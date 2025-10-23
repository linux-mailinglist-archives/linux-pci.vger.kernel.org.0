Return-Path: <linux-pci+bounces-39090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2804BFF828
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B3CB4F7E0A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6CF2E7166;
	Thu, 23 Oct 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mlSBw4Bn"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F82E2EF3;
	Thu, 23 Oct 2025 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203902; cv=fail; b=RozmFzLYfoBmRYu9rvc1Q98WfYAkD+xnLHj3BUvsQynrLh+p+1yeXD6QGJTBNPt002vFr7T+cfNVBANvCJWqkiKUxR5lo4cyXLoKfc9erCCfXU/kuhKWy39hqgkBghT+GsZAu4ifS7US32le3CGFlBvbGveMYSbModhEetuOqpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203902; c=relaxed/simple;
	bh=UJKAzvAW71UqvWVkM46A2CfkkkNF+DhHx7c33V3H7ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5/27BhEIICmoKlUq7cXyJ2pnjFY+HzyaCwrQqSIcD6t/p0VVIVg4FgI3NSodkFE/xKbW3fQsDM4yJYpukuDF7my9lzBSFgSokJtJHa5dymGJF0mxOt14AQ+xzR1g6XudUfnZbxpjC29oav7RC8+V5+55vjd/eXuQVeu9Kj1sl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mlSBw4Bn; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu5SeejEMAGL2GN6YfJG11u+wYMW0AHE1FSZVMTKXyMUsbSL7OrsmiYVMAvoM0reupAnRWdJ6hRQq2N2svOy81E5vdopb+Gm8/RU481uxSFMbu8n7e1gDOCcZ4L4m56q8bflF5MOXeVaDeBKuOoPLf/oofz6Tas9w4F4GzdQ8ssGgA2mjKGIkuzL6LdQv8lVQj7i752Zzxs2FtY4JmzNcn+bc4C/bIstg0Qoe6IfxYZv7WgCNxo6TF5PQvwn4fCcDL+8+1sLBNb9MBrZs9zyPeFWYfhEoI6NTdgEhVhmtg1HBNGJP8ZtpfP0PTYsKcAzsKglyWjf92tY6ajBhKl0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRf6TXvpxlHhi/Ltsu8CE6pvR0JJzG0pPq0yXVHyLwY=;
 b=yduTMW/XGiT5Atxec66rMwbk/t35V+q6Xx5ukYyvCLRFx6p1LxG2cd0zey5swXtTJos5ogtn2ofjApRVVbTciDzVGOGrslXph1MinnfIkBL48DpV7kmoEGoFlLA82Yk3FqYR4k1qfXbN3GMng8OehwOSS260to68IFmeT5z5XuH5JzVW9l3EqB8PIthsZWPlNwNsez1enA58ybYpe1d3NFezNZRv00oLw+8fj25qMRgNUWFJcWtOmWibhS19GRWTbT07b2gV5AvBLl6jUIGic30wiim0v4qoBHZNlDX4Lb66SW1NPTrMzad/avOuD/JbiC1thl4bNvrmdPpTBXoxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRf6TXvpxlHhi/Ltsu8CE6pvR0JJzG0pPq0yXVHyLwY=;
 b=mlSBw4BnioMuPNiriK5NzoYTp0dACrAWxYHVhvSnn/CU4HrscJZnz7QBnRqUeRhbLGzsUPqCqCzqqvFH4i0XyNKhAkPwslwAM8pql1QCfkyw4QeEFCaSt94LA8c2dWE+E/UqDCCuxtqMNVl/w19Hd8GreXNx1qKVXCbEDwrFoMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:18:15 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:18:15 +0000
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
Subject: [PATCH 4/6] PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
Date: Thu, 23 Oct 2025 16:17:55 +0900
Message-ID: <20251023071757.901181-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071757.901181-1-den@valinux.co.jp>
References: <20251023071757.901181-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0075.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::13) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: b005e2c5-fab4-4355-8f90-08de1204554a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nVQQ0uwAfOfBKDIIg8yY/vvlofKzSfl0JgHPsZfLIAo+TpDYK8M0RebxPVIU?=
 =?us-ascii?Q?ntifZYy7E5HiIowbwpT7C6+qLFslpSR7tOfDA6hX4R4L0ZVgILifNpTBLtjl?=
 =?us-ascii?Q?KMUbs6mljRZJj1fBUXDKdBvpajXpwswXePJbqgztZUVbx/jwuwfFqLfRd9P4?=
 =?us-ascii?Q?LkP2kwaMM/Ev5EiRyerpPOMqh3Z8L2hSmvSUQ+xnJ1+6uBQCSExCaOh7fyTl?=
 =?us-ascii?Q?wdQ9iLHnjrmke0u9WV2dVOs+G8Zb7JBuC6jMX4dItstHHjBP8Kmuv49TK065?=
 =?us-ascii?Q?Pnx8kSpcw02G0KZvmVl8Clhra4B7wn9p96iPIW3iaaLjwuT/wcr2BwgNRWbO?=
 =?us-ascii?Q?ZiircT0eblxkUDTrx5Br8Bb1UrxNfndWoqZmQiCQLqUec0pkXd5G7GP5gcT2?=
 =?us-ascii?Q?QUYGhMvR6Ty8t99hEkHYLqNaO9UqvfTx4hUrLJE+s6/1BVPfshu5AJ5JIZLo?=
 =?us-ascii?Q?H1kNQGgfHksWBv2MpHsR16b5Yk1XjlqCzaPGCQbvl2JcdqUcAx0pFeY8j2mM?=
 =?us-ascii?Q?E8q7MQ6Vhrc9mL2WvHdyZtzOXZyHWdP3WhMkfbIgoFttEG6tLtp0Sk/lelQd?=
 =?us-ascii?Q?dvvOYfF9j5+BmOw1AYt8wyTHe6h05jmhOePff89ls4mvXdj18yDcbr/bX4t3?=
 =?us-ascii?Q?a3/qyM8DICmT2M4LltKaB2WOcidbJTPObfLkHXpZ6kLqrrEXMxAQQFrls0Ex?=
 =?us-ascii?Q?Hq5gVmpPHqK2kMgjg7iPWpmLFeK5IUiFj9wtjCAshnWwztBDnJ9kKGJe/wBs?=
 =?us-ascii?Q?7eKv1cLveo5y0SPEtDgua+EleQvYejqLt+ZoVN9O+O486y0xF08C0ELjgAYZ?=
 =?us-ascii?Q?t6WDOCALyoa7z/EPePgsx6bivt/aQjR5b0HWZsgCt0jpbwqck6hhSVaXeWPl?=
 =?us-ascii?Q?YZQHdJMqctVaRIpDZ23tnCJH84abDY9v0D9vMKoICL2qZC5zs6aduWSeAAzc?=
 =?us-ascii?Q?U+UxBJaKiulP/pDfpNPaC/G0P/AyrVFqnuOJeRQVqmQHA7yHHWys6Ks3vnoA?=
 =?us-ascii?Q?dA/NG8SsawKFDSidhna0m6u9ujK7msay3Q8u9t8c8W/+wzYVkdPSctgO6Hl0?=
 =?us-ascii?Q?mHGGCPQcA7y8cfo1dqUqGjWC/umr39AKBMcXm9NoRw9ngWqu509kIXWtH+k9?=
 =?us-ascii?Q?4OGOe62g+3WdpvfCrtxkFzU1n/0NYi3vzUvrPnx4pESu5mgAuNl4+3s15hIy?=
 =?us-ascii?Q?NRWvCykLHICu517bZCdPY1y7mLyVa3wftdvwcXhJtZKL262e5VjOaRWQrhBs?=
 =?us-ascii?Q?xKPtK2wyyZklgMaoo/T6Fmj+kA48HKLY9XzGor0lSB1Ysi+BN7o6TQFj/RwD?=
 =?us-ascii?Q?hv8b74d0iBshKQdxJvMyxGm2BRbT5GL17yJzwzU3jx6LI00gdyrr/WbJq+lk?=
 =?us-ascii?Q?zEiRrNFw/hEkWzJecyrVOOzbbyBYt6HlI61OMVrj9nTqfbz73AtoD6heHK9o?=
 =?us-ascii?Q?dn9gA1KxaffeV7Bl6PmqoKU7dkElQNkz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vcW/7eQj1HgnYrwc3vMq+CkK+4tiKzHFFBpWR8mddKtlTRFYyLMGwEqEr895?=
 =?us-ascii?Q?H1MeOXZdx1rZdBWXksbVysgnnFLWbZyEouVZpGuMD1NZV4CQhVGwBc5E7ffi?=
 =?us-ascii?Q?H767RO11LmOKqIB6UX4atzRdMWZMdbVzsIsczKh8jERJKkfBkAxb1tgY4ecL?=
 =?us-ascii?Q?pqmGCaC8uBBpIauvUmSwHYfnmfMizEQ11HkVlRhWZrXXGHQn4KewR7YAA7gI?=
 =?us-ascii?Q?VdPVYt3irY6qRrIC1nVqF35H7XTPwOJJWhay9tOy27sYQ5Ula4tAMLY5+JUf?=
 =?us-ascii?Q?0CxojjDLw8tqB4gghneEZ8Zo85M/bFf7pXEEC8ua3MwhoZjVyvy1lGAcV2zr?=
 =?us-ascii?Q?5LE9K0FfOGmIZF5AODsFZHGotZJrhgulDwvE2Ss6hqqiQADgGx7q2vL4dce1?=
 =?us-ascii?Q?KjHun/ZmTBrCiJsWZnWxDQa4SmUiTKVyIcdnCidTH5ujRae+UyLI+93wbNoD?=
 =?us-ascii?Q?onTlmHbVm5N6a1zTAOE2l+R+OqP22StIx0MneZHpk08SfiRal531duWJ+VD4?=
 =?us-ascii?Q?qys1QLaxSGiPlfAUJOUH1iQbSKUT9V/lvyNmYdI7AM3NzP09Spt+dphHUTQj?=
 =?us-ascii?Q?Q7aGzXvHXu8T10o1SJEdHhnitNwWfmb9fCXd4H672mGsgqGkyq9fDarqfgqO?=
 =?us-ascii?Q?840bgAMTGbjukR32S0KooP56RYmGgSg+UH11ELS0fCECaMXFqp6/BNwrfgsi?=
 =?us-ascii?Q?XajRULyyeBgnuzy9ZEMWsefLLuN7+SqgdphZ6KTPQrsIIu+YFix3D53Y2ZYM?=
 =?us-ascii?Q?k1yvMWQp+WOS4ORQD8NmNCXptMUdyYsixTsmtjjdlez6fynovIishlVVA/UO?=
 =?us-ascii?Q?s2Ab7dvDw3jvxOL2qS+Q0ZKaLD2mh/qXeRq0cHvMfczpn0sRmZd9EvrPyIS8?=
 =?us-ascii?Q?WIQ8PJFVopza7SqW97L1EiXfMQ+s+5gTNKfOoqN5/mY9+PwkxXRilsWeQQNA?=
 =?us-ascii?Q?Q8qjc+PHqp457gRpT8+m8Rwb1y5oHuR9JGHNUiG1AM7oXGigA1w7X0q/tvv2?=
 =?us-ascii?Q?Db77n2kO/XlpIsY18J/1A904II/oKc0Oas9eE1rKNVKJBMUIGWUVLUl4Y8FP?=
 =?us-ascii?Q?HnmPoTIJ7VTkFS17CVmPxD9gjINMWhHVVOkzS+12Rv9RHdRn63/lh44+dNbI?=
 =?us-ascii?Q?ONTKMKvcFCHiyCeqZAMCgDIjZafqniI6SwZc+uS6lE4eQvOjeAKrpk4PBKrk?=
 =?us-ascii?Q?ntS27i8qYpJe1ELwScMWO9eywL9i93EXzGG+KE65Z2HgJPvnwMCjdKrtx1fl?=
 =?us-ascii?Q?p+17HAjP+BBPV6T05AuFxWNybCNJyvUAwWbJpB1atC9UYEIdPtiNLrMICrah?=
 =?us-ascii?Q?3LRoT9T+FE+nWdeEUJfx4Dcl7/tOjQV/HTz0tsz3nNLT9/860Ct2HipjDOym?=
 =?us-ascii?Q?dCjDIQdtttVG6YQERqF+eBHuQKfVOcGe4uD1odP2ZR0FNFb6B//waVN5lYbE?=
 =?us-ascii?Q?tP91x61YSMEn+5uzd3pKOV1u9HD3uGPIOY3+HQFINgQUYH8XYs8T4v7Q0Gqo?=
 =?us-ascii?Q?pdgsijiVVbV2Lo0gl0ClbG7GSk2c/SEkYTl7xFqatBHp/u1m4uMk59SvVqla?=
 =?us-ascii?Q?oIh8udBd3D0yUHhptpj9t7X+7rasKy0ZQpH1JggCl+Cmv/8BnoS3N7XdozYR?=
 =?us-ascii?Q?H3n0jZXpDFsBlGS+ZYgnmvA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b005e2c5-fab4-4355-8f90-08de1204554a
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:18:15.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE5kuUQB2nbbyJDlt9o+326ESWKm19aXiS0xotWuOOZVtiJX50t+Zid+DynG2VHyg2qmWSzAKXj7J6YSFufKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

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


