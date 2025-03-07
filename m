Return-Path: <linux-pci+bounces-23132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F0BA56D31
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 17:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E423AD951
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62C22489F;
	Fri,  7 Mar 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="md7RsDhA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8922489A;
	Fri,  7 Mar 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363663; cv=fail; b=TaN1onRSadz19aK+f4jongYhxDU1RyIPLkQ2nSli7N7G5RYQiMnu3i5zv/4m+6TSLnB/sLKCE1+HWazjFT1rGs/U9DJKGXesjLAsuKHLnmIeq2mGTeenH46XLQ92PuMW/Vpj+X+5D8l5jg+/6CTwTNRrU0vN34xGw0IHSZ5VKGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363663; c=relaxed/simple;
	bh=hGlFr5m8rjFWp1nptg9PRLjrhHHNb5JU114ydmsFB4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n5nKFMHp9zrvypaRmjC2+zPl6ACPQZqPK4yF8o21lMApLUi5KMx4+exCS3fYBzdAXh0fqlBjEhsQAS9ZxkMQEYRD7F0/5j3SQdSRb2Xqz4RgRFCaJPAl5AIgsCQXkl2TSdYTf3Xgt6xJ3HIlEO1qdgjHe7i9ccUdRrA/EGARaAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=md7RsDhA; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G77hXEzHu1KXWcQtVLXtJ0q5Wik7UF8vWS93d6z7R+go6kqkneUsA0MxkMCvX2nYYUWod3FSLd/DAa5f/w+QseuXvjmKJwUxGWyBLj3eufPePPTLwnO3uN37i6kyJ+6P1lZobOQK9Uq1leDmfDexiZzRvd7Tv6/KWEBLl/6a3NKKjpPrGDsv7zyIsIOF/C1LIhRuLKkqdogDz7VtxdWSGrB27JmCKQCU8f9n+s1iwJgiKf7lT0nuTqjhPkxc9HbZAE7Jtrx4K/KOcOuU9aK5xGd3CK/MbordLoNFczFt/pGhzxw1f+PS0S1A6Q4eQz4sDx+nzEDa5dsph/IqeWY66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/TWIirvLhhRxpyssgVJKHDHnAsFNmm3drVk72mebIw=;
 b=g5qp6z5ufZ9sGGUt8Tq0QahcUBBKrCVq/8Qz2AgbThAJw6gGZJ0GRq/QBBdmBTPxZWgl1vA9jsyD+nRS907LKGv25dKtixJ3tfCLsZLYMetau58F7lFbZEjK6kUZJvQuIJBJkQbOwdLd/89Z7UXALlkU0gsXC/UmFDEuZaz6ejsqHNQ/DB15PdxpGlFtBC0yvfAvEVQM1hrL3PDUldHlL7rX0/4MotL3o5CnuyXg1x6uK/BV7xTqB7CQ4AhRuKOOoA6Dgr5JG9cPpAivhIWqa34Ec4ulFqNe9svaoYEv4NmSEl/EON9EHPzGl4RGDFR0NXzkzrFm6bEZ8HeFG4iNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/TWIirvLhhRxpyssgVJKHDHnAsFNmm3drVk72mebIw=;
 b=md7RsDhAUILYhY4joIrKu6liT1ZOd4qNdF1WApKBgbRmMT6ayEz5FQ0N+mRTedxooRyJpOR7KIhIUj8j4Tz63q9g5JRiA29IKkpPC7GSf5YAz2dPHZlGCkyX9fJcU1+RpbBQTQzXSC9CnjLpdyHa45uK4A2fgTUoK3V7nHK/1Qf+LDb3Rk53TjFoEWuOU/BHoAXN6yQ6WLWw1V45T9hhSfEV+Mzf0W0bwPsndY8i1o2yC5hPpJQPLScCWjZwQRuxNVR40BwS9z8vAQFofHuWZq79bsdrfr9sKbOnC3Yg0XMEtIcM+bvJmuBd5h5rkdrCEnwTwr19LGFSAtaaFLYyBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7495.eurprd04.prod.outlook.com (2603:10a6:20b:295::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 16:07:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:07:39 +0000
Date: Fri, 7 Mar 2025 11:07:31 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop
 unnecessary status from example
Message-ID: <Z8sZwyBpXxnZkohz@lizhi-Precision-Tower-5810>
References: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
 <20250307081327.35153-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307081327.35153-2-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b68be8-6cbf-4173-b560-08dd5d922f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZ0Zi0tU2uypta7z2604W0wM+o79+NW2I7KFa9QNSurbtnbvUort73vvKdhM?=
 =?us-ascii?Q?GuHpr8+4m1WyLjVY36vdypqBXo9IpfmC+lA2wpB9nJ+tjhbWJOfMINpOPESy?=
 =?us-ascii?Q?NKyXluIZrtntlI8Co8GmJ6N6O2jSooCEzbrxe51qe4fUcLEUvRx1YAyb1cY+?=
 =?us-ascii?Q?RZLwJIeiUWPPHvYmws0hiq+/we+H0E+zMfIK6x38JmDXYg48DMtC5eUb3kkA?=
 =?us-ascii?Q?8bHINYieOO2RUmdzkgj2a5PBt97sKe3wOoilVZR1iQRLyLkYAJ+IcIHLkhKT?=
 =?us-ascii?Q?paiyt1tebcDSq2x4UlVfSbq254huHSR4fRKP/iz+cqGhteQFE9hxZ994gu/+?=
 =?us-ascii?Q?okK9JdNeEUHdJQ2qLmgwSq/iRjxvYiiXIrB8rEhB3BNnQG8oFoNcpgoUm+Ni?=
 =?us-ascii?Q?+2rq8VqkylIluTRi3viE6HmaGZw5Uq6UYaAqiMLWraZB/Hz9uwbIewOqiKJ2?=
 =?us-ascii?Q?ddPT5DFbsUlHPNY86N8W8+JtyBsK+fIIzPOH8xH5QE863s6ou93cMrNbIP2D?=
 =?us-ascii?Q?PBZ+L7LL4Zid71Z8d8/ZDcxswp3w5lsGRkgnAVwPamejky4uw+ev9GbAxREk?=
 =?us-ascii?Q?FIH+27pQMZwSZDFyHZw51tzuOJaJ5L9XlUBjc+MCjaD3Ca8wuJ1NM2wVqJI3?=
 =?us-ascii?Q?k39+MdG3OO63jl2OODAAmW/zeueDzA04U5kKiLfSM/YH8d5EuiTp2AkpBX+H?=
 =?us-ascii?Q?xMimLkClychbNBeyfCWMJ1Laq9u9BO7s0Oj8JkgfqZM6A81SxUx+9NMbrLXZ?=
 =?us-ascii?Q?aw5646HGqeIoYZljHFocVq+htaGfgYjtMp0EtKK/lllVlaa2yABkIN+tWTsl?=
 =?us-ascii?Q?wQ9CNdAvJcWQIXa2xafT97S0cgs7yeWUqtu1jtHpuQqtycAd1Q11oWMR/zVq?=
 =?us-ascii?Q?1zE1X0rjLiGofF9i7J1t8Pl2kqoGDcxh920/TPqQT6lFjWbHfYoxzmg/zrJf?=
 =?us-ascii?Q?Fsiig4Bgf1scfKufHFI5mE02BN5VY81zEkHmRgzM1YsaLtoCsyfYJkYXI0W4?=
 =?us-ascii?Q?Uln1/aNYkCqG9v6+5GcPJxtiy+qghq8+e+7ZvtuHdsRTM3jQpBttMZkgWw/J?=
 =?us-ascii?Q?2E/cLed87mdR/D0GmDeotY9KrxgG5YGfQBmELtIvBnPEK0M9WKLggJ/Hl5fh?=
 =?us-ascii?Q?iJp6aZRqOoJEycVOz8smdfdE1PUtqwqqGT+FchPNvaah4YmLNFXB998Bu9d5?=
 =?us-ascii?Q?Voxqg77B9qOIRvokRH4RV4D95e2FISZGN+QFeM09WFuIYbB4YsBOAP3vMCQR?=
 =?us-ascii?Q?SR+J7gtgCKbYfzPuYgdAgonIn90hz2XMu0hGCbEvkyTvWPL+GgT7wyZNiTmF?=
 =?us-ascii?Q?Lr99NCen8niCO89ujxyEUkzHtET0tNryQwpOomdSOZDfocarUaobr982HUwI?=
 =?us-ascii?Q?Mem8PFxgjsSO8Opmw8PwAcIJvZPBL0BTgTcJrFIWkRtv9OnrMTGcUeeq2lhD?=
 =?us-ascii?Q?ra5bBRSv/bBb0GrkXznSI2Rw9V4sc61L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ovhrFB/sGVvvKaQllw7WmfPVl5QQNbQBxYrrimvZAoHAmBnQelZybtcReIo4?=
 =?us-ascii?Q?aIevufYCObkuV5CWioRR9GywIfPkaQIvB0AQuL34ioKRABlBwCLP+q8DrvC8?=
 =?us-ascii?Q?A8Ymv48quXlHDq66wMIeuxTErrAcE4jsVcT0FatHI//TM0U9L5j//HPAYIgb?=
 =?us-ascii?Q?u6YJCBnVe8P//bYL2qaIedpLFd7FiJDI715Ra4bJl8oHxqQ6obi1fMjjOMq+?=
 =?us-ascii?Q?PcRE9cYGC+nfLCXIbTWv4hNLTiOEdZEe3Rs5eB3JsQIEA6A74vd/uEBUIHL6?=
 =?us-ascii?Q?X2D/Cs/nr0mpHcQdBnfwMAeW5dRZXhq08Y0JnQlH65CYIs8HcWRyBekDTuKu?=
 =?us-ascii?Q?7a5lNTRGdC+YCVbyl/mF8iFLJ2Kg4gKY1nBPCnRkwaPcWAc3aQuqa7/7x/ZL?=
 =?us-ascii?Q?AlTeRd8dowGDjs5cyy8CSdSd44V/Iig62F+03APnbnmBxcaspK7lHEN4ZEhu?=
 =?us-ascii?Q?gbxMUUICKbe2BXzvwFy3HcpOu7k0eEDgGmh1XpellXfqVLpM0h0TeYHG/2fK?=
 =?us-ascii?Q?Y4XxX59YMeJc5H123DWBtspb3p1DTreJxXXi6i8X0kBDE9UIE9eroFpnQsUZ?=
 =?us-ascii?Q?gwevQrfhq5I+nKugaCAZdhDlMJeUU9BsgMit8qEYphVRKxcf3vMVHuuJ4HaI?=
 =?us-ascii?Q?QaBAaZtAjuB4Ii7gsAw9RoVz/i6wNMZNlNdDklixEK7CVA03adT92h1BLOEA?=
 =?us-ascii?Q?/Usn98oaUTPTLflrkHPfgjpLMuXZ2vDNKxjTKVwOWEUJNnCDJhDQ/N9yLZ63?=
 =?us-ascii?Q?KmqW/uutpOPz+9YF1IQYUxmWAp80s22k14V5vIya5OpzQ9wLCeBeS1HjD0SF?=
 =?us-ascii?Q?NSs8bfZEF6O3opKQ/QxODkWCUuMGos3ZbPpg/yuHSHBSY3hHXuZ/69k4x0yH?=
 =?us-ascii?Q?NI6RdpTSs7A9oo4XskeiG4SeoDSp99YkjYcX1BE4K+NalugFAZY0ZhYOcHj9?=
 =?us-ascii?Q?CCSVjpbOlqvTfPbcGTh5xMmERq9B7/RFDLyNkLrBRG30l8XzMhf1awXNJRBc?=
 =?us-ascii?Q?D97XE+UtRhKB6uadsMRSBzZRwcDneyZUhhhsevD7QaCG9TrJzlaaTlcmt57R?=
 =?us-ascii?Q?liY6Ex84RuBP4a8CZDanEVYKHlzgSu/EMvnL4t0lLHgBbO8vQtTrz8sqorJR?=
 =?us-ascii?Q?7EnmvoZVyzHeNgdCC3q7MADSPqbthRF0Dwag8rt67XbSfZoPPhPvZWWkDSOi?=
 =?us-ascii?Q?VKf8PNpPlpuPxifcrJnd8I92g3gkWJI9cDyfVcXtqvbzFkTuxQaNCQbebRvP?=
 =?us-ascii?Q?8KB/lqX5F7s4tsfLpElDJx1Mn78hfPMMNSGwOqSaNa01uqLRQ5JgIIjPF/TI?=
 =?us-ascii?Q?hrf0FvgcaQUv/4bftnRrCKBE4MQW+RfKZ+GvwvOfk5EBEhduKKVutGuGtbm4?=
 =?us-ascii?Q?/V8+Wy1FY/HCj7JVCKygvnAdVuhf5sifbABXaxjeYzN/a7Aaq+ydZRbrtxZY?=
 =?us-ascii?Q?XahjZXA3ynAv+IBGD5ilz+huAomuJhfXsIsNyF3Z8RwsxzV75v8uImMl1R9Q?=
 =?us-ascii?Q?ITsct37UuNISgrTmcVa9B2G8hNPaRdOPyF57fJRpdxBcNdjs2/P21XAbB4Xw?=
 =?us-ascii?Q?lCy6kAvTfsG+MxxtTlogEBnRj48jsE79xJCp2ebR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b68be8-6cbf-4173-b560-08dd5d922f0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:07:39.3857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3yXVD0eZCRLccfHt8/3nvNVFXKZXKNRBRG36p9mpqrao+XX7C3BwQ0ciOWaVld+3Ig8V539h7uapesQ518uyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7495

On Fri, Mar 07, 2025 at 09:13:27AM +0100, Krzysztof Kozlowski wrote:
> Device nodes in the examples are supposed to be enabled, so the schema
> will be validated against them.  Keeping them disabled hides potential
> errors.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml          | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> index 1fdc899e7292..d78a6d1f7198 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -94,7 +94,6 @@ examples:
>          reg-names = "regs", "addr_space";
>          interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
>          interrupt-names = "pme";
> -        status = "disabled";
>        };
>      };
>  ...
> --
> 2.43.0
>

