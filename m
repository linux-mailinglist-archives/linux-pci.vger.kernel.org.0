Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71A64FD36
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 01:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLRAVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Dec 2022 19:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLRAVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Dec 2022 19:21:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB55DEDB;
        Sat, 17 Dec 2022 16:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671322878; x=1702858878;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wM8slmAc7VmULF5axG01qAabBH4g78qGY5JglxE+qdg=;
  b=PHdD643XvD7AD18JNxI5iEdezn3HbKeMWvhW8pNXZSIdZ6FwmijNiNvr
   CwYNKteNR1kGMY9EcQA2ZFUfTjqo8qAAnZ9AmFbLDQD8c5utzYtl63rqm
   P/CZDuV64VgvvMG6TkPIDbBoZR8YCwPg9BoGd0trEbpQIxA1TuCvIgig4
   yScL2vJn8Cf6xw2TxuiTVllkRCzwCKZIXG+FKLj1vz1w1wyqxW6JUY85O
   p1WK5hx3ydAE6VrqLaIeqFdfZ50nwOfyUSCBCPu1hmoHs2dFjv0zcJjwT
   CJ7UzmoxPuFiHV6PA7nLixY4kiY56rHeIw9pzKqkCS6hRG26yXyeqwSli
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="317853910"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="317853910"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 16:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="652313274"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="652313274"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2022 16:21:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 16:21:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 16:21:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 16:21:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 16:21:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe8xDMoKiM3utLavjH1hhyPPpQ9M5ObLNhvnfi6MZaKmPQ0rY3mbd02vB9naXjZoBVZyjVa8mqQCvLmOc8CD4aB7lxLblSFdLMw3j/uPg4BzDWfYOEamOTckKx12DOKpkyLKYHX9zX2W3ythgZf+d+l9am6KsErkj+4JNsifSzp95IZgx2W78Xlg6pxxsUb2QIz8n/eHQt2R+BGkF6dI3Fsyx+Q3qT4J8z5MjxE4yEwhLLA8bspfuhxrAAFoWtyGByBuE4b6uRyZZETf3IuCbFGlF9huehNSNza7WKTC4Mn5FYaFZ+kKG4N22/zu02k3O7sUUAyQDkdUdd7CNj7GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2FK8yEPlu+cyrpSdeMc26/IAG1Ixp2h9rYJbb0ual8=;
 b=FfejTl/KrFoGJQMLrEUf9PAkM0k3weFYDN6rKVX5ACTxsMBBn/l5RZH2e65gkMocLRBHP986z5jAwkBSh1aylbF08PLMqXB3bWAJ+SwoTAWNb9i89gHOKB2bkzBLvdCiyJbwt/JYSAHah4VFVUVLfp1m2Kms1SJ3nxP3BSs/AeEpaPdglVj1l9bkJhBJdJ4g8tIaNWLL5zXvkCDdiDOv+FWdYtD572Mn+swQAUlwkBXXuhoqwCM6IeOZLVb2gjz2jVk6vE8K94hGUdEXV0XYjOnqWeUrFy/d16AYkFWxw+ZJjJUg+P7TZffSdHDczVHdM74OHyZKajCpiTROk/VCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB7037.namprd11.prod.outlook.com (2603:10b6:806:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sun, 18 Dec
 2022 00:21:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Sun, 18 Dec 2022
 00:21:09 +0000
Date:   Sat, 17 Dec 2022 16:21:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 2/9] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <Y55c8TB75EUbhvqj@iweiny-mobl>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-3-ira.weiny@intel.com>
 <20221216153939.00007c41@Huawei.com>
 <Y5zo+UqOmGCE4ObC@iweiny-desk3>
 <20221217163850.00000bc4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221217163850.00000bc4@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:303:84::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 889b8e67-4052-48d3-ff24-08dae08dc315
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I40nLmiTbZrBAFw6GjieQ6/yo+4oWLkhF2zBSYzsZU6IjQOuTNm/Pf2DF+WbQ3GnpeK0p+Auc1Mt3+yFoucpj8mbzkowf8d0ysx5MJUyWJ+yr1v4SbZRl2WKpwsBgCopMa6w1DkLRdMWhjR5dzmBLjJhLnWBiHVeHFALZxTPnH7RS55iAkgxrGizti6PTf9+C0QeM09X+BK6sDp00NnLC1LnEI4bAvtyzlSpW0degKr7dUhYMgq/cwtkiw6pEN4CGVdi0pHYSKmFkwN1wasnGWh/udZHmL94wKM5qqzaMtB7G84Nnot1U5J3/ibBWR64VoGZcB+R/8D04/hNl/0r25o0P5JmeF49z54bciN6s1rL/qPT2tnOgJV1K980eQ42HFqP2MB8GQxs2KoPRzE3wMBriBgVZU4gq8BVbItzKb6rmQjj6W+xKVUE4FBNyaCeeLnn1hxBGAFGg0pXnUPBmbaruRaErmhpbYh5wCtl0S2lDmJ94LZFAtRZBOY2/mptKwAeCUGM65KepcuTvKmelsLpShC1DnMQnsz+U1IsNo260vkSDLyhXvLUsNsZcXq9qOIZHJkZx020q9LREIF9hhNNZv4gVbNzdQqsBBZd/6dLlACzLCr27Vq2kB4JpBXFVk8fN+YaaSoy896GFiAd1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(66946007)(86362001)(66476007)(8676002)(66556008)(4326008)(316002)(5660300002)(8936002)(41300700001)(33716001)(6666004)(6506007)(9686003)(6512007)(26005)(186003)(83380400001)(54906003)(6916009)(38100700002)(82960400001)(6486002)(478600001)(30864003)(44832011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRAoSyDadGjgZxwJiXEEw5GFrb4U/X5sa/Vs0MrRAOGom7ZPM1zVUTeXxI1M?=
 =?us-ascii?Q?Ngoid6h/aZR+DsghE74ol2dIu7LsoY1y/OePk3EgcijjghMj/6DDM5aMyNN8?=
 =?us-ascii?Q?zPIFYp7esZBwsooiGryZc6o4L9FRmwyed4r1eI59U5OySOaruOoA5hTG8dHJ?=
 =?us-ascii?Q?1MarQlTooA4qyfbbToBCUEmv4RFnUAPSxaypqAaI7o6Dp5+iMVg8D5ybmS8d?=
 =?us-ascii?Q?PGWDXyK5j9J6WMDaU32cvF+6LcXxwgyyf3W2ofON5qI8gknyKvX/2eBYCckE?=
 =?us-ascii?Q?WoYHEqg59adGiNfwvBxWBtUmcxdeDM3Sd9+zcWzXIQZM1PZgQt5AIyWpDgN2?=
 =?us-ascii?Q?xnYb4yGU17KfF2fZ9jSYf0iVLXfYeWSLdfdeU1YrRO7av5tS45ElqNM3ue5F?=
 =?us-ascii?Q?U22isvgtsdTp1wqhIY26n9jpncOkUbZOLrb1x2bN3HH5y0OStJyF8KJy5wqd?=
 =?us-ascii?Q?ynay4ieSBOkP060jl52kS8Gd6fxwFB9MbsMUmqaF39+sdQJuoqu+en8Z2OKO?=
 =?us-ascii?Q?80WvyzkTCy+NwplgYN6HtKJXMmu83yMnDmtnrmI3sLgwEOe+KmYtvy+/5V+W?=
 =?us-ascii?Q?ih9UGhHwyaWWxI9bpKuV+W79QtTEJQnmKZ8DyvxX7SY4FW6jiygOOJvQhHEj?=
 =?us-ascii?Q?FF5F8rioodl3SFNffuowMg7wnkkn3A6t5hMhSV3HIQuKan86iS+byBRpA5FU?=
 =?us-ascii?Q?a8Wo8aj95+wW3p2ZlLCw/rGb0ol95gpkbL+4k36+l67DZWw4mxP3a5i9RTPx?=
 =?us-ascii?Q?nZRzz5vPGpmaDFUnOICWOFHTA3XMK8L7rVl1AMgeLeTd/jBsZdNWTibNcr69?=
 =?us-ascii?Q?H/lF16MRP0L7fOI+qg/iAonU4f408B+FX9dpD/0LgZKHtOVG8Yzzv3UDvWN8?=
 =?us-ascii?Q?yURMw4zBNC9GnngVJD9zvjbBK3i+x0jFkAleq7gIbsdkVGb1r3UPL/ap4V5z?=
 =?us-ascii?Q?8K37GC9e8HeaHKCoq29q5NIE258FexdAornmNmDC3A7R2vgLkz86QVTm6zH2?=
 =?us-ascii?Q?SsUNfy2z4Gbz0iT97LZjRZ03MluYr7OOqiLAwe99lJOcJ/aAFy8fMaQSDjMT?=
 =?us-ascii?Q?6eB41RfUumSJAYPGN8D5EfQH17hCzSNLk0M8o5fvBLFlBMi6zimtG1kiKRtO?=
 =?us-ascii?Q?GFyuY07+VHCy+9GnrrmB05kWGTFQJEEBaPU3FeciPFHPvympQKuQGwpmdnCj?=
 =?us-ascii?Q?NVwYJT4TPziHswPQD06WjbTymNXsREKibCnlhJyD2tD2fyjECt6Awbw4Q6Iv?=
 =?us-ascii?Q?gftYdce2Trg8k0pCP2HyQoKEX9wgFsscr1sqSm4KGZTKgYobICivvMEN9CRo?=
 =?us-ascii?Q?VGdk0Ghh3e8ZJwQVB2Znz3lNZ6FMmT07AWH74lKs1EjmmHb0YIfmO7Ixbgor?=
 =?us-ascii?Q?ACSAeDVr3wv4gyj3Q7PQU/0Ctl49TsT2ozWQFCP00th2kDIlW8GZ90LfJTiZ?=
 =?us-ascii?Q?A4z1Gf2cPl0rDyBsHWiKao9Vb/QhKQU7A2jDdx6Y7bfrG9y5ySZqL1y6BnWW?=
 =?us-ascii?Q?1qUlKtyroyflTsT0d0b4U1yuqtlMvCPOJLxzKP79UE4f5slIC2V/cX9JFjX4?=
 =?us-ascii?Q?BSWO2zJhqLSDPZWlB8y2XxgpyuZqQKnF1eiJ4f83?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 889b8e67-4052-48d3-ff24-08dae08dc315
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2022 00:21:09.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKtmwkD+AgH3roLk2vnlwBDLW0PGt/Lsfw9N7yWNGmUHY0gAQkdOORrt17D/2mEzyjWXn5SnnkoFeC8cji0JAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7037
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 17, 2022 at 04:38:50PM +0000, Jonathan Cameron wrote:
> On Fri, 16 Dec 2022 13:54:01 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Fri, Dec 16, 2022 at 03:39:39PM +0000, Jonathan Cameron wrote:
> > > On Sun, 11 Dec 2022 23:06:20 -0800
> > > ira.weiny@intel.com wrote:
> > >   
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > CXL devices have multiple event logs which can be queried for CXL event
> > > > records.  Devices are required to support the storage of at least one
> > > > event record in each event log type.
> > > > 
> > > > Devices track event log overflow by incrementing a counter and tracking
> > > > the time of the first and last overflow event seen.
> > > > 
> > > > Software queries events via the Get Event Record mailbox command; CXL
> > > > rev 3.0 section 8.2.9.2.2 and clears events via CXL rev 3.0 section
> > > > 8.2.9.2.3 Clear Event Records mailbox command.
> > > > 
> > > > If the result of negotiating CXL Error Reporting Control is OS control,
> > > > read and clear all event logs on driver load.
> > > > 
> > > > Ensure a clean slate of events by reading and clearing the events on
> > > > driver load.
> > > > 
> > > > The status register is not used because a device may continue to trigger
> > > > events and the only requirement is to empty the log at least once.  This
> > > > allows for the required transition from empty to non-empty for interrupt
> > > > generation.  Handling of interrupts is in a follow on patch.
> > > > 
> > > > The device can return up to 1MB worth of event records per query.
> > > > Allocate a shared large buffer to handle the max number of records based
> > > > on the mailbox payload size.
> > > > 
> > > > This patch traces a raw event record and leaves specific event record
> > > > type tracing to subsequent patches.  Macros are created to aid in
> > > > tracing the common CXL Event header fields.
> > > > 
> > > > Each record is cleared explicitly.  A clear all bit is specified but is
> > > > only valid when the log overflows.
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > > 
> > > A few things noticed inline.  I've tightened the QEMU code to reject the
> > > case of the input payload claims to be bigger than the mailbox size
> > > and hacked the size down to 256 bytes so it triggers the problem
> > > highlighted below.  
> > 
> > I'm not sure what you did here.
> 
> Nor am I. I think this might have been a case of chasing the undersized
> length bug in QEMU because it was the CXL 3.0 issue and misunderstanding
> one of the debug prints I got.
> 
> Friday silliness. Sorry about that!

NP but you did have me going.  I've vowed to actually understand the spec
better going forward!  :-D

> 
> However, the over sized payload communicated to the hardware is still
> a potential problem. See below.

I don't see where there is an oversized payload used either...

> 
> > 
> > >   
> > > > 
> > > > ---
> > > > Changes from V3:
> > > > 	Dan
> > > > 		Split off _OSC pcie bits
> > > > 			Use existing style for host bridge flag in that
> > > > 			patch
> > > > 		Clean up event processing loop
> > > > 		Use dev_err_ratelimited()
> > > > 		Clean up version change log
> > > > 		Delete 'EVENT LOG OVERFLOW'
> > > > 		Remove cxl_clear_event_logs()
> > > > 		Add comment for native cxl control
> > > > 		Fail driver load on event buf allocation failure
> > > > 		Comment why events are not processed without _OSC flag
> > > > ---
> > > >  drivers/cxl/core/mbox.c  | 136 +++++++++++++++++++++++++++++++++++++++
> > > >  drivers/cxl/core/trace.h | 120 ++++++++++++++++++++++++++++++++++
> > > >  drivers/cxl/cxl.h        |  12 ++++
> > > >  drivers/cxl/cxlmem.h     |  84 ++++++++++++++++++++++++
> > > >  drivers/cxl/pci.c        |  40 ++++++++++++
> > > >  5 files changed, 392 insertions(+)
> > > > 
> > > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > > index b03fba212799..9fb327370e08 100644
> > > > --- a/drivers/cxl/core/mbox.c
> > > > +++ b/drivers/cxl/core/mbox.c  
> > >   
> > > > +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> > > > +				  enum cxl_event_log_type log,
> > > > +				  struct cxl_get_event_payload *get_pl)
> > > > +{
> > > > +	struct cxl_mbox_clear_event_payload payload = {
> > > > +		.event_log = log,
> > > > +	};
> > > > +	u16 total = le16_to_cpu(get_pl->record_count);
> > > > +	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
> > > > +	size_t pl_size = sizeof(payload);

This line ensures the payload is only ever the size of the definition per the
3.0 spec.

> > > > +	struct cxl_mbox_cmd mbox_cmd;
> > > > +	u16 cnt;
> > > > +	int rc;
> > > > +	int i;
> > > > +
> > > > +	/* Payload size may limit the max handles */
> > > > +	if (pl_size > cxlds->payload_size) {
> > > > +		max_handles = CXL_CLEAR_EVENT_LIMIT_HANDLES(cxlds->payload_size);
> 
> Definition of that is more complex than it needs to be - see below.

Then this ensures it is truncated if needed.

> 
> > > > +		pl_size = cxlds->payload_size;  
> > 
> > pl_size is only the max size possible if that size was smaller than the size of
> > the record [sizeof(payload) above].
> 
> Sorry. For some reason my eyes skipped over this completely.
> So we are fine for all my comments on overflowing.  On plus side
> will now check if that happens in QEMU and return an error which we
> weren't doing before.
> 
> > 
> > > > +	}
> > > > +
> > > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > > +		.opcode = CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> > > > +		.payload_in = &payload,
> > > > +		.size_in = pl_size,  
> > > 
> > > This payload size should be whatever we need to store the records,
> > > not the max size possible.  Particularly as that size is currently
> > > bigger than the mailbox might be.  
> > 
> > But the above check and set ensures that does not happen.
> > 
> > > 
> > > It shouldn't fail (I think) simply because a later version of the spec might
> > > add more to this message and things should still work, but definitely not
> > > good practice to tell the hardware this is much longer than it actually is.  
> > 
> > I don't follow.
> > 
> > The full payload is going to be sent even if we are just clearing 1 record
> > which is inefficient but it should never overflow the hardware because it is
> > limited by the check above.
> > 
> > So why would this be a problem?
> I'm struggling to find a clear spec statement on if this allowed, so the following
> is a thought experiment. There is language in definition of the "invalid payload length"
> error code "The input payload length is not valid for the specified command", but it
> doesn't go into what counts as valid.

I think the only thing which makes sense is if the payload length is smaller
than:

	Header + nr_recs * 2

Anything up to

	header + (0xff * 2) should be fine per the 3.0 spec.

> 
> What you have looks fine because a device can't fail on the basis it's told the
> payload is longer than it expects, because you might be sending a CXL 4.0 spec
> payload that is backwards compatible with CXL 3.0 - hence the fact the sizes
> don't match up with that expected can't be considered an error.
> So far so good... However, we may have a situation not dissimilar to the
> change in record length for the set event interrupt policy payload between CXL 2.0
> and CXL 3.0. The only way the endpoint knows what version of message it got is because the
> record is 4 bytes or 5 bytes.  If we have extra stuff on the end of this record
> in future the end point can assume that it is a new version of the spec and interpret
> what is in that payload space.
> 
> Say the future structure looks like
> 
> struct cxl_mbox_clear_event_payload_future {
> 	u8 event_log;		/* enum cxl_event_log_type */
> 	u8 clear_flags;
> 	u8 nr_recs;
> 	u8 reserved[3];
> 	__le16 handle[nr_recs]; 
> 	__le16 otherdata[nr_recs];

otherdata should be ignored by a 3.0 device.

a theoretical 4.0 device should handle otherdata not being there per some flag
in the flags field I would suppose...  That would have to be determined if this
payload were extended.  Otherwise this software will fail no matter what.

Other mailbox commands do not 0 out from the command size to 1M either.

> }
> 
> Endpoint receiving your 'overly long payload' will assume all those otherdata fields
> are 0, not necessarily the same as non present.

But it is not 'overly long'.  It is only the length of the current spec.  See
above.

> For the set event interrupt policy, if we sent an overlong payload like you've done here
> with assumption of the CXL 2.0 spec we would be turning off the DCD interrupt rather
> that doing nothing (unlikely to be a problem in that particularly case as that one
> doesn't have a FW Interrupt option - but that's more luck than design).
> 
> I'm not sure why we'd have extra stuff for this payload, but it 'might' happen'.

I'll have to check but I don't think I set the payload long in that message.
It too should be sizeof(<set event int policy>)

> 
> > > 
> > 
> > > 
> > >   
> > > > +	};
> > > > +
> > > > +	/*
> > > > +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> > > > +	 * Record can return up to 0xffff records.
> > > > +	 */
> > > > +	i = 0;
> > > > +	for (cnt = 0; cnt < total; cnt++) {
> > > > +		payload.handle[i++] = get_pl->records[cnt].hdr.handle;
> > > > +		dev_dbg(cxlds->dev, "Event log '%d': Clearing %u\n",
> > > > +			log, le16_to_cpu(payload.handle[i]));
> > > > +
> > > > +		if (i == max_handles) {
> > > > +			payload.nr_recs = i;
> > > > +			rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > > > +			if (rc)
> > > > +				return rc;
> > > > +			i = 0;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	/* Clear what is left if any */
> > > > +	if (i) {
> > > > +		payload.nr_recs = i;
> > > > +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > > > +		if (rc)
> > > > +			return rc;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}  
> > > 
> > > 
> > > ...
> > >   
> > > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > > index ab138004f644..dd9aa3dd738e 100644
> > > > --- a/drivers/cxl/cxlmem.h
> > > > +++ b/drivers/cxl/cxlmem.h  
> > > 
> > > ...
> > >   
> > > > +
> > > > +/*
> > > > + * Clear Event Records input payload
> > > > + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> > > > + */
> > > > +#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
> > > > +struct cxl_mbox_clear_event_payload {
> > > > +	u8 event_log;		/* enum cxl_event_log_type */
> > > > +	u8 clear_flags;
> > > > +	u8 nr_recs;
> > > > +	u8 reserved[3];
> > > > +	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];  
> > > 
> > > Doesn't fit in the smallest possible payload buffer.
> > > It's 526 bytes long.  Payload buffer might be 256 bytes in total.
> > > (8.2.8.4.3 Mailbox capabilities)
> > > 
> > > Lazy approach, make this smaller and do more loops when clearing.
> > > If we want to optimize this later can expand it to this size.  
> > 
> > I agree but the code already checks for and adjusts this on the fly based on
> > cxlds->payload_size?
> > 
> >  +	/* Payload size may limit the max handles */
> >  +	if (pl_size > cxlds->payload_size) {
> >  +		max_handles = CXL_CLEAR_EVENT_LIMIT_HANDLES(cxlds->payload_size);
> >  +		pl_size = cxlds->payload_size;
> >  +	}
> > 
> > Why is this not ok?  [Other than being potentially inefficient.]
> > 
> > Do you have a patch to qemu which causes this?
> 
> Two issues crossing I think on my side and me thinking this one was obviously
> the problem when it wasn't.

My fault also for not at least throwing my Qemu test code out there.  I've been
busy with some things today.  I'll try and get those changes cleaned up and at
least another RFC set out ASAP.

> 
> > 
> > Ira
> > 
> > > > +} __packed;
> > > > +#define CXL_CLEAR_EVENT_LIMIT_HANDLES(payload_size)			\
> > > > +	(((payload_size) -						\
> > > > +		(sizeof(struct cxl_mbox_clear_event_payload) -		\
> > > > +		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\
> 
> Could use offsetof() to simplify this

True.  How about I submit a clean up patch to follow?  I don't think this is
broken.

Ira

> 
> > > > +		sizeof(__le16))
> > > > +  
> > > 
> > > ...
> > >   
> 
