Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7A7CCB62
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjJQS4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQS4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 14:56:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C70C6;
        Tue, 17 Oct 2023 11:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocKI9TJvIyUbJQzIlbWFZUmRRorogw8SNkaZo5DZywGN7OuTngXe5zzRYWvufRdLLiVvdkQdIWHtfK/E2mT2GrAyYWoesRnb2xzPRMKOqCRi7ZQEkqExAYl2/ErsRW29TZugzHV61lSQTXIj6jgCETF9p4iFjJd8hikY9YMGEgNRKX8EH8RSgbMeeNTEk4VMqQFuKhgulZPxyaT3FyABLUciEb4QD/I5WebZ3/yD4pgqN3xZhaRySaQiDqi+HuQJ5dx9JMA8fgb96XziLrDFDKTP+ub4YJNlaPNnOALs8qdyEFNNjLIwaNZMct0GJnpLLQrIzcUZVvpfXVeZT1OV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL6kFCzUjal1/ynwQzNM+b5aR+B6UvCRBtDpoTjVbLs=;
 b=LizPayy/W+kUOmVP3GfEL1QjmLBXRUwiGPzWkI9J60W5VRTqn79UnTRu0Y6gJfHkYZxXK8DtccIwSqkgDm9z37XGPw5oVmB9GmkoViL9Sor1+lACorl0LtKFuZDDMmfytYDYLVJ/OfeWjtLzVgGWXfaFhdYQFf/xzapGsMglRBbk3acBdZhb0Yk5PzcioG31pg3CqUSCDkV58KkTri7x/YRXIcQNUPTdmwLAjykbrkpRtMmDZ2nJISlWJpSRfGImHKfoluRwhETV9BwdhOmC2oUbISzovJbEeuv7wBiOspXS3TqNqmHnWBsNb/KawNQ8+vlH4vrXDoQlvxsBxHKziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL6kFCzUjal1/ynwQzNM+b5aR+B6UvCRBtDpoTjVbLs=;
 b=svw63NjDosg8KZ0ftgMQg6aDJv1/WTIH17aRZMHdMB/iC8Ew2df0c9cv2a1IPa+jToBc7oZLQnGVH/yUEnjKw/Nt4mWZeI2SObMNHN7TtPMqL3P0Dsx6RUD2eudUfmJxIqxu/2EulEXv9lP7YwwscfqVVHQqKflnRvcw5WcTaxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 18:56:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 18:56:08 +0000
Date:   Tue, 17 Oct 2023 14:55:57 -0400
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
Message-ID: <ZS7YvWSlkQluPtg3@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-2-Frank.Li@nxp.com>
 <20231017183722.GB137137@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017183722.GB137137@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b4e6fa-aacb-4637-d813-08dbcf42b8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzVdAfuvUeml4Y+GhE29F64KoAVIAbsLCkWCDpriRLZ/Ilsxmct+B+g6whKiH4QaxZXcQ18ofxN3ogp8yLCD1GqtZZ8nJAe0VQX1P7o0nSw7iPLSMOLZ6q51Ki3ooVsRXGMLymLNRuWvqj9L2Z1F0ZYaRcm/3FEu0ofFZLqxjs/GGC2WaNP+vu2vmBsvJIbtzw4baNJyS/RZ5co7Mg5vQ6aBLohhRPcQlWob1W9QfK/S2b1gYRMGdYhcafdzKDS+kbl4M+jM/h+Y9n9A2LZbfz8owdrcQU4Tv94uXKPgDgb8QTFqr34n4ptDKQG6ElW00sUGb+On1Bu+/Q7jpvta01d4feW2scjsyiYxM+n68OwTCc9BqJryNXZUWK2JttjBEvtrmiCpKEQAVEEvpeRwO02kA1SLCJk0sqfno/UACvBaS6cD5DuxjQ4QlBi1Co+dQw/hcxUzsMQgdaXOCHeWiEpZtfpcFjK/GHWdGxW6VHt6n+SHkdVaR5FgpJBzNDwXTVlwVgPnNyDmMKedjb7xi7qORTmn4pMWiimx25ZugdbdTfP56O4o56MOqGAnTq4AlIJ0AM8APafZnLZE3VlwpFKhbw5smV5diGjVJ0picdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6666004)(38350700005)(5660300002)(86362001)(41300700001)(7416002)(2906002)(966005)(83380400001)(4326008)(66946007)(316002)(66556008)(66476007)(6916009)(38100700002)(6512007)(6486002)(8676002)(52116002)(9686003)(8936002)(6506007)(478600001)(33716001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVWczdrZ2lMZUgvakphczhqZ3QrUDlKL3VFYmlOcHRwcWZuck8xYkJ4dkxx?=
 =?utf-8?B?eWNSS0ZGdlFiTHRpcGx0dnBWNkd5YmE1U05SSDdxZHVhWjMwRThIalVaaWlv?=
 =?utf-8?B?MzRuU254aEdiQytkV1NvOTR3V1VDb1ZIRGYzaDJERVEzUkVwL29KOFVnV2Rx?=
 =?utf-8?B?ZHZlRHVmcDJDY2s3Z2x5RVZYQklMUXdXNXR2SG9qMGswZUNtM1NTUGljMzJq?=
 =?utf-8?B?dWdRdWV1Ykp0THBpVHpXRlY2bFJLZThFREhqemtneUt0elVjTEpBZXFOTHN1?=
 =?utf-8?B?dnZjYWVuNTMvd1U4NTRweEZ4NGZ1bXdwR3VDZzRqcWZyU0J0SU5sNEZOeUVa?=
 =?utf-8?B?dm8zRkFEWDhmQ3lzcnJwUzUvLy9OUy9BK0l1OUlDSmtPSHR5alhqbE9SRTNi?=
 =?utf-8?B?ZlViRWlVK3JHTlpINVZTWks4LzlsMTRZREx2cmQ0QjFJeVd2N0FWVEtwU0hZ?=
 =?utf-8?B?b3pVc2ZoZzVUTW93RVgvYnBKVWFpaW5jbE5jYWZXTjk2RWJmajZ6UGlkU2Mw?=
 =?utf-8?B?VXVWTEJ2RFp1cUVUVEJzMHNNR1RObzhZMldncGNNT1d5VmJFdFVadVVmQU9Q?=
 =?utf-8?B?MXBWSGltQWQ5SVVCSmFHbXd2aE10ck9TcDBlR2Vmb0xsdFdIejZJSUIvTW1O?=
 =?utf-8?B?WjZPaGlZTFNWbng3a3I0TmlIVDJwRmV2U1F1MTlsT1lidGU0Z1Q3ZVdGa1pB?=
 =?utf-8?B?Q01CYksxd25jZHI2VXNXSjcrdzBUcXhYdzJQcjNLMVlsbXJZSStEQTVnOWw4?=
 =?utf-8?B?bFd2eGpnWnRxS3lHZnNhTk9XRCtBUVlDd2ZRRDNLWVNQVFg0OGZkL2lTOWx0?=
 =?utf-8?B?eWp1VEFpam1Yb3lFNUE4dUJHdERhS1kvNjYrNTlVTGFrTDh4R0cxUGlkenRF?=
 =?utf-8?B?aG12WFkrQVFUbnBwdGdkeGlBeTQ1c3RzY2hMVktTWHpQdUEwS2NIb3ZGL1RE?=
 =?utf-8?B?aG1OaW9KaGF3ZzRZbnVLc2JVYS9FdVJORjE2WWloWjZJQjhSN1lHWEJVTkFB?=
 =?utf-8?B?UTV4Tkp1djdOOEdvRHBWbXdXSUYxSzZKK0h3Y0F1dFZsVjdWUTZOa2ZjalJs?=
 =?utf-8?B?amlybHR0ZVdFT0VyT2lROHRYSnU1aSs2TEUwL1hTMHl4UFFzcXFieERiaFFK?=
 =?utf-8?B?N1lrY0dRU1kxcWFURnpxV1BISkJmYkJLR2J4VHVqc2tlYm5mT1V2VUVLU0VS?=
 =?utf-8?B?RThLWDdhNHJ4bXkwZC9GNFhnR3JuVnVtWjZNZmU0d2dFWmlyS1prMWp4TEU0?=
 =?utf-8?B?SmtUUzVxa0Z4b3BEbHJ0M3RoRXdSTW1ySjVneWZzYTZ5T0xUZjNFWG40Vlk3?=
 =?utf-8?B?Y213MzFNM3Q5K2lFcmFqWlp4MUN0N2FnNGhoSG5Kc1VZdE5LQ2pOcEpUTjhj?=
 =?utf-8?B?WFkvUmU5bFN2UjR4TktmWnhDRExnZkxWWHY4MXpid2lQTm15THBVVFRmL3V2?=
 =?utf-8?B?RzFPeHBwaU9Da0JzdTFYcFJQVXZSWFJPOGVtS0dkWjNjTHFCdE5pYU1KbDd4?=
 =?utf-8?B?U2dJVzA3bjdjSDVqeE9EUEdiQUYrTldPazBDcEczbUpVNXNyMUR3ZHRWRXlr?=
 =?utf-8?B?b1pUaVBHcUNCQmF4QmNsQ0l3b202bkhWemlYT0tlVVA5MGZrM0FmUnVvcWF4?=
 =?utf-8?B?dzVhYkt3a1l0aE01YjRlcUsyU1hpZTMxalJTN3htZitYY0UxR0hyTXloMmxJ?=
 =?utf-8?B?TE9USlBJTXh4RzdKamZiYkpESDhnaTROZFNEMW1ucFQrTlZPOFdFYStvY3RX?=
 =?utf-8?B?OElLUG52NGJYdldJUHp5ZmFSOHZwMS9HdXZBbTVublI3Rm9yMVhIRjF5TzY3?=
 =?utf-8?B?L2YxQVJxaXJHbHVGZFlTS2svOVFqUFpnL1I0akZYVVc1TEJwb2NhYTU5Tk1I?=
 =?utf-8?B?L2lPakNndDdmaG12a2k3SWI3aEVDWWRRTGFENFBhTkVBZnBTRkVsWFc5czdo?=
 =?utf-8?B?QjRVby9BZHoxcFEwY0pTUE1LYkxXN1dpcFg0YkJMWjJBV0J1NUJ3YWkwVytr?=
 =?utf-8?B?eG9EZjM2RlYwMnBrOFFKVzFFcTlOTUQwM0ljSFlVMXkxcmJmekdRcllvNDlq?=
 =?utf-8?B?SE9KSXIwQWE0UjVLcEFDMEhtUUlnSlM0L3krMHJoM01uWS9MUnJieHkxdXU0?=
 =?utf-8?Q?QHWA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b4e6fa-aacb-4637-d813-08dbcf42b8fa
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:56:08.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCLj5OnYBa+BvXi4CxoEFE41HL2xI53s9IdX0vLYAwCDIlBX6RUgVJiVxeCrltwxdwJaAHMfcMNIvU2QYQrw/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 12:07:22AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 11, 2023 at 06:09:16PM -0400, Frank Li wrote:
> > This commit introduces a common method for sending messages from the Root
> > Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
> > controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
> > for the BAR region by the PCI host to the message address of the platform
> > MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes
> 
> "Doorbell feature is implemented by mapping the EP's MSI interrupt controller
> message address to a dedicated BAR in the EPC core. It is the responsibility
> of the EPF driver to pass the actual message data to be written by the host to
> the doorbell BAR region through its own logic."
> 
> > to the BAR region, it triggers an IRQ at the EP. This implementation serves
> > as a common method for all endpoint function drivers.
> > 
> > However, it currently supports only one EP physical function due to
> > limitations in ARM MSI/IMS readiness.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
> >  drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
> >  include/linux/pci-epc.h             |   6 +
> >  include/linux/pci-epf.h             |   7 +
> >  4 files changed, 249 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 5a4a8b0be6262..d336a99c6a94f 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> >  
> > +#include <linux/msi.h>
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> >  #include <linux/pci-ep-cfs.h>
> > @@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
> >  
> > +/**
> > + * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
> > + *			      the space.
> 
> "Allocate platform specific doorbell IRQs to be used by the host to trigger
> doorbells on EP."
> 
> > + *
> > + * @epc: the EPC device that need doorbell address and data from RC.
> 
> EPC device for which the doorbell needs to be allocated
> 
> > + * @func_no: the physical endpoint function number in the EPC device.
> > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > + * @num_msgs: the total number of doorbell messages
> 
> s/num_msgs/num_db
> 
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
> 
> You mentioned 0 is a success. So if there is no callback, you want to return
> success?
> 
> > +
> > +	mutex_lock(&epc->lock);
> > +	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);
> 
> Why can't you just call the generic function here and in other places instead of
> implementing callbacks? I do not see a necessity for EPC specific callbacks. If
> there is one, please specify.

1. Refer v1 your comments.
https://lore.kernel.org/imx/20230906145227.GC5930@thinkpad/
2. Maybe some ep controller have built-in doorbell support. Write to some
address to trigger doorbell irq.

Frank

> 
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
> 
> Same as above.
> 
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
> 
> Same as suggested above.
> 
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
> 
> Same as suggested above.
> 
> > +
> > +	return IRQ_HANDLED;
> > +}
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
> 
> No need of this newline
> 
> > +	if (!epf)
> > +		return;
> > +
> > +	if (epf->msg && desc->msi_index < epf->num_msgs)
> > +		epf->msg[desc->msi_index] = *msg;
> > +}
> > +
> > +
> 
> Remove extra newline
> 
> > +/**
> > + * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
> > + *                                    controller
> > + *
> > + * @epc: the EPC device that need doorbell address and data from RC.
> > + * @func_no: the physical endpoint function number in the EPC device.
> > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > + * @num_msgs: the total number of doorbell messages
> > + *
> 
> Same comment as for pci_epc_alloc_doorbell()
> 
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
> > +
> > +	last = -1;
> > +	for (i = 0; i < num_msgs; i++) {
> 
> You should iterate over msi_desc as below:
> 
>         msi_lock_descs(dev);
>         msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> 		...
> 	}
> 	msi_unlock_descs(dev);
> 
> > +		virq = msi_get_virq(dev, i);
> > +		if (i == 0)
> > +			epf->virq_base = virq;
> > +
> > +		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,
> 
> 	request_irq(desc->irq, ...)
> 
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
> 
> 	return ret;
> 
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_generic_alloc_doorbell);
> > +
> 
> [...]
> 
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 3f44b6aec4770..485c146a5efe2 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
> >  	int (*link_up)(struct pci_epf *epf);
> >  	int (*link_down)(struct pci_epf *epf);
> >  	int (*bme)(struct pci_epf *epf);
> > +	int (*doorbell)(struct pci_epf *epf, int index);
> 
> kdoc missing.
> 
> >  };
> >  
> >  /**
> > @@ -180,6 +181,9 @@ struct pci_epf {
> >  	unsigned long		vfunction_num_map;
> >  	struct list_head	pci_vepf;
> >  	const struct pci_epc_event_ops *event_ops;
> > +	struct msi_msg *msg;
> > +	u16 num_msgs;
> 
> num_db
> 
> You also need to add kdoc for each new member.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
