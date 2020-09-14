Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACD3268A12
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 13:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgINLbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 07:31:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10087 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726102AbgINLaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 07:30:01 -0400
X-UUID: 7931e12f8b484086ac09751e8545ef09-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PEhItO3FI00zCynCyOZJCO9f+PedrDX9uq/sSJ/84Ro=;
        b=onUVFc4NthU2+EZ2n+lZcbeZ+kx2rmR6KPF7NZiLOAdHGoRutQU5+BTEWVDBsbwmz4/ddLJpIuTv4Hbdksma2yUtEOysAKhG9MlAk+7rKhtR5mvP03aUPYgh2qUeXmlBd62eG8GwHnFvF/cAJYkKjdP05Ywm/w/2WDVGdYvXy2E=;
X-UUID: 7931e12f8b484086ac09751e8545ef09-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1698551436; Mon, 14 Sep 2020 19:29:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 19:29:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 19:29:23 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v6 0/4] Spilt PCIe node to comply with hardware design
Date:   Mon, 14 Sep 2020 19:26:55 +0800
Message-ID: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8543CC27B5C0BF586E95D1EAE5D1FED90A5EEA9E793042D1C11942EA46B8D07E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U3BsaXQgdGhlIFBDSWUgbm9kZSBmb3IgTVQyNzEyIGFuZCBNVDc2MjIgcGxhdGZvcm0gdG8gZml4
IE1TSSBpc3N1ZQ0KYW5kIGNvbXBseSB3aXRoIHRoZSBoYXJkd2FyZSBkZXNpZ24uDQoNCmNoYW5n
ZSBub3RlOg0KICB2NjpGaXggeWFtbCBlcnJvci4gTWFrZSBzdXJlIGRyaXZlciBjb21wYXRpYmxl
IHdpdGggb2xkIGFuZCANCiAgICAgbmV3IERUUyBmb3JtYXQuDQogIHY1OnJlYmFzZSBmb3IgNS45
LXJjMSwgbm8gY29kZSBjaGFuZ2UuIA0KICB2NDpjaGFuZ2UgY29tbWl0IG1lc3NhZ2UgZHVlIHRv
IGJheWVzIHN0YXRpc3RpY2FsIGJvZ29maWx0ZXINCiAgICAgY29uc2lkZXJzIHRoaXMgc2VyaWVz
IHBhdGNoIFNQQU0uDQogIHYzOnJlYmFzZSBmb3IgNS44LXJjMS4gT25seSBjb2xsZWN0IGFjayBv
ZiBSeWRlciwgTm8gY29kZSBjaGFuZ2UuDQogIHYyOmNoYW5nZSB0aGUgYWxsb2NhdGlvbiBvZiBN
VDI3MTIgUENJZSBNTUlPIHNwYWNlIGR1ZSB0byB0aGUNCiAgICAgYWxsb2NhdGlvbiBzaXplIGlz
IG5vdCByaWdodCBpbiB2MS4NCg0KQ2h1YW5qaWEgTGl1ICg0KToNCiBkdC1iaW5kaW5nczogcGNp
OiBtZWRpYXRlazogTW9kaWZpZWQgdGhlIERldmljZSB0cmVlIGJpbmRpbmdzDQogUENJOiBtZWRp
YXRlazogQWRkIG5ldyBtZXRob2QgdG8gZ2V0IHNoYXJlZCBwY2llLWNmZyBiYXNlIGFuZCBpcnEN
CiBhcm02NDogZHRzOiBtZWRpYXRlazogU3BsaXQgUENJZSBub2RlIGZvciBNVDI3MTIgYW5kIE1U
NzYyMg0KIEFSTTogZHRzOiBtZWRpYXRlazogTW9kaWZpZWQgTVQ3NjI5IFBDSWUgbm9kZQ0KDQog
Li4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNmZy55YW1sICAgICAgIHwgIDM3ICsrKysr
DQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUudHh0IHwgMTM5ICsr
KysrKysrKysrLS0tLS0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS1yZmIuZHRzICAgICAg
ICAgICAgICB8ICAgMyArLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS5kdHNpICAgICAgICAg
ICAgICAgICB8ICAyMiArLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUu
ZHRzaSAgICAgfCAgNzUgKysrKysrLS0tLQ0KIC4uLi9kdHMvbWVkaWF0ZWsvbXQ3NjIyLWJhbmFu
YXBpLWJwaS1yNjQuZHRzICB8ICAxNiArLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ3NjIyLXJmYjEuZHRzICB8ICAgNiArLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ3NjIyLmR0c2kgICAgICB8ICA2NiArKysrKystLS0NCiBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtbWVkaWF0ZWsuYyAgICAgICAgfCAgMjMgKystDQogOSBmaWxlcyBjaGFuZ2VkLCAyNTMg
aW5zZXJ0aW9ucygrKSwgMTM0IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTguMA0KDQo=

