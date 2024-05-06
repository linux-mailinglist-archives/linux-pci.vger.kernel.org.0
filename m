Return-Path: <linux-pci+bounces-7132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6308BD55B
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 21:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0B61C21A6D
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2340158DAB;
	Mon,  6 May 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk4xQxs/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA773158DDA;
	Mon,  6 May 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023443; cv=none; b=BiZ+R9hu+nx0lrZXkJqQI/JtM66DNYbtRsxqkgH2o6RBDeN905Rcmc3yJwbtp6mbNGBviLZGZYSmPAJuAG78JZQSalW23TsZRH2xTVjqTKGwseckolfAZOXcFbwDcr1weQpksok8D+pJdD9UGeSteg/qcnvrsTx4E4wYTTrZgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023443; c=relaxed/simple;
	bh=eSARHEaXPlpYTPk6nnOZSW56af64LMpXvs2QgA5+byc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i7Ipzi05sOMTEX4Oa59vB4W427s38zk3I4HtH/WT1F+wn231UEGl+4TomHC1WRrpSZEom80+X5/U7/S7bn6LKX5XpMLQFa2xmzio3qe3AJ92AyH9/Gt+TGcK1bslUdWBarFZDWFH2fIGfnGRH3lcLXLvxQUKo4U3z56w0j+ohCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk4xQxs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29756C116B1;
	Mon,  6 May 2024 19:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715023443;
	bh=eSARHEaXPlpYTPk6nnOZSW56af64LMpXvs2QgA5+byc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Xk4xQxs/H8E9uZItfebdEpXqi96lNvNDqSBJt4JEcayLkxMvfZ0icI1kB5oJ2mUGM
	 Aq1lR3d7mYt1tuTv5oInj1rwDDHcrRh4iZ6pRX6s3+oid0P1zyg+83w6t+PBiYRJl8
	 HHXW7RkMd94jqf3NAwPeJrRLq65fHb7HjMD0derQLvss2uFaXdqH2pL4z4/WW82ZRI
	 aZQ7Vpuc7xCIIXPLR0jU/hqJD1aPk5230DBSxnEyUxRJk0Om5HnnfZTanuv0mJXs70
	 /pjowm4jGPbNNTY0L08XZKev+tbv3y6ugwW7O9WcqlDtKn+KIMaG8G7lNq7knFVCaI
	 EgvKpaK6kRRfQ==
Date: Mon, 6 May 2024 14:24:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David E . Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH] PCI/ASPM: Fix a typo in ASPM restoring logic
Message-ID: <20240506192401.GA1704739@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506051602.1990743-1-kai.heng.feng@canonical.com>

[+cc David]

On Mon, May 06, 2024 at 01:16:02PM +0800, Kai-Heng Feng wrote:
> There's a typo that makes parent device uses child LNKCTL value and vice
> versa. This causes Micron NVMe to trigger a reboot upon system resume.
> 
> Correct the typo to fix the issue.
> 
> Fixes: 64dbb2d70744 ("PCI/ASPM: Disable L1 before configuring L1 Substates")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

This is something David did correctly in his original posting
(https://lore.kernel.org/all/20240128233212.1139663-4-david.e.box@linux.intel.com/)
and I broke it while reorganizing things
(https://lore.kernel.org/all/20240223213733.GA115410@bhelgaas/).
Thanks for finding this!

Since 64dbb2d70744 was merged for v6.9-rc1, I queued this to for-linus
for v6.9 with this subject:

  PCI/ASPM: Restore parent state to parent, child state to child

since it's more than just an innocuous typo.

> ---
>  drivers/pci/pcie/aspm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 2428d278e015..47761c7ef267 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -177,8 +177,8 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
>  	/* Restore L0s/L1 if they were enabled */
>  	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, clnkctl) ||
>  	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, plnkctl)) {
> -		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, clnkctl);
> -		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, plnkctl);
> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, plnkctl);
> +		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, clnkctl);
>  	}
>  }
>  
> -- 
> 2.34.1
> 

