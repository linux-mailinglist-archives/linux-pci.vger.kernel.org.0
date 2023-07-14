Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0E775432C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 21:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjGNTSJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 14 Jul 2023 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjGNTSI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 15:18:08 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8182735B1;
        Fri, 14 Jul 2023 12:18:06 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-98273ae42d0so66948666b.0;
        Fri, 14 Jul 2023 12:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689362285; x=1691954285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCXsMqYR9s3PYFNU6diJhKk3oI06Lndg+rpXvM6sCxU=;
        b=LmDEH9I10xUggZklBU+MTSDXVnJBcQLU1/y67a2gk0J5wczF+Jn91CDemjACbe/piu
         BWPe5ymT/RWdbLdaS+Duv/gIAWTQfx7ff23TC/fth2+nfPASHFR6kjhVbaJB0oViLsU/
         /22Z87BRKK/NwbSCECSeOeWzBF4RlaLOmBzbSt/qPpUxpd/i9lYdx/Cb4XEtbQCiYadF
         BQb14ldD/R6gUuqyV25pIZP/RI+gucSXGRrID5gc9/s7XxCi5YuDQN1Osv9toV4RDq/T
         Gj9Imi16vBKEzwBx5VqUTcUhTOY1r3X/mF/X63w7b5Pbs4nYEkbzFf1LVY/YD7oa7Lxv
         2dKg==
X-Gm-Message-State: ABy/qLYNeGQfIJNzkgcvwilXMm70qu+e3Lx7pNbKWwJnY0ULJn8WSTNt
        KKmSTpTObCTbZkmQB3L4bfqqGZ2P0wS/Zzt+w5g7dNa8
X-Google-Smtp-Source: APBJJlFVCm/aKdLWObD0Z4IqX8VLM6YjQNvFOBuZmroCJeQzEghYt5BYZSc6eyZm+vtTvzIpO9EWFIySkBOxLmU37FA=
X-Received: by 2002:a17:906:220b:b0:993:d54b:3e4b with SMTP id
 s11-20020a170906220b00b00993d54b3e4bmr141681ejs.0.1689362284621; Fri, 14 Jul
 2023 12:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230711221427.GA250962@bhelgaas> <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com> <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
In-Reply-To: <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 21:17:53 +0200
Message-ID: <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On Wed, Jul 12, 2023 at 6:09 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 7/12/2023 07:13, Rafael J. Wysocki wrote:
> > On Wed, Jul 12, 2023 at 12:54 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 7/11/23 17:14, Bjorn Helgaas wrote:
> >>> [+cc Andy, Intel MID stuff]
> >>>
> >>> On Mon, Jul 10, 2023 at 07:53:25PM -0500, Mario Limonciello wrote:
> >>>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >>>> PCIe ports from modern machines (>2015) are allowed to be put into D3 by
> >>>> storing a flag in the `struct pci_dev` structure.
> >>>
> >>> It looks like >= 2015 (not >2015).  I think "a flag" refers to
> >>> "bridge_d3".
> >>
> >> Yeah.
> >>
> >>>
> >>>> pci_power_manageable() uses this flag to indicate a PCIe port can enter D3.
> >>>> pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
> >>>> decide whether to try to put a device into its target state for a sleep
> >>>> cycle via pci_prepare_to_sleep().
> >>>>
> >>>> For devices that support D3, the target state is selected by this policy:
> >>>> 1. If platform_pci_power_manageable():
> >>>>      Use platform_pci_choose_state()
> >>>> 2. If the device is armed for wakeup:
> >>>>      Select the deepest D-state that supports a PME.
> >>>> 3. Else:
> >>>>      Use D3hot.
> >>>>
> >>>> Devices are considered power manageable by the platform when they have
> >>>> one or more objects described in the table in section 7.3 of the ACPI 6.4
> >>>> specification.
> >>>
> >>> No point in citing an old version, so please cite ACPI r6.5, sec 7.3.
> >>>
> >>> The spec claims we only need one object from the table for a device to
> >>> be "power-managed", but in reality, it looks like the only things that
> >>> actually *control* power are _PRx (the _ON/_OFF methods of Power
> >>> Resources) and _PSx (ironically only mentioned parenthically).
> >>>
> >>
> >> Your point has me actually wondering if I've got this entirely wrong.
> >>
> >> Should we perhaps be looking specifically for the presence of _SxW to
> >> decide if a given PCIe port can go below D0?
> >
> > There are two things, _SxW and _SxD, and they shouldn't be confused.
> >
> > _SxW tells you what the deepest power state from which wakeup can be
> > signaled by the device (in the given Sx state of the system) is.
> >
> > _SxD tells you what the deepest power state supported by the device
> > (in the given Sx state of the system) is.
> >
> > And note that _SxW is applicable to the device itself, not the
> > subordinate devices, so I'm not sure how meaningful it is for ports.
> >
> > pci_target_state() uses both _SxW and _SxD to determine the deepest
> > state the device can go into and so long as it is used properly, it
> > shouldn't return a power state that is too deep, so I'm not really
> > sure why you want this special "should the bridge be allowed to go
> > into D3hot/cold" routine to double check this.
>
> Because pci_target_state only looks at _SxW and _SxD "if" the PCI device
> is power manageable by ACPI.  That's why this change is injecting that
> extra check in.

I see.  We seem to be getting to the bottom of the problem.

[cut]

> >
> > Generally speaking, pci_bridge_d3_possible() is there to prevent
> > bridges (and PCIe ports in particular) from being put into D3hot/cold
> > if there are reasons to believe that it may not work.
> > acpi_pci_bridge_d3() is part of that.
> >
> > Even if it returns 'true', the _SxD/_SxW check should still be applied
> > via pci_target_state() to determine whether or not the firmware allows
> > this particular bridge to go into D3hot/cold.  So arguably, the _SxW
> > check in acpi_pci_bridge_d3() should not be necessary and if it makes
> > any functional difference, there is a bug somewhere else.
>
> But only if it was power manageable would the _SxD/_SxW check be
> applied.  This issue is around the branch of pci_target_state() where
> it's not power manageable and so it uses PME or it falls back to D3hot.

Well, this looks like a spec interpretation difference.

We thought that _SxD/_SxW would only be relevant for devices with ACPI
PM support, but the firmware people seem to think that those objects
are also relevant for PCI devices that don't have ACPI PM support
(because those devices are still power-manageable via PMCSR).  If
Windows agrees with that viewpoint, we'll need to adjust, but not
through adding _SxW checks in random places.
