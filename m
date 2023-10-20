Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4057D1551
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjJTSAb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJTSA1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 14:00:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F4D55;
        Fri, 20 Oct 2023 11:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9NWcNXPN7Q0kKpvsPKDCEJ5D1CxeDvp4SDXzDrxa+FKjAI5rJxBuoc6sosnhbaQYF4gmQNnF0t2Wpe4Fr2NDXPSl+ZDIKKnGLyFNKXntM+kzMm+HdauPRuUxT9YilYTZas14WRLkk1vH4J99sIReTwQZCiHr1IjsV7jQPTARMzD2fekfid8QtJ8E2s+3LBdHE3f88/A3bFKEmSueR5HdjyYm4iccKAko/8uPn19w5WuA1WEUi+e/OqLVbDHIr843jMA/pq+lirF/w9HiygzpwXdDIw0i0I33WKuqp2dFMtT1aOb7k8ct1D+vmhrmefKoTOkvH/0d+8mEjBiwY5Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDAkyi+VlMeJxFIoletHt4xEHdGZAAM22wWAwFiTqd8=;
 b=mbUGCHIQMbThXZiTfr2rPTVtx4gZ0SgFoJp6Zz/Mrked8Rmx2grz62qgzYq4IF3sTixK4ISbDfw1s8BSzdpNougjSR6zQ512aZe9hIpCKSaBfrdPVJfEvt3G9/wF/xnOcRA/CMcoXjzaGwseOZPS/oEWAeREptCjiLO59GQ7G9BrLg0i2WUspBX2aBf1nqnSWO8C0DTiCWTTaiHDc1VH/lxBRtz1dY11W3hZXewhDVZ1K/ZcHHfOCxmoeqhOTW8YEz/7IC97zAkVFtGYpdk4+DU02Ct5awH3AgI3t9RAbB8l3H7aZ7tnoif/Pg4gL/zsM800gZtIA6oi6TXkqCtCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDAkyi+VlMeJxFIoletHt4xEHdGZAAM22wWAwFiTqd8=;
 b=dk2eEK1qZaDi+MMS1Obqk8f7YJrfCO8TfgiJRktjgPcrtgaZaTDU/uReJ4u76dMphMltGxS/4ILpuUC8mLAJW14HBb0KczS9p5E4sM3Y6pXOnDogLUa6Vz+8NZd2My/uyy6Bnv5WwYokzHiOxtNybB4h/Z0Z3grwBBTTfGAbsHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7816.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 20 Oct
 2023 18:00:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 18:00:15 +0000
Date:   Fri, 20 Oct 2023 14:00:06 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, aisheng.dong@nxp.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        festevam@gmail.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kernel@pengutronix.de, kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controllery
Message-ID: <ZTLAJu64wL17wrPj@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-2-Frank.Li@nxp.com>
 <20231017183722.GB137137@thinkpad>
 <ZS7YvWSlkQluPtg3@lizhi-Precision-Tower-5810>
 <20231019150441.GA7254@thinkpad>
 <ZTFSlpnF41BDzyiX@lizhi-Precision-Tower-5810>
 <20231019172347.GC7254@thinkpad>
 <ZTFxSnpqfHtVR1JJ@lizhi-Precision-Tower-5810>
 <20231020171215.GA46191@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020171215.GA46191@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 5544cac5-58da-46ba-505c-08dbd19669d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAFBgs4+NX7OVcHZ0BW873Ap3WSYNYEmNKIDPNuMJJoOEy/gzm7VQjGdyO+fOu7dJBfMUl35VQBmSzgSvX90vWX97KDvl3Ja7oRktR+bjovOom0NzNWx6Ozak5r2Z1uBdmdeik/kJ8+tGJHBdcdFlUl+KOW6tgTaxB2bomZ07OQ0BhFsR6xqPzpWKX53CPzb3BZ+Zci2egFhv5uooLEV2UJU5635TpoyHZLe4CS3+IHiPs2HJmMBCe2t9I9M5JYgKh7G6KOJIDooZb3HyqXa8jsFdYWCIV24YlCOMIPJSvlu+TY/gkY+DQQtczaNb6rooDLNoqkDilvUPEAz7Le51oEzFyGKKYv9NPc0M9CgdtUnoAYfrenmlToPL2SHdvz+dqpBbnbPZHCUVqFDrXWe4UORgAVshuQ8GsKwZ6DFZqxZ3geuBfaWD14wtR/SzzUms1rUnHsE9h1EiuafcnPYicCqCIKvwTZNrRRGFnq7bee7quSrAA7ocNDFRZcifZoOhuZmoZnwTbr5JcdDN+VGIPiHeu6Pa/H9A9Pjgakitus26W26dE46r7Nx4W4Xy3PImoOKZtxtkx8Wzl0gQN1kX9t4DYzW42omZM7C+FDgTTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(26005)(2906002)(7416002)(8676002)(30864003)(4326008)(38350700005)(5660300002)(8936002)(86362001)(33716001)(52116002)(6666004)(9686003)(6506007)(6486002)(966005)(41300700001)(66556008)(66946007)(316002)(6916009)(6512007)(66476007)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS9WNUJYaXlOL2dKYVhhK3p0WitaSnZ5Z0l4VGJjUmJrMGQrR0hiU2RTaW52?=
 =?utf-8?B?UGMzNm5GSHR2V0tzdCtHSUNndGpaRFg3ZTBMRDUvMDRKQWltc3pPUHNScDhr?=
 =?utf-8?B?VWVEV0htR3I1d0R2b0ZEVDRZNHIzSyt1OTk5dTZNVlJLMXFvT3Z5aC9BT0dq?=
 =?utf-8?B?aVA2ekVBa2hQelgyY1VPRzZYQWk4R20wWWJ6NGpPRjcvc1VHMjJ6SmVlc29U?=
 =?utf-8?B?Q1RhWkRRWU91OWx1ZnFGVlBlM1dVR1dZdmYzZTM4QituNG9ibVhqVU1WVDdM?=
 =?utf-8?B?RjM1aVlpbTdzT3RjRDUrd3ZBTW54UjlKWWdtSnFUaHRRS2pOeVlVTHFvQWJM?=
 =?utf-8?B?SWNhbCtOMUYveTd1aHNjWncwMTh5QjkzVStjZWxrbnc1OForSTlnYnFSTDZC?=
 =?utf-8?B?dzJlSTRpUG1ka0x5VXdrQ253Mk50enJsd1QzUEZRdTdtSm1qMXQwOEo4UTcv?=
 =?utf-8?B?WGl5RUJZSnNFNEdPVjkyWng1YjdZaEhBQlpQWHRLU0F1Y2orSFQwZnFsNXpk?=
 =?utf-8?B?blB3Yk5hc2g1WEZqTUVUbTFkSkRIaEZHakNwZ25HZzZBQ3ZnTHVkWHdja3Zr?=
 =?utf-8?B?dUNFdFY0M3BLKzFVWk5YY2laSFVvK3VKaEREdU14VmZjVnlQKytuRVF2ZnUy?=
 =?utf-8?B?cUxZcVFlMWh1YzFxNWpjVEdINjd4UVF5THR4ZlFuTEF4bHh3cVdTclIycUNr?=
 =?utf-8?B?dmowNTlLaU5aUys1VnZpV0JzM014UEhFRWNCY2dBemlkcGZpTEZqLy8raU01?=
 =?utf-8?B?ZnU3MHFvTWd3THJuNGx6dzFkVmV6bUUxMzVQYmVSWGZPSUJyL3JVRENFdTNR?=
 =?utf-8?B?QUtaUUJubW8rVk1zdnhMQ0Nyd1lrMWlVUFdxb2xYUmx0Nkc3bmtCTEl0czFw?=
 =?utf-8?B?aENMVkVmY1VFL2tQQ0FlNUJ4MnNlL05GdngvdUdldHJwVHJDNjM5Z2JzdHI4?=
 =?utf-8?B?OHNqUVJFMjZHc2xzLzdZOWkxVDlUNlphMnRTL3FUYTJKMGVEZG42UnhRRUJj?=
 =?utf-8?B?Z1Y0NXNzaFVWcGJYejkwNFlKTnZLVC82VzFieU1KSU1zNDJLa0I4WHpFbjRj?=
 =?utf-8?B?dGVGKzZzM2NRSlFJSEhUb3lVL3JGdXMrSTNLWHduRlhidzlXN0dGazdwclI5?=
 =?utf-8?B?ODhIOVFNbTc2UDlWUVRzZHJCYURBcXA4Tm03bVdZOTdzYlVpMGtpNy9ldHJT?=
 =?utf-8?B?RGZsVXpYSlUrTnU5QnlCSW05OFBWa1ZiZ0EyM2RoOHo2OUxzVG9JVStUQmQv?=
 =?utf-8?B?ZUNDRU94RVR3YVhZZEFTRUQ5T2dSWWdOMVhrZkFHYy9ncGFGYitkS01WKzg4?=
 =?utf-8?B?c2R1THVDWkVidlFjL3lwZUZCS3FZWFpyby94dGNQZ2J2dkZSUzFWaWRrdlpI?=
 =?utf-8?B?eG1rS2k2by9VZDlyL3A4U211LzRuMnF5N0Nhd3YxSW8vTVZUS05VSy9CSmpN?=
 =?utf-8?B?VklPcm1nNy9BeFpLMExkc09lL3hpVVFuS3R5b3UxY05nL0tkSnBxRnZPa0Vs?=
 =?utf-8?B?NXdSalkyR2RsN1VZWW5QaU9NcjFRdDRCZkRZZWJ4ZXRJRHZaZVdrTnI4Rita?=
 =?utf-8?B?OFNyZXR1K0tRUlVKaXl0eGhVWFRFaHBiYjkyVDVUY2w2VnMwZExTL0lUWWVN?=
 =?utf-8?B?aGEzM1FndEFTVnVnOWR6elBSSWg4NGpWWGFIVUdYbG1rbnJ6QytyK2syazRW?=
 =?utf-8?B?MjZjWkNVcFBuU3NEWkdtUkFVTTNrd0dTNW5rNFo4MWZSYVEyMFdINXRxWWlz?=
 =?utf-8?B?K1hEQ0NpbUV6bEZOeGl4R0hhM3dUZ1NFekFVOUFyS3U0clJTMVVwSlpkSGJk?=
 =?utf-8?B?Z2NQYjF4MEc4SzZjM3lDWWh4NGtzLytnVjNyOS9vSml0Q0lDOG44MVhGdVBI?=
 =?utf-8?B?c1VWbFdWVXJjZ3Q4UU5iSXE0NkQ5R1hMMXNOU2IweW9VeFVxK1VyNXB4emkv?=
 =?utf-8?B?RnVobWhVT3ZWRHIzVjNhaytiYzFzM1VZRm52REFhV2pubVdYdFArbXAyTEFM?=
 =?utf-8?B?YjhBelRRQzMyd2poRmRrQVlDQWNmU1JKazR6RFhPeDJUeFFZSkJpbjZuTkkr?=
 =?utf-8?B?SG9sNTc4M082ZEJERUhoQmMwVnMxK2hIbWZzTzRIbGRGSTJTQU1oR1JXSjNN?=
 =?utf-8?Q?CwaA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5544cac5-58da-46ba-505c-08dbd19669d4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:00:15.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCrGt6kXEA1zviMXc2Wy0af6huv6mCrcnU3RaQsEtmXMzoClBp2MZX/GNMxPOD66/tK94aNkgHz3pYtYuJ+Zjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 10:42:15PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Oct 19, 2023 at 02:11:22PM -0400, Frank Li wrote:
> > On Thu, Oct 19, 2023 at 10:53:47PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Oct 19, 2023 at 12:00:22PM -0400, Frank Li wrote:
> > > > On Thu, Oct 19, 2023 at 08:34:41PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Oct 17, 2023 at 02:55:57PM -0400, Frank Li wrote:
> > > > > > On Wed, Oct 18, 2023 at 12:07:22AM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Mon, Sep 11, 2023 at 06:09:16PM -0400, Frank Li wrote:
> > > > > > > > This commit introduces a common method for sending messages from the Root
> > > > > > > > Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
> > > > > > > > controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
> > > > > > > > for the BAR region by the PCI host to the message address of the platform
> > > > > > > > MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes
> > > > > > > 
> > > > > > > "Doorbell feature is implemented by mapping the EP's MSI interrupt controller
> > > > > > > message address to a dedicated BAR in the EPC core. It is the responsibility
> > > > > > > of the EPF driver to pass the actual message data to be written by the host to
> > > > > > > the doorbell BAR region through its own logic."
> > > > > > > 
> > > > > > > > to the BAR region, it triggers an IRQ at the EP. This implementation serves
> > > > > > > > as a common method for all endpoint function drivers.
> > > > > > > > 
> > > > > > > > However, it currently supports only one EP physical function due to
> > > > > > > > limitations in ARM MSI/IMS readiness.
> > > > > > > > 
> > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > ---
> > > > > > > >  drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
> > > > > > > >  drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
> > > > > > > >  include/linux/pci-epc.h             |   6 +
> > > > > > > >  include/linux/pci-epf.h             |   7 +
> > > > > > > >  4 files changed, 249 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > > > > > > index 5a4a8b0be6262..d336a99c6a94f 100644
> > > > > > > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > > > > > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > > > > > > @@ -10,6 +10,7 @@
> > > > > > > >  #include <linux/slab.h>
> > > > > > > >  #include <linux/module.h>
> > > > > > > >  
> > > > > > > > +#include <linux/msi.h>
> > > > > > > >  #include <linux/pci-epc.h>
> > > > > > > >  #include <linux/pci-epf.h>
> > > > > > > >  #include <linux/pci-ep-cfs.h>
> > > > > > > > @@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
> > > > > > > >  
> > > > > > > > +/**
> > > > > > > > + * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
> > > > > > > > + *			      the space.
> > > > > > > 
> > > > > > > "Allocate platform specific doorbell IRQs to be used by the host to trigger
> > > > > > > doorbells on EP."
> > > > > > > 
> > > > > > > > + *
> > > > > > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > > > > > 
> > > > > > > EPC device for which the doorbell needs to be allocated
> > > > > > > 
> > > > > > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > > > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > > > > > + * @num_msgs: the total number of doorbell messages
> > > > > > > 
> > > > > > > s/num_msgs/num_db
> > > > > > > 
> > > > > > > > + *
> > > > > > > > + * Return: 0 success, other is failure
> > > > > > > > + */
> > > > > > > > +int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > > > > > > > +{
> > > > > > > > +	int ret;
> > > > > > > > +
> > > > > > > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	if (!epc->ops->alloc_doorbell)
> > > > > > > > +		return 0;
> > > > > > > 
> > > > > > > You mentioned 0 is a success. So if there is no callback, you want to return
> > > > > > > success?
> > > > > > > 
> > > > > > > > +
> > > > > > > > +	mutex_lock(&epc->lock);
> > > > > > > > +	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);
> > > > > > > 
> > > > > > > Why can't you just call the generic function here and in other places instead of
> > > > > > > implementing callbacks? I do not see a necessity for EPC specific callbacks. If
> > > > > > > there is one, please specify.
> > > > > > 
> > > > > > 1. Refer v1 your comments.
> > > > > > https://lore.kernel.org/imx/20230906145227.GC5930@thinkpad/
> > > > > 
> > > > > I do not find where I suggested the callback approach.
> > > > 
> > > > 	> > > If that, Each EPF driver need do duplicate work. 
> > > > 	> > > 
> > > > 	> > 
> > > > 	> > Yes, and that's how it should be. EPF core has no job in supplying the of_node.
> > > > 	> > It is the responsibility of the EPF drivers as they depend on OF for platform
> > > > 	> > support.
> > > > 	> 
> > > > 	> EPF driver still not depend on OF. such pci-epf-test, which was probed by
> > > > 	> configfs.
> > > > 	> 
> > > > 
> > > > 	Hmm, yeah. Then it should be part of the EPC driver.
> > > > 
> > > > 	Sorry for the confusion.
> > > > 
> > > > Here, all "EPF" should be "EPC". The key problem is of_node. EPC core have
> > > > not of_node, EPC core's parent driver (like dwc-ep driver) have of_node. 
> > > > 
> > > > pci_epc_generic_alloc_doorbell(dev), dev is probed by platform driver, such
> > > > as dwc-ep, which have of_node,  EPC core will create child device.
> > > > 
> > > > dwc-ep device
> > > >  |- epc core device
> > > > 
> > > > we can direct call pci_epc_generic_alloc_doorbell(epc->parent) here.
> > > > 
> > > > I may miss understand what your means. I think you want to dwc-ep
> > > > (with of_node) handle these alloc functions. 
> > > > 
> > > 
> > > My comment was to have just one function definition. But looking at it again, I
> > > think it is better to move all the (alloc, free, write_msg) definitions to
> > > dwc-ep, since the contents of those functions are not EPC core specific.
> > 
> > There are still problem. (alloc, free, write_msg) is quite common for all
> > controller and the system with MSI.
> > 
> > If move these into dwc-ep,  cdns or other controller have to duplicate 
> > these codes.
> > 
> > If you think it is not EPC core specific, how about create new help files?
> > 
> 
> Hmm, that sounds good to me. I think the best place would be:
> drivers/pci/endpoint/pci-ep-msi.c

How about header file?

int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs);     
void pci_epc_generic_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no);

Is it in include/linux/pci-epc.h, just 2 lines.

Frank
> 
> Reason is, we cannot have this generic code under drivers/pci/controller/ as it
> is not a standalone PCI controller but a platform MSI controller. So having it
> under pci/endpoint/ makes much sense to me.
> 
> And this is not specific to EPF drivers as well, so we cannot have it under
> pci/endpoint/functions/.
> 
> - Mani
> 
> > Frank
> > 
> > > 
> > > In the EPC core, you can still have the callbacks specific to each EPC. This
> > > also solves your of_node problem.
> > > 
> > > - Mani
> > > 
> > > > > 
> > > > > > 2. Maybe some ep controller have built-in doorbell support. Write to some
> > > > > > address to trigger doorbell irq.
> > > > > > 
> > > > > 
> > > > > We will handle it whenever such EP controllers arrive. Until then, let's keep it
> > > > > simple.
> > > > > 
> > > > > - Mani
> > > > > 
> > > > > > Frank
> > > > > > 
> > > > > > > 
> > > > > > > > +	mutex_unlock(&epc->lock);
> > > > > > > > +
> > > > > > > > +	return ret;
> > > > > > > > +}
> > > > > > > > +EXPORT_SYMBOL_GPL(pci_epc_alloc_doorbell);
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * pci_epc_free_doorbell() - free resource allocated by pci_epc_alloc_doorbell()
> > > > > > > > + *
> > > > > > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > > > > > 
> > > > > > > Same as above.
> > > > > > > 
> > > > > > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > > > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > > > > > + *
> > > > > > > > + * Return: 0 success, other is failure
> > > > > > > > + */
> > > > > > > > +void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> > > > > > > > +{
> > > > > > > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	if (!epc->ops->free_doorbell)
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	mutex_lock(&epc->lock);
> > > > > > > > +	epc->ops->free_doorbell(epc, func_no, vfunc_no);
> > > > > > > 
> > > > > > > Same as suggested above.
> > > > > > > 
> > > > > > > > +	mutex_unlock(&epc->lock);
> > > > > > > > +}
> > > > > > > > +EXPORT_SYMBOL_GPL(pci_epc_free_doorbell);
> > > > > > > > +
> > > > > > > > +static irqreturn_t pci_epf_generic_doorbell_handler(int irq, void *data)
> > > > > > > > +{
> > > > > > > > +	struct pci_epf *epf = data;
> > > > > > > > +
> > > > > > > > +	if (epf->event_ops && epf->event_ops->doorbell)
> > > > > > > > +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> > > > > > > 
> > > > > > > Same as suggested above.
> > > > > > > 
> > > > > > > > +
> > > > > > > > +	return IRQ_HANDLED;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void pci_epc_generic_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > > > > > > +{
> > > > > > > > +	struct pci_epc *epc = NULL;
> > > > > > > > +	struct class_dev_iter iter;
> > > > > > > > +	struct pci_epf *epf;
> > > > > > > > +	struct device *dev;
> > > > > > > > +
> > > > > > > > +	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> > > > > > > > +	while ((dev = class_dev_iter_next(&iter))) {
> > > > > > > > +		if (dev->parent != desc->dev)
> > > > > > > > +			continue;
> > > > > > > > +
> > > > > > > > +		epc = to_pci_epc(dev);
> > > > > > > > +
> > > > > > > > +		class_dev_iter_exit(&iter);
> > > > > > > > +		break;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (!epc)
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	/* Only support one EPF for doorbell */
> > > > > > > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > > > > > > +
> > > > > > > 
> > > > > > > No need of this newline
> > > > > > > 
> > > > > > > > +	if (!epf)
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	if (epf->msg && desc->msi_index < epf->num_msgs)
> > > > > > > > +		epf->msg[desc->msi_index] = *msg;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +
> > > > > > > 
> > > > > > > Remove extra newline
> > > > > > > 
> > > > > > > > +/**
> > > > > > > > + * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
> > > > > > > > + *                                    controller
> > > > > > > > + *
> > > > > > > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > > > > > > + * @func_no: the physical endpoint function number in the EPC device.
> > > > > > > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > > > > > > + * @num_msgs: the total number of doorbell messages
> > > > > > > > + *
> > > > > > > 
> > > > > > > Same comment as for pci_epc_alloc_doorbell()
> > > > > > > 
> > > > > > > > + * Remark: use this function only if EPC driver just register one EPC device.
> > > > > > > > + *
> > > > > > > > + * Return: 0 success, other is failure
> > > > > > > > + */
> > > > > > > > +int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > > > > > > > +{
> > > > > > > > +	struct pci_epf *epf;
> > > > > > > > +	struct device *dev;
> > > > > > > > +	int virq, last;
> > > > > > > > +	int ret;
> > > > > > > > +	int i;
> > > > > > > > +
> > > > > > > > +	if (IS_ERR_OR_NULL(epc))
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	/* Currently only support one func and one vfunc for doorbell */
> > > > > > > > +	if (func_no || vfunc_no)
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > > > > > > +	if (!epf)
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	dev = epc->dev.parent;
> > > > > > > > +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epc_generic_write_msi_msg);
> > > > > > > > +	if (ret) {
> > > > > > > > +		dev_err(dev, "Failed to allocate MSI\n");
> > > > > > > > +		return -ENOMEM;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	last = -1;
> > > > > > > > +	for (i = 0; i < num_msgs; i++) {
> > > > > > > 
> > > > > > > You should iterate over msi_desc as below:
> > > > > > > 
> > > > > > >         msi_lock_descs(dev);
> > > > > > >         msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> > > > > > > 		...
> > > > > > > 	}
> > > > > > > 	msi_unlock_descs(dev);
> > > > > > > 
> > > > > > > > +		virq = msi_get_virq(dev, i);
> > > > > > > > +		if (i == 0)
> > > > > > > > +			epf->virq_base = virq;
> > > > > > > > +
> > > > > > > > +		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,
> > > > > > > 
> > > > > > > 	request_irq(desc->irq, ...)
> > > > > > > 
> > > > > > > > +				  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i), epf);
> > > > > > > > +
> > > > > > > > +		if (ret) {
> > > > > > > > +			dev_err(dev, "Failed to request doorbell\n");
> > > > > > > > +			goto err_free_irq;
> > > > > > > > +		}
> > > > > > > > +		last = i;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	return 0;
> > > > > > > > +
> > > > > > > > +err_free_irq:
> > > > > > > > +	for (i = 0; i < last; i++)
> > > > > > > > +		kfree(free_irq(epf->virq_base + i, epf));
> > > > > > > > +	platform_msi_domain_free_irqs(dev);
> > > > > > > > +
> > > > > > > > +	return -EINVAL;
> > > > > > > 
> > > > > > > 	return ret;
> > > > > > > 
> > > > > > > > +}
> > > > > > > > +EXPORT_SYMBOL_GPL(pci_epc_generic_alloc_doorbell);
> > > > > > > > +
> > > > > > > 
> > > > > > > [...]
> > > > > > > 
> > > > > > > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > > > > > > index 3f44b6aec4770..485c146a5efe2 100644
> > > > > > > > --- a/include/linux/pci-epf.h
> > > > > > > > +++ b/include/linux/pci-epf.h
> > > > > > > > @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
> > > > > > > >  	int (*link_up)(struct pci_epf *epf);
> > > > > > > >  	int (*link_down)(struct pci_epf *epf);
> > > > > > > >  	int (*bme)(struct pci_epf *epf);
> > > > > > > > +	int (*doorbell)(struct pci_epf *epf, int index);
> > > > > > > 
> > > > > > > kdoc missing.
> > > > > > > 
> > > > > > > >  };
> > > > > > > >  
> > > > > > > >  /**
> > > > > > > > @@ -180,6 +181,9 @@ struct pci_epf {
> > > > > > > >  	unsigned long		vfunction_num_map;
> > > > > > > >  	struct list_head	pci_vepf;
> > > > > > > >  	const struct pci_epc_event_ops *event_ops;
> > > > > > > > +	struct msi_msg *msg;
> > > > > > > > +	u16 num_msgs;
> > > > > > > 
> > > > > > > num_db
> > > > > > > 
> > > > > > > You also need to add kdoc for each new member.
> > > > > > > 
> > > > > > > - Mani
> > > > > > > 
> > > > > > > -- 
> > > > > > > மணிவண்ணன் சதாசிவம்
> > > > > 
> > > > > -- 
> > > > > மணிவண்ணன் சதாசிவம்
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
