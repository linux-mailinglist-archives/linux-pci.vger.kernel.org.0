Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4267CBC94
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbjJQHo0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbjJQHoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD4116;
        Tue, 17 Oct 2023 00:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgHrtpF+gZRbIB5nPyRvUrn+8hPfBgmJRdoCYHwBxzYP6Zh4pYalFe7zsiAGoFydSXwN3Lzc821/D4AT7s1z/kWjhHbIaExyaH53/mVgRCARFaPCNyFG8a3vEQP+NlBaGqVljTEZCSUBmLEJ24/II2CwS6jIhThj61U1FZp949LsQfGYsBgWiPFcl2xpjlOAlYTnu1WzM3OCWJ/DOs0cU+37NZf2MVciRl9AIQEEciICjgXpqi/HKk7CCBiEIs1R2WFnRouqFA02/U+ayaqvgubOtNypxzv6ixZXVcPd2g1k/GJn0rpwQvxL6mkP3C2YEm+lO0HpD8xMOICs+weT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvrjWKnInD3FEV7atI/fMRbwGrB4JpQa0u66Dj1Pow4=;
 b=CjfuwBT56S5n4OE98WavkLLzXE5xo2UMAOQTz78M0mGSoRkmG+ZWgnX3IJGzPtnM0PEBliWV05d95AYZI53eu9LJGcRn1jULOPmK4TT9PpheZVlwm9L6YIJmFkdkDCqn2sy0SsQGv5zkyXYUS6N3F04HoB7Djs7sq+UcPjxHwg4bd9hkxFqidk6zb+krFid4z6WNckvHbDfrON8U+8yAGzZjwedsqNpvkBIXPHnzvxMCeeTV7dskaE1XMo7CnqijvqhOZHJ5CSgLY8c/xLCMx0Zth7lSza+ntFpLY/Pvu4vhKRwKhlEAYqQwsWy9T6iJZThJM656Ejc6AGl2ayt8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvrjWKnInD3FEV7atI/fMRbwGrB4JpQa0u66Dj1Pow4=;
 b=aZeIgtktILD1X0ZfeS8COThKNgHrhMforLZEYhqjUzGidCTLvVrpUA8x3UZwHLWN4J2ZW/FGa4VYXC6QPORoC8bu6Xn+3n2xaPP0BHKXB9Vw7iHNG0jkV1pOk5LyCqRz1JsExvmac5bUAXAwwFnjtWCf9qBnCnK4OUk1JIgShdNtajfM7zbS60HTKW7zemWZ8N6StgdUEicQ4TrZZiJdFcHjEua9Q2wRxpXk8/ii03kLBten1ZjyYa+YAgK/51nNqhjiAIDp6KnLtAWS+LbJaXfPoKe1VHpPyF76dcIA1A7aLxcOJ/aTJXDzBEOreqERzaTu6bmpiIaoC/Wr1xFq/g==
Received: from CY5PR22CA0089.namprd22.prod.outlook.com (2603:10b6:930:65::20)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 07:44:17 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:65:cafe::eb) by CY5PR22CA0089.outlook.office365.com
 (2603:10b6:930:65::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:44:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:44:07 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:44:04 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 08/12] mlxsw: pci: Rename mlxsw_pci_sw_reset()
Date:   Tue, 17 Oct 2023 10:42:53 +0300
Message-ID: <20231017074257.3389177-9-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 84173d44-40ad-4c22-97be-08dbcee4de1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzS/yOHGxCIUfpXTuxbJHNGSHoBn6X+et2xpwH+kM97KhaBiEijG2lVYppT9ylazpCyJqdIkF0ehwcxIeJBryZu2QU6lI4I+aE5T5W1MU+BpTaLBCSMvjXsa8GT0wuX8xbbdhCLH+m0mWWO3FA48ygqy1IRSLEVcSoC46t0ZGwNUsWfqfb82dguc5Lrq3ugRrGQgFpkmQfg7LjMYlR316amF+IUJpsSt5uKSZ4aR7daB0KzRfNDF+CyYQVCXM6ShGavm5WQLAln4Rraukb4yh8vgLw8ry+QNSSUcKNHwDNcLc/0SNJ1hOFk+edijZ2PGwQ6cLaIAS5VFtabW4sSezj9hZitdc4tV5aaxjCwgQyx0XXHPCzW/toq1ZvjI3cPIvvA4Nz3t+LbwpEZKXNZ3Ahgd8PEaI0e6+uCozMIQFgqU5Fkq+/A3Dduy5BrxmV10zTkb8f36FCSdxeEviT5cocxS0yLzM+AEQQHa4QRoWH6h8IVFkpALyCZ7lAt1eE94wghGsd+KoBdPP0AwxNtuyNf/eq4LG4ra41p5m4aIuvew5WIEdAck7TzGuaMO5/sHJtkf88zuSJ/EPvmXPQVPL8PROJfobYG6g2VGcjYpzzyOVIitK2y/rUGS59bFnbgFocbAFgWnPJafJr/zrMGIMGDdPjYajsg/XpddmE1cpEU5dr+nphv3I29V1izQT2mW+o4KPTWwacfD6FfXusnuS9qs/MQwjkJc0AWL+b0/fj0Acmq1VhNfYkHL/178ItKJ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(316002)(70206006)(70586007)(110136005)(54906003)(2616005)(6666004)(478600001)(107886003)(1076003)(8676002)(8936002)(4326008)(336012)(426003)(36756003)(5660300002)(86362001)(7636003)(36860700001)(26005)(16526019)(41300700001)(83380400001)(356005)(40480700001)(47076005)(2906002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:17.5801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84173d44-40ad-4c22-97be-08dbcee4de1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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

In the next patches, mlxsw_pci_sw_reset() will be extended to support
more reset types and will not necessarily issue a software reset. Rename
the function to reflect that.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index afa7df273202..af47d450332f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1464,8 +1464,8 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 	return -EBUSY;
 }
 
-static int mlxsw_pci_sw_reset(struct mlxsw_pci *mlxsw_pci,
-			      const struct pci_device_id *id)
+static int
+mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
@@ -1525,9 +1525,9 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	if (!mbox)
 		return -ENOMEM;
 
-	err = mlxsw_pci_sw_reset(mlxsw_pci, mlxsw_pci->id);
+	err = mlxsw_pci_reset(mlxsw_pci, mlxsw_pci->id);
 	if (err)
-		goto err_sw_reset;
+		goto err_reset;
 
 	err = mlxsw_pci_alloc_irq_vectors(mlxsw_pci);
 	if (err < 0) {
@@ -1659,7 +1659,7 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 err_query_fw:
 	mlxsw_pci_free_irq_vectors(mlxsw_pci);
 err_alloc_irq:
-err_sw_reset:
+err_reset:
 mbox_put:
 	mlxsw_cmd_mbox_free(mbox);
 	return err;
-- 
2.40.1

