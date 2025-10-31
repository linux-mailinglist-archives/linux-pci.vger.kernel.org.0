Return-Path: <linux-pci+bounces-39958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1CC26CAD
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AD13A215F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800F2DA757;
	Fri, 31 Oct 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ItbQxE8a"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28528AAEB;
	Fri, 31 Oct 2025 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939511; cv=fail; b=QUG8df0xDdqHNZdW2tXzBFrZ2BmRPGJz0es72KhNHzQZv7xk/wJmSAwgkRjVwMXTS+Huz6U07C340agCSi/ccoXSL1PCH4LkR/Xhe1KHIR474JimQfEiqVSxlX2bEzipAIguT7DRMwmYdDHF1T6aDw8mKmrD/ehEzdZc6HtvL04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939511; c=relaxed/simple;
	bh=1pLubJqEPIiav+l/sQJRHdfsOmskEKnNS1YdzJzrKuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gawfQOzG0iwa1Vcj35TDWHqvxJ/x+yQfYvUdwoVKV+1xpfNOqvdQQrWYTrgnyGRYzui/WsXI9Bn7D3gA9XdkV0rC5/cFy1bLnOxztN2sHTRXMxO8l1dfnsY1zq0d0oy855JLqj1EtX46kPr6he40lXpfd51qVUmBMTfN5bA4T5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ItbQxE8a; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjkzfyqHGVJSX1/Hpwt6hyVdx2fuTJO+swEtjJH6qTrl50lnsfKjpSuTEoytdQ8z00VY1/rno5q+fXW8xHX1fqcAeTpoJVagwOy2JH+Z8vt5fdVe2U2MoOFX93PSyJ/ynXu116boRAnWKFrFVmZ0z+RnGxLxqyfEC+xCm8Ex3i6XC6sEdhfrQYJZkQ4k8nv6O0ZIEwIie9uhD+CYtQEbSVoJa7BnOaKY4fX2HcwKuLC7AadLiUK+IlmwyiSPrWI4ZQgpOXxcpxQHdbemipXRhooZTdf6pumY+pSI3FT5bB4Wga290mSnca3S+eHnPc/veP3XKNo/wBnE4Qei7wZUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCI2HCzwIlV6zLqwpvaVjMiSUfPI0b9aQPBKdE9sn1g=;
 b=LlmTqVCw7WgS4IIkgRfQHfEykoeQD4QjfNR0paokCT/UNeJUxVVycu8CdPoGAYiMIg0tSOg1aHC/SefkSzSRW5Rr4+74Iib9Wf+2DaNHzTdC5l0vrM1TUVETZy/b1KPrtNOM/KnGyAAuFTqmAm2qEmQN5z7oCT36dMUYzGqpzRbN3tHzRf8eYl52rlg//k4yw45U77HGHmcsDNXCZNRHuP1+173R05Bvn2jpMnGGCeVYhdKSIGeYEf+qv+d+96ehmWtWSq7mf1U6MbqvBVrdyVVgj1pkGNPZ/NoZzmtbgqI4P+4LCnm098a/HvmFD792RDT7iHV1+ol5uUe1zKR74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCI2HCzwIlV6zLqwpvaVjMiSUfPI0b9aQPBKdE9sn1g=;
 b=ItbQxE8a9ENkuQxE33DJPSojR1oR7Xf1yPunPAZGYnRsck2n1+RYRcchLMODwlA23VLYf6Vmi6Zhi6d+xiswXNdZmgX+rQqzFRywjmIrWzxAvJ/N8UGn6PguGBpiN+uBU56QpZ5jMnlug9hYTZXEGFlcTLmpiXFjK4092M6AgM+Jfid+tc0xiXpnGMofngPf4mcNclN0E8PF7LZfhE5qPzYlugA2LAmRgNXknClzg9VKszupZN0cSl0NhuryzeDIjpP/mN0EgUfkiTN0f6RWEiFpn6yS/LB+O9HjeF70k133VacXWFyH3pO2xKeHDcaqnF2Qsn/GxPjQ2my2SytpmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:38:26 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:38:25 +0000
Date: Fri, 31 Oct 2025 15:38:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/11] arm64: dts: imx8mp-evk: Add supports-clkreq
 property to PCIe M.2 port
Message-ID: <aQUQKA9UX/yoKl9Y@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-5-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-5-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR08CA0037.namprd08.prod.outlook.com
 (2603:10b6:a03:117::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 41414519-d5d6-4eb9-2750-08de18b50f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqV4J2Zbe/ZlB0ggN16IZ0NUVvcqMte+yO9ja8czKJvpY/uBgE44XuEiX2ta?=
 =?us-ascii?Q?tGQl27eVpY/76vS1u3II1tM3de74bly2veag+nmuN9b7VvoO0ck/NYqocOHv?=
 =?us-ascii?Q?VTro1r0LPjCs/qlG4VP218NdxLJbeQhvwS2sLMQt/SDlJYRh3dN8qoyiuvJc?=
 =?us-ascii?Q?L44k/PmJsr8+Iwm3n+8T4mm4k6z0jMhJU7M5yW2EeHoEZWfBrFGL5rYbaWOT?=
 =?us-ascii?Q?PMxNx2zlOBBfPYc0Qfb3DvkaUb2tAt7wBa33oNrC4SNYXCLyB5KfkIWGvpof?=
 =?us-ascii?Q?uNzihqeWBAtKliSo+OdGC4Xqeo/elyJHLKekfIsuoWMashf2PoD+4ckspfo+?=
 =?us-ascii?Q?rSmx1l2480JQt3ugy944C6J/Y8N2kA86PA0aFbtE36KAI1UUzc8kGtbPuXeG?=
 =?us-ascii?Q?k2NxhqyKLyDTQyU+0mQ44chSFeBap/Da6fyAwaEfT4bGvqdCM5sW4vNmLldT?=
 =?us-ascii?Q?0P2GrcrGrMBa7cpegPz1wvBzE46TL/eaD/z5HqLbRFud2WFAOP6iH4XMls9G?=
 =?us-ascii?Q?OtUXVnehmSRSbKzfnJREQ14TwGeYfDIEud6WUR4NRDSskWKpTQ76Q+4GUr8Z?=
 =?us-ascii?Q?kfkfO+K/b/Mi+ShwJa7xuIRHIFUu8r0RqF1krd9ep4TMN2Fb8sR6W9ypKeb7?=
 =?us-ascii?Q?cnDTu7+eiTysvpiCrAEf4s8pdT5JyxtcYdeY84iU1EaEoruRa6CXh611Bjfl?=
 =?us-ascii?Q?oXOA5fmwxy9ZWfcovABr8RQLQnl0JeB+CLfkargRLhjIrpymzsYvcCp3bWBu?=
 =?us-ascii?Q?82Q07pFqQgzfJGiGabSVqJXXGvmqcm2NZBIGPdOUYKCsmENC3f2H1o1gkhnn?=
 =?us-ascii?Q?f7EoOT27Llhh594jxzNAb198IhCZohfxs+D0Wbcma1bDzTCfnewgCjFtmLDF?=
 =?us-ascii?Q?oU1LW0LJrRG/sD8LzunoSrsAbXW/Drl9hetPiejMv8tQbtTmGT33pNQFncln?=
 =?us-ascii?Q?RED3A5p9LZhiFtMwecUPzSMqGM6j2rnpUGp8ViLmtVCYMSSuFDUdscRquOq1?=
 =?us-ascii?Q?jvETzkQUPeVTk74Y+9Vq660aHZC5imM77Fh7YkwHVK6ccCbi+13WlHIGROQn?=
 =?us-ascii?Q?BekmQKmT/HQEVtiUWFTRSRV4EXefA1MPTpXfHHbc7/VTHi9Jd7VrjO/LCWno?=
 =?us-ascii?Q?cO4eBtl1Ql1wThfzRueUvqi6RzAwSF3+DenHxz9yfXk5bTlPIXQiznAyftqW?=
 =?us-ascii?Q?YqAOmwZ9FwzvAKsLDmBntlNaJbVLGXU9hfeSBaEpRvU+56xkmLohLZY3IvU9?=
 =?us-ascii?Q?+WbHWU4rsNHWfn10yWDmemq8NrUy+g0HkVE0FGLsfyf6GcTkCIUEm1TeVtx2?=
 =?us-ascii?Q?MG4spkUj5HLQrmTUJOV9v/lTBI8ea/GZDx03MoVWBh5wAA8OTQCkDDHCdmk5?=
 =?us-ascii?Q?pLOCSoVzhwnLoRP8oOLny8x9ye3n6+IZYuyBeTlaDyYIoSAcYrhwIMqK8cdw?=
 =?us-ascii?Q?2IMzCvciXCZ4GBdKjnhqXj7htgKS6aR4cIbmslx3UbuXWfm2rh5sX9qSLJGE?=
 =?us-ascii?Q?+bsorzJ2xFcTkMgs+ry1rSWch6dSODVfkhaL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EhSqxNL7uN3I7Rtc88UPFrTWdnkzmW5Xu8K9R0Kt+Mos3yJ+YzBysc8zvVhN?=
 =?us-ascii?Q?Te6H8ohECK/jAuQcGvrS0+DYsChwskGUArm1zUi41YCGLXaebWXeProt138v?=
 =?us-ascii?Q?Sny+C5FeB4V6lrNGMgP3FKZyh/QeCGseNsuOuGAZpjWS4JtaLL8DutJkvI9j?=
 =?us-ascii?Q?IRkaJ8bddWyYjDbALgwRNv7JHjrlVWdL4Tnc96RKD0IVcpaP7vK/X3lODXJu?=
 =?us-ascii?Q?+blcF51jjvug2/xtsMgPY3SG4GsEGck507lPvvNx7pb3AdxUjmKV5R5UFxic?=
 =?us-ascii?Q?JXYwFHaSC+W8TLA+jIswBRdY9x/94DBCj+9T9d0SrsXDYf1b8UVJqYf0urdD?=
 =?us-ascii?Q?vUKRkaGrJe+C2scXMT5XQ6sPoiFE+NQtkkvmA0YOoLQ88x38z68Le2WGcg+x?=
 =?us-ascii?Q?DmRF57I5NkttQZE7mJdpsAvCarS3DaV5nyQuvth0h8kQ/IxEyRFhjrEWUGAp?=
 =?us-ascii?Q?BKwqaRdZe+0v+cQZXon3T+KCU9i3+hCBGx753DmCsK9Cq0p7iCnyckYdSfSc?=
 =?us-ascii?Q?9aLsnxwLlf2VU2HWc3dBMguFmAEU5qVnZ4X7aXUu+/Uq7Tk3YRzjq5EGhaF6?=
 =?us-ascii?Q?67DcaHESfdvZMA9NjJNifhtLW8gbNTGkDpqvxVrATtuzkJLptA+01WygIh0n?=
 =?us-ascii?Q?/NoJjs6KbOEtjO23RUj1HVYSUVA0BM7KVD1dfIZ1ZTX3XkalXdMqzMxT+f1R?=
 =?us-ascii?Q?Ll86Cuhi/H4BlfHbs1JDdClqmVTSWcWAbQmX+ozMUa9UIhzBQPz9GAValf0l?=
 =?us-ascii?Q?9jbNi7mA0L5W0NGDU0/fMym2iNuPou/Js84g8ZEuNHXhX7FgB7ceW3OOATeq?=
 =?us-ascii?Q?4FXLVgXAsXBcSm8YfbH0upfMICh7FYB8oG1SHGh2MPVnVRXn2EnTwGbYvtUK?=
 =?us-ascii?Q?Jk5EHTSN3BzHuzvb58ihVOq7tkbyVnSGoMS2jeYuIcPwJMN2p8MwLfjzwJxO?=
 =?us-ascii?Q?qC6ZSoOpVpOZG1dMWkWRXIuhg/GZm/1j+OsIoSSgka+02FRqvwssV0n/F365?=
 =?us-ascii?Q?S1WLdcwsT9ugwhCAhPQWfIoN7I6SSCYUhZatpe7iuXwJ+KZCLqj5elKdA+//?=
 =?us-ascii?Q?LNu8hYM529/9wP5oifAsMAWIevBhWcwC7JMt5c2ML2o8VLrLBa/7Y5j0ejO1?=
 =?us-ascii?Q?vHVXA7JWtqNcEPJd9JKQcqHmIlH2mzHjOHjqL6vCpt1Un/4dUv9cO4m/1oCM?=
 =?us-ascii?Q?vPhpwiNt/ZYqyv4SbBzmFskrPoSpWX6oxPB2tcFI1CUIZsyEI/SV00SjW/zh?=
 =?us-ascii?Q?y9gyJXZRnBvFxiC2hNQL72BBRP2EKoia8/m/tX98knQo+So6pFfGQ33hL2iR?=
 =?us-ascii?Q?e+Vv//AK22xWJYMERdxumiQ/YYUu9TXeulPH6JcxTPgsaD2tpjksvHmhfYEU?=
 =?us-ascii?Q?aW9Ru0jApTuSBEv2hA9q8PjXV4oZ4Cc8ecjIeZ/sRoNiaQBO+kiQMAui2o9y?=
 =?us-ascii?Q?JX3nZv6gsSFwOVsZEqAqQYQmoUoXREv9NaycdfywEnjcrlUsj74Gsl2Uh6CK?=
 =?us-ascii?Q?MhcvhSv9y2C5wees6n+tA56oznhrHLhgW+phsiBtRwahp/0qV0VllFjM+QXk?=
 =?us-ascii?Q?4BlmrYey/KAxemZZf6I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41414519-d5d6-4eb9-2750-08de18b50f24
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:38:25.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWMbV2rEF30avUqdV4+LcKbYJRlRr2HyZoQK+A2fQ89heE+85QKITCxxsScYRF1XtnLvjeS2sIZnmm/pl/wXuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468

On Wed, Oct 15, 2025 at 11:04:21AM +0800, Richard Zhu wrote:
> According to PCIe r6.1, sec 5.5.1.
>
> The following rules define how the L1.1 and L1.2 substates are entered:
> Both the Upstream and Downstream Ports must monitor the logical state of
> the CLKREQ# signal.
>
> Typical implement is using open drain, which connect RC's clkreq# to
> EP's clkreq# together and pull up clkreq#.
>
> imx8mp-evk matches this requirement, so add supports-clkreq to allow
> PCIe device enter ASPM L1 Sub-State.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 3730792daf501..523bf4aeff317 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -710,6 +710,7 @@ &pcie0 {
>  	pinctrl-0 = <&pinctrl_pcie0>;
>  	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_pcie0>;
> +	supports-clkreq;
>  	status = "okay";
>  };
>
> --
> 2.37.1
>

