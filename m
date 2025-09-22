Return-Path: <linux-pci+bounces-36682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A2B91CC8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33E12A23D9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72A226B96A;
	Mon, 22 Sep 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zz1iBvrn"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF29126C05;
	Mon, 22 Sep 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552663; cv=fail; b=j2gDp12sTWEoeCe5IXznJqysQq4H5/gDKu/SEefsek7y8/XrIpQaUsm2tJl6prSyuKCDsEQHXSmMLa82jBA/5MuEMNYkv7mwB+/Q1lsLYyU+nCju8RRDEQsSlk9mNuvPNZURVwO7WK5q49z5eSseEDRdMD5ecqZ6uhaXxbuVL+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552663; c=relaxed/simple;
	bh=paMIcDu/xO3Zyvleo8sovblpo0YtLCJ/CVirlbRkQ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CWb/8Wy3AbJTzR1xKYZh3HS37WtKqiNAjwxR01jQ+KpewHxvc9f0Wi4jX2LpdCImD4II7P4El/U6BVLfJiyfgFhvqJxL9bokVDqXXbC5IcOcmS2fy0DP1xXr+jxaL8gV31IMwS+wkSO2MhLZJSfzJdc3LMsk8gIQEFWSf3R4VeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zz1iBvrn; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxS1tJ+8wN73cK/t4/zlwrpTRKu3NzuQ361ynNnGk0DEALNZq+exrKT2A/2Gccql00OrPA71by1kibGBLjES6cQvx9K4vtTYyetsYeYlS1fbAP+RxB3vsgdwj9UQ97jgNyWL8O0MAavn2BWViRDLHcXCzzRyllnNk8oNBG/eM3G7UKkjNUDaeo5jB9kJ7dOzGj/Xjs+UvGq+i9qVopJyQw0NOE7Bn3sQRmiPZp1MsWNNkxzcTgcn0wrY6k4PACRz5mcqpQT1astsesqVrcizB07fLEe1ewIktIZdHQGh+/gzgJD5Q3DcWzM+nzV3Ek5SedYOv54/DktGOKzbB2tdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HstABPzJSDBeUXMSWj/NudlL2olMpA3lTBm0WGCjDC4=;
 b=F1k3PuT9qVgJ5TpKW4rR4cXXTCpZRwJJUM/C9YMo68Aij3H9F07mqgxSu/KjNDz7hLULYxzkfe7yzWJj/p10qdk27mhbwCB+scllO9zKEuQp96fWyTdrSjW+yAjDhwFMOIUdPzcwf51cq04G9qdYziZONkN++2H8ovxRitv++isL6Ua7T0fDovMsrEZevb4PYlwBTkbCEYqaiZiC+JdEag0OOjIAO8Vn1JmFD3tDYpX+N5zMXBKB9MTyLXUjoRnQBIL4IlrpZ3ZVHaFoeL+oiDQi08d48VP3nTPKnb1GrZ+my+eSGsQtyc1tsBhEM8GMkElGXEekS2heM9LJZZruhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HstABPzJSDBeUXMSWj/NudlL2olMpA3lTBm0WGCjDC4=;
 b=Zz1iBvrnE5k8Wqg3IHZUO31RvHVsdAfc7kUegdLGIeaNlvNNv5dsMYs+V985nnzLjtfdawtExS39MJ4lJY++olSy6J4NZbgewXa96LXoJredt4iWXpCJzYRH0MIvzLC/3JMAyKrS73S4clKm804xk9tQSbWtsI08ETgp338cNNsY1sk5LN//OCTN3emuPu2wKYRAGHKYrBQ8HdUmEtdcI6vbuj09Hou03dJ9e3rApiA8Dt1fO5ArpOgSpg7DJX7LecslXStidtND2cO52UGy+6HlPDCek88DV4OweJAF15gpD6XmQ70ou+n6gMnkLlOB09KBlk6tK5n5GE5oWynHRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7896.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 14:50:58 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 14:50:58 +0000
Date: Mon, 22 Sep 2025 10:50:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] PCI: imx6: Rename imx8mm_pcie_enable_ref_clk() as
 imx8mm_pcie_clkreq_override()
Message-ID: <aNFiRny143V0YaAl@lizhi-Precision-Tower-5810>
References: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
 <20250922082433.1090066-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922082433.1090066-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 396c3054-c27a-4087-077a-08ddf9e770f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S64NnXb7j75YllCZ8HbOBFSUrT/9aTA1IjX7y1QTenq56dQd29IPYYHiQOUK?=
 =?us-ascii?Q?oBhSoAW1WtwK9Nf8bm1Qffvt2w1PiPv3Ov+EcSTTb3EcbTONjR0NxNz6b7Hd?=
 =?us-ascii?Q?gQSPcyfzEpnsl/ovOvYmwGp5adKGq0vTQmukGKrLvlHKF1BxF/SMoDoaoMGt?=
 =?us-ascii?Q?+Gl4Q2HaMmqdFoapmQCg4TiyohOJe5gmyd6aEzoX1kcfW0xW6acUJp1hIbNa?=
 =?us-ascii?Q?lZlZSwUpGeb7betbb1u2hMqdJBIBSXoUxSXBkMwwzR3KHdCWLSKGR0pNtBYf?=
 =?us-ascii?Q?9qIIdmyvPUU3s1av2HZE0j0S17XftOD0Zws4v+BrNZKRbqVTF+7RIQATMnTD?=
 =?us-ascii?Q?E2tFcH26lj0s/rgiAQiAU6O++tKh4F52axHRz+YkygnjZDv1NJWJOHVPhM7m?=
 =?us-ascii?Q?DTG9knIsoIUil6DkQvkN6KUpA8KksYHY7ZgJ/zRU5ZxKf9JcXIUh9MDw+d++?=
 =?us-ascii?Q?Ut8BwIWUa4srxlHzE9YJ/RlfNF3edYWqWAVrIRJXQNY9zZ/c93wfCQ2NJ+xM?=
 =?us-ascii?Q?CkLCDBA6O4iublzb6tAyNIdkfwxwjyhXC8wqR955H/VvXGxw828i/7mjIHZc?=
 =?us-ascii?Q?oVbDE4bSvJ/UoSK8XPDc7QDC+eHfFZ5DXBkH4++2/ruNY+W1raQWiHJ1EwJ1?=
 =?us-ascii?Q?u81YUhRwAXvDBrrToYMl/hQERmKLoZ+iNrEKxnFDPf3FK1Oz8GtDGjaCuU71?=
 =?us-ascii?Q?fmjAyvb6rcHY3RtZqbBRdEC/KYuf5zllPlmjPPcGcBASglZu62Wv8hVCgccW?=
 =?us-ascii?Q?ko/QVFz06B2SEzJNc3eC9bj1AejAiStPod74s251QN3PqV6uC67zdeAvB5uU?=
 =?us-ascii?Q?SXnIY0n/PNepBcLQwm/8AZ2YB0tQhRAx04qVLNmz39mCuSfJxSuXeX3IWOB8?=
 =?us-ascii?Q?y7QfCHVrXTz9823rQJ/pmfyaC4dKu3KY2aHTPp0z1UljXhjoRfHJ3jfp+g58?=
 =?us-ascii?Q?Aad3mt6BV50H8cqCk7spz55csfg4+oEcyzz4IhjkatST9hSMZ5I1eyXUqq4/?=
 =?us-ascii?Q?6Lo+hIVxo9in6qT3ffF41nUwUNq5y5X/8fnMfWQtIa1lBpwY5o0cz5xb4K+M?=
 =?us-ascii?Q?E3ZtgpdbrwqEfQ5XyEz5Vydqe6+mNM0kY0jNlsqDC4iAanbYSXNV5DZcRZQi?=
 =?us-ascii?Q?e4sBDETk1Ut0NBqpluq+LhThHRg7q182D0ozRBgeA0MU43gB99qtfv0V+n0e?=
 =?us-ascii?Q?uaRYSH1e7cAROaTUe7Z0XvRikTzaw8wCKKzOqqyKf8EZto2fYF+I2+0MGC/q?=
 =?us-ascii?Q?Vx6/xfpmqh1nyBHvh6mXUUzaPbar/KGSl7KSfyukBRVp3BQDEbjW2Gcx5O+C?=
 =?us-ascii?Q?N0Fv6SpS07t+t/M7YCSKAEgvYtjXs2Wpa3QmlIzM1+T1KbcJ2k7YL4A41azI?=
 =?us-ascii?Q?MD6l35I1wJ5TKoiwtizCWOi9MCEXmznEznDdpkjyVP8A4Btff1jZQ9mmhMIu?=
 =?us-ascii?Q?KSjfw29c1OrCGAmulaytFSDSJX6kPdhZ+doy4k1DMmqkrUAPTC2jzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T6nqLt4Tq9FO0XA+QsUSP54dM4zGyThda5FTB4eMfxsXnrm258KDU2CO7XLl?=
 =?us-ascii?Q?Ja3lrl763BsXus1SBXNzNfV2y8rFefYP7xag1Bjh+g4AEXcKSZWjq5rcF3sK?=
 =?us-ascii?Q?uITLfEaOfWMhnwqxCUXwqiKqBSIFhyS6G9D/l4Br0REuzqTZlTrBRB3OVBCY?=
 =?us-ascii?Q?QA8nhdtM3o645LLC+wFa4wB0alvaGLIYJfKZ+AXp+TGEVPgEyp2yvsQtGKno?=
 =?us-ascii?Q?ZWYT3y6/d70VxJChoDZGdyAVwDIFaXLK3chpEOFysODjamquDQ8jnhFVPB7M?=
 =?us-ascii?Q?K/FHdcGWx00NL7p8oupQ5cGRCkh2dTaSXeK9rFQJlOMsO5dLFNYbVobHULsr?=
 =?us-ascii?Q?etHcCPHYn3STITMniGmZbXtYszS+GNpUN+4z/MxB/nsSaUIyf7ya0c3ihr/P?=
 =?us-ascii?Q?Z/Rkr2x8yPK31qqH37Llf4A4Vknj1yTUB1Hfdp8erQ1aExxKpdkbLb6DbaCY?=
 =?us-ascii?Q?loBxwqv9R62EKirhIDuJwBG0avp+Uk60cOzl00Xtwr8O8n0ysvw9+S94gWaC?=
 =?us-ascii?Q?Wxx9j177ERCtOSfkXC48ntTTAy5vx7BR/9SFD9Yx8lCDypkLQt8OsVj2FP+/?=
 =?us-ascii?Q?hx9Tb1XaAVGnY8JtRoEcwPovkS87hn3Pvc/CozNCUOyyRUMPluZzaUKU9026?=
 =?us-ascii?Q?Qkt6/ZK2kkIC02AI3Iia4lXjv/xnhm4igKBU3ei+PS5dpFC28wdKqu6TEK2x?=
 =?us-ascii?Q?RA1S9TL4PVVTaIKMSdAmKtfmin8hE1Wo975be/dzEfFa/pueS3eScxXy+UkB?=
 =?us-ascii?Q?5k5HwWF2cGjhUC6Qz8/w9gatUOaRL8eB4Gs8u13L8R+R3brPrtbBVIhxCKKR?=
 =?us-ascii?Q?3Uta5NwKh5JTZWEJJ9HuoDA7NV++mQo93yL85VRfTqPIOA8e8MKBHSRGrSrU?=
 =?us-ascii?Q?FeCcMS7DVrC5HcvRpOhbruqk1tTwpJ2HBIqCTXw86Ro7lCKo75hz0RZtxluI?=
 =?us-ascii?Q?6rvt9mjY8S1ECa1sySEBTiUCNnPSAqB58bev9metLaxMKAMY5DZd2xAVEuho?=
 =?us-ascii?Q?2aiIiD9OnPa26IAiSKqVHFEz6q4aVTTE21kRVCLbQDSbOY/Aen/G83FhvDVA?=
 =?us-ascii?Q?Pq5e8UPPYKTsF2Ce/z6P+ESHT8pLuXusbzY0uTgdfCQcKM0kpbYyIpkb/h5e?=
 =?us-ascii?Q?tiuapbrboOPMKYADuIw+6UbAurVaIA9ZgaviLpLwjW5V+JZdFuQJR4uaf7R/?=
 =?us-ascii?Q?wirlF+dp544ACCxgPgaRGI+OIVFf5hEQDWbC0SvZ8QT5M/kCdScZorGONrz/?=
 =?us-ascii?Q?Xib83tFCsTfg9MyFt2ZF0bW5GLCTfWS5Q+F3/K+SsxBFxL8wlLib5dpl1Ura?=
 =?us-ascii?Q?FKBSYD7XjT1EUmXhw83kKaTurS45MmUKmQpD8+rv7zFenlrcJ2C9dOFd094D?=
 =?us-ascii?Q?fIx6dYHINvVeY8Jw3kF2BF0WT5xdT8xbV9eDkXySc7msz+Mwz0aOhBZk4nft?=
 =?us-ascii?Q?IyeJmNrMSeuBXb6DkomGGHlMMXYyRm73U+UmI0EkssFl+OQaOeBLx9/1dUG5?=
 =?us-ascii?Q?TpNLHiSdaHxQEnKV8QBe8FZas5XPLbHn4tTfUkqCzDxcIBJpy3DTmTbAt3Tw?=
 =?us-ascii?Q?bxOOUumqaZAWC/XRC2FH7F7/fnVrMV7JgGkFq+7n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396c3054-c27a-4087-077a-08ddf9e770f8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 14:50:58.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8ms/+JaA+Mf42YQ43B4Ebnd+t8eE55AeUIM0FjgnyyjDBWS92DRQ/Me7iKI/i0jvSneoKfmDqOwKT63d8ckcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7896

On Mon, Sep 22, 2025 at 04:24:32PM +0800, Richard Zhu wrote:
> To align the function name when add the CLKREQ# override clear function
> later. Rename imx8mm_pcie_enable_ref_clk() as
> imx8mm_pcie_clkreq_override(). No function changes.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf..41f971693697 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -685,7 +685,7 @@ static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  	return 0;
>  }
>
> -static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +static int imx8mm_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
>  {
>  	int offset = imx_pcie_grp_offset(imx_pcie);
>
> @@ -1872,7 +1872,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[1] = IOMUXC_GPR12,
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.init_phy = imx8mq_pcie_init_phy,
> -		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.enable_ref_clk = imx8mm_pcie_clkreq_override,

I remember bjorn like callback impliment function name should include
callback name, here is "enable_ref_clk" to grep easily later.

Frank

>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1882,7 +1882,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> -		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.enable_ref_clk = imx8mm_pcie_clkreq_override,
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> @@ -1892,7 +1892,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> -		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.enable_ref_clk = imx8mm_pcie_clkreq_override,
>  	},
>  	[IMX8Q] = {
>  		.variant = IMX8Q,
> @@ -1926,7 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.epc_features = &imx8q_pcie_epc_features,
>  		.init_phy = imx8mq_pcie_init_phy,
> -		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.enable_ref_clk = imx8mm_pcie_clkreq_override,
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> @@ -1937,7 +1937,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
> -		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.enable_ref_clk = imx8mm_pcie_clkreq_override,
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> @@ -1948,7 +1948,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
> -		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.enable_ref_clk = imx8mm_pcie_clkreq_override,
>  	},
>  	[IMX8Q_EP] = {
>  		.variant = IMX8Q_EP,
> --
> 2.37.1
>

