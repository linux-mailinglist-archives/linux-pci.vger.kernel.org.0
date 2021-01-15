Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77692F87A2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 22:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbhAOVZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 16:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAOVZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2021 16:25:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0707C061793;
        Fri, 15 Jan 2021 13:25:16 -0800 (PST)
Received: from dslb-188-096-136-022.188.096.pools.vodafone-ip.de ([188.96.136.22] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1l0Wak-000574-Ry; Fri, 15 Jan 2021 22:25:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v4 3/3] PCI: xgene-msi: Fix race in installing chained irq handler
Date:   Fri, 15 Jan 2021 22:24:35 +0100
Message-Id: <20210115212435.19940-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210115212435.19940-1-martin@kaiser.cx>
References: <20201108191140.23227-1-martin@kaiser.cx>
 <20210115212435.19940-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix a race where a pending interrupt could be received and the handler
called before the handler's data has been setup, by converting to
irq_set_chained_handler_and_data().

See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ
handler").

Based on the mail discussion, it seems ok to drop the error handling.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v4
 - resend after two months

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
2.20.1

