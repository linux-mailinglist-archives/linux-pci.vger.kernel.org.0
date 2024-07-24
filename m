Return-Path: <linux-pci+bounces-10731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C493B4E5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2F6B24097
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47521158D9C;
	Wed, 24 Jul 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amma9G2n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9C18E10;
	Wed, 24 Jul 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838187; cv=none; b=fnicsfEFe26xwf4QxF98Mzi8PyNzYr/APhzEHO96jp+4Rww7lldMvm9SBO3KPVCCVxHe6jLBnh0RtgIGift03q8TB1ip2jyAuuqn8YqrTYPnsW52Lf1oSVRDBXasr+DAADZex4SdZozaC6/xeuUq6u8RSL06Jicz0pbCQfI9Zh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838187; c=relaxed/simple;
	bh=waqtxyoI1c8LwddMZBPmTXS/fGoT0GGRjxIpfHuAGTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=muVitMSBriVFXAMKxj3f7oY5NUXG8VL0i1Bbdqr5CZpy2oGBH8670nU4lJTLsgqDnvv04mzvsJxACbpjvZGPUlIWyjrHnT1Vcej6CRQPKVS8eL7IdVZ4wr5NXjtpwD2cHsCET5E3+pTxJR3G1rlnIqoTtJpklqcjtdc4MgfS/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amma9G2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F43CC4AF0F;
	Wed, 24 Jul 2024 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721838186;
	bh=waqtxyoI1c8LwddMZBPmTXS/fGoT0GGRjxIpfHuAGTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Amma9G2nW50V4idQwZHsRJQYWpfXD3fdjfiSVG2jtopM2RgOoYk/qoeef1L2XaxaP
	 XV1ZyR8z2JTO41LSEwUjL+YWrVBZzyRKiHdsvIWyd07pFtIRl+GDGb1X+c330FNfK8
	 qKN4Q80dtvBzJ9zs6RTQDS/MKo8E+dJC9wcJkxppqy75lvyI5YokxhvBFzNVzQSVqA
	 1VftM4LjtxTtcwEeiO3DrIF4z0TmKEdFhLPDL/FkATOFgZBBI5GU5K6w0NWcuY1QLT
	 JcTswEgX5d9xmx14eJAwCiNLUe/izCfBKzKEuLOBBkrx4Q8N723mY75dMadSrw4Rcr
	 l+BWqfGUWAX5w==
Date: Wed, 24 Jul 2024 11:23:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240724162304.GA802428@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724065048.285838-1-s-vadapalli@ti.com>

Subject should say something about why this change is needed, not just
translate the C code to English.

On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> Since the configuration of Legacy Interrupts (INTx) is not supported, set

I assume you mean J721E doesn't support INTx?

> the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
>   of_irq_parse_pci: failed with rc=-22

I guess this happens because devm_of_pci_bridge_init() initializes
.map_irq and .swizzle_irq unconditionally?

I'm not sure the default assumption should be that a host bridge
supports INTx.

Maybe .map_irq and .swizzle_irq should only be set when we discover
some information about INTx routing, e.g., an ACPI _PRT or the
corresponding DT properties.

> due to the absence of Legacy Interrupts in the device-tree.
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
> of Mainline Linux.
> 
> Patch has been tested on J784S4-EVM and J721e-EVM, both of which have
> the PCIe Controller configured by the pci-j721e.c driver.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/pci-j721e.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 85718246016b..5372218849a8 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -417,6 +417,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		if (!bridge)
>  			return -ENOMEM;
>  
> +		/* Legacy interrupts are not supported */

Say "INTx" explicitly here instead of assuming "legacy" == "INTx".

> +		bridge->map_irq = NULL;
> +		bridge->swizzle_irq = NULL;
> +
>  		if (!data->byte_access_allowed)
>  			bridge->ops = &cdns_ti_pcie_host_ops;
>  		rc = pci_host_bridge_priv(bridge);
> -- 
> 2.40.1
> 

