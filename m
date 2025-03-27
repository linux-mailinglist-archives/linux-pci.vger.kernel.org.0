Return-Path: <linux-pci+bounces-24880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A09CA73D9E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAB4189BF33
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43021931E;
	Thu, 27 Mar 2025 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouVL5tJa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1CE1FF613;
	Thu, 27 Mar 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743098159; cv=none; b=cVT1hFK74kM/+VUW2qvbgasQy8wLmdoYbSJUhPD6jzQkw/0CKXh1+EIMcNvAW3z7xf7tQKn43dOlMst4BVoNleEFTnxGLGSYBmpkfGwy+rwH/Y9Smca5phYRIqW/cfvWJJafdyotatfxZjKRl+Hf8WE+UFaDW2dDEsq9utGamXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743098159; c=relaxed/simple;
	bh=GXiwOvkxWgxlNaGSsb7P/U6b2eY25FmZ/yfDozVoIIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IMs0FQKpYDiUn4EEnLhKOptY97hVUD/qbKUzDyKr8vxpGEMdYBjnJ2v1lQDcCCUvtn/z8tTTDFoWKbCFywCWAhlBE9eEiIwDusORBW0aXBaJkoMuQ5xT55EKQAtcgA4MjsEJVHNS23rPh2L3HqmxcJ+td+edd+gUSSBQI4qiMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouVL5tJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F6BC4CEDD;
	Thu, 27 Mar 2025 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743098158;
	bh=GXiwOvkxWgxlNaGSsb7P/U6b2eY25FmZ/yfDozVoIIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ouVL5tJarY8YUiK5ZdcNuYb1n/t3XjTmwrsrohRgkOojKv4FLDMGX30b0a986oSm6
	 tQV62HBbPP1+VsCNYv5VzYnNcVRG4UozDObVGccy3ATAi+GufHStnOVubImiDN3PdE
	 C3ob4DbxBCI5gAlo0FCSZFD8OoEC3lPiXJR5k8bU88bJQORhf6/aECWdjRZOjtzrPK
	 9UQfQ3n0zfm+XlKnwaQjlxlgsWsnOmtrdtRWQkcPaRgRse96/7Hpd1MykC1p6BmyyK
	 VdoOPlwBc6owJUbpZYPf3wggQDB65TGXNRiGJm83d3AFjCpXqFn1KtlXp19XguUhGe
	 iAWhz9xIaTdmw==
Date: Thu, 27 Mar 2025 12:55:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: fix index passed to
 syscon_regmap_lookup_by_phandle_args
Message-ID: <20250327175557.GA1438048@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327151949.2765193-1-ioana.ciornei@nxp.com>

On Thu, Mar 27, 2025 at 05:19:49PM +0200, Ioana Ciornei wrote:
> The arg_count variable passed to the
> syscon_regmap_lookup_by_phandle_args() function represents the number of
> argument cells following the phandle. In this case, the number of
> arguments should be 1 instead of 2 since the dt property looks like
> below.
> 	fsl,pcie-scfg = <&scfg 0>;
> 
> Without this fix, layerscape-pcie fails with the following message on
> LS1043A:
> 
> [    0.157041] OF: /soc/pcie@3500000: phandle scfg@1570000 needs 2, found 1
> [    0.157050] layerscape-pcie 3500000.pcie: No syscfg phandle specified
> [    0.157053] layerscape-pcie 3500000.pcie: probe with driver layerscape-pcie failed with error -22
> 
> Fixes: 149fc35734e5 ("PCI: layerscape: Use syscon_regmap_lookup_by_phandle_args")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks, applied to pci/controller/layerscape for v6.15.  Hopefully the
last change for this cycle :)

Thanks for the message sample.  I dropped the timestamps because
they're not really relevant here.

> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 239a05b36e8e..a44b5c256d6e 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -356,7 +356,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	if (pcie->drvdata->scfg_support) {
>  		pcie->scfg =
>  			syscon_regmap_lookup_by_phandle_args(dev->of_node,
> -							     "fsl,pcie-scfg", 2,
> +							     "fsl,pcie-scfg", 1,
>  							     index);
>  		if (IS_ERR(pcie->scfg)) {
>  			dev_err(dev, "No syscfg phandle specified\n");
> -- 
> 2.34.1
> 

