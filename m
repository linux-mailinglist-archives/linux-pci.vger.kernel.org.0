Return-Path: <linux-pci+bounces-25666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ABEA85A2D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9AD4A5473
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1D238C19;
	Fri, 11 Apr 2025 10:37:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021096.outbound.protection.outlook.com [52.101.129.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C820DD47;
	Fri, 11 Apr 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367830; cv=fail; b=tZ1/FLXctXP+SHs5GiNKHbiNWRIwMlPb5MhNL5ldGF4zu4jgBpc+5RnWmNb2FInljhZGDZyIGzPDji4qvaRVYHF8Dgs0X9o070q9FvfAqf4OXuqZRMZdmh9W/WkqQ7sLfys9SEp9PcJnRCr/o276OlGY7oDkIIG24rV7wDeJn8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367830; c=relaxed/simple;
	bh=84dVrIWnBjnLXF8t5riG1C5Wp4dgODDFI1dDSRWik8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8CK+whXPaDr8k2S2B8sUXg6Vmyk8NtINEVidgA1ItXXQJ0EWzA9lARiCIcHZdVEhRCeJMALLg3a2/sR6VXkr55aX2vLXvsuQjfIMz2v1IEU5/vn/9+VGaqb52P3W6P3tj4kH3WaYSoojiMqwg01ECoRYD+q5RUIQaJChBcNSko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4ze4c2mLEmyp33naw8y+J5IcuawnJJMTpYhiB/7m23sQQARgSDH+iYTb1eBhcfzmoh5HsxATIh1M+8n3pmpTJFMzQwRvgig6WVsZI/RgEhSrzNj5XRzrLqrKqdSgHuIh12I1SOaatZ2liVZ5GGbEKOG4CEq+aR9HRfSuRgIxQllqXG2bPgYuK3Q7Aja8nF9yLy+cDHIdOCVvnCcn7KmSaxJkjgZnB+The2+3f0Yk50Ufdue6rMjo7mlCjUn/c6NdcnfXPdQhc3FTjW9g6Mhda4ffzjS74HvefOyrKIrCuH5qAKsQjqSWY1z+XAPqbdiyRSNb64IofxrAmjuPLhwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsKq/nHfuwqXnk9NOtUnr4Ey4GUmmyRUeR0hB7eU+ks=;
 b=leyQ8r8qAQefmL0sJF6Vkp8BDPTjpPd48tV3T9nx3MOSHBJ8UC5dtvu52jB4EnyYF6ysyj1SwcyIWEDDTe+qgQU07wcVP5CljKP21ayYA8lwyZ9JA6FA14zpmnFxHWdDJpisp53Qt7oH7lw4B76b2POWz/MiP0rYY+lRSsIG6q/TMq8VXliMxdsQn5ALvKJu5fk7w9i/zAYWFr7QI7t/eGtvNHMwbSG1N0+hlvezPAnyO/4NcwLNjwf169SoF/+OFvMYExLOmjV8BqV/0EkbmXOs9qjsvlEy+NBUgkrReQb2x8e4bKFuGysYxIgQbC6fVfTBQVflNj/frfksjGB2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0174.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c6::15)
 by TYSPR06MB6972.apcprd06.prod.outlook.com (2603:1096:400:46a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Fri, 11 Apr
 2025 10:37:04 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:400:3c6:cafe::55) by TYCP286CA0174.outlook.office365.com
 (2603:1096:400:3c6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 10:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 10:37:02 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 93E394160CA8;
	Fri, 11 Apr 2025 18:36:58 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v3 6/6] PCI: cadence: Update support for TI J721e boards
Date: Fri, 11 Apr 2025 18:36:56 +0800
Message-ID: <20250411103656.2740517-7-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411103656.2740517-1-hans.zhang@cixtech.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|TYSPR06MB6972:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0defa126-df32-4e66-c610-08dd78e4cc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3B+HWBfObPlvMz/bBYaSog2mbfbq/Fjor0xFmg9eJg70U26KEqrb0O9oZRO?=
 =?us-ascii?Q?5SWxfM2167TozF9R7FXwZl/5eDrS51OnR4+Vw1sKjivvbay096EaIX+nB4Ex?=
 =?us-ascii?Q?jAbu3/fYZPwrv4CoEGnTGUZsh3jfy3HKjxzbbKLs4GNS18OdB3boahc8WWOH?=
 =?us-ascii?Q?eNs6COrSDgTLC0OHfXly7jKVbuZ6nVSEJ1V6W7SRbsb1V6Imna4fjYgig5gI?=
 =?us-ascii?Q?0OJUUOf9DqBCIiteTUP9IdYCE1DRmKGBApQAcjJiC+niXEzF070stLnhSz3w?=
 =?us-ascii?Q?Pyv4W7wlrvMk2uC71Bj90caCpTmYHFB2FNNgg9G+S1hCCZsVQ9BmN1lsi65k?=
 =?us-ascii?Q?m2IDQay6j7xnhG5ipZDDF1c3/qnTmQlYp2S58U8LIa7SaLyP7hEZMenKh+mw?=
 =?us-ascii?Q?V3s/Ybif0YKYi4yeQ5lCzEs3/qvZKYLjsebh1cBvS80YcbxBHxp6GVueVsaK?=
 =?us-ascii?Q?KUpZ6uCdj55MXdto90BQajEiOoSZaDD9r3Pc5y/8ZPWUgr2D/BgN1VzrrjP/?=
 =?us-ascii?Q?nMikREIQUHNpH1VljuSQWNfISHHgKPLUAwVyWjnQ6ixs2RupYt0JVXC6z0Qa?=
 =?us-ascii?Q?M9lWIo0BAu9JIlrhPp+/6gbzck/8x4kq9kFUE2yvEwowrqWhc+ObEWxqubqO?=
 =?us-ascii?Q?ZU+9FhzTK/374RJ2EQmlOAzdWibWJo+qWyVjEq9cKjNV0EftGWMJrB3c5D6c?=
 =?us-ascii?Q?8xL8vDrYNn+AgeIp6pkP8ANqiFxZq7pSCmT2T+xDWN8KtFkPQCUdJCQGH4wS?=
 =?us-ascii?Q?UlCuyy76WqtRZ+qbAUsm15Bla4iKcA4UlbaQIIXmXQteppsFGY3wSvG11cdV?=
 =?us-ascii?Q?wKfIhj7MQGYbKD5K+v/ROVmKbnFpG2I4VFhNOhp4fgLCsoz2EGX3ExSgzs09?=
 =?us-ascii?Q?8UxrrkKGC66ucF7o5LaU5SU3hj1sjY644dvmdjWkwd9HqPiF4ZnNFzKJlbvY?=
 =?us-ascii?Q?rxK8JD70fn2NDoay3kw640AgOXP/v1R4TwH9FZAwn+6MD8mQLeZq1Ino7Sl8?=
 =?us-ascii?Q?31TXCRxbpV3lkbbpIjwgYTdUAQqRywYM9GRLczBD3oOZu9/m1bs1D/c0nQ2P?=
 =?us-ascii?Q?LIev6dG1Nj4359mbDl54O+QhCksy3+s0aOs8fsxmMlWfRMJAI2b/kJb9J7OC?=
 =?us-ascii?Q?ijQ1XE87MfYJ7NxU+0uLhv36DfHC/sVtc1mLJB6/OtfKiGWUcdHT5fMVn1hZ?=
 =?us-ascii?Q?QYLg0+/xtTRDrGnzmrnq5WaTIYmgBRmZ1YkVDhtG7oIdcdgekpoA1wM9vp1D?=
 =?us-ascii?Q?AsiroA7253IfNezpboS7246YAw7VhCliaKpoYWkw25wm6mTSTVgRBA16yO7f?=
 =?us-ascii?Q?UWMfSZrXMP9Uyhe8GB1f/RJTtU0lRpva7wvenejGm4NAkX1NDTDYZ0bXxhnI?=
 =?us-ascii?Q?Y/gc0Hf4mx5+qm1GnEEYhqarJV/abjb++ncPhzj37VVUxh9t6UQyHEvDOg16?=
 =?us-ascii?Q?o6EK+WDaeHsGy2lUKRnANcgT/1NeL8A9lKbNFCUPczlEKB8u+26BRna7VhBZ?=
 =?us-ascii?Q?UBuC0otzQyKjn7prxJoKKjKkpEwZT6+TVnyq?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:37:02.8862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0defa126-df32-4e66-c610-08dd78e4cc48
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6972

From: Manikandan K Pillai <mpillai@cadence.com>

Update the support for TI J721 boards to use the updated Cadence
PCIe controller code.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ef1cfdae33bb..154b36c30101 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -164,6 +164,14 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
 	.start_link = j721e_pcie_start_link,
 	.stop_link = j721e_pcie_stop_link,
 	.link_up = j721e_pcie_link_up,
+	.host_init_root_port = cdns_pcie_host_init_root_port,
+	.host_bar_ib_config = cdns_pcie_host_bar_ib_config,
+	.host_init_address_translation = cdns_pcie_host_init_address_translation,
+	.detect_quiet_min_delay_set = cdns_pcie_detect_quiet_min_delay_set,
+	.set_outbound_region = cdns_pcie_set_outbound_region,
+	.set_outbound_region_for_normal_msg =
+					    cdns_pcie_set_outbound_region_for_normal_msg,
+	.reset_outbound_region = cdns_pcie_reset_outbound_region,
 };
 
 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
@@ -479,6 +487,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
+		cdns_pcie->is_rc = true;
+		cdns_pcie->is_hpa = false;
 		cdns_pcie->ops = &j721e_pcie_ops;
 		pcie->cdns_pcie = cdns_pcie;
 		break;
@@ -495,6 +505,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		cdns_pcie = &ep->pcie;
 		cdns_pcie->dev = dev;
+		cdns_pcie->is_rc = false;
+		cdns_pcie->is_hpa = false;
 		cdns_pcie->ops = &j721e_pcie_ops;
 		pcie->cdns_pcie = cdns_pcie;
 		break;
-- 
2.47.1


