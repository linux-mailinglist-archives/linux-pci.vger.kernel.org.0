Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969E3260381
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgIGRuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 13:50:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48951 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729235AbgIGMKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 08:10:52 -0400
X-UUID: a2e268fb05e348028d30b6335d481ecd-20200907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mWs1TicmUihewvCBjVKC06mEcTl47586ruiLpRjWtf0=;
        b=hGj+mUvBalskvKSo2aDFF6vMpETfhHsIqHQJKehDbZu9UTTvOzpigKiCwf3R8VA81xvV0hT9ACxY3/7Rep4N69Cf9Qx88grS36ZuAf+zaloaQuKOrf05U26M73j5mDXNOUwbsE+qELEIIHqhQtskXPhZa2Ps3ldT+rtUKvdtJdg=;
X-UUID: a2e268fb05e348028d30b6335d481ecd-20200907
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 972947843; Mon, 07 Sep 2020 20:10:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Sep 2020 20:10:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 20:10:45 +0800
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
Subject: [v1,0/3] PCI: mediatek: Add new generation controller support
Date:   Mon, 7 Sep 2020 20:08:49 +0800
Message-ID: <20200907120852.12090-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhlc2Ugc2VyaWVzIHBhdGNoZXMgYWRkIHBjaWUtbWVkaWF0ZWstZ2VuMy5jIGFuZCBkdC1iaW5k
aW5ncyBmaWxlIHRvDQpzdXBwb3J0IG5ldyBnZW5lcmF0aW9uIFBDSWUgY29udHJvbGxlci4NCg0K
Smlhbmp1biBXYW5nICgzKToNCiAgZHQtYmluZGluZ3M6IEFkZCBZQU1MIHNjaGVtYXMgZm9yIEdl
bjMgUENJZSBjb250cm9sbGVyDQogIFBDSTogbWVkaWF0ZWs6IEFkZCBuZXcgZ2VuZXJhdGlvbiBj
b250cm9sbGVyIHN1cHBvcnQNCiAgTUFJTlRBSU5FUlM6IHVwZGF0ZSBlbnRyeSBmb3IgTWVkaWFU
ZWsgUENJZSBjb250cm9sbGVyDQoNCiAuLi4vYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2Vu
My55YW1sICAgICAgfCAgMTU4ICsrKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAg
ICAgICAgICAgICAgICB8ICAgMTQgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUg
ICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRp
YXRlay1nZW4zLmMgICB8IDEwNjMgKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQs
IDEyMzcgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCg0K
LS0gDQoyLjI1LjENCg==

