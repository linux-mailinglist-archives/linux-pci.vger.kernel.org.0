Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD154E6718
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 17:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiCXQg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiCXQg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 12:36:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848621E3C2;
        Thu, 24 Mar 2022 09:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DDEC61908;
        Thu, 24 Mar 2022 16:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3427CC340EC;
        Thu, 24 Mar 2022 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648139694;
        bh=MwEBxoUcJHEj1ejih7Nggyyx2DlbRXKacpB98IMsXOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EBjCKI68pOLx3BBQiIMJUxZRZ7EJp3Vj7FNlqkeXk48bJcjs1J8TeLGch6QN1C2cs
         UliuGNpqu52rjYiQMEHIwcOZTJ5YxqCKvB9afH3oZKhjcEfcoA2AXufkvTzLsEOWvr
         z6z0AuOXdK4FIQgtrqIEAXnArlLqjzHuQ+JDxAQHjLnDHtWsGPdETM07iWsGfosWoe
         jZdkWUoDr1N7ybxApsl2wsT4mYFM4X+19M1v6W3f1dvPRxTOWXIn+8IdK1sN6w6keK
         c2+Q+/K+FXAeRHPdyPyViUnmf2Rq34gdib3yGtNE3k6ItnXlaDPlOK/+gCbpa96qvJ
         YBSNR44BwEAeg==
Date:   Thu, 24 Mar 2022 11:34:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Message-ID: <20220324163452.GA1449620@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51575C7E6979A60E2637CC82E2189@BL1PR12MB5157.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, "HotPlugSupportInD3" scope question below]

On Wed, Mar 23, 2022 at 09:51:18PM +0000, Limonciello, Mario wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, March 23, 2022 16:43
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; open list:PCI SUBSYSTEM <linux-
> > pci@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>; Mehta, Sanju
> > <Sanju.Mehta@amd.com>; Rafael J. Wysocki <rafael@kernel.org>
> > Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if device
> > can wake from D3
> > 
> > On Wed, Mar 23, 2022 at 09:26:15PM +0000, Limonciello, Mario wrote:
> > > [Public]
> > >
> > > >
> > > > On Wed, Mar 23, 2022 at 11:01:05AM -0500, Mario Limonciello wrote:
> > > > > On 3/15/22 11:36, Rafael J. Wysocki wrote:
> > > > > > On Tue, Mar 15, 2022 at 5:35 PM Rafael J. Wysocki <rafael@kernel.org>
> > > > wrote:
> > > > > > >
> > > > > > > On Tue, Mar 15, 2022 at 4:33 PM Mario Limonciello
> > > > > > > <mario.limonciello@amd.com> wrote:
> > > > > > > >
> > > > > > > > According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
> > > > > > > > indicates the ability for a bridge to be able to wakeup from D3:
> > > > > > > >
> > > > > > > >    This ACPI object [HotPlugSupportInD3] enables the operating
> > system
> > > > > > > >    to identify and power manage PCIe Root Ports that are capable of
> > > > > > > >    handling hot plug events while in D3 state.
> > > > > > > >
> > > > > > > > This however is static information in the ACPI table at BIOS
> > compilation
> > > > > > > > time and on some platforms it's possible to configure the firmware at
> > > > boot
> > > > > > > > up such that _S0W returns "0" indicating the inability to wake up the
> > > > > > > > device from D3 as explained in the ACPI specification:
> > > > > > > >
> > > > > > > >    7.3.20 _S0W (S0 Device Wake State)
> > > > > > > >
> > > > > > > >    This object evaluates to an integer that conveys to OSPM the
> > deepest
> > > > > > > >    D-state supported by this device in the S0 system sleeping state
> > > > > > > >    where the device can wake itself.
> > > > > > > >
> > > > > > > > This mismatch may lead to being unable to enumerate devices behind
> > the
> > > > > > > > hotplug bridge when a device is plugged in. To remedy these
> > situations
> > > > > > > > that `HotPlugSupportInD3` is specified by _S0W returns 0, explicitly
> > > > > > > > check that the ACPI companion has returned _S0W greater than or
> > equal
> > > > > > > > to 3 and the device has a GPE allowing the device to generate wakeup
> > > > > > > > signals handled by the platform in `acpi_pci_bridge_d3`.
> > > > > > > >
> > > > > > > > Windows 10 and Windows 11 both will prevent the bridge from going
> > in
> > > > D3
> > > > > > > > when the firmware is configured this way and this changes aligns the
> > > > > > > > handling of the situation to be the same.
> > > > > > > >
> > > > > > > > Link:
> > > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org
> > %2F&amp;data=04%7C01%7CMario.Limonciello%40amd.com%7C095e9cb1cb3
> > 34458a08d08da0d1610bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> > %7C637836685684066439%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> > =aAj91EajV77J7GjWEGGhAYLAb9Al2TMsH1baasdVdyI%3D&amp;reserved=0
> > > >
> > %2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt
> > > > %2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-
> > s0-
> > > > device-wake-
> > > >
> > state&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C1f96c7aa37a
> > > >
> > c47640d6208da0d0efd67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> > > >
> > %7C637836655281536690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > > >
> > MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> > > >
> > =Cw1OTYiX9BD3gh8eN3Zyz6%2FK8YFgqbn6bgi9%2FjNsnrM%3D&amp;reserved
> > > > =0
> > > > > > > > Link:
> > > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.mi
> > %2F&amp;data=04%7C01%7CMario.Limonciello%40amd.com%7C095e9cb1cb3
> > 34458a08d08da0d1610bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> > %7C637836685684066439%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> > =v8YYoxTCp1drb7ZxgbDkrgA2Nc3TxbENLBfPxbo1CTI%3D&amp;reserved=0
> > > > crosoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-
> > pcie-
> > > > root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-
> > > >
> > d3&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C1f96c7aa37ac4
> > > >
> > 7640d6208da0d0efd67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
> > > >
> > 7C637836655281536690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > > >
> > DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=
> > > >
> > UkB5lmz1QBUzWVM6%2BuNzJsleP%2Fi%2BDCJJuSgINiNbymo%3D&amp;reserv
> > > > ed=0
> > > > > > > > Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe
> > hotplug
> > > > ports")
> > > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > >
> > > > > > > No more comments from me:
> > > > > > >
> > > > > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > Or please let me know if I should pick it up.
> > > > >
> > > > > Bjorn,
> > > > >
> > > > > Friendly reminder on this one.
> > > >
> > > > Thanks; we're in the middle of the merge window now, so I'll
> > > > wait till that's over unless this is an emergency.
> > >
> > > Actually it's a pretty important problem.  We waffled on the
> > > nuts and bolts of this commit during the 5.17 RC's, but I didn't
> > > think we would make it out to the merge window before it got
> > > picked.  I guess I should have spoke up on the urgency earlier.
> > >
> > > > IIUC the bug this fixes is that "when a bridge is in D3cold,
> > > > we don't notice when a device is hot-added below it," right?
> > > > So we need to avoid putting the bridge in D3cold?
> > >
> > > When the ASL has been configured this way (to return 0 for _S0W)
> > > the lower level hardware implementation will lead to hotplugged
> > > devices not being detected.  Without this commit the hardware
> > > will expect to be in D0, but the kernel will select D3hot.  So
> > > yes; the outcome is that hotplugged PCIe devices don't work.
> > >
> > > > Is there a typical scenario where this bites users?  I don't
> > > > think we ever saw an actual problem report?
> > >
> > > This is the common way that these systems are being shipped.  I
> > > have plenty of private reports related to this, but nothing
> > > public to link to.
> > 
> > I still have no clue how many people this affects, what kernel
> > versions, etc.  If there are no public reports, it suggests that
> > it doesn't affect distro kernels or production machines yet.
> > 
> > Can we at least list some common scenarios?  E.g., it affects
> > kernels after commit X, or it affects machines with CPUs newer
> > than Y, or it affects a certain kind of tunneling, etc?  Distros
> > need this information so they can figure whether and how far to
> > backport things like this.
> 
> It's going to affect any retail machine with the SOC we refer to in
> the kernel as "Yellow Carp".  This is one of the first non-Intel
> USB4 hosts and will be using the USB4 SW CM in the kernel.
> 
> Without this change, effectively PCIe tunneling will not work when
> any downstream PCIe device is hotplugged.  In the right
> circumstances it might work if it's coldbooted (if the paths
> selected by the pre-boot firmware connection manager are identical
> to that selected by SW CM).

Thanks a lot for this context!  As far as I can tell from grubbing
through the git history, there are no PCI, USB4, or Thunderbolt
changes related to Yellow Carp, so I assume this has to do with Yellow
Carp firmware doing things differently than previous platforms.

Previously, if a Root Port implemented the HotPlugSupportInD3
property, we assumed that the Root Port and any downstream bridges
could handle hot-plug events while in D3hot.

I guess the difference here is that on Yellow Carp firmware, even if
there is a HotPlugSupportInD3 property on the Root Port, the Root Port
cannot handle hot-plug events in D3hot UNLESS there is also an _S0W
method AND that _S0W says the Root Port can wakeup from D3hot or
D3cold, right?

I have some heartburn about this that's only partly related to this
patch.  The Microsoft doc clearly says "HotPlugSupportInD3" must be
implemented on Root Ports and its presence tells us that the *Root
Port* can handle hot-plug events while in D3.

But acpi_pci_bridge_d3() looks up the Root Port at the top of the
hierarchy and assume that its "HotPlugSupportInD3" applies to any
switch ports that may be below that Root Port (added by 26ad34d510a8
("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") [1]).

That seems wrong to me.  How can the platform firmware know how
downstream switches behave?

I have the same question about this patch because it looks for _S0W on
the Root Port, even if acpi_pci_bridge_d3() was called for some switch
port below the root.

> Yellow carp isn't supported in the kernel until 5.14, so should this
> be backported it shouldn't need to go any further than 5.14.
> (Realistically though no distro should be on 5.14, they should have
> gone to the 5.15 LTS).  

The question of moving from v5.14 to v5.15 is outside the scope of
this patch.  I think we just have to mention Yellow Carp and the way
its firmware differs from previous practice, and distros can make
their own decisions.

[1] https://git.kernel.org/linus/26ad34d510a8
