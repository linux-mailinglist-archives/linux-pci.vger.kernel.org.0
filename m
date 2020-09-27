Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7B279F58
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 09:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgI0Hsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 03:48:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38721 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730351AbgI0Hsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 03:48:41 -0400
X-UUID: a79534706c5344d1954d9f9c8989ff9b-20200927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CyTAOKrr53K3SDY9K0q/wmMsGmkcwUYZ/U05kXCMXwE=;
        b=tcEoSiCAHtdCv2jYK1MUuosunaZj6NSGGMP1xvs/vwR/gX1Q2cCCjgwSWC7bTSaiiogdB4iyArBU2B8nM5MwB0Mp7f+PPGknVboJw7MLGO/95yq7G1OwBJ0GtgeHLIOiD2ZGKsR8rsUcz1WqAk89+zIRFOWQrUmEKpejRY/e6YY=;
X-UUID: a79534706c5344d1954d9f9c8989ff9b-20200927
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 298846190; Sun, 27 Sep 2020 15:48:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Sep 2020 15:48:29 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Sep 2020 15:48:28 +0800
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
Subject: [v3,3/3] MAINTAINERS: update entry for MediaTek PCIe controller
Date:   Sun, 27 Sep 2020 15:45:55 +0800
Message-ID: <20200927074555.4155-4-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200927074555.4155-1-jianjun.wang@mediatek.com>
References: <20200927074555.4155-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
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

