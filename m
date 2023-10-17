Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24BA7CBC99
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjJQHoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjJQHoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9D124;
        Tue, 17 Oct 2023 00:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCq8abt49Atv70bttgoHO+B06kvVngCYty2Qk62FfdCmvae6f4xkdWNT6a3QYJ3nKwX4kyNiv1vjSyeIWAw43DtHW99+IyXdFwIvVyDSlhqV8CDR3j7D+3eWQ2vv/1JuNPqawvPtFEy3pIeo9ESFiVQLT1OLvTv2duG6XMhP7PxRWlMr3DY1k+4eyOPiEfErcYPiiZpzCqPAOxZts1wpmLWeXY/z1TG+wcSeu5Ydkx9b2arTrEE4DCX6/xTsNYPUXb6bqGuejBVbKxdOu7ejYOFP6lNbga2qTvzN4CJAMpswMw8x5ikdlkI85IoqnJ658u3fa0vr3CABiSiSCOy9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vqs+C06eO7czzQVki9lE5wuURywSDuMWoKlaORdiDo=;
 b=Uex6y1v9hJJ44Qbmf1vOjyUW5LlimXi//jVrSlIEQPUmSqypwZUFhwn9fWt9sVHXnQHZGfIGLSABaqW9cCiK6KQVW6HDe2aYNHNCPd4hpMtOIM3F+rQJ9N7L8hzE96GFsZVrvKjM0bOyJCZ7NECtaMBMdEtina6Q6ls/JT9eKI8czaZz61nvCq0CNyUE7IK+1UU3NqsZMv/wlBKEv9BsFtMr7hvVfGW6MoYD1wKJ3GDFgZ7EU7qpbWphqcbFjbP8fhhSxvTb8JCPJGc5SUySYKv9uu0L3futHcjGgOCSMpijimU2vBYWApoDu4O3FFopqp0W4gyOdeoCbjy7wA9D+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vqs+C06eO7czzQVki9lE5wuURywSDuMWoKlaORdiDo=;
 b=dSUmTm9pOgi6iN4D5cdiW2BFFjnQVbRYZzoLDgXv2DiMQqSjD2e+GQq4Vqt20Oiin41PknmYe0OZMI2MeiplCNU9F6T7qYC7Z9pnkqwVyC6UGMgSQrCHxy4YQEP+bwXWQoMwGJWPCGy1C0ehcBGE//muijgHV07h+SmiFe/TQ201nIv1rca66oUsB2rlWnwRy+/hp0faK4ZO0Rr6szuu0t4+sO3jLTRVDU6/WJYre1/fviBBT9e3USM8pjppXJJjD+Ax/TyHc6vpp3V4XkYS0vTyE2qlIpqMomRGJtezeDMFxXbCfkjkcACrKNlbyBRAt6q5l0EFTS7vBo6Na3/Rcg==
Received: from CY5PR22CA0107.namprd22.prod.outlook.com (2603:10b6:930:65::17)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 17 Oct
 2023 07:44:27 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:65:cafe::59) by CY5PR22CA0107.outlook.office365.com
 (2603:10b6:930:65::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:44:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:44:15 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:44:11 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 10/12] mlxsw: pci: Add support for new reset flow
Date:   Tue, 17 Oct 2023 10:42:55 +0300
Message-ID: <20231017074257.3389177-11-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: dd83813e-52aa-46ad-5589-08dbcee4e3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgeSfGR0RS3z8+4W7X/GG3zzgYxIUdRZrxABG1u+1OswTTUV7rlYpsNp1CLH7i/ROSEeKQfVPBXU63LT0sI35wAruQ4lOtqMH+DL3Nx5DW4CSGAc7FDw62Xkk7Iorz7weoCVDnQJ4E3TsH+o6ormW3M6JhxnNrP2crEkHI8oCfwutKKJ3ME4fCFPX5qEfLGyAN9ibHv0pDfUC1R9QN0v24HyvSAz1WyoOd1MoNY3pQMX37pWwxShj7Qgh3Rh2Z/9y1DqdJyvmzpfTaSMzWd+OgET6YB1fdVyb1jm3ebZqKRwVChrd7a0QwHGc3c2YXy/0BOuGiPWihcxGrCTmxT+UQtS3CgKReKoaq6ATKyUaHdMoxBcbZh1eKrEfDr1dTOJm1pIwFt1sP3NWG3GGdtKwx4+y5Tfc13OM0Qtf8szAsro2tjY5iSulWLpZygd28YwvW3oAfY3Pglq9kcKoK4bXAScRv9/3x+++yvMZ6dMsGVcdQvjEJ4ssmckno26X+ovXChZLIgpXvp7/BF997wtwioumFJyfPvAcRSQU3+16uMDJqVJgPkG2A0b4+VXtGuKZuLy201B0q/miSKw8jP5qJ3Y8jfvDiSh1jzzfAm1JMjcm8Z7iUpdCJpDSOdudziHt4hkiFAv0SZDd9/FIpnmwHGAGwAP/iEUZXv1PQ6GJqu7nN2WIqBNXiMNqsy2qiK959To8nkUV+ZDL8vr5Sd6YfziRwQRMNG3oE6lQUGjUWEOgs4/7KIDm7LacH8kUXj1
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(40480700001)(478600001)(316002)(47076005)(54906003)(40460700003)(110136005)(26005)(107886003)(2616005)(336012)(70586007)(16526019)(83380400001)(70206006)(426003)(36860700001)(82740400003)(8676002)(2906002)(6666004)(1076003)(5660300002)(4326008)(356005)(36756003)(7636003)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:26.9082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd83813e-52aa-46ad-5589-08dbcee4e3ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver resets the device during probe and during a devlink reload.
The current reset method reloads the current firmware version or a
pending one, if one was previously flashed using devlink. However, the
current reset method does not result in a PCI hot reset, preventing the
PCI firmware from being upgraded, unless the system is rebooted.

To solve this problem, a new reset command (6) was implemented in the
firmware. Unlike the current command (1), after issuing the new command
the device will not start the reset immediately, but only after a PCI
hot reset.

Implement the new reset method by first verifying that it is supported
by the current firmware version by querying the Management Capabilities
Mask (MCAM) register. If supported, issue the new reset command (6) via
MRSR register followed by a PCI reset by calling
__pci_reset_function_locked().

Once the PCI firmware is operational, go back to the regular reset flow
and wait for the entire device to become ready. That is, repeatedly read
the "system_status" register from the BAR until a value of "FW_READY"
(0x5E) appears.

Tested:

 # for i in $(seq 1 10); do devlink dev reload pci/0000:01:00.0; done

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 44 ++++++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlxsw/reg.h |  2 ++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 1980343ff873..b5bb47b0215f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1464,6 +1464,33 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 	return -EBUSY;
 }
 
+static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci)
+{
+	struct pci_dev *pdev = mlxsw_pci->pdev;
+	char mrsr_pl[MLXSW_REG_MRSR_LEN];
+	int err;
+
+	mlxsw_reg_mrsr_pack(mrsr_pl,
+			    MLXSW_REG_MRSR_COMMAND_RESET_AT_PCI_DISABLE);
+	err = mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
+	if (err)
+		return err;
+
+	device_lock_assert(&pdev->dev);
+
+	pci_cfg_access_lock(pdev);
+	pci_save_state(pdev);
+
+	err = __pci_reset_function_locked(pdev);
+	if (err)
+		pci_err(pdev, "PCI function reset failed with %d\n", err);
+
+	pci_restore_state(pdev);
+	pci_cfg_access_unlock(pdev);
+
+	return err;
+}
+
 static int mlxsw_pci_reset_sw(struct mlxsw_pci *mlxsw_pci)
 {
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
@@ -1476,6 +1503,8 @@ static int
 mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
+	char mcam_pl[MLXSW_REG_MCAM_LEN];
+	bool pci_reset_supported;
 	u32 sys_status;
 	int err;
 
@@ -1486,10 +1515,23 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 		return err;
 	}
 
-	err = mlxsw_pci_reset_sw(mlxsw_pci);
+	mlxsw_reg_mcam_pack(mcam_pl,
+			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
+	err = mlxsw_reg_query(mlxsw_pci->core, MLXSW_REG(mcam), mcam_pl);
 	if (err)
 		return err;
 
+	mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET,
+			      &pci_reset_supported);
+
+	if (pci_reset_supported) {
+		pci_dbg(pdev, "Starting PCI reset flow\n");
+		err = mlxsw_pci_reset_at_pci_disable(mlxsw_pci);
+	} else {
+		pci_dbg(pdev, "Starting software reset flow\n");
+		err = mlxsw_pci_reset_sw(mlxsw_pci);
+	}
+
 	err = mlxsw_pci_sys_ready_wait(mlxsw_pci, id, &sys_status);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to reach system ready status after reset. Status is 0x%x\n",
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 44f528326394..c314afd4a8ff 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -10594,6 +10594,8 @@ MLXSW_ITEM32(reg, mcam, feature_group, 0x00, 16, 8);
 enum mlxsw_reg_mcam_mng_feature_cap_mask_bits {
 	/* If set, MCIA supports 128 bytes payloads. Otherwise, 48 bytes. */
 	MLXSW_REG_MCAM_MCIA_128B = 34,
+	/* If set, MRSR.command=6 is supported. */
+	MLXSW_REG_MCAM_PCI_RESET = 48,
 };
 
 #define MLXSW_REG_BYTES_PER_DWORD 0x4
-- 
2.40.1

