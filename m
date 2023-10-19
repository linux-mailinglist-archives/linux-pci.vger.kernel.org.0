Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC997CFEEF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345848AbjJSQAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjJSQAj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 12:00:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C8106;
        Thu, 19 Oct 2023 09:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPVqqTZs3q+cOHWzVzfkurNS/WsloWyfDw26F73h33wNLn9NWw3McP/Ce5azsFq8D4Ub183emnDa5M7ZVbRa1zgZQcKfu4VS8KuYNkJSnA/fcV61ld0UO0BOgVkJi6NR+Y3M7leICkQkWc0D9FVGMDeMHOPhuXSFaC6UmFB9cWk+7mSKse/0aGo1Z/hvDzTaNeS96fEC+CrRjCVVmyuo9jWVuDx/geERU0tEcZwnXR5ewLFcdT6Bu7KCf3J1rGNtww/hIW0T4IDz5IV6illkk6ABAxKZdpDyoAKcZFhLrlchUJrMu5TSPBRDz/bDEL17imxcVf1/H+1LjEaT3GwIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh5xBFCy9VfUJuzQwewwgPgDu25RYnjbzWzS4+ly7hk=;
 b=nSkNGRQljKLBSHKI1wULIoJJX+ExgxJw9NpFPlYPFCIpw74x4BcT1ho1cTu/XehB7AeTytRFimGLDwD2i9qceErCD0K/7HfWFiOS2/xW/yisJNlLvmH/EN4PuM+AbvSTnuewMMHvxQKetXYzI+TqiD/qjMk8bVv7fOWuXygFDI345RVRC1c9uQ37HALlIGx7pDDhY5Jnlu+8Rgp3kN6uKoXc+9aWavj1lYRiJQpAaBUTAWtPKcSeYPIfNuvWzbEaOPZ46EGDWbr0rc5PyU8wNiRXX7VG7jszseCaSFHwLkt+qdv3QRLowmIbyEg9Y8gd8UjyLNDMy1XIWRa6mvOymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh5xBFCy9VfUJuzQwewwgPgDu25RYnjbzWzS4+ly7hk=;
 b=JB2CuYKai3IcqW3ma3D6/9reJqTsVrSH50qFvwRrlZz89gZBhA64P9MmDxHxUcGmatZLddAVgTQ72CjHroFv7QkVNTmAomHQVwCU/Jk2xr3R7B70p3y49Tae7RPBT7llhXKx2iniEgD1fEz6szM478cFpdYBF2iUwUpYEmhPWhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7675.eurprd04.prod.outlook.com (2603:10a6:10:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 16:00:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 16:00:33 +0000
Date:   Thu, 19 Oct 2023 12:00:22 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <ZTFSlpnF41BDzyiX@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-2-Frank.Li@nxp.com>
 <20231017183722.GB137137@thinkpad>
 <ZS7YvWSlkQluPtg3@lizhi-Precision-Tower-5810>
 <20231019150441.GA7254@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019150441.GA7254@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a5311a-37e8-470c-c66c-08dbd0bc864d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyPa2WV4fKz8ZK22PAd5gjNNAXboicKJ6auumLW933TAwM/voxRtpJ7BK+cz2BheowdmTBzvlSJcYV/aPrNV6t6lIMQ9H1Y9/21oP6Ocl8R+ag3nlKAgI87ji9shVWmVMv4Xr+au6yDzSdGj4cF6fPQJsUvXYbfMpDrLTcMb86oSCV6CWQplKmfblynvgYxFC+f1QjpR7Up8h/2clYKpad05yUGDhRTaP0GRntvNHx/3gxvGQc0b/ywwJxCT6V1h+tcwAn1z+jFDQsg4T9zz14bqTxVmLXqxvgxt6oWikVBAkQOzoVNjTbQbqN5R5MKvmlQtAqGOkCCJEDo3nqwuffRAWInW4v5IQmSbOCPFLelXPsrngtOapMafJAAWfLkbukRaIflww07RLMB2XnSyBHBS4UM8Dt2eEpTWZ4Yre56VYx+jTZ1m0sMLl35VlARfu8GMYK6HfEzQwLl0cpddQqegYuw8T9wwBHAsjuTFa91ZP34Tf3MWFpJrcUDsKdJ9PvoI6dB/RjtWOXq2yuIrxQgfJkFh9mebC6NWbq3aXO6/Y+pem90yHQluV77FfOZMTBRHa59mKyjOZOY8L08wjXxs22+02pfke3mCZD8SWSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(316002)(66946007)(66476007)(66556008)(6666004)(6916009)(8936002)(8676002)(478600001)(6486002)(966005)(41300700001)(5660300002)(86362001)(7416002)(4326008)(2906002)(30864003)(6506007)(38100700002)(6512007)(52116002)(9686003)(83380400001)(26005)(38350700005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2IreU1TSDNrWklqeEVBKzFxQnFnTFBRcW4vN0lnbitVT0J4amh2cDFLK0li?=
 =?utf-8?B?WHBjVUlxVlhKOXpsWlZFZ1YzUEFRcDZZaW1GNFhManhESUZuSWFYeDU1dUNt?=
 =?utf-8?B?N0p2eTc4U3I2MW5nZ0ljK25pYWhzcFZWVkhrRzFndHhEL09TZFVhaTRtdHUr?=
 =?utf-8?B?Umw3UXNzODM4R1cwai93U2FMTHRzNTlGUklqRjRXbzFZUXZyTXlYeGUza0do?=
 =?utf-8?B?eHJieCtCTTVJNUtYdUNmL2hVR0NKM1hOaXRQcUYzd2pCZ1JmMUZITlhpelR4?=
 =?utf-8?B?MVBBMjFUcDlPVXlGRzZOK2dHWGpyS2tuTTMyMDJ2amVRT0NzSXVaVEZhazRJ?=
 =?utf-8?B?Z2RUdmY0OUUvSXRodWJLRUhRcVM4ZzROelJ6OU5ZWTVVOVA3eUpyUkpzYkZt?=
 =?utf-8?B?cVBhQ2ZUTS9Wd1BOQURyd1cyOXYvZnRwdzk2SlBobHNpK3ZaWnJtc2p6TkFE?=
 =?utf-8?B?cTU5TDVrVDBxaVYvSkY2bFk0YWRPaDBpNjFFdER6ZG9wYmhLTFY5NXI0dEJJ?=
 =?utf-8?B?aGpvZUdSZWVoSkR4bTc1bGpHNkdRZmxoV3dtbk5YR2x0NVVuWnB3SlNqUVRo?=
 =?utf-8?B?QmEvUmplcThncFBBNGZPckRKcWlNNlZFZEFBNUlaK2RCbkJ6MWJ5R3V4M0Iy?=
 =?utf-8?B?clFDNi9TckFVRUo3c2U3VWZFUjlQQ0JBM2JJekplcUV2dFhlbUYvYTVPaXFi?=
 =?utf-8?B?VWsrRTJxU0JvTWFxZnBFUUljYUdIRjllQ2tyVnRsZW1sVGx6ZzBOdkVsNG04?=
 =?utf-8?B?V3k4S055RUo1aUFYYWxBU1NjV2krZXdDUGZad2ZUTFVmdzh0OG02SFp1NFo0?=
 =?utf-8?B?UHNobDZFcGZCOWVvM2RQSnlJVXhSbzJyMytvVXppT3dRR25WbG9sUlJ3b0Zh?=
 =?utf-8?B?UE1ndk1wNlMrazdKNjBoMENXYWdYa0tuaGY4MnNqWkw0dG9zUXk3ZFNhSnRQ?=
 =?utf-8?B?RXlxOHJhVGhROTNGOEFGMXM0MEcwb3dQL09ZWDNseFRVbW01OUNQREVKSjRh?=
 =?utf-8?B?SkhHd09OSXdmTmNoVGU5VjBueDRUT0s1Q1RoQ2wyYVJ5ak5JdWxDcDlBVzFZ?=
 =?utf-8?B?YTFxMXB2ZWhHb1JIRFUvbTg1WGhZdW42SFhrR0xpeWFqdlhwVWI1Y2ZhdjV5?=
 =?utf-8?B?MWM5TkkyNTIveDdUQ0UzT2hOeEtueWZyRFUxeVllT3k0MUswV281OXBZMkhY?=
 =?utf-8?B?elQrRkxueHBtaDJYODJ4cVljQ0pqbEVrWGZkbGR2ZFdwVHZsaVREanBIQXFm?=
 =?utf-8?B?dERSLzNReDRLaG50Tk50d1JEWkY4aCtQMDZUQ2FkYm1YcmlqQXExcXNXZWNV?=
 =?utf-8?B?bkg5VngvalY2NUVYbm5FaGdZR1V2a0Zya0ZLa1N3QkxpYU0vVmtpekxDSFR6?=
 =?utf-8?B?ODlZaENHSEhycUlCbk1FKzlueDcvbHNYNjRzWmtlMHRzNEc0Z1ZLRitkQzhD?=
 =?utf-8?B?Ny8ya1dqLzlmVWJTY3hjNFF5MHd4RmdLUDBTRStEZjc5TGFJSlNtU1loVjBQ?=
 =?utf-8?B?S0YrU2hTcmdFekpTeDR4dlpkUzFyRVg0N1I0UXB3QmNRc2Mwb0t6VEh4b3JN?=
 =?utf-8?B?TEdPQXhNUzJlSkM2c2JYWkVWWVVtbzFieXp6R3VLeXhqVTc3SXRqL0dkd09Q?=
 =?utf-8?B?M1JyVC9jYUhwTEQwVHRqbGtHNmJjZVhzdEZ4VUhQYjNtaE54NGJNbEZpMytP?=
 =?utf-8?B?b0l2VDk3RkRHNEw3UDJPTFlNTmVEK0xrL0hraFJOSDJBaVY4c3VJUW9MVWMx?=
 =?utf-8?B?Y0FzcHZNQXd1OWRNUkdLMERscUJHZkJ5dFJBTjFMaEFqckNzc2ZrbTNnQ2hz?=
 =?utf-8?B?Tk5UV0ZtM08zK3ZkUVo1V3REbUZNVEdMUVg3eFc0cVI2dEFwejJSajM2a3Y0?=
 =?utf-8?B?MEdJUFVPajQvM2JKeE1RWExjeU1vZTBlWHZOdXNGRzFXc09PcTJRNEpGZllN?=
 =?utf-8?B?N2VPL3V0U0ovbHZRK2xEaVRZVzNiTjJXR0l4L2VkWDQyZThsYWM4SFFFSUhF?=
 =?utf-8?B?eEQ5MjNDT3ZFdG9CTVg4U3VsN0Fia0JBMHVFcURtYUdwZ2JwREQ4STlGMkZv?=
 =?utf-8?B?THRUeXc2WTZEU1FvV3BaTzEvZXBSWGtJcW5sKzl1N1R3V2czclBKajdiMnVW?=
 =?utf-8?Q?hZSJDKjFzlrXuSilh2xCaAKjq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a5311a-37e8-470c-c66c-08dbd0bc864d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 16:00:33.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcLRPQ2dWGzw3j52AkDSAxBXvmFWRos3exjS1WQU5QXHe0vQ/yphmtLGROpZ1uOt/gDww3ftfw/qLAqVYXGB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 08:34:41PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 17, 2023 at 02:55:57PM -0400, Frank Li wrote:
> > On Wed, Oct 18, 2023 at 12:07:22AM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Sep 11, 2023 at 06:09:16PM -0400, Frank Li wrote:
> > > > This commit introduces a common method for sending messages from the Root
> > > > Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
> > > > controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
> > > > for the BAR region by the PCI host to the message address of the platform
> > > > MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes
> > > 
> > > "Doorbell feature is implemented by mapping the EP's MSI interrupt controller
> > > message address to a dedicated BAR in the EPC core. It is the responsibility
> > > of the EPF driver to pass the actual message data to be written by the host to
> > > the doorbell BAR region through its own logic."
> > > 
> > > > to the BAR region, it triggers an IRQ at the EP. This implementation serves
> > > > as a common method for all endpoint function drivers.
> > > > 
> > > > However, it currently supports only one EP physical function due to
> > > > limitations in ARM MSI/IMS readiness.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
> > > >  drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
> > > >  include/linux/pci-epc.h             |   6 +
> > > >  include/linux/pci-epf.h             |   7 +
> > > >  4 files changed, 249 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > > index 5a4a8b0be6262..d336a99c6a94f 100644
> > > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > > @@ -10,6 +10,7 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/module.h>
> > > >  
> > > > +#include <linux/msi.h>
> > > >  #include <linux/pci-epc.h>
> > > >  #include <linux/pci-epf.h>
> > > >  #include <linux/pci-ep-cfs.h>
> > > > @@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
> > > >  
> > > > +/**
> > > > + * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
> > > > + *			      the space.
> > > 
> > > "Allocate platform specific doorbell IRQs to be used by the host to trigger
> > > doorbells on EP."
> > > 
> > > > + *
> > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > 
> > > EPC device for which the doorbell needs to be allocated
> > > 
> > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > + * @num_msgs: the total number of doorbell messages
> > > 
> > > s/num_msgs/num_db
> > > 
> > > > + *
> > > > + * Return: 0 success, other is failure
> > > > + */
> > > > +int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (!epc->ops->alloc_doorbell)
> > > > +		return 0;
> > > 
> > > You mentioned 0 is a success. So if there is no callback, you want to return
> > > success?
> > > 
> > > > +
> > > > +	mutex_lock(&epc->lock);
> > > > +	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);
> > > 
> > > Why can't you just call the generic function here and in other places instead of
> > > implementing callbacks? I do not see a necessity for EPC specific callbacks. If
> > > there is one, please specify.
> > 
> > 1. Refer v1 your comments.
> > https://lore.kernel.org/imx/20230906145227.GC5930@thinkpad/
> 
> I do not find where I suggested the callback approach.

	> > > If that, Each EPF driver need do duplicate work. 
	> > > 
	> > 
	> > Yes, and that's how it should be. EPF core has no job in supplying the of_node.
	> > It is the responsibility of the EPF drivers as they depend on OF for platform
	> > support.
	> 
	> EPF driver still not depend on OF. such pci-epf-test, which was probed by
	> configfs.
	> 

	Hmm, yeah. Then it should be part of the EPC driver.

	Sorry for the confusion.

Here, all "EPF" should be "EPC". The key problem is of_node. EPC core have
not of_node, EPC core's parent driver (like dwc-ep driver) have of_node. 

pci_epc_generic_alloc_doorbell(dev), dev is probed by platform driver, such
as dwc-ep, which have of_node,  EPC core will create child device.

dwc-ep device
 |- epc core device

we can direct call pci_epc_generic_alloc_doorbell(epc->parent) here.

I may miss understand what your means. I think you want to dwc-ep
(with of_node) handle these alloc functions. 

> 
> > 2. Maybe some ep controller have built-in doorbell support. Write to some
> > address to trigger doorbell irq.
> > 
> 
> We will handle it whenever such EP controllers arrive. Until then, let's keep it
> simple.
> 
> - Mani
> 
> > Frank
> > 
> > > 
> > > > +	mutex_unlock(&epc->lock);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_epc_alloc_doorbell);
> > > > +
> > > > +/**
> > > > + * pci_epc_free_doorbell() - free resource allocated by pci_epc_alloc_doorbell()
> > > > + *
> > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > 
> > > Same as above.
> > > 
> > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > + *
> > > > + * Return: 0 success, other is failure
> > > > + */
> > > > +void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> > > > +{
> > > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > > +		return;
> > > > +
> > > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > > +		return;
> > > > +
> > > > +	if (!epc->ops->free_doorbell)
> > > > +		return;
> > > > +
> > > > +	mutex_lock(&epc->lock);
> > > > +	epc->ops->free_doorbell(epc, func_no, vfunc_no);
> > > 
> > > Same as suggested above.
> > > 
> > > > +	mutex_unlock(&epc->lock);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_epc_free_doorbell);
> > > > +
> > > > +static irqreturn_t pci_epf_generic_doorbell_handler(int irq, void *data)
> > > > +{
> > > > +	struct pci_epf *epf = data;
> > > > +
> > > > +	if (epf->event_ops && epf->event_ops->doorbell)
> > > > +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> > > 
> > > Same as suggested above.
> > > 
> > > > +
> > > > +	return IRQ_HANDLED;
> > > > +}
> > > > +
> > > > +static void pci_epc_generic_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > > +{
> > > > +	struct pci_epc *epc = NULL;
> > > > +	struct class_dev_iter iter;
> > > > +	struct pci_epf *epf;
> > > > +	struct device *dev;
> > > > +
> > > > +	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> > > > +	while ((dev = class_dev_iter_next(&iter))) {
> > > > +		if (dev->parent != desc->dev)
> > > > +			continue;
> > > > +
> > > > +		epc = to_pci_epc(dev);
> > > > +
> > > > +		class_dev_iter_exit(&iter);
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	if (!epc)
> > > > +		return;
> > > > +
> > > > +	/* Only support one EPF for doorbell */
> > > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > > +
> > > 
> > > No need of this newline
> > > 
> > > > +	if (!epf)
> > > > +		return;
> > > > +
> > > > +	if (epf->msg && desc->msi_index < epf->num_msgs)
> > > > +		epf->msg[desc->msi_index] = *msg;
> > > > +}
> > > > +
> > > > +
> > > 
> > > Remove extra newline
> > > 
> > > > +/**
> > > > + * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
> > > > + *                                    controller
> > > > + *
> > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > + * @num_msgs: the total number of doorbell messages
> > > > + *
> > > 
> > > Same comment as for pci_epc_alloc_doorbell()
> > > 
> > > > + * Remark: use this function only if EPC driver just register one EPC device.
> > > > + *
> > > > + * Return: 0 success, other is failure
> > > > + */
> > > > +int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > > > +{
> > > > +	struct pci_epf *epf;
> > > > +	struct device *dev;
> > > > +	int virq, last;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	if (IS_ERR_OR_NULL(epc))
> > > > +		return -EINVAL;
> > > > +
> > > > +	/* Currently only support one func and one vfunc for doorbell */
> > > > +	if (func_no || vfunc_no)
> > > > +		return -EINVAL;
> > > > +
> > > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > > +	if (!epf)
> > > > +		return -EINVAL;
> > > > +
> > > > +	dev = epc->dev.parent;
> > > > +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epc_generic_write_msi_msg);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to allocate MSI\n");
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > > +	last = -1;
> > > > +	for (i = 0; i < num_msgs; i++) {
> > > 
> > > You should iterate over msi_desc as below:
> > > 
> > >         msi_lock_descs(dev);
> > >         msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> > > 		...
> > > 	}
> > > 	msi_unlock_descs(dev);
> > > 
> > > > +		virq = msi_get_virq(dev, i);
> > > > +		if (i == 0)
> > > > +			epf->virq_base = virq;
> > > > +
> > > > +		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,
> > > 
> > > 	request_irq(desc->irq, ...)
> > > 
> > > > +				  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i), epf);
> > > > +
> > > > +		if (ret) {
> > > > +			dev_err(dev, "Failed to request doorbell\n");
> > > > +			goto err_free_irq;
> > > > +		}
> > > > +		last = i;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +
> > > > +err_free_irq:
> > > > +	for (i = 0; i < last; i++)
> > > > +		kfree(free_irq(epf->virq_base + i, epf));
> > > > +	platform_msi_domain_free_irqs(dev);
> > > > +
> > > > +	return -EINVAL;
> > > 
> > > 	return ret;
> > > 
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_epc_generic_alloc_doorbell);
> > > > +
> > > 
> > > [...]
> > > 
> > > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > > index 3f44b6aec4770..485c146a5efe2 100644
> > > > --- a/include/linux/pci-epf.h
> > > > +++ b/include/linux/pci-epf.h
> > > > @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
> > > >  	int (*link_up)(struct pci_epf *epf);
> > > >  	int (*link_down)(struct pci_epf *epf);
> > > >  	int (*bme)(struct pci_epf *epf);
> > > > +	int (*doorbell)(struct pci_epf *epf, int index);
> > > 
> > > kdoc missing.
> > > 
> > > >  };
> > > >  
> > > >  /**
> > > > @@ -180,6 +181,9 @@ struct pci_epf {
> > > >  	unsigned long		vfunction_num_map;
> > > >  	struct list_head	pci_vepf;
> > > >  	const struct pci_epc_event_ops *event_ops;
> > > > +	struct msi_msg *msg;
> > > > +	u16 num_msgs;
> > > 
> > > num_db
> > > 
> > > You also need to add kdoc for each new member.
> > > 
> > > - Mani
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
