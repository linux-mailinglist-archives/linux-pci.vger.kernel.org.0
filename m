Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E23263B94
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 05:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIJDrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 23:47:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52089 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727055AbgIJDrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 23:47:45 -0400
X-UUID: e386fe9b4cd04378bb9bcd192e68287d-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=i74HM4n2z7CpO2GU1v53gI/FrljpvWxIeevuuyVHQjk=;
        b=dssjgq5bRR4rflvQw5PY5rjvXWvN0834CfeY04OpF8BPQCTWMSXBucmgSJWsQlQew+waKuKZdFGbTOlwx5aHJbubNbfhYe2b9166PRNSCyXQ/kvZOISgty2K5cJGsp6EJ38CgR+4XxI4XdIlHmPFINq7hy6v8C3ZsErN42gLPrQ=;
X-UUID: e386fe9b4cd04378bb9bcd192e68287d-20200910
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1341551757; Thu, 10 Sep 2020 11:47:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 11:47:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 11:47:40 +0800
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
Subject: [v2,0/3] PCI: mediatek: Add new generation controller support
Date:   Thu, 10 Sep 2020 11:45:33 +0800
Message-ID: <20200910034536.30860-1-jianjun.wang@mediatek.com>
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
Q2hhbmdlIGluIHYyOg0KMS4gRml4IHRoZSB0eXBvIG9mIGR0LWJpbmRpbmdzIHBhdGNoDQoyLiBS
ZW1vdmUgdGhlIHVubmVjZXNzYXJ5IHByb3BlcnRpZXMgaW4gYmluZGluZyBkb2N1bWVudA0KMy4g
ZGlzcG9zIHRoZSBpcnEgbWFwcGluZ3Mgb2YgbXNpIHRvcCBkb21haW4gd2hlbiBpcnEgdGVhcmRv
d24NCg0KSmlhbmp1biBXYW5nICgzKToNCiAgZHQtYmluZGluZ3M6IFBDSTogbWVkaWF0ZWs6IEFk
ZCBZQU1MIHNjaGVtYQ0KICBQQ0k6IG1lZGlhdGVrOiBBZGQgbmV3IGdlbmVyYXRpb24gY29udHJv
bGxlciBzdXBwb3J0DQogIE1BSU5UQUlORVJTOiB1cGRhdGUgZW50cnkgZm9yIE1lZGlhVGVrIFBD
SWUgY29udHJvbGxlcg0KDQogLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFt
bCAgICAgIHwgIDEzMCArKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAg
ICAgICAgICB8ICAgMTQgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUgICAgICAg
ICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1n
ZW4zLmMgICB8IDEwNzYgKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDEyMjIg
aW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCg0KLS0gDQoy
LjI1LjENCg==

