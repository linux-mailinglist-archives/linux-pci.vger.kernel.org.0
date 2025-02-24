Return-Path: <linux-pci+bounces-22229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99DA4270F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6C93A16FD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD825EFA3;
	Mon, 24 Feb 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5PpgGma"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9A13AD18;
	Mon, 24 Feb 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412242; cv=fail; b=m38oAwNI+mmS9OXqSfZCq96s5qFADhCyzMEhTa8pBk/dG3gJwvRXHHPg3N8ZzCF/wSDhHATCpTIWsGawlvYgJ13LmnaztQ0J3PZCpQwn3pInxytHX5m6gh+Wbs+M6OIUwOsuEon77KNhFNQv8lAd6n8zJ7jK38J61iMpfIcR57A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412242; c=relaxed/simple;
	bh=hm11OjUBcKuyHt9E7RUpufImbw1CnKEUOWZYYW5mG7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeYVEV9jdY/wb6KgspdctnDEXxhaxgOxykOhSReNY1qH3eJE/5rod2uVo7mvgIaedHoLt9/fL0QsMDWXjT3LXfCYGhpK/YJnUgPmwtoYcpO2JboS3YPx+mp1h0KR4Az6Fpim2Qr+t5ikbtYhYmP1G/KehaKcNwRD6lyR7YmgmN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5PpgGma; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVu1S2nmkrtQNaJKQfGobRI+rgbrL0x38pOe0xYVBazqVkBwiPOtq6JBQESafbakfBPuL/j82svfY9ss+8bCBvxAlKzxDTOEi58gIa5H3PSJaRoDcGtQmdE0NqrL1Jb+vDOdn6KaPiPuSMBV29vmBZhLapg2jOQ950bBlFi/pxb25Obgwvcd6a64fhjHcS8k5miFjnvBI9DbIULBwWfDSqj03+StjzG7S+NhLGW9l8lO5cqckhRB2C4Zq3zH4ps2/C71wHVv86+bnKcte4TNhas+V2KkfUn5mQHGratXkk61iZXWUwRsUdEMilJFQ7ht13k2WAu6FtgwJUiJyTialg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntlClmMXET9zcOmhO0KJUSg+V8TO1G/QbcLwLN5gDp0=;
 b=kos9mEInQpekNBPHTZWJt24Q+8n8R2z8OstuAA8Munkh5Xe5fB37c1D1HCXnrbfTPlOP63hgO/gl9YK+6ssotCsY9mg+ix9avScVa2ex/2IueI45woZyj5m0ZhGgeoSgr3ogSaFagnbFXhXz07bfa3PY69dqNcS4pqxSEPSyDxaTtRHkvO4vGGwNHUgwZSIKXKoKeZ/fNBQJwMC9U7kDaPCOqlZcVATJVBvKQZeJnPF/gFWD7ek4Qd57PwU3EKDx6TxJSXfh3gaV7kLl3/nwv3qMRM4GECrx2bnPh7WqETYcbMen2kL8Tf9o5Nb96wHEy+YWimX+prdiKjjqYfPfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntlClmMXET9zcOmhO0KJUSg+V8TO1G/QbcLwLN5gDp0=;
 b=d5PpgGmaVTtv2+groyKrheNJWyueLd6e7iI1qoIAmYO70YV0STNySXLg5qolYOrFOdOuzhHmV22ECZNesEi8TfSrZkg9K64WmzGiMQAg8Y5S03uWIApL+WdMzPXJBEfpejwokfv/jRTAX59B5YCpldOj3qkr3Cm1mpmdZxg8Lys=
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:50:35 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::2c) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 15:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 15:50:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 09:50:34 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 09:50:31 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error path of probe.
Date: Mon, 24 Feb 2025 21:20:22 +0530
Message-ID: <20250224155025.782179-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 2436773d-4877-4754-b3f4-08dd54eafa5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lFS3tbKzUnsYdL4+e2QwRtwepdF3Oqw5G3VdJhK5UUvoOxQM1L2RZpwH43kH?=
 =?us-ascii?Q?jz65b8kZVaGfYRGmy/ANW1AHi2GeKXvB3mJjDjydmCfAXwpoVPIOo10pfUvu?=
 =?us-ascii?Q?BmPXzOv1JXBYdIUeruCUTbgXbfBIxhj5GbWRnal8BYcy57leAxPC1toosB9I?=
 =?us-ascii?Q?A7eBdK6VJXsuN3TjDj04Nj6/oP+xybygkl9gYLSMr2xEdnKijP5BhmyuirSN?=
 =?us-ascii?Q?lXCvGtJNOXxZlqPzyLjkdG+TmeRMG3fZIT1gKsrPU1EKCpAIUT+wdMKwvlaf?=
 =?us-ascii?Q?ml4hvfm6BLg6cUe5jSUS53bWtZSZUOSlOlcva1pcVduaE0Pscs1AQyGOtWFF?=
 =?us-ascii?Q?F0X++s6pFI9911qW7X+DRvCCoWHxQqVJKmcqm5MT2wKjzxHSpjnxF8dGcVC0?=
 =?us-ascii?Q?1Ly2oBHXJwLJrfraFV8Io7W5gDrjxMvvbDPAhhojpFu0VXpYqVts3ULeXIJE?=
 =?us-ascii?Q?J6s4K7wkTAV/6akmYmQmQC7/fvuJOV60BOEHYRYv4kWDL5C5SgYzff58kvcM?=
 =?us-ascii?Q?Kqqrok6UC8TAbRGbr2VrNVvKZu2HV7+eogfExUGje6KnEgIVSeRUAZYk/fIK?=
 =?us-ascii?Q?sEv/YOh7Z3Lzoorn4ybIoncCPEcGr+p55AEGbpZqJo3uKsAacAIMZmt7Mge/?=
 =?us-ascii?Q?mJa14mGwPNPF/bJSYh4+7CnJAhFQk+biPLccb4dv8yJTD1BIYqVWf/c1qaiX?=
 =?us-ascii?Q?NwEGpXUB3QZqiTAPtUZGzsthBVj0mE487VYZUNFZAY/i5aF8mA6WAUy05wu/?=
 =?us-ascii?Q?XXdptwDlFdyo0KNwhzpp1Hh/q6oNlULpI5iX5l5W7q94ntjyFOhKtcB4JpyD?=
 =?us-ascii?Q?BHRoaBdYtwqxRDt4XdNuCpsXHif0phDNa3onUwF0M9y8vjjv/9TNGCmyPkih?=
 =?us-ascii?Q?njcuKd0ZlIDE8NS7iG8kNc/DtmruuAuwPK73oSjkBLYu5lRXvCilf+5qRKJx?=
 =?us-ascii?Q?CVJc30FKVhaxsdRVx4mXo2aoHLg1UeHwv6kPsEjhT/nnVQ+wCMwXw+B9Jwt5?=
 =?us-ascii?Q?yUawOFNE+Q/01AFeFg34ngIshyd7aJuhBwc0XPkyeUHAu8PQ1wNyo6vvM/XA?=
 =?us-ascii?Q?WGYsiaCSb/EJoy2Mum7JEvuiWtOfhEGn1WlkqHXj/0KaoBRl0ULISFA1iYxp?=
 =?us-ascii?Q?bg6EjIV6YF4ppUHtWUcFTUcLKn5sl7/bu0+Cd4KS3f+6YJe0XkFUzutwCWr2?=
 =?us-ascii?Q?oyoZR7o4s+g0ze7sQzWn/n+VocIbQnu3BBBarmfLl7AyRgVOkySlF5EE8Y8r?=
 =?us-ascii?Q?JQrGwRCFsIePb6DKiL9/YyVIbXlD9Vwu2FsVV+6SZoZzY+vBdnr3oHvuT9he?=
 =?us-ascii?Q?PQoQPi5MX4F7szMyCBkOA1jAda9cNum2NGGGGZhT3AMiEhw8e6nnzyZfAq3T?=
 =?us-ascii?Q?5KqsVvlqdw+mCESwzywbJ6Ek4QusUjBy03dRpf8uh5dSdGder7KiTyvBJWX7?=
 =?us-ascii?Q?nNST0IoZFbqRvVBIho36c18zsEE93yo9zQxurNUIfmyi30j+ifwJbxqbJSAf?=
 =?us-ascii?Q?TmD/JGKMyRXFdlI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:50:35.4259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2436773d-4877-4754-b3f4-08dd54eafa5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

The IRQ domain allocated for the PCIe controller is not freed if
resource_list_first_type returns NULL, leading to a resource leak.

This fix ensures properly cleaning up the allocated IRQ domain in the error
path.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 81e8bfae53d0..660b12fc4631 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -583,8 +583,10 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 		return err;
 
 	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
-	if (!bus)
+	if (!bus) {
+		xilinx_cpm_free_irq_domains(port);
 		return -ENODEV;
+	}
 
 	port->variant = of_device_get_match_data(dev);
 
-- 
2.43.0


