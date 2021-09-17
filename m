Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198F240F07F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 05:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbhIQDv1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 23:51:27 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40804
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230287AbhIQDv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 23:51:27 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 40A2940260
        for <linux-pci@vger.kernel.org>; Fri, 17 Sep 2021 03:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631850598;
        bh=o2WwArOaqXO510rowzIQD3yCaqD7PjB7l55ID7TA3xc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KC/wMMq6u4xVTIC9gWwtWw3qFPdmYtz6bE0+rjN44ZoRNnma/rFGmlEFwdE+tN1vu
         IomElIncX/Wfo9BttVhsPysERGTi6sgoRZDtDaVpIGx8+dP75WV+wrpa+oRoBKMiKQ
         lbtTSAJQ6UAwoWZtiXZ13JPJFNb8wCuGfQTgT/tGtEr/VcdBNmlzR1BCyjthRQZwcO
         G6LeIy+gbZXkWoNL88gMLndA2hHOm44Hc4VA/qdwEg6tPjrsqXtjcl3azNgtzmN5wO
         HRLszHr1z4BXuRjitmpzM7VQqcBb73I1tVFx06Z4miObasxZxclDOup3CXV58llczG
         w8nLNVLFHrU4w==
Received: by mail-oo1-f71.google.com with SMTP id i5-20020a4ad385000000b0028bd047a835so37968942oos.12
        for <linux-pci@vger.kernel.org>; Thu, 16 Sep 2021 20:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2WwArOaqXO510rowzIQD3yCaqD7PjB7l55ID7TA3xc=;
        b=c6mmKVy67xe7VyRCX8674bldJTk7BhSvt8QI7ilVD83K39nqF9B1h9yG9cEDOUtw4T
         2MAK+BiJIelIgtnGVRYmFxIfeTumpOS3xzKm6O9ajXJunPG5sHCdmyR35GBMkwcR2oQ2
         w3dYVc7OVy9y6Gvvt0EThiAtm/8zGMb+wdhyFRO29ADUklN29YMrIbaDTCn+bRqObJb1
         Ov0dWVILndbb4TSr7xOXjzgv5SDjVUleRd3DPzgUsV/IMRmSoVrMwLHb+Ca6YwH9MPBu
         z4EsvbBoCduRpCXHZajTY7lIoCS8mxBxlNJKrcdN89tsy894d33zMSaNdKbeijsTnqVc
         DOqw==
X-Gm-Message-State: AOAM532NatUqga5rYgo1FvNdOPLUq86BHtxWrzQ7yLPC6iRXRZkDXp/R
        vPJP4Q/k1YYN58/YsoG6gmT3eXMJyNb32HxSwdQRKe3xlQZhLM5Mo5QaWJgLrMJ2P5VQ3SkRstH
        gADwi7Ofs6fjvcaSh1PLDhme7wC380bhIw0ycwhYJo70m1ggnFOmZJg==
X-Received: by 2002:a9d:1708:: with SMTP id i8mr37627ota.233.1631850596967;
        Thu, 16 Sep 2021 20:49:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw7/JqD91vFn6Wh+g3/wCVkduUO+JuLE1VRUyT5ut6P5TQKvgQDp/KcbJC9Gr75Lp89fxAxavZwAorE2CYMic=
X-Received: by 2002:a9d:1708:: with SMTP id i8mr37613ota.233.1631850596710;
 Thu, 16 Sep 2021 20:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210519135723.525997-1-kai.heng.feng@canonical.com> <20210916163755.GA1620802@bjorn-Precision-5520>
In-Reply-To: <20210916163755.GA1620802@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 17 Sep 2021 11:49:45 +0800
Message-ID: <CAAd53p6XdeYcLNctghOi5VPy1YHEOaGoeo9Wc_T9P-RmYTJKzA@mail.gmail.com>
Subject: Re: [PATCH] vgaarb: Use ACPI HID name to find integrated GPU
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 17, 2021 at 12:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Huacai, linux-pci]
>
> On Wed, May 19, 2021 at 09:57:23PM +0800, Kai-Heng Feng wrote:
> > Commit 3d42f1ddc47a ("vgaarb: Keep adding VGA device in queue") assumes
> > the first device is an integrated GPU. However, on AMD platforms an
> > integrated GPU can have higher PCI device number than a discrete GPU.
> >
> > Integrated GPU on ACPI platform generally has _DOD and _DOS method, so
> > use that as predicate to find integrated GPU. If the new strategy
> > doesn't work, fallback to use the first device as boot VGA.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/gpu/vga/vgaarb.c | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> > index 5180c5687ee5..949fde433ea2 100644
> > --- a/drivers/gpu/vga/vgaarb.c
> > +++ b/drivers/gpu/vga/vgaarb.c
> > @@ -50,6 +50,7 @@
> >  #include <linux/screen_info.h>
> >  #include <linux/vt.h>
> >  #include <linux/console.h>
> > +#include <linux/acpi.h>
> >
> >  #include <linux/uaccess.h>
> >
> > @@ -1450,9 +1451,23 @@ static struct miscdevice vga_arb_device = {
> >       MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
> >  };
> >
> > +#if defined(CONFIG_ACPI)
> > +static bool vga_arb_integrated_gpu(struct device *dev)
> > +{
> > +     struct acpi_device *adev = ACPI_COMPANION(dev);
> > +
> > +     return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> > +}
> > +#else
> > +static bool vga_arb_integrated_gpu(struct device *dev)
> > +{
> > +     return false;
> > +}
> > +#endif
> > +
> >  static void __init vga_arb_select_default_device(void)
> >  {
> > -     struct pci_dev *pdev;
> > +     struct pci_dev *pdev, *found = NULL;
> >       struct vga_device *vgadev;
> >
> >  #if defined(CONFIG_X86) || defined(CONFIG_IA64)
> > @@ -1505,20 +1520,26 @@ static void __init vga_arb_select_default_device(void)
> >  #endif
> >
> >       if (!vga_default_device()) {
> > -             list_for_each_entry(vgadev, &vga_list, list) {
> > +             list_for_each_entry_reverse(vgadev, &vga_list, list) {
>
> Hi Kai-Heng, do you remember why you changed the order of this list
> traversal?

The descending order is to keep the original behavior.

Before this patch, it breaks out of the loop as early as possible, so
the lower numbered device is picked.
This patch makes it only break out of the loop when ACPI_VIDEO_HID
device is found.
So if there are more than one device that meet "cmd & (PCI_COMMAND_IO
| PCI_COMMAND_MEMORY)", higher numbered device will be selected.
So the traverse order reversal is to keep the original behavior.

>
> I guess the list_add_tail() in vga_arbiter_add_pci_device() means
> vga_list is generally ordered with small device numbers first and
> large ones last.
>
> So you pick the integrated GPU with the largest device number.  Are
> there systems with more than one integrated GPU?  If so, I would
> naively expect that in the absence of an indication otherwise, we'd
> want the one with the *smallest* device number.

There's only one integrated GPU on the affected system.

The approach is to keep the list traversal in one pass.
Is there any regression introduce by this patch?
If that's the case, we can separate the logic and find the
ACPI_VIDEO_HID in second pass.

Kai-Heng

>
> >                       struct device *dev = &vgadev->pdev->dev;
> >                       u16 cmd;
> >
> >                       pdev = vgadev->pdev;
> >                       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> >                       if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> > -                             vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
> > -                             vga_set_default_device(pdev);
> > -                             break;
> > +                             found = pdev;
> > +                             if (vga_arb_integrated_gpu(dev))
> > +                                     break;
> >                       }
> >               }
> >       }
> >
> > +     if (found) {
> > +             vgaarb_info(&found->dev, "setting as boot device (VGA legacy resources not available)\n");
> > +             vga_set_default_device(found);
> > +             return;
> > +     }
> > +
> >       if (!vga_default_device()) {
> >               vgadev = list_first_entry_or_null(&vga_list,
> >                                                 struct vga_device, list);
> > --
> > 2.31.1
> >
