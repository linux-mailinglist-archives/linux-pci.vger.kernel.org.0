Return-Path: <linux-pci+bounces-25664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76DA85A27
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D854A0F45
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AC221292;
	Fri, 11 Apr 2025 10:37:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2138.outbound.protection.outlook.com [40.107.215.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7C204080;
	Fri, 11 Apr 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367829; cv=fail; b=E0BMfly79AisHhcW35MX2XNlbJptRSuZeUmcF33gxxyhgPEvIvPKQmiW5IkiXwmFGIqJa86q9Ax6WRrwKQi4T0QqEj85sn1nVAlDHU0OzM4EXN5D+q5a2HIxFuK2TOEGpjny2zDeH2DEuDpvKleGzKIMiwo3iF98cYd7jmORqaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367829; c=relaxed/simple;
	bh=e35KqtqoEshogus6kmWu6U+0Y0WSlVK63BTczF6Mc74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owCxtbNrZdId2xn1WPsPIcM0iHer5SaGu0i0EaNTmm1w61ScWoHk30VHBIFEg4LGQySyrIC+9haq12qZxzu7doFfe/vT07BGNXcTv2FFi1vx+i65Fap5QnI0KK5y9lA4wS0XzI1YrSyLWMSLP2yunT7MoKtlTVavuldQpIgDVUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IshLkd923tihuwD8Q5SrBwinVyYFRkmTGychJHtNC6AZDT08hs7aFsrjyjhxdvo9j6KazgAcvTNDROjWgE+1WgQtDj6RprsDDM7R8qZQaVicZT/j88WVCNU5pH3ZJO8g3ldsAaNL3/I5uI0owaRqMNq4iwJITM5uhZi0eeGuYvFDak86KOXVhcrzFHroW9AeGcPEGgjm+/XCOSVWtBVwpEOnuO8RxxHzNio24hjGnYeIK/+HY387On4a/ox9jsw4valyYeeD8xLxTwhxBldUVS1IFPM5tXcd1Dv7BvSyqlow16zCcNgvLPcAIPS1S3Dad9O8T3CZA8sPRzwBgYh49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUT7um8HuoTNivGWUNX2deh3iQ4MOn4em83eIgIlzqI=;
 b=Gy4aB3r4HR1uukobX9LuMOSg+xDshEBo9H3nqpk614VH+OiYBBKwx9OR5rITYJPH/DiZhHNLfCCWERS5OBHN8yjbxY/g/fikLhAtgaSdXdRBKDBEPRdAO0CSw0XgPU1AmpNQMq3XujFhcgJQFAFcRKZgw0qD1NKPfu9zA7WiQJIdMPrBaojqfiKXA7ZVHEtIod6H/YQ8uUNRxd4sXVZ/0fGmsQksb7f4fgFvOH1x2GZAEFwj9a0tIHi76DVSdhi8JyKHgKJhRH0OqSE/E3GSnj3fr4Ou+7v6vJ2hxRk/B7ZIlCHHD5wtDQoui8XDcn7hP4+ICz3jbG/Bx49/dsa+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::17) by KL1PR06MB5969.apcprd06.prod.outlook.com
 (2603:1096:820:ca::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Fri, 11 Apr
 2025 10:37:01 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:300:2d:cafe::df) by PS2PR01CA0005.outlook.office365.com
 (2603:1096:300:2d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 10:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 10:36:59 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4B2464160CA2;
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
Subject: [PATCH v3 2/6] dt-bindings: pci: cadence: Extend compatible for new EP configurations
Date: Fri, 11 Apr 2025 18:36:52 +0800
Message-ID: <20250411103656.2740517-3-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|KL1PR06MB5969:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 05c2b654-a4eb-4dde-53de-08dd78e4ca28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LPgPgIzT6G07JJUFlJ7GOmJ8q6LbYdy6nVVeVtiYFdlE6lDBe8WXgKJoR6mj?=
 =?us-ascii?Q?5gLj69ElU9phILjHb0w5F4132JH6gAtIZT5izIv/kk5V5I139r9RhCMsNglN?=
 =?us-ascii?Q?IzCAJ4ZIU/mQ4YXkZe+dDNBNMulEe+z+TfZck2c+pNI3mgVM9MDxuhTZ8BoV?=
 =?us-ascii?Q?nDHP+62+nMJlE9W3q7absKaXRoDXIE6A6LCaNnZI2HOKQoSjALcGVAxmZA3p?=
 =?us-ascii?Q?0usZn5JlMYjciI0nR7baWp/Xn4NLnV8BdeQYjwb+sVJfFN/5L11S44YerdHX?=
 =?us-ascii?Q?oz/6j1MIijI3I25mjqDaa1XxWj3EhVdcUY0uip8eN3kjORjJFxOr95GikpdZ?=
 =?us-ascii?Q?G3whYliXApC0kpQf9b9ZqTL7i1g7QljDqM9l+HKiE6W3QDazscEZQ6sy7pLv?=
 =?us-ascii?Q?G2AguNesPVlRG2o5/C6QrRyd4GgF7xhERSCbrh9L0lpsRgbHr9ScODSys6++?=
 =?us-ascii?Q?WZpxI3fv7kB91cYrou6AU/fTEYY7KOTCswmCdxFLgEnvaOULlNxOuKD8IIJs?=
 =?us-ascii?Q?8r1YSfgvI5p8A5Fc0pfe+TOYKl/SlSl7lAfpuEt8GteTY786elIgXy1Ipq35?=
 =?us-ascii?Q?f5j/n2Uno5ImLBLY6Bqck++f2vndStO3hp/1FKAuMGBpTl8jn/0IEIpy1bnI?=
 =?us-ascii?Q?+MATypuQPWLSFI1dEZ5Q56KOXioe2X2uFc0pvqL473bF4/GPsSH0FlyFhmsB?=
 =?us-ascii?Q?5paJBhgWwMtbb41/IWeyGa8FZGKY6imYGbV2TnuNugTqYIdkB+j9ZOb8N77i?=
 =?us-ascii?Q?opCZwMNWdm8QDJyGQ9YWZbl9WDBdkkgJ26Fkl/ZKbe+l690yLh4OeHhzXjOb?=
 =?us-ascii?Q?JrShAt6qenzYLjzXQgiVvsDvWE2gw21PTWJ42tVdPSmFjkIuIQGISqGPm/re?=
 =?us-ascii?Q?zEUBEYWYKsf9jOkPCcji/WjnPZfwSehM7yvHLnyv2e0CICXmrEBZjmPVZ/r0?=
 =?us-ascii?Q?jJSdYNRmOgkadMeSFMu8VwPLJoYpQb3aGWYDGDP8hyn+l+kVT2VmXHYWgEeS?=
 =?us-ascii?Q?Zp4tt97Khw1/1bLYzPTNzh7qxoMdf5MMFLrWcMs0njXmOh8NRgXqR2tA8Unn?=
 =?us-ascii?Q?AMfnn4lJn34G991EqNvmy+e6YU9gZSTVg7Zf8HqbAPaJ8Yk9FSXE3lTFUy4n?=
 =?us-ascii?Q?mCeU9UpNPNgyYD4ah9uVzn+FJprZcOl2NFTdKPpAXs/QEpkPrOlSs7UauPG/?=
 =?us-ascii?Q?u4DiSVUPXBGDWmW5P4H/zHaFlUrdPAkFHLkNYn3mdA425yZnHTxkRribH0BR?=
 =?us-ascii?Q?3TNeRcIcilOL1j/a9fd2kG9Duid92CHYL8Cpk5sva60cuGvpvYEu4QqVVFZA?=
 =?us-ascii?Q?bUjwbnT8atkzAzeKpW1G8dHQoGT1AznTenovkal5hvqdybFUkWsDvN6VYipc?=
 =?us-ascii?Q?f8JfPPHUmX5xHKwK1gV3UEzoi1Qcq4uKVn/ZuXBFLghWuFzlnfaN7bTpIGop?=
 =?us-ascii?Q?ivhZ8rV2Z4L5NpoULr6fI4f282j+vQbngrIlvrl0m/qajfDkOXpn1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:36:59.3651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c2b654-a4eb-4dde-53de-08dd78e4ca28
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5969

From: Manikandan K Pillai <mpillai@cadence.com>

Document the compatible property for the new generation(architecture) PCIe
EP configuration.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index 98651ab22103..a7e404e4f690 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence PCIe EP Controller
 
 maintainers:
-  - Tom Joseph <tjoseph@cadence.com>
+  - Manikandan K Pillai <mpillai@cadence.com>
 
 allOf:
   - $ref: cdns-pcie-ep.yaml#
 
 properties:
   compatible:
-    const: cdns,cdns-pcie-ep
+    enum:
+      - cdns,cdns-pcie-ep
+      - cdns,cdns-pcie-hpa-ep
 
   reg:
     maxItems: 2
-- 
2.47.1


