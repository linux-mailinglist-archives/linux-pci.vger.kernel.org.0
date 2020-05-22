Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774401DDE2D
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 05:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgEVDhx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 23:37:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50166 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgEVDhk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 23:37:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04M3bS2W038302;
        Thu, 21 May 2020 22:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590118648;
        bh=BL02kCIy8Dsc4OqSHYXYSfecDXhGisCZ/n6an0znEN0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xut2lO1HujuRj9WiI8CL1G1esBWBJcC+ra53lnHn9qbb12yX6ci8Nj7hCMBi4IuYU
         XSTbD2lhkm1cKAgxrLuk45fzpGfEJV1RnAiILjCfInk46PIbBICn9uYOrMJhCD5g+/
         G5+coQCQQoc9JSvZ6qfn78IcD+AOCsWXunuAkJMk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04M3bSS7027632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 22:37:28 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 22:37:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 22:37:27 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M3aYc9062596;
        Thu, 21 May 2020 22:37:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 13/14] misc: pci_endpoint_test: Add J721E in pci_device_id table
Date:   Fri, 22 May 2020 09:06:30 +0530
Message-ID: <20200522033631.32574-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522033631.32574-1-kishon@ti.com>
References: <20200522033631.32574-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add J721E in pci_device_id table so that pci-epf-test can be used
for testing PCIe EP in J721E.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index ef5a1af6bab7..a70b17e5dd9a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -68,6 +68,7 @@
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
 #define FLAG_USE_DMA				BIT(0)
 
+#define PCI_DEVICE_ID_TI_J721E			0xb00d
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 
 #define is_am654_pci_dev(pdev)		\
@@ -930,6 +931,11 @@ static const struct pci_endpoint_test_data am654_data = {
 	.irq_type = IRQ_TYPE_MSI,
 };
 
+static const struct pci_endpoint_test_data j721e_data = {
+	.alignment = 256,
+	.irq_type = IRQ_TYPE_MSI,
+};
+
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
 	  .driver_data = (kernel_ulong_t)&default_data,
@@ -942,6 +948,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
+	  .driver_data = (kernel_ulong_t)&j721e_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.17.1

