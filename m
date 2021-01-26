Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DB3304457
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 18:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbhAZRAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:00:37 -0500
Received: from muru.com ([72.249.23.125]:52936 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390008AbhAZI2C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:28:02 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C4E5C8057;
        Tue, 26 Jan 2021 08:27:23 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 00/27] Update dra7 to probe with genpd to drop legacy pdata
Date:   Tue, 26 Jan 2021 10:26:49 +0200
Message-Id: <20210126082716.54358-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Here's a series to update dra7 to probe with ti-sysc and genpd like we've
already done for am3 and 4.

These patches are against v5.11-rc1, and depend on the following commits
in my fixes branch:

7078a5ba7a58 ("soc: ti: omap-prm: Fix boot time errors for rst_map_012 bits 0 and 1")
2a39af3870e9 ("ARM: OMAP2+: Fix booting for am335x after moving to simple-pm-bus")

These patches also depend on the series:

[PATCH 0/3] Few ti-sysc changes for v5.12 merge window

Please review and test, I've also pushed out a temporary testing branch to
make testing easier to [0][1].

Regards,

Tony

[0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git tmp-testing-genpd-dra7
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v5.12/tmp-testing-genpd-dra7

Tony Lindgren (27):
  PCI: pci-dra7xx: Prepare for deferred probe with
    module_platform_driver
  ARM: dts: Update pcie ranges for dra7
  ARM: dts: Configure interconnect target module for dra7 pcie
  ARM: dts: Properly configure dra7 edma sysconfig registers
  ARM: dts: Move dra7 l3 noc to a separate node
  ARM: dts: Configure interconnect target module for dra7 qspi
  ARM: dts: Configure interconnect target module for dra7 sata
  ARM: dts: Configure interconnect target module for dra7 mpu
  ARM: dts: Configure interconnect target module for dra7 dmm
  ARM: dts: Configure simple-pm-bus for dra7 l4_wkup
  ARM: dts: Configure simple-pm-bus for dra7 l4_per1
  ARM: dts: Configure simple-pm-bus for dra7 l4_per2
  ARM: dts: Configure simple-pm-bus for dra7 l4_per3
  ARM: dts: Configure simple-pm-bus for dra7 l4_cfg
  ARM: dts: Configure simple-pm-bus for dra7 l3
  ARM: OMAP2+: Drop legacy platform data for dra7 pcie
  ARM: OMAP2+: Drop legacy platform data for dra7 qspi
  ARM: OMAP2+: Drop legacy platform data for dra7 sata
  ARM: OMAP2+: Drop legacy platform data for dra7 mpu
  ARM: OMAP2+: Drop legacy platform data for dra7 dmm
  ARM: OMAP2+: Drop legacy platform data for dra7 l4_wkup
  ARM: OMAP2+: Drop legacy platform data for dra7 l4_per1
  ARM: OMAP2+: Drop legacy platform data for dra7 l4_per2
  ARM: OMAP2+: Drop legacy platform data for dra7 l4_per3
  ARM: OMAP2+: Drop legacy platform data for dra7 l4_cfg
  ARM: OMAP2+: Drop legacy platform data for dra7 l3
  ARM: OMAP2+: Drop legacy platform data for dra7 hwmod

 arch/arm/boot/dts/dra7-l4.dtsi            |  75 ++-
 arch/arm/boot/dts/dra7.dtsi               | 220 ++++---
 arch/arm/mach-omap2/Kconfig               |   1 -
 arch/arm/mach-omap2/Makefile              |   1 -
 arch/arm/mach-omap2/common.h              |   9 -
 arch/arm/mach-omap2/io.c                  |   2 -
 arch/arm/mach-omap2/omap_hwmod.c          |   8 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 719 ----------------------
 drivers/pci/controller/dwc/pci-dra7xx.c   |  13 +-
 9 files changed, 211 insertions(+), 837 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_7xx_data.c

-- 
2.30.0
