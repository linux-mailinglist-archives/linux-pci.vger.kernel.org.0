Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B335793EF5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbjIFOeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjIFOeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 10:34:19 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419F199B;
        Wed,  6 Sep 2023 07:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ7eKsjrJ28ILCOOIY//JPZ5cEynzEyn1gF8PTPQzNiBxdPtTNkWUHh3BcQeDwyUXFO+sT0VVOI90NWOm7Res7C3+fKdWPjcuIQ0lfJ+j+W+iGfdq6dPGYPRWwiS5+d3YiQJMWGiHyC0TUiPrRRr9oSJS2IsUxOgnVNxDsdJdtS5hWnhQ/eajkdqD6Q9xwyqs9/vQCRcUOMEope6DkJDaOZaDGPj9kn5Gwh0vnnwC1IETnbuaQTXql124aji/D2lJ7gXglPRdg9TnA3HIU/ZBXINeS+/hhiEMOtmwtKSDhNBipbVMcs7S2BBlaVz/jvDCxFLmqTfTQX137O1/f8qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N2+sPvSEw51/d5BnkGvWuP/bf7LFvA5z28m5QMAPwM=;
 b=EICZzbCZIwadG4UlXZc5P09Kd4MFPYaNIN60cmRZY70bVDfqX7eB1zHjwDEIEtJXSUJdEcyvEvoWbQVFG0Ffhzr6hv12ytiXPj7RjaG6yaaC1hTgdFnh1kshhtMmTIJ6Rp2L0ESbZC1VIedrRNtG7no9zOjrG+8sOce28KYdJYk587JwOIzICOO9MOiLJ25vJv7OAP3HRM4Yn1d9NIPqs3N81TOwYf0RG4yKwJH2PHZr0vZo4SHJ6AOH4KfgRhHq1JB6weg+4fGriEAaf547dao2f3CkXt/lRzm0DZfkNbZ2zrXO09+0OB4WgGi0ljBXTfn+NwGjbjB0TWc/XrvVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N2+sPvSEw51/d5BnkGvWuP/bf7LFvA5z28m5QMAPwM=;
 b=kgUspsBdV/7ewTVy+RfoL7mvMrAdJh35InHqAv0y8ks2Gsje7RfAQlbBP5k4hAYoGwtbaomxoSlBU2Ngo1fzCEzJBsO1f/fOa3w/6EY8y9BSjCmTe1soIwg+8o7a0fNrELbLgXkD/nKrpLWS2gll9XIYBHEgLBxiY3PwxQNrFgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8378.eurprd04.prod.outlook.com (2603:10a6:10:25f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:33:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:33:52 +0000
Date:   Wed, 6 Sep 2023 10:33:37 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     tglx@linutronix.de, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Message-ID: <ZPiNwQg3rDQMRA/6@lizhi-Precision-Tower-5810>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
 <20230902045214.GA2913@thinkpad>
 <20230902045328.GB2913@thinkpad>
 <ZPf/EkffMC51iLQ/@lizhi-Precision-Tower-5810>
 <20230906122605.GB5930@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230906122605.GB5930@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: da73b2c1-34f2-4e46-5726-08dbaee64a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEPyqpP9Av1EmAxt0fzP5OSzqvOjMDaWKGu4GZinW20Mmn7QixXFd5usVnWKizZePExwx4ipmp1CWenIcQqd0q5nhQ/SAWh4qRk5rYtd5olUwc+Z6JHPMBOnUaT06L+WHhuK/zmHi9aAlTeYDhOtrbf9w1rgBzifLUYuh5slhwsIW8WWPJa5WipK4XepKKROPIpU0BUtb7aw8r56PQZZqfj9axxbkLzqpwx7H9w1xP/KaFyoUroNPTbjEY7k7kgIZBdfei8NxsLWacdpgtrrEUp33JYdnnj1a9nXdH+O+V4tTJLjSOJ669gtSe9s0VSO7qRpq/6znDFWS7+sZnCwDP4omaa41G9VgfA87GiZLWvOntPop/I/bqjCgWgC70CQBpby7P1eaXuxpr7yuWiMoiiJvVRn74dYPlm3l0o7vuvOyCFeYeKlm+d5GF6O7BefvR19AdwFZO0FqvrtJeAw/rZMW9LWSIOJ5ur8YlBguaftQdYt4f4mTBRpxOOgHOtaqYueayLzvhJx+IIZGuFZC9QOEM+5Z94EE4hcuIjbqkezU8a7+Ky/JtRNlyyxkKM218A+FMhAW3uEd7BPN+qbsZX21r6P6u3Cg6+2320bU/8gellS3yLTUpHTDvGUEVC5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(39860400002)(396003)(376002)(1800799009)(186009)(451199024)(33716001)(8936002)(4326008)(8676002)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(6512007)(26005)(6486002)(6506007)(6666004)(9686003)(52116002)(41300700001)(2906002)(316002)(38350700002)(38100700002)(5660300002)(86362001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJFKy9hYzJ1TW5nbExITUlrNGtYcUhDcGkyc2drRUZadXlzZHNKenNJQVNX?=
 =?utf-8?B?MldkWGV3R2pWTjNlYm4wMGtxK0JWY1hud3VhNUdmcHp1VEh5SlVWVjN2ZHVq?=
 =?utf-8?B?RnkzazlOSzlqK0VxdGFKWWdZdjlqVEJZd2JGUklWUitSMDVuOVVUcFFBN2Ev?=
 =?utf-8?B?b2JtQWVqRjFBOWJsWGE1WmwwKzNFTFpDd25oMXNGcnN1MUtpU1RyWnBySXV2?=
 =?utf-8?B?Y25mRGgzV0hMZHpnbFlLc1hVM2JpeDU0UUpqNEhWSHBUVnAwVVAvOTRDZm4r?=
 =?utf-8?B?a3RjdUo5cDg1UTdVb3Y4c2E0ZnYrWUNFMUZmSVFXTW8yeE9jbFJ0ak5MS0FW?=
 =?utf-8?B?enRzRWRndHFyWjc3bENUMDNLUVQwak55VWdjYlhMQUZxREt2K3pMZlhkUmZr?=
 =?utf-8?B?Z3haTUg4SlZhanEwVXE2Si9rNjdWQk1OMkh4eHROc3ZjaEVHYXlVd1gyQTY1?=
 =?utf-8?B?NmJramc2U3Z3MzFMbjh4Nmt3QTJUM1BQSi91WmxucWZmOUxDWXZsS203TEp4?=
 =?utf-8?B?ZE1ERFV3SWJ0OXdhNTFKdGEvR1BnZk9NVk9udkpTSDRlamtiZmtmbHhIdndW?=
 =?utf-8?B?dDBUS2IzRUU3QlJYVmFVb3VHNUxBLzVqZ093UDM2T2F5YmxFQzdTeUxwaTk5?=
 =?utf-8?B?SE1VOXdjM1JMZjZOT2pmaEFPWGpIZU95dFZOVzZzMFRWYjNYN0duc1krWkwy?=
 =?utf-8?B?ZmNFOEt4OVR4eUpYTXlZSTQ3ZDVZMEhmbFB0ZHBVZm84a1hZQ3lvRVEwd0Mw?=
 =?utf-8?B?UEoxRFBRNTNvVTNZd2FmNFRaK1FCNWYxZktUeitkQWk4WDNNbU81Y2p4Y01V?=
 =?utf-8?B?OHMrc24veGJBZkUxWC9IU1VsZHR1ZVR4WWRxYVVaWlVRR1ZiYXRsYkFYb2cz?=
 =?utf-8?B?VU41V2xNaS8yaXRzS3hpOGVRMUgxbm9QOEZtUmhFSmo1NzNHZnRodkw3MWJN?=
 =?utf-8?B?NXBVdmFXOUY1eVg0VDBJM2xpTjhraFIrbUZTZmFxNWY2K1JYUXZpOHhqa0c2?=
 =?utf-8?B?T2hUZGZ6V3hrcTBlQ0JNYk5BZzRySzF2OHNrdlhkK2psSFZNMmI0cVk0RXRE?=
 =?utf-8?B?WGpnYk8veHdJMGc4aUpEWTYySk5yb3E4bVZvdVY5YWUzVm1WWGJEcjBPYndy?=
 =?utf-8?B?VGFBUmRGUjhMMnVTeDJFUmozejY4MnZuV3U3b1lLMjdBbENQNjB4VDJNcVZu?=
 =?utf-8?B?d3pYNng3STRwN1F2R0NKajVuK2YwUFVWTEVhQmNBZTUvQjY1anZGbDJtTFEw?=
 =?utf-8?B?OUkvdnhZTWtpcTZ0TEJHNy8zVUI3dDE3a2FzNjlLL0VBQnlNVnpDbWloMjl5?=
 =?utf-8?B?bldGQ2FRNFk2VHFmc2pTVlhUaWJhcFlHR0dkbHAzam94cVJFNy9QY05jdEVB?=
 =?utf-8?B?NXAvMGp6ckZvdERONGlQendxUXBEaVc1ZEFvYmRYRkF6bG5Yb0EvV0JlVEVj?=
 =?utf-8?B?cDFweTZSeTk0Tm5GbTNkaVlkMmxYNytncHc3Q2lTcVVpaHZaekUwN3dieTI4?=
 =?utf-8?B?eE1xeklzQ1N2QzNnWm8vL0g1NDRsc00yVEsxMExVTEtzMmNyc0pOc0Zuanp6?=
 =?utf-8?B?NFhHUCtDRWxQTzdrNi81bnEyZHdMZW1lUGZvZEQ1MHpaaHRzYStoRFlkWEpt?=
 =?utf-8?B?MzViaWNSZmpoaEc3RklDdlRYVk9ReHRBYllReGRnN3crcWx5ZDZVTHQzQnVm?=
 =?utf-8?B?dFQvU0EzYmdGeHplK2hFamsrcXJmSi8yaDF2UHVjRGFKUUVpZlQrVmZZdWJx?=
 =?utf-8?B?Ky9wV1ArQWhlaDBXTFJOWnRTd3RMMU5NZG4rMzVFTzhGVW5iSGIya3pBakgr?=
 =?utf-8?B?bHN5aDdaRXp2Myt1U2I2R0NWTGxOTkRiT1RyaGJGdis2MDVyalFzSUZjZGtK?=
 =?utf-8?B?djdOVFNHMGQ0L3BhOWR0Zlh4ZkY2STNEbUVnampWdEU5TEFiZm56dFF3bVU5?=
 =?utf-8?B?Q1MxUGRqVDh4M2VPTXhTbmRHcXJEcy9GUkNhZjcwdENLT0R1V2x6VnRhd0Rn?=
 =?utf-8?B?ZHF2L0dwMnB1bUJ2UEMwNXJNM051OXk2R1U1YytpbE05Wnk1cm9oVEdJUW96?=
 =?utf-8?B?QU0raVc4OGREb3hvTmlwSnBVNXltSWRyUndpRXZ0RFJwR0JJKy9yeTRvQ0NW?=
 =?utf-8?Q?K6lDG2hjNjjnY54s8xjLTWlF7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da73b2c1-34f2-4e46-5726-08dbaee64a97
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:33:52.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72/MFexmuh81M8/N/LIcvmvm4hf5fFOIB9ngk1BShcS+7ZMeoAX6DY2ZDrwHg4ucJT9AX7OZwScdYXbwHCTS7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 06, 2023 at 05:56:05PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 06, 2023 at 12:24:50AM -0400, Frank Li wrote:
> > On Sat, Sep 02, 2023 at 10:23:28AM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Sep 02, 2023 at 10:22:25AM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Apr 26, 2023 at 04:34:34PM -0400, Frank Li wrote:
> > > > > This commit introduces a common method for sending messages from the Root Complex
> > > > > (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt controller,
> > > > > such as ARM GIC, as an EP doorbell. Maps the memory assigned for the BAR region
> > > > > by the PCI host to the message address of the platform MSI interrupt controller
> > > > > in the PCI EP. As a result, when the PCI RC writes to the BAR region, it triggers
> > > > > an IRQ at the EP. This implementation serves as a common method for all endpoint
> > > > > function drivers.
> > > > > 
> > > > > However, it currently supports only one EP physical function due to limitations
> > > > > in ARM MSI/IMS readiness.
> > > > > 
> > > > 
> > > > I've provided generic comments below, but I will do one more thorough review
> > > > after seeing epf-test driver patch.
> > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  drivers/pci/endpoint/pci-epf-core.c | 109 ++++++++++++++++++++++++++++
> > > > >  include/linux/pci-epf.h             |  16 ++++
> > > > >  2 files changed, 125 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > > > > index 355a6f56fcea..94ac82bf84c5 100644
> > > > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > > > @@ -6,10 +6,12 @@
> > > > >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > > >   */
> > > > >  
> > > > > +#include <linux/irqreturn.h>
> > > > 
> > > > Why is this needed?
> > > > 
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/dma-mapping.h>
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/module.h>
> > > > > +#include <linux/msi.h>
> > > > >  
> > > > >  #include <linux/pci-epc.h>
> > > > >  #include <linux/pci-epf.h>
> > > > > @@ -300,6 +302,113 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
> > > > >  
> > > > > +static enum irqreturn pci_epf_interrupt_handler(int irq, void *data)
> > > > 
> > > > static irqreturn_t
> > > > 
> > > > s/pci_epf_interrupt_handler/pci_epf_doorbell_handler
> > > > 
> > > > > +{
> > > > > +	struct pci_epf *epf = data;
> > > > > +
> > > > > +	if (epf->event_ops && epf->event_ops->doorbell)
> > > > > +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> > > > > +
> > > > > +	return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > > > +{
> > > > > +	struct pci_epc *epc = container_of(desc->dev, struct pci_epc, dev);
> > > > > +	struct pci_epf *epf;
> > > > > +
> > > > > +	/* Todo: Need check correct epf if multi epf supported */
> > > > > +	list_for_each_entry(epf, &epc->pci_epf, list) {
> > > > > +		if (epf->msg && desc->msi_index < epf->num_msgs)
> > > > > +			epf->msg[desc->msi_index] = *msg;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_msgs)
> > > > > +{
> > > > > +	struct irq_domain *domain;
> > > > > +	struct pci_epc *epc;
> > > > > +	struct device *dev;
> > > > > +	int virq;
> > > > > +	int ret;
> > > > > +	int i;
> > > > > +
> > > > > +	epc = epf->epc;
> > > > > +	dev = &epc->dev;
> > > > 
> > > > "epc_dev" to make it explicit
> > 
> > All other place use 'dev', I think better keep the consistent.
> > 
> > Frank
> > > > 
> > > > > +
> > > > > +	/*
> > > > > +	 * Current only support 1 function.
> > > > 
> > > > What does this mean exactly? Even a single EPC can support multiple EPFs
> > > > 
> > > 
> > > Please ignore above comment.
> > > 
> > > - Mani
> > > 
> > > > > +	 * PCI IMS(interrupt message store) ARM support have not been
> > > > > +	 * ready yet.
> > > > 
> > > > No need to mention platform irq controller name.
> > 
> > what's means?
> > 
> 
> "PCI IMS ARM support" is not needed. Just say that only one EPF is supported.
> 
> > > > 
> > > > > +	 */
> > > > > +	if (epc->function_num_map != 1)
> > > > 
> > > > Why can't you use, epf->func_no?
> > > > 
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > > +	domain = dev_get_msi_domain(dev->parent);
> > > > > +	if (!domain)
> > > > > +		return -EOPNTSUPP;
> > > > 
> > > > Newline
> > > > 
> > > > > +	dev_set_msi_domain(dev, domain);
> > > > > +
> > > > > +	/* use parent of_node to get device id information */
> > > > > +	dev->of_node = dev->parent->of_node;
> > > > > +
> > > > 
> > > > Why do you need of_node assignment inside EPF core?
> > 
> > GIC need it to allocate a MSI irq to platform devices.
> > I think it may improve if IMS support.
> > 
> 
> Can't you assign it in the EPF driver itself? I do not want any OF reference in
> the EPF core since it has no OF support.

If that, Each EPF driver need do duplicate work. 

IMS will support per-device MSI domain, then we can implement customized
MSI irq allocated. But so far, it is simplest solution, we can update it
after IMS implementation at kernel. Only one place need be changed.

Frank Li 

> 
> - Mani
> 
> > Frank
> > 
> > > > 
> > > > > +	epf->msg = kcalloc(num_msgs, sizeof(struct msi_msg), GFP_KERNEL);
> > > > > +	if (!epf->msg)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	epf->num_msgs = num_msgs;
> > > > > +
> > > > 
> > > > Move this to the start of the function, after checks.
> > > > 
> > > > > +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epf_write_msi_msg);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Can't allocate MSI from system MSI controller\n");
> > > > 
> > > > "Failed to allocate MSI"
> > > > 
> > > > > +		goto err_mem;
> > > > 
> > > > err_free_mem
> > > > 
> > > > > +	}
> > > > > +
> > > > > +	for (i = 0; i < num_msgs; i++) {
> > > > > +		virq = msi_get_virq(dev, i);
> > > > > +		if (i == 0)
> > > > > +			epf->virq_base = virq;
> > > > > +
> > > > > +		ret = request_irq(virq, pci_epf_interrupt_handler, 0,
> > > > > +				  "pci-epf-doorbell", epf);
> > > > 
> > > > IRQ name should have an index, otherwise all of them will have the same name.
> > > > 
> > > > > +
> > > > > +		if (ret) {
> > > > > +			dev_err(dev, "Failure request doorbell IRQ\n");
> > > > 
> > > > "Failed to request doorbell"
> > > > 
> > > > > +			goto err_irq;
> > > > 
> > > > err_free_irq
> > > > 
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	epf->num_msgs = num_msgs;
> > > > 
> > > > Newline
> > > > 
> > > > > +	return ret;
> > > > > +
> > > > > +err_irq:
> > > > > +	platform_msi_domain_free_irqs(dev);
> > > > > +err_mem:
> > > > > +	kfree(epf->msg);
> > > > > +	epf->msg = NULL;
> > > > > +	epf->num_msgs = 0;
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> > > > > +
> > > > > +void pci_epf_free_doorbell(struct pci_epf *epf)
> > > > > +{
> > > > > +	struct pci_epc *epc;
> > > > > +	int i;
> > > > > +
> > > > > +	epc = epf->epc;
> > > > > +
> > > > > +	for (i = 0; i < epf->num_msgs; i++)
> > > > > +		free_irq(epf->virq_base + i, epf);
> > > > > +
> > > > > +	platform_msi_domain_free_irqs(&epc->dev);
> > > > > +	kfree(epf->msg);
> > > > > +	epf->msg = NULL;
> > > > > +	epf->num_msgs = 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
> > > > > +
> > > > >  static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
> > > > >  {
> > > > >  	struct config_group *group, *tmp;
> > > > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > > > index b8441db2fa52..e187e3ee48d2 100644
> > > > > --- a/include/linux/pci-epf.h
> > > > > +++ b/include/linux/pci-epf.h
> > > > > @@ -75,6 +75,7 @@ struct pci_epf_ops {
> > > > >  struct pci_epc_event_ops {
> > > > >  	int (*core_init)(struct pci_epf *epf);
> > > > >  	int (*link_up)(struct pci_epf *epf);
> > > > > +	int (*doorbell)(struct pci_epf *epf, int index);
> > > > >  };
> > > > >  
> > > > >  /**
> > > > > @@ -173,6 +174,9 @@ struct pci_epf {
> > > > >  	unsigned long		vfunction_num_map;
> > > > >  	struct list_head	pci_vepf;
> > > > >  	const struct pci_epc_event_ops *event_ops;
> > > > > +	struct msi_msg *msg;
> > > > > +	u16 num_msgs;
> > > > > +	int virq_base;
> > > > >  };
> > > > >  
> > > > >  /**
> > > > > @@ -216,4 +220,16 @@ int pci_epf_bind(struct pci_epf *epf);
> > > > >  void pci_epf_unbind(struct pci_epf *epf);
> > > > >  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> > > > >  void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> > > > > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
> > > > > +void pci_epf_free_doorbell(struct pci_epf *epf);
> > > > > +
> > > > > +static inline struct msi_msg *epf_get_msg(struct pci_epf *epf)
> > > > > +{
> > > > > +	return epf->msg;
> > > > > +}
> > > > > +
> > > > > +static inline u16 epf_get_msg_num(struct pci_epf *epf)
> > > > > +{
> > > > > +	return epf->num_msgs;
> > > > > +}
> > > > 
> > > > I don't see a need for these two functions as they are doing just dereferences.
> > > > 
> > > > - Mani
> > > > 
> > > > >  #endif /* __LINUX_PCI_EPF_H */
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
