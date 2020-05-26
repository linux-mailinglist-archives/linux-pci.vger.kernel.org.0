Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7688A1E2644
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgEZQBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 12:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgEZQBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 12:01:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F6C03E96D;
        Tue, 26 May 2020 09:01:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n15so10376013pfd.0;
        Tue, 26 May 2020 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruQiqAYcuVk1zrfq4RYcU4OqA1YERnQKs2UgedyH13Q=;
        b=ESdB2QjDZLhzBjCEQRXo80hWPSO3A04P1r2Xsv3qMjkl1YjXSjq257NTPq+Ai2MrsD
         hydlsB0evnEz+Bsx7F5VIhdJu6s9qYJA6vQ9bhuEZSwuraa9RXaaFQrs2c2Vv+iFkUmQ
         oIgC3/yGk60NHhHDvgDFZLvmDVOa/vGQGCtp6p4uAZ8KNKHDLj8e5rr5zuXfXVf4Bg/c
         iPHssd7ky+CL/h8AQSlfK89JtTOXG77NE5T6hnfkgZ9kptUbFVq6W/u3jjM2bt5Vycge
         +MTOuVZ8igU6NsDAMucQ5yL5XpX58208nXm57LztnaM4mFRzwDH7If5hQVng0YLyjldv
         Sdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruQiqAYcuVk1zrfq4RYcU4OqA1YERnQKs2UgedyH13Q=;
        b=Z5AcxnJe43j07vOAfs15vyN1G8L3W6k/0ailobUcH2+LT5HvIc0+mHWUAR3aN0YM4c
         hnFCW2QHIfbI0mJ23a6prjIGfmnBr60e37q7xbgBJfXK5hbOwZwCiCZ+xGDY6oPTflTi
         pUrNR7qkY12rYVjXNHvUozYNNuXe2jvDz6BqsrWha3EYgYawE1WIT3PNsC6BjS6RHMuU
         CSxBcEh/6BBG1rMnwsQqTWeKIVUaPhwd4s/BE8OD6NTdjw7ID1QwW4LoZsQAI9w54UYE
         ChJ8/iSWJmYAr1hKadfcPFQ4OQPmmLNxWLaA61y9NmJWrMVJe0LZWxHZW3EfAI7+S5Ue
         wYcQ==
X-Gm-Message-State: AOAM531ktRr22YdtSdEv/hxl8+Mv/uziUBe1nGC6bbcbTTQqYaaE7rK+
        GomhdMbY8s5FZSBTkFzQR2k=
X-Google-Smtp-Source: ABdhPJyrGLN4ewwVdIdmAh0vOk3OySO8WwavEIaqzTkgRVKlZskl51K35RlXlFa76bXCEHdPNrafnA==
X-Received: by 2002:a62:834a:: with SMTP id h71mr22408927pfe.147.1590508878264;
        Tue, 26 May 2020 09:01:18 -0700 (PDT)
Received: from localhost ([144.34.194.82])
        by smtp.gmail.com with ESMTPSA id 202sm10846pfv.155.2020.05.26.09.01.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 09:01:17 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     jingoohan1@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, kgene@kernel.org,
        thomas.petazzoni@bootlin.com, nsaenzjulienne@suse.de,
        f.fainelli@gmail.com, jquinlan@broadcom.com, krzk@kernel.org,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] PCI: controller: convert to devm_platform_ioremap_resource()
Date:   Wed, 27 May 2020 00:01:10 +0800
Message-Id: <20200526160110.31898-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

use devm_platform_ioremap_resource() to simplify code, it
contains platform_get_resource() and devm_ioremap_resource().

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 4 +---
 drivers/pci/controller/pci-aardvark.c   | 5 ++---
 drivers/pci/controller/pci-ftpci100.c   | 4 +---
 drivers/pci/controller/pci-versatile.c  | 6 ++----
 drivers/pci/controller/pcie-brcmstb.c   | 4 +---
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c5043d951e80..5791039d6a54 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -84,14 +84,12 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
 {
 	struct dw_pcie *pci = ep->pci;
 	struct device *dev = pci->dev;
-	struct resource *res;
 
 	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
 	if (!ep->mem_res)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ep->mem_res->elbi_base = devm_ioremap_resource(dev, res);
+	ep->mem_res->elbi_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep->mem_res->elbi_base))
 		return PTR_ERR(ep->mem_res->elbi_base);
 
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 90ff291c24f0..0d98f9b04daa 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1105,7 +1105,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct advk_pcie *pcie;
-	struct resource *res, *bus;
+	struct resource *bus;
 	struct pci_host_bridge *bridge;
 	int ret, irq;
 
@@ -1116,8 +1116,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pcie->base = devm_ioremap_resource(dev, res);
+	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 1b67564de7af..221dfc9dc81b 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -422,7 +422,6 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct faraday_pci_variant *variant =
 		of_device_get_match_data(dev);
-	struct resource *regs;
 	struct resource_entry *win;
 	struct faraday_pci *p;
 	struct resource *io;
@@ -465,8 +464,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(dev, regs);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index b911359b6d81..b34bbfe611e7 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -77,13 +77,11 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	if (!bridge)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	versatile_pci_base = devm_ioremap_resource(dev, res);
+	versatile_pci_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(versatile_pci_base))
 		return PTR_ERR(versatile_pci_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	versatile_cfg_base[0] = devm_ioremap_resource(dev, res);
+	versatile_cfg_base[0] = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(versatile_cfg_base[0]))
 		return PTR_ERR(versatile_cfg_base[0]);
 
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7730ea845ff2..04bbf9b40193 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -934,7 +934,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	struct device_node *fw_np;
 	struct brcm_pcie *pcie;
 	struct pci_bus *child;
-	struct resource *res;
 	int ret;
 
 	/*
@@ -959,8 +958,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pcie->base = devm_ioremap_resource(&pdev->dev, res);
+	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
-- 
2.25.0

