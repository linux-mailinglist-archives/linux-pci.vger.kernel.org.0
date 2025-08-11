Return-Path: <linux-pci+bounces-33799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91646B2188C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF72E1903672
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F4A19D065;
	Mon, 11 Aug 2025 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KST1rq0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7061E515;
	Mon, 11 Aug 2025 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952421; cv=none; b=HV5LvdD80J4PBJgIPoupEyI1N62JuA6JZn9KR8te7ppHwWFK1kJ9PrZQEJYGk8655xhbKUXMqjONMbi3izcTF0LmKHWCsayzXkYmvjNeQuJXs8QMlzsfqfY5+udwJTPEXQbYanbRkwo5vJBmfgTAdKsrsF2+GF6FQt6dp+e30lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952421; c=relaxed/simple;
	bh=f+O5W/S8/rdvyjkv3EVe3Crl1oeO2GsIjPKFm2BH7LA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KgLW3iANBb22ZZL50Js4H7KH3DUB9zBHsmY0HqI3s+W6bjw7Qm3rX+Bys7f59+MS4izopNLBQWa7GOL+U8GuqcmKX4vGdTa3ZdBcKycdC0kfFpRvv0vqZowQoowHeS9T4L3HtIYaWKsPa19bn+7i5mmn0f4E7lWwKseL0i0FxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KST1rq0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C52BC4CEED;
	Mon, 11 Aug 2025 22:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754952421;
	bh=f+O5W/S8/rdvyjkv3EVe3Crl1oeO2GsIjPKFm2BH7LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KST1rq0/HEGi6IK4W8bLHuVN8/vwyFzvkVBaHCRntvyjXmLLrXaVl2g4Bi8jp8opq
	 LmZOqD8bJJm2Sc+l+oBoK9Ei0cgl+uNaa/FAne8+VFttbnolMQ7Ibk5H+KLtvyQkEn
	 xF3wG3+l+hPU641s6dBvRANhyfJTLzN8BTKugL21SZ2knEtVaVU95soNgjHKxh5/s/
	 4etacMu4FJNaAfcyUbOFm76IbfiC+E06GHGErR7AM1zBlav4DFOsuXPI+co+3KAgFt
	 iYhd8EGaPBrxt8nqvs0ySiWxXK5gxKIOxyTr3OP/G40j2wgkWfDVXNmhcGROfPEsia
	 Q1JNfU9FSZSgw==
Date: Mon, 11 Aug 2025 17:46:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <20250811224659.GA168102@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811053935.4049211-1-namcao@linutronix.de>

On Mon, Aug 11, 2025 at 07:39:35AM +0200, Nam Cao wrote:
> Commit d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> added a WARN_ON sanity check that child devices support MSI-X, because VMD
> document says [1]:
> 
>     "Intel VMD only supports MSIx Interrupts from child devices and
>     therefore the BIOS must enable PCIe Hot Plug and MSIx interrups [sic]."

Can VMD tell the difference between an incoming MSI MWr transaction
and an MSI-X MWr?

I wonder if "MSIx" was meant to mean "VMD only supports MSI or MSI-X
interrupts, not INTx interrupts, from child devices"?

I put this on pci/for-linus for v6.17, but it seems like we might want
to clarify the commit log.

> However, on Ammar's machine, a PCIe port below VMD does not support MSI-X,
> triggering this WARN_ON.
> 
> This inconsistency between the document and reality should be investigated
> further. For now, remove the MSI-X check.
> 
> Allowing child devices without MSI-X despite what the document says does
> sound suspicious, but that's what the driver had been doing before the
> WARN_ON is added.
> 
> Fixes: d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> Link: https://cdrdv2-public.intel.com/776857/VMD_White_Paper.pdf [1]
> Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Closes: https://lore.kernel.org/linux-pci/aJXYhfc%2F6DfcqfqF@linux.gnuweeb.org/
> Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/pci/controller/vmd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index b679c7f28f51..1bd5bf4a6097 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -306,9 +306,6 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>  				  struct irq_domain *real_parent,
>  				  struct msi_domain_info *info)
>  {
> -	if (WARN_ON_ONCE(info->bus_token != DOMAIN_BUS_PCI_DEVICE_MSIX))
> -		return false;
> -
>  	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
>  		return false;
>  
> -- 
> 2.39.5
> 

