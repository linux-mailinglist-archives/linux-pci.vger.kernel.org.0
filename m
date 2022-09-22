Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F775E6788
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 17:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiIVPt7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIVPtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 11:49:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3435823BF2;
        Thu, 22 Sep 2022 08:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqfClBldEaxJjWJz3tmu/lmBVrfAEB9yGriuGs8TNeHQJ9U4c/gzYIHBZLIMsxLZEVppmN/hf+IXo/CodBK026Mi3lDaSVXvzGpdOEJGY/RtDmNidA7EJE4ihRBv/aglTw8l8CL+U/myLmnB9p0G9BsrXIHJ0jFXSHms6JMcwN0NtK37B2BCFTkc9OnxNHxWZps92ApbCukbvwGe0jjih5qOaxaqd0AW/kggILvCNF3JXf7ojoRjlCh/hql9QPsn+zs6Om+Vfv0iibNR0ZoPoanUGoDHbZlByQ72nZwTjuemXCpz1Sqp04JO+HhChhDwPLQTITp1qeBmyEVIp2Vv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln//GF6mNv6fmzmrhUGsU5aFSG0J+eZ+cEGyOTws/xU=;
 b=kg6ysA5skVqajPET+pa+z7zDz+U+DczoBWjppsJl5NTCsqb4pX6Er+9hFp6WABxIgq8Gb62h0AwMvK/99bYWe7VpFJik+MDzAGW4/epCXgYU0tgle1cwfZsodjCpKT4/oG19VJo9LJBL+XMj1veymWKKlpRJaIclygP3W0hF64/JloLoAJBMimciVB8z6JTs6aHNYAhnUPhIZjkuDUhUm39QiQe6yR4jdFT3Ta7zoLddkTAALMynZnEs26PNDbJpkvn0OiNhldI3PJdo5m2EC44H77QnwRpAPDwIT+Vlvj/R7s8ZCKSOGDYj770fhgbCZvcCZ1bngbYqqO5u40gwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln//GF6mNv6fmzmrhUGsU5aFSG0J+eZ+cEGyOTws/xU=;
 b=MB9JCnWfJLZV4OLk0Fdh8CzBF3YATE+To5O4ljzCpsTJYR3tKenPOHlP3TPd8NzN0Z04Nfdh+lsSi9GaVS2DuLQGUvzm76Q50SZWkKuNhOmvEwhoqhM5utjXQoxdt7Rd3JKnTqrYLBp2IhlDlX4uGpu1avP/PO+toMmefnQUUWchl8qb/uDoKFBlq7EJ4OrRKmMgd18TfJbLlgXu0TTFZrX4ziMRBFZNXNTQJ0XP1DDJuJx9MBsB44EgQL+LSaR/gF7ERVSe99zSEldRCf9mZQdJFf8mOEOPmwVZWdBW+sGzPsLRwTTn2H1bUWl+6b8uRtB/XlKgobw11Xk7Dnh2dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 22 Sep
 2022 15:49:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:49:44 +0000
Date:   Thu, 22 Sep 2022 12:49:43 -0300
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v13 05/13] iommu: Add attach/detach_dev_pasid iommu
 interfaces
Message-ID: <YyyEF7+SZtj8vUtQ@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906124458.46461-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: b672dd61-7d94-4d9c-69b3-08da9cb211e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8fzFhxRcILnd8pCUV9il4s9vw1v7al4/JHIf7S0f6yQWgZaY9N/qbfdksMgVpNFMXlJHUc+aw9mryCoNytUO1Ez1+ru4JDvcoUDooBKfFVfY7tpoE6908YgjtSO0bP6fdomvYc7M+Aoy02M6wamKQ25i9oz4ps2bDwzkmIYH7f7LTdDI8yyxN9FIus0ZBq5Y9c0S6d3wgh8OFDAdGUrhS9QyNw7Z0RNCimf6qP+vhd+rk3+zFoDPeQTe6yTQx9RvDETeLVBe1vqtEV9VfI/yJt/J1vCxDgWrA6rxmjjBI6aO653gfM0nzc36x7Vhe54W3eHmu/k6+aCiUkhFc+e9g/69Pn5jZiQI8BcS95DRqPd2Ts4KO71DdqLIERfHxzhV/zCMSgMenAbPfwQDhURNggoVfu4Qp1SDa+hcNd505niCdFJOvu9m/7mcEKre8nJpT1cWUOJpc3MpXrHwP9nn19viDEEzJz9FEaldPbiNvqYzYvbsy+ootviJOPBo02+YtwC+6xjr3LHaA1PdZTlHgY7M8dctVYNZB1tD3noIUDrqIhOKw7XPXQudBGXBbmfgHUvu2UiwPkW4NLkdKurG7kxDW0qF9yOqIw2fYhFliLAMFMJdTjiQRXT8+ssCIly9wnMybifdrYTjEPs5kJot4l3OJM//kuTNYSbT3F+U7FRXLydto0ZDHW07jzcPLcwHHALSF5W5YCQTrC0qg8UJkYRqAQ4BMNzeKAm4TzI+SRAKdxcFOubEsBIfgD6uFf/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(8936002)(2906002)(7416002)(5660300002)(86362001)(36756003)(316002)(66946007)(54906003)(6916009)(66476007)(66556008)(6486002)(83380400001)(4326008)(26005)(8676002)(6506007)(41300700001)(6512007)(478600001)(2616005)(38100700002)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0qNN22+FxwPIhw6orYFYTaLoZEOxZ4wKV9oOWobNoCpBs6ndulsBq6r8Q08b?=
 =?us-ascii?Q?cv3w0q4IXZVLomObUDFxrEiDQ2k/OMmymMO8ZNVvRiBHyvWzm4YOCx14vst/?=
 =?us-ascii?Q?iIJFFlXK+04+O9tA7fcLrSGFRopp6yeisseqZt56M9KFOForbs+Wmbp6P/A4?=
 =?us-ascii?Q?3Vejdas2AZCwDNBHRJxL7dkx9Bm5AfYmBnzltQmOZCSjXAYAoTvwgn2YSBKa?=
 =?us-ascii?Q?tlPqq31iIBljyD9jTzD9LkoKr7OIgxVhVoErhgEmJDKDt5SJZjM+thutzyUw?=
 =?us-ascii?Q?WSUAbqSDkkAyAb/GL56nSBUhAxwPJ8eyTvZI+GRwN9tuUsFYYCw1JM8OKBSW?=
 =?us-ascii?Q?xx0tpcEwvQydbO6NYnVohm/dX2Zu+KVNtZpUi34I/+EM0voG962ZPKUtSIB+?=
 =?us-ascii?Q?W50hoXmjsCV7EnooqUaJXqLnsloIU4JUi66jmuKoWlhF5qmg6NnWn929Cv++?=
 =?us-ascii?Q?8G/iG5Zv5rjFKd2XW60YSQQUySllEB6pQjoVfkzx9nYyrMHdHvWPx18Xreov?=
 =?us-ascii?Q?VY5+1VAoEQHnavj1ymB8QORzebhK6Sn14TLBx/AjSvBRkcC1zgB6lHhNMNOm?=
 =?us-ascii?Q?WLzlnB5eGJxXFksLLraxB4T7DVt3P3laM2TFhNSGLroxaVxToPljyb8FbePr?=
 =?us-ascii?Q?a22S1W0dWTer1HVlGZ6JZ6FjePcerh5Ine0x4sw+0wa24Wo9yjeP2pRF126q?=
 =?us-ascii?Q?MUGvYxMQscn7PSAH0XDA18sVIvpOK20Lm7sEDeByhWTmH4MWbUO/gAM6Go6/?=
 =?us-ascii?Q?PxpS4mRnvtvlWXJR+YZny9Ehs59riuBSUM/dUiApF3gMpi/2kpdno1Ec2zbI?=
 =?us-ascii?Q?jwtxjSXRmXO8fL1RVK/XaSTSl3iub/y63QxeC7K0elGbwxHviU/8P19zvi3g?=
 =?us-ascii?Q?QwzcqnHEtZrG8ulW63WQI+Cs8cBjV+A1J8up0JNWfq76av8YaJ8zGAUAfOdr?=
 =?us-ascii?Q?S9nsejbF6Jak9lrZ+mhbETxq27WlgMT1TjIL5Ew99+6JPAj9Q3gk/QpHUfv7?=
 =?us-ascii?Q?7y4mvdW6g5Mts32oUJirBKcV4Oms3XFeqBKpuOWPVT2/3/I4q8Od3EfzO4bJ?=
 =?us-ascii?Q?d/ABvXPVLXwB3Ny/fKnmAQ+uNGsWUV8cu6kF4lndIMjVPTxrpNhhPRcCusmY?=
 =?us-ascii?Q?kEy6IFekUdzDm/WeBRE1SYKR+C2a5K8m7Jrq3c+Q/R3c0oPCCc3QBpHOOjd+?=
 =?us-ascii?Q?4eDAHAY2XXs+GsmYXi18jl81XGl5sghc8FTmE8a62/nZckki8UYp+XbFXmJE?=
 =?us-ascii?Q?gXEAKjX5cj5JssTQm8dj+kQX38LsGzpXU/ZK7aDRw8Y3OKxjM0OG9nftooyc?=
 =?us-ascii?Q?Wom5Ugw6uW7YK3QuAeKXkYRf1MS36iQ95We0KV8IGu4s4TGuEGy5A3Q0Ovsn?=
 =?us-ascii?Q?jrjTS9f3cHcCix2x28/ZhmO6SuJFAjOBFoLjL540hlpWA3EY59iiVJE4Jslx?=
 =?us-ascii?Q?Ymy5uL/0HjuRdIgRQ/PoLqjitOk7OZRNWkq5QyYYHkwQPJp/P/EVNHENZclW?=
 =?us-ascii?Q?RVpFLIW2wjPOykEJlDokgTt6tK042SWPj/lE1MsCGfLTCg4i9ZN5mPrlCh1h?=
 =?us-ascii?Q?wtgTwWvtnoajqCmglnotfv+rg2Z6jOreaNyW5m1N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b672dd61-7d94-4d9c-69b3-08da9cb211e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:49:44.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8IwE3lXfhkCSO3K5Klz2I1iQJi9sv4fZilDUJuyT1xXCRbsFSLhsJFYa6W+mhHk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 08:44:50PM +0800, Lu Baolu wrote:
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
> 
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
> 
> This adds the set_dev_pasid domain ops for setting the domain onto a
> PASID of a device and remove_dev_pasid iommu ops for removing any setup
> on a PASID of device. This also adds interfaces for device drivers to
> attach/detach/retrieve a domain for a PASID of a device.
> 
> If multiple devices share a single group, it's fine as long the fabric
> always routes every TLP marked with a PASID to the host bridge and only
> the host bridge. For example, ACS achieves this universally and has been
> checked when pci_enable_pasid() is called. As we can't reliably tell the
> source apart in a group, all the devices in a group have to be considered
> as the same source, and mapped to the same PASID table.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/iommu.h |  32 +++++++++++
>  drivers/iommu/iommu.c | 130 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 162 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
