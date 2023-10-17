Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731327CBC88
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjJQHoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjJQHoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B83F1;
        Tue, 17 Oct 2023 00:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoN/ZnJfE2CGa5S9CvA47+rIo7ZPk/pYmz0wDZzvsgfAaQOOwaGW8rweLY30bDa+DZaNzABSm0HyrSPwBHNqUw5JBNGWqtigeQ+qWJa2j2ozuY5Fj5QLXlvk3uisldb2nsV6o6rSkIhAPr+nt2HQ0CtRUdROXQ97bgP14UG8WCgOogq5sqFuBJCHTEWe3oCiAUKtNYMDoQJSAWbUjvL/LfN/jwlYohAANfMpuPJxB6ncQ/xlziOuQpGpR20OftiS2Nag2wXnlGH2cKl+ZiFyMExUJg+we0nwmp2Y7TgGXDVVDD2aPry+udV8wIJVk2uqjq1r6Hi5VCtrIMQGXyKhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHg6h6blho5eQEpN8tp3swpuvzBzcqSeBV65e/vt1rc=;
 b=lPbOZFFh2SqfFGUMjyzwnaeKpaGLqvN9dZZs/ur36u5a7zRXn53AslKAfalh1SaGqLrfTG5iaEJPb8IQ/33UG9jsUAmrdTcUTUFlWM1kkBMcljh8Bd9duTDj2HjFOmV1oW/DcSU6PsgFL2xO+XeyfpWlaZ5al0H8a1wCq7KOltm+Xsjq01VrVyE9YqAaEZb3WbQdPgybtJGDEgcqr3/QYqYJCWEesyglr/KYGae3deXq3qgcE+tq29tYolI94NFE3dELMKIMI1s5Jr5XK/cqp/5CcN7HhKa8DUn59Uqdg09NcOf2zyML9do7E9MWrb48tAOZPKzrT3i2jZHNfVh06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHg6h6blho5eQEpN8tp3swpuvzBzcqSeBV65e/vt1rc=;
 b=tfcGyWF5xUT77Ovf7AyqcDdTLYIirBCSFyiujekUA6MZdPzcwYwnKSRy+/G2j8QlgmfQjaFTNwZ4KCZLkS/NTB4H5RJxf54Rjx+wIgWuB8VS5YdGeuDh/RRTl73KUpK+QwaFmztEEiwmHtoMWt/IWmmK0xHlBFlLLFS3HvVkCrwdVOyIJq7iWKVd3czm6srzvd3cNmCecnXE1xCAp0qUouB2pfpyOsnObI+vSvAXc8/dLnYwqTPGhlKLZsD0TgogMGVmN/QCBBiqenKUq3lMlKvb73I1okf0d3WmOOJhqUSoPEm9NlkKpZ/1kpK+pY/QUCk/+6hgjlVnbw3PMdXtAw==
Received: from BL1PR13CA0152.namprd13.prod.outlook.com (2603:10b6:208:2bd::7)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:44:04 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::6a) by BL1PR13CA0152.outlook.office365.com
 (2603:10b6:208:2bd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 07:44:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:43:48 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:43:44 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 03/12] devlink: Acquire device lock during reload
Date:   Tue, 17 Oct 2023 10:42:48 +0300
Message-ID: <20231017074257.3389177-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017074257.3389177-1-idosch@nvidia.com>
References: <20231017074257.3389177-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: aadf613b-702d-4966-0979-08dbcee4d620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LKLCp3+TqqXMpTpI0w/V9eqcYbGZGrdgdAMoHzyhsaF2z/m+ek3LEf2YHoUgn+LMJP4GDdNmMQdXyP3kdFdR0rJHG3d1zHKmImM5jn4aWKWH1Cxro5vEmO19IjRG3dVpA97XEeYp3KWDDBA6kWb2VQw+MpPW/YJbI5CGq/jmRv85EqfvW91ArvFVUxQlUuri6ho/kRFh4X4yN6rL7HCXN6EbmpbXqQEeOijGuWKlCETlcaCUJkYycarkoNZvU22dmL8EhFVKnExn9OhXCFEFlwTW91snOYuvK6oLpru/rcCQCPbuxxcKBoDtreUA/dB75dGsOY6nLNtMllYIskgd5gxhM7aejDzFGr4msKzsSD7a78Pyn7CrkXaJeDL0oKO6HfswrsONR0uggrpNz9wUHhApPKPCLVJongal4VU2r3LRsBi9ZCaUytJECaH2yp+B4X9q9QOovJw/Fob2zD6TB8nr853g9bXIqo/JFJvT8G3QkwVgmrkEa49mDAE8dUjdLwKx+sqorcYn5OhXpY8yD/+KsDYQ8YlKdD3MkjPZ2os0ESINjuJnxTDE6j0UE9QZp08I1rInVHEFU3itFNf5FbWfuizOJSj5D1CFVZoLndPaLbbuiO/56xoGVmU14dMwek1zn0aaiLdO+r4YexJ7K6JhbZsWbzVMmG1E1CFEHEJCB8oomo0O96S1OsQh0eBCDVLVrG+3GofDz0BJJZypK64R/OEfRxZdVsH7h9md1OYvEaGpRB2kA1pKuON3xPx
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(478600001)(70206006)(110136005)(70586007)(54906003)(107886003)(1076003)(16526019)(426003)(41300700001)(26005)(336012)(316002)(2616005)(8676002)(8936002)(2906002)(5660300002)(4326008)(36756003)(86362001)(47076005)(7636003)(36860700001)(83380400001)(82740400003)(356005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:04.1315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aadf613b-702d-4966-0979-08dbcee4d620
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Device drivers register with devlink from their probe routines (under
the device lock) by acquiring the devlink instance lock and calling
devl_register().

Drivers that support a devlink reload usually implement the
reload_{down, up}() operations in a similar fashion to their remove and
probe routines, respectively.

However, while the remove and probe routines are invoked with the device
lock held, the reload operations are only invoked with the devlink
instance lock held. It is therefore impossible for drivers to acquire
the device lock from their reload operations, as this would result in
lock inversion.

The motivating use case for invoking the reload operations with the
device lock held is in mlxsw which needs to trigger a PCI reset as part
of the reload. The driver cannot call pci_reset_function() as this
function acquires the device lock. Instead, it needs to call
__pci_reset_function_locked which expects the device lock to be held.

To that end, adjust devlink to always acquire the device lock before the
devlink instance lock when performing a reload. Do that both when reload
is triggered explicitly by user space and when it is triggered as part
of netns dismantle.

Tested the following flows with netdevsim and mlxsw while lockdep is
enabled:

netdevsim:

 # echo "10 1" > /sys/bus/netdevsim/new_device
 # devlink dev reload netdevsim/netdevsim10
 # ip netns add bla
 # devlink dev reload netdevsim/netdevsim10 netns bla
 # ip netns del bla
 # echo 10 > /sys/bus/netdevsim/del_device

mlxsw:

 # devlink dev reload pci/0000:01:00.0
 # ip netns add bla
 # devlink dev reload pci/0000:01:00.0 netns bla
 # ip netns del bla
 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
 # echo 1 > /sys/bus/pci/rescan

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/devlink/core.c          |  4 ++--
 net/devlink/dev.c           |  8 ++++++++
 net/devlink/devl_internal.h | 19 ++++++++++++++++++-
 net/devlink/health.c        |  3 ++-
 net/devlink/netlink.c       | 21 ++++++++++++++-------
 net/devlink/region.c        |  3 ++-
 6 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 5b8b692b8c76..0f866f2cbaf6 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -502,14 +502,14 @@ static void __net_exit devlink_pernet_pre_exit(struct net *net)
 	 * all devlink instances from this namespace into init_net.
 	 */
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_lock(devlink);
+		devl_dev_lock(devlink, true);
 		err = 0;
 		if (devl_is_registered(devlink))
 			err = devlink_reload(devlink, &init_net,
 					     DEVLINK_RELOAD_ACTION_DRIVER_REINIT,
 					     DEVLINK_RELOAD_LIMIT_UNSPEC,
 					     &actions_performed, NULL);
-		devl_unlock(devlink);
+		devl_dev_unlock(devlink, true);
 		devlink_put(devlink);
 		if (err && err != -EOPNOTSUPP)
 			pr_warn("Failed to reload devlink instance into init_net\n");
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index dc8039ca2b38..70cebe716187 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/device.h>
 #include <net/genetlink.h>
 #include <net/sock.h>
 #include "devl_internal.h"
@@ -433,6 +434,13 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 	struct net *curr_net;
 	int err;
 
+	/* Make sure the reload operations are invoked with the device lock
+	 * held to allow drivers to trigger functionality that expects it
+	 * (e.g., PCI reset) and to close possible races between these
+	 * operations and probe/remove.
+	 */
+	device_lock_assert(devlink->dev);
+
 	memcpy(remote_reload_stats, devlink->stats.remote_reload_stats,
 	       sizeof(remote_reload_stats));
 
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 741d1bf1bec8..a9c5e52c40a7 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -3,6 +3,7 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/device.h>
 #include <linux/etherdevice.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
@@ -96,6 +97,20 @@ static inline bool devl_is_registered(struct devlink *devlink)
 	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 }
 
+static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
+{
+	if (dev_lock)
+		device_lock(devlink->dev);
+	devl_lock(devlink);
+}
+
+static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
+{
+	devl_unlock(devlink);
+	if (dev_lock)
+		device_unlock(devlink->dev);
+}
+
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
@@ -113,6 +128,7 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 /* Netlink */
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
+#define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
 
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
@@ -140,7 +156,8 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 				       int flags);
 
 struct devlink *
-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
+			    bool dev_lock);
 
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 51e6e81e31bb..3c4c049c3636 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1266,7 +1266,8 @@ devlink_health_reporter_get_from_cb_lock(struct netlink_callback *cb)
 	struct nlattr **attrs = info->attrs;
 	struct devlink *devlink;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs,
+					      false);
 	if (IS_ERR(devlink))
 		return NULL;
 
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 499304d9de49..14d598000d72 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -124,7 +124,8 @@ int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info)
 }
 
 struct devlink *
-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
+			    bool dev_lock)
 {
 	struct devlink *devlink;
 	unsigned long index;
@@ -138,12 +139,12 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_lock(devlink);
+		devl_dev_lock(devlink, dev_lock);
 		if (devl_is_registered(devlink) &&
 		    strcmp(devlink->dev->bus->name, busname) == 0 &&
 		    strcmp(dev_name(devlink->dev), devname) == 0)
 			return devlink;
-		devl_unlock(devlink);
+		devl_dev_unlock(devlink, dev_lock);
 		devlink_put(devlink);
 	}
 
@@ -155,9 +156,12 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 {
 	struct devlink_port *devlink_port;
 	struct devlink *devlink;
+	bool dev_lock;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs);
+	dev_lock = !!(flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK);
+	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
+					      dev_lock);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 
@@ -177,7 +181,7 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 	return 0;
 
 unlock:
-	devl_unlock(devlink);
+	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
 	return err;
 }
@@ -205,9 +209,11 @@ void devlink_nl_post_doit(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink;
+	bool dev_lock;
 
+	dev_lock = !!(ops->internal_flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK);
 	devlink = info->user_ptr[0];
-	devl_unlock(devlink);
+	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
 }
 
@@ -219,7 +225,7 @@ static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs, false);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 	err = dump_one(msg, devlink, cb, flags | NLM_F_DUMP_FILTERED);
@@ -420,6 +426,7 @@ static const struct genl_small_ops devlink_nl_small_ops[40] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_cmd_reload,
 		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEV_LOCK,
 	},
 	{
 		.cmd = DEVLINK_CMD_PARAM_SET,
diff --git a/net/devlink/region.c b/net/devlink/region.c
index d197cdb662db..30c6c49ec10b 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -883,7 +883,8 @@ int devlink_nl_cmd_region_read_dumpit(struct sk_buff *skb,
 
 	start_offset = state->start_offset;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs,
+					      false);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 
-- 
2.40.1

