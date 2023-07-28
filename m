Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E47672DF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjG1RHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjG1RHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 13:07:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6326635A8;
        Fri, 28 Jul 2023 10:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwsRE2thnRynzXCIfuAbQwvBCujMLskfOYgJccvSyvcEKbSomrfQJyHVLBx9iz0/b1ABiuFHKyqGqVcgLlstTORZjqYE+HaLae4oRR+Z/LcIKBYl2H+BXMEULP86rbFilxtwJPZg4Ui+bdFg/d4jq766ZHa32n/TWyikOlKXckW/VJyd1z8EJlE68dMW9bt4cUPin9fpJ6ZlG2XNDIH0e29+ymQQHTIGeo3GAhUCzYSOto4TcsYNTU2AIF5b11ABB+NW61ZhibB16hB7bCMzAVv/J/bs31QronCVF2zSUMyyehkWVHyZ9E5HCqXPF3BxAZKRUl91dUlyre8qAFh7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBJs1W1gsz26MzBL1ZYcPD7bjCpk2QNv3lOk5FogfDE=;
 b=Th8YZYwhqJDF4SmaftDyLVVVhIdD0+27W3ZX0QnGrT2jfi0zYsOpEtDczxFtggG+k8W15M2l7hOVO8HinmLjBtFSsqNLmVwqBrti5Bpo1Ppr6Gin5LobTEom/AYW8kwUg78SOH2Gnqa2HvejuOVmDJvA+88PrKha8qZgEu3nN85wf8ighoFsUtg956D619M4AfJN9L6HZwS/o9ehLYqQmAsiXs59Ahp3ejKhQb9QqTEFMh8OxEuQ80MAJgIRsa9pgQVua/IGw89NK2v7Zd/1oYA/b5qNEaZnvyv+Nzdqsh813NEsUKtD/Ehcr2i9f1qUxPFARA5hnmyTV7Lx75MMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBJs1W1gsz26MzBL1ZYcPD7bjCpk2QNv3lOk5FogfDE=;
 b=htm2EfPPPwnIPAirnny/134iXkrFShVE6asZQ8xUyIXCCxny+4qiWZsqj15j3LqjVrKX0Qdkm5Ksjdp0nHB369GBroMOBzS/GbK/e2L+2xwjYl9rOtoZlynRlC9SOI5T40/094SKW2ac26PoOytaNln+UDJrECE1jcstCa0PI6Q=
Received: from DM6PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:100::37)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:07:05 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::f5) by DM6PR03CA0060.outlook.office365.com
 (2603:10b6:5:100::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 17:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 17:07:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:04 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 28 Jul 2023 12:07:03 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V12 4/5] of: overlay: Extend of_overlay_fdt_apply() to specify the target node
Date:   Fri, 28 Jul 2023 10:06:57 -0700
Message-ID: <1690564018-11142-5-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
References: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|BN9PR12MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: d2436211-d3d2-4a08-53ae-08db8f8d1197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8t8DXCHGUoIgzGm/jhfenhwnDPngUBz8KovGPZDcwX7DF+Fpf022Hkl0L6lLZYF/Jc2XifKC6YPMtGI9i4eXi+472RSSg1y7EABjOyzp8hU2y72wefn4qrS8RMij6eQcE9uMgIjAPY8PZw1dViC4N5FsTJvp9SVoHaela72c4f5uyX616uD15H4WcG/fLo2DIZ+GEvCKBx7u6bg2F56kGR7lzM+loLfaxTPsYJNTCEM36wHQAd95WhKl28ccCipaqFkdB4pJHHSKUNtd7+mWPBOMijbc2KeK0kEw7kQwS2dcWHOxogkj9dexfWEVrd3Zjt3GMzt277zd1sMJujEgcCVL/iwe6JTvUC+xOQfSM1VWyI1h88ZFCoxhdfXj3jN8Qp5fRnqsF7IElUelYZj/H27B8eVqjjk6B6hUYWxTcq9c/JiMfAy7TzX4dSfMx84q8Vz7Hj0gtO2prup9yYhLHure9Cfsx8tfB/UpQR1OJolcF48UEakLS0THklEBHFIIZ4guG5HG/Vznn7LOFOf3j3ZNjAFIYBgYRRYAL79QW5GH4CKceNp0hK9MO/1gADoMeuIXq6hYjskzHDXK+gz70CqcaLQTnljsJmUuN4HTcmLMA5L4ZYCOBpKo8X3GmB23RmLQ0wD2ndkfBPljtmDtjdNv/wVFyf70o+A/6TG6DMKCnPdhnK7nhVC95xHI6u9a4oEyubE9VX766aOChCEXklAngpMsubn2VCFnCCpvZUUiBMiAyrEgdEcIVvOOTcVFeGB5MSDQSLDipP+3ec4ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(356005)(36756003)(40460700003)(2906002)(40480700001)(110136005)(54906003)(478600001)(82740400003)(81166007)(336012)(36860700001)(426003)(26005)(186003)(2616005)(47076005)(41300700001)(44832011)(8676002)(316002)(6666004)(70206006)(70586007)(5660300002)(4326008)(83380400001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:07:05.0254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2436211-d3d2-4a08-53ae-08db8f8d1197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

