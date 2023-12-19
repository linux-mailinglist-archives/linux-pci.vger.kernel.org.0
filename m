Return-Path: <linux-pci+bounces-1172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED4E818E77
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833271C248A2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12846374CF;
	Tue, 19 Dec 2023 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G7zB6JWl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5713174A
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d47bb467a9so2136286b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007937; x=1703612737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=959oPX30wMegwb1RPQMugDw8tMBDjS9o+5BG/fh0FBc=;
        b=G7zB6JWltfhL+hfXQnIoYIV5sdpPY+NymWT4cEZDWxG8smsr/mf30/SYfVLOwgI3Yt
         owzOlvbml8ubI6NOtbCYkIqtNyOIAPlnLsMN9dMWXRIxwfa07atBVyxlhnsEalS+BwZA
         BvxG1+W+j1aHpa/iPmIYp6/gFaB8iHCvuY/hShn1XA6h2bswKgkSkSQXRpVBJFo9dIQw
         Ug+t1q99ZddFCbaOzy18vvLjvWBj1hsYkvS0vnoTqMQiFZq/yIuBrGTiPALrBKTPMid4
         E2Eup05wb3CbXFCNC+SxjJW/e7BD7PME0l7M8SUeeL6Veew4SbnUAF0twPL0piopkVsA
         D8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007937; x=1703612737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=959oPX30wMegwb1RPQMugDw8tMBDjS9o+5BG/fh0FBc=;
        b=q8pOKIVvluAT4YP6uu4Fl4EfrR0XvKM+Utl9iB9gW148vR5lkJsucKkBuZ17cQitVd
         BNF2WDEww0j4kas2HsSBfWgPUCKhp/QkF1x+RIg+IaNDhEoNGoR4Tdl5QWSavZ4XDRFf
         rRlMRlJItps6rHl2VNKK5ncJB14MuDTNCxXfJrpxVhLozgaR6IS1LwBLybg9CypQVvNt
         P+fvu5iYnIh79/wn6T//LXNPrD8/48yxVR9UjYZYc6HoSJV/0yjMYnoJKTHkfpn6InPs
         MTb35DH/W+f1ZWGdjI41VOphYhHAPDOeBNuZralDerGyI84jlg1ANMg393bc16N9eS0F
         dEtA==
X-Gm-Message-State: AOJu0YxbWIBeTTWWAup/U15ZrHvuqJf2uYx+zbrbj60+IOnnUN1VO6W/
	28RTLQzBkmE8MjZtNbi7gU9WFw==
X-Google-Smtp-Source: AGHT+IFwXvF0wStLmtEexCX7/btdTXes/e+r4u90Q61lIBg2zzfPyLBBBtaNfs0lLogbWkW5yL7UDQ==
X-Received: by 2002:a17:903:11d1:b0:1d0:6ffd:6117 with SMTP id q17-20020a17090311d100b001d06ffd6117mr1910887plh.57.1703007935507;
        Tue, 19 Dec 2023 09:45:35 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:45:35 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 00/17] RISC-V: ACPI: Add external interrupt controller support
Date: Tue, 19 Dec 2023 23:15:09 +0530
Message-Id: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the below ECR approved by ASWG.
1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing

The series primarily enables irqchip drivers for RISC-V ACPI based
platforms.

The series can be broadly categorized like below. 

1) PCI ACPI related functions are migrated from arm64 to common file so
that we don't need to duplicate them for RISC-V.

2) Introduced support for fw_devlink for ACPI nodes for IRQ dependency.
This helps to support deferred probe of interrupt controller drivers.

3) Modified pnp_irq() to try registering the IRQ  again if it sees it in
disabled state. This solution is similar to how
platform_get_irq_optional() works for regular platform devices.

4) Added support for re-ordering the probe of interrupt controllers when
IRQCHIP_ACPI_DECLARE is used.

5) ACPI support added in RISC-V interrupt controller drivers.

This series is based on Anup's AIA v11 series. Since Anup's AIA v11 is
not merged yet and first time introducing fw_devlink, deferred probe and
reordering support for IRQCHIP probe, this series is still kept as RFC.
Looking forward for the feedback!

Changes since RFC v2:
	1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
	2) Dropped patches in drivers which are not required due to
	   fw_devlink support.
	3) Dropped pci_set_msi() patch and added a patch in
	   pci_create_root_bus().
	4) Updated pnp_irq() patch so that none of the actual PNP
	   drivers need to change.

Changes since RFC v1:
	1) Abandoned swnode approach as per Marc's feedback.
	2) To cope up with AIA series changes which changed irqchip driver
	   probe from core_initcall() to platform_driver, added patches
	   to support deferred probing.
	3) Rebased on top of Anup's AIA v11 and added tags.

To test the series,

1) Qemu should be built using the riscv_acpi_b2_v8 branch at
https://github.com/vlsunil/qemu.git

2) EDK2 should be built using the instructions at:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

3) Build Linux using this series on top of Anup's AIA v11 series.

Run Qemu:
qemu-system-riscv64 \
 -M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic \
 -m 2G -smp 8 \
 -serial mon:stdio \
 -device virtio-gpu-pci -full-screen \
 -device qemu-xhci \
 -device usb-kbd \
 -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
 -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
 -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
 -kernel arch/riscv/boot/Image \
 -initrd rootfs.cpio \
 -append "root=/dev/ram ro console=ttyS0 rootwait earlycon=uart8250,mmio,0x10000000"

To boot with APLIC only, use aia=aplic.
To boot with PLIC, remove aia= option.

This series is also available in acpi_b2_v3_riscv_aia_v11 branch at
https://github.com/vlsunil/linux.git

Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
(https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro.com/)

Sunil V L (17):
  arm64: PCI: Migrate ACPI related functions to pci-acpi.c
  RISC-V: ACPI: Implement PCI related functionality
  PCI: Make pci_create_root_bus() declare its reliance on MSI domains
  ACPI: Add fw_devlink support for ACPI fwnode for IRQ dependency
  ACPI: irq: Add support for deferred probe in acpi_register_gsi()
  pnp.h: Reconfigure IRQ in pnp_irq() to support deferred probe
  ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
    probe
  ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
  irqchip: riscv-intc: Add ACPI support for AIA
  irqchip: riscv-imsic: Add ACPI support
  irqchip: riscv-aplic: Add ACPI support
  irqchip: irq-sifive-plic: Add ACPI support
  ACPI: bus: Add RINTC IRQ model for RISC-V
  ACPI: bus: Add acpi_riscv_init function
  ACPI: RISC-V: Create APLIC platform device
  ACPI: RISC-V: Create PLIC platform device
  irqchip: riscv-intc: Set ACPI irqmodel

 arch/arm64/kernel/pci.c                    | 191 ---------------------
 arch/riscv/Kconfig                         |   2 +
 arch/riscv/include/asm/irq.h               |  46 +++++
 arch/riscv/kernel/acpi.c                   |  31 ++--
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/irq.c                         |  22 +++
 drivers/acpi/property.c                    |  20 +++
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  15 ++
 drivers/acpi/riscv/init.h                  |   6 +
 drivers/acpi/riscv/irq.c                   | 169 ++++++++++++++++++
 drivers/acpi/scan.c                        |   3 +
 drivers/irqchip/irq-riscv-aplic-direct.c   |  21 ++-
 drivers/irqchip/irq-riscv-aplic-main.c     |  64 ++++---
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |   9 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  52 +++++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  51 ++++--
 drivers/irqchip/irq-riscv-imsic-state.c    | 128 +++++++-------
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           |  96 ++++++++++-
 drivers/irqchip/irq-sifive-plic.c          |  76 ++++++--
 drivers/pci/pci-acpi.c                     | 182 ++++++++++++++++++++
 drivers/pci/probe.c                        |   1 +
 drivers/pnp/pnpacpi/core.c                 |   7 +
 include/linux/acpi.h                       |  18 ++
 include/linux/irqchip/riscv-imsic.h        |  10 ++
 include/linux/pnp.h                        |  14 +-
 28 files changed, 895 insertions(+), 348 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irq.c

-- 
2.39.2


