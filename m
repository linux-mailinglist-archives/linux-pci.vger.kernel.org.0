Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738E05FCA50
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJLSOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJLSOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 14:14:40 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88D91103;
        Wed, 12 Oct 2022 11:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpdE42NPETtHZJYusIrDUMNbYX+7w66X1aXf/bp15Wc2xOMtfG2C2OxZB2I4jWBsNVvlluaVfkASre6/liFIN3ZuDEseuIn+sgJtko2UD2+85CVa7TZbcp8FYDeFWZJfXOlr8Dew9yH9dDonmoTmMSdyLAr5mvEYtf1Ncl4h4SpDaUCOnTeCHsUNOwiiQlRH/70gcGjutIoO3e+bllY4hoGJGPdp/qJeQG1N9/jOYBAQmJKDoSXpoirnKrjnxnfdSSaDrJmizYRZTdO92qTwrGl7i4ZyXgi6Q5RiS8CFTFUxK2ecST76U98FRI9Yx9w2cwKwCuSdcu4zjVcb6Pfi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP45TGotFcPnMTqvsEe8IqQciJFPIzynwhiPiSk/1Is=;
 b=Fr5VfiToN3LVrvix76APq09iX49VAqjzGZQugBf55sNCunhYr2RVKBHV+VeA8a3TwfOSUa//iOmS+WM21bcEWeSgXNEwKfD1C87X1psugx2V3UUaI4GhPsAovBOhfZxH1+KlqQE6jsHtRtcHTSnVMyiSa/destwi0rxpffunYB/fzqjrxAo66zemdorW5URFkTcYqFrYWwZQcyLV1ZgCRMv6W95Z2+klm6QNO0r14GL0UjFecfL+uEvSkPzX3XBTvvRq1lptIL51uVK4pfwgQqeo+5k5EL8vvAZB31Y8QXJCMz9rLeEz1KHs9KhvKo+3qhRTSQ9utH+60zcfXeFJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP45TGotFcPnMTqvsEe8IqQciJFPIzynwhiPiSk/1Is=;
 b=YT8tfhLYj/4yuD/4JamELJQJJTRJZ0KtWhFeXnf+u70TyhnpU0ep8ememf4h4Lji2zLJxqG7/LncnJaU5bq/sXnQcpLCCmHPKpvJp2IObboIA2F7XO8xm97Jz5mYMyGqYJ1fWWHpgnP6LnfoZjl0h0DX9zjSnNHrDecXyoTCleg=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Wed, 12 Oct
 2022 18:14:35 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::70) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Wed, 12 Oct 2022 18:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 18:14:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 13:14:33 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 12 Oct 2022 13:14:32 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V2 3/3] PCI: Add basic properties for dynamically generated PCI OF node
Date:   Wed, 12 Oct 2022 11:14:00 -0700
Message-ID: <1665598440-47410-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
References: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e0741f-7fc5-4766-6d47-08daac7d9e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SfcVDTGjGjdQI8wI8SPPDwi6nV7vL6fBDqr9bkUTmb7j3wuTaKg8aXE0BkK9BXzHuPYS6arUdh+uJ3rf0qK4wA7OUW88215IMavxjnPmpKocZ5RP23y32fcBGanbLa5wZlRBU5N/ccBLZaJbaElyYwG5avOxgctUG+7OdhdQhLZtnZu834P3WVD51NrFG9guAblF/nth7hPvtWXtp8Vu+gxgxOxEHpOUnySsJjRLR9c250d6XOivO78oqo2QutbAZFQcnyeVbAzZhMtpw8GTTzwuShsWkEIAoAEqWW8U/h7i39hkntVQQh/jj259KVV6jzyJ6xVO2aD7cALjgMkOmYnK0lf4H73ZPM5Bc/I/BAIOvjKUjV8Vu4ly3F+D4uc/SrX9y1Qh6IQCuWgqW0icwRI6M2d1YCuxt4gc2wHqeVV580Etzg4ba13/EAkq1F7KZF5tpsFQ9KX41s1L7As9JDXrPjGwG98f2iYNKH2rdgHujawNa0dkfTunkOOOHiYYhQBRvL7NCEio6IX0x2BEPwsdQ8eyTZGSfvHHgyAB9uv0s7GDxNuPctzCfsdDf7+qfZxgSTKxGEpWe3ZSV/jGsMakFNdpabh5zeO60OdE33En5DSVVyyrE+VzYoLwSl8Ypeaepm3AViK0z+/ezEjfe3kAG/ztTqX27r1QsclmM5cp/Wk0AVeYwmv3Q8X1XtC5BzuGJNituJyjrubUDKS7w9pLg3HUM/sMUmYT9xIBnrpqycvY+jmTZQcePTWiJSLdpqVceN8E3rcW+hXDtnScfFSUNBm/bbANki8CICmLRY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(81166007)(36756003)(86362001)(186003)(44832011)(83380400001)(2616005)(70206006)(8676002)(82740400003)(47076005)(36860700001)(426003)(41300700001)(2906002)(82310400005)(316002)(4326008)(6666004)(26005)(54906003)(70586007)(40460700003)(356005)(478600001)(5660300002)(336012)(40480700001)(8936002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 18:14:35.4557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e0741f-7fc5-4766-6d47-08daac7d9e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch addes 'reg', 'compatible' and 'device_typ' properties for
dynamically generated PCI device tree node

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Brian Xu <brian.xu@amd.com>
---
 drivers/pci/Makefile      |   1 +
 drivers/pci/of.c          |  10 ++-
 drivers/pci/of_property.c | 177 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |   3 +-
 4 files changed, 189 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/of_property.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 2680e4c92f0a..cc8b4e01e29d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 83e042f495a6..00d716589660 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -619,6 +619,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 {
 	struct device_node *parent, *dt_node;
 	const char *pci_type = "dev";
+	struct property *props;
 	char *full_name;
 
 	/*
@@ -645,10 +646,15 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (!full_name)
 		goto failed;
 
-	dt_node = of_create_node(parent, full_name, NULL);
+	props = of_pci_props_create(pdev);
+	if (!props)
+		goto failed;
+
+	dt_node = of_create_node(parent, full_name, props);
 	if (!dt_node)
 		goto failed;
 
+	of_pci_props_destroy(props);
 	kfree(full_name);
 
 	pdev->dev.of_node = dt_node;
@@ -656,6 +662,8 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	return;
 
 failed:
+	if (props)
+		of_pci_props_destroy(props);
 	kfree(full_name);
 }
 #endif
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
new file mode 100644
index 000000000000..693a08323aa4
--- /dev/null
+++ b/drivers/pci/of_property.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+
+struct of_pci_prop {
+	char *name;
+	int (*prop_val)(struct pci_dev *pdev, void **val, u32 *len);
+};
+
+struct of_pci_addr_pair {
+	__be32		phys_hi;
+	__be32		phys_mid;
+	__be32		phys_lo;
+	__be32		size_hi;
+	__be32		size_lo;
+};
+
+#define OF_PCI_ADDR_SPACE_CONFIG	0x0
+#define OF_PCI_ADDR_SPACE_IO		0x1
+#define OF_PCI_ADDR_SPACE_MEM32		0x2
+#define OF_PCI_ADDR_SPACE_MEM64		0x3
+
+#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
+#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
+#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
+#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
+#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
+#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
+
+#define OF_PCI_SIZE_HI			GENMASK_ULL(63, 32)
+#define OF_PCI_SIZE_LO			GENMASK_ULL(31, 0)
+
+#define OF_PCI_PROP_COMPAT_LEN_MAX	256
+static int of_pci_prop_device_type(struct pci_dev *pdev, void **val, u32 *len)
+{
+	if (!pci_is_bridge(pdev))
+		return 0;
+
+	*val = kasprintf(GFP_KERNEL, "pci");
+	if (!*val)
+		return -ENOMEM;
+
+	*len = strlen(*val) + 1;
+
+	return 0;
+}
+
+static int of_pci_prop_reg(struct pci_dev *pdev, void **val, u32 *len)
+{
+	struct of_pci_addr_pair *reg;
+	u32 reg_val, base_addr, ss;
+	resource_size_t sz;
+	int i = 1, resno;
+
+	reg = kzalloc(sizeof(*reg) * (PCI_STD_NUM_BARS + 1), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	reg_val = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, OF_PCI_ADDR_SPACE_CONFIG) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
+		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
+	reg[0].phys_hi = cpu_to_be32(reg_val);
+
+	base_addr = PCI_BASE_ADDRESS_0;
+	for (resno = PCI_STD_RESOURCES; resno <= PCI_STD_RESOURCE_END;
+	     resno++, base_addr += 4) {
+		sz = pci_resource_len(pdev, resno);
+		if (!sz)
+			continue;
+
+		if (pci_resource_flags(pdev, resno) & IORESOURCE_IO)
+			ss = OF_PCI_ADDR_SPACE_IO;
+		else if (pci_resource_flags(pdev, resno) & IORESOURCE_MEM_64)
+			ss = OF_PCI_ADDR_SPACE_MEM64;
+		else
+			ss = OF_PCI_ADDR_SPACE_MEM32;
+
+		reg_val &= ~(OF_PCI_ADDR_FIELD_SS | OF_PCI_ADDR_FIELD_PREFETCH |
+				OF_PCI_ADDR_FIELD_REG);
+		reg_val |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss) |
+			FIELD_PREP(OF_PCI_ADDR_FIELD_REG, base_addr);
+		if (pci_resource_flags(pdev, resno) & IORESOURCE_PREFETCH)
+			reg_val |= OF_PCI_ADDR_FIELD_PREFETCH;
+		reg[i].phys_hi = cpu_to_be32(reg_val);
+		reg[i].size_hi = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_HI, sz));
+		reg[i].size_lo = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_LO, sz));
+		i++;
+	}
+
+	*val = reg;
+	*len = i * sizeof(*reg);
+
+	return 0;
+}
+
+static int of_pci_prop_compatible(struct pci_dev *pdev, void **val, u32 *len)
+{
+	char *compat;
+
+	compat = kzalloc(OF_PCI_PROP_COMPAT_LEN_MAX, GFP_KERNEL);
+	if (!compat)
+		return -ENOMEM;
+
+	*val = compat;
+	if (pdev->subsystem_vendor) {
+		compat += sprintf(compat, "pci%x,%x.%x.%x.%x",
+				  pdev->vendor, pdev->device,
+				  pdev->subsystem_vendor,
+				  pdev->subsystem_device,
+				  pdev->revision) + 1;
+		compat += sprintf(compat, "pci%x,%x.%x.%x",
+				  pdev->vendor, pdev->device,
+				  pdev->subsystem_vendor,
+				  pdev->subsystem_device) + 1;
+		compat += sprintf(compat, "pci%x,%x",
+				  pdev->subsystem_vendor,
+				  pdev->subsystem_device) + 1;
+	}
+	compat += sprintf(compat, "pci%x,%x.%x",
+			  pdev->vendor, pdev->device, pdev->revision) + 1;
+	compat += sprintf(compat, "pci%x,%x", pdev->vendor, pdev->device) + 1;
+	compat += sprintf(compat, "pciclass,%06x", pdev->class) + 1;
+	compat += sprintf(compat, "pciclass,%04x", pdev->class >> 8) + 1;
+
+	*len = (u32)(compat - (char *)*val);
+
+	return 0;
+}
+
+struct of_pci_prop of_pci_props[] = {
+	{ .name = "device_type", .prop_val = of_pci_prop_device_type },
+	{ .name = "reg", .prop_val = of_pci_prop_reg },
+	{ .name = "compatible", .prop_val = of_pci_prop_compatible },
+	{},
+};
+
+struct property *of_pci_props_create(struct pci_dev *pdev)
+{
+	struct property *props, *pp;
+	void *val;
+	u32 len;
+	int i;
+
+	props = kcalloc(ARRAY_SIZE(of_pci_props), sizeof(*props), GFP_KERNEL);
+	if (!props)
+		return NULL;
+
+	pp = props;
+	for (i = 0; of_pci_props[i].name; i++) {
+		len = 0;
+		of_pci_props[i].prop_val(pdev, &val, &len);
+		if (!len)
+			continue;
+		props->name = of_pci_props[i].name;
+		props->value = val;
+		props->length = len;
+		props++;
+	}
+
+	return pp;
+}
+
+void of_pci_props_destroy(struct property *props)
+{
+	int i;
+
+	for (i = 0; props[i].name; i++)
+		kfree(props[i].value);
+	kfree(props);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e0a11497b1ad..37841241ceea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -681,7 +681,8 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
 void of_pci_make_dev_node(struct pci_dev *pdev);
 void of_pci_remove_node(struct pci_dev *pdev);
-
+struct property *of_pci_props_create(struct pci_dev *pdev);
+void of_pci_props_destroy(struct property *props);
 #else
 static inline void
 of_pci_make_dev_node(struct pci_dev *pdev)
-- 
2.17.1

