Return-Path: <linux-pci+bounces-20291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA17A1A7AE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701E7188A42F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA135280;
	Thu, 23 Jan 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rk2trWcZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D18328B6;
	Thu, 23 Jan 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649003; cv=fail; b=JayKiY7xmF0+tYFBP0bodqfBoRh/gdVJ/woBj6y9xwhP0DVyDxdW8jf7YrR8h62DbeRTsUir9w4YkDBFiLbw1A99q/6yj2Tk+oVJFcJFm60CJBqSA2fA0ZSQfkqe+DUE6NWLQ/LnMB/YcbSDRXS9mlcZ3iGRGJhaOdOfkqxWW5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649003; c=relaxed/simple;
	bh=fQ8H3e1CtaTNJuR+iRXAw9gDoAD7A4DTz23ap7qzB5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gJ8u4sppFK1YltqRNpbcAfVBVFkejr6RgEQIZrrXfynsh5wUOPuFf69pbaNgW1/oJX16Y0mYx1PXVZijYy6T8EXngAUtoCZ/tkjgv5urs/zXkOeXqGkjE8wmq0qHu5OkSVjeKakSLwIXftfwvNeF328JWfObUUJqPB1W+zYU2Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rk2trWcZ; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbv4eQfiKOxZoN2anW9f+4nfDCeCIklbMm3LPoNgtaFkSUj3zpVDk044hzOzUsVC2PHRNXNF8qAFZBxIJZuW85z2EOmU+90Uya0udo3RRW9ap9QbMMNxzkJ9/LeGoECqQIWuUH5XL/LMyKbWEgq5GwsT1DKNgff+P8zlqVFkiLtJYzGeG5IV1I69obDS1vjrdRF8PfHbwHkmRsZnrBdiivGR8KkEhXmofK1Kg+RXXZz+mHJ6o1wNpQnD+1gFTJ6USd1pPR/KwVWg36mx/+cRJexDJftBfnw4lBV2ZOHy9QteB7NWEFZw8i3l3rnqEslT157bONArtusVDuABVt0QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLbLgPyh+k//BU3awoBJFz/UdCSwX8WHShik/q/FA5U=;
 b=XFJcSVkfbOC8AAgV6Ccm2Q0CeSGDwWerL/syROdMUd0Q/TDiQodGwrgqT5pXpqcEB50FfWZJ/7ZJYzFuu0A0ZEpVosqG8/Q3jSyMAuQro2OBlMz7mOXdgYxEIOi+/SpvMH08ShfuncM/hM2Gu1A71KgJD90TvdVnvYv4ScvcwWTqVKc7TAlo7rLv/08+q3XIPVReWxSoLIadePZZkQhs+CA4cNqq06erloC+CTximRbWSbw3+orrgb0LlvodJFIA/BVyP4gH/373bhRr3wTx+9sgZVSiuYhkHI1LaOHcBEtcnB+pY/E1WORlNym/q0RnG0BTJey51D2R1+XcASXGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLbLgPyh+k//BU3awoBJFz/UdCSwX8WHShik/q/FA5U=;
 b=Rk2trWcZlZsCm7LvlYDAtLTqkaCTIJInE3KNGMzNYfviKZcl4pXfLlYdu1EXVnKjK7WMG8B9qqPIAKfwKbtTetOOunlbV5kwrSiQoLvUYBWcAcQxBspemAkR7b5BJMsslrcmiEWJNTGvHalWlJt+LkIelFMRbX8DI4JuNq/SOu/bqTHVeg4HvaLNSR9mOO2Cmsx8rSy2am7FqSlJWrOE0w34ZaRqTegVDvfxkzG1ObJ3qA7YauksfXa/WwGt2MUxRtzOpIBEfrZMYtboZo7LKbALJBLHT8SEiq+o7XHfmC61izfXZ5T8i1oU9JpTx6Cp0LEpASbyD2H92y5qvsJYiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS5PR04MB9923.eurprd04.prod.outlook.com (2603:10a6:20b:67f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 16:16:37 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 16:16:37 +0000
Date: Thu, 23 Jan 2025 11:16:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [PATCH] PCI: dwc: Add the sysfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <Z5JrXsDDM2IManp+@lizhi-Precision-Tower-5810>
References: <20250123071326.1810751-1-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123071326.1810751-1-18255117159@163.com>
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS5PR04MB9923:EE_
X-MS-Office365-Filtering-Correlation-Id: d27a189e-2b1c-4a83-d972-08dd3bc95003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OKtwTJG/u64T3zPpugB54IyxvIzULDjKd68UoITpgJILvZ/1kJaKLKK1XqJX?=
 =?us-ascii?Q?NmDa5P7Ht9vq4zsKJjYLiMYxJSJW5RHK8gIyhgIaWYMn1QYqYj2F10t2B98q?=
 =?us-ascii?Q?z0pT5Irsozu1q3sT5nFdAkkzT3Q5ACe4fwbjy6VYCU2GyAq1+1UQ4ugE+fpH?=
 =?us-ascii?Q?Qi3hE/l55R8JJILpg7pDclFjnk+Tw6hQvBCTm7F5RbTn1TxbkmfOaMryVe5t?=
 =?us-ascii?Q?TRF19ZEYvEG6K5YFYsHeS+bP6nXh7V6WYOA7bnMd+49Fvop/98Q7spZC74WT?=
 =?us-ascii?Q?NFceJ1SEOftGee/Iv1ieTZCTxVJe/4eduamKKI7pTqmK7qVASBVa3Ml8Z25M?=
 =?us-ascii?Q?lRHtTfyrXZSNRc80yxl+qIGYm+5paYXtjmavlbiQ3TidVyASqQ0BgMspqVlE?=
 =?us-ascii?Q?SXle5PpVh1J3051hvi0Q6OFNNxvCbORmBko703LJqiWCkLqHuAsdeW/fSbl6?=
 =?us-ascii?Q?4pU3O0eECAGBEQrw5rNHQiPACstFHuwYxo1Mxu9t5O3ZVk+rlGWM3k5DTooF?=
 =?us-ascii?Q?udIxcLn4+ZvRU4zbj5Sy7ubpJAEarp+FbAHq/gHZ3M8c3S2XwUY5SFyTrwiH?=
 =?us-ascii?Q?sixoyhyV8Yp6obE3RRi9wiuq10C3qCepyAzHezlZKFr0mKq18210spJUWQ57?=
 =?us-ascii?Q?JkGF6VELD9Und/Y+IHA8YrQuv/2phdYf26mIsFUtSZRp8AJxoEZCDcfI7HTv?=
 =?us-ascii?Q?hagsI9Bu8r8yp8wAoIlWluwrWFtmbivRAtkATwAr1HaXQHgx2uUJBtvU7wDs?=
 =?us-ascii?Q?bc94rI/Isopu/KhwyLHMP9DD98TNKCqbIwk67O8kxoj1yZgxej4kVWrVfHtp?=
 =?us-ascii?Q?twyj16Y4bZuqtrryddZwt0kzxZJn9HilOnJ709Ng/PhTd+lp9iJO8McIUzvU?=
 =?us-ascii?Q?UjIhILsC7Ciix3RuVj8ROqq4v1VNx99ooT+FFEMsMq+G+TMRTFEwWJyIX3iJ?=
 =?us-ascii?Q?tnC78Kwz1uCCHgrol5OD7HVNfvJEhsb3Bh0qR3ZAlipOGEfKC3Zkn5EvXAeK?=
 =?us-ascii?Q?/NDy+rchEXmb/EpvSZFdEXQ4sp9T6XlGPY3KWFEWSgF97eit1/t7p3h9UJnj?=
 =?us-ascii?Q?lgtxS+2xhqJ1VudtnH4PRNJwNO7+ahAyq1jY3LsWIQUnxbN4d/S4rm7ROfis?=
 =?us-ascii?Q?xw+QdqvwJzcanz7/oiWio2enQKgMEssCn734hrx0ux1Cbaj3g2Tn9OgFv9+o?=
 =?us-ascii?Q?Wk81agZgnA8Kl+WVUPudmCTYXYcUofThgZ5O7Gdv8nVCtCZR4F6mUUeqoXr0?=
 =?us-ascii?Q?CBQizChH2Oa1vwXUNlpK0zKWSdVIqbQ0FcRJjA2fXcSeXo6m2CkSxaQm1mNm?=
 =?us-ascii?Q?vhEBvGWFm5FkNPLyaj/oTbsSJDUGpE/ZGZ1/SOvUQFsFK+M8EM1mlJKOSINT?=
 =?us-ascii?Q?JFGYjA6cohHWiByoFIOkxAgegxUr9wJpwHh6xxsIKQNrgJcqv99dCmvk8BHx?=
 =?us-ascii?Q?x+jIp4B7lbbIe/BMcMdW3ZZzBtsEhY2U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mBMymhaanGkGzYrKlXkDu4xshJwRpqlnLZHYcYJb2aXlyk1bm0+fHmyTBgUm?=
 =?us-ascii?Q?iaV3x4mKGrko/uC4W5F7xU1nNVr0Bm/GQce3GOwo4n5k1z4j/detyCpGiFly?=
 =?us-ascii?Q?SW7Uf+SEk7LqDSZBfO/OhdPM7a7V1/mMjH+/MD80acV414Odh1CNNHSL5AV8?=
 =?us-ascii?Q?nFt0qrVGjNH2qExUOlvOC2F5m2wZeqSjs9nKFgS0lbOVymCI8M3gPoY5mRSB?=
 =?us-ascii?Q?jZimvqu6jQtliAWZh5BgELcVu75Xg50E/KylJNWDhSjCphEgvLoHPawT3l28?=
 =?us-ascii?Q?q8YQJpnnXKdpMISmQqAy3UofmJAHWW0ZoytGy4S9abiqIkSQY2v57GZ+Cv8D?=
 =?us-ascii?Q?nXmZo92N4MyBOPRwAccYfyEZbbbzvBXcH8m5zd/WErm0pwscMyZx2gyf3oI+?=
 =?us-ascii?Q?bSlIPsFacvO5RIS4K35dxiWuELLDzHtW3vt/EfAhFthypuTbV5GfCTkOsz1m?=
 =?us-ascii?Q?HOuHl3N5bjOLKZPQTFP22urjDUc6N/cXfGhDn+iTWtfSdQnZZ4qzsXmz2uKI?=
 =?us-ascii?Q?VNxEiEx8WCAlMcILZHLVNCpGUvw92Jr4qme3QWZYXwZVmapDw7uwBlwhfX8q?=
 =?us-ascii?Q?o0qcVvru+PaDzS34LkxE0P+VDe4/6Bp5imusgRuxZodoJbtqHJoyqvkvskn8?=
 =?us-ascii?Q?OA4tR2nC3aqKlLJ9NGBW6RVsJBzty+22/zRhxduToGbIDoKVzn7ctzUFvPgp?=
 =?us-ascii?Q?f/qBclAsGWL61hGHG0nk67ktlbABQ0DO1qBFPZBrAlRhuNCoJE+6uLcB/Omx?=
 =?us-ascii?Q?bDv+6QDVn9KCsQDwroUW+FZ13u29ToXSfHYIjuT9NsoAvYKGZYp+Cag6FOJV?=
 =?us-ascii?Q?6P3L33eEcdnTTNse6GQrvV2bOwUpKKZzRcyQ9kwMV4HTYY/i7sW0yaaDWvmy?=
 =?us-ascii?Q?BzHhwgKch8bGVA+VgWJvrviufXxan1tSikIBA385/PvwXh+iSJpkCRJEGXhr?=
 =?us-ascii?Q?Jn2ZiA56Sw7LkBCjPD9eFEOaunTO7VuLfUVtZCy+6+JHoN0foxKnJZAX2nho?=
 =?us-ascii?Q?2RMuqeGtwqlUkCo/yllDONK1SbhPsjMqaK+t65YfkA+/+zuUuuG6kPK7hJFS?=
 =?us-ascii?Q?cfsWLCemium89jFyjySTNYAqSLK6jJdAZy1s/TLT7DSJPLsQc+yxg4SgZID3?=
 =?us-ascii?Q?zLJsn1fzmiBcyjnyqaxvVlsjwLRkrsjhI6h/zmXvPi46HsBEjuPK0l5N+pzm?=
 =?us-ascii?Q?a7IlA+g164PnMQIzycrgQK2+EaYTF0ndOjuhm/1Iu21vq/trUggEOqXySSIw?=
 =?us-ascii?Q?4eKCxWT7qOWFIGMdJIsuu/RBVhFeSPlTmSRxTBmp3QzmWkxxH0vRBKbbi8r0?=
 =?us-ascii?Q?Hw7AWOZHC1nOwUtyySggsMLWpnHso6lTw+L6IvHRcgGV6GVIRPH9XQvvvB45?=
 =?us-ascii?Q?hfPt94WsNLQhppockFiYI21cRPMJtDoLjmyhKGABPvLYNnf3E+bwVhZw9mXZ?=
 =?us-ascii?Q?v8zdmeNC3XwsJd+EH1mhG25Osp+zDqd9hH8J0bO/8zYYhIdCMb0+Sjn2pDVv?=
 =?us-ascii?Q?o0KnohHht2ikrOuNtXGzNLHI/6Ff0IFveR60CP/mKGc9O9hpNiJHsyl+vwFl?=
 =?us-ascii?Q?X/7Z7/FdKeOQqGiPHf5G5lf9ar4pwHUkF+P7k7xT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27a189e-2b1c-4a83-d972-08dd3bc95003
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:16:37.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR1qpQkPzKp0+1zb6/XxN921x9WoGQyiQNrqjvnFVb0QH6L+/RaszWJ0UFlecUVvxZV8NwuygrtNxUwAbMuyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9923

On Thu, Jan 23, 2025 at 03:13:26PM +0800, Hans Zhang wrote:
> Add the sysfs property to provide a view of the current link's LTSSM
> status from the root port device.
>
>   /sys/bus/pci/devices/<dev>/ltssm_status
>

Thank, I like this.

> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 86 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  | 32 +++++++
>  drivers/pci/pci-sysfs.c                       |  3 +
>  drivers/pci/pci.h                             |  4 +
>  4 files changed, 125 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d2291c3ceb8b..8ec0e35cca8f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,92 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>
> +static char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)
> +{
> +	char *str;
> +
> +	switch (ltssm) {
> +#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
> +	default:
> +		str = "DW_PCIE_LTSSM_UNKNOWN";
> +		break;

I prefer
const char * str[] =
{
	"detect_quitet",
	"detect_act",
	...
}

	return str[ltssm];

Or
	#define DW_PCIE_LTSSM_NAME(n) case n: return #n;
	...
	default:
		return "DW_PCIE_LTSSM_UNKNOWN";
> +	}
> +
> +	return str;
> +}
> +
> +static ssize_t ltssm_status_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +	struct dw_pcie_rp *pp = bridge->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  dw_ltssm_sts_string(dw_pcie_get_ltssm(pci)));

Suggest dump raw value also

val = dw_pcie_get_ltssm(pci);
return sysfs_emit(buf, "%s (0x%02x)\n",
		  dw_ltssm_sts_string(val), val);


Frank

> +}
> +static DEVICE_ATTR_RO(ltssm_status);
> +
> +static struct attribute *ltssm_status_attrs[] __ro_after_init = {
> +	&dev_attr_ltssm_status.attr, NULL
> +};
> +
> +static umode_t ltssm_status_attrs_are_visible(struct kobject *kobj,
> +					      struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if ((a == &dev_attr_ltssm_status.attr) &&
> +	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +const struct attribute_group dw_ltssm_status_attr_group = {
> +	.attrs = ltssm_status_attrs,
> +	.is_visible = ltssm_status_attrs_are_visible,
> +};
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..fb7e3c14e523 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,8 +330,40 @@ enum dw_pcie_ltssm {
>  	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>  	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>  	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_POLL_ACTIVE = 0x2,
> +	DW_PCIE_LTSSM_POLL_COMPLIANCE = 0x3,
> +	DW_PCIE_LTSSM_POLL_CONFIG = 0x4,
> +	DW_PCIE_LTSSM_PRE_DETECT_QUIET = 0x5,
> +	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
> +	DW_PCIE_LTSSM_CFG_LINKWD_START = 0x7,
> +	DW_PCIE_LTSSM_CFG_LINKWD_ACEPT = 0x8,
> +	DW_PCIE_LTSSM_CFG_LANENUM_WAI = 0x9,
> +	DW_PCIE_LTSSM_CFG_LANENUM_ACEPT = 0xa,
> +	DW_PCIE_LTSSM_CFG_COMPLETE = 0xb,
> +	DW_PCIE_LTSSM_CFG_IDLE = 0xc,
> +	DW_PCIE_LTSSM_RCVRY_LOCK = 0xd,
> +	DW_PCIE_LTSSM_RCVRY_SPEED = 0xe,
> +	DW_PCIE_LTSSM_RCVRY_RCVRCFG = 0xf,
> +	DW_PCIE_LTSSM_RCVRY_IDLE = 0x10,
>  	DW_PCIE_LTSSM_L0 = 0x11,
> +	DW_PCIE_LTSSM_L0S = 0x12,
> +	DW_PCIE_LTSSM_L123_SEND_EIDLE = 0x13,
> +	DW_PCIE_LTSSM_L1_IDLE = 0x14,
>  	DW_PCIE_LTSSM_L2_IDLE = 0x15,
> +	DW_PCIE_LTSSM_L2_WAKE = 0x16,
> +	DW_PCIE_LTSSM_DISABLED_ENTRY = 0x17,
> +	DW_PCIE_LTSSM_DISABLED_IDLE = 0x18,
> +	DW_PCIE_LTSSM_DISABLED = 0x19,
> +	DW_PCIE_LTSSM_LPBK_ENTRY = 0x1a,
> +	DW_PCIE_LTSSM_LPBK_ACTIVE = 0x1b,
> +	DW_PCIE_LTSSM_LPBK_EXIT = 0x1c,
> +	DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT = 0x1d,
> +	DW_PCIE_LTSSM_HOT_RESET_ENTRY = 0x1e,
> +	DW_PCIE_LTSSM_HOT_RESET = 0x1f,
> +	DW_PCIE_LTSSM_RCVRY_EQ0 = 0x20,
> +	DW_PCIE_LTSSM_RCVRY_EQ1 = 0x21,
> +	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
> +	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
>
>  	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>  };
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7679d75d71e5..c23d188323f4 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1696,6 +1696,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  #ifdef CONFIG_PCIEASPM
>  	&aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCIE_DW_HOST
> +	&dw_ltssm_status_attr_group,
>  #endif
>  	NULL,
>  };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..3775841b5714 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -960,6 +960,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  extern const struct attribute_group aspm_ctrl_attr_group;
>  #endif
>
> +#ifdef CONFIG_PCIE_DW_HOST
> +extern const struct attribute_group dw_ltssm_status_attr_group;
> +#endif
> +
>  extern const struct attribute_group pci_dev_reset_method_attr_group;
>
>  #ifdef CONFIG_X86_INTEL_MID
>
> base-commit: 7004a2e46d1693848370809aa3d9c340a209edbb
> --
> 2.25.1
>

