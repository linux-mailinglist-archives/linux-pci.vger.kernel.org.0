Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6997565AF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGQOBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjGQOBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 10:01:34 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0076118;
        Mon, 17 Jul 2023 07:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAydZwDVGU8IWqpZgnDKx5E7DXSNhthZoGrSsvyUUbdodK6xpUkokE1WysdR6U0DYMF+oT9a3ZTF3UYo9hw+SaYwC0ddzeJej2jXYhU0cDOXiZGyqiKLUfKqmjOflHC7NiXcp8XzqqAs9IDfAoFOySyvWi5+qy0nqgR+gopYTJ3srbfewGxqQe7EwaTfsjPFL+LL+rHIS0bi6GVMzumeFKCIobSutKIG9gR5MXaGrTIEZ3Ys/DgRSedTSgaJZyVRILd8pqZs8TEpEH1maHPY6/XzL8RtBq6BB3xz7safY7sGPBDldvOrYBeG11lrWms7QGkNTn+9+YZjpAzTnBH6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcq/i7Xl6uxieNzHuwd3w4yDYaxFKtwgiYkbDDbvwIc=;
 b=WFW/tMYfyg1ytN7ficnky9Vg4qYf6+MqvC7Rpr79qSv2x9xQD1iEPAl2L31QndlyiLbMHQH2jyythln6Kqb6ZRSI1S+YOKL9hhDo9sUczO6a15zPrPoBFOfaV+VbVCDjJ0ESK58c9YlzOqAXTNbtdbgt43JkIUBXB1iI0eERwyUfwYV7X/tN4pGOVkOlmugvaC/reLRxYEo2eOpyWZZVPqdhwU7ttVRZs2D/va7S2XO/X0CuDFO3XbBr8xut7RK6cAjQtZ9yeEAyYfCgn699EE1KuMy8T3dPvXTGrylnfPBHsW+QnwbyULOF2/l2OFeZmWOfpxhG51UamdcfZAyR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcq/i7Xl6uxieNzHuwd3w4yDYaxFKtwgiYkbDDbvwIc=;
 b=mInX0e0gFJ3HHVbN9e1BhUpW+p0FaczRyxer9sjEUCpK/o9VY0iO4Us0gAzUIVDhVNltDa1GU0JXHACqhj9KxzF/r/0VCXnJ8kD+lV9XvQtJA2vN8M1LzSJXUQUx9Eo0dk2CjcDTninWIIxNP7iH+eukaKV0hv33bAU/bSkhViQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 14:01:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:01:28 +0000
Date:   Mon, 17 Jul 2023 10:01:11 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     mani@kernel.org, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: layerscape: Add support for Link down
 notification
Message-ID: <ZLVJi6C0JGGFp//F@lizhi-Precision-Tower-5810>
References: <20230615164113.2270698-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615164113.2270698-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 272c2021-12d2-404e-79e7-08db86ce50ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tOXExE7PxeQTlWA7c4GF0KZF4zLU5/6WwJyONe7CRcxmJn0qFuCrzNuCGxsV++M5Z7/rG/f2DJvF6H5s9vXngjcCcrF1mazLPEsVv+ZABrRAxGR/Ju0A6RSjpJB+3LfEFlMmpVJdXF7S3jYfJgmgzvRdTulf1sgIrmde/n1aKa7ZXbWT8jiZk6xQ2kmd76dwyE5LEBpkHtYfB896JwmxHbCHwSjpJYbe5cuUrX/KHMz1PPCWv34N+PG5XuN+oHi1Av7vXXsRRDqmIM5aUulM0+Btq4DXUHIk7QOjr6zR9B+/6fOZkpdY/fp3y5DDTDJ7ZSiXWqSR/pUM2EtKE1rACOQMzulCxJE19iauOSJSZEugpNgi0tEH21bDPUt8GnvQSPZkzs0hS5nucQys9rE/SnhYNm0YUC7Fohrqst3MbVrMJ+RBXk0AkSr9EUmlMulu7lvUfBB5JnF13yr0fq5vsV9p4vYaEh/k9uaRz1pSNjyu9kxmBEIv3loMZZx0PUiYdvVmXU3jFNVJ93lAA347yxPlGsY8aMKc69X2yFd667r0lQ0vLTrNJurLfn9JO9G7+hyfrvbSQ5XUwjC9GhfHA3lMQaxyDhxYzIOn2nmntWv6xWyP0R7UIgkZLzBzogscQCQTmzSuwUrgNLaVDXH7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(9686003)(6512007)(26005)(6506007)(921005)(66476007)(8676002)(4326008)(8936002)(5660300002)(33716001)(316002)(110136005)(41300700001)(66556008)(66946007)(38100700002)(38350700002)(7416002)(6666004)(2906002)(52116002)(83380400001)(15650500001)(478600001)(86362001)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEgBXdo6EpC3AWN1/9C1iXOnsaXb5keYw1NTxziJPSVIL5PCOouAKk0iNbhC?=
 =?us-ascii?Q?D/p6ScmaCWE6S6YC2ZhKMtLxTcmniTUYZhnkCVgICCRh4tQ/UHi6rS2/5m47?=
 =?us-ascii?Q?6Guzxr3lHJDAUT3lWooMd4NAIWMzac2AiEL8VFf6XpGRS1b2yy6aQ72Dn8KA?=
 =?us-ascii?Q?gZqPuq1aKinYq9+lx496xk2OzQa0gQSvvELW8zwah1bVMc/yqsjlT9Z1NDzz?=
 =?us-ascii?Q?GuAYM5VKccGfXiPxRaj4sNGGLx+KtQMKc0gu2m7zYerS7ejVFMYzW2W+BF0d?=
 =?us-ascii?Q?0aQ+zGzNe+LsueG4mM4iWg0PpyaDAtxBnLFcR+LbyI2E1myIFxlKpk4zOjFd?=
 =?us-ascii?Q?s+bJZNV+eJdq3reu7c5vMKUeRrB/Y2i6xs0U4VPBktXQQVP5q9FCI1oEWCFi?=
 =?us-ascii?Q?4vIDuzTa6bKazg90Z5PqRi61N4PYCRZSF0WhW074JM18g/dMzqmXosIAV5eU?=
 =?us-ascii?Q?vY+cCrgM2D7aWB/q43rrHHl52ZmNxJatq6a+QWYGaQIzRz1Uxh55NV0cElzI?=
 =?us-ascii?Q?SDzsdSoZIgJUlN60YOcg8jclM/jGWr1pf9xPmmlzPqKzb8D6kxARwjv6d/Gr?=
 =?us-ascii?Q?b9GyhuH6I7fm+oxfHhjkbCuq8+XjDKpCN/IE0iUX+XuiqTt2Y+nK7wxzbNEc?=
 =?us-ascii?Q?4PYZptFsqA22dEMq1CdusT/qCYLxnCgaEiP0vKpCSeWBs2UVa941O+I6Te8M?=
 =?us-ascii?Q?/rfNm9azEXKBI6LDDxEDYkHPc44t1TCgj/LJFsSX6Bhm33OV01N3x6Secvqd?=
 =?us-ascii?Q?KXolkbOpQ2d5Bk5oddS5tCiBr39C6IPv+Cm4WpZ/WYp+84Gi1v1W4GBJKxah?=
 =?us-ascii?Q?dcZqbkcVJGtlp7c9OSpZqqFe4QQoMd8JYmcSbZmX1fQSJNxUTuTIvnZsW5Rd?=
 =?us-ascii?Q?ceym0DZ3u2+NpG61JFw7iERXWIYQ9qH4px5ou0+R/tn7M8pb5fmdwfEWpLb0?=
 =?us-ascii?Q?/eG/t2TrS2xvb2NT2PfEVh2zATtv5gKibSbD8c/n+SSxCPr5mcUkDb+Gm105?=
 =?us-ascii?Q?MTs9CgyBYNg8WkjBU+qqotIunLnyMRhodSPrEoNkOKihHIH/49LeeNgY8ldi?=
 =?us-ascii?Q?C41KYJqV96X31ofcJllTpRJKDApISYx5FhHelqZshdsV+N/7Woe0/gA11V8t?=
 =?us-ascii?Q?vDgiMn7N+0mB/pDVO4/abkqPUoTlB7kFgX+qLvShXprxE0s9TA50VAhaAjj6?=
 =?us-ascii?Q?Jm4kKoL/mJ8LaBhkjeQSzaX2SYBCpVvVyPrwCDFo1OEKIwPuDdSlyUMi4XT8?=
 =?us-ascii?Q?8P1txK7TjVHxomOkRTtfAkDgZQhi5hyN9f60GLknyKIB/jigQ8ZoNfKKXzi9?=
 =?us-ascii?Q?hAne9GItD2wKvG57mjOHDgNIjOsCB5jm0RSPGYFxaKVqflXS9nMMreCGWamU?=
 =?us-ascii?Q?4biOvjl4YX6LpGu9471pAIU6vFSfW7ZdxLSnjYV+LzCG7UanluzBmRx6Z8Zb?=
 =?us-ascii?Q?BP7gZ6pmkcecR4A8+HyYK3Je4XcKorFkJemFCsMDEK76wACRxlMu2YtilzQD?=
 =?us-ascii?Q?W9jTQe5y4wBAHv+g63dneFVCyE7l13/w7C1alZQ+ASSMF6OuxSglsbDu6bEE?=
 =?us-ascii?Q?H+0F0rxYqPjgF0XsihtzdMFOuUngvvO4V1eN/Ao6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272c2021-12d2-404e-79e7-08db86ce50ad
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:01:27.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nV+ORxRwjdcacrZAUbQhaIwpkhggUx6uSTXj/RIa2PR8cO7gJdMtDMH5HTdCngrXhuQZoBBWX18emcuoWL44kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

O Thu, Jun 15, 2023 at 12:41:11PM -0400, Frank Li wrote:
> Add support to pass Link down notification to Endpoint function driver
> so that the LINK_DOWN event can be processed by the function.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

@Lorenzo:
	No comment over 1 months. Just change layerscape
	and 1 line code change.

	Could you please consider pick this up?

Frank Li

>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index de4c1758a6c3..4e4fdd1dfea7 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -88,6 +88,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>  
>  		dev_dbg(pci->dev, "Link up\n");
>  	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
> +		pci_epc_linkdown(pci->ep.epc);
>  		dev_dbg(pci->dev, "Link down\n");
>  	} else if (val & PEX_PF0_PME_MES_DR_HRD) {
>  		dev_dbg(pci->dev, "Hot reset\n");
> -- 
> 2.34.1
> 
