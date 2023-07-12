Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7D7507D9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjGLMNb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 12 Jul 2023 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjGLMNZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 08:13:25 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072BC1BD5;
        Wed, 12 Jul 2023 05:13:19 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b6993ef4f2so20056161fa.0;
        Wed, 12 Jul 2023 05:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689163997; x=1689768797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS3qaHVvAwTVCS9m57CY6+emzHWGCJiS7xz2pEoXsZc=;
        b=WTOBEnmL5nlnU2WNBSTT+6rKB3OY3mMCcEzec1MIrEb48KKYIvZ40Yxc7MhnN2t4St
         JoZnOVmh2WY4CHU4eya8qceXraYzzUV+neBnfk2eegHPkRW/dzFIKxMEaIfKkYvo6NJ/
         Sd3FAkTPgUHLHeKTpijg1ilReJdYLMRf7PHVLbcEIZq56nkyXHUCBGJRCsWk1qo1ZB09
         TnLj+sPtZzYC82RRnzrp6T2jV/kKJDqMOjWOGB56uBbR7IcZq3b1YZX6xj7d42NLSzez
         vRp727TMmu3v+XD0gKXjPtoN815shDqi6t0JcExexfETc1HsTAHX7SGxcZZ/LTqMM3Gq
         OeiA==
X-Gm-Message-State: ABy/qLZyCk5SI12tzDk/4dVaaLAOuUCnwNFUWaMSdIV8WLPx59iYKSPy
        8Vlvvc6qrs3JMctny0dEl1Rzo9t59GrB/NFDUck=
X-Google-Smtp-Source: APBJJlG75qrYQ0PqgwdvdOeXmYDgJ9dV0/aomxHz8Iu/tnxy/JRRRiOJpa+/1evrBTmSFB7ChQBsXmIa7kXCBmRw7Xw=
X-Received: by 2002:a2e:bc07:0:b0:2b7:40e4:8e2f with SMTP id
 b7-20020a2ebc07000000b002b740e48e2fmr113227ljf.1.1689163996866; Wed, 12 Jul
 2023 05:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230711221427.GA250962@bhelgaas> <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
In-Reply-To: <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Jul 2023 14:13:05 +0200
Message-ID: <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 12:54 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/11/23 17:14, Bjorn Helgaas wrote:
> > [+cc Andy, Intel MID stuff]
> >
> > On Mon, Jul 10, 2023 at 07:53:25PM -0500, Mario Limonciello wrote:
> >> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >> PCIe ports from modern machines (>2015) are allowed to be put into D3 by
> >> storing a flag in the `struct pci_dev` structure.
> >
> > It looks like >= 2015 (not >2015).  I think "a flag" refers to
> > "bridge_d3".
>
> Yeah.
>
> >
> >> pci_power_manageable() uses this flag to indicate a PCIe port can enter D3.
> >> pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
> >> decide whether to try to put a device into its target state for a sleep
> >> cycle via pci_prepare_to_sleep().
> >>
> >> For devices that support D3, the target state is selected by this policy:
> >> 1. If platform_pci_power_manageable():
> >>     Use platform_pci_choose_state()
> >> 2. If the device is armed for wakeup:
> >>     Select the deepest D-state that supports a PME.
> >> 3. Else:
> >>     Use D3hot.
> >>
> >> Devices are considered power manageable by the platform when they have
> >> one or more objects described in the table in section 7.3 of the ACPI 6.4
> >> specification.
> >
> > No point in citing an old version, so please cite ACPI r6.5, sec 7.3.
> >
> > The spec claims we only need one object from the table for a device to
> > be "power-managed", but in reality, it looks like the only things that
> > actually *control* power are _PRx (the _ON/_OFF methods of Power
> > Resources) and _PSx (ironically only mentioned parenthically).
> >
>
> Your point has me actually wondering if I've got this entirely wrong.
>
> Should we perhaps be looking specifically for the presence of _SxW to
> decide if a given PCIe port can go below D0?

There are two things, _SxW and _SxD, and they shouldn't be confused.

_SxW tells you what the deepest power state from which wakeup can be
signaled by the device (in the given Sx state of the system) is.

_SxD tells you what the deepest power state supported by the device
(in the given Sx state of the system) is.

And note that _SxW is applicable to the device itself, not the
subordinate devices, so I'm not sure how meaningful it is for ports.

pci_target_state() uses both _SxW and _SxD to determine the deepest
state the device can go into and so long as it is used properly, it
shouldn't return a power state that is too deep, so I'm not really
sure why you want this special "should the bridge be allowed to go
into D3hot/cold" routine to double check this.

> IE very similar to what 8133844a8f24 did but for ports that are not
> hotplug bridges.
>
> > This matches up well with acpi_pci_power_manageable(), which returns
> > true if a device has either _PR0 or _PS0.
> >
> >    Per ACPI r6.5, sec 7.3, ACPI control of device power states uses
> >    Power Resources (i.e., the _ON/_OFF methods of _PRx) or _PSx
> >    methods.  Hence acpi_pci_power_manageable() checks for the presence
> >    of _PR0 or _PS0.
> >
> > Tangent unrelated to *this* patch: I don't know how to think about the
> > pci_use_mid_pm() in platform_pci_power_manageable() because I haven't
> > seen a MID spec.  pci_use_mid_pm() isn't dependent on "dev", so we
> > claim *all* PCI devices, even external ones, are power manageable by
> > the platform, which doesn't seem right.
> >
> >> At suspend Linux puts PCIe root ports that are not power manageable by
> >> the platform into D3hot. Windows only puts PCIe root ports into D3 when
> >> they are power manageable by the platform.
> >>
> >> The policy selected for Linux to put non-power manageable PCIe root ports
> >> into D3hot at system suspend doesn't match anything in the PCIe or ACPI
> >> specs.
> >>
> >> Linux shouldn't assume PCIe root ports support D3 just because
> >> they're on a machine newer than 2015, the ports should also be considered
> >> power manageable by the platform.
> >>
> >> Add an extra check for PCIe root ports to ensure D3 isn't selected for
> >> them if they are not power-manageable through platform firmware.
> >> This will avoid pci_pm_suspend_noirq() changing the power state
> >> via pci_prepare_to_sleep().
> >>
> >> The check is focused on PCIe root ports because they are part of
> >> the platform.  Other PCIe bridges may be connected externally and thus
> >> cannot impose platform specific limitations.
> >>
> >> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html [1]
>
> At least for myself when I respin this, here is the 6.5 link.
> https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects
>
> >> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> >> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> >> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v6->v7:
> >> * revert back to v5 code, rewrite commit message to specific examples
> >>    and be more generic
> >> ---
> >>   drivers/pci/pci.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index f916fd76eba79..4be8c6f8f4ebe 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -3041,6 +3041,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >>      if (dmi_check_system(bridge_d3_blacklist))
> >>              return false;
> >>
> >> +    /*
> >> +     * It's not safe to put root ports that aren't power manageable
> >> +     * by the platform into D3.
> >
> > Does this refer specifically to D3cold?
> >
>
> No, it's intentionally not saying D3hot or D3cold because it's stored to
> "bridge_d3" which is used for both D3hot and D3cold.
>
> > I assume that if we were talking about D3hot, we wouldn't need to
> > check for ACPI support because D3hot behavior should be fully covered
> > by the PCIe spec.
>
> Right; the PCIe spec indicates that D3hot should be supported by all
> devices and has rules about when you can go into D3hot like not allowing
> it unless child devices are already in D3.
>
> Naïvely you would think that means pci_bridge_d3_possible() shouldn't
> have any of these checks, but they've all obviously all been grown for a
> reason.
>
> The value from pci_bridge_d3_possible() is used both "at suspend" and
> "runtime", but what we're really talking with this issue is is the
> behavior "at suspend".

Which is suspend-to-idle AFAICS, so from the ACPI perspective it is
all S0 anyway.

> >
> > Let's be specific about D3hot vs D3cold whenever possible.
> >
> >> +    if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
> >> +        !platform_pci_power_manageable(bridge))
> >> +            return false;
> >
> > If ACPI says a device is not power-manageable, i.e., ACPI doesn't know
> > how to put it in D0, it makes sense to return "false" here so we don't
> > try to put it in D3cold.
> >
> > But I don't understand the ROOT_PORT check.  We may have a Switch
> > described via ACPI, and the ROOT_PORT check means we can return "true"
> > (it's OK to use D3cold) even if the Switch Port is not power-manageable
> > via ACPI.
>
> This feels a lot more of a potential to cause regressions.
>
> Something we could do is include the value for bridge->untrusted in the
> decision, but I'm not convinced that's correct.
>
> Another option can be to merge a series of changes like this:
>
> 1) My v5 patch that adds the quirks for the two known broken machines
> 2) Patch 1/2 from v7
> 3) Patch 2/2 from v7
> 4) Another patch to drop the root port check here
>
> #1 could go to 6.5-rcX as it's riskless.  #2-4 could go to linux-next
> and if they work out not to cause any problems we could revert #1.
>
> If they cause problems we come back to the drawing table to find the
> right balance.

Generally speaking, pci_bridge_d3_possible() is there to prevent
bridges (and PCIe ports in particular) from being put into D3hot/cold
if there are reasons to believe that it may not work.
acpi_pci_bridge_d3() is part of that.

Even if it returns 'true', the _SxD/_SxW check should still be applied
via pci_target_state() to determine whether or not the firmware allows
this particular bridge to go into D3hot/cold.  So arguably, the _SxW
check in acpi_pci_bridge_d3() should not be necessary and if it makes
any functional difference, there is a bug somewhere else.
