Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D417B34DC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 16:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjI2O0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjI2O0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 10:26:45 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8991B4;
        Fri, 29 Sep 2023 07:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMEJobw1V2LW9pQ1uQDTg6lZsy8Sp4TgkXdM637JEYcvJ0qU3xXN/UlkRnHOKRLAxLBQnufMWmvE6Tn1A3Knxg2ic7Uy06vFxYdhyTw8F1602dZAVYios9kdR0UcTBLsIdTzz8JTsIZjtL7w7C8gIdUSwxHoQcjY2rltE8xFMA2O/uGRj+tlUnuqK7Gt7lM/kL0tBlWSG26af5PKwMZPTJqA9NDIoLtl1Dmr96CeaR1pVezqo6WqSCwQd/KI1ZEjCO5N7FyJQpQtiNqLoQOe/KdfYb0UOckrs+EGTZQehwVxGDbKTBq64l+W/X1VlG5EEb74U7BpAmtKYkg5Or2j6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHj0ZBhPNoGfVNDTM0inqX5CZ/XSlSEWlHMZccKvNb4=;
 b=c+9wsICjKY2HqQx3r7E/iMy6iNLk5jyw6fXjf7ooCybd7dyMpdEGa58DHB9taj1gK/rPySnvgGhzGlo6b2OQn7BXDGgEFGlPEGvjYmXCCcFEEefHeYib1pYWO1rT1kf6vJIvCEamAQ3xinUyDx62GfsO1yMR68YeYEju0oFZdO8yp3PISsRzwBkfJwVTMoYTtS9+Smcm1id+bCW1gLpJd3ReKYLb2ITiwFEz5GWceL4Y7poIKobe1Vfi8rg5W4Fp0SvhfhuloYqorBJFdIZXP7nviVjP5/8+zmxlWcXizlUCZwGlHtyjlsYjWVjwX1Akt+/PF1lZHP+1RthDBMjppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHj0ZBhPNoGfVNDTM0inqX5CZ/XSlSEWlHMZccKvNb4=;
 b=WzqmRlPIowCen82AHZwxCBsIrLu2pZPcuKi74ejqZLRPsnmDSb4lOkH/mz5Of6iXsDopo+2qD8gCvXZDGdc5zh41JLX04cMo6uyVfYOSdvAfDB6esiO4l1GDN0t54Mlaw385YyX4sMGCRIPFBu/dejikiBgmOWyglZTOxxB0L20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 14:26:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 14:26:39 +0000
Date:   Fri, 29 Sep 2023 10:26:25 -0400
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
Subject: Re: [PATCH v2 3/5] PCI: endpoint: pci-epf-test: add doorbell test
Message-ID: <ZRbeketQ/Mje2cuw@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-4-Frank.Li@nxp.com>
 <f89afd2c-8870-077c-b4b4-368784f6d54c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89afd2c-8870-077c-b4b4-368784f6d54c@amd.com>
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ad68db-c33b-4b5a-9e92-08dbc0f817c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuOurEA9Wr3FCf1b9KII8GTaWR1Dj9OmxL0j2Iw2ANIFgM/vWjHq8727yPQv/ZqktQzxIpQLKryT6olZ7MByJlxTnbPLfSBiO6MmTfBf5qA2BMyp8OAwN8QKfkceEL7xU8F/fs9MuvtHtqlR6x7zdaDxJR6CeeIPiRtTPHOkTW4q2Wy3FieHF0EHePQOkZRsza5wtHT8RybJ1Po5u8w3Nt/Uc3r7/VArhinWKBYTlLES7YvFbAckozPXr9uM6Lb5KDcZKzeN3i9Cqx7mlh1tt950wW8DFaPQjta0KNq10F1dW2POAIMSlZuEg0XLfpKqGf2UoelCW2ECm+Sg8S9AREVGHungJhaSM7ZNv+ZCAXsXKVSlyM6lD+7cuEv39Eh8zGq/pbr9QLmpyRd5+lekuLFGQoJgr0UFEfKgsQHgavxVJbEzugt7HfwzpPFyE/KPvJmIx5PE4bf7Mg8qHx/v/hJjL35B5eX5rlcpe9HGA4EvDUkBZuQuwu7lXpVJPuu4SRfmyUsEcUuZQJGfQuQRwkIM9SN0QNMu7scLkHFHHi+4PVe6uJUf43EbBWJIGZfj22BQ+zoOKBUC2BPPCkvjDPCJP6fg2W3kUQVlIHc6oweYUxpVWUM1BsMlR1SrWsvP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6666004)(6506007)(2906002)(38100700002)(6486002)(66946007)(7416002)(83380400001)(478600001)(6512007)(9686003)(26005)(66476007)(53546011)(5660300002)(66556008)(52116002)(6916009)(8936002)(8676002)(316002)(41300700001)(4326008)(86362001)(38350700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSmtoFuuVcLyYRoom06jb+Yvjq+DNvahHfP+F02T4mDzqSeUMbqTox/D+rTw?=
 =?us-ascii?Q?z0D0HwKVU7a6wNOUWvVU8STyn/G5aD40oR9mPf8Rk0EXh9wBZyUM03ehI3n0?=
 =?us-ascii?Q?LcOedgD2MeYCDqVe9yZe0zzUAm0YK7pRSzU9a61gf3F3ns5B+HdBZ1vABT5X?=
 =?us-ascii?Q?tLZezJ6jHwSZYaJCXLEUisvs50UwluRnsz+E1OcfIpw0xLmbIKAr1gctTk2A?=
 =?us-ascii?Q?DWxudYSWWzOuG+9rMSrQtXN40IlqG0PXLR7x+R7FYZtra8Zid84PxjHUuwCN?=
 =?us-ascii?Q?A2psVW8oCKfM1rhsDZsH/TVOobtAfigvjIRgwmfi9G+SqX7VQRU5b6pGztxC?=
 =?us-ascii?Q?hBJfiOHwBr02BrnZNGMhMxa8gAgjgPeUXrNpFEdE+jbhhQRB1W6xLEYTNwUg?=
 =?us-ascii?Q?RBuVehDMJz0ZSwDDrV9PCKjFv5fmzxrGm3vI/YQItwAnZwlEeV4OxXPlduoO?=
 =?us-ascii?Q?wmSplXWigKtrKO91tDhiVJa74yeHjGahfUCQ5mFHOu9yLFgi3kkZzfvorB8X?=
 =?us-ascii?Q?NaEeJuJ4KvLCq/Dn55xNQeJbjQT0+eCX52XVP+7HjNPnu/GLnqD23R+oFTOP?=
 =?us-ascii?Q?13S4wEHTKj+KeCNdoS/APBRjWeTJerGyT3Rd7G5FOQ3ki1M1ca8fzDUOQUrH?=
 =?us-ascii?Q?n7ZTu3uSVBoH4icFbF1F300HxjU3tu3W1o6OjurL2xYUFG5WfN+De+lSKNzM?=
 =?us-ascii?Q?RKm9ND9XHjp8dBeVTCAB/WKDPmrcFsXL7VCXMbDinPfEAiJGjNgjFVM7xeJU?=
 =?us-ascii?Q?SeZW49t5BL+7qmXzhRrCEMG/edC0UADgpdGfuWtFHlBGw/GJTI4RzDIX1Gtn?=
 =?us-ascii?Q?wjxltYp5U8qYGnRWXRDwaeQgj/Xzb459KhMy8Hvj8S8x8l2Y7EWgU/WMTI/f?=
 =?us-ascii?Q?OhZbccGuGq7mxuPkFDXYeGKWmW0UPAUY5O2e7bzg3/9EW9uwvk9lgDUWm5AZ?=
 =?us-ascii?Q?KL/gFX4hYo1m8ScguUgtptTl5EsYqnR2QD+VjodUq6pifOiug8bY5P0erApA?=
 =?us-ascii?Q?mlO365N65QRyOVkFmtNia45JXFXHuCnMiiA7FOmKFBj31aecJNlQoS8kwvRg?=
 =?us-ascii?Q?3ZyM2H/xj/Gor5djc2A1aX+GVWcfmH1AsE7IvrVhrzDr8VTFszHVoW/GX9v1?=
 =?us-ascii?Q?ByxWFyZv53Z5tQBTE1zY2sK4t2CLVC873Gu5aAzjREnCJoEQ1UsRMEEswWJG?=
 =?us-ascii?Q?s+ggkLKwczd93uI/pAMX+5LlXLzU9o/VpXzKhgsLBtpjZZsxuSyvtdcRCK0t?=
 =?us-ascii?Q?00fLHeHaruF+2teTzDKrfXsdkrhGrH7zl7zujqHte7zkJhKDyIOmUwesbycy?=
 =?us-ascii?Q?qWcc+SX3Vqru2zO65IcaH/u0YE2y4M/GYdeeP3rn6bdFlDsP+YLjgWn2m5Gd?=
 =?us-ascii?Q?POMrCj0KHHaNNQv+lpqkR6N7nCy4qvH7jEqKhOnEswV3ndCM9mksqKg6rlT2?=
 =?us-ascii?Q?O+YIqcXFw0WkxZU1Elm6az83y+N5oNtCrul7bbT1t6DQQUgvIqKomu7OKUat?=
 =?us-ascii?Q?bOeK3Otjr/j1T1rW+r0MGsGT0VMoSJhAX7vmBj8zauWgRk7yup4UfA0OgyhN?=
 =?us-ascii?Q?hTJcb7OH78kBj9LeOdM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ad68db-c33b-4b5a-9e92-08dbc0f817c0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:26:38.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgF6wJKW22EUNXgFQ5Q+y7mwiWN+u/hVuFu+pOMGhS5nlMsb1eAcILgi6gK+arU4w3NFUPV5O2vuK3ycdayImg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 29, 2023 at 03:03:35PM +0530, Kishon Vijay Abraham I wrote:
> Hi Frank,
> 
> On 9/12/2023 3:39 AM, Frank Li wrote:
> > Add three register: doorbell_bar, doorbell_addr, doorbell_data,
> > doorbell_done. Call pci_epf_alloc_doorbell() all a doorbell address space.
> > 
> > Root complex(RC) side driver can trigger pci-epc-test's doorbell callback
> > handler by write doorbell_data to mapped doorbell_bar's address space.
> > 
> > pci-epc-test will set doorbell_done in doorbell callback.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   drivers/pci/endpoint/functions/pci-epf-test.c | 59 ++++++++++++++++++-
> >   1 file changed, 58 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 1f0d2b84296a3..566549919b87b 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/dmaengine.h>
> >   #include <linux/io.h>
> >   #include <linux/module.h>
> > +#include <linux/msi.h>
> >   #include <linux/slab.h>
> >   #include <linux/pci_ids.h>
> >   #include <linux/random.h>
> > @@ -39,17 +40,21 @@
> >   #define STATUS_IRQ_RAISED		BIT(6)
> >   #define STATUS_SRC_ADDR_INVALID		BIT(7)
> >   #define STATUS_DST_ADDR_INVALID		BIT(8)
> > +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> >   #define FLAG_USE_DMA			BIT(0)
> >   #define TIMER_RESOLUTION		1
> > +#define MAGIC_VERSION_MASK		GENMASK(7, 0)
> > +
> >   static struct workqueue_struct *kpcitest_workqueue;
> >   struct pci_epf_test {
> >   	void			*reg[PCI_STD_NUM_BARS];
> >   	struct pci_epf		*epf;
> >   	enum pci_barno		test_reg_bar;
> > +	enum pci_barno		doorbell_bar;
> >   	size_t			msix_table_offset;
> >   	struct delayed_work	cmd_handler;
> >   	struct dma_chan		*dma_chan_tx;
> > @@ -74,6 +79,9 @@ struct pci_epf_test_reg {
> >   	u32	irq_type;
> >   	u32	irq_number;
> >   	u32	flags;
> > +	u32	doorbell_bar;
> 
> You could extend test_reg_bar for doorbell to avoid using additional BAR.

It is sperated physical address space. So far, epc still not support map
two difference physcial address space into a bar.

So I have to use a sperate pci bar for doorbell.

Frank

> 
> 
> > +	u32	doorbell_addr;
> > +	u32	doorbell_data;
> >   } __packed;
> 
> Thanks,
> Kishon
