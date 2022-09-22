Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B85E5CEC
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIVIHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIVIHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 04:07:08 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 484DDB40D9;
        Thu, 22 Sep 2022 01:07:07 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,335,1654527600"; 
   d="scan'208";a="135810761"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Sep 2022 17:07:06 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A84084185388;
        Thu, 22 Sep 2022 17:07:06 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v6 00/10] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Thu, 22 Sep 2022 17:06:37 +0900
Message-Id: <20220922080647.3489791-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
To support them, modify PCIe DesignWare common codes.
Base kernel is the same as v5.

Changes from v5:
 https://lore.kernel.org/all/20220905071257.1059436-1-yoshihiro.shimoda.uh@renesas.com/
 - No treewide patches.
 - Drop PCI_EXP_LNKCAP_MLW_X32 in patch [03/10].
 - Add Acked-by in patch [03/10].
 - Fix subject prefix in patch [04/10], [05/10], [08/10] and [09/10].
 - Fix typo in patch [05/10] and [07/10].

Changes from v4:
 https://lore.kernel.org/all/20220722110744.2274466-1-yoshihiro.shimoda.uh@renesas.com/
 - Rebased on next-20220901.
 -- And based on the following patches:
    [PATCH v5 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
    https://lore.kernel.org/linux-pci/20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru/
    [PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA controllers support
    https://lore.kernel.org/dmaengine/20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru/
 - Notes that snps,dw-pcie-common.yaml modification seems under construction
   so that dt-bindings of R-Car Gen4 is based on next-20220901.

Yoshihiro Shimoda (10):
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: Add PCI_EXP_LNKCAP_MLW macros
  PCI: designware-ep: Expose dw_pcie_ep_exit() to module
  PCI: designware-ep: Add ep_pre_init() callback to dw_pcie_ep_ops
  PCI: dwc: Add reset_all_bars flag
  PCI: dwc: Avoid reading a register to detect whether eDMA exists
  PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
  PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4

 .../bindings/pci/rcar-gen4-pci-ep.yaml        |  99 +++++++++
 .../bindings/pci/rcar-gen4-pci-host.yaml      |  97 +++++++++
 MAINTAINERS                                   |   1 +
 drivers/pci/controller/dwc/Kconfig            |  18 ++
 drivers/pci/controller/dwc/Makefile           |   4 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  14 ++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 182 ++++++++++++++++
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 195 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 181 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  63 ++++++
 include/uapi/linux/pci_regs.h                 |   6 +
 13 files changed, 864 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

