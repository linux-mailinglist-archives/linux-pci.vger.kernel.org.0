Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD9486742
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiAFQDx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiAFQDv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:03:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B9C061245;
        Thu,  6 Jan 2022 08:03:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id q14so2789588plx.4;
        Thu, 06 Jan 2022 08:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Qzj5uM3WmTTnFaEKj5iKt+4OPXn0Lx6lUn5gyvkQ+E=;
        b=N8wK/hRD1u3eb7TVeN1Csp7IwhqFqj1t094kbL8ce5G6wEGT0Z1UIU9MmlAXUeAWSr
         EJVePebjd59M1AuR5yDw0qiN7/1ulwW0x8ZVAQ+Eqg/ZEXuQ4H0y1IOrpB8UrkczOeLB
         whhNeCgXVZFQAj+NTCBLp+pr1RWF4KAEYWvbFUYR5uhp6+WdCKqrHScBr6ckxwZFUJKj
         lrEGsOP/wRJtiuEfCgPfbv+eEB3MubeNYGLOVt3OqXWG/j3bS6A2OdtNvj2YbgDGTujX
         Gi2Hjy8BU7z7tV/nqNNrQ4VaSxYxRMfVF1GbpIrYCoNKanjWb4mfkv928NoA9Ud/7i5r
         Q9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Qzj5uM3WmTTnFaEKj5iKt+4OPXn0Lx6lUn5gyvkQ+E=;
        b=FHqN5+vzDgN5Fu8S2D9gcdRaStbMm7WgYo/ZgyG6wF5qixNiCooWh9/lzNSg9OxgZH
         c/GAXurien2GhhriFo/0va5/3tsu3R4XNdgaWtpptWxdEHeYTMbk3xUrvAoG6cKG4zX1
         /NzZTdNc/fEyWuiEpGtHm4t3hj6jndMZtStuf/cCMpdOF7aZEHu3Y7rboVVGc6O0Ykwz
         ByypKEc+ouOpJmLP832P2th5UYDSS5oZwzEFTeEBGpi36ZDtdRLFY0lbSxBIo8NVQuSe
         gy7/lxYgRpqaXmCK5PLoL19G6pFqbl3F2MJ5ocQK7s8QJs7LxGupt2uz8m09ty9a7re8
         FvzQ==
X-Gm-Message-State: AOAM532zqDIfoh5DS39e++kD5VRCsz2L9RDaSW613sAf3usVDbYKPl3/
        gkS6u4lEVc7bW4+xk/MZL7l0hdHxrrQ=
X-Google-Smtp-Source: ABdhPJynVfa2BqUF7oYxZ+qXdflkl/Xq5ZuShssXE3LWpM9zD23C7Y01xPxtPsdcem3u6V/yU6XTLg==
X-Received: by 2002:a17:902:7009:b0:149:e7b4:ba32 with SMTP id y9-20020a170902700900b00149e7b4ba32mr5514766plk.151.1641485030857;
        Thu, 06 Jan 2022 08:03:50 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q19sm2376316pgb.77.2022.01.06.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:03:50 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 4/7] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
Date:   Thu,  6 Jan 2022 11:03:27 -0500
Message-Id: <20220106160332.2143-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220106160332.2143-1-jim2101024@gmail.com>
References: <20220106160332.2143-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We need to take some code in brcm_pcie_setup() and put it in a new function
brcm_pcie_linkup().  In future commits the brcm_pcie_linkup() function will
be called indirectly by pci_host_probe() as opposed to the host driver
invoking it directly.

Some code that was executed after the PCIe linkup is now placed so that it
executes prior to linkup, since this code has to run prior to the
invocation of pci_host_probe().

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 65 ++++++++++++++++-----------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9ed79ddb6a83..5f373227aad6 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -863,16 +863,9 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 
 static int brcm_pcie_setup(struct brcm_pcie *pcie)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u64 rc_bar2_offset, rc_bar2_size;
 	void __iomem *base = pcie->base;
-	struct device *dev = pcie->dev;
-	struct resource_entry *entry;
-	bool ssc_good = false;
-	struct resource *res;
-	int num_out_wins = 0;
-	u16 nlw, cls, lnksta;
-	int i, ret, memc;
+	int ret, memc;
 	u32 tmp, burst, aspm_support;
 
 	/* Reset the bridge */
@@ -957,6 +950,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
+	/* Don't advertise L0s capability if 'aspm-no-l0s' */
+	aspm_support = PCIE_LINK_STATE_L1;
+	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
+		aspm_support |= PCIE_LINK_STATE_L0S;
+	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+	u32p_replace_bits(&tmp, aspm_support,
+		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+
+	/*
+	 * For config space accesses on the RC, show the right class for
+	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
+	 */
+	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
+	u32p_replace_bits(&tmp, 0x060400,
+			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
+
+	return 0;
+}
+
+static int brcm_pcie_linkup(struct brcm_pcie *pcie)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct device *dev = pcie->dev;
+	void __iomem *base = pcie->base;
+	struct resource_entry *entry;
+	struct resource *res;
+	int num_out_wins = 0;
+	u16 nlw, cls, lnksta;
+	bool ssc_good = false;
+	u32 tmp;
+	int ret, i;
+
 	/* Unassert the fundamental reset */
 	pcie->perst_set(pcie, 0);
 
@@ -994,24 +1021,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		num_out_wins++;
 	}
 
-	/* Don't advertise L0s capability if 'aspm-no-l0s' */
-	aspm_support = PCIE_LINK_STATE_L1;
-	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
-		aspm_support |= PCIE_LINK_STATE_L0S;
-	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
-	u32p_replace_bits(&tmp, aspm_support,
-		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
-	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
-
-	/*
-	 * For config space accesses on the RC, show the right class for
-	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
-	 */
-	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
-	u32p_replace_bits(&tmp, 0x060400,
-			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
-	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
-
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
 		if (ret == 0)
@@ -1200,6 +1209,10 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		goto err_reset;
 
+	ret = brcm_pcie_linkup(pcie);
+	if (ret)
+		goto err_reset;
+
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
-- 
2.17.1

