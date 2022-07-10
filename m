Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3356D1B5
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGJV6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJV6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 17:58:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DB0DF8B;
        Sun, 10 Jul 2022 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657490293; x=1689026293;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NsE9WFeyKj/rWrPJCnRNqhQyusCR2ZNjh2Ng+TKRXVU=;
  b=DgL2Isk9JdsICDY5qOPEZMRRhZrelh7bLIvNKnVJ9xLueuu2EBLPItJK
   gSY85iiELG2fo40s4z6/xZLkfffo6ybVv+Gh8eho07vBtwSktDa6dmdTq
   hozPfxEWFQ2uO0Yb2RMlNYyG0ZA8obdR76Aj5wpZGrpoKM64Q/etEPI4/
   fQvoFgCjvQLiKd0y93lKQ5Kaa91VaiSUHlI4ovJObUVYR6uAWZW78h9nG
   y32k+5rwHLlf+wpYFFvctdS2tQ/tigzsa+HAtlAKbemLDUG5w1I5pZD3j
   AA+Vqta6zWUSfHZBFtGKyAXJoJIdrIDHr0Qn/PyiywPQNL4fSL7h1DI6B
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284562695"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="284562695"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 14:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="569547251"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2022 14:58:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 14:58:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 14:58:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 14:58:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 14:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxDdPwDkku8ayCKnqqgOAmsi6yt5ZpUhkLVBAKXcEjXTgovXwtvWqYILI0UjV2DjfAIm5q9xA0ZExAOUhCEmWuYKzREILU6LYxDAxs5ACGXcL9Wma/fccKHlQKGUYGQn8TCsOpeNPsJFlkyghTEzn+AsmQyiUoBTmi34a80oMga5DVgD0veMhOs9iUJxVHv+eQllQArFA/QA5sJtPwjiufcwbfLUV3YKvFMDF5lSuuTfZgwtbwsT8PfNwcNwUCG7No9+dyaWWFyc6TQ8FI5QwVxWL3Df3bSWVWqscDWBaiNlCqDKuujPufnASCCniIJEk+NPnjN+JX2qKMfExAUsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWkwiKYwXxqSp6wJAGNW0aaxUa6UWcl2sjLJvhJxfXA=;
 b=JcRMIaG2coP/0QJJ+G1VBeMCOXmA9B3EhDSDJamG8XlO3KPJiibmlrWz8peEvjbzxPrzY09GcpkMD9CoQSPxfHxAjdogC9+k0qDaYl8KH2MYW2wFIs0qd7EDM/rO8ayIcG7SLk9pqtcdzCQ0QmWSEkVesprRE4jsuU9PNqxquc45kA5QF5zChC6UUkjQCaSaPW6VLCHU/G5XUeembaH2PLyiDUBszTEXk0oSncunyG3w2ar3PuKvD7Wx92v4fE/8VyoWRMH2u6hTdQMWs5RzxnaIXp8ggXYKLGUS0DSHLinxrVMV5/RI+c1oH60Pz+hYex2/ShDhxG+xGk5I3tz2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4400.namprd11.prod.outlook.com
 (2603:10b6:208:18c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Sun, 10 Jul
 2022 21:58:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 21:58:09 +0000
Date:   Sun, 10 Jul 2022 14:58:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Jason Gunthorpe" <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH 33/46] resource: Introduce alloc_free_mem_region()
Message-ID: <62cb4b6ed3efd_35351629463@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-8-dan.j.williams@intel.com>
 <20220630113548.000036e8@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630113548.000036e8@Huawei.com>
X-ClientProxiedBy: MWHPR18CA0051.namprd18.prod.outlook.com
 (2603:10b6:300:39::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98ce5915-8946-4b4d-0285-08da62bf46d4
X-MS-TrafficTypeDiagnostic: MN2PR11MB4400:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3TRmapLGWuTeDFduuLlsAxtdSDoDMoQb5CWpc8CDJ2ZwUxDv0aJwgHcRJM23gvc0QiCXHX9439YwBfpszV8rzCAYRW3w7iv17xOONCVQG0Zst+zj3MgXQuWnf6c/Fqv0RXApPKzpeEjiw7Wkl9r+gDRHmeSf5lN+83VJKzvqjRDl3OdRQq8AOseRapdWLV4PBxpy1z4/x219JnDdz7BqYuoxeX4y9nrib5lJSaIh7zM+QnppSEdDukz5HeFJJ418iRS2+yLFXBY+2CHey7sbTEY2RBkvsbTXFyy5l+eFkwFY2tre6kT1itGi+POGiGXrG8hrQHifkCh1gh7GTUawx2oVfET541e3UNTx/qiCCeTbEUk7IQmGxB2ys+xzkp1nVQlSwFdIVHhmhgZs1R3RTeHdgFzdVTiqWzytxHT9VCUenHe5v2Rhrp8e+AhOQFjgusYkE4iDE75I7aYpbxct4M9D79s7WvyBRHFLFf8TQ/FhvzCkHOm2X7R1XTwhoYgrk+O0G39r3pQLLfyjINJekjj7jYMUOM1VMuinfPYKJ1PzNwV1v35YgeHQZdZep9N71S7ZM7TztuKPAiUjYnArVrzBB5qAShZ0r0XjhVic9n+tma8AYJGV5dNmNF09xbI1G82AQZqKbZIHd88ly8GuuVflDMoFU/rs3SVAYPQNmkmyE/+1EbwiABXC0XUty42AkjLq/GCen2XROfALpwfOwa5Pyv28N5RKTB+mS3EYCDxs+AMi1S6BfKDz1fm0wHKV7VQNSH9CNGuiTOHnLFDVGWU4uONQ+NwztNZ6C4TApo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(39860400002)(366004)(346002)(8936002)(2906002)(5660300002)(38100700002)(54906003)(8676002)(66476007)(66946007)(66556008)(110136005)(86362001)(316002)(4326008)(26005)(9686003)(82960400001)(186003)(6506007)(478600001)(6512007)(41300700001)(6486002)(966005)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uUCBzRGiM6bCknGmbjBhI0JkoWE6KsmIjGUOat/mciK+ImuKb2vSHdj9zR6d?=
 =?us-ascii?Q?ExN60o0oQ7Xh7yQ+acZytQ0iKAnY3Z+3sYE2yvN/XYQZXOmvMfH6LsrlY28o?=
 =?us-ascii?Q?7oH9hQe6dtGU/9PdTlxdUupSkYWsmkFBIRrHiO7lukysY0IjKHdBFeNjBjyq?=
 =?us-ascii?Q?QhjXsjriXkyIS9UIGSmPx50svayJvV57vNOYJpwssYqmfEJZ1oEQP08084Tc?=
 =?us-ascii?Q?xs4oL3q3lc5O0M5vT2L731w9Eg0e7WRijV736dZ67z8ElDVXjTLE90/AfueN?=
 =?us-ascii?Q?ATMzMVQgj16K90b3trmLBWeEm60o633Zk67x/bMBaYfoL0yE3sXEyrAAVAA5?=
 =?us-ascii?Q?bThCjCjzcfZ5hGPXbN4ekZCvTUeRxjIkQ/7zuD2B2+uJqdOo0ZCZdtq9EW79?=
 =?us-ascii?Q?pqr8DA6fAK7nJCCO4MY/ZSja0Vzg6U/ndV5mPL1e6ASNelMr5vJWmWgjuHW3?=
 =?us-ascii?Q?/C/iW1UQRspz58toPZ632CG9kvBVsVG/rCmfzPHKrzlfPZP/pzOQUJNs4hOj?=
 =?us-ascii?Q?la22cG7nnTthQ6Qgpg+hpaX0nXjTl6yETqHhZjyb4TpnySQ27XMzWhz0jLX5?=
 =?us-ascii?Q?HSl4rybV+WRwt1LDKK8Zc0o9qqQfNhqdfY74sXiwEKqs30WulLkCz56zUHKc?=
 =?us-ascii?Q?bHVjY1Xf3nd4fa4Pz1yWO/jb03F4UZHIIWeVFnt2E+zbckPMfGHkIkJ/vPwO?=
 =?us-ascii?Q?S6dxsNBNGnCZUIh9ALVnauIfsGX6ifmkNHaSrkm0867u5BU3+BRqVEDTWDtQ?=
 =?us-ascii?Q?ss5VY3dB1vmVHSZBmWZoVvC/nTYF7Kdl88e+SJ0yal4MhSVF8+Fbjub2Gdy0?=
 =?us-ascii?Q?D3EadoZgcIcBKGAOFBUgCZC1T8F6kmQ/xaA6O2bF+5ijjwkhews6/CCqDTye?=
 =?us-ascii?Q?1Neok+ciSXoCRsCFHMFzvxnZJNa3EY2Bs6c8iT+KMb2KgwJJ3JF46nkWsMkM?=
 =?us-ascii?Q?Do5bNcbA4pNmrBOd/LoBydljsFCx5GgORUJ8Tu4RO6UqepRsAINrOe+HjNsc?=
 =?us-ascii?Q?rMxfM71cyBK2rODndeFNaK9PL+g+pGkPh0ebmAFr0AFmhhkmz6VWh/hQN3bP?=
 =?us-ascii?Q?tjrlkoqxntf5p+WievKh2dNRySitSFq9xW2ycvpu+64TWt4NdUmJSAJYW52B?=
 =?us-ascii?Q?hqu0AsUK+xsBGHgLdxKsUQaScJVQ7a2/O2KZiJsuSPgC7UF0tyeZMcNTOyvs?=
 =?us-ascii?Q?hNAkIgHxBKM98Er7y9IX5VWjWHn5yeXKjX3W/SUrGAmS6rEmMXXPqaHlBeN7?=
 =?us-ascii?Q?AcRu4gf5uwWxm9sfEih1+j17jnVdD2yl6yQdvYmHx0HK1uR9ozfbDvJgaRRb?=
 =?us-ascii?Q?W0YPgSkncLbjO6W8yy5OOTtiuRqx0+8uNcy6K7eXK8c1BHlTWWrLJpdgrRIH?=
 =?us-ascii?Q?JatiaMVha9F146tSDR9qbM3T6VS7jqE0jfeo2UqyO6ZuuY8e2Q65jI5fnZxE?=
 =?us-ascii?Q?6mWeXfa6gLOv2JY/4KS14Pqh0cs7TNj2MY5A8nBkKeFY7ttI65yJbeP5bVC3?=
 =?us-ascii?Q?cxEUW4qm2AyWw/XaYU6T+I/Fk7nc4g+J7y9GqLPVMqk4rV2JGi9McBPf+Wlm?=
 =?us-ascii?Q?/dxqQKYmaAmdIqo4sLAmqAQl7TomxA3XvTHciCqwt9VVDext9lPQMYC0xTp6?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ce5915-8946-4b4d-0285-08da62bf46d4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 21:58:09.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwQQKvNmBkZeROH9WHgLuaRd/mSkUHU1xWMsIl87ujNKJYRcwB0yi8jij5FWZAeS71MhVm5dzBjdONS9RYGv72rZ5U3W21WMpOBv02Zds0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:37 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The core of devm_request_free_mem_region() is a helper that searches for
> > free space in iomem_resource and performs __request_region_locked() on
> > the result of that search. The policy choices of the implementation
> > conform to what CONFIG_DEVICE_PRIVATE users want which is memory that is
> > immediately marked busy, and a preference to search for the first-fit
> > free range in descending order from the top of the physical address
> > space.
> > 
> > CXL has a need for a similar allocator, but with the following tweaks:
> > 
> > 1/ Search for free space in ascending order
> > 
> > 2/ Search for free space relative to a given CXL window
> > 
> > 3/ 'insert' rather than 'request' the new resource given downstream
> >    drivers from the CXL Region driver (like the pmem or dax drivers) are
> >    responsible for request_mem_region() when they activate the memory
> >    range.
> > 
> > Rework __request_free_mem_region() into get_free_mem_region() which
> > takes a set of GFR_* (Get Free Region) flags to control the allocation
> > policy (ascending vs descending), and "busy" policy (insert_resource()
> > vs request_region()).
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Link: https://lore.kernel.org/linux-cxl/20220420143406.GY2120790@nvidia.com/
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A few things inline,
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  include/linux/ioport.h |   2 +
> >  kernel/resource.c      | 174 ++++++++++++++++++++++++++++++++---------
> >  mm/Kconfig             |   5 ++
> >  3 files changed, 146 insertions(+), 35 deletions(-)
> > 
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index ec5f71f7135b..ed03518347aa 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -329,6 +329,8 @@ struct resource *devm_request_free_mem_region(struct device *dev,
> >  		struct resource *base, unsigned long size);
> >  struct resource *request_free_mem_region(struct resource *base,
> >  		unsigned long size, const char *name);
> > +struct resource *alloc_free_mem_region(struct resource *base,
> > +		unsigned long size, unsigned long align, const char *name);
> >  
> >  static inline void irqresource_disabled(struct resource *res, u32 irq)
> >  {
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 53a534db350e..9fc990274106 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> 
> 
> > +static bool gfr_continue(struct resource *base, resource_size_t addr,
> > +			 resource_size_t size, unsigned long flags)
> > +{
> > +	if (flags & GFR_DESCENDING)
> > +		return addr > size && addr >= base->start;
> > +	return addr > addr - size &&
> 
> Is this checking for wrap around?  If so maybe a comment to call that out?

Yes, and ok.

> 
> > +	       addr <= min_t(resource_size_t, base->end,
> > +			     (1ULL << MAX_PHYSMEM_BITS) - 1);
> > +}
> > +
> > +static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
> > +				unsigned long flags)
> > +{
> > +	if (flags & GFR_DESCENDING)
> > +		return addr - size;
> > +	return addr + size;
> > +}
> > +
> > +static void remove_free_mem_region(void *_res)
> >  {
> > -	resource_size_t end, addr;
> > +	struct resource *res = _res;
> > +
> > +	if (res->parent)
> > +		remove_resource(res);
> > +	free_resource(res);
> > +}
> > +
> > +static struct resource *
> > +get_free_mem_region(struct device *dev, struct resource *base,
> > +		    resource_size_t size, const unsigned long align,
> > +		    const char *name, const unsigned long desc,
> > +		    const unsigned long flags)
> > +{
> > +	resource_size_t addr;
> >  	struct resource *res;
> >  	struct region_devres *dr = NULL;
> >  
> > -	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
> > -	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
> > -	addr = end - size + 1UL;
> > +	size = ALIGN(size, align);
> >  
> >  	res = alloc_resource(GFP_KERNEL);
> >  	if (!res)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	if (dev) {
> > +	if (dev && (flags & GFR_REQUEST_REGION)) {
> >  		dr = devres_alloc(devm_region_release,
> >  				sizeof(struct region_devres), GFP_KERNEL);
> >  		if (!dr) {
> >  			free_resource(res);
> >  			return ERR_PTR(-ENOMEM);
> >  		}
> > +	} else if (dev) {
> > +		if (devm_add_action_or_reset(dev, remove_free_mem_region, res))
> > +			return ERR_PTR(-ENOMEM);
> 
> slightly nicer to return whatever value you got back from devm_add_action_or_reset()

Yes, but it is known to only return -ENOMEM on failure and saves adding
a local @rc variable.

> 
> >  	}
> >  
> >  	write_lock(&resource_lock);
> > -	for (; addr > size && addr >= base->start; addr -= size) {
> > -		if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> > -				REGION_DISJOINT)
> > +	for (addr = gfr_start(base, size, align, flags);
> > +	     gfr_continue(base, addr, size, flags);
> > +	     addr = gfr_next(addr, size, flags)) {
> > +		if (__region_intersects(base, addr, size, 0, IORES_DESC_NONE) !=
> > +		    REGION_DISJOINT)
> >  			continue;
> >  
> > -		if (__request_region_locked(res, &iomem_resource, addr, size,
> > -						name, 0))
> > -			break;
> > +		if (flags & GFR_REQUEST_REGION) {
> > +			if (__request_region_locked(res, &iomem_resource, addr,
> > +						    size, name, 0))
> > +				break;
> >  
> > -		if (dev) {
> > -			dr->parent = &iomem_resource;
> > -			dr->start = addr;
> > -			dr->n = size;
> > -			devres_add(dev, dr);
> > -		}
> > +			if (dev) {
> > +				dr->parent = &iomem_resource;
> > +				dr->start = addr;
> > +				dr->n = size;
> > +				devres_add(dev, dr);
> > +			}
> >  
> > -		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> > -		write_unlock(&resource_lock);
> > +			res->desc = desc;
> > +			write_unlock(&resource_lock);
> > +
> > +
> > +			/*
> > +			 * A driver is claiming this region so revoke any
> > +			 * mappings.
> > +			 */
> > +			revoke_iomem(res);
> > +		} else {
> > +			res->start = addr;
> > +			res->end = addr + size - 1;
> > +			res->name = name;
> > +			res->desc = desc;
> > +			res->flags = IORESOURCE_MEM;
> > +
> > +			/*
> > +			 * Only succeed if the resource hosts an exclusive
> > +			 * range after the insert
> > +			 */
> > +			if (__insert_resource(base, res) || res->child)
> > +				break;
> > +
> > +			write_unlock(&resource_lock);
> > +		}
> >  
> > -		/*
> > -		 * A driver is claiming this region so revoke any mappings.
> > -		 */
> > -		revoke_iomem(res);
> >  		return res;
> >  	}
> >  	write_unlock(&resource_lock);
> >  
> > -	free_resource(res);
> > -	if (dr)
> > +	if (flags & GFR_REQUEST_REGION) {
> > +		free_resource(res);
> >  		devres_free(dr);
> 
> The original if (dr) was unnecessary as devres_free() checks.
> 
> Looking just at this patch it looks like you aren't covering the
> corner case of dev == NULL and GFR_REQUEST_REGION.
> 
> Perhaps worth a tiny comment in patch description? (doesn't seem worth
> pulling this change out as a precursor given it's so small).
> Of add the extra if (dr) back in to 'document' that no change...

Added to the changelog:

As part of the consolidation of the legacy GFR_REQUEST_REGION case with
the new default of just inserting a new resource into the free space
some minor cleanups like not checking for NULL before calling
devres_free() (which does its own check) is included.

> 
> 
> > +	} else if (dev)
> > +		devm_release_action(dev, remove_free_mem_region, res);
> >  
> >  	return ERR_PTR(-ERANGE);
> >  }
> > @@ -1854,18 +1928,48 @@ static struct resource *__request_free_mem_region(struct device *dev,
> >  struct resource *devm_request_free_mem_region(struct device *dev,
> >  		struct resource *base, unsigned long size)
> >  {
> > -	return __request_free_mem_region(dev, base, size, dev_name(dev));
> > +	unsigned long flags = GFR_DESCENDING | GFR_REQUEST_REGION;
> > +
> > +	return get_free_mem_region(dev, base, size, GFR_DEFAULT_ALIGN,
> > +				   dev_name(dev),
> > +				   IORES_DESC_DEVICE_PRIVATE_MEMORY, flags);
> >  }
> >  EXPORT_SYMBOL_GPL(devm_request_free_mem_region);
> >  
> >  struct resource *request_free_mem_region(struct resource *base,
> >  		unsigned long size, const char *name)
> >  {
> > -	return __request_free_mem_region(NULL, base, size, name);
> > +	unsigned long flags = GFR_DESCENDING | GFR_REQUEST_REGION;
> > +
> > +	return get_free_mem_region(NULL, base, size, GFR_DEFAULT_ALIGN, name,
> > +				   IORES_DESC_DEVICE_PRIVATE_MEMORY, flags);
> >  }
> >  EXPORT_SYMBOL_GPL(request_free_mem_region);
> >  
> > -#endif /* CONFIG_DEVICE_PRIVATE */
> > +/**
> > + * alloc_free_mem_region - find a free region relative to @base
> > + * @base: resource that will parent the new resource
> > + * @size: size in bytes of memory to allocate from @base
> > + * @align: alignment requirements for the allocation
> > + * @name: resource name
> > + *
> > + * Buses like CXL, that can dynamically instantiate new memory regions,
> > + * need a method to allocate physical address space for those regions.
> > + * Allocate and insert a new resource to cover a free, unclaimed by a
> > + * descendant of @base, range in the span of @base.
> > + */
> > +struct resource *alloc_free_mem_region(struct resource *base,
> Given the extra align parameter, does it make sense to give this a naming
> that highlights that vs the other two interfaces above?
> 
> alloc_free_mem_region_aligned()

The other variants are also aligned, they just aren't variably aligned,
they are implicitly aligned to GFR_DEFAULT_ALIGN. So I think calling
this one _aligned() betrays what is happening in the other cases.

> > +				       unsigned long size, unsigned long align,
> > +				       const char *name)
> > +{
> > +	/* GFR_ASCENDING | GFR_INSERT_RESOURCE */
> 
> Given those flags don't exist and some fool like me might grep for them
> perhaps better to describe it in text
> 
> 	/* Default of ascending direction and insert resource */

Ok.
