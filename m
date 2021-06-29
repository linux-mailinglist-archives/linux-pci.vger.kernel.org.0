Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA213B7AC9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 01:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhF2XxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 19:53:06 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:48874 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhF2XxC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 19:53:02 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 15TNo5fA027394; Wed, 30 Jun 2021 08:50:05 +0900
X-Iguazu-Qid: 2wGqimLSptaMBrzYf3
X-Iguazu-QSIG: v=2; s=0; t=1625010605; q=2wGqimLSptaMBrzYf3; m=8tXOEjdEbXlzXauNDjXtyxN5zZQtkWtU8usVbLVyB3s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 15TNo3b5034107
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Jun 2021 08:50:04 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1F7111000FD;
        Wed, 30 Jun 2021 08:50:03 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 15TNo23H001568;
        Wed, 30 Jun 2021 08:50:02 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v4 0/3] Visconti: Add Toshiba Visconti PCIe host controller driver
Date:   Wed, 30 Jun 2021 08:49:49 +0900
X-TSB-HOP: ON
Message-Id: <20210629234952.306578-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series is the PCIe driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation, device driver, MAINTAINER files.
This patch series is v4, and the updating record of each file is below:

  dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
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
    v3 -> v4:
      - No update.
    v2 -> v3:
      - No update.
    v1 -> v2:
      - No update.

Best regards,
  Nobuhiro

Nobuhiro Iwamatsu (3):
  dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
  PCI: visconti: Add Toshiba Visconti PCIe host controller driver
  MAINTAINERS: Add entries for Toshiba Visconti PCIe controller

 .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++
 MAINTAINERS                                   |   2 +
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-visconti.c    | 360 ++++++++++++++++++
 5 files changed, 482 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c

-- 
2.32.0

