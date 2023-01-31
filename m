Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C06829AA
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 10:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjAaJzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjAaJzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 04:55:51 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2A8846715;
        Tue, 31 Jan 2023 01:55:48 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,259,1669042800"; 
   d="scan'208";a="147983400"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2023 18:55:48 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1D8FB4001B72;
        Tue, 31 Jan 2023 18:55:48 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v8 0/6] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Tue, 31 Jan 2023 18:55:37 +0900
Message-Id: <20230131095543.1831875-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
To support them, modify PCIe DesignWare common codes.

Changes from v7:
https://lore.kernel.org/all/20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on next-20230131.
 - Update Copyright year of new files.
 - Add a new capability flag (DW_PCIE_CAP_EDMA_UNROLL) for finding eDMA on
   R-Car S4-8.
 - Remove some PCIe configurations like L1 substates from pcie-rcar-gen4-host.c.
 - Change timing of reset_control for suitable this hardware initialization.
 - Add gpio reset handling for host mode.
 - Capitalize the first charactors on each printk message.

Changes from v6:
 https://lore.kernel.org/all/20220922080647.3489791-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on next-20221116.
 -- And based on the following patches:
    [PATCH v7 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
    https://lore.kernel.org/linux-pci/20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru/
    [PATCH v6 00/24] dmaengine: dw-edma: Add RP/EP local DMA controllers support
    https://lore.kernel.org/linux-pci/20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru/
 - Update dt-bindings docs for the latest based code.
 - Add support for triggering legacy IRQs in the patch [06/10] (new).
 - Add .no_msix flag into the patch [07/10].
 - Merge .ep_pre_init() support into the patch [08/10].
 - Add .reserved_bar for BAR5 instead in the patch [08/10].
 - Change SPDX-License-Identifier from "GPL-2.0" to "GPL-2.0-only".

Yoshihiro Shimoda (6):
  PCI: Add PCI_EXP_LNKCAP_MLW macros
  PCI: designware-ep: Expose dw_pcie_ep_exit() to module
  PCI: dwc: Add support for triggering legacy IRQs
  PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
  PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4

 MAINTAINERS                                   |   1 +
 drivers/pci/controller/dwc/Kconfig            |  18 ++
 drivers/pci/controller/dwc/Makefile           |   4 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  70 ++++++-
 .../pci/controller/dwc/pcie-designware-host.c |   3 +
 drivers/pci/controller/dwc/pcie-designware.c  |  33 +++-
 drivers/pci/controller/dwc/pcie-designware.h  |  19 +-
 .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 185 ++++++++++++++++++
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 165 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 166 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  63 ++++++
 include/uapi/linux/pci_regs.h                 |   6 +
 12 files changed, 714 insertions(+), 19 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

