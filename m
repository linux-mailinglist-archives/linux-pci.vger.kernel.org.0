Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09D94C4A44
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 17:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiBYQOb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 11:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiBYQOa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 11:14:30 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30339134DCC;
        Fri, 25 Feb 2022 08:13:58 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id j24so7899902oii.11;
        Fri, 25 Feb 2022 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCHRnXL4mKn+6E5duIIhmS6dWA7zitZos+dayOXocss=;
        b=S3xzZ2wu0aDRY6jiUq3aQZLTl1ZPMRPGsn8JyzoJPpbsVYqUKBH/CCh4T10JldqDKe
         Y4cXW3IHkYtNO0ncBeau2TBq+l9aSdWTuWKwepu43ms4v0UMbrXWCriIoAFLFvTvmjEh
         +/770KIESfIKDVeHs/n0owPxGSpb4lApAIGm6/ZGpQsltz2HPhG2OPFe44OSG3IJFQC/
         ivU5q9VSwtRyCGXFfbXB1oYkqv9jPpqzOstobW3Z2O+0jjbUYA/ys9CKeQ8xFrONWvUG
         pTYuv5UBhAw1dqLycQXV+ocRM7nTMtl0qerhcSbM/Z2xRxk16PWyu5umKwGz/lANzIcQ
         pIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCHRnXL4mKn+6E5duIIhmS6dWA7zitZos+dayOXocss=;
        b=Pk7TzkzqkTkPH89ptDMS8uwiFUOktz3iFRmx6yGRRH/PPEmbNP1Zw95q2sQ8dNHfaU
         8DkCq7GK1atqNuUxTBYhpYx9k2s0EZjnaN25FzRg1fpIZ4571hHeyzRT8TMgjyS2eziA
         dsuMQn3MlDHOsC+hxAOIweJPOJhzf67G4OtcQauMj9LHCzKy+8spjTssFTUnj7gwlLXO
         g0t//L3LHmSMJUQHMUD7uT5dk1VtJkWTYs74qIZJNWGqnpZhg4LoE+Mw4qbdtf/0qy/t
         W4jL37den4pvuG6Iz3/DYnpoL1YUdDkV2ApOdD2oeOuk4Dcywj53GGxI/l3ftNRXWU6j
         UunA==
X-Gm-Message-State: AOAM530wWkrVisgAE5pv/TOeeTD4YquuCD3d6LVuBho+Cu9LwHXSuExE
        VxCUlq8zcsgx9Hr4Fus2GU5KZsE3FXNM47MwJyEVGkeZ9dM=
X-Google-Smtp-Source: ABdhPJwC+u1A6lmB7w4Qa6qwmF6pQMGUN+HIW84cdgjX/rDWEnFjdpliXt2qnrq9vZGGa/EuxEZUepTh9GVIquBzdzM=
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id
 j13-20020a056808118d00b002d4be7e6748mr1963019oil.123.1645805637487; Fri, 25
 Feb 2022 08:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20220224215116.7138-4-mario.limonciello@amd.com> <20220225012346.GA317859@bhelgaas>
In-Reply-To: <20220225012346.GA317859@bhelgaas>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 25 Feb 2022 11:13:46 -0500
Message-ID: <CADnq5_OA5O=5QLG9B6dgU_qfSJUc7eGDdn0TD5ZTL04EDNfyrQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] PCI: Drop the `is_thunderbolt` attribute from PCI core
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 24, 2022 at 8:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Feb 24, 2022 at 03:51:12PM -0600, Mario Limonciello wrote:
> > The `is_thunderbolt` attribute originally had a well defined list of
> > quirks that it existed for, but it has been overloaded with more
> > meaning.
> >
> > Instead use the driver core removable attribute to indicate the
> > detail a device is attached to a thunderbolt or USB4 chain.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/pci/probe.c               | 2 +-
> >  drivers/platform/x86/apple-gmux.c | 2 +-
> >  include/linux/pci.h               | 5 ++---
> >  3 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 17a969942d37..1b752d425c47 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1584,7 +1584,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
> >       /* Is the device part of a Thunderbolt controller? */
> >       vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
> >       if (vsec)
> > -             dev->is_thunderbolt = 1;
> > +             dev->external_facing = true;
>
> I assume there's a spec for the PCI_VSEC_ID_INTEL_TBT Capability.  Is
> that public?  Does the spec say that a device with that capability
> must be external-facing?
>
> Even if it's not public, I think a citation (name, revision, section)
> would be useful.
>
> >  }
> >
> >  static void set_pcie_untrusted(struct pci_dev *dev)
> > diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> > index 57553f9b4d1d..4444da0c39b0 100644
> > --- a/drivers/platform/x86/apple-gmux.c
> > +++ b/drivers/platform/x86/apple-gmux.c
> > @@ -596,7 +596,7 @@ static int gmux_resume(struct device *dev)
> >
> >  static int is_thunderbolt(struct device *dev, void *data)
> >  {
> > -     return to_pci_dev(dev)->is_thunderbolt;
> > +     return to_pci_dev(dev)->external_facing;
>
> This looks ... sort of weird.  I don't know anything about
> apple-gmux.c, so I guess I don't care, but assuming any
> external-facing device must be a Thunderbolt device seems like a
> stretch.
>
> Ugh.  This is used via "bus_for_each_dev(&pci_bus_type)", which means
> it's not hotplug-safe.  I'm sure we "know" implicitly that hotplug
> isn't an issue in apple-gmux, but it's better not to have examples
> that get copied to places where it *is* an issue.
>
> >  }
> >
> >  static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 1e5b769e42fc..d9719eb14654 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -442,7 +442,6 @@ struct pci_dev {
> >       unsigned int    is_virtfn:1;
> >       unsigned int    is_hotplug_bridge:1;
> >       unsigned int    shpc_managed:1;         /* SHPC owned by shpchp */
> > -     unsigned int    is_thunderbolt:1;       /* Thunderbolt controller */
> >       unsigned int    no_cmd_complete:1;      /* Lies about command completed events */
> >
> >       /*
> > @@ -2447,11 +2446,11 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
> >  {
> >       struct pci_dev *parent = pdev;
> >
> > -     if (pdev->is_thunderbolt)
> > +     if (dev_is_removable(&pdev->dev))
> >               return true;
> >
> >       while ((parent = pci_upstream_bridge(parent)))
> > -             if (parent->is_thunderbolt)
> > +             if (dev_is_removable(&parent->dev))
> >                       return true;
>
> I don't get this.  Plain old PCI devices can be removable, too.
>
> pci_is_thunderbolt_attached() is only used by GPU drivers.  What
> property of Thunderbolt do they care about?
>
> nouveau_vga_init() and radeon_device_init() use it to decide to
> register with vga_switcheroo.  So maybe that's something to do with
> removability?  Of course, that's not specific to Thunderbolt, because
> garden-variety PCIe devices are removable.
>
> amdgpu_driver_load_kms() and radeon_driver_load_kms() apparently use
> it for something related to power control.  I don't know what the
> Thunderbolt connection is.

For GPU drivers, we need to determine which dGPU on the system has
d3cold control via ACPI and which GPU would use a mux for display
switching between the iGPU and the dGPU for hybrid graphics platforms
(e.g., iGPU + dGPU built into a laptop or all-in-one PC).  The dGPU
built into the platform would be the one we want to use for mux
switching and ACPI power control.  You would not want that for the
dGPU connected via thunderbolt (or some other hot pluggable
interface).  I had suggested that we could check if there is an ACPI
device associated with the dGPU and use that to determine this, but I
think someone brought up a case where that didn't work.  We need to
know whether the dGPU uses platform power control to determine whether
the driver should let the platform manage the power state via ACPI or
if the driver should do it (e.g., for dGPU PCIe add-in cards) for
runtime power management.

>
> nbio_v2_3_enable_aspm() looks like it uses it to change some ASPM
> parameters.  Seems like potentially a device erratum or quirk
> material?

I think this one is a quirk specifically for thunderbolt.  Thunderbolt
attached dGPUs needs a different ASPM L1 inactivity threshold for
stability.  I can check with the relevant teams for more background on
this.

Alex

>
> If these things are not specifically related to Thunderbolt, I'd
> prefer to get rid of pci_is_thunderbolt_attached() and see if we can
> help the GPU folks figure out what they really need.
>
> >       return false;
> > --
> > 2.34.1
> >
