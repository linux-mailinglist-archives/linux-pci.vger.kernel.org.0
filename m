Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06F37D012B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbjJSSLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345100AbjJSSLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 14:11:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9097A12A;
        Thu, 19 Oct 2023 11:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgf3pMmfuyF2QXFw94m2iNgUFNN2NcX3TYvEEoClbnPFmQxrz+EQNalqOaNzBbrromdSgrxzGSlb3TCuXH/vABEtPg2za49EQrZPFIESP2pebmuKOT/2/ZzBG609tbdSQeHHQy9JagiKwQBrhZib+nNuCA8uVjjPwUuGmJhuzf3YOcg5kbTQIL+opFf/9VNOtDE42xJ1H93yLd8ldYvFL4S4QVSxcazWFCLYUOCGPFqxcua55/2bXvjrqmvR2RXHOkSoTqIMwEn9OHDJdMeA5ypyG80uan+3+vj/+ojVdeseWDGzMsy3rXtb3CidF37RD1FcyMoEkvd9gG9OUWmsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZK9ASLLVISYrU8XZA8uG3Jeyz6QNjsvUFO4J1+vNU0=;
 b=gYzzcQS85O73Ea6SR3cJM5zUJibxpNha097sg8kOW9gPlUrM/EOYBFEj3wvQkySVxZPW9Ex84A3KiC2tjIPolipIyfgZyx0InFtqkf/hZPp83xSYEMTrnCYKf9EaYHWJfyvbJ6wfStUchjsuzDIMztwnr2qA1bLK1X/ePp/sYEszR9Yrm2fKESPPNBF+Q50c5aYOXjxC0JwmmXVJHFkCcIj6ToTEwElMxYPXobgj+aSxcjKNEeoS+I8gZ+o5ClX5NvMIKfmJItksJ39s0wc+kPjENkmtPfRuuUuB9exhzY1iAYv+ol+DDmIhlsNW7zW3lM5lOKLYuckRpYa9gXth1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZK9ASLLVISYrU8XZA8uG3Jeyz6QNjsvUFO4J1+vNU0=;
 b=V47eavm7FOFu9OHNd8XS6cxBetYGD1ePsfOzDkipSha1COeValYiHXb06+rhk3opDlUDX5ctmptNmyT416ptvk/IhnUB7EdJAkVtGBTA5D/3FLIoD2DOrcKdRohMbLYDvH4bcLLslSkTr9BoLJmMJ/ujoOHf0hTc74Kj6dRsV/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 18:11:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 18:11:32 +0000
Date:   Thu, 19 Oct 2023 14:11:22 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controllery
Message-ID: <ZTFxSnpqfHtVR1JJ@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-2-Frank.Li@nxp.com>
 <20231017183722.GB137137@thinkpad>
 <ZS7YvWSlkQluPtg3@lizhi-Precision-Tower-5810>
 <20231019150441.GA7254@thinkpad>
 <ZTFSlpnF41BDzyiX@lizhi-Precision-Tower-5810>
 <20231019172347.GC7254@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019172347.GC7254@thinkpad>
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c39e226-871e-48b3-a0b6-08dbd0ced2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qs8EpLWyCEKu2Uz6qyE11b+9Udt+6XXha0CQ3DjwMXe0DFisJwLlATKMl5N9lUhhs0AC4N+Xa9WzdSJfF2PvACR4Ul7wDfb7GTvVYkmBDQokJGM5ibJNmZ8tVS/664VllzrfG/N0RmW52zqxDVWJtf+WqmH6/UORtc5QKk/chKTv/ZiH74P3csUpzaU54bYCSqULRiMmG2JhRHXNQEk5MOyrYtf+UhU0yJlWPk8r1wVOr3m1qqJ8sItqU1zEank+QRElqp34LsLn8c9t9EA2GjO55oUG8Cv96FB/h/HrSzSMn86dUhsIck9uQ+5ETvXv5LLGQpUrKkG9rvEPjfAXxp3Gj88gU+vq7wmSC5FpwwgeD29T8kSPrGMAz6KldNjElZPcvBthRr2e6jT3CDsvmGCz1nHorUDM0pw6tjTo7gBdL7LKeOULXs22hOGHDfy9lMYSk0gdF+B3KOcO7hb4kO0X1ln3AdLgtot4VQLtlCwHtPVxOJSTB2Eb/VcUUzEJprGyKnPqCB2kpe+lZWz+8pjhlP67IBbfXbWu9H4UDNljBojv8oia2Vm+m01tghjyNW5WzLZaMqeht1UX4RjheTHnKL2oIo0UOMoKmCsM9p4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(86362001)(316002)(66556008)(66946007)(66476007)(6666004)(6916009)(8936002)(8676002)(478600001)(6486002)(966005)(5660300002)(4326008)(41300700001)(30864003)(7416002)(2906002)(38100700002)(6506007)(52116002)(9686003)(83380400001)(26005)(6512007)(38350700005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZlODhySEM2Rm5CS2hqeGZ6dGVieUEvTVF6RUJrVGZoWXRMRjVKV0d3c3lr?=
 =?utf-8?B?MVV3ZWpPMlc1N3RvOXBINE1EYlRYSnhqTkZiN3FJL0ZYeGdEUHlRM1F5dWMw?=
 =?utf-8?B?di9oZGxLaHpuME9GZmZwZEtmaVNyeXNVYUp2TFUrOVhDZWwxUFlFbnVoc3J2?=
 =?utf-8?B?SkloMDZyTkFTVWxKbVJCZG5Ca3FvL0xiR0VnRzBOSjk3ZHlmL1RheHE4cDlP?=
 =?utf-8?B?WUhwWndHWVZCaXFkQjB4NXhpajZuUmMzek9velpvSU5rc2pEWWlzekdCcUxz?=
 =?utf-8?B?eWUra3JRaXl3Y1VJVUQrV1VGdWRFWFpxYmZkUkdQeXkwb1VqbXdCR0JHNDBF?=
 =?utf-8?B?bE9EamFpa0QrcExsQzhCODJEcFYrNkRpK0cvTytDWlBjUURneGFDT1c3OElE?=
 =?utf-8?B?V0gxNE9jQll2WUlEcytMU1NWUTFvQ1dNMTFuSWpCTEJwNnpsaGYyTjdXVFBR?=
 =?utf-8?B?cDBWTjlBZmQzOVkzNjR4QjViZTM4MXVrb0R1dlh0SDVGSFJBb1hIc2ZQdUhK?=
 =?utf-8?B?ZC9tbStCbmFIY0pGYWxEYlBKYWJjenZiKzZncjh2c0ZYRmttSm5mV09tY3hQ?=
 =?utf-8?B?K2VSYVlYSHRva1dEMDZpVm8yRVRnOHUwVTJocmJwdWxFU1J1bHBPb1Q5LzVy?=
 =?utf-8?B?ekhDREFCNUJ1UkszdnVhMks1Z2lGUFJtRU1qUHNHSkFjb2dpUDAyUkVaNWNB?=
 =?utf-8?B?TEluajlxQWhsOWFqdzhjWERManp6MndqekRvY01ML0ljSmt6WnJWcktqSjYr?=
 =?utf-8?B?akZtcHlLUkdNdjgrMERnMnZFUXFzblR4TVlQRFBYL2FCdzkwMXZDU0FtVzg1?=
 =?utf-8?B?cXZseG4rNEpMVTlibXlZbUMydHJ5d3VRUzM1OThaNzVmRGdqemRzZG9Fc1pv?=
 =?utf-8?B?S1hxb3MwUGIzSmduU1kzeGJYcGZidDFJcVh1Z2xHSTBOelg0T2I1RGt6NzQ0?=
 =?utf-8?B?ZjQzMFZqUUpOcVVXRy9OK1ZaTUM2S0RJZGM5dHcxMWVUQ2hxUU5oalA3WFVP?=
 =?utf-8?B?c3M3NzU2R2htK1UvWHF5VXFqQlJqd0lmQ0NOVk82QWlnc1phdHJROGFMS29v?=
 =?utf-8?B?SEdabG1PR2M2ZFBoemUxZWJZN3RJYXYwTUUwL25Jbi9pbTdvTkxZU1ZIbW1m?=
 =?utf-8?B?Vy9aUk9pOG1sck9aK0lCSUw3d3JtZ0tqd3JVMllUeGhSbkhMU1FPUHRKc2da?=
 =?utf-8?B?cndTV1RtSW1NRmt4eVJHcFIxSkxMcloyTkk3cXRiTVZNWlBKK0hvMmVXOEVW?=
 =?utf-8?B?cXUyTllQcTA5ZDZ5QlZQcnVlSjdZM2NzMnBLVktheEcrd0pOOGJ0WVJnZHNC?=
 =?utf-8?B?QkpacWhFYmMwOStxdWZlcWlBOUxwdVV3eHg1eitEM0k3YVZjV3FwdnlWQlJH?=
 =?utf-8?B?cnlteVF1TVBvdUdhSlI4bG5DQXJYWE1jcGJZbXhmRHQ2dkJrdndYNldoWFAw?=
 =?utf-8?B?RnpNWE14NFFwSHB6QjBkSTVBSEdpKzdZN09xakJBemtxMU9kemVBRWttamoy?=
 =?utf-8?B?bGRFT1lDQ0pEZVEwTmZJZmpEZWJ4NGZHbGpJM0d5dmZUY3k4eU5DWlg4Zktn?=
 =?utf-8?B?VlMvdDd5dTJGZURsNjRyMjU1bEVmdC9wVXVzeWNlV2RUNzQ0cDc2dlhPdVIr?=
 =?utf-8?B?V1cxOEExZU5NTEZwYzJNU3FDRVNOMlIyNXlqbVpQNjVGWE9pTWFSTng0a0hi?=
 =?utf-8?B?S0R5WU90dVQ0aGtlc3RYL3hHKzZ2VHlkU0FFdUhRNlhHVnJFQVFjRkpLanlL?=
 =?utf-8?B?cTRPZ3Q2N21yM1ZVaHRlbHB6cHFTVHRjU2w1U2daZ2ptbTM4b3ZyQlJYOXFl?=
 =?utf-8?B?K1ZsMVJrclpaN0VzUklnNDVxU0JrMTVTWTNXY3hacEQ4aFQ5OERhcmgzeEdW?=
 =?utf-8?B?anViSTdxYW1aejljWFVBcGZZcXEwV3ZBSmZSUkVET2Z1LzVkdlIwWmxCN2lI?=
 =?utf-8?B?U2lkTzNROGpPcm16MjdkQTNjaGJobDVwTCtaNUdXUDV2cjlSWE9hUFRoVkdN?=
 =?utf-8?B?aDRPb3RXUUNGc1h3dGNJTjZ0dDYvdk5tRTBLMzBGNnppRHdHUjhGMWtTUjdR?=
 =?utf-8?B?M3ErUnlsaFRFK0dJajNkZDdOOFMzMW5rR3NoTXRBNUE0T0tUWDAyWWJPUEpr?=
 =?utf-8?Q?XCrLgnhAtMbfqTPVc//lTSqHR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c39e226-871e-48b3-a0b6-08dbd0ced2b3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 18:11:32.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZNp5jxvzEcQ7fJPyAAcnr2bJW9cu3Ua5fP9l4EJWgo40QIIxx4IVSVmKKsUCMEfWFnOwi8VgWp/kunP65y1oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 10:53:47PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Oct 19, 2023 at 12:00:22PM -0400, Frank Li wrote:
> > On Thu, Oct 19, 2023 at 08:34:41PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Oct 17, 2023 at 02:55:57PM -0400, Frank Li wrote:
> > > > On Wed, Oct 18, 2023 at 12:07:22AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Sep 11, 2023 at 06:09:16PM -0400, Frank Li wrote:
> > > > > > This commit introduces a common method for sending messages from the Root
> > > > > > Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
> > > > > > controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
> > > > > > for the BAR region by the PCI host to the message address of the platform
> > > > > > MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes
> > > > > 
> > > > > "Doorbell feature is implemented by mapping the EP's MSI interrupt controller
> > > > > message address to a dedicated BAR in the EPC core. It is the responsibility
> > > > > of the EPF driver to pass the actual message data to be written by the host to
> > > > > the doorbell BAR region through its own logic."
> > > > > 
> > > > > > to the BAR region, it triggers an IRQ at the EP. This implementation serves
> > > > > > as a common method for all endpoint function drivers.
> > > > > > 
> > > > > > However, it currently supports only one EP physical function due to
> > > > > > limitations in ARM MSI/IMS readiness.
> > > > > > 
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >  drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
> > > > > >  drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
> > > > > >  include/linux/pci-epc.h             |   6 +
> > > > > >  include/linux/pci-epf.h             |   7 +
> > > > > >  4 files changed, 249 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > > > > index 5a4a8b0be6262..d336a99c6a94f 100644
> > > > > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > > > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > > > > @@ -10,6 +10,7 @@
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/module.h>
> > > > > >  
> > > > > > +#include <linux/msi.h>
> > > > > >  #include <linux/pci-epc.h>
> > > > > >  #include <linux/pci-epf.h>
> > > > > >  #include <linux/pci-ep-cfs.h>
> > > > > > @@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
> > > > > >  
> > > > > > +/**
> > > > > > + * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
> > > > > > + *			      the space.
> > > > > 
> > > > > "Allocate platform specific doorbell IRQs to be used by the host to trigger
> > > > > doorbells on EP."
> > > > > 
> > > > > > + *
> > > > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > > > 
> > > > > EPC device for which the doorbell needs to be allocated
> > > > > 
> > > > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > > > + * @num_msgs: the total number of doorbell messages
> > > > > 
> > > > > s/num_msgs/num_db
> > > > > 
> > > > > > + *
> > > > > > + * Return: 0 success, other is failure
> > > > > > + */
> > > > > > +int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	if (!epc->ops->alloc_doorbell)
> > > > > > +		return 0;
> > > > > 
> > > > > You mentioned 0 is a success. So if there is no callback, you want to return
> > > > > success?
> > > > > 
> > > > > > +
> > > > > > +	mutex_lock(&epc->lock);
> > > > > > +	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);
> > > > > 
> > > > > Why can't you just call the generic function here and in other places instead of
> > > > > implementing callbacks? I do not see a necessity for EPC specific callbacks. If
> > > > > there is one, please specify.
> > > > 
> > > > 1. Refer v1 your comments.
> > > > https://lore.kernel.org/imx/20230906145227.GC5930@thinkpad/
> > > 
> > > I do not find where I suggested the callback approach.
> > 
> > 	> > > If that, Each EPF driver need do duplicate work. 
> > 	> > > 
> > 	> > 
> > 	> > Yes, and that's how it should be. EPF core has no job in supplying the of_node.
> > 	> > It is the responsibility of the EPF drivers as they depend on OF for platform
> > 	> > support.
> > 	> 
> > 	> EPF driver still not depend on OF. such pci-epf-test, which was probed by
> > 	> configfs.
> > 	> 
> > 
> > 	Hmm, yeah. Then it should be part of the EPC driver.
> > 
> > 	Sorry for the confusion.
> > 
> > Here, all "EPF" should be "EPC". The key problem is of_node. EPC core have
> > not of_node, EPC core's parent driver (like dwc-ep driver) have of_node. 
> > 
> > pci_epc_generic_alloc_doorbell(dev), dev is probed by platform driver, such
> > as dwc-ep, which have of_node,  EPC core will create child device.
> > 
> > dwc-ep device
> >  |- epc core device
> > 
> > we can direct call pci_epc_generic_alloc_doorbell(epc->parent) here.
> > 
> > I may miss understand what your means. I think you want to dwc-ep
> > (with of_node) handle these alloc functions. 
> > 
> 
> My comment was to have just one function definition. But looking at it again, I
> think it is better to move all the (alloc, free, write_msg) definitions to
> dwc-ep, since the contents of those functions are not EPC core specific.

There are still problem. (alloc, free, write_msg) is quite common for all
controller and the system with MSI.

If move these into dwc-ep,  cdns or other controller have to duplicate 
these codes.

If you think it is not EPC core specific, how about create new help files?

Frank

> 
> In the EPC core, you can still have the callbacks specific to each EPC. This
> also solves your of_node problem.
> 
> - Mani
> 
> > > 
> > > > 2. Maybe some ep controller have built-in doorbell support. Write to some
> > > > address to trigger doorbell irq.
> > > > 
> > > 
> > > We will handle it whenever such EP controllers arrive. Until then, let's keep it
> > > simple.
> > > 
> > > - Mani
> > > 
> > > > Frank
> > > > 
> > > > > 
> > > > > > +	mutex_unlock(&epc->lock);
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(pci_epc_alloc_doorbell);
> > > > > > +
> > > > > > +/**
> > > > > > + * pci_epc_free_doorbell() - free resource allocated by pci_epc_alloc_doorbell()
> > > > > > + *
> > > > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > > > 
> > > > > Same as above.
> > > > > 
> > > > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > > > + *
> > > > > > + * Return: 0 success, other is failure
> > > > > > + */
> > > > > > +void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> > > > > > +{
> > > > > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > > > > +		return;
> > > > > > +
> > > > > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > > > > +		return;
> > > > > > +
> > > > > > +	if (!epc->ops->free_doorbell)
> > > > > > +		return;
> > > > > > +
> > > > > > +	mutex_lock(&epc->lock);
> > > > > > +	epc->ops->free_doorbell(epc, func_no, vfunc_no);
> > > > > 
> > > > > Same as suggested above.
> > > > > 
> > > > > > +	mutex_unlock(&epc->lock);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(pci_epc_free_doorbell);
> > > > > > +
> > > > > > +static irqreturn_t pci_epf_generic_doorbell_handler(int irq, void *data)
> > > > > > +{
> > > > > > +	struct pci_epf *epf = data;
> > > > > > +
> > > > > > +	if (epf->event_ops && epf->event_ops->doorbell)
> > > > > > +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> > > > > 
> > > > > Same as suggested above.
> > > > > 
> > > > > > +
> > > > > > +	return IRQ_HANDLED;
> > > > > > +}
> > > > > > +
> > > > > > +static void pci_epc_generic_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > > > > +{
> > > > > > +	struct pci_epc *epc = NULL;
> > > > > > +	struct class_dev_iter iter;
> > > > > > +	struct pci_epf *epf;
> > > > > > +	struct device *dev;
> > > > > > +
> > > > > > +	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> > > > > > +	while ((dev = class_dev_iter_next(&iter))) {
> > > > > > +		if (dev->parent != desc->dev)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		epc = to_pci_epc(dev);
> > > > > > +
> > > > > > +		class_dev_iter_exit(&iter);
> > > > > > +		break;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (!epc)
> > > > > > +		return;
> > > > > > +
> > > > > > +	/* Only support one EPF for doorbell */
> > > > > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > > > > +
> > > > > 
> > > > > No need of this newline
> > > > > 
> > > > > > +	if (!epf)
> > > > > > +		return;
> > > > > > +
> > > > > > +	if (epf->msg && desc->msi_index < epf->num_msgs)
> > > > > > +		epf->msg[desc->msi_index] = *msg;
> > > > > > +}
> > > > > > +
> > > > > > +
> > > > > 
> > > > > Remove extra newline
> > > > > 
> > > > > > +/**
> > > > > > + * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
> > > > > > + *                                    controller
> > > > > > + *
> > > > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > > > + * @num_msgs: the total number of doorbell messages
> > > > > > + *
> > > > > 
> > > > > Same comment as for pci_epc_alloc_doorbell()
> > > > > 
> > > > > > + * Remark: use this function only if EPC driver just register one EPC device.
> > > > > > + *
> > > > > > + * Return: 0 success, other is failure
> > > > > > + */
> > > > > > +int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > > > > > +{
> > > > > > +	struct pci_epf *epf;
> > > > > > +	struct device *dev;
> > > > > > +	int virq, last;
> > > > > > +	int ret;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	if (IS_ERR_OR_NULL(epc))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	/* Currently only support one func and one vfunc for doorbell */
> > > > > > +	if (func_no || vfunc_no)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > > > > +	if (!epf)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	dev = epc->dev.parent;
> > > > > > +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epc_generic_write_msi_msg);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "Failed to allocate MSI\n");
> > > > > > +		return -ENOMEM;
> > > > > > +	}
> > > > > > +
> > > > > > +	last = -1;
> > > > > > +	for (i = 0; i < num_msgs; i++) {
> > > > > 
> > > > > You should iterate over msi_desc as below:
> > > > > 
> > > > >         msi_lock_descs(dev);
> > > > >         msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> > > > > 		...
> > > > > 	}
> > > > > 	msi_unlock_descs(dev);
> > > > > 
> > > > > > +		virq = msi_get_virq(dev, i);
> > > > > > +		if (i == 0)
> > > > > > +			epf->virq_base = virq;
> > > > > > +
> > > > > > +		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,
> > > > > 
> > > > > 	request_irq(desc->irq, ...)
> > > > > 
> > > > > > +				  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i), epf);
> > > > > > +
> > > > > > +		if (ret) {
> > > > > > +			dev_err(dev, "Failed to request doorbell\n");
> > > > > > +			goto err_free_irq;
> > > > > > +		}
> > > > > > +		last = i;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +
> > > > > > +err_free_irq:
> > > > > > +	for (i = 0; i < last; i++)
> > > > > > +		kfree(free_irq(epf->virq_base + i, epf));
> > > > > > +	platform_msi_domain_free_irqs(dev);
> > > > > > +
> > > > > > +	return -EINVAL;
> > > > > 
> > > > > 	return ret;
> > > > > 
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(pci_epc_generic_alloc_doorbell);
> > > > > > +
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > > > > index 3f44b6aec4770..485c146a5efe2 100644
> > > > > > --- a/include/linux/pci-epf.h
> > > > > > +++ b/include/linux/pci-epf.h
> > > > > > @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
> > > > > >  	int (*link_up)(struct pci_epf *epf);
> > > > > >  	int (*link_down)(struct pci_epf *epf);
> > > > > >  	int (*bme)(struct pci_epf *epf);
> > > > > > +	int (*doorbell)(struct pci_epf *epf, int index);
> > > > > 
> > > > > kdoc missing.
> > > > > 
> > > > > >  };
> > > > > >  
> > > > > >  /**
> > > > > > @@ -180,6 +181,9 @@ struct pci_epf {
> > > > > >  	unsigned long		vfunction_num_map;
> > > > > >  	struct list_head	pci_vepf;
> > > > > >  	const struct pci_epc_event_ops *event_ops;
> > > > > > +	struct msi_msg *msg;
> > > > > > +	u16 num_msgs;
> > > > > 
> > > > > num_db
> > > > > 
> > > > > You also need to add kdoc for each new member.
> > > > > 
> > > > > - Mani
> > > > > 
> > > > > -- 
> > > > > மணிவண்ணன் சதாசிவம்
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
