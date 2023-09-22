Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD997AA89C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 07:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjIVFxm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 01:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjIVFxl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 01:53:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2084.outbound.protection.outlook.com [40.92.89.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DA5C2;
        Thu, 21 Sep 2023 22:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koVbMwDUETqOWE74+cCM7hhqdxska5+ReiOcmRSCItp4eapLS0H5ebro0XNq4fctIAScs/qmcGBf1P4TmX4kiY0Vl+XBUm/heYBy8FuYQQD3+N+AlLJ1kTvQpmxHa5CJnlZ0NerkrQ+5j7yV4J9BBoh0eEu6lyGTQFb0qIEfzPePr4YzM7ea5OFtQP09j6/+8ohyUjuFGn+WcacWzEdyilRAAfR59VIJdCXkfltlEEZKADNrM/lo/mPmJO3wYCzzLTVYiQKrPBxE4SOnAKtqpR08YnBBRpalbkaPsx19zlEJX94Nz1pPLwyUHcB2OH1jPkavo401SZQDRBf6ZbnTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vq+iCL4fRwjPpgBYU+M+oSnf2X9iA6HGH+etITbNlw=;
 b=UVUZUTvv81rOQ5kH9JaDqpxbip5MorJhGN0mRpgB6mu+Z8TRQ1Y1k95tfn696KXEMB3WcOg1XyaJ6aKet4qcY5chnqRpctM4KubmVZthBtb98W7xYlelGstIC3jE2jjY/ppDWzx/iaDo4bZie2UaziFczrTA6+fTBvLOWFMomzCYq+aAQR8ZY+kqBG3o0rLsJcqLuLKapZiezNY/vcyE7Ay43N0g7n61dr+dRi2YOOleWxoEbov64L4dnBVmyxMKZeRebxBBtoTdusMRzeBsrojM/7NfRdTZEkARBAtMOWNHu544NpeC1L7C8osHUwFCKeILIXb0pF48hlWv0lhyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6897.eurprd02.prod.outlook.com (2603:10a6:20b:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 05:53:33 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 05:53:32 +0000
Date:   Fri, 22 Sep 2023 06:53:30 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/4] PCI: Add device IDs for Brainboxes/Intashield
 PX/UC/UP cards
Message-ID: <DU0PR02MB78996ED81C85C7FE7E722128C4FFA@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <20230921215822.GA347672@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921215822.GA347672@bhelgaas>
X-TMN:  [Doo0mZk9ZsRK5GjYpaHwEEJxBjpQBcv+]
X-ClientProxiedBy: DUZPR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::26) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZQ0r2qrPdc2iJAjI@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc889c5-ec2e-4cf3-6b6e-08dbbb3040e3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMdGxvAZFoHbke5oK253CTyb5tHwZouIuRFOpzBa9yXCXJ+J2YJrHCkLqjfybd+ROixyRguHBAxcr3noOBiNM0Tf6I1QCicWUyp8M2CpyuzpriQ9ey0K9s5mRx26Yu7DGLphhjcsQmaPQvFVJ6dto5iFL0S2Z6SlbZWZ0/GR/4610ZOGth0bxkwyDUiSyEtLSKlxRhkU5/xlkEKJw27rfMkjU73WOTGP+Ts7sSmqKwEa7dNP+TZWQy3swvAc3bjAbMVoPF+6eo/HC2VyA0XdfgTSw9MEt37+GGqkPSMU6DXblqfxYcoP9YttmHeKlLNg4zu9SMlEdwH1K8t1mgjaNnxEBk/l3uTLIQC8B4l7tTO+3pKRyb8DrCbjvZWGwD8lq9ehjN4lZMx4lYSG28OYVMDbdelk/e/gntwmIqMkQ1u2u/YnLJaKhHRUHXVnNiQfoMi27hiW40Lqv7mYJc3eZYMoG8elqO5tR1KuyZ4C1ZYZXgZurqo/ZGN98NdOWvOba+hbUMRoP+WSw5ZykOOhMd8TOQZlmN+HNMZwwQdv5RImF4JC7KDQieCrJTNnLdcB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJenwNAoYqfu8R7oZkvjsthzzahwiGGtyVYRQoY3zTbNlatk8TypAa1AMWt8?=
 =?us-ascii?Q?Oz1MOtumW7TN9/uqhh55OTkut1GqPuDwSXg/e0qlbXqxz3Ni5OauiV8g9aKX?=
 =?us-ascii?Q?U8n8oTLDC3UwRESdsLVKROx5VD2mGPzhf9yQ0KQ5MpSQnQE2bjJdqfm7+sNG?=
 =?us-ascii?Q?7pVHfrhkKiao0gNJtTiqiUZh03E/R/BeDDgsklETVtUCiQzkhdNkqo42yS4r?=
 =?us-ascii?Q?aXM52im8Z/Xsy+BsxuiP7QxboM1zKelpMJoEpQJiQmYddJZzILIse8d2FhFE?=
 =?us-ascii?Q?qXNKUqy8//NCjS7B+FCH1m9lEbFWKSQyLjNGPwzua2OnK8JDhp0H7n8SCPrQ?=
 =?us-ascii?Q?q0zT3/i6lCxN5YpxwMnNgaKiM6sIoW8zT6lgX5V7q5nn9SeHTIJfWzJpZasj?=
 =?us-ascii?Q?wFgR3y3cMhVPq0FsciWTAyr06Qg2J3Kc6geUv/GTt+7M9PedbDwjEMgDhPmk?=
 =?us-ascii?Q?jBjxxsC9JVggD/lo/Bh53fVv61IgS5lasyeLixrluHpZy/hS8PZ3m794u8Er?=
 =?us-ascii?Q?OIy7l4CrkcejAP/TvJJ/FU15MZdjFvXv8isz34jzi0eRQ3hj3qApZWurS7KN?=
 =?us-ascii?Q?P+ZbMglqt986NNhEFFrKn/McXH32YMas5R1sUclS7OOz8deG7K10ydLNLXtm?=
 =?us-ascii?Q?+8AfQwqNx8RqULr2kdIQbozefvAU2HeD1TQG3ejNaw7XD0/XozUEkI7qvXgI?=
 =?us-ascii?Q?XhGuOsXlFiMV129F1K5rkPNn36MhRNfNn+N08ncmUafVR3tvVcukP4lxkxUp?=
 =?us-ascii?Q?5F6l31XOxmhi0vkmaHaTPJ8fkuPmLJ/AX8ojBVZMsyMNBG/ik0OF0ugcbfbU?=
 =?us-ascii?Q?GOc1+2TEGo25/WBJh3y6ULIoRvGiBJdlxpzf11PdicU6sB9qRv4lnUQS9Bf4?=
 =?us-ascii?Q?4rS32HIZ/dQhwHhYS+ZrAsYO1ay3pIwD4XrOFSCWxDIus8J02THA/GCPQsiw?=
 =?us-ascii?Q?PsVGdr6Fh8Oc1D5G20WAGwVlEPM2kUxgvmeec44VbS8L0R9+ABBSWDXaQmex?=
 =?us-ascii?Q?T83CExt2yUDSRpmHSR3ar8pNyk/IcMXL/NdUvvP5h39Oxeo3orKlroK0Vvjt?=
 =?us-ascii?Q?y+0G9ywhKFiiwAGq0/tdbGks+2aBliwOBVO1/jj8paFVwo1+zpWvV9fD0zzX?=
 =?us-ascii?Q?BTo14MFXaoQMf101d2TO7zW9LESiXSHPowZzztoVOtSygT2NpAhIfL/U4D3M?=
 =?us-ascii?Q?cTYHns4eTkRo5z9wWGmniU+b2f7h/FbqjPxVBw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc889c5-ec2e-4cf3-6b6e-08dbbb3040e3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 05:53:32.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6897
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 04:58:22PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 21, 2023 at 10:09:16PM +0100, Cameron Williams wrote:
> > Add device IDs for PCI/PCIe serial cards manufactured by
> > Brainboxes (IS/IX/UC/UP/PX).
> > Apologies if this file isn't strictly for your tree. All trees
> > I am sending this patch series to use these PCI IDs, I was unsure
> > if this was the correct way to go about it, and better safe than
> > sorry. Thank you for understanding and please disregard if
> > its not required.
> 
> From the top of the file:
> 
>  *      Do not add new entries to this file unless the definitions
>  *      are shared between multiple drivers.
> 
> I can't tell whether that applies here since I haven't seen the other
> patches.  If they're only used in one file, you can add the #define to
> that file or use the bare hex values.  This reduces merge conflicts in
> pci_ids.h when backporting things.
>
In that case, please disregard this patch series. The IDs are used in
different drivers but exclusively, not shared. I will resubmit this patch
with raw IDs.
> Also it looks like there's a mix of tab vs space indentation below.
> They should all be tabs before the device ID and it looks like a
> single space before the comment.
> 
> > +#define PCI_DEVICE_ID_INTASHIELD_UC246	0x0aa1 /* Revision 2*/
> > +#define PCI_DEVICE_ID_INTASHIELD_UC246R3	0x0aa2	/* Revision 3 */
> 
> Comment indentation error.
> 
> > +#define PCI_DEVICE_ID_INTASHIELD_PX803R3	0x401e /* Revision 3 */
> > +#define PCI_DEVICE_ID_INTASHIELD_PX475LPT   0x401f /* LPT port */
> 
> Indentation error.
> 
