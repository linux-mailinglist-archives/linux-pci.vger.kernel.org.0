Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0057CBC87
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjJQHoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjJQHoH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FD8F;
        Tue, 17 Oct 2023 00:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikEsNTIMI1rtDZE/aDLfIBhbUvjVYJL00vA3UCv/xndAU3uVDqcOplK33YUjT2jwjMuRZTOtnjHAB7RMCVHFb+xp4J54cjf0Vu+YtwniJFZfFJOX9cdoU9H5JQFdOWllk2LdTcUgEPIp+It+t0CXOUZLBiRd63qjfHIat2Ob4UM1tYUKq+Vo6lHPb4cXKquMnfW1mUsJxePZIudzz2bxypFPhZDU9VoCbnKPo2jrKAxEmKisV40EmsLJ8eJUwgNpGEZ1H/vsBKT5WEnH2BljJMUts3uHYuHUUKD94NEwhhWo2x7BJkjwrjz03o9gfWJasjHgxICPUXqv4wBy5zRl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n91lZ8OzIl4a+vNqew2S3qyrxSEe3wp3gOPs4Xh0hIg=;
 b=iMrhLbQWHca/jgmuSdWxyVfkH7kHIsY7wxdR0UyC9KddU/9ydQai+ihvEchFtEdjuoCwK30P/gdHRYmZHwsrcayIR981l+VcGCDXgEWBrWjmEB3MCWO8rD1GC7ES1tpPSc2caPOJ0HPJKfahkA3WDBPG73TbfY0mgEY4Au3/atVko6UTBGg8mCLOp086MEvUHoUcDq4/DT8O5jCIv9v9c856ouiKVGuN38dvI0af9dbp/kBy7j1CkuftLdLiX75I4mCUjiNhW+Mg4GCdOMphjjnR2sBzUrG3VfF6tC3Tthm0F0u9ZZwF1mBdxiwVMzp2R+StIpmh6cd1tsVWq2XiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n91lZ8OzIl4a+vNqew2S3qyrxSEe3wp3gOPs4Xh0hIg=;
 b=CNg9qzYLS1tUuMGwC+hf+EXovKp9D9c3XWq/hknNVGFfblM0XPSUyrDI7gjH7/YWLpYKVm4Fq4DrzrUlHxZ9vMfacUQ3PIqN9UcVc7XmchZ9cJf3MGzeo2qMQ2JrFAFSWM1FJJUT0V6ehidR/Ii8tCxIRAG79TbkVg/xN5dnrRMcdfnHpSgI1OsmguRFxqY97i1MwJ/xygmVLQaC08nULJT98bS8jbpAcBUPmC/tOpYoGZjJiKyWdSyvTkO/7uR0F6HZyvsz8LF/ksGJolw9XvIM1kvSoMvXZ/HtLvAWQYw1EAU/yZ6mFcnDr5W42tCCDXwfFGHstKh8kBNSOz1njQ==
Received: from CY8P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::8) by
 DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Tue, 17 Oct 2023 07:44:03 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:47:cafe::9a) by CY8P220CA0036.outlook.office365.com
 (2603:10b6:930:47::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:44:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:43:52 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:43:48 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 04/12] PCI: Add no PM reset quirk for NVIDIA Spectrum devices
Date:   Tue, 17 Oct 2023 10:42:49 +0300
Message-ID: <20231017074257.3389177-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bdbd3b-06d8-4ade-eec9-08dbcee4d5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNbSAhjIxV04I+eE3Rr8XODNpCk+JThkymm0RP0oKmKuP8ByeFgntITLZzb+JQQmoMC7w1CGqB5jX/bCN17s4/3GFP5xMj1P+EwqJ8Ze0aSsxM0hlsG9Lh9u9lmzMHRgqp35OIavPCBMqy9+ZOwNHrx6N9+xgIJtglvqjA/ylHLJaUDdnAuq5XXRp4CsDbpCglFpllge2dyWbr+zVHtj8VBcBjKgFqAuSJAyxRSdrmhb3qyGZ6oI+r+GsKS/fdqot53gGHn82orbZSpQXF3S6BJNWrEKrEchgIAjSaGYReUHDpHK9eMWu0QH+7/OGGIp9+kFkoRGIprusWAhgK75miEvOs+MeOFJSxbdXhq/SDbQZnJRw3H+GQgQA5bFV3gPh6g/dBHkUIU8bMIAHuaoRk7HyTs3GF6jxOrMciB+eFMD74HA2Us9g23wyXM12924CC8FAb6Edu4BAK3gfzKy7sXRfrOvy2snH0f/f03Om2mR6pedJHsSmUcCiIW7ECHzNuQJkh7wz4oUq8otQ40sFsbKbAE1G1X3+GpaHX6UalzNkSq6SAblGkUFtRjU3no0FOp2LkPyVK5iZaWGb5NkaqWF9ykqxd0pkLTdKVs6pz75kl0C3AV6noJGLVzHJjot+767BpsSTnJj8KzryvdVL8m5EQxTZJYV7v8lBEVTps+vAC4HUvwX2JnGbeHlX1NgYYRAdFlZk+Y6EKoZ5BBZX1nIrSHT8SqC5vjNTzxxAjZWPMd2288H+woIG2EGP7vQ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(426003)(86362001)(356005)(7636003)(36756003)(82740400003)(40480700001)(2906002)(47076005)(8676002)(8936002)(41300700001)(5660300002)(4326008)(478600001)(107886003)(336012)(40460700003)(70206006)(110136005)(316002)(26005)(70586007)(16526019)(54906003)(2616005)(1076003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:03.4265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bdbd3b-06d8-4ade-eec9-08dbcee4d5aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
reset (i.e., they advertise NoSoftRst-). However, this transition seems
to have no effect on the device: It continues to be operational and
network ports remain up. Advertising this support makes it seem as if a
PM reset is viable for these devices. Mark it as unavailable to skip it
when testing reset methods.

Before:

 # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
 pm bus

After:

 # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
 bus

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..23f6bd2184e2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3784,6 +3784,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
 
+/*
+ * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
+ * (i.e., they advertise NoSoftRst-). However, this transition seems to have no
+ * effect on the device: It continues to be operational and network ports
+ * remain up. Advertising this support makes it seem as if a PM reset is viable
+ * for these devices. Mark it as unavailable to skip it when testing reset
+ * methods.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
+
 /*
  * Thunderbolt controllers with broken MSI hotplug signaling:
  * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
-- 
2.40.1

