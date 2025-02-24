Return-Path: <linux-pci+bounces-22159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575F1A4164A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997D23A9663
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487DB1DA31F;
	Mon, 24 Feb 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="utgkdvJX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1D14A0A3;
	Mon, 24 Feb 2025 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382299; cv=fail; b=q79RgoG3TxgN9Mlo9h1WUtnnHWe0wL4urlxAteVJSusnieG58eDxzSgig6NmY/407BMUGYFdmUyUOAhQAOyZXcuJJbWVHCejsKTh9hDPtqhjIpL8RlSMLYfmpYEzIEsc6/Ou24Pyhy8v8VFEDPdWArAkY4+ohrgU26gro8S0kcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382299; c=relaxed/simple;
	bh=sWVLcByvdv1zgCmR6JhQuUi3/1+aDic5vEE5I7Js81k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWSuN3bwVspQjltQtK6blPK0ekNVHUz14jyE+h02ZYZ1OMeOhq/TQILR4Ppntwmmcxtl9o2O4n92I3g3/Xpx9M7s+QeqBIXhvIpWIv3EoSbb4u27xA7Y8Xa3E+BuXkem4LxAsx6Om4dkp2FajHz3yuGKf3UXeLiParwpIoHRw+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=utgkdvJX; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmQ8WVYS/8CXWB+hiJMk8953WtDel5HdMQ+kK1H4Mjt277ZDwtPO8ngTvrp1CKgunUOuoM41XM+mmgr17nun9HjXlfq21iXpcBaMqpTYoUpP3C6yTzPPYZ5pI5AbKzqZJfXHkuAcF8ZhbvbG17DMmPGw75zHCpkLOsI9lkJo8xh8VsCxFNJDvwCGSVahf6hEn1p90DRwCl8gc/7ZOil6nYtXpCZYAYJDkiUCixAyPk4G6GhQVh7C4COXo4fB1a3cyx47GwDJKCSOo9I4np/JM7U21mARsiLx/mlUiXpszxv4Wju5ez5re94G6ycXHi0Q/c01HDRmeZn27gap22um/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=mv4mmEAnUqHal0rIEyp3yjCMWQLxXI6nsAf2rxFzbKYFXr7oNcyYk89At7ZBYtY8/hOk7gPlX7JazwXOnMNu+QngZfhueFjPNr3QetY61odThkKnf9XiO1xZoDKw+x3qaNwN4kIA8OxSRMWvXriYoKfnlZ/YPktB3b4oAHnhkQJHyK2JozFOqrFvhnjy3Ykhg2HW5Pdrxo0rQhUKzHcp4QVK2lX9QagpoHy1IujjeHE4syjEttak90YK9tHl9W9DeGgMijTdAufW//YbHIiHrvhSUnJY4bpvvC/QBFr5FZwRT4494AtQelW/lvc6rBiBC5xq/S6S63UA6IIDlY0RIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=utgkdvJXibTuTgWQkfUGRyxPgJX2tveBt3OHX0Zu4xhbxGHivo9pIL2qHM7Pa6sboiMVLtICvNzkPk4PUdLrLSjuCGrPL2vyBew8ik1DKK+wZyVfvqKPx50iQUcUY7LP4G5tYzBh2bVWV3dFkUBfF26GNvibCshQqIXxlwXd7gY=
Received: from MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 07:31:29 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::c5) by MN2PR22CA0019.outlook.office365.com
 (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 07:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 07:31:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:31:27 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 01:31:24 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v14 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Mon, 24 Feb 2025 13:01:15 +0530
Message-ID: <20250224073117.767210-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
References: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: c97e7ef4-1cc0-4026-8e00-08dd54a54092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvkekZyhyMJP7jcmjaazd8IhbJs7gohfv6e+j3v6lZ4zNBRLzwDGcyap109p?=
 =?us-ascii?Q?aWOtyS+at6YRH7gDKmzUQueHTkVBfbpXfXfARepBRts88uJxtNZGHmrBVTOY?=
 =?us-ascii?Q?4L7s85fj9GC6J/XQEB52T3HX9KNlymidEfOHJXHG4rN53YS19a3LmCBJMMmu?=
 =?us-ascii?Q?7CRv34nqcXlLGqK8BpJlwNP0otFYBSm01qfDP13b/b24oQwNivRFBTyrW8p0?=
 =?us-ascii?Q?UPra3u432f1StKgzAAvAA8HDFqZMXdB61VFExPH55c814ylw8WeDNbQjv7JS?=
 =?us-ascii?Q?D310/FlppjGKJJdQRANlEFKCXS67gQZRK7n84vyrvCl9p+iktbfawCksq/3e?=
 =?us-ascii?Q?R0WoxuRLMPBd4SWK+jFmMWqwPjYD8tC+nbzg/Gvpvk1rnh1QAeSmFciqD9Hn?=
 =?us-ascii?Q?02qj2KMecZF5ut0eGaVBBeYphb8a2Q/1CMaq1bHHYpzOC+QU+yXqrT91ZVQn?=
 =?us-ascii?Q?1ONSgXRJlQUviFeHSudH+pEc0yIoRHuaFSH5MAnOWNgy4OWorexmP9W7+GTV?=
 =?us-ascii?Q?VuWVivc84FLwTQA3njhWs27EfV/6wdRAhqZyee6dg9W9DjB/rRIu0F4gvVuO?=
 =?us-ascii?Q?SfcCdEnfWdmdN9GVfHrAkym3X8Rlqrket5sMmzmUDxlyLA7dYV2H1QHlgh4N?=
 =?us-ascii?Q?hxitqejpToR8AZhfiJWwUHPOa5kTAuh/E8SrllcBxVhw8Gv9akn0JWegnPM/?=
 =?us-ascii?Q?KijklmJ3nj6XtVjxnab+KkLaXeTNZ1kHfGoIM5njza6ut9tmcEzYDO+P6afW?=
 =?us-ascii?Q?qKZWo0ITj2g+OJyWfOF9be5fhLiGDxUIiS6rcguR8rsl3AnsYg5xfH0DTh6i?=
 =?us-ascii?Q?UkLUl2220igTMiWEWOjE7JMhj1Hv8KugcLZ/Z+hZHnP90/g2XlCxX/5y/K1m?=
 =?us-ascii?Q?Ezr7EsHdDI5rn+zNo1Z57zj7ycI0Za3bXJlwahRfNW5JiGA3Q6EGVyACWWmX?=
 =?us-ascii?Q?spl+0Z+8Y874oJOwNchB02TBSkcT3acR4MncXBRyt/Ak6uu4ECDVRr0aBrVU?=
 =?us-ascii?Q?4TdzMKJKgvZ/zk3nyOwC2Zva2EhHsU+07YrNuvR0RvNt9jguCDR6D6bUj1Nv?=
 =?us-ascii?Q?tk/aabreuo3esOydL/FeUiMW1mN2sbtcX2d9mqiDWRgunlZ+yrJ6nxYNJwdz?=
 =?us-ascii?Q?nIJGtEX69b+7ZNVEdxm+OeE+wAcLuCIPIt7AWtXeOsaSWJmb3azKs5g8og7E?=
 =?us-ascii?Q?967nGwQL1+k21V1CJ1WncHE8sWqeZ4FjKaMO1G9hXi576Dv25nWjC+aPMtrm?=
 =?us-ascii?Q?lJ9ngCngj7azPO9N4qhVldHF/EuRgKTMw/Qz6PaplaEWzjSc11az1eTi37dH?=
 =?us-ascii?Q?VkdFaAKtt2MAq7ME9BkmRJ1ZGknfBv2AYeGssSu4aOxLA5c8Mgtxb70aKJe2?=
 =?us-ascii?Q?1PwbAgYMunNBGFZSn+GYtQcRchg5LVfZwcLD28GW3ileIKya1QrGZNpE60Fb?=
 =?us-ascii?Q?RNGkr0qWg0x097aItf2OXy4CYtf65fr+JUSArAIsspzcHs54VNTHKfJhVBVV?=
 =?us-ascii?Q?54lyVHYPlPIkEEU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 07:31:28.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97e7ef4-1cc0-4026-8e00-08dd54a54092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
-------------
- Introduced below changes in dwc yaml schema.
Changes in v5:
-------------
- Modify mdb_pcie_slcr as constant.
Changes in v6:
-------------
-Modify slcr constant
Changes in v11:
-None
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 205326fb2d75..fdecfe6ad5f1 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -113,6 +113,8 @@ properties:
               enum: [ smu, mpu ]
             - description: Tegra234 aperture
               enum: [ ecam ]
+            - description: AMD MDB PCIe slcr region
+              const: slcr
     allOf:
       - contains:
           const: dbi
-- 
2.43.0


