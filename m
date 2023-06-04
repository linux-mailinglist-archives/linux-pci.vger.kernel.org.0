Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2AC721669
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jun 2023 13:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFDLk4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 4 Jun 2023 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDLkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 07:40:55 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B5CD;
        Sun,  4 Jun 2023 04:40:54 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-977c963041dso17390966b.1;
        Sun, 04 Jun 2023 04:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685878852; x=1688470852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hPyATbScLhd1Ux5VdZrCgqoxiG2kNtepUPYKFFp83Y=;
        b=RXI+yPYqQ4DXmXWtG9dgrm5U8dKy8HvsZfYSdJx/zqhGzZ8Nf4qdHQrKMe5fOm2dQG
         eWsqcoZ1FYep6Oy02gk3e9URgBt38sBh8V+OozrIE+fh1T8SK9IC93h8BpEZ7YvI4nWr
         X0FvXBMHY/hVH8oOSiR+/RyZbZuwLOK8m6M0DZ3WvT54mCsoOi8LulQ8Cj1qBk61Z4GK
         txpP2Hedis3Z5izz5H2rJOyd9aFHhZOk8+q9rYVkiQij8RVXKFeJFl7NVuPUvJQgeJ7v
         Rg3Q4TtedXX+uq3ZTi9o5WBK/D8B+pY6Tko95n1IZXUF2jgHuBicXIHBUTGcP84zHNkp
         vtkA==
X-Gm-Message-State: AC+VfDxHzNcGoUlFndWeK4SqWhiI2rrFpfjYxCweX0SbDrHbQRlhg0Il
        4v/PD9ZHpy2NsT587775GxqMsGtxnTmBRyenBDs=
X-Google-Smtp-Source: ACHHUZ7QnNU+FbrNuimuy8IFPogOJ6RW3cP4uqCSkGhdbhb+uXX6dm95eaOJikHCKcGztKS4gC50P06UbxLsKbexkWs=
X-Received: by 2002:a17:906:7496:b0:976:50a4:ac49 with SMTP id
 e22-20020a170906749600b0097650a4ac49mr4246569ejl.6.1685878852229; Sun, 04 Jun
 2023 04:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZHprL3oavxW+tUsX@bhelgaas> <af1bbb31-36d4-4924-e02a-bc22b938c7e4@amd.com>
In-Reply-To: <af1bbb31-36d4-4924-e02a-bc22b938c7e4@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 13:40:38 +0200
Message-ID: <CAJZ5v0hz2B3Y1HFE9Rvo4B+YHZR5CeoTSLhTc0GO9mZKrwykPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 3, 2023 at 12:38 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 6/2/2023 5:20 PM, Bjorn Helgaas wrote:
> > Hi Mario,
> >
> > The patch itself looks fine, but since I don't have all the power
> > management details in my head, it would help me a lot to make the
> > description more concrete.
> OK, please let me know if after reviewing my responses you
> would prefer me to take an attempt at rewriting the commit
> message or if you can handle changing it.
> >
> > On Tue, May 30, 2023 at 11:39:47AM -0500, Mario Limonciello wrote:
> >> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
> >> that xHCI device is connected to a USB-C port for an AMD USB4 router.
> > It sounds like the real issue is that "Root Ports in D3hot/D3cold may
> > not support wakeup", and the USB, xHCI, USB-C, AMD USB4 router bits
> > are probably not really relevant.  And hopefully even the "AMD
> > platforms" mentioned below is not relevant.
> Yeah.  It comes down to how much you want in the commit
> about how we got to this conclusion versus a generic
> fix.  I generally like to be verbose about a specific case
> something fixes so that when distros decide what to pull
> in to their older maintenance kernels they can understand
> what's important.
> >> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >> all PCIe ports go into D3 during s2idle.
> >>
> >> When specific root ports are put into D3 over s2idle on some AMD platforms
> >> it is not possible for the platform to properly identify wakeup sources.
> >> This happens whether the root port goes into D3hot or D3cold.
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

Why doesn't it work fine when the system is in s2idle then?

Getting to the root of this would be really helpful here IMO.

> >
> >> Comparing registers between Linux and Windows 11 this behavior to put
> >> these specific root ports into D3 at suspend is unique to Linux. On an
> >> affected system Windows does not put those specific root ports into D3
> >> over Modern Standby.
> >>
> >> Windows avoids putting Root Ports that are not power manageable (e.g do
> >> not have platform firmware support) into low power states.
> > The Windows behavior was probably useful to you in debugging, but I
> > don't really care about these Windows details because I don't think
> > they help us maintain this in the future.
> OK.
> >> Linux shouldn't assume root ports support D3 just because they're on a
> >> machine newer than 2015, the ports should also be deemed power manageable.
> >> Add an extra check explicitly for root ports to ensure D3 isn't selected
> >> for them if they are not power-manageable through platform firmware.
> > But I *would* like to know specifically what "power manageable" means
> > here.  I might naively assume that a device with the PCI Power
> > Management Capability is "power manageable", and that if PME_Support
> > includes D3hot and D3cold, we're good to go.  But obviously it's more
> > complicated than that, and I'd like to cite the spec that mentions the
> > actual things we need here.
> Power manageable through platform firmware means the device
> has ACPI methods like like _PR0, _PS0.
> >> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> >> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> >> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v4->v5:
> >>   * Add tags
> >>   * Fix title
> >>   * Adjust commit message
> >> v3->v4:
> >>   * Move after refactor
> >> ---
> >>   drivers/pci/pci.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index d1fa040bcea7..d293db963327 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >>      if (dmi_check_system(bridge_d3_blacklist))
> >>              return false;
> >>
> >> +    /*
> >> +     * It's not safe to put root ports that don't support power
> >> +     * management into D3.
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

I would rather write "unless then can be power-managed with the help
of the platform firmware".

The meaning of "signaling" is unclear in this context and even if it
was clear, the platform firmware support actually needs to be used
here, its mere existence is not sufficient AFAICS.
