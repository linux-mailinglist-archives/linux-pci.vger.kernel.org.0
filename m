Return-Path: <linux-pci+bounces-36105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F4B56F0F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 05:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 135BC4E01D2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC8271459;
	Mon, 15 Sep 2025 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S1nhraNd"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE126D4EF;
	Mon, 15 Sep 2025 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908463; cv=fail; b=IO7dPCjUnHR4B3Wh+IAp4NEQOVGWk8ykqSHjH6sv6rXUf/fJ+NtpZWy2PqvmkqRRC+DEZ1B8CrModDdXgm2D4UpwPWLm6HSpeI26qF7EPC8d8B3JfqKkwimUrl4DVoxnB4VQVQcYrrppmQ9Weq9huWKE7ATGHUTF7pqpH+6gqAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908463; c=relaxed/simple;
	bh=XF+jIKJi5j95j7oQANGmIqjCQakIjVQC5xGaQPr48bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOmDmwb2xZtmlsbCyqkfl59xbvwdojXVMB9YYuXkK0LTRKk9t0O8QCgYJArkJzbl8FWTNZjpFnywGWdLMDO2/nMm2Ko/k4wLhHPrkPagRSD6X0Ukym736S48ggZjKc1FPgMKhGgik9IPcwILwnniBI5150/cPOgCBRhuWySw3vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S1nhraNd; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKE7cAQo5HWKJnxRuOWKra4786j/JKN0bkcPR/m4XBA6FKcSzD3OCBns/RQ8LRuJ/MbWyYU6P6EOgZYGAI/C510ELpa20VqomLaQuEUPsApbk8w/2xnA96JxTXUjYM9Fj1SvGyaY2VsQOlPWiOjWn6nwyZI91i0eNq1mmBGQNs+1wKSqD1EXnJvkOK4hbBLCeo7GPzhNYBNIAgZeioHctUjT8NaARUTWTxu/Q7+xexcWTIaPSwwA/IPTpr60OErUzCjMDWNEKMWnB7QJG4KpgztT2KL8NUYtQi3uoc2/WmhkTHqA4lkEY060+GQwz6/a/Sxv3B9MbFKxHFkzhyR2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvFP+CbiCmlu9yZSW1CXGyDGIHy1WG3uUeuQGIabDrA=;
 b=gexPL6voO+lqeZvtd9giIM9N7rQx3B82ReBfpc6DVZbj84Hjspi8/+WIE+o7rsP1i82lvJxzHtRE4anM0X5eVNAQRRrCpgx+fvGTvy80IdtQR5Uxz+JTvItUyPykvhVFbrmD5EfydO+Ce9acp1o+FO3YbHmyeInTw2rR3CehkAG5GJnxAF7T+DaD7DeJp0e9LCGGsT5C+JGDQbyqsLGYSCQ7FkXdEsUeds1VysjA5usE7Sdu/y7OdJOA9/9sO6ECP5AFtnuoZK6R2/4cNqoXYVixUkFatdmmzdbTM1CdblkEnWHlmbszhzIWe8HIrU77gB46dH0Kk1nrwTOeIMCoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvFP+CbiCmlu9yZSW1CXGyDGIHy1WG3uUeuQGIabDrA=;
 b=S1nhraNd03uvv1GrXawZtdmvQrzTK6A77qKnkZRHKm0dMFBtu+ynR9pCZdHRmYvWPPSLDn+HJArSFwKc3zu+X3iU8ppoQ9/KxtaAj0LItoMASqTnfe9sUcYlKRtIrCv3RRS3h/ChwB1IFeCLvkQOo7jmBt+tmIo8/MIRD6KbNxx0FDnTq8RaDhMT1m59/BPeMe4td6NLCVHCeWYsX6jsn1/IC+MNhXWqxNytwT/S/xokSyipTcxiwd4WrO7yk1YEvElfdf6LEbfQy3miEhu+kgQdK/SwOqCnH0jwlA6Ap0wc/3BsS/8Y+3gXlu0jtoRHGCNRvpudcb114SA67uZS2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 03:54:18 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 03:54:17 +0000
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
Subject: [PATCH v5 1/3] dt-bindings: PCI: dwc: Add one more reference clock
Date: Mon, 15 Sep 2025 11:53:46 +0800
Message-Id: <20250915035348.3252353-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
References: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU2PR04MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 034367d7-2953-4de2-6b95-08ddf40b8b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ot0LNii6z9svZsqyV++VxSA/JrEilz1hh175wunsTSk6NQhp0Pqbo/L89e0L?=
 =?us-ascii?Q?fKEQ2m4gCXcLt6dL6mx/wKf+Zlu1Fn5A+2CtL+jPms6lT5o+L69jqxak2P0L?=
 =?us-ascii?Q?2BC9C3MTlcTa4ssegqJol7zybwSo5kKWeAGQHtHG+PlGuP1vCPvdLZohqFI+?=
 =?us-ascii?Q?d1I6yjqiLzRUZ9f1LAz33sU1ljceGMpFebAMdbsH5pZ3NyZaXHjur75ZBTM+?=
 =?us-ascii?Q?tbPswlwoW2EIrMmpL3TGVWv6AP26Bqeh4vO2XbGbYsUPjcLbMBXx0wToipw8?=
 =?us-ascii?Q?zFlkoVKIYlwcjT/RPtfhQ4VFWWDl93txBc6FWzfB9sH35iEtVAgGQeo17ZdN?=
 =?us-ascii?Q?PzOSKBsTICHvIKQDkXBWYh3Wkim6lz0rIOlEKFd29kLNqjnaGjl5wqdUgbR6?=
 =?us-ascii?Q?RpLYwGapS+JwmeX3uVZygffo2xCVhjJZR6+F7X84O35YsFzf0EWXrXBHqQJm?=
 =?us-ascii?Q?4PFrdPhbVvSk0HBMQlNfauxuMJytrwg81ypyUR/rcBNSCjAKEVI6sSZBk2Bq?=
 =?us-ascii?Q?dDXHX23shOQVafdxHXm3NnBJCyZ5pSk7fTWIrmRsVZT/9SNoUAMVWb0kFIm5?=
 =?us-ascii?Q?eHC0UZW2Q4CzMu1nNOHOUu3nVbaPZYbEx3AV/FWPTgF3uW7cdDsT9/1iBYwZ?=
 =?us-ascii?Q?GE/OnI9w0M8feb4npUMPiyVN0RQ+xhVDvQBSG15OxYrSlfTpQRqS6D48s6YX?=
 =?us-ascii?Q?M0cygizpHSldBB4Gc5vUkNWVKl2//G6BgpRYOTnNmmpeGRF1e/ROpWIm1XLm?=
 =?us-ascii?Q?8G2Bit5EYTy2YsNYrCYCTiOg4TiBiYJUJOntG1moK6xfIRN6roNIpqz2Abvf?=
 =?us-ascii?Q?hx348h3siMjQDr4Tv1nhAPs+Msg9ICP3c4CBGWG/ry2oqWSZo0oGmq/dtW0Q?=
 =?us-ascii?Q?0h20cic+H3Gl6uruuP0Pz/5DOp4Qbd96BrnuNUuUsT8CEV1E3AOyLA+SSw95?=
 =?us-ascii?Q?U+lLAWN10ADsQm68Xiq4ab86u87GciWCj1knHwnpmOD2I9M6RI+6KLGkaaPq?=
 =?us-ascii?Q?ep0AFCRMCr59ZGvys9DaVDA/XxFzruhoxQeWtAFE3VY/bdKMenJzkxyChTuV?=
 =?us-ascii?Q?Y1fRfGckmvzYVLlzzJOr7YU+QPZr0Bc9KNIM4vGLZ0x9quOh8SvZc5lx82CP?=
 =?us-ascii?Q?O8hECjgrMRLLcByaEy+vrsbsXKbSf+6yFT3QauQTF0xnYZLLorum+p6c2Mvk?=
 =?us-ascii?Q?/Qa56F61bb+iZ/ZDbouD7Vq4vv8dYp9ZmaxJ2tEacr8x9I+DjRRVcgR0TmP7?=
 =?us-ascii?Q?7gOAH9H6LnecFPmxl8CTE6/DsiDfYNlQwn/wQ+Dsnhy0E1pfmjcP1/fUruCR?=
 =?us-ascii?Q?PmRkCy9nExt3htgAdN9hm6URMCA9eOxHwAcYRPuPLhRSC28vhgByQ6YugFVu?=
 =?us-ascii?Q?Mv0opIwdZ3Ovj9IlCAZiDBTg5Xu/q98qFJrUsciTnSPit6o3UBAbq1kpEr1/?=
 =?us-ascii?Q?7rGJd5hJhryA5wqY6eZEFirQSqhcq5BCEVNWfphrZN/Bxm+qfeOYfoX30CpM?=
 =?us-ascii?Q?jwEIemFysGFUGyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mug+tuvu5lXBfMRy4XrrGYyIMCY23UgrB03PT52/pUpk9OCcpgTVV2x8Plyt?=
 =?us-ascii?Q?jQ0iFJJ3ZQP+v6enKHL8MZPgerKQYvrrisZqB/lXwB2NLW3ewqKJya0AIc+s?=
 =?us-ascii?Q?BciXSHv9j44nyOqJxxKrqwQ/Lq2Z/BmGbwopzlrJ4Z4p54BJyVKmhj7LltmF?=
 =?us-ascii?Q?L/VDbGz+lkqgCbVuYIUOk3hUGwbh7ubXdiHG+S418fovUmlRDfCkiCdDC55O?=
 =?us-ascii?Q?v9G19O+AsoTTP1D3/tFbhtIjlKgHKoxhJNE5lFzaGpw8FoxaWdu64iMy+2V8?=
 =?us-ascii?Q?8Z32Pc907qhpN6JrkSt/z0pUSvG7zLz7yBZFSYnwjPuGvYcXFwNt5qk6ehQ1?=
 =?us-ascii?Q?NDYvaGm0tEfwDmTtqk0CEsoZcqnkGITUITf3s6poXl5x8z4G+YIXb30iskTT?=
 =?us-ascii?Q?+syGsLWFMBmUUxDjXY/rzmvxnT8vU085O5a4wWqL45XJNnlEoMH0vCNFau2K?=
 =?us-ascii?Q?HHWQz6XuNzzkT7LYjwV2LjdqnXxqBVnywGJXK8i6VWPjitbdMz2LBrgpfv9w?=
 =?us-ascii?Q?e4vJ6ZqsDjVpD3V8k/tYw1nSi78YWwe1+Roe6xNbV6MSTgdE1IgQW4jXMO+C?=
 =?us-ascii?Q?1eY2lNUwGiQCnQvfJ+XjqE32KYlSXs/od73npopJy1lai44ogkJzU3+b7ZCC?=
 =?us-ascii?Q?s90ves4UJ9Cv20JO4a0x8yNyMlyJn9ydxsf7OK2R23f5li/TR4NJy+XiceEH?=
 =?us-ascii?Q?/OPhzwh0phQBdIfX7IIz23sP9xxcGEHTgKZlOeL/T0JxEE+YEm4O44wzUQ8B?=
 =?us-ascii?Q?pPFyCzg5iPxMs+gHy/ZZC2+0+qWGOCl7Lgew1dlAVd7jVlBB1y5wLfLUblSe?=
 =?us-ascii?Q?1F+qw9dtYxGpJ5obk3wlfU3aIVMuFRS4AHbTd4eIkiiTbh5Gb+5RPC03Nh/i?=
 =?us-ascii?Q?gniZBoSr0Vr+IGlwJki51Q2OVlMPZ+qoP+zqd49OJGsQjC9hpX6b0zOOj+TS?=
 =?us-ascii?Q?KXE/SUsK+pYrdkCVsdGCLwerpZZZgl4IvmdStGft1HSeOesYpaXn1GrlThGb?=
 =?us-ascii?Q?Pc5Wvav89n0in5YyHFl5dVOvAWVBDLOGGFm8RWDqYuxIV2ZslQg84W1XH+Z8?=
 =?us-ascii?Q?8W8I0lf/EYgz24L/OQRJZCVWkvjiaYGaLX9PFxMmzeZlelNBzME2bs0hJuuq?=
 =?us-ascii?Q?iilscL6pFB+iZBlSZf+wSwEtHbUEfj8eC7Gb6BFH0hM0ya83kzesgJnJxiDw?=
 =?us-ascii?Q?XQ02VZR5WXcSi6p7P6SthJ0ZRjri4urD0eZnHKTsrhQDN8Q+dMqMslYFmdkH?=
 =?us-ascii?Q?FiVzCBYBw3cVgIdZoAiH9mtdbU1Rw7l2xdCKkEszZO+Mb7J56gJqK4EfwJ2U?=
 =?us-ascii?Q?VayE3ih0Aq1CaxrtqyXK124GX1zPFjs6iyLv7dKbuStNk/m7/c+fyo7PAHjz?=
 =?us-ascii?Q?07m/Kn7Y4Ov3gaEUe7lpj8hrgPljz1TVS7n0l60yD9F84fwLmHdn1/OtXjZ6?=
 =?us-ascii?Q?vy2AwecFOuvc73U6LESj6zwgiklq6z8fgVeYQshuHk2OUgLkmo24LUrrTVWC?=
 =?us-ascii?Q?9jTNr87vwJ2CIbfBIgk4GATXx9z0DdL1kxg45Xe/Srk/tqQ8Ga4G53ACjCo8?=
 =?us-ascii?Q?TAVZA4jJpcM+mzye5/ls0jef0bzBy1sKqw430fAN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034367d7-2953-4de2-6b95-08ddf40b8b49
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 03:54:17.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt2mmCpoOfCYvaIiIeyjVDpvskNhSyxxoZgeDs8IrQp9iJGkR5ffNiA0HBNmHzvZVu5yIbdXmuzYPQ4xlSS/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693

Add one more reference clock "extref" to for a reference clock that
comes from external crystal oscillator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8db..0134a759185e 100644
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


