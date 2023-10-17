Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97B77CBC92
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbjJQHoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjJQHoW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1876E114;
        Tue, 17 Oct 2023 00:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7ugib52Pd4qBbqAmBcIlAZ2jhSEc6OEa4ulq7fRzVUY7A8NUykzFNIG8lL31ikJgSHL+xb4coJsvkypUOulH618N3LeCfl29Ce162yNpXWuREpqkMDJzNJZiAtA4xJ6uIdO5FEXKsSzQvA/CgZuUdQIG/6DwOAx3y4cc8f1UBoid3TeReCtMLRMoeGf32wzDRHA89os37RPywfy4XhfMUt8nnd/6Iaav+Db2C4Ao4OgKmW+1PlNUyU8kaGirgJMZvmc9xY83Nfu0WFHh76v6RPDnMNs8G/RyYxa6hYIoNVGMj/qPoPwcXYK6K1f6AZY4Y2s1NwYGEkOnKOjyWFXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+Wxkya7jtrraxFiIxfX4SLA1OlxnpDaImArPrytwp4=;
 b=ZcCbb36a8H9LuEvYKewO6lT8EUrM8yFIttmKKfAUTu6tGEZefrAC2iuvwr53R6BGSlmqUQkBRnInLF126A4w/EiRKPzUjvEtjggXzZQs8aAibhd0WBZ0VM2J7tgknB5gUBz3Xk3DKamHbnbKzTpZBjAprUuG/gRe8dM87ai2tM9F3UMG+pRlIXfxwfY/pvKqRhUBD58jyzbpo7HsxuqBA2pkxfmN3FEpEwpNVv4yFrEa1jd5meWu9W3hgVHOP/mnID+Jf/o56JErD+ESh90VcZ5Wrv9m4WcyOZliUyX/LyondoECIuXQajJbWhNmaIKL9K/52lJTiS8Px+tLpRPGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+Wxkya7jtrraxFiIxfX4SLA1OlxnpDaImArPrytwp4=;
 b=tRR3C4vTrt6+Rq6OXwEveZsM6lGYvHg1s156Q/tAK+8QQ2BabqRwEZcPMGfP/1HlLQhw00AleJTF93JAz7D+DVY5aSe8E7M+mtuabtQKCX0v2cHbobZQ751M3QeCFbkFnL0ygEGtkfU+d9oNunt5Ya7b0c4Foxd98qkfo6kz7Ih3vk4ZfOeeXwQK+IKj4NZP/B8whqmXldgUx9hjRNgX3GpvfUj3MLf25ch1nPF2HUw7W7yNAtQeIB3k6DmlGEt7OR3YYiNRtGESs9k7Bl0ojm+RX63J34ZK2cd6We/jrykzgrfCl9jXhXFJdyrZsiA0xrx/NF2hDEbKjzZxo3xRfQ==
Received: from BL1PR13CA0163.namprd13.prod.outlook.com (2603:10b6:208:2bd::18)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:44:18 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::7c) by BL1PR13CA0163.outlook.office365.com
 (2603:10b6:208:2bd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:44:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:44:03 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:44:00 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 07/12] mlxsw: Extend MRSR pack() function to support new commands
Date:   Tue, 17 Oct 2023 10:42:52 +0300
Message-ID: <20231017074257.3389177-8-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de35ad0-aa49-4c7c-89c7-08dbcee4de40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIN44ee5Nugsnm52TsPawf0b4D+XynEaPnWV4sFUxogBR9v11AEkKcLhdODsTFXFaqgqdboswioJLVbNx6akSHIiIofRNDGvusbqTunuW953usMsLqnIWaCTsRKd772axuU+mzbNnauLXO6RK1apRe4u2pI4CpSCIvum/sKIYGKkQSEUGOqQhFyBsF+zZvjovzZW1BrJRooQDXvHzFYH7DTYbLPhHZdsUcI8gHq+9JjS8jg3Cc7uZ9YSyF9nzjt7CD8iEHrSkhMxA0n/OZyoliSf0w1E2BvpsUU4/w8cw1oL4vzP9G70nMNajqWQA6DAfVHgp/QoXc/bXSY/K7wB9cWpgpaerYVrDLc+1cGmOx8/aI5DUiafLhUz+dTa08is7xLiu1A0Ze6ipHUB0twM+CcXzOL66xfp6Q4CTyLL551BIT6kghhVK+FmIpZmKjqdcmi261cWD5w0MxZjSNLt3GJho/jvt6Sz5xgnDuyYR0CGUc9TDDia54wWKmDzais6zZBGr47A8VD44l6NqDjFEuFvwADUhbFDGufwyWWiWkxUtQOxEknezAb/OTcw+S2WOwTNjITn2P1JPQWsqXKTr3Y90jJuw62O9cqyjgjjDkB6C+HnT+aa5nyvq7UfIeQLmbfUJPA4JVs1i17U5a+t6xmBZkApTcfPIRc9NgMmYuKKkpBam9ZTiLML6x5IG2Bp0ZEx+b6TxanMhPfEA70m1ekMqYTQWCbFDTr3l0kNcoo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(5660300002)(40460700003)(2906002)(26005)(36756003)(36860700001)(2616005)(426003)(336012)(107886003)(16526019)(6666004)(83380400001)(7636003)(86362001)(47076005)(82740400003)(356005)(1076003)(41300700001)(316002)(54906003)(110136005)(70586007)(70206006)(8676002)(4326008)(8936002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:17.6881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de35ad0-aa49-4c7c-89c7-08dbcee4de40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amit Cohen <amcohen@nvidia.com>

Currently mlxsw_reg_mrsr_pack() always sets 'command=1'. As preparation for
support of new reset flow, pass the command as an argument to the
function and add an enum for this field.

For now, always pass 'command=1' to the pack() function.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 7fae963b2608..afa7df273202 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1479,7 +1479,7 @@ static int mlxsw_pci_sw_reset(struct mlxsw_pci *mlxsw_pci,
 		return err;
 	}
 
-	mlxsw_reg_mrsr_pack(mrsr_pl);
+	mlxsw_reg_mrsr_pack(mrsr_pl, MLXSW_REG_MRSR_COMMAND_SOFTWARE_RESET);
 	err = mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 9970921ceef3..44f528326394 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -10122,6 +10122,15 @@ mlxsw_reg_mgir_unpack(char *payload, u32 *hw_rev, char *fw_info_psid,
 
 MLXSW_REG_DEFINE(mrsr, MLXSW_REG_MRSR_ID, MLXSW_REG_MRSR_LEN);
 
+enum mlxsw_reg_mrsr_command {
+	/* Switch soft reset, does not reset PCI firmware. */
+	MLXSW_REG_MRSR_COMMAND_SOFTWARE_RESET = 1,
+	/* Reset will be done when PCI link will be disabled.
+	 * This command will reset PCI firmware also.
+	 */
+	MLXSW_REG_MRSR_COMMAND_RESET_AT_PCI_DISABLE = 6,
+};
+
 /* reg_mrsr_command
  * Reset/shutdown command
  * 0 - do nothing
@@ -10130,10 +10139,11 @@ MLXSW_REG_DEFINE(mrsr, MLXSW_REG_MRSR_ID, MLXSW_REG_MRSR_LEN);
  */
 MLXSW_ITEM32(reg, mrsr, command, 0x00, 0, 4);
 
-static inline void mlxsw_reg_mrsr_pack(char *payload)
+static inline void mlxsw_reg_mrsr_pack(char *payload,
+				       enum mlxsw_reg_mrsr_command command)
 {
 	MLXSW_REG_ZERO(mrsr, payload);
-	mlxsw_reg_mrsr_command_set(payload, 1);
+	mlxsw_reg_mrsr_command_set(payload, command);
 }
 
 /* MLCR - Management LED Control Register
-- 
2.40.1

