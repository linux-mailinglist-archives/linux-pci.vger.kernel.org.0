Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB83C164950
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 16:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBSP51 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 10:57:27 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:58581 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSP50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2020 10:57:26 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6AE27101E694F;
        Wed, 19 Feb 2020 16:57:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 16111ECCD0; Wed, 19 Feb 2020 16:57:24 +0100 (CET)
Date:   Wed, 19 Feb 2020 16:57:24 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, narendra_k@dell.com,
        Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH v3] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
Message-ID: <20200219155724.4jm2yt75u4s2t3tn@wunner.de>
References: <20200207195450.52026-1-stuart.w.hayes@gmail.com>
 <20200209150328.2x2zumhqbs6fihmc@wunner.de>
 <20200209180722.ikuyjignnd7ddfp5@wunner.de>
 <20200209202512.rzaqoc7tydo2ouog@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209202512.rzaqoc7tydo2ouog@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 09, 2020 at 09:25:12PM +0100, Lukas Wunner wrote:
> Below is another attempt.  I'll have to take a look at this with a
> fresh pair of eyeballs though to verify I haven't overlooked anything
> else and also to determine if this is actually simpler than Stuart's
> approach.  Again, the advantage here is that processing of the events
> by the IRQ thread is sped up by not delaying it until the Slot Status
> register has settled.

After some deliberation I've come full circle and think that Stuart's
approach is actually better than mine:

I thought that my approach would speed up processing of events by
waking the IRQ thread immediately after the first loop iteration.
But I've realized that right at the beginning of the IRQ thread,
synchronize_hardirq() is called, so the IRQ thread will wait for
the hardirq handler to finish before actually processing the events.

The rationale for the call to synchronize_hardirq() is that the
IRQ thread was woken, but now sees that the hardirq handler is
running (again) to collect more events.  In that situation it makes
sense to wait for them to be collected before starting to process
events.

Is the synchronize_hardirq() absolutely necessary?  Not really,
but I still think that it makes sense.  In reality, the latency
for additional loop iterations is likely small, so it's probably
not worth to optimize for immediate processing after the first
loop iteration.

Stuart's approach is also less intrusive and doesn't change the
logic as much as my approach does.  His patch therefore lends
itself better for backporting to stable.

So I've just respun Stuart's v3 patch, taking into account the
review comments I had sent for it.  I've taken the liberty to make
some editorial changes to the commit message and code comment.
Stuart & Bjorn, if you don't like these, please feel free to roll
back my changes to them as you see fit.

I realize now that I forgot to add the following tags,
Bjorn, could you add them if/when applying?

Fixes: 7b4ce26bcf69 ("PCI: pciehp: Convert to threaded IRQ")
Cc: stable@vger.kernel.org # v4.19+

Thanks!

Lukas
