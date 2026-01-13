Return-Path: <linux-pci+bounces-44660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CBED1AE6E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C9DC300DA50
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71730EF7E;
	Tue, 13 Jan 2026 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwWB0bnZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720A1AAE13;
	Tue, 13 Jan 2026 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330292; cv=none; b=rpSOdw2o4K9cxPNTeJJlUaOfnsTuPyAAUIjb5DoJMwAZ5hfwCTT2m0v2COU+vbBH/chA9Ae11IKS4iQZ8q5yxa4H3EepEqg0UQfjiIRWXTJa6rdVDyoG9hnp4grYiHenAdVzlzPdUE/KWvu9hxeRXFVNoXw2pKwH7KDT8Nu6rEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330292; c=relaxed/simple;
	bh=ClicSUotQM99rvFPIWXEPqgkHHx4OO4qNEAVDXft22A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tk0VVpINzMgs+2yA8iJnsD/sc0y90wJreKWdIkqyWg42xw1Tazhoamo7z21M+MYfDieBRlAqOgikC792soGEEuEEHnmctffCoheLHRhbVT2B8g9MqlmI4Kwjb4Wx2SmMBPim417Yxt+9+ft4uWSvHA1inRKt4ZF8boyV+wiaZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwWB0bnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5102C116C6;
	Tue, 13 Jan 2026 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768330292;
	bh=ClicSUotQM99rvFPIWXEPqgkHHx4OO4qNEAVDXft22A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XwWB0bnZppbMIIRh1Bh6gQ6eUx9zPjICOG/FdLxuGayBKZgYY+EZduht39k9O3fTw
	 vW9ChNdDqnGT41iq7penj+7tLy1E/FDCRpK/bcV1OZ9N0SLfLJ2HjAsOnYCS+dkrip
	 ytpeeUpVTytksx4jiSzb4lbu25V2SuhbPaqAV9eawBN8ly/FdIBs+GM37VliFTS3NA
	 CY7hSkZUAcwqgfpolo/qBeOneHk6P8QB9eVzoev5GWgr84v+jCTRgfphRbhplvqnkP
	 ccR+cCGtolvkGIOuan8u0Cdvqb4+0NBfdylUjqo3rs8mTBFbn3FeB3zw8si8HYUUUf
	 U//IZHcH3AEqg==
Date: Tue, 13 Jan 2026 12:51:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, okaya@kernel.org, keith.busch@intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	liuyongqiang13@huawei.com
Subject: Re: [PATCH] PCI: Fix AB-BA deadlock between aer_isr() and
 device_shutdown()
Message-ID: <20260113185130.GA774840@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109095603.1088620-1-duziming2@huawei.com>

On Fri, Jan 09, 2026 at 05:56:03PM +0800, Ziming Du wrote:
> During system shutdown, a deadlock may occur between AER recovery process
> and device shutdown as follows:
> 
> The device_shutdown path holds the device_lock throughout the entire
> process and waits for the irq handlers to complete when release nodes:
> 
>   device_shutdown
>     device_lock                      # A hold device_lock
>     pci_device_shutdown
>       pcie_port_device_remove
>         remove_iter
>           device_unregister
>             device_del
>               bus_remove_device
>                 device_release_driver
>                   devres_release_all
>                     release_nodes    # B wait for irq handlers

Can you add the wait location to these example?  release_nodes()
doesn't wait itself, so I guess it must be in a dr->node.release()
function?

And I guess it must be related to something in the IRQ path that is
held while aer_isr() runs?

> The aer_isr path will acquire device_lock in pci_bus_reset():
> 
>   aer_isr                            # B execute irq process
>     aer_isr_one_error
>       aer_process_err_devices
>         handle_error_source
>           pcie_do_recovery
>           aer_root_reset
>             pci_bus_error_reset
>               pci_bus_reset          # A acquire device_lock
> 
> The circular dependency causes system hang. Fix it by using
> pci_bus_trylock() instead of pci_bus_lock() in pci_bus_reset(). When the
> lock is unavailable, return -EAGAIN, as in similar cases.

pci_bus_error_reset() may use either pci_slot_reset() or
pci_bus_reset(), and this patch addresses only pci_bus_reset().  Is
the same deadlock possible in the pci_slot_reset() path?

> Fixes: c4eed62a2143 ("PCI/ERR: Use slot reset if available")
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/pci.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..7471bfa6f32e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5515,15 +5515,22 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	pci_bus_lock(bus);
> +	/*
> +	 * Replace blocking lock with trylock to prevent deadlock during bus reset.
> +	 * Same as above except return -EAGAIN if the bus cannot be locked.

Wrap this to fit in 80 columns like the rest of the file.

> +	 */
> +	if (pci_bus_trylock(bus)) {
>  
> -	might_sleep();
> +		might_sleep();
>  
> -	ret = pci_bridge_secondary_bus_reset(bus->self);
> +		ret = pci_bridge_secondary_bus_reset(bus->self);
>  
> -	pci_bus_unlock(bus);
> +		pci_bus_unlock(bus);
>  
> -	return ret;
> +		return ret;
> +	}
> +
> +	return -EAGAIN;
>  }
>  
>  /**
> -- 
> 2.43.0
> 

