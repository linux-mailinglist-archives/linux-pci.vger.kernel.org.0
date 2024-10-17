Return-Path: <linux-pci+bounces-14744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47379A1C67
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B77528923B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BBC1D3573;
	Thu, 17 Oct 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PRK5HoiY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BE1D79BB;
	Thu, 17 Oct 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152159; cv=fail; b=KvmMK4jrgIP1EawAHRwnP9HETEZ4nmdaocYIevlZ85yLhJAInMn/m2SpJaMzEFibM+vZhzOCS7v8ioCCj/fT7bFHyDblr2L+x6kWxDE5eaYLsfV4AXR3gYdUZAD+ahHdZCc+CvJm4hxd1LYurSB2NQ5bi+U/7Ry38ghRZsRjAWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152159; c=relaxed/simple;
	bh=w9A1rPrGzoqvXsGMFIF7atOUKyK/GOjlnyh9QYRa5SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eN77nT9DcNAf8OlI2wIGAgRPfvqgHJTN0M1SV8et/fO+Sm4lzBIIPNtl+ooZx7IeKuh97KJ6+BBeG83/I4mwODN2aFcEB9nYAkP2oNvv5rYgryxuCW6DWS3Mp5YAb2CJ4xBYCCDVCFLL3hESbzfAXMGo4yfJI1Uu7yvmFBkzPUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PRK5HoiY; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0ol8pIDlk9WXeARKOYzy/iTR2TyW77znSLARh/OxjwSofMNJl0c3N4balN1nTn5WS1Y8V2C9SGmstiOIgTCR8NU2i38k2QuxRi5sEEmAsUyw9f9Vr43KDNa4alplEMkntTvD681C4/0M/7aSgiJLFSs7h9rd4NtJOkbDSfFYF1xzMk3yXTLPoT39Bd1jwGclHfrntK5iyj2SJyWYfkPI6zaLTRhgbuwzEm6T4KafeMWlSRPUqoP3rhai1AKrTtUc3YW9YB5NiW9OhVAN7VWP5rjAIspZDc35wzA6sR0smXX0DRRqitCWhk8xC3l51ZPPD7G3/eUtzjOvsSE6Lvbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6rJsFXDQDlHH8QIGYt5cvSlVBPRP1S/RXEZf5RNNPM=;
 b=iwoVYnoTJemHrfTutBlLr9Qz1dZXHcnAy/iFDL32ej/CMYOOG63rh+VSHXJBD1QYmvnXmBzpmaaTzR9gOP1feajYD5Z092spPvBPTfuiNHRUNwv2+tWpn/eGWdmMS9kxmfgVmiFeElpO2tk0XID9UPMjrdBssZz8SRaHx0nGxhKQICfwckza/loMaoSNvlk0IOG5OIX0LPmf5SVSixtZ0H5WrZlKPSLbC8NCaS5BG3W1d2P/Ylj2ekcP9tDL7SznwLcM2+yWpoMXrrv5wIl67oimtbRnGguPOgCdpEna4y/RVBesIX5EQA9Mowjjc77tt3Sm7smUF2ACw7+RcEOpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6rJsFXDQDlHH8QIGYt5cvSlVBPRP1S/RXEZf5RNNPM=;
 b=PRK5HoiYC1CtoxpHZvuDj64H+OLZcXwzJ5XKfRDzK08XWYsrbUDNZmUEVm3R9zWXP6OPZgQf4e1FiI3EhtZ4VUzTSAEwkiWmS/5BnkzD20n/f1BtZ0CkxvWYFjI4vdqcsznFovX3Sp+bnGb+l4onu0vpS4KnxCOYnPBloGX2N9dBsM/Df9BEvIreR/413A3EyD9tr+/Cv7secXrFEKkr1w9Uoji3UzR5iicMB33Rv7hx1QOE+d0U3qJiE1PcisI+LB+SYDkLLpYk/ZscUgDca08DpJTOchxoZMw2nGj6eXwjofr5/8/Qi+O2U7n2xUrLeSKJU3JEDR6sUA2qin8i+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:02:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:02:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 net-next 07/13] net: enetc: remove ERR050089 workaround for i.MX95
Date: Thu, 17 Oct 2024 15:46:31 +0800
Message-Id: <20241017074637.1265584-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017074637.1265584-1-wei.fang@nxp.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ed4c7e-2111-41be-a5fd-08dcee820d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T50MQvbyD+84yCkGI3PGIhOnsADct7Obe4vB1rwi/xvoHnnlsdCxiv3RcZdM?=
 =?us-ascii?Q?ujULMjPQARjeC4YpjvwUhtGD3tFcpdZPBB7pYboXZXm+MO7bmZyUmYfD6qPt?=
 =?us-ascii?Q?bNEBxjlTZHkUcytkqB4piNJ3yKz6kSD2mFavh/nQAeCDEblPOGNU+VJTPRct?=
 =?us-ascii?Q?I/kVFyz2S81A+KXfJyKiTHVjX4X7losmMQL3SbSFmM/Rq3vYKEtrbNuHdVmh?=
 =?us-ascii?Q?p+B1TjpXY1grYw0xigPw5o/0IuyAEucJsYCqQwEgWQjb6+UL1dkQhFafh1Nh?=
 =?us-ascii?Q?v4kabQFMbbkxKVkrQc5lgGE20nUGEvpF5/unST2yEaU7Y5wpXB/BvO7OLJoi?=
 =?us-ascii?Q?pKIsaGWWoN13IUweZPH/45p9XfiH5TROIWrDtXXfFNYkX/fW2aiolPqBjlEm?=
 =?us-ascii?Q?K+8GWzpfp8PF0DpvNdIJ4GfSCsEVwBhnX6DA2rkQxxbst+m0B1BGQJPSkk8u?=
 =?us-ascii?Q?Q6j+S9yvG5yVKyC+PMOMjrd5/GRoo19pYLKeQ+UY5YkGU8eQjdUIpNn7Jdjn?=
 =?us-ascii?Q?dlImpedf2UdKTjVEwhQOKjoQP8lUZ7H8NGhhA9wfxFmqAkvWeMl5ModHPu8+?=
 =?us-ascii?Q?b2Uo+33R8KgMGNgUB0cHRakcNJCL9ILJl6PJ+EUKvf5m01J14y/6h4Obm3bM?=
 =?us-ascii?Q?y61/nDaf2fELc+qQbdWtJsIG9uAbJbBm+2dEp1mRQxMWTo6pS0PzjJkNE69a?=
 =?us-ascii?Q?aETg5x+ofIGFHgIxqYXGqPrTsNly1aYgtGZ2kID+At7trNaJ+sFo8Et7o32f?=
 =?us-ascii?Q?dZmAc+3PVW1Icv9HDBEJpR5a5MCUprAjRkAnkln0mktmwSHGsVQG6FoFLyCD?=
 =?us-ascii?Q?QPcW8gMZArIWmkCN0d+1oYPDfFoJrkKUiBHW6wTSH1l0V5sZN8F0OSod/yBs?=
 =?us-ascii?Q?KshhL6aFQrWuHW9lnmYS8IjbCT4O/LrIHfqb2PGRlkghKAhpPnvfheIUJVmh?=
 =?us-ascii?Q?U7/dQKpTxbJKBBKpKN6xes031COlCrawx268nd+CWMaPeY5jsEqAVB8OcrJL?=
 =?us-ascii?Q?kl+p/atJfSLLVjcIms8oIFJn8cKz8nifJolW/eI3r2SVv7VSK7+00D5A5ar/?=
 =?us-ascii?Q?9z/ZXnIblmDaenDRt8ZWqvg2oRVYgOcl7X4jxM+hQ0EUUHeyuaIO3T6aWFLg?=
 =?us-ascii?Q?HNPLrnDHce/9IdKSQoeL1CYNOOGQqEWlHredqgZ/C9R2DJzw/YVfWAO8zg3r?=
 =?us-ascii?Q?rIXCrRY2TNsIf9279gBcS79TAUYZd3S06TswsHZVBR9bBs5uDEcBUaolnU0L?=
 =?us-ascii?Q?5hTYKu3CUx825Y5hcVqMW59W4hB7VbM9JGKUeXFJ7v2cLHFbWKAIsMPHC+VA?=
 =?us-ascii?Q?uqXKkekczi3iSJut7tqfmggddlxBy9sKn/Ku/dH4hLV7qgOq6c22vl0hPqDB?=
 =?us-ascii?Q?ZBZiCyVq5PCq458fOUvmDy/GPCxQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9cCya68AiV3RZ1FFPbt82mXRT5GvRebmnpZncMxzOMkmxLasLee9zALYO7Y?=
 =?us-ascii?Q?Y1vRO6W2P+8DvxFUaQcWLSuAyn1s9klopJkrK9L/3Puo65NnndrGvzhxaDdi?=
 =?us-ascii?Q?I9foTtcqeSGNrxjL+D0iaKlzTtIaoxHCENlbjD+3nxDIQS8Agyq5RJpOS9en?=
 =?us-ascii?Q?E3Pqgr0LsI/qlFJfaCwXb9Z5ZNezW7xrxKJEQfM9WCbFRPbRulheGsmSRh2N?=
 =?us-ascii?Q?NoEcvsurJBtCRfflqG6diTMnJIX9nZ19N/4fr/B+MtMLsxkVVml4NqOoGBWl?=
 =?us-ascii?Q?PPvXSW6iQPioKee/GITUykVJUYUSNf26rdYQqtnDQTaBd+bswPRznCoMkJBw?=
 =?us-ascii?Q?ffDfxdYHm+ldZG3MElunltt9wadPWiTzX3e4xsKlXmyMB6/K7/bfw8Hx1IGY?=
 =?us-ascii?Q?2Rs1u03J8IypJMRnVLpKMb576ShZSZzMqKV++OOryZxM1fu8X+JMoUUSfdAp?=
 =?us-ascii?Q?UzqSaWHOnLwHGGMbV9IjDlVU7xzfK28FxJZFNIBuZrN3pqwn0JZrrHROTZKN?=
 =?us-ascii?Q?H/p8W20wa5PiJxdJYiowNlAGYGjcNQZlAFuu7Kf9La/+fCoo/TuY/faKVT7O?=
 =?us-ascii?Q?JaXzSWT3o8VTboUq1Tu55v0sP3U4Ulp/I0PBKTf9h8C4Ql13Yra0leUQEJQb?=
 =?us-ascii?Q?hykl9jlFZ65lvv5XpnDV/pHBHCh1G6Wd5kDdzCDRFZEGXHSOjXXh9GfVSPJA?=
 =?us-ascii?Q?jkpfQHS2ZD4g5nj7CSTkEuvBsX66ZzgPIhmTkz2QW1Wvx0wswSjbY7ohu33K?=
 =?us-ascii?Q?Emt9L8rDPJVg0IyCyEaPwacgD7/AKO+lbfcjzGC3eppjqW6U6bpj7vfwtN82?=
 =?us-ascii?Q?t2QyVQe0bP4nViNh/ZCRk/UD0udG7XS4XHZXZ9Puir2k/nhuv0jgi0RnufGo?=
 =?us-ascii?Q?dcYfWcBEkv7AdRymGOM/n2LK92qVVoUwIXYR1+H7FqYVdXwcDXh04JyfOjCa?=
 =?us-ascii?Q?x8aCUFSbnjs8QwCpbW9V7yD9yr0usEtfkcneqGMpw1MrFBGmebP9qKbHZp5s?=
 =?us-ascii?Q?/zf5ieMXNAYuN6p5W3iEdKiAUEOuRlzTWrW4y4alTiJYiCWkSgUcSZcowgwD?=
 =?us-ascii?Q?q9IRTu+bKQQ99obDfEhyoOAfunF2VDKP03QBp0zg2LOIRkKLOpgZZAdkvSA4?=
 =?us-ascii?Q?cFVNNAr3BRTLY5A7XoPJGO6Cwp6dVnyBzksUcRXgxzG7Ud6YsMOgHKE4Q1me?=
 =?us-ascii?Q?c3hPSnvlJ7WkkSnJQaqpgD3YUEhew3Q8l/+bD3IvNwbUSeqdXxAeKYWO0ESL?=
 =?us-ascii?Q?4imUfe5lyDT/s0j5lqwY2Zdu4uYIeNEhGMzzmGC9FGbCKyqIKrtAc0pTDW9j?=
 =?us-ascii?Q?ExQ9pDZcZFm0LwYbvCkDKWHcSlIIdCFOg5xBa/bbOiIlpjKlVVYQeXKL96PU?=
 =?us-ascii?Q?a0rL4cPjXVt20AGx8HkvwyMepLWb0vS9zbQPQko6QxU0sUSnk18sL6vrHCtE?=
 =?us-ascii?Q?LoyjZIGPEEo9Iy9BwtougqvjDZCajzRGZMb6cgyZaJDEvh+XWmNs0B5J+hco?=
 =?us-ascii?Q?3HLZMM764r6yEBhWUW8wqUcyhFpbPZUCJXlQkI01NYNVieB1rjGdwxMsy7w5?=
 =?us-ascii?Q?frl+Kcc3escvT4qF4UPWzAlIUFx4o5Q8SjqJ0w74?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ed4c7e-2111-41be-a5fd-08dcee820d37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:02:31.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXFgK4VhM3GVma+QIMvTrMW1FR37LwxogZP8qtLloFeFNrLaG1iw50zQa0WFMCjIHXydmzlQ9gB4AC6PRwQjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ERR050089 workaround causes performance degradation and potential
functional issues (e.g., RCU stalls) under certain workloads. Since
new SoCs like i.MX95 do not require this workaround, use a static key
to compile out enetc_lock_mdio() and enetc_unlock_mdio() at runtime,
improving performance and avoiding unnecessary logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes: no changes
v3 changes: Change the title and refactor the commit message.
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 34 +++++++++++++------
 .../ethernet/freescale/enetc/enetc_pci_mdio.c | 17 ++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 1619943fb263..6a7b9b75d660 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -396,18 +396,22 @@ struct enetc_hw {
  */
 extern rwlock_t enetc_mdio_lock;
 
+DECLARE_STATIC_KEY_FALSE(enetc_has_err050089);
+
 /* use this locking primitive only on the fast datapath to
  * group together multiple non-MDIO register accesses to
  * minimize the overhead of the lock
  */
 static inline void enetc_lock_mdio(void)
 {
-	read_lock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_lock(&enetc_mdio_lock);
 }
 
 static inline void enetc_unlock_mdio(void)
 {
-	read_unlock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_unlock(&enetc_mdio_lock);
 }
 
 /* use these accessors only on the fast datapath under
@@ -416,14 +420,16 @@ static inline void enetc_unlock_mdio(void)
  */
 static inline u32 enetc_rd_reg_hot(void __iomem *reg)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	return ioread32(reg);
 }
 
 static inline void enetc_wr_reg_hot(void __iomem *reg, u32 val)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	iowrite32(val, reg);
 }
@@ -452,9 +458,13 @@ static inline u32 _enetc_rd_mdio_reg_wa(void __iomem *reg)
 	unsigned long flags;
 	u32 val;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	val = ioread32(reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		val = ioread32(reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		val = ioread32(reg);
+	}
 
 	return val;
 }
@@ -463,9 +473,13 @@ static inline void _enetc_wr_mdio_reg_wa(void __iomem *reg, u32 val)
 {
 	unsigned long flags;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	iowrite32(val, reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		iowrite32(val, reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		iowrite32(val, reg);
+	}
 }
 
 #ifdef ioread64
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index a1b595bd7993..2445e35a764a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -9,6 +9,9 @@
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
 #define ENETC_MDIO_DRV_NAME	ENETC_MDIO_DEV_NAME " driver"
 
+DEFINE_STATIC_KEY_FALSE(enetc_has_err050089);
+EXPORT_SYMBOL_GPL(enetc_has_err050089);
+
 static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -62,6 +65,12 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		goto err_pci_mem_reg;
 	}
 
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_inc(&enetc_has_err050089);
+		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
+	}
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -88,6 +97,14 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 	struct enetc_mdio_priv *mdio_priv;
 
 	mdiobus_unregister(bus);
+
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_dec(&enetc_has_err050089);
+		if (!static_key_enabled(&enetc_has_err050089.key))
+			dev_info(&pdev->dev, "Disabled ERR050089 workaround\n");
+	}
+
 	mdio_priv = bus->priv;
 	iounmap(mdio_priv->hw->port);
 	pci_release_region(pdev, 0);
-- 
2.34.1


