Return-Path: <linux-pci+bounces-43469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC5FCD2F9B
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 14:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16F0C30038BC
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF722E3E7;
	Sat, 20 Dec 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha1Imwa5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3322A4CC
	for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766237112; cv=none; b=GkZUEm8dVkNmLoxcAx1w3/SDQAQi2HEO7hwvLEL5ITUpLE85sc07HB7B1xCY4sGbr8gS+coUh6OhoQyi7SuXYeQHzEEEu7BzobOXrOhv10vAUPXcSXBaq8Zm/O0O5BdgqsqgJn/+lXGzgN8ZBb0dMDqCDWLB61GcwDVDy6mGh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766237112; c=relaxed/simple;
	bh=EVLtq3EvLSTKl8Bx9CgjCqTlFIjmG+xy1nwCqsTDbrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/Efyy1SsgX3ldD6z666G57vmksf8nIuMIumyJVFUbeJi42kYkZN5WwrFQoej87fktJ5ZiSfwXR7Vlf/L1yVA4W8fxddINg0YXX7dAbi9fWPHumyYejTVZcaMMkUIL/2tb5za39ZCql6FJoLW2mXHFxP56mhoPDxDWykuBuWLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha1Imwa5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5957d7e0bf3so3132508e87.0
        for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 05:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766237109; x=1766841909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b0M4fusp4M8TwC+3lvPsPvDRWyNz+WF92fODAY27og=;
        b=ha1Imwa5jqmIlLujZ7avOZT0sjVI1tHKug49T0NHTdafLDiVlxCnlpNn+m/eT+jAbe
         ihB4XV4aYACCI8OXl03hPvs/lvK4k298B4coXtYjgX6z0mAH/QZov3uDpC0jmxBndCmC
         NYclWT8cPmVXfeBcrC5ia2qGeUutW5TRc1AsbNSuF1H8SnUfy2ZmLebh2HZkIc+einI/
         72RyrDUUwhJUAtLnxej+eaXx2/KQixP/I5vmAZjN2D8te5Zqt6LYfGhbPplTygy9BEtw
         cIdX/qo5gzOPLv0iTOMZFTHlFi91z8U2DSd/RpuXG4cmoFso3NFY07+TPVb1jlowd26U
         R2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766237109; x=1766841909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3b0M4fusp4M8TwC+3lvPsPvDRWyNz+WF92fODAY27og=;
        b=K1dwidVCtl50BXfjO0+A//LwLgVSqbWir1Add5vNsXUGdDAC0U2TOvHjrQJ97zr7Gf
         dEmzH9Tsjn6y2Ay/S13FSUUy1qdz+OOaxtpV8IdbX0ZoIFxTdE7kyntyjeD9j90MfpKM
         652LeIiq8PnvRzF323mbSzu9DF8+5lWr5kJ/zcnVQddUA57EaDMrl4MNxUIURphqkus1
         rNF2xSaFhIMW71abCLYk8qZkuQLK8Nj9bWNLf4FyDLfkG9DxFpUa7+A8h1NgrcqDrcqu
         Br16hezD9FntQpQOgcdjeuMsSIyWseX6MFrdhl0e+VyX3oSh2rKS3OpV3kD22D/WioxI
         nc/g==
X-Forwarded-Encrypted: i=1; AJvYcCUB1uv5QB10wUdOiluEEgba6PnJkysbu/k6cffXyRrjIr326VblNmMnAPgnomzCvEacM5BH4X3hZ9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3HWzWVawkXRlHj6cee7DG2IUmUUpBbo7SvbgTC95wQlAk1l6
	5KSaqSlEFVDiiWD77C0rU0lh8Oa7KVTKHQh99f6CmYTieKpoWs6ViZLXJc0sKRwSnOjvP1+MwZ3
	stvp1VbdcVN8W9AYaPa8nhFWQ1PFS5Z5BIA==
X-Gm-Gg: AY/fxX4tFzhmVA+Iv1EiHr6z2giLoR11cbvV1UfKhasYvUPzTbQSQFyUP919hNO0kGt
	5rTCEeQtrCmnfnPH+yTwxuKmfXIMxfezRQnZrqse3r0cTXg2dTS4jPjvJu2yjqGui8ivKrK6NBT
	2kRrChEDHlFMVAxBD4NVf2hlvIkYeoj8TjvXsZSGMX/5fkznI54lMcxPqMXmniC/4buxiFFABRC
	iYi7RJGoFnumG3V278x2Qqnsb2cUlVusJgRE4RvvVCX9crpzusg2ws4bc5Bdm9Ga4jYkY5CoSs5
	e9Kb8pk=
X-Google-Smtp-Source: AGHT+IGPcvp6fW/TUruAB977dCAs0N1AZzF3yRbKDGcbSmIfEy45oEg5nlHbJP3YYyMlqgMPqEvRU6R52LtRcG3Csv4=
X-Received: by 2002:a05:651c:1542:b0:37e:6dd5:2e3b with SMTP id
 38308e7fff4ca-381207761eamr22258141fa.5.1766237108703; Sat, 20 Dec 2025
 05:25:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
 <20251215045203.13d96d09.alex@shazbot.org> <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
 <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
 <20251219170637.2c161b7b.alex@shazbot.org> <CAHP4M8Ud_tm+SPmZtnSi1--zf=MTsbvSqDYdAfPdAXUj+Ormkg@mail.gmail.com>
In-Reply-To: <CAHP4M8Ud_tm+SPmZtnSi1--zf=MTsbvSqDYdAfPdAXUj+Ormkg@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sat, 20 Dec 2025 18:54:56 +0530
X-Gm-Features: AQt7F2ozfyOfOGjyPn74d-8hfCl7Xro1Z8pjLNJPv5fWJeElxisiOGYPXqkXKTY
Message-ID: <CAHP4M8WZULK3t8-hTSB7ANsUohyBD1tLqdPE+FgeR2h6-yfsww@mail.gmail.com>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
To: Alex Williamson <alex@shazbot.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, iommu@lists.linux-foundation.org, 
	linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is guest-acpi-mcfg/mmconfig tables the answer to my last question? :)

i.e. qemu-bios setting up acpi mcfg / mmconfig addresses, which are
backed by mmap'ed pci-config-space mappings on the host (while also
setting up ept-mappings for pci-config-space too)?


On Sat, Dec 20, 2025 at 6:22=E2=80=AFPM Ajay Garg <ajaygargnsit@gmail.com> =
wrote:
>
> Thanks Alex.
>
> I was/am aware of GPA-ranges backed by mmap'ed HVA-ranges.
> On further thought, I think I have all the missing pieces (except one,
> as mentioned at last in current email).
>
> I'll list the steps below :
>
> a)
> There are three stages :
>
>    * pre-configuration by host/qemu.
>    * guest-vm bios.
>    * guest-vm kernel.
>
> b)
> Host procures following memory-slots (amongst others) via mmap :
>
>   * guest-ram
>   * pci-config-space       : via vfio's ioctls' help.
>   * pci-bar-mmio-space : via vfio's ioctls' help.
>
> For the above memory-slots,
>
> *
> guest-ram physical-address is known (0), so ept-mappings for guest-ram
> are set up even before guest-vm begins to boot up.
>
> *
> there is no concept of guest-physical-address for pci-config-space.
>
> *
> pci-bar-mmio-space physical address is not known yet, so ept-mappings
> for pci-bar-mmio-space are not set up (yet).
>
> c)
> qemu starts the guest, and guest-vm-bios runs next.
>
> This bios is "owned by qemu", and is "definitely different" from the
> host-bios (qemu is an altogether different "hardware"). qemu-bios and
> host-bios handle pci bus/enumeration "completely differently".
>
> When the pci-enumeration runs during this guest-vm-bios stage, it
> accesses the pci-device config-space (backed on the host by mmap'ed
> mappings). Note that guest-kernel is still not in picture.
>
> "OBVIOUSLY", all accesses (reads/writes) to pci-config space go to the
> pci-config-space memory-slot (handled purely by qemu-bios code).
>
> Once the guest-vm bios carves out guest-physical-addresses for the
> pci-device-bars, it programs the bars by writing to bars-offsets in
> the pci-config-space. qemu detects this, and does the following :
>
>    * does not relay the actual-writes to physical bars on the host.
>    * since the bar-guest-physical-addresses are now known, so now the
> missing ept-mappings
>      for pci-bar-mmio-space are now set up.
>
> d)
> Finally, guest-kernel takes over, and
>
>    * all accesses to ram go through vanilla two-stages translation.
>    * all accesses to pci-bars-mmio go through vanilla two-stages translat=
ion.
>
>
> Requests :
>
> i)
> Alex / QEMU-experts : kindly correct me if I am wrong :) till now.
>
> ii)
> Once kernel boots up, how are accesses to pci-config-space handled? Is
> again qemu-bios involved in pci-config-space accesses after
> guest-kernel has booted up?
>
>
> Once again, many thanks to everyone for their time and help.
>
> Thanks and Regards,
> Ajay
>
>
> On Sat, Dec 20, 2025 at 5:36=E2=80=AFAM Alex Williamson <alex@shazbot.org=
> wrote:
> >
> > On Fri, 19 Dec 2025 11:53:56 +0530
> > Ajay Garg <ajaygargnsit@gmail.com> wrote:
> >
> > > Hi Alex.
> > > Kindly help if the steps listed in the previous email are correct.
> > >
> > > (Have added qemu mailing-list too, as it might be a qemu thing too as
> > > virtual-pci is in picture).
> > >
> > > On Mon, Dec 15, 2025 at 9:20=E2=80=AFAM Ajay Garg <ajaygargnsit@gmail=
.com> wrote:
> > > >
> > > > Thanks Alex.
> > > >
> > > > So does something like the following happen :
> > > >
> > > > i)
> > > > During bootup, guest starts pci-enumeration as usual.
> > > >
> > > > ii)
> > > > Upon discovering the "passthrough-device", guest carves the physica=
l
> > > > MMIO regions (as usual) in the guest's physical-address-space, and
> > > > starts-to/attempts to program the BARs with the
> > > > guest-physical-base-addresses carved out.
> > > >
> > > > iii)
> > > > These attempts to program the BARs (lying in the
> > > > "passthrough-device"'s config-space), are intercepted by the
> > > > hypervisor instead (causing a VM-exit in the interim).
> > > >
> > > > iv)
> > > > The hypervisor uses the above info to update the EPT, to ensure GPA=
 =3D>
> > > > HPA conversions go fine when the guest tries to access the PCI-MMIO
> > > > regions later (once gurst is fully booted up). Also, the hypervisor
> > > > marks the operation as success (without "really" re-programming the
> > > > BARs).
> > > >
> > > > v)
> > > > The VM-entry is called, and the guest resumes with the "impression"
> > > > that the BARs have been "programmed by guest".
> > > >
> > > > Is the above sequencing correct at a bird's view level?
> >
> > It's not far off.  The key is simply that we can create a host virtual
> > mapping to the device BARs, ie. an mmap.  The guest enumerates emulated
> > BARs, they're only used for sizing and locating the BARs in the guest
> > physical address space.  When the guest BAR is programmed and memory
> > enabled, the address space in QEMU is populated at the BAR indicated
> > GPA using the mmap backing.  KVM memory slots are used to fill the
> > mappings in the vCPU.  The same BAR mmap is also used to provide DMA
> > mapping of the BAR through the IOMMU in the legacy type1 IOMMU backend
> > case.  Barring a vIOMMU, the IOMMU IOVA space is the guest physical
> > address space.  Thanks,
> >
> > Alex

