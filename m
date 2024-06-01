Return-Path: <linux-pci+bounces-8157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4798D708E
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E3D1F210BA
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60915252F;
	Sat,  1 Jun 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="APrjjZou"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0415218F
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254265; cv=none; b=SN05grwcib0nnOYOrKiXIDcG6P8UNYqsMDWv9Q4a/9XLzYqWMUwqz+CGTWNCbuh9o1VbLQGdtUFteTbs8P6/i6V/6PpPnZCFQG4CQ6XRFUvt1NvFTYuIZGpm1v+82nQc1cky74viVmEmctC94rjkAHXH4YcjpBxUv7sUIl9pG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254265; c=relaxed/simple;
	bh=t07UkiT//kJvTyikoaPZfW2KllppHyimPLLG+y5rtMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CPUEsVvxdzp1zGb7LBQmwheitUlrsQEK9NbLamdSTaTBTaHJS2GxdS5D9GBjp2/xxN5VnAdsfgAH9+19qkOBYkFPWBRDuXKgSV7Bq7d+pF+qyrdKoBMGsarjPxS6eeDBCb7cWfzjGo4+LEO+ZBCXACh5OFlKtybCVlP/nJ0srIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=APrjjZou; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70259bdcf7cso285358b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2024 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254262; x=1717859062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgxwxnWOjHGJRULZg5HYqL5pz8PSgbwJm/88zI1CoMY=;
        b=APrjjZouZXYQc+xxo90UPe5GdV0celT7/znuMItizbZjvjGPLyzX3apFTWy4j8IbX9
         14W7Uk3EgFqEnfYD9+oGzEwP/d2qYka7jn1YbwuU7fINB4N4u8eD4JzrbI0wrXSn18C8
         tpwFPgmUo/ynH6x24p6pwpSW0YKRPaNkC/zRv4DbGYygSIKg2TOWBdl16ErL9/lBVFjh
         ZHdGDEKL6H+3ASY7waEsaq028riiHwWviT+MvZjzYRhxg4VxNU/cB779xmQa8Id19M1C
         Ai5VvLFbbNfxVcoNVgVr7f1we2YFeW8M9fgtsFKu/Ajb0QCe0nRkKIEBXDEK3d8LzB9G
         K68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254262; x=1717859062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgxwxnWOjHGJRULZg5HYqL5pz8PSgbwJm/88zI1CoMY=;
        b=QJpAqt3uqgoC9Xo26YYQPIb0W60QXDoIL7YM9v0cDhsSzGMDLxeHqW8AlZWwWcNrsq
         Kc8L2hHZBE5OhRhqYLDGh0cJznOmIsISX45GLpp7rETFh2WYEJMH/lJDCtB4GV4S6jtP
         Wl2vtQlNzE85i2GSxvNER9mVdKLN73ZmZQ2kntt5LAe+2HPAA0hy0Ywq2sVTVDVipKX/
         5voK9MfUEk+5DVS0CGfJoJY7asuD1bYdJDDuu7+DVOKjLYxIXWeJ1GsHOc90E37gCoPC
         lFKovX6IHGLuQb0ZNJSPdUePu5IwSsrZBjcWwEi0kTJPTORKdzbmcmGbWnWgbYr6LUFa
         SnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf4efNpollc7H/JR6yvLaI1sni+bakhVX1xDV1rsbXJ+0rIV17K07S4Xqmv0/Q3/jyfa2C2lEMu0lL5GLtlQwsV7BQif/UTYf3
X-Gm-Message-State: AOJu0YzwGZo4G3INAQyiQRn7Kvez2nhEXCWYzJOInAmhayFvpSMFcbDJ
	X3FNDqyarCRV7RDA30ZnpexokOGdpuE1hC2p7GPeBjeBoFxTkr2kcx7edWK3yeI=
X-Google-Smtp-Source: AGHT+IENZYZ6pmncsatWg7wAXsx4MuGnUG/pExhK7JqrpVwMEVVkLjFulSLz0B0y6o7X8oXFutrZkw==
X-Received: by 2002:a05:6a21:78a1:b0:1b2:67d1:228c with SMTP id adf61e73a8af0-1b26f2cd637mr5593792637.48.1717254261549;
        Sat, 01 Jun 2024 08:04:21 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:20 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 00/17] RISC-V: ACPI: Add external interrupt controller support
Date: Sat,  1 Jun 2024 20:33:54 +0530
Message-Id: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds support for the below ECR approved by ASWG.
1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing

The series primarily enables irqchip drivers for RISC-V ACPI based
platforms.

The series can be broadly categorized like below. 

1) PCI ACPI related functions are migrated from arm64 to common file so
that we don't need to duplicate them for RISC-V.

2) Added support for re-ordering the probe of interrupt controllers when
IRQCHIP_ACPI_DECLARE is used.

3) To ensure probe order between interrupt controllers and devices,
implicit dependency is created similar to when _DEP is present.

4) ACPI support added in RISC-V interrupt controller drivers.

Changes since v5:
	1) Addressed feedback from Thomas.
	2) Created separate patch for refactoring DT code in IMSIC
	3) Separated a fix in riscv-intc irqchip driver and sent
	   separately. This series depends on that patch [1].
	4) Dropped serial driver patch since it depends on Andy's
	   refactoring series [2]. RISC-V patches will be sent
	   separately later once Andy series get accepted.
	5) Rebased to v6.10-rc1 which has AIA DT patches.
	6) Updated tags.

Changes since RFC v4:
	1) Removed RFC tag as the RFCv4 design looked reasonable.
	2) Dropped PCI patch needed to avoid warning when there is no MSI
	   controller. This will be sent later separately after the
	   current series.
	3) Dropped PNP handling of _DEP since there is new ACPI ID for
	   generic 16550 UART. Added the serial driver patch instead.
	4) Rebased to latest linux-next.
	5) Reordered/squashed patches in the series

Changes since RFC v3:
	1) Moved to _DEP method instead of fw_devlink.
	2) PLIC/APLIC driver probe using namespace devices.
	3) Handling PNP devices as part of clearing dependency.
	4) Rebased to latest linux-next to get AIA DT drivers.

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

1) qemu should be built using the riscv_acpi_namespace_v2 branch at
https://github.com/vlsunil/qemu.git

2) EDK2 should be built using the instructions at:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

NOTE: One should be able to use u-boot as well as per instructions from Björn.
https://lore.kernel.org/lkml/87a5lqsrvh.fsf@all.your.base.are.belong.to.us/

3) Build Linux using this series along with the riscv-intc fix patch
[1]. Since serial driver patch is dropped, SBI_HVC console needs to be
used. Enable below configs while building the linux.
CONFIG_NONPORTABLE=y
CONFIG_HVC_RISCV_SBI=y

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
 -append "root=/dev/ram ro console=hvc0 rootwait earlycon=sbi"

To boot with APLIC only, use aia=aplic.
To boot with PLIC, remove aia= option.

This series is also available in acpi_b2_v6 branch at
https://github.com/vlsunil/linux.git

[1] - https://lore.kernel.org/lkml/20240527081113.616189-1-sunilvl@ventanamicro.com/
[2] - https://lore.kernel.org/lkml/20240506140308.4040735-1-andriy.shevchenko@linux.intel.com/

Sunil V L (17):
  arm64: PCI: Migrate ACPI related functions to pci-acpi.c
  ACPI: scan: Add a weak function to reorder the IRQCHIP probe
  ACPI: bus: Add acpi_riscv_init function
  ACPI: scan: Refactor dependency creation
  ACPI: scan: Add RISC-V interrupt controllers to honor list
  ACPI: scan: Define weak function to populate dependencies
  ACPI: bus: Add RINTC IRQ model for RISC-V
  ACPI: pci_link: Clear the dependencies after probe
  ACPI: RISC-V: Implement PCI related functionality
  ACPI: RISC-V: Implement function to reorder irqchip probe entries
  ACPI: RISC-V: Initialize GSI mapping structures
  ACPI: RISC-V: Implement function to add implicit dependencies
  irqchip/riscv-intc: Add ACPI support for AIA
  irqchip/riscv-imsic-state: Create separate function for DT
  irqchip/riscv-imsic: Add ACPI support
  irqchip/riscv-aplic: Add ACPI support
  irqchip/sifive-plic: Add ACPI support

 arch/arm64/kernel/pci.c                    | 191 ------------
 arch/riscv/Kconfig                         |   2 +
 arch/riscv/include/asm/irq.h               |  55 ++++
 arch/riscv/kernel/acpi.c                   |  33 +--
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/pci_link.c                    |   2 +
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  14 +
 drivers/acpi/riscv/init.h                  |   4 +
 drivers/acpi/riscv/irq.c                   | 329 +++++++++++++++++++++
 drivers/acpi/scan.c                        | 103 ++++---
 drivers/irqchip/irq-riscv-aplic-direct.c   |  22 +-
 drivers/irqchip/irq-riscv-aplic-main.c     |  68 +++--
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |   9 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  64 +++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  32 +-
 drivers/irqchip/irq-riscv-imsic-state.c    | 160 +++++-----
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           |  90 ++++++
 drivers/irqchip/irq-sifive-plic.c          |  94 ++++--
 drivers/pci/pci-acpi.c                     | 182 ++++++++++++
 include/acpi/acpi_bus.h                    |   2 +
 include/linux/acpi.h                       |   9 +
 include/linux/irqchip/riscv-imsic.h        |   9 +
 25 files changed, 1106 insertions(+), 377 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irq.c

-- 
2.40.1


