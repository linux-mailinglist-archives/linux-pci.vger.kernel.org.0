Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A384E68E2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 19:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352161AbiCXSyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347682AbiCXSyM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 14:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC83B8211;
        Thu, 24 Mar 2022 11:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE97261AF5;
        Thu, 24 Mar 2022 18:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0659DC340EC;
        Thu, 24 Mar 2022 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648147959;
        bh=J1U967edacUKqsMOKaKTNbYO0SoILVgjhb70YrFL3as=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=auaHy3c8Otw2WdRSmxl1N4gBKDbSbDhKVwz3MIYICZzPwJvySaB2a6jKxWGch5wHE
         PZ6AUteMeTK0ribzXyhwA271qdxGvdtBxzQay53SZdxwDsNgD+AgJtgH14p9x1qB5+
         1G9v/H0ShFfOC+n9mC6LawOhZsmOmYmaUuZKenou1VjM8ilBq5C6iT0L8Cq32bTt23
         jhC94Sz/Le/BPDndzW/wCujaFEC1b0slSPYuRsHZppE/rOT+BKcKHVVLq8hV2YcP/B
         hoHSrHgIGelxGZtxfqSosyX5VBC4RsTcX8KK/ayMbVKysc6m1K2bbxE+moi3CkGZn3
         I+NvRtSQsv1PQ==
Date:   Thu, 24 Mar 2022 13:52:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Message-ID: <20220324185237.GA1466503@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hVFkKXTJcrFqRR4FoK5v_k3zCacKPmurWm=sozt7GPiQ@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 07:31:56PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 24, 2022 at 6:15 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Thursday, March 24, 2022 11:35
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>; open list:PCI SUBSYSTEM <linux-
> > > pci@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>; Mehta, Sanju
> > > <Sanju.Mehta@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; Mika
> > > Westerberg <mika.westerberg@linux.intel.com>
> > > Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
> > > device can wake from D3
> > >
> > > [+cc Mika, "HotPlugSupportInD3" scope question below]
> >
> > FYI - Mika had approved some earlier versions of this, so I expect conceptual
> > Alignment at least with the latest one.
> >
> > <snip>
> >
> > > > > Can we at least list some common scenarios?  E.g., it affects
> > > > > kernels after commit X, or it affects machines with CPUs newer
> > > > > than Y, or it affects a certain kind of tunneling, etc?  Distros
> > > > > need this information so they can figure whether and how far to
> > > > > backport things like this.
> > > >
> > > > It's going to affect any retail machine with the SOC we refer to in
> > > > the kernel as "Yellow Carp".  This is one of the first non-Intel
> > > > USB4 hosts and will be using the USB4 SW CM in the kernel.
> > > >
> > > > Without this change, effectively PCIe tunneling will not work when
> > > > any downstream PCIe device is hotplugged.  In the right
> > > > circumstances it might work if it's coldbooted (if the paths
> > > > selected by the pre-boot firmware connection manager are identical
> > > > to that selected by SW CM).
> > >
> > > Thanks a lot for this context!  As far as I can tell from grubbing
> > > through the git history, there are no PCI, USB4, or Thunderbolt
> > > changes related to Yellow Carp, so I assume this has to do with Yellow
> > > Carp firmware doing things differently than previous platforms.
> >
> > There have been a variety of Thunderbolt/USB4 changes as a result of
> > Yellow Carp development and findings, but they have not been quirks;
> > they have been done as generic changes that still make sense for all
> > USB4 devices.
> >
> > Sanju (on CC) has submitted a majority of these, so if you want to see
> > a sense of what these are you can look for his commits in drivers/thunderbolt.
> >
> > > Previously, if a Root Port implemented the HotPlugSupportInD3
> > > property, we assumed that the Root Port and any downstream bridges
> > > could handle hot-plug events while in D3hot.
> > >
> > > I guess the difference here is that on Yellow Carp firmware, even if
> > > there is a HotPlugSupportInD3 property on the Root Port, the Root Port
> > > cannot handle hot-plug events in D3hot UNLESS there is also an _S0W
> > > method AND that _S0W says the Root Port can wakeup from D3hot or
> > > D3cold, right?
> >
> > Yes, correct!
> >
> > > I have some heartburn about this that's only partly related to this
> > > patch.  The Microsoft doc clearly says "HotPlugSupportInD3" must be
> > > implemented on Root Ports and its presence tells us that the *Root
> > > Port* can handle hot-plug events while in D3.
> > >
> > > But acpi_pci_bridge_d3() looks up the Root Port at the top of the
> > > hierarchy and assume that its "HotPlugSupportInD3" applies to any
> > > switch ports that may be below that Root Port (added by 26ad34d510a8
> > > ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") [1]).
> 
> Not really.
> 
> "HotPlugSupportInD3" applies to the root port only and the platform
> firmware may not know about any ports below it.
> 
> However, the presence of "HotPlugSupportInD3" is used as an indicator
> that the entire hierarchy is "D3cold-aware", so to speak.
> Essentially, this boils down to the "Is the hardware modern enough?"
> consideration and the answer is assumed to be "yes" if the property in
> question is present for the root port.

Seems weird to me since we're talking about a hot-plug Root Port and
anything at all could be plugged into it.  We're basically saying that
we can assume a property of an arbitrary downstream device based on
something we know about the upstream device.  I'm still not
comfortable with that.

At a minimum we should add a comment about this assumption.  The
existing "... we know the hierarchy behind it supports D3 just fine"
seems a little too strong.

> But if "HotPlugSupportInD3" is not consistent with the other pieces of
> information regarding the root port available from the firmware (_PRW
> and _S0W in this particular case), the presence of it is questionable
> in the first place, so IMO the approach here makes sense.

This part seems reasonable to me, as long as we have good confidence
that requiring "HotPlugSupportInD3" + _PRW + _S0W where we used to
require only "HotPlugSupportInD3" is unlikely to break anything.

I can't judge that, but I assume you know that we don't use the
acpi_pci_bridge_d3() result unless _PRW and _S0W exist, so I'll take
your word for it :)

Bjorn
