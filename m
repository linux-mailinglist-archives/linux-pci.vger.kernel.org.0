Return-Path: <linux-pci+bounces-14663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D89A0F9E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32601C22F8D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E612DD8A;
	Wed, 16 Oct 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bqdrUuAi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AE2101BB;
	Wed, 16 Oct 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095893; cv=fail; b=LCEXuuycnEqD33Cyi9gQVMxQ9l2XTBNkYYrhzjvMH7gRL+5trPgu6zyjlY4/5r9KaqGN8JT1ORmTElA8zpNGLG/V/5tcY+x6nmwlTggFk0sETYD3Ted76MPM99kraqV+T5RNP1d2t+S82L81T64e6YfRl0nQHYVMyWNA+GyO+gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095893; c=relaxed/simple;
	bh=9oijvjMra3mSd5Y1SrI180rIkvD8Mh9XeqZs/FO/N4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUIepbWI9S5m73JIwlQFZ5gMd8S9T/QiVqGykkkvWWv2ecbJ/+VJz2hgU2y0TGlCeafk602CSsTRZ5pKun0HLY8OOlReVViBZZv8jMKeXWUgkyr8yq257TxlYBoBH9c0l+L6P9Ad9xUyRPT33OERVQ3fDVMJn0267Xaz3/OEeEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bqdrUuAi; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjZUaEp4qe9LEEVU7HZa0YVjxPhxTAtNG2lY8PSTEgBqEAwoaJAO3l9CjLBJBwnQLON049v68i74Pd6QmYJZTRBfRybi3q3+FwVcD1VguLVfEQYzVToPNeWOZgXtXEfL4e4qIKHsnP4J+yPZi0/7lyBP943knQoeIovLbjsqpv88z+2UVxVFZtwGlSGqaZNYl0z1vzBVRJPkl4rLeF5LoGihUbdHbfJjfkxTGApFbSxsBZQzWAr/I1pIWa7adjv0a6cUVHcWlwXXlQXQzs2J9abexaeTHdYGBSwjSMn69E3A0fH5ZovrgsU9BkFgaW3e9ZPEgxcujrEnKKwkNK7e+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OchMtW/vNcwg0aN3c2nTP6GxHvW7xjWRaJ3bSJMelU0=;
 b=H3swL7ItvpAxh+hN7VUif9UoimJs1ylqAmVHzInET0oApf+GL7i0HarLHqIEhCScUVBUyh/hiS/yTCZo84YWKk+lArEUQnv82ogtdJF/Gatzesogogula3MLh3ZqfUyPLaZySi8SOjF7S24q+OchmHj6m6VBoSXw1MTRuW8ELxXvVRBMcg7lkvTg/ne9/YR2pP5qr52PZjMbdaEznIFdWTf1zY6rAT/8ltSyBFwuTkD9AzXE+jRFm+Ui52kRqIRLweB6AvBZAeOtLf+gWggtd1fwuc6nquRpJusc2uvHl8gQjZQtlQM9c9xFkcJlOD8nIdhvdPGpGjAZBaoOLGxJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OchMtW/vNcwg0aN3c2nTP6GxHvW7xjWRaJ3bSJMelU0=;
 b=bqdrUuAi/2t88nJRDFCjm7KSUgXJdYDMqmjjigr6GGb2l23A/i2r4jP7YP0XhE0W/rMyrOoK8lUnn1WhMkazPW3Bcvxs1YaXQVu0aWunE5yNyGFS/eaTtgyvBTEjcI1gI5WgtlsYKc4fpvSbIMod9r7rLtV6AIIrr5W8put1cjmdx1Lpw8Zg6wu6jVbFc9hRAIf+bw20Ibjla0zMNiENK9D7SGa8xWlALPPlBJbsWg4zzDQTWVcTAar39y49L0tLGYqz6OEgV0QT0OdI5SvupiX3mje4jOowf1JmH7t3xZBoCynUlp/u2JVhT6njZBNt6iNx7koUv2cJmFZHhD6CWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 16:24:48 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 16:24:48 +0000
Date: Wed, 16 Oct 2024 12:24:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Olof Johansson <olof@lixom.net>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 2/3] arm64: dts: fsl-lx2160a: add rev2 support
Message-ID: <Zw/oxwypUt5bpWd2@lizhi-Precision-Tower-5810>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
 <20240826-2160r2-v1-2-106340d538d6@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-2160r2-v1-2-106340d538d6@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::17) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf21237-96e4-48f1-002b-08dcedff0ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SxkN2ikYYEkwYXRKEY74LT6z+zt0bANpgiSX35kdrtcBv/FAHtTFFHDq951?=
 =?us-ascii?Q?jMpQIlERJ+jfwiKewQguDEUbGQSU0PcOEmx6+VNv8rwv6EkQs3UDLiwOHk3q?=
 =?us-ascii?Q?5wSDv9Sms/ZQuz6YxvVtwMfOWhZ5FqNlWC6bGvzra23nZhrYFTTuDaz7JCfY?=
 =?us-ascii?Q?uGzvjyaalBpGxUjYxFY0me2vwFc4b11ckMQ1Pokrvo8Gz86yo0D4dmLzAW8Y?=
 =?us-ascii?Q?5Ufrvfetpuzmxyy3ObIti9N2qeSWGaW/w/rvGRKXGKxjlAYC1jYPLK4+aqNb?=
 =?us-ascii?Q?ssm4HuBT5R5gh6VOBp7GH4ghO6RVh81is2Pr9gVOiZXNCzoF7tlij6nQuF+f?=
 =?us-ascii?Q?dZoonib0zIvI87YZbJj8JXlvqavhJDiYHQp+k3HwlS3Ll3k+2Uef6O6pRTWl?=
 =?us-ascii?Q?KchGpLxK/9I2iXLqApsFr+WsF/nXmDoZ3/xYlJ0X7Q11vLhbvSKepRkZ1MzT?=
 =?us-ascii?Q?+UkWCarXsd+EEtLAugosyTrN6qohBzYr0kPvlYnOfVSGrUnSihrMpOANfgy4?=
 =?us-ascii?Q?gkoIk8lFNXfiV543hRj2DYNrC6n13QhuvbE7evu2tJ1fsUnogtIZ2f/snIaO?=
 =?us-ascii?Q?yMg2fim8OvTqrdcj5SA2mV7lEdWQOgAqPjbt2dhi5PqdQRloCayRTfqx3xSM?=
 =?us-ascii?Q?6NKG60uM+b+qPb7+tsxuT1q8+gRxEszzW7ddJP+odeW6CnRy+ku1EPHrg7XH?=
 =?us-ascii?Q?ODaWTtjyG6wmngL4rw34hoAxYTmBiCKI9Q/HOBEKWbJcH6B4kHOlaFGijd5a?=
 =?us-ascii?Q?GEte5xTqWIA5+QRW3O0KC27XS3d5YAk7I3iUC/ipES57v3mxn5bDBJTCmrXG?=
 =?us-ascii?Q?MZjztDCqoMw5w5roglJGAGlTExr0JexWBPHkihxb40AFD1t1bbbSA7GjG0vW?=
 =?us-ascii?Q?6fW3yvF79L2T6pejnLLAaVkGhIdfL3+9rCm5rFc03Pv7teSfH9TVgkdRNAsI?=
 =?us-ascii?Q?SHk7yrcIEOgzAKYnNm6un/jO37nqp+7qp2ctpm4nVGMKe7p5oG3pB3N7GfVe?=
 =?us-ascii?Q?cwgux4biIFMotNv6cDZedykv9AR4Iz0AEYuTZtujaX7NLFnXlzZPAWG0W4tX?=
 =?us-ascii?Q?rpMLHzqqXBqPDM2SkyIyUr8n8FfaZMotP9AhaZseec4+XNJKYn5t/GlldF0i?=
 =?us-ascii?Q?LTyS/3801y1xC93NODP+9RrfGTkBgzb006NlAgsBYpGkMba1DlJQv88ufAJ/?=
 =?us-ascii?Q?VGUtDBRh0n5w/fAsEGjhJtk48aP5XzonGoTdliCYqbzlDeq6sZ3i7GAaS2kQ?=
 =?us-ascii?Q?U7LEy/b9gEhwh0wchsDmq8Os1BO/5DqNDdW5A9l9juFODJo6coVxYP7ncuXL?=
 =?us-ascii?Q?wrTz80EfdjOJ6PPw2Hk1cn9x0QqPGOMjA4Tw+AkuHD4yOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6UVuEA2xTuuGAASeSjSZSxLx4swGx6dsKlcjz/W1X16wh0zRzI8bQe7GWtzw?=
 =?us-ascii?Q?MOOy6wYe4qIwHMk9W//MqdvyTQLa4TLH9mQZX2Yt2T0wav8zEroF+s86p41+?=
 =?us-ascii?Q?x4gqBPRWYvdbJq4t2vrBWyhxDJ2Rzi2kM6ED2JYk++gHBIuEMGhVbBar7X1q?=
 =?us-ascii?Q?LvgwE1m5BwczakSwqSyGeXy+l7In5qHLNERKAqGiDwMLJ0lsuoqDghwuCA56?=
 =?us-ascii?Q?Rl3KHH5q/Z3nXdiZ13lsQa+HtLnYVikgOwTy5ofk3flbfydAjVsv/ZaSG6L1?=
 =?us-ascii?Q?fhW6qnkbfblFAyDgaoZCJhUtnsgKrstKZGUrfUeK8aoYHFtFP73MwGQXYHK3?=
 =?us-ascii?Q?7KzQtflxjL1pnlqEssuvIcyeOMTRmFYd5VZC+uWQYuoUqWT9MFLmDUyXOG2B?=
 =?us-ascii?Q?rxcfGiNN/kntMRdlZIdC5WzwAHmfQX7W6ZGKTCQolugIvMpsv0NKGGty7saE?=
 =?us-ascii?Q?uFxjoSCWZcd0HqKZsgyDn5QmUnOw3pTgibPuNVgsy4+lLuONZ6gxTCCuLHox?=
 =?us-ascii?Q?cjOtCqR8kyGPlQdxI5IiUyMHURLky1Yr4xWUUbisoRzlHUH3YBqEhn+961JF?=
 =?us-ascii?Q?jEeeeBvzlIciwPDJwEfYNLHEYV9JKjeydRL9+qH4e3sWuXqRJTc6Z6RqzVn2?=
 =?us-ascii?Q?crr24HOtzqNB3DMXBSORPSKzSZb4XUt1XZOutSEEW0E27gEqSfK8MOpxgpyJ?=
 =?us-ascii?Q?YMa9qlXRJxjivdpvx1yZ+DpCYBdYiUVHwZ8E5Xp8lTR5HGh3PoPLum1h6OkE?=
 =?us-ascii?Q?hW/WQcIpUENAwZmZkOGkDYYLYaqICOwCsJmnDwaDxvFTazwqH5Z2D6ejNxjd?=
 =?us-ascii?Q?AGVdKxg5SyC3vvgsV2/InPqbvTn+qnUcTob45ymTLLguLJIfCaQiv8u0cqw0?=
 =?us-ascii?Q?R4Jv5M7MqePQMZOMqmHr2ysdV3vKboh03IhbPGrelsPpsfRJE0IHfTJUcxpb?=
 =?us-ascii?Q?5ziZFFplvg7P8smQlvvO3JX3YoQOJV2ytYRW7Dk9U2SeiXjqSUGFB9ZbM4kw?=
 =?us-ascii?Q?rDAtS+b8gFsFBLEo8RaA9LDNt9/5VmckzOvkCPZdyERi3qDU3LDPdpdEt9Xo?=
 =?us-ascii?Q?3ehtljLuHPZ60V+WFJh5z8FEpneqK1+jl8LRgw/9NvTccssfm9tlQf3jd9lQ?=
 =?us-ascii?Q?dso0uPIDC4fKCSvtrcg0hqZOeEeeaRWJ4tSc3j2MyQJyDYrAcaahi/kfylDM?=
 =?us-ascii?Q?V7Xv+Lq2frrGQkEokcvqoM8PDMmIlEJXNezid1Kd5cxxsC0i8yA0G6GSTS51?=
 =?us-ascii?Q?lu79orFc/8N33we3Si7DjzY9EIW1Tbl8cDc7Wl6Wbg402S0Re0Wh/Pl1lbfy?=
 =?us-ascii?Q?Dalzq6Vlti7d3DYCZWATnpWz7DbhNk5Sqkg2rqIs4WWGl/IQgz2WU/1s3Y3y?=
 =?us-ascii?Q?hivP3kcvCMIqpBaqrHZOmJzPCwa7TUeleB/bDij1adAa1sTNU0p67GDYi5T0?=
 =?us-ascii?Q?Dz5BI9XGtxwnMKS0QsJWvvx0XDt5/TV6pipTCvwhF+Lrrfix6bGskq7Z7MvM?=
 =?us-ascii?Q?/1evWFzXs7kZgZHwG4yGzTo6C0l5uhgnhpZjaiOGZs+Jdltn2irWmQE+StUX?=
 =?us-ascii?Q?KD3DlvsZjREt2fpHHtY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf21237-96e4-48f1-002b-08dcedff0ddc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:24:48.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnX0f3oNrCRKVyLyAUKCN8zXoFIF4rxWzwyY1piU7PanuOa83oquPg/bAj4GSsoeWZ5GicXEm8wGXhl24uGr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

On Mon, Aug 26, 2024 at 05:38:33PM -0400, Frank Li wrote:
> Add rev2 dtsi. Although uboot fixup can change compatible string
> fsl,lx2160a-pcie to fsl,ls2088a-pcie since 2019, it is quite confused and
> should correctly reflect hardware status. So add fsl-lx2160a-rev2.dtsi to
> overwrite pcie's compatible string.
>
> Add PCIe EP nodes.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Shawn:

	Do you have chance to check this?

best regards
Frank

>  .../arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi | 170 +++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   2 +-
>  2 files changed, 171 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi
> new file mode 100644
> index 0000000000000..432e54f6f7ae5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2160 REV2
> +//
> +// Copyright 2025 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +&pcie1 {
> +	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
> +	reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +	      0x80 0x00000000 0x0 0x00002000>; /* configuration space */
> +	reg-names = "regs", "config";
> +
> +	ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
> +
> +	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "intr";
> +
> +	/delete-property/ apio-wins;
> +	/delete-property/ ppio-wins;
> +};
> +
> +&pcie2 {
> +	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
> +	reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> +	       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
> +	reg-names = "regs", "config";
> +
> +	ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>;
> +
> +	interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "intr";
> +
> +	/delete-property/ apio-wins;
> +	/delete-property/ ppio-wins;
> +};
> +
> +&pcie3 {
> +	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
> +	reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
> +	       0x90 0x00000000 0x0 0x00002000>; /* configuration space */
> +	reg-names = "regs", "config";
> +
> +	ranges = <0x81000000 0x0 0x00000000 0x90 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>;
> +
> +	interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "intr";
> +
> +	/delete-property/ apio-wins;
> +	/delete-property/ ppio-wins;
> +};
> +
> +
> +&pcie4 {
> +	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
> +	reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
> +	       0x98 0x00000000 0x0 0x00002000>; /* configuration space */
> +	reg-names = "regs", "config";
> +
> +	ranges = <0x81000000 0x0 0x00000000 0x98 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>;
> +
> +	interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "intr";
> +
> +	/delete-property/ apio-wins;
> +	/delete-property/ ppio-wins;
> +};
> +
> +&pcie5 {
> +	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
> +	reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
> +	       0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
> +	reg-names = "regs", "config";
> +
> +	ranges = <0x81000000 0x0 0x00000000 0xa0 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>;
> +
> +	interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "intr";
> +
> +	/delete-property/ apio-wins;
> +	/delete-property/ ppio-wins;
> +};
> +
> +&pcie6 {
> +	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
> +	reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
> +	       0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
> +	reg-names = "regs", "config";
> +
> +	ranges = <0x81000000 0x0 0x00000000 0xa8 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>;
> +
> +	interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "intr";
> +
> +	/delete-property/ apio-wins;
> +	/delete-property/ ppio-wins;
> +};
> +
> +&soc {
> +	pcie_ep1: pcie-ep@3400000 {
> +		compatible = "fsl,lx2160ar2-pcie-ep";
> +		reg = <0x00 0x03400000 0x0 0x00100000
> +		       0x80 0x00000000 0x8 0x00000000>;
> +		reg-names = "regs", "addr_space";
> +		num-ob-windows = <8>;
> +		num-ib-windows = <8>;
> +		status = "disabled";
> +	};
> +
> +	pcie_ep2: pcie-ep@3500000 {
> +		compatible = "fsl,lx2160ar2-pcie-ep";
> +		reg = <0x00 0x03500000 0x0 0x00100000
> +		       0x88 0x00000000 0x8 0x00000000>;
> +		reg-names = "regs", "addr_space";
> +		num-ob-windows = <8>;
> +		num-ib-windows = <8>;
> +		status = "disabled";
> +	};
> +
> +	pcie_ep3: pcie-ep@3600000 {
> +		compatible = "fsl,lx2160ar2-pcie-ep";
> +		reg = <0x00 0x03600000 0x0 0x00100000
> +		       0x90 0x00000000 0x8 0x00000000>;
> +		reg-names = "regs", "addr_space";
> +		num-ob-windows = <256>;
> +		num-ib-windows = <24>;
> +		status = "disabled";
> +	};
> +
> +	pcie_ep4: pcie-ep@3700000 {
> +		compatible = "fsl,lx2160ar2-pcie-ep";
> +		reg = <0x00 0x03700000 0x0 0x00100000
> +		       0x98 0x00000000 0x8 0x00000000>;
> +		reg-names = "regs", "addr_space";
> +		num-ob-windows = <8>;
> +		num-ib-windows = <8>;
> +		status = "disabled";
> +	};
> +
> +
> +	pcie_ep5: pcie-ep@3800000 {
> +		compatible = "fsl,lx2160ar2-pcie-ep";
> +		reg = <0x00 0x03800000 0x0 0x00100000
> +		       0xa0 0x00000000 0x8 0x00000000>;
> +		reg-names = "regs", "addr_space";
> +		num-ob-windows = <256>;
> +		num-ib-windows = <24>;
> +		status = "disabled";
> +	};
> +
> +	pcie_ep6: pcie-ep@3900000 {
> +		compatible = "fsl,lx2160ar2-pcie-ep";
> +		reg = <0x00 0x03900000 0x0 0x00100000
> +		       0xa8 0x00000000 0x8 0x00000000>;
> +		reg-names = "regs", "addr_space";
> +		num-ob-windows = <8>;
> +		num-ib-windows = <8>;
> +		status = "disabled";
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 26c7ca31e22e7..b2dea03e1b8ec 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -613,7 +613,7 @@ cluster2-3-crit {
>  		};
>  	};
>
> -	soc {
> +	soc: soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>
> --
> 2.34.1
>

