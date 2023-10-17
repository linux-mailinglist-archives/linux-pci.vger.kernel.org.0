Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC27CBC98
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjJQHod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjJQHob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30D10C;
        Tue, 17 Oct 2023 00:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRPTomM0b//O0jAo5TvPPu8mg98dQQYFBH/wML6pbxa7Yx3AEIoUzj7B5tMfmZeHihrGCaOLFjdBe6CVROBVmNDxXA5whUmGqJNeRYfh8Y6LjgAdFlsVSL2ulYhxDb9xZr4pHpfBvDedqd9cWxmDQji4ozn6LP66LXl0QhAhGgEEzp//0VakdJhqwQLequRf6YfcykMp96nATql0lVd8PmNl3ENE7roaWy4hY+fCKECtEk8BUlXWQPrjjNMvP203ZZTGCjW0B6oFJgPYFydpNJThXjjlXCSWe5THndOLv2rPzsgx8FvNW6O76Q8QfD/M5WrhxoQRmKvUERKN4S8Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0chJtnb3ns48sVZviSEcdyNMJg/VRQQAECZhiVjdrAI=;
 b=Qb7xh9nO0UISYpUZoii3LMVgIBUrZI8xnVAkjmwWyCMCIO9tGZ9rxiZpB80mHE8Zjnbf03p3qhxbdv2R7PcXeo8Sb0q3YxmVb8SfIs6XgpYyhHQi7QX6ZsKFRks047zx2zkG65Yt73elSnAD4rZkAPFJPi0JDQhfsc6a23Vw+RikDXtf9/IC9kVc8wR+m1EeSA1ts6w70cQ/5maXsvE5sybEajfFAIqamVyEEly6Y+5mANl3zbRAfQUUYvhRgaspT1Kl/aTaTpy8At3+ya+0Lk4EYZpUeVHCGWmW2bhaZ2vh6xZ+dR+azMt4iIGSYlJ0G1pmkMS55X7LMZREdTi3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0chJtnb3ns48sVZviSEcdyNMJg/VRQQAECZhiVjdrAI=;
 b=HMxRj4CvK6kHmJBAlmNyPYjB155up+GsjeRp6rj6WhEe08g6oRrcN6BpbjE2xg83J//T6s6HG3+S/1PGATibJ2/CBk9B4yM3WVqqAOyvQhgnHUhC8RB0n5AVkpHK0NxwVUtavw1rrj2OgukkXpVad9quPn5y1SZfazA6QkYqcbKkFkD68GWgrBqdAbGlo5YYr8VviXBFYXtNPkMwAgesvxRJpENR9DI3HS4c1IXPBYEsVihYJq+um1ZKL+BlCz3vpUS5OR3bZ5YhVrIs3IKMJPJSbKXrlqeY7Zm+I7VuTcldQcmWiXKvfYPn7iPYx8HpBuOGaiSbj+UBxi5Bvcq61A==
Received: from BL1PR13CA0173.namprd13.prod.outlook.com (2603:10b6:208:2bd::28)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 07:44:26 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::3b) by BL1PR13CA0173.outlook.office365.com
 (2603:10b6:208:2bd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:44:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:44:11 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:44:07 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 09/12] mlxsw: pci: Move software reset code to a separate function
Date:   Tue, 17 Oct 2023 10:42:54 +0300
Message-ID: <20231017074257.3389177-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CO6PR12MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: d69bb817-e09f-404f-120d-08dbcee4e2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wTh/GRZjORzrulnHjP3iB7v7wPoYAUBVmuqI+Z0NI2wYjbo3FSqsGQxhH7eg5VucY7/iPhEv9ewAcdqLJ6rV5PjXlC06OUQGh/bEqC2V9tVAE2rCe/SdwdplJtKsUuLvAC/5NgTP0cZMg7eqGn6LzjtrxzP+ZfFpsKieopq8LwG5ouWzuaN+zTZKEBcV/xaw3IImxrD7drW52S7zzBBnNpR3YNKbWHKnek7agGPtpagB8HwqnZBiocYCbbsbFPFGn+stUD46MkCTI+62lo3wc91i/9npzBKR/gNXKtE7879yQBF5+AZPId4VdNXsp4jEuyzqIHXrf9Hen2y7xQshm/QbjOx0xvoJ/R7VDZIPEWfhVcTWgo/TVxoizZK3m/CwxWhsah/Xo/aVh5kG/ZcNQpsnkXh97zwFQH2DkrBXDSI6axr04Tn6OmNGB14Ij/lZnCVGhN646OAMgwLZ4YREVkVmXetlVP6U2VrFI0S+8rD1PN+7yrJ0VsgCydeI4kIuHc6Ob9v8mXoSnjy+M9HOmCuwdIfWX5/ZhFFAE501ibQLJyvVMV8EBabpzAOREbj6PE4dAhjgHElvzs8j4P9gx3XCoEBU8sPJ5rQ8DslIzH/7FjDHIPWiscyc0AOpcK9tpHvWwUX6Kon/7HXwYNnxf+drdNICFYjjm3dblDsCYc5MYP0U7NNqbTuFWyehj96Lmbobzy4v7wdGfabEoQyOoBQJEuHVfVejbxAOrl977Y=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(82740400003)(356005)(7636003)(40460700003)(8936002)(8676002)(4326008)(41300700001)(5660300002)(86362001)(2906002)(40480700001)(478600001)(47076005)(6666004)(16526019)(426003)(336012)(107886003)(2616005)(36756003)(26005)(83380400001)(1076003)(54906003)(316002)(110136005)(70586007)(70206006)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:25.7192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69bb817-e09f-404f-120d-08dbcee4e2fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amit Cohen <amcohen@nvidia.com>

In general, the existing flow of software reset in the driver is:
1. Wait for system ready status.
2. Send MRSR command, to start the reset.
3. Wait for system ready status.

This flow will be extended once a new reset command is supported. As a
preparation, move step #2 to a separate function.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index af47d450332f..1980343ff873 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1464,11 +1464,18 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 	return -EBUSY;
 }
 
+static int mlxsw_pci_reset_sw(struct mlxsw_pci *mlxsw_pci)
+{
+	char mrsr_pl[MLXSW_REG_MRSR_LEN];
+
+	mlxsw_reg_mrsr_pack(mrsr_pl, MLXSW_REG_MRSR_COMMAND_SOFTWARE_RESET);
+	return mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
+}
+
 static int
 mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
-	char mrsr_pl[MLXSW_REG_MRSR_LEN];
 	u32 sys_status;
 	int err;
 
@@ -1479,8 +1486,7 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 		return err;
 	}
 
-	mlxsw_reg_mrsr_pack(mrsr_pl, MLXSW_REG_MRSR_COMMAND_SOFTWARE_RESET);
-	err = mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
+	err = mlxsw_pci_reset_sw(mlxsw_pci);
 	if (err)
 		return err;
 
-- 
2.40.1

