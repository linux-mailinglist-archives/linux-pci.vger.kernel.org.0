Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E452E629
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 09:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbiETHXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 03:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346348AbiETHXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 03:23:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9213514ACB9;
        Fri, 20 May 2022 00:23:02 -0700 (PDT)
Received: from kwepemi100016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L4J800KcXzhYR4;
        Fri, 20 May 2022 15:22:08 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100016.china.huawei.com (7.221.188.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 15:23:00 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 15:22:58 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <lorenzo.pieralisi@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <akpm@linux-foundation.org>, <logang@deltatee.com>,
        <martin.oliveira@eideticom.com>, <thunder.leizhen@huawei.com>,
        <axboe@kernel.dk>, <kch@nvidia.com>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <mcgrof@kernel.org>,
        <jiangguoqing@kylinos.cn>, <jpittman@redhat.com>,
        <dave@stgolabs.net>, <liupeng256@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
        <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 2/2] null_blk: fix wrong use of nr_online_nodes
Date:   Fri, 20 May 2022 07:37:47 +0000
Message-ID: <20220520073747.1184091-3-liupeng256@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520073747.1184091-1-liupeng256@huawei.com>
References: <20220520073747.1184091-1-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain systems are designed to have sparse/discontiguous nodes,
a valid node may be greater than nr_online_nodes. So, the use of
"nid >= nr_online_nodes" to judge if a node is online is wrong.

Node id is a basic parameter of the system, a user-configured node
must be checked as early as possible. Otherwise, it may cause panic
when calling some vulnerable functions such as node_online which
will cause panic if a very big node is received.

Check g_home_node once users config it, and use node_available to
make node-checking compatible with sparse/discontiguous nodes.

Fixes: 7ff684a683d7 ("null_blk: prevent crash from bad home_node value")
Signed-off-by: Peng Liu <liupeng256@huawei.com>
Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/block/null_blk/main.c | 45 ++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c441a4972064..312903f3a09e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -97,7 +97,33 @@ module_param_named(poll_queues, g_poll_queues, int, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of IOPOLL submission queues");
 
 static int g_home_node = NUMA_NO_NODE;
-module_param_named(home_node, g_home_node, int, 0444);
+
+static int null_param_store_val(const char *str, int *val, int min, int max)
+{
+	int ret, new_val;
+
+	ret = kstrtoint(str, 10, &new_val);
+	if (ret)
+		return -EINVAL;
+
+	if (new_val < min || new_val > max)
+		return -EINVAL;
+
+	*val = new_val;
+	return 0;
+}
+
+static int null_set_home_node(const char *str, const struct kernel_param *kp)
+{
+	return null_param_store_val(str, &g_home_node, 0, MAX_NUMNODES - 1);
+}
+
+static const struct kernel_param_ops null_home_node_param_ops = {
+	.set	= null_set_home_node,
+	.get	= param_get_int,
+};
+
+device_param_cb(home_node, &null_home_node_param_ops, &g_home_node, 0444);
 MODULE_PARM_DESC(home_node, "Home node for the device");
 
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
@@ -120,21 +146,6 @@ MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<inter
 
 static int g_queue_mode = NULL_Q_MQ;
 
-static int null_param_store_val(const char *str, int *val, int min, int max)
-{
-	int ret, new_val;
-
-	ret = kstrtoint(str, 10, &new_val);
-	if (ret)
-		return -EINVAL;
-
-	if (new_val < min || new_val > max)
-		return -EINVAL;
-
-	*val = new_val;
-	return 0;
-}
-
 static int null_set_queue_mode(const char *str, const struct kernel_param *kp)
 {
 	return null_param_store_val(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
@@ -2107,7 +2118,7 @@ static int __init null_init(void)
 		g_max_sectors = BLK_DEF_MAX_SECTORS;
 	}
 
-	if (g_home_node != NUMA_NO_NODE && g_home_node >= nr_online_nodes) {
+	if (!node_available(g_home_node)) {
 		pr_err("invalid home_node value\n");
 		g_home_node = NUMA_NO_NODE;
 	}
-- 
2.25.1

