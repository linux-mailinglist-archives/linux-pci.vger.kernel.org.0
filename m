Return-Path: <linux-pci+bounces-30692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C29AE96F9
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 09:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE815177DEB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5325B30A;
	Thu, 26 Jun 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n2PDnjvC"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EFF25392A;
	Thu, 26 Jun 2025 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923630; cv=fail; b=Kf/k0cA6g1vUEb4aVQSVdaIVVDjtCyyDVPLo6PECW4gs0VwP+h2wDpYyf//lLGORDaM1Cr2XDXnbHi8eYOuJizIZM++2xWz2MUW6QJm+teOxNO25ktSNCp6UsZzDJ7EOL6q/kI+kQDbBaK32oSGFjayUBRZswkhS5Q052S55TV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923630; c=relaxed/simple;
	bh=m3dbIYhHPbQ9d9A8Y0rAJE5pOq/fVK3Qkiwn9VqGk0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JwJ1/COdrqL24ueF9RNt2XrSiWf+PrcXYbQtm24krvqGGGYUztxg7GETgxnxVlnXCz/3IDstVMzbYTgOrUJ19HqgyxxrPP7gX4PE9q4KF09cK39D+XMmFYqunxOrfHo2CE4VMs7IYd//PTkSZaWXjgQZHaWmDoDdZe/JFzMImO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n2PDnjvC; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHL1B77mu1EfURuGq9DRbbuneOA1sYDuWlvNpSfBXWOPn4Wvdr+Qrs8PAS55pbkr11fjIYf8kr+75qVdLkZmXO3DWdDwroOHuLPgaR3bpdE5ORlhmg56kKsUBl57cyvoNZa8hVrTc2aIfEoVz7OU9ij1ryRmR2/ylVdYwbM5tvhR1W+Fjy5ZL161GNMUBKEPA9zYrU26xYfNZaiXFuReGeRhZtzBldxiIT/u0IRWPZvtxGAoRbOgRQysV0MmHuIIlVtHPh22sp0s4Xi45mKZj0TII9DVmFPhUXJBlYeDL1IK7bu3/jTcc+3Jkc2/l71WAyZxpWrI9QOAATamI22WvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs2UEbMzbeCWmrtXPmbLDtrLrHvSJp877V6yHegsruk=;
 b=dIVSqo/BGt7W3cpq2bx4uAFHEUE+1SPh8O4LWiD42wiifIBL/vpN14gBbYwpfLM5kZeGyuFoN6yMbzDhFMHHgIPbpHLwfRXLUNIo+BX5cYVuEzGuI+Wj7uCzLDBg3WVGvI61On+7upKfFtXtXOl6x62Y/SI+jniUILfA9HiPvQjyO9UAcEw8W/Mx7SVvjB02lYF+ZQsBnFY+eABPrl/sE5LaIVF6+a+pKhNZjs6gcLRGKu7xXPix97Ixim9ZxwWm9SEHHyZtWRZ0WIwh8wmEveNcxK6tyqJ+7SGfuV/+I+7Avx359Xwu3xVrTEmN03Hx5K/+nyDVyOrqS1YkKyDJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs2UEbMzbeCWmrtXPmbLDtrLrHvSJp877V6yHegsruk=;
 b=n2PDnjvCxM9ch06i21HCGTvRmmeSPNXX+XOuDcXLx8WsDMA8zDuCdabE+T1DEkqHhu7qMuM3HFGcu8FfHpbaDhrEHwwoVpZ1hhFqAA79rzjXah7hbkFePKLHdIkhzSpkus5W5is1IVSsBhiZeqNqGaNVK5SXafqb9CMYZY2gnmyO8rqKQ9Vx8tAwzkAuslIAok+vTNObqaDzIRdmkCZNlESGwJbzQQU16VACckRJeVqXZGMzxTRJzqZ91rA6tSjR+xGWcvqWpunueo7eZfNKrocXF51PzA8nz89QWhM9VpKTdrdrXOSoX5reOBk9hb6oxsitz2AIuG+ud1MNx0VC3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 26 Jun
 2025 07:40:26 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 07:40:26 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 2/3] dt-binding: pci-imx6: Add external reference clock mode support
Date: Thu, 26 Jun 2025 15:38:03 +0800
Message-Id: <20250626073804.3113757-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb01f9e-ca8e-4425-b7b5-08ddb484b717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IL701Vzo+HMMXt/x7chgp7BVDdhROerqr2APkGain8x/nh20dlmzvKY99YnJ?=
 =?us-ascii?Q?GnG9csHMZMhpu6AvFreJBzGH+/CmKMoHCxCvV9/R2THF4jDB/tBgveF8TqAv?=
 =?us-ascii?Q?0mus9aC9keqc+8rLSNMXQDHxJ83zQONjSXQhVvIiymerAxQphh4YqNAoGZeM?=
 =?us-ascii?Q?U7NwgHnbZcqdlFo91eXQYzqRumeapWUkEEFExZ2CYoBpPb+X3Qk4Ah25RgE1?=
 =?us-ascii?Q?tKoHuQMrr9G2ENmBxKhuGE+C6H/0+EG+SxPWtrsKWEf1bX552dBZ7TvWUOnu?=
 =?us-ascii?Q?8jrdSTdw1nYV+h7REiea5eyDb0yqYO1VuqMn1nf1qtHX0MO3KQG9adArPP9Z?=
 =?us-ascii?Q?DWmnh3eMS7kHW5o/f+0gliKcBGnLYcLyFRMUfh6Mu4jc2U6r/jo/Xyp5YdgY?=
 =?us-ascii?Q?YsLsdPXeXKf8++yyNTMi5MiMXekxc3qzP2tweTiDfOdohNXPU80hmruu9lII?=
 =?us-ascii?Q?4uKFixpgNBdTBp477VFQ9I1k73UY6qcmO+yj4+yahoowxAjs0KyowXhqqjqs?=
 =?us-ascii?Q?AL44NelZbAjEbqx4EyCWFLYqMw5bZqKJS7C8mCIuP33nuWac5dAgFmmdJYBm?=
 =?us-ascii?Q?7xxVcaVrAQMihhjDu6jK05GruX2flpYQ6EkWMzZKlZQzES+NF32Iwsha6Y3+?=
 =?us-ascii?Q?2yr59ytdpnGKIc5MsDkE5hiYkUxVREpvurV/bbiyqmIZMe6BX+YurbOVWV9J?=
 =?us-ascii?Q?hZ3WICOy5zBxs98csjroB14iUPCX62N112tLBqg2XBGKazuVdbSH9I6PVPy/?=
 =?us-ascii?Q?azmSNCimyfiogYf8wYRI9QxxlaTcrXTkosheB6PLNbZq+erpK2UGEDW2KOkN?=
 =?us-ascii?Q?nhJtrI1GeBYP4dNu3d/8zQKVA7F4ha/N3gdy8isN9U9jcuRkrpLjwFlmzIPx?=
 =?us-ascii?Q?bUkzEowptYFOQIvuelSB2+yeIhfJEY0l4ge4P2SkbQPY9juAfhlU3Px2T+ig?=
 =?us-ascii?Q?6ndDDZPh4bL3c0UKiHGBnxNnxTlci23HJgNspFFROYcX3/JG2J729xYRQ+Hd?=
 =?us-ascii?Q?uAtQhKHKNn+vhgMCsvGu7jjMLCYOZZDoCdx0QH+LQUYpUeWDO1MJFW7WUMUX?=
 =?us-ascii?Q?r0mDPZvrmPakt8Z7HI5Aej510pIKiggq2wgHPrJUC1qbiRPkycXmQhyiq3m+?=
 =?us-ascii?Q?P414LEzgJ4P11ML3FOu/FbOWDjtiAPJM2Q+NhBxbIJoa7WkOzfGq4M6e6MTT?=
 =?us-ascii?Q?KXUoD5VjZAwOjFZZ2ia/A/Om7x0AKIc2G24WMUqo7r+atd8SJONBP1aRoPdb?=
 =?us-ascii?Q?7Vb5pEAymCxR90XnUXOOLY81apux3os4ZnqnalpaoidVHcKGLyOUvWMvZJ4q?=
 =?us-ascii?Q?mBbupFz7mlZ1oNPhsf8Yb+Iix8wkMNwEOQfhS9zemRq7gB+xDt4BB7pm5aUW?=
 =?us-ascii?Q?9v8hW1tvquIpikndK+QlFYptJj+UmM3RWkmAYdMJwAIARj/T/1YjH4k8KsId?=
 =?us-ascii?Q?UdQ/JRl/sJO5VOgbbu+xIZ/G/GFo2CbPEhwAW4P2xlJYrZp3DeJ6t1RNlBCy?=
 =?us-ascii?Q?ZcCynOZbImYK9j4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S9KIepAa0BRaSHXerhSRKcMVIFeZx5TBYPhng8ma1oX21QsVdIF2vS3NGF4M?=
 =?us-ascii?Q?PA4AD9NLrlXmo03vS6QkHo4h47hEGEmWKRao1vHTMZjARQWdf4oPZ8lUaTkg?=
 =?us-ascii?Q?l/x6Sc0L/BT2U/U9kR+p/9julix/ip6PyTf6XKSonzIibPl55Sz9vpiDzZcD?=
 =?us-ascii?Q?gf3jS6O8VRyQvaVdputgSCypVPlC+GKPgykJPSMEaL+VmNS6riDxwMGlC3aT?=
 =?us-ascii?Q?MoztQ+eM68cR8AJjJinQ1wH7+grLRosZr3j8T8hjW462KWTlXeM0JhJoKdyr?=
 =?us-ascii?Q?PCR9R1mVBJ/Q/+DxS2NsvM5XrAVTkuzt4kiXGcACpRX9cK1urBic7yGNK1/Q?=
 =?us-ascii?Q?TLoIuW8+YBhPVX8nrwTcag14vYqq5peHoj2204Qhycz+zRK1Jg0+3rYTlXoM?=
 =?us-ascii?Q?0zrOzGe82WMatSJ2Wc3a11nDrCPFCSYhgiAwRxwrMP3lfxQij2NrDTYU2qWC?=
 =?us-ascii?Q?Y+x6LqgH9hwfgCotZo6XeQhNEmbxumiLLJHPietmSXRs0Py8nzBzRB+zoT6t?=
 =?us-ascii?Q?Xj+Xk6tOaFNnOQmrvNaqUXxHfFn88/MnVewZBGaLzu0Gur/78NysiZ1O29OY?=
 =?us-ascii?Q?VgCW57cdJLKmtIp0pwgsK8CggS2Y6LmxJkwpS4XUeGgB3V3Jg39tK0b2mipF?=
 =?us-ascii?Q?VBYEGKO4O/pRynHLzx3L4mJyNLR+iUk2YKwfS9DZRXwDjQn0ztugAntuBFSq?=
 =?us-ascii?Q?6CpfxBGUv1rPElrNevyLsrqZGC7cqgzGg5rVyTk8+605A1norYcrg7jShv/Q?=
 =?us-ascii?Q?+NEoXJP/bmyUtIzJVbGNV88I+AeqF68UnrJrvC2MhRDcCdmYtgwsA61bBNhK?=
 =?us-ascii?Q?/dnLPFFQf9DXEujomsPcx1Lsq/zTEMn3N5hMQZqsQNOOQ5C9Xdz4HguIo7Jv?=
 =?us-ascii?Q?QYGZeT9HEzM8UhzKTuGIJLt08BU8tlwrZsrB8wn7FdTQjQsLlY1xsIq67v4X?=
 =?us-ascii?Q?vUShIEH0Fe26iir3k38g5DFrHe3DOmwH2mFvPNY3vNSQ92TBhWK3xnuuhDKU?=
 =?us-ascii?Q?/Lj+v1/gs7RaXqQ5sY0nPGAFSf5eOH+UCv3A0WjQtUDbdKaGHRQHQEoqtOkb?=
 =?us-ascii?Q?Dv/MuvFvAIYjBghu5hrvjgY6S6khTBZ0Ku2RBsajysudJUU2etGY7PTtxuNm?=
 =?us-ascii?Q?1m86dOjUbjg7xMwKj0X/1Ud/uUzAxvzS6OVvXgP4leF0pcCyzUiVav69vfGM?=
 =?us-ascii?Q?cLyDsXSzgBLatuEzfcQUWaj90lwwvPaMngtqymIwWeIBGk/qr1NsnAAYDd37?=
 =?us-ascii?Q?bPFIMyHWVYxPb39tR3jqUAPxrILvfoKlInV+o3qrrQGawHHwLQLH9K/LYtoW?=
 =?us-ascii?Q?7Ahm9iVXe1doaPWwQ9xrSN733UJNsPfunlOl+ZkWagn/uFbh5SanaJfY9mCy?=
 =?us-ascii?Q?itKtxzDZTIL0wNHAZ0iIGuMrkRaiFyjMN76VOZEIHbMsBOmDRBfKiYIYoJBy?=
 =?us-ascii?Q?IR0BuIdhk977K0A/dqlpkDzTwC4g+NjZcrmFaS6TcbBOf1m6BI/sf+5D3TJS?=
 =?us-ascii?Q?z/2bv/V+AE9UkSTJr5VSA+xQLRCVlUDvXFkwMykRYzuQSEridyqGRF94DXzP?=
 =?us-ascii?Q?anLlDZ4tSC9evQ47xL0NrlOD/B9dhqrEGbQo9dVw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb01f9e-ca8e-4425-b7b5-08ddb484b717
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:40:25.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlWAG1cXKtKPNGC4upDjTPs3bU8TjIzr14Q+Sdrlu0nGLVOeioVTMtm2xiAgs7sqghGHHidyakLYsAW8GOysaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

On i.MX, the PCIe reference clock might come from either internal
system PLL or external clock source.
Add the external reference clock source for reference clock.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index ca5f2970f217..a45876aba4da 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -219,7 +219,12 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-            - const: ref
+            - description: PCIe reference clock.
+              oneOf:
+                - description: The controller might be configured clocking
+                    coming in from either an internal system PLL or an
+                    external clock source.
+                  enum: [ref, extref]
 
 unevaluatedProperties: false
 
-- 
2.37.1


