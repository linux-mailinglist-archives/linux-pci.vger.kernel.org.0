Return-Path: <linux-pci+bounces-22228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1820A426D4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5A8164759
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B025A34D;
	Mon, 24 Feb 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMswTZ0m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5925A348;
	Mon, 24 Feb 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411791; cv=none; b=Cq5XpkpsRblNgBz0mI6waLJjzypZPXhVwsLQC/Rk60SfSUQptRkOA/l5f0+yfL3d9DcBZmdhfdR0Uwirb6CDjrjFiuEzO8dWRYgx4n0E3QbT2QRf6zR5LEQfdRepihVn887FdSAENd0tvsH2jT8OkUd1KHzvpZ4vbSZoIraTjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411791; c=relaxed/simple;
	bh=Appv64mgYxO2sDwWT9vScFqVEMdC97kyS93cZAyYCsk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g7vtvmbSH+Qr/Trl96saMb2eZ81tDKedIr/W1uS6kV9cP19F+ZCM4nMajr1rv+TbsvsBt3VhQwJ0Eh00PrUPITtnuZRtGLYLG6zOtiSzN19V1IB75eClDqI2rkWPFby/nnvE+AHStWYHBkhvtP+nxcO15XX2Kh080701gzSmyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMswTZ0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAFBC4CED6;
	Mon, 24 Feb 2025 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740411790;
	bh=Appv64mgYxO2sDwWT9vScFqVEMdC97kyS93cZAyYCsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hMswTZ0mf3ek6zWlsbLxER72OMiwoxodZlOzrVR246l5McU0K9YoTnABFhhLhfOjP
	 HJxQVsAaTW9m/EvR+BuNV9xR6gbWpI8sWuGxGAuoiwNA3zLA5sNOJ1SQ4K5kKGQaU8
	 YGQ4fmzVSkI1O1iHuABNeYBO5E5rKzLYa+8KF6EVDWqawKVt6W405X1KQmTqEGHEeA
	 0YAIljl+veWp/+CoqE9Qm1cHNq6Kn0/JannyQKwRfcWmV43kmr/Z1Hgjy2OF79U4EG
	 TldbfYAAv9EnpEpy3kYe9TedlsO9IcFA5cGpWn0DngrT4ckmDtAUq4eCWrlywrBwBg
	 3thKZOdoC2dcA==
Date: Mon, 24 Feb 2025 09:43:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	alex.williamson@redhat.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: fix bug introduced in pci_save_pcix_state()
Message-ID: <20250224154309.GA465854@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223050700.4635-1-Ashish.Kalra@amd.com>

On Sun, Feb 23, 2025 at 05:07:00AM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For PCIe devices which don't have PCI_CAP_ID_PCIX, this change in
> pci_save_pcix_state() causes pci_save_state() to return -ENOMEM error
> and causes e1000e driver probe to fail as follows:
> ..
> [   15.891676] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   15.921816] e1000e 0000:21:00.0: probe with driver e1000e failed with error -12
> ...
> 
> Fixes: 7d90d8d2bb1b ("PCI: Avoid pointless capability searches")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

I dropped that patch for now, so if you're using current -next you
shouldn't see this issue.

> ---
>  drivers/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ccd029339079..685463ea392b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1743,14 +1743,14 @@ static int pci_save_pcix_state(struct pci_dev *dev)
>  	struct pci_cap_saved_state *save_state;
>  	u8 pos;
>  
> -	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> -	if (!save_state)
> -		return -ENOMEM;
> -
>  	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
>  	if (!pos)
>  		return 0;
>  
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> +	if (!save_state)
> +		return -ENOMEM;
> +
>  	pci_read_config_word(dev, pos + PCI_X_CMD,
>  			     (u16 *)save_state->cap.data);
>  
> -- 
> 2.34.1
> 

