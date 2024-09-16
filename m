Return-Path: <linux-pci+bounces-13239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588597A60A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A061F2494A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9942515B551;
	Mon, 16 Sep 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0K2u5yLy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95BF15B543;
	Mon, 16 Sep 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504306; cv=fail; b=Kcz3X7R7dmvdLlYnLbYGfxm2nm2c9cXaU44+xabcd9IUKoHtz8f1RpexuE+MTfnOrLArSkhZX+pjuAZyc9TtI04NCfi5N+QfD/aimR4zOUcrOfpODgZIjUzFtN/15+gkHx3ov8yfd8rpnoYPajsLgJCE0gMyHco8DceEfTxJr/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504306; c=relaxed/simple;
	bh=yZwISjYMjFk09pal4GUIv3RbdiY3Pd3paOshMrkKq7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3zFi2An3bNtKAOBcKqZ5mGXQ/8jmYSzxiMMkvhWqx0cxrtSonrYkD8/lbws7ZPzkhCNbCSnLjarCABPPnWhJmc06VpcSOnT8Tvnjj+zf2VfdXEWQaOJMKivg1ZXmBCQF88JLm+JYQiN42iQQjHB7rJvGPDvwsnFLmS+tXPYyIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0K2u5yLy; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwYzg1H0lNM9OsoyCs/pX82WWGk4H3NSAJRWBvBS6KZVzxBiBh3XUcIrwMN7DL7Qt3YJ1qFPVsEzjHedAD+i8puO3NNjT3EE8VNeTOkgRNLaF0n+Sr2WSBu8LvNHaT+3fyUyzUOi01kxHMqXHJkyoud1340zkyu0ei9TKMMGemCnpyhHo8JI+ytr4smmsYwi1/0vRe6TjupPrKgZ1KCnVnuIj2Qx5yuO0ytjybaTUl7u2An/FYL5CrgB66W2zxjCwWRmQeXQKAa6wbJhLAQPBw4Lfn/92fWU8wSDNt12qxX9LAimO9vcRQ0QTYGmOLCrsB38bPgPNen3b2MT0AIYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebJF0bT+XecCMXh/KP6H5FLBPDqakeF0DCX94SSV3o8=;
 b=CT69Zbsibv4zZcexdZe1+mgRfl1nvxhez7cVr1wpT8vkpBp4PRhTJalvkvAQZNkcBt/hxz5RS95Tn7Nd0nhgTEhhWly8P48dmQl6H5BpUx358NfL9fy1oIega3NGuJFxpoUNs6hyrdbAxROmV88p/47OnA9ZXD0A00hYFkpdgziNhMbmq+Zl5W7hci3c0YU2i9BLqkhRkJMA7Uv6nIc/w0GigOgfXenhje2ehIAYFsGxt1L/7b0yefu2WImaALR/2H+MDU5czwGkLC6AUkMVXk0RfUn52uSYMtGulk/2zJ9rNySl3RzwNyYsaewDkW4HNKHIN5yltaF8CT/RiFFzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebJF0bT+XecCMXh/KP6H5FLBPDqakeF0DCX94SSV3o8=;
 b=0K2u5yLyn9feNLh/9ykQaQ7Zu0mkA1smjTLEzdHsZWsysiRgB+TBluzwYrj15wVnPmgkutqF0nDukAPkkcQ61svIapMg6JWALw9J0RlzdcTzV3rlKLoJAFQGtcviU1s2UUKSVLKAmPjLIUnt/zpX5DKzMrIo4wDe559DfRwuM1g=
Received: from DS7PR07CA0003.namprd07.prod.outlook.com (2603:10b6:5:3af::11)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 16:31:41 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::ed) by DS7PR07CA0003.outlook.office365.com
 (2603:10b6:5:3af::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Mon, 16 Sep 2024 16:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:31:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:31:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:31:39 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Sep 2024 11:31:35 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, Thippeswamy Havalige
	<thippesw@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5 controller 1
Date: Mon, 16 Sep 2024 22:01:23 +0530
Message-ID: <20240916163124.2223468-2-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916163124.2223468-1-thippesw@amd.com>
References: <20240916163124.2223468-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 96481b81-8be9-46df-c302-08dcd66d0b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBXLW+92LjOkBMU8i4YHVkx6UtBKdPbLmFV9jVuWVhuezdtel4okoDm+1ZEL?=
 =?us-ascii?Q?Q+bVOhvaGihRUSGF8Tlz4bns06//UCCPJ8fDd5w08oyROrUIQWW+PXZO+6s+?=
 =?us-ascii?Q?E2NK2ptXxPNnsBV6EMC+atilN+6bFKUJFO5i69AgXUqpwI4jXDxlnsXKu3eP?=
 =?us-ascii?Q?jk2tfgPTtRDqRwZHImXm1COp0Km24N/DXwjv7bUAf8H50fsKWa2zKPc3up7J?=
 =?us-ascii?Q?goBuHknxh1MT8Eo9UVulY37tMcTbvsoey7Au/VclcWkFijJaI8cNkxkfaDkP?=
 =?us-ascii?Q?X7QIEKaJvCGIyuAyfL/Iwg7qKuRde0V2vXNTd1Wa03YuReF2hAps2SU8HeqU?=
 =?us-ascii?Q?viBF1ce9gd8deRE3D571KtQ1GNpQuJeVaHDMIPlW040P2eHcDpPGAtvphg5s?=
 =?us-ascii?Q?FWb5KTDYhbrRpPwRoRAfyZ9R30H7sEAd4PfeROGWayI1vS161woJ0siGZJ99?=
 =?us-ascii?Q?JN3m4rrOwPTLOxaQTsqOjMPc4nENSYQigZRnmSaizRgGD+PGjIL89O6EFOau?=
 =?us-ascii?Q?C0IqyAmvQzUtiaYJkqvt2irVQYBrYv75+XGvgwXoV6udnnITgpnUt2wP4/hM?=
 =?us-ascii?Q?tOZTz3LO04gSCKxy/UGPrLsgsrxxk++DYxOLoFoAzhkA9t1EwfKvP+bQeaG+?=
 =?us-ascii?Q?ViWFOHU6reR/93mxXAfUU5hsqayJRJhntvxvuL0zOznKQfPm5h8whF/Zfc8U?=
 =?us-ascii?Q?cXuusjjXJ0x8wuhpcDFwxRICtiRjeoOcN7hVcURrr/+SPN7BWnu+ybqpGoDS?=
 =?us-ascii?Q?W5LLsV8/Hzj+m52maokagvI1pBnYqejh/mMSJNVgpc7Okiz6iib1229y0Rn9?=
 =?us-ascii?Q?22nmkafqTN43Yn/zGLjrF51vXPhVdHbOOoia1tAGm0GR94X3oM/YlaKEwVe/?=
 =?us-ascii?Q?xMGYUAoTJngZoLaGbqe8F100T+x9mxcEU7EVQ0lnDFKo8GfaTxSSTW88z8lV?=
 =?us-ascii?Q?fFjUeW57x2hUUrIldCtwAiYNua9Ecz/Dp++0JRFai48anj5Hgy4dqWXHcnOR?=
 =?us-ascii?Q?HVuCYwrqcnkMlTO5nFU4ZiWqXGGXNyQL/kRgTYqzZc+vZJDeAOrqq+D/SSt2?=
 =?us-ascii?Q?BRvnRR/bf1MS+b36XiER1yOHosoGtPo6xTXmPK8TEB6Reh4f1Ig5uC9qvbuS?=
 =?us-ascii?Q?JYzvo2jKy1GNKsOar4SMdkNSK10fo8+HGrI4zCDzJPO7Pzi5hCZzURHW5z3j?=
 =?us-ascii?Q?Y7LrSfHdcHCuBMLCsY5Uoto/h8U6z8cfecFpJPuOxna09VKX8K0KqJ5A3Nw7?=
 =?us-ascii?Q?ZqW5rtm5qMrWTP0zK+Btwn2MjUnp852Vncl0jDsybPHn0vYjkwOr3cuHks8n?=
 =?us-ascii?Q?5v95s+UseWFloqalfVfmDFRsvy72qAeRMbwA6FwThl07WlbmHtnEaUC0eDlJ?=
 =?us-ascii?Q?sp52jT8F8zGMA8pbep35vf6TQWeLG4Xkgi9FdA9o6vDd0/8P0Du4If4QnFag?=
 =?us-ascii?Q?TtJXz9JWPkQlFltCS7oE/QX3WnddJ00h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:31:40.6878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96481b81-8be9-46df-c302-08dcd66d0b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

The Xilinx Versal Premium series includes the CPM5 block, which supports
two Type-A Root Port controllers operating at Gen5 speed.

This patch adds a compatible string to distinguish between the two CPM5
Root Port controllers. The error interrupt registers and corresponding bits
for Controller 0 and Controller 1 are located at different offsets, making
it necessary to differentiate them.

By using the new compatible string, the driver can properly handle these
platform-specific differences between the controllers.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
changes in v2:
--------------
Modify compatible string to differentiate controller 0 and controller 1
---
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 989fb0fa2577..3783075661e2 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - xlnx,versal-cpm-host-1.00
       - xlnx,versal-cpm5-host
+      - xlnx,versal-cpm5-host1-1
 
   reg:
     items:
-- 
2.34.1


