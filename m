Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5035A5661
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 23:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiH2Vog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 17:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiH2Vo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 17:44:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5495F83BC7;
        Mon, 29 Aug 2022 14:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmLRbzSqalCgOZdKfs0+n/Y8+WqWQteCQsVAGAneVu+BC9rGrXFyzfLBfUs/agbLSjvxxczSWDREytIIjEN9zoehdjwufDZoS6FhkJkcGqOuXQhBF8fxH/YbriHJn8+fr75Q4CzHowZ8IssR7ewzAeAE4TkpbCziZr0LDK0YdckdWadIx52RKAI6qfDP0jLDq02j3fFGzC/JquqWrPW7obnvjfh1RHLnPIgPFRJt2NKgoXrRtlC75PeVP6P/NGfEGB+jghZebyeX6gX94152UTsBvcGAbOLcdsfZfxgr6QZp40zNOEPJeY9zfYOECzSjyfpNGUn95a07DCLpRr44GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQCtpbG0fKoeL2VKT4DHcGPh8dsbfkJ7hp7VzVicUEQ=;
 b=c/Wu0f/xDUAJHMdgJ5bNfm/yhR5qMYJTDlrcWDNQNUDRbx8lZzk8lFkFab3CSBspHCbh4IejozbNpGVnrlreSxhWQ05QyVWNviTlYgCH+GeUIavlto8hvYp624uhLfQhrZ1WX6rDDtsvBJCkw18smRjm5i0//ED4ILqeEJvz5X8XBxrElISidPu1Ju+5Mq4DVv6rrycuPWEJwwlTDDcyU9NA8mtds0oZY2+5mhDgq3jg4klVNOuHIY3wxRM566vS1Liv4ndEbfD5c7gdtOgc4zmbmkkaNCrMR8i4clM+XBcolUGYwAwT4IAU6s8POI98RmHYuIuZUem9oI5DJJKz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQCtpbG0fKoeL2VKT4DHcGPh8dsbfkJ7hp7VzVicUEQ=;
 b=P1pMThP32dv2oMdG/ZFxklpI1SxIDRt2NwsI7fRB4SFE8fQ+WWUhg2l2n14bwFajwbx7GLge6OiOXfKMc5D5cvYPLOf9ExQuJOP/x77C7Q5W9B2rEVOUFJYX7WFQQFg+wRKHwDvJ2DJRYCsaPPhIg79IdodqN1+TxT7GvNkc6Cs=
Received: from BN0PR04CA0185.namprd04.prod.outlook.com (2603:10b6:408:e9::10)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 21:44:24 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::f2) by BN0PR04CA0185.outlook.office365.com
 (2603:10b6:408:e9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 21:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:44:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:44:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:44:18 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 29 Aug 2022 16:44:17 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC 1/2] of: dynamic: add of_node_alloc()
Date:   Mon, 29 Aug 2022 14:43:36 -0700
Message-ID: <1661809417-11370-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4229fbf7-1ad7-4872-5971-08da8a07a3bb
X-MS-TrafficTypeDiagnostic: PH0PR12MB7079:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urLbklyPVacIma1NJ9W+4ir4iQOzeb5X/ySpRHL1bxdLm8O9wMiBReCvUBgmOnNpjonRS8qV/CdNMYCKo5DfHY6cScXVHtgAzgNre6vYQSbzqwhGRHolMLMpbKuXBeDXG0EUMhUlN+GKlpX+N7G5jKYNC+Om5RewBZrx5x3c2utZTQqDhnfp6R+WNifHpc6rqMgTv0f4SLe9NVFD3EfNqv5F7xEJ4YqpCvPiP5zql8Al3y0ouEq2zoW/uTkRn88GI3J39F3ptXByYATK+1LFsHMoZUm7u45cMuk4WoWkdERIIVyJSQd4kxMdFFRo5tlAikL2mDqWkbrB0q73JkX7cU7cMho0N747R7B9xZ7zs84F4sKf//sRJFlx5oQrz4E2Mm2+PohuEchSA+JK3yo2iUBnl0p+w3Q8wm9XeTt+3gZjipsVcxsdDY+UXtNgTjwhUL6dmQv0Q+VmNn3wR1lco7nW6UnPtuj+6RaMPqH/agpBlGG2KHPjeNecmezaABepSxHgnU5H1FO3A8YwN3okY4RUKIj5SFa4GC/QhDex7q4lyZX1rVBbnAMxsGiaPeuDSoCLH8RnIkN4mr3+7wSepEysvOxvNS0AoR/anK1uwVoDFKqd+FYhvELAq6IzyzZKajpEmQLtDayZNoGGV9QlxaECjcZqKOYWaS8sYdhS8uRpBknK9zkePEwTc+4P66MHhRPZ7Bfe0ZBUZSiMqNGU5EfbfoAlO/h+WdiNhooEnxDmbWQzTlj1l69sLvnHV5nwI0EleKuqdGjNdKNJzPN7aB2HuQPf4YfsRFEj1um3rXfi7kgqnYiZxK4nYO3hc2FT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(356005)(316002)(26005)(82310400005)(41300700001)(44832011)(82740400003)(6666004)(5660300002)(40460700003)(478600001)(86362001)(8936002)(4326008)(8676002)(2906002)(70586007)(36860700001)(40480700001)(70206006)(66574015)(47076005)(54906003)(110136005)(336012)(426003)(2616005)(186003)(83380400001)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:44:24.1933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4229fbf7-1ad7-4872-5971-08da8a07a3bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Clément Léger <clement.leger@bootlin.com>

Add of_node_alloc() which allows to create nodes. The node full_name
field is allocated as part of the node allocation and the kfree() for
this field is checked at release time to allow users using their own
allocated name.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/dynamic.c | 50 +++++++++++++++++++++++++++++++++++---------
 include/linux/of.h   |  7 +++++++
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index cd3821a6444f..0e08283fd4fd 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -362,10 +362,49 @@ void of_node_release(struct kobject *kobj)
 	fwnode_links_purge(of_fwnode_handle(node));
 
 	kfree(node->full_name);
+	if (node->full_name != (const char *)(node + 1))
+		kfree(node->full_name);
+
 	kfree(node->data);
 	kfree(node);
 }
 
+/**
+ * of_node_alloc - Allocate a node dynamically.
+ * @name:	Node name
+ *
+ * Create a node by dynamically allocating the memory of both the
+ * node structure and the node name & contents. The node's
+ * flags have the OF_DYNAMIC & OF_DETACHED bit set so that we can
+ * differentiate between dynamically allocated nodes and not.
+ *
+ * Return: The newly allocated node or NULL on out of memory error.
+ */
+struct device_node *of_node_alloc(const char *name)
+{
+	struct device_node *node;
+	int name_len = 0;
+
+	if (name)
+		name_len = strlen(name) + 1;
+
+	node = kzalloc(sizeof(*node) + name_len, GFP_KERNEL);
+	if (!node)
+		return NULL;
+
+	if (name) {
+		node->full_name = (const char *)(node + 1);
+		strcpy((char *)node->full_name, name);
+	}
+
+	of_node_set_flag(node, OF_DYNAMIC);
+	of_node_set_flag(node, OF_DETACHED);
+	of_node_init(node);
+
+	return node;
+}
+EXPORT_SYMBOL(of_node_alloc);
+
 /**
  * __of_prop_dup - Copy a property dynamically.
  * @prop:	Property to copy
@@ -426,18 +465,9 @@ struct device_node *__of_node_dup(const struct device_node *np,
 {
 	struct device_node *node;
 
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	node = of_node_alloc(full_name);
 	if (!node)
 		return NULL;
-	node->full_name = kstrdup(full_name, GFP_KERNEL);
-	if (!node->full_name) {
-		kfree(node);
-		return NULL;
-	}
-
-	of_node_set_flag(node, OF_DYNAMIC);
-	of_node_set_flag(node, OF_DETACHED);
-	of_node_init(node);
 
 	/* Iterate over and duplicate all properties */
 	if (np) {
diff --git a/include/linux/of.h b/include/linux/of.h
index 766d002bddb9..fc71e0355f05 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1462,6 +1462,8 @@ enum of_reconfig_change {
 };
 
 #ifdef CONFIG_OF_DYNAMIC
+struct device_node *of_node_alloc(const char *name);
+
 extern int of_reconfig_notifier_register(struct notifier_block *);
 extern int of_reconfig_notifier_unregister(struct notifier_block *);
 extern int of_reconfig_notify(unsigned long, struct of_reconfig_data *rd);
@@ -1506,6 +1508,11 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
 #else /* CONFIG_OF_DYNAMIC */
+static inline struct device_node *of_node_alloc(const char *name)
+{
+	return NULL;
+}
+
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
 	return -EINVAL;
-- 
2.27.0

