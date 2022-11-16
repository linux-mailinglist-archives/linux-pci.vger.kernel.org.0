Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF08262C906
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiKPTgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 14:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKPTgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 14:36:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A623C26577;
        Wed, 16 Nov 2022 11:36:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STLYxpDronDOnkPA7GNtgtJUwX/Usc1pXJmBSukh7+RC4Jfd6XFYuVDdJh1pkyDSdHLNUzC0IbyoxEnYzkQWEpQyyaG4TZ7wD5SkTIktOkjoS5zb4OHLONspUE+2CLuBQigBmq0YBgblTqPiD0meRRPz6DN0MvO5eYfKKLPjMYuTneywT2NH6dHOV5ifRSyHeAnAKAmMGxYBuU8b/yH2dONlxb+Zm/tsyxIg0UwdLz6DnpUtIXK87/4VUIT96YFZSfcrszcmXy97yiMcYYui+V52D7DzEMKQmnJ4A4+q6MoQ9SmFnlANFbrUK+0iHwuBdD/cn4pdv+h2oqk6eARHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hwpNgK30KkGgOt2HPOfwjiYd6BOzhVwrREwj/1cSp4=;
 b=E7bXUeDCafVThsnDV6BCmUQvSoTT4cDFE3/3QMkODx6eFiYvFJkQAIi9416GpEv4fbpCtbj/+Mc7Oq6DAlI67LmF+KYNvajsL5zgz7Eo6MJ1tHsjMNeN9ysEAYhUY560OJ/yQcilKn5NUmmwtIrY4xYc3NK20H2IOe9AlUndP3fVknYt29hmUntqGaidBCU10nKkjRp8P/OxXJapF05jNQBJiz/XXekTtGKX5dRiGDWeAzA/2myvMM0WPfF+V6t1Vq/m8kpToGXnZuvTUgxiDBVHmM2osESA7oIbyEDlpNsozzhN+fIIJh0CM6GMhU7Bhx53eUULzZ8oovs+BgpbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hwpNgK30KkGgOt2HPOfwjiYd6BOzhVwrREwj/1cSp4=;
 b=U0zTYGX2zS4oRlRkW1H3ImbJfYiln03ILuXnMXXHFly+nHuKr5OOhWPv2vh0LY0jChMSA2bLdl4dQJp/HLmC20yTE3mHZp+yEnjkTIMJXXF3zVtTbCgm7EUTY6anSLAQoNuSI72A5v9VwoS4kXmcuoayh/cnaBJhwHOo9iWmuFN/pD0o3F6fLkL4RC1I4iFYXrzjfF7o1H46jePenP3SKdPsVlOeuiZQ6+xr1/AapIYdpU+ACnPg/koiNL9+PpXtjpCI2nkkAIWBgkupJqYU45FjOmZYiCwkxRKi/5pc/4FwryQN4zd9C9gYtEnE4xzIMWxnviK1mmQSe5S2W2gX0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 19:36:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 19:36:02 +0000
Date:   Wed, 16 Nov 2022 15:36:01 -0400
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
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
Message-ID: <Y3U7oeW7jfEDv0Qu@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.463650635@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.463650635@linutronix.de>
X-ClientProxiedBy: YT3PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de903d7-f566-4109-e13c-08dac809cbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XT6LCYzgRTy5CgJ+KJgTXDDlLZP/cLW0yY2wK/iuhfXgLeedBp4wy2yMMHykvHy0p5JipcIqBA9FaPQYeCidkzfV6h+2Gp9ZKGjyDYC74MBLDD8e6UVKr+hxvQuU8968HPAQLy62VVtvKC8DEhMTNPoPzCT87xjLS4IHalWd1ihBe2szYSCeyVb4rV8HzvIeFvzIrYACpC5NE6gtJCFSPdboVZ8gftwl1HA7Dq4j1GTVmBbjZTQ2slNauYLM/Z3OwxqPxsg7wp9VB9/MxRAlplmCpCRagTHrMuozJrgQcDU0GXvwHOZCwP0j6TZ841BTs3IAXxwSgfE/8FApPs5jhrOv3fWsAm+eAXC0g7y3h8g0AS7aDYb7vRSqPzDbY9NpOiq+ooPn8NHSQUdsuHPSPOJ4dyEHlppBT0Q6sbR3YLux+znhLA1ZLfcOeyAGFhPXnSc1Y2j3uriDTAZg7mKmRCIfugD1qxSzmdGdZMAUx4biyTyMFoESxsYLr4UWTesunjjtksEor/NaNWqsgb1Ka+Udz7mubZMgfw49QeKcfUfxoPJ9U70rT9c0YA6Up08ZqrrayV8wNhNwiZEWgCnPnkWdzuDnogEN2Hy7KTLjalF59UW8j7gkzJSFSo924r6v5IXcrOXgwmnvrsJL2BLoR+YegMqrtsF3kOtGnR5pltufTlVS4w2em7B22eoL1GpT2nfSyvBKOQDaLzbso4Z4Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(38100700002)(478600001)(6486002)(83380400001)(86362001)(7416002)(5660300002)(8936002)(2906002)(36756003)(8676002)(66556008)(66946007)(4326008)(66476007)(6506007)(41300700001)(6512007)(186003)(26005)(2616005)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z8eYJzvT+3DEDyjuPt12AIYTmOpkG2tDeRmdcAeeeqhLS1HHZbW0pqbXLWzJ?=
 =?us-ascii?Q?pqz8aI2FcMnvYVcBiQs312VZIWkH7sE+d+YNKB/jtxL6RcYz6895peYlXrRh?=
 =?us-ascii?Q?YoX5E1kOzLjrH+sAPMVM10b0BNCjvqKhda6sgSfmw0CBUTl51koT0p9Ra7mV?=
 =?us-ascii?Q?Dl+R9TRlt2lWL77rUZ1iHv1See7UehQFvYIY19Pn3k1JJ6YXjLrLDoZmM9rO?=
 =?us-ascii?Q?xw75kd+uv0q13YG+NYb121ethkhY8TktFgzaRIpJF33hk1G3mzhI6oOaQFu9?=
 =?us-ascii?Q?uNkM6oFhLqmI+26S9ySZc6Qm8e9B1A6MtY1DwMBkrwoD5LhX46jzZNNqZ+vd?=
 =?us-ascii?Q?eyRwUYeDWND9Ma9jNf25x2QENYcvOn0CgazIMbuLx5NCAThGequJdh1qQYM0?=
 =?us-ascii?Q?8rJ1JMj1dmkk2O/bYPiAksZ7Dpj7PnEEhngh68kqfwjKzQUxjrz3PbYUS07P?=
 =?us-ascii?Q?yMpcdq3CgUCoHO17/KeWuTjEnAh/Ueiq1lKyVy7jkwuYKUZ5vaDmcwVgNJ4p?=
 =?us-ascii?Q?JQviZIIFm5/dgaU7HZ1yclPP27JSvvsk+dbOdX78u0qQSV9hgtjutOqgkCzT?=
 =?us-ascii?Q?Pr3Eh0HGpWCQZYNHiE/wUpsLJx4W0bHlkWRSMjAYOm2Azo1inT2q+v9LOBRv?=
 =?us-ascii?Q?2DSaWxPYtFPq35myRqPJKSWw5rVvQ9RlPSFRrKhB24H91XDKSzzMnzBd6C+j?=
 =?us-ascii?Q?/08F3DHZjYVVsnq8twVDxCH5d3mlInZLiAKm+Tk65CxQnm2/a83K7rOL2Pib?=
 =?us-ascii?Q?gMk6NQoVHjl2O0PlU2W+D1CCGx6/Q0M0DNxeUPESDMKpRmxElT3uIS30wOCq?=
 =?us-ascii?Q?lmp/RmissEwja81rOjXPSc540G2zRrk2vrWtyUhyRkNvouA8dg1bBPFgygcx?=
 =?us-ascii?Q?kl+gYsUIqxmyBzfoM5kkystmN54y02dnnRmJ+tutJlacfG9POhu9oxI1lw/j?=
 =?us-ascii?Q?EDvoOiTf9Vcj86O4wN99aobQbhxtWNrBHAH9cYXZvlppljetGfyH6O18cIBF?=
 =?us-ascii?Q?H+Mu2YgeJ9DhnYsRZS/k/6fUPaceML6AdTcgUzR/va+ieUI/7vJxPUVePM1U?=
 =?us-ascii?Q?nHMkbZQD0nogrnu09g9K/iCW7tAjG/c+GigseVODd41DlJteVMjTD0iq332O?=
 =?us-ascii?Q?38IXHkvkPCWT+rvbP7Se+81amd4LdsyUe1BFUbbQGw+DeTGvL+f3QaiVpzKs?=
 =?us-ascii?Q?aruwQZSVpUDJCgBfWmFjlZ1zHa4IomfnI8x6ErF6/7sQ0xN8yhIA6Ytw4r+r?=
 =?us-ascii?Q?hk/zrQc3NjX5aTQOrYwsinsx7CwANxVUTvAYbuhkWLbOCZOXoRcOFX8epmSi?=
 =?us-ascii?Q?C1QSeBcJyz2GYEbmbX9d0Ocy8pghiHtuSC5pOowQZ+mqdLbXyhoRqjjSo4fz?=
 =?us-ascii?Q?zsd6zyEE7w0gKLsv9amcN7MQ4rejUYjPVkhAVZ1bGGbmJCuSTaps/2QM6Opr?=
 =?us-ascii?Q?Louz6pk+n5Z51nfWH8n8Vwu8pAiny98hQKZ/dloHpfblgvaqEIFyehdffiJL?=
 =?us-ascii?Q?c3LBLZMj8+c68RPZvL1DDqFo2I71/PT9CkLUTTmcUfflRgcVpqAgq6/nBYq8?=
 =?us-ascii?Q?4R2X7qzkbLjEuibLapjtZhYqdr/KEHgYH3d2Zgmx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de903d7-f566-4109-e13c-08dac809cbe9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:36:02.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI4UNwR3C63EGWsV9JQcFD4Yz0ble/hrLpzbpHMZL1OAEscRkRs5yHQ1H+zN8tNY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:44PM +0100, Thomas Gleixner wrote:
> For supporting post MSI-X enable allocations and for the upcoming PCI/IMS
> support a seperate interface is required which allows not only the
> allocation of a specific index, but also the allocation of any, i.e. the
> next free index. The latter is especially required for IMS because IMS
> completely does away with index to functionality mappings which are
> often found in MSI/MSI-X implementation.
> 
> But even with MSI-X there are devices where only the first few indices have
> a fixed functionality and the rest is freely assignable by software,
> e.g. to queues.
> 
> msi_domain_alloc_irq_at() is also different from the range based interfaces
> as it always enforces that the MSI descriptor is allocated by the core code
> and not preallocated by the caller like the PCI/MSI[-X] enable code path
> does.
> 
> msi_domain_alloc_irq_at() can be invoked with the index argument set to
> MSI_ANY_INDEX which makes the core code pick the next free index. The irq
> domain can provide a prepare_desc() operation callback in its
> msi_domain_ops to do domain specific post allocation initialization before
> the actual Linux interrupt and the associated interrupt descriptor and
> hierarchy alloccations are conducted.
> 
> The function also takes an optional @cookie argument which is of type union
> msi_dev_cookie. This cookie is not used by the core code and is stored in
> the allocated msi_desc::data::cookie. The meaning of the cookie is
> completely implementation defined. In case of IMS this might be a PASID or
> a pointer to a device queue, but for the MSI core it's opaque and not used
> in any way.

To my mind it makes more sense to pass a 'void *' through from
msi_domain_alloc_irq_at() to the prepare_desc() op with the idea that
the driver calling msi_domain_alloc_irq_at() knows it is calling it
against the domain that it allocated. The prepare_desc can then use
the void * to properly initialize anything about the desc under the
right lock.

Before calling this the driver should have setup whatever thing is
going to originate the interrupt, eg allocated the HW object that
sources the interrupt and part of what the void * would convey is the
detailed information on how to program the HW object. eg IDXD is using
an iobase and an offset along with the enforcing PASID, but something
like mlx5 would probably want an object id, type, and SF ID.

This is again where I don't much like the use of an ID to refer to the
domain.

Having the driver allocate the device domain, retain a pointer to it,
and use that domain pointer with all these new APIs seems much clearer
than converting the pointer to an ID.

Jason
