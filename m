Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F009041D019
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 01:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbhI2Xmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 19:42:31 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:9185
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231238AbhI2Xma (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 19:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVwUW6pLDKxaNe2rG97oxCjfpuTKgIVQNJZ8wHHZ12tnHoplZB88stnrHfXuN8saFMeq1roiNyAkcFi9WIYSA+ZRbwXuXbSa/y1kMvr+sx5eUQiB7I+0Y3xKDBs1PYs0PgarM/CFwJATCpAYnKTeptyxbW7mO4qP46asXLe18O5jtjfIxh+vEj03jtmmQWCpivhfO8pVgiWcU0pC0TOSyXbUCaKdOuheQE+FLRbfp/VkFNnOE7B1y6DjtfC0W+hDWfIDHgwBhE/y8kpy8rxfgEyjM38rC8bhENlHxu88kxCWSFcFSo4tWilBnsdKD+raW30y/lZEjM3WnqpSU9UkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dm1YdaXJTx7YoXnMC+FUKNK8W1/6uOAgDU9ddKAXFzg=;
 b=L3ohmsXA3GFjPxestD3h/8Ml6Vexp9jTmptFYXYM5LgCFl+ny1ML7mgulLsUHoNxDpi6Gvi9XYaLi9Damq/oUebshPMAENBtBwrwgRe3PkhmnZgSuOVWnZeeQkb4YrRGo91ncXeiqxll0qf7yYDooV1z/TeNTJYv47+OUHiqKxqMi5kXUeAFMxPbv+IEewGfGOKuoS6IM3ruNCXZCICPSiJynknonaQfWg2ob3Own9bYjjLXKtmX75rJAJ9z/lfozbUScMu2QPXAfJbe7TsMrzbWeU9PhbbRGgoJHGj1gZ/1/LjLMEWfVj2f30KCX6pq4vWU0bz6VktQX3NqY2+fbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm1YdaXJTx7YoXnMC+FUKNK8W1/6uOAgDU9ddKAXFzg=;
 b=o+P44I5AGpsJaenXnGH+BVwsfskpfafmh9k1AU9Yks41Ycx1/ewpr4Ffa1rrdvQtNUbphMqSo5iNTVd+ucH530f0tgjC3f4hzwzbnGi8ovZE+hsHOX86wp8imt8pp2uEMp4E46HZu2u2y1WXvagaqzcD28oflgb4/ESx+0jS2xbuQrHsnwaa5vgX2lMjeI4TIaKG0m/+0EaAVN36rIRplnnmsod1S1ZZZymPFG6ItNAZh8a1DQPkks36ETsBMRhClVMHzO5Pe0/XOfhbiOlRhGaYGfxe0LGsVyZn/fRAyfgQYGPsQGgxFSR651MTMgxciyJK09F0vnRf4NTFdkppKQ==
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 23:40:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 23:40:46 +0000
Date:   Wed, 29 Sep 2021 20:40:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 4/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
Message-ID: <20210929234045.GB964074@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
 <20210928220502.GA1738588@nvidia.com>
 <91469404-fd20-effa-2e01-aa79d9d4b9b5@deltatee.com>
 <20210929224653.GZ964074@nvidia.com>
 <fb678f5e-b477-0bd0-334b-a57e771eedc9@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb678f5e-b477-0bd0-334b-a57e771eedc9@deltatee.com>
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 23:40:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mVjBt-007j1L-J7; Wed, 29 Sep 2021 20:40:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c03fc0-6945-4779-4134-08d983a28f6d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5240F938B828E836CC6D943EC2A99@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uDjiYICOij+IVLhRX/3SZaFxt+2CLt/vJO6MWxKiptjlmFX6xaPW2HK7Ffzunyv4HTxzCxn2Wg7f31DYrM3Rv7T1rYhbiQj4PISLaWtkxWv6U9zPAzuf7YcQL1ZPR5vzqPqCH6HooPePuJpTCgX8nMpJCGwVLsntob1Wp0QI+3TmCWOXtSQMOK373GRreYwhHStsTCrb2VVS7S03Uk7rwVePtVkD90RsDAMjYxTJmAOTXy9EFqO8o6HCYt/gURr73TH9oK0LfUTpy30w73yhgwzCxIdiq9DiGTFS6puDp6RJERLycLv3bN/siSEzF6+VYzvUwACR5RRk1LHmuVf21PmSqDPyY85vLrGH1rle01FFUVgMAOXKSx8UceTc0ulc70McSTbu5LcbKJrVlbiGt95LJutXWmZln3s0awQJq6cwjmNp/jWnOPfW6Ctb1p6iSkNRfAY1z7A0uz6JqJ2/nbrGk+/Uf8zuibNCPEwPg0OcwflROgd5beYIt036kfTaz1X97T/eds6OKjuTOw/n+DY3PzYLDS3ZT9YKHqdkaO1Gy3d/V6zaAR7/YiuLP4L7Y5uzzvBEmk3tg43pHNqz8OwVLcTdFqirk+4cgB3Bk/y4MO+ECu9wg5/YfR04xK3vhSNUMcXhez10VM9obPk0Sb/qj05vGuoMuuikZiR4wHP2wheLBy29cBYYHHIVbACPsDOwVxVR5YkVF0l7Lq/Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(186003)(4326008)(53546011)(9746002)(9786002)(8936002)(5660300002)(7416002)(2906002)(1076003)(86362001)(316002)(426003)(66946007)(508600001)(66556008)(36756003)(38100700002)(8676002)(54906003)(33656002)(66476007)(6916009)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FVBAawbafdrTgPPNeLQaHmvRur+fodz97CgUQIdiETaArX0TfAsr05jnU40?=
 =?us-ascii?Q?OgtRkifU+Y60qpLPEWE1Og6dtMDUO20aaCF3PrrZZ2Sd2i2NnLXxXaDJxvua?=
 =?us-ascii?Q?Ha4ZTTnpDbIQlG1C3eDJFItkJ2LDsNsLyoYK5k52FJVoHjOJxOnagcfDJU9N?=
 =?us-ascii?Q?GGJ0ynQ3mQ3hjEMhksPnzdHkdnQEQFy/46BgmzKmwOUQIvfjgj8aJWUBtFbh?=
 =?us-ascii?Q?Gd3NM9ecEmf12KHcc89Kjpt9iR2sma4aVQF+V9gaeMeR4eE1tbI03UgCjqTv?=
 =?us-ascii?Q?sQxhStuclQkpC8xwuWHRqs7ZwwVUySRtsUmWV/dfEMO9tfkBklH3cmq7gWVb?=
 =?us-ascii?Q?cO4R4LV7Lx5i8693tX9gGog+APPmUOTqEaUIhv3GGnN5HcigttEYQ+ztb8My?=
 =?us-ascii?Q?4MRNI81TllTvs9gXdv7anwEun/cUKDqwSkf1gsv4zBYCoYtf8DDDBGfoSLq0?=
 =?us-ascii?Q?E+0g9V+DtNldoxZ5U/vI9ccQ3x8tgNW1xIJYHI3wp59DvAAm5NqaMhYW4lBb?=
 =?us-ascii?Q?3m0h9GAPkFJB2+daWf0aqt7h1Xc+nX4tOv9aJwsMo7R3Xjg+HzvT5IX8pQ2p?=
 =?us-ascii?Q?WIqc9PvUO6eZC2X9Vwllqi7nIIKeqL3e9RIKbwzDOgVC28CZlEA8qZRuHz+n?=
 =?us-ascii?Q?YIrTZHEvmIQXcbH7i5Hg6mtzxoyT7fa+3NvGqfO8/0+j48GA6v01pjvkURf3?=
 =?us-ascii?Q?UCn8SReDiNABR2f/fMsBebYmZQNfL6WEHESe6jFXiwrVPg5IJm7z7n9/TI87?=
 =?us-ascii?Q?dAz6v8PyUbaw+dh5pzr7ZI3R47aLqNrhJYkT0MQN0yEQtpu5v3z+BQeOE75e?=
 =?us-ascii?Q?KTuk+NUDiq1TncRO98d7EGntx7j7zUmNBJ8ZuKTrE9OTMKvjsvGhsetJ1FE1?=
 =?us-ascii?Q?TlpH7yMDqnVvsoqYst13P8buiMhLMa76SSCievLguj2cftDw2/l5fj+XscXz?=
 =?us-ascii?Q?AdADUA2jeJ4S+NfJdZmzCzs4d9zDRJyPGyOmaBQwFKkQkeNqrKikU4HUZ5nE?=
 =?us-ascii?Q?U0/rKVQ5sfKM6TviJ7KhbpBGiZmczJtFtXjUjQEv+BeZWMnYn3pUv075+6El?=
 =?us-ascii?Q?eFpgd+fU5F+/dfTEGkYorA3gOX2QFMKQkQwQEKdt12osXT90X0qd/nLtW/zM?=
 =?us-ascii?Q?nXTF7EUTbMWD4Eswbt9fSCGW/12Ll43LYqXeWGcf8NoiHTumLaGLyuJDrJ8U?=
 =?us-ascii?Q?LRPumHHBDwEDfsEyRQhQjMSN2P4FCUEQOz2aqjQkWGJuHj682XufKaAoWX8p?=
 =?us-ascii?Q?9MxKmpdgs7YpdyzQDCyOrkPRmmh8tEwDH1n1bE2IBhdTXUHwpgwA5gifTHOW?=
 =?us-ascii?Q?hJlghmPNdAWJC+TTFiT3PlPK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c03fc0-6945-4779-4134-08d983a28f6d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 23:40:46.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUepHwuqxDIVd5m3mdVzNhDUfU10bf5g7KEhJA7rtpd86VMv0AHP126doqY+ThIv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 05:00:43PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2021-09-29 4:46 p.m., Jason Gunthorpe wrote:
> > On Wed, Sep 29, 2021 at 03:30:42PM -0600, Logan Gunthorpe wrote:
> >> On 2021-09-28 4:05 p.m., Jason Gunthorpe wrote:
> >> No, that's not a correct reading of the code. Every time there is a new
> >> pagemap, this code calculates the mapping type and bus offset. If a page
> >> comes along with a different page map,f it recalculates. This just
> >> reduces the overhead so that the calculation is done only every time a
> >> page with a different pgmap comes along and not doing it for every
> >> single page.
> > 
> > Each 'struct scatterlist *sg' refers to a range of contiguous pfns
> > starting at page_to_pfn(sg_page()) and going for approx sg->length/PAGE_SIZE
> > pfns long.
> > 
> 
> Ugh, right. A bit contrived for consecutive pages to have different
> pgmaps and still be next to each other in a DMA transaction. But I guess
> it is technically possible and should be protected against.

I worry it is something a hostile userspace could cookup using mmap
and cause some kind of kernel integrity problem with.

> > @@ -470,7 +470,8 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
> >  
> >                 /* Merge contiguous pages into the last SG */
> >                 prv_len = sgt_append->prv->length;
> > -               while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > +               while (n_pages && page_to_pfn(pages[0]) == paddr &&
> > +                      sg_page(sgt_append->prv)->pgmap == pages[0]->pgmap) {
> 
> I don't think it's correct to use pgmap without first checking if it is
> a zone device page. But your point is taken. I'll try to address this.

Yes

Jason
