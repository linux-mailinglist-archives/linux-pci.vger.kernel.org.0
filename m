Return-Path: <linux-pci+bounces-39119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38755BFFA02
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BC23AEF19
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96682C21EA;
	Thu, 23 Oct 2025 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TYst9UIl"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011018.outbound.protection.outlook.com [40.107.74.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496782BF016;
	Thu, 23 Oct 2025 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204162; cv=fail; b=X3T4X96yzWs0QpNKGfekYhPMJW0vgWwhQmjZUYBjz/BbXwvaLOZveZ+kAKQ6EIhSZQ/PqmtWr2oKfRZpvUspKggdLJnLfJcpIhDyAucqcCWZetob19mR0fjR0W3ZFpSDYnUQFIeYtusJX5yTqNJdLo6tKihO9o7bbHxzsR5ebTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204162; c=relaxed/simple;
	bh=j0RbVc/w1A5+67juDnqX5T63O/pkzOqCTEano98BZxo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KAKkMVBU+oO4OzkPpKmehtVuftmHLejD3IteRUMVtS9K1q2gpxGa1bTWvAK3Y1eXCCooGv3+3EGmGZM/avm+IyNl973nB7njpOIpib6zpxIi/QuuufExHG+yJ3rsd5c39KURQzNBYZhxly/f0L3RvzzaacqTMo6p+FKJv1A+t3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TYst9UIl; arc=fail smtp.client-ip=40.107.74.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLL0wSEVtkD2rjoGIzKoUwFSWnfbLzrGbhh/a+YBrlN1XYhAHudcTG5pF2R3y6wnOcEHulT74q8tihTYLfWMVOMK7EzR7E9JuDhcsRnLmC/8QyKYoNdGgTxx232KuqGGud9FE2mNudaYCtQk1V5J+jXkfrDqtAC6fzPl5eFavq5clsgeGlgqf8x57XJs3zNa2jEu9VKUnsDazWWSxUtnNQ1N5EpIwAJ3Ppd/iFAOZxfAwkAYu9RYPszkVHaXfVYLtxapm5/7MXvkMEWuxlICL9l4lvooGSuaqFeiMXB1nw5WXB3XmUCpHb8nXP6bxBboEkSC28rUwkHSeAvVqo1PZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FJRbf8WJqrSjuh3efEqUMf/ZQ4YzhgWaOqcb88zv7g=;
 b=Lug4iDQv0ItdPQk7wX7YATNVG9GuH2H9Ned1DguDYpXZ5CnZg5pncRBk09wnUxa4Dzxd6ldNve75S202Xa4SKyP1+lyVWvFY+e2myKR1CF4gedlwS17xciGT2QCNszvDYAr6Qjva+8EpaT4AGz1hLVeMqdbYo1x7jnb+2XbIB5XXfydQvW0ynhBBku+pjYNyZ0ITu7qPEvlql7K3MdHZMFPU7LH96DKvgHRHLC70sCkHJyXxwXgw54cognAbqbZcEKxiCSyuqL1AZgHfSuaeXa8y3rhtobkdW0HGSnh38PeivaB9orp/qZxFTehITDqCqfp6OsvLyChAGBUhAubAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FJRbf8WJqrSjuh3efEqUMf/ZQ4YzhgWaOqcb88zv7g=;
 b=TYst9UIlQ6wwynatthVaDHebpuvv/5TPXvO+BmGytXtXcXsv63dPKkgAnGOmqwlcqYOAxDN6XO4APY/2YOeGz0aVth9Ea7dxSPBpJtKhlXgRZfQSkvB1EoJWrfYWP6kbaERQrRTP49nMxDU8GwXD074icvOGFhOTQOB05+GeO+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:22:39 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:22:39 +0000
From: Koichiro Den <den@valinux.co.jp>
To: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Subject: [PATCH] PCI: dwc: rcar-gen4-ep: Program Resizable BARs and drop 1MiB BAR limit
Date: Thu, 23 Oct 2025 16:22:17 +0900
Message-ID: <20251023072217.901888-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::9) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d00ed10-25a9-4e1c-cdba-08de1204f28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jrxTKK3JGbVa5cffXp0ITAmOodHytaR5kZIjXhToZ2AW9kxSsgRqCmj5e2Xq?=
 =?us-ascii?Q?uUW32oD2yoA1u4ASGYejE5jwJbKaq2tYcoGuMtYVyD+OepDqVFyGlBPIlHBA?=
 =?us-ascii?Q?Xr00o9ojJ5oXteqlhVVNVLTzhbgn/sZ751t0YXS6PKzkL6EEFGZkZvc+Q96R?=
 =?us-ascii?Q?Oc9wf7ZL/TYhjtMbtLgfMxT8VtX5WbMBe5ajv1FLXL1tp9RgKKCMccQQgNZ/?=
 =?us-ascii?Q?bDfL+/wCbTc0FAlcNqHAoWb+5jGnkjC2uBHQ2ZtqDmTke7DRu3HGaweeDtVj?=
 =?us-ascii?Q?Q+NJ4cCbM/pWMQr1+J71H0IS9F0sxGQXBg/7pu/xnKZVqnIfGXaitpfua5sF?=
 =?us-ascii?Q?+MYVp4ojX+C7h0h4bdWKh0c+W7PRs3efeBYBYcEWFTtWhb5jDDI6HTnJX+jN?=
 =?us-ascii?Q?4aFN3v1QXmfVFlNU1vKnefVybPHwSNaaZs4vFagA5y9ok/67JryVDxXNzgOL?=
 =?us-ascii?Q?5bCliP6nLjppZS19yX6EqH6GRqGBx+aWVml2Pqkxfllb2lFkVB+dErDKXyFY?=
 =?us-ascii?Q?jlXTg9hshcbfVOyHL2lGXDJvEykiOeiUK7hxEhe9eXAB1avPb5DQ7Dsbu3uw?=
 =?us-ascii?Q?K3pEhcwy4XE+JC4dM9nZWF500oLCOSZghxo2VWMLsbrGaz1mxF6dBZqStEYe?=
 =?us-ascii?Q?MSYTIKw7rO/Y0Yn/PEVqGmW47VlpJZIaP4ZRu9jTrHeHLTZhg36s8fnQ0Tk3?=
 =?us-ascii?Q?nCXQCMIexiRHBj66p25KsRrr5Ho3WrKkk/stjTWCzs9EB3gT0kArtv6ha60U?=
 =?us-ascii?Q?dp3aVNKrMsR0nEFslmgdGmSWAlSjHej+FqAAppZ5ZwJDc3FBgrXC9GvSw57D?=
 =?us-ascii?Q?IbEMbObZtV/ENZeAcVyYYdPdzBy/gWNewDTEE6s70Fx+AyTlXiv3KuEzuCeI?=
 =?us-ascii?Q?bz2UHllupyFUdxBSd3rM5UejVIUZ+DLxi/d3XP4iy2fmcfRCCFSFl3bPnKX4?=
 =?us-ascii?Q?2htlYAQ7UXBb2UHHa8E+AusFr6hfLrIpwdxcZWWouJNnDHbiMnBA5rMnwmPi?=
 =?us-ascii?Q?dZuyyAQJO3WrJ9hyEBfaBOb4Nomb821/FPlopm5q6j7kgnJ0/rCYzlMG0NPw?=
 =?us-ascii?Q?RqxJhWEssnIXw187LhVWdNor5Jh66JaVH+FD91sUWpw/r9i7ipkHBd3m0H8Y?=
 =?us-ascii?Q?dMXg4pDE97EI/CGcLhyJBBTX3rWmZnNmZ4YXhMpaj0/GeZ7Y4zccp6OjrOSv?=
 =?us-ascii?Q?R8IEvJQm2MEpa5uQf3YKf1jNSG3a4TtGJkZlGF7w/kqTApAme93wqz/VqaZA?=
 =?us-ascii?Q?cXTSbeKPsI6MlZSPzwmaVMghpiCBXV/REkhUz3VFWGMjObf3SLq9tgRiobvp?=
 =?us-ascii?Q?no9QMN0ZK65SKxwybpO094fw4TMv1Y88uowP+ktk3YHJd66yuCGOaGzA1cLx?=
 =?us-ascii?Q?vwlLaQiB4/pLo5VIdtt7/5E17uw9lpUTl2EMa3XG41zB37PyAaUVHOX2YGRv?=
 =?us-ascii?Q?uJPtC+4z9LJMgIfnxljcnlewvjokQ0j9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UBirglBtXUba/1+kS8pyARlAMtfLX787jWjSAO5q2CpDCjDRzjczKykRbvO/?=
 =?us-ascii?Q?YnE8YAViLJ7dfrd+cyOTZOiLpZQG8rPJG90UM1L0Xr38kPGredK5hmawclLa?=
 =?us-ascii?Q?HcHpGHgpe9euHt45EC93MzLU0x7ssmgsFtheo3qBgLlDh5xj68BEG12RPwPa?=
 =?us-ascii?Q?/q/acCnjFpfdakfJT1Cci1luNRCeBb5iGKD/MArDp2E4UGVsHxN5INlAmwia?=
 =?us-ascii?Q?5yj1jJa/9bK4UgtMuGE7Lnwn28w7p2VwFz0ANdUKFdS3uov2LYtZSWmkMN47?=
 =?us-ascii?Q?hnb7La0eNXtIxcev1w3J9OsOwW5Mw4sNuqlaSvH6MB6hskKDPIK5pUFpS3rI?=
 =?us-ascii?Q?QPc2xxjbYf0L/HGXi6fiacfLLpivWN4BK/BxTtPt/Suu0OkFCcNAHQ0JwZZV?=
 =?us-ascii?Q?wYmwhss856sfErDKP6lTzI0irZbHSVpMO9sAv21vv+XNnIaJnNm3SnXWaRD6?=
 =?us-ascii?Q?jGuY64rGJ0EudPtKS0NrN3ulzYOTZTLGGCt2Cu5UwH1etmINyLnxyKj3MGU2?=
 =?us-ascii?Q?NmenJRDGHQFDuzYBiE+mazv4Lf9UQ+zsfbnEwba5DU2NNaPyw9PY6A5TH+If?=
 =?us-ascii?Q?5PE0lbgvQQH9lrZO97FGQcfy3RTJ9dU360Af6FgDyYCNH/XfSLBpG2qe7fAF?=
 =?us-ascii?Q?ID4P2qHUkf/ZOqdn5WUtka6vCt5Om7JJMPf7uidwnfUssq9//uLO1J6OcGXk?=
 =?us-ascii?Q?G5UH8cxwTBbalLDMaEGXzJl2s3LlujYO0tfFStOm4m3M4n4Qy5QnHf+PehkJ?=
 =?us-ascii?Q?ktnyIPAGJmcsCUdoWMnGQVJ94M48lj4YmcKJ+44f4CjAzjhxY7vQc5imJpx1?=
 =?us-ascii?Q?pfdswuDQ5v+dM91V7/HFXktLAscwOwbn44mRwE82ztWGcQ5DZJhN2A+a5nOk?=
 =?us-ascii?Q?fcA/CCaONCm1WQHOMn4y2MHTX/weJyV/qynu9jQx9g1KmX71yx1YFoNFoevs?=
 =?us-ascii?Q?QEDx2i6dYTUhf9RYButIf/I6YAyueIb5Tfkf+IfgOKm18hPFPy8txt3IGugm?=
 =?us-ascii?Q?genFpUuis4knmXMhPtnb3cpmHEHRvxQafyJ1x8zqJUxevG1fBlzo8uLf5xcO?=
 =?us-ascii?Q?yuMdW1g0cfGJc6OmVXzoANYg/6QrfLfe0erors17/S4605+zjAojLneEUOmI?=
 =?us-ascii?Q?ktmcw261RpedGwk6W6G2/Y/L7D2SYLpmIm08mUK4uwng8FC1j73k9MpvYuZe?=
 =?us-ascii?Q?R7NskNmAdbDKdIfS46BoAF8N//qBLy7mWd5uJyvv/PwogAGNwfpyN3blJFZR?=
 =?us-ascii?Q?wi0COKqs0yusSc220+TYD8OYZjJhUZP2nlCakTHXq93aS3wgpKjo3udIPxJi?=
 =?us-ascii?Q?e9qru9N6dP+ttGDQ+5Xfi5QjanvtqvReYpdayaoALu/e5k3K4axTYup+gINo?=
 =?us-ascii?Q?v72Hy6n890gANa0ZF4yaxnC7oGAYLICjxdhgwAa5+cvCXkyFxHUjvlqfuGeE?=
 =?us-ascii?Q?rUBUjyrCM7WlO3jh/n2pEJa1jOdr3aT/ee9Nu6VsY5bj/RHt86qRtwSqY0h1?=
 =?us-ascii?Q?+cHa2mGzL5FK66LG1EOTfT5VVK6MbwZNMn9pusCxwaHhEfaOaK1py5bq6lJD?=
 =?us-ascii?Q?+QGCxXNxgtS8BR5Y0N7EfiYarZPkFFLqq9iw2fUrUJ8dSuF/29msyYubEbpo?=
 =?us-ascii?Q?Xf6tN8X6SokPo7omKylAQBs=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d00ed10-25a9-4e1c-cdba-08de1204f28b
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:22:39.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqi5MoxS68E1pNEQXONRjb6BQ4baPtVOahm6K/8Bc86QtmUdlIkzz88fBA317w2G8ISspMy3oPnG1iwvHrXUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

R-Car Gen4 (S4) exposes BAR0 and BAR2 as Resizable BARs. Program them
accordingly by using dw_pcie_ep_set_bar_resizable() instead of the
programmable BAR path.

Before this change the driver left the Resizable BAR capability
untouched and only wrote the BAR register, so the RC enumerated BAR0/2
as 1 MiB regardless of the size requested by the endpoint function. For
example, configuring a 2 MiB window for pci-epf-vntb still produced:

  ntb_hw_epf 0000:01:00.0: \
  Size:0x0000000000200000 is greater than the MW size 0x0000000000100000

Program the Resizable BAR control so the RC sees the requested size and
ntb_transport can use larger memory windows.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 80778917d2dd..dbad741b8286 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -421,7 +421,9 @@ static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
 	.msi_capable = true,
+	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
 	.bar[BAR_5] = { .type = BAR_RESERVED, },
-- 
2.48.1


