Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015329E620
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 09:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgJ2IPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 04:15:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53579 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728513AbgJ2IPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 04:15:50 -0400
X-UUID: c559ab8950ab4ae0a56d513c5d28fb74-20201029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jRHkZTdg8apssmBzz5oFqjyf+DQFKqK4eJkHYPOIPPE=;
        b=VFOykh2+IZrXDbWlGtr0/1F9ECMLxyx+8D72UwndgKVOXuW8sCubaOOC+5WDMtMEY/8SUpDgD/Jl1/H6vWQYCiBmGc3rRWtIcFXn862b5Sr0j+EMqFBzbEiE6i8jxuJjPXjRk0nN87keEjAmMyU0bV9q+W2X4N7USfkhKI3AR9c=;
X-UUID: c559ab8950ab4ae0a56d513c5d28fb74-20201029
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 165975230; Thu, 29 Oct 2020 16:15:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Oct 2020 16:15:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Oct 2020 16:15:43 +0800
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
Subject: [PATCH v7 4/4] ARM: dts: mediatek: Modified MT7629 PCIe node
Date:   Thu, 29 Oct 2020 16:15:13 +0800
Message-ID: <20201029081513.10562-5-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201029081513.10562-1-chuanjia.liu@mediatek.com>
References: <20201029081513.10562-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 885291DBBB7B536A8EA9EC48C496567E09C22C21B6BAB1A250B99CE39C0A0D7C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UmVtb3ZlIHVudXNlZCBwcm9wZXJ0eSBhbmQgYWRkIHBjaWVjZmcgbm9kZS4NCg0KU2lnbmVkLW9m
Zi1ieTogQ2h1YW5qaWEgTGl1IDxjaHVhbmppYS5saXVAbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6
IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL210NzYyOS1yZmIuZHRzIHwgIDMgKystDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0
c2kgICAgfCAyMiArKysrKysrKysrKystLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL210NzYyOS1yZmIuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LXJmYi5kdHMN
CmluZGV4IDk5ODBjMTBjNmUyOS4uZWI1MzZjYmViZDliIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjI5LXJmYi5kdHMNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS1y
ZmIuZHRzDQpAQCAtMTQwLDkgKzE0MCwxMCBAQA0KIAl9Ow0KIH07DQogDQotJnBjaWUgew0KKyZw
Y2llMSB7DQogCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogCXBpbmN0cmwtMCA9IDwmcGNp
ZV9waW5zPjsNCisJc3RhdHVzID0gIm9rYXkiOw0KIH07DQogDQogJnBjaWVwaHkxIHsNCmRpZmYg
LS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRz
L210NzYyOS5kdHNpDQppbmRleCA1Y2JiM2QyNDRjNzUuLjZkNjM5N2YwYzJmYyAxMDA2NDQNCi0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS5kdHNpDQorKysgYi9hcmNoL2FybS9ib290L2R0
cy9tdDc2MjkuZHRzaQ0KQEAgLTM2MCwxNiArMzYwLDIwIEBADQogCQkJI3Jlc2V0LWNlbGxzID0g
PDE+Ow0KIAkJfTsNCiANCi0JCXBjaWU6IHBjaWVAMWExNDAwMDAgew0KKwkJcGNpZWNmZzogcGNp
ZWNmZ0AxYTE0MDAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXBjaWVj
ZmciLCAic3lzY29uIjsNCisJCQlyZWcgPSA8MHgxYTE0MDAwMCAweDEwMDA+Ow0KKwkJfTsNCisN
CisJCXBjaWUxOiBwY2llQDFhMTQ1MDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
NzYyOS1wY2llIjsNCiAJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KLQkJCXJlZyA9IDwweDFhMTQw
MDAwIDB4MTAwMD4sDQotCQkJICAgICAgPDB4MWExNDUwMDAgMHgxMDAwPjsNCi0JCQlyZWctbmFt
ZXMgPSAic3Vic3lzIiwicG9ydDEiOw0KKwkJCXJlZyA9IDwweDFhMTQ1MDAwIDB4MTAwMD47DQor
CQkJcmVnLW5hbWVzID0gInBvcnQxIjsNCiAJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCiAJCQkj
c2l6ZS1jZWxscyA9IDwyPjsNCi0JCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTc2IElSUV9UWVBF
X0xFVkVMX0xPVz4sDQotCQkJCSAgICAgPEdJQ19TUEkgMjI5IElSUV9UWVBFX0xFVkVMX0xPVz47
DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyOSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJ
CWludGVycnVwdC1uYW1lcyA9ICJwY2llX2lycSI7DQogCQkJY2xvY2tzID0gPCZwY2llc3lzIENM
S19QQ0lFX1AxX01BQ19FTj4sDQogCQkJCSA8JnBjaWVzeXMgQ0xLX1BDSUVfUDBfQUhCX0VOPiwN
CiAJCQkJIDwmcGNpZXN5cyBDTEtfUENJRV9QMV9BVVhfRU4+LA0KQEAgLTM5MCwyMSArMzk0LDE5
IEBADQogCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UNzYyMl9QT1dFUl9ET01BSU5fSElG
MD47DQogCQkJYnVzLXJhbmdlID0gPDB4MDAgMHhmZj47DQogCQkJcmFuZ2VzID0gPDB4ODIwMDAw
MDAgMCAweDIwMDAwMDAwIDB4MjAwMDAwMDAgMCAweDEwMDAwMDAwPjsNCisJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KIA0KLQkJCXBjaWUxOiBwY2llQDEsMCB7DQotCQkJCWRldmljZV90eXBlID0g
InBjaSI7DQorCQkJc2xvdDE6IHBjaWVAMSwwIHsNCiAJCQkJcmVnID0gPDB4MDgwMCAwIDAgMCAw
PjsNCiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQogCQkJCSNzaXplLWNlbGxzID0gPDI+Ow0K
IAkJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KIAkJCQlyYW5nZXM7DQotCQkJCW51bS1sYW5l
cyA9IDwxPjsNCiAJCQkJaW50ZXJydXB0LW1hcC1tYXNrID0gPDAgMCAwIDc+Ow0KIAkJCQlpbnRl
cnJ1cHQtbWFwID0gPDAgMCAwIDEgJnBjaWVfaW50YzEgMD4sDQogCQkJCQkJPDAgMCAwIDIgJnBj
aWVfaW50YzEgMT4sDQogCQkJCQkJPDAgMCAwIDMgJnBjaWVfaW50YzEgMj4sDQogCQkJCQkJPDAg
MCAwIDQgJnBjaWVfaW50YzEgMz47DQotDQogCQkJCXBjaWVfaW50YzE6IGludGVycnVwdC1jb250
cm9sbGVyIHsNCiAJCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KIAkJCQkJI2FkZHJlc3MtY2Vs
bHMgPSA8MD47DQotLSANCjIuMTguMA0K

