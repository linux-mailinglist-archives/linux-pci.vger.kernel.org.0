Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAA462042
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbhK2TXj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351560AbhK2TVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 14:21:39 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF8C0619D3
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 07:39:47 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id AA2332805D230;
        Mon, 29 Nov 2021 16:39:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9DAC22ED5ED; Mon, 29 Nov 2021 16:39:43 +0100 (CET)
Date:   Mon, 29 Nov 2021 16:39:43 +0100
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
Message-ID: <20211129153943.GA4896@wunner.de>
References: <20211129121934.4963-1-hdegoede@redhat.com>
 <20211129121934.4963-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129121934.4963-2-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 01:19:34PM +0100, Hans de Goede wrote:
> Use down_read_nested() and down_write_nested() when taking the
> ctrl->reset_lock rw-sem, passing the PCI-device depth in the hierarchy
> as lock subclass parameter. This fixes the following false-positive lockdep
> report when unplugging a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:
[...]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

That's exactly what I had in mind, thanks.

Reported-by: "Theodore Ts'o" <tytso@mit.edu>
Link: https://lore.kernel.org/linux-pci/20190402021933.GA2966@mit.edu/
Link: https://lore.kernel.org/linux-pci/de684a28-9038-8fc6-27ca-3f6f2f6400d7@redhat.com/
Reviewed-by: Lukas Wunner <lukas@wunner.de>


> Note the 2nd patch can probably use a Fixes: tag but I had no
> idea which commit to put there. Or maybe add a Cc: stable to
> both patches?

I'd just add a stable designation and let the stable maintainers decide
which versions to backport to.  The problem I see is the dependency on
the first patch in the series.  In theory there's a syntax to specify
such prerequisites (see "Option 3" in
Documentation/process/stable-kernel-rules.rst), but in practice,
my experience is that stable maintainers may ignore such prerequisite tags.
It might be simplest to just squash the two patches together.

If you do respin, it would be good to explain in the commit message why
one lockdep class is used per hierarchy level:  This is done to conserve
class keys because their number is limited and the complexity grows
quadratically with number of keys according to
Documentation/locking/lockdep-design.rst.

It would also be good to explain why the lockdep splat occurs and why
it's a false positive:  With Thunderbolt, hotplug ports are nested.  When
removing multiple devices in a daisy-chain, each hotplug port's reset_lock
may be acquired recursively.  It's never the same lock, so the lockdep
splat is a false positive.  Because locks at the same hierarchy level
are never acquired recursively, a per-level lockdep class is sufficient
to fix the lockdep splat.

Thanks,

Lukas
