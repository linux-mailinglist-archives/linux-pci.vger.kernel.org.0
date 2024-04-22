Return-Path: <linux-pci+bounces-6529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAD88AD4D5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 21:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419ED1C20ED4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765ED15532B;
	Mon, 22 Apr 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFAAzSYo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446475025E;
	Mon, 22 Apr 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814117; cv=none; b=lBrgg+NmmbJmokCn6pZjxUe6HBLX/UKjkE3xGhVHgVQZu/B1+HG2IMXhUHBj1E7zedk4UNsOQ0lQ4IREXrqQUcJ3RwTAozqVpRFcuvPXEljcnBLN3t/7tbj6d6SuXB+WHKhYcddAJ0evhFrEIJWkYneX5qeIBZkrhhSgi3gZQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814117; c=relaxed/simple;
	bh=vK0Pec9UTkueMfeAUW6DUE58gHSSShCHCCsfnjahRB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYTMTz495WOWkfMSD0jQq6TnCSIBXtcb65UzeyT8i7A/nNQiQKFr/m0ZFW0mKgQ7rmnWGtFEb39HzT1V6//Ckvw77UEgheqp6SjHgrwaVTFOgF6xD6CLMi4TEz2ag2mAoWuDxIIO5016NZQirBP4apH+slHJ807HDQc7Vk3sw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFAAzSYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E4CC4AF0B;
	Mon, 22 Apr 2024 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713814116;
	bh=vK0Pec9UTkueMfeAUW6DUE58gHSSShCHCCsfnjahRB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aFAAzSYoUCQ68idR1ZV/vA+n5TvKrpHfQPoJVIiInIMpjHdQSX73yMdn8U4ksj4Fc
	 skG6AwXlU+5fRyCJT657pU2QBb3UEFwAmP5XAc9n2XDl5Xz1uW0oJN6x4qVbmV5LTG
	 kcxqY4j8mc7HfQsccUQl1hDRBDyntfRMXM0/5IHXrFVFiRRrSgq8OXXe/6FaB2bmSv
	 V5PtvrBUChUucAwEXMYzqk8qPn2vYGkelEQruUnzVbFZU5IQLsQ12fMF0BQwGrjLlg
	 pNHv2P+Atj6ifkBsSbq3ndmGR2MyN7SrutlUyMoSh4pCnCtmBSYtw+Dvvvhr4ywRAs
	 Yn/7YHfhlPTUg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5af12f48b72so54783eaf.3;
        Mon, 22 Apr 2024 12:28:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHKGmo7STpFRzemDOOTHy6x10AbCoTSzBSLd4NbsEKeIto/HIqXrzuJ5fFa9POKOq6hbk9OVQy/XZZsWOyheZkTD/DKNd0gbj2wfP2iCWPw7zKjuIr1P5b67yUTSsTpj7dRWJdn7fvfA4QMOu0i64r5Cpi29BwIjMlGYY7wXDPwd328g==
X-Gm-Message-State: AOJu0YxylrhNQUSWCUsOKs9Ms+Ws27YZeUNiV2Vr3lvkdY9j6MU6CDOP
	ouHaQoopHZ/TrQ0WA2DEXgQmBp21rtXZbmYJ15VIfmGbMmWHcYYHw9UPN/BbwoFxPKQEK7yM0is
	I1Iy2uV/UVngIpiyVgmk6/7M7xzk=
X-Google-Smtp-Source: AGHT+IGUETKc3TgOF4OePC5o1ZswAoxj8sQKPSP7731avzXAb+y8Q1PqVfZ8Xtb3zIuDpvt+fYwScVKj2gv5dZwOXLc=
X-Received: by 2002:a05:6820:2884:b0:5aa:241a:7f4b with SMTP id
 dn4-20020a056820288400b005aa241a7f4bmr11757032oob.1.1713814115959; Mon, 22
 Apr 2024 12:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 21:28:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTzn3TDoh0+0UQjMeJVdU+z16dDOT_fKMhr0XrOxyRtA@mail.gmail.com>
Message-ID: <CAJZ5v0gTzn3TDoh0+0UQjMeJVdU+z16dDOT_fKMhr0XrOxyRtA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Robert Moore <robert.moore@intel.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Kumar Patra <atishp@rivosinc.com>, Andrei Warkentin <andrei.warkentin@intel.com>, 
	Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 7:01=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
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
> 2) Added support for re-ordering the probe of interrupt controllers when
> IRQCHIP_ACPI_DECLARE is used.
>
> 3) To ensure probe order between interrupt controllers and devices,
> implicit dependency is created similar to when _DEP is present.
>
> 4) When PNP devices like Generic 16550A UART, have the dependency on the
> interrupt controller, they will not be added to PNP data structures. So,
> added second phase of pnpacpi_init to handle this.
>
> 5) ACPI support added in RISC-V interrupt controller drivers.
>
> This series is still kept as RFC to seek feedback on above design
> changes. Looking forward for the feedback!

I've looked at the patches and I don't see anything deeply concerning
in them from the ACPI core code perspective.

The changes look reasonably straightforward to me.

Thanks!

> Changes since RFC v3:
>         1) Moved to _DEP method instead of fw_devlink.
>         2) PLIC/APLIC driver probe using namespace devices.
>         3) Handling PNP devices as part of clearing dependency.
>         4) Rebased to latest linux-next to get AIA DT drivers.
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
> 1) Qemu should be built using the riscv_acpi_namespace_v1 branch at
> https://github.com/vlsunil/qemu.git
>
> 2) EDK2 should be built using the instructions at:
> https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
>
> 3) Build Linux using this series.
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
> This series is also available in acpi_b2_v4_autodep_v1 branch at
> https://github.com/vlsunil/linux.git
>
> Based-on: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git/tag/?h=3Dnext-20240415
>
> Sunil V L (20):
>   arm64: PCI: Migrate ACPI related functions to pci-acpi.c
>   RISC-V: ACPI: Implement PCI related functionality
>   PCI: Make pci_create_root_bus() declare its reliance on MSI domains
>   ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
>     probe
>   ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
>   ACPI: bus: Add acpi_riscv_init function
>   RISC-V: Kconfig: Select deferred GSI probe for ACPI systems
>   ACPI: scan: Refactor dependency creation
>   drivers/acpi/scan.c: Update _DEP honor list
>   RISC-V: ACPI: Initialize GSI mapping structures
>   ACPI: scan.c: Define weak function to populate dependencies
>   RISC-V: ACPI: Implement function to add implicit dependencies
>   ACPI/PNP: Initialize PNP devices skipped due to _DEP
>   irqchip: riscv-intc: Add ACPI support for AIA
>   irqchip: riscv-imsic: Add ACPI support
>   irqchip: riscv-aplic: Add ACPI support
>   irqchip: irq-sifive-plic: Add ACPI support
>   ACPI: bus: Add RINTC IRQ model for RISC-V
>   irqchip: riscv-intc: Set ACPI irqmodel
>   ACPI: pci_link: Clear the dependencies after probe
>
>  arch/arm64/kernel/pci.c                    | 191 ------------
>  arch/riscv/Kconfig                         |   3 +
>  arch/riscv/include/asm/irq.h               |  57 ++++
>  arch/riscv/kernel/acpi.c                   |  31 +-
>  drivers/acpi/Kconfig                       |   3 +
>  drivers/acpi/bus.c                         |   4 +
>  drivers/acpi/pci_link.c                    |   3 +
>  drivers/acpi/riscv/Makefile                |   2 +-
>  drivers/acpi/riscv/init.c                  |  14 +
>  drivers/acpi/riscv/init.h                  |   4 +
>  drivers/acpi/riscv/irq.c                   | 323 +++++++++++++++++++++
>  drivers/acpi/scan.c                        |  69 +++--
>  drivers/irqchip/irq-riscv-aplic-direct.c   |  20 +-
>  drivers/irqchip/irq-riscv-aplic-main.c     |  70 +++--
>  drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
>  drivers/irqchip/irq-riscv-aplic-msi.c      |   9 +-
>  drivers/irqchip/irq-riscv-imsic-early.c    |  52 +++-
>  drivers/irqchip/irq-riscv-imsic-platform.c |  32 +-
>  drivers/irqchip/irq-riscv-imsic-state.c    | 115 ++++----
>  drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
>  drivers/irqchip/irq-riscv-intc.c           | 102 ++++++-
>  drivers/irqchip/irq-sifive-plic.c          |  89 ++++--
>  drivers/pci/pci-acpi.c                     | 182 ++++++++++++
>  drivers/pci/probe.c                        |   3 +
>  drivers/pnp/pnpacpi/core.c                 |  24 +-
>  drivers/pnp/pnpacpi/rsparser.c             |  63 ++--
>  include/acpi/acpi_bus.h                    |   2 +
>  include/linux/acpi.h                       |   9 +
>  include/linux/irqchip/riscv-imsic.h        |  10 +
>  include/linux/pnp.h                        |   7 +
>  30 files changed, 1108 insertions(+), 388 deletions(-)
>  create mode 100644 drivers/acpi/riscv/init.c
>  create mode 100644 drivers/acpi/riscv/init.h
>  create mode 100644 drivers/acpi/riscv/irq.c
>
> --
> 2.40.1
>
>

