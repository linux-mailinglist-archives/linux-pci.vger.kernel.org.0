Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3083FE950
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 08:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbhIBGiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 02:38:13 -0400
Received: from mx21.baidu.com ([220.181.3.85]:35996 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241743AbhIBGiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 02:38:12 -0400
Received: from BJHW-Mail-Ex08.internal.baidu.com (unknown [10.127.64.18])
        by Forcepoint Email with ESMTPS id 2702A7305C619AF5E1D2;
        Thu,  2 Sep 2021 14:37:12 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:37:12 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:37:11 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <patrice.chotard@foss.st.com>, <mchehab@kernel.org>,
        <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v2 3/3] PCI: mediatek-gen3: Make use of the helper function devm_platform_get_and_ioremap_resource_byname()
Date:   Thu, 2 Sep 2021 14:37:02 +0800
Message-ID: <20210902063702.32066-4-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210902063702.32066-1-caihuoqing@baidu.com>
References: <20210902063702.32066-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex28.internal.baidu.com (172.31.51.22) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex08_2021-09-02 14:37:12:149
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the devm_platform_get_and_ioremap_resource_byname() helper
instead of calling platform_get_resource_byname() and
devm_ioremap_resource() separately.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: Use devm_platform_get_and_ioremap_resource_byname()
	instead of devm_platform_ioremap_resource_byname().

 drivers/pci/controller/pcie-mediatek-gen3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 17c59b0d6978..27009da62ec1 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -715,10 +715,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie_port *port)
 	struct resource *regs;
 	int ret;
 
-	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
-	if (!regs)
-		return -EINVAL;
-	port->base = devm_ioremap_resource(dev, regs);
+	port->base = devm_platform_get_and_ioremap_resource_byname(pdev, "pcie-mac", &regs);
 	if (IS_ERR(port->base)) {
 		dev_err(dev, "failed to map register base\n");
 		return PTR_ERR(port->base);
-- 
2.25.1

