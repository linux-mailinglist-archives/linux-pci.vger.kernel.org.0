Return-Path: <linux-pci+bounces-24054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEAFA67817
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D05188484F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD351A01B9;
	Tue, 18 Mar 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXfwIEJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943620CCDB;
	Tue, 18 Mar 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312302; cv=none; b=i67RCpJEJn0qkUyaeIUBEct2KvSOTosZUwhY3O/92L8LhM9qu0GzQM/01fEhioMC3P2kebMdf6M1iiAw5AB7kQFm0cfCDk9tKjMWescMRHrPQi8AHqlzfLd4WWn98F5eJLukPbZF3Y5bQrGQUFQf83cZYKvtN2rolZmR0Dni00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312302; c=relaxed/simple;
	bh=6vRe1xGHKinnOHibJbE9BRfIfB0P0VJZl7MqbD8QsEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pkb330dx67jppKnDeIB7uwmA7SzA1O+nIpC6/Ju4h+x8RBCI9pf6FME+QQ7x4XKL9fePeZ+yAcOlMhISEjCmKONURMV3Y667oqrzNJ2b9QBwjWj/ZTUPVF5hRiEubebWT9rtoINzJltEgmP6i2EMeqRn31OYFVwq6AJja9uY+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXfwIEJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF5CC4CEDD;
	Tue, 18 Mar 2025 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742312302;
	bh=6vRe1xGHKinnOHibJbE9BRfIfB0P0VJZl7MqbD8QsEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bXfwIEJS6+zd+bIaOwENgY7nfrSmKdgrBe2vvcpdJKbJrb5Jqaf2uWbOkRjUHuWdF
	 D4tvgE0rYDylQTxTJEYGj1hZJi7olHZJa53jvDS3hpLFZwMJAYn2RsA3VxwDV2vap0
	 H4ch1ym4qQw1E2Tj+VivqRg9OE7TbeR6RDCT5lKjXHqgG+u1otXcTSX3h0sNcvp6E7
	 jGwxT2q8nX8H/d5k89z1REfl/AOMKY1e8eCT+OZ2IWok3EFV20IspXV5/AIVqX9vrZ
	 qBuv3xKvbQx1LJdpgbol0l4+isOkbxRnPsYKHydgj7XpEB4GTKE1tiVvTZVA0yKdUw
	 9zr0WU38KpOGg==
Date: Tue, 18 Mar 2025 10:38:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <20250318153820.GA1001146@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315201548.858189-7-helgaas@kernel.org>

On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> is a hard-coded way to get the parent bus address corresponding to a CPU
> physical address.
> 
> Add debug code to compare the address from .cpu_addr_fixup() with the
> address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> redundant and should be removed; if they differ, warn that something is
> wrong with the devicetree.
> 
> If .cpu_addr_fixup() is not implemented, the parent bus address should be
> identical to the CPU physical address because we previously ignored the
> parent bus address from devicetree.  If the devicetree has a different
> parent bus address, warn about it being broken.

> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	int index;
> -	u64 reg_addr;
> +	u64 reg_addr, fixup_addr;
> +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
>  
>  	/* Look up reg_name address on parent bus */
>  	index = of_property_match_string(np, "reg-names", reg_name);
> @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  
>  	of_property_read_reg(np, index, &reg_addr, NULL);
>  
> +	fixup = pci->ops->cpu_addr_fixup;
> +	if (fixup) {
> +		fixup_addr = fixup(pci, cpu_phy_addr);
> +		if (reg_addr == fixup_addr) {
> +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",

On second thought, I think this one should be a dev_info(), not a
dev_warn().  We know the *current* devicetree describes the offset
correctly, but there may be other devicetrees that do not describe it,
and we need to keep .cpu_addr_fixup() for those other devicetrees.

So there's nothing the current user can or should do about this.

> +				 cpu_phy_addr, reg_name, index,
> +				 fixup_addr, fixup);
> +		} else {
> +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> +				 cpu_phy_addr, reg_name,
> +				 index, fixup_addr);
> +			reg_addr = fixup_addr;
> +		}
> +	} else if (!pci->use_parent_dt_ranges) {
> +		if (reg_addr != cpu_phy_addr) {
> +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> +				 cpu_phy_addr, reg_addr);
> +			return 0;
> +		}
> +	}
> +
> +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> +		 reg_name, cpu_phy_addr - reg_addr);
>  	return cpu_phy_addr - reg_addr;
>  }

