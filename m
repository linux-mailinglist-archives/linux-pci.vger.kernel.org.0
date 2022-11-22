Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B863426C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiKVR00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 12:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKVR0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 12:26:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E275D87
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 09:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDF9617FB
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 17:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286D9C433C1;
        Tue, 22 Nov 2022 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669137984;
        bh=7Ps8ZfkHF5M9k8eMHcwMwPv/gwwPZmeDmsutOAl+fio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CUk2vLIBFtHvDXVgLhzphZnECufWiPRJfrtcWszhWIceO6clF3ZyQO5WA4/I21gcd
         NOfWnEuyiKIkxY2VJVmj7lD+kHMPzLD6Os7BuOql/RCnAwaMBcrITI16bnau61bncW
         /PZk6rO12Kj/TelNvFmmsi6gxJkDDlXLqhLYMUWXSwsAx6OuAzJOhwcMLXn4lretfL
         1r/EEaCystoM/pwxQnrHH33/UrBkzowMXFHWp8w61zP7YVT/YYK6hyy4oqGSmciZCj
         Y2SM7FM6s6bWjYLy8qKhxMEJpeebRQNVsbZaHJcj9jAo/IV7L7K1ri/ms4lUicmAfS
         BzEzumUkeDR/A==
Date:   Tue, 22 Nov 2022 11:26:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <20221122172622.GA197413@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122114541.00005ff9@Huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 11:45:41AM +0000, Jonathan Cameron wrote:
> On Tue, 22 Nov 2022 08:42:58 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > On Mon, Nov 21, 2022 at 04:45:48PM -0600, Bjorn Helgaas wrote:
> > > IIUC, the summary is this:
> > > 
> > >   00:02.0 bridge window [mem 0x10000000-0x102fffff] to [bus 01-02]
> > >   01:02.0 bridge window [mem 0x10000000-0x100fffff] to [bus 02]
> > >   01:03.0 NIC BAR [mem 0x10200000-0x1021ffff]
> > >   01:04.0 NIC BAR [mem 0x10220000-0x1023ffff]
> > >   02:05.0 NIC BAR [mem 0x10080000-0x1009ffff]
> > > 
> > > and it's the same with and without the current patch.
> > > 
> > > Are all these assignments done by BIOS, or did Linux update them?  
> > 
> > > Did we exercise the same "distribute available resources" path as in
> > > the PCIe case?  I expect we *should*, because there really shouldn't
> > > be any PCI vs PCIe differences in how resources are handled.  This is
> > > why I'm not comfortable with assumptions here that depend on PCIe.
> > > 
> > > I can't tell from Jonathan's PCIe case whether we got a working config
> > > from BIOS or not because our logging of bridge windows is kind of
> > > poor.  
> > 
> > This is ARM64 so there is no "BIOS" involved (something similar though).
> 
> It's EDK2 in my tests  - so very similar to other arch.
> Possible to boot without though and rely on DT, but various things don't
> work yet...

Doesn't matter whether it's BIOS/EFI/EDK2/etc, the question was really
whether anything has programmed BARs and windows before Linux gets
started.

> From liberal distribution of printk()s it seems that for PCI bridges
> pci_bridge_resources_not_assigned() is false, but for PCI express
> example it is true.  My first instinct is quirk of the EDK2 handling? 
> I'll have a dig, but I'm not an expert in EDK2 at all, so may not get
> to the bottom of this.

I don't know what pci_bridge_resources_not_assigned() is.

> Ultimately it seems that when the OS takes over the prefetchable memory
> resources are not configured for the PCIe case, but are for the PCI case.
> So we aren't currently walking the new code for PCI.

Whatever the reason for this is, it doesn't sound like something Linux
should assume or rely on.

Bjorn
