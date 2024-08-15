Return-Path: <linux-pci+bounces-11699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCFA9536CD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0A28A8F8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 15:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E721A76C1;
	Thu, 15 Aug 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ki1V1irM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AA1A76BC;
	Thu, 15 Aug 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734805; cv=fail; b=X7nkXFff3tJ6xle9ZkDuRtSkJagBis5C/6aUirRduylIMOQ9S7ckO+/JcAfk1y/FryBPE7SF+oMtpFA2sCVh3kUhP+ZEkwnTFBnLsjaNMEDrRo4R8NVx2ZbxTDUehKJ69+a7sbaNrNee5KtHqiNhHdro8q6vri0hJFEazJa0nSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734805; c=relaxed/simple;
	bh=tkIJk+QAna5eL0EAoqfYhYJ5sSP0r4V/SiX/CRaz9ZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cnmNauLrU8TF3J65V1yVezqKErbFmESlukX1AvAEnBk9LG0YYjIQ4mG/MaTwTmX1Qy+GC/ueKaMOr0vwjnf/CXdtWwzPcdhH4FM9FlxD9FUa1pB4nIGFukL2XG/0A9b3MKlpdJ/Oo2ISIhWTttbqS8wCTd0yi44eag3QD+N6yWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ki1V1irM; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNXiOpfxvWkCjY/WxKMkdYvFl2RQbM4Jw9NcLUtjK2TNP/Xfswof6DtLJYkgYTG1APXpVKD6TU7StVIRJcxnOdbyKYo2pRjL0gYnMXtGjU872Xxsgzp7MPjLbNQFtZ+2zb73Gp4HYgvh/Ucrlpe3frIXQ13VUkc1fOeIMlR0MD0/Q9yWgOLEnUNIMIx+75wlX5HCaQrrez0giWPbx+C4GlXjPlpwMIfa9MAVo0J61S+Y0LopgQ8ihW0s32oDWBryPdw1UsYDhvup8/LK36EC5ZYGrYdX9qCjt5woeS9dmPGe9xJFKbdbSCgktlDi9aAHuc8IoHnVan8Zf1FH/em9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7EwRvZ7LgLdlkt2WHyzOBKkRuuPjndYL4JVEB0Ni8k=;
 b=VfZx+0Yt1sHYiDJ8vv79Z4pf2zfN4x/LdlO8Dde8K7pRzUPysDfXtBU0JhnFgmBKtuy/tgYmSniKdk8f62lNrCD00oKZA8ybzAF/Hdqt/mzZhxjZMEQunTgk7w3dKpkPLySm4rXMkqjt50fX/aFdZtWOg6Rr5vT0DLjKbkv8dddS9F8oKW6aUgrzaldCwf3Gqa2FnfiS52G5UwFPwINtjtiEsYkxYUazXutBn5Yu2Yk4fZ9DZXGIlf1zZgf/CDeDHI4cD2Hs4IBgrvxVJZOoUqNpU2tCwcbuQCDyqlEcxQIBYv+vRgupL/bpLXidGk2ZPi88/XOnch/hNb4/Hf2ZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7EwRvZ7LgLdlkt2WHyzOBKkRuuPjndYL4JVEB0Ni8k=;
 b=ki1V1irM3L/OSS6NG178fzE4WpyPEunIU8Zsn8yuIGvv4HBBXNSPR6VgQ6sSoOJJ3+8B2qrhko+zn4XDRAghxrWJIdaL4DzRuedXo6rrwL4KVkSf0+gfc6b0Vm8EA5xE8JOJMxZxKhWW4b6kq9Vbl3FR/8G3//32zuiH9gOLpYQ=
Received: from BN9PR03CA0693.namprd03.prod.outlook.com (2603:10b6:408:ef::8)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 15:13:20 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::76) by BN9PR03CA0693.outlook.office365.com
 (2603:10b6:408:ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 15:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Thu, 15 Aug 2024 15:13:20 +0000
Received: from cl-16.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 10:13:19 -0500
From: Richard Gong <richard.gong@amd.com>
To: <bp@alien8.de>, <bhelgaas@google.com>, <yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<x86@kernel.org>, <richard.gong@amd.com>
Subject: [PATCH] x86/amd_nb: Add a new PCI ID for AMD family 1Ah model 60h
Date: Thu, 15 Aug 2024 10:12:40 -0500
Message-ID: <20240815151240.3132382-1-richard.gong@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 327186f1-5b9e-4c67-5f5a-08dcbd3ccc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTcy+BetJjMvMvWM2SblJHaCCTC03E+Mf5Fee3QWolu/iDIvmiJ10cOj3gUO?=
 =?us-ascii?Q?aLHcnjvgyr2rkK80N1ghp0CeaCoOOmSgWiq5tYl8LOHEU/Yd9rfDarmElfUt?=
 =?us-ascii?Q?AuFathaa7fieb0KBnJXREVGPDpVFLd/zTiZSKzhJ/kezNNaVWK1Lwr0jao6V?=
 =?us-ascii?Q?qGgIHfkTu/CxoG4cVHXFaeO/mX5fOQxqK2Rc44kMmsgBdf4mkkAb4FPe7yNa?=
 =?us-ascii?Q?HPSwLpgC+7M7AjyKYdEpMkOkdWul/Hq2E/Gg/PBC5/ExDKdeKMpAn+vere8P?=
 =?us-ascii?Q?sHCNatviOkK0NoXoMw+9Sv2EWnZvULLaT8/Sd1EPyNt7E3R72GOpmj50ap16?=
 =?us-ascii?Q?SL+hGkvSb3NcgEzALbePzoChyTG030zgS8BO3UC4QuygtXL8Grx2Ig32qbnt?=
 =?us-ascii?Q?yE/LrJHOrZ1VqxH/dYj/1VNromvtaY/bHcn6aBB/GkF+dIougMhKOich7gLR?=
 =?us-ascii?Q?YjxxITypTrMFSG9ouujY1bZXp+1V/Ag3ZH1LVccw3KvocckQGydE3lhLxX/0?=
 =?us-ascii?Q?ldoXn/eDn//u9j3mj6HPA4dXiF3HcsaNMPR8/f2sU+3/fZEC3Xcu9obXH4t4?=
 =?us-ascii?Q?av0xhaPKql32DydJ3YlrNWyqHoBed97uhFB7+QRhf2+eA3hAGvPccAHrCJtC?=
 =?us-ascii?Q?rCifA6yZF6KxD6JhQsKOZmXGNN9mb/OHC9HzdwJzg2/zDDpRlFo/U0UJu0Fr?=
 =?us-ascii?Q?fZWTL69hCmkiCElrTOMp5SrYXz6DvkSRJkxkfClEuJt5B5vJTEKeqNyiUvw1?=
 =?us-ascii?Q?h7bFwGUHRaESpWgxYijenPe5c0Bd2RU+3pfoDPLVnPp0UMdZt5XUWGD11Irm?=
 =?us-ascii?Q?72kVoNlKTVeW6m6ckfQAusMAwNX8o70ZUCyN7RzT4nlNNwxCsd0XqTeNI1gI?=
 =?us-ascii?Q?e4u3nhk9ttKgPd4c2MyXciboKworz792hLsNnLwJfPrd0gb78hWFxUa3jahG?=
 =?us-ascii?Q?YjpauxMDmb7BbceBJiQy2U8CQs8KqF5aUqJCBJhklwINVrXE0PGBnQQGcpuh?=
 =?us-ascii?Q?UURc1xJMyAe4m+W/AXvQ50CYOMv6eRQAi2xSEwL4THOYia8KMGaJ9utNR8P3?=
 =?us-ascii?Q?5f2DvfHidrgpTjXNENigCqCi5mJPyybqjngGWuWmt1mEy87g40I+XCOn99gV?=
 =?us-ascii?Q?9AamCIajW/Q9hdI+UFWfP+75s8M5RDDqBUDTWy7vo1cNGDlLolLkE0R9zkHS?=
 =?us-ascii?Q?DZGqwdcQbOMUBNxRr0HWI1iZsFOfD7XVnTjwRITtDFo2DDThnUDtMnxWTcaS?=
 =?us-ascii?Q?Djw3tK05RaKAlrKPaGXuniPZEldn3qcsTLoNm9hMvoq32w03TTi6rtMIAldf?=
 =?us-ascii?Q?Vv189k0dm6QhYXwFS+Tur+P5q8ZU6+P5yBHa5pYfZmphZ+/0lXc3Ewuqztml?=
 =?us-ascii?Q?sdlcKCpjjlHHEXizIN3T8icBS/cE/3g1t9yD+FAEfbLUrxT3c6UrglN9ertm?=
 =?us-ascii?Q?ft75v6quXfF5pOTHTR3xQkYuzTM1+C8I?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:13:20.4540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327186f1-5b9e-4c67-5f5a-08dcbd3ccc74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558

Add a new PCI ID for Device 18h and Function 4.

Signed-off-by: Richard Gong <richard.gong@amd.com>
---
(Without this device ID, amd-atl driver failed to load)
---
 arch/x86/kernel/amd_nb.c | 1 +
 include/linux/pci_ids.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 61eadde08511..7566d2c079c2 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -125,6 +125,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
 	{}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 91182aa1d2ec..d7abfa5beaec 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -581,6 +581,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
+#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4 0x124c
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
-- 
2.43.0


