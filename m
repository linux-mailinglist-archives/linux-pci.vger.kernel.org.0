Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB255EA86
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiF1Q7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 12:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiF1Q7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 12:59:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9693EC0;
        Tue, 28 Jun 2022 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656435539; x=1687971539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KourgPet7es5Jm2jxp5d3VhP1vL/qRXjRi9KWZ65knk=;
  b=bA+0rWohQE6ADwb1+MBZkYwmyuYV2R4/eLKv1hL6M7sWS9csR5uUGePG
   6j5y9CqpIfhN8MPfEG2fAi3BlSUimjHTXxC/xMyk3Mf7ZMz9QPi8v89vC
   7kqOJIdk7XOuXigRfH6Qyygxcd49E/qWRuLBwYDnICrj0BBdMJxO0tY2Q
   mMfyjiqEwgIIBtyGDgq1Xmr9lzu3YZVOWPGQ4kR6K/XsHzY4HrE4Trmpc
   5tfx4wcukmi4bwoazqD3DQgwi9507n+lMow4nEMUn2E3RJN1Pw9+wHPW/
   y+zyj8m/DpvPWMW3ak0pQXKDuuo8aTyvjRZfw+0iQrhLEPsAkRrvsAQyq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343485034"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="343485034"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:58:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="587934833"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2022 09:58:49 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 09:58:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 09:58:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 09:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXkbVy0bePPMF5tKL/eO9pnLTEnZW0m6NiYXpgbze9+ShuwFXrQWsIIkE5sAvAoTu4ApcQ2wneAFEaOfIsCPayHlolYNXcCFR29uwDSjNK+VTnPKP9Ypr8V0q/iZD5cnKP+lbalyGHDmrAwocEg9f/Y1aRS5x9IoV7tZnm64uhQcDDyaa393CaZMux082e0XaP/hlXCiRgG7lR+y1eLXfSB50VbwT63gMN08Qv32HmZ6piGleDIsSjP3U73LThKH2C2j0Z0Wj8Lmk09zgD21GXZGNDiFSmZgqNcn1R5hNMLvtGsHiQwNUklzVSrxo7VO+jzEVNbHAQlv8kCPCgL19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Uy0iwdwqeVEcTTrpDLioU955NYy9bxMphYBC1JgXCY=;
 b=F++/n0DcwMADpDf27yBerzunxDpdZwxzMMD6HKKMVxacPdyJefIrVOSx4N3tQWmW1Z7laOjCQ8n+Dfy/zBmptcIc2lnWKXCVzV8+NHcncjTuFkkc6WCp3qzwFFn2RmCKnOZxEp/nNLW4SkaYf0d+Ei5CaRiCIlaO/0a5arXUL5CLZH8fr8ohOkG8yXI91xHnKnhVNUUMeS7Tx5zwU9QhISwKPVQCrsFfx9RmnDbkg1JKvreFYYjQ5VvQi+FLJfYjALNTHtBP2nmmKehfu6OJSbCpQ3tLdqEc2xwhcdwgVFQc53eTDMi5UzamTZkaV1VwonblV+dOg5O9Y2sTfYkZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BL0PR11MB3444.namprd11.prod.outlook.com (2603:10b6:208:6f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Tue, 28 Jun 2022 16:58:46 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 16:58:46 +0000
Date:   Tue, 28 Jun 2022 09:58:39 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <YrszP+S3XLpmZL3n@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-4-ira.weiny@intel.com>
 <20220628153848.00007818@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628153848.00007818@Huawei.com>
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 984f5437-a999-4458-6d2d-08da59277724
X-MS-TrafficTypeDiagnostic: BL0PR11MB3444:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6TS9eAQLQk6S96fEhTGYvl41KNxUbY3DLltdkcXwEYUqQscsJlzrST2ym+u9zmev5soeDx8XoLjPSApDpXMeA1vaqvml6G4Hz4uyYUN9Mg1y/Yxp5xgvpX9hploq0l0Xl/+hCaDD7+P5M+wCU6QtNn9Fhz08spx/Owsyy9oFiaijbo8QXh0ZYPlxPqFWIm3K/YztQCoW5Hqe8jJbFs4akmLhHdQ17DkFRyty+lanBDAa5aToGzTr8iL7w6kO1pcMDc9l2jQdcIFpnEXXhEbSXst1yY8abqgkXUDNR6NGhoCq+Jic+J9sOAjT7YOhooQMRceXGJxEILiqHNPGyfy5X5i3cN7exbl1exPLF/7rxAakn14oUrk6yvwSvFkuNSHSzXAzlBRspEhGwrxSwZfSDbsRid7JSRuyEZVN8deMhlVbBWqGBxtG6+SeDlmCHJ3ED+AwniKLviMQgSHsqXJrSGr87WtJq4OfmnZhgagRLl/pMqZahQiuBTt8FSB3+0sbq3vMNcJy8z6RIUKOg3qxmWGVjLix9ef1TvfYW6OkgwkiHrdVrXLdnGiAf6NxG5S0bHwB0tg+t5jtinCt4Jus8qvS62/j/DUNf337Uv0AELlErGPxMQG1ie9RL5B5xD6ye1O21CwBf1fDDvHXbzU7+L4HvD5IMtwsrDgqP3ZFmkUK528XzMGD37kbzVw4/ctHsn3iHOePTYFRGh1ILw0FUE6aLv4Xrxq0ySz156tfS9TBjCAtshrSnmijS/H2K5uSUtIUDxGxlso6mjLTsPCQM6yMc9mHwMswL+L0gMRHS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(83380400001)(6666004)(15650500001)(6486002)(66946007)(186003)(5660300002)(316002)(478600001)(6916009)(33716001)(66476007)(86362001)(38100700002)(9686003)(54906003)(44832011)(66556008)(2906002)(8936002)(41300700001)(6512007)(82960400001)(4326008)(8676002)(6506007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oLJqZRffZsSz4R4DM7D5ADl3InZUZKebp2IR/+fhJQtqARKDwivG8vNIxqGV?=
 =?us-ascii?Q?ZhyKEyWd+dCHhfXBKoPp08dbeCdc5UAZvWwJcVtxG/5niHKXlCSwwxcuLKjx?=
 =?us-ascii?Q?uuwZ8VDjmg5Hu3Bz23eXb3oZ8Ta2DSAjGZ9VJ5f7E1KoY0FCMIADLAGn2Owp?=
 =?us-ascii?Q?PuI0YNp5sW6pvUS5VEQ+yufV9MCZe0KONSZmaRaHpr513SQ1mWyxeBHnXwjk?=
 =?us-ascii?Q?ITMQ6CGL6v/LHX32iIODNxN9RQEPUA+9Ni94HJcRNeQoZPBQtpB+0Y6Sj5O1?=
 =?us-ascii?Q?PM4UjG5gJ1Vty1Iej8DCvEUzXiNv8UltHt/ohzhPNGmJ0KL6Y+UFYywHp3e/?=
 =?us-ascii?Q?NCTXGvai5TbTG7cWu6p9ogcqWcyF4TQt+6+DrZTbZ8ZyhaPQJE5sYEWs35Ti?=
 =?us-ascii?Q?/VUX2P/mZmmcqkYRRLhrx5YEvwiKRvDByg2z4eYWd+01NI9mk94Ijdguwi4O?=
 =?us-ascii?Q?aGRWiAWjPOqY7LW6nSshf368TD+c0QdPaJUsIsqgx8KTzxD5SlQZzHMx+YhI?=
 =?us-ascii?Q?4YX3VOwN1fpnFpkaV9mXqmKFezFoX3gm5BiO0otAOt/PSw+qUeTZRBc8i/IU?=
 =?us-ascii?Q?JC9umX2/lGpuORhUjECxAt6PvwuKhvH0k2LbeOOBIGky+pIpb5l3jrEqdczU?=
 =?us-ascii?Q?6uIdiMnGcu0kf0U6jdxOa0dbmjR/kEKBjO3z5Ce2ehSUhVvNoFm/Gt9ZFVaj?=
 =?us-ascii?Q?9rA0eeDCymfNs6M7JWRIMheWC9c8sTUbqutJXovMporv66Ep/nypnTNh/z+4?=
 =?us-ascii?Q?TXpHDElm5gGM9n5lzP2aL3EWJdn4D8p5O66ur8Y2bl5fTSvEpdF7CrHqSnR2?=
 =?us-ascii?Q?/RdCVcuK0XB1kb3G2w9Ow5GHg6EintvJN9KUvjhyB6h2XMyAqEehxzDHOnOB?=
 =?us-ascii?Q?fAl3XP7qnl6Ja0YpRNHEgP/V9EMTXKnZIt7LdHqJpfA+Zx/ppL9T3qcsB7fP?=
 =?us-ascii?Q?mtG768VkvQ2wEje27AZI7Vw2B24yMbz0gf4BlbBeK4h51cGDSKBbqTTJ1Rip?=
 =?us-ascii?Q?e6bqGhLbZpJp/+P7dy6mH4mzmFBujjw+mAKfgPidpCg30VQrOmvLnwADn8Pf?=
 =?us-ascii?Q?YXJzccGi44FHi8mIjqKi9bcWS7qnU2wjOlm1AMYLqhrHh2kIzpbs0dlaKl6c?=
 =?us-ascii?Q?JXNgLAxLitafMrYXsHTzRgodAjv7mBuWFmxXAUSN/CBSdlMBybcDgK5NSUk9?=
 =?us-ascii?Q?ATqnMTyk43cNa8mgnELowrD181Ba17TRs2LVuXkrTzqGk6CoYQWwI4nPQ/fi?=
 =?us-ascii?Q?4G1AosnK40mIPiOu8rHgDV/4KWXIRFDivWeqdUiJeYFOrvl0/Yjc8o26ix5c?=
 =?us-ascii?Q?4DX6BhcNAVPLqv9YUQiu2RUmMLERY30WRxED7/6vY7zCB1YLcWSK1U7lOG/E?=
 =?us-ascii?Q?CcGYTSjWAd2tX1lIHyMRrr1seqBoyRs3ebqN78kEBnO9zoe9iqjE6eRC266k?=
 =?us-ascii?Q?W88ZxJOx2Oee7oFVkRFkjUi8KOqtKS5FLYzkYYubTQ68rEQw+JC6TP+wGVUj?=
 =?us-ascii?Q?pZK+ZLVAfmOkkfTrTJINaMsOps26tM42Mz5AwX7cTEnX5IhSsPO18r6aHV7K?=
 =?us-ascii?Q?3tg5h1Glmkh90fIqtUGGUma4i3KFX0MQthDT0GH/b1jO8ezmvyH0mEBymEAn?=
 =?us-ascii?Q?HxZUnJkYV6WOBOq+QrLQO9tiPTiqtiLdzY5sCitMVdFK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 984f5437-a999-4458-6d2d-08da59277724
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 16:58:46.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/MwO6me5y2Ntkg5eDA1BtF0aQ2McabF4ht6Q8VcFT3pdW2vcv6qEZelasrqxDEOIFielKH75VzoMMvcfEe0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3444
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:38:48PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Jun 2022 21:15:21 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> > mailbox with standard protocol discovery.  Each mailbox is accessed
> > through a DOE Extended Capability.
> > 
> > Each DOE mailbox must support the DOE discovery protocol in addition to
> > any number of additional protocols.
> > 
> > Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> > defined config space offset.  Functionality includes iterating,
> > creating, query of supported protocol, and task submission.  Destruction
> > of the mailboxes is device managed.
> > 
> > If interrupts are desired, the interrupt number can be queried and
> > passed to the create function.  Passing a negative value disables
> > interrupts for that mailbox.  It is the caller's responsibility to ensure
> > enough interrupt vectors are allocated.
> > 
> > Cc: "Li, Ming" <ming4.li@intel.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> +static void *pci_doe_xa_entry(u16 vid, u8 prot)
> +{
> +	return (void *)(((unsigned long)vid << 16) | prot);
> +}
> ...
> 
> > +static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> > +{
> > +	u8 index = 0;
> > +	u8 xa_idx = 0;
> > +
> > +	do {
> > +		int rc;
> > +		u16 vid;
> > +		u8 prot;
> > +
> > +		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
> > +		if (rc)
> > +			return rc;
> > +
> > +		pci_dbg(doe_mb->pdev,
> > +			"[%x] Found protocol %d vid: %x prot: %x\n",
> > +			doe_mb->cap_offset, xa_idx, vid, prot);
> > +
> > +		rc = xa_insert(&doe_mb->prots, xa_idx++,
> > +			       pci_doe_xa_entry(vid, prot), GFP_KERNEL);
> 
> I'm not that familiar with xarray, but the docs suggest that you have
> to use xa_mk_value() to store an integer directly into it.

Indeed I missed that.  Thanks.
Ira

> 
> > +		if (rc)
> > +			return -ENOMEM;
> > +	} while (index);
> > +
> > +	return 0;
> > +}
> > +
