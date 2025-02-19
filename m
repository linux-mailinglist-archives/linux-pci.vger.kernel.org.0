Return-Path: <linux-pci+bounces-21802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE850A3BB8A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 11:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3964177504
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9651DEFD9;
	Wed, 19 Feb 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IfIXqBAY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA51DED66;
	Wed, 19 Feb 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960500; cv=fail; b=H1672A+SpNFVpKUskbKulbnOKBl8kqvuVI9Z7xL9w3zrW7k2pJFiczvg54dwvgrfTGyS/GXD71pHVvxKnM/CmF/oKLfwH7c5L6w+1s8GFpMqKBVyf0whsX8qrIn9BESGOcWjW/dYljz85wmTUQq0k9swRQqMsAiokTLFlbwoDW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960500; c=relaxed/simple;
	bh=sWVLcByvdv1zgCmR6JhQuUi3/1+aDic5vEE5I7Js81k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2/3HuqP5ZVzhX9ogTU+zM5JqgqfUdEhFxlL0o7cSj2RE+2THjMO/lhHowfAQJPwYaUr1G1iAov7g+71a/Q3krdq7RGwgIkXLictAnFElbGDm3QzbPC+F6WE9jf7OxTrLx5r+UxJl8+hQq+kIGizXE36Qdgx08Ycm0JSZGHePpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IfIXqBAY; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCGuiRFBvG0/gnbHJC3ek08S54AA/RrIMrlZy+4FJj8iaRu2u8Or0j2T9qzqCEYq0Amz6oxsmnUsTsaeHIhbxC37ezUZfwXjdG87nJctDgi1YmWMFIg3jQvG6uwsKP3C609Og5/+5+573CqZ84kRTN8LeZ40Ij1j/EZjFceXU+aq02Yd0UJpJGxP9toRhUA2NJYx28FESXqEjMVh2+IgdeOEI03wGpJd72ymZxHNFLn6/lrjlIoRu3j+4skZgmnVK2fyTYqEMtioDnIkbP2W9AfX+3bWOEl/vk+Lz4yxiPtE6XOqureSaFBSVO2QXYCUH9s6NAr/5P9IwaPn79cIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=n4mwhN6IOQMG8m96HEmSKOv/v6PF+UUrkf5DCyc/zCFuL2fMHX0vbBChipuJ8u+vxz2MH7IqDrx393C47rvIZR1ZoShtJ6ptDpfTNQ3CLsnq+MmTgUx3/lN0NK/5xlJyxO7oZboehNiik8PBxG1nY7ssl3z8TwVQi1c9rEwK49Du+1wlbRo8X0zUnqFia6pqwF29MsSETge+f2iAQRcES9yaaqJM16UZrfZrYs8/d+4gmLedZMyERiDjo7i3M/3b4+V1Gj0zDoxpthkzm1GUdNabor+gxt37DMyBVPUIvvwkIGOpcvd5QL7Zu7CmwfAziCUHQC6b+RbCozx0dP/SOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=IfIXqBAY5/EX/3zUeOmUjU/9lrAl/3kwFM0n4pR6IFJgstezxi5Jpi9OONmPbnWkfkqB+osmcXqtOpSd+hqNN44pY5hbtkT7HPNXHE839/0I4NDKPiiG7kRaSV0hT2otMBjBw4qImHirRaSJ31uv2bW4hnzC/uCzNcNf6e8UsAw=
Received: from CY5PR22CA0005.namprd22.prod.outlook.com (2603:10b6:930:16::28)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 10:21:35 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::a7) by CY5PR22CA0005.outlook.office365.com
 (2603:10b6:930:16::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Wed,
 19 Feb 2025 10:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:21:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:21:34 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Feb 2025 04:21:30 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v13 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Wed, 19 Feb 2025 15:51:22 +0530
Message-ID: <20250219102124.725344-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219102124.725344-1-thippeswamy.havalige@amd.com>
References: <20250219102124.725344-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 233f2070-0931-4385-164f-08dd50cf3032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jZvooQaBsKNHT6/rJ1xgXZi+SqdVPJQhR4Nh+eMXLbws7zP+ZLNDuyrMVX8B?=
 =?us-ascii?Q?9HGDC8nx0enOC0mXyLH/UIRo10bmScZsehQBsQf8KKHMlVn/WOI0CXzLwcnR?=
 =?us-ascii?Q?0fHa5U/GeRaFSg4r/m/f7XCc/aOiNRtLA2PXQLK6DZeqPQzzitgThUZaY3Hq?=
 =?us-ascii?Q?tWrbM0/6We3/9dEhdXGeoLYrsP4VDYGvKPT4nVpnmzx1CKNZh3ThXkPBfPlT?=
 =?us-ascii?Q?xBlpz8yasXYMsrAd+ZnAZefAKnxgivwh5IKwNDLm6xpaf/7Rt+/cpJXkXXaO?=
 =?us-ascii?Q?0mq/wvQyCHcq0uXPo+oo/O62i9ayEhcoDY2Kxup0+7aIPlPWORbybx5SjMt8?=
 =?us-ascii?Q?JRSOu4QyyV8faxrnC1QqHIlsVEH6ziF2TGNvYa/NHOGq4irZSMjhVv2l7WFD?=
 =?us-ascii?Q?NOlL5pQcSS224qGZualORJ/05WJnK+MvSMGdBKxYbTKG4yRD/BDcaHiRY/Zz?=
 =?us-ascii?Q?C+ToxUXWT+9uPSnhk455GEgIX2CX7PDVYu/h9Ja7uIs5bKYZjpBkw/4Ezrjz?=
 =?us-ascii?Q?Ck7SmpSulF2V1Cquj9059UPG4c4dpeALR3bNHsHZF1zBaQtoocdKst/0q0pz?=
 =?us-ascii?Q?GB+OXhO3CC883S4tsCT1aM4Uf1qkV9SVIJukVk/Q80Rtj0EYgouU6pu14xXX?=
 =?us-ascii?Q?c3fbMYFdzWJM9EvTX27UOScOhG8RhAiEPkquWHSjqgU1EokdhaumdzwprGIK?=
 =?us-ascii?Q?/68glMbaCqpayJVFus/09IyclaCYWx+br3FRa+QdiWfqA1wnRK4C5zutNFPJ?=
 =?us-ascii?Q?//AIdoMXl8Z+I1fYGz8xDF3i6wt/QiMoBD5cMsSE2ITeHKBe/4z8r7ylRfk2?=
 =?us-ascii?Q?CFpuW1T+21qWDf+m8YBepK5GKVcOXPQnytX7bfv9LdExUrVdcPW80sWPqjq2?=
 =?us-ascii?Q?ySS4PHYVzcTpD6PkWQml7PrzFNTLfa9g1C/2mC861TDEjYvnIhwog14bp29Q?=
 =?us-ascii?Q?T8hEZUUxqfZ5biPVfQIUhAv9QFPXy51be37muhgGerR51xzQfuhYUS/RPYO1?=
 =?us-ascii?Q?9IDdjNuwknjsMI1K0ebd47x7AYqPCEhMd9S5nGMf4rxEGU3GMUiJTnYBUimZ?=
 =?us-ascii?Q?4cSP247DlzM6pS4q60GZWC936uXPATPOX4ihigIHl4kV9aQWw4U92i4crt/v?=
 =?us-ascii?Q?oYyKGjbqitkFFcLehsk4FNExrITOwG7vy2VYj3Ps39CnAy1hr+rWlMizDofZ?=
 =?us-ascii?Q?xK65Vn4Ju24HAdxUn/Fo6eEQh7QMt9xG1M4qMSL+biUWjFcwrPrKGR6WRJ49?=
 =?us-ascii?Q?n00SgU9GxTuMsJjxKzT9FiWPWQjqV/w5Q4XRG0Os85qxgu5KWMSKfbTbVtym?=
 =?us-ascii?Q?5kG2gO8RBtERuk5cRqYnnBg23l31Bb00l/kO2/iPeOmkpDS93AXqOjYm5sqf?=
 =?us-ascii?Q?EOhKZJEAqAjxYiS5/paUPCl0di9lt2Sm/FJXtNXnfADdA2DvX31EqoDPc2MY?=
 =?us-ascii?Q?QOS+TneQkwrq8q2nxS+9RjNO5k4aM8lbp229XC/osWtZgL2O0zA4PL0jDjn8?=
 =?us-ascii?Q?SHAP7JDKjHqYx8U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:21:35.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 233f2070-0931-4385-164f-08dd50cf3032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932

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


