Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C008E6DE3CE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDKSYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDKSYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 14:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06CF49D9
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 11:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8D662ABB
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 18:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE63CC433D2;
        Tue, 11 Apr 2023 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681237453;
        bh=uy6BKXTvuQDPydiJqxdl35/VH7+HDeJb32NbJ+/XYr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G7Y0mHZ6hKUPNtSXodVYAbHB1vIhPeFRNQXgASSEseqjmFN/ALPgPbFPwH+n1pLHH
         CaoglXZQZo/JTJz2fzXp7XdWf18xaEdLi+sgxNCkcNiFNl+V2KwlRBirUKRApjN/DM
         gdXEabfMUUZuN1RzH44HzCha3l7W+DloGuW9LFInRnBOd2fu7mLECO6htTOQZbgTkX
         O6q/uqSRzsZbL2WkEZfeZOc7Xm+yQLL3COQ4iq9B05jFli9KibcmuwLAXGFVxhqyff
         32DZW/881CLiZ6p6LqHJbUkn7G6EHWcNRvF2Y8/6rdR2r6fUvo/X3sqXKw5/MAsJPT
         qp5KhaUd8MIIQ==
Date:   Tue, 11 Apr 2023 13:24:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Michael Haeuptle <michael.haeuptle@hpe.com>,
        Ian May <ian.may@canonical.com>,
        Andrey Grodzovsky <andrey2805@gmail.com>,
        Rahul Kumar <rahul.kumar1@amd.com>,
        Jialin Zhang <zhangjialin11@huawei.com>,
        Anatoli Antonovitch <Anatoli.Antonovitch@amd.com>,
        linux-pci@vger.kernel.org, Dan Stein <dstein@hpe.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Michon <amichon@kalrayinc.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Fix AB-BA deadlock between reset_lock
 and device_lock
Message-ID: <20230411182412.GA4165673@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef2b2e9edf245c049a8c5b94743c0f74ff5008a.1681191902.git.lukas@wunner.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 08:21:02AM +0200, Lukas Wunner wrote:
> In 2013, commits
> 
>   2e35afaefe64 ("PCI: pciehp: Add reset_slot() method")
>   608c388122c7 ("PCI: Add slot reset option to pci_dev_reset()")
> 
> amended PCIe hotplug to mask Presence Detect Changed events during a
> Secondary Bus Reset.  The reset thus no longer causes gratuitous slot
> bringdown and bringup.
> 
> However the commits neglected to serialize reset with code paths reading
> slot registers.  For instance, a slot bringup due to an earlier hotplug
> event may see the Presence Detect State bit cleared during a concurrent
> Secondary Bus Reset.
> ...

> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/hotplug for v6.4, thanks!

> Cc: stable@vger.kernel.org # v4.19+
> Cc: Dan Stein <dstein@hpe.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Alex Michon <amichon@kalrayinc.com>
> Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> Link to v1:
> https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/
> 
> In v1 I tried to solve the problem by changing the locking order for
> Secondary Bus Resets.  That didn't really work out.  I've experimented
> with various other approaches and finally came up with this simple one
> which lends itself well for backporting to stable.  I apologize for the
> long time this has taken.
> 
>  drivers/pci/hotplug/pciehp_pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index d17f3bf..ad12515 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -63,7 +63,14 @@ int pciehp_configure_device(struct controller *ctrl)
>  
>  	pci_assign_unassigned_bridge_resources(bridge);
>  	pcie_bus_configure_settings(parent);
> +
> +	/*
> +	 * Release reset_lock during driver binding
> +	 * to avoid AB-BA deadlock with device_lock.
> +	 */
> +	up_read(&ctrl->reset_lock);
>  	pci_bus_add_devices(parent);
> +	down_read_nested(&ctrl->reset_lock, ctrl->depth);
>  
>   out:
>  	pci_unlock_rescan_remove();
> @@ -104,7 +111,15 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
>  					 bus_list) {
>  		pci_dev_get(dev);
> +
> +		/*
> +		 * Release reset_lock during driver unbinding
> +		 * to avoid AB-BA deadlock with device_lock.
> +		 */
> +		up_read(&ctrl->reset_lock);
>  		pci_stop_and_remove_bus_device(dev);
> +		down_read_nested(&ctrl->reset_lock, ctrl->depth);
> +
>  		/*
>  		 * Ensure that no new Requests will be generated from
>  		 * the device.
> -- 
> 2.39.1
> 
