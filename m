Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1281E263B9A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 05:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgIJDsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 23:48:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51591 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726714AbgIJDsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 23:48:07 -0400
X-UUID: 49487089d5004960b01db84a6416a13e-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CyTAOKrr53K3SDY9K0q/wmMsGmkcwUYZ/U05kXCMXwE=;
        b=kG9e+Dy2m4gJOMj+3IWkRouyOPlmGtEszONJau+OPMARyWeev2nc6sdNFmSrJu6h0fmiIMgt5d/PzWSIZG21W4D99z8i+qdSS+epTtpxzr3evwqbvWbzjjbi6sCtYFihuTJeFodQTMXqLTeMv57bCmLZ+gLRmHbhgNX+eSjSzrQ=;
X-UUID: 49487089d5004960b01db84a6416a13e-20200910
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1020178516; Thu, 10 Sep 2020 11:48:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 11:47:57 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 11:47:57 +0800
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
        "Sj Huang" <sj.huang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Subject: [v2,3/3] MAINTAINERS: update entry for MediaTek PCIe controller
Date:   Thu, 10 Sep 2020 11:45:36 +0800
Message-ID: <20200910034536.30860-4-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200910034536.30860-1-jianjun.wang@mediatek.com>
References: <20200910034536.30860-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIG1haW50YWluZXIgZm9yIE1lZGlhVGVrIFBDSWUgY29udHJvbGxlciBkcml2ZXIuDQoNClNp
Z25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNvbT4NCkFj
a2VkLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBNQUlOVEFJ
TkVSUyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0
IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KaW5kZXggZGVhYWZiNjE3MzYxLi41YzYxMTA0
Njg1MjYgMTAwNjQ0DQotLS0gYS9NQUlOVEFJTkVSUw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC0x
MzQ1OSw2ICsxMzQ1OSw3IEBAIEY6CWRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtaGlz
dGIuYw0KIA0KIFBDSUUgRFJJVkVSIEZPUiBNRURJQVRFSw0KIE06CVJ5ZGVyIExlZSA8cnlkZXIu
bGVlQG1lZGlhdGVrLmNvbT4NCitNOglKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRl
ay5jb20+DQogTDoJbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KIEw6CWxpbnV4LW1lZGlhdGVr
QGxpc3RzLmluZnJhZGVhZC5vcmcNCiBTOglTdXBwb3J0ZWQNCi0tIA0KMi4yNS4xDQo=

