function Complex(re, im) {
    this.re = re || 0;
    this.im = im || 0;
}

function ComplexCalculator(a, b) {
    BaseCalculator.call(this);
    var self = this;

    //�����
    this.add = function (a, b) {
        return new Complex(self.plus(a.re, b.re), self.plus(a.im, b.im));
    }
    //���������
    this.sub = function (a, b) {
        return new Complex(self.minus(a.re, b.re), self.minus(a.im, b.im));
    }
    //������������
    this.mult = function (a, b) {
        return new Complex(self.minus(self.star(a.re, b.re), self.star(a.im, b.im)),
            self.plus(self.star(a.re, b.im), self.star(a.im, b.re)));
    }
    //�������
    this.div = function (a, b) {
        return new Complex(self.slash(self.plus(self.star(a.re, b.re), self.star(a.im, b.im)), (self.plus(self.star(b.im, b.im), self.star(b.re, b.re)))),
            self.slash(self.minus(self.star(a.im, b.re), self.star(a.re, b.im)), self.plus(self.star(b.im, b.im), self.star(b.re, b.re))));
    }
    //������
    this.modul = function (a) {
        return Math.sqrt(self.plus(self.star(a.re, a.re), self.star(a.im, a.im)));
    }
    //����
    this.zero = function () {
        return new Complex();
    }
    //�������
    this.one = function () {
        return new Complex(1, 0);
    }
}