Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14E264DFA3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 18:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiLORbB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 12:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiLORa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 12:30:57 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1154C26574;
        Thu, 15 Dec 2022 09:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDpnHkvFAxDSo0O/h2YDGa40DrEBzaCehECtf+SDd0EwrZoSwUQaFYZ+2Ck4p8Bju2UvLH5ARSGIxe1ePMegB0uivpwvavCxbSa8nP+YVS+4oHFqv/qP3Ilw1obOgKWEeOvP/P3a9qqq2C0RZmPZlr+JD+Cwfr2y76OthhzYGx5vSU9u5Att0vH5BWNsAI5xRb5VkCvHPhXl8OS4qlSgsjRjyjAJY+LO/blrvApRb923UTS1LLLAu+uyc3Fxzxm/f07yuJQ3Loi2ZeoUUadLw0gCVMcFQr4HNLb51kdpIE5W8e8cnHrYpalCwnW0X5WKDKNuoSvWRP4R1IS69mbKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FHs1RkMPqhdQDUgL2TxIAKlxvNwycGWFN1h3CQRhwM=;
 b=VDvT+68VWyjDiBS99W2mUaMGVVOpGDdql6WT2s3yBQ2NoQnoAoJuwskCC5+xx4NIKCYyEfwhmx1Aw9OrTpRoojryZU633mEtjS2fiB41M7p0i1AfPJGAqW7crDMDFEQJ2Z5vCrbKORnzc5ISYR1t11g/qOAapwamp+MICPMMwBIzL+b9F5+HAb7aDZHxhJyD9vR6fkXUMaI5Fvx/wl3/tlw6QMoQb8JqnhoipxIX8bQTgfcjRnaR9fMXKvkOBdRco06Ku/LBYKq+e7LNGthR1i70vxkgbIiiOoKmgDHAuoG8xZuHY8FjSF96qhFfqWmK9Unnhb4Ch4GHrIxpvbacAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FHs1RkMPqhdQDUgL2TxIAKlxvNwycGWFN1h3CQRhwM=;
 b=RK5xRmSA6RTRH8GEqlnbrXfJkyWB3kBKO9xgHdOZeWaDmZSKPa6Bziej2AIVMjFUDHFiXVTRZFrBQY7X+tt+J9U1FRAaBuqfhUWJzsZN9S6MDpA4oRFeJSbgW5cKePyLcWSRTOKmCiqCI4c42zxiUiQ7khJrtU32qHAW7M+OYcM=
Received: from MW4PR04CA0182.namprd04.prod.outlook.com (2603:10b6:303:86::7)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 17:30:51 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::cb) by MW4PR04CA0182.outlook.office365.com
 (2603:10b6:303:86::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 17:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.12 via Frontend Transport; Thu, 15 Dec 2022 17:30:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 11:30:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 09:30:50 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 15 Dec 2022 11:30:49 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V5 1/3] of: dynamic: Add interfaces for creating device node dynamically
Date:   Thu, 15 Dec 2022 09:30:44 -0800
Message-ID: <1671125446-57584-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d9e171-94d7-4399-ed49-08dadec21cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8l/1yCsb+UUFV6xG/5d4oAbcorioVCDiRhTsRW9NJiGqsmNZjxU09Rj5myazPQz84SlP0uoxVoMePNJlTJq6YM94t+AIZgFg2cY2hwVqz2B0+jKoRHi7uCaYmGXJ8A2n6ipqiMbnWRZu9AfL6TCL7sn7mcZB2eVJ7zjMrgiHejVDJGnXGoSEgxRHhXNM4szRmenU4psoV/Uw39ejHiguhtFZLJ/y4maSiz26FMZRD0UanJXK0jRfnq2V1vEE4Rlpp0EQRifu13smWBPk3J8jrRqpzRuS0xnpAV5O0ea1Ibi2NcykrgGtmsrVzFZHuTjASRHrHnZIKjhIEgMMLdmp1a5HKPnxAV4fMQzElcWn2onYTJ+OTVaipBHyP6Rm5845a6KeXwjqdeSbU2KGLjsWrbhW/8+AG7TnViYMxpNvqD1woNIOTWC3Oo639dBR60JRi3OqYS/9HXdJs5+5KVJM96wpS87w6jEr+SjJ6cHQiJnHd4hE9kRnCyNxpetwohSjYNSJf4SD572zBRDQ79nprHH0UurzFT8kIyWRiD2wxJRWgr4UCdQlE1va4CqnRiUq6gcLhrZ+bep2or9fhpJ4qj0Qa0L4gCqBvBzHPBBxhFkYrKrpEWmysbjV7X5+ei+xmXkg9dnY7RlMsHZ78aH9r9cwBf655y9BtsIXPz5vyFPEJqlW5XrV3tedX0wbMhe6TzpgGrZbGtVpoZ1MGHSgJFcB0PYFfrL/VohEiXH3etY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(36756003)(4326008)(8676002)(70206006)(54906003)(70586007)(316002)(2616005)(82740400003)(81166007)(426003)(47076005)(83380400001)(2906002)(36860700001)(40460700003)(336012)(82310400005)(186003)(26005)(110136005)(478600001)(6666004)(356005)(40480700001)(41300700001)(5660300002)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:30:51.2040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d9e171-94d7-4399-ed49-08dadec21cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
 drivers/of/dynamic.c | 197 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  24 ++++++
 2 files changed, 221 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index cd3821a6444f..067d996a9f79 100644
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

