Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26D735F46
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 23:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFSVhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFSVhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 17:37:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2918BE64;
        Mon, 19 Jun 2023 14:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A29E560EAB;
        Mon, 19 Jun 2023 21:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7CCC433C8;
        Mon, 19 Jun 2023 21:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687210639;
        bh=uBhmHL9sGeVHprDShlUwP6iM5RxyKgskvEbeJubZdck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LLZfnENqlBuWdWEIKr6/QJ+Yxjtxg5KXUFTvNaBZ6kdOXR0mi+d2UpG7zexKVmeN/
         2605ejSMtTH6drU6Y5vPSa6fMfvQq7E0zgSVYOl/d1znI3serTuSlJGbWzEdyinUhy
         c7IXoIqJFUgnMnBIZpJXXDLEMrJziuyUsdk82RQjZbyTM3XY8jnAWn77oNY0jV24tI
         ab/PKJkQ7vI96+DMg9u1VbnrOT7EnqzNzttz0Wx2Ey3qAmuiEvQmq6ONQ38GYpqGh3
         zrfoZtG1qQJswVfT+Z7OlqxDCiOmekqaKApotETNzbIJTcibf2MrAn462eMl9PFYPX
         oRwGfp/fitJ/w==
Date:   Mon, 19 Jun 2023 16:37:16 -0500
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
Message-ID: <20230619213716.GA23372@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20ac3359-cc0d-7725-fc75-d415bcd4c2fe@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 19, 2023 at 11:16:35AM -0500, Limonciello, Mario wrote:
> On 6/15/2023 10:01 PM, Kai-Heng Feng wrote:
> > On Fri, Jun 16, 2023 at 1:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Jun 15, 2023 at 03:04:20PM +0800, Kai-Heng Feng wrote:
> > > > When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> > > > enabled for that device. However, when the device is plugged preboot,
> > > > ASPM is enabled by default.
> > > > 
> > > > The disparity happens because BIOS doesn't have the ability to program
> > > > ASPM on hotplugged devices.
> > > > 
> > > > So enable ASPM by default for external connected PCIe devices so ASPM
> > > > settings are consitent between preboot and hotplugged.
> > > > 
> > > > On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
> > > > pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
> > > > pcieport 0000:07:04.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> > > > pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> > > > pcieport 0000:07:04.0:    [ 7] BadDLLP
> > > > 
> > > > The root cause is still unclear, but quite likely because the I225 on
> > > > the dock supports PTM, where ASPM timing is precalculated for the PTM.
> > > > 
> > > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217557
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >   drivers/pci/pcie/aspm.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index 66d7514ca111..613b0754c9bb 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
> > > >                /* Enable Everything */
> > > >                return ASPM_STATE_ALL;
> > > >        case POLICY_DEFAULT:
> > > > -             return link->aspm_default;
> > > > +             return dev_is_removable(&link->downstream->dev) ?
> > > > +                     link->aspm_capable :
> > > > +                     link->aspm_default;
> > >
> > > I'm a little hesitant because dev_is_removable() is a convenient
> > > test that covers the current issue, but it doesn't seem tightly
> > > connected from a PCIe architecture perspective.
> > > 
> > > I think the current model of compile-time ASPM policy selection:
> > > 
> > >    CONFIG_PCIEASPM_DEFAULT          /* BIOS default setting */
> > >    CONFIG_PCIEASPM_PERFORMANCE      /* disable L0s and L1 */
> > >    CONFIG_PCIEASPM_POWERSAVE        /* enable L0s and L1 */
> > >    CONFIG_PCIEASPM_POWER_SUPERSAVE  /* enable L1 substates */
> > > 
> > > is flawed.  As far as I know, there's no technical reason we
> > > have to select this at kernel build-time.  I suspect the
> > > original reason was risk avoidance, i.e., we were worried that
> > > we might expose hardware defects if we enabled ASPM states that
> > > BIOS hadn't already enabled.
> > > 
> > > How do we get out of that model?  We do have sysfs knobs that
> > > should cover all the functionality (set overall policy as above
> > > via /sys/module/pcie_aspm/parameters/policy; set device-level
> > > exceptions via /sys/bus/pci/devices/.../link/*_aspm).
> >
> > Agree. Build-time policy can be obsoleted by boot-time argument.
>
> I agree as well.

This isn't strictly relevant to the current problem, so let's put this
on the back burner for now.

> > > In my opinion, the cleanest solution would be to enable all ASPM
> > > functionality whenever possible and let users disable it if they
> > > need to for performance.  If there are device defects when
> > > something is enabled, deal with it via quirks, as we do for
> > > other PCI features.
> > > 
> > > That feels a little risky, but let's have a conversation about
> > > where we want to go in the long term.  It's good to avoid risk,
> > > but too much avoidance leads to its own complexity and an
> > > inability to change things.
> >
> > I think we should separate the situation into two cases:
> > - When BIOS/system firmware has the ability to program ASPM, honor
> > it.  This applies to most "internal" PCI devices.
> > - When BIOS/system can't program ASPM, enable ASPM for whatever
> > it's capable of. Most notable case is Intel VMD controller, and
> > this patch for devices connected through TBT.
> > 
> > Enabling all ASPM functionality regardless of what's being
> > pre-programmed by BIOS is way too risky.  Disabling ASPM to
> > workaround issues and defects are still quite common among
> > hardware manufacturers.

It sounds like you have actual experience with this :)  Do you have
any concrete examples that we can use as "known breakage"?

This feels like a real problem to me.  There are existing mechanisms
(ACPI_FADT_NO_ASPM and _OSC PCIe cap ownership) the platform can use
to prevent the OS from using ASPM.

If vendors assume that *in addition*, the OS will pay attention to
whatever ASPM configuration BIOS did, that's a major disconnect.  We
don't do anything like that for other PCI features, and I'm not aware
of any restriction like that being documented.

> I think the pragmatic way to approach it is to (essentially) apply
> the policy as BIOS defaults and allow overrides from that.

Do you mean that when enumerating a device (at boot-time or hot-add
time), we would read the current ASPM config but not change it?  And
users could use the sysfs knobs to enable/disable ASPM as desired?
That wouldn't solve the problem Kai-Heng is trying to solve.

Or that we leave ASPM alone during boot-time enumeration, but enable
ASPM when we enumerate hot-added devices?  It doesn't sound right that
a device would be configured differently if present at boot vs
hot-added.

Bjorn
