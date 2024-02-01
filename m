Return-Path: <linux-pci+bounces-2955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E11845F98
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DD11C28593
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06A88527C;
	Thu,  1 Feb 2024 18:10:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004912FB05;
	Thu,  1 Feb 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811042; cv=none; b=H5NT471wBlpX4FR34nVXhHV1Qton3FCVZrBamA9LyJUa/0tTjDO2h35EfHY+kPDJUM7ePZyvcHY4ZejCbE6GfEzqmAwMeqJpQrWwZOZYxK7mnQ87q/PLo25CoC+0b5RzgZnelUEQHhVwK7v0pjTgQDk/0DBHM24R/UN582AruFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811042; c=relaxed/simple;
	bh=dNRmWLW4qsaW4MOpb+pEVEKn4Tx40C4u33xEP6L33ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8NzgCZg0cZ6ZwFUoMQt8Of4E0njZycQH9J3sfRFb1qm4j9SSAeGBr0QiS6xS5e0B2Q2gRkM01acnIIoogL+7tA11IQ+Nf8EXEWCiPcpgPdyfv/7YuQzaEuK8U0n1bMAvZp2l9G892QKN6NEqCluLpM5jQr3Nja0b6Lk8kDy3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3be2ba0ffd8so165092b6e.0;
        Thu, 01 Feb 2024 10:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811040; x=1707415840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7K2m1hjkCVzp42ssBbLht83KsIxMJIS717mDSy4hWI=;
        b=Ea+CSqkJza18DzkVs56PzokWhnV4mQxxhjlHhs2LhhRJt9taK0ELNYI+l7AXXSh7HQ
         mLOAUc33Ul6UluF2A8u7utLENr31FNSPvkH/+en53jsbBHcViJJHOfgvvz+B3aZIQ6L/
         jp/zcLfAE5YUz2jZtzVqJHFctcnEvbXdHTRziAdzINtVLVOqX+Z9v762+q89FQYeKth7
         TKqEIXdRD3QyIoalsIcPfjIOzhIVbNy/vt69zPAjau/YL0U5ASCdXkAsBvCTfvHR+pkR
         NG/o7iQ6iAAD8BsAJX4MuyUyYMxYsXY8m7E2+2csCWO/IIMdetwOVXlbgMbjA14Y+MM8
         Hd3Q==
X-Gm-Message-State: AOJu0YzThAUKPyNkXdcbE+KzKx8zwp5r18epDi7Hr2Y9U2F3TdO73zKO
	qPgdI2YoMavoj1mUelljpNvIx3wJM5IAl5zaG1IaTL68G0ib4BYnNnNGKIg/eOMj3R9VVJqn7tl
	iErPEiMaZmkmEIdy208vg4OyMzx0=
X-Google-Smtp-Source: AGHT+IGhgYJn6KsHi/QptCtDQVi4EiETT3Ordm1Cq+9U5IBgGQtd4dFzNprS6Moq70ompSbbd8eAwusq2WaBH+MGmvk=
X-Received: by 2002:a05:6870:828a:b0:218:d68f:fe29 with SMTP id
 q10-20020a056870828a00b00218d68ffe29mr3483142oae.3.1706811039953; Thu, 01 Feb
 2024 10:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
 <CAJZ5v0j6Veze8xDFKTbVZ5=WAfmLdeJ8NXRnh9kwCZgyaDdgew@mail.gmail.com> <ZbiQ/tO/odnJCBD1@sunil-laptop>
In-Reply-To: <ZbiQ/tO/odnJCBD1@sunil-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 19:10:28 +0100
Message-ID: <CAJZ5v0gnH0uPEM0q9VzJOg2Z_7bOP9XdQbOttpRtnkLGej45Sw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] RISC-V: ACPI: Add external interrupt
 controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:02=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Tue, Dec 19, 2023 at 06:50:19PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Dec 19, 2023 at 6:45=E2=80=AFPM Sunil V L <sunilvl@ventanamicro=
.com> wrote:
> > >
> > > This series adds support for the below ECR approved by ASWG.
> > > 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsI=
Kia7zR/view?usp=3Dsharing
> > >
> > > The series primarily enables irqchip drivers for RISC-V ACPI based
> > > platforms.
> > >
> > > The series can be broadly categorized like below.
> > >
> > > 1) PCI ACPI related functions are migrated from arm64 to common file =
so
> > > that we don't need to duplicate them for RISC-V.
> > >
> > > 2) Introduced support for fw_devlink for ACPI nodes for IRQ dependenc=
y.
> > > This helps to support deferred probe of interrupt controller drivers.
> > >
> > > 3) Modified pnp_irq() to try registering the IRQ  again if it sees it=
 in
> > > disabled state. This solution is similar to how
> > > platform_get_irq_optional() works for regular platform devices.
> > >
> > > 4) Added support for re-ordering the probe of interrupt controllers w=
hen
> > > IRQCHIP_ACPI_DECLARE is used.
> > >
> > > 5) ACPI support added in RISC-V interrupt controller drivers.
> > >
> > > This series is based on Anup's AIA v11 series. Since Anup's AIA v11 i=
s
> > > not merged yet and first time introducing fw_devlink, deferred probe =
and
> > > reordering support for IRQCHIP probe, this series is still kept as RF=
C.
> > > Looking forward for the feedback!
> > >
> > > Changes since RFC v2:
> > >         1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> > >         2) Dropped patches in drivers which are not required due to
> > >            fw_devlink support.
> > >         3) Dropped pci_set_msi() patch and added a patch in
> > >            pci_create_root_bus().
> > >         4) Updated pnp_irq() patch so that none of the actual PNP
> > >            drivers need to change.
> > >
> > > Changes since RFC v1:
> > >         1) Abandoned swnode approach as per Marc's feedback.
> > >         2) To cope up with AIA series changes which changed irqchip d=
river
> > >            probe from core_initcall() to platform_driver, added patch=
es
> > >            to support deferred probing.
> > >         3) Rebased on top of Anup's AIA v11 and added tags.
> > >
> > > To test the series,
> > >
> > > 1) Qemu should be built using the riscv_acpi_b2_v8 branch at
> > > https://github.com/vlsunil/qemu.git
> > >
> > > 2) EDK2 should be built using the instructions at:
> > > https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/READM=
E.md
> > >
> > > 3) Build Linux using this series on top of Anup's AIA v11 series.
> > >
> > > Run Qemu:
> > > qemu-system-riscv64 \
> > >  -M virt,pflash0=3Dpflash0,pflash1=3Dpflash1,aia=3Daplic-imsic \
> > >  -m 2G -smp 8 \
> > >  -serial mon:stdio \
> > >  -device virtio-gpu-pci -full-screen \
> > >  -device qemu-xhci \
> > >  -device usb-kbd \
> > >  -blockdev node-name=3Dpflash0,driver=3Dfile,read-only=3Don,filename=
=3DRISCV_VIRT_CODE.fd \
> > >  -blockdev node-name=3Dpflash1,driver=3Dfile,filename=3DRISCV_VIRT_VA=
RS.fd \
> > >  -netdev user,id=3Dnet0 -device virtio-net-pci,netdev=3Dnet0 \
> > >  -kernel arch/riscv/boot/Image \
> > >  -initrd rootfs.cpio \
> > >  -append "root=3D/dev/ram ro console=3DttyS0 rootwait earlycon=3Duart=
8250,mmio,0x10000000"
> > >
> > > To boot with APLIC only, use aia=3Daplic.
> > > To boot with PLIC, remove aia=3D option.
> > >
> > > This series is also available in acpi_b2_v3_riscv_aia_v11 branch at
> > > https://github.com/vlsunil/linux.git
> > >
> > > Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
> > > (https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanam=
icro.com/)
> > >
> > > Sunil V L (17):
> > >   arm64: PCI: Migrate ACPI related functions to pci-acpi.c
> > >   RISC-V: ACPI: Implement PCI related functionality
> > >   PCI: Make pci_create_root_bus() declare its reliance on MSI domains
> > >   ACPI: Add fw_devlink support for ACPI fwnode for IRQ dependency
> > >   ACPI: irq: Add support for deferred probe in acpi_register_gsi()
> > >   pnp.h: Reconfigure IRQ in pnp_irq() to support deferred probe
> > >   ACPI: scan.c: Add weak arch specific function to reorder the IRQCHI=
P
> > >     probe
> > >   ACPI: RISC-V: Implement arch function to reorder irqchip probe entr=
ies
> > >   irqchip: riscv-intc: Add ACPI support for AIA
> > >   irqchip: riscv-imsic: Add ACPI support
> > >   irqchip: riscv-aplic: Add ACPI support
> > >   irqchip: irq-sifive-plic: Add ACPI support
> > >   ACPI: bus: Add RINTC IRQ model for RISC-V
> > >   ACPI: bus: Add acpi_riscv_init function
> > >   ACPI: RISC-V: Create APLIC platform device
> > >   ACPI: RISC-V: Create PLIC platform device
> > >   irqchip: riscv-intc: Set ACPI irqmodel
> >
> > JFYI, I have no capacity to provide any feedback on this till 6.8-rc1 i=
s out.
> >
> Hi Rafael,
>
> Gentle ping.
>
> Could you please provide feedback on the series? Patches 4, 5, 6, 7 and
> 8 are bit critical IMO. So, I really look forward for your and other
> ACPI experts!.

There was quite a bit of discussion on patch [6/21] and it still seems
relevant to me.

ACPI actually has a way to at least indicate what the probe ordering
should be which is _DEP.

The current handling of _DEP in the kernel may not be covering this
particular use case, but I would rather extend it (if necessary)
instead of doing all of the -EPROBE_DEFER dance which seems fragile to
me.

Thanks!

