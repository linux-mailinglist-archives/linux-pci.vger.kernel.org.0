Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0641B8FD3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDZMbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgDZMbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Apr 2020 08:31:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABD4C09B04F;
        Sun, 26 Apr 2020 05:31:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so17160044wma.4;
        Sun, 26 Apr 2020 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM7KSHYLxbtaRQBN1tlYxjklq7dK+X9NukakkOqk6gc=;
        b=NarMcRYDW+Le6qxXEnIIf421DZxURGD6NZpSdUm3Ujg7Eitto1zSJBPbjR+7cY0d5a
         AL0ZxwDuUv0cFHiTVkyhDyn9IBR7jOTZrTkT5DR8iN9p2L5h9BtvN/flQ+pKHI/TFlWq
         PXwmxj8f6N1ndRDh7sREP5nhCr1DkeVeRy60DJ1jbrj0m00y4iNNJq1xZILmANm0N3p+
         eGcBHorx42s36g+iS1WE/Ek6RN6Zw9Eat8cE422OdzEq/aRKp/ZGxrOU0YWjoFNFpmn7
         gd+pyKGAB4BNNN5CyPVtXwn4kiEzXbAGEz8TQCR5eKewEuiMyFqv2kpibeRu0OlZttSc
         oH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM7KSHYLxbtaRQBN1tlYxjklq7dK+X9NukakkOqk6gc=;
        b=gxyPsX1xIxXjIuf//UL9ho2U2ibdaWRDj3Xs35aSGxlwkwV3I+ndMSC0oEaZ+v+pix
         HwczTUIVNVrUAq69IWyIybv51Xy1UuHjiyjyn//Ph9iypo6OUOgTYT3+sYF4hEarT2/1
         HDuf/YzP8fcW9Cx3yED/dNfd7zyJsq3TjmGR6b0xOmeW6WHWd9qnpOtIEpwJIynbmY83
         ZuKfcYpNauxAVtUuCiot7e4UORozpj+GQZtsbyGTbvIc7tI5KPqkDNj57yR+v0qq2prB
         qyQ7pIg7/cQVK5RgvNIf3gaCXeTxXacAC+3xMKQFoc7dSVxE2ejLlp7aSllwc1WEFjfH
         Caxw==
X-Gm-Message-State: AGi0PuYGdg7DaR8lndJwQaJj6FYmCot9WwfVIwaijUzWVdghyEintZAS
        VJmyjV7+e3Pv4l3i5aX5C9fOlE5w
X-Google-Smtp-Source: APiQypL6wH9T1LkxzZjGflCmrVl7Ro7249VwqGqGg8kBiYBYfdRO8uPSgp2ihfHAoM3d2GMAms0wbQ==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr19889872wmh.157.1587904313663;
        Sun, 26 Apr 2020 05:31:53 -0700 (PDT)
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id h16sm18983657wrw.36.2020.04.26.05.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:31:52 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
Date:   Sun, 26 Apr 2020 14:31:47 +0200
Message-Id: <20200426123148.56051-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

The PHY initialization function pointer does not change during the
lifetime of the driver instance, it is therefore sufficient to get
the pointer in .probe(), cache it in driver private data, and just
call the function through the cached pointer in .resume().

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
      branch pci/rcar
NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
---
 drivers/pci/controller/pcie-rcar.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 1a0e74cad9bb..59e55f56e386 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -153,6 +153,7 @@ struct rcar_pcie {
 	int			root_bus_nr;
 	struct clk		*bus_clk;
 	struct			rcar_msi msi;
+	int			(*phy_init_fn)(struct rcar_pcie *pcie);
 };
 
 static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
@@ -1147,7 +1148,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	struct rcar_pcie *pcie;
 	u32 data;
 	int err;
-	int (*phy_init_fn)(struct rcar_pcie *);
 	struct pci_host_bridge *bridge;
 
 	bridge = pci_alloc_host_bridge(sizeof(*pcie));
@@ -1187,8 +1187,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto err_clk_disable;
 
-	phy_init_fn = of_device_get_match_data(dev);
-	err = phy_init_fn(pcie);
+	pcie->phy_init_fn = of_device_get_match_data(dev);
+	err = pcie->phy_init_fn(pcie);
 	if (err) {
 		dev_err(dev, "failed to init PCIe PHY\n");
 		goto err_clk_disable;
@@ -1253,7 +1253,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 static int __maybe_unused rcar_pcie_resume(struct device *dev)
 {
 	struct rcar_pcie *pcie = dev_get_drvdata(dev);
-	int (*hw_init_fn)(struct rcar_pcie *);
 	unsigned int data;
 	int err;
 
@@ -1262,8 +1261,7 @@ static int __maybe_unused rcar_pcie_resume(struct device *dev)
 		return 0;
 
 	/* Failure to get a link might just be that no cards are inserted */
-	hw_init_fn = of_device_get_match_data(dev);
-	err = hw_init_fn(pcie);
+	err = pcie->phy_init_fn(pcie);
 	if (err) {
 		dev_info(dev, "PCIe link down\n");
 		return 0;
-- 
2.25.1

