Return-Path: <linux-pci+bounces-22471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A21A46FDA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233173A4F2E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF65A48;
	Thu, 27 Feb 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2xCzwEZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E48F66;
	Thu, 27 Feb 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614899; cv=none; b=VtU2dEWEaRqwgXsG9JuCqllXzuGEikXGrQtVAvXEG8jfT4QFKR3FD5D4U0p/7JbsWK1glwF0LJWgxMyQ+87/C2G2qA1EGWW0FnW6mJfXnjx848ut7Y25ZsWwMBU2S7hVHcaNjX/USZ29KMVVMauiBr8ibBt8PuRicogCVx2gIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614899; c=relaxed/simple;
	bh=xgs7rT60JFXEHjg9mQodKhFyFx8CjHFlo+z0Izl+sPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oDP806idcKop+jYjqlry9XFZ7gPpsqZe1CiA5LFvTv0eMKYTfTuTWaPu0OKPg0GB4yjIQOL8JVqK2T9b0SsVOxq314NTSS9TSjqA9Z/UK7JZi0q2A2JQngHSk3q3nxor8xQ4LhNu31LdIiwoa1fSqabdrIdyqXaQZUbfIh5Ng68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2xCzwEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC32FC4CED6;
	Thu, 27 Feb 2025 00:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740614898;
	bh=xgs7rT60JFXEHjg9mQodKhFyFx8CjHFlo+z0Izl+sPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g2xCzwEZWvRK21RHGuJr1sXCfA+YRAmrbtRAF4GdHDCVQ3wVOMp9umP4H7FarbFdq
	 7frYHCCegvUG0mb37YjiDdZI3TS/JXMRQoy8q3nP8xTtrzv/gKad+G/LeFkkA1GdFq
	 +Xb/QGPx2cFkpgnS1M0vlAOmhAYWCMBFnU2lez3G/iFcVyxa7KOkyiINv+WN2gLZOZ
	 3iXL2RslMqWfH1h/qfcGQk7RDLA0bYR35kyCAplYb7xyeHFgDhnBDatEcCUXqJi1Ug
	 vIXiULOxDdWv9Ye3W2luRCJb+zAmf0jgS7eqPIm2IKSwpg2PlAXAvDncAFh4R3rhSd
	 +wcSfEiHPTm/Q==
Date: Wed, 26 Feb 2025 18:08:17 -0600
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
Subject: Re: [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
Message-ID: <20250227000817.GA565171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com>

On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> Introduce `parent_bus_offset` in `resource_entry` and a new API,
> `pci_add_resource_parent_bus_offset()`, to provide necessary information
> for PCI controllers with address translation units.
> 
> Typical PCI data flow involves:
>   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
>   PCI Controller (PCI bus address) -> PCI Bus.
> 
> While most bus fabrics preserve address consistency, some modify addresses
> to intermediate values. 

s/modify/translate/

Specifically, they *translate* addresses, which means the same offset
is added to every address in the range, as opposed to masking or some
other transformation.

I think we can take advantage of this to simplify the callers of
.cpu_addr_fixup() later.

Ironically, most of the .cpu_addr_fixup() implementations *do* mask
the address, e.g., cdns_plat_cpu_addr_fixup() masks with 0x0fffffff.
But I think this is actually incorrect because masking results in a
many-to-one mapping, e.g.,

  0x42000000 & 0x0fffffff == 0x02000000
  0x52000000 & 0x0fffffff == 0x02000000

But presumably the addresses we pass to cdns_plat_cpu_addr_fixup()
don't cross a 256MB (0x10000000) boundary, so we could accomplish the
same by subtracting 0x40000000:

  0x42000000 - 0x40000000 == 0x02000000

> +++ b/drivers/pci/of.c
> @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			res->flags &= ~IORESOURCE_MEM_64;
>  		}
>  
> -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> +		/*
> +		 * IORESOURCE_IO res->start is io space start address.
> +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> +		 * same as range.cpu_addr.
> +		 *
> +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> +		 */
> +
> +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> +						   range.cpu_addr - range.parent_bus_addr);

Wrap to fit in 80 columns like the rest of the file.  Will have to
unindent the two lines of arguments to make this work.

