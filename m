Return-Path: <linux-pci+bounces-24566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E8A6E33B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 20:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2883D3A665F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D5148850;
	Mon, 24 Mar 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fyaQP/bd"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE584D08;
	Mon, 24 Mar 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843949; cv=fail; b=Hz6mf9DXM+FXOymEeFA7g+HEkYkQ3/p7FpsTjYgOQdVEF0uYt1s7nxrE+kshbKUK4mlRITyjufRUo73fQwvbVqQI2fXZkZvSoFSvMjsWwl6AR4erMP3EQKkYJbLtEf9hzKxmw/qkz63O426s3XNPb7rBhpLJI8f9i6PPb0KBs5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843949; c=relaxed/simple;
	bh=4eowO8A8qUbmSL2rnx03jBRs3rz1vOurpWVUzb9aDw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QwFa/cmW6v6ph7ajGHRvJ57sXEY5RfyuUQtyoXYm7+iqZjxh+9tSkiVCQ1ZwafrkfIbY9xKX73xEZ/ebsrTygX9iGkIH6KP2WHynOOUVg3r060nx9usxwQ4wumhF9c9vb9lSMKkg1+nW4pL5OuobAu31K+2Bsq/A4crhX3vphXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fyaQP/bd; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrosidr92I1GPoNCprqzZYf1sZRDLnzJ/4gHCsmXCZ/1V99kc7PwoyrlofrDC/sBDaYCtK1yOmBnjsfDHJId8088eSVclqGVrlnwb7Pi+zX9PA9zTdMxtA2pN2iT9sijyk+ySmDSaHy0jJ7Dg9ldg0Uubhe7ViLU4D9s43Vdk101/jfg8NZTOXOAeP6IYvznfnHolwy01pECN01BhXLcGU/08YFLi88kkr9f6FbzzyO0Jknarh3acBEqIOQFE3yn6pMa+L+Q7RzEXhRK/TY0uJtCjCKoVuLlb/B79n07lVz7L3wOHcZZwh7hRiUS61c14TqT1NQ5ilksbjfbk6GQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/Ryn4TuN0nsTbrc45njRwtkhVgpxP9Hz/vwCYDKCL0=;
 b=IHy8yk60Ey922w8npPQZ6fT1A3/FGOPoNo/8Rt9g4hHkqQss8/DKSN9687FnQjhIYEJ5KhWZ7Cq2whBYPfjbiCnxnyzhu9eKd72U6ko7uq1yRGWvRKr7HEF9VWJDXsapLzr34PA7E0U3G6eoVL/nMXbnxjiS6smx3oFpiETuDEiSHl8jcp6GrLaCsjreYeHwXPVRuNnQqOFDMnZdD1bRUuWneGL8uOm4dDsrJRRxvRrK5LWdNFXndoyrW7Au8367QaYy5NmsC/srC30jrHzg9WrpvG5XzQD19siwBjIq9smwmqo604FnZTY/vp1lORgometFiR94yxGsfQv2isTe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/Ryn4TuN0nsTbrc45njRwtkhVgpxP9Hz/vwCYDKCL0=;
 b=fyaQP/bdSeeAIW0sTU9STbL+PKeUKJfMBNn2cgnR8oYmeWmVYYojOvByLYG8626Me+GrIPMoQM5pNoSGt4agdlKdlHr6Qxq9/az7yX0MJQqaeljdeaa5XIOZu214BeT20tKEmOl+uzsG5gECZxCHZhisR0Hf1WpGWPLf5e/uDYiuXc8jP/XIB/eef94JgELQSrQurX8Bw0BuRsAGzQReZdGEzkUW++PLvQ4WlEK/P+4A4ZE36DbRQTC+FYYu+dllPH6uGbQ0yAuWhPiypJUuYPlQASE1PDZjeghUqFZDheFw3qyTxZenyaM740C1c+/3v5gDjYn5fyn+o5rS8BuoYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10654.eurprd04.prod.outlook.com (2603:10a6:150:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:19:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:19:03 +0000
Date: Mon, 24 Mar 2025 15:18:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
 Receiver Impedance ECN
Message-ID: <Z+GwIOBB9MwoKfpf@lizhi-Precision-Tower-5810>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
 <20250324062647.1891896-5-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324062647.1891896-5-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH7P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10654:EE_
X-MS-Office365-Filtering-Correlation-Id: a67c68cd-b057-488c-1444-08dd6b08bd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3n4+kWE4PYELUTlwfYdCxJcpqJd783wjMoy48buTijxRkCqqpi09UxbebVgk?=
 =?us-ascii?Q?1iNJmEjtcMScEyf8M2+lWf+d7vdIpWowN3ehHPB/flJyTAX3wEps7z/OmYzf?=
 =?us-ascii?Q?5+U51QkogrhCNrklBxuL5EkIEeZCzSRFOxcieoG0ih4m8P7ijTA+gkLeqUoy?=
 =?us-ascii?Q?J9RokHLU0KZLU7i5iR+GwyeaqUQG7lStzXUsj97M3vlnJ6cZW3g4Ypjk/u7F?=
 =?us-ascii?Q?gp4/J1+/frS+vJFNjVrt1GtNveiIC0D5BjTo8LZTot4NklfYSxEOdzGmLNur?=
 =?us-ascii?Q?NuAUqZCahHm4gENTP/BsxkfAuO8Nh8b4tFymZiyNQt0XroLAgIKpw6fFZ9Vy?=
 =?us-ascii?Q?Uueq4FbTpjVd8Fi8velFFNvrdoHmuaABIpzg6GRPkRbEgatdrvXVZOxQ5aBP?=
 =?us-ascii?Q?JhcL2HDxrlb+Enpln/QmvIdUuvZbdi2NFhMniITukZEQl17Wyz1bOR6cG40a?=
 =?us-ascii?Q?xX2l/rS2+LMA0F7GXYfJXzpBmOtinOuCOKWICHjwFwEd2vZlmMroU4Oi3VrG?=
 =?us-ascii?Q?i2/I96tZWkxn724vW1eq/RQuoHdSaugr6IjSLZ+pVcsTOHaQiIqGDSGopL2A?=
 =?us-ascii?Q?UBJGQcKvoqHHwI3kxWPVhfzoczKxgJnVkm+pUElWQQZVl6A7ROUXcKxL0qS3?=
 =?us-ascii?Q?G//s1009NYWdjU/MkTcN3u2mzKg19noQ49kQFPv3g6FN4YTYFAGzl+IimDSf?=
 =?us-ascii?Q?njCtGV9Au1HzlwuwQ+5C+9EORaHVXYKJt69xK3+GIlkWNkObSNW434WwEeKs?=
 =?us-ascii?Q?WUuSrb7V5yRBLxDiAh//4c7VLBsHM45BDun++2iWVtN9B/eM8nyF3p96l0TI?=
 =?us-ascii?Q?CMnVjo5MYn5DfcmNY0bbl+VXTZXM68cScO14iNVCQg0uU6iKfzJEBYt7Ujzp?=
 =?us-ascii?Q?Dr4ftdx8oM/g1VW1nw56rGjRtvsVdY4JcvPDRX6W6o1uhpKhVTa9yi31raut?=
 =?us-ascii?Q?w7VoRJROKvV1f8a1EZNvqLLFDHaSPJdBdEqYj9A67hkppecb4OggBDk6usNh?=
 =?us-ascii?Q?BcqUINqWyrL6vuhw7+xXI1Cjlt6o8hOjywKIcifax2IRcZxQRlnoB0wOFr/b?=
 =?us-ascii?Q?ndDhd7aJzpk0IrDmUVb6IBfgOeD0To+a+6gdj9Zj6PExGNAgugFPZjlQgfYU?=
 =?us-ascii?Q?xXIyLjf7/5aT6OsukmE3J7cSUsYbpxWAzQ0PmMMPKLODGroDusf52Hj4rW3G?=
 =?us-ascii?Q?mELG9Ih80vnCeDKsDhwpSTFqurWHvsG6jhwtEIEMhwZzC/unrXaiIS7DFvBL?=
 =?us-ascii?Q?OzDgxa2WVH95b0O4miDogFeDZUAa8759pHe4w+zVOvZVCmIsmMguvqZ4eHvX?=
 =?us-ascii?Q?fmBcC42uDgg4E/fYEeJqfNdTJbH+LREe9iqc+jwCL3Du3p7QbX2mtrnqna75?=
 =?us-ascii?Q?+G7jbEtcuKMz25r3O5ZVDJbeGWDtIIrHeGaKcomw/WSdTmVztbiPeGnMoPUf?=
 =?us-ascii?Q?wXQ51X5RTPj66uL5JfYQrS7K5T7TciLS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpyJKrtvYa53KYm6RImNwmOFVEJg/aIrG9m+ohMd28Hm2JK8IEUxIfruK6UW?=
 =?us-ascii?Q?82Fr6/ay5XTcF/TQRA+7QXMFxww1BpfPtbE1R9mPzdXCdag0HJQ7K2l8PmNt?=
 =?us-ascii?Q?9YHFmVouZQP8ym/fuANlu5IulP4Dm1hZ62WsAqt7oK1980RmXc3q9ho1OJEQ?=
 =?us-ascii?Q?/kIPsifkf6SVK9FR8OycMwrBTZ8nYTH6WCJS1buYyx5bkZbCCLhyWIfNQtLn?=
 =?us-ascii?Q?BQR+XeAoA7cvyDK23p5FXV8Kg8Eg2Gh02SaXCSBWYTIT3YOqHjHrsuNNPWrx?=
 =?us-ascii?Q?zaEbAzkTNfakb05/BGhWW2cSZ1H3Wdhhxh4UcF69ZOq7Saoau8ZH8WamGcHY?=
 =?us-ascii?Q?QrUe0+NoweErjvstbMGz1oixF1wK0j0weObgl6dir9iAyk8psEhithesdJ+m?=
 =?us-ascii?Q?eF9MHoeO3WdfKlPtjOvo5dYgS+zHd6fhzbH3kkVMpF+BV1DXhg4oU5yGe02U?=
 =?us-ascii?Q?rw3wdzZbLUkAZyz7IMKZZogouRD21Oq5YBzFPbdIrfdDg/iS3O0Ev8qqjJ1u?=
 =?us-ascii?Q?VY/vAjltsAzoXO2rkkmooB+o+hAviCd78AUEl6RVmjRZLXMHgh8tM2XJh5py?=
 =?us-ascii?Q?Cgi8Bj9Ba3Q+ofRDBLbilqFyFASEyPxc+5R3N3wmLF2NoZ0I+kmVamCyi90I?=
 =?us-ascii?Q?cVt7moWlhMTXObEgRovPNNwYGK50UbnQk3kWbtvCtFOOQ2deiupibQgRPgWB?=
 =?us-ascii?Q?eJpHRDWbhlXoBlJMWkqGqBa+lDDD/ktp1yMHUiAMxSoGWO7GkieVm+5RXgRc?=
 =?us-ascii?Q?0iACKOA20aQ2QQwy5iDwZOXwv+X9yJHxSbilm2nwwg+oF8I5AdzSX23hpV+H?=
 =?us-ascii?Q?YClE9D36fTuNNDO0lf+EYcsipnWQHtTFio8kcay6LP6zuVXFA9MFdE6hFp5o?=
 =?us-ascii?Q?0lWnMgOQZVJTSwVQnltWOdU/qbc/7QbPdnpVIEzHZMGqrABZA8VNQxiVp1d1?=
 =?us-ascii?Q?KYERVm9kNM6me8HvrMc4nNrLdx/Uz1jXtzwnVzqWfLWTkml9YxDnjtOXRmOU?=
 =?us-ascii?Q?VN9pKZyjsNc4xjaqTlK1oZXDsOWAej8znsNz+XPFqpnhRs8I/7gXZOiOcmJ0?=
 =?us-ascii?Q?lDktPy02qhrqxAyrlWmEfJmPVUFS6oQcLaaR64I8UXvd6aR6tJh+yoDceAHE?=
 =?us-ascii?Q?RIrmCEt4lGviQ45xSgPKEOPbSKFyv9MVOsZif7LIYxjyjcWhzeDH12oqFpSo?=
 =?us-ascii?Q?cgMpnE6yk6qJnKDeDDTHD8oF3un2IQhvEDmc0g1qL8Dxb+/SurlU9M2vw7p5?=
 =?us-ascii?Q?ukZtPzxGt6weqd8wzYPJ/OpT5WbBp9B3hy79y5PVsuO9N4igRvXyInVJ7n/Y?=
 =?us-ascii?Q?rN09KHzkQlINI3x4rtyg0xp9ybg3mEGNiyC3NNUmkV6qeYhtJkoAZVKJspcL?=
 =?us-ascii?Q?2VhVxaN9e3Kq66Jhh6HG4VE/WzmBA/SfgpLCIXMQjEMqwRc66e7Uo+Mk657h?=
 =?us-ascii?Q?avQVl+iqQ5m1hZSackoXj43Mh2bWjv8v8zPqtIGe/VF/y9slrkx8IoWDi0Ld?=
 =?us-ascii?Q?bI95xZtZ6Nx2hkkQVzLa5HPeDLmjOOXTkQHrfjSdJ/0W31uUSd4Fa2PmAo6T?=
 =?us-ascii?Q?UJW3lMJg1cNAperv127V+I6eKL6D3RXZqgnc/aoi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67c68cd-b057-488c-1444-08dd6b08bd25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:19:03.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmP3m7PmqWQ8pNLUKgH1I54o4t5q8ab44WC2gZfMmmQBU6Eld69Eao4HuvT1QEIfjp3PRtpnBnJdNr1WFexjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10654

On Mon, Mar 24, 2025 at 02:26:46PM +0800, Richard Zhu wrote:
> Workaround for ERR051586: Compliance with 8GT/s Receiver Impedance ECN.
>
> The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
> makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
> operating at 8 GT/s or higher. It causes unnecessary timeout in L1.
>
> Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 29 +++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 52aa8bd66cde..dda3eed99bb8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -131,6 +131,7 @@ struct imx_pcie_drvdata {
>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> +	void (*post_config)(struct imx_pcie *pcie);
>  	const struct dw_pcie_host_ops *ops;
>  };
>
> @@ -1158,6 +1159,29 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
>  	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
>  }
>
> +static void imx95_pcie_post_config(struct imx_pcie *imx_pcie)

There are already have post_init in dwc dw_pcie_host_ops

struct dw_pcie_host_ops {
        int (*init)(struct dw_pcie_rp *pp);
        void (*deinit)(struct dw_pcie_rp *pp);
        void (*post_init)(struct dw_pcie_rp *pp);
        int (*msi_init)(struct dw_pcie_rp *pp);
        void (*pme_turn_off)(struct dw_pcie_rp *pp);
};

Can you use it directly?

Frank

> +{
> +	u32 val;
> +	struct dw_pcie *pci = imx_pcie->pci;

struct dw_pcie *pci = imx_pcie->pci;
u32 val;

> +
> +	/*
> +	 * Workaround for ERR051586: Compliance with 8GT/s Receiver
> +	 * Impedance ECN
> +	 *
> +	 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is
> +	 * 1 which makes receiver non-compliant with the ZRX-DC
> +	 * parameter for 2.5 GT/s when operating at 8 GT/s or higher. It
> +	 * causes unnecessary timeout in L1.
> +	 *
> +	 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
> +	 */
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1222,6 +1246,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>
>  	imx_setup_phy_mpll(imx_pcie);
>
> +	if (imx_pcie->drvdata->post_config)
> +		imx_pcie->drvdata->post_config(imx_pcie);
> +
>  	return 0;
>
>  err_phy_off:
> @@ -1808,6 +1835,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
>  		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
> +		.post_config = imx95_pcie_post_config,
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> @@ -1863,6 +1891,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.core_reset = imx95_pcie_core_reset,
>  		.epc_features = &imx95_pcie_epc_features,
>  		.mode = DW_PCIE_EP_TYPE,
> +		.post_config = imx95_pcie_post_config,
>  	},
>  };
>
> --
> 2.37.1
>

