Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE02245B300
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 05:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbhKXEQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 23:16:30 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:39181 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhKXEQ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 23:16:28 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id DE5B010315524;
        Wed, 24 Nov 2021 05:13:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A4BAB17C3C; Wed, 24 Nov 2021 05:13:17 +0100 (CET)
Date:   Wed, 24 Nov 2021 05:13:17 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: Lockdep warning about ctrl->reset_lock in
 pciehp_check_presence/pciehp_ist on TB3 dock unplug
Message-ID: <20211124041317.GA1887@wunner.de>
References: <de684a28-9038-8fc6-27ca-3f6f2f6400d7@redhat.com>
 <20211122212943.GA2176134@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122212943.GA2176134@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 22, 2021 at 03:29:43PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 22, 2021 at 05:45:32PM +0100, Hans de Goede wrote:
> > With 5.16-rc2 I'm getting the following lockdep warning when unplugging
> > a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:

Thanks for the report.  I'm aware of this issue, it's still on my todo
list.  Theodore already came across it a while ago:

https://lore.kernel.org/linux-pci/20190402021933.GA2966@mit.edu/

It's a false positive, we need to use a separate lockdep class either
for each hotplug port or for each level in the PCI hierarchy.

Thanks,

Lukas

> > [   28.583853] pcieport 0000:06:01.0: pciehp: Slot(1): Link Down
> > [   28.583891] pcieport 0000:06:01.0: pciehp: Slot(1): Card not present
> > [   28.583995] pcieport 0000:09:04.0: can't change power state from D3cold to D0 (config space inaccessible)
> > 
> > [   28.584849] ============================================
> > [   28.584854] WARNING: possible recursive locking detected
> > [   28.584858] 5.16.0-rc2+ #621 Not tainted
> > [   28.584864] --------------------------------------------
> > [   28.584867] irq/124-pciehp/86 is trying to acquire lock:
> > [   28.584873] ffff8e5ac4299ef8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_check_presence+0x23/0x80
> > [   28.584904] 
> >                but task is already holding lock:
> > [   28.584908] ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
> > [   28.584929] 
> >                other info that might help us debug this:
> > [   28.584933]  Possible unsafe locking scenario:
> > 
> > [   28.584936]        CPU0
> > [   28.584939]        ----
> > [   28.584942]   lock(&ctrl->reset_lock);
> > [   28.584949]   lock(&ctrl->reset_lock);
> > [   28.584955] 
> >                 *** DEADLOCK ***
> > 
> > [   28.584959]  May be due to missing lock nesting notation
> > 
> > [   28.584963] 3 locks held by irq/124-pciehp/86:
> > [   28.584970]  #0: ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
> > [   28.584991]  #1: ffffffffa3b024e8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_unconfigure_device+0x31/0x110
> > [   28.585012]  #2: ffff8e5ac1ee2248 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40
> > [   28.585037] 
> >                stack backtrace:
> > [   28.585042] CPU: 4 PID: 86 Comm: irq/124-pciehp Not tainted 5.16.0-rc2+ #621
> > [   28.585052] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET30W (1.20 ) 08/26/2021
> > [   28.585059] Call Trace:
> > [   28.585064]  <TASK>
> > [   28.585073]  dump_stack_lvl+0x59/0x73
> > [   28.585087]  __lock_acquire.cold+0xc5/0x2c6
> > [   28.585106]  ? find_held_lock+0x2b/0x80
> > [   28.585124]  lock_acquire+0xb5/0x2b0
> > [   28.585132]  ? pciehp_check_presence+0x23/0x80
> > [   28.585144]  ? lock_is_held_type+0xa8/0x120
> > [   28.585161]  down_read+0x3e/0x50
> > [   28.585172]  ? pciehp_check_presence+0x23/0x80
> > [   28.585183]  pciehp_check_presence+0x23/0x80
> > [   28.585194]  pciehp_runtime_resume+0x5c/0xa0
> > [   28.585206]  ? pci_msix_init+0x60/0x60
> > [   28.585214]  device_for_each_child+0x45/0x70
> > [   28.585227]  pcie_port_device_runtime_resume+0x20/0x30
> > [   28.585236]  pci_pm_runtime_resume+0xa7/0xc0
> > [   28.585246]  ? pci_pm_freeze_noirq+0x100/0x100
> > [   28.585257]  __rpm_callback+0x41/0x110
> > [   28.585271]  ? pci_pm_freeze_noirq+0x100/0x100
> > [   28.585281]  rpm_callback+0x59/0x70
> > [   28.585293]  rpm_resume+0x512/0x7b0
> > [   28.585309]  __pm_runtime_resume+0x4a/0x90
> > [   28.585322]  __device_release_driver+0x28/0x240
> > [   28.585338]  device_release_driver+0x26/0x40
> > [   28.585351]  pci_stop_bus_device+0x68/0x90
> > [   28.585363]  pci_stop_bus_device+0x2c/0x90
> > [   28.585373]  pci_stop_and_remove_bus_device+0xe/0x20
> > [   28.585384]  pciehp_unconfigure_device+0x6c/0x110
> > [   28.585396]  ? __pm_runtime_resume+0x58/0x90
> > [   28.585409]  pciehp_disable_slot+0x5b/0xe0
> > [   28.585421]  pciehp_handle_presence_or_link_change+0xc3/0x2f0
> > [   28.585436]  pciehp_ist+0x179/0x180
> > [   28.585449]  ? disable_irq_nosync+0x10/0x10
> > [   28.585460]  irq_thread_fn+0x1d/0x60
> > [   28.585470]  ? irq_thread+0x81/0x1a0
> > [   28.585480]  irq_thread+0xcb/0x1a0
> > [   28.585491]  ? irq_thread_fn+0x60/0x60
> > [   28.585502]  ? irq_thread_check_affinity+0xb0/0xb0
> > [   28.585514]  kthread+0x165/0x190
> > [   28.585522]  ? set_kthread_struct+0x40/0x40
> > [   28.585531]  ret_from_fork+0x1f/0x30
> > [   28.585554]  </TASK>
