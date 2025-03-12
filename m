Return-Path: <linux-pci+bounces-23545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B8DA5E72A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 23:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B933BAE6E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188321EF370;
	Wed, 12 Mar 2025 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acqC/clq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7A1EEA40;
	Wed, 12 Mar 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817788; cv=none; b=aIial9TegqGycj8flP+iFmBv0tatLjs+1nGboUKfdMOQmlww1XMH8LOtVbVg9KLnTHYCYDFupeItSB1fG9btGqsT/LGIGccsD8D1pDTpDqrxnMLXNws1Ngn6B9Q5TB3qOd7FjkSs0PMnWLVW+c/AtYS4IElSt20J/CSJdQAsdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817788; c=relaxed/simple;
	bh=vkr3KopYdWUircBEEhav2hH+I7B84ECNwkPnSpSsVCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ukKZpMigVtbwTAfNrOutPCd4IMosx4Ga2BGP80Y/+8sDb7B0pQRsfW76wfe1wJK5e0FJ4eh5gxCbi2SToAr06+ND1Y/awL8XJ64YT939Wda/056EucpJ8Aggxq+0RchQRbF1E50q1pq4wzUZFXC3yeLCnN44mY3taHfEtV5sTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acqC/clq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E89C4CEDD;
	Wed, 12 Mar 2025 22:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741817787;
	bh=vkr3KopYdWUircBEEhav2hH+I7B84ECNwkPnSpSsVCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=acqC/clqSUvbGHLoM6HoKK3d+FnFC5UsLEm/ESofPeZh4zRHSzxQ8xZEwpyEwa+UE
	 jCDXndb9lcYvm38L+aHEmjl7AH1nJ7wY5UHJGZI1WmNBaseG2KnH+QJ6I53vDtwBVA
	 XuSguY4U+5wmTqZIYYBHQ3ptELul5IR/8DtVlVbcpuVe/V2UxSrxA12AnXPt+ogIim
	 n/wD0cM0OnqpyqotCR6b1AopO0XXa6cKiYgpYweKJQ5U8RZnKeuCWN8jun0j3RD1LW
	 mKlNEHtDpGI+8pmm8XHLK76mBYiPX9h8vFyWBk/fA3c5yotJxMPU2gOLetbVN5Z13F
	 em3cPp2n4qqHA==
Date: Wed, 12 Mar 2025 17:16:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v10 04/10] PCI: dwc: Add helper
 dw_pcie_init_parent_bus_offset()
Message-ID: <20250312221625.GA711258@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-pci_fixup_addr-v10-4-409dafc950d1@nxp.com>

On Mon, Mar 10, 2025 at 04:16:42PM -0400, Frank Li wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Set pci->parent_bus_offset based on the parent bus address from the
> "config" (Root complex mode) and "addr_space" (Endpoint mode).
> 
> .cpu_addr_fixup(cpu_phy_addr). (if implemented) should return the parent
> bus address corresponding according to cpu_phy_addr.
> 
> Sets pp->parent_bus_offset, but doesn't use it, so no functional change
> intended yet.
> 
> Add use_parent_dt_ranges to detect some fake bus translation at platform,
> which have not .cpu_addr_fixup(). Set use_parent_dt_ranges true explicitly
> at platform that have .cpu_addr_fixup() and fixed DTB's range. If not one
> report "fake bus translation" for sometime, this flags can be removed
> safely.

> +int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
> +				   resource_size_t cpu_phy_addr)
> +{
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
> +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> +	u64 reg_addr, fixup_addr;
> +	int index;
> +
> +	/* Look up reg_name address on parent bus */
> +	index = of_property_match_string(np, "reg-names", reg_name);
> +
> +	if (index < 0) {
> +		dev_err(dev, "Missed reg-name: %s, Broken DTB file\n", reg_name);
> +		return -EINVAL;
> +	}
> +
> +	of_property_read_reg(np, index, &reg_addr, NULL);
> +
> +	fixup = pci->ops->cpu_addr_fixup;
> +	if (fixup) {
> +		fixup_addr = fixup(pci, cpu_phy_addr);
> +		if (reg_addr == fixup_addr) {
> +			dev_info(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> +				 cpu_phy_addr, reg_name, index,
> +				 fixup_addr, fixup);
> +		} else {
> +			dev_warn_once(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; DT is broken\n",
> +				      cpu_phy_addr, reg_name,
> +				      index, fixup_addr);
> +			reg_addr = fixup_addr;
> +		}
> +	} else if (!pci->use_parent_dt_ranges) {
> +		if (reg_addr != cpu_phy_addr) {
> +			dev_warn_once(dev, "Your DTB try to use fake translation, Please check parent's ranges property,");
> +			return 0;

IIUC the point of this is to catch a DT that describes a non-zero
offset when the driver did not implement .cpu_addr_fixup() and
therefore assumed "reg_addr == cpu_phy_addr".

I guess that makes sense.  But I think we should include both
addresses in the message to help understand the issue.

> +		}
> +	}
> +
> +	pci->parent_bus_offset = cpu_phy_addr - reg_addr;
> +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> +		 reg_name, pci->parent_bus_offset);
> +
> +	return 0;
> +}

> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -465,6 +466,16 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	/*
> +	 * This flag indicates that the vendor driver uses devicetree 'ranges'
> +	 * property to allow iATU to use the Intermediate Address (IA) for
> +	 * outbound mapping. Using this flag also avoids the usage of
> +	 * 'cpu_addr_fixup' callback implementation in the driver.

This part of the comment is now wrong.

> +	 * If use_parent_dt_ranges is false, warning will print if IA is not
> +	 * equal to cpu physical address. Indicate dtb use a fake translation.
> +	 */
> +	bool			use_parent_dt_ranges;
>  };

