Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4C580179
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiGYPQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiGYPQG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:16:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6601ADB4;
        Mon, 25 Jul 2022 08:13:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 17so10757426pfy.0;
        Mon, 25 Jul 2022 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nqXI0OBX6+3fPD9GB7eqkTNdkkNXz3BLLurSoXm4HMY=;
        b=hGZdKFYkmF90c02xvsh4TfWmzhRk35TqVrz2UXPDss5oWXIh5efjAMVqxnh9vYxcz3
         xHhmwQJ1+gSPCXSYD/cbL4I/xAAzGjWwfkARCxHkJaOLsZHHrWQeAzNrIaSd88BlEiYP
         F7DmwbirPybTHYyzpO01qUxDP320aL/O8Javs2gKC8zTVzBvdlqhd1UlWgD5+Z6ZnVd8
         maB0slKaLaxtaGkpxUMukcslUPUvr9lwXtxDiQXjsusIBe3T6oN6ciDhipuXmDBLH8A+
         2spdzBp/CJ53fuMR9bg4i1fjbOelqVWT33eCPUudAPyar81AhQW4u4KARfQvv+gO2ioA
         P0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nqXI0OBX6+3fPD9GB7eqkTNdkkNXz3BLLurSoXm4HMY=;
        b=Pi4UK4vBG6FD529rUiCSzVsjtD0/QDGbh4x2rb+y3GxBUQz0Ej3tFdKaeahKAEqpIB
         BGBTIhfXSGertqtr4mvy5I378PjRB/05PYZEl/D1cwkOP073pJxaaibTmVlzbimKBA4H
         9Czvg1tzux/frOWRwixjaZ0W98ip57fT5UYFdXUlIrT0FChfjMFior/xuaLbAVQlLBwr
         3ficMh3TIsMBwrEdAK1SsVDQDPVPi0nfpp2acZ4sGZ/opsGa3Yw0XLvAeqxXsEAW6OlX
         1LYm0A3wa51M4//yQr3P9sJ8TQeT7kLTizxy6fFlj0vxJ33xSNPW6H791sp+O1c1wAcd
         9lig==
X-Gm-Message-State: AJIora9hpNNwW9FlrZMCeEfUuJK+hhhbFwDw8+q+F3fWjKXKnLgGtQSi
        E4msmx1BSzi3OOipbvKFI5k4ka78acw=
X-Google-Smtp-Source: AGRyM1tDMzwhzglh6zmMH0dTfmoPWhxUORzvFrGe51sd2pdmdOipPi6xw1FyIB9+SCslffXPs69U5w==
X-Received: by 2002:a05:6a00:796:b0:52c:2d1:3ae0 with SMTP id g22-20020a056a00079600b0052c02d13ae0mr1888610pfu.52.1658762008159;
        Mon, 25 Jul 2022 08:13:28 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm6649667plh.30.2022.07.25.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:13:27 -0700 (PDT)
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
Subject: [PATCH v3 2/7] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
Date:   Mon, 25 Jul 2022 11:12:51 -0400
Message-Id: <20220725151258.42574-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725151258.42574-1-jim2101024@gmail.com>
References: <20220725151258.42574-1-jim2101024@gmail.com>
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
add_bus() callback which is invoked during enumeration.  At the end of this
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
 drivers/pci/controller/pcie-brcmstb.c | 111 +++++++++++++++-----------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bd88a0a46c63..15e47e8c94eb 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -849,17 +849,13 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 
 static int brcm_pcie_setup(struct brcm_pcie *pcie)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u64 rc_bar2_offset, rc_bar2_size;
 	void __iomem *base = pcie->base;
-	struct device *dev = pcie->dev;
+	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	bool ssc_good = false;
-	struct resource *res;
-	int num_out_wins = 0;
-	u16 nlw, cls, lnksta;
-	int i, ret, memc;
 	u32 tmp, burst, aspm_support;
+	int num_out_wins = 0;
+	int ret, memc;
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
@@ -935,6 +931,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	else
 		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_GT_4GB;
 
+	if (!brcm_pcie_rc_mode(pcie)) {
+		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
+		return -EINVAL;
+	}
+
 	/* disable the PCIe->GISB memory window (RC_BAR1) */
 	tmp = readl(base + PCIE_MISC_RC_BAR1_CONFIG_LO);
 	tmp &= ~PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK;
@@ -945,31 +946,27 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	tmp &= ~PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK;
 	writel(tmp, base + PCIE_MISC_RC_BAR3_CONFIG_LO);
 
-	if (pcie->gen)
-		brcm_pcie_set_gen(pcie, pcie->gen);
-
-	/* Unassert the fundamental reset */
-	pcie->perst_set(pcie, 0);
+	/* Don't advertise L0s capability if 'aspm-no-l0s' */
+	aspm_support = PCIE_LINK_STATE_L1;
+	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
+		aspm_support |= PCIE_LINK_STATE_L0S;
+	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+	u32p_replace_bits(&tmp, aspm_support,
+		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	/*
-	 * Give the RC/EP time to wake up, before trying to configure RC.
-	 * Intermittently check status for link-up, up to a total of 100ms.
+	 * For config space accesses on the RC, show the right class for
+	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
 	 */
-	for (i = 0; i < 100 && !brcm_pcie_link_up(pcie); i += 5)
-		msleep(5);
-
-	if (!brcm_pcie_link_up(pcie)) {
-		dev_err(dev, "link down\n");
-		return -ENODEV;
-	}
-
-	if (!brcm_pcie_rc_mode(pcie)) {
-		dev_err(dev, "PCIe misconfigured; is in EP mode\n");
-		return -EINVAL;
-	}
+	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
+	u32p_replace_bits(&tmp, 0x060400,
+			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
 
+	bridge = pci_host_bridge_from_priv(pcie);
 	resource_list_for_each_entry(entry, &bridge->windows) {
-		res = entry->res;
+		struct resource *res = entry->res;
 
 		if (resource_type(res) != IORESOURCE_MEM)
 			continue;
@@ -998,23 +995,41 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
+	/* PCIe->SCB endian mode for BAR */
+	tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
+	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
+		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
+	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
+
+	return 0;
+}
+
+static int brcm_pcie_start_link(struct brcm_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	void __iomem *base = pcie->base;
+	u16 nlw, cls, lnksta;
+	bool ssc_good = false;
+	u32 tmp;
+	int ret, i;
+
+	/* Unassert the fundamental reset */
+	pcie->perst_set(pcie, 0);
 
 	/*
-	 * For config space accesses on the RC, show the right class for
-	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
+	 * Give the RC/EP time to wake up, before trying to configure RC.
+	 * Intermittently check status for link-up, up to a total of 100ms.
 	 */
-	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
-	u32p_replace_bits(&tmp, 0x060400,
-			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
-	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
+	for (i = 0; i < 100 && !brcm_pcie_link_up(pcie); i += 5)
+		msleep(5);
+
+	if (!brcm_pcie_link_up(pcie)) {
+		dev_err(dev, "link down\n");
+		return -ENODEV;
+	}
+
+	if (pcie->gen)
+		brcm_pcie_set_gen(pcie, pcie->gen);
 
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
@@ -1031,12 +1046,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		 pci_speed_string(pcie_link_speed[cls]), nlw,
 		 ssc_good ? "(SSC)" : "(!SSC)");
 
-	/* PCIe->SCB endian mode for BAR */
-	tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
-	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
-		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
-	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
-
 	/*
 	 * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
 	 * is enabled => setting the CLKREQ_DEBUG_ENABLE field to 1.
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

