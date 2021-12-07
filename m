Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE346B978
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 11:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhLGKxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 05:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbhLGKxC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 05:53:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7872AC061748;
        Tue,  7 Dec 2021 02:49:32 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i12so10365426wmq.4;
        Tue, 07 Dec 2021 02:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3XUpWa6+1DXUAt7w4vSplRb3YE72oXrdXq5mYAn8E8=;
        b=C+yu8zCfUE6lse16oPxZBsWO4Oc1HcCQyegPwFGnsxch4nayyCuXvsHqRpwddeKBqc
         A9jpVIqj5yM19yHxzniLitpkfsTmpN81uTzEhpOTNTFfRJVwg2TwdtsbqKvZrNZs5tTF
         7bYYKlkuUNLWaLuRXq/3XwxmV4OPFss1il1Qfr1q1ma+sfn8E21JZ2A+HkD/zh6eQxnk
         eNZrwaH7Dtl+sEQLEJ4J6CriHSL9uxaN0Eq8Ej9Z5GVoOA1qCI25yDeiOCQLdkMddi5y
         F/gCzr83H+pxE6BkExo1Vn7FHb1Tu0XqZgfZMbiAP0G2eWQlYWFNsnDkGRhCVJEPvnPj
         9eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3XUpWa6+1DXUAt7w4vSplRb3YE72oXrdXq5mYAn8E8=;
        b=MEXbUEyP2N1XlYF39DnTNpr8r2NZ00Me5ZIkp87Kl6uJ7cvZ++a4oLLGb701EME/Mv
         9oGTG3r4qJL0+CKsWrPufMpmrQfj5TNstF3KKkXz1P7/xNtaR3Xy6MaW0dzu4jRfgwti
         qJrJDbcfyOVvRkI8TGSqyzQ8WQzQNUg5vKwKlAUZdlzuch1oDhqGK0t2NlmyRPlthglf
         Zcow/zj19xSDllYkXHu5+bLFB434imAWvzH7aE3+5hZBmUQqKz0NeUx4jkDlZOFL0nJU
         ri84qp6OJSRvLKQtPtFMlqMHVtYlGG2Bn752jCVjYEwuJ2DaqIqc7wqieh/R707yYoVt
         HoGw==
X-Gm-Message-State: AOAM532uCFf2bJP+AW6na4gtN4xc9yuU134A7eDr/1+BxccxBYXCTStF
        sdMABlQTz8eZ9AucMM8Iyx+kKNG3ykw=
X-Google-Smtp-Source: ABdhPJylkXGNpR6jFsgRln7FS6oBDEGYmeLoZvlJzPRtb/YgJwo01PMfTZ7LadjK1JCidrT2nUzOcA==
X-Received: by 2002:a05:600c:294c:: with SMTP id n12mr5906139wmd.71.1638874170879;
        Tue, 07 Dec 2021 02:49:30 -0800 (PST)
Received: from localhost.localdomain (27.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.27])
        by smtp.gmail.com with ESMTPSA id z6sm13958561wrm.93.2021.12.07.02.49.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:49:30 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v3 3/5] PCI: mt7621: Avoid custom MIPS code in driver code
Date:   Tue,  7 Dec 2021 11:49:22 +0100
Message-Id: <20211207104924.21327-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver code is setting up MIPS specific I/O coherency units addresses config.
This MIPS specific thing has been moved to be done when PCI code call the
'pcibios_root_bridge_prepare()' function which has been implemented for MIPS
ralink mt7621 platform. Hence, remove MIPS specific code from driver code.
After this change there is also no need to add any MIPS specific includes
to avoid some errors reported by Kernet Test Robot with W=1 builds.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 37 ----------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 4138c0e83513..42cce31df943 100644
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

