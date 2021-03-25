Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52B3348C59
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCYJKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:10:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40550 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCYJKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:10:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P9A1EC104845;
        Thu, 25 Mar 2021 04:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616663401;
        bh=fizCFa2FC7q85wBtLkQgLLvgIMCdjLrp+tEVBpiTQXI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SSr7Jx3/AA1GeZQKpipzaX4Txc2++7hZ6xpfzAyyEjuUXJBK6yogFr4jGMp2ZbUG6
         eyWI36wRrZDrqFxnl+oYMvPXQM60SNwbO8pLo8diNmQ0AlLwiRaJl8tkRXsqdZBTMj
         0SNQtFPqSEwvfkkAzpJpDZgbdd1A/LRF6PkjFgrM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P9A1Of022983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:10:01 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:10:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:10:01 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P99bA1078373;
        Thu, 25 Mar 2021 04:09:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 4/4] PCI: j721e: Add PCIe support for AM64
Date:   Thu, 25 Mar 2021 14:39:36 +0530
Message-ID: <20210325090936.9306-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090936.9306-1-kishon@ti.com>
References: <20210325090936.9306-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AM64 has the same PCIe IP as in J7200 (legacy interrupt handling is
same as J7200 instead of J721E). Add support for "ti,am64-pcie-host"
compatible that is specific to AM64.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index f175f116abf6..38895a5f4b68 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -467,6 +467,10 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,j7200-pcie-host",
 		.data = &j7200_pcie_rc_data,
 	},
+	{
+		.compatible = "ti,am64-pcie-host",
+		.data = &j7200_pcie_rc_data,
+	},
 	{},
 };
 
-- 
2.17.1

