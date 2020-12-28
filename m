Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB8C2E33ED
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 04:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgL1Dee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Dec 2020 22:34:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:24494 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgL1Ded (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Dec 2020 22:34:33 -0500
IronPort-SDR: k21CJjbMsL8IA3S//MGCjIWFIck7fuylWZNQOcYw/QTHJemdsHJ0Oyy2zM0vHZKpKlaDyNpeXE
 gaPsq8WAMwCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="261087139"
X-IronPort-AV: E=Sophos;i="5.78,454,1599548400"; 
   d="scan'208";a="261087139"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2020 19:33:52 -0800
IronPort-SDR: e07jpiTLrVybqgz692E+r6kxjanIzqQcaIwsdL8sAQ8IUzFVdcA4CAGtldjt8KSjFaamqxHcAQ
 dnw9dvGyQLGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,454,1599548400"; 
   d="scan'208";a="340742925"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2020 19:33:49 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v5 0/2] PCI: keembay: Add support for Intel Keem Bay
Date:   Mon, 28 Dec 2020 11:31:57 +0800
Message-Id: <20201228033159.15369-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi.

The first patch is to document DT bindings for Keem Bay PCIe controller
for both Root Complex and Endpoint modes.

The second patch is the driver file, a glue driver. Keem Bay PCIe
controller is based on DesignWare PCIe IP.

The patch was tested with Keem Bay evaluation module board, with A0
stepping.

Thank you.

Best regards,
Zainie

Changes since v4:
- Rebased to v5.11-rc1 and retest.

Changes since v3:
- Add Reviewed-by: Rob Herring <robh@kernel.org> tag in dt-bindings
  patch.
- Remove the keembay_pcie_{readl,writel} wrappers. And replace them with
  readl() and writel().
- Remove the dead code related to unused irqs.
- Remove unused definition for unused irqs.
- In keembay_pcie_ep_init(), initialize enabled interrupts to known
  state.
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


Wan Ahmad Zainie (2):
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

-- 
2.17.1

