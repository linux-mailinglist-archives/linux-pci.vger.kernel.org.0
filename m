Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5B5263D0F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 08:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIJGOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 02:14:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23963 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726647AbgIJGOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 02:14:32 -0400
X-UUID: 92366f52c11c49ec8411eb9da262c7df-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xloUjBE6OF+ENLRHth9hL5fNUGfyOv8h8Vtqb+yulXk=;
        b=nTfkAeXkYYvzFy0uVMmVgpJ6yeJqDAgad8mtu/eppQ4AH3uDiSnxGTifiskLsMbBrPTaCzkdSpsVk6Z4vEEjrKYzTACl/RdrkBPpYmWDdoXWQCeeNeH4YvTwg6H0XWyOQ//5HGKlFr+SVrDld5u4PQoSOObfiq9nPSBF7gWvGH8=;
X-UUID: 92366f52c11c49ec8411eb9da262c7df-20200910
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 552507246; Thu, 10 Sep 2020 14:14:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 14:14:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 14:14:24 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>
Subject: [PATCH v5 4/4] ARM: dts: mediatek: Modified MT7629 PCIe node
Date:   Thu, 10 Sep 2020 14:11:15 +0800
Message-ID: <20200910061115.909-5-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200910061115.909-1-chuanjia.liu@mediatek.com>
References: <20200910061115.909-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 06F033A27D6FEFF1385F1BA824970B003F89F257B2FE2FFDC1AA77B79BE1042B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UmVtb3ZlIHVudXNlZCBwcm9wZXJ0eSBhbmQgYWRkIHBjaWVjZmcgbm9kZS4NCg0KQWNrZWQtYnk6
IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IENodWFu
amlhIExpdSA8Y2h1YW5qaWEubGl1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL210NzYyOS1yZmIuZHRzIHwgIDMgKystDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0
c2kgICAgfCAyMyArKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTUg
aW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9tdDc2MjktcmZiLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS1yZmIuZHRz
DQppbmRleCA5OTgwYzEwYzZlMjkuLmViNTM2Y2JlYmQ5YiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL210NzYyOS1yZmIuZHRzDQorKysgYi9hcmNoL2FybS9ib290L2R0cy9tdDc2Mjkt
cmZiLmR0cw0KQEAgLTE0MCw5ICsxNDAsMTAgQEANCiAJfTsNCiB9Ow0KIA0KLSZwY2llIHsNCism
cGNpZTEgew0KIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KIAlwaW5jdHJsLTAgPSA8JnBj
aWVfcGlucz47DQorCXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KIA0KICZwY2llcGh5MSB7DQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kgYi9hcmNoL2FybS9ib290L2R0
cy9tdDc2MjkuZHRzaQ0KaW5kZXggNWNiYjNkMjQ0Yzc1Li45NDU2NzMwN2I4NDIgMTAwNjQ0DQot
LS0gYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvbXQ3NjI5LmR0c2kNCkBAIC0zNjAsMTYgKzM2MCwyMSBAQA0KIAkJCSNyZXNldC1jZWxscyA9
IDwxPjsNCiAJCX07DQogDQotCQlwY2llOiBwY2llQDFhMTQwMDAwIHsNCisJCXBjaWVjZmc6IHBj
aWVjZmdAMWExNDAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjI5LXBjaWVj
ZmciLCAic3lzY29uIjsNCisJCQlyZWcgPSA8MHgxYTE0MDAwMCAweDEwMDA+Ow0KKwkJfTsNCisN
CisJCXBjaWUxOiBwY2llQDFhMTQ1MDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
NzYyOS1wY2llIjsNCiAJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KLQkJCXJlZyA9IDwweDFhMTQw
MDAwIDB4MTAwMD4sDQotCQkJICAgICAgPDB4MWExNDUwMDAgMHgxMDAwPjsNCi0JCQlyZWctbmFt
ZXMgPSAic3Vic3lzIiwicG9ydDEiOw0KKwkJCXJlZyA9IDwweDFhMTQ1MDAwIDB4MTAwMD47DQor
CQkJcmVnLW5hbWVzID0gInBvcnQxIjsNCisJCQltZWRpYXRlayxwY2llLWNmZyA9IDwmcGNpZWNm
Zz47DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQogCQkJI3NpemUtY2VsbHMgPSA8Mj47DQot
CQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE3NiBJUlFfVFlQRV9MRVZFTF9MT1c+LA0KLQkJCQkg
ICAgIDxHSUNfU1BJIDIyOSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSAyMjkgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQlpbnRlcnJ1cHQtbmFtZXMgPSAi
cGNpZV9pcnEiOw0KIAkJCWNsb2NrcyA9IDwmcGNpZXN5cyBDTEtfUENJRV9QMV9NQUNfRU4+LA0K
IAkJCQkgPCZwY2llc3lzIENMS19QQ0lFX1AwX0FIQl9FTj4sDQogCQkJCSA8JnBjaWVzeXMgQ0xL
X1BDSUVfUDFfQVVYX0VOPiwNCkBAIC0zOTAsMjEgKzM5NSwxOSBAQA0KIAkJCXBvd2VyLWRvbWFp
bnMgPSA8JnNjcHN5cyBNVDc2MjJfUE9XRVJfRE9NQUlOX0hJRjA+Ow0KIAkJCWJ1cy1yYW5nZSA9
IDwweDAwIDB4ZmY+Ow0KIAkJCXJhbmdlcyA9IDwweDgyMDAwMDAwIDAgMHgyMDAwMDAwMCAweDIw
MDAwMDAwIDAgMHgxMDAwMDAwMD47DQorCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiANCi0JCQlw
Y2llMTogcGNpZUAxLDAgew0KLQkJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KKwkJCXNsb3QxOiBw
Y2llQDEsMCB7DQogCQkJCXJlZyA9IDwweDA4MDAgMCAwIDAgMD47DQogCQkJCSNhZGRyZXNzLWNl
bGxzID0gPDM+Ow0KIAkJCQkjc2l6ZS1jZWxscyA9IDwyPjsNCiAJCQkJI2ludGVycnVwdC1jZWxs
cyA9IDwxPjsNCiAJCQkJcmFuZ2VzOw0KLQkJCQludW0tbGFuZXMgPSA8MT47DQogCQkJCWludGVy
cnVwdC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCiAJCQkJaW50ZXJydXB0LW1hcCA9IDwwIDAgMCAx
ICZwY2llX2ludGMxIDA+LA0KIAkJCQkJCTwwIDAgMCAyICZwY2llX2ludGMxIDE+LA0KIAkJCQkJ
CTwwIDAgMCAzICZwY2llX2ludGMxIDI+LA0KIAkJCQkJCTwwIDAgMCA0ICZwY2llX2ludGMxIDM+
Ow0KLQ0KIAkJCQlwY2llX2ludGMxOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQogCQkJCQlpbnRl
cnJ1cHQtY29udHJvbGxlcjsNCiAJCQkJCSNhZGRyZXNzLWNlbGxzID0gPDA+Ow0KLS0gDQoyLjE4
LjANCg==

