Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF13F89068
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfHKIHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 04:07:06 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:53355 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfHKIHG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 04:07:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2520F30001A46;
        Sun, 11 Aug 2019 10:07:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F0A83F5A33; Sun, 11 Aug 2019 10:07:03 +0200 (CEST)
Date:   Sun, 11 Aug 2019 10:07:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pciehp: fix a race between pciehp and removing
 operations by sysfs
Message-ID: <20190811080703.qfnlzfutgamoxzti@wunner.de>
References: <1565008378-4733-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565008378-4733-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 08:32:58PM +0800, Xiongfeng Wang wrote:
> When we remove a slot by sysfs.
> 'pci_stop_and_remove_bus_device_locked()' will be called. This function
> will get the global mutex lock 'pci_rescan_remove_lock', and remove the
> slot. If the irq thread 'pciehp_ist' is still running, we will wait
> until it exits.
> 
> If a pciehp interrupt happens immediately after we remove the slot by
> sysfs, but before we free the pciehp irq in
> 'pci_stop_and_remove_bus_device_locked()'. 'pciehp_ist' will hung
> because the global mutex lock 'pci_rescan_remove_lock' is held by the
> sysfs operation. But the sysfs operation is waiting for the pciehp irq
> thread 'pciehp_ist' ends. Then a hung task occurs.
> 
> So this two kinds of operation, removing the slot triggered by pciehp
> interrupt and removing through 'sysfs', should not be excuted at the
> same time. This patch add a global variable to mark that one of these
> operations is under processing. When this variable is set,  if another
> operation is requested, it will be rejected.

It seems this patch involves an ABI change wherein "remove" as documented
in Documentation/ABI/testing/sysfs-bus-pci may now fail and need a retry,
possibly breaking existing scripts which write to this file.  ABI changes
are fairly problematic.

The return value -EWOULDBLOCK (which is identical to -EAGAIN) might be
more appropriate than -EINVAL.

Another problem is that this patch only addresses deadlocks occurring
because of a "remove" via sysfs and a simultaneous surprise removal
(or button press removal).  However the same kind of deadlock may
occur because of two simultaneous surprise removals if one of the
two devices is a parent of the other.  It would be better to have
a solution which addresses all types of deadlocks caused by the
pci_rescan_remove_lock().  I provided you with a suggestion in this
e-mail:

https://lore.kernel.org/linux-pci/20190805114053.srbngho3wbziy2uy@wunner.de/

   "What you can do is add a flag to struct pci_dev (or the priv_flags
    embedded therein) to indicate that a device is about to be removed.
    Set this flag on all children of the device being removed before
    acquiring pci_lock_rescan_remove() and avoid taking that lock in
    pciehp_unconfigure_device() if the flag is set on the hotplug port.

    But again, that approach is just a band-aid and the real fix is to
    unbind devices without holding the lock."

Thanks,

Lukas
