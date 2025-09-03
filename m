Return-Path: <linux-pci+bounces-35405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF2B42A89
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 22:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBFD5E0393
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D222DFF0D;
	Wed,  3 Sep 2025 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNu4cinD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDD2DEA84;
	Wed,  3 Sep 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930214; cv=none; b=G1+TZjEjpB2MXvQxw22uJvYw4C8diFGkBHArfYkT0mJx59qLPPkEF+7W9kkZiyjKQtYq1BcKb9KiQ8ohO4JPvENuT3HbE6OJdHyhku9EroB0m0WXl3YuR52ilr43BQTbg94KMtCTmcSh2YPzJU7s2v1TB6pJ0rbKdehFj4IfTj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930214; c=relaxed/simple;
	bh=CIVePx+bh6Jcnti5BnbFzgt4EvnviVStsAkU6XlfJLg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nGXhyjv/fi0tTKIO2Ar6B4vknWMCp/OJhDUwR+9NsUeQ7DQl/hUHQMZQojGfCUp1KkGFpdza19IOUKoC1ilOC8JggQq0bgS1AVSx0d3Qy6syLNy6bZzQmAJzTEcNoDNwa7P+9Ml8wRZ3OqnI0HLA3Ul7pC4aUyS9GextCRzHnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNu4cinD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD44C4CEE7;
	Wed,  3 Sep 2025 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756930214;
	bh=CIVePx+bh6Jcnti5BnbFzgt4EvnviVStsAkU6XlfJLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qNu4cinD4/GLmBzXEhGQc2l7h3idJgqi2vXPhv5jcOABZV/NsgyQXT1IPbL3m82Wz
	 shzBjjRpYp1P4lEx+/YmOK6C9DnFqQRrBizS9QxoTPAu7D8VOVtrSsspiko35UUOmK
	 Z0UgJ+1VnCSJRl1YqRAZxpPqnJJeXHA8OrCcKsu4IiArVpBLY6hSqGDsUFbQNw3APo
	 ZWfdz+b5MFXV2WL19TO5J75PlkTqkWL5Loq2uorUWc1RmheDo+UhH7yV4X2ttYUne2
	 xhhPB+yYa3JxWjZR7xo//L1g9KyJ5bA/27pDA/A8M3cnsPKRcSzOAmXeN8DDkvDbaS
	 Drm4jctGZJJ+Q==
Date: Wed, 3 Sep 2025 15:10:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com, Jonathan Chocron <jonnyc@amazon.com>
Subject: Re: [PATCH v8 4/5] PCI: dwc: Add ECAM support with iATU configuration
Message-ID: <20250903201012.GA1217030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-ecam_v4-v8-4-92a30e0fa02d@oss.qualcomm.com>

[+cc Jonathan for potential issue in pcie-al.c]

On Thu, Aug 28, 2025 at 01:04:25PM +0530, Krishna Chaitanya Chundru wrote:
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> would be matched against the Base and Limit addresses) of the incoming
> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> 
> Configuring iATU in config shift feature enables ECAM feature to access the
> config space, which avoids iATU configuration for every config access.
> 
> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.
> 
> As DBI comes under config space, this avoids remapping of DBI space
> separately. Instead, it uses the mapped config space address returned from
> ECAM initialization. Change the order of dw_pcie_get_resources() execution
> to achieve this.
> 
> Enable the ECAM feature if the config space size is equal to size required
> to represent number of buses in the bus range property.
> 
> As per PCIe spec 6, sec 7.2.2 the memory should be aligned to 256MB for
> ECAM. The synopsys iATU also uses bits [27:12] to form BDF, so the base
> address must be 256MB aligned. Add a check to ensure the configuration
> space base address is 256MB aligned before enabling ECAM.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/Kconfig                |   1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      |   5 +
>  4 files changed, 138 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ff6b6d9e18ecfa44273e87931551f9e63fbe3cba..a0e7ad3fb5afec63b0f919732a50147229623186 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -20,6 +20,7 @@ config PCIE_DW_HOST
>  	bool
>  	select PCIE_DW
>  	select IRQ_MSI_LIB
> +	select PCI_HOST_COMMON
>  
>  config PCIE_DW_EP
>  	bool
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..eda7affcdcb2075d07ba6eeab70e41b6548a4b18 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -8,6 +8,7 @@
>   * Author: Jingoo Han <jg1.han@samsung.com>
>   */
>  
> +#include <linux/align.h>
>  #include <linux/iopoll.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqchip/irq-msi-lib.h>
> @@ -32,6 +33,8 @@ static struct pci_ops dw_child_pcie_ops;
>  				     MSI_FLAG_PCI_MSIX			| \
>  				     MSI_GENERIC_FLAGS_MASK)
>  
> +#define IS_256MB_ALIGNED(x) IS_ALIGNED(x, SZ_256M)
> +
>  static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
>  	.required_flags		= DW_PCIE_MSI_FLAGS_REQUIRED,
>  	.supported_flags	= DW_PCIE_MSI_FLAGS_SUPPORTED,
> @@ -413,6 +416,92 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = {0};
> +	resource_size_t bus_range_max;
> +	struct resource_entry *bus;
> +	int ret;
> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +
> +	/*
> +	 * Root bus under the host bridge doesn't require any iATU configuration
> +	 * as DBI region will be used to access root bus config space.
> +	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
> +	 * remaining buses need type 1 iATU configuration.
> +	 */
> +	atu.index = 0;
> +	atu.type = PCIE_ATU_TYPE_CFG0;
> +	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
> +	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
> +	atu.size = SZ_1M;
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (ret)
> +		return ret;
> +
> +	bus_range_max = resource_size(bus->res);
> +
> +	if (bus_range_max < 2)
> +		return 0;
> +
> +	/* Configure remaining buses in type 1 iATU configuration */
> +	atu.index = 1;
> +	atu.type = PCIE_ATU_TYPE_CFG1;
> +	atu.parent_bus_addr = pp->cfg0_base + SZ_2M;
> +	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +
> +	return dw_pcie_prog_outbound_atu(pci, &atu);
> +}
> +
> +static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct resource_entry *bus;
> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
> +	if (IS_ERR(pp->cfg))
> +		return PTR_ERR(pp->cfg);
> +
> +	pci->dbi_base = pp->cfg->win;
> +	pci->dbi_phys_addr = res->start;
> +
> +	return 0;
> +}
> +
> +static bool dw_pcie_ecam_enabled(struct dw_pcie_rp *pp, struct resource *config_res)
> +{
> +	struct resource *bus_range;
> +	u64 nr_buses;
> +
> +	/*
> +	 * 256MB alignment is required for Enhanced Configuration Address Mapping (ECAM),
> +	 * as per PCIe Spec 6, Sec 7.2.2. It ensures proper mapping of memory addresses
> +	 * to Bus-Device-Function (BDF) fields in config TLPs.
> +	 *
> +	 * The synopsys iATU also uses bits [27:12] to form BDF, so the base address must
> +	 * be 256MB aligned.
> +	 */
> +	if (!IS_256MB_ALIGNED(config_res->start))
> +		return false;
> +
> +	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
> +	if (!bus_range)
> +		return false;
> +
> +	nr_buses = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
> +
> +	return !!(nr_buses >= resource_size(bus_range));
> +}
> +
>  static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -422,10 +511,6 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>  	struct resource *res;
>  	int ret;
>  
> -	ret = dw_pcie_get_resources(pci);
> -	if (ret)
> -		return ret;
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	if (!res) {
>  		dev_err(dev, "Missing \"config\" reg space\n");
> @@ -435,9 +520,32 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>  	pp->cfg0_size = resource_size(res);
>  	pp->cfg0_base = res->start;
>  
> -	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> -	if (IS_ERR(pp->va_cfg0_base))
> -		return PTR_ERR(pp->va_cfg0_base);
> +	pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
> +	if (pp->ecam_enabled) {
> +		ret = dw_pcie_create_ecam_window(pp, res);
> +		if (ret)
> +			return ret;
> +
> +		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +		pp->bridge->sysdata = pp->cfg;
> +		pp->cfg->priv = pp;
> +	} else {
> +		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);

Now we only set va_cfg0_base when dw_pcie_ecam_enabled() returned
false.  dw_pcie_ecam_enabled() only depends on the "config" resource
alignment and size, which come straight from the devicetree.

Doesn't that mean that other users of va_cfg0_base (keystone and al)
will potentially be broken if their devicetree has a "config" resource
that causes dw_pcie_ecam_enabled() to return true?

> +		if (IS_ERR(pp->va_cfg0_base))
> +			return PTR_ERR(pp->va_cfg0_base);
> +
> +		/* Set default bus ops */
> +		pp->bridge->ops = &dw_pcie_ops;
> +		pp->bridge->child_ops = &dw_child_pcie_ops;
> +		pp->bridge->sysdata = pp;
> +	}
> +
> +	ret = dw_pcie_get_resources(pci);
> +	if (ret) {
> +		if (pp->cfg)
> +			pci_ecam_free(pp->cfg);
> +		return ret;
> +	}
>  
>  	/* Get the I/O range from DT */
>  	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_IO);
> @@ -476,14 +584,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> -	/* Set default bus ops */
> -	bridge->ops = &dw_pcie_ops;
> -	bridge->child_ops = &dw_child_pcie_ops;
> -
>  	if (pp->ops->init) {
>  		ret = pp->ops->init(pp);
>  		if (ret)
> -			return ret;
> +			goto err_free_ecam;
>  	}
>  
>  	if (pci_msi_enabled()) {
> @@ -525,6 +629,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_free_msi;
>  
> +	if (pp->ecam_enabled) {
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
> +			goto err_free_msi;
> +		}
> +	}
> +
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -560,8 +672,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		/* Ignore errors, the link may come up later */
>  		dw_pcie_wait_for_link(pci);
>  
> -	bridge->sysdata = pp;
> -
>  	ret = pci_host_probe(bridge);
>  	if (ret)
>  		goto err_stop_link;
> @@ -587,6 +697,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (pp->ops->deinit)
>  		pp->ops->deinit(pp);
>  
> +err_free_ecam:
> +	if (pp->cfg)
> +		pci_ecam_free(pp->cfg);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_init);
> @@ -609,6 +723,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  
>  	if (pp->ops->deinit)
>  		pp->ops->deinit(pp);
> +
> +	if (pp->cfg)
> +		pci_ecam_free(pp->cfg);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4684c671a81bee468f686a83cc992433b38af59d..6826ddb9478d41227fa011018cffa8d2242336a9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -576,7 +576,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	val = PCIE_ATU_ENABLE;
> +	val = PCIE_ATU_ENABLE | atu->ctrl2;
>  	if (atu->type == PCIE_ATU_TYPE_MSG) {
>  		/* The data-less messages only for now */
>  		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ceb022506c3191cd8fe580411526e20cc3758fed..f770e160ce7c538e0835e7cf80bae9ed099f906c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -20,6 +20,7 @@
>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/reset.h>
>  
>  #include <linux/pci-epc.h>
> @@ -169,6 +170,7 @@
>  #define PCIE_ATU_REGION_CTRL2		0x004
>  #define PCIE_ATU_ENABLE			BIT(31)
>  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> +#define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
>  #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
>  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>  #define PCIE_ATU_LOWER_BASE		0x008
> @@ -387,6 +389,7 @@ struct dw_pcie_ob_atu_cfg {
>  	u8 func_no;
>  	u8 code;
>  	u8 routing;
> +	u32 ctrl2;
>  	u64 parent_bus_addr;
>  	u64 pci_addr;
>  	u64 size;
> @@ -425,6 +428,8 @@ struct dw_pcie_rp {
>  	struct resource		*msg_res;
>  	bool			use_linkup_irq;
>  	struct pci_eq_presets	presets;
> +	bool			ecam_enabled;
> +	struct pci_config_window *cfg;
>  };
>  
>  struct dw_pcie_ep_ops {
> 
> -- 
> 2.34.1
> 

