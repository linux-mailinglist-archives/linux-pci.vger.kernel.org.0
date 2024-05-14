Return-Path: <linux-pci+bounces-7463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF898C599E
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 18:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DFB283E82
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5691802A5;
	Tue, 14 May 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m2MWpEqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6D1802A8;
	Tue, 14 May 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703557; cv=fail; b=t1s5z2TOV/WxdHOI8gRcyVkWJ8rAnUEl9gJmGu4i05sSpzh2NPtNTF3HbQBukS91yqHZC9CXjvw9mXj5tyrWMy+EgPR+V5lcdr+oc3OS9XaIPf40d2WtqIsJpv+8KtNGBsCuz0RiszIq1BSccmKetT7rhFmPlRjFg2KaNgnECoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703557; c=relaxed/simple;
	bh=PnycsfVh1aujBm9yTOz32NLA6pEUVw8jio50miuki0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZhscDPGwbpUftdbV6NBA/MqYm8U5wtV+y2SqnELQsNszcXbCqJ3OYxt9lvWU2I58S6mW7VraQ11E+vuB4eOQ+lfPew+WHO3ey+ANNscbiMA9Fi1kB0HKK3dfrEqKe+WstCsaY2Wmd+qQT6lyaHp8llW0YMBycvjVYAuDX+nqB7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m2MWpEqw; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPrgUC+P8k+rEyVWvzfJpBn2y1kpDefMepHaQTrbD2d/l3e1dKUiKtha9vE18/kAhx5wrau72db61KtR0nWriIjLuIqoXIbI4JQxwwLXSw4x0zMjMOtbKf4FXR0k3CEm7WgFWOA5kGujrVYXKps7o0wa5Nu/DP8fBwFMc7Yhd/K1g1SWHNF1WzHpQ229naGt268STbwe0YqdhVrg2LN0iQnzBecLWIwFedKW8xc4SUVjeba8XDLluRuBwySAT3b0Z9AIqPr7CDG87BmAG3CJyIisu0bRmsE9FAyyWaKmKh29ZrDtUFXCjbaFlnscDKIi/jSshI74Bk2k4eKxnMf17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vbD7ViSGycGGLn/TXxnyHOEosd05uK9V4vPjn1yXPk=;
 b=D/0CfRxmnAsHviwMHJPoRptNEHmWCXBteXPydrSnqlmWmqQD/kolc1KhA2J9iFanE8wFo7lizdnmcVOs8UZrg1vELHJv4WxbNeSD95+Z6n/yg57k2o43M6te+j6croxT5oukDE7QlWCkd0QdskF8YpbnOLBRSz3V2qzDFCrmVm67yaXAoykH7cWmVWqCupuSR67FHqLtJ+RezQu1tjKhOnfRzsmYG9VNUR4K/qK3svjSjmocUqUy5bWIR7xznPaZhCWiVM3f/ZvWjWdKx4foPNWo9gokRHbiCluxdjIcN2CNPH+H1adZI5yqf7pwLhnx3kMIQiU2hHsXlHicVI1QXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vbD7ViSGycGGLn/TXxnyHOEosd05uK9V4vPjn1yXPk=;
 b=m2MWpEqwf8LqlM4leQ6pQ9+AZr5DETQPltiHN6oz9j7StWqAukAhzo+yUi4yT4TrknuVJedp2MQjFYb9d5maiZd1dUPR/CojgWdc49hX4OBfbGxS7bN0bSSUx4W4prMlzfU8D7xG8Fc3UfhM3SIXqYQCln6FUd0F66CVZm1YtBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10887.eurprd04.prod.outlook.com (2603:10a6:10:592::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.21; Tue, 14 May
 2024 16:19:11 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 16:19:11 +0000
Date: Tue, 14 May 2024 12:19:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, mani@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v1] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms.
Message-ID: <ZkOO923deBXzAcQ+@lizhi-Precision-Tower-5810>
References: <1715663358-8900-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715663358-8900-1-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:334::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10887:EE_
X-MS-Office365-Filtering-Correlation-Id: 7152b7a9-a4cf-4852-c3ee-08dc743196ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GviAin7iryitA4xniEZ9L8CTw/Kbgf0GEewPeJGdUyQBJc9UL5j7spcpP05E?=
 =?us-ascii?Q?0btIB4/g7tECOj3Bij5ZqW9FOaRXhf03acsBACoqqsBAhKI/EyqjLkTSKFMu?=
 =?us-ascii?Q?YbEcWrqUMV5uxg3cWyXAKTV9QKhi5/jgYMj2ZQhikZJgSBH42XlDx9jUkgWO?=
 =?us-ascii?Q?/7wSLc0tWVYlBIEjxNp68nKeFRwOQfricx6RnRnfBHuxhfB0PH4I15hfolr5?=
 =?us-ascii?Q?+EEN/UFLsB8UScQYpvnelXbnqYQKiHioEij0opg/IQw7gLSMRo3IBX2bsVEY?=
 =?us-ascii?Q?eStdmhlfBDTxeuhAlytU3B3wYcTgcAC8nVZLYrfN0hH/Bp3Lx4HNVXZ4SUtk?=
 =?us-ascii?Q?+5k9zMh5ZsXB/8pfQs+MAz2dMpZxucyip2Xq1HLCctYj4WIO8xPxjblOtUdH?=
 =?us-ascii?Q?0XRW4nLuDf7akaxX7vTIAlq9PLOe2VSYvYlbInOJFdQ4TnRbz+jRwEczy3+H?=
 =?us-ascii?Q?41IwjVd5LjQKB1tWOfOyCZ3evCo4BQtvHqAWz16dA+Gqvt+DOOLl6jdAFnWJ?=
 =?us-ascii?Q?vMGYcRz8Z9Do55ohMThroEe5TkHoYf51qk0bS5sLvb1Z4/LKSN/GTvEx8ORp?=
 =?us-ascii?Q?ehn9dpclDkT3EfvXo9rIR3B/APBKs6Xju027nSgGVoSVxcpaoBXWuRx8/peC?=
 =?us-ascii?Q?ii46JehgfNl4DZgyMfIdAEBUQUs8TEFUDKuPXTaTf3pf2UlhT02Lm4guGDac?=
 =?us-ascii?Q?UL5rt2aj7OsCkohw86ZLQfwwspv18BXPporL9AraL89ur0dJJ3cBj/Ua9u23?=
 =?us-ascii?Q?ovweLb552iFV3m2YO8amtgStA4/ZyHzmMM81dSCQXZWSN6KzTZzXu6SHmcfL?=
 =?us-ascii?Q?Qo7FzyGkPAzYaxxDt3IT1AAPgXzHpSkASdr2fD4yEaTkICHywRHNdcCao3bW?=
 =?us-ascii?Q?HG3fXi4GSnuinSb7Mnc32hYeiEAtjZ5MFEY+mjfG3a6pB0sK+9qI1D5Th+vw?=
 =?us-ascii?Q?qGroBErNjX+B9yJLceCotxptBqhEq2v/3hnW6AlxXsIZsV4GMOmqKij+1AQS?=
 =?us-ascii?Q?+9Bm30mJeaA08MDdp547fFgGKnUsxOYhBLp+PV6iFSZKMUpZOEcJdk8hY77r?=
 =?us-ascii?Q?vhgCzHqyacvbCFExSFDVa50pZis6j45czaOkfk1nviBrw7Yup7PRtW+VfXdW?=
 =?us-ascii?Q?XfJi/mKADjnBUAkZmM74SPHH3jD/FSBzYRzwEvuZDTxyfoXcygQw2e/s9TkO?=
 =?us-ascii?Q?ZEjI4Hp9JgJEfTckmo52QS2DDhENCbT+VmUqVMTLFjVj8dCzQzWYHdHfI1z1?=
 =?us-ascii?Q?d8cK3Scq2+OxAL/meExDY4xOYg8aJOP0WWEafkjmaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OJZnPpiqwf8IX4eRw50M7/oDCxFjIsnrZlpPe1IKqlM3BLJQAtfGcinX6LXF?=
 =?us-ascii?Q?jC/R76d3j2ZuabGlA642bbykUD421KIa+JjnBhJQ7Vjb3bcbHfexVrcK4qR6?=
 =?us-ascii?Q?Y5izrbpHFqBJeTZIg9csv19xU3oJ1pgb+8yC8qQNgojO1vDJymNcubJ7oMUp?=
 =?us-ascii?Q?Ky6AXljw3WimXRi7UGlX/SB5BS+8JBh917PtiYPvPd5jbVlgYOT7h62nMvK7?=
 =?us-ascii?Q?Gqav19uY3StMMLDEEAYoFukHY8CrECGQwoXoCfYsUQtPK7e5VnrRLnah4Wee?=
 =?us-ascii?Q?XGFrESPS7mXy+LbAftzfnd+0oU+za28WEVDUwPWIQEaYdEFtxGaW+FTyUgL2?=
 =?us-ascii?Q?vthVKjqhqGCWz4H0I7Sa8yMxNKkxYjRmW4iD64SVDmQVAjYLkNiUEcb9zwUJ?=
 =?us-ascii?Q?FYebV9kbIajHeLIYgaCQ0jnF9BaH54pB9w6FZHWqL/4mJrCSP6OmCL9Q76nJ?=
 =?us-ascii?Q?MJfHxDV5okAU5WO6clRGFrQPhywarkDenaDhwUoJY6yZSpjel5/9aPWk9zlB?=
 =?us-ascii?Q?yCE2LQKLg2EXmKxYAglnhWMZdyDHqhfKGTyQcBijuZjsrWpq1mVuo6eHu35n?=
 =?us-ascii?Q?nfu+GEB00fQNIpmkgiYZvFXzDjtoGiVtBl94j6PuMIVFNaS78y0x4G7bQuoi?=
 =?us-ascii?Q?Gqfua+T7PFbEY+3HuQ1Hhz342r7H7nQr4eIdPnkay7owT5bDYa2H0K1Y/P0a?=
 =?us-ascii?Q?qYFhbrExKCnkO5QvMpmxNi/EptfvG6ASHCyuk1Ls+03HFZP201pbnUhrd/Jw?=
 =?us-ascii?Q?xWNy0/PlFr0Fny7GoqtO6g2gaq28Fbm9EWaqyYN6Jo4iNSrJxcBodeSiuYSP?=
 =?us-ascii?Q?GTrAR8oEoXi5091yesHnSAu3+OfFWF6SOgusVvkJXHuzBFUO9WpMWjenKbjc?=
 =?us-ascii?Q?5O/7Z1ZX4dPREZnnHvKh1gmMkNrUpBjWmVBMXaQMdr8u90/Qim8USOOJvDnp?=
 =?us-ascii?Q?CZ5gVAEqdp6nSA/Y7sS9liFhqMPWssEzwHAt3eJ1/vSzbLNcc6H0cNp43AH0?=
 =?us-ascii?Q?b/lhvMGy8tjiULvve5hJwcm/BIZTwLOJ3Cfg7O/Wo7J3/1DiWdtufDqN1NYp?=
 =?us-ascii?Q?+LpuKUCRSuvP4GVnFKJ1zNXPpvT3DnEJW9+pUtCUKFgOLHeFxQL6GVktMKN1?=
 =?us-ascii?Q?mVo85ybLjs+crFxXI7a2TnkF14+F1R6ypz+w/yBAjqGS+og6uwFdf0x8Prmg?=
 =?us-ascii?Q?nqXWi34F58eXWFfgGbXpfyZ2WWIChqRzljy93avlx9aYJ37ZvRv9VEtcrFAF?=
 =?us-ascii?Q?WXK2ZHvtY5dyS/oSUDKTWqDIiZWwFlVAbUcc/xMYk1g15CLmArHkrI33qgjq?=
 =?us-ascii?Q?jadDKOEDWk/+Hc9FrfVar541WpJKoIRyUxJ99ABNU3l+x84tG4rX035SKLJU?=
 =?us-ascii?Q?fvLNvrG6IVK8P2X0MOGEuhTxu8MWxiZd8ZIGs9W3Thl2B1OPHsPGBiLt9U6N?=
 =?us-ascii?Q?0Coj6FeJ7sKCWNCsRC08QbHez7pMFWFJgQE5e50LfCx+Uqi4Ke/7LNQAwEPP?=
 =?us-ascii?Q?i3OqiH8jOgIdt+K7K0tUac64YU3SkZTDDQmk0MUFRgEueLSXv8WuouVdDNU7?=
 =?us-ascii?Q?Vi8zfTDDA3SEFaHx1+c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7152b7a9-a4cf-4852-c3ee-08dc743196ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:19:11.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tktVre2JTG8fTsAUQwkbrU4BfGSUvVBCURX+fJKdahKbBubFxLkYSa2gA469SbhzgIAXDMQW44MH6b3/0FcxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10887

On Tue, May 14, 2024 at 01:09:18PM +0800, Richard Zhu wrote:
> The dw_pcie_suspend_noirq() function currently returns success directly
> if no endpoint (EP) device is connected. However, on some platforms, power
> loss occurs during suspend, causing dw_resume() to do nothing in this case.
> This results in a system halt because the DWC controller is not initialized
> after power-on during resume.
> 
> Change call to deinit() in suspend and init() at resume regardless of
> whether there are EP device connections or not. It is not harmful to
> perform deinit() and init() again for the no power-off case, and it keeps
> the code simple and consistent in logic.
> 
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc
> This patch depends on the branch listed above, because it's not in pci-next.
> But suppose it will be in there soon.
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a0822d5371bc5..cb8c3c2bcc790 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -933,23 +933,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  
> -	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> -		return 0;
> -
> -	if (pci->pp.ops->pme_turn_off)
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> -	else
> -		ret = dw_pcie_pme_turn_off(pci);
> +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> +		/* Only send out PME_TURN_OFF when PCIE link is up */
> +		if (pci->pp.ops->pme_turn_off)
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		else
> +			ret = dw_pcie_pme_turn_off(pci);
>  
> -	if (ret)
> -		return ret;
> +		if (ret)
> +			return ret;
>  
> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}
>  	}
>  
>  	if (pci->pp.ops->deinit)
> -- 
> 2.37.1
> 

