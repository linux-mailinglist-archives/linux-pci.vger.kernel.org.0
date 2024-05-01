Return-Path: <linux-pci+bounces-6936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E58E8B89A0
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D91B21783
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9784E0A;
	Wed,  1 May 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mb3DeCIb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F434F20C
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565887; cv=none; b=JcfDPR/6Uk1XWi+cDzdPIlR7Ta4fC0oovxDiBohY1O6C8LyWdYtIHpV3dxNJ0+7gSbVVBvYVPo41DL5+dbXASKe5/5GhJrbVj5N41gYbjGe0sUJCSYbxKAMQcnPIFUSs4Cd9/WMCvYiopAuIDzUvKRq0B6fThyUb1x86XzdgKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565887; c=relaxed/simple;
	bh=EWOsbQ8d8Nb/EJHNU/jBnJqaPWlguzEkjOm3OBX3Ncc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i4RGN6F2bLbg3ttf9RfbgvVuZR66L9iHh+tTJeRDAzRmnVL8O6NKPsWn3rWOI1aS1JEQjmXmVotCqd/G/Y1nPrfpRjgHJWi6wmD+VfYY44bp9++J9/eCyMClw47oIn55uQWkOSJiOOdlEjGJKMWhgD3VCn8BKfJHKePfF35bZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mb3DeCIb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec92e355bfso5023455ad.3
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2024 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565884; x=1715170684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EhfEaMFfLrGfmVLdeaNNG6PlGGzfTCBnCOLnM+VG1c=;
        b=mb3DeCIbbmpn3mHmnE+oFMaBcjecbbNlK/QZrkms2jJA+3UDdtWoHK2u6fd8O99oZV
         DZBPdOibNnGXR/3fneUHY+xliWTnRI4Yk251Fr01JZPBrtLxyecpW6F6JERJZOJHfhnU
         9VSHoa/4LO5UkRm2Cq4GDGXTbYnbX62v3YbATpAkiiC0SwS+qHzgeqWWKsrvz+muHPZx
         a5Bem5TxCjlzNR6RyHla9iEHu2QstpVxZq5QL+K436kdbR9ARUGPE1DtoWHHOoNcgnVj
         sP/QXa/KGts1fsgIsDV4V1xUJv/SPujSnedypd6/rUF4JVGitabA+3a0Rc4ZtYqP6hYB
         i7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565884; x=1715170684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EhfEaMFfLrGfmVLdeaNNG6PlGGzfTCBnCOLnM+VG1c=;
        b=ZXomQJ2esBVkDI08HefsBFUSkt9GP5ly9F+VVnuM7KjkSneKWviYkPVAWF9gZatVge
         MqvdQfiesfDIPTSk8VWdZR/dMKxsfRMaUOSEp2Ry0kXC49Zk4W6ZrO4pdB/jGZBDHBi2
         6NY+y/Aq9UbWnkEe1vCzRX2Z01oNmqQyUJWpsyf01VUhsw1JEK3+i1kEw2v2ajBohkJP
         QaBIPDGSOFh1YbpoOHgfANB8unQtzy4aMJ+V/Iu5M2/yIt4wTb/WUn3WXi/xl4q/Mbyz
         DnABUZMTOc5p3+jqOZn5UtRXLyGW80DCJxj+sSdhdPS2YxZ8rLVn+CWl8xQfvWjm01UF
         Q/bw==
X-Forwarded-Encrypted: i=1; AJvYcCWp1+9AjKR8JAfyj+Kb4a2moOG8J8KFIzOh5pjZgr6j4kuWnhGbWA0mXwkGGcyjoIEU+4ArlM7CVjw2mTBuOfbl1ST9BnVHcdmL
X-Gm-Message-State: AOJu0YxcVgiD83chOy9Md9j01+zR9bBdu5osfhHWFgVJsi6oKKsXZyaD
	drLZy68cwxt578rYU6PNT4CQdT++Ufjl5+tDetMUULMLKdiKbBHuZTojPqnvmsE=
X-Google-Smtp-Source: AGHT+IGKp6Ma/BFy2R+UnRNFa2ZVdvrW3j2wb0D3bLNHdRHpaQg8W2PvjVIveWAJa/pc36T5TUO8jg==
X-Received: by 2002:a17:902:efcf:b0:1e5:c06b:3330 with SMTP id ja15-20020a170902efcf00b001e5c06b3330mr2036008plb.24.1714565884004;
        Wed, 01 May 2024 05:18:04 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:03 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 00/17] RISC-V: ACPI: Add external interrupt controller support
Date: Wed,  1 May 2024 17:47:25 +0530
Message-Id: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
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

4) Added 8250 serial driver for a generic 16550 UART which is enumerated
as ACPI platform device.

5) ACPI support added in RISC-V interrupt controller drivers.

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

3) Build Linux using this series.

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

This series is also available in acpi_b2_v5 branch at
https://github.com/vlsunil/linux.git

Based-on: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20240501

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
  irqchip/riscv-imsic: Add ACPI support
  irqchip/riscv-aplic: Add ACPI support
  irqchip/sifive-plic: Add ACPI support
  serial: 8250: Add 8250_acpi driver

 arch/arm64/kernel/pci.c                    | 191 ------------
 arch/riscv/Kconfig                         |   3 +
 arch/riscv/configs/defconfig               |   1 +
 arch/riscv/include/asm/irq.h               |  57 ++++
 arch/riscv/kernel/acpi.c                   |  31 +-
 drivers/acpi/Kconfig                       |   3 +
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/pci_link.c                    |   3 +
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  14 +
 drivers/acpi/riscv/init.h                  |   4 +
 drivers/acpi/riscv/irq.c                   | 329 +++++++++++++++++++++
 drivers/acpi/scan.c                        |  65 ++--
 drivers/irqchip/irq-riscv-aplic-direct.c   |  20 +-
 drivers/irqchip/irq-riscv-aplic-main.c     |  70 +++--
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |   9 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  52 +++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  32 +-
 drivers/irqchip/irq-riscv-imsic-state.c    | 115 ++++---
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           | 102 ++++++-
 drivers/irqchip/irq-sifive-plic.c          |  89 ++++--
 drivers/pci/pci-acpi.c                     | 182 ++++++++++++
 drivers/tty/serial/8250/8250_acpi.c        |  96 ++++++
 drivers/tty/serial/8250/Kconfig            |   8 +
 drivers/tty/serial/8250/Makefile           |   1 +
 include/acpi/acpi_bus.h                    |   2 +
 include/linux/acpi.h                       |   9 +
 include/linux/irqchip/riscv-imsic.h        |  10 +
 30 files changed, 1155 insertions(+), 352 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irq.c
 create mode 100644 drivers/tty/serial/8250/8250_acpi.c

-- 
2.40.1


