Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1B662F9E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjAIS5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 13:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjAIS5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 13:57:11 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AAB1DF2E;
        Mon,  9 Jan 2023 10:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaJy0Cn7G3xDRmfypffKGnZflYtWD0RR1j1vFwldRvO/G6vSOsbZNazWMak4uCAvnyn+lqvRCLxXXJeIuRtIOJqhLDczZES5tTebOtAu8cdTJ2vjL0/JuNwoSAfwpeEDaMgfq981Fq6/6r7oqAhlOr2R5q9NwCE2SKDmnSMWWZ/svmlPl9Jk4fkfA+1jFu2Vcpt2wr5b5PkaJV/4hPZx1rZ4MSPZplglZh+dac5oL5K9AYaDjfsTXvhDmio+8anBcmwpM6YFIzAwOOTmW+qjiAAr2TCaZtT+CISiUWSd5rolsfZcLLuhfssmg70PffjoqVI70oD8nN2oG7VTxBGoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Tbs6kNBZ8lwTpMS6fW9CyD2xJ8Xv1Z2w4cVRhIEdkc=;
 b=dTn42yj1cIbRcN1OkPLJMx8FJyT1xBFET5jMvsCj+lGFv3ZQ8UMieIYefcb6S10f4QTLA+LrB3LngcrP/250fvpQcTNdaq+pSPxzeFG5Hbs82OKfXkF3u/JBhyjkb/ikcZQsa1o42EmeZDi3FE4oUMVdnrBZZWAw5MjOLwjhLCl2PCkhRQD1JIGItdxpDSrMpCuqudbE0mHezmvP64aK7bBtITN98q/BIObl5TV5F+V50tH4H7EUz/FaDgKJp/7e/m4Isunb1ySuxaS3P5Op0qsK9u3ku+VpqJXXcQ02cjmtoyolUx5ajKOqgy5AdMgYqicQZBS3gWIITrPE7eQR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tbs6kNBZ8lwTpMS6fW9CyD2xJ8Xv1Z2w4cVRhIEdkc=;
 b=biEcVbsmk1FbSZ4XNrF4ArgleEDVby6Tn9ygkxLUHyGLhuT+geX3wMZl+JycREiiE6atiTNVxusG53T8EG/LVQ1nl7tHvwVJFPaMntpNuml489lqV8wfoRXBmJjJLWEj99wBzoDYVrVykV81RyuJgE11wqmUV9pgJBHy/9iS0cc=
Received: from BN9PR03CA0554.namprd03.prod.outlook.com (2603:10b6:408:138::19)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 18:57:07 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::e7) by BN9PR03CA0554.outlook.office365.com
 (2603:10b6:408:138::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Mon, 9 Jan 2023 18:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 18:57:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 12:57:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 12:57:06 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 9 Jan 2023 12:57:05 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V6 1/3] of: dynamic: Add interfaces for creating device node dynamically
Date:   Mon, 9 Jan 2023 10:56:59 -0800
Message-ID: <1673290621-22888-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673290621-22888-1-git-send-email-lizhi.hou@amd.com>
References: <1673290621-22888-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 1136abb2-1e2b-485c-f806-08daf2734e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZfLfGahN6hBd2bGGWZuDIgX1Rn0RuWmoeEqqYZZaIyn351qoQYWYZPa5gLYz3LbyBiMbs4Kefclz3SHLda/3CqqPyPzJCTf6idaSuK3EuGCtf3TJEUJK+/F+6DjpqwabZ/hX4BdKcs2KS6w1ls2r9tXNreABnlovGEScqDC5J6OlH6xF45chL21SnJ8qakDyhkTwQ4izM15npXjz2rYCFRfA7/BfhQb+8Yyl6cyhea5EYT6w0nTKaE+8hauaFSBNHlj/AL2zB4bmHx+/sqOsFGTOEbf9NIFrXUhnswmwYkeEF56zjN9nCM2NvtBynyOQHdqim6B9lpoXXpa0XfOkwylxgD84ka0PzJaJoEubmt6FEjvjVzO+k2MJMg25ZlI50l2qQXg/zoKF0EybtQSKZsBbBUi872Ciy7OAFFuX60PRxjcXgc0wBx3x9hMlVvjO+7SVCt6KjoJdhPWwFjlxB8o2SaHFA1F5BcO7kzmr5FxAOkwZoSM0uhjGIhsFozefWX42Gt/3B+/E+6gbSYuGFm2HYKBjRh4Bt5Bim+Nwgq1cRCXS9/7IunsvZYRWqr7RWj6PZ8LqelaUVuyQGwwx9sOeHcw1qTjJoKvq2oLAGOThjAqsvlP/nU4DSymqbEd9IDbpZ6iV6AEpWjnKd0rQ5j6nawQSTmzSvhzRn3jiS3b8Tuh8ACS/WpgktbjIM1Uv+if+l0j0OyROGxkxv2Vht3ByumjL2VgVl2dgzPfB8k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(26005)(186003)(86362001)(40480700001)(4326008)(8676002)(336012)(83380400001)(426003)(47076005)(8936002)(70206006)(70586007)(5660300002)(2616005)(36756003)(40460700003)(81166007)(2906002)(478600001)(316002)(54906003)(110136005)(356005)(41300700001)(82310400005)(36860700001)(44832011)(82740400003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 18:57:07.5295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1136abb2-1e2b-485c-f806-08daf2734e55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904
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

