Return-Path: <linux-pci+bounces-25662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8E3A85A29
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB2C188B486
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC341221271;
	Fri, 11 Apr 2025 10:37:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2113.outbound.protection.outlook.com [40.107.215.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F91F03F4;
	Fri, 11 Apr 2025 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367828; cv=fail; b=g0VovxhNevztDQiHfYHEcP7Cl2SeHci4lmYgS833wwfEKx+xCBzRZusYetYaRbdGOYmtnJYuxrWnhsm9+wDO8Yiw42mMppVDLN6DmFrpI3SsINU2rWG8oEGmwuHpZT/Fp8t3sXnpBC4pVCh0SqlzEX05He803kddipB+B7ReI+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367828; c=relaxed/simple;
	bh=cZBWgZaF+UEaaBY9se3ph66+YPjawMwKBPKsJJKzWZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jf0hE59cPMxDDgy/64/PGkaDef6mO5caDj81TF7JvNBK3FuC5or/YeSQQLnlsFtObgQWRKlf+4FQOqiUglHn/iEYKgsxYniVXmO1Lh0mLJHURBUuhU0dPqy9HU+7Drs4PRp6DwgG9xgWAPcZff5SXD+TNv2MtO/0b0hbEHraPKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUoZKvYX51jke7GY1xNLkmLqKj+wjtejlpJIQJ/QaxlDIzoCT4nEXk+tH1C4QSApN1RnJ881jpfYm5aQhfrP+tQsXME6KVWtMOSqXA1LdiZznuNjM/n20FImW++OeQGs23bw77f8UC0Nk05N2cd5SOxTbQ0fYOIoMP0A/GEhE2qf9MZei9TV6epyueJ7YCoofUowZtOC+sbU8JCIVBlOcUJ+T4wpoMhRSs/8InQ4AOzEOENVz3/qUfwLAMlLOmqoYcnaJIVhoZdc/2qlouKZ3qxN9aG99/wkxbA1w7M2MNTH2ewbbGTGbvwutgSxUBJzpK36fDmFHw4Wy0DGwcGfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QR8gMxWgNXuLdd3i4EDOT6UVXZROz6nhLTdR66T6pU=;
 b=IjJjTqkmwKTMIoluJlkOjpsymlx84T206zS6CZyscxmFdBP0m7BgbH9mHMH23SwziR7qshzn8kO6jm09/vMG2Jabl//b1HthlD/WIIXiwOlLcSss66Y59sw6+23WglpdwE3126I4Mn2Rgz6mRC+hCbWeVCV4MusrFkpbDEP3PdzbxWJyUWpxS44oFgMMidD/iVxbCzFmLIY/V4ozBDkoWMR36nl6Or65ROZ4Ogzqt5IPgSsjqXa4/qSsPL7g57h1nC0H2aC+qdKZqwhjjeL5TdUwXkP4Y+x8gq0eB6nBYU+FYY8oJ3OvzFilfjEJgajpj95ntoq5Kb/czrXh0amtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::23) by TYZPR06MB5347.apcprd06.prod.outlook.com
 (2603:1096:400:1f0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 10:37:01 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::fb) by PS2PR01CA0035.outlook.office365.com
 (2603:1096:300:58::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 10:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 10:36:59 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3B5BD4160CA1;
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
Subject: [PATCH v3 1/6] dt-bindings: pci: cadence: Extend compatible for new RP configuration
Date: Fri, 11 Apr 2025 18:36:51 +0800
Message-ID: <20250411103656.2740517-2-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TYZPR06MB5347:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e877df08-4bba-4926-8d64-08dd78e4ca30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSSZ6PIsn+glpVKuKdam6gghVlGHUIJbaCZxZatthhjiQ5DAoOHmXJIviRYW?=
 =?us-ascii?Q?ZgcsWg6rizHzmldRBfqtv1xdc4YO7Sd5uqjVfhNStJBjy6U+zZLJlZLww34t?=
 =?us-ascii?Q?olyp3rn1Yt0V2+lbctatRK93XUmPDqN8V7NweVth25ebEhuEHc3c2elaBik8?=
 =?us-ascii?Q?gErO4Ph/IZbGfFLpAxmV5Mf1MGsG7xAXFcyRIKYJG4XafjdXOINSLIxIB4Z3?=
 =?us-ascii?Q?dKcyKelUEbOdRtvhDLX2C7tgS9OzeqKjNQuBJU1XE/tg0KD6kCBwQLn1SEtz?=
 =?us-ascii?Q?Rl76gS48fEGavRN4pVddZXt95ukiMnZK7ne9oGzHWyzZ1IpWWbD4Di5lw7MW?=
 =?us-ascii?Q?FH0kh7uLuPNJyl6P9yewrMTOE7762H4aSNwualzbOukdxxYgzYAL2g6EEGll?=
 =?us-ascii?Q?u6pbio2tYxUAkQoLZrHGPFH+B184R8VLKyatyg84uEaahJN41mSZJ+PFbNU6?=
 =?us-ascii?Q?Y+LOt1Mz/2W7/LQGNr52ibSAmSJMl4IEIJIrv+IzO5lKXHVoyRpkKnJC/P2V?=
 =?us-ascii?Q?+kjtTAHtYdlQpBqR+H00oJDsaORHg4T6E/VS0Kqgd9SH5197HBWEbyO7S/sF?=
 =?us-ascii?Q?A447ntERRp8XDDPF4NVEo1dBzq/VloZZf3I51VxURHrZ58oWKEEBTjCs5HhU?=
 =?us-ascii?Q?mLUI4b5Ids5IZbXhQAPmzmvVCNaCN4dp40YDQdXW0K7uu2rx3ZRugzHYi4Y3?=
 =?us-ascii?Q?GW2H0HwlZbGcXzfvWmjYq1PJyyTHkJ8HTgxxiS6DfOVoUw3VCJTv6d9YzDdV?=
 =?us-ascii?Q?IeEcIs0gMFcPT3JhA+KKYzoW5XxxDD+vyyYsb0LwgieFZLDuOgO94MlHG+Ht?=
 =?us-ascii?Q?gQABolVPX2wAAO87CKwNKR1AIpNGGP4KGqQ/tf2hYmkrymooUeIcV7MaB5Yr?=
 =?us-ascii?Q?x9UXHeRskq2GqQtXxeDFTpiTRp1D2FeYz05zizyDGrK+3rKt2qfYzWMXh+Bl?=
 =?us-ascii?Q?vAu/Gmnw1CXG2TfISOAKrynHF7FnWGOphWjkdYsCuLuhqmaQodimCYIWpYvx?=
 =?us-ascii?Q?LVIE+BH69oeFLQOcWVWTVy7mt8WDqqQGAtnfyQzHebyxZRrCvipa0VDEPnlR?=
 =?us-ascii?Q?Jh0HD9RYzQdT4+K1frcnEWcjyjxXPyRk6f14rR67hZOTYm1EX1+2SOUzgLvb?=
 =?us-ascii?Q?3z9B2i31AT6y00HjxPN1nslqRzxAwUQmKcjFeK9FWvHTWsNzPlC4vAItcaUC?=
 =?us-ascii?Q?Kqg1OX/0EOMmUNHiURVvNzML6nSfhe7g33KxPIvjZM+PV+54zlBo1NbObf3w?=
 =?us-ascii?Q?BAZzHTAkyi3Pdkuh0fpMXBQSXPkNliMLTrMSyOy3TnXydVxo/Asq+7zHQIkV?=
 =?us-ascii?Q?a9OXwmosEM36jdPKv+RbdK2Rr6O1T6aZSBaeFc6tE4KMl9kxVj3H7GOinpAn?=
 =?us-ascii?Q?fLvxVb1+ENuS4Ny/M8wHYGO6+jFTrj7kfsrRzEUf9mg62k52AwT90f2iD9PC?=
 =?us-ascii?Q?drZ+lk47VmMkUDR78ngFzNS4ET8FJ7qvYBnIWpUlbFWSZACqURiHLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:36:59.4190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e877df08-4bba-4926-8d64-08dd78e4ca30
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5347

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


