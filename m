Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D817CAEC
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 03:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCGC3k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 21:29:40 -0500
Received: from inva020.nxp.com ([92.121.34.13]:37174 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgCGC3R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 21:29:17 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0947A1A0E38;
        Sat,  7 Mar 2020 03:29:15 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A3E6B1A1975;
        Sat,  7 Mar 2020 03:28:10 +0100 (CET)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 434F840294;
        Sat,  7 Mar 2020 10:27:59 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Zhiqiang.Hou@nxp.com, Minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        bhelgaas@google.com, robh+dt@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        roy.zang@nxp.com, amurray@thegoodpenguin.co.uk,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v4 00/11] Add the multiple PF support for DWC and Layerscape
Date:   Sat,  7 Mar 2020 10:14:19 +0800
Message-Id: <20200307021430.36826-1-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the PCIe EP multiple PF support for DWC and Layerscape, add
the doorbell MSIX function for DWC, use list to manage the PF of
one PCIe controller, and refactor the Layerscape EP driver due to
some platforms difference.

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

 .../devicetree/bindings/pci/layerscape-pci.txt     |   2 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  31 +++
 drivers/misc/pci_endpoint_test.c                   |   2 +
 drivers/pci/controller/dwc/pci-layerscape-ep.c     | 100 ++++++--
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 255 +++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c       |  59 +++--
 drivers/pci/controller/dwc/pcie-designware.h       |  48 +++-
 7 files changed, 404 insertions(+), 93 deletions(-)

-- 
2.9.5

