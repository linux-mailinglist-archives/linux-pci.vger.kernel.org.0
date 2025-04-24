Return-Path: <linux-pci+bounces-26630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5CCA99DAF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC4D3B9CBA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B814D2B7;
	Thu, 24 Apr 2025 01:04:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021090.outbound.protection.outlook.com [52.101.129.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79A134CF;
	Thu, 24 Apr 2025 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456697; cv=fail; b=NBGsOuIR6ocSSQYTYtDuOfIyifuv5P92+2wYzRVuIZkYved3VM5kQFnqdcITt5KDWkt0QoPOoTBGivBKkYejBmh09WMZoi7BI03NOH6ZRIIt36OvZm7eiBQj4gO89Es++94bv9TVjO8yVOwhkKTD0roJOrmt4zlJm6K5yQ4vxzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456697; c=relaxed/simple;
	bh=cZBWgZaF+UEaaBY9se3ph66+YPjawMwKBPKsJJKzWZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVWuDw6ZKZnmzG/haNRlqrzzOZU4cAJDWPjWvG1JGHBYO+F0wGS5WlOodakekJIvkVlOJkL91IvY09HvH67dHn1JRTG4gUgHfzBFgwhYDPGfCelbyMDpZGzt6+Lh+JoDTrZpgt3pqolZOTMJCHMff61GogpirUss02aaduPizBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXmdHBNZg8WfKTTBFvSkg+aKNmZIhfOkEtvqGtBucjWQ/UJ6eJgY2YhyjRLdJYKUMH0dYaUzNKW9rDQO6dwAzAwIXAsUjV4ZzbaXWocofeS+8LNKhh0r1XMPqUbFRhrZuR3GTui6uh6NgbMEyCAG1qB51ZAu0XXFbBoEdnKl2UGpbbupkTDwADTaPVluuuxLu+GtGQDAQYW7ERwQL5z+YiiFQL0ej0dvqbz7G2TRLCXB8FHsayBGX2ue+8T6fwKVznwzNZfCNmAdMZ2NbeD6wXZeIJGJ6fcUjbDb+gxRssW2vC/MzSsEn9LK7I8mIMJ1B0iHRFSUnbReQDiQ/QewsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QR8gMxWgNXuLdd3i4EDOT6UVXZROz6nhLTdR66T6pU=;
 b=TWEEkXCRVUtjIbCj30StX+dy+1gV/FBl9x0NvZcO5GcFhwvFFBz8GgzpWTGsZQdHFGjadEyXN0hWQlmbBEdXItdjWNqd+HccQvxxSVqk8deUXZwQFvP3FJ9L4LsNPaS8rwnfUFSMemPA4J/V+Ec7MMj8ADkOe3E4wx61/jfEqtILb/Bpf/uux1R6/VzNzgQUrJQq9oPGoBZ2Lr6xj98l3Fjdt4R12eKJ1LbiqCJ4beGHQsv5XduRrtTR7XttbM9QYUkdAa6UOYakZbkIkVdeaOoB5kFeAYA7KM0ogonEAHJWYMuo3Po/BPKt0dHDqAdd56sahgT5EC5fOSuKLbIz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR06CA0008.apcprd06.prod.outlook.com (2603:1096:4:186::23)
 by TYSPR06MB7097.apcprd06.prod.outlook.com (2603:1096:405:8d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 01:04:48 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:186:cafe::6e) by SI2PR06CA0008.outlook.office365.com
 (2603:1096:4:186::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Thu,
 24 Apr 2025 01:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 01:04:47 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id ABBC341604EB;
	Thu, 24 Apr 2025 09:04:46 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: peter.chen@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v4 1/5] dt-bindings: pci: cadence: Extend compatible for new RP configuration
Date: Thu, 24 Apr 2025 09:04:40 +0800
Message-ID: <20250424010445.2260090-2-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424010445.2260090-1-hans.zhang@cixtech.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TYSPR06MB7097:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9f257c14-d373-4cbb-bef8-08dd82cc0202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S2Tmx5e0VSGC09jYqaGeYmcUQu0Hp7hxIKnZBo8uGwAwCAHl9s1thOxcoX1a?=
 =?us-ascii?Q?FMDibY0VSIXY0JM+XCxTaiGitOnsCvzHbEIfHf4ZebUO+IlbgM31dyOsQogI?=
 =?us-ascii?Q?iGR+eOlj0I2EWwxVtvoqWJW8QLOev6aX4KgPR9PIW5mLYtEAt7Icec+3j8zt?=
 =?us-ascii?Q?O3fuypr9LzdMUKIL28DYcKh67JmONWxyLj8RNd7s8ixPGEaTu2364lOYuXaj?=
 =?us-ascii?Q?4GYP+qo2OmWjzA3IIhoW9JNa+J/6apTX/RYAff5wXpp9yJeUvIJK7Xd0pvUf?=
 =?us-ascii?Q?9h3ERv/Blhf6QPcd4kZ3SsD0nNDBv5TZRquBwW4Qo3APmLJn0eHHVm4KT8AR?=
 =?us-ascii?Q?WK+qBvJHeUtE0k199dZlpyNngpqzR2Um6HSbF/LjcAo14Z7EscJtu5RXqwA2?=
 =?us-ascii?Q?p11KWXxt79Mo9Wbyl0BklsawZmb/GaUflNK3CPt5CUQ+qhVYVHYTCCOwISY+?=
 =?us-ascii?Q?Z6cWWORVU4Jv3ZLxTcfqGJ3xEH/GFi6R2GEmFfnI72v1y41ppimrl4UHWxrX?=
 =?us-ascii?Q?z+pwiAPk0ij+CqFPuJpYC3LZw6A9X/T+1dsyNsg21OPDLFFTjMjc3GOFo8Qr?=
 =?us-ascii?Q?EnFLqbcJiqXsMlhtd1V066Us51R92znM3LG6RgNircsqkivvhe76IJy3EA1s?=
 =?us-ascii?Q?51FfdD3nFRj5o8Qi1oIFIAtUUnLg17UAJxDgESP/PmOXM7yBYCKo/fndRtC8?=
 =?us-ascii?Q?Eu+YuNAQzW8j/HYbKAjud8/pbZ4O+hslUGEMcMpM6fOPKiKrc56iZgjfIoZm?=
 =?us-ascii?Q?z6xHapLN0AkOV/AeLZwxmXO82ZYBT/qbBhyYm3t9ctByN+qfq4uR291Ep+YS?=
 =?us-ascii?Q?GKbbUNMV4OakD+XM/IxvT/9DuoFbvVeVJ5lQ+oNQX4z6pSRLw/IOdpzCCuFd?=
 =?us-ascii?Q?5T9I6wYHN5ZWOI3fUEhxkCdxCuqtOQXIBxvq0imugZ89RXzbTOZCPhtIG8Dt?=
 =?us-ascii?Q?RkucKeIOD1VOgRdr0WzxclpC7kQmWZaIbX0UNfhoFHxGlC/8fmQpsNu9DGA0?=
 =?us-ascii?Q?NBX9C4YFLwnjeADfCNSDm0j9aNd6+Xmk3rDH6AnynYyrUb9sbg8Fyg9Ospq5?=
 =?us-ascii?Q?yCVu0wTDpcrqU+zUMf32kP2jpt3clWSKkoTxPybhTZzDNSGEer/80cWwYHJ4?=
 =?us-ascii?Q?MaBeoLHN/JF1evDByWlXbx8WW0XYBpSsvl/apPLkhomw4IgMcl7aHbmEab9M?=
 =?us-ascii?Q?+7tmK+cPiSAn7TC5fTiBi4nr+BIhWB/8ng8wIpEN5Btky+OE5HSlKxyF/gXX?=
 =?us-ascii?Q?XDezsLr5H4OGJsp2KfLj5rk+W6wCepDDUNKFqoP7oZgJbRY4Fa4P3kfm+R20?=
 =?us-ascii?Q?SdB0QuKvKtWJjnP+FWthUCb2A+mGoFuaXmoq5GAYqyncGWdfA8HrD+jLk+F/?=
 =?us-ascii?Q?DSLXoV0+1/FLDlnuDdeJdgyRAN6FATQ/jEsaNXPiaFkqOQH9ELItd9SSPlSl?=
 =?us-ascii?Q?N0wwBnwkXdczjIKPdcqEjQd1F9sk2IyM3oD3ehYfWzMUOknpVAcM/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:04:47.3277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f257c14-d373-4cbb-bef8-08dd82cc0202
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7097

From: Manikandan K Pillai <mpillai@cadence.com>

Document the compatible property for HPA (High Performance Architecture)
PCIe controller RP configuration.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml        | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index a8190d9b100f..83a33c4c008f 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence PCIe host controller
 
 maintainers:
-  - Tom Joseph <tjoseph@cadence.com>
+  - Manikandan K Pillai <mpillai@cadence.com>
 
 allOf:
   - $ref: cdns-pcie-host.yaml#
 
 properties:
   compatible:
-    const: cdns,cdns-pcie-host
+    enum:
+      - cdns,cdns-pcie-host
+      - cdns,cdns-pcie-hpa-host
 
   reg:
     maxItems: 2
-- 
2.47.1


