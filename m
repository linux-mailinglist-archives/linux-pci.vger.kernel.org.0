Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCEE5771D7
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 00:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiGPWZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 18:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiGPWZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 18:25:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768AC1C91C;
        Sat, 16 Jul 2022 15:25:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c139so1305838pfc.2;
        Sat, 16 Jul 2022 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UA2iSTXYz9HjpyWctyFLbZx1A3AhwC5oV8QF3I5X1cM=;
        b=mMENpA/Fv9wUTX+vKmefub6AgdlUIiVKM/zE84zMV752qPADpLc+WC9R3mNjPZcDu1
         gH8wM8Pf8E07hVvWqt+j+56PAYJEMmj2PyLhPsWL8HCTL6P268+OYiVWi3z96B4YKtoe
         U5gWfL5WdMYiz+SuK3CkfCesHUB8S1wayl8tvhdCNSirKBfsENMQAP1kRyRBOewzCyTm
         +M0yOd7sVtGqpgFfLtyegKQSj4+ZPDrAeMmWSr1zJgzXqkagIltbm/RTmTEuPdfLNBKM
         /3CZxXM3PQF8aimP6gyxAUxmznyFmXuhUzshySZYzZ7fKoeoP4WdBVo1ltUkFQYx7Y7j
         qd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UA2iSTXYz9HjpyWctyFLbZx1A3AhwC5oV8QF3I5X1cM=;
        b=fWMtqFt9hEcRNn40IJGrjyu6DzKlX2mf4a4I9wst3B+bubJkdYHOORZqCB9KrsECP8
         ibtadKepz4kApRH3hQWMhsU4SgC0YfcAsQc90ETGwc1MPvN9ssMn5AvvaVqGZ1IY6lbc
         HRGcNy6FP7TyglOrox3LbCwkvn7+wZYmqLo3O5prYiJc+f+Dyr4QTYn3C8Q2FcntZmIX
         cdJX4ZKmSHYAEQPDh8KFq0AF9rSjVQUiCJ1MinEEi0LkMZJ0HDVWj2aJTzmvmybKc4Oc
         XifqXpP/0XVtd9zYR2IFTJaSgx0s4FWNkREOTdSPQSnq5mZ2p9jw2T11Mh7TkHNT5b2G
         9AZQ==
X-Gm-Message-State: AJIora+bSC6y8bKe0fl6/jTFy7xQSuEi8/O/NCu+aeULo/LQh2EE7G1K
        oDvOAo6SWSBZct9/Uta2EB/bBtXqq/E=
X-Google-Smtp-Source: AGRyM1u8riRGlBHRbvzjBqYEwJUVYsJqkT5qxeenlL3SHSf6WlYTyMFEA3+42EkM3Fjic8ow4xR7wQ==
X-Received: by 2002:a63:e80e:0:b0:419:d02c:fc8b with SMTP id s14-20020a63e80e000000b00419d02cfc8bmr10549317pgh.385.1658010305827;
        Sat, 16 Jul 2022 15:25:05 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00528c149fe97sm6318662pfr.89.2022.07.16.15.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 15:25:05 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
Date:   Sat, 16 Jul 2022 18:24:49 -0400
Message-Id: <20220716222454.29914-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220716222454.29914-1-jim2101024@gmail.com>
References: <20220716222454.29914-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the function does the setup for establishing PCIe link-up
with the downstream device, and it does the actual link-up as well.
The calling sequence is (roughly) the following in the probe:

-> brcm_pcie_probe()
    -> brcm_pcie_setup();                       /* Set-up and link-up */
    -> pci_host_probe(bridge);

This commit splits the setup function in two: brcm_pcie_setup(), which only
does the set-up, and brcm_pcie_start_link(), which only does the link-up.
The reason why we are doing this is to lay a foundation for subsequent
commits so that we can turn on any power regulators, as described in the
root port's DT node, prior to doing link-up.  We do this by defining an
add_bus() callback which is invoked during enumeraion.  At the end of this
patchset the probe function trace will look something like this:

-> brcm_pcie_probe()
    -> brcm_pcie_setup();                       /* Set-up only */
    -> pci_host_probe(bridge);
        -> [enumeration]
            -> pci_alloc_child_bus()
                -> bus->ops->add_bus(bus);      /* We've set this op */
                -> brcm_pcie_add_bus()          /* Our callback      */
                     -> [turn on regulators]    /* Main objective!   */
                     -> brcm_pcie_start_link()  /* Link-up           */

One final note: some code that was executed after the PCIe linkup is now
placed so that it executes prior to linkup, since this code has to run
prior to the invocation of pci_host_probe().

Link: https://lore.kernel.org/r/20220106160332.2143-5-jim2101024@gmail.com
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 69 +++++++++++++++++----------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bd88a0a46c63..c026446d5830 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -849,16 +849,9 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 
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
@@ -948,6 +941,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
+static int brcm_pcie_start_link(struct brcm_pcie *pcie)
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
 
@@ -998,24 +1025,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
@@ -1204,6 +1213,10 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		goto err_reset;
 
+	ret = brcm_pcie_start_link(pcie);
+	if (ret)
+		goto err_reset;
+
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
@@ -1393,6 +1406,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	ret = brcm_pcie_start_link(pcie);
+	if (ret)
+		goto fail;
+
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
 	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
-- 
2.17.1

