Return-Path: <linux-pci+bounces-39607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2BC18DA8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1B1891AB4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671D31282A;
	Wed, 29 Oct 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gLJX8LyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67F3126C0;
	Wed, 29 Oct 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725038; cv=fail; b=UKeLWHMu/yj1ohoa/dlrL0o4TwEq97gHHnDGn/xwDbjFLIsU8FuuOGDTtTjtkBFRzZLkHeImO2VKUuxOrnWRoWldVe8JyB4mXmrm1AsXxgf3snSRcvm7vhnLyDaQVaXgcYwuRF1Hcj0gveDaXMWsrSKEoh0D80oBVAWS/V1bFYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725038; c=relaxed/simple;
	bh=kQskWWtIs3dq2QEqSb62M5nTdddcCqrhR2KtArq0fbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aKxRy44xIx6Gmnz8GbDlqL/SyeNB4kHDq/YOWCXyyf702xS+5zRdToNrm2HYCFS0KKcxsQ52u9L3PAHufynTe7A8DceC0iP0O7RZuwP+s31+ocCKIOmDcK0kqr0Tj0loGnxOR/mqz7cSoIUx2wV7PP2l3oM2r9rjn8iX2xJCKlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gLJX8LyO; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVeNcWQfz7aWEYB/fFQM+AwRbuUZ785cS7g99wTVG5fBkoF9XBBD67co3zqCEmDSFsna3m+e9LWXn/1iSkkE0RF43pgZKztJzln6zNkV00tJotZgLJIBiKFviJv0xOb+GrR0yKj0oBKiN/kMZ68okvTrFoeaGOahHyrAyjHE1sBRQroqs18iujY3SJFPtUyloIaEUzH6lDBclHySxMfNW68rWtqMH4EMbMP9eb3frDkxL0fosKM7124iMxL9Xu1PEd4Mb4bCSdHuGDOtayW7CVEpAYwMDuWxIUW1OC4SqHdvHGBvjp9IAtIO1MZUV0aEB8EtO3BTm/2hN5rJ6IRvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I++yll8TSjloR+LP7mQ+1mGSxZ9EZxoJoKEUH08NIKI=;
 b=tVVfwC9Jv55mMUGSCbGV/sUozsi1qX9L3H40JLyihUazKM7g5gqXSPTqnZblXk8UiVZAQZraLhGGglz9FKzj/ZPAWZ4TmjR+4zDrGKnXI+cDVttnz4dFHLJbMBPnzk52UXAFsUvIYCsI1dgcJ0gjz6F/PuE7FHhLZflIA54VDrcDVoJSKnDjYahBzZNNYgQt4lvsAQLIaklkA+kERgQ8fsQ/G68eVb0BpeT5udhCc3jAB0VEYogJxXBz/Jm3tvBLagaWmY0il938+EbSjmkhhkD134nsDuuxNAHZAQsgh3q9wfdwDf6TUAPRQQhzJjLPX/y+h+g2FvzwXVMCD7CL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I++yll8TSjloR+LP7mQ+1mGSxZ9EZxoJoKEUH08NIKI=;
 b=gLJX8LyOS3ZJrp//K3t0olGohoAeI8eUuMmhTIaTBHZVLoyzrhFbzGrCK4z2vkHdSghiGgBbWKobwljRRSj0kuSfWIyUqNsBCkRp1T+Z1QL5Mj+dK9tnfNvv9pXy4XwokL2RlVGOn5Idzggf0styGtwdu8TtPAL3ECPSl4ZWbYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OSCP286MB5086.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 08:03:52 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:03:52 +0000
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
Subject: [PATCH v2 2/6] PCI: endpoint: Fix parameter order for .drop_link
Date: Wed, 29 Oct 2025 17:03:17 +0900
Message-ID: <20251029080321.807943-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251029080321.807943-1-den@valinux.co.jp>
References: <20251029080321.807943-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::10) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OSCP286MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7fe447-4311-4290-9d09-08de16c1b33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Djg/06DasLCbaF+n3GCnUN1X7bEA14UQ8T3HGjHHoCxo+2zMdwA9aDWYWOfT?=
 =?us-ascii?Q?YLDa8xdGVpKW7U0Ki9lbySLuEEGI5bR9iVq0H61N9K1YTmCvy6tED83DtD5v?=
 =?us-ascii?Q?3leFH3wXsZUx6ERsDK+eLd1bzfUTzzKjboCi4wDgj0+w5AMjvilxh0Jy9ehb?=
 =?us-ascii?Q?WYOWyEqFhxjDwSkZ+CrvhJxQGMwhSa+cHN9QxriRjcF7J4o9w7iNk2q+W1s2?=
 =?us-ascii?Q?D7pxAp++gbV5zcznsURlt9ksS50osvzzNxNRTXs76SLF46U0FUVFzxotGl+M?=
 =?us-ascii?Q?GCDBb1couxoJtbjKJPCzZIwC2qq8Sxp2Z1N28G/WMzsbYyHIt6lz6Mgbp2Z3?=
 =?us-ascii?Q?toh6F2VcKuRceHjLAMhbSzWBulQ9V4fdwmPA/0wqqP8aLMnW6P5iU8HoKEl4?=
 =?us-ascii?Q?quCdYb9FlSxvS1fgIIybFbouvLkzgbt+rUsYFZk1aA5fjuOZ0SqCbzl7Ylkj?=
 =?us-ascii?Q?PjjTrbP5LQS21BntZD3e8P17s+9SK5PlzQwGxldkoq2MggCOcfv8Ib9hPXBT?=
 =?us-ascii?Q?ajY/0KGjXcXFt6Xi7KSvtodewg+GkkE6tdkcQO5+eVWIuUz2TcIDz32oLLhA?=
 =?us-ascii?Q?eYUKNK9PkHhZ/fy3dADfUXE/OrNNawBGhdYOKUR93AJ6qbMDGHc/522Gi9pN?=
 =?us-ascii?Q?cTG9TO4hkpEFOR21KQ6N20rClx3ZNC1IT6q1RejTog12DovrZCsFTdC4MIYL?=
 =?us-ascii?Q?T8LgFUTh7EMGf+aWyV0/ZQxHORk/eBNJnvQJzB5V+wuLg0xaEavvrrqescNE?=
 =?us-ascii?Q?vSGOELSbyk78w6LmDhOxe7+E5HJdgEE8gEpBgl3c6i+rjkQ4XwPV3XKqYt2n?=
 =?us-ascii?Q?TeoIF9yju87ulgIOU/zBd0RZgcRe+6CjDWjH4D2U+tLsPxUkTDn3ISbAzt0F?=
 =?us-ascii?Q?feN6kG8vsdjsXggX0QQVf1Rt9cwAAcUMs1K40Z9DQv/GSGq1AmoZZbzhUZRX?=
 =?us-ascii?Q?ZXlmYxniZwrjZCBmP84E/KWn4pGQ7s2UyZrDJDRqitaCyy8XHABqchhXToBL?=
 =?us-ascii?Q?Bmk5b9P9oF3oeRyCdwojvY4dId3yhbmyiWqRe5yaKChqHMzeyekHDt/bkoFM?=
 =?us-ascii?Q?edPToq1f1W94VPlaLvIWQI029k2RrHZg9lSdsKD6cRMvdw34hyTfDnqWp9Hk?=
 =?us-ascii?Q?oN31eQW+D6d3PdB3w+ZRFlQO6wBMJo/z/wT432YxfYyjFZADTg3oN+18YtVr?=
 =?us-ascii?Q?4EAIDCm0/OkcjIHN8pNC5VqH9XPCmBD8JAWslHT59kgPzqLaBCtoqaOrmtz8?=
 =?us-ascii?Q?3RfiIpiT1gliUdLdUdMq3wqr6IDkmI9EGI7BQPfx5ANCV+DMkvziQoA7JIbK?=
 =?us-ascii?Q?bYImfDrHj9L8+rJ091syQ+pUGr7M0ekWXaxuUO1u3cRCvECA4PdZSElVoQYa?=
 =?us-ascii?Q?wIbD/H0DzbMlM7607SnBb68Eyvlk4Q1UQKjobbhepkT9BwIKHya8Tko7Qa72?=
 =?us-ascii?Q?W8+avhzoFyGy5B/6Q5T4wKjLQJa9o9VH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N0sT/2ekOH6unCh+oHKjZ1lRSuJe66GDyXxkC9sb+ABsM/oRV3biXkCqusft?=
 =?us-ascii?Q?rE6j8r82HNqILyoCsColTrRKRvabir3BoO8c7J4O3cdU4GHGQYndBAtYl8tP?=
 =?us-ascii?Q?Wbeb5h0+QAEBbQzsWK5O1lypH/e3cDaCXAjVRu8BRMb56eM7tjA+tAfpM5Ow?=
 =?us-ascii?Q?8q4TH8Dji5H1jS9KNGsTikvVfcQiVyWJk+TqJcwyeHhLjqpaRRI/YE4e94Bv?=
 =?us-ascii?Q?bcC1yzeeISOtuK+tjJ6fVnUUxdOve+NjdJ2dwDod1H9Zz6tzmGgmM34JvMhL?=
 =?us-ascii?Q?7EYDkaDJQvYorGs0GsivuJep0eQH6VLCqNvk7GDy/0rGgdxqJhn3KrSffuJ8?=
 =?us-ascii?Q?LAoJ8dZbctOoxvy+s65MDWV1LXdXenRsCS3t4EDYGWaP4gPUgeOUGR50+8DM?=
 =?us-ascii?Q?UO5YDoecOWP6Kj52TPBSlqDcPNzYh8PYlebA+SWym98fBXCmyNhn+MCDrC+t?=
 =?us-ascii?Q?h0q+CDTa+4SM7U7BXBvDevtV1MgLZNEaSXyDuttXm9BXoT40YsTIOY1ZK4f1?=
 =?us-ascii?Q?X4cSZum/7r+td2DNBEI9kKCmI46HmWiL5VR4wWUGQy3nUVSBgTXezph6Iw1x?=
 =?us-ascii?Q?iyZABRaN/iYhNTT27lkCuNh6/dw5naor0fO16jCd1qtIaL+fPlr1Mj1DgUvV?=
 =?us-ascii?Q?zBW8keTuNAREEOWztoteoAwXGZLuyhgGft+ZKAujN6RiqoJNObKCL/25F9RY?=
 =?us-ascii?Q?Jo2f60M+DHSefPA7gaTU2AkXHY1LeqqNx2oyOiFNcnKuAtsJnZZUSpcVYcsZ?=
 =?us-ascii?Q?tCC/ENXKYYTm4vhdszaDW4wJY232vnMy5ne8Xw0N8B+xg0kgkOrxDykc4QGM?=
 =?us-ascii?Q?nl1rCOIxLNlStsbqe2A1JIociBaHFDcyDS/Rp1V+RYJJj41pI189iwMqlUSv?=
 =?us-ascii?Q?k6byzX5l1diX4DwvhCrmuMLqRUdgfPTmKk7r8anqM5HRs5+LAAmOPVb1cbCX?=
 =?us-ascii?Q?GL69QhjoVaOkMjZ8vprS5N2Pc9eofQ6DM34j3c4Fp+lY36uCcArYZ401Oruu?=
 =?us-ascii?Q?4gR5MKCEBvlAQixRJBwvjXbArioRO9lnTWrpffqwECQ2zB/yEiThrsKP8G/f?=
 =?us-ascii?Q?MNjb2Ql7zRy1fVWwuxXWFIYiOEXwU8q8se/g3e3ZNw2iXviy7c/fCmO7VgEc?=
 =?us-ascii?Q?gvW59tLzYnkCVbj7auJ68wfkjKJWFptAVK3R8MlaJwed6JASxfj66GwSxKXM?=
 =?us-ascii?Q?cdCo/UD7u6j1lcsfKIoojHGaefWJS/HX718+TIUiFf3mwHDIbrcYbEK4RXaF?=
 =?us-ascii?Q?2IwU99fdBT2rYpx5vD6bvFq64H4TSnorfwFC93gUTmkiQ5CXl9VZ7lLodo/D?=
 =?us-ascii?Q?0XWq9FBty6tkCIN2zOn6VkymCeTPYm7qsDz87R1hYVDc+gZ2Db9T652UAr4T?=
 =?us-ascii?Q?/KbtVEPKjwlAtuC1NjCCkC/Mc2EuSFYaM1iuIT7K4KET9Ktd6mko44trTtzu?=
 =?us-ascii?Q?K2sVSEG0L0Pr8d5NUBhRq9Pfx4oE0lqUTkqulbXuO629ddQfDV+deySwC7+N?=
 =?us-ascii?Q?ZlU/cSG/8xIrvdMF9JtnpG7be6iEOX3Y8/uvuB7N+maM1qETGPKFmmGilqLQ?=
 =?us-ascii?Q?m/PsYp+5N3iZXfdFuKtR8lnipwYImWuvQoGKIGp/YYjXOqTvE4Xv9zlAKwmG?=
 =?us-ascii?Q?oW1mS8H04/tViXyd++/dvCk=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7fe447-4311-4290-9d09-08de16c1b33c
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:03:52.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xf6CUE4FRWaKfOJN3x0qGmt7SBFA0edhRxozKt/slvDJYdo5lN0g9WojD//nFZlEUAnO0xrjlCr5SlrFjm9rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5086

The unlink callbacks passed the parameters in the wrong order that led
to looking up the wrong group objects. Swap the arguments so that the
first parameter is the epf item and the second is the epc item.

Cc: <stable@vger.kernel.org>
Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index ef50c82e647f..c7cf6c76d116 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -69,8 +69,8 @@ static int pci_secondary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
-					 struct config_item *epf_item)
+static void pci_secondary_epc_epf_unlink(struct config_item *epf_item,
+					 struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
@@ -133,8 +133,8 @@ static int pci_primary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
-				       struct config_item *epf_item)
+static void pci_primary_epc_epf_unlink(struct config_item *epf_item,
+				       struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
-- 
2.48.1


