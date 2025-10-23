Return-Path: <linux-pci+bounces-39089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F905BFF84A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31E93ACB0B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD92D9784;
	Thu, 23 Oct 2025 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XG9zT5jE"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC22C11E5;
	Thu, 23 Oct 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203900; cv=fail; b=aQvcgWv4uZwTxm3A/7KG1LabgfBB+FW3Q0kVxkhB+WngEqxvbn4EtpavC3sP+wqMEcYBODcN9ao/aALBaKxBScER2d7Q19YAVJaQybHPKn1a5UxF0hQZMdxdmW/vsvrc1a0mgv2pTLL2xEKSeXUP+/8UsBhSPx55sm/StPcTv24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203900; c=relaxed/simple;
	bh=lgz+MBYCv53LRA0Lth3d4Qq4K156rNCRbUVjIEZaolQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GrTb6dGV+kBX/fhPlQ5FeRJyDGdE3x8BcG25GO8ef0Poax54lgjz3ByYZ75uime/2Ivg4yK7z0QwW7tFGC2bpWmLuiZDDV+lfwTViVlmZ9jkDeZ72RrRDF3nNJRFua6WN5ovTWK5RQFTIdOyIhZ+S1ZyMHEno80TKj/uu3nyoeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XG9zT5jE; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep0ZTLxqhbHYkIelsQN7aSH7a30a963J9HI5ScdRtxXisin/oqdF2U6x4u6UyTRcOH10NkIqTFdv0vuby/mSdpFD53Ey4mh9Cbgy5l9jOdY6Kv3GCP2PKrr/T034/cULlx9KUcW2fWQzOOdWj9pJTQj4kRNFYCKxu184dhp38hCuoih7di+qcKDPW3pnJb0ZpgAt6Vi/J3rxY10D3Qz9cQA8wHgt64K1Ty7nawxQWUbbKAq7v9T7VZJdqoqXPA6iuSTuVB/yp6cGeSu/utLMfCgxTsn0SiBTO3GIiM6WP1pBqlWkTSpz8nOn0ju3QeKuD78PJ+v01VjmNCsGBKSXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD0uxcYHMTdCjHfAx8yucTKpAHPiBsnaYCqJDxk4f+M=;
 b=trbq3UZZxOoZ1RuKDQdtfKPA4ANYxI6qgHO3WXdBpuQcQYfnODUD2H1zEF3bkQLHinF34wqOBvZE/LY27VGXPm8F724EDgNnMcFiuHdFl+RcYOyPHAxU33bt6oMkAidDqw9fkkTpWdRdbgQBDUBkdIjBLJJshZKL2/001oG2Ny6+o2y2wkxD2Y525Guv047fG5dHNFV2c8KxELQnZMt8myQWlLqsEeuJi0STa2Tleqou8/N+RlRaXlKuyIPRjSTC77hSclslgjSjzsqHZ+pQpxqBjY6E38AIFjse+fQCe1XxeiDctk5Ggret/iP7WNlZ2GDTdSi/LliWmMvAzKob+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD0uxcYHMTdCjHfAx8yucTKpAHPiBsnaYCqJDxk4f+M=;
 b=XG9zT5jEtDqBMP1lf7woMdB52H9jIjbhM6Eol7HjT/ousZ/twxuLcFIvkF73zx5Dop6GvXMZQFWDx6CDQBjM/8LxBI61JGcS9by2/4d2npX4cd4R0EjWKurnl34Gqrn8bDqLLb2PIb/9zRMHokiLUAr9iyTySLwLKB1RiTM6AqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:18:13 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:18:13 +0000
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
Subject: [PATCH 3/6] PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
Date: Thu, 23 Oct 2025 16:17:54 +0900
Message-ID: <20251023071757.901181-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071757.901181-1-den@valinux.co.jp>
References: <20251023071757.901181-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: f825eef8-2c29-485b-c45e-08de12045442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUpq1zkNzYkfjUKEvK4V+CMZ6ElTQ/kTKlubpOpIcq+yNojLvwlYgypo18cB?=
 =?us-ascii?Q?/YAISP78Z8pTf7olh89xBvepXWsbtjFwcmJOdur2XVE1KGFbUUtitPSwzy61?=
 =?us-ascii?Q?NtC5b2LYosHNN94F9FIgVde9BZDXN/xV0jSVxxjZTNlKSIBBBKTVvdlyXfiP?=
 =?us-ascii?Q?LVAQsvKlHCrZEFqmD4ufhxs8HN2+0/s16BBkUFZg3LNg86i57B2Cr3BGe6Tv?=
 =?us-ascii?Q?gbFuXIfBybVaxO9rU4XLyq8RUTklwMk9B03gxHlqgBQyyJP6h8dRjomEccj6?=
 =?us-ascii?Q?ns60QfCyhzOBWGZI/HWkr/f4TVNXo3TZRt/Yk4QfGh8v5OD2theZu6A6ufY6?=
 =?us-ascii?Q?4Jis2v1trMo1EGNdaOF023LBsDzyo/X+rug10R3OrXhvWEGOiqhwaUA6tzR+?=
 =?us-ascii?Q?MRIeywn42XKf0Egt0OKqz0J7snkW8QNh8fC/0XhRnf0WD1MZintnf8g73ov5?=
 =?us-ascii?Q?wIdVot9U6Q8G66TZW6GnrvkXmbCf0zyvBBNg+qzqRaL6Hvr5maGiELsLrOMg?=
 =?us-ascii?Q?RT7xSI1cm0JC7FOwFIj2QVlO5+t2+xqSle/IMHFcosrlMI5nPbWLKnwrB57c?=
 =?us-ascii?Q?7QLUJtbqQCSp5Guz01OmBYkq9X+dutMJWmhGQIhM3L6rdvxP/cxSaLOvdSb9?=
 =?us-ascii?Q?bF2gRfIs7R3U0bDKgRx+l5tcp/TEDgmsusQpeOVQisSuIGZ+uUW2uKG9GQoN?=
 =?us-ascii?Q?yQ5+dB9sHhiGxy/U0PTQxAxU9aAFb31YNZm3kBo53rJwgLdMXdgh03UW4zC+?=
 =?us-ascii?Q?vUg/NghphldZN3Fq7H5nBjlzK2BwWjFZKRWqGISbrgTDzEv80to4lzXfcl+F?=
 =?us-ascii?Q?Mqd+oW171TDY8LcehcceZ/IFuel9yENyIyaQoLMXxRTIVgzl1hHnrC5Kd7FQ?=
 =?us-ascii?Q?9kDQwFQLw/JJmzSr8HpQH6a3JtSJxb0V4Rlyxsm5k9s+WbAVVIgdK4HdPSXT?=
 =?us-ascii?Q?thwXW/oHLez1mfyrAitChKc59MjviA6SQqSYBDeHl23E4fhamm4p3zwoFPJR?=
 =?us-ascii?Q?FQkYNDuyEldqxazkYj5xqfHGYLluThcza0jgnCLYR+IS+ynZzOciLMC3NBva?=
 =?us-ascii?Q?akZ69fUF7fC9vbyxBcjYZn0dIbxP5gYXmG1PZ1JYg9KgvqQkJabbWHVJfsLf?=
 =?us-ascii?Q?XgC0hEmWUTYZGzQlCy0dczu7/NHipXvwSwMsOIm/GhXHb+2VMFGqqvnTv7Lm?=
 =?us-ascii?Q?siMVdNMiWjhibfnC1MQ6tyT/wd0fP5QM3eaoUDHKUx7bVKeVMk92NPvZtk96?=
 =?us-ascii?Q?rqw4VxtPryph8wDKWq3dzDwLl2VzYAwSkISPAPZ6vkJtB81O0t78gqcfOt0J?=
 =?us-ascii?Q?IZtn2iPSewHZVuJxzl946ILufyzneKo8Yq3J/VR7flxohftPomatYIBH+DMp?=
 =?us-ascii?Q?S8dfUbjFaSWWbCTLyYbVOldDvsqH5Odk+8tAmIPbc1rOVcY/UvJXbMz6unq4?=
 =?us-ascii?Q?fAXT/ZJd0GNgC77RgHDR0ez+d2Su4qpF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UyeRBImQB43nTAyHHMLtoWJLhQaO8MSgkJWM4f0nreLJrIK+S632qzi6JZNw?=
 =?us-ascii?Q?FLQGAqLt3DEVDUX4DVQIl9OILRRLjk2sG5tkc61x5oXU4mU607dW46y7gaai?=
 =?us-ascii?Q?67rlvYPdLI0ikC6usfN6OAAnIXgyoID0595ibUPVnggd5cusu2zceY/w/iX2?=
 =?us-ascii?Q?74bkp2FA4oA2BGGx3XLWpvy6eaIZCYLXlqBd/RlLELK+zc7DrvXQiTdPpaTy?=
 =?us-ascii?Q?eXJJ4TnE9ED7mXVsiPSt76EtBtpvPqFoHZprIQUSgs6uojiMl5IuAKvMmU4l?=
 =?us-ascii?Q?RuiN0XL5YsGBtHuuQDfsb6BwNepvwN090ryb8Gs3p1zvFHOFOhJlKdZilr2I?=
 =?us-ascii?Q?MqQaq4Uss793OFhb0WOJ+GP2CJQmyIMI28EX26bmtcdhilUBcK8/q112pv5z?=
 =?us-ascii?Q?qJHIMMLVAEMqAyhL7qBc++CASTR1ux+9xO7d9O89JTd7kDo3tp4ptysJNLb8?=
 =?us-ascii?Q?JFEfyyYfz4GbeP9Z8CJo+lZ+SI/pxNOPU83Op0ELsHT+PBMpRSSwB2ruMGtp?=
 =?us-ascii?Q?jzaaF024E08OCNWquFdVz7iJVCW8LjK+dLIZJapZNORYq9HxXYSVt/LCUaj/?=
 =?us-ascii?Q?PPI79sa88t4qwN0KANf1crCmBemvuUw0L5QC+r20Wj5XEJsiNEUy+KaWVfEF?=
 =?us-ascii?Q?xSQZ15Z16LbPVECxc3dIyb6tTPrb68SZJLRD+MCYMcM3OMvGP5gwor2axETG?=
 =?us-ascii?Q?Bbo9MEHNo4FXtdKoqxApcDYUBJKEwcSVm7QdWQdGOkg1+CFg0MF1Yu6iIert?=
 =?us-ascii?Q?+QFU07stOgdFxhx1o/jZzZYb7XCcPjaALr/1RSkOB3ELc7HTooLBtkqv/Vaa?=
 =?us-ascii?Q?MP/s3iYLDKe0bQ8YTbuNozC43T3dMWLILkgMyFMX0Cx0d7QM1CF01yacpDTV?=
 =?us-ascii?Q?kFIGGi1xLs5sRa7eFQ1tAcx7dUV/u/556aXuUKXrfU+mgqdMzBlIIVDwn1cj?=
 =?us-ascii?Q?68FfqViPBIIGBG7kb6asOP6gv3g5As8GE6Xsa4wz2KYNZYXgFRb9CFeXz454?=
 =?us-ascii?Q?ua0u9c49mIolpiucUE4nlmknJqyXFOuJ07gnmy2Kuuccql5sKjkBMltbhQaF?=
 =?us-ascii?Q?D/U8uyRavIIy6e/EUh4FMM03Kx+rWjNYNZBjZVNfyQMTeD0Xet/tBGsMnySs?=
 =?us-ascii?Q?DofbHm5FISnHP/5LOXOjS5Kaad53Bq3ZYBBCeSh+j1xLu1hvV+nAnrAGZSfU?=
 =?us-ascii?Q?2n1Pw4pVMVLzhXwy4abldvbIFKAegGl3KLNW4i36jpxc0Hy7mzs4VVKn1Yc9?=
 =?us-ascii?Q?mHzquEBsopMcQj+M9zNAja0jm9bU8gGoendchHcVfOhDPIT/l/SR2j5alyFV?=
 =?us-ascii?Q?+vjV+msPeTUQd8GnJ6zaozcQrNUEnjCZV6t7Z23d7LiyE/Ea+wjr6Gx/OCmo?=
 =?us-ascii?Q?GuvUwbBzJZyKdS111fMCEKucX9C/y4RkjP4Xd7xWU/WDhQ2KoDOw4pWQGMtU?=
 =?us-ascii?Q?MVnOeJqdxEudXeBgivmKjxaG1jLbX547lH4mKkWqDpGC+89I0jVEWgdsXtrI?=
 =?us-ascii?Q?n+EZuDz5/ZZWoEbqgrZ+Xo8BHpYpHkOlPWbFFXEOZC1fgo8ElugNG9Pxx7Nv?=
 =?us-ascii?Q?hLnIMIFAq8yL/lEpk/eCkrymA0TvzDFNILwCZdi2t2J0uFMDhrl4ztzm41R8?=
 =?us-ascii?Q?wpsB/4CM+WSy8tAKQsn0HTg=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f825eef8-2c29-485b-c45e-08de12045442
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:18:13.8497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdegXoEF/XIdkeyiYrpg2OyMh96OB0U/7trwi6c/Y0u+TyZpkAMXPriUe9nrh0PXhfh9gS5OCt2a2TAYIQBihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to perform later. This leads to an oops when .allow_link fails
or when .drop_link is performed. The following is an example oops of the
former case:

  Unable to handle kernel paging request at virtual address dead000000000108
  [...]
  [dead000000000108] address between user and kernel address ranges
  Internal error: Oops: 0000000096000044 [#1]  SMP
  [...]
  Call trace:
   pci_epc_remove_epf+0x78/0xe0 (P)
   pci_primary_epc_epf_link+0x88/0xa8
   configfs_symlink+0x1f4/0x5a0
   vfs_symlink+0x134/0x1d8
   do_symlinkat+0x88/0x138
   __arm64_sys_symlinkat+0x74/0xe0
  [...]

Remove the helper, and drop pci_epc_put(). EPC device refcounting is
tied to the configfs EPC group lifetime, and pci_epc_put() in the
.drop_link path is sufficient.

Cc: <stable@vger.kernel.org>
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4..49ce5d4b0ee5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -644,19 +644,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
-	pci_epc_put(ntb->epf->epc);
-}
-
-
 /**
  * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -1406,7 +1393,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
@@ -1446,9 +1433,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1464,7 +1448,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }
-- 
2.48.1


