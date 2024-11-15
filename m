Return-Path: <linux-pci+bounces-16888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0339CEFE6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D245FB2699E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789231D0DDF;
	Fri, 15 Nov 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eoCnVavr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4D1BBBE4;
	Fri, 15 Nov 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683161; cv=fail; b=mc1tpIYBzQwcitxHYb/wp6Ce84twHND8eVmScGgKzV+ueibZugRQgB6tYs8Rao5/hFhNZYtMpTEjTNk0KJ8rwo7/j8cRhh3hq6Pitp6arG9tq3QLo3BBzXKE94KaN7nCZ9LUCnTkE/+ZT0XboTbPuRK+OQ0on2bW/5/7SfCGV9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683161; c=relaxed/simple;
	bh=ptRlveVm/tapGgpn31mQu3Szx9vF7/Zpq1FKmvZRLRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YBuGht/7XsX9eZKB/5QOm1+KA1Wgu5Za9qX3Lue/Abm/CeP1iS+kZYk/GndNXHu2WoBS5q1rQEGYqTOmuOFvsj6QpFUBdzb0Rymw1myougBGKmAWaD9vmLfwQ3tHYbb8CtXsHk/cwKwhGjXGMHMUFEbfVvQn6qQy5B4zf3tkMmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eoCnVavr; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms7HCrZpYs6km3eVoedN1DgkAJJnCefjD7chaFNlgBRAtKdmRmKy3oa9wJrHmQM1IV7/CddczClnm+qiIZp/YfAyL3EjtBg+KakB3Glrge+3jBBavc613DS8XstxCse/JqKiMwUUzwVzWes9pze3DMdH342RLMPxGaxHTz9587RrIaymb0KmME3leiMmtT1qw7sInn6NYH76qrZ2oKJsu4k/tfFdpBJ9McCoZNnHVnqK485HOgqzcTu6+rOSDQnV1XoOk7OQsJ0fThb4z89cN3K3bhOaX53SKy582lwiEQIR3JyVi8yEXIbVYr0Llr2f7cTranGNWk2G3TOHmMIoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZGrWCJiRUSCWoaxeFVKdu4p2WCXxN/fS7IiAMP6Ytc=;
 b=f1AAIYoiNRKau1vvDLwsrGqARD+ctW4mZw0LG6TvKL+DPPSNrSYX6vrIWvTt0lifsTz/dDiLIuskHDy7bVZj0LJP3WRSB3wRsmqANqWBNW2dVlst/H+5pOQJXB9Kc80/MKc/1n1FK0LhEU2Q79xXiiEMKJkjS6fJMSVVetkFeG/Gu1Othrh3DEHj5bLuWunC1YwObBGnSkHI7MlKKigmZ7dURcmtB6cLfkxb+aYWK97SLdJpxowo1SAxZ8U+DD1IHEN3Fvs9+DE7k8e+YaMMrNisvxIjuD5NBDJZ1ZgsMc1sSzxXdvh/SfkcaDjtTzGd5Dk4JPQTNs0kCDNiJjeHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZGrWCJiRUSCWoaxeFVKdu4p2WCXxN/fS7IiAMP6Ytc=;
 b=eoCnVavr9JCY0oOrbHWwwCjpiauX7QQ5I8NNpMLwPrCmnWwUnYunK/dxMZziZcEQ51Te4UQkUwwsLTYRoRLTTIi5yFqFNIBSk/9IvPY5ckk4oj6+/N2ViqMOOVV3vBK86g6J3vRK+M460Lg7z5ELy2GqHQWdOU0ZXMjAcANOtRMA+LqOLOA8ZszXR6PteHHsuTrNRJoWFqx633ftt05QbHowGaz3sjHQGrnvAEb4aG8Vf5Xe0JimpwiAtVT68fq9OEx+8WHglOPZRA3jkbzU1ARsELJQZe7kGmbbpo3P10XZaMh9tJvGcAzTkW1BzuaqufeTAntS85/4Xud06mxnJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10419.eurprd04.prod.outlook.com (2603:10a6:800:235::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 15:05:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 15:05:55 +0000
Date: Fri, 15 Nov 2024 10:05:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <ZzdjSO/jjdu/aF7J@lizhi-Precision-Tower-5810>
References: <20241115090321.527694-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115090321.527694-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10419:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c28f146-cc56-4d6b-7350-08dd058700fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fFL6oADjsAykrXoADlFvv1x6FbWHU/ZVOcEH0oM6ho2MID0vxd+14WWPBsdO?=
 =?us-ascii?Q?s0ZYvDz774tS8x89u7N4N/P+KmHFBwE4+TnIkcsz/QKg93RnUl0kzJmzWone?=
 =?us-ascii?Q?PupKxy+gQSwxxiErmYUOq6QGomD4uvWMw83WmO453vfYv4uSJWSY3O3GfJk5?=
 =?us-ascii?Q?d9j96YVe7YxuOK9u5yl2CfF5fqpgwMBAV1fOBkzbOjN14EFc4KH7dYrky0vu?=
 =?us-ascii?Q?3lHHJ9BWJqDHz0HFuutABqTNs4iMVVBPn4fO+QzmN+K0P3PNcpw7VMWIf3FX?=
 =?us-ascii?Q?b5j6gPDRvz7n//uUsdoHA9rcqY+uk8ZAedtlGdZH/My4CsysBpgEGipsP0K8?=
 =?us-ascii?Q?Fboi/Bmm4BguvFsjNksnpdKyNYgGI727DnMjUl5BZhGpRczCcThNOD1VUitG?=
 =?us-ascii?Q?ofA3EoX4M2akXCHxAFDOWj6S/tqsWJc055CqwKHigo+NHMkR2/AxF1WFQL/p?=
 =?us-ascii?Q?xDXzn2Tt3GBYx4dQV6CCNEZfGFZT307swt8TvG/LWVwNSis70W2e4wErNuzB?=
 =?us-ascii?Q?xvdrmHAFQWFk3x94/zGfNjfoNwPicfEDnjA5O/GIYZH4tNTcZKwurQQCKls7?=
 =?us-ascii?Q?TFJ5L+NRieIiFhuUl7ygtAlT9eoEblWpsdrqJib1hs8oxf2K2qy9iIoHFx4y?=
 =?us-ascii?Q?dEARpM5Zf2QtLiE6AxB12zXLBHKCq+QMFxYI7ID9yq0btv5QQFu+ezlM5qpD?=
 =?us-ascii?Q?eIRUKyPnJafDIwhvX3Rn7dghPxXUTyS/T2EGS5cwnxN7MygLaX5UiUYuaqHM?=
 =?us-ascii?Q?GcToPTfJPln+80MUDORPKLjj+YJlB1fBlATylZdVWh0gaIMEdJj9qXQtR68q?=
 =?us-ascii?Q?3XI/9zJmI49zXHppZd4cr7DNF36FIhpFooThB3mZsHbwBORWFXK9Ft0NrPdt?=
 =?us-ascii?Q?ZYrxQeo8Fxwd9QBZqDTb2txCtroIZPa2RPakFrHb0YgmX+XKITUTp0hpwwNA?=
 =?us-ascii?Q?0I911JsrdkmpihuKw6lmBo4QDd26NR1L4RToDiiyljpDISwb94w41zevZQqO?=
 =?us-ascii?Q?KFkVPgVU/8nu4BCIJef8b7jlKUeJhvyaE5UGaDfnu5SqsfwsUaqG/oKgqRri?=
 =?us-ascii?Q?Rr18CamiGwLqA9wtYGvB2d1dIRKLlYPh2Rgs1qOpBaCPaFCGllIsmuzEiGR/?=
 =?us-ascii?Q?gCiCsy2+V8lDyl/OrgXDLmsGOfmF4Tpao/X67R8Gvunl9Tu+qNn+LeKbEcZ9?=
 =?us-ascii?Q?y4ZZdHTNmKW/5oWYAeK1lJLA7jvb3mI5UdheLogXWVFctFnK3wkcop9uY/Zj?=
 =?us-ascii?Q?cO4tmTlqQKmN0Ll/gCMpBbfruaTxK1SfYh2gkJsnWplO00ZKBIcuLmWKV3di?=
 =?us-ascii?Q?yUF3/dc6iCsl7E4R9HwXELeJBERYcYNM2FA7O2TxgoshCdXuZoKBuGaL/blX?=
 =?us-ascii?Q?wd8aiR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qh3wwMG2+YGI/qc8CsoBam2Pyq9vhH1la1xzu25d8hy87ACNoNpoYZ7enIiV?=
 =?us-ascii?Q?XIWLkEzPJXT5C6wsEjkgAseKE/AOqb1LFgKlc1LndSmjbkBBT2ehCFCwrIZB?=
 =?us-ascii?Q?GJYnI1dY7KWFU+tDjxtPUE6O4+QGDWywKnx3IaFtzwXDVcPgsamHj2U3H7t3?=
 =?us-ascii?Q?biOTxVycaD5NSwZffOo7/Ligsx8R4t6gr4dxT60qLhyz2ZAJeDmDHoRipBJm?=
 =?us-ascii?Q?l0TP5f0Qm6LZBGVqWjeFDht3YMgjDIXSQV9DzgnrkXAg7c401l7M/yQK6LOa?=
 =?us-ascii?Q?6bA5bfszTj3hRbOTxk/kpfXZo41nbCxeRAahO8/HCZo02E8OjmTtg/ZutMR/?=
 =?us-ascii?Q?TjNXWhJDHGwYNxU6OOZATioRamvEbyhGHVtz0fBPZOR9BxrJkUqhY0sVNhVM?=
 =?us-ascii?Q?qeAQ1sLKaZRocAIstQjp+JBybhl1z5ryaeVV32LoVFK7FCmsVurzEBWESChq?=
 =?us-ascii?Q?dfDkbwUIeWM0gx7Q/GxMtTVMVVazKu9c+TBQyeUZpA3ssGfa/iYDZMoHR4VO?=
 =?us-ascii?Q?6G7MhT0SBhhvbxwqO0OUL16reuzQKPdcdzlE4h+co0+oISkinCqIQ7oTrfbq?=
 =?us-ascii?Q?XgwOfLOd3fdpRBI9ivIjjdfy79GeEUVZVLYZoKup5O1SP5/nx+4H4KmpxjV1?=
 =?us-ascii?Q?5bF0Vs8VayrwL/zYBmgQahGdEa9bUJXTBfClQ5mQfaLB1L7qZF7wwHrbAptG?=
 =?us-ascii?Q?A9vTsnc8KJu7G6QECN4RNLg5AXLRhuwE5SHRwm8IpluUtP+x9iPeI2rMslXi?=
 =?us-ascii?Q?mWLTUPDMKnGrY1gdBpJgmKvpVJWeJ7U5pBJSu8Xe7JDYk8QQyI20WKZ7LP5Q?=
 =?us-ascii?Q?PNxcz1d+0NpNKjiSenDZAK29gRUm9YGHDRD+zcBGeZRJw49sObiPba57pWOu?=
 =?us-ascii?Q?ut1bFwk6uk+7xQbvE98d5cbyHGACoQsMj16ojKTrwRFo7qc6PKJKmRnxqIdK?=
 =?us-ascii?Q?OGrpZIhnh+TtaoDBVOl4qH4BOBy+ax07JnszuyDe7muQcPm6ZS9zsI/6VIjV?=
 =?us-ascii?Q?QII4I7ORUF5sVyMCmLCROV5GYRk03VdKyZwCFlKo0I4iI8xzNgE3+KdAVM1r?=
 =?us-ascii?Q?rF0dIuxUuDIqpxeRcewriMJwl2eFdc/KLPoOoQw0IcIy1sePNZzURWHe7c4B?=
 =?us-ascii?Q?Yqg/zoGnZ6lLo6UqMQp8JO4I/O5EI2z3923cpPdqMwtoPASObi4w80UGQsJ7?=
 =?us-ascii?Q?N96oTEqOg83x+rIUmUFpx0/KYcDuG5s2YT/nVYjvPBdm6UtkQDGitMCTlwAB?=
 =?us-ascii?Q?6aqh4WBmVUbz2vYvXZMQTE+pN4urCmmfRvOfjM0UN5Tf8buyzYl33pUnE/3z?=
 =?us-ascii?Q?j/w+MH9OkA49iaOZcuiUil/EPBjVk1D5L/hvUFZfuAQaZHnNClo0Kegn9rkW?=
 =?us-ascii?Q?0KQi36QPKnEDFkcLzFtFhxxft38AVBqlB+pcEuJCCA5SxUgvPy199h0o0zQV?=
 =?us-ascii?Q?YBS1gsCESAUmI3vjNnOJXJtp9W5eNuPdNPbdp4X/TUPV1an4zlBS1Mx4K1b+?=
 =?us-ascii?Q?+4TLmiWzp3rIwby8O0sHa6qt1+Y21pxaKgoISQVmZLGvYzpMpkd5K4M7PF3+?=
 =?us-ascii?Q?PUs+yIc14iyVy9aIFjwMyvhtGLI+p3eKnO2hB0iz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c28f146-cc56-4d6b-7350-08dd058700fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:05:55.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iC4eaaCZzDrNgRBEf45opFj+fJnz+5TtFyenYowryKI3lbO3r2aUEWbdb7V6LxdQZ3J8oeAMt2da3zaTxk08eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10419

On Fri, Nov 15, 2024 at 05:03:21PM +0800, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM stat before sending
> PME_TURN_OFF message.
>
> Only dump the message when ltssm_stat is not in DETECT and POLL.
> In the other words, there isn't a notification when no endpoint is
> connected at all.
>
> When the endpoint is connected and after PME_TURN_OFF is issued. Just
> print out one information instead of an error and exit, if the link
> doesn't entry DW_PCIE_LTSSM_L2_IDLE stat. Since the recovery would be
> done in the following closely dw_pcie_resume_noirq().
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 37 ++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f7ceeb785fb0..c2053555c44b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -927,23 +927,26 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>
> -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> -		/* Only send out PME_TURN_OFF when PCIE link is up */
> -		if (pci->pp.ops->pme_turn_off)
> -			pci->pp.ops->pme_turn_off(&pci->pp);
> -		else
> -			ret = dw_pcie_pme_turn_off(pci);
> -
> -		if (ret)
> -			return ret;
> +	if (pci->pp.ops->pme_turn_off)
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	else
> +		ret = dw_pcie_pme_turn_off(pci);
> +	if (ret)
> +		return ret;
>
> -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -		if (ret) {
> -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -			return ret;
> -		}
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,

val == DW_PCIE_LTSSM_L2_IDLE || val <= DW_PCIE_LTSSM_DETECT_WAIT

it will avoid wait 10ms when no link up

> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +	if (ret && (val > DW_PCIE_LTSSM_DETECT_WAIT))
> +		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
> +		dev_info(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +	else
> +		/*
> +		 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
> +		 * 100ns after L2/L3 Ready before turning off refclock and
> +		 * main power. It's harmless too when no endpoint connected.
> +		 */
> +		udelay(1);
>  	}
>
>  	dw_pcie_stop_link(pci);
> @@ -952,7 +955,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>
>  	pci->suspended = true;
>
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..bf036e66717e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
>  	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>  	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>  	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
>  	DW_PCIE_LTSSM_L0 = 0x11,
>  	DW_PCIE_LTSSM_L2_IDLE = 0x15,
>
> --
> 2.37.1
>

