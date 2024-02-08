Return-Path: <linux-pci+bounces-3256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6584EAA4
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16E11C2245D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FF24F1FF;
	Thu,  8 Feb 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2OxyuUR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5F4F1EE;
	Thu,  8 Feb 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428204; cv=none; b=jRi72mCNLK7QGq1Ly5+PLgnn1Iff83tgBoPdHh5zwenTo9J8TKawrKNwXAwIFxul8SPOw20ERLrkWNz8H6R6DVLQmNV3Y57oFP/Eid935JxqZjQyOZmIAvZ5xKWyTUyOj/hS3QPkgrvtvpu8qffIhPpjbgUmvEBMdqKtGgB0qHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428204; c=relaxed/simple;
	bh=6h1r+mf5vEgW1yFwYkHTvO5I4boVb36Scu743ILzsvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GqDrXP8p8GdX/Xi6ERb53INY50R5nstyLQP8zqwgaNwx/uY5lvXWjTQqgyrseMhYtgGvpnlkPhOXVrgMehD109bSrnSHjAFEsoYRSFTXNxFuoQDNhF1SkVjCqQGhUCqATzHxUYODio+LgdnIqUWQV5R5TshB+mhZnbKpf6RkiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2OxyuUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B75DC433C7;
	Thu,  8 Feb 2024 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707428203;
	bh=6h1r+mf5vEgW1yFwYkHTvO5I4boVb36Scu743ILzsvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u2OxyuURzWENGfTKrM94WkOqvvqSNdFVdrPiueXmUUdR6l1Hq/YCH062SRZWJrDDo
	 joL4hhXXfzv04VyY7Iwc4bYTuNsekhglHoxF6fh+MnO0lIofGz096XGqNc5GazOwzU
	 BRcX8aMZ8QZEfT6n0a9bY579w8doM7BBXLC+jxakVKYdATVY3itqkWY+auyDmPtne3
	 giir9A6f/Dv5+G9ENjTCG6muTsemX1PnCvnR0nQahxfVYzrQzB0DusqrPiPHvP0PvB
	 SNJKreXJFzqXghFfyzofY/pKw05ahxScMLBUDnipqovKyUvdAXDpHNi6HTIwb0rXSe
	 /9gFiNShlMQTg==
Date: Thu, 8 Feb 2024 15:36:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Daniel Stodden <dns@arista.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: switchtec: Fix an error handling path in
 switchtec_pci_probe()
Message-ID: <20240208213641.GA973659@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01446d2ccb91a578239915812f2b7dfbeb2882af.1703428183.git.christophe.jaillet@wanadoo.fr>

On Sun, Dec 24, 2023 at 03:30:01PM +0100, Christophe JAILLET wrote:
> The commit in Fixes changed the logic on how resources are released and
> introduced a new switchtec_exit_pci() that need to be called explicitly in
> order to undo a corresponding switchtec_init_pci().
> 
> This was done in the remove function, but not in the probe.
> 
> Fix the probe now.
> 
> Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after surprise hot remove")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to pci/switchtec for v6.9, thanks!

> ---
>  drivers/pci/switch/switchtec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 1804794d0e68..5a4adf6c04cf 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1672,7 +1672,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
>  	rc = switchtec_init_isr(stdev);
>  	if (rc) {
>  		dev_err(&stdev->dev, "failed to init isr.\n");
> -		goto err_put;
> +		goto err_exit_pci;
>  	}
>  
>  	iowrite32(SWITCHTEC_EVENT_CLEAR |
> @@ -1693,6 +1693,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
>  
>  err_devadd:
>  	stdev_kill(stdev);
> +err_exit_pci:
> +	switchtec_exit_pci(stdev);
>  err_put:
>  	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>  	put_device(&stdev->dev);
> -- 
> 2.34.1
> 

