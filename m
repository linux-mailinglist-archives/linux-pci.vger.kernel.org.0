Return-Path: <linux-pci+bounces-23874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835FA63328
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 02:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFDE1892167
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0518024;
	Sun, 16 Mar 2025 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/G4tlvb"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADF47F4A;
	Sun, 16 Mar 2025 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742088267; cv=fail; b=Jcv5uentoMebnYl4oUGJDJA6CBZEW5uCAt2ZocSzpzzaO4aLrV43XB4UK3WOQYUQ0k81pCBmWJpQDniBKKjFdnZAZ0QsBKDU8AtCy/Je5cLBy2gEeUoIpH/+nVaA1WH3uQ7zadNZEoz9oVVzpgysYsSb7wEglUVdibXUZnw9t2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742088267; c=relaxed/simple;
	bh=fN44qaIBPU/k8y1MZnXTWGGVclFrxrZBRmjPij+eMuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JIDyLFEQUBw2M2KWlwpzoHlNgdy3Izcluv9ul482PJNWh0HTKLcf/mzMkvCNlklUX6x8QK7G3n3IIXkOw1UJ6ybMZqRb18jey5rWRzu8HlXgTfRQLcBSczGTQ6IAtOyIMpM1HBjXmyltShgv+JspD5B90EYqLuDSZKInFLL0aQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T/G4tlvb; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE9f4z/42V3LOeVRfU0/z64ecsk/Xl1R1fbP/2bfD6PLQj2OWNHpAzDpccRMtgYIxjRkLUuJZlCnCRpRgX0/cbQYuaUYqOwpUSZJzwf7kjcNGcFxatMzlNGSabAJudvGdy67E0bKewW+sy0XgOvQIXU/H333erSXmqBEdHA2EdBNI+A9cQCxpD0W4TSILtifmwI1UWbnqdQeM16gRSMK4T9c51W5Wsn5LRQGzhfe6SX8U+PrdmUQ5zlE+7WOv7kjEc0C37FFwR+Xskc6Ur37LFBgh33tmCod+OIibdEf5q4cnLbsx7kVY9/yeklPXFsCaVeIJP5k2JdPGaqSdJ3nUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0npVlXEud279OxzKg+Rd+VQ5KybVXgX17Y9ApuZv8Ws=;
 b=wEF8Cj6mZnV2V0s2mJoPZT3759Pn1A2CWA4rzdkQjmBNxbPfgjQwTG6TLnCRmEBBJeVwtEJaQZt5Ve6vznyQHYainBPnWdMTX7pazVrYHMZ8t5SoEk/NlEde9DMViZeN+3CRb3/tyUdg1A62JCDAyLO2lCBpU42peFUZHGp+DZjx8mbHYVovOTFtJy9D+nO253ymVQUqrf+DVU2Bip4f5b9MXU8IkNZkHqiPA8AyqSdldd7IdD1ZWkzKs8HbecMRaWaVkF3ijrwQ5YYCpqgnrM8IrdsRGAn5cE9jO4bzNbYAslBqCrfldh/yAF3caki+oLUYjf5LmTEXTtipn+K0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0npVlXEud279OxzKg+Rd+VQ5KybVXgX17Y9ApuZv8Ws=;
 b=T/G4tlvb8b+632IUAUvUkBD4uJub2SXsF1I5n+SLaIUE960iobIHzJwfm44tUivpaRVuRgdfSRUHqX4w8rTVM/RIagC5/jQvZKB2C5fAe1YTFCI3cLA0iGu9ZZxn74q/nDf/QRDQz1zVZELu+GA3g6BA6PA2NAYJEivHddoMi5/M1pwyD9uabBy4NfHI/n1Q+z49qR+NkCcTciVolUHbwXCCz544CAuOvsUzLuP8C7Vts0ryB/kFPGMRA7VDhEpPAXGoBlPNGXOi6djPDTo+Hvpfc7BhDaa2UN/DIGoVIll0cDPreOt1yUDI6pSCmWhiiQ1wz5mbgQ87qPEKJscjLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sun, 16 Mar
 2025 01:24:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Sun, 16 Mar 2025
 01:24:23 +0000
Date: Sat, 15 Mar 2025 21:24:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 08/13] PCI: dwc: ep: Call epc_create() early in
 dw_pcie_ep_init()
Message-ID: <Z9YoPgphIhYDmOga@lizhi-Precision-Tower-5810>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-9-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315201548.858189-9-helgaas@kernel.org>
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 161be208-3d1b-4f0f-4b78-08dd642948a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ol2CcChtRubtgBKUAer/zFOOj/uE+GCTXrjSqWVHq/rmmyWcbaGaZf+ZhYkV?=
 =?us-ascii?Q?YtfgzrpT5MC7aTxxoIIf8nXqcGZjffeiMTEWhZtFM/TbiusxY1zjJgT6jnRA?=
 =?us-ascii?Q?jIs3krvXfyS9lkV6nuZ3JGIhoK1p2tAcCkbFfVd8RN70nSAYwCoQQdwUxYaP?=
 =?us-ascii?Q?BNxgQ7B0/2Deul3DjGpELVMeUUlzHfZbxjTvi0c/LWieAo5Ywk6uQSddT7M3?=
 =?us-ascii?Q?jhkC7NO2DQC1CyqPPPufbZPPQdsa3GtwIbvEAbl5J7RtszHGzzDBYNkLL+xX?=
 =?us-ascii?Q?UxtKYnt8zeJOEI6Y1AbmLZpVSgOWlzV3+xi0DhkrgR+VqaakaqpJM/F9EW2I?=
 =?us-ascii?Q?jawYQBz9OJounZOQjIwbJ4UENfiwAsOuSW7HMIsJb04FlxFMnYa04IOcEF0y?=
 =?us-ascii?Q?iRKf9wghe3LRVYuqPu2mPbHHRnIPybWLhyHl/GAfbKEyUTisM/yFYWcphrml?=
 =?us-ascii?Q?cDQwwmevOTGEtZfR29qixHBpd11o9+lgZbExqn0ryNHnvcSwOzVNDNVB9VXX?=
 =?us-ascii?Q?gpiHyUzAdmp4uBWFKtjS8CjNw8Jn1HNDB6kC544iTQJKuAKQzyW6kv8xOCM7?=
 =?us-ascii?Q?iLfscA8gvdbD/0lNhO2QnePiGhQYwycA/ip+hV9Hs28Vj0d/8x/7k6KiduYS?=
 =?us-ascii?Q?yrCcpLZzMzKxmsu+MPpjRbdxyGZg2xjUw/uHTxJQLAT0NYMzubIMFriZSM69?=
 =?us-ascii?Q?eRRjxOS0ZpTEnLTRE8wF+T3IEytBrt6ziPS4Qolq6ve2Yqm6EjFVKsNwNX30?=
 =?us-ascii?Q?OiYDvFPh5LpfioHmQRe2dHUsOFNP9/57vOC8HPbBPaJUon9ArmHAEJZ+l46G?=
 =?us-ascii?Q?KqHQOHyTFVwWJj9q6T+XrSSl0H0prXh60R0uUfTRooxHFMhhhIMyDxnW8r1W?=
 =?us-ascii?Q?XFXCSbNDF3vfpaZiOy7S/W+I/m78jaxfrv0a9U8iHbVOgsY8gZlqokgGAMKs?=
 =?us-ascii?Q?CjIySUKEf7SQZX55lwUZEgBP+QZ+yvWrdUxIW6ElQbYb2zZUEZbQC1oXQ8NM?=
 =?us-ascii?Q?ExYqc+C8mNtdCz7MbO4eqzZY+Zgs+SxSX1QljrGeMhe3HLzd2ShSO2E+mPlW?=
 =?us-ascii?Q?2CNSUWeEG6JV8xF4XcF6JX4aCnZzNIZfVh5c+Ic1ugWWEVttVzZis9HFtn3J?=
 =?us-ascii?Q?rmAlAkBclcVWO/Mjc5LEwKDs1pcYN4Spgrr1NyZGmoWTD9dv/x5VKW1wEiZt?=
 =?us-ascii?Q?eidjeX3D/ojf5rfQSY+BG6EbMWuN7QqHFocjU4Qk9Tr2Tr/NhHqjJlkGHr3b?=
 =?us-ascii?Q?+sVkqG+eqi7QEet711vKr2QqS7Fflbv74J0UQOWjAQKbsEM9v+VIJlxKL35U?=
 =?us-ascii?Q?Xs9EEJPbns4hkT1DhSyqWRDKIMrT8iGmsYjlEjdoKps+li1oZ56pXlYTYa2F?=
 =?us-ascii?Q?2ycdkwNuXFg4hygTWTSKy5DGvRxRQ1IdhKZLxzHIW82zzDImzpjZXVImevCn?=
 =?us-ascii?Q?Tn3UV7TmkDF3H7AmVg6BRfjqKVygJ/ss?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LbbGnHFUqQHs+kJWjRlU95O9j2xn0sFhXSJ/LU9c9LhfpV3vnmZdn8dUiI+F?=
 =?us-ascii?Q?C9MbfjeEAFdZa9oXx31lSLSMzLVB0z41nwtEkG2MeqpkMK6XVaKP7YbS8AoC?=
 =?us-ascii?Q?1oBGCqF5eSu312th+LUQntN5BX9rxbEuKGSC1Tq+hF1HTeYKW/3YK8KA2qTj?=
 =?us-ascii?Q?jTU+oAhvsbQeb1GBPpEVDm0q/9c0TndcLMbq4XAG4EazkhhkIiIMFYeO/p4d?=
 =?us-ascii?Q?5jBP6qwiUXVC9ykODqr4QAF7PIPPQ5FP98+8QcTCM3MmwnL+9AGH+VGjOyq8?=
 =?us-ascii?Q?7dBmD4dG9qZlR8dbYObEq6uRTjllKOdoONvTQlgC168yyWLcy5KM2FOpnO+y?=
 =?us-ascii?Q?ustnT1+hqmHt0fgniTM5HBQdLERJhIWEIh+mr7y9Qb4S7HkN8CZC5TDGBkgF?=
 =?us-ascii?Q?/ysHktJ1vJMyE419PU06EQNpWXIM23q40kCbA26AmuXxUOAHqJBrGMHEjzpB?=
 =?us-ascii?Q?2CqYwEYvYADGcOgzuff9dhZkW4DMkHBX2xdw6gkAeTGpknyfZSd3HuivAvlP?=
 =?us-ascii?Q?Iqn3ZigWCm/D2UFYdzJ1PbcYRXCRUTMA5ZeLKXDbZEEQv97WDY4lcKIGvuK7?=
 =?us-ascii?Q?5OVahYOQ0cBKft8CGyjdzF+eww8Era+SMiA0zZn6dFdIpe2QBJEGD9mSiqRH?=
 =?us-ascii?Q?wZctgzJ5RS/Arz++24ZgSYh7H0giJCNapPF3KF9RPfzr4Ba0hIW2A+zqg7Az?=
 =?us-ascii?Q?UdLYm8cR6T6SMe7v2p8UwwObfZlHSBdgR9Jh0fPFM8jf2bo2ztymExC4l2Kr?=
 =?us-ascii?Q?8XgzmhcYEd6866unkBB9NRJ4nPza30asDLIiZvG2px6/x0UXhYdD7RR8vU1l?=
 =?us-ascii?Q?Ib96q+b8eke1UgKABsPBAnCZ5l5PnZ6/Zhb7qefpNhbtYVzsBC5ylShitgxb?=
 =?us-ascii?Q?HkIMIEEa3CoRaEJJBqe6KyrJyFSs2Y5CV0M3ZtocWZDBDktnQHf/B3m+p3ob?=
 =?us-ascii?Q?T9Xo79QJXibpqP9crPFKUiTXe1bv3AS5go5P7MD0XlkJBHSP+c+0ESV87f6K?=
 =?us-ascii?Q?ZWz8rY95+mVs+/5P0JnrxyUPo9xnAnUwy3+aF0oYLujcG9HItT4+VSmIJZv0?=
 =?us-ascii?Q?nedYNoUWHxszFkLiTxon/Yo6AilA+BEMyVuHP9r6SKf7ezotmi7Wft8zgZPz?=
 =?us-ascii?Q?TRLYyhfURPv6WlBrtUpK73E53GnAQRZydZcBkPvrBrBk2wQAP51lJ3faBz7N?=
 =?us-ascii?Q?w1WaK4R3PPsz/rGy2tkLLLPnXIg4kDZEow5IvAvk5hPuiZ09J3zswyIvHiib?=
 =?us-ascii?Q?x4IJVRqk3SWOMHv0sKRGFz8sjWtvOHwtQbWGz4CWyRgCCxZwrjEA0W+ng5vj?=
 =?us-ascii?Q?94gCwuj0v9fu13yJ4rAgCQzWza8ddIq92o03TIqDIlgmvnhgf2L0+b6rBUl7?=
 =?us-ascii?Q?meApBLfX6vcNIfQMZt5Ih9PYCh6xmb1OOnpw8GuwvXt6fqWaJ9xQ5ILyiV1b?=
 =?us-ascii?Q?/4eT+VPWg9vD2XczcZVR8tElLrA6Bo7KD2J3iNYh0ojCDseBdfInNt3tsKtj?=
 =?us-ascii?Q?ZifzPT4bEou3wwreDtZX/msFgngTmtCd1KAEDTNRElbZ5iXCFn1pgZW0XL7/?=
 =?us-ascii?Q?RW40XefIoSBW2rWnoJM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161be208-3d1b-4f0f-4b78-08dd642948a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 01:24:23.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05V6TSNrwJzLsn9vE9iSO6qy8P6GmflmejkUNKV2GiczQqLaBQB6casg0hG548Jz1/wVBqP+WcOE/DlXQt0JrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

On Sat, Mar 15, 2025 at 03:15:43PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Move devm_pci_epc_create() to the beginning of dw_pcie_ep_init().
>
> devm_pci_epc_create() is generic code that doesn't depend on any DWC
> resource, so moving it earlier keeps all the subsequent devicetree-related
> code together.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 80ac2f9e88eb..100d26466f05 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -904,6 +904,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>
>  	INIT_LIST_HEAD(&ep->func_list);
>
> +	epc = devm_pci_epc_create(dev, &epc_ops);
> +	if (IS_ERR(epc)) {
> +		dev_err(dev, "Failed to create epc device\n");
> +		return PTR_ERR(epc);
> +	}
> +
> +	ep->epc = epc;
> +	epc_set_drvdata(epc, ep);
> +
>  	ret = dw_pcie_get_resources(pci);
>  	if (ret)
>  		return ret;
> @@ -918,15 +927,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ep->ops->pre_init)
>  		ep->ops->pre_init(ep);
>
> -	epc = devm_pci_epc_create(dev, &epc_ops);
> -	if (IS_ERR(epc)) {
> -		dev_err(dev, "Failed to create epc device\n");
> -		return PTR_ERR(epc);
> -	}
> -
> -	ep->epc = epc;
> -	epc_set_drvdata(epc, ep);
> -
>  	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
>  	if (ret < 0)
>  		epc->max_functions = 1;
> --
> 2.34.1
>

