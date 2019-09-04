Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E651DA841F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfIDNFJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 09:05:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:4063 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfIDNFJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Sep 2019 09:05:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 06:05:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="383462732"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2019 06:05:05 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i5Uy8-00016w-Bj; Wed, 04 Sep 2019 16:05:04 +0300
Date:   Wed, 4 Sep 2019 16:05:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v3 2/2] dwc: PCI: intel: Intel PCIe RC controller driver
Message-ID: <20190904130504.GN2680@smile.fi.intel.com>
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <35316bac59d3bc681e76d33e0345f4ef950c4414.1567585181.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35316bac59d3bc681e76d33e0345f4ef950c4414.1567585181.git.eswara.kota@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 04, 2019 at 06:10:31PM +0800, Dilip Kota wrote:
> Add support to PCIe RC controller on Intel Universal
> Gateway SoC. PCIe controller is based of Synopsys
> Designware pci core.

Thanks for an update. My comments below.

> +config PCIE_INTEL_AXI
> +        bool "Intel AHB/AXI PCIe host controller support"
> +        depends on PCI_MSI
> +        depends on PCI
> +        depends on OF
> +        select PCIE_DW_HOST
> +        help
> +          Say 'Y' here to enable support for Intel AHB/AXI PCIe Host
> +	  controller driver.
> +	  The Intel PCIe controller is based on the Synopsys Designware
> +	  pcie core and therefore uses the Designware core functions to
> +	  implement the driver.

This hunk is full of indentation issues. Please, see how it's done in other
cases which are already part of upstream kernel.

> +#define PCIE_APP_INTX_OFST	12
> +#define PCIE_APP_IRN_INT	(PCIE_APP_IRN_AER_REPORT | PCIE_APP_IRN_PME | \

It would be slightly easier to read if the value starts from the next line.

> +			PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
> +			PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
> +			PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))

> +static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
> +{
> +	u32 val;
> +
> +	val = pcie_rc_cfg_rd(lpp, PCIE_LCAP);
> +	lpp->max_speed = FIELD_GET(PCIE_LCAP_MAX_LINK_SPEED, val);
> +	lpp->max_width = FIELD_GET(PCIE_LCAP_MAX_LENGTH_WIDTH, val);
> +
> +	val = pcie_rc_cfg_rd(lpp, PCIE_LCTLSTS);
> +
> +	val &= ~(PCIE_LCTLSTS_LINK_DISABLE | PCIE_LCTLSTS_ASPM_ENABLE);

> +	val |= (PCIE_LCTLSTS_SLOT_CLK_CFG | PCIE_LCTLSTS_COM_CLK_CFG |
> +		PCIE_LCTLSTS_RCB128);

Unnecessary parentheses.

> +	pcie_rc_cfg_wr(lpp, val, PCIE_LCTLSTS);
> +}

> +	switch (lpp->max_speed) {
> +	case PCIE_LINK_SPEED_GEN1:
> +	case PCIE_LINK_SPEED_GEN2:
> +		fts = PCIE_AFR_GEN12_FTS_NUM_DFT;
> +		break;

You may group this with default case, right?

> +	case PCIE_LINK_SPEED_GEN3:
> +		fts = PCIE_AFR_GEN3_FTS_NUM_DFT;
> +		break;
> +	case PCIE_LINK_SPEED_GEN4:
> +		fts = PCIE_AFR_GEN4_FTS_NUM_DFT;
> +		break;
> +	default:
> +		fts = PCIE_AFR_GEN12_FTS_NUM_DFT;
> +		break;
> +	}

> +	trace_printk("PCIe misc interrupt status 0x%x\n", reg);

Hmm... Doesn't it give you a BIG warning?

kernel/trace/trace.c:trace_printk_init_buffers()

> +	return IRQ_HANDLED;
> +}

Perhaps the PCI needs some trace points instead.

> +static int intel_pcie_setup_irq(struct intel_pcie_port *lpp)
> +{
> +	struct device *dev = lpp->pci.dev;
> +	struct platform_device *pdev;
> +	char *irq_name;
> +	int irq, ret;
> +
> +	pdev = to_platform_device(dev);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {

> +		dev_err(dev, "missing sys integrated irq resource\n");

Redundant since this cycle.

> +		return irq;
> +	}

> +	irq_name = devm_kasprintf(dev, GFP_KERNEL, "pcie_misc%d", lpp->id);
> +	if (!irq_name) {

> +		dev_err(dev, "failed to alloc irq name\n");

Not very useful. initcall_debug shows an error code.

> +		return -ENOMEM;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, intel_pcie_core_isr,
> +			       IRQF_SHARED, irq_name, lpp);
> +	if (ret) {
> +		dev_err(dev, "request irq %d failed\n", irq);
> +		return ret;
> +	}

+ blank line.

> +	/* Enable integrated interrupts */
> +	pcie_app_wr_mask(lpp, PCIE_APP_IRN_INT,
> +			 PCIE_APP_IRN_INT, PCIE_APP_IRNEN);

At least one parameter can be located on the previous line.

> +	return ret;
> +}

> +static int intel_pcie_get_resources(struct platform_device *pdev)
> +{
> +	struct intel_pcie_port *lpp;
> +	struct resource *res;
> +	struct dw_pcie *pci;
> +	struct device *dev;
> +	int ret;
> +

> +	lpp = platform_get_drvdata(pdev);
> +	pci = &lpp->pci;
> +	dev = pci->dev;

You may save here and there few LOCs by adding these to corresponding
definition blocks.

> +
> +	ret = device_property_read_u32(dev, "linux,pci-domain", &lpp->id);
> +	if (ret) {
> +		dev_err(dev, "failed to get domain id, errno %d\n", ret);
> +		return ret;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");

> +	if (!res)
> +		return -ENXIO;

Redundant. It's done in below call.

> +
> +	pci->dbi_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);

> +
> +	lpp->core_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(lpp->core_clk)) {
> +		ret = PTR_ERR(lpp->core_clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get clks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	lpp->core_rst = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(lpp->core_rst)) {
> +		ret = PTR_ERR(lpp->core_rst);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get resets: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_match_string(dev, "device_type", "pci");
> +	if (ret) {
> +		dev_err(dev, "failed to find pci device type: %d\n", ret);
> +		return ret;
> +	}
> +

> +	if (device_property_read_u32(dev, "reset-assert-ms",
> +				     &lpp->rst_interval))

I would rather leave it on one line.


> +		lpp->rst_interval = RST_INTRVL_DFT_MS;
> +
> +	if (device_property_read_u32(dev, "max-link-speed", &lpp->link_gen))
> +		lpp->link_gen = 0; /* Fallback to auto */
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");

> +	if (!res)
> +		return -ENXIO;

Redundant.

> +
> +	lpp->app_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(lpp->app_base))
> +		return PTR_ERR(lpp->app_base);
> +
> +	ret = intel_pcie_ep_rst_init(lpp);
> +	if (ret)
> +		return ret;
> +
> +	lpp->phy = devm_phy_get(dev, "pciephy");
> +	if (IS_ERR(lpp->phy)) {
> +		ret = PTR_ERR(lpp->phy);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
> +		return ret;
> +	}
> +	return 0;
> +}

> +static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
> +{
> +	int ret;
> +
> +	intel_pcie_core_rst_assert(lpp);
> +	intel_pcie_device_rst_assert(lpp);
> +
> +	ret = phy_init(lpp->phy);
> +	if (ret)
> +		return ret;
> +
> +	intel_pcie_core_rst_deassert(lpp);
> +
> +	ret = clk_prepare_enable(lpp->core_clk);
> +	if (ret) {
> +		dev_err(lpp->pci.dev, "Core clock enable failed: %d\n", ret);
> +		goto clk_err;
> +	}
> +
> +	intel_pcie_rc_setup(lpp);
> +	ret = intel_pcie_app_logic_setup(lpp);
> +	if (ret)
> +		goto app_init_err;
> +
> +	ret = intel_pcie_setup_irq(lpp);
> +	if (!ret)
> +		return ret;
> +
> +	intel_pcie_turn_off(lpp);
> +app_init_err:
> +	clk_disable_unprepare(lpp->core_clk);
> +clk_err:
> +	intel_pcie_core_rst_assert(lpp);

> +	intel_pcie_deinit_phy(lpp);

Why not phy_exit()?

> +	return ret;
> +}

> +static ssize_t pcie_width_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct intel_pcie_port *lpp;
> +	unsigned long val;
> +
> +	lpp = dev_get_drvdata(dev);
> +

> +	if (kstrtoul(buf, 10, &val))

> +		return -EINVAL;

Why shadowing error code?

> +
> +	if (val > lpp->max_width)
> +		return -EINVAL;
> +
> +	lpp->lanes = val;
> +	intel_pcie_max_link_width_setup(lpp);
> +
> +	return len;
> +}

> +	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
> +			    0, PCI_COMMAND);

0 is pretty much fits previous line.

You need to fix your editor settings.

> +int intel_pcie_msi_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +

> +	dev_dbg(pci->dev, "PCIe MSI/MSIx is handled by MSI in x86 processor\n");

Is it useful message?

> +	return 0;
> +}

> +	dev_info(dev,
> +		 "Intel AXI PCIe Root Complex Port %d Init Done\n", lpp->id);

Same, literal can be placed on previous line.

-- 
With Best Regards,
Andy Shevchenko


