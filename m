Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD88281506
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBOY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 10:24:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40843 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbgJBOYz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 10:24:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id m128so1379394oig.7;
        Fri, 02 Oct 2020 07:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oXpa3kicEZpKqydffMP2F2DCvS5CBlfjCKM89ZyVOM=;
        b=PwHn+UOL0hJ6nqHvwhYZPC9SnMPG7JhzJ0G4oJxQsBAbj7njVHGWLGGDG1mQu6rd09
         ZAjpy9s62WjJqRw94BrkO4vIuTStyqqHvkOK4x0EUkIcufrCy94pppwkh0lMW0BFyjNX
         hMi5hJS0UN9loS8abSOZk+nLXAJfjO8W2AwdweuxLWfiZRwOKsMbkiH66AC/5XbjTNkW
         MrBDsqIbErDg7SHgc0LS8mpzbRGQFF8FoL01wnF0AEMc+qfRp+Ji1sc23BifR14fP8ww
         RG7IfKuaynuZafOw+uy9g7LE8xuarjgu2JAY7kponx1U9o4YIRMpuQivcLX5sx/1vkVJ
         Y6Og==
X-Gm-Message-State: AOAM531rrNkS90fIXOkfvVz7tvTa68yGKAjCPVM/3GKqu7wVQwfkUEdP
        RTpgIPEr/LOF3+nUWiyuRrphy+a6kHmr77cyVik=
X-Google-Smtp-Source: ABdhPJxz7C7wkVk/Uve1kV8PtdOMbPoxoqT/bJyjWJ9DUI+FeAsIM20zb3yKwQjjZOC4EfyoZPEh6IfVfmeof2SW0AI=
X-Received: by 2002:aca:df84:: with SMTP id w126mr1454599oig.103.1601648694157;
 Fri, 02 Oct 2020 07:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
 <CAJZ5v0h5dHp6C8rx-B-hS=6hJOvTHuY1K4590qkNzCAkoivK4g@mail.gmail.com> <MN2PR12MB44888EB0D4D9B3B1D43698B6F7310@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44888EB0D4D9B3B1D43698B6F7310@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 16:24:41 +0200
Message-ID: <CAJZ5v0itTBOvjMJVrWJwgC2xdEVHKb-=fWC5SidT_X5Lxpmb_g@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power managed
 by ACPI
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Aaron Zakhrov <aaron.zakhrov@gmail.com>,
        Michal Rostecki <mrostecki@suse.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shai Coleman <git@shaicoleman.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arthur Borsboom <arthurborsboom@gmail.com>,
        matoro <matoro@airmail.cc>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 2, 2020 at 4:20 PM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [AMD Public Use]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Rafael J. Wysocki
> > Sent: Friday, October 2, 2020 10:17 AM
> > To: Lukas Wunner <lukas@wunner.de>
> > Cc: Aaron Zakhrov <aaron.zakhrov@gmail.com>; Michal Rostecki
> > <mrostecki@suse.com>; Linux PCI <linux-pci@vger.kernel.org>; Rafael J.
> > Wysocki <rjw@rjwysocki.net>; amd-gfx list <amd-
> > gfx@lists.freedesktop.org>; ACPI Devel Maling List <linux-
> > acpi@vger.kernel.org>; Shai Coleman <git@shaicoleman.com>; Bjorn
> > Helgaas <helgaas@kernel.org>; Arthur Borsboom
> > <arthurborsboom@gmail.com>; matoro <matoro@airmail.cc>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>; Len Brown <lenb@kernel.org>
> > Subject: Re: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power
> > managed by ACPI
> >
> > On Fri, Oct 2, 2020 at 7:17 AM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > Recent laptops with dual AMD GPUs fail to suspend the discrete GPU,
> > > thus causing lockups on system sleep and high power consumption at
> > runtime.
> > > The discrete GPU would normally be suspended to D3cold by turning off
> > > ACPI _PR3 Power Resources of the Root Port above the GPU.
> > >
> > > However on affected systems, the Root Port is hotplug-capable and
> > > pci_bridge_d3_possible() only allows hotplug ports to go to D3 if they
> > > belong to a Thunderbolt device or if the Root Port possesses a
> > > "HotPlugSupportInD3" ACPI property.  Neither is the case on affected
> > > laptops.  The reason for whitelisting only specific, known to work
> > > hotplug ports for D3 is that there have been reports of SkyLake
> > > Xeon-SP systems raising Hardware Error NMIs upon suspending their
> > hotplug ports:
> > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Flinux-pci%2F20170503180426.GA4058%40otc-nc-
> > 03%2F&amp;dat
> > >
> > a=02%7C01%7Calexander.deucher%40amd.com%7C99ec20b6d4dc410baf800
> > 8d866dd
> > >
> > e688%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6373724505855
> > 84491&a
> > >
> > mp;sdata=EPFyxPA0MDBuAkvH7bbp2wHYnpos8p%2BoZmzlUvvdAek%3D&a
> > mp;reserved
> > > =0
> > >
> > > But if a hotplug port is power manageable by ACPI (as can be detected
> > > through presence of Power Resources and corresponding _PS0 and _PS3
> > > methods) then it ought to be safe to suspend it to D3.  To this end,
> > > amend acpi_pci_bridge_d3() to whitelist such ports for D3.
> > >
> > > Link:
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> > > ab.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F1222&amp;data=02%7C01%7C
> > >
> > alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> > 7C3dd89
> > >
> > 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> > ata=cMj
> > >
> > LDIbjp8RQiWX8pgK2bDUH%2B0u3oquy3TqeT9QjZGE%3D&amp;reserved=0
> > > Link:
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> > > ab.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F1252&amp;data=02%7C01%7C
> > >
> > alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> > 7C3dd89
> > >
> > 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> > ata=iP9
> > >
> > EqNcM15Dj4Ax%2BE6e2HaMWHEX%2B0IO3cMoi0NXWGzM%3D&amp;reser
> > ved=0
> > > Link:
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> > > ab.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F1304&amp;data=02%7C01%7C
> > >
> > alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> > 7C3dd89
> > >
> > 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> > ata=VlT
> > > UV2UCH4RvKgTXZcpGOpkjZpfijmPgwtvKx6HRT04%3D&amp;reserved=0
> > > Reported-and-tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > Reported-and-tested-by: matoro <matoro@airmail.cc>
> > > Reported-by: Aaron Zakhrov <aaron.zakhrov@gmail.com>
> > > Reported-by: Michal Rostecki <mrostecki@suse.com>
> > > Reported-by: Shai Coleman <git@shaicoleman.com>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: stable@vger.kernel.org
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/pci/pci-acpi.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> > > d5869a0..d9aa551 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -944,6 +944,16 @@ static bool acpi_pci_bridge_d3(struct pci_dev
> > *dev)
> > >         if (!dev->is_hotplug_bridge)
> > >                 return false;
> > >
> > > +       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> > > +       adev = ACPI_COMPANION(&dev->dev);
> > > +       if (!adev && !pci_dev_is_added(dev)) {
> > > +               adev = acpi_pci_find_companion(&dev->dev);
> > > +               ACPI_COMPANION_SET(&dev->dev, adev);
> > > +       }
> > > +
> > > +       if (adev && acpi_device_power_manageable(adev))
> > > +               return true;
> > > +
> > >         /*
> > >          * Look for a special _DSD property for the root port and if it
> > >          * is set we know the hierarchy behind it supports D3 just fine.
> > > --
> >
> > I'm going to apply this patch for 5.10 unless Bjorn would rather route it
> > through the PCI tree.
>
> Any chance we can get this into stable at some point as well?  It would be nice to fix the laptops out there in the wild running older kernels.

I can mark it for stable, but I'm not sure which releases it should go back to.

Thanks!
