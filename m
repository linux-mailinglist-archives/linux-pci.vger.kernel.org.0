Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147F229E642
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 09:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgJ2IUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 04:20:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37215 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727666AbgJ2IUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 04:20:39 -0400
X-UUID: 6ff530164b16492784825281621ba9b4-20201029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SFReDfEAHp+Cr6KMTkQNKGnYxoXDY1B3fpzVPKpq7PM=;
        b=cLv9GjJ3HFNyzGz4+W3TYOzb+Lfn9bnTiVqQPlwMWN4N9CWKA2mmocs6U39cGrNvrOsEV0IUPdlQjf0pfIc7BjxQDUfFZ3UgTFlIBJtBY2vQcpRvR9DlQpzm4kAtq/s8iC5oGBlj4xh0sDHB4B9WcD2jKvwZqveaHTDCcRBhQsM=;
X-UUID: 6ff530164b16492784825281621ba9b4-20201029
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 443957077; Thu, 29 Oct 2020 16:15:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Oct 2020 16:15:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Oct 2020 16:15:26 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>, <chuanjia.liu@mediatek.com>
Subject: [PATCH v7 1/4] dt-bindings: pci: mediatek: Modified the Device tree bindings
Date:   Thu, 29 Oct 2020 16:15:10 +0800
Message-ID: <20201029081513.10562-2-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201029081513.10562-1-chuanjia.liu@mediatek.com>
References: <20201029081513.10562-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U3BsaXQgdGhlIFBDSWUgbm9kZSBhbmQgYWRkIHBjaWVjZmcgbm9kZSB0byBmaXggTVNJIGlzc3Vl
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxpdUBtZWRpYXRlay5j
b20+DQpBY2tlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQog
Li4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNmZy55YW1sICAgICAgIHwgIDM5ICsrKysr
Kw0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLnR4dCB8IDEyOSAr
KysrKysrKysrKy0tLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDExOCBpbnNlcnRpb25zKCspLCA1
MCBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNmZy55YW1sDQoNCmRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtY2ZnLnlh
bWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUt
Y2ZnLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmQzZWNi
Y2QwMzJhMg0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNmZy55YW1sDQpAQCAtMCwwICsxLDM5IEBADQorIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZQ0KKyVZ
QU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcGNpL21l
ZGlhdGVrLXBjaWUtY2ZnLnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21l
dGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1lZGlhdGVrIFBDSUVDRkcgY29udHJv
bGxlcg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxpdUBt
ZWRpYXRlay5jb20+DQorICAtIEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNv
bT4NCisNCitkZXNjcmlwdGlvbjogfA0KKyAgVGhlIE1lZGlhVGVrIFBDSUVDRkcgY29udHJvbGxl
ciBjb250cm9scyBzb21lIGZlYXR1cmUgYWJvdXQNCisgIExUU1NNLCBBU1BNIGFuZCBzbyBvbi4N
CisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgICBpdGVtczoNCisgICAgICAg
IC0gZW51bToNCisgICAgICAgICAgICAtIG1lZGlhdGVrLGdlbmVyaWMtcGNpZWNmZw0KKyAgICAg
ICAgLSBjb25zdDogc3lzY29uDQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAxDQorDQorcmVx
dWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQorDQorYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQorDQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgcGNpZWNmZzogcGNpZWNmZ0Ax
YTE0MDAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLGdlbmVyaWMtcGNpZWNm
ZyIsICJzeXNjb24iOw0KKyAgICAgICAgcmVnID0gPDB4MWExNDAwMDAgMHgxMDAwPjsNCisgICAg
fTsNCisuLi4NCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL21lZGlhdGVrLXBjaWUudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9tZWRpYXRlay1wY2llLnR4dA0KaW5kZXggNzQ2OGQ2NjY3NjNhLi5jMTRhMjc0NWRlMzcg
MTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlh
dGVrLXBjaWUudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L21lZGlhdGVrLXBjaWUudHh0DQpAQCAtOCw3ICs4LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
CiAJIm1lZGlhdGVrLG10NzYyMy1wY2llIg0KIAkibWVkaWF0ZWssbXQ3NjI5LXBjaWUiDQogLSBk
ZXZpY2VfdHlwZTogTXVzdCBiZSAicGNpIg0KLS0gcmVnOiBCYXNlIGFkZHJlc3NlcyBhbmQgbGVu
Z3RocyBvZiB0aGUgUENJZSBzdWJzeXMgYW5kIHJvb3QgcG9ydHMuDQorLSByZWc6IEJhc2UgYWRk
cmVzc2VzIGFuZCBsZW5ndGhzIG9mIHRoZSByb290IHBvcnRzLg0KIC0gcmVnLW5hbWVzOiBOYW1l
cyBvZiB0aGUgYWJvdmUgYXJlYXMgdG8gdXNlIGR1cmluZyByZXNvdXJjZSBsb29rdXAuDQogLSAj
YWRkcmVzcy1jZWxsczogQWRkcmVzcyByZXByZXNlbnRhdGlvbiBmb3Igcm9vdCBwb3J0cyAobXVz
dCBiZSAzKQ0KIC0gI3NpemUtY2VsbHM6IFNpemUgcmVwcmVzZW50YXRpb24gZm9yIHJvb3QgcG9y
dHMgKG11c3QgYmUgMikNCkBAIC0xNDMsNTYgKzE0Myw3MSBAQCBFeGFtcGxlcyBmb3IgTVQ3NjIz
Og0KIA0KIEV4YW1wbGVzIGZvciBNVDI3MTI6DQogDQotCXBjaWU6IHBjaWVAMTE3MDAwMDAgew0K
KwlwY2llMTogcGNpZUAxMTJmZjAwMCB7DQogCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Mjcx
Mi1wY2llIjsNCiAJCWRldmljZV90eXBlID0gInBjaSI7DQotCQlyZWcgPSA8MCAweDExNzAwMDAw
IDAgMHgxMDAwPiwNCi0JCSAgICAgIDwwIDB4MTEyZmYwMDAgMCAweDEwMDA+Ow0KLQkJcmVnLW5h
bWVzID0gInBvcnQwIiwgInBvcnQxIjsNCisJCXJlZyA9IDwwIDB4MTEyZmYwMDAgMCAweDEwMDA+
Ow0KKwkJcmVnLW5hbWVzID0gInBvcnQxIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KIAkJ
I3NpemUtY2VsbHMgPSA8Mj47DQotCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTE1IElSUV9UWVBF
X0xFVkVMX0hJR0g+LA0KLQkJCSAgICAgPEdJQ19TUEkgMTE3IElSUV9UWVBFX0xFVkVMX0hJR0g+
Ow0KLQkJY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX1BFMl9NQUNfUDBfU0VMPiwNCi0JCQkg
PCZ0b3Bja2dlbiBDTEtfVE9QX1BFMl9NQUNfUDFfU0VMPiwNCi0JCQkgPCZwZXJpY2ZnIENMS19Q
RVJJX1BDSUUwPiwNCisJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMTcgSVJRX1RZUEVfTEVWRUxf
SElHSD47DQorCQlpbnRlcnJ1cHQtbmFtZXMgPSAicGNpZV9pcnEiOw0KKwkJY2xvY2tzID0gPCZ0
b3Bja2dlbiBDTEtfVE9QX1BFMl9NQUNfUDFfU0VMPiwNCiAJCQkgPCZwZXJpY2ZnIENMS19QRVJJ
X1BDSUUxPjsNCi0JCWNsb2NrLW5hbWVzID0gInN5c19jazAiLCAic3lzX2NrMSIsICJhaGJfY2sw
IiwgImFoYl9jazEiOw0KLQkJcGh5cyA9IDwmcGNpZTBfcGh5IFBIWV9UWVBFX1BDSUU+LCA8JnBj
aWUxX3BoeSBQSFlfVFlQRV9QQ0lFPjsNCi0JCXBoeS1uYW1lcyA9ICJwY2llLXBoeTAiLCAicGNp
ZS1waHkxIjsNCisJCWNsb2NrLW5hbWVzID0gInN5c19jazEiLCAiYWhiX2NrMSI7DQorCQlwaHlz
ID0gPCZ1M3BvcnQxIFBIWV9UWVBFX1BDSUU+Ow0KKwkJcGh5LW5hbWVzID0gInBjaWUtcGh5MSI7
DQogCQlidXMtcmFuZ2UgPSA8MHgwMCAweGZmPjsNCi0JCXJhbmdlcyA9IDwweDgyMDAwMDAwIDAg
MHgyMDAwMDAwMCAgMHgwIDB4MjAwMDAwMDAgIDAgMHgxMDAwMDAwMD47DQorCQlyYW5nZXMgPSA8
MHg4MjAwMDAwMCAwIDB4MTE0MDAwMDAgIDB4MCAweDExNDAwMDAwICAwIDB4MzAwMDAwPjsNCiAN
Ci0JCXBjaWUwOiBwY2llQDAsMCB7DQotCQkJcmVnID0gPDB4MDAwMCAwIDAgMCAwPjsNCisJCXNs
b3QxOiBwY2llQDEsMCB7DQorCQkJcmVnID0gPDB4MDgwMCAwIDAgMCAwPjsNCiAJCQkjYWRkcmVz
cy1jZWxscyA9IDwzPjsNCiAJCQkjc2l6ZS1jZWxscyA9IDwyPjsNCiAJCQkjaW50ZXJydXB0LWNl
bGxzID0gPDE+Ow0KIAkJCXJhbmdlczsNCiAJCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAg
Nz47DQotCQkJaW50ZXJydXB0LW1hcCA9IDwwIDAgMCAxICZwY2llX2ludGMwIDA+LA0KLQkJCQkJ
PDAgMCAwIDIgJnBjaWVfaW50YzAgMT4sDQotCQkJCQk8MCAwIDAgMyAmcGNpZV9pbnRjMCAyPiwN
Ci0JCQkJCTwwIDAgMCA0ICZwY2llX2ludGMwIDM+Ow0KLQkJCXBjaWVfaW50YzA6IGludGVycnVw
dC1jb250cm9sbGVyIHsNCisJCQlpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJnBjaWVfaW50YzEg
MD4sDQorCQkJCQk8MCAwIDAgMiAmcGNpZV9pbnRjMSAxPiwNCisJCQkJCTwwIDAgMCAzICZwY2ll
X2ludGMxIDI+LA0KKwkJCQkJPDAgMCAwIDQgJnBjaWVfaW50YzEgMz47DQorCQkJcGNpZV9pbnRj
MTogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KIAkJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCiAJ
CQkJI2FkZHJlc3MtY2VsbHMgPSA8MD47DQogCQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQog
CQkJfTsNCiAJCX07DQorCX07DQogDQotCQlwY2llMTogcGNpZUAxLDAgew0KLQkJCXJlZyA9IDww
eDA4MDAgMCAwIDAgMD47DQorCXBjaWUwOiBwY2llQDExNzAwMDAwIHsNCisJCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQyNzEyLXBjaWUiOw0KKwkJZGV2aWNlX3R5cGUgPSAicGNpIjsNCisJCXJl
ZyA9IDwwIDB4MTE3MDAwMDAgMCAweDEwMDA+Ow0KKwkJcmVnLW5hbWVzID0gInBvcnQwIjsNCisJ
CSNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KKwkJI3NpemUtY2VsbHMgPSA8Mj47DQorCQlpbnRlcnJ1
cHRzID0gPEdJQ19TUEkgMTE1IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJaW50ZXJydXB0LW5h
bWVzID0gInBjaWVfaXJxIjsNCisJCWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9QRTJfTUFD
X1AwX1NFTD4sDQorCQkJIDwmcGVyaWNmZyBDTEtfUEVSSV9QQ0lFMD47DQorCQljbG9jay1uYW1l
cyA9ICJzeXNfY2swIiwgImFoYl9jazAiOw0KKwkJcGh5cyA9IDwmdTNwb3J0MCBQSFlfVFlQRV9Q
Q0lFPjsNCisJCXBoeS1uYW1lcyA9ICJwY2llLXBoeTAiOw0KKwkJYnVzLXJhbmdlID0gPDB4MDAg
MHhmZj47DQorCQlyYW5nZXMgPSA8MHg4MjAwMDAwMCAwIDB4MjAwMDAwMDAgMHgwIDB4MjAwMDAw
MDAgMCAweDEwMDAwMDAwPjsNCisNCisJCXNsb3QwOiBwY2llQDAsMCB7DQorCQkJcmVnID0gPDB4
MDAwMCAwIDAgMCAwPjsNCiAJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCiAJCQkjc2l6ZS1jZWxs
cyA9IDwyPjsNCiAJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KIAkJCXJhbmdlczsNCiAJCQlp
bnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAgNz47DQotCQkJaW50ZXJydXB0LW1hcCA9IDwwIDAg
MCAxICZwY2llX2ludGMxIDA+LA0KLQkJCQkJPDAgMCAwIDIgJnBjaWVfaW50YzEgMT4sDQotCQkJ
CQk8MCAwIDAgMyAmcGNpZV9pbnRjMSAyPiwNCi0JCQkJCTwwIDAgMCA0ICZwY2llX2ludGMxIDM+
Ow0KLQkJCXBjaWVfaW50YzE6IGludGVycnVwdC1jb250cm9sbGVyIHsNCisJCQlpbnRlcnJ1cHQt
bWFwID0gPDAgMCAwIDEgJnBjaWVfaW50YzAgMD4sDQorCQkJCQk8MCAwIDAgMiAmcGNpZV9pbnRj
MCAxPiwNCisJCQkJCTwwIDAgMCAzICZwY2llX2ludGMwIDI+LA0KKwkJCQkJPDAgMCAwIDQgJnBj
aWVfaW50YzAgMz47DQorCQkJcGNpZV9pbnRjMDogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KIAkJ
CQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MD47DQogCQkJ
CSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQpAQCAtMjAyLDM5ICsyMTcsMjkgQEAgRXhhbXBsZXMg
Zm9yIE1UMjcxMjoNCiANCiBFeGFtcGxlcyBmb3IgTVQ3NjIyOg0KIA0KLQlwY2llOiBwY2llQDFh
MTQwMDAwIHsNCisJcGNpZTA6IHBjaWVAMWExNDMwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDc2MjItcGNpZSI7DQogCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KLQkJcmVnID0gPDAg
MHgxYTE0MDAwMCAwIDB4MTAwMD4sDQotCQkgICAgICA8MCAweDFhMTQzMDAwIDAgMHgxMDAwPiwN
Ci0JCSAgICAgIDwwIDB4MWExNDUwMDAgMCAweDEwMDA+Ow0KLQkJcmVnLW5hbWVzID0gInN1YnN5
cyIsICJwb3J0MCIsICJwb3J0MSI7DQorCQlyZWcgPSA8MCAweDFhMTQzMDAwIDAgMHgxMDAwPjsN
CisJCXJlZy1uYW1lcyA9ICJwb3J0MCI7DQogCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCiAJCSNz
aXplLWNlbGxzID0gPDI+Ow0KLQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyOCBJUlFfVFlQRV9M
RVZFTF9MT1c+LA0KLQkJCSAgICAgPEdJQ19TUEkgMjI5IElSUV9UWVBFX0xFVkVMX0xPVz47DQor
CQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjI4IElSUV9UWVBFX0xFVkVMX0xPVz47DQorCQlpbnRl
cnJ1cHQtbmFtZXMgPSAicGNpZV9pcnEiOw0KIAkJY2xvY2tzID0gPCZwY2llc3lzIENMS19QQ0lF
X1AwX01BQ19FTj4sDQotCQkJIDwmcGNpZXN5cyBDTEtfUENJRV9QMV9NQUNfRU4+LA0KIAkJCSA8
JnBjaWVzeXMgQ0xLX1BDSUVfUDBfQUhCX0VOPiwNCi0JCQkgPCZwY2llc3lzIENMS19QQ0lFX1Ax
X0FIQl9FTj4sDQogCQkJIDwmcGNpZXN5cyBDTEtfUENJRV9QMF9BVVhfRU4+LA0KLQkJCSA8JnBj
aWVzeXMgQ0xLX1BDSUVfUDFfQVVYX0VOPiwNCiAJCQkgPCZwY2llc3lzIENMS19QQ0lFX1AwX0FY
SV9FTj4sDQotCQkJIDwmcGNpZXN5cyBDTEtfUENJRV9QMV9BWElfRU4+LA0KIAkJCSA8JnBjaWVz
eXMgQ0xLX1BDSUVfUDBfT0JGRl9FTj4sDQotCQkJIDwmcGNpZXN5cyBDTEtfUENJRV9QMV9PQkZG
X0VOPiwNCi0JCQkgPCZwY2llc3lzIENMS19QQ0lFX1AwX1BJUEVfRU4+LA0KLQkJCSA8JnBjaWVz
eXMgQ0xLX1BDSUVfUDFfUElQRV9FTj47DQotCQljbG9jay1uYW1lcyA9ICJzeXNfY2swIiwgInN5
c19jazEiLCAiYWhiX2NrMCIsICJhaGJfY2sxIiwNCi0JCQkgICAgICAiYXV4X2NrMCIsICJhdXhf
Y2sxIiwgImF4aV9jazAiLCAiYXhpX2NrMSIsDQotCQkJICAgICAgIm9iZmZfY2swIiwgIm9iZmZf
Y2sxIiwgInBpcGVfY2swIiwgInBpcGVfY2sxIjsNCi0JCXBoeXMgPSA8JnBjaWUwX3BoeSBQSFlf
VFlQRV9QQ0lFPiwgPCZwY2llMV9waHkgUEhZX1RZUEVfUENJRT47DQotCQlwaHktbmFtZXMgPSAi
cGNpZS1waHkwIiwgInBjaWUtcGh5MSI7DQorCQkJIDwmcGNpZXN5cyBDTEtfUENJRV9QMF9QSVBF
X0VOPjsNCisJCWNsb2NrLW5hbWVzID0gInN5c19jazAiLCAiYWhiX2NrMCIsICJhdXhfY2swIiwN
CisJCQkgICAgICAiYXhpX2NrMCIsICJvYmZmX2NrMCIsICJwaXBlX2NrMCI7DQorDQogCQlwb3dl
ci1kb21haW5zID0gPCZzY3BzeXMgTVQ3NjIyX1BPV0VSX0RPTUFJTl9ISUYwPjsNCiAJCWJ1cy1y
YW5nZSA9IDwweDAwIDB4ZmY+Ow0KLQkJcmFuZ2VzID0gPDB4ODIwMDAwMDAgMCAweDIwMDAwMDAw
ICAweDAgMHgyMDAwMDAwMCAgMCAweDEwMDAwMDAwPjsNCisJCXJhbmdlcyA9IDwweDgyMDAwMDAw
IDAgMHgyMDAwMDAwMCAgMHgwIDB4MjAwMDAwMDAgIDAgMHg4MDAwMDAwPjsNCiANCi0JCXBjaWUw
OiBwY2llQDAsMCB7DQorCQlzbG90MDogcGNpZUAwLDAgew0KIAkJCXJlZyA9IDwweDAwMDAgMCAw
IDAgMD47DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQogCQkJI3NpemUtY2VsbHMgPSA8Mj47
DQpAQCAtMjUxLDggKzI1NiwzMiBAQCBFeGFtcGxlcyBmb3IgTVQ3NjIyOg0KIAkJCQkjaW50ZXJy
dXB0LWNlbGxzID0gPDE+Ow0KIAkJCX07DQogCQl9Ow0KKwl9Ow0KKw0KKwlwY2llMTogcGNpZUAx
YTE0NTAwMCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMi1wY2llIjsNCisJCWRl
dmljZV90eXBlID0gInBjaSI7DQorCQlyZWcgPSA8MCAweDFhMTQ1MDAwIDAgMHgxMDAwPjsNCisJ
CXJlZy1uYW1lcyA9ICJwb3J0MSI7DQorCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCisJCSNzaXpl
LWNlbGxzID0gPDI+Ow0KKwkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyOSBJUlFfVFlQRV9MRVZF
TF9MT1c+Ow0KKwkJaW50ZXJydXB0LW5hbWVzID0gInBjaWVfaXJxIjsNCisJCWNsb2NrcyA9IDwm
cGNpZXN5cyBDTEtfUENJRV9QMV9NQUNfRU4+LA0KKwkJCSAvKiBkZXNpZ25lciBoYXMgY29ubmVj
dCBSQzEgd2l0aCBwMF9haGIgY2xvY2sgKi8NCisJCQkgPCZwY2llc3lzIENMS19QQ0lFX1AwX0FI
Ql9FTj4sDQorCQkJIDwmcGNpZXN5cyBDTEtfUENJRV9QMV9BVVhfRU4+LA0KKwkJCSA8JnBjaWVz
eXMgQ0xLX1BDSUVfUDFfQVhJX0VOPiwNCisJCQkgPCZwY2llc3lzIENMS19QQ0lFX1AxX09CRkZf
RU4+LA0KKwkJCSA8JnBjaWVzeXMgQ0xLX1BDSUVfUDFfUElQRV9FTj47DQorCQljbG9jay1uYW1l
cyA9ICJzeXNfY2sxIiwgImFoYl9jazEiLCAiYXV4X2NrMSIsDQorCQkJICAgICAgImF4aV9jazEi
LCAib2JmZl9jazEiLCAicGlwZV9jazEiOw0KKw0KKwkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lz
IE1UNzYyMl9QT1dFUl9ET01BSU5fSElGMD47DQorCQlidXMtcmFuZ2UgPSA8MHgwMCAweGZmPjsN
CisJCXJhbmdlcyA9IDwweDgyMDAwMDAwIDAgMHgyODAwMDAwMCAgMHgwIDB4MjgwMDAwMDAgIDAg
MHg4MDAwMDAwPjsNCiANCi0JCXBjaWUxOiBwY2llQDEsMCB7DQorCQlzbG90MTogcGNpZUAxLDAg
ew0KIAkJCXJlZyA9IDwweDA4MDAgMCAwIDAgMD47DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47
DQogCQkJI3NpemUtY2VsbHMgPSA8Mj47DQotLSANCjIuMTguMA0K

