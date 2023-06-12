Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3172CB45
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjFLQQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjFLQQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 12:16:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155E2F9;
        Mon, 12 Jun 2023 09:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRep4nv58n8pU66Cy8pDj2EcOb1YI+nPUrFHkywCggO9sHvU201PHGF4RFjetOKvCX7Lp1D1DG0avvIHakC6LOjhpuA0hbSGxCjIF34l0LrHxNQUb8+nUDpEe7moYWkdctxOp6H6EGa4vrcrboEsrU2FwxRHemAzIQcamz5151r5EBagy/PhtufxYMpWmUtHnmj83NLHMFZwok4WlqyzKtEOUfms+t3IBPe2XFpxlnTGCa2N23Ed4pBY/P0cmPsEvqIxosuphL2fY3qpSdtOFoRM8+H1y8dH3HkZxn9BEM1dhyaSxpyslr5+ELcshWSy692N1kxh/4Au7Ih+pcUazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX8JSc6r3hNzUw30HMIVIjNeTs8I18CXNmXrJRNIy6I=;
 b=gDTk/BxvKd9fAUXfM5s8qw3sa6Sxz3YvEswAbRmlMWEHTzQaxK/nKk9IS/Tqs8CPef9Aeb1/0t3jp6ZK8uEU5xt0oZm9YdwwswTMmbzOKpE/XukWN5mOW1bJ1xDHFV7CRUipHKffpAQEYBnaf/E5Fyla4X0EHlJlorBj255o0O7zwdmXVSrp+Ppnu99IcVt7YuJboLhxGs+VbOcvT9KUbSNrgUqGm86oq8ipPohvbyHWMaiJFt6L+O6RNRHJm3nMk3tzY2Y1q5edRWiuqJHKW7pp0FXvequhJt7ff2LYjAWvAkD4GiwgzSJOa3O/CDClYBnxMGVYBamhjZZ1FReeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX8JSc6r3hNzUw30HMIVIjNeTs8I18CXNmXrJRNIy6I=;
 b=Qek8rDda0hV5WPIO8gotxSYGoMcmGCAN1J0nTCI2Iu1kObIPTnd3WXKEm8tOBwwHU5vKilGgZk4mUOtgtQT147+kwEnoDJOMs9DmAwDZMP3Te22YP3A9DqrrcDwzW64O6U13epZByormDcmanG3QqMiOWdpk/Le7ByrTx/3emU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8852.eurprd04.prod.outlook.com (2603:10a6:20b:42f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 16:16:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 16:16:40 +0000
Date:   Mon, 12 Jun 2023 12:16:24 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "kw@linux.com" <kw@linux.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Roy Zang <roy.zang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZIdE2KjOuyHmLqz0@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <AM6PR04MB48383AB3FD2062334ECB66EB88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB48383AB3FD2062334ECB66EB88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6354262f-2654-4516-941c-08db6b606797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nK9YZEeU00wS88dKYO59EXWwpYEyp9X0dZtp/uP+Phf5mdjMOo86TZdbP8HXpBYo1KKBYVeqkPJXNO0W5o8RQhm+S86JDRjqK9HANAcRDfQeu78YRw0iMG+nkhj7ZsPh4Xv420fu7fEjqqlhgkZJerZRuKcz17uqHmr0k5Xi5FCFPtW7BMPWOTs1CcujUSbvIxhEuA5vP8plHSDZ399CzxlPkqxCWfIUHY6+bRAwvwWKomXgwhs2CDk/xzYlUzR+Z2QgBrrGf2ZGYMMT1dKaxbYZqjaBXa/JGrpaxXPnAWFiCRyrJMR6cy7YoQOmjoKyIz3rs+uWCfiePRC4m92AYgRKtyaJLyNpkDf9uUYmYvw4//iCnFHHq2oMHe70tg8bogqM66eUf5YPh2+TDpWQq6lr/s6s7WFEEhYFA9tASYGWyfIVPm/XR8v81lOEHzitjHg56dYjuos01qdTZ8QFyGvJbMyayyAsnesgzbIMxm0WW1/p1GjrO/dwuIhCJ0rar00Sz/y0rdrvbmXMtI/c1180Se5X8m6iT1RnfG3KeFGUnDmCq3nl+28Lowdccs4oXuLd+3u97tM69VOMQOQwKL0JyU/UJzR+6jd/5owrADg9NWF4UT31xE0++jc/xH4U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(5660300002)(54906003)(7416002)(8676002)(6916009)(4326008)(66946007)(66556008)(8936002)(41300700001)(316002)(4744005)(186003)(2906002)(478600001)(66476007)(6666004)(6486002)(52116002)(9686003)(6512007)(6506007)(33716001)(26005)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lIK0hnnFFowGHyWW9VkXRWeQdRsCNfciJhpuXURCjnB23AgX2AvcQCO7tMUb?=
 =?us-ascii?Q?9EBE3yw3YuIz/Bz595S4YLMbz3Xd6PTCbT6OOHnkWy0u2nupyl/JKnlxW9Ui?=
 =?us-ascii?Q?yBh/DtK/mekG3eYhwBJTA6RS7o/F8ftNUIcGhi06zbVcsWAnwNkCjFr2Uxdw?=
 =?us-ascii?Q?iGoF5UMg1wTkaJy0WlcyyevOLx2ODWN7fs8SewVOLiMQWtlrmwHbir53r1QU?=
 =?us-ascii?Q?gDkK8YcbA8vUXHvwyWPW7+5C78MeGL2FvaXSGLi8k3k5xo74dcyZl8sLL3sF?=
 =?us-ascii?Q?yPq4KbFDrUfuUFZ9bIOg3Rm5elAPcFUcAhlVuk7ytMbsLSxQI6tkk9FEjPXh?=
 =?us-ascii?Q?fr5R4QW0fourjBdqnIp4WAt2XW15/mxxYna2NjzlQv0zc1ATH4yqht0my2Px?=
 =?us-ascii?Q?Q8w0/AdXJEi6Xw4WGiCoR8S/EPvV7OakSvWdsf9Ket58SXDlAIf7mlnUIcvO?=
 =?us-ascii?Q?lIMs5PmfySEtKotbsAqOTbU9zglNLKsOzqrL0cASYW/QrzuZY7K8euZLb+jf?=
 =?us-ascii?Q?5XKwrOj9duKDZmDLWHGeNwbeBLWgX9Q+k0VyimpeROKU9Zqs7Z0XGX+IYJyi?=
 =?us-ascii?Q?8qpodGVrZCYMEGDKLSkBQZsALmZsQAaAAcGTeZkwX0eKtVHzmmjuWlBFPQrZ?=
 =?us-ascii?Q?Ysvb2KmAtnIsuJGsC0xiXYwingRKNQMMMH/CTl2V9vwg2YbWJaa/3u5ipnF2?=
 =?us-ascii?Q?1J9CAsBq0FXCqm2osp9V+YfDmq+pvkIzWdMTPbkGMO4NEzcxYu4oDZK3v3Eq?=
 =?us-ascii?Q?nfkk9HsmelY7e+hvewTDqPs7QQKXRj2waZ7virwBpv5FRFE/w68ibrEVpdEc?=
 =?us-ascii?Q?2mxVPMSGc2f0/1QdERoUhauWSlhnbseS0CcBsad7tfzVK7+pl9UvbwU7SFHR?=
 =?us-ascii?Q?W0CIse4Y96L0ljL7q+0KeCU6SPXFbOpxFC+f5VS/vTk3Y1bkqPXU6OFEL5GD?=
 =?us-ascii?Q?MUWBohF7W0jEgS3pTOVg8cPX9alSCPwbVfKKQ7wmYuX0UcBaTRieWLSP1/MJ?=
 =?us-ascii?Q?AK0WZNqv6MEiLJ2lviDDOlYjrFYMFHfUW2krtTen6wqWQBO3QJgLNHN6yYz2?=
 =?us-ascii?Q?EG4TFcaXKPoFenXFOrd/6OA85Bdik55DMiO5iiHDmDLk0ChSNBU0/HBTwt8q?=
 =?us-ascii?Q?g2Ba715a0p8E5kgdiNssw8Jk9bBpzfOikaQVk2c5nsw3M41h3WiuyU77qVYn?=
 =?us-ascii?Q?4JKZ5JF3iYJmVIvUWsm2ZC18h9GI2z37kP9QtFhzFx+DFf1jZV/2gacOidka?=
 =?us-ascii?Q?/H7alXvyK65KjmceF6Q1eTG4m+ksivBMhJlyaONuAOtZidNpCJr77QjEP5gO?=
 =?us-ascii?Q?Sjm6d5kr+VaiwHMRWct+B3bbR2yN2HeFayEbeM2lHHn5mLMTKquxe17GAfXw?=
 =?us-ascii?Q?RN8AZWEuLIDtWduWR8F4REsN+e4TpgMoHDdJRZf22xh3w3NstjKKkRJpFcJK?=
 =?us-ascii?Q?BOtduvTgL7/kqkpCwjaBjJBFC3Gp23awsOhOfZVH7GEU0nrdMKArjmIhSBOY?=
 =?us-ascii?Q?RVkawDrMYanUr5SQGG6JA31cpNbaJO1WmomJHr2xw8ZWT/70i5nevcfHDWCS?=
 =?us-ascii?Q?3I7GCz2rEgMB6/aHPkk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354262f-2654-4516-941c-08db6b606797
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:16:40.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFfd9dR6du46hmBISu3h3qi0L1jE22nlzNEIUQxryVuUbPACDIbI0342R8Zuqits9z2VQ9WJCE+xdnps9H6/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8852
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 02:47:46PM +0000, Frank Li wrote:
> > 
> > Introduced helper function dw_pcie_get_ltssm to retrieve
> > SMLH_LTSS_STATE.
> > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state
> > transitions.
> > 
> > Typical L2 entry workflow:
> > 
> > 1. Transmit PME turn off signal to PCI devices.
> > 2. Await link entering L2_IDLE state.
> > 3. Transition Root complex to D3 state.
> > 
> > Typical L2 exit workflow:
> > 
> > 1. Transition Root complex to D0 state.
> > 2. Issue exit from L2 command.
> > 3. Reinitialize PCI host.
> > 4. Wait for link to become active.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> Ping

Ping

> 
> > Change from v2 to v3:
> > - Basic rewrite whole patch according rob herry suggestion.
> >   put common function into dwc, so more soc can share the same logic.
> > 
> 
