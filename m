Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B26329DE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiKUQnc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 11:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKUQnZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 11:43:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E69BF5B6;
        Mon, 21 Nov 2022 08:43:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBK3QMtLO9jOQlpRdspYfpVi6QKBC6QrLKETuGPDGcRHhhLOE6xPUkKC0okcKRhlHrmv/+EzOhdbfVOoJUUnEQoI6L48euNITcI/lwboNwn/NpEr/3mYzf4VKiGRor9Dqm5AOXmzYqv5nAe77fztKNTD0EmkBypEyDOFPO2MxzEcf10f9w+Y+SEaC9wcMIYhWqsr/CNT0r59StpN8tqQyM84v0C9bpgc+r738iTnqbyEOfj+I6XpH8jlu0bppbRTDLOXAg9Yme6qgEQ7FlYVM+85oEfKRi3c+L/InTbm+o27ciAMYICYS2SSsdt9SBezjLAy2wadrAWRT4Y5wJshrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2axPqeESC/l8aE6D21gNNvD9QRikcwKhy3ptffKIg4=;
 b=lygfDWdcEt4DwqwLz32WKWkOhV9INXE8wd2iSyndlbJkmjHG4P8PUvDZbxiFxv3rO62JvKmMP+EkE8G92HcSrp2QS4pko0ucbaK/TFkA1KgjQk+K5sDIOgJefD0HYzr4hXSgD6AQBCsSmQZs32IxgtYo6gU1cPw7aMRjIq9e5nva82TngdMQX2UfPjIQj7kqGATvcmBDP+r6NdPbupHYNnh2x3y9RUdebobm3IZHUcc3iIFzF8FMRlG2ENHb0uyf5hcnRbeKfJg2slKcdBgQW8Yu8XezYaNk8SXg5WFou6oV9QfVgq44ZHqKUFzuzT2Dd75828Tw5z/L+gjkgckDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2axPqeESC/l8aE6D21gNNvD9QRikcwKhy3ptffKIg4=;
 b=p2RiqX7Dnrtqs5loSFomC1IrUHeSaqSQYYvYpaoW0ZuGRx7FVz8+pkE5XaU9YdCD6OoqHQ2GJ7WEOuz7iH2cx++3pwy7Mp7dsy6JYPYFzfmQe2wj6K8K7ni4i2y7V7RiY9VUfygdD6GcUAG8u4Gdv5hvyzAhGaxDoiOe+iLLuPM=
Received: from BN8PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:ac::30)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:43:15 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::ef) by BN8PR07CA0017.outlook.office365.com
 (2603:10b6:408:ac::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 16:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 16:43:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 10:43:14 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 21 Nov 2022 10:43:13 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [RESEND PATCH RFC V4 1/3] of: dynamic: Add interfaces for creating device node dynamically
Date:   Mon, 21 Nov 2022 08:43:02 -0800
Message-ID: <1669048984-56394-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 43aed840-f991-415f-16ca-08dacbdf7c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJOEplWJtwhDVGlD5zDFRCdjwfZLXIZCBN6QWunttPQ0/eX2CZXYdC/tRL4Ovse+bhjiV8Cg+l/EaAxhXvWYcxMGDi5a0G2TqmIF/w4uI3FOwBzfYS5i2tkX+lsfEnYKSsxeTReB79mbXjvEn4yCc99Exdg81QUsmbHCox6285Kn/SI/uSyYfyc5mA/MPsOIC4A46LhG2Oj2ZCuoP3dKOuNjO6OgJy49yi++GY+dr4i1Qk9gobxLrhhosm7v38Z2UdAkGz+AlXKL9qX7Y95y6Nx+o02Judz1sRMG2At99T5Dqd4zTCOwFPqLvfhWl+6rFUIZgEtcxDFWm5MdFC7LOYksltIULnFzNu5yib/26FWZAGCAogXtp/8J6MulJ6ewG+bGrt7GeidUjLadQO050fbGjdcLjGASUlf2q1M68PuL6UrvucukK/vZCAxdc3cFok0JXJ/S36+M4gxMWs1s/OWw5+zLUIDM/1GSDpzonBTmMsH4aiJdSjzkyrlpRwjtfsrOXmV29Fzw3c6qScrTWCGCR69+5aOuAKtrScZsD3ENSV5hxfj8r+K9vu4SoYCZswCrOkHEsENYnHLhCzLFmuEpo8a529ya0H+HPuu6xR31j/EDwO0egAK8mln6WT87PsWERGoSaSIMXrqNS+fSwafwwxLRJQHqHuYhnVkqUcTL+EsdEBBV3H0jNwA67wKlonKUhBgHNPibfB8yHWdAPLmOEk5VIxk/DJ3bUHVCoqs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82310400005)(4326008)(70586007)(40460700003)(40480700001)(41300700001)(70206006)(2616005)(426003)(47076005)(186003)(5660300002)(8676002)(8936002)(336012)(6666004)(478600001)(26005)(316002)(44832011)(110136005)(82740400003)(54906003)(81166007)(356005)(83380400001)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:43:15.4365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43aed840-f991-415f-16ca-08dacbdf7c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_create_node() creates device node dynamically. The parent device node
and full name are required for creating the node. It optionally creates
an OF changeset and attaches the newly created node to the changeset. The
device node pointer and the changeset pointer can be used to add
properties to the device node and apply the node to the base tree.

of_destroy_node() frees the device node created by of_create_node(). If
an OF changeset was also created for this node, it will destroy the
changeset before freeing the device node.

Expand of_changeset APIs to handle specific types of properties.
    of_changeset_add_prop_string()
    of_changeset_add_prop_string_array()
    of_changeset_add_prop_u32_array()

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Reviewed-by: Brian Xu <brian.xu@amd.com>
---
 drivers/of/dynamic.c | 187 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  24 ++++++
 2 files changed, 211 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index cd3821a6444f..71d53c81b396 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -461,6 +461,72 @@ struct device_node *__of_node_dup(const struct device_node *np,
 	return NULL;
 }
 
+/**
+ * of_create_node - Dynamically create a device node
+ *
+ * @parent: Pointer to parent device node
+ * @full_name: Node full name
+ * @cset: Pointer to returning changeset
+ *
+ * Return: Pointer to the created device node or NULL in case of an error.
+ */
+struct device_node *of_create_node(struct device_node *parent,
+				   const char *full_name,
+				   struct of_changeset **cset)
+{
+	struct of_changeset *ocs;
+	struct device_node *np;
+	int ret;
+
+	np = __of_node_dup(NULL, full_name);
+	if (!np)
+		return NULL;
+	np->parent = parent;
+
+	if (!cset)
+		return np;
+
+	ocs = kmalloc(sizeof(*cset), GFP_KERNEL);
+	if (!ocs) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	of_changeset_init(ocs);
+	ret = of_changeset_attach_node(ocs, np);
+	if (ret) {
+		of_changeset_destroy(ocs);
+		of_node_put(np);
+		kfree(ocs);
+		return NULL;
+	}
+
+	np->data = ocs;
+	*cset = ocs;
+
+	return np;
+}
+EXPORT_SYMBOL(of_create_node);
+
+/**
+ * of_destroy_node - Destroy a dynamically created device node
+ *
+ * @np: Pointer to dynamically created device node
+ *
+ */
+void of_destroy_node(struct device_node *np)
+{
+	struct of_changeset *ocs;
+
+	if (np->data) {
+		ocs = (struct of_changeset *)np->data;
+		of_changeset_destroy(ocs);
+		kfree(ocs);
+	}
+	of_node_put(np);
+}
+EXPORT_SYMBOL(of_destroy_node);
+
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
 	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
@@ -934,3 +1000,124 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_changeset_action);
+
+static int of_changeset_add_prop_helper(struct of_changeset *ocs,
+					struct device_node *np,
+					const struct property *pp)
+{
+	struct property *new_pp;
+	int ret;
+
+	new_pp = __of_prop_dup(pp, GFP_KERNEL);
+	if (!new_pp)
+		return -ENOMEM;
+
+	ret = of_changeset_add_property(ocs, np, new_pp);
+	if (ret) {
+		kfree(new_pp->name);
+		kfree(new_pp->value);
+		kfree(new_pp);
+	}
+
+	return ret;
+}
+
+/**
+ * of_changeset_add_prop_string - Add a string property to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @str:	pointer to null terminated string
+ *
+ * Create a string property and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_string(struct of_changeset *ocs,
+				 struct device_node *np,
+				 const char *prop_name, const char *str)
+{
+	struct property prop;
+
+	prop.name = (char *)prop_name;
+	prop.length = strlen(str) + 1;
+	prop.value = (void *)str;
+
+	return of_changeset_add_prop_helper(ocs, np, &prop);
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_string);
+
+/**
+ * of_changeset_add_prop_string_array - Add a string list property to
+ * a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @str_array:	pointer to an array of null terminated strings
+ * @sz:		number of string array elements
+ *
+ * Create a string list property and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_string_array(struct of_changeset *ocs,
+				       struct device_node *np,
+				       const char *prop_name,
+				       const char **str_array, size_t sz)
+{
+	struct property prop;
+	int i, ret;
+	char *vp;
+
+	prop.name = (char *)prop_name;
+
+	prop.length = 0;
+	for (i = 0; i < sz; i++)
+		prop.length += strlen(str_array[i]) + 1;
+
+	prop.value = kmalloc(prop.length, GFP_KERNEL);
+	if (!prop.value)
+		return -ENOMEM;
+
+	vp = prop.value;
+	for (i = 0; i < sz; i++) {
+		vp += snprintf(vp, (char *)prop.value + prop.length - vp, "%s",
+			       str_array[i]) + 1;
+	}
+	ret = of_changeset_add_prop_helper(ocs, np, &prop);
+	kfree(prop.value);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_string_array);
+
+/**
+ * of_changeset_add_prop_u32_array - Add a property of 32 bit integers
+ * property to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ * @array:	pointer to an array of 32 bit integers
+ * @sz:		number of array elements
+ *
+ * Create a property of 32 bit integers and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name,
+				    const u32 *array, size_t sz)
+{
+	struct property prop;
+
+	prop.name = (char *)prop_name;
+	prop.length = sizeof(u32) * sz;
+	prop.value = (void *)array;
+
+	return of_changeset_add_prop_helper(ocs, np, &prop);
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
diff --git a/include/linux/of.h b/include/linux/of.h
index 766d002bddb9..ba31036f0876 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1505,6 +1505,30 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 {
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
+
+struct device_node *of_create_node(struct device_node *parent,
+				   const char *full_name,
+				   struct of_changeset **cset);
+void of_destroy_node(struct device_node *np);
+int of_changeset_add_prop_string(struct of_changeset *ocs,
+				 struct device_node *np,
+				 const char *prop_name, const char *str);
+int of_changeset_add_prop_string_array(struct of_changeset *ocs,
+				       struct device_node *np,
+				       const char *prop_name,
+				       const char **str_array, size_t sz);
+int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name,
+				    const u32 *array, size_t sz);
+static inline int of_changeset_add_prop_u32(struct of_changeset *ocs,
+					    struct device_node *np,
+					    const char *prop_name,
+					    const u32 val)
+{
+	return of_changeset_add_prop_u32_array(ocs, np, prop_name, &val, 1);
+}
+
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
-- 
2.17.1

