Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5F147497
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 00:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgAWXVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 18:21:54 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:62739 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgAWXVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 18:21:54 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5ED7E240002;
        Thu, 23 Jan 2020 23:21:49 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v6 0/7] PCI: amlogic: Make PCIe working reliably on AXG platforms
Date:   Fri, 24 Jan 2020 00:29:36 +0100
Message-Id: <20200123232943.10229-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe device probing failures have been seen on AXG platforms and were
due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
in MIPI's PHY registers solved the problem. This bit controls band gap
reference.

As discussed here [1] one of these shared MIPI/PCIE analog PHY register
bits was implemented in the clock driver as CLKID_MIPI_ENABLE. This adds
a PHY driver to control this bit instead, as well as setting the band
gap one in order to get reliable PCIE communication.

While at it add another PHY driver to control PCIE only PHY registers,
making AXG code more similar to G12A platform thus allowing to remove
some specific platform handling in pci-meson driver.

Please note that CLKID_MIPI_ENABLE removable will be done in a different
serie.

Changes since v5:
 - Add additionalProperties in device tree binding documentation
 - Make analog PHY required

Changes since v4:
 - Rename the shared MIPI/PCIe PHY to analog
 - Chain the MIPI/PCIe PHY to the PCIe one

Changes since v3:
 - Go back to the shared MIPI/PCIe phy driver solution from v2
 - Remove syscon usage
 - Add all dt-bindings documentation

Changes since v2:
 - Remove shared MIPI/PCIE device driver and use syscon to access register
   in PCIE only driver instead
 - Include devicetree documentation

Changes sinve v1:
 - Move HHI_MIPI_CNTL0 bit control in its own PHY driver
 - Add a PHY driver for PCIE_PHY registers
 - Modify pci-meson.c to make use of both PHYs and remove specific
   handling for AXG and G12A

[1] https://lkml.org/lkml/2019/12/16/119

Remi Pommarel (7):
  dt-bindings: Add AXG PCIE PHY bindings
  dt-bindings: Add AXG shared MIPI/PCIE analog PHY bindings
  dt-bindings: PCI: meson: Update PCIE bindings documentation
  arm64: dts: meson-axg: Add PCIE PHY nodes
  phy: amlogic: Add Amlogic AXG MIPI/PCIE analog PHY Driver
  phy: amlogic: Add Amlogic AXG PCIE PHY Driver
  PCI: amlogic: Use AXG PCIE

 .../bindings/pci/amlogic,meson-pcie.txt       |  22 +-
 .../amlogic,meson-axg-mipi-pcie-analog.yaml   |  35 ++++
 .../bindings/phy/amlogic,meson-axg-pcie.yaml  |  52 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  16 ++
 drivers/pci/controller/dwc/pci-meson.c        | 116 ++---------
 drivers/phy/amlogic/Kconfig                   |  22 ++
 drivers/phy/amlogic/Makefile                  |  12 +-
 .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 188 +++++++++++++++++
 drivers/phy/amlogic/phy-meson-axg-pcie.c      | 192 ++++++++++++++++++
 9 files changed, 543 insertions(+), 112 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

-- 
2.24.1

