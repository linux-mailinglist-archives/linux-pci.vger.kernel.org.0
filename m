Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29058184E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 13:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfHELkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 07:40:55 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:58483 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHELkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2019 07:40:55 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id EE7D6100B029E;
        Mon,  5 Aug 2019 13:40:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A70823E553; Mon,  5 Aug 2019 13:40:53 +0200 (CEST)
Date:   Mon, 5 Aug 2019 13:40:53 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciehp: fix a race between pciehp and removing
 operations by sysfs
Message-ID: <20190805114053.srbngho3wbziy2uy@wunner.de>
References: <1519648875-38196-1-git-send-email-wangxiongfeng2@huawei.com>
 <20190802003618.GJ151852@google.com>
 <0c0512fd-e95a-74be-09c2-1576844d9c97@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0512fd-e95a-74be-09c2-1576844d9c97@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 02, 2019 at 04:23:33PM +0800, Xiongfeng Wang wrote:
> If I use a global flag to mark if any pci device is being rescaned or
> removed, the problem is that we can't remove two devices belonging to
> two root ports at the same time.
> Since a root port produces a pci tree, so I was planning to make the
> flag per root port slot. I mean add the flag in 'struct slot'.
>  But in some situation, the root port doesn't support hotplug and the
> downport below the root port support hotplug. I am not sure if it's
> better to add the flag in 'struct pci_dev' of the root port.

We're susceptible to deadlocks if at least two hotplug ports are removed
simultaneously where one is a parent of the other.

What you're witnessing is basically a variation of that problem wherein
a hotplug port is removed while it is simultaneously removing its
children.

pci_lock_rescan_remove(), which was introduced by commit 9d16947b7583
to fix races (which are real), at the same time caused these deadlocks.
The lock is too coarse-grained and needs to be replaced with more
fine-grained locking.

Specifically, unbinding PCI devices from drivers on removal need not
and should not happen under that lock.  That will fix all the deadlocks.

I've submitted a patch last year to address one class of those deadlocks
but withdrew it as I realized it's not a proper fix:

https://patchwork.kernel.org/patch/10468065/

What you can do is add a flag to struct pci_dev (or the priv_flags
embedded therein) to indicate that a device is about to be removed.
Set this flag on all children of the device being removed before
acquiring pci_lock_rescan_remove() and avoid taking that lock in
pciehp_unconfigure_device() if the flag is set on the hotplug port.

But again, that approach is just a band-aid and the real fix is to
unbind devices without holding the lock.

Thanks,

Lukas
