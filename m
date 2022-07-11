Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A723456D26B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGKBMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKBMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 21:12:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89129581;
        Sun, 10 Jul 2022 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657501931; x=1689037931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k1q7TxZu2fbE1JZxmDNFG85wyYRYDAKBhSa7THEC1wg=;
  b=cEopxKbl32m4YTeGX+l9H0+PgIOUUb/XEhv1MHtJHZSRV3tNTPEhTfC0
   fLeFuJasr2aAZEt6CpPtD/IPOEu5EoAWF+mLxtpHsJ3eb30BUGerkTivh
   OAC9xDwL6YCRlNUVZ2bipjIjplfTxrhpySTrzmOYDdFpotZglmTdhGURt
   I2+Q1mXa9ibMMG7yxLH94HLtlMIigsJQX7Lqidlt8gWJWgmkhLb8wtKMe
   Vq+pKW/WVvcM0uV41yF7c7kWD9JxPruf6KJ0FcB9CQzcf8DaRkerFO9G4
   WyogFwa0CP82m+2Tj66tAQwiKcz7kBkN64jOhBSQ/vbRp0Em0NRsbdfzG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="310155063"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="310155063"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 18:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="544827826"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 10 Jul 2022 18:12:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 18:12:06 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 18:12:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 18:12:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 18:12:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC6uKo8KLXNNtml4yTWNnsIw5SrNFIu6EdKR79TFJNW15aGJWsZ3Y69o/jA/K8JNNXximvTn/ByZIhpgp+nOEe9Ny2quoXdJh3uSKuCaxgLvkMmL+TNDlEQ+upexuzg8n+Z8DHKC6W9XYqGopYPV5bKL4QJ+bG/Mvpk/e8P3U7eqjTkKnekC+Ye58qRHPmjg4wUj51I7ctjRugAAE+5Q4mvFTxmY1XkyEXeZ2cF9C4b/Irrr493fP7v/riWxIgHPmv0b0SayNIsnrxlVDhwMGx925gpN8psZtKjpCtnSJMbtNAsliwyBt9/It1ebKVbcNYIloVogNvXCAwF5sCve3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH+a+4d829uPk7kpGK2W1fpWkXuM7SFA3CxD9t4d/KU=;
 b=gi5M4FmQCwZaLlsR+I8/5XDKlG7bTPZ7WJJ4v/qHXCSVM1MC/WsUBOPxAFDbFZ50KB+uE5z4FSl2Sy8arnjJj0dv6JOKpkRG2W6RistiNLj3WtdebcblU67BHIk34A1j2v0TuHFN8YnAlKIMRJLLbowCriT9fVjhR6DRaoiKiOKE66ftMUx81cKYeFr13b5rCkWiVP/sAMAJlHkAYqMBlgrGHNFrX8IbpdNll2Xcz8O/b//GZrf6BrlQA0X6fmXzUKk40DbSNIgqf8wSn5A6sqjK3XXowIJYWhToggOI0oKJoi7hOrdmPxRwH3gxtgk/HUmfJII3XVjK5xdnFk+5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB2028.namprd11.prod.outlook.com
 (2603:10b6:3:d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 01:12:03 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Mon, 11 Jul
 2022 01:12:03 +0000
Date:   Sun, 10 Jul 2022 18:12:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 38/46] cxl/region: Enable the assignment of endpoint
 decoders to regions
Message-ID: <62cb78e0efc25_353516294d9@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-13-dan.j.williams@intel.com>
 <20220630153150.00006fa2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630153150.00006fa2@Huawei.com>
X-ClientProxiedBy: MWHPR12CA0041.namprd12.prod.outlook.com
 (2603:10b6:301:2::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e58dd05-924a-4131-77e4-08da62da5cf3
X-MS-TrafficTypeDiagnostic: DM5PR11MB2028:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBlchbOvgEOHe7S+CJS146GeYmPGHxThNCKbZ1IhgkHEavSeeaH6ajH5DxKv0CLmgqRHYdddVW0iv1JJokP+6GXqSt+9AH8RKKVSuFxHttAlpoGLce2+9yAT9O/ul4dToYX/ETBqtF09W63JnXuoPgqirQker88vqdFlUcTeP+EtopzH/PEbqvU50CGTPDjOZANiR6ZlcdTNwO1EHeE+fKuICKR8qYM3AFo1pas8p6ubWni2YqBfYXoVym/UYoZRiQqb2qlP9bIQQbQv78i7MPsyYKMrsBZaAK8OGpY+TcjD5jaAqhG5DFyhmOdsypfM65Zva7mPskL3dssOcD5YdbY5OZLqSgaZqHTYgWQkcSIhG2micbp4oo0M2Cb0G673kvAhpzbWvOnOPlkSaO8/HyyKXktqY4TxASkT3+UN3u9NGAtrBGEn+uaQCwJdlnMFVyq6891OSlbtuDarPWhZF9zxOgPLH7k43PUJNj64QNbnzk3QWcpiHoIDlMenYueU+NU765fET6sORSChDl/tDFzYIF0i0XeJRwXUwKjKHNHPdg6qU1r+J5pM8optF/IUXqlq+jwcSxRdXXmS3XTJ0jZmX2W1drdop5i2oQDKAMjAIskhysv2pyMqAvnYzPsVm9BaKwbFD+Cw7YhvBWGpi5kLJryqIZvs1opXtDS/qsOIDx66/XWGxji4jTOcUnrlDbVd9lkVSilSXdl5dsHyyqaXe99liLYmRI11ttMaCqT1noYsPfM+Q52MupdQ2CDg0GWBkwgb66PshVzEfjKTyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(366004)(136003)(396003)(83380400001)(66946007)(82960400001)(186003)(26005)(9686003)(6512007)(6506007)(6486002)(478600001)(86362001)(110136005)(316002)(4326008)(8676002)(66556008)(66476007)(38100700002)(5660300002)(41300700001)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4B161wLrqb/B419ePy5n5zEdC9gfmdw1Cs5tCZ/aG46EPCbWafIsJkv9VvK?=
 =?us-ascii?Q?sWDbkGVgn+ar7E+9Pq69+SmewBMyoHgRz17ZdqfX2FLgB+S1p2pIiINva6rR?=
 =?us-ascii?Q?igO9BKcziPcV46tNK37RTEIWvxQgOPGWFGukRQJ9m1Eh51rIfbOsb2/bSobj?=
 =?us-ascii?Q?1MTjyY4T5Nh65/PPrKNfZe6NhC4TJUKHJeq5a0xHTrfMK5KLengb+jx3e9xU?=
 =?us-ascii?Q?FKOYZ5HYh7sHFkJCX3rL+mHeGoL/XGdNClH/tsU8HU2aCvW7Mi/uNbEhHjgH?=
 =?us-ascii?Q?y4RSK4vP1tzDOIB/LyiPmgTy0Az9FULSqgs59LUURTpQdxzzj8QLP6oERrP6?=
 =?us-ascii?Q?pBa+rSmRMovhmlmLAVNiyD6tUwudCxpWDVkQCnSELqAG7j0VCxqp5zQNXgiT?=
 =?us-ascii?Q?4bV4jnm2h9vc6FXShmuD2n2lcf6S7E9MdXJMT67Zo/4kP83SK9ERHeJxb7gr?=
 =?us-ascii?Q?PivyJSQvEmqAkVv2ekwYOmUvnHPbM3g1t1yI555PNmt6jvCQMpsvKcAlghC+?=
 =?us-ascii?Q?oFULUhb0gLmLcrLUlymmHqa75VaIq8N6u8jAK2qCgU1b8MugeexLgRz+7ssJ?=
 =?us-ascii?Q?lYPm1indi7kc+qbAdtBSxCBM/z3VMPSyxrxjw8iZ97M39fn2uEyX5kLPPy0r?=
 =?us-ascii?Q?4ZIG5ILJ0QEM/yU7OQBrtfWGfTyd6a4L9gpuVUAh4/bTtp2SuWh2z05/iEs5?=
 =?us-ascii?Q?9ExWO5C9ngwZLUAuIIrfxzyfSQcatVOtIQjznTrGINe+4CTRa+bit+93DWuX?=
 =?us-ascii?Q?VTaoA4b/LcuUrn1crdcuzXDAPeiaZhfAvMt4qMA5kPxZ3z+bt3HtWxq9Acun?=
 =?us-ascii?Q?NgujO7TLBV3YeucoI/uz5cqiGRPLqorSTE9KNt/5UfLUNnrGMKsKvdXM2RRf?=
 =?us-ascii?Q?pR2ltWtIuHY6kG5TKeROQc9QROtRTMDtoDvLfNo7uQ/J2I+52r6J/ecwLrqJ?=
 =?us-ascii?Q?4WISNltH5Tyut7uFl0Mn+Axwh3Z868f/9bvJJkFmgXRiUgkfddCcuUtUMxwX?=
 =?us-ascii?Q?ZQWLELFsqkcqGlKBEkaJSOt37inmYs9RtBrvVqS37Wfr2ewawZ9o0S8/JgOP?=
 =?us-ascii?Q?Od1GA1HUsr6Ec7ZkbknotW3pTAhGTy/12jXLP0YBqzGN4KeGrOUpor4Q8a9P?=
 =?us-ascii?Q?UrZpghCUAmhyj05bXf9SCTppGgWj8ierE4Nb7H/+ZMU+TZ6ZGyWr64PJqLY4?=
 =?us-ascii?Q?+rZe3DDwTrCxE3Ud9cnmTo4H7MrG1YzLRF3E/ban0FzN5tlwt/WDgNuhUBKE?=
 =?us-ascii?Q?FYiYqrPnHH0TJ8kI1hvKeW4NPZASgXu4QG7+SZu85k6TG4X26f5FiCxTmJ4x?=
 =?us-ascii?Q?1Wf/g5hhsI7SCRu5X0/el4NJubYRtcdt4vblFsElabisQIMtTPjacW4jtwds?=
 =?us-ascii?Q?yuFVQPLAbEZjsHra8RC1Qz8ouZk06UEqC/ljHXPSzmZYzykH2IrKgMagwtnw?=
 =?us-ascii?Q?nlyYauFOIaruHbF6JTSH35xb4Kvc+K+d6zt2l6avPbjDiRLspwn/aLi6Kq/4?=
 =?us-ascii?Q?BMVSlThbeMuhzsGUvwezCbgnjY9bAo0FVtU/klbR9YwBk3Zl/BImwXexcWxj?=
 =?us-ascii?Q?6H3qHbbuv8gvIl08NdvXZ1gCKF5UmkC/HbH1pawvcNNix0RUQKBOvMJTXywB?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e58dd05-924a-4131-77e4-08da62da5cf3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 01:12:02.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoULMYeuUUQxe0eCFcmGQdycrBqGGkScPr+zLQlytojENnsReuIKs9dtQ6JPmdhorJd1ezIyu5JV1LNeyPvUpMVmq6LmgghGHROZ/c0zExU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2028
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:42 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The region provisioning process involves allocating DPA to a set of
> > endpoint decoders, and HPA plus the region geometry to a region device.
> > Then the decoder is assigned to the region. At this point several
> > validation steps can be performed to validate that the decoder is
> > suitable to participate in the region.
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |  19 ++
> >  drivers/cxl/core/core.h                 |   6 +
> >  drivers/cxl/core/hdm.c                  |  13 +-
> >  drivers/cxl/core/port.c                 |  12 +-
> >  drivers/cxl/core/region.c               | 286 +++++++++++++++++++++++-
> >  drivers/cxl/cxl.h                       |  11 +
> >  6 files changed, 342 insertions(+), 5 deletions(-)
> > 
> 
> A few fixes seems to have ended up in wrong patch.
> Other trivial typos etc inline plus what looks to be an
> item left from a todo list...
> 
> ...
> 
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index a604c24ff918..4830365f3857 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -24,6 +24,7 @@
> >   * but is only visible for persistent regions.
> >   * 1. Interleave granularity
> >   * 2. Interleave size
> > + * 3. Decoder targets
> >   */
> >  
> >  /*
> > @@ -138,6 +139,8 @@ static ssize_t interleave_ways_show(struct device *dev,
> >  	return rc;
> >  }
> >  
> > +static const struct attribute_group *get_cxl_region_target_group(void);
> > +
> >  static ssize_t interleave_ways_store(struct device *dev,
> >  				     struct device_attribute *attr,
> >  				     const char *buf, size_t len)
> > @@ -146,7 +149,7 @@ static ssize_t interleave_ways_store(struct device *dev,
> >  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> >  	struct cxl_region *cxlr = to_cxl_region(dev);
> >  	struct cxl_region_params *p = &cxlr->params;
> > -	int rc, val;
> > +	int rc, val, save;
> >  	u8 iw;
> >  
> >  	rc = kstrtoint(buf, 0, &val);
> > @@ -175,9 +178,13 @@ static ssize_t interleave_ways_store(struct device *dev,
> >  		goto out;
> >  	}
> >  
> > +	save = p->interleave_ways;
> >  	p->interleave_ways = val;
> > +	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> > +	if (rc)
> > +		p->interleave_ways = save;
> >  out:
> > -	up_read(&cxl_region_rwsem);
> > +	up_write(&cxl_region_rwsem);
> 
> Bug in earlier patch?

yes, fix now folded earlier. Good spot.

> 
> >  	if (rc)
> >  		return rc;
> >  	return len;
> > @@ -234,7 +241,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
> >  
> >  	p->interleave_granularity = val;
> >  out:
> > -	up_read(&cxl_region_rwsem);
> > +	up_write(&cxl_region_rwsem);
> 
> Bug in earlier patch? 

yup.

> 
> >  	if (rc)
> >  		return rc;
> >  	return len;
> > @@ -393,9 +400,262 @@ static const struct attribute_group cxl_region_group = {
> >  	.is_visible = cxl_region_visible,
> >  };
> 
> ...
> 
> > +/*
> > + * - Check that the given endpoint is attached to a host-bridge identified
> > + *   in the root interleave.
> 
>  Comment on something to fix?  Or stale comment that can be dropped?

Stale comment, now dropped.

> 
> > + */
> > +static int cxl_region_attach(struct cxl_region *cxlr,
> > +			     struct cxl_endpoint_decoder *cxled, int pos)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +
> > +	if (cxled->mode == CXL_DECODER_DEAD) {
> > +		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (pos >= p->interleave_ways) {
> > +		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
> > +			p->interleave_ways);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (p->targets[pos] == cxled)
> > +		return 0;
> > +
> > +	if (p->targets[pos]) {
> > +		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
> > +		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> > +
> > +		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
> > +			pos, dev_name(&cxlmd_target->dev),
> > +			dev_name(&cxled_target->cxld.dev));
> > +		return -EBUSY;
> > +	}
> > +
> > +	p->targets[pos] = cxled;
> > +	cxled->pos = pos;
> > +	p->nr_targets++;
> > +
> > +	return 0;
> > +}
> > +
> > +static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_region *cxlr = cxled->cxld.region;
> > +	struct cxl_region_params *p;
> > +
> > +	lockdep_assert_held_write(&cxl_region_rwsem);
> > +
> > +	if (!cxlr)
> > +		return;
> > +
> > +	p = &cxlr->params;
> > +	get_device(&cxlr->dev);
> > +
> > +	if (cxled->pos < 0 || cxled->pos >= p->interleave_ways ||
> > +	    p->targets[cxled->pos] != cxled) {
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +
> > +		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
> > +			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > +			      cxled->pos);
> > +		goto out;
> > +	}
> > +
> > +	p->targets[cxled->pos] = NULL;
> > +	p->nr_targets--;
> > +
> > +	/* notify the region driver that one of its targets has deparated */
> 
> departed?

Yup, thanks.
