Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26D70FCA2
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 19:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjEXR3V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 24 May 2023 13:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjEXR3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 13:29:20 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1ED93;
        Wed, 24 May 2023 10:29:18 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96f66fbd770so34915366b.1;
        Wed, 24 May 2023 10:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684949357; x=1687541357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyb/BR/z8u3ulReGvvxK6Q0tGW6dyhXAau/A1unrmWs=;
        b=hVQq4ZCvYb+27wRpNueRjG/O+V6fx6A/v4zsfyvLocyprT5vMzLN+Gxk47HVcgDzJ/
         Uz7orqWux45huwdloHrDt/csCkcvtLlOzgVqB1vMP0KtcLJuxzZ768FvxSkk9+AcrkVx
         lqyPDdL7taAoxnpPOPlX50z78rU5JxuGIzbLyTeaDgg6NtlG/HqneY8/9qlhnJb5f1cv
         magJJQgtbjjzXRbeO80hhaMCs3N9cF1Vh6wPv7GNMVbnkuj1N+QrVm+It5s5N/rwHk+j
         QX8oXrK4dfHSf6UE6ZQZYFdBHCIIP2ixWkUynLOarppxj6x56rMm9e5MJWKcAXKf1Z5W
         XvEw==
X-Gm-Message-State: AC+VfDymHAOfFBKFao3NuN3uhEvC0Soa2DZ8DWnyEjuIPnG/VggYBIfj
        qp4GgWqxPbwEf3PxMu2qIANd4rZasa5GIbZSYY2ebjjz
X-Google-Smtp-Source: ACHHUZ7YqrPutCJvrzN1P8ylXeBNhlIpe2oavSEzUDQT7bXKqG1xa+Q8A0BHKiN0Jo5gxjlCGtNpixDrC6t8HPqz+x8=
X-Received: by 2002:a17:906:729e:b0:96f:6590:cbdb with SMTP id
 b30-20020a170906729e00b0096f6590cbdbmr16630454ejl.6.1684949357047; Wed, 24
 May 2023 10:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230524152136.1033-1-mario.limonciello@amd.com>
 <20230524154454.GA28455@wunner.de> <MN0PR12MB6101E8F181DA892B0D6D7C1BE2419@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101E8F181DA892B0D6D7C1BE2419@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 19:29:05 +0200
Message-ID: <CAJZ5v0gv_7CVk4JoEvoxC6ZiRXF=HoHbXytmGKDs_x67GdRaWw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Don't assume root ports from > 2015 are power manageable
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Iain Lane <iain@orangesquash.org.uk>
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

On Wed, May 24, 2023 at 6:16 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: Lukas Wunner <lukas@wunner.de>
> > Sent: Wednesday, May 24, 2023 10:45 AM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>; Rafael J . Wysocki <rafael@kernel.org>;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; S-k, Shyam-sundar
> > <Shyam-sundar.S-k@amd.com>; Natikar, Basavaraj
> > <Basavaraj.Natikar@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; linux-pm@vger.kernel.org; Iain Lane
> > <iain@orangesquash.org.uk>
> > Subject: Re: [PATCH v3] PCI: Don't assume root ports from > 2015 are power
> > manageable
> >
> > On Wed, May 24, 2023 at 10:21:36AM -0500, Mario Limonciello wrote:
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2976,6 +2976,9 @@ bool pci_bridge_d3_possible(struct pci_dev
> > *bridge)
> > >
> > >     switch (pci_pcie_type(bridge)) {
> > >     case PCI_EXP_TYPE_ROOT_PORT:
> > > +           if (!platform_pci_power_manageable(bridge))
> > > +                   return false;
> > > +           fallthrough;
> > >     case PCI_EXP_TYPE_UPSTREAM:
> > >     case PCI_EXP_TYPE_DOWNSTREAM:
> > >             if (pci_bridge_d3_disable)
> >
> > This will exempt the Root Ports from pcie_port_pm=force.
> > Not sure if that's desirable.
>
> Right; It will only exempt root ports from pcie_port_pm=force
> if they aren't power manageable.
>
> If it's still desirable to let pcie_port_pm=force work on these
> I think it's worth refactoring the function otherwise it's going
> to be a nested if that matches the same variable as the
> switch.
>
> Something like this:
>
> bool pci_bridge_d3_possible(struct pci_dev *bridge)
> {
>         if (!pci_is_pcie(bridge))
>                 return false;
>
>         switch (pci_pcie_type(bridge)) {
>         case PCI_EXP_TYPE_ROOT_PORT:
>         case PCI_EXP_TYPE_UPSTREAM:
>         case PCI_EXP_TYPE_DOWNSTREAM:
>                 break;
>         default:
>                 return false;
>         }
>
>         if (pci_bridge_d3_disable)
>                 return false;
>
>         /*
>          * Hotplug ports handled by firmware in System Management Mode
>          * may not be put into D3 by the OS (Thunderbolt on non-Macs).
>          */
>         if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
>                 return false;
>
>         if (pci_bridge_d3_force)
>                 return true;
>
>         /* Even the oldest 2010 Thunderbolt controller supports D3. */
>         if (bridge->is_thunderbolt)
>                 return true;
>
>         /* Platform might know better if the bridge supports D3 */
>         if (platform_pci_bridge_d3(bridge))
>                 return true;
>
>         /*
>          * Hotplug ports handled natively by the OS were not validated
>          * by vendors for runtime D3 at least until 2018 because there
>          * was no OS support.
>          */
>         if (bridge->is_hotplug_bridge)
>                 return false;
>
>         if (dmi_check_system(bridge_d3_blacklist))
>                 return false;
>
>         /*
>          * It should be safe to put PCIe ports from 2015 or newer
>          * to D3.
>          */
>         if (dmi_get_bios_year() >= 2015)
>                 return true;
>
>         return false;
> }
>
> Then the check I'm proposing can injected anywhere after the force like this:
>
> if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
>     !platform_pci_power_manageable(bridge)))
>         return false;

Sounds reasonable.  I would even put it after the Thunderbolt check.
