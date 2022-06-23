Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0615455884D
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiFWTC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 15:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiFWTCi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 15:02:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043373E0C3;
        Thu, 23 Jun 2022 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656007690; x=1687543690;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZWgRb20YtMLnchZF8oumwX+9PviSn0jHCmpTz1KBjdY=;
  b=N3opEmtS3ffg3ICK3wnoB3haEKMXwMpxYQyYn7b3seLVjUls0+OoA+ZF
   x1lawEFn7oliwZAuUJ5+P6tD+CQM3LKtXbdIiI5Z6G/kVjoO8Cx6Byf4t
   Nn5KVcfU4N+2GT3etSZOBVfsglJ40dDhFnjPH9rJ+F7BWjcGVwyet6xIY
   J6iGJsfuXLpB3h9IUJ0YmMCjdx7aNVImJ2RGbiinSh/pPnj096GzZuajd
   og2wmpbjPjva1gn4rY0M6l/I7Kdh1if/K8JSQtgLGl2O/Lvfj+AHMro38
   zbFfxBd1pHy39vFXWA5w0IXvVb1NsKn3zY6uJ7LgmDKIhgU0cvKOwvhVu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261229037"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="261229037"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 11:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="586261926"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 23 Jun 2022 11:08:09 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 11:08:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 11:08:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 11:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu2+xdDSKVO5OEvyW0tFLwe8t5tixgQF1kMPbm3LaVPiNQeGy0Efsioqf5CgHhz+V0b3c0u5uGzAqSZBmlt+3QajNXOhJCiJpT4GOZBC9UPbkyqzif+ni9npcOn7TgC2Iq/daB0hBSg7dfi4WdzKGHOf8VFR2Eq+ynwmaWw+cT6mvQLDnaKLGxfc7ONsuxd0oMECUDLHwin2hCusbz8hsQRH0n+aNINjG4fv7fMUb2H+qbDAWCBYVDpqa9zNkzKLouvu8HPSpoIQl/6ZwhqvrB7J+VXkUo+e2fHkEgiKzExG/mUk74pklyzThp5BLjOEDL6VcK62MDpk+jWlPojweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqGGifT4zp/yapxEic717zvLPfM/kVHjcKmRM7Ra1EU=;
 b=QNOxt7L6LzEZHGnXhGVfo40I52bvLGk/LTYmo33S7Z93WT5JSiOeAdrN7ALF50406yEEb9+FQTW2K5Nf+eK64KBeAuVPeiHdWvzstWVeTTORMJRRwDRHEVMvCZVedtGwa6oWtuqdCiMTACln2k6i+bTXS+R/b7Mq8Kpl6SBkplj1ysfjvewLFU5RBh60RYBOYqTyGyFUGf+GDhRrH7AOLuTWFlG2KXwCGUkgmCyh+pa85dO+bQSwO7sq3QOLfHOZg6HLKBCnrpRqlKIc8N5y6M++HnQ1nnSVaF6boAU1SPISCOzelnw6DuV+xl2HXxSNtF8poHfboQWrui3VNweZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4612.namprd11.prod.outlook.com
 (2603:10b6:5:2a8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 18:08:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 18:08:00 +0000
Date:   Thu, 23 Jun 2022 11:07:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <62b4abfe54d0c_3c3ff029484@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
 <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
 <YrObe+AdfziEPlYB@iweiny-desk3>
 <62b39e5eead1_32f38a294b6@dwillia2-xfh.notmuch>
 <YrOy3vodu3FcRjUY@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrOy3vodu3FcRjUY@iweiny-desk3>
X-ClientProxiedBy: MWHPR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:300:12b::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2005d16-4c5d-4554-ad38-08da55434ee4
X-MS-TrafficTypeDiagnostic: DM6PR11MB4612:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0rxcdBKIrCbCnauNV+WyWwxAu1jgcv2oP30JDQQiOIvXpMQhJ8yxRMiGH/mQYMPMVHTtv8LNMQXq1anMnh5H0qSxkA5jNP8g2QrnEQgQAs6xskd2XwX5MY2wcCkUIxHyQRY1IzFMfWO+hrrewcww3yVYcqK8bjd8dLV9ahFSNVjXJCFeYBA0334iiTo/wFitQHXV9vQRQkigOtcTvwTt5Lh6FhnwVdPJPDK2joBjMVIbPNiKp9vLwqhRW2xR31xD3+61p+Wmr+vpMYqFKlTg4tEbyRw/ZqH0E8uva5vbVkPqFmi6AxJEtccZPVlFiUYo6hz6ORQjDTvxu6+pD3UXd6+xrbcHozTjoXN6eiiP9dMeSBo7pLMaO7CiE0RhWBfbh/8nuSXKbge52fu1Dre169fl4VWeZpMbBLayhjw8NceXKf7ASyacNo8bceffAwdLfE1KHzXbi9XO0hseMBtrB9xQk20BoBzb3n7YFrwlbntZElJC5p2VLkmslwHvdake230vf2ozSowY+xsG8m18MJng8r63I3z4iUnXFg+v0H32rNCBiHZ3cBzHxicpBc7QJBkaH1arcMEyd0XNxFYhpom4k/LwS/TV2JRNuNPhmRTyNfNOq4nmlQhtDfsyAPiqAKLSeTNHzO2GVAac5p2GpOMHPFpovtT2eZg6GaFUDD4Hd+kElLiYiHXs1NV8aGo+v+NhHPgX3Q1Xvu1KjTRp38Eei98z3rXoPxRF144hus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(39860400002)(366004)(396003)(478600001)(26005)(6512007)(66556008)(6486002)(83380400001)(6506007)(66476007)(41300700001)(82960400001)(2906002)(5660300002)(8936002)(9686003)(86362001)(38100700002)(4326008)(186003)(316002)(66946007)(54906003)(8676002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5DZNZvVi4LRj9Q3pGsUV0OEca4dPiIVKj3rrN2Tv7/exFBFlirQkbVKwumw?=
 =?us-ascii?Q?EpW7Py5YGZ9Gt+PdwRWJTWKgNuneyJ59MVH54jmUXbP4eKZ10TL5zd8ehHm3?=
 =?us-ascii?Q?J6SHsUvk9h3IE8R4sSg3j+fFcTnfpWMEDgPjyG97uySbLl/L1UBLmt5qzIJP?=
 =?us-ascii?Q?wItna8akAE70mba98854VSBEt341tys7+baZn81mnsq52DQR7KDTO1dt35ha?=
 =?us-ascii?Q?P7sNyVjUFL13F5vthkPgTfvAp+9AVUOrsLRNZn3A/lpJRpkdHXu0q4GYQCgD?=
 =?us-ascii?Q?K9EaLAdCowTIrOQ8vPWskj076t61anVoW9YO4dj3V8fvELRBOWtG+ksESetZ?=
 =?us-ascii?Q?+dIbIlyaPOMMfagoukI/92m57BSFif1IAj/qGNSx0SEhxmVxyNlSmx3zlLBk?=
 =?us-ascii?Q?W2Yf2hwPbXu8vFS+hwAqUHRM1+7eiSjfPPAtAsjKSgOtsVpw+alFaqugYFCX?=
 =?us-ascii?Q?1ONqYKyAmNFi6p4TPQQuoyNV+AbcpzeFnsuW042pfMRCfJKcr0MtW2CVlvzh?=
 =?us-ascii?Q?dpsYrMva7peLMpd5Z5zt/k25kX6A2BShCNhUm3LyRnxvOYVCcwaW0F5uI6aP?=
 =?us-ascii?Q?Zsvqz6L1wT4PNHpONKPGspOhoOapSuml9a19iGZp2LhLe+afpQlc4CMfez/p?=
 =?us-ascii?Q?lBMy3DUpEsXxiTp/IjkPtEylBvsvSdRl4ViAbZ9nPvVLVqWvUCV4mlaMUqU0?=
 =?us-ascii?Q?mT0oaeDqYo66zIbIVpbXqLLkJPSm9MyAXz+7TiB7WgXWyy305H9YWxxuSiMH?=
 =?us-ascii?Q?lsglQ9WjsH349H4vH9Wp0nh59rHwBExFMfw5Gk8dKZN4nUA8LsikZzz0OyKN?=
 =?us-ascii?Q?JlsZZWxijQIie+zD+YxvRgcWKFSKmA8wdPvVhIPWyvXS+O8pi3Daj7EIH4rN?=
 =?us-ascii?Q?QyCJNf6bHdiWE3h0J8wrjxYRoqk1DZvFX6vdhyC56ejTcm4108UzF3V2Bn7X?=
 =?us-ascii?Q?bNWvtN/LMBdmSfLCblq7OC4SSaN6qEC4NObU4W+2cuU+gtiWLRewDyKxcdtA?=
 =?us-ascii?Q?DMgxF57gtR5Q26vnHuykaY4vCOAFrhMhPQeFZp/Svmts4wvAtw7VW/0Mdp1k?=
 =?us-ascii?Q?uJfSpXO7h3bBPMopnYHTMQkTzcipNNWsgOlFwpwdfF1hjkB3IgXW2sjb3x4g?=
 =?us-ascii?Q?X6BeUNcfw6AanCmCDvuQWg8W5L7RlpjT4hdyljIhNyallbis2RMoDur1Dvef?=
 =?us-ascii?Q?QCAfrB12tmLPkEdQ9RNafGtdNyrrGhYkCRsDLYV2aHJ/ZvP0HiiLcnb7cO/P?=
 =?us-ascii?Q?093Q4tp+ArJ0rotB1VpOZTQb0dE02kbCQz3LqmNEYg8P4wf05MkF+DOD7u4y?=
 =?us-ascii?Q?39+oM02dZ9rS6w7/inGPm2521kbkfxfZzUkTR1/htnxB6u5MkDdNO8GJ1VAt?=
 =?us-ascii?Q?m9Vdh0tC5M9MhXLwt67wKLNwP74+yt+wo6BIj1xL22h4uv96ptVhwyH1gfAD?=
 =?us-ascii?Q?k9sQbtxr7oxXu+YoNCR229bHywpoGBUk0Yc9CPc7K5OnGa8EPbeFbMumTM0b?=
 =?us-ascii?Q?VTxHJesV4gUyDRjZpFGr/2lpajbNzYReclrl+ExKt2ISYQZX2IQwbVj/6SoZ?=
 =?us-ascii?Q?jfnk2GSqgvEK9KtkxxDlACUXb6J7SvciCfOmuLAgzYzEqavSWlptwlmXJ9tB?=
 =?us-ascii?Q?WqNw10HNdNWYlUzzLd7FPGp4A+jR1RiuEKtFZIStQPZTO6H6/AwGqZ851Qil?=
 =?us-ascii?Q?DZqeNQkp4tgPPV3zJKt8lVo0H2bXlDP1G2auMQRcSajKOG4FX37i1qoxanF0?=
 =?us-ascii?Q?DuDEmSygNvLyvlvKuBVAQXblJijPj6w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2005d16-4c5d-4554-ad38-08da55434ee4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 18:08:00.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhwKv+q4rmTBWb9CHgUG3jA8B/bLQyaufjOovTdhKaLq0zSq8WFljb/OFqlAGulz1nZe/zi0+eCrWXCOvbYv/RElGwB3tlYusKGGwE28r+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
> On Wed, Jun 22, 2022 at 03:57:34PM -0700, Dan Williams wrote:
> > Ira Weiny wrote:
> > > On Fri, Jun 17, 2022 at 03:56:38PM -0700, Dan Williams wrote:
> > [..]
> > > > > +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > > > > +			     u8 *protocol)
> > > > > +{
> > > > > +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > > > > +				    *index);
> > > > > +	u32 response_pl;
> > > > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > > > +	struct pci_doe_task task = {
> > > > > +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > > > > +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > > > > +		.request_pl = &request_pl,
> > > > > +		.request_pl_sz = sizeof(request_pl),
> > > > > +		.response_pl = &response_pl,
> > > > > +		.response_pl_sz = sizeof(response_pl),
> > > > > +		.complete = pci_doe_task_complete,
> > > > > +		.private = &c,
> > > > > +	};
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = pci_doe_submit_task(doe_mb, &task);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	wait_for_completion(&c);
> > > > 
> > > > Another place where the need for a completion can be replaced with
> > > > flush_work().
> > > 
> > > No not here.  While this call is internal it is actually acting like an
> > > external caller.  This specific wait is for that response to get back.
> > > 
> > > This pattern was specifically asked for by you.  Previously Jonathan had a
> > > synchronous call which took care of this but you said let all callers just
> > > handle it themselves.  So all callers submit a task and if they want to wait
> > > for the response they have to do so themselves.
> > 
> > Ah, true I remember that. The nice thing about a doing your own
> > wait_for_completion() like this is that you can make it
> > wait_for_completion_interruptible() to give up on the DOE if it gets
> > stalled. However, if you have a work item per-task and you're willing to
> > do an uninterruptible sleep, then flush_work(&task->work) is identical.
> 
> So when you mentioned a work item per task I really jumped on that idea.  But I
> realize now that it is a bit more complicated than that.
> 
> Currently a work item is actually one step of the state machine.  The state
> machine queues the next step of work as a new work item.
> 
> I'm going to have to change the state machine quite a bit.  I still agree with
> the one work item per task but it is going to take a bit of work to get the
> state machine to operate within that single task.
> 
> I don't like what might result if I layer a work queue on top of using the
> system work queue for the individual steps of the state machine.  So stay
> tuned.

In the end only one workqueue should exist either a task queue (my first
preference) or a device-state queue (if the task queue turns out not to
fit), but neither of those use cases should be glomming onto the
unbounded system_wq. Keep it simple with a dedicated ordered queue.
