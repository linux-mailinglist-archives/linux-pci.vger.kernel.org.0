Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BB34FCA6
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 11:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhCaJ0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbhCaJ0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 05:26:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D4C061574
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ha17so9198660pjb.2
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptAj4yv/V2YXF5TVjwqAvjZ15acpk75vmMod83zctB4=;
        b=HQlqMib2bg7AIt68guokCMcx0XMKUJiIOKWHOgQH8UJTwGJBDFDPpVMysvWj6AEMo2
         7jekLfcHYDhiOBDMvr2ZE6n0hFwDEM235djLQ3+DbxnW3shM8RAZ/9TbkKOe1AF62cAX
         Y4Mom0nLwfn1UCptK1wz1RDrTiw+WVnUZjTDYNA1uAXgE57jgvdoM2t0s/qxeCO1od1c
         ImeDG7ME+JGqw3sqAG8Fqe/WYsZxsIWTATya28k2x03YqXN4YZEy0La2NHLeUzenMx+8
         +GMLuZBh0MD+UzTllV4HlY890/ZUXG6XaWzcStTtwudtZSmciThjP7k5Kq1inYAtKuGn
         1stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptAj4yv/V2YXF5TVjwqAvjZ15acpk75vmMod83zctB4=;
        b=dnvrprJu2NLAhbEIE5XIduP62ov4de+KKKlihi3YtxKtHJyYG9Fk4EiP0qYWoTsUc2
         zKoOXFRGccOb8pqAcpRQDKfjyWaH6uevehcFGVi8weZSYplGCRy4+4AWFKHaJpkdO5E0
         3Jm6t24SYXPCXBOI8U1kp0g2bFl5Ds1OYzcZ7e/Ii73UdI/XXm0KMm+KvsChwcObG1dN
         JsHddCRVb5ZydmzeNT7+mwADo0qNAH7JZt+S8SuDsebBbNK4VrL6KBY/5PLJsPEolp/8
         7UdBxOzWQkKyqVRFbvnkrMpdxE7dDGrJ/pf3Vf5WZDaBiOzEt5mDMmLiNQS88sacX5Mb
         QXVQ==
X-Gm-Message-State: AOAM533xaaKU+ML+1ejeXalNWvGQ5q1SWnmNR/7uefjP2IfGh9O47r03
        ItshW7d63QMcttpIxzQlAZuWow==
X-Google-Smtp-Source: ABdhPJyU6iv5HYECCCvfUvDFEX7gJ9XfaG9BZebwyBes+Az9+1iCyEo1gUauWR+aWZMul3kAfgkngg==
X-Received: by 2002:a17:90a:c249:: with SMTP id d9mr2655658pjx.104.1617182776459;
        Wed, 31 Mar 2021 02:26:16 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 143sm1726505pfx.144.2021.03.31.02.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:26:15 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Add SiFive FU740 PCIe host controller driver support
Date:   Wed, 31 Mar 2021 17:25:59 +0800
Message-Id: <20210331092605.105909-1-greentime.hu@sifive.com>
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

 .../bindings/pci/sifive,fu740-pcie.yaml       | 109 ++++++
 MAINTAINERS                                   |   8 +
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  33 ++
 drivers/clk/sifive/Kconfig                    |   2 +
 drivers/clk/sifive/fu740-prci.c               |  11 +
 drivers/clk/sifive/fu740-prci.h               |   2 +-
 drivers/clk/sifive/sifive-prci.c              |  54 +++
 drivers/clk/sifive/sifive-prci.h              |  13 +
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-fu740.c       | 324 ++++++++++++++++++
 drivers/reset/Kconfig                         |   1 +
 include/dt-bindings/clock/sifive-fu740-prci.h |   1 +
 13 files changed, 567 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c

-- 
2.30.2

