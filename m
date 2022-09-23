Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFD15E7A81
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiIWMWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 08:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiIWMVY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 08:21:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24EEA5AC;
        Fri, 23 Sep 2022 05:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDI20ty2bL5bZSz+/oLTFoXg68p2ej39s9Wls2qAOHSeTerhx6nqSexn8djEszj7tWPgrl0I4TOzB4zl5sgpIOBC2rSUY5PP26gSyOk8ry2kD/fecegRz38EnwcnHuUt4gRGfodI6vOO6ZigY7HMFW/yghoJZQr6h2mP2Ih4Au1n9ReyDwL9D6c8svOOs17A2r8mBQgZ+jZSooCoFqeNerF5/YVh4EuqdY7sVQTYv38q2qU+/rYqbjHKQOGU3X0x/bXabtgB37bE7u/9w1c6kYBqqg6/kdv3tJDpHuXVck5wft6klPmEwIjmQ7ysBnJXupeJ3Tkvw8LM+ubHkaztAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b321ej90z0Cs/uBEx8IVeWcDA3TsyMOO5N4PeuYJz6g=;
 b=jzt5EoM5etI+uO01cgY0EcXwt+lVJYh4fWM9Okamzjev2ltEca3e/NW/9VS3r2MQtL4K9XzNnY8n8uX5R/G+dnHJTBTIxrL+oP3a6yK+Cl3tDc+5AuBsuYpshzmhNCHUHcHdJ7HgS5swhystOz+soYb2qK/tJQQM2x+L8uBe/YU9cVNHzXUomvbMviVHMZrvolZaTWMZlVfnqPdOcGdpToKWHAd/pksfqb2/jlK+YtaKCM/CiAHtUUA3sis6pIX9m4nlt4pTbLQF2UYtJLD5vC4c3hT/zSDHYRFbdHUwZ9zrHKKj82aEvNnYWgMllQqGSxbBxnjHEXZ5vUdfjJkLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b321ej90z0Cs/uBEx8IVeWcDA3TsyMOO5N4PeuYJz6g=;
 b=scLIhMd2ANVzXAQEI7ZvLDm8/5QtDPK18ri7m+5NtTk5HAU0/kMA+FrNqVjrqM0yQie7WHYSqpWI0IjbNVyhuaNGLeTSMxGaSZLwT/qOuqVNj951WBSvCqCl499QXJEu4M1XSOzpSHyRzoufz16CzKUIePSWKC2nwBw6yi/NBoBXXl7vLzpBvbfaVnrr+dBQWMrFwBVbfBZPbjI+aooBhUWD1+gDCEb/pr7IHnR188QVt0sauJIfQhV5jd2ZnpduRubWBAxadA2okLxurSqxCmn17ZS7q47nSGHDh0Mima1ViruMVqGpqwzxoO2tRQkqrWPJsTRhhNWrWfBINj6CCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 12:15:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 12:15:44 +0000
Date:   Fri, 23 Sep 2022 09:15:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 07/13] iommu/vt-d: Add SVA domain support
Message-ID: <Yy2jbsaXuoxgR+fj@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-8-baolu.lu@linux.intel.com>
 <YyyECCbmfsaDpDgJ@nvidia.com>
 <075278e0-77ce-2361-8ded-6cd6bb20216f@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075278e0-77ce-2361-8ded-6cd6bb20216f@linux.intel.com>
X-ClientProxiedBy: MN2PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:208:238::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b171f8c-66da-4b2d-5f82-08da9d5d5682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxArKbphZnmFvS6PpFQPNH0gBSVsH4q/DRRjVdQ0qDH5e7oNWgK//c+9taXcMJQIQiv/zKlHUeIz1CD+oqQnH54WkelADZYwfsp5xjtRv2W8uYbhYpFp64EtpIHytchJPWkR8f/LvUEhAFDSRUzpWvhMxeeoQab0B/TdwDFfruoWH2X6wCzp2o/6tWXmHBjupWBU5qEiiXzSM0NkfCfflX7nTDhxju0Nr7QbLh01TZAGUWDS1JJePrbkGpHmQSluZ6DwoU9/aJt1SDzInHBnI/BlLRx8et+pBhxmZj30WUGldUHUeb0UnR9n29kc6mGaUvNtGDIncTo9njRr+saAl19YdpJRSOfoecqFUG7sVwjXx3DaBBuZJ7mqEU8AmrAupSCmSE+F+iw50NB5m4kXukgDm9eXe5aLyEQAXXRHZD7VkeJ78OpkrvjRu7tE7Qpj5dD57fd7rzH2p+aKDnBHj/D897PWTeuq1ZP0ckqf6IlUhz7rxyU1MJj4hZuJbUouY9sWGI0hHwX8mzuMy4lyFzsmmkERjMo/WS6OKpXGoKzJo6xgZD3YwdRxLZiW9z8RDn9+oJkPaM7DmseOFWXFAaKsM/nDmym3hzZLMsswSWJSI37mii9tapMnM45PMJQWiDhyf7AlNUBXh44PvU3gHESNEHBeRHK8wvROvXF9sj5wdkvEuztfScMVisx9W84PQzZ/EfMA8tee4uYOlzNvxOBnRbAPp2jlC21hm55Amz9qA8n3hoxunM2xbRs7Lr7X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(4744005)(6512007)(6486002)(36756003)(316002)(66946007)(66556008)(66476007)(8676002)(6506007)(86362001)(6916009)(26005)(4326008)(8936002)(41300700001)(83380400001)(38100700002)(7416002)(5660300002)(186003)(478600001)(2906002)(54906003)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohaoaSdEftPn05VkD9XetILYtFDEvx3CL1ttxCAWSBrgcj7ONU3HM2WCxOQ1?=
 =?us-ascii?Q?0bS1U8J66lj9kKRxI5paVQZN3YanovWIrj8VBRv9kEitjbhFVeiqpldCyjTb?=
 =?us-ascii?Q?LR42/YzOatAHGlStxlhSvBiuH2dRCBnvlkMOIihiHDjWuez98Ju/Zb7WskvL?=
 =?us-ascii?Q?jDqR7DbQMgTZFhPlSba+rFIP9tSztpO8JDQOIa/2FpRRHK1L1qYUZmrCCuKU?=
 =?us-ascii?Q?oLTLq5uvRhJHrWI7NxsSbuvkouibvtzh3yoUqsStOhrpTHjmqnQE/un6sgJQ?=
 =?us-ascii?Q?s+KXCjjZ196VARq+4YQnMD+Qpt4w0YAvfYhT67HBF45UzgS312OjtlT+bEB4?=
 =?us-ascii?Q?EHYJzPQMunylEX/CgaFef2//J4bln93lDvyYoyfH5nmtURO42mOKQNWhZrgs?=
 =?us-ascii?Q?s22IUaJPDS2wN6dkNW5/uzvCOa2j4LL5Gg4Ho94grNkOCsAsEeEcJRxm7ISw?=
 =?us-ascii?Q?sHmczJXOiBq1nGK2d0jIOiII+WzFyo6t5yI27EC5M5WTlwxTtwZECULyRhx1?=
 =?us-ascii?Q?2/0EGk8AqtAnT9gYRESGlcPASYzfp7zQvrGfu5xuvA3vwoWb96mpqxawNX0L?=
 =?us-ascii?Q?4QaZLjZGqAz6oiR1Gx1pmTQDvTAkfsiDbsai2Cc3vvtdKk0Ww5vBFGt93roH?=
 =?us-ascii?Q?ortEsf8Bs3KmQ9qdEMqXk4BFAgu87As2z+GxVn3x5jAR3aGTHG9U8wCk0PRM?=
 =?us-ascii?Q?C4JemfldYQ1BybjG4DunXp11RFamIMel0w/830ngDTHO7PujMs6ZhzJzft2+?=
 =?us-ascii?Q?WmpNWAf40vHKQ5Se5PZtrnnrtr7Vj8nEgg+yoXRzmgr7k3NITzKgTqlmDRc6?=
 =?us-ascii?Q?sChzHC/qTit9FhsJPBogkf/SlYVt0gRYY7BPSy7uNFqdeqm4wdux43sAFn2l?=
 =?us-ascii?Q?N359/mH75Am+94cOQLwUbx3Vb9U2zKM7JjWn5U+u6sYluaUrCV1MmC9lni9h?=
 =?us-ascii?Q?fMwYP6MhT2maxy68MTChXuzjIbYlgcXBRROBf4VpDtlo34d0+mFGny1GCyv6?=
 =?us-ascii?Q?i+cGxFIsMGUavgQk36oFp88w0yUQUD0O3y2FhVNrKOBs1KmQv6189qirSUk1?=
 =?us-ascii?Q?6oRerXsnsY/o1dp7m6mtIK7Rxxt5H6ryBbn3eWqywsLSQaF/Fvn7TsA1zX4O?=
 =?us-ascii?Q?S/4z5rDURvimfEoHOoQj8hxlSFCdVIbARI/DG2q7z3EEfjp6ShxQFgdEFhcn?=
 =?us-ascii?Q?ScooshtMV3nXCXfna1gUDanyrTX+Vv1ogDdI2UQ3T2tlDygij/Odzu+qYENR?=
 =?us-ascii?Q?uK+AXfG6GR8IhpADbD33xRp8KTcbw1hJ4fYDkpPkDdRQsTuiGYHnKlLyvq/5?=
 =?us-ascii?Q?7Na854/yjr3Sohrik4h/9mPs9We8OGNu0E6xYPo4UtolfizBeR5y4s7WiSVA?=
 =?us-ascii?Q?bcfbFySNlsubJtiR1veZWGReouQqV5E+jVJpXqV0Z7TEIIOaXWnH0MnrxTtB?=
 =?us-ascii?Q?Kp/vR+P97aRHrDlazUB38l1gfD4yvPmTatVSzHcZhGU5iAsli0mPH7MCQr+0?=
 =?us-ascii?Q?enf0SN9TW1jJdCGFhB6su8qmRi6A3s10UvztgYR8NQojnUC1lbmgbhjuiI8M?=
 =?us-ascii?Q?xUxPgK3xeR9XoSUWgcEyXWaQefPTmU6jv/Ukb7MI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b171f8c-66da-4b2d-5f82-08da9d5d5682
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 12:15:44.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aagg+O/cPKOCT/9/B+VLWI2uYma3Eyr6dqW48BcCYlxdzJ3UiaYLhDGX/HdFTHxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 10:21:51AM +0800, Baolu Lu wrote:

> At the beginning of this project, I wanted to consolidate the mm
> notifications into the core. However, ARM SMMUv3 and Intel handle the mm
> notifications a little differently. Then I decided to do this work
> separately from the current series.

It doesn't look really different..

The SVA iommu domain needs two new ops triggered by the notifier:

 - 'stop using the mm, subsitute a blocking domain' tied to release
 - Cache invalidate a range, maybe this is just iotlb_sync_map()

And we could even think about the first as the core code literally
attaching a dummy blocking domain and releasing the SVA domain. There
is no reason we need to have every driver do this tricky bit of
lifecycle management.

Jason
