Return-Path: <linux-pci+bounces-42458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4CC9A6DE
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753F33A5FF2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722C303C8D;
	Tue,  2 Dec 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GVU0CGYC"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE100302CC4;
	Tue,  2 Dec 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660249; cv=fail; b=EL8Dj2xXkQJ+ndSUMVWGBKlHv5ZKqwPzodZXh3QQ3I7AudnbKTRm815HYkJf7FpHWJRGkkWMUhSVKo9fSG0drPygIrHqrTaNSuucjI2MX96KWe4idvDgxLdNPNdCDoy8oigVxLuCSRQ0o/rNXIIUKiPcFaI1PrHCqrMv40TWVtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660249; c=relaxed/simple;
	bh=kQskWWtIs3dq2QEqSb62M5nTdddcCqrhR2KtArq0fbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyl1V0Rdi6sNY5iy2KXHvVJBavT/jwMYlmeFjoVbpFxe6+mg3smtnDS8jiw2kZ527k/zfW2flP5IZoHeXDvP5aHv3BSWhvgryj38Q5Jw8vVl/dGHOWihZ+QJ4t+YHbjFw+pEnCuxIfufwC/Ppw3HkXr8qQq9RV211ca1VN2FSGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GVU0CGYC; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9lUSVv6tNNV7OmYjjBMjKRt8NeAKiX6dO1ptaiOrNu79WmsnhaOIb9BvxxJ6Nb+tt7SR3WQWjfGRo0DK1Kl0UDVAtNvNOukge44SnJsBEHBf8odrxLJ/mpiZUfahqz9H/egoUizH7riDyoq1tKIBfXUKYxo2yabi4lIExdBwY62edyodOsXqFJULRZAyVpX0hIRwAeOpMupIWQK/KH2BTiCozBbaViuyWEOHw6HyIvWA42PLq6dc21j8b+YnT/5++TLOVhx4fSkD1soKgbrFAoXsZDtuvKfX1oYRGCI39LxcEp4BjjtqAuwk0WY62rLW9ldfl4mMZbbZ7fFVMW8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I++yll8TSjloR+LP7mQ+1mGSxZ9EZxoJoKEUH08NIKI=;
 b=nhA9SlQnP5PKabz8JYab2fK4T/f/W2qU5/Dp7wXYb7ZeN6H41sBcM3ZY4VkE8RA0SdaGotY0xAJZcC8j19DnOdtkVaLt1TPBNkIyN/9D6nxm8Eb5W8JNlrjptuAy35x15dSiuvR5UpF3h42iYAsqDWfTdmxWzJR6cEIZ4kybI5Oa/8BOrARBy0EjaQv/4+fwe+eR62Qr+8azNx/+wS+LwceWninj+CkqfreaFJWR03LaT3u8MZ83U3egshenBxHHvMbQ43HBK+TlVX8/XW4HVcnv3HVl743YA49Y52ROt9nkvIg42Z+mVZXfLlftRHnYQH+qLNjJXKlLiV7Xaq4+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I++yll8TSjloR+LP7mQ+1mGSxZ9EZxoJoKEUH08NIKI=;
 b=GVU0CGYCKjNORmgwOqwnr6J5hbV7LtlSIJjAyyB5DZGxGBjmB9cIZ2VfhjPdARFzvC6Zhu39E49SJ1CI7get1uw8IY8eRM30gjnZoCXplOPxlnyByItdyFDN6IH4sxmH8dxc5gfXEBFW9O55cB18Ei5rIAWnK79SWcHzf7720A4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:23:52 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:23:52 +0000
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
Subject: [PATCH v4 2/7] PCI: endpoint: Fix parameter order for .drop_link
Date: Tue,  2 Dec 2025 16:23:43 +0900
Message-ID: <20251202072348.2752371-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: b01b96c5-5d78-4032-e9fe-08de3173bec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RiD0pcNGrkQaTGCm02N4PuUakgVX0dXtqZMFtBkU+2fM15MD53Ac7GF9tTAc?=
 =?us-ascii?Q?zYg59GMVRXbTKmSLll52nDa/NKkWA3e4Me9FlfcPWGswtTngrPJe8QqotTtn?=
 =?us-ascii?Q?HbHFZORA7oj2uuCdqNYQl5bEhqaRweuSyFrIBHj8cmSG9EKXwBGMI5bHysoJ?=
 =?us-ascii?Q?p3AF/L4e3K0YP+9zQivTXpCad5LLQtcnzcNRZ1mzGpbYQ4AgwPibIN/sMO8T?=
 =?us-ascii?Q?9nicc+bMUqYGpnWr1rPMoj3rZioc3XLciT7s1Bsv18IysplaFKCez2Fb4hgP?=
 =?us-ascii?Q?9JdnLctMaAJnt2V0dokR2/fzT0wrfuj5yi6azDDeECnF+CrYNkJH0yD8+zp+?=
 =?us-ascii?Q?RCinZRC8rsl0AdBSKekp56foR82Yx75G4hN5O5VJGsTJs9uE2jbXKU0uQTQL?=
 =?us-ascii?Q?FDAUSAcsiFCdxEv8hyzYKvv8yHT3wc5tcTCoojRN++mi9oHLhudppIYZNocN?=
 =?us-ascii?Q?epiOcEuEiVukyzfmCBuzi62DnmQaZnkZ2E1BaS0adQtUMfRshVQYjglulIf4?=
 =?us-ascii?Q?SZZ2677Z5l4ZimNil4I9uU2WyudLBHtcjP5xUneYaBilSyTxLQRsJcRq6uoC?=
 =?us-ascii?Q?aGtreyKPXwWazOEpQG62ADgDQPMgi9SutA3kUFqrMWZTx90p7a1V8Tls5VYx?=
 =?us-ascii?Q?BYWQmwEUjY+nNTx0M0fDnfCb/wvDFLLLg4ZZbnDcoWEfSKfqXiw68iQfA/9J?=
 =?us-ascii?Q?c5rHZkaIVLfYKPLXZP4Sg8q0/lgKhqaMFuc5b8oU2dYsNok2iajit0cxiYW2?=
 =?us-ascii?Q?8QgQyXmhrVEBKYhMtqt6gOjM1OkobXs2dH4zWlz7c/y5q2I7rmWPuc0utUX0?=
 =?us-ascii?Q?+bZJM2SNLAnmouwCDs0/Qrq9V/oPREyMkmjzepDyd3iF2uSi4QtNNvcaNEw8?=
 =?us-ascii?Q?5DY4nvz6+s8KjS6adDluJYX24R5oeJwE9lzpWdlzORUCXCZ3aZXJyB9ftbUR?=
 =?us-ascii?Q?tz6JB+QdPJA1YlGZvJQW5ykjRyjyp6pUjZtFIWWoQRq9ZPiVrthEFYq0CiKQ?=
 =?us-ascii?Q?8wnrqKUd9Dkrd1xMclp75QrL257U8Dv7Ii7nx7YMEsub8AaayNqalnwD/is6?=
 =?us-ascii?Q?Mf8uOT55tJvcOd3YoMbCs48PQ/KCrxSl+1lqHSJNhacbIYsTIhMq6CLI/jzK?=
 =?us-ascii?Q?f03hmihodMzj+O87BQC5sgq9maW9XjAO/4aWfQEufWpFqGgfK3/CMrJaMLQa?=
 =?us-ascii?Q?l71Qfkf6OdcuSIdW97jFIPQDlISrVJvPziZHDniEQ8oJBF0apZZoQyQuG+A2?=
 =?us-ascii?Q?ZN1tLNafU9nyRmis/OcW32xfy4d53OENJ8gWtG+ODb8Tkg4ff4uIz5X61oFE?=
 =?us-ascii?Q?sLrjlWwW01g8spq/L81yuOe88HJ50+YWjp4gY0Hu6crPSBxwyKSB8cgOZr9R?=
 =?us-ascii?Q?6z6P4I2YJdU2Sm3FXV+UYnbR85n7kpQdKW3Uw51imUvm79L+zajqYTQVfs3v?=
 =?us-ascii?Q?KCPKSNtQS8ZltdMZqD1TCoKxFYrV3WXZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lx8A6plU7LEKRHvS3+Rob9COdz0R2yyKOlApTp6yEFNC7BPmMFG0Gzrp0Yxq?=
 =?us-ascii?Q?D4lLTfesCLVc99H6lXIlW1coHMVjE1ptqHZtg/4qZGWPzaynlQqJuQ+x3Ywf?=
 =?us-ascii?Q?cGCdhLL84bPRS9MqATRJZcLsUJBAt3tQQfwRwRgYOU6KKbtNEzOxJ69HBvjv?=
 =?us-ascii?Q?nMhsK+DEyQUfFAYoPd3xhvuaXVK3vhhiqhxFKG7AUTRk9dXZVvIV5WoAT3+d?=
 =?us-ascii?Q?tLJf5uc0HSNOoHMxKHgIRYhAn1pu4pwfWn0NzLvH12hFmybhQd7uOBqcHdbl?=
 =?us-ascii?Q?EVgoBt8p+LCkFcBZKf0POLjdJGNEPE8szo7LfrheNk+fprRqVa2cmxa7FwC7?=
 =?us-ascii?Q?62+QwcZD0O30+VHQ97rav0eIF8/m+5PnTo7FMJXorEqAKFgfQp6ElyNtn2VK?=
 =?us-ascii?Q?dzQ1ssnfz+x8NlDbFWP4MuLViWS4HMGWcXp3P6bDtdWtDV2nqsDHsG4zaC3K?=
 =?us-ascii?Q?N54N7NKfG8PzDfaMnuF/7/nVXB3HWtPRC+hZdUO19LDPOmtkZfp9+OCy6B2m?=
 =?us-ascii?Q?KOP5iXZ147ZeIoDtDlWEYlGOZA82/6vughgPFjyozlRqNIo5lk0UOuGCQU2X?=
 =?us-ascii?Q?AWxf0eT0eDBE+wJD5gWIJx8TW1wvG1PgttERDcv4iUkXzHUANAIw3MtGTgR6?=
 =?us-ascii?Q?YxTDItSnocsOik/fbo7yYfL7PbRwypV3Ctvp3MYeRZoa3k4la/zbhYHsyKok?=
 =?us-ascii?Q?hMhHaVFajjROhv4Ut4CIovn7jG3D+D3Wji1OLLLvV2B/+kG8j7kiPN5hHYaw?=
 =?us-ascii?Q?020g64X7x97EhoMHdM8VHYlisIhH0ftNuSRKEn+B89g0c/gX8rLfy+x69iPW?=
 =?us-ascii?Q?gY9Q3z3ClEIyKqRnXQxjN1J6lc9wSnH2y9/hIxLrlBGVqoPS12EtHIjWiilR?=
 =?us-ascii?Q?K7W1h7/PBLxWAe3p5VeZm1Lwa6k6Y0/9KlOT2H3LJQFjv+MLaaJeXf4zMv47?=
 =?us-ascii?Q?RHKzM+YSDdgoDb9OFoYbdUOgy5ZYVSTjxkPwBviPPrPv1hQv5pKLcJd+Ri7K?=
 =?us-ascii?Q?3TTUaJmDY1J8N8+ABfSPoDBE+ea/zAHI7KTuMhlY1UwN1RZxipoAMuL/o9ek?=
 =?us-ascii?Q?z3+POBCioxbASSEKUocf7RqwZ/FEcKma9x7mLIBjpAOYJ9ZeDpGW1QCS36hR?=
 =?us-ascii?Q?M5n/Vjo/p3/EOZsf40RVLjLvp8ZMoVzL/SG4nMxciQ3zqIpcIe1C5kQCyGx8?=
 =?us-ascii?Q?anC3fnxOSxBfgXu1wOLtMxCAwzGFCrc/F2sS5lwgHbF3ZIz2fRtVj1Su1LbB?=
 =?us-ascii?Q?HkYCNjTNET774cNwQGrgME4B4xkJI7OYRzUYImuSvOpssYlJklvdN9VuJ71S?=
 =?us-ascii?Q?HjDCZg/1cfdxd4IkkFxDJce0k7P+3nqVMg+1oUE5JKTj9sIlgXFEj2agxWHG?=
 =?us-ascii?Q?DQw8mcfCoLKdkNR9tFhLH+IjKKZS16Xx1ZFxq3Sp1LcRMesZXaQcF+VQZLaA?=
 =?us-ascii?Q?plgLQVcJnkNeJ/KIBxxY1U3I153Vy7aj7gpxs136VRKtB158B7Gn5wxA3Dib?=
 =?us-ascii?Q?TC+PuikC7XPhwUfpBfQty3GJAwgHVfqsyUqwgCG6RHhQ+OM5i00A6g5WovN5?=
 =?us-ascii?Q?ypZ9vN3Nm20u+KkEkHqYNkfpkJiKfwmpvhe0t6kY0h85fSCsXBvFh8hKXH1Q?=
 =?us-ascii?Q?1subMQ0kxXO7k95q64P5ooc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b01b96c5-5d78-4032-e9fe-08de3173bec2
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:23:52.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIPOoKOReABLD0R10qQiBmeCnkeLia77RyIaz1t3EcyanZqXx+jRB3P3FbOjZP2yrLacMUYFMTbhvikXv8KLfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

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


