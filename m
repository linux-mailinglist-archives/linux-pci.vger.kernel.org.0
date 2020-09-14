Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A929268A14
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 13:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgINLbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 07:31:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17677 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726104AbgINLaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 07:30:19 -0400
X-UUID: 7a2321b8c52e492eb72535f12010e486-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jRHkZTdg8apssmBzz5oFqjyf+DQFKqK4eJkHYPOIPPE=;
        b=bVDY6JyBMx3D0LqQj3gOz930lEnoDDnEuqLifRxd9i5b9JzlldI6UeqAkDTO9brK3ZRIhFgB5A51LcpuJ2qRfJU4rP85gMgu3OfZGzQBU1DQvD/shA3wqghsj/0QFx4Q3Zd/PUSGznYD6DgUsuGqfH4q6Cc8JH1nYcSSgG1ZG9U=;
X-UUID: 7a2321b8c52e492eb72535f12010e486-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2048203631; Mon, 14 Sep 2020 19:30:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 19:30:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 19:30:11 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>
Subject: [PATCH v6 4/4] ARM: dts: mediatek: Modified MT7629 PCIe node
Date:   Mon, 14 Sep 2020 19:26:59 +0800
Message-ID: <20200914112659.7091-5-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
References: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 537793BD68D696A12E2F5552D08C888BD0B645B6D00FCBFFDE9F0E7FC92BE5402000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
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

