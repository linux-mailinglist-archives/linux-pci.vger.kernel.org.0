Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8927032B1EF
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbhCCB5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1446887AbhCBMN4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Mar 2021 07:13:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76F9864F68;
        Tue,  2 Mar 2021 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686242;
        bh=SYtnFExsYwZEI5O1S2aFKD5Uu6aJETmBOiCrDaoDXrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f72jznriVSKZPoWy7SFzJ8t6+nB30YbBMs0bUixuKot2DpqkGKGOLRE1SrPizoUpm
         KRm1AC5BZdCR4enrWeYArYLeqVuqiZeMJRIiML68jr+oWGMdKtI+Qhd0Foq2KJBwVz
         y8Y839kFbBQoZ4qYYd/pu14tWauset6opYc7oohdf7Ds0InCTYjLyZNPsiajNFd1Ja
         OSWm4GIJnbSAD8agofvcz1H/FXjYjq2kiGxlCfibSSBo3ATj7K94Gr75p4pLB+0BLp
         FkXWh/qj2LW5KqPrskeKsisA8cmVHkHi6hhqwaXWFdzKwCvKOVqkfdiHt79Ow2s8Ql
         aeXlJLzwcundw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 28/47] PCI: xgene-msi: Fix race in installing chained irq handler
Date:   Tue,  2 Mar 2021 06:56:27 -0500
Message-Id: <20210302115646.62291-28-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115646.62291-1-sashal@kernel.org>
References: <20210302115646.62291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit a93c00e5f975f23592895b7e83f35de2d36b7633 ]

Fix a race where a pending interrupt could be received and the handler
called before the handler's data has been setup, by converting to
irq_set_chained_handler_and_data().

See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ
handler").

Based on the mail discussion, it seems ok to drop the error handling.

Link: https://lore.kernel.org/r/20210115212435.19940-3-martin@kaiser.cx
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 2470782cb01a..1c34c897a7e2 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -384,13 +384,9 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
 		if (!msi_group->gic_irq)
 			continue;
 
-		irq_set_chained_handler(msi_group->gic_irq,
-					xgene_msi_isr);
-		err = irq_set_handler_data(msi_group->gic_irq, msi_group);
-		if (err) {
-			pr_err("failed to register GIC IRQ handler\n");
-			return -EINVAL;
-		}
+		irq_set_chained_handler_and_data(msi_group->gic_irq,
+			xgene_msi_isr, msi_group);
+
 		/*
 		 * Statically allocate MSI GIC IRQs to each CPU core.
 		 * With 8-core X-Gene v1, 2 MSI GIC IRQs are allocated
-- 
2.30.1

