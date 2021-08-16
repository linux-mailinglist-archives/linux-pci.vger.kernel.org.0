Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B763ECD0A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhHPDRP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:17:15 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45154 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHPDRO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:17:14 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add PCI driver for the Apple M1
Date:   Sun, 15 Aug 2021 23:16:15 -0400
Message-Id: <20210816031621.240268-1-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds a PCIe driver for the internal bus on the Apple M1 (and
presumably other Apple system-on-chips). It's based on the work of Marc
Zyngier, Mark Kettenis, and Stan Skowronek (Corellium). In conjunction
with a pinctrl driver, this enables the USB type-A ports and the
Ethernet port. It also paves the way for Wi-Fi and Bluetooth, but that
requires further work.

For the largest change since v1 of the series-- this now uses Mark
Kettenis's device tree bindings for PCIe. This series contains Mark's
patches (currently under discussion on the LKML) adding the device tree
nodes required for PCIe. I have made minor modifications to Mark's
original patches to get everything working under Linux:

* In the bindings themselves, I've increased the maximum number of
  interrupts to accommodate the full set.
* In the PCIe node, I've added the full set of interrupts.
* I've added the PCIe DART nodes (IOMMUs) and the corresponding
  iommu-map(-mask) properties already covered in the bindings.
* I've tweaked the sizes of the `reg` blocks. Otherwise I got a page
  fault early on.

I've collected the patches required to test on this branch:

	https://github.com/mu-one/linux/commits/pcie-v2

This branch is based on linux-next and contains a GPIO (pinctrl) driver,
a clock gate driver, additional device tree nodes, and this series.  The
type-A ports and Ethernet should work out-of-the-box on that tree,
provided the kernel is booted through m1n1. This improves on Maz's
initial PCIe driver, which required U-Boot to function.

I've started using Linux on M1 as my workstation for Panfrost
development, so this should have 40 hours of testing by this time next
week.

== Project Blurb ==

Asahi Linux is an open community project dedicated to developing and
maintaining mainline support for Apple Silicon on Linux. Feel free to
drop by #asahi and #asahi-dev on OFTC to chat with us, or check
our website for more information on the project:

== Changes ==

Changes for v2:
- Cherrypicked Mark's device tree bindings and switched to using them.
- Split up the PCI driver patch into 3.
- Large numbers of minor changes to the driver better match upstream
  quality standards (using more helper functions, etc.)

Alyssa Rosenzweig (3):
  PCI: apple: Add initial hardware bring-up
  PCI: apple: Set up reference clocks when probing
  PCI: apple: Add MSI handling

Mark Kettenis (3):
  dt-bindings: pci: Add DT bindings for apple,pcie
  arm64: apple: Add pinctrl nodes
  arm64: apple: Add PCIe node

 .../devicetree/bindings/pci/apple,pcie.yaml   | 166 +++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/apple/t8103.dtsi          | 207 ++++++++
 drivers/pci/controller/Kconfig                |  12 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-apple.c           | 448 ++++++++++++++++++
 6 files changed, 841 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-apple.c

-- 
2.30.2

