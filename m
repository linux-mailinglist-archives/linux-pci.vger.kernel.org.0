Return-Path: <linux-pci+bounces-13749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11A498E986
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 07:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F0D1C21142
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CFF3FE55;
	Thu,  3 Oct 2024 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8Wr0n3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B48634
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727934676; cv=none; b=WNjevpbYbbLHPZkjIwEXrW9q0b9sfUZtwuORPpGjMzjryYs1Dt/Ui+lg9+dtYYCd+Sz1+F00mfa+HBL6YHBXxBuGaV2/8/lynWyvv+EV05gn8wNvrJUyvIOlAokpvGEWo00guAWu61l2rfocWuZts5vmsTbtzRIqDpzXjuuYzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727934676; c=relaxed/simple;
	bh=VFmboQ0WFDlCkx5RluuKwpmBTCKDTSlVFQNe17ed6T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNs4VJqNV97X+d6Y5C8rW2pP8wRsE+lOVGuXrk3wsRq4NyGsbeQCR//qwP8CZsUOCyiTyC+iOQgHa0I6LXQyTkh9erqq39Nf891Xw3MPOW9jBb26s1+r83qs8TflYn8zk86KOZZKU9HFEak0aeJhFNdi5d0kWDp2b93TnrPYCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H8Wr0n3n; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so437334a91.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Oct 2024 22:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727934674; x=1728539474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x+I/rurAYPkV9R/iih9/yeq0qeeCIBS1txmeO8x6Thc=;
        b=H8Wr0n3n0eqbienDjsLEJzdGLSHjK19vzW0aYMEnEg4uAsahRBMkbef+m+rAHtCqBM
         ZIjigmvAh5nD5aq2izYasH110RdisuOJ7NnraaYR9Yso8Bevzm8NZasp8mTf5ZPPPmsN
         eNDcdN/gBQKBUC0C5R+cNY+X3p+PJhRnQyMHEy+utlURoLIpZsuV7ThhX6461RSiWc92
         GpkJ43UenBjOPQ5DjHx0Dy+60M1FwG8VO1tHpKmrqHVVOpX401TktTtpKtKyQo8w9Cm8
         ElZO/oI/H025SYyDRcWXLVCjqxQVsJi3+z6EtVv6xWfP/PdIgFG1YGxPv3zF6yqin3RY
         AJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727934674; x=1728539474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+I/rurAYPkV9R/iih9/yeq0qeeCIBS1txmeO8x6Thc=;
        b=E2h0wybeqqLJk/S9v5FHPjJR8Sjbwor5lw/uAc+atEod8mm4cysTA1SQyQbltYGrSA
         90z4TkSNkO9nk7ZnlXzQB9ZkJFWuanCF4uZiZtkHfwym8N5zb5xPnpJm3Nb616XomOpj
         mGd8Kpk0VNZ4SNSsVxyKcBVlr4vAtSJE7K+Y4VPonEFyuwU3D+KNZH3orXnmjv0RbLfV
         c/ca/dox8mSsOJDCB3133iMB+Rf2QZkly5oDkh2WXxrawR/IQfwE7vmP/SnXjhLeiEvF
         dfrYArf9F19uuwijS3+DFOEDd4SlCz00bZY+o9FkAPVYSIEn55i127L5LybTtSpro4qj
         7P+w==
X-Forwarded-Encrypted: i=1; AJvYcCXtJZPFprZRR5KKPE6GGzrDm8QqCb4OuVFRFOZIyFH2CQJy7YNRv0GndX80BnOpLSU4KmH/UMiMmtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJdt08lcXfjY/PS7aF8D5t+kQKcRcvSaHdsNYRGd3lBTTAo0o
	v95b3Q0k83n2x97n+BkjH3KjiEC34HI+l2wU8clAE1SNYvXjhIjVZx5h1rOSLQ==
X-Google-Smtp-Source: AGHT+IH4jjkOJP1RtIXH+LBCTfHZBvB58vRfsRO3uSDukfy6Z2x05FLvSSpdy6l8f7b6/7D4/s/J2A==
X-Received: by 2002:a17:90b:1bc4:b0:2e0:a77e:8305 with SMTP id 98e67ed59e1d1-2e18496a8c7mr6423901a91.39.1727934673666;
        Wed, 02 Oct 2024 22:51:13 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfb2f2dfsm579483a91.31.2024.10.02.22.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:51:13 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:21:06 +0530
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
Subject: Re: [PATCH v3 2/3] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Message-ID: <20241003055106.sm4x23sg4hh67els@thinkpad>
References: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
 <20240930-pci_fixup_addr-v3-2-80ee70352fc7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930-pci_fixup_addr-v3-2-80ee70352fc7@nxp.com>

On Mon, Sep 30, 2024 at 02:44:54PM -0400, Frank Li wrote:
> parent_bus_addr in struct of_range can indicate address information just
> ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> map. See below diagram:
> 
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff0_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► IOSpace   ─┼────────────►
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
> 	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> 		 <0x80000000 0x0 0x70000000 0x10000000>;

Does this address translation apply to all peripherals in the bus or just PCIe?
If it is just PCIe, why can't you encode the mapping in the below PCIe node
'ranges' property itself?

- Mani

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
> Change from v2 to v3
> - %s/cpu_untranslate_addr/parent_bus_addr/g
> - update diagram.
> - improve commit message.
> 
> Change from v1 to v2
> - update because patch1 change get untranslate address method.
> - add using_dtbus_info in case break back compatibility for exited platform.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c72904..823ff42c2e2c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
> +					resource_size_t *i_addr)
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
> @@ -440,6 +469,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->cfg0_size = resource_size(res);
>  		pp->cfg0_base = res->start;
>  
> +		if (pci->using_dtbus_info) {
> +			index = of_property_match_string(np, "reg-names", "config");
> +			if (index < 0)
> +				return -EINVAL;
> +			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
> +		}
> +
>  		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>  		if (IS_ERR(pp->va_cfg0_base))
>  			return PTR_ERR(pp->va_cfg0_base);
> @@ -462,6 +498,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->io_base = pci_pio_to_address(win->res->start);
>  	}
>  
> +	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
> +		return -ENODEV;
> +
>  	/* Set default bus ops */
>  	bridge->ops = &dw_pcie_ops;
>  	bridge->child_ops = &dw_child_pcie_ops;
> @@ -733,6 +772,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		atu.cpu_addr = entry->res->start;
>  		atu.pci_addr = entry->res->start - entry->offset;
>  
> +		if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
> +			return -EINVAL;
> +
>  		/* Adjust iATU size if MSG TLP region was allocated before */
>  		if (pp->msg_res && pp->msg_res->parent == entry->res)
>  			atu.size = resource_size(entry->res) -
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index c189781524fb8..e22d32b5a5f19 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -464,6 +464,14 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	/*
> +	 * Use device tree 'ranges' property of bus node instead using
> +	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
> +	 * reflect real hardware's behavior. In case break these platform back
> +	 * compatibility, add below flags. Set it true if dts already correct
> +	 * indicate bus fabric address convert.
> +	 */
> +	bool			using_dtbus_info;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

