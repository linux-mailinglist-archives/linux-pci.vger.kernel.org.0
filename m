Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D233EC755
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 06:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhHOEfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 00:35:06 -0400
Received: from [138.197.143.207] ([138.197.143.207]:44978 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhHOEfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 00:35:06 -0400
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
Subject: [RFC PATCH 0/2] Add PCI driver for the Apple M1
Date:   Sun, 15 Aug 2021 00:25:23 -0400
Message-Id: <20210815042525.36878-1-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds a PCIe driver for the internal bus on the Apple M1 (and
presumably other Apple system-on-chips). It's based on the work of Marc
Zyngier, Mark Kettenis, and Stan Skowronek (Corellium). In conjunction
with a proper device tree and a GPIO driver, this enables the USB type-A
ports and the Ethernet port. It also paves the way for Wi-Fi and
Bluetooth, but that requires further work. The device tree patch is not
included here, as it depends on the GPIO driver which is still
work-in-progress. Nevertheless, I feel comfortable submitting "PCI: apple:
Add driver for the Apple M1".

I expect review feedback will be concentrated on the device tree
bindings. These bindings are a mish-mash of what's in the Marc's initial
driver, Corellium driver, and Mark's U-Boot downstream. They differ from
Maz's bindings by including nodes necessary for hardware bring-up, but
are simplified from Corellium's bindings by omitting tunables which are
handled by the Asahi Linux bootloader (m1n1). I am new to device tree
and expect "dt-bindings: PCI: Add Apple PCI controller" to need changes.
This was my first time working with YAML bindings; please be gentle :-)

I've collected the patches required to test this branch on this branch:

	https://github.com/mu-one/linux/commits/pcie

This branch is based on linux-next and contains a GPIO (pinctrl) driver,
this series, and updates to the M1 (T8103) device tree. The type-A ports
and Ethernet should work out-of-the-box on that tree, provided the
kernel is booted through m1n1. This is a noticeable improvement on Maz's
initial PCIe driver, which required U-Boot to function.

I've started using Linux on M1 as my workstation for Panfrost
development, so this should have 40 hours of testing by this time next
week.

Alyssa Rosenzweig (2):
  dt-bindings: PCI: Add Apple PCI controller
  PCI: apple: Add driver for the Apple M1

 .../devicetree/bindings/pci/apple,pcie.yaml   | 153 ++++++
 MAINTAINERS                                   |   7 +
 drivers/pci/controller/Kconfig                |  13 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-apple.c           | 466 ++++++++++++++++++
 5 files changed, 640 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-apple.c

-- 
2.30.2

