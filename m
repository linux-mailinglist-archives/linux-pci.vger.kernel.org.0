Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E55241935
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHKKCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Aug 2020 06:02:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41462 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgHKKCB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Aug 2020 06:02:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AA0C8201EED;
        Tue, 11 Aug 2020 12:01:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C2059201E80;
        Tue, 11 Aug 2020 12:01:52 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EF188402DD;
        Tue, 11 Aug 2020 12:01:43 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, andrew.murray@arm.com
Cc:     mingkai.hu@nxp.com, minghuan.Lian@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv7 00/12]PCI: dwc: Add the multiple PF support for DWC and Layerscape
Date:   Tue, 11 Aug 2020 17:54:29 +0800
Message-Id: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the PCIe EP multiple PF support for DWC and Layerscape, and use
a list to manage the PFs of each PCIe controller; add the doorbell
MSIX function for DWC; and refactor the Layerscape EP driver due to
some difference in Layercape platforms PCIe integration.

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
 .../pci/controller/dwc/pcie-designware-ep.c   | 258 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c  |  59 ++--
 drivers/pci/controller/dwc/pcie-designware.h  |  48 +++-
 7 files changed, 410 insertions(+), 96 deletions(-)

-- 
2.17.1

