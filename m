Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA576F103
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjHCR7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjHCR7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 13:59:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7FC30CF
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 10:59:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f38692b3so1119142b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085574; x=1691690374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wq1z7BeI+UFrw1hZHq1hsdT3ctozS/71fNVXggUyOc=;
        b=TKbVzXiidYr6S5VYtdtf1RzdOXZlF7YlZGAMz5JBa3hQCChWKfcMl06Tm33RUMM2AT
         HJc+DhFBmwL3k/o/kj3hAK2jwOBpEOGlbr63abNLrTyaHg/Tx613qEQ2sIGIokBFEKy7
         Q7pSXU90KcKI0UZou6S7o898dbu4yYtAjvjesZlKV+tw21+58qB8DHwqlFlZZwF3J4tW
         +fhM21Zek4vYUxDqvDmwUsMhSfI0z5X0OZZSxk6N6kacC+/t6jBe0dUAiJ0ITdhIawrA
         IYvPPOVt5EitUe3UmJGfXaVeDMYYV9aeRa3RBCj3uM8jO94WL6Z9GAZ/GkCsvh5d1yrf
         xZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085574; x=1691690374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Wq1z7BeI+UFrw1hZHq1hsdT3ctozS/71fNVXggUyOc=;
        b=YAss8wLPDxLYIbQ/o8OKpmKP8F2eM0E77FykmIKIbaUCbd8rkg7PIVO7sMAQDvV2AD
         gc3W83AokvIxQAA7PqVXIbJiO0BRRLGOccJaYu8LcJRq0IbiJaZfjRmlTxnef+4xCfOn
         kcBzWXlmLJPNvpoVfG3MI9wNfhhl71ViIHf3k43eFZZkmuROMwdqO0KbA2+EkQScys5Y
         VfyVvR/sZaq38qsoU+ITXAOFAq5xaYCXwJkkhQW536xjX2msUOKFCEAICYsCPt4vf8H7
         T+yZXV5amW3XbI2SX1TgTlkL15iCy0OKRfa16ELeYJeuJLw9QGVwEjdNG/tjp1SzvuvA
         D5bg==
X-Gm-Message-State: ABy/qLb4ilo2oqIvKoZCwRMTz+NinFtrQsxDWKeVRJSiXhSB9dgmuBRY
        MVKNFXeef4s1nsvgG6X0etIbVQ==
X-Google-Smtp-Source: APBJJlEa2k0rKCkuiAJ14ufMYRdoRsdE+VQDeZqRmHp7niCeuF87Hv6jsPcdECJx49MZ98jIdtCMHA==
X-Received: by 2002:a05:6a20:3953:b0:134:1ef9:8c17 with SMTP id r19-20020a056a20395300b001341ef98c17mr24642870pzg.20.1691085574172;
        Thu, 03 Aug 2023 10:59:34 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:59:33 -0700 (PDT)
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
Subject: [RFC PATCH v1 00/21] RISC-V: ACPI: Add external interrupt controller support 
Date:   Thu,  3 Aug 2023 23:28:55 +0530
Message-Id: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

