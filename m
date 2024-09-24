Return-Path: <linux-pci+bounces-13454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A9984987
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED96B2818D1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E41AAE2A;
	Tue, 24 Sep 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N5kdgKtr"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2E2745B;
	Tue, 24 Sep 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195097; cv=fail; b=GmDWQdpATumvk1n6ysiNXF1Y/UHGDzJoImRORSFYIyWTOe65ICWf1gfSmH7mYAU5tCBbs6CHGvX+RTUoZV20+PYudClCxBk4TpSpL7n8nvDCx52Dot3Vfv+COQ/GkYHAliCzjpzF+w7+/gfhcXyFeNR2BuZsp8qkfTd5gPhj+vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195097; c=relaxed/simple;
	bh=YuIeSqcUNYPEguMRndDt1ub0v86C3aHjwMjFWMcTksw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eOHJBczn5YZNj13f+XXiqOedY0+jEDjFPdqKX34SHy1/rPr4ug8DJoXoxxgGwkdqO90sxcAcptyzHZ321eOpk0BjUJqbOUoLTm5mMjEh8CqKqevbZubpQ/LDZCmk517li+rhI8mDl2PtNl3sJNvr4wRK6Kch2LEr05zoUworeCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N5kdgKtr; arc=fail smtp.client-ip=52.101.70.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrR/awx5rUNcjFVsDOcLG93ORX5YPBztHRpAax0yLgXdh9N5me1e8drQekUiSiHrB0i8lUfFRd/RnTxsA2xaOHThj/ZsOnCe9I+BAQfCcpvcYgH18k1Q3ti9a1lgOnAHQcODs9yKSKWGl2lILqyZrM6zK4hE2FWaDjvBVdTLvWihb/IjpFNLQS8a0kqKDMuGO2qtH2s2xz4G7+QifFPRF+IgKFlGDZ85bruNrXOym30mK/LDK0F50IO8KmAabjH928LEntLn5616THmkXUNQS5+w0DRYPa2UzyUIWr+QiC0pBuMmclgfqn4Gt7gjLoDMKmYNLUnshT6erXwVDsdQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrqIj6xjqqRrxNurxnX1S9qsqOBtIdvUmJDHca3JlH0=;
 b=JYOAFhsXM/Dnexw5QaP0GPCY/hqsf8/11D8pbLrhlV6rg0chuHVC7lmg1N5kYptj3gC1lfsBgH6TOJE+UJoqIGDgepg7aHIANt+PdlfkZgE8Pi/HNUoNRtV+NDbCvkfmFJAt/qq7fP1jRPa40Eb5kWZpy50qoWCtvEgDQdi3ZBds4QsvuNDIToFYFSrOaeGlhSn7H+7KLbOY1sRunig9tNnWYt3r12LUk7EmEy2RPyP/ULi/eTj+HdZtrXvobt2iFOf17r1x6j5XxxgtjRKFl9ju7UOIZBFOj6f4BQR72sKKIZekeFHn2wzargY95ApUQQ80kDD/nMexMdv4T0G4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrqIj6xjqqRrxNurxnX1S9qsqOBtIdvUmJDHca3JlH0=;
 b=N5kdgKtrJsyV7Fpj512xzmTBmhJSql5Z6vOkHzojv4URcvcVibPBSAnEM8+WMNyB5TYm+4miuNmQeUSDgYYOLCLahkWwDr6PqyXZrNb2140P+x4snFR9Et/yxNvUjYv8ouYtO9JzY7rv8ysDE2eMqyDRiR+vxZSQNGuM5/v1VRG/OXtc4Z7w0woszq4HJwX0yu2g5VbBJSvkBDms7+odDXNn0dQo1VCsJm8jAbIpcuq2W/K2POQbb2HGgMs6q4l9wqRdKk5E7natTRRIyBsW2G0WlPL1b+Z5t3wg13eEYid7IkWkW795OuGGkIZU1uJvqm9vuB39jrF8BjUdgbWz2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10127.eurprd04.prod.outlook.com (2603:10a6:150:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 16:24:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 16:24:48 +0000
Date: Tue, 24 Sep 2024 12:24:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 6/9] PCI: imx6: Make *_enable_ref_clk() function
 symmetric
Message-ID: <ZvLnx4LsFxf8+9mO@lizhi-Precision-Tower-5810>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-7-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727148464-14341-7-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10127:EE_
X-MS-Office365-Filtering-Correlation-Id: fd752df0-aaf6-4af4-b832-08dcdcb568bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AyjpQJtuyyDTz4xAI42SRha3BePcGgrLrFNeeemTHWE90KLOwayn8w8uNtK3?=
 =?us-ascii?Q?bdDj5NQWQ3s+4iUJt2vbfjPGo5vE4MuaWVh7svYSgvBwxrMSyr7BiDCjP1FR?=
 =?us-ascii?Q?IM5z6i8a2cQOfV7gX6KpLEGP7ac7Ayf0jHoVeDyN7F1hVnJxYRV9wZVTi1m9?=
 =?us-ascii?Q?VeRgSGvq0GSJlANoiuDlty4USTQk7KgFKQdvOVxlnfS/LnYjgK4r+KFYyaVv?=
 =?us-ascii?Q?MtFaWdMOtkCPKbahEU+vS/wYvf3i/Q2dveO2Z/2KNRq8+hhYW+Zwj76GXeKm?=
 =?us-ascii?Q?d01RFKjOSA//Im0p4H4ERZYafTqlUWj7gLNMXjodFhlkjv/3a0Ps8+bpYnvd?=
 =?us-ascii?Q?x+oD1zwWYvcx9p7LpTE05kvncB5xvuINgWsRMHd5zm76m1XaN70Z67r4VZc4?=
 =?us-ascii?Q?Z0B4mT84DPBSUxkztBReeQv2Yyu+SwqVBuTk8tZTTAE3T83KFVdtjo2AzOEP?=
 =?us-ascii?Q?EdjBkT7g8wqstlX7wgQL+rI9+ON8/Z9FBNpcaA5VueXHgSE0JWHy/nN1+8K2?=
 =?us-ascii?Q?W4uEQP6gAeIMDAt2+qeDaNrqp4DLGk3qpV4g5KcGvpWfGFlAoBZaaf5FbivQ?=
 =?us-ascii?Q?GcLmCjmTp0MLBXCsG7qdEc5k0GiHE2eLIpuIiEbvv5sikKekgEfJU0Daj/+a?=
 =?us-ascii?Q?46MB1AALG1a5JIU5I6e8evzKNU8wxiYcewHJrdpEJLRTCefBCrBBbDz/KsB4?=
 =?us-ascii?Q?+vf8ctzGHwpehCUC9i1c483i/5CJLvSXcB0gQKZ5sb/5ujlGfbXvKhTUQNr4?=
 =?us-ascii?Q?OVOeVy9LZrdS0BOYMla7VOHqmz1V23jcQgg22lVoY6xofmzLtzksljOF381B?=
 =?us-ascii?Q?4vtIlJAsmH7ZWJzzG/woS7sg89T8X+UD3TBts0LxCas2QQa+3FDfLeYSx5Dm?=
 =?us-ascii?Q?TTBd7aBOt3OFnsT8I1vTnSN4mpxL5iVjfS/XnS9qTjfLXfVe4IlwLV9+Z18v?=
 =?us-ascii?Q?I7EoKHWRM8491EaA/lgJoJinF9PDKfZxWFqqexA0UDvndUmfdbLLWAEMpxmU?=
 =?us-ascii?Q?khPbfgDdvslfQ91qDov3tM2zp3cwIeYzhKbvlJtE+oEimSvIBr2GKGOzPq5n?=
 =?us-ascii?Q?HOyFuEAnqPjpPYu1Uh1iMkVfzNlMBDHQ2GsQrY91Told1UxaDsKjdSoj+f3L?=
 =?us-ascii?Q?ugKSCXGuzTQIjW5hOai5xSqM7lNA1f+4KH2LEgFGCo1r/j3G3DzSSqvuRAMl?=
 =?us-ascii?Q?6fyAgrsZQtAF6l1/zdqeNbcv9jP6ODxLp7jx8Mab9wOEH8/jNa/Gu4eSTINB?=
 =?us-ascii?Q?5EG+xniJKQy9Uzmmm/17wAeXkqixyIg9xRqbpoYlzAGS1DkEX2XOEY0oaoDO?=
 =?us-ascii?Q?D917Jpulz+o9MuCBv/C3V3rxrYuA2Xij6QzH9B0EIFNO1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tNgM4KSsyKaPWo+LbXEYyOJDR8KjJSWtdA9LqhAPArUqI4YH6v+u2c2L1SzU?=
 =?us-ascii?Q?CwTE12zQj5FhWbUDJR0lumyWfuLtCkzuGrv8wxfVBOZEbXm3JUgDrmFQjsDV?=
 =?us-ascii?Q?kqh/9n0TqqrmVwosm2uKgyX2aduRFodnJ7eDOBJc3XmBoOgjoEvAEFeJ8XiV?=
 =?us-ascii?Q?IE3NMNanXYkvL7c7zQUFdRqVeSyP9RzHMoPtHmDik4hxPVMKxmMfh0jRHTz2?=
 =?us-ascii?Q?jiROBXzlHpo39JUkPSEtL5lX/AJGougIJlJIKY/rp1brVQsb+0F3uCh4tMJl?=
 =?us-ascii?Q?YLZq0zdI8mT0bSSqnvQjllSWEypjk4/2FsF4WmyI9QcPnMI3PKZenaa1T8M6?=
 =?us-ascii?Q?IIqhRmvO/TxQJGdm+KgOKJP4JnCREtIRRVWpRIxk4bS+DNy8Wt9854PJmfKy?=
 =?us-ascii?Q?MPoV5pAdarpqzc0mSGoZBlkQVI64oS2eE5qsIem4n0m47UD2epwcduR6d1+s?=
 =?us-ascii?Q?VZYAlToY/9H3wtmJQEeq495TzT7pQKTwA0KWrVdl6flzb8YGOqQaLV3WIzVB?=
 =?us-ascii?Q?eVKaZ4/PsA4eKaJOJwZ6F4VimjELqTDJgxTC++medkG8nnDIE/SGJhXD5mlt?=
 =?us-ascii?Q?E8sxkAf8Ia7uclvbZrIaxQ607TWYo9hnHjy5a7fvMeodRQL4mt1BpFdpaFQX?=
 =?us-ascii?Q?9IGGV40nGus75bjA3lTHGFxCk2l0J4qUKGZ3WOCj2TYOaBf7sJRyrTETKD0P?=
 =?us-ascii?Q?g6BH76MHcg0vuPW+KIcx2zMLZsjF4BR7xmQdtzq3Gjl+SairaEsVds8BwTsU?=
 =?us-ascii?Q?psnfiXWEqjpmMRH7kzkVFq6qHehR+Rkb0nMR40NpoHvFlW8vk5bafiy6Kdb3?=
 =?us-ascii?Q?BqKb8BD5qznpeX+7NYB+3+7vVkgcom9iGvc8RQHeoKYstRkCWhVFTxjf+IRa?=
 =?us-ascii?Q?+xkiGMYjCg6x2ZxLl7ICv6f3tvkDb5EqI8AQFUfu+D543Y2ss8XH07nwBSUb?=
 =?us-ascii?Q?Qwi+52vBH+DOIaHQNDx+1XA6U7F3rKMUrNRBcsQ91KIuKm0Da8veit7r83Pl?=
 =?us-ascii?Q?/z6qUc1Th4jy4ney1FvVHD1aQBDVocNaysnSFYDxC9w1oZkImEGCoPBPPLzZ?=
 =?us-ascii?Q?bokkW+nh3iN4eVAPo3P48BSOn9C08EyzBG/EKTxC1BJ0HBTWFC+3+NnE+cvN?=
 =?us-ascii?Q?96OhkNstJsgMvI4kc1Of/0dVtVP7lXxxvNkBufaZhI47JBLYgC8Cp7XfBiUn?=
 =?us-ascii?Q?TdIz2ZMcHo0i5tkaS6YE7bOTwcms1O9tTnqzE+mIQixE6jb5vmL8IW/F8ybJ?=
 =?us-ascii?Q?JS2Slaq1bVEeMwVwZwz+MIUc7qPGVMzItXXEpWUHGIuKFa6enAM+Z2Uju3Zu?=
 =?us-ascii?Q?x9SPfAXf2MtsrIYk3Ew/SRDT88lWOkyi2Z8Qj1IxL4qkuWt0B8zm8GVk3v/m?=
 =?us-ascii?Q?qn6G2kP73vnOJjgfE0xPVLEZNZz42QbkugIN8NOqI31e+tMGMRsG50Gdu9qE?=
 =?us-ascii?Q?cK7vR/thYUfd3Ye5w1tHwbaLX8B6/ngof7USsE+wMlsJkVAphXdwTxC/BYwP?=
 =?us-ascii?Q?hqvfncWklkHW/PcjhOUj+PX/ktkMeVXvElgNVhMLNTHjuAQ2apEiu185rRHb?=
 =?us-ascii?Q?rzKJv1pvEp4wY9clEHg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd752df0-aaf6-4af4-b832-08dcdcb568bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 16:24:48.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7kGe0ONJn8RgQEfoPpiQkE0ulL6QIJwCagwAn5YtJHAtPqlo1/k223nm/4ZO2pXo9A0E+fBFxazR4R3fDW9yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10127

On Tue, Sep 24, 2024 at 11:27:41AM +0800, Richard Zhu wrote:
> Ensure the *_enable_ref_clk() function is symmetric by addressing missing
> disable parts on some platforms. Also, remove the duplicate
> imx7d_pcie_init_phy() function as it is the same as
> imx7d_pcie_enable_ref_clk().
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 33 +++++++++++----------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index f306f2e9dcce..5ec43d9f9784 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -388,13 +388,6 @@ static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>
> -static int imx7d_pcie_init_phy(struct imx_pcie *imx_pcie)
> -{
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> -
> -	return 0;
> -}
> -
>  static int imx_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -593,13 +586,13 @@ static int imx_pcie_attach_pd(struct device *dev)
>
>  static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (enable)
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> -
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
>  	return 0;
>  }
>
> +
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
>  	if (enable) {
> @@ -625,19 +618,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
>  	int offset = imx_pcie_grp_offset(imx_pcie);
>
> -	if (enable) {
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> -	}
> -
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> +			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> +			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> +			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> +			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
>  	return 0;
>  }
>
>  static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (!enable)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>  	return 0;
>  }
>
> @@ -1522,7 +1516,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx6q_clks),
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> -		.init_phy = imx7d_pcie_init_phy,
>  		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
>  		.core_reset = imx7d_pcie_core_reset,
>  	},
> --
> 2.37.1
>

