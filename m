Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01C47298E3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 14:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjFIMAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFIMAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 08:00:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298E3E4A;
        Fri,  9 Jun 2023 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686312013; x=1717848013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g2+v2F/C3dq9bX4UCNTaty4eQZoKwwlzegzB9UQvZtE=;
  b=OF40xkCGDW3DycWDnpRKEFbTjxfFweHKQ3zIwXZWuczGnfoTM7CTGDwe
   +xJ0RC1c/wriCKNbjvSPdbpBSa+ohihR4fzi2rNRFbE7cfdVzGbUNuLB2
   xTjl33DLzm/O1zwiFztixvoBk8LepryRNgRO72D3XLdcU79uH4tKz+mB4
   XoHlZy5hDKWY8I1MoeuBMouAlsGCrFaK6M/V5sv4ZLJr3b4Lgzu8f9ffw
   5zopz7v0JzQYgN7t4SbdO6UkC+trbsRTC4OraMt3kjV3NAtsgUHp9qpw6
   WK0gg6hsvlK46Z5zBOdC9aEFZSkjZSDfMtAxVI3M7cY0LewDmZaj2kYUd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356472039"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="356472039"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 05:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="1040478414"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="1040478414"
Received: from lmirabel-mobl1.ger.corp.intel.com (HELO intel.com) ([10.251.211.108])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 05:00:08 -0700
Date:   Fri, 9 Jun 2023 14:00:00 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 3/4] PCI/VGA: Tidy up the code and comment format
Message-ID: <ZIMUQCuxLG4x1FP0@ashyti-mobl2.lan>
References: <20230609112417.632313-1-suijingfeng@loongson.cn>
 <20230609112417.632313-3-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609112417.632313-3-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sui,

On Fri, Jun 09, 2023 at 07:24:16PM +0800, Sui Jingfeng wrote:
> This patch replaces the leading space with a tab and removes the double
> blank line, no functional change.

You mainly fixed comment style, though and it's not written here.

No need to resend for me as you also wrote it in the title. But
next time please list all the changes in the commit log.

> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi

> ---
>  drivers/pci/vgaarb.c   | 108 ++++++++++++++++++++++++-----------------
>  include/linux/vgaarb.h |   4 +-
>  2 files changed, 65 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 22a505e877dc..ceb914245383 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -61,7 +61,6 @@ static bool vga_arbiter_used;
>  static DEFINE_SPINLOCK(vga_lock);
>  static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
>  
> -
>  static const char *vga_iostate_to_str(unsigned int iostate)
>  {
>  	/* Ignore VGA_RSRC_IO and VGA_RSRC_MEM */
> @@ -79,8 +78,10 @@ static const char *vga_iostate_to_str(unsigned int iostate)
>  
>  static int vga_str_to_iostate(char *buf, int str_size, unsigned int *io_state)
>  {
> -	/* we could in theory hand out locks on IO and mem
> -	 * separately to userspace but it can cause deadlocks */
> +	/*
> +	 * We could in theory hand out locks on IO and mem
> +	 * separately to userspace but it can cause deadlocks
> +	 */
>  	if (strncmp(buf, "none", 4) == 0) {
>  		*io_state = VGA_RSRC_NONE;
>  		return 1;
> @@ -99,7 +100,7 @@ static int vga_str_to_iostate(char *buf, int str_size, unsigned int *io_state)
>  	return 1;
>  }
>  
> -/* this is only used a cookie - it should not be dereferenced */
> +/* This is only used as cookie, it should not be dereferenced */
>  static struct pci_dev *vga_default;
>  
>  /* Find somebody in our list */
> @@ -193,14 +194,17 @@ int vga_remove_vgacon(struct pci_dev *pdev)
>  #endif
>  EXPORT_SYMBOL(vga_remove_vgacon);
>  
> -/* If we don't ever use VGA arb we should avoid
> -   turning off anything anywhere due to old X servers getting
> -   confused about the boot device not being VGA */
> +/*
> + * If we don't ever use VGA arb we should avoid
> + * turning off anything anywhere due to old X servers getting
> + * confused about the boot device not being VGA
> + */
>  static void vga_check_first_use(void)
>  {
> -	/* we should inform all GPUs in the system that
> -	 * VGA arb has occurred and to try and disable resources
> -	 * if they can */
> +	/*
> +	 * We should inform all GPUs in the system that
> +	 * vgaarb has occurred and to try and disable resources if they can
> +	 */
>  	if (!vga_arbiter_used) {
>  		vga_arbiter_used = true;
>  		vga_arbiter_notify_clients();
> @@ -216,7 +220,8 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  	unsigned int pci_bits;
>  	u32 flags = 0;
>  
> -	/* Account for "normal" resources to lock. If we decode the legacy,
> +	/*
> +	 * Account for "normal" resources to lock. If we decode the legacy,
>  	 * counterpart, we need to request it as well
>  	 */
>  	if ((rsrc & VGA_RSRC_NORMAL_IO) &&
> @@ -236,7 +241,8 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  	if (wants == 0)
>  		goto lock_them;
>  
> -	/* We don't need to request a legacy resource, we just enable
> +	/*
> +	 * We don't need to request a legacy resource, we just enable
>  	 * appropriate decoding and go
>  	 */
>  	legacy_wants = wants & VGA_RSRC_LEGACY_MASK;
> @@ -252,7 +258,8 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  		if (vgadev == conflict)
>  			continue;
>  
> -		/* We have a possible conflict. before we go further, we must
> +		/*
> +		 * We have a possible conflict. before we go further, we must
>  		 * check if we sit on the same bus as the conflicting device.
>  		 * if we don't, then we must tie both IO and MEM resources
>  		 * together since there is only a single bit controlling
> @@ -263,13 +270,15 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  			lwants = VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
>  		}
>  
> -		/* Check if the guy has a lock on the resource. If he does,
> +		/*
> +		 * Check if the guy has a lock on the resource. If he does,
>  		 * return the conflicting entry
>  		 */
>  		if (conflict->locks & lwants)
>  			return conflict;
>  
> -		/* Ok, now check if it owns the resource we want.  We can
> +		/*
> +		 * Ok, now check if it owns the resource we want.  We can
>  		 * lock resources that are not decoded, therefore a device
>  		 * can own resources it doesn't decode.
>  		 */
> @@ -277,14 +286,16 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  		if (!match)
>  			continue;
>  
> -		/* looks like he doesn't have a lock, we can steal
> +		/*
> +		 * Looks like he doesn't have a lock, we can steal
>  		 * them from him
>  		 */
>  
>  		flags = 0;
>  		pci_bits = 0;
>  
> -		/* If we can't control legacy resources via the bridge, we
> +		/*
> +		 * If we can't control legacy resources via the bridge, we
>  		 * also need to disable normal decoding.
>  		 */
>  		if (!conflict->bridge_has_one_vga) {
> @@ -311,7 +322,8 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  	}
>  
>  enable_them:
> -	/* ok dude, we got it, everybody conflicting has been disabled, let's
> +	/*
> +	 * Ok dude, we got it, everybody conflicting has been disabled, let's
>  	 * enable us.  Mark any bits in "owns" regardless of whether we
>  	 * decoded them.  We can lock resources we don't decode, therefore
>  	 * we must track them via "owns".
> @@ -353,7 +365,8 @@ static void __vga_put(struct vga_device *vgadev, unsigned int rsrc)
>  
>  	vgaarb_dbg(dev, "%s\n", __func__);
>  
> -	/* Update our counters, and account for equivalent legacy resources
> +	/*
> +	 * Update our counters, and account for equivalent legacy resources
>  	 * if we decode them
>  	 */
>  	if ((rsrc & VGA_RSRC_NORMAL_IO) && vgadev->io_norm_cnt > 0) {
> @@ -371,7 +384,8 @@ static void __vga_put(struct vga_device *vgadev, unsigned int rsrc)
>  	if ((rsrc & VGA_RSRC_LEGACY_MEM) && vgadev->mem_lock_cnt > 0)
>  		vgadev->mem_lock_cnt--;
>  
> -	/* Just clear lock bits, we do lazy operations so we don't really
> +	/*
> +	 * Just clear lock bits, we do lazy operations so we don't really
>  	 * have to bother about anything else at this point
>  	 */
>  	if (vgadev->io_lock_cnt == 0)
> @@ -379,7 +393,8 @@ static void __vga_put(struct vga_device *vgadev, unsigned int rsrc)
>  	if (vgadev->mem_lock_cnt == 0)
>  		vgadev->locks &= ~VGA_RSRC_LEGACY_MEM;
>  
> -	/* Kick the wait queue in case somebody was waiting if we actually
> +	/*
> +	 * Kick the wait queue in case somebody was waiting if we actually
>  	 * released something
>  	 */
>  	if (old_locks != vgadev->locks)
> @@ -447,8 +462,8 @@ int vga_get(struct pci_dev *pdev, unsigned int rsrc, int interruptible)
>  		if (conflict == NULL)
>  			break;
>  
> -
> -		/* We have a conflict, we wait until somebody kicks the
> +		/*
> +		 * We have a conflict, we wait until somebody kicks the
>  		 * work queue. Currently we have one work queue that we
>  		 * kick each time some resources are released, but it would
>  		 * be fairly easy to have a per device one so that we only
> @@ -665,7 +680,7 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
>  	}
>  
>  	/*
> -	 * vgadev has neither IO nor MEM enabled.  If we haven't found any
> +	 * Vgadev has neither IO nor MEM enabled.  If we haven't found any
>  	 * other VGA devices, it is the best candidate so far.
>  	 */
>  	if (!boot_vga)
> @@ -706,7 +721,7 @@ static void vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
>  			bus = same_bridge_vgadev->pdev->bus;
>  			bridge = bus->self;
>  
> -			/* see if the share a bridge with this device */
> +			/* See if the share a bridge with this device */
>  			if (new_bridge == bridge) {
>  				/*
>  				 * If their direct parent bridge is the same
> @@ -777,9 +792,10 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>  	vgadev->decodes = VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
>  			  VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>  
> -	/* by default mark it as decoding */
> +	/* By default, mark it as decoding */
>  	vga_decode_count++;
> -	/* Mark that we "own" resources based on our enables, we will
> +	/*
> +	 * Mark that we "own" resources based on our enables, we will
>  	 * clear that below if the bridge isn't forwarding
>  	 */
>  	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> @@ -860,7 +876,7 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
>  	return ret;
>  }
>  
> -/* this is called with the lock */
> +/* This is called with the lock */
>  static inline void vga_update_device_decodes(struct vga_device *vgadev,
>  					     int new_decodes)
>  {
> @@ -877,7 +893,7 @@ static inline void vga_update_device_decodes(struct vga_device *vgadev,
>  		vga_iostate_to_str(vgadev->decodes),
>  		vga_iostate_to_str(vgadev->owns));
>  
> -	/* if we removed locked decodes, lock count goes to zero, and release */
> +	/* If we removed locked decodes, lock count goes to zero, and release */
>  	if (decodes_unlocked) {
>  		if (decodes_unlocked & VGA_RSRC_LEGACY_IO)
>  			vgadev->io_lock_cnt = 0;
> @@ -886,7 +902,7 @@ static inline void vga_update_device_decodes(struct vga_device *vgadev,
>  		__vga_put(vgadev, decodes_unlocked);
>  	}
>  
> -	/* change decodes counter */
> +	/* Change decodes counter */
>  	if (old_decodes & VGA_RSRC_LEGACY_MASK &&
>  	    !(new_decodes & VGA_RSRC_LEGACY_MASK))
>  		vga_decode_count--;
> @@ -910,14 +926,15 @@ static void __vga_set_legacy_decoding(struct pci_dev *pdev,
>  	if (vgadev == NULL)
>  		goto bail;
>  
> -	/* don't let userspace futz with kernel driver decodes */
> +	/* Don't let userspace futz with kernel driver decodes */
>  	if (userspace && vgadev->set_decode)
>  		goto bail;
>  
> -	/* update the device decodes + counter */
> +	/* Update the device decodes + counter */
>  	vga_update_device_decodes(vgadev, decodes);
>  
> -	/* XXX if somebody is going from "doesn't decode" to "decodes" state
> +	/*
> +	 * XXX if somebody is going from "doesn't decode" to "decodes" state
>  	 * here, additional care must be taken as we may have pending owner
>  	 * ship of non-legacy region ...
>  	 */
> @@ -952,9 +969,9 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
>   * @set_decode callback: If a client can disable its GPU VGA resource, it
>   * will get a callback from this to set the encode/decode state.
>   *
> - * Rationale: we cannot disable VGA decode resources unconditionally some single
> - * GPU laptops seem to require ACPI or BIOS access to the VGA registers to
> - * control things like backlights etc.  Hopefully newer multi-GPU laptops do
> + * Rationale: we cannot disable VGA decode resources unconditionally, some
> + * single GPU laptops seem to require ACPI or BIOS access to the VGA registers
> + * to control things like backlights etc. Hopefully newer multi-GPU laptops do
>   * something saner, and desktops won't have any special ACPI for this. The
>   * driver will get a callback when VGA arbitration is first used by userspace
>   * since some older X servers have issues.
> @@ -984,7 +1001,6 @@ int vga_client_register(struct pci_dev *pdev,
>  bail:
>  	spin_unlock_irqrestore(&vga_lock, flags);
>  	return ret;
> -
>  }
>  EXPORT_SYMBOL(vga_client_register);
>  
> @@ -1075,7 +1091,6 @@ static int vga_pci_str_to_vars(char *buf, int count, unsigned int *domain,
>  	int n;
>  	unsigned int slot, func;
>  
> -
>  	n = sscanf(buf, "PCI:%x:%x:%x.%x", domain, bus, &slot, &func);
>  	if (n != 4)
>  		return 0;
> @@ -1310,7 +1325,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		curr_pos += 7;
>  		remaining -= 7;
>  		pr_debug("client 0x%p called 'target'\n", priv);
> -		/* if target is default */
> +		/* If target is default */
>  		if (!strncmp(curr_pos, "default", 7))
>  			pdev = pci_dev_get(vga_default_device());
>  		else {
> @@ -1427,7 +1442,6 @@ static int vga_arb_open(struct inode *inode, struct file *file)
>  	priv->cards[0].io_cnt = 0;
>  	priv->cards[0].mem_cnt = 0;
>  
> -
>  	return 0;
>  }
>  
> @@ -1461,7 +1475,7 @@ static int vga_arb_release(struct inode *inode, struct file *file)
>  }
>  
>  /*
> - * callback any registered clients to let them know we have a
> + * Callback any registered clients to let them know we have a
>   * change in VGA cards
>   */
>  static void vga_arbiter_notify_clients(void)
> @@ -1500,9 +1514,11 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>  	if (pdev->class != PCI_CLASS_DISPLAY_VGA << 8)
>  		return 0;
>  
> -	/* For now we're only intereted in devices added and removed. I didn't
> +	/*
> +	 * For now we're only intereted in devices added and removed. I didn't
>  	 * test this thing here, so someone needs to double check for the
> -	 * cases of hotplugable vga cards. */
> +	 * cases of hotplugable vga cards.
> +	 */
>  	if (action == BUS_NOTIFY_ADD_DEVICE)
>  		notify = vga_arbiter_add_pci_device(pdev);
>  	else if (action == BUS_NOTIFY_DEL_DEVICE)
> @@ -1543,8 +1559,10 @@ static int __init vga_arb_device_init(void)
>  
>  	bus_register_notifier(&pci_bus_type, &pci_notifier);
>  
> -	/* We add all PCI devices satisfying VGA class in the arbiter by
> -	 * default */
> +	/*
> +	 * We add all PCI devices satisfying VGA class in the arbiter by
> +	 * default
> +	 */
>  	while (1) {
>  		pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev);
>  		if (!pdev)
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index b4b9137f9792..6d5465f8c3f2 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -96,7 +96,7 @@ static inline int vga_client_register(struct pci_dev *pdev,
>  static inline int vga_get_interruptible(struct pci_dev *pdev,
>  					unsigned int rsrc)
>  {
> -       return vga_get(pdev, rsrc, 1);
> +	return vga_get(pdev, rsrc, 1);
>  }
>  
>  /**
> @@ -111,7 +111,7 @@ static inline int vga_get_interruptible(struct pci_dev *pdev,
>  static inline int vga_get_uninterruptible(struct pci_dev *pdev,
>  					  unsigned int rsrc)
>  {
> -       return vga_get(pdev, rsrc, 0);
> +	return vga_get(pdev, rsrc, 0);
>  }
>  
>  static inline void vga_client_unregister(struct pci_dev *pdev)
> -- 
> 2.25.1
