Return-Path: <linux-pci+bounces-37036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C54BA1CFD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2187410E8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75231E0E4;
	Thu, 25 Sep 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zcsTh3UC"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A432286439;
	Thu, 25 Sep 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839718; cv=fail; b=DpTiRSry/mPK/BRtQwm8GdHNrlh9froL+KuavRMskckYEz7GRbeQfdQqE5KoaJKYWjOPDnWnA24HqIfi0XBlkzwEnxRJKuq+L8gkpi0sQWTeW9hldn3wWuOomrSyRMZTRqtfpQP0HGXu9Ayb/x5HjTAVrLkmmeOTMD1L9A9zxJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839718; c=relaxed/simple;
	bh=Ye3IXD7SCr/FkJeWWN2qp75gpn9W1p5RakD1wvtCQbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+mVwZmB2lRAlazaGbzShtqMrYed4PmOvpZyRHm733Qplk1ZUyfLowaiAoGRM0j4rxxrgzXosev8JDWRmYieYrH175ov8v2piBcTiUMyoKhjGuH5aH8fFY3sNqwQDKIFV18BSVs2mtEcpcLgvvKOTuOzQU/pJ8wUTlmbHar55GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zcsTh3UC; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqPdkmKervzd5dh5xzM5ZE2nrYatPKCVmoEnlsyDWsXVml71ga5dqe5sYt9Fy2XL5SqIywYyZJc+X+ag6foemtjHsbZDvdJ8ziiCrtCPh2dH0UWNhf4aAIIilcVb8N9H/WP9M+pbF7Az24W14exsqm4ltLN3qYqAJuu0eY7G/i+4E5CtC+azSCSC+4shmqJk0ECCOTlrn8BSMSmO6fRRTXP1i6Kwi21J/h8X9kDnWWzvUyHZZWgrg6N+dEB1bvLdXNJO/plLftJ77mRCGcX+c3HxVhvLiXx3DZC9ljWzynsJCQ0ATolgI1/pTKY2FPv4Pv4Sgae41U8XaRQW5KapHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxaA15rzsASneXOVQDG0bq4C0AWCkIcfLq3tLm0+IeQ=;
 b=ZjwyyMHTNtdY8P1mHNVaHTRQFt2bRR9ozgNl4mfgqe5BFpf/ardw/m9BDmrQkkVfW8JpenBYyXx023E3hvh9Jvb5kmW3x8WszBIA4N+fu4PCZhNbpsomM8ctJNMjNUDOW9qW5JTzdJKhQqJtpuyBkPwTxbehhcgoK36la7nFONwAKdFDLbhUPBpP84GK5ZOM/0nf80H4CrJdk1hAjrCcumcco/DxQ+zX7QKjQdZrJH0GeVy78g0LhSX0R/vqJc3aDzaFgJCp5Y/7tkg+Xhdw36dvLpJfPdhY+IjiqnP1ilYT/OWxevFxd7hUUxLVpCHwnkEOqrR2uKruGVMqTP4Zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxaA15rzsASneXOVQDG0bq4C0AWCkIcfLq3tLm0+IeQ=;
 b=zcsTh3UCizR06wcX+UOgtT0LuUVcbnwyQb5CirdYnXTENWA309KWNv2O1KTDJQEW+xPcCqcg9BW93KlgxzSWntg5fPsnEArG4vzgaa5G/7hnjl1/IFc5+kHVHoOON8qbiPEhF2pXtdNz3/jUFN+Ge5EHs3JC8do4b1E2aiEUXj0=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:35:09 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::1b) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Thu,
 25 Sep 2025 22:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:35:09 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:35:08 -0700
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
Subject: [PATCH v12 02/25] cxl/pci: Remove unnecessary CXL RCH handling helper functions
Date: Thu, 25 Sep 2025 17:34:17 -0500
Message-ID: <20250925223440.3539069-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e90548-38c3-42f6-5a1d-08ddfc83c8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUAYuutBhaD1zfOWRd6FmlEn0UJ1Tlr+k466siVXdik4OpvM0LpbC3IZJKTG?=
 =?us-ascii?Q?jEiUxg4MIyDnLI/MOpr26Tkwsxp763js7BNu0oQ81/lyQ8a5EB27pz54RjNx?=
 =?us-ascii?Q?A60s0Uhj6CC96aD0Zoy+UY6M19kRMYaWyBp2hvLTnsICAETtMkzVQzSO0K/H?=
 =?us-ascii?Q?HZZgPmuKR/vhi8V7zGFP+no1rjO+ajAXc+SYwtYvgYx/0ghpbYce9ohq8gmw?=
 =?us-ascii?Q?l3UK7prOLoN0iEc4pUC8tW9TfTW0YCZrW4lLNf7WCq7XjrXQ2IkruAJePAIa?=
 =?us-ascii?Q?rTvMBxeoWxjOUl8SS5Fb82OiQ6vhEfoleasLKPjFQWj/kcNsIdE4elt2bf8Y?=
 =?us-ascii?Q?UaQV65K7YXYWNUypnrmm/8/3AJd/VeeSMriAZa1oeck9/2F7oyrTpdCyzqic?=
 =?us-ascii?Q?7EfUsidrjDrxRjpm1KE8te77myIkVsP4zZyYiZaaDrf+hhFOCtVSWT6kjJc+?=
 =?us-ascii?Q?DXbg/GJH4McxODudlBZMnFLXbM2WKIwdo64a+Zs7gYE3KIWgtBGUhFeRBj5J?=
 =?us-ascii?Q?snqcwyPcWLH8SaHrztI3o3jc5YbyoFu6XxreF1Ven4ZEDE1yZIAUZEXZIRJe?=
 =?us-ascii?Q?BtWSrFEK7rWDFSODxiBc3iwf2DRAV0XROCbKvE1+k20tejYJSHWz0PAnH63c?=
 =?us-ascii?Q?L/YJNKHtmzweoO+WbBBTPUOURBKQ92XwkdQ6WIwItinJlHmcQTNiVVGHqRbu?=
 =?us-ascii?Q?nfjb9ZaQFbwV6eePiXAkc5+ktbD4+KSKOLH5kNsSA/dkJIF0S/ckxmXlMpCf?=
 =?us-ascii?Q?X26518Iz6rw/X3YidOe15bMEq36Xr18rNgmyj6kryY79lLnup6prMRDzBQv2?=
 =?us-ascii?Q?QlZLv4iBsFZN8Rqkv4IDixl9b1nhIGfIVzDyAS3WhVR+zD7xqwQP86Tokvhv?=
 =?us-ascii?Q?0pI5E/SdFk5lpWYqXkuNndQ7DPcqiE+f+uIn0AmslnDkUawMOstOvZpxzmlk?=
 =?us-ascii?Q?kpWpxZsMg84FO0IJJztwYP2M5Lr0AqWC8hzdScUL+ZVCYXTrA40FCVl7Ai2Q?=
 =?us-ascii?Q?UekDRVvbnFUjmh3rHga19mC0Wl9v9OHHGrbx71eX0/SpbkMNNoj01apMl/5w?=
 =?us-ascii?Q?N+wLBTQcfBiQRj+v5HHJU4Yat8fKQUxnpqB7wUedUrRUTBajJdCzI2RywWve?=
 =?us-ascii?Q?S+Fzxk/aM6WPVjBY4HUHqS7ZgDIHDOKkCi36otrZCv8G9C/fSKjh3XVaiQB2?=
 =?us-ascii?Q?lW1k+mzR4zPJ1pEer7bIyrOXAv3e1a8Mu7om3gBtacI4YM8ulDRbKolIM6fg?=
 =?us-ascii?Q?JG9LxLLanBWfah+R+JLMat3Q1joDdpUpFvqn7laokg3jlQxesK6dzd0859zT?=
 =?us-ascii?Q?/Tdq+K3RhoTbQ0BTNo13HKNEGHGZ6lUbprFMlRAXm1l5oilYuFFXK4AVHbsD?=
 =?us-ascii?Q?Wip5zVcwpsSGn4FsLqWpBSSmS+zrvqOXHo5+6YiNRe9HuLfLwvkWzz88+Imk?=
 =?us-ascii?Q?xOeM4AeQMcfzlk/KOiAWUHZAdempTK1svZt6sVgZ7WD+ZEdpIliRNjpKGrCc?=
 =?us-ascii?Q?6gFMsPrT+4lWf/68f/3gFTrDySnMlNrfLxiNimRgnf6d8PeLbUoJ4L8HqZU0?=
 =?us-ascii?Q?saOk8xy6KkTdUAwz0Hy0SV9G6LiKAr+XrMoYurQ9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:35:09.4549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e90548-38c3-42f6-5a1d-08ddfc83c8c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673

cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
to Restricted CXL Host (RCH) handling. Improve readability and
maintainability by replacing these and instead using the common
cxl_handle_cor_ras() and cxl_handle_ras() functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v11->v12:
- Add reviewed-by for Alejandro & Dave Jiang
- Moved to front of series

Changes in v10->v11:
- New patch
---
 drivers/cxl/core/pci.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 078e9e5651e1..3fb9462954da 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -858,18 +858,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
-					  struct cxl_dport *dport)
-{
-	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
-}
-
-static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
-				       struct cxl_dport *dport)
-{
-	return cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
@@ -939,9 +927,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	pci_print_aer(pdev, severity, &aer_regs);
 
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_rdport_cor_ras(cxlds, dport);
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
 	else
-		cxl_handle_rdport_ras(cxlds, dport);
+		cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 #else
-- 
2.34.1


