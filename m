Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2133D218C50
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgGHP4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgGHP4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 11:56:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F5FC061A0B;
        Wed,  8 Jul 2020 08:56:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so5786962pgm.2;
        Wed, 08 Jul 2020 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTnB75vtOiMnbJqaXMvvz8L2JnWzPT1EaDAz7nDE03Y=;
        b=QbwrULrpg+PmMdPzqkDQfzuOdRcVMM0J3kkOHTf9KV5F6X81uJgGRL1DRuOfE7YYLy
         KQRrNu+8BMYuJHI4Bla08kX/ordNvUCa82r+1oZ5ZJa+CQJNM9zXNm938oU9YsflLMRF
         LLLkAT4D0VZsEQsVZNUdX2HmSwLDYTam8wFZ3QLpcbNUPjwiQWhyf//Swwi0t9M/2fFt
         Km6XNqVKQSHoKEbkRzJAGGnhtsARCGHhqvw43+bRXBQ92VjNHw6Jgs5IqeiBoa8kIGAC
         RjCP1uVdmTwXWRlIDwHpXhU7AcPRsPs+kaHm8qn3rW8izjbv7cuf9garpWuipYUTBhOF
         bgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTnB75vtOiMnbJqaXMvvz8L2JnWzPT1EaDAz7nDE03Y=;
        b=RPX381jX0KdJzxtJWrv6p4zqaR0OV/GIxj4Gk4D+bLm14mOJ5TvsebhH2MrvpkWb6V
         krBP+mWgus4W7vQ9VMMqWWBaCXqTE/iLOIaLqA7D/Yx+S0VXOxBuPo+S7oqVYqwLJDZh
         hIT9zu3YLYKuSJOSaTPa5/YzyTI/kkwe9CB2W0MVrrBsqyLh/fPOr+XWBfZ0IVqmsSIF
         c24esEx98UExxwPGaq0DlLcZuVyppGPr/mgXA7DDbBt/1YoJG4NPDoDKB6PBoOaMQ62H
         /S0UrT+IdpIvY811q0M59sMffViF5lFqU3OfN3aTTYihxMU0NpAok+gFV1xGFsPTwRfX
         qWhw==
X-Gm-Message-State: AOAM533JuTgXLIGuaOL1TSoplZOTyJo4DVcUJNqbSEdpmGOzHdzgey+B
        HKQSGVWKGWJzhtJiJGJiWYk=
X-Google-Smtp-Source: ABdhPJz06Vl6GCUNpLi+sFeMwoYs4LZGc0RPijejxvNKqSbOK+voGeoXsqXro3kDQQshV6k8IlIN1w==
X-Received: by 2002:a62:52d2:: with SMTP id g201mr1028079pfb.57.1594223782761;
        Wed, 08 Jul 2020 08:56:22 -0700 (PDT)
Received: from localhost ([89.208.244.139])
        by smtp.gmail.com with ESMTPSA id e6sm227698pfh.176.2020.07.08.08.56.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 08:56:22 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     jingoohan1@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, kgene@kernel.org, krzk@kernel.org,
        thomas.petazzoni@bootlin.com, f.fainelli@gmail.com,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2] PCI: controller: convert to devm_platform_ioremap_resource()
Date:   Wed,  8 Jul 2020 23:56:14 +0800
Message-Id: <20200708155614.308-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200526160110.31898-1-zhengdejin5@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

use devm_platform_ioremap_resource() to simplify code, it
contains platform_get_resource() and devm_ioremap_resource().

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v1 -> v2:
	- rebase to pci/misc branch
	- add Rob Reviewed tag and Thanks for Bob's help.

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
index e90f0cc65c73..a8d361f6c5d9 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -76,13 +76,11 @@ static int versatile_pci_probe(struct platform_device *pdev)
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
index 15c747c1390a..91a4b7f3ee45 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -933,7 +933,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct device_node *fw_np;
 	struct brcm_pcie *pcie;
-	struct resource *res;
 	int ret;
 
 	/*
@@ -958,8 +957,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pcie->base = devm_ioremap_resource(&pdev->dev, res);
+	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
-- 
2.25.0

