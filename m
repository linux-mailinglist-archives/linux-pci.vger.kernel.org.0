Return-Path: <linux-pci+bounces-13730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345398E435
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 22:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEE61F233B4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8DE2141D1;
	Wed,  2 Oct 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOIVTvLJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201281720;
	Wed,  2 Oct 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901329; cv=none; b=L16FalSTIsQMO+tEs3NQ9nazBvQDmRE2kpk5WKaUXomFTtdmlNMP2IR56bJ2It3i05GcLcBF4REXdlulzYn8icMdVShYlQb1ekjWoe89eE6zHi0wRFJEiFc11gMYZ5NzQ3v3Rs/y397Hxskifx228LXzpZd3FJ8vuVHeu9vT/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901329; c=relaxed/simple;
	bh=MqydiT4BUeVyD3/c1YaamI8hpviv3bNgpn4gjmHO6wI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U67fGY+pxFcAqsfLPurcN5HU+2gQX4cJzCdaMTlcbW41TGLoROPoL3ZwVQ4VQ3hgYsnqmSOAfIagxLAhuCrfDlUnNpO3rrOOtetOCfaGRsHMQaH7WfQarZJpZZ10FihnyWSCgT2Fvwd7p4LtrzbgfsLVL0hMTd0/AG49MA558ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOIVTvLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD80C4CEC2;
	Wed,  2 Oct 2024 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727901329;
	bh=MqydiT4BUeVyD3/c1YaamI8hpviv3bNgpn4gjmHO6wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NOIVTvLJKgk2utuCb21BMAdgbdQSNVfRsUZGCGDbaFfs3S3EKM2Nyyfy7T+AXCccX
	 tcV55OhEEgL/IbrkluD5WDxHF0lSFVZwfqrRABUfPLPvTJV+9hMD9lfHLFyUtZEHNM
	 7dgkA5iPfWfe5cIBxxc2jaVQzE/+1t8ihJRFx9O2pJmw0aTzBQrc3EqbT/vAjakMKF
	 P/2wYgnkiuRoZ21K1Fye3IUqXfMxiLBHM9gN4srAVvjIfoFQzEMcO28FKjE0BGY4eb
	 18vmqPMO62rJt2b59T/nMCjcrAnWbml1tJnz0/sVQXT9W1qXS7HV9v2hCxt+xwP9IM
	 JwVpzq+SF8xxQ==
Date: Wed, 2 Oct 2024 15:35:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: vigneshr@ti.com, s-vadapalli@ti.com, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dra7xx: Added error handling in probe function
 when devm_phy_get() fails
Message-ID: <20241002203526.GA269499@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001105717.4566-2-riyandhiman14@gmail.com>

On Tue, Oct 01, 2024 at 04:27:18PM +0530, Riyan Dhiman wrote:
> While creation of device link, if devm_phy_get() function fails then it 
> directly returns PTR_ERR without any cleanup of previous added device 
> links.
> 
> Added goto statement to handle the cleanup of already added device links.
> 
> Fixes: 7a4db656a635 (PCI: dra7xx: Create functional dependency between 
> PCIe and PHY)
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

No need to repost for this, but when applying, please
s/Added/Add/ in subject and commit log (I mentioned this before for
the v1 posting).

Also add statement in commit log about what the patch does (currently
it only says what the problem is).

And join Fixes: into a single line without a newline in the middle.

> ---
> v2: resend when tree is open and reformat commit message
> 
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
> 2.46.1
> 

