Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A562C7CD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKPSlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKPSlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:41:11 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1788918F;
        Wed, 16 Nov 2022 10:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOXRvwLfbDUZ8DEym/aXPoYgt4OKD8I3R7MNxcGPGB/65iq4IGxf8B8GNM5YKLndFvRB6sFZuI9/9QY+WY+FkxnLAkR/f/hSyCAUrFo1rkSHqpFd8nwnllq20sShqYK5hrMLRvFFgo3rJm3kymrCCcA6oh2/ungNa22D3mNhq/szflUII/1ZjwJQNmDezIWEBj5kxVBcbm/TtoryvbR4jXV3sFzFKhjNBQB3TfCiL/4jW9j7fZjtL9juJVp1CJ6NBTvGiSCSdncSdTqHRUDTUFN4M47UqnVtel5FBcAlROP9kdEeloqkga9sfrtFCTjXmX8D0FLJ86ZdqR0ad1s8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1bNPKrMnTVc+l9U5thADIqK+XsJ6YE693MOdEsA0LI=;
 b=EMk4mFltJib3zd2F+bhVt0nYOYitPBMn27aWa53E8SnIsxD1VmC7ExtM7maHOHnixev87YJrpY75Ues71JQ+a426eqODMP+1CenYzfQ6i3qbEDwlRU9jf5RdvY9NIzBkoXsCkYAjN2E46gqNkSYy4PCUncRI4dbw4LAl8SF82+RHQLoxWQvGOIYgbD9OMOVC+/ZpP9TqWLhzluD4+IZwzqceR8jtob8xuDn3kSzGEgsKffy1Up6t992H0uw9LoB5TPwgRN13hU4UJ0hYx+w7556SuLKmHHI57cquvmDC8zYbKbwkJXc3YFDZf8gzHLYftNe98tE/1GCnsetCuZCiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1bNPKrMnTVc+l9U5thADIqK+XsJ6YE693MOdEsA0LI=;
 b=OMMyWbRxeMr8O3fMk1Rf/FVmTCl2WAOd/R5P4QXnWtVIEczFHewk/EUnabWjVhfeY9/K1JegocHLICNLmVyom4LeXh5a6zt9M5Eawg9RIUkKMJ96e3Q2mjG3hefuHKXPb6ris4KL7k0wdyzokmyrq32Rgil71NF2P5lb1BpilmGDAywHE674PyyfzZqVVo9oMol9WzB4ZqTl0WnCeBUUW5cObuUWCXzQqt/lejlp1CCWJvkgBVyj0xteb81LJ0jr/29aLZtzHoUPdTY6Ve4/ZFgKGhGvN+sXQtMqhRmPzixuZvGN8ezURvn7VgaW9i8C6xSkO6PVDIZkIefAspUcAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 18:41:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:41:07 +0000
Date:   Wed, 16 Nov 2022 14:41:04 -0400
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
Subject: Re: [patch 01/33] genirq/msi: Rearrange MSI domain flags
Message-ID: <Y3UuwHuyT0lq+zvg@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135205.309731052@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135205.309731052@linutronix.de>
X-ClientProxiedBy: BY5PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:a03:167::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bf3f6c-bbc1-40ad-61b8-08dac8021fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEsn++Cw0JpkmP3HLyYtHMwy5lExvbbDnPX+Mg+G/5GZH/lEyyc7o9gLUfiasGqoqVlS8HMI5cCi4+MKSVEiS9tRrp9cablX86JzHSg8aM9PrRL4byV92+5wj3WRg+evqEI+SNsMIZnCzZVh57GNwSMG8upHTjGzn6jNdtuqPBCXvkbDddbTJC2vX2/H3qn/ltZQPnkxEYR/NmxJZ9WiG0LG1gKR6PxLlrxBzK1Th+lrtEWG4fW6F6I/XDdHxRwty5SYbhlSi/yMeCjkEoKtfP8s5aXPen422B9GAav3f6oH4VwjF05ytm+A9th9YkOi1hkbbsrvjkQJxAoQxM1JrOoBTqyjJsvM2MIgOLZAi3ymucamkMaUlvpuKPdWAnUr9YtsZGEoiz1qb+dqUrTCozum88mKhpgX/PgcI1nF4f41LzY0LimpsVi5fyN94WWNdkAC7E9DnYE6KqcPOAjKIlL9seW42Uyu/KKxVYd4YEAnfILVq5BD10hbgSqW9vknK4puzKUoUykuXv9Sn5CpjxgOFjtg7/cVjFk2USGDvPQpHfrf5fT3mmOYRonr3Vg5Wb7AritPC8W7xtLun7JlX+8PP+ini5GGVTY7H2srmnfGyrvxP3zwmwDkw4eC3QpL+eGAGWLNcHj0TbntfR47HnYnLZ0dfl0DlQq43dnObJuXUNT12DJDpeqjO68KeQVYkWzcIg08FbIT5NgG7rL1JbxCc+246kY5SrnP6gdqjJecAHg7b/91GgjhZvNFGtUu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(2906002)(8936002)(7416002)(5660300002)(4744005)(41300700001)(4326008)(83380400001)(66946007)(8676002)(66476007)(66556008)(86362001)(36756003)(316002)(6666004)(6916009)(54906003)(186003)(38100700002)(26005)(6512007)(6506007)(2616005)(478600001)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wq8nS/qmdvtIPuwQPSSP0ebjJ47Wa6yJ3Vq5PyQF3d17E4io+iHVNSNVwvYw?=
 =?us-ascii?Q?VLsOk7Zxa44YlEk6yIT+LfB9SVE7MATKglgP74woCVBw3T+BJYRBvGrWGkIK?=
 =?us-ascii?Q?oEhkiy+qJGHQv6BImoBNDD1fBdXurbGggyOfH77W5lGFNIQHit68HkkS2QdP?=
 =?us-ascii?Q?7qmLJfh99hE2ar3f9Y6hzmegiwXE3+XxBnW4RG2x8n0sya7y2wSXP5b/jCDT?=
 =?us-ascii?Q?jobbc/IH8jN5WY0mBFAIwQE2sFBBxM4upO7gdj8Z78odjjS/LvxbKqBVB4B3?=
 =?us-ascii?Q?Pga712KzuDRpzL7h3XfnI3uO7PZOKt4+dNtux48UGF6tCNBYva2+fC109xPs?=
 =?us-ascii?Q?dG2KBV7eOsgk+BipJ5NZ3oaFjJ+MdBGy5QGeFrPqQxDjXnFHyV+Mg+U3qXcJ?=
 =?us-ascii?Q?LZQvnGlPvgvYXWF7KsIpM99idlu8koBMJ/10TkjvN1Rjqw0h3/lfD4jRni1r?=
 =?us-ascii?Q?RaLNXvGYjRLKFUcJmxVBYOEVmzOMRTGtmmb+xyDpQG8tE34qfVKyTt+72hfc?=
 =?us-ascii?Q?OYYzZjPRvAbrVUzBVDA44Ll2ijnqI7pwfeRH7R09wlxzXYTc/s1CUUqzKmvO?=
 =?us-ascii?Q?6HTKAb87aMJsqZkhgMflyVOVGajQ0ow7vE/Ndswh0Jorc7wJMbsAkPDmkHko?=
 =?us-ascii?Q?w6CCcmOTK9nQXx8TKPk6Wb/iDNVRQcS5+05RUYon98FC9wE+dle73ux4s9+8?=
 =?us-ascii?Q?8N/UF/nwSmStV6B+Vn11XLxBPSqNFRUmyW6hgJ6M0noOuUgGfd2ik+HKTC87?=
 =?us-ascii?Q?VzFqm+TPlo/0FC+xmMnxaBiHxQK6L50jhJgNFVPV3eUrarR8f8OHC9xMvBHI?=
 =?us-ascii?Q?txZxMVSXOJyVdgxGWT6WeSycY1Jc+05ksA4B3c59n/NSGYv+qNGXefp7mK9Y?=
 =?us-ascii?Q?+k4Vu+fkGGeBsEfE+SD2WMAEP1bkrLgFCteX7zE3G6VCMgcOaczBFZPGb7Le?=
 =?us-ascii?Q?Ui1ffHx6BOpjZCcEmS+biya0y4HlIC7Sfx3yvApIr2yOHOP/j2agtDA2Cu11?=
 =?us-ascii?Q?anzAGe6lOM8puIcXg2wR+LAB2KfqvBMdzU0a8ovBGDiU8CDQpYYZ81tOFSac?=
 =?us-ascii?Q?PWuIR9mKT+ydZTnY0lL+JG/iOEtCPi/ruidnyZf+5ZBD8QusLp6ijDPu1yhJ?=
 =?us-ascii?Q?/no8nfZNigvLildH+8Dbuy9Hfc790zFZjcaBRX+b2xJSUmx70TfxuBiLx0b5?=
 =?us-ascii?Q?1r1kNLjFBSfcHkxoN8qQZE+ULxHXkDoWe+pDDkE6JO+YtktQo/y54cLDNZ+2?=
 =?us-ascii?Q?ASJ6wbaq4Byna0VTQ3RhnVkczeh47nTRkfzRzvT28UTNPnnghmpvSN77rdLv?=
 =?us-ascii?Q?JCIjdBP1h9mkGHyM3YYNYDZwD3SsCMZsg8WdusuQx5PcRBx/IvjLW/bQ4M33?=
 =?us-ascii?Q?IWH9GL+QE9K6x7fiB6Ofbkvpl/1NjOG4BJC/kAD5h4p+pqg5aoX2WDwbiqnW?=
 =?us-ascii?Q?uY7I36pgw1T97bfktNarrYe45YSgXYVcHAghrXJjyJJkEsGYKm13ls/3/9Ns?=
 =?us-ascii?Q?EML/+uRmOFgNeYbIskrLEECTGg035wEgt1kgdPZIepjVZ8zYEXPSU+77U7Se?=
 =?us-ascii?Q?FMnZl9YFJKF2XRgJba4KHS8fvMvwViL5lrFVPpNV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bf3f6c-bbc1-40ad-61b8-08dac8021fac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:41:07.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYaS3Fn8gm9IHtIVCZ4frBTawhBiCrcSkOxMNL8QQa0f8aGQO7iyuxDgVRaiDQI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:12PM +0100, Thomas Gleixner wrote:
> These flags got added as necessary and have no obvious structure. For
> feature support checks and masking it's convenient to have two blocks of
> flags:
> 
>    1) Flags to control the internal behaviour like allocating/freeing
>       MSI descriptors. Those flags do not need any support from the
>       underlying MSI parent domain. They are mostly under the control
>       of the outermost domain which implements the actual MSI support.
> 
>    2) Flags to expose features, e.g. PCI multi-MSI or requirements
>       which can depend on a underlying domain.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |   49 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
