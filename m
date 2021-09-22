Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00F9415203
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhIVU46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 16:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237850AbhIVU4t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 16:56:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B018B611C4;
        Wed, 22 Sep 2021 20:55:18 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mT9Gu-00CP8z-Mg; Wed, 22 Sep 2021 21:55:16 +0100
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
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: [PATCH v4 00/10] PCI: Add support for Apple M1
Date:   Wed, 22 Sep 2021 21:54:48 +0100
Message-Id: <20210922205458.358517-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is v4 of the series adding PCIe support for the M1 SoC. Not a lot
has changed this time around, and most of what I was saying in [1] is
still valid.

The most important change is that the driver now probes for the number
of RID-SID mapping registers instead of assuming 64 entries. The rest
is a bunch of limited cleanups and minor fixes.

This should now be in a state that makes it mergeable, although I
expect that some of the clock bits may have to be adapted (I haven't
followed the recent developments on that front).

As always, comments welcome.

[1] https://lore.kernel.org/r/20210913182550.264165-1-maz@kernel.org

Alyssa Rosenzweig (2):
  PCI: apple: Add initial hardware bring-up
  PCI: apple: Set up reference clocks when probing

Marc Zyngier (8):
  irqdomain: Make of_phandle_args_to_fwspec generally available
  of/irq: Allow matching of an interrupt-map local to an interrupt
    controller
  PCI: of: Allow matching of an interrupt-map local to a PCI device
  PCI: apple: Add INTx and per-port interrupt support
  arm64: apple: t8103: Add root port interrupt routing
  PCI: apple: Implement MSI support
  iommu/dart: Exclude MSI doorbell from PCIe device IOVA range
  PCI: apple: Configure RID to SID mapper on device addition

 MAINTAINERS                          |   7 +
 arch/arm64/boot/dts/apple/t8103.dtsi |  33 +-
 drivers/iommu/apple-dart.c           |  27 +
 drivers/of/irq.c                     |  17 +-
 drivers/pci/controller/Kconfig       |  17 +
 drivers/pci/controller/Makefile      |   1 +
 drivers/pci/controller/pcie-apple.c  | 826 +++++++++++++++++++++++++++
 drivers/pci/of.c                     |  10 +-
 include/linux/irqdomain.h            |   4 +
 kernel/irq/irqdomain.c               |   6 +-
 10 files changed, 935 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-apple.c

-- 
2.30.2

