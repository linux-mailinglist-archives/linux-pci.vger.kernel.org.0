Return-Path: <linux-pci+bounces-35688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEFFB49A43
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB74165E6C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D79227F4D5;
	Mon,  8 Sep 2025 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBIgm7AC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877E1A255C;
	Mon,  8 Sep 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360676; cv=none; b=PMbLxYNFnFUj4AVLO8ruYFnpC9s6p0frWRcuyDq3HgYICiOPS/qzkJycxUudVcAXYp9pCLsqa+UbMD3LhMAXWrXtCaikkTJIfCZ4eX4jw2XgICmUGaay2rRgq41picYPaz2udqPSWlAWcRxONRCiVqGffq8cTg10cPJuweTB4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360676; c=relaxed/simple;
	bh=o/DTnsN33P7EIb8svR5PswkHMaTvVF4k4Q5vDtNgxPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UPRUgsU8fiUuipJiAmOR16XnRcCdhQATP/ReihJAMb8MkRoSOuW4vD7ELWvaB6PgBoaRZqt6dqNUNVtKNxiDX4cFJG+No7egxTwCl4xaOKlJLZqAvYPXUi3UB5O9tVoT5w83sUEPiZtcJtWfFk0E/tDlMNTLSOYGPDAZdHTxJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBIgm7AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A808C4CEF1;
	Mon,  8 Sep 2025 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757360676;
	bh=o/DTnsN33P7EIb8svR5PswkHMaTvVF4k4Q5vDtNgxPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RBIgm7ACPdwtYByH86t0ZrIf7ELUqsMHKrWCcR4cWQo8QslgZ2EY3frdu5RHNh46M
	 xLGb2Qpm+8GEUZSMugDPXMOzcRiETPeZ1bYHRUiMbNy+gifYsEhpvz8qFFWIMaQUCz
	 GCZuxnIrsZZTCv6fHTr0sWvJLDayjJ1A51t4+fJc9M/MJVML53uNE7yFdPjgek5nuW
	 26QqiwXToR5EmFiLowT/xFfnDI+Vl941ArQcDnvQdTTclwoz04d2f2Z8yxGGirWUeh
	 KBRoGNMR8cAs8UpEP5mCauIussB0K++mPeoa1AeVN9MvBgM7u2oISWg5Q+50GiIUFb
	 yTj89j0efGncA==
Date: Mon, 8 Sep 2025 14:44:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jan Palus <jpalus@fastmail.com>
Subject: Re: [PATCH v2] PCI: mvebu: Fix use of for_each_of_range() iterator
Message-ID: <20250908194434.GA1454201@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907102303.29735-1-klaus.kudielka@gmail.com>

On Sun, Sep 07, 2025 at 12:21:46PM +0200, Klaus Kudielka wrote:
> The blamed commit simplifies code, by using the for_each_of_range()
> iterator. But it results in no pci devices being detected anymore on
> Turris Omnia (and probably other mvebu targets).
> 
> Issue #1:
> 
> To determine range.flags, of_pci_range_parser_one() uses bus->get_flags(),
> which resolves to of_bus_pci_get_flags(). That function already returns an
> IORESOURCE bit field, and NOT the original flags from the "ranges"
> resource.
> 
> Then mvebu_get_tgt_attr() attempts the very same conversion again.
> But this is a misinterpretation of range.flags.
> 
> Remove the misinterpretation of range.flags in mvebu_get_tgt_attr(),
> to restore the intended behavior.
> 
> Issue #2:
> 
> The driver needs target and attributes, which are encoded in the raw
> address values of the "/soc/pcie/ranges" resource. According to
> of_pci_range_parser_one(), the raw values are stored in range.bus_addr
> and range.parent_bus_addr, respectively. range.cpu_addr is a translated
> version of range.parent_bus_addr, and not relevant here.
> 
> Use the correct range structure member, to extract target and attributes.
> This restores the intended behavior.
> 
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> Reported-by: Jan Palus <jpalus@fastmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220479

Applied to for-linus for v6.17, thanks!

> ---
> v2: Fix issue #2, as well.
> 
>  drivers/pci/controller/pci-mvebu.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 755651f338..a72aa57591 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1168,12 +1168,6 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
>  	return devm_ioremap_resource(&pdev->dev, &port->regs);
>  }
>  
> -#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
> -#define    DT_TYPE_IO                 0x1
> -#define    DT_TYPE_MEM32              0x2
> -#define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
> -#define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
> -
>  static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>  			      unsigned long type,
>  			      unsigned int *tgt,
> @@ -1189,19 +1183,12 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>  		return -EINVAL;
>  
>  	for_each_of_range(&parser, &range) {
> -		unsigned long rtype;
>  		u32 slot = upper_32_bits(range.bus_addr);
>  
> -		if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
> -			rtype = IORESOURCE_IO;
> -		else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
> -			rtype = IORESOURCE_MEM;
> -		else
> -			continue;
> -
> -		if (slot == PCI_SLOT(devfn) && type == rtype) {
> -			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
> -			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
> +		if (slot == PCI_SLOT(devfn) &&
> +		    type == (range.flags & IORESOURCE_TYPE_BITS)) {
> +			*tgt = (range.parent_bus_addr >> 56) & 0xFF;
> +			*attr = (range.parent_bus_addr >> 48) & 0xFF;
>  			return 0;
>  		}
>  	}
> -- 
> 2.50.1
> 

