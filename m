Return-Path: <linux-pci+bounces-15171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378E9ADD1F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867ED1F2355D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8B819E97B;
	Thu, 24 Oct 2024 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qq6LevBo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1AC19D065;
	Thu, 24 Oct 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753736; cv=fail; b=WrZyORDIOQQo0OZncv2W1USS1z79xBEeb19mxigtKbZoLhgYwpZd6awLhZ/N1BBsPSwfV7tOlRRUVcqXL/LfDpuouGRZz6cBOrXY99MHfGIHkpKQUQ9NRL/NLmH85VAQUd94dB4wCaYJqDzewYPAwkue1rs3uSwWnQNKoAObDnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753736; c=relaxed/simple;
	bh=mePkwdqAkNlSYtpf314OfkDrdqJFxy9A9IR3aZ+GdLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EcyL8saJxgI5QyoieBz32zF/C0qYmbgw0V8Vy5G+6nONStnuzC8zMODgA6FU5x4vCQl1qGpX3SLkczVCF4tSzdKMg8mZrjf/DPZBB/jDaX1acUcrPoFpTpuiq3Nvi77UZpFpGpLCZOF2s1qayIR2S4twNYCXXr4MmmdKlt+T+Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qq6LevBo; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZybC1NcNEo2T/tf8mOAkOgJvWg76S+nu0JaDKwIzwQQjnND8/t4ZXApKorq+wOuH4Sz5yHItmtlGENvWJ2LSqhBEs/1FQUe5NHfhDOeEZAo9176m0ETBzbAyNJEYBWyLQxAG6SdU165IHuhhh9nzmTzIupsLeENO0ZRkmuLyrHOMmZFEI5KEaMJAGixeJO91dKIKDW+fJaBCrgb1RU6Sdw/eU/q4A4ZD/u68XzJd78RWsjVouFObmkmetUv9hW4v7+9dIGP37o2wLs/Ej0pDMLPQo54GBGEIRHbJOvc5MnZeq+xO6/dWFNWF2dcEDAnO+9xVehECaTeUZjDcLptX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgJAyoAgCjGd9NIHYHQdV6kRh5/lgtyzhpXP0g0Lqug=;
 b=ByKRwDlYyB4x87OsOvqbKemGprDbYLkX9SJG0Xl6gfSC/5nphlyebE2opXlnr+QpRqe5XK2FPjD9WctIC8TkFmmwulV7gebzJOzxx3AkM8uQrlzFOBft+pWDxwNEXFbWlU256Zrw8JsD/ySpvOX+i4Mt6xHXBvC/vePsyV5YemeDz3B8MUJ+FpQkpUgoMveuxEjxUGk7NImoqgAmCEPX8wHFnS88Ag3i9tHCoDDUXs+3a4B7zLBVQyq9fv8DsDJUGC9K2srwUuYXdQ91NIMCkC2NLOFAeyr5M3e7qX3TQNRkDte00fQFAyVPciwsfUUhR5y6hLshYoWIVORfTYd7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgJAyoAgCjGd9NIHYHQdV6kRh5/lgtyzhpXP0g0Lqug=;
 b=Qq6LevBo60i2iKQHM35ZGY7wyYtIjbql9B/KDKyMGw9MJEmop6+klo0kKjBZ5gKT7K2Nki2IoJHoKFH09YAzsKyxbd0gHu4RCeb6FZzunmeEhL484pjWI+w1Ef++WCb++mcaXdXUgdMC9tKcDSz07R1tYxYZmA8a7oj/BJPAerPqtiAhlGzJDMiX8Vomq6Ksom/qEjtvchLCkTN3IRSndgDDoZmRd8bb6NqP/IlA/Y1R1lopIKT+3/xdsDowtnLS5zYFX9fKVVxjwuN7Ew9Xp5x8l09mEZT2pvRhx5HaZ7yjEea3TCduoVRnCug7g7/dmXHLFs81XzWt0A1XJ+XZ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 07:08:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:08:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v5 net-next 02/13] dt-bindings: net: add i.MX95 ENETC support
Date: Thu, 24 Oct 2024 14:53:17 +0800
Message-Id: <20241024065328.521518-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d4eaf7-1650-411a-7839-08dcf3fab657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddv6lxc0x1liESdCJhAgHxbl5Kf6WjSs1c3BG9cS4OhR5adgiJ3GYlrtq1gL?=
 =?us-ascii?Q?px3x2O6x79UUq+mW5yiqWLK5hLd6htY8VsDSw6ZgdSBg546nnNizFfJE++QX?=
 =?us-ascii?Q?y+iLTpvM8u4fuPocsADHSykeVNlNVg0gV90bhtm5eRYmAOu9u/ia0kComia3?=
 =?us-ascii?Q?3pG8C5M8vy2v6sI/uqGPTBn+BuF7qhDQ6cKbwFPn138Gy+J6FaRkClW5d4SU?=
 =?us-ascii?Q?5oKZX39CfGg2tFB3Bd33n0PnLQDgEpKnvCtnI5Z3mrKzgKbxllmSGOZHQMwQ?=
 =?us-ascii?Q?ti148uTECT7m1pJZhtf8wRIvDhdBGa/ZYRmCcG8WT92xR1U0K66eNIWSoAGn?=
 =?us-ascii?Q?4V4cYjumkDQxYchIlmMRaII8MAxLGEq/FLBPE12FTvjyd6Tws1o5fRXlThw9?=
 =?us-ascii?Q?EcHMrsuAkiBnJibQXj3yH1HeBbVaLbJkCswM9IgcvYCPd4UsFIXXwMleWThQ?=
 =?us-ascii?Q?UfL4jVzRre1J+SoQTCIuIr3/47pZ2hiTKwd3zyGZxhEVs7kZOkJnrWJTL5pu?=
 =?us-ascii?Q?67YVshZxsYrAnbta6RD1mPMt+X2zPv/vI3F80fejbWfvp10CQdbTj3N73u4N?=
 =?us-ascii?Q?GhrbihWLPFci+kT0bP28tvO8VAi+HbcTt1ulZcKqHwKtbTij7kBBmdEKPYYo?=
 =?us-ascii?Q?UIeyJP4hgOhXFDj49bRzrmAa1kMQ5KBbx0Le/qpefL6anbuGPcy99KBfuT8L?=
 =?us-ascii?Q?jitQSIfwpcj0Nc76I3YsWW2/RAxBoTxbj6WlV8R3WwhuvhTUVXz8YzCdmaQW?=
 =?us-ascii?Q?NkgGT2nC7PAXqj+mW1kxNNNE7oRZtHjaxV1gKpj2AgYfQ68Eg9TrehtgLKWy?=
 =?us-ascii?Q?QVnREQpq+2vWLBUmCWbAh0LqTPj4ByWj0lRlgnT8L64d/xcxF77W0G02IvX/?=
 =?us-ascii?Q?ALX3/t4x29EcQP7cnIGFqt0vy0x7giNJQoCLfA+Jtj2ahCFh/0Eg+uo1RiqD?=
 =?us-ascii?Q?+ApQ/V8A9zq52OpkrVUllrESobae7Qvv8vTd3A3Y65sPa2Fc3BSu+DhCHT/2?=
 =?us-ascii?Q?dE3jSDwMdxyi04Po9MQuuiQHsq23xwOTJ7koGZ+MRAf8MwkcGoUa+78lMsHu?=
 =?us-ascii?Q?FGyxSVZtPDzpRYaW4BVYhZdEEIqtlL/rGpF+ThKDI1+OxqXmxNPgVnM0hlAK?=
 =?us-ascii?Q?vLXG3tECP0mZEk7tfZydIAF2Y4+nZ0n784IMjOwBe8JFoKTJ7hhUSgFuQgRK?=
 =?us-ascii?Q?N6dOzBilUzL+1k5XvyzjKNuISUNLRA4eD2jIEv2EvFHFnNDC7c61MAxwc+Xz?=
 =?us-ascii?Q?koDh69Q7tF8ESvLeuEEyS9zNLzBgoikHunj9N5ZvtmWsTTTrosa6j0S+c0aD?=
 =?us-ascii?Q?t/p5hjecAij2+G340YOVBI/AYlLVkEEjCUG4ZLxz5rmtn9I+S6b/YvsluWTr?=
 =?us-ascii?Q?myYhQSRkuhU17nh68PVIEL06HPUB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tE8mEGhSclS43Vdn+A3Ht47JHqOYnb/SnGADqMpjblB75oeMku8Sx09zvfX4?=
 =?us-ascii?Q?7l3PUvIYKBfb2huHdFTlFMgpKwzUrPTCKBuGRYWMVgnBWC3kInDlQZOpZ+78?=
 =?us-ascii?Q?doRaeNXQbD94OSlRfFI2udA9Jf9wmjPgwhu2PfuIGShS3ImThKuinX7txJLt?=
 =?us-ascii?Q?uBuUl3Spk7dOM6FFineS1FmNE3Y0XPgxCyid1eKtJYwrROORWvp6OsjmTMYA?=
 =?us-ascii?Q?CAFY0epmEoUuJ4qt9vPGOr930Fi6Qmu8CqutIfMVNk2qkfKMyYpN6JcpAmyc?=
 =?us-ascii?Q?1Ljev2K3T7RJEuUvtVRD80BoRrveGKVwneUoLsDQXSzoz20W/nBU2vMM2ivq?=
 =?us-ascii?Q?IYwV3mwe5aX+e83PRjixDUbxtHNjAAen64JwlDmVEyXUM4aD+Xhb/4ac8cpO?=
 =?us-ascii?Q?6S3cVuORSGo3GWvM+uC6rscH2KwM0K2fcrQb9GPq+ceqg2v8PUhxOLJlOrVR?=
 =?us-ascii?Q?dRQQtCMocJEgfjobAfeYE6nqtzDrtr1w9woycF71J9QUK3cHG5hcFa3TVjuV?=
 =?us-ascii?Q?RnRlfBGbGOIJvKhdXM9WkGnIQJjf6bIZ6hXociS+3+bl9aESc08eM3+/IUu2?=
 =?us-ascii?Q?ecOfWtVRRsiMGDMQrnNIpH0twl/RpSbWhpH901XWGGJfwY2K1/QRNS+qf9HN?=
 =?us-ascii?Q?iU11q/KnUBU2JA1uiFoDd/uahyHDX+nXZ0LSO8JxKLq5o48n9ki58XJKVzez?=
 =?us-ascii?Q?YBJawDRJ5NF6BBFrZDJp8DFLRw21cf5TSw12qqdflbdjFik8dXAUhdS7hyJt?=
 =?us-ascii?Q?HnWUd3qTplQE5zaNv/ru5arG0SxBWPc7ShCvPBdkGVw5Lu8nUZl1a1yzgMzA?=
 =?us-ascii?Q?B2xnvVgjhvXTLiJe/Opc8dh+q1611jgqnw2KA7okmIKN1oXheizHCu3Z6ic0?=
 =?us-ascii?Q?rxSxhyM/etLXmQ/7H5pooT/DOwTMcdejrpUbXhouI1/BjURlXXUHxE+vBPsK?=
 =?us-ascii?Q?YYO2nTrh3tfw8cmVcCMQws1wyA3iAERR5MdGNDVCkTUDPINb5yWcotauu4l/?=
 =?us-ascii?Q?Epnxlsx5Tb6LPUdeBqJsXO6KjCHsOOuQaBeWi6lNUyn2Mi3pYAwr3Iwyj5ey?=
 =?us-ascii?Q?jpyhrCBFALxzzbvJN/oXnReMrAQTzYoNfoZ5Vv+tgAeKX7tfextinMZpSaN1?=
 =?us-ascii?Q?SC5YVRxaJy0buU9DfBOSpJG+S/muqYGEHllE7twJsp8mCXSLf7HSPAnXrjQE?=
 =?us-ascii?Q?TE9PFqNNAi+PterVZpWqHDHTDmBR6ZMwHctmxQVQlOTQD1anjeQlsrC+k8Vx?=
 =?us-ascii?Q?HGL/nBiExs2RMvl0DR6e95Hoe/vEF58pHaW6OWEliwp9FeGHWneUx3yMe7S6?=
 =?us-ascii?Q?q3ZnQb31byVvwUZ3Q/a5IoXjgeQWNjsaFFe5bssVrJL0gQLs0CrQ4t2aQgUo?=
 =?us-ascii?Q?gJwKEICyJdz/CRcdM2/aCodkImh9sn1tJRX2MgSnO18XM93Xb3g537zIV59Q?=
 =?us-ascii?Q?aCZMDEjx5C6dPE5bt6z4ZSUI8rlffuRCjOt2CLOOut8BKyLhERKYik6qbQWZ?=
 =?us-ascii?Q?32EJ49SrhDJTHipyvKZ6a0tTk/NYlxRA/asnSwJnFf55LQM+PN+GSV1foL2e?=
 =?us-ascii?Q?/tSe5npp5kYxAbiDZDbUCdmI1ma5S2nc1toaGQDt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d4eaf7-1650-411a-7839-08dcf3fab657
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:08:50.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0R19FCmZnjXvq364LzTefitNZXEKH0Bb7CLQy+qeIJy8iw2wG56EZGZ0Hjxk/lHsEIvxyQD/dcR4m47pawFGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
or RMII reference clock.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2: Remove "nxp,imx95-enetc" compatible string.
v3:
1. Add restriction to "clcoks" and "clock-names" properties and rename
the clock, also remove the items from these two properties.
2. Remove unnecessary items for "pci1131,e101" compatible string.
v4: Move clocks and clock-names to top level.
v5: Add items to clocks and clock-names
---
 .../devicetree/bindings/net/fsl,enetc.yaml    | 34 +++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index e152c93998fe..72d2d5d285cd 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -20,14 +20,23 @@ maintainers:
 
 properties:
   compatible:
-    items:
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,e100
+          - const: fsl,enetc
       - enum:
-          - pci1957,e100
-      - const: fsl,enetc
+          - pci1131,e101
 
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
   mdio:
     $ref: mdio.yaml
     unevaluatedProperties: false
@@ -40,6 +49,25 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-device.yaml
   - $ref: ethernet-controller.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pci1131,e101
+    then:
+      properties:
+        clocks:
+          items:
+            - description: MAC transmit/receiver reference clock
+
+        clock-names:
+          items:
+            - const: ref
+    else:
+      properties:
+        clocks: false
+        clock-names: false
 
 unevaluatedProperties: false
 
-- 
2.34.1


