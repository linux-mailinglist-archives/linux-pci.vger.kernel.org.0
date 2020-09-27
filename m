Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83317279F5A
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 09:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgI0Hsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 03:48:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57809 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726382AbgI0Hsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 03:48:40 -0400
X-UUID: 7654f65750624dec820f151604faf743-20200927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=psXz+brn7C+t4owfhvfEvuvTHp/hL3WQtlakmjYKIX4=;
        b=C+cZ4AZxGLLnRrt341bbuvZWdumbd2Ru/XUg/hxy62t3gEjBqJTZFvd6Ek2tEaUQpit8QINes4Vxu2jEcARRV4N7xUQ1ZkEzCKoFOl4S95krmuuDbWLwJfWlIrA05EAHBWbH1PcehwEanyo7trCC10rXOR/0p2YpyXozFjxoFJg=;
X-UUID: 7654f65750624dec820f151604faf743-20200927
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 95630127; Sun, 27 Sep 2020 15:48:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Sep 2020 15:48:26 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Sep 2020 15:48:26 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>
Subject: [v3,1/3] dt-bindings: PCI: mediatek: Add YAML schema
Date:   Sun, 27 Sep 2020 15:45:53 +0800
Message-ID: <20200927074555.4155-2-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200927074555.4155-1-jianjun.wang@mediatek.com>
References: <20200927074555.4155-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIFlBTUwgc2NoZW1hcyBkb2N1bWVudGF0aW9uIGZvciBHZW4zIFBDSWUgY29udHJvbGxlciBv
bg0KTWVkaWFUZWsgU29Dcy4NCg0KU2lnbmVkLW9mZi1ieTogSmlhbmp1biBXYW5nIDxqaWFuanVu
LndhbmdAbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwg
ICAgICB8IDEyNiArKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTI2IGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4z
LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmM3YjVkZDEz
MmViZA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KQEAgLTAsMCArMSwxMjYgQEANCisjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwg
MS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9wY2kvbWVkaWF0
ZWstcGNpZS1nZW4zLnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEt
c2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IEdlbjMgUENJZSBjb250cm9sbGVyIG9uIE1l
ZGlhVGVrIFNvQ3MNCisNCittYWludGFpbmVyczoNCisgIC0gSmlhbmp1biBXYW5nIDxqaWFuanVu
LndhbmdAbWVkaWF0ZWsuY29tPg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiAvc2NoZW1hcy9wY2kv
cGNpLWJ1cy55YW1sIw0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBvbmVP
ZjoNCisgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxOTItcGNpZQ0KKw0KKyAgcmVnOg0KKyAg
ICBtYXhJdGVtczogMQ0KKw0KKyAgaW50ZXJydXB0czoNCisgICAgbWF4SXRlbXM6IDENCisNCisg
IHJhbmdlczoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4SXRlbXM6IDgNCisNCisgIHJlc2V0
czoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4SXRlbXM6IDINCisNCisgIHJlc2V0LW5hbWVz
Og0KKyAgICBhbnlPZjoNCisgICAgICAtIGNvbnN0OiBtYWMtcnN0DQorICAgICAgLSBjb25zdDog
cGh5LXJzdA0KKw0KKyAgY2xvY2tzOg0KKyAgICBtYXhJdGVtczogNQ0KKw0KKyAgYXNzaWduZWQt
Y2xvY2tzOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgYXNzaWduZWQtY2xvY2stcGFyZW50czoN
CisgICAgbWF4SXRlbXM6IDENCisNCisgIHBoeXM6DQorICAgIG1heEl0ZW1zOiAxDQorDQorICAn
I2ludGVycnVwdC1jZWxscyc6DQorICAgIGNvbnN0OiAxDQorDQorICBpbnRlcnJ1cHQtY29udHJv
bGxlcjoNCisgICAgZGVzY3JpcHRpb246IEludGVycnVwdCBjb250cm9sbGVyIG5vZGUgZm9yIGhh
bmRsaW5nIGxlZ2FjeSBQQ0kgaW50ZXJydXB0cy4NCisgICAgdHlwZTogb2JqZWN0DQorICAgIHBy
b3BlcnRpZXM6DQorICAgICAgJyNhZGRyZXNzLWNlbGxzJzoNCisgICAgICAgIGNvbnN0OiAwDQor
ICAgICAgJyNpbnRlcnJ1cHQtY2VsbHMnOg0KKyAgICAgICAgY29uc3Q6IDENCisgICAgICBpbnRl
cnJ1cHQtY29udHJvbGxlcjogdHJ1ZQ0KKw0KKyAgICByZXF1aXJlZDoNCisgICAgICAtICcjYWRk
cmVzcy1jZWxscycNCisgICAgICAtICcjaW50ZXJydXB0LWNlbGxzJw0KKyAgICAgIC0gaW50ZXJy
dXB0LWNvbnRyb2xsZXINCisNCisgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQorDQor
cmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQorICAtIGludGVycnVwdHMNCisg
IC0gcmFuZ2VzDQorICAtIGNsb2Nrcw0KKyAgLSAnI2ludGVycnVwdC1jZWxscycNCisgIC0gaW50
ZXJydXB0LWNvbnRyb2xsZXINCisNCit1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQorDQor
ZXhhbXBsZXM6DQorICAtIHwNCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1j
b250cm9sbGVyL2FybS1naWMuaD4NCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVw
dC1jb250cm9sbGVyL2lycS5oPg0KKw0KKyAgICBidXMgew0KKyAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8Mj47DQorICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCisNCisgICAgICAgIHBjaWU6
IHBjaWVAMTEyMzAwMDAgew0KKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTkyLXBjaWUiOw0KKyAgICAgICAgICAgIGRldmljZV90eXBlID0gInBjaSI7DQorICAgICAgICAg
ICAgI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQorICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47
DQorICAgICAgICAgICAgcmVnID0gPDB4MDAgMHgxMTIzMDAwMCAweDAwIDB4NDAwMD47DQorICAg
ICAgICAgICAgcmVnLW5hbWVzID0gInBjaWUtbWFjIjsNCisgICAgICAgICAgICBpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgMjUxIElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQorICAgICAgICAgICAgYnVz
LXJhbmdlID0gPDB4MDAgMHhmZj47DQorICAgICAgICAgICAgcmFuZ2VzID0gPDB4ODIwMDAwMDAg
MHgwMCAweDEyMDAwMDAwIDB4MDAgMHgxMjAwMDAwMCAweDAwIDB4MTAwMDAwMD47DQorICAgICAg
ICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZyA0MD4sDQorICAgICAgICAgICAgICAgICAgICAgPCZp
bmZyYWNmZyA0Mz4sDQorICAgICAgICAgICAgICAgICAgICAgPCZpbmZyYWNmZyA5Nz4sDQorICAg
ICAgICAgICAgICAgICAgICAgPCZpbmZyYWNmZyA5OT4sDQorICAgICAgICAgICAgICAgICAgICAg
PCZpbmZyYWNmZyAxMTE+Ow0KKyAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmdG9wY2tn
ZW4gNTA+Ow0KKyAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnRvcGNrZ2Vu
IDkxPjsNCisNCisgICAgICAgICAgICBwaHlzID0gPCZwY2llcGh5PjsNCisgICAgICAgICAgICBw
aHktbmFtZXMgPSAicGNpZS1waHkiOw0KKyAgICAgICAgICAgIHJlc2V0cyA9IDwmaW5mcmFjZmdf
cnN0IDA+Ow0KKyAgICAgICAgICAgIHJlc2V0LW5hbWVzID0gInBoeS1yc3QiOw0KKw0KKyAgICAg
ICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQorICAgICAgICAgICAgaW50ZXJydXB0LW1h
cC1tYXNrID0gPDAgMCAwIDB4Nz47DQorICAgICAgICAgICAgaW50ZXJydXB0LW1hcCA9IDwwIDAg
MCAxICZwY2llX2ludGMgMD4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCAy
ICZwY2llX2ludGMgMT4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCAzICZw
Y2llX2ludGMgMj4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCA0ICZwY2ll
X2ludGMgMz47DQorICAgICAgICAgICAgcGNpZV9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7
DQorICAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDA+Ow0KKyAgICAgICAg
ICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KKyAgICAgICAgICAgICAgICAg
ICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCisgICAgICAgICAgICB9Ow0KKyAgICAgICAgfTsN
CisgICAgfTsNCi0tIA0KMi4yNS4xDQo=

