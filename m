Return-Path: <linux-pci+bounces-4410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9AD86FEE9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 11:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D5F2838DB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B394225DE;
	Mon,  4 Mar 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YVsh0H7p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693822606
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547641; cv=none; b=nzJSs5sAIYnHSBQfyqCvAWWq8aOmBwcNgBIlftxMsLZarlXjpGxUeZmMpqVshxGedrxw5mKZlUBZNHr0P9C8RqmA6B6fUon01pVS8JLH1kyiFh8JLqiNsIuoxP8NMY7fjvkUYSXH/dlGxu6K096Fso76JCfUbfWTl1a9k0AnPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547641; c=relaxed/simple;
	bh=2WLaY6eqKv6rBswgiO8JI2DBDzh7KJg/smdKRll/6Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/Lo6M2oadTgoWmqF47AgphfzpcQ2JkyaEFH+ZBpZ58P5LPzCiwJ1vVlPmHxsSjEUYjBYzq53e4vbuDcsuVVxOCyPuHtsp8iIJs7xtllqCsB72qH3THNSfjW1/KqrcXY2vnde1SMLLJH+EfCkRRir/v72Brzmgqvj2ffOjyvsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YVsh0H7p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd10ae77d8so4501225ad.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 02:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709547639; x=1710152439; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A/DJVtxZvGSCKoS+yY9PcXRHWiBZMtGTQN3gpK4VsPo=;
        b=YVsh0H7pf9iqJVU9++524FnPxXUBE/qdZhT2kfZo+vVw3eNaqnsiZxAQfbVlfgECTS
         WQT15/XZ28pezapM6fXIAozK6P9kjqgn6PhY4He9e83Bo4lMi8ZwXXOO85/uhTQIY3DW
         ZCHhipwvwvh3VjicV0N6PVX9WGKisPH+IaiHjvmoitlJVCo0XscFSV0ZT0tWpD8wbIGT
         vmbxN0b2o9hT32xsXT29mpif3Bf7m8KSxef14AZ5uaiRZ3g47iTjeCSVX6s9T8/u0+32
         ZdwptLoBYoFIXPvDzBMzfeD1iMfgemPWkDViY+0SuAYdLqwZk2ie6oFA5+cuQfjzIo12
         8UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547639; x=1710152439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/DJVtxZvGSCKoS+yY9PcXRHWiBZMtGTQN3gpK4VsPo=;
        b=v3JeIPHB74ASEzpyWV0O0s4rccW+JYOFhdhJRU27DFsxVWNnKtJ+yjfgbtesAXdcsE
         mqZOXGPuYswuvjz5Q7UrIu288iq2BM5rhBJDEnTXsvmrDQs6V9c0iSp3CRgGhOb8XuP6
         CMwVbm1kH+8BvZM+uoEkzj4EbSlG0v5chywbdA/tOYJrE5gaxeHlmUQtfGLbtZVOEjZF
         PcITAzyy+yc9BXC9BOyHdWJPhna8/HIRf6Ujm8Innpn1mRkFgAWaKh2T/K86i0Hzd3F2
         Oz5Sb8dbFs4QCZ74AAgm2W1znLGAuK4I/RLmKmEpwbeCqI/wK0G44CqlPFbHP+AMnkEA
         gn9g==
X-Forwarded-Encrypted: i=1; AJvYcCUIWtSTvRpSrTsdy3geR1bbs984O5889TIHFu1LCYz93j05HzhYU/fENadDFFpG3K+44r2PHll7FtF9IdmQ4lb1mYPa8VP/aaPU
X-Gm-Message-State: AOJu0YxgQLfjbIWA8h/0KoFw54zZB7BQ78TktSD4EraVN3x0puU/CGOZ
	aThvtohH99FFAeU3XE8pGUQpPDEdCXBXB9QODwlrCmYLhCRPn05CEi6+3MrxKPI=
X-Google-Smtp-Source: AGHT+IGNf6d/KjqoEkB6i3css4Ghljv6x7mLmw/ox2UBDC/0ylRWfyGuP0B7LoSaO2wMg5CRK4hD8g==
X-Received: by 2002:a17:903:2406:b0:1d7:5d88:f993 with SMTP id e6-20020a170903240600b001d75d88f993mr9267803plo.41.1709547639351;
        Mon, 04 Mar 2024 02:20:39 -0800 (PST)
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b001d8d1a2e5fesm8126502plh.196.2024.03.04.02.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:20:38 -0800 (PST)
Date: Mon, 4 Mar 2024 15:50:29 +0530
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
Message-ID: <ZeWgbU2muPdMo0E9@sunil-laptop>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
 <CAJZ5v0j6Veze8xDFKTbVZ5=WAfmLdeJ8NXRnh9kwCZgyaDdgew@mail.gmail.com>
 <ZbiQ/tO/odnJCBD1@sunil-laptop>
 <CAJZ5v0gnH0uPEM0q9VzJOg2Z_7bOP9XdQbOttpRtnkLGej45Sw@mail.gmail.com>
 <ZbzdQ2TdsSsb7PL/@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbzdQ2TdsSsb7PL/@sunil-laptop>

On Fri, Feb 02, 2024 at 05:47:16PM +0530, Sunil V L wrote:
> On Thu, Feb 01, 2024 at 07:10:28PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 30, 2024 at 7:02 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >
> > > On Tue, Dec 19, 2023 at 06:50:19PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Dec 19, 2023 at 6:45 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > >
> > > > > This series adds support for the below ECR approved by ASWG.
> > > > > 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> > > > >
> > > > > The series primarily enables irqchip drivers for RISC-V ACPI based
> > > > > platforms.
> > > > >
> > > > > The series can be broadly categorized like below.
> > > > >
> > > > > 1) PCI ACPI related functions are migrated from arm64 to common file so
> > > > > that we don't need to duplicate them for RISC-V.
> > > > >
> > > > > 2) Introduced support for fw_devlink for ACPI nodes for IRQ dependency.
> > > > > This helps to support deferred probe of interrupt controller drivers.
> > > > >
> > > > > 3) Modified pnp_irq() to try registering the IRQ  again if it sees it in
> > > > > disabled state. This solution is similar to how
> > > > > platform_get_irq_optional() works for regular platform devices.
> > > > >
> > > > > 4) Added support for re-ordering the probe of interrupt controllers when
> > > > > IRQCHIP_ACPI_DECLARE is used.
> > > > >
> > > > > 5) ACPI support added in RISC-V interrupt controller drivers.
> > > > >
> > > > > This series is based on Anup's AIA v11 series. Since Anup's AIA v11 is
> > > > > not merged yet and first time introducing fw_devlink, deferred probe and
> > > > > reordering support for IRQCHIP probe, this series is still kept as RFC.
> > > > > Looking forward for the feedback!
> > > > >
> > > > > Changes since RFC v2:
> > > > >         1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> > > > >         2) Dropped patches in drivers which are not required due to
> > > > >            fw_devlink support.
> > > > >         3) Dropped pci_set_msi() patch and added a patch in
> > > > >            pci_create_root_bus().
> > > > >         4) Updated pnp_irq() patch so that none of the actual PNP
> > > > >            drivers need to change.
> > > > >
> > > > > Changes since RFC v1:
> > > > >         1) Abandoned swnode approach as per Marc's feedback.
> > > > >         2) To cope up with AIA series changes which changed irqchip driver
> > > > >            probe from core_initcall() to platform_driver, added patches
> > > > >            to support deferred probing.
> > > > >         3) Rebased on top of Anup's AIA v11 and added tags.
> > > > >
> > > > > To test the series,
> > > > >
> > > > > 1) Qemu should be built using the riscv_acpi_b2_v8 branch at
> > > > > https://github.com/vlsunil/qemu.git
> > > > >
> > > > > 2) EDK2 should be built using the instructions at:
> > > > > https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
> > > > >
> > > > > 3) Build Linux using this series on top of Anup's AIA v11 series.
> > > > >
> > > > > Run Qemu:
> > > > > qemu-system-riscv64 \
> > > > >  -M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic \
> > > > >  -m 2G -smp 8 \
> > > > >  -serial mon:stdio \
> > > > >  -device virtio-gpu-pci -full-screen \
> > > > >  -device qemu-xhci \
> > > > >  -device usb-kbd \
> > > > >  -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
> > > > >  -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
> > > > >  -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
> > > > >  -kernel arch/riscv/boot/Image \
> > > > >  -initrd rootfs.cpio \
> > > > >  -append "root=/dev/ram ro console=ttyS0 rootwait earlycon=uart8250,mmio,0x10000000"
> > > > >
> > > > > To boot with APLIC only, use aia=aplic.
> > > > > To boot with PLIC, remove aia= option.
> > > > >
> > > > > This series is also available in acpi_b2_v3_riscv_aia_v11 branch at
> > > > > https://github.com/vlsunil/linux.git
> > > > >
> > > > > Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
> > > > > (https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro.com/)
> > > > >
> > > > > Sunil V L (17):
> > > > >   arm64: PCI: Migrate ACPI related functions to pci-acpi.c
> > > > >   RISC-V: ACPI: Implement PCI related functionality
> > > > >   PCI: Make pci_create_root_bus() declare its reliance on MSI domains
> > > > >   ACPI: Add fw_devlink support for ACPI fwnode for IRQ dependency
> > > > >   ACPI: irq: Add support for deferred probe in acpi_register_gsi()
> > > > >   pnp.h: Reconfigure IRQ in pnp_irq() to support deferred probe
> > > > >   ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
> > > > >     probe
> > > > >   ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
> > > > >   irqchip: riscv-intc: Add ACPI support for AIA
> > > > >   irqchip: riscv-imsic: Add ACPI support
> > > > >   irqchip: riscv-aplic: Add ACPI support
> > > > >   irqchip: irq-sifive-plic: Add ACPI support
> > > > >   ACPI: bus: Add RINTC IRQ model for RISC-V
> > > > >   ACPI: bus: Add acpi_riscv_init function
> > > > >   ACPI: RISC-V: Create APLIC platform device
> > > > >   ACPI: RISC-V: Create PLIC platform device
> > > > >   irqchip: riscv-intc: Set ACPI irqmodel
> > > >
> > > > JFYI, I have no capacity to provide any feedback on this till 6.8-rc1 is out.
> > > >
> > > Hi Rafael,
> > >
> > > Gentle ping.
> > >
> > > Could you please provide feedback on the series? Patches 4, 5, 6, 7 and
> > > 8 are bit critical IMO. So, I really look forward for your and other
> > > ACPI experts!.
> > 
> > There was quite a bit of discussion on patch [6/21] and it still seems
> > relevant to me.
> > 
> > ACPI actually has a way to at least indicate what the probe ordering
> > should be which is _DEP.
> > 
> > The current handling of _DEP in the kernel may not be covering this
> > particular use case, but I would rather extend it (if necessary)
> > instead of doing all of the -EPROBE_DEFER dance which seems fragile to
> > me.
> > 
> Hi Rafael,
> 
> Appreciate your help to look at the patches. Thank you very much!.
> 
> I am not very sure whether you looked into patches in the v3 of the
> series. Because, unlike in v2, v3 doesn't need changing all drivers to
> handle EPROBE_DEFER. In v3, it creates fw_devlink for the dependency as
> suggested by Marc. Please take a look at PATCH 4/17.
> 
> For the IRQ dependency, I think adding _DEP is not required. The
> "Extended Interrupt Descriptor" supports ResourceSource to
> indicate the dependency. Or GSI mapping can indicate the source. This is
> already handled in acpi_irq_parse_one_cb(). PATCH 4 uses this
> information to create links between producer and consumer so that DD
> framework probes the driver in the required order.
> 
> As you know, PNP devices are enumerated in a different way. I don't know
> why it was done like this. But pnpacpi_init() is called via
> fs_initcall() and acpi_dev_resource_interrupt() called from
> pnpacpi_allocated_resource() doesn't handle the ResourceSource
> dependency. It caches the information in PNP data structure and expects
> the IRQ mapping to be available. Even if we add support to
> handle extended interrupt descriptor, it is not going to help. Hence, I
> had to add PATCH 5/17 and PATCH 6/17. Again, the change is mainly in
> pnp_irq() now and hence it doesn't need changing all drivers.
> 
Hi Rafael,

Any further feedback on this? Do you see any issues with fw_devlink and
pnp_irq() changes for the interrupt controller dependency?

BTW, I explored the _DEP option you mentioned. But I think the current
approach would probably be better with lesser impact than _DEP. Below are
my findings.

1) When PNP device like PNP0501 (16550A UART) has _DEP, it does not get
created in the first pass (as expected) but they won't get created even
after the supplier clears the dependency. This is because
acpi_pnp_attach() returns success without calling pnpacpi_add_device()
when acpi_scan_clear_dep_fn() calls acpi_bus_attach(). Either
acpi_pnp_attach() needs to be modified or pnpacpi_add_device()
should be called as part of clearing the dependency. I may be wrong but
I think modifying pnp_irq() would probably affect only RISC-V than any
of the approaches above.

2) _DEP doesn't support PCI devices. When we have PCI link devices
(PNP0C0F) in the _PRT, the PCI driver probe as part of PCI scan can happen
prior to link device probe since link device will have dependency on the
interrupt controller which may not be probed yet. This will cause issue
to the PCI device driver init because _PRT says there is link device for
legacy PCI interrupt routing but the link driver is not probed yet.

3) _DEP needs namespace interrupt controllers. We would like to avoid
adding namespace devices also along with MADT.

Please let me know your thoughts.

Thanks,
Sunil

