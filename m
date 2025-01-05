Return-Path: <linux-pci+bounces-19313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC5EA01AB5
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4973A2DC2
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985F1465BE;
	Sun,  5 Jan 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cI6rhGVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E880143725
	for <linux-pci@vger.kernel.org>; Sun,  5 Jan 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736096074; cv=none; b=ZmUXS425w1ZVg84B/1n1T6enB2qYnmG7AP5bfSMwKp/BSgBzsI9cObNwWH22yvrkKTht28/VvtcaFKYG/eriV/MaSEX8BEaZOBHoByFiYOmgbQKwNXUXlVgl5wsY1JHeH7uzmiBrk8/XmEmtZ/CLOb58cA+oZLBylg8LNMhtK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736096074; c=relaxed/simple;
	bh=eOtgxUY75cgZuz93li8ktIizbZiivy8G4rsgjO+RUOI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sqt2nxm2JXGWeEfjPEraSuVbL2QwtoVDPTfuclw1Y5o/tN10K9Y0qUHiPbQl+UFuFkeS+AgV22vzqIbvRmtr7QX0gP6xyKwXBXs8dSH6ArrR1wZvWyr9qAqkXrp6yXRPLmaOb+8LSQYvMiO26xjNcUVxY06vp4dKn/hdCVeCv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cI6rhGVt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736096072; x=1767632072;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eOtgxUY75cgZuz93li8ktIizbZiivy8G4rsgjO+RUOI=;
  b=cI6rhGVtgsbmNrHBq1h1T+ZqR0V+mhsT3CZU5Q+2yPkhwRFwFqjMw9IT
   rq9Nh2NIsUztJvioDUMKGLMydlSoTToz1RurgjyfUmFFkpl3V+/da+1dv
   V3qToOCzGGrueQ2oiX7/Ktp1pw3nSYn2wpDq3zHX8dokMGjZihc5tyMaL
   rKgariKbMyggioycHTNz13qFs0x732pplIgE88F2wsu8bM6bt9ejzF2X9
   /SfB1wC0d20XnKgNTcqzGbx9rEaS/z3MmiQDe9i6kObsEi1GtMIif4C1z
   9N1FOd5zx/CPNUBU+cx1VIIrOGnZCGki6SCrdSpRqcgsb6KptQYGrtseq
   Q==;
X-CSE-ConnectionGUID: hCYPYEA6QKGOM8cn0Q7mfA==
X-CSE-MsgGUID: DeE7JFPGRQiHR3IbEH/ZKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="46925783"
X-IronPort-AV: E=Sophos;i="6.12,291,1728975600"; 
   d="scan'208";a="46925783"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 08:54:31 -0800
X-CSE-ConnectionGUID: Tes5J0qcRIif2v8YoJaVfw==
X-CSE-MsgGUID: 0b+OikDSQ2WYi3QX/6WZKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,291,1728975600"; 
   d="scan'208";a="133074661"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.18])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 08:54:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 5 Jan 2025 18:54:24 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Krzysztof Wilczynski <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Evert Vorster <evorster@gmail.com>
Subject: Re: [PATCH for-linus] PCI/bwctrl: Fix NULL pointer deref on unbind
 and bind
In-Reply-To: <0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de>
Message-ID: <e08d30b5-50e0-4381-d2e7-61c2da12966f@linux.intel.com>
References: <0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 Jan 2025, Lukas Wunner wrote:

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

Hi Lukas,

Indeed, it certainly didn't occur to me while arranging the code the way 
it is that there are other sources for the same irq. However, there is a 
reason those lines where within the same critical section (I also realized 
it's not documented anywhere):

As bwctrl has two operating modes, one with BW notifications and the other 
without them, there are races when switching between those modes during 
probe wrt. call to lbms counting accessor, and I reused those rw 
semaphores to prevent those race (the race fixes were noted only in a 
history bullet of the bwctrl series).

Do you think it would be possible to put also request_irq() inside that
critical section to synchronize lbms count calls with the mode switch? 
(Also beware that with scoped_guards, a goto out of the critical section 
cannot be used in error handling and the NULL needs to be assigned inside 
it.)

(I know Bjorn has taken this already in so if needed, we can consider 
making that change later on top of this as those races are much less 
severe issue than what this fix is correcting.)

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

It seems I didn't remember to fix the mode switch races here at all.
So I think also here, pcie_bwnotif_disable(), free_irq() and NULL 
assignment, should be within the same critical section. Although this 
doesn't seem very big problemn compared with the probe side.

-- 
 i.


