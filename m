Return-Path: <linux-pci+bounces-1566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB8820610
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 13:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5422820CC
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C96D6E6;
	Sat, 30 Dec 2023 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e839z4wO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B608468
	for <linux-pci@vger.kernel.org>; Sat, 30 Dec 2023 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBTUdbVNTAzNRsnMjhQypSW2qM1pk/7QMLTsllhVGSK+o5cNow5lz9impct9AI/js8Dge/YdViBcLIn/fKZOTfHTML7+INlB+UmHkF4fX9JhkwwpGoyufQwRMDcoKg0uEGTPbHC2vsOLUHSlvjIBAUWRNa9SbtcgCqa3ZJZM+woy0WkpdMV/D5I8mnDdHmvSEzTiv/EJ9UVitUE+BLipm9osF49I4OKOPqFGSYiUsoBaPTp5eYKJ1TmeWmo22xiSNmLT6iR5eeRXNCNiBOKf9iuQxGMNXslImmW5Ux0zDbCPx48/wMrlnLB3APJDG6SH78An1IbY8hfaT4jD3unHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6raChxRt4wCEtQNXY/hgJP/nKPIJjOB/DV5UhBw9wt0=;
 b=EGhUkHNuvbPdqeVD61hcoG8h91BG6sGkzH9M8ygtAvRZYJrJKxchfVPj8zZ/2d7NXUNNKewrCxqUWuYBVJjtQOir24Ypg5SP+vrco3F31Kc78XhCs4iYWe3WlQfY+U+x+WsY2liRWxAE4xRCUoDE36tAjZshPoyspwyENpe+dBrBaR2gG6Km8M2PFChzL6Ck0xmMRuDHGuvNszombhgohS/Dy3Zv1RD7/LN6AQXFYhuoBe0G88M6uPv557VyHVDCc7yGhDPu7gVNxwkmVsxEJdualEXzFiPbXEWJHFePnXDlT2TAKvqEO9CfV3hGHx5p6+RYEjEDYOaFNFB+sRRyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6raChxRt4wCEtQNXY/hgJP/nKPIJjOB/DV5UhBw9wt0=;
 b=e839z4wOYUeZzs3PiKm21xWaKvYUpsGS5OsLjKX2xD928hcvJTtFQeJ7hW7dDRtJriLnJj4r33ZKDE7tHNXFyVPiqqqe7EjHBKLaOWOn29zbBHIvFFbSS+ialMbVGiMvb36kJ3CLjghNUykaVdo0B8xEuLbN1N7850B483u7zl0=
Received: from DM6PR10CA0011.namprd10.prod.outlook.com (2603:10b6:5:60::24) by
 PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 12:43:15 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::1) by DM6PR10CA0011.outlook.office365.com
 (2603:10b6:5:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Sat, 30 Dec 2023 12:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Sat, 30 Dec 2023 12:43:14 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 30 Dec
 2023 06:43:12 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <linux-pci@vger.kernel.org>, =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH pciutils 1/2] lspci: Add TEE-IO extended capability bit
Date: Sat, 30 Dec 2023 23:42:38 +1100
Message-ID: <20231230124239.310927-2-aik@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231230124239.310927-1-aik@amd.com>
References: <20231230124239.310927-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: c0026c67-9ba4-4137-df86-08dc0934e42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2nBWy5cCVnfEVUfBli/jk6i+RfZbkGQIqau+LpGyPk6Iuwtvs9nk149XzIhHj80OKoKr+1R1NYYpPwNABPWUCpHUYXjECbR9esA6g8GKrZVfzFpIqmHk58/hF1iag7Ajm8x380lGxHvdILPieVhRI8LmDpVkHUIFzVXJ+TZ5NmJS8b+vReEgJepq3SJQ+ry8FliuWRuGGx8vjQ2eYktpQPQT4sfcJbl9urpcgwabCZb661IzRG9dqTHxVbmkGeC+47Qr1d0dIUq94vMtR5bOt9wRmsPRLxgZmvy4l/2r7leZ8k2lkJ6q+OxA4OkGZt8ISW3iqM85Lj4W6OWdIVNa6s4tA91X7p2cXiFT6nVS/j7DKz1AXNfBwu1HcmCGqYAJb1jxJx6HcXcH9htwnHjee/v4LTbyI/O8bCze0ijrRVaoVoyKlTMUeDj2/5ntHMLxpJP0G/lg+z2BOotXmyBjBlSa6SwKUVb3fxBTnVCj7CDS6Xo457yZ6coXmyhCV7/QVM1yfjrTU6A7RwAFNq1KbcO8xJuxxZrhyGVfEXP8kTqJFaqlauSiSlmGrp0jCzVWrsfxNfXs70qt+JmV20/FIUpE4OtDZhfrFE/cZDMEnoJzpGF7li0C6Fd1iH7vTLnha57um0ecyyFXd7px2Fjc6aGFh+HgDR/ylrlSEcXLWuLXn1HclyxBIYOEL8rErkaocFLxGimn4ALmuw+TDRvGp1k6UPZ/7HyG4NGqk5QCqUxxId6HGTXgnybf7uE2bn8PJXNUArlTLzWu3QVnavlJmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(6200100001)(5660300002)(41300700001)(16526019)(40480700001)(83380400001)(336012)(2616005)(40460700003)(426003)(26005)(1076003)(47076005)(478600001)(6666004)(82740400003)(36860700001)(356005)(81166007)(70586007)(70206006)(54906003)(37006003)(316002)(6862004)(4326008)(7049001)(8936002)(8676002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 12:43:14.9860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0026c67-9ba4-4137-df86-08dc0934e42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722

PCIe r6.1 defines "TEE-IO Supported" in the PCI Express Device Capabilities
Register which indicates that the Function implements the TEE-IO functionality
as described by the TEE Device Interface Security Protocol (TDISP).

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 lib/header.h | 1 +
 ls-caps.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 58fe7df..47ee8a6 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -776,6 +776,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x3fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0xc000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLRESET	0x10000000 /* Function-Level Reset */
+#define  PCI_EXP_DEVCAP_TEE_IO  0x40000000 /* TEE-IO Supported (TDISP) */
 #define PCI_EXP_DEVCTL		0x8	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
diff --git a/ls-caps.c b/ls-caps.c
index 2c99812..65e92e6 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -717,6 +717,7 @@ static void cap_express_dev(struct device *d, int where, int type)
       printf(" SlotPowerLimit ");
       show_power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18, (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26);
     }
+  printf(" TEE-IO%c", FLAG(t, PCI_EXP_DEVCAP_TEE_IO));
   printf("\n");
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL);
-- 
2.41.0


