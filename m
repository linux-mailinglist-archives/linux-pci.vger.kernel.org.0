Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7982656CC07
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 01:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiGIXih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 19:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIXig (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 19:38:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4119EE1D;
        Sat,  9 Jul 2022 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657409913; x=1688945913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gM8TPoOYkN97aixi5C96hnxySsBEcEQKNllctF+5/xw=;
  b=JY+wJ1ZxXQB7hgenYdKg8bR+/NoIpaPLYav5dKLYWRtCLpXRLxLYhnVr
   /HM0W3X0qBC8CppXT0NPRnH5YpjdcgnZ4Ft25uzFgHFLTzgFl7bhiB4jV
   NA1yqhuYZnaT5xKOOdg0xKh6KVonkf1bhwV+7xHLhGKnsI7H8kWfV7TCp
   gHrmRJoojzPSHXDySzVf1TDTti6a5wSrghlmxXfkOpNrKqMsKvbor2nD5
   zXjy3bSAgGBFn2ls6Be58yyg478gpJPWZC/kdTPGISD6hlNqmlZrp3VIY
   VpdscKlt9/RNtNbOxnDjqSIRzdaT39D4KiIbnXkjGrVHafYkhYlh0dpkx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="264878341"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="264878341"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 16:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="621644662"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 16:38:31 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 16:38:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 16:38:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 16:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlchDY82WXDTvezSq59LsAYMUdc8/hIy5gPSf3j9o+aLGeCXseh7iCylXIY8fiM4KT2JK0fUxPjo48WpKdacB94m53LHZaKuwEBfwAaYc8nMq7pseeziSxQ1Dil8T+mYEWzDjZwuSFPXe8lw0G3jOVEzh+HQlaJbT8sP8TH/Whfx9WZJVFWC35sZnV+WHrq2kQWvt/bYdx1JrV9Qk0CzNBUtlLlS42sZ+eG3cXLQfBosJwAHlxLedwg/Vf/RWfPDjtsMLTcCon0EPvO5Ku09llcaimjxYy57mpW3coBaPWkaLoMDlXgs6UZBzbb0C7HnEyozl6l0JOwgMneMQTl+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR79zUO20yaQkwt8scPnvbZAB2faekQfeTPnPZmjIq4=;
 b=JkPfFb9N/3gOJneHZxmtiKtvLq4OaK/EG63pTUdTX4F4StW5t5tOUcacg5B8/BJsRf6m0O0WopUCv9DliOWgiQFpXkcfN2XqyhhnemYD5IyPEwQT0AjxcvwjzScun9Wnl3XrGQ7xQObkGW2Osf4UJmlGpg6ypHgspLhlRfrR9oTTKF+6oAQ2ijLxAQrCMKVED25F9rnllI92t34MxL9Fo3wMZeEue/LB4pByU0IqBpBywGfPv11RamaI5Kx3L7xqxljLDWoknkKlfD0RbQCxMNdkTdDY7k9ZCp9+haC3gM8rAwU5yhmol9Jy3dK+2jyK43ZDq4FILzyS6xW2Og/oBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB5992.namprd11.prod.outlook.com
 (2603:10b6:8:73::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 23:38:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sat, 9 Jul 2022
 23:38:29 +0000
Date:   Sat, 9 Jul 2022 16:38:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Adam Manzanares <a.manzanares@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 05/46] cxl/core: Drop ->platform_res attribute for root
 decoders
Message-ID: <62ca11732897b_2c74df2949f@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603873619.551046.791596854070136223.stgit@dwillia2-xfh>
 <CGME20220629202117uscas1p2892fb68ae60c4754e2f7d26882a92ae5@uscas1p2.samsung.com>
 <20220629202116.GC1140419@bgt-140510-bm01>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629202116.GC1140419@bgt-140510-bm01>
X-ClientProxiedBy: CO1PR15CA0096.namprd15.prod.outlook.com
 (2603:10b6:101:21::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b3946d5-8c00-43f6-9c0c-08da62042067
X-MS-TrafficTypeDiagnostic: DS7PR11MB5992:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1cBN+RwW8BMV4p668shxmtk635lTC2uje7WGHPjHF2t2HaMK9cLlKJQdM8C9m96uI7UE8h+6c9/JkbISuzD7E9G3CtLXuXB9mYVwAdD4M4feXHnMZ4EwQaf+UbzQMk9Umi9LCZ2fhiT0s0ECn+71NYtgyUY4fw0Ijs1MxtMunaVHg/rmrvmZY4UT9lEFrQMai8iKE/B3UX8oY/2WOrunVmdHyNZOQgDypjT344de9Hhj83XUc95vnshW7wjxCSx/D1HFf10seq5aDsjqA++LeJGUbI12uRATjz/NBUYLzOAAEZ96TjB3H/Zb18ifkLXgE/b24RgzjJFa8KTcG5KiYUOK6rb8cUvajCSUu3y70pCKnfRiqKAlv+cpwCMb8hSUK1QWcHZuBTSQuDfK76ExUugsgPTPI96UmrbhM0bkeB1AC9u88zorXcqYORQ1AHayTeizQP7uToc1zF5UHa5PouF8mcQga1igQOovU8zAKkXl7jrmMXdSRbURcDQdcTrBBp2NmJssZZHnW+pbhn23donGz1WmR6zpe31GVS/RWuOyNpesjHvGyTGk+Iu8V/A6JgOjy352YUSnZauE65D0ujA9gyXo0/7bPMxS08SPAWBquLwSYazOou5AfbIEOkLO1e9+AXpQdK6OBsKgkkyZbbrT+O3pvDlVdbylVvch1MMu7RYMv0fnClMwbZN7QSevwYk+Tm/6vj8Mz9HH+2uaxPFFt1gVQWLhjJQMwMI47Q0sJFqNgSTXbror/pVsVl2a/W26OYX4MjI6BKPerROyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(136003)(346002)(6486002)(478600001)(8936002)(38100700002)(86362001)(186003)(54906003)(8676002)(6506007)(41300700001)(66556008)(4326008)(66946007)(26005)(6512007)(316002)(66476007)(110136005)(83380400001)(2906002)(9686003)(5660300002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pLQAgzfgw8LQ83U/L6hum7gnnzLFa7upyFDBxzr0gheVVZ3lnJAJ5kNRikb4?=
 =?us-ascii?Q?6nmhvg0cv8GAzIqHWL6TIkhwZpmBr9iH+TSRbMYRtI5+OlFQV4PeGdV1/cHz?=
 =?us-ascii?Q?zjC29NDE+j7RXO93omOtL3R7uynu109exIIkuskToWvYuMOYWnzHEJB3a/Zp?=
 =?us-ascii?Q?mm2K3eMEJ4AQYVpsDAKg15ewa2nfqGljpz7HOaJ3F1zjOD8bH2WVKrChRviQ?=
 =?us-ascii?Q?OzVBtZYbOKQrF6M/Bw2bxJGKQe6MYadhq8XreCswPCSQ29pvGYeDU+llFpWr?=
 =?us-ascii?Q?9/2U6388n/GBDq1RW9ySDZ5amrc8dZhmAWXSzI4Ngmdz0rUb/0ij1PFUPkb3?=
 =?us-ascii?Q?3n6QkPRHhUoqS0oBnkVMwfwNtuq9I3xui7A14iVv6zgRorSARRHSpHGcPk2+?=
 =?us-ascii?Q?nMF/eBzndXn0GXCFtUzlSD/BcCSbc9KHifqX7anGEAU3kbzjXMYFPlrm2nbH?=
 =?us-ascii?Q?l2ElDvdVuF9E0bC5l342j92/K+31OOTCGPwvjrISchkrNr2/DzjE8MOaJ/Cj?=
 =?us-ascii?Q?VmisQO4qLmp3nm/o/LsmSDxAqpnDnyO6iw7skl3f9Kxnpr/QcLHr1YyD8t/i?=
 =?us-ascii?Q?7KK/TfF+iJALhxiKnuCgGSClR/YGmCnYFSXEPey2JCWgx87gSbJPZMSGZY4Y?=
 =?us-ascii?Q?J6N8YDuTyGcOgvO9PAQFbw29QNhpCS6f3fa61nrtg71h1nMwIzfG48TczM67?=
 =?us-ascii?Q?qDjYkPkl7zwzOAvUxeU/MxzkIzAZRxsjvP5Xr8AlRL0l0GSXgxtDf0AyIvS3?=
 =?us-ascii?Q?oOJ7dwDhpl9pre8a6xwPvuuyiw05KHZrx8rcvu+Qbb6clE3zhS0utl3VgsSr?=
 =?us-ascii?Q?Rq1sj0gX1+3iOiXnYvKp3/oSxnOwiVlzUoCdrcwrph/FKxGg/Bt7QQBUOb0f?=
 =?us-ascii?Q?bvJsa+SF/rQFKSAKrtNEIfbGBW6iAcABR1l1HezEhLB/ljXJa6mdXG14VeXp?=
 =?us-ascii?Q?8YN871BYIp8X9Pa86DzbaHsjiv3jQ3dBWF3QGp51uCP90DYLO/brytESbjmW?=
 =?us-ascii?Q?JsowCMgJZKEgBoDF1+bS53ZEwHzmR8I95eRnsomohKWOBcK8RB89qPFKRErD?=
 =?us-ascii?Q?uOCij0sWCXM5uytjC1PSpbzZpzdLUwxT7U+Jgi8mrWef2eqXA64yiJN7BSqL?=
 =?us-ascii?Q?psH+FZaVCsb+R6NGP34iYSfeiQNiKzJmokxYjXj0o40dTxy92mfwMf7r0cqY?=
 =?us-ascii?Q?DrM5TtenGZaVr9brP039YUMtluCFzY7+dcljk/QNAwGgMe3mK+r/UuU8d5vT?=
 =?us-ascii?Q?DZqohWF2FGz4ZN2sSE4s9zVTaoHaCcWd1gKHioMKgl2Cn6uxMdE6pnF/1PiN?=
 =?us-ascii?Q?7Ww4OZrbv1LrCFfYlVllFyfTbv4pM52WbLTn8egoZfTWwKKAdK12SaJJwYYL?=
 =?us-ascii?Q?dHnjCCNYb7ZVaOQe7JyhCjH3MHiqs1tPXj9wkKUTtSuEFobg0zCOM2HVnRFl?=
 =?us-ascii?Q?UbkI7+P8fRx7DtoomIkqzPOS938NZA/AgWeW6qRkkX2gGcyAa9/0AWgaSeWl?=
 =?us-ascii?Q?hkJBQFFPQJMZz1CsVpnbYj1ex2MDtf3TeqQrAPiD3LsrIJ9Jjqia909yJlme?=
 =?us-ascii?Q?+pUW4NTse27ihygDYma88OeDnNB4kpW5RuJXLYdejIERS7FoR6fVr/tR2Pew?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3946d5-8c00-43f6-9c0c-08da62042067
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 23:38:29.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxbuqmnBKzdggBqG6qyKpQtbtm7bcjV+htgZwuz/JTOnCqKuck7yi7nS6tvEaE6+bjaEPYSlO0anbhWjdTyV5f3j7Meya8yofs49JnS7XCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adam Manzanares wrote:
> On Thu, Jun 23, 2022 at 07:45:36PM -0700, Dan Williams wrote:
> > Root decoders are responsible for hosting the available host address
> > space for endpoints and regions to claim. The tracking of that available
> > capacity can be done in iomem_resource directly. As a result, root
> > decoders no longer need to host their own resource tree. The
> > current ->platform_res attribute was added prematurely.
> > 
> > Otherwise, ->hpa_range fills the role of conveying the current decode
> > range of the decoder.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c      |   17 ++++++++++-------
> >  drivers/cxl/core/pci.c  |    8 +-------
> >  drivers/cxl/core/port.c |   30 +++++++-----------------------
> >  drivers/cxl/cxl.h       |    6 +-----
> >  4 files changed, 19 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 40286f5df812..951695cdb455 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -108,8 +108,10 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  
> >  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> >  	cxld->target_type = CXL_DECODER_EXPANDER;
> > -	cxld->platform_res = (struct resource)DEFINE_RES_MEM(cfmws->base_hpa,
> > -							     cfmws->window_size);
> > +	cxld->hpa_range = (struct range) {
> > +		.start = cfmws->base_hpa,
> > +		.end = cfmws->base_hpa + cfmws->window_size - 1,
> > +	};
> >  	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
> >  	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
> >  
> > @@ -119,13 +121,14 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  	else
> >  		rc = cxl_decoder_autoremove(dev, cxld);
> >  	if (rc) {
> > -		dev_err(dev, "Failed to add decoder for %pr\n",
> > -			&cxld->platform_res);
> > +		dev_err(dev, "Failed to add decoder for [%#llx - %#llx]\n",
> > +			cxld->hpa_range.start, cxld->hpa_range.end);
> 
> Minor nit, should we add range in our debug message?
> 
> +		dev_err(dev, "Failed to add decoder for range [%#llx - %#llx]\n",

Sure, but I shortened it to:

"Failed to add decode range [%#llx - %#llx]\n", 

...just to keep it under 80 columns.

> Otherwise, looks good.
> 
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>

Thanks.
