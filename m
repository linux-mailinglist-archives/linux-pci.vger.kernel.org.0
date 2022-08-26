Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD735A2BAF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiHZPuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344657AbiHZPut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 11:50:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D2C0E6C;
        Fri, 26 Aug 2022 08:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoOkyRsTInT/TwTQXONg7FbiQmNTxjf4EQlTYrRTIlCB9hybvsCgkRY1nQWmTeweCirv4Un53QSvF8koPFNqUmouhvvEB/TxbJP63P8x23gkMjohmXkYFkgJllH1awuWeoBzIf/AKJYhjoDA3Obp0q/89ciRihMLZkRaWeZ04iJOC7iX4dYFsK78yqg8LBa2ULt8cHbW2qz1hkExS4TtlO+7+7n8r5BkIA5wES1GRfwxzPH3URxTQZee0S7eEm8PFQie1DZb4gjrCP4F0yM4Bcl5X6y+BLY9z2BfgZS0aqrMtXVyv/HBt4DuyYWUh0ItzVu1XEiDcwfqzfUiQE/24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXy3Xf6C5/mNmCNZQX6Ke7KoqUiwnNBdwQT4gnRJU+4=;
 b=ibqFBv0f6D7R1caMb3XXeJnox5z0NIbzzYGCNYnFM1KwUFlyIbTYyVlOn+T/ju3PqYDC1PhQGixOs10j2O8cxxMgXCfS6VREWInwIwlnWpoIEa3SdaADT5voJXJSX1x7IN4BY7ZXul0IgHqkSsS7eqze3jV3nKVM9x/V9NTRWJdGwf5PqPVUyIBrs52NafGG+W6E1uxDTNXeK11gnaW5Kgkvc4UTZmxBTEF/958kZgR5OrQmCh2Is9gghw6WYu3AsmIsh9jj2XePZwp+1KdddSwkR5ryqZQhwMYpWQeOYTCv3J1ufmVf35g0IcjT/OPXUwxRjdBcItU/p5FCDZ4XEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXy3Xf6C5/mNmCNZQX6Ke7KoqUiwnNBdwQT4gnRJU+4=;
 b=ejIoKQG7F5aTnUWqhNDOfLSB833FU+S/aDVOl3yPgEHeTpI76uiOdiBpEd5GwxNO2CEaRtxlRkdGD2KoaSy49JGsUE6uQnIz4qQ+qIU/9KOoqD4HwyuVXQfJ/J/7Q42mDOUJnvkiHV89jmIhI9MvRGyvjuoFfXeBKdsApVuA0MtlJayLc1F6N7gRonxpjG3ksT6X4TjLbQ0Dhz0l3I5h3tr/81Sn/DA3//S6ggvhaX31Yl5sS5Y3UeSvthcv4no6DP/KdHmMG8P8KRnVr2U8OZj2etGvL2xtwt7NaUJ7YfVpOGrQyGFH+crWpW/6Q3Z1m7/MdDQsZrbJs7/MXprLww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 15:50:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 15:50:44 +0000
Date:   Fri, 26 Aug 2022 12:50:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
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
Subject: Re: [PATCH v12 00/17] iommu: SVA and IOPF refactoring
Message-ID: <Ywjr0rolwfdiaFSC@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826121141.50743-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a3cb4ff-0d4e-4aa4-85b7-08da877abc18
X-MS-TrafficTypeDiagnostic: BY5PR12MB4887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlEJRuOViWfa5v3/lExjo7Oia/pXqmTriyvLBp/V3vGT++Zjr+vQwU8EoCt+avc1A+PBeGfFGV8L2S8hfIhUINHIq+RrMozopolDy69QpE5i7/QkIx0dVGJYt72Y6mQ8vLFQQjcvpv7ma50PmCCT3uFjDlV0OUj8aAQuMgaxT31TrmYAkzknhnl4GA+ksJtFfmx9aZSl55H2mQKhYMuaPu9HGljIuOonFLUqvh6NhZ+6LrTRLeU/0/IfzCmkvLOaASkJhUkqCWynk0UAg5/RRMKFqDb6AjiPDTugYiNAMoSsBHQQPKVrT2xzNdXH40DIJYUS9aPs6ppRyll8/avbr60NedPC0fheil2X3VKXs9UN9sZiV9VAV16C/dpZagiq2cEzTyIMCqeKVMFI5rY8cDOgx7Us7dSXg6wPSY4jUPLb8R5alRfS5CXeH/wDpwU1O7WA/73qMLF8uJ4SzYP6OQytRUbG0+dPVLiRzdIEctJMRAKotI7P73/urJIr+jJnPQslikqCMSmaaouR+KznfdwRhQVzGs+ZYrfF6SLSGXXhUd5dtNzdRNff29JJ4JYoayvKjC7+OE5hBxDctWfp8iq1Y2ydv5x5NwxT+fBtbqJ5WDgbaKpIWg0bJ0Ae9NVy3CyuxbT8dY0RVx2zVx4TLsggEjtTN6X8DscFhTSKIK7Bj2O/RYiuu5Mdvx6IpDAsmaCceuqUfF/tIzp0kqTUxhs42I/QLYgr7Vb48g78rR+o9QwVxgxl1kWFeC0A35hEMAieLoqHAzrLUq2T6bEKfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(186003)(83380400001)(2616005)(38100700002)(7416002)(8936002)(6512007)(5660300002)(66476007)(54906003)(8676002)(4326008)(66556008)(6916009)(316002)(26005)(41300700001)(6506007)(478600001)(2906002)(966005)(6486002)(66946007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9SmC6L0hk7Fg/zIPCjvOTMQ/n3eX9sZ5rDQUT1SZuf3W2fok3rHSHPLGUu9A?=
 =?us-ascii?Q?Sm6bErT44nwGTr8h/5drZSV9CQ5y4BT9R2BWNqNK068bUXDDGyjw3gQv5Yo8?=
 =?us-ascii?Q?CRwH3vHYyVSVICwSs/YETS/Y2qpjTzEzoFkCtgA2kCjAieSLdrzmjBhahudl?=
 =?us-ascii?Q?EUsVxCRh6WBkaPYiz5eTzJK3HV1P5dZfkt0V6QXFvIGshojuEMZNzgKYsy7R?=
 =?us-ascii?Q?6GRP0Y2L4a2YvwMv0qnn0TRLbRWEfvehlxMGHmV32ruTJV0epfWwMjy7kVNS?=
 =?us-ascii?Q?5BbKaP7V8T4EBHHyvOug1fYvgFyGakahCZZ2x1u4ojn9q7ecymVbKeDbtgbF?=
 =?us-ascii?Q?uutI7HAdFBGWeCPAgG5Dh9aZmuVON8palUju2Wdw0fVj6qY+Uw6LE9KBVQut?=
 =?us-ascii?Q?Vd5m8aikSqel1XMCmJPPI0W8pqyYT9t1h8m7KrF2/lZmPypv+XEGZgFMWxis?=
 =?us-ascii?Q?2efbRo279u3Slhgx1YPgOvPC82a6sDUxp5QtNHKmLvbnrM9zDy1aTCHwjYvW?=
 =?us-ascii?Q?PvjT3xFdR3h/4wwNKJBfobkFrr90OJJO5/ypNOLwFaI/ycPEGysGEDxlJwCn?=
 =?us-ascii?Q?fh5oDwaC9XhxIF7qksEmy2LhLX+1RmW0TGOxzJ0J3EgYjEh3qDkNOj+QgUDV?=
 =?us-ascii?Q?fjG0a0jXbwVBQIX0h6n6UoAakGWHeOFtBbGIkcnecQLaWDWqgjU1hlfzmQny?=
 =?us-ascii?Q?7TjHDbbh33e3qBK4GXtCfRWIrS1WFRAyQy8xC0zUMg6Gigd1o93sXQGoxpGf?=
 =?us-ascii?Q?OG266c31OzZGKYAnynHkoHyTcNy0r+daTybcBL0HWru6U177D1Oeq5Q6LOp/?=
 =?us-ascii?Q?UsVkYjCcwETVmdsoGg0S//EKXikp3ERpbzlwicW5XTUOYAADEzwS7gv39TCi?=
 =?us-ascii?Q?DEfuaeDTeJ+oNEmDFB0rmYN06VsoiRU/AaP1jt7uF3mxixJpXmym1YZ4vi/v?=
 =?us-ascii?Q?pE2ZTK1JkudqK+2iG4D3mdZfHKHl+kBqDfudYoQEeHfeUumuRyJhiHEMrMco?=
 =?us-ascii?Q?OfgBM5c4RDzWVWQoAvDCsZ+6J4K7BCKFOmDtjg8fhO4fzBlZtlb2vTPcvBX+?=
 =?us-ascii?Q?fF7rqris6G/uaiCo7Q6CFH8xayW+IlRZDvT1LIEQm5lF/ZLRzmLO7jvN5SHC?=
 =?us-ascii?Q?RvCAmQljKB3ATeJFFqJ7KVpHCb+IgNM1AZ++YzcDP0h3bxE/6VONuoJY6RPS?=
 =?us-ascii?Q?IcOVDYAN3KFNl4IMUOmd2CA4nQyru92Pq6xHcLmr7eejysM4u6ObYmL4XIIJ?=
 =?us-ascii?Q?0VxsYyE89CdJTj4nMrt7B3j8Ngvqg3okRg+Eu5A1bK9EhBpWLB83EW3TKO5K?=
 =?us-ascii?Q?OGuIvnsUAJmdlik3/IHY1OoVpvvzSwc8PxePTmvhJzCK7zj1c/WhQ3ZayOSt?=
 =?us-ascii?Q?21YBC9F1McAbWs4aDhz1Nt+HtUPIFpNLmLKLuqen8YeRfuJJEsWEqSeWsoNB?=
 =?us-ascii?Q?imZRj9Qfuo0AjAqkjX3EH2OYxko3xUDm1nDo3SP99ty+bIOXqwyCJ6Qjxi4A?=
 =?us-ascii?Q?TzIn1WtEubgZeKEKHYfNMvr3p+kBL7Eqh9FRfOp9i8HENG+xX+4LaHuA0c6X?=
 =?us-ascii?Q?5w7KOhZcFe6L5WrBdyEOmw0majtWhHWAuORSHRN+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3cb4ff-0d4e-4aa4-85b7-08da877abc18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 15:50:43.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/bTJOqcn8D+2GJYR13g/3zFjEUzQWLcJ1Htj8HRxIX6kFuL97FNBi8zopg+6Xel
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 08:11:24PM +0800, Lu Baolu wrote:
> Hi folks,
> 
> The former part of this series introduces the IOMMU interfaces to attach
> or detach an iommu domain to/from a pasid of a device, and refactors the
> exsiting IOMMU SVA implementation by assigning an SVA type of iommu
> domain to a shared virtual address and replacing sva_bind/unbind iommu
> ops with a set_dev_pasid domain ops.
> 
> The latter part changes the existing I/O page fault handling framework
> from only serving SVA to a generic one. Any driver or component could
> handle the I/O page faults for its domain in its own way by installing
> an I/O page fault handler.
> 
> This series has been functionally tested by Tony Zhu on Intel hardware
> and Zhangfei Gao on arm64 (Kunpeng920) hardware. Thanks a lot for the
> efforts. 
> 
> This series is also available on github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v12
> 
> Please review and suggest.
> 
> Best regards,
> baolu
> 
> Change log:
> v12:
>  - Add blocking domain support in both vt-d and smmuv3 drivers and make
>    the set blocking domain through its own domain ops.
>  - Add a type parameter in iommu_get_domain_for_dev_pasid() to matach
>    the interested domain type.
>  - Only enforce ACS RR & UF in pci_enable_pasid() and refine the commit
>    messages according to Bjorn's suggestions.
>  - Misc code and comment refinement.

I think this is looking pretty good, aside from some minor remarks

Jason
