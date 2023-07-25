Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF347625C8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGYWPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 18:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGYWPi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 18:15:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4E193;
        Tue, 25 Jul 2023 15:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh3FkML533aAaN8KYK3ZCQt51hRAfiHNADfN88FXcH3PlmgN8Jp4qbTgITLTFRxlQgX621D+pW2FyEyjbn+dzxMkw1WcwTzovYniM7F6FnaP05taKxp+8K0yV3KdA2i12SHgIF+a+Ty1zHIYp4nMEFgUcxCP3a1xpaAiqgZSFancPa6dUX5BmFP+VL7HBtI/JdCFJ9b5DV9ZGxOustao7WGK9+nNlBPBiok1ZHjdR5PELn5zMWumZFWm03CKwfY/cFj5TJZH71oG4wtNe+L2hLi+8NWbY/f4twPsu9nOcwm8Iy4842KOPguk3U1f+Loa24vSzLXBZKaV9gq2N4ktAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBJs1W1gsz26MzBL1ZYcPD7bjCpk2QNv3lOk5FogfDE=;
 b=bO+fDiUu4lgZ8QIyLmIU8Udn30xUIkcGhmt+mpO5ttaeeSXVD6xi9RW244fEnXdrZxBxrgVKJ4F4Ck0ZyHlZr521Xs4EvqzBN6XUtXfic2gTABHpFEb40s5sw4DCAEJ1sg/Fr2vAmUScpRJiACS05FaWZ9j1qmv9e3TuKK+hwuQDpXM05QgF+lXZnUkCFwIkWKysmohOHOvm1U1G1DxngATKsrl1gh4QLlsD9dqDP/JrMJbmTwBHEg8nb4R8A7omRPbuN6j5CtZh75+SgBajKu6YlYxsxq9ZbjzSLFz/wNUxYmlSjJX7GIo4ALRxPJI3QuVjJYbK0Inlfmrss5mNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBJs1W1gsz26MzBL1ZYcPD7bjCpk2QNv3lOk5FogfDE=;
 b=LG72aZRKYeE6L3WG6ue9hbWXOF+jHLGUDlj6pj2oOJ3ANatoXJSo8/Pfet7nNrBIuSJmJFK1MxogvF+cfBbLCQeEt2VSenBowWrZvH1lDFBuPpo26wET7wa1/AOBjL1cMGd9RMOx3Qi1cl1mL8keTGUTeCOPcg5sP+jx8d9MZhU=
Received: from SJ0PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:33f::7)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 22:15:34 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::42) by SJ0PR05CA0032.outlook.office365.com
 (2603:10b6:a03:33f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Tue, 25 Jul 2023 22:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 22:15:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 17:15:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 15:15:33 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 25 Jul 2023 17:15:32 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V11 4/5] of: overlay: Extend of_overlay_fdt_apply() to specify the target node
Date:   Tue, 25 Jul 2023 15:15:17 -0700
Message-ID: <1690323318-6103-5-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690323318-6103-1-git-send-email-lizhi.hou@amd.com>
References: <1690323318-6103-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ec293e-0cdd-4f67-e39b-08db8d5caa99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krmX0fOn1V0pdPl5t7QzTgIkxBbInr+KkhDje3/DBZuPjH+kVau6DmVtfu8Je3YJ2Tdpwc7c5NzS+eoXHfMpYOUNgaY98z1mRjiBmnJLxnIHNaak1TPvBbA9vdnGCnxqdrptx/MGdlr5oC39K1pEmfFslygMTVBZqsgqAoYHITY5wqKQ0H5HWdcUjZGrJjzKwyUnnhXWLGsPKv4vj8Tm3pkZUy2xCt41MdY5gohCq68SGVXbY7tzSCZHEbZIqzBxgE+9j6DKROJlVWLAg4hFqhBSeXrEILBW6YCnxjQ4i4nU1Nflbp4BPQ4LCMniFkyvMlQm7c3l5y95SPbQLPxCBeDoFNPDDXWcSZeFmlX9EnS0G5bEWDt977jhPxcwwCWI6fO21eM4+M816CAd+UnXPvS/zioW/5nLHbd7YKoc9zX9tMA3zRoMi/M17V3QlOKFkN9d2Vw975l1a4T54kPuIylVmmJElP7qihwmvfRql5mOg9yl1Aubz0TEH4HD5ajP3zzs4dvTOPLco6lEw91o5X+YMuTwsuStpkiP6ScJ4OxD2OvIMBB8Ud/vGSdonP1Tdyh/Plc7PJe8oHP2S0jvZ3wJRsKisMZZosLmA2Z1LmEKT+720VU6dG9YCFpe21UI24gQ3r8U533adITax17FM7e0HojJTrSgyApTU2hdqTVPe7PkQqc1bW8u7hAB0TM9YBOqHHAbY5GxzhxyyeHFQNA7iQK35cXzcXos/XBP698vAq3iagps0/ypfVReS6BAWeg2dKh/dHmtPeiotj6r3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(26005)(186003)(2616005)(336012)(426003)(36860700001)(47076005)(83380400001)(70206006)(70586007)(316002)(4326008)(44832011)(41300700001)(5660300002)(8676002)(6666004)(8936002)(54906003)(2906002)(110136005)(478600001)(40480700001)(356005)(81166007)(36756003)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 22:15:34.0995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ec293e-0cdd-4f67-e39b-08db8d5caa99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

