Return-Path: <linux-pci+bounces-35274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E05B3E620
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79573B4EB4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BEA338F44;
	Mon,  1 Sep 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/oc0JM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE171C27;
	Mon,  1 Sep 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734771; cv=none; b=mnD51KusPD3isbpwKvWpjtOnmB3BXhFyjeXbwnHViauvZA3IOWJssjlgO5KzyB5gDqURKAIipLOf5MwVoLCNkZCtoXOi1tYDLXHgt3zEYhWFo8bvjZomtbs2XLj8oljCqkK722ntnS360jzd74VbbAXfCMLbhkM1rOrjo+ADV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734771; c=relaxed/simple;
	bh=1Sg3rEDoWH1KaBimTkP2BT3g0Ey6+WD6VuLXedDw65k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5UgiMoCL37U8fvpQjTVKRAw19UGkaQIqVeCZpcd2HruW5dKniuPSIxoZE6NR82Lyy4z8VXjwysYgfhnLpvQ+tTujjsKUOCPiuRyMr7wUPGGdenb0FELPY6d1cj4oITdxRMOxVVJ1UddGxGMV7/dVtiJAKSFSZ+IYrptBaBUDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/oc0JM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAC1C4CEF0;
	Mon,  1 Sep 2025 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734770;
	bh=1Sg3rEDoWH1KaBimTkP2BT3g0Ey6+WD6VuLXedDw65k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/oc0JM0tTl36NdYr+audgnhtIlSV9TinPArKRXNuXe+nTDoaoPDXyX1fa0yle0Hb
	 Nrdy0UpyFr65t2jpQrS/EEnyQ51+hdjwruZgDSVgLdhEju20IEAlJWbTIjdjwTNPQr
	 6urywwJlXvO/DAUDt+kTeS/ZChAxe+qddCYrH8WhXnYNvjacdMVu15JBVb875ceWdm
	 HwNxKLDwC5OZDwxVf/uW7qk1vtkPxVTaoY7Fw29bHuL71KljseqHG4rPEfEsJzIcpP
	 X8EiL26zXxkx62ZYSVfvcr/7HyoviK6tJLul5vpqYOfrqDPXC5ZhQdGjND5ct8PK0v
	 EUxjtuldSxGiw==
Date: Mon, 1 Sep 2025 19:22:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com, mmareddy@quicinc.com
Subject: Re: [PATCH v8 4/5] PCI: dwc: Add ECAM support with iATU configuration
Message-ID: <camqcq72cy774st365jtodvckqvohzlu2fsklsgpfrgaxzz6re@yk6rvt6vq5y5>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <20250828-ecam_v4-v8-4-92a30e0fa02d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250828-ecam_v4-v8-4-92a30e0fa02d@oss.qualcomm.com>

On Thu, Aug 28, 2025 at 01:04:25PM GMT, Krishna Chaitanya Chundru wrote:
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

I've reworded the comment and description to clarify that the alignment
requirement comes from the PCIe spec, but the 256 MiB requirement comes from DWC
implementation since DWC always uses 8 bits for representing PCIe buses.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

