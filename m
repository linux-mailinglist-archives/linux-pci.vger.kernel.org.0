Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15C56D235
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 02:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGKAce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 20:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGKAcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 20:32:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9187662;
        Sun, 10 Jul 2022 17:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657499550; x=1689035550;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AmCszFpCeObzzjwpcXEcerLxQ/HcbhoCIjiu3zyuqOc=;
  b=YCupzoarVckFzXj7G3aL4ZrWp9OypcHre1+bFP6y+zBAk8uCE5A87kZd
   rphI9vJb3FKxLsLJXqxOJiwWazNsjuickHputjgTODuW8vDDWBrKt6VMG
   0P0EzUwAtDcHqpbGi/L3xfstxLMMY9U/NIYaU5/zyAp5WHKdjo5uQ8iXE
   hlWT6lgXJFKca8LCR/sD87NL+GKQQfZ/aPzshKZSVKU1Fwve2Am+HbJCZ
   ZavwyXnphmlRvnmKPudAMsh+MghdJLFDT7x6CXQHJtA8HUXxPWAffXZDJ
   NgsbF3QWbH3AI18SkACqi4Vfnt4lfy/Qgw+iEP38Mw0r+sJAMzmqrd0dD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="310151043"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="310151043"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 17:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="627304509"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2022 17:32:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 17:32:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 17:32:29 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 17:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdlVGUP+aFm9BbbBsD7eW+68Pko/3VyaToVO3KnL8VmGKDm0THpB/vi8b30Xx+Mb1CH4bvqrQAZ0itZMv96Be/B2I7jcQwUIcKWHSjVvBUoF8lmpTCwF36gFxVQy8/If6Zitd6EbnNEylM3auW368f7tUuefkzLfgN3u9wbccap+WFBSIrLUx8gIWhCRBEMrXQNQejifL00gcZZ7EnhfVg0BNaSus8bTZQ9tblLadrKXN/+xcCJsGNXKDGXSKjosoquMpWsqTEBY9QzQp00d5AGF2rTk/DBGssGnGvuOrp8J2yzr0061AjrQNAaecGtQibelTrZoqTKCPBUDuhkPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUWWOwoa79Sa85qDlrGdh9JpFq67kNVXeWCjczT2kmA=;
 b=i7JZWvtPyXSPMxgW67Mmf40yci9cc7uAcdGD3Sk3hffrhAOnxKTe4JImgZWVaTiAz4usCu6WGXvbWDs9kIigOga+sgOQrOZaJ4gDoiq1taL4wc9VgA6ocjvA1Xe9Xq03Cv5iqMpekWYTz8xo8y4x2vop4CClgtApMymxdrLR5d1AVE/zZnUB1DbtqUfBrywAE8fowngAe/avF4QDycMVsK9TPZ7HsX5s2SKjmzT5UC+7e3AumtYy7OH3sU9c509+jlFa64MVpnGArg9DYheAFAMfKa6Y+0XU2Pifj96DS215lfzh/E+zKuHuaio62LlZ35gJpSoQ4LrQN4lUhTwMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6341.namprd11.prod.outlook.com
 (2603:10b6:930:3e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Mon, 11 Jul
 2022 00:32:28 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Mon, 11 Jul
 2022 00:32:28 +0000
Date:   Sun, 10 Jul 2022 17:32:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 36/46] cxl/region: Add interleave ways attribute
Message-ID: <62cb6f9a74b33_3535162944e@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-11-dan.j.williams@intel.com>
 <20220630144420.000005b5@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630144420.000005b5@Huawei.com>
X-ClientProxiedBy: MWHPR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:301:15::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f70ea1c-85a9-4e5c-402c-08da62d4d570
X-MS-TrafficTypeDiagnostic: CY5PR11MB6341:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEfrGNbs7DfJYSGVGLv5GWk4gP+N3Mq1HBrH+xhW/A67TVJLT6ObO+6deyoGf9b9Fx3xezbZumzR1LBgeOOQgXfxYaqm3KZPCMLa32a23OHNwvXUpaLVfyd6C3lwQ8cJJfLBWQeL8qpOB9Rj/wjcsSaLhlHKF8IgiCXRbvFhd3hGLAB5xd7xozWniJ9upuQat4kiHiGVapLvTD5G3f1IR2tg0LdPhbmuJPODsexwWRDfso1FyWDmZhBg7+sYIxiYZaG+JG2hrbZC15c4I37A5NgiLKGqKW2W+mbyhILst72vp9Eli9sFMwaGsYMcmYRZyA2IDsFPIF8OqoOdSqPT1Y1BJ6wAMX8f2QUG4rMigzTByrvd4ZaFs9ObogIoRYPdN8xvoSB+ohngWbvd/apEoIWV0bcnrz5eQIPDDXFfMXXSl63616AWy7o0VhfKsrm/4gNkqtG/fHJoAp/ckoNvwD3FGVwYIajMDp72QN5xgU8MJ0VvFTu5B5YeLHWwOY5cB9dir6HsTlluo3BeHZF8fviNtA/lb/AEpkmo8vkvEyiHoK3EPSlZm0icjY11HpkuQ8fVW+w2vuAJo6isYevJFLBAP/ROT+wT6s2QUrhpknTnHQwTltFGcF93RXdY8TZ3XQHTJHN576BBzt6NqWbOhhvbnY/Xz20/aw947qaXiN4Ni2Jl2gnf7qRVEHZaaCNtZS4PoLL6hpIoFhFxaKAhn65vX8NASY0SlA1TfSCD5p+LmP4gzZlTOmHlrp3wseZnCdSify/j4HaAoplssbPNHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(136003)(346002)(39860400002)(86362001)(41300700001)(5660300002)(478600001)(66556008)(4326008)(8936002)(110136005)(66476007)(8676002)(6512007)(26005)(6506007)(9686003)(316002)(66946007)(2906002)(38100700002)(186003)(83380400001)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JXho58YInZFn7uEUe/wnKUWUzQaNnZovVfjdYKXSNWpZTN8SPhSMpO2sc3Mv?=
 =?us-ascii?Q?X9uv5P5XRvuIH+bvOfUgbK6Pt9wRjcFikFX3S8UwQZg95R/FlN8Y3PzR74q6?=
 =?us-ascii?Q?Y17+IZ3qvP1NU3KnFpFoa1pCOWH0/k5/XU1TNhNJcm0E6eHahVU5K7V5CnB9?=
 =?us-ascii?Q?GEey8vVgAznrpG5eGxx0ZSzm1bDK/kpoETZQ7w08uSFrl583Bwkf3FHQoaP/?=
 =?us-ascii?Q?i1wHqUWhW5ZWQWQNNZOF9yOzK/OVguuwMhC9HdeEHZt4Ds/1HFw59mkjbsJt?=
 =?us-ascii?Q?dJ2n+gNiCkCxfX9GSbLm2DvHjGLhyNWo19E9/5fHvjmB8bLziitH6RSe63Jy?=
 =?us-ascii?Q?5Ks2WFSrOVgoD4X5sw4F2len3GGQFE9ZvUmgmRdFafPY9q5rrAmENIoGmoHd?=
 =?us-ascii?Q?ZBsk1GsDCrToKRk7pes8RpP7hr4/1Veq489FnTvmNf7KfYw9p3cD0KA4mbS8?=
 =?us-ascii?Q?2exv38hs8HgGeFvhWSjzX5PkHRiHefN2gih+Bzdlf9jzm1TGSqrPUJWqJLZJ?=
 =?us-ascii?Q?02iYquiF/fMNG/HJKJHOVAbPLkGb8SW1vMuDVBrumY2zeGPgMu/PNMfMyILO?=
 =?us-ascii?Q?0mwDk2xwBVxUQ3YyE6o9EWlEWT3DsAlBQT6ZXSdcnLIbX7lhUqQc3eEHCGvP?=
 =?us-ascii?Q?UgvsC+t80l5tfpoW0fqR4aeAxnICMBtGV01Np2A9QfQ4J6aITbLa+DusEdpu?=
 =?us-ascii?Q?HyX+KmR2ZBWqAj6G/Gqpu/0iClDQLHGRKjMHLGNAxzqGQ73O/EQg3dOtfMxh?=
 =?us-ascii?Q?BRHb+400+RPkDZc7awJAMCqCGKLndhGW3sPiNXXWkUpAcaQ9/Xw7vJcqq8cl?=
 =?us-ascii?Q?xg4/cuqbXz65EOFWJ/m2/4c8I51oFTSUAa+srZ4BjL5lQ42gsiW9nfnEXNg6?=
 =?us-ascii?Q?8yZaPzC6xYvbAUdWKf7eYdtYekk25DJ4aXXZQ2OBQVPxdStyjFcpoiEddZrg?=
 =?us-ascii?Q?Oyvd23TEQYggM6cyZgRUrb6IzZet5tFj/3lj+SV15VDsj54yjWJozfLYa6YI?=
 =?us-ascii?Q?XybOs3HfAxuYyMHQ470NfDtw6imJQSYeD8hk9sAg7LXqvCSwaIvh9V4qBqBl?=
 =?us-ascii?Q?wQR8waib9fYZ+R/VcOgWUimHQEkvPBSxU+zBoSrpmSA4QEvAB46HQaRNgwi/?=
 =?us-ascii?Q?xqim1FraL3//tluE9H83iVrTAOWZ20zDlL2QpKKHANQcCOXw+3BAospYWOcL?=
 =?us-ascii?Q?6wIxDEa8vs7cV9agYktT0xgf23rzy2IOBlyHCE96bO8ApGxZQI0Dsm2EBYZN?=
 =?us-ascii?Q?YdM6QompTfuf+4S2XB/sXjZYmF1PKPKurXcyOBf2H5RHZ0nuUng3s7lr4Z2I?=
 =?us-ascii?Q?PropVCsP8QkCK3Wo/AibJs91p6IaZZFaNReE3ZuTBm3DpmxNmxBajVmKgNNT?=
 =?us-ascii?Q?cPCNtK/oTludfP0EVTScY3V6Q93u5ADhCjn+jhZeCfrNQuve2DN7KCJ9VRBF?=
 =?us-ascii?Q?ajccsX5I3CaOSBqclmelH3WW8tUbFHtPomHEKW67SLqTpmnfCImOMLVo8how?=
 =?us-ascii?Q?8aZHqzMC/QbucIEO1a0+DNflqVxDQS6LYLmw8SUhOfHzAgjk+5KRYc77+aUo?=
 =?us-ascii?Q?1Tbzc81+GlhtweCA2KY563t0DU0O5DTGQMYmXVtwCec8o6J8iUMZ+a/PTSOT?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f70ea1c-85a9-4e5c-402c-08da62d4d570
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 00:32:28.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsquZgzfj+1KgFBKiE9jgDb7u7ryZZrjLcRn3Xhg3Ktle8bmFKOJtvmE8MCQrpNS6+xUiFK6ShLLWrxmhhmJP4RZMN8s1jX2xEzRbYCtuqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
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
> On Thu, 23 Jun 2022 21:19:40 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Ben Widawsky <bwidawsk@kernel.org>
> > 
> > Add an ABI to allow the number of devices that comprise a region to be
> > set.
> 
> Should at least mention interleave_granularity is being added as well!

Added.

> 
> > 
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > [djbw: reword changelog]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Random diversion inline...
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |  21 ++++
> >  drivers/cxl/core/region.c               | 128 ++++++++++++++++++++++++
> >  drivers/cxl/cxl.h                       |  33 ++++++
> >  3 files changed, 182 insertions(+)
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f75978f846b9..78af42454760 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -7,6 +7,7 @@
> 
> 
> > +static ssize_t interleave_granularity_store(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    const char *buf, size_t len)
> > +{
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> > +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> > +	struct cxl_region *cxlr = to_cxl_region(dev);
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int rc, val;
> > +	u16 ig;
> > +
> > +	rc = kstrtoint(buf, 0, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = granularity_to_cxl(val, &ig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* region granularity must be >= root granularity */
> 
> In general I think that's an implementation choice.  Sure today
> we only support it this way, but it's perfectly possible to build
> setups where that's not the case.

If the region granularity is smaller than the host bridge interleave
granularity it means that multiple devices per host bridge are needed to
satsify a single "slot" in the interleave. Valid? Yes. Useful for Linux
to support, not clear.

> Maybe the comment should say that this code goes with an
> implementation choice inline with the software guide (that argues you
> will always prefer small ig for interleaving at the host to make best
> use of bandwidth etc).

No, I would prefer that as far as the Linux implementation is concerned
the software-guide does not exist. In the sense that the Linux
implementation choices supersede and are otherwise a superset of what
the guide recommends.

Also, for the same reason that the code does not anticipate future
implementation possibilities, neither should the comments. It is
sufficient to just change this comment when / if the implemetation stops
expecting region granularity >= root granularity.

> Interestingly the code I was previously testing QEMU with
> allowed that option (might have been only option that worked).
> That code was a mixture of Ben's earlier version and my own hacks.
> It probably doesn't make sense to support other ways of picking
> the interleaving granularity until / if we ever get a request
> to do so. 
> 
> I think it results in a different device ordering.
> 
> Ordering with this
> 
>     Host
>      | 4k
>     / \
>    /   \  
>   HB   HB  8k
>   |     |
>  / \   / \
> 0  2   1  3
> 
> Ordering with Larger granularity CFMWS over finer granularity HB
> 
>     Host
>      | 8k
>     / \
>    /   \ 
>   HB   HB 4k
>   |     |
>  / \   / \
> 0  1   2  3
> 
> Not clear why you'd do the second one though :)  So can ignore for now.

All I can think of is "ZOMG! My platform failed and the only one I have
to recover my data has HB interleaves with larger granularity than my
failed system!". Otherwise, I expect cross-platform CXL persistent
memory recovery to be so rare as to not need to spend time too much time
worrying about it now. It seems a straightforward constraint to lift at
a later date without any risk to breaking the ABI.
