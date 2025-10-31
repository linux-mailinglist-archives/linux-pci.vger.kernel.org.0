Return-Path: <linux-pci+bounces-39884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5C1C2326F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 04:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D253BD20F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 03:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6B277807;
	Fri, 31 Oct 2025 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c3C1UlGn"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653A270EA5;
	Fri, 31 Oct 2025 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880791; cv=fail; b=VOwMQxp9CiitZ3p8+JkRrw1/3M3pFihkINhb3c3puL70a0AmcNiKXq5YyJmdtDXrs53MUPZKTinc1/ikc8/xFgbIk30vCafyKyx4OQ5D49dKlA3TtpClOSDkOLWxSHeyZPZ3thvroYMTxImjssskfSNw0DhqAkcCp4Z/zhTAsEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880791; c=relaxed/simple;
	bh=HLJ1UslZwatMbbECQckNxT32NTA4Tyzzy6m5HV9NyFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OihR8wPnDkqR7667/wWnT2ETBYIsT1keljLDYRowsClz3jmzcjbAwaUOUxqg5nwJ7ghlHaZeAAAaNZ902uZZcBVnGLb8bndKRUar+Y8MLgQGjZ27uL6eTj9c6uHVfW0pg2bCENaEw0D9Bq+S4RvGNIakiuDkLpG/NQ0tV7o600E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c3C1UlGn; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVyiGAF1mK78ELNy95HXNsllNoo7PO2rngbCQKt5jcGOlMJamxxcqTDHlkslMksqkjAZEDX/WoH4jLnofJElfvmGG5BZZtW2YJ2Ak1B1WhqEwM3K0cfJSsntp4VStQpfAfnngOOjGS4fgKbFwDIMuYVbsTUgzYrMlNuHdJcrVXOvwgt3/FrULFrByMzB+ubvpiecnRn2wnfovRPQHBmJCl2MmIgBHLb3Vt5FOhzS4xDlG/qGj9IIl3BiJT1jRt9FldWHhlqCl848M5fYNoiM/ZCJVW7HvMd1aeqVIb10qxl9QKjhbU0CKQvJKGFjOHIU8bs5wBWAio3ZyPevDyYNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxZozv0F3QKY3YkQ/IRGi9I3HQYjF4mDsiiwcH9e/uU=;
 b=UR3VmnAmkkCZw7/z+YgqsQx2KjB7dD7UpefenMk/3ilAPrg/D73r4kkKWv0M7ZJzHXRZgaeQ7C+Y6wp94N8eIMjXVQu94o57TpM8S8UxvtRGzphCtp0KIQErVc0uwp4ZjApeGvxfCfiOoaBV7Dv9USgBrfWLklKJcAi85qyQo6v3vp7fYGIYCdPy+HkpS6L82ryomFcC6Xp1A9W8vuZH58Gb3GtzdHdBnpSZdHE2Koi/grkdCRL88tWqhhIayTQFuQzLE/gaZgV38AHg4iBe1cieU6LuvV/sQpppjuhWXviBwZ5MUVgfpaPWJkQkacDw7Jmv+nSSPHlHdSNbCyFwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxZozv0F3QKY3YkQ/IRGi9I3HQYjF4mDsiiwcH9e/uU=;
 b=c3C1UlGn6ld80jKsK0V98VroRgXD5Z2+lfTF4EVyZyeJnuzOBvL+PPsnEOb/nYdNS6PlbSEHZxbysyITuCF9Ty84f1E8y78jqPXRL7X96eXwq7G7QQ/+8VpOq5b9rtQAtGgLu8b7xVo3edMnqYIoQS+U4a9qRAq4PEkcDfYs7hiVSOBo+n6qJk7xhKaHmlYZJdoL6oQ/hT/xu+zK36pvaQk2aXn20pqHXIYaOoW8TZ8LWIgCT1dpVKC2Zf+StSlezxt3Vab2TDBPYuNDKovrerYATYp97k5n2KorANMDTeYH8yhlHbBS9X2ZJeudhTns8Reyu8EGn7r68UMeMPDMWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:19:45 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 03:19:45 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 1/3] dt-bindings: PCI: dwc: Add external reference clock input
Date: Fri, 31 Oct 2025 11:19:05 +0800
Message-Id: <20251031031907.1390870-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251031031907.1390870-1-hongxing.zhu@nxp.com>
References: <20251031031907.1390870-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 30062820-f8f8-484b-1aec-08de182c5737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?80Nc/v/IHup8qo6c2f7TJum5GGpwR/y0GpltrrKtLxSTynqeA4cJcUtiP57a?=
 =?us-ascii?Q?T/TsHDcyB2R8OeIiTlaH+5LsPEyVvF4LjTAWVZT8lL0mYvFn50/9rh1MXx1N?=
 =?us-ascii?Q?pNl2ge1cWOKzlnGna95NYn9v6Krf1VS3r4DqVoT4eMIjPq23QUmrY+94tzga?=
 =?us-ascii?Q?rD/t4DIuMcaGxKGa1aXt3dy8mJlApihWjEMA7qXtwdjABW3FV4P2jGzqldFv?=
 =?us-ascii?Q?UFQ1beQ8GQupGJoaekX1hbfk75osP+48ZafjKlmcBiFCcpNFtRxGffWRXXE7?=
 =?us-ascii?Q?TSZ+RbZ210E32Di2torZIdq3QCWfEMViMgc1TlkCqLNBx+SoLh8DlUeo8c2g?=
 =?us-ascii?Q?HzEfpE8+dOk9CiMMf1uijqeYZfGkmidig7MLNE0Q9K0YG5rhJXcyKb9Ib5rU?=
 =?us-ascii?Q?4joe08zTpB52csCRaRf2uQGNwc0vhZgCvzq5a9x6GKdPTQ2FYmH3sduSABZB?=
 =?us-ascii?Q?c9/0/JAMeJ6/tA2DsNZuvdtqdZSOquXbYpcDRI73/FFCodlyPAGFsW+klxV9?=
 =?us-ascii?Q?nRBUbmBrbXjHKt2psReZ6kLYqSEPrrs9JhWRIcocnaGQBln7xS6ogKNDZhij?=
 =?us-ascii?Q?+SBO0JH5qupI+mRODyvRjcUboQ1StcZ1RGJFCI0ou52PeK4p9AdhGUckT1aT?=
 =?us-ascii?Q?wxhoAiKtocNxKgG0G/+m0YT7TvE5RAuuoIbBnb6nln3HamL72UEuOJUsZy9J?=
 =?us-ascii?Q?79qxmDmL9LY6Gf3vC7gadY0YY54B6MQvkQ1e6xqdUsNNUR1FJA0Yl3Rw3b8M?=
 =?us-ascii?Q?Nsqu2NGq1qRQzVYjzldOn+JeH1+CC9RXX8av6c8LHE5vQVtK68saD0hSzlVg?=
 =?us-ascii?Q?z/8ui0EuH3ts3HTyPatYVYGitQb0Oulc5/RMVXSpMcrRtrWS8tI9BWXreVXo?=
 =?us-ascii?Q?q23/37Sw4DTbG2h55RctdQavey4dD+GMaTpKL3k24DIMTYArHOS6+IAmIlWQ?=
 =?us-ascii?Q?HQKjXdTO47wNjRRBewltaiMrlJHSlPzYbpvGvRe7vRfmsQiVSDlJs5LExcUk?=
 =?us-ascii?Q?+PctZlkSZ3OhDoI68ztuhFb7ZR24s2mtjlHyT54mwB1/rFMhoCsa+9Elilp7?=
 =?us-ascii?Q?RrH5EjADpHSjjQ9HliitJpUeZCdJznINYadB1KExPKPHjK1fAdZM0IekfxPD?=
 =?us-ascii?Q?nYfAbdorUbLBw2C5egfBvDt5/XT25aeD4RGOs2B51X/XhNEXREDGQnbY/UiC?=
 =?us-ascii?Q?x+jI7QgO9GwA/nrmLIyHXU1IrIeiDUi937c1d5ClUL/FIC7Fw+0JhgPPV5mr?=
 =?us-ascii?Q?3ESVIJCTb87c2a8IDs1nh7eVurQ2V1d8/8UMjKribEUdj2fFucw5J0oPcwo9?=
 =?us-ascii?Q?XeysKo9ufT9jV4vaNhZYzcjT4Hcuy+7f+v/PsRyRUq5qMbHsnIV7euIc773B?=
 =?us-ascii?Q?50IpXDuDYcSLwny/FCFB7Vr0RHDtxi3VO+zbolADLEuyDlR9PRNUqebI52XX?=
 =?us-ascii?Q?Ead/mh/4OOGeioyOo6XcPU6er6cJMd/+is90jATrnqJ0D+Aja+fJ9zdaXkX4?=
 =?us-ascii?Q?aalmhRtG2VvycguGZr68sbmlKnsKjc0SRSOf+/XwClEPkUbfg/GxHV0Ylg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?04T4JVlc0+JuqQ4D+bsvLIpsCzbRYTzmO6nqURn2V4DY2x53L5IKYi8MF1uw?=
 =?us-ascii?Q?0w1UsQqnaR+eR0jxiiHhGmj8EXMHW/jkXal6/E/reZIV53ztI31HvYycjAEO?=
 =?us-ascii?Q?kEk/mpXPrzrVfx4hIiPyEEjxkyi6HEMYcurdsxwN2keWrDCBwMlfr96RoEKn?=
 =?us-ascii?Q?8uwRQYPnGaMeKlsaZ8f3lj0emhZvj0GGtzTmf6cIVFwnHZmVv63vmtwiaBVX?=
 =?us-ascii?Q?rWvOEH4dCgHurnPf/T5NuT+sfnEAHnXd+W5SkVmkiQWGNvY4Citd+N4BbiDG?=
 =?us-ascii?Q?PW9IYU0ycYUjydIxuoZsD0bFFtVk4cTPkPQyC/sWuiB4yIi25J4ZFJE787lo?=
 =?us-ascii?Q?LB1J7y085oLtPcQj0evwyDHbl2Rt0TtWwqIW9QMin8zMgZPaJ27DF1lkLWE0?=
 =?us-ascii?Q?9rN5Bqm57lVo8VRW7txpUxIrbttIrkEeTWIx56/SGSj0LDcKTTz0ZEI8867O?=
 =?us-ascii?Q?E0/P+F9apK0SZbnGpBZuL7wYUgHpzMAfZ9mKNTro/U0EoAngZ05fE032ZDEn?=
 =?us-ascii?Q?HcfSpwUMhALirZ2PVqRc7jDxx0sqNki/T19eZYjif5pdoBUqD/spnOnfObDO?=
 =?us-ascii?Q?yLWX+eGTOt4wtpdQRKgsroeLcBhWv9IX9YteJP56kTI/AXwruNLdFFQ76PC8?=
 =?us-ascii?Q?tGjdwvuPAFCklZGRUSg4VrSD+sDbqiMmbCW4ZdDAN9KCCAF0XkniQMRxLPM3?=
 =?us-ascii?Q?4YcWyRkS1u9crIbDrtbW/jFBNh9ggrmVDsUwhrrmngG6RHetmK7OTqfU+fyd?=
 =?us-ascii?Q?h1+tUSzR3c9TXHfBH41braXHQDZy9+3MWAkDwnvftVi2Q+fMdjbeWakII9lP?=
 =?us-ascii?Q?bcoJRCUyHC6XruP6ubD8T4NMYEH2XZD4fcBxYH8+ZWk15F/VOyxhCshuo502?=
 =?us-ascii?Q?TtDPEglBt+D9vmXWxtDXMx/nEQhK+b2UyaYZ7HWaUOhaDc159w7lFPMG+rEO?=
 =?us-ascii?Q?Tj9Bqjt5pG5xhCqKybK6uU6/z/DstTofK/+TTXs3xco5qwu1xtFH1G3NSefN?=
 =?us-ascii?Q?CY9yu7nDLJK78AwWjWZHEAuX5Qol2cmfZrCHfmv79kc56ih4emJOiHETCHpo?=
 =?us-ascii?Q?MnL1Vl9OZtfVvuwDzglF9B+oZVtpOwmEdk33BVM3F8MgLSPw7eMma8ebG1Vo?=
 =?us-ascii?Q?MGJj6PLhB51uVzQQdPImOCUCmS6X2BUFGCIBgTbqkzI075e/4BOPbd714umo?=
 =?us-ascii?Q?XSHcoI+v7mHQoC39s7z/kqUfzfo5UHe4Nl4jq1CBj6TNVpHTkocPTjCyIPN1?=
 =?us-ascii?Q?mbA00BHognkRp17sl1d/p3NqDve7uIxpv0KwtcSLWxGAfQAGC5CUv7pOtd+v?=
 =?us-ascii?Q?zc9Z8meG1zd7zRt06vNXCEv7js9FPwf6EVZAQZ6bZb9AskNdJdOF37qnXCjy?=
 =?us-ascii?Q?zcBAxRNgg9U0XkQxCL0+SeXXE5xK0xvE3YSrmcymOgK6cyOIBukXS5LFL3Ci?=
 =?us-ascii?Q?+YGSMixRxdO1EbJ9mAe3f3+P/hNkVgIaLYHEVNwSspvnr+LYr/0gzl0YixgN?=
 =?us-ascii?Q?rg5oqI2yqv2MGcr7KVx/Hp7ab5F4MJUeZWR0KTIUYsL+QleEHzmdNiHbIN2p?=
 =?us-ascii?Q?+mrOtHe1mylQ16ukGLNb5Y+EL5lOeBDO34FsNdg3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30062820-f8f8-484b-1aec-08de182c5737
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:19:45.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqhrhOyraGNAE4wJPR9OUUlpkq/mkxpmAvxk8HAHegDGEgXKxBzsGkr+lFRV0O++m3AACwubnibJsIdcWKCQFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

Add external reference clock input "extref" for a reference clock that
comes from external crystal oscillator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8dbe..0134a759185ec 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -105,6 +105,12 @@ properties:
             define it with this name (for instance pipe, core and aux can
             be connected to a single source of the periodic signal).
           const: ref
+        - description:
+            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
+            inputs, one from an internal PLL, the other from an off-chip crystal
+            oscillator. If present, 'extref' refers to a reference clock from
+            an external oscillator.
+          const: extref
         - description:
             Clock for the PHY registers interface. Originally this is
             a PHY-viewport-based interface, but some platform may have
-- 
2.37.1


