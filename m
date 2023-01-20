Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B18D6749AF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 04:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjATDCl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 22:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjATDCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 22:02:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9C1CACE;
        Thu, 19 Jan 2023 19:02:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeIhDIf8hwLU3TgVog9hXJIogC/Rmcte7aliFccm/n0RlE3A7dCZ5vtGPcbUPvoR2qt+Ns1eHPSa3+jcjkCwT0xflGwSA7AsJ6bYn1YNN51KA5AT7MyW7pOeTYBwwK99NPigu4WmyKqHTY7LvFtbLIdskyXjINsZF6fyWa83YkReJ5FRREm6ixSJLmhCP9Z9t5DGSZ8Uwl7p5daghPeqjE04Byje/7MtMX2Sy6qkjX7cSKSj8KlaWs2Ne6DUbeVbiaDOYeE39uNN8kK9xtuLt0cWWIe8CGRdLIYYAQaNY9QEtTl4L/XNdWfmv/JPSxfYd14WqMe1xv9Vn+lE1Ccr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdlI4F5W5ZYE3228KtQJtCpbKkAXKajzwOx3KdJ2j5Q=;
 b=i0xpfqUDvtBy98oZlLG2q9IwqyJmJmjj54SHfmB0ziYHPPPckSL3F5hTzu0jk4TnBSjCvuoVFL8qHlLhAsJQC/wSiqmawj3D4+gbLkG/FujG4njh2Crx7WoSjETtQQs7gmiJA81Rmw4S+z4I037nmurVS2rVbx9ituHddoj+F8MxLqbs/Xz/t9k6tJJrKcYOpfS+BH8g13HU9tKEZ7uX2ZDf9PFT7N+ui+QSwtFHhDqExOS5zEH1bbYtu2Ydi/0rMJrp9R4TQxMYLgXfFe/Puk2c2w5uOA2Kti0dbU/9XIZ2o8tSyXrG9I0g3e8+fLPcHXqAHv2xJZL1zHRXl/eKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdlI4F5W5ZYE3228KtQJtCpbKkAXKajzwOx3KdJ2j5Q=;
 b=NhM7CUXtSghnkvE+5ccqPQ+GJflDc4lR19en7BuQI806ZHJt1SazZ5As82vVoM2QJ4D2+RhNEO4JwRk8Lznhy+UUD2PwEZK3ZV2c8qFzRdIsvsP969JoAmGe4f8e3OhLtFVZjdwaKTnd/DbqIyM9xqtsVREfErx0P98qRafoJW4=
Received: from DS7PR03CA0350.namprd03.prod.outlook.com (2603:10b6:8:55::27) by
 BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Fri, 20 Jan
 2023 03:02:35 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::5f) by DS7PR03CA0350.outlook.office365.com
 (2603:10b6:8:55::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26 via Frontend
 Transport; Fri, 20 Jan 2023 03:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 03:02:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 21:02:35 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 19 Jan 2023 21:02:34 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V7 1/3] of: dynamic: Add interfaces for creating device node dynamically
Date:   Thu, 19 Jan 2023 19:02:10 -0800
Message-ID: <1674183732-5157-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|BN9PR12MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e80d986-4537-4a95-89ed-08dafa92c841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnHlHIG2XzM5kNiSba3D1jynMVnOlvQ+i992jvqeQHmYAQa7iAf4nxEb8lCB7NRq6b2UObaCmnSUrrr8sOgv2KS5pmA/NP/YQpHwepRhu5dmBMW8jHg/4qGOmJXF14x95/i34fdAMG16FAQO1wzvL9dFr08ZK5Zqrs/jJm3VwDR/UHhYQ6qna4BAUD3e/qs7NePdNOkAhj8Y3v+F087980qE9BQEDbGOZrvvGiLwv/2r56C7x3qRYmInl0onuxmBZSOFDsw/v8FmekXZzJH15yK9TgEzKDABTbuqGLMjvHNdDv4vVAd6wFG05ZdX+gOWG8A3+D1Pjr9ov5UfxpteWJFGl62EaEqQgAa36PjTD2H7FLvc5vwIZCaVitdfYJFni+p+l01G49ZPTuO0a0RhzrrjvqBYcEUozU7MPXhYogUeskbBJAiY2zEZZ9gXTG0rgbKjrE48jbCP/5XtssxgU7OyamBCtiLNrijjz4ggivFpjfsgGL297ZAPgd2SPoSoQPRVR4OsWgi0aJUiqMA7NhZKXLSI/nHLh/5Y6spnVqc2Yec3yyTvxdXBIvzCLoN+7ehKMQOhsbO+WhBrBx4vapwjWI0f5tWxtXGMoifbczmC4/ot/lHHFMIzDTprNaJhcyBgFJdlh3uFlletEZXiOzPKVDH3PrpkedDh7TR5PVCe+zgqI4Oi59CZaNQhjowkC+q7gBwZR2G5kO9iNXOC3r8TPhcQq9ioD66tesD5x/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(86362001)(40460700003)(316002)(36756003)(6666004)(478600001)(2906002)(66574015)(2616005)(82310400005)(426003)(110136005)(47076005)(336012)(44832011)(70206006)(54906003)(83380400001)(81166007)(70586007)(186003)(4326008)(82740400003)(8676002)(40480700001)(26005)(356005)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 03:02:35.7472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e80d986-4537-4a95-89ed-08dafa92c841
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
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
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/dynamic.c | 197 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  24 ++++++
 2 files changed, 221 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index cd3821a6444f..4e211a1d039f 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -461,6 +461,71 @@ struct device_node *__of_node_dup(const struct device_node *np,
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
+	ocs = kmalloc(sizeof(*ocs), GFP_KERNEL);
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
+	}
+	of_node_put(np);
+}
+EXPORT_SYMBOL(of_destroy_node);
+
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
 	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
@@ -934,3 +999,135 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
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
diff --git a/include/linux/of.h b/include/linux/of.h
index 8b9f94386dc3..ebd276d4c4aa 100644
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
2.34.1

