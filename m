Return-Path: <linux-pci+bounces-14259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A5999C2C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 07:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0863C1C228AA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898EE1F4FDA;
	Fri, 11 Oct 2024 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbmEM79x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6602F26
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625282; cv=none; b=TezZzeRWUrA/xZfAeqRfOjS95O0HiztFUUOqvuWJvS1Nbc6L0StKAQ8OrrG7pLK8cogy0FFyazNeYToKU5VNZ9GAyz2IvD0gQsrdeLSI283iS15xIB0XylFgX5/UVgfbSKC+Ftgj9Tb2pTwJeDrJs4TRUI8qwmsDoF9oDDbA3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625282; c=relaxed/simple;
	bh=JXP2SX0fltwKEBNCECEz98uuvB/mnFhT/Q8vdHyXbT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYhFJuQ45QbnGCMfkbuqUeU/z9zPupWH4pN4PzvWvldbp4AWz1pPWNmG0kagWaQYjo/JMb+iRtdUECInYIARfI/sYvFF6vfka+0hqE8wJMqJqtxD1aQG1yddij9IMy5wGAcZuHWtPvgXRYa6P52Ok/AtA26KbzQXzhxaKZRv1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbmEM79x; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728625281; x=1760161281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXP2SX0fltwKEBNCECEz98uuvB/mnFhT/Q8vdHyXbT4=;
  b=UbmEM79xIa+G+23pDjcsrDFmD93Krh32o/qDS3UBxM3x1uqvXt8JaQgR
   Gm2iZDbF/xyMBEc+CKcEDDgVgfJACF3VhUBhMJbN1vZ6drMVX3kZmejjD
   TPS6Rpuy/K4A3pUujoTL/ry+9kflxbffc5FCx2/2QcUMqOGriKGM2CSKr
   DtTQhEYXJu35tzg0Vk9ULCgf4ODSZBeW0rvuoFpYspd1ZHwRg/lXw8Imv
   6TjJn9kFHpfzgbMA2BGvKdx6JghJeON4uc3G5aImdMtnNyyx1DyJDdgVJ
   2GW3UV/J3BFukLcwtXWuxJXnKYgOi0vW1RJUC4fhoX74RTmO6b2612pp0
   g==;
X-CSE-ConnectionGUID: atkVysp8Se+KYnsfXSwq0A==
X-CSE-MsgGUID: HVXe36UGQDKPjKBawdpAYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28105103"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28105103"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:41:20 -0700
X-CSE-ConnectionGUID: RQ2qdVKMRr+Bl2WPlnvS0A==
X-CSE-MsgGUID: ynGnbfOHSXaU5XFIW1/LBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77637245"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 10 Oct 2024 22:41:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id EE69F184; Fri, 11 Oct 2024 08:41:15 +0300 (EEST)
Date: Fri, 11 Oct 2024 08:41:15 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dennis Wassenberg <Dennis.Wassenberg@secunet.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mathias Krause <minipli@grsecurity.net>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH] PCI: Fix use-after-free of slot->bus on hot remove
Message-ID: <20241011054115.GG275077@black.fi.intel.com>
References: <4bfd4c0e976c1776cd08e76603903b338cf25729.1728579288.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bfd4c0e976c1776cd08e76603903b338cf25729.1728579288.git.lukas@wunner.de>

Hi,

On Thu, Oct 10, 2024 at 07:10:34PM +0200, Lukas Wunner wrote:
> Dennis reports a boot crash on recent Lenovo laptops with a USB4 dock.
> 
> Since commit 0fc70886569c ("thunderbolt: Reset USB4 v2 host router") and
> commit 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot
> firmware"), USB4 v2 and v1 Host Routers are reset on probe of the
> thunderbolt driver.
> 
> The reset clears the Presence Detect State and Data Link Layer Link Active
> bits at the USB4 Host Router's Root Port and thus causes hot removal of
> the dock.

Can't this happen also simply unplug at some part of the PCIe topology?
I don't think this is specific to TB/USB4.

> The crash occurs when pciehp is unbound from one of the dock's Downstream
> Ports:  pciehp creates a pci_slot on bind and destroys it on unbind.  The
> pci_slot contains a pointer to the pci_bus below the Downstream Port, but
> a reference on that pci_bus is never acquired.  The pci_bus is destroyed
> before the pci_slot, so a use-after-free ensues when pci_slot_release()
> accesses slot->bus.
> 
> In principle this should not happen because pci_stop_bus_device() unbinds
> pciehp (and therefore destroys the pci_slot) before the pci_bus is
> destroyed by pci_remove_bus_device().
> 
> However the stacktrace provided by Dennis shows that pciehp is unbound
> from pci_remove_bus_device() instead of pci_stop_bus_device().
> To understand the significance of this, one needs to know that the PCI
> core uses a two step process to remove a portion of the hierarchy:  It
> first unbinds all drivers in the sub-hierarchy in pci_stop_bus_device()
> and then actually removes the devices in pci_remove_bus_device().
> There is no precaution to prevent driver binding in-between
> pci_stop_bus_device() and pci_remove_bus_device().
> 
> In Dennis' case, it seems removal of the hierarchy by pciehp races with
> driver binding by pci_bus_add_devices().  pciehp is bound to the
> Downstream Port after pci_stop_bus_device() has run, so it is unbound by
> pci_remove_bus_device() instead of pci_stop_bus_device().  Because the
> pci_bus has already been destroyed at that point, accesses to it result in
> a use-after-free.
> 
> One might conclude that driver binding needs to be prevented after
> pci_stop_bus_device() has run.  However it seems risky that pci_slot
> points to pci_bus without holding a reference.  Solely relying on correct
> ordering of driver unbind versus pci_bus destruction is certainly not
> defensive programming.
> 
> If pci_slot has a need to access data in pci_bus, it ought to acquire a
> reference.  Amend pci_create_slot() accordingly.  Dennis reports that the
> crash is not reproducible with this change.
> 
> Abridged stacktrace:
> 
>   pcieport 0000:00:07.0: PME: Signaling with IRQ 156
>   pcieport 0000:00:07.0: pciehp: Slot #12 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
>   pci_bus 0000:20: dev 00, created physical slot 12
>   pcieport 0000:00:07.0: pciehp: Slot(12): Card not present
>   ...
>   pcieport 0000:21:02.0: pciehp: pcie_disable_notification: SLOTCTRL d8 write cmd 0
>   Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 13 UID: 0 PID: 134 Comm: irq/156-pciehp Not tainted 6.11.0-devel+ #1
>   RIP: 0010:dev_driver_string+0x12/0x40
>   pci_destroy_slot
>   pciehp_remove
>   pcie_port_remove_service
>   device_release_driver_internal
>   bus_remove_device
>   device_del
>   device_unregister
>   remove_iter
>   device_for_each_child
>   pcie_portdrv_remove
>   pci_device_remove
>   device_release_driver_internal
>   bus_remove_device
>   device_del
>   pci_remove_bus_device (recursive invocation)
>   pci_remove_bus_device
>   pciehp_unconfigure_device
>   pciehp_disable_slot
>   pciehp_handle_presence_or_link_change
>   pciehp_ist
> 
> Reported-by: Dennis Wassenberg <Dennis.Wassenberg@secunet.com>
> Tested-by: Dennis Wassenberg <Dennis.Wassenberg@secunet.com>
> Closes: https://lore.kernel.org/r/6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

