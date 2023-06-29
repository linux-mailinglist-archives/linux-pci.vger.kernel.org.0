Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7107B742B45
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjF2Rbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:31:38 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:37070
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231768AbjF2Rbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2023 13:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMOpgZ2wqVcePZ7SVakmUoUJYdFgbUS7XsE7j4/P1tJmyOcVJoo7bsKIDUjsye7SGf8iAczKu0YIHOjSRAkqKABNb4kbkGU1BeqyaWDEcqOJ/A2SygRPO1CF9R4l6jFSn7CexlcuC0iAksYyW3teg+JBUmF0TxJa2CTKXhxx7wj4hhXVF3dUxHuKyn+8zC/FMzTy2D0t1vDWOD8W2IWtDStK7p50901tNRjhIH18o/QyYyFpDETMRfpesJqvp7E9WKFYBiyIMPFimNWNLc0LeamwpeqO61b4nayYn4KY1n2lezjpoLKRp1Eo6v69fsNHZ2eGZ08Qk11arzfpkYzDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GewLlpz3XfsZc+5THxZsHXFYOBx/SLC7l1DprcjQmJQ=;
 b=idLt/mLyUQ8Ubxmax/XdZzNIE1uWGWxxfrsL1AYfFZB+EH7I/R/8+83YPK+BAAPlwgPpydnax6zVj1+DXHFVYoZb3wWW++6+iqXJ+IvXx5+pcd/QcpWy+dxLi8oKYafq1vi1sXDeuYvH7LxJXdHzZncvOdsjaRkMZQc/vVogux9c2aJrB0Nk7BbRelpeqkL7QcatR+bnkev1SEs38+1d2AVb1c5Z105hSOSIlyyWyvle+d6XamtNBxmKEJhlT0kNpJQ2wPYmJ6lKWMgzleaJaFN8pSThRMxmPRTN5OcBhPWi6xyR+CosylkrwnLrYFUY74veXkweJh1bQuWH/04qNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GewLlpz3XfsZc+5THxZsHXFYOBx/SLC7l1DprcjQmJQ=;
 b=blTgEeSzBnILJAke3jdphrsDa7XJmImcJcD0BLZQG4bdpgS6Zg7cpQQlQy64UQ31ljcJUiGL8sFcNlNBCKOU5u2/SMI3KLRCnGkk8KkBVWdstoxaZL9JDKS2mCV2We95mf0JdLuWHd7SQSA8QfrPMiVL9zJW4uQLjs1dBnMHGo8=
Received: from BN9PR03CA0962.namprd03.prod.outlook.com (2603:10b6:408:109::7)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 17:31:30 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::41) by BN9PR03CA0962.outlook.office365.com
 (2603:10b6:408:109::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 17:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 17:31:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:29 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:31:29 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH V10 1/5] of: dynamic: Add interfaces for creating device node dynamically
Date:   Thu, 29 Jun 2023 10:19:46 -0700
Message-ID: <1688059190-4225-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
References: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|CH2PR12MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: cbee17b4-3de7-4ee6-d7c4-08db78c6ad0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgUVj1JImKQR/zcp2jdLfdZb6Qm6WfOUTWKyNWNWIK4rvmIE1zoCKN9agdQCS304CbfAl9/61Cruh/pKYcs0GaEER0j81ec7ZTk/FyeFF9M/FNeZIOTLz2PtFMZndpAsAZvCdUzuadx0zF9GdiyQ5QSH9WnXWdE22eTAYPFG0PMXffxgstmOOv/vTa94wUyV3FHIdsEloGmipFwxawW647GGNS5gJcdr/CvGx5voTiSf0DObCJ3Yv2qJHu0RLvlG33RIPbmu6R2StunJFPkIWZh0Mj2e0jtvl12Cbluh8d29o/IiRhHuQtt75taBM0kvosujI+R2QwA4VctL9Jfmg5gETvZOH2ibRHxguCM25UYsQ69MfYA61CGD2sEaVYjaAepzO8xcWADol2aaMc6RZt0EA1sp+BnnlMI3iSrrhf36pD98HjgE4K1UNhr7RVD7yUAc1yVigDS7YZ/MSiSYhIpCGUr3MdG6Ih7rzaaw3IOaPQj+d/DnaesRCXwRq4501idQu7rhaNVOFbA7igpfhaUeAqT4+tR4TghxzqR8q4Bd2cxoaqL7OUIafgH+YT8dr/73ZECrOsUJbuFOuB0yGQuMlVzWPwbnfJkrLZEGWKF+REddXms6FpaA+NId/RKgPajlcY84uSgoAzxVOSOL1EFAQTq9Y1XM64cJNYX7oo6FRdXzxS4cItAHmFSL1TmSHdKcXOYkVN/sQotyB1nZFg03NiKiVMZwRLMVzeZH1Vhw4ahYkrOI/DMz6okOWo8cwoTFRjYqZ6GiGRTD6d8sjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(2906002)(8676002)(36756003)(41300700001)(356005)(44832011)(40460700003)(316002)(5660300002)(70206006)(86362001)(4326008)(40480700001)(8936002)(70586007)(82740400003)(81166007)(66574015)(186003)(26005)(47076005)(83380400001)(6666004)(2616005)(54906003)(478600001)(110136005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:31:30.4877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbee17b4-3de7-4ee6-d7c4-08db78c6ad0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_changeset_create_node() creates device node dynamically and attaches
the newly created node to a changeset.

Expand of_changeset APIs to handle specific types of properties.
    of_changeset_add_empty_prop()
    of_changeset_add_prop_string()
    of_changeset_add_prop_string_array()
    of_changeset_add_prop_u32_array()

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/of/dynamic.c  | 187 ++++++++++++++++++++++++++++++++++++++++++
 drivers/of/unittest.c |  19 ++++-
 include/linux/of.h    |  26 ++++++
 3 files changed, 231 insertions(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index e311d406b170..4d0720a09be7 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -487,6 +487,38 @@ struct device_node *__of_node_dup(const struct device_node *np,
 	return NULL;
 }
 
+/**
+ * of_changeset_create_node - Dynamically create a device node and attach to
+ * a given changeset.
+ *
+ * @parent: Pointer to parent device node
+ * @full_name: Node full name
+ * @cset: Pointer to changeset
+ *
+ * Return: Pointer to the created device node or NULL in case of an error.
+ */
+struct device_node *of_changeset_create_node(struct device_node *parent,
+					     const char *full_name,
+					     struct of_changeset *cset)
+{
+	struct device_node *np;
+	int ret;
+
+	np = __of_node_dup(NULL, full_name);
+	if (!np)
+		return NULL;
+	np->parent = parent;
+
+	ret = of_changeset_attach_node(cset, np);
+	if (ret) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	return np;
+}
+EXPORT_SYMBOL(of_changeset_create_node);
+
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
 	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
@@ -960,3 +992,158 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
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
+ * of_changeset_add_empty_prop - Add an empty property to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ *
+ * Create an empty property and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_empty_prop(struct of_changeset *ocs,
+				struct device_node *np,
+				const char *prop_name)
+{
+	struct property prop = { 0 };
+
+	prop.name = (char *)prop_name;
+
+	return of_changeset_add_prop_helper(ocs, np, &prop);
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_empty_prop);
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
+	__be32 *val;
+	int i, ret;
+
+	val = kcalloc(sz, sizeof(__be32), GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	for (i = 0; i < sz; i++)
+		val[i] = cpu_to_be32(array[i]);
+	prop.name = (char *)prop_name;
+	prop.length = sizeof(u32) * sz;
+	prop.value = (void *)val;
+
+	ret = of_changeset_add_prop_helper(ocs, np, &prop);
+	kfree(val);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 2191c0136531..1193a574fa36 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -802,7 +802,9 @@ static void __init of_unittest_changeset(void)
 	struct property *ppname_n21, pname_n21 = { .name = "name", .length = 3, .value = "n21" };
 	struct property *ppupdate, pupdate = { .name = "prop-update", .length = 5, .value = "abcd" };
 	struct property *ppremove;
-	struct device_node *n1, *n2, *n21, *nchangeset, *nremove, *parent, *np;
+	struct device_node *n1, *n2, *n21, *n22, *nchangeset, *nremove, *parent, *np;
+	static const char * const str_array[] = { "str1", "str2", "str3" };
+	const u32 u32_array[] = { 1, 2, 3 };
 	struct of_changeset chgset;
 
 	n1 = __of_node_dup(NULL, "n1");
@@ -857,6 +859,17 @@ static void __init of_unittest_changeset(void)
 	unittest(!of_changeset_add_property(&chgset, parent, ppadd), "fail add prop prop-add\n");
 	unittest(!of_changeset_update_property(&chgset, parent, ppupdate), "fail update prop\n");
 	unittest(!of_changeset_remove_property(&chgset, parent, ppremove), "fail remove prop\n");
+	n22 = of_changeset_create_node(n2, "n22", &chgset);
+	unittest(n22, "fail create n22\n");
+	unittest(!of_changeset_add_prop_string(&chgset, n22, "prop-str", "abcd"),
+		 "fail add prop prop-str");
+	unittest(!of_changeset_add_prop_string_array(&chgset, n22, "prop-str-array",
+						     (const char **)str_array,
+						     ARRAY_SIZE(str_array)),
+		 "fail add prop prop-str-array");
+	unittest(!of_changeset_add_prop_u32_array(&chgset, n22, "prop-u32-array",
+						  u32_array, ARRAY_SIZE(u32_array)),
+		 "fail add prop prop-u32-array");
 
 	unittest(!of_changeset_apply(&chgset), "apply failed\n");
 
@@ -866,6 +879,9 @@ static void __init of_unittest_changeset(void)
 	unittest((np = of_find_node_by_path("/testcase-data/changeset/n2/n21")),
 		 "'%pOF' not added\n", n21);
 	of_node_put(np);
+	unittest((np = of_find_node_by_path("/testcase-data/changeset/n2/n22")),
+		 "'%pOF' not added\n", n22);
+	of_node_put(np);
 
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
 
@@ -874,6 +890,7 @@ static void __init of_unittest_changeset(void)
 	of_node_put(n1);
 	of_node_put(n2);
 	of_node_put(n21);
+	of_node_put(n22);
 #endif
 }
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 6ecde0515677..703152181a44 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1580,6 +1580,32 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 {
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
+
+struct device_node *of_changeset_create_node(struct device_node *parent,
+					     const char *full_name,
+					     struct of_changeset *cset);
+int of_changeset_add_empty_prop(struct of_changeset *ocs,
+				struct device_node *np,
+				const char *prop_name);
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
2.34.1

