Return-Path: <linux-pci+bounces-38091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B5BDB658
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 23:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E112580118
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99012D6401;
	Tue, 14 Oct 2025 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLENNlmf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BD2C1590;
	Tue, 14 Oct 2025 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476705; cv=none; b=dFXXD9xCIyFFvhEjXI1BdnD3T4/at1Hsbe7MLsIHq8UM7T6p1XjOeb3dRHPBCfHG2eBojp5GB0qvp7g+I6w+LhSnc3I3ptza0ygMDxEPZTW1EMnf2aApFXDCbgFaHgsyY33JQvRjHqgf7zriNJTqrFyNCCUaqFh6fu2VdEEGPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476705; c=relaxed/simple;
	bh=k9VLhEH66l0BqEGhD0Vjo1mGSRb3mjuRpsgnYAD5Zww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QIqe0ns63KsAMxHdYevkZ8jH1ixzL2wImLAJGxCH5eq/aSG98sQaB+WOHLDswFBCapiy7eXkkKlpmoesYV4DIkqxgeukXo0etuGvH24HKFREi2Mwd316RwidsYWKHDlxk06FHYdIquh3/sh8QPtWEiHygF+IgjRS6czijSemfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLENNlmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE72C4CEF9;
	Tue, 14 Oct 2025 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760476705;
	bh=k9VLhEH66l0BqEGhD0Vjo1mGSRb3mjuRpsgnYAD5Zww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vLENNlmfx+OiRdnI/YKOfKboL0Ji4hnfJ0whbjh5rEfh//U8FdlmwB+QotFfXnJNo
	 ZAeHhDdvBNu70mA4OsHspXV24b0dk9OtZWZwx9E3ALnSeptyewaBnObSj2ABTelSac
	 SwNaVbi+JYzPVcXnPZj0HO15LDENRByTXxnAm65jR0puoM3SXVhsy4SPL/TD4lCy8L
	 rLdZ9NjjbbYox34/dF32Zm2YrYUIRPq12XHUBcHOZNC3XHfBTX0SAkfdtjoavSCLpw
	 nDPOjEf+ukivM+Qsq5g2aK+EryW/v5UWTvxq40bVHwBEDyCxLuMUPYyPxAiekyG+QT
	 An0SJMkFHxyCg==
Date: Tue, 14 Oct 2025 16:18:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kenneth Crudup <kenny@panix.com>, Genes Lists <lists@sapience.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] PCI: vmd: override irq_startup()/irq_shutdown() in
 vmd_init_dev_msi_info()
Message-ID: <20251014211824.GA908020@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014014607.612586-1-inochiama@gmail.com>

On Tue, Oct 14, 2025 at 09:46:07AM +0800, Inochi Amaoto wrote:
> Since commit 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per
> device domains") set callback irq_startup() and irq_shutdown() of
> the struct pci_msi[x]_template, __irq_startup() will always invokes
> irq_startup() callback instead of irq_enable() callback overridden
> in vmd_init_dev_msi_info(). This will not start the irq correctly.
> 
> Also override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info(),
> so the irq_startup() can invoke the real logic.
> 
> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/all/8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com/
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Kenneth R. Crudup <kenny@panix.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thomas, I'm happy to take this via PCI you prefer.  I acked it
because you merged 54f45a30c0d0.

If you take it, I wouldn't mind if you capitalized "Override" in the
subject to match the history.

Obviously this is v6.18 material since 54f45a30c0d0 is a v6.18-rc1
regression.

> ---
>  drivers/pci/controller/vmd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 1bd5bf4a6097..b4b62b9ccc45 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -192,6 +192,12 @@ static void vmd_pci_msi_enable(struct irq_data *data)
>  	data->chip->irq_unmask(data);
>  }
> 
> +static unsigned int vmd_pci_msi_startup(struct irq_data *data)
> +{
> +	vmd_pci_msi_enable(data);
> +	return 0;
> +}
> +
>  static void vmd_irq_disable(struct irq_data *data)
>  {
>  	struct vmd_irq *vmdirq = data->chip_data;
> @@ -210,6 +216,11 @@ static void vmd_pci_msi_disable(struct irq_data *data)
>  	vmd_irq_disable(data->parent_data);
>  }
> 
> +static void vmd_pci_msi_shutdown(struct irq_data *data)
> +{
> +	vmd_pci_msi_disable(data);
> +}
> +
>  static struct irq_chip vmd_msi_controller = {
>  	.name			= "VMD-MSI",
>  	.irq_compose_msi_msg	= vmd_compose_msi_msg,
> @@ -309,6 +320,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>  	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
>  		return false;
> 
> +	info->chip->irq_startup		= vmd_pci_msi_startup;
> +	info->chip->irq_shutdown	= vmd_pci_msi_shutdown;
>  	info->chip->irq_enable		= vmd_pci_msi_enable;
>  	info->chip->irq_disable		= vmd_pci_msi_disable;
>  	return true;
> --
> 2.51.0
> 

