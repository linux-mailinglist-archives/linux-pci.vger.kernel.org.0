Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1B76700F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjG1PDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjG1PDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 11:03:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381572115;
        Fri, 28 Jul 2023 08:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWeD4fI3Ds/QZSnddyJuSkxhA/13uoTPoevzRiquX7dXE2Tx6q0sifVyCPO1QXa5T6Acnu7cCY74a5yUOwU9oKJBf+Wff4OycRij9IzA8YCX1D3v4ZFrLezuxj9A0qczGuASHnr7r64kD+99VfWN8YXVsDeO+pmyAL0RsdjbAuefJIhc472eY180K2KzpdNIHHnBBMFO07u6LoxPwsqPP6fADprMz8B/LzgvQGCy5bm9us5aVqEKMi+fTbTawklpX8B6o2ttG8j41Z3qPlvQPQoYEzGoeM7DNmWFwi4dNtQvAgcOoajqulyoQBo9Q//6baaSa26PR678E9CXcmWRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOvnMV8bImL7iRcsFHQTplVUVKC0ZtOR8fUOBqieoeY=;
 b=nMRP73t2jcjya+S/AgABX8tknq6u6iOkw6CxS83XkiZSqCpvYMx3PTyzIyi1DUMbWbEkHpPHVY2ZQv0+3nJb9FS6T0uKEekInIaDYmUCauBmCFQq65NXcnZw8vzLmYw0vJdPQSL4sr4W/xKaHnT6pkUUEEikK5iUmVrRPALVhy+KOqw1j4734cmpvnyOhzs4iLKhHxWbssc39vIQnc/oLXolbHquDFj0w82VC1f3vdEpN63dKBwGz19E5cSG5WnV1l8dNH6zms8zmdWgkdpFNQz/Z6ovpmo52+5jVpoNARhzx0/gCLFFMzhVgaYrhfN/R4IuhpVL08OPkt82pd3k9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOvnMV8bImL7iRcsFHQTplVUVKC0ZtOR8fUOBqieoeY=;
 b=VCVcDeg1Yxk62hevzNZ74oWRDCa8CxHxbaw4MTUyHzuqZUKXpB7fSaouj7W2eF4hZYuDWnE6H8z+owyAnYObrJ8wxtjbnrUj5iNBK8JRj5YPBVNABLCXhqH4rzrsAKZDGhBDgy3LEYobUNpvIbST57+2SK+JdQ0Hv6yospSc7jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8091.eurprd04.prod.outlook.com (2603:10a6:10:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:03:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:03:18 +0000
Date:   Fri, 28 Jul 2023 11:02:59 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, manivannan.sadhasivam@linaro.org,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mani@kernel.org, minghuan.lian@nxp.com, mingkai.hu@nxp.com,
        robh+dt@kernel.org, roy.zang@nxp.com, shawnguo@kernel.org,
        zhiqiang.hou@nxp.com
Subject: Re: [PATCH v5 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZMPYo0AtN6peiOMR@lizhi-Precision-Tower-5810>
References: <20230724215830.2253112-1-Frank.Li@nxp.com>
 <ZMOE9PJ//y1ClpU+@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMOE9PJ//y1ClpU+@lpieralisi>
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf102db-31f4-44f8-b110-08db8f7bc6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbso3FUO692R/Y+919AIhTVeixeeiCxZwDtWPC8FILmKL7ax4GYRag5/nrNad3qeyxodbzPjYbU+3HDOu43rzltGVuENtbl0rUNCbtTWIqZFHMl0yKAq74AeWMKP1q6YhoqA75CpLWhnBRkKjRkMl2bD6BFhpIMxo2vSd2eOifT2KZkBxazhu8/e/JHq5CQD2Ye6DQeec0ua1QNDs1W/jkzmKe2L8idE9V1dZYx6zA8ETUMe1+j+25n4yLiw8zadFVOV+mgzdqMUWH30SF1bZ/EDD8qT19nMelNWLLA1QSvM+Fpe7fisKn/I3FXa/u8RvqksAeZ4WynEvqR5vbHgCUpA7ZLB2X0CwHUsTUlPXA3U1HI7jDcBMiCNfeBI5gwbKsE3R980b4bmXN3/XUjG+th4XzKjYn8+s2wkgPTgIm+XK2ffg8MTPrM91NFmrMkaZDwa9OGNGbFE8SFdXDFyEHH04pIIlijC7pkXa5ilpQetoZSA5tMj/qYibXgvLn6LtFtjCU/ZEouTcRsKx9x1+nh+/uVZ5FQf22hT5GG40dGTsFL6LPsXmv1QvhbELtkTOhtmEIEx6RCiD8YPFOmiDa4tIBKAV/dNe+NjhMxoPag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(316002)(2906002)(8936002)(8676002)(5660300002)(7416002)(33716001)(41300700001)(15650500001)(86362001)(6486002)(6666004)(52116002)(26005)(6506007)(186003)(9686003)(478600001)(966005)(66946007)(66556008)(83380400001)(6512007)(38350700002)(38100700002)(66476007)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BPSv8wPxOpln8htAzPvD7NwO6ThNL3BbjrOq8qdk2x8XMxRog8aBbKSb4OZh?=
 =?us-ascii?Q?lOxZSEQh3RLI/oMwv0kUXR5XX7lGMLgQLg587Ogwba18QaRerx+IijXojnZX?=
 =?us-ascii?Q?6WPcEYCCtEucjX1RBXpI4/ynYYxth5gPaiSziCAss5lye2W7F8LkzTLbybZI?=
 =?us-ascii?Q?mwd0O2QHayWac/KKjumcTqrZLV+XNq+W9jesA6KmPy+iW5Sse+i1OYxvVkY/?=
 =?us-ascii?Q?ChtF3RNsMOLITvgh7PhQ0zt/ggozzg63JlOMPoNiEi0n5hM9xsqtdMdgZO1J?=
 =?us-ascii?Q?CSMIRBIUdWcjAEmvAMzhzVz3e22Ddasl20x+Fr73MeX+cBhJi/3XVx0uw+Zg?=
 =?us-ascii?Q?aNpENt/nOLqgvOHyI6anczACAm2FPHH9ZvFm6sYVFpkT/onz9+ysY1NmXMNv?=
 =?us-ascii?Q?ynqJMkC/H5PYWzVrKpO97gvSBbaMh1vJZxeBrhhIMrE4Ws8To5i8jwqkHTBL?=
 =?us-ascii?Q?gcBBNXsMWH0xn0+y1XSH9SowbaKiWUcWISIo19saQAwXiBOr7Vqj4WmHjms5?=
 =?us-ascii?Q?+fpD76OOtKo3BANg+ML3jjaKnLKUfIctflRvwxtqvW378BAPHA8hgNt8Bs9J?=
 =?us-ascii?Q?BuWmOY2saZRSbl9QWYHW72YllQPabnAEJ7/fU8POJwtKFbimc8boDZeK/Dee?=
 =?us-ascii?Q?Y8Ov80jHaQfyVRcCnnWmgAUx0L51/PK0gSdDgw3EZp97nLZIaZoyTcA0/uCk?=
 =?us-ascii?Q?us1KAaCIGAUZ0RZjAosAHDrfy2UYlmlq8xomIRUt4+gtnNJyyv9FW7wATYEx?=
 =?us-ascii?Q?wJsWU9hldCDRHmb/lizoRkTsJDyLkiRz7Htvyoqjzu2dvaQsPt1qFWmkRlc7?=
 =?us-ascii?Q?qnrJABZ/2SLAJdZNrGMMcyXRaLP+JqYuV+c7HuaEce58t/qZAZ04kW8HkEvX?=
 =?us-ascii?Q?CLaFwAFqAFsTmVB2pD2r0bG6oUxpt2x/xgXHnnkhOojcoiYlzrsQk5I/9l1i?=
 =?us-ascii?Q?01JLDrsv8oNlIFWo9lSdQqDJ2+BwV9+/MkfbXfdzHPq/x24AYDWe+5nE8wjB?=
 =?us-ascii?Q?C6ZQrAWOVeEb7KpF4UX/vzWjm2PzYwJnyDOz4DwMSUTN9xFNFD4XY15Q5u5C?=
 =?us-ascii?Q?ZntPo/BvkxXYgmPd9N4Vcb+UZFbQQTX6GjYDWPpx6o9VRvwnWa4o+K3vYs2k?=
 =?us-ascii?Q?Hg1g2T9q8uMtS5OQnDNdkDRovuBmtS+2b69aBiezGO/hu7dhNS+qaceQTOLo?=
 =?us-ascii?Q?3OuKuc51w2TSumL6yGS8BhcwlICm0iGhNn9WDepE9dwoLpntK0+qkawMnuYw?=
 =?us-ascii?Q?dqprOM/E1CLXEK4sqNEviq+Jf0lBNYQE4ijXIfSlD9fpcSWHoq5D0SOkQNcW?=
 =?us-ascii?Q?JUD18PBApfmaARHTRln9ZIymp1pfNcvxAShbE74oswWJL+htM4/cR8FU+D+p?=
 =?us-ascii?Q?C1Rh9GtzgakyNrd01fQgDngv2Jn4WzVnYPPlHy5ZWGMbEZzpuNmJCkNUXPhc?=
 =?us-ascii?Q?B8G+34sfMkTlQEgr+Nutqahco7DRBpM8a5cRuhsG0lWE7p0kv+NO1BQCSvwI?=
 =?us-ascii?Q?fBCR/01TmmwwHNqpAsDj20mDT69IgpiB90I1wq4twaAui3mMO4GM/6B8Ok2B?=
 =?us-ascii?Q?wJcNQvGAtO9ablJ0c8c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf102db-31f4-44f8-b110-08db8f7bc6a0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:03:18.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc/xSbtxtBYCwlEYnelunGsrEqPrzq+5CiBOwPJKV4Gy3hE/FReq+5+tjexNTKm5q6DNmA8r05IB4H6hH595BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 28, 2023 at 11:05:56AM +0200, Lorenzo Pieralisi wrote:
> On Mon, Jul 24, 2023 at 05:58:29PM -0400, Frank Li wrote:
> > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> 
> Commit logs should not use the past tense but the present tense.
> 
> eg s/Introduced/Introduce
> 
> Furthermore, read this post from Bjorn and follow it to the letter
> please:
> 
> https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
> 
> > 
> > Typical L2 entry workflow:
> > 
> > 1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
> > 2. Await link entering L2_IDLE state.
> > 3. Transition Root complex to D3 state.
> > 
> > Typical L2 exit workflow:
> > 
> > 1. Transition Root complex to D0 state.
> > 2. Issue exit from L2 command.
> > 3. Reinitialize PCI host.
> > 4. Wait for link to become active.
> 
> This does not explain what the patch does and why it does it.
> 
> Are you describing the L2 entry/exit as implemented in the code ?
Yes.

How about below commit message:

Introduce helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.

Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
handle.

Add common dw_pcie_suspend(resume)_noirq() API to avoid duplicated code
in dwc pci host controller platform driver.

Typical L2 entry workflow/dw_pcie_suspend_noirq()

1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
2. Await link entering L2_IDLE state.
3. Transition Root complex to D3 state.

Typical L2 exit workflow/dw_pcie_resume_noirq()

1. Transition Root complex to D0 state.
2. Issue exit from L2 command.
3. Reinitialize PCI host.
4. Wait for link to become active.

Frank

> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v4 to v5:
