Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8B4155E3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 05:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbhIWDWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 23:22:09 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55976
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239019AbhIWDWG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 23:22:06 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8BBDE3F30E
        for <linux-pci@vger.kernel.org>; Thu, 23 Sep 2021 03:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632367233;
        bh=+y78UmABh7HK9tr/4S4sGTCsj4Mr5ovgzCxdWvhQlG4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uNh29KRnZbR8/SoCvkGLKHhi21F46gzpXddgQxLgNCgULNmoyDkZf+eDMDWgsn0bD
         Qle+q3LTLuci42Bf+CLTCIsExq9sYVuMIO4nlq42XJvTXKkbDfniIZ05BpyiGtwLE/
         mlQo6sRqbJXnCWhfxR3I7HMSwO/YaBp6Eefpsg7r+5TRtRnZba1dRns34iCvVg4e0r
         fI7MmQJ7pcdTyItQJdpOKCDI+h9nZSqTEx7HjfAYr/Oih/hdXw8wgwZRUZvHdiY2T6
         EKZg7cCaLgQE0OPFM16ApS4s6WgynHyyD4dbuy2K4ZVmCHTx5/b9NO2/P6B3nJiaQ7
         pdolEWpvn5SSg==
Received: by mail-oo1-f70.google.com with SMTP id d6-20020a4a8806000000b0029acf18dcffso3018117ooi.11
        for <linux-pci@vger.kernel.org>; Wed, 22 Sep 2021 20:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y78UmABh7HK9tr/4S4sGTCsj4Mr5ovgzCxdWvhQlG4=;
        b=n+aU5GDRqBty373sSWvsOMr3hnP5Yrhk+M6Y/Ni8wQMhmwlPRpJp6OKYENM/h6FqF8
         LylsgWpnF+hVNBRYOmYVUyfHk48BkXtJOhCD4b0bC6CUio6l7nkuaMWre49SAsI6C4jh
         MvE0WKjrgQ1SzsyHJapY6iM86kUgiQXkOQW7wkes6g+fU47/aOtSzrWndnNumwtrMpmM
         5HQElgaIhACzSGYqw5DqX6uX0HRHvnXhGNhY8OqXvkhbnobjX5U7a57xSGulYB27+2h/
         yCkM47utQ4KCZeWrbYMW9jd2SpUckVlSheTtGCXXVfv3/xI/g/pC0BDLUWWFJF+wV/ZF
         ZYYQ==
X-Gm-Message-State: AOAM530kJCqytrQEusbaphLC1HETC/lGmoXbQ6TF540GM6CtAxP8Smye
        An23xI3ymlApkxyaSZhnaoOWdR0gdq4C6AZ1Uj12rC/wq+lBV5Xl1W0vV4V/OIUOpcZ1mBpano2
        IbvUcOTOOE97zmaTdhtn5Y3Yxha1DCqpsvkajKJYGsggyjxBW+2lFvQ==
X-Received: by 2002:aca:2102:: with SMTP id 2mr10887119oiz.98.1632367232282;
        Wed, 22 Sep 2021 20:20:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo/AOHrlw7eOB4SMFrUrqCF4z6yGeBZyQ9DCJWkuum5LRKyrbRQIRZgx6p+VovUjqHalCZTcYbTL6gqQfhfKI=
X-Received: by 2002:aca:2102:: with SMTP id 2mr10887103oiz.98.1632367231968;
 Wed, 22 Sep 2021 20:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6XdeYcLNctghOi5VPy1YHEOaGoeo9Wc_T9P-RmYTJKzA@mail.gmail.com>
 <20210917165500.GA1723244@bjorn-Precision-5520>
In-Reply-To: <20210917165500.GA1723244@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 23 Sep 2021 11:20:20 +0800
Message-ID: <CAAd53p4raiRuWQ3O9VFpxhtro4YJ-E2sUiDrnFnNEMDyxXDK=w@mail.gmail.com>
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

On Sat, Sep 18, 2021 at 12:55 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Sep 17, 2021 at 11:49:45AM +0800, Kai-Heng Feng wrote:
> > On Fri, Sep 17, 2021 at 12:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Huacai, linux-pci]
> > >
> > > On Wed, May 19, 2021 at 09:57:23PM +0800, Kai-Heng Feng wrote:
> > > > Commit 3d42f1ddc47a ("vgaarb: Keep adding VGA device in queue") assumes
> > > > the first device is an integrated GPU. However, on AMD platforms an
> > > > integrated GPU can have higher PCI device number than a discrete GPU.
> > > >
> > > > Integrated GPU on ACPI platform generally has _DOD and _DOS method, so
> > > > use that as predicate to find integrated GPU. If the new strategy
> > > > doesn't work, fallback to use the first device as boot VGA.
> > > >
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >  drivers/gpu/vga/vgaarb.c | 31 ++++++++++++++++++++++++++-----
> > > >  1 file changed, 26 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> > > > index 5180c5687ee5..949fde433ea2 100644
> > > > --- a/drivers/gpu/vga/vgaarb.c
> > > > +++ b/drivers/gpu/vga/vgaarb.c
> > > > @@ -50,6 +50,7 @@
> > > >  #include <linux/screen_info.h>
> > > >  #include <linux/vt.h>
> > > >  #include <linux/console.h>
> > > > +#include <linux/acpi.h>
> > > >
> > > >  #include <linux/uaccess.h>
> > > >
> > > > @@ -1450,9 +1451,23 @@ static struct miscdevice vga_arb_device = {
> > > >       MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
> > > >  };
> > > >
> > > > +#if defined(CONFIG_ACPI)
> > > > +static bool vga_arb_integrated_gpu(struct device *dev)
> > > > +{
> > > > +     struct acpi_device *adev = ACPI_COMPANION(dev);
> > > > +
> > > > +     return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> > > > +}
> > > > +#else
> > > > +static bool vga_arb_integrated_gpu(struct device *dev)
> > > > +{
> > > > +     return false;
> > > > +}
> > > > +#endif
> > > > +
> > > >  static void __init vga_arb_select_default_device(void)
> > > >  {
> > > > -     struct pci_dev *pdev;
> > > > +     struct pci_dev *pdev, *found = NULL;
> > > >       struct vga_device *vgadev;
> > > >
> > > >  #if defined(CONFIG_X86) || defined(CONFIG_IA64)
> > > > @@ -1505,20 +1520,26 @@ static void __init vga_arb_select_default_device(void)
> > > >  #endif
> > > >
> > > >       if (!vga_default_device()) {
> > > > -             list_for_each_entry(vgadev, &vga_list, list) {
> > > > +             list_for_each_entry_reverse(vgadev, &vga_list, list) {
> > >
> > > Hi Kai-Heng, do you remember why you changed the order of this list
> > > traversal?
> >
> > The descending order is to keep the original behavior.
> >
> > Before this patch, it breaks out of the loop as early as possible, so
> > the lower numbered device is picked.
> > This patch makes it only break out of the loop when ACPI_VIDEO_HID
> > device is found.
> > So if there are more than one device that meet "cmd & (PCI_COMMAND_IO
> > | PCI_COMMAND_MEMORY)", higher numbered device will be selected.
> > So the traverse order reversal is to keep the original behavior.
>
> Can you give an example of what you mean?  I don't quite follow how it
> keeps the original behavior.
>
> If we have this:
>
>   0  PCI_COMMAND_MEMORY set   ACPI_VIDEO_HID
>   1  PCI_COMMAND_MEMORY set   ACPI_VIDEO_HID
>
> Previously we didn't look for ACPI_VIDEO_HID, so we chose 0, now we
> choose 1, which seems wrong.  In the absence of other information, I
> would prefer the lower-numbered device.
>
> Or this:
>
>   0  PCI_COMMAND_MEMORY set
>   1  PCI_COMMAND_MEMORY set   ACPI_VIDEO_HID
>
> Previously we chose 0; now we choose 1, which does seem right, but
> we'd choose 1 regardless of the order.
>
> Or this:
>
>   0  PCI_COMMAND_MEMORY set   ACPI_VIDEO_HID
>   1  PCI_COMMAND_MEMORY set
>
> Previously we chose 0, now we still choose 0, which seems right but
> again doesn't depend on the order.
>
> The first case, where both devices are ACPI_VIDEO_HID, is the only one
> where the order matters, and I suggest that we should be using the
> original order, not the reversed order.

Consider this:
0  PCI_COMMAND_MEMORY set
1  PCI_COMMAND_MEMORY set

Originally device 0 will be picked. If the traverse order is kept,
device 1 will be selected instead, because none of them pass
vga_arb_integrated_gpu().

Kai-Heng

>
> > > I guess the list_add_tail() in vga_arbiter_add_pci_device() means
> > > vga_list is generally ordered with small device numbers first and
> > > large ones last.
> > >
> > > So you pick the integrated GPU with the largest device number.  Are
> > > there systems with more than one integrated GPU?  If so, I would
> > > naively expect that in the absence of an indication otherwise, we'd
> > > want the one with the *smallest* device number.
> >
> > There's only one integrated GPU on the affected system.
> >
> > The approach is to keep the list traversal in one pass.
> > Is there any regression introduce by this patch?
> > If that's the case, we can separate the logic and find the
> > ACPI_VIDEO_HID in second pass.
>
> No regression, I'm just looking at Huacai's VGA patches, which affect
> this area.
