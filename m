Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E169856CC05
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 01:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGIXd6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 19:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIXd6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 19:33:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB54B869;
        Sat,  9 Jul 2022 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657409637; x=1688945637;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8JzDYKGpTrsJXAbhQYKJ+MItyA6jvBawhIa1U4+YvRg=;
  b=RtPmHW5lPWCDjEEq+H+3Kk+9aLtEXxGSUhdbHlEWatRqTZL1IQUbS5Lh
   IM+Zf0yDrIpb021TTu1BwLOWQiFuchxvvCsQag1KO+rG4zrcLA9+KquDZ
   mmvbSxmR85oBQx8JTb4nZi8IV43Gk2y8BSDHrifjGF8tNc8Gw6WNlqqXT
   Pdz89Mz5PMqsLdX5ANEo+1qtpErDE3L3eOZHjIk8A5mcENwiDOYrv9+bT
   wbzS4Anr433UqZBn8Enquy8LWla3EcwhlY//9iat6hQzeobzkUSC0RIlS
   5mg1SsvJ2be+bZPCgKLFBXMCNdG7s6oaSRHfAkG9x12LAMOIVQBQpbDKX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="285209661"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="285209661"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 16:33:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="598681014"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jul 2022 16:33:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 16:33:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 16:33:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 16:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpbzZHOfBQkFy+5JtycZOlV7ah4hmFUQTI8me1Y+ofd5fE9ro3uK57X9tNcsiij87an+AAgLR7jooaV+FwxTCahm7+deMMopF2bFjMJ637/GGMt3h9TVeo6VAkNxy0IrfBooGy/Xb0GBYgmRJOvkJ7Eq/bsDu8NY2Jms4LIH3e0l/bUDExO3ZuFVx7qEph+3vrLlllJ/GpVDlAdASrujfin6qxEn/zcUgesDKPtXmE68b4fGyqhg7p9lZcPse5kkivOqJyuBTCayTItckQKUZcZFiO5g16o0FY6DnpquwBWVcYL1wlkUz7xI3kHQilszWGPLdVfZ1oMf6ovMDhuz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en44ig/gnCVMWSrpgMr1y5oqUgaf0jNZ82UFWQoxOAw=;
 b=M3W05fuxqOXycwr4qs3DPJiDhYSH5Y2xSItnwJ4Dy6VJQCv3kWNrTx0M9cJB3zMEkAZYpATO66W+g34/6U0pxI4wnNC2jQsDrAhlkWAti+bJFyVwJIK1YHvMYWSJHDC9A8GGVT6uxPz7jsps7RRM/vDQd6TZzdPrWwqvr4TK91gB3r1gc09aki/uLrnuGmrxQaMrKAn7jG5Q+nO0cn0MioGdCX7SdujdsIHnNjgp/9ImeIkCgyhlFHPFwTuzFvNLegTq4W8EwLA10BZZrRFCFQx2fjl0Kl3EgzZtCRmQXComh0A9zA9hgsS9kJDhhooc+gat+By84IHjTxkCFQkP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB5992.namprd11.prod.outlook.com
 (2603:10b6:8:73::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 23:33:54 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sat, 9 Jul 2022
 23:33:54 +0000
Date:   Sat, 9 Jul 2022 16:33:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 05/46] cxl/core: Drop ->platform_res attribute for root
 decoders
Message-ID: <62ca105fe1679_2c74df2943f@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603873619.551046.791596854070136223.stgit@dwillia2-xfh>
 <20220628162445.00001229@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628162445.00001229@Huawei.com>
X-ClientProxiedBy: MWHPR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:300:6c::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff82f331-cddd-4958-ab9d-08da62037c73
X-MS-TrafficTypeDiagnostic: DS7PR11MB5992:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SybPDB3WhiQCvA3Dd7YuCu1BECtLMGYxTPXWWJ1zzzbEZ42aPfopzyyrr7/rYORueiGBFEY7Wv0/nrbopoFm5iYN/nmMN1Fw4FlLIFJS7kLrn6vyMPR3FwpFUwILPHhLlUjaLSWOLU1QUNg64uTYC1ufZzmvHx85xjG9QJzwlCE+HEzyMFmfLnwdSg1fiewrQ2Zu1qJE/HFHa/+kQHEE/v0NOdGN7EbKGbWMVt7Y3VRt4KLE1CScjdYjwKS/cAMPG+Pb+jw+tAfMyL4qMp21tFwT76MQosPnm1b8J8TdGNITs43QcgMSy4dM1NneaEHbBCvoof/jOUy9gpSHoyETX3HVp9oP72dlfspJNtabuJ3JVfwzL2/CKZdGksRJa4g5pAYGJirEdnPO2BnhGzrPj/2Xf7L4UvtynNNxvXiAvNU3wd6hX9FyH927LWt+tEfZNRLJlCaSXqFvZuNTQ5mWJCbsaPzwTvR/gy4+pziOn/U1Cz6JgZbb43/M9SuuCnNWDEXe/12Z+9g0dTTQk+Pi4tNb/W7/9C2NDt6q4yfL+QF59LX+ImR8Hd5C59e9ZhMAHglhW567jiC4UAnPh4VFBG3Ffb3Rq+1wSiEIzZsGt61/AxlwBp7HMfmmaaV3x25KRrIeYH913i++/1TlTkjMGDR4OTn05SbMQtcU8ZF0MUCrK/xyjwxIOMAED8bLYOa6E47fR3NIVjzksH6QR5+3+q6YYhk2p+wbVdXHq6zjt/P8EFpCBhc9F3Kr/QLjMKwWsISqxuVUtO+ZGmgRRmTLUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(136003)(346002)(6486002)(478600001)(8936002)(38100700002)(86362001)(186003)(8676002)(6666004)(6506007)(41300700001)(66556008)(4326008)(66946007)(26005)(6512007)(316002)(66476007)(110136005)(83380400001)(2906002)(9686003)(5660300002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqzo04Hg9qU+ctr+yWgAwkcElE1d3FWIBaoGBaJy3NROrqZO+B/iGW7CiMD1?=
 =?us-ascii?Q?L8LEUsPbf50cHQjEwwAh2XAHXj4bPCNxrk6qSCweoaZ4X+vLVm/le6dYHPab?=
 =?us-ascii?Q?lFN6RXQDrXlNFqTUWujLSdi3gbdhQ6b6TItczpz5WVo33RvoSHgohm7T1Rfd?=
 =?us-ascii?Q?vI7mlzCPxw59+1RcaeiMctMh3WVTOyJ6ci7YyGmUURF6KbF+tJwqKL3fbtok?=
 =?us-ascii?Q?+nV1zkQcEVk3c4qvMukHMKhLa+GiaJX++hp+8p3kwuxFgxtSBHqdeW5jRJgb?=
 =?us-ascii?Q?CEi+7rJTnKyg/3NnfTR44ChNE8o0IHxTAbprYpDWzxG9f6AM/qh/vqUEkrhj?=
 =?us-ascii?Q?OzGFSDem8lej1hVbm9UA4n2D9O8OrG4RYowhZ6qhDaSe5Ywj6u+6/kqhaioC?=
 =?us-ascii?Q?IP49hVRX7Di61nntOGMMvXc0gIvZKh2u4tDFy2qrLZNResIN9w9/yCjpG46C?=
 =?us-ascii?Q?ybJc5c25e/HV0GH3ul9aQS9EHRZHrV/DVRGVvcxB8GhHt1E+SVdMZq1N6bxZ?=
 =?us-ascii?Q?62l1aY+4oRVbEyU+4z1qRP74URHO8tCBPfttcETa5kus/Hu3hw4cZI/BakCV?=
 =?us-ascii?Q?V1hzfrxLOOK3JEzthfViZsS7QZfj5sQRyp4rL06IFZxn+pxY1tqGwbEKsRjb?=
 =?us-ascii?Q?LIZZGLb8tKmgpyIggOZMz7GKXEj+XdtqwC4hrAvOm8zcShlHVpG+caI7rmK5?=
 =?us-ascii?Q?cuIM0+c8XIAWfLVZFcgzRR3NZJ1zoGCMA0jTW6iZvusSgqHNYDDrjBjjjJe7?=
 =?us-ascii?Q?Ci5AuutCjHeLLxpqpPra6QUjejn/6C5jg39pbUxs4rtw6218xEEQ2xSqDT6O?=
 =?us-ascii?Q?mhZYxVRWrVzmI1FoVKzqzAI2VtsVOMZ2rTL9V+bnDXmN/mXTEw8hQjuzhTVL?=
 =?us-ascii?Q?Rs5itifps/W5SI0mDnlY7rWwM8qOSP2VXaKlnUsPw28ZLMqLixMO/S9BiGiN?=
 =?us-ascii?Q?khaPFKy6HEdyuOabBjtwK1EvVCdzmRpR6olfrhi7Zmr9DMLYD/IM+jrTdZvM?=
 =?us-ascii?Q?SxL6rrVzgMUcqxU9VRoNnWRU8QvOaQUzMPZk3mEmDGmPifLyXSmspr9RgoF9?=
 =?us-ascii?Q?V1058kiZr6iD0rVuMhs5J5r6tVpfMDds9cGErT0xjl3erqlazGtACYPEejBd?=
 =?us-ascii?Q?r0ptxYISJYCDfVYxKyGnn0byCaK/UdkshMy+Y3S4rz5qiOBd7E4+k8gL0YUm?=
 =?us-ascii?Q?P3Al7CnEPqE602UdJMxuyKpdxhtzCEic6VpJAOQrJfVIVMPHJCdYn3TDZ8iP?=
 =?us-ascii?Q?sjtwxQIwtCGiBLflJEX/eSK4EkcYsihFbmZDYzNwZDiV89Lcr3ozONHThLdU?=
 =?us-ascii?Q?PqiHs6kAD770Nn/+iB/kojwVsVRMaEh2YgYmyogRVGYRU9WuXeGUZd3R7G3B?=
 =?us-ascii?Q?/Ds21qVKqaC3ofvrC0OHMQ8ZS88C2/d9CRsUthyriqnROCKJMQpPHp0BqQiw?=
 =?us-ascii?Q?Rs39tJq0hdCViDL0j8ylSWQeYtV+t4aU8ZOQcWeNMJrhAaBxQqV3pImKJcK9?=
 =?us-ascii?Q?cPfhhsXFnAGvZojNF7Y6gaqfKgbfQ0JNqjxWVw5k+D5bfHROLIR/j2TqEpyr?=
 =?us-ascii?Q?/MXyYRTfc808QOWQ6VAaoFeSXGzArDP7wTwYVaE+pIwOI0RO4Gm8DtpKVZYb?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff82f331-cddd-4958-ab9d-08da62037c73
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 23:33:54.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDO7l9Fywpb8lZSQNF0u7YIK6w+eHhur2BolF65hPwEY8XOPhMzGxY8rfYwXk/WGKP5lQZHFzPPU0ztldIHtWirNhMKcz+TBwwoj1i0Ll8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
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
> On Thu, 23 Jun 2022 19:45:36 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
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
> 
> One trivial moan inline about sneaky whitespace fixes, I'll cope if you really
> don't want to move that to a separate patch though :)
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
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
> >  		return 0;
> >  	}
> > -	dev_dbg(dev, "add: %s node: %d range %pr\n", dev_name(&cxld->dev),
> > -		phys_to_target_node(cxld->platform_res.start),
> > -		&cxld->platform_res);
> > +	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> > +		dev_name(&cxld->dev),
> > +		phys_to_target_node(cxld->hpa_range.start),
> > +		cxld->hpa_range.start, cxld->hpa_range.end);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c4c99ff7b55e..7672789c3225 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -225,7 +225,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
> >  {
> >  	struct range *dev_range = arg;
> >  	struct cxl_decoder *cxld;
> > -	struct range root_range;
> >  
> >  	if (!is_root_decoder(dev))
> >  		return 0;
> > @@ -237,12 +236,7 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
> >  	if (!(cxld->flags & CXL_DECODER_F_RAM))
> >  		return 0;
> >  
> > -	root_range = (struct range) {
> > -		.start = cxld->platform_res.start,
> > -		.end = cxld->platform_res.end,
> > -	};
> > -
> > -	return range_contains(&root_range, dev_range);
> > +	return range_contains(&cxld->hpa_range, dev_range);
> >  }
> >  
> >  static void disable_hdm(void *_cxlhdm)
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 98bcbbd59a75..b51eb41aa839 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -73,29 +73,17 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
> >  			  char *buf)
> >  {
> >  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > -	u64 start;
> >  
> > -	if (is_root_decoder(dev))
> > -		start = cxld->platform_res.start;
> > -	else
> > -		start = cxld->hpa_range.start;
> > -
> > -	return sysfs_emit(buf, "%#llx\n", start);
> > +	return sysfs_emit(buf, "%#llx\n", cxld->hpa_range.start);
> >  }
> >  static DEVICE_ATTR_ADMIN_RO(start);
> >  
> >  static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> > -			char *buf)
> > +			 char *buf)
> 
> nitpick: Unrelated change.  Ideally not in this patch.

ok.
