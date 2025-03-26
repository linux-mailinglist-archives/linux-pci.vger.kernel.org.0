Return-Path: <linux-pci+bounces-24750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BACA71368
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 10:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7199B3B6F3E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765017B506;
	Wed, 26 Mar 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgRC8LoI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4B158DA3
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980542; cv=none; b=Hw5oZO8actSOtLFgqEFavPV+5cUcqz74dU9hh+u4bNWXS4dW1blM3JPtkUvkyaDUykBAafy9GguEoUVGWMXZ4rZJ8GuoRQEkUGJloRgF06/kLvRta4hDCe7acuwAIZIUPLrszpArwm03Od6TSpJEFDgKIVgMzWN+Tuv6LyNH120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980542; c=relaxed/simple;
	bh=/H1wTvyr5tsWkX2Rv0GdGxFPYuYV2KazfPniifSB8FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMWGRGxoQ8WPLn/VKSRZF1W3j8kFtO3v+0aILPkqSJqd53uxuSuBN0tCi89hjHQXLtoH3XLIKGzzjNejWlxo1TrggIFbWuWeD+5htTdv6jNVd0Bu0qF0ARJ/JnFhh1TKfJsOxhqmWrpx2LLPrTqhktqHqXDPLVmBW5SD/mlLVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgRC8LoI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so915412066b.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742980539; x=1743585339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsJj4MsviRdZRWAI3t9QDLtfnm4aB6zEh8PwYsGJZUA=;
        b=BgRC8LoIP5JEpPv/UcwRa6pdJulcEjMJKUKLqjl738u64C3ehD/1+nHOvUTx7MvAax
         7htRIpaGJSPACVIAX/NTSMGPTUwp8WjmYcln0V5QNyFJeP8MVEmeHblbKGMqQMBohp2S
         eqKgrK6w0DEUPf308LLf/BVg2VbRm1opaydd0EdcpkUQoxqa77M9PS6RfaYoMi0I0Wxc
         1Yygnp3IsEKCOYDIlFW/l10CyhbXbOkai16rooJFOT3lfvwxQeupB2959TenRPGXAy0/
         azxoGP2WJ0V5skHHeeNnYJsVAm5FKSdkMMS+AFd3bxVKAOOE8FcvDIlBmCvARXqYN+jx
         LwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742980539; x=1743585339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsJj4MsviRdZRWAI3t9QDLtfnm4aB6zEh8PwYsGJZUA=;
        b=eHytyQYVeM9nLQxs5v5Ei+A0y0Qh7FC51W4Lh0M3Z9Lk6zzbQ1uvVZ4RPGDCems/qi
         roqRT6JZeDJvDbakWILnuPC7o/f/kJSbJ8158FE7503gUAeyInS8g4OMnikDprJjdHq2
         S1FZybdhHnVsrPTLEtmZ7oPAP93KYXAK55GLNb41eEog7N2Q+a2renEDeV2E0C8+lnrN
         2gj1neRnFDZiuyYHSrrtNwwRFAXcfsKmblrm7e0ogY9xEHjeynSWTbhzwaqk6B7M0vlf
         6arugotEnz6y9pq8sc76ZZ7t+cON4NHrKcfASEG9tONsxwQ96PTK9cxPsBv9rbBAyt0J
         UAJA==
X-Forwarded-Encrypted: i=1; AJvYcCVN9S1/NQ/dl+2ONojr9yc1f+KX+SvzZ2Inmz/THIymi7aD9TVygLzICdnjvo2aq/3lykK90abki5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbzSDi8PVSLCCWoAKuRXeR/01chBPaqA3MmyXMzuugpAFTAaL
	YaEVqPM1DSfBNb114jbNuG/VGAEHmRof8vH93aQk0NFREG0k1XxxiIyG6OiCsP1AMkTO5jNG/0L
	HF/A4v6fk+LTf/+H+Kl4lW5lQw7AMbentHSLJbw==
X-Gm-Gg: ASbGncuwcmwjXyA+MZeFcSN9X0RjTBkG7LhOi7LK34e6DGQtdorKL0lrxOCBmJIE0w1
	KO9Dj1aSFNT6dWFPFhNcjyFPoou+mRkBGKFa38fmXNi32KG2XRD8o44qZNFd4og1LTb9ZuBw6Nv
	j23HjiyWW3x0USfoAByPr3uRFnarNy
X-Google-Smtp-Source: AGHT+IGCx0CwKbcp/DEeEBG9rDf6JKoBNWEaN4ZVKpMgkw55pGBPmm0oDeIBokQCS1+64UadEPaWIknL2FVFYPpJBsA=
X-Received: by 2002:a17:907:1b05:b0:ac3:4373:e8bf with SMTP id
 a640c23a62f3a-ac3f241b60cmr1874068666b.10.1742980538379; Wed, 26 Mar 2025
 02:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H7c9jkXqwn2STdYq-1g4jVELjKL5jaO2aASFAETW5FLHw@mail.gmail.com>
 <20250318215025.GA1012479@bhelgaas>
In-Reply-To: <20250318215025.GA1012479@bhelgaas>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 26 Mar 2025 17:15:28 +0800
X-Gm-Features: AQ5f1JodSzHMYeHOCSVwFkxr96OR7M3TCO-KWyBTa_R4-L_d0zjV8am04NzebIc
Message-ID: <CAAhV-H7+3_qJzrN+wZv8Useh0tvojObp0Sa0m8UW4WYhUYipjw@mail.gmail.com>
Subject: Re: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:50=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Greg, USB maintainer; I'm proposing ohci_pci_quirks for this]
>
> On Tue, Mar 18, 2025 at 09:07:10PM +0800, Huacai Chen wrote:
> > On Sat, Mar 15, 2025 at 3:59=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Tue, Jan 21, 2025 at 07:42:25PM +0800, Huacai Chen wrote:
> > > > The OHCI controller (rev 0x02) under LS7A PCI host has a hardware f=
law.
> > > > MMIO register with offset 0x60/0x64 is treated as legacy PS2-compat=
ible
> > > > keyboard/mouse interface, which confuse the OHCI controller. Since =
OHCI
> > > > only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB=
 BAR
> > > > is wrapped around (the second 4KB BAR space is the same as the firs=
t 4KB
> > > > internally). So we can add an 4KB offset (0x1000) to the BAR resour=
ce as
> > > > a workaround.
> > >
> > > It looks like usb_hcd_pci_probe() only uses BAR 0 in the OHCI case, s=
o
> > > I assume this OHCI controller has a single 32KB BAR?
> >
> > Yes.
> >
> > > And you're saying that in that BAR, the 0x1000-0x1fff offsets are
> > > aliases of the 0x0000-0x0fff area?
> >
> > Yes.
> >
> > > And this causes some kind of problem because the OCHI driver looks at
> > > offsets 0x60 and 0x64 into the BAR and sees something it doesn't like=
?
> >
> > Yes.
> >
> > > And this quirk adds 0x1000 to the BAR start, so the OHCI driver looks
> > > at offsets 0x1060 and 0x1064 of the original BAR, and that somehow
> > > avoids a problem?  Even though those are aliases of 0x0060 and 0x0064
> > > of the original BAR?
> >
> > Yes.
> >
> > > > +static void loongson_ohci_quirk(struct pci_dev *dev)
> > > > +{
> > > > +     if (dev->revision =3D=3D 0x2)
> > > > +             dev->resource[0].start +=3D 0x1000;
> > >
> > > What does this do to the iomem_resource tree?  IIUC, dev->resource[0]
> > > no longer correctly describes the PCI address space consumed by the
> > > device.
> >
> > In the iomem_resource tree the whole 32KB is requested for the OHCI
> > controller.
>
> I'm skeptical.  The quirk only updates the start, not the end, so I
> think the resource is only 28KB after the quirk.
>
> This is a final quirk, so I think the quirk runs after the BAR
> resource has already been put in the iomem_resource tree.  We
> shouldn't update the resource start/end after that point.
>
> > > If the BAR is actually programmed with [mem 0x20000000-0x20007fff],
> > > the device responds to PCI accesses in that range.  Now you update
> > > resource[0] so it describes the space [mem 0x20001000-0x20008fff].  S=
o
> > > the kernel *thinks* the space at [mem 0x20000000-0x20000fff] is free
> > > and available for something else, which is not true, and that the
> > > device responds at [mem 0x0x20008000-0x20008fff], which is also not
> > > true.
> > >
> > > I think the resource has already been put into the iomem_resource tre=
e
> > > by the time the final fixups are run, so this also may corrupt the
> > > sorting of the tree.
> > >
> > > This just doesn't look safe to me.
> >
> > OHCI only uses 4KB io resources (hardware designer told me that this
> > is from USB specification). So if the BAR is [mem
> > 0x20000000-0x20007fff] and without this quirk, software will only
> > use [mem 0x20000000-0x20000fff]; and if we do this quirk, software
> > will only use [mem 0x20001000-0x20001fff]. Since the whole 32KB
> > belongs to OHCI, there won't be corruption.
>
> Here's the path where I think the BAR is requested.  Assume the BAR
> contains 0x20000000 when we boot:
>
>   acpi_pci_root_add
>     pci_acpi_scan_root                  # loongson
>       acpi_pci_root_create
>         pci_scan_child_bus
>           pci_scan_single_device        # details trimmed
>             pci_scan_device
>               pci_read_bases
>                 resource[0].start =3D 0x20000000
>                 resource[0].end   =3D 0x20007fff          # size 32KB
>             pci_device_add
>               pci_fixup_device(pci_fixup_header)        # <--
>       pci_bus_assign_resources          # details trimmed
>         pci_assign_resource
>           pci_bus_alloc_resource
>             allocate_resource
>               __request_resource        # inserted in iomem_resource
>     pci_bus_add_devices
>       pci_bus_add_device
>         pci_fixup_device(pci_fixup_final)
>           resource[0].start +=3D 0x1000                   # now 0x2000100=
0
>
>   ohci_pci_probe
>     usb_hcd_pci_probe(& ohci_pci_hc_driver)
>       if (driver->flags & HCD_MEMORY)
>         hcd->rsrc_start =3D pci_resource_start(dev, 0)    # 0x20001000
>         hcd->rsrc_len =3D pci_resource_len(dev, 0)        # now 28KB
>         devm_request_mem_region
>         hcd->regs =3D devm_ioremap
>       usb_add_hcd
>         hcd->driver->reset
>           ohci_pci_reset                                # <--
>
> So I suspect:
>
>   - BAR contains 0x20000000 initially (for example)
>
>   - pci_bus_assign_resources() inserts 0x20000000-0x20007fff in
>     iomem_resource
>
>   - final quirk updates res->start, so resource is now
>     0x20001000-0x20007fff
>
>   - OHCI driver binds and sees 0x20001000-0x20007fff
>
>   - OHCI driver requests 0x20001000-0x20007fff (28KB)
>
>   - OHCI may only use 4KB, but AFAICS it actually reserves the entire
>     resource[0], which is now only 28KB
>
>   - BAR still contains 0x20000000 ("lspci -b" should confirm this)
>
>   - /proc/iomem contains something like this:
>
>       20001000-20007fff 0000:3e:00.0
>         20001000-20007fff ohci-hcd
>
> Now the device still responds to accesses at 0x20000000 because that's
> what's in the BAR, but the kernel doesn't know that anybody is using
> the 0x20000000-0x20000fff region.
>
> I think the best solution would be to add an entry in
> ohci_pci_quirks[] that bumps hcd->regs up by 0x1000.  Then we wouldn't
> have to touch the struct resource, it would stay 32KB, and it would
> accurately reflect the hardware.
OK, let me try this way, thanks.

Huacai
>
> If that doesn't work, I guess you could also make this a *header*
> fixup instead of a final one.  Then we would at least update the
> resource before inserting it in iomem_resource.  But I don't like it
> because the device still responds to an area not mentioned in
> iomem_resource, and the resource is now 28KB, which is an illegal size
> for a PCI BAR.
>
> > > > +}
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_OHCI, loo=
ngson_ohci_quirk);

