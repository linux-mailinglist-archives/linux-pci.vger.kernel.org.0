Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C30196E36
	for <lists+linux-pci@lfdr.de>; Sun, 29 Mar 2020 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgC2Pnz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Mar 2020 11:43:55 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46379 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Pnz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Mar 2020 11:43:55 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 163AA30002531;
        Sun, 29 Mar 2020 17:43:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DF2353F4B0; Sun, 29 Mar 2020 17:43:52 +0200 (CEST)
Date:   Sun, 29 Mar 2020 17:43:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: Deadlock during PCIe hot remove
Message-ID: <20200329154352.5lxbtlf3464sm4ce@wunner.de>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 03:21:52PM +0000, Haeuptle, Michael wrote:
> I'm running into a deadlock scenario between the hotplug, pcie and
> vfio_pci driver when removing multiple devices in parallel.
> This is happening on CentOS8 (4.18) with SPDK (spdk.io). I'm using
> the latest pciehp code, the rest is all 4.18.
> 
> The sequence that leads to the deadlock is as follows:
> 
> The pciehp_ist() takes the reset_lock early in its processing.
> While the pciehp_ist processing is progressing, vfio_pci calls
> pci_try_reset_function() as part of vfio_pci_release or open.
> The pci_try_reset_function() takes the device lock.
> 
> Eventually, pci_try_reset_function() calls pci_reset_hotplug_slot()
> which calls pciehp_reset_slot(). The pciehp_reset_slot() tries to
> take the reset_lock but has to wait since it is already taken by
> pciehp_ist().
> 
> Eventually pciehp_ist calls pcie_stop_device() which calls
> device_release_driver_internal(). This function also tries to take
> device_lock causing the dead lock.
> 
> Here's the kernel stack trace when the deadlock occurs: 
> 
> [root@localhost ~]# cat /proc/8594/task/8598/stack
> [<0>] pciehp_reset_slot+0xa5/0x220
> [<0>] pci_reset_hotplug_slot.cold.72+0x20/0x36
> [<0>] pci_dev_reset_slot_function+0x72/0x9b
> [<0>] __pci_reset_function_locked+0x15b/0x190
> [<0>] pci_try_reset_function.cold.77+0x9b/0x108
> [<0>] vfio_pci_disable+0x261/0x280
> [<0>] vfio_pci_release+0xcb/0xf0
> [<0>] vfio_device_fops_release+0x1e/0x40
> [<0>] __fput+0xa5/0x1d0
> [<0>] task_work_run+0x8a/0xb0
> [<0>] exit_to_usermode_loop+0xd3/0xe0
> [<0>] do_syscall_64+0xe1/0x100
> [<0>] entry_SYSCALL_64_after_hwframe+0x65/0xca
> [<0>] 0xffffffffffffffff

There's something I don't understand here:

The device_lock exists per-device.
The reset_lock exists per hotplug-capable downstream port.

Now if I understand correctly, in the stacktrace above, the
device_lock of the *downstream port* is acquired and then
its reset_lock is tried to acquire, which however is already
held by pciehp_ist().

You're saying that pciehp_ist() is handling removal of the
endpoint device *below* the downstream port, which means that
device_release_driver_internal() tries to acquire the device_lock
of the *endpoint device*.  That's a separate lock than the one
acquired by vfio_pci_disable() before calling
pci_try_reset_function()!

So I don't quite understand how there can be a deadlock.  Could
you instrument the code with a few printk()'s and dump_stack()'s
to show exactly which device's device_lock is acquired from where?

Note that device_release_driver_internal() also acquires the
parent's device_lock and this would indeed be the one of the
downstream port.  However commit 8c97a46af04b ("driver core:
hold dev's parent lock when needed") constrained that to
USB devices.  So the parent lock shouldn't be taken for PCI
devices.  That commit went into v4.18, please double-check
that you have it in your tree.

Thanks,

Lukas
