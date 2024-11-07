Return-Path: <linux-pci+bounces-16273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 346509C0C14
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 18:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30EB1F2318E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD473216211;
	Thu,  7 Nov 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh23v4IK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7521315B;
	Thu,  7 Nov 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998810; cv=none; b=qQRaozqSpHyuZ0Nlg9qq6zv0+YyJ8zPoTnSgcVxlECRr8k+9kV7XR615P0FCw1f/GQCJ+f6nSELPCcim6AOqjzVYyovPfGJpf4lyrDKTYtGbOV3Ej/NUPNhzuSDhUBQRsBZpqwB674DLyfQjrgnOu6S6NbhK4tmR6dI3qQ9Vwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998810; c=relaxed/simple;
	bh=LxlQsyn16YGpTarQqk1LdGdxRMkwoMFrL36XAWtSuzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lae47DXx37WARMr74zO6e9iohKH1fWs+cQO4bvuB+G/VE1odee/XADVTFjIxrpMkM1zh2KmE7E9XDlhpfjTYm6LwVtJQ17dVpdK7Zrq+O3/zL5s1ANapr/UqNoycFdERgvn+PN/ZQUdizvizfHInULgKw//pwaLiMTyTlVArKYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh23v4IK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2273DC4CECC;
	Thu,  7 Nov 2024 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730998810;
	bh=LxlQsyn16YGpTarQqk1LdGdxRMkwoMFrL36XAWtSuzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qh23v4IK6diLbyoPZVVoeajvDEI3N5TNXcreMxWkyj7+VOSBaLFTZeGnIlWmGpLrD
	 IwG/iN4uj3Bq2/KFE0j+1GWYLuQoivwBqbSIKsoGzSytFsmJm4fWklCMZiBrKjCMe+
	 sh9IL5btYLTqPIenPELF/NeoboymXm2Hnwfu7udISwEwDaOWkEupCufJr8WHUm8m+z
	 z4uBMGLe4/o6RCwXIgTEilQpgsFiBVriAP6kE3Q6stX+QcOHeXUS2UZg3gono0TFIQ
	 9f8ZJ3H4VxD4UTUlCSSJsZNEXncOSpCIivbDK+Qxowq/FUa/uuJqPfIfgnUxdFj+GL
	 8aw9tDwz5QxHw==
Received: by pali.im (Postfix)
	id 4757AB94; Thu,  7 Nov 2024 18:00:02 +0100 (CET)
Date: Thu, 7 Nov 2024 18:00:02 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use for_each_of_range() iterator for parsing
 "ranges"
Message-ID: <20241107170002.wz7wkqmtyqiiaswl@pali>
References: <20241107153255.2740610-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107153255.2740610-1-robh@kernel.org>
User-Agent: NeoMutt/20180716

On Thursday 07 November 2024 09:32:55 Rob Herring (Arm) wrote:
> The mvebu "ranges" is a bit unusual with its own encoding of addresses,
> but it's still just normal "ranges" as far as parsing is concerned.
> Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> instead of open coding the parsing.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Compile tested only.

I see no reason for such change, which was even non tested at all and
does not fix any issue. There are more important issues in the driver,
it was decided that bug fixes are not going to be included (yet).

> ---
>  drivers/pci/controller/pci-mvebu.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 29fe09c99e7d..d4e3f1e76f84 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1179,37 +1179,29 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>  			      unsigned int *tgt,
>  			      unsigned int *attr)
>  {
> -	const int na = 3, ns = 2;
> -	const __be32 *range;
> -	int rlen, nranges, rangesz, pna, i;
> +	struct of_range range;
> +	struct of_range_parser parser;
>  
>  	*tgt = -1;
>  	*attr = -1;
>  
> -	range = of_get_property(np, "ranges", &rlen);
> -	if (!range)
> +	if (of_pci_range_parser_init(&parser, np))
>  		return -EINVAL;
>  
> -	pna = of_n_addr_cells(np);
> -	rangesz = pna + na + ns;
> -	nranges = rlen / sizeof(__be32) / rangesz;
> -
> -	for (i = 0; i < nranges; i++, range += rangesz) {
> -		u32 flags = of_read_number(range, 1);
> -		u32 slot = of_read_number(range + 1, 1);
> -		u64 cpuaddr = of_read_number(range + na, pna);
> +	for_each_of_range(&parser, &range) {
>  		unsigned long rtype;
> +		u32 slot = upper_32_bits(range.bus_addr);
>  
> -		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
> +		if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
>  			rtype = IORESOURCE_IO;
> -		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
> +		else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
>  			rtype = IORESOURCE_MEM;
>  		else
>  			continue;
>  
>  		if (slot == PCI_SLOT(devfn) && type == rtype) {
> -			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
> -			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
> +			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
> +			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
>  			return 0;
>  		}
>  	}
> -- 
> 2.45.2
> 

