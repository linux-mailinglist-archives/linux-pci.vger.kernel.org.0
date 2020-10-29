Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9625729E640
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 09:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgJ2IUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 04:20:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37205 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726392AbgJ2IUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 04:20:37 -0400
X-UUID: 002690c0a75444e7a1a8e4e8a1957422-20201029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=o3Qv9OfYUwrK9tVE0LcM9g+mhJJ29QPAQxRIwyUon6o=;
        b=toC2fsuuN27LunQYhD4azaeoj1sETWqhOJAtJg6AnEebdikM9i7hcB3Gkro4MYqnUlFUVC45mnLV5/BjWsVxGR/XHVgtRueF5kjmZQcPZui5ddzi2ePAan1v+8uHXWUxqWZwUvkoXVCl6Gl8GA9Hj5+Nx0cmN+jHjLJHmLym4KI=;
X-UUID: 002690c0a75444e7a1a8e4e8a1957422-20201029
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 972438657; Thu, 29 Oct 2020 16:15:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Oct 2020 16:15:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Oct 2020 16:15:19 +0800
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
Subject: [PATCH v7 0/4] PCI: mediatek: Spilt PCIe node to comply with hardware design
Date:   Thu, 29 Oct 2020 16:15:09 +0800
Message-ID: <20201029081513.10562-1-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SW4gY3VycmVudCBhcmNoaXRlY3R1cmUsIE1TSSBkb21haW4gd2lsbCBiZSBpbmhlcml0ZWQgZnJv
bSB0aGUgcm9vdA0KYnJpZGdlLCBhbmQgYWxsIG9mIHRoZSBkZXZpY2VzIHdpbGwgc2hhcmUgdGhl
IHNhbWUgTVNJIGRvbWFpbi4NCkhlbmNlIHRoYXQsIHRoZSBQQ0llIGRldmljZXMgd2lsbCBub3Qg
d29yayBwcm9wZXJseSBpZiB0aGUgaXJxIG51bWJlcg0Kd2hpY2ggcmVxdWlyZWQgaXMgbW9yZSB0
aGFuIDMyLg0KU3BsaXQgdGhlIFBDSWUgbm9kZSBmb3IgTVQyNzEyIGFuZCBNVDc2MjIgcGxhdGZv
cm0gdG8gZml4IE1TSSBpc3N1ZQ0KYW5kIGNvbXBseSB3aXRoIHRoZSBoYXJkd2FyZSBkZXNpZ24u
DQoNCmNoYW5nZSBub3RlOg0KICB2NzpkdC1iaW5kaW5ncyBmaWxlIHdhcyBtb2RpZmllZCBhcyBz
dWdnZXN0ZWQgYnkgUm9iLCBvdGhlciBmaWxlIG5vDQogICAgIGNoYW5nZS4NCiAgdjY6Rml4IHlh
bWwgZXJyb3IuIG1ha2Ugc3VyZSBkcml2ZXIgY29tcGF0aWJsZSB3aXRoIG9sZCBhbmQgDQogICAg
IG5ldyBEVFMgZm9ybWF0Lg0KICB2NTpyZWJhc2UgZm9yIDUuOS1yYzEsIG5vIGNvZGUgY2hhbmdl
LiANCiAgdjQ6Y2hhbmdlIGNvbW1pdCBtZXNzYWdlIGR1ZSB0byBiYXllcyBzdGF0aXN0aWNhbCBi
b2dvZmlsdGVyDQogICAgIGNvbnNpZGVycyB0aGlzIHNlcmllcyBwYXRjaCBTUEFNLg0KICB2Mzpy
ZWJhc2UgZm9yIDUuOC1yYzEuIE9ubHkgY29sbGVjdCBhY2sgb2YgUnlkZXIsIE5vIGNvZGUgY2hh
bmdlLg0KICB2MjpjaGFuZ2UgdGhlIGFsbG9jYXRpb24gb2YgTVQyNzEyIFBDSWUgTU1JTyBzcGFj
ZSBkdWUgdG8gdGhlDQogICAgIGFsbG9jYXRpb24gc2l6ZSBpcyBub3QgcmlnaHQgaW4gdjEuDQoN
CkNodWFuamlhIExpdSAoNCk6DQogIGR0LWJpbmRpbmdzOiBwY2k6IG1lZGlhdGVrOiBNb2RpZmll
ZCB0aGUgRGV2aWNlIHRyZWUgYmluZGluZ3MNCiAgUENJOiBtZWRpYXRlazogQWRkIG5ldyBtZXRo
b2QgdG8gZ2V0IHNoYXJlZCBwY2llLWNmZyBiYXNlIGFuZCBpcnENCiAgYXJtNjQ6IGR0czogbWVk
aWF0ZWs6IFNwbGl0IFBDSWUgbm9kZSBmb3IgTVQyNzEyIGFuZCBNVDc2MjINCiAgQVJNOiBkdHM6
IG1lZGlhdGVrOiBNb2RpZmllZCBNVDc2MjkgUENJZSBub2RlDQoNCiAgLi4uL2JpbmRpbmdzL3Bj
aS9tZWRpYXRlay1wY2llLWNmZy55YW1sICAgICAgIHwgIDM5ICsrKysrDQogIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLnR4dCB8IDEyOSArKysrKysrKysrKy0tLS0t
LS0NCiAgYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LXJmYi5kdHMgICAgICAgICAgICAgIHwgICAz
ICstDQogIGFyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS5kdHNpICAgICAgICAgICAgICAgICB8ICAy
MiArLS0NCiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDI3MTJlLmR0c2kgICAgIHwg
IDc1ICsrKysrKy0tLS0NCiAgLi4uL2R0cy9tZWRpYXRlay9tdDc2MjItYmFuYW5hcGktYnBpLXI2
NC5kdHMgIHwgIDE2ICstDQogIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLXJm
YjEuZHRzICB8ICAgNiArLQ0KICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYyMi5k
dHNpICAgICAgfCAgNjYgKysrKysrLS0tDQogIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1t
ZWRpYXRlay5jICAgICAgICB8ICAyMyArKy0NCiAgOSBmaWxlcyBjaGFuZ2VkLCAyNDggaW5zZXJ0
aW9ucygrKSwgMTMxIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtY2ZnLnlhbWwNCg0KIC0t
IA0KIDIuMTguMA0K

