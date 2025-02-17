Return-Path: <linux-pci+bounces-21616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BC1A3840E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 14:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC6817386B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4826021D3CD;
	Mon, 17 Feb 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p4hpzse2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27721CC64;
	Mon, 17 Feb 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797727; cv=fail; b=oEKm1tBfEf8jrUv3kwVbnYzQTsTWbOzlXJ0pwXxukEirnfYD4EBZQewVK9hwMn6due4LEWIYIiGOq5hdVE2T53EzfQpWWANVXi3rYcj8kk9VVXZKpmBC07A8tcxsLtbyu4mXzERNHzzbzPwFvjIoiaLfQBsaqtQWNK2xy4IFb40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797727; c=relaxed/simple;
	bh=sWVLcByvdv1zgCmR6JhQuUi3/1+aDic5vEE5I7Js81k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcip4JO+AfFwxEyUczie3AF0WJCRVG5MwQ39JcBdLlfRxqfjC1+EyHny/0KjAR5Mgm5SC21Y8Uh1uvpb45F0WWt6vVjZCO4R52dsgNUd1Q43FyF6hX3n8J5pp1qG9gxttTHaEdM5cU+iV3ozqf6FBD6ue3/swDzAVvNjUL9TAlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p4hpzse2; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoCyrCxEH6HWV8VXfEnGQcOFdwsevBlstaBk0++sFiSrPUvbb9YjxpqXHDPNx3MEflgU4sBCjRr+0OPLPNEzSS5inNTfcQvM/T+sF9RuNzVTohhGWyTM76rnGRARCao4EKmTAeQhAdyN5/ZDKH322u2StVI2B1Go1c7f4/IYalslRBWrpCjPgQOiI897K1fnZuje4Wgp8WY37Yzce+tf+4X8gmNQBd1wQXW3hOC0SuQ0u860Cq9bN4XejtW6xTzI6k3Mezm/cT3QORLPzQ8GKXOqMK69JD1Qf38IngfywfssGCcMmidDWyRhFmjRezDvGKpYQVVc822/4GWZNh73WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=jwD6OVRm5vqwJ15wRte9hL3Gc1uGMDQkTrExY0Hf1iK12VxUH4/YrB6P84HIncOvQiVXnqE0+VniBZW0eOocT1bI0hSOgZISH+KLWI/aAK36fwvOxw5s+wpB5jM9LD8r2AwKObtl7XcFwZxNn7zY9QH5eBU0qs9Cw0EDn8FA+EOTyCFJdGT3m4Pjf80rHT9lvwK4mO52QwVw66xjXyX0MHdwYNxUqzIVZTzAKjaJ3YRPMN9x+SajtrOWpEZjTmXLq/4u7yz7pzZ03ini1ntae+/5ctsYt0PGSdWszcH6QrxfmnZiry2Nq2iOmk8nC+jWuc0jT3O2lPVdhj7a86dRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=p4hpzse2rJA09Q7u7u4GCeSlmJLzLCUNpYlRZw7ReKR37UiIcYoEL1rs6o9ECT0bgWkq4Yn2PZQ2XUt+6gHgXowKwdlkXR8GjUQgU720HmGgNiPyestf4WSqQtKiVSMZ288IFetozjy7fNboPYyuw+40L0UHwzqs5QREib2OSB0=
Received: from BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Mon, 17 Feb
 2025 13:08:39 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::29) by BYAPR08CA0027.outlook.office365.com
 (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Mon,
 17 Feb 2025 13:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:08:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 07:08:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 07:08:38 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 07:08:34 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v11 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Mon, 17 Feb 2025 18:38:26 +0530
Message-ID: <20250217130828.663816-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217130828.663816-1-thippeswamy.havalige@amd.com>
References: <20250217130828.663816-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: dd46b5da-f716-4ba6-5298-08dd4f543246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dm+clTybkl+qG+hYpsbJNvxyI4pjT3BCoPdIDy5KEQaoW4Ouou5WS4qJsZ/M?=
 =?us-ascii?Q?PbE18wUL6hKpg4FjDukckBmZmu/RVAUpxPwBHLeazTUKZpbrL95KlCbKoc1x?=
 =?us-ascii?Q?X9S3XoonSOvVX1VJu8hABaBL0WGxxltb131rZOvBjYDDeeXFAj39tmkT0XYM?=
 =?us-ascii?Q?2pyJuWsDL+ZaqUAg9Xrf1xY5pSQlkZwZfcIL6AAnkCaJHplW3ikK8G2S7V3p?=
 =?us-ascii?Q?aAptVn5T7k6SPW9vrdszD4CeWHYvD4kScN9Nam3cokU7h7+dzR3yiQUbdG9I?=
 =?us-ascii?Q?aKJEn6X46FqPirbJatuKogitQ9BHuWJfx1v1kuPaQAlKwdpYv8cWw1Jit7Ja?=
 =?us-ascii?Q?oyANUt1e33HsQitpsSGLZuhsDEQ17WdrugWYvRVLnwJR972MlLZYSkiO/lML?=
 =?us-ascii?Q?QEmRcheW1W58cJSFRWrHR/wBgAtIUnfZ6k71bEpIzcw6T0mjbFpxnZC1/tXz?=
 =?us-ascii?Q?uYlHYY0bXOcwpgBd0MG0BmLnNRA9VVBZyMSSEhZcSuL9cdLJMN66ZJzfs5tT?=
 =?us-ascii?Q?r9VPXVIGRCSxuv/mBK3/CUgYja8JjkrSzRHxMvxgX9QSc9FqI59rpZzZcHrl?=
 =?us-ascii?Q?B88EgT45e77GYUK4cv4Jxmy7soD3m+H4kxwTKyPlBARFfRiLkphpGGExaAxn?=
 =?us-ascii?Q?VFitC3tnC5kFMmfKllAfAKlj7TyonQffmV6HnX8dob2bjkoRG9TUG6JRm9ku?=
 =?us-ascii?Q?J8NUcVRDWihGSLBiijtxwpNXYp6fwqfrxqVNzztuwRN8qN1hiuxeYs7Q+Khk?=
 =?us-ascii?Q?OfgTgM5JU1SFjXkurZSHNCzvfEbPEJsjnEVmbxEru0fJ26V5pJ/kZ9HRo3jH?=
 =?us-ascii?Q?W0noQDeImHIxSJC//Y2mqP++v3zn4V7mf/33KJLLWVhD4xTWpasc4SPa9R05?=
 =?us-ascii?Q?7NFRQGKT5DwrvdribIlgw5IJzDoUUE0n8uyzSKHJ4GkZSy/idL94L9pzOG5S?=
 =?us-ascii?Q?a079PVm8GpBavpaxznEYXFRD8yFFMpxOt2ohreW5B0N/u6aXcLximKGhnLLK?=
 =?us-ascii?Q?yXFWUSvOGuHRq274nctkQYkRFIrgl/ofVlO1FQ0QT7a+VpFV88XDem5aZzVT?=
 =?us-ascii?Q?QLEdXKZZtiHBU0gf0AWgheAm9hVqoh67kpKp/NhH/ZrKumdWOz2WbyJd/qcU?=
 =?us-ascii?Q?WWj8BQLUXamoORI8wdNw+ZVN3yj33UQZhF7Ha7T5kVujpm1t+lMQdVprLqdK?=
 =?us-ascii?Q?DMc2MLf4d/NBPePkTzPWA+X+4cBUZwZ7XyyyDe9mQLQ5nn4X05PMQNiF+Tqp?=
 =?us-ascii?Q?0+SJwPFnBeG0VVo7gcQWPmlk0aFhW7lD6gCgRmYf2ONYBFXCzEIO0N0QCgBL?=
 =?us-ascii?Q?PZyAXlejU6zx4MRGBNTSyCrlCLWO81pmuHYQv1T2x/84wgKjWoTl7syO535d?=
 =?us-ascii?Q?3VOFm48ygaUSePSqzF0feU64oAkBZFQEqjs72/f2QBrs3IXbMvThMPlyAoBw?=
 =?us-ascii?Q?pqEKX9T5RuygrNesfgObHb5tnb3cLuJ4neZFuMrSd6kXZMZXqp/O5V7djMNk?=
 =?us-ascii?Q?bgN7ijwMy8WhxB0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:08:39.4232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd46b5da-f716-4ba6-5298-08dd4f543246
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410

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


