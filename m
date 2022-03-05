Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757554CE2AF
	for <lists+linux-pci@lfdr.de>; Sat,  5 Mar 2022 06:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiCEFM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Mar 2022 00:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiCEFM0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Mar 2022 00:12:26 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67A56C1E8;
        Fri,  4 Mar 2022 21:11:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeRWOuaZhLj1jryVWj41XnDo1zPop2WSrrQaCOIXieco6SRrBD9Jr0v9H3n1PjJfqSgWs5l8O6AM/hbvfwGuohjwEr3T48w0JsWH1Y3hI7Z0CL0NTuKjoUUWtxjhIRMq3CwC13HHeI0m8nApuE4qf2vcWBb1FknFQSlBScVmZuq+espk0nvwoHK71RC9Q0PWnwiKchrRP+k2TQS568YNZI6KQePlrCRK+cgz/dKuPH3kMdiQli3i3PEFdLRikYwdeGWT94DNixx+4p/xPiY6A80f9RddMbQnaFnDRBYZdU/QCnx4uvrgR7ZnhVGD+1CrOjebOaXc1QYMlN6r0AZ0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YaIMcnkqkA7VrLiz5PDiYFwijwL2DpD7MCfhu9ZTGc=;
 b=DT55FFxOiqq9Uwl4ZbLm6jsEWUEwfqyaKb31dW9IiQW1592UziEUFOdfOhbGQhbUNiaFPrMf2+hcoCKp9Cv0ESCIB2K/MuL1VenU1HqFSAkrY9XZ3s07gw7eTUBukJXnQbwmsPrWkmBZe28u42gvNbkZnaSUZILhj2/GxFrMJQBvstiUTGaz04mig38t3I5/osfYEjtxxDi4edSxUfn8hkpF3j4lX8GO3jQvmwLrCDy63+SxJI2eKjjHTcfFlGxEHy6Q2r8DgIsvOfdYzAmdhITrwX989bFYy9lqdW+UuBW5ihQpQjG8Ah/kl/GnAPCx7YvKYPpbALePaTqK9dB6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YaIMcnkqkA7VrLiz5PDiYFwijwL2DpD7MCfhu9ZTGc=;
 b=h1K0GhZl4MP8p8LEbldvNdQnN2SbQHIaexh6vSRY9NXQ9/i8Sg1pVhZHY/15NRrdo8ztIARceJPC9HfMDHPYuKVhyjOs/6y420iKtA0eO9q3F7YG8uyjhL19vNY9rFnu6IZc1kHmpkamf3NkfcDyk83rS82R9lEwtS4DazX0KDg=
Received: from DM5PR06CA0062.namprd06.prod.outlook.com (2603:10b6:3:37::24) by
 CY4PR02MB2456.namprd02.prod.outlook.com (2603:10b6:903:6b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.16; Sat, 5 Mar 2022 05:11:34 +0000
Received: from DM3NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::a9) by DM5PR06CA0062.outlook.office365.com
 (2603:10b6:3:37::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Sat, 5 Mar 2022 05:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT022.mail.protection.outlook.com (10.13.5.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Sat, 5 Mar 2022 05:11:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Mar 2022 21:11:32 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Mar 2022 21:11:32 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org
Received: from [172.19.72.93] (port=44414 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nQMhY-0008c2-KP; Fri, 04 Mar 2022 21:11:32 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 4EF8D600197; Fri,  4 Mar 2022 21:11:08 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 1/4] pci: add interface to create pci-ep device tree node
Date:   Fri, 4 Mar 2022 21:11:02 -0800
Message-ID: <20220305051105.725838-2-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305051105.725838-1-lizhi.hou@xilinx.com>
References: <20220305051105.725838-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ffac46-b71a-476d-6a05-08d9fe669db2
X-MS-TrafficTypeDiagnostic: CY4PR02MB2456:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB2456EAF5CB1E1CCA90FFED8EA1069@CY4PR02MB2456.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXmfiXfzXHDxYUb6NHY5VZr1Mba6efGhQHlhPWz/PbecKGFrc0T21NBsaKy7t7RTHjW9IKrcNptnmrQIG4MyYR+Hi4d0/9szUlOtmYkyLzde1sUl3uXVf9S5xRDNeq2YwMugCZtdwHZxcJbkcGd9X8MSEdFyk7SCcd4zwmiRNfg49KotC34wdLzj2pDoKgRGusi3Kp6huIvalITzqOWzgDYtZRfoNv1BNH/lqZN1viz4xyFTzgJxQc5E71h17XSSMb5WhIsk6S2qdBf/cJNQ7ZW1+ta1DZWLkK9Q8RUwpibhof1sq4UPZJxmrj1UMcbOOSl89GAVprpETnDGOmp2rgviSrsfI4h0GdfMBgNPw4ZwqUIObeLM716EKLO8TMVNLk4QYz8g6v6g5QS9Zjw6UmOgTJxA6Z1klo4+8ZMbHIfsXY6YzeX/jRgeoOT4wddAM95uVB5YDDwX6hJU3hnIsoFURTlBMZeScxerdwHB0i288iy42xMhtA7VnD3/Myrw95syGBH7oaWw99ayp8LrGkB3A4MG7PnOz2hadsp+7kh7Nd7n/pNsIGTIiHy/32chbEl1nAD41MmQsLTms3Cua85xVQV20aDyM1N0/RP6vGurGsLFIjbw5n7VdQ8T9/BLVCT9FM4RROS3ca8CLp7GUg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(83380400001)(44832011)(8936002)(42186006)(70586007)(4326008)(70206006)(8676002)(54906003)(36756003)(5660300002)(110136005)(316002)(47076005)(2906002)(7636003)(6666004)(82310400004)(107886003)(2616005)(6266002)(26005)(426003)(1076003)(186003)(36860700001)(336012)(356005)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 05:11:33.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ffac46-b71a-476d-6a05-08d9fe669db2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2456
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch enables PCIe device to uses flattened device tree to describe
apertures in its PCIe BARs. The aperture address consists of PCIe BAR index
and offset.

For this kind of device, the driver probe routine calls the new added
interface to create a device tree node. This device tree node is attached
under system device tree root. Then the driver may load the flatten device
tree overlay and attach it under this node. And the node also contains
'ranges' property which is used to translate aperture address(BAR index
and offset) to CPU address.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/pci/of.c       | 180 +++++++++++++++++++++++++++++++++++++++++
 include/linux/of_pci.h |  15 ++++
 2 files changed, 195 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index cb2e8351c2cc..198f08351070 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -605,6 +605,186 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 	return pci_parse_request_of_pci_ranges(dev, bridge);
 }
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+
+static void devm_of_pci_destroy_bus_endpoint(struct device *dev, void *res)
+{
+	struct device_node *node = res;
+
+	of_detach_node(node);
+}
+
+static int of_ep_add_property(struct device *dev, struct property **proplist, const char *name,
+			      const int length, void *value)
+{
+	struct property *new;
+
+	new = devm_kzalloc(dev, sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	new->name = devm_kstrdup(dev, name, GFP_KERNEL);
+	if (!new->name)
+		return -ENOMEM;
+
+	new->value = devm_kmalloc(dev, length, GFP_KERNEL);
+	if (!new->value)
+		return -ENOMEM;
+
+	memcpy(new->value, value, length);
+	new->length = length;
+	new->next = *proplist;
+	*proplist = new;
+
+	return 0;
+}
+
+static struct device_node *of_ep_alloc_node(struct pci_dev *pdev, const char *name)
+{
+	struct device_node *node;
+	char *full_name;
+
+	node = devres_alloc(devm_of_pci_destroy_bus_endpoint, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return NULL;
+
+	full_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "/%s@%llx", name,
+				   (u64)pci_resource_start(pdev, 0));
+	if (!full_name)
+		return NULL;
+
+	node->parent = of_root;
+	node->full_name = full_name;
+	of_node_set_flag(node, OF_DYNAMIC);
+	of_node_init(node);
+
+	return node;
+}
+
+/**
+ * devm_of_pci_create_bus_endpoint - Create a device node for the given pci device.
+ * @pdev: PCI device pointer.
+ *
+ * For PCI device which uses flattened device tree to describe apertures in its BARs,
+ * a device node for the given pci device is required. Then the flattened device tree
+ * overlay from the device can be applied to the base tree.
+ * The device node is under root node and act like bus node. It contains a "ranges"
+ * property which is used for address translation of its children. Each child node
+ * corresponds an aperture and use BAR index and offset as its address.
+
+ * Returns 0 on success or a negative error-code on failure.
+ */
+int devm_of_pci_create_bus_endpoint(struct pci_dev *pdev)
+{
+	struct property *proplist = NULL;
+	struct device *dev = &pdev->dev;
+	int range_ncells, addr_ncells;
+	struct device_node *node;
+	void *prop = NULL;
+	u32 *range_cell;
+	__be32 val;
+	int i, ret;
+
+	node = of_ep_alloc_node(pdev, "pci-ep-bus");
+	if (!node)
+		return -ENOMEM;
+
+	/* the endpoint node works as 'simple-bus' to translate aperture addresses. */
+	prop = "simple-bus";
+	ret = of_ep_add_property(dev, &proplist, "compatible", strlen(prop) + 1, prop);
+	if (ret)
+		goto cleanup;
+
+	/* The address and size cells of nodes underneath are 2 */
+	val = cpu_to_be32(2);
+	ret = of_ep_add_property(dev, &proplist, "#address-cells", sizeof(u32), &val);
+	if (ret)
+		goto cleanup;
+
+	ret = of_ep_add_property(dev, &proplist, "#size-cells", sizeof(u32), &val);
+	if (ret)
+		goto cleanup;
+
+	/* child address format: 0xIooooooo oooooooo, I = bar index, o = offset on bar */
+	addr_ncells = of_n_addr_cells(node);
+	if (addr_ncells > 2) {
+		/* does not support number of address cells greater than 2 */
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	/* range cells include <node addr cells> <child addr cells> <child size cells> */
+	range_ncells = addr_ncells + 4;
+	prop = kzalloc(range_ncells * sizeof(u32) * PCI_STD_NUM_BARS, GFP_KERNEL);
+	if (!prop) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	range_cell = prop;
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (!pci_resource_len(pdev, i))
+			continue;
+		/* highest 4 bits of address are bar index */
+		*(__be64 *)range_cell = cpu_to_be64((u64)i << 60);
+		range_cell += 2;
+		if (addr_ncells == 2)
+			*(__be64 *)range_cell = cpu_to_be64((u64)pci_resource_start(pdev, i));
+		else
+			*(__be32 *)range_cell = cpu_to_be32((u32)pci_resource_start(pdev, i));
+
+		range_cell += addr_ncells;
+		*(__be64 *)range_cell = cpu_to_be64((u64)pci_resource_len(pdev, i));
+		range_cell += 2;
+	}
+
+	/* error out if there is not PCI BAR been found */
+	if ((void *)range_cell == prop) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = of_ep_add_property(dev, &proplist, "ranges", (void *)range_cell - prop, prop);
+	kfree(prop);
+	if (ret)
+		goto cleanup;
+
+	node->properties = proplist;
+	ret = of_attach_node(node);
+	if (ret)
+		goto cleanup;
+
+	devres_add(dev, node);
+
+	return 0;
+
+cleanup:
+	kfree(prop);
+	if (node)
+		devres_free(node);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_pci_create_bus_endpoint);
+
+struct device_node *of_pci_find_bus_endpoint(struct pci_dev *pdev)
+{
+	struct device_node *dn;
+	char *path;
+
+	path = kasprintf(GFP_KERNEL, "/pci-ep-bus@%llx",
+			 (u64)pci_resource_start(pdev, 0));
+	if (!path)
+		return NULL;
+
+	dn = of_find_node_by_path(path);
+	kfree(path);
+
+	return dn;
+}
+EXPORT_SYMBOL_GPL(of_pci_find_bus_endpoint);
+#endif /* CONFIG_OF_DYNAMIC */
+
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29658c0ee71f..c1d86be321b2 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -38,4 +38,19 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC) && IS_ENABLED(CONFIG_PCI)
+int devm_of_pci_create_bus_endpoint(struct pci_dev *pdev);
+struct device_node *of_pci_find_bus_endpoint(struct pci_dev *pdev);
+#else
+static inline int devm_of_pci_create_bus_endpoint(struct pci_dev *pdev)
+{
+	return -EINVAL;
+}
+
+static inline struct device_node *of_pci_find_bus_endpoint(struct pci_dev *pdev)
+{
+	return NULL;
+}
+#endif
+
 #endif
-- 
2.27.0

