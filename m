Return-Path: <linux-pci+bounces-29102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61227AD0531
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76BE3B0BDE
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380F76026;
	Fri,  6 Jun 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DcJWtOcZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C914F104;
	Fri,  6 Jun 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223817; cv=fail; b=WEvaQ+kPsRXX2Awda1etMuFaknqM/GxCJAIms4ZslNwDiG2G37CKUJo96oMDmTLSaBh3h8aee6MBZbFApRot5GLv6AEf4LlxUgnOW92Z4taPK/Yv47Km5HjiZ7OWO4XjZbGccfpbOCH4UfJQRlmiuEMtGjTRf0nu7UWI6iGhe8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223817; c=relaxed/simple;
	bh=Lje4wNRKgwb25qGrm7iajkZCikV8+VEzDk5D4QEmC5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yq6mGzsnEO5Z7/7uBdVa6sHPCsjU3rN9EB+XcXn4NunULHebctkctKBbbD2kp77D/6vhsbpbcJvkrIS4D1BxgMHWjfMWS/frMroNOIMzjMpyzwM1UMphVHcLauz8D1Iax0AdWIg2wavj1ukYK8YyfbqfXQSjvsn9gqyZcQTNiCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DcJWtOcZ; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtMaMVHUiYbTw/nGHxgepY2mlyyQQRXXOT3q1PUhnVA3ML5fZff2TYseeGAxaxKL5LBuRBVhxl11QKsatPd/hoaisoR51txmX+GgxVbno5OKzklBryN5lZTGBmkRZKuo32Il9BSKRCZy6UCyUweupUvdr2RVJUcRNd991RsJFOEEuvLTvVRAettW4AEPGP02KueOR5ZmSxDo8O9w0McINGxlDClPLxn53W8RTuWmgQiPNC8fvzdQAv2iuZEnQTODO/TuiYLVoHw8V07bf08VakGjvz1PM5rmyT6HvCopADJSosZPYk/9nMKLIDFnENOh9/w1RIuLZ9UwcFrlc2274w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btl5kK6xryG+Uxq3Mmi9pvnmZdChsjQKfoH5Tqeqjuo=;
 b=l/NDtyDOqj3K+Vh29Sz0kDKwm5zTl10oOR0bLRd9LcUcHnjciZ4gP2Uwdhu1qdRbWr0IlRWiWhh9i28sNtQHJPj4K5QUTr3mP/QyR4qladIHbJbKXZVkqDrqDjOhAdNcbX9Rx/BlBKDX8Z58BTgVs8GctmY8aYQ1n3tyhXVGOEb7aZHYlp4tV1ghcIfNw+sUQGeA7m43xSy6J3G3G7+r5/zzZTspuxOlrYpw4udg+q7ja7FZh0oPOebu5+242QXT3DAgt5Rd3d5TNe2BL8mkIFVvlovOFhZZe4Rv/2BixraXXzZfcQ0YWUQuO9RNJyUTjsxsYtO6XXYbWcqsGuO/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btl5kK6xryG+Uxq3Mmi9pvnmZdChsjQKfoH5Tqeqjuo=;
 b=DcJWtOcZvuKrT79MWv6cBW0kXHByGWU6FbPTv4I+oPchCs647QsaDWtPZwTVDRDUydcNT0v+bUtpiqEX/KZ6dUajw2YPLo7W62A8rJt6isyGzHYG2yp3NUEE/lSHq91x9SBz5hwyDM3CrKxXe5zZSp0olpCfVFN1A97rIUtQRJKJFHYBEjzHz+fzmMc3koMSvyfdDdypjR/8A6TK0mKFJeV/aDKcZlg+ksR9eTpTKOGozGdFBZpUwqAfXjjB+1dlVx9JFZUtB+ReHHeMqFEgjTJ7iReTray3IVt0T+W7RI8soGXcZmXoNXIg00hBwY/lAcbgz7CDaCMWbQqlc472Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10183.eurprd04.prod.outlook.com (2603:10a6:150:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 15:30:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Fri, 6 Jun 2025
 15:30:11 +0000
Date: Fri, 6 Jun 2025 11:30:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Align EP link start behavior with
 documentation
Message-ID: <aEMJeovM0G/+WZo7@lizhi-Precision-Tower-5810>
References: <20250606075729.3855815-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606075729.3855815-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac8f6ed-6193-4fa7-b3c3-08dda50f06cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XSu+coH6gRaN+QSVJ5yFfuetM9CksR6+py5RySV2RCIkuT+lXq5jM40/aljA?=
 =?us-ascii?Q?GLCZ1W25frMU707//FdkO8JlQnGLn6O6aD+6FHdx+PcQvNPY7OfjbGhax4EW?=
 =?us-ascii?Q?LLxOC0mvSOhteSbYHwpfIwG1rJlaigQtLzIy+7AbgVBcbt62BE49+qFKyPGB?=
 =?us-ascii?Q?9WLBUHwJR3sOb8zS+4Xac0N696KG2+Qbl2l2I4GCTsmtkFeL/gyYqopj5dh5?=
 =?us-ascii?Q?D7JVyK4ZZbM79pRlOZip/cMIIrrQISq0ihACP1enYdQDejL1XBit4p59Fm2G?=
 =?us-ascii?Q?GQa/BGllOjMCkcXwf9sIW4Y+QrwM03lMoyfYq1MdPnOnfEFs2QGsZD4TkPgS?=
 =?us-ascii?Q?zLC4drEDxh8P+chCGPerA296R5EpTlQG+Yzs1QnrYqCtL1FxhWys8JpAFJH/?=
 =?us-ascii?Q?S4AdMmn1A9vRpy8PrvXqKSP0I8Du+rTGhksvGzLCTuJslYuylEAZTNBIcYq4?=
 =?us-ascii?Q?gqZH7ZNCmXNCq4TjmGoqlPp9OW4wvcdM72ZVWd/90FGB6wDPhbdF3fN7UQgK?=
 =?us-ascii?Q?9m1J04jdd8p5Zt3ss7TheAkOt6fYTjeAmooD5/937Rvi3Y6Xp97K1IgEw4ok?=
 =?us-ascii?Q?moMj2ScqWMCIEMNWZNBpS/21RJ4UPOjdMz5nTZ9m8qoDUHnBUh00fg60Xb1j?=
 =?us-ascii?Q?QWVqDWxN3g0HRJOCh5CsuxlgZNGmPQu+vA3rn6kxnHM4WMyStgrqh2ojIrWU?=
 =?us-ascii?Q?/YTT09ps3NL+4HHubSTJ+Fftth3Xo+HKgwj+V+f2FIueMPmhQYBT6ipvYYro?=
 =?us-ascii?Q?yedmMgbDg4QXcfVa6nD6Gi9Bmm4UfHLpx4WexW7Ku011bfs0cpoaqUGfLY1h?=
 =?us-ascii?Q?9fGOD6CvR0g28GiUpehTgZmJSM/HzIelr4QCK4/1jlbkdAUZNTrZYTchqNyv?=
 =?us-ascii?Q?ZEq6vPtHvDnlFUue8W6XiwAykpMuhGS9KyjcC/MAILQfHBoeW1+qWmu/NyxU?=
 =?us-ascii?Q?/ggcGwhSclrZcWZQLp2qNhBnAdzaxzIPq6FWXUAyEpOxZmPyjq+kai8pH0ol?=
 =?us-ascii?Q?Hz2GnUegcXBj5aA4S1l5CwCM0QA9s6R4hVuUoMuQYR/So8c/ghSrjOfnvrJL?=
 =?us-ascii?Q?fp/FsXK2Ryx2pFFwo2KXv3QehI2Nse7rXhqd38C7WqjSAbjVeUnLU0+LPFVl?=
 =?us-ascii?Q?iqdCnlMwkOcZV6cxKEs8XKWQm+zkc+l9DKHOqgE2xMWuqHN0G9+nw1CBUizF?=
 =?us-ascii?Q?WdMolDG+A4JjLqn7usEzIqqGtCtTCXyIwi7IIgryrYfaz2AeNWWB3DMQrMN1?=
 =?us-ascii?Q?ietWBnd45wmIh/4mw2vmflZb24R2tdJ3ikHm0gbX9a5gA36tSKCL70lwCsB3?=
 =?us-ascii?Q?TStPn1d/hRKDG44SwXzwYq9gcS19vQxfNQ6W8s/qjRmArNJkV8goN41D5T4t?=
 =?us-ascii?Q?oTLBqdrCz6T/CDIoZ4d4QQfrz7kK9LHSDXiOjrQ7OWivhOg/oP24LHFeXmQ4?=
 =?us-ascii?Q?2ZoTN/Mjei5zznHUv5Sf+Yzk4wvIQTrFAXqISoUUc+91Ah45TNOsZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUdU8SIDhWX+MODtgpvrjp8enHPh9s8V8Lk+ogRhiraE9YtsLU5QXHPmDkvV?=
 =?us-ascii?Q?Hptn5OntMMRFZgLHXUX7FwKWwA+OpZVE3GEQ/fwPnvFXZKnpTnNUEddPQhCU?=
 =?us-ascii?Q?68mXStfcx5pFjKbnZ6bYiC6NG8yg9llmZwJoKhe0u5vhxqYztVK6SXrWOSEX?=
 =?us-ascii?Q?5aZWEQFhNZa19bGMhj8FdZHyjG0GPqj5daFkzW7S11OFsIRAhT+ig683A2Me?=
 =?us-ascii?Q?xpvDIGJc+ebVyXlJOcZBWpAQNh9rML330JOVR95AWSbshgWndZYxQg7zxdTq?=
 =?us-ascii?Q?3ZMPQffSJwvsuBZiUZjLsNbyUByB8qmvsPsQm4OPE6qqFbpDkGj+kd0JGdtX?=
 =?us-ascii?Q?0dbLEtrslT0SDEDGbPJJp2L7TAnmWZUrRV83Bj7W1hPvMyrEy1Lyr+OngUKa?=
 =?us-ascii?Q?MAlNnCO71w7CpQSVz0/GBIOufdHwDDH8yVOrCVO8eBbjDohgHyaqnr9e2b9z?=
 =?us-ascii?Q?riGNgxOpb4lJPlN+zGMEZQ5Td+u8J84z682Mppw0BGVeE/8vTMoQ6JjwcSpy?=
 =?us-ascii?Q?u39pDWcKGI0g813TeAdKwl1v53x5f5W4VRR1WS02DiZNgrmhdzCNfgXSja5V?=
 =?us-ascii?Q?8SQcE/WmlFxqU/EsHFssEH0OoILjUkJYUd2hQyiUgxxJOkH/DLD0ldjBLnsY?=
 =?us-ascii?Q?hRjSkEw/dcd+HoIZmBJ0m+KLuU1rug/51GWh9EHgIKfEwQ/HeI00bh3wjRo2?=
 =?us-ascii?Q?ayrHoWaAon3XgZjfY7zfUBUy1D7SboLqmXmDXFZXFzfGB1cVOZp/Tlr317Md?=
 =?us-ascii?Q?RSdiZgEILFT3ODnMBEQE9axUWAxsw1Clwvp9fxNiRQQbdKTVXshd2eprqbcy?=
 =?us-ascii?Q?+htDPL+HYMMwgz35RPfN0pJD6ryLQMFge8o0fnkdXEQk9lF7MYuVzjvlvMbm?=
 =?us-ascii?Q?5SOf/hDAOH+Zxpk2zip43hU6IcQFmT0AnfqLUnUkiUiJCNIEYXQ/gpAZPMa0?=
 =?us-ascii?Q?yD+/az+TS6EyOCZg4FJmTlFD90X1jaN7R9gjhaS/RFBYZPDp5rD4grfYXJ5s?=
 =?us-ascii?Q?5cQPIeJzRC/7F/wvIR7q1gGEsDLB8iJ3EXFL5LW6zYTAy6tenMiUZyyGrz6v?=
 =?us-ascii?Q?XopKM10fKoTJ64T/vkYp2PG2yF8ttYHY+C0isODZyQx38cHlS0+91AEOaFVL?=
 =?us-ascii?Q?FWrihEH0ivMrxDknzOCPh7G4qftzQDTFg6d6a0jORBUvOR4RxILK3hmw/YuS?=
 =?us-ascii?Q?wJQ0U3MC9VbnunefAbN0BucbpPP9/bldBlFvN88EsNJGbsTC4PgqYn5wlSm1?=
 =?us-ascii?Q?HgvmJO/OAPdoZY4D22Z/gV+xCBcNDF1s2gLs+kwKB+itL1p9tY9f0Bi9HMGN?=
 =?us-ascii?Q?2GQFRBsoDlfp1ocXY7NCFlles6Pqv/adu2AJA0mmE97df4Y183nHze6ZEC9A?=
 =?us-ascii?Q?n34dOu0+0wncC8Lhz/xczYKQI6IyVwYexKCGEYuCyA37bTJD2udMGLlI6gTX?=
 =?us-ascii?Q?XKMsfGFBOVKXjPK5EzTlTkXke/vik+Ju5p/ZFZcaYEQEHxlxJq6NSSIPETK2?=
 =?us-ascii?Q?fIV22la2fQbL/rCi3gNugbv5LQvUWuwuOIJoad5RVpLmuhX4yrHHFWemuTWV?=
 =?us-ascii?Q?6cQf9B7QHvsTSsxMbC8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8f6ed-6193-4fa7-b3c3-08dda50f06cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:30:11.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LJjwITTqIBHUKuMavIdG82PqQUEBGUhHRcxFsU2T9FXXegzQ7/laC+r+pe+NF25iYMPmRURio49zl5Cvs+unw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10183

On Fri, Jun 06, 2025 at 03:57:29PM +0800, Richard Zhu wrote:
> According to PCI/endpoint/pci-endpoint-cfs.rst, the endpoint (EP) should
> only link up after `echo 1 > start` is executed.
>
> To match the documented behavior, do not start the link automatically
> when adding the EP controller. Ensure the LTSSM_EN bit is not asserted
> to 1'b1 by default.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5f267dd261b5..69825e47d2d4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1337,6 +1337,10 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	struct device *dev = pci->dev;
>
>  	imx_pcie_host_init(pp);
> +
> +	/* Make sure that PCIe LTSSM is cleared */
> +	imx_pcie_ltssm_disable(dev);
> +
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>
> @@ -1360,9 +1364,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>
>  	pci_epc_init_notify(ep->epc);
>
> -	/* Start LTSSM. */
> -	imx_pcie_ltssm_enable(dev);
> -
>  	return 0;
>  }
>
> --
> 2.37.1
>

