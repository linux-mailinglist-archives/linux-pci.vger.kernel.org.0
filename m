Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB648C6F6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbiALPSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:18:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35262 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbiALPSg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:18:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CB5AB81F18;
        Wed, 12 Jan 2022 15:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97134C36AE5;
        Wed, 12 Jan 2022 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000713;
        bh=+VK97S4+9dHrE0d87LQ66cQJF7naygHp+eL8HzXayK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPMjNRm4LK8IlEez+6lAMbvWR2RdRd8rJv5J1r8ErW7YV+7wUAwSFewRUS/oCH9o3
         ZRm+zvfy8gS3uwzjsAngRL+5ek9gqt2xXju8vjP/GEZsHcu1u40k1YaX3+i98v0OBu
         wYRDDKnx3oi/EL5BjHqtBqUnFAzGdmdUqhcd/PcvJ/QhQrdKxVnP8mS4oiGk0MyBbp
         E4UvszXCZwQ/jAZ1xfTJTt+axi/BEAjieZqoHv5Tu2z707QySjRF2ecrwA0kPUkHt6
         HgcDXhNAJgIo7xLgO+0vC+1cuP6IYgFw49bqpWYo7dtFiD30R2iPM7ZwQUuBBP3+9c
         0r4HHLtMsbrYA==
Received: by pali.im (Postfix)
        id DF2E3768; Wed, 12 Jan 2022 16:18:30 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/11] PCI: mvebu: subsystem ids, AER and INTx
Date:   Wed, 12 Jan 2022 16:18:03 +0100
Message-Id: <20220112151814.24361-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220105150239.9628-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series extends pci-bridge-emul.c driver to emulate PCI Subsystem
Vendor ID capability and PCIe extended capabilities. And then implement
in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe AER
registers, support for legacy INTx interrupts, configuration for X1/X4
mode and usage of new PCI child_ops API.

This patch series depends on other pci-mvebu and pci-bridge-emul patches from:
https://lore.kernel.org/linux-pci/20220104153529.31647-1-pali@kernel.org/

Changes in v2:
* use static structures for INTx interrupts
* remove INTx domain after unregistering INTx handler

Pali Rohár (9):
  PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID
    capability
  dt-bindings: PCI: mvebu: Add num-lanes property
  PCI: mvebu: Correctly configure x1/x4 mode
  PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated
    bridge
  PCI: mvebu: Add support for Advanced Error Reporting registers on
    emulated bridge
  PCI: mvebu: Use child_ops API
  dt-bindings: PCI: mvebu: Update information about intx interrupts
  PCI: mvebu: Implement support for legacy INTx interrupts
  ARM: dts: armada-385.dtsi: Add definitions for PCIe legacy INTx
    interrupts

Russell King (2):
  PCI: pci-bridge-emul: Re-arrange register tests
  PCI: pci-bridge-emul: Add support for PCIe extended capabilities

 .../devicetree/bindings/pci/mvebu-pci.txt     |  16 +
 arch/arm/boot/dts/armada-385.dtsi             |  52 ++-
 drivers/pci/controller/pci-mvebu.c            | 355 +++++++++++++++---
 drivers/pci/pci-bridge-emul.c                 | 167 +++++---
 drivers/pci/pci-bridge-emul.h                 |  17 +
 5 files changed, 497 insertions(+), 110 deletions(-)

-- 
2.20.1

