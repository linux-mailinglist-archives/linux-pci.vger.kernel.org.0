Return-Path: <linux-pci+bounces-39092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8CBFF84B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D0744F0605
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066012E2EF3;
	Thu, 23 Oct 2025 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="V96vMJAo"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011031.outbound.protection.outlook.com [40.107.74.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71F2E7F1C;
	Thu, 23 Oct 2025 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203907; cv=fail; b=X2sd1Pj6la40RhZbYen9sYNi/ETCkVWIp89PAcsATL+m6Y4hJPP9OtqCkpd+04VFA7ae8ZHYYQ4MXM6KneJXfkD+wKwfqx2q0Ym4UyEdwlscQuvqSRNaKWmhxTcfc4+jkAgydD8nIzrlLjM8rEpo01elyShobA0Ua+zfmXhAWFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203907; c=relaxed/simple;
	bh=2A1cb9SPF8hGk/UXIKPp01bJdfMC0Tw/ns0auddf+H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=prJETTvYxiywFhORYiiC9FeiXgbq6V7X1vZPxl/zc6BaEY1y8aYrj8sGxtQPA2uHJcw5K440on92OnWJ7M4kksHk60tm4kZdVS6mK4wvOL9g3Q4jNdbFjdRH6ikGyvrx8y8tsHbap6XKR4M1WlnqROR4qITi9h9hh1x1w/r8aD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=V96vMJAo; arc=fail smtp.client-ip=40.107.74.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQ6ibW0rSEx/Xt3D5VdTY0JW9bxtt76xSW7oK5DuIzKYSvN4gkY7gXDsgLiEZdlFlDHv9J8PSBOXRnRVpm8x3F98q1sebek80WDsgOdJO/RTO7/SDWfCTmKsONkbT8KGlmCra0+XtP1U3OZIzSwhG8zWjLUn2VPSKFlmvoGYCbFhI8Yrhy09cXfJCtDgIVpoOW+ckbPKtUJuEFn4sWXy1iN/91UulNIVNHc61TEryoLy+zDymvepprPGXa3YFipdWTtIUOs77BRsr22Y9s01Hs9DKv8lDBMc4Mj+ZQzppzRioDl99E5RyIObe62afq0PENRxEjC2HMtA6r51nuJ/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsVzujUiNAz7/v8l2f3eU4kWhBeMH4KVdpSjgldoz9g=;
 b=MLb5yC1awsUwD//vlno94UzAjhM4zTy2Yh+XuhvS3ThTHPAQme0c0hI4I2/BDskKukLJ+0hwQ+H9iFzh8DVMAtKzAvVjin+ibmNJ+7SqK0EvxcgJ6TKkWHn9WDN8lqMGnfESTdlOLNIEa42GCE87qXev4/bwd0fJ/Bg4K32zEGFFsQjYdRW1kHBRW6vQXX8E2CKEjvhCMNnenQiw0K5pwT5pBlK22pKdKTlbXtxBwHmBY+ndBNX1IGKTobKWH0mxprPhRi8RWM/upHkeN6vqlwUo75fpKzI15YE/Fev5AftHBR3wWuMPb3q8/uVcaNBqBaBvJNK3oFrqHEwIwzlcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsVzujUiNAz7/v8l2f3eU4kWhBeMH4KVdpSjgldoz9g=;
 b=V96vMJAoO0wVlFXi9RR190VdxSlCZIyq5bXYoTOSiVXIPjVUYdNg5CfuwtfvAetKgGcsg4rM8qRfj+xnj49Ow57NlBt6ZnQqcSa6PnWtSzR9tM+NLQWATj76cFkVgG4nGI2Qtii1TmDYuxk72RUZFja+b67W1N6irUFcDqR2uH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:18:16 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:18:16 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de
Subject: [PATCH 5/6] NTB: epf: vntb: Stop cmd_andler work in epf_ntb_epc_cleanup
Date: Thu, 23 Oct 2025 16:17:56 +0900
Message-ID: <20251023071757.901181-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071757.901181-1-den@valinux.co.jp>
References: <20251023071757.901181-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::11) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3b6d82-c02c-43fb-98ae-08de12045606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?16hJ7LHKQr4sybKEc7iyAXSAYbmUFVwd6z1Y1iyRPtMhqylMRbNxqjy4qUD+?=
 =?us-ascii?Q?w97g47//zlj4Rbi+UWVWjZbo7+5/0aHRe/MQVB4LK0+hbSi5spx+jZHhqsu1?=
 =?us-ascii?Q?DgGMN3jzfVy2PTgTrdFJqtNjpbs5E3Nq8mVDC8xuHfT/iZPJt9U64s4qiXbo?=
 =?us-ascii?Q?KdY4iNKZ2Gc0CJ5ydEbhtSLfWOwm9JuOJY8MTXztxEY7hHynAtd9uij6cSaP?=
 =?us-ascii?Q?t8jPdcKBpDMzt7QFjiUD4F09bZ0crGOiKJxUvBFSvX4qaB9U5JrDZ41tFHcE?=
 =?us-ascii?Q?bl8Nn3JZhJDFUaxKAKOOGejZtHPouDbOywupptm9MAZeEEHXqXT9zkRFIjdy?=
 =?us-ascii?Q?oak7BO+lJyUbvxqza4/tk+8wmIBdBqS7O8FOX0fYBAJYfEx91w/RsIFFfP5b?=
 =?us-ascii?Q?E3VZPZ4tl+JyQ3gap8etN38HCt72Cppb5XcqBInaVKrivyxj3Js69N0daoUs?=
 =?us-ascii?Q?HXIAkUPJLSgTWi/bmbbi1zUx8b4FCPvJ5MHB2Yo8ZMRgNtZqQ+2OagwX5HRs?=
 =?us-ascii?Q?cuY7NmUUlFMmNMmgtB2ybfWkPHzbNwKTF9M7Gqz40cUNwyXXzeznNnc0Dn26?=
 =?us-ascii?Q?wgJPJBYQAYrObdtHxORW1zeU7SEtr/Q1Ceu/0b8huwjbeS0DFFMUcaCyTSMn?=
 =?us-ascii?Q?hK9OYlChqLTvnWSsN1nNl+IxlO+XdawFbNdWq9wFnOfCUu8QjYh33XxWgUGL?=
 =?us-ascii?Q?rtm8uD4cr0IJO0sodO8sS8VV2cwzDcz2kkGvf9Huwbzu91rEz9/qomVDz4Bt?=
 =?us-ascii?Q?YD0XNcvmoOBSs3y/QL7/Y2PsDVDSXyOcvpzyYSN9eiq1v0SaeL0CYQ7Ycsxd?=
 =?us-ascii?Q?ZPPc5kGg8qmQh2CcpEXLWzQrEWhaS+MLTgcvtMS0cAPb2ecVz//bDFv7ZOJB?=
 =?us-ascii?Q?e+3BJ3Ty4qTNcgdua59vR5XcSTAQEgvvw+EchBSacv0mFiZS2R49KHBg7rvQ?=
 =?us-ascii?Q?tAywa7257MMVRn8ubrUlKYOtRPfOmmbhpib1cEucmX8iw74WzatR+gU/u8eg?=
 =?us-ascii?Q?3c1gz9gY70IP8qbBWSh/MuZmkiTLH0lPuLNeIfvMJnoTQndT+7TNVYRhH+Kd?=
 =?us-ascii?Q?5th+qkWXTZ+l4XLlhsNjclOa+e6Tijdwbkhr2tku5nM4HJ25SW/1UmPgmQyV?=
 =?us-ascii?Q?Ct10i/nhf28+IHzQg46BEGZNG+Dyex0sSeI+uVYqVluk1r4DQ7xLRQxNtXPz?=
 =?us-ascii?Q?o+7Yq2lmh3grFAOTNZSmaVzPxTEcp/B39kQVPQcNFNHu0xRjdF6OhbkAt9g1?=
 =?us-ascii?Q?7CMkK2VRkASSRZoZgIdl1TEf0fu1uxBBBTBLOtogN1DHx8oi7osAISjc3rSv?=
 =?us-ascii?Q?yjerRwyo8l3KFEi7RWMalNnYUv/xJ3wT6Ctr6AouwM/wN70kT5Qx1p+be3uy?=
 =?us-ascii?Q?HYdmGP1hDIXVQeTmOqZ/PTjlyvIVdg1vjURS35WHBFZQ+NBc+d21zYdPyOB/?=
 =?us-ascii?Q?WI0/NsGVJP+fdBZJ/Rp+07rKMpm/oJOP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5C/i1K4OwrjjUMQt9RDKyTEl160EnFyEthvPXFlJwpROKVe4Ihovg60FmTmv?=
 =?us-ascii?Q?02W11Xel1WNLO7caKNcH4jFTpOYsfhrcl0Emp08n9qJt11SAyaLAzpDyPQmI?=
 =?us-ascii?Q?TJH9T9SICyqoauhDBGdNqydmNC1KYn0IMIhdFhz/xGsRmDszv0nt3BkyGUci?=
 =?us-ascii?Q?ut1pnTyQRT01kf8HukoDOokyUwSAza6QOErEmFayV/u7B/OyNmaKy9b1SIhj?=
 =?us-ascii?Q?zNfm4xlyWN7REZfuG68Og4Xbh4LL/t4XkYP0hf9drJkRkrbok0lWgRgLWa8v?=
 =?us-ascii?Q?D8FIBbTOcQt0V6HZXiOALFtV7oW9/+pCj75DIUgMSHBlURJ1GjxPy0o7kNSE?=
 =?us-ascii?Q?N6nir4FkqZoUI+dv5cM9x1Z8U2ePFYlmlBQkFBbdfbsmuilWgPH8GF1hwIzQ?=
 =?us-ascii?Q?J3uAwkEfh6bXaMYM9ww4XMCy1vrmBDBDbwM1iEAC+qgrn/En0RSOfhc4Nogb?=
 =?us-ascii?Q?27mj0wisLWZwRmpM6Bu/o0JUl/5Ri7FF6VWjnSNPVBR8+XTmpYRR5OTWuQYN?=
 =?us-ascii?Q?nGiNZwE63CxEUl6FyL2cPLuP+DXH7dAiOEsyQfljT/gk2lSV5mgJ29MMvHnx?=
 =?us-ascii?Q?iA/INuPSlfRar9la796i/yXde4qdspN/iNLLq8ekpigW62bFQdeYHCfN3zkx?=
 =?us-ascii?Q?FhwWy9uoMEbZ8DyvOUrzN1aSYOGOL1y0kMITvjR2T85HlhzcjA+1d+bEUgfX?=
 =?us-ascii?Q?z7DGpbjqdSZSTvy5tmTrxyJHXgO731aR3iLPpPm6nR8GkfH9TWasYCMyf794?=
 =?us-ascii?Q?46nvwrVLnsn9IWGJgCKJLL4Ab/O+THxIC0peT4gSFeaW67fHAK/B6OZ5l82/?=
 =?us-ascii?Q?j7uM3LcCcsQsu6tulVFjeUfuRZ4sjqzDsIL/GCgS6AWje9eMxmx/A5Yo8zKH?=
 =?us-ascii?Q?HIxa2NnpIPBQbWqypc2QUw6ChVdgdQnZzkXdT3FS2bsaa0HHKFdxP/AoUUmS?=
 =?us-ascii?Q?1bZnEY78srBcqyJpxsTIHtqLeTm5wKXVhW9D1faMOWaVzEkuCNm1yOt6ws1e?=
 =?us-ascii?Q?PU7fY12tiOaJFQYAROS+m6H3EXCrwEsZrGe7LdNEgdt44XGrUryTDojWLu4z?=
 =?us-ascii?Q?v+bmKmQmeK7TxUkooix84wkt55KNBT3wDU7tepjrkNHOegzFvGa4mlhtnrHW?=
 =?us-ascii?Q?MmZg5g9qFA9JDZwOGUzd/C1afz6rwX/eZjFMTO40fMhnrwAopsLovtXBctSo?=
 =?us-ascii?Q?LUHcXyBcsqrJwWe4C0clVuJ2ETMKFA3hTm9Gk1OjVlEfKIg2mTyZlYn77FKI?=
 =?us-ascii?Q?RsA8QLaPX8WhdE/PmaALxIkmLCRlKdsA7SjqspKjHKbLJvz3nVNofAnnLqU0?=
 =?us-ascii?Q?jYuWCFxw1uPlA5Ho+YqolJUvhymUAmaRsfbZxhYHUWCrqA3q6I/U8Ed2rj9q?=
 =?us-ascii?Q?g705LeA9hGJ43+MLxT8gcnpIRdxND5TVfyzTP/3S8FmcvLdj39UWU8Z6huRO?=
 =?us-ascii?Q?EPxo1+AH7LsIQVxYcT9+PLJYLDrvcwqHEkqYP69vu7FlPQPPZWjBOH93iSex?=
 =?us-ascii?Q?8p+Rqpr1a5B4Fj/tH9icB8593QMRRxGCCvTgu4ZvHFqUboJjiippFTj6tvhQ?=
 =?us-ascii?Q?B0JBHcq0g/h1kCbrm15EEE9lfkEZPcstTfhx1ONht5i2Y6J18mXM89SRqPjS?=
 =?us-ascii?Q?uHJb83zAgLJ+nf2DYEmliGc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3b6d82-c02c-43fb-98ae-08de12045606
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:18:16.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x44ETY79mOFD39T/Hdw2SVWGVHEmXGG+qIw6CFJNsiHk3Tx2v3ACDWlXTJ3oAc6Uw+Y2K8lpvM8H8TpYvTIRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Disable the delayed work before clearing BAR mappings and doorbells to
avoid running the handler after resources have been torn down.

  Unable to handle kernel paging request at virtual address ffff800083f46004
  [...]
  Internal error: Oops: 0000000096000007 [#1]  SMP
  [...]
  Call trace:
   epf_ntb_cmd_handler+0x54/0x200 [pci_epf_vntb] (P)
   process_one_work+0x154/0x3b0
   worker_thread+0x2c8/0x400
   kthread+0x148/0x210
   ret_from_fork+0x10/0x20

Cc: <stable@vger.kernel.org>
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 49ce5d4b0ee5..750a246f79c9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -823,6 +823,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
+	disable_delayed_work_sync(&ntb->cmd_handler);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
-- 
2.48.1


