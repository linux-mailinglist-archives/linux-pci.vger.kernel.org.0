Return-Path: <linux-pci+bounces-31035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E181AED340
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598D63A52A6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C31A3172;
	Mon, 30 Jun 2025 04:16:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022139.outbound.protection.outlook.com [52.101.126.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B4D198851;
	Mon, 30 Jun 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256975; cv=fail; b=r3TeGOKWSOIa+ovbBJJrlEs39Si8KUQJ4NQbJKT6OU4vYwklaZusvNxjppewiksV1TxZ0HH1IxPYb6SrQ4AI/Oy/L0z8G2Nk/GTt92G5peGi2I7XNLJWcCFJV/jnssi6wF+y0rBOSLvS2kON0jTHGRjXOwpp+nUl17fAGBfS8Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256975; c=relaxed/simple;
	bh=JO8oH08uUYFuMgGztVfW64NruI0ZGziJLxCPC8mEIRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=io9vaR1iKhWSxkLbwP6uhhZTanSuzZOJ2C8FnfUxUD9VOuDXd3Nm5Fxvmi7JgsBUls7eExVLdiS2Q9E1nRLbQNNQBhD9oCSurtaFKisAIt8jtepUAIGUi8BhLZZIyvcEy4qmNPUi16cqX+ihJK3o5ECaVN/Sqq29KbZ14LuZUDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzeM4fGKCC0I3QIEMwtDeU9KEHVA5+BIKY7EyKjBW3L6px5HuhdEaJa/nHZGsIelvqHyhX6v4GdU7i7YkbX8tzognWp9q+tZXg2g0faiLrUQA6aiPib+qk7uIErxKLdqSL0HSNearX9PUg5PnqK10VEU0+kwdLBkObYVlizsnCp2YjUGOGBoL3nfd2qmpJRqdhOCUXykFTf1F/CVKGh1EE5KVrIbNw5ZGvKwcfxBu3tKB4dqauBEZRJxsc2dkuLUiqpGBDcaRNiBXS/nbL8ix9DuplTIzL7Qw6TN1DKUtSs/6DV7v6KtklEyVnHHhKQsTC10y9H8PAqIaZVYh9aWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3XqRBTOcsoIFAso8NI+mFvpvV8Xo2qaI4p2NTiEjyE=;
 b=cm7lYTYzb4RSWxfVjXZQFo+HyW+AWK8vEq2wf4PZEDN4V4VbHvgzlFJx6vSkAiMRxb2K0Y4FeQD09W3TwzBE2IUKw59BD+K1ibmc7H2TFV81Vo/q3ksxMLgdPB8sTwAO42Ee1eCXYprY1CwmQx0jqyZHZmtiSqyusbgO33w8UqaXJnhAF1B2HLop5+2FYFz4uGJSJ2OvOkxs20/eRwAmJWSgUyY0YQ3KifzJZRrAkg9IRltnUw3kUtRD1RtaXQ/pfl6WZyHo8fMoBrADsLCD67x8S0ISnvnm41YrZz33BChXIHmsbUo+8Xm2XjotM2SNIcYOpxus3NbKuZ0Vai2WEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::23) by
 KL1PR06MB6092.apcprd06.prod.outlook.com (2603:1096:820:d6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 04:16:08 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:190:cafe::e8) by SI2P153CA0032.outlook.office365.com
 (2603:1096:4:190::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.5 via Frontend Transport; Mon,
 30 Jun 2025 04:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 66AA444C3CB6;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/14] dt-bindings: pci: cadence: Extend compatible for new RP configuration
Date: Mon, 30 Jun 2025 12:15:48 +0800
Message-ID: <20250630041601.399921-2-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|KL1PR06MB6092:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d67b9337-039c-427f-1329-08ddb78cd649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WRoyLEHftKpLWOEo0E7U+8Wmc2BELL4TVsnAEEEDheES/Z24glRXhoJnuULJ?=
 =?us-ascii?Q?KnK5ch+we+kgOxBHiNl6oVejrki/Ij55KcXWwSwg42czJ1vdHaxRWV65Bmk1?=
 =?us-ascii?Q?YXOG3JZIgqbuKjJnh1Gg9dQH7Vra6ZByl5bU1kcbrEMUdK8bQnKxtbSMZSkF?=
 =?us-ascii?Q?M5KmG2S6qurLACbinvFEXedEOXIYZag6HUs3XVQWE4tAbRnobv1mWE+m27mM?=
 =?us-ascii?Q?5RtobsMOjoJU4wmfksE1VoPf7LIjIvC/cr9hwgHUzmTpgrHkO/xcggNPc3ZF?=
 =?us-ascii?Q?O+/k1ivlN6jvxwkTRgdN/a259qr+DOf8v37ybB/Yc+BZimfZx+TI257rIWWU?=
 =?us-ascii?Q?63KBVF4IEAHRsIZmnWo5lnzP6OAOWMJnEJQau4v2IA4txmpNCH17F+79syOz?=
 =?us-ascii?Q?L4IegQO2lf3wEJpRGL1F8A6bukKcQQNTVBwucCokcttMeoTEw6mLtqDPy7Bh?=
 =?us-ascii?Q?dINyF6lfeny1T3HOjFApxlNSVyWAoKTYeJNocUnCyjtoU5NiVjA2ggwKDA80?=
 =?us-ascii?Q?hTDC+M5aRkGaUCdYMRtX+3+hS215lcX5s5herhZtV5Lvmc4KLD6lqkxSFLpe?=
 =?us-ascii?Q?DUY8myhxJtyF9/LmDYRftAhD+Kf9aQJWn48vQO7aubMFhKv+zhmy+P6RJXJx?=
 =?us-ascii?Q?HrgbN4YVqHjBb8oaNmlftnO1ltPqY/5SAZlYHdYnHmck+X8SN7v88KAsSheO?=
 =?us-ascii?Q?Z5UfVfDhE6+ZafPD8TNwGOvQUeOZ4XVSU7IoxiluX98HgeBgaFVw8sfRHVn0?=
 =?us-ascii?Q?vNQRgA1PAMOsIlOY8NklGPuzqLlCfa860OnPhO3m+CoRCpcIyJpHfa3tHl8A?=
 =?us-ascii?Q?oe4kQIXEvVkgLBWWDIwmVO1RbBnXqoK69WcMSwXYq5baXZ4TspBfSkmBU3eL?=
 =?us-ascii?Q?rjT7QV6UwFjIFFjp4NldR3IxNpWjvJZwv81jRFHED6TusMkTy9IKMVwy9mw6?=
 =?us-ascii?Q?5/5Uno3DgLp8Xiq9fZVznnTsCxadaiKRblpeJgBPoBqJNDOAiSVs525cKe3m?=
 =?us-ascii?Q?Tjn4zjWYcTziGiZgPIN4ncdYakgOfUDtG0w8WZbdoJZHSgtwxstLQZCaQ5X9?=
 =?us-ascii?Q?Q4awde+VD0/Wdyh/GD9cNuqhnrPPAeJ7FNokRY4AD4PO4wWPChWuwbI3uOXF?=
 =?us-ascii?Q?WAFuUR3hxPF5qmAxLd4564C2uq1CIiC0MCZggY8fAvDS5EBS/hFEKICjrtL9?=
 =?us-ascii?Q?OlxSb5cjauJfCa2KDESp9IE5EvR9ShamNlu/yBOIW92JHU/E1ipV+PLT4hkZ?=
 =?us-ascii?Q?W7EJ19oXbzPyZ+jlXSgYqPK6IWupsJ0Tl7mqXyvpaEdP7rwImuLtKhLrY8Nm?=
 =?us-ascii?Q?rHgHyIfPAZzGGL7EvfDACgwF5wzQJBre+k1R7yXitvPJbrxijrs5kPNxT6Xc?=
 =?us-ascii?Q?th+Y8bTV5uNr4GdOiFpvmjyh/er95f1EPMlLitEJzJAAeMOrRht0i+L7VQae?=
 =?us-ascii?Q?nWKFo3mTw/ARYLOCr0KUys1AhLThyIY3zNI0z+NyQqWYP4e+ZIKpGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:07.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67b9337-039c-427f-1329-08ddb78cd649
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6092

From: Manikandan K Pillai <mpillai@cadence.com>

Document the compatible property for HPA (High Performance Architecture)
PCIe controller RP configuration.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
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
2.49.0


