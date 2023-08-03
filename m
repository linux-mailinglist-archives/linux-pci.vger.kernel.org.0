Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A180C76F0E5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjHCRwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 13:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHCRwQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 13:52:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18C630D5
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 10:52:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so879767b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085134; x=1691689934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AaI7fI3M5YP9w6pz8mvrFaji+j10/oJLgbr5Sgiyug8=;
        b=e9tSk2Lz0f+uk2NwCCZSrPkOJwVQN+srfiSADOX8z6U8s0voJ/9V2syfmKv+xT0nTA
         CFMYsmvyoN5Ek5L5nmyycpkdNsYQsyRsZyRzC2tre7ewYkPpJUCPUy9jMrunYpMk9/4Z
         BGMfKUg3rjhemUeKS85ff4NkRy5YwNs05TJASd2Ki5eux1sbpKsdyqk6a/gztlxNnqsF
         yMERiPl6rzZH5OFYJOxIwcw/nALMtmZE/mDNN/4DdfyBlykrY4tZD83KawFWzgH69R0H
         n3tZM7W/jpRK/OBm1gz0ijUuTEfxtXcApljDwqgjMXQDeTixMtMpp9Sf0NGTy3xa0KDL
         uTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085134; x=1691689934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaI7fI3M5YP9w6pz8mvrFaji+j10/oJLgbr5Sgiyug8=;
        b=AehzWQT/HDEmg8B0ttc3QwQdUWltWRcGfJvDZ2IoDePB3FHxL2DIN/eMsuCiPiuw9E
         KxchiSPLzeBWa0ttMzLsGGH22Dt0X0uH/8SFq1dWFlnM27yxW1dqk96uPSQwWqR7ptxB
         dLt0KokBwKdoArabDZkTOMMYEwDr//Z1pcNQDdqfLWh4DbSlK33Ya6UWJE8+kPMqB/MB
         n5UwWHDMnEXM985p1SmCbyPL3UYquD/e2maMVHlDtcCBDJI+46tS6/Seru1OPUAZTERP
         DFQxx8xR9qXn6/sPPQvr3VynKrXaiU31Y1doi6iQhrmHJqo3g1WFTsD+0R4MoxPUibCv
         F6Zg==
X-Gm-Message-State: ABy/qLZrYdGdmv0zLEBphYBAd1dq/fB8QCXmk5GB6yrOItbIoFoORN7T
        fmz313SFiapLTO0WiumqT8USYQ==
X-Google-Smtp-Source: APBJJlH/TxrbX63ED89L3m57EPRl5UCCCRrK2WDITT468OXcUgoqJeG95n4wPLeVLccJHACSpDQ36w==
X-Received: by 2002:a05:6a20:3d03:b0:13f:3d25:d83 with SMTP id y3-20020a056a203d0300b0013f3d250d83mr4614678pzi.19.1691085133387;
        Thu, 03 Aug 2023 10:52:13 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id m6-20020aa78a06000000b006871bea2eeesm145153pfa.34.2023.08.03.10.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:52:13 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 00/21] Add external interrupt controller support
Date:   Thu,  3 Aug 2023 23:21:41 +0530
Message-Id: <20230803175202.3173957-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the below ECRs approved by ASWG recently.
1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
2) RHCT - https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view?usp=sharing

The series primarily adds below features.

1) ACPI support for external interrupt controller drivers (IMSIC, APLIC and PLIC).
2) Get CBO block sizes from RHCT.
3) Set timer_can_not_wakeup in timer driver based on the flag in RHCT.

PCI ACPI related functions are migrated from arm64 to common file
so that we don't need to duplicate them for RISC-V.

It uses software node framework to create the fwnode for the interrupt
controllers. This helps in keeping the actual drivers code mostly common
for DT and ACPI.

This series is based on Anup's AIA v7 series. The first 2 ACPICA
patches in this series will be merged via ACPICA release process. PATCH3 is a
fix patch. These patches are included in this series only to enable build.

To test the series,

1) Qemu should be built using the riscv_acpi_b2_v1_plic branch at
https://github.com/vlsunil/qemu.git

2) EDK2 should be built using the instructions at:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

3) Build Linux using this series on top of Anup's AIA v7 series.

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

This series is also available in riscv_acpi_b2_v1 brach at
https://github.com/vlsunil/linux.git

Based-on: 20230802150018.327079-1-apatel@ventanamicro.com
(https://lore.kernel.org/lkml/20230802150018.327079-1-apatel@ventanamicro.com/)

Anup Patel (1):
  swnode: Add support to create early during boot

Sunil V L (20):
  ACPICA: MADT: Add RISC-V external interrupt controllers
  ACPICA: RHCT: Add flags, CMO and MMU nodes
  RISC-V: ACPI: Fix acpi_os_ioremap to return iomem address
  RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
  arm64: PCI: Migrate ACPI related functions to pci-acpi.c
  RISC-V: ACPI: Implement PCI related functionality
  RISC-V: Kconfig: Select ECAM and MCFG
  RISC-V: ACPI: RHCT: Add function to get CBO block sizes
  RISC-V: cacheflush: Initialize CBO variables on ACPI systems
  clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu
  irqchip/riscv-intc: Use swnode framework to create fwnode
  irqchip/riscv-imsic-early: Add ACPI support
  ACPI: bus: Add acpi_riscv_init function
  ACPI: RISC-V: Create IMSIC platform device
  ACPI: Add APLIC IRQ model for RISC-V
  ACPI: RISC-V: Create APLIC platform device
  irqchip/irq-riscv-aplic-msi: Add ACPI support
  ACPI: bus: Add PLIC IRQ model
  RISC-V: ACPI: Create PLIC platform device
  irqchip/sifive-plic: Add GSI conversion support

 Documentation/riscv/acpi.rst            |  33 ++
 arch/arm64/kernel/pci.c                 | 193 ---------
 arch/riscv/Kconfig                      |   3 +
 arch/riscv/include/asm/acpi.h           |  21 +-
 arch/riscv/kernel/acpi.c                | 120 +++++-
 arch/riscv/mm/cacheflush.c              |  37 +-
 drivers/acpi/bus.c                      |   7 +
 drivers/acpi/riscv/Makefile             |   2 +-
 drivers/acpi/riscv/init.c               |  16 +
 drivers/acpi/riscv/init.h               |   6 +
 drivers/acpi/riscv/irqchip.c            | 507 ++++++++++++++++++++++++
 drivers/acpi/riscv/rhct.c               |  61 +++
 drivers/base/swnode.c                   | 117 +++++-
 drivers/clocksource/timer-riscv.c       |   4 +
 drivers/irqchip/irq-riscv-aplic-msi.c   |  14 +-
 drivers/irqchip/irq-riscv-imsic-early.c |  28 ++
 drivers/irqchip/irq-riscv-imsic-state.c |  33 +-
 drivers/irqchip/irq-riscv-intc.c        |  12 +-
 drivers/irqchip/irq-sifive-plic.c       |  16 +
 drivers/pci/pci-acpi.c                  | 182 +++++++++
 include/acpi/actbl2.h                   |  76 +++-
 include/linux/acpi.h                    |   8 +
 include/linux/property.h                |   3 +
 23 files changed, 1248 insertions(+), 251 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irqchip.c

-- 
2.39.2

