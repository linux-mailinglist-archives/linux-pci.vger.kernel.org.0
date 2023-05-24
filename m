Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C070F3F9
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjEXKTk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 24 May 2023 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjEXKSf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 06:18:35 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98973E6C;
        Wed, 24 May 2023 03:18:08 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-96f72e6925cso15689566b.1;
        Wed, 24 May 2023 03:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684923487; x=1687515487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIbASmk4FtEgWrqVYhKPUtwtIiST0CQZcy/ybdN1tZk=;
        b=Y6910eTfj9aEfs0Ls+yYeG2938rtzbqHLvbCJwGed9VjTHpm0pNPNWN3kAm0mwMc+b
         IBmm0W5sFUnavvcfTQ8yPsQ4Qpf39GpI++djl80kejHmV74Md+NFd1oBrDzKq4GISALx
         ntwsnDfVDzYKech88Yx9Q1g5o1hdvL7IMIrpLVeoBLTzCtOAhklRy7/s6HaTiItc8P+r
         qeIdFtRmhqjeAvASDvIf5XHa49ISrZXFxn97rjXEX0taMnjixEKNgxpiURZO9pSMPwVp
         VrjasSiQaHF05109BgO4J7nC8Q61tM1z67A29KjwvElQqCAJc2xRiU4oFKbK1NIxGPc6
         PXgg==
X-Gm-Message-State: AC+VfDzLP7xNa/wS7iPWOdP6QLIOFf5EKqnl8kuxAqadzsVJmbjbDThr
        l4rDkQ/TmwnuoRz+RUuGzF5J4Xn4EzpMDpEtMnQ=
X-Google-Smtp-Source: ACHHUZ6MfeW4Iz0iuqbb/1bCIMVmiJssD4zE344ftV+J1YfKEI/cSISP7O/SQjiOiT3Mf9B/3DqQuKn/DFk7ERvm5zc=
X-Received: by 2002:a17:906:77c5:b0:966:1f60:fd32 with SMTP id
 m5-20020a17090677c500b009661f60fd32mr1471924ejn.6.1684923486802; Wed, 24 May
 2023 03:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <ZG0jhvzAZnfscSeC@bhelgaas> <654d2a59-9836-cc6d-c521-6835d725284d@amd.com>
In-Reply-To: <654d2a59-9836-cc6d-c521-6835d725284d@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 12:17:53 +0200
Message-ID: <CAJZ5v0gTWJWR=cO+DXD15UW-CcCMaGRxxX11L8UWLm61w6gvbw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Don't assume root ports from > 2015 are power manageable
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 23, 2023 at 11:30 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 5/23/2023 3:35 PM, Bjorn Helgaas wrote:
> > [+cc Rafael, Lukas, linux-pm]
> >
> > On Wed, May 17, 2023 at 10:08:27AM -0500, Mario Limonciello wrote:
> >> Using an XHCI device to wakeup the system from s2idle fails when
> >> that XHCI device is connected to a USB-C port for an AMD USB4
> >> router.
> > Are XHCI, USB-C, and the AMD USB4 router just examples?
>
> They're very specific to this case.  If XHCI
> keyboard/mouse is connected to a type-C port that is
> not connected to AMD USB4 router this issue doesn't occur.
>
> > I assume the
> > same issue could happen with non-XHCI and non-AMD devices, too?
> Based on what's wrong with Linux and fixed by this patch,
> yes this *can* happen to any vendor that the root port doesn't
> support waking from for D3 but Linux uses it anyway.
> >
> > I assume the problem has something to do with PME_Support and some
> > device being put in a power state where it cannot generate or forward
> > PME messages?  I think the PCIe protocol details would be helpful
> > here.
>
> No; it's specific to an internal sequence in the SoC.
>
> If the problematic root port is in D3 during s0i3 this
> problematic sequence happens.  If the root port is in D0
> then it doesn't.
>
>  From discussion with others in AMD that's at least one
> reason why the firmware doesn't advertise any power management
> on this root port and why Linux shouldn't be using it.
>
> >> Comparing registers between Linux and Windows 11 this behavior to put root
> >> ports into D3 at suspend is unique to Linux.  On an affected system
> >> Windows does not put the root ports into D3 over Modern Standby.
> >>
> >> Windows doesn't put the root ports into D3 because root ports are not
> >> power manageable; they're missing _PRW and _S0W.
> > platform_pci_power_manageable() tests adev->flags.power_manageable,
> > which is set by acpi_bus_get_power_flags() when a device has _PS0 or
> > _PR0.
> >
> > So I don't know what's relevant out of _PRW, _S0W, _PS0, _PR0, but
> > this sentence doesn't seem to match the code.
>
> The firmware doesn't have _PS0 or _PR0 either for this root
> port.
>
> >> Linux shouldn't be assuming they support D3 just because they're newer
> >> than 2015, the ports should also be deemed power manageable.
> >> Add an extra check for this to ensure D3 isn't selected for such machines.
> > Is this talking about D3hot or D3cold or both?  If we can make this
> > explicit, it will help me out.  It's probably obvious to power
> > experts, but I'm not one.
> Both.
> >> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> >> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/pci/pci.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 5ede93222bc1..3fe27aef09e6 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -3010,6 +3010,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >>              if (dmi_check_system(bridge_d3_blacklist))
> >>                      return false;
> >>
> >> +            if (!platform_pci_power_manageable(bridge))
> >> +                    return false;
> >> +

This goes too far, because it causes all ports, not just root ports.

If the intention is to address a problem with a root port, then the
change in behavior should be limited to root ports.

And yes, you can argue that for root ports, specifically, power
management without firmware support is rather pointless if not
harmful.

> >>              /*
> >>               * It should be safe to put PCIe ports from 2015 or newer
> >>               * to D3.
> >> --
> >> 2.34.1
> Something that this patch makes me wonder is if the original
> heuristic was actually correct.

Do you mean the cutoff date?

> Did the PCIe ports from "older" machine have everything needed
> to let them go to D3?
>
> Or would this change also let the heuristic be dropped?

For root ports - probably.  In general - not at all.
