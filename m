Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A7334782E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 13:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhCXMTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 08:19:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhCXMTU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 08:19:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12OCJ9nE012463;
        Wed, 24 Mar 2021 07:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616588349;
        bh=ZQ8qJj8RwlPeZrwTX1Z3GFmExyi4aqBIe+jNtKIiGco=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vC36B0vQd9ioFdWlvuNfuccMzjwluk7efPww046Aindu9RyXErZ2jMOx4JlHluyUd
         VrHUZSgBKcIeWHZIjE3rrMH7IUTluBytmx07He3V7eDXnKMD34cnfDO9mJ5cy1Z1T/
         9ePPxJLiPGFgCaU9eT8u1LmC/MIqyZIjZFpi2+ZM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12OCJ9xE021488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Mar 2021 07:19:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 24
 Mar 2021 07:19:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 24 Mar 2021 07:19:09 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12OCJ1Ch121061;
        Wed, 24 Mar 2021 07:19:06 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/2] PCI: keystone: Set mode as RootComplex for "ti,keystone-pcie" compatible
Date:   Wed, 24 Mar 2021 17:49:00 +0530
Message-ID: <20210324121901.1856-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324121901.1856-1-kishon@ti.com>
References: <20210324121901.1856-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
device data ("struct ks_pcie_of_data"). However it failed to set mode
for "ti,keystone-pcie" compatible. Set mode as RootComplex for
"ti,keystone-pcie" compatible here.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Cc: <stable@vger.kernel.org> # v5.4+
---
 drivers/pci/controller/dwc/pci-keystone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index a59ecbec601f..7171ea70da49 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1047,6 +1047,7 @@ static int ks_pcie_am654_set_mode(struct device *dev,
 
 static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
 	.host_ops = &ks_pcie_host_ops,
+	.mode = DW_PCIE_RC_TYPE,
 	.version = 0x365A,
 };
 
-- 
2.17.1

