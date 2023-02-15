Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3188069872D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 22:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBOVOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 16:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjBOVN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 16:13:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58192D17B
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 13:13:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5059F61DB2
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 21:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B229C433D2;
        Wed, 15 Feb 2023 21:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676495635;
        bh=vlPpGXoQ/zZSQWuK5jIs+jmIzYZIW3Wr7KG7ZOZnP2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A9fWBcygGAPOxp4XgWpX52R6uvvUwiT2wVksDCd1y2Q7v8tuPVr7+HW1DmcBzOYoN
         C3J1XANC6LKiIhIAhPGrVjTfeh1ThxCTpD0vYsSLrwdRqzmzhjZNeES3oxfBNGHMdG
         YpWHKrVwi/8Qu1VeDydME2UntNYOZnui+jIxt1NNQsBdmYNlwsEKnP3XwAwm/8J7Fr
         jWFSRh0izEBWB2IFYJ25dN5jhKMe6XKPlc+vkrXAWK42MGiQgq4yL3lmmjgNo5cmNv
         ZD1ra3RHgva1fESKy2y41rvSJaPuakQA5qYmKwrlNnJtyBxqzRyaIrTDgIxfQCNpLu
         KCJZJwJEZki6A==
Date:   Wed, 15 Feb 2023 15:13:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Anatoli Antonovitch <anatoli.antonovitch@amd.com>,
        Keith Busch <kbusch@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: Allow marking devices as disconnected
 during bind/unbind
Message-ID: <20230215211354.GA3216458@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 20, 2023 at 10:19:02AM +0100, Lukas Wunner wrote:
> On surprise removal, pciehp_unconfigure_device() and acpiphp's
> trim_stale_devices() call pci_dev_set_disconnected() to mark removed
> devices as permanently offline.  Thereby, the PCI core and drivers know
> to skip device accesses.
> 
> However pci_dev_set_disconnected() takes the device_lock and thus waits
> for a concurrent driver bind or unbind to complete.  As a result, the
> driver's ->probe and ->remove hooks have no chance to learn that the
> device is gone.
> 
> That doesn't make any sense, so drop the device_lock and instead use
> atomic xchg() and cmpxchg() operations to update the device state.
> 
> As a byproduct, an AB-BA deadlock reported by Anatoli is fixed which
> occurs on surprise removal with AER concurrently performing a bus reset.
> 
> AER bus reset:
> 
>   INFO: task irq/26-aerdrv:95 blocked for more than 120 seconds.
>   Tainted: G        W          6.2.0-rc3-custom-norework-jan11+
>   schedule
>   rwsem_down_write_slowpath
>   down_write_nested
>   pciehp_reset_slot                      # acquires reset_lock
>   pci_reset_hotplug_slot
>   pci_slot_reset                         # acquires device_lock
>   pci_bus_error_reset
>   aer_root_reset
>   pcie_do_recovery
>   aer_process_err_devices
>   aer_isr
> 
> pciehp surprise removal:
> 
>   INFO: task irq/26-pciehp:96 blocked for more than 120 seconds.
>   Tainted: G        W          6.2.0-rc3-custom-norework-jan11+
>   schedule_preempt_disabled
>   __mutex_lock
>   mutex_lock_nested
>   pci_dev_set_disconnected               # acquires device_lock
>   pci_walk_bus
>   pciehp_unconfigure_device
>   pciehp_disable_slot
>   pciehp_handle_presence_or_link_change
>   pciehp_ist                             # acquires reset_lock
> 
> Fixes: a6bd101b8f84 ("PCI: Unify device inaccessible")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215590
> Reported-by: Anatoli Antonovitch <anatoli.antonovitch@amd.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.20+
> Cc: Keith Busch <kbusch@kernel.org>

Applied to pci/hotplug for v6.3, thanks!

The xchg()/cmpxchg() is a little subtle just because we don't see it
every day, but a really nice simplification and explanation of the
state change in addition to the locking improvement.  Thank you!

> ---
>  drivers/pci/pci.h | 43 +++++++++++++------------------------------
>  1 file changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b55..5d5a44a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -310,53 +310,36 @@ struct pci_sriov {
>   * @dev: PCI device to set new error_state
>   * @new: the state we want dev to be in
>   *
> - * Must be called with device_lock held.
> + * If the device is experiencing perm_failure, it has to remain in that state.
> + * Any other transition is allowed.
>   *
>   * Returns true if state has been changed to the requested state.
>   */
>  static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>  					pci_channel_state_t new)
>  {
> -	bool changed = false;
> +	pci_channel_state_t old;
>  
> -	device_lock_assert(&dev->dev);
>  	switch (new) {
>  	case pci_channel_io_perm_failure:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -		case pci_channel_io_perm_failure:
> -			changed = true;
> -			break;
> -		}
> -		break;
> +		xchg(&dev->error_state, pci_channel_io_perm_failure);
> +		return true;
>  	case pci_channel_io_frozen:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> +		old = cmpxchg(&dev->error_state, pci_channel_io_normal,
> +			      pci_channel_io_frozen);
> +		return old != pci_channel_io_perm_failure;
>  	case pci_channel_io_normal:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> +		old = cmpxchg(&dev->error_state, pci_channel_io_frozen,
> +			      pci_channel_io_normal);
> +		return old != pci_channel_io_perm_failure;
> +	default:
> +		return false;
>  	}
> -	if (changed)
> -		dev->error_state = new;
> -	return changed;
>  }
>  
>  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  {
> -	device_lock(&dev->dev);
>  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> -	device_unlock(&dev->dev);
>  
>  	return 0;
>  }
> -- 
> 2.39.1
> 
