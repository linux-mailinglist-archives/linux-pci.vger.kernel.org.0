Return-Path: <linux-pci+bounces-16922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865969CF449
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61ED3B28C94
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF41D63E8;
	Fri, 15 Nov 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqDhpNkE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC901D5CD4
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695028; cv=none; b=f24BIb/rgmMzyP9yhX2hRijkLe4/0jr15sY+lbppfiBsLanHbdMnmdMEykamIbVWCn/4D3WtLf5FkW3DCsqe+uusyoLfaRYN7ZNrwGyzleoWD4MCoL2z2DGBAY6AF5vhbDkiL4lcpJ1iwHDFFKzSl3ySiKln2sLihdHBqS71X7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695028; c=relaxed/simple;
	bh=GbWyhc1V4IVmIs1bffftUs21lGGTCqy73H9xpXKKptk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkYWoDIHP+1kKDB+IaYYqtJQTh6d7c0jcMzmjc99IhdsO1bQ+GR6+vpnGcvDzSH4ZDfCzghHnGpiRPOXiVwb7pZ5ZbUDOTpSWLY+2pIYHVf/s3efYjCGhD5jalAW0nGNmFWxFUlZoxGpcSsMDXrEDoEkwScEZwz2bHswAK0o69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iqDhpNkE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2110a622d76so19347415ad.3
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731695026; x=1732299826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1CnwJEhoyWWs0hfunP5nkD+KmYCyarErjrVddNp9cu4=;
        b=iqDhpNkEVQh9qdrYx6ZTewPBF/vO7rOgwfK/E/sgzhXXK24+hYCUTwLZzA3ZZMy+nW
         /1WPrCWeWk/GcnqufrzEbxzirdCBTPKlMc5/ERNjAnwP2p+VjAqNhfu9UiU0PswfMJMA
         Oy1Df0CSXm12o42GxZle8dnUtif8aEUdo6ZfVgLPwo6lUZeepNUQQ+yLElyJIzR6pz2u
         i9eKnb74S6IOjknXOl1/3D9rUh1pvneCL2UB7e3EuUxNEaxGPVRXJ/HfPl+tjy9zuVeb
         ymg1HyfkVTTBD0x9CxE3Ogy54JDE+RakE81s0ay2CXg+zKMz/mPPfUppZt1CuDl22ZO3
         BiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695026; x=1732299826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CnwJEhoyWWs0hfunP5nkD+KmYCyarErjrVddNp9cu4=;
        b=k6ZkqIkf5O2X35xCyg+iDQ9p4aHhFX+FYRXJiRhE0Jm/D05DcT8F7dV/qDOmyTwJ/m
         14LUFVdJkbkdWo5CQKHSqREATTBydI7xutqwKBGdb+Wk9cHO/N9SgcBW+byTaqi1o2vy
         iDtI4+yKvwAPli56/2FJ3NHZkoKN7U8Srsr/O/J1fMiwflPhdfvNqGrDCY5KFLr9JGYt
         sXwCVlX9sWWuc1qNFEHxXBQTcr+WPapS+U7Y+I02OiCigOyb10hMIz9VuHJNBhfPUtu9
         av82fUJSqWdVRpi7ZiOQGrgcBid1JDTCj8yegT3gbj+epWTW/WVOft9M5THhnhpaRdYC
         uszw==
X-Forwarded-Encrypted: i=1; AJvYcCWlue3ED1Irt4z67gWTXiNlxAUsb/l8ZXQutKhO/AE/rSQrkNfWwI4Dx3xcV5Smp9/WtbAETSnVrZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSX9uctX0cb54KkjBQ5Y7nn7aYbaK5SDA03RylDADjhE1lrt0x
	RVN8r4I7EcJOulew0x04gm0ZjGJLj0DMLNIlat+YcSTEME/7V9UR9kWevfUfYw==
X-Google-Smtp-Source: AGHT+IEwWbdg7azduaJi6v/1T3xzOGMgr6uhezauDZeHmiw5GXWdDs8QfnFyhbpVqwXNdilvnfJezQ==
X-Received: by 2002:a17:903:1d0:b0:20e:5792:32ed with SMTP id d9443c01a7336-211d0ebc0c5mr44114045ad.41.1731695026118;
        Fri, 15 Nov 2024 10:23:46 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f51fe0sm15266645ad.233.2024.11.15.10.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:23:45 -0800 (PST)
Date: Fri, 15 Nov 2024 23:53:36 +0530
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
Subject: Re: [PATCH v7 3/7] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <20241115182336.7jy63pt7n66h6pa2@thinkpad>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
 <20241029-pci_fixup_addr-v7-3-8310dc24fb7c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029-pci_fixup_addr-v7-3-8310dc24fb7c@nxp.com>

On Tue, Oct 29, 2024 at 12:36:36PM -0400, Frank Li wrote:
>                    Endpoint
>   ┌───────────────────────────────────────────────┐
>   │                             pcie-ep@5f010000  │
>   │                             ┌────────────────┐│
>   │                             │   Endpoint     ││
>   │                             │   PCIe         ││
>   │                             │   Controller   ││
>   │           bus@5f000000      │                ││
>   │           ┌──────────┐      │                ││
>   │           │          │ Outbound Transfer     ││
>   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
>   ││     │    │  Fabric  │Bus   │                ││PCI Addr
>   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
>   ││     │CPU │          │0x8000_0000            ││
>   │└─────┘Addr└──────────┘      │                ││
>   │       0x7000_0000           └────────────────┘│
>   └───────────────────────────────────────────────┘
> 
> Add 'bus_addr_base' to configure the outbound window address for CPU write.

This doesn't make a lot of sense to readers. Use something like,

"Use 'ranges' property in DT to configure the iATU outbound window address."

> The bus fabric generally passes the same address to the PCIe EP controller,
> but some bus fabrics convert the address before sending it to the PCIe EP
> controller.
> 
> Above diagram, CPU write data to outbound windows address 0x7000_0000,
> Bus fabric convert it to 0x8000_0000. ATU should use bus address
> 0x8000_0000 as input address and convert to PCI address 0xA000_0000.

s/convert/map

> 
> Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
> the device tree provides this information, preferring a common method.
> 
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
> 	pcie-ep@5f010000 {
> 		reg = <0x80000000 0x10000000>;
> 		reg-names ="addr_space";
> 		...
> 	};
> 	...
> };
> 
> 'ranges' in bus@5f000000 descript how address convert from CPU address
> to bus address.
> 
> Use `of_property_read_reg()` to obtain the bus address and set it to the
> ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> 
> Add 'using_dtbus_info' to indicate device tree reflect correctly bus
> address translation in case break compatibility.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> Change from v6 to v7
> - none
> 
> Change from v5 to v6
> - update diagram
> - Add comments for of_property_read_reg()
> - Remove unrelated 0x5f00_0000 in commit message
> 
> Change from v3 to v4
> - change bus_addr_base to u64 to fix 32bit build error
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/
> 
> Change from v2 to v3
> - Add using_dtbus_info to control if use device tree bus ranges
> information.
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 21 ++++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h    |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 43ba5c6738df1..a5b40c32aadf5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -9,6 +9,7 @@
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  
>  #include "pcie-designware.h"
> @@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  
>  	atu.func_no = func_no;
>  	atu.type = PCIE_ATU_TYPE_MEM;
> -	atu.cpu_addr = addr;
> +	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
>  	atu.pci_addr = pci_addr;
>  	atu.size = size;
>  	ret = dw_pcie_ep_outbound_atu(ep, &atu);
> @@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct device *dev = pci->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
> +	int index;
>  
>  	INIT_LIST_HEAD(&ep->func_list);
>  
> @@ -873,6 +875,23 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -EINVAL;
>  
>  	ep->phys_base = res->start;
> +	ep->bus_addr_base = ep->phys_base;
> +
> +	if (pci->using_dtbus_info) {
> +		index = of_property_match_string(np, "reg-names", "addr_space");
> +		if (index < 0)
> +			return -EINVAL;
> +
> +		/*
> +		 * Retrieve the local bus address information, which is sent to
> +		 * the PCIe Endpoint (EP) controller. If the parent bus
> +		 * 'ranges' in the device tree provide the correct address
> +		 * conversion information, set 'using_dtbus_info' to true. This
> +		 * allows 'cpu_addr_fixup()' to be eliminated.
> +		 */

		/*
		 * Get the untranslated bus address from devicetree to use it as
		 * the iATU CPU address in dw_pcie_ep_map_addr().
		 */

- Mani

> +		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
> +	}
> +
>  	ep->addr_size = resource_size(res);
>  
>  	if (ep->ops->pre_init)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f8067393ad35a..f10b533b04f77 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -410,6 +410,7 @@ struct dw_pcie_ep {
>  	struct list_head	func_list;
>  	const struct dw_pcie_ep_ops *ops;
>  	phys_addr_t		phys_base;
> +	u64			bus_addr_base;
>  	size_t			addr_size;
>  	size_t			page_size;
>  	u8			bar_to_atu[PCI_STD_NUM_BARS];
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

