Return-Path: <linux-pci+bounces-2759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B08A841BB5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 07:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92833B24325
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB109381DF;
	Tue, 30 Jan 2024 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cAXOg7gq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9DC381B9
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594572; cv=none; b=h5clyxhnO1NuuwinTitHRfVKoLo3d95mjE9CX3YfP9VBAKDMA6KX4O6BTmsTAyCJKIqQeNDv0Hg51b9pMhTEk82WQFiC8UY3VrKQgnXk/Y3WJGTsks6A864tmnO+qWWs/6LHyrX0BoftX6nmPtwKT2ZvKgMa4wmmUc3AOS2MI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594572; c=relaxed/simple;
	bh=4br/Ua+azXBzhdQ97Yt9a8Dsc3D0lJpwdMuxGOCCxsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxW6AT/axqglMYVVjCo3yLkSJrJvaANivzhhCjzsP0ETbBpy3Y0jxzS39mvBzfOLNWTUDSEiiN5O/6BWW/0eWaBqy55qOQJBeP1MIvyp6fd6czPxVoIdpitPddt6PfItiJUHwDeW+YST6FWgqw7WoRKH29/sXS4J0Qxkcx7JWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cAXOg7gq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2954b34ddd0so1623760a91.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 22:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706594569; x=1707199369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xWLJZhOYSryL+JD6+g86jHbcKwp+hE7AslVqd+M2GlQ=;
        b=cAXOg7gqybiL+GoOLKYne/mRhyLa96mmj6WVFMAP8odP/b6sU6CsqNIMPoTUhPFfvO
         9scK/3o6PDJJK2tAkPHEUrJhzPmnuIZbqYPF4wACBHxkRmOO+UQCoxhF00q7OXZr39E5
         Q/mF/vEVsYfkUmLOiwHgX1jnt8lP1kaecYqBiWQOiBvdEOTILZSALBubXwubqTzfSMDF
         PGBNiDQ2yj4h33oLFoG+lcvHELai1f+zU1qb7eaJw4XWlxYu0upUveVBINKQNj06m90+
         QJ0xo7ZLZ3fhDO1yGInJn659H7oKJYwTYKOhsPEC5CsoHHSmhVQ+R3zkbAT8DSd3fb1D
         nFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706594569; x=1707199369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWLJZhOYSryL+JD6+g86jHbcKwp+hE7AslVqd+M2GlQ=;
        b=WT3NjQ4bSiyh61seRqQQAZT+qTHyBmVUK7ZTAuMQrKl0ToPYez/rB5GS30CpB+4j1S
         4505ftIErOA4OCl423C+t8d+VP/LYR52k1FjwlGTNIm/07BdJ3b+hfQTQPUI0KjqhuYV
         cJafVxfqX8XdW2wXy3mp7nt1VzfGm/+IzExkgAv7JOb8A5SCWdMz+bmsOOrsxT4SW8xe
         2r2FCBcF5aJTktQppSuc781M734kSKMPkWoMcg82qitlRXZbUAs7bUSlnRW/4140IY5o
         co8hMXJ+2UkxtEUtZlEDr7bx0JTJ5TRQL1QWyk73EaRFRn869024/R+Ev3xc8w4s6W9+
         x3EQ==
X-Gm-Message-State: AOJu0YyVXHlz5IBqjy0J5XzGUd3sfpyGtrGz+5tXfBmGb+vsTg1nl6Nl
	TX/D8f/AKJt2NG8IYEAGF3UmiSSWEkCEZ16ArTxboKwSWPqk+KD+IZ0lXV2zhjA=
X-Google-Smtp-Source: AGHT+IFKZAHGBi+fEdW2P5cUvSK/6ac2dz3pUpO8dYb7X5Yq8/JiJKtWenAEAb33oYqNI300DuJRkg==
X-Received: by 2002:a17:90a:9284:b0:294:97c1:b58f with SMTP id n4-20020a17090a928400b0029497c1b58fmr5078955pjo.9.1706594568825;
        Mon, 29 Jan 2024 22:02:48 -0800 (PST)
Received: from sunil-laptop ([106.51.190.212])
        by smtp.gmail.com with ESMTPSA id n17-20020a17090ade9100b00295b45b7e5fsm151060pjv.1.2024.01.29.22.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 22:02:48 -0800 (PST)
Date: Tue, 30 Jan 2024 11:32:38 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v3 00/17] RISC-V: ACPI: Add external interrupt
 controller support
Message-ID: <ZbiQ/tO/odnJCBD1@sunil-laptop>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
 <CAJZ5v0j6Veze8xDFKTbVZ5=WAfmLdeJ8NXRnh9kwCZgyaDdgew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j6Veze8xDFKTbVZ5=WAfmLdeJ8NXRnh9kwCZgyaDdgew@mail.gmail.com>

On Tue, Dec 19, 2023 at 06:50:19PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 19, 2023 at 6:45 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > This series adds support for the below ECR approved by ASWG.
> > 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> >
> > The series primarily enables irqchip drivers for RISC-V ACPI based
> > platforms.
> >
> > The series can be broadly categorized like below.
> >
> > 1) PCI ACPI related functions are migrated from arm64 to common file so
> > that we don't need to duplicate them for RISC-V.
> >
> > 2) Introduced support for fw_devlink for ACPI nodes for IRQ dependency.
> > This helps to support deferred probe of interrupt controller drivers.
> >
> > 3) Modified pnp_irq() to try registering the IRQ  again if it sees it in
> > disabled state. This solution is similar to how
> > platform_get_irq_optional() works for regular platform devices.
> >
> > 4) Added support for re-ordering the probe of interrupt controllers when
> > IRQCHIP_ACPI_DECLARE is used.
> >
> > 5) ACPI support added in RISC-V interrupt controller drivers.
> >
> > This series is based on Anup's AIA v11 series. Since Anup's AIA v11 is
> > not merged yet and first time introducing fw_devlink, deferred probe and
> > reordering support for IRQCHIP probe, this series is still kept as RFC.
> > Looking forward for the feedback!
> >
> > Changes since RFC v2:
> >         1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> >         2) Dropped patches in drivers which are not required due to
> >            fw_devlink support.
> >         3) Dropped pci_set_msi() patch and added a patch in
> >            pci_create_root_bus().
> >         4) Updated pnp_irq() patch so that none of the actual PNP
> >            drivers need to change.
> >
> > Changes since RFC v1:
> >         1) Abandoned swnode approach as per Marc's feedback.
> >         2) To cope up with AIA series changes which changed irqchip driver
> >            probe from core_initcall() to platform_driver, added patches
> >            to support deferred probing.
> >         3) Rebased on top of Anup's AIA v11 and added tags.
> >
> > To test the series,
> >
> > 1) Qemu should be built using the riscv_acpi_b2_v8 branch at
> > https://github.com/vlsunil/qemu.git
> >
> > 2) EDK2 should be built using the instructions at:
> > https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
> >
> > 3) Build Linux using this series on top of Anup's AIA v11 series.
> >
> > Run Qemu:
> > qemu-system-riscv64 \
> >  -M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic \
> >  -m 2G -smp 8 \
> >  -serial mon:stdio \
> >  -device virtio-gpu-pci -full-screen \
> >  -device qemu-xhci \
> >  -device usb-kbd \
> >  -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
> >  -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
> >  -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
> >  -kernel arch/riscv/boot/Image \
> >  -initrd rootfs.cpio \
> >  -append "root=/dev/ram ro console=ttyS0 rootwait earlycon=uart8250,mmio,0x10000000"
> >
> > To boot with APLIC only, use aia=aplic.
> > To boot with PLIC, remove aia= option.
> >
> > This series is also available in acpi_b2_v3_riscv_aia_v11 branch at
> > https://github.com/vlsunil/linux.git
> >
> > Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
> > (https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro.com/)
> >
> > Sunil V L (17):
> >   arm64: PCI: Migrate ACPI related functions to pci-acpi.c
> >   RISC-V: ACPI: Implement PCI related functionality
> >   PCI: Make pci_create_root_bus() declare its reliance on MSI domains
> >   ACPI: Add fw_devlink support for ACPI fwnode for IRQ dependency
> >   ACPI: irq: Add support for deferred probe in acpi_register_gsi()
> >   pnp.h: Reconfigure IRQ in pnp_irq() to support deferred probe
> >   ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
> >     probe
> >   ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
> >   irqchip: riscv-intc: Add ACPI support for AIA
> >   irqchip: riscv-imsic: Add ACPI support
> >   irqchip: riscv-aplic: Add ACPI support
> >   irqchip: irq-sifive-plic: Add ACPI support
> >   ACPI: bus: Add RINTC IRQ model for RISC-V
> >   ACPI: bus: Add acpi_riscv_init function
> >   ACPI: RISC-V: Create APLIC platform device
> >   ACPI: RISC-V: Create PLIC platform device
> >   irqchip: riscv-intc: Set ACPI irqmodel
> 
> JFYI, I have no capacity to provide any feedback on this till 6.8-rc1 is out.
> 
Hi Rafael,

Gentle ping.

Could you please provide feedback on the series? Patches 4, 5, 6, 7 and
8 are bit critical IMO. So, I really look forward for your and other
ACPI experts!.

Thanks!
Sunil

