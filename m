Return-Path: <linux-pci+bounces-24770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAEA7194A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A706189C8DB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351CD1F4E41;
	Wed, 26 Mar 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i6s9FL3M"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E81F4717;
	Wed, 26 Mar 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000155; cv=fail; b=MuxM8kXZynUaBozkHT67p1AnYYuKQGYBjA91A4AiTqSk1MK9Q/xMoXJ8G8d/Q3VZpmwUMtH+kgbuIJC8PddWYjjaXsfhEV1NyrhgtQ+zChf8GwqKShirkI34RQhzhXPumdCeQu58X3z+ce/R5H6DKzd23Sp7lWJCOaTeURxEGhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000155; c=relaxed/simple;
	bh=8qXHIPxD01HLTQvkjuT2h8qaZ1h0MJUx7OkIQS8oLJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=myPkBrEjh/y3TO1hPS1NbXdM4EUyt0EPfD/iuRGO2+nXCwuFN5gHp+sm9SvYknRYbMJj2DxOr7ngvtqZG8d7i0QIifGB4MygXOWlKp/hLCQJaLsCIS4LmbznbdfI9Cz5nBtV7ls3ijBXaENMz4n17TgtzpzhR8RvcHCmznO4fWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i6s9FL3M; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bln8zahea3S/t1ax4VpXWbxJoDGKL3y9o+4h8JklEtf+eZjos/1WPWuTUaBRSFMriFx2TT7JVdES7S9Du1n6wS8XOUwoFzACu+q2+4/AmCwB5RcKCf3eyt1GZMoosPfZOjGd6YQXc9UpvmlpmsLUuZs9GY2RT5v5yF+XiAtKZLk0GOkG8o2rZ5nIDCN9m9WzIc++Q4Zt9sLw0J1HPb75sNKciyaY05R2XJHWcEYiJSZKSqSR2lkm5/oXS/40ZOuuWTWeffBAFKK1hKqMyxWm+aPTXUk8DYSVN9x1gCzDfjyqvupd5Lw97P7Ur63ZP36jdfhRyUdPZfrzgQT/JyQUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mRb9PuZVQ0f1EmxNlnR9V97fyjZSK7TBvnWMESH4ZY=;
 b=mjo3NVrCHt8KdJhTGfuxY39aUecWK2Zh8QLn7+/9LWJt6ADyiwzqPq8FCTz2m2u8nD6o1Xll7RXw9hT/VmEqN2okxYY/W2Scx1D8dfd74PNQGjZOJwiJvsl1qgOYTdmayTG1eC3RgU30ss7UiBny9vVIAvta+kxXCJ/kKBeJhSFiqrJi9cTD9U/LcYjI4CuQXpA7HbahEl7Diguvlr1wjrtxI7ua5+7QnTpVGko2Dyqs1F955eoap78UIAg+tuOdiRgQbEZRyUTMLJC1++E7A+m9Ujz2izvhEh7L/Yxr/D+6DJjOWoG6o9JAmpDxu2Kqow9XqS4qD8d0l+XO3iOMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mRb9PuZVQ0f1EmxNlnR9V97fyjZSK7TBvnWMESH4ZY=;
 b=i6s9FL3M/cdFAcOWfcYfV9ANbSL5p/GyUT8NhK+7qn1lTOYcTAaIRoGvgLc8glPKM7qlRzVeRWCnU9uiP1FsUVINNz/Zrog22ZcpbFGylK4yJRzaJ1Fhp9nkeulITS4byYicNzRCddNEOYwceG5mbIINmP6GYvw7BtEHnocNVDjDJiblYH6+qx/juPjtZzrwadf3g5yWq0vc708Ou0TB3ZgFFO9Lq2SgD/1pP2+BBDa3CuszWtXgEhU//9c7mHo10o84Xmt58YWRxYF38t2TpTVOcybNf8rdbdq0BvbY46EIHcrxYf4KA9L6yTKI5WXpiAld5e7Lz9JEH/yJ2FUeDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:42:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 14:42:30 +0000
Date: Wed, 26 Mar 2025 10:42:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Message-ID: <Z+QSTkC8c5J93R5P@lizhi-Precision-Tower-5810>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
 <20250326075915.4073725-6-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326075915.4073725-6-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbbc6dd-0d4d-447a-d4bf-08dd6c746fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WBvG/ZCXqRrgPhaRRTjUjt32z94c/PJToV09NxUU0+eZbqvjGsj8/b5a+lUG?=
 =?us-ascii?Q?iMAbk99ijFDWFLykisZaxIsYZgAHCd4wQ7MTGhKe1nv3RoW2RP0GxQ9iv9ur?=
 =?us-ascii?Q?aNdE5995otHlPIDdyIkmbl2DYlrEghrT6ENf3CqRV2bxxDDJg4vBXOF/bMG7?=
 =?us-ascii?Q?b7liq89opgvyO0sEfisbRBxhcRlaAHKoRn1BJqLlwW+LNjS0XHC1S6ncwRpK?=
 =?us-ascii?Q?Xcme9J7glVbcXkN76pL4c3sNWM5fHMu/tH1X1hIk2+qctRFFl3Xlcz1wvBgU?=
 =?us-ascii?Q?Rs3MIFBCwNLghouw0UXobsFttLH3zIO2oSVhXtew7zGsI1ddYt8yXG2En92U?=
 =?us-ascii?Q?57h/PrV1J/hKbMLGezohFyKF64cuvSrtk8itW2kd7/Ckp8tiuAYSffUoyc+b?=
 =?us-ascii?Q?Zj+47S6VM2qCTR7gC4IZWqV4UVCK+fGEgO3tqfRo6lfg9KIpso355qNDRrtI?=
 =?us-ascii?Q?2fKK4JK8jyWsqvA6RVkrJqW38aOZ5/rVZzK9NGo9og3VNiPRfnGrTh/XejQF?=
 =?us-ascii?Q?3VK2IP2urwTRZIIAgYKrW9BRy8jU/jTnUYoDXmBfPPbbDdk6CcyFmr/HAAPg?=
 =?us-ascii?Q?7RKSkTrkw5dXVJXUTy4bxZZNCx2/395XWYCnAwo7ZeK4pQ7kikAVILQ6HLDF?=
 =?us-ascii?Q?2d286Dk1hmOG/OT2ojNvUlUwgXcKZ4yA0bixLJ1l+hNc//TUAh7w0EOkIZfI?=
 =?us-ascii?Q?wXbN7Y1uRLCF8rb7kqSxNT99c1w5OXToHNpwoUYmxG4+lGPl3W06wkYGVegM?=
 =?us-ascii?Q?SMFanVcEILa7+gLU4nppvWNVfWs0Of5uTBKunhW1FEESKgmeJRSuf/0Vy4MS?=
 =?us-ascii?Q?4a8yO0bDX1AYHIpuNCmD8wxIuZDYQ1Xg5RTtKkKkIeXakhx4jGIeZKNP38z9?=
 =?us-ascii?Q?/zEa9HYo7Zjk6qfHlsAyvMDtbti3Fwi308EPhxx+MAwmpW7dRnF47UzKdw9Q?=
 =?us-ascii?Q?bEqZjmSnfRvsuz+or0nZLE4u5b6y031ulKDIG9XLNcEo6hVVx6PAMbDTSvgx?=
 =?us-ascii?Q?EQFKJCnM29qM9Eb/Jw4mUlnRx0vViGK5Vq531XIJrURRa2JWcrtUyfpt/qnG?=
 =?us-ascii?Q?Sf4JeyAEgc9T90TBYUnXoxv0sM1vsot//ThEydpOIg+yjEcitf4W60vuOZTy?=
 =?us-ascii?Q?UFxpC/tAOJvsi7Za5xa/lLSxtiYAQaaluUZL/hUwViULi8Mp72jTutZ2REeN?=
 =?us-ascii?Q?mzng42jB5+6RHtx2iPubWs5eUD0z+kSESABGsFIUYWevb30mb0RDXbWwE4BE?=
 =?us-ascii?Q?w1YgFQWMbQQAg3Hpubg58QJdh5Mpt47nAAt3RwZ8VrgyPtdw4mkwBanNlrjm?=
 =?us-ascii?Q?ZgHLzIAF/YDqGK0a1RavQzgr+4JkcwA9PEHsHyUpyBpV+FNR/+D2ir2Du286?=
 =?us-ascii?Q?DG537X3vuYXnVESl3VWeaLHaFRN6X+haj/qfJ/7YhIiONNUH3jKWFuiY4wIC?=
 =?us-ascii?Q?RYrXfCK7oLe2ws79KZpa+ikuvtqVN/39oHoUKbWs20ednJHWy5jDvlnAWwE9?=
 =?us-ascii?Q?I7aHC9LvYAoxq0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dteJ8x9h1iiUp3XDlVnQEDrzj0+Ci4n0h/giVgYtrQh/bSyS8zaQX7E42b1a?=
 =?us-ascii?Q?nBlz3L1ACi3hutD++3LHwgWHgrXTgb7Jlsm0AloUkS1Wsjs6mO2aXAjQs6Cg?=
 =?us-ascii?Q?oqu0JnHpa8bSFjZCei/BUNVHDgKBn2x9fpMqu+uJ5IMDfzbUOJrfSUrsfnUo?=
 =?us-ascii?Q?uoYwWi/MrCVH9ZAej2xSYYkelrCh3zyWK0TCl8QVSBew35FzqmqGSPHhUbEF?=
 =?us-ascii?Q?YMXnxpIz8TJGP7FPAFVdNWSG+eoeYtN2d00y40QcZOq5SMFb8j13t3CZpAqT?=
 =?us-ascii?Q?34JOyFTBhI/4zuSzyxtSqRs1UxCPn+XnGhsKU1rSKWyDwEpeN8R1GvoZL5Ob?=
 =?us-ascii?Q?lsfctwaQPwaadEbwoUbNNZoVOJqpQ2Ppthijk77Tv5aVBTBxpwLRO6wJHYGN?=
 =?us-ascii?Q?gE1JFbW2nojHlm6MlRkEOGD5BOAqFoNWsnXW7QDf51ilM+SOXtzWhs9tU6YJ?=
 =?us-ascii?Q?hSQpkK8ArJ1qLHf4aAbGq12CWUppA+9dVzp1CfO+eMKVRwjvjOLE4HhM46Pr?=
 =?us-ascii?Q?J3V6DfSyKgOoq+u/iwVL94hjRZZy/PEuArDYQqrZyQKNU6WdK/U2E6tL5Smt?=
 =?us-ascii?Q?1yot1+f4BIZK075frv5Yobkkjtpmkx42uCBbW9CCTzI77ZXyGueuKjAK7FO6?=
 =?us-ascii?Q?2QXr49PbbFfNQ83QuX+gr92CKNAB8JH8n2rkX6rl3Bz6sIP1Mg+2njls1IXc?=
 =?us-ascii?Q?P3cSy790PSQ6Z2luofC3lBFhBxNdwKFUFdWIC13n6aM6yGb4slwNthJeRmJ2?=
 =?us-ascii?Q?pz3F0U99YmDsjWwJL+/GxvbDbrQBqWx/n/+DqmrXVzChYkkUevuEKMOZIZtT?=
 =?us-ascii?Q?E2wlhCxjBo7rKunK4azfK5keB1ehfiworIHvyc6CMZ7271Mc1BUwEEEmjKiD?=
 =?us-ascii?Q?nYbOPhI6DQHyDFgQDQnaMagMML14YwJWyx93dk9aT1ESlMidIrFriyhcB8nr?=
 =?us-ascii?Q?J4XS5J8EFKPVNQbVjaKIPISd7ZE8gwsKkzFGx+59LqFI8ZI+Yy+ElBCKvfHA?=
 =?us-ascii?Q?bfdjFSvf//dhiH556E0/VpcS4BnH1oRO7XC04qQBt41DtNaKHE/DC+0fydTb?=
 =?us-ascii?Q?2ewSBduxpeQgT1OUABmXe+uUpWPCmgwbLxZ2o7GQNBgxLj1M56K9myBhyq1/?=
 =?us-ascii?Q?0By1CEH6iBgQp84mYUSt/xKN64u7s4amkJrRQOQ4/AljkAxW4c6KeE/KxTSP?=
 =?us-ascii?Q?G0iNKxksX5bsk0iHdNpH7WsRq7aMldYZmurBIul+8RCsomipDlmQBg64mYvJ?=
 =?us-ascii?Q?WTHgqh58PWJeQZbQMC4+1ujd5ac3vYGu2r2s2XosSMKOH2q5XI+3BuzUimHY?=
 =?us-ascii?Q?Oxxg1pg4m0M5WnpB2XIs9tXgbVzclgKujkKAdg3PVeDYQwrrbvK3jpdbUJNR?=
 =?us-ascii?Q?Y9uO5/gPNstlc4cV6Z9NHmHBC1iN5N5ojEadTaIovxiyz6R9RoBoY34UXQxe?=
 =?us-ascii?Q?M6xNruZw2RIJUB7KfE4HrqG/IamFsPPtG223Ifk6b9n4cEyztGT+5tbdaISv?=
 =?us-ascii?Q?eCK09oUlPGYRUHlOPRrk8BkB5jzdASeyQTFEtYGpO0T2vaX16uCBL9Ubedfp?=
 =?us-ascii?Q?9BS4DVtwIhkGVay/t5Zlwnlya4dqCUxS25P3u/XS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbbc6dd-0d4d-447a-d4bf-08dd6c746fa0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:42:30.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQB+ZOmsPmQsUrUntStrLT8TlP8k1gOv4+WAcPv7DBn7CWjeXpet06bLqh1fz5a9mlP5EfI9NgroQK0KLMVfrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457

On Wed, Mar 26, 2025 at 03:59:14PM +0800, Richard Zhu wrote:
> Add PLL clock lock check for i.MX95 PCIe.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 42683d6be9f2..1c8834fbcfd5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -45,6 +45,9 @@
>  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
>  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
>
> +#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
> +#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
> +
>  #define IMX95_PCIE_SS_RW_REG_0			0xf0
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> @@ -478,6 +481,23 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
>  		dev_err(dev, "PCIe PLL lock timeout\n");
>  }
>
> +static int imx95_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
> +{
> +	u32 val;
> +	struct device *dev = imx_pcie->pci->dev;
> +
> +	if (regmap_read_poll_timeout(imx_pcie->iomuxc_gpr,
> +				     IMX95_PCIE_PHY_MPLLA_CTRL, val,
> +				     val & IMX95_PCIE_PHY_MPLL_STATE,
> +				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
> +				     PHY_PLL_LOCK_WAIT_TIMEOUT)) {
> +		dev_err(dev, "PCIe PLL lock timeout\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
>  {
>  	unsigned long phy_rate = 0;
> @@ -821,6 +841,8 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
>  				  IMX95_PCIE_COLD_RST);
>  		udelay(10);
> +	} else {
> +		return imx95_pcie_wait_for_phy_pll_lock(imx_pcie);
>  	}
>
>  	return 0;
> @@ -840,11 +862,13 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
> +	int ret = 0;
> +
>  	reset_control_deassert(imx_pcie->pciephy_reset);
>  	reset_control_deassert(imx_pcie->apps_reset);
>
>  	if (imx_pcie->drvdata->core_reset)
> -		imx_pcie->drvdata->core_reset(imx_pcie, false);
> +		ret = imx_pcie->drvdata->core_reset(imx_pcie, false);
>
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (imx_pcie->reset_gpiod) {
> @@ -854,7 +878,7 @@ static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  		msleep(100);
>  	}
>
> -	return 0;
> +	return ret;
>  }
>
>  static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
> --
> 2.37.1
>

