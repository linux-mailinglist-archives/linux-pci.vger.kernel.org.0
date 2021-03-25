Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DA348C16
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCYJBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:01:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49414 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhCYJBC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:01:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P90ieq035055;
        Thu, 25 Mar 2021 04:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616662844;
        bh=abH1W5WXyijsp3MpriPtz1CV3oRWfYGjXmRCI8jXfHw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lM2KiiKkp96TVlEqMMbEPuTxv1ikOMSktPK+iUxy7v6cTZe+/WmWXoNBpBOyhe6Iz
         EYULf55yXukDGF1q2ZgKSIlnqUlD6itch/SmschQGS1mUduTrDk+52igdtxJ97V5Se
         bGvk9FuxEPzRnUd6FsRl1PS/Cj+dL2RNvsPhHBqs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P90imA008768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:00:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:00:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:00:44 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P90RkA115556;
        Thu, 25 Mar 2021 04:00:40 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 3/6] irqdomain: Export of_phandle_args_to_fwspec()
Date:   Thu, 25 Mar 2021 14:30:23 +0530
Message-ID: <20210325090026.8843-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090026.8843-1-kishon@ti.com>
References: <20210325090026.8843-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export of_phandle_args_to_fwspec() to be used by drivers.
of_phandle_args_to_fwspec() can be used by drivers to get irq specifier
from device node useful while creating hierarchy domain. This was
suggested by Marc Zyngier [1].

[1] -> http://lore.kernel.org/r/20190223121143.14c1f150@why.wild-wind.fr.eu.org/
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/irqdomain.h | 2 ++
 kernel/irq/irqdomain.c    | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 42d196805f58..0236f508259e 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -391,6 +391,8 @@ extern void irq_domain_associate_many(struct irq_domain *domain,
 extern unsigned int irq_create_mapping_affinity(struct irq_domain *host,
 				      irq_hw_number_t hwirq,
 				      const struct irq_affinity_desc *affinity);
+void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args, unsigned int count,
+			       struct irq_fwspec *fwspec);
 extern unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 extern void irq_dispose_mapping(unsigned int virq);
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 288151393a06..70f050741ab2 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -756,9 +756,8 @@ static int irq_domain_translate(struct irq_domain *d,
 	return 0;
 }
 
-static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
-				      unsigned int count,
-				      struct irq_fwspec *fwspec)
+void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args, unsigned int count,
+			       struct irq_fwspec *fwspec)
 {
 	int i;
 
@@ -768,6 +767,7 @@ static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 	for (i = 0; i < count; i++)
 		fwspec->param[i] = args[i];
 }
+EXPORT_SYMBOL_GPL(of_phandle_args_to_fwspec);
 
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 {
-- 
2.17.1

