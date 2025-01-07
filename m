Return-Path: <linux-pci+bounces-19473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24DA04C66
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363933A5819
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C85A1F8EE5;
	Tue,  7 Jan 2025 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MoGEJjFy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5D1F37C0;
	Tue,  7 Jan 2025 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288958; cv=fail; b=MdymAIuNNzczEpLBFQQGIxjT1Fx2We5+IHvACVVCKWHmwWfRrKgzk1DC11eu7rRVR4Js5bDNRRyDhuvCU9LiVgS/SBH+dQVXGzBvopbYeMRwng0R5p8HvVyOxj868g/wW/JBGvGxSYnQrkfQDhv7JHSAq+iFAM6J1SiPQ/1F5Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288958; c=relaxed/simple;
	bh=EJ3auUOfkS8eEyrYrCoiXIGdXNNVz0ciZ4a6c9JpqZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRAiIC/ELB4460Hdw3V/763sHjCA4eiojniuYJebw3Gs4k7WpKPx+xHp9euLX1zGsM6EYFlaKfPI0U1EuZPbcxHckuuNh/I4RFp7CwQhFoOvoLjqK31n/37ErmjGninJPdjfFCTpXxmptl6LAAa15dLNNiiD7g8F7B8F2LPtw2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MoGEJjFy; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGlNc6n4v/d/Qwn3ilO4aaKIG7ynh1xaQw+W7pyY5yKMlsKjSIUDu+URH3nYcQuOIQdCBsQsB9rMMmh8YM8L7Nxa7Q+3zHYlmdbTbIQ5xIFZKC83bX11+4CrPKEw/TP+syF87IWSunS4cgMMSHS2wHIQewIUONawjXZtzRSMgychQne078/TZ1tGAX+ABykAYg+v8xTqawoOY40cfQlDTgueQCfKF6AZfIjbnEsnAafa1pFknUn3L8i0dGisVRZj+OhgJrpFE5hCdVvtQCiVtQHWq7M6y5HaNkzhQLHo1IVczqYypRJ74fgVfsNrg+JTcl9FYhsnQIyYx0Y+hXXEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiF0XkagsOJ2GkTv8+rls+reVi3pJHUGFNtfagJIVvM=;
 b=jKOHCt7ar73Z4eDBJOswGpgMEVw/ood6IvLEZmYPU3xl4svrCpYKPUgn3ql5awMzCEh0ZMy2U11ZmvMpSrc2N7nRgCCkgkihh9sXpkabrEttv3FR05Bcg5WZTry/jCEmBB9k7pP/DgsmNvdIHCosJego/J3Dif8QqGVkiKKCVPDhqKjmJsyTMcNwv/GpnAK/Rnub0o/FdzKo7fNESiz+DgKmc8k+NpPBId/cYOq5FGlzUuquIAWarhN0a5I7CbVlhR3zcJfEZ+bvAqKUuxPDYlgRb1qYmANtojo2vI9Z7RdP/rORUI4wnn5qzViVYzsDg3EwgVfBtSZzqwu+K/eNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiF0XkagsOJ2GkTv8+rls+reVi3pJHUGFNtfagJIVvM=;
 b=MoGEJjFyKRijMkI8UqU5zJlvqwERMyDhz8mRQ7TpCRAJ3UxuUUl3tfhDA49je+NwzmhiX196PoNtfW6HpUF/kypMDhqIkcy7EEMsm3Eo+0/PyPeFl5+rhbQUvzOIJ/dGA5a47X4hpr8CF1LbcJ8zRcIyJStviI43QMa0PNwwqFs=
Received: from SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 22:29:10 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::c2) by SJ0PR13CA0236.outlook.office365.com
 (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 22:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:09 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:07 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Hans de Goede" <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>, Suma Hegde <suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v3 10/12] x86/amd_node: Update __amd_smn_rw() error paths
Date: Tue, 7 Jan 2025 22:28:45 +0000
Message-ID: <20250107222847.3300430-11-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107222847.3300430-1-yazen.ghannam@amd.com>
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 4383bff2-5cbe-4252-aec4-08dd2f6ab47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ctgjwMCXpEPd3Lqcxx2UzJytyQSrfLMrAzBAiihvfaTKXSv0F2AFcP/MGDAo?=
 =?us-ascii?Q?w1uoAnXLiA2pIfJgxoe1uiqppy4gQh4wiRquBixcOsNkAMRkTQ0GXo7tysfV?=
 =?us-ascii?Q?/qhv+hqCh1kRieKTGEfEeGSe7jRbKAbrfZXb4cVrpJyfcTcbejTNdiG4XSzv?=
 =?us-ascii?Q?MVgvjNuQqWb9519pv3W9h1ZTgxbuJ5je9HIKaOm/AKFIGjn/TGu5qDu/AOIo?=
 =?us-ascii?Q?fRuhTzh665Ia1geq3Qn3tMOI8i+yOQfkqElFWcn0HQuFTLte7kVUEICPsv5+?=
 =?us-ascii?Q?2EgCpXL4ksO2TGsreO451iFWtoZoAFrVnVp9ghevmESYyKbYMet7gn2mjU8Q?=
 =?us-ascii?Q?hATzndI6eGBn07LpvJ2QQGnEQPsxTpFlSUq2Jswd1Q0Yg8IY8nhF4btRksx1?=
 =?us-ascii?Q?J/D5KH/dHjmd6vXtPHeOYpOY+xkcTiGufww9AzY4nUihiRNKX97aGeoG2Qlx?=
 =?us-ascii?Q?itJLAIAWsO97cnTfJRZ9GvgOVblS7AZJkN1c/iPYWC+Fx4CqBczqVZ6oUhts?=
 =?us-ascii?Q?TTfNOcrf3rkY8vq3DvIELJ3Y0U7wp0yJQ3dYclI2sju4f1ertECmmPWaY+2o?=
 =?us-ascii?Q?/XLuZVKVmhiBH3O40jnobVBn9EQ6PMWdfDFFXSDDzadZBxUE8RiofFzBLseI?=
 =?us-ascii?Q?59GOzuLKtlkmxuWj3nKG/2bKf6DtUgKjVUOSbWSQPJUqi67uDEt6g+KggRgZ?=
 =?us-ascii?Q?0NJFlkMQnxkd5L7ma+McfHOOavOhosyuH7FGBLRiKoScn3FShEGF2uG2MdOy?=
 =?us-ascii?Q?cCtrtKqKyaxYhS3Uw2MhO7Uj0PbmJNVZMa3BbkBpFdc8Uq74GRIRVqwo5liM?=
 =?us-ascii?Q?0w/TeyfPvhTdKnH+KrzaHyDjqVaOuHVx5RRdV10kDkJB0CuKckKNc1rW+Lvi?=
 =?us-ascii?Q?Cu92unyvHPZFVfECULKH6S+2ToTP0QU/0/pwWwnFo+vGEKjSWK1BRxZB74Gd?=
 =?us-ascii?Q?DOtZuhrb/Nl3si7r2sOSVE9MGrYXrA6+MzmOyzKN7nMZJlDsf6mMX3Y2E0FU?=
 =?us-ascii?Q?E69rE/pbAdT0tsFef3byFEjmVh3NM7oLFGxZTXhWvhj32wyiVxmD5GIJfqW+?=
 =?us-ascii?Q?A9/qcG8I0iTayx3RnWOwtBLoz1ORbKbndeu3Zg0C9qls4Nqt5/kQVZxy47qp?=
 =?us-ascii?Q?1abqZ6lP1oym4RcWv1eBc3hUsXaN/1G23QjPPo+h5YlwZUW7zaIysH+OQg0y?=
 =?us-ascii?Q?2CG8GvetrNrZ+zW4nnHLmkU+BFSVI2fofh+EyE9JBc4q23+OCRgsqeXiPIdc?=
 =?us-ascii?Q?ppN15vVE0gAQjIeKiqNA8svZkA6qmUzKxaIZ6isathRzPqi4WOGWO6NCnAF4?=
 =?us-ascii?Q?P74BriBMyQvGau3CRZQihGLy9fZK1vSB6LY2FwRyrztefOGRRM9hDzliK3nl?=
 =?us-ascii?Q?yOcnsOreaVdcuSTZpdB59SwFTE/4SeV7Lada6KlAbe4FmRwHQ8FnggnNA+jl?=
 =?us-ascii?Q?Xb6ncVqek5i+PajkMGPt0C5NdV6xzbsKgI+85bQppv+OTA7E0AVOPUm+2sy0?=
 =?us-ascii?Q?Dddr4kRp/sGvFguz6R7CR80VNmHvs6oR3oDN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:09.5893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4383bff2-5cbe-4252-aec4-08dd2f6ab47a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

Use guard(mutex) and convert PCI error codes to common ones.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-12-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_node.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 95e5ca0acc90..0cca541e18d5 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -136,28 +136,24 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
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


