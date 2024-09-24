Return-Path: <linux-pci+bounces-13452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AA98497A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 18:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667BA1C22C39
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC12ED531;
	Tue, 24 Sep 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ew5N9ayI"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9321ABEBA;
	Tue, 24 Sep 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195022; cv=fail; b=LBtEQpGrrCAUyP7cdpwXxg1i3B2GDhAn6Ns9NrQ2Mwo1L5h5R2zWNhBURrf5fcO8hCwG9beis6R1CJzXJq3YP6i6ne7CeiesCJNpsK3gcWr4mqAQETzar2+Hq1YxuqVQHjaHmS7+n2BlQ68FrAnxEcTDeaYeIt6+nEW7z/+X0CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195022; c=relaxed/simple;
	bh=VVl/xsk/e3tBraU2lnkUmffHkucOq5QNN2BAp2YgtXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ez+tYKKVo9fAeAGG1ukAn+P4+UyjYDj2C6F/xRPJuAwV8+Tx5b0+gMTKFWQmLX4v/wjFngdJkOUoYZTQtkrhpuiutFZWnCuenG88OGTb/jEf0YoDXEpKqjVKPW9Got6MW7nPNWlKwZOMkVQVwL5F+x2aHBIfSz8tIVRp27845Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ew5N9ayI; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvO2huSULWw+QIrt/rMZwopQW7x8RnpZj8eMwPnweU0IBWRA2SWb+Mlzu0R5pgiHOj5oJEg/oIt/oHPUD70m9rhOJyLnVr06V87asCHzToqR6ol5MqlXv5OsGi/U/Yq03Fsb9CHmQPBUoaqubFCiQy74rjr7FwZG0qB41xJ8ZCt3dHrZNrWikTpuLLNlfBS0jQyCciRxPcxa/iL8ETSmo0IDgFni0eLunZkkW20KXKCzCYNSoYCUMB+x4vZ7yteDth0f7yflmorlo2MJmkIHyHd2eS216eLMZKGjbx15f/TRbkHAgBJiUCx8H1C8qiHSM6bkeOpRn3hpEDE3p3rTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuDZml33RQ2hnJHE8xHq8EfNGdUfY02rWRpR2b9/jKg=;
 b=sHP62yu6/ZgwUyIxvtXmbBIg0QVZKdQFR1LrUNBKBU5zdHrXmnLAElpBVUhIb6W+YSG4E6bLJyEA+WP8qktSZ7zm+Wn2O72sdBAl0Rk+0364CAzJHN5vJhFBjHN1Th+2IyHQQDCKZlFMGOlecmPnH+Imxp8SdiRxMw248EQE9ctTU1sHybYdjNgORh0f6Mr7AlWLyeePYcMci0QJqw03HcLDzLxZBakBT9D1/fDq6va1Vnz7BdBMcqbiOmlUaUsfgnNVR+ZHsmZ4kgP2NV2e/jKFKjm44XwplFhB1wc/xYO8ENkkxWD6KuxGdszrH7b83eBsUpDBCKjSAgFZJb1qKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuDZml33RQ2hnJHE8xHq8EfNGdUfY02rWRpR2b9/jKg=;
 b=Ew5N9ayI8BfgD+WWdjE1xVebxxzk2p47diyC8iZZRwNKEfBypW0qGI4UL8J63/OzzvQWAmE5R7VaAd86gTOGs3ZF7DPlarZJV86bYS7T9dWADgU6r6yxjASAlbelo3m88suIa2ZvOjSIlGJQ8dhJdho5WzP2YKkxgSGpwcRPu3xZnxeXJlp9a9ouMNAN58TBqX+9I0GF4FclP3wCsqqn7iKSvcyszd/ZjpvprpWkNNtCU+7rBsSrtk5wrHk6DLv226eRjOIlXalcDsIGO52qqY2GdmWKfCrbuiSHtxPvCw8W6+umQ19seKlouP2084q/LWFQl2nYftes77gBmIoZ8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 16:23:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 16:23:33 +0000
Date: Tue, 24 Sep 2024 12:23:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 4/9] PCI: imx6: Correct controller_id generation logic
 for i.MX7D
Message-ID: <ZvLnfMDEiNIa6CNc@lizhi-Precision-Tower-5810>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-5-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727148464-14341-5-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5930933d-7b92-4254-87f3-08dcdcb53bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LAcCNqW9tpej1fuAljDAh73+2NSygYy902ddJuMaDRUT7CdsAt2LMhQlz/go?=
 =?us-ascii?Q?rJkVg129r8P7RwAOhHvOwHwIqnnHqNV3bT4Ohnt+N0NkgS6kvvZHYpWT2tRR?=
 =?us-ascii?Q?wVW4iR8UhfjB2spCG4AaKdOdDZdlAVWeQw425ZfPoVTlIWhPZ1V5t4Pntx96?=
 =?us-ascii?Q?WZBZcOBxrv99TRE1M8M3ddXCWtIN/Vq0hrtIuCJT2I+rnSHdbbrZHI9LmfYo?=
 =?us-ascii?Q?toBLYkqYbUAKgbA8/4YJ/TcYOZ8SWAMJ/J3SQocn1/Ccd9MRiokFsTgPkF9A?=
 =?us-ascii?Q?Y9qnRZ5dODKgfZmz5W/U6bv81In1HPKv4s1Ox4VyqvmbcWaRh27R3blYPB9t?=
 =?us-ascii?Q?wCsxkpKD5UaCvTSAkwSEZOfu1a2lIh+1CAFMi4DT4s7pRUYwMOe7FYw7SB89?=
 =?us-ascii?Q?ke3ayAV0tcp27TaSra30xRzC4OMcysCwbijylHQO2muVmFWBba8SX1uQra3E?=
 =?us-ascii?Q?zHHKMAIF4LD8aaBsMVt+GRcmxdaVVw1sWDhftScPfHiFGf96FdxjCkWIDmjE?=
 =?us-ascii?Q?U5bSSQSQZs20oRP7eYNge1GDt5pagyRjEjmDTuzGwylCAZTBiRaRmpuhHMwI?=
 =?us-ascii?Q?fAmcQa4vNR11SnGpFiY5+nZyfkgsICydVYWkhyblfYE7W2duacIVuQW9hMC9?=
 =?us-ascii?Q?G7cI0/HV108o6BU9pFiReAs/LYi4B7acSck5f0WToy3zeRqBYc8HN0IMqboP?=
 =?us-ascii?Q?RKAuH4Kxr8V5TepGsEVmH+vcPNjRxJDuFb7nTdTzQvi86BJVaa+VAoROMFfK?=
 =?us-ascii?Q?xwodBARDPdZ4d22rHc9Y3DflOjrsTiCLiE4gQuyksSf3jj00xS6J824lS+qC?=
 =?us-ascii?Q?DO4VCURtQES3WRUKPKp+NNwFdOPTfChjmWrxgdO8maKQXGs7YSYGeui4bg1/?=
 =?us-ascii?Q?BPqguP7TiKKfoMmYVhUn2yt1nMIZBBsBbcMNRbwuIPWyM4+k1L/gzqhJK6Uf?=
 =?us-ascii?Q?AiPJvsKxZTg1A4YHfzCK7DnSFsll5LFanC3tJYQnSP2Jajzc0f/dKLkKhZ4P?=
 =?us-ascii?Q?iJyDSyDzEoiwPBqMEvILZtO8ZRmb5SfApC9izfeLzYHN+8K2j0jCGyunIObD?=
 =?us-ascii?Q?IwITGeHIlKRTomY9Pybp4MRcIBUN1uxzIEs/NyVNeC+Zw381Au8oQhN5rhz3?=
 =?us-ascii?Q?VoYQGiCzgZNG1MlaTc5YblPSHO3BXmAiS8TIxBAIwdAWl22QKdlUuI5AnEYf?=
 =?us-ascii?Q?9/cXzrsF3kGM3xxqdIf7OqsiKkE2SQshyZ/+rJ0ZHHPQTCOJlGvQ7prScXwJ?=
 =?us-ascii?Q?UjowT+LAyr2ZgZEk4xfg4lmemptFEaB+r0FxSmO6H9pfI5nMHhTWBvgW986Y?=
 =?us-ascii?Q?ic1MVkBkBBhieQEuV7ejS3OCeQ+Rdw+u4GEsUribPFsmUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EFmDyvYvGX+34BrEw8FlayOaKJxv0bRNa+75rjfKLpRnjFMUQ7VBEZVVxKUD?=
 =?us-ascii?Q?N2jHsQroZug2P8haOFrT3YJs+fvVcChrLd9wDjxkEwHWS/v1kHBQ4e/qcCQ9?=
 =?us-ascii?Q?gxecwAQyjO8mr5i4QGu4pRe4PXJvxEk+09mtQaK+YOaSJs98LmYwECevNn3N?=
 =?us-ascii?Q?buurAgBIATqa3kCp5kcMwKEjEqRFHbO2x/44+3gDfeJlt+jVf8CDUnS3xQN5?=
 =?us-ascii?Q?ITxsh18lQDSxOo5pE3OfFW/hJ9rsPWRrJc1FKQTDf95b/kmnd5yo7YaSDqzD?=
 =?us-ascii?Q?SZ5Su4dO/+sG16/MexSjuJNXl86NcSnyWazVtbETwLLxbOvSYm0eumkvTuAs?=
 =?us-ascii?Q?LoUAGw2yu4iNUjdcD9BUHTieuHm502EBIJRF112j8P/uQW4DS7FcKO3qeytg?=
 =?us-ascii?Q?pChMiLk90fsJgl3nUYEZ2uVgxMr6zQgb1jtrcXuTcTXy6TU94xBzCFUnaGN0?=
 =?us-ascii?Q?J3dwPxsDWN78GPNfRbrXbU8b2fx4b2NcsGBA34dLR15MKaYErsqOdDdIeeGw?=
 =?us-ascii?Q?5JOnLUvCOaacFrXaciGqRG1GNxK178Obn/4MGKZvkIe9KwVZS43nmbiN/HXK?=
 =?us-ascii?Q?E5lwtBBfPR9ePke7neyE8kCvvhXQSGXtHFMCOT+vp9NXnJ0kBeNXlFGHMP1x?=
 =?us-ascii?Q?EADeaSeb3K5W8bdDsrcvqOsbST2vdC43uXm/X9dLughvn7h6kGZSKU13th9n?=
 =?us-ascii?Q?NDbfd/FfawTmY2L04NgIn7GWsyeEtQE97zQCthrLa/8hl7lID0U3rrjLFRnV?=
 =?us-ascii?Q?GfoSiRJLcAqX059Bp0g4rlE9GUFYZAX3WECaNJYPnjSw1kteFL3/dbWWhSgp?=
 =?us-ascii?Q?vhAUr5Fw01e8mx5wkx75WUMVVSrVgOEUyDd6R4lkRcw24AYtzjBJ1mJodd63?=
 =?us-ascii?Q?Z96hq0PEdZis5Pl1Gi314Cyx8WEN2m2WOtZyrdku/HinzuwPBEZU0au5+ZB6?=
 =?us-ascii?Q?MDWOY7FMlNyjEwI6nM7s9WDz4lFfQFnqVAASoUqQBpotCL9GQO3RTDV4qCRk?=
 =?us-ascii?Q?ERWLCnfuIS1bosYujZRMOPLxc9ttb/ZZWAsXMYB1hcdtlHdIC73QgYOief+u?=
 =?us-ascii?Q?dJRWYH+AYw5gLVYpkRdPIuXz8Kn7FMyuI9/9CIac6A7NK8o9RP3ISiqqTJry?=
 =?us-ascii?Q?/y0ZtDzowfRGA3H3zZERm4rJSEcRlGb4d1m3oFda2fx79uEuEzYaXkXhM1A8?=
 =?us-ascii?Q?0uFfkaNROZrfxvt/HXDnbyTsPF0fdy5PtiOjS85K3iB1HPjB7OQNT098lzZ6?=
 =?us-ascii?Q?j4aemCBMxwmYD03go3wVdshOp0BwqksYPddK29bKJbboW1dN6d3FyGZq5QOr?=
 =?us-ascii?Q?OJye/Z5H1jhq79zb+H033mdBuHiSMfigaIVQ3PK+/UHRxwgQ/WK6YkcdnNf6?=
 =?us-ascii?Q?AnRzQyxkM7489FzNQf9t3zEPMmltnfEwCBY6L/hFxNGabd+6GNMxQ51esPJt?=
 =?us-ascii?Q?ZTiu3aW7iKNUMQ5lHCnpy1ltW0xqjF2PSFjIo6oVNv2hi1+TvuUlOzY7XIyx?=
 =?us-ascii?Q?XGFiCBrSccmLOOSUibwk/6hUPJOHux6VVeDsUaRRv1sb4gbFGFEWlhinXk7J?=
 =?us-ascii?Q?iJzvBqt1g7GycBaDPMk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5930933d-7b92-4254-87f3-08dcdcb53bc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 16:23:33.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAInLa5VEn4kVof598dBEVbHnKqu5rTd3qjm40FbxaMkG+qd19xaDpLDPjeYDKqoAtRcS9Si137dgnC6Jcbp2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

On Tue, Sep 24, 2024 at 11:27:39AM +0800, Richard Zhu wrote:
> i.MX7D only has one PCIe controller, so controller_id should always be 0.
> The previous code is incorrect although yielding the correct result.
> Fix by removing IMX7D from the switch case branch.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e8e401729893..d49154dbb1bd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1338,7 +1338,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	switch (imx_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
> -	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx_pcie->controller_id = 1;
>  		break;
> --
> 2.37.1
>

