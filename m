Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2F38E104
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhEXGcI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 02:32:08 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:44256 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhEXGcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 02:32:05 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 14O6UDpq011752; Mon, 24 May 2021 15:30:13 +0900
X-Iguazu-Qid: 2wGrTXt2OTZ3JauveJ
X-Iguazu-QSIG: v=2; s=0; t=1621837813; q=2wGrTXt2OTZ3JauveJ; m=hKCpCsnUM5F0fJr5XiY3dcIMiQR4Kw6R9ZxRrbWz2Lk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1112) id 14O6UCbf007973
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 May 2021 15:30:12 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1302E1000D0;
        Mon, 24 May 2021 15:30:12 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 14O6UBsj020955;
        Mon, 24 May 2021 15:30:11 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v3 0/3]  Visconti: Add Toshiba Visconti PCIe host controller driver
Date:   Mon, 24 May 2021 15:30:01 +0900
X-TSB-HOP: ON
Message-Id: <20210524063004.132043-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.31.1
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
    v2 -> v3:
      - No update.
    v1 -> v2:
      - Remove white space.
      - Drop num-viewport and bus-range from required.
      - Drop status line from example.
      - Drop bus-range from required.
      - Removed lines defined in pci-bus.yaml from required.

  PCI: Visconti: Add Toshiba Visconti PCIe host controller driver
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
    v2 -> v3:
      - No update.
    v1 -> v2:
      - No update.

Nobuhiro Iwamatsu (3):
  dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
  PCI: Visconti: Add Toshiba Visconti PCIe host controller driver
  MAINTAINERS: Add entries for Toshiba Visconti PCIe controller

 .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++
 MAINTAINERS                                   |   2 +
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-visconti.c    | 369 ++++++++++++++++++
 5 files changed, 491 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c

-- 
2.31.1
