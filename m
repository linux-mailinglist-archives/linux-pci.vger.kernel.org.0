Return-Path: <linux-pci+bounces-15131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587BD9AD27D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EDB28217B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48FA1D0416;
	Wed, 23 Oct 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vkyuGYsU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7E1CF5E6;
	Wed, 23 Oct 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704131; cv=fail; b=XxtPwv1s5kxc/4/gEFAqHHtO7kqG5dbxIuLpTf03BXWWZNQMxGpngDQjwMQLqeulXEYztHJ/3G/Bglq3nK594kZmAhr9TyEX7a53rN1UOrzkcgoCGyRTW38nbDe1bTFPCs+qKExxlH1Ffl0fpl3Sm3839co8hV+XvqLWyG1uSkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704131; c=relaxed/simple;
	bh=OQxfHvFjuuNlVIxAhZTsaJrJUHybixhHLmQg3InXlSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tsf3vDDlXWowDxAkGm+P/rkExOM0UDl6uLkMt4SUzrsUAKEQH1S8SjVzPKUDtQ6i9j4TG1g4zaSdDFnv/kuVQlyBZd4vVrRj7pJCny3sblxaVEU3KmgX0c9FtQmL6Dtjgq1qhiVL/nk8I9lOA2a4pHMQ9DLQkPgMe+p1kNsppXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vkyuGYsU; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bbeui+/xRXpb2vgCUiG+EiK0W8a24+TFhlxugY0NumQpO/FDs88rxZW+NEQqg1DHuQiwfVFdIj7fqMfkl8vFwsLs6XxKDvlzmiZIwsp8Z/Eir+ghejMnU6CgHSkvb6B6QGRAlk/XB2JR+yNsZBSPDqGp8epc5BSTub2+WvcgcV6MC4sy3ZvTZ706srKSoPv2FArF8ZTk34SzXflXaxyqSCnfmyarUbXREc8lnaf0C5CV7aug3W5tzaumqnCaTc46SlGmGyDNOCKovhhBKg+VynOiTINeG4lewXZylmdvDMD4CIaTWYTpv1qoWgeVJkZjQyTBDK/VN4oxfZFD9iQGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E18zgn1p3i/bkUeVRfSrWl7ziS2hVjpIPX/yFhMFfXE=;
 b=Pee7o1PDjm7OmauGx0+XvtCmswtnSHfckX/5oJ2j0FGdCnc5hmIbXUSKUIvydA7qzJMi6ggu+luH2e7JvKBXQmemMiKKenleV39aP3zaDHuNS9gTrstF1u8/4YeMwAE/0TsVa5+H+oUNBaggj3SVO2hjm7uNcggpLOTMhL6HSxQX8JsoqbjGaEkB46CgNZcxBJs/50Dnw5k1wKi2Krj657NYxiChPAz8J0CfN/gpmr/cpUBxzpmUaG0SmmfafKmglkrheHMHAlCerSj13cKcP2hYILMJlc1TfTPSDrJ/cJaqV531JolHoQXsK5ZBXvO/vXo8a4BpS68Ener/07VVjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E18zgn1p3i/bkUeVRfSrWl7ziS2hVjpIPX/yFhMFfXE=;
 b=vkyuGYsUxxZSJoD2PG/KQXH/1HsRm5GJYhTmpxLXf20pg/su+vKPKv5IJoyvUjBkD7koWNY5S7KwIbjGA/sUg5ajhABtuVvL7YLdaHbbecG5ou6HyLUa6p/WmZzRokFNE+vKTxHg0GEWdeHdopw8hG8gzjAC6fH6V0fucUvY6cY=
Received: from BL1PR13CA0104.namprd13.prod.outlook.com (2603:10b6:208:2b9::19)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 23 Oct
 2024 17:22:06 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::7) by BL1PR13CA0104.outlook.office365.com
 (2603:10b6:208:2b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:06 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:05 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <Shyam-sundar.S-k@amd.com>, <richard.gong@amd.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <clemens@ladisch.de>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <naveenkrishna.chatradhi@amd.com>,
	<carlos.bilbao.osdev@gmail.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 03/16] x86/amd_nb: Clean up early_is_amd_nb()
Date: Wed, 23 Oct 2024 17:21:37 +0000
Message-ID: <20241023172150.659002-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023172150.659002-1-yazen.ghannam@amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 06215daf-5333-43a6-f8a0-08dcf3873809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yE7fDts+m4hehzna89ilUkeE9O9tdVC41tf6Ncr7P0Mq1BmlSesixMPUe0vf?=
 =?us-ascii?Q?DCRhL8/yNJy1FHcFM2sb69tkCh3+GzSMQTpN12mfaO1yhFWhU2BaUUn3wjo6?=
 =?us-ascii?Q?1FEWmGBYQg+A7rQnrTTGiTl1o6p9mrz53gRga9MNqLoDMiRi94Kt8A/sHaUO?=
 =?us-ascii?Q?AJuHP37xr/6vmr0yh7ztCQmsikRW3ed0oIdZ1Ffc1QJQVAphFjm8UMvmLXEE?=
 =?us-ascii?Q?7NdVw7zzTWEq+jY+/iUZzlChBx182cg1TvUjsOEh4Bpw4MxFu6NHOZxd9nFA?=
 =?us-ascii?Q?pLcNmtGB2uMnpQlcQndS+cAddaJRXr0H0BiALKQ8OqjuPs1/05sd5ASj5Qzm?=
 =?us-ascii?Q?ELP8G7eD9z19d/GZczkq2JmUq5kv5cUbd+qd/UnCope8tzbc82WwgT2hnPiE?=
 =?us-ascii?Q?1c+jj+1p2O3iZ1D0CAvnqWIQBFVofkjksf0a3LVfxhzJeZfFd0gQNK32Ppkj?=
 =?us-ascii?Q?eQ0uhqlAJdhVjLkuLj/X+hcb3oX24nSpXVCqxfwDlmEacC4CUTEW2BJWxdvD?=
 =?us-ascii?Q?Fs5Ed+8sylYht18rSqVQ4fYITa8b319Vbhl86KgayX4pJBw1j7FFKz7RklGS?=
 =?us-ascii?Q?9iNgbBpIEf020T4B4MM3aq4VnCgsvmfxwiMR8pJ1Zyl8/oVKTPrg037knBDG?=
 =?us-ascii?Q?TjTEWqG7yrxMfz7TigIEKc0m1HAvEi+LDb6d68BVNT9IqK7U/Wv0z6TpMqnh?=
 =?us-ascii?Q?cGvYUF3FUfyYUdDhx9pvt+l9ae29toLFyuRXTlzCVzdOTTUUmAni3RjYrxHE?=
 =?us-ascii?Q?xYttmyZpJgAzrr2+TF1wCDoNbLM3dQiyS4q3l4uEIJz3Ze8VKzEahAhXaaIk?=
 =?us-ascii?Q?HLnMhClEGHUhrc8HIhxwdEX/7s6rquWwv6/tXUTdEj3+PUp/agaHEPfKSkPw?=
 =?us-ascii?Q?JLDO//zcoaOdwAS6F1P+h7mL62PzUgtBlC9beXONYlYQxyNJerwp7vktx6r8?=
 =?us-ascii?Q?v3l51Y5ByYKa/TdjmnUFvsGMhSqC3up7YPDtO6RynusAHgCUUcBPBcxgr/oW?=
 =?us-ascii?Q?719VNzfMczuSQjlE4jQV4FOG1qRrs+D/cb9IMSe1udQEf6+8CSl3ZvM/cSZA?=
 =?us-ascii?Q?3tjEf0ENdu+rAsg9s3XAWzkPocnp+K/VOqRRfNKb+77j6fteSu+/NClJOidI?=
 =?us-ascii?Q?ufXpJcEB6PEGupev0T5bFa4TkrdU/WWQWGMZV76xSTTtuhzx5i4ywQxTR0Gw?=
 =?us-ascii?Q?XZBhKOO08g2tQqlskjOVzqspJaHRHOFFS3dBGSYqc/mcsgp/weMTzj7Giu9R?=
 =?us-ascii?Q?JTnXRjOtizi5M6P6ILLdstyMZ4Irxf1xXHhVRAzxUXgAUBUnnjD9fhfdnJcl?=
 =?us-ascii?Q?JNbQDJFZo1P+Ml2pKvySHZnqKMEZOsAZvocuED7LLij3VZCsWnlxSBOvldHq?=
 =?us-ascii?Q?71OVcofezK3T314Hz+0zu0yRJuV9c5Bt5wMbneIcFiKUrX/QCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:06.5298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06215daf-5333-43a6-f8a0-08dcf3873809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863

The check for early_is_amd_nb() is only useful for systems with GART or
the NB_CFG register.

Zen-based systems (both AMD and Hygon) have neither, so return early for
them.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_nb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 37b8244899d8..65884d0613f8 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -385,7 +385,6 @@ static int amd_cache_northbridges(void)
  */
 bool __init early_is_amd_nb(u32 device)
 {
-	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
@@ -393,11 +392,11 @@ bool __init early_is_amd_nb(u32 device)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return false;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		misc_ids = hygon_nb_misc_ids;
+	if (boot_cpu_has(X86_FEATURE_ZEN))
+		return false;
 
 	device >>= 16;
-	for (id = misc_ids; id->vendor; id++)
+	for (id = amd_nb_misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
 			return true;
 	return false;
-- 
2.43.0


