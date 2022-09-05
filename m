Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EDA5ACC66
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiIEHTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 03:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiIEHSt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 03:18:49 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69E4A4CA3E;
        Mon,  5 Sep 2022 00:14:00 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,290,1654527600"; 
   d="scan'208";a="133728184"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Sep 2022 16:13:08 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id CC4604004461;
        Mon,  5 Sep 2022 16:13:08 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v5 00/12] treewide: PCI: renesas: Add R-Car Gen4 PCIe support
Date:   Mon,  5 Sep 2022 16:12:45 +0900
Message-Id: <20220905071257.1059436-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
To support them, modify PCIe DesignWare common codes.

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

Yoshihiro Shimoda (12):
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: Add PCI_EXP_LNKCAP_MLW macros
  PCI: controller: dwc: Expose dw_pcie_ep_exit() to module
  PCI: dwc: Add ep_pre_init() callback to dw_pcie_ep_ops
  PCI: dwc: Add reset_all_bars flag
  PCI: dwc: Avoid reading a register to detect whether eDMA exists
  PCI: renesas: Add R-Car Gen4 PCIe Host support
  PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
  arm64: dts: renesas: r8a779f0: Add PCIe Host and Endpoint nodes
  arm64: dts: renesas: r8a779f0: spider: Enable PCIe Host ch0

 .../bindings/pci/rcar-gen4-pci-ep.yaml        |  99 +++++++++
 .../bindings/pci/rcar-gen4-pci-host.yaml      |  97 +++++++++
 MAINTAINERS                                   |   1 +
 .../boot/dts/renesas/r8a779f0-spider-cpu.dtsi |  39 ++++
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     | 122 +++++++++++
 drivers/pci/controller/dwc/Kconfig            |  18 ++
 drivers/pci/controller/dwc/Makefile           |   4 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  14 ++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 182 ++++++++++++++++
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 195 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 181 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  63 ++++++
 include/uapi/linux/pci_regs.h                 |   7 +
 15 files changed, 1026 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

