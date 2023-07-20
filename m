Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA275B51C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGTQ7r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGTQ7p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 12:59:45 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3492;
        Thu, 20 Jul 2023 09:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdqfof7+MmlVdQfzIQg5Mpmp7nGMSPsgWG4vAPMnmM4j/AOTh+5l57bkepo4NEoBu6jRRGw5gkTHko1dSxPcfKQbE3DIbtIVWIS11BoxmLsxnDua3VhBV5X6vCEr99d76bu/L6wloEi+vUArEr0O88GFtuJcGcxmwO3qYBBJDOoVlW4gBAJtT+lEQzVBfayyU6cuNs6zn2UIGtbOBxEAf9z7QG5A/SiS+0wuYgARJNINU3XUrQDnOngfRmG/Gs8JV/yssO6MhMKqfKeqOjcUnhenYjDdgSGFiFFW+xvqKYgiqMykAj4oF2yK/6B2T5GVeGNNJKA1W+FjitY8bdOgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66jfCo6JZvpcBWfCbEaUA7qh5Q37lSrzg38E9qv4RzI=;
 b=Q5GpXWJ5iK2Wb3mR5UyDK33BqDwG1U6T9BoMxsTITlu8iGIChnl+D8PPJCncQFq1Rl2bMVeGOJon75EePVoDZZQrTXcoEPlIMYzrWTBAPWvo7DNdF5x0bCC1MIFIwnz/o8rMVD/uFjw82UbcNz/xjF/f7KGZD5wbDBuH4b+FZHiZ3aKGjUqkRqQIfVLRpnSoKDRFqy6YZspxY2gcOltFwHsqQH3NmIlPuUpOSFbN/AzOt+Ydy0QttmcD9a9OYZurGcXd355DxPyAFNm5+TjWMqbDNPuP/hCL2e0qkTa4N5tYe0pmz8KYg4ZcjomohiJyf3HJiartWG8SbNLVArzEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66jfCo6JZvpcBWfCbEaUA7qh5Q37lSrzg38E9qv4RzI=;
 b=Js3jXEBg1TWb+wNQoMYfsNfNK2WApukLE5I5I3/qexR0+CVp2l4rHMLn8v0B55BvWPpBLoeXkewwOk7EUTri0nk+s0DdQEbXf42+rd3jCQ0lhsxlHlVDv6VcqMr8AjhiptKmnG3twjqprf2uSNE4YJ3HhXHyOoHamxD+zXAj1Ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 16:59:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 16:59:35 +0000
Date:   Thu, 20 Jul 2023 12:59:20 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZLln6GDX/u3pdEQ6@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
 <20230720160738.GC48270@thinkpad>
 <ZLlgPprvtuDbGFVu@lizhi-Precision-Tower-5810>
 <20230720164318.GE48270@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720164318.GE48270@thinkpad>
X-ClientProxiedBy: BY5PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:a03:167::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: b86727a9-582d-404a-2102-08db8942b203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0m/lGQSYU07jVbx1IQmUerjRX4SSKxPZA3BQbzN+X8fikxELk7oId79Ti2Wy6fxXfdt+MNLoPOC+FPdJpFul5WnskkaOMeq/Yopo9trTzHxOx9IzRXHRgtNUiscn5FCl7lM3WP8Ymj85KcDt2kWRXwOCZM/KmaBng7fJpsNQzFYa909LLwFr670CM9goHdsOfwsY2oucUOyz43Uw8Nki3uAoH/c9y3MjkbaFGouqAA6XnlK7blXR3XwxJVeQDqkvjAAR/KMABXElWVsQj0ydDOk3e6e29vCT8BoADxuxDAGDPxFzq5aE0N/r/RYci9OZZqgS0jjXdkq4gslwHv1ibdfnnNGAPfbAspyAvyRQxXggLuxSUJmqzbkzKmly86uIsrKkTiteUEf5zjx8pqnq1k6Ml31EeZQEpFW1uNBSVa8Upvp3UPeuyjW4oVvH3lIQJvFtxEmbtOP59mDDhvVzDu5M9sQhr3vFtKEJXLKla5W9wc63Nv0VUC0/Ofg4yfAp7PlXrkmzD0NSsprnPeDSJPnkRJQScQmxBQkC6vcteIQL8Jq4sFg2PZYt8OgOvTzVrHeouhc58rLNDpufq+55f93uMe8sbvogcLPkaHcvEa1207Vv2++wy6EEoJx6cP4h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(38350700002)(86362001)(316002)(4326008)(6916009)(6486002)(83380400001)(6512007)(9686003)(6666004)(38100700002)(52116002)(6506007)(33716001)(26005)(186003)(15650500001)(478600001)(2906002)(66476007)(5660300002)(66556008)(66946007)(8936002)(8676002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXQ2UytkWjR4azhneGNzZnBWSGtlMngrUDF6M01scDc5OUxnSVNYSFZwdzFT?=
 =?utf-8?B?UXRTbVVtcWZ4V05mdVNNWUJzWlQzd2VDR2VsNHlzczJ0Y3ZTcWwrUnVaUVd2?=
 =?utf-8?B?dkFuYWdOVGJQRU1YSnFXaVJCaTgzYWttbmZiT3hZRUtpVC9UNWlwb0pnVUpZ?=
 =?utf-8?B?TEFGVGE5SWhkYWZxVHFsajliTngwQ3libXQ3TVdwWjFqV3hNMUhyRFpZWmwy?=
 =?utf-8?B?RFZkYTVSZ1JXaFE0ZWxCK08xRXVUVFdtNUw1clUySElGZXd4OGM4UEpQK0Ja?=
 =?utf-8?B?M3NOYzBGZnZKcHFEVjNRam5oV24yK3dVQ1lpL0xUanNabEkvRGtJc254Qklz?=
 =?utf-8?B?cEdDNDd6TnlrcW5aZVJ3TWM1a1MyaEVIRHFHdnM0Tld2OEJXeXM2d2YvV0h2?=
 =?utf-8?B?YUlDeUN6ck9zU0ovYnB2aE1WVlNUR0IwMEtKYkxVdmNaT3lMcGU0aUhWc1R1?=
 =?utf-8?B?Nm1DTUZxbkFqUVR6bHZRZi8vZkY5aS9nMWw4VzZjN0pBa0hnbzh0ZnJqWThJ?=
 =?utf-8?B?T2pIU21LK21mNWNhV3o4OVZOeVNFemRzWnBpT2ovbUh2NTZrc285dDZHZFd1?=
 =?utf-8?B?enFWOXloc0FBMTJLTmwyTXdncWZSMklhNVl2aG9jcFk3cmZ5c1BzK2lCdGVD?=
 =?utf-8?B?c0VwZ05XcHg5cXJlMFVleVovNnd5VXJCL2FEL2hwbEdLdTYvbkxKRUZSRnZ4?=
 =?utf-8?B?MjV3SEkzaFowbk9VbFU1cms3S2c0VFh4dnJCbVVCNnloMmJnSEg0NDRmQmcy?=
 =?utf-8?B?QmpWZ2R2TXU5Y3g2WU1FS2REclFFK254Smo2Vlo4b1ZvS2R4Ylk0MDZ3M0dS?=
 =?utf-8?B?NmdmZWJqbCt5Rnl5UW1aWlpkempXTVJGZVdOVmEvUUMrckRvRHB4NHpWVFNj?=
 =?utf-8?B?SEpCYnlRV3hzUnJzdXAxdzZjZWVEODVkUlF5NnVmS2Qwd0JiWjRsOFJMK1pq?=
 =?utf-8?B?UXdVTEVuUHVPZk5GczBnL1ZpODNLUGRFWkpQTmMzdnRmbC82eDkzdFF1TWRQ?=
 =?utf-8?B?VlYrdkhFSVlKUE1ZZGYxa0ExdTlSbWJRUDdha2pNVVNXbk5OUHJieE43dmUw?=
 =?utf-8?B?NEI0dFlwcGU0cURRd3l0a05wQXYwQmQwd0p0Y09YSmFLaXNOWnhtK2g1Wmoy?=
 =?utf-8?B?YkJaN09hem8wMHFqRW94VmllV0xQa1MxWktYS0lFNXBUaGE4WXg2TUdOUmhz?=
 =?utf-8?B?QnA0ekJYK3Nyd05xWEtaNXZSRXkvNS8yelFDd0p0all1ZkJjdTl3ZzgxdkRz?=
 =?utf-8?B?RVRJeGNSVXpqTkZaMCsvYkNlV2dhd2lmSjlOU0k4Q0hybDFHYjFSTWZ6SXFk?=
 =?utf-8?B?S3BnMlpHalRnektSck1FTFdGV09PTUY0b2Z4V2I0TWxoSHYxaDJQSFdBcDlG?=
 =?utf-8?B?Ync0c0h0M1FKbmdYamNOaHhiVnJuenl1eFZnZnZVallVRG1OYUpiRzB3MXU4?=
 =?utf-8?B?aVRGNkQ0SEhFdTZrSFF3NlRXendodnhSajQyNVdJVDFWTUFtdDQ3MWxNeGVl?=
 =?utf-8?B?OUZLZ04wNDN0dGJBV2F2dkt4Z0UvN0M5Q3NjUW9OYmlxZGdQZnkxRnN4dFJ3?=
 =?utf-8?B?dVorSkdmeFVpUnBINHFBZ2pkQ1doZFBtS3pTQXYxenVMM0NRZVZxQktxV3dH?=
 =?utf-8?B?RlNxNHBTcGIvSFQyemdkRXM2NnJLVjV4NnJxYnJaMXQ1NkcxWjZLK3prYlN2?=
 =?utf-8?B?Wm1TeTI0bm83b3dmaUZWY2FSaXRvR1h4NG9iM0pENUhhVlBHQkNraU56ZDdZ?=
 =?utf-8?B?N3VjVnZhVWc2Tit3Tm1odHRTNHcydCtUdUpJM3lNN2x3T1pCSDl5QmxwNWh4?=
 =?utf-8?B?L2ZNSXBYYjNsUlRGdkhVNFBrVXpzTnNhL2NMYk1mRXBmemgxZG9sMGxQRUtE?=
 =?utf-8?B?b2FBbkx0b1JMa0xhMTE3T1o0Y3ZmamVyQjBaS0dUd1hQckMzblZ1Zk1pb2l2?=
 =?utf-8?B?L3hHUDg1T00zT3kxYzNDTnlpZ05kR2M0Rks0eUZrL0pNbDBTdWhuMVNUYlZx?=
 =?utf-8?B?RXk5K1VvejNLTlBRWlAxT1NFdEM2SzRKd1UzTG5qd2xmR1VRSkxPNmI4T3d5?=
 =?utf-8?B?dEt3SFh6VTZCbmhSMlZyck54L0dLeERZM2hPMmVHVmsxUlkvc0F6YVpFRFBo?=
 =?utf-8?Q?wkxHk7qLrnuHKxbu39MapWorQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86727a9-582d-404a-2102-08db8942b203
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:59:35.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gzkS/LJWCje91H+hA0iL8t0ThTTLygdRDsCyQbD+nwY+t52DLNtHM6ea129XX4giaevKi0MNlYuZbbs24fISg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 20, 2023 at 10:13:18PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jul 20, 2023 at 12:26:38PM -0400, Frank Li wrote:
> > On Thu, Jul 20, 2023 at 09:37:38PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
> > > > On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > > > > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > > > > > 
> > > > > > > > > Typical L2 entry workflow:
> > > > > > > > > 
> > > > > > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > > > > > 2. Await link entering L2_IDLE state.
> > > > > > > > 
> > > > > > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > > > > > 
> > > > > > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > > > > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > > > > > PME.
> > > > > > > 
> > > > > 
> > > > > One more comment. If you transition the device to L2/L3, then it can loose power
> > > > > if Vaux was not provided. In that case, can all the devices work after resume?
> > > > > Most notably NVMe?
> > > > 
> > > > I have not hardware to do such test, NVMe driver will reinit everything after
> > > > resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
> > > > at L1.2 at suspend to get better resume latency.
> > > > 
> > > 
> > > To be precise, NVMe driver will shutdown the device if there is no ASPM support
> > > and keep it in low power mode otherwise (there are other cases as well but we do
> > > not need to worry).
> > 
> > I supposed this should work. but I have not hardware to test it now. NMVE already
> > sent shut down command to SSD, which can safely turn off. after resume, that most
> > likely a cold reset.
> > 
> 
> NO, it won't work and that's the reason the Qcom platforms are not transitioning
> the link to L2/L3 state during suspend. This applies to other platforms
> including layerscape as well.
> 
> > > 
> > > But here you are not checking for ASPM state in the suspend path, and just
> > > forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
> > > expect it to be in low power state like ASPM/APST.
> > 
> > This function is not called defaultly and need platform driver to call it as need.
> > Actually, I think PCI framework should handle L1.2 and L2 case, some devices
> > or user case want to L1.2 to get better resume latency, some devices want to
> > L2 to get better power saving, which out of scope of this patches.
> > 
> 
> I'm referring to the platform where these helper functions are being used which
> is layerscape. It doesn't matter whether you test this series with NVMe or not,
> it will not work unless you disable ASPM.

I tested with NVNE. You are right, ASPM is disabled at layerscape platform.

> 
> > This patch just handle L2 case, I remember L1.2 don't expect send PME at all.
> > 
> > > 
> > > So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
> > > you'll ending up with bug reports when users connect NVMe to it.
> > 
> > Platform should choose call or no call this function according to their
> > user case. So far, I have not found a good mathod to let ASPM to affect
> > suspend/resume. 
> > 
> 
> You are missing my point here. If any platform decides to use these helper
> functions, they will face problems with NVMe. So please add a check for ASPM
> state before doing any L2/L3 handling.
> 
> I agree that it may not be optimal w.r.t power savings, but the PCIe controller
> driver should work for all devices.

I can add aspm check here. but I hope there are a flags in future, which can
show if expect pci controller enter L2.

Frank

> 
> - Mani
> 
> > > 
> > > - Mani
> > > 
> > > > This API help remove duplicate codes and it can be improved gradually.
> > > > 
> > > > 
> > > > > 
> > > > > - Mani
> > > > > 
> > > > > 
> > > > > -- 
> > > > > மணிவண்ணன் சதாசிவம்
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
