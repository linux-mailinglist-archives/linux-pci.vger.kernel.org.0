Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9556CC74
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 04:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGJCks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 22:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGJCkr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 22:40:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D713D5C;
        Sat,  9 Jul 2022 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657420847; x=1688956847;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F4s4McOy4Pbu059eZKR4uUT5dMt8oeyXn+G7EXewuaE=;
  b=eVVMuxz44myLvA351aAF5HfnU9eohRAQ+F0RTgHNio02UtWC/ZQgJFv6
   iocrlrkrC0Vc48RVcH51gwayhsLTOGKcmnNt4QIbepSrc5+vt3oIGtr98
   PyvXamUvlAoaG83tJOYQIOesUbNDPEj9HR3gM5FvFp5/aWoErvpVnK9RW
   g0Z9TPHh5vHCgLeZp0a5Syi4ms0bsCxM9pF5oagIRq3Meg4nrOZ93331A
   yHhZLKB/dRzR3e1zSbk3IroDxHAlpWia0ukzNKmkeP1Ifi5WnYnKXPuRZ
   UALIQ/cAelTPiyShSaMmFQMyu566w31Lp31nzDg/AhXbenDIITChvYHR+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="285218744"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="285218744"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 19:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="840656837"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2022 19:40:46 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 19:40:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 19:40:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 19:40:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 19:40:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koHFxPHENUl5+BfU4qPpJw/4Og5FEZbQdFkzDot1TiZ2Yn9M+kSCZKvKKqv4J26Sfy0L43gixo8l5vrcYfUFa6Ck2iFEqJKCzGttl+ZJ3+ku80v1bhEmA8rWEFrft98I2j2+p2Ujt8FutZI2iNLeqdcINi92vNHi25Xhv3Wa0es6W0wbWfqr84x8kCA94/5rMvkpG081FX10AV/+5WC3JBZi9+hdlxZjFjz7lsQHGnYz4hpdmeSgtjU5/B0GoRgiwaCA7YogC64cx9m0kFpjDCO8nadg9CFMBmE32NQ3dMN/lU69ugbjhLWKNV4yZwICQrcah6wv/pRmi8tmsz7LAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSPReGm4ofyRXof26Jy8tAU+5QQ8mKc30/Sr4wohg70=;
 b=E3LB3Mb+H1pAeIRe0araIZBeAY13liFHXZPYD8jLzLinr6SHiWGFGJKgDpWSNYytbdV3VCds5Xe2Wm7sk/JvERjCojfdKKFmhRzH1X1ZASbN7N5nv1xLDnY6zJHcMDotvDUccJTlUT3/t2mnjer0n1BYcGIh2jT6yQ33sFj+qz+Wz7nUtga/oLIn5LcvkgSr8+SohyZkRgyqflE4XBnrK5HkdFIRKzPvaDhCyA/26yxxwPFo26Fpo8mzzOOPLZa1XMJ2+/j0swnt0nJ94rn9VFj9khxKPUaD1IfJ1ey0DTzbpvTfWu9efXZoiIgyIGFkXxoamcKVBfkeQjphNhmN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB3908.namprd11.prod.outlook.com
 (2603:10b6:405:7d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Sun, 10 Jul
 2022 02:40:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sun, 10 Jul
 2022 02:40:43 +0000
Date:   Sat, 9 Jul 2022 19:40:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 11/46] cxl/core: Define a 'struct cxl_endpoint_decoder'
 for tracking DPA resources
Message-ID: <62ca3c2995c1b_2da5bd29450@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603878173.551046.17541236959392713646.stgit@dwillia2-xfh>
 <20220628175533.00005da6@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628175533.00005da6@Huawei.com>
X-ClientProxiedBy: CO2PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:104:5::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0e8b0db-713e-416d-eff9-08da621d9582
X-MS-TrafficTypeDiagnostic: BN6PR11MB3908:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3JhSKevYWcNQ9s3Ag0X/5+y+YRFy7gTaTo5yC7F6gyf7gxhMpEMAcs0Xp1pR4B6WFFW0Dkz3uGGAr1QQ/+aK7JIuQpTxQJVi9Wq+M/nFgEKnLV67Qpt/6nIoNfciaFaUF07kRwf8qPln5vbgJmkt8c4Nju4sY7/xgXjgOvG+Gzuy/tiE4mhN2epsbi03AviHNGaN9fJA+hQSNQu5FlbxuRATzhWjs7MfSCRNMhRcXz/E9KOWMNIOrxN7JGJkgX4wGCVy++I+Lnxgr95isRD0RJr+Nrhw63COW2xjG17z9OSNIVkfgYzkOICro4KicqnM4fpOVFAQa7w1nH7jeTTI9FRV3OirWfJKmXNuZg7TQWYp3otecsRBg9YmnWV+PST9SfvWIp2t+6OBLJQjrRXd4I+TM/OqteXl9RyexdhGCZtdkP2OcYg16pKk5lmKGFj6ey1PJYb37j8lUqhR5T801elbgla/3lDTvMtrp2D1lZ9BFJmF7y4+pWA+pfKPRr9W7h9kaPRLysE0hdt82Agys8MM7vvGFyyZrsvD6pgxwHpBA+HRHFIfSkFg8vfUSVvcNTWLFfhuZOIZXgoWFceBraTDk8mgoDBSgULBsHSL1r8qr9xfiX81k+jisvzBjZx4sOxylZHgYnA4+s6nwbnC/sfBncf4RhYvcN7k7mnRv9Egi8LlxLYHETeMwKvowtd7qv1O0IJ3mcU0Yohbq3WkWqIsCe+EGuquqvqnWwwAv6cWrE6/xHVGnO3jQwwXaEivmrcpCNo91h9blPTrIlPGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(366004)(376002)(26005)(186003)(38100700002)(9686003)(86362001)(6512007)(82960400001)(6506007)(6486002)(478600001)(4326008)(8676002)(8936002)(5660300002)(83380400001)(110136005)(66476007)(66946007)(66556008)(41300700001)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOzyo4Xm8B1KMVr7Gy2snAS+AZ8LsRGVmclmJeCxh9of8d0Cxx/Ph/ZTJ9dY?=
 =?us-ascii?Q?NUsicxKrNVlA/TkwoTUaANB4dWvUUnoTgrTFkkBfKNu4OlBk7KPua7hUrfr/?=
 =?us-ascii?Q?vP1zXX+XZ5bNdPRXTtHig1p7xeG/3LCO7YJCbiPwBjA8gKL/j+b6lD96Tge4?=
 =?us-ascii?Q?n4UChKbM6M46WXp8fqZQeClCdN8K7V2jEJBM+++7C+Hh6Qlj+aqieGgUNjM9?=
 =?us-ascii?Q?aex3ZbNzsFrQx2Szp8TCDslEXHA3+wk1Ac+R6PaM0RMLi8gwFndoQWddQvnr?=
 =?us-ascii?Q?srm5uwOk4Vn4KFCGY9J23K/4HG70NAEcTdPzVXv+JKcvY5Zmyv6ZVgPJQxjy?=
 =?us-ascii?Q?bqMr5X1XftQOgDMT5wm1sAZEmK/1BHmirAhBED4vDsjPalvjp85PNryky7Ho?=
 =?us-ascii?Q?70z/fTOytddZN7SdEiztTIqYziCrbIijE3LNpPjOyCq5HQ7G0r5qq7asTruf?=
 =?us-ascii?Q?sso5cW3Bc+ix75oCIHYu4A9ONFpzvcIlV+wN4jrF838IFMu0rf6bXAW3xv15?=
 =?us-ascii?Q?GNPa2DjT3gnCi2x6cDGtyuLIEN4YEzMW9mQQWya8LhJdp/0zQ8M3W6rd33RD?=
 =?us-ascii?Q?T38zrNza37eHZZSMjgFQ/EntTXaavE1zpbTDpHgMGrihq3RZRHwHe/R+EosN?=
 =?us-ascii?Q?TzCKBIRhx9xmjFBDJ4GEK+dCRzs+u87mz5AgD0zKllbv2jDOBXABrTYKByxd?=
 =?us-ascii?Q?Ihr8l7FRoBwt+gWQxEI1BuTvqfGcB3xXNp0Y4x06bsQ/BBaJN7mspbaLKBDG?=
 =?us-ascii?Q?Roh3BisllkUN8rms3xXsPLurW76nDKtBO73ODQMQAzONzAd+JhmEE5Wa0hv3?=
 =?us-ascii?Q?wk8S+DC1xyec4j2iMLJyyc0u0+juBNrPBUEe333j1u+ZJn8R5Cb3qqIej2o0?=
 =?us-ascii?Q?uF17/xBwmhAn5XQuEBo9L0LATOLi7khf5qM/S1V8pCD34EfpgdL7Xfe2YhG4?=
 =?us-ascii?Q?bbZIcburbaQn8aoiFWhWLV17Xo2ywRmUwK/v06e5QmC8NyGXRur7ZABz1oA3?=
 =?us-ascii?Q?/QNX/aPDS3sfVk0bDrEM+AyEAO33vV1D57fAopldvoyQkCbtao9Y6tPrlB0T?=
 =?us-ascii?Q?jaXFGId5YZzf6T+inOiFdCgcMskiG6AIaBDn6NkyCGpEIzwPzTJBO8Lkb/p/?=
 =?us-ascii?Q?RGsI1mj0nlHVhiWBADaOZ0vFMhjQ23qVQYSrpwXg3/WFYqSj/RASeDYdVQ46?=
 =?us-ascii?Q?hn8ztokeddLqaFbR7DC7G/hERpCC6apHsv8PrRjiWNZLr++nTvQL1ccKGDL1?=
 =?us-ascii?Q?dkE83yGvsikxJAX0cF6sPIgQT2LjTNKTbDm0sDF2Q2GXu+s84SwrpT9WMwIU?=
 =?us-ascii?Q?p7pWyAT9JVUUGSs+fEfYV/bCmy1sK4QOjhi+8pfra3k2o8S6DYLqSYLEtMlv?=
 =?us-ascii?Q?/Ga8dwaKE3CKPvQPUVEecaR+myArSxsF0rBG6lPA5quT2JJW/XoJMeFqz7A5?=
 =?us-ascii?Q?JQUEL9+QyUiqInCxHFyeAarK158V8Y7If6bgWzx1RRSE8XrL7jKCcT3wtzXh?=
 =?us-ascii?Q?TCZ3kxHzH9YwPeUIoZlV+aHjWz3KFMEWzXYbqaubLKjM8ZkbF/RS0Eve4pZe?=
 =?us-ascii?Q?df0GXGoh4c4EIyQ7JaZ88Qv2ByRvbcQgu7213Iit/ii0uTmPZYgtZCFG+88d?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e8b0db-713e-416d-eff9-08da621d9582
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 02:40:43.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm949jZRztOZ/lTrAy7KlqVCz1nFWg6/grz26D7wSB2LljAtPTipJ3D6l4Jw1ynfed+/jssWkgj3G89hm5h5RwQy3s+WF7cXea4ePnJI6Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3908
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:46:21 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Previously the target routing specifics of switch decoders and platfom
> > CXL window resource tracking of root decoders were factored out of
> > 'struct cxl_decoder'. While switch decoders translate from SPA to
> > downstream ports, endpoint decoders translate from SPA to DPA.
> > 
> > This patch, 3 of 3, adds a 'struct cxl_endpoint_decoder' that tracks an
> > endpoint-specific Device Physical Address (DPA) resource. For now this
> > just defines ->dpa_res, a follow-on patch will handle requesting DPA
> > resource ranges from a device-DPA resource tree.
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c       |   12 +++++++++---
> >  drivers/cxl/core/port.c      |   36 +++++++++++++++++++++++++++---------
> >  drivers/cxl/cxl.h            |   15 ++++++++++++++-
> >  tools/testing/cxl/test/cxl.c |   11 +++++++++--
> >  4 files changed, 59 insertions(+), 15 deletions(-)
> > 
> 
> 
> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 6dd1e4c57a67..579f2d802396 100644
> 
> 
> >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> > -struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
> > +struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
> >  int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
> >  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
> >  int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 68288354b419..f52a5dd69d36 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -459,8 +459,15 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
> >  				cxld = ERR_CAST(cxlsd);
> >  			else
> >  				cxld = &cxlsd->cxld;
> > -		} else
> > -			cxld = cxl_endpoint_decoder_alloc(port);
> > +		} else {
> > +			struct cxl_endpoint_decoder *cxled;
> > +
> > +			cxled = cxl_endpoint_decoder_alloc(port);
> > +			if (IS_ERR(cxled))
> > +				cxld = ERR_CAST(cxled);
> 
> It's my favourite code pattern to moan about today :)
> Same thing - just handle error here and it'll be easier to read for cost of a few
> lines of additional code.  Few other cases of it in here.

Done and done.
