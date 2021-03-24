Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C107346FD7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 04:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhCXDGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 23:06:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47605 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235019AbhCXDF5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 23:05:57 -0400
X-UUID: e496039b6cea4f51bf3b3162195fa922-20210324
X-UUID: e496039b6cea4f51bf3b3162195fa922-20210324
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 270299147; Wed, 24 Mar 2021 11:05:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Mar 2021 11:05:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Mar 2021 11:05:51 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        <anson.chuang@mediatek.com>, Krzysztof Wilczyski <kw@linux.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [v9,7/7] MAINTAINERS: Add Jianjun Wang as MediaTek PCI co-maintainer
Date:   Wed, 24 Mar 2021 11:05:10 +0800
Message-ID: <20210324030510.29177-8-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210324030510.29177-1-jianjun.wang@mediatek.com>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 973E95F7BAF6E3CE5732BC3D6A6899E3412E8CF9B7A6CCB05EF3A179FBAFA7B12000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update entry for MediaTek PCIe controller, add Jianjun Wang
as MediaTek PCI co-maintainer.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..8050c14e6a7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13919,6 +13919,7 @@ F:	drivers/pci/controller/dwc/pcie-histb.c
 
 PCIE DRIVER FOR MEDIATEK
 M:	Ryder Lee <ryder.lee@mediatek.com>
+M:	Jianjun Wang <jianjun.wang@mediatek.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org
 S:	Supported
-- 
2.25.1

