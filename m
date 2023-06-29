Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B48742B42
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjF2Rbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:31:36 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:53963
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231634AbjF2Rbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2023 13:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhlwkRqxOgLSJPY07AzKfy9LpvhOgS4esEs8calgcniRTQ6U+8jH9LQ1g85bX/NUBOw+WJC8Bv0R45l0X3IqD3KZTnWGLQgkckZXnALAVIyJ2Nr2hecn6YkvxaqYaCm40WnbM0LHicb5ZGrxj1vEuVlT8KmwNneG9WCvF+9kyYUUcIqs4CFmqoqch1RyQEmugubNJydoVs2WDUhMYHnqvnNkhaAm0fILxRRDWHXNn4PYgTeBI2CMNt8BpsRa2sz7cVIX35C0+r3aynk0MnvsmJKeKn+zaVLSatAimxWE9bW+Us4QJpTmtsNV/kghs/LkV1W4rJNV4jlFHvlvJRy+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkO4axAxsQcsEdDXAFikKnXxzjh1KpezGHQRB3mLF7s=;
 b=L40zSDCoUf6LmE3/zrHCCeKeO0ixPqtfWSxGxQlLQegfvva1YryzVk5mEFroImc0n3jXhE3BZ+ZoUHy6l0JVD259fzTNimd2rLTi8sR+MJYW0vwjGV01Ml7ymjk2ajgh9WFx0vAvFKy7Tu30dpSSN8rvNqQc3WAdobShnF87PYH7+3LXrFVvTButLAs9qAbOWG58WpqPiOtfq2RgFeGRufBZSdqys7faai/QT+zhh9PATbFHNU/zpiJd1rDxGnmQyCw7FdzOuf+McdS6g+UXNbrZ0R4oVS2CqtcAXlclUFul9O9IGFn9cTUp2UV+O5Ai+TdCD2DwhIOCf9fs/6DFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkO4axAxsQcsEdDXAFikKnXxzjh1KpezGHQRB3mLF7s=;
 b=ZvqO82d1qrHvRWVs3dROzEaJQsxaeL6NVxMnv4lToNJsROpjkhOUgwRh6hd914wGmT5lefsqRbNOENTEWKcSnlwjl7N15GgtjO4sZZVDoxNdSX7fpl199g8PEa00dgJybE7rJ5mhV6WehNi/GMMblFSIMiCMyJfhkX8hY/mlxpo=
Received: from BN6PR17CA0050.namprd17.prod.outlook.com (2603:10b6:405:75::39)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Thu, 29 Jun
 2023 17:31:32 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::14) by BN6PR17CA0050.outlook.office365.com
 (2603:10b6:405:75::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 17:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 17:31:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:32 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:31:31 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V10 4/5] of: overlay: Extend of_overlay_fdt_apply() to specify the target node
Date:   Thu, 29 Jun 2023 10:19:49 -0700
Message-ID: <1688059190-4225-5-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
References: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 3671aa4f-4c64-40d0-f5d9-08db78c6ae5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtgPQMcURl0YV1ycqfPw5SOWMR4mVkRP/14Hhy81tSE63xnxwqieDNPnUcCDiObnhMbEoS7HNe57TOFxdjTCT7Ifc73nyVXptvbj98pLlicO9Ti3Ix0T8HKd/R9/ZKmCShA1PpNbx7E8hlL6ihrsOK/Vx3qc3HnKzfWgAQ0H5uxerxd2NX8+fBSHuw2Biq8Ahtgkp5Y489B5xznuFK5k889l9UCliQgW8CrhDSpTXNPjKThTcwjr1j0G/n+E6BBkf42YNuMgDGI4JNCBdUlirfrpCbhMLVhiGC2KFmb9ifVY+93uuWKMdpYIqR+Ku1ibgjccTVfJEAHroY7PhByusX13f8LffXSNzdwFxcYJmU2Uu6AqJ1chARZu7DnX0NGZ/ERpeTc20SuQ6dmLEqT3RPerj+h3JhezM0U2tFqALePHCk07JwLnjlPOfkvDCjdgJOSUC/Vob1gLVMp0Qm98FcFmTSG01Lb0z3Zg188gHRIpVWJRz/BLC6XtBFNVwNF9NX4dsWeQgdCwcrr228wkG9g8MohY/rbSe2EYHZx6MwhTVUX4XWesyIpA4yJ5T7qQ9zn1OLdkV3aLfE3i6xEsgfYAm5HswQcoPrtE3o/usLQ2Hz2cUU2KmeMwcBkwwFgiZcN8GCqTsrFrkA9gTRdnUQae/w1R2mA2TULNbGgkpQ7bLzR5YdQ9jdyo+ZWe5A3L6QeAsTCT3Tl7gLsf/l+gsDotest6+UNpNCk2xUAfYxk2em8QxPUfbrjCpXCyPeW6ITh5J/ilPv1VEtZkmMJ68A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(82310400005)(356005)(6666004)(82740400003)(2616005)(81166007)(83380400001)(26005)(186003)(336012)(426003)(47076005)(36860700001)(40480700001)(41300700001)(110136005)(86362001)(54906003)(316002)(2906002)(36756003)(70206006)(70586007)(4326008)(44832011)(5660300002)(8936002)(478600001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:31:32.6839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3671aa4f-4c64-40d0-f5d9-08db78c6ae5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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
index 703152181a44..c989a5400da4 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1671,7 +1671,7 @@ struct of_overlay_notify_data {
 #ifdef CONFIG_OF_OVERLAY
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id);
+			 int *ovcs_id, struct device_node *target_base);
 int of_overlay_remove(int *ovcs_id);
 int of_overlay_remove_all(void);
 
-- 
2.34.1

