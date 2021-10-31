Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C45441008
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 19:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhJaSPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 14:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhJaSPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 14:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2373D6008E;
        Sun, 31 Oct 2021 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635703957;
        bh=IsOfQdCWxHyLcI8aggRv5sAbY7FQ+QHxt9mRMcL0Brc=;
        h=From:To:Cc:Subject:Date:From;
        b=PCZAPJDrSaz10jG0aujYC/fsoPOFOCHnKQvp72lvmyFMFzU9glX3V9xMB0vsdddI3
         /Hkz01c9X3DOBlq63D9gm5OipZWCBpMWVdfAnTwE1UoLHW8ztHQXIqH52jrbgSGn1P
         0+hiV7WRhl5KhgMpzRvQ6yFYHtsUMtLrctO7+7Vt/qsBgNTlSYTdy86P/NVnntzz9C
         0B83iSJ24rAS/LsIsnRY8WuGjfTFb1LgG9dBBeTq1kem0SFWe0ZfPHpi5oMQwUzVRA
         kJ4vthLVeYh66ZjPLReTkNccU5AzPfkOiQvtuUEgdsr/42WGFBrwHDFCO/lcFAALGT
         B7nZFzTkof4Fw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 0/7] PCI: aardvark controller fixes BATCH 3
Date:   Sun, 31 Oct 2021 19:12:26 +0100
Message-Id: <20211031181233.9976-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Lorenzo,

since we have dropped some patches from the second batch, I thought that
we could instead replace them with another 7 small changes, that we can
hopefully get applied in this cycle.

Description:
- patch 1 just adds a small explanation to pci-bridge-emul, no functional
  change
- patches 2 and 3 add support for some more registers on emulated bridge
- patch 4 is taken from the MSI patches we dropped from batch 2, but since
  it only clears MSIs and adds a useful macro, and makes no changes that
  depend on the API change request by Marc, I think we can add it now
  (especially since patch 5 uses this new macro)
- patches 5-7 make driver unbind work better

Marek

Pali Rohár (7):
  PCI: pci-bridge-emul: Add description for class_revision field
  PCI: pci-bridge-emul: Add definitions for missing capabilities
    registers
  PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2
    registers on emulated bridge
  PCI: aardvark: Clear all MSIs at setup
  PCI: aardvark: Disable bus mastering and mask all interrupts when
    unbinding driver
  PCI: aardvark: Free config space for emulated root bridge when
    unbinding driver to fix memory leak
  PCI: aardvark: Reset PCIe card and disable PHY at driver unbind

 drivers/pci/controller/pci-aardvark.c | 65 ++++++++++++++++++++++++---
 drivers/pci/pci-bridge-emul.c         | 45 ++++++++++++++++++-
 2 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.32.0

