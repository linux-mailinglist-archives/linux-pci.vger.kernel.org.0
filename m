Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B43FE952
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbhIBGiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 02:38:14 -0400
Received: from mx21.baidu.com ([220.181.3.85]:35884 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241529AbhIBGiN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 02:38:13 -0400
Received: from BJHW-Mail-Ex07.internal.baidu.com (unknown [10.127.64.17])
        by Forcepoint Email with ESMTPS id 43FFC8FD5DB95F69C887;
        Thu,  2 Sep 2021 14:37:11 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex07.internal.baidu.com (10.127.64.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:37:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:37:10 +0800
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
Subject: [PATCH v2 2/3] media: sti/c8sectpfe: Make use of the helper function devm_platform_get_and_ioremap_resource_byname()
Date:   Thu, 2 Sep 2021 14:37:01 +0800
Message-ID: <20210902063702.32066-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210902063702.32066-1-caihuoqing@baidu.com>
References: <20210902063702.32066-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex28.internal.baidu.com (172.31.51.22) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex07_2021-09-02 14:37:11:234
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

 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 02dc78bd7fab..8d57970c196c 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -676,14 +676,11 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 
 	fei->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "c8sectpfe");
-	fei->io = devm_ioremap_resource(dev, res);
+	fei->io = devm_platform_get_and_ioremap_resource_byname(pdev, "c8sectpfe", &res);
 	if (IS_ERR(fei->io))
 		return PTR_ERR(fei->io);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					"c8sectpfe-ram");
-	fei->sram = devm_ioremap_resource(dev, res);
+	fei->sram = devm_platform_get_and_ioremap_resource_byname(pdev, "c8sectpfe-ram", &res);
 	if (IS_ERR(fei->sram))
 		return PTR_ERR(fei->sram);
 
-- 
2.25.1

