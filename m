Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903D613B095
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 18:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgANRLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 12:11:09 -0500
Received: from foss.arm.com ([217.140.110.172]:55146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgANRLJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 12:11:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 280D71396;
        Tue, 14 Jan 2020 09:11:08 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4373F3F68E;
        Tue, 14 Jan 2020 09:11:06 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:11:01 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        mbrugger@suse.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/6] PCI: brcmstb: Add Broadcom STB PCIe host
 controller driver
Message-ID: <20200114171101.GA11177@e121166-lin.cambridge.arm.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
 <20191216110113.30436-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216110113.30436-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 16, 2019 at 12:01:09PM +0100, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
> 
> This adds a basic driver for Broadcom's STB PCIe controller, for now
> aimed at Raspberry Pi 4's SoC, bcm2711.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> ---
> 
> Changes since v3:
>   - Update commit message
>   - rollback roundup_pow_two usage, it'll be updated later down the line
>   - Remove comment in register definition
> 
> Changes since v2:
>   - Correct rc_bar2_offset sign

In relation to this change.

[...]

> +static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> +							u64 *rc_bar2_size,
> +							u64 *rc_bar2_offset)
> +{
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +	struct device *dev = pcie->dev;
> +	struct resource_entry *entry;
> +
> +	entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> +	if (!entry)
> +		return -ENODEV;
> +
> +	*rc_bar2_offset = -entry->offset;

I think this deserves a comment - I guess it has to do with how the
controller expects CPU<->PCI offsets to be expressed compared to how it
is computed in dma_ranges entries.

I will try to complete the review shortly and try to apply it given
that it has already been reviewed by others.

Lorenzo

> +	*rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
> +
> +	/*
> +	 * We validate the inbound memory view even though we should trust
> +	 * whatever the device-tree provides. This is because of an HW issue on
> +	 * early Raspberry Pi 4's revisions (bcm2711). It turns out its
> +	 * firmware has to dynamically edit dma-ranges due to a bug on the
> +	 * PCIe controller integration, which prohibits any access above the
> +	 * lower 3GB of memory. Given this, we decided to keep the dma-ranges
> +	 * in check, avoiding hard to debug device-tree related issues in the
> +	 * future:
> +	 *
> +	 * The PCIe host controller by design must set the inbound viewport to
> +	 * be a contiguous arrangement of all of the system's memory.  In
> +	 * addition, its size mut be a power of two.  To further complicate
> +	 * matters, the viewport must start on a pcie-address that is aligned
> +	 * on a multiple of its size.  If a portion of the viewport does not
> +	 * represent system memory -- e.g. 3GB of memory requires a 4GB
> +	 * viewport -- we can map the outbound memory in or after 3GB and even
> +	 * though the viewport will overlap the outbound memory the controller
> +	 * will know to send outbound memory downstream and everything else
> +	 * upstream.
> +	 *
> +	 * For example:
> +	 *
> +	 * - The best-case scenario, memory up to 3GB, is to place the inbound
> +	 *   region in the first 4GB of pcie-space, as some legacy devices can
> +	 *   only address 32bits. We would also like to put the MSI under 4GB
> +	 *   as well, since some devices require a 32bit MSI target address.
> +	 *
> +	 * - If the system memory is 4GB or larger we cannot start the inbound
> +	 *   region at location 0 (since we have to allow some space for
> +	 *   outbound memory @ 3GB). So instead it will  start at the 1x
> +	 *   multiple of its size
> +	 */
> +	if (!*rc_bar2_size || *rc_bar2_offset % *rc_bar2_size ||
> +	    (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
> +		dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, off 0x%llx\n",
> +			*rc_bar2_size, *rc_bar2_offset);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int brcm_pcie_setup(struct brcm_pcie *pcie)
> +{
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +	u64 rc_bar2_offset, rc_bar2_size;
> +	void __iomem *base = pcie->base;
> +	struct device *dev = pcie->dev;
> +	struct resource_entry *entry;
> +	unsigned int scb_size_val;
> +	bool ssc_good = false;
> +	struct resource *res;
> +	int num_out_wins = 0;
> +	u16 nlw, cls, lnksta;
> +	int i, ret;
> +	u32 tmp;
> +
> +	/* Reset the bridge */
> +	brcm_pcie_bridge_sw_init_set(pcie, 1);
> +
> +	usleep_range(100, 200);
> +
> +	/* Take the bridge out of reset */
> +	brcm_pcie_bridge_sw_init_set(pcie, 0);
> +
> +	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
> +	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	/* Wait for SerDes to be stable */
> +	usleep_range(100, 200);
> +
> +	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
> +	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
> +	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
> +	u32p_replace_bits(&tmp, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128,
> +			  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
> +	writel(tmp, base + PCIE_MISC_MISC_CTRL);
> +
> +	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
> +						    &rc_bar2_offset);
> +	if (ret)
> +		return ret;
> +
> +	tmp = lower_32_bits(rc_bar2_offset);
> +	u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
> +			  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK);
> +	writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> +	writel(upper_32_bits(rc_bar2_offset),
> +	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> +
> +	scb_size_val = rc_bar2_size ?
> +		       ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
> +	tmp = readl(base + PCIE_MISC_MISC_CTRL);
> +	u32p_replace_bits(&tmp, scb_size_val,
> +			  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> +	writel(tmp, base + PCIE_MISC_MISC_CTRL);
> +
> +	/* disable the PCIe->GISB memory window (RC_BAR1) */
> +	tmp = readl(base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> +	tmp &= ~PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK;
> +	writel(tmp, base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> +
> +	/* disable the PCIe->SCB memory window (RC_BAR3) */
> +	tmp = readl(base + PCIE_MISC_RC_BAR3_CONFIG_LO);
> +	tmp &= ~PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK;
> +	writel(tmp, base + PCIE_MISC_RC_BAR3_CONFIG_LO);
> +
> +	/* Mask all interrupts since we are not handling any yet */
> +	writel(0xffffffff, pcie->base + PCIE_MSI_INTR2_MASK_SET);
> +
> +	/* clear any interrupts we find on boot */
> +	writel(0xffffffff, pcie->base + PCIE_MSI_INTR2_CLR);
> +
> +	if (pcie->gen)
> +		brcm_pcie_set_gen(pcie, pcie->gen);
> +
> +	/* Unassert the fundamental reset */
> +	brcm_pcie_perst_set(pcie, 0);
> +
> +	/*
> +	 * Give the RC/EP time to wake up, before trying to configure RC.
> +	 * Intermittently check status for link-up, up to a total of 100ms.
> +	 */
> +	for (i = 0; i < 100 && !brcm_pcie_link_up(pcie); i += 5)
> +		msleep(5);
> +
> +	if (!brcm_pcie_link_up(pcie)) {
> +		dev_err(dev, "link down\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!brcm_pcie_rc_mode(pcie)) {
> +		dev_err(dev, "PCIe misconfigured; is in EP mode\n");
> +		return -EINVAL;
> +	}
> +
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		res = entry->res;
> +
> +		if (resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +
> +		if (num_out_wins >= BRCM_NUM_PCIE_OUT_WINS) {
> +			dev_err(pcie->dev, "too many outbound wins\n");
> +			return -EINVAL;
> +		}
> +
> +		brcm_pcie_set_outbound_win(pcie, num_out_wins, res->start,
> +					   res->start - entry->offset,
> +					   res->end - res->start + 1);
> +		num_out_wins++;
> +	}
> +
> +	/*
> +	 * For config space accesses on the RC, show the right class for
> +	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
> +	 */
> +	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +	u32p_replace_bits(&tmp, 0x060400,
> +			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +
> +	if (pcie->ssc) {
> +		ret = brcm_pcie_set_ssc(pcie);
> +		if (ret == 0)
> +			ssc_good = true;
> +		else
> +			dev_err(dev, "failed attempt to enter ssc mode\n");
> +	}
> +
> +	lnksta = readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKSTA);
> +	cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
> +	nlw = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> +	dev_info(dev, "link up, %s x%u %s\n",
> +		 PCIE_SPEED2STR(cls + PCI_SPEED_133MHz_PCIX_533),
> +		 nlw, ssc_good ? "(SSC)" : "(!SSC)");
> +
> +	/* PCIe->SCB endian mode for BAR */
> +	tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
> +	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
> +		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
> +
> +	/*
> +	 * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
> +	 * is enabled => setting the CLKREQ_DEBUG_ENABLE field to 1.
> +	 */
> +	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	tmp |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
> +	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +
> +	return 0;
> +}
> +
> +/* L23 is a low-power PCIe link state */
> +static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
> +{
> +	void __iomem *base = pcie->base;
> +	int l23, i;
> +	u32 tmp;
> +
> +	/* Assert request for L23 */
> +	tmp = readl(base + PCIE_MISC_PCIE_CTRL);
> +	u32p_replace_bits(&tmp, 1, PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK);
> +	writel(tmp, base + PCIE_MISC_PCIE_CTRL);
> +
> +	/* Wait up to 36 msec for L23 */
> +	tmp = readl(base + PCIE_MISC_PCIE_STATUS);
> +	l23 = FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK, tmp);
> +	for (i = 0; i < 15 && !l23; i++) {
> +		usleep_range(2000, 2400);
> +		tmp = readl(base + PCIE_MISC_PCIE_STATUS);
> +		l23 = FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK,
> +				tmp);
> +	}
> +
> +	if (!l23)
> +		dev_err(pcie->dev, "failed to enter low-power link state\n");
> +}
> +
> +static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> +{
> +	void __iomem *base = pcie->base;
> +	int tmp;
> +
> +	if (brcm_pcie_link_up(pcie))
> +		brcm_pcie_enter_l23(pcie);
> +	/* Assert fundamental reset */
> +	brcm_pcie_perst_set(pcie, 1);
> +
> +	/* Deassert request for L23 in case it was asserted */
> +	tmp = readl(base + PCIE_MISC_PCIE_CTRL);
> +	u32p_replace_bits(&tmp, 0, PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK);
> +	writel(tmp, base + PCIE_MISC_PCIE_CTRL);
> +
> +	/* Turn off SerDes */
> +	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
> +	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +
> +	/* Shutdown PCIe bridge */
> +	brcm_pcie_bridge_sw_init_set(pcie, 1);
> +}
> +
> +static void __brcm_pcie_remove(struct brcm_pcie *pcie)
> +{
> +	brcm_pcie_turn_off(pcie);
> +	clk_disable_unprepare(pcie->clk);
> +	clk_put(pcie->clk);
> +}
> +
> +static int brcm_pcie_remove(struct platform_device *pdev)
> +{
> +	struct brcm_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	pci_stop_root_bus(pcie->root_bus);
> +	pci_remove_root_bus(pcie->root_bus);
> +	__brcm_pcie_remove(pcie);
> +
> +	return 0;
> +}
> +
> +static int brcm_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct pci_host_bridge *bridge;
> +	struct brcm_pcie *pcie;
> +	struct pci_bus *child;
> +	struct resource *res;
> +	int ret;
> +
> +	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	pcie->dev = &pdev->dev;
> +	pcie->np = np;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pcie->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pcie->base))
> +		return PTR_ERR(pcie->base);
> +
> +	pcie->clk = devm_clk_get_optional(&pdev->dev, "sw_pcie");
> +	if (IS_ERR(pcie->clk))
> +		return PTR_ERR(pcie->clk);
> +
> +	ret = of_pci_get_max_link_speed(np);
> +	pcie->gen = (ret < 0) ? 0 : ret;
> +
> +	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
> +
> +	ret = pci_parse_request_of_pci_ranges(pcie->dev, &bridge->windows,
> +					      &bridge->dma_ranges, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not enable clock\n");
> +		return ret;
> +	}
> +
> +	ret = brcm_pcie_setup(pcie);
> +	if (ret)
> +		goto fail;
> +
> +	bridge->dev.parent = &pdev->dev;
> +	bridge->busnr = 0;
> +	bridge->ops = &brcm_pcie_ops;
> +	bridge->sysdata = pcie;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +
> +	ret = pci_scan_root_bus_bridge(bridge);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "Scanning root bridge failed\n");
> +		goto fail;
> +	}
> +
> +	pci_assign_unassigned_bus_resources(bridge->bus);
> +	list_for_each_entry(child, &bridge->bus->children, node)
> +		pcie_bus_configure_settings(child);
> +	pci_bus_add_devices(bridge->bus);
> +	platform_set_drvdata(pdev, pcie);
> +	pcie->root_bus = bridge->bus;
> +
> +	return 0;
> +fail:
> +	__brcm_pcie_remove(pcie);
> +	return ret;
> +}
> +
> +static const struct of_device_id brcm_pcie_match[] = {
> +	{ .compatible = "brcm,bcm2711-pcie" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, brcm_pcie_match);
> +
> +static struct platform_driver brcm_pcie_driver = {
> +	.probe = brcm_pcie_probe,
> +	.remove = brcm_pcie_remove,
> +	.driver = {
> +		.name = "brcm-pcie",
> +		.of_match_table = brcm_pcie_match,
> +	},
> +};
> +module_platform_driver(brcm_pcie_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
> +MODULE_AUTHOR("Broadcom");
> -- 
> 2.24.0
> 
