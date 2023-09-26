Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27817AEC8C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjIZMYq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIZMYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 08:24:45 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 161CEEB;
        Tue, 26 Sep 2023 05:24:37 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; 
   d="scan'208";a="177299696"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Sep 2023 21:24:36 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B1FBC41FAD07;
        Tue, 26 Sep 2023 21:24:36 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v23 00/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Tue, 26 Sep 2023 21:24:15 +0900
Message-Id: <20230926122431.3974714-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe controller for both host and endpoint modes.
To support them, modify PCIe DesignWare common codes.

Changes from v22:
https://lore.kernel.org/linux-pci/20230925072130.3901087-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Add Reviewed-by in the patch 12/16.
 - Move a few endpoint related code from the patch 13/16 to 14/16.
 - Change subjects in the patch 1[34]/16.
 - Modify the code for readability in the patch 14/16.

Changes from v21:
https://lore.kernel.org/linux-pci/20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Fix -Wmissing-prototypes warnings that was reported by kernel test robot:
   https://lore.kernel.org/linux-pci/202309222125.KiN4nFhD-lkp@intel.com/

Changes from v20 + squash patches:
https://lore.kernel.org/linux-pci/20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com/
https://lore.kernel.org/linux-pci/20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Cherry-picked almost all patches from the pci.git / controller/rcar branch
   for squashing.
  - But, drop the following patches which are related to INTx.
     eb185e1e628a PCI: designware-ep: Add INTx IRQs support
     5d0e51f85b23 PCI: dwc: Add outbound MSG TLPs support
     4758bef61cc2 PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
     44938b13046b PCI: Add INTx Mechanism Messages macros
 - Add a new macro T_PVPERL in the patch 12/16.
 - Merge pcie-rcar-gen4-{ep,host}-drv.c and pcie-rcar-gen4.h files into
   pcie-rcar-gen4.c.
 - Add CONFIG_PCIE_RCAR_GEN4_HOST config.
 - Fix some comments.
 - Change return type of rcar_gen4_pcie_speed_change().
 - Add registers' full names as comments.
 - Rename function names of rcar_gen4_{add,remove}_pcie_ep() to
   rcar_gen4_{add,remove}_dw_pcie_ep() for consistency.

Yoshihiro Shimoda (16):
  PCI: dwc: endpoint: Add multiple PFs support for dbi2
  PCI: dwc: Add dw_pcie_link_set_max_link_width()
  PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
  PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
  PCI: dwc: Add EDMA_UNROLL capability flag
  PCI: dwc: Expose dw_pcie_ep_exit() to module
  PCI: dwc: Expose dw_pcie_write_dbi2() to module
  PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
  dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: add T_PVPERL macro
  PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe controller support for host
    mode
  PCI: dwc: rcar-gen4: Add endpoint mode support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
  misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

 .../bindings/pci/rcar-gen4-pci-ep.yaml        | 115 ++++
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 127 +++++
 .../bindings/pci/snps,dw-pcie-common.yaml     |   4 +-
 .../bindings/pci/snps,dw-pcie-ep.yaml         |   4 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
 MAINTAINERS                                   |   1 +
 drivers/misc/pci_endpoint_test.c              |   4 +
 drivers/pci/controller/dwc/Kconfig            |  25 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  45 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 102 ++--
 drivers/pci/controller/dwc/pcie-designware.h  |   8 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 526 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    |   6 -
 drivers/pci/pci.h                             |   3 +
 15 files changed, 906 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c

-- 
2.25.1

