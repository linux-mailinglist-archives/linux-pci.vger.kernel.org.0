Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5429A57D53E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiGUU4N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 16:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiGUU4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 16:56:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E338FD5B;
        Thu, 21 Jul 2022 13:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90F9EB82676;
        Thu, 21 Jul 2022 20:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36A1C3411E;
        Thu, 21 Jul 2022 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658436968;
        bh=tX6kO771Y8rae7XBY2hGr6gk9lyb6FdmAulTojf4f9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V3Ss2H67Xvnx8ZyuGEpnPgx1kEi/8dQ8yRb5Eu7KmogmH8k+CCAH4J3MAWiLdGvGN
         dU3RKuozG9sXJPrGUMa/0zy7PkEWdLLixnT8qHgnwyS95ktqSeecguhRqZ+67W7KpI
         LUV5IvMVOKaGss2QuQdWlgL1/Z7oLbl5+wvQ0ppG3fdWkJE4uM00NK1aTJOHWc7z6a
         1++shiOGSgqmwOD2ucU/s9bvRbsKX1m1HCw3pl9Oz3EE38x3d/vyLySjd1r6w9a7kq
         Q6JjpWNiK0HjWYzJ+X+F9uVmO58fQihbqHFHbseW04Vxudc9aojkVqJKTWLlwpWDYK
         6kgxj44bnoLZg==
Date:   Thu, 21 Jul 2022 15:56:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Subject: Re: [PATCH v4 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Message-ID: <20220721205605.GA1749669@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720060112epcms2p30a05414992cf814e5886af2b70c0f58f@epcms2p3>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 03:01:12PM +0900, Wangseok Lee wrote:
> Add support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform of Axis
> Communications. This is based on arm64 and support GEN4 & 2lane. This
> PCIe controller is based on DesignWare Hardware core and uses DesignWare
> core functions to implement the driver. "pcie-artpec6. c" supports artpec6
> and artpec7 H/W. artpec8 can not be expanded because H/W configuration is
> completely different from artpec6/7. PHY and sub controller are different.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> Signed-off-by: Jaeho Cho <jaeho79.cho@samsung.com>

Since you are the one sending the patch, your sign-off should be last:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.18#n363

> +config PCIE_ARTPEC8_HOST
> +	bool "Axis ARTPEC-8 PCIe controller Host Mode"
> +	depends on ARCH_ARTPEC || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_ENDPOINT
> +	select PCI_EPF_TEST
> +	select PCIE_DW_HOST
> +	select PCIE_ARTPEC8
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in the
> +	  ARTPEC-8 SoC to work in host mode.

Add a blank line between paragraphs.  Mentioned previously:
https://lore.kernel.org/r/20220603160314.GA76545@bhelgaas

> +	  This PCIe controller is based on DesignWare hardware core and
> +	  uses DesignWare core functions to implement the driver.

I don't think Kconfig users need to know how the driver is
implemented.  Not really even sure they need to know that it's based
on DesignWare hardware.  Users need to be able to connect the hardware
in front of them with the drivers for it, which means they start with
the name on the box.

> +config PCIE_ARTPEC8_EP
> +	bool "Axis ARTPEC-8 PCIe controller Endpoint Mode"
> +	depends on ARCH_ARTPEC || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	depends on PCI_ENDPOINT_CONFIGFS
> +	select PCI_EPF_TEST
> +	select PCIE_DW_EP
> +	select PCIE_ARTPEC8
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in the
> +	  ARTPEC-8 SoC to work in endpoint mode.

Same.

> +	  This PCIe controller is based on DesignWare hardware core and
> +	  uses DesignWare core functions to implement the driver.

> +#define PCIE_GEN3_EQUALIZATION_DISABLE	(0x1 << 16)

Why the mix of "(0x1 << 16)" and "BIT(...)" below?  Pick one.

> +#define PCIE_GEN3_EQ_PHASE_2_3		(0x1 << 9)
> +#define PCIE_GEN3_RXEQ_PH01_EN		(0x1 << 12)
> +#define PCIE_GEN3_RXEQ_RGRDLESS_RXTS	(0x1 << 13)
> +
> +#define FAST_LINK_MODE			(7)
> +
> +/* PCIe ELBI registers */
> +#define PCIE_IRQ0_STS			0x000
> +#define PCIE_IRQ1_STS			0x004
> +#define PCIE_IRQ2_STS			0x008
> +#define IRQ2_STS_IRQ_MSI_ST		BIT(20)

> +static const int artpec8_pcie_dbi_addr_con[] = {
> +	FSYS_PCIE_DBI_ADDR_CON

Since this is an array, I assume you envision adding more entries
eventually.  That means you should have a comma at the end of this
entry, as you do in artpec8_pcie_clks[] below, so the
FSYS_PCIE_DBI_ADDR_CON line will not need to change when you add
entries in the future.

> +};

> +static u32 artpec8_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				 u32 reg, size_t size)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);

Typical names for pointers like this are "dra7xx", "rockchip",
"artpec6_pcie", and even "pcie".  "artpec6_pcie" seems unnecessarily
wordy.  "pcie" seems possibly confusing since "pci" is the common
pointer to struct dw_pcie.  I think "artpec8" would be perfect.

> +	u32 val;
> +	bool is_atu = false;
> +
> +	if (base == pci->atu_base) {
> +		is_atu = true;
> +		base = pci->dbi_base;
> +		regmap_write(artpec8_ctrl->sysreg,
> +			     artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],

This is not safe because nothing guarantees that 
artpec8_ctrl->link_id == 0.  Any other index other than zero would be
out of bounds.

That suggests that making artpec8_pcie_dbi_addr_con[] an array is
over-engineered.  If you need more than one value in the future, you
could make it an array at that time.  For now it just makes the code
hard to read.

> +			     FSYS_PCIE_DBI_ADDR_OVR_ATU);
> +	}

> +static int artpec8_pcie_get_subsys_resources(struct platform_device *pdev,
> +					     struct artpec8_pcie *artpec8_ctrl)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	/* External Local Bus interface(ELBI) Register */

Add a space before things like "(ELBI)".  Also below for "(DBI)".

> +	artpec8_ctrl->elbi_base =
> +		devm_platform_ioremap_resource_byname(pdev, "elbi");
> +	if (IS_ERR(artpec8_ctrl->elbi_base)) {
> +		dev_err(dev, "failed to map elbi_base\n");
> +		return PTR_ERR(artpec8_ctrl->elbi_base);
> +	}
> +
> +	artpec8_ctrl->sysreg =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +						"samsung,fsys-sysreg");
> +	if (IS_ERR(artpec8_ctrl->sysreg)) {
> +		dev_err(dev, "fsys sysreg regmap lookup failed.\n");

Omit periods on error messages (as you did for the elbi_base message
above).  This also applies to several messages below.

> +		return PTR_ERR(artpec8_ctrl->sysreg);
> +	}
> +
> +	artpec8_ctrl->pmu_syscon =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +						"samsung,syscon-phandle");
> +	if (IS_ERR(artpec8_ctrl->pmu_syscon)) {
> +		dev_err(dev, "pmu syscon regmap lookup failed.\n");
> +		return PTR_ERR(artpec8_ctrl->pmu_syscon);
> +	}

> +static int artpec8_pcie_get_rc_mem_resources(struct platform_device *pdev,
> +					     struct artpec8_pcie *artpec8_ctrl)
> +{
> +	struct dw_pcie *pci = artpec8_ctrl->pci;
> +
> +	/* Data Bus Interface(DBI) Register */

> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> +	if (!res)
> +		return -EINVAL;

Add a blank line here.

> +	ep->phys_base = res->start;
> +	ep->addr_size = resource_size(res);

> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(artpec8_pcie_clks),
> +				artpec8_pcie_clks);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

This is the same as:

  return devm_clk_bulk_get(dev, ...);

> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(artpec8_pcie_clks),
> +				      artpec8_pcie_clks);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Again, same as:

  return clk_bulk_prepare_enable(...);

> +static u8 artpec8_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
> +	pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;

This line is out of place.  This function is essentially a boolean and
should not have side effects like updating pci->atu_base.

> +
> +	if (val == 0xffffffff)
> +		return 1;
> +
> +	return 0;

This function as a whole is a copy of dw_pcie_iatu_unroll_enabled(),
which is static in pcie-designware.c.  I assume you'll resolve this
eventually (maybe not in this initial patch) so we don't have two
copies.

> +static void artpec8_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;

Add a blank line here.

> +	/*
> +	 * Currently PCIe EP core is not setting iatu_unroll_enabled
> +	 * so let's handle it here. We need to find proper place to
> +	 * initialize this so that it can be used for other EP
> +	 * controllers as well.
> +	 */
> +	pci->iatu_unroll_enabled = artpec8_pcie_iatu_unroll_enabled(pci);

> +static int __init artpec8_add_pcie_ep(struct artpec8_pcie *artpec8_ctrl,
> +				      struct platform_device *pdev)

Why is this __init when the caller is not __init?

> +	ret = dw_pcie_ep_init(ep);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Again:

  return dw_pcie_ep_init(ep);

> +static int __init artpec8_add_pcie_port(struct artpec8_pcie *artpec8_ctrl,
> +					struct platform_device *pdev)

Why is this __init?

> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pdata = of_device_get_match_data(dev);
> +
> +	if (!pdata)
> +		return -ENODEV;
> +
> +	mode = (enum dw_pcie_device_mode)pdata->mode;
> +
> +	artpec8_ctrl->pci = pci;
> +	artpec8_ctrl->pdata = pdata;
> +	artpec8_ctrl->mode = mode;
> +
> +	pci->dev = dev;
> +	pci->ops = pdata->dwc_ops;
> +	pci->dbi_base2 = NULL;
> +	pci->dbi_base = NULL;

These are guaranteed NULL already by the kzalloc().

> +static int __exit artpec8_pcie_remove(struct platform_device *pdev)

Why do we need __exit and __exit_p below?  exynos, keystone, and kirin
use them, but I'm not sure they need them either.  I don't know all
the details, but most of our drivers don't use them, so I assume this
one doesn't need them either.

> +static struct platform_driver artpec8_pcie_driver = {
> +	.probe	= artpec8_pcie_probe,
> +	.remove		= __exit_p(artpec8_pcie_remove),

__exit_p(), see above.

> +	.driver = {
> +		.name	= "artpec8-pcie",
> +		.of_match_table = artpec8_pcie_of_match,
> +	},
> +};
