Return-Path: <linux-pci+bounces-12888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2996EF50
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 11:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18F128ADB3
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD588158533;
	Fri,  6 Sep 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3D8uG+0g"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8961C8718;
	Fri,  6 Sep 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615145; cv=fail; b=Jb9TOmrqlW/Q8wdrHIX3/iFjEmanX9VL/gKzvDdz5kX70TDzzCASbIzcXOgUH+BdqdFFEO88JZMTrnwRNM7KkHvtCkwcCKRKqx1qppRbqtn8Ev2ldpF55wvYS9ZQiNx/sepbx69PU3sB0GsfuYOZNhvqCZWddZsMT095ZuywtU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615145; c=relaxed/simple;
	bh=A2YVHxkBpxh9utRQoj2z2+UfH79q7U03iuIC4tMk3pw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYLzBpMXxotGuNflM+q/p99dgWe2Zs28ECqeK9UUaGfIuDLQx0V3mUT9uQ0wPfIee3K97uwAbq0AgUlT8wVxDE0zHKM/owv0Mi86A/dJkaQeWfSHY6zfROAJZO3fwsqwsT6UW+kggcqxzXBFtim75+1eSje4QzBdjtpfvCrhmXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3D8uG+0g; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIQQI+hiRm8a/MMz7RVZkCAcXplMJT9gPDu3UCAhWyOK/6zcGnnVHx50PREoyDsuWp9w/afSVbMxEej3HvSzMWV5T9xh+PJM63vdJL8hOma4MM289iCTXnZ5ykX3jojXxjBa155EWzh67zNelcmhwsr82vcx1qWAc3wtaApwZdGH1vSauQtbWnocSYYVAkM+jxy3QwMdpUgz6dciwO90SoBMzcurpHmaUdawN8Vr2fOaDayGh+zoAdrs0aa+cEHJyqckZP94RtmZBRJGyd3ldOpA9S6lq+uKO7rnFAtnUbv+pGHo8plfLH2xgpAT9AVxeZixfu2CWyNMHjuqII9DVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Afu3R/jxP2zwy/ouUAQxAzxtds3TR41H6CNrKyLnR8=;
 b=k58HO8N9FXGNBSjfFIN6oHMn0Np1dWgL20GJbbNZPtFd5W9UYQ+mq2zPmtIvQZ075dB+iuL0jKaHaqwXLru9Zn/nwtoE4LXzq5PaomZuqgc2p1hyBUTpjcy53Wq19mptcRvm73vXF1bzvuzmlhfUCHXfOvzY3IGe2FuuVKHZEqnC7D2kpEO2oVIN6LNO8UnIi5B+vP4K/DUM83XPMq2YVXaiQSR99zJIiOTaK5zzGgdFKlK0gQp8ULr4wT8v8hvATxyj25bVon655iL032tPod4rA/dt6Jfm8GyhPDYuUwxg9I6cUUpZtJsPmVlvY1wpJHO+HDtw35l6ZMeNile4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Afu3R/jxP2zwy/ouUAQxAzxtds3TR41H6CNrKyLnR8=;
 b=3D8uG+0gDBbpWYJgIwZXFMpI+JAx9mS3UKjjm8/90b3e+paqdYOGdz9hXg0iDQCjTcO7c3KqGPWbWIPCNl5x/sEhXzhINtb29dPfx0zkwDIjTt3eqzUzSSQaU2nywYT+WZNnNiJCfn6EHj0b+NzrifqsZFgmCOXcI+bq9zc+xCw=
Received: from MW3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:303:2b::13)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 09:32:18 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::3d) by MW3PR05CA0008.outlook.office365.com
 (2603:10b6:303:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:32:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 04:32:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 04:32:09 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 04:32:06 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, Thippeswamy Havalige
	<thippesw@amd.com>
Subject: [PATCH 0/2] Add support for CPM5 controller-1.
Date: Fri, 6 Sep 2024 15:01:46 +0530
Message-ID: <20240906093148.830452-1-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 431e61a7-cdbf-4934-ddc5-08dcce56cca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xu6EIkmAiyqubsyLrmtyucdAKIQHj3UBJVZQGD6kNiCWl4xplq6e+QFaSSGu?=
 =?us-ascii?Q?X4w6TiuEhFA1SIe2vvBwMK4BGocKXR7PQ270FoRXzRpfGdVH1rIspPGO5t/F?=
 =?us-ascii?Q?nU4bMtewMnp/K0lJTjRWgF4XnhgidRWLDCkbM0RK9SvI7c6RUi+qwSI7BosY?=
 =?us-ascii?Q?V/U1yzMCPMd++Qmq8MxmJPiijFMx8kQhPdvVuc+LGk1hwsIXM54oCntdnBJq?=
 =?us-ascii?Q?ij0al1v9YC008zOBQmHPTkic32SgkWCatZH5IB3d8Lk8HDhPGrJVhR/SChdT?=
 =?us-ascii?Q?FcIGOyiiIvgbxH9S6ycfsdwVnEHyTa4jvl0MH3i0Nfc7RnJBQU6Yc5ZIuB/z?=
 =?us-ascii?Q?SzShZct9OxmlF42hCc9/OYU1kEniCGSVD32QOwoAJJJ/RlB+sZ+JF/3fASey?=
 =?us-ascii?Q?EdAUZRUXkx/tGB13TGaCC75LAjrCPKRRIYAX/euoNXLLJDzQJU1wPB3FFoa8?=
 =?us-ascii?Q?X0TY3V/CSDZxmcBuwpSyUpfA9c7zQqOnb2no7tOEzLsNp01Fx4k3seN+fdnu?=
 =?us-ascii?Q?Q0KBmaD1lQW/nT/QSiSlcJWSXPy/apu6La5uSo+J052h0x+cgdaMSuL5vH6g?=
 =?us-ascii?Q?2aVLC5NjOIu4srpp4xDJsyTN0UoojaO5kJ68kQ6kfRIuiZxgrNdHCQ+t8n3X?=
 =?us-ascii?Q?y+xYwTjN/JbIpCSx135Bv1G/PSksWM1BUKpzCSBkbCobDgyx11qqeTSWbyH0?=
 =?us-ascii?Q?idpxfql9OjtE1KMLGGXZWXa5L5JpLyvYW6IsAFowLm78Q1He9d4sh2ooOACf?=
 =?us-ascii?Q?+cto/OWYEf8GhKRXLxBPVPOIma2VXo1uTzMpIsnDDyKoLQMgKDmRDagmtOA+?=
 =?us-ascii?Q?fZvCu+KthLqV3qYTs7UsDKNW12i57OZ1gcOoGWBIAymVLU2IhthAPc4OQB6U?=
 =?us-ascii?Q?sQJJk0HivDoI6p/UOkYUkVlfqd4BZ/qUY+Evr+ZPUfG3Pb7yFccoMI94+CpT?=
 =?us-ascii?Q?kXVJD1LXTcH9jGRpADVIOmzATED4xD8aLKD8szcE9y/VxaXK7O7GZL2suDgu?=
 =?us-ascii?Q?5DqJJRd0WYpSS/Mi9wSuym/T76S5vwbCJJeXCGTUq7F2TzyjMXqJ2ZW9AKec?=
 =?us-ascii?Q?EpMLy+b4QgwtojNSyMNTdhzCvd1SYD/OcmlmWXa8uG3H1Pfj2kxm5lUwpb0n?=
 =?us-ascii?Q?9jMEYwdGClV9Goj+MKFZGHJqqzCPSZ1bSWQELEUz1eWopSNIs/0xe0sog0eD?=
 =?us-ascii?Q?VxJLr0irMkZ+8NlBJj2zWjtxJh6JciFMSV6IkjKVO5m0p4yE304aFjGoUwrI?=
 =?us-ascii?Q?L2nXgfKVqNmXxvC77vxSeEJqkQOsDkIYThj4XAC384mDm+WWyX2XZanQLy3C?=
 =?us-ascii?Q?b4r2dSGTRmbfHCSwLCahNZQu+x5IpHDKCm3zooOZvsTISxekx13Tx/pmZiHH?=
 =?us-ascii?Q?XiwQndPWHi1LQr0Z48p0CLyuNaqhpWedUk0/i2SPCjm9s7LmvD0/1U79IGeM?=
 =?us-ascii?Q?3lIqpcNkouVmES4ys8otnXon+iNCrn5B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:32:17.4005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431e61a7-cdbf-4934-ddc5-08dcce56cca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698

This patch series adds support for the Xilinx Versal Premium Controller-1
as a Root Port.

The Versal Premium device supports two controllers, both operating at Gen5.
speed. Only one controller can be used at any given time.

The primary difference between the two controllers are the register offsets
and bits related to platform-specific errors

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5 host1.
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port controller 1

 .../bindings/pci/xilinx-versal-cpm.yaml       |  1 +
 drivers/pci/controller/pcie-xilinx-cpm.c      | 39 +++++++++++++++----
 2 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.34.1


