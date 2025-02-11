Return-Path: <linux-pci+bounces-21202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78972A31561
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A243A8FCF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2426D5B2;
	Tue, 11 Feb 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YhK0dG9u"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5B26D5CB;
	Tue, 11 Feb 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302020; cv=fail; b=c3i1sbsWBwMqJ6UI8ej0CRSKj0TnpKYTY3iIbUY6AoZyFPg/E2DvHUl4FckbbooeasMtYOZC2xvUmeNGAfTlUgUMYTnUCRLLHNUBmlFew5h0ZaV05Y4AIGz8K5HdfbJy4bWCs0+ob8GeSv1fw9F0rmXny/ZJrsyA6F3+eCau/5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302020; c=relaxed/simple;
	bh=3cEUtq3pEBEdRbHub0mpq+H7LoLhgY6Gs5LqqiSmrH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnAXNxZnWhCIXDvdr4fOqGbB8om6s8zYVArjaIL7fo8xWW7Aoh8k0zHCIJsNKFB/wbfHUqqN6ObxUZWBQqBG57/+KCEf2GZsJoUvG7qm3t7AhcdvcxfAtHMyqj+uugpbFSsCgauXrtls8tJqK2J3iy8v4H9hFVf0e/XkGlUCRkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YhK0dG9u; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6AQZksEt1Ph30Tc6jAjaDsbA/xudvMV7Y/2K+FQFL8LITawNbh0FQpVhxTdZnKQ68I5AN+yHJDgzifSRr8a2wUtKNMdo6qLgK2oTeaTomOf6hsZxujVbZc8nlEbr4Z62WYWGfthvgR/RA5pduAAS28IhohgHMIV7v9XMTOwyQG64vVxyrKERrCA87Y8tLJV8G147g9p/HUuXRVwxLXWvNKvQXNpspm5JzVfJQFaP5cjWfHKm8Vb/FFSZ7dAnJhAO1i56Uq/7SQlhFGPq7ZHcSKc6nj9g3KTzuWVHxDM9ba9rDWoIINoBVLwev1stkCQo6oMR8UeicBeJzNVcmjwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNupzYRXghJOuAOq6Jvnt0xvLZ8nVsmheBZQrqyg3BM=;
 b=bARzmfiFBPQy7Uwq7ENKGH/p5NWwZ66jweACJydmjtye6GfjCCv6C8lDMYXVKOGtrkSyHuhHdvZmv8EjQf+psphGbqdEp8ly/iXjn/4S1QqHMYqEIn++2Ojx1LMty3UvvutlFEgOQGo0jxeLPfXM79BMBU1QDFRgl75xyNyrKlkMbPVZDPbLGC0aOvEs1OTLoK3gIQH0A+ftjQEddwUq1EiZnz8kgLi9T2wtguxHmxLEq4ZpUjG0smWln+iB04Cd/T3tKVpa+pArwWr7WFB1MnZeQJ5JbhyxBSwWd4LNUntjISzErmdXXXEKptD4SrZOG4VOXgnoMf8itZVDlRoAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNupzYRXghJOuAOq6Jvnt0xvLZ8nVsmheBZQrqyg3BM=;
 b=YhK0dG9uHHWdGlmneVlabyT+YxxRTG/xuFaiYXC95PdUkig+5boIfuXemHC+iD1yGVtp2knc1GEt9WhyDgnQ7kLu3XY4OlKLVfYiWCPiZkJjaM/Wmkodia9rysTJda8neEsWdJYOOS6cyXPBLKNZimD3I+eLNhRwWKeTsC1+B2M=
Received: from SJ0PR03CA0147.namprd03.prod.outlook.com (2603:10b6:a03:33c::32)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:26:53 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::c8) by SJ0PR03CA0147.outlook.office365.com
 (2603:10b6:a03:33c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:26:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:26:52 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v7 11/17] cxl/pci: Change find_cxl_port() to non-static
Date: Tue, 11 Feb 2025 13:24:38 -0600
Message-ID: <20250211192444.2292833-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 385ad1ea-77ea-4838-47d1-08dd4ad20a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZTpgbHmBc4d45VCLl938ja4pNq7iGmryf7CMIcH47jVol9HlNEJGYOAfyNwW?=
 =?us-ascii?Q?jnLNdSDRqs/feY0fncOevYjNEyt/01aX6+qfNKnPHwd7j+BOV5Vcljz5nJ+/?=
 =?us-ascii?Q?fULWCCWaAcriOqP0U7ez6xJ/dSjLTRUSJ431hBEINJgBdN4Gfe/ZszehKozJ?=
 =?us-ascii?Q?aggiIUtS35c105+9GDPmN23e67GA8xkIgBef/4Ww6uHOSASbP50iSbxP0b5k?=
 =?us-ascii?Q?205gm5IiRBEPaz1tnbd7R0q370af2cvpO7hxZWxXPKQRdbgzPAKj0wGCWVTZ?=
 =?us-ascii?Q?UIvgeNtzj68RRkQg9xdR+jFd0EipPsUv4AEuYQKOPw1+wGzXBA2VXEW6n2uR?=
 =?us-ascii?Q?SjlNldY6ikmCf7NPulwQZqDT5hcQSAoYL2kU2ew6EUpL7bsU9DWgmVWvlg3a?=
 =?us-ascii?Q?/QOIMoHLvdQEyR8Gi1WsH/T5qJl2VaL/8TDEzVFGxJPZ2eqbCbnktfMHR7qI?=
 =?us-ascii?Q?sXbYivh+iCZ8htrRrg1E5hAcp41X0MTUkvqEiDnmLOiudAKQUcQyTZEw0Fpg?=
 =?us-ascii?Q?lujM2cWnxp5jagm+S/Izg9t+byoubVdXgrQ0eZsnE02d4Y31kVjZzot/ENAd?=
 =?us-ascii?Q?sRGw0ZeU0ZP9GpQBDMxSDrGPtR6r24hAU+BLWu98QcmakYonrvYk6V9cA+0F?=
 =?us-ascii?Q?j6RTpXHEgEsaUOnWhL6pwttjBUW/GMZ6hUNifUNd6AQ8yia6oS+ZvQq/TQmd?=
 =?us-ascii?Q?FZpV0RLQHfm1YGXz0/9E4lWJqTzH4c/jxOgGWbD6HpyI1KKNlwwwuiM8v8ki?=
 =?us-ascii?Q?lOEHjHRe/QLFm8sC/KSs+ECsgeRVfZdEdrq5epKGUqHI34D0vmvfOs77YwxN?=
 =?us-ascii?Q?ZvdEcHvRh7pjyBted94d8M+NQ82sSn2ocG8G/7LrZvkmzcW+udDyETzl52b+?=
 =?us-ascii?Q?R0ZK6JYH2kMOu7H/BDf3O1AtkNtf6LvSrk8RrWiHSyGw0uKUXlFizDuDga7/?=
 =?us-ascii?Q?s945MoAkHFpzltNg3kPxTKqUdFSNGXVuXv8POJuiA110lT7E004mjUa/NDaB?=
 =?us-ascii?Q?Nnk9YyxJfAUGcTHsATXOw/zPs76SAiEmN55100jmXNcyh1UV4ezTl/fjazfg?=
 =?us-ascii?Q?AytbJ9/yZ7dIPFUzwusK40D/JKMUPdf3/Ciji/7ZRB839WsF8SZZXznEhZP9?=
 =?us-ascii?Q?srPedhyry085x8CIlYzHtJVplVlFroDlUywv7G460FglAA4Tuh6xl03y2X+w?=
 =?us-ascii?Q?7oQ6SrBdnFHGsU9TUZnm5q6oS7r5tfKVpbmPZITIe5H9idVs5bfKwQnEoxwU?=
 =?us-ascii?Q?2hsz9wc/D/Jc4nW7EqKM1pUEahELeI5XPZ2l19T0EVSyaHpp9DukA7aatHMU?=
 =?us-ascii?Q?UJ3G+LyxguakWVZ0fVyaqHYeTrpwCPPDDtDHTe2vLx5etvurlpJvQ/BkDgmY?=
 =?us-ascii?Q?rDydbOV1STBNfmYqAqDA5e414jhZJPissKCnjG2uRrWDuek+55TSsEGuQEin?=
 =?us-ascii?Q?mV6sdIMzR/mdCuq5fQvaKV4Ra9oj9wS1DlJ8DgkTCyBWbfgohxBrlf/8eaFg?=
 =?us-ascii?Q?QBeJaroC3hflvsc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:26:53.4486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385ad1ea-77ea-4838-47d1-08dd4ad20a7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

CXL PCIe Port Protocol Error support will be added in the future. This
requires searching for a CXL PCIe Port device in the CXL topology as
provided by find_cxl_port(). But, find_cxl_port() is defined static
and as a result is not callable outside of this source file.

Update the find_cxl_port() declaration to be non-static.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h | 2 ++
 drivers/cxl/core/port.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a20ea2b7d1a4..796334f2ad6c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -118,5 +118,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
 int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f9501a16b390..ae6471e4ebff 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1352,8 +1352,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
-- 
2.34.1


