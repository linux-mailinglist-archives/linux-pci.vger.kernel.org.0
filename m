Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6644FF04
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhKOHLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhKOHLL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:11:11 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EB9C0613B9;
        Sun, 14 Nov 2021 23:08:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w29so28518141wra.12;
        Sun, 14 Nov 2021 23:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTUc9NbgAeebeURXgv+3miv1kPLP6aJJxQBm6hsHSgU=;
        b=IHfix6xhbeGCGUZOUsdQGMCA0f7uVp0mcQifrR2nBfAzFOdbFyl1mPPfKh0dTKmuU6
         tya5wAqEb+LvXjZn0Th1RlUjwLgF5XGGKaKNgQJfz0x9gK43BrBn8rKC1uek4vbuwuoW
         qITHbAiYikSSbxO+ZEo0MvimAmCQUxqTRb8y3peSyiaWzxwbzlXs1wCzRe7XRELWIEOY
         /CCgHdDuBiSuD/mSkGa6RRadZIkhyIaPZ65Eiz2BSmX/xkTC6MP+JU/43RmMJhLwybsQ
         f2NpJarEXIU0FTzWabe8MU0/LBSJJnxaZ/CV6VvcY/7QYGUW54eVJk73MuMMXfVFAKs9
         Boug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTUc9NbgAeebeURXgv+3miv1kPLP6aJJxQBm6hsHSgU=;
        b=Mgu4uza9/XG0CuAIrJhq2I3l0h14gxa8tXn2dOgKbKbdufkkw56mKHDEmaXPh0UcL0
         dfxZ36KdPhEdmCazMqO0ljhNursWHuVJVJpQwfDrUbks6t0JRE1XIfam2NXxxz+MFdac
         1IbbzU01fNSK3U+atS+kUFihqd3vLbJFKlUiDJZ15Vt5sJSE5OriJtLf0MLon5DI0WBn
         WgHGOi6WQYvzP28AYvRTdwCExJ3o5rdSM9+TJ6KksjOA04ClOBJzev+QjqsldAJgV16k
         WWN7lY/C7eNuBpQuPwhojPvbuBgV0RXOtnH7GFJ6+dlvSsbyGfrSZyOyNHtG/lhYSjkI
         cuiQ==
X-Gm-Message-State: AOAM530dA3fmu2WcYLjrLwzSi0JdzrAdIjqxomWiPluBEqc6WKEojJgy
        xccg7KCFUtrVTPuMTqvXkomklELI6BM=
X-Google-Smtp-Source: ABdhPJxaLi+MfCejxxF0xNuZE0GE60Ysw0QHQe4Dn4w5v73JPTyVgPGyi/ohrNSVm9ACx/6WBDDdeA==
X-Received: by 2002:a5d:47aa:: with SMTP id 10mr45720843wrb.50.1636960094548;
        Sun, 14 Nov 2021 23:08:14 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id d6sm13301079wrx.60.2021.11.14.23.08.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:08:14 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/5] PCI: mt7621: avoid custom MIPS code in driver code
Date:   Mon, 15 Nov 2021 08:08:07 +0100
Message-Id: <20211115070809.15529-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver code is setting up MIPS specific I/O coherency units addresses config.
This MIPS specific thing has been moved to be done when PCI code call the
'pcibios_root_bridge_prepare()' function which has been implemented for MIPS
ralink mt7621 platform. Hence, remove MIPS specific code from driver code.
After this changes there is also no need to add any MIPS specific includes
to avoid some errors reported by Kernet Tets Robot with W=1 builds.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 37 ----------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index b60dfb45ef7b..9cf541f5de9c 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -208,37 +208,6 @@ static inline void mt7621_control_deassert(struct mt7621_pcie_port *port)
 		reset_control_assert(port->pcie_rst);
 }
 
-static int setup_cm_memory_region(struct pci_host_bridge *host)
-{
-	struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
-	struct device *dev = pcie->dev;
-	struct resource_entry *entry;
-	resource_size_t mask;
-
-	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
-	if (!entry) {
-		dev_err(dev, "cannot get memory resource\n");
-		return -EINVAL;
-	}
-
-	if (mips_cps_numiocu(0)) {
-		/*
-		 * FIXME: hardware doesn't accept mask values with 1s after
-		 * 0s (e.g. 0xffef), so it would be great to warn if that's
-		 * about to happen
-		 */
-		mask = ~(entry->res->end - entry->res->start);
-
-		write_gcr_reg1_base(entry->res->start);
-		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
-		dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
-			 (unsigned long long)read_gcr_reg1_base(),
-			 (unsigned long long)read_gcr_reg1_mask());
-	}
-
-	return 0;
-}
-
 static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
 				  struct device_node *node,
 				  int slot)
@@ -557,12 +526,6 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 		goto remove_resets;
 	}
 
-	err = setup_cm_memory_region(bridge);
-	if (err) {
-		dev_err(dev, "error setting up iocu mem regions\n");
-		goto remove_resets;
-	}
-
 	return mt7621_pcie_register_host(bridge);
 
 remove_resets:
-- 
2.33.0

