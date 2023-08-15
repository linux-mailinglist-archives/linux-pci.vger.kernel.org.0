Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E021B77D0D4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 19:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbjHORUk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbjHORU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 13:20:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F73E2115;
        Tue, 15 Aug 2023 10:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWwVXuvLV3ptk9j4TqHKc365vXUd4EKySLnhjD0tlxIyAMTFWscme5PGWU+GYmPEwU217MyxAfcBXPRmn1m1H9fs0Clj8QhqKUU4C63KilpaDmYsq0RVhsvPK9Q/GCqpNWKXzvXi6BAhqLl5bSJdWDjZa4U+pOt3BGxrjzBSuU68BVE1BKbK5zoX79yi0Xbt16gv5CH10vz11o0CAG3RYYIwAMteORj2GMBicgeO4Vj0t0xLvFkpv763LcQjNEm9cqT7sc1WfD7zLswWk7ZPhvPcBEPdN/NjiIB2GAesRY8eqYpC/+FjZhLHQJm/1pRGxg7Izfh2Pmc6ZA6mzZKMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBJs1W1gsz26MzBL1ZYcPD7bjCpk2QNv3lOk5FogfDE=;
 b=PDvcq3TloTzLSk+suGc0q3i8QJtv6dQitp2H98PY5IFh2QDbTtPcKn50gkQfBvfh+JK9PsxqCKiahaa/i6ec6pA09zYYhQ2yBOeLG3YbxFdjNU8quWYaYcWU1J/na/Ch5J+1d50jLNK+W3rX3DkatbBYAZ3alGqhkHnNs+Cl7dlO6FE85jxMiLCuIZM8SqXvRGwrnqTfvFE7DYDYCWMTRub4PaIz9tg2+d+dyU6JArlPFDLEf34g/y4k0DKIMZpdZaniB7dEWV7cVXMjY2lTFN4mGoitnXYCVQv1Iy3O3aUEbXP9Mq25/bR9IwkHvJXMZ3GkUFdoJ2sSwcUnwke6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBJs1W1gsz26MzBL1ZYcPD7bjCpk2QNv3lOk5FogfDE=;
 b=IYsx8vrWemjUpsDaYOUW5utU4sRIXnqmSgPex408heAK7Iijr+2t5x9z6Y5KLEqow8oAbRh9P0OWQilaeeOYoAKVb5spxmu66T/k16Cpjt4fJpwXw+iN1nj1yHsV0/E0gSplpk5nVlzsc4oH6zMsqtgq+rMpQyM/quPzRdlIo+I=
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 17:20:14 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::fb) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 17:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 17:20:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 12:20:12 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 15 Aug 2023 12:20:11 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V13 4/5] of: overlay: Extend of_overlay_fdt_apply() to specify the target node
Date:   Tue, 15 Aug 2023 10:19:59 -0700
Message-ID: <1692120000-46900-5-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a86a9b-2fec-4a05-91ed-08db9db3e340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcgHEZhTEnqqsOLCvFghq12RMSZmDsUf2aCgLItl4pdMsRuNOodHU+X+MA1/vt2r2a0F5N0wmn7xYWaIJ2lihx8CjEF918ImKpVpnAACpAaGHHV176FnKFK3m8ojSaJ+Mus3JixVn/6RFRDf+KlJvXEu20r0ho3JegKNXy0abtIi0PgbjLspYE0wN8TeT2NeGh6dWpzXxuk3MiLkl2JFRp3VRwFyvakKeaPjulR1Ms+JR3uTFs28IMuond9RTZEuvfYkEJzNyeUjR1npLeOI2j62KNNos94NUqcbREIgdeF7yY11enTEE+rJ98jJ8pTYSdmw7C0FxWrLpqEfO5OTT08oXczS4fRPkwBEdmIqv0pV6hW2aFB+ScLxtqOUxuWtjj6YbaL2shpDVZy8VDF8nFCnL4WHDpkTP8tGdkhrRAJjHgJsmgkjb04k1BS6wL8ROPeEY1/uD9Wm0HbQqxEW4x5ldbsGzGHacCkjy8bUrRpPPXnwKOqJ3VGY01tHDQxVJGsrRgjoJGzd0KYLeZq2uUT9FVIzSBywuV7bgH86GgOYYm1jlCd3qqSomT8897cHc1qU504ScA0nnzq299GeoX+EcEN7slMC6zEsAKwTSGw/AC5z2M15yyG1zc4Vl+RiuS6a896GzuX9qcTjT2Rae1B/4BimlKmVIuOICkNB2jp/eHaV5iYJ7eksvCiJ31ANVqfZwkhYYFD30Wbhq0WYzNjavPtZly0KMwOoLZUFsZKRrI+zvzBDW5zUiWpkqrlc61DgL0u5eEn5o5GxYEjPAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(6666004)(478600001)(44832011)(2616005)(2906002)(8936002)(36756003)(4326008)(70586007)(86362001)(36860700001)(110136005)(47076005)(40460700003)(40480700001)(82740400003)(81166007)(356005)(5660300002)(26005)(54906003)(426003)(336012)(316002)(70206006)(8676002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 17:20:13.8861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a86a9b-2fec-4a05-91ed-08db9db3e340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, in an overlay fdt fragment, it needs to specify the exact
location in base DT. In another word, when the fdt fragment is generated,
the base DT location for the fragment is already known.

There is new use case that the base DT location is unknown when fdt
fragment is generated. For example, the add-on device provide a fdt
overlay with its firmware to describe its downstream devices. Because it
is add-on device which can be plugged to different systems, its firmware
will not be able to know the overlay location in base DT. Instead, the
device driver will load the overlay fdt and apply it to base DT at runtime.
In this case, of_overlay_fdt_apply() needs to be extended to specify
the target node for device driver to apply overlay fdt.
    int overlay_fdt_apply(..., struct device_node *base);

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/of/overlay.c  | 42 +++++++++++++++++++++++++++++++-----------
 drivers/of/unittest.c |  3 ++-
 include/linux/of.h    |  2 +-
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7feb643f1370..6f3ae30c878d 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -682,9 +682,11 @@ static int build_changeset(struct overlay_changeset *ovcs)
  * 1) "target" property containing the phandle of the target
  * 2) "target-path" property containing the path of the target
  */
-static struct device_node *find_target(struct device_node *info_node)
+static struct device_node *find_target(struct device_node *info_node,
+				       struct device_node *target_base)
 {
 	struct device_node *node;
+	char *target_path;
 	const char *path;
 	u32 val;
 	int ret;
@@ -700,10 +702,23 @@ static struct device_node *find_target(struct device_node *info_node)
 
 	ret = of_property_read_string(info_node, "target-path", &path);
 	if (!ret) {
-		node =  of_find_node_by_path(path);
-		if (!node)
-			pr_err("find target, node: %pOF, path '%s' not found\n",
-			       info_node, path);
+		if (target_base) {
+			target_path = kasprintf(GFP_KERNEL, "%pOF%s", target_base, path);
+			if (!target_path)
+				return NULL;
+			node = of_find_node_by_path(target_path);
+			if (!node) {
+				pr_err("find target, node: %pOF, path '%s' not found\n",
+				       info_node, target_path);
+			}
+			kfree(target_path);
+		} else {
+			node =  of_find_node_by_path(path);
+			if (!node) {
+				pr_err("find target, node: %pOF, path '%s' not found\n",
+				       info_node, path);
+			}
+		}
 		return node;
 	}
 
@@ -715,6 +730,7 @@ static struct device_node *find_target(struct device_node *info_node)
 /**
  * init_overlay_changeset() - initialize overlay changeset from overlay tree
  * @ovcs:		Overlay changeset to build
+ * @target_base:	Point to the target node to apply overlay
  *
  * Initialize @ovcs.  Populate @ovcs->fragments with node information from
  * the top level of @overlay_root.  The relevant top level nodes are the
@@ -725,7 +741,8 @@ static struct device_node *find_target(struct device_node *info_node)
  * detected in @overlay_root.  On error return, the caller of
  * init_overlay_changeset() must call free_overlay_changeset().
  */
-static int init_overlay_changeset(struct overlay_changeset *ovcs)
+static int init_overlay_changeset(struct overlay_changeset *ovcs,
+				  struct device_node *target_base)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
@@ -786,7 +803,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs)
 
 		fragment = &fragments[cnt];
 		fragment->overlay = overlay_node;
-		fragment->target = find_target(node);
+		fragment->target = find_target(node, target_base);
 		if (!fragment->target) {
 			of_node_put(fragment->overlay);
 			ret = -EINVAL;
@@ -877,6 +894,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  *
  * of_overlay_apply() - Create and apply an overlay changeset
  * @ovcs:	overlay changeset
+ * @base:	point to the target node to apply overlay
  *
  * Creates and applies an overlay changeset.
  *
@@ -900,7 +918,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * the caller of of_overlay_apply() must call free_overlay_changeset().
  */
 
-static int of_overlay_apply(struct overlay_changeset *ovcs)
+static int of_overlay_apply(struct overlay_changeset *ovcs,
+			    struct device_node *base)
 {
 	int ret = 0, ret_revert, ret_tmp;
 
@@ -908,7 +927,7 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
 	if (ret)
 		goto out;
 
-	ret = init_overlay_changeset(ovcs);
+	ret = init_overlay_changeset(ovcs, base);
 	if (ret)
 		goto out;
 
@@ -952,6 +971,7 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
  * @overlay_fdt:	pointer to overlay FDT
  * @overlay_fdt_size:	number of bytes in @overlay_fdt
  * @ret_ovcs_id:	pointer for returning created changeset id
+ * @base:		pointer for the target node to apply overlay
  *
  * Creates and applies an overlay changeset.
  *
@@ -967,7 +987,7 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
  */
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ret_ovcs_id)
+			 int *ret_ovcs_id, struct device_node *base)
 {
 	void *new_fdt;
 	void *new_fdt_align;
@@ -1037,7 +1057,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	}
 	ovcs->overlay_mem = overlay_mem;
 
-	ret = of_overlay_apply(ovcs);
+	ret = of_overlay_apply(ovcs, base);
 	/*
 	 * If of_overlay_apply() error, calling free_overlay_changeset() may
 	 * result in a memory leak if the apply partly succeeded, so do NOT
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index d2b286d32db0..7bff6c4cb653 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3478,7 +3478,8 @@ static int __init overlay_data_apply(const char *overlay_name, int *ovcs_id)
 	if (!size)
 		pr_err("no overlay data for %s\n", overlay_name);
 
-	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &info->ovcs_id);
+	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &info->ovcs_id,
+				   NULL);
 	if (ovcs_id)
 		*ovcs_id = info->ovcs_id;
 	if (ret < 0)
diff --git a/include/linux/of.h b/include/linux/of.h
index 82d0a476ec75..5fe5257a7ab7 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1668,7 +1668,7 @@ struct of_overlay_notify_data {
 #ifdef CONFIG_OF_OVERLAY
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id);
+			 int *ovcs_id, struct device_node *target_base);
 int of_overlay_remove(int *ovcs_id);
 int of_overlay_remove_all(void);
 
-- 
2.34.1

