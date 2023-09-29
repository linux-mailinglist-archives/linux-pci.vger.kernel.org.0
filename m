Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD97B35DD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjI2Ojo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Ojn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 10:39:43 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803B1A7;
        Fri, 29 Sep 2023 07:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqsNjYxeUsxNlIywxSmm4X8lVOBC8oFg2/o6G7AMxN84RbNj9NOytFVH6XuTp3QSaxAPSXnEOv44sHkMgA+SZwUNhdmQQZLBsZ9wVVGW5mM7pBucYQyHvLmFJ8DvH+Hxzr/LEfVxS6sxkZuYnqb73wjmdtSG+jYi/mQmxZETLKa1V+TLOD7aWHMVo9biH9Rx07ddoXaMKfxYm/n39IXzhrCm0qUom6RWfIgBSlm6Kfc/9idCAZc3hrS7vD1VA7m/GJRqRumITg0j70ZjC0yJCfLOCsjDlu7RA7hYaaL9jnZVWv1vVfYbsxNm+2xa3eV+9fUghm0Vltj9XzT/BfQP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3j/eAWmJfSexOqipWHCFZrVZuxDp2AieHLOPVlMgmk=;
 b=DgvK3jH+bCkxdwzTNyyGo1tPdQFHL9Hjev1V31tNzrRE5r791D+nXlgpuF2l48vmgcZoYIoh3M6j2sT1KemFXrQSbfMbyxBGPA2hxGkB9YL4X+c8Ze55zfwA/xxLr5gl2uWfgav0eyoQyc4VzTnQiOaLb5s+orm2pssLLlbaP1ZLQBnqMj/mxh9Kn+D9WrNNE4WgPXzlRNLfKHIrsi8KRw7DDuIrsmNy9Er9lPSO9KtpkzH1+cI7lqVmIRg5ldLw9ZQLBwy58+W7ThgFr0rhOmS4Bd7FlHgpPu/VDxZ492ZJ5i/tNOLwF5bde8pdQ9/MQ/y4G79B1Njx6zZM8k/KLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3j/eAWmJfSexOqipWHCFZrVZuxDp2AieHLOPVlMgmk=;
 b=IcaZ8+JhN9gmZSK0Re/4qbtpl0KJU6QRta5aDJRRU3EzHct543LMd5MnnnGLWaenDVxneR9hnr9zSP/u1j3N2QGcWNdocObABpFhPSTVzUM604zoazECpgvBptKVrswW8uHP8dzAv+iom1ViPCVPNpeHkLnKp7w7GtOUk4C5Yis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 14:39:38 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 14:39:38 +0000
Date:   Fri, 29 Sep 2023 10:39:26 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Kishon Vijay Abraham I <kvijayab@amd.com>
Cc:     manivannan.sadhasivam@linaro.org, aisheng.dong@nxp.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        festevam@gmail.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kernel@pengutronix.de, kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <ZRbhnhMxvDs7eCmI@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-2-Frank.Li@nxp.com>
 <8918a885-b803-5430-8200-6b97c8782d76@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8918a885-b803-5430-8200-6b97c8782d76@amd.com>
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cff4af5-8928-43d4-8b05-08dbc0f9e869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TaSclaxz7wKjo15uRkg2tfTqGUNPQyb2VZLiOFrD5puxUd6r4WVecMPWS/rnYLHXX4YQl1TmF895BYthl8AIssiLnmqLP5jHpoBeO5dhCvUgNVfColzG+WPVEqhz9pntRcpLCVvW2/YvoOyxIN2H2yUEfT65e9nH674M8lt6e+1q96wHgJAc2RYcUEdb5PlB3Axp5RgnT1oFndBn4FKt+kEeKpTRUyQydzDk+lkI8eBwHanRNx29x1yVXcC2rN0X69XtS7g3bgvuXcqPbYu7SJoEXoAsP+erSftBqccoUY9ScKwGNsfwRjHWw41H6v/r/SoflNljkOqyD/sDzQ2gV3jEg/EnVF1tVo7ZFcsc4GWuJ/vINqjMQJD9p632DnHBIHIBR2dNADhKJA3Pw+VMobkdeKrGAT3+c/xHoqCXvM+mR6pg3V0Hn+ZGn0xGIIU6MKZ35dFiB1Up/UQ+9TLY1oUYzagKjSOJg4cxRV7Pi9CxV3fHmnFPG5iRE7T9zGxZwN1YpkowYkOxaJVr+Tna/k6CU0GDWKLjBMQxE4JcvMyzMqujrbHfuOYJIKUr5Vr5Ee/VYTnko6OWxhGBRKinX6guEtD15KLbACG3ppPe4fJyeWsR1U0XtNOWVs5tmy9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(9686003)(6512007)(6506007)(52116002)(53546011)(83380400001)(6666004)(26005)(2906002)(4326008)(478600001)(33716001)(66556008)(6916009)(66946007)(316002)(66476007)(5660300002)(41300700001)(8676002)(38100700002)(38350700002)(6486002)(7416002)(86362001)(8936002)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?88TS5rcq4t43jchQr5BWtPtxgQhE86Nu0AVfBzXxLBjDcVMhQj1WHP19k/Xl?=
 =?us-ascii?Q?rq3swRDU4qMNJSsMRIHayDTL4pvJNU7n3uvXmuCNB5zZJAW/VztKitF8/dtf?=
 =?us-ascii?Q?vKtE2He9iMKZG5v5+UJ7+yQUQgF/lsidDhvrWA2wd/SK825WhrzCRIqYIe9o?=
 =?us-ascii?Q?cqi7GMYkAKueP4OktMKs0ZcTlT2TplYbVZyvgG24QH2qw5JQtxkwfhuN8Xj6?=
 =?us-ascii?Q?tiRrDfxwCnZqgKxrXz5DCgE6p3zxdybpcZwrhgRfFFuKJUQtPGF3tA7iTUe2?=
 =?us-ascii?Q?4MejeYnuWKcKfzVsZ0f1V6hhjQQJHoJnt3WSnT9ufLQ2X5fbe04U7SIBJjtK?=
 =?us-ascii?Q?uCmaKO0stg5iPfkefwxa/dWl3WbO/afLJ52ZPWF87S6URcrmVjewIOsPU1zL?=
 =?us-ascii?Q?sxo9OqtmdM6Y5t4Ksk0IQVg1dzjia+AgitZpxqJhbiyTRHGNaXj7dL/KOZdR?=
 =?us-ascii?Q?2YRF728eYxizKUXYf29YpP5dk9eqwCrtu6CGaf3elrXpjXkL9i75VV/kQqmO?=
 =?us-ascii?Q?5HLxBYPlrPzkVd0YeIAVXGYda6JUpe5dmK2FFR5tMGTxAYAfYdskHbIeM9EX?=
 =?us-ascii?Q?KirWbTfpsgP6sbG8Lc8sq616mmHI322WERSq5zw2JGiP/E2BRRJgup2C/O5R?=
 =?us-ascii?Q?mTtv0RBXG5eEWy8XfPOGX9Ui5C4AzAhqNePUN+TS1LGPLRUTxYxqgyqdBsb+?=
 =?us-ascii?Q?zNStFRliKmmdRok5jSUSN1fkRstDDsysJZJELBxHaQomckm4g3TFfnReeOHW?=
 =?us-ascii?Q?hUkcZzYa9oqieaQkL+wiUhnAJawIeW7AWNoyRvKWmWPYwQAQv0wHF71n23n2?=
 =?us-ascii?Q?Kz8LyC+2QjcQcQZP2bFQtnEjt2aA4OLFc107nLoDW3uCIZA6BiUPLas2Vj77?=
 =?us-ascii?Q?qKPG8hFWYuBkMlCkZVDAM8XgpNXwqrslx0T4ShoVQi3/C6AU/VJpzmNxy6/8?=
 =?us-ascii?Q?lJMwKCrL0Vwt6Zd0tNZM6hbhX1x9121JyMcRkHYDjTnCztZB5BNSAziY/8Um?=
 =?us-ascii?Q?tni/W89nLWFDp/oqxMn/Klh4vJJnoYJ2ZWmhPYSNHeo/06tf38KQ5qR9dQ6g?=
 =?us-ascii?Q?aOjPnvjQRVMgl9tAqeQKbTJvHbUiW0Xf7ixTPV00w7q6CdPhO9gJXQOikhb/?=
 =?us-ascii?Q?uoIgZQC3Cmt8T1NfvhqQgueOJQs5wUJQ1ritPZ4XZj5bYCwIZFRPm8VDnGsv?=
 =?us-ascii?Q?jvAuRif7WZGVcxaKA4/TJu0dU03nJapwAYHYR+egOooS7j6s9jnTCehVD/lj?=
 =?us-ascii?Q?EO8dcns5/BX4qrcIK7ccoWilKGanWVsAqobVkkIirjPrGmjwO+mXMCFKBYSQ?=
 =?us-ascii?Q?XtaabFYbLebcmKA5ncoJsCJLegkPgsbAT6m1SJ3Q94UYpGay5KCtLWzUDD/p?=
 =?us-ascii?Q?Xv2Vd8edI/KMuwxP/nvGwtIxZ1MKCfyidhyiA8uieh3yW0Po0+eoWxv8pm4W?=
 =?us-ascii?Q?4bQj6h1I5fUAZGstbvaGvWcv13ODbJPn4EMXoWgouSa5amnwnh77g5YWoOja?=
 =?us-ascii?Q?VlCc+3FQXSEwDiC8yWefI0MunZzeFuYdAVdmynnsTP2bzCACBRKJMIqkJ1MJ?=
 =?us-ascii?Q?4On81foaV7Mlf2SytFc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cff4af5-8928-43d4-8b05-08dbc0f9e869
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:39:38.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOzFBX9fknITl3aSeQNvo1BvaEq+qHYZpeZgw2Asd4qxI6SlICSA8hm7tkJY/KoGjZhzNGCpfcZ2ypaEOdkqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 29, 2023 at 03:00:16PM +0530, Kishon Vijay Abraham I wrote:
> Hi Frank,
> 
> On 9/12/2023 3:39 AM, Frank Li wrote:
> > This commit introduces a common method for sending messages from the Root
> > Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
> > controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
> > for the BAR region by the PCI host to the message address of the platform
> > MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes
> > to the BAR region, it triggers an IRQ at the EP. This implementation serves
> > as a common method for all endpoint function drivers.
> 
> This would help avoid the polling used in current EPF drivers. Thanks!
> > 
> > However, it currently supports only one EP physical function due to
> > limitations in ARM MSI/IMS readiness.
> 
> Any such platform or architecture restrictions should not be handled in the
> endpoint core layer.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
> >   drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
> >   include/linux/pci-epc.h             |   6 +
> >   include/linux/pci-epf.h             |   7 +
> >   4 files changed, 249 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 5a4a8b0be6262..d336a99c6a94f 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -10,6 +10,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/module.h>
> > +#include <linux/msi.h>
> >   #include <linux/pci-epc.h>
> >   #include <linux/pci-epf.h>
> >   #include <linux/pci-ep-cfs.h>
> > @@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
> >   }
> >   EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
> > +/**
> > + * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
> > + *			      the space.
> > + *
> > + * @epc: the EPC device that need doorbell address and data from RC.
> > + * @func_no: the physical endpoint function number in the EPC device.
> > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > + * @num_msgs: the total number of doorbell messages
> > + *
> > + * Return: 0 success, other is failure
> > + */
> > +int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > +{
> > +	int ret;
> > +
> > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > +		return -EINVAL;
> > +
> > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > +		return -EINVAL;
> > +
> > +	if (!epc->ops->alloc_doorbell)
> > +		return 0;
> > +
> > +	mutex_lock(&epc->lock);
> > +	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);
> > +	mutex_unlock(&epc->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_alloc_doorbell);
> > +
> > +/**
> > + * pci_epc_free_doorbell() - free resource allocated by pci_epc_alloc_doorbell()
> > + *
> > + * @epc: the EPC device that need doorbell address and data from RC.
> > + * @func_no: the physical endpoint function number in the EPC device.
> > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > + *
> > + * Return: 0 success, other is failure
> > + */
> > +void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> > +{
> > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > +		return;
> > +
> > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > +		return;
> > +
> > +	if (!epc->ops->free_doorbell)
> > +		return;
> > +
> > +	mutex_lock(&epc->lock);
> > +	epc->ops->free_doorbell(epc, func_no, vfunc_no);
> > +	mutex_unlock(&epc->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_free_doorbell);
> > +
> > +static irqreturn_t pci_epf_generic_doorbell_handler(int irq, void *data)
> > +{
> > +	struct pci_epf *epf = data;
> > +
> > +	if (epf->event_ops && epf->event_ops->doorbell)
> > +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> IMO the handler should be directly implemented in the EPF drivers. There
> should be one API which returns the virq and the msi_msg to the EPF driver
> and the EPF driver should do request_irq.
> > +
> > +static void pci_epc_generic_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > +{
> > +	struct pci_epc *epc = NULL;
> > +	struct class_dev_iter iter;
> > +	struct pci_epf *epf;
> > +	struct device *dev;
> > +
> > +	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> > +	while ((dev = class_dev_iter_next(&iter))) {
> > +		if (dev->parent != desc->dev)
> > +			continue;
> 
> Ideally the msi_desc should be associated directly with the EPF device.

The key problem is platform_msi_domain_alloc_irqs only support put epc
driver's dev into desc.

IMS may resolve this problem, but ARM IMS progress is quite slow.

> > +
> > +		epc = to_pci_epc(dev);
> > +
> > +		class_dev_iter_exit(&iter);
> > +		break;
> > +	}
> > +
> > +	if (!epc)
> > +		return;
> > +
> > +	/* Only support one EPF for doorbell */
> > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > +
> > +	if (!epf)
> > +		return;
> 
> If this is a platform restriction, this should be moved elsewhere.

where is good place? 

> > +
> > +	if (epf->msg && desc->msi_index < epf->num_msgs)
> > +		epf->msg[desc->msi_index] = *msg;
> > +}
> > +
> > +
> > +/**
> > + * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
> > + *                                    controller
> > + *
> > + * @epc: the EPC device that need doorbell address and data from RC.
> > + * @func_no: the physical endpoint function number in the EPC device.
> > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > + * @num_msgs: the total number of doorbell messages
> > + *
> > + * Remark: use this function only if EPC driver just register one EPC device.
> > + *
> > + * Return: 0 success, other is failure
> > + */
> > +int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > +{
> > +	struct pci_epf *epf;
> > +	struct device *dev;
> > +	int virq, last;
> > +	int ret;
> > +	int i;
> > +
> > +	if (IS_ERR_OR_NULL(epc))
> > +		return -EINVAL;
> > +
> > +	/* Currently only support one func and one vfunc for doorbell */
> > +	if (func_no || vfunc_no)
> > +		return -EINVAL;
> > +
> > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > +	if (!epf)
> > +		return -EINVAL;
> > +
> > +	dev = epc->dev.parent;
> > +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epc_generic_write_msi_msg);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to allocate MSI\n");
> > +		return -ENOMEM;
> > +	}
> 
> The alloc_irqs should be for a EPF device IMO.

The GIC ITS driver need of_node information to alloc msi for such devices.
But EPF device have not of_node information.

> > +
> > +	last = -1;
> > +	for (i = 0; i < num_msgs; i++) {
> > +		virq = msi_get_virq(dev, i);
> > +		if (i == 0)
> > +			epf->virq_base = virq;
> > +
> > +		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,
> > +				  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i), epf);
> > +
> > +		if (ret) {
> > +			dev_err(dev, "Failed to request doorbell\n");
> > +			goto err_free_irq;
> > +		}
> > +		last = i;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free_irq:
> > +	for (i = 0; i < last; i++)
> > +		kfree(free_irq(epf->virq_base + i, epf));
> > +	platform_msi_domain_free_irqs(dev);
> > +
> > +	return -EINVAL;
> > +}
> 
> Thanks,
> Kishon
