Return-Path: <linux-pci+bounces-43981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D7CF249D
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 08:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F580300EE48
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E42BEFF5;
	Mon,  5 Jan 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="u40vnNte"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021076.outbound.protection.outlook.com [52.101.125.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CA1F63CD;
	Mon,  5 Jan 2026 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599775; cv=fail; b=L8Fxw4vodZYK8Mb7ZSoCXPl36fCTpL/8P6Xipx4LieqbGnmZtYrc+zkjha+oeO6aGhkQQWyxwKdL5FKedd8DWNAg47CeEnUX2PasW02WQE4gbms28WcKFamyHKWh3ump9pbfraDDt1HCop8Xs7gqPhVfwWIjxVe8qow7o7onOxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599775; c=relaxed/simple;
	bh=48UuQNB01rim5fOf0vWPIe3tHMysj8ThNXz1AwnjftA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NcNMu4ugYnkrGj3gvPjzIXWEDrrh1OuaPQhYQ4YuwnrnULfvJmiD/xXKx5Xl+ygU1MXmOvXfxIfdXVV6WYyEJa1i6WACDTubKjdNg6bLU8hEXON/ZG7h+niEcMPS2IFVUFA3Gibl/lYLWf7ile+gFpwODyzG47vLgnvCnB6QPX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=u40vnNte; arc=fail smtp.client-ip=52.101.125.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKZ7zY1aOFdxbYaNTknoHgTakPRK8cIUtzLJTQjaDDliIfi5dxalnPTOmw48vndu+AhkpjBEWEDbpS51qQmHUXY9BGJ7ppr0DEd0haqKqgC0pTwnraGOgGMgU29EXh3zE+HgfGE3kUFxJUuUZf+xY8CHeIqMBLzXVKizPLwa4QnlETOLJB/CjnBoy7UWoVHL+s3Xwi1FypgIpb32o83stxwMmW61eD/PmhaLUcdRa8QiQwHp/3nMKOytp15mpMWLqwKPirgXiCde5LN2rCsMRJyNGtUADR2xwpG5JUq7btAQGo0H7WRIeiDczxdoyOkmQf/Ck5ieAfy4Q067zPeKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3uOyV3hKcLDbY5f2m0yPwooy7xD7vzBphEhwuPXRBI=;
 b=TTM5+R8MG+nuEOOrfcpIqs/ECTBd1jBmouF5Y6XO4p8O5BoIVZoXPzw20+IqIrYR9A+uvGJJec3GR0mzobZuF11srZ7inRvPkwLGZ1lpVRnit/gjAzbvwUiST3vxC321OSNKZcuPglZGGVo0E6mYiI43861VYtL9Vaax3DiD4lG2XQJLwHKM+AvVtwFBaz4jqCGOOqQSusnqzvPraw9majLOMEKc4bnLpztdGAFW4VFbrFC6w73FUKlkZJwoWGB4FayXm47HyLFt24jo4+BeWXFc0+Yl643TwNwmzq9ZGvLxpSpSLg8l6Q57OXuVwPNMxBhQdUdFruauEsk3OGD3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3uOyV3hKcLDbY5f2m0yPwooy7xD7vzBphEhwuPXRBI=;
 b=u40vnNtePcBVM76fRE6vzC9m+/khboZAe7y7VHPf5YIS2MIkl2JElztzqwr49JH8UuLHDRyWANN7DqwOvWZEVvOwmZ4FPKh4f58m++buqg66AoT1mOSM4widr3ytuGnHqUTZ/tHMjunWCaMSsv/kvLn3q0zZKM801D70R1vKvvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6511.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 07:56:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 07:56:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com
Cc: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
Date: Mon,  5 Jan 2026 16:56:06 +0900
Message-ID: <20260105075606.1253697-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0101.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d14aef-0018-4859-d575-08de4c2fe3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+YlnoCbb33o0nu5+NmofwfCq022quLwp0xU+5cB8STgXZu0mEW00j/hgB8pl?=
 =?us-ascii?Q?7DZ3Owfa4cldKpQAicGfDXk3ejj4/3gLoYKLmaROxi/z7JnYByG9n4RYPfxT?=
 =?us-ascii?Q?3DIsI3sS5Yt0oS+w7TEvpSF+A5ZJ0DCEArwJAuc3EJ5AJNxQXQdvvr5zqFwa?=
 =?us-ascii?Q?OQeo15ksQIpvJGZxG4MQSNtgFMszEXdh+3UZ61uQH0Z7cRvRIHaJcNpMMoT8?=
 =?us-ascii?Q?XAXJ7gBvusaV88N1c4P09BdIoPig31o+b4MDmD674X+mUZ0zfYQqS6x5fnK2?=
 =?us-ascii?Q?rw6s6jhesFbpOTSvh4RptX8HVS5yI/2fa7W+eaNv1sAawrLCxJQHSbivy2vv?=
 =?us-ascii?Q?wgAs3f92J+gq6MXKsy02tOQqgbPbu5bbtvd94KZBC9Fahn0aCrkfxuPNLUL9?=
 =?us-ascii?Q?5iad8lTiefeWrax6zNM2I5BB3m25QqhK14iP0tKRUxPdNvKqERyRuBqrv/Wq?=
 =?us-ascii?Q?8MPaZcPBDoD+lzx38C9fMbwh3OMKzgh8UnYiqMgnwhuuMu5AiOULG+mOBKPF?=
 =?us-ascii?Q?f4qeMkzrc5TCVkH2otRt8WZzeBjEezehHPlMl1ijqrO1IFAnJbti+izkAAid?=
 =?us-ascii?Q?h/zg2H/l98E6316WkjtDvqVe0rNOynABd+A2FZbPdnLuCpmTsgeuzJP9Pr1n?=
 =?us-ascii?Q?CtYilMkpWNpYE9zn7FxxPr1HgIKg6COSVjXarg3Y1zV9o24hpVgAt9GUgrvC?=
 =?us-ascii?Q?jY+xdF232erp+TsO9Z9jIBKsUFcxiULiYh4uxRPSdydf60h3m3GoHhyWuGvM?=
 =?us-ascii?Q?L0yF3bAo4o5uA+uWnwuBmFQZLOqnR6hBOD1MbzxtmlSKxdEqb1I13wKa+8Qs?=
 =?us-ascii?Q?q1F3yAPE8I0uAJzFxWLpa6m1kiEOkyuCoUU1q80BY9xT0D2EjzWLeCOhnW9I?=
 =?us-ascii?Q?2SXSg+G2DfpQB5MJrbN4F3BriNknZMayg2hr6rMtLL7WbXn6+CVP/nuOvmze?=
 =?us-ascii?Q?1zlgnZE6kyDcZGbl6U8jjnzqzQL8d56PflEtDNbpIDYnYfiFsFH4eGisQvF2?=
 =?us-ascii?Q?7c3hCFgBfMCcq2aKrJSs2zUl6M7UFgejRukAkYYVZ8PYxy3Qiebd+JwQkBB6?=
 =?us-ascii?Q?d9nqbF7e48NwadEcNanzK5cUts27zkji7Rqt6Nn1jRYpCxD5XEmG5q4/J4B0?=
 =?us-ascii?Q?2fVD2PsRagQXF/TJdk4YpSOdMUX9nWuhoboPRuhlll2L86sl33Ieq/HQrSLU?=
 =?us-ascii?Q?qtz4sIxSKOgCAoHqBn4cHKPtD540+yaTjugq+w4OR5uh0U1E7gog8qBTgSjy?=
 =?us-ascii?Q?egycvhAJhRAejDp5pFTbjzCywfUAxkZxg/dhl8/cDhSCy2fWOd/pqS7qdMvV?=
 =?us-ascii?Q?ipwsvRuUssMSa9QQ5CWziCMetY0/TPbidmNcrRLvUHuynWQCMNfp9lOmvy1r?=
 =?us-ascii?Q?3lo6tcAzc2cXCFyg0oDgqPZp9ytjvHGHVrPoQV/ZYTqRWG1r6nEKhLyJEMm6?=
 =?us-ascii?Q?ZnVRr6hJR2+zkji1LF3rFYXJyxnLj6ef15fmQpMh0+BuFQhNaLpNHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ddZIj/p5D1X1vyfFIGME9MlM+1fQjDl+PRjfLqLH0suF90tdlJJgJ5jtS04?=
 =?us-ascii?Q?fmwV/MRd0i2WOw1jiW9jLSBBdedUEMj7lErR3WkS1RXmTewL1OvujR8W5oTB?=
 =?us-ascii?Q?f+g08yroQydwIe5DeW33mG9Wb783E9IkoZbw/VauqoPOCnI7FpBhJJJ/smZ3?=
 =?us-ascii?Q?gYiNbU+wg72Al0Z8nSWgphTSr+j+eKbhhgUZsELFgr6V4aQC+lKr5aYCJwRI?=
 =?us-ascii?Q?B/9lOc8y8jsdw+hwHK5DIgmEsqj+a/i+BSssWi4C16V0/NGvCryegLR+DZ6q?=
 =?us-ascii?Q?JzG+2BE0S4FoLJHJO6sP9YbqkNMCqaSCIbGxgPj3t27sR+s2jBeM0LkxWLHN?=
 =?us-ascii?Q?e0bzMY5sWegUKF0Jh/HAyGASDGk1S8lxvr23UZJq3YVkAIuHiiP79JHSLDp6?=
 =?us-ascii?Q?CTRQQLZguQzcfrvBiur4V7jfXEZlWO5UffqUicvXsEhtkXOFKGH/oLM6oBKg?=
 =?us-ascii?Q?yHEHvlxxElQMFPgkAV3SMpizXDPbT34ymYvAQhrdilCJzgqP0bMCk+lieKw4?=
 =?us-ascii?Q?EJJ+N0XomDkQOv9ZSfldO1XDM0W2kklY6SF5oafY2QVIW0N7AP2gKelMitjL?=
 =?us-ascii?Q?O/qQuvSGuzVJCjbHLZI+cujuPVfK917FSEJVUPbtb5QgQzVQxPSQTFWbx8vS?=
 =?us-ascii?Q?Ml5nx1EfQS5sC5ctnQYUlgOpsibqKoZfni72ptnc5vU/lnooOUIqmzOQdLwF?=
 =?us-ascii?Q?8M4ZUCelqOOICjbzUbRybU3lE8QcbBRSDajnvgfZuTGO7YT4z6Ji+//HIvSX?=
 =?us-ascii?Q?8H0wHhnBoJZILtwuxuC9tTpEz8w6lPGgTN5pbJWvyGUal7Kl+KkXyUXf+Cn8?=
 =?us-ascii?Q?bNCCWEUXudbBAQK3bLTh1Tp1ecpjr3vvzwtTcrThBIcsL4QDkMySce0klkv9?=
 =?us-ascii?Q?7AwAyWY/5LJLFu8qj0zTliV8x6tEx0BLlHzNKCpji/tQ2cZcqt72Wv6pn+6a?=
 =?us-ascii?Q?jkUCfTbnKZhDbNBQyUOHj4Vq/Ce0Zn54b8+odmZB08z4sH2WgEdyENL8UP07?=
 =?us-ascii?Q?4anof98IwiwYAcaFFCyPPfM56sZSK1UF7y9o8fIE5gny/ZIKS4aaSTMxQRyz?=
 =?us-ascii?Q?59qJGT9CSNTAsCT5Pq1KbyE6WK8aIihm/5BAiCspa+M3+0PHIgFg36515EQj?=
 =?us-ascii?Q?QBtUr5WeGWUnFVhfM0RDBbKJUJn/lWCkOsmonYzwyBJquohPuIrGdkYePvrZ?=
 =?us-ascii?Q?wbAh7yI3ry9Y4wGQKPbX6vlOxyBfeUd2liyrL7YDWSYhCpOETZg4IGgu7g+d?=
 =?us-ascii?Q?fH2GArT2fkzVgjYCMDVORKFjVz8w7cQy6BizBQ+iUCZNB8Fz/CQgySgg3GPZ?=
 =?us-ascii?Q?1eEB0yodH9xDhAJNhle7njnRfIO2wrqOAZ7dSQ1Q68Ok9eyvG7GMtoMvcnm7?=
 =?us-ascii?Q?lNlhTpj5kFLvgQdft/HRviD0zFhDfv9VHiWC03DTepNXOCSY/ZG7D73oreV7?=
 =?us-ascii?Q?Ywpc5hbkpw1Bve9vNaYjn+qmDAsY3A8luuT/2YueVJlLCMx5JGBLFfLWxpmI?=
 =?us-ascii?Q?ZKq05ZzuIsfLjfF2GSgTDVfuWQdmRcNtEOlCG1GQD/YqnFKAKaGBvtPO6Vq4?=
 =?us-ascii?Q?O2eoyaSo64hR50NUu8B8ip9JoPdKzK21a9rSvj3+vmfpZinivJWqFPnf54kc?=
 =?us-ascii?Q?Kwo6kbYeX2qn8/MzAfG79dFh6z3QhSXxH4fJLwdjKmx61kk39YSosk/23JNG?=
 =?us-ascii?Q?Cp3JSFgNUDZ0wq6iGKmAjzR85TjLtySsIDCUJtKYx9tkGw9VGk0yjVyU8A/D?=
 =?us-ascii?Q?emT81X4C6g5Nn+owQLofpOYYojk6y+A=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d14aef-0018-4859-d575-08de4c2fe3e2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 07:56:10.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNbQV1RYge64pV0CRkywQnNSoyr15+kqG8mMRFZhrY2xdj9gU3bMoVANIjUb/sJTnr/zCKvv+XOIag2p6+BBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6511

Follow common kernel idioms for indices derived from configfs attributes
and suppress Smatch warnings:

  epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
  epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]

Also fix the error message for out-of-range MW indices and %lld format
for unsigned values.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Base: https://github.com/jonmason/ntb/commit/68113d260674 (ntb-next)
This is a spin-off patch from the following series:
https://lore.kernel.org/all/20251217151609.3162665-2-den@valinux.co.jp/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4..192dd4f4de8d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -876,17 +876,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
-	int win_no;							\
+	int win_no, idx;						\
 									\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
 									\
-	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
 		return -EINVAL;						\
 	}								\
-									\
-	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
 }
 
 #define EPF_NTB_MW_W(_name)						\
@@ -896,7 +898,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
-	int win_no;							\
+	int win_no, idx;						\
 	u64 val;							\
 	int ret;							\
 									\
@@ -907,12 +909,14 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
 									\
-	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
 		return -EINVAL;						\
 	}								\
-									\
-	ntb->mws_size[win_no - 1] = val;				\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	ntb->mws_size[idx] = val;					\
 									\
 	return len;							\
 }
-- 
2.51.0


