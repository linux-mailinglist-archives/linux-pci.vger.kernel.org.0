Return-Path: <linux-pci+bounces-13285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCA197C194
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 23:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4DBB210B0
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADF1CB30E;
	Wed, 18 Sep 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWjcEzJX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8818A6C5;
	Wed, 18 Sep 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726696373; cv=none; b=fM+JfhL6KUVXcE4UHysb8UUwBrkhCiXucnGOrlvgZdFJpJ0/WP+hDGmaSq94n9HlKDX/mw1Dv4ZAF1fWDXk5AMCwVkBBi9bJBxD7vkwvYq1+SWNZuHdGwYodK1mZgG4UvhNmQJy1oK9/xyfDpNHlXPFInCnSY4BvuK54zg1L4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726696373; c=relaxed/simple;
	bh=KjosWc3YQGl++7cHwuyERfoMjEYoSmUFMJfCENozWAQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jbop9kwUti7CwCBP64WlOpSS7Oatrp+zspxOrJ86AKF5fS7DRosojiiPAJA07FcBVpIGSY3YBkrz5DE6b2q++Vse5vVWCgBHraNbdEtShXubJE2EwzOChZ9cpgmrSu8ZLXv537FseulmXUJ2Nal2uATJli0MxAi+3BF+8gQVIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWjcEzJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C711AC4CEC2;
	Wed, 18 Sep 2024 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726696373;
	bh=KjosWc3YQGl++7cHwuyERfoMjEYoSmUFMJfCENozWAQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dWjcEzJXX4ooRHUXZs1QKRISgq0BU0G8hNkX+kieyzIIGyJKsLFV2tRzO5yYceGcH
	 K7MqyCs1l7uFHSn2AM8V/hxEVmDM01gL5WQ6r+lrAvkxXpRZOqEchapTg1/5N25FzV
	 Z9J38Rzr5VyP5A4Bx36/b9OvnFCLEJ2b0XA1U2kYyX1L2ws5Oedick2Io1uyiaRVg+
	 u13tTohXKkJbw9VooAQCTnxOPvTouaOTcoM9IOkt2An1+bqQ2Hm/PrUpAoH4oxTtIb
	 ZFSJKoN/8RtX7NYroGqxCYTCS6cu8xp7L1Hy/OjV4h7zeTaN6KklRG9LvXy07VePbw
	 ZFSLGUlmA9rUA==
Date: Wed, 18 Sep 2024 14:52:50 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jiqian Chen <Jiqian.Chen@amd.com>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, xen-devel@lists.xenproject.org, 
    linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-acpi@vger.kernel.org, Huang Rui <ray.huang@amd.com>
Subject: Re: [KERNEL PATCH v9 1/3] xen/pci: Add a function to reset device
 for xen
In-Reply-To: <20240912092352.1602724-2-Jiqian.Chen@amd.com>
Message-ID: <alpine.DEB.2.22.394.2409181450280.1417852@ubuntu-linux-20-04-desktop>
References: <20240912092352.1602724-1-Jiqian.Chen@amd.com> <20240912092352.1602724-2-Jiqian.Chen@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Sep 2024, Jiqian Chen wrote:
> When device on dom0 side has been reset, the vpci on Xen side
> won't get notification, so that the cached state in vpci is
> all out of date with the real device state.
> To solve that problem, add a new function to clear all vpci
> device state when device is reset on dom0 side.
> 
> And call that function in pcistub_init_device. Because when
> using "pci-assignable-add" to assign a passthrough device in
> Xen, it will reset passthrough device and the vpci state will
> out of date, and then device will fail to restore bar state.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>


Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>



> ---
> v8->v9 changes:
> Due to the struct and name of the hypercall changed on Xen side, I did the corresponding changes, so removed the Reviewed-by of Stefano. But no function changes actually.
> 
> v5->v8 changes:
> No.
> 
> v4->v5 changes:
> Added Reviewed-by of Stefano.
> 
> v3->v4 changes:
> Changed the code comment of PHYSDEVOP_pci_device_state_reset.
> Used a new function pcistub_reset_device_state to wrap __pci_reset_function_locked and xen_reset_device_state, and called pcistub_reset_device_state in pci_stub.c.
> 
> v2->v3 changes:
> Added condition to limit do xen_reset_device_state for no-pv domain in pcistub_init_device.
> 
> v1->v2 changes:
> New patch to add a new function to call reset hypercall.
> ---
>  drivers/xen/pci.c                  | 13 +++++++++++++
>  drivers/xen/xen-pciback/pci_stub.c | 18 +++++++++++++++---
>  include/xen/interface/physdev.h    | 17 +++++++++++++++++
>  include/xen/pci.h                  |  6 ++++++
>  4 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> index 72d4e3f193af..bb59524b8bbd 100644
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -177,6 +177,19 @@ static int xen_remove_device(struct device *dev)
>  	return r;
>  }
>  
> +int xen_reset_device(const struct pci_dev *dev)
> +{
> +	struct pci_device_reset device = {
> +		.dev.seg = pci_domain_nr(dev->bus),
> +		.dev.bus = dev->bus->number,
> +		.dev.devfn = dev->devfn,
> +		.flags = PCI_DEVICE_RESET_FLR,
> +	};
> +
> +	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_reset, &device);
> +}
> +EXPORT_SYMBOL_GPL(xen_reset_device);
> +
>  static int xen_pci_notifier(struct notifier_block *nb,
>  			    unsigned long action, void *data)
>  {
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index 4faebbb84999..3e162c1753e2 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -89,6 +89,16 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
>  	return psdev;
>  }
>  
> +static int pcistub_reset_device_state(struct pci_dev *dev)
> +{
> +	__pci_reset_function_locked(dev);
> +
> +	if (!xen_pv_domain())
> +		return xen_reset_device(dev);
> +	else
> +		return 0;
> +}
> +
>  /* Don't call this directly as it's called by pcistub_device_put */
>  static void pcistub_device_release(struct kref *kref)
>  {
> @@ -107,7 +117,7 @@ static void pcistub_device_release(struct kref *kref)
>  	/* Call the reset function which does not take lock as this
>  	 * is called from "unbind" which takes a device_lock mutex.
>  	 */
> -	__pci_reset_function_locked(dev);
> +	pcistub_reset_device_state(dev);
>  	if (dev_data &&
>  	    pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
>  		dev_info(&dev->dev, "Could not reload PCI state\n");
> @@ -284,7 +294,7 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
>  	 * (so it's ready for the next domain)
>  	 */
>  	device_lock_assert(&dev->dev);
> -	__pci_reset_function_locked(dev);
> +	pcistub_reset_device_state(dev);
>  
>  	dev_data = pci_get_drvdata(dev);
>  	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
> @@ -420,7 +430,9 @@ static int pcistub_init_device(struct pci_dev *dev)
>  		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
>  	else {
>  		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
> -		__pci_reset_function_locked(dev);
> +		err = pcistub_reset_device_state(dev);
> +		if (err)
> +			goto config_release;
>  		pci_restore_state(dev);
>  	}
>  	/* Now disable the device (this also ensures some private device
> diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
> index a237af867873..df74e65a884b 100644
> --- a/include/xen/interface/physdev.h
> +++ b/include/xen/interface/physdev.h
> @@ -256,6 +256,13 @@ struct physdev_pci_device_add {
>   */
>  #define PHYSDEVOP_prepare_msix          30
>  #define PHYSDEVOP_release_msix          31
> +/*
> + * Notify the hypervisor that a PCI device has been reset, so that any
> + * internally cached state is regenerated.  Should be called after any
> + * device reset performed by the hardware domain.
> + */
> +#define PHYSDEVOP_pci_device_reset      32
> +
>  struct physdev_pci_device {
>      /* IN */
>      uint16_t seg;
> @@ -263,6 +270,16 @@ struct physdev_pci_device {
>      uint8_t devfn;
>  };
>  
> +struct pci_device_reset {
> +    struct physdev_pci_device dev;
> +#define PCI_DEVICE_RESET_COLD 0x0
> +#define PCI_DEVICE_RESET_WARM 0x1
> +#define PCI_DEVICE_RESET_HOT  0x2
> +#define PCI_DEVICE_RESET_FLR  0x3
> +#define PCI_DEVICE_RESET_MASK 0x3
> +    uint32_t flags;
> +};
> +
>  #define PHYSDEVOP_DBGP_RESET_PREPARE    1
>  #define PHYSDEVOP_DBGP_RESET_DONE       2
>  
> diff --git a/include/xen/pci.h b/include/xen/pci.h
> index b8337cf85fd1..424b8ea89ca8 100644
> --- a/include/xen/pci.h
> +++ b/include/xen/pci.h
> @@ -4,10 +4,16 @@
>  #define __XEN_PCI_H__
>  
>  #if defined(CONFIG_XEN_DOM0)
> +int xen_reset_device(const struct pci_dev *dev);
>  int xen_find_device_domain_owner(struct pci_dev *dev);
>  int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
>  int xen_unregister_device_domain_owner(struct pci_dev *dev);
>  #else
> +static inline int xen_reset_device(const struct pci_dev *dev)
> +{
> +	return -1;
> +}
> +
>  static inline int xen_find_device_domain_owner(struct pci_dev *dev)
>  {
>  	return -1;
> -- 
> 2.34.1
> 

