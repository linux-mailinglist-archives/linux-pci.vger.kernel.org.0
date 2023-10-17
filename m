Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765EF7CBC85
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjJQHoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjJQHoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4225395;
        Tue, 17 Oct 2023 00:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFKjmwrewh9jL9rTJpnFEPJV9qCuhV3XOarTRWEBjX6DRUqwVIPUlsuQTzv1aQEvrSRwUBE+LqMhaNCT+cFlQCuN1rW0WMgR1AEGOaCf7p3hpaH5TZ81evp8NIXs7Ipyh7c2hF1kOPtHJp+83MIDvWAhIfq8j42h6jvrPDnqA35TzzNrrrwRbNkNjnT2eoPsBpEruu/6pq8UiVc0skCrVSmjPXd0x4lcDQI0g+iAX3PO7n+J09cNTafMxn7Tjq2QEvpGhheY3twF7Ia8LWkbc4fClYtxgyxI/1lVBydFj5bYIiBLUW6O5+YDuPOrOxkqTl+Jhk3/YXFOI4Hw2BEDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm2TIS8vlCdsD1nFe6vuUEyYctb55iQFP4PEjqu58pU=;
 b=UAnjU9sQIHpD+8FImNHEz4JVr47tSiWnEN5lbuEHK3NkilYg90MxPKfXDOiQFYQeEdnroYmqUG74tViZT854c50RZN8jIR/6cJjqwo1C8maO6W6mVAg6WZdUQ1FEjRs2YOEPemm58Jn8sfpuio3QqLp2DrltAoBf4EO0DHoQWWbfPnU/5K3u3Tx9U/ojFbD1IjGl7dKjD7axTRkux6AvQ3hoeZMvE6cQNn6DrVEdGx1CMffu0MCfQkIjB0oaskxocfW6bC/ZqalUO95HpX8v8xm27Zdy4VvhwG3kIdE6b1xf4t68Tk7V2Umh/fxFZ0APQljAqSP2zCCqfFeLzi8dLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm2TIS8vlCdsD1nFe6vuUEyYctb55iQFP4PEjqu58pU=;
 b=hfG7grrKmKUYrKHfNYn7vdob08mI8ixo2SyoOLi05UfpjgE2D+AedJNDcXqiZqR3a4/8DPwx6MT31o6NBSrEi9cpWRtWufc2+ohFjiaMwrHi8/NZq9GCVRmPmCDmjtxwX7VUg4sPpBdlarW7URFoIShqNBG/W0BIpORCrIrbPdaQCyv0JYOMxm9L+LXbz+G5blHAbopMMVmrnbfzRgvxUYgWU/svJ3E21vRuUme6pHnwtb5g7z7tRPeHGXHPYpVyBGCblEIIl/mD1Gl4/AIYUSU6DCeDxg3czodkrIYB0gtrPP1kJIFoe9BKsMJjGz+EhzYL9t0dbeoWZKbQAPP0cQ==
Received: from BLAPR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:36e::7)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:43:59 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::db) by BLAPR05CA0007.outlook.office365.com
 (2603:10b6:208:36e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.17 via Frontend
 Transport; Tue, 17 Oct 2023 07:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 07:43:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:43:44 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:43:41 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 02/12] devlink: Hold a reference on parent device
Date:   Tue, 17 Oct 2023 10:42:47 +0300
Message-ID: <20231017074257.3389177-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 563afb95-2527-43e3-6ba8-08dbcee4d315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+7nLyCX2Vcb3mjI1rafa0CqXIV8aFllzmpoq2PMoay+0O+GqtcGtN/DzRTMDgPMVSKHf8iDsklVvVaLy7Z/xleehSi1WKUws7ghAm/gGhu5pbNwNdj5tmSL/Lq8+fqEeHy312WX7z96mTZHFz4CXDk0Nt/t/Jz8B/Wd1C76lVV5l0FquArXU05aAt96reKFwlInyGn98Ng0wLxqOEhfYuY4LQU7Y/cboWcJporHMbuiNP3uvlOp0kTpxYq+l09jx2/gC4tPo3jAU689ENg9l+khLrpUCbMe2QBoOEd4pVJbZ+UrpZOmFCI7PFMYivWhSr1UMrW1wB80MoZulj0F+cBIXbXyoTzbgB4mgamTIWG8kj5k4rps5coUUQIRb7fBZy6ZDdaAeUSWWX891GBVBeGoHuh99TVJUmueNH7rJqG82r3KmN/wh61AeBXpER29Y2jcpiiasIQMd1PB72kcoi1F4S7VfEBVNO6ZZDEMfR4o0p/z+c4NJpmjsSZmvvh1JQpuH7kyyGIzBLuJu6PoICOTxcaooWbCJKzNcvZL4dXVoa6z54yZxLJ1r/Ud9kXfDINa3iY4oMX9wEKeMQ2yujsoCzqa1/PIuPwAMOKMLFbM1bzE8nPADUkft63TKBA+DF7dqd2jzyzE4Jr5PmDi+1qL+lqNBGXY6wcwkATipx5d3AQMRLct5IUC8g5lgYP2p3shc8N5MHCs9QyEKXxElV9N8DANfjyZASb2pK0jxHPbiMosaOdEslHP+NLZoyy9
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(70206006)(110136005)(478600001)(54906003)(70586007)(16526019)(426003)(1076003)(26005)(336012)(107886003)(316002)(2616005)(4326008)(8676002)(2906002)(8936002)(5660300002)(36756003)(47076005)(7636003)(36860700001)(83380400001)(82740400003)(356005)(86362001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:43:59.0131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563afb95-2527-43e3-6ba8-08dbcee4d315
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Each devlink instance is associated with a parent device and a pointer
to this device is stored in the devlink structure, but devlink does not
hold a reference on this device.

This is going to be a problem in the next patch where - among other
things - devlink will acquire the device lock during netns dismantle,
before the reload operation. Since netns dismantle is performed
asynchronously and since a reference is not held on the parent device,
it will be possible to hit a use-after-free.

Prepare for the upcoming change by holding a reference on the parent
device.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index bcbbb952569f..5b8b692b8c76 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/device.h>
 #include <net/genetlink.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/devlink.h>
@@ -310,6 +311,7 @@ static void devlink_release(struct work_struct *work)
 
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
+	put_device(devlink->dev);
 	kfree(devlink);
 }
 
@@ -425,6 +427,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (ret < 0)
 		goto err_xa_alloc;
 
+	get_device(dev);
 	devlink->dev = dev;
 	devlink->ops = ops;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
-- 
2.40.1

