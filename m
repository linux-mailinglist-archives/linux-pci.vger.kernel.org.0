Return-Path: <linux-pci+bounces-7257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8308C0372
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 19:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9161C21E70
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895B12C80B;
	Wed,  8 May 2024 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G5/Izlph"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0512C52E;
	Wed,  8 May 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190159; cv=fail; b=ILBmwJK6bvJiOAqs6GCFjBFDCaH0gAKh4BqZDI9yGM0LtmPKQPMcrnRm1y6DH30Tn4/1XuGJl0LThhlmUIbAJXLEfQqzBIVh9oRE4gX2vcWZU3f8cTp+223i48hKK+P2D4vdaaUASJGVadg3MD8hUyfOef/JIkEH4u2ExaY6dW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190159; c=relaxed/simple;
	bh=lby/wMtpUYH53Nmsg5fjQy+6v0bNJ3vxci9/wwpcqrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQXFjjrdeXOO/YlfZ5WVdjwWDP5GmEXwdtVY5GD6Ah3NQpXjpSPuWi8blAWpzQvGW7NK2ic/hWJVyi75zGpJ8PEKmMnzD6qEbJzrqQhEWlXfVrEvP5yxPSByxXjhQcogBg2wTuvFRCcMTaX3DTUIZSQszcORRRs6JwACE8bVYu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G5/Izlph; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju2FODLadTs2AvxGFZsRqnnEBpoKUxPOSqI7YWWhwGcn7SKKe4U7ZsStnYEGBfRluBCW3rsbf0w3AEoOHfXbMyKIJTuaX/uMB7SvgGbyYUceow5QWAoyDvjRHHR1Isw51w9Y7jJ2HIN55RsGWX/dmBmPax5k2+Me21+fPkFGubfOlp3g1kpi2eBGveygtWGsoaHUCcWQkHTAzCXodxqccNpIIAZC52Yc9qZKjfEHkBK4IxslbkjOiFx/IU0DEB4I9qdmr6WLBqvVPN3HMPYj8GA9YI5JiHKW48UjC9LgKGDBEcFnlw0Siq4lXYD0XnaiTiH7Z8FOX5dLblwljouupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKNpLXsBUlqmtukWmZYFvtj8c+Uu5VQ/A05GblTLFd4=;
 b=YrloX+pTirrzkMogH8wVYBnb89X7NKbv/YWCbae9MESbuqOdoBXFUJBDT0qA99i7xh4MMHD9DYzZVTk+COxLWSXtERCU+Q7SBATdcREIovSqrNfuXI366/+8K90B7kIKZKD5OHv3nUMi7b2nmPKRqx0DK39cd//yQwm+AUAJZxNPhmsDAr16CaPQcPDBPs3HBiYUA/hBDNm6LhMETs2x5MSa2M0UaRQugrv8W99fxWmvCHycw/NFJDDW5Ely7Vh5Pu7ag26/sdJUiSlqMemfYCyqpFPFjLnrPp57u1gekQYQjAxBE9nAbJDx1a/xIwmlowO1i6I2wmw8pj7SM9nHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKNpLXsBUlqmtukWmZYFvtj8c+Uu5VQ/A05GblTLFd4=;
 b=G5/IzlphNSw1blfFH6emJYatwGAkADCEfV0hxZp1cVFpLr8nTbTQ9hTgFXxF7aX6w3IGq2uLVy7LQjp3tWFlQk3gLt5r8LDApspcKLg6GE75ackEhfGH1JqxT2bFvNuayePHsGU2RkZsINFQEGbiagwwdfIdk5erfCIEEqFK9xkRnJq346WsbT45rjdzVOL3S8lCS8bw9TCR0qObps3k7UpAPJJXAjPLTs4ZhHd4mfxATXgvN9/yOV991GupYC0CY/llbZ5eQFTMkku6kncW5XqUtx6AdVcESAqJBzK9vQHxgHJ3yfTD+859DcCcH0M4pebDZ3NYV+vQfpAeGa/19g==
Received: from DM6PR06CA0003.namprd06.prod.outlook.com (2603:10b6:5:120::16)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Wed, 8 May
 2024 17:42:28 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::55) by DM6PR06CA0003.outlook.office365.com
 (2603:10b6:5:120::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 17:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:42:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:42:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:42:09 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 10:42:04 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V7 3/4] PCI: Unify ACPI and DT 'preserve config' support
Date: Wed, 8 May 2024 23:11:37 +0530
Message-ID: <20240508174138.3630283-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508174138.3630283-1-vidyas@nvidia.com>
References: <20240508174138.3630283-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff2a747-6f5f-48e5-9017-08dc6f863aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t4sc45athLZiTLhtOVR/vvWvWiFkgPnyTljw0pHXQpWQ4PzpmqiB38AOXu0d?=
 =?us-ascii?Q?nYcb/HL5ENkuuSChPWdSQ5b4GkuMRs4KX6/ZDP1gXXV+xKw7KSjJA9F31L+7?=
 =?us-ascii?Q?K9ttnM8bclrbDlOgicGdFyPTdAZVeZ9xR3HQDUkuI6iK4sSijaVnY8JmKt6c?=
 =?us-ascii?Q?p6Nt7pHMdcqEMGXjNTVq4LRQ+8qJQnuj7Gz1WZ0hV0eWiOJcv1KpL+17b1Vh?=
 =?us-ascii?Q?4Nn4+KOrUo736kB7ssvplc8voA/bpuDaBMmLjpiFRoUYLrKNQMJeovDSRVkR?=
 =?us-ascii?Q?wRS+wK270W/nUmxz5dNBIggYIlp80WKOKoA2WSfYUyCyHHPk0/wpuOhfO9eM?=
 =?us-ascii?Q?o6DC11+PKiRWMKIKRUhOJFRJiORR2tsLqPlwrRpaqNV2Ad5YJ6XC9Yn2WZE9?=
 =?us-ascii?Q?R97And2Vau0nMmTlRi8Xr3FJmVtvgWaHGeoZb0+FPpd6yyNSnMPLpeOLZx/s?=
 =?us-ascii?Q?UDKhyxxsVtwiR3E66SACaip717Zz4qlbGxhUofKYbYDYwn2yzMQuViQ62pj3?=
 =?us-ascii?Q?ZejjdmRL6kbYvvGR2pk8/IsPSxYq5Rx14UDARunepuYiWpYnpTYg4EECPYYj?=
 =?us-ascii?Q?iEm/7flii+iVrTZ+UugzXqgfT8c8vvGFC54XcprqAeK9yCjDVD9jIaUIAB4A?=
 =?us-ascii?Q?cfwpfxuux83hbw8CA4OkxHa+wLsE3visgRviGkNmITOTyt6CUzWc9cWMRE6w?=
 =?us-ascii?Q?4pOYlzjTe7idPFCoHLRvohKLeu9cS8PH0HjW5XvS1lqyfoF+DE5JiUDaT6tq?=
 =?us-ascii?Q?PgeRyLrNbAxu5DEqJJpb178/DfIDMPo7mttP/K9kox+qYaE5M8RT+JBGXrRq?=
 =?us-ascii?Q?JDeN9qLcRguxlkQorUV8KKUuRoD0Ex1MUi4UurFiuBjTeBgDh+uHuwwqbWKj?=
 =?us-ascii?Q?dNk1h005HAKcKgOv9xx4LkQak/BqMheLuTmipqi/2P3MznrkgsNhM4UlKoNq?=
 =?us-ascii?Q?BC8h5M28lVDOu/OG+dt11E71SwCU+e0wmmJSfaDe3i/asOWccSl5OYdc1Pec?=
 =?us-ascii?Q?qHdRfTFYGxvKPp/3GU2Mj1GgJgDlXWqUvw3nDc2U17GfcWRdaHYnFyoIleLk?=
 =?us-ascii?Q?OVqKBvJr0lX15xRNTzW6QLSYbOYD25IKNp1zMipaX9OP3Q7XFdAaGzuCXjmL?=
 =?us-ascii?Q?0+Bl0/ilpzi4f7/E4iguCta2pDW8iAqPpQAKwrmrQopIT/HgOcfDengPm9Xp?=
 =?us-ascii?Q?1gQDeeOQCwuYN5RdmyJwREk1FYjZjGRpBFL1iAwY3cwKiVsWY8Fcc2KKOoo4?=
 =?us-ascii?Q?I6kHsUCmIOu06bprfAk4hfCybX2XDOiQU40+SwPwVBFRquGr84eHrXtukN6c?=
 =?us-ascii?Q?lePcuXtQgiqCiTsNKyL1fwGr8LRr6SnhK/Tybia2YchtgUJPiqaL3TVnO1J0?=
 =?us-ascii?Q?cnFQgejRQC1MluYdz1pXqwM0MgN7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:42:27.8238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff2a747-6f5f-48e5-9017-08dc6f863aa2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

Unify the 'preserve config' support across ACPI and device-tree
boot flows.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ee086d029450..2c232c22d6af 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -894,6 +894,9 @@ static bool pci_preserve_config(struct pci_host_bridge *host_bridge)
 	if (pci_acpi_preserve_config(host_bridge))
 		return true;
 
+	if (host_bridge->dev.parent && host_bridge->dev.parent->of_node)
+		return of_pci_preserve_config(host_bridge->dev.parent->of_node);
+
 	return false;
 }
 
-- 
2.25.1


