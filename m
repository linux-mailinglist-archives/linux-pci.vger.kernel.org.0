Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F672F879E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbhAOVZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 16:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAOVZv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2021 16:25:51 -0500
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jan 2021 13:25:10 PST
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B867C061757;
        Fri, 15 Jan 2021 13:25:10 -0800 (PST)
Received: from dslb-188-096-136-022.188.096.pools.vodafone-ip.de ([188.96.136.22] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1l0Wab-000574-2e; Fri, 15 Jan 2021 22:25:01 +0100
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
Subject: [PATCH v4 1/3] PCI: altera-msi: Remove IRQ handler and data in one go
Date:   Fri, 15 Jan 2021 22:24:33 +0100
Message-Id: <20210115212435.19940-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108191140.23227-1-martin@kaiser.cx>
References: <20201108191140.23227-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call irq_set_chained_handler_and_data() to clear the chained handler
and the handler's data under irq_desc->lock.

See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
IRQ handler").

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
Hi Lorenzo,
here's another bunch of simple patches that were discussed in November.
Could you have a look?
Thanks,
Martin

v4:
 - resend after two months
 - capitalize the commit message properly
v3:
 - rewrite the commit message again. this is no race condition if we
   remove the interrupt handler. sorry for the noise.
v2:
 - rewrite the commit message to clarify that this is a bugfix


 drivers/pci/controller/pcie-altera-msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index e1636f7714ca..42691dd8ebef 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -204,8 +204,7 @@ static int altera_msi_remove(struct platform_device *pdev)
 	struct altera_msi *msi = platform_get_drvdata(pdev);
 
 	msi_writel(msi, 0, MSI_INTMASK);
-	irq_set_chained_handler(msi->irq, NULL);
-	irq_set_handler_data(msi->irq, NULL);
+	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
 
 	altera_free_domains(msi);
 
-- 
2.20.1

