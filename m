Return-Path: <linux-pci+bounces-17908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA689E8C58
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5EB2819BB
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A478215176;
	Mon,  9 Dec 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xt/DLhHC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79108215041;
	Mon,  9 Dec 2024 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730024; cv=fail; b=VYsn+HgdTvzynsLLqKqb5RvdIbg1gnSHx3Jp1xYoI0f3C0nrBTr+67WQA/d9UcjfxiFOU3MRRv1sRJKizweykL1SSEv1goNANysKBkRzsfPUSEZ3gu8lVPxl0MC3mr5jcx09urmPDk3jm1QsIJPVkvl1I911lhL2Pn6eezEMNqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730024; c=relaxed/simple;
	bh=ad0np7rV7Gguix3t2Ps2ejZNuRVU6dLTdPBGZsV2Hbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sP8VzWCYhjWHNBBFowT4H3XJyvgglVG91ptMkqED3qtuEQBEvAuai2s2XWAeITyJC/Ek7Qhgndybkjp7z3QEQge6ZzDZcZ1pOsSA7veHoewt0WLwgK6nmcAgpth9NOUmOvsnV4g0WWzob0qGa2Th1MduWrKZvc5fefIXtBa3rvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xt/DLhHC; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ll3m5i9UB4X3rH/4b4llyri/IdGUZBnoSb4hLffRPXt0c5/nyb4WWR2YeKvYJHVaBwRobjZp6DC5YDZ6h4L7iSL5LlmjvtXKu2iBqzo4/9+jNYfxef6yvnhrTMy5ss6O4HyoW36lrYnBteaaQTj1R2rbU75LfDAH+ECdJTm4ePtscO5SDFkNNlFKTcT99QF2D0nULc03nqTRYX4IxbqNri61prm0hXgBGbtkzPxzowZcNPWcEUvtAMClX3dthqcXzUr7LTo+3jqNd+v6QWh9FLVQIXql87KF5CJ7usvPm60YiDu6x7RIgq2wRS5ec/mau0ot86vmsUTpGErPjv/FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXnETvKY5BUhPageFT8Pvdntsbhs5wSeCgT5SuhCiUw=;
 b=AcQS3JDBEJMmVXnpkUlYjQb8MmOUduoLEzsqZkAaxYb1JDNCoRZ59kWI1XJ/d9Ut9LM6fEU9EZBbxvfrYRWHj6LUXzaPKlON7lXRQbAt3x2T0gbpDlPJCHJG2Vr9M9H75pj7S42OfQpfOtG7RN6talVbasRVZes5Ttdj9CYIwR83UD2T/NMg0J2qnXhfRiL+k/zhxGw/SeO2F7x7CnnzRqWaUpOj9CxvRYd04hW0FZIe9tsvKmsNOtM98Z22yN+TDFd4gdGyTvdZszzgZWY/Nu20dZMdnLu0EXAJe1Zx3E/WJ9+CI1aEaHyUZFTy+M7DVrIeJ/LLOkJyQF1g/wlIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXnETvKY5BUhPageFT8Pvdntsbhs5wSeCgT5SuhCiUw=;
 b=Xt/DLhHCVMyuCDfX8JzdLOXdsajAjQPM2SPhqCuMaLbBJ3ZFupYx7uo4dr20MGsA+jpJY6H1MFWchKsrZid45pHoSWzfg3k6VGir3Y0oPMb+m83UpAGABD1JNV9TTHOPM4lWJlhXA4dIgxiIhjR//lfA6FA0g8ISmVgiAA53yYk9kQZLK1tLo6PnltMIcVYz5THxxhxz63B1eKljHfMjVHCarl2S32Nh77rtZ4VhgPEtP609sSEMbmSXZL2g/3qnMn7vXno26B/LHXsRwSpc9xSlhYN+jlVK2emERI8xcy0HHJAYvpu60HQ141Y3P6eLfPa8YfOqF/GD0IM/sV61mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.28; Mon, 9 Dec
 2024 07:40:18 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 07:40:18 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com,
	quic_krichai@quicinc.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/3] PCI: dwc: Always stop link in the dw_pcie_suspend_noirq
Date: Mon,  9 Dec 2024 15:39:23 +0800
Message-Id: <20241209073924.2155933-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
References: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc846e6-9d5e-460b-c1e3-08dd1824ba6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hHAiXQVQBHLacsTdNiKx39iHqk9HB187CozviKIpsaG730Oyh1GIYCbM8QUJ?=
 =?us-ascii?Q?5CAcIKLqHXmOxTaKhTHPgZJHb8zkTnFQCtIeYAbpmaZ8PyeFUDcEPW66PK/i?=
 =?us-ascii?Q?fxYdxw5AVJLdxfgygbaGD+RLtKFG+Qi/slDcX8zsEOIol5Zv3DTmiEB6bbXJ?=
 =?us-ascii?Q?OF/0GvxY3SF4fKPFVwbjT2aepXEDngA09ipq7sug0lV7nS416IRQvpF4OZ7M?=
 =?us-ascii?Q?ybwFJoprLBZ2HzW69hmfiHsrxt9r3dOGvutdzfd79j4riSKfagx4D68BoRSv?=
 =?us-ascii?Q?nb7VzHUium7MX5x/2RS+bqPdP2qd76VDtoiQ6FqNs0C/v5Dc+oizsn0+N2Iu?=
 =?us-ascii?Q?cM1CWtclFgskQF5GSeJpBIU5ZKpiw8HqbEi9omqweGNVSFSsdulvyzE7idgC?=
 =?us-ascii?Q?otZ0hIzEqejLzqjk4lyno4mqsWUu/rC9X2YUuyHqAYwsXbsG8Xfs1XDViyT7?=
 =?us-ascii?Q?dlUk3oB+NkKmS87dMi5Ujt7Y+a3VY9HUpFEaCoJjSLqhhUbWgZCMqG+NZnAY?=
 =?us-ascii?Q?TJCK0zkClTESS4wCzMZEBUjJq6QV40K4pgWPaOQD14duo3VZFSDeJiwG7dK+?=
 =?us-ascii?Q?yONuOlXkxLeCeFk6KM/eJEDZGtgnNWUuXPnSBgJYSwnK5ICU51KlqxjDvuFW?=
 =?us-ascii?Q?7AsXDle6G5VF2NxdLEP/KBC9CmRbWA7P5r9UJs4hTabnbHmeyc952SAoNiBl?=
 =?us-ascii?Q?NuyqeP8TWueGNkb4tvQXL1FcTgnlCrvYnobB0Od9i+HA6+s2Z+I4M+x9eIQ4?=
 =?us-ascii?Q?TUSjfmr3yhilqd1PHEUe8tu6ZKgXVu+tzbeEz9UTqlS877sYnX7JxO/XWXMb?=
 =?us-ascii?Q?PCFg9dtuNfU4jsHj4uBbBikN2JAwMV/NjDkiR5DasImm4T+vWNT7HsI59Uz7?=
 =?us-ascii?Q?/KoIL+OMcdvlleLIH7GGz0JS1JqQuc8Lh322o1Ca5rb0p3FftH2y7szHFNE3?=
 =?us-ascii?Q?+b/z1GKA5W2jI8hij2e6fFAFFkV5Zdjaci+Vt7usjX/b/Bsob98F0TN4+NV3?=
 =?us-ascii?Q?k/JEl1MgPyVljWiybEanSVPgqyNbh6ks/UQ9rly/f5upIc2V5oLiMqvREWId?=
 =?us-ascii?Q?nAnTxVUFGDqdKvBxusprcmeBjjbYy/5RShrrk9/KVPFjfrgujnF8l2JWBz5U?=
 =?us-ascii?Q?v3paapV4gh0LAbx0bUkDCCRWhyQilyuILaQ4A0pn+Z13SU733n5c4lnIqJmc?=
 =?us-ascii?Q?YR83D1uSbkbGTA+RDKIHA1nXpUS1gqw2j4CnjYYeyvhTvgGzkzOz9nYCecIV?=
 =?us-ascii?Q?zsgHjUXNiwTsxDiwpwbercqMakylvlAVu2KfOwFqJ+L7y9TF72vgP1Y4ol2h?=
 =?us-ascii?Q?AUOoEcwMkyIpiIdR/ofzJMFXUhj56XM0gWI3ws/OWxPiDI1SxNYCGuSRfl5U?=
 =?us-ascii?Q?4OJaj3XqIHMfLPOc8DzmkIHLraqNQJ318NJ44vNWZThTl6eQxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3cwSC63WcAQTGQqkBzTDWtaYuvFlDUOWWipc0Is0kRBf5Pe9F/P0qathsUN?=
 =?us-ascii?Q?otnAWa83Kv/2pQ1gQQlfXN/tJvezatqW+R0yOSK5cXn4BTFDHtajtUye+Bxr?=
 =?us-ascii?Q?dh0abIAH0R8ZgChOSvcaMCizTBPfpS18B5UWx/7PE+rDFAwV/o5a7ruWko+c?=
 =?us-ascii?Q?cTiB7FQNkVMTdy90RKhOJZUi8xrFdzk4MbjTaU8ZcTKtngFz0NUB58265jOK?=
 =?us-ascii?Q?aVic3Zq7jEt655W2R83PiTnCvLIfLRISq6rfKG7KLl4wf8SYg1CG3iKcPbFg?=
 =?us-ascii?Q?3hSUKO24nDSDRNhHy7Ju5N4+GTha33+flkRkSAG7Zuxco37CG04ov4EeBtwO?=
 =?us-ascii?Q?lPQcy2XcBG90q9Kh/fP0bFTAQ0KA6fLLcR6AN/ug7sYKdZd4c9CN8bHO9pBq?=
 =?us-ascii?Q?IGUW6nUxVOmSJp/LZi2sg1lFk1GSdXHi1ZR2F1fZ5tOKMRl+ivcFRuY9DtPs?=
 =?us-ascii?Q?JZ5/jCcvcoWo2+kceE2acKunPvNMxQO0PtdTcl4rAXjOL3HrBRc1BzGKOO6z?=
 =?us-ascii?Q?JPKyg02arT1ttBI/QkcSiqHXn9V2W1Yuhtep3gwIBnai3dZV4A3wGVmGQrhX?=
 =?us-ascii?Q?RwU3+lGyBsQtrZU860nUF10Ns76OLRxjxdBDu/OVZLbcE6j5ZcK1L3gwIOYU?=
 =?us-ascii?Q?JiFlW0pkb8RT1l6jELHy9lhTVPugkpkGjAxmwm6adUBuSJCm0kDDN+W5F8uv?=
 =?us-ascii?Q?Td/KFjNrLsTZ0cq5Uwf8EB6k5XI9wY8WOMsERLsxOdnDY9FdTHrI7aaL3EG8?=
 =?us-ascii?Q?5Ni3MRnf6ycjulql4H4DO6XIRezTnxP4mzlcjCzCfBeGKIQkiHVhMgVAuHT0?=
 =?us-ascii?Q?EzwGdclF8uST+7XjJsVhsmRQJ8stw2hdjbCIAYB7MGLWY/pd7wG+XSM7d7rd?=
 =?us-ascii?Q?ezNfFHhSAzqiZf5aLmsh7300mpdQpQ42pgRoPG4Ei0ve/TJUSh8A0MNqHJVP?=
 =?us-ascii?Q?3UAi9OVqnlR11U1JonDkZHnCLX1ud+Salli+79uxVqxuolrZyQJ0YERiAOox?=
 =?us-ascii?Q?p5rZYnKoRy8lfegFTgkOceuvo9LTOG+AI6M1f7sv5wKGUf0SVFhwIeMvdAPa?=
 =?us-ascii?Q?D7tVSXn23D+o4VntmqdeYHOHj3zHxPrSehoxavHvm7LAO6dWk2ckv6Zrs6DL?=
 =?us-ascii?Q?nVPKZ+HNI/DPSvveMxro7Z40OJaLZQDPBYbm5UhT89vFdqcuLzlvpEIaI+RS?=
 =?us-ascii?Q?NmQsX6qC3B3PCF20DJNfvD325ob+0TspcWiablw31KHHTDuhnb/MEQdqe3id?=
 =?us-ascii?Q?6t/OC9Ir7a0hgMtb3qI0jvung13MXAg//744XKYQOZrwNR7gK0ldbU5efdda?=
 =?us-ascii?Q?Odyybj2Nd+Ha+y+4rxHmL5p4qYekXw3UFw4mFHuq6KxP8USKyYNrz5eJXxcb?=
 =?us-ascii?Q?dguQZjyhJX7q6eqLIG1cR/y57GIKvTo/liL6prXstOqlAeUNp5HtrFFbvClC?=
 =?us-ascii?Q?Sv5FwrtnH1vECz74f6Nf+3JE8mrnruxCcJhsC+ROyR5OazVJskB7C57TUVCN?=
 =?us-ascii?Q?dI4Eu574HPsAgZP2jkx4x4o7Y79Rg63wMhTmvT9JQQZGo7toJkD4UbBF5rcu?=
 =?us-ascii?Q?3o6Vov/scHsmNuDUCjKiripTRpJkyX/ZjC++F0uy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc846e6-9d5e-460b-c1e3-08dd1824ba6b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 07:40:18.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIfjA3eouWTVJDflJ0anJqZuaWmsELC7QjndrG0bG2w1dQvLWOEkh15OdUxDQdoDzT0/U5xVAE/byvjTsJrvuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927

On i.MX8QM, PCIe link can't be re-established again in
dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
dw_pcie_suspend_noirq().

Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
keep symmetric in suspend/resume function since there is
dw_pcie_start_link() in dw_pcie_resume_noirq().

Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 11563402c571b..14e95c2952bbe 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1001,6 +1001,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 		}
 	}
 
+	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
 
-- 
2.37.1


