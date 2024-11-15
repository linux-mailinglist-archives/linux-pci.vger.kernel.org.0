Return-Path: <linux-pci+bounces-16915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8769CF394
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C76B2C7E8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F741D63C5;
	Fri, 15 Nov 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZzArRzj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD61D61A1
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693120; cv=none; b=COhzMk5mQ42w/rvm9JVAtUC5B4qruSwf9UaWoG8EqLgnAo4tYLH7YToVGI6ylN+BEMh+j5XzVZbEXOEpKEk/aisDx9xX+jfjRUdfmGqB/KbMOHqozoqmEcPuQqR//2mNStgJQDasChG1dsbmUiTap06vEW1RSGyG67efLWPsFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693120; c=relaxed/simple;
	bh=09hYKCgXyDUZhuZQR4UkViK/zC1/odV9u3WUWthEMVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIHiDVoKMCK3NWtG2PlWILCHPTgSSkPtn/SMAAUy1AhqoTe5XwzOCIppc9fuljE9X966wvGATli7LB6SzQvGOZ+MedQg29PlShRoIVxcfew5elRyVQK50N37GoHYudAA5BqMdM/EHi5ZMj16lYHlnXD2IZ22/1MT9zPEDfJ8Da4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DZzArRzj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21145812538so17399455ad.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731693118; x=1732297918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HsIDulqPVm11kvME4lSY/OQMyOCr+gV0M7N3MMcJtZE=;
        b=DZzArRzjpv+EzQ+Dd0SnZz1mUJeC/aINbsFGuspjjcZzODFNwTE7qEXWWBhI7+PzQR
         XfVX+NaAXdqSPM/s1sNxM1pcvwCOqjZeg+9a9mpHsoVt9J9TQday8GDbgzaOS8usoMIJ
         cJYa+rreLAeJL/FpgbXgDHITH+d+4RftPjFBNTykik3CjyVdoywNvA83/kPowqJEaQIF
         EPn30NwmuOQJEPqiFW0N8o87b+FMcDSqiXcqa++X7sofjmBdvR4Jj/yqn78oOPvIzCBK
         S6K/DrVUf0grGI6ctsImb3TzZI1efFOowv/QlJxjvsU4VIEB3GsAj/k19ukT4Jm6jRWg
         PvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693118; x=1732297918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsIDulqPVm11kvME4lSY/OQMyOCr+gV0M7N3MMcJtZE=;
        b=SojA8/BU+zR6C0CCdYjMN4sHB8MpkqklBJR1zCy/Fmqzrosvp/w1aPhlXhKWn1HbT6
         e1tBLs+Sgf8kbJD/68WW5rWD1JYjodb4FJWpbZjoGNiaQIpb+Re7v8NAFBg3ovorGDIC
         YHypfAi9Nzu8gzQ4r+aGKK5FLyZW5bMqxDd6OZVxYi5gaPcBBocEyvXvcGmkWIegtPyn
         Cggbirsf7SqXYXADqBggs8KQza1vlBDFujpvfjqYWBlXwoS7zt7xOzzLk+olL8cpEFtL
         Wp5NhjiV/UuCrH2DFYXQtxlN96Qv7FdTjePW4u5S4gjsFSO/YcH4VOJ4yYwZ6+huRceQ
         4yFA==
X-Forwarded-Encrypted: i=1; AJvYcCWFbtRVroyEzM5HUjYCqHAhXJ88QGReq1wODj0nIMpvSgwkI1wRCohC0aWTxV9OoE5gbKAs7HytJWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDcp07dVa9Jkhm8Zgb0gMFyQ9kAGrZ6/ZSaGYlD1dAnJi+Yfi
	eHXAuucLNsvCgRm7QWnuDlTfIXubfT7obx7mi0X5xIkbPoTWo8BeHw9YMMW7Kg==
X-Google-Smtp-Source: AGHT+IEo8KIx+IDClFIGzyYawx9wyWhggQfWSS3I5L/7qTi+6XFaoyQ//P5mcasYulpv7qLH/9m62A==
X-Received: by 2002:a17:902:d4ca:b0:20c:f3cf:50e6 with SMTP id d9443c01a7336-211d0ebc492mr54783415ad.38.1731693118199;
        Fri, 15 Nov 2024 09:51:58 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e9d0c389sm793705ad.161.2024.11.15.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 09:51:57 -0800 (PST)
Date: Fri, 15 Nov 2024 23:21:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v7 2/7] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Message-ID: <20241115175148.tqzqiv53mccz52tq@thinkpad>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
 <20241029-pci_fixup_addr-v7-2-8310dc24fb7c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029-pci_fixup_addr-v7-2-8310dc24fb7c@nxp.com>

On Tue, Oct 29, 2024 at 12:36:35PM -0400, Frank Li wrote:

Please reword the subject as:

PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback

> parent_bus_addr in struct of_range can indicate address information just
> ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> map. See below diagram:
> 
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff8_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
> 
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
> 	pcie@5f010000 {
> 		compatible = "fsl,imx8q-pcie";
> 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> 		reg-names = "dbi", "config";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		device_type = "pci";
> 		bus-range = <0x00 0xff>;
> 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> 	...
> 	};
> };
> 
> Term internal address (IA) here means the address just before PCIe
> controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> be removed.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Add a resource_size_t parent_bus_addr local varible to fix 32bit build
> error.
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
> 
> Chagne from v5 to v6
> -add comments for of_property_read_reg().
> 
> Change from v4 to v5
> - remove confused 0x5f00_0000 range in sample dts.
> - reorder address at above diagram.
> 
> Change from v3 to v4
> - none
> 
> Change from v2 to v3
> - %s/cpu_untranslate_addr/parent_bus_addr/g
> - update diagram.
> - improve commit message.
> 
> Change from v1 to v2
> - update because patch1 change get untranslate address method.
> - add using_dtbus_info in case break back compatibility for exited platform.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 55 ++++++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++
>  2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c72904..ea01b7bda0a76 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
> +					resource_size_t *i_addr)

dw_pcie_get_parent_addr()? Since this function is anyway reading the parent
address from DT.

> +{
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
> +	struct of_range_parser parser;
> +	struct of_range range;
> +	int ret;
> +
> +	if (!pci->using_dtbus_info) {
> +		*i_addr = pci_addr;
> +		return 0;
> +	}
> +
> +	ret = of_range_parser_init(&parser, np);
> +	if (ret)
> +		return ret;
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		if (pci_addr == range.bus_addr) {
> +			*i_addr = range.parent_bus_addr;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct resource_entry *win;
>  	struct pci_host_bridge *bridge;
>  	struct resource *res;
> +	int index;
>  	int ret;
>  
>  	raw_spin_lock_init(&pp->lock);
> @@ -440,6 +469,20 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->cfg0_size = resource_size(res);
>  		pp->cfg0_base = res->start;
>  
> +		if (pci->using_dtbus_info) {
> +			index = of_property_match_string(np, "reg-names", "config");
> +			if (index < 0)
> +				return -EINVAL;
> +			/*
> +			 * Retrieve the parent bus address of PCI config space.
> +			 * If the parent bus ranges in the device tree provide
> +			 * the correct address conversion information, set
> +			 * 'using_dtbus_info' to true, The 'cpu_addr_fixup()'
> +			 * can be eliminated.
> +			 */

Nobody will switch to 'ranges' property if you mention it in comments. We
usually add dev_warn_once() to print a warning for broken DT so that the users
will try to fix it. You can use below diff (as a separate patch ofc):

```
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c..d1e5395386fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -844,6 +844,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
                 dw_pcie_cap_is(pci, IATU_UNROLL) ? "T" : "F",
                 pci->num_ob_windows, pci->num_ib_windows,
                 pci->region_align / SZ_1K, (pci->region_limit + 1) / SZ_1G);
+
+       if (pci->ops && pci->ops->cpu_addr_fixup)
+               dev_warn_once(pci->dev, "Broken \"ranges\" property detected. Please fix DT!\n");
 }
 
 static u32 dw_pcie_readl_dma(struct dw_pcie *pci, u32 reg)
```

> +			of_property_read_reg(np, index, &pp->cfg0_base, NULL);

Can you explain what is going on here?

> +		}
> +
>  		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>  		if (IS_ERR(pp->va_cfg0_base))
>  			return PTR_ERR(pp->va_cfg0_base);
> @@ -462,6 +505,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->io_base = pci_pio_to_address(win->res->start);
>  	}
>  
> +	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
> +		return -ENODEV;

Use actual return value here and below.

> +
>  	/* Set default bus ops */
>  	bridge->ops = &dw_pcie_ops;
>  	bridge->child_ops = &dw_child_pcie_ops;
> @@ -722,6 +768,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +		resource_size_t parent_bus_addr;
> +
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>  
> @@ -730,9 +778,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  
>  		atu.index = i;
>  		atu.type = PCIE_ATU_TYPE_MEM;
> -		atu.cpu_addr = entry->res->start;
> +		parent_bus_addr = entry->res->start;
>  		atu.pci_addr = entry->res->start - entry->offset;
>  
> +		if (dw_pcie_get_untranslate_addr(pci, entry->res->start, &parent_bus_addr))
> +			return -EINVAL;
> +
> +		atu.cpu_addr = parent_bus_addr;
> +
>  		/* Adjust iATU size if MSG TLP region was allocated before */
>  		if (pp->msg_res && pp->msg_res->parent == entry->res)
>  			atu.size = resource_size(entry->res) -
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35aa..f8067393ad35a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -463,6 +463,14 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	/*
> +	 * Use device tree 'ranges' property of bus node instead using
> +	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
> +	 * reflect real hardware's behavior. In case break these platform back
> +	 * compatibility, add below flags. Set it true if dts already correct
> +	 * indicate bus fabric address convert.

	/*
	 * This flag indicates that the vendor driver uses devicetree 'ranges'
	 * property to allow iATU to use the Intermediate Address (IA) for
	 * outbound mapping. Using this flag also avoids the usage of
	 * 'cpu_addr_fixup' callback implementation in the driver.
	 */

> +	 */
> +	bool			using_dtbus_info;

'use_dt_ranges'?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

