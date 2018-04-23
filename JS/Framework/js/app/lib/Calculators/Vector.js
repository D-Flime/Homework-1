function Vector(x, y, z) {
    var arr = [];
    arr[0] = x || 0;
    arr[1] = y || 0;
    arr[2] = z || 0;
    this.arr = arr;
}

function VectorCalculator(a, b) {
    BaseCalculator.call(this);
    var self = this;

    //�����
    this.add = function (a, b) {
        var result = new Vector();
        for (var i = 0; i < 3; i++) {
            var calc = self.getCalculator(a.arr[i]);
            result.arr[i] = calc.add(a.arr[i], b.arr[i]);
        }
        return result;
    }
    //���������
    this.sub = function (a, b) {
        var result = new Vector();
        for (var i = 0; i < 3; i++) {
            var calc = self.getCalculator(a.arr[i]);
            result.arr[i] = calc.sub(a.arr[i], b.arr[i]);
        }
        return result;
    }
    //��������� ������������
    this.mult = function (a, b) {
        var result = new Vector();
        for (var i = 0; i < 3; i++) {
            var calc = self.getCalculator(a.arr[i]);
            result.arr[i] = calc.sub(calc.mult(a.arr[(i + 1) % 3], b.arr[(i + 2) % 3]), calc.mult(a.arr[(i + 2) % 3], b.arr[(i + 1) % 3]));
        }
        return result;
    }
    //��������� ������������
    this.scalMult = function (a, b) {
        var result = 0;
        for (var i = 0; i < 3; i++) {
            var calc = self.getCalculator(a.arr[i]);
            result += calc.mult(a.arr[i], b.arr[i]);
        }
        return result;
    }
    //������
    this.modul = function (a) {
        return Math.sqrt(this.scalMult(a, a));
    }
    //����
    this.zero = function () {
        return new Vector();
    }
    //�������
    this.one = function () {
        return new Vector(1, 1, 1);
    }
}