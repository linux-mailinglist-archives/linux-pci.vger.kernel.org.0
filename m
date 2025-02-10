Return-Path: <linux-pci+bounces-21064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D186A2E692
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0DC163C03
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE511B87F4;
	Mon, 10 Feb 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rix57maQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A624198E8C
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176682; cv=none; b=sNtKz/Scba3wY5JvgQKKp/t8V0ndz7TYMTBbU9J/hLvo0gOKj6JP6La808ZDgEcyQUlJYrKtIlu2PKNMIV3DvkypY/WE1Cn1Sob4m9Zf4qHVN2BwkkSBvQEcZ5SVnj/gjQ0/vJHEan/Ar6784eeDC4tjOTSk3tuMJERVuF+ivKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176682; c=relaxed/simple;
	bh=cJCgwBnqhSFSKnh6vWtQ4K51NqjcxPtY771+//9qyJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFZQb7v12GZVRU1fmishU8p6o7YfNATcfXGj5CMScRP1G5PtRFsDLNeTSlP77VD3JDqXmXLcHzICjNaRp5w6Wf1f2y7uWkVxe/+pmGzKAIq5S9Hs2Dj8ryOVJxphfPtFOoZAj4At1ktIRKApNlzwMhSc0Q6OjCUYPj2fn+q+50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rix57maQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f6f18b474so20670155ad.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 00:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739176680; x=1739781480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HSCr6KDY7aSJqcLRlRrnx4f7ZxgsovJM0SoNHsgPSQE=;
        b=rix57maQdagq1+Q5d9f4xqFL7rI/iHNDU/NPDSAy0zG0lueTCSaS8qxWecXHaiJOmH
         tSAOiB/gVzHt1VIKkkecc5dtgEgXmScLLWwmMkMXzRvNj2kAdJqe9xf+nidYZ3CYixye
         N20mx+L8d6oaTRyiYcnqRVZw/6nEKR2aWtHzR0yQ5S8qHx1T7oFoE1809EzM72MoV1u1
         JfNqFqaJwgICqQOdDPFGr3DEatgMxX6mORM7XS1Bl/3Y3nMGYQw46C5EPJ+9lvmPbMkc
         9uTVGfbEvMQjv0QOuY24mEavn00Mlnzezhr3x+yJJ7I/EYYRZjUpMIwrSUcDfX7k693K
         fZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176680; x=1739781480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSCr6KDY7aSJqcLRlRrnx4f7ZxgsovJM0SoNHsgPSQE=;
        b=hjZh0+NGtDpJXt/RA7exXXzaYiUnJzATHZ6LlYarcdBtAPKcGGmARVUaJGMowcSUBx
         JpGgHAGVMulj89KFoiVqWiO2k4lZAA1jiZHFaGIDzWjA43D79OyNrKI+nkI2fZqbYpBS
         BwN6/r0985SDUpilcncDMxd0GEBBZ8rMK9P9MREEze7fVMdRRu0757+GISlr2N6PFIGB
         veNNIS9DrC2jGx/yxgCdzxehs/E3mda9ypRuZePkZ9uT1A0idBq/44uJWprL/bfEy/5w
         HqWMqtozjbTf9dHKrwx+2xhFzlo2GM+h16FbRvb0xjosRuIZ9XD6VLsn42460K4qRpdo
         19Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWRYoiYN3sr4kh4/LLDeuCkbSHmmJLwYiNvk6CMezPGWmaw1P8PawYZ5NjsbbRGPr38JGHdbxBEm64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWJ9TTKmrXXlMrnEOPCIjhv3HxLJ3A5StO8qLGRx74FUrUP5r
	+50vyOods7RN13LfBpJLF6b6E/dt5q3knvlh1hf2s8UtPkzhwA2802eAMR7RhA==
X-Gm-Gg: ASbGncuuyq+ZmD42Krsr4UIFcU2eo0+HG1UnjBweVG9V4YZ1oiZ+NSlEcqPgVP/UmEW
	sFimNz/My6cJ4rt7rwLzW3J/Pprgt5GLp+8O0EeLAeluCTPGyM0uvwrrdTQ2sxR6dXwRgEM2PA8
	6NcEXmWnteKfRFwjGc86aug1TYAsVpFakUXP5MEydhihnZ3zPVFswTlfPMsc16SrR9ai4eRN8yu
	akMGO6EjktHv5spgdto2x9TgazYPvxYFQ08gWSoy6nZMs4zZP0OKseEwzazP0VnxzlDLMQCp17X
	Wmq2I99lNyv0P0zAJRrsi+WPOPRQ
X-Google-Smtp-Source: AGHT+IEq3GC4JT703kBKsDRes4mDoRZKqkC7ITYa7CwPdS9q579MB+nUp7wrrL6Ra7nC2Jm7XLOPow==
X-Received: by 2002:a17:903:234e:b0:216:554a:2127 with SMTP id d9443c01a7336-21f4e7636e1mr234385355ad.41.1739176679730;
        Mon, 10 Feb 2025 00:37:59 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c6bfsm72704405ad.191.2025.02.10.00.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 00:37:59 -0800 (PST)
Date: Mon, 10 Feb 2025 14:07:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v4 2/4] PCI: dwc: Add ECAM support with iATU configuration
Message-ID: <20250210083752.t5rjclerwmmxjhu7@thinkpad>
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
 <20250207-ecam_v4-v4-2-94b5d5ec5017@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ecam_v4-v4-2-94b5d5ec5017@oss.qualcomm.com>

On Fri, Feb 07, 2025 at 04:58:57AM +0530, Krishna Chaitanya Chundru wrote:
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
> to represent number of buses in the bus range property, add a function
> which checks this. The DWC glue drivers uses this function and decide to
> enable ECAM mode or not.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/Kconfig                |   1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c | 133 +++++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      |  11 ++
>  4 files changed, 132 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..73c3aed6b60a 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -9,6 +9,7 @@ config PCIE_DW
>  config PCIE_DW_HOST
>  	bool
>  	select PCIE_DW
> +	select PCI_HOST_COMMON
>  
>  config PCIE_DW_EP
>  	bool
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ffaded8f2df7..826ff9338646 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,66 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
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
> +	 * as DBI space will represent Root bus configuration space.
> +	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
> +	 * remaining buses need type 1 iATU configuration.
> +	 */
> +	atu.index = 0;
> +	atu.type = PCIE_ATU_TYPE_CFG0;
> +	atu.cpu_addr = pp->cfg0_base + SZ_1M;

Why this 1MiB hole needed here? For DBI?

> +	atu.size = SZ_1M;

Add a comment stating that this 1M corresponds to 1 bus, 32 devices and 8
functions. Like,

	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */

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
> +	atu.cpu_addr = pp->cfg0_base + SZ_2M;
> +	atu.size = (SZ_1M * (bus_range_max - 2));

Nit: Use,

	atu.size = (SZ_1M * bus_range_max) - SZ_2M;

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

Why can't we use the existing 'dbi' region?

> +
> +	return 0;
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -431,10 +491,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	raw_spin_lock_init(&pp->lock);
>  
> -	ret = dw_pcie_get_resources(pci);
> -	if (ret)
> -		return ret;
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	if (!res) {
>  		dev_err(dev, "Missing \"config\" reg space\n");
> @@ -444,9 +500,28 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	pp->cfg0_size = resource_size(res);
>  	pp->cfg0_base = res->start;
>  
> -	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> -	if (IS_ERR(pp->va_cfg0_base))
> -		return PTR_ERR(pp->va_cfg0_base);
> +	if (pp->ecam_mode) {
> +		ret = dw_pcie_create_ecam_window(pp, res);
> +		if (ret)
> +			return ret;
> +
> +		bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +		pp->bridge->sysdata = pp->cfg;
> +		pp->cfg->priv = pp;
> +	} else {
> +		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> +		if (IS_ERR(pp->va_cfg0_base))
> +			return PTR_ERR(pp->va_cfg0_base);
> +
> +		/* Set default bus ops */
> +		bridge->ops = &dw_pcie_ops;
> +		bridge->child_ops = &dw_child_pcie_ops;
> +		bridge->sysdata = pp;
> +	}
> +
> +	ret = dw_pcie_get_resources(pci);
> +	if (ret)
> +		return ret;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
> @@ -462,14 +537,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->io_base = pci_pio_to_address(win->res->start);
>  	}
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
> @@ -504,6 +575,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> +	if (pp->ecam_mode) {
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(dev, "Failed to confuure iATU\n");

*configure iATU in ECAM mode

> +			goto err_free_msi;
> +		}
> +	}
> +
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -539,8 +618,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		/* Ignore errors, the link may come up later */
>  		dw_pcie_wait_for_link(pci);
>  
> -	bridge->sysdata = pp;
> -
>  	ret = pci_host_probe(bridge);
>  	if (ret)
>  		goto err_stop_link;
> @@ -564,6 +641,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
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
> @@ -584,6 +665,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  
>  	if (pp->ops->deinit)
>  		pp->ops->deinit(pp);
> +
> +	if (pp->cfg)
> +		pci_ecam_free(pp->cfg);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>  
> @@ -999,3 +1083,24 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> +
> +bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp)

Add Kernel doc since this is an exported API. Clearly mention the requirement
needed (config region size) to support the ECAM mode.

> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct platform_device *pdev = to_platform_device(pci->dev);
> +	struct resource *config_res, *bus_range;
> +	u64 bus_config_space_count;
> +
> +	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
> +	if (!bus_range)
> +		return false;
> +
> +	config_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> +	if (!config_res)
> +		return false;
> +
> +	bus_config_space_count = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
> +
> +	return !!(bus_config_space_count >= resource_size(bus_range));
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_ecam_supported);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 145e7f579072..523ca7f267fb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -509,7 +509,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	val = PCIE_ATU_ENABLE;
> +	val = PCIE_ATU_ENABLE | atu->ctrl2;
>  	if (atu->type == PCIE_ATU_TYPE_MSG) {
>  		/* The data-less messages only for now */
>  		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 501d9ddfea16..d0ba8855ba2a 100644
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
> @@ -171,6 +172,7 @@
>  #define PCIE_ATU_REGION_CTRL2		0x004
>  #define PCIE_ATU_ENABLE			BIT(31)
>  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> +#define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
>  #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
>  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>  #define PCIE_ATU_LOWER_BASE		0x008
> @@ -343,6 +345,7 @@ struct dw_pcie_ob_atu_cfg {
>  	u8 func_no;
>  	u8 code;
>  	u8 routing;
> +	u32 ctrl2;
>  	u64 cpu_addr;
>  	u64 pci_addr;
>  	u64 size;
> @@ -381,6 +384,8 @@ struct dw_pcie_rp {
>  	int			msg_atu_index;
>  	struct resource		*msg_res;
>  	bool			use_linkup_irq;
> +	bool			ecam_mode;
> +	struct pci_config_window *cfg;
>  };
>  
>  struct dw_pcie_ep_ops {
> @@ -686,6 +691,7 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
>  int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
>  void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>  				       int where);
> +bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp);
>  #else
>  static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> @@ -726,6 +732,11 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
>  {
>  	return NULL;
>  }
> +
> +static inline bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp)
> +{
> +	return 0;

return false

- Mani

-- 
மணிவண்ணன் சதாசிவம்

