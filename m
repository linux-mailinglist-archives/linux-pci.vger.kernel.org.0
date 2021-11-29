Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4F462463
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 23:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhK2WSV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 17:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhK2WRd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 17:17:33 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E495C04C32A
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 10:59:48 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2146330000641;
        Mon, 29 Nov 2021 19:59:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 114A924ADCC; Mon, 29 Nov 2021 19:59:46 +0100 (CET)
Date:   Mon, 29 Nov 2021 19:59:46 +0100
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
Message-ID: <20211129185946.GA1475@wunner.de>
References: <20211129121934.4963-1-hdegoede@redhat.com>
 <20211129121934.4963-2-hdegoede@redhat.com>
 <20211129153943.GA4896@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129153943.GA4896@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 04:39:43PM +0100, Lukas Wunner wrote:
> On Mon, Nov 29, 2021 at 01:19:34PM +0100, Hans de Goede wrote:
> > Use down_read_nested() and down_write_nested() when taking the
> > ctrl->reset_lock rw-sem, passing the PCI-device depth in the hierarchy
> > as lock subclass parameter. This fixes the following false-positive lockdep
> > report when unplugging a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:
> [...]
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> That's exactly what I had in mind, thanks.

Hm, I found the notes that I took when I investigated Theodore's report:
Using a subclass may be problematic because it's limited to a value < 8
(MAX_LOCKDEP_SUBCLASSES).  If there's a hotplug port at a deeper level
than 8 in the PCI hierarchy (can easily happen, Thunderbolt daisy chain
allows up to 6 devices, each device contains a PCIe switch, so 2 levels per
device), look_up_lock_class() in kernel/locking/lockdep.c will emit a BUG
error message.

It may be necessary to call lockdep_register_key() for each level or
for each hotplug port and assign the lock with lockdep_set_class()
(or ..._and_name() and use the dev_name()).

It's these complications that made me put aside the problem back in the day.
My apologies for not remembering them earlier.

Thanks,

Lukas
