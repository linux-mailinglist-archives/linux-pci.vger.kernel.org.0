Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517373741A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFTS26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFTS25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 14:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A7C1717;
        Tue, 20 Jun 2023 11:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FB1661361;
        Tue, 20 Jun 2023 18:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32936C433C8;
        Tue, 20 Jun 2023 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687285733;
        bh=H/rq7SZDvG71JLbWFDr2WU3UgH4X4GJ/7+kcHnFx6Gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lc7sjKnpvayvN5gv39BysvD0hrG8waBAisqT3s+zXvYaHTrE1Faj3tNujp/wOXNU+
         KTTrUfJXD8EICKYTaCSExjHZvttD/913+dqM7LFK+0mUIITnls7O82q7vsKEZTF4W6
         JIViruwdQMvgKvktOpaNSGmIl972C2lQFgwr/ppIE6jfxRl8YgVY7fFZgIPMJ54tzs
         CQOz4N9G3CufCcj0UJ9UslJU3ZmkMyHIroA0uqDDLR0qYOBQyYC4kSmg9ENTM/5OOe
         NeJbgxz4rz3pjTVz5kg1WH08yLyExilw2fdEi07fdlkUt4PnX18oG5UjtGrp2zJvbO
         6k14tTZawN48w==
Date:   Tue, 20 Jun 2023 13:28:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Message-ID: <20230620182851.GA52252@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eea91b5c-a61c-9a66-f084-df7495ae2c0c@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 19, 2023 at 05:09:55PM -0500, Limonciello, Mario wrote:
> On 6/19/2023 4:37 PM, Bjorn Helgaas wrote:
> > On Mon, Jun 19, 2023 at 11:16:35AM -0500, Limonciello, Mario wrote:
> > > On 6/15/2023 10:01 PM, Kai-Heng Feng wrote:
> > > > On Fri, Jun 16, 2023 at 1:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Thu, Jun 15, 2023 at 03:04:20PM +0800, Kai-Heng Feng wrote:
> > > > > > When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> > > > > > enabled for that device. However, when the device is plugged preboot,
> > > > > > ASPM is enabled by default.
> > > > > > 
> > > > > > The disparity happens because BIOS doesn't have the ability to program
> > > > > > ASPM on hotplugged devices.
> > > > > > 
> > > > > > So enable ASPM by default for external connected PCIe devices so ASPM
> > > > > > settings are consitent between preboot and hotplugged.
> > > > > > 
> > > > > > On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
> > > > > > pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
> > > > > > pcieport 0000:07:04.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> > > > > > pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> > > > > > pcieport 0000:07:04.0:    [ 7] BadDLLP
> > > > > > 
> > > > > > The root cause is still unclear, but quite likely because the I225 on
> > > > > > the dock supports PTM, where ASPM timing is precalculated for the PTM.
> > > > > > 
> > > > > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217557
> > > > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > > ---
> > > > > >    drivers/pci/pcie/aspm.c | 4 +++-
> > > > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > > > index 66d7514ca111..613b0754c9bb 100644
> > > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > > @@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
> > > > > >                 /* Enable Everything */
> > > > > >                 return ASPM_STATE_ALL;
> > > > > >         case POLICY_DEFAULT:
> > > > > > -             return link->aspm_default;
> > > > > > +             return dev_is_removable(&link->downstream->dev) ?
> > > > > > +                     link->aspm_capable :
> > > > > > +                     link->aspm_default;
> > > > > I'm a little hesitant because dev_is_removable() is a convenient
> > > > > test that covers the current issue, but it doesn't seem tightly
> > > > > connected from a PCIe architecture perspective.
> > > > > 
> > > > > I think the current model of compile-time ASPM policy selection:
> > > > > 
> > > > >     CONFIG_PCIEASPM_DEFAULT          /* BIOS default setting */
> > > > >     CONFIG_PCIEASPM_PERFORMANCE      /* disable L0s and L1 */
> > > > >     CONFIG_PCIEASPM_POWERSAVE        /* enable L0s and L1 */
> > > > >     CONFIG_PCIEASPM_POWER_SUPERSAVE  /* enable L1 substates */
> > > > > 
> > > > > is flawed.  As far as I know, there's no technical reason we
> > > > > have to select this at kernel build-time.  I suspect the
> > > > > original reason was risk avoidance, i.e., we were worried that
> > > > > we might expose hardware defects if we enabled ASPM states that
> > > > > BIOS hadn't already enabled.
> > > > > 
> > > > > How do we get out of that model?  We do have sysfs knobs that
> > > > > should cover all the functionality (set overall policy as above
> > > > > via /sys/module/pcie_aspm/parameters/policy; set device-level
> > > > > exceptions via /sys/bus/pci/devices/.../link/*_aspm).
> > > > Agree. Build-time policy can be obsoleted by boot-time argument.
> > > I agree as well.
> > This isn't strictly relevant to the current problem, so let's put this
> > on the back burner for now.
> 
> I think it could fold into it if we end up treating the i225
> PCIe device as a quirk as mentioned below.
> 
> > > > > In my opinion, the cleanest solution would be to enable all ASPM
> > > > > functionality whenever possible and let users disable it if they
> > > > > need to for performance.  If there are device defects when
> > > > > something is enabled, deal with it via quirks, as we do for
> > > > > other PCI features.
> > > > > 
> > > > > That feels a little risky, but let's have a conversation about
> > > > > where we want to go in the long term.  It's good to avoid risk,
> > > > > but too much avoidance leads to its own complexity and an
> > > > > inability to change things.
> > > > I think we should separate the situation into two cases:
> > > > - When BIOS/system firmware has the ability to program ASPM, honor
> > > > it.  This applies to most "internal" PCI devices.
> > > > - When BIOS/system can't program ASPM, enable ASPM for whatever
> > > > it's capable of. Most notable case is Intel VMD controller, and
> > > > this patch for devices connected through TBT.
> > > > 
> > > > Enabling all ASPM functionality regardless of what's being
> > > > pre-programmed by BIOS is way too risky.  Disabling ASPM to
> > > > workaround issues and defects are still quite common among
> > > > hardware manufacturers.
> >
> > It sounds like you have actual experience with this :)  Do you have
> > any concrete examples that we can use as "known breakage"?
>
> A variety of Intel chipsets don't support lane width switching
> or speed switching.  When ASPM has been enabled on a dGPU,
> these features are utilized and breakage ensues.

Maybe this helps explain all the completely unmaintainable ASPM
garbage in amdgpu and radeon.

If these devices are broken, we need quirks for them.  We can't avoid
ASPM in general just because random devices break.

> There are various methods to try to mitigate the impact both in
> firmware and driver code.
> 
> > This feels like a real problem to me.  There are existing mechanisms
> > (ACPI_FADT_NO_ASPM and _OSC PCIe cap ownership) the platform can use
> > to prevent the OS from using ASPM.
> > 
> > If vendors assume that *in addition*, the OS will pay attention to
> > whatever ASPM configuration BIOS did, that's a major disconnect.  We
> > don't do anything like that for other PCI features, and I'm not aware
> > of any restriction like that being documented.
>
> With both of those policies in place, how did we get into
> the situation of having configuration options and knobs?

The kernel parameters and config options been there pretty much from
the beginning.  We didn't have the per-device sysfs knobs until very
recently.

> > > I think the pragmatic way to approach it is to (essentially) apply
> > > the policy as BIOS defaults and allow overrides from that.
> >
> > Do you mean that when enumerating a device (at boot-time or hot-add
> > time), we would read the current ASPM config but not change it?  And
> > users could use the sysfs knobs to enable/disable ASPM as desired?
>
> Yes.

Hot-added devices power up with ASPM disabled.  This policy would mean
the user has to explicitly enable it, which doesn't seem practical to
me.

> > That wouldn't solve the problem Kai-Heng is trying to solve.
>
> Alone it wouldn't; but if you treated the i225 PCIe device
> connected to the system as a "quirk" to apply ASPM policy
> from the parent device to this child device it could.

I want quirks for BROKEN devices.  Quirks for working hardware is a
maintenance nightmare.

Bjorn
