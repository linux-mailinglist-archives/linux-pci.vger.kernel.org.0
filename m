Return-Path: <linux-pci+bounces-6205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D318A3870
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 00:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764391C22314
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 22:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3B39FD5;
	Fri, 12 Apr 2024 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBvZNMhc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458714C593
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712959340; cv=none; b=bQZmIWdrFSxY335Qy3WQt7HwdcVNVUKIFkzN2YAM+89sbUgAPtJghazyIcSYErH7rLz5RYDqhnglhfy4J1woPO17EZs7MaFlujTU6rg06sQSeVJyN+8R5V2RC02N+K3fR8fO/Sgc0Ve/mtRpo5VA2x55Xxzfzl/BFg6lBoBKqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712959340; c=relaxed/simple;
	bh=ocjkvdjpN1yOh232yqtZ4lw0AkNcIVCsY2DeR3aycgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD4LTnxJTSCb5v8B+5kcp+k54csxUFtnCmPnyJxPngnxZWIx8HLY/KpJMAgOKdmxxcrPMWjU5pPWZ6fJrPpYvriUcDyq2eswzJyq27So7CY0+txtsyxEMAiyM0ZzDuzH9fztbBgiAtc3+pdbZLBMZ5nJGicqCHtr/CQctD4oMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBvZNMhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07372C113CC;
	Fri, 12 Apr 2024 22:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712959339;
	bh=ocjkvdjpN1yOh232yqtZ4lw0AkNcIVCsY2DeR3aycgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBvZNMhcZIFVHE1FvgsTOo8/KoF2PbI5Aki6vEaTW6jqxSZVMZOFomYRxTA16Ocv8
	 7xzsL6lgwIewwpijdj3VKUstih/3F8aNXxlKsaBSM532YpTxUmZSIUq+vNBc1hMHJr
	 3gd73wHBEQ6vqqSe9HmxDvDS5ki+BSOnshgLompHsEzQYoTEUsdxZ0XL2ovZ/QLkE9
	 3CtOUJMTPR1EWTJXHRz2g3EuPrQJZUjwaPBxX8gWnepy4IYBBKE46hwH86yMBvl9Zp
	 ZES6+VbB8GxF/fHQvR1GJBvbbgtdUrnFr3WmuffCx7PMWiz7WyGUjhtr+JJ8dm5nxQ
	 kp8hcwDsCZnrA==
Date: Sat, 13 Apr 2024 00:02:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/9] PCI: rockchip-ep: Set a 64-bit BAR if requested
Message-ID: <ZhmvZJg7A11tyh5Q@ryzen>
References: <20240313105804.100168-9-cassel@kernel.org>
 <20240412185901.GA10301@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412185901.GA10301@bhelgaas>

On Fri, Apr 12, 2024 at 01:59:01PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 13, 2024 at 11:58:00AM +0100, Niklas Cassel wrote:
> > ...
> 
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> >  		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
> >  	} else {
> >  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> > -		bool is_64bits = sz > SZ_2G;
> > +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
> >  
> >  		if (is_64bits && (bar & 1))
> >  			return -EINVAL;
> 
> Completely unrelated to *these* patches, but the BAR_CFG_CTRL
> definitions in both cadence and rockchip lead to some awkward case
> analysis:
> 
>   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS              0x4
>   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_32BITS     0x5
>   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_64BITS              0x6
>   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_64BITS     0x7
> 
>   if (is_64bits && is_prefetch)
>           ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
>   else if (is_prefetch)
>           ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
>   else if (is_64bits)
>           ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_64BITS;
>   else
>           ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS;
> 
> that *could* be just something like this:
> 
>   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM           0x4
>   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_64BITS        0x2
>   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH      0x1
> 
>   ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM;
>   if (is_64bits)
>     ctrl |= ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_64BITS;
>   if (is_prefetch)
>     ctrl |= ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH;


If you send the cleanup patches, I will send the Reviewed-by tags ;)


Kind regards,
Niklas

