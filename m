Return-Path: <linux-pci+bounces-1190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E8818ECD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22193285EBC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F939AE0;
	Tue, 19 Dec 2023 17:50:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7139875;
	Tue, 19 Dec 2023 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58dd5193db4so994579eaf.1;
        Tue, 19 Dec 2023 09:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008230; x=1703613030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIdikjM2NM0B5fwp5wKpgGui6ScB4p2R3IMX5NwS0ok=;
        b=UHyXHRwETSPtzSGZANcLZyUJj9HSFjJ/8ZV97I9Lm51lV/BV6MG0A879RVQZWiVIIi
         nESyjOYFVRLlwqtOJ/qBzFkP+QViArPCVEi59URgZKWjO+m2u2S+QjSiFvaG6nZAiN72
         qBB9di/n0xyBTQ4qT8T0LBSJi1Mi2ugROSSNGhOUPcGTR5kpkAGEDzx1FfgGZ/V/LHA0
         PR3VJz0Hg059QjsC90ckVP8tJ5q+KHYmvcg7EBpdNMQenHpyF1XHENDnIso2KQLbhiov
         0/8WMc24FCIDPlNzm7BNCRFy/jqgXHIjW5ONFNOUvYZ0iB7Hju7RlMuHDyEdV56NWliY
         ObgA==
X-Gm-Message-State: AOJu0Yy/wNiQcAwWZuUio8dL/3YHLaa3W2wRg4jJlz2krCF58SY5g1VA
	bHBDGtnr8DUU0MPcRe7SGCo+NSvA/t/Z3AyttQsfIXYX
X-Google-Smtp-Source: AGHT+IFCQvZAgqrtipbyRJTOVOETMEvHgFW0NX7bvW4mXju3ST3yT0F/qBGe1Vu0qs7mI+XzxyVbVlBQ09EqkNHkiTo=
X-Received: by 2002:a05:6820:2a18:b0:590:9027:7ab0 with SMTP id
 dr24-20020a0568202a1800b0059090277ab0mr27147443oob.0.1703008230114; Tue, 19
 Dec 2023 09:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 18:50:19 +0100
Message-ID: <CAJZ5v0j6Veze8xDFKTbVZ5=WAfmLdeJ8NXRnh9kwCZgyaDdgew@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] RISC-V: ACPI: Add external interrupt
 controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 6:45=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> This series adds support for the below ECR approved by ASWG.
> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7=
zR/view?usp=3Dsharing
>
> The series primarily enables irqchip drivers for RISC-V ACPI based
> platforms.
>
> The series can be broadly categorized like below.
>
> 1) PCI ACPI related functions are migrated from arm64 to common file so
> that we don't need to duplicate them for RISC-V.
>
> 2) Introduced support for fw_devlink for ACPI nodes for IRQ dependency.
> This helps to support deferred probe of interrupt controller drivers.
>
> 3) Modified pnp_irq() to try registering the IRQ  again if it sees it in
> disabled state. This solution is similar to how
> platform_get_irq_optional() works for regular platform devices.
>
> 4) Added support for re-ordering the probe of interrupt controllers when
> IRQCHIP_ACPI_DECLARE is used.
>
> 5) ACPI support added in RISC-V interrupt controller drivers.
>
> This series is based on Anup's AIA v11 series. Since Anup's AIA v11 is
> not merged yet and first time introducing fw_devlink, deferred probe and
> reordering support for IRQCHIP probe, this series is still kept as RFC.
> Looking forward for the feedback!
>
> Changes since RFC v2:
>         1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
>         2) Dropped patches in drivers which are not required due to
>            fw_devlink support.
>         3) Dropped pci_set_msi() patch and added a patch in
>            pci_create_root_bus().
>         4) Updated pnp_irq() patch so that none of the actual PNP
>            drivers need to change.
>
> Changes since RFC v1:
>         1) Abandoned swnode approach as per Marc's feedback.
>         2) To cope up with AIA series changes which changed irqchip drive=
r
>            probe from core_initcall() to platform_driver, added patches
>            to support deferred probing.
>         3) Rebased on top of Anup's AIA v11 and added tags.
>
> To test the series,
>
> 1) Qemu should be built using the riscv_acpi_b2_v8 branch at
> https://github.com/vlsunil/qemu.git
>
> 2) EDK2 should be built using the instructions at:
> https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
>
> 3) Build Linux using this series on top of Anup's AIA v11 series.
>
> Run Qemu:
> qemu-system-riscv64 \
>  -M virt,pflash0=3Dpflash0,pflash1=3Dpflash1,aia=3Daplic-imsic \
>  -m 2G -smp 8 \
>  -serial mon:stdio \
>  -device virtio-gpu-pci -full-screen \
>  -device qemu-xhci \
>  -device usb-kbd \
>  -blockdev node-name=3Dpflash0,driver=3Dfile,read-only=3Don,filename=3DRI=
SCV_VIRT_CODE.fd \
>  -blockdev node-name=3Dpflash1,driver=3Dfile,filename=3DRISCV_VIRT_VARS.f=
d \
>  -netdev user,id=3Dnet0 -device virtio-net-pci,netdev=3Dnet0 \
>  -kernel arch/riscv/boot/Image \
>  -initrd rootfs.cpio \
>  -append "root=3D/dev/ram ro console=3DttyS0 rootwait earlycon=3Duart8250=
,mmio,0x10000000"
>
> To boot with APLIC only, use aia=3Daplic.
> To boot with PLIC, remove aia=3D option.
>
> This series is also available in acpi_b2_v3_riscv_aia_v11 branch at
> https://github.com/vlsunil/linux.git
>
> Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
> (https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro=
.com/)
>
> Sunil V L (17):
>   arm64: PCI: Migrate ACPI related functions to pci-acpi.c
>   RISC-V: ACPI: Implement PCI related functionality
>   PCI: Make pci_create_root_bus() declare its reliance on MSI domains
>   ACPI: Add fw_devlink support for ACPI fwnode for IRQ dependency
>   ACPI: irq: Add support for deferred probe in acpi_register_gsi()
>   pnp.h: Reconfigure IRQ in pnp_irq() to support deferred probe
>   ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
>     probe
>   ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
>   irqchip: riscv-intc: Add ACPI support for AIA
>   irqchip: riscv-imsic: Add ACPI support
>   irqchip: riscv-aplic: Add ACPI support
>   irqchip: irq-sifive-plic: Add ACPI support
>   ACPI: bus: Add RINTC IRQ model for RISC-V
>   ACPI: bus: Add acpi_riscv_init function
>   ACPI: RISC-V: Create APLIC platform device
>   ACPI: RISC-V: Create PLIC platform device
>   irqchip: riscv-intc: Set ACPI irqmodel

JFYI, I have no capacity to provide any feedback on this till 6.8-rc1 is ou=
t.

Thanks!

