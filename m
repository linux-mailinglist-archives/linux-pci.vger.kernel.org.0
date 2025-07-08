Return-Path: <linux-pci+bounces-31692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1FFAFD00D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D2A3A7AEF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81492E3B1B;
	Tue,  8 Jul 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm+GezH7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E92E0929;
	Tue,  8 Jul 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990762; cv=none; b=j/nZU22Y7Mij/vjH7E+EBufdmNPaI0f9AhCLoYgDniDC+NPCPbwFJ7lMFmO5s9mKsLoPGcIBV6x1QvT5cV+9d6Otd6JvFXSteYJLOTDj3rt08BZVluP8toJqqUS0unkV0jUzWsJR96e3N/Uoge3acUL1LXxUct4c/k2oRFkUyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990762; c=relaxed/simple;
	bh=VoqXC5vS3jsIa1yFv0oPoDMiBok2AlhMwtNJQb0+QVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tUQTxZErs+pFfc2T8USy3kPHPMuPHOCSdjWDgOXVm+BfCm7Wm9yEDwyYWLOAw6d4l0Mrl7RmhgiEbPrnZzUu1BeuJXVPY+sfqwBq6aza1qI9Lv94w4HgEQXZ//0zSh3WmtLuatoIsQqj6Md54dRnsgeIlWvwC2msaCzoKwJSk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm+GezH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BD1C4CEED;
	Tue,  8 Jul 2025 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990762;
	bh=VoqXC5vS3jsIa1yFv0oPoDMiBok2AlhMwtNJQb0+QVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bm+GezH77xN1w6ikSayOdd/DgOLYB3Egij8qvNsjOVoHaI+xqsL38XPX4H3K1GeeU
	 FPQBVwShbzDpkvzmguPQjDdXexsaK8s4BJnm94pW9mnE3fn2wPJqnXOuB2/5B/tn0w
	 UhkNqdX4QZ3TmmwfssxJ8Z7wuovZdo/ZNtcOZ+TFV9+elpQuavsytBj6CUSsYVf4t0
	 T/1dh+Iy/RBAOsn6D67oTMk8AtB74jmoz+eNUfonfWh67pOro6KgVz/sHIOK1+lGPC
	 DiYO6KgVPtso/VoB+hN9vxmgQkm7bU7EFWMmyVmYeI+1rAWZ1HgI3+/+8sO/ZORU0t
	 HAzplkVeGB74g==
Date: Tue, 8 Jul 2025 11:06:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: iproc: Remove description of 'msi_domain' in struct
 iproc_msi
Message-ID: <20250708160600.GA2147978@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708053825.1803409-1-namcao@linutronix.de>

On Tue, Jul 08, 2025 at 07:38:25AM +0200, Nam Cao wrote:
> The member msi_domain of struct iproc_msi has been removed, but its
> description was left behind. Remove the description.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507080437.HQuYK7x8-lkp@intel.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Thanks for squashing this into the ("PCI: iproc: Switch to
msi_create_parent_irq_domain()") patch that removed the msi_domain
member, Mani.  No point in cluttering the history with extra commits
that clean up things we haven't merged upstream yet.

> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index d0c7f004217f..9ba242ab9596 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -82,7 +82,6 @@ struct iproc_msi_grp {
>   * @bitmap_lock: lock to protect access to the MSI bitmap
>   * @nr_msi_vecs: total number of MSI vectors
>   * @inner_domain: inner IRQ domain
> - * @msi_domain: MSI IRQ domain
>   * @nr_eq_region: required number of 4K aligned memory region for MSI event
>   * queues
>   * @nr_msi_region: required number of 4K aligned address region for MSI posted
> -- 
> 2.39.5
> 

