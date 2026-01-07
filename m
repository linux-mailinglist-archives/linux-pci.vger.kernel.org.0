Return-Path: <linux-pci+bounces-44135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B991ECFBEC1
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 05:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9C2300F335
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5D13A244;
	Wed,  7 Jan 2026 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rbSYyuqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021080.outbound.protection.outlook.com [52.101.125.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950F79DA;
	Wed,  7 Jan 2026 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767759249; cv=fail; b=tQVLixpOHPDT4sZwrtUFV9sW+cMiGw4fmibm1GL4OfyAk+yfYorkygBBYVz2Av5WkaRnlSMz/XEN5eyTENxa8E4izkGMqdisCgQfDCvDAaQpS2vkrHpZNxar/ziWawBQS8mApgY6GDHQReAl0hplt5a9J0Azbw6TUGSFyBi253c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767759249; c=relaxed/simple;
	bh=mlEIf/8pplHSDKJWc5BD0HvxFEqYK18GDErAvCZInjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N7GKi+HPoIwIU3p942YpCDWGXZj6FU3uaL05FUcDfR5cLiZhCMU9sTuE6apOUMNnw7vgP+PNRwMNoj6YlAQAWg/Om8oyxANNqcsOY9b0jjbLV6whOqwrZcJEK9ks4GNgw5gZ7FAJqmY1+6Wjk+E0Wklj6aBFVDdkFs0iq41QkiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rbSYyuqh; arc=fail smtp.client-ip=52.101.125.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weVs6Cl5y5B9behDVR3BDaynk7CUCPSkywUB3PQLS1aCbcUDsoGPf15SpkdTTz533HeNtQr0gKYPKSxH4L7XyM5BFfpzekeAncwOsDDOcQObfDhaT6sRKlYSNDZNTZL2nJTzRh9avUj7jJV7xTLH7Lzm/fq4MNDEwE7eKFR8WzquQQ+Bkro7mcsxz6RiTbJz5OIUjdP8EHbFJxEzMAF9Au+PC9lCduhJAdD33CmRe68KGpFezHPsMG47/Swcp4biecal0RUf7aLwFFmbdIXoiVkbyrbkj7zdmQa9fDcryeSlul5ei92JXKquZPxaaO2Zt8PShFANzxJHK+fevkSxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czmnNFgXNMLFM++7aDoFu+wfAZsexwL60YTwr+iiToQ=;
 b=QLpogZvsQlj5Ny+ZPYPGv8cU20ivd4dsb4wwBtQvp2Fdu2oxMHt5ZE6GZZUcDlUrw+pcwqMRKOyMEUAxrtyF37T3cnilEu4a4hPjxpbSemLYjJAhWQ4EF2vqk2sDWrydajt+zhiMNH81ywc2lMm8yIVGY75PZ5ZT8hjlZejJgPbcXbHIXC40bI5j6YoLXlARdbN6fMLuC/NSXLLoQxuadG1Eq/kFMZdy23tRYwUiQg2WJM3W2O3LqxfSMYL7lT6BgB3Ow1F/KxvLBMghYyG2fE3KjUMOSgai3VCGNFdRp0HhEeuLkPuE6t4LteCFPUtQrpJb3GnoexboK6GnYCFing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czmnNFgXNMLFM++7aDoFu+wfAZsexwL60YTwr+iiToQ=;
 b=rbSYyuqhRNefvU+F4xgmgVJmUIarz/4bgRsN7z2FDqO/4OG6InOvMUVjt0x+Z4uQOsK4J6iIm7S5vFG4WbNKKpuU+rfgE7GxN5Jm1xl0M6C27uIyJDqMzRLBTSzJam0Ew6Tgxtx6FtdQfQKUJOMIotMfHIpCWpED6JyGDumo8Oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5904.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 04:14:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 04:14:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: endpoint: Add BAR subrange mapping support
Date: Wed,  7 Jan 2026 13:13:57 +0900
Message-ID: <20260107041358.1986701-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107041358.1986701-1-den@valinux.co.jp>
References: <20260107041358.1986701-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d92c312-6dda-44d8-e8d3-08de4da3306d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QLA22ggH/Dnu6+m3CTI8faujtCpECF7VWRD+JIOdcauSBx6BejSS6RbJEa6T?=
 =?us-ascii?Q?DNUU2waKoJs91hHTddYtjAxEL/0muLLzKXTP0Q4I8ESpeS5Y+D4mELCi9V4M?=
 =?us-ascii?Q?CFUEDuvBdCGnKmsLwtK5yqwMcuPxzwde19qAv8REg082hh4W4qu1OzXAEMKf?=
 =?us-ascii?Q?oQ0shUR6FpjkjVNk60IZwNdbNmw8zVlkLQ5Wa6MM2KQqampYi3MvJhduOqr/?=
 =?us-ascii?Q?r1c9yD7dxn9jJtzVzZY2yHtGmzCYQiUNaWpW891vdC5fto5kRIN8gsXZPXuH?=
 =?us-ascii?Q?Gh/vUlpFhQpuwwxNKWsBoiG3sRENFHuhRdP688turdAxakfbT0yMoZ2oQvw2?=
 =?us-ascii?Q?AJTaEenX4wTK8AMD9/6Or/oF6eAuvTf4ze1iE1YFmD9oN61MoAJpPct5txdy?=
 =?us-ascii?Q?w/aJtTfBZamyBAck7SdUhdfhI0U8mkcgAjnovVDoZgBBM5sm1Atz5HeXZ0IX?=
 =?us-ascii?Q?8Q2pKR+R78tPJ48hnerGmqwMf0MK9Qe2vb7cxftmrtdlmnaJJAviJ/dc7hTf?=
 =?us-ascii?Q?J/z5AMWuCP+iQ160WA6+TImoLGX0SybTrSLZ51xB/Xlv4QrvIpEIV+zkxlK9?=
 =?us-ascii?Q?Z0xMrrF3sL6dJGnlvFB3w7V5mF0ML/d0AeEJklSeT2HrL3MZDa77cOfsrsJ2?=
 =?us-ascii?Q?mYcN6OFuRFT5X6x73uU3e+QTLUy0s2zLCSnylH/QFawW2WpSBT+T7Ds9iHZ3?=
 =?us-ascii?Q?ViqURa+x8TjoRtmk0X2Kjxd741fjcwKUkLXL3jbQjMdYd34TKYSpwuiUm0MF?=
 =?us-ascii?Q?QIIAKWkp97fQJAMkhg/cw5/8huKezeXex0Ss7EvXt9N22iB0qvnFLu6oeV7y?=
 =?us-ascii?Q?4pYtFURN/gnN8VLnqhu7QR4xi0X2/jMAIw09lTK9U9Uh3UUaQptCEMX972xb?=
 =?us-ascii?Q?FEIRet8of9pWNvq1ViX3IYoNdZQ2613/PGGbgl4VIunrLHO0GWDFOIbb7fzc?=
 =?us-ascii?Q?lbFnV9w4Q95E+iZQ35Im4CuMO229Jm+oE05ZEz+8y49RvdnHR3pqsnLy7dj8?=
 =?us-ascii?Q?sSNC5IUphDQ0g37udr2Ad8xI4EjeZUqVE4DonL8/0omr8Ktk9ei/caCVUx6p?=
 =?us-ascii?Q?GnHPz5xVxlEOFbuZSo58tJR2OABMDCnzfHHYuzRONA269MjogauUr1UlONI0?=
 =?us-ascii?Q?TtvnCjsVtYw7AJn06dP/EBN6DHLizFuy4N8ZosWQufO59aZAMhlj5Ki+MIC+?=
 =?us-ascii?Q?3CXmmeRynK4/WKlY4PR9NVf4gr0S0vKzKdutLK4V8Aq+zc6e2P3gIK3uhNcg?=
 =?us-ascii?Q?3uCl7DCsyjS8gkdmxL9pibL370kGs5Ylyl4RksFX9nqWY6713qLXIvt1pPPc?=
 =?us-ascii?Q?yEBQlODL23dZIW/Xfehtf12gnAA6qDZwKOnrmW8Vm8jHUrwVnFx4JqjTauWN?=
 =?us-ascii?Q?EFVHLOsawM6CdXkZpTTMHKdZ0lYd8emdiDqDGkzIEd2q8ZzLcuj3Wq5H/NUk?=
 =?us-ascii?Q?DVrj4ep2rPr55uhiS22xvGEK6rWxt2ME?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ZK/4vz4JgDFUrixxakryjLDyupYZVkf9uuwEOzZfWseqYO5ZCN0ShHJb6RD?=
 =?us-ascii?Q?PnQEcS/bOvynR1WVV+7TqK2ZeyJkcjmoWx2nEsbRxlZG1Yzng/jdeCscGAmP?=
 =?us-ascii?Q?7OIrP3KvlInrzsH3c2hOBOqi4UHJCFDChjKokZEVpnW7T66KtAB8CAQzoLuv?=
 =?us-ascii?Q?D2lndfNwfXvTubQdN80IpHQwhiTgDPErhCYudYHw1F/zDm5godBMEOPADQfa?=
 =?us-ascii?Q?nEzGrtc7RFQu1ubCVxiMDZ8WIEgWCN5o6Amwllsi+bIpdJyRo6Px+omQ5xTV?=
 =?us-ascii?Q?yxLT6axwET3FL2LvWH+XovB50xfofpUZOnBfcKw4Nwyx3piSJymhIOfoVeDb?=
 =?us-ascii?Q?imYoXHaE7Qq1YZhDZBCXbr+CICidHbf175CMaEoTy4TgZoVZttDsWG8arURN?=
 =?us-ascii?Q?tl83wNwD1zhPvqNG05ZnMbmWYQAVyLUi10QVGiCagt41iuAgUlVupSqe8CaS?=
 =?us-ascii?Q?kYIQqPGE+CsmJC8o8ymvHf8HSZe6EhjMOSkyl4Qw0P2oVUsk9YIB8C2HSq+h?=
 =?us-ascii?Q?2TtjLox9WGQBef02stzGDHBf4fi0QiV6r+690n7oNlBqydZeF6vNdd67CTKa?=
 =?us-ascii?Q?DBx0GJmUbamPQ4IZj8ef04AwfjF180W6yKr0TCYkMssgTzZHgNC6fYwbY/oZ?=
 =?us-ascii?Q?gogAJbPSnC29aPnHLCNFbenKZcN58SbXR9v+zOrnpQt9Am+teYqdTSejsK/g?=
 =?us-ascii?Q?MHky654LIRx1HXlzzZHbJwZg6889EH+tljzoH0F9s/V616wj4snzp8+1edED?=
 =?us-ascii?Q?kIHfg313Dm1a7Yg4IzYapNYIh4Gayg1x/aoHM0nQgU/c5fzEYg1xsHyZQfOY?=
 =?us-ascii?Q?DkuifCed4O50393uDvE/Q2hrHhIkhQnUzVmEA7Ta6X9n8maNQ996Jt6OkJAF?=
 =?us-ascii?Q?zG6/FMCy88EwNj2qoEVkUrXaZCI932O/tFI17d3Jx+tmGAQwWANLUUqomybs?=
 =?us-ascii?Q?BnRH0/KglaKHzyXz2C+/oooMt99/lFjImIL/K08Ixi0mjbuvQDc4vNp2zdBM?=
 =?us-ascii?Q?WdHHKm+UQSGdRXkVlHs3Tg/v2gAe5eNd98UrCfCu57dLfYI/G+H3/mLUHw0y?=
 =?us-ascii?Q?dXHmCpUSlze7jJn4upmawEaDFAbYn4O5aAfG72f10HtZlm94gTWYhV1FUWLu?=
 =?us-ascii?Q?jVmoQbL9bfZuTeCFhVCqgb1BIg/YDXxBoW2Gm6Ci5xjK6dPO44iAT0V1lJaI?=
 =?us-ascii?Q?rrPIgyngJyj8pQyAlTGnSjcGBGKZ13p3g04dvoun/lpBGXpc0ItwGyzbJHOA?=
 =?us-ascii?Q?jpiIvBnlqPBlwQX+1Gj6VCz3E+ygyRxnPgbUq2Jc+V8Dn424Fuj9kAbsCp4N?=
 =?us-ascii?Q?S7FKMkIK1AK/75lq8oBuiNIOCFT/A122YJW9lsznOCZQVoJ4auBrZIUYXJq4?=
 =?us-ascii?Q?cPPm8K7uaw2Wjb+CLYGLFUuXsAX9lFW14xqjySbiShIKQjhBVxZH4HqRn3AO?=
 =?us-ascii?Q?Vu248bnkDhP3Jzi2m7kPXXNcJuS7yv8PIDYJkZk4s709wpBi1ri1PGMD1wfG?=
 =?us-ascii?Q?OccY+px+EkJ2UlPkqItcMF097wd1RdbQGHG51ue/xEmUsq9WNUjU1erNCZ6L?=
 =?us-ascii?Q?Ixr4SoXT1xf8mAjt1JL04h7xycCEH3+v34VSbztIczSLFqfWvJyClzwU58Kl?=
 =?us-ascii?Q?vKydvVr+oQ688K0U2zqY3a3m4YpJO8BTH96ALPZ6YgsbAkqqb2Zewp/THJCT?=
 =?us-ascii?Q?WY66wo/s21zui5LsgffbT19f4xCC/MwoBai3Ju1i84vsK096AWyFGyDAuDii?=
 =?us-ascii?Q?FHBA48Ox3PP1i2GcKJNG6SBnxRTU9DNUNgHwNX0+OtTsZ1VonXNt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d92c312-6dda-44d8-e8d3-08de4da3306d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 04:14:02.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8NZ+IQfE6tlNJNaxmLDGipCVid6j0gV2ymzJfJOcJLjAhJRPyZBgNvxCvmIdA4exKaM1F+Mv/zT9lCpr33OhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5904

Extend the PCI endpoint core to support mapping subranges within a BAR.
Introduce a new 'submap' field and a 'use_submap' flag in struct
pci_epf_bar so an endpoint function driver can request inbound mappings
that fully cover the BAR.

The submap array describes the complete BAR layout (no overlaps and no
gaps are allowed to avoid exposing untranslated address ranges). This
provides the generic infrastructure needed to map multiple logical
regions into a single BAR at different offsets, without assuming a
controller-specific inbound address translation mechanism.

No controller-specific implementation is added in this commit.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/pci-epf.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 48f68c4dcfa5..26209c7a6af4 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -110,6 +110,24 @@ struct pci_epf_driver {
 
 #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
 
+/**
+ * struct pci_epf_bar_submap - BAR subrange for inbound mapping
+ * @phys_addr: target physical/DMA address for this subrange
+ * @size: the size of the subrange to be mapped
+ * @offset: byte offset within the BAR base
+ *
+ * When pci_epf_bar.use_submap is set, pci_epf_bar.submap describes
+ * complete BAR layout. Subranges must be non-overlapping and must exactly
+ * cover the BAR (i.e. no holes). This allows an EPC driver to program
+ * multiple inbound translation windows for a single BAR when supported by
+ * the controller.
+ */
+struct pci_epf_bar_submap {
+	dma_addr_t	phys_addr;
+	size_t		size;
+	size_t		offset;
+};
+
 /**
  * struct pci_epf_bar - represents the BAR of EPF device
  * @phys_addr: physical address that should be mapped to the BAR
@@ -119,6 +137,9 @@ struct pci_epf_driver {
  *            requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
+ * @use_submap: set true to request subrange mappings within this BAR
+ * @num_submap: number of entries in @submap
+ * @submap: array of subrange descriptors allocated by the caller
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
@@ -127,6 +148,11 @@ struct pci_epf_bar {
 	size_t		mem_size;
 	enum pci_barno	barno;
 	int		flags;
+
+	/* Optional sub-range mapping */
+	bool		use_submap;
+	unsigned int	num_submap;
+	struct pci_epf_bar_submap	*submap;
 };
 
 /**
-- 
2.51.0


