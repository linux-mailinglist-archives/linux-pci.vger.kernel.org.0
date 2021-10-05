Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF6422FAB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhJESLr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJESLq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E71D060F6C;
        Tue,  5 Oct 2021 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457395;
        bh=yuq4fJxwm5w3lb/NK2zR9RbGnu8c8XfWbWJCznyg8aY=;
        h=From:To:Cc:Subject:Date:From;
        b=A3DAqWvXIqnF6GeIoSvXNxYvG/jJktejLLBc0zti4xwCRqeEBaR/KJTQ2+AnQaTfd
         jp88/FmXOGYmXv0UrDHz0FKlQjADUv6Xf1gLimzfZZVgLsBbUvStiuenwgNeNQlBOJ
         AHyGEdtEFF91Cg87VlAH+VuC7qVeFDBUHOno8cj9uHJi9lXN9R6sWliVIVJZsQOhro
         yFU/LmAL8YKvMnsvQ8qgj3SGQ1QDsuVBEwKTy2HzULPLIDovxp90EpQwyMXgm790Ps
         O9OJzJzw044gibmDYJVo5bayfw3oF/h/OYo2DOGhP4P/Sqxzzp4vJsZtCy7Ekt/Ce8
         1JLc2PSaboS6A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 00/13] PCI: aardvark controller fixes
Date:   Tue,  5 Oct 2021 20:09:39 +0200
Message-Id: <20211005180952.6812-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

as requested I am sending v2 of this series.

Changes since v1:
- updated commit message in patch 6 as suggested by Mark
- updated patch 6 to also drop the early return
- changed the LTSSM definitions to enum in patch 12
- dropped the Fixes tags for those patches where it was inappropriate

Marek Behún (2):
  PCI: aardvark: Don't spam about PIO Response Status
  PCI: aardvark: Deduplicate code in advk_pcie_rd_conf()

Pali Rohár (11):
  PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
  PCI: aardvark: Fix PCIe Max Payload Size setting
  PCI: aardvark: Fix preserving PCI_EXP_RTCTL_CRSSVE flag on emulated
    bridge
  PCI: aardvark: Fix configuring Reference clock
  PCI: aardvark: Do not clear status bits of masked interrupts
  PCI: aardvark: Do not unmask unused interrupts
  PCI: aardvark: Implement re-issuing config requests on CRS response
  PCI: aardvark: Simplify initialization of rootcap on virtual bridge
  PCI: aardvark: Fix link training
  PCI: aardvark: Fix checking for link up via LTSSM state
  PCI: aardvark: Fix reporting Data Link Layer Link Active

 drivers/pci/controller/pci-aardvark.c | 372 +++++++++++++++-----------
 include/uapi/linux/pci_regs.h         |   6 +
 2 files changed, 217 insertions(+), 161 deletions(-)

-- 
2.32.0

