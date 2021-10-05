Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DC422FB1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhJESLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhJESLz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:11:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 440BE613D5;
        Tue,  5 Oct 2021 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457404;
        bh=DZyKnWhOg5Oz0jdZ5Vv/HD2A809k6FTtb6eCQkheZdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKKijucOykjOEebvlTmi2RhWXyC3xmEy0GJ3Z2JM20tXLti/K1zAC6m4VADPyrSPo
         Tojc8J0JEWJR54U6swMjBkYeWYl2iPr42wd/9Xps47+o7DhyDE/0Lo7gRam4qigFlH
         S9PZkrb/5pgYRH78V7/AtZP2yNk/dEt3/j/mxGEiTfD7qnsm7BPhqbS2MJ8VLOv/uR
         ISGl9Y83RsrxvtBwscU75NaK0YreeILlR4+LHV2Y7ztASxDoRdj+hcmov7ubD31Uey
         nXhpK/QdLcmV3GaZfNonlwwsDnlYMDNLFjMxVp+mUlbvltJlXBbHGRYQbAghz9BjaX
         qTQCGjj6pIZxQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 06/13] PCI: aardvark: Do not clear status bits of masked interrupts
Date:   Tue,  5 Oct 2021 20:09:45 +0200
Message-Id: <20211005180952.6812-7-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

The PCIE_ISR1_REG says which interrupts are currently set / active,
including those which are masked.

The driver currently reads this register and looks if some unmasked
interrupts are active, and if not, it clears status bits of _all_
interrupts, including the masked ones.

This is incorrect, since, for example, some drivers may poll these bits.

Remove this clearing, and also remove this early return statement
completely, since it does not change functionality in any way.

Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d5d6f92e5143..f7eebf453e83 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1295,12 +1295,6 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	isr1_mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
 	isr1_status = isr1_val & ((~isr1_mask) & PCIE_ISR1_ALL_MASK);
 
-	if (!isr0_status && !isr1_status) {
-		advk_writel(pcie, isr0_val, PCIE_ISR0_REG);
-		advk_writel(pcie, isr1_val, PCIE_ISR1_REG);
-		return;
-	}
-
 	/* Process MSI interrupts */
 	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
 		advk_pcie_handle_msi(pcie);
-- 
2.32.0

