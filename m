Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220557CD71E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJRI5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJRI5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 04:57:03 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFE449D;
        Wed, 18 Oct 2023 01:57:00 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,234,1694703600"; 
   d="scan'208";a="183503670"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Oct 2023 17:57:00 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0230540116BA;
        Wed, 18 Oct 2023 17:57:00 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v25 00/15] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Wed, 18 Oct 2023 17:56:16 +0900
Message-Id: <20231018085631.1121289-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe controller for both host and endpoint modes.
To support them, modify PCIe DesignWare common codes.

Changes from v24:
https://lore.kernel.org/linux-pci/20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Reordering the patches. (This is suggested by Bjorn.)
 - Drop "PCI: dwc: Disable two BARs to avoid unnecessary memory assignment"
   because break other platforms.
 - Modify the patch for the latest next branch in the patch 04/15.
 - Add specific-setting by using dbi2 again in the patch 12/15.
 - Modify commend of the specific-setting in the patch 12/15. Serge suggested
   this on v23 but I missed to modify this on v24.
 - Fix for -Wincompatible-function-pointer-types-strict  int the patch 13/15.

Changes from v23:
https://lore.kernel.org/linux-pci/20230926122431.3974714-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Remove Link tag and Krzysztof's s-o-b tags from all patches.
 - Drop "PCI: dwc: Expose dw_pcie_write_dbi2() to module".
 - Add "PCI: dwc: Disable two BARs to avoid unnecessary memory assignment".
 - Add Reviewed-by in the patch 0[137]/16 and the patch 1[24]/16.
 - Fix typo in the patch 14/16.
 - Fix error messages and commit descriptions in the patch 1[234]/16.
 - Change the subjects in the patch 1[34]/16.
 - Use aplhabetical order on Kconfig in the patch 1[34]/16.
 - Drop DWC spec code in the patch 13/16. 

Changes from v22:
https://lore.kernel.org/linux-pci/20230925072130.3901087-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Add Reviewed-by in the patch 12/16.
 - Move a few endpoint related code from the patch 13/16 to 14/16.
 - Change subjects in the patch 1[34]/16.
 - Modify the code for readability in the patch 14/16.

Yoshihiro Shimoda (15):
  PCI: Add T_PVPERL macro
  PCI: dwc: Add dw_pcie_link_set_max_link_width()
  PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
  PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
  PCI: dwc: endpoint: Add multiple PFs support for dbi2
  PCI: dwc: Add EDMA_UNROLL capability flag
  PCI: dwc: Expose dw_pcie_ep_exit() to module
  PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
  dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode
  PCI: rcar-gen4: Add endpoint mode support
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
 drivers/pci/controller/dwc/pcie-designware.c  | 101 ++--
 drivers/pci/controller/dwc/pcie-designware.h  |   8 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 527 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    |   6 -
 drivers/pci/pci.h                             |   3 +
 15 files changed, 906 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c

-- 
2.25.1

