Return-Path: <linux-pci+bounces-9217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB2916417
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2126283EB3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581BD149C58;
	Tue, 25 Jun 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="bpeeSqJe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6E14B078
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309214; cv=none; b=WZSJi1XajDilht2yitEGsuQb2Ll4ZHYYUceQ2cP/hmIzFENxxZS+GxQ0slw80OcY5qfijPPr1WA8FDhafajOBYuUDA51aszuR08wTgsyiKA0GhKgCKcFFsYgg1OSv5cuYX/Af0F57At5bQs3tBVd/PXaDNRf/soO0iQyWith4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309214; c=relaxed/simple;
	bh=ubR/H1KDCHv15kc/h4bzN7goNlGoi7nGu28lfBNp3Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnESHewInmhwsPZUWZ5wJniRKD/OXHOJrqD7EZDss0mzeaQZKMInYw6lYz1dMN4SqMAoDtPF8FkV9O6QgtjEclN59ezDPIHiAsE58mhm9W5m6sSrUcttRwxRBIfs1QqBy+K5Omsx/4L+l7R/n30bWQmRPCGOrJHaJGMBm+M48+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=bpeeSqJe; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dff305df675so5699658276.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719309211; x=1719914011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EihByteN8eLD7Off0+cCvYThY2zGPs4M5iPP7WdFRig=;
        b=bpeeSqJeQ8Hzivb6IONGfm5ATUEddu2vMP4yVC5YCiAnnPf27JBV6AY/M01YrIBF8Y
         9Hr++uVyO5zgXBsPTr2LtWQ4oCVJ5Bm7/jqSKRnOUGl0Rd9BSaiZ1GzUICAcwMUAt0KW
         ni/g9l8BaeIs6iXcPrmeqorPbekCZD2xVyNBewii5ZAQ5slZWwUYymzR9QV7Pk687RjO
         1efMNJNACKnzTFS2rS0+Umtw+Ny4icVU1abBPoPD9R/mB+lDHtZPBgVbdcGTNAAVngAW
         IB0H77jRV3W7HldaYthgkbzGQE/xPa1/cHRgkQvjT1aOFAqTAS7YBR47QV6ocIVY945f
         lMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309211; x=1719914011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EihByteN8eLD7Off0+cCvYThY2zGPs4M5iPP7WdFRig=;
        b=v9bI0d0kwaMWK0jnMVWwW8vQX9iQLj4s5r3AM4ODse9Yx0g9B+FG5C/auJOCkS9vRd
         czpbEb6GO15m8kriQpEofPDeKKsLUQFptoOxHjqdjXQPHIcJDkRJT8FD7TfwZ9wcTTRi
         fl9obyajbkJO7+PHd9hRrHz7xyqorCNmdiXHYWQtC66+78FMBMHkHLbqeCSYutBgBPYa
         25fcWNiAmn3rQ1PXrnKxY7B6FmemSqJQa9cS4Y6jqAcQ447wIdwjQDI+w4WVQX64BvZl
         Q9T09sA8I3fNaB6mr2DlUpI5YCtKUWLYOl5vx3DQnTzayMnVHgH3CZ7/W5CY4EDKNllz
         bp8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbPUOtHf3LdWVdM1uhe5VtFtVmLg2F2sqYPiYAyJlnGc3bbsXroY6Tf21egUvw4cvJAYRGqCjCL94ypnICrUnoGfK4SNLDiWA6
X-Gm-Message-State: AOJu0YxfaNy6jA9ss3lQoqCVCd1EygOvQ5oIJcc1Clk8yafDUmgd7sn2
	wslKuoa47EkwjCrG4aFN74sRLeo3uCKH+C1lxW3RuV590R3EVe0vP+oNuEgLi3wOt/bOy/dUcf9
	EVFQykT/BV8BgdPFfeEBFUDz3rXUD8d/8KVV2rw==
X-Google-Smtp-Source: AGHT+IFBvNR7MZObZFOvRvXTTt3kur5mv2a9F975t+24bwWHaJvhGsuWd44cQWKN/R/wtGYvxKswobQAqMrsxHtrU/4=
X-Received: by 2002:a25:c585:0:b0:dfa:6bfb:e19a with SMTP id
 3f1490d57ef6-e0303f753b3mr6901340276.39.1719309211199; Tue, 25 Jun 2024
 02:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624081108.10143-2-jhp@endlessos.org> <20240624082144.10265-2-jhp@endlessos.org>
 <20240624082458.00006da1@linux.intel.com>
In-Reply-To: <20240624082458.00006da1@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Tue, 25 Jun 2024 17:52:55 +0800
Message-ID: <CAPpJ_ee5e-wwOGJ9z+AaXbpDUkN_zZt3Q_BLcZTztW8aHcPSfg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: vmd: Drop resetting PCI bus action after scan
 mapped PCI child bus
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org, 
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nirmal Patel <nirmal.patel@linux.intel.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:25=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Mon, 24 Jun 2024 16:21:45 +0800
> Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the
> > PCIe Root Port and the child device, they should be programmed with
> > the same LTR1.2_Threshold value. However, they have different values
> > on VMD mapped PCI child bus. For example, Asus B1400CEAE's VMD mapped
> > PCI bridge and NVMe SSD controller have different LTR1.2_Threshold
> > values:
> >
> > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
> > PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
> >     Capabilities: [200 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > L1_PM_Substates+ PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50=
us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                  T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> >         L1SubCtl2: T_PwrOn=3D50us
> >
> > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> > SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
> >     Capabilities: [900 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+ PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10=
us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >         L1SubCtl2: T_PwrOn=3D10us
> >
> > After debug in detail, both of the VMD mapped PCI bridge and the NVMe
> > SSD controller have been configured properly with the same
> > LTR1.2_Threshold value. But, become misconfigured after reset the VMD
> > mapped PCI bus which is introduced from commit 0a584655ef89 ("PCI:
> > vmd: Fix secondary bus reset for Intel bridges") and commit
> > 6aab5622296b ("PCI: vmd: Clean up domain before enumeration"). So,
> > drop the resetting PCI bus action after scan VMD mapped PCI child bus.
> >
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v6:
> > - Introduced based on the discussion
> > https://lore.kernel.org/linux-pci/CAPpJ_efYWWxGBopbSQHB=3DY2+1RrXFR2XWe=
qEhGTgdiw3XX0Jmw@mail.gmail.com/
> >
> >  drivers/pci/controller/vmd.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index 5309afbe31f9..af413cdb4f4e 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -793,7 +793,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > unsigned long features) resource_size_t offset[2] =3D {0};
> >       resource_size_t membar2_offset =3D 0x2000;
> >       struct pci_bus *child;
> > -     struct pci_dev *dev;
> >       int ret;
> >
> >       /*
> > @@ -935,25 +934,6 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features) pci_scan_child_bus(vmd->bus);
> >       vmd_domain_reset(vmd);
> >
> > -     /* When Intel VMD is enabled, the OS does not discover the
> > Root Ports
> > -      * owned by Intel VMD within the MMCFG space.
> > pci_reset_bus() applies
> > -      * a reset to the parent of the PCI device supplied as
> > argument. This
> > -      * is why we pass a child device, so the reset can be
> > triggered at
> > -      * the Intel bridge level and propagated to all the children
> > in the
> > -      * hierarchy.
> > -      */
> > -     list_for_each_entry(child, &vmd->bus->children, node) {
> > -             if (!list_empty(&child->devices)) {
> > -                     dev =3D list_first_entry(&child->devices,
> > -                                            struct pci_dev,
> > bus_list);
> > -                     ret =3D pci_reset_bus(dev);
> > -                     if (ret)
> > -                             pci_warn(dev, "can't reset device:
> > %d\n", ret); -
> > -                     break;
> > -             }
> > -     }
> > -
> >       pci_assign_unassigned_bus_resources(vmd->bus);
> >
> >       pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
>
> Thanks for the patch.
>
> pci_reset_bus is required to avoid failure in vmd domain creation
> during multiple soft reboots test. So I believe we can't just remove
> it without proper testing. vmd_pm_enable_quirk happens after
> pci_reset_bus, then how is it resetting LTR1.2_Threshold value?

uh!  I mean that drop pci_reset_bus(dev) after pci_scan_child_bus(vmd->bus)
Not pci_walk_bus() with vmd_pm_enable_quirk.

Jian-Hong Pan


Jian-Hong Pan

