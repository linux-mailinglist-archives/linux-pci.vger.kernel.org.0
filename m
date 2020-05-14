Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE091D3429
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgENPBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 11:01:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42282 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgENPBY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 11:01:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EF0Z7o029269;
        Thu, 14 May 2020 10:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589468435;
        bh=3kot24pT8I54Qo+jrpEa45lAzMIAEzTZmm1JUxN+Bjc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ld4YaDO/ufrRparGyNG/IyBUN/95uQw4hpuKaFIpoG1jGzOCx133M/kZcsqCyV+kj
         QgguIenZsF00Rg/954KX15zsVccuq9ZfIIUukgN75a4SKjMerpjsI21OcQ0gQVtbRj
         B5kWIsmUtKeAJNKrOX6eTKFGISOtv/aCrlkbcrMg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EF0ZGx129334;
        Thu, 14 May 2020 10:00:35 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 10:00:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 10:00:34 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EExgAs019279;
        Thu, 14 May 2020 10:00:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/19] PCI: endpoint: Make pci_epf_driver ops optional
Date:   Thu, 14 May 2020 20:29:18 +0530
Message-ID: <20200514145927.17555-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
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
index f9ba2e8d4a99..f463eedcc3ad 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -201,11 +201,9 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
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

