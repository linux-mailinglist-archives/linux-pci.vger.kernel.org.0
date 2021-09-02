Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4293A3FE94F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 08:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbhIBGiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 02:38:13 -0400
Received: from mx21.baidu.com ([220.181.3.85]:35780 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239574AbhIBGiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 02:38:12 -0400
Received: from BJHW-Mail-Ex06.internal.baidu.com (unknown [10.127.64.16])
        by Forcepoint Email with ESMTPS id 60EBCE156FEC99B0549B;
        Thu,  2 Sep 2021 14:37:10 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex06.internal.baidu.com (10.127.64.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:37:10 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:37:09 +0800
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
Subject: [PATCH v2 1/3] driver core: platform: Add the helper function devm_platform_get_and_ioremap_resource_byname()
Date:   Thu, 2 Sep 2021 14:37:00 +0800
Message-ID: <20210902063702.32066-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210902063702.32066-1-caihuoqing@baidu.com>
References: <20210902063702.32066-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex28.internal.baidu.com (172.31.51.22) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex06_2021-09-02 14:37:10:371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since provide the helper function devm_platform_ioremap_resource_byname()
which is wrap platform_get_resource_byname() and devm_ioremap_resource().
But sometimes, many drivers still need to use the resource variables
obtained by platform_get_resource(). In these cases, provide this helper
function devm_platform_get_and_ioremap_resource_byname().

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: Resend this patch as part of a patch series that uses
	the new function. 

 drivers/base/platform.c         | 30 ++++++++++++++++++++++++++----
 include/linux/platform_device.h |  3 +++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 652531f67135..34bb581338d9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -124,6 +124,31 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 
+/**
+ * devm_platform_get_and_ioremap_resource_byname - call devm_ioremap_resource() for a
+ *						   platform device and get resource
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @name: name of the resource
+ * @res: optional output parameter to store a pointer to the obtained resource.
+ *
+ * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
+ */
+void __iomem *
+devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
+					      const char *name, struct resource **res)
+{
+	struct resource *r;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (res)
+		*res = r;
+	return devm_ioremap_resource(&pdev->dev, r);
+}
+EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource_byname);
+
 /**
  * devm_platform_ioremap_resource_byname - call devm_ioremap_resource for
  *					   a platform device, retrieve the
@@ -140,10 +165,7 @@ void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name)
 {
-	struct resource *res;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
-	return devm_ioremap_resource(&pdev->dev, res);
+	return devm_platform_get_and_ioremap_resource_byname(pdev, name, NULL);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
 #endif /* CONFIG_HAS_IOMEM */
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7c96f169d274..50eb1a5b503a 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -66,6 +66,9 @@ extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
 extern void __iomem *
+devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
+					      const char *name, struct resource **res);
+extern void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name);
 extern int platform_get_irq(struct platform_device *, unsigned int);
-- 
2.25.1

