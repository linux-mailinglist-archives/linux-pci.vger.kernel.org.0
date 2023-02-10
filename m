Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDCC692019
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 14:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjBJNtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 08:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjBJNtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 08:49:21 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 549623644F;
        Fri, 10 Feb 2023 05:49:20 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,287,1669042800"; 
   d="scan'208";a="152409435"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Feb 2023 22:49:19 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9981246C7F07;
        Fri, 10 Feb 2023 22:49:19 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v9 0/8] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Fri, 10 Feb 2023 22:49:09 +0900
Message-Id: <20230210134917.2909314-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
To support them, modify PCIe DesignWare common codes.

Changes from v8:
https://lore.kernel.org/all/20230131095543.1831875-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on next-20230210.
 - Missing dt-bindings patches accidentally.

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

Yoshihiro Shimoda (8):
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: Add PCI_EXP_LNKCAP_MLW macros
  PCI: designware-ep: Expose dw_pcie_ep_exit() to module
  PCI: dwc: Add support for triggering legacy IRQs
  PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
  PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4

 .../bindings/pci/rcar-gen4-pci-ep.yaml        |  90 +++++++++
 .../bindings/pci/rcar-gen4-pci-host.yaml      |  90 +++++++++
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
 14 files changed, 894 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

