Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3BB263B96
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 05:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgIJDsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 23:48:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62687 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727055AbgIJDsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 23:48:00 -0400
X-UUID: 572e29baa32942629a175d139f47e780-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2hoCkcyHFcvHSe+6eY3PpXdLBY223EQZtp+kbXz1uFU=;
        b=bJp5/jTWIWQcqwO+LgJ60UcgpFq4uNdAR9Ne5MgYswrG0lzMzeBL1mtwMZGSBujpEPUiUpZMcq5NOuz9y/aAv+JQMdz44ZJozy3U3sGVddYUe1AxtC6czIcLIRcPmxYsypvrZuOgKTvKlrtOESo24TF8sYFmuGJqLDytTHD0808=;
X-UUID: 572e29baa32942629a175d139f47e780-20200910
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 91102384; Thu, 10 Sep 2020 11:47:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 11:47:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 11:47:52 +0800
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
        Jianjun Wang <jianjun.wang@mediatek.com>
Subject: [v2,1/3] dt-bindings: PCI: mediatek: Add YAML schema
Date:   Thu, 10 Sep 2020 11:45:34 +0800
Message-ID: <20200910034536.30860-2-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200910034536.30860-1-jianjun.wang@mediatek.com>
References: <20200910034536.30860-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIFlBTUwgc2NoZW1hcyBkb2N1bWVudGF0aW9uIGZvciBHZW4zIFBDSWUgY29udHJvbGxlciBv
bg0KTWVkaWFUZWsgU29Dcy4NCg0KU2lnbmVkLW9mZi1ieTogSmlhbmp1biBXYW5nIDxqaWFuanVu
LndhbmdAbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwg
ICAgICB8IDEzMCArKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTMwIGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4z
LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmEyZGZjMGQx
NWQyZQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KQEAgLTAsMCArMSwxMzAgQEANCisjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwg
MS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9wY2kvbWVkaWF0
ZWstcGNpZS1nZW4zLnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEt
c2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IEdlbjMgUENJZSBjb250cm9sbGVyIG9uIE1l
ZGlhVGVrIFNvQ3MNCisNCittYWludGFpbmVyczoNCisgIC0gSmlhbmp1biBXYW5nIDxqaWFuanVu
LndhbmdAbWVkaWF0ZWsuY29tPg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiAvc2NoZW1hcy9wY2kv
cGNpLWJ1cy55YW1sIw0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBvbmVP
ZjoNCisgICAgICAtIGNvbnN0OiBtZWRpYXRlayxnZW4zLXBjaWUNCisgICAgICAtIGNvbnN0OiBt
ZWRpYXRlayxtdDgxOTItcGNpZQ0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAg
aW50ZXJydXB0czoNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGJ1cy1yYW5nZToNCisgICAgZGVz
Y3JpcHRpb246IFJhbmdlIG9mIGJ1cyBudW1iZXJzIGFzc29jaWF0ZWQgd2l0aCB0aGlzIGNvbnRy
b2xsZXIuDQorDQorICByYW5nZXM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0ZW1zOiA4
DQorDQorICByZXNldHM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0ZW1zOiAyDQorDQor
ICByZXNldC1uYW1lczoNCisgICAgYW55T2Y6DQorICAgICAgLSBjb25zdDogbWFjLXJzdA0KKyAg
ICAgIC0gY29uc3Q6IHBoeS1yc3QNCisNCisgIGNsb2NrczoNCisgICAgbWF4SXRlbXM6IDUNCisN
CisgIGFzc2lnbmVkLWNsb2NrczoNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGFzc2lnbmVkLWNs
b2NrLXBhcmVudHM6DQorICAgIG1heEl0ZW1zOiAxDQorDQorICBwaHlzOg0KKyAgICBtYXhJdGVt
czogMQ0KKw0KKyAgJyNpbnRlcnJ1cHQtY2VsbHMnOg0KKyAgICBjb25zdDogMQ0KKw0KKyAgaW50
ZXJydXB0LWNvbnRyb2xsZXI6DQorICAgIGRlc2NyaXB0aW9uOiBJbnRlcnJ1cHQgY29udHJvbGxl
ciBub2RlIGZvciBoYW5kbGluZyBsZWdhY3kgUENJIGludGVycnVwdHMuDQorICAgIHR5cGU6IG9i
amVjdA0KKyAgICBwcm9wZXJ0aWVzOg0KKyAgICAgICcjYWRkcmVzcy1jZWxscyc6DQorICAgICAg
ICBjb25zdDogMA0KKyAgICAgICcjaW50ZXJydXB0LWNlbGxzJzoNCisgICAgICAgIGNvbnN0OiAx
DQorICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI6IHRydWUNCisNCisgICAgcmVxdWlyZWQ6DQor
ICAgICAgLSAnI2FkZHJlc3MtY2VsbHMnDQorICAgICAgLSAnI2ludGVycnVwdC1jZWxscycNCisg
ICAgICAtIGludGVycnVwdC1jb250cm9sbGVyDQorDQorICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQ0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBp
bnRlcnJ1cHRzDQorICAtIHJhbmdlcw0KKyAgLSBjbG9ja3MNCisgIC0gJyNpbnRlcnJ1cHQtY2Vs
bHMnDQorICAtIGludGVycnVwdC1jb250cm9sbGVyDQorDQordW5ldmFsdWF0ZWRQcm9wZXJ0aWVz
OiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCisNCisgICAgYnVzIHsNCisgICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQorDQor
ICAgICAgICBwY2llOiBwY2llQDExMjMwMDAwIHsNCisgICAgICAgICAgICBjb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5Mi1wY2llIjsNCisgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJwY2ki
Ow0KKyAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KKyAgICAgICAgICAgICNzaXpl
LWNlbGxzID0gPDI+Ow0KKyAgICAgICAgICAgIHJlZyA9IDwweDAwIDB4MTEyMzAwMDAgMHgwMCAw
eDQwMDA+Ow0KKyAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJwY2llLW1hYyI7DQorICAgICAgICAg
ICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDI1MSBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KKyAg
ICAgICAgICAgIGJ1cy1yYW5nZSA9IDwweDAwIDB4ZmY+Ow0KKyAgICAgICAgICAgIHJhbmdlcyA9
IDwweDgyMDAwMDAwIDB4MDAgMHgxMjAwMDAwMCAweDAwIDB4MTIwMDAwMDAgMHgwMCAweDEwMDAw
MDA+Ow0KKyAgICAgICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmcgNDA+LA0KKyAgICAgICAgICAg
ICAgICAgICAgIDwmaW5mcmFjZmcgNDM+LA0KKyAgICAgICAgICAgICAgICAgICAgIDwmaW5mcmFj
ZmcgOTc+LA0KKyAgICAgICAgICAgICAgICAgICAgIDwmaW5mcmFjZmcgOTk+LA0KKyAgICAgICAg
ICAgICAgICAgICAgIDwmaW5mcmFjZmcgMTExPjsNCisgICAgICAgICAgICBhc3NpZ25lZC1jbG9j
a3MgPSA8JnRvcGNrZ2VuIDUwPjsNCisgICAgICAgICAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRz
ID0gPCZ0b3Bja2dlbiA5MT47DQorDQorICAgICAgICAgICAgcGh5cyA9IDwmcGNpZXBoeT47DQor
ICAgICAgICAgICAgcGh5LW5hbWVzID0gInBjaWUtcGh5IjsNCisgICAgICAgICAgICByZXNldHMg
PSA8JmluZnJhY2ZnX3JzdCAwPjsNCisgICAgICAgICAgICByZXNldC1uYW1lcyA9ICJwaHktcnN0
IjsNCisNCisgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KKyAgICAgICAgICAg
IGludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCAweDc+Ow0KKyAgICAgICAgICAgIGludGVycnVw
dC1tYXAgPSA8MCAwIDAgMSAmcGNpZV9pbnRjIDA+LA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA8MCAwIDAgMiAmcGNpZV9pbnRjIDE+LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA8MCAwIDAgMyAmcGNpZV9pbnRjIDI+LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
MCAwIDAgNCAmcGNpZV9pbnRjIDM+Ow0KKyAgICAgICAgICAgIHBjaWVfaW50YzogaW50ZXJydXB0
LWNvbnRyb2xsZXIgew0KKyAgICAgICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDww
PjsNCisgICAgICAgICAgICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsNCisgICAg
ICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQorICAgICAgICAgICAgfTsN
CisgICAgICAgIH07DQorICAgIH07DQotLSANCjIuMjUuMQ0K

