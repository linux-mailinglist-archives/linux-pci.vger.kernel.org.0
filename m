Return-Path: <linux-pci+bounces-14738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D929F9A1C4A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E941F24C7F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B31D2F73;
	Thu, 17 Oct 2024 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lexsofnl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375551D2B0D;
	Thu, 17 Oct 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152110; cv=fail; b=OFmJHFlJVmodvp+OQK3oZObEQn0c7c67lz9mtMQ9ArYVgHsZGiXJjSytg24xaNnuvbaR//l2RNrK90+yAGiQMed/0LUwpUf8nv7nIKl6l82vw/dJ9jHjmFUCIbMJqbwz9+/zkdAubru5dJ0iALkA10P9uZM9muyE5Icnpyx45P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152110; c=relaxed/simple;
	bh=U8mIRjLLo/SidCdLK/en72QCtrv9iigGqTyAZCP6n0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWnKvojCPo7Wy2Pk9omoD0oJ4SmhlMkkRo8l710CnnYxJSkXMaRIx6ASU5+c0lfScMWqfAVI1LMMmdW+5D7Y4iPbBwZVN997/htvrEu3j/Ggv6ByzsyHVnE0N+7mGpuFNZ2XDycUokBbJI6Mu3FFjZ3JS5zAM2ywNM8GsyC+a8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lexsofnl; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5BJFJN02gCT+sSxta4FYOrpCDazj4PI+MPplPrZq7lDSvpgYMA4EHPBnXz7JPKac7VLrKYzAxNpTpmLJe7ITPgBwkAcasooNhyEBBWbxT+qH0TDDdJLKCtT8QGC2TjAznGuGyJibFOjTJwms+u22jX/EJIJ37lVoRmp//2rLRs/8Ef3MSoNcFRtXNlz3diWebdqE59I1PI7HLbpeBRRvrvhfmJCTmyI9ZV+DyAbBFlMalhVZxFZ48RKErakUbIAMP/YADqO+B7x3+lgZizCITsiYtx1HAWmIkNTaDJCppjHZRCATPk99EC9KZvCrFvjMuA2i6l2XFzSYQah94MmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgmWLasc/x8D9mV9MYRct+igiNRpL0P0dcY8ICjUkdk=;
 b=B/Ua4wdHLar5VejAYPXKwM+IcT0471mP3hqiX7SsgkO/AfARf+37N3veJukdS54Su3LvAKK0920nlYrxtUpbLwLRN85fDXf/X/Ka645stzHXzBdaxZl+OI805NcBn2zb/K0zqvJvelTuAEQqx8twYqMScBXju0BmQtOIKeuzqbKOA/PK4r+wWsqXkXp/vX+x/tCH14vTf2giR2UW7Ulgche3hOOuZxGAff34mShAdG4tmvb9cta+OPUWdZrf91safhrGtqXPItBA0hWgXrA9+qXmSarJffh+tYbgeJ+OSF0+t49mM50AOAF7UT1LAp/V2GXu9P9YZTGt6GBa0zvtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgmWLasc/x8D9mV9MYRct+igiNRpL0P0dcY8ICjUkdk=;
 b=lexsofnlrRMfjBg/FpDOeQdCaMeeNRyjEzq9ZKdrV4Z/XWNc1yt+iWAUq4Ya6N+q2j8vscjAJgjpgIV7kZi32GHp7W822IeqyVfBA4zyA/GHX4vliI4XIu52G9pkIJapccbkiP81B6oX5T2nGIGdTEz7bheYwomSIB1V9b3znd3ZaaTRZ/cxSxN7DzguWzUU2/QD9Ln9bSK9tMZ0jNCQog2LSeC4Urg9H0cYD6+Y+9t48ToI9WBeJFHJzzQg48vzAqC2DqYlYlNOEvHEmDFQZs7Ez9JjTDglDF3xjzTqCDDuOP3sHzIBQjIcEFpFQatYGvvCIuNiWcInGBZJde+y+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:01:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:01:43 +0000
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
	linux-pci@vger.kernel.org
Subject: [PATCH v3 net-next 01/13] dt-bindings: net: add compatible string for i.MX95 EMDIO
Date: Thu, 17 Oct 2024 15:46:25 +0800
Message-Id: <20241017074637.1265584-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017074637.1265584-1-wei.fang@nxp.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: df6cb4a3-b819-47cd-0aa9-08dcee81f03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mjs+zUX6eDPHMmEm/TZVJw3LIpXvXB+PoAVqF6DwqjMEDtrhOcTSdy8rZYkP?=
 =?us-ascii?Q?VYHDXbDKyUfFwU3kVLGJJuPZLXS2ywDqJvumua1twkjTiowaD4sAcASWNM6n?=
 =?us-ascii?Q?5KdiTLRXF/RJQun0ALOaaYeIy6yZfVqX2+jIP1QuUlvQb1Mnuu5wkRl0DgoP?=
 =?us-ascii?Q?3AIdi2b4sUy7rTMVfPqLqCEqZqpQSJbHR+gnhCsddjma+03ehcTQ2lNzJ+Vx?=
 =?us-ascii?Q?7ccLCbxcfPbitpnAKS5bPBA27eNbtNpp2phdUBk0dK39Hpw6siwPCYdsJrQe?=
 =?us-ascii?Q?x4wZgP/YdMBASEh27mFxgxPSog5F6QjXk9MLKAv7SHdxz/BVL2AoQ1twCZnG?=
 =?us-ascii?Q?qwOax2CfnyJ+YAL/9U3fig8kXhYgU7u2Wme6cDmfqyBlm/YWtOqb5rWe4cKC?=
 =?us-ascii?Q?hGVMyh/Gqb8pK1hvZViZUN7VUeaM48yafFLZAjvGoZRJX+f/97rsY6OxJN3Y?=
 =?us-ascii?Q?BTbL1zveJ+lzLUuSdwkI87ImruT37fUMUZ0DkX6ag39WFF4cLOIJhwztLL7E?=
 =?us-ascii?Q?t+LCIBHMTplhncH5cdQGAOcoaRBnQIv+zDvJwAKpAQfkzwsX5RACfafQh2cV?=
 =?us-ascii?Q?nZptyw3A5nP2xs5XbUgV1mOoZ17rW+rAC9KxTmYpsN6kDqK7UhJX32KlNrN5?=
 =?us-ascii?Q?Nne6+AIy9x9WajJGXUz5VEVgBym+RDU6CiPRmlfniK0v34SwwZsaCjvowd1u?=
 =?us-ascii?Q?5F2QS9JlUYh6AJHWkwkcHvwxfGkoO75ngpBHMQXtjMODS8JE+eGOnIw634uB?=
 =?us-ascii?Q?eEqREZK4IcY8dmrgyEmuAmOTqaZ+Lk9ae/TxDEJ+p0iVeO8TPBVnJhnYOykM?=
 =?us-ascii?Q?3VwQXWTz83DXzSA68Ixhz9q4XIojA3TYDJaudD3SIZMH1bOIHgtbq7HLXLuR?=
 =?us-ascii?Q?/ji5GZlTW2qOQTrLY8Cli0n2tBQuNXZYqabTCwaiIL64uKUMP52RBYkobfVU?=
 =?us-ascii?Q?nc4D774Bbed7Rrgf5vyd11NF5ulzjB4AxRRnjgrKHsrJ24+fQp5nEcEr4T3Z?=
 =?us-ascii?Q?nCImn567z+e7z1Gq+fVAKW1lQVuDS+1iAf8OumzEQgxN2zLZnIrEL3G7cEnZ?=
 =?us-ascii?Q?flN8yk7Ak1I3lDzlB1hqQJ29Ix0P4R4xSBnaoRZgWC18B4WQYKjnbR7mCkr2?=
 =?us-ascii?Q?OaHnWumRbUCELwtLlwB/YdnkEUiF28TsohsucVXx6lZ8QsBPjl+HznSKGuB6?=
 =?us-ascii?Q?fnyPM4Wovsiv7+ELq772YFIyuv5+YcHEntZTT87wF2E0iU/GbMHKNdKDZSMb?=
 =?us-ascii?Q?uSj2oLEBo6EJnxpoPCZmKctO3Zuk2tZX/WjBp8J2KKUl8fSjAEb4I+GQEM3I?=
 =?us-ascii?Q?AQUfjiZLUKGjQBWmpMjIhwWmhevqtdX/rk+DJ9kGvYZZxQViRsAN7NXj3603?=
 =?us-ascii?Q?/K6PEka+fmqFO9roY8gR8Q8XgzVa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+iEfBk+m+CGcjuN3KWF92USQ75d5crAhRqqXQ0FsM5mdTKLtvKpRfwl48Nmh?=
 =?us-ascii?Q?5rTAGQVQ2zzc9pPSYfkQ8sbAAHKMXasnOuTzcq09LUyLc07JIgsLrwxidEMW?=
 =?us-ascii?Q?4cNTwtEAG7RYzIPAAMYpQQDh9x294JVLul9VOpALrpqw5XRrmvEkNk0Gx2Kp?=
 =?us-ascii?Q?QK6kkSnO1LzS2Ldigi/Osy4mSEWuu1dqCTTE16TSQJC2aat1TxPP5/lMn0Nq?=
 =?us-ascii?Q?QZbMQMXk5yX3FOXeesAoPLwk513F5b7EmvKf2Uf4iVRiE7OIZXsLX+QqlnPn?=
 =?us-ascii?Q?Q9GAQyluu+WS/tLcnW3ccX2rQMtMOhJLkI6w3P+UTpTz7OGJveu9S6S3SqPl?=
 =?us-ascii?Q?1YkqWrSKG9z/rcsi7r6hFgJBTKBdQhLPBNGAP9NKKyk3E1+4xxcoQmGsT2NE?=
 =?us-ascii?Q?EwnLD9Y0ppDE6UrqwCMDilpkBBGocfjX1MKOYDU5F2OV+9QkBSirIqai6QDH?=
 =?us-ascii?Q?5v0r3MoNOra7y0KwsdW+P+9NcImUtcW61Qhy1vZIvzAU+qpEYdIqcvXd3kTr?=
 =?us-ascii?Q?yCRDy7+lA5D9PaJdTPyfO5Y5FqV/QPW0USgPDY31XsYdHBLLLaEIjKQnponf?=
 =?us-ascii?Q?UyRcAPn9YvhERadRH5MBAETvs29fwnUhMI5zv8Vwubs5nTAELXreYf5thgBk?=
 =?us-ascii?Q?sHzUlh568Yywg0o02TOMbGhcczHL6IK7p/iWVfP1EQ7dqkFtKZPQ5oqsLH6F?=
 =?us-ascii?Q?0JEQ1H7bTGgEP1UyioT2JaqmByhPjC1B7rlYdXgw+Ea0bwAgbImpdhG71eEu?=
 =?us-ascii?Q?1LNZEWCLQBS4CwGeB+fy7q6jRFi5AG53SC+ML6j9p9xJHU76plH/ToYIaLm3?=
 =?us-ascii?Q?vzkaxq2q0ExgEtI0NjygPrz7OUH1+aqskWoXtOGiD9WBUgST8ClW6UIi0z6U?=
 =?us-ascii?Q?fgTw56ypV9JWlww0gWasMzgu7recd4vWCO+zVztkDtxIFfUDa41X3VyQLMi+?=
 =?us-ascii?Q?3sG9Y+x6UBu8HdN6c1gdKpV8I2olnawWjHgoUWGZsXqS9jYx44POM9LFQmdi?=
 =?us-ascii?Q?MhlTHhM1x/xa77fF4FFPn5boq0lU4ChteF7ChdPMQWSq78A/2zQTPNcT2C3G?=
 =?us-ascii?Q?oTAXc1auqkyl4mMUU+k0CAf64ZVZe59fP2DJgS+VJFPU9UR8OrR/n3BZkg44?=
 =?us-ascii?Q?HaSJF+xsvWRFYT22Ymkcx5F4mkjLK5WcqLKGTPgqIJFZObQvybcnLRpD1cld?=
 =?us-ascii?Q?P2OEWR46f1RDtIh+49jmYImoQZdXo9B6ttISYb6X8Weoz3sdV3RpYsi7t0NH?=
 =?us-ascii?Q?ExkKledR7XP2sHsQ/oo9b+QFsLRjneifBQnaTqCYeetSlUdQIA2GXIkqDKsO?=
 =?us-ascii?Q?eGRTArdAMkr0Hw9C8/g405gMRnllorRZnbQwME0Iu04+e0szB6LD5kDuy2r/?=
 =?us-ascii?Q?8lPvcdN0OioTeTnVByxfGzW/8I7BnZPgjgYtxZU9kQTfnM+YVQC8mWHc1S+B?=
 =?us-ascii?Q?gIDsHlKRA0CjLkdYSOOtnreIXIax2RI/BL7l8JjC0xAElhb4v72i1qHVLkjB?=
 =?us-ascii?Q?eO+xBHcwzqCuXaYFifE7Hx5aSEzK3VuZZZt6JIkbvgLvZxPEFmuK1pzwO6K8?=
 =?us-ascii?Q?o4qS6L7OcVwYQ5SMviFyVfkkn/dhef6o+RT9ds9J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6cb4a3-b819-47cd-0aa9-08dcee81f03d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:01:43.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQMjaOjUBphSZf117qajflRWiwWiRQVfcclhwo7XCtJbTFPBBw81rIm6kXNdm7Nx1lBCNs7+tfg0omdLZqXUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v2: remove "nxp,netc-emdio" compatible string.
v3: no changes
---
 .../devicetree/bindings/net/fsl,enetc-mdio.yaml       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
index c1dd6aa04321..71c43ece8295 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
@@ -20,10 +20,13 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - pci1957,ee01
-      - const: fsl,enetc-mdio
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,ee01
+          - const: fsl,enetc-mdio
+      - items:
+          - const: pci1131,ee00
 
   reg:
     maxItems: 1
-- 
2.34.1


