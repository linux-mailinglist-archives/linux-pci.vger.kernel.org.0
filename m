Return-Path: <linux-pci+bounces-13342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9297E03D
	for <lists+linux-pci@lfdr.de>; Sun, 22 Sep 2024 08:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1F81C209CC
	for <lists+linux-pci@lfdr.de>; Sun, 22 Sep 2024 06:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921A519340B;
	Sun, 22 Sep 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aUHphdgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7909193096;
	Sun, 22 Sep 2024 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726985679; cv=fail; b=QyvDALdh9T26hvvlCxyHDy6tIRp0dyIMhpf25uN5Zm8sszrEQQdHb7ExGzGInrr5qS1hv/wOnhbJJrDoj5+UNJcINy06VALjqulErl/miuYQ+n0JzZ5cBOqnuO7p/JWI8GxzpksetBaN+Gdexyig/9IPCcOKaT3O/PciO3KeGus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726985679; c=relaxed/simple;
	bh=wAzu9punbHzzomMNrDjviL2OB4EyzATnemrEn9x+scU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmYvB1AzL5Z66RHdVh58BXEfPdlIl5m6KLfK94tNOdczsuJR+C0ZtiuYiY1I5ujGwqmXK9k6HpYlC+0x7TYUd6/Peh2ubO38swBy19MGAagAVCUkCMELi38YQdTnWE96P7lSVhfFtrOQo95ofiac6VZKodcf6Q5FoU5wS9XycSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aUHphdgS; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUyM4IgSPynTNPeKLfDDIQjkR/ecAW7uulidYZf2AZDIRcpamz4wHd1VMRNsp3r3S+N4pLI6CJham4UXH7gLIeJQvbP77Hn3B1kk84wtN+a8Hr10vxD5nZ+GQEcFHogIhWqAdRGbRlUP32fqdX0kpJ0VI7SvlpOQhOUpOE8f4uoQDCJbs0iKLT0O6ZOJXM0Vr/dK/3OZE3qaAxc8riO6mKFT9evuwehuoweTjuQ6fINlXW+WWKiLt3ZqtKtvTBajpQgq4kfg11n99TZ6oh4IO2AQdn8uMwLbRjbtxoIL+yc6980tDCIskKxRVZ70F8k+v6quzf21cqgtVRnlJ8IeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHhcBBZpfCRa3Ke/Pu+8mf6XT56X3QtBWqjhsQLAiA8=;
 b=cb5SkCCiUun1+61d4pDZBAnM0nsSafXPcrhujklxdwpSC1LPQk5RWnpdD5h6cZYFVN4f50xEjdDw/0jHhWdgn3Rgi4txqtT3gkYiIqpqMWHZ4CmiNJWFP5hx5zxWzKc61mrlWNgengUeSEXaQ/Zto6x0bVkYx3mjQISuPnhhMz5U3G+CVIjUKJkTt8/2l0StNzylibF9DH7SsT34t4KMdEg77N2xKp/GBTtcPIJUtRVYDRNqpMvnd4A84vTreP3lFvlHO7vEvMzw/La3O/gCKsVrZq5DkuSCZlq1zqwDP9ek26ipW6JRYHCsKqPt3EsX+fuV9GY6CfRNfXZG46vbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHhcBBZpfCRa3Ke/Pu+8mf6XT56X3QtBWqjhsQLAiA8=;
 b=aUHphdgSSXYyiL/2X4e2PF9VLiGoTd+66m88xWvhiaZJOsa+reUuiq4TZMWWt9jlYg2/mYTHfBP4dxuftr1pealv7bUqUEAxdnMD2/e7SfJqqzk8xTQqX2LDgOryiEwptQGd/zzV84zsJ7Ndz6vBKKaddGwgfTK3R0wm6zahsf8=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sun, 22 Sep
 2024 06:14:32 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::aa) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28 via Frontend
 Transport; Sun, 22 Sep 2024 06:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 22 Sep 2024 06:14:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Sep
 2024 01:14:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Sep
 2024 01:14:30 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 22 Sep 2024 01:14:26 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
	<krzk+dt@kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5 host1
Date: Sun, 22 Sep 2024 11:43:17 +0530
Message-ID: <20240922061318.2653503-2-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240922061318.2653503-1-thippesw@amd.com>
References: <20240922061318.2653503-1-thippesw@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c07f074-d7e3-4127-3835-08dcdacdd2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6oPTm6Kf46R5FmntKf5iUIcrfdqE0d7Z11yY9m1Lgi47eZC/OB5D73GlSPN+?=
 =?us-ascii?Q?GMFn1ddOOt+pJz4mhjs/j53S6zpww1LIePrKVdWi6ivUMRC5p0qZpNW27fWS?=
 =?us-ascii?Q?H7EzrDnsV8gkGNWVaNktgLkqizBDaZdxKnVgRg6w5Azov3mffPKQznUPTZ13?=
 =?us-ascii?Q?xgDmJAlZh6ggWjypQ1cx2ubPiGtkxezu2qbNiyhSX1dRNa8lQy6O35pVw31H?=
 =?us-ascii?Q?O3VOrrWUrQjT8cv/O/fDzIrd9gPfE91UIjSN4srQR2kl3UY/g8HBL4tIfxZ5?=
 =?us-ascii?Q?/oQJ3ysuhWjg3gJviyEW/lzd6f3xPyhMFz/hVmvhwR9+0RXJ7fggI1fsHfTM?=
 =?us-ascii?Q?V04MrinO/V7rZ7+xs0y/yiLgpBY1g1s7gzvWJfFNE7Mr/kYPo5+Iir+jNcSW?=
 =?us-ascii?Q?gGShEMEX0SAUiw9z4g4ERr7kVc8YpJq/cFcVY/dIlGSUM1qjguAVYtngk8tu?=
 =?us-ascii?Q?4zftLMUSpOeOie4ty+FG/udnToopICX8QEVBV0brl05PoPukzp+pDz+BQayG?=
 =?us-ascii?Q?tfWdgZcf+wDsPBVKrw6T72ELPnMmHCxLatuQw0JEkR7JaMR41u2HC1Yi/eX9?=
 =?us-ascii?Q?i3L/r2YZ9luMhGcQ1RlQ7s0nbEVHbQuHGTfg3Lqn4D9H3wGOWNcoBpdjDvzg?=
 =?us-ascii?Q?H9XoDbCDxiC0t7IAWRdlermA06/jPfNOBiqzYj9VT8L895P/jfq9KU3GtI1p?=
 =?us-ascii?Q?knM1mrR4BETtvS3Frpn5TJ+4j5UWKMJYQza4gUDr5mHkX6bxSjy8IzDfBB1i?=
 =?us-ascii?Q?na4woz5KHIvoCWaQGjxcPjgdIBa+Igus4GR9kENAv6yfSuVRsnlu3f2WggfJ?=
 =?us-ascii?Q?crYiyyHOsRSlNiPeiC2fW6tAFVN0DC8J8wUCmIMj0sQwbo9eEbGrEiDEPe/4?=
 =?us-ascii?Q?X+GAIjVyXXeq0CBTfiEBBQLzhNeobKFaKD6RgPMmOILw7l/iH5pHx3LoMqRd?=
 =?us-ascii?Q?x4mwVJK3FhSjI4WY8LmSj4OpGoui64GbnRPZMQ3bS5imIpTeHH06jDW9MAk8?=
 =?us-ascii?Q?H6Mhf9C9r9hhLkNKmVJC6p3zK5O861goXG03MRCLxeax82UM4+NPlSONHWxC?=
 =?us-ascii?Q?aBG+16d/rBuz6rRHog3TW66WhfAqMNO8MOBzzWyXyZA7lRnywkZWcTIQ6Cpv?=
 =?us-ascii?Q?KNev+a24Lq6Z2xtSRCGjXqNL7iTFCS2WiMkZLnZrVeL5l7q8Z5ND9FEwmjGB?=
 =?us-ascii?Q?MYqG8F5VRR6S7c6Xu+5rqDxZsJvqceokr8SnavieiqOzwo9kdXXUlNOgpPXL?=
 =?us-ascii?Q?IfgZoRf4bCRPpMS4uvLM+Fp8EI1ItIO3YIcykAY1SFY0D+F+YG6JHReNFFdq?=
 =?us-ascii?Q?IUgV2l2QJ4S5gqRiDU9OUWIZKoeOJin+kDltEXAZEUUTWTSPJwjVMSwiCtRu?=
 =?us-ascii?Q?1PYJZbgv0QNY4U6MZtewzt5P9SuZJv7CaG6lshHnnObRMkYRQYwVUvJow4EN?=
 =?us-ascii?Q?Thwah1iTJkW2kTVKx1GNC95uXL3184dO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 06:14:31.6069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c07f074-d7e3-4127-3835-08dcdacdd2b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

The Xilinx Versal premium series has CPM5 block which supports two typeA
Root Port controller functionality at Gen5 speed.

Add compatible string to distinguish between two CPM5 rootport controller1.
since Legacy and error interrupt register and bits for both the controllers
are at different offsets.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
changes in v3:
--------------
1. Modify compatible string.
---
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 989fb0fa2577..b63a759ec2d7 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - xlnx,versal-cpm-host-1.00
       - xlnx,versal-cpm5-host
+      - xlnx,versal-cpm5-host1
 
   reg:
     items:
-- 
2.34.1


