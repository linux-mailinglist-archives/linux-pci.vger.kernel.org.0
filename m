Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916444F1789
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 16:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378135AbiDDOuS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378351AbiDDOt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 10:49:58 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A46269;
        Mon,  4 Apr 2022 07:46:26 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2eb9412f11dso6140727b3.4;
        Mon, 04 Apr 2022 07:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOVa50JjPloX6NNffrNOX4espVwKfbmV7XpVc9dmG0M=;
        b=hLkrAgq6G6yoBmuoQj1tn4j4N7InxAhK9Z484R0RhVcoRbiCKgY4eo99XUdQCln087
         D8Dnnpy1dWrbfMGaWXSdWUnRZuhZsCDkBL2apmyMYmzsRocBOw8OghWoaaJhbE3XoCrh
         CrmMT7Y9OAqPM93CjC8A7s9xwk9amyPan9LU11K+d9Deu+Ak1n23CRO+H2azcJbT44eu
         r8rNcynjuXq0MGDagb3nxZJtLARqe97U82U5zKRzeckJdCBEC75JKd4udYwA9yusGIDj
         8EswGVMuLdR8i35As0r34iS2Z3QDItKVpZs0nMvvaUu2DViTwNjzI6B1ZpHkYOAHTBjY
         5JvQ==
X-Gm-Message-State: AOAM533NkmJCXr2TALJXzyOuvsUkle9DnIjEXeSJp/eSOX3921qFMBU1
        nXtQ27SORqk1g5SSspQulAYuU10DwT2+esRf/ZFe8IWQ
X-Google-Smtp-Source: ABdhPJyg2Xbuwq68gGaJs02HIy037eWLmim0xjma1cNwXHy1U8CJmjV3G96JDCjri9ldcBDvTczX34wd4A7ES27cTSc=
X-Received: by 2002:a81:508b:0:b0:2e5:9904:8655 with SMTP id
 e133-20020a81508b000000b002e599048655mr281561ywb.196.1649083585226; Mon, 04
 Apr 2022 07:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <11980172.O9o76ZdvQC@kreacher> <20220331215716.GA27368@bhelgaas> <CAJZ5v0hTBQ=eajovHixwMs+1YQVFV7=uAay1qdxh3uDs68HndQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hTBQ=eajovHixwMs+1YQVFV7=uAay1qdxh3uDs68HndQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Apr 2022 16:46:14 +0200
Message-ID: <CAJZ5v0g9cg=nJ0yr5-a_phNnJLiU74KrfsULsAEsWBKeRr7HCQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Quirk bridge D3 on Elo i2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Stefan Gottwald <gottwald@igel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Apr 1, 2022 at 1:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 11:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > Hi Rafael,
> >
> > On Thu, Mar 31, 2022 at 07:38:51PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If one of the PCIe root ports on Elo i2 is put into D3cold and then
> > > back into D0, the downstream device becomes permanently inaccessible,
> > > so add a bridge D3 DMI quirk for that system.
> > >
> > > This was exposed by commit 14858dcc3b35 ("PCI: Use
> > > pci_update_current_state() in pci_enable_device_flags()"), but before
> > > that commit the root port in question had never been put into D3cold
> > > for real due to a mismatch between its power state retrieved from the
> > > PCI_PM_CTRL register (which was accessible even though the platform
> > > firmware indicated that the port was in D3cold) and the state of an
> > > ACPI power resource involved in its power management.
> >
> > In the bug report you suspect a firmware issue.  Any idea what that
> > might be?  It looks like a Gemini Lake Root Port, so I wouldn't think
> > it would be a hardware issue.
>
> The _ON method of the ACPI power resource associated with the root
> port doesn't work correctly.
>
> > Weird how things come in clumps.  Was just looking at Mario's patch,
> > which also has to do with bridges and D3.
> >
> > Do we need a Fixes line?  E.g.,
> >
> >   Fixes: 14858dcc3b35 ("PCI: Use pci_update_current_state() in pci_enable_device_flags()")
>
> Strictly speaking, it is not a fix for the above commit.
>
> It is a workaround for a firmware issue uncovered by it which wasn't
> visible, because power management was not used correctly on the
> affected system because of another firmware problem addressed by
> 14858dcc3b35.  It wouldn't have worked anyway had it been attempted
> AFAICS.
>
> I was thinking about CCing this change to -stable instead.
>
> > > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215715
> > > Reported-by: Stefan Gottwald <gottwald@igel.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/pci/pci.c |   10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > Index: linux-pm/drivers/pci/pci.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/pci/pci.c
> > > +++ linux-pm/drivers/pci/pci.c
> > > @@ -2920,6 +2920,16 @@ static const struct dmi_system_id bridge
> > >                       DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> > >                       DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
> > >               },
> > > +             /*
> > > +              * Downstream device is not accessible after putting a root port
> > > +              * into D3cold and back into D0 on Elo i2.
> > > +              */
> > > +             .ident = "Elo i2",
> > > +             .matches = {
> > > +                     DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
> > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
> > > +                     DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
> > > +             },
> >
> > Is this bridge_d3_blacklist[] similar to the PCI_DEV_FLAGS_NO_D3 bit?
>
> Not really.  The former applies to the entire platform and not to an
> individual device.
>
> > Could they be folded together?  We have a lot of bits that seem
> > similar but maybe not exactly the same (dev->bridge_d3,
> > dev->no_d3cold, dev->d3cold_allowed, dev->runtime_d3cold,
> > PCI_DEV_FLAGS_NO_D3, pci_bridge_d3_force, etc.)  Ugh.
>
> Yes, I agree that this needs to be cleaned up.
>
> > bridge_d3_blacklist[] itself was added by 85b0cae89d52 ("PCI:
> > Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports"),
> > which honestly looks kind of random, i.e., it doesn't seem to be
> > working around a hardware or even a firmware defect.
> >
> > Apparently the X299 issue is that 00:1c.4 is connected to a
> > Thunderbolt controller, and the BIOS keeps the Thunderbolt controller
> > powered off unless something is attached to it?  At least, 00:1c.4
> > leads to bus 05, and in the dmesg log attached to [1] shows no devices
> > on bus 05.
> >
> > It also says the platform doesn't support PCIe native hotplug, which
> > matches what Mika said about it using ACPI hotplug.  If a system is
> > using ACPI hotplug, it seems like maybe *that* should prevent us from
> > putting things in D3cold?  How can we know whether ACPI hotplug
> > depends on a certain power state?
>
> We have this check in pci_bridge_d3_possible():
>
> if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
>             return false;
>
> but this only applies to the case when the particular bridge itself is
> a hotplug one using ACPI hotplug.
>
> If ACPI hotplug is used, it generally is unsafe to put PCIe ports into
> D3cold, because in that case it is unclear what the platform
> firmware's assumptions regarding control of the config space are.
>
> However, I'm not sure how this is related to the patch at hand.

So I'm not sure how you want to proceed here.

The platform is quirky, so the quirk for it will need to be added this
way or another.  The $subject patch adds it using the existing
mechanism, which is the least intrusive way.

You seem to be thinking that the existing mechanism may not be
adequate, but I'm not sure for what reason and anyway I think that it
can be adjusted after adding the quirk.

Please let me know what you think.
