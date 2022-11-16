Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32362C78A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiKPSWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiKPSWG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:22:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335C519026;
        Wed, 16 Nov 2022 10:22:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTyd5zMwjGwDpWBuEfqTVaZh84QbSMBk5R7ZcHSvnx+zR0T+Xqkzko8+jzVFiTOUrPyxvSQDcchlRtdip2g93xdoCikYzdEH4QnFIKfMnSaB9k80ySLyLY5H8qMWHEBNw5CQWEoW5tAt8pz//1HUbrpLZxEkjgz7SmIBNHDe/sffHFvWwSO7P7NrR2ZFOMkJXb5g5vEfl62mqS7sfJlG1nrzFcbImn3vbetMw38EsCjKbna8kU4kCaA2zUIfcpwV5N2PUqj/ynVRrDq+XqsQ6A5JhNd2+B7Y4gTZ9S9Fukgq6S3xNvhUvE5zGq8HTGRVyjyqBDB6U17ynPn4GJcr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3tcatjvGDC0Tn2f0u5MkSy4MnhT3IJgrpjxBoq9OBU=;
 b=fMsX0dy4fQGr6yF64R28AgK3eO0Uaw105cEQO3o5uFMC5BdBdUbCa+TU+aT9M5xszucabIUoRIYkWdrPuJE1Ogq06PUY3QBMTRXk40qUgABqssCA/4L9auvJPUGsEgLeaMyuhLTFbsQk5Oi5glF3JmMfVMU7HMM16k3qtLLbzcSvHOhGav7kMD47Hn4Cqk7JItUJAp7W+A1AEVOVsoUVZzNSApgi2RRcy08QIJLBuWn7awKlKntgJyVMy0DdK4cYvuXgJwgAWnTjqJ6ZNyOgLIcAFL3jlGaU6/vsQz89mZmqjWyia+r96LE7u/J7WmpoZuCUvHn+0eCInujnnleVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3tcatjvGDC0Tn2f0u5MkSy4MnhT3IJgrpjxBoq9OBU=;
 b=UHIzz5JalRItmbADTsjRgWJKOvyXC/QI0uTI2YETU83BkPX60SpuA+fuhUU53io5aarUoJKKPEuuctoS5vScPkSA9ZGzDKmR5NItwKiHVRqYwd3g19WiOeLz2BxmSjZF7z0iXjAkOvV7SW7yTfJ09yxaRKXgsSKra6X40YNoiNcSu/awQBmg2LCHhyL5EnWsrxd3KDp+OP9hTz9JHVyg38MhbmgobiZsNookJxq8msTwKAu5/QGjYEweECsWClT3nDgWH7qygPOizJJ4UOUCcgBXEAUmkPv1C7+fwR2Mco7rsu2rXDpTdTx8TPPoxhBmI95RGaNgcyTSNtultJcp1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 18:22:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:22:03 +0000
Date:   Wed, 16 Nov 2022 14:22:00 -0400
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
Subject: Re: [patch 02/20] genirq/irqdomain: Rename irq_domain::dev to
 irq_domain::pm_dev
Message-ID: <Y3UqSOGDHl+vnlo9@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.163937407@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111132706.163937407@linutronix.de>
X-ClientProxiedBy: BYAPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a56dfd-95ee-45cc-9922-08dac7ff7586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFfgu9GBmsSHYWoNr4D9qkWzwunBayl6wI79peAuIwjdSjrlAnC04I/LGxMpE6/hFX5pBg6a6dScIZPlP7ugaeiw0Wl+tCb3Wj97dKPVSZAohFQM+9a+P4dagJ1jxZ9XRxVuAvbIrPaLvneO6Fd0VL8NDGick+PvK0bkZPpq/RGLxsf218AFlA4QPWxQurnOpVUJtfdn9a9rLA9t5UJK4Rt123oT7s6aI2nHh1jjuEUtLW9USKtA30DeC6mPvFJHkMPS73c2r6QKM6D1twlnOefAMULOgm+VyJNtNgSxwJp6lX6eQDSTB1MYUrFyziK6aiNYVj1AUJgmkI6wM4PVdhaPd2+498Iv9lyZClSBSwdN9kSXM5aTYg51B1nMGl3Gil9lwXJlQrtTHolxJHn0e+V+JQ1muIW/FqWdnIlI3xvJVS8Jz8FxbH1t9dYOaYE/dd0hsg5z9c/ZANzvzXNHXJbTaw2DE5XynWV9Rmr9QL1oxpBpgLIfbZuY/FUNSTV8u47T7pU2wFdx4AzRYuBuszxF6gBTJrs9E8tGQqxQEDTJriS5KyaOAJlvX1B7HJGD9LSCDzYoUOLWBBCiI4x+HuDgjBM/3xEUtetxZkyzfKdDMzV29aQJJxBCAxtpHqrQHnl/TD/zEwPYue6L8mIt9IdrjnPO6BlkL1REGCNKkPI0E68DmxjLQcZfqZvw2KlDubbBo8x5q7RTHFmMcHplOG0qeAwqlldQGnCw13P+k+aPuB2gOaWH77Twemssx4pZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(38100700002)(6486002)(478600001)(86362001)(66946007)(7416002)(83380400001)(41300700001)(26005)(5660300002)(36756003)(6512007)(6506007)(2906002)(4326008)(2616005)(6916009)(316002)(8676002)(54906003)(66556008)(186003)(8936002)(66476007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVxpYz0oJJTlPLkeF6VqbdkDXibYjNw3mkTVOhCz/wi1PCwInbkCxMM+gSf1?=
 =?us-ascii?Q?luvNHAtjNvLsjJrxcm9MrXAB56MDjAzkqHYX/FV1GjTZnpT4/9r8BhUBTYv9?=
 =?us-ascii?Q?VqJzpMMIjZuQo3ZjkEGSngnHExOG3oKuoZWyScephs+nIcbAHWvIgOqxokSf?=
 =?us-ascii?Q?haYaxF9J20/wtTnkj4xUl/N1ywkES/E2cIjOVQu6xUYhFoJwqMuSFzEHE8u5?=
 =?us-ascii?Q?OvrB9ypHqLiQ1VI9ei0y9Zt91JRnrVnAZCcbQlchO93+xRKqBnEl3S4W8p0B?=
 =?us-ascii?Q?tv1uO6gjvmuGFy32mPd4UTjTppz0dIWj0LpqjtiNwi3cy36+F01itvq+Rpna?=
 =?us-ascii?Q?31zO98IjdTKEhTcln4aHug2A0mLHjSMW3d+SiGFYzBQCcw+sY60YHnazb0Fg?=
 =?us-ascii?Q?Eu7U+1KVfKoG+wwj36oGbdZaXpbpsHyLtCwrHjdp4dH7Qsbw73sut38dCakG?=
 =?us-ascii?Q?vC1T7NKPyDmuvsvmq7J+lMparKKGIN4oTKi6XP4kEGhv4un/50/qf7uGBLcI?=
 =?us-ascii?Q?YqKjTjcyrOwhEa7Q3R7ws58AoZPwnURgx2w2gHvWQ5Y68Xx2d8opqNiVRTdd?=
 =?us-ascii?Q?cydktcxQFUTe+kR7MJQg7HO5xuoHqsQB1BxUV0kqTYHV+TtYTiSlw3Fn2oq/?=
 =?us-ascii?Q?kNuhTpwGq0k2/I53WyY3z5AGbZkuEEzdNMbN5/DlfwimKQ87UQb7dDPSNrbF?=
 =?us-ascii?Q?fMJnC4jQvVHYwaQNIjzg0rlMhNHceruklN4STRHIjAlKx1pGL04UwTqfhsbU?=
 =?us-ascii?Q?He3qqKFizsE9UrKNu8aSnkClqDgZMzQDCnt9CvLaDkCdHBEkT55GHtiqgdq8?=
 =?us-ascii?Q?/KmF4z2hT10QsXhGqh5NbVMahyxsd9SnvNpwlgVhIxMaiCCrndmRzRjZUvFd?=
 =?us-ascii?Q?CuIKgIFytqF+KeW9D9sZw6Dq+MpxX10tkhXe9wdjkV/4cfAYNAsnOxZ1wRm2?=
 =?us-ascii?Q?wd5IUnH4tx3W1jU4EHWjQtXaf4o6AKJjmGVe7hFs4wYXmxJuXfsI9UFQcH+R?=
 =?us-ascii?Q?u6XqPsSwWhrWyQSiBCv3Od9O6KFB0OcaOXxy9Hl3KkkySPdL4o0gEUNT5RKW?=
 =?us-ascii?Q?pnwG90tNcT6PsCP6d62D9BzBBTfwP8TCuaOecCJGFbZgUWYiQX1OmMLmRE0F?=
 =?us-ascii?Q?T2DoCXlARM7KCprKTPHZY5Aq9zDi/YjVHLC01slb9KJMNmQ7HKdWJ7t2FhH+?=
 =?us-ascii?Q?WyW850luqemNugYoWXkUYySkTsvBRBy3xObeMYTviF6qFBfcKKRfuijaXfRQ?=
 =?us-ascii?Q?k/pz3Akh4NnEf14oU8TMEO+/Ji2TldprEEgTvAW4t5zL7dLcIJFTnQx4K6Fc?=
 =?us-ascii?Q?4n3tVA/2Y9JqP7W8OxbBMyjJIbCTSqOd0sq/B10jINq5pTMHkHTPn0s835E3?=
 =?us-ascii?Q?7t+ZkRH38FUdPHNRA6yYPDZdpms4iSe7xcrIphgFtanvrGoNBEYADX5I7Ufy?=
 =?us-ascii?Q?l+hZdrwBefHre057qIkSifOJ3Eq1O0MtlW379X2b47Z1W13cw7lB5WNc4RF3?=
 =?us-ascii?Q?FDctvJ8LzPkXUMXxXQPRp6E2uT7A2aquleWAWklcb3W2A2e4xAHK88LzkVEq?=
 =?us-ascii?Q?wx8MnStcA9car3Gl9SJKBtjytQOkAwAjmUK7JLsr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a56dfd-95ee-45cc-9922-08dac7ff7586
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:22:03.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZz3NRdzkgkhnxK2m7rbsPlk3iCiahGu6kGFwJf0JDbtkyfQ/FdbXRoQqnbAS+P4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:56:40PM +0100, Thomas Gleixner wrote:
> irq_domain::dev is a misnomer as it's usually the rule that a device
> pointer points to something which is directly related to the instance.
> 
> irq_domain::dev can point to some other device for power management to
> ensure that this underlying device is not powered down when an interrupt is
> allocated.
> 
> The upcoming per device MSI domains really require a pointer to the device
> which instantiated the irq domain and not to some random other device which
> is required for power management down the chain.
> 
> Rename irq_domain::dev to irq_domain::pm_dev and fixup the few sites which
> use that pointer.
> 
> Conversion was done with the help of coccinelle.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/irq-gic.c |    4 +-
>  include/linux/irqdomain.h |   76 +++++++++++++++++++++++-----------------------
>  kernel/irq/chip.c         |    8 ++--
>  3 files changed, 44 insertions(+), 44 deletions(-)
> 
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -401,8 +401,8 @@ static void gic_irq_print_chip(struct ir
>  {
>  	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
>  
> -	if (gic->domain->dev)
> -		seq_printf(p, gic->domain->dev->of_node->name);
> +	if (gic->domain->pm_dev)
> +		seq_printf(p, gic->domain->pm_dev->of_node->name);

This looks a bit odd now? I guess it still prints something meaningful
to debugfs but I suppose this would someday make more sense to be the
::dev version?

> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -117,53 +117,53 @@ struct irq_domain_chip_generic;
>  
>  /**
>   * struct irq_domain - Hardware interrupt number translation object
> - * @link: Element in global irq_domain list.
> - * @name: Name of interrupt domain
> - * @ops: pointer to irq_domain methods
> - * @host_data: private data pointer for use by owner.  Not touched by irq_domain
> - *             core code.
> - * @flags: host per irq_domain flags
> - * @mapcount: The number of mapped interrupts
> + * @link:	Element in global irq_domain list.
> + * @name:	Name of interrupt domain
> + * @ops:	Pointer to irq_domain methods

Maybe all this whitespace change would like to be in its own patch?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
