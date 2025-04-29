Return-Path: <linux-pci+bounces-26990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817BEAA067D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07AB7B1A69
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E90D2BD5A2;
	Tue, 29 Apr 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KmPcXeQT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DC2BCF6B;
	Tue, 29 Apr 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917266; cv=fail; b=M5OSqyMJwpAt9FVBprHEo5DP0HfmLeQcDkJ6PLWq7xGz5//ZCDBWxRDPJBzcCVkjed5Z+GJPxlXx2FV+Bdkb4ujgRZvb9HYAyFPWjZh2SG5DsGlDnSbMec4yZRwlK5MIOo8eKI6MkSM1WZSB4bysRk1cMFzzFuQAZvON1IgFwxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917266; c=relaxed/simple;
	bh=/q3gDmhJOHnx1BVm5HZLbW6RQIx1sECTIr+BMnVIEZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omeII1uFimE+ey+oRoElktT20Yto5WmmPCS7KW2+78lrQtObLRVB2n6JOrCBJ0iAfQ1QQAjoDVpHMrkQj4QSufIWGg0+TeDhFbwqHuzLoO7wAAerS2JiPOyqcJ089XYjUwkCGleIL/6WtjdAbh9ldmNjLKXaQGD8AfkSXjFlgyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KmPcXeQT; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBc+jHojp3GF8/xbcr4G1lB0bLl1VFqjBD0bCDOQxW5LjYNiwV1ksqYmBKj0ReyW7zR9HDejgrCVtNllwpyK8riSdgxK+XnOhmLhIvoVs9RHpAuYUffy0k5WcxnwCCM/qv/B/isz536SRCxSg35gacXf/NUSLK9ntIXf6nJbxcWzXXmumnTsALU9L4wU5Y2FT5rk4SX/TMy36RhSq5SoG41Zskr8tPQXKVP7eGCJBy7/KN8qtS3tGOWrywlYYnudr9Nv9yybNzLE+x8PD79/mazGsmkUwxkIspHsKH6K7dad5agsMyjv9sfDHreaZ7HRm+11GQArmVaETUmmx2cqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUS0DCft0mKujPvLIKdsDTWW6XcV6N60Or9qUGdXLYg=;
 b=TYQi9KdaUeYc2mb96Q15GU7VP5DERziXNS0eLWacd99iogE7P58+PDkY4TdHoMA7WDzh3JOdpXT7hchAQh5p1NBT/UYA88Sho1VlPn4oe/DMgGnbCkgVXdMH4Ix5HKMbdFIBLrDO3t3i5EJu2eWvCIvXzxNtptzY5d7n7c6hs8CISbOsXkVsPgB68vt8Kdz6EhThnK0HnYtH8g2kb+LdybgdgCAGDHc25OVa4e4E1qdBMofGSsr7TgOyhauLTNRwEw7I3rVFCGJs1CKX7RQUQFCIyBm6mciY/+Wh+7e534VBVwiMhbr1CNY2f3OkaevmGcOTrk4U61V7njnSBsCSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUS0DCft0mKujPvLIKdsDTWW6XcV6N60Or9qUGdXLYg=;
 b=KmPcXeQTd4TXYb96XT3SIrXYmgU+5qWfy6EIAOXra58ucPfqIKaULS7wawEftGuibLUIZtYufojupRH1529EF/Lk/5UPQxXynFVc/UVF0ZiYoLV+kxta7IvbcbbmsJrEsWnaxtpT6Dhd4KKYZJtk5VvdSqNlk8oBHtF/2D7QfaE=
Received: from BLAPR03CA0151.namprd03.prod.outlook.com (2603:10b6:208:32f::15)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 09:01:00 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::2a) by BLAPR03CA0151.outlook.office365.com
 (2603:10b6:208:32f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.39 via Frontend Transport; Tue,
 29 Apr 2025 09:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 09:01:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 04:00:59 -0500
Received: from xhdlc201955.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Apr 2025 04:00:55 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add `reset-gpios` property to example device tree
Date: Tue, 29 Apr 2025 14:30:45 +0530
Message-ID: <20250429090046.1512000-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250429090046.1512000-1-sai.krishna.musham@amd.com>
References: <20250429090046.1512000-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: b167655f-9b67-459d-31b9-08dd86fc5cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jv3bFnRQjznRsprTy4+mzRisHCv1vbl/+TNnS0uMW7sMetcdewpwqj2xVy+M?=
 =?us-ascii?Q?FPcV1G+UY/QkcLbcNSfL7rRDXjvq53SU3CvEYgkyigHqguh/bMAq+CdHhUK0?=
 =?us-ascii?Q?Dr4oDTZ947yKqB8MP+i90RWWpcDQsW3sfxwuw4t0TY3IX0vm2U6VM1Mrs5+F?=
 =?us-ascii?Q?zRMOOm7eQtXYqJlLykl+mKPJnxmz3gco26dgdr7+Lb4+Rad9LZX3vUtZac5r?=
 =?us-ascii?Q?nlmtNaEvqlUF5XRWCRpNtDbQ+zJJXBuxSoTepeqxj1nV1kVKRslXCkvxRZX+?=
 =?us-ascii?Q?gLSrhTYNtzsqS6OoUZ/ju6aYXyTIlwOE2lq/oZqFm4utD3OC9i9Ra0LYgGuZ?=
 =?us-ascii?Q?MBhFgEBI1X87OIhOmL/9n5Y5WyPifUCnxcmwIkHSN3j3J32K0VTDoiqC07tr?=
 =?us-ascii?Q?lImcjs+y/kob5bfmHYvdQ83xpyilaVAuC8IkWtzrpwWsaEu8N59D9rEE7fFj?=
 =?us-ascii?Q?uK4ofExQmuITnchAFfNXcuLMOXTk80lBWq53mtNrecc477cJw0SJq4tBLiwV?=
 =?us-ascii?Q?FqgfjVb4a2X/f44mOp2o688lhArYsmbrlnC7aNVa2sVsJ++jDR80gdxuTwvm?=
 =?us-ascii?Q?1bshdHbNx2Tpj4RX8721jRVvg+6cAGU762lMYGsUnp/YifQzEjh4dAXaaroV?=
 =?us-ascii?Q?dVGIYRyGr5K4PetTOr82+MXOEdG5g1tJbZG+EdWLH87gVzs1iQf6EDELc1Wl?=
 =?us-ascii?Q?04ZX69yzJTWp55W20gUgWJiTDJLA5ffpeCcn2HrO3WQEpNk+PjZZHH00i8w3?=
 =?us-ascii?Q?kfyDdRmG2vwLz7LIhFKXZMMeUnZHbypIpe7CxgoqieKpGpTNO8dWveaOJrNw?=
 =?us-ascii?Q?ijU6UI8vYNGIqB+wgPGqUobpp/jjsORy8TMMsTa8HA9GghYv4+XxOtn28yi3?=
 =?us-ascii?Q?zAGRJAqkz9Cp8jlqO8LOnc10QoqM3pLsnLaLLWLNBzE8vwEh52zOg0kakjqT?=
 =?us-ascii?Q?YJxWXQf4HZntUBsbUsSvlgMRGAvwg5G5Vm5nf5GwzOJaO4TrFAOaQROdCA0g?=
 =?us-ascii?Q?BBGgHNoymQYCG3tTiaK+s8uNpXSI5zq5Kowquqh0c25xUAtDu0gguKeJl9Sz?=
 =?us-ascii?Q?eKKv6KDE1vOXyk4z0F7s27WZERyHmFmp8TzbFQfaOQcpLF+83MRn0O2Ogysj?=
 =?us-ascii?Q?HTBAkIElkODFlh3EJg2PtVL4UmZltRvcGXUbDNm2uLvWTU/ATwLcq2BkjNpJ?=
 =?us-ascii?Q?lpFl4vZBwzaX1AlbX3BEajOn9TbMQ/5PIbSIZMHfCc5jeaDKSwA17jD6UTrr?=
 =?us-ascii?Q?u8xTquenRMAUTzkV4w8EBVRpThcVpcu9cShtPoKudFYQE4OSnm3PHs6wX/bD?=
 =?us-ascii?Q?iJHSfrWrSCrVdVmdEXt4VzlkLwlnqTBALz5Iy1ty35wL4nWwcvvH0lGiHGr5?=
 =?us-ascii?Q?RLm5FHbODe8NqbLCVIqowMJpw1ZXN5o0TFS1camNM6BlnBCmBFET17SHxKEm?=
 =?us-ascii?Q?5/auTQiTLIsdaLyj6y4pgwrEFuWQ9bwsII7yn4MFBsyvRonVIGuZsgVAUj3k?=
 =?us-ascii?Q?xi0TLQSejU5nB8DAX/Z+g9NZ/PENVLAi1zSk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 09:01:00.3069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b167655f-9b67-459d-31b9-08dd86fc5cd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973

Add `reset-gpios` property to the example device tree node for
GPIO-based handling of the PCIe Root Port (RP) PERST# signal.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v2:
- Update commit message
---
 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 43dc2585c237..e6117d326279 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -87,6 +87,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
 
     soc {
         #address-cells = <2>;
@@ -112,6 +113,7 @@ examples:
             #size-cells = <2>;
             #interrupt-cells = <1>;
             device_type = "pci";
+            reset-gpios = <&tca6416_u37 7 GPIO_ACTIVE_LOW>;
             pcie_intc_0: interrupt-controller {
                 #address-cells = <0>;
                 #interrupt-cells = <1>;
-- 
2.44.1


