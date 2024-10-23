Return-Path: <linux-pci+bounces-15138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E69AD2A3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F1F1C214BE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E11F4707;
	Wed, 23 Oct 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2th9DCxs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E191E7C2C;
	Wed, 23 Oct 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704142; cv=fail; b=rmUO49oYHT0QqkhORsGOsP+goRyx/YHfqnj8BwWqfy0eoPwij28Wsh7TLlWqiXpvSp+Ur8hSHcOy6VBasWanTZAoEDd3SXCIppRBXJ2Vctkh/1s0VeJQFs2rDFkn8UY0/Pu89vVCAcY6bCg+TLGepkMoRoARSKIEDKDrFczw/l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704142; c=relaxed/simple;
	bh=gtlFZIqULmZBMN5jWLQXJT6lBpkx1Crim7NCPuKwsUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DL7dN2pVvnAO3iK0fTmR41jtLTtYONavpdSTWjPOD88SnnnGNmjhPnL5YIjnXqMsQHkxsPKUj5jDf71Lsmn8nms+QolT/lGmw4Gtpiay0+LPcjys8HRPo/sByXHuFfO2AYSHwKJfxdzW2MpWw+UALpp1iJV1Tw6W12bNlhvxKwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2th9DCxs; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgVdKG6DJ7FkrWppBnqqk6DEGyml7domcuUeG6mblo14/LE73PYi2uGROfcWaz4eJm8j/23va+5cOG5lCBTUf56bY7qvEB2/m7LbJIFAWelNvK3paB5WhRYtK4rvcxZkXZk9xotzAheDauh3ko6+Db9WcSDzZxg+9l5Uthu+MWw+ZRrsIcAeYNtPC4oEq9FxDNjHdGuieWuAihh/oTuj7PZvG0EUKmJ+BZWLnn09HOKX7sBo4HfuuuFbG46XHIoOsRqiJa178Mrqcl4T04A2aDFBTwatMzwuZkynS2c/Xk6V6WYtF8Gr/hoWv0LWcS5ddsEl0lRfMmE6vjRIFzld7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhyFuMik5UlE/DE0GG/U8a4SuTAQcB3Um8aJqXkkyGw=;
 b=E3/4tADTbvk0jGGVhNpuE4rGRFPb82GlyjmFiYgnHweQzHGhKn5HzGGrQwhbZ1TuaN1q/Pd8BBuanZMsQmLIIkFXMsjl0aYzgaWcFZUzZqs2TMMhp+06XXY6Uz0MyqlWs5/ArYzQcHRUxnWbJwwPckW1+C9nOklDrrz9hx5msYj88Ivs8gYZBnVDckw4EgAxAWXE4fjJ/AN2h8v1kLnkP501hQkp18H2JihmECEDZ6rsXaH1EVeFTPD4FX80if0i0KSutH5ZxWuceoHIwxDhv9sHeotwhKxOTHee5WYQ+XfPn7ndtAyiZTiN/uB2vRfHhfvL50fdYQcqjGqccwPueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhyFuMik5UlE/DE0GG/U8a4SuTAQcB3Um8aJqXkkyGw=;
 b=2th9DCxsxNgqtmkGIsyicI5eTyV5ofvNcPSn5c4mekPS7PAfKDCwolshe/IvU8s77oh+xwFLZt/NGIiANEGc2E/UQV91bHOQtNa2NDXuquiaEz5nLNf3NfOvBVKH3A8XqA5NVyO8KxFLuI7Pp8qqzrV3WNcmaNiN9uOhg9pQYsc=
Received: from MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) by
 LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 17:22:18 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::51) by MN2PR01CA0047.outlook.office365.com
 (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:18 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:12 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <Shyam-sundar.S-k@amd.com>, <richard.gong@amd.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <clemens@ladisch.de>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <naveenkrishna.chatradhi@amd.com>,
	<carlos.bilbao.osdev@gmail.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>
Subject: [PATCH 11/16] x86/amd_smn: Fixup __amd_smn_rw()
Date: Wed, 23 Oct 2024 17:21:45 +0000
Message-ID: <20241023172150.659002-12-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b4747a-72b5-48c3-5919-08dcf3873ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TNQ1Qza6meVHzs5tr3k/6x+Xy/3a+3CKhjAgpz+BdP9+bTnRcBSqSfU5v7W9?=
 =?us-ascii?Q?iWw8SA0TMnvW5mnFTXiUUvTD/8fysfeDeiuwbYd3Sq5xbnlaoe0BihwoCYAx?=
 =?us-ascii?Q?iLQxZM9ynIEdiADSujItDFUvkl7PV62bio9AiF+F7jmFk9Aa7x9c5uaww8Ls?=
 =?us-ascii?Q?QIbpj3fJlzwgIKE3zB9lIxmGBVWfHUMOu4rNg+FkrXJTX0q870qrXbTWikO8?=
 =?us-ascii?Q?rHN7Hc+fDVmsp3N+KOYvL3kz7EuGVcVBxPAhqKF8ThbKvgmjjp4LihVq5Qti?=
 =?us-ascii?Q?O51j5yEZsLf3KbTzzX9BxXz1mzMwsd/W6C1i5rw8oV3u+u++9aTVVPx1Q4VS?=
 =?us-ascii?Q?agGOOC6hp3QyIfdG6rLk5iBvpPZE6I4NnVstzwjRC3rYa0DOSGyJuteXoXbF?=
 =?us-ascii?Q?PjXXHSpHgzTJg+sI5sawrQViWDvn0mtCvfaw/lmlQvjjH9oQrtCDGp2aDptW?=
 =?us-ascii?Q?kzahxsVHBMqMsxMIy0mKpkSPCMX0MjbH4taykgPbuj/8b8Xhf6mV8bw4hdDc?=
 =?us-ascii?Q?NsA3oVrWq3CktXb7kr4hdlIqe1UHdVFpjEwK4g9aorDPRrSZF/KZB8mUo/D3?=
 =?us-ascii?Q?RdBTdx4UDLWhaFz+UrQ6ZVHD7y7YKxRMNAFIAXCy7GrVsba+34h/STRMQoil?=
 =?us-ascii?Q?TJ6j8V7THtGjis7U22GFvNGBn2smPkuz6rPWJuK69Pyc4+V5O7TqBGJXET9V?=
 =?us-ascii?Q?gwEb9ttAC3OiENv1LJ90zPJ8pdVtjjolctD66yrJolCZJnN7PGFqn6wsAckp?=
 =?us-ascii?Q?xWoC5rdj+CkmPK20/V4+Eh9L5lgkAuyGti6qCm6uWIbp7fsoee9c962FEA5U?=
 =?us-ascii?Q?YHr3HO77PXllYLmkL8mfWsVAsPnmJH2QnAB0wk+c9nm2lFPG6O94M+SSgzER?=
 =?us-ascii?Q?7jQzsFjS4Brc1qHcTw+auH1i6EiEdsAjyFO0RQz7Sitf1ordHMwyzUZ1pbo1?=
 =?us-ascii?Q?nsKDZhLyB4Z8gqJq/jHp1bDr+58mjdNnybVnIQ58M/+wIdRVZ64T5C38P1u3?=
 =?us-ascii?Q?g5qbonOKvg3uY9tCcjGdD2jvqr/PgDmlCYl26EK74oSttf/8+mVbIHjZbSDf?=
 =?us-ascii?Q?xLVzJleEXdK1d5Ia3721T0+116tmct/1chLU82WXWz/2ZhnR5eGoVpZFpaVt?=
 =?us-ascii?Q?gTwRHEJZT9QrFJ6tVnz7PlIQn/n+2uwaf12p05c12R8cO56fbiNJ+3j7703+?=
 =?us-ascii?Q?lI2jIQKBlKB2GJpbtQ/8aq8aMDe+KRMP0+2DpcIMwJbA3gntJd8PkXiMxDJB?=
 =?us-ascii?Q?YJ49b2/89BN8TYC9kVWpFI0K5yB+eoS57l0pCY5gX1Rw2Gk6uoXEogi5X0et?=
 =?us-ascii?Q?czPV68qXtVY/ljLX48B4dD4afiotS2Z6sa0hJ0VS6uEKDdyKiDz+TgpIDx/h?=
 =?us-ascii?Q?S9iT9PAfbiH4a5XUz4hfJm8gWRgH7OBTxkw7KXB6+Z8BqCZuOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:18.0011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b4747a-72b5-48c3-5919-08dcf3873ee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944

Use guard(mutex) and convert PCI error codes to common ones.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_smn.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
index 06160a9e2444..e53db07d1a77 100644
--- a/arch/x86/kernel/amd_smn.c
+++ b/arch/x86/kernel/amd_smn.c
@@ -57,28 +57,24 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	int err = -ENODEV;
 
 	if (node >= amd_nb_num())
-		goto out;
+		return err;
 
 	root = node_to_amd_nb(node)->root;
 	if (!root)
-		goto out;
+		return err;
 
-	mutex_lock(&smn_mutex);
+	guard(mutex)(&smn_mutex);
 
 	err = pci_write_config_dword(root, 0x60, address);
 	if (err) {
 		pr_warn("Error programming SMN address 0x%x.\n", address);
-		goto out_unlock;
+		return pcibios_err_to_errno(err);
 	}
 
 	err = (write ? pci_write_config_dword(root, 0x64, *value)
 		     : pci_read_config_dword(root, 0x64, value));
 
-out_unlock:
-	mutex_unlock(&smn_mutex);
-
-out:
-	return err;
+	return pcibios_err_to_errno(err);
 }
 
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
-- 
2.43.0


