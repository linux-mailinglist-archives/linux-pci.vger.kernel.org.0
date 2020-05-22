Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47F1DF32D
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgEVXsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:40 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36860 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbgEVXsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:39 -0400
Received: by mail-il1-f195.google.com with SMTP id 17so12516373ilj.3
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcOH9Yyg8RTS1uDyK4ju1tKTwPN2SKJdo9WLhc7R054=;
        b=Yq+ddVcIbStFD/JTpAlILE88uQ3Rrr1tAyij3rR/8w+maTObDdWZrfn8lFExMHl/G1
         4ZQgAQ3IJry6YxnQbGlaTKD9sf3eysJbBvGVeFx2X42JwisKDdYJIFgN9P+oErsQTK67
         85OeAT5bfNQfERZS3yyG42V9+yD6n2DIiLt4S2upzO8PbJwsJ4kY79ZAwj9NUrkZMDN7
         KU4x/zcaRp74TAOj+4AYGn6bE0NCEjazt3UGFv1VozVwZw3a7/Lx6r7lsfAgV7tblaso
         H97CZXb2OkSrTlSqiWFvMTe/DVJQnWPGh6z/kYxDqMl7fcXWABtbd7Hgf6vaMIUR0NrB
         0W0g==
X-Gm-Message-State: AOAM533J01JF/gloToXaGI+1rZbjE6ZkbtXcC553HAamQshDq0FE/MBe
        zQYKE6QPXFLjo85q98WXPQ==
X-Google-Smtp-Source: ABdhPJxSQMk+Xgx5mMu8Qr8nZIuiuOwT56dTl3b5bTFmMoPFk+wCyTSsmV14SJYYFxh7j5CDBkgX/w==
X-Received: by 2002:a92:cf46:: with SMTP id c6mr16172424ilr.4.1590191318280;
        Fri, 22 May 2020 16:48:38 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:37 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 04/15] PCI: brcmstb: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:21 -0600
Message-Id: <20200522234832.954484-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The brcmstb host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-rpi-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7730ea845ff2..15c747c1390a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -172,7 +172,6 @@ struct brcm_pcie {
 	struct device		*dev;
 	void __iomem		*base;
 	struct clk		*clk;
-	struct pci_bus		*root_bus;
 	struct device_node	*np;
 	bool			ssc;
 	int			gen;
@@ -919,9 +918,10 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 static int brcm_pcie_remove(struct platform_device *pdev)
 {
 	struct brcm_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 
-	pci_stop_root_bus(pcie->root_bus);
-	pci_remove_root_bus(pcie->root_bus);
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
 	__brcm_pcie_remove(pcie);
 
 	return 0;
@@ -933,7 +933,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct device_node *fw_np;
 	struct brcm_pcie *pcie;
-	struct pci_bus *child;
 	struct resource *res;
 	int ret;
 
@@ -1004,20 +1003,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0) {
-		dev_err(pcie->dev, "Scanning root bridge failed\n");
-		goto fail;
-	}
-
-	pci_assign_unassigned_bus_resources(bridge->bus);
-	list_for_each_entry(child, &bridge->bus->children, node)
-		pcie_bus_configure_settings(child);
-	pci_bus_add_devices(bridge->bus);
 	platform_set_drvdata(pdev, pcie);
-	pcie->root_bus = bridge->bus;
 
-	return 0;
+	return pci_host_probe(bridge);
 fail:
 	__brcm_pcie_remove(pcie);
 	return ret;
-- 
2.25.1

