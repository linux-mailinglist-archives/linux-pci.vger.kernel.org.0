Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849E239D645
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 09:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFGHss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 03:48:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:36921 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhFGHss (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 03:48:48 -0400
IronPort-SDR: sFnrTfM/u+dI8SS7l6ic6uOzGFKOPqiprZI/TVlWVSuWJdolSH7jkLAKJA+AoA8pyJge7h0+s1
 8FX5qUxcBwsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="265733136"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="265733136"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 00:46:56 -0700
IronPort-SDR: OlUQLz1rbA8VItc4n13WGGJCTk0oK91dlEMhirBDqWnRvq+8B/8AIz4fupQXQ+D38N2Jn92mYy
 Ml4PHzeoamsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="401606122"
Received: from intel-z390-ud.iind.intel.com ([10.106.46.146])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2021 00:46:53 -0700
From:   srikanth.thokala@intel.com
To:     robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, kw@linux.com,
        srikanth.thokala@intel.com
Subject: [PATCH v10 0/2] PCI: keembay: Add support for Intel Keem Bay
Date:   Mon,  7 Jun 2021 21:10:42 +0530
Message-Id: <20210607154044.26074-1-srikanth.thokala@intel.com>
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

Changes since v9:
- Add 'Reviewed-by: Krzysztof Wilczyński <kw@linux.com>', thanks to Krzysztof.
- Rebased to v5.13-rc5.

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


base-commit: 614124bea77e452aa6df7a8714e8bc820b489922
-- 
2.17.1

