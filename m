Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91009634806
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 21:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiKVUW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 15:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiKVUWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 15:22:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105310579;
        Tue, 22 Nov 2022 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669148574; x=1700684574;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nQAvIJfNSSdXfspi+Y02YyTHxNElTk0HFv8scvaW90E=;
  b=COs4UpRTWSMRgw/xuaRO/Z5Bi6J8zULCH2zxTmUS2hiS1avSyvrj3URX
   8CEzFmDDlwir074grWl6vBYHY5vqDZYAtGhwbMufU1sx+4sRSNRfba31j
   wV+26PQcsTDYIIA44w/1K2nTm+RJJJfKnpKRopyNlt3FwoHwwl2F1CR6y
   8EG369idrgSygYV1qBWc2BjQSCHsEsDJYre8E81yzaumeEtUHHZ1vHOYw
   3qf8HN/jLgHAju5H/LmlekP3269FCivu4GQhS9wnGYLTw6w/dd4UtrdsO
   WF0BJsMVTI1qNKeZBTmvFE4EPTmiHpQP2RMw/UdMiY/ewAbH4ZmaeQmQ6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="312608107"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="312608107"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="672612204"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="672612204"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 12:22:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 12:22:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 12:22:52 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 12:22:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGjjSFkDLxewMTa3U4GxnpDGDj8TC8wh5XzrOreC4CDotRWP8+SpH0Ki6dVpXNLmric90hH74DLvLs/hwbblKz6b3Jme6zzMFMcterGkfuICq+Qf31wjsu96cmZJHIYlQsYQxHgGReqzuh+goHN9OWXiBBf9Cbu2LA2tIoljJYgyQOuWzMJo4YeJQwUgcFaj0eSJQwiRp9z4zrI3MPnxSQ932iS3CkUkycqMa+T4mOZ+iI72zd/YMMtU6HZREc+4/9HJVjn6fX8WHJj7AetbaUIKxpBU7WNN9msNJi6fsXelG5J10ntTKSVWlBgJvR8iN0Wnbpvvim9cMwOCq3F5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXdu7CoRheAtjNDyAxj1SIN2vJ5ns2s7sJhy6j6ZyDQ=;
 b=lT0YJAWJf0S9J44QqSdEd1sLj4OBiX4DkhqNNKIomzuXxtp5FCPlLSaro96hq8tQKXejMYVyglqKxaQ4LaW+8FZ25TTZgpx/49sNV3JmvjBqBbSwje+98L7KOQ0DwV0yMk7JHfsjtKVdYZPZrbL/R8/jqY2c09W/JqrI5kg5da+UjfVo+VA2RuwhnTovN5lYKKUs8wZHJESFQuNuxaNFi2o3InFh329dKQw0zarVt3MO3nFAqLMLzc+XwZ+zTG/E7V0QrOG8RgXf2J9XV/KgJjraGu4tLBQ/pzY/RaGex/6kySi/kb0Ss30EVlbPYWYUTTQDdG5Oj5NaoPoUpOSiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB6309.namprd11.prod.outlook.com
 (2603:10b6:8:a8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 20:22:50 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 20:22:50 +0000
Date:   Tue, 22 Nov 2022 12:22:48 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>,
        David Laight <David.Laight@aculab.com>
CC:     "'ira.weiny@intel.com'" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Message-ID: <637d2f98db8b_12cdff29464@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
 <20221122171309.GA11310@wunner.de>
 <20221122171406.GC11310@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221122171406.GC11310@wunner.de>
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b3d563-80dd-4a80-256a-08daccc753d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z86HdE5dfnDmeMf/AUt2nOwsAnqyg0bc+kmJFtvAXFO2/XIKVlH7+ey56Hx8YF09+C2g9Xko8ttuhghPHlkzPrERUxoWVjQHjwBds9O3xw89UNSIfnbzgzQXdz26lVNRJdJZL4uu8EHvnJoSBQsOjTlKYdD0rM7r3jKvTFXduqsxOyoiBQiJ+vVtFN3EstsXa+ptbGMKV+dHhh7SvYyK5P8ApX9WlTZmII2uDTuvixpEsR8GOxRa43PKoaiLykly7WUDYMlANPJs7LiOEecU7/N1/I7G7LaBKSUMzaIN/SwOMR7sHHIzg2HNDUTE5RitBHUG2DZiDEs/wc5trLJbNEI+/lMRynMYfnNNf3ACfIZdq8lUqaTCEJlRMKEA7JgQCCvn0z+RQPKQnAsx3tASCxqn1ypqQkhd/J7goIZGlOygN+yhPEJh5mowr3ttaOZGZfe1UZAXZkG0abTOqeRrV/qUxivqcPdlbZ0ifs83MirsWR7nUNSzsM2xNH4IXuV4QCFpqKpAoAY/zcKshVbENdd8ub8ZEK04lOYMZcI1bpRLYETaQK75dMYP3lpFC0q57I69zEJQ1bSnH3COMIrqU1sH0g6LChpDuOU6kQLLWbtdtsq8uvaIlTnSPhCfx3UdOaYQZYgZWuizDWuyY4XJLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(478600001)(2906002)(83380400001)(7416002)(82960400001)(86362001)(6506007)(5660300002)(38100700002)(8676002)(110136005)(66556008)(54906003)(66476007)(66946007)(4326008)(316002)(6486002)(186003)(41300700001)(26005)(9686003)(8936002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0a74YU8kO3m9MCHDIyzAFpJfRvh/sskGs56nT2nOdRNesnkDT4xnlLNmdpy9?=
 =?us-ascii?Q?2eoCCuRPnpbSIoZrBJE/oFqwYauAs5SuMA7ppGbTNcm0QzHdHllFO7uSJAQa?=
 =?us-ascii?Q?s87gUchbhHrH+PC5npi2Hfb36oPh9aLmRfmDKoQMAZBFo6aTnyEYFgt4lhPt?=
 =?us-ascii?Q?l9vyFKbE+73S8+jMDPv9caO+/aLBZ5gXwSFAfFSz/I+yiSg5kRqNkMgZu+M6?=
 =?us-ascii?Q?808YEertWhRm+XsXSbCbJuue9daw+4cL3DKFxIL8/AVlE0ntbNB/K8alPSGX?=
 =?us-ascii?Q?YDSxXKD/pp15bAMGxV2nud3d9wFXX6aRPvreGcNfdzCCIOwo4K/JoK0TBS/f?=
 =?us-ascii?Q?Ma5RzELHYiJKXUWjpFoVbcDOOCq9NIM9qPp9GqYdYMSzwtBpD/2gFAONFlFc?=
 =?us-ascii?Q?ReXAr5wNerqTVyDj9kuiU4YrDrX+UzbsH+GpzyDboBfb1xzvKexZ06Y7B0ID?=
 =?us-ascii?Q?kjYMih+0raXBnzCHhbW9z9CdbxbD1jknEa0Gaygc4qfev/jOKCXPwwsc4N+J?=
 =?us-ascii?Q?zL8BcxnNJPkmUqefA15Tt0WnU6Pbg2NzAYIEa7HHkB2mazYTYOhP5zFrXhPj?=
 =?us-ascii?Q?zwLEIXBSE8lCqGT/SbmGJGZ/qKqxAxezcYtKbbz88iztNIlCa6T82y0IpjZI?=
 =?us-ascii?Q?qx002oYqtV9VUarNHhfWG80A/ob8StvFsLI49ID5Ubz4B3yZyANyNA2eZ2pc?=
 =?us-ascii?Q?kNyKAh/ChiIthkOvQp7R7llBGg0oJoGZRPilmlRb06/GqdneLyael6jUJKky?=
 =?us-ascii?Q?awptfmW0B4FESAplQUV7v9PcSsUUUES68rTFN6Hn+HqpUVuCDP6/H3ZBCmby?=
 =?us-ascii?Q?2NpyqlXsCsQ4xzs1WTPvsYBZk9Cu0OZvoZMhlsMgaFx5SfXgkH2dl5HLx2/2?=
 =?us-ascii?Q?DpwWxpg7tUefcNeb5fhmeP5RxLnpKOZQV0LgkIiK8h8lCG2m66YTdMIVKVz5?=
 =?us-ascii?Q?ILn4kruAl0pBxngbWYZkWNuH+YuRZLGQ5LCqwNIoS37iYvH2C1yazFzUgZbh?=
 =?us-ascii?Q?7E7dE6/7rhV5wJo+I8PX17Y8HSeA1BAdwe1H/0QByTvfJTfZha3JB9NrduEi?=
 =?us-ascii?Q?WP2V/4Um/xJiWSumHhwLGaFnvy7UFx8ETLbF4g9YOToUfTzizMoq7kAofxrk?=
 =?us-ascii?Q?B1BhB67udbhJ9RJllT74rm+6G01WuJFJ1tTv5S66gc0CLtREmUHWnyoP7JuB?=
 =?us-ascii?Q?elAi1RTK8bvdRSra0OtNgUufj9OtncHr4hM9luD+pz4f2s8XcAEJFxERzU5p?=
 =?us-ascii?Q?jcNvp+qnHv95A5+enIXQ4A8XdtsO9i4CtxngUY7q8qjo0WnTqE10QgbNj7nC?=
 =?us-ascii?Q?hO3VZkmBatxcYlBrsFY2ubNqAC4suT9ws5BZKGg4/wOszurHad5do+UFQLNp?=
 =?us-ascii?Q?Nn96wbhE6FiceG2kQPlGq6f7U7GpBnij7fk9vOX0Nt6X5GdVPK6rCs0Bk6HX?=
 =?us-ascii?Q?jgFH4GQZT3iFr7eqiv/wV1XbIteR+fWIvYQUrxQWZIulWNRoe2fe6yxjIwO7?=
 =?us-ascii?Q?4VJSjvdRkZI+XKbtWYjZUYMwsTPp0AE/gj6IHyzB1woID8KvSb0gcYupsPpB?=
 =?us-ascii?Q?qwCCD+fdQ3pPlbWJG1RR4hPYqay9/SNVZQtNhwZSXdpM5i+8qX2wo0qfe5iI?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b3d563-80dd-4a80-256a-08daccc753d9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 20:22:50.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWA4JO0DhaHm8RP+LDQSuJ/UkfGAXGl6Luk1VsKMN9uIiRf8uuZpFQzS99cjj6l1+W0vQHfhxHY1HCCax+3kQKNv+gJbBwnFJHiIG6lyAy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> Now with Thomas added to cc for real.
> 
> On Tue, Nov 22, 2022 at 06:13:09PM +0100, Lukas Wunner wrote:
> > [+cc Thomas Gleixner, author of dc186ad741c1]
> > 
> > On Fri, Nov 18, 2022 at 09:20:38AM +0000, David Laight wrote:
> > > > From: ira.weiny@intel.com
> > > > Sent: 18 November 2022 00:05
> > > > 
> > > > Work item initialization needs to be done with either
> > > > INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> > > > allocated.
> > > > 
> > > > The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> > > > stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> > > > 
> > > > Jonathan suggested creating doe task allocation macros such as
> > > > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > > > function is not known to the callers and must be initialized correctly.
> > > > 
> > > > A follow up suggestion was to have an internal 'pci_doe_work' item
> > > > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > > > could restrict the context where tasks are used.
> > > > 
> > > > Another idea was to have an intermediate step to initialize the task
> > > > struct with a new call.[3]  This added a lot of complexity.
> > > > 
> > > > Lukas pointed out that object_is_on_stack() is available to detect this
> > > > automatically.
> > > > 
> > > > Use object_is_on_stack() to determine the correct init work function to
> > > > call.
> > > 
> > > This is all a bit strange.
> > > The 'onstack' flag is needed for the diagnostic check:
> > > 	is_on_stack = object_is_on_stack(addr);
> > > 	if (is_on_stack == onstack)
> > > 		return;
> > > 	pr_warn(...);
> > > 	WARN_ON(1);
> > > 
> > > So setting the flag to the location of the buffer just subverts the check.
> > > It that is sane there ought to be a proper way to do it.
> > 
> > If object_is_on_stack() is sufficient to check whether a struct
> > is on the stack or not, why doesn't __init_work() use it to
> > auto-detect whether to call debug_object_init_on_stack() or
> > debug_object_init()?
> > 
> > Forcing developers to use a specific initializer for something
> > that can be auto-detected is akin to treating them like kids
> > and telling them "You didn't say the magic word."
> > 
> > What's the point?

I had this initial reaction as well, but INIT_WORK_ONSTACK() documents
an important detail of the object's lifetime. Here are 2 examples of
functions that would become trickier to read if the kernel did a
global s/INIT_WORK_ONSTACK()/INIT_WORK()/

    synchronize_rcu_expedited_queue_work()
    insert_wq_barrier()

...where those take arguments that are known to come from the stack and
be used in async context.
