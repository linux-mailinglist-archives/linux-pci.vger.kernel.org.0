Return-Path: <linux-pci+bounces-42456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDCFC9A6D2
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91C42347070
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98918302754;
	Tue,  2 Dec 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bScOev/F"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5E30215D;
	Tue,  2 Dec 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660245; cv=fail; b=cFoBTxC7ouC/eulUa+n6kMK9o7tMuI4E+pKrWk7xNMJacQ6W1YBIYdaFTqnE3nov7854H6zxkqgwnb2RWazOS+64BMh13SRTsVpmdZ8ENXM8TTWj5I6yGJdwaCpDKKKUN7YwWytTTh4vduwEOkiJ+PUmq4SsImVpq7NYaVc1eU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660245; c=relaxed/simple;
	bh=wFhE9Q+XxbX1jLRxMK+EUYiUQzRLl1bDyGpu5AEwkiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDVPjNG74xqCcpLLMRfCDnjIf+wg+OTtSZhAWM//5HGRDjAo19aj645/QvMuKImURoKl5TBV9RPDDs/kzAaG7uajWx2IGIoRl1zJfp3ulBE9oNWt7kdmY7Seclh+5yEkQAVaAQNvlyzJPlOpQni6K+3mj105aaeC933BT0gwM6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bScOev/F; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQLV0a8sjT4qE3TErfpMKBJuZLGStosuCg9f9sM+WdXmvoHiXW0LLqx80HetYyYnNEAa9RJUjYft+rNQxmwcj2KsJRiHGRvIziIxYeee23IKGgg01RusNq5zleR0OY50uJ/KKvoR8clSa7u3QmT4oIXRUEWb/owLkcnUYo9u5uQbsLhPqVc484MNU4BzD0UN4ucRfMuw9nI7AJ35LO4YzzqEJChfevV/Iwgp6ElbPfRhmM0ss4FRXu1ONkDMGSFm2pD/GqiF1gEj0bsrXJBQat5yB8rT+YsBMVivw+EKXSTkWhtu27EtQEyxKJARXOlZTDYS2PJ/PeQ39Ux/MFAIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUbXZaNgaExAcWtrAOlLg+aS4C25w4bx4IUYpq7ovFc=;
 b=qwAP4Xyv7VrPvML66pDveZAMyVVQdggChZTtmenk1/206OPr5Dtb3wxL3rqvN9mTWTJlCLeWykIM6nwotDpT/gn5UOYGKpWPKMkIaLruNg1dmvyEbY6dkOmjPntT3TfcaqwrqpjVWX+H+cQIzFXNlrLiIJaX0Uaw7x7y6FMpPFeoFIPIfKs0lZssIgtsk3Vjm+3CUUDxDEzfw1o5zbVApdfeOJCvobVtW1KfsJ3smL0L3lkEQ4AO+UbbSEwnAuvf0EsuRbWQnqW0sMKXNz3aGjEfUuFE84F4QVN9zX52cmfL34aiwLd2I91e7incbgfwTtKljB74odVREOfgz53gqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUbXZaNgaExAcWtrAOlLg+aS4C25w4bx4IUYpq7ovFc=;
 b=bScOev/F71J8nSS561F+Evi5fIQLKPYrSmSBcHfalLyZ4jqD36+iB2lTxl2hwaXs329LOk7xE94Xvfillokje7AKooGwS866qnLkb7yPstBC+2n7xyYCmIEaSCSMwvBTYKE0xcdTzMmQIKymywz2jQyDDNdcbhS7rQlByVFZAX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:23:54 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:23:54 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	stable@vger.kernel.org
Subject: [PATCH v4 4/7] PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
Date: Tue,  2 Dec 2025 16:23:45 +0900
Message-ID: <20251202072348.2752371-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf01589-6e30-4f59-bf35-08de3173bfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NihjYVuzQltXoHp6fQqknyAHVp7D/NqgnP9nOtH/+ivnVv9q3bicuJq6OUG+?=
 =?us-ascii?Q?HQPbokh3tDj4423HVuHWiDiVsrSJKFh/4yffd+oU3UEhc9UDgeM0sXkI0H0/?=
 =?us-ascii?Q?hkOJB4KBF6hB2FQkfDJ32KDZaDY5zzZr9ht/W9nKZk2NzMfQGOe6Tmjtgy2i?=
 =?us-ascii?Q?e5LWoLLnuVivwQ+U7erm9TzBO6UasMxLq5c4x6b9s7aGK0j1KynwDeM6oSgr?=
 =?us-ascii?Q?KTQbxnti7vm9QO5DP0wBWxKTXIGOvwLjOIHJ/X6VK/qMY1qnQc/91ywPCjE0?=
 =?us-ascii?Q?LuxikDDOb0Y+yJEEhuz8lGlypW2+EUDpZIRpQdxV7/NWoddqeeMAgzXU3TjT?=
 =?us-ascii?Q?zFhkTAJ3YjdMz7Z8woHp4+AmIv+XKOTBUE2ThctQfF8D9ldGDGNzmSHihDBo?=
 =?us-ascii?Q?Hd516X6MAonH64Tzq41xFHu8ZbT026pkLmhKYPA/OpyIZo5f7VdJvXrLinKC?=
 =?us-ascii?Q?czrHH2b2IloV2uhTQA49GTSfAtR95fKoN/qxWhbCF8s/5DwTrqPokKhfztXt?=
 =?us-ascii?Q?S+38szZ651Lv/THak+qBVkXHdLn+14xGJ8t6omxpbpJh3OYC85gLWk8TZ7Hi?=
 =?us-ascii?Q?dTqXHjDDBlfJBwt0dNyaUoEq8JVhNcRSQm4xOHK95SBRImB+gzEM40eoXglX?=
 =?us-ascii?Q?VpMKd4wuky+82KwVHemL6PtNm3K5Ia1aZ8lI293cIZjrt9F7+y/ue7HxB3h8?=
 =?us-ascii?Q?0ibXmMbbpCLx9RU3wu5G5wmqr3CeP3T3TYCTEXIrklG88lE8bCx1F3C/GS9E?=
 =?us-ascii?Q?xBV5JwJg/RR5Lhb9N+xQ4rRge+A7YNOrLEIvzlouQcWeVCsUrhdEIQCGdRfb?=
 =?us-ascii?Q?W9fOzGlGcRmda3/IT6Q21JDgBIWf+iC8VukR/RVgyHctfVSOi8tzQkpgQt06?=
 =?us-ascii?Q?IvX93XVTnU98JTM2HJlBRU0hs0PB/QDqpgCJF1W2dILuVcQdyKoKo0FsisSD?=
 =?us-ascii?Q?EFDAvxc2Xoi+MAkj1Zw90Rku1LJ8ABzCIJRikj+bosqBGXPGsYBIGlBHd3aw?=
 =?us-ascii?Q?8JzC+UwUO5WwO0qUxhSXW407yOwiUSKAKqkrht2tmKPRG3sXQOHdXpJU0Fgy?=
 =?us-ascii?Q?ddYn2S15Q52GjEFji0qx4jO/RRdPfzjCIP9L0zVpN9D5J3Bv4kfwLJYJiwoC?=
 =?us-ascii?Q?VwAAu/YeHF6DuN6QeTC66INSFrooFYZMuOMcInuaar2mSaLG/h9tlbUdEToQ?=
 =?us-ascii?Q?AmgVeeSeNjD0FH2wP+qjaa9amhlARpHp4SQTZWpv3cKkKwXA2TXu9OoUSBgU?=
 =?us-ascii?Q?Wt0fkJbuTYeLusSidhlNMU6p5ce3tjmIRDlibfaeigTRszzU3RoZAVVwLamb?=
 =?us-ascii?Q?JN0A8bQ4Kqfdfx2ljrSf8O+cv51TyO81YVSs9RySdyF6WWrluYSDQ8tU012u?=
 =?us-ascii?Q?escDpzMgcJj+DH0b1haGcKckJ0PZbcmOeRmm7t3SAyX6vv8JYnQp/SrTb5oD?=
 =?us-ascii?Q?ir+KXDOm/Cvvz5dk/XYVC1zm7yR6RUtQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+URi5BbNbGLzMtr25tZ0W80rtKyQ8VZBD8Iuem9XgKIYh1UbQ0HsiIMYhEX?=
 =?us-ascii?Q?fd9KEEnNFJ+hshNMdADWekmDIOdYHRR+XGVBZFg31UQenmRSilUAUU2xDx/a?=
 =?us-ascii?Q?Ds+XmGM4B24eg5rKBc5McHBcVL2AssIziQhTsU8zlbvlfD+xPRxJro5ZqGoQ?=
 =?us-ascii?Q?/PWhXzUtmzxh1MXdCsPC5fhGWq1RjkVHe66u0MNtKkgmZFqgk31II4xXKx+5?=
 =?us-ascii?Q?8MUq/NmPyU8YpLu0NN2mOtLG+/7BerQTO04JnkyeWGxgIorsmAwG5DNDGOh7?=
 =?us-ascii?Q?xN7f19RrnkMqOR1JWdWEvJxfuFLhvrXPrf63HE/8FsFU3KKxQnu/KOroHBJb?=
 =?us-ascii?Q?iKmPgJP3AWAYxJAG60WzSxNTyF2VfVjM5WvCRLJ8xwNXhYYriVPtiYg7qevc?=
 =?us-ascii?Q?MZ/mS+9bzvFrlWhkyUzx5vKO1lhaVJDN7u+6Kldrx3//jgwcRYaH4SvAgRf1?=
 =?us-ascii?Q?Pv2Vlr+h29jYwq6PupZgVPiacW0zxHl3WmRCYuIJXMylZXs49Xm7MAubsTKF?=
 =?us-ascii?Q?cflvAZzxJxEyXY9oLzYuyNdMOduOJdNPYx3XG7bWFCNdCfosJEaJ3DX3MmI+?=
 =?us-ascii?Q?I0gIHs44T4OBpErhkk9e17AacHDLMexy2RLWFj5tH6XVioqAw1LYC42os72e?=
 =?us-ascii?Q?oUl8RtDOa2h1kUBJAN1CLs8xPYVTUFzOdlnYlDHDyrwQdBF4eRvG5LNjTqQ4?=
 =?us-ascii?Q?zwPsxu5/7ASglJ6U0uryuahdm2FkrjqpY/r9HGa5LawXxI72L5e+AMnQJM7t?=
 =?us-ascii?Q?p5VnKfXPK/XoKE408KuTNx5I/EUcoUCG8KNod8AwM1KRfkL3WOabf5K8bpnB?=
 =?us-ascii?Q?cw41GxHw2NIQGBH1T+/WLc2YGkVzAU438pwYxP/+Iekmgj3SADsZQzEwimQ3?=
 =?us-ascii?Q?xEEPf5bZyzRVvJsqC+51ob+QuVEGrNf1Uh7ubfzJGsaksTeT27piw40Jrab4?=
 =?us-ascii?Q?UCbtMEn0gYVHBoExb8UHZWfdlTtjFBho4PN63mRxbewE/maj+bhoyEpsnHM0?=
 =?us-ascii?Q?bSZXgBBAw7yTR5Ngq6virrPt1LL2epSiNXMtbmZg6LQKs11Xz3OhOzWusies?=
 =?us-ascii?Q?AvT09gNwW0zhnZT10k1dpyYmOpwth4Fp9skxWHXk0ch07ZCwjKR70Goe5/mR?=
 =?us-ascii?Q?HaRUgPKvUVyV9XX9MCb0KaZwk1XtEI49c9wPB+9lynaGi8FcvX+uqyGT/FFy?=
 =?us-ascii?Q?uU1p7WLpEfOtPP806qkv9GOGdD2YoB/pdq2cVjG4fA9JAKcfMJjuQsRfjQCm?=
 =?us-ascii?Q?x5xqsXc84sgSBxw0tyDJuaUtHDsKiPEVDx9ZkB5UpyQG2KoFpTIAg9HFYggp?=
 =?us-ascii?Q?RjLnEQ4oHiLR3nNkpfQJibj3gLulxrCnFK0vKaoSmycXNDH+nPOj5iYdDEQk?=
 =?us-ascii?Q?GJGvmewv3syv9UH+24840QPlRIelY7TiG5Jmyg8kDsxyIYMs8lz8MCR0fcIc?=
 =?us-ascii?Q?hVXIWDTmf5tqn0xwioVrCN+2G3Qt2+KLI6D8xLlR99OOi489G4J61jG6n5uA?=
 =?us-ascii?Q?9KLd3iSBMfWA1gcCafMQmKBdpbd9MwuQ0ADuF/wmo8+ySAz4nGqvl2jT2w6n?=
 =?us-ascii?Q?mRtsorym55QMxCG+epSazUwTr034y2KA3T2/00OEsYr5Wb1ob+EhlnJlNRxH?=
 =?us-ascii?Q?ACiwyPQtGBFi+nL+Y97dG4s=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf01589-6e30-4f59-bf35-08de3173bfd5
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:23:54.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1WnpEGfJEm6YDpNiGIX9oWvkJM30mosuN39UR0EVw1DhRrMRv9U7uwjjO23BxZtuI6/fyDhOlNd4bOdTFiN6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to do later. This leads to an oops when .allow_link fails or
when .drop_link is performed. Remove the helper.

Also drop pci_epc_put(). EPC device refcounting is tied to configfs EPC
group lifetime, and pci_epc_put() in the .drop_link path is sufficient.

Cc: <stable@vger.kernel.org>
Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 56 +-------------------
 1 file changed, 2 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d21..7702ebb81d99 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1494,47 +1494,6 @@ static int epf_ntb_db_mw_bar_init(struct epf_ntb *ntb,
 	return ret;
 }
 
-/**
- * epf_ntb_epc_destroy_interface() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
- * @type: PRIMARY interface or SECONDARY interface
- *
- * Unbind NTB function device from EPC and relinquish reference to pci_epc
- * for each of the interface.
- */
-static void epf_ntb_epc_destroy_interface(struct epf_ntb *ntb,
-					  enum pci_epc_interface_type type)
-{
-	struct epf_ntb_epc *ntb_epc;
-	struct pci_epc *epc;
-	struct pci_epf *epf;
-
-	if (type < 0)
-		return;
-
-	epf = ntb->epf;
-	ntb_epc = ntb->epc[type];
-	if (!ntb_epc)
-		return;
-	epc = ntb_epc->epc;
-	pci_epc_remove_epf(epc, epf, type);
-	pci_epc_put(epc);
-}
-
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	enum pci_epc_interface_type type;
-
-	for (type = PRIMARY_INTERFACE; type <= SECONDARY_INTERFACE; type++)
-		epf_ntb_epc_destroy_interface(ntb, type);
-}
-
 /**
  * epf_ntb_epc_create_interface() - Create and initialize NTB EPC interface
  * @ntb: NTB device that facilitates communication between HOST1 and HOST2
@@ -1614,15 +1573,8 @@ static int epf_ntb_epc_create(struct epf_ntb *ntb)
 
 	ret = epf_ntb_epc_create_interface(ntb, epf->sec_epc,
 					   SECONDARY_INTERFACE);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "SECONDARY intf: Fail to create NTB EPC\n");
-		goto err_epc_create;
-	}
-
-	return 0;
-
-err_epc_create:
-	epf_ntb_epc_destroy_interface(ntb, PRIMARY_INTERFACE);
 
 	return ret;
 }
@@ -1887,7 +1839,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc_interface(ntb);
@@ -1909,9 +1861,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1927,7 +1876,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 }
 
 #define EPF_NTB_R(_name)						\
-- 
2.48.1


