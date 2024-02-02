Return-Path: <linux-pci+bounces-3009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CAB847002
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81EB1C2676C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701413F009;
	Fri,  2 Feb 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LEZnrVCl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1713D4F0
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876238; cv=none; b=YPn8i+vvB/igFRxz9N0rsg/GnzWw8cvx47f1U88lmcOT2z3ZgDpw1es6Ag3yotpi9YKUUJdJaa0xKpdldPwdnIBcV7DcpLUhiQiFnCn3a9pBmBLvvpYn17eQjgt/+UOzBDvOOu6pg3Tvu0zcbfmIk2Kc2F4D+QkBKw1/AWc9bBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876238; c=relaxed/simple;
	bh=gmE72n6TeFitgVvbm9bRHImXfXzUUrp0CX/IXAfhr/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8oq/evFyhPSLRzSmrpB+UMAzzPM2iEeGngvaEKxkwj18r6y1zqlEVnaxTzn2jsyK5oZjYvwVDGC17D+6tK/viYZVnL903uwYHXRWJxe6YqyokedOLxkVMZU5IjW3BwHQo3ZtRDZA7cug9lYNvsXpvLpJG4a/2VGe9VJJDMg1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LEZnrVCl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7232dcb3eso15144005ad.2
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 04:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706876236; x=1707481036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WuDd3zOQAiqDRvFUN46e91vQJ5JvtevogL67l6y45OI=;
        b=LEZnrVClJwcOevItepcRqcVAL98KuItnkEznZStbZaHa7gsgtoVxvgrvxfDMGbkLr1
         CzkgsOgzHVntNVToPvjsOhgOiuGNO9NQZP8pdQLRXGvUmEt/zQEuyXnxbAz0s7HeYUYY
         6U8tyeZX3r4LxB4CkOoJx1cFH6Td9SaKI1p8bNeh++XFJMU04aCDY1NtxGMIiE5DYSWL
         8ftoiMS6JzTzT5ZrgFJgGpTJdfhwvbp8Mwa3qqxp3cCGB7JQl284Ngnu5qF1vfSikjyZ
         mQVLPvPQhwNfyR49nAj/O5gl4L/vVu/aZUf2LLuIetagwr2vQexInuBW/GJ6GLfug4Le
         y+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876236; x=1707481036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuDd3zOQAiqDRvFUN46e91vQJ5JvtevogL67l6y45OI=;
        b=a6nmACQoMzBLJcDZsbnv00KDGFdjYqMIvnwSsI4AMnYEAGYwqQpsyCFhOpBc/OEcwn
         u2XaOLVeZtKowk4pQvbiTIimE1/goHId1XmW97ituUbFkON6dEHAusSQs49uDNo0TJr7
         1qnzDQSZAeauOFtqRQBEMh4a03+ocikyX1nCx1LoCcPU3gLCxtZPW1viJ7Kjat+rZmcu
         iriVjXxw275DjrNmN5MnPeFQkhHaHgjgfcUKWEYSoas1CQTISqSaRgUvN5TTT02gXrXh
         22YQV+tKZoxGbpVcCq52uaIEP9XMesURyMOMERP89mOcJ5gXTkCJe/RTiM9tgWoBpkg9
         dVjg==
X-Gm-Message-State: AOJu0Yzk/MNpKRx2akRl3pwPttR+BDZ1QlDThLJuoeW1uz/s1ptXQ8iO
	J1+wHwWq1EC/eBiTpTmpPglqoKHaKVLZDEQPn/jhvOhyPS3RLt2yJEVj7YRst3g=
X-Google-Smtp-Source: AGHT+IELLNH6lWdm0s+G2HbC/KWATTA/vsyct7pz0+9b+4Hl12z0rekIe8r2GVhwtMQnByPle+FQLA==
X-Received: by 2002:a17:902:da92:b0:1d8:b8df:79f4 with SMTP id j18-20020a170902da9200b001d8b8df79f4mr2378238plx.17.1706876236115;
        Fri, 02 Feb 2024 04:17:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXiIR/itsnWnL1cYJ2OcTY6EoEK531FbhCQgmajYPOLag9Pn/hn1011psN0PdOlnWFiCO3Pl7QzTF7ASCpJtLkcC8afhklPJ5blqucvlLhvzbbGcgZjklNOCtCWmOghvWbPoAazvdXfe2MtAEYveR9SiN/Btj0BfjZZoUxwGik0E9pdD+i8nqL38Ou8e/WtpBfRvw7t+MeIiVhJZ+CXJqogfa3tF6jeWX70+4N8KPHFzuKJttY7H4U5gKw5NOh++nPlx7TkjU70fazXM/7dykap7nIu6meMXFNV6+5DHAJF3CZWF0/xlvLaToMNmXgIBQ8grxl10She4NsanWIJZcXR+BJLfI5+YOVUS8mNPgzn3eKImcR9iDmju9bQNUFesVN9Y0O+1WKM2+k2px/45ayy3Xue/cYB/TnSO18utI7unRCRpOwYUhjSEtDBkRrIANziYcu35JZM6JTk+Mp6Na/1Uk626Cx9+Ez/9sgKHnYzEiFuxkK0U60iaLGa0jn6Wy1QgSZiHqXSSXYzuDhsJ7TNMtj7zCfK0+i6cLjDllPTlKFjAQAqx5uYH6V7VDlJmMALStyGMQmRGJrNQAoJ8oat7T7aXiZgUTWNyfxEm1k=
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903209200b001d8cde39e8bsm1467536plc.194.2024.02.02.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:17:15 -0800 (PST)
Date: Fri, 2 Feb 2024 17:47:07 +0530
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
Message-ID: <ZbzdQ2TdsSsb7PL/@sunil-laptop>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
 <CAJZ5v0j6Veze8xDFKTbVZ5=WAfmLdeJ8NXRnh9kwCZgyaDdgew@mail.gmail.com>
 <ZbiQ/tO/odnJCBD1@sunil-laptop>
 <CAJZ5v0gnH0uPEM0q9VzJOg2Z_7bOP9XdQbOttpRtnkLGej45Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gnH0uPEM0q9VzJOg2Z_7bOP9XdQbOttpRtnkLGej45Sw@mail.gmail.com>

On Thu, Feb 01, 2024 at 07:10:28PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 30, 2024 at 7:02 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Dec 19, 2023 at 06:50:19PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Dec 19, 2023 at 6:45 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > >
> > > > This series adds support for the below ECR approved by ASWG.
> > > > 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> > > >
> > > > The series primarily enables irqchip drivers for RISC-V ACPI based
> > > > platforms.
> > > >
> > > > The series can be broadly categorized like below.
> > > >
> > > > 1) PCI ACPI related functions are migrated from arm64 to common file so
> > > > that we don't need to duplicate them for RISC-V.
> > > >
> > > > 2) Introduced support for fw_devlink for ACPI nodes for IRQ dependency.
> > > > This helps to support deferred probe of interrupt controller drivers.
> > > >
> > > > 3) Modified pnp_irq() to try registering the IRQ  again if it sees it in
> > > > disabled state. This solution is similar to how
> > > > platform_get_irq_optional() works for regular platform devices.
> > > >
> > > > 4) Added support for re-ordering the probe of interrupt controllers when
> > > > IRQCHIP_ACPI_DECLARE is used.
> > > >
> > > > 5) ACPI support added in RISC-V interrupt controller drivers.
> > > >
> > > > This series is based on Anup's AIA v11 series. Since Anup's AIA v11 is
> > > > not merged yet and first time introducing fw_devlink, deferred probe and
> > > > reordering support for IRQCHIP probe, this series is still kept as RFC.
> > > > Looking forward for the feedback!
> > > >
> > > > Changes since RFC v2:
> > > >         1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> > > >         2) Dropped patches in drivers which are not required due to
> > > >            fw_devlink support.
> > > >         3) Dropped pci_set_msi() patch and added a patch in
> > > >            pci_create_root_bus().
> > > >         4) Updated pnp_irq() patch so that none of the actual PNP
> > > >            drivers need to change.
> > > >
> > > > Changes since RFC v1:
> > > >         1) Abandoned swnode approach as per Marc's feedback.
> > > >         2) To cope up with AIA series changes which changed irqchip driver
> > > >            probe from core_initcall() to platform_driver, added patches
> > > >            to support deferred probing.
> > > >         3) Rebased on top of Anup's AIA v11 and added tags.
> > > >
> > > > To test the series,
> > > >
> > > > 1) Qemu should be built using the riscv_acpi_b2_v8 branch at
> > > > https://github.com/vlsunil/qemu.git
> > > >
> > > > 2) EDK2 should be built using the instructions at:
> > > > https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
> > > >
> > > > 3) Build Linux using this series on top of Anup's AIA v11 series.
> > > >
> > > > Run Qemu:
> > > > qemu-system-riscv64 \
> > > >  -M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic \
> > > >  -m 2G -smp 8 \
> > > >  -serial mon:stdio \
> > > >  -device virtio-gpu-pci -full-screen \
> > > >  -device qemu-xhci \
> > > >  -device usb-kbd \
> > > >  -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
> > > >  -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
> > > >  -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
> > > >  -kernel arch/riscv/boot/Image \
> > > >  -initrd rootfs.cpio \
> > > >  -append "root=/dev/ram ro console=ttyS0 rootwait earlycon=uart8250,mmio,0x10000000"
> > > >
> > > > To boot with APLIC only, use aia=aplic.
> > > > To boot with PLIC, remove aia= option.
> > > >
> > > > This series is also available in acpi_b2_v3_riscv_aia_v11 branch at
> > > > https://github.com/vlsunil/linux.git
> > > >
> > > > Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
> > > > (https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro.com/)
> > > >
> > > > Sunil V L (17):
> > > >   arm64: PCI: Migrate ACPI related functions to pci-acpi.c
> > > >   RISC-V: ACPI: Implement PCI related functionality
> > > >   PCI: Make pci_create_root_bus() declare its reliance on MSI domains
> > > >   ACPI: Add fw_devlink support for ACPI fwnode for IRQ dependency
> > > >   ACPI: irq: Add support for deferred probe in acpi_register_gsi()
> > > >   pnp.h: Reconfigure IRQ in pnp_irq() to support deferred probe
> > > >   ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
> > > >     probe
> > > >   ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
> > > >   irqchip: riscv-intc: Add ACPI support for AIA
> > > >   irqchip: riscv-imsic: Add ACPI support
> > > >   irqchip: riscv-aplic: Add ACPI support
> > > >   irqchip: irq-sifive-plic: Add ACPI support
> > > >   ACPI: bus: Add RINTC IRQ model for RISC-V
> > > >   ACPI: bus: Add acpi_riscv_init function
> > > >   ACPI: RISC-V: Create APLIC platform device
> > > >   ACPI: RISC-V: Create PLIC platform device
> > > >   irqchip: riscv-intc: Set ACPI irqmodel
> > >
> > > JFYI, I have no capacity to provide any feedback on this till 6.8-rc1 is out.
> > >
> > Hi Rafael,
> >
> > Gentle ping.
> >
> > Could you please provide feedback on the series? Patches 4, 5, 6, 7 and
> > 8 are bit critical IMO. So, I really look forward for your and other
> > ACPI experts!.
> 
> There was quite a bit of discussion on patch [6/21] and it still seems
> relevant to me.
> 
> ACPI actually has a way to at least indicate what the probe ordering
> should be which is _DEP.
> 
> The current handling of _DEP in the kernel may not be covering this
> particular use case, but I would rather extend it (if necessary)
> instead of doing all of the -EPROBE_DEFER dance which seems fragile to
> me.
> 
Hi Rafael,

Appreciate your help to look at the patches. Thank you very much!.

I am not very sure whether you looked into patches in the v3 of the
series. Because, unlike in v2, v3 doesn't need changing all drivers to
handle EPROBE_DEFER. In v3, it creates fw_devlink for the dependency as
suggested by Marc. Please take a look at PATCH 4/17.

For the IRQ dependency, I think adding _DEP is not required. The
"Extended Interrupt Descriptor" supports ResourceSource to
indicate the dependency. Or GSI mapping can indicate the source. This is
already handled in acpi_irq_parse_one_cb(). PATCH 4 uses this
information to create links between producer and consumer so that DD
framework probes the driver in the required order.

As you know, PNP devices are enumerated in a different way. I don't know
why it was done like this. But pnpacpi_init() is called via
fs_initcall() and acpi_dev_resource_interrupt() called from
pnpacpi_allocated_resource() doesn't handle the ResourceSource
dependency. It caches the information in PNP data structure and expects
the IRQ mapping to be available. Even if we add support to
handle extended interrupt descriptor, it is not going to help. Hence, I
had to add PATCH 5/17 and PATCH 6/17. Again, the change is mainly in
pnp_irq() now and hence it doesn't need changing all drivers.

Thanks,
Sunil

