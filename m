Return-Path: <linux-pci+bounces-10227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E332930230
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 00:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D87B213E3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1C97E0F2;
	Fri, 12 Jul 2024 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLORCvSP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE161BDC3;
	Fri, 12 Jul 2024 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720824267; cv=none; b=oXxWHBrdZiMgqrzdh0vtZO4mzMuqQXwYpMzV+lcWXjIq8/30aYsQFGOTRfaNUVGQYM1rZLkew1kTQeNkuzDqpN7rtSV47628/UDDWVN5iB8lL3xnEqxYvPQcyuMs0GxKdFLlMB5gST2wQ1GGKVxxCePmTfJb9n5J/3ubyoZcOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720824267; c=relaxed/simple;
	bh=NIGdh/kMaF+lvONdNDcKSTqVCmA3Hf1AZlPWWBHP8nc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CJdsEYaVvILCwUNILnieWNOdhsygymVVXHWg7OgWEXo8FWnaVBr+vOzeVWDSTsmiGfzQZGwcKHK+XAUg4g32wg9prc7KXdq+AeTg2JDxYaQ++6bWUz0IeecuwlXv4azec1rKEpP9IKmMyO/KEYjqfPpbjZFCIRB+lD1VL7zK9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLORCvSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CD8C32782;
	Fri, 12 Jul 2024 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720824267;
	bh=NIGdh/kMaF+lvONdNDcKSTqVCmA3Hf1AZlPWWBHP8nc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fLORCvSPIfEUSx8ljluhidKnvRkwOx1+BEHl80fkzgizYnAKeooZJEWvA1fQyJnzc
	 kQl3lNIDDP0fdd1SD/VPZqruHbS/GFoGQl0g0nnthdxK8kJzgd7ixyAsjUe1955e3S
	 EKyfIM3Bv8mIGMd8NHsfrUcDpAsdrK5l31pBgylWNpArxSGwRoOdLRnLjnAuJckNER
	 6tT1HZWDdhkqplnlq8lTdomMpqPHbjXhdyH/CaDqzlE47eYeo5cjYKATEm9QXYTGkc
	 tL28quyam9JbJOi7016n8bkoqJ+EkgiskLs9tFk3UtKlL2pyQoKJoleiCM3huYdTqD
	 Kj0wCCDG2pLxw==
Date: Fri, 12 Jul 2024 17:44:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: ngn <ngn@ngn.tf>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: shpchp: Remove hpc_ops
Message-ID: <20240712224425.GA351076@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb0f57ee513af545be761988fa9ad5ce5703060.1718949042.git.ngn@ngn.tf>

On Fri, Jun 21, 2024 at 09:35:00AM +0300, ngn wrote:
> fix checpatch warnings and call hpc_ops functions directly, this has been
> also done in pciehp with commit 82a9e79ef132

Trivial changes like checkpatch fixes should be in a separate patch
from substantive things.  This helps make both easier to review.

It *might* be worthwhile to remove hpc_ops, although shpchp is pretty
old and dusty by now, and it's hard to justify touching things like
that because the risk of breaking something is relatively high and the
benefit is relatively low.

The fact that shpchp is the only user of hpc_ops does make me a little
more sympathetic to the idea of removing it, though.

> Signed-off-by: ngn <ngn@ngn.tf>
> ---
>  drivers/pci/hotplug/shpchp.h      |  84 ++++++++++++-----------
>  drivers/pci/hotplug/shpchp_core.c |  20 +++---
>  drivers/pci/hotplug/shpchp_ctrl.c | 107 ++++++++++++++----------------
>  drivers/pci/hotplug/shpchp_hpc.c  |  63 ++++++------------
>  4 files changed, 120 insertions(+), 154 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
> index 3a97f455336e..6931d648b873 100644
> --- a/drivers/pci/hotplug/shpchp.h
> +++ b/drivers/pci/hotplug/shpchp.h
> @@ -48,16 +48,15 @@ do {									\
>  #define ctrl_dbg(ctrl, format, arg...)					\
>  	do {								\
>  		if (shpchp_debug)					\
> -			pci_printk(KERN_DEBUG, ctrl->pci_dev,		\
> +			pci_printk(KERN_DEBUG, (ctrl)->pci_dev,		\
>  					format, ## arg);		\
>  	} while (0)
>  #define ctrl_err(ctrl, format, arg...)					\
> -	pci_err(ctrl->pci_dev, format, ## arg)
> +	pci_err((ctrl)->pci_dev, format, ## arg)
>  #define ctrl_info(ctrl, format, arg...)					\
> -	pci_info(ctrl->pci_dev, format, ## arg)
> +	pci_info((ctrl)->pci_dev, format, ## arg)
>  #define ctrl_warn(ctrl, format, arg...)					\
> -	pci_warn(ctrl->pci_dev, format, ## arg)
> -
> +	pci_warn((ctrl)->pci_dev, format, ## arg)
>  
>  #define SLOT_NAME_SIZE 10
>  struct slot {
> @@ -72,7 +71,6 @@ struct slot {
>  	u8 latch_save;
>  	u8 pwr_save;
>  	struct controller *ctrl;
> -	const struct hpc_ops *hpc_ops;
>  	struct hotplug_slot hotplug_slot;
>  	struct list_head	slot_list;
>  	struct delayed_work work;	/* work for button event */
> @@ -94,7 +92,6 @@ struct controller {
>  	int slot_num_inc;		/* 1 or -1 */
>  	struct pci_dev *pci_dev;
>  	struct list_head slot_list;
> -	const struct hpc_ops *hpc_ops;
>  	wait_queue_head_t queue;	/* sleep & wake process */
>  	u8 slot_device_offset;
>  	u32 pcix_misc2_reg;	/* for amd pogo errata */
> @@ -175,20 +172,20 @@ static inline const char *slot_name(struct slot *slot)
>  }
>  
>  struct ctrl_reg {
> -	volatile u32 base_offset;
> -	volatile u32 slot_avail1;
> -	volatile u32 slot_avail2;
> -	volatile u32 slot_config;
> -	volatile u16 sec_bus_config;
> -	volatile u8  msi_ctrl;
> -	volatile u8  prog_interface;
> -	volatile u16 cmd;
> -	volatile u16 cmd_status;
> -	volatile u32 intr_loc;
> -	volatile u32 serr_loc;
> -	volatile u32 serr_intr_enable;
> -	volatile u32 slot1;
> -} __attribute__ ((packed));
> +	u32 base_offset;
> +	u32 slot_avail1;
> +	u32 slot_avail2;
> +	u32 slot_config;
> +	u16 sec_bus_config;
> +	u8  msi_ctrl;
> +	u8  prog_interface;
> +	u16 cmd;
> +	u16 cmd_status;
> +	u32 intr_loc;
> +	u32 serr_loc;
> +	u32 serr_intr_enable;
> +	u32 slot1;
> +} __packed;
>  
>  /* offsets to the controller registers based on the above structure layout */
>  enum ctrl_offsets {
> @@ -252,18 +249,21 @@ static inline void amd_pogo_errata_restore_misc_reg(struct slot *p_slot)
>  	u8  rse_set;
>  
>  	/* write-one-to-clear Bridge_Errors[ PERR_OBSERVED ] */
> -	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MISC_BRIDGE_ERRORS_OFFSET, &pcix_bridge_errors_reg);
> +	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MISC_BRIDGE_ERRORS_OFFSET,
> +			      &pcix_bridge_errors_reg);
>  	perr_set = pcix_bridge_errors_reg & PERR_OBSERVED_MASK;
>  	if (perr_set) {
>  		ctrl_dbg(p_slot->ctrl,
>  			 "Bridge_Errors[ PERR_OBSERVED = %08X] (W1C)\n",
>  			 perr_set);
>  
> -		pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MISC_BRIDGE_ERRORS_OFFSET, perr_set);
> +		pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MISC_BRIDGE_ERRORS_OFFSET,
> +				       perr_set);
>  	}
>  
>  	/* write-one-to-clear Memory_Base_Limit[ RSE ] */
> -	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MEM_BASE_LIMIT_OFFSET, &pcix_mem_base_reg);
> +	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MEM_BASE_LIMIT_OFFSET,
> +			      &pcix_mem_base_reg);
>  	rse_set = pcix_mem_base_reg & RSE_MASK;
>  	if (rse_set) {
>  		ctrl_dbg(p_slot->ctrl, "Memory_Base_Limit[ RSE ] (W1C)\n");
> @@ -300,24 +300,22 @@ static inline void amd_pogo_errata_restore_misc_reg(struct slot *p_slot)
>  	pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MISCII_OFFSET, pcix_misc2_temp);
>  }
>  
> -struct hpc_ops {
> -	int (*power_on_slot)(struct slot *slot);
> -	int (*slot_enable)(struct slot *slot);
> -	int (*slot_disable)(struct slot *slot);
> -	int (*set_bus_speed_mode)(struct slot *slot, enum pci_bus_speed speed);
> -	int (*get_power_status)(struct slot *slot, u8 *status);
> -	int (*get_attention_status)(struct slot *slot, u8 *status);
> -	int (*set_attention_status)(struct slot *slot, u8 status);
> -	int (*get_latch_status)(struct slot *slot, u8 *status);
> -	int (*get_adapter_status)(struct slot *slot, u8 *status);
> -	int (*get_adapter_speed)(struct slot *slot, enum pci_bus_speed *speed);
> -	int (*get_prog_int)(struct slot *slot, u8 *prog_int);
> -	int (*query_power_fault)(struct slot *slot);
> -	void (*green_led_on)(struct slot *slot);
> -	void (*green_led_off)(struct slot *slot);
> -	void (*green_led_blink)(struct slot *slot);
> -	void (*release_ctlr)(struct controller *ctrl);
> -	int (*check_cmd_status)(struct controller *ctrl);
> -};
> +int shpchp_power_on_slot(struct slot *slot);
> +int shpchp_slot_enable(struct slot *slot);
> +int shpchp_slot_disable(struct slot *slot);
> +int shpchp_set_bus_speed_mode(struct slot *slot, enum pci_bus_speed speed);
> +int shpchp_get_power_status(struct slot *slot, u8 *status);
> +int shpchp_get_attention_status(struct slot *slot, u8 *status);
> +int shpchp_set_attention_status(struct slot *slot, u8 status);
> +int shpchp_get_latch_status(struct slot *slot, u8 *status);
> +int shpchp_get_adapter_status(struct slot *slot, u8 *status);
> +int shpchp_get_adapter_speed(struct slot *slot, enum pci_bus_speed *speed);
> +int shpchp_get_prog_int(struct slot *slot, u8 *prog_int);
> +int shpchp_query_power_fault(struct slot *slot);
> +void shpchp_green_led_on(struct slot *slot);
> +void shpchp_green_led_off(struct slot *slot);
> +void shpchp_green_led_blink(struct slot *slot);
> +void shpchp_release_ctlr(struct controller *ctrl);
> +int shpchp_check_cmd_status(struct controller *ctrl);
>  
>  #endif				/* _SHPCHP_H */
> diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
> index 56c7795ed890..f9a54a509dab 100644
> --- a/drivers/pci/hotplug/shpchp_core.c
> +++ b/drivers/pci/hotplug/shpchp_core.c
> @@ -81,7 +81,6 @@ static int init_slots(struct controller *ctrl)
>  		slot->ctrl = ctrl;
>  		slot->bus = ctrl->pci_dev->subordinate->number;
>  		slot->device = ctrl->slot_device_offset + i;
> -		slot->hpc_ops = ctrl->hpc_ops;
>  		slot->number = ctrl->first_slot + (ctrl->slot_num_inc * i);
>  
>  		slot->wq = alloc_workqueue("shpchp-%d", 0, 0, slot->number);
> @@ -102,7 +101,7 @@ static int init_slots(struct controller *ctrl)
>  			 slot->bus, slot->device, slot->hp_slot, slot->number,
>  			 ctrl->slot_device_offset);
>  		retval = pci_hp_register(hotplug_slot,
> -				ctrl->pci_dev->subordinate, slot->device, name);
> +					 ctrl->pci_dev->subordinate, slot->device, name);
>  		if (retval) {
>  			ctrl_err(ctrl, "pci_hp_register failed with error %d\n",
>  				 retval);
> @@ -150,7 +149,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
>  		 __func__, slot_name(slot));
>  
>  	slot->attention_save = status;
> -	slot->hpc_ops->set_attention_status(slot, status);
> +	shpchp_set_attention_status(slot, status);
>  
>  	return 0;
>  }
> @@ -183,7 +182,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
>  	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
>  		 __func__, slot_name(slot));
>  
> -	retval = slot->hpc_ops->get_power_status(slot, value);
> +	retval = shpchp_get_power_status(slot, value);
>  	if (retval < 0)
>  		*value = slot->pwr_save;
>  
> @@ -198,7 +197,7 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
>  	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
>  		 __func__, slot_name(slot));
>  
> -	retval = slot->hpc_ops->get_attention_status(slot, value);
> +	retval = shpchp_get_attention_status(slot, value);
>  	if (retval < 0)
>  		*value = slot->attention_save;
>  
> @@ -213,7 +212,7 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
>  	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
>  		 __func__, slot_name(slot));
>  
> -	retval = slot->hpc_ops->get_latch_status(slot, value);
> +	retval = shpchp_get_latch_status(slot, value);
>  	if (retval < 0)
>  		*value = slot->latch_save;
>  
> @@ -228,7 +227,7 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
>  	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
>  		 __func__, slot_name(slot));
>  
> -	retval = slot->hpc_ops->get_adapter_status(slot, value);
> +	retval = shpchp_get_adapter_status(slot, value);
>  	if (retval < 0)
>  		*value = slot->presence_save;
>  
> @@ -264,7 +263,7 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
>  	if (!ctrl)
> -		goto err_out_none;
> +		return -ENODEV;
>  
>  	INIT_LIST_HEAD(&ctrl->slot_list);
>  
> @@ -293,10 +292,9 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  err_cleanup_slots:
>  	cleanup_slots(ctrl);
>  err_out_release_ctlr:
> -	ctrl->hpc_ops->release_ctlr(ctrl);
> +	shpchp_release_ctlr(ctrl);
>  err_out_free_ctrl:
>  	kfree(ctrl);
> -err_out_none:
>  	return -ENODEV;
>  }
>  
> @@ -306,7 +304,7 @@ static void shpc_remove(struct pci_dev *dev)
>  
>  	dev->shpc_managed = 0;
>  	shpchp_remove_ctrl_files(ctrl);
> -	ctrl->hpc_ops->release_ctlr(ctrl);
> +	shpchp_release_ctlr(ctrl);
>  	kfree(ctrl);
>  }
>  
> diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
> index 6a6705e0cf17..9e6437e318f5 100644
> --- a/drivers/pci/hotplug/shpchp_ctrl.c
> +++ b/drivers/pci/hotplug/shpchp_ctrl.c
> @@ -51,7 +51,7 @@ u8 shpchp_handle_attention_button(u8 hp_slot, struct controller *ctrl)
>  	ctrl_dbg(ctrl, "Attention button interrupt received\n");
>  
>  	p_slot = shpchp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
> -	p_slot->hpc_ops->get_adapter_status(p_slot, &(p_slot->presence_save));
> +	shpchp_get_adapter_status(p_slot, &p_slot->presence_save);
>  
>  	/*
>  	 *  Button pressed - See if need to TAKE ACTION!!!
> @@ -62,7 +62,6 @@ u8 shpchp_handle_attention_button(u8 hp_slot, struct controller *ctrl)
>  	queue_interrupt_event(p_slot, event_type);
>  
>  	return 0;
> -
>  }
>  
>  u8 shpchp_handle_switch_change(u8 hp_slot, struct controller *ctrl)
> @@ -75,8 +74,8 @@ u8 shpchp_handle_switch_change(u8 hp_slot, struct controller *ctrl)
>  	ctrl_dbg(ctrl, "Switch interrupt received\n");
>  
>  	p_slot = shpchp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
> -	p_slot->hpc_ops->get_adapter_status(p_slot, &(p_slot->presence_save));
> -	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
> +	shpchp_get_adapter_status(p_slot, &p_slot->presence_save);
> +	shpchp_get_latch_status(p_slot, &getstatus);
>  	ctrl_dbg(ctrl, "Card present %x Power status %x\n",
>  		 p_slot->presence_save, p_slot->pwr_save);
>  
> @@ -116,7 +115,7 @@ u8 shpchp_handle_presence_change(u8 hp_slot, struct controller *ctrl)
>  	/*
>  	 * Save the presence state
>  	 */
> -	p_slot->hpc_ops->get_adapter_status(p_slot, &(p_slot->presence_save));
> +	shpchp_get_adapter_status(p_slot, &p_slot->presence_save);
>  	if (p_slot->presence_save) {
>  		/*
>  		 * Card Present
> @@ -148,7 +147,7 @@ u8 shpchp_handle_power_fault(u8 hp_slot, struct controller *ctrl)
>  
>  	p_slot = shpchp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
>  
> -	if (!(p_slot->hpc_ops->query_power_fault(p_slot))) {
> +	if (!(shpchp_query_power_fault(p_slot))) {
>  		/*
>  		 * Power fault Cleared
>  		 */
> @@ -173,15 +172,15 @@ u8 shpchp_handle_power_fault(u8 hp_slot, struct controller *ctrl)
>  }
>  
>  /* The following routines constitute the bulk of the
> -   hotplug controller logic
> + * hotplug controller logic
>   */
>  static int change_bus_speed(struct controller *ctrl, struct slot *p_slot,
> -		enum pci_bus_speed speed)
> +			    enum pci_bus_speed speed)
>  {
>  	int rc = 0;
>  
>  	ctrl_dbg(ctrl, "Change speed to %d\n", speed);
> -	rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, speed);
> +	rc = shpchp_set_bus_speed_mode(p_slot, speed);
>  	if (rc) {
>  		ctrl_err(ctrl, "%s: Issue of set bus speed mode command failed\n",
>  			 __func__);
> @@ -191,8 +190,8 @@ static int change_bus_speed(struct controller *ctrl, struct slot *p_slot,
>  }
>  
>  static int fix_bus_speed(struct controller *ctrl, struct slot *pslot,
> -		u8 flag, enum pci_bus_speed asp, enum pci_bus_speed bsp,
> -		enum pci_bus_speed msp)
> +			 u8 flag, enum pci_bus_speed asp, enum pci_bus_speed bsp,
> +			 enum pci_bus_speed msp)
>  {
>  	int rc = 0;
>  
> @@ -241,14 +240,14 @@ static int board_added(struct slot *p_slot)
>  		 __func__, p_slot->device, ctrl->slot_device_offset, hp_slot);
>  
>  	/* Power on slot without connecting to bus */
> -	rc = p_slot->hpc_ops->power_on_slot(p_slot);
> +	rc = shpchp_power_on_slot(p_slot);
>  	if (rc) {
>  		ctrl_err(ctrl, "Failed to power on slot\n");
>  		return -1;
>  	}
>  
> -	if ((ctrl->pci_dev->vendor == 0x8086) && (ctrl->pci_dev->device == 0x0332)) {
> -		rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, PCI_SPEED_33MHz);
> +	if (ctrl->pci_dev->vendor == 0x8086 && ctrl->pci_dev->device == 0x0332) {
> +		rc = shpchp_set_bus_speed_mode(p_slot, PCI_SPEED_33MHz);
>  		if (rc) {
>  			ctrl_err(ctrl, "%s: Issue of set bus speed mode command failed\n",
>  				 __func__);
> @@ -256,14 +255,14 @@ static int board_added(struct slot *p_slot)
>  		}
>  
>  		/* turn on board, blink green LED, turn off Amber LED */
> -		rc = p_slot->hpc_ops->slot_enable(p_slot);
> +		rc = shpchp_slot_enable(p_slot);
>  		if (rc) {
>  			ctrl_err(ctrl, "Issue of Slot Enable command failed\n");
>  			return rc;
>  		}
>  	}
>  
> -	rc = p_slot->hpc_ops->get_adapter_speed(p_slot, &asp);
> +	rc = shpchp_get_adapter_speed(p_slot, &asp);
>  	if (rc) {
>  		ctrl_err(ctrl, "Can't get adapter speed or bus mode mismatch\n");
>  		return WRONG_BUS_FREQUENCY;
> @@ -285,7 +284,7 @@ static int board_added(struct slot *p_slot)
>  		return rc;
>  
>  	/* turn on board, blink green LED, turn off Amber LED */
> -	rc = p_slot->hpc_ops->slot_enable(p_slot);
> +	rc = shpchp_slot_enable(p_slot);
>  	if (rc) {
>  		ctrl_err(ctrl, "Issue of Slot Enable command failed\n");
>  		return rc;
> @@ -313,13 +312,13 @@ static int board_added(struct slot *p_slot)
>  	p_slot->is_a_board = 0x01;
>  	p_slot->pwr_save = 1;
>  
> -	p_slot->hpc_ops->green_led_on(p_slot);
> +	shpchp_green_led_on(p_slot);
>  
>  	return 0;
>  
>  err_exit:
>  	/* turn off slot, turn on Amber LED, turn off Green LED */
> -	rc = p_slot->hpc_ops->slot_disable(p_slot);
> +	rc = shpchp_slot_disable(p_slot);
>  	if (rc) {
>  		ctrl_err(ctrl, "%s: Issue of Slot Disable command failed\n",
>  			 __func__);
> @@ -329,7 +328,6 @@ static int board_added(struct slot *p_slot)
>  	return(rc);
>  }
>  
> -
>  /**
>   * remove_board - Turns off slot and LEDs
>   * @p_slot: target &slot
> @@ -352,14 +350,14 @@ static int remove_board(struct slot *p_slot)
>  		p_slot->status = 0x01;
>  
>  	/* turn off slot, turn on Amber LED, turn off Green LED */
> -	rc = p_slot->hpc_ops->slot_disable(p_slot);
> +	rc = shpchp_slot_disable(p_slot);
>  	if (rc) {
>  		ctrl_err(ctrl, "%s: Issue of Slot Disable command failed\n",
>  			 __func__);
>  		return rc;
>  	}
>  
> -	rc = p_slot->hpc_ops->set_attention_status(p_slot, 0);
> +	rc = shpchp_set_attention_status(p_slot, 0);
>  	if (rc) {
>  		ctrl_err(ctrl, "Issue of Set Attention command failed\n");
>  		return rc;
> @@ -371,7 +369,6 @@ static int remove_board(struct slot *p_slot)
>  	return 0;
>  }
>  
> -
>  struct pushbutton_work_info {
>  	struct slot *p_slot;
>  	struct work_struct work;
> @@ -401,7 +398,7 @@ static void shpchp_pushbutton_thread(struct work_struct *work)
>  	case POWERON_STATE:
>  		mutex_unlock(&p_slot->lock);
>  		if (shpchp_enable_slot(p_slot))
> -			p_slot->hpc_ops->green_led_off(p_slot);
> +			shpchp_green_led_off(p_slot);
>  		mutex_lock(&p_slot->lock);
>  		p_slot->state = STATIC_STATE;
>  		break;
> @@ -446,10 +443,10 @@ void shpchp_queue_pushbutton_work(struct work_struct *work)
>  
>  static void update_slot_info(struct slot *slot)
>  {
> -	slot->hpc_ops->get_power_status(slot, &slot->pwr_save);
> -	slot->hpc_ops->get_attention_status(slot, &slot->attention_save);
> -	slot->hpc_ops->get_latch_status(slot, &slot->latch_save);
> -	slot->hpc_ops->get_adapter_status(slot, &slot->presence_save);
> +	shpchp_get_power_status(slot, &slot->pwr_save);
> +	shpchp_get_attention_status(slot, &slot->attention_save);
> +	shpchp_get_latch_status(slot, &slot->latch_save);
> +	shpchp_get_adapter_status(slot, &slot->presence_save);
>  }
>  
>  /*
> @@ -462,7 +459,7 @@ static void handle_button_press_event(struct slot *p_slot)
>  
>  	switch (p_slot->state) {
>  	case STATIC_STATE:
> -		p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
> +		shpchp_get_power_status(p_slot, &getstatus);
>  		if (getstatus) {
>  			p_slot->state = BLINKINGOFF_STATE;
>  			ctrl_info(ctrl, "PCI slot #%s - powering off due to button press\n",
> @@ -473,10 +470,10 @@ static void handle_button_press_event(struct slot *p_slot)
>  				  slot_name(p_slot));
>  		}
>  		/* blink green LED and turn off amber */
> -		p_slot->hpc_ops->green_led_blink(p_slot);
> -		p_slot->hpc_ops->set_attention_status(p_slot, 0);
> +		shpchp_green_led_blink(p_slot);
> +		shpchp_set_attention_status(p_slot, 0);
>  
> -		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
> +		queue_delayed_work(p_slot->wq, &p_slot->work, 5 * HZ);
>  		break;
>  	case BLINKINGOFF_STATE:
>  	case BLINKINGON_STATE:
> @@ -489,10 +486,10 @@ static void handle_button_press_event(struct slot *p_slot)
>  			  slot_name(p_slot));
>  		cancel_delayed_work(&p_slot->work);
>  		if (p_slot->state == BLINKINGOFF_STATE)
> -			p_slot->hpc_ops->green_led_on(p_slot);
> +			shpchp_green_led_on(p_slot);
>  		else
> -			p_slot->hpc_ops->green_led_off(p_slot);
> -		p_slot->hpc_ops->set_attention_status(p_slot, 0);
> +			shpchp_green_led_off(p_slot);
> +		shpchp_set_attention_status(p_slot, 0);
>  		ctrl_info(ctrl, "PCI slot #%s - action canceled due to button press\n",
>  			  slot_name(p_slot));
>  		p_slot->state = STATIC_STATE;
> @@ -526,8 +523,8 @@ static void interrupt_event_handler(struct work_struct *work)
>  		break;
>  	case INT_POWER_FAULT:
>  		ctrl_dbg(p_slot->ctrl, "%s: Power fault\n", __func__);
> -		p_slot->hpc_ops->set_attention_status(p_slot, 1);
> -		p_slot->hpc_ops->green_led_off(p_slot);
> +		shpchp_set_attention_status(p_slot, 1);
> +		shpchp_green_led_off(p_slot);
>  		break;
>  	default:
>  		update_slot_info(p_slot);
> @@ -538,8 +535,7 @@ static void interrupt_event_handler(struct work_struct *work)
>  	kfree(info);
>  }
>  
> -
> -static int shpchp_enable_slot (struct slot *p_slot)
> +static int shpchp_enable_slot(struct slot *p_slot)
>  {
>  	u8 getstatus = 0;
>  	int rc, retval = -ENODEV;
> @@ -547,17 +543,17 @@ static int shpchp_enable_slot (struct slot *p_slot)
>  
>  	/* Check to see if (latch closed, card present, power off) */
>  	mutex_lock(&p_slot->ctrl->crit_sect);
> -	rc = p_slot->hpc_ops->get_adapter_status(p_slot, &getstatus);
> +	rc = shpchp_get_adapter_status(p_slot, &getstatus);
>  	if (rc || !getstatus) {
>  		ctrl_info(ctrl, "No adapter on slot(%s)\n", slot_name(p_slot));
>  		goto out;
>  	}
> -	rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
> +	rc = shpchp_get_latch_status(p_slot, &getstatus);
>  	if (rc || getstatus) {
>  		ctrl_info(ctrl, "Latch open on slot(%s)\n", slot_name(p_slot));
>  		goto out;
>  	}
> -	rc = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
> +	rc = shpchp_get_power_status(p_slot, &getstatus);
>  	if (rc || getstatus) {
>  		ctrl_info(ctrl, "Already enabled on slot(%s)\n",
>  			  slot_name(p_slot));
> @@ -567,26 +563,26 @@ static int shpchp_enable_slot (struct slot *p_slot)
>  	p_slot->is_a_board = 1;
>  
>  	/* We have to save the presence info for these slots */
> -	p_slot->hpc_ops->get_adapter_status(p_slot, &(p_slot->presence_save));
> -	p_slot->hpc_ops->get_power_status(p_slot, &(p_slot->pwr_save));
> +	shpchp_get_adapter_status(p_slot, &p_slot->presence_save);
> +	shpchp_get_power_status(p_slot, &p_slot->pwr_save);
>  	ctrl_dbg(ctrl, "%s: p_slot->pwr_save %x\n", __func__, p_slot->pwr_save);
> -	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
> +	shpchp_get_latch_status(p_slot, &getstatus);
>  
>  	if ((p_slot->ctrl->pci_dev->vendor == PCI_VENDOR_ID_AMD &&
> -	     p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458)
> -	     && p_slot->ctrl->num_slots == 1) {
> +	     p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458) &&
> +	     p_slot->ctrl->num_slots == 1) {
>  		/* handle AMD POGO errata; this must be done before enable  */
>  		amd_pogo_errata_save_misc_reg(p_slot);
>  		retval = board_added(p_slot);
>  		/* handle AMD POGO errata; this must be done after enable  */
>  		amd_pogo_errata_restore_misc_reg(p_slot);
> -	} else
> +	} else {
>  		retval = board_added(p_slot);
> +	}
>  
>  	if (retval) {
> -		p_slot->hpc_ops->get_adapter_status(p_slot,
> -				&(p_slot->presence_save));
> -		p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
> +		shpchp_get_adapter_status(p_slot, &p_slot->presence_save);
> +		shpchp_get_latch_status(p_slot, &getstatus);
>  	}
>  
>  	update_slot_info(p_slot);
> @@ -595,8 +591,7 @@ static int shpchp_enable_slot (struct slot *p_slot)
>  	return retval;
>  }
>  
> -
> -static int shpchp_disable_slot (struct slot *p_slot)
> +static int shpchp_disable_slot(struct slot *p_slot)
>  {
>  	u8 getstatus = 0;
>  	int rc, retval = -ENODEV;
> @@ -608,17 +603,17 @@ static int shpchp_disable_slot (struct slot *p_slot)
>  	/* Check to see if (latch closed, card present, power on) */
>  	mutex_lock(&p_slot->ctrl->crit_sect);
>  
> -	rc = p_slot->hpc_ops->get_adapter_status(p_slot, &getstatus);
> +	rc = shpchp_get_adapter_status(p_slot, &getstatus);
>  	if (rc || !getstatus) {
>  		ctrl_info(ctrl, "No adapter on slot(%s)\n", slot_name(p_slot));
>  		goto out;
>  	}
> -	rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
> +	rc = shpchp_get_latch_status(p_slot, &getstatus);
>  	if (rc || getstatus) {
>  		ctrl_info(ctrl, "Latch open on slot(%s)\n", slot_name(p_slot));
>  		goto out;
>  	}
> -	rc = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
> +	rc = shpchp_get_power_status(p_slot, &getstatus);
>  	if (rc || !getstatus) {
>  		ctrl_info(ctrl, "Already disabled on slot(%s)\n",
>  			  slot_name(p_slot));
> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
> index 48e4daefc44a..012b9e3fe5b0 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -167,7 +167,6 @@
>  
>  static irqreturn_t shpc_isr(int irq, void *dev_id);
>  static void start_int_poll_timer(struct controller *ctrl, int sec);
> -static int hpc_check_cmd_status(struct controller *ctrl);
>  
>  static inline u8 shpc_readb(struct controller *ctrl, int reg)
>  {
> @@ -317,7 +316,7 @@ static int shpc_write_cmd(struct slot *slot, u8 t_slot, u8 cmd)
>  	if (retval)
>  		goto out;
>  
> -	cmd_status = hpc_check_cmd_status(slot->ctrl);
> +	cmd_status = shpchp_check_cmd_status(slot->ctrl);
>  	if (cmd_status) {
>  		ctrl_err(ctrl, "Failed to issued command 0x%x (error code = %d)\n",
>  			 cmd, cmd_status);
> @@ -328,7 +327,7 @@ static int shpc_write_cmd(struct slot *slot, u8 t_slot, u8 cmd)
>  	return retval;
>  }
>  
> -static int hpc_check_cmd_status(struct controller *ctrl)
> +int shpchp_check_cmd_status(struct controller *ctrl)
>  {
>  	int retval = 0;
>  	u16 cmd_status = shpc_readw(ctrl, CMD_STATUS) & 0x000F;
> @@ -357,7 +356,7 @@ static int hpc_check_cmd_status(struct controller *ctrl)
>  }
>  
>  
> -static int hpc_get_attention_status(struct slot *slot, u8 *status)
> +int shpchp_get_attention_status(struct slot *slot, u8 *status)
>  {
>  	struct controller *ctrl = slot->ctrl;
>  	u32 slot_reg = shpc_readl(ctrl, SLOT_REG(slot->hp_slot));
> @@ -381,7 +380,7 @@ static int hpc_get_attention_status(struct slot *slot, u8 *status)
>  	return 0;
>  }
>  
> -static int hpc_get_power_status(struct slot *slot, u8 *status)
> +int shpchp_get_power_status(struct slot *slot, u8 *status)
>  {
>  	struct controller *ctrl = slot->ctrl;
>  	u32 slot_reg = shpc_readl(ctrl, SLOT_REG(slot->hp_slot));
> @@ -406,7 +405,7 @@ static int hpc_get_power_status(struct slot *slot, u8 *status)
>  }
>  
>  
> -static int hpc_get_latch_status(struct slot *slot, u8 *status)
> +int shpchp_get_latch_status(struct slot *slot, u8 *status)
>  {
>  	struct controller *ctrl = slot->ctrl;
>  	u32 slot_reg = shpc_readl(ctrl, SLOT_REG(slot->hp_slot));
> @@ -416,7 +415,7 @@ static int hpc_get_latch_status(struct slot *slot, u8 *status)
>  	return 0;
>  }
>  
> -static int hpc_get_adapter_status(struct slot *slot, u8 *status)
> +int shpchp_get_adapter_status(struct slot *slot, u8 *status)
>  {
>  	struct controller *ctrl = slot->ctrl;
>  	u32 slot_reg = shpc_readl(ctrl, SLOT_REG(slot->hp_slot));
> @@ -427,7 +426,7 @@ static int hpc_get_adapter_status(struct slot *slot, u8 *status)
>  	return 0;
>  }
>  
> -static int hpc_get_prog_int(struct slot *slot, u8 *prog_int)
> +int shpchp_get_prog_int(struct slot *slot, u8 *prog_int)
>  {
>  	struct controller *ctrl = slot->ctrl;
>  
> @@ -436,7 +435,7 @@ static int hpc_get_prog_int(struct slot *slot, u8 *prog_int)
>  	return 0;
>  }
>  
> -static int hpc_get_adapter_speed(struct slot *slot, enum pci_bus_speed *value)
> +int shpchp_get_adapter_speed(struct slot *slot, enum pci_bus_speed *value)
>  {
>  	int retval = 0;
>  	struct controller *ctrl = slot->ctrl;
> @@ -444,7 +443,7 @@ static int hpc_get_adapter_speed(struct slot *slot, enum pci_bus_speed *value)
>  	u8 m66_cap  = !!(slot_reg & MHZ66_CAP);
>  	u8 pi, pcix_cap;
>  
> -	retval = hpc_get_prog_int(slot, &pi);
> +	retval = shpchp_get_prog_int(slot, &pi);
>  	if (retval)
>  		return retval;
>  
> @@ -489,7 +488,7 @@ static int hpc_get_adapter_speed(struct slot *slot, enum pci_bus_speed *value)
>  	return retval;
>  }
>  
> -static int hpc_query_power_fault(struct slot *slot)
> +int shpchp_query_power_fault(struct slot *slot)
>  {
>  	struct controller *ctrl = slot->ctrl;
>  	u32 slot_reg = shpc_readl(ctrl, SLOT_REG(slot->hp_slot));
> @@ -498,7 +497,7 @@ static int hpc_query_power_fault(struct slot *slot)
>  	return !(slot_reg & POWER_FAULT);
>  }
>  
> -static int hpc_set_attention_status(struct slot *slot, u8 value)
> +int shpchp_set_attention_status(struct slot *slot, u8 value)
>  {
>  	u8 slot_cmd = 0;
>  
> @@ -520,22 +519,22 @@ static int hpc_set_attention_status(struct slot *slot, u8 value)
>  }
>  
>  
> -static void hpc_set_green_led_on(struct slot *slot)
> +void shpchp_green_led_on(struct slot *slot)
>  {
>  	shpc_write_cmd(slot, slot->hp_slot, SET_PWR_ON);
>  }
>  
> -static void hpc_set_green_led_off(struct slot *slot)
> +void shpchp_green_led_off(struct slot *slot)
>  {
>  	shpc_write_cmd(slot, slot->hp_slot, SET_PWR_OFF);
>  }
>  
> -static void hpc_set_green_led_blink(struct slot *slot)
> +void shpchp_green_led_blink(struct slot *slot)
>  {
>  	shpc_write_cmd(slot, slot->hp_slot, SET_PWR_BLINK);
>  }
>  
> -static void hpc_release_ctlr(struct controller *ctrl)
> +void shpchp_release_ctlr(struct controller *ctrl)
>  {
>  	int i;
>  	u32 slot_reg, serr_int;
> @@ -575,7 +574,7 @@ static void hpc_release_ctlr(struct controller *ctrl)
>  	release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
>  }
>  
> -static int hpc_power_on_slot(struct slot *slot)
> +int shpchp_power_on_slot(struct slot *slot)
>  {
>  	int retval;
>  
> @@ -586,7 +585,7 @@ static int hpc_power_on_slot(struct slot *slot)
>  	return retval;
>  }
>  
> -static int hpc_slot_enable(struct slot *slot)
> +int shpchp_slot_enable(struct slot *slot)
>  {
>  	int retval;
>  
> @@ -599,7 +598,7 @@ static int hpc_slot_enable(struct slot *slot)
>  	return retval;
>  }
>  
> -static int hpc_slot_disable(struct slot *slot)
> +int shpchp_slot_disable(struct slot *slot)
>  {
>  	int retval;
>  
> @@ -681,7 +680,7 @@ static int shpc_get_cur_bus_speed(struct controller *ctrl)
>  }
>  
>  
> -static int hpc_set_bus_speed_mode(struct slot *slot, enum pci_bus_speed value)
> +int shpchp_set_bus_speed_mode(struct slot *slot, enum pci_bus_speed value)
>  {
>  	int retval;
>  	struct controller *ctrl = slot->ctrl;
> @@ -871,28 +870,6 @@ static int shpc_get_max_bus_speed(struct controller *ctrl)
>  	return retval;
>  }
>  
> -static const struct hpc_ops shpchp_hpc_ops = {
> -	.power_on_slot			= hpc_power_on_slot,
> -	.slot_enable			= hpc_slot_enable,
> -	.slot_disable			= hpc_slot_disable,
> -	.set_bus_speed_mode		= hpc_set_bus_speed_mode,
> -	.set_attention_status	= hpc_set_attention_status,
> -	.get_power_status		= hpc_get_power_status,
> -	.get_attention_status	= hpc_get_attention_status,
> -	.get_latch_status		= hpc_get_latch_status,
> -	.get_adapter_status		= hpc_get_adapter_status,
> -
> -	.get_adapter_speed		= hpc_get_adapter_speed,
> -	.get_prog_int			= hpc_get_prog_int,
> -
> -	.query_power_fault		= hpc_query_power_fault,
> -	.green_led_on			= hpc_set_green_led_on,
> -	.green_led_off			= hpc_set_green_led_off,
> -	.green_led_blink		= hpc_set_green_led_blink,
> -
> -	.release_ctlr			= hpc_release_ctlr,
> -};
> -
>  int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
>  {
>  	int rc = -1, num_slots = 0;
> @@ -978,8 +955,6 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
>  	/* Setup wait queue */
>  	init_waitqueue_head(&ctrl->queue);
>  
> -	ctrl->hpc_ops = &shpchp_hpc_ops;
> -
>  	/* Return PCI Controller Info */
>  	slot_config = shpc_readl(ctrl, SLOT_CONFIG);
>  	ctrl->slot_device_offset = (slot_config & FIRST_DEV_NUM) >> 8;
> -- 
> 2.45.1
> 

