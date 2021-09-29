Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88941CA57
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbhI2Qkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 12:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345899AbhI2Qkg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 12:40:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE03B61411;
        Wed, 29 Sep 2021 16:38:55 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mVcbd-00DmcL-LG; Wed, 29 Sep 2021 17:38:53 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>, kernel-team@android.com
Subject: [PATCH v5 00/14] PCI: Add support for Apple M1
Date:   Wed, 29 Sep 2021 17:38:33 +0100
Message-Id: <20210929163847.2807812-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, joey.gouly@arm.com, joro@8bytes.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is v5 of the series adding PCIe support for the M1 SoC. Not a lot
has changed this time around, and most of what I was saying in [1] is
still valid.

Very little has changed code wise (a couple of bug fixes). The series
however now carries a bunch of DT updates so that people can actually
make use of PCIe on an M1 box (OK, not quite, you will still need [2],
or whatever version replaces it). The corresponding bindings are
either already merged, or queued for 5.16 (this is the case for the
PCI binding).

It all should be in a state that makes it mergeable (yeah, I said that
last time... I mean it this time! ;-).

As always, comments welcome.

	M.

[1] https://lore.kernel.org/r/20210922205458.358517-1-maz@kernel.org
[2] https://lore.kernel.org/r/20210921222956.40719-2-joey.gouly@arm.com

Alyssa Rosenzweig (2):
  PCI: apple: Add initial hardware bring-up
  PCI: apple: Set up reference clocks when probing

Marc Zyngier (10):
  irqdomain: Make of_phandle_args_to_fwspec generally available
  of/irq: Allow matching of an interrupt-map local to an interrupt
    controller
  PCI: of: Allow matching of an interrupt-map local to a PCI device
  PCI: apple: Add INTx and per-port interrupt support
  PCI: apple: Implement MSI support
  iommu/dart: Exclude MSI doorbell from PCIe device IOVA range
  PCI: apple: Configure RID to SID mapper on device addition
  arm64: dts: apple: t8103: Add PCIe DARTs
  arm64: dts: apple: t8103: Add root port interrupt routing
  arm64: dts: apple: j274: Expose PCI node for the Ethernet MAC address

Mark Kettenis (2):
  arm64: apple: Add pinctrl nodes
  arm64: apple: Add PCIe node

 MAINTAINERS                              |   7 +
 arch/arm64/boot/dts/apple/t8103-j274.dts |  23 +
 arch/arm64/boot/dts/apple/t8103.dtsi     | 203 ++++++
 drivers/iommu/apple-dart.c               |  27 +
 drivers/of/irq.c                         |  17 +-
 drivers/pci/controller/Kconfig           |  17 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-apple.c      | 822 +++++++++++++++++++++++
 drivers/pci/of.c                         |  10 +-
 include/linux/irqdomain.h                |   4 +
 kernel/irq/irqdomain.c                   |   6 +-
 11 files changed, 1127 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-apple.c

-- 
2.30.2

