Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE8E263D02
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 08:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgIJGNh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 02:13:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39774 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725885AbgIJGNf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 02:13:35 -0400
X-UUID: 0ce9efa0dd4b47d0872e5ee2db51bb94-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zFcW3GcXd1P8FnAbyGNj9CaD7meMZ2kjh/WC5Wilqqw=;
        b=feV0DEPi/Pu4f5Psg3pKMetQDcIc1AJgj9rs0e0nhdp+ZEDcYxEbCiTo8dusziEx/zknMwyJGFgkVQU781y6jElQ3WTOxBoXlt93wkA53ZT5yjf0+fgX+8LPuSRZyup+O8AjVcjqiq1im3dXX/bhc/lKZIGckWH54Y3oabuQJQY=;
X-UUID: 0ce9efa0dd4b47d0872e5ee2db51bb94-20200910
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 19333964; Thu, 10 Sep 2020 14:13:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 14:13:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 14:13:28 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v5 0/4] Spilt PCIe node to comply with hardware design
Date:   Thu, 10 Sep 2020 14:11:11 +0800
Message-ID: <20200910061115.909-1-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SW4gY3VycmVudCBhcmNoaXRlY3R1cmUsIE1TSSBkb21haW4gd2lsbCBiZSBpbmhlcml0ZWQgZnJv
bSB0aGUgcm9vdA0KYnJpZGdlLCBhbmQgYWxsIG9mIHRoZSBkZXZpY2VzIHdpbGwgc2hhcmUgdGhl
IHNhbWUgTVNJIGRvbWFpbi4NCkhlbmNlIHRoYXQsIHRoZSBQQ0llIGRldmljZXMgd2lsbCBub3Qg
d29yayBwcm9wZXJseSBpZiB0aGUgaXJxIG51bWJlcg0Kd2hpY2ggcmVxdWlyZWQgaXMgbW9yZSB0
aGFuIDMyLg0KDQpTcGxpdCB0aGUgUENJZSBub2RlIGZvciBNVDI3MTIgYW5kIE1UNzYyMiBwbGF0
Zm9ybSB0byBmaXggTVNJIGlzc3VlDQphbmQgY29tcGx5IHdpdGggdGhlIGhhcmR3YXJlIGRlc2ln
bi4NCg0KY2hhbmdlIG5vdGU6DQogIHY1OnJlYmFzZSBmb3IgNS45LXJjMSwgbm8gY29kZSBjaGFu
Z2UuIA0KICB2NDpjaGFuZ2UgY29tbWl0IG1lc3NhZ2UgZHVlIHRvIGJheWVzIHN0YXRpc3RpY2Fs
IGJvZ29maWx0ZXINCiAgICAgY29uc2lkZXJzIHRoaXMgc2VyaWVzIHBhdGNoIFNQQU0uDQogIHYz
OnJlYmFzZSBmb3IgNS44LXJjMS4gT25seSBjb2xsZWN0IGFjayBvZiBSeWRlciwgTm8gY29kZSBj
aGFuZ2UuDQogIHYyOmNoYW5nZSB0aGUgYWxsb2NhdGlvbiBvZiBNVDI3MTIgUENJZSBNTUlPIHNw
YWNlIGR1ZSB0byB0aGUNCiAgICAgYWxsb2NhdGlvbiBzaXplIGlzIG5vdCByaWdodCBpbiB2MS4N
Cg0KQ2h1YW5qaWEgTGl1ICg0KToNCiBkdC1iaW5kaW5nczogcGNpOiBtZWRpYXRlazogTW9kaWZp
ZWQgdGhlIERldmljZSB0cmVlIGJpbmRpbmdzDQogUENJOiBtZWRpYXRlazogVXNlIHJlZ21hcCB0
byBnZXQgc2hhcmVkIHBjaWUtY2ZnIGJhc2UNCiBhcm02NDogZHRzOiBtZWRpYXRlazogU3BsaXQg
UENJZSBub2RlIGZvciBNVDI3MTIgYW5kIE1UNzYyMg0KIEFSTTogZHRzOiBtZWRpYXRlazogTW9k
aWZpZWQgTVQ3NjI5IFBDSWUgbm9kZQ0KDQogLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2ll
LWNmZy55YW1sICAgICAgIHwgIDM4ICsrKysrDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L21lZGlhdGVrLXBjaWUudHh0IHwgMTQ0ICsrKysrKysrKysrLS0tLS0tLQ0KIGFyY2gvYXJtL2Jv
b3QvZHRzL210NzYyOS1yZmIuZHRzICAgICAgICAgICAgICB8ICAgMyArLQ0KIGFyY2gvYXJtL2Jv
b3QvZHRzL210NzYyOS5kdHNpICAgICAgICAgICAgICAgICB8ICAyMyArLS0NCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUuZHRzaSAgICAgfCAgNzUgKysrKystLS0tDQogLi4u
L2R0cy9tZWRpYXRlay9tdDc2MjItYmFuYW5hcGktYnBpLXI2NC5kdHMgIHwgIDE2ICstDQogYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjItcmZiMS5kdHMgIHwgICA2ICstDQogYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaSAgICAgIHwgIDY4ICsrKysrKy0t
LQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jICAgICAgICB8ICAyNSAr
Ky0NCiA5IGZpbGVzIGNoYW5nZWQsIDI1OCBpbnNlcnRpb25zKCspLCAxNDAgZGVsZXRpb25zKC0p
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvbWVkaWF0ZWstcGNpZS1jZmcueWFtbA0KDQotLSANCjIuMTguMA0KDQo=

