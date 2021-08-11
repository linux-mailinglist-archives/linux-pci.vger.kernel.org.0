Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA93E8BF0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhHKIjg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 04:39:36 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:49262 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhHKIjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 04:39:35 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 17B8ceTn029249; Wed, 11 Aug 2021 17:38:40 +0900
X-Iguazu-Qid: 2wHI1WtxCCdJWdk7yS
X-Iguazu-QSIG: v=2; s=0; t=1628671120; q=2wHI1WtxCCdJWdk7yS; m=uhCheTdU5gs+WCRi6kl3yWL7U8eyQmXgnGl4qr7N7go=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1112) id 17B8ccHa006735
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 17:38:39 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 7DB6D1000E0;
        Wed, 11 Aug 2021 17:38:38 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 17B8cbbN018239;
        Wed, 11 Aug 2021 17:38:38 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host controller driver
Date:   Wed, 11 Aug 2021 17:38:27 +0900
X-TSB-HOP: ON
Message-Id: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series is the PCIe driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation, device driver, MAINTAINER files.

Best regards,
  Nobuhiro

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

  dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
    v5 -> v6:
      - No update.
    v4 -> v5:
      - No update.
    v3 -> v4:
     - Changed the redundant clock name.
    v2 -> v3:
      - No update.
    v1 -> v2:
      - Remove white space.
      - Drop num-viewport and bus-range from required.
      - Drop status line from example.
      - Drop bus-range from required.
      - Removed lines defined in pci-bus.yaml from required.

  PCI: visconti: Add Toshiba Visconti PCIe host controller driver
    v5 -> v6:                                                                                                                                                                                                                                                                                                                         - Remove unnecessary commit log.                                                                                                                                                                                                                                                                                                - Fix split line of visconti_add_pcie_port() 
    v4 -> v5:
      - Remove PCIE_BUS_OFFSET
      - Change link_up confirmation function of visconti_pcie_link_up().
      - Move setting event mask before dw_pcie_link_up().
      - Move the contents of visconti_pcie_power_on() to visconti_pcie_host_init().
      - Remove code for link_gen.
    v3 -> v4:
      - Change variable from pci_addr to cpu_addr in visconti_pcie_cpu_addr_fixup().
      - Change the calculation method of CPU addres from subtraction to mask, and
        add comment.
      - Drop dma_set_mask_and_coherent().
      - Drop set MAX_MSI_IRQS.
      - Drop dev_dbg for Link speed.
      - Use use the dev_err_probe() to handle the devm_clk_get() failed.
      - Changed the redundant clock name.
    v2 -> v3:
      - Update subject.
      - Wrap description in 75 columns.
      - Change config name to PCIE_VISCONTI_HOST.
      - Update Kconfig text.
      - Drop empty lines.
      - Adjusted to 80 columns.
      - Drop inline from functions for register access.
      - Changed function name from visconti_pcie_check_link_status to
        visconti_pcie_link_up.
      - Update to using dw_pcie_host_init().
      - Reorder these in the order of use in visconti_pcie_establish_link().
      - Rewrite visconti_pcie_host_init() without dw_pcie_setup_rc().
      - Change function name from  visconti_device_turnon() to
        visconti_pcie_power_on().
      - Unify formats such as dev_err().
      - Drop error label in visconti_add_pcie_port(). 
    v1 -> v2:
      - Fix typo in commit message.
      - Drop "depends on OF && HAS_IOMEM" from Kconfig.
      - Stop using the pointer of struct dw_pcie.
      - Use _relaxed variant.
      - Drop dw_pcie_wait_for_link.
      - Drop dbi resource processing.
      - Drop MSI IRQ initialization processing.
  
  MAINTAINERS: Add entries for Toshiba Visconti PCIe controller
    v5 -> v6:
      - No update.
    v4 -> v5:
      - No update.
    v3 -> v4:
      - No update.
    v2 -> v3:
      - No update.
    v1 -> v2:
      - No update.

Nobuhiro Iwamatsu (3):
  dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
  PCI: visconti: Add Toshiba Visconti PCIe host controller driver
  MAINTAINERS: Add entries for Toshiba Visconti PCIe controller

 .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++
 MAINTAINERS                                   |   2 +
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-visconti.c    | 333 ++++++++++++++++++
 5 files changed, 455 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c

-- 
2.32.0

