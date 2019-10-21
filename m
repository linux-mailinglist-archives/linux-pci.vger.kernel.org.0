Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3846ADEE2D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfJUNjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 09:39:14 -0400
Received: from [217.140.110.172] ([217.140.110.172]:52882 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfJUNjN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68E031007;
        Mon, 21 Oct 2019 06:38:52 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D49FD3F718;
        Mon, 21 Oct 2019 06:38:51 -0700 (PDT)
Date:   Mon, 21 Oct 2019 14:38:50 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Message-ID: <20191021133849.GQ47056@e119886-lin.cambridge.arm.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> PCIe RC driver on Intel Gateway SoCs have a requirement
> of changing link width and speed on the fly.
> So add the sysfs attributes to show and store the link
> properties.
> Add the respective link resize function in pcie DesignWare
> framework so that Intel PCIe driver can use during link
> width configuration on the fly.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c |   9 +++
>  drivers/pci/controller/dwc/pcie-designware.h |   3 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c   | 112 ++++++++++++++++++++++++++-
>  3 files changed, 123 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4c391bfd681a..662fdcb4f2d6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -474,6 +474,15 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>  		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
>  }
>  
> +void dw_pcie_link_width_resize(struct dw_pcie *pci, u32 lane_width)
> +{
> +	u32 val;
> +
> +	val =  dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> +	val &= ~(PORT_MLTI_LNK_WDTH_CHNG | PORT_MLTI_LNK_WDTH);
> +	val |= PORT_MLTI_LNK_WDTH_CHNG | lane_width;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
> +}
>  
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>  {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 3beac10e4a4c..fcf0442341fd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -67,6 +67,8 @@
>  #define PCIE_MSI_INTR0_STATUS		0x830
>  
>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
> +#define PORT_MLTI_LNK_WDTH		GENMASK(5, 0)
> +#define PORT_MLTI_LNK_WDTH_CHNG		BIT(6)
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>  
>  #define PCIE_ATU_VIEWPORT		0x900
> @@ -282,6 +284,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
>  void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
> +void dw_pcie_link_width_resize(struct dw_pcie *pci, u32 lane_width);
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  void dw_pcie_link_speed_change(struct dw_pcie *pci, bool enable);
>  void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 9142c70db808..b9be0921671d 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -146,6 +146,22 @@ static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
>  	pcie_app_wr_mask(lpp, PCIE_APP_CCR_LTSSM_ENABLE, 0, PCIE_APP_CCR);
>  }
>  
> +static const char *pcie_link_gen_to_str(int gen)
> +{
> +	switch (gen) {
> +	case PCIE_LINK_SPEED_GEN1:
> +		return "2.5";
> +	case PCIE_LINK_SPEED_GEN2:
> +		return "5.0";
> +	case PCIE_LINK_SPEED_GEN3:
> +		return "8.0";
> +	case PCIE_LINK_SPEED_GEN4:
> +		return "16.0";
> +	default:
> +		return "???";
> +	}
> +}
> +
>  static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
>  {
>  	u32 val;
> @@ -444,6 +460,91 @@ static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
>  	return ret;
>  }
>  
> +static ssize_t pcie_link_status_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
> +	u32 reg, width, gen;
> +
> +	reg = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, reg >> 16);
> +	gen = FIELD_GET(PCI_EXP_LNKSTA_CLS, reg >> 16);
> +
> +	if (gen > lpp->max_speed)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
> +		       width, pcie_link_gen_to_str(gen));
> +}
> +static DEVICE_ATTR_RO(pcie_link_status);
> +
> +static ssize_t pcie_speed_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > lpp->max_speed)
> +		return -EINVAL;
> +
> +	lpp->link_gen = val;
> +	intel_pcie_max_speed_setup(lpp);
> +	dw_pcie_link_speed_change(&lpp->pci, false);
> +	dw_pcie_link_speed_change(&lpp->pci, true);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(pcie_speed);
> +
> +/*
> + * Link width change on the fly is not always successful.
> + * It also depends on the partner.
> + */
> +static ssize_t pcie_width_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	lpp = dev_get_drvdata(dev);
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > lpp->max_width)
> +		return -EINVAL;
> +
> +	/* HW auto bandwidth negotiation must be enabled */
> +	pcie_rc_cfg_wr_mask(lpp, PCI_EXP_LNKCTL_HAWD, 0,
> +			    PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> +	dw_pcie_link_width_resize(&lpp->pci, val);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(pcie_width);
> +
> +static struct attribute *pcie_cfg_attrs[] = {
> +	&dev_attr_pcie_link_status.attr,
> +	&dev_attr_pcie_speed.attr,
> +	&dev_attr_pcie_width.attr,
> +	NULL,
> +};

Is there a reason that these are limited only to the Intel driver and
not the wider set of DWC drivers?

Is there anything specific here about the Intel GW driver?

Thanks,

Andrew Murray

> +ATTRIBUTE_GROUPS(pcie_cfg);
> +
> +static int intel_pcie_sysfs_init(struct intel_pcie_port *lpp)
> +{
> +	return devm_device_add_groups(lpp->pci.dev, pcie_cfg_groups);
> +}
> +
>  static void __intel_pcie_remove(struct intel_pcie_port *lpp)
>  {
>  	intel_pcie_core_irq_disable(lpp);
> @@ -490,8 +591,17 @@ static int intel_pcie_rc_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
> +	int ret;
>  
> -	return intel_pcie_host_setup(lpp);
> +	ret = intel_pcie_host_setup(lpp);
> +	if (ret)
> +		return ret;
> +
> +	ret = intel_pcie_sysfs_init(lpp);
> +	if (ret)
> +		__intel_pcie_remove(lpp);
> +
> +	return ret;
>  }
>  
>  int intel_pcie_msi_init(struct pcie_port *pp)
> -- 
> 2.11.0
> 
