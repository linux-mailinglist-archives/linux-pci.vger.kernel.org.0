Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640AB46CD97
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhLHGWa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:30 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48646 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbhLHGWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2683CE2032
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD0C00446;
        Wed,  8 Dec 2021 06:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944335;
        bh=GzQOWTmCJXyEaiPRkYCwGrHZuX86017EIl5lmX90270=;
        h=From:To:Cc:Subject:Date:From;
        b=JPD3HNlGeUEpi/Z2OnCCBLWN3Ks4c82OjCN17OPmtJW8cHOBzD/CGTCDg2Xib9mdG
         cIwM7Be3yVCn3np5bCbWQ53W7SevlCS8iFfAP2/oP6qWsns3rluJE8D2Wuk2praBmF
         /MkIVK9qDVFbH6EDGswQHG36/CQNkCOlEkxAOp9wrr/TsPeQfnjzqXjU9ov8D/1LsF
         4dyNsqHKqm0rTU8nig/ueiqLZVHHt3KPjE1+/J5B1bOmtMRxamGz5A2oGRdYca/e5I
         Uu/YfeOZOYWYW72sEsMvUexOxk91jHBhFlPtA6iLper8SpV5HAHEzcM+BEYYj1n2mF
         FJj65UcwflJUg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 00/17] PCI: aardvark controller fixes BATCH 4
Date:   Wed,  8 Dec 2021 07:18:34 +0100
Message-Id: <20211208061851.31867-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo, Marc,

this is batch 4 of patches for Aardvark PCIe controller driver.

This series mainly fixes and adds support for stuff around interrupts.
(All but the first one.)

I have rebased it sot that first come patches that change the API to the
new one, as Marc requested. Marc, could you find time to review these?

Marek

Marek Behún (1):
  PCI: aardvark: Drop __maybe_unused from advk_pcie_disable_phy()

Pali Rohár (16):
  PCI: aardvark: Rewrite IRQ code to chained IRQ handler
  PCI: aardvark: Fix support for MSI interrupts
  PCI: aardvark: Fix reading MSI interrupt number
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
  PCI: aardvark: Check return value of generic_handle_domain_irq() when
    processing INTx IRQ
  PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
  PCI: aardvark: Don't mask irq when mapping

 drivers/pci/controller/pci-aardvark.c | 332 +++++++++++++++++++-------
 1 file changed, 245 insertions(+), 87 deletions(-)

-- 
2.32.0

