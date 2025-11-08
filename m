Return-Path: <linux-pci+bounces-40628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27758C42DCF
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AECA3B2E44
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6CB221F0C;
	Sat,  8 Nov 2025 14:03:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023108.outbound.protection.outlook.com [52.101.127.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D51FBEA2;
	Sat,  8 Nov 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610596; cv=fail; b=b4Dc1SfdO3G2oaz8J2wTUOUNj8R794qE1x+EkrWO3Pb//JIFtuJwu+5Zlp/5mLe4GqKgdasm6aFaYCKQMfbVIVIbrMfD4hBM+8YvXCVOMrdgvBNOns4BXLJDIX8rUQgd3Wtft2ec9JgYaNe+dpGvpQsUpvgywERYjKwM9jWU2f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610596; c=relaxed/simple;
	bh=PEfL7HCtbDHPpTBBl3f0Mrujw2hf06qHECNWPb2kCDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lt2sS7yh2QFb+/M23fyTta9LAWxgSdkyud7KeM5SA7rowxoG8E9xkD0wLWE3OO+apvLKnCusBhtjOLO2ff6oAVlm3bPk3rQievQKMcFKaaCLLPKAnBI+Sub13UHDRhbmiRqXJeOBTqX8DJHIudyXLcEzoEQVtxu9vv7AhUtqeVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2N95WvsV4609FCb4PETBxpzceRYypwXKBVikVblpx/afIaohE/ChjPQEL/fdl4JnZz+3YMddrQ21H5Dab3VjNo78Ge8OnYfbHEAgLm5GCIsVyu2j62ma17ZIiH8YgGJu6CN/scXVHTz6HPipSEcKusmVy8/TmB6CR34yxBWXf9aGuJjDDIF1C/m2yWoDcawzMD5+LWJ1XMXiBIvIsZnb6jU7Lecg+6Z6B9aAIExKzLxl5DW7Qiu34QfIL4yBERuGKXcrXlTj5CwxZ4jbWc3jfAzaD7ElqVZSDWaNScIRKiaALQAdRe2olliCG5h6sMTyp9mJ+a6gMmdV8kLVLylPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaqs6SUEhJOGWaN6/+rzZk9nGERm84PZqBOu5zbAoVQ=;
 b=f7Q/IfFTKCj/2b58Bvi4lAkTrCbUpSxALcR9xZ/BGyyeh95IheE2UN52CHbBuF3iNBfL/nypLPsfsdK+BQD0VxwIkCOXLyu5FB7Wji4Tv3W8w0V1SlRK+zW5s63H7FS6kQi2PlIRva/yQaejbCEU2Un8NvwYfGOL7ELw8i6KAcrtiEXFIJ0UOuHRDdKGF8zHAvkDTFLfq2ZOceWEYOa+4c1k3jZfI7y1kBuwLvHA3vZ2slXeMsDuuWAqmT3q616LwZEMMYlRFCtdwI+b7iibSur81M3LTthKitxgZrHZiBzkhkPn4KDd7MMrKSZysMfoS2rP6DOj3K+b1U6yJ9eWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::33) by JH0PR06MB6536.apcprd06.prod.outlook.com
 (2603:1096:990:3b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 14:03:10 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::39) by PS2PR01CA0045.outlook.office365.com
 (2603:1096:300:58::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 14:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 31F074115DE0;
	Sat,  8 Nov 2025 22:03:06 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v11 06/10] PCI: Add Cix Technology Vendor and Device ID
Date: Sat,  8 Nov 2025 22:03:01 +0800
Message-ID: <20251108140305.1120117-7-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|JH0PR06MB6536:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2ad984d-656e-4405-3fb4-08de1ecf8ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8RWePSguEuInuY15f0a4p3zujhqsDn2iplyKioi7g4LieAuxd/1D6q0aVTgL?=
 =?us-ascii?Q?L3TU9yUuGYXevjw1nwIWGO+Muj0SGstaET1Jnn2ZqRKCNugKLXCMGobMkoFi?=
 =?us-ascii?Q?DXjT/5/VlIc1ODtUiUy5Smpq19RiCuXf7eiqcGt+eWmmOYNmagnmljQ7O3zO?=
 =?us-ascii?Q?LnHixv686diE/6VbNZAeLpOS0eTfJCjOga1Cqiesqcm0Il8Tf83i6eQ3xeDv?=
 =?us-ascii?Q?h8J7Fk/ey53UbhwA9rfJ5K07HRdpO7W7zOLhI9vM2841/GKqj7OVaVLnj1ZD?=
 =?us-ascii?Q?SvKWI70GNwuzRg953F8YLUN9v/e8sRryio9LpFrVnyxhmgSZEhQ8QW+5MKGX?=
 =?us-ascii?Q?en0ROHvh6DDrft01+Qv8BotyE52aiudS8eBTBYPPoGCZV4Z4B1zTmp0lQCVm?=
 =?us-ascii?Q?NmCtZJyI/y2uPzfB4g5cj99dSVDAAQ6M8N2RwOnzqZ8M0nXgpS2AuUcTZpeC?=
 =?us-ascii?Q?OKwsXKO0q321YOoD1N1W51+MerLNLUh5jJCTC6R0eAw3t5KaPTtt1LoUBQ37?=
 =?us-ascii?Q?TODveisnDCw2kbXigR7BFOaGz0IECS9MOsJt6MBB9psUTHqIHQqFzRfol8Qi?=
 =?us-ascii?Q?WI1ZbteqLxLUXTJFRl/rCBZMAd3DeTV1+JpgORUR37JYII2gQ/GD/lYsqFmA?=
 =?us-ascii?Q?VA7OfrBYJ6FXeZj3PIOWprc4F5/G5Km6afItQYsFw88CmSqUvkuEyWN4e1qv?=
 =?us-ascii?Q?K9cuN8Kh77CJVzu7xy1vtZS5iNSkzNtlAwZqP1kCzih4zCErAP+kVtCH559x?=
 =?us-ascii?Q?LkDgmeMJhksYO9xkwpuR6XIp+85jGicMUTfSENfVP1T88cTyqBGwzzwR6SZj?=
 =?us-ascii?Q?x4dSk8JS/qkT6BzVZEmsE/3SkwdIuLcUbapUMdxs/2/fgcKa11n0nualCJwj?=
 =?us-ascii?Q?C1gqDyioEfgqsP3a5BGY/hwfxMxFeg6gxEyY+LE3LDi4V+TxNBvDrkRDAWtA?=
 =?us-ascii?Q?f2kC/Ydn1lDOymqK+DdufrfefNBUhO0RCEHI1Aow5jLDAEQpmaGoJXAQoSkW?=
 =?us-ascii?Q?nwfGr2x7a/K9A2pcI5HSBkT+XyK5DR4H7Vr9oPMqo4HRiM2H/2Fir4dW1GAo?=
 =?us-ascii?Q?pLRgUuXlXQplWLaP6fjPYr/YZ9KGz35U77lMObUHTa+Med/jdgKcL042fp46?=
 =?us-ascii?Q?jgEd/fXHN3f7W9SA0ehHmwPFya9y+Sst1OOZP8mXNQFQnWc2/uKjALCYMFpo?=
 =?us-ascii?Q?7exdJOH+Hl6T9DEcYBNugLLdk8ETkqHj3LYB7BkUg8z6FsfLZ6bGCATaDto8?=
 =?us-ascii?Q?UQO9EYeQbTJbyO4jA3aVaRrR1H7tiQZFdTlZ9YuksGtD3oiu/LpM67JJaMh9?=
 =?us-ascii?Q?Y8wOEC+I8kTgndByk0Do48eBNXs14Yumi4LxpkzxtSFSH+IVtC5x8zp9hK4q?=
 =?us-ascii?Q?hqYVl9eLzyxm91COJVs/cSBwhrLWT7PXnsJkqhyAroEuGch8X03hQVWfvxoh?=
 =?us-ascii?Q?HFZ3YvcMJ/0DhC3d0t+7oh3w1OdJvk3y0eSJV5LNC6EgmQZttfikI9JjdR5q?=
 =?us-ascii?Q?drF+zZOr2YW8/h1JjKtFkOb2WCKNvsZR/F+xuLIgJOg/YqPDbyZgVgzxWWCE?=
 =?us-ascii?Q?tUwZQOejfcH34GecxTs=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:07.5510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ad984d-656e-4405-3fb4-08de1ecf8ba2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6536

From: Hans Zhang <hans.zhang@cixtech.com>

Add CIX P1 (internal name sky1) as a vendor and device ID for PCI
devices. This ID will be used by the CIX Sky1 PCIe host controller driver.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..24b04d085920 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2631,6 +2631,9 @@
 
 #define PCI_VENDOR_ID_CXL		0x1e98
 
+#define PCI_VENDOR_ID_CIX		0x1f6c
+#define PCI_DEVICE_ID_CIX_SKY1		0x0001
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.49.0


