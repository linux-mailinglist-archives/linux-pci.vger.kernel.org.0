Return-Path: <linux-pci+bounces-22355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD9CA445A5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AB916FC6D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 16:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10018DB19;
	Tue, 25 Feb 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TK9tw3rA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264FB18DB13;
	Tue, 25 Feb 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500035; cv=fail; b=sAdXF3wBG4Y4SduFaluy5sQJK1KGqnIJIeBqXvxPDPISaM2CLzfQFDbnNwdq4hBSPrCeg1k8NTrES0NOOhXoR+1tXFwgQPqUJZlkNyfspwHgf/QqaOkdOsat8/tAwZRt0JYNnlFy9AP8tCrUimiSUehxlOC1BUWj1vkK8YLQSKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500035; c=relaxed/simple;
	bh=eHAyrA/X8jozx2Qe7nX/e3+YrjdDXS3mAibcuIcriCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TZdYLBfImXYraqurKD6gLHZn+0oc7EdQAGjPhTDoM1J49J5OWd7A/VHG4aq/su1OynSDXyJ/8oqxiRwqynf/6airWpidew/1FWZan4qKkPXnQwt/RwxZe5vHENJN57zNFR4xOUZKyxYucjnlQRIBqubyhtOE/PRMYhMC5zt4xS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TK9tw3rA; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVb13WCNSGQQU2Rf+gF3Wbn2fZtPyZLOOt8hXsX/mouDlmlXHXt4H02Q4TNpy3CoxDQkYJjiRXgodt8IBRAmPFkFZSQ0YV4+4HcVY+76TKKKX32BasT2eoSNbtSeOeI1Q+GjGyq9T6y5xk1mXWJoP+7r98BMsU3OPVwHIEQPBV0O2OKjlEwAqGJPflU7I/ILeugmt71Sq3TC/JaMr/ptqMSIFswCgXi99iXDdzAEoqlEpZtxDYy3JnfQ7JibeZyZOxl4Se05KO9jbabv8/8fzebgjPvwfP6OOfzMxW6sySPUqRHWwHdqPi3aZUoHNpt1PMp9ttWA6+2kFg/yhJmiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0gAz+sSIBtgbY3+Rxahq4DLSthKJqF3cK65CUbHR+0=;
 b=ezy5aISCn6VfCOx77aELTXyDFU+HSbkEVJrBOhCsvf+1tSfra4FNxzx+vcmCju6a0KMS+Ny/xH70O0zcnaDO1Tg2Njdos9IumdM7ugY2jdSlDy8SX06QkMt4/bNFisSOuBLOD+qC/CN/GTDmUFJCMtl+kRQ5yqs9W1RuXWBrCaIdU25EKipY6RU3Q4i2DfwtnYqRmhfwgSTZjaU4KpOZb1mt5ecgqRYpyX3YAjJ4ZQBLSqUfgwcdDOa/fCPEu14SbslT3pif1fCmviyeZziYUov+euBSr5Ix7q2YYvcD/F2oPkFOc5grMz+1mCyJpnOn0IMe/66M6ZCaxQUHq+EzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0gAz+sSIBtgbY3+Rxahq4DLSthKJqF3cK65CUbHR+0=;
 b=TK9tw3rAGPf1yulE7v5pV92nNJnPEkYJR/5AFIJaoXG7lyWUN9oilMNUxMNGkmIO58z/eIhN//Zq9fc0mLMUE+BaNrEmUNCJiPaBeonT/lDKUfgvqieZZRAlelKw94FyazO89k+AOqBCh4FnnGiWBfWYF73revKRqPWOAgulQ1xXGzmb5mv/fCgzH50E76dJwZ5G/C9P/ia9uRKkFOAzzJZXR5DHiuwzjnjISli5VxMy7SWYrM0urUeohD1MHyjcj3MXUvF9/+sRTb6znmpolDA7y0joHjnAMfRWx+1PpWx70C3iQEfV20MWI72QAIDZwCp9ObzkzYusll+UQnatsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 25 Feb
 2025 16:13:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:13:49 +0000
Date: Tue, 25 Feb 2025 11:13:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH 3/3] arm64: dts: mba8xx: Remove invalid propert
Message-ID: <Z73sMjMqYBIXZo/B@lizhi-Precision-Tower-5810>
References: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
 <20250225102726.654070-4-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225102726.654070-4-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad6f7ac-cff4-4968-d3ac-08dd55b762db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SHQ76vjhuwDyn/aQMM8SVpPWp604Aeel1Kvd6c8YoXU0wenYts4RFu3w6V7g?=
 =?us-ascii?Q?V+sRJnlbvstd0bG+xIvYfwgjyoxjmYI14JgKF9/U5vccIDAGCbSAT10k9vsl?=
 =?us-ascii?Q?8qVO1Dfl21ODz7oqYsPv/bCse2ZxyJX+yJIBRXFdoLsKfxm4oi4XyhLveeEr?=
 =?us-ascii?Q?3XcXWqhZpkyRuz2ryqr6cp0BT8J8HYgPSr42KXCJQm1g4sdKmKK9Y6BCkbI3?=
 =?us-ascii?Q?JhTcs91EvmokpWLvI9h0edYekGjXFBuM1pQ8xtleOsIlj9iXWOW/JBhpB7Cf?=
 =?us-ascii?Q?RhV+VH8u9OF9KiCZrPIH4ywdXMVxSD5OnG/5azx5uXB89sb+pDlVUhNO5w1V?=
 =?us-ascii?Q?HRLxx/HEYbkc9M6R+wLHHi3s4FH2eBJJR2GHU20+cROqeGdzvsVAIQtyiK5R?=
 =?us-ascii?Q?qmW4YqKtEV+2e8RzakAsnJZzrrY9QXLfA2Z9OHcTtnCpUB91pL/9VZlOb6CJ?=
 =?us-ascii?Q?5F2ILUMNPXDu56qyrtxu6ZqhL+VYCT7nYnF2GVvaHucuLnCwkEIaE0Lh+wyp?=
 =?us-ascii?Q?cdigQGbKykeb/4bv1/qqiloxNeNRFQeg6hlHmTzi3cUTX/HnB0RGjQXxtFAx?=
 =?us-ascii?Q?6Atpx5ZkMUB3HlCSqXaIRPjF7ZO52JXStRuQ3ykoNBSOoXykUiLqeQmGrdrE?=
 =?us-ascii?Q?6qxel5PDvMzB+fF8bg1Hccx256gpb76FUfX2SnSmN3er3Bw/Pa7Biz4dzH2q?=
 =?us-ascii?Q?TF7PhkUvFAMrMv0YaB+NedQSn5cfWyjX0Ugh+dA2e7pESTVxItUrdqI1zcqt?=
 =?us-ascii?Q?UOg1EBs1o4ELsUpLMkUReGmUVrSXA6ZCyr6UcWXnwNeF3kLnhLdfXl2hMz+6?=
 =?us-ascii?Q?eYHHqTLPRm9sW8hWD07g/hJ9vqiCFFH4IJ8CvfM0I6dRqLlu+/JzqKDHzI1s?=
 =?us-ascii?Q?H/aykTDQB63ZRRhpoDtc2+jW5HNyZN2GU5YZioZo9mBFqVFPfeakyj4Utc1/?=
 =?us-ascii?Q?RYY6/bHxwyRcs9nu7I0EKrDjRCdZ6AOX6c5oZXIdMiI5txslAoaqAkxBXiTq?=
 =?us-ascii?Q?4H5VP9Ss7+WImJlBmBkdF92eOFiJfT4ZXGWTWWmb4UJDnuHiIPKoXCS5OI/5?=
 =?us-ascii?Q?lvOy5TFCMf5RvHnki+a8SLTm0qYuE9uuuP6OinkGSI4BsaiaOQoCDyF6Y0Aq?=
 =?us-ascii?Q?jkTtYyXhXfETF/Ruvmm1MARH3YasXv8K31Gh167Khum+lavTZZwOt7onOOY4?=
 =?us-ascii?Q?hT1qNsfXC8j/Qu3HXHu9spbjN3c0tr01vimSV5Eyp0eW2U16cJQbKakn5rUB?=
 =?us-ascii?Q?1Zc1UWggfmRxPlMw4QoA+9DKe/wSMavydtNNBulGHp0iEByk391bMfFQ+sc5?=
 =?us-ascii?Q?UvJ++8UfJisiyISw4V1tEggXcb/uwooEcWbmkoYphLTuC993OV1UO6ewKkL5?=
 =?us-ascii?Q?16EFPQ6WQn3QhNZ1XF4s0daQMeCWz0v0qtSl2A1WOcuJVamsSfDPRdKj7wfz?=
 =?us-ascii?Q?mbmYQOLojLqomGfSpqBdSGQqCzOjYiK5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?32j+eg2d3ZqY8qCahVt0Qfi8GajahheFNip3c6E0e1h2ZDTIFjHfxWPXH500?=
 =?us-ascii?Q?wK0Yj7Pcu3S+TR5mqlh5Uw2VnQLfBlYEzdz5IMkGoLgbxGyx0EYWy5jaPszO?=
 =?us-ascii?Q?FqqX4X8Exr1PfRQfOmosK2GDWx8078u4FcgTNE7Z3bl224MG+zQ7CrIFp3zS?=
 =?us-ascii?Q?L09O1l7OxE3MsVxaxAEgkDIHye0WUxyHxggmaJmSBptzGF1IWIAnyCxaFzdQ?=
 =?us-ascii?Q?acdOhc/wAqkAhvBxUm9Jv/3p2R/ZetutD+kREb9KkrCi+QqeJpe2FMWG35Vj?=
 =?us-ascii?Q?x3xXPZxX0jMQo6gIcY1wa/RW2L3mddvysWMjgOmoGBxGPz/jAeH379pvOGtL?=
 =?us-ascii?Q?KRgvSDVuJdYuQIXLNtC2ulGkdXi1BIxpQjvYm4szxbIg0ikv4VmNEoZg+1Dj?=
 =?us-ascii?Q?snGMWK+hsYzeBEC6yNEyfvduQGgyIWuDNdKd/ejY+a3xrzOJW2Vc2rgKC5Xn?=
 =?us-ascii?Q?mThq33CZ+QDiItePKdSYnpSDJe+KCpBt4Y8NoQcznDr0iGbFaKxahTZsl7Oy?=
 =?us-ascii?Q?lzMBJ737f61nFx3rd+xY9xAkD8iZgHkB6lt5fTN8PQCtW2+MKuGW8fM4nnkE?=
 =?us-ascii?Q?xTjUj1ZFXZrfvRgRT/5zNOQ0X1Pikdrhw8s0arkfJFSAMIdCx94r1uiobiI0?=
 =?us-ascii?Q?yQ0XgEn4vgZRxuLMzi/QuV2Y0q/hNC+6r8eoehDroJVgG0wtoTMZVvEjzIbB?=
 =?us-ascii?Q?+6sjcAUUNYSgwvB/Lz0oJtK81Ne3EqhyefjGzBovxRX2O/GKMNGZyrDX+DH4?=
 =?us-ascii?Q?aLtlMl3f7Zu5twxiwtNFZd156s/odctatHpFIH1GoMQtHCEbrAykfJUMyzqW?=
 =?us-ascii?Q?SwCh9q5QF+t/teIalg43AKkvTH3feLNtEWmVZuy8ywH1SqH+L/iCrpWN6s/H?=
 =?us-ascii?Q?sutYCTNO9vSXgrwPQb5EF5OLkgjxgf1mWdnf+0snpX4dnLf+WBEyxNl1Bhi/?=
 =?us-ascii?Q?AC0I+HsedT1n3REOmGtn1/+QL2s/dcUucYWHZ0N1QzluPvjou06P9jhVIedo?=
 =?us-ascii?Q?G6p/+4DX4lSoCp+nt1MW0ppOl0p8JnuoB/I59RevI6WbnG0orAgYCavWpaBf?=
 =?us-ascii?Q?9hbanI/3rGlySq/Tb//Xr8klGEeveeayYvuf0fczvyo1zsytiPpRIE+yr+TC?=
 =?us-ascii?Q?6TyKR5zTIUsXCsT+Mlqvy8srDPpu0INAq7NfuUdTTStGTZNu809SeZOeR3je?=
 =?us-ascii?Q?2UzokRVtolU5uMRCppkw8pBXRf6+JkFa8dwj4ioaGVggAdrWAyRGbn7Gw5rT?=
 =?us-ascii?Q?Bsfz7sf0TexlXxwVhJqpBV5bNcU9+ybbhR8HIa1ZWItJR9Z/Kkeha9nK5FMb?=
 =?us-ascii?Q?/izwB2fieRxHlYTWyY7lm1c2+K2UKWlbSQBG6vczOl+CLSkGgaua38zcq+tS?=
 =?us-ascii?Q?VpL1lQw19Ro+0cpOitgWyF54TYpvY93RZE4WZ6Jcu5GtsRB3W9RU9TIX645N?=
 =?us-ascii?Q?VJheFJnWHimJHiCMtlbtIDigUYk1WryIy8VMI5U6c7FGSYeVzmRayzc/B03/?=
 =?us-ascii?Q?L2NrSshVjlmlAiu1ufkgFHsaH6SN5/dNsynUmIdAMeub5Exzo+z6zuQjhQBP?=
 =?us-ascii?Q?qd3EIPxb/b3nv4uM889dhdWpzXUHvYXaTTeb3e1M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad6f7ac-cff4-4968-d3ac-08dd55b762db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:13:48.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwrsOQ7EsTZIYxTBNOg5kq4wk7tu6Ad2P7lEzQT9fbyhoSvktjHhGUYqABKSvkpemdLsRwTVOEpIHq1UZeDemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

On Tue, Feb 25, 2025 at 11:27:23AM +0100, Alexander Stein wrote:
> disable-gpio is an (old) downstream kernel property, which slipped into
> DT. Remove it.
>
> Fixes: c01a26b8897a ("arm64: dts: mba8xx: Add PCIe support")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/mba8xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> index 117f657283191..c4b5663949ade 100644
> --- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> @@ -328,7 +328,6 @@ &pcieb {
>  	pinctrl-0 = <&pinctrl_pcieb>;
>  	pinctrl-names = "default";
>  	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
> -	disable-gpio = <&expander 7 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_pcie_1v5>;
>  	status = "okay";
>  };
> --
> 2.43.0
>

