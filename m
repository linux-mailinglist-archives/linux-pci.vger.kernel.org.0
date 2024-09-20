Return-Path: <linux-pci+bounces-13335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70DC97DAC3
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 01:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB8AB21F94
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 23:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C86A185B67;
	Fri, 20 Sep 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6tbJx3y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B51531E1;
	Fri, 20 Sep 2024 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726874314; cv=none; b=Is7TqaEbyVgi6E2DWsQgrPm3SZSL6az0gPsDF7iN/TOHeg6mw7yHTyvbsnhq1QJLZGtinOnuxKCV5C/gm/APGwZ9mbeMFT9Nw/HHTFN5oEFYD0Ik85ZnNkGrhJO1I7ukkPhPOxqbN91UTwnBa5kQctCOmlz32msqabcGVF6BwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726874314; c=relaxed/simple;
	bh=g8cMyzOEs0S98G+5L/f/JqPHBPyVQgL4h0J5XUiipmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XHepxQLOPHP38Z14tTca82GjPD+2itdRxPCF+PPsTQwXMcp8Z+xqGy3DPMqQh93b4jZ8qUtFbmp/Q4KzCHPsJbjlls+OpTwfFK3CMz4+d4F8X4HIVqDA8vLpWJQYu04csBfc20zMF60XXq/fvQ5h1jDFT1MxNHxEEnkN6fLdIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6tbJx3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115F8C4CEC3;
	Fri, 20 Sep 2024 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726874312;
	bh=g8cMyzOEs0S98G+5L/f/JqPHBPyVQgL4h0J5XUiipmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e6tbJx3yD/aiLi8NrcKFHltbqwpwy+vKiAFAqu8R5A/oDIOBvzLq8NWVreYGkS5bD
	 9X5K3W0/12Qg8FCgKWqPnBrCP1fia5+zvod0RiJdPUFEgwxhZ0XRjs/ZWCIfzLh5MA
	 1tZnNlxNrvwco1PCBauZ2I+bymBx2PQJAcycyZyKvxomlTkHjQGBXRaD3cQ7ylmYZW
	 PVy3BJcsSPLJBm6Q2yN1IItmw/5CfwpCrD59UBpGb7vkLwG9DLjlHNl72oLUSaQFVP
	 SEb6j+Xt9RjijG4I9I0ih4keSlERyv4mAliBWscSqCL+4kCpkQmVjhlohkYwLnnEcR
	 kC67QVahi83ng==
Date: Fri, 20 Sep 2024 18:18:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: vigneshr@ti.com, s-vadapalli@ti.com, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dra7xx: Added error handling in probe function when
 devm_phy_get() fails
Message-ID: <20240920231830.GA1073362@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911171112.46322-2-riyandhiman14@gmail.com>

On Wed, Sep 11, 2024 at 10:41:13PM +0530, Riyan Dhiman wrote:
> While creation of device link, if devm_phy_get() function fails then it directly
> returns PTR_ERR without any cleanup of previous added device links.
> Added goto statement when devm_phy_get() fails, to handle the cleanup of already
> added device links.
> 
> Fixes: 7a4db656a635 (PCI: dra7xx: Create functional dependency between PCIe and PHY)
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

Thanks for this.  We're in the v6.12 merge window right now, so please
post this again after v6.12-rc1 (probably Sep 29).

In subject and commit log, s/Added/Add/.

See https://chris.beams.io/posts/git-commit/ and
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v6.11#n134

Wrap commit log to fit in 75 columns.

Add blank line between paragraphs.

> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 4fe3b0cb72ec..c329d107b811 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -762,8 +762,10 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	for (i = 0; i < phy_count; i++) {
>  		snprintf(name, sizeof(name), "pcie-phy%d", i);
>  		phy[i] = devm_phy_get(dev, name);
> -		if (IS_ERR(phy[i]))
> -			return PTR_ERR(phy[i]);
> +		if (IS_ERR(phy[i])) {
> +			ret = PTR_ERR(phy[i]);
> +			goto err_link;
> +		}
>  
>  		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
>  		if (!link[i]) {
> -- 
> 2.46.0
> 

