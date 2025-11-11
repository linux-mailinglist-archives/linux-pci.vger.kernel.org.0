Return-Path: <linux-pci+bounces-40828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E07C4BB30
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E17718936C3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773E1305E1D;
	Tue, 11 Nov 2025 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MtgLAK/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F92741DA;
	Tue, 11 Nov 2025 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843232; cv=fail; b=jbEAMumwcQvrk49FaVxM9LWkRinOF3YjQecDUc+dNU3/4bH7Jpq1i70DXCSv/mGppPqeRDPTzi0YkT/aU70V5nE7PFWwjjpNp5AaizJo7LR8ZZgiJCJKF9CiMHGTT2tbz8SpzcBLBG0hWK8mSCYSeesDriOgY6gWCQHyC3VYrDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843232; c=relaxed/simple;
	bh=3Bx5GC77+niP9YmNxKI5EglJRbILnjAgF5IqxVxZLq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2h3amfIRr3KrA7Df46AtQ0EUr/lSeARdyhr6hs9CP/eyMgfD3qJbMp7eU53XR5L9EcU2i00Dv7L33ASL3D1XJftGvzi82u22oQ2R6GL7sC/wGK9qR9eqEt6IpNJfbI+tgbEzVCvG6cV4pQigvntNwl1x5jWZFijsPMo7g19hnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MtgLAK/w; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdJNMMX0kOFMe83LBbxQcdcbVdHsWbm9bSSErhtFThFvTz1Mjxqp9MZwsohy9m7e7fRqz8shNwMCGvGnI58V9LRcTE9h55drv3U5IPfGvYw3PCf1vQOfj4HdEpX6wEKHXugheSKJtdMZUHgqo001wmggf4w5vABUWxtknQsD4DIwywpSsJk/ynSn1LMGtQfPyeEqb1gx0+afz2Aq5LDpIcaA8HhxLdNJKMPEJfd3BY/jGvGpIjOdaagEGgnk9UGi07gmy7yuA62KK8JEztK+uTdxXHzejx4tglo1XpDyYtN7PUdY6fgK0ntItBo2xx7tfRk+NaoJG0aHZ1P6RRH7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nP+dMIFDG+myOHYYz/Fg+ryGEGWIX44EJWkanthjmI=;
 b=lDoS7u6ioLCFoCX7gX4si0opLY79/CJEhGH71yFw+ZY5697e/CCUkCHusx0wByhXIqH18NMbluqWti4Yk4PW6mGTsZl8Fefi0l5D6tKZcH40IIS5nklGKmEer63IYORV4hSV6EuvDD2oJEwBtdVL67CWA36Jb+ZSFHLGk+39Bl55+V8QjcwTPM8FYmNVaUxXoeYP90xFmiCOURW+9a4CL899nf3SOddjSyO2Mo0NgFwIzqmxO9/2dkUvUcwcRZFV4lP1Rq32nHUfgnbj5kX4QYAcaSxK0JxP3oCFGHwht4WQv4+6StbWh46qweFBpYC7Dl7iW1EM3PCTJs3NWvXMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nP+dMIFDG+myOHYYz/Fg+ryGEGWIX44EJWkanthjmI=;
 b=MtgLAK/wRVbtF/SZFyS4myZUsh49Sydh2KN5kduM2qQFHXp9k4GM/kUSMYnt+NYEKFec5QJbpOfvlqSUBCD/J0HmqopyUfIe8Yjz9f9jmN8OV/Funp5G/l0n7pISaE2T23AUzWEKYcqBOnzPRBnqJNHJoHvjSbrdZh8eGydOfkU=
Received: from CH0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:610:75::8)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:40:05 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::88) by CH0PR04CA0093.outlook.office365.com
 (2603:10b6:610:75::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 06:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:40:04 +0000
Received: from aiemdee.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 22:39:50 -0800
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-crypto@vger.kernel.org>, <linux-pci@vger.kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Dan Williams
	<dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Eric Biggers
	<ebiggers@google.com>, Brijesh Singh <brijesh.singh@amd.com>, Gary R Hook
	<gary.hook@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Kim Phillips
	<kim.phillips@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Michael Roth" <michael.roth@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Xu Yilun <yilun.xu@linux.intel.com>, Gao
 Shiyuan <gaoshiyuan@baidu.com>, "Sean Christopherson" <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, Alexey Kardashevskiy
	<aik@amd.com>
Subject: [PATCH kernel 3/6] psp-sev: Assign numbers to all status codes and add new
Date: Tue, 11 Nov 2025 17:38:15 +1100
Message-ID: <20251111063819.4098701-4-aik@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111063819.4098701-1-aik@amd.com>
References: <20251111063819.4098701-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 606af4f7-7f34-45db-d123-08de20ed25cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i6+5V/e4rl72iVqC3vZUO6p6YrfV3/WOFAYfh1JqT+7H3ramO8ETdDS8dd8R?=
 =?us-ascii?Q?8TczDfTuT1rlwHAQ1xOGJaZJQ9KAIm+eUKPtPgciy9oBlzGv9fz7VPcOyGEG?=
 =?us-ascii?Q?dKc5ZloOz5QD/VE4c3JPyo7itJdsAGWYewb/uTSo4rheaDpir7NrEth5EX+p?=
 =?us-ascii?Q?XvRjRx+vkDKGo67Q9aaFD2FkZamHnKZ0GUPqwwLgnuiYQdgnaV+ZrIvdr3G+?=
 =?us-ascii?Q?xOnzs54QQtT9KgcjdUu8Ff4zpip+pnkDZOgIXnY/gG5KK7I7+L93etpJ/luS?=
 =?us-ascii?Q?oDF6Ry6NrIRJKOEo+58yYTXb2/PpxRK2ctubnkZQTaTaA6sPbuqJLCG7GaDu?=
 =?us-ascii?Q?Yd6Pa4TftqL0rgAkD807ncbP5x1HYATl+LeAYTfjlLwlwEnGsviRvsFBRmyU?=
 =?us-ascii?Q?RK7v6x1eEFdpMcSJhzQ+WkwExRhuAJYh1TR1tRveIFpT6CRH8WmEZRTLrlV0?=
 =?us-ascii?Q?xdmqbW3pp+nD/4YMH2ytvAuIPC35xAK35TFun2zKUyy4Y1Cyh0J2eQp8RgNx?=
 =?us-ascii?Q?NivMTybrwR0850UzyteNjEjAVVqDtdFj4aBE5t4ncbWE3AL3fE8n7fG9Wgwh?=
 =?us-ascii?Q?Vdvy5IoCNoWqdZfPZiGoqWbaAH4Wr/TmuqKPdMqtB5OkPcpFT847rG8QZvJ8?=
 =?us-ascii?Q?hGy6xsSi+AB9pGh4a16xknYzJMNKTtT7KthV9FhaDvLu00xbTgfX7lohXG9F?=
 =?us-ascii?Q?XueBjrRjI5QDHe5qr1jWaA46dmC020egP1nSLpCf3pKVrKehpMPqkv0pJRjE?=
 =?us-ascii?Q?YJnefSKGNOyatnBX+Ny3H2/Xc1kCkY2A9dW1UPdIzTLhGM6kV8KfXYB1GV7q?=
 =?us-ascii?Q?Jxn2AS/POZmNEN2tWbXlXoGssEuFyFgSzq+JP9kZu7ivZc9tw3aTI4k2YnYt?=
 =?us-ascii?Q?R7AQhjhJhARNe9fIksy8CM96W8F18V1mYy7IUx0SeJOMruePQ0K9Cp9DZInN?=
 =?us-ascii?Q?HhYZ4WAZfsRM96HTljElYfMhcQUBZAiNhGcW9ZceOsLSHal9E8Mb4/Jw6BlJ?=
 =?us-ascii?Q?ewVQ1xF8S7cWVUdsANm1eh6WWAew1iIYIKOnXquraFe5GYEYjxUKzMKXepLG?=
 =?us-ascii?Q?vQBB2bwbgguCILkU+QAll9myYGx2ACTIaF/J5NIEbmPbTZ2xktPmMDYzUwXH?=
 =?us-ascii?Q?vZbepMKltgFGddR9+Fjjr7QrBIP+kzOugF0JSknaAogxm3uJ7Gl2w+BiKp0Z?=
 =?us-ascii?Q?A49EDqNrk5D/Edmv5/u9LGjwocwoJ77fvfC5I/gRdPzG4bhdfw4cPt9KUEhc?=
 =?us-ascii?Q?ESrzcuBrd5PY1WOxJe7MrLY0EbDEZbXnRypaotRlR3xqMZn7/5MIbWBg7SeM?=
 =?us-ascii?Q?2V3XFJhR0K8g5etRaMWSm10tcCNjMIvaZF4UDIntW2ajTWCMGTAcBRYy5HhZ?=
 =?us-ascii?Q?zCNPdeBs5mgpmVGtChCO5YIdAc74kkR9BQMXg05cSFkg3izAPVlvfs8XpBHY?=
 =?us-ascii?Q?N7ZqE6qFh6U4nDxouU7sPelK3vJHJIVirLUXdRC5SNbs7X2TPcO3qvmKRLlz?=
 =?us-ascii?Q?qCahHmNausNNZdk4WvHmjCvKoP+FtV8PdRHNvzYb/4YAulwwVwQL5sr7rvqB?=
 =?us-ascii?Q?sqbmjnUQPRqMHxiE8Wk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:40:04.6177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 606af4f7-7f34-45db-d123-08de20ed25cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

Make the definitions explicit. Add some more new codes.

The following patches will be using SPDM_REQUEST and
EXPAND_BUFFER_LENGTH_REQUEST, others are useful for the PSP FW
diagnostics.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/uapi/linux/psp-sev.h | 66 ++++++++++++--------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index c2fd324623c4..2b5b042eb73b 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -47,32 +47,32 @@ typedef enum {
 	 * with possible values from the specification.
 	 */
 	SEV_RET_NO_FW_CALL = -1,
-	SEV_RET_SUCCESS = 0,
-	SEV_RET_INVALID_PLATFORM_STATE,
-	SEV_RET_INVALID_GUEST_STATE,
-	SEV_RET_INAVLID_CONFIG,
+	SEV_RET_SUCCESS                    = 0,
+	SEV_RET_INVALID_PLATFORM_STATE     = 0x0001,
+	SEV_RET_INVALID_GUEST_STATE        = 0x0002,
+	SEV_RET_INAVLID_CONFIG             = 0x0003,
 	SEV_RET_INVALID_CONFIG = SEV_RET_INAVLID_CONFIG,
-	SEV_RET_INVALID_LEN,
-	SEV_RET_ALREADY_OWNED,
-	SEV_RET_INVALID_CERTIFICATE,
-	SEV_RET_POLICY_FAILURE,
-	SEV_RET_INACTIVE,
-	SEV_RET_INVALID_ADDRESS,
-	SEV_RET_BAD_SIGNATURE,
-	SEV_RET_BAD_MEASUREMENT,
-	SEV_RET_ASID_OWNED,
-	SEV_RET_INVALID_ASID,
-	SEV_RET_WBINVD_REQUIRED,
-	SEV_RET_DFFLUSH_REQUIRED,
-	SEV_RET_INVALID_GUEST,
-	SEV_RET_INVALID_COMMAND,
-	SEV_RET_ACTIVE,
-	SEV_RET_HWSEV_RET_PLATFORM,
-	SEV_RET_HWSEV_RET_UNSAFE,
-	SEV_RET_UNSUPPORTED,
-	SEV_RET_INVALID_PARAM,
-	SEV_RET_RESOURCE_LIMIT,
-	SEV_RET_SECURE_DATA_INVALID,
+	SEV_RET_INVALID_LEN                = 0x0004,
+	SEV_RET_ALREADY_OWNED              = 0x0005,
+	SEV_RET_INVALID_CERTIFICATE        = 0x0006,
+	SEV_RET_POLICY_FAILURE             = 0x0007,
+	SEV_RET_INACTIVE                   = 0x0008,
+	SEV_RET_INVALID_ADDRESS            = 0x0009,
+	SEV_RET_BAD_SIGNATURE              = 0x000A,
+	SEV_RET_BAD_MEASUREMENT            = 0x000B,
+	SEV_RET_ASID_OWNED                 = 0x000C,
+	SEV_RET_INVALID_ASID               = 0x000D,
+	SEV_RET_WBINVD_REQUIRED            = 0x000E,
+	SEV_RET_DFFLUSH_REQUIRED           = 0x000F,
+	SEV_RET_INVALID_GUEST              = 0x0010,
+	SEV_RET_INVALID_COMMAND            = 0x0011,
+	SEV_RET_ACTIVE                     = 0x0012,
+	SEV_RET_HWSEV_RET_PLATFORM         = 0x0013,
+	SEV_RET_HWSEV_RET_UNSAFE           = 0x0014,
+	SEV_RET_UNSUPPORTED                = 0x0015,
+	SEV_RET_INVALID_PARAM              = 0x0016,
+	SEV_RET_RESOURCE_LIMIT             = 0x0017,
+	SEV_RET_SECURE_DATA_INVALID        = 0x0018,
 	SEV_RET_INVALID_PAGE_SIZE          = 0x0019,
 	SEV_RET_INVALID_PAGE_STATE         = 0x001A,
 	SEV_RET_INVALID_MDATA_ENTRY        = 0x001B,
@@ -87,6 +87,22 @@ typedef enum {
 	SEV_RET_RESTORE_REQUIRED           = 0x0025,
 	SEV_RET_RMP_INITIALIZATION_FAILED  = 0x0026,
 	SEV_RET_INVALID_KEY                = 0x0027,
+	SEV_RET_SHUTDOWN_INCOMPLETE        = 0x0028,
+	SEV_RET_INCORRECT_BUFFER_LENGTH	   = 0x0030,
+	SEV_RET_EXPAND_BUFFER_LENGTH_REQUEST = 0x0031,
+	SEV_RET_SPDM_REQUEST               = 0x0032,
+	SEV_RET_SPDM_ERROR                 = 0x0033,
+	SEV_RET_SEV_STATUS_ERR_IN_DEV_CONN = 0x0035,
+	SEV_RET_SEV_STATUS_INVALID_DEV_CTX = 0x0036,
+	SEV_RET_SEV_STATUS_INVALID_TDI_CTX = 0x0037,
+	SEV_RET_SEV_STATUS_INVALID_TDI     = 0x0038,
+	SEV_RET_SEV_STATUS_RECLAIM_REQUIRED = 0x0039,
+	SEV_RET_IN_USE                     = 0x003A,
+	SEV_RET_SEV_STATUS_INVALID_DEV_STATE = 0x003B,
+	SEV_RET_SEV_STATUS_INVALID_TDI_STATE = 0x003C,
+	SEV_RET_SEV_STATUS_DEV_CERT_CHANGED = 0x003D,
+	SEV_RET_SEV_STATUS_RESYNC_REQ      = 0x003E,
+	SEV_RET_SEV_STATUS_RESPONSE_TOO_LARGE = 0x003F,
 	SEV_RET_MAX,
 } sev_ret_code;
 
-- 
2.51.0


