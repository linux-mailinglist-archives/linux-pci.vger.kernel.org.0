Return-Path: <linux-pci+bounces-24124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C870EA68E97
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 15:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825AD3B383E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009B1AC43A;
	Wed, 19 Mar 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UxwMyR+e"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721619D074;
	Wed, 19 Mar 2025 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393215; cv=fail; b=WLl1d3hJg+epjsvlpUCii3pANFTKAn+VjEWW3EHpoK2xy8GzaEuGfRUbLphNrjMkJCgpdTKZidGywvSm3120RgRghjdWkfyubWCFGmZb7k7dLfwl8s4KvYvEmkzdC4iyeu5eNvmty04fmoYZQa2HoIcjc5WTqQ/eyx1W/b0X3cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393215; c=relaxed/simple;
	bh=KEhUaVQnhtBmAuWA3/EcZQ1NQjT5RMidsrwZ+SeTLnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LKQQe/pph4QowWhuc+vYqvKTUKJk07W352d/xXtJZkjZPbvPilS9AGt4mRKlYsu+XHxj+UKdEze3VqQ1iffI67q3rr/PIx0FcsCbpS/MNhM/Ue8nXmlv/T+1Pet7Duk6wB9NGOOO8rNJRS022f0c5FigbkLf3Gflj65zpk7kIYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UxwMyR+e; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGkZOFLvFzNSB02xzC5Cu763dLl9ST2h5lNzuFn0Kz4oom2JDwXdSRjpguFCdRtFpdkDCW5KTxyJ1PmjOxFCVHLXBba8CVKMm9fOiA9cjJ32iY6KAzjgnCi1UTrGlnopSzrh+cYNEcsnV/PQVpRQR/L2vRnj8Ej+csO0SOGUsLBtMfYuMCfRh59wU72dWgN0z3uUI4HdyvTaifr94KowleqmZUnlQpLmjeLjxaVcEgrENnV1KC+PW015CZcPXETg4l2cPC9DqpR5Gso+45XW8a9GLHPZ0H+uuiZHp5q6M5O2fcUIBUwr3ceNfcGqlX0LzAZ+UgHXI2xbTj9Kl9FptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn3xRv2700TmSMZxINRtRebU38q218mDlzpclZjCwB4=;
 b=o/zqfoHhwgF0yKU8J5Q2EAMfkkxYTw1XmOeN/sEqgrx6Gyx/nKJyNsTgArEth163fNCL9h0X4JzEQo7hxmYW2H8I/qA077agtpeWVoiEvN3Tw/Bma3iOtyyC0cKn9xhv2v+DQyPHTDTwKbM1hJd5KiYxR49mRmFCoPNco0dgwDEZyUTNgnqHrI6HlHqPDZ8qNgkWoXh3G32EoxmQLoFfRaiFP4RV6bdlxd3rVFM+tQgr/ZHU00r//rvzKJJe5McM9pRUusIpLYzdkF0DML2aKHhgom3Y+OGL4rHOM9WMzPql16uwbnd0zzJoVmdTJYn7R2dUKU4hwsw/H+N2Rzoisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn3xRv2700TmSMZxINRtRebU38q218mDlzpclZjCwB4=;
 b=UxwMyR+eElH5OflS47I4ZeLYqsrZa6518uxX+BO+mV/xFGTz2RDp0foLFHlnv7+sYla9L4qtkT37x2fv42wyidlE0hUJU0MyVAPuONsrN104R8GnXdWpcHm3kuhtafni4BjJdrulvSmKY4hY5o5lywCTFW9PUnbbZVyXc2hslQREpTZgbEklC6SQ/nl20fFW3jM8MseouczfI1rMTGtUNyD8GVKa0v35QCKv2Y6VVJJspeIYkAcn7qXSbv/1p+9uqFZHuySwAaryEO9xvwXPBlkmlTKgeI4w6FXPBUltLNWrAmKDlxxzk27zn07JVzlXYeQgghckaOfy1UDiqoNRJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9647.eurprd04.prod.outlook.com (2603:10a6:10:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:06:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 14:06:47 +0000
Date: Wed, 19 Mar 2025 10:06:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: don't assume the ops field in dw_pcie always
 exists
Message-ID: <Z9rPcFR4wxmITjmO@lizhi-Precision-Tower-5810>
References: <20250319134339.3114817-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319134339.3114817-1-ioana.ciornei@nxp.com>
X-ClientProxiedBy: PH0PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:510:e::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e525bb5-e2f1-4e8e-c8b7-08dd66ef4945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7C8eh0F+CtHOAAA8NzzBZaFqY5Erlb4ObZM5SmnX88D5FObXjK/xzs/WYpg?=
 =?us-ascii?Q?Hk2aTVFyVIU33OftbH/EvZCF073l4IpEeWl4ipbGPS/EdnghOCvbhk7OpWob?=
 =?us-ascii?Q?gpFEd4B1/JmXSE/lndgoOCP2UZybw5EFi26f66OEM1M6uu2ifwEZuy6OkF77?=
 =?us-ascii?Q?YbB754I5/2YmkZLBLqU+YduBeWuFoh92C/L60mmjw6N6w/zo4Liu6Ot3TQ1E?=
 =?us-ascii?Q?rpvhJ9WJYWh0V01M5qqBqR5HjGIlDgjq+fxJl6QM4HsL4w9B9HyPK8IEYMvj?=
 =?us-ascii?Q?dcVCtzRXkcQn6AYrjWND+NlwLM8pxkegpiRspVbGotVI4wkW4RjGWdzlhi89?=
 =?us-ascii?Q?eMX+FkLSVTayFr8xa0xmPTPTv1F/rge7NsGYKWq2ILJeMrJWWlNUy58mf87x?=
 =?us-ascii?Q?rKXn5NLWc9SxiIglJIpf0RofL94v3oohkuAu0UPi1p/9I48RhJeR0OPQRtF9?=
 =?us-ascii?Q?CjUI9ZXnkOJugaiwZl3BftolxWywYxvurejgY8YPIYBrZR6kuT5y607/YKan?=
 =?us-ascii?Q?14GNAgw5bMzps/3BpIYG/xgSlzL3zgOclVWE0BVYi2df2hGoHWT/a/WeGxqC?=
 =?us-ascii?Q?RgyKLuRAvnvXFUSFveqKmHDjq/WOSrSBcVFjMd3otSIMapourBFW2OaYZwPC?=
 =?us-ascii?Q?k4y0+52I5XqB2tez2vksRI9/sdpncVWqogfvhy5AY2ihC6hgZu5t4bfeng+V?=
 =?us-ascii?Q?H4pHk2sHN5RfRhiXXJH2GIa4PpqvKzPEpFokpMe7zyf7sy24VPM2r/XPiNyM?=
 =?us-ascii?Q?hNVatxfrluAtdeTvG3PmqqWdkHB/giUwd+72765xQ0y5Ty6ynCkolSncUzQB?=
 =?us-ascii?Q?jSbI3sJDRCW7JM7dmK8BTgdl7wHyPp5KofSxYf25vqzuPNYsAKfHSqgGc1Kl?=
 =?us-ascii?Q?caodzz+Csr1xuG6BiR1xxwUABqwAp3mtlhSWD/yi/iNbKxgTjiuqkVTszwLL?=
 =?us-ascii?Q?56/3PEntfLf9X3J5+uujOm/2fPC1pStGRqTxhTSsL5DMo6PM7U5OjEv3Uplk?=
 =?us-ascii?Q?CKq8iIEjFFmaezir80pAbyEMkvdTdA82KILCcRe5bS+YdNIVU78lr8EaMAj5?=
 =?us-ascii?Q?aRQ/uKsumXEJppKXcxtSVQcKVlxIrDA/fyKBaaNX9zXOo6Ei+iho1IifwNik?=
 =?us-ascii?Q?C62dcA7R9tcWBMAEEwgkjRWQOouDxFXWzzflAJrEUcH82NvSMISb3Z89Whs5?=
 =?us-ascii?Q?L1MOrsysv8aBmHBGC7TzF1o35yI0j0cVBNavy7re6ovBoAiiRP3LqIqHi9jz?=
 =?us-ascii?Q?2nCwIQW454M/lMhZB6YxwpS1XOWSEskuWI/hzBtMzkOEy89F9bSniEaSHPzD?=
 =?us-ascii?Q?jyMxd2im2WutwWYKoNvxOI4Lz9L/lum2prFGhp2EIhp4KbYc/HfG12djPNQY?=
 =?us-ascii?Q?EMe3GXRbR3qucteAWdKa9c9a+qtzsfLDHAp6FHD9h+nP+SJFiDLd6JVe9sOA?=
 =?us-ascii?Q?oLGYQR+EUxfX9trlDV+rGaVH+LADpwn3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lSxGEdBAF7UVtsZdskImubinv4SDl/BqIOsE79N6R/mxpP4Sk0ZkRlV5WjEW?=
 =?us-ascii?Q?F0QunbN73C6iX6Ics0Zh2CJQIx/XmLj/vAuYlMiwml3fHuPsq0lH0UzvmK9+?=
 =?us-ascii?Q?zWbej4fGCSfOGhjSNpunQWLO71Fw3H1Y3aX6G0bDT/J7vurEgZP9K7KeGKXs?=
 =?us-ascii?Q?PjXBRzYPOyArlsDdFSibkiCJ1HbKr0Ooy7iXxxl2nLPvs1uOZeBwYZTd7HkR?=
 =?us-ascii?Q?RhFkLy1DpVhuV2QosD+3S4dG4uFsdrd3KM9t2IAVtKvtpr82/b/KUzpPXarf?=
 =?us-ascii?Q?MMVv1IsP98WCN3bcfc7t2Z5EhHgS2Juf5QELQ+juyrslqo4DhSsyxDFkurgG?=
 =?us-ascii?Q?Qdu6jUxqnaf2o6oB8BP+vxk1IVPyRg+Zwpo88gF77ZKL988/s9uNgYITDoVe?=
 =?us-ascii?Q?VickQQu+CJs+8VL3CwmZ/IkDx8pzrLRRXx2X8+gUrmeexn9Ns5ZFfCPXoLDT?=
 =?us-ascii?Q?GZZsQ7PYF/LjW63ECjrhJbOjGnQTqO/q+/oHmtE9aydsHicpWpjFe8KUAV7F?=
 =?us-ascii?Q?gImufKD2akgk/f9dJ4u8owEwdn2hUgr7lmqlu4Rkm1oyX82V4dWd7w69cby4?=
 =?us-ascii?Q?J+BxG2IG6YAtO/pImBlF2ab5Z3OqzCE8OrQSwjm5YevlRkQEamXz+NW04euB?=
 =?us-ascii?Q?n+Vw5UYf+w6K4gZOfXo1IGZ/Ma8WY+sWsGPVUsdkFvNKKmNIHQnCC9bSDFvR?=
 =?us-ascii?Q?JuBeNToonCjb2EOEE/Y5RjNLec6rL4zn5nb5/2awwCOhnR9qcmxM0FCX3mwP?=
 =?us-ascii?Q?3v0s+LBoWnVgpYso3H9WU4DGd4MpqSnel4PuU4ZFNbdQ2Ea1tR1x+3peMCrr?=
 =?us-ascii?Q?uBYuaM8ZW37I4Tte2juBfansq9pVJP/QjyzVy5NOLifX2vwAtNSvcuaD8Y4i?=
 =?us-ascii?Q?6hPBBXflHFmBKzD6NBDfYnua5w3Ob3ivVAw7IFEHfQvBzryfbp5SjwiqgtmD?=
 =?us-ascii?Q?3tX4P6TRWLggXnYP2OFMlEyrcmDi/97fgPD3Kl/xKkhMv+Y29HeFpWXlgOoo?=
 =?us-ascii?Q?dkbGgUN/TxPD17md7HcL+/3GJBZdR/P7BgZ0PDkmQC4Og6Ak/k8PK9XlZbBA?=
 =?us-ascii?Q?GycZQ8SaBlEaMWue8GUOt3vYDeMVjxgOh74Y1IjnGsx0BAuZ0p+0Tv1mqCmX?=
 =?us-ascii?Q?BLJaxjVvKcubvq3eBjcGuu7HgYA0LwuK9vFbf+xBC2Sh/Z8bhY0EyiMmC9S9?=
 =?us-ascii?Q?je47RMMrtmj6xwHBfZ/mSXeHq/oUnFGeDy4b5xy1C8PoOtVeM/5IsoWURNou?=
 =?us-ascii?Q?TgwYP9ZY49Mvhx+H+Rq1d3ZorKNut2vhRTjl/9Fc2tvsNjyEWemZQrOLBwuC?=
 =?us-ascii?Q?B2etD03RYKwwmAyFzXtJ3ZDk2tZZv6+2NFAX/wV02vNvuaH8orb9J/C+hjrZ?=
 =?us-ascii?Q?Y5frtBnpWycy3JtQy8dVODUIQv7o76tCYTwJmLTELuBj7ZlSvKR3mr84mCpl?=
 =?us-ascii?Q?SmLKDFNKxm9sm59t3JswIpa6N7A31/9rP5f3CPuAEDn4K6N2QAh8yzspNTjl?=
 =?us-ascii?Q?HHE341h2qldZLGusCrW9waJ0llH3ZVmzkMK4GQXcNbWMcp+t8MrTaWrSg6+y?=
 =?us-ascii?Q?/Laby+IEZfM7JHdFvXc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e525bb5-e2f1-4e8e-c8b7-08dd66ef4945
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:06:47.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2YxzDEzMlSEoG/kbxaL3cTZutdfjUl00FKiLV99xOAdSeS5ExST//5Ff5S4Bt4Kht36RqpBoU6PnfUy0b01RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9647

On Wed, Mar 19, 2025 at 03:43:39PM +0200, Ioana Ciornei wrote:
> The blamed commit assumes that the ops field from dw_pcie is always
> populated. This is not the case for the layerscape-pcie driver which
> does not provide a dw_pcie_ops structure. The newly added
> dw_pcie_parent_bus_offset() function tries to dereference pci->ops
> which, in this case, is NULL.
>
> Fix this by first checking if pci->ops is valid before dereferencing it.
>
> Fixes: ed6509230934 ("PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Bjorn: you may squah to previous's commit.

Frank

>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index e68e2aac210f..b5fd44c0d6ad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1170,7 +1170,7 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>
>  	of_property_read_reg(np, index, &reg_addr, NULL);
>
> -	fixup = pci->ops->cpu_addr_fixup;
> +	fixup = pci->ops ? pci->ops->cpu_addr_fixup : 0;
>  	if (fixup) {
>  		fixup_addr = fixup(pci, cpu_phy_addr);
>  		if (reg_addr == fixup_addr) {
> --
> 2.34.1
>

