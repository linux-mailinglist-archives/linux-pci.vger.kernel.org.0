Return-Path: <linux-pci+bounces-30691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3F4AE96F6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 09:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DF6189ABCC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC41B043C;
	Thu, 26 Jun 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LQQnM9wT"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF825392A;
	Thu, 26 Jun 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923623; cv=fail; b=o+ac0+KqIry/7sb8GWSJ6MTaFALap8RlO0BCkAUszhOOS+DuSC6UOABedrZ+n6q3+GRWpaWi+99fFpAvTDtHEcRvhROsoEYaFM7Py3HJsa33mfCN6jsQR2G6bu300c+efhlcyFEdOIUPSy+K+0jdcByKYc4FIikc0/eemZjnY2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923623; c=relaxed/simple;
	bh=dOYTnQRGg7PBCc5gzlzjAECMS+tvzkcGlY/RWKhTocM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2E1GNSKL+fM5nmPXS+etgctyjzk95SfAdZvCEneVUKXyI4qrmWrArmyFc0q7Jdk39W0b6zs7ruCKwQfb4cZ1pJk0ZBoSbx5KKKWRiQHxls3VDtddkjuiHLfWfmOkVmWWfi0DAIL3TQTPhSaHmyYxzGl+y8gjG651h6gsalLXEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LQQnM9wT; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNm98mQRd+Xbhu8XXl9wQLMAHp98MlBqB0VIOo7vFGAEH6VTXYZCFBMUNU1nSV2gtqGwF9ztMyk0KzL7sdIXDBp9zrniTeYBJLibSLc7qJAT2QOiKat8nZ3BqHgylKsq728nNIimEOXxNfo0DtvVzXtd4UdTXJxeWPOVDmRV4A1IFEbzy3+Pj4tGSRbfjq0XbK+lzGJrJaQDV9pTEtMvhAlxsVr94XF0EPJbQhgNK5XV9IKDTWP1nNV0Xq6Yy3YAm9E3zfsMC7hM3hItbizjwyTjo1+fZbGXvEBdrTcnzEoTPQErXUR9pEWQN+hYSPjWpuYyimkTjLJ9YJK3nFYspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTGudsc+UjAaMQ8d3/9ek7ZDN+4VCVxd5hIiIPKWl8A=;
 b=Zh0LiWO7LVeh5Q6fZKKbtUatkjcevUZMwis5U4c41C4lCMEwILE4/PhwxbVrrAuCZ37V1x91oV1BGgSA8FBS0JGdLf3F3V6FuAItIZ7jqZrG73XdOAlrOlAsnGzB61xSdCOPhgvznXVNJmjco3qYkTRJrnap6GKRdVngb0MdTNc00q7/QelaSZ6LkHS6rNbZ0GzUOGrtWO/i0p9DYNaw77+ToxSafpgNKEAJqgBCvjP8XwcEVO2o/fOVqxUuBy9JAYjZLgw+GrE1vCI8Kob0XvMzwu+P6U3NQkjea2QG+eIWsZdWxbJ6QdqlS3f8bx9E3DyC7o7sedMFeqJTZD2zeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTGudsc+UjAaMQ8d3/9ek7ZDN+4VCVxd5hIiIPKWl8A=;
 b=LQQnM9wT8WxlRhS7Ixuto8KJWhMvCJkRaXhtDDMrjBKK0XPyytEsjnnsZNGQ97ga+UBC+FygoGa6P6XD6xDRTQI0qa8VRPpDloYCqbVIZt94gmkpGcrie3MCD1X7xcLpr3At4peTQzyjYipual8y6aEy+biOgecz9Q9YQN+t22rt9UCOh6ll0ImDSKVANq0hDqCBxdW68m77l34K/SFSCvYENIpFcaANESRunNXO2CksuIa5eCMbqIBdw6dWYsnIw0awkxvkOffxTRTyK52MsQXqyV5fyJScQT1Rn+dCV2NCwJi5fuL9Ia66M1Z2ZjjUHYNGC624urZ1xopuF3P/RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 26 Jun
 2025 07:40:19 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 07:40:19 +0000
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
Subject: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference clock
Date: Thu, 26 Jun 2025 15:38:02 +0800
Message-Id: <20250626073804.3113757-2-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52d94c2f-8eab-4f63-61bb-08ddb484b358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mbXBFqmNaueYfNF0phlrExosJCPAlGU3d96OtrIndnqMfFofOX5MScj/wnwP?=
 =?us-ascii?Q?cp/YGQ8Aie+gk1kK9L2Bc4cmgmysVfJYXl/13dvr5oREeLrvrnf5L8orJcLI?=
 =?us-ascii?Q?hlY2GjjOcBe4IacX4VLkskh+7XjQlXI+kma0917L2n5NGiIP9a2UK8Eq5x5Q?=
 =?us-ascii?Q?ZE/4mHijQUaQ64IVz/qnhgzVw8hvwW4XXRsIIYwxVo+LtAjkT8N+aXYEAbIv?=
 =?us-ascii?Q?P77JC23UuJMxFfdzQi6LFKjNm2NsOrye1xoinmflUOr19tjgsuxMjpK94alK?=
 =?us-ascii?Q?KmeqmaxVchc/4Bf938A0lDTe68NXVtkPwMX26EWTonO1QcXwv4AnS6seBW7w?=
 =?us-ascii?Q?l4TCB2ucW5+TBuFJjK3h2JxgZO/MckcQcvAq4vGTg93BOpRAdrAkN+4sH6bS?=
 =?us-ascii?Q?LC4HmNr2uHy2jO8/w/eJjpC2IzWzrbhCSj2BKSjBLltcaTx8gonJc7I0r3MJ?=
 =?us-ascii?Q?MrfByJmmmi6Q5V2EKhJ57gmQrQXkefKawa4obLqq5teWYIhCxuE+TXLJkJoJ?=
 =?us-ascii?Q?8JfSSDnQEeLRGJ60G+zUKJ4Ie9+WgYENNhem3Q4Y3LAUrV2C0zU4Q203d0Qr?=
 =?us-ascii?Q?eC/Gcg23pGawpHQgT0rimZCwG75zob/ty4WdRPluCU76Rskznrp/A/78cFhv?=
 =?us-ascii?Q?79734UjZu9Uh6iJC3XYFGe6p72bTkXDrwMXwL6sUDtR7bDF6PlGZMOd9YvpJ?=
 =?us-ascii?Q?1IQWuGl2cLQgCHAzr+odW1ubDit+g3aR0e+QG9AqOisl3W283yxufdpKCarN?=
 =?us-ascii?Q?KVzFkan1hNFJnO8p5C6jc/3Dn+SLAZt+j2YnaEjtYH7zdS5bLef5NRQhuLHX?=
 =?us-ascii?Q?C1z8oxjgAm8H4Xx6c23zWDsYguamYCnt9uft4bwFRWTK5gQu3J0hvuoCYB9n?=
 =?us-ascii?Q?FxfuSQRlmpxjhA4PSk2Og0K8YW1AlEEhaPvaiRpIEEu0RLvMkwdN+B4sXvIP?=
 =?us-ascii?Q?laob4MRBFA5NFdz79p1zlcqyim5R0oBm/wh/Rjihvj9UjhZgmU75k9y5X70m?=
 =?us-ascii?Q?gO1aO2/+KIt4ZxlqnK9MQtp3m7xzCh342RPbdkpUoGHhN9qvnCpvTA9F6rvZ?=
 =?us-ascii?Q?3ZDDyaSqNUq46m53XhDdrZebmiRs6p0LfHpooBPeHwy13noUyonHELt62NS4?=
 =?us-ascii?Q?8WoxRPTDdwK4Vvh4FdyJQ6C8fSDC52VEfvGCVczmJyCIk5NOoZigWG2ahv3V?=
 =?us-ascii?Q?ZUYjAobenI5uItQQ4gfe2+HMnofhF7oPPvj4bPasaQ80mNIAK6rysYGnum8s?=
 =?us-ascii?Q?KLQsDHiy+Kbh2/58gLFdgitdjysWE8k6U0wZnfk9ove7QjzL++QXaUcBW3JM?=
 =?us-ascii?Q?vCv6gQQQKoL9SDrU/r+Srq+ui0NY0YEp4BN/sry1T2CNnEXqsHnQlpMkmrno?=
 =?us-ascii?Q?sIHBYi9TEXWX20XIU4BM+gzXeFKmHbeOSA83sChN3goclS8NUfAh+4RnZFIf?=
 =?us-ascii?Q?AUnuhVvRh7Mq7StDTO3UqKjfz1ocHf9y9EgzwREYh6dbmNHP+z6rbZoB62td?=
 =?us-ascii?Q?56/i4WODQ1agFP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8Geztfu/DGDvkTkdoTAOIWagu4Ty5t/dORizZQjROwSvnfNWx8kKzGZrOqC?=
 =?us-ascii?Q?V2tll1yPAmPW63EMvcTFqKbhiJ1uyP5vMV1MyT6dqrVGnTzc74iJhiWJXaqb?=
 =?us-ascii?Q?LHQPY6+vlUHIgp46EiUaCv8VMVC/K8xsQpJ5wFutig6C5ItV4WQ/oCMURtbr?=
 =?us-ascii?Q?XCLhJfDS175qfTN0ZSRTaXwbRLx4RRQ2LbAGgcWl67iiKZxaDHtA7ayGtQ3P?=
 =?us-ascii?Q?If/SrGcsAmNIKyeje6UBL//Pgk0FpMNJPsSEIKVWJD4KycLTKPpzIY8hXbBI?=
 =?us-ascii?Q?qD/ZpA6WmDHANrQQkEmt4N1H/ce/DfmPNb50PVxNNR0Jtxr3bTIs121h8f8q?=
 =?us-ascii?Q?YZG1siN8JT91fDkZjRnJCuMuoxIeStvDNiL6DM96/Uz4X+AeZ0Wcp9q+rShQ?=
 =?us-ascii?Q?uTZUH6b/mhYTEcnBLscIdHuDHZgpWlk6BunWB00m/bbE7MOlXO62n7QvH02o?=
 =?us-ascii?Q?Zof6rSCh4Ws/Mlm51Gvl2bRf01XCOkiv9wdfj73KEhmJShRore0UX5V0shLa?=
 =?us-ascii?Q?C0ve+t+oTEtpHhlYBB8eZ/4FFFYqy8TwelPvhWb0g2Kx9yZso9/vPX4seIbp?=
 =?us-ascii?Q?okQRuQJgT9QieGR33vJ9dH37c/i/EpYJadjTF1fexUYCA4rE4jDQE/lr7IO1?=
 =?us-ascii?Q?YNzdWnIbOQo2lSpaWniIZO8kI/7FDuSq/gaVTToICzNCgJY0s0P41pxVDjD9?=
 =?us-ascii?Q?kqm6yx/QXS0M37nyGTz4rBau3/mlQWZr2kvul9Smp6gKmlfLVZMIcvnvMr9l?=
 =?us-ascii?Q?vT0X0XvG0Oq5+T7cASMC1NUwCKzxG9RxTBsdB1RoVpelhz8d8Z5J/wnfx4p/?=
 =?us-ascii?Q?dumMMFiGSY8VioPYXxZn5/U6FV9bcuinUvrossHtNAgPOGWkqLDO08Em2Pgq?=
 =?us-ascii?Q?Y6clZ3llC8Tb0KoyHaLSQ84d+yNVXuhWJxq/9kckAaR6YuRGDxztelt3LLp4?=
 =?us-ascii?Q?6pQswXVV2rptgkBhfGob+gtbgga2w/1eSXd6s1/sKIc6p2ZLWKhAuTnCMH4W?=
 =?us-ascii?Q?xwljGmS34QL8XxixyI6LvqrUFdt4sBPJBgcnQfwWNmTdEOiL+fy6DBS1eu0x?=
 =?us-ascii?Q?4zO1PeS29UttAlEbBnTjHVF8rH0UQ/+MZVWbby6xm4D6pWsaAo5r/w6WMTKE?=
 =?us-ascii?Q?tipgYAN9N8Mmluhs93kOhG4Ove1HFr1jbAjlljqrTkFdSVHtvINd3IYzt+vY?=
 =?us-ascii?Q?qz63Z6eD7edTiYo+UcV4FZ0dDXCFKGN4KKBCvly4jCnq/jJlewBJNnaAekKs?=
 =?us-ascii?Q?0ujty+JwAqFb6bXBJYyKhweCIF3Xq2DZq272QQRcybvHGTnA+FYbSLmf6+ws?=
 =?us-ascii?Q?USZiZYeXERyvzjOdKqhHxNLTjDq/v1urg456BHqkEPPGIM6pnb++SDNPxILH?=
 =?us-ascii?Q?VNhc11lD+eFco+gLyWVgMw59BJEMogVy+BzuHT20Bpal/ggbvnffGMsZt9bw?=
 =?us-ascii?Q?hyYtnAPUpjYD8gFJOSfenGqajVwBf80RbI8IgT48spc82n2Y4pDTh3CdEtCG?=
 =?us-ascii?Q?pMfC6pn/QlQrCtYQkHRfDGaKjBtS5erqjEqqZhzcnBFBFaEhTQDaCc5mbVHj?=
 =?us-ascii?Q?65sVzI/PCxGprOgNE6SFc98ZK38VIDB8sLBWOXJE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d94c2f-8eab-4f63-61bb-08ddb484b358
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:40:19.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noJE8y3lTmdvbRtBLfp4cDBH7jnl7c3A+I6kGvGJkdCah2uixaKqw0no87FLGvFnh4RNbqpm6wIs9wXcqPRT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

Add one more reference clock "extref" to be onhalf the reference clock
that comes from external crystal oscillator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8db..ee09e0d3bbab 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -105,6 +105,12 @@ properties:
             define it with this name (for instance pipe, core and aux can
             be connected to a single source of the periodic signal).
           const: ref
+        - description:
+            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
+            inputs, one from internal PLL, the other from off chip crystal
+            oscillator. Use extref clock name to be onhalf of the reference
+            clock comes form external crystal oscillator.
+          const: extref
         - description:
             Clock for the PHY registers interface. Originally this is
             a PHY-viewport-based interface, but some platform may have
-- 
2.37.1


