Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936AC3872D7
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbhERHIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 03:08:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:58403 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239487AbhERHIe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 May 2021 03:08:34 -0400
IronPort-SDR: ZL+taszF6xELT3rbaK3tUyjmlBBPRjSn2W0rfmNc09NHIkPT2xkR3Bz+kv2loFceFNDNHGkhVX
 krvVoXfbl8Ww==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221695499"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="221695499"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 00:07:15 -0700
IronPort-SDR: xDBRmGUeXieopofy4uGig2AqxSMc7D0VSVNhOpp6+meymcczwNRIHDAdTKgJIaDJT0eNtAFJ2R
 D97evuzz7hfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="626966818"
Received: from intel-z390-ud.iind.intel.com ([10.106.46.146])
  by fmsmga006.fm.intel.com with ESMTP; 18 May 2021 00:07:12 -0700
From:   srikanth.thokala@intel.com
To:     robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, kw@linux.com,
        srikanth.thokala@intel.com
Subject: [PATCH v9 0/2] PCI: keembay: Add support for Intel Keem Bay
Date:   Tue, 18 May 2021 20:30:48 +0530
Message-Id: <20210518150050.7427-1-srikanth.thokala@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Hi,

The first patch is to document DT bindings for Keem Bay PCIe controller
for both Root Complex and Endpoint modes.

The second patch is the driver file, a glue driver. Keem Bay PCIe
controller is based on DesignWare PCIe IP.

The patch was tested with Keem Bay evaluation module board, with B0
stepping.

Kindly review.

Thanks!
Srikanth

Changes since v8:
- Use chained IRQ to handle MSIs, as suggested by Lorenzo Pieralisi.
- Rename *_setup_irq() to *_setup_msi_irq() to be more meaningful.
- Move *_setup_msi_irq() call to *_add_pcie_port() to make it invoke
  only when controller is in Root Complex mode. In Endpoint mode,
  IRQ will be setup by the respective driver which will be based on
  PCIe End Point Framework.

Changes since v7:
- Rename keembay_pcie_ltssm_enable() to align to its functionality.
- Fix other minor comments from "Krzysztof Wilczyński <kw@linux.com>"

Changes since v6:
- Arrange SoB in chronological order.
- Alphabetized and modified status of entry in MAINTAINERS.
- Added a comment to specify the PCIe spec section about the delay.

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

 .../bindings/pci/intel,keembay-pcie-ep.yaml   |  69 +++
 .../bindings/pci/intel,keembay-pcie.yaml      |  97 ++++
 MAINTAINERS                                   |   7 +
 drivers/pci/controller/dwc/Kconfig            |  28 ++
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-keembay.c     | 451 ++++++++++++++++++
 6 files changed, 653 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c


base-commit: 88b06399c9c766c283e070b022b5ceafa4f63f19
-- 
2.17.1

