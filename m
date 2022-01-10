Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF3488E39
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiAJBu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiAJBu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F8C06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57572B81118
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C978C36AE3;
        Mon, 10 Jan 2022 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779424;
        bh=B7sfen2UllzsVBzAuAws7MqogCv0oaPUjCj0ZlnHL0w=;
        h=From:To:Cc:Subject:Date:From;
        b=Nl5aBrsv1eSEgqfb9C4lv4zeCcYmPLIli/odFOs+PHOlZXKJ3CaOmBHFmRPR6HlR3
         zWQY4kuoRXRH/OmLEndiZuy62YfZ1EsnxiN5pDgcC0oIzdeLf5XWt6fOmR2eWU8sA4
         h8dXx1irCOWHqrVSABTOa75HYltItv9j9+f4VigAizR18FFUGicfWLmbXxs9bL54b5
         DUX2RbOskVCVgwzYYxrwmGRbst0rbl8mLCgFQUaarsqyXnJelj+Hyc8uh+hNw6zBwu
         PUFu8k82laIi8+pY0Lso19mzA+lR8KdigFZfVcB9en0W3aE/lyHyzDxYP0wsSmjztp
         eKDS0OHF0NknQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 00/23] PCI: aardvark controller fixes BATCH 4
Date:   Mon, 10 Jan 2022 02:49:55 +0100
Message-Id: <20220110015018.26359-1-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo, Bjorn and Marc,

this is v2 of fourth batch of fixes for the Aardvark PCIe controller
driver.

Stuff is converted to new interrupt APIs and recommendations from Marc.
Marc, could you look at these and acknowledge or comment?

This series mainly fixes and adds support for stuff around interrupts:
the most important thing is fixing MSI support.

The series is rebased on helgaas/next.

Marek

Changes since v1:
- added patches converting irq_chip and msi_domain_info structures into
  static driver structures, instead of creating them dynamically, as
  suggested by Marc
- added some small patches that should be easy to review
  - conversion to use constants from linux/pci.h instead of ad-hoc
    constants int patch 1
  - use dev_fwnode(dev) instead of of_node_to_fwnode(dev->of_node) in
    patch 8
  - fix of a comment in patch 22

Marek Behún (6):
  PCI: aardvark: Make MSI irq_chip structures static driver structures
  PCI: aardvark: Make msi_domain_info structure a static driver
    structure
  PCI: aardvark: Use dev_fwnode() instead of
    of_node_to_fwnode(dev->of_node)
  PCI: aardvark: Drop __maybe_unused from advk_pcie_disable_phy()
  PCI: aardvark: Update comment about link going down after link-up
  PCI: aardvark: Make main irq_chip structure a static driver structure

Pali Rohár (17):
  PCI: aardvark: Replace custom PCIE_CORE_INT_* macros with
    PCI_INTERRUPT_*
  PCI: aardvark: Fix reading MSI interrupt number
  PCI: aardvark: Fix support for MSI interrupts
  PCI: aardvark: Rewrite IRQ code to chained IRQ handler
  PCI: aardvark: Check return value of generic_handle_domain_irq() when
    processing INTx IRQ
  PCI: aardvark: Refactor unmasking summary MSI interrupt
  PCI: aardvark: Add support for masking MSI interrupts
  PCI: aardvark: Fix setting MSI address
  PCI: aardvark: Enable MSI-X support
  PCI: aardvark: Add support for ERR interrupt on emulated bridge
  PCI: aardvark: Fix reading PCI_EXP_RTSTA_PME bit on emulated bridge
  PCI: aardvark: Optimize writing PCI_EXP_RTCTL_PMEIE and
    PCI_EXP_RTSTA_PME on emulated bridge
  PCI: aardvark: Add support for PME interrupts
  PCI: aardvark: Fix support for PME requester on emulated bridge
  PCI: aardvark: Use separate INTA interrupt for emulated root bridge
  PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
  PCI: aardvark: Don't mask irq when mapping

 drivers/pci/controller/pci-aardvark.c | 415 +++++++++++++++++---------
 1 file changed, 281 insertions(+), 134 deletions(-)

-- 
2.34.1

