Return-Path: <linux-pci+bounces-22163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA43A41676
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F73A2E4F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72B8241666;
	Mon, 24 Feb 2025 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PGdYsJhp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071C23F40F;
	Mon, 24 Feb 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382920; cv=fail; b=uSF8x5Rgq8Pwel5gBwvoluA102NQRGVgiDgIeIgf2mEHLWjxYCnSUpJuqLjBLbr/AMvrIQ7xp2hpI3pB8o6LclxBB8TVB5ajLxCU5C3uHTJxIgvK3/z9O7xasxLkAk+9kdGfo6PbdCBGxdkT4xAMKFkilX32NW+A3Ly37INRTvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382920; c=relaxed/simple;
	bh=yKYPPxGuNopiJX972gaVEzZZD5L3YwPgsCWXktV4VUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQX+7rxrE5m+kGp67Qoj07be0/LtvC5PeouIBjLv6v3O3clLlt8dsPtV5TUDs2JYmXmDnuvSTPCWIzzsHKqGPbPuPLAF+6FN5LUgMbhD5xgXwo8a7bUiyXsoktxD/pqpOCEML+Nl2xoHqB9ZkZD0vUXcGI8MnFVZ3MP8ul5pgJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PGdYsJhp; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSYENA0fLeFA20R2EKJBVWEDYcnerAXezJZ+ZtvC2vxEk9GOMT1uulm51IqUf0aon7qWv7TCVSF5A4iJxKmTNjBXhaKQ4A8E+RjfuotgAlYWUckOYbZPGK8jkGHC9PdWrBBVkK+LibSgGUkQfSUCsmQAulYighRu3Q7chU/sVt8weUtsOxc5Dcu6rumzGgDxxfmyTKBeiXe48/UT2MseCUVbfcLTeE5nz4dqp8J75Y4bvf2xl/Hhh1s8rLHBmyX9g89cLwruoX9R3pVNPJ0jhl+bWkZNRaBmSiC8DFnTR22CF8Kvb0tK4CNbB3egVgm26cDNJqTNN1EcZyllZXGcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS6vKUjNrwzBwmBLAOIseFiGCw82kPWhNVktwvX/eGo=;
 b=sqV5KraheaNAZjnLM7Eywzs7ktOsF4tY18AUkDzT/jMAIqVBkHfyM/dTbBlXTm30rmqX3w0cGQLPU/QKz2D0fdo/RGyj61eHqoVU+k894s4xVCnLYUxJrm2cAJCQKvsm9mjc6SNksrYYYUW4MGup94K153GcdKUqmoLu5iNfXS2Ow44THIQhyj9r3wKg4kY20NBMrnjWUqkf4vIGELeMFfZQCzIGiH7ztVrWLcRFv4D1T8pfSWeOW1+yG8TQ66Gdp27/MRDrQyt7Nbgv5ihqr3MtGSDYIh1vIdLL5mebLck80dhOm0g5TH5DVcGB6pWBJ+iySAc3Vyjiww6jJSGM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS6vKUjNrwzBwmBLAOIseFiGCw82kPWhNVktwvX/eGo=;
 b=PGdYsJhp85N0lZFnOUKkDYKWmrDfOPnjv5b9HdquGxCYNl0AtI7IVGCAlCxgf+5/FTrupuiEdxQWYfJASF5pm5Uvv5nq0p1ZxNE9b7Oxj7UPj/mp860e2eBzT0HMdHdymnpDlJfaBToL+WDDiNAf3x+nCOZcZvqc2sZ/hqyOtJ0=
Received: from MN2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:208:134::18)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:41:53 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::f5) by MN2PR16CA0005.outlook.office365.com
 (2603:10b6:208:134::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 07:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 07:41:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:41:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:41:52 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 01:41:48 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal Net host
Date: Mon, 24 Feb 2025 13:11:42 +0530
Message-ID: <20250224074143.767442-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
References: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 75684cea-f50d-4932-ed63-08dd54a6b4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cC9Nb9RVLt+ncU9h+02gXyMsoOcgaDmQSizGZkcXHlRYaGSPW6AxZS3iMOgO?=
 =?us-ascii?Q?v+SHBt+J95wUi8R8KOM/xPVtUezziEIE0Ql5OFvoYGxOB1QMSASZ4QBGgBop?=
 =?us-ascii?Q?PTadoPYxKEpKSTdN5VZn3GG6k1AkUquVlDiPryYuAsRZVcwGvYPkg/CTJ5ZG?=
 =?us-ascii?Q?cEOGIlLMzJQvLk5YxzQ6x14p/u/f4XO0IA18dfhbYAEFAhtam7CdBj0YdiZg?=
 =?us-ascii?Q?e/5EvxvOYsZEg+xdjJ3h+WDyomvaSZUVW4dhWWF6pvLGwYR3d3NTQlhisRrG?=
 =?us-ascii?Q?MxZOtnQQDdbSD/81EHPibROzugZQJkgRXpkupv8OX1jwtquqvkLaz+KnXfCg?=
 =?us-ascii?Q?SuLhgHshn/fTcyIDRgZaQChMUIoqsTISFDtnP0w/KP8Mo/+XkiUVuFsDiPxv?=
 =?us-ascii?Q?iyfRSL8JHsvk4WTbDlGqOTkrVD5oiTWfuK/Vg7LNbLMJj7KJ8/uYSUTAftCn?=
 =?us-ascii?Q?UC4IPtmCjriCKk0hl/37w5kpv1n7QhRpDXRlLWrRHDuKDvUUve7VgmmLd3EL?=
 =?us-ascii?Q?2ADSdugtaGtufvgEi6DQMpr0CvPYZ6N2Bi9Tx7Kh/lDn2nYJHnATJSdUB9Uk?=
 =?us-ascii?Q?JGZABiSKCx3/TFgHN0DLQ+ApX+uhlwJIC4+HSImVkwYmKmTNRXhNkl+/TEGu?=
 =?us-ascii?Q?hoj2tBnwAKyXLDdkzsdkJBEySb+t9INM4ldoPUdEoniH5DvnWEpktQgec3cT?=
 =?us-ascii?Q?A2dLRLBT4KLH9v85sM9cfuuimUZFAL4bIrEHtzceFJ3uQBLh90qjQYTiQdHn?=
 =?us-ascii?Q?tJl0WxDpzCtPJXMZCL5I01Mz48SmeGs2/VMZlZ78bD66dJUiDIC5QAyq/bqM?=
 =?us-ascii?Q?Y1mVkWFe1cwgMc0oSjqeiyEt1h3iZ65NLZHTSMu4GZJFhoDXGn7VCwcvTcBl?=
 =?us-ascii?Q?oOhZAvn/PXl5gAyr/iRuQzQpMXPvI7r8UlGKSZc4IlAz8Xokl6v487YCBFZb?=
 =?us-ascii?Q?03f6vtiODgP30j7OyQock3ZQ4pNSLut4eLM/PHgwxxJ6H2Kk8B3tFwUjNw1s?=
 =?us-ascii?Q?VmvZeR6q7JtB1YkJX5syJ9QFTX1RMupvrdtgIeyHL2FMdyiiJybuYPP8sgfc?=
 =?us-ascii?Q?70KiB2iU7ZWMgH1HpDnbLIl6dGtPUVnwR4GXQyWh0xDPham5PW8QAvqtI99e?=
 =?us-ascii?Q?9gP1u1+RIBiOpkaMKV6MT7hZDatDaoI/ezsRghNCpsRusmdAZsZaBqKlU/jI?=
 =?us-ascii?Q?GLDNH8H17SyckUvGMsm3jygXqllwOPm51avxMp9OTTp4i62hDCKhY1xVQQjF?=
 =?us-ascii?Q?H/7XJiD2jKLidqHM0dNevIpD/cCdl0dfSXex2Tq5/GB25HrsTzs34VAiMQrn?=
 =?us-ascii?Q?+9jLMyUz/LwDwlfxZfjS5WNSHnNIqdD/krmHfsGxaIPQQj7+72gyWMRFOFvW?=
 =?us-ascii?Q?oFVqiwIkmyy31TZrQU6TsOOlDpCg0ABovRPkbVjZz9WveWZRqO6gsPoT4Wt0?=
 =?us-ascii?Q?lJUSXyfWmVJ470KU2pUbN4gIFClWiFlZlL/fQzX6ODiwFXPh4nBluI+qtRNk?=
 =?us-ascii?Q?dmjFNOvOxCw9nIg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 07:41:53.0775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75684cea-f50d-4932-ed63-08dd54a6b4ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933

The Xilinx Versal Net series has Coherency and PCIe Gen5 Module
Next-Generation compact (CPM5NC) block which supports Root Port
controller functionality at Gen5 speed.

Error interrupts are handled CPM5NC specific interrupt line and
INTx interrupt is not support.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
- Update commit message to INTx
Changes in v3:
- None
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


