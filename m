Return-Path: <linux-pci+bounces-24768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E68A718B4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ACF27A27C2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B61A0BDB;
	Wed, 26 Mar 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NPkstlEl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F34778E;
	Wed, 26 Mar 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999989; cv=fail; b=dm3QUPx4d3gECgifBrF7rocCPrzzhk5sFTm8Is4KQ4LNy1KquaA/7rHOzfnmUvxu/pFQ6m047xhd5J1Drldb+sLsw/rsjsQt1aWmXXxs/OEPUQxiZS2/LiT0Crg1TYWEJzyuD6VVMVjPvPJJiujujIqX0+s7q8CHiCfkQ9uDRMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999989; c=relaxed/simple;
	bh=pRJ/zQ02eVznR/jWzUQ+JKD/PMG/rv9YRlGW7K6cZug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSH74Qpg4PT2cCUcCvCAkEVdNEDFVB9Io70L1aNLrFIt6hsBuJe+j93ibigwQX/I6Udlc/mVPys40ajFVI+4hyXTsPc8iI1++v1D/sVldI73mrsrWS9S+3JdPWbbKBQw57byg+tZbdX5IUVaACq911hdDattIp4ogElMlhF5ruE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NPkstlEl; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF36hAIhIW5TDyyV9Z1iUitpKlMBWlZc0l2dg6da6RCvmuIjnhi3K24g0l0SJgBRdKJN5GKQyVyyx3nvxFQKQCSNIKl9SWVx8Bc67eX/cFghjg92P6M5XAc7TQM/7vj6mebWG1I8etCsrUa4HPhfOLZQuZU1qgk0poojQwt8/y/wlZEYlnRF7kTndv8WOPfEAZRqUC3w9XaN7gfBb83hXyvShpidBVOZd3RkqiZ0Uz6+8vSv8dxpHDlwH1nkPkN592yYfC/EUKc/SsTwcy5jM7W3xEN4PVwN5rWLx/i6nwMsqAFz7x0O1daN11NGfdl2pS4VwzuSkxnM4zC/14g3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDKjwgUBD50F8tSje2h+m7/fTZNTOb3U7tE1cCgVink=;
 b=Xnp6YwtKzil1P+eVWkh5AW4gNctsOB9KUJidnIor2o6HDzQ0Yq77FqVMqERcR23K8II2j4owEbDCjOcRJqkDxTJfsWwUYp40PY7s5qykeR4tcgQSc3np7vJsP03TZ6NKzcBNNShtoidOxjKPK3JdFqky3mL9o0D7aqTOzcqkXMkZ4Z+vjMHYpyxMRM2U73jrsTT9m+qcamh8SkXAmexb2oueaI7OgqZ0n68xP3kZOVqMggfMo1R9hfSaEStDQpgptsvSqIv6uOtAz9Q6OQVy0jCz0AwjtSUyjZtVFfFU6PES+DqlhzzxrZpI9V4KigZTr58JilcD+k81uQDiZJRATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDKjwgUBD50F8tSje2h+m7/fTZNTOb3U7tE1cCgVink=;
 b=NPkstlEl71TOH7hsTZIOv3LUun9M5i2YWUuqkTWzTP9GrB9MHecfh+2KxVdR3dOW3ODEEGUt7kXzalMHKwbggCaxKyWlDfiUcJ3oY+L/2f3JqqFFss+4+iZuOSrvTzk4usQtsOFp/w+JiYbJFSmCIqmTkwKlUCieT/1ijYGkf3zC5tnQ46RmHNCsIZOPGaDGcXnkNCLLOqfL1A2FBb+eTWc0A33/R2XLVSHObTamo9amtJ5/4ky9HQdt82tWA8+T7V94nyzdki/liGnecS9mQOtQcNzeYTrAyTr1o26pinAQUEV//fY+oC9zDsPY2Smq3Nh7Z1zqlKYLzU13zITKuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:39:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 14:39:43 +0000
Date: Wed, 26 Mar 2025 10:39:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
 Receiver Impedance ECN
Message-ID: <Z+QRp3v/DW0CbVD/@lizhi-Precision-Tower-5810>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
 <20250326075915.4073725-5-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326075915.4073725-5-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY5PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::44) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 935a3812-18ca-41fc-f5a8-08dd6c740c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9z4kHrojH65UT4C/C5RYCww3zBGo4in3APAGFXfUVR5Z0aTQACGZx5jB2KAe?=
 =?us-ascii?Q?qh9qeO1bJLYZewEr7sLLjt4opguEX+2Ldf8QEW6yrjWSTxGc1HmH77CD6yp3?=
 =?us-ascii?Q?lmSbgh3Nx62+UeymCwtFZ7jQ4SAhuVGqAtyjxnLdQ4aYSZ5ndnGFyAGFRu7L?=
 =?us-ascii?Q?laGJ4rkgl8fKu4jE4SrifHmtIX9PgMpRn1o8HOQIKNO9RN9Rp3lK8z7DOl0A?=
 =?us-ascii?Q?nrCI+vsVUQmmngpn5uvbmhL/UJ1VJu1eDxeA0zryzHI/wnyRErc7ExLqiW1l?=
 =?us-ascii?Q?HvPNxgUiWUjGfKVkb3kFanYwYDEYjBrDY8tBkeowdNf9Cdy/+oxxO1Zf8j01?=
 =?us-ascii?Q?IjEjFMpvTffG5muRrqlXlFaXnP4rj0q1zSh4thGMBimcmuWAoO7fF7bPJiuF?=
 =?us-ascii?Q?Mt0ZcisWJha/tnhGvEuShjCo3T4hkIxrw2K3ypl+6RN+eVodWxowGtc0CZ40?=
 =?us-ascii?Q?XTHBIj0R88mvSC3NlB/RLzwfCkou8zg0u03Ydvxdio7Jt9l+8QQJuz0xIwr5?=
 =?us-ascii?Q?F0otYh+wEn48/BO2wK59BlcTMY3vSpFk4tW/7RK5TN2i66nCyvLbbXrbhJE4?=
 =?us-ascii?Q?1PFiATacetv8rFpx5MPvHrm9yEP7qSKrHUrShbT+hQ8F+7UO7YuRIXA8NO3G?=
 =?us-ascii?Q?hGh/RTNKrO+9u8pMneebMfa/zPi3mDyQnCknB2wlEeNS3PVeheo9byxP1oo6?=
 =?us-ascii?Q?gZhBX4YyzuPnCLwdr/DEMenNiXin1k5fwnqWoZAwlT/IMm976rAKutbl+AiL?=
 =?us-ascii?Q?xZI8rOULMseLNmJvvpqSzbowBxYlbXCysSrvJPA+SRfeZGtKiWAPg6e7gxFk?=
 =?us-ascii?Q?tuZaVVhIUihgZgXpqe8rVryHoodJiJb4TVdldIQjkBG5LBWFT/0tdEOBg1tn?=
 =?us-ascii?Q?hDKNgU+wUZXgali4V/5blooZ2aur9/JpvVo/6BHf35OzVgf2F5+3+kOkONrY?=
 =?us-ascii?Q?w1NCt8B7i+XKyKel3bgdQDhfYdtcLMqSrg+wj9tdrkFNe578SgETm6iTayr9?=
 =?us-ascii?Q?qk3oOTbeybcuMWAC0efgbrMkJrR28xk43k5uDCccYuiEFw+DH12hKiqgkNhx?=
 =?us-ascii?Q?z03f9xKdE2VzLJhr5gAqWL5rsA3bmoA1LMwpWGNGJMvt6UqJFciKMYGGeqLG?=
 =?us-ascii?Q?lbJidB5rMqTMpeY6iRICSqx8AzZbQ8oWAXVy37CVKmDtQkofnkt14FHWX/2a?=
 =?us-ascii?Q?614UDvvxXJn81Aujv527jOkoH6Eb2JN+WVteNaOrksrig43LPqtikWBzmfCL?=
 =?us-ascii?Q?5lwb6jFtOXqxlxYQ0ep0dsONZqhW1HvmCRszhudzB/+CSuVfjDsF8riIf3TH?=
 =?us-ascii?Q?D6A1XKCtviAKodHwQ+m2mv+uLBs+LotOXwteLFK4lMFNXLMDekBvtn6qU2Or?=
 =?us-ascii?Q?ptbVsLb9HBtxPmqZKln2kdktDSFSA/n7rtnz8tUD31TAPsa88Jtv3iLBF1Pn?=
 =?us-ascii?Q?/c0B9j/PpUvqx6ALKR+w0DHjUK4fH4Qya3y5Kaj4bR+daoE1GzKNpcTfbPFM?=
 =?us-ascii?Q?Jff1Iv0NDWbL/MI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X4oVWYReJvtRZRhHTiTgAFkZEHlhFQtdmA9p3ShIhnwvRwfSHQfHG3rjC4nu?=
 =?us-ascii?Q?K9djeF+HshMC4Ja5im4Dtn0jPDxF6h5FHtU5CZF0/IyuCVNoK9MBQQ5kOD+p?=
 =?us-ascii?Q?12/G6IIc06Lbnj6QLSyQiWnkyu3s164ckgj6mb1QqpDFwv9sR+6gzONKdoXs?=
 =?us-ascii?Q?b9U4Eg9m2cFx1JRttOpmRknBxKqosKYrG1VEkyqG0xCcS4fCO8xHFKx4dZfX?=
 =?us-ascii?Q?OvdZ4ONze4zcbu6O/UFm8vnWRHpb8pfoxzN2LcEsbdxxJDbddn2ziHQHgvyA?=
 =?us-ascii?Q?n++65RurfunsCHQz5h1KZ8wJxPkISOamRRcWrVxn3IuC1w6W17NETmvP7dE8?=
 =?us-ascii?Q?stuqajVW3LErwAIHDI770/n04cWgGK6G54t/0XIjHJ/9xEBTT8hrFNVUrHEW?=
 =?us-ascii?Q?iBwFSFr+U3oW9NP2yHU4EaU7ZE5VUqS3aMtP2zClvyKNbCyih/fP15vfJZM1?=
 =?us-ascii?Q?mJ0wRZH/xB7tDryB1K54KuADAoI1YazeKNrTvVmUsK69VhF5CTEOWKC6A5F6?=
 =?us-ascii?Q?xO9eWI36/EW7CSjuviuJLMsrd8mdjOsJYCFu6i9/pmNCBqwRMTW/miPFSkuZ?=
 =?us-ascii?Q?NxM8hLEhVsmK1TVeHBiqJKH3izldziOYMzQT49ywJXifS5+BoF8k2gb2WscA?=
 =?us-ascii?Q?MhiRTbMq2RfNEBTS5M8AJVlVtWr0DFyETT/uoMMd3hWONaeBdO1csgknkrmI?=
 =?us-ascii?Q?rhsjp6w/IlQXj0YTQSfq2u/ydP+bBQZlpOFkepAG4LWs4FXEl6i5gEBo4NmZ?=
 =?us-ascii?Q?23bMugV/E0iD1iSJB8hROOUOWJyZGIs99JnP/nZ38uryCjT4od1+CHhTVoFx?=
 =?us-ascii?Q?D+cUSuvFvZUonOM00ANlmibx+6ptI80u+oY+2kiKrR/ijobD9uGDIG6fFhAm?=
 =?us-ascii?Q?fiji4Dxm6+xNIy5LYxmQlbAYlV76bBkIYa5B8PqqjzV71r1MJspzk7zAdJgR?=
 =?us-ascii?Q?zov3FW2EOK7rPD4buN68gblXmFqvU8oD1REI/dFUvGC9Yqp4hUpUtJ0kmtDx?=
 =?us-ascii?Q?/B0s4pJa+QxHKc28rShvynTGmnkEWUBjEHwMhppHfxRTfWLubdYeFuC7h3Rj?=
 =?us-ascii?Q?OcTwx8l4H/xuGDppAtRZaAGmxwoaqwYZCoB4EbNhL7L59sbp2wV8pYOO9dk6?=
 =?us-ascii?Q?Dif0216sb09nsG7BQG7VB0MFoBX6VP5/l6VsFq+D3TUVj4+0KwVGI7r98DCT?=
 =?us-ascii?Q?DcaRVtXYDRPhHCk8j4Rlcmrz6SNV23Cm438f/9pXUr1IWNjCiwn9+6Qiu6SG?=
 =?us-ascii?Q?HLnKRWNbWqBcG/vHafCO12WGHvic9KGtxTZDN297GwirLkrChMnUKuSTTbwm?=
 =?us-ascii?Q?hFHxzZUjns8pwwII/lv3civ4rayfYYFMugyllOaPfGsiAIMcdX3BMpKFz0NQ?=
 =?us-ascii?Q?1UQsZCXxpTcJ0eHw7C0ClcdwRxJ3ZM5WCtCPgKn1lC0/q7XFBnqFvEnXcSKj?=
 =?us-ascii?Q?1ZU2m1X3+cC0nBUqdSIYncNeRsLvqe1Q1YSFp6fnaaak4ri4OShxs1I2XXjm?=
 =?us-ascii?Q?+DbjQzaQ+CH6JxEx1VQnO7wDkCfao9jaiLmSiOkbCuG3k3yY6wEe6eoOZ1js?=
 =?us-ascii?Q?Bo8ZErw+tFf3ceaDInluKkq8XLpzl5UiZCVRO9th?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935a3812-18ca-41fc-f5a8-08dd6c740c10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:39:43.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnZYXEdj9kPOG9vdY7jfll2eTycrjhSP0i96ODacC/KQkdNYkjQgdJKVJgvmKCb63nvX7wAzUrx5zmw42Zbbbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457

On Wed, Mar 26, 2025 at 03:59:13PM +0800, Richard Zhu wrote:
> ERR051586: Compliance with 8GT/s Receiver Impedance ECN.
>
> The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
> makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
> operating at 8 GT/s or higher. It causes unnecessary timeout in L1.
>
> Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 33 +++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index fbab5a4621aa..42683d6be9f2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1261,6 +1261,37 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>
> +static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> +	u32 val;
> +
> +	switch (imx_pcie->drvdata->variant) {
> +	case IMX95:
> +	case IMX95_EP:

Use quirk flags

	if (imx_pcie->drvdata->flags & IMX6_8GT_ECN_51586 ) {
		...
	}

Frank

> +		/*
> +		 * ERR051586: Compliance with 8GT/s Receiver Impedance ECN
> +		 *
> +		 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
> +		 * is 1 which makes receiver non-compliant with the ZRX-DC
> +		 * parameter for 2.5 GT/s when operating at 8 GT/s or higher.
> +		 * It causes unnecessary timeout in L1.
> +		 *
> +		 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
> +		 * to 0.
> +		 */
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  {
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> @@ -1302,6 +1333,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> +	.post_init = imx_pcie_host_post_init,
>  };
>
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1401,6 +1433,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	struct device *dev = pci->dev;
>
>  	imx_pcie_host_init(pp);
> +	imx_pcie_host_post_init(pp);
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>
> --
> 2.37.1
>

