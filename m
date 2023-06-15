Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891E7731E70
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFOQwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFOQvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 12:51:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C8A7;
        Thu, 15 Jun 2023 09:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtIG5a73ozr8qIV/GqqfBggi27NjfqE0pgp0vGqgTefGvlrdxkRw6fpli6DroMLH0TVslQAGvg/u/sMDhSlRNVXAbUXcKiAgbKwkEwkFblO90dRHm97JY0E62z+L+vkZS55g3MSi2w+1/gDj6lGSm+IxHepcKDJv3S06Pl5+2ermUlCIp/LxrXdL2vSda9RVeiwRBxlD8mvMv+KYbk67DpUhytdj2gJCiESG/uI8WA1VWRH42g5yG+ZEl72yzHM0U+fClf+2qpQAM2onRsrxANN1njC2yGRwfiaOZ4CW2ym4UGuL+UPM3iRJ02L4fZJvpv/5ZeW/Kpn8wynweqU8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCeQOJjkj5YimJPVzX6eRl9p/6j1ICZvwuY+Ma4V4P0=;
 b=fmefLh1mPbtPzw0v2g7MnIVxyp9zn/M7RiB3cDsPmpT9A4A25KmKlH82fc/sFy4PtCIFYQCfSjfX8u8V6VBtfYk6wRMwmP1XXnTeasIZ5EoN1LQrraIkDNJZlKOmf9stDdq3HfB0AhRRHPAvxQGP5BiooR6zyQMcLRthM6H78IJjZOqirFaRz4x1t5fnWzxE7xAuEiZ6qqqKAklh/Z/e4c4afgnJA9btSWejAep/u61Rat7ZhPZAj7W3G48GXSTO+9sJDIxKKcvn9l2MJ5zGtC1NsWUGtU1AI3NPu+XroPIwPmVbj3wVYjGvH7ZflOjddvaufTA8Lb7Q9QbaiMoBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCeQOJjkj5YimJPVzX6eRl9p/6j1ICZvwuY+Ma4V4P0=;
 b=MGfjs8N0vDInZyl8HXTjH8cSZaiyvbyFr+ufK38deJ7gEyrM5QBnA8hZAxKoDvnWzZ5WeAcwFeuGEX8fWkfMuaSPFszX44/G3ACFu3FCDzNKJOpofo1Z23MFYNocuv8/gno9g+Q4UYxRBMQxrTlKXCPtvJc40QmeRB1JWWmWNJ4=
Received: from SJ0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:a03:39f::27)
 by CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 15 Jun
 2023 16:51:15 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f1) by SJ0PR03CA0232.outlook.office365.com
 (2603:10b6:a03:39f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 16:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:51:14 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:51:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Jun
 2023 09:51:13 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 11:51:13 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH V9 1/6] of: dynamic: Add interfaces for creating device node dynamically
Date:   Thu, 15 Jun 2023 09:50:37 -0700
Message-ID: <1686847842-33780-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9d334d-e15a-4637-4637-08db6dc0bb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oY80HXwA2TR2erkJ8gFC8UQ4ldrsNHHcFiMvgrxHDaLKxLB8ME9HF5ir8Mzz0l/cJ9/2lEGBer3m5XtI4m3ny8zXM1MeEXFujjka+4q8rvb/KkB0BD6I51IbIjtNK34dQ1i3xEJoIvJroWh/LGWpjua5NGfMZeEKkVKcuthLkNpxtsrDpjy+O5yKSNXiEHTZ/yXNmDFpfCWAYPxhX6FCAqYsPB7GlhRiO2KYRSiTl13gesspM/JPwcNZmGu7rtLYwXZ/DdYLAak088J1ljdFWjF2/DQzKumGUpz4LQXCJsomSEUUG3Xjow59Zuin5Y/cZkHjlyVyKqMvi+Alo7sPGrasT+OXrQID98JQdmMk+KpjO1QcJkfRw6zYUlaqvKB0/XxWrfZupXDTuuea6ztwopjMH+SZoXuL5j/WEV02ODg0u8R66JHwA6k6yNPD0C61c7+Jw0rBU6AW7dY2oBziTquOqQ4uqQchf8BvTvjhrTnyQoARox0MBdYFUlKTWy8eiTrFtrO9xGiWNEszu5wk9l9eSgd2pm00ZFJzCYKgrJYg9wm3VEOKnQerbXXIY6IqOeOsld5rqMglWFuBCY/+sojLImjJc3j85DEEbQKmMT3M2NfUnsixmHFlR3iNtM6HjFjiUGrmShyYzRywRrDfN2HqyH+eCdl7IqR0UUrMtYkUcAxZQrQLj8goYxh7+4M7FpZP5eSzKe4zinVfv5C6Vdm0F6tPP/jfcsoruZkegwDSvh2JLnKBTms/82VYfhTj1RZqZwGmTgRRD/TJAQqNnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(110136005)(2616005)(6666004)(54906003)(26005)(478600001)(86362001)(186003)(316002)(4326008)(82740400003)(336012)(83380400001)(426003)(47076005)(66574015)(70206006)(81166007)(70586007)(36860700001)(356005)(5660300002)(8936002)(8676002)(44832011)(2906002)(40460700003)(41300700001)(40480700001)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:51:14.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9d334d-e15a-4637-4637-08db6dc0bb7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_changeset_create_node() creates device node dynamically and attaches
the newly created node to a changeset.

Expand of_changeset APIs to handle specific types of properties.
    of_changeset_add_prop_string()
    of_changeset_add_prop_string_array()
    of_changeset_add_prop_u32_array()

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/of/dynamic.c  | 164 ++++++++++++++++++++++++++++++++++++++++++
 drivers/of/unittest.c |  19 ++++-
 include/linux/of.h    |  23 ++++++
 3 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index e311d406b170..9259cebda4d6 100644
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
@@ -960,3 +992,135 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
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
index 6ecde0515677..82d0a476ec75 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1580,6 +1580,29 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 {
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
+
+struct device_node *of_changeset_create_node(struct device_node *parent,
+					     const char *full_name,
+					     struct of_changeset *cset);
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

