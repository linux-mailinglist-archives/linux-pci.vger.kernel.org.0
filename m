Return-Path: <linux-pci+bounces-40163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B69C2E872
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BCF3BB63C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B60F42A80;
	Tue,  4 Nov 2025 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZcI+leCK"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78217993;
	Tue,  4 Nov 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215093; cv=fail; b=o+VLA+0mc0YFoYfrLDR3DZsyz7F7nz4gzakbbRP21G3IrjSZJX6ZWFmGK0/LhdavyJ7U7bOCRPWStdfIDjthitYlNDgVaKi39YWDjjeQl9fSCnFw9VLVm6mHK7X1jgZh80iRzrDnIHEbzg5TQeSDVXPfMWLIY/zDuILZRU7eZo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215093; c=relaxed/simple;
	bh=2w+yOD1BhVZNwwD+wm5q+m2cEvyA/WSNZXFso16XNHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1BzP2JXx6yAqGPVG315Bj0fK9CVivUFCn+abZxVoD++Q7W8yLwgwXplvXmzf3o6vgQgp1uRU0zgw0kJoZt+rZOgbDUw+PvM5yjvg2VWSsXLOJ9SpXdicVynfZ8JWOuREoivX4DHc6rB9rp7SzwMDA+JzuxNElvfQy5cH8U0qAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZcI+leCK; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izNBfueoUHzZWZIXG4bbQb17PaIfXSu4fkstiYtG52V44+gmxNEqSrAovqNYgtXyoVym3Sbq9KSdZZMsd6MFxYsxO7iVMC3Ojx9vdrLX05ykOCpsqcM03XonGoOdXcGRHRKlviGGDlVBy8wjUFG6pqBU42+L/4TQldCZxvUCOlOZzpr0ppEc9/v3K4DbiVDltgvB5TOfuwhKAFMHKgnXA0WTB6MVWgS1COQ48bikmQdvExxJAJMB8PE5rDNyaeKYNh4MMWghmdw7u+6oIYrdSM0d4gkVykQ603dpwqZl0sWtveIw4l+fWsSZR3UBfG3QEMPfaa83BnoPaaFs6ui6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS55YpMLGYOIbaZaGRLUZsL0mpY7hKYfiLkNbAKgy1Y=;
 b=a5Um6jfq2N/lvlYV8itLFT9GHrg0oyWA247+VrncjV5e9W8/eSp2LW5STVCKa5S2a42xRxfou6KSuU5loUdINa5aulylgEubFV9UU/DyBuJ1TzbfSKhu3BiQa6wZon8KqTayC1UFfzC34SGLoqwG9lIpvyKVBOw1x605gCUmTWuzAUG2TXTWBy+ex6IYFuQzxPTu1CnhDBK5lwC+tf2YC43J7J1LnU3cyfj7hPyRRSW0dAQjekxRsg/yuDa+/4pcTVH2SXS4DXtgPj8e+f2Y1jX0fZkrZqfxSXXBZHWAuTcaVhQOl702X+grzlgJHsll09orsKGrnrNGwHiEd6mD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS55YpMLGYOIbaZaGRLUZsL0mpY7hKYfiLkNbAKgy1Y=;
 b=ZcI+leCK3oaSab2gMwgt1esKP7wHw2yOvDRa98q19HlEY369InArJ3Z/NScvr9Ao7XRS+78mrw8+JDGTq2/G6bZwtwOn/1HNqAXaCbCQvVRBJrAZ7DTAloVlcEfSkaddqoR5vDLrkWD2cGe8jCwDI5Z7SewLJDqfA2+QcxK9jtE=
Received: from CH0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:610:e4::31)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 00:11:26 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::d6) by CH0PR03CA0206.outlook.office365.com
 (2603:10b6:610:e4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:11:25 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:11:24 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 07/25] CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with guard() lock
Date: Mon, 3 Nov 2025 18:09:43 -0600
Message-ID: <20251104001001.3833651-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c69d73-86b6-45c5-b354-08de1b36b19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HvYwcjeEEK6hez3ng/jDnSfnupgdLkMrJ7dWsjd2O/sHKaB8viZPQaU3jQ4J?=
 =?us-ascii?Q?OF77j8PQ7JfG85yeTjMRJsVb8c/gx8Q7c9XEgg54FJzjl9AFhKffD1WoUVMh?=
 =?us-ascii?Q?8ccruEdbkz53Q7XxiXMOz0+31tlkWgCNiiY9+DJ9qICDouEZROM3i4JOLoYI?=
 =?us-ascii?Q?h6Vplc5cixOarmeGXGkZk4EKjdCL4//73GGnlwcvoaTNLRodjMBizRhK3SwF?=
 =?us-ascii?Q?+nWdVhO+af7/soOp1++RHbE8Sdr05sLfpy/BB9kYuDCgSBExjNie+X89azSY?=
 =?us-ascii?Q?bLbGCOtsPjdpOws3R7z+pSij4Kb+CTFMVq/aoLeYK3jBcLBe5th8Pf0ox1QY?=
 =?us-ascii?Q?WgycLZwYiQuQ7oP8AmaNs20l70gG0+EmT+POCHdY4sm5hBjkQRwbygU1d58o?=
 =?us-ascii?Q?LDZ0FOfyEFS8jpOdQfTOyI3DhyUsqN5Aaxa5q5qWJbz6y3uhDbL8nE26Jftb?=
 =?us-ascii?Q?HGB4K/84NvBNMcf9YBmw4OYTSG7sxUcX3ZbUnC25bEt1MXvjattaUOkP/lfX?=
 =?us-ascii?Q?6Be1pp3+10IOsJEUVvL5cXrJ9IsJC8MwHHHXIiWbNtjTFhW8xRP1ol9QGGzW?=
 =?us-ascii?Q?C89+y9KjGPNYrKrTpBuc9nNpQcpK8k2kBV7ZLgEcp71pgKH6W5Z9A/FUtF60?=
 =?us-ascii?Q?dk6FoXvnGqTHdflD0mtzqPL7aumt7YHtc+qROG+/pKWuitNJM9Gp6FXG3VzX?=
 =?us-ascii?Q?Jhn3OZYra5xOUiBTeGfvyMTA2erpYEJI+Da/lN3yjUxhrtHuaTP4jwslHIYF?=
 =?us-ascii?Q?jp0XwCkVm0UJd4aWrJBcYrHHJTJvitD4CyYdWh+dR9/DosNhn4NxqBSzMRvt?=
 =?us-ascii?Q?w4MgMuatyAn1a+q+komJMb4zpV1RS7p04BT1/0gAHdJMn1FmDRwpbuXMkiB2?=
 =?us-ascii?Q?EloFCrdAUsL+xMvE/3pVVgymmx/YzJzb++0i4vaqVCN8GsSfAOWqTTQhinK7?=
 =?us-ascii?Q?Ea73L3nIKX2I4vA7HG2L5rxOEPuvjjm5aX+AZeGNqCUHD18lGuNQtML7+29N?=
 =?us-ascii?Q?AoOtgROExd9ZlV5NvjIhp7SNcixXqn92c/JmocWQaSKDwmCoWVV7rYxyzT4x?=
 =?us-ascii?Q?CTrd7qtwydbt45hInk4DjXzuFuYi+VZ4ONfm1oUAZo7QhOq/mY74TGoU5RGZ?=
 =?us-ascii?Q?fpvqCf3XEwdBANQebFFxcWvs0h63/rRG0c31GbboDiOBC3MXoGL4P+FxHIIY?=
 =?us-ascii?Q?JgjThAZj8YIrdHn8ALHQw0LZCe73awEACtLmgJGGvm1lucolaoNUj9LlUoCW?=
 =?us-ascii?Q?sFhZYSCdVSdihY6W4zdgO9n9/xRCugOA8yPD8CsW+q4YT02O+mmn5+6B3+QK?=
 =?us-ascii?Q?IJ7vi8u3yt36DHX0Yf2ggV0uUAJBxi3R3AmZUUwarP0F9dnPF7OhZW4ZNoy2?=
 =?us-ascii?Q?L/WtNITtDXQ1YweSSpxKag8UpdRYLYRFKzSUxN3FXVsfks0kxWLac8SEvvNm?=
 =?us-ascii?Q?OGEYm9k1MDm3vaFuYIlRXPf2tArI9TYP0ECQtwb6oWe+A0Nyu+2VEkiqku4s?=
 =?us-ascii?Q?nQAtnA7rSGghQUyvW+BzuDXmg+RzV429gkG6O066KWWOHLrjYI1u35R+3WcB?=
 =?us-ascii?Q?odiYuLkTBE+/u2l7Ras68302jFHN91x+j7alNWbb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:11:25.5120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c69d73-86b6-45c5-b354-08de1b36b19f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

cxl_rch_handle_error_iter() includes a call to device_lock() using a goto
for multiple return paths. Improve readability and maintainability by
using the guard() lock variant.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- New patch
---
 drivers/pci/pcie/aer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0b5ed4722ac3..cbaed65577d9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1187,12 +1187,11 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
 
-	/* Protect dev->driver */
-	device_lock(&dev->dev);
+	guard(device)(&dev->dev);
 
 	err_handler = dev->driver ? dev->driver->err_handler : NULL;
 	if (!err_handler)
-		goto out;
+		return 0;
 
 	if (info->severity == AER_CORRECTABLE) {
 		if (err_handler->cor_error_detected)
@@ -1203,8 +1202,6 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 		else if (info->severity == AER_FATAL)
 			err_handler->error_detected(dev, pci_channel_io_frozen);
 	}
-out:
-	device_unlock(&dev->dev);
 	return 0;
 }
 
-- 
2.34.1


