Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE257CBC84
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjJQHoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQHn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:43:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0959B8F;
        Tue, 17 Oct 2023 00:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODYxErI3Cb/ZADnq9QJjXWtU0pTgJq5MVOPRKGAO9cwlgWkIQrN6gaBhG6I7z8GhcGCjNLevB/oC8ktVIfszPM7aKvvxOUJ1IE81pwZpatNthQYgVzBtTukkSiIDaBSazYlgIJwtY5/4uRT9AA7w7DagZ6ypblzCp6FfloJDJ+RzIZOQY+16g2dEQ6krTrIuNUtXlSzAaGV65lTvI0R2tbgn3QCyOj/IF4CWHeQQbXdYSj2fm2CI6Q2aDwtBnVBqBNqJiHsOk+XqdtAgRH1lsceCT821TNTCGk8ZCfuQuqt7hJdSWCXJh/uCkICBl9TwDj74KJ2rqVzCZvKmk7XksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+UdztoCxdDVBnRnQBFgbG5vg+ieKEhrNnRjwC41O3Y=;
 b=fOV4skR6e1iDOKfndWd5VoUdstJ0zVeARaJbO9GKjTBeGUP0QLARwOaDqYKYxRRB/DYPXmnSs5473ZtWpvb4k2z+MfQS3c7glQsXkZtlHtrZPk+MbPXuiGUGeumcQlDJMJj+RkTwF2C0DuLKGTGPW3m0tBOXxg/H/M83A7J4L49NiUmrwWMHIScOMdCLIpHR/h8J9FX9PLlvT6CxtzwoV+BxBi9o9H+vFc39pnhvmrBvm6Po2GseCTSn1wOXWAJKq1RVtLPccFkwoU0lIlVLzNySLqzGGJtkhC7JSkB8ObswLEECNjr2rdTwX51X2PwxnBb4HNAniLZWAhGx0mpvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+UdztoCxdDVBnRnQBFgbG5vg+ieKEhrNnRjwC41O3Y=;
 b=SBpiMCfOMQgjXKedeeJA0O/hGiIwYfu9dQfl436LB99aqpm4dJYkpIUAq02TxcmI80TinEvj2wBBcQ2AnA93vnz/x+jdaDiXsdht0wFNq7VYVMaH0EP8KdGCcSIKFkgVOVO0ztm5Q8AN/tmZgaqBNKtRnVrNiZb1S3v/Kwj+O7S7Oph00BKScV2WYCFlQWCAAsFOECWN7DaWE6XbADoiKOvpbKi/cfMGgNrNQQUo3p46su+QMWRM3jglehzzZuP1dhsLPUZfkvl8fUsOTBIwfFcT6ww0UKT7eKGwimDane5hY9WDp6qvB6QS3XvA+5ele2Wu41XZv0U6JOI6bQjkQg==
Received: from BL1PR13CA0142.namprd13.prod.outlook.com (2603:10b6:208:2bb::27)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:43:56 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::60) by BL1PR13CA0142.outlook.office365.com
 (2603:10b6:208:2bb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 07:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:43:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:43:40 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:43:37 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 01/12] netdevsim: Block until all devices are released
Date:   Tue, 17 Oct 2023 10:42:46 +0300
Message-ID: <20231017074257.3389177-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef68985-ec7f-41a9-bea1-08dbcee4d0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsGUp/medVjjw7SRL3fLbHlx2zms0NNX0vQU2RzOaCVt6hmel0ki/u2QrCW8HPnGjWEV0cEqCR93Nw0ZjCkHjRzrLMuxXDUEJShK5VJYthiKlyLy/UtDpcmQDrzqH13rk6fuEbbACy8JY7SRC1w4tarwBtzH9uO6nk+onESRJZxt8PVfKd9SL+h+fxyB9DLy8194V7gxEn085Y96YGXMjyjj/Up1Y6cAq37hCxmetJM/mOYJ+ARUSW7mJiuWvAE86UKIsTFSa5Xp4+qsdydaKekZSCmOBvfHNRHnvlpLk0yjBjZc2ThMpTQseuFc++u+s67d5B0E3PvDZoLAEZl1WTfuqrwmiacnUQJOvSTl7AkfxDYMFgK5BoTtHZO24t09cTSXYPYjQOuv8ixa3pwR9Sr1F7KXyP/cJo1yE7cY0WsK68bwkz4u951bAnUhs5xVOjjewej52RNJxg/kFN3WkMuFdGuRegPRrlPiX94G4f7jzrdx0mVyf2jKhV82ZJQjwSYILuo4AgUKeeL8pHyMpyvHayXvQyKzfxD3fAI5r9e02B7EZ9VbD+slRdCcZABcuI5ZGbq/gVEW1r9Nz7fezzeutRIbPtBu7Ov5FgHENXx03305KHB74t3WoSAQDS4gBBIYtL8hU+iCOkeLcXIlUS0OqdSBViehI+SzNIUCYyosTiJwbdUH6Ona7NKoEIwd3RuFwP7n2jqUoEorES6SUbH5Cw3kiDxrKbrNRMUltQq0dHkRIARoN1chVJ87PPpKcpScQUHf5efv68lCXQekVwyTtklbpQSRR+6H8Mzc8oY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(2616005)(40460700003)(40480700001)(966005)(36860700001)(82740400003)(7636003)(356005)(47076005)(83380400001)(6666004)(16526019)(26005)(36756003)(70586007)(70206006)(54906003)(478600001)(1076003)(107886003)(426003)(110136005)(336012)(316002)(86362001)(4326008)(41300700001)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:43:55.5181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef68985-ec7f-41a9-bea1-08dbcee4d0fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Like other buses, devices on the netdevsim bus have a release callback
that is invoked when the reference count of the device drops to zero.
However, unlike other buses such as PCI, the release callback is not
necessarily built into the kernel, as netdevsim can be built as a
module.

This above is problematic as nothing prevents the module from being
unloaded before the release callback has been invoked, which can happen
asynchronously. One such example is going to be added in subsequent
patches where devlink will call put_device() from an RCU callback.

The issue is not theoretical and the reproducer in [1] can reliably
crash the kernel. The conclusion of this discussion was that the issue
should be solved in netdevsim, which is what this patch is trying to do.

Add a reference count that is increased when a device is added to the
bus and decreased when a device is released. Signal a completion when
the reference count drops to zero and wait for the completion when
unloading the module so that the module will not be unloaded before all
the devices were released. The reference count is initialized to one so
that completion is only signaled when unloading the module.

With this patch, the reproducer in [1] no longer crashes the kernel.

[1] https://lore.kernel.org/netdev/20230619125015.1541143-2-idosch@nvidia.com/

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/netdevsim/bus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 0787ad252dd9..bcbc1e19edde 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -3,11 +3,13 @@
  * Copyright (C) 2019 Mellanox Technologies. All rights reserved
  */
 
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -17,6 +19,8 @@ static DEFINE_IDA(nsim_bus_dev_ids);
 static LIST_HEAD(nsim_bus_dev_list);
 static DEFINE_MUTEX(nsim_bus_dev_list_lock);
 static bool nsim_bus_enable;
+static refcount_t nsim_bus_devs; /* Including the bus itself. */
+static DECLARE_COMPLETION(nsim_bus_devs_released);
 
 static struct nsim_bus_dev *to_nsim_bus_dev(struct device *dev)
 {
@@ -121,6 +125,8 @@ static void nsim_bus_dev_release(struct device *dev)
 
 	nsim_bus_dev = container_of(dev, struct nsim_bus_dev, dev);
 	kfree(nsim_bus_dev);
+	if (refcount_dec_and_test(&nsim_bus_devs))
+		complete(&nsim_bus_devs_released);
 }
 
 static struct device_type nsim_bus_dev_type = {
@@ -170,6 +176,7 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		goto err;
 	}
 
+	refcount_inc(&nsim_bus_devs);
 	/* Allow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, true);
 
@@ -326,6 +333,7 @@ int nsim_bus_init(void)
 	err = driver_register(&nsim_driver);
 	if (err)
 		goto err_bus_unregister;
+	refcount_set(&nsim_bus_devs, 1);
 	/* Allow using resources */
 	smp_store_release(&nsim_bus_enable, true);
 	return 0;
@@ -341,6 +349,8 @@ void nsim_bus_exit(void)
 
 	/* Disallow using resources */
 	smp_store_release(&nsim_bus_enable, false);
+	if (refcount_dec_and_test(&nsim_bus_devs))
+		complete(&nsim_bus_devs_released);
 
 	mutex_lock(&nsim_bus_dev_list_lock);
 	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
@@ -349,6 +359,8 @@ void nsim_bus_exit(void)
 	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
 
+	wait_for_completion(&nsim_bus_devs_released);
+
 	driver_unregister(&nsim_driver);
 	bus_unregister(&nsim_bus);
 }
-- 
2.40.1

