Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB8862390A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 02:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiKJBmn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 20:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiKJBmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 20:42:42 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF5D27CDE;
        Wed,  9 Nov 2022 17:42:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrstkAiJSuD//tMw6BkBzHtZ4yLAidrUUqw4Bn21GF82ke9jWOnDzH5Pzt6+4ov3dOoC5uYbs6IIRaJuZKUqV9Ria4K5CIypm4LpEBp+kjZSHqJNlSUWpqSO9mMHVnmcZgI3ERbATVNKPteqHcCOZnSYAjkWRzMS4re4K2qOD3zMbe46Z/FeTG9y/sPEPOtiBSo4SwwqYgC2nOhWbGrW5o+7hhULghI82+LBiaqRXNev2HQX3CAxoFaPTKeFkpKBbN1U2M2Q5CyaHYJ7SmcBTw4MKqCPwTkOCfVIp1ZUKzgRBVrHVXJXKBpIpbM3iUxJb8plXy8g7fw5nVtrDm/YHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2axPqeESC/l8aE6D21gNNvD9QRikcwKhy3ptffKIg4=;
 b=iQ6edqSUfr8ChDALfq8VaLTmRwrnxtFbSogNCmo9knUth6KV0WrQiTOHzb0qTSfoy+qh7C69f+gK14IHa6TsC5DIW8/rzGidii+05mAQTI1v5LA8QfOJ4RZ2i4af72ElSKa8mUSJ0FhsUHC2w8W0lSrH+wcluiJbs8mzi/7Osa6XfVMB6E0X769WzrKNEW+hm49NU9Vq9SByQgh81kIAj0Z838/oqJm+vDzxoArY3mnUWnGN7/++DqduOdgS+1rKIwsDhWf6tNtz3ON+KHu34rfsqrlTOh4KnENcj3rfMUmsqAB3Z+hn6gattCrfU/tedFXAswTExqVlB20FOYBQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2axPqeESC/l8aE6D21gNNvD9QRikcwKhy3ptffKIg4=;
 b=gUyUuq2gaVslPE07uOwi2Vdll3/54kbYixmTOk2k5+g0ZteZo7gIgylv3amjoQRwFjRPZF5uWD2vksAqB/uQyUzR7qdv9+8WuZ4+s3VTYdxFTNHuxVW/qskbe97XkbisM/959n6QjX00RXm3S/KOtBRMcZJsLkemE9Y5fzfQbhw=
Received: from MW4PR04CA0212.namprd04.prod.outlook.com (2603:10b6:303:87::7)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 01:42:34 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::b3) by MW4PR04CA0212.outlook.office365.com
 (2603:10b6:303:87::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Thu, 10 Nov 2022 01:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 01:42:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 19:42:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 19:42:27 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 19:42:26 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V4 1/3] of: dynamic: Add interfaces for creating device node dynamically
Date:   Wed, 9 Nov 2022 17:42:16 -0800
Message-ID: <1668044538-27334-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668044538-27334-1-git-send-email-lizhi.hou@amd.com>
References: <1668044538-27334-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: f842c082-2ab6-4cb5-b397-08dac2bcd6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ng4IrEILMNvyVpuZbGvl72eyLOKBx5+6oVSPhGIo2UUa4lya9yqvRP0rC7++cbajnDVzAFG4sYFfhqAEaz9aOubseHX+8Y17mOVYGnefxKh4ihS7V/fxEPgXfVO2uWOhxLJbBLWhAdwTLjp+XCrkOt1dD/4PhK6uAVpMW/3nQCXfm13xLy3Ig/T83u2co2TU+eLIuloHJ6Ek1niSIhsatP2Ie91itxYQM3MrQbVIZmnyQdJ7ixJ7c4bZckh/b8b76vA4dj8bnIrpJeWoswKXR90ZLP9xnvlEpF52HjGA4VuD2KZ4R7H5KBiqqSRrNZUqHVcc+b6aLyxyMR3y3nDw0t6FWeXsEV29CWvqK8HScBuhlM22V/p3oOejU1Yd8NC59llgad1Ze4ccVJamSIThP2JYxqtGKwuPrB3Rl/p2Hm+f8snkcxunP1l712KoTSqF2FdPhzw1LgVswGVSGFi2TSLwCqKOSZ5BKNJLZpCdQp8G5HtAKRT94nC3VQroYtnQOZQMhyGF+lAP2X+fI6YUEPTwcXu4TVQyw55o8T6Am3oxkC95aFJH2fgvdQm9DwwWS6dHpmMqhufARlkQazAQiQo3+XrQGGEGp8cACh+pbKk026WZLXyVT0gVTa6g8q9pPTkif9SRSq/qKmPIk9EwR9cT1/rEQcTr6/65H6WYg5s6PhFzyDEJIOeEBUf7JYhgcZHrLwHVxrdnxSDbLgRJGzqybC1zNlVTfHXO/aprdq7x2esxCXfoSWLsfzyq1pWM33EnIrdzUSSmTxfUxuFeTD3KJu8Sjh/BSYGr9b0O5b+0QpdzSuczU00iHPcqsPnl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(336012)(26005)(6666004)(356005)(36860700001)(186003)(426003)(110136005)(2906002)(83380400001)(2616005)(40460700003)(40480700001)(5660300002)(44832011)(82310400005)(478600001)(8676002)(8936002)(316002)(41300700001)(4326008)(54906003)(70586007)(70206006)(81166007)(36756003)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 01:42:33.6616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f842c082-2ab6-4cb5-b397-08dac2bcd6b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

