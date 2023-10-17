Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312957CBC9B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjJQHok (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjJQHoh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B5124;
        Tue, 17 Oct 2023 00:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndIqh2proNqp7wGzOyezUsPm0FAXnjtmQbUQjLSGdBmqIIe1LOTVfWPWHDYKhUjIS22c0+Z2v6S8tPynYFMu7Jyvmc6//Bm+N0zZbDPCs8VxNzwhn9DNHdyt+T6T1fmNfuknoy+r4gvJjHA5sVo0ufYkPiHtiKbLRF0aIlgFDpw3kdpBA69rdtqaU2q1gbcGvA4MH6T7Lag42VluT6q/C+ScDCv/vVJcgYRurppr3+jQwOaHGF5VQy4O9J5UCOozwrehgo0/f8C/MzWwTvA/LsIpNfaFgSiyGB+yTn1GGMVyd7UUL3Tpp3muEXDoQQvxuXrWDymHgoILXiL8J2K5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRWUnk6t5TArjd2YyK/IisbcCMSDer+3jvzA+PByoB0=;
 b=baKm/zHlGitLPysIjossdn6yQSUc6UdjGSqS2F73ji3n70ZxBKJBuXHocfFDKb0OIPRBsj5KEY+hwtKTZgxwCkQ7WuWr0QJ5W/x/MluiVkObErRGRo0sjt5VrIst2lUhg6YJLxNuT34QgtHuI5KTp1DafPmUUgeFqUSSceTZP9to/BaxsdtCxi1XRkfp2VMd/K9uLzWMrZ0+/9xFAO+2T29XKSXUovQu7TcgBAW1SUx+FzlSqgQ5V1Fgr4UzYAHVF4dMHwiq/vdIgZ+0mXsDNJlUvqVFsjMykjhOfWgz8JAwZ3CicgJMyzfClwpyezu18ld+iShgoPMPj3FV3JL0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRWUnk6t5TArjd2YyK/IisbcCMSDer+3jvzA+PByoB0=;
 b=rcrS/2uHx2of//PW2CznQRCq1BWDvlYbYg9Dkix8d4jaiqCXMxJQ6V5Gaf+AZym+ArKPXLnbaCh1m1/pDAamBVhP1fomFoq2J6lHPV7Ip1VMEHpVOjmVMT/onF0mF2DSUtD0sAL7oGama9b7DEj7MA71BU+FGfZURfreGvFs4qDw6aS82vXhbgwJjwVMx1UMQ4QLb0w6HWcG7iLccAkJZE70dsLne7J4rFAz+ejPWQhmUro4qwKuMsHhDZoCMbCXgCCxOtPULVb7zgzxAjvSHvKpsRHAkGmuj5HoL4SqLTCXqzRnZi+1KtuYZe6cdcPtgxsWTeq560fRdNE4EHmo0w==
Received: from CY5PR22CA0087.namprd22.prod.outlook.com (2603:10b6:930:65::6)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 07:44:31 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:65:cafe::ea) by CY5PR22CA0087.outlook.office365.com
 (2603:10b6:930:65::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:44:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:44:19 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:44:15 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 11/12] mlxsw: pci: Implement PCI reset handlers
Date:   Tue, 17 Oct 2023 10:42:56 +0300
Message-ID: <20231017074257.3389177-12-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BY5PR12MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f1d7b0-e023-46cb-83de-08dbcee4e664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+LbF0wRSmfxtvtPbaxcRme+VBk2a93suCi1XErMN8b96ByABXogutb2y7Al6ACsnLmhK5LOF2nSKNQ6L/ARJgkN+q/+33tY00G+Ut5rMjpgacYN5j4EAfcOnA0SPsEQFOgnKNlQITku04mG9sy5QfN6ni7KECp1p/r1I7cL6QI2s+W+BOlrP++JfzERcKyB3eG8vIsm8vejcHNuKJd++rWFbP6TPn0mUDf5CAn0J+NoXkFrT5KIyG8ZHLw+R4dLLyTSyAfGDX8zmcKDba10U39ix1gUF+YIxwQtkMVydn1JzFmOPQ4caiUt42GErfwwNVIx8x4VWStJ6MHkWUfwBCvw9dsJoGwjDAgFMBXkY5/pFNlyZep/GsZLno5NtV/3WGK3IpcYFvaZeLy6tAAEb9X9Q8EyBrm4QsKq2wyN0pdeRDZtgse23Vnd8aCImGS1jN0iGe/qp/EBVUZbtqqtdmdiCn+CWa3YxbJJ8lOVBGVfERIoYaR7DSpBQD4VtpJy5ePeO8DSHuT/qYz/UZ4rgsxR84wneyJJu6qzaZDjHn48HTTuGfcWms+b5SDHfGfqDNYE5F6jnvLspOLA+CXh1XdpzzZ6O24d4aAcxC5SiXlZCdURfCqYUSnHjTZrFK3w3daQnU8fohkE++jjLLzeuWbsjrcmbtN15sb0e27d6J+vi5FyT6gGbQ2fCGeAEcZFtXttDD72pb8x0KQ0ORB7M+izXOm+r+idYIleSMWvtQatIFGGPI4mbz4+TrWPaet6
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(36756003)(40460700003)(110136005)(316002)(54906003)(70586007)(70206006)(86362001)(82740400003)(7636003)(356005)(8936002)(36860700001)(426003)(336012)(107886003)(26005)(1076003)(2616005)(16526019)(6666004)(2906002)(478600001)(41300700001)(47076005)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:31.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1d7b0-e023-46cb-83de-08dbcee4e664
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement reset_prepare() and reset_done() handlers that are invoked by
the PCI core before and after issuing a PCI reset, respectively.

Specifically, implement reset_prepare() by calling
mlxsw_core_bus_device_unregister() and reset_done() by calling
mlxsw_core_bus_device_register(). This is the same implementation as the
reload_{down,up}() devlink operations with the following differences:

1. The devlink instance is unregistered and then registered again after
   the reset.

2. A reset via the device's command interface (using MRSR register) is
   not issued during reset_done() as PCI core already issued a PCI
   reset.

Tested:

 # for i in $(seq 1 10); do echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset; done

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index b5bb47b0215f..8de953902918 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -128,6 +128,7 @@ struct mlxsw_pci {
 	const struct pci_device_id *id;
 	enum mlxsw_pci_cqe_v max_cqe_ver; /* Maximal supported CQE version */
 	u8 num_sdq_cqs; /* Number of CQs used for SDQs */
+	bool skip_reset;
 };
 
 static void mlxsw_pci_queue_tasklet_schedule(struct mlxsw_pci_queue *q)
@@ -1515,6 +1516,10 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 		return err;
 	}
 
+	/* PCI core already issued a PCI reset, do not issue another reset. */
+	if (mlxsw_pci->skip_reset)
+		return 0;
+
 	mlxsw_reg_mcam_pack(mcam_pl,
 			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
 	err = mlxsw_reg_query(mlxsw_pci->core, MLXSW_REG(mcam), mcam_pl);
@@ -2085,11 +2090,34 @@ static void mlxsw_pci_remove(struct pci_dev *pdev)
 	kfree(mlxsw_pci);
 }
 
+static void mlxsw_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct mlxsw_pci *mlxsw_pci = pci_get_drvdata(pdev);
+
+	mlxsw_core_bus_device_unregister(mlxsw_pci->core, false);
+}
+
+static void mlxsw_pci_reset_done(struct pci_dev *pdev)
+{
+	struct mlxsw_pci *mlxsw_pci = pci_get_drvdata(pdev);
+
+	mlxsw_pci->skip_reset = true;
+	mlxsw_core_bus_device_register(&mlxsw_pci->bus_info, &mlxsw_pci_bus,
+				       mlxsw_pci, false, NULL, NULL);
+	mlxsw_pci->skip_reset = false;
+}
+
+static const struct pci_error_handlers mlxsw_pci_err_handler = {
+	.reset_prepare = mlxsw_pci_reset_prepare,
+	.reset_done = mlxsw_pci_reset_done,
+};
+
 int mlxsw_pci_driver_register(struct pci_driver *pci_driver)
 {
 	pci_driver->probe = mlxsw_pci_probe;
 	pci_driver->remove = mlxsw_pci_remove;
 	pci_driver->shutdown = mlxsw_pci_remove;
+	pci_driver->err_handler = &mlxsw_pci_err_handler;
 	return pci_register_driver(pci_driver);
 }
 EXPORT_SYMBOL(mlxsw_pci_driver_register);
-- 
2.40.1

