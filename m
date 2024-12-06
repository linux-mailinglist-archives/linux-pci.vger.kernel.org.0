Return-Path: <linux-pci+bounces-17858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D349E7577
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B0D28B657
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB578212B10;
	Fri,  6 Dec 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4pGjnqCy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688E21147C;
	Fri,  6 Dec 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501563; cv=fail; b=lwayCHnAcaW7t1GYXpjwnzP9zpXZhNJo45Zx3VxirOzx8QQtnu4hJll5P3aKEaXNtp5rEQfojoqqli+voe7vn56g4I6OgH6+tMxTBqu/em7IzAyIostfH/Fz2/0DfDTnANOPA4cWD8W4W1OC+JTuo3YnKGWYYrkuzdNacY0cNVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501563; c=relaxed/simple;
	bh=MfVWnrdzjh5zgDf17FZkeOPBuOsx+G2InN0vT0pYyaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iThB9OhTy4Gkfh8jUGRX/GagBivYOsMdg1WRCvXF5N4CCIkOafGx5Q4oGHxnE3zwv0i9K00hE0EolaMtk7Jji9/lDHaBAqqsp4x6Mx6KWJ/bNBUSQy0JiOLq6ukFb7coI6n53xLIBfWKDLMVNzfe7bGnD8TXJGXQPhoVwhNBY1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4pGjnqCy; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu3ZdNa7exbjdYEbwbmoVZPhF+sJ4FpdNb275/uAi+dT9kDglLykELJb0RE/hBCyTFYWKnXNFZ5kOXIKh17m4o3HpBOw+9267Ab9xx1Zs/hK7j7tuqWlci8rtVSh5A0QFYiCnId2lsca6W6MVVUWRpW0ihrqJgx6NDqQz9Mi3vXxyjzdk6s/mobEnEKinMiDK8DsXhk30p6D32msnAQVRq2ImTj50O35UYemtFEl19mMA7RHUjafY+dhOncADSny4JTz2ECgOXZirX/Y4TsS8dFh7OmFOHw7tqubRtoVXeH/p1vICUbFTfbY3+gTUuOI6MHoC77xpPg+PrSSpXcAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlHlcR9VqKCinqql447V9yi/B7E0+PdXRB59KT7EBec=;
 b=ZPJHQaxQUMHMg0TJZbVM1Cz3oiOrfRjfDoimWP4vDsUmDPFkiCLixFwoT5bUjtpCGyhAaP8pEG8iAxq5NjgNqb4s+z2Glp4pa/IYLwKny5eFDDYV8GeiApQ8BlwYTUqThU8AHfNRLaS0f6bPvqPDFcniYJYZoZLp39baK05UwYOK/vtQ64fGTIUb3xRI9Dz4Sb9RhGDxuwzr4uwNuRDYRy7qa+iDKmn8Qswr9D8aGuR5dw4gI5wEH4h/3Vt39UiSWqJ+LyQcK3wGLquy2uceCyb2a39L94/d4mqZJiOoWAcZprJePINRnvbUevqea/jF8iUzWxDrgW18ChZMWAWaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlHlcR9VqKCinqql447V9yi/B7E0+PdXRB59KT7EBec=;
 b=4pGjnqCyyC7Ul7hwLrR/Qy8ZVkLPW4fXv5BlkILoiwc/sQmoDiUvidTT3pFgpFLiMCBAR39LvbccTRSREGBHVRdLtao0bixW0xgyJxLEOGU2Ko779vKz7FNP/o/Jya9QyoyHPInhSDlm/uitSgl3zsUutLJ/RYddN0IGOE1DjHI=
Received: from DS7PR03CA0266.namprd03.prod.outlook.com (2603:10b6:5:3b3::31)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 16:12:35 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::b4) by DS7PR03CA0266.outlook.office365.com
 (2603:10b6:5:3b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 16:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:34 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:33 -0600
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
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 12/16] x86/amd_node: Remove dependency on AMD_NB
Date: Fri, 6 Dec 2024 16:12:05 +0000
Message-ID: <20241206161210.163701-13-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: e95b8726-65e9-4e15-23d5-08dd1610cbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QF7hsPjJx0r6v5UFdWjymfZbi49oPizjtwJMl2N/Eyw6oPYzilIGDKyzoXeD?=
 =?us-ascii?Q?veu0zCik5/Gof+8U6fI2UsGJ6IO7ERE4AKHQZ7RyQjvYcYljd+bhRAL2Q5vU?=
 =?us-ascii?Q?PpuoYuGGPSK6V74AkM9v38mJylIJSu2saMHrUz9Gcks4aQGKzQghduKUXge+?=
 =?us-ascii?Q?l3zcOrN0xw2zFd9kBO6w4wXcITndC1IfQMYJnnki1wy3m9IiQYkB9NDJMBCD?=
 =?us-ascii?Q?Gl5wP+rCnH5Nn7UQ0Si3aH0YUdvBIRZg6fjJOHzTqeY71UyEs1yxvlbMYEJy?=
 =?us-ascii?Q?w0vbZSZxdGwVUsnsI3noOIttKIh7tgbNrlzzzjvM6vrLmlDH0tNAkIxs87+X?=
 =?us-ascii?Q?pK47JAkrdSfstAReKirDOlrHM6LF8PnEc2yMCrg4Lqnlu1xgRaQw5kHQ08+X?=
 =?us-ascii?Q?01PEQGjCz4GBHTJhCvsfqbJDwi9NPH5jM0TOR9sLdaBbeD+4WQWw96zhlEVP?=
 =?us-ascii?Q?KWQ49WWM2qXzdmkd6aOXnKMheZ9e0JWtB9FHLBo5w4BFivOr42ph3BhCTWRY?=
 =?us-ascii?Q?jBTkEwI0BF5TiZIDkqHI4cqYDFcakOVgJHk3snP6VxyCjRApD3hQ980Cb7Wq?=
 =?us-ascii?Q?/FvBtmYk6QDBtx/Rd3Xc0r7rZitfqJIBIp+oyvSoqkrUlHiRibfnVgcwKoVN?=
 =?us-ascii?Q?0jI8FtSu12phWoZsZQNSLLvSQExHFZnVjk8PEQ97IEqi1btqyifGmhcU45uH?=
 =?us-ascii?Q?YuiL8tlDhi4fC8qkYhMSMVVBFjfmnOut2GeJXQf+g3s7lI5Wqe65Aiao5GYb?=
 =?us-ascii?Q?LjF66c8dRTaOa5FQWpdsXsUNvuuR/WxUHBnfrrK1/6rjnbbkU0Io3U2CKmMh?=
 =?us-ascii?Q?4tAXA9oZxttVLSge7KWq99FDkgJSpp8LI921YoFR5qCpXplpdHuce82YP+TY?=
 =?us-ascii?Q?MvLhVHlkC2zwsJJwZsZNIT9tFQZys8ifiHQc8n4cblnJkmYmALVhSrKSGavt?=
 =?us-ascii?Q?5EYhqGFBgLk8f/0/daH4bfULRt6tru+QuE/TMngzba23rq6cEnzB/+kfPzub?=
 =?us-ascii?Q?k+z6EHGWdHwR04aa+lUhQl1fEwuicPFhW7YPYY/AHk/rFQwOD3LRjb/PuYMM?=
 =?us-ascii?Q?8hMf4d3KNGUMoueau2SAp5sVD7pY+pXgQnO9mJPlAhLPq6/lrmFr15deEDZG?=
 =?us-ascii?Q?zf7PANXk643gCFM4DwE9z4aUhqCQ2xEghHrYMEmjBcZHQ+qcx6/TdMMU9KKG?=
 =?us-ascii?Q?X92Kt44+VG6YMsCK5dOsIVReB/11IZnQAB/g0lxlkmoYTCmH9MwWOQyKX744?=
 =?us-ascii?Q?zjjYEnE0k/BAubFuluon6HfvESDPTkj56zW5IiUmLDq/9JO2RbT0ey6EUJKg?=
 =?us-ascii?Q?LkIz9CL8txZsejyHFNmFCTib7I2oc+eGl76AO5MwZSpJtA/TigxZrqf4fsiH?=
 =?us-ascii?Q?fINddwPy8LGhNd2Tjlr4gkxXWhfZUeRdXyXdvy03+aKBjKFjP3EBjT9/fxm5?=
 =?us-ascii?Q?MFFPIDdr1zIy0CRcmnasP0McWXQYNJSRLB3GkFDNe07dVNfbLOpmOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:34.9498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95b8726-65e9-4e15-23d5-08dd1610cbc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

Cache the root devices locally so that there are no more dependencies on
AMD_NB.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-13-yazen.ghannam@amd.com
    
    v1->v2:
    * Apply to amd_node.c.
    * Change sizeof() parameter in kcalloc().

 arch/x86/kernel/amd_node.c | 42 +++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0cca541e18d5..45077e2e6f2f 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -8,7 +8,6 @@
  * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
  */
 
-#include <asm/amd_nb.h>
 #include <asm/amd_node.h>
 
 /*
@@ -90,6 +89,8 @@ struct pci_dev *amd_node_get_root(u16 node)
 	return root;
 }
 
+static struct pci_dev **amd_roots;
+
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -135,10 +136,10 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	struct pci_dev *root;
 	int err = -ENODEV;
 
-	if (node >= amd_nb_num())
+	if (node >= amd_num_nodes())
 		return err;
 
-	root = node_to_amd_nb(node)->root;
+	root = amd_roots[node];
 	if (!root)
 		return err;
 
@@ -174,3 +175,38 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 	return __amd_smn_rw(node, address, &value, true);
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
+
+static int amd_cache_roots(void)
+{
+	u16 node, num_nodes = amd_num_nodes();
+
+	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
+	if (!amd_roots)
+		return -ENOMEM;
+
+	for (node = 0; node < num_nodes; node++)
+		amd_roots[node] = amd_node_get_root(node);
+
+	return 0;
+}
+
+static int __init amd_smn_init(void)
+{
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return 0;
+
+	guard(mutex)(&smn_mutex);
+
+	if (amd_roots)
+		return 0;
+
+	err = amd_cache_roots();
+	if (err)
+		return err;
+
+	return 0;
+}
+
+fs_initcall(amd_smn_init);
-- 
2.43.0


