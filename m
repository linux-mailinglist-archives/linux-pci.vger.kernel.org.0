Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1321278B9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 11:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfLTKES (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 05:04:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54476 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfLTKER (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Dec 2019 05:04:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBKA4BPO016735;
        Fri, 20 Dec 2019 04:04:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576836251;
        bh=Ma1U2A/pFmH8hrjGx2OkWa/HQjXzqaF1j16RnDWo8mY=;
        h=From:To:CC:Subject:Date;
        b=AAJUBnieER3BPQr+lYbn0N/wcjXZLQ9rEsz8j9KxUcwiIr/6CqaBJmKOeYXonEZgo
         a5BL2f4SMHwDQjf99/a9MzLJBg89rEdYbAaEO/MjYexc5Jo4Tpia4D+zk/9fwqvcFy
         Rar3go/cyO9cL8rDF4i5SvR53EZ+z6xN8IhPbS0Y=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBKA4Bxg044521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Dec 2019 04:04:11 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 04:04:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 04:04:09 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKA47W6113355;
        Fri, 20 Dec 2019 04:04:07 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: dwc: Use private data pointer of "struct irq_domain" to get pcie_port
Date:   Fri, 20 Dec 2019 15:35:50 +0530
Message-ID: <20191220100550.777-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional change. Get "struct pcie_port *" from private data
pointer of "struct irq_domain" in dw_pcie_irq_domain_free() to make
it look similar to how "struct pcie_port *" is obtained in
dw_pcie_irq_domain_alloc()

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 395feb8ca051..c3d72b06e964 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -236,7 +236,7 @@ static void dw_pcie_irq_domain_free(struct irq_domain *domain,
 				    unsigned int virq, unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct pcie_port *pp = domain->host_data;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
-- 
2.17.1

