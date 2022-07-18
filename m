Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D238578AA0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 21:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiGRTXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiGRTXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 15:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4792F67C;
        Mon, 18 Jul 2022 12:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95ACF616CD;
        Mon, 18 Jul 2022 19:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8A4C341C0;
        Mon, 18 Jul 2022 19:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658172223;
        bh=zn268JVToH1CrQ7zJIK0eZF4kMGLavgHTgGjFqMHSE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B69LvkOepfV5ubz8OtDW5ZNqbnWmPX+1y97k9GTrGOFc/ZDKVdyaWA83uSdsQRvmm
         aIpGgTkNxRM8JM2wqHM7Kg9c1uXUuORV575Xh+ZPAbWG7dgjtJMmg8vqD9Vh2ykTBD
         ML5RpFcZ3rr9EPwzOrLUJLs8U9foLpw9vgXrxupvcaiyTfTrQkiX6ssGvB3hZanFgC
         xyvNBmQ649eGhktPXPznZYkC/K+EabhsMnvH3zCLNxLdPxU9RX9BCvifv4pcuY62Lz
         oSbr9N6ikbrolDxYOWx75MyiQ1K/fsZ4QC/KxkR9YsU6za8P2e0Zmv4cYzx5sTEEYO
         HkmwenW4DThNw==
Date:   Mon, 18 Jul 2022 14:23:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220718192341.GA1437687@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwjPr2gu_oyn4NheLPJZHh-3eib-3onz63sfNOJpdJ6Tw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 02:56:03PM -0400, Jim Quinlan wrote:
> On Mon, Jul 18, 2022 at 2:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
> > > Currently, the function does the setup for establishing PCIe link-up
> > > with the downstream device, and it does the actual link-up as well.
> > > The calling sequence is (roughly) the following in the probe:
> > >
> > > -> brcm_pcie_probe()
> > >     -> brcm_pcie_setup();                       /* Set-up and link-up */
> > >     -> pci_host_probe(bridge);
> > >
> > > This commit splits the setup function in two: brcm_pcie_setup(), which only
> > > does the set-up, and brcm_pcie_start_link(), which only does the link-up.
> > > The reason why we are doing this is to lay a foundation for subsequent
> > > commits so that we can turn on any power regulators, as described in the
> > > root port's DT node, prior to doing link-up.
> >
> > All drivers that care about power regulators turn them on before
> > link-up, but typically those regulators are described directly under
> > the host bridge itself.
> 
> Actually, what you describe is what I proposed with my v1 back in Nov 2020.
> The binding commit message said,
> 
>     "Quite similar to the regulator bindings found in
>     "rockchip-pcie-host.txt", this allows optional regulators to be
>     attached and controlled by the PCIe RC driver."
> 
> > IIUC the difference here is that you have regulators described under
> > Root Ports (not the host bridge/Root Complex itself), so you don't
> > know about them until you've enumerated the Root Ports.
> > brcm_pcie_probe() can't turn them on directly because it doesn't know
> > what Root Ports are present and doesn't know about regulators below
> > them.
> 
> The reviewer's requested me to move the regulator node(s)
> elsewhere, and at some point later it was requested to be placed
> under the Root Port driver.  I would love to return them under the
> host bridge, just say the word!

I'm not suggesting a change in that design; I'm only trying to
understand and clarify the commit log.

I looked briefly for the suggestion to put the regulators under the
Root Port instead of the host bridge, but didn't find it.  I don't
know enough to have an opinion yet.

> > So I think brcm_pcie_setup() does initialization that doesn't depend
> > on the link or any downstream devices, and brcm_pcie_start_link() does
> > things that depend on the link being up.  Right?
>
> Yes.
> 
> > If so, "start_link" might be a slight misnomer since AFAICT
> > brcm_pcie_start_link() doesn't do anything to initiate link-up except
> > maybe deasserting fundamental reset.  Some drivers start the LTSSM or
> > explicitly enable link training, but brcm_pcie_start_link() doesn't
> > seem to do anything like that.
> >
> > brcm_pcie_start_link() still does brcm_pcie_set_outbound_win().  Does
> > that really depend on the link being up?  If that only affects the
> > Root Port, maybe it could be done before link-up?
>
> Some of the registers cannot be accessed until after linkup but these do
> not have that issue.  I will change this.

Here's my attempt (assuming we don't change the DT regulator design):

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bd88a0a46c63..70cad1cbcbb4 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -852,14 +852,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u64 rc_bar2_offset, rc_bar2_size;
 	void __iomem *base = pcie->base;
-	struct device *dev = pcie->dev;
+	int ret, memc;
+	u32 tmp, burst, aspm_support;
 	struct resource_entry *entry;
-	bool ssc_good = false;
 	struct resource *res;
 	int num_out_wins = 0;
-	u16 nlw, cls, lnksta;
-	int i, ret, memc;
-	u32 tmp, burst, aspm_support;
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
@@ -948,25 +945,23 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
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
+	u32p_replace_bits(&tmp, PCI_CLASS_BRIDGE_PCI_NORMAL,
+			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
 
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		res = entry->res;
@@ -998,23 +993,37 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
+	if (!brcm_pcie_rc_mode(pcie)) {
+		dev_err(dev, "PCIe misconfigured; is in EP mode\n");
+		return -EINVAL;
+	}
 
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
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
