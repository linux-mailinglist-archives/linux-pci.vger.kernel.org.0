Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB944BC27
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 08:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhKJHgs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 02:36:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54880 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKJHgr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 02:36:47 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AA7Xsje087444;
        Wed, 10 Nov 2021 01:33:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636529634;
        bh=v2RhFi+MlwouzGOPhxiLA1I96shpgu+XqvCENLeXfLs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VqRg6PBrdd+KvCZQRbDRRuCWI2FnOkqp2ChTWmIz3vTPnLi9ZLXK8ZTppjvv2cVWY
         xBsXK9+T+eUF44sVXhrgpPfM7mkIh4FFNO0m8hkpsl6xWqB3y+LkqM1c7iLlgnvhvw
         +4jffbVI6nwpmZwj64MjZbDlRJOTKFlwQVm55XRY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AA7XsiK128690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 01:33:54 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 10
 Nov 2021 01:33:54 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 10 Nov 2021 01:33:54 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AA7XiT3020054;
        Wed, 10 Nov 2021 01:33:51 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/3] PCI: keystone: Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET
Date:   Wed, 10 Nov 2021 13:03:42 +0530
Message-ID: <20211110073343.12396-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110073343.12396-1-kishon@ti.com>
References: <20211110073343.12396-1-kishon@ti.com>
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
index 38ab1d3f144d..6a352528d971 100644
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

