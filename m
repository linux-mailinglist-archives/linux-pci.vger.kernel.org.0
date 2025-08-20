Return-Path: <linux-pci+bounces-34389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A39B2E103
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F7E1C87DF3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D334575D;
	Wed, 20 Aug 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V+FtvYU+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7A34574D;
	Wed, 20 Aug 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702845; cv=fail; b=LQyU5X5ytKqbXEEW9hqFJo+OQodBqeB1hJ8ONbshW5yDyekdTn5vEn1GzaR8/jYuvXnVXl/2gZh475WgkRXaHOZ85RGj0k1gqQRbiaqz/TYnMbX870twBC2l3ODXbKsHzjXgzFYD4wk12bSDOahBvTQs4qymprS3VDScUAC9mTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702845; c=relaxed/simple;
	bh=Cks1sgGAZWQKoIKEnfVhWXgxAlyGC+3CHrIRQ12XE9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EDhDmmXQZ2fy8mS4LIMTVN/YWVlcbgF+0TjKwT2rCGePLOdx0zlOK8AG0wWnRkU5JK8cnmR1T8TehJkDs5NCKPvvnjfUXXmPCMEzGpFc/JxYRdo9kusV9FcGEFsCmrbTyO0eS2wicnkKvFkvdrLw5COMO0WKeJ7h4LECtB6i8Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V+FtvYU+; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/XsK3AUDZ20rJsg4Il0wkxyjWTFdqGAvz8GVOHH6c3/6VZktspkRxCtfnuoDHKQWW6hb0Ok5R2UMUyiCU83i3fKAWBUFJXsi7Ti+6NrtjZuxePrz7mUz6JKcQ4u5kTZI+VcU3TQsQhPw2jA27ZnVX/gXre2Per0hOd6wEHBHkgVPdzX1aAzKtqHh03TLpGWV+0fF+1q8OeBLNw35nsFWnmi+pdEKfevIPKW1GckS1za7wvccfHchXi6qOcCpEu5dH2pDQ8x/UhXNvBQCxbdo5SGcla67ygdxAkKQie75bP+AFjs9dbZYvMTr2F38fKYduSGNcy8ixcUSJ9f3g+pmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN2qBGl17LNkMMwd1dWMHrYUL7L1Lv/LNRb6dNCLxH8=;
 b=q3L0vSOaYi1mwNSs1aBw7zIbCemntseNEbh2Ij8ojw0vEDAK2m9snHlIaAIS6drj3SHIB/Rx8wRzAnYvU5pjZ8Pi58yXNa8QCySArC27yGg03aRazXDy2Y+Ye8Nol+8W06/7JYGAk+5BX/Gu6/1p2z9b7jkkAxXtWsf9derbfKG97OegAlM136UIp4ObuT2klYb0b+YrFY47i+HMZzSH7x+JFaU3lVNTsiNvA/2yQ7pWO0NC+Fw6mg3z9CfE+zYgEK2APfoQn3N5szT5sjBsmdLQgVGOKV4IFqK/z9yjC1t4dvjy+vJSSHvcSlHDwC8ZmUEWPi9qg7pCp+qrJs3FvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN2qBGl17LNkMMwd1dWMHrYUL7L1Lv/LNRb6dNCLxH8=;
 b=V+FtvYU+sS868HIGQQLMoYCgxkT/8cR5I+qcMxOD+/89hCrcnciYo74RnVomUfZwwTT/wt8uXT5KdhPMOT49D8ZH2Fajir0gqbf6fKK0wh8ByMtZiE4hZruYCCB/IoCbfFhDPQQUiBmiWAobzfppzCFBFJiotdazqs/EhGVtnU8LEbK/0J5SuVnX2cdDSG1x0HpLQJIcLkzlQf8dB6R5Vp5Y1QhWUzps9q/SFm03UkERAo+wXecpbzZaBzfTfopWJ2PiPkN2mA8ZXUPlOzEq/xu2XjPRPeoOyoeTGva6Xykuf73S22Y7LeEu+F6NUWwIFJq9Fw+DKdxg+U101oAyfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB10974.eurprd04.prod.outlook.com (2603:10a6:800:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 15:14:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 15:14:00 +0000
Date: Wed, 20 Aug 2025 11:13:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <aKXmL4Q8OnKARPtW@lizhi-Precision-Tower-5810>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
 <20250820081048.2279057-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820081048.2279057-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB10974:EE_
X-MS-Office365-Filtering-Correlation-Id: 415efd2b-b594-4506-b6c0-08dddffc30b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B2xQaJQb1N14KEbnR7Bc46PcHs2b/5sgLIJjnwTyF34l513FFqdVUjGqQAlV?=
 =?us-ascii?Q?pjTpShahHvkUD0q8caKu3TnAg9RPffeje/KCKx9+SFghDuDQnfhLpBc1F+g7?=
 =?us-ascii?Q?T8TWyJJIJQAAWBR5T2oqHpZw1qDY1iOfdVatXKohzVUTxQkG9eOAD54IEk49?=
 =?us-ascii?Q?tR3ZyUxmELt52gqJ26Ws9sDqNxvIrrhzlpEcqmZtRGMXyUScZ3pZ+nUKOUu0?=
 =?us-ascii?Q?3NXNAZ5cx4/6NYJgU+wbmC6XWlx0UmSAngvKnPumEpvKU9LipBPjiZYU52Sy?=
 =?us-ascii?Q?NLMHERpK+mZl6kOmIXY9dZaRrhwBpyFvpebmzZUGAKHsKph2foxMFTp6aKI0?=
 =?us-ascii?Q?a3xuHYPQ/VJYArIz+R6BmGwqD1KqPzuhVCJxRoSGe5N1xv7R7PztjNbJSGtf?=
 =?us-ascii?Q?MXHvYoXbORoQphp9SBI82jtw2qNJn7BIHBPSmb9/9e5/sLXsGfzqeR/tqgV9?=
 =?us-ascii?Q?34QR8fUcgxlQQ+A2Q7I2vsPv5oGkdr8nZF60M7pnbcxiaaMVWRqF0RLxFeZ7?=
 =?us-ascii?Q?bx0yO0PG6uapvZ4BXw04/P28BmeS65rO07MnC7pUaunRYgREwcxziNMEMTKK?=
 =?us-ascii?Q?1kX0p+zS6ZEMeX5XFahrzCzzWyyynuc2plCJXpGbKGCceOPoPC3C4sWbUp8H?=
 =?us-ascii?Q?BKLnuWEb0+N1cLShrZ1lwyFIcodbefkT1zNERaErV9Z3nM1daEnMeYIdyvGJ?=
 =?us-ascii?Q?TUKLmjs7wCuAKfxyYsH1ioFUsx65juX4LeDgYr3NwechQQ+8cRpZep1JL+sL?=
 =?us-ascii?Q?X8lTFzerE9H8H14Gnu5e3xG66JLNTMD0ICPsGIHYXIIg5ly5K2zPUw9t5K1G?=
 =?us-ascii?Q?yivdqrki91hfZ+frfbPZ5wEJyLxzHuDh9h5KhBwni8FmEPa6zTWdrXDl0gKH?=
 =?us-ascii?Q?WxSlAa37xAFK0UsvfBaZbPDlKx68v7YxdIaygqIrGo9wFPe5UB8z49WtU8yO?=
 =?us-ascii?Q?+U/xVwWk+J77eulPVwZ/GYfNdQUOFm9JPCzXvlx79vW0bWqBGjxf7aMHZEih?=
 =?us-ascii?Q?TJ/4ATiezk685SpFrb0SOaoEmUqbYIit9NlAZYufcGEyRlGSXxscmOz49muZ?=
 =?us-ascii?Q?tAFCDjqAxYb6A1A1lErDQm+5U4dUPb/CUEYd6ENgI+biiWACJ1VA3NzVNd0t?=
 =?us-ascii?Q?wKugbYpX8NyegyVymLxMZtCu2xp6AxbAEj4SAIxPfWy0ooYTCeMW1yl51UXC?=
 =?us-ascii?Q?MsR7s8T4E/FobuDtBFl444D/nvPABO8RH4IIqnr4tkMVURJCFN89RY508FFc?=
 =?us-ascii?Q?b4QxwlfhS96S8vF3WTj4oPNVOoYo9k+K6tCspx7ZsMxS8xODoZablzUijXew?=
 =?us-ascii?Q?GaWgCBcJ63fsRxBU4ociGaiOIZyxNi9/JvzI34eDzTDT7kloCU3+lsAVAYhw?=
 =?us-ascii?Q?F+wKgzF4RF2HtFKBSnBEH6m2etvuicQQXIuNJyKnXe0uy1TdM8uFRlOk/PtN?=
 =?us-ascii?Q?IEEQGBZUBeLD/AJxDFcXWaA1Sk5jiP200JY1/FG7nJkqUSiKyHY76A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z1uoWabl22Hg9sxbYV6kakYoRa6HXWfqs+agEan1NoWBklrTdFu+se7oASH1?=
 =?us-ascii?Q?tnBwupBdn2HnIb+8iyIEQCs9Kk/kQMkM4iXPQksYvRV/6DRj1q06EQLec092?=
 =?us-ascii?Q?XaOWXVnJIUF252eB/MOFr+AO+C5eUIzaTco6Oaw5FKFLBvFX+Tid2IaORtlU?=
 =?us-ascii?Q?T4w/CGSj6PKWF0F0h/eLvQGdY6lNFTyQhFwzPWeUdLIuEbDuHbROxIcjd20Y?=
 =?us-ascii?Q?8KuwSglgq8ANT3yxnWVwwwElh3szAnEQ3RL95ShtgoKkHqneP72kNITOKLlF?=
 =?us-ascii?Q?1bc0B9ILhbpzM0rf5GyO2nZiXO298BT7zhoyML9kaVhPrht42NcNSNG0HhPp?=
 =?us-ascii?Q?qa7yhh+GEFQOBtqoXEL+fFqZQuwI5gccrJjjToclKq/XMArKzr/1AqYKwDUv?=
 =?us-ascii?Q?QHDXdm7ZdfRfP0gyk4Qvsum8obZoqm4v7us125vAvo4WfQI7NYZPn/7I4FDw?=
 =?us-ascii?Q?gu/thcagTCC/rZG1TABvE8zxiEA/qJgi5XU31iqrY9FzgJ4IsLkE+Z4fJvuj?=
 =?us-ascii?Q?b8fq2GKG/jaIZLSVhiv2fvPhNnXM1RL1ktC0LPIOEtS88dlXLxGaic797qcl?=
 =?us-ascii?Q?tRPohR2+ESZfSw68UcPr0iX4n76UyMyzVCaksccP9G8G0AV+9w9GEgLTemir?=
 =?us-ascii?Q?+G3WOsR87ycwzwcSnjdHk1gcCaIpU9pX/iMdOxeynJB3ULR/Cp4HG6qVZosS?=
 =?us-ascii?Q?zJYajxGCM4rem1YpmlEX4v+bCDA5EWrzN+N2Rnu6ANtjhaFBDbSVH5uiMCJR?=
 =?us-ascii?Q?SBxEREvkVzndA4+DVkzSo90VsVKglK1Yxy+ojmcUMS8JAs3AQ9WOZSfH9odS?=
 =?us-ascii?Q?Mmcy5uQ44Jiz1skHElne3eYmsCQ57b97V8QeTlywU9rqL4OIheQH9WVOLaVX?=
 =?us-ascii?Q?oSJjpc7SuZrd110i3QfV3eraS92jghBKnQqd8TjCmQ2c8ou1uET3aA7LPouX?=
 =?us-ascii?Q?8+tGwbCP0wBkBnM3q4z8iN9pYcLU2Zt1rMt6FtcgqF/uXV//gCDY9Kwdiwkn?=
 =?us-ascii?Q?Oq7D8ea84VdwyHYvAe6vEcRYq3y+Wfe7u4Maw0QuZCTwcFIZ1wM+w/gQhQef?=
 =?us-ascii?Q?9LWVucvYmFdOl5RPuHclam18eaK70HoGBxRmi8XUVuw0euOwMiViQFsZlPBH?=
 =?us-ascii?Q?NSHoxclJTqkbDcW9r8Srg1/zpvGiWueWvyxEfk9MJs5qABPMku2wPjMnFFGi?=
 =?us-ascii?Q?4qDYOlkgq2vYYh1sZwYDlK6UvS1szsioWuouWzzsE3o7wGwuQH6ssOafCRan?=
 =?us-ascii?Q?+hTYwoI4KF0ortqNhX8YJfBDAxlymm2ZeDlgTj0OQXPEmtzPjmZWgEyE7iHV?=
 =?us-ascii?Q?D5Wpwu4dJLzCtYuWpSAog2YxYQ6zCRDk0J7q89oLDqRCmWQya9wsmvOz7o1t?=
 =?us-ascii?Q?XZSZv77pnocC4lKn5b+JKZKofTgip/7W9CSqnKn1Obb0H6RggPKU0GVE2vzF?=
 =?us-ascii?Q?lde6ApW0SDi0+Yq32hVetQSRstZhEvEjQ67APIN/U8TNzW4c/4vNJbHdod0S?=
 =?us-ascii?Q?AmaS3Yec8MOPWn3w5BLKW5iIlEAqcZs5u75uzbaoLUVuS210SHCMeOfGa2Ei?=
 =?us-ascii?Q?qyDEELOqXBnVfxj26bDOrBK8A4m5z0WlR240xKeP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415efd2b-b594-4506-b6c0-08dddffc30b7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 15:13:59.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gko42mTIH+hY/6o9y56cIt3uATalNuoi+JUem+Gb8X2UwRfQdZJ2XN/DMw4qS9YZdxI0b5WZfHp82VtYJexLIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10974

On Wed, Aug 20, 2025 at 04:10:48PM +0800, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock.
>
> Since the reference clock may be required by i.MX PCIe host too. To make
> sure this clock is available even when the CLKREQ# isn't driven low by
> the card(e.x no card connected

some old PCIe standard slot card have not connect CLKREQ# signal because
PCIe standard have not defined it at that time.

>), force CLKREQ# override active low for
> i.MX PCIe host during initialization.
>
> The CLKREQ# override can be cleared safely when supports-clkreq is
> present and PCIe link is up later. Because the CLKREQ# would be driven
> low by the card in this case.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf6..a73632b47e2d3 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -52,6 +52,8 @@
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
>  #define IMX95_PCIE_SS_RW_REG_1			0xf4
> +#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
> +#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
>  #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
>
>  #define IMX95_PE0_GEN_CTRL_1			0x1050
> @@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
>  	int (*wait_pll_lock)(struct imx_pcie *pcie);
> +	void (*clr_clkreq_override)(struct imx_pcie *pcie);
>  	const struct dw_pcie_host_ops *ops;
>  };
>
> @@ -149,6 +152,7 @@ struct imx_pcie {
>  	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
> +	bool			supports_clkreq;
>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
> @@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			   IMX95_PCIE_REF_CLKEN,
>  			   IMX95_PCIE_REF_CLKEN);
>
> +	/* Force CLKREQ# low by override */
> +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> +			   IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
>  	return 0;
>  }
>
> @@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>
> +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
> +}
> +
> +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> +}
> +
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
> +
> +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> +		if (imx_pcie->drvdata->clr_clkreq_override)
> +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
> +	}
>  }
>
>  /*
> @@ -1745,6 +1774,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>
> +	imx_pcie->supports_clkreq =
> +		of_property_read_bool(node, "supports-clkreq");
>  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
>  	if (IS_ERR(imx_pcie->vpcie)) {
>  		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> @@ -1873,6 +1904,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.init_phy = imx8mq_pcie_init_phy,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1883,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> @@ -1893,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8Q] = {
>  		.variant = IMX8Q,
> @@ -1913,6 +1947,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
> +		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> --
> 2.37.1
>

