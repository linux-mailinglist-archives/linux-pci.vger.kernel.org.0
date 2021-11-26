Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8BE45E974
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 09:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359690AbhKZIhG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 03:37:06 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45010 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353255AbhKZIfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 03:35:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8Vd4S091368;
        Fri, 26 Nov 2021 02:31:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637915499;
        bh=g2rQ1mMO32HDUsjYDmMgPUbjxQTL8iGUWukhF+UH/Ng=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iMQoFKr3UMXrqa6ROWP7D/h7chmlOUfRjqsjusuL4eAROikTHSjaqqMfwQlkRBfEp
         2eH6nSmhSusbuVernqksgeT3/dubP6oKzyUtJ8+80DI/VM6q9uHOjJ8ovKOzjKNK9d
         mYoATUpXyGOC6o5SUEuvYb/10+6SP7zWoAhWyMYI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8VdkQ039546
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:31:39 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:31:39 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:31:39 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VKEo127547;
        Fri, 26 Nov 2021 02:31:36 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/5] PCI: keystone: Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET
Date:   Fri, 26 Nov 2021 14:01:18 +0530
Message-ID: <20211126083119.16570-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126083119.16570-1-kishon@ti.com>
References: <20211126083119.16570-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AM654 RootComplex has a hard coded 64 bit BAR of size 1MB and also has
both MSI and MSI-X capability in it's config space. If PCIEPORTBUS is
enabled, it tries to configure MSI-X and msix_mask_all() adds about 10
Second boot up delay when it tries to write to undefined location.

Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET so that
msix_map_region() returns NULL for Root Complex and avoid un-desirable
writes to MSI-X table.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 52d20fe17ee9..73e6626a0d8f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -557,8 +557,14 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		{ 0, },
 	};
 
-	if (pci_is_root_bus(bus))
+	if (pci_is_root_bus(bus)) {
 		bridge = dev;
+		if (pci_match_id(am6_pci_devids, bridge)) {
+			struct resource *r = &dev->resource[0];
+
+			r->flags |= IORESOURCE_UNSET;
+		}
+	}
 
 	/* look for the host bridge */
 	while (!pci_is_root_bus(bus)) {
-- 
2.17.1

