Return-Path: <linux-pci+bounces-2747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB2841677
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 00:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44261F24629
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE151C37;
	Mon, 29 Jan 2024 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/WjhpOm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A81E51C28;
	Mon, 29 Jan 2024 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569416; cv=none; b=nKh+hUkHIvi+6UU1eUQ9SBxeMZcnaC2eeR9or0GQ1yO4ChDGbhZdV0+/LAaSMbDhj+CwDkywsq9Pe52xZUla+1H10zmCrzykmiQNDoO4b2wKnOM+piDEtxNJyIxcprgYHOSgGZl7tBxGZlMB8gXOdEmFhZZQAbWc63SCoUF4bIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569416; c=relaxed/simple;
	bh=j8YNS5RM2ehR91Bb8qJHFnLgXurZ3AiCzbt4xD1WmOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R7kRcg7Ux+5qli9r7zWPY+lki36lBE/8JoHHl5+NRiZleY5J+G99WsIOh77dXXMMAj2/dpCVqBPt6N1Cxmxn7OuyqIaKR1wKvdjPxu3SljimvK8S8ltmBK6qRFdFeaUsb9yBelCFgr1VWrrTJvIn9RdcGMxWXyDfYUsszRckH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/WjhpOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDA7C433F1;
	Mon, 29 Jan 2024 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706569416;
	bh=j8YNS5RM2ehR91Bb8qJHFnLgXurZ3AiCzbt4xD1WmOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H/WjhpOmVfxs/sHmEaFO/ZCyzsa6Pdy5OMkLq8KdC1iQ01qQ724hCjggz91I0PH0b
	 8u78JqCm606Uh0/ykWI8Luki+Rrv8wq6yKoeWDv9iLHu66Ab1cJXwWp8HW3TfWt6RZ
	 YXYQP0DBhUQDImHAGzAr4DHheobWK7R7XBiRnmPskTH7/Wpf3WOYpofLYnbDzr150J
	 LyWFCfjOo4lRo21ynAmV73oXDcrDFjVBfTrP3ZMUkiLu60ieeFGa9vwKZdkAT8vAwh
	 Clg/CxYsPBP5sIjp31BaNhnzgSrKPFkdlRTl/s/RjqbpfR76hmRiO90Qb5DWmRuqIJ
	 NAt8SoM1gXA8Q==
Date: Mon, 29 Jan 2024 17:03:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Place interrupt related code into irq.c
Message-ID: <20240129230334.GA480827@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129113655.3368-1-ilpo.jarvinen@linux.intel.com>

On Mon, Jan 29, 2024 at 01:36:54PM +0200, Ilpo Järvinen wrote:
> Interrupt related code is spread into irq.c, pci.c, and setup-irq.c.
> Group them into pre-existing irq.c.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/enumeration for v6.9, thanks.

> ---
>  drivers/pci/Makefile     |   2 +-
>  drivers/pci/irq.c        | 204 +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c |   9 --
>  drivers/pci/pci.c        | 144 ---------------------------
>  drivers/pci/setup-irq.c  |  64 ------------
>  5 files changed, 205 insertions(+), 218 deletions(-)
>  delete mode 100644 drivers/pci/setup-irq.c
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index cc8b4e01e29d..54a7adf0bb88 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -5,7 +5,7 @@
>  obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
>  				   remove.o pci.o pci-driver.o search.o \
>  				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
> -				   setup-bus.o vc.o mmap.o setup-irq.o
> +				   setup-bus.o vc.o mmap.o
>  
>  obj-$(CONFIG_PCI)		+= msi/
>  obj-$(CONFIG_PCI)		+= pcie/
> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> index 0050e8f6814e..4555630be9ec 100644
> --- a/drivers/pci/irq.c
> +++ b/drivers/pci/irq.c
> @@ -8,9 +8,13 @@
>  
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/interrupt.h>
>  #include <linux/pci.h>
>  
> +#include "pci.h"
> +
>  /**
>   * pci_request_irq - allocate an interrupt line for a PCI device
>   * @dev:	PCI device to operate on
> @@ -74,3 +78,203 @@ void pci_free_irq(struct pci_dev *dev, unsigned int nr, void *dev_id)
>  	kfree(free_irq(pci_irq_vector(dev, nr), dev_id));
>  }
>  EXPORT_SYMBOL(pci_free_irq);
> +
> +/**
> + * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
> + * @dev: the PCI device
> + * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
> + *
> + * Perform INTx swizzling for a device behind one level of bridge.  This is
> + * required by section 9.1 of the PCI-to-PCI bridge specification for devices
> + * behind bridges on add-in cards.  For devices with ARI enabled, the slot
> + * number is always 0 (see the Implementation Note in section 2.2.8.1 of
> + * the PCI Express Base Specification, Revision 2.1)
> + */
> +u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin)
> +{
> +	int slot;
> +
> +	if (pci_ari_enabled(dev->bus))
> +		slot = 0;
> +	else
> +		slot = PCI_SLOT(dev->devfn);
> +
> +	return (((pin - 1) + slot) % 4) + 1;
> +}
> +
> +int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
> +{
> +	u8 pin;
> +
> +	pin = dev->pin;
> +	if (!pin)
> +		return -1;
> +
> +	while (!pci_is_root_bus(dev->bus)) {
> +		pin = pci_swizzle_interrupt_pin(dev, pin);
> +		dev = dev->bus->self;
> +	}
> +	*bridge = dev;
> +	return pin;
> +}
> +
> +/**
> + * pci_common_swizzle - swizzle INTx all the way to root bridge
> + * @dev: the PCI device
> + * @pinp: pointer to the INTx pin value (1=INTA, 2=INTB, 3=INTD, 4=INTD)
> + *
> + * Perform INTx swizzling for a device.  This traverses through all PCI-to-PCI
> + * bridges all the way up to a PCI root bus.
> + */
> +u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
> +{
> +	u8 pin = *pinp;
> +
> +	while (!pci_is_root_bus(dev->bus)) {
> +		pin = pci_swizzle_interrupt_pin(dev, pin);
> +		dev = dev->bus->self;
> +	}
> +	*pinp = pin;
> +	return PCI_SLOT(dev->devfn);
> +}
> +EXPORT_SYMBOL_GPL(pci_common_swizzle);
> +
> +void pci_assign_irq(struct pci_dev *dev)
> +{
> +	u8 pin;
> +	u8 slot = -1;
> +	int irq = 0;
> +	struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
> +
> +	if (!(hbrg->map_irq)) {
> +		pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
> +		return;
> +	}
> +
> +	/*
> +	 * If this device is not on the primary bus, we need to figure out
> +	 * which interrupt pin it will come in on. We know which slot it
> +	 * will come in on because that slot is where the bridge is. Each
> +	 * time the interrupt line passes through a PCI-PCI bridge we must
> +	 * apply the swizzle function.
> +	 */
> +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> +	/* Cope with illegal. */
> +	if (pin > 4)
> +		pin = 1;
> +
> +	if (pin) {
> +		/* Follow the chain of bridges, swizzling as we go. */
> +		if (hbrg->swizzle_irq)
> +			slot = (*(hbrg->swizzle_irq))(dev, &pin);
> +
> +		/*
> +		 * If a swizzling function is not used, map_irq() must
> +		 * ignore slot.
> +		 */
> +		irq = (*(hbrg->map_irq))(dev, slot, pin);
> +		if (irq == -1)
> +			irq = 0;
> +	}
> +	dev->irq = irq;
> +
> +	pci_dbg(dev, "assign IRQ: got %d\n", dev->irq);
> +
> +	/*
> +	 * Always tell the device, so the driver knows what is the real IRQ
> +	 * to use; the device does not use it.
> +	 */
> +	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
> +}
> +
> +static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	bool mask_updated = true;
> +	u32 cmd_status_dword;
> +	u16 origcmd, newcmd;
> +	unsigned long flags;
> +	bool irq_pending;
> +
> +	/*
> +	 * We do a single dword read to retrieve both command and status.
> +	 * Document assumptions that make this possible.
> +	 */
> +	BUILD_BUG_ON(PCI_COMMAND % 4);
> +	BUILD_BUG_ON(PCI_COMMAND + 2 != PCI_STATUS);
> +
> +	raw_spin_lock_irqsave(&pci_lock, flags);
> +
> +	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
> +
> +	irq_pending = (cmd_status_dword >> 16) & PCI_STATUS_INTERRUPT;
> +
> +	/*
> +	 * Check interrupt status register to see whether our device
> +	 * triggered the interrupt (when masking) or the next IRQ is
> +	 * already pending (when unmasking).
> +	 */
> +	if (mask != irq_pending) {
> +		mask_updated = false;
> +		goto done;
> +	}
> +
> +	origcmd = cmd_status_dword;
> +	newcmd = origcmd & ~PCI_COMMAND_INTX_DISABLE;
> +	if (mask)
> +		newcmd |= PCI_COMMAND_INTX_DISABLE;
> +	if (newcmd != origcmd)
> +		bus->ops->write(bus, dev->devfn, PCI_COMMAND, 2, newcmd);
> +
> +done:
> +	raw_spin_unlock_irqrestore(&pci_lock, flags);
> +
> +	return mask_updated;
> +}
> +
> +/**
> + * pci_check_and_mask_intx - mask INTx on pending interrupt
> + * @dev: the PCI device to operate on
> + *
> + * Check if the device dev has its INTx line asserted, mask it and return
> + * true in that case. False is returned if no interrupt was pending.
> + */
> +bool pci_check_and_mask_intx(struct pci_dev *dev)
> +{
> +	return pci_check_and_set_intx_mask(dev, true);
> +}
> +EXPORT_SYMBOL_GPL(pci_check_and_mask_intx);
> +
> +/**
> + * pci_check_and_unmask_intx - unmask INTx if no interrupt is pending
> + * @dev: the PCI device to operate on
> + *
> + * Check if the device dev has its INTx line asserted, unmask it if not and
> + * return true. False is returned and the mask remains active if there was
> + * still an interrupt pending.
> + */
> +bool pci_check_and_unmask_intx(struct pci_dev *dev)
> +{
> +	return pci_check_and_set_intx_mask(dev, false);
> +}
> +EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
> +
> +/**
> + * pcibios_penalize_isa_irq - penalize an ISA IRQ
> + * @irq: ISA IRQ to penalize
> + * @active: IRQ active or not
> + *
> + * Permits the platform to provide architecture-specific functionality when
> + * penalizing ISA IRQs. This is the default implementation. Architecture
> + * implementations can override this.
> + */
> +void __weak pcibios_penalize_isa_irq(int irq, int active) {}
> +
> +int __weak pcibios_alloc_irq(struct pci_dev *dev)
> +{
> +	return 0;
> +}
> +
> +void __weak pcibios_free_irq(struct pci_dev *dev)
> +{
> +}
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 51ec9e7e784f..ec838f2e892e 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -419,15 +419,6 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
>  	return error;
>  }
>  
> -int __weak pcibios_alloc_irq(struct pci_dev *dev)
> -{
> -	return 0;
> -}
> -
> -void __weak pcibios_free_irq(struct pci_dev *dev)
> -{
> -}
> -
>  #ifdef CONFIG_PCI_IOV
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
>  {
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8f11a078924..75388584e60d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -24,7 +24,6 @@
>  #include <linux/log2.h>
>  #include <linux/logic_pio.h>
>  #include <linux/pm_wakeup.h>
> -#include <linux/interrupt.h>
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> @@ -2292,17 +2291,6 @@ void __weak pcibios_release_device(struct pci_dev *dev) {}
>   */
>  void __weak pcibios_disable_device(struct pci_dev *dev) {}
>  
> -/**
> - * pcibios_penalize_isa_irq - penalize an ISA IRQ
> - * @irq: ISA IRQ to penalize
> - * @active: IRQ active or not
> - *
> - * Permits the platform to provide architecture-specific functionality when
> - * penalizing ISA IRQs. This is the default implementation. Architecture
> - * implementations can override this.
> - */
> -void __weak pcibios_penalize_isa_irq(int irq, int active) {}
> -
>  static void do_pci_disable_device(struct pci_dev *dev)
>  {
>  	u16 pci_command;
> @@ -3964,66 +3952,6 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  }
>  EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
>  
> -/**
> - * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
> - * @dev: the PCI device
> - * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
> - *
> - * Perform INTx swizzling for a device behind one level of bridge.  This is
> - * required by section 9.1 of the PCI-to-PCI bridge specification for devices
> - * behind bridges on add-in cards.  For devices with ARI enabled, the slot
> - * number is always 0 (see the Implementation Note in section 2.2.8.1 of
> - * the PCI Express Base Specification, Revision 2.1)
> - */
> -u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin)
> -{
> -	int slot;
> -
> -	if (pci_ari_enabled(dev->bus))
> -		slot = 0;
> -	else
> -		slot = PCI_SLOT(dev->devfn);
> -
> -	return (((pin - 1) + slot) % 4) + 1;
> -}
> -
> -int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
> -{
> -	u8 pin;
> -
> -	pin = dev->pin;
> -	if (!pin)
> -		return -1;
> -
> -	while (!pci_is_root_bus(dev->bus)) {
> -		pin = pci_swizzle_interrupt_pin(dev, pin);
> -		dev = dev->bus->self;
> -	}
> -	*bridge = dev;
> -	return pin;
> -}
> -
> -/**
> - * pci_common_swizzle - swizzle INTx all the way to root bridge
> - * @dev: the PCI device
> - * @pinp: pointer to the INTx pin value (1=INTA, 2=INTB, 3=INTD, 4=INTD)
> - *
> - * Perform INTx swizzling for a device.  This traverses through all PCI-to-PCI
> - * bridges all the way up to a PCI root bus.
> - */
> -u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
> -{
> -	u8 pin = *pinp;
> -
> -	while (!pci_is_root_bus(dev->bus)) {
> -		pin = pci_swizzle_interrupt_pin(dev, pin);
> -		dev = dev->bus->self;
> -	}
> -	*pinp = pin;
> -	return PCI_SLOT(dev->devfn);
> -}
> -EXPORT_SYMBOL_GPL(pci_common_swizzle);
> -
>  /**
>   * pci_release_region - Release a PCI bar
>   * @pdev: PCI device whose resources were previously reserved by
> @@ -4737,78 +4665,6 @@ void pci_intx(struct pci_dev *pdev, int enable)
>  }
>  EXPORT_SYMBOL_GPL(pci_intx);
>  
> -static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
> -{
> -	struct pci_bus *bus = dev->bus;
> -	bool mask_updated = true;
> -	u32 cmd_status_dword;
> -	u16 origcmd, newcmd;
> -	unsigned long flags;
> -	bool irq_pending;
> -
> -	/*
> -	 * We do a single dword read to retrieve both command and status.
> -	 * Document assumptions that make this possible.
> -	 */
> -	BUILD_BUG_ON(PCI_COMMAND % 4);
> -	BUILD_BUG_ON(PCI_COMMAND + 2 != PCI_STATUS);
> -
> -	raw_spin_lock_irqsave(&pci_lock, flags);
> -
> -	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
> -
> -	irq_pending = (cmd_status_dword >> 16) & PCI_STATUS_INTERRUPT;
> -
> -	/*
> -	 * Check interrupt status register to see whether our device
> -	 * triggered the interrupt (when masking) or the next IRQ is
> -	 * already pending (when unmasking).
> -	 */
> -	if (mask != irq_pending) {
> -		mask_updated = false;
> -		goto done;
> -	}
> -
> -	origcmd = cmd_status_dword;
> -	newcmd = origcmd & ~PCI_COMMAND_INTX_DISABLE;
> -	if (mask)
> -		newcmd |= PCI_COMMAND_INTX_DISABLE;
> -	if (newcmd != origcmd)
> -		bus->ops->write(bus, dev->devfn, PCI_COMMAND, 2, newcmd);
> -
> -done:
> -	raw_spin_unlock_irqrestore(&pci_lock, flags);
> -
> -	return mask_updated;
> -}
> -
> -/**
> - * pci_check_and_mask_intx - mask INTx on pending interrupt
> - * @dev: the PCI device to operate on
> - *
> - * Check if the device dev has its INTx line asserted, mask it and return
> - * true in that case. False is returned if no interrupt was pending.
> - */
> -bool pci_check_and_mask_intx(struct pci_dev *dev)
> -{
> -	return pci_check_and_set_intx_mask(dev, true);
> -}
> -EXPORT_SYMBOL_GPL(pci_check_and_mask_intx);
> -
> -/**
> - * pci_check_and_unmask_intx - unmask INTx if no interrupt is pending
> - * @dev: the PCI device to operate on
> - *
> - * Check if the device dev has its INTx line asserted, unmask it if not and
> - * return true. False is returned and the mask remains active if there was
> - * still an interrupt pending.
> - */
> -bool pci_check_and_unmask_intx(struct pci_dev *dev)
> -{
> -	return pci_check_and_set_intx_mask(dev, false);
> -}
> -EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
> -
>  /**
>   * pci_wait_for_pending_transaction - wait for pending transaction
>   * @dev: the PCI device to operate on
> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> deleted file mode 100644
> index cc7d26b015f3..000000000000
> --- a/drivers/pci/setup-irq.c
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Support routines for initializing a PCI subsystem
> - *
> - * Extruded from code written by
> - *      Dave Rusling (david.rusling@reo.mts.dec.com)
> - *      David Mosberger (davidm@cs.arizona.edu)
> - *	David Miller (davem@redhat.com)
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/pci.h>
> -#include <linux/errno.h>
> -#include <linux/ioport.h>
> -#include <linux/cache.h>
> -#include "pci.h"
> -
> -void pci_assign_irq(struct pci_dev *dev)
> -{
> -	u8 pin;
> -	u8 slot = -1;
> -	int irq = 0;
> -	struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
> -
> -	if (!(hbrg->map_irq)) {
> -		pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
> -		return;
> -	}
> -
> -	/*
> -	 * If this device is not on the primary bus, we need to figure out
> -	 * which interrupt pin it will come in on. We know which slot it
> -	 * will come in on because that slot is where the bridge is. Each
> -	 * time the interrupt line passes through a PCI-PCI bridge we must
> -	 * apply the swizzle function.
> -	 */
> -	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> -	/* Cope with illegal. */
> -	if (pin > 4)
> -		pin = 1;
> -
> -	if (pin) {
> -		/* Follow the chain of bridges, swizzling as we go. */
> -		if (hbrg->swizzle_irq)
> -			slot = (*(hbrg->swizzle_irq))(dev, &pin);
> -
> -		/*
> -		 * If a swizzling function is not used, map_irq() must
> -		 * ignore slot.
> -		 */
> -		irq = (*(hbrg->map_irq))(dev, slot, pin);
> -		if (irq == -1)
> -			irq = 0;
> -	}
> -	dev->irq = irq;
> -
> -	pci_dbg(dev, "assign IRQ: got %d\n", dev->irq);
> -
> -	/*
> -	 * Always tell the device, so the driver knows what is the real IRQ
> -	 * to use; the device does not use it.
> -	 */
> -	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
> -}
> -- 
> 2.39.2
> 

