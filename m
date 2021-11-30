Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99DC463EB9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 20:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbhK3TnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 14:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhK3TnN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 14:43:13 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEBCC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 11:39:53 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 57A2730000349;
        Tue, 30 Nov 2021 20:39:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4BD5D108869; Tue, 30 Nov 2021 20:39:51 +0100 (CET)
Date:   Tue, 30 Nov 2021 20:39:51 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Use down_read/write_nested(reset_lock)
 to fix lockdep errors
Message-ID: <20211130193951.GA15925@wunner.de>
References: <20211129121934.4963-1-hdegoede@redhat.com>
 <20211129121934.4963-2-hdegoede@redhat.com>
 <20211129153943.GA4896@wunner.de>
 <20211129185946.GA1475@wunner.de>
 <0dcac663-4726-6deb-d518-3f29583b7baf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dcac663-4726-6deb-d518-3f29583b7baf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 11:15:40AM +0100, Hans de Goede wrote:
> On 11/29/21 19:59, Lukas Wunner wrote:
> > Hm, I found the notes that I took when I investigated Theodore's report:
> > Using a subclass may be problematic because it's limited to a value < 8
> > (MAX_LOCKDEP_SUBCLASSES).  If there's a hotplug port at a deeper level
> > than 8 in the PCI hierarchy (can easily happen, Thunderbolt daisy chain
> > allows up to 6 devices, each device contains a PCIe switch, so 2 levels per
> > device), look_up_lock_class() in kernel/locking/lockdep.c will emit a BUG
> > error message.

Actually, after thinking about this some more it has occurred to me
that you should be able to make do with 8 subclasses if you change
the algorithm in patch [1/2] to something like this:

	while (bus->parent) {
-		depth++;
		bus = bus->parent;
+		if (bus->self->is_hotplug_bridge)
+			depth++;
	}

(It may be necessary to add a NULL pointer check for bus->self,
off the top of my hat I'm not sure if that's set for the root bus.)

Because with the patches as they are, the array of 8 subclasses is
sparsely populated, i.e. if a parent port is not a hotplug port,
a subclass is wasted.  You only care about hotplug ports (more
specifically those handled by pciehp) because those are the only
ones with a reset_lock.  The above change should result in a
densely populated array of subclasses.

Naturally, because this makes the function pciehp-specific,
it should be moved from include/linux/pci.h to pciehp_hpc.c.

With Thunderbolt you can have 6 devices plus the hotplug port in
the host controller.  And there may be an 8th hotplug port at the
Root Port if the host controller can be "unplugged" when it goes
to D3cold.  (That's handled by acpiphp, not pciehp, and I'm not
even sure if is_hotplug_bridge is set in that case.)
So 8 subclasses should be sufficient.

Aside from Thunderbolt, nested hotplug ports exist in data centers
with hot-removable NVMe slots in hot-removable chassis, but I highly
doubt those use cases have more than 8 levels of hotplug ports.

So that would probably be a pragmatic and minimalistic approach to this
problem.

Thanks,

Lukas
