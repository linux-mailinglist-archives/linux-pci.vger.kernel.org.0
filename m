Return-Path: <linux-pci+bounces-19359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACF6A03332
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 00:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D05E16251C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 23:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4D1E048D;
	Mon,  6 Jan 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNg/lnLu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC971C69D
	for <linux-pci@vger.kernel.org>; Mon,  6 Jan 2025 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205115; cv=none; b=tT8kAV5QZJqqj2/JgOJqHXABTTn6UeHjgMkNUfdPh2yHO0CMxRq3twiZf2Rmc/G8XZL/jMsptTDTOHWKCzgiKFLr283DVBYN72C8BwvHkJHzvCJsqxzj999V60x00p4yBB4S1FeHVKg1zWTByG7nHnhvrXh+Ra0GdvQMOhvKKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205115; c=relaxed/simple;
	bh=MN/Ih2P+s6qf6oUkFhnGkhQu+KHq9eZ465ZZ7btl6hU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bN8R26cUTyVImjMRoh0Ffw50bl01pF9D3l3HgXak15FjMI+Bp9UfzYG0ykb4c+Ih0ada1lUA9MrhJV5w3Q5dMXIeAMMoUjGu4IUYX0bysF1rYDMBPNf4SiwHM/G0Fj5GqcD6PLSZPdWQuMzO73rOQ57Jj1UWC29HF3NdQD8DjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNg/lnLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E651C4CED2;
	Mon,  6 Jan 2025 23:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736205114;
	bh=MN/Ih2P+s6qf6oUkFhnGkhQu+KHq9eZ465ZZ7btl6hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SNg/lnLu+XwaDiPgeCwleH/v+su+9gXl+5Hczkj/kBu37fZ6LEo7yTsa5Lu4bR7rC
	 LhFChr3Pd/QRC6R6OCfqOrR68X/i+J9A/K9JslrBvLnBuoevDJ38ZbpVy4ngMbxIhp
	 EEDGzNrxIn6qjleUbYRhrK0Zj41Z01hzeQcOyKW1+WHQddK948TV692bQPfyDDxTwE
	 dbS++iEZubFg2GHAX3bunSNgrEW47p80n/owThGowZdZ99Yf+oDFO5winkanYGsO6U
	 CLKjtj6sAHoD7pX7LQOHspr0imCOJl1cL4s6H33fG1VTrwnyHlV3Zf1GSQ++yHlk51
	 duaDch+jtj1og==
Date: Mon, 6 Jan 2025 17:11:52 -0600
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
Subject: Re: [PATCH for-linus v2] PCI/bwctrl: Fix NULL pointer deref on
 unbind and bind
Message-ID: <20250106231152.GA139531@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae2b02c9cfbefff475b6e132b0aa962aaccbd7b2.1736162539.git.lukas@wunner.de>

On Mon, Jan 06, 2025 at 12:26:35PM +0100, Lukas Wunner wrote:
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
> Ilpo points out that the locking on unbind and bind needs to be symmetric,
> so move the call to pcie_bwnotif_disable() inside the critical section
> protected by pcie_bwctrl_setspeed_rwsem and pcie_bwctrl_lbms_rwsem.
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
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219629
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Tested-by: Evert Vorster <evorster@gmail.com>

Replaced the patch on pci/for-linus with this one, headed for v6.13,
thanks!

> ---
> Changes v1 -> v2 (in response to Ilpo's review):
>  Move request_irq() inside critical section on bind.
>  Move free_irq() + pcie_bwnotif_disable() inside critical section on unbind.
>  Amend commit message with a paragraph explaining these changes.
> 
>  drivers/pci/pcie/bwctrl.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index b59cacc740fa..0a5e7efbce2c 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -303,14 +303,17 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
> -			       IRQF_SHARED, "PCIe bwctrl", srv);
> -	if (ret)
> -		return ret;
> -
>  	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
>  		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> -			port->link_bwctrl = no_free_ptr(data);
> +			port->link_bwctrl = data;
> +
> +			ret = request_irq(srv->irq, pcie_bwnotif_irq,
> +					  IRQF_SHARED, "PCIe bwctrl", srv);
> +			if (ret) {
> +				port->link_bwctrl = NULL;
> +				return ret;
> +			}
> +
>  			pcie_bwnotif_enable(srv);
>  		}
>  	}
> @@ -331,11 +334,15 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
>  
>  	pcie_cooling_device_unregister(data->cdev);
>  
> -	pcie_bwnotif_disable(srv->port);
> +	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
> +		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> +			pcie_bwnotif_disable(srv->port);
> +
> +			free_irq(srv->irq, srv);
>  
> -	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
> -		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
>  			srv->port->link_bwctrl = NULL;
> +		}
> +	}
>  }
>  
>  static int pcie_bwnotif_suspend(struct pcie_device *srv)
> -- 
> 2.43.0
> 

