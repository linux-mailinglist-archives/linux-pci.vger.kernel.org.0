Return-Path: <linux-pci+bounces-15141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BEC9AD2B2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B90E2852B1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B51FCF78;
	Wed, 23 Oct 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAoY2xih"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266B1EC01E;
	Wed, 23 Oct 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704145; cv=fail; b=YFI3cMoYJYHNu9TBdswZW7+LjgrG12Y5pS7pHUaJAQBLs0hkFg8ZjzkMXx40sNwjVTMBuj4q1IzOZORTaNCpp5NLSO/rLaX062A3YgauSz0ADfpY2xTfjgEB8d0D90xkkLPeyojL/3D3BP1RHJDcFx8NXwwyJSIsDefUs/4kH5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704145; c=relaxed/simple;
	bh=Yj/pIVeDo3FsU9e/Yp/VpsmiBmMiEocYYARIncMNvTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKpYi4iZWzlzkfWefRgFqGwIchNXRYkxwGRPVsL5MicfRcPRivk1GXFwP/pv0pG5ZhslCC53CDH6wRD81eCW6V09Uh8/W3nHUoqyFaUt4GKT8N3zs1ZSCaAad+XYyWbIMjdLzkjB4E7PanYR6APhMJ9vU2zaBTUXiIZ1MWfXxrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAoY2xih; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es6zwu1B99RQUFVaLNx/tf+D2+iI6qVQht2CifVUprcw/o2yFC7sxjaSNlMyqZisNt1m2/1d/9Tsh2mVm/nEF4bmFXOiDL1ubgPQ8RQn3MbeU7L+Fri3J074GHXXXAKe3X+T9Asgiyt92D7v31aqcxtbWvABSZiJspqCMCDY34swfRamc7N+8/+gjTkly4qdsjhe6AD8HDiDE43b4NIF5uggqTdKLMfo0Vj5kZbtbYcho1mVYn0LDyogWxXxG2l/djD5bv/qWrT6BEAR0V/CuSxh45qVnI5ATH7dZCTIw0BykauQRbm85uXErZLXUINd7d9E8LaaUC/xuHcuIh2V+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5oJCTls20r7WkZcdgysfoYtNuwVRHW0WYr6jSyftkE=;
 b=rskLaIzti7CT4uOR8OYU57eGRjFQ6TTw4Ri9LvmYw3r+iWQAmh8GVi82Bck8uDToXGw7M7ynnkJxroGyOB1b8hTtqvcxgtcIwRgI9rey6Wpmf9NYHyH9H2RkpC7Bb/kquQJZ3Vvsu7aNI+tGik9R5EyMx3lcPaOyI6K/ZduFRKxnzGBrWZCbbTrT/QprQ7iPRwmseq230HZAdfOAVUwTCz9XWHom5SK3V9tWk/+z0xsbU4o36dBLqTul26FpUruVPTZdHwx0c9YcF2nT4+157vMYv0+M06PCRInpvHR+XA9C5Ad2QVebPUK76pOAkPk+Trg6hpTEXdl6j5IBMTc/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5oJCTls20r7WkZcdgysfoYtNuwVRHW0WYr6jSyftkE=;
 b=KAoY2xihmmIt5yYzZ9JAEAxg/PzNnn319f4TWWKzgSvij6tENyzoRVl/tUieyy/Q6BPxT2H0Yde0/SbQyXUNNeOui7iYhKzAnLEr3nfSIrLtTkutfQrFfIFtXAu0A0jFdopPh1MtdNOSRfubAmJWDdJgknAzZXEz0z4MW8lc5RE=
Received: from MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) by
 SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 17:22:19 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::cb) by MN2PR01CA0044.outlook.office365.com
 (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:19 +0000
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
 2024 12:22:14 -0500
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
Subject: [PATCH 13/16] x86/amd_smn: Use defines for register offsets
Date: Wed, 23 Oct 2024 17:21:47 +0000
Message-ID: <20241023172150.659002-14-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cad7825-5240-4cc7-8d1b-08dcf3873f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iwcc+gJ4C6T6jTF9lEjiTU30+qzbzg6dz5VMRuX07SkM0LFBw5Zllrb6iZd2?=
 =?us-ascii?Q?ElWRJ4Js8nSln0S06vuk8h8I9yDjU6yzrSJh+SZNMFl7d2/KlWczE6xGD5K1?=
 =?us-ascii?Q?d/vaD4cj0MG6XwhWZCasenY7PeJhrTZIOgTgxFroxFURUD6MZq12ZwQrs+Pk?=
 =?us-ascii?Q?ztBjbBMfTHkVoav6rgR8JoNTBmQ4t4Wj3CzOBBHbKj+CJN56V/4xfNOBKwcL?=
 =?us-ascii?Q?/CC20hygLMZEduGRpJiWNB9c2W80N6BaDOugaCoV8su0h4BjsHEIEklLqw63?=
 =?us-ascii?Q?e8Qb21SMMBJ2IZJ06RCUOyoetOtH1nrY+GNhDtHNlDNnrbT17YqbNIwpMTXT?=
 =?us-ascii?Q?opJyPCDx8apJ79Vm/6C8z8kq/FscTzDN7RHIq27lttM3QMAp1FxgWp0XxOpM?=
 =?us-ascii?Q?PYc4c9gWsXcqLQdOIW2nqkoWhMHjrL9MjNrijmssxwmmRu7B6NWk4dzMLKxJ?=
 =?us-ascii?Q?7C/rPcpnB2KuvM4fck0TeDLS28Hl+IuyLheRpsBRaRzdZgxlA9UipgjHR/LY?=
 =?us-ascii?Q?XyKK7U1+0PHYz2RaCAqX+mB1nHH0/18u9z1pkbOBYyXsoXPt4GcGaowAQW8C?=
 =?us-ascii?Q?+zW0qKQLx+VnK2e1th3MNGE/oFhJVN4ScVcBcWF8BSlUHqRFIeDAUxQRm79o?=
 =?us-ascii?Q?2zoVGvACC+JYFuJxMYx4ZOETfz0LXFtWoapKTUXVPUwPD2TGpvIYNIHhpMlP?=
 =?us-ascii?Q?aILCmhnJ7A09rWvZSwdk4BPj5Mu0JTgnhyjs7DQ9TLlr4fpmo0/L5HG9bMUj?=
 =?us-ascii?Q?qaPmydVVBPn/++drjNWzuGHLEsWc+ki+XBs7s6jkJrn7JvVEVqDy9U6ANtQg?=
 =?us-ascii?Q?IDHAJNRz3ws6ZelqCi7SAAtQa6BYDFpIPJscJOAMIfd6OwQLBN3X25GmpzEh?=
 =?us-ascii?Q?3+07/KEvPz0nSs3xVyh3JWIdZK50UUQ6m7tU9AUf8hSd3iwLkv4PMUC07w8C?=
 =?us-ascii?Q?8V6gxroq60WHCsehMQJnTy6BNpJwt8gqpn3qx+Vg2PGY0ZmcX3uuoh1HZMH3?=
 =?us-ascii?Q?K98OR3qYTtB3DNrY0++nGhvzRA+d3qtdUigR0x9fFKjjLFDO9LoLh2/eIeKS?=
 =?us-ascii?Q?mPXLILGsGxnrvGWEN70sdw09xM887mTFixa92P1Pip5YGB4B5B9j3IE8pd1R?=
 =?us-ascii?Q?SFe9eUI/FZKtqWxT3m+ZOK7KMJHsMiPbOgFjto0M3zNIn/6+RRS4jHvY0qby?=
 =?us-ascii?Q?YP7R7YMv278gpriMJjcU/Uy5ODqGcQTJ623OkVWZBereGJtDONGNsBeFhWFq?=
 =?us-ascii?Q?6R7TynW92zN1+U9KfDsmK0pTsVyj89IE4j9KW226imBmW0UOR5ixpw1KM6dR?=
 =?us-ascii?Q?sSyfA7CBiRWka3d41XqM5nbMd6NTIjc/Q6yYQBLSZRJlzsXd/6MUkD+Fxubw?=
 =?us-ascii?Q?3CZCoXz9Z/Atlx467UtyGodlJeFynlpXf/uZYvx7DLHJDl342g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:18.9855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cad7825-5240-4cc7-8d1b-08dcf3873f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

There are more than one SMN index/data pair available for software use.
The register offsets are different, but the protocol is the same.

Use defines for the SMN offset values and allow the index/data offsets
to be passed to the read/write helper function.

This eases code reuse with other SMN users in the kernel.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_smn.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
index 45cf86cd9014..997fd3edd9c0 100644
--- a/arch/x86/kernel/amd_smn.c
+++ b/arch/x86/kernel/amd_smn.c
@@ -15,6 +15,9 @@ static struct pci_dev **amd_roots;
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
+#define SMN_INDEX_OFFSET	0x60
+#define SMN_DATA_OFFSET		0x64
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -52,7 +55,7 @@ static DEFINE_MUTEX(smn_mutex);
  * the operation is considered a success, and the caller does their own
  * checking.
  */
-static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
+static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, bool write)
 {
 	struct pci_dev *root;
 	int err = -ENODEV;
@@ -66,21 +69,21 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 	guard(mutex)(&smn_mutex);
 
-	err = pci_write_config_dword(root, 0x60, address);
+	err = pci_write_config_dword(root, i_off, address);
 	if (err) {
 		pr_warn("Error programming SMN address 0x%x.\n", address);
 		return pcibios_err_to_errno(err);
 	}
 
-	err = (write ? pci_write_config_dword(root, 0x64, *value)
-		     : pci_read_config_dword(root, 0x64, value));
+	err = (write ? pci_write_config_dword(root, d_off, *value)
+		     : pci_read_config_dword(root, d_off, value));
 
 	return pcibios_err_to_errno(err);
 }
 
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	int err = __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address, value, false);
 
 	if (PCI_POSSIBLE_ERROR(*value)) {
 		err = -ENODEV;
@@ -93,7 +96,7 @@ EXPORT_SYMBOL_GPL(amd_smn_read);
 
 int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 {
-	return __amd_smn_rw(node, address, &value, true);
+	return __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address, &value, true);
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-- 
2.43.0


