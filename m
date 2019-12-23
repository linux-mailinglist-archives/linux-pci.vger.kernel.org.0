Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775E3129B24
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2019 22:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLWViC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Dec 2019 16:38:02 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:45431 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWViC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Dec 2019 16:38:02 -0500
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C81F7200007;
        Mon, 23 Dec 2019 21:37:58 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 0/3] PCI: amlogic: Make PCIe working reliably on AXG platforms
Date:   Mon, 23 Dec 2019 22:45:26 +0100
Message-Id: <20191223214529.20377-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe device probing failures have been seen on AXG platforms and were due
to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit in
MIPI's PHY registers solved the problem. This bit controls band gap
reference.

As discussed here [1] one of these shared MIPI/PCIE PHY register bits was
implemented in the clock driver as CLKID_MIPI_ENABLE. This adds a PHY
driver to control this bit instead, as well as setting the band gap one
in order to get reliable PCIE communication.

While at it add another PHY driver to control PCIE only PHY registers,
making AXG code more similar to G12A platform thus allowing to remove
some specific platform handling in pci-meson driver.

Please note that devicetree and its documentation modifications as well as
CLKID_MIPI_ENABLE will be sent as different series if this one is
considered sane.

Changes sinve v1:
 - Move HHI_MIPI_CNTL0 bit control in its own PHY driver
 - Add a PHY driver for PCIE_PHY registers
 - Modify pci-meson.c to make use of both PHYs and remove specific
   handling for AXG and G12A

[1] https://lkml.org/lkml/2019/12/16/119

Remi Pommarel (3):
  phy: amlogic: Add Amlogic AXG MIPI/PCIE PHY Driver
  phy: amlogic: Add Amlogic AXG PCIE PHY Driver
  PCI: amlogic: Use AXG PCIE and shared MIPI/PCIE PHYs

 drivers/pci/controller/dwc/pci-meson.c        | 140 +++++---------
 drivers/phy/amlogic/Kconfig                   |  22 +++
 drivers/phy/amlogic/Makefile                  |   2 +
 drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c | 176 ++++++++++++++++++
 drivers/phy/amlogic/phy-meson-axg-pcie.c      | 163 ++++++++++++++++
 5 files changed, 409 insertions(+), 94 deletions(-)
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

-- 
2.24.0

