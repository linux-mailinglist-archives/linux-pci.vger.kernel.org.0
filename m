Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB07506F9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 13:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjGLLtp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 12 Jul 2023 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjGLLtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 07:49:15 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B02103;
        Wed, 12 Jul 2023 04:48:31 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-94ea38c90ccso191471966b.1;
        Wed, 12 Jul 2023 04:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162503; x=1691754503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoXCY3sAAcBrdVqEWi7uKArR+tI/RlCQx6kJCdISvsg=;
        b=PdG/0T7XNFox0hRyfG/idCR3WMjuf/RNKSjS1AEKAfymWTYt4MDySd5m9M5TexqS4f
         VI/HBBapuvG0R0eMt0+DB2oh2YjMHUtLCJPGPZErQbQ7C9wfLHR0ZxCayzbb6c0P84fn
         066XcCnF3T0UQ0x2P56/KCqjBxEJy7FeBculJT6j3ePEYVrELE/zyFmAiuEDU7g/U1qF
         NLr1/ghK9P3uFYvzowVNa8ARa8BEkfdrbNELX1ZsBbBleKIgTj91/SIhtI45QMmyobcS
         fcF0YvbcK7xVnksuiJEyoKxQzmYzTALPG4Gy+02B3PgrD4IC6ZdV+T7R22Zuurn0T5xU
         8r9w==
X-Gm-Message-State: ABy/qLaAUCWIBR4VFqUPSpIe4GimtVKEK6unTqp1nHPAgdnuE3yxwp5/
        dxn24CYczI8byU+ViaFz1JQLMbW4D9M37qptgEg=
X-Google-Smtp-Source: APBJJlHOQkU1ZmDQsnarqITjpg/7awZ+GZY2vErAj+o094OvmfF5lgPs4W86rGgS1a4K2aEJN7z0eJCyTB9ZiA5CcN0=
X-Received: by 2002:a17:906:7490:b0:993:d5e7:80f8 with SMTP id
 e16-20020a170906749000b00993d5e780f8mr14433741ejl.7.1689162502796; Wed, 12
 Jul 2023 04:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230711005325.1499-3-mario.limonciello@amd.com> <20230711221427.GA250962@bhelgaas>
In-Reply-To: <20230711221427.GA250962@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Jul 2023 13:48:11 +0200
Message-ID: <CAJZ5v0hmDVkUz8QbE3Jx0kLqDfB6hEuQjhd_u8Kjj2hyZYpZGA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 12:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Andy, Intel MID stuff]
>
> On Mon, Jul 10, 2023 at 07:53:25PM -0500, Mario Limonciello wrote:
> > Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > PCIe ports from modern machines (>2015) are allowed to be put into D3 by
> > storing a flag in the `struct pci_dev` structure.
>
> It looks like >= 2015 (not >2015).  I think "a flag" refers to
> "bridge_d3".
>
> > pci_power_manageable() uses this flag to indicate a PCIe port can enter D3.
> > pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
> > decide whether to try to put a device into its target state for a sleep
> > cycle via pci_prepare_to_sleep().
> >
> > For devices that support D3, the target state is selected by this policy:
> > 1. If platform_pci_power_manageable():
> >    Use platform_pci_choose_state()
> > 2. If the device is armed for wakeup:
> >    Select the deepest D-state that supports a PME.
> > 3. Else:
> >    Use D3hot.
> >
> > Devices are considered power manageable by the platform when they have
> > one or more objects described in the table in section 7.3 of the ACPI 6.4
> > specification.
>
> No point in citing an old version, so please cite ACPI r6.5, sec 7.3.
>
> The spec claims we only need one object from the table for a device to
> be "power-managed", but in reality, it looks like the only things that
> actually *control* power are _PRx (the _ON/_OFF methods of Power
> Resources) and _PSx (ironically only mentioned parenthically).
>
> This matches up well with acpi_pci_power_manageable(), which returns
> true if a device has either _PR0 or _PS0.
>
>   Per ACPI r6.5, sec 7.3, ACPI control of device power states uses
>   Power Resources (i.e., the _ON/_OFF methods of _PRx) or _PSx
>   methods.  Hence acpi_pci_power_manageable() checks for the presence
>   of _PR0 or _PS0.
>
> Tangent unrelated to *this* patch: I don't know how to think about the
> pci_use_mid_pm() in platform_pci_power_manageable() because I haven't
> seen a MID spec.  pci_use_mid_pm() isn't dependent on "dev", so we
> claim *all* PCI devices, even external ones, are power manageable by
> the platform, which doesn't seem right.

No, we don't.

This only means that PCI devices may be power manageable by the
platform and so the platform code should be invoked to check that.
AFAICS, intel_mid_pwr_get_lss_id(() will return an error for a device
without platform PM support.

> > At suspend Linux puts PCIe root ports that are not power manageable by
> > the platform into D3hot. Windows only puts PCIe root ports into D3 when
> > they are power manageable by the platform.
> >
> > The policy selected for Linux to put non-power manageable PCIe root ports
> > into D3hot at system suspend doesn't match anything in the PCIe or ACPI
> > specs.
> >
> > Linux shouldn't assume PCIe root ports support D3 just because
> > they're on a machine newer than 2015, the ports should also be considered
> > power manageable by the platform.
> >
> > Add an extra check for PCIe root ports to ensure D3 isn't selected for
> > them if they are not power-manageable through platform firmware.
> > This will avoid pci_pm_suspend_noirq() changing the power state
> > via pci_prepare_to_sleep().
> >
> > The check is focused on PCIe root ports because they are part of
> > the platform.  Other PCIe bridges may be connected externally and thus
> > cannot impose platform specific limitations.
> >
> > Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html [1]
> > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > Reported-by: Iain Lane <iain@orangesquash.org.uk>
> > Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > v6->v7:
> > * revert back to v5 code, rewrite commit message to specific examples
> >   and be more generic
> > ---
> >  drivers/pci/pci.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index f916fd76eba79..4be8c6f8f4ebe 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3041,6 +3041,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >       if (dmi_check_system(bridge_d3_blacklist))
> >               return false;
> >
> > +     /*
> > +      * It's not safe to put root ports that aren't power manageable
> > +      * by the platform into D3.
>
> Does this refer specifically to D3cold?
>
> I assume that if we were talking about D3hot, we wouldn't need to
> check for ACPI support because D3hot behavior should be fully covered
> by the PCIe spec.
>
> Let's be specific about D3hot vs D3cold whenever possible.

Amen.

However, even though by the PCIe spec it should be possible to program
PCIe ports without ACPI PM support into D3hot via PMCSR, I'm not
actually sure how that works in practice, especially as far as PCIe
Root Ports are concerned.

Hardware designs usually don't allow Root Ports to be power managed
individually, so I suppose that programming them into D3hot (or D1 or
D2 for that matter) could be treated by the Host Bridge as dropping
references to them or something similar and I can imagine that this
may not work on some platforms and so maybe it should be avoided in
general.

When there is ACPI PM support, though, it can at least be assumed that
the platform designer has taken Root Port D3hot into account.

> > +     if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
> > +         !platform_pci_power_manageable(bridge))
> > +             return false;
>
> If ACPI says a device is not power-manageable, i.e., ACPI doesn't know
> how to put it in D0, it makes sense to return "false" here so we don't
> try to put it in D3cold.
>
> But I don't understand the ROOT_PORT check.  We may have a Switch
> described via ACPI, and the ROOT_PORT check means we can return "true"
> (it's OK to use D3cold) even if the Switch Port is not power-manageable
> via ACPI.

My understanding is that it is related to the remark above: It is
generally unclear how Root Port power management without ACPI support
is supposed to work, so they are kind of a special case.

> >       /*
> >        * It should be safe to put PCIe ports from 2015 or newer
> >        * to D3.
> > --
> > 2.34.1
> >
