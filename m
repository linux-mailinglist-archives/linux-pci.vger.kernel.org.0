Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB44363B85
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 08:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhDSGgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 02:36:06 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:58988 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDSGgF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 02:36:05 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 13J6ZHID017231; Mon, 19 Apr 2021 15:35:17 +0900
X-Iguazu-Qid: 34trYlwXUYN69ExCb0
X-Iguazu-QSIG: v=2; s=0; t=1618814116; q=34trYlwXUYN69ExCb0; m=FPzuwcnwHkWzaOwOeu5PQnRgPud7f0jrBk1uH5w+QMA=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1511) id 13J6ZF7a006738
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 15:35:16 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id CE8C41000AA;
        Mon, 19 Apr 2021 15:35:15 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13J6ZF9C025291;
        Mon, 19 Apr 2021 15:35:15 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 0/3] PCI: dwc: Visoconti: PCIe RC controller driver
Date:   Mon, 19 Apr 2021 15:35:10 +0900
X-TSB-HOP: ON
Message-Id: <20210419063513.1947003-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
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
    v1 -> v2:
      - Remove white space.
      - Drop num-viewport and bus-range from required.
      - Drop status line from example.
      - Drop bus-range from required.
      - Removed lines defined in pci-bus.yaml from required.

  PCI: dwc: Visconti: PCIe RC controller driver
    v1 -> v2:
      - Fix typo in commit message.
      - Drop "depends on OF && HAS_IOMEM" from Kconfig.
      - Stop using the pointer of struct dw_pcie.
      - Use _relaxed variant.
      - Drop dw_pcie_wait_for_link.
      - Drop dbi resource processing.
      - Drop MSI IRQ initialization processing.

  MAINTAINERS: Add entries for Toshiba Visconti PCIe controller
    v1 -> v2:
      - No update.

Nobuhiro Iwamatsu (3):
  dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
  PCI: dwc: Visconti: PCIe RC controller driver
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
2.30.0.rc2
