Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66ED63B3A3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 21:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiK1UsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 15:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiK1Urv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 15:47:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1501A24F11;
        Mon, 28 Nov 2022 12:47:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5O8o835XQsHWF9FKZHOdDoQLARwXoxZrmHNuORvFD4Uf4dQhYW/qlvkgV7LrqzEhyS7PNDNUYraMtJ2ycgLNycHNwSie7awwk+NOv0Y5YXlUSGfOpG1xSQTSgT6Ymgdb4iTf3Jr+1wOZbNTZeCBZD1MOkmYusCeLRLXth01sBkYDA7x8JhwoURcRVMPuNXZN207gOsyExenPrZotjnsjQ3MR0wSByWsXNmv9ZtjfCyNhRgOrn0Iy6Zlyf2hnKIF+SAXuOBDymrD2nJawKl+VbDhCXXWFjj5vSe3aQ8nneGq5s/A/04Sg1oH1m0J0ju6V1yD+9FKz/CwoR2Nq2lbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM5+fuxttU13lytdgPa6bP03Fv0eyqy2kxa6Nrxtz/4=;
 b=HiJJ+JJwKtu2jEzQjI0cZvLyAbMzXogiZnA/qnZf/ggnnv/fUagjTq2N5DDyHL/C8E0PXp2NnC2zYAHorL/oTqAAQRd8oFSh2hZOwOx6rIonG4IO0KpyeYPGzV2gcIK+cYm7lR2kLK0dfwPkUcesA5l8JpPU4wDppQDDs2gicMCBfJu0SooODc7M9AojAh5t/lrnJikul+d20dnV87fxHdV78GtYkLFyYpnLnxt6jHzQelvUbwTlNnS+xA5pKMIgAQ+gZpAByXgOvjTbDexXdEhg784AgGcpW0AdaTzdBR2xujpduwu+pp7r64UMEr/BHtof6zZy57cqW2hyl9/Lvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM5+fuxttU13lytdgPa6bP03Fv0eyqy2kxa6Nrxtz/4=;
 b=JoiA87RWkv704OMU505VdvzVlRNngMLXmujkr/ISD3qBA4DrW6nTTJbmL+pvAj8uyDjTgYWb9MoRYvbuy5nuAiMz32wtp+RBkYsRbhJKSzFini10u8rSdYxDfBsC2Di8MzfgZizuoUHuHC4ZYE4+wpj/wxVdSQZAN4XJhHJRDJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB9077.eurprd04.prod.outlook.com (2603:10a6:20b:444::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 20:47:43 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 20:47:43 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de
Cc:     agross@kernel.org, ammarfaizi2@gnuweeb.org, andersson@kernel.org,
        andrew@lunn.ch, bhelgaas@google.com, festevam@gmail.com,
        gregkh@linuxfoundation.org, gregory.clement@bootlin.com,
        jgg@mellanox.com, kristo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        nm@ti.com, okaya@kernel.org, robin.murphy@arm.com,
        s.hauer@pengutronix.de, sebastian.hesselbarth@gmail.com,
        shameerali.kolothum.thodi@huawei.com, shawnguo@kernel.org,
        ssantosh@kernel.org, vkoul@kernel.org, will@kernel.org,
        yuzenghui@huawei.com, imx@lists.linux.dev
Subject: Re: [patch V2 33/40] irqchip/imx-mu-msi: Switch to MSI parent
Date:   Mon, 28 Nov 2022 15:47:10 -0500
Message-Id: <20221128204710.2084706-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121140050.386216606@linutronix.de>
References: <20221121140050.386216606@linutronix.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3108c46f-3269-49e7-f01a-08dad181cb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWAA49X+tme9kPQENlbZF6FYzApp+eAnecrbwYS+vTPQ2zej0pri5MZddWk78aYscFAq09RstqcceAr6X4EE3fK2PhnGFAxjbh7LRyUS6V6Bc390exwDRyJI0x/lQ3TwdrIuTldvWWVqVOyMzyqO3uMVJ7bqD0uss9qMjnlOneJ25Yj6gxztfldPxJ/CVXj1ocspc2giJSZqQuyCr56w81PUfzp3GYMjwKLn2MSYqCIu/s381DBMTOjGRu+59XRk9qxwx6XFYbWNmFn1qfsvChw0rIM0H4qgi4CapBJODdXMti3BblGb9s/NYkRsGAkvnW9mivgCSbZ2o6FCGU97/tmIcznuG/Jy1TJGeQgqS2RYDMCzzWzO9E85vM3reigSdAmUkegJWUqJvbRSS5/CJYdAKbp6mX93PIT0zoSfFWEO/CBWx5W1yZ+oXOTjfq3StQ1OpuyXGOqApAbG+VnPyzz9R+1XeKmE8nzD50ZhyS1kNslZkpnlXTP4Web0ivTJ4Y4qwd5O6IS4zo3cxFaXxfsDAeSSkbtRiH3BvioGsFCuLyZLc08lE94WmOGTt8C1TEtoa4gc+nzjqT4+4GykFRnHUhU9o7u4h7oyuAiIA7I3u0qFxWzXwRDFo+j+zO5WDw96hxgugkSd/WCiex0dIzRCDdU1iO0bMzqAZVNa78k4nQeDIU+iyptwxlK4xpZb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199015)(7406005)(7416002)(5660300002)(2906002)(41300700001)(8936002)(4326008)(66946007)(8676002)(66556008)(66476007)(316002)(478600001)(6916009)(36756003)(6486002)(26005)(6506007)(2616005)(52116002)(6512007)(1076003)(186003)(6666004)(86362001)(38100700002)(38350700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bjM9r1EIHxlBzhr6unviSd7x/oWuvmRL1WoAAz6F9vWEwk0s9gT6yG0WRuUU?=
 =?us-ascii?Q?1JZ5sk9WmEtFCdNjI+qGPOjtS+vPxGkogNad4ps15Tq3vky3OPUtRpyeoJS+?=
 =?us-ascii?Q?SyCV0So9ZhQZBoZOtIH6nqBLk5Rpqint4JLOrGyD3m/b9IqADSZmxxl5Nlwo?=
 =?us-ascii?Q?kHLhXGdaI9Klw1w9/6z3OJ8ZlSWgJq/iqVw1BjCDhLfBCPvtMVcSuVdN+XuQ?=
 =?us-ascii?Q?6cUAFKTKqxfP36fdFAz3TBzitZKJk/YiFSNdIu6/4CNuuv8EXxd6dhlMDJUN?=
 =?us-ascii?Q?FXGTpP2ucbGO3NUNxyxmchwiCbUVklPonXVjQV8LbkYGCwyb6wo4UzaYY+Io?=
 =?us-ascii?Q?OGn9b/sDaieceRYrv4eensG/bD+/v71bD0QfR4oeofE5Z3F4KRsveZo+nNaX?=
 =?us-ascii?Q?GCIIQXHhNIqB+FSC07m49mDJVfCPsJfnWvqKuh9VI1GOZQ33gCZM2Wlfcvn8?=
 =?us-ascii?Q?tjOEigtxNTk3rXcq7I3HXWRkYDEHc+hrM31sxMmjRwouZGorqwOF/ft/yc/L?=
 =?us-ascii?Q?H7kx3VhXfxQFfwleTbhCY2/VAdfib5HYe/8CuaV0cwfv8lbIkj3uZrfj6AGI?=
 =?us-ascii?Q?vNcVURigvjQdLF6v30qz4RI1L8A0LHX1gzJ8SIlKBQtrCGP1b6ZupPJamP8R?=
 =?us-ascii?Q?hmOhkJP/YqQc8o5Fn7bug4y9OFdb7+n+o7ewPp7yRfzj5ky8Ec9MF8djLiYH?=
 =?us-ascii?Q?+oMaCuQEP6l3nzb96LoBIRrjcx9U4qQI1cHs/gitFiKpgXvgJyCp/pY8ntCd?=
 =?us-ascii?Q?YwSQUKVORHWNX0ZqW+qAWfHIcbycLI468/AElyyFLj+q8EBeQDTVX0I9MOsn?=
 =?us-ascii?Q?beNtXX9jLMbozlI4BZ7pOTDfyDX2t64qyp5187yVLhkYfwy6VYphSEShJobQ?=
 =?us-ascii?Q?4tp2c0ju5rE7LRv41/HrZTuE/l+csz0LJFqhgW2qJq5VvokUFY3NS5w4vm5Y?=
 =?us-ascii?Q?TO28+Wbxn8zLJoqRQ6i8ylIUa8RLi7jSldnsa+S3sPZd9Is+IJTNtI2YVV/r?=
 =?us-ascii?Q?C8nYQPGKEPG4kJ7WAhVLp/e8lQW2gpzYsFdcNPuH2L1D1WdbNdLHIiErG4ID?=
 =?us-ascii?Q?UFbCgc7KQ6par9YqnTUR6gbDPg/mRgU/I+ZZui+urIWsD7spzsiyswdwUu/7?=
 =?us-ascii?Q?rGY3M8h9SwLAhqFppHxDlNtPJSd39rm5qjxNvfsAZisMCbhXY5paEOkzE2PT?=
 =?us-ascii?Q?sDIDoL9qd5FJugp6qBRvSesdRYtgLLnOG467tOfwKeO90YeA8XeDXGgAYe74?=
 =?us-ascii?Q?nIQISoWfTV4VeN5bNPGTKPs5vb3UDykrywSxbrhLgMSmNKoGfEYuJjAD4GOB?=
 =?us-ascii?Q?3ach5Lqfwt0/jpMaAWLpiLzLtlXwbG08jC4j6XylFTqwdCq8Dll+yRvpvhhc?=
 =?us-ascii?Q?U7I/ZFESL5DhCj1Txq7Ld3ygF1PBjoyKSmbNrfWSXtoREu8fCrO2nwlnpBLl?=
 =?us-ascii?Q?6Rl8Uq5bO1NbAVW9wEmIY9XgdHYL98+u7SKv0yQbzOizC/jGDeJpf8rvSJSZ?=
 =?us-ascii?Q?pb2wvG+H4xVHx1wPwCebfrQ+4HLUAHZL7CPhS2DJwa/1BES72Xl764soiwTD?=
 =?us-ascii?Q?SqgOr5ULghYkW0zKegI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3108c46f-3269-49e7-f01a-08dad181cb32
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 20:47:43.5975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCTzAAyKmBw2vCgH/4feG79GRDYHTrCLQQNEK0a0UErG8WrcB2VdNfdCKkhHU+ZKm6HLvSSgaJPXEiTOomHGSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <Frank.li@nxp.com>

On Mon, Nov 21, 2022 at 03:40:09PM +0100, Thomas Gleixner wrote:
> All platform MSI users and the PCI/MSI code handle per device MSI domains
> when the irqdomain associated to the device provides MSI parent
> functionality.
> 
> Remove the "global" platform domain related code and provide the MSI parent
> functionality by filling in msi_parent_ops.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/irqchip/Kconfig           |    1 
>  drivers/irqchip/irq-gic-msi-lib.c |    2 +
>  drivers/irqchip/irq-imx-mu-msi.c  |   53 +++++++++++++++-----------------------
>  3 files changed, 25 insertions(+), 31 deletions(-)
> 
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -494,6 +494,7 @@ config IMX_MU_MSI
>  	select IRQ_DOMAIN
>  	select IRQ_DOMAIN_HIERARCHY
>  	select GENERIC_MSI_IRQ
> +	select ARM_GIC_MSI_LIB
>  	help
>  	  Provide a driver for the i.MX Messaging Unit block used as a
>  	  CPU-to-CPU MSI controller. This requires a specially crafted DT
> --- a/drivers/irqchip/irq-gic-msi-lib.c
> +++ b/drivers/irqchip/irq-gic-msi-lib.c
> @@ -90,6 +90,8 @@ bool gic_msi_lib_init_dev_msi_info(struc
>  	/* Chip updates for all child bus types */
>  	if (!info->chip->irq_eoi)
>  		info->chip->irq_eoi	= irq_chip_eoi_parent;
> +	if (!info->chip->irq_ack)
> +		info->chip->irq_ack	= irq_chip_ack_parent;
>  
>  	/*
>  	 * The device MSI domain can never have a set affinity callback it
> --- a/drivers/irqchip/irq-imx-mu-msi.c
> +++ b/drivers/irqchip/irq-imx-mu-msi.c
> @@ -24,6 +24,8 @@
>  #include <linux/pm_domain.h>
>  #include <linux/spinlock.h>
>  
> +#include "irq-gic-msi-lib.h"
> +

I think irq-gic-msi-lib.h is not good name. Actually mu-msi is not arm gic.
irq-gic-msi-lib do common work, which not related arm gic at all.

>  #define IMX_MU_CHANS            4
>  
>  enum imx_mu_xcr {
> @@ -114,20 +116,6 @@ static void imx_mu_msi_parent_ack_irq(st
>  	imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
>  }
>  
> -static struct irq_chip imx_mu_msi_irq_chip = {
> -	.name = "MU-MSI",
> -	.irq_ack = irq_chip_ack_parent,
> -};
> -
> -static struct msi_domain_ops imx_mu_msi_irq_ops = {
> -};
> -
> -static struct msi_domain_info imx_mu_msi_domain_info = {
> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
> -	.ops	= &imx_mu_msi_irq_ops,
> -	.chip	= &imx_mu_msi_irq_chip,
> -};
> -
>  static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
>  					  struct msi_msg *msg)
>  {
> @@ -195,6 +183,7 @@ static void imx_mu_msi_domain_irq_free(s
>  }
>  
>  static const struct irq_domain_ops imx_mu_msi_domain_ops = {
> +	.select	= gic_msi_lib_irq_domain_select,
>  	.alloc	= imx_mu_msi_domain_irq_alloc,
>  	.free	= imx_mu_msi_domain_irq_free,
>  };
> @@ -216,35 +205,37 @@ static void imx_mu_msi_irq_handler(struc
>  	chained_irq_exit(chip, desc);
>  }
>  
> +#define IMX_MU_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
> +					 MSI_FLAG_USE_DEF_CHIP_OPS |	\
> +					 MSI_FLAG_PARENT_PM_DEV)
> +
> +#define IMX_MU_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
> +
> +static const struct msi_parent_ops imx_mu_msi_parent_ops = {
> +	.supported_flags	= IMX_MU_MSI_FLAGS_SUPPORTED,
> +	.required_flags		= IMX_MU_MSI_FLAGS_REQUIRED,
> +	.bus_select_token       = DOMAIN_BUS_NEXUS,
> +	.bus_select_mask	= MATCH_PLATFORM_MSI,
> +	.prefix			= "MU-MSI-",
> +	.init_dev_msi_info	= gic_msi_lib_init_dev_msi_info,
> +};
> +
>  static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
>  {
>  	struct fwnode_handle *fwnodes = dev_fwnode(dev);
>  	struct irq_domain *parent;
>  
>  	/* Initialize MSI domain parent */
> -	parent = irq_domain_create_linear(fwnodes,
> -					    IMX_MU_CHANS,
> -					    &imx_mu_msi_domain_ops,
> -					    msi_data);
> +	parent = irq_domain_create_linear(fwnodes, IMX_MU_CHANS, &imx_mu_msi_domain_ops, msi_data);

coding style change should be in sperated patch.

>  	if (!parent) {
>  		dev_err(dev, "failed to create IRQ domain\n");
>  		return -ENOMEM;
>  	}
>  
>  	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
> -
> -	msi_data->msi_domain = platform_msi_create_irq_domain(fwnodes,
> -					&imx_mu_msi_domain_info,
> -					parent);
> -
> -	if (!msi_data->msi_domain) {
> -		dev_err(dev, "failed to create MSI domain\n");
> -		irq_domain_remove(parent);
> -		return -ENOMEM;
> -	}
> -
> -	irq_domain_set_pm_device(msi_data->msi_domain, dev);
> -
> +	parent->dev = parent->pm_dev = dev;
> +	parent->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> +	parent->msi_parent_ops = &imx_mu_msi_parent_ops;
>  	return 0;
>  }
