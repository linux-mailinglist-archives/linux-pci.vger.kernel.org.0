Return-Path: <linux-pci+bounces-30154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C267ADFD65
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 07:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B13E189C004
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706124397A;
	Thu, 19 Jun 2025 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aufew6Pp"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264524467C;
	Thu, 19 Jun 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312661; cv=fail; b=Qgv6VLPiQNl4TkXaJp0S+Wjhn58JXRDb2zEt+vZh9g5hSXeThfVPsxJ6ql6AaQ5VlxyZCg2DwCoQ/cs+uhuDpReo5Yc8T6G80cE3BqNF8C3qMhaXaPAsJnJ1R6vpmR8j6N4HoFHzXrGV/tsJE6bSqf226sFN23hll6VboI/hj7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312661; c=relaxed/simple;
	bh=8wuU64jPrNd0Rg4k/tqOIGUef3eRTHKqcSD5fQUi19I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uboc1mIAbJ7xjnUZqbiMDT0eBv4uEwQtZ62lcvlSYZCX4tWvTJBQDH+1nBJhDd03eJ0dF4l8AYJTjWH/zX4mgmF0pGZGjfukHuPAq/lJFgppPT3/VwkzIsE5JeCXTs16vIwED8sd+L963lfJ55OYLHRuL5pjwoldHylTT6X9l2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aufew6Pp; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1cXkK5KWphaxVpoDy6w+iG1YYSrB26T37IyrEyzslIRl/MpO4G8avXEfJ4s6mG8uUnMbgCM3ADN5X5zimyvyowYRtElgPUWNks7/g+nXbNADQbmgTsoet2AonpBLeiUPgOgL4dbI8niGSklhsJgq4G3w6UfwhLF/Oo6kH7NEeTVikufY9YLh//PcwFM3FlIPMdQCPX+6LgnOI/bIK9UldUhKVWG5cbgk5GvMGQP0B0jKr6Tz/AN+gQR+SNa/IF+10v7cE3skJa50Ex0SHG+85jNWU/LJIBtN90iV6JHAQjjTB20Q2dsStllN4WziOh3Xjllpi2BdmPEQ8Ukviy4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDf15+ngiMm+cJ0DBsedfeRD5Ab4Q01vKu08D4Rn5fk=;
 b=atzY0TtwVJiTKvqfhuaovXCiTAPv1yfa9sVawmNc1v8ictUOEM0hK/FanHNi9bmBjkNoQ/VsTSXe41c2Sbw81qg9plssIN/1tBbXtEqDDRjCQbXHzhk8OP2u/yJ4U9gIA6U7dc7gkat9oon2vo/AAFI+gCNCs9MOTPFD5CguI20+bAtPpi1VGt1tfBIm9wsWodo0PaGz/bbKZ+sNq9SDVXPz6JsFyIUC1e8wUfcg8vmxdSMde9hGVXS5F4P19jbE5m9o8eyY+NGGzwbyYhlWzpJgJBGNRgfgPF+ym0BIDzSfBFU4C/zGu0zSQ74dNuAiNVtoDjwUiZNk8eycWKWSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDf15+ngiMm+cJ0DBsedfeRD5Ab4Q01vKu08D4Rn5fk=;
 b=aufew6PpWHlmA4XNzImlIaisKLd+YAJQmdi1cY1JpFLxwre/o+juC4huThfYwXaxuU/frJruZTwurip/tk40hIB2bXqROO1dx23IMKwuKYh6AJThtmNxrmUAKApO6laTY53GMG4xaAz5SQ85EVdXLkQ1rqEZDgwJ5xb7/MZZPpHaZE7O382VbWCnUba+ZJF2GkWa8hxbjmQrBdf6OJxVFEy3GvBDBuIrjI6IQCsdhTFUKsdfynoDotNzp1/Gm2XPQkiyR5ImslJSH18c3F+BlB+iTUCBgrbRKo0nfxMmIblryiSEt+LsqZhEUwJ4XbGxdvfqxp/xKf3SQC3MgETJyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB10151.eurprd04.prod.outlook.com (2603:10a6:150:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 05:57:32 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 05:57:32 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RESEND PATCH v1 1/2] dt-binding: pci-imx6: Add external reference clock mode support
Date: Thu, 19 Jun 2025 13:55:14 +0800
Message-Id: <20250619055515.74675-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619055515.74675-1-hongxing.zhu@nxp.com>
References: <20250619055515.74675-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB10151:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c740e5-c7e4-48c0-e193-08ddaef62e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zz8K8wBfA6q80ZK+I+lxBoxwlHB3J37GpZeT8SbdP1jDVuBIYo++P+0d46mu?=
 =?us-ascii?Q?POKma9HQgl7zyatmdcSo7TWEedzNEKwtxHaElpmTfw65lLFQcGTmlU+N9F0a?=
 =?us-ascii?Q?Lk5dwGz8nFdC9I/kXbyjzV2JdijATB/ICU3JOhksTtNTOicO3F04A/33epwB?=
 =?us-ascii?Q?fa5d6TuL6+1MyFdw/UTiE+SwTyWdSIH/OTYLJAB9L/kxoPq9KJXqIO+R733y?=
 =?us-ascii?Q?jy8OAUYRUF9jneDmn3ld6T5Gsi1tJQ9R3ALxWzm/zhJTnykhjVjhRZ9D3nfr?=
 =?us-ascii?Q?cgFcAZO5rbZ0fO64SnIORfWp2fujca5yVAK1LKEhBihSSsXiDzspb8y1cRiR?=
 =?us-ascii?Q?NI+SPH3y1FhrqbdzTRvMmztAyztvBNboMnxZED3EqqksgU13cEDKQDOBtuhB?=
 =?us-ascii?Q?n9e/XXaP9QbWQYYgVADRO1cJKv3mFqCxAo7qF3vYTV1XtwcMoNU+grVCuIO1?=
 =?us-ascii?Q?EgRYNBwW0mTeoRlJ04SFaJZY0K7kjyXco77FquL7RDYfxAs+PNRgA9kJE7vy?=
 =?us-ascii?Q?K++yYhbe/iRdUp0L2Ld0OukNioRu/ZE2rd6iEOYNKAHsHyhPq4+8f7VE/ID7?=
 =?us-ascii?Q?/W7+jQeBdlrNH4SZ8PUeY8PM0rLU2SybWY2cgsFiE61w8CLQ5Ob8AUQPG5th?=
 =?us-ascii?Q?XZtFOun6kyFLqK5BJQJS2jUQdz1feXYGsV1H9JoYJInwzee1fjkXp+eINsYV?=
 =?us-ascii?Q?wuP4Kg/q6qqrjHhZd9+6/nXtXsjMYp82sw92mYdrGicObNFyYOMYHzqt4wOK?=
 =?us-ascii?Q?WkRIMoq48VTgPSEh9H4XpJ1w5MXR2U0Ij3xcfqBXlqZC0eBjXYHjL7kjt7NC?=
 =?us-ascii?Q?qV4bQRgif0p0GNwEH0oCLONzJQq7ewfmwnt0XbJ+N/YPXceL0Gtl9pklyTVR?=
 =?us-ascii?Q?9Ii5nLhjl+MtMIcwy1BU0093w5Qez9/uYbC0PPO1Ey914cZYTsXyloOuYBQ3?=
 =?us-ascii?Q?xWjGzZNpou7dd9WXpKcDKMgLx2//RkHBW1rzvn35hlu2vO1g7kELgiu22nlz?=
 =?us-ascii?Q?5mvVmbQyFII5OePksPCmHmZL/mwhFztt3A5xHW/Kdr658KJ4oQjwrXjRvroN?=
 =?us-ascii?Q?j6m7TMocsHdgrjsuTbO+oX9EjdELjkiOT2ukKarG5h/W4cBXT6S2gplrrQ51?=
 =?us-ascii?Q?Z+4fHcJnZa7/1XmgeBtLOKx5zsWFwmxvMKuh6pRQO2mW5Ox4WcsdRtdsK2vS?=
 =?us-ascii?Q?1wqS9nNPUrF+x4SYGrlwiiO8eGCqD4k0zjdMbu2PG60qla1cKpUkFUp5J15O?=
 =?us-ascii?Q?cn66dNO+/2S9FTnAPf2ESpcvBoLYqm0pcobXmNgJuGvqGE3jvsD7oZDoRq9R?=
 =?us-ascii?Q?a4i1Wp+ocX4E/Tk2I3Y7hLEukZVFbIkvKJhBLXYvORN4DFla0uKKFcxk9wvN?=
 =?us-ascii?Q?+H+xN7EBf89ZzDN5bP6q7tQNtxdtf8ZbvUPlHluAJzoLkddDIioIi+fbtDOa?=
 =?us-ascii?Q?jmEkHv+8QeVwlzSx6KymVHPzj0SlavqXYdU7czQ72pp0UIGCrTIhhi6Y4wO3?=
 =?us-ascii?Q?dro/I+LSpMM6dyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iU3VoVuYeclaS6JYFcCp+CQPmXLJSEAt6vyh+Tl2xk+kwDrsbPuxk3nCwNlS?=
 =?us-ascii?Q?RDGAM3WLZ2YfcLQb/AgiO2E6rldRvgnqjBENXr2pBEkT1/ac5KLI8/ejvHwU?=
 =?us-ascii?Q?PcWekIPSXO2K/615rHsa6i5GPMi5QeDOZoDGFm8jf5uTmQVCmhOLrdTIS7Wy?=
 =?us-ascii?Q?HP3SGB9tBnAmqgW3yc/X3BJImdu62gQYRlfSf/btuEnH5YpX1VOMnRoo681I?=
 =?us-ascii?Q?qxsaP7TcV62N+aG03+r+xGPyuSg5Xcxui1FfTo2vOfQft3HlXkWhqxOSR8EH?=
 =?us-ascii?Q?3rRPL9eVPM3tv57exS0I2/SIocAiGmjn1XiLlf1GmJQNNPpGtk4EwwvfhrY6?=
 =?us-ascii?Q?qNiQzbQ5u63QhZqLg+y0EbDR6cQTFm35OyIQ5HZZZ6XNJ8woqsZnWyZf0mX8?=
 =?us-ascii?Q?DCBrXzbzsMsR8ci5Qv0yhNE7m5v2to5ByC1q/Oi5gt4Ki/ptcEv7Aji602Ri?=
 =?us-ascii?Q?aWRbWPBgwqg52E5jddCf06ms7RLDwG2MInRamdwRJNsGO/CJk9Oi4wlZSDIl?=
 =?us-ascii?Q?CKm9ArtZH7ck0sMQxOCPmeqFOUBz8YwDP3K168jyFOQ0aTtCbdAyZf6ByoUM?=
 =?us-ascii?Q?0foYGEGDa4mIV1ATMi6llfOUDBqItMe77ra1DhXR+mhKXUgMJ1vLSb6XgvSe?=
 =?us-ascii?Q?upMfkmomF5k25Qzby5zqZa7UbvPci+alE1CVnGJTH6+aqUle2ayIwI4pHDzs?=
 =?us-ascii?Q?HPm2N4zsfct27m+ERqothd9jqxcCHkSQlxyHQ2jA6NtY+j3EA18Z6ZFqZKkg?=
 =?us-ascii?Q?7lz8CDQhWoBD98bwycdoGyratTcWCtXd9QGPWBtB4fC1IaYGqUf+7AHkqfzD?=
 =?us-ascii?Q?NzQR3fJJeagQ67bavHRvwNoXJfFtb+pLgCZY81WnLsj9yLJfHrlXoE7nuWWQ?=
 =?us-ascii?Q?Gm2cA4l/fnbNnXFx2dDp71wbNU6jLJmjWGQrmltelsyl69StfFFaMO0J7DqH?=
 =?us-ascii?Q?a984k6g1l+e9zXVnZztpH3n7flvU3i156G+8WGh6FevJ6c05a1X56V9Id1z6?=
 =?us-ascii?Q?rrQ9Nu1+KAtfVJJbOHEFrSPCYAL9YAHMpI1ITC92mRUcQDyCLIN/oYr6FkFM?=
 =?us-ascii?Q?kiqYNJe6QebopfHK3SfI9/y04o7rb+5R/1bmPLlM5OGlfte92jUSs7jVw+/H?=
 =?us-ascii?Q?wPXz7q1SnjiYIILz0FdfYjsORIy0RprdIdsgMmwbMQ3xHRwVIVdPfkVL7YUw?=
 =?us-ascii?Q?VDQyZL2PFCDVF5+zHDTDMdN06K1sdXtlkDpSiSvh0a0jpXFCFA1HZCZrD8Jr?=
 =?us-ascii?Q?fOt01J4cnSV21pqL/hJIS0cy/eum5PX0vNjERUQxHfCLPKNnXLuAr3YtT1P6?=
 =?us-ascii?Q?ZoAytiTiTQMoUTfh0SyNwpRnaic1FYcZwNiksuu8bLej4TZuEVlOEJo3pRmx?=
 =?us-ascii?Q?QTDsVtxGsDzemMgoU1kYuJK1Ix90BlGxXAT0QlP8ALDf/H3a9w+yJBdvrCfK?=
 =?us-ascii?Q?Iu4ukDnJNSCCs6d+ZbYMgXwwU2VbqFJjXG/khGwkZMbelaWmZhIQJ0l5E5H6?=
 =?us-ascii?Q?SmOfJ+aa50/gcoB2pfoz8MlsBXbsmcMxYxjyg4HA3GwPyYo1pFCTeboBeOa2?=
 =?us-ascii?Q?V/hrQD/9ICEjfG7iJJWS8+PawDJODYCdrCkvCuq0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c740e5-c7e4-48c0-e193-08ddaef62e73
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:57:32.3995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+bsOy0CVmPx15qzabWEjoBSn6wW3KMHOJ1PPf2pX3hcYzMZOXwJdpP3jHnG4T03yJfuCov7zpJGoflm0mnyWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10151

On i.MX, the PCIe reference clock might come from either internal
system PLL or external clock source.
Add the external reference clock source for reference clock.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index ca5f2970f217..4b99fa8e7a25 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -219,7 +219,12 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-            - const: ref
+            - description: PCIe reference clock.
+              oneOf:
+              - description: The controller might be configured clocking
+                  coming in from either an internal system PLL or an
+                  external clock source.
+              enum: [ref, gio]
 
 unevaluatedProperties: false
 
-- 
2.37.1


