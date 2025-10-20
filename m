Return-Path: <linux-pci+bounces-38701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F44BEF46F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A623B8695
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F02C0280;
	Mon, 20 Oct 2025 04:29:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023108.outbound.protection.outlook.com [52.101.127.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C72BE7CB;
	Mon, 20 Oct 2025 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934547; cv=fail; b=l/+/US3LRU6qfRyCM7AXAUKOBoX7LGb9jgI81mCfIK03ewNODMB+WnSoP52XRkHeVKgZYXhsTb0Fs/7a856GYvx4xPimR5CkT3b4hU2AUpGSqVsY6hFnwQLh/5qUWXDUkUPa2CE/wEW5aZ943kFlmhkIbLPtuaYeb7dxnF4OXWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934547; c=relaxed/simple;
	bh=PEfL7HCtbDHPpTBBl3f0Mrujw2hf06qHECNWPb2kCDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTCmI04jh65fCCJ7zT9XNelRQT/1iX5i0sxzqWLAwQIYhP9x9sug0LByzPONq5sMQ7KLK2BSK6KgJsXlE+SONA8bFQq2AnPqcABNU97Uq7Zc0Qjn8N5qc6Ui1UsbWna1SkbjqikOTCiSsuC5FGCIWsjiYwOIGxJjiBGI6wFY6oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHR+ul1qU21AbAvOzMkph1prp9xmIkpHFezMJR4RaF032oCsrqqDa3Tc96qS83yd8hoS/1qKYuIojVagmhDRdvZPOoCn7b44QEvBw1EWJplzGa2mBSPwMmdb7noNHOwK0E+EL/wGxk1W93lBaCLBd/P3rMUxYDICblbndfaysO3ZWRLZT4DueUpUbrdxITxnwGtrXNNO8ER8x+bFUbK9PdgzKybkGj84I4K5lHJyRAg0IE8UO2BWZx5wHP75/gJjiUDp19dsPcC3UN+aPNwW/rtSmFagZKTWLRFoCnjPwHll2Fne1FuZ57CmwePN4xCwoXSUYch/NTLP/PB0k5902A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaqs6SUEhJOGWaN6/+rzZk9nGERm84PZqBOu5zbAoVQ=;
 b=ygXALlWnxQfFzc8iI2DKTkThUKAqOAmrvFslJa7mhe25neTZ37cvU6pIlGvwjztFSuaoOjco9JWG+NBOjczdnc11E/1m8YhTQPKWfDanUgTZJMyV+MgRb3TsgM4x6AD7VNubBbPpqDYHk2+nuTwpJyfssb1Z9GfJ6sUO1gjva+dGm03YZh3p41qAdKVXdntd2+Cz1c0p5etdhVKTRfjJAmO2G9YzZFnLUbT0Wz34425TGKCqm9wOTkVTrMjpdG5QFvL4LMhFq6+fggSRKjV9lttNM17QFV72mAXjFMCd69RrHSYD0dSPM2N5uJ64ditEgErdJN5tU2qavzV6XE8loQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR03CA0009.apcprd03.prod.outlook.com (2603:1096:300:5b::21)
 by SEZPR06MB5989.apcprd06.prod.outlook.com (2603:1096:101:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 04:29:02 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:300:5b:cafe::d4) by PS2PR03CA0009.outlook.office365.com
 (2603:1096:300:5b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.10 via Frontend Transport; Mon,
 20 Oct 2025 04:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:29:01 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0731440EEE9D;
	Mon, 20 Oct 2025 12:28:58 +0800 (CST)
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
Subject: [PATCH v10 06/10] PCI: Add Cix Technology Vendor and Device ID
Date: Mon, 20 Oct 2025 12:28:53 +0800
Message-ID: <20251020042857.706786-7-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251020042857.706786-1-hans.zhang@cixtech.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|SEZPR06MB5989:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3724067c-c36e-4892-3284-08de0f9131e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ghU7z18VYvme3vS3Gz4+EG7i+nO5GTgOcEd2gjZGudBEBfQbIHixFOckd9lo?=
 =?us-ascii?Q?ziZQiIntajr5rkXezsf4+xdpWXBUXVxab/TfyySo5BBFqmDl1+EXdQSpAfNm?=
 =?us-ascii?Q?oVi8H3kU02llk8Lap3azo/etlWyI0+oPgy5CyjiL9D3ZP667O2IwMQn630K1?=
 =?us-ascii?Q?Erq7paNe8JlVqCyt97BRGiIbtQjlcPi9xqiKJKjHiZw+pVBbADBojONXxJIl?=
 =?us-ascii?Q?jlwthRjkJDASPDS3KEmHtjdv0QxIBkMAIml3VmHqanJyi3AfT5iN7xvT6QRM?=
 =?us-ascii?Q?zcboSUGTj5BClzJlpzLRPPcUdi/RUowRQbnxcobix0Cmud5zl+lcGJgRVgSI?=
 =?us-ascii?Q?UZqZe4Gte25r0ez7OENKPS96w9O6Gu7snQzOgtQ63IVi3n07qg8/5avdClFA?=
 =?us-ascii?Q?4X390/gWD/A7zK/+Q2hxEMiCCBCKoDaafvluSzfg0LCc/yguoGg00tcIk01N?=
 =?us-ascii?Q?46Zm25aPIKeJz2AZiF4oWnQjUyz/A0OuFkw4GrdrqFn68RGu3lUfo4o5n9C2?=
 =?us-ascii?Q?cueTA0ulBgOn7o/cdnLONiZcv7D9uvHmJrZ/jMBLyvSJuqsi317h8+GoRfjF?=
 =?us-ascii?Q?U0xhppBYDKvzWCwJ9nVKaxY15EDsx0OQ8QUT8s290g3an0TQbBDoIrlF41Ns?=
 =?us-ascii?Q?Q71/EuVozHDsvfNZ14tND4H+aFq+8DHcuEjtrt8vNifin59hQIXwDoPpclQS?=
 =?us-ascii?Q?rpE11qf54syCRs4XnXIf1XaWW6yg1E7DoIn7F4vc2MkDkB5qIZeGyPXQvhLk?=
 =?us-ascii?Q?Yog/uj7Pkz0f/+kLItiRI4UlfAFQM/zIvZKTkBj/6tX0FSHV/bRz6hYZ5lfT?=
 =?us-ascii?Q?Efhp7tI0pVOyKehobXgt7HckvQHq12GTiIrbTLLIlv87Wpr+LD+KtOcgZmsI?=
 =?us-ascii?Q?0Br7ZaNetRBzDX70M7jCMe1JeT/Djs2EyWn+frZ/qzZwud4Vu89nm8c+pVOS?=
 =?us-ascii?Q?+3qWNx6ak4Kb0jZde4EMkKrCHDJrq7E31LhaIaC9PybDf9cnwSLvGizg5JmN?=
 =?us-ascii?Q?TCZwPLJCcYqeJ77O7Ui+h9goG1B4Ewpp7YL8EDPJxA/aoVXQRbuZvOyV+m9n?=
 =?us-ascii?Q?yWAkwILlaD4WJ2Bg66jARbJ/G/PXgfg47TjEPBmKesqvDo+bFJmu41u6chho?=
 =?us-ascii?Q?iC2r6Q+4poUDZYnMFv4QwolKY8NxNBvUahRN/jVNhj644n8iu8LSSj6g3f1w?=
 =?us-ascii?Q?3E2JEFdF4sealDLgQXDgFOl257Xc8IQLcHVMnvlnfQQMUMYsdFRuN2L2uZQw?=
 =?us-ascii?Q?To7vnC1XZlckalyESjIxSQeaWCLoO7mY4QtydII/a9RepcMqMuZ32Vz5wRp8?=
 =?us-ascii?Q?VQhx/EpH5evpG6aotFMnDxFwz3uSKccICRnxBaRIApbGP0nxtytZihiO2Umo?=
 =?us-ascii?Q?GyahA6ZAcl0pbxHCH06mfHD7iL0n45hJRFe6lnGpKGJ0/D575OmoCoSTKdsN?=
 =?us-ascii?Q?+f3DevpILZVjojNeJverhnIwBR2rouau5Jb989PFYsi5EJ7CM036N+mXMkce?=
 =?us-ascii?Q?tULi7zBBkj6gwNM5IQcu06E/Cnkjyp084eSjua1gz3IfHYM9g96RTemzbGpI?=
 =?us-ascii?Q?3uo82h39WN1cbKpmGGk=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:29:01.2888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3724067c-c36e-4892-3284-08de0f9131e7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5989

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


