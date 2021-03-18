Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF433FF46
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 07:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCRGId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 02:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhCRGI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 02:08:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12650C06175F
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 23:08:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so6382898pjb.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GhH4cTVoL0LfJc3UZUszeYbDpRmL5TWL1BjWP50Uz4=;
        b=mIubeFddqSR3EKaZVNy5rbrJaHNUXne4naiUVYafpvQO15fTp7eXRmAHopzbbbLyED
         RRQdw09/QKisZ6TGKn8it60oMIU4SxpAMmsjw9CKd0BLSU6GvXJLzGeLVnJFWYLQiLQP
         GfutHjdWILN8FfZlo9XkQiSNhHk2L/q4vVNXboDBpjTEt2cmXtlu3p3K9TiRkiLAaoWS
         W4TAguGoxlSfhHs8xhayrBYiSvoJW8KIAvhCoEmQDxU557DOlUmNLkYWRknx6mWQV73Y
         AYMXkgj5idW282tScN8YI0cUqykrpR0mUckheXXdUo6d9SThPgmR3RGpCrkIAzBLopRe
         lHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GhH4cTVoL0LfJc3UZUszeYbDpRmL5TWL1BjWP50Uz4=;
        b=jRWneHUOlTEzv88kic+uZ7R1K6eBXKkwQd4BsVgi51HC6k5We8DR7p+x6PTrDiurZN
         idWZNb7DSSuLOkn7CQpsjnCvt7wqcw3uZCYiTsl/t7TKkYkxz0U60qr1vTZK4i4Rvxej
         +1qNl1CuSebGaBZabA8UtJMy+G57c/lbE2g3rdE4iZHgoHhWVxWZ8s+t3Ia2FnB4jcR/
         LZeTJCNuq5YVxBXELZd/VofyG1sHTeXteaBNV3hZ1SpAuKzPhaJvKchpE9mfEWW3IaM/
         o92HXoE+LWfvcenz1OHuRp8SZSlrBzQgE5KOlDeGLW9TLAcnoyWjR1Hn1l65it3TvJo5
         vl6g==
X-Gm-Message-State: AOAM533eoSX/rCqpj+0jcfo2uYa+m1GR61Plotn6XXz8VcUYiaewrguj
        EXWxVi8nHAsDplTJ2jKD9gA6AA==
X-Google-Smtp-Source: ABdhPJzeHTjGVcWo4WvxhySCrEqEcLBWg1WasA9ZJ0Y4RCv1bFsY+eYb1iAciVjVCp3+v6vNUtG1yQ==
X-Received: by 2002:a17:902:9304:b029:e6:8d24:b5ce with SMTP id bc4-20020a1709029304b02900e68d24b5cemr7821316plb.27.1616047707395;
        Wed, 17 Mar 2021 23:08:27 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 68sm967353pfd.75.2021.03.17.23.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:08:26 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: [PATCH v2 0/6] Add SiFive FU740 PCIe host controller driver support
Date:   Thu, 18 Mar 2021 14:08:07 +0800
Message-Id: <cover.1615954045.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset includes SiFive FU740 PCIe host controller driver. We also
add pcie_aux clock and pcie_power_on_reset controller to prci driver for
PCIe driver to use it.

This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
v5.11 Linux kernel.

Changes in v2:
 - Refine codes based on reviewers' feedback
 - Remove define and use the common one
 - Replace __raw_writel with writel_relaxed
 - Split fu740_phyregreadwrite to write function
 - Use readl_poll_timeout in stead of while loop checking
 - Use dwc common codes
 - Use gpio descriptors and the gpiod_* api.
 - Replace devm_ioremap_resource with devm_platform_ioremap_resource_byname
 - Replace devm_reset_control_get with devm_reset_control_get_exclusive
 - Add more comments for delay and sleep
 - Remove "phy ? x : y" expressions
 - Refine code logic to remove possible infinite loop
 - Replace magic number with meaningful define
 - Remove fu740_pcie_pm_ops
 - Use builtin_platform_driver

Greentime Hu (5):
  clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
  clk: sifive: Use reset-simple in prci driver for PCIe driver
  MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
  dt-bindings: PCI: Add SiFive FU740 PCIe host controller
  riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC

Paul Walmsley (1):
  PCI: fu740: Add SiFive FU740 PCIe host controller driver

 .../bindings/pci/sifive,fu740-pcie.yaml       | 119 +++++++
 MAINTAINERS                                   |   8 +
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  34 ++
 drivers/clk/sifive/Kconfig                    |   2 +
 drivers/clk/sifive/fu740-prci.c               |  11 +
 drivers/clk/sifive/fu740-prci.h               |   2 +-
 drivers/clk/sifive/sifive-prci.c              |  54 +++
 drivers/clk/sifive/sifive-prci.h              |  13 +
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-fu740.c       | 324 ++++++++++++++++++
 drivers/reset/Kconfig                         |   3 +-
 include/dt-bindings/clock/sifive-fu740-prci.h |   1 +
 13 files changed, 579 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c

-- 
2.30.2

