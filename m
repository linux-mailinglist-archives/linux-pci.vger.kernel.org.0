Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68381DF32C
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgEVXsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39988 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbgEVXsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:39 -0400
Received: by mail-io1-f65.google.com with SMTP id q8so11951847iow.7
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThmdbRMtyh+goPlCsRsJutoUCzX5VD3oRn0IWK/oqQw=;
        b=p77dnAHzCiaXAmwrXE7PDlTvEbAzT8efu4tyqM//L10wDacIt+vqT1Q5sYhYM/nGhT
         FFoqVZA2szHKIhXewc2KKZiy9ILC2Y8A4JBJUrS5ESD4xTC7g5/GfFLa8yLE1KiUdzmL
         QWLUqY/cYfSB56WDlJ5z1dm+rPiYr3n7hMuZf6avhFngAHaj8FqL6O22ThemIUo79F80
         LfuVERyOw5qfnHbKZf/rWa7uwzqvP3F+cxf5i3bNa5SQvQGXFxMohJWalejn/3BqfM/J
         nFFOg6SoRL1y77h/rf46LpZ9svCZbJr2eCms+ZqDhTpgp9r9BtCU5V/Y6w9r0YjNbjLj
         n9Ig==
X-Gm-Message-State: AOAM530VToEh4F8VafMNWbjMEhZuKZhB7pqeeUsqyv02pRi0m+ClX3Sz
        Ni9Ojhmv0p8z9LSIQJEEVg==
X-Google-Smtp-Source: ABdhPJyDe0JoDXoIsQG/kMCc3sQ6ItzXn8qXN6+PN/9wYAzSRpPJ6IwR3EmqfjWPoiHq9avExGm3NA==
X-Received: by 2002:a6b:ee15:: with SMTP id i21mr5318999ioh.179.1590191317148;
        Fri, 22 May 2020 16:48:37 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: [PATCH 03/15] PCI: host-common: Use struct pci_host_bridge.windows list directly
Date:   Fri, 22 May 2020 17:48:20 -0600
Message-Id: <20200522234832.954484-4-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's no need to create a temporary resource list and then splice it to
struct pci_host_bridge.windows list. Just use pci_host_bridge.windows
directly. The necessary clean-up is already handled by the PCI core.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-host-common.c | 36 ++++++++----------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 953de57f6c57..f8f71d99e427 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -21,7 +21,7 @@ static void gen_pci_unmap_cfg(void *ptr)
 }
 
 static struct pci_config_window *gen_pci_init(struct device *dev,
-		struct list_head *resources, const struct pci_ecam_ops *ops)
+		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops)
 {
 	int err;
 	struct resource cfgres;
@@ -29,31 +29,25 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	struct pci_config_window *cfg;
 
 	/* Parse our PCI ranges and request their resources */
-	err = pci_parse_request_of_pci_ranges(dev, resources, NULL, &bus_range);
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL, &bus_range);
 	if (err)
 		return ERR_PTR(err);
 
 	err = of_address_to_resource(dev->of_node, 0, &cfgres);
 	if (err) {
 		dev_err(dev, "missing \"reg\" property\n");
-		goto err_out;
+		return ERR_PTR(err);
 	}
 
 	cfg = pci_ecam_create(dev, &cfgres, bus_range, ops);
-	if (IS_ERR(cfg)) {
-		err = PTR_ERR(cfg);
-		goto err_out;
-	}
+	if (IS_ERR(cfg))
+		return cfg;
 
 	err = devm_add_action_or_reset(dev, gen_pci_unmap_cfg, cfg);
-	if (err) {
-		goto err_out;
-	}
-	return cfg;
+	if (err)
+		return ERR_PTR(err);
 
-err_out:
-	pci_free_resource_list(resources);
-	return ERR_PTR(err);
+	return cfg;
 }
 
 int pci_host_common_probe(struct platform_device *pdev)
@@ -61,9 +55,7 @@ int pci_host_common_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
-	struct list_head resources;
 	const struct pci_ecam_ops *ops;
-	int ret;
 
 	ops = of_device_get_match_data(&pdev->dev);
 	if (!ops)
@@ -76,7 +68,7 @@ int pci_host_common_probe(struct platform_device *pdev)
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
-	cfg = gen_pci_init(dev, &resources, ops);
+	cfg = gen_pci_init(dev, bridge, ops);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
@@ -84,7 +76,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (!pci_has_flag(PCI_PROBE_ONLY))
 		pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
-	list_splice_init(&resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = cfg;
 	bridge->busnr = cfg->busr.start;
@@ -92,14 +83,9 @@ int pci_host_common_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_host_probe(bridge);
-	if (ret < 0) {
-		pci_free_resource_list(&resources);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, bridge->bus);
-	return 0;
+
+	return pci_host_probe(bridge);
 }
 EXPORT_SYMBOL_GPL(pci_host_common_probe);
 
-- 
2.25.1

