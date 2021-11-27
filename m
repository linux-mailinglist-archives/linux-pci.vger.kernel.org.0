Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6E45FF1B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhK0OTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhK0ORs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:48 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87127C0613F1
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso8675851wmr.5
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZ/a1hLw4ib4u/sKDQg2z3YvvoSc0gXGQR3XWvJND3g=;
        b=oqhFJrPbWY79Vj5f5L0bx09G+WbgjAONBUVmiErfATsmYwQoMdhG8D9QdXevd+QSnW
         oFkYAPUvdbYBbcAoblBCypCHSrTtbmzWQi5BElfjXTLjJLYPb0mHfuyqacsZpmSuw8Mp
         jAGZTQe+ZNdkLFkKcBAFtXCR3432+ccFRYbrDfn1I4DLbmzLbsxNz6T4OAzfHd99Pz5j
         3DLKpkXyksIKCVkE4Y96/poYPSA99CT+l5SlFt3CHzZigvG6hR0EIaJjRWwDUh5+t0PP
         JCSg/0EPPPpH+tOhY3xwheo1lSeQZ36ksmtPYPS3qs/vHDvoUVyZ3zGR0/lC9uDeRxTs
         Hp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZ/a1hLw4ib4u/sKDQg2z3YvvoSc0gXGQR3XWvJND3g=;
        b=qpwZHYiRX9r5a3bBH+krtjHcoq9fy0Nq+otLu7m+IKcvrfaCrtzO9HLy4PsK6alFhN
         VAg79NfY8AmRVa/H0uuXKx7byujbU7ogaM7C9UhO65Dii7vrqya6s1Y+NeXADVKqY9j3
         HPMc9kx3pLvakBuSHgfQlrKKiPAqz6if/X2dsf0Oq3c3oA1+4b00ZWwNO40SH++umOmZ
         DppBv3DqWP16KRccrw04iPHOAvdudgxPmkj/rBM98ox1DbVybresxJX4w1djyhvrE8Ah
         ULmDS1JR62Db2bL6cvBB3lav5LrZk9xEGYFWfS2PuFloIiZx5wno7uhVxTCrr9WH4nG5
         JuRw==
X-Gm-Message-State: AOAM533vH7UpvBdgHitpmzARk+GH9W2prc3sOrz7sUKsbnRQCw+ZcXIM
        gTRAH6Jt90KBM5H/Uc0shmwnJ3BWG0Xk4Q==
X-Google-Smtp-Source: ABdhPJwsQ8RBGmaR68eJc+uAbx2KvJIE4ouM9lYecwGOYm0nOmZ5Vt0dBnsmDhqgI1f4t7Ap4feSIw==
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr23192727wmc.42.1638022296061;
        Sat, 27 Nov 2021 06:11:36 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:35 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 06/13] PCI: brcmstb: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:14 +0100
Message-Id: <fd50e5903c6cdb2e8d7bc9460e47cb848da4badb.1638022049.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638022048.git.ffclaire1224@gmail.com>
References: <cover.1638022048.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI controller struct contain "device *", while others contain
"platform_device *". Unify "device *dev" to "platform_device *pdev" in
struct brcmstb_pcie, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 35 ++++++++++++++-------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..e6f0c3e561b6 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -278,7 +278,7 @@ struct brcm_msi {
 
 /* Internal PCIe Host Controller Information.*/
 struct brcm_pcie {
-	struct device		*dev;
+	struct platform_device		*pdev;
 	void __iomem		*base;
 	struct clk		*clk;
 	struct device_node	*np;
@@ -641,7 +641,7 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
 {
 	struct brcm_msi *msi;
 	int irq, ret;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 
 	irq = irq_of_parse_and_map(dev->of_node, 1);
 	if (irq <= 0) {
@@ -780,7 +780,7 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct resource_entry *entry;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	u64 lowest_pcie_addr = ~(u64)0;
 	int ret, i = 0;
 	u64 size = 0;
@@ -866,7 +866,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u64 rc_bar2_offset, rc_bar2_size;
 	void __iomem *base = pcie->base;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct resource_entry *entry;
 	bool ssc_good = false;
 	struct resource *res;
@@ -984,7 +984,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 			continue;
 
 		if (num_out_wins >= BRCM_NUM_PCIE_OUT_WINS) {
-			dev_err(pcie->dev, "too many outbound wins\n");
+			dev_err(dev, "too many outbound wins\n");
 			return -EINVAL;
 		}
 
@@ -1067,7 +1067,7 @@ static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
 	}
 
 	if (!l23)
-		dev_err(pcie->dev, "failed to enter low-power link state\n");
+		dev_err(&pcie->pdev->dev, "failed to enter low-power link state\n");
 }
 
 static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
@@ -1101,7 +1101,7 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
 	ret = (tmp & combined_mask) == val ? 0 : -EIO;
 	if (ret)
-		dev_err(pcie->dev, "failed to %s phy\n", (start ? "start" : "stop"));
+		dev_err(&pcie->pdev->dev, "failed to %s phy\n", (start ? "start" : "stop"));
 
 	return ret;
 }
@@ -1231,24 +1231,25 @@ static const struct of_device_id brcm_pcie_match[] = {
 
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node, *msi_np;
 	struct pci_host_bridge *bridge;
 	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
 	int ret;
 
-	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
 
-	data = of_device_get_match_data(&pdev->dev);
+	data = of_device_get_match_data(dev);
 	if (!data) {
 		pr_err("failed to look up compatible string\n");
 		return -EINVAL;
 	}
 
 	pcie = pci_host_bridge_priv(bridge);
-	pcie->dev = &pdev->dev;
+	pcie->pdev = pdev;
 	pcie->np = np;
 	pcie->reg_offsets = data->offsets;
 	pcie->type = data->type;
@@ -1259,7 +1260,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
-	pcie->clk = devm_clk_get_optional(&pdev->dev, "sw_pcie");
+	pcie->clk = devm_clk_get_optional(dev, "sw_pcie");
 	if (IS_ERR(pcie->clk))
 		return PTR_ERR(pcie->clk);
 
@@ -1270,15 +1271,15 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(pcie->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "could not enable clock\n");
+		dev_err(dev, "could not enable clock\n");
 		return ret;
 	}
-	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
+	pcie->rescal = devm_reset_control_get_optional_shared(dev, "rescal");
 	if (IS_ERR(pcie->rescal)) {
 		clk_disable_unprepare(pcie->clk);
 		return PTR_ERR(pcie->rescal);
 	}
-	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
+	pcie->perst_reset = devm_reset_control_get_optional_exclusive(dev, "perst");
 	if (IS_ERR(pcie->perst_reset)) {
 		clk_disable_unprepare(pcie->clk);
 		return PTR_ERR(pcie->perst_reset);
@@ -1286,7 +1287,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
-		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
+		dev_err(dev, "failed to deassert 'rescal'\n");
 
 	ret = brcm_phy_start(pcie);
 	if (ret) {
@@ -1301,7 +1302,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
 	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
-		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
+		dev_err(dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
 		goto fail;
 	}
@@ -1310,7 +1311,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (pci_msi_enabled() && msi_np == pcie->np) {
 		ret = brcm_pcie_enable_msi(pcie);
 		if (ret) {
-			dev_err(pcie->dev, "probe of internal MSI failed");
+			dev_err(dev, "probe of internal MSI failed");
 			goto fail;
 		}
 	}
-- 
2.25.1

