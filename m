Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0862AFAF6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 23:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKKWBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 17:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgKKWBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 17:01:43 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8EC0613D1;
        Wed, 11 Nov 2020 14:01:43 -0800 (PST)
Received: from dslb-094-219-035-043.094.219.pools.vodafone-ip.de ([94.219.35.43] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1kcyBK-0003ZH-H4; Wed, 11 Nov 2020 23:01:34 +0100
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
Subject: [PATCH v2 2/2] PCI: dwc: Fix race in removing chained IRQ handler
Date:   Wed, 11 Nov 2020 23:01:16 +0100
Message-Id: <20201111220116.22034-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201111220116.22034-1-martin@kaiser.cx>
References: <20201108191140.23227-1-martin@kaiser.cx>
 <20201111220116.22034-1-martin@kaiser.cx>
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
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 44c2a6572199..fc2428165f13 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -258,10 +258,8 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 
 void dw_pcie_free_msi(struct pcie_port *pp)
 {
-	if (pp->msi_irq) {
-		irq_set_chained_handler(pp->msi_irq, NULL);
-		irq_set_handler_data(pp->msi_irq, NULL);
-	}
+	if (pp->msi_irq)
+		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
 
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
-- 
2.20.1

