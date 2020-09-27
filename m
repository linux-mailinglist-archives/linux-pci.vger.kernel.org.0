Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA387279F54
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgI0Hsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 03:48:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57794 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726382AbgI0Hsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 03:48:35 -0400
X-UUID: 41f7c2f5dcb64a769089f932eb3d2dcc-20200927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=d9lyIqtPvPXiR0F6KUQePPMfpcjXX/jEbkNNHhsMUyo=;
        b=o4qFlUBL8p6PM/BoSI4Fh75nQ9SKQjn9e07CFDjyzLqE+i40/+JT5ZppBXM9OcnX9nEwgZ0e+/U8ZW+ygxl6GtjXfj80Lz7wXaEDrN9YLZsDFU9+QZltD2MWM6U/CTIL1bE0jud3Iwp5W6ixq2Gf+ZCUjxRLYxZgzetCcMWxQu4=;
X-UUID: 41f7c2f5dcb64a769089f932eb3d2dcc-20200927
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 219952987; Sun, 27 Sep 2020 15:48:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Sep 2020 15:48:26 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Sep 2020 15:48:25 +0800
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
Subject: [v3,0/3] PCI: mediatek: Add new generation controller support
Date:   Sun, 27 Sep 2020 15:45:52 +0800
Message-ID: <20200927074555.4155-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FEC9D6A66C7B483EF0EF7CCF5000DE10A76B54A9207FFC0B54437214FC778F142000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhlc2Ugc2VyaWVzIHBhdGNoZXMgYWRkIHBjaWUtbWVkaWF0ZWstZ2VuMy5jIGFuZCBkdC1iaW5k
aW5ncyBmaWxlIHRvDQpzdXBwb3J0IG5ldyBnZW5lcmF0aW9uIFBDSWUgY29udHJvbGxlci4NCg0K
Q2hhbmdlcyBpbiB2MzoNCjEuIFJlbW92ZSBzdGFuZGFyZCBwcm9wZXJ0eSBpbiBiaW5kaW5nIGRv
Y3VtZW50DQoyLiBSZXR1cm4gZXJyb3IgbnVtYmVyIHdoZW4gZ2V0X29wdGlvbmFsKiBBUEkgdGhy
b3dzIGFuIGVycm9yDQozLiBVc2UgdGhlIGJ1bGsgY2xrIEFQSXMNCg0KQ2hhbmdlcyBpbiB2MjoN
CjEuIEZpeCB0aGUgdHlwbyBvZiBkdC1iaW5kaW5ncyBwYXRjaA0KMi4gUmVtb3ZlIHRoZSB1bm5l
Y2Vzc2FyeSBwcm9wZXJ0aWVzIGluIGJpbmRpbmcgZG9jdW1lbnQNCjMuIGRpc3BvcyB0aGUgaXJx
IG1hcHBpbmdzIG9mIG1zaSB0b3AgZG9tYWluIHdoZW4gaXJxIHRlYXJkb3duDQoNCkppYW5qdW4g
V2FuZyAoMyk6DQogIGR0LWJpbmRpbmdzOiBQQ0k6IG1lZGlhdGVrOiBBZGQgWUFNTCBzY2hlbWEN
CiAgUENJOiBtZWRpYXRlazogQWRkIG5ldyBnZW5lcmF0aW9uIGNvbnRyb2xsZXIgc3VwcG9ydA0K
ICBNQUlOVEFJTkVSUzogdXBkYXRlIGVudHJ5IGZvciBNZWRpYVRlayBQQ0llIGNvbnRyb2xsZXIN
Cg0KIC4uLi9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwgICAgICB8ICAxMjYg
KysNCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAx
ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL0tjb25maWcgICAgICAgICAgICAgICAgfCAgIDE0
ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAgICAgICAgICAgfCAgICAx
ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jICAgfCAxMDI0
ICsrKysrKysrKysrKysrKysrDQogNSBmaWxlcyBjaGFuZ2VkLCAxMTY2IGluc2VydGlvbnMoKykN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQoNCi0tIA0KMi4yNS4xDQo=

