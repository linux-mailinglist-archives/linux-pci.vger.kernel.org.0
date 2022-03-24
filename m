Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0584E68B2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbiCXSdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347538AbiCXSdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 14:33:40 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36604B0D34;
        Thu, 24 Mar 2022 11:32:08 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2e5827a76f4so60245597b3.6;
        Thu, 24 Mar 2022 11:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQqbs6kTpfRwGjko3DN/P6DCOtM/TIsNyfTND6KAXY8=;
        b=e7de5krULehcRREK1TVoqfPZuMLIycKAKGrjTWxo/vKBsDOxC5xVhAVeZG/uze0nFA
         bjk9W1DXx5st9JJ7VMZ7cbBL3n54kFQNP0BVk76UpN0c2l3ucsQV+D2nlfCBP4qajxBP
         cpa+et7NQgUpIN6Pnx77g2FBrzBLIBI1KGfBAaL7OrR9taz7qQLPc1Q6FbclnB0UXMS5
         OlGu8q6EDaCRq+DJOR9zt3Ef3IQewG4ZTl1O0w0s16VzxwfECOmhdnLMIhQhLtGxb2wJ
         BrpVykFeKxC5BYXyErQYBy6ccnrq98FUOFFMHYZfOtbDT9WWGqrIYzpBNtdT2jwTU9+P
         2a6w==
X-Gm-Message-State: AOAM532ymLSy1uZ0namjvSnaBER0PUnZV9BHnbLvwNF7Bo75j4XniUj5
        qyN67H/0kyOPEDBqw7wj9FQBXSPU6GCB3qhm1TQT4zvkqfs=
X-Google-Smtp-Source: ABdhPJxdvY/5aM1TrmIrMzyvhYCyyNiqbpo3hJNCceCWmO8Uea2zzPLg8DAetcVVZ7GP0VikXvprr/AI7FeWcGH8+5w=
X-Received: by 2002:a81:bc5:0:b0:2e6:dcfe:bfcb with SMTP id
 188-20020a810bc5000000b002e6dcfebfcbmr897492ywl.19.1648146727448; Thu, 24 Mar
 2022 11:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <BL1PR12MB51575C7E6979A60E2637CC82E2189@BL1PR12MB5157.namprd12.prod.outlook.com>
 <20220324163452.GA1449620@bhelgaas> <BL1PR12MB515720B6EE3EC337081FBFDDE2199@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515720B6EE3EC337081FBFDDE2199@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Mar 2022 19:31:56 +0100
Message-ID: <CAJZ5v0hVFkKXTJcrFqRR4FoK5v_k3zCacKPmurWm=sozt7GPiQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if device
 can wake from D3
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 6:15 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, March 24, 2022 11:35
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; open list:PCI SUBSYSTEM <linux-
> > pci@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>; Mehta, Sanju
> > <Sanju.Mehta@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; Mika
> > Westerberg <mika.westerberg@linux.intel.com>
> > Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
> > device can wake from D3
> >
> > [+cc Mika, "HotPlugSupportInD3" scope question below]
>
> FYI - Mika had approved some earlier versions of this, so I expect conceptual
> Alignment at least with the latest one.
>
> <snip>
>
> > > > Can we at least list some common scenarios?  E.g., it affects
> > > > kernels after commit X, or it affects machines with CPUs newer
> > > > than Y, or it affects a certain kind of tunneling, etc?  Distros
> > > > need this information so they can figure whether and how far to
> > > > backport things like this.
> > >
> > > It's going to affect any retail machine with the SOC we refer to in
> > > the kernel as "Yellow Carp".  This is one of the first non-Intel
> > > USB4 hosts and will be using the USB4 SW CM in the kernel.
> > >
> > > Without this change, effectively PCIe tunneling will not work when
> > > any downstream PCIe device is hotplugged.  In the right
> > > circumstances it might work if it's coldbooted (if the paths
> > > selected by the pre-boot firmware connection manager are identical
> > > to that selected by SW CM).
> >
> > Thanks a lot for this context!  As far as I can tell from grubbing
> > through the git history, there are no PCI, USB4, or Thunderbolt
> > changes related to Yellow Carp, so I assume this has to do with Yellow
> > Carp firmware doing things differently than previous platforms.
>
> There have been a variety of Thunderbolt/USB4 changes as a result of
> Yellow Carp development and findings, but they have not been quirks;
> they have been done as generic changes that still make sense for all
> USB4 devices.
>
> Sanju (on CC) has submitted a majority of these, so if you want to see
> a sense of what these are you can look for his commits in drivers/thunderbolt.
>
> >
> > Previously, if a Root Port implemented the HotPlugSupportInD3
> > property, we assumed that the Root Port and any downstream bridges
> > could handle hot-plug events while in D3hot.
> >
> > I guess the difference here is that on Yellow Carp firmware, even if
> > there is a HotPlugSupportInD3 property on the Root Port, the Root Port
> > cannot handle hot-plug events in D3hot UNLESS there is also an _S0W
> > method AND that _S0W says the Root Port can wakeup from D3hot or
> > D3cold, right?
>
> Yes, correct!
>
> >
> > I have some heartburn about this that's only partly related to this
> > patch.  The Microsoft doc clearly says "HotPlugSupportInD3" must be
> > implemented on Root Ports and its presence tells us that the *Root
> > Port* can handle hot-plug events while in D3.
> >
> > But acpi_pci_bridge_d3() looks up the Root Port at the top of the
> > hierarchy and assume that its "HotPlugSupportInD3" applies to any
> > switch ports that may be below that Root Port (added by 26ad34d510a8
> > ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") [1]).

Not really.

"HotPlugSupportInD3" applies to the root port only and the platform
firmware may not know about any ports below it.

However, the presence of "HotPlugSupportInD3" is used as an indicator
that the entire hierarchy is "D3cold-aware", so to speak.
Essentially, this boils down to the "Is the hardware modern enough?"
consideration and the answer is assumed to be "yes" if the property in
question is present for the root port.

But if "HotPlugSupportInD3" is not consistent with the other pieces of
information regarding the root port available from the firmware (_PRW
and _S0W in this particular case), the presence of it is questionable
in the first place, so IMO the approach here makes sense.
