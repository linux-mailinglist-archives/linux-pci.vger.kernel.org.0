Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3A12A35B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2019 18:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLXRbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Dec 2019 12:31:55 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:38419 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfLXRbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Dec 2019 12:31:55 -0500
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 82C4B240004;
        Tue, 24 Dec 2019 17:31:51 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 0/5] PCI: amlogic: Make PCIe working reliably on AXG platforms
Date:   Tue, 24 Dec 2019 18:39:37 +0100
Message-Id: <20191224173942.18160-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe device probing failures have been seen on AXG platforms and were due
to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit in
MIPI's PHY registers solved the problem. This bit appears to control band
gap reference.

As discussed here [1] one of these shared MIPI/PCIE PHY register bits was
mistakenly implemented in the clock driver as CLKID_MIPI_ENABLE. This adds
a PHY driver to control this bit through syscon subsystem instead, as well
as setting the band gap one in order to get reliable PCIE communication.

While at it adding this PHY make AXG code close to G12A one thus allowing
to remove some specific platform handling in pci-meson driver.

Please note that CLKID_MIPI_ENABLE removable will be done in a different
serie.

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

Remi Pommarel (5):
  phy: amlogic: Add Amlogic AXG PCIE PHY Driver
  PCI: amlogic: Use AXG PCIE PHY
  arm64: dts: meson-axg: Add PCIE PHY node
  dt-bindings: PCI: meson: Update PCIE bindings documentation
  dt-bindings: Add AXG PCIE PHY bindings

 .../bindings/pci/amlogic,meson-pcie.txt       |  22 +--
 .../bindings/phy/amlogic,meson-axg-pcie.yaml  |  51 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   9 +
 drivers/pci/controller/dwc/pci-meson.c        | 116 ++---------
 drivers/phy/amlogic/Kconfig                   |  11 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 drivers/phy/amlogic/phy-meson-axg-pcie.c      | 185 ++++++++++++++++++
 7 files changed, 287 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

-- 
2.24.0

