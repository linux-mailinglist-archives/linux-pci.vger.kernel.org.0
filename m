Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38752630FBA
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 18:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKSR1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 12:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiKSR1w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 12:27:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE0101ED;
        Sat, 19 Nov 2022 09:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668878869; x=1700414869;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PIPSq60PXGHyNr+G02OxENvAmE9CayjonhI24RZiSQs=;
  b=WsjJrBewSLWrVBsE96U8pyMW3vHQq+pZh8sepVHSgdSNth0pEWfnIcGn
   XVDxgim4TZa+YdgkZ839p8s3VdcH+h0pjw26rpY+clrOrieazT6Wv4vlx
   cZA3VR0PCH///lFcbIMYp+ifM7rHqw+pnecaG0xU+RmQvfBPoj/bl64/I
   AWVXKEvNUp/ZUb4DXEz0v1J/VqnFSzkg4hWvB/BUDdoURT64oHd1Q1S2J
   sjkbB5BMU38AI0iGmqoWEAtcvt8Ybs5vcBLW58y9ZygX75WqQd8/seLgT
   TKu2UWJrdQkoaHf00xH7QLhq2uy7L9G8OsxHBO5nzDtPHg6Jxx9tWyWeG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10536"; a="375478345"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="375478345"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 09:27:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10536"; a="782987134"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="782987134"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2022 09:27:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 09:27:47 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 09:27:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 19 Nov 2022 09:27:47 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 19 Nov 2022 09:27:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSOhshziXL/ALUsdVRZjlDLTZ1+bAvSwUHBEh+I00Jr0dH0V74ay4ChBLtMEskHMGFAZ8/7dm8L3nB6vFkxqDeoUPNKBtAOOkG24NvnepJDBOAPub6w3ULDiS1LDCySAhPCKavsfGk/nTVv/vfeFZ8ej+XW+gVdBCx4UIvBJIZKxHpyWSbmL+Lt9sUWB91r6u33pXRLEMiG7FDJt2PiYNJQv2s+UGeQJColBW7+eek1o8mkPs0eg4qHgIJvOBuuaOnRZLU4drV6Ta3bT4ye3uvRruqhaA5FTHro9rU8dTTQM3lqilxkc1CmzXiXnTvZQoAI+e9sFOt3mFGu3UA1Ldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO5c+Daj6+7cw41C7R8e0emADS0dusnDg4RZxXrTZX0=;
 b=XOgV010/ZIhtieeSbXVWaBDO4I0T9tmkvshkAs027NFnRz30b/t38vuLLLhvh1lizYn7Q4uyAWM0owrns924+FKtNUfyN756t3/PXTNo6itNpkim4B598YhwJIdtOuA30BoVmai2WpxniuT1WS0AbN1KYZ0UuBaokK88W9GLq6A2YNHeUB2Y4wkYUei6cgO9S8tbENRjU3MvgQ0wAoYAQzpI8mXAf7FjL+g2MFnujebHgxvIj7ZJGtymTP4fPMl60GrbgNQ40zqzhYgNa+jjY5Js7GIvlzk2vjQdf6Gn1BSTY2p2V9MwZNcO8BtpOq6ptrQfq9bugTKFs1R+bvAFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 17:27:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 17:27:44 +0000
Date:   Sat, 19 Nov 2022 09:27:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Li, Ming" <ming4.li@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Message-ID: <Y3kSDQDur+IUDs2O@iweiny-mobl>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
 <Y3fSRbpjeC1CTPA1@iweiny-desk3>
 <6377e0fa50f1d_12cdff29425@dwillia2-xfh.jf.intel.com.notmuch>
 <7bb72f37-9da0-2406-cbc4-d9b0f879320a@intel.com>
 <6378659e433be_1ee2429488@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6378659e433be_1ee2429488@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 020f174f-8e73-4ff9-1267-08daca535e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaK1QwwVJOCJUA0iA1ESl5nVwlod3mZ4/x41ATPzaOAD6g/ndKBK8jOUaHZeL0F8Y2hwGQuL57mI0Voiqme/VtS3eE61kQYqM/Pr33RDP42I1LYpI+gqgFccpWg+OVNYGulYVe1JHFay8o2qiga0DKzg6yQ5L/Cn9gnUAkzrf5HbvEGPrCx2VBttbJeZCZZ5Ojxhp9FSvpqLqEvcPXnHXg8Uw3vOvvoNX8hTf+9512+Vpp6qT8Q9GtLehwoYE2nQ+goAOUJVGxVM4BNzxFDdokHYFMnxf/2+RxZTA38OH9eaLVbsGRONEBQabAPM8nNqQ+3eSZ1EymDpVDgTWQjKdvvAFnG6d9o5rglzUFh9lgL/2kf5B3Wt2F508HH2+DFfjILVZ3FtpNUKV41j/0C2zeAybtlZF2yGfFL51e1sWb5Tw0IlC1YIgn5fMQNXEmo++7PI6jOyYYSoo4WTdx7Wd+u/veq2Gq3QKySkoolBuC7ivprbA4/XBorEnzH8NIGAxCgBE5dBy05iUzRIzUZz1rBwG3egO/8VSJQBYoQHYvCwvlbLq2IehRrIF8BZaU8d8NPAhg/8j4g2103yxsDlIriCzpPCXDyBMGWyMdeRKhR5ufDaHQ+qDdG2ahwQFk0yh30YoS5+ntSmlBVH2t3SVkA+4tzUXcyGhH0f92odW9iHfmStGtyID32B6nWrvKgGHVX2DuYZ034CaQ/7mPGFrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(6636002)(53546011)(316002)(82960400001)(66476007)(26005)(9686003)(8676002)(86362001)(66556008)(6512007)(38100700002)(4326008)(66946007)(83380400001)(30864003)(44832011)(2906002)(41300700001)(186003)(8936002)(5660300002)(6862004)(478600001)(6506007)(6486002)(966005)(33716001)(6666004)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHecPo1Llyn7s6yMlGJ/TQZ1pCLK4QltwDW4SiYdbOdBm5E7D8+XABpKL49H?=
 =?us-ascii?Q?zLSbmkN0U2Fz9EA/xymQfxAm5SAj+sNizI5wdJwvLOaEwg7oCI6iZ5/TIKiw?=
 =?us-ascii?Q?1MMETnpEVRivKTLOTBtICTo17cIUGRAjqzsASk6VZ2G0yhPmm8UfG/lLWRuE?=
 =?us-ascii?Q?oyLxypMEv5ukQlPnntN/l28TChrAgr8VdFmbv8F5b+XpWvu/QkBGK4KBE3L9?=
 =?us-ascii?Q?rPlVBZRztLVmtVx7VcTD5culHDMciT6YTSCS6B3DMjuLRfgg5i5/kicooMuZ?=
 =?us-ascii?Q?q9melusJxRqe2eTOybRasJU5CGb2/gWbiBm6GGD4uNaA+k/yOzeLVj4rSx+8?=
 =?us-ascii?Q?dggTra0iYBToYvYXQDyRo7pmYZAJtOS6RjPwWjeoXe0tz/6kdkvoK3c+yFon?=
 =?us-ascii?Q?EWicAGOY89Ez/GMfLsTJ11JiBDyGisc6+gwzEdo/Sf6Ybfd3WtwgsvjgvxAc?=
 =?us-ascii?Q?I+8THClRuXc6hS+FEPmKxg6tjFmwUFpCwAMSOAPnOv0clDF58fBz59UZz7B3?=
 =?us-ascii?Q?tvD4QdLTokh+83YksTshlo8ojcwqhGkyFMCHV+lZIE7rWWKm/vuLt5rCN8UU?=
 =?us-ascii?Q?IAHgEG4KCKKAcp8P0LMEaOBRS3plelkL2kaKLNFDdYttNNnru+L8rAZARa+V?=
 =?us-ascii?Q?3nphcNRPSUvIzk0QESAfvNDglm3kIQ9eyleZiJ/y8piCdm9xQrnjxQ8vmQ3C?=
 =?us-ascii?Q?alpiSzcc7+KMeyqH601HJYbhWNmlmMWaW5zAVQWZnpx4c9Cd7E5tk9U5TCHT?=
 =?us-ascii?Q?1dGcauu2DygluKQX4wGDNJ/utiQHdMLuhZyhc94HVD2pp8e6gsYCRJKmU2cZ?=
 =?us-ascii?Q?Mct9QLCROuZHlZhI6nDXSLp0DqRz7wVuSDm+6OMiKkF0xyi8UcnjxGnbpCHn?=
 =?us-ascii?Q?3OfnvV0FPM/RQQmu5ajgpFjrFkpui1++3N2Gu8TuJu2QLzwWQ0A24hcHNmNL?=
 =?us-ascii?Q?s0VLr/cZSAX2hMWTaMMFXpMCWm8ER1c8+IwNm6mce4KcXfMvXziFnlW4Kbej?=
 =?us-ascii?Q?DGzfCJS3QvQQUJXXMRpCzSKeLGZz/iYqRQoStuAkHOKdkdJNVVrBy9rXhC1T?=
 =?us-ascii?Q?0mdht1GPNh1Kg0EWz0+/CQJQoJqBxGO/TZHY7F3jXSXelY6vvNg2tghEj9Fi?=
 =?us-ascii?Q?bkgkBkaoUIUOQx4xLvx3TSlOCMokpFuilj4mb6lmfqtr6m8TDCfxQbPWtkfR?=
 =?us-ascii?Q?BtXx5O3TAvbw6f9zFam2Ddgzh1ijyUFTd+SfbrsonXD1am5y8LAWCpnFOs7e?=
 =?us-ascii?Q?VEPQllC4Njb3eLrJAYqAZr9VM1/lPRvBwlIBXn19HNbmJjEgO7fDHasxdk2a?=
 =?us-ascii?Q?M2e0mpD//dVc8o8zyRtnfvH8CgF6KqLTf43XvLznkLnTsiZWep8Z0/jCcRDE?=
 =?us-ascii?Q?PaWblpy+wfZu6s3TYTc+o4Yhc5mUewbFOlqJIWS6yPVe4fn38Pl8gTaql8LF?=
 =?us-ascii?Q?oIStGz2lilQitI4onQrjd7rHt1lHEYLN70XWWMwMI7QPvyy3Uz+I2/pQ7Zf8?=
 =?us-ascii?Q?ijYgDjCdYxnA0O2k0O5T/zCuWcTv57It83aEHBZg6k2xPvKlh/HgbXEObzAA?=
 =?us-ascii?Q?aTwas+6mxJna1PbjNiiXIu7s9H5aPXYMLUMoqv9g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 020f174f-8e73-4ff9-1267-08daca535e93
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 17:27:44.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PozvAzeSpUi+v83R18XKYTNQZj8Vc+VqiRkonzWxys9dgsgex7oWHRHcGZBcXbilXvXUVwQl5MYHSS9YKH7KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 09:11:58PM -0800, Dan Williams wrote:
> Li, Ming wrote:
> > On 11/19/2022 3:46 AM, Dan Williams wrote:
> > > Ira Weiny wrote:
> > >> On Fri, Nov 18, 2022 at 09:20:38AM +0000, David Laight wrote:
> > >>> From: ira.weiny@intel.com
> > >>>> Sent: 18 November 2022 00:05
> > >>>>
> > >>>> Work item initialization needs to be done with either
> > >>>> INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> > >>>> allocated.
> > >>>>
> > >>>> The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> > >>>> stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> > >>>>
> > >>>> Jonathan suggested creating doe task allocation macros such as
> > >>>> DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > >>>> function is not known to the callers and must be initialized correctly.
> > >>>>
> > >>>> A follow up suggestion was to have an internal 'pci_doe_work' item
> > >>>> allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > >>>> could restrict the context where tasks are used.
> > >>>>
> > >>>> Another idea was to have an intermediate step to initialize the task
> > >>>> struct with a new call.[3]  This added a lot of complexity.
> > >>>>
> > >>>> Lukas pointed out that object_is_on_stack() is available to detect this
> > >>>> automatically.
> > >>>>
> > >>>> Use object_is_on_stack() to determine the correct init work function to
> > >>>> call.
> > >>>
> > >>> This is all a bit strange.
> > >>> The 'onstack' flag is needed for the diagnostic check:
> > >>> 	is_on_stack = object_is_on_stack(addr);
> > >>> 	if (is_on_stack == onstack)
> > >>> 		return;
> > >>> 	pr_warn(...);
> > >>> 	WARN_ON(1);
> > >>>
> > >>
> > >> :-(
> > >>
> > >>> So setting the flag to the location of the buffer just subverts the check.
> > >>> It that is sane there ought to be a proper way to do it.
> > >>
> > >> Ok this brings me back to my previous point and suggested patch.[*]  The
> > >> fundamental bug is that the work item is allocated in different code from
> > >> the code which uses it.  Separating the work item from the task.
> > >>
> > >> [*] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> > >>
> > >> Bjorn would this solution be acceptable and just use GFP_KERNEL and mark the
> > >> required context for pci_doe_submit_task()?
> > > 
> > > It is a waste to have an allocation when one is not needed. The value of
> > > having INIT_WORK_ONSTACK and DECLARE_COMPLETION_ONSTACK is to be clear
> > > at the call site that an async context cares about this stack frame not
> > > going out of scope.
> > > 
> > > However, coming full circle, we have zero async users today, and having
> > > the completion and work struct in the task are causing a maintenance
> > > burden. So let's just rip it out for now with something like the
> > > following and circle back to add async support later when it becomes
> > > necessary: (only compile tested)
> > > 
> > > 
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index 0dbbe8d39b07..69873cdcc911 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -488,21 +488,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
> > >  		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> > >  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> > >  
> > > -static void cxl_doe_task_complete(struct pci_doe_task *task)
> > > -{
> > > -	complete(task->private);
> > > -}
> > > -
> > >  struct cdat_doe_task {
> > >  	u32 request_pl;
> > >  	u32 response_pl[32];
> > > -	struct completion c;
> > >  	struct pci_doe_task task;
> > >  };
> > >  
> > >  #define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
> > >  struct cdat_doe_task cdt = {                                  \
> > > -	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
> > >  	.request_pl = req,				      \
> > >  	.task = {                                             \
> > >  		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
> > > @@ -511,8 +504,6 @@ struct cdat_doe_task cdt = {                                  \
> > >  		.request_pl_sz = sizeof(cdt.request_pl),      \
> > >  		.response_pl = cdt.response_pl,               \
> > >  		.response_pl_sz = sizeof(cdt.response_pl),    \
> > > -		.complete = cxl_doe_task_complete,            \
> > > -		.private = &cdt.c,                            \
> > >  	}                                                     \
> > >  }
> > >  
> > > @@ -523,12 +514,12 @@ static int cxl_cdat_get_length(struct device *dev,
> > >  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> > >  	int rc;
> > >  
> > > -	rc = pci_doe_submit_task(cdat_doe, &t.task);
> > > +	rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
> > >  	if (rc < 0) {
> > >  		dev_err(dev, "DOE submit failed: %d", rc);
> > >  		return rc;
> > >  	}
> > > -	wait_for_completion(&t.c);
> > > +
> > >  	if (t.task.rv < sizeof(u32))
> > >  		return -EIO;
> > >  
> > > @@ -552,12 +543,11 @@ static int cxl_cdat_read_table(struct device *dev,
> > >  		u32 *entry;
> > >  		int rc;
> > >  
> > > -		rc = pci_doe_submit_task(cdat_doe, &t.task);
> > > +		rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
> > >  		if (rc < 0) {
> > >  			dev_err(dev, "DOE submit failed: %d", rc);
> > >  			return rc;
> > >  		}
> > > -		wait_for_completion(&t.c);
> > >  		/* 1 DW header + 1 DW data min */
> > >  		if (t.task.rv < (2 * sizeof(u32)))
> > >  			return -EIO;
> > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > index e402f05068a5..115a8ff14afc 100644
> > > --- a/drivers/pci/doe.c
> > > +++ b/drivers/pci/doe.c
> > > @@ -18,7 +18,6 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/pci-doe.h>
> > > -#include <linux/workqueue.h>
> > >  
> > >  #define PCI_DOE_PROTOCOL_DISCOVERY 0
> > >  
> > > @@ -40,7 +39,6 @@
> > >   * @cap_offset: Capability offset
> > >   * @prots: Array of protocols supported (encoded as long values)
> > >   * @wq: Wait queue for work item
> > > - * @work_queue: Queue of pci_doe_work items
> > >   * @flags: Bit array of PCI_DOE_FLAG_* flags
> > >   */
> > >  struct pci_doe_mb {
> > > @@ -49,7 +47,6 @@ struct pci_doe_mb {
> > >  	struct xarray prots;
> > >  
> > >  	wait_queue_head_t wq;
> > > -	struct workqueue_struct *work_queue;
> > >  	unsigned long flags;
> > >  };
> > >  
> > > @@ -211,7 +208,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
> > >  static void signal_task_complete(struct pci_doe_task *task, int rv)
> > >  {
> > >  	task->rv = rv;
> > > -	task->complete(task);
> > >  }
> > >  
> > >  static void signal_task_abort(struct pci_doe_task *task, int rv)
> > > @@ -231,10 +227,9 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
> > >  	signal_task_complete(task, rv);
> > >  }
> > >  
> > > -static void doe_statemachine_work(struct work_struct *work)
> > > +
> > > +static void exec_task(struct pci_doe_task *task)
> > >  {
> > > -	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> > > -						 work);
> > >  	struct pci_doe_mb *doe_mb = task->doe_mb;
> > >  	struct pci_dev *pdev = doe_mb->pdev;
> > >  	int offset = doe_mb->cap_offset;
> > > @@ -295,18 +290,12 @@ static void doe_statemachine_work(struct work_struct *work)
> > >  	signal_task_complete(task, rc);
> > >  }
> > >  
> > > -static void pci_doe_task_complete(struct pci_doe_task *task)
> > > -{
> > > -	complete(task->private);
> > > -}
> > > -
> > >  static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > >  			     u8 *protocol)
> > >  {
> > >  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > >  				    *index);
> > >  	u32 response_pl;
> > > -	DECLARE_COMPLETION_ONSTACK(c);
> > >  	struct pci_doe_task task = {
> > >  		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > >  		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > > @@ -314,17 +303,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > >  		.request_pl_sz = sizeof(request_pl),
> > >  		.response_pl = &response_pl,
> > >  		.response_pl_sz = sizeof(response_pl),
> > > -		.complete = pci_doe_task_complete,
> > > -		.private = &c,
> > >  	};
> > >  	int rc;
> > >  
> > > -	rc = pci_doe_submit_task(doe_mb, &task);
> > > +	rc = pci_doe_submit_task_wait(doe_mb, &task);
> > >  	if (rc < 0)
> > >  		return rc;
> > >  
> > > -	wait_for_completion(&c);
> > > -
> > >  	if (task.rv != sizeof(response_pl))
> > >  		return -EIO;
> > >  
> > > @@ -376,13 +361,6 @@ static void pci_doe_xa_destroy(void *mb)
> > >  	xa_destroy(&doe_mb->prots);
> > >  }
> > >  
> > > -static void pci_doe_destroy_workqueue(void *mb)
> > > -{
> > > -	struct pci_doe_mb *doe_mb = mb;
> > > -
> > > -	destroy_workqueue(doe_mb->work_queue);
> > > -}
> > > -
> > >  static void pci_doe_flush_mb(void *mb)
> > >  {
> > >  	struct pci_doe_mb *doe_mb = mb;
> > > @@ -393,9 +371,6 @@ static void pci_doe_flush_mb(void *mb)
> > >  	/* Cancel an in progress work item, if necessary */
> > >  	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> > >  	wake_up(&doe_mb->wq);
> > > -
> > > -	/* Flush all work items */
> > > -	flush_workqueue(doe_mb->work_queue);
> > >  }
> > >  
> > >  /**
> > > @@ -429,19 +404,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> > >  	if (rc)
> > >  		return ERR_PTR(rc);
> > >  
> > > -	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
> > > -						dev_driver_string(&pdev->dev),
> > > -						pci_name(pdev),
> > > -						doe_mb->cap_offset);
> > > -	if (!doe_mb->work_queue) {
> > > -		pci_err(pdev, "[%x] failed to allocate work queue\n",
> > > -			doe_mb->cap_offset);
> > > -		return ERR_PTR(-ENOMEM);
> > > -	}
> > > -	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
> > > -	if (rc)
> > > -		return ERR_PTR(rc);
> > > -
> > >  	/* Reset the mailbox by issuing an abort */
> > >  	rc = pci_doe_abort(doe_mb);
> > >  	if (rc) {
> > > @@ -496,23 +458,20 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > >  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> > >  
> > >  /**
> > > - * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > > + * pci_doe_submit_task_wait() - Submit and execute a task
> > >   *
> > >   * @doe_mb: DOE mailbox capability to submit to
> > > - * @task: task to be queued
> > > + * @task: task to be run
> > >   *
> > > - * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> > > - * Returns upon queueing the task object.  If the queue is full this function
> > > - * will sleep until there is room in the queue.
> > > - *
> > > - * task->complete will be called when the state machine is done processing this
> > > - * task.
> > > + * Submit and run DOE task (request/response) to the DOE mailbox to be
> > > + * processed.
> > >   *
> > >   * Excess data will be discarded.
> > >   *
> > > - * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> > > + * RETURNS: 0 when task was executed, the @task->rv holds the status
> > > + * result of the executed opertion, -ERRNO on failure to submit.
> > >   */
> > > -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > > +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > >  {
> > >  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> > >  		return -EINVAL;
> > > @@ -529,8 +488,8 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > >  		return -EIO;
> > >  
> > >  	task->doe_mb = doe_mb;
> > > -	INIT_WORK(&task->work, doe_statemachine_work);
> > > -	queue_work(doe_mb->work_queue, &task->work);
> > > +	exec_task(task);
> > > +
> > >  	return 0;
> > >  }
> > > -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> > > +EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
> > > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > > index ed9b4df792b8..c94122a66221 100644
> > > --- a/include/linux/pci-doe.h
> > > +++ b/include/linux/pci-doe.h
> > > @@ -30,8 +30,6 @@ struct pci_doe_mb;
> > >   * @response_pl_sz: Size of the response payload (bytes)
> > >   * @rv: Return value.  Length of received response or error (bytes)
> > >   * @complete: Called when task is complete
> > > - * @private: Private data for the consumer
> > > - * @work: Used internally by the mailbox
> > >   * @doe_mb: Used internally by the mailbox
> > >   *
> > >   * The payload sizes and rv are specified in bytes with the following
> > > @@ -50,11 +48,6 @@ struct pci_doe_task {
> > >  	u32 *response_pl;
> > >  	size_t response_pl_sz;
> > >  	int rv;
> > > -	void (*complete)(struct pci_doe_task *task);
> > > -	void *private;
> > > -
> > > -	/* No need for the user to initialize these fields */
> > > -	struct work_struct work;
> > >  	struct pci_doe_mb *doe_mb;
> > >  };
> > >  
> > > @@ -72,6 +65,5 @@ struct pci_doe_task {
> > >  
> > >  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> > >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > > -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > > -
> > > +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > >  #endif
> > > 
> > > 
> > 
> > good to see that we can have a sync interface.
> > I think that we still need some methods to garantee doe_task can be
> > handled one by one in doe_mb?  When more than one kernel thread are
> > going to transfer data over a same doe_mb, only one kernel thread can
> > use it and others will failed in exec_task().
> > 
> 
> Oh, good catch, yes, this likely needs a mutex_lock_interruptible() over
> exec_task(), or similar.

Indeed, good catch.  I'll get to this today; coded up and tested.

Thanks,
Ira
