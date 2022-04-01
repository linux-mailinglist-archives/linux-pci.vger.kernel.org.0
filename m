Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968084EEC6C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbiDALgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 07:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbiDALgw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 07:36:52 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBD1D66F6;
        Fri,  1 Apr 2022 04:35:02 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2e5e176e1b6so28793527b3.13;
        Fri, 01 Apr 2022 04:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vcpLdnxR+c+1IodUhMT7bozvTtnxFjdrTjmrW7ioa8=;
        b=ymhoIZQsDoCBsYv+BN4xO3LxZiq6CQAKHKwl8AZEhFYCmoHUccLKAKG+1NoX/BKL0A
         Lyptv/pBHwMPhwmF/aMd4P8D3MU0zEPYpiDB3P0SH3i2Ak2fX8J5+nxEJhO4R5RQ8bwk
         ScrriPF4IKOrFOmqJV82st704FZ3Hc9hZvgJ+RCJfJt8GdSi7lBzF/UWR4A409d+POCO
         eBedtqso2OJGeC+NAad5Rooz4lWyQ+NqCXW34tveimvlhhG7LYATOHShKvfSzYwmwz+J
         DGRMY50+saqRdwmHmepqoK/EVrHSpH+EEdb7DROJf6f5MlMlJzlij8lTddqzDxOiHZlN
         dfIA==
X-Gm-Message-State: AOAM533UVNbXOJllJZAl7y98eAZqadW1b2M0MbBPzPbuPONLrborQ0oc
        Qt28uP3If0c3ITXJ9dPttTUnW7+wZ+1GVVcWk1Q=
X-Google-Smtp-Source: ABdhPJzacR+RMoy0ORGG7NFwHFOcHeSB6CcA/ae/HowmGQBYxHBi8F7c1VKDCkwOLjaykLANKDkfCFEyb1cGKUAGXnw=
X-Received: by 2002:a81:5cf:0:b0:2e5:7477:168e with SMTP id
 198-20020a8105cf000000b002e57477168emr9592262ywf.149.1648812901273; Fri, 01
 Apr 2022 04:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <11980172.O9o76ZdvQC@kreacher> <20220331215716.GA27368@bhelgaas>
In-Reply-To: <20220331215716.GA27368@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Apr 2022 13:34:50 +0200
Message-ID: <CAJZ5v0hTBQ=eajovHixwMs+1YQVFV7=uAay1qdxh3uDs68HndQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Quirk bridge D3 on Elo i2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Stefan Gottwald <gottwald@igel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 31, 2022 at 11:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Rafael,
>
> On Thu, Mar 31, 2022 at 07:38:51PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If one of the PCIe root ports on Elo i2 is put into D3cold and then
> > back into D0, the downstream device becomes permanently inaccessible,
> > so add a bridge D3 DMI quirk for that system.
> >
> > This was exposed by commit 14858dcc3b35 ("PCI: Use
> > pci_update_current_state() in pci_enable_device_flags()"), but before
> > that commit the root port in question had never been put into D3cold
> > for real due to a mismatch between its power state retrieved from the
> > PCI_PM_CTRL register (which was accessible even though the platform
> > firmware indicated that the port was in D3cold) and the state of an
> > ACPI power resource involved in its power management.
>
> In the bug report you suspect a firmware issue.  Any idea what that
> might be?  It looks like a Gemini Lake Root Port, so I wouldn't think
> it would be a hardware issue.

The _ON method of the ACPI power resource associated with the root
port doesn't work correctly.

> Weird how things come in clumps.  Was just looking at Mario's patch,
> which also has to do with bridges and D3.
>
> Do we need a Fixes line?  E.g.,
>
>   Fixes: 14858dcc3b35 ("PCI: Use pci_update_current_state() in pci_enable_device_flags()")

Strictly speaking, it is not a fix for the above commit.

It is a workaround for a firmware issue uncovered by it which wasn't
visible, because power management was not used correctly on the
affected system because of another firmware problem addressed by
14858dcc3b35.  It wouldn't have worked anyway had it been attempted
AFAICS.

I was thinking about CCing this change to -stable instead.

> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215715
> > Reported-by: Stefan Gottwald <gottwald@igel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/pci/pci.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > Index: linux-pm/drivers/pci/pci.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci.c
> > +++ linux-pm/drivers/pci/pci.c
> > @@ -2920,6 +2920,16 @@ static const struct dmi_system_id bridge
> >                       DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> >                       DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
> >               },
> > +             /*
> > +              * Downstream device is not accessible after putting a root port
> > +              * into D3cold and back into D0 on Elo i2.
> > +              */
> > +             .ident = "Elo i2",
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
> > +                     DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
> > +             },
>
> Is this bridge_d3_blacklist[] similar to the PCI_DEV_FLAGS_NO_D3 bit?

Not really.  The former applies to the entire platform and not to an
individual device.

> Could they be folded together?  We have a lot of bits that seem
> similar but maybe not exactly the same (dev->bridge_d3,
> dev->no_d3cold, dev->d3cold_allowed, dev->runtime_d3cold,
> PCI_DEV_FLAGS_NO_D3, pci_bridge_d3_force, etc.)  Ugh.

Yes, I agree that this needs to be cleaned up.

> bridge_d3_blacklist[] itself was added by 85b0cae89d52 ("PCI:
> Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports"),
> which honestly looks kind of random, i.e., it doesn't seem to be
> working around a hardware or even a firmware defect.
>
> Apparently the X299 issue is that 00:1c.4 is connected to a
> Thunderbolt controller, and the BIOS keeps the Thunderbolt controller
> powered off unless something is attached to it?  At least, 00:1c.4
> leads to bus 05, and in the dmesg log attached to [1] shows no devices
> on bus 05.
>
> It also says the platform doesn't support PCIe native hotplug, which
> matches what Mika said about it using ACPI hotplug.  If a system is
> using ACPI hotplug, it seems like maybe *that* should prevent us from
> putting things in D3cold?  How can we know whether ACPI hotplug
> depends on a certain power state?

We have this check in pci_bridge_d3_possible():

if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
            return false;

but this only applies to the case when the particular bridge itself is
a hotplug one using ACPI hotplug.

If ACPI hotplug is used, it generally is unsafe to put PCIe ports into
D3cold, because in that case it is unclear what the platform
firmware's assumptions regarding control of the config space are.

However, I'm not sure how this is related to the patch at hand.
