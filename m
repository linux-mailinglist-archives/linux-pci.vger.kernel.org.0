Return-Path: <linux-pci+bounces-17855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC229E7571
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8765E188760E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB722101A1;
	Fri,  6 Dec 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wM2QA7sp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FF20E71A;
	Fri,  6 Dec 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501560; cv=fail; b=CyIBOeupTWeZu7+nQeSFT0mN0GnnWrtjahobKKHpaWeNd0vfO+XPCxgAF7iNGKwTOGo9voaFL/W8YMQ+oFhIcgwhKW9uyBZJFtDkfRNVCPWP6fw2bNwTnl8GX2q3mgy4q28l1W6sKybfyIWKjaIKOWzhPHamPP/sE46rz9sZ8Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501560; c=relaxed/simple;
	bh=w+SbRx+ynE3ifmKD8Dq8CA2+wkpOjJ4i3jymNv4hiAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMbRPEIES3SixFv+mH+6Vg8TkYHDjJKAXLgUFjlbKy1dUWoPm5Ir5hodTOIxR5TR8o+nwP03dF3eAVGb1fQMhIqd3im9923YJQm3pecyU+6wyc4KVtiwELmY8TZRW4O582vQrIDvQVyfvoSA63GQ/1u3YkYmYHUNtD5hJC2r7Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wM2QA7sp; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MftBohd488iLR+RFTujfF6XNtxohUCAOiVg3jqua/FiRwhjSM7vf/kdPwkyWbD58tI+LT5tyDfOXlGKhk/73Agl7KcxWw8IFSk/JCWVUUpRnUInn5cpzw5BuCbcX/FmzqsTGgWc5SFeYNTc4cx2OxwS+XVO25lCQjMg/CuXxpX2OeOvoHeyg0VDToB2axTi0dNORQo2CHT+mkZ4dhvzIH382piXwgnsM/oF5EeJvuSDtnfYDVIw+Gw5ATOxBrZlL6JAWquYYeklJOF1KUiGXi7D7CTBfiJVSr2kMoExHHRkpIHgAJPYm7CmpCIiz2B3bRngzjM/ydWWEqv8kG5NqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha88gzqeraxEemKnKmWXaTOoc3Wu8iQXSvrfdlND8OI=;
 b=H1zM0RDQlB3zCMQwOJCTVonUBP7VYdRUCYZi7uNPEzkxVWXOhAW3tScKwJVc40uSRvvPSH/3u+xHMqyQltFvxaZWpnSkk4UDLvzhj0rMMQ4RP9e3C4d6SraXReCgbIDs2ccN/l0wjjSUKy0d2VNXwW2HOCAutzxOd4IfqTQgbk1iKjQCnFaPpVWTDPt9JXbyCCK7V9Tp6WVbpLXAiiJDaqF2HHnKc5aubz0v7oO5BM6Rr16OUBL57lWJtvOoHhZKq8TIoMnwA9kPsM20NHy6fOgR1L/urfOfCrhyRE8HEi94zKs8mUfKgGnAs/9ZO9/UEoZlbqlkKI9u3zm/if8h7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha88gzqeraxEemKnKmWXaTOoc3Wu8iQXSvrfdlND8OI=;
 b=wM2QA7spQUvvphpgaAcL/QS5s3uglFsIbOxISfjwCy8xao3BA9qm38SycBR4gm6J+b7jVlj2yJLXdm3kLkjxODdv3mbG6WxxNXtGNOs3WNm2ZgETlfgsoJlvLgMGwgMt7dOMQYh6qrrKXmxS6TifNL2R4mi80+OsPetsvGZJSqo=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 16:12:34 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c4) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 16:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:33 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:32 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Clemens Ladisch <clemens@ladisch.de>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Naveen
 Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>, Suma Hegde
	<suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 11/16] x86/amd_node: Update __amd_smn_rw() error paths
Date: Fri, 6 Dec 2024 16:12:04 +0000
Message-ID: <20241206161210.163701-12-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206161210.163701-1-yazen.ghannam@amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: dae064ad-5208-4193-51ea-08dd1610cb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yf2W6mnipItx0lSjbRD0m1o/ug79INI39r655bM13Ol/U5lV3sHtWhlrvOcl?=
 =?us-ascii?Q?2BzpoCahPH9k2CTxUe2HRVs7oGAJjchM86VOuVJ0/ZlA7nUi0sJB6XGpz/kG?=
 =?us-ascii?Q?hDX8S0TsYjsZ3adW0Tvs5vIzDT8kqoUGXeVtSdkpCIyLpx8M1ucwJiKcED3J?=
 =?us-ascii?Q?/tGxHm3quVtGeuWvqlb9LLUB5YtixUScA+ne1l1Mb5uLYZzLTbU5zzoqxbkC?=
 =?us-ascii?Q?hT3a+F+LhoyBGgkTjt7ARyetDHuGvjrFsIeoMEXo4RY/VvEVJTRdL0AM1OrT?=
 =?us-ascii?Q?p5UoRMC1WPfqMJ6x7jIf7SdcNBk11FGUTUASVsTJttA8JN61vFHAHbHlpddO?=
 =?us-ascii?Q?TzIpPN2c3O3g1yBr62sBf2G0azfk3ckRapXHDODgs/yNc9SXGawuoKYuHRCe?=
 =?us-ascii?Q?wYfSavV7RgzEKQAJXXE1ffkFKcoEMK79S6Bwo6VCF+mnviJ/eiV65q7Ct9bM?=
 =?us-ascii?Q?1Xe1qkNrG6+/t2eZUElklfcZBga/AkGiimWry5tFKRkwZy4xEFTGtwV3xSLm?=
 =?us-ascii?Q?/jN496UHfd8MvRX/pS6eeIxf3LrbMu/5uOWg+3mcE/AP275PV7rWhDRTSav5?=
 =?us-ascii?Q?CUZ8D0Rn9q532nlGYCaYQL4Lg8l6FY+KtAIi7bh79pMOMY73XJjnoxAw9O9A?=
 =?us-ascii?Q?clkNBy4Di226xA1yvCoA40RY1MQtzp2dgs4ML/YBh+MqNvNUG0b4QK2lUWmX?=
 =?us-ascii?Q?xqyz39TkKSwt80a7dtLutEZmMROrJ3iQymegTzzHhe7Bdr/nuGD4t9XEAEo8?=
 =?us-ascii?Q?gQ8Rpuw+3LEo2zO9/qw7UNCbT1gqkZ00wckhbcyCmq0sq7YysYMdAbl+NvWo?=
 =?us-ascii?Q?5NDCL84g7ixdkdDr6ZB7Ld9SO6ot+D+2rhfRu22KzIYAaLwdIAsz47Pw6TL9?=
 =?us-ascii?Q?TyoA9se7uGqlpE+qu5Hagk816KJUM44vjW6A6/aIqZvRMSTAz24elTojgS24?=
 =?us-ascii?Q?bx5/2VVl5d86PdhCgKAhH2zkYzpRPxEUjBuraAebGIAxPkxdNTXjP4yiuWCT?=
 =?us-ascii?Q?oFYudibzZ5AgTph0iK0KfqTm/KxLhnPM01VTDUOUOWxKQRzuVl2b0/wWv9CK?=
 =?us-ascii?Q?PMY/4PdnjROA9J7jpDJHuIRo1lHiJafjjrvPaDPkdbuGxMYae5EURJqXoWoV?=
 =?us-ascii?Q?NkP5S2lDcdurYKR0R3vutZVW7SZCA1OQ0BRgFIuKCxTjsDl15OlCcE2Rjyl8?=
 =?us-ascii?Q?gGQqRkCm/aa4+PQwMvt8v2AMQ5yr8eS7TjdUV86qe7M4grDi+hA0/e2xAWLS?=
 =?us-ascii?Q?VukWH7sXUXDlyShZZevhkWrQi4i23V1/SM8WNLSG+Vj+y1+lBpa8qZ+rtSxg?=
 =?us-ascii?Q?Y6tgzPi667Uq83wBebnHv4Bvzrs0KxQ01DpAlLiJy3qHqdte33Toy2nR4a2h?=
 =?us-ascii?Q?d8KL+hHweuPjY+9tRl2XP6fzTTv1Hicu3bWor+asZpfERfoACMNv2wnr6waa?=
 =?us-ascii?Q?HzykHQMuQDpfix9LJVtRaWCqoy8OUwR81rHup7cELG38I0qJZsky9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:33.9810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae064ad-5208-4193-51ea-08dd1610cb33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643

Use guard(mutex) and convert PCI error codes to common ones.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-12-yazen.ghannam@amd.com
    
    v1->v2:
    * Update commit subject.

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


