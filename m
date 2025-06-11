Return-Path: <linux-pci+bounces-29487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C5AD5E60
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 20:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D5017DC9A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758F227586;
	Wed, 11 Jun 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PoWY6M+0"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B53380;
	Wed, 11 Jun 2025 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667107; cv=fail; b=f+nU6ILUm2H2snU4XwZZLXJxyqXBgVk6auV7qgqmnEnZgwa4nU2EMP//49QJ+7/NGSeB1CmGYANzZNyL5gRYyXl0Pk2VSxtS5uRp3UFCIH9y1eOYK2t8GRyjXwmFHO7yUH4toiLdhvNQhiB4jOTjbri4SCoeKlPjvb+MhR2SLWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667107; c=relaxed/simple;
	bh=g50tJB8CZSYQbCVv/qj7xRu7QUjFnNIbp3Ashi/rEi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afrTA7Ct0rPrtJfjZlRFDIwp+H/0UX3eZy7YvFKsOZZTylxyp76nAc49S9TJWO7KOkSZR26EMBeht7QHf7tGuWwe526CnDsghSfASC8fsYm7bOtoQgo5NGeEd9nexBE0B0HgQjNPia5uGMDB69RrtLz2CalKB4A8mWv00KFcD8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PoWY6M+0; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbE8uRvBbkVLAQsSAA4dXNvUkOKQTAniPWo2KMgMyGyym+tNHZj5cy/lKMfmkwLJiWAjeVGZd9IPCKW46P5X/1gLe+8OqQU1QQzt6mBHvW0HODRQSkTsd5Z51J/thELT54ujTisvYeXwXPFu0j2Ow3Y3zBp+qTqcG4/Ga4iWGvfRofKFxpNIkjNCN9s7mm6q/zDH/X/SdS6uQext4+VDq4rZxQnw76ECOMnGrhoCFL/kZlzGa3th1WX+b7ePTtqCousZLsQ+UjZc8+ILb/VaJ+hGGAUEMXrhtka/nKOaVSohCPyoAqMpkNdoH2tTS7+PP7+eT/+psUXNfBc9QYXjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxutpdI+LMZqj6IN69nAFloI96WfKMipPTMxQqguw1M=;
 b=W/j3HBtRs24vQvYP5YFUuSd6CCgiCKB3rZQQ1ZcRHtBZ00NVcw9Pp9EEh7Q3O3/Uq8+13GATmXoc5ded0tKSrjtm0hpWn40Y5EaFmnPRK97G92D1MwoJ0L6oZ+NMkZF4W2PRoAQgUNQhR0wyRsA9bSt8IN5zCQlWecgwCOmg44bY7q7/oBeGoURwLfYyhnSj8HwoaTErCeGvV7MXZ1sQQ5ZD9Zp9ptOY0V6AyGf6OhEdTlnMgv8XQ8AlwjFYCoK0q+iTnx3CZ5Fh/p+MthvAtUKVQSv89TDr103M06GEusT9jN0ioh3OWDd8u9Zbt1Hlx6nbNKLjkcsEj+Do+8uFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxutpdI+LMZqj6IN69nAFloI96WfKMipPTMxQqguw1M=;
 b=PoWY6M+0/dHWzA63RUx0DxcaS+i+tVdbJUrXg8BZaq6ssmVlpMJKGZB7AgjuHmdftRgrjqNyEDNElYOSR/kpcwAKWEzKUb6dm68g9+isYUA3ReN0N6QLwhjYnGRzkouj/8AnvQQ/rsQEx8JumJePp6kHi964YNYbbeVBG1i3fZ+fh1zStYas9w76KhJLdbsJH5w8hgoChbXfMXEVxmTz9TANItg0ZePg1sZhQYTWC7COuCxX/e8r8aBr1wZscrX7+NsF7bX9rOKM72Fld9nvH0IXnmTQNWdEGBTI9daZihoNJtqTBkZOCrYfyD7T0OPOl2ZGUDINfW1TEzZXD4Ep3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9057.eurprd04.prod.outlook.com (2603:10a6:102:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 18:38:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 18:38:22 +0000
Date: Wed, 11 Jun 2025 14:38:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] PCI: dwc: Refactor imx6 to use
 dw_pcie_clear_and_set_dword()
Message-ID: <aEnNFgv08BVVxfOQ@lizhi-Precision-Tower-5810>
References: <20250611163121.860619-1-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611163121.860619-1-18255117159@163.com>
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 74df5005-4242-4042-5827-08dda917247c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORYVc/GnrNzCN7tpcIMgQZy5zc90TbU17MZne9pICPjO+W5AUZ4nEGGY5dED?=
 =?us-ascii?Q?xrsSiQ7q4YmNFQe1VyIsXWskMm1UnhVgLmJAn3Wg7xFwLdNXPYtKAC3BGBOS?=
 =?us-ascii?Q?Xf+DrgaM6gG2SNFj44jdz9pStIDzERZ1MUqRNM9oIOifAJwrRcXwBRPV1+Fg?=
 =?us-ascii?Q?wKtOGnjO22cf8fm9mE8Gaqy4Jh1hewJZxWdhmxY5kKP7V5nXr8OJ8uhGyMEA?=
 =?us-ascii?Q?QdI/f42azM8rlvIoOKZuBnnDt03LYQEx8Lw4QHxBmgL8p51KGtOiueX1aqm1?=
 =?us-ascii?Q?zEoXwqh6wQn+P3cLZDYG6V/da6NCnXtsZXysOJyi3VW5iqQPkERatE6NAudp?=
 =?us-ascii?Q?zQHrDQCQlP8P9S8OR2HLOpTFXt4zdQ3dzlb3vjqpK/NgHPu2TbGSD10EunPH?=
 =?us-ascii?Q?d6el41fEOaOFrGNf/WBm92oVgx9GOKNORarSvW/JQew3dfHgqyNDVKvzoD9z?=
 =?us-ascii?Q?eojOydH+aUhpda9kqsvn7UoUs3T0VTs+5bYKIVpRSubLe9ecDLJK0ihQzHwe?=
 =?us-ascii?Q?FSM5siXqxxf9GcitBL6rh55Lo7ktLgTYnazw3XHLv4yk3uB4KFQb3by7T2yo?=
 =?us-ascii?Q?lm7cIO8WyeWwOaxgC4iIShqCUdNaK9KKMeZqr29Kxc3VL9sPMTWF3j7bmqrV?=
 =?us-ascii?Q?2+H/rqeGrsIQ6V5PcQxAHKmK1Kv1L7oF0t6TdkhJlM+7wdBul+Lzzy3IsroC?=
 =?us-ascii?Q?aZppMnI8UBJhpev2PHqGUDhSqcXbeTJC042u55XeP6RFDdHNeODDz2HCVc3O?=
 =?us-ascii?Q?Qat9/f0yctGxTeLcTvgS7y5RH/qbE5Ofmehio9hWq8DNjQq+azmAC3l6O/BA?=
 =?us-ascii?Q?q9RviZ5L14cn8P4TprmCrm15xkvNuAuU4XmApaqGQGGph5rQ84vtEUF/weA/?=
 =?us-ascii?Q?1eleQTtyNLmQpKqhSrvfP3/nMkxDVy/X+05h/ec2DJszjQF1GX/inTDyGOXI?=
 =?us-ascii?Q?rQdx/7+wY9PqZWz7LkXxePglA9oMmgH0cJDXg6MJ96b2OAfrlq6QYFEs5NpI?=
 =?us-ascii?Q?vX+2QF2eiu6ZjBvxDia26yhRv2t1gUCOLJYa9Ibrnc2V6G1rn8ZUKSaTaBoe?=
 =?us-ascii?Q?pBJioc8/yRdLxxKZH8/WURuWZwX/oglSjArNDAzpW2/jCHkN0HhHfCWpnUON?=
 =?us-ascii?Q?KxCn/f5lClwTVHMRoLjqBLcqbQ1ul/6t3s++3jM3mmpZC8CiyY4rRXOCCsIk?=
 =?us-ascii?Q?3GsYJK2JR4t7eMZAUuc0Hj8uYD28ICtdcqrMuAN4rXiwqVcSD8XEPaxXrdIg?=
 =?us-ascii?Q?tg+Jo998xJC9pp4kThkUJlLNGmnVqTRWbLyA0c12fWxoqC9b5vyMd8o2IuP9?=
 =?us-ascii?Q?zMq83QOcEjowNanAqq810ZjfIM1gC0mQ7lHIZWOMmLpbSXcZDdC6K341+hU7?=
 =?us-ascii?Q?fojs+CqkamFQ3KIDAyCNd0BXcvHthzYAPyAot5gUTitl1J4f6Nz8lbXf+4gJ?=
 =?us-ascii?Q?ZM7kJrRCUbw6ZtmQmvHt+Gmkl61W6EtUVcLljV7WfwhtARzIiAFDKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a45xu//s+BbvTLFK+Hpj/JKAGwhjfYDw30UI7Yy1E2yhDcJJT9w1W9iUeJAb?=
 =?us-ascii?Q?4l4tnO3TgwDtZ9/dE19ASfFoUd+hk3VOSAfCdmG5sSqwR50R7tl/ChJaGjPF?=
 =?us-ascii?Q?GWwYCy4r4VEg/bdJwllKnLKfvfiRoMhdFJ81EBaFVtlZn16C06nsJGTRTthO?=
 =?us-ascii?Q?UgrqOBn68wAWZwfALrCkBRMBZ9GZ8W6jGTkDxXN/ogkGET4pFskFCBNXOgpo?=
 =?us-ascii?Q?gQEL7lSzHHc6MTu8C7yaFJYOT5dBT6DbaputbcF+Bb8DKraZRbnRaNYHiCO9?=
 =?us-ascii?Q?cZwgRCTfeUsPYfYSFA+eFeloZkxPTJknqcs2zbuLmJ0OQFAeNipVLC6IbcGh?=
 =?us-ascii?Q?HsHMSTIjRkzIZ770RWH9Nu46q2EgOsebzxLJt2HVkA+RbpfnTPz/ziB0R6SD?=
 =?us-ascii?Q?oG733+53tQeT+5AC1Hi26mXruQTcE99OvtWJfQ+lrALweUh/pf1ssjhtgYPX?=
 =?us-ascii?Q?tuRcFoSeWvGb6I6LHs/IBSgcUezyCb0sJKWu9UCl+2IkJKR5UMR4rjkRaNh/?=
 =?us-ascii?Q?kkTamUe43zNYUHFQaUltN+EA+FXdpjyBFVfcnMYti2d6tyQ0+N8wLidtUswf?=
 =?us-ascii?Q?I3jjgzET6V+giwk2OI7EUZhZuVw2Z6g3Q5SyCuW4DkVxTZldY7U2UXfmkr/H?=
 =?us-ascii?Q?yPdrQ8elo9ez73JucH/HtFwBMLROmnDETIMauFKQYL/ZmFJmu2Dzx3e6U8Kd?=
 =?us-ascii?Q?n1NZAJnCP5lm/NMolw3JsIsefa7GYfpYanhZgHjaeumicAwzAu1ezSeb4qV2?=
 =?us-ascii?Q?ZK/fPrsKaB+Rxtt4C0uxlQlxxu49CgVA30uMfvWnwSpaiXewbRTUnrkG/qCd?=
 =?us-ascii?Q?bsThq5V4UlsWzy5erUJ+UAMViYGyUjMfkuBD4Do1+TitZzmLjfgzthE+d7NF?=
 =?us-ascii?Q?9LNxpOoc9EOX5IoOAAmAHk34b91m0+yCl5eEL0UaqRoBXtMa4XihCQQUkoKf?=
 =?us-ascii?Q?6RNIXDfL9j9hDL42MsOacnwv4Uye2nHRIORFuiKR8nrsKei6mzfMwuzX5i33?=
 =?us-ascii?Q?BTjoSakNNMP1h0V73If3cq+BG39SJswBFJyqysY70bHRBzcI3yNpF8JHfrcG?=
 =?us-ascii?Q?E2Esk9KArgtnEbvK8dpIJrQgqk4PjfITWpLPDbOtgIcq259FC326AbDYXll1?=
 =?us-ascii?Q?//sBpifZkiJuFTjNxjSOVpNlYI7s6quNRf8m55aI+A/PQLSpe+KUg46O0zIw?=
 =?us-ascii?Q?HQexqEk75RsbesgV7vMbwjEoS9YON4wU/rq2UmR3HpBsu9oAzbmCkfF5UNvx?=
 =?us-ascii?Q?I696Fghsq2Kk0WxUcReomNBL//RxMtVJbyYCZfVD1f1MuGGD/0dqlo+MpxqR?=
 =?us-ascii?Q?HRWxUqZR8Po+ciWkYOge+gyjbP9BCO7G4jG5XuDfDZZcZ5wawJFDk3bxLfnd?=
 =?us-ascii?Q?k66aq7pOUQOsKwejSgR3iaA70akqfvfyZ//YP7+cB58lP1/o/z0cGaxPgWwD?=
 =?us-ascii?Q?01sNWS8kuhqc6yaQRrm8LNKMZ9hIoDfFwnxcKi1wLhuA2wo8oAWw4dj2GHY3?=
 =?us-ascii?Q?rfn6KbmTT2OSIacldnUfgHG11H8BGrCL++uZYLFQvqZb3qCuSOta4/c7ggRb?=
 =?us-ascii?Q?UEXwKJ+lzRaG0Z59K7s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74df5005-4242-4042-5827-08dda917247c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:38:22.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p2RAeNyDidVcrAOhic7jdfo8wXAV/2newg8XBkD/FnFmW5WwsC99QIiDX0wmMsqo/ezrTH4MVOLw+lYDn/LZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9057

On Thu, Jun 12, 2025 at 12:31:21AM +0800, Hans Zhang wrote:

Subject should be

PCI: dwc: imx6: Refactor code by using dw_pcie_clear_and_set_dword()

tag "imx6:" should after "dwc:"

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> i.MX6 PCIe driver contains multiple read-modify-write sequences for
> link training and speed configuration. These operations manually handle
> bit masking and shifting to update specific fields in control registers,
> particularly for link capabilities and speed change initiation.
>
> Refactor link capability configuration and speed change handling using
> dw_pcie_clear_and_set_dword(). The helper simplifies LNKCAP modification
> by encapsulating bit clear/set operations and eliminates intermediate
> variables. For speed change control, replace explicit bit manipulation
> with direct register updates through the helper.
>
> Adopting the standard interface reduces code complexity in link training
> paths and ensures consistent handling of speed-related bits. The change
> also prepares the driver for future enhancements to Gen3 link training
> by centralizing bit manipulation logic.
>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..3004e432f013 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -941,7 +941,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	struct device *dev = pci->dev;
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u32 tmp;
>  	int ret;
>
>  	if (!(imx_pcie->drvdata->flags &
> @@ -956,10 +955,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -	tmp &= ~PCI_EXP_LNKCAP_SLS;
> -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> +				    PCI_EXP_LNKCAP_SLS,
> +				    PCI_EXP_LNKCAP_SLS_2_5GB);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>
>  	/* Start LTSSM. */
> @@ -972,18 +970,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>
>  		/* Allow faster modes after the link is up */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -		tmp &= ~PCI_EXP_LNKCAP_SLS;
> -		tmp |= pci->max_link_speed;
> -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +		dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> +					    PCI_EXP_LNKCAP_SLS,
> +					    pci->max_link_speed);
>
>  		/*
>  		 * Start Directed Speed Change so the best possible
>  		 * speed both link partners support can be negotiated.
>  		 */
> -		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -		tmp |= PORT_LOGIC_SPEED_CHANGE;
> -		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> +		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> +					    0, PORT_LOGIC_SPEED_CHANGE);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>
>  		ret = imx_pcie_wait_for_speed_change(imx_pcie);
> @@ -1295,7 +1291,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> -	u32 val;
>
>  	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
>  		/*
> @@ -1310,9 +1305,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		 * to 0.
>  		 */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
> +					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
>  }
> --
> 2.25.1
>

