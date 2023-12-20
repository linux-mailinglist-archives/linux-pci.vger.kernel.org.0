Return-Path: <linux-pci+bounces-1200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D3281975E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 04:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8131C20ED6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD68F66;
	Wed, 20 Dec 2023 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TRi5q9lD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B015ADB
	for <linux-pci@vger.kernel.org>; Wed, 20 Dec 2023 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b7fc0e4a4dso36824339f.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 19:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703044184; x=1703648984; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cV23V7TOvb67CyEBq2y7tG+sTh2KHoQeq84YdzqhXCE=;
        b=TRi5q9lDJZdfAvtKFYNNTleePu2PoxvqaQK4mpAkJLU9znxosjXHvMmfMxx3Ejlmca
         pvB+tPF+c8YyQ71i0Et++snbh3hCO1Kft8jbif26EcWgiKgamHvIi0o0G1UGeA2NJIef
         u66nUB+G4Mc7Y+W57xBfd54rBOckBAY+dQ+xv3byLrMryRpPWLT8PIrPKEQhzB0/SkAV
         3h5eSbwgJNSH+AC6z94xMsOyjoUrwL33GpsABs/x3Xk8mGN2OnD9BhWjwsLxPfSrpRGw
         ybnYSNg9T5bRELx4pK9CWWNJalLxSNF+t1jMI2ZIuY6Yog08AaNk8iKruj5WMY0QfPg1
         7EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044184; x=1703648984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cV23V7TOvb67CyEBq2y7tG+sTh2KHoQeq84YdzqhXCE=;
        b=hgmuRkN1RTsVNSGHTwkch2eZMoKVgPC5+bj1MUlnezoq4k3BKs8Ks0ww0o6DWXd1BI
         sjpxt0nQ30ah0Mb51kkwZ8l5YJSQHZOsORPp2KzIdEu7Q5k2QedKw++emlpE4nOzMmA+
         uYRS/urVxEQj6dRqmHmpKTjstJ1z0iq8addT60dc5Ma/hfrKlbvx+bKIZnmWtCd8D7Sw
         5GvjuSwJq6tRtJ5Ty8nIOOkTxG+WJXaZ/Z6dOmKZvMwyvxSoxllZvMt2pxkHFyQCK5Ks
         X+ToyBG5UsvGMmObWAaDcZJfOE3y4FpCfipvlaPsDcRZPdxpYvWmchWijRoiU0CZfii8
         L/Hw==
X-Gm-Message-State: AOJu0YyNgsc4uAy/iR7UoTLFuj2qeQ6gPsSDPvSSNHHYVEDAmR30Lynu
	hk8AkWGk0aRgobKVSDG/o2OGyA==
X-Google-Smtp-Source: AGHT+IEFtaaGYdqONj8ZBQy1SsSMrvVpJouh1AF9l/WyoqOfDMdwX1NJFUbBjCx+mCqU4PqT2OUdiA==
X-Received: by 2002:a6b:7f0c:0:b0:7b7:faa5:954f with SMTP id l12-20020a6b7f0c000000b007b7faa5954fmr1627037ioq.23.1703044183845;
        Tue, 19 Dec 2023 19:49:43 -0800 (PST)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id r9-20020a6bd909000000b007b42bf452f4sm6509305ioc.33.2023.12.19.19.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:49:43 -0800 (PST)
Date: Wed, 20 Dec 2023 09:19:32 +0530
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
Message-ID: <ZYJkTN+GNi1nMkJd@sunil-laptop>
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
No worries!. I will wait for your feedback.

Thanks!
Sunil

