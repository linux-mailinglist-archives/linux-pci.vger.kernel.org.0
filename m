Return-Path: <linux-pci+bounces-17640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2E9E393F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD0E168F35
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0A1B414A;
	Wed,  4 Dec 2024 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cy9Dg7zX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CA1ABEDC;
	Wed,  4 Dec 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313130; cv=fail; b=DYD1jPFZTskYUaDgRASqqHlOPzYfC4M44XxbDErFu96TTFBus8jLhKYx9Ae6g0UUSMjWOHh6osIxXm88RR54kUFzmp4xyc5nZWg0+YaF2YPEzKImPTcoSBteUUbmFGJaeE+Ev8yODt4vPwnGQgRnO9hnuioGIu9KdYkNhk0kNko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313130; c=relaxed/simple;
	bh=p5lEA8luTm1wqTxn0OH94BG6kYYpZKR740dEAOWaKf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hszJnXhEn+hBmrPcm7tYUjRv2yJghjHrYJY/MA1elhEQOp0J7/1zGDkfjYVbnnyHUbVaov46vmJY4wMRHwlustedz4wZzj+M2V/UnqcSMeFag9rgsPtJu/U02hkpOr6BO/gQxv00f7/46itBvGePihMvUJyOHUEFpzuQTLu9Lxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cy9Dg7zX; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNOU038Ij9DWVqO1Ys1i63/AYhGMnSacubekZb2BeL/VaIileka7FMycfMoxx3B9h2q79suoCTZyMjBqqrPi+sze89U9LO+9T3A//clwW6LVruqmbYjagpWIdtTRwG2Yhhmx//neBehACmKJ7eHq1UeszDGc244ZBcmGPlKREORDILSDQR6BvheAX/WNMqMFP/tyO2gTrX27QKrGO4r38EDeTuw/HZ7X9pFEzQk6zOlsq351ZZKd9aFdnli7Od5kkG0EJdrZ+zXFl+9RD4prlE4B1qLhZh5AykHjBduB16GZF/SVJBNgjmChSkxF97fyEtriITgbMGnm29mXQMiyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U42IGIeOCX+XZVxJ4xtEhtnjRkQl39MLW0N5Pg7beF8=;
 b=m3TD8U1aRgChIyZ2Y8UML5kXtIDZ4LCcGIBClYwyeQyblFsvPDGKFbgcaIjewy5xwJv47brGYxiDWAQ0oIZBBSaTdF2jJ6HC6wv9/d/NMEnleMTJPxfeIVOqWbpd96tTsoaDzDngjKhIe5tp22/kL9aDWSoDCU9GrB2HTYS/l8YmwvyaCKA5KezjzIxZBJSFco1+h1nkwDPLoukz8m0X4RpF726CJZFNISbFdIhhkJZ5m4qluGZy+dmtO713X1T3toC5UPSm4D0fQWb6aDvP1QNnsBExGYnt7R01KBVEyr5wshtmVI08cii0Vwln9QwLnIcjPduyr6HBDv0i2zjL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U42IGIeOCX+XZVxJ4xtEhtnjRkQl39MLW0N5Pg7beF8=;
 b=cy9Dg7zXyCyNS63DWdclTQvstEncbAE5VCjTgRgQPC0R2REF2uj2YvAC7kLmgbgiV7tbianQVuvWKs1OZF42fwbg8bBM9cC41peNr9pLH45U9U2H92bCIb4S8BXWWfbOPfQUmZ5+cmyyv/iUqeNVQ+XtkkzpHVMKEw5onEwWnyw=
Received: from BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) by LV8PR12MB9135.namprd12.prod.outlook.com
 (2603:10b6:408:18c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 11:52:06 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:207:17:cafe::12) by BL0PR1501CA0006.outlook.office365.com
 (2603:10b6:207:17::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 11:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Wed, 4 Dec 2024 11:52:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 05:52:02 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Dec 2024 05:51:58 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v3 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Wed, 4 Dec 2024 17:20:24 +0530
Message-ID: <20241204115026.3014272-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204115026.3014272-1-thippeswamy.havalige@amd.com>
References: <20241204115026.3014272-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a942a82-4060-49ba-1f18-08dd145a135a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VjKrNxRX7bU3sglLLPBcbnGIcyILvNs4PmvLvOSejbU5ezTkArDd54Izw9Ij?=
 =?us-ascii?Q?CWlu4YcKXnoeJ8K6Q1ysUM6IBTZ/xMW1L5x7ouzNS/07fsVGr/CaBKWVuXCz?=
 =?us-ascii?Q?9RkraaXpR9D73pI9JyOqZC/4npPsg5QRKc0H66VlDGFAFZRIVO6iWYN/npch?=
 =?us-ascii?Q?+acl81HpnsdJhWXqYPBBfOwf/3nrN9bfVSlGJ8aN22s48XomGVYvfE3k0LQZ?=
 =?us-ascii?Q?fs++APJ0DExBWJKaf2FgnFrxnN5vp9ZmwGa5yyzF0MoEBdBhLwa//oBfEIEh?=
 =?us-ascii?Q?PlaF4UlUfSfI06uDQLo7RSLbfzhSWKxOPSPeKCDG0BRIkgc6UWQYmF8sgJey?=
 =?us-ascii?Q?vcMyrUUrBqxyJiiv/8UkRaEmF59ylaV7SQWrPKo1pPKx14nvpod2kiSLUX+p?=
 =?us-ascii?Q?xFBQO6KSMpW8JkSGy7FZrbayhSUZqA8s4PU4hZojpozxXe600CJweHHx8F2g?=
 =?us-ascii?Q?MWZsq6910qLWnNPsZ6yJZEvosXe4QwOISgcVThZsVwKo5MwbD0JsuEvgcnrc?=
 =?us-ascii?Q?M0yp/jucjnyFh5bIMI9ZgCIzgXGcKH7PFYgQPe5ufTZPh7TaZkOcIV63lFHW?=
 =?us-ascii?Q?1vjHZChC7NGT3/fEmZ75dkxmjYNemXn2sA7B32WToq0aQTcgGlrFTzzhJhTN?=
 =?us-ascii?Q?eKzsXHz5wfF+73q6y8c7FmHCglFRVgpXwmLiZYBNPwfGv8cHgMrA91E5QLPI?=
 =?us-ascii?Q?FBxMWuAWdn4khVqmn7C8l+v4tUWwe619CNnTTI7DmmvY5XWHkOBNYkL7dhpX?=
 =?us-ascii?Q?T0oNzj42OONtgnvYIjxM5kaY1NRARHK2l3Gyf6MgIeoTk5W/gtqUghM6Z5uS?=
 =?us-ascii?Q?ffJKk0F2u4zaxSZgFjpVZizdsjTwJ9I3sZhMbQG0gAu4Jw2o0enX7gt7ZDX4?=
 =?us-ascii?Q?MUuLInlX0Odnh3Ml4D68dhxLC5+2uvxvrqG6cnUq06kpZ6MxdA/6Y9bVGIDv?=
 =?us-ascii?Q?3Xw3eIpi5KluC5bTbzS00hy2hZlNaSgS7HRPFwfgxl63HcM2FPOb7VOH1QUh?=
 =?us-ascii?Q?sWQXPnK3u3FUVfOKVMzUgcZm3f7F01Np8T62rpNyZ6vzWQ6PtiRIZcETByQS?=
 =?us-ascii?Q?3ALCUn2mZcrq6gVFOopUUi0NGy+r0shgHgLSJEkSmgnAm4VzHKnSafkShMfN?=
 =?us-ascii?Q?W4Xila3sajw30dgMU/3oJykhEqOOG8g2wRu3Z7vg24/VqTJNZRSS2fp7M7xp?=
 =?us-ascii?Q?KrcCKFo+1RDI4ko6+FPV2Q5ZDiDDKedYtoYWsFCaddO+80A+GMvHAGYtD+w/?=
 =?us-ascii?Q?2mZGmtj8IQPK4OqNKuWF8kB5J0m9fkBIcUQ8w8zQbhU6Ppa3k+25UpOq3hMe?=
 =?us-ascii?Q?P0hbcXyJcqROp23+ZxtV1lnt86uStmb3wef7qWi2lHL247ANil+Qt5jNJHko?=
 =?us-ascii?Q?vwd3Kdnjk2S4IKmfxG6tlsULInNZXuGKOTWzmtXDHMYi03rIfirDqVFVX1N0?=
 =?us-ascii?Q?elQVKM20FnSn0kZEpAeSmNxlH3XFvzZw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 11:52:05.9982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a942a82-4060-49ba-1f18-08dd145a135a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Changes in v3:
-------------
- Introduced below changes in dwc yaml schema.
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 548f59d76ef2..02cc04339d75 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -113,6 +113,8 @@ properties:
               enum: [ smu, mpu ]
             - description: Tegra234 aperture
               enum: [ ecam ]
+            - description: AMD MDB PCIe slcr region
+              enum: [ mdb_pcie_slcr ]
     allOf:
       - contains:
           const: dbi
-- 
2.34.1


