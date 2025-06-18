Return-Path: <linux-pci+bounces-30123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948FADF5FC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E043AB168
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DBB2EBBAD;
	Wed, 18 Jun 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="db2VBbFS"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6B1E98F3;
	Wed, 18 Jun 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271664; cv=fail; b=utROdPzKmLKN3cyqfLCCzAFaapMreCFnwOOqzY4orohhiHsInMZyT6xlhWpEUYF90lw0Y6SKEwC8yBr3kcCLZdprNCWenBpN6CfILuHgq1CzHXJw969FyHstBOKNsSl042AjECMTwf9o+ftPk2CPS2dwM7GHDWtgrPbuFIkKvvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271664; c=relaxed/simple;
	bh=zhtTTnxJJT6gdH6Mz7hFoM34skROa933rjx4x0Zanf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BhNJscbR3kazBj0blqw2O9JuUzu2oxaDTON3h/HRK1Xed2Pxe+7n5D/fcdUNH9WBYLj7nPh/z5xNQ9N4Yg+jIreDNDrkVcYnyn/WIyNb/x5BDrC/gu15TWiWsmkxbJ51XXtt4AAxRKIdYmEiaex7d5x6aaCmbLJgr9802ISzMrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=db2VBbFS; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPZvJ/Qf8b6Dt8kkCVdVWCnFEeXJtUkqGF0mCI6hrrUyFv0SnlYnNdPxy0OqYkUpfw0Qv1ERqvMcnTlfLqnuKHXIPnbUzTBUlLZK32ghY6QHqf61wStf+0uqpxsRTDyoneW/X5rnx/K6VEbfI89zlroLu3BDA5mbfR03mOqyHDc2hho6Vq+/6mRENz9NNFJ8OySN+6HeCxH+bxDb60E5k7nvJbknEIF9bSH5nH1/e2Bty0algS9FaZ8k7VcUu0F4qgq9CEkMJ/3lvXcB46K0eEQ7hv+oz4H/+MFjG/HLm3/gGnLgJ3XkllaHMnUYZUKOJBmWX64R86LeqxsjhmPgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0y9RF5C5A5ddHaUm3LD2gDkFyu+Yf6dks42mRg2eck=;
 b=UD5qF9S1u8d4NVl3/XkrMpELrvNqGOdlRQHqaG/HwTthybVMWjjhEa3jJl7Hap6rF1QVyvaYQ2O50nPevkuk1j40Lkw9ueKfGWMJ7BfNjyxnLb35ybxNITyvdwJk2eXBZD0QEJ53qloZJsDVXSIqoWcogotX1ugVwQdYcrSXbpTTw7XT0Nl4pZ8JA9ycSmwZeegqiNq8YaOn9p7yEfNYlOXSnUWtXIQawEdieC+LdXsx7h1igqqohLYPZxeu793kIzEGm/cHIEWgzMmJ+fPsv5jd03T0t3zXpr/Y4TQosPQWM+lKxJVH82EoCLEnxql0JsXRcdgnGd8Vtbrmfynm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0y9RF5C5A5ddHaUm3LD2gDkFyu+Yf6dks42mRg2eck=;
 b=db2VBbFS00BgK7rl6jKyJh1GOHmEohJTZbAWXlsB6yx/jOqVvyPWhaWthrhJVoOgTNkiC+4rZ9uDMfJ9PY/cuXVm+5JpvGJFSbR69brt33xBjL/uIyyLaH7EZjzTEY2yhsvueD0SJ8/YHzXAvcn+UaZYv3XJjQHCL//MAHpwHv+6oeqHO+ONhFmmekI5lcrUhgyowhMj5R/eZLAIEYTZzxj9FY0G6T/+B3HvGK4OOSFp6y3dS18smo9d67iDJI2Ddz/nJj2w3wo5Qhy1btNUKv0O+IlLfaT0kuZ+VTCG0DiosfFB9ATVgVr/WIkUwDY+MSuHJHkcXZN3VdcDmXK28A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Wed, 18 Jun
 2025 18:34:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:34:18 +0000
Date: Wed, 18 Jun 2025 14:34:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI: imx6: Don't poll LTSSM state of i.MX7D PCIe
 in PM operations
Message-ID: <aFMGokOMOQsj7FtY@lizhi-Precision-Tower-5810>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
 <20250618024116.3704579-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618024116.3704579-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: aadb9b80-c0c8-4952-a8e2-08ddae96bc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?89IRxsLCBtz8g6ezPpPM9PH5q2dTTRYBwSwiR/Q4x+kvE5iz5/TFbqGTr2gA?=
 =?us-ascii?Q?NsOLWUT/nM2XpLIjdxe1JlZG0179rutTEF3ixINLj05RA/2o/c+bi0yoxLeW?=
 =?us-ascii?Q?FyaxnIDWr+Jvg3n8SiCz9Dt61kmewOW3AxR5WLf1kQKLDZDdVbwbyMg+MDeS?=
 =?us-ascii?Q?cOxXNjvidxv8afqMhpEjWr3qT4vnWOC3E6HfS6jzx4tIyxax/MF6YexhLOom?=
 =?us-ascii?Q?J6UKWCV2e9JnwyHciNjyDIjvfTWS7NKUaOgVve66RQjSjRz/Gwf1OrsNKIqL?=
 =?us-ascii?Q?alvDZyEMEAZ7dqtdGhIn3UiB1ihR6ev5W0DbUkaqqoXu9jn+4wUlXS7grP4b?=
 =?us-ascii?Q?ynhoLRqxQBM2EnJunoHe4R5bX4Bpyt4Hf6ZCM/W8fBzjPxSPAK7YGq9LNKHP?=
 =?us-ascii?Q?7G/HoohplUSQmxBsMjWP0w6F8y44Teif4n6WhZjhwqVh+SsAvrZZDl1rwRHF?=
 =?us-ascii?Q?BOfRTrMdh0jPH8SUlyDC2dEoOA4IwKNWrB6ThuxvRMV6bMqKOtrNvrD0nUs1?=
 =?us-ascii?Q?lwvuNIZuEEikH0Yi3aOKx/CTyW1/zT3SZytHrpTT0y6nMF86HsBsAY/tVCM/?=
 =?us-ascii?Q?LvWrZFZgcqZJmsIFtYEh00cw6F5BL0lTnfGj8n82hwkb+WVnO+/+HCHnI+Mc?=
 =?us-ascii?Q?1+6jzGlZ1EVZVzYJ3m3B9QCrf+od4uF28gLEFFJsfxe2z5OdmZqO716t0hxP?=
 =?us-ascii?Q?uyJIAoy3/e6DSPnBOeg6hn3XBef8BetgSB/QoLWCLiUpqlz9SRzp71E4CI14?=
 =?us-ascii?Q?KJ7XwGSjAxUQHBNTQzEVgTo3dl5eEGKIdyBtatObIPAbfzuSsU73iH0gGny0?=
 =?us-ascii?Q?zJNbOIJTNh4R/uwB6tHFi6wqsygx5y/691A44BSoEPn9UfjI6OtGPjb6iLTl?=
 =?us-ascii?Q?WNFbhnUsVFl6U/BwQlHUCtXdv4apkLo0F1TnJs0T4l/SUS8Q7AnN5yMlO+oF?=
 =?us-ascii?Q?T4+QPYxN/i+wjTWOiTGnpP6CG3qznSMDwDmnCQO0so1J+PN12czlAuKkK6De?=
 =?us-ascii?Q?40tnGzclTI5TozxORUNJEZ7ABd/vH8XUjrpZ2PbMOm3u/BlFykZ88ti1/Elo?=
 =?us-ascii?Q?mrzZEoLeCc6vxnJ0dHgYVk1sO3mQhAFvy0SZhbB1Cne6N7I5vSygUE1AbrpP?=
 =?us-ascii?Q?hMaTcLzV3EgdUZuy3L6x/vEUs2Y4RXd/TV+zSB3cvS5R5hhvkAFyBQ2QD4Jf?=
 =?us-ascii?Q?0o3Qbj6+j6R/+aslRgId3K7cyjmW6OmHQZHWGUsBg3HrKVCtAdt12fwD239X?=
 =?us-ascii?Q?J1MCkurpJ1j6dLLXyL+N0dsTHG1cgtQNrLLDjN/7CGzp+kVgtiT6VJa4kimy?=
 =?us-ascii?Q?E3LI4ajxellwRn1e7Cf0qsQtTy91dG4QWwPmfUIjaEh/t7N6PwEr/XfSaBeK?=
 =?us-ascii?Q?//nfRQVu13+wz6wpmWntrGVyWPT3AUgfFKJOH4RGN/uHyOW+2uF2O3jg20BR?=
 =?us-ascii?Q?T0EGCu7ya9INuGHP0ovB9LMUcwcNXhoBpCnekKIktZrDN7J+NpuHZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hyVaOmCDSvMQJ8xVhfjY3GEaPMSyN5JyC66DuUKfvaU771q4RXZmTcCYCp+F?=
 =?us-ascii?Q?2ZPxt6S7b/ruG/G0hOG8evrtbnAwtG1XlX1BqvnE91Qp+wjaGE3WBXu1dAtz?=
 =?us-ascii?Q?h8QTgX6dej+zvKebLhMqLQXiGl4PVQxh7pASdLGSHArSZ1X1HGAya5D0ins9?=
 =?us-ascii?Q?2j81Rs0CBnryD85lq6c4r1LZwdlZdjWZ9eADqp8Oeo6rvJrYmrNfPj8rx9Se?=
 =?us-ascii?Q?FYwU+4wfvEuXOI0NSs2Ku4PlnnU1MMatPpt0M1ftx8k4yHG44DeY+arDiYS1?=
 =?us-ascii?Q?BKy28gEsTkBbC2VT/Zh15jWOYovaTRuby2ODH37U3ddDcgFr4AR10q1/5DbE?=
 =?us-ascii?Q?urD3IN8q71k0giBRKU8FhxKdpN3kUU294xZupZczWNnmQKcG3Z3eQ57lkz9d?=
 =?us-ascii?Q?zZuc3b819b1JErCiZv0J2Qd4BMoTU2ZWrGNFD1H/8V7ah437Aa7AeV9y2Wu9?=
 =?us-ascii?Q?K5p3sM0HB0Twonzte5BwoIP1YSu1f2f5Cdhqd255AKZ0KhKmZtuhsQ3wApTX?=
 =?us-ascii?Q?tJqydExojlyH4lmsB+zG+6M/ckd3CMV/hRJPtFktIVJHwr2xLcw1NkWBBK5v?=
 =?us-ascii?Q?/dXbk6Q5K3Iryzvpylq/gQ0WJVLqpq0t8fKu41/tffFqCIg7GmhlwS4MJt4U?=
 =?us-ascii?Q?HwdSpdc1pSvZWNafo6+VIpJjPz35JaXxk1/J3AnjzkPQ58qM8f08/61WyLlG?=
 =?us-ascii?Q?yuV5mM85vd4DhIN2yAAzX7EFftwMRZ6iJVBs0EQ29Gl4uj/fACQ9pwKgz6eg?=
 =?us-ascii?Q?Pm0cPQipBnXC4RAscbj7GxPgZmTXyr4GjSVuDsdqgZvOK6TJqRw4U5Q9QlO7?=
 =?us-ascii?Q?0jdfj5MDiM8p879J3aOaIjiXXQBRrS9yc5CC4vbGgpjrFDy1C/qPsrug50zc?=
 =?us-ascii?Q?Mshi2ZvEDdnxRxUczQG+q8T/VKfaC8rNlYM7dC0Gg9nOPkLXU+ERwlLDe8/G?=
 =?us-ascii?Q?0GXzrsRTuiu82eiDEELiQLW/5IwWaXmMMmQi/4jW4n9TZD9iB4LKDfx1Zdy2?=
 =?us-ascii?Q?ewPBPrRq/5Whwc5+fQBwkrrL54Zd/NozNITWuDAcT/9aChU2UwbEGghF3JPA?=
 =?us-ascii?Q?HiLlAkvcVcHgogOTWwI9BwfXIv3GxbBbpCyNX5rEjPq3c6elI1bGXWX+wZLN?=
 =?us-ascii?Q?rDgxZ0zvsVyNuD83sH7k5/Jl448QT1/2x0KRHyeVheiLT3MIvklkrSWMP7En?=
 =?us-ascii?Q?onWdAp1ez8swCkrIyry/KoRuk76nXpuyJSta2lDYn0ysXNaXc3J9iot1qzsv?=
 =?us-ascii?Q?q1cZffXpe3aYsrdu2R9AOdx7UwWx4E8ijqNeiqNKX9a5JffSfqcZf0Zu7cdQ?=
 =?us-ascii?Q?EFQ6SPXA/Qcf5dEzGACzSR3WPLaueAjdG5h4GJKk2yckkX3WtePp0qGE1RSr?=
 =?us-ascii?Q?yPy+yycm7A9kDujk4P5t9+WR7oMt1gg2Hp8LMNT1upDfamaaA9Vrvqv1cmDz?=
 =?us-ascii?Q?DgNpwKci91XHUF2ZVMCPjYafqrTG+9US/MDu1OZRgUcfHnaiA/9aSJi+rhaz?=
 =?us-ascii?Q?XWqTD98pPtqG5kKwFkJl2iRr3XfvsTZ3opc4elTkT8ovPI2XUF4qSkVszCen?=
 =?us-ascii?Q?LTMSCh/nuaYP3sOKCGAsukgSai69DV0GcbpjBvY0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadb9b80-c0c8-4952-a8e2-08ddae96bc8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:34:18.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJTH1D9/wKVpZqO5lMYhJpV7Wsm/YVmlztENZySHHUEXGlVZQYuyg3QqIy6r4yf6NShB6JdZICv4OSOsO6a10g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342

On Wed, Jun 18, 2025 at 10:41:13AM +0800, Richard Zhu wrote:
> Add a quirk flag(QUIRK_NOL2POLL_IN_PM) for i.MX7D PCIe. Don't poll the
> LTSSM states after issuing the PME_Turn_Off message.

s/issuing/issue

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

This patch should after

PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend

Frank
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 8b7daaf36fef..f084a9ad1001 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1851,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
>  		.core_reset = imx7d_pcie_core_reset,
> +		.quirk = QUIRK_NOL2POLL_IN_PM,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> --
> 2.37.1
>

