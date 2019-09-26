Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7BFBF1B8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfIZLb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:31:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51028 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfIZLbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:31:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBVGt5042493;
        Thu, 26 Sep 2019 06:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497476;
        bh=E2GTTExAvbZbBjqJm7peVu26RwtsAEY0HmYYy9aUZio=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Sc6WLz/rgCEjTalAjHyyN/dl7vJRBPT5G+xMCus7Zdk+xUmOS/jli4Wl1k39juA5g
         NqqLx7JqQXazDe/Uwihqes0fkvz0VlyzEoKmz7611/wgXt1IJjHEjjIhu9ci208c0R
         K0uutCj06xnxsrpSCNJxwnjOpoe43EMooUR/B+is=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBVGH3013966;
        Thu, 26 Sep 2019 06:31:16 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:31:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:31:08 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTk3069017;
        Thu, 26 Sep 2019 06:31:12 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
Subject: [RFC PATCH 10/21] PCI: endpoint: Make pci_epf_driver ops optional
Date:   Thu, 26 Sep 2019 16:59:22 +0530
Message-ID: <20190926112933.8922-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epf_driver had two ops for bind and unbind which will be invoked
when an endpoint controller is bound to an endpoint function (using
configfs). Now that endpoint core has support to define an endpoint
function using device tree alone, the bind and unbind ops can be
optional. Make pci_epf_driver ops optional here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index c74c7cc6d8bd..67015c66d09f 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -446,11 +446,9 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 {
 	int ret;
 
-	if (!driver->ops)
-		return -EINVAL;
-
-	if (!driver->ops->bind || !driver->ops->unbind)
-		return -EINVAL;
+	if (!driver->ops || !driver->ops->bind || !driver->ops->unbind)
+		pr_debug("%s: Supports only pci_epf device created using DT\n",
+			 driver->driver.name);
 
 	driver->driver.bus = &pci_epf_bus_type;
 	driver->driver.owner = owner;
-- 
2.17.1

