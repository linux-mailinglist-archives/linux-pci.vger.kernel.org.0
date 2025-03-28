Return-Path: <linux-pci+bounces-24950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C33A74D11
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9A81632A7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD1157E6B;
	Fri, 28 Mar 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQXn33nR"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012010.outbound.protection.outlook.com [52.101.71.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6984B5AE;
	Fri, 28 Mar 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173237; cv=fail; b=KLl+u8YlyPym7TAH7lmaQROcRt3SwmNVTHVx7ikndnq3qQBZxvY0P4IQuLdknHM61942IuoeorGfB+gxuyqdlIOshb3HpOnTB98HuZMVTyYMaxKaavekZEHty+SmODVeaF016rx9LuQrc/AxKVLbtQH+Jg4d6mafQDxnlt92n1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173237; c=relaxed/simple;
	bh=Byjy92iWEwzO6rmAHQOnBa6wnRwN0pm2TD8etgwOR3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxiE03Nb0RZ2XThXFhYdvHiZ1eHtDpwRSP2VUStxm11SDL2QE+Hv1B3u0Ui3c1eFdA/+TiGFyMmzl59ZJQ7IaYuEDHF4lo8JY4dJjFeg5Sk0aqGWftcGQ3tJHuU2OiaspjckIiYk+KQEd795F0GaVTqL/pwagHY6gzK7kAFJSEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQXn33nR; arc=fail smtp.client-ip=52.101.71.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nuge7WeaHb+hjuRyo4mbuURBkzbntReKd1ZeC+J1n8qA6dp77CiLcFQX0LhGE0tpcK65hlkqGHdSxjGKRFndD7Cz8gYbH/a20aXdS/8B9kYiRmSnYHMpxiXZqS8IXyw3VjALTiUufJtZ1mFlUllC04EUIYqZ3ZTn6n28LxbLRZkDO0xOkVcwOV80Fjc8eawqjA72JSR+6xs+XlVM0FgSwE54cg5wFzoxcZa4HmLPrc2VT/fIkzK+yi/SFdYra2KjOpoeE59/ddPXxmLnmLSGbhvUAmht+PCAYIkOCPECnKexHGjIx5VZSQYacsU05PokXTBXzIGsHDz6xrN6lkm70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktZhJASY3Bmjxjrq8qUmB8aqIVCn0jPRenbvl4WejPo=;
 b=OFc4t5xEDiOhkJ7a2tZ3TpVGJS0j+z+6IgO8md8Ht4bmSVUhosJuk96LPhr84m2aj+eIsj57QfGvAIDPDpXTbEoTKfrplo/BTKEe+1HT1uv4hXR9IHEYiCYuj5Lmh1uLhxptmRqYg/Q0P/FnKIoyxGkcz14WR/KWUeO5DzGDGM2iNhaYPhApUc6nUgWMUrNiAANEncrtDCK+Eg+MosvI87YK9qHG7vWKO0bpZn+pjR2MMNKLc1DKpW50WY6NPXP8DuhhG14wve2W69bJkIAMh5x5XnnUZb0FnzOEkhS3kkmszVbuhqHWrOjgY+DLp0oePwbQUhetxr/t7X2ixMpbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktZhJASY3Bmjxjrq8qUmB8aqIVCn0jPRenbvl4WejPo=;
 b=eQXn33nRLoM5cVTLROcadkXO55pazMoF3jlcEDvpSIIRrFGCsc8C+2Kg2g4x8ZnVkMV2WmvDnlnBDoimuQqueUl7F7l5H7PD2vdGZxW4dKjz5r6dmpFlS+nr6P4bW0X43HtmZj2Gnnj+f6ai6twC1tgmkOlmT279yKFYN/fzSwEYQv/jOj+D6sRL3yi6rtYiNPVAB2MYIHlSNc1fWm8kTtX8u8ksZ29qn5Q08XhhCXjlGHbc36SdHVXNCf6VHK+equSRS6RRnnTNNUuR+y2QUOWPtaDLfrCSMrNbQx8bWSu920z/LN4BynsNn3lBb2005KVW2hb838ieDhuY7a8y1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Fri, 28 Mar
 2025 14:47:12 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:47:12 +0000
Date: Fri, 28 Mar 2025 10:47:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] PCI: imx6: Start link directly when workaround is
 not required
Message-ID: <Z+a2Z0X9hZ5CDvsA@lizhi-Precision-Tower-5810>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328030213.1650990-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 93779f73-7b1b-4060-e905-08dd6e076c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSN7uql7dswu5q6OtbpfuWaIQJWru6iCweK1Mtuc8FTN7F4DMMOHTlsdVsYe?=
 =?us-ascii?Q?5gGJ3s3Wtbz5vI4Ib5R6fZn82ojaupi5OyIQcLD566WFrsyrSoDYIpJdbNim?=
 =?us-ascii?Q?qNCMlR7T7tw9SbnSCbpr0BfojJgRCi//Hk3nYL7/dJU/Gjap50eeQ/vpWNVK?=
 =?us-ascii?Q?G7EiIPCMgPuWjsBve4hULAJtpqicP3LPwCKkylS5F3srPB7hAIII9HUxygUb?=
 =?us-ascii?Q?W6M8QNLO4Zb98ujVpQfLxgL6y6nS6bBYbOLImXyY1ahOdMTlY803XI+X2qjK?=
 =?us-ascii?Q?w4aFB87NbH7ZYyf/rFtnnxMdnHGr+ds8fguu0pyzDtVyT71OIiPbGCPysbXp?=
 =?us-ascii?Q?xyXg6v22lnBJ3dXQpRgXliQ0bqgRPYkSaEuW37xUojEeYW6kroXivKIBACL/?=
 =?us-ascii?Q?ghpefAjuypLqgcezHntuy1nP67YV/fDiG3x+/j0fgYf+2kpO65jJGguicrvm?=
 =?us-ascii?Q?UFXQap9SKU4wlv+iZrRUt/EzzdTxaSXEF62KXtP2gcS4KponO7tQGfWBDMHj?=
 =?us-ascii?Q?atpfnA7Ildp65tB2euQdGH0jEvz3R3D4BbAGoePBAcc4/3mDEXvQ+rWJgXs6?=
 =?us-ascii?Q?Udq+jfs+cVN4OulMlGhYworO/Y9e6F1b3NrgYFfr2tOCxCXIL45riNDucTHP?=
 =?us-ascii?Q?1j3SMMo55Y9I4mWbf/lHeMNcxf7jokCjzAyvZMV7IURj5U89T2b4X+ngH6zj?=
 =?us-ascii?Q?IvuvGDdSSwRgpGzp5zXbJs2aKP9jsyeYfza9URg61m7ReKtLVkycCGH7yD/w?=
 =?us-ascii?Q?ZyC+ad3O288OZXn+DmhpHINa5HCgqL/y4xbrpm5I1UehcclZrVgyRMsZrLy+?=
 =?us-ascii?Q?+cXWd9Wy7ThhQ1vZc2ggIRpr2pvsTNb/gh1peEMjE9ewzV8Ud6oqp2goxkGl?=
 =?us-ascii?Q?h6bHhJ1R4lKbudfdHhU4qSA9/oTZe0JF9chWPSWkg2kazGZtBzF9E6+Y86oO?=
 =?us-ascii?Q?vJ+zUKVbdY+23b3ehCdUElM/0jcWboe1ep4ZMtqimlLtlUq8WkeVTTdPulkZ?=
 =?us-ascii?Q?fQasiB3C2hh3tTNEf3xse+VpfmmPfDzeroRS8x6N+9TYFnMgvejK2qFaIvzR?=
 =?us-ascii?Q?Xdapu5/FIvKWe8Ael6j/FPlUyAj8ISa3elghMHvPWLvNwV0vtDUNI2b7eG2L?=
 =?us-ascii?Q?XIyoUZTHHLXh+H2G2ebtJ1WG5qFVYgPwuhK1ZKixWji4Tddm+4rnTA69Dsgl?=
 =?us-ascii?Q?evzL70Vxo2gA0tBfXb9EsutqchqR8SP80nzJ8ebtsxZTJlGhAjYngUtplMY+?=
 =?us-ascii?Q?xwuE1YyAq1oWl+MN8yqAeHkxl3p2DjR2V+RQjvCZXW4mZP1XD3pA72vmRXor?=
 =?us-ascii?Q?5TFVnZA/GZmfiDvcR5NVmUT/KHImJfQMcb/dvZz3ZRQ0Prs9bEoLLfk8mc8h?=
 =?us-ascii?Q?lFaa1ez7Hn+PQNmVTQfpLhL3lV1kSmtgNDJgDlq5Xc/N2o1sAoiZTWNI1Cld?=
 =?us-ascii?Q?C2nF3dXhuyhb5Q75p8cvjBl46CJQyOp+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T1IBd06EuoAC+JzE1BqVraRyFOQzzHIsqViVSRUDZey0EAtJlD3pCC+2MB2r?=
 =?us-ascii?Q?3BTwDOKZe6ED91OHLPaXqthn+ykIkEA0c4qq6/0IAHieMLOHKfnyGPKn3D09?=
 =?us-ascii?Q?yO+QDiPXPwVcrSopoTt6ImAFATgpwzQbW7RhxqadHiyqkVFGg5VJdYxRuLsT?=
 =?us-ascii?Q?ZA/lVD2yZ0b8wziB7Mio3uISsu/DLqI6cwpca92rXRa2VvfW7uGDuQYRO3ea?=
 =?us-ascii?Q?riYUgO/YI/fw9elM1Qpaiqo7aS64nOrlvaLp3CFVZ7UOthEzFYz9wWX0hcpM?=
 =?us-ascii?Q?BsowDJk3ubI0vZ0FpHQLqcF08ShGOSAKgPTWWFt+pedE8kEBvek58zfyaCMK?=
 =?us-ascii?Q?o1Gr0Ba7hR7vadkWjNkXvMFd1BXnS0oSVT1GnVG0vXJJ0V04QQWJPxtBWZ9l?=
 =?us-ascii?Q?IruMsl/hbs0IhpgC9qV8kRFES3AlA0pp3M3gZ69IOAnMXj5O1udLtd+cHjpi?=
 =?us-ascii?Q?AyPk/TvNZ3Tj9e9y+xJXMyBtgCKKLwHTIwJOGGZqwW8V0vasXffAcVTEYc6d?=
 =?us-ascii?Q?9G4BfaxOS6X+rf+E6xzwxsdEB5GtJdxBzIxMUT5N/tuJHwHdC7wlzGz90mti?=
 =?us-ascii?Q?2AZxXsjW1OYXe1WJOyLfZjunC1mPwV+sgIJk+nIt8jz3vKeEGM772ZXrHv4r?=
 =?us-ascii?Q?5yT2ZakAQaZV2+7rH5WGYM8ZueqkRfJjpBUOAJ41KieSI6TMu7OH36Y2lDDz?=
 =?us-ascii?Q?cwlD+od5z+giES+PIDYC4a2KgdGQgsDjPtgOMc2g7AjiJ9b3WNSrQbNDVybn?=
 =?us-ascii?Q?eOCISKT02EUwt+kkkcDalHN70HwjOHgSbNRzwCc/GTytRoQaJZ1q9x0EEcnX?=
 =?us-ascii?Q?vrrNRR3Nx9xkKwqzj1VQhmeMzKsPiq0b40yvcdmaj/9ooq9A8VZpBSae/32H?=
 =?us-ascii?Q?kAxd5MWlbY2y6dOZgKO1uPqKHCkJiaHHWB6NE1s+8zQtFVCeO0BoPReYpbVg?=
 =?us-ascii?Q?2Kjy+9zFLmnXZVfiEIRtVxjtUAU/kLTbKg9B9wy3SzdqC79NDIS5Pgt/SFXz?=
 =?us-ascii?Q?/IoYSJ9IDzjXqiPCAarLH6i92qzew6GdyHTAZMYC0DjaWpEqtQw0pEwUogxG?=
 =?us-ascii?Q?QHNg79YPO5Q25LsV+zMaaPLcCdXSRUtXsrrAKzVlIRMhygXdckM/ptx2M0BK?=
 =?us-ascii?Q?4zBS2219azM4fZ3Ths/lHU0Ofk4Xx1CcxAZHiYYJ8ZDZvWqRusmEQ56j2Yag?=
 =?us-ascii?Q?WtyN+WeNxfo0xTlS5LCcS89YAEijgbVhzKfh+48JHKGwLjivD9qw+eWgXqwU?=
 =?us-ascii?Q?5bEK4vvXguy6SK8DVAHltasJqwKws3AJbfKE1Om6Nrt2vlsPCyuize7FFGCV?=
 =?us-ascii?Q?QJqyXlCz+8QiyR3+s+vbD5+B3fLV8VrFjejxvTRq61dfoABNW0ex11Qh3Nfx?=
 =?us-ascii?Q?eh8VrYJJN+2lQsDGV6WlKEtFIU8kiwQnxodJCDH8KhzWX7otIwHmeX7HEX4h?=
 =?us-ascii?Q?1KMqnSnhwio2pVa6kPLLuu8yXbZ02sIgmLcQXdq+GLdi1MHBBMQVLYJavmh7?=
 =?us-ascii?Q?ZucSs2jxw6Kfj1bZVjLpWxCujbzkhCZiMOBgsnFY8H8FSOPPLUnGWsYYCQbp?=
 =?us-ascii?Q?0BkNo6rz4Z+r7uNhAqzHAJQYnlEp72oE7FC657U2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93779f73-7b1b-4060-e905-08dd6e076c55
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:47:12.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L84+g43BZRAYdD38b1pQC/zTZDGDtWBuTz/M4rKU4xfHR+UizaxGPdnZ9Ll2T1VDUOrslI2x0+G1GLrnbgVRWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

On Fri, Mar 28, 2025 at 11:02:08AM +0800, Richard Zhu wrote:
> The current link setup procedure is one workaround to detect the device
> behind PCIe switches on some i.MX6 platforms.
>
> To describe more accurately, change the flag name from
> IMX_PCIE_FLAG_IMX_SPEED_CHANGE to IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND.
>
> Start PCIe link directly when this flag is not set on i.MX7 or later
> platforms to simple and speed up link training.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++----------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c1f7904e3600..57aa777231ae 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -91,7 +91,7 @@ enum imx_pcie_variants {
>  };
>
>  #define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
> -#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
> +#define IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND	BIT(1)
>  #define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
>  #define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
>  #define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> @@ -860,6 +860,12 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	u32 tmp;
>  	int ret;
>
> +	if (!(imx_pcie->drvdata->flags &
> +	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
> +		imx_pcie_ltssm_enable(dev);
> +		return 0;
> +	}
> +
>  	/*
>  	 * Force Gen1 operation when starting the link.  In case the link is
>  	 * started in Gen2 mode, there is a possibility the devices on the
> @@ -896,22 +902,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>
> -		if (imx_pcie->drvdata->flags &
> -		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
> -
> -			/*
> -			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
> -			 * from i.MX6 family when no link speed transition
> -			 * occurs and we go Gen1 -> yep, Gen1. The difference
> -			 * is that, in such case, it will not be cleared by HW
> -			 * which will cause the following code to report false
> -			 * failure.
> -			 */
> -			ret = imx_pcie_wait_for_speed_change(imx_pcie);
> -			if (ret) {
> -				dev_err(dev, "Failed to bring link up!\n");
> -				goto err_reset_phy;
> -			}
> +		ret = imx_pcie_wait_for_speed_change(imx_pcie);
> +		if (ret) {
> +			dev_err(dev, "Failed to bring link up!\n");
> +			goto err_reset_phy;
>  		}
>
>  		/* Make sure link training is finished as well! */
> @@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
> @@ -1681,7 +1675,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
> @@ -1696,7 +1690,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> --
> 2.37.1
>

