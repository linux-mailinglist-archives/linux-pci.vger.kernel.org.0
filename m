Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA3462888
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 00:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhK2XtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 18:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhK2XtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 18:49:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F684C061574
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 15:46:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D887FB8163A
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 23:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDFDC53FC7;
        Mon, 29 Nov 2021 23:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638229559;
        bh=CecNPrp90DEMxULZowpxYdkd/gdOEdalFOVewV001u8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pThaAgkdUFgEfBrT8B9wqJ3NH8IXxNRSwOm6i/9nqeO+NRjIkINJgqikECpldJCUi
         1s0BIWQDXYzpSLdT8zYKfmkefgmV57Pn20oETXSsPCoP+LVOxuY5qvfpsEAUSW8vWj
         yI4VGa6zTn6Vsb4/gDre0KeO4iZhFvaPognuIWSs6fedLTrZ1f65HuV/Fh5+Wn3iMc
         lx6CEgppPXVHeymQQt9WUjnWSaNh0RcH8qTCQ/3be3Ml4wsyYGkKCE1DaNSvApob7w
         NyvwD7Hnggk77uTRvgcXmRdGfRwX8DPhAFBQOeC63c/tnLPDd0cYXgU9hpvj9yxNAI
         lKnpu5vLAT9QA==
Date:   Mon, 29 Nov 2021 17:45:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Use down_read/write_nested(reset_lock)
 to fix lockdep errors
Message-ID: <20211129234557.GA2704068@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129121934.4963-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 01:19:34PM +0100, Hans de Goede wrote:
> Use down_read_nested() and down_write_nested() when taking the
> ctrl->reset_lock rw-sem, passing the PCI-device depth in the hierarchy
> as lock subclass parameter. This fixes the following false-positive lockdep
> report when unplugging a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:
> 
> [   28.583853] pcieport 0000:06:01.0: pciehp: Slot(1): Link Down
> [   28.583891] pcieport 0000:06:01.0: pciehp: Slot(1): Card not present
> [   28.583995] pcieport 0000:09:04.0: can't change power state from D3cold to D0 (config space inaccessible)
> 
> [   28.584849] ============================================
> [   28.584854] WARNING: possible recursive locking detected
> [   28.584858] 5.16.0-rc2+ #621 Not tainted
> [   28.584864] --------------------------------------------
> [   28.584867] irq/124-pciehp/86 is trying to acquire lock:
> [   28.584873] ffff8e5ac4299ef8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_check_presence+0x23/0x80
> [   28.584904]
>                but task is already holding lock:
> [   28.584908] ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
> [   28.584929]
>                other info that might help us debug this:
> [   28.584933]  Possible unsafe locking scenario:
> 
> [   28.584936]        CPU0
> [   28.584939]        ----
> [   28.584942]   lock(&ctrl->reset_lock);
> [   28.584949]   lock(&ctrl->reset_lock);
> [   28.584955]
>                 *** DEADLOCK ***
> 
> [   28.584959]  May be due to missing lock nesting notation
> 
> [   28.584963] 3 locks held by irq/124-pciehp/86:
> [   28.584970]  #0: ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
> [   28.584991]  #1: ffffffffa3b024e8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_unconfigure_device+0x31/0x110
> [   28.585012]  #2: ffff8e5ac1ee2248 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40
> [   28.585037]
>                stack backtrace:
> [   28.585042] CPU: 4 PID: 86 Comm: irq/124-pciehp Not tainted 5.16.0-rc2+ #621
> [   28.585052] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET30W (1.20 ) 08/26/2021
> [   28.585059] Call Trace:
> [   28.585064]  <TASK>
> [   28.585073]  dump_stack_lvl+0x59/0x73
> [   28.585087]  __lock_acquire.cold+0xc5/0x2c6
> [   28.585106]  ? find_held_lock+0x2b/0x80
> [   28.585124]  lock_acquire+0xb5/0x2b0
> [   28.585132]  ? pciehp_check_presence+0x23/0x80
> [   28.585144]  ? lock_is_held_type+0xa8/0x120
> [   28.585161]  down_read+0x3e/0x50
> [   28.585172]  ? pciehp_check_presence+0x23/0x80
> [   28.585183]  pciehp_check_presence+0x23/0x80
> [   28.585194]  pciehp_runtime_resume+0x5c/0xa0
> [   28.585206]  ? pci_msix_init+0x60/0x60
> [   28.585214]  device_for_each_child+0x45/0x70
> [   28.585227]  pcie_port_device_runtime_resume+0x20/0x30
> [   28.585236]  pci_pm_runtime_resume+0xa7/0xc0
> [   28.585246]  ? pci_pm_freeze_noirq+0x100/0x100
> [   28.585257]  __rpm_callback+0x41/0x110
> [   28.585271]  ? pci_pm_freeze_noirq+0x100/0x100
> [   28.585281]  rpm_callback+0x59/0x70
> [   28.585293]  rpm_resume+0x512/0x7b0
> [   28.585309]  __pm_runtime_resume+0x4a/0x90
> [   28.585322]  __device_release_driver+0x28/0x240
> [   28.585338]  device_release_driver+0x26/0x40
> [   28.585351]  pci_stop_bus_device+0x68/0x90
> [   28.585363]  pci_stop_bus_device+0x2c/0x90
> [   28.585373]  pci_stop_and_remove_bus_device+0xe/0x20
> [   28.585384]  pciehp_unconfigure_device+0x6c/0x110
> [   28.585396]  ? __pm_runtime_resume+0x58/0x90
> [   28.585409]  pciehp_disable_slot+0x5b/0xe0
> [   28.585421]  pciehp_handle_presence_or_link_change+0xc3/0x2f0
> [   28.585436]  pciehp_ist+0x179/0x180
> [   28.585449]  ? disable_irq_nosync+0x10/0x10
> [   28.585460]  irq_thread_fn+0x1d/0x60
> [   28.585470]  ? irq_thread+0x81/0x1a0
> [   28.585480]  irq_thread+0xcb/0x1a0
> [   28.585491]  ? irq_thread_fn+0x60/0x60
> [   28.585502]  ? irq_thread_check_affinity+0xb0/0xb0
> [   28.585514]  kthread+0x165/0x190
> [   28.585522]  ? set_kthread_struct+0x40/0x40
> [   28.585531]  ret_from_fork+0x1f/0x30
> [   28.585554]  </TASK>
> [   28.586512] xhci_hcd 0000:0a:00.0: remove, state 1
> [   28.586538] usb usb4: USB disconnect, device number 1
> [   28.586547] usb 4-2: USB disconnect, device number 2
> [   28.586555] usb 4-2.1: USB disconnect, device number 3
> [   28.586561] usb 4-2.1.2: USB disconnect, device number 5
> [   28.587709] xhci_hcd 0000:0a:00.0: xHCI host controller not responding, assume dead
> [   28.590021] usb 4-2.3: USB disconnect, device number 4
> [   28.613814] xhci_hcd 0000:0a:00.0: WARN Can't disable streams for endpoint 0x1, streams are being disabled already
> [   28.616865] xhci_hcd 0000:0a:00.0: USB bus 4 deregistered
> [   28.617082] xhci_hcd 0000:0a:00.0: remove, state 1
> [   28.617089] usb usb3: USB disconnect, device number 1
> [   28.617092] usb 3-2: USB disconnect, device number 2
> [   28.617094] usb 3-2.1: USB disconnect, device number 3
> [   28.617096] usb 3-2.1.1: USB disconnect, device number 6
> [   28.617098] usb 3-2.1.1.4: USB disconnect, device number 8
> [   28.645354] usb 3-2.1.3: USB disconnect, device number 7
> [   28.645357] usb 3-2.1.3.1: USB disconnect, device number 10
> [   28.647489] usb 3-2.1.3.4: USB disconnect, device number 11
> [   28.647494] usb 3-2.1.3.4.1: USB disconnect, device number 13
> [   28.760411] usb 3-2.1.4: USB disconnect, device number 9
> [   28.760414] usb 3-2.1.4.1: USB disconnect, device number 12
> [   28.795513] usb 3-2.4: USB disconnect, device number 4
> [   28.821464] usb 3-2.5: USB disconnect, device number 5
> [   28.822850] xhci_hcd 0000:0a:00.0: Host halt failed, -19
> [   28.822854] xhci_hcd 0000:0a:00.0: Host not accessible, reset failed.
> [   28.823331] xhci_hcd 0000:0a:00.0: USB bus 3 deregistered
> [   28.823589] pci 0000:0a:00.0: Removing from iommu group 15
> [   28.823605] pci_bus 0000:0a: busn_res: [bus 0a] is released
> [   28.823660] pci 0000:09:02.0: Removing from iommu group 15
> [   28.823729] pci_bus 0000:0b: busn_res: [bus 0b-2c] is released
> [   28.823773] pci 0000:09:04.0: Removing from iommu group 15
> [   28.823782] pci_bus 0000:09: busn_res: [bus 09-2c] is released
> [   28.823851] pci 0000:08:00.0: Removing from iommu group 15

I think you're planning a v2 for Lukas comments.  When you do, can you
strip out the timestamps above, since they don't contribute to
understanding the problem.  It would also be helpful if you could
remove the irrelevant items from the stack trace and dmesg, e.g.,
"Can't disable streams", "busn_res", "Removing from iommu group",
"Host halt failed", maybe "USB disconnect", etc.  We mainly want to
see the call paths that cause the lockdep warning, and just enough of
the dmesg to help someone match their symptom to this fix.

Bjorn
