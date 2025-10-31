Return-Path: <linux-pci+bounces-39960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF8C26CE3
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E210F1A23277
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A456F30649A;
	Fri, 31 Oct 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nCEcTPfM"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E42FC006;
	Fri, 31 Oct 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939605; cv=fail; b=XGNj7cXedLuQ1CfRMW+JuMAEPAQN8m5VywY5pbeETUhlLlDPKzFo/NHW164A+kiwhAJsoDYro5iKTrblZ/hbq0Uc8aeffYW/XdnNYjZkS1hgd3T/SRoD8k8+Nq7rGnR3Jj6w+t1WEiBRxLLWiK004xouK2N8A0PFjyZ2xSrSixI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939605; c=relaxed/simple;
	bh=/iBGSsDU4iNNPKkKNRObqCMsq35WDO44VrTfNmVxWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aa2cW2Snn7w7l49SdE6rzTbf9U02V07XJNezqaOI2evkLh1y0ASdYTGxbyf9nohXbwoXWPtjkbg2m05DY8o4/78rd+6qwjStxodVxTtY8CVs/ZGWJcAtIBElVlOVaXbXie9RAWOPouryda+KEzQm5hIAqcHGOcx9JK2NJE3CJpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nCEcTPfM; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwL5UZq04SxNR3agYA6T46zwKUH4mgFExjx2OVRx1zW1iqLpx5QT4bytQi8YKli7pQkRSSa21JYy71LTLnxQDvbQR4Y4iVibd6dQTeZtRmL/0tQX45ShnQAxmcBKyvHFqRuDDmKk/a6Lhsy8NYkNLFCSbDV+xCfFS6MhSSoLVUGwq0lv6zzcz2XRGC6eDTb/E1NrlR7/OKi6ew0StjEV9x7S8k/KxngkWp871tAPkbR1wXN9tp/0zVGMx29kPLMdibxCeETd+ED5HTcd+0bC/6TanVUl+vqLGapdUNChPg75le2RzVTAg9n95M4FNKe7tRanT+PLyxWIYjJJr0oc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE87iCFY08J1KfPhJ1sLuyk13d5k7H2+BbanBPOKKyQ=;
 b=p92CgWzNZKcG+bCmsrLbpcExBF/O47ZdDQQOSCpiwiqKOCvzzomz8TRRb8P/dTK1IqF2uS0Z7tDHIPVoHbMVkTyUrTLXLoB2x5RC1LBmJdJFvozpAu8F5C484LEjyQWcRZTezcFpQLKSGHlOy1y5FmT755j8m4dAtq2frb9OoZAU/ARHt9CFZDa5PrFhm9YHwVtnsQhXYsFothIuQwiYedpZ4kN68oz9mzT/SU/J/iYFnSmz9OOjSep2C4kUR+GereoMPyp3KOz9Q/WBynYYKbU1GMNG94Qco7JzpopjGeTLu5Q6nGG40DOv5AcRZPulM7HnFUPdCoEi9T7cc15ZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE87iCFY08J1KfPhJ1sLuyk13d5k7H2+BbanBPOKKyQ=;
 b=nCEcTPfMOxFY6FmcBJUoM6MedzvZIE2gf1Nsr3hLnpmZ+W5agnslGtNAhGJJNApu6SnTqG5oZ9c4L1DBpcJEfc5jXndKbGWOZioN0QvrDgWq8S246fZqXyNK0U5Ve2ABdHvxE3Gtmu5nR2W8Jr9FUBjQherT4hWpLoXCb3wodIQp1dydKEoGiGEM9WPgrlySP6a57r2w8yNqJ1ZxaYfhtF6jB/cY54XTV2939iFnDp6YI+lIbgEE/ixprIq3JQiv8RYkpVE/4y7YrtvmePkBxs/tVhp7vhWPk5SU8aX5fBUBG8/zwLaRUVgtW8VGyxuA075lAAZgOyRSgnP5OY+H+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:40:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:40:00 +0000
Date: Fri, 31 Oct 2025 15:39:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/11] arm64: dts: imx8qm-mek: Add supports-clkreq
 property to PCIe M.2 port
Message-ID: <aQUQiDdlNTc2iG3u@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-7-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-7-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d84912-e925-4cf6-da85-08de18b547a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BeXqUzzKWpQNSwI0QBVyft/zzW+fEzWQLzMaQ9eaWJJGmztBT5AKihQapNyx?=
 =?us-ascii?Q?bCAfotTc7Yv9Da9LtOuzyIU7qLRPDO97XtFW+UqfczwBn1LHWK+rnkSyWcYK?=
 =?us-ascii?Q?HjSWaIBh1bErK55cthHLJVvpWIgeLEKVCmFOo0ZsaSAN36+hY/IRJhaC+DEr?=
 =?us-ascii?Q?QKDktpYtSdrHrMJBxZlTYIXrJTktiSs2AwoHP/oJ12pGmX2YSdJFcmdOFqLV?=
 =?us-ascii?Q?ietY/25kBtuOr1teZb0HIb/hacRpSjwPy7QicwMMAtb42jP5WS801dnKkuno?=
 =?us-ascii?Q?5U06WqmZ/HA/xIKzlyfV70HUAl0vG5f1UpuFEkaHCDjpRAEiYpLCPCaULAZb?=
 =?us-ascii?Q?gJjBSlo+vRyQj85oV1f8QlP8We/B3KS6SGCeakeW0vxUyGAl9NzoETTK29Vr?=
 =?us-ascii?Q?9PNSGlO60iWHxHHECNWSIIsfoZgsEBcPpqelOhLDGleyFcXy2WdjUE7NGupu?=
 =?us-ascii?Q?ACReBTKBtVm5FT9btONeuYgG5x410bBZoqr4cfA+RN0NQ0qsnBCxYqr1yLdL?=
 =?us-ascii?Q?spxQY5n8mbQqDA0MfFSt8ltZzsZsNwg1jL+7h0oc4IgVN57hAtvGXIbB+/+4?=
 =?us-ascii?Q?Wrvvty6kmM8EYqLnb8IKvQ3KWDaVq1LkUDAQdDVQNvOB1xGJcdxHpdgzK1wA?=
 =?us-ascii?Q?rBEN7KXGoajC6ieoBbf7xP9s1HqnPjg8OleJesRfAuXGL+lT5H4eIqueexSj?=
 =?us-ascii?Q?RzZPbZPXr1Tt7LuSfpXBppaJit3+h4A1pV9qGstpS9Wg1v8Q+bVpILp8ETt5?=
 =?us-ascii?Q?A2olLLp7OnR8uos/ZHqD4PYy5/IKVeBcQJgqm8kOndw/7dj8+6BJ3/dER5WQ?=
 =?us-ascii?Q?sqwcqeX5nf6JC3up5jQk3Cr65g7lD6KdVyV70fWlELrYvWohHfuYxl9AvR0A?=
 =?us-ascii?Q?fKa7/ADBCI1nr3546VeeF4IdE5VwrkeiJf0n2/7ewUowAiE5u9aCtpXid91k?=
 =?us-ascii?Q?jhYv/mfP3shnl8JJvpVNpgu2pR2j+Gm15R5uyrGISUQlhfb8oiVOpDQbow6m?=
 =?us-ascii?Q?I4vyhI/r30Ff8ssmNjT2C5KUMEQOBHmURkgHeL7hWXUxB3J215ouL3GH1nq7?=
 =?us-ascii?Q?8s5DNf9XajJ0t8i1CuwAh8/rTBSLyHjPSWBCA7MhyJB8fTukIES2Z+wMqRdo?=
 =?us-ascii?Q?ZKy/OS/du28c0/RZr9EZ6Z6nu+uNXhAEYFAW1K3/XTg6RuObK+NOdKPFRl3l?=
 =?us-ascii?Q?t/cuQCAG8Iu8zrj1l+fMx2i+LTmZAGOLMsqp4jKWjgFsJ5g77v9UyNyHt/Tp?=
 =?us-ascii?Q?4DZoUi53J5WTJA+kk+hfa3RtQfrlyV9AlvnEOOTPoSwbTf4riBCvQl5BaYyF?=
 =?us-ascii?Q?yVRfwOrJd3LDfmGnOHjaX29Ksc1Vl9bKW4xoSITv8OK0tq69eDYfximwV2pF?=
 =?us-ascii?Q?sv0f8ZMWlfGm1DeZQRnyZpZXyTscEIrxZb5pT/bnrjT4L9hQrnlKmKa2yuP4?=
 =?us-ascii?Q?M+GhR5Sn2qDBdXUVS8aQ/TMhPnGEAxJPdnNb7kVFJ/h8HqsDtpI9gAiuIw6L?=
 =?us-ascii?Q?Dfuavc5ePYs0ut8V7PpP7Rn14X0uwrKFvhji?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HXVYtnDhpOhbMmmjnlSVAfj6yLv9GzD6tyRwoHITHPB34l/Iz/oGyLCzoJiY?=
 =?us-ascii?Q?GX44gR4RlfqCDjGA8aGQR+B82az1m73rk1DMTz8JlIDsJyVF4nmXCDDehqCc?=
 =?us-ascii?Q?icOe2p1dy6dQk3Ye7l32yrRqDC1aDtL++ZMlO1X4Rvi2OPr7Hoc//+XReT8J?=
 =?us-ascii?Q?cZLZTKFTd71THxXrWcETOY9vxPBdXxo4ntkGV/lU6bm8O9XKBt7WWug1P6Fh?=
 =?us-ascii?Q?e/s5NrandSF+RH3VIB2a7bdOFrFqc+Tc++QXQ0bQW9/EoT9spUgf/WipjaC0?=
 =?us-ascii?Q?wlUpxNAoPGZHTdlrWuNbMxL8t1YG9r3E0FxDxMT9+pgtwnvUlrrMp7wMw+x6?=
 =?us-ascii?Q?2lmZbqfWf75fNEAwPcr1sk7EDOrOCVNLW0/wlqiHkG/S+2XF01aX2LBZMMYS?=
 =?us-ascii?Q?L7EthAA7gRmZDSavJLGpeIGrX86uNussIq5ys9W90BPVmE0UvXSf5JSXqAM5?=
 =?us-ascii?Q?3LhG5De+c2fGITtSLEEMpw/rvaf/dXjSN7m2s19Iw41yWOs06LhffeMa+1+l?=
 =?us-ascii?Q?gAAn9hziRtkulbyFRGTDctuui2vKfdyocHJti4Bfo7vsgowZnDFxwHb8J6CS?=
 =?us-ascii?Q?pIwhjw6Dtvl86AEWb3dv7wLS2it0CLhoSRrrPI32sPcPvcUAKGJROMiWgL4S?=
 =?us-ascii?Q?hhc+cTX94+fW0K9UmSW5DJuyD5xsJszYkkGxKrv0tbRKLopFWjGVUvpndEgw?=
 =?us-ascii?Q?Mp9h4Pl0byosITQQypXw7X/hL64lL0+8i1qDuu/LIf8Ar1r0YvnP8QXmw0mK?=
 =?us-ascii?Q?53j4KlTfwnlp8lV+1sK6RSkX/TlHMsAy9zExGm2ya9NVlVF0atv497deZrQj?=
 =?us-ascii?Q?6W/W/Fg9PxHmR8TEKAi/Wzy32LVVEkVk06FZ5YR5IoNMyYwtn4QUrd6DJg/O?=
 =?us-ascii?Q?T0JzmZxbZ3OtSZve9oj+Yyp+whf9y8+417fJEZamga42MCs9fBEYnd0dNs43?=
 =?us-ascii?Q?aqNmexQ07RIFpElEWFsouP0PAnf+byHjUjvMxcrnqv4wTCvL/ghAGKefYbL9?=
 =?us-ascii?Q?4P0pUmJ63xTWDJ4SOdy9NSN5QZR23KIXzLYCFDddLRLKOR5rCzosX+DpnC28?=
 =?us-ascii?Q?NmURnCewXEB6oWlCnDANn0mmLzyqe7Lv4V6DYbXXf95u+oXukN48AqN0Y71L?=
 =?us-ascii?Q?XD0MAgh8AVa/9yHkWH3C/gDM5WUBPsC6EXUXsJfqxrXYGyN4WmnWC90ArVhK?=
 =?us-ascii?Q?8O7WoAUay/rFleSY5H354bEgF7edIwc6HMLH0GZ0TPBlMYqKazS847pE9du9?=
 =?us-ascii?Q?qH2rii0bYCIHdabdSP0tWTmZwv3Q1l2Xd9nwCObyRnJxtvzKBLiHZ9x4iZbh?=
 =?us-ascii?Q?PCvL8PRGGHI/Le+FE3Kn3J1Ejid16I5oIAATzjN2sAzBi2FCqePNS2bOiOmz?=
 =?us-ascii?Q?9G5LbA8RwYVQNUGWmueJ/rYWau2sLkBrJc+njJcLW0wlxYrGp3IjbdqJdGOh?=
 =?us-ascii?Q?0WyvvfsMzlu0EuEIImiu90yKInafCMDHw2BQD/SCh8haHCvvcT1bs6ucj0IS?=
 =?us-ascii?Q?OjQfjk+ncs7CX4cq2zS5JKv3CYpC8ibcX4eqFK/N8EoF6vFaBWqrrYpaj258?=
 =?us-ascii?Q?Y7PC982fTK20IWc+vPQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d84912-e925-4cf6-da85-08de18b547a5
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:40:00.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbYRKstGOSH8Bpgxzs8eDCnVelwH36tLRtvmd3orj0UlPLUYw3mVH1emgH/DNhNd/2rZ9Shn9M+0CjmhJtadxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468

On Wed, Oct 15, 2025 at 11:04:23AM +0800, Richard Zhu wrote:
> According to PCIe r6.1, sec 5.5.1.
>
> The following rules define how the L1.1 and L1.2 substates are entered:
> Both the Upstream and Downstream Ports must monitor the logical state of
> the CLKREQ# signal.
>
> Typical implement is using open drain, which connect RC's clkreq# to
> EP's clkreq# together and pull up clkreq#.
>
> imx8qm-mek matches this requirement, so add supports-clkreq to allow
> PCIe device enter ASPM L1 Sub-State.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

shawn: I posted it as richard at imx8qm dts patches, you can pick this one
with other part together.

>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index 202d5c67ac40b..c1e4775c13849 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -775,6 +775,7 @@ &pciea {
>  	pinctrl-names = "default";
>  	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_pciea>;
> +	supports-clkreq;
>  	status = "okay";
>  };
>
> --
> 2.37.1
>

