Return-Path: <linux-pci+bounces-9219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C3916546
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70683283FAF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105D14A4EB;
	Tue, 25 Jun 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="PXzkzbKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786614A09F
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311553; cv=none; b=JNYm0AZy1wzL0bH8hFSjfUL8BvkErkKHrqp6/9fygRrSOmUxx5m9qOdJoWqScSXBcCd6r9c5A54dutzN3X5vCRWzSVPrjxlgo+e84BQse4YgsMayFWfoGCdsYQVarVZW9jDNg5ZMsgk+V/3uKUs4iISlFSEFaQFkaI1h3/Q+wHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311553; c=relaxed/simple;
	bh=yexphHRNlx1HBIakVGghbz9IQgLRz7EgKahrZP3O3Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8nJP2g0eu056J6Z3ub/TNiaOFoIoqZFImOEbIkw9Ghd233SWjQYFhrxEVJwKs2a9ATaIKafw7DmTgPf5ypk7gqT1Awo4FBa2wmkEmJwiuSfW3mt1toVEML8WV3KRlvQ08sgKYmvhzv30htMnlcboTSJVCvfmxLpULHqskjnvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=PXzkzbKK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-63127fc434aso43080037b3.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719311550; x=1719916350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeHhF7HwElqfhWVKAUpUcxv4NHbXbC1N1cEo/E0Fnrs=;
        b=PXzkzbKKHqPZdbiGEA7NhzF+xqwu/aqw90JmvtW8A/Bl3xpLInrvlz6E2hfWTNuv7B
         E2MpRizGbxzx+cF2LwBo44Ng6ApfC6fy0U+PtpDxgxHLtkYbnTzZEmAlUfCdw5e1WkOH
         A36qheUArMp82t5Srd9/lRd0cNkXfvHNeFpwlIfW/Z5diDAj56K5XQTq8mH3cz8FmNUK
         00DoPPx+1fgkjHlAcaqGg/wVEl5q9BNRER/r2AY7nsYQvG4IXsLnuRfkBrPcU7O1nEJP
         VNV+yAOsV/c1KNyc6g+1dgkQqM9GyCs9AVoUQ7nLfWybSLOeP0NnxveBVn9sF5CPPwjU
         j92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719311550; x=1719916350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeHhF7HwElqfhWVKAUpUcxv4NHbXbC1N1cEo/E0Fnrs=;
        b=jOw29N0h51/O5c/hKmMLwwiYCJ+JuQ8QwAb+xYhUkgHDmFOszxhjKtJQIHsGy8oCMn
         zijLAzBnn4FaL2SWLL1iTyQrmfOP0n4Ez11vwC7P/uLYGddrUm5NE0qZaPWHxlPFRElX
         +7Wx2ihcFqD9Slvv/MsVPjLdqMmMuGwDG6fme/xm/niP4iaHwv3LJcNE/+azHiqMkW50
         Cfy0/X8yeLTDsAJsez7zAJfXtTJMGoc5ESH6hx6JfkkLziPpgeP6R9Oo8EWHrvw07hOr
         85yU4ke8/ZGT52iikBjbAPIiHvjeM1rPHR9a7yU8ZoKZ03TEJRfm5ODrBzri+24Q+/me
         KRIw==
X-Forwarded-Encrypted: i=1; AJvYcCU03e0ZLnsV2TuGjp/nkIuzVFK3cq1dbOUhFMtaUIPNvWy9eW75sAE2WrameruucEJhJvacGSgi5UhH0swEubOvi2iHPZxrZE+R
X-Gm-Message-State: AOJu0YzUkB/TOtGkqiFi17FMYKUKtEuL+Ha+Yiez0yO5bplE6MhCRyRx
	1HqgdZohPBCcRaRc4PbcYrCm7AO0kLuUwLv4eDVjAGdjVlxnRGrjAvjqOmu1A6nNAkACaicMPnV
	YJPmmm8BmEEuRt5fDARecePcD7yaAayiSmstVZw==
X-Google-Smtp-Source: AGHT+IET0vZmsrLZtS70AiPitaD9jDC/goMS3ehzZdEh8KQdRBnZS8rR4Rr5tG5J6ErER+1rbE0z36/BIhmk4qSGM7w=
X-Received: by 2002:a5b:892:0:b0:e02:45d6:6a4f with SMTP id
 3f1490d57ef6-e0303f6eacemr6088179276.36.1719311550054; Tue, 25 Jun 2024
 03:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624081108.10143-2-jhp@endlessos.org> <20240624082144.10265-2-jhp@endlessos.org>
 <20240624082458.00006da1@linux.intel.com> <897ead26-be10-4bb3-b085-1b8c97d93964@intel.com>
In-Reply-To: <897ead26-be10-4bb3-b085-1b8c97d93964@intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Tue, 25 Jun 2024 18:31:54 +0800
Message-ID: <CAPpJ_efs9nHrTx=N2NwtmN=py3CFg62izcgJrUkcMDd_ErR5VA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: vmd: Drop resetting PCI bus action after scan
 mapped PCI child bus
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com> =E6=96=BC 2024=E5=B9=B4=
6=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:39=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 6/24/2024 8:24 AM, Nirmal Patel wrote:
> > On Mon, 24 Jun 2024 16:21:45 +0800
> > Jian-Hong Pan <jhp@endlessos.org> wrote:
> >
> >> According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the
> >> PCIe Root Port and the child device, they should be programmed with
> >> the same LTR1.2_Threshold value. However, they have different values
> >> on VMD mapped PCI child bus. For example, Asus B1400CEAE's VMD mapped
> >> PCI bridge and NVMe SSD controller have different LTR1.2_Threshold
> >> values:
> >>
> >> 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
> >> PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
> >>      Capabilities: [200 v1] L1 PM Substates
> >>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> >> L1_PM_Substates+ PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D5=
0us
> >>          L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >>                 T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> >>          L1SubCtl2: T_PwrOn=3D50us
> >>
> >> 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> >> SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
> >>      Capabilities: [900 v1] L1 PM Substates
> >>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >> L1_PM_Substates+ PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D1=
0us
> >>          L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >>                     T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >>          L1SubCtl2: T_PwrOn=3D10us
> >>
> >> After debug in detail, both of the VMD mapped PCI bridge and the NVMe
> >> SSD controller have been configured properly with the same
> >> LTR1.2_Threshold value. But, become misconfigured after reset the VMD
> >> mapped PCI bus which is introduced from commit 0a584655ef89 ("PCI:
> >> vmd: Fix secondary bus reset for Intel bridges") and commit
> >> 6aab5622296b ("PCI: vmd: Clean up domain before enumeration"). So,
> >> drop the resetting PCI bus action after scan VMD mapped PCI child bus.
> >>
> >> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> >> ---
> >> v6:
> >> - Introduced based on the discussion
> >> https://lore.kernel.org/linux-pci/CAPpJ_efYWWxGBopbSQHB=3DY2+1RrXFR2XW=
eqEhGTgdiw3XX0Jmw@mail.gmail.com/
> >>
> >>   drivers/pci/controller/vmd.c | 20 --------------------
> >>   1 file changed, 20 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/vmd.c
> >> b/drivers/pci/controller/vmd.c index 5309afbe31f9..af413cdb4f4e 100644
> >> --- a/drivers/pci/controller/vmd.c
> >> +++ b/drivers/pci/controller/vmd.c
> >> @@ -793,7 +793,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> >> unsigned long features) resource_size_t offset[2] =3D {0};
> >>      resource_size_t membar2_offset =3D 0x2000;
> >>      struct pci_bus *child;
> >> -    struct pci_dev *dev;
> >>      int ret;
> >>
> >>      /*
> >> @@ -935,25 +934,6 @@ static int vmd_enable_domain(struct vmd_dev
> >> *vmd, unsigned long features) pci_scan_child_bus(vmd->bus);
> >>      vmd_domain_reset(vmd);
> >>
> >> -    /* When Intel VMD is enabled, the OS does not discover the
> >> Root Ports
> >> -     * owned by Intel VMD within the MMCFG space.
> >> pci_reset_bus() applies
> >> -     * a reset to the parent of the PCI device supplied as
> >> argument. This
> >> -     * is why we pass a child device, so the reset can be
> >> triggered at
> >> -     * the Intel bridge level and propagated to all the children
> >> in the
> >> -     * hierarchy.
> >> -     */
> >> -    list_for_each_entry(child, &vmd->bus->children, node) {
> >> -            if (!list_empty(&child->devices)) {
> >> -                    dev =3D list_first_entry(&child->devices,
> >> -                                           struct pci_dev,
> >> bus_list);
> >> -                    ret =3D pci_reset_bus(dev);
> >> -                    if (ret)
> >> -                            pci_warn(dev, "can't reset device:
> >> %d\n", ret); -
> >> -                    break;
> >> -            }
> >> -    }
> >> -
> >>      pci_assign_unassigned_bus_resources(vmd->bus);
> >>
> >>      pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
> >
> > Thanks for the patch.
> >
> > pci_reset_bus is required to avoid failure in vmd domain creation
> > during multiple soft reboots test. So I believe we can't just remove
> > it without proper testing. vmd_pm_enable_quirk happens after
> > pci_reset_bus, then how is it resetting LTR1.2_Threshold value?
> >
> > Thanks
> > -nirmal
>
> To follow up on what Nirmal said: why can't you set the threshold value
> in vmd_pm_enable_quirk() since we look at LTR there?

Looks like setting the threshold value again in vmd_pm_enable_quirk()
is the preferred direction?
If so, I can prepare for that in the next version patch.

Jian-Hong Pan

