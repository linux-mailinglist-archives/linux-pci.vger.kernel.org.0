Return-Path: <linux-pci+bounces-19188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E6A00181
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 00:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A981883C0D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E9192B81;
	Thu,  2 Jan 2025 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3c2/3/V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178EC13D
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860143; cv=none; b=AW4zVZR70h8gjPliLgTY5YsLmgMfDzVVVhUovRVACL0OlcmMzQMdDDrc5TcFqZqTTqRedeSjOM8eBub0tvCyHqmIvtsLMar/iMY2h/W+8OwU+IZ0Ik5BGk5MA+myL+N/cI9Zz9psXPA7NQfN17FTKqb10TWGfxDnLxbfYtt/FAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860143; c=relaxed/simple;
	bh=nb2rGQueV01bvdielc+XL2pBr1ke6dGbpYQq6D+vKCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e1qEzoX4qCnooxfJGSTOCHA9LVgz2+dKOmDL9RnEGMFfuOkXccGhPCkLh08ZAR938153ZD+L3jHyHJXeQzOSMPOirTf4zYkFHDNDdyFhVRJw4+i7AHKYPFJY6XXyI6154dIYWkZnwMrowqLY7272mKLerVfKxq8Fcvw//qFMGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3c2/3/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC11C4CED0;
	Thu,  2 Jan 2025 23:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735860142;
	bh=nb2rGQueV01bvdielc+XL2pBr1ke6dGbpYQq6D+vKCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D3c2/3/VHqvvUzjOY1vg1xebvPghJerRKnKG+7EYsYAUjzZyB7TjY66LX+h6XvYyX
	 Q+G9pJzZ+7Y1miveBGAb0VkbxPRvv+ktCbqsD32XgENLrc0YpIzehb7nalP+sXrlYH
	 NyopHmO2hnNWSpYGtvIxqCanFToGaroYC1kqHBAU/Cpznwm6Jk1FGS1SlN42DIEO7I
	 kTo8G6DBaz+Rc+n2ighIxvNO3F8M164is4ablePfmsvsZ0OLzfgbV7d09nBiuAXifP
	 5EwGykkvXD1Ym6CUmKCj5aJSikHfI6om3mbk85S8qbQmCOdkSaKJJxW8vVdl3K89DQ
	 jkY4rH+k3zfqA==
Date: Thu, 2 Jan 2025 17:22:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krzysztof Wilczynski <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Evert Vorster <evorster@gmail.com>
Subject: Re: [PATCH for-linus] PCI/bwctrl: Fix NULL pointer deref on unbind
 and bind
Message-ID: <20250102232219.GA4146855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de>

On Thu, Jan 02, 2025 at 10:20:35PM +0100, Lukas Wunner wrote:
> The interrupt handler for bandwidth notifications, pcie_bwnotif_irq(),
> dereferences a "data" pointer.
> 
> On unbind, that pointer is set to NULL by pcie_bwnotif_remove().  However
> the interrupt handler may still be invoked afterwards and will dereference
> that NULL pointer.
> 
> That's because the interrupt is requested using a devm_*() helper and the
> driver core releases devm_*() resources *after* calling ->remove().
> 
> pcie_bwnotif_remove() does clear the Link Bandwidth Management Interrupt
> Enable and Link Autonomous Bandwidth Interrupt Enable bits in the Link
> Control Register, but that won't prevent execution of pcie_bwnotif_irq():
> The interrupt for bandwidth notifications may be shared with AER, DPC,
> PME, and hotplug.  So pcie_bwnotif_irq() may be executed as long as the
> interrupt is requested.
> 
> There's a similar race on bind:  pcie_bwnotif_probe() requests the
> interrupt when the "data" pointer still points to NULL.  A NULL pointer
> deref may thus likewise occur if AER, DPC, PME or hotplug raise an
> interrupt in-between the bandwidth controller's call to devm_request_irq()
> and assignment of the "data" pointer.
> 
> Drop the devm_*() usage and reorder requesting of the interrupt to fix the
> issue.
> 
> While at it, drop a stray but harmless no_free_ptr() invocation when
> assigning the "data" pointer in pcie_bwnotif_probe().
> 
> Evert reports a hang on shutdown of an ASUS ROG Strix SCAR 17 G733PYV.
> The issue is no longer reproducible with the present commit.
> 
> Evert found that attaching a USB-C monitor prevented the hang.  The
> machine contains an ASMedia USB 3.2 controller below a hotplug-capable
> Root Port.  So one possible explanation is that the controller gets
> hot-removed on shutdown unless something is connected.  And the ensuing
> hotplug interrupt occurs exactly when the bandwidth controller is
> unregistering.  The precise cause could not be determined because the
> screen had already turned black when the hang occurred.
> 
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
> Reported-by: Evert Vorster <evorster@gmail.com>
> Tested-by: Evert Vorster <evorster@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219629
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/for-linus for v6.13, thanks, Evert and Lukas for
working to hard to get this resolved!

> ---
>  drivers/pci/pcie/bwctrl.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index b59cacc..7cd8211 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -303,17 +303,18 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
> -			       IRQF_SHARED, "PCIe bwctrl", srv);
> +	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
> +		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
> +			port->link_bwctrl = data;
> +
> +	ret = request_irq(srv->irq, pcie_bwnotif_irq, IRQF_SHARED,
> +			  "PCIe bwctrl", srv);
>  	if (ret)
> -		return ret;
> +		goto err_reset_data;
>  
> -	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
> -		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> -			port->link_bwctrl = no_free_ptr(data);
> +	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
> +		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
>  			pcie_bwnotif_enable(srv);
> -		}
> -	}
>  
>  	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
>  
> @@ -323,6 +324,12 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  		port->link_bwctrl->cdev = NULL;
>  
>  	return 0;
> +
> +err_reset_data:
> +	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
> +		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
> +			port->link_bwctrl = NULL;
> +	return ret;
>  }
>  
>  static void pcie_bwnotif_remove(struct pcie_device *srv)
> @@ -333,6 +340,8 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
>  
>  	pcie_bwnotif_disable(srv->port);
>  
> +	free_irq(srv->irq, srv);
> +
>  	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
>  		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
>  			srv->port->link_bwctrl = NULL;
> -- 
> 2.43.0
> 

