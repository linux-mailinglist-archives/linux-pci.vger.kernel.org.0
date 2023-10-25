Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F67D7567
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYUYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjJYUYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:24:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8612A
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:24:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-577fff1cae6so96455a12.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265449; x=1698870249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9/pedB262IMNHEh1PUtoWlFeNdn65+nq0ZZR6F2re8=;
        b=KDBnVad/L98ks9dD6PFiobWlP+Y3q+9Zm0vjzN3/+4omI65ozoSxrD30/6HzY+mbQM
         H6IwEnthNvfRwxUvup1anEfy2bOrqPYRKxmyXL8n7RErVvzVMLkMSVCO7hpfrjYtH967
         DjN2SsObKv5oVudbtz50lcuB4ySHSDcD6Wh6SOMfo2yD3D+YqW0nTUr0e5GspcQSN1RR
         0SQngTgKrPvDXXIV4axCjPlx5lK03PX8xn98jaouG9PAq2gCBMUUmhBYWJdAC6qDUJ0p
         LWmZI7tMzbAE30w6Pfmzr9D5j2bPqBiUqkDxoC4PhCl3ovTi17+Z+lXxmFwU3u+0FhpL
         rZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265449; x=1698870249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9/pedB262IMNHEh1PUtoWlFeNdn65+nq0ZZR6F2re8=;
        b=ExRBOp0sFvs8jBfrkB4kOl3XzVMA0l0h5TWKpOxz1Hf4wlfEbgt6Dib3gyiKy9j3HS
         iz5usV0ET6VHOJKVZg2+7F1qLQ6KYKmxXg5KTqeOEVO5eON1xI1p31F0kcsCJn7HhQMT
         B3c3FWgBS2wxlEPCK0xt1nT+yXV6jQgtNPeoYcF2JkemUogpJhykwny+/A42mBhIY6EB
         z0oOW/NvA/ECIk2Ehd20zbfFf+/bASfpr8I+RAhx8R+/ylSE68yqJGSHnYccAFonJlPJ
         8DZocgPmLJECOCJXPapTDVGqBW5HdkhoY8wgI1jjerUx0jHS/SpT+EETfH+x52SyRAOx
         spQg==
X-Gm-Message-State: AOJu0YzQnf3Ren0fgzzlJc/fmn0MDDdnABlQRriKkw/AIyPxtPEUnqaU
        05TOysCp0A7XP0jjaNp6kZ/3og==
X-Google-Smtp-Source: AGHT+IEV4o/13i3hZesUJvr2asiwuxud0jha6gl4OJB79xQ7DR2BCPeSNSC6qZTwPjauiylzsIcCjw==
X-Received: by 2002:a05:6a20:8e12:b0:14e:2208:d62f with SMTP id y18-20020a056a208e1200b0014e2208d62fmr801359pzj.22.1698265448502;
        Wed, 25 Oct 2023 13:24:08 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:08 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 00/21] RISC-V: ACPI: Add external interrupt controller support 
Date:   Thu, 26 Oct 2023 01:53:23 +0530
Message-Id: <20231025202344.581132-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the below ECR approved by ASWG.
1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing

The series primarily enables irqchip drivers for RISC-V ACPI based
platforms.

In addition, PCI ACPI related functions are migrated from arm64 to
common file so that we don't need to duplicate them for RISC-V.

On RISC-V platforms, apart from root irqchips which provide local
interrupts and IPI, all other interrupt controllers are probed late
during boot. Hence, the drivers for the devices connected to these
interrupt controllers which are probed late, should also support
deferred probe. While ACPI platform devices/drivers seem to support
deferred probe since they use acpi_irq_get(), the PNP devices and the
PCI INTx expect GSIs are registered early. So, patches are required
to enable few essential drivers to support deferred probe. To minimize
the impact, a new CONFIG option is introduced which can be enabled only
by the architecture like RISC-V which supports deferred irqchip probe.

This series is based on Anup's AIA v11 series. Since Anup's AIA v11 is
not merged yet and first time introducing deferred probe, this series is
still kept as RFC. Looking forward for the feedback!

Changes since RFC v1:
	1) Abandoned swnode approach as per Marc's feedback.
	2) To cope up with AIA series changes which changed irqchip driver
	   probe from core_initcall() to platform_driver, added patches
	   to support deferred probing.
	3) Rebased on top of Anup's AIA v11 and added tags.

To test the series,

1) Qemu should be built using the riscv_acpi_b2_v4 branch at
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

This series is also available in acpi_b2_v2_riscv_aia_v11 branch at
https://github.com/vlsunil/linux.git

Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
(https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro.com/)

Sunil V L (21):
  arm64: PCI: Migrate ACPI related functions to pci-acpi.c
  RISC-V: ACPI: Implement PCI related functionality
  ACPI: Kconfig: Introduce new option to support deferred GSI probe
  ACPI: irq: Add support for deferred probe in acpi_register_gsi()
  pnp.h: Return -EPROBE_DEFER for disabled IRQ resource in pnp_irq()
  RISC-V: Kconfig: Select deferred GSI probe for ACPI systems
  serial: 8250_pnp: Add support for deferred probe
  ACPI: pci_irq: Avoid warning for deferred probe in
    acpi_pci_irq_enable()
  ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
    probe
  ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
  PCI: MSI: Add helper function to set system wide MSI support
  PCI: pci-acpi.c: Return correct value from pcibios_alloc_irq()
  irqchip: riscv-intc: Add ACPI support for AIA
  irqchip: riscv-imsic: Add ACPI support
  irqchip: riscv-aplic: Add ACPI support
  irqchip: irq-sifive-plic: Add ACPI support
  ACPI: bus: Add RINTC IRQ model for RISC-V
  irqchip: riscv-intc: Set ACPI irqmodel
  ACPI: bus: Add acpi_riscv_init function
  ACPI: RISC-V: Create APLIC platform device
  ACPI: RISC-V: Create PLIC platform device

 arch/arm64/kernel/pci.c                    | 191 ---------------------
 arch/riscv/Kconfig                         |   3 +
 arch/riscv/include/asm/irq.h               |  31 ++++
 arch/riscv/kernel/acpi.c                   |  31 ++--
 drivers/acpi/Kconfig                       |   3 +
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/irq.c                         |  12 +-
 drivers/acpi/pci_irq.c                     |   7 +-
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  15 ++
 drivers/acpi/riscv/init.h                  |   6 +
 drivers/acpi/riscv/irq.c                   | 120 +++++++++++++
 drivers/acpi/scan.c                        |   3 +
 drivers/irqchip/irq-riscv-aplic-direct.c   |  22 ++-
 drivers/irqchip/irq-riscv-aplic-main.c     | 105 ++++++++---
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |  10 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  52 +++++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  51 ++++--
 drivers/irqchip/irq-riscv-imsic-state.c    | 128 +++++++-------
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           | 114 +++++++++++-
 drivers/irqchip/irq-sifive-plic.c          | 113 ++++++++++--
 drivers/pci/msi/msi.c                      |   5 +
 drivers/pci/pci-acpi.c                     | 182 ++++++++++++++++++++
 drivers/pci/pci.h                          |   2 +
 drivers/tty/serial/8250/8250_pnp.c         |  18 +-
 include/linux/acpi.h                       |   9 +
 include/linux/irqchip/riscv-imsic.h        |  10 ++
 include/linux/pnp.h                        |  10 +-
 30 files changed, 906 insertions(+), 356 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irq.c

-- 
2.39.2

