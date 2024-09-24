Return-Path: <linux-pci+bounces-13456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290598499B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59061F2114F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F081ABEA5;
	Tue, 24 Sep 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h75f9wlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74781AB6E4;
	Tue, 24 Sep 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195307; cv=fail; b=DeWeeND6u/eXdkGRO9zbua60GG4mixgQwlN6+fBUTmxC++IVXybDnXy2P+Vtlb0k7rsVKD3ZmBG58OaC69iafTO9E92o8U8mY8wPaw8Xw471tPQPZiW52EF6WUbk9potwGl4La3Gqj8/wqP9cxaCqKUdALje4hQtYHYuQKMtxv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195307; c=relaxed/simple;
	bh=FuypOtAwgNRsaaNVrbYgbZUEu8EUmHdlByPj4SR3BQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P7ttOOrwToh8SXrXcy8P4XtKOxDOE9ZBkJd8scdZxxC+4tvZqUTeg25L8xJ0hpJQ3+giPfJbGOWxpG0ur4uut0FxVWNYTohTQGfDkDi6UJxAE9lgK0hTxAOr944aXMohIbfd0LVqSM/eYeCfdcF2dKr+s0RPZ3JJhbWvcZIQhT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h75f9wlY; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXThloQEggcpW9XZfvPjZH3WfXzqeEghzMkhfHT34nUpFfk2Oj01UKTD3yqM4WKP5E1Qt+/bbFcgRLC6Oje9zTIf3v369X7yNgxF7SH6gphVNfXHf0NasI0SlzpDVK1+Gu7rOJ35YcjCAHWL4neSQExcz4f32kUt7nyxgPlqZEN2yhLo76Ca/OIPgFNApz+YSblTBIriTpLPPmgxDzqHoIkqRNlhhQYFqC1wQujiGAl6JzaPo51xCShsMtbSLXDqmwED/aLDlRSxjT3BEl4xa47QrcpsNj4WLm9d7WHSkXKzYrOwlofFkJt0MKCUTEX1B+DKa5D/zMaYBOI+fEgOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd0/mPNhbx0/f6rKdkmNXIWGiS22K2fZTmwm+hzk564=;
 b=dlqkZXI7VKRTaZwSGS3ZA4/a2PpvA79ENfyJc0kr7i9CohFd8VYg6ucchg3b0cEZOLNVuKop7WP7RaPn5A9lRNvKDAL5D4iQQwRbr3WIHp/DoYB6i7kq+HRD8RUVy7bLDWm4JJtPJR7LYuFM368kehrjVDTHE1oERPobjSRQzVwlzXfM3PoUyfrWxl1YnFPMtvNSj9OAIHSh0pKzkDJG3KD/th2pbDWJd8oQeQgQ1qrmMbAlcDgCczGGiUuYb+23uWeNxJmDFH2dmvpR/E8n/rzof+IVURucTA4W+dCSEWt9ZYhGmZhfGRkxpK3Njp67IY0QwXCc8kibTMQSROpcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd0/mPNhbx0/f6rKdkmNXIWGiS22K2fZTmwm+hzk564=;
 b=h75f9wlYnMfw1RmLxbODTixDSf+XrT2Kdg5SCR2KoWwBCItMMdxnXEx+kYRokh1FhWOq7wJNkeAO2PUR6KYkwmdxcCloD10jye8Pc1n59rpe66+JDdVFICrzFPG2hHNY94c1/AVntKGOoVt5ZhP5AL6Bs8sNz/Apup5yeBou1kkwqS60l/b3FDw9Gft7eqoX1FdmWvwS9S3Q4AJmGJo/StJDHJotYhVqH6NSZFpjWRuD6xmcHLBL8FLfwZ5FJzgi68+Zu4vQlTVknGXkNrdicDfegcA8B7cApznf+ip6qMYYpPEZpgNukNUuqCJaKP8m0LjE8894AZK7z8OaNHk8YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10127.eurprd04.prod.outlook.com (2603:10a6:150:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 16:28:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 16:28:18 +0000
Date: Tue, 24 Sep 2024 12:28:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 9/9] arm64: dts: imx95: Add ref clock for i.MX95 PCIe
Message-ID: <ZvLomXcbbiZ+LTP0@lizhi-Precision-Tower-5810>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-10-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727148464-14341-10-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10127:EE_
X-MS-Office365-Filtering-Correlation-Id: de588c66-067b-45d7-6760-08dcdcb5e628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KIP0uFJk4uihv4xQ+ycl0gOtntSNkpiVIl2ncGqK1V9wRj78KqbVT98jmmQU?=
 =?us-ascii?Q?GMVCERmEokZtZQxWuCQlo58HZc0amKdbnhZFuoewC7I1SdZSFUErLYmNqwvA?=
 =?us-ascii?Q?r8nt+B7SAQpYT+jmV0K0xRi5QFJQV7i78Bn8BieTRC6Xp0+XUoUrLLxYJSwW?=
 =?us-ascii?Q?3HjwoIXLA0xBsYuF9+7dQG6uiwWY/JBfMRz3wcPaekntyqgUoTNe/Ibl65NP?=
 =?us-ascii?Q?QZNKx5XOIX9a2hBESRrBHaoM1JqJqIicn1glm5PmpqKEv12vmaBQstf11/JW?=
 =?us-ascii?Q?mlvyCDmHKq05/AlM9C7GB+9FLxiznAxu1axCTFcCcGAWzp5HO0qQTNXGWcAU?=
 =?us-ascii?Q?j/6FWn3YOePny3KskC0UwDCg5gR3eNmHVlNkPkAmMbaEswMSa0jzK9NqnWqT?=
 =?us-ascii?Q?ETOCD7xvCCna7GudajEKsR2pdNyIHhtByT7s4CUrBchu+D+FcJrWhsZwD074?=
 =?us-ascii?Q?JWTpK2Bh3fkrqyrTJLBZrsnUDJW+/spll2xeK7nVA0geZvuku7oEhU5DuszY?=
 =?us-ascii?Q?UKyV6p4P9E5VApVEOm8OqYbLH+RdIT0147PBC2E1CkPcjs1l3ioju8wkQWD6?=
 =?us-ascii?Q?Yis7lZEZZV0HEuA25aLkaw+8T9tHpjb9GzURxjunb+FX2Lq/NzP7oAUdvcB+?=
 =?us-ascii?Q?5iKdAoEljnNjg7Fbs1xyXtZjBQX4IV9+U6yW8ZlDVCcckJBOTsFOtaeLvf5y?=
 =?us-ascii?Q?/kggRuDqM4F331TkfUgCNruz6yfpyEfs07qgxW9zfdjIqGyLobVcw5dW9eHC?=
 =?us-ascii?Q?n6rDQTi6xEa/XNQmX6v9Vkypa749U/RjiS2TdpugaFbSvUtKCKMrxMOTqGTw?=
 =?us-ascii?Q?PX0L2jXMWnk5aU+g1kcKSUqrTY7uWZhAerRLouO+jwaEAqZF42vAS6+yVfNP?=
 =?us-ascii?Q?q9Rw4O11zZ2jllAi9kTvQyoy2UaVMpqLtD3fdFRubtWACD5ysb2tQ5w/kFhK?=
 =?us-ascii?Q?jUrNJloLoN+iNyD63ZGF8qKSqdYDCTxlloqVv8TDxdIdgDTU5KXY3nLXwqM4?=
 =?us-ascii?Q?MvELnmq0qtAMIOc3vwJhjF47HmD4KYGC7Yb7WCs285uG0X536KoWHIIfVrA4?=
 =?us-ascii?Q?Y1Nli7DeddVNdDZr8A2iOt0T5pQGeTHDYsmUsjsUJwh+qllSJbxO2bIT4m8n?=
 =?us-ascii?Q?s+t7kjiMeSwdAcWrVr/Z7g8zsXipAY1LBuKtQJwAuJqwEXyt/7Ch1QeVocdA?=
 =?us-ascii?Q?32bCbffYCKp1A6+3gghbasv30q41V4QPEOTBp20qY55bwaDDmxVDxfGazRl/?=
 =?us-ascii?Q?sdQdgcAlK8GjbdX++JKOINvn18wQiVdxwart4aNowuKKAypZeh4fduOqTPut?=
 =?us-ascii?Q?mJ52gVDpdgVqxH8tioIovSzDA+goGOTd773zKslVKXq+Qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRo8uzm7NdQdIWr4a6Mg9GxjqWciKWIoR//vJlpUt7tHZj6sLdGlDC4tl1kY?=
 =?us-ascii?Q?YHKGl/qTBJPVrF/UpvA8K1KPX4IuEpgLp8Rue8Op8ei3p914GHNT5fqImD92?=
 =?us-ascii?Q?emVAHdyObrQth/O+ycCi9Xksjo1xJEA3xnUHEFpKfE7YOUghypAfOcM5lotV?=
 =?us-ascii?Q?cc3g0GsDUexUBGXd0aa9kmIgk11Qkl0n41mxuEwJul+GcmqzOhKTWj7ZoIBS?=
 =?us-ascii?Q?nv1sHPJMoTT3jK6OeZDsgifdWVfH3IkvM8Th8nC9nXf93sMzOWdjp65ZdI5U?=
 =?us-ascii?Q?r9Hznjz1RXcOqyIEwXoxxlceTpdGtE6phizlg8CX6OH5dNSZaVk2lcy6vaOr?=
 =?us-ascii?Q?pqSViW+LZV8BHe5/H/nEHSwJx1LIG5evk1ISIo80Zqf8nrkM+kr/yUqhCbIv?=
 =?us-ascii?Q?gnxtrlBvVORHBQRY0kElXLfi50IUEs+ce9CSJoiUD++d+ATRZTTD92dRMHX4?=
 =?us-ascii?Q?QeooZicfX5LX5aNj3x6VQyn9YhuyZtIchDVzu0rdmUEkYNcX1iGiRBvqbOl1?=
 =?us-ascii?Q?ZZXj+y/lddtIXH8fZGw0lP4IHcZSD6JLJNlSuWVTCGULDeLK6mxyUfa1NLi0?=
 =?us-ascii?Q?e2j0F3Qb1cpEukQ1LM/fRnNAJ8SwhTfcWUYHmAM4cgz2kzayY9jMMGVi/Dwe?=
 =?us-ascii?Q?M2AwSJJHrTAmyjXAD6MzDofJzgMnylCQNv6WGAqTynBvfPDSzEMFEYJYtGRd?=
 =?us-ascii?Q?DDfnG0v6zU6KhF/3OwIcmmXT1fPuUOUFkt9bSsp2Cai+anIqS3bGhQ+1gI14?=
 =?us-ascii?Q?tFsARTaeaxJqx+4GBVX2QWNMmad6ZJA0Ds3MeqzCEYLNT/RlijQ9uvPMjxKf?=
 =?us-ascii?Q?EoF++hxRxd6IBjdA7JvPc9BOIwTh+fXvKphqKeIIC/f5hZL+k5lQNn4QZkDV?=
 =?us-ascii?Q?3Eo5Bgd1rLZW5MgIkRizBjrC1v5oeWhu6K7CVpOi9c/tKAQuWZ3CW2nczzf1?=
 =?us-ascii?Q?B0OsEdgjQmWx+D0X4RY2wM/dvKkd4UYW2HrYt4lX8eMzpA28pWqwIAUnEZTP?=
 =?us-ascii?Q?VzuduBhX5XcQOOUTm/Kg3u93rh8rT1RF9czfUIrTALAf6d4PVpvdHq8Y9Uui?=
 =?us-ascii?Q?+52Cg7/1FloTj4bXzGQ/uXgNjdKQ9ayQXmp6yuN3SE0x08+jb0ZLimcV2Lho?=
 =?us-ascii?Q?N/2t6K71jvR8R8t5ni8SQ2RKqPwtyErFpwknS5IZtWwFIZ82/TNP/7T4xKwx?=
 =?us-ascii?Q?lF2N6XS+5juzi9AzRA3t6mBZdAZ2oBRYJxMxn8+dX4VZ6OKI7r35Z3BE3BPh?=
 =?us-ascii?Q?8vOtjddQrHWZGwWDVLEZNE6TC50tYFGtWwi57kOE8iFwttVZ7iEC1bjP8W6C?=
 =?us-ascii?Q?rn6yHTob3x5tEehOa268gRwjaFR1cLuROCfxhf+8R2jf3IrVOBKlqAhQyBa6?=
 =?us-ascii?Q?g3qS2PWwyoylV14LF6tAeLLBuWNH89uwb0BDd9S5XOBmJbUx8ZmeO0jXwJn4?=
 =?us-ascii?Q?QzxzWspR1r3T3Dxd9SoUWDFYXbBiP5SCMh0gjR644qiw07AEuwwLrXMoM5J1?=
 =?us-ascii?Q?A5qDrpVUFcRCDO/yGMfVjEKlS0cPF3+CgzBXOaxvdKpvr79qTXXrgppCoNOl?=
 =?us-ascii?Q?pXqDPT47q6Vd2kBgghY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de588c66-067b-45d7-6760-08dcdcb5e628
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 16:28:18.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dna1L9sfr2PldBuDq4lDVq2AlcnVBF59FaUeBCKrZjnKdYpVuyG9wgUKexh0KbdEWXIxk5OFYKNb1hsihwksEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10127

On Tue, Sep 24, 2024 at 11:27:44AM +0800, Richard Zhu wrote:
> Add ref clock for i.MX95 PCIe.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

below nit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 25 ++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 1bbf9a0468f6..e66be264c2f2 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -221,6 +221,13 @@ core5 {
>  		};
>  	};
>
> +	clk_dummy: clock-dummy {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +		clock-output-names = "clk_dummy";
> +	};
> +
>  	clk_ext1: clock-ext1 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> @@ -1055,6 +1062,14 @@ smmu: iommu@490d0000 {
>  			};
>  		};
>
> +		hsio_blk_ctl: syscon@4c0100c0 {
> +			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
> +			reg = <0x0 0x4c0100c0 0x0 0x4>;
> +			#clock-cells = <1>;
> +			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> +			clocks = <&clk_dummy>;

nit: move clocks above power-domains


> +		};
> +
>  		pcie0: pcie@4c300000 {
>  			compatible = "fsl,imx95-pcie";
>  			reg = <0 0x4c300000 0 0x10000>,
> @@ -1082,8 +1097,9 @@ pcie0: pcie@4c300000 {
>  			clocks = <&scmi_clk IMX95_CLK_HSIO>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> +				 <&hsio_blk_ctl 0>;
> +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
>  			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>  					 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> @@ -1149,8 +1165,9 @@ pcie1: pcie@4c380000 {
>  			clocks = <&scmi_clk IMX95_CLK_HSIO>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> +				 <&hsio_blk_ctl 0>;
> +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
>  			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>  					 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> --
> 2.37.1
>

