Return-Path: <linux-pci+bounces-24766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CDA71885
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF203A8BCC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8364219D07B;
	Wed, 26 Mar 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sg4N00aZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB331B4132;
	Wed, 26 Mar 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999496; cv=fail; b=t4WxFIZXBm3Q4vBJfxouM5g4fKa+ml3VOvneYoVTR0hqK+xMPLdZQDyUbc4iadJd8FN8W1wqiHEGNRYN9USqCbfjEpvtd8bP+kg3mklq9SThA4pnCY7xlPZjg5l1lJBPEkuFiTg9gnZaxdpEMPzMXDy7asdVhiTLPFeRBV9J8ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999496; c=relaxed/simple;
	bh=/YTYZPeH6M0ESPm64xmUer3Jo6i26QZSGH/RWYvfXVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qvi48ilxZIdB/lAmx7MUqig4Y9FAhxIfSyRv+iJ6KFGulToNtAl0vHORVdFbmzLvhzmBQUSZZEZIR7iHsOjNIMn1f9EhootKuEM0FHU8qSNqKGYyvkDu88ZrfL+GHYZF0QyAvz2fdFZFyKnBdVcL0mcxxOmE/RN0WAj2j+RIaYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sg4N00aZ; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCMPqMVXDjsebB3IM0gONC5KzmGs1oW3Bqe7AI6d1wLptTzkWJb1ZYpg4DSqGLfZRS6uEi7P78nl9Jr1bqJgPzPKrTLeOxDYGF4Q3giwBDAILi1r8D16a5PI3TIpThlW+rYFTiV6THtvlvlrlhDd/VI/qzE+hKDOqseBYSeo3P/sey5b/1d4XYA16Y7/eMuSAGR2IwFqPIURqaEhIh1Z7X9vbjDlM9JVBA/w7fY4hA7lDq7vVYMKd7zWZZNwXTClhNUcbIPFQxcfdZZzmxQSCdkn2whZyM4VgzNdsKliLC0/ydsQmpkQunTziBmKXSIIMf695ii3l/mIztECDu5SpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6lBtZCRLN3GuVWwNtx9yxfFsMzYr2zJPwCQ7C9PLA8=;
 b=Q1uopvADxC8uyA0tDIgBCR8YkVVou4nvAD6xDxqnfJNPpm+Keh3ykmXrmzMpH3RHAXeLSrhaXrkAChvnmLlACiD/Qqx/doPVgw3eLsjjcnFo9OD0Nm2d6tDL0p4iVyhy4dOXPOF+DQ4pM1aZD4I+H1ImPdM9bDXXSsG9+HjQ7Dquae9UHgaGt56EyT14C1OaH0fJO5towByIxmdV/4VoRevxWGqXNoreBRD2mYKL+7u5h8ZaHTO/KjmLUG9Gr+fPsMtEfHJxeM7rJkZ7XjumsWIv9YKuNCD0zrj13EqrhzRkKYOcZjWR6ruyISjbnyl3AJ0mOTbry3DMPUmHG68L1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6lBtZCRLN3GuVWwNtx9yxfFsMzYr2zJPwCQ7C9PLA8=;
 b=Sg4N00aZQbz6abWFKfZ4bq8IoIxRRyUOaUEWjUPopvJCuFipxELUggFsbk1dmBpSAx/Oeyt8INQXRgOJSIwk2ZY85KhK0xiCBvx8q5qdhWQqXD3SK4Qu397D93N4CZlf39pjsjKwtGoe/F5xvKJqsdyAS0z0cZmrczxor5q1dSOCG1ApnLcteWxqLpVFzMc++LAv5xYxXavu4yJ9rLUzZdsHDtzCTzLeCcp5K3dbOVDU6aVrEHZrZvF5KqBVfVJs43kTkfa64behJr98JZutULqk5/vdhruCbUt7HYy020LwQhjJqT7RMl2NxH+KyxfR1deXoN4s59WxOO9JByq62g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7043.eurprd04.prod.outlook.com (2603:10a6:208:19b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:31:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 14:31:30 +0000
Date: Wed, 26 Mar 2025 10:31:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Message-ID: <Z+QPukWbfYfHKrg9@lizhi-Precision-Tower-5810>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
 <20250326075915.4073725-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326075915.4073725-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e859c4-6695-4dea-3872-08dd6c72e67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OYN6fHfTroOPkbX3ef7Kiln0vlszvMAOs/5PIyHTg1ZCpBrYhNFCf8r20rAK?=
 =?us-ascii?Q?xGPi1HvKHXIc7CrVS/8gzROH3AhkBEcoBBZx0Stuw4cgFD9vGe26dTF+n77V?=
 =?us-ascii?Q?iWP5gzW8K7/3lXS9TTBrG2wswFL2mjFn3b61dfdEEOhT9zv2/e0p5WVOshvO?=
 =?us-ascii?Q?q5ZYyBMsgQuiZlpRzo5Cw3WYFDPZvPJrpGHGB93ylXNvA/QH8HsmBlp42M6f?=
 =?us-ascii?Q?YgzesrGpoujSjx2egMj1oYm5hmJgsjHxFwbkgGPQM0OsSBcHGnywFUww35zl?=
 =?us-ascii?Q?ZeP3+fYHPjfn24zv5Zn3w1by0I2KCW/QDdYWOVhfPJZ2Cm2RbjI4z0Rk+U6N?=
 =?us-ascii?Q?z9kSN9kOYCbQt8yEbAIjwv6qMbptJqHhB3a8lDSzxYqUqGLB0L/CO5QnpH5K?=
 =?us-ascii?Q?tdtowFFSZH1NJzCYtf3aoyBSm7bObtLKwkdDpHJsYcmi0t0IsFx9Snz1BlKK?=
 =?us-ascii?Q?qHvQ8RcbJ6CSPRIxW3SzqWcZbuMXaiMa8bhHyjCkwd0R/Eldo96+MxcPF0cs?=
 =?us-ascii?Q?z9ukeFG1F2MpKykQRAevHW6Lv/LEuXlYXQ3xr2kYB1mVfIzXWKjH9/fOZ4hU?=
 =?us-ascii?Q?fC8iUoCvmsKYTLh2EXa/8IXLXXJEbdYoINF9MWCMNj7KYODC7MDr0ycIl383?=
 =?us-ascii?Q?M3eRhH8FE1W82qxaedXowm4byDr8KgR0uOt1Pn/0i5lRxrjvuw6ANIUfYgBg?=
 =?us-ascii?Q?l03jBzvvIgCqfA7VihKCHWrlmobiNVnroFV2LQ449cMFi18EWkW/exvFBtZJ?=
 =?us-ascii?Q?lMvK/egTsYtGimOjTSSpwmZH0otb2tdn0pFrkNVhDPS4gNV0gDnexJYKUytR?=
 =?us-ascii?Q?kTg03X+BfoYq1z5X4TYqDjakEPUFbDGe43TTvLWxilCTXJMtWUCv8dkD9QTX?=
 =?us-ascii?Q?4BUC5kLHuTW8oj+pvM175Y5sq/URHjHbatBTAPpbtn6DkJGbTkwFm6e+Rt4I?=
 =?us-ascii?Q?W6FQb59a4FPy4jpi6tKxgKAB4bjy7uYPz1nlTSfROJjr3mDXqyuQAWEVpOD9?=
 =?us-ascii?Q?OWhG3mc6Z8YRxkuUf3lJ2PPnydKDdWyoCVHHlNV1FSfuiJDTn1Kdqb92qlIr?=
 =?us-ascii?Q?923UOfXZezOJ9jWF8XxC/Pqfhnyxy4j9bqYU5qcYyFJpzvjMAyYAx8ucExH4?=
 =?us-ascii?Q?LwKsV77u5IxZKw7QZcT1zPIfoiDG76k6eBt+01vd9QDoTAiD63a/zhPtvbZl?=
 =?us-ascii?Q?2rGibLCylxEEm2mMVZKxbjjgZz+QuOTiIczlIyfNDyS8U31I+YTcKxpVPeDw?=
 =?us-ascii?Q?zK1hHBvXec5D0qi2Qh8rH57lQ07cM1qF/7fFuBsAIZSdJwd8HKRUCRhxvdFv?=
 =?us-ascii?Q?Arwn8GPV7vTZVV/dwD8aUfR2NsgNxdK/5qNpkZAhpX5XEBf/gvr8F+vMjul1?=
 =?us-ascii?Q?V/jG6OBoB6szBLFoO4PTrVX0isRKTZA0eg/1A0uM+Kjx84evLuYJqDD47ogA?=
 =?us-ascii?Q?zyai6llLthLMlwXHOqh6XUj1F/j/1pZt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdjjrbFkwqSJgxI/R0kWEGv5EC6IrdAXpaBjrZdoJ8W9wIgh/qmkj85cxuMt?=
 =?us-ascii?Q?dGclWI3qKvdC5X8u9AsCFIQTw9i92xNb/NdisixEAzBXpCVxS5eNAvM+SeHR?=
 =?us-ascii?Q?M80YuEnBHYqHhfHaPYaZBSSFcyQHLmOz5FbLdZRtcfDKLuD9nQ2lguKx+d06?=
 =?us-ascii?Q?e+zMBhzBGEAOZ3PSnotcIQdMGFkDp3O4mFUphLHOvcyH0pVjLIaPGHQ1XnHK?=
 =?us-ascii?Q?KPHhvyCBbaO7ygH2SHmuPpIkHPykrilh6uC9GeL49MtpBJEiYGGbmKS8fb9F?=
 =?us-ascii?Q?yvnLMJrgMh90KWbTAmJC+C8Xwok0BNwyIGfEL2+/AX20JdL0kbAy/o7SeEkb?=
 =?us-ascii?Q?oBc0dYRxssktTsOaezXflQZqnN3SMwm5uaRRPxo38W/AoyzloqB8CmLz8g+u?=
 =?us-ascii?Q?sfeihTgn4LBq+sz5Nfq2R4Vwe0VhwwRXs7mNYJZgG5B9OGOpUiroeNKBSR3J?=
 =?us-ascii?Q?zUbqxfBkPBzgPEs5eDFwBnslbbctcxYPP8fC4gRRcvhF3EI5Rjml3biECg96?=
 =?us-ascii?Q?PcT0tuUgKeYS6CQ853H/KXyTGz8aDKxZ8JMhLb9Et/DVLr2uymxD4n4Q0KM9?=
 =?us-ascii?Q?GxikrWemAxfR9D6E5Pd4AA4dvLzAcoiIcxVAM3xv0C5i3nnG4gvlzVEGm9U1?=
 =?us-ascii?Q?V95mzG5Ba3fmhtIKmeiPU0UXlwSkCpzVIQLs964jc2gGiOsfc8AwG7e8keAq?=
 =?us-ascii?Q?3Xp1AJ+sjiucu3mmu5OP3eSxiGrxtGiYV/rZcGzMvGQy8VNsQcUnmhOmmW4z?=
 =?us-ascii?Q?Jo76uSRm7U+XAFFnMylgPSj6uRCQ2JYvqBI8R3BFO177UAyHb8L4554XCQel?=
 =?us-ascii?Q?UvwyreioUbfgkgEbHSnnWJOovMVkTXiSM7y8bZzL8fX+nkX0TnVMiSL7DAa9?=
 =?us-ascii?Q?5RnwEMg2w7k2TQFx8YZmtT4ulP/+DTRAqXx2iksBkBcB/V5PigfqdM9ILOI8?=
 =?us-ascii?Q?fz852+LQTVastz/0m05ahYaGm3Kjftn1fqYqZ8Lyx95Z3xoEQYBpiyFSgXrC?=
 =?us-ascii?Q?OWMhhR5MgG9JwV/B+766hQNEMMXffrHzYjaBYUKgIJ8d3NdZeqZrfd22OcKf?=
 =?us-ascii?Q?1amQgnZNGU3UdSFCGNVy55Ib+/2qzW8IfmxS5gyIrNu44TjEgdLlscFo7tN5?=
 =?us-ascii?Q?4ixF8CLrr4E4N32GkgP5kbEu5kgP53gCS5Y6KEAbboTIMzBHf6KMDZwSMlRd?=
 =?us-ascii?Q?H1f4G/cyPDGoGIjcm0LL2OpSYWvTYvR05Ao39UGQYcj9WDmnzkqHbUxJeUaw?=
 =?us-ascii?Q?Ni0EzD4QHcr4roOGXtxHG9XO4O60usVSli5vNXGEn062/VplZ5e92JKpCY0x?=
 =?us-ascii?Q?IiDlTSSOgnV82/RoOTP7vvsSylBij5icDtwaMfRZQq7DTiwe8/bFyQBr2UM6?=
 =?us-ascii?Q?TcPz5vVjNLC/0AQuguPS5BHG4EXZTzpLK1urecMPaw3ivKYm6KzuYsF8z+Uw?=
 =?us-ascii?Q?vl55urrynLf1DWGuxF5FmA1Pw97i1F8kTIfd3qDLteyuDpZvD+XzjVqcuA62?=
 =?us-ascii?Q?iw61dp5BcvnSx9eCJC4mPWZkTOfpiILj3/+G8QU70T6CGWIXEf1cgel2dqEJ?=
 =?us-ascii?Q?1XTTkUCgfQx8BvZBuWaquxxIER/sfXp11D8dRpkb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e859c4-6695-4dea-3872-08dd6c72e67a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:31:30.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inSfNBtalxbYOleMhAFb+y0llsmWakVId22hRO8comNn2woOydUM1OJHfwXw5Cv+Hy9LyXSdvgk4VdECxh099w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7043

On Wed, Mar 26, 2025 at 03:59:11PM +0800, Richard Zhu wrote:
> Add the code reset toggle for i.MX95 PCIe to align PHY's power on sequency.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 57aa777231ae..13e53311cc0e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -71,6 +71,9 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
>
> +#define IMX95_PCIE_RST_CTRL			0x3010
> +#define IMX95_PCIE_COLD_RST			BIT(0)
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>
>  enum imx_pcie_variants {
> @@ -773,6 +776,41 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  	return 0;
>  }
>
> +static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	u32 val;
> +
> +	if (assert) {
> +		/*
> +		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
> +		 * should be complete after power-up by the following sequence.
> +		 *                 > 10us(at power-up)
> +		 *                 > 10ns(warm reset)
> +		 *               |<------------>|
> +		 *                ______________
> +		 * phy_reset ____/              \________________
> +		 *                                   ____________
> +		 * ref_clk_en_______________________/
> +		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
> +		 */
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				IMX95_PCIE_COLD_RST);
> +		/*
> +		 * To make sure delay enough time, do regmap_read_bypassed
> +		 * before udelay(). Since udelay() might not use MMIO, and cause
> +		 * delay time less than setting value.
> +		 */
> +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				     &val);
> +		udelay(15);
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				  IMX95_PCIE_COLD_RST);
> +		udelay(10);

Is This 10us critial? if yes, also need read register before it.

Frank
> +	}
> +
> +	return 0;
> +}
> +
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_assert(imx_pcie->pciephy_reset);
> @@ -1762,6 +1800,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> +		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  	},
>  	[IMX8MQ_EP] = {
> @@ -1815,6 +1854,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
>  		.init_phy = imx95_pcie_init_phy,
> +		.core_reset = imx95_pcie_core_reset,
>  		.epc_features = &imx95_pcie_epc_features,
>  		.mode = DW_PCIE_EP_TYPE,
>  	},
> --
> 2.37.1
>

