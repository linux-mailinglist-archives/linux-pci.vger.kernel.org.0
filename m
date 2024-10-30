Return-Path: <linux-pci+bounces-15660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E001C9B6F53
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600E21F23773
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344222A49F;
	Wed, 30 Oct 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKgtfj98"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861C229B34
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324140; cv=none; b=qgBYU6cJOHl1yvHEKFte/Pu3fDXO6w0yul4A4ZXn4EVMmjP2uQjvKsHVuwBGRTQky7Gb0hynEkM4/p4QvXRpkRTt/9JA/wbvHJK3G960xZM5c6jnwS2ITXMGlVuYeOTWJQRGtvme36EP08CkX/bs4zlRtMfgGONDTUetyaAntlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324140; c=relaxed/simple;
	bh=P9fVyRwNZAe8XW/cQVnHFXYjzJ+A+9altMVqkfUS/sI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H5bpHmyOPoihG0wVuLyt2GHa8JyULPLgEtQA/b+ZnXzBG0Gd3DLCm+zmpuFnlIUfIGo0ta7r/TFXEP4lB+F25NU9NnXoRPMUVl/jlRWssMCefVJCkvr3E4kxWhOvU8Av/eqg6Dcxnfjcdf5fekh0KnhZrbKdXgkZaEEDoxR5EeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKgtfj98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D113FC4CED1;
	Wed, 30 Oct 2024 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730324140;
	bh=P9fVyRwNZAe8XW/cQVnHFXYjzJ+A+9altMVqkfUS/sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QKgtfj98GbV6ouLUeEtQDGCclPNNXm8H9fYzgSR4MgAMejq2PCCwUEMgJUvImOvRX
	 DxJ63nzzfz9cXyldCDaKxxWG5cbu6I8X79oU9QPks29rm/PpXG9Y190tdAKWbuQqUV
	 B9mVatrPcTD21Lb20T5B7NPnoYS23vVrwIEaefWFs6/vONurakUjmHncmeYy1bbADD
	 4UpYzozmPa5L/dQZcL1jWHiKJ/5Jf0yqDRmjY3WfYc6yD+R3wEuEbpsP+cjfmVqWHH
	 4uVttN+O4l47cKRH2RchvN9xlA8edJihELJbX8t8GZ7GOyD9E5zuGCX8w/7hkPSsXc
	 gwOZobF23uisg==
Date: Wed, 30 Oct 2024 16:35:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dennis Wassenberg <Dennis.Wassenberg@secunet.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mathias Krause <minipli@grsecurity.net>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH] PCI: Fix use-after-free of slot->bus on hot remove
Message-ID: <20241030213538.GA1221873@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bfd4c0e976c1776cd08e76603903b338cf25729.1728579288.git.lukas@wunner.de>

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
> 
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
> Cc: stable@vger.kernel.org

Applied with Mika's reviewed-by to pci/hotplug for v6.13, thanks!

> ---
> I am tempted to remove the call to device_release_driver() from
> pci_stop_dev() and just rely on driver unbinding by device_del().
> It would simplify and rationalize the code.  The call was introduced by
> commit c4a0a5d964e9 (PCI: Move device_del() from pci_stop_dev() to
> pci_destroy_dev()) without providing an explicit reason.
> 
> Dennis stress-tested driver unbinding via device_del() without witnessing
> any problems.  The only downside I see is that it would re-introduce the
> cosmetic issue avoided by commit 16b6c8bb687c ("PCI: Detach driver before
> procfs & sysfs teardown on device remove").
> 
> Preventing driver binding after pci_stop_bus_device() should be achieved
> by this one-line patch, though that's still racy as pci_bus_add_devices()
> might revert the match_driver flag to true after pci_stop_bus_device() has
> set it to false:
> https://lore.kernel.org/r/Zv-dIHDXNNYomG2Y@wunner.de/
> 
> An alternative would be to serialize removal of the hierarchy with
> pci_bus_add_devices() by way of pci_lock_rescan_remove():
> https://lore.kernel.org/r/20241003084342.27501-1-brgl@bgdev.pl/
> 
> Both approaches are yet to be tested by Dennis.  Personally I would like
> to avoid the pci_lock_rescan_remove() approach.  We should try to move
> away from this big lock and use finer grained locking instead.  So again,
> just dropping the call to device_release_driver() would be the simplest
> and most preferred approach from my point of view.  Thoughts?
> 
>  drivers/pci/slot.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 0f87cad..ed645c7 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -79,6 +79,7 @@ static void pci_slot_release(struct kobject *kobj)
>  	up_read(&pci_bus_sem);
>  
>  	list_del(&slot->list);
> +	pci_bus_put(slot->bus);
>  
>  	kfree(slot);
>  }
> @@ -261,7 +262,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  		goto err;
>  	}
>  
> -	slot->bus = parent;
> +	slot->bus = pci_bus_get(parent);
>  	slot->number = slot_nr;
>  
>  	slot->kobj.kset = pci_slots_kset;
> @@ -269,6 +270,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	slot_name = make_slot_name(name);
>  	if (!slot_name) {
>  		err = -ENOMEM;
> +		pci_bus_put(slot->bus);
>  		kfree(slot);
>  		goto err;
>  	}
> -- 
> 2.43.0
> 

