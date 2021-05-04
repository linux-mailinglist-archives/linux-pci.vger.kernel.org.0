Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F8E372944
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 13:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhEDLBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 07:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEDLBJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 07:01:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAB7C061761
        for <linux-pci@vger.kernel.org>; Tue,  4 May 2021 04:00:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x188so4991874pfd.7
        for <linux-pci@vger.kernel.org>; Tue, 04 May 2021 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJIjfEJRJ7Pr4p4QG/w4Mq8dVNNzEKWBtUNtLtPuDVY=;
        b=B2c0fA+WY+d4YSzIml/LTUKhzsTlkS1ULrQt0iy93gdLCTT/XapkzdZ6w+cwRJFWfd
         IQB9T/YmcJHkamNW8DznWDqVsfHhdAXAuOxzGaxYwtwO2D/w9XsmfWCiOnhuV7B23j9A
         Qejpj1XZUensXy+InEnvf91fz8If3aB2yYiRQC+9Apzfrfn4d1ApRIH8g7e42y+HHUX/
         12L+wHKYzr30nGVl8ShOfuwl8E3VpiuF1gzDmBO24m1Vpsy5GUzayamBVbKrdalVVM6b
         yKoLnZ8NToFdzsYvpcp441jUw700s+n3ySfHxjE32s3GhlDfh3TI5wySW/RrM5OF3VgB
         xmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJIjfEJRJ7Pr4p4QG/w4Mq8dVNNzEKWBtUNtLtPuDVY=;
        b=ASZjy8BfLpQ4pjZk9v+xM4ECeaXHBuNROsqtXqfZ+idhaOpkcSpChrJNZovkjcC0wd
         JtEwLjmmuJYYC/1AXCZI4GSjvQ4ih+HknsFqrMnbEZZwHQmKQt42owGvl5W8rLLgO+W0
         YSqT+LZg4nZetOEqBkrNq4J2it1jwW6DBD6d2S86eEUTJjqMFVnd0nyLiHp4YSRi63kk
         06TGOTcEusYzUmXMz/t2qHohSeVidC3Wtoj2JY2GGR6stepoeIi/EN4aHaXl90svptEo
         8ZsLTQyZbvw1PhjaUnCYfF/cFva97r6aDyNhaq+U6IOkvHKpNCi3R3YwGo3ZO/iJ+kVL
         1d0g==
X-Gm-Message-State: AOAM530wNAjN0yKHYhUWt6wxmeShttbIDD5QdPZENjLI4T7GliRS1BOQ
        T9fqnUJyZasOhREEhpu3OJVq4g==
X-Google-Smtp-Source: ABdhPJwlO973vBwZXAhgpxC+3mmoQWgrmYIE12W3oa3frr5nBO6fYbyhs92WeZVYoUrtaNbZnD8tyQ==
X-Received: by 2002:a17:90a:e615:: with SMTP id j21mr4340982pjy.43.1620126014199;
        Tue, 04 May 2021 04:00:14 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id k17sm11762529pfa.68.2021.05.04.04.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:00:13 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: [PATCH v6 0/6] Add SiFive FU740 PCIe host controller driver support
Date:   Tue,  4 May 2021 18:59:34 +0800
Message-Id: <20210504105940.100004-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
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

Changes in v6:
 - Fix build error when CONFIG_GPIOLIB disabled

Changes in v5:
 - Fix typo in comments
 - Keep comments style consistent
 - Refine some error handling codes
 - Remove unneeded header file including
 - Merge fu740_pcie_ltssm_enable implementation to fu740_pcie_start_link

Changes in v4:
 - Fix Wunused-but-set-variable warning in prci driver

Changes in v3:
 - Remove items that has been defined
 - Refine format of sifive,fu740-pcie.yaml
 - Replace perstn-gpios with the common one
 - Change DBI mapping space to 2GB from 4GB
 - Refine drivers/reset/Kconfig

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

 .../bindings/pci/sifive,fu740-pcie.yaml       | 113 +++++++
 MAINTAINERS                                   |   8 +
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  33 ++
 drivers/clk/sifive/Kconfig                    |   2 +
 drivers/clk/sifive/fu740-prci.c               |  11 +
 drivers/clk/sifive/fu740-prci.h               |   2 +-
 drivers/clk/sifive/sifive-prci.c              |  54 +++
 drivers/clk/sifive/sifive-prci.h              |  13 +
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-fu740.c       | 309 ++++++++++++++++++
 drivers/reset/Kconfig                         |   1 +
 include/dt-bindings/clock/sifive-fu740-prci.h |   1 +
 13 files changed, 557 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c

-- 
2.31.1

