Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540022FF4B2
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 20:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbhAUThW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 14:37:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:14401 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbhAUTde (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 14:33:34 -0500
IronPort-SDR: 9beEo0O2O2pOcojCPL1GUridj71We0ss/Wrdj/GYmsM+GMk4HYqGHlmvFahISPet1nS6n1d2fc
 3pls3UEZCqMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="166425921"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="166425921"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 11:32:53 -0800
IronPort-SDR: 71iIBiTk7HTcDqhSl+0nPgfg5Ew8mi8bJqt76hWwZkXalxc2OoaTARUN3V340ExBIOcgszEq6a
 jIWfu0EDOmlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="367027293"
Received: from intel-z390-ud.iind.intel.com ([10.223.252.51])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2021 11:32:49 -0800
From:   srikanth.thokala@intel.com
To:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, srikanth.thokala@intel.com
Subject: [PATCH v6 0/2] PCI: keembay: Add support for Intel Keem Bay
Date:   Fri, 22 Jan 2021 08:56:08 +0530
Message-Id: <20210122032610.4958-1-srikanth.thokala@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Hi,

The first patch is to document DT bindings for Keem Bay PCIe controller
for both Root Complex and Endpoint modes.

The second patch is the driver file, a glue driver. Keem Bay PCIe
controller is based on DesignWare PCIe IP.

The patch was tested with Keem Bay evaluation module board, with A0
stepping.

I would also like to inform that I will be taking ownership of this patch
series from this version as the previous author moved out of the organization.

Kindly review.

Thanks!
Srikanth

Changes since v5:
- Rebased to v5.11-rc4.
- Updated maintainers to add myself in DT binding documents.
- Fix checkpatch issues.

Changes since v4:
- Rebased to v5.11-rc1 and retest.

Changes since v3:
- Add Reviewed-by: Rob Herring <robh@kernel.org> tag in dt-bindings
  patch.
- Remove the keembay_pcie_{readl,writel} wrappers. And replace them with
  readl() and writel().
- Remove the dead code related to unused irqs.
- Remove unused definition for unused irqs.
- In keembay_pcie_ep_init(), initialize enabled interrupts to known state.
- Rebased to next-20201215.

Changes since v2:
- In keembay_pcie_probe(), use return keembay_pcie_add_pcie_port(pcie,
  pdev); statement and remove return 0; at the end of the function.

Changes since v1:
- In dt-bindings patch.
  - Fixed indent warning for compatible property.
  - Rename interrupt-names to pcie, pcie_ev, pcie_err and
    pcie_mem_access, similar to the name used in datasheet.
  - Remove device_type, #address-cells and #size-cells property.
  - Remove num-viewport, num-ib-windows and num-ob-windows property.
  - Replace additionalProperties with unevaluatedProperties, for RC
    only.
  - Add dbi2 and atu property.
  - Remove description for regs and interrupts property.
  - Change enum value for num-lanes to 1 and 2 only.
- In driver patch.
  - In Kconfig file, remove dependency on ARM64.
  - Add new define, PCIE_REGS_PCIE_SII_LINK_UP.
  - Remove PCIE_DBI2_MASK.
  - In struct keembay_pcie, declare pci member as struct, not pointer.
    And remove irq number members.
  - Rename and rework keembay_pcie_establish_link(), to
    keembay_pcie_start_link().
  - Remove unneeded BAR disable steps.
  - Remove unused interrupt handlers; keembay_pcie_ev_irq_handler(),
    keembay_pcie_err_irq_handler().
  - Remove keembay_pcie_enable_interrupts().
  - Rework keembay_pcie_setup_irq() and call it from
    keembay_pcie_probe().
  - Remove keembay_pcie_host_init() and make keembay_pcie_host_ops
    empty.
  - Keep and rework keembay_pcie_add_pcie_port() a little.
  - Remove keembay_pcie_add_pcie_ep() and call dw_pcie_ep_init() from
    keembay_pcie_probe().
  - In keembay_pcie_probe(), remove dbi setup as it will be handled in
    dwc common code.
  - In keembay_pcie_link_up(), use return (val &
    PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP.
  - In keembay_pcie_ep_raise_irq(), rework error message for
    PCI_EPC_IRQ_LEGACY and default cases.
- Rebased to next-20201124, that has dwc pci refactoring,
  https://lore.kernel.org/linux-pci/20201105211159.1814485-1-robh@kernel.org/.

Srikanth Thokala (2):
  dt-bindings: PCI: Add Intel Keem Bay PCIe controller
  PCI: keembay: Add support for Intel Keem Bay

 .../bindings/pci/intel,keembay-pcie-ep.yaml   |  68 +++
 .../bindings/pci/intel,keembay-pcie.yaml      |  96 ++++
 drivers/pci/controller/dwc/Kconfig            |  24 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-keembay.c     | 448 ++++++++++++++++++
 5 files changed, 637 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c


base-commit: 45dfb8a5659ad286c28fa59008271dbc4e5e3f2d
-- 
2.17.1

