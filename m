Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAD26F813
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgIRIYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 04:24:00 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40960 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgIRIX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 04:23:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A4F472010B6;
        Fri, 18 Sep 2020 10:08:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF624201128;
        Fri, 18 Sep 2020 10:08:37 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D8F2C402AE;
        Fri, 18 Sep 2020 10:08:28 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        shawnguo@kernel.org, kishon@ti.com, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andrew.murray@arm.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv8 00/12]PCI: dwc: Add the multiple PF support for DWC and Layerscape
Date:   Fri, 18 Sep 2020 16:00:12 +0800
Message-Id: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the PCIe EP multiple PF support for DWC and Layerscape, and use
a list to manage the PFs of each PCIe controller; add the doorbell
MSIX function for DWC; and refactor the Layerscape EP driver due to
some difference in Layercape platforms PCIe integration.

Rebased this series against pci/dwc branch of git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git

Hou Zhiqiang (1):
  misc: pci_endpoint_test: Add driver data for Layerscape PCIe
    controllers

Xiaowei Bao (11):
  PCI: designware-ep: Add multiple PFs support for DWC
  PCI: designware-ep: Add the doorbell mode of MSI-X in EP mode
  PCI: designware-ep: Move the function of getting MSI capability
    forward
  PCI: designware-ep: Modify MSI and MSIX CAP way of finding
  dt-bindings: pci: layerscape-pci: Add compatible strings for ls1088a
    and ls2088a
  PCI: layerscape: Fix some format issue of the code
  PCI: layerscape: Modify the way of getting capability with different
    PEX
  PCI: layerscape: Modify the MSIX to the doorbell mode
  PCI: layerscape: Add EP mode support for ls1088a and ls2088a
  arm64: dts: layerscape: Add PCIe EP node for ls1088a
  misc: pci_endpoint_test: Add LS1088a in pci_device_id table

 .../bindings/pci/layerscape-pci.txt           |   2 +
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  31 +++
 drivers/misc/pci_endpoint_test.c              |   8 +-
 .../pci/controller/dwc/pci-layerscape-ep.c    | 100 +++++--
 .../pci/controller/dwc/pcie-designware-ep.c   | 245 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c  |  59 +++--
 drivers/pci/controller/dwc/pcie-designware.h  |  48 +++-
 7 files changed, 397 insertions(+), 96 deletions(-)

-- 
2.17.1

