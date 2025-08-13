Return-Path: <linux-pci+bounces-33902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7BDB23F88
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD2B2A4855
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288BB2BE7DC;
	Wed, 13 Aug 2025 04:27:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022083.outbound.protection.outlook.com [52.101.126.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAC2BDC0C;
	Wed, 13 Aug 2025 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059235; cv=fail; b=SjZnOWb9LriKeJXkZvCpT/ysqUozkX8Dc7o5CDlxwBHABWiu3WTjmNGap5J3AtcP3mXZGr+eqRWFrf8ZmKAXtSZmmKGZdC7sDL71QUOEmJ4QhhuIgYRmz6cK+zS/RuMyEq+ih41qe244Cf3udEknLfuYk+2DrIi1OP+dJSu2Cvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059235; c=relaxed/simple;
	bh=G5eOl/Xm3GP9bTaLZSi9myToHoyTJVqJ7DYrdSEslFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipVAeSaf6dPeVuxE6TKVKwMMNHNZ1CKekz1d5g6hOuyDRkkrx8UOOXGeOB+PMq/hA8SdL/WbsrEVYNhrnkbCuaEq7evJcUlijYjtgav4+u8pophvHZOyHwlbTo43MtvdrIlsENWs6/NnXpPfu358HoRS+XTmlNqiB8J0UbY3Ja0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHMApO3DItRYSPnjomqUA36M6R2xcbNQOjLafPCQcyCDxqGPJ/p50XHoC9YqsJRnFL96il7vy5NNt1cFI/8bROkGKe9ek+4bZix2a7bH/3FcK4AGE8lOSBzhG5R3XTK+ZOWI4vTBP/pwUfxY6s/cGthq4GXDe8Q6ma6lAzEP4zHEBH74QSgojYawQvWqvsu8oX8BhqvvsIFL5icRLrmaRmbvcAdS4m9RuZmrwa2ddMqqQ0uM4Q20HfmUW5ZuRCbiQKrBMpa3yTNDf6noBZRr4HUA42XGsIXq+r1EAwUG5aBzZmQDNRcJQCP5MoUrtYediXWfBYDSnwNc6MEjuqsuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8BToPZxjTD4L5jPzzFAljpwlBxu60t0OjqLNMwJZRo=;
 b=CIgMNwLO2rOkwjIE2+BBTvwmGGxLvjNQ8yrtjAUGlcwW8DfK3xuQZxUkG1Xnc/x7cK4txQuik6VI3jCqJPxCP0k6e6dEr2Xy1BtSlHYU3hawb/oM3ZuOM/k2jYpgUGHUy7px7DyrdkLnREKZSHmE2lyBn6TqI9funwRyjNTH++XdFP2fxtJ/vHHQVYuRpepruIR1yEDSlCjRXgB4wFrVwTL82zjLtaXIyhmNm7IhbLYM3deza31BZrib4H0PhRe69SPDlDdFs6SkTbLsV62nsa0iLV7yhbH2i8GU8uQsCOuowQQjMRg8eF0V0z8m4jX6xkRGXO8ktIdEM6dw8vLD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS7PR01CA0001.jpnprd01.prod.outlook.com (2603:1096:604:251::15)
 by TYSPR06MB6315.apcprd06.prod.outlook.com (2603:1096:400:40f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 04:27:10 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:604:251:cafe::96) by OS7PR01CA0001.outlook.office365.com
 (2603:1096:604:251::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C6BB241604E6;
	Wed, 13 Aug 2025 12:27:04 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
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
Subject: [PATCH v7 09/13] PCI: Add Cix Technology Vendor and Device ID
Date: Wed, 13 Aug 2025 12:23:27 +0800
Message-ID: <20250813042331.1258272-10-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813042331.1258272-1-hans.zhang@cixtech.com>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|TYSPR06MB6315:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc502970-b2c1-48bc-544d-08ddda21ab08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O0NGO0SvYAdhCMT+h9WtNKVFOWzHSiFdxTaBRMeJXNadAZ72QZwF05SyurHL?=
 =?us-ascii?Q?Nn4Tc+LZxO1uGVjxM4/L6vBH9J0Zlu8HH0uenU/vat6oLUgbKs5ekE8KMKvk?=
 =?us-ascii?Q?5VcGUoRJETLgsOLqPjnESbQjRxDPFAFrcuz5qa6Gx4em7kMxuAt8kSMAGF8J?=
 =?us-ascii?Q?vc789ZLgKyXm3ELmgOM+F6BDXI/BMcpTsEXgY6t2QsOjQI9ccf6IC9zYgeVH?=
 =?us-ascii?Q?szV6YncxFY9iRqKqdhjDKP81/WXlBg/x5a/h+IDhK750Onlx5PbtlOAltM6q?=
 =?us-ascii?Q?pSZAh8MO6udifk9vmXbjal1o3ms2mVC+TsUBChFdRhGnZ4T8S/dytGbSpNnX?=
 =?us-ascii?Q?wF247dctjJ5fzD69kP+n9cyvlJHCbNf172f5xjcEcAscVQf2XZkOnTXD1897?=
 =?us-ascii?Q?+Z2eos8cVNxfqQimebXKZ8bO5dNHlnrjbk6g+05+oQj56DmMAxsXuO9k5osj?=
 =?us-ascii?Q?K78QidffClIPrWi3jTuK/gQSSrQ8M5RhXPQBq03V4PRhBiRPhckoJD/beaP6?=
 =?us-ascii?Q?bSLhctOFMGPQQTliGzus6Um0BrUTO2g0LibVRMnfTPKsx7d0fO+wVN3BsViw?=
 =?us-ascii?Q?QpFM9F4GzFfDfE1GcEipAwlJI68xBZznicBfekTq7EsuCC9p6V7PAryoZBz8?=
 =?us-ascii?Q?+KppIyGzi+h7DqAduP3EiuP+u45AgeSPVJ5CpPy1f29j43Jb7ab0to68UELb?=
 =?us-ascii?Q?eMN4FguzylVW6qxN1GGt7/VQC0XAlb5fWazyynY7v33eduMcHx+Kqf4KVqoA?=
 =?us-ascii?Q?sOERq0JWKy41yYvSFZM+5q6lDbf+Ot6N5TcW9OX3LSSaRTkiqcBwMXjWgk7A?=
 =?us-ascii?Q?hBYPgI0qL1FJBa005dvTNS73yLJZZdt3vbwGtJSxlxd78oioP1V0UktL2zzv?=
 =?us-ascii?Q?45X2DD+DKm0VI1AgtxCBxEOn0etyQGETJkHg7MsxEhyk/16k2vuNZkCnczf7?=
 =?us-ascii?Q?horNlYuVSVp760UKXnTdFzComiCHaoJS4mAR/1mBxWPyNeQp6aps+7fTDHjJ?=
 =?us-ascii?Q?mBY7ySK/X09GmSQ10CGrAmDjnySATs1j8OidyyqTojLQJYiSjzcTTVfpaepS?=
 =?us-ascii?Q?pW97LDDDz9heoNlqCFmPG3gOOTHfQNwyXiu71Eo6gs6OtpfNYJVbAvWYAoWB?=
 =?us-ascii?Q?8q3rS53AoYyM//caC7RRXj267suu5LUQCKQRa3Ncor4jIwjAVSyl4rQd3/D0?=
 =?us-ascii?Q?/FeB6vg9q2QX169ysogLt2YMGD+jv3WbyZkoPx2g+n1Td3ZQ7+GA6H/lgsma?=
 =?us-ascii?Q?TFqAFJkVGwWXvJBesVoiEUp6rAaB5+GpkayQM059jfFoTE4SHrV8D3kocr3H?=
 =?us-ascii?Q?CV7/OJlLBi4v/ZT/P4PNlJmD/V32nhnT8X9F/VOByXCLzhkwlRb7w53BIexj?=
 =?us-ascii?Q?ABEzvBv9rRZeycW0Yr3abdcAGwAveGSkopLbbHn1QHCEQigcuuB8CXcHOS+5?=
 =?us-ascii?Q?1w0hiIxDZys+vyAJOEpvICT0XwixbniRG08EEhEEsc96efh/kMy2mTNxZi2P?=
 =?us-ascii?Q?d1nv2QfJelUy6O9YcdrSypEhfQkcQtez29nA?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:09.2455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc502970-b2c1-48bc-544d-08ddda21ab08
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6315

From: Hans Zhang <hans.zhang@cixtech.com>

Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
devices. This ID will be used by the CIX Sky1 PCIe host controller driver.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..24b04d085920 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2631,6 +2631,9 @@
 
 #define PCI_VENDOR_ID_CXL		0x1e98
 
+#define PCI_VENDOR_ID_CIX		0x1f6c
+#define PCI_DEVICE_ID_CIX_SKY1		0x0001
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.49.0


