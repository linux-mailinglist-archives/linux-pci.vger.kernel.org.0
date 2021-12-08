Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955C846CD9C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhLHGWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48720 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbhLHGWi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D6961CE19BA
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF9FC341C8;
        Wed,  8 Dec 2021 06:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944344;
        bh=QSzutjN74AVndvpfq9uTNvcs6nqbKPvJqT/O4JHVRjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrSBeK2s0HqUe1uxdOY5UkajC+FwXuxWPSFIB1NYqJGdztGvV1XT3Z22b7Jb5qRmo
         p6NICcLTwlM28jqpbffK1bGOuh5qmMyfrLZHcwJpmRNPz9ZZhQvt/Hxz/WuWEqvxIc
         gUWC5mXYVW2gOjXMEw4gbDb7SuZm+FWQOSqqg2mOAAA0A8k6Okre/d6eouwGIl8yHj
         j1zhA8c6oDheEFGLmVPi6u1D82airBDuHmxEIHnWW3gPyMlEn9wcu07xd3kJd1bkLW
         A0HPhZP7UDTE3EpRE4Ztoc6DoIdATUqHjxOleCJTBtUGZK3imD6YLRNO5UX/dn4Tk8
         SuQVMc3LIoAQA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 05/17] PCI: aardvark: Refactor unmasking summary MSI interrupt
Date:   Wed,  8 Dec 2021 07:18:39 +0100
Message-Id: <20211208061851.31867-6-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Refactor the masking of ISR0/1 Sources and unmasking of summary MSI interrupt
so that it corresponds to the comments:
- first mask all ISR0/1
- then unmask all MSIs
- then unmask summary MSI interrupt

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 7ea18f0ab8ad..f03dd5d8213a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -579,15 +579,17 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
 
 	/* Disable All ISR0/1 Sources */
-	reg = PCIE_ISR0_ALL_MASK;
-	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
-	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
-
+	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
 
 	/* Unmask all MSIs */
 	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
 
+	/* Unmask summary MSI interrupt */
+	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
+	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
+
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
 	advk_writel(pcie, reg, HOST_CTRL_INT_MASK_REG);
-- 
2.32.0

