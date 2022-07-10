Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40256CC7F
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 05:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGJDDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 23:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJDDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 23:03:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE49BCA0;
        Sat,  9 Jul 2022 20:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657422228; x=1688958228;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jbE6gjduVIlU7DP6BhV5aTE2qJV6n640TcixsTLT6lM=;
  b=SOOq+HMawBXCxERvLTjI/8K8BJYEqCQGN1H/GLGjsr4Jqk7iASPzJf1U
   M9mfbIPVtq96kAh2jCazg8YHDbG3xOwL0sozaF6NZz/IxGQ+NqPvnowUP
   w0w/IiVFu7y4p7K9UzmQQwfvXlm0tavzcHMZoFGz9eal22VOoeP2cMNax
   IEk5sg4W7pNUueT1vUm/Yy//9OZqv/Kw4YIbCr/4Gnhd/l/paIzkeqP5B
   1MD3zsZIxpU264/p1wzXI9+fINxarDaSCYI3urnEdBZpEYwTNzJwtQGWO
   x8LU7Xgq1u+Pgyjwl3p5p6XUu+MwzrtliHnjcBwYehYFlY2FEx7Qo+3b3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="282028035"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="282028035"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 20:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="662174410"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2022 20:03:47 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 20:03:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 20:03:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 20:03:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 20:03:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOD0cdfLm1SYCMHcnoidVE7YbWAuEPS0VPI3EAYk6B3huUWV7MUWGD6SgSaop0WBswn/Md2vuMDmJOrXekTT+u3hSFpSEVpAv9ZTVtkaJChwTYDJwP9Wo6629ZEK6bK0v9gjA7RuQfbm2k8T4UlmdVQ2LznHkvd1wKmjg2bSpo9Bif8VgS/f3OR8Yc0945yYHvTwvvCrU3Rbms0QLU50CrgnScZJd04bpk5CS9C3ku7ycszK67sUYvqD1T8uxddbLDE5+96GyzxeI4gmT61JEn2N4euiRpO1x4sjcTKXhx87hPsiqcdmCTORXZSVCmRaD934LaCRRN/yVv7pcJ/UFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFWWv3Fs1YVESxT8u759llpPQ2oqD0RJYq39jwpiDeg=;
 b=VIZGnEN+J3NnORGo7qayV5leldvGAl78KPv6RsyU5XXi7L5DGAx6zoujgEITCNNvEHyQ+KOQ+PaLrAKUj/xOoZ8fMJr5olU2O1vXZVPo9t91V7hWPDBl/1XYi1FajNNFRaa2hP18lTovjoa+bq6yM+aDOYHdlp+aGwqCNtnaYE1aQcbGb9lJ9nSQRPfbl5y8UN+GGEKbBT4gsKymgAgvN4x9GYhTQuCcOzXj+JCwiiYZxFT1OdCn2RIoQ40ZaArh/hQuAgODikoGyrej+25ks7UjIf2+febDlhVTN5ANvTc5fzB0DYGW7v1EuSPHu/IHKWqSUxQ+0BEaEsoaxIB96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN7PR11MB2643.namprd11.prod.outlook.com
 (2603:10b6:406:b2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sun, 10 Jul
 2022 03:03:45 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sun, 10 Jul
 2022 03:03:44 +0000
Date:   Sat, 9 Jul 2022 20:03:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 14/46] cxl/hdm: Enumerate allocated DPA
Message-ID: <62ca418dea1ef_2da5bd2946b@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603880411.551046.9204694225111844300.stgit@dwillia2-xfh>
 <20220629154359.000021cc@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629154359.000021cc@Huawei.com>
X-ClientProxiedBy: MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d121740-9c85-405d-1844-08da6220cca8
X-MS-TrafficTypeDiagnostic: BN7PR11MB2643:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMY3X4JlZ81t6ghaMxiSJL1xVc6YlejW/LoTrNQ/7AsCbT0de7ecQTcuxfiSCwj7AaS3pun5ki0/dLNxZ80lNN3IzXPw8ZCA+R60HEYRpYBqE1xWTuLB33gWRPq85nTrhsP9R/8gLWBhhcIjmiZNSPCaSbBXIHmh2Voq+d0x1ez1sq9DNcuNQoUuRoEZyIPkfp/m9mFuCos5oGgHvqmANEH7bMI2CDWA+KSuL7Vyve5/aECkqT4jqEVMFPoT9+lKtlSZBOwXtPRCigOBKDnEZCfOswOf7E910aVINbBqKMkebvSic88C1/7y+UeaMI6rUIOqFR41KwgpX/85ujTOjMosRc8JgkDibUwDub7nojZ92m+r86r4Xltl5rtBXAhOTbrxONOxtAxmy9Ies9ODI7WEFaX8kJgyhzChTbSv3ERrc/EhJLzV1AeumjDsyvisb8lStDi9z/4jb6aPor3KgsWUSVwOn5E14UUDZPxzuVad0uLtuuLwgWUqUyKRvWm/79bvE6a+WelsRSs/Z/1BnS3lbnnvJc5DGZT2nVL2TMKjHNLYqip0yD6PBrauypTqyzpBGpFj7XzBcIlhlFAkFS73eIqh8q1GJRQSsJUWQiwSVnaGzDkPBwoa3z0VbGaVw7JizUXa+ZW4sKHzxDbhBR1SjI47EptV4qQsUC2lj53k1FLfSsU8xYPPs2cn5qrswVH6EESikqZGE6kY6FLFIuiM5qsLGVrmlK2agxRgUhiFaxBFTnqCIfL4ju5PIZMLxk6vtSjykNUOUYkHzI3lHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(396003)(346002)(376002)(26005)(9686003)(186003)(83380400001)(6512007)(38100700002)(82960400001)(86362001)(110136005)(4326008)(478600001)(316002)(6486002)(41300700001)(66556008)(8936002)(66946007)(2906002)(6666004)(8676002)(66476007)(6506007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXNnF7EvtoDnDXljy7jXktAPLM37XcJlfshOIFAowd/UZl79R5roNayNC1uP?=
 =?us-ascii?Q?/1lmrbgjAQ6OMtFWVSMtCJkI+BUFV5spyhWdXSAbMqSnzxYlbGhSekWPPpBN?=
 =?us-ascii?Q?vBDjohcR9PJk/MogpsjI3SCk8pklMBiRBe0SSNHaS2Uh859hucspQLVG19P2?=
 =?us-ascii?Q?K9t5IbJhE3GdMsgi1SJNYU5VgB+LDqTtG6wzWg5EYKc9Fs/Lv9+Lpb/zNt7b?=
 =?us-ascii?Q?Ftq4CylClJ3pz1Z7CVUOFlzLKvsbR5F4hDK7nOOXr8d5CaFGVdbd/8mbcT/7?=
 =?us-ascii?Q?DtoSGeczv3c17sI6rTKSypAoVMdKACzgcbq01BbDdiofRmOH03f5npjbxotc?=
 =?us-ascii?Q?aF2kKzB1Pn/js0qA9ZP/kvWeIJFMGHbIGZ9F95Pgwf4sQQmvN1eYKexeGejF?=
 =?us-ascii?Q?zcOO/EWrBhOYk7BIzcsjvf1QIG9xoFlONy5FzZyN/NGOWz28HrIi+xqLEjxx?=
 =?us-ascii?Q?Pa767RKxF1/2Zr1Ta9iFNvhioa1MN1hz5bK4YHrbJEXQFcuxXsVVfixadnbM?=
 =?us-ascii?Q?PGDxA/FbaVnsPESCa3ehu8QiyfeWj1c5UWu4WPj3im4LQcd2GEL805G1XY8m?=
 =?us-ascii?Q?c8tPa0c8z/k4u2rRR7Ig4njR+3CP4jw9na6Kkn3KIvlKdru2pFFvYqf3C0lq?=
 =?us-ascii?Q?yHt/S5nNSZwx4AGhKcxzwpQfU54uLq3t3aWpwv8yGLlJE8lXRCJ0vGIuXlzZ?=
 =?us-ascii?Q?oClpSHmMrIP146zQ0gcy6guWVmc/Bzx+RDA2jxC5NV8ezr7CRVJFD3UtH+TZ?=
 =?us-ascii?Q?gghVnToMPtbaU4ECOPnKZqHe3IaaJiJymql3aCnSG3NMBhlBj7itfK/x5nw9?=
 =?us-ascii?Q?FPQZZspAmzVcK8rRonTz977wEAE1n+VtfFkLMlLtcydsBSXfV3B4qay7W9T1?=
 =?us-ascii?Q?8aAKIHss4qGe5SGucZQj9B9/r1c0m0IYYl9i7e6E9muQpLnVObfQqBjIjQvv?=
 =?us-ascii?Q?QsW4qfxq+0KX5NrYyX0kCXAMeDfwCHlF06oHbOgYl7Ll3gLwAl0mDhWNyaEq?=
 =?us-ascii?Q?TD0kPBxizBZr1fJGULSI8ZBJYhkE/nU+b45am/wOpVDtmDqleM7i0N7fpK70?=
 =?us-ascii?Q?W8ydLodWK7axy2TaO1nwa8STWjFD8QJ7iqugvn6Ic7axAjlPP0Wm6MAf9yGu?=
 =?us-ascii?Q?3LMGPY36o9Glm4wSzkAeY6C/ADEnKTRvxF9lsPG+3lrkPkFp1frTt07zFR67?=
 =?us-ascii?Q?KcEk1hq8Q8tslx7REX8zOLg3MeKzBFzPSQ+024uCztql9sXUqlVoYAMTXmJi?=
 =?us-ascii?Q?LuRZS3E/LENIw6OaWDvxfWxyCFFfvBqxk3fGV52VxNannJ6e41eAZAfinKkm?=
 =?us-ascii?Q?ubeI++SLmvIBGeszMblR6uTk71OHLjPK8vhTugU4vTCJBNYEek9sRw7047Go?=
 =?us-ascii?Q?JEEFkCWCuHKs9D60VbNIU3681GEp3QMobP/ym7S9ZSKddjF0x7iJq6MOMm3b?=
 =?us-ascii?Q?U1sFEky4UIo4wIHCPG20cq8GzcUu9Szn0BoBLx+NN+R3phYFDGqRHKkOfo/E?=
 =?us-ascii?Q?Ar/Z8rTuneeUHFA4WFzIcbZB3xtBJJoyeJXbz1N+qAilTVOrcBxvDU21QJr9?=
 =?us-ascii?Q?W/QswA8bpFAbqTUjy6NwCYVqMSypvVB/3363USaSGq4APyo0rEsOoQztCewQ?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d121740-9c85-405d-1844-08da6220cca8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 03:03:43.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOr3Q8WqZO+NDHLDbsXQSabZ8kV0BdDODwC/uu2B15cM8l7ZWg4QW6IR7SPodsIuc8Nw/8Q1Pe40ndhuiT3IrrG5ykK+MjqzkWeUeupPq04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2643
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:46:44 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for provisioining CXL regions, add accounting for the DPA
> > space consumed by existing regions / decoders. Recall, a CXL region is a
> > memory range comrpised from one or more endpoint devices contributing a
> > mapping of their DPA into HPA space through a decoder.
> > 
> > Record the DPA ranges covered by committed decoders at initial probe of
> > endpoint ports relative to a per-device resource tree of the DPA type
> > (pmem or volaltile-ram).
> > 
> > The cxl_dpa_rwsem semaphore is introduced to globally synchronize DPA
> > state across all endpoints and their decoders at once. The vast majority
> > of DPA operations are reads as region creation is expected to be as rare
> > as disk partitioning and volume creation. The device_lock() for this
> > synchronization is specifically avoided for concern of entangling with
> > sysfs attribute removal.
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c |  148 ++++++++++++++++++++++++++++++++++++++++++++----
> >  drivers/cxl/cxl.h      |    2 +
> >  drivers/cxl/cxlmem.h   |   13 ++++
> >  3 files changed, 152 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index c940a4911fee..daae6e533146 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -7,6 +7,8 @@
> >  #include "cxlmem.h"
> >  #include "core.h"
> >  
> > +static DECLARE_RWSEM(cxl_dpa_rwsem);
> 
> I've not checked many files, but pci.c has equivalent static defines after
> the DOC: entry so for consistency move this below that?

ok.

> 
> 
> > +
> >  /**
> >   * DOC: cxl core hdm
> >   *
> > @@ -128,10 +130,108 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
> >  
> > +/*
> > + * Must be called in a context that synchronizes against this decoder's
> > + * port ->remove() callback (like an endpoint decoder sysfs attribute)
> > + */
> > +static void cxl_dpa_release(void *cxled);
> > +static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled, bool remove_action)
> > +{
> > +	struct cxl_port *port = cxled_to_port(cxled);
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct resource *res = cxled->dpa_res;
> > +
> > +	lockdep_assert_held_write(&cxl_dpa_rwsem);
> > +
> > +	if (remove_action)
> > +		devm_remove_action(&port->dev, cxl_dpa_release, cxled);
> 
> This code organization is more surprising than I'd like. Why not move this to
> a wrapper that is like devm_kfree() and similar which do the free now and
> remove from the devm list?

True. I see how this got here incrementally, but this end state can
definitely now be fixed up to be more devm idiomatic.

> 
> static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> {
> 	struct cxl_port *port = cxled_to_port(cxled);
> 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> 	struct resource *res = cxled->dpa_res;
> 
> 	if (cxled->skip)
> 		__release_region(&cxlds->dpa_res, res->start - cxled->skip,
> 				 cxled->skip);
> 	cxled->skip = 0;
> 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> 	cxled->dpa_res = NULL;
> }
> 
> /* possibly add some underscores to this name to indicate it's special
>    in when you can safely call it */
> static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> {
> 	struct cxl_port *port = cxled_to_port(cxled);
> 	lockdep_assert_held_write(&cxl_dpa_rwsem);
> 	devm_remove_action(&port->dev, cxl_dpa_release, cxled);
> 	__cxl_dpa_release(cxled);
> }
> 
> static void cxl_dpa_release(void *cxled)
> {
> 	down_write(&cxl_dpa_rwsem);
> 	__cxl_dpa_release(cxled, false);
> 	up_write(&cxl_dpa_rwsem);
> }
> 
> > +
> > +	if (cxled->skip)
> > +		__release_region(&cxlds->dpa_res, res->start - cxled->skip,
> > +				 cxled->skip);
> > +	cxled->skip = 0;
> > +	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> > +	cxled->dpa_res = NULL;
> > +}
> > +
> > +static void cxl_dpa_release(void *cxled)
> > +{
> > +	down_write(&cxl_dpa_rwsem);
> > +	__cxl_dpa_release(cxled, false);
> > +	up_write(&cxl_dpa_rwsem);
> > +}
> > +
> > +static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > +			     resource_size_t base, resource_size_t len,
> > +			     resource_size_t skip)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_port *port = cxled_to_port(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct device *dev = &port->dev;
> > +	struct resource *res;
> > +
> > +	lockdep_assert_held_write(&cxl_dpa_rwsem);
> > +
> > +	if (!len)
> > +		return 0;
> > +
> > +	if (cxled->dpa_res) {
> > +		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
> > +			port->id, cxled->cxld.id, cxled->dpa_res);
> > +		return -EBUSY;
> > +	}
> > +
> > +	if (skip) {
> > +		res = __request_region(&cxlds->dpa_res, base - skip, skip,
> > +				       dev_name(dev), 0);
> 
> 
> Interface that uses a backwards definition of skip as what to skip before
> the base parameter is a little odd can we rename base parameter to something
> like 'current_top' then have base = current_top + skip?  current_top naming
> not great though...

How about just name it "skipped" instead of "skip"? As the parameter is
how many bytes were skipped to allow a new allocation to start at base.
