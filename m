Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE162CFCC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 01:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiKQAhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 19:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKQAhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 19:37:15 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C86AED2;
        Wed, 16 Nov 2022 16:37:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWNzk//A0Zh3tmGtU/cn01ivUVaZmzKpMwWDl+HepNh20Kusck5Lct7wPIhm/sbzb252v2e41KWjVQUPipMsJt8VW2bb1+gJbUakCDLyVDLk8sT9fM+VrHkn601yNJdLb5276CblHQyLlkxcF7zBWiiPMwf39QXlrb2gQ1WFuE/GMlrpkS5JMr1yeHGt8H/h2uU14IiSn7fVEsFUN9hE5XLcLmcpzbph4onAiIMcOmeklFmWD8QJSpdc9EvXx1jRUP1oneYaTksMJOKnrgsZviUWsArQfWGE7E6VWzropjxBZ7HSdxAFAVHrrqf2qm52myemrU1Jf5n4E0PXyZnSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksKNGC1aF1HxT6inu+bWLbVIsFZoPOyxjWDhOuG4cQo=;
 b=W+e5JsJkFWcG2iDSdgOBEFtnWBC4Zp5tZSs5LVc7/ZPByRC4W5df1aGfF5Lj8pcZVyr88JH+A/Qwxg2W6p4K79JeAtJH50KbUM0biKL0K1A+Wn9dWDcz163v/J/iNLwh756Z4nsr1clgUii8He0zdCkxiFMzlsN1hO0ZPt4bC10xlU0cSikOCYwJgi3ZtjrdRnWMPH3fwYrA6j4yWncBDyhNMPpa+Il63mnh+RgvWXbdxb2Tif9ARqnwWOMw/uA8/GplcB7iGC11rE3kjf53lvGsWMvJZrekpiHHz07A9SkG1gFXfx/fw4DHMIY+VFZ7KdLjLLelfGi6mIHQWOP7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksKNGC1aF1HxT6inu+bWLbVIsFZoPOyxjWDhOuG4cQo=;
 b=WuGGOWHs/bF0aiDytGPBC/mAJIn+OuUMspidKk5giu41U0osOQfpmSjRyPz3cTtBqtG7FyZsr6bbfZnGaGP9uDM8n5FPPz4Dxx+D4jvetfSppdrZJD0wF184wxgB9jaTkHJorYR0OEC8IAAnZnVYAumBr+eZBEwd7jGtHZt06ipcLYWfBnmWWqP9iP+58tI+YaHyX+Xc9S4hHuWq40TVxcQNsF9jebiIWprQ0ue0dPwdHrjEcH59TZf6uljAzhl8ObJ3aepYs+WRK1fBjxq6pvZmBRzBzVzy6iMpcME2ncrFt7G1vjqQ9xvJHotnaXRIX3fhZqHBfG5aqZgZgiT95A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 00:37:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 00:37:12 +0000
Date:   Wed, 16 Nov 2022 20:37:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 08/20] genirq/msi: Make MSI descriptor iterators device
 domain aware
Message-ID: <Y3WCN2bAvBvbp/w5@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.500733944@linutronix.de>
 <Y3UtlTwIka6n0RuT@nvidia.com>
 <87wn7uo7io.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn7uo7io.ffs@tglx>
X-ClientProxiedBy: MN2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:d4::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd9de73-6821-439f-fa18-08dac833de52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9WqiF4Rs78Cw6OAzfZpXCkdqbL4bZxHNFpvdMEzi+gBa6WTQJ6KL65RGHseN0YGJ6k60eh/uF8Hr9QG94/JkUrTzAPXcJGh9bINk9G+lnXmzLJzkmuUEggGoQdrwxs16LRVBYunKphJLj6Gl3xGKNY0b48Jl7M26eDMRlT5O9NAFE7+v1uIEuC6rPKskWNJtb6sk/zvyuFjdXpawnRlOvUOBSz21wuUyNV+S2TNiL0k5iEuQQwFdYFbFRImdeAi5/j1yDZgAmuIgXzaMz3BCWqMskSharacCeXpghhmY1HLFCap33Wtd+2dK97mcdosRxq4Rwaqe9OHk3K74MmfsHfoiouA5z8D8H1E6P6FDnWwVLCOXReYCUTWr4jv8mA3U7fQWqUHdLZ4i9iWksRzOaCYcvXSKUe54pq6ykrjOQQ+prVtE38KiOGVjkIEkaiZecCjqL4GR8nO+IfOg/tyTxgWVKxLVz1phNxOoQ4JUG11U8kgHGHWFtgYe6/q2Cqa17Qnoq2AEro0CceSFde4kH0CaRG8S+BljqyDztVMCWDyY9vI0mvKVtQGKKDGMOOzbLBiG8rFDHJHP5XwSgwPBSNUOGTUsGsPpH8gzKR3Q5PqV6m5celfwYi97up4ohdOtcrILs7V+GwKddPXVMziZhhve3ijdrfBaeXP0wrWaH8O3sEKi58vOojqQDZ5ocK5Q5rBtEVmplxpf4DrNc99tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(66899015)(38100700002)(2906002)(5660300002)(8936002)(7416002)(4326008)(2616005)(186003)(86362001)(36756003)(41300700001)(8676002)(66476007)(66946007)(66556008)(478600001)(6512007)(26005)(6506007)(6486002)(54906003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2uciyCeC7bGEtEebeffdsH/SKf6mI4y3vZCn8OqDop0lQQTb0OLpksbMWywW?=
 =?us-ascii?Q?3aEoIXc7uaDh8/JRnzv0ouO4AsmkYvtF8PfAMY3G8u1yZC8Ti6N+yr22phut?=
 =?us-ascii?Q?ByZ6F9hawvGJKqKgHeaVlM90l5uymMAfBD0/YfqbLKzRHwJzUEB16sgwEJse?=
 =?us-ascii?Q?WKlmYOtwT1obfMA3wZNU55cCy2ndO+NVOV8Uj0sq7wdQislocTLTIxbSMKvt?=
 =?us-ascii?Q?DN9Qfbf9wPvsuMzgtYALkKnNGk7hsKT7L/wzysA+VQx3RgaO8giEAaysw703?=
 =?us-ascii?Q?GlT98c2Vqjl3tauNhsMKcan5LwQt8UlRBBFUxfzOiFhBLnEVTXET+FzG0ABU?=
 =?us-ascii?Q?tQRoFumuXxMugHfnH2gX5CPE9YBsklWLuNGzVhX2DgvIACPUdzQ+ZU1HGA8F?=
 =?us-ascii?Q?V/UNnSvp3BzaoklAhVic6CZElry+9H+aJfQk0/1ynr15SRfW2lid7jwhUf9s?=
 =?us-ascii?Q?dG6n3oxjsTFVJi3DQreZvNIjoXP6HdMt7mWlOZEsAkvZh5lmLvyQbmEoyt7d?=
 =?us-ascii?Q?fSLHWOv6F3EdsjqN+p0SSkty9nxiffXlqqs+lcHLJBMQrA3BzKNHYAAhs33S?=
 =?us-ascii?Q?hq65Nky8WSD4CU1mT/l5JS7xeSSpPbSvN4GwJcdsGGgGj8PtgTjFbURptqnz?=
 =?us-ascii?Q?1r/T4fPTX2weW8s2TFK5zdYkULjAN8+dZU/RzUf8CTCFCI8UHhOTiaO0tMU8?=
 =?us-ascii?Q?BqILjSIKbWccu5XkTkipdsFol3GYu1AxTB9VRLzzAAcDLkfoqq127veYU0a+?=
 =?us-ascii?Q?tpw++uI5b6EuSFCJcxhJ06x+3gsncAPwBazuWTpzbz8yQmHkvMBllHU5wZ1y?=
 =?us-ascii?Q?q2SI8N7SDR+8fX0dzb/dgSkkYNUjcFZtuFC/2tK/o7P6DZmg8g6aZ2qsMbIW?=
 =?us-ascii?Q?Tn905/uVhgO6ZCQlr5LRjHhXXHgvARxXmbwGhN6e8p8ftmB3o27204F0OVLl?=
 =?us-ascii?Q?k+6QNBsp+5k66QkBprUK3aWgbUP7Bb/IUpUcu6mnL2AV6AtiVf/vS/l2UFEf?=
 =?us-ascii?Q?fAzNydOD5wazpRUBeNJKYvOsj90cq1A6XkzX2K0uVJKZvGEWaLqvxLItjmQS?=
 =?us-ascii?Q?klS025diuhhtTEimyIY8m70iwmcwTP/dN/7NlpGjMu0O2IfiCwwiT5+1YwWs?=
 =?us-ascii?Q?xQWMcmynZq7kaq3xcOT/HwQgGxM3zjoqgJoLCEyooVe3PQ1G5b8VnC8+f2Tz?=
 =?us-ascii?Q?7C71Pt3PaC8qox/NHp1q8rc7JT6V73U/qUz/xYi6BICuYyCfBYAlBBxB91SY?=
 =?us-ascii?Q?qYtebioB1GY/cr/oCqh1I2obw9yNUj/PMZ5CYblibSvQcN1fOIvwMayERWzY?=
 =?us-ascii?Q?r5gwC7dc1o/ErJ5KxsiD8zSTd0XG2tiqpKm7YXy4Pkm5B//MDkl1Wb18XVem?=
 =?us-ascii?Q?FNU+1faywzFXyH/lfcmj4vqXND32TwqbuCXQaQSFHmLtGKX5eo+YkuY0zJmH?=
 =?us-ascii?Q?kvqEZm9D6lScDSuo3XhGpQQJp5rycMifKZYF7y5DhTWKzpK9NO2MzgreMUMX?=
 =?us-ascii?Q?cosZXf9GoGxNMh4FxkCZwKYy81KUw/iu820brAvBbCqXwtBM4whIZR+2uNu6?=
 =?us-ascii?Q?v9FVp0FsxxLnWcOEUzU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd9de73-6821-439f-fa18-08dac833de52
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 00:37:12.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLRKBBSDLHU20CWT7ToQCei4YSxRIp1O/IzdnFl9aggEKYetnd7IvgdlYzVU+R3j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 11:32:15PM +0100, Thomas Gleixner wrote:
> On Wed, Nov 16 2022 at 14:36, Jason Gunthorpe wrote:
> > On Fri, Nov 11, 2022 at 02:56:50PM +0100, Thomas Gleixner wrote:
> >> To support multiple MSI interrupt domains per device it is necessary to
> >> segment the xarray MSI descriptor storage. Each domain gets up to
> >> MSI_MAX_INDEX entries.
> >
> > This kinds of suggests that the new per-device MSI domains should hold
> > this storage instead of per-device xarray?
> 
> No, really not. This would create random storage in random driver places
> instead of having a central storage place which is managed by the core
> code. We've had that back in the days when every architecture had it's
> own magic place to store and manage interrupt descriptors. Seen that,
> mopped it up and never want to go back.

I don't mean shift it into the msi_domain driver logic, I just mean
stick an xarray in the struct msi_domain that the core code, and only
the core code, manages.

But I suppose, on reflection, the strong reason not to do this is that
the msi_descriptor array is per-device, and while it would work OK
with per-device msi_domains we still have the legacy of global msi
domains and thus still need a per-device place to store the global msi
domain's per-device descriptors.

> > At least, I'd like to understand a bit better the motivation for using
> > a domain ID instead of a pointer.
> 
> The main motivation was to avoid device specific storage for the irq
> domain pointers. It would have started with PCI/MSI[X]: I'd had to add a
> irqdomain pointer to struct pci_dev and then have the PCI core care
> about it. So we'd add that to everything and the world which utilizes
> per device MSI domains which is quite a few places outside of PCI in the
> ARM64 world and growing.

I was thinking more that the "default" domain (eg the domain ID 0 as
this series has it) would remain as a domain pointer in the device
data as it is here, but any secondary domains would be handled with a
pointer that the driver owns.

You could have as many secondary domains as is required this way. Few
drivers would ever use a secondary domain, so it not really a big deal
for them to hold the pointer lifetime.

> So what are you concerned about?

Mostly API clarity, I find it very un-kernly to swap a clear pointer
for an ID #. We loose typing, the APIs become less clear and we now
have to worry about ID allocation policy if we ever need more than 2.

Thanks,
Jason
