Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE26F3E9187
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhHKMeo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:34:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56260 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhHKMej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:34:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCY3IA080226;
        Wed, 11 Aug 2021 07:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628685243;
        bh=pW4ZExl/ov5EyYZlVuZTWsVG4Ufb9shw+pTUByjYGyE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AgpCJIA1n/IMLeTZ7G9MLBT8LEITTnl35e0eRrwpXK3tzDVHW9GOLQtv0uNI6re8g
         YtlZ/HaQupJJVlMZW8SdpUVERzor8GY6Ms4zGmmxLsBUCr16XaGpml8Do/8oPDFhNa
         BLPniObSXPWQm3rqTYmIZ50VNJAsZYxcl3pPCX4o=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCY2Zx010992
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:34:03 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:34:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:34:02 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXbj0083813;
        Wed, 11 Aug 2021 07:33:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
Subject: [PATCH v3 4/5] PCI: j721e: Add PCIe support for AM64
Date:   Wed, 11 Aug 2021 18:03:35 +0530
Message-ID: <20210811123336.31357-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811123336.31357-1-kishon@ti.com>
References: <20210811123336.31357-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AM64 has the same PCIe IP as in J7200 with certain erratas not
applicable (quirk_detect_quiet_flag). Add support for "ti,am64-pcie-host"
compatible and "ti,am64-pcie-ep" compatible that is specific to AM64.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 10b13b728284..ffb176d288cd 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -310,6 +310,17 @@ static const struct j721e_pcie_data j7200_pcie_ep_data = {
 	.quirk_detect_quiet_flag = true,
 };
 
+static const struct j721e_pcie_data am64_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.byte_access_allowed = true,
+};
+
+static const struct j721e_pcie_data am64_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
+};
+
 static const struct of_device_id of_j721e_pcie_match[] = {
 	{
 		.compatible = "ti,j721e-pcie-host",
@@ -327,6 +338,14 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,j7200-pcie-ep",
 		.data = &j7200_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,am64-pcie-host",
+		.data = &am64_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,am64-pcie-ep",
+		.data = &am64_pcie_ep_data,
+	},
 	{},
 };
 
-- 
2.17.1

