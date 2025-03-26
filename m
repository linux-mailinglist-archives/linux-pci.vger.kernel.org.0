Return-Path: <linux-pci+bounces-24777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D0A719C1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 16:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C66A3BFAD9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6422615;
	Wed, 26 Mar 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIBJfaPg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B473D6F;
	Wed, 26 Mar 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001214; cv=fail; b=pxkrGe0Tco0m1uJ1D6T81HYVP2Vq/TnIRBPQRoI4l67QJiDBCl+3zoepJLuqUgO1YaqKmQJutWZHOkN2AvYSvwpr9icG1S+lwioKhyR8NRL8NSyBxafBvfxy/IuphTHLXN739o1PDAWS92P9b8I4uZOd7B4EYncC17kdY+EBY+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001214; c=relaxed/simple;
	bh=TsJg1fZCPvDQDdEnpD4ThsMTm+DPcOkS4exCRieA7+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tbhC9rsBkRpBWYaJRu2CQi+JeOut//IO6k9p58+qJf9P24Zpe9Kol6C+Ay+GPPhqDBruJh8ce+F0inzbvlghtsT1xmLeus578NMsWUlNrH1OFNpStLr/rNe3dGauJ/4H6soN+SOhS2eg9sSxiyNzD+/u8FZkSlJtM8TdUK48yYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GIBJfaPg; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olpuvxPcM5oERN5NQnG7zZPYy+Rc8PFRbuETVY/8tSN9018gFrWMV/wApJ4L8SjxqvW7CT7/bKQr/MW96ipzsg8FggYThs0DUAwc0wY1A/fUKjjLJg1WQVQ7PStVsXGAQ+/QPcgwpN4LDr/jeuK8PhPcrmQp/ELQuL18deKaoTQWWvRDkaBYG0KMnDlTnsw5vx28Zt/9tVSYIYGMp8zP1N5Km/ODCGhS6cD76qHEkjcebDSOwOdMMnDkIXtqyeHanuiVI9IvgWemOVZU6fjWuUBH05H4L6JUUuFRwsSO38UBQf9CY43qKEXoIBFFIgDB/j9S7/6BCFOdpKi6ghLSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbhykBVffZ9GPRzqw38C6O44BTL4036PFafeQF/sJmA=;
 b=ks/lRtNqyzt2GPAREBbLX9nFUOQAxFiNMNIkNscBZrZlrlCVRbyw0IOzIzzDH+E8xc3a8scIka9YnUX1iMWPI2F1iyYq5t4eTXOqArn3IBCi89lUHetNTrZLgmpYjanPj5vWQXmyqPD6oNOlkjP65lE+lTq4RLBwIoTKDU+vSa+kgAPxDKFzYJZTYuT5eE3AjXEF/EcGk2xmRMOXabzzU1FIldu1XeBy4B2X120Z5gmvRdENRtIbwThZgMAonPgPmpQNnj9msoMAEW+FeYxOyhWmk6vaoqZ4YhbPS5miCqclE9dwME3MZ7eSJ6dJHe3aHu/s36ccUkSJ4z16RXI35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbhykBVffZ9GPRzqw38C6O44BTL4036PFafeQF/sJmA=;
 b=GIBJfaPg59xsCWLae++jU8c3eIC1wHvwAn1QRnL8o2jVeeZ5osHZ+Zn702P6yBGJg8ejcAjHRaeC4mCu4X+kAmArgaTps8n9RerSY9jhb2smtdtmUC38zHfwfre1GeAOE0+og94FfYozTzUkV3AV6Nbx2Jv0YBk7San04iFxSZCieDZxH8tXhLJl0bthD5oorSsH9PqKq7ih1hqJZARLdSkraNmWsEatcqLfez5dnV++34tS5jbxIeT1hB0w9SzJm8MOjGrZ1o4USAP1sZanm5sdS8xCyvkJqPOVthW3W98Hq6BMiZMl6iZNgnjWg1SRAuPVEP1dlAHFIXpyMFjp1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10036.eurprd04.prod.outlook.com (2603:10a6:10:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:00:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 15:00:08 +0000
Date: Wed, 26 Mar 2025 11:00:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] PCI: imx6: Save and restore the LUT setting for
 i.MX95 PCIe
Message-ID: <Z+QWcMIH93mew5Al@lizhi-Precision-Tower-5810>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
 <20250326075915.4073725-7-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326075915.4073725-7-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH1PEPF000132EE.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10036:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f53289-f66f-4ac1-0df1-08dd6c76e661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Xm353c7GRBHcXYLQRgiT3kxBWLgq2FS+AWgcwQBZQNk2wE2+v72FDpq6bg9?=
 =?us-ascii?Q?gny1nR6x3F+VAZFzKGc892Gpz6qoqUj6F5REDbq3wH+87hQDTNaCSvNeG/sR?=
 =?us-ascii?Q?u5933PqJeHqlJIQpe4aaZaEuD5WcV1IWwoNoWdVRjvr8xOOkOmApT8zpf4jM?=
 =?us-ascii?Q?k76MKmTrwzFMncq2L+cbXg7mkb1Q1RaexdXYcEl27F1HZtYEm8yBxaFHjGlW?=
 =?us-ascii?Q?krJDwhikVRiCkRroHaOlId5XVZrafYyCgxFH7ZeebUOJdqkEyslltPehh01R?=
 =?us-ascii?Q?XtDWyNPTZqFxk4y8Q7yqCOHQx+lGyUDelslbGZb+3k2M7VZVF+rd1imE5Q3N?=
 =?us-ascii?Q?/2Xp9k5d7Pas5a/Mzk/1QyYA90mR0jqXRnRcsgBdgzhZEOADobaxX68Fsl/e?=
 =?us-ascii?Q?7DfDcgzBRJQfUjzyX5AvSSJWB0r4/MfvpiQiyHDDAZZ8ixec7kbFQaPoM/Um?=
 =?us-ascii?Q?6jBlOngsMHleDAU5AqOpfirbnYxHI6rYjQazGq+XsLuhy8kXPXy7QOH8v61C?=
 =?us-ascii?Q?lXG6xzxFQAPn1LAQ7wu0Yan7LF+j0RUHDRlMDBMIUmx03lkViELPwkHsPMk5?=
 =?us-ascii?Q?a8WMOEFXisRDqokoiv0W/L8z1cvbCL697Kz05euX3tkRHrOhL7szi7izLB1M?=
 =?us-ascii?Q?ySBKEbMT27FJh3AEYuCchsapC2R5yqM5xke26Cho8eXd7oYM3LpbSrZTSBcy?=
 =?us-ascii?Q?dxjbFySxQwjT8+xVnbYn0OdKP36qifAozS2351BdMeWXznXsYOumtMyTGI6d?=
 =?us-ascii?Q?vMxJD1Hv3gwHS7HHYGqvtz4PfW/GZGsM4DJ9sVLHbIRUDkbxk5wC17axFoGW?=
 =?us-ascii?Q?nE9qO/SQa5NeO9KfICb+pLfSbRy/EH5fYuiLeM91kHS6huBHcKm9bJG7+QoX?=
 =?us-ascii?Q?DjELi+csSSP0CFdugEADwOXYM8LhL/lSphi1cxvNuFNIiQT5GmS4005bV+UH?=
 =?us-ascii?Q?2tgfDt29/+bYkctUjGjoNgM0BfeL5d5AVv7NRWL37wGTP7z1wJpFt0PYn9dj?=
 =?us-ascii?Q?hsBakSgJ2flufhJBJ7mNFuNSQnja90wnJIZOw4LkWt12VWkhClQtz7fQKVhY?=
 =?us-ascii?Q?2EwS70rWL+FzPB/Zl/us7Raoo8hvscDTKWNdczgypFF8Id2+nUyABClke7G9?=
 =?us-ascii?Q?ZhZXdo9Cer+QcnRNHQ96pxf3TTV4yi1afy4LOEhvk9+mhW35ntKvtBSwb6NE?=
 =?us-ascii?Q?lowRLeJe0rphIneaH5G5+dRT9sUGXpQ1F8bL/c5LGojRC7FqtHa09mYa5IUy?=
 =?us-ascii?Q?k4UUu5rIGhwqRMO/O0OLbLVapN9MlMNfaQdyHXrnqLOdO4dELzsodF81U4W/?=
 =?us-ascii?Q?a96tmT2qz3NiISuudRj3avk/pNiuldUKzTdZjhIegeMjUIJ3uw4f2VFzS1ZO?=
 =?us-ascii?Q?X9a9FcoIw3nPqD4Sa4oheWIcXZEP1JMRO5BNYG19qHqFp7Yqs/WPvuhISFJl?=
 =?us-ascii?Q?pYbQoZdCPwFHU4cUIfAzU7b/OAxOfumS8azMmZ5thcciexRStg172aQWDH7u?=
 =?us-ascii?Q?eePe7pwjyURt2N4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qr+FK3CD8y9yCJZwvpCj9gOuZGjmsh0x81IXi4AcXk134/mz4xOG462k7XPl?=
 =?us-ascii?Q?xd07WbfBk01mkhZ5m5pb83Smc39Sh2bzc1SXNZhNK+VglxIjdJ8HjOcwWOys?=
 =?us-ascii?Q?zZ2EwSrEgpHxDidD9RqMP1Ua4kR2/P+hykJ/prSWLpaDCuaOecBoRa2jArd7?=
 =?us-ascii?Q?oHkuUbjhTPIVxr/gwpvhFz95nVOAacfxEF/dge08sLvUGxNIHsT4VOTyYJyz?=
 =?us-ascii?Q?lIBzMbLbNGtt1tYcAvcU2wDzOPhQc1dTPq83AcxeMvlANq/ZnqTUb7AbKGJJ?=
 =?us-ascii?Q?c/Iv3V7PrOfyaEmRbBpbJTQ2JSRnI8s1plXoyYA9Xv2k/36YGEOogpSb8Wgo?=
 =?us-ascii?Q?PYQjR0GOXyWvAq/0510OqdbyGVjrG/80c+YtKxppf/XPUlLYK/mTPIVlC4Y1?=
 =?us-ascii?Q?jV4LE395OOgI8dThGYZnMoNKwC9IZKGvjKusJjDlSqM91d/eRtGxSYH+VRTc?=
 =?us-ascii?Q?E4wGAAZpsuCErji2j0DjVJWIP1hcVwOYd49ViX3c8QEQSCwlOe+hDMkkXVEj?=
 =?us-ascii?Q?gTTzKegDMJ784Q4qkmwzeWiIkHUL/sNvVmT3XUSNM6hOOPR2SM1JzBpfzfgR?=
 =?us-ascii?Q?k76a9OGrzmbNz7B1en7KsButS2JYEnK4kPX+kUaoUglP28pciCnTYBS+Fx4o?=
 =?us-ascii?Q?xHcTnyuyWP7zYtXU4wgMNPWSJdf9l4q8Q3G77PCGqJgRMh/WcqksgjttVCYf?=
 =?us-ascii?Q?VztwV3cIVk4DXm05OgdrTi2KDl7uYTpkb7hdkg7lm3JvPeAZQVy4uLb+S7nI?=
 =?us-ascii?Q?/C2yhCWMqWkZZk/ZVXnL5/pCv/P1UFqN1qMZyhcJi+PDmjUx87vJy4E2YYIt?=
 =?us-ascii?Q?WoHBe+m9Y5UGaiV9T/jFba0iCgBeZBvZ6rBM1ZWCSu0NmkLvz9RUF5sp4u11?=
 =?us-ascii?Q?qGXsJf+B7M+FCxgEt/Mmycob3pj5QV6HoDrTYvQMiJR6Zvl73Gpin1QUQKLQ?=
 =?us-ascii?Q?RBWd04Dk+l4ecTEJHOFuTpT56DksVseFEx7+SQHzx5964UqQyl4T/ORqKZfP?=
 =?us-ascii?Q?HsmxzPKEVVe3bIVR8sWJ5NVfiGdoEnPI2Rmr9i2RJ6UD3PsuyMxN04cTdbyl?=
 =?us-ascii?Q?kHm0M8KyihOevoTYmYXjDMXpbTBrkn97ymJpNQUELFYN1kJMSMk0KsjoWQQ7?=
 =?us-ascii?Q?5EI83xHUsEWg5Zhnvvc/sA44GOo0uatn+qZKlGnSoxi3NHIxNPOW90t/PtqK?=
 =?us-ascii?Q?6qcdswz8wqTpsE2ziSCbz0EVT5Q1wUcnglpCe2eFc3BvpKnqpJT2Xo0RjzAK?=
 =?us-ascii?Q?7Ue5pzlh8mjM/Qf8/LLZduOKf7tygVO5Kid19yqFTQomD0CDI3Q9j0UWFigI?=
 =?us-ascii?Q?bfoogrOs0i2fArC4XV3A0vmfoLK29/FnOdOhfzL3Lis6QUp5fTaK51/LxVKM?=
 =?us-ascii?Q?G1jaT7Ar7TbafjxpvY7BVg1VXjlE8KoU7/zenGyFAvhHLNmwtb/xwJPJYqVc?=
 =?us-ascii?Q?VOxpN2dz2lwPXD4MO1wuipMaT2IomuhNGRvPAs0yc/L4i/FKKqZXUajsrWSp?=
 =?us-ascii?Q?qvyDrvAYSRW1SET4HcSfFVkfFgJShTo2U4REEXUAFG3/0mmhVGsBD/YH1iGo?=
 =?us-ascii?Q?y4YA92EYDOfrkLppKmWOXCFBVtol2iK0EdT2EyYB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f53289-f66f-4ac1-0df1-08dd6c76e661
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 15:00:08.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3YkIs/WUUAJUXKrNEajebrGm+xhE7C2Cu/YNEvaRVaO7QPx/+duQ+ftBIg5wsq1yDpKdYpX7G6tQP0qwByjCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10036

On Wed, Mar 26, 2025 at 03:59:15PM +0800, Richard Zhu wrote:
> LUT(look up table) setting would be lost during PCIe suspend on i.MX95.

The look up table (LUT) ...

>
> To let i.MX95 PCIe PM work fine, save and restore the LUT setting in
> suspend and resume operations.

To ensure proper functionality after resume, save and restore ...

Frank

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1c8834fbcfd5..dc98a04c2956 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -137,6 +137,11 @@ struct imx_pcie_drvdata {
>  	const struct dw_pcie_host_ops *ops;
>  };
>
> +struct imx_lut_data {
> +	u32 data1;
> +	u32 data2;
> +};
> +
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
>  	struct gpio_desc	*reset_gpiod;
> @@ -156,6 +161,8 @@ struct imx_pcie {
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
>
> +	/* LUT data for pcie */
> +	struct imx_lut_data	luts[IMX95_MAX_LUT];
>  	/* power domain for pcie */
>  	struct device		*pd_pcie;
>  	/* power domain for pcie phy */
> @@ -1507,6 +1514,42 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
>  	}
>  }
>
> +static void imx_pcie_lut_save(struct imx_pcie *imx_pcie)
> +{
> +	u32 data1, data2;
> +	int i;
> +
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL,
> +			     IMX95_PEO_LUT_RWA | i);
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> +		if (data1 & IMX95_PE0_LUT_VLD) {
> +			imx_pcie->luts[i].data1 = data1;
> +			imx_pcie->luts[i].data2 = data2;
> +		} else {
> +			imx_pcie->luts[i].data1 = 0;
> +			imx_pcie->luts[i].data2 = 0;
> +		}
> +	}
> +}
> +
> +static void imx_pcie_lut_restore(struct imx_pcie *imx_pcie)
> +{
> +	int i;
> +
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
> +			continue;
> +
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
> +			     imx_pcie->luts[i].data1);
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
> +			     imx_pcie->luts[i].data2);
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> +	}
> +}
> +
>  static int imx_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> @@ -1515,6 +1558,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
>  		return 0;
>
>  	imx_pcie_msi_save_restore(imx_pcie, true);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_save(imx_pcie);
>  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
>  		/*
>  		 * The minimum for a workaround would be to set PERST# and to
> @@ -1559,6 +1604,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  		if (ret)
>  			return ret;
>  	}
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_restore(imx_pcie);
>  	imx_pcie_msi_save_restore(imx_pcie, false);
>
>  	return 0;
> --
> 2.37.1
>

