Return-Path: <linux-pci+bounces-21148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA2AA3058F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 09:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F3F18864FF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEF51EF090;
	Tue, 11 Feb 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QrIs2NnT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133851EEA46;
	Tue, 11 Feb 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261858; cv=fail; b=tMfDg8w7Po79b7m4hqmIiMCtYETBsoA4HMMg+dholyT5DoTuFcR5/aZTFhXRdkSGYiK34BxDSfhTgUHBNl7S33rsQ5aRrcTtB+xZmvALl12bWWwaEMH0KWoiMetZ/XUJjURImg+YcvvAvtWv4WA4xfHrqMH575Pap5ZF8qvqAQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261858; c=relaxed/simple;
	bh=ieO1+El8FqQTv99HTQhxHunxwwJohy0A2ZnhoVVRFf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdYatg1N8xRVxuZpQmepunjdb4wSRrxV42PCRPEWMXAccVFBqS9dH6u/OhYQ7+wo5gyz1/oZWkByDfNMYe7P48mzMqAML9OTIBVBvzAatUc9V+RuWgLTvH2YCFSFbmn/P/F4YDB1Nb8spVP3xDcA1i/ISzqfAT+1YE1J6zuAik4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QrIs2NnT; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYQm0ztOlqaEt0yUsnShSgz4QbhxtnV4q0hKClrCm8IR88ZKbRN059oQpm9++3gKhtgQ7Kyy5PwcsteXHwRLzInhUt/5PUsygu6Pr+Beu/LXvOD3XkQtNv60FRh7a1d7LNlCHI4YyiBhHT1Pdxiq0aJ59fzmQhAzMqdIMK+1o1KHyxos9ICSZGBPhsdY+Fhnr/k/s3d0KK4iGx9l0qp57EV9R1l+qfLCjQDHkHrUbxBEZZfTBKpeAW1OkrYB1f98jtZhaO1A0rjYN4M1BSO7tDfwaDEhZwbBINmOuQ/zSgd5rip4APXVxfnyR+XXDEk+3GS8NO37T54iCb5z8oKkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLnOfWh5KOVmXiplmruPnhvebJXrJaZq4rwWqOFkJ+Y=;
 b=Z44DpLyxe/z5oOMxtfEMYiuRgmMud9oZJfZZHxzhecAS/kE31Utc7irdO1MbZ1b4Z2ZU+l1SeZPb3+dYruZBHbdczyF94zfA5JP5j45i+G7HZ2k5+zn3KtZnU3566wbGZkMtuoBc14MHpE2dw1ARCMWjy+Q01F/pe9StDAopl94JYWqcFHZrtXCVDuR2Z5Sifpz2ABhtHRaD1u6wCt/ZSHXyIKJFqK1Y2iYVBuGimGpXUf+kYlLKMANTH7lwcpQmybvtdNCoDd2DFwXkB4suK08aW9dtv09vej7yZyCMWYtg2dJW7hJPYsRhkuEp2+OawftxrQlz8x4K93sxMrbnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLnOfWh5KOVmXiplmruPnhvebJXrJaZq4rwWqOFkJ+Y=;
 b=QrIs2NnT55PsJEEL2KjCek0nr/Qg/Bo1AhDPF+dADQm6mQhpKPTtbLCL8DExsCm4uY4Xm5n5qkHYqmEb4ZTUoX315eswu6QNH2uErbmYBr5167rH/VaowMr68dEUGu4Zs/U7zxsq2i7Tn9Y4r/Xbm6YQmnEbjFKQmEtWplPYBV4=
Received: from MN2PR11CA0008.namprd11.prod.outlook.com (2603:10b6:208:23b::13)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Tue, 11 Feb
 2025 08:17:34 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::66) by MN2PR11CA0008.outlook.office365.com
 (2603:10b6:208:23b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 08:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 08:17:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 02:17:33 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 02:17:30 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal Net host
Date: Tue, 11 Feb 2025 13:47:23 +0530
Message-ID: <20250211081724.320279-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211081724.320279-1-thippeswamy.havalige@amd.com>
References: <20250211081724.320279-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 989a1ac2-8268-4f00-8588-08dd4a74896e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jTReF3fYqT4mFEUpP9BBBH2gSkQXeYUXcd6tMBlgIqk+gIBt70iKT1fkvel7?=
 =?us-ascii?Q?guiJFKF3w6hCcyiVJ+hkUimv+TBEzS97yO+tecoRiWG5a7F3JdfaAGBQZifn?=
 =?us-ascii?Q?ROMG2F7TeojvMSuvYgBCmYMZGz6sUanNUjM0FMRrCVsYxrjG/Dd+TOXJvWJA?=
 =?us-ascii?Q?d5G/XJmI2P3h6SeuC2361q0UTnOPOnKzmEB3IyELMO5jYUGAc47nqyonUVGe?=
 =?us-ascii?Q?0PqjjJoK7T7IxLUjbL0Delf5ub4DezIBeJAmV/gS6fH7jH1dcLrOQVdvlmL4?=
 =?us-ascii?Q?qgS+I3HvKygTdWgtXNy9L604zvacoO8SVep0AhYEk06Et/tvvA1vd7R28nz4?=
 =?us-ascii?Q?aexzGdceE9j3HiKc+7MWLrsaESAcp1kOOCH9Ky3B68yhT2eIjgxJRHWwMhg4?=
 =?us-ascii?Q?rrp996NZd7giz3CKDkeIEBlD77x3japu5XfGKDoDC6JFKnzA1gIC44Uq9k9J?=
 =?us-ascii?Q?VD9sgY8nkdU89PNBGOg55DBU9JesLaoPxbHnLQLg526zrMSGI0WT6ojdaYn4?=
 =?us-ascii?Q?QI89GaVTsdeRLkQnb4jJmeOCABCJbc29zyHaKxGJJVpY8EOPpqW23riL/6jO?=
 =?us-ascii?Q?ItfutMHD5APtO7lqj8hTbJ74rd3duB46w7Da0z51l8dN2gR6LGqau8RSPj7K?=
 =?us-ascii?Q?CKgPEPOwWy1TqUau32WLYcsEeFeO0D+x40jcPpwUckrVUtudifbjIaZUTxak?=
 =?us-ascii?Q?KWCGpUI/p3UTbcD030Wn6+Z63tsmUifUBTNzvoUcGdEQGmOwKtUxOTtuyenE?=
 =?us-ascii?Q?rJ4SdI8JnwHoVEjR2xJGrUysBfo+aFiV2Md2SoGVJtGzVbLXfxb81DOj5mU6?=
 =?us-ascii?Q?UQ5L0//X1xm0E/dN/jiFfL4wlv4l/eQndqgnGlVDofjZPov2RHzUdWAX/Fi3?=
 =?us-ascii?Q?/PM2xoXM/6zmpx3tdlOh1C1ftbk1imXgYI+8hV4bYMI8jjd6SFcNcCGo9AJE?=
 =?us-ascii?Q?nxlIlKV3/FMlsnIWUwrC11PxCu++z/MsaPeq3igrS37i5FDWdvjh0ayKQMbL?=
 =?us-ascii?Q?rwRZliKBtQ8W6pS6YigC3ubCDiRmGbAbbGBjP8RiJuKz1BW9jatuDZNXgEY5?=
 =?us-ascii?Q?dsZjeHNtg9KdCCldnfbICrspR0gIFsNmM6atCkT4ONF0NCsCjHJWqaQw1M3f?=
 =?us-ascii?Q?kq62JlhxegNkTIb0LVwonaPWjILtUggZs03z1cFU8lbF8ZD1Mv/8/0ktpRG1?=
 =?us-ascii?Q?kytXtVjZ8I+LIJh3gxfmnIe0EQAhWMC92N4HjWM7eU7OkIpDs2lPvEBp2De6?=
 =?us-ascii?Q?cpp4dTM9zHV5lbOHlNXH1CdtsIGvtBGpvtu7HxNtt1MoSrBzLHjXrVHm7csU?=
 =?us-ascii?Q?+q7wgklZMHzXPxk2pD+DBlsd+gM3wfgwsFPf6fPLj4b8NQfiNcSB8OVwmimH?=
 =?us-ascii?Q?3vfOE93eq59lVVBul0viO0QKUXlEwRbj3YYmhtu9AfVs9f0mJbB29FSvYzx3?=
 =?us-ascii?Q?WY6K7hp5tdcsiYdoLxI2TojlOhhHeXBqptppDameJCX5uMYfQ+QwIxs5NQF2?=
 =?us-ascii?Q?6D6Ax+Q6+TieNXE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:17:33.8080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989a1ac2-8268-4f00-8588-08dd4a74896e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859

The Xilinx Versal Net series has Coherency and PCIe Gen5 Module
Next-Generation compact (CPM5NC) block which supports Root Port
controller functionality at Gen5 speed.

Error interrupts are handled CPM5NC specific interrupt line and
legacy interrupt is not support.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index b63a759ec2d7..d674a24c8ccc 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -18,6 +18,7 @@ properties:
       - xlnx,versal-cpm-host-1.00
       - xlnx,versal-cpm5-host
       - xlnx,versal-cpm5-host1
+      - xlnx,versal-cpm5nc-host
 
   reg:
     items:
-- 
2.43.0


