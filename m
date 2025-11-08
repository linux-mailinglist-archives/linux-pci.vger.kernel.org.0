Return-Path: <linux-pci+bounces-40632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CA6C42DE7
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD213B452C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36809231845;
	Sat,  8 Nov 2025 14:03:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023137.outbound.protection.outlook.com [40.107.44.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D71DE4F1;
	Sat,  8 Nov 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610598; cv=fail; b=qniHEv0yEQnXL9zUwJ/k9SmdmlX2RgLPOHQO8QpQCjRNjyVeWQE68wt7IjmvusBDeUW4F8n97CF3VPtoTNid51srPU3SC0i1BiNL4VYgDVQ2jAQD5kKiLXMCA42o9P7KvInvEQMNdBc3S6ywiStONZazc9WtOCDxCy8q8K2Mlfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610598; c=relaxed/simple;
	bh=WlQClg6frxhcRHEMj8ZylbzI4DB6f6yJ0EXyHCZdLhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhA/OfBr+0U4HWUeR2S02BBuzHSMnV+MIBiXBwaDguhHUTYnFajjevczVufwy1OcQxWV7yU47lo3WMnrSCoNMcNuSrMbuVd6k1yzbu08qZYrkN9mMBWPoSIOPwy9T+O7czE9Vq0iwfRGCs2QsfpxNXvd6nYnXUMKQRU5s/RG50A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfTaXzuihE+1VtoGYNRFS9eGccliapct/k+qyTG58gTaeUl0mUiRJVb+uJ0gnSodaJUSgxRs23PYFuQchSPZ4TSSwptbBS5wtC2d8qQ5VVHdym2Zl6uhdEcXhEVii9vfX5nNKh9OCLjJbOhVcRej23lIrIpRvy1VOMOIBxAXjR7DimowQlzDNOMBsNHd/aiPitB8gIslIN/tBMD0ndOM0X7wayADUDMFN6Kr9BtKQcr6eve9Aqqh0/7p9/nlCdo3onAQSQJ4rzmpZEUyzZT8MHJL9bgZ4aub/nAW3+uGFahNQsIi9n83BA7AwBnRlwF73hzzHQE1lnJjFlsTfDUs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXU9wPxi9DZ+GV6htPv6QnuXrMW5w671lSIBh5+Bnh4=;
 b=Cg/qc3qETuPz2J9lvJThGDuRIqsyMs6iQqvU/PsDioScjwRGZf3CvbleZycg7aZf2+7QJriT9/RqzCEzb3CbH+/5c4pLaDA7UtFrtWiu8NW2FeKZEhEwf2ayApqfsSzeSr0DXxkpwYgde+4RXV3AUslqpONfqHKaKGvTNK2VgiI5LT9yqfoXSFqW5dsr9CsaJV3pS+FjbqdqgEM6abG6AYQq6nK7aXQ6a2VbB/DmHyT20yPMteVhj6IB8rYHqWa7Ltl2PsQ3aGxK4ex3uVXEq3R57ObW6L9sMgNMtpYnDtjP4xwr3byTiGNAVYoJf5gTBXK1kButR06vu2A8Vlq/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::21) by KUZPR06MB8109.apcprd06.prod.outlook.com
 (2603:1096:d10:47::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 14:03:11 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::47) by PS2PR01CA0009.outlook.office365.com
 (2603:1096:300:2d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 14:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 529594143A8B;
	Sat,  8 Nov 2025 22:03:06 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v11 08/10] MAINTAINERS: add entry for CIX Sky1 PCIe driver
Date: Sat,  8 Nov 2025 22:03:03 +0800
Message-ID: <20251108140305.1120117-9-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|KUZPR06MB8109:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 49d35590-7066-4d5f-b840-08de1ecf8c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0mstjp6x4McUIMe0lNIoZL6fLPOZAUCXdy3AWEBuCK48zYK1VQS0dFle7Bpd?=
 =?us-ascii?Q?Ka3LY48u+Q5wNIRBbj3ywwczr0HkQ5cE7TpSaZaWP8lm6BSZLpA6N+w7ggKl?=
 =?us-ascii?Q?iUMxqaPejZSNH6unvjBXYTOwW2HNOczQ6UM83RQEAnb/KnZqqR38J0mIjQ3s?=
 =?us-ascii?Q?UZVn8GXixRfHZqcsSxZZH61eRvayeaI/K79YzdymsXTnCSwAHgbGykWLDfS0?=
 =?us-ascii?Q?8sA4W+rdfvCiXyjzUxrvHPlROG1Y0OFHaMCAvVh4SfI8WRPHODxpfBEd4RB3?=
 =?us-ascii?Q?FkAhriQl2rdhbee/QK3fMVU2n6m2kg0zvCNkT56moUpy5S6c+9FMLFpXPyob?=
 =?us-ascii?Q?ypr7lxl9ges/2b2CATk6WVmV6KBt8ncNKI8WMoBQQO7b/Q9OLtp/lgYwm5qe?=
 =?us-ascii?Q?5pqVrCa5Os/f/HpDLkIpcuyDfiFUgaPKb9Cx/MUBHt+EKRvZHKYFuu558VVP?=
 =?us-ascii?Q?TiBhm8XZBxcQa7FIVQgmZ/+HEYFwgIA9+f6kqD9PJQlKTl1RQmT3PeN1n6Fj?=
 =?us-ascii?Q?7M9oX5MEWxrNphk8NeeY4PelNZJZz5ZnY786QyQHEE8i3BWCTng8Sjr/IARF?=
 =?us-ascii?Q?BHi3PFnnlBRjIsalgCCcgcohwH2NxIBSP6WTeEPE1oHsSePwWjlqPyLSV+tY?=
 =?us-ascii?Q?mSGRpCnI6DmmeD6tcl6hHnTdwTVvLcEi3iZ3JL/VtTqYqM6LQT2VMxEPRYmE?=
 =?us-ascii?Q?El0/5RdzLNDgd+uoZc4B39SuvQx6lFE7cjiqDxP4rJ03iq1iI8WjjFdK/DFt?=
 =?us-ascii?Q?OREy8Hp1I8/BHSXzOKBWoXcvFqc7XjbT/zO/2S35JGHyATNr2iQTjk051yO9?=
 =?us-ascii?Q?PbMhSwkAJH55BXcv9wewkYDJc1UeAvtgAiufgEDRpgbyZXSI1gOXn7lKN3HZ?=
 =?us-ascii?Q?EMJCk0Lb7go+GrOA7zfUVG6+N4huG1d/DQZ7///N2jmCBKnrbd4Va82q8J2Z?=
 =?us-ascii?Q?yB3F1lI3SMNYohJuHX3/Vn0Pn0CBmsSdAkIDjBynN1vUSpGjIgyqBwmvp89e?=
 =?us-ascii?Q?5BkER9GENhGwDurpBWgW9w36e/0AMIm2EB4kouL8KCu1s4OeVOKEiYaIHlpo?=
 =?us-ascii?Q?Kpw8MEZc9ezW+/vpX1W8acBLzXo8CJXb6LsvBgFgFZvWTFqsbfIVLcOd3uDL?=
 =?us-ascii?Q?C+ZLZnGWXpmO9M5+gjsrHxd0mZQNmBgdCAzyGelCVCSTY+WtXqdiW7rueSJn?=
 =?us-ascii?Q?9wGhgkCYOmW5ltBzE5Rfjvu/jYaT2sGh1lR7OY8mkmyyd6RqdDtaJZ1h8GqI?=
 =?us-ascii?Q?sGCjKEEJotw5EQOmMBhLLU6YEXfKptHqMxJpA34QL5anJeCx4yVBpf1f1Z1h?=
 =?us-ascii?Q?kfe1SR9Dbp+sANs9FaLhvtzskdPQ6PbLkOSQmadSVBVoB40fjyYwQBuGJapj?=
 =?us-ascii?Q?OyMJCkaBEuiTuoiUYQ/XxkmuDZ1PyNHHj3sCj1PmlOrpfAxKwsGG85qSZudj?=
 =?us-ascii?Q?FM9BK6W0VWNjA6cpnKP+t7DVyDJukB3jGNnaVPwZwj7ZglUOn5ZKBnoi3t4W?=
 =?us-ascii?Q?ECGa+3OfvC1PniFFj6PKOCiV3T7BAj8hYmTmQ2PN+X3A7lYcTkqwpyOQSnY2?=
 =?us-ascii?Q?rAncguDDZm36+BnR7/s=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:09.5517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d35590-7066-4d5f-b840-08de1ecf8c8a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8109

From: Hans Zhang <hans.zhang@cixtech.com>

Add myself as maintainer of Sky1 PCIe host driver

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e033042..5b3f3aa74365 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19646,6 +19646,13 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/cadence/*cadence*
 
+PCI DRIVER FOR CIX Sky1
+M:	Hans Zhang <hans.zhang@cixtech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/cix,sky1-pcie-*.yaml
+F:	drivers/pci/controller/cadence/*sky1*
+
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
 M:	Mingkai Hu <mingkai.hu@nxp.com>
-- 
2.49.0


