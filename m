Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6E720C44
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jun 2023 01:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbjFBXTG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 19:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFBXTF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 19:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792FD123;
        Fri,  2 Jun 2023 16:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0906760F63;
        Fri,  2 Jun 2023 23:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25563C4339B;
        Fri,  2 Jun 2023 23:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685747943;
        bh=Eo339TE/OLsLyXEWbF4WtJJQ5NxP+CiAHuGpf6j8be0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xms/Aas6bnAwHlZsqnmshBtNnizBEgfnRy9Upaqj+Ok2ydwdPFONGhRBjSMGj/L7i
         pQKTbB+IxGs2Crpx7MaioICa749MruUVUqzblRe9ojbd+fm+rfwzuh5IoHBiBKLzqG
         Wf9wscM17MFH+NqpYuv1KqsleXgjjkxmMfddbTAwKm81uJNAi3Hvjvk5k7YRp49quQ
         qpwbpGYBIWGqt1Ga/4JPgkqAOnmaySwke2jk84yPH0RybDLiZfxi4mVHo+rW7fqDZY
         H+QDsiwJfVWc1/PJUZk6fACRTOd0HPON3OV4mhZeirdvVrQJjTBEonm8vMgWeKRwmb
         SeuFDBbxN6Ctg==
Date:   Fri, 2 Jun 2023 18:19:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
Message-ID: <ZHp45fNGuPUWPnO7@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af1bbb31-36d4-4924-e02a-bc22b938c7e4@amd.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 05:38:37PM -0500, Limonciello, Mario wrote:
> On 6/2/2023 5:20 PM, Bjorn Helgaas wrote:
> > On Tue, May 30, 2023 at 11:39:47AM -0500, Mario Limonciello wrote:
> > > Using a USB keyboard or mouse to wakeup the system from s2idle fails when
> > > that xHCI device is connected to a USB-C port for an AMD USB4 router.
> >
> > It sounds like the real issue is that "Root Ports in D3hot/D3cold may
> > not support wakeup", and the USB, xHCI, USB-C, AMD USB4 router bits
> > are probably not really relevant.  And hopefully even the "AMD
> > platforms" mentioned below is not relevant.
>
> Yeah.  It comes down to how much you want in the commit
> about how we got to this conclusion versus a generic
> fix.  I generally like to be verbose about a specific case
> something fixes so that when distros decide what to pull
> in to their older maintenance kernels they can understand
> what's important.

That's actually my point.  I think this problem probably affects
non-USB devices, non-xHCI devices, non-USB4 routers, etc.

If we can say "Any device below a Root Port in D3hot/D3cold may not
support wakeup if X, Y, Z.  Root Ports may be put in D3hot/D3cold for
sleep/hibernate/s2idle/...",  that's much more actionable.

> > > Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > all PCIe ports go into D3 during s2idle.
> > > 
> > > When specific root ports are put into D3 over s2idle on some AMD platforms
> > > it is not possible for the platform to properly identify wakeup sources.
> > > This happens whether the root port goes into D3hot or D3cold.
> >
> > Can we connect this to a spec so it's not just the empirical "some AMD
> > platforms work like X" observation?
> > 
> > "s2idle" is meaningful on the power management side of the house, but
> > it doesn't appear in PCI or ACPI specs, so I don't know what it means
> > here.  I assume the D3hot/D3cold state of the Root Port is the
> > critical factor, regardless of how it got there.
> 
> Unfortunately (?) for this particular issue it's only a
> critical factor when the system is in s2idle.
> 
> PME works fine to wake up the device if the root port is
> in either D3hot or D3cold when the system isn't in s2idle.

So that must mean something other than the Root Port has to be in some
specific state.  "System in s2idle" is not actionable in terms of PCI
maintenance.  It sounds like we just haven't really gotten to the root
cause yet.

> > > Linux shouldn't assume root ports support D3 just because they're on a
> > > machine newer than 2015, the ports should also be deemed power manageable.
> > > Add an extra check explicitly for root ports to ensure D3 isn't selected
> > > for them if they are not power-manageable through platform firmware.
> >
> > But I *would* like to know specifically what "power manageable" means
> > here.  I might naively assume that a device with the PCI Power
> > Management Capability is "power manageable", and that if PME_Support
> > includes D3hot and D3cold, we're good to go.  But obviously it's more
> > complicated than that, and I'd like to cite the spec that mentions the
> > actual things we need here.
>
> Power manageable through platform firmware means the device
> has ACPI methods like like _PR0, _PS0.

What's the connection to wakeup?

> > > +	 * It's not safe to put root ports that don't support power
> > > +	 * management into D3.
> >
> > I assume "it's not safe" really means "Root Ports in D3hot/D3cold may
> > not be able to signal PME interrupts unless ... <mumble> platform
> > firmware <mumble> e.g., ACPI method <mumble> ..."
> > 
> > Can we include some of those hints here?
> 
> I'm cautious about hardcoding logic used by
> acpi_bus_get_power_flags() in a comment in case it changes.
> 
> How about:
> 
> "Root ports in D3 may not be able to reliably signal wakeup
> events unless platform firmware signals power management
> capabilities".

I'm really looking hard for that spec citation :)  Without that, this
just devolves into "this seems to work on these systems."

> > > +	 */
> > > +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
> > > +	    !platform_pci_power_manageable(bridge))
> > > +		return false;
> > > +
> > >   	/*
> > >   	 * It should be safe to put PCIe ports from 2015 or newer
> > >   	 * to D3.
> > > -- 
> > > 2.34.1
> > > 
