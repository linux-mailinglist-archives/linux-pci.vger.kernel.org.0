Return-Path: <linux-pci+bounces-39609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B814C18DBA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DD01C871D5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBF31353A;
	Wed, 29 Oct 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pZYvzV8C"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ABA3128C4;
	Wed, 29 Oct 2025 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725042; cv=fail; b=QaKsV437THg+eAYqsp9Cx/jFXoJBE5fpcfUr1AzpI0FfbkwOUt23L3EFTNEFRVllyvuHYwNimn4UWhDlIYq6JNf83cTs3IT0j1HxAG3CxbKpFpZGn+Bl+dZCPJnEKg1wLH4on/XN5iE8EwHH1B5bmFdUxzFv1UkI4eNbS32/aSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725042; c=relaxed/simple;
	bh=UJKAzvAW71UqvWVkM46A2CfkkkNF+DhHx7c33V3H7ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SuvRjVcGHc7wp6zDbGuhldXGYDq8pFmny8DZUsbpwC6WYtsmR8QAxU6HYmqd3OHaco1F3n2InfBl86CKKVdRS64ECpM/A9ZkgXWDL4vNvSZHwpkKqoSjX6c0RkY+tRpCmWaQX9/C5mZtueE9lzzpLJX1U2frgdSCdZSIcJmN6rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pZYvzV8C; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GipV2yUvNky9JhzoCrAPwUiGmbAE0a1/nXLmNbVIQJ3YsBRbPYZCkTmBR0qsowBDxRQKYBBtLfLDMpWqH4Y2QucQD65US3bDMjkICekOFb02gTPl0gDv2jk9NbUeT5bnZZU2VwmVTTVJHaZWzFQJ2au9JONy5nO7CBpMWTE1Kk2ABoCaCKAZQpzp9B5/b9veCqjeg7uOrtiWvONLCPNejQqsCEHKy5AoeuCmw4PXTet0afr75Q+Xe6UnWLg/0Y5mPDKSR/GXN/mL3pz8UdvUVc+gVXpz2v1oVW7XChcEikWZAc38PUBEA2zNrvu3F4D6Uj5W/PIkr+vnsbPuzjrNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRf6TXvpxlHhi/Ltsu8CE6pvR0JJzG0pPq0yXVHyLwY=;
 b=pK0NXc+rxb1D97hQNBfhRk6Jub0bQhgUEHjBIlbq+6lQCVU9HjU2fzjIpsIDP7zolKl6JyapeT+axsyjICKFoNuJwzdSQaxIw9XaPQD80bSnluNJpK/riYhacaj+23mFBVntcKsADcDidz7Mg982JjZlDAHBqDsrtLPU9XMYZcpyFMVwMLzCAkdavTwOcqoUCamOaIXkaabKtdja1Cb11rf8vWiCFC0FERGboQQiYalNHZ2Y/0EMMtoTqqQoIWBsyAvrpsm2WOHp9KILwbLcsSRPp9n2wycO69jwY0m/9ZQQZmSRIzV0+B2vlRx6OxJKA4uNFqiWngEVKClaGfbkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRf6TXvpxlHhi/Ltsu8CE6pvR0JJzG0pPq0yXVHyLwY=;
 b=pZYvzV8Cp3i2Z5zYWkMSmjMy0hKB+0E1RqMn0435StxPRjU6yWpS2GEdVVCLOoca9AwvUpRmk6QUcXllWAfKugwjkxkj2pnkkzrumpfcTXTG0hLQJAcHYFwkpsdGYe1IV2BmQiurxHFCGUdZnqzEMZj0k34T3R0OiA0Wv+PQaQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OSCP286MB5086.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 08:03:55 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:03:54 +0000
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
Subject: [PATCH v2 4/6] PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
Date: Wed, 29 Oct 2025 17:03:19 +0900
Message-ID: <20251029080321.807943-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251029080321.807943-1-den@valinux.co.jp>
References: <20251029080321.807943-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::12) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OSCP286MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b685faa-23c7-4e4e-b9ad-08de16c1b49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U17CAnQRE9bjkwZ3YvdbKR6CZFleWR6AllnfrqL6x7OtEYasHb/A/lfmXNIx?=
 =?us-ascii?Q?xuLeM2bvyYiCYhiQ+MyWihS7qjPc6j+cI4MwBoSPyncKklgKms1ZO59pdIEB?=
 =?us-ascii?Q?Az+weMWUTxzZrPNerIuauaqojkZYIn8DbQp3X63R/GUhU3akyaJbOowXMULh?=
 =?us-ascii?Q?mN46KmpMgT9qSJPBro0iThTI7KlRPqeW5ltPJp7iEkC/ElYgwGgVcxsJ3R1I?=
 =?us-ascii?Q?BityT3LBe7aA8PiJ6pj7W11UQ9e7aw8nMFKRyWUF672WPo3ht+TdxUawpelo?=
 =?us-ascii?Q?6wOLfLeBNmZ9fey5uNRB1LxUq0ukM2pXdeUYQ2iES+aL5/17KrmzaWvnBGIr?=
 =?us-ascii?Q?If5821+UYJTo98qmt9rGZvGsn72tW6cEo7biixkGumGw5xiQde4kA9Q8vOqP?=
 =?us-ascii?Q?LmH/gWSaExgNykb8kJ60XoTR49I/s32rfUJ6NMKQ4Gv8ais2zaKyPLuMoozm?=
 =?us-ascii?Q?xYuKQJgvovaYNqcmQPY1At93vJXvjkPgs3/Ls+dZ0NxO/4pesxEANUy7/NjT?=
 =?us-ascii?Q?odKjTwNImfIOdOxppWK8NhQo/t8yNCiEw5hTT3hpnWQdMxoru84mjXS7n4L/?=
 =?us-ascii?Q?k5Oa6djjzRHthr+Dr9oHbO7UYgH4a0ZDEC2DF7LkE65tuBi+ohatqMEfD21o?=
 =?us-ascii?Q?5vCbsPHde1QwghqYhdJkPhoNd0Cht96uoUb1ill4g4zN+6B1u/N7hLiVBg8Q?=
 =?us-ascii?Q?eS9VOupyPv2xUUFEv0cGmbqTuTcS2W6CYN/kHPSNuZIFuXpIbgsbq/CrhgW/?=
 =?us-ascii?Q?LXYdfXIUdZCyJylqMIhXoSAe22c1t6Xd/mman/HXGd390d8ehTFDqFQBq9p6?=
 =?us-ascii?Q?biawpq3E2FeANNpuV2pJaEmiQnyD9OP0fMGQVuPpbNoRe6gZnx0lPiXU1buJ?=
 =?us-ascii?Q?9ChcXKX4ZH2Y2BC82vk25IikHw29EdAeFU/t2/APbTTco7BxDbbFrrE+0kzH?=
 =?us-ascii?Q?sHY+zshOneM0nf5KMiTaEa8V8M2fUMxRWr3rEQopv3HN5xwSMJPAtPIAnEeA?=
 =?us-ascii?Q?NyWzxl/ufxONripq8SFB7UaObS5kigLjQjNjGWuyy6vxbJYPtwGcis3zJNXc?=
 =?us-ascii?Q?cfYN0rvVgoP9eZBvVqPy5JA57pYXm40KWUFYigwo+/IGmjnfc3dNIsvWzC/7?=
 =?us-ascii?Q?TxPCYuBF+mFFCMnIUmAaRR/Ub51RAsVW1ACa90R9pLfV8OPwk5iqpaxtvnjP?=
 =?us-ascii?Q?+bAMU6z4ArBKM0IoEf51gEp02YB+tB9VLZLkhugdxEJR62FaHHswf6+hecix?=
 =?us-ascii?Q?muH7OUucb559E0dH8iu95iOoirVetlB+s+1NzpezHjg4d3Qgs0LyLXCGnHlI?=
 =?us-ascii?Q?GQW4gCpQmSjA9cSq4N0eFiJzGxpVkMskGdpbAz+1TLjZz9Js1kq+2vnPwcgO?=
 =?us-ascii?Q?xbROd37xY7R11DB/ar+AMNEKitVcEqlmHX3zahA3jZ/P19F+mqhfGBDEw5V1?=
 =?us-ascii?Q?uA/NT/k/bocyXfmLzVFdFMxCbDiQT1LD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nIZm00BrhU8xQMQx4+R2fvA3SnWXFdMovyLj2MWElndb8vy8cXRtsHP1Efvg?=
 =?us-ascii?Q?+ad6uuzqQP1fzzzmM8ScaXPtfcfH2KYJlN5p47twQCMewMahNLOHdt2j1Odr?=
 =?us-ascii?Q?+vjuhffDz2W7SewwJ7bui1si8fAvTW9hOfY5bs1vIUF8X2Uoez+KS5Ve54xq?=
 =?us-ascii?Q?/8yUc//+SiuQnngkmdj9vWiKNgxUIH67rN0EUKG6O8c0suWLHCXpd2s9xxBk?=
 =?us-ascii?Q?ejXGQaUApRUKSbxDzFeSE/vLB1W++gihnL7RXnNMfRNo2cD7rPck8eRrU/KV?=
 =?us-ascii?Q?IHp/PhhXrvpYrLB5gle89PYCUr7Q/XuEiHFAnraBLg53C4hMBOq3nC2c01Pb?=
 =?us-ascii?Q?pD3uKo5R714p3Ma0BkBjL3yTlEB5JMuxlustj81GYEwU3isopGM8azguY+mM?=
 =?us-ascii?Q?Hnbo0SAx1C8g1yzfx8uORdSWPiqmjkE39Mw8etCT9BrU++NKGMCM5emUIiRG?=
 =?us-ascii?Q?s933bipExf/j8/oSZ5nBpU7xZ8ixqnzYBo+5+oYM0ceirfpbEwbTZ2SojP6W?=
 =?us-ascii?Q?YZxNJseBj2lyRYBEb/bcFCkBdHrxkoJy6jJUU7AJ/IDWwKUBl1xy+NTX6+09?=
 =?us-ascii?Q?JqOyIZ3zCerLHoIFDHXAf4VzlRxrCmpzjk+kuTvnsSObt+Pm+YHnBfBlvf4o?=
 =?us-ascii?Q?IK/jir6eEqNIIBqw0JSQbsFqGh9yUokafHaDJ85o6UWSXCyR8t5Q9w1xI21E?=
 =?us-ascii?Q?suKGQCW5s26+47SzeT8z1T0mvZLheyHKcVgGJBnEhBPJ5ic3FtC4P7X92weS?=
 =?us-ascii?Q?wMvZLx1BHbqciNH4Tyt/D8mCplgYPHL2N8SgszkTvEZzOoLd0gbmtsdq72iD?=
 =?us-ascii?Q?J6tkPuGngIVia77ye/Ki1ySThCqeweaA6l2ktx8D/SKB34Y8NiHAHon9YK99?=
 =?us-ascii?Q?+XDh2gMg1P8XcDtBi76+h+7aKTlE04hZHEWYe+kX55JYF/ECd0BK6PiVmii9?=
 =?us-ascii?Q?xr215mNbg8q8HkM5+EinpblR9mnktZ12BXtaHfuaUqInIxwzZs0hLiW7EjHx?=
 =?us-ascii?Q?XfXhdtebH15Mprq74bA44c2ayttL470mmORM+MDVJ78ZyD7pMfIUEHBPNlCV?=
 =?us-ascii?Q?VsCrcoamYg9gkF/0MmLUiATAAwZYbjELkmV9Qj4KDALbq/dJiVavS53tOPMB?=
 =?us-ascii?Q?YKMvybCTOV3t4zvdK45r7SX8uNKiLc5hUX1203Plc7plReKBofLlwaCJbPj0?=
 =?us-ascii?Q?eQ1BktHINZuUWc+l8xMez5zl0UuxnKTb34oYSeWgxqXjvTVtoJbqL+yx6wmv?=
 =?us-ascii?Q?ya8oIHYmufuUNvzpqL+aBLle2zexgcdONKra9EzYCxjPAJT31FOU2mPUw2JD?=
 =?us-ascii?Q?73VR6YECyilDpREQCQqnIJMVIoszdJBdTIvXa9aL56UPaecQdxJsiIV3efpG?=
 =?us-ascii?Q?NQjwpejplUNUOSqq8D/kDDm7tLhM9+jDaeRfa8JcqfC6peCcdMdh1fcAdqWL?=
 =?us-ascii?Q?3a+fzvDJ8QBP8i5XEO9UcrCBx3VYNkXYtkz6D/Q9uJiIx2amksn+B0kfVc5o?=
 =?us-ascii?Q?AXWeskHzmZcbKPYMpw+NBkIes8wlKHnNFvW1IlnaJqwrcypdu41HAEKR95Z2?=
 =?us-ascii?Q?SB6VmOQrujpA+QFvhEXpH8YxfgwyAnjupvjF6jOpALBVx2eK697I4B9ALiNZ?=
 =?us-ascii?Q?rF1Q0+kcB6JkEpW3e9/d8Rg=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b685faa-23c7-4e4e-b9ad-08de16c1b49f
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:03:54.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncw/zb9hGNTh3vzpWBfOWq50PC7I0AgfslpDOgKaSr89w0OC4hZcY6HPTQO+rv7tPZgjgKzIAKGeHJQQPRUmag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5086

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to do later. This leads to an oops when .allow_link fails or
when .drop_link is performed. Remove the helper.

Also drop pci_epc_put(). EPC device refcounting is tied to configfs EPC
group lifetime, and pci_epc_put() in the .drop_link path is sufficient.

Cc: <stable@vger.kernel.org>
Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
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


