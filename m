Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734AE350EA5
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 08:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhDAGBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 02:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhDAGBC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 02:01:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2181C06178C
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h3so636405pfr.12
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAkl8M4METQp4Mm9sKB+PbWAOillZ+9QKk7wqLzx2ik=;
        b=kloLjxLfd0OejQ8NPmE8+w+AelvEtQ5wlqJ/yxgI5sdP1+zxwHWcGzRx3VUVckPvL2
         aLtsS2kfCfKKF8sTKs1VW8qVlADk/o6dFe1E5Nbmoc/sjbs8olBc0UZv+fQBpJebk4Z5
         pC6TA6HkeTJJFxjjiIGACxFskYggw8STbfmDHlcuBtkilS3q1OlLKTE81NO7/BsR+WfD
         CEi1IvIy8YeeaQtRv3onLS6bt0TSdb86oRp6gLVvO26l7P/24TCZyJ/8O0b+6S+8MAjY
         pKVWBVvheFwbcIGltFqdAwZtCmdyiEKGZd7briO0U3NPokgMa/UKrqA9xVGMHxz3+j7Q
         5XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAkl8M4METQp4Mm9sKB+PbWAOillZ+9QKk7wqLzx2ik=;
        b=rWUj2CA8Qcowb44ecT465OUJajjZsmpO9riRY9zFzDI2i7dIHWLHvURSs49TDTRuQp
         KCvf4zjYfDUyk2vzpEYQqkCheE6GI3nxEeaH+P45as2Nu+U0FnIRQcubptSgJOYPQHUm
         Afh4ck0myQYgvwQFgGHTw4LSZrqykhv7dYdo5eNWXSrXAkKzVAW0PSTXtE013Rkh8gQL
         ytZdRlpYS0J9Kh7rgco2md6JUV4mV5u5KkXbySGq/aEmxqsKfTr4XIV/arkIIxJ4HTRH
         Fj5fYH5I9bkS07QtT96AnCnSvCJ4B2OCfpMB1nq0zdsLhg5SWMHjyD5h/Niw1n20Boe6
         qukw==
X-Gm-Message-State: AOAM533nzPoFADMpjXqFpX1xx8L+pjo1BJkgAoqBhRtXuiMboZI3mLhw
        2OV9NBiueH+om0RQqlu4g1GWoA==
X-Google-Smtp-Source: ABdhPJxaVYjdSka2klDIXVKJNz6O8INGxI7E/EAZ0NbbLCwgWADxmkZYkF03MJkl85Ic1XBys+NkDg==
X-Received: by 2002:a63:f443:: with SMTP id p3mr6118424pgk.378.1617256861296;
        Wed, 31 Mar 2021 23:01:01 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id a6sm4037328pfc.61.2021.03.31.23.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:01:00 -0700 (PDT)
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
Subject: [PATCH v4 0/6] Add SiFive FU740 PCIe host controller driver support
Date:   Thu,  1 Apr 2021 14:00:48 +0800
Message-Id: <20210401060054.40788-1-greentime.hu@sifive.com>
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

