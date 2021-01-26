Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F74303D3B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 13:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403800AbhAZMk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 07:40:58 -0500
Received: from muru.com ([72.249.23.125]:53318 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391625AbhAZMk5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 07:40:57 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id E4CD58057;
        Tue, 26 Jan 2021 12:40:19 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCHv2 00/15] Update dra7 devicetree files to probe with genpd
Date:   Tue, 26 Jan 2021 14:39:49 +0200
Message-Id: <20210126124004.52550-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Here's v2 series to update dra7 to probe with ti-sysc and genpd like we've
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

Changes since v1:

- Split the series into two parts, looks like most of the emails did not
  make it to the lists

- Dropped Balaji from Cc as the email address bounces

[0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git tmp-testing-genpd-dra7
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v5.12/tmp-testing-genpd-dra7

Tony Lindgren (15):
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

 arch/arm/boot/dts/dra7-l4.dtsi          |  76 ++++++---
 arch/arm/boot/dts/dra7.dtsi             | 216 ++++++++++++++++--------
 drivers/pci/controller/dwc/pci-dra7xx.c |  13 +-
 3 files changed, 213 insertions(+), 92 deletions(-)

-- 
2.30.0
