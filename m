Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD637573C
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhEFPdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235295AbhEFPdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FC8D6121F;
        Thu,  6 May 2021 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315167;
        bh=4PdOrm3ckyFyLCrz8KXjoYJ/bE97syCdXnf2iYht7P0=;
        h=From:To:Cc:Subject:Date:From;
        b=nTYk0C0GB/2hQOoxxPHbZxsBuXKqffrD5pzDXMVjeBfVaXarD/c2bkjwkMbStG6Y9
         Qh8sKqg8tP/80bLYac++BizFLF0W1LQTgbJHPoIMILv/S6/T63TLuJe7YIoRsBsSnh
         lQAW653pZdTiQJvReyxgT41La1gK6UaqN+OWsD5+PuWsAtvfi8/jmNnXSC7kyvqMta
         UsVXn3zYt9tEL4nmqy0AKV6o0z7IEU21xbhqPjP9S1E65Sj1e9Z8IA8pkrjqhNyslU
         Lbo6o688qxIYeVd5z8fTVKdkcteuG49rc+nysfhXqRXH/40M3DZNxOaQRJPT0xvgwO
         E97U50sdrjG1Q==
Received: by pali.im (Postfix)
        id 00869732; Thu,  6 May 2021 17:32:43 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/42] PCI: aardvark: Various driver fixes
Date:   Thu,  6 May 2021 17:31:11 +0200
Message-Id: <20210506153153.30454-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes various issues in pci-aardvark.c driver
(PCIe controller on Marvell Armada 3700 SoC) used on Espressobin
and Turris Mox.

First patch fixes kernel panic (or TF-A panic depending on used
firmware) during execution of PIO transfer and I would suggest to
include this fix into v5.13 release to prevent future kernel panics.

Other patches then fixes PIO issues, PCIe link training, initialization
of PCIe controller, accessing PCIe Root Bridge/Port registers, handling
of interrupts (including ERR and PME), setup of Multi-MSI interrupts,
adding support for masking MSI interrupts, adding support for more than
32 MSI interrupts with MSI-X support, and adding support for AER.

Note that there are still some unresolved issues with PCIe on A3720.
I asked Marvell for PCIe documentation or explanations but I have not
received anything (yet).

Patch "Fix checking for PIO status" is taken from the Marvell github fork
and adapted for inclusion into mainline kernel:
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/84444d22023c

Whole patch series is available also in my git branch pci-aardvark:
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark

If you have Espressobin, Turris Mox or other A3720 board with PCIe
please test this patch series with your favourite PCIe card if
everything is working fine.

Evan Wang (1):
  PCI: aardvark: Fix checking for PIO status

Pali Rohár (39):
  PCI: aardvark: Fix kernel panic during PIO transfer
  PCI: aardvark: Fix checking for PIO Non-posted Request
  PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO
    response
  PCI: pci-bridge-emul: Add PCIe Root Capabilities Register
  PCI: aardvark: Fix reporting CRS Software Visibility on emulated
    bridge
  PCI: aardvark: Fix link training
  PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
  PCI: aardvark: Fix PCIe Max Payload Size setting
  PCI: aardvark: Implement workaround for the readback value of VEND_ID
  PCI: aardvark: Do not touch status bits of masked interrupts in
    interrupt handler
  PCI: aardvark: Check for virq mapping when processing INTx IRQ
  PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
  PCI: aardvark: Don't mask irq when mapping
  PCI: aardvark: Change name of INTx irq_chip to advk-INT
  PCI: aardvark: Remove unneeded goto
  PCI: aardvark: Fix support for MSI interrupts
  PCI: aardvark: Correctly clear and unmask all MSI interrupts
  PCI: aardvark: Fix setting MSI address
  PCI: aardvark: Add support for more than 32 MSI interrupts
  PCI: aardvark: Add support for masking MSI interrupts
  PCI: aardvark: Enable MSI-X support
  PCI: aardvark: Fix support for ERR interrupt on emulated bridge
  PCI: aardvark: Fix support for PME on emulated bridge
  PCI: aardvark: Fix support for PME requester on emulated bridge
  PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on
    emulated bridge
  PCI: aardvark: Disable bus mastering and mask all interrupts when
    unbinding driver
  PCI: aardvark: Free config space for emulated root bridge when
    unbinding driver to fix memory leak
  PCI: aardvark: Reset PCIe card and disable PHY when unbinding driver
  PCI: aardvark: Rewrite irq code to chained irq handler
  PCI: aardvark: Use separate INTA interrupt for emulated root bridge
  PCI: pci-bridge-emul: Add description for class_revision field
  PCI: pci-bridge-emul: Add definitions for missing capabilities
    registers
  PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2
    registers on emulated bridge
  PCI: aardvark: Add support for PCI_BRIDGE_CTL_BUS_RESET on emulated
    bridge
  PCI: aardvark: Replace custom PCIE_CORE_ERR_CAPCTL_* macros by
    linux/pci_regs.h macros
  PCI: aardvark: Replace custom PCIE_CORE_INT_* macros by linux
    PCI_INTERRUPT_* values
  PCI: aardvark: Cleanup some register macros
  PCI: aardvark: Add comments for OB_WIN_ENABLE and ADDR_WIN_DISABLE
  PCI: aardvark: Add support for Advanced Error Reporting registers on
    emulated bridge

Russell King (2):
  PCI: pci-bridge-emul: re-arrange register tests
  PCI: pci-bridge-emul: add support for PCIe extended capabilities

 drivers/pci/controller/pci-aardvark.c | 980 +++++++++++++++++++-------
 drivers/pci/pci-bridge-emul.c         | 149 ++--
 drivers/pci/pci-bridge-emul.h         |  17 +-
 include/uapi/linux/pci_regs.h         |   6 +
 4 files changed, 850 insertions(+), 302 deletions(-)

-- 
2.20.1

