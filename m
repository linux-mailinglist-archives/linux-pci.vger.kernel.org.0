Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7547B6F7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 02:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhLUBxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 20:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLUBxP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 20:53:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E578C061574
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 17:53:15 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso958848pjc.4
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 17:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKifyk4mnM2Yqu+DHF9A4ZQKh8AD3UzsDcB1i167Eiw=;
        b=MaB1um+dYv2t6mjXCrJsFKlTMZbqdh/9n62tnx8pJE+h24nBSFYAs9RdvxUsrmE63/
         GiRfYfME5IXTH79JPNx/yE6A3KmFIE3wIbS/9gjJmm5Wh/Lma/B1iHLRC2c8/vb+iNuU
         KToY0L0svEZG3BTFCF/Ug68BwgzvyuYFdb9odRsESXJ7VVLQfJPAUxKCT28UtESBlqsO
         niz5Tb2iNCiNZ84x/v+NmgFolirSgBL4hMiNerKgTlD9Yblk7ohIXbxSKGBamZtJaWon
         YNoXFp58iaauv1VTbNaQmO90D1axttElWNWGunncNWQY5z6Hfz7z/fNr5Bdcfkzbskfd
         J7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKifyk4mnM2Yqu+DHF9A4ZQKh8AD3UzsDcB1i167Eiw=;
        b=ctq17dI23rHsBt+uSzTcBh3hfk/ABciWqghpnXVivAS3lH0BTN82JLo1eehO2ZjyiO
         Op5K3wvOZlnOgo+CDn/+VMijJ7YrsoKSG4+nueUqKfS6tFS8folGpe82Z6otocIums5/
         CE55GqHio+Yk1TRMm0nSo0afgFFhoRTa7/U1VuJVk8Lne3IZpBDDfDq0DPsI9FW4P0YV
         Bd/HVbpCWJByB6TFB6Z1vDHhg5xERBZNNaHpAswdhO+8HFOApmGJm8pz8FmtvY4U+FKQ
         AftodAzPkrsDOTHDnqsCFuGQjb+tF5Pb8+htz5ldnp2+cAvhEbJuiDdseBUl/nkrrR4I
         /Xkg==
X-Gm-Message-State: AOAM530X3mHgSGERTZzEYIvNeli1qr4v9juIa5Yqn39eikOfg+LKnTRz
        XM1Zs0jH2pKWpmAM2U1pnHpCyOte3HR3r5rMjxlbyA==
X-Google-Smtp-Source: ABdhPJw1wGlebTO1Y/iJTrz3X12wTkdt7cSjE7BAWPIRZYlry0j+kWAUq5yqBlrqlRC3HhBqvTsqcFirQF44KF2itFs=
X-Received: by 2002:a17:90a:d498:: with SMTP id s24mr1313595pju.46.1640051594509;
 Mon, 20 Dec 2021 17:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20211216172658.GA770781@bhelgaas> <5432c30fd597a68feaa935054205da90519a769f.camel@linux.intel.com>
In-Reply-To: <5432c30fd597a68feaa935054205da90519a769f.camel@linux.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 20 Dec 2021 17:52:38 -0800
Message-ID: <CACK8Z6Fs0zBZ252XLzBr3QKQd0kx1L=PBgO9qUzSYisM1YHitQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
To:     david.e.box@linux.intel.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, Dec 16, 2021 at 1:24 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> On Thu, 2021-12-16 at 11:26 -0600, Bjorn Helgaas wrote:
> > [+cc Rajat for LTR max latency write]

Thanks!

> >
> > On Wed, Dec 15, 2021 at 09:56:00PM -0800, David E. Box wrote:
> > > From: Michael Bottini <michael.a.bottini@linux.intel.com>
> > >
> > > On Tiger Lake and Alder Lake platforms, VMD controllers do not have ASPM
> > > enabled nor LTR values set by BIOS. This leads high power consumption on
> > > these platforms when VMD is enabled as reported in bugzilla [1].  Enable
> > > these features in the VMD driver using pcie_aspm_policy_override() to set
> > > the ASPM policy for the root ports.
> >
> > s/leads high/leads to high/
> >
> > Does this depend on "Tiger Lake and Alder Lake platforms"
> > specifically, or does it depend on a BIOS design choice, i.e., "don't
> > configure ASPM or LTR for devices below a VMD"?
>
> It was a BIOS design choice to have this done by the OS driver for both Tiger Lake and Alder Lake.
>
> >
> > The subject says "override ASPM on VMD devices," but it looks like
> > this affects the ASPM configuration of devices *below* the VMD, not of
> > the VMD itself.
>
> Yes.
>
> >
> > It looks like this only affects *NVMe* devices, since
> > vmd_enable_aspm() checks for PCI_CLASS_STORAGE_EXPRESS.  Why is that?
> > Is there something special about NVMe?  I'd think you would want to do
> > this for *all* devices below a VMD.
>
> We need this for all devices under the PCIe root ports below VMD. Those will only be NVMe device
> AFAICS.
>
> >
> > Since it only affects PCI_CLASS_STORAGE_EXPRESS devices, I don't think
> > it actually "sets ASPM policy for the root ports".  vmd_enable_aspm()
> > calls pcie_aspm_policy_override() on endpoints.  It's true that the
> > link ASPM state happens to be attached to the upstream end of the
> > link, but that's an ASPM implementation detail.
> >
> > This all needs to be clear in the subject and commit log.
>
> Ack
>
> >
> > > To do this, add an additional flag in VMD features to specify devices that
> > > must have their respective policies overridden.
> >
> > I'm not clear on why you want this to apply to only certain VMDs and
> > not others.  Do some BIOSes configure ASPM for devices below some
> > VMDs?
>
> Not currently. But the plan is for future devices to move back to having BIOS do the programming.
>
> >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=213717
> > >
> > > Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > Tested-by: Adhitya Mohan <me@adhityamohan.in>
> > > ---
> > > V4
> > >  - Refactor vmd_enable_apsm() to exit early, making the lines shorter
> > >    and more readable. Suggested by Christoph.
> > > V3
> > >  - No changes
> > > V2
> > >  - Use return status to print pci_info message if ASPM cannot be enabled.
> > >  - Add missing static declaration, caught by lkp@intel.com
> > >
> > >  drivers/pci/controller/vmd.c | 43 +++++++++++++++++++++++++++++++++---
> > >  1 file changed, 40 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index a45e8e59d3d4..880afd450a14 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -20,6 +20,8 @@
> > >
> > >  #include <asm/irqdomain.h>
> > >
> > > +#include "../pci.h"
> > > +
> > >  #define VMD_CFGBAR     0
> > >  #define VMD_MEMBAR1    2
> > >  #define VMD_MEMBAR2    4
> > > @@ -67,6 +69,12 @@ enum vmd_features {
> > >          * interrupt handling.
> > >          */
> > >         VMD_FEAT_CAN_BYPASS_MSI_REMAP           = (1 << 4),
> > > +
> > > +       /*
> > > +        * Device must have ASPM policy overridden, as its default policy is
> > > +        * incorrect.
> > > +        */
> > > +       VMD_FEAT_QUIRK_OVERRIDE_ASPM            = (1 << 5),
> >
> > I think you specifically want to *enable* some ASPM link states, not
> > just "override the default policy."  "Override" tells us nothing about
> > whether you are enabling or disabling ASPM.  Applies to subject line
> > as well.
>
> Ack
>
> >
> > >  };
> > >
> > >  static DEFINE_IDA(vmd_instance_ida);
> > > @@ -661,6 +669,30 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
> > >         return 0;
> > >  }
> > >
> > > +/*
> > > + * Override the BIOS ASPM policy and set the LTR value for PCI storage
> > > + * devices on the VMD bride.
> >
> > I don't think there's any BIOS "policy" here.  At this point BIOS is
> > no longer involved at all, so all that's left is whatever ASPM config
> > the BIOS did or did not do.
> >
> > Why only storage?
>
> Only storage devices will be on these root ports.
>
> >
> > s/bride/bridge/
> >
> > > + */
> > > +static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
> > > +{
> > > +       int features = *(int *)userdata, pos;
> > > +
> > > +       if (!(features & VMD_FEAT_QUIRK_OVERRIDE_ASPM) ||
> > > +           pdev->class != PCI_CLASS_STORAGE_EXPRESS)
> > > +               return 0;
> > > +
> > > +       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > > +       if (!pos)
> > > +               return 0;
> > > +
> > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, 0x1003);
> > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, 0x1003);
> >
> > 1) Where did this magic 0x1003 value come from?  Does that depend on
> > the VMD device?  The endpoint?  The circuit design?  The path between
> > endpoint and VMD?  What if there are switches in the path?
>
> The number comes from the BIOS team. They are tied to the SoC. I don't believe there can be switches
> in the path but Nirmal and Jonathan should know for sure. From what I've seen these root ports are
> wired directly to M.2 slots on boards that are intended for storage devices.
>
> >
> > 2) There exist broken devices where WORD config accesses don't work:
> > https://lore.kernel.org/all/20211208000948.487820-1-rajatja@google.com/
> >
> > We might need a way to quirk config accesses to those devices, but we
> > don't have one yet.  So for now this needs to be a single DWORD write.
>
> Ack
>

Sideband: Yes, I'm trying to work out such a quirk mechanism, but for
now, yes, please do that as a single DWORD write access.

Thanks,

Rajat

> >
> > > +       if (pcie_aspm_policy_override(pdev))
> > > +               pci_info(pdev, "Unable of override ASPM policy\n");
> >
> > s/Unable of/Unable to/
> >
> > I think we might need a message about when we *do* override the
> > policy.  A note in dmesg might be useful for debugging.  I'm worried
> > about the LTR programming because I really don't understand how we
> > should be doing that.
>
> Sure.
>
> >
> > > +       return 0;
> > > +}
> > > +
> > >  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >  {
> > >         struct pci_sysdata *sd = &vmd->sysdata;
> > > @@ -807,6 +839,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >         pci_scan_child_bus(vmd->bus);
> > >         pci_assign_unassigned_bus_resources(vmd->bus);
> > >
> > > +       pci_walk_bus(vmd->bus, vmd_enable_aspm, &features);
> >
> > Do you support hotplug under VMD?  This will not happen for hot-added
> > devices.
>
> That I don't know. Nirmal, Jonathan?
>
> David
>
> >
> > >         /*
> > >          * VMD root buses are virtual and don't return true on pci_is_pcie()
> > >          * and will fail pcie_bus_configure_settings() early. It can instead be
> > > @@ -948,15 +982,18 @@ static const struct pci_device_id vmd_ids[] = {
> > >         {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
> > >                 .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > >                                 VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > > -                               VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > > +                               VMD_FEAT_OFFSET_FIRST_VECTOR |
> > > +                               VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
> > >         {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
> > >                 .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > >                                 VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > > -                               VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > > +                               VMD_FEAT_OFFSET_FIRST_VECTOR |
> > > +                               VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
> > >         {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > >                 .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > >                                 VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > > -                               VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > > +                               VMD_FEAT_OFFSET_FIRST_VECTOR |
> > > +                               VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
> > >         {0,}
> > >  };
> > >  MODULE_DEVICE_TABLE(pci, vmd_ids);
> > > --
> > > 2.25.1
> > >
>
>
