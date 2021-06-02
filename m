Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3D239929C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhFBSeZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 14:34:25 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:38605 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFBSeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 14:34:25 -0400
Received: by mail-vs1-f51.google.com with SMTP id x8so1632656vso.5
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 11:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+6EpPiKGTbba3D6msEWSqgRwh29B5X0RstzTh8olVo=;
        b=jxwes4IJ6U0ttJaiH1ijIGfeEr0C/TQYkLyoAGHlATMfw/MBnyPOdLK2zk1saML2Mq
         qZDNGQLj41RmwISSC2DVyx9MFN1UmpE3yQW04aM7cr9u6VcXZ/cF4VUoqu39b35B5q1R
         2dZBNu4GhczPPUjoGjelItX+I/ERNwUqNqEPOm0NO4MKUg6kRcaok0nYw4oglucWLhOI
         55g12daPmYdolLCwn+OUjkndFvV6zzf9u72tlJOSa+jKft5Psv9Mm2WGerUfqGK8l2CS
         6WU5IkV9lBW+seaQ2TTpyNDf9r9NM4N+oJAQCbTD6mdZgRvza0j1V7viVNxpwPVFnxrP
         plVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+6EpPiKGTbba3D6msEWSqgRwh29B5X0RstzTh8olVo=;
        b=qi1RGfoccr0ps0pQn15ELrHTBEN5vq8WWkZJtm7Zh7zQzg1q4SFQMB1Lu6xQ82bMO8
         u9rg7yfMVNCA9u7A6KeZvaEOoRFQqKYLuXVMbowwazvPbuCMCVtSr4+pWN9Cwsy7WR+c
         1/QFqXfgwAM9U6BWaghJQM8xEUD3pQNHKfYtNeoXtvy1+t1yDJ+35gVc+vVSGYW3f51L
         10PjuuJo33wMhC1EsVxcdi55f3LDkcxozWVTVvGHnZH34USwbP8EoiIl5MaSBCeeon13
         2Ej3fHYWkCKxFAtDBlB3aIiTiopRaTYODwHQsPYsx3qtyXz/u2zMO16hhTSnzCFBl5us
         P4fg==
X-Gm-Message-State: AOAM530xl6KDNiHGYz9ws/lDof3uRXJD5iQh6ZywRyq7GXwGImZGx8vY
        WSWPS9qM2YJ03W8e6dIeFlUlNWfFe6+0gVNgDoZ/
X-Google-Smtp-Source: ABdhPJxwLwNw9wMdeE6wsbNns02k71FVdh9AIj+Ofqu2MLM0zTHxGQtuSlAXZ0gIg3XSoWsQdSaxURqU43/s4Fm+pOM=
X-Received: by 2002:a05:6102:227c:: with SMTP id v28mr25855811vsd.52.1622658688177;
 Wed, 02 Jun 2021 11:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210528082607.2015145-1-chenhuacai@loongson.cn>
 <YLZYuM6SepbeLcI7@phenom.ffwll.local> <YLZqe14Lf2+5Lbf3@kroah.com>
 <YLZ2WJlHu0EZT7H9@phenom.ffwll.local> <CAAhV-H5Mt7tmmDVoix6sY3UtfhjxGvHovve2N=5o5xtvmFeQOA@mail.gmail.com>
 <YLewShl3lMyqJ1WZ@phenom.ffwll.local>
In-Reply-To: <YLewShl3lMyqJ1WZ@phenom.ffwll.local>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 2 Jun 2021 13:31:16 -0500
Message-ID: <CAErSpo4cLp4YHGh0Lp=hZ70=1A4WBEtUhM-KUKk=SnNmTVzmRg@mail.gmail.com>
Subject: Re: [PATCH] vgaarb: Call vga_arb_device_init() after PCI enumeration
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Wed, Jun 2, 2021 at 11:22 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Jun 02, 2021 at 06:36:03PM +0800, Huacai Chen wrote:
> > On Wed, Jun 2, 2021 at 2:03 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Tue, Jun 01, 2021 at 07:12:27PM +0200, Greg KH wrote:
> > > > On Tue, Jun 01, 2021 at 05:56:40PM +0200, Daniel Vetter wrote:
> > > > > On Fri, May 28, 2021 at 04:26:07PM +0800, Huacai Chen wrote:
> > > > > > We should call vga_arb_device_init() after PCI enumeration, otherwise it
> > > > > > may fail to select the default VGA device. Since vga_arb_device_init()
> > > > > > and PCI enumeration function (i.e., pcibios_init() or acpi_init()) are
> > > > > > both wrapped by subsys_initcall(), their sequence is not assured. So, we
> > > > > > use subsys_initcall_sync() instead of subsys_initcall() to wrap vga_arb_
> > > > > > device_init().
> > > >
> > > > Trying to juggle levels like this always fails if you build the code as
> > > > a module.
> > > >
> > > > Why not fix it properly and handle the out-of-order loading by returning
> > > > a "deferred" error if you do not have your resources yet?
> > >
> > > It's not a driver, it's kinda a bolted-on-the-side subsytem of pci. So not
> > > something you can -EPROBE_DEFER I think, without potentially upsetting the
> > > drivers that need this.
> > >
> > > Which might mean we should move this into pci subsystem proper perhaps?
> > > Then adding the init call at the right time becomes trivial since we just
> > > plug it in at the end of pci init.
> > >
> > > Also maybe that's how distros avoid this pain, pci is built-in, vgaarb is
> > > generally a module, problem solved.
> > >
> > > Bjorn, would you take this entire vgaarb.c thing? From a quick look I
> > > don't think it has a drm-ism in it (unlike vga_switcheroo, but that works
> > > a bit differently and doesn't have this init order issue).
> > Emmm, this patch cannot handle the hotplug case and module case, it
> > just handles the case that vgaarb, drm driver and pci all built-in.
> > But I think this is enough, because the original problem only happens
> > on very few BMC-based VGA cards (BMC doesn't set the VGA Enable bit on
> > the bridge, which breaks vgaarb).
>
> I'm not talking aout hotplug, just ordering the various pieces correctly.
> That vgaarb isn't really a driver and also can't really handle hotplug is
> my point. I guess that got lost a bit?
>
> Anyway my proposal is essentially to do a
>
> $ git move drivers/gpu/vga/vgaarb.c drivers/pci
>
> But I just realized that vgaarb is a bool option, so module isn't possible
> anyway, and we could fix this by calling vgaarb from pcibios init (with an
> empty static inline in the header if vgaarb is disabled). That makes the
> dependency very explicit and guarantees it works correctly.

pcibios_init() is also an initcall and is implemented by every arch.
I agree that calling vga_arb_device_init() directly from
pcibios_init() would probably fix this problem, and it would be really
nice to have it not be an initcall.  But it's also kind of a pain to
have to update all those copies of pcibios_init(), and I would be
looking for a way to unify it since it's not really an arch-specific
thing.

I think the simplest solution, which I suggested earlier [1], would be
to explicitly call vga_arbiter_add_pci_device() directly from the PCI
core when it enumerates a VGA device.  Then there's no initcall and no
need for the BUS_NOTIFY_ADD/DEL_DEVICE stuff.
vga_arbiter_add_pci_device() could set the default VGA device when it
is enumerated, and change the default device if we enumerate a
"better" one.  And hotplug VGA devices would work automatically.

> Whether we move vgaarb into drivers/pci or not is then kinda orthogonal.

I'm fine with moving it to drivers/pci if that makes anything easier.
It definitely is PCI-related stuff, not GPU-related stuff.

[1] https://lore.kernel.org/r/20210526182940.GA1303599@bjorn-Precision-5520
