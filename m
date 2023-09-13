Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0C79E851
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjIMMu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbjIMMu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 08:50:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8BA19B4
        for <linux-pci@vger.kernel.org>; Wed, 13 Sep 2023 05:50:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFCCC433C7;
        Wed, 13 Sep 2023 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694609452;
        bh=sIzI8Xuh6rf2B3tNBsQctz4kjmXFn7MqGQfMZVdRVk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qAc3QjJMjeA1lPvPGdB/BLDJx6EFSbnbYsVoKMj6H0KQWq9mngyQJvcBH29IED403
         JtW9yspPPi/rCTlFRnS4O7QoJTAmCqKH7eaS2v4HQE8EYYMOMLzYJpriFhEnCkNTUa
         VVzyt6cO7mZJ8xsTV9zUSAyU4OEKqnYl1YepyiwgK8P/0tdWBdQC9jOLZyYJvlNqgl
         a6kjzr5hBVb3mJny6bdVVfPKpEm/Mw+WLnFSbcM0FCFwblI76CPRIPVdZAIdXEkUby
         +0FDToQuldKuPV36TixfKCb1GLX5RySp1CmzUf8LCVukHIH3mvUKflB8GIP5C7kYge
         SgkFBIZXetkVw==
Date:   Wed, 13 Sep 2023 07:50:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Message-ID: <20230913125050.GA428916@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p6TJm+KP2X2AtgjGoyA7KkJx8ZHNCkuEQ-2kxxgYVJpOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 11:54:05AM +0800, Kai-Heng Feng wrote:
> On Wed, Sep 13, 2023 at 6:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Sep 12, 2023 at 02:35:39PM -0700, Patel, Nirmal wrote:
> > > On 8/30/2023 9:55 AM, Bjorn Helgaas wrote:
> > > > On Tue, Aug 29, 2023 at 02:35:36PM -0700, Patel, Nirmal wrote:
> > > >> On 8/29/2023 11:00 AM, Bjorn Helgaas wrote:
> > > >>> On Tue, Aug 29, 2023 at 01:10:22AM -0400, Nirmal Patel wrote:
> > > >>>> Currently during Host boot up, VMD UEFI driver loads and configures
> > > >>>> all the VMD endpoints devices and devices behind VMD. Then during
> > > >>>> VMD rootport creation, VMD driver honors ACPI settings for Hotplug,
> > > >>>> AER, DPC, PM and enables these features based on BIOS settings.
> > > >>>>
> > > >>>> During the Guest boot up, ACPI settings along with VMD UEFI driver are
> > > >>>> not present in Guest BIOS which results in assigning default values to
> > > >>>> Hotplug, AER, DPC, etc. As a result hotplug is disabled on the VMD
> > > >>>> rootports in the Guest OS.
> > > >>>>
> > > >>>> VMD driver in Guest should be able to see the same settings as seen
> > > >>>> by Host VMD driver. Because of the missing implementation of VMD UEFI
> > > >>>> driver in Guest BIOS, the Hotplug is disabled on VMD rootport in
> > > >>>> Guest OS. Hot inserted drives don't show up and hot removed drives
> > > >>>> do not disappear even if VMD supports Hotplug in Guest. This
> > > >>>> behavior is observed in various combinations of guest OSes i.e. RHEL,
> > > >>>> SLES and hypervisors i.e. KVM and ESXI.
> > > >>>>
> > > >>>> This change will make the VMD Host and Guest Driver to keep the settings
> > > >>>> implemented by the UEFI VMD DXE driver and thus honoring the user
> > > >>>> selections for hotplug in the BIOS.
> > > >>> These settings are negotiated between the OS and the BIOS.  The guest
> > > >>> runs a different BIOS than the host, so why should the guest setting
> > > >>> be related to the host setting?
> > > >>>
> > > >>> I'm not a virtualization whiz, and I don't understand all of what's
> > > >>> going on here, so please correct me when I go wrong:
> > > >>>
> > > >>> IIUC you need to change the guest behavior.  The guest currently sees
> > > >>> vmd_bridge->native_pcie_hotplug as FALSE, and you need it to be TRUE?
> > > >> Correct.
> > > >>
> > > >>> Currently this is copied from the guest's
> > > >>> root_bridge->native_pcie_hotplug, so that must also be FALSE.
> > > >>>
> > > >>> I guess the guest sees a fabricated host bridge, which would start
> > > >>> with native_pcie_hotplug as TRUE (from pci_init_host_bridge()), and
> > > >>> then it must be set to FALSE because the guest _OSC didn't grant
> > > >>> ownership to the OS?  (The guest dmesg should show this, right?)
> > > >> This is my understanding too. I don't know much in detail about Guest
> > > >> expectation.
> > > >>
> > > >>> In the guest, vmd_enable_domain() allocates a host bridge via
> > > >>> pci_create_root_bus(), and that would again start with
> > > >>> native_pcie_hotplug as TRUE.  It's not an ACPI host bridge, so I don't
> > > >>> think we do _OSC negotiation for it.  After this patch removes the
> > > >>> copy from the fabricated host bridge, it would be left as TRUE.
> > > >> VMD was not dependent on _OSC settings and is not ACPI Host bridge. It
> > > >> became _OSC dependent after the patch 04b12ef163d1.
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/drivers/pci/controller/vmd.c?id=04b12ef163d10e348db664900ae7f611b83c7a0e
> > > >>
> > > >> This patch was added as a quick fix for AER flooding but it could
> > > >> have been avoided by using rate limit for AER.
> > > >>
> > > >> I don't know all the history of VMD driver but does it have to be
> > > >> dependent on root_bridge flags from _OSC? Is reverting 04b12ef163d1
> > > >> a better idea than not allowing just hotplug flags to be copied from
> > > >> root_bridge?
> > > > It seems like the question is who owns AER, hotplug, etc for devices
> > > > below VMD.  AER rate limiting sounds itself like a quick fix without
> > > > addressing the underlying problem.
> > > >
> > > >>> If this is on track, it seems like if we want the guest to own PCIe
> > > >>> hotplug, the guest BIOS _OSC for the fabricated host bridge should
> > > >>> grant ownership of it.
> > > >> I will try to check this option.
> > > > On second thought, this doesn't seem right to me.  An _OSC method
> > > > clearly applies to the hierarchy under that device, e.g., if we have a
> > > > PNP0A03 host bridge with _SEG 0000 and _CRS that includes [bus 00-ff],
> > > > its _OSC clearly applies to any devices in domain 0000, which in this
> > > > case would include the VMD bridge.
> > > >
> > > > But I don't think it should apply to the devices *below* the VMD
> > > > bridge.  Those are in a different domain, and if the platform wants to
> > > > manage AER, hotplug, etc., for those devices, it would have to know
> > > > some alternate config access method in order to read the AER and
> > > > hotplug registers.  I think that config access depends on the setup
> > > > done by the VMD driver, so the platform doesn't know that.
> > > >
> > > > By this argument, I would think the guest _OSC would apply to the VMD
> > > > device itself, but not to the children of the VMD, and the guest could
> > > > retain the default native control of all these services inside the VMD
> > > > domain.
> > > >
> > > > But prior to 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
> > > > features"), the guest *did* retain native control, so we would have to
> > > > resolve the issue solved by 04b12ef163d1 in some other way.
> > >
> > > Yes, _OSC settings should applied to devices on 0000 domain.
> >
> > To be careful here, I think a PNP0A03 _OSC applies to the devices in
> > the PNP0A03 hierarchy, which could be any domain, not just 0000.
> >
> > But I think we agree that devices behind a VMD bridge are in some
> > hierarchy separate from the PNP0A03 one because the PNP0A03 device
> > doesn't tell OSPM how to find things behind the VMD.
> >
> > > VMD creates its own domain to manage the child devices. So it is
> > > against the VMD design to force _OSC settings and overwrite VMD
> > > settings.
> > >
> > > The patch 04b12ef163d1 disables AER on VMD rootports by using BIOS system
> > > settings for AER, Hotplug, etc.
> > > The patch 04b12ef163d1 *assumes VMD is a bridge device* and copies
> > > and *imposes system settings* for AER, DPC, Hotplug, PM, etc on VMD.
> > > Borrowing and applying system settings on VMD rootports is
> > > not correct.
> >
> > Yes, agreed, and I think this suggests that we really should remove
> > 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
> > completely.
> >
> > > VMD is *type 0 PCI endpoint device* and all the PCI devices
> > > under VMD are *privately* owned by VMD not by the OS. Also VMD has
> > > its *own Hotplug settings* for its rootports and child devices in BIOS
> > > under VMD settings that are different from BIOS system settings.
> > > It is these settings that give VMD its own unique functionality.
> > >
> > > For the above reason, VMD driver should disable AER generation by
> > > devices it owns. There are two possible solutions.
> > >
> > > Possible options to fix: There are two possible solutions.
> > >
> > > Options 1: VMD driver disables AER by copying AER BIOS system settings
> > > which the patch 04b12ef163d1 does but do not change other settings
> > > including Hotplug. The proposed patch does that.
> >
> > This doesn't seem right because I don't think we should be applying
> > any _OSC settings to devices below VMD unless there's a PNP0A03 device
> > that describes the domain below VMD.
> >
> > > Option 2: Either disable AER by adding an extra BIOS settings under
> > > VMD settings or disable AER by Linux VMD driver by adding a boot
> > > parameter and remove the patch 04b12ef163d1.
> >
> > I think we should remove 04b12ef163d1 and figure out some other way
> > of handling devices below VMD.  Maybe you just hard-code those items
> > to be what you want.
> 
> The idea was that the same physical root ports were used by 0000
> domain and VMD domain, so it's reasonable to use the same PCIe
> services.

Hmm.  In some ways the VMD device acts as a Root Port, since it
originates a new hierarchy in a separate domain, but on the upstream
side, it's just a normal endpoint.

How does AER for the new hierarchy work?  A device below the VMD can
generate ERR_COR/ERR_NONFATAL/ERR_FATAL messages.  I guess I was
assuming those messages would terminate at the VMD, and the VMD could
generate an AER interrupt just like a Root Port.  But that can't be
right because I don't think VMD would have the Root Error Command
register needed to manage that interrupt.

But if VMD just passes those messages up to the Root Port, the source
of the messages (the Requester ID) won't make any sense because
they're in a hierarchy the Root Port doesn't know anything about.

> So what items should be hard-coded, assuming 04b12ef163d1 gets reverted?

> > > >>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > >>>> ---
> > > >>>> v3->v4: Rewrite the commit log.
> > > >>>> v2->v3: Update the commit log.
> > > >>>> v1->v2: Update the commit log.
> > > >>>> ---
> > > >>>>  drivers/pci/controller/vmd.c | 2 --
> > > >>>>  1 file changed, 2 deletions(-)
> > > >>>>
> > > >>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > >>>> index 769eedeb8802..52c2461b4761 100644
> > > >>>> --- a/drivers/pci/controller/vmd.c
> > > >>>> +++ b/drivers/pci/controller/vmd.c
> > > >>>> @@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
> > > >>>>  static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> > > >>>>                                         struct pci_host_bridge *vmd_bridge)
> > > >>>>  {
> > > >>>> -        vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> > > >>>> -        vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> > > >>>>          vmd_bridge->native_aer = root_bridge->native_aer;
> > > >>>>          vmd_bridge->native_pme = root_bridge->native_pme;
> > > >>>>          vmd_bridge->native_ltr = root_bridge->native_ltr;
> > > >>>> --
> > > >>>> 2.31.1
> > > >>>>
> > >
