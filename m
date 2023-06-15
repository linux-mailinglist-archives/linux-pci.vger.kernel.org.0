Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1734D731E88
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 18:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjFOQxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbjFOQvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 12:51:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187062D7F;
        Thu, 15 Jun 2023 09:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQVxnOSFUKEqbQ6cRA+ns2IbEAs86PgKIPQQh/GcSOXPErI9lOf/VZScQW6neoMNXAlCNTLwdjRcSLM4TXjUma/gM4IG3b2otzqJBy65pvlqqkUt9J7PY9TPzr2Tj2l5pSL9VeqMyn7tpDoVvRv0jh2RdtPyngLoZ8D9Srcv17etkb5NTbZjBJtLdEUGE85Zldrx42UdMQsvG7Wb2MYei8jzXpDMPtbMJcWryRWsAgFylqcWt8Vst0U4acnFtEbSLhA8wu1qnca713FfmO5IqlBDgG510Qb44ZDZ34hde9P/0MactGYIraQqsfbLhyG1BqwtDJdnY4gY8rIq5k3Ixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MADuss227WzePRnbWXwwjohHHj2nTjBiOHJxq1H/10o=;
 b=byQsHvrnCvLTmndqrzk+upLJxX1TU2Stgqr6dr7cVhpem8CW9rFgTdjiOWLUIktuGsbGpjR8s2+lf/pGe/Z1YIWQn37CiFQIAxNQSIRgmHggLi1P9Eq1xjjfRi5x9KPsgNbsyS5da7JYRxp6bxOY3XfNd3hlF5ccH4J5TKEMlslyrT4CJKgYQFENgGOk4sVp7T/cqjlevdu2TRwerUn1OU/W3loo6RPv+xbs6bXQPpp6vXfLt7SwXN35MqdlGjzL2DzaHsJijKuD0TY78t5EwjsBqE7vD3fwP4dnfpeoiph/gPCzDzYLA4tPCnqdgF1PHATTH7mOx/qSpRZ4ejB0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MADuss227WzePRnbWXwwjohHHj2nTjBiOHJxq1H/10o=;
 b=xk0c2kk7SQ2zxbgxV8lWrRYd/t1FbNVgucuP+WTzowOrB0dj2wWYzxebhESgnxoDtrv2ZTvwDv1ixUSVhFdR2o/KXz4ZWa+BIviNkBQ05XcOpaUJbQrUAL4IEFboPp0HPpG3tnYi2pJaFdV9Dw474lZwoU8dXCjpxmNv4oaNjmo=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 16:51:23 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::ec) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 16:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:51:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:51:17 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 11:51:16 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 5/6] of: overlay: Extend of_overlay_fdt_apply() to specify the target node
Date:   Thu, 15 Jun 2023 09:50:41 -0700
Message-ID: <1686847842-33780-6-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b1aed9-5c1c-4ecd-e9af-08db6dc0bff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIw8qZCC1jZHuSne8CluEy02R2tDI6j2OzHIHaXfUDhRV0Nld2ZDzdBbnFQsppmLpZ83UgCQ+BTOf8qPPYb8+Q9OyRdZt4xj2GMgm0i7sNsOxEZhd1+hUcafmiAOqhQGmc4D4hStETEjuSfniOmpk28nQzyp1ImfH2umiasfacjH9mUxVOmhJ737ewqJC/6BG6vYRW1awCAv1js5tKlgExF0ZJyCsC9nOsQagkEebL5Zs+/g0XgoJT/Ju41YfaSgYdPlFRqEhRIy8V1FLA3BbBb1z7+nDBRtPNwBDtwAMqy53A02Iq91+QoXdFt1pYmK9/yWZ3cdbuG2I59n7gu1TT2iq1QS1pj7IEnlQtCljMJ8XL0nfYbEwtsNpOGMCNwiTwCgmxPHBLLFTeMM+3tBBC+rrNpY9Lqga4w0hmRKyb53WBzyw/HRYspHSa9E68fxlClYiREIFM8s8XFIvi6kWPxG0zIYkHAwripH0rSPOtgVJJR4Cyr86DLEI/qTaXFWHcYrlaROhENqPvHt/dVd08k3CSJuUcWYwAvvUEek58mKGJ2dLnjUxFpxv5NOgXk2745kl/HlPObg7iwSdIKSE18+pibSToIG+nWrzW6u1WeKHRjFMmFkBJmFs4QPH4t3AvqS4VTA+ByqCpLftimGdos6Pq0ZKF4WMLtMh3lZMWJ1CuClX4UjHc6dCncSZ8rKrtCFbvhabD14CTFCSfoCTzzop/rV5pgbjylZ9t6ZGxoGo93S5bONSnfemdlhDTh7yvww6g3/iO+HBp1wz3PDkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(54906003)(110136005)(82310400005)(8676002)(41300700001)(86362001)(8936002)(70206006)(316002)(6666004)(36756003)(4326008)(70586007)(40460700003)(478600001)(36860700001)(26005)(47076005)(44832011)(40480700001)(82740400003)(5660300002)(83380400001)(186003)(2906002)(426003)(81166007)(356005)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:51:22.3792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b1aed9-5c1c-4ecd-e9af-08db6dc0bff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 1193a574fa36..4a0774954b93 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3506,7 +3506,8 @@ static int __init overlay_data_apply(const char *overlay_name, int *ovcs_id)
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

