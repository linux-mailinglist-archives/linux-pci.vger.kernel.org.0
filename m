Return-Path: <linux-pci+bounces-22627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36386A4952B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F51895E7A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E6525743D;
	Fri, 28 Feb 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JqJ788z4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14A257441;
	Fri, 28 Feb 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735297; cv=fail; b=cYeIZoKJA2kEgOXjDRRtEmYL0tBbK9y3/OceTI285/rQeRE2wKOXbpxQV2R/bf7tCxemUCLEltiOvp5yXKJYR5MkZzFNZL1nMlENpURhdA0AKcWOcvdzJ+kFgRRlEwwKKu4U+dlC++D14nfJksvPhfPuYRIo2vdBSds4b0YcvBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735297; c=relaxed/simple;
	bh=sWVLcByvdv1zgCmR6JhQuUi3/1+aDic5vEE5I7Js81k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JT6vOhvHxLYSXf2ZP/0oTK/8H2nd6CS9IiseGKRSEL3mWSROTf04a8UBGiO7vV/ZlVhAK2SyWPNGZP3eGsd2d7nDzKhMV2f4LRAERLT/XXZtWCOTJ1r+4Tl03bgWsQeZCV0wlwFigYf4HbjoCuKJKhOG49jWFrgP/ULLp4jvgUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JqJ788z4; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itMb3sMu637WP7ekzu57+ZWHSKVdJeugrmKIEc4KlZz2Ki287lltrRMgoFJjmeVSKSJ35NUe8LyXVI1MqjclAGuhM9KHRf8zhsmt8N15STIu3Z3CFDNNKQ7xJgZKbN9desNB7nHGzTJl0y9q012dFcZXoFiN8QSwUzOREDZPSOqesrl7l7F0U3BTzjLxXNTu5zLs1lfHh+pZ0zAyc2utmrsesYV1aWgEfGnVBrPIci9sLmjIW0UXsp3bXZ9ijbM5JmLk7gEXgTNNYwn8o5ViAimSluQS9WIY5dNdTSAAxpCsYwpBxKhT2neTRyHyd1VorVE2vmOKLE1TelZbklqPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=xTpppQ9DcOzvdyQiJjCsIdxC6825QwqI2HRi6tJsd6Naukjt7ADovRJ/URteYi3rcAwGJDNQ/kVXik853O4+RqXYOaRRdtkXAKOXqYdWpqqWxo4ZqzrydsRqZvSCKQ9MKSuBMAS9xYhr2nQugnZ//eEUc1M+140vg/Bb8sRpmGUPyh3fIylxbllQ5cl+noM2ZzEqqFhcEyLkj8AiOCtKa/Jwu/R2t6XAZrtv8WLxxTTB9Q1YUG2Q0v7BrC+UJE0FSEDYWM2idGQoH5m2DcLi7gYFBRM8X+e7DGR79pnM4WqvLupmk6zspVdyiKevYqZoLqRRQfcDulQ8P+BZYLv7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=JqJ788z4aPeaqbdk8DFaYT96G5C8dwVZTsFo3uaZA1gQY8sj/qwah4rpHYuk5R3rRhHE3mpuL/Ln0c/kGsR82zVv7q1qpWcB0q4fmcKOkKQ0s/MyNyVRJQZxk56osLllHC3v7QGeleKJh1jriYoVsXbohnTIVKh0w7sYTtf3PDg=
Received: from SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::8)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 09:34:50 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::97) by SJ0P220CA0021.outlook.office365.com
 (2603:10b6:a03:41b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 09:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:34:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:34:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:34:14 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Feb 2025 03:34:11 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v15 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Fri, 28 Feb 2025 15:03:49 +0530
Message-ID: <20250228093351.923615-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
References: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: a9593f6f-e1b3-4cb6-4abb-08dd57db25a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dOXo4zWtgE+YHKTrXfDgD2hh7l0ijieUzhJe2I4SlQWqyROHmZSiOGFM8C3+?=
 =?us-ascii?Q?PqEt7NZkG70FaNsF0cYpMKrDIfuLkaf1Gv4NJnfRWEnhePeUEA75lBnc2R2T?=
 =?us-ascii?Q?SxM3ks77FkeQ4AHOllOosPwWiaYv8rFclYpKsZ9yUAKmX75zcJOS+c2PlQon?=
 =?us-ascii?Q?EuN+r29wqj3J9dyQkTxZoPAW5Hwq0eaHxanGdFo2g+wZe0BzPYOV3+8Xjn9J?=
 =?us-ascii?Q?ZnSQIc1JnOu6HVhKDCXk0N3ys9Gn8IZvf6coCIgUyIlPWtaiGk6jxsRM2QeX?=
 =?us-ascii?Q?RGjlsacNLkHxSGyjv87gOplWLc21U+X8p7kicYKEQd4tly56JLfzgGPeRfOI?=
 =?us-ascii?Q?hvVLaUzuvEI8tTN8DVlnYIGTVi3OU+Q2fN5HYboFDyCUnz42d+7E01n/vwRS?=
 =?us-ascii?Q?47g3w38xiG8oRcXAscARIPzV29apv+4OYN2KERb9DB6jjDBBG4ssCx4LWCqS?=
 =?us-ascii?Q?wT5OYowyOCbYPpXYgIjrhVjL4CeHJ8zk8ipd4N0c98h/aHN1X8yKVRUolxMC?=
 =?us-ascii?Q?rvEHDytgbNbtY43KRumbXHbJj2pTFzh1UsiYSKCxqHn2lyOOfsPGoKX5uYhE?=
 =?us-ascii?Q?Y0zQ5Z1lKLZ2PbaxgxWpUJSWFo3YNFJAtYmhlNt2f7HjgtOk/SKryDF9MGkY?=
 =?us-ascii?Q?vk3+Hfy1RAA8Acl1zSUYThKAsZzhwKDKI3k02uUzLrBXZ6lyCrvqQGfVg4aA?=
 =?us-ascii?Q?wiAcPxBXhQ4fSrhSFBDAX3T/XmqmO+8JdhqMlKqJJNUaVnvRIC0WiP0Q+XVj?=
 =?us-ascii?Q?fIjNQ9VxXBLYSW02jJjqCmlZzKE8ZQ++/oIzhIp+ckUR6ZlQxNRIvR5uCrPU?=
 =?us-ascii?Q?ehYfwl/LDukYhZZPcWlGzcN+N+F/V+Z34KjDusGw2xf+Z+bqMkgAS2wEUWRz?=
 =?us-ascii?Q?7vHAxk9mrLA8aooTLhhwuKNhnQZwrLuA/i1HsdR3ghQ1COfNOiABhSBrhJNI?=
 =?us-ascii?Q?9xJgwfnCJqzIA7tOxUdg6yFvHaPVvhSYNkptGL9TN4mpSRKHzylk5KsPUW0C?=
 =?us-ascii?Q?DBO5sG/v6q0acMwFQ8VQIChhXCmdgw1xjwN4Orrz0pPDm4zy3KFH/ZVq/JN+?=
 =?us-ascii?Q?72qDAav9mFL1Q2ir2Q3gF+5p8XhtQx5aClMQb3BSVj6wtqmfkOR38D0yW9JI?=
 =?us-ascii?Q?nyteWvdJyzQ16YY/FcYJI36UZU3wnpRTp3TU6EQ1jdqPd8MF0DWTw/u8sGyl?=
 =?us-ascii?Q?+Fd2lvFaEMswYliva9tp0zQkt1K7a9mdsFyjLrSZ104jGK0DwKYRTS9wzr1X?=
 =?us-ascii?Q?mCDZnFAkbpgun34daVMoXm/HdpoJvcGze5fkpRa86sk6tqwKLrsX0SsJW0Mo?=
 =?us-ascii?Q?7yXvKDDwGRtwwc/yMOYRrpQzLYm/Dw1UVotNxhUQA//I9dfzKylQ46Hc18CO?=
 =?us-ascii?Q?8F10489j6crGyQiE1tNHZqvvMNv2FHLTvEAAc+1lwbIAcqBTUsVn+RTU6kDI?=
 =?us-ascii?Q?ofxE+bjGifnwfkivSJkVQWS6MG8QVsl0dtccvXPBFbtf07sNEDwaHguH5r1V?=
 =?us-ascii?Q?dD7sHbnEGi+QDpI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:34:49.6000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9593f6f-e1b3-4cb6-4abb-08dd57db25a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

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


