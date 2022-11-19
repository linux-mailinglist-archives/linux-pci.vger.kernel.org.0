Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893F630C01
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 06:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKSFMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 00:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKSFML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 00:12:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272582BDD;
        Fri, 18 Nov 2022 21:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668834729; x=1700370729;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gNG1CTH6MzoN6TgfXIFDB7VJqyZxT9+1TghHTKjQzYA=;
  b=jiqcObjxkWDDTan2WGirN81uvkblO4dDSRKQVz14C7SZC381fK0QuNFO
   K0HnZvTWPejftO1cNLrmdKWy64Ok+FCLkEgwFjKV7zP/sTJYY1dif6FFv
   UBxFkz4Si8BneNG8qeMYgTgF5lQrDzpknyJC4gL2BZuvKo3xpi51jPm3v
   kdBkHKDXQA6A0e+l62kti2vdBI6fyuiuYjY3quGcq5sgrAl773aGSLDmA
   zAi1yrnGJahNz6WCeNDD3UxCw6V7UXF+Ug5TEEmCQHb3KtXSrhK+hIPjY
   PfzsYSkhoJroID8vLoYARZ6vJdKYfaTRp3a3ciZDghmYMg1Izp5lGzbyG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="311994683"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="311994683"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 21:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="885545474"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="885545474"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2022 21:12:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 21:12:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 21:12:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 21:12:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 21:12:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVtErpPpIgWBgV6AFdM3KLJ8HlB9pfAKfG4OGltJfn5Fxa6v2kAL+7+i5Zug/OFk90N2ixG+JrlV9r0ynX+2vGlczcLpWRSO3qDcbMSCY4Z3DcNcB6bYRFnsRwp1d1FIBh2mLq2TuQB8+qBtCqi6IGnYzpvnPb3tVhSXsf7PHC7Iy1T+7iEnS+E2/ux3SxUSyy8sZiJndVmOvS+L3pvk6whiQqgbDvc0kxfr2TlihBxiitt2Dm3f1+XQu18e6UYxoOvvM3OQjocPhr0p10xVt5519n6n15jhIh4bjourAKMsb2hic+y5OAa2Vrk2/RjfQLisHPKo6Uf/FUB1WgIvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQcZHdT20RqGxx6Y0RYQuIoen7AcMyYOx/usEdcC0mw=;
 b=aMbV1xqg6EnUKcaNVNxIh7iebn0qJgEPkAYaGe4Szvd96c+K26EwylUiOaXDF3ikgfcwZ/97PqpXPbyu+gOk5295WjBqKGvcyHHgXIBBxKQwzv5SVCq2xO2YKHmnw9fZVynxmDeoqId1JKYB1bynhJ27gPzsZooVfW/6U5Wq3ZYWtp+zb5868dVZar0RJAZCtdJzeLnhnjIENfF7tgYAiSI7eVhLvnEdSk+bQYSbM0OhB52Ut1LJ9Y4uKXoCPB6AubuMglqf6eZhWC+0bzdQsIas10yX5w9OMDjTTGsweN1XrXLdsOtgiDQGFD0T1YAw56I7dJryX7C2QqXIkTLqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH3PR11MB7321.namprd11.prod.outlook.com
 (2603:10b6:610:150::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 05:12:01 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 05:12:01 +0000
Date:   Fri, 18 Nov 2022 21:11:58 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Li, Ming" <ming4.li@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Laight <David.Laight@aculab.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Message-ID: <6378659e433be_1ee2429488@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
 <Y3fSRbpjeC1CTPA1@iweiny-desk3>
 <6377e0fa50f1d_12cdff29425@dwillia2-xfh.jf.intel.com.notmuch>
 <7bb72f37-9da0-2406-cbc4-d9b0f879320a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7bb72f37-9da0-2406-cbc4-d9b0f879320a@intel.com>
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CH3PR11MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d41d9b1-f256-4fb7-4fff-08dac9ec96e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fs2NeF7LerOg1BOLJOMyyyMVC6y10i0Axdxva+XbAcVUfVSGt/5+aRwD/ZUa5MdpSVDd4Nr0ALJBHUAPBKlJyFv1IcHx4l2e5CEziDzOrLcwI4zeyZieJpRku3JYnAqnpods87HfUKWZtA1j2Xyjc6WNfy8kaKm85ve8pG0shnZHzRTbT6genONybw9qvI8QIKgtuo72lq0TKQi6hWQ2Wq1BcTdL8dLsLpLI923jTOSObdVEdzoOxqbEWz+1wu/+TYzhB+5XQ2G48VOkmZUBMQeuP20GQi22ORefDCdP+nYMt9b9sHaDcvNW7Ljz+UH3+lgtIWnd926JqqgJ0AigXhus6XSFBKx8368SdasVI4qdL4qmeLzL2uDQnUOfLpiGgypX3JRXHUqa3JpwAI0bYGrr843L2BIa5T+h0I8Mb1IalrCRh2bFQNUaLdWE5chaf9IwTWoxbblcm6LmCN/KfRpVXssXpOKu4W49fEyATc5adqkCLnCetYuyjZ9zrjG0LjV0nhhbLUVtJTlmlkexoApGwt3FQH1GbmD8Rm3PHnt8/m2rrUdJycrw+CwBT1CaeYKKjbrYzAgk++9knSeYRpU5UGqPaPTQMAuQg+BsVsW+a2jS9OPeNpuXEDAZ7t1SqjrGMUz1Xj+YsUR6FwJH5E7umvozBkVwnHzy48QVRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(110136005)(6506007)(54906003)(478600001)(316002)(6512007)(6666004)(9686003)(66946007)(53546011)(26005)(66476007)(8676002)(66556008)(6486002)(186003)(966005)(4326008)(41300700001)(8936002)(5660300002)(2906002)(83380400001)(30864003)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WGqnBkaVhdBAzr0b6eQf2ndhCyWIYTtzHMFU09cJj9tlyY+bLFg+SMH0Pmcy?=
 =?us-ascii?Q?P71RB54xWHwRiOeGRZ/Iow4Zf8luMPEjmhpzXLv6arY5zZiv1mt352fntUjk?=
 =?us-ascii?Q?58l85j6Wx9XEV/bJCohOFXodmLUPQvk3ucBWUcXrCecpG8vCppzC1gjpNhCu?=
 =?us-ascii?Q?4/yWJ6swcu3YIPRJuFP63oGTixT4397kvGcPxa8yC+cYOmn5lJUQaLHM7fK8?=
 =?us-ascii?Q?CPO7nhP2jXPcFDU7IrPLWfmdHDW2SqfNVPlrsGE3cEPZTAMwd8H8DQGqU0ej?=
 =?us-ascii?Q?5yWCwv3SH9h0ezkf5XXBcP0H2jwDxMY6afGg23UHYJChFftH8jzMIkTt4NFP?=
 =?us-ascii?Q?wp8AQSVgESZOK5B8jXdMFMUFmHYq12YhUtHFKfGONvVm66FgtvcmJbaTEpMj?=
 =?us-ascii?Q?uGWffgwOuEhqkgaAmM8lUEvo2bybcKeeMy9t497Autbfe2+boheTylYijJwY?=
 =?us-ascii?Q?xiW2cLl/bh+qoUG7Qj4BIgpyBfflHj04jhM9DTjqB1S2J4hMd3kooE/8QPHK?=
 =?us-ascii?Q?6Wz5U2MvRWRm5MTSDf+QBrGeWtOzPIlpSu8VrctrIPIb1R6dnQyhDbkY138S?=
 =?us-ascii?Q?zzZeHWhXVfWks7mpW4eQA/M4Uv9OhTnCqoXlZ0CYwwhcrtj243EJ8q1xRSMl?=
 =?us-ascii?Q?A5I9XRwZFtowKOzVD6N15YaDI86AvLJv0edJcEnHkSEfsKYbFwLfwFmEjIEE?=
 =?us-ascii?Q?k2t9g9RP4fe0pp9K9aSJsAmq2pk2LOdA6amanNoijod0mb+mDJqmoFGca+mf?=
 =?us-ascii?Q?WWKhs85fz95AY1PmDL/+GdJePoIC57igvuWNl4Svw1V7bm3Xw9P+PUkAqW19?=
 =?us-ascii?Q?uX0rLHvG+T+RVa8RpCxisOBS8WsZ5gst9vcX6NQwhBC01nK/FKGFzyBWr5Wb?=
 =?us-ascii?Q?XUEgkJWWHbdZw3+xb2KU7urgLMKNSJ38Vlb3CT/WjJB44UNnXvSkUtsi4ZRJ?=
 =?us-ascii?Q?Ap91zjsiP2d7C40MS59nQE6Vt4tCit7i8jvGyarG9wPN7qiRehuh0cwzxJ1R?=
 =?us-ascii?Q?AlcuRFMJCRScDOkQaMmXIZ9xTJCgTBLd6W3acBlUnxJO/VAVu3dfx/RoF7zZ?=
 =?us-ascii?Q?3gynwC/aC7RHiUt1tIMG/LcFdWsuCuMj8sohhhYeFZeWaCTSdNH8OV1b3znm?=
 =?us-ascii?Q?3xkQz1xjN1ymazFkGeZ5R80E6JqSwOSfd/5XybCVs1jw4gl4z8Y6nzsmkQDL?=
 =?us-ascii?Q?tTKtvHBPlZea/V6OC4IV/z94vr590c0bOgjkK50qWeCldI8icCLrbDjuLoK3?=
 =?us-ascii?Q?0QSSSkwCuxpAgu63HHb2B9P1YWwyeuov/1NIu+KtzPSKpvqiShpsGmo3L3bh?=
 =?us-ascii?Q?w9TyvQWqoY/PP6KetS/YT80UjVBeXqORzy00DWK99wQK4ixuBCX1qHu7kMi7?=
 =?us-ascii?Q?ZbdmuuWH7jWSTNHt4jVRb9BGCLnGYb9KYLL0Xb0ATaQ2vLdmqoCyV0jJtLzX?=
 =?us-ascii?Q?k0DzmuRilECnzzWfsh5mYXIdIJxldA1+gX9fnD8rw+mXqYnvIih5uVqAHElr?=
 =?us-ascii?Q?+FcWpQSG/z1YMHfsIpzWVzwrcOypJ54yF4iW9XnXHnglTAknG1grXgs4k8J+?=
 =?us-ascii?Q?mdZ4mTjHSEkIKoGmuDqfUbIMWe8KKLxHiTDlcieHUyU7KTjNL7VfV8zRRABb?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d41d9b1-f256-4fb7-4fff-08dac9ec96e6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 05:12:01.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/Vm0So3yUV6JZRCt3nx7u0iJK2nDQL6S/pl1hwk0T/wT5kBtUoMT/dUNrifo7tKBAAjNQhYxSsjPghWJPT7rM/SRdzRB6FMwFwUMWfxIO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Li, Ming wrote:
> On 11/19/2022 3:46 AM, Dan Williams wrote:
> > Ira Weiny wrote:
> >> On Fri, Nov 18, 2022 at 09:20:38AM +0000, David Laight wrote:
> >>> From: ira.weiny@intel.com
> >>>> Sent: 18 November 2022 00:05
> >>>>
> >>>> Work item initialization needs to be done with either
> >>>> INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> >>>> allocated.
> >>>>
> >>>> The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> >>>> stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> >>>>
> >>>> Jonathan suggested creating doe task allocation macros such as
> >>>> DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> >>>> function is not known to the callers and must be initialized correctly.
> >>>>
> >>>> A follow up suggestion was to have an internal 'pci_doe_work' item
> >>>> allocated by pci_doe_submit_task().[2]  This requires an allocation which
> >>>> could restrict the context where tasks are used.
> >>>>
> >>>> Another idea was to have an intermediate step to initialize the task
> >>>> struct with a new call.[3]  This added a lot of complexity.
> >>>>
> >>>> Lukas pointed out that object_is_on_stack() is available to detect this
> >>>> automatically.
> >>>>
> >>>> Use object_is_on_stack() to determine the correct init work function to
> >>>> call.
> >>>
> >>> This is all a bit strange.
> >>> The 'onstack' flag is needed for the diagnostic check:
> >>> 	is_on_stack = object_is_on_stack(addr);
> >>> 	if (is_on_stack == onstack)
> >>> 		return;
> >>> 	pr_warn(...);
> >>> 	WARN_ON(1);
> >>>
> >>
> >> :-(
> >>
> >>> So setting the flag to the location of the buffer just subverts the check.
> >>> It that is sane there ought to be a proper way to do it.
> >>
> >> Ok this brings me back to my previous point and suggested patch.[*]  The
> >> fundamental bug is that the work item is allocated in different code from
> >> the code which uses it.  Separating the work item from the task.
> >>
> >> [*] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> >>
> >> Bjorn would this solution be acceptable and just use GFP_KERNEL and mark the
> >> required context for pci_doe_submit_task()?
> > 
> > It is a waste to have an allocation when one is not needed. The value of
> > having INIT_WORK_ONSTACK and DECLARE_COMPLETION_ONSTACK is to be clear
> > at the call site that an async context cares about this stack frame not
> > going out of scope.
> > 
> > However, coming full circle, we have zero async users today, and having
> > the completion and work struct in the task are causing a maintenance
> > burden. So let's just rip it out for now with something like the
> > following and circle back to add async support later when it becomes
> > necessary: (only compile tested)
> > 
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 0dbbe8d39b07..69873cdcc911 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -488,21 +488,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
> >  		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> >  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> >  
> > -static void cxl_doe_task_complete(struct pci_doe_task *task)
> > -{
> > -	complete(task->private);
> > -}
> > -
> >  struct cdat_doe_task {
> >  	u32 request_pl;
> >  	u32 response_pl[32];
> > -	struct completion c;
> >  	struct pci_doe_task task;
> >  };
> >  
> >  #define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
> >  struct cdat_doe_task cdt = {                                  \
> > -	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
> >  	.request_pl = req,				      \
> >  	.task = {                                             \
> >  		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
> > @@ -511,8 +504,6 @@ struct cdat_doe_task cdt = {                                  \
> >  		.request_pl_sz = sizeof(cdt.request_pl),      \
> >  		.response_pl = cdt.response_pl,               \
> >  		.response_pl_sz = sizeof(cdt.response_pl),    \
> > -		.complete = cxl_doe_task_complete,            \
> > -		.private = &cdt.c,                            \
> >  	}                                                     \
> >  }
> >  
> > @@ -523,12 +514,12 @@ static int cxl_cdat_get_length(struct device *dev,
> >  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> >  	int rc;
> >  
> > -	rc = pci_doe_submit_task(cdat_doe, &t.task);
> > +	rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
> >  	if (rc < 0) {
> >  		dev_err(dev, "DOE submit failed: %d", rc);
> >  		return rc;
> >  	}
> > -	wait_for_completion(&t.c);
> > +
> >  	if (t.task.rv < sizeof(u32))
> >  		return -EIO;
> >  
> > @@ -552,12 +543,11 @@ static int cxl_cdat_read_table(struct device *dev,
> >  		u32 *entry;
> >  		int rc;
> >  
> > -		rc = pci_doe_submit_task(cdat_doe, &t.task);
> > +		rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
> >  		if (rc < 0) {
> >  			dev_err(dev, "DOE submit failed: %d", rc);
> >  			return rc;
> >  		}
> > -		wait_for_completion(&t.c);
> >  		/* 1 DW header + 1 DW data min */
> >  		if (t.task.rv < (2 * sizeof(u32)))
> >  			return -EIO;
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index e402f05068a5..115a8ff14afc 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -18,7 +18,6 @@
> >  #include <linux/mutex.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-doe.h>
> > -#include <linux/workqueue.h>
> >  
> >  #define PCI_DOE_PROTOCOL_DISCOVERY 0
> >  
> > @@ -40,7 +39,6 @@
> >   * @cap_offset: Capability offset
> >   * @prots: Array of protocols supported (encoded as long values)
> >   * @wq: Wait queue for work item
> > - * @work_queue: Queue of pci_doe_work items
> >   * @flags: Bit array of PCI_DOE_FLAG_* flags
> >   */
> >  struct pci_doe_mb {
> > @@ -49,7 +47,6 @@ struct pci_doe_mb {
> >  	struct xarray prots;
> >  
> >  	wait_queue_head_t wq;
> > -	struct workqueue_struct *work_queue;
> >  	unsigned long flags;
> >  };
> >  
> > @@ -211,7 +208,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
> >  static void signal_task_complete(struct pci_doe_task *task, int rv)
> >  {
> >  	task->rv = rv;
> > -	task->complete(task);
> >  }
> >  
> >  static void signal_task_abort(struct pci_doe_task *task, int rv)
> > @@ -231,10 +227,9 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
> >  	signal_task_complete(task, rv);
> >  }
> >  
> > -static void doe_statemachine_work(struct work_struct *work)
> > +
> > +static void exec_task(struct pci_doe_task *task)
> >  {
> > -	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> > -						 work);
> >  	struct pci_doe_mb *doe_mb = task->doe_mb;
> >  	struct pci_dev *pdev = doe_mb->pdev;
> >  	int offset = doe_mb->cap_offset;
> > @@ -295,18 +290,12 @@ static void doe_statemachine_work(struct work_struct *work)
> >  	signal_task_complete(task, rc);
> >  }
> >  
> > -static void pci_doe_task_complete(struct pci_doe_task *task)
> > -{
> > -	complete(task->private);
> > -}
> > -
> >  static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> >  			     u8 *protocol)
> >  {
> >  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> >  				    *index);
> >  	u32 response_pl;
> > -	DECLARE_COMPLETION_ONSTACK(c);
> >  	struct pci_doe_task task = {
> >  		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> >  		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > @@ -314,17 +303,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> >  		.request_pl_sz = sizeof(request_pl),
> >  		.response_pl = &response_pl,
> >  		.response_pl_sz = sizeof(response_pl),
> > -		.complete = pci_doe_task_complete,
> > -		.private = &c,
> >  	};
> >  	int rc;
> >  
> > -	rc = pci_doe_submit_task(doe_mb, &task);
> > +	rc = pci_doe_submit_task_wait(doe_mb, &task);
> >  	if (rc < 0)
> >  		return rc;
> >  
> > -	wait_for_completion(&c);
> > -
> >  	if (task.rv != sizeof(response_pl))
> >  		return -EIO;
> >  
> > @@ -376,13 +361,6 @@ static void pci_doe_xa_destroy(void *mb)
> >  	xa_destroy(&doe_mb->prots);
> >  }
> >  
> > -static void pci_doe_destroy_workqueue(void *mb)
> > -{
> > -	struct pci_doe_mb *doe_mb = mb;
> > -
> > -	destroy_workqueue(doe_mb->work_queue);
> > -}
> > -
> >  static void pci_doe_flush_mb(void *mb)
> >  {
> >  	struct pci_doe_mb *doe_mb = mb;
> > @@ -393,9 +371,6 @@ static void pci_doe_flush_mb(void *mb)
> >  	/* Cancel an in progress work item, if necessary */
> >  	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> >  	wake_up(&doe_mb->wq);
> > -
> > -	/* Flush all work items */
> > -	flush_workqueue(doe_mb->work_queue);
> >  }
> >  
> >  /**
> > @@ -429,19 +404,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  
> > -	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
> > -						dev_driver_string(&pdev->dev),
> > -						pci_name(pdev),
> > -						doe_mb->cap_offset);
> > -	if (!doe_mb->work_queue) {
> > -		pci_err(pdev, "[%x] failed to allocate work queue\n",
> > -			doe_mb->cap_offset);
> > -		return ERR_PTR(-ENOMEM);
> > -	}
> > -	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > -
> >  	/* Reset the mailbox by issuing an abort */
> >  	rc = pci_doe_abort(doe_mb);
> >  	if (rc) {
> > @@ -496,23 +458,20 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> >  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> >  
> >  /**
> > - * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > + * pci_doe_submit_task_wait() - Submit and execute a task
> >   *
> >   * @doe_mb: DOE mailbox capability to submit to
> > - * @task: task to be queued
> > + * @task: task to be run
> >   *
> > - * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> > - * Returns upon queueing the task object.  If the queue is full this function
> > - * will sleep until there is room in the queue.
> > - *
> > - * task->complete will be called when the state machine is done processing this
> > - * task.
> > + * Submit and run DOE task (request/response) to the DOE mailbox to be
> > + * processed.
> >   *
> >   * Excess data will be discarded.
> >   *
> > - * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> > + * RETURNS: 0 when task was executed, the @task->rv holds the status
> > + * result of the executed opertion, -ERRNO on failure to submit.
> >   */
> > -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  {
> >  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> >  		return -EINVAL;
> > @@ -529,8 +488,8 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  		return -EIO;
> >  
> >  	task->doe_mb = doe_mb;
> > -	INIT_WORK(&task->work, doe_statemachine_work);
> > -	queue_work(doe_mb->work_queue, &task->work);
> > +	exec_task(task);
> > +
> >  	return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> > +EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > index ed9b4df792b8..c94122a66221 100644
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -30,8 +30,6 @@ struct pci_doe_mb;
> >   * @response_pl_sz: Size of the response payload (bytes)
> >   * @rv: Return value.  Length of received response or error (bytes)
> >   * @complete: Called when task is complete
> > - * @private: Private data for the consumer
> > - * @work: Used internally by the mailbox
> >   * @doe_mb: Used internally by the mailbox
> >   *
> >   * The payload sizes and rv are specified in bytes with the following
> > @@ -50,11 +48,6 @@ struct pci_doe_task {
> >  	u32 *response_pl;
> >  	size_t response_pl_sz;
> >  	int rv;
> > -	void (*complete)(struct pci_doe_task *task);
> > -	void *private;
> > -
> > -	/* No need for the user to initialize these fields */
> > -	struct work_struct work;
> >  	struct pci_doe_mb *doe_mb;
> >  };
> >  
> > @@ -72,6 +65,5 @@ struct pci_doe_task {
> >  
> >  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > -
> > +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> >  #endif
> > 
> > 
> 
> good to see that we can have a sync interface.
> I think that we still need some methods to garantee doe_task can be
> handled one by one in doe_mb?  When more than one kernel thread are
> going to transfer data over a same doe_mb, only one kernel thread can
> use it and others will failed in exec_task().
> 

Oh, good catch, yes, this likely needs a mutex_lock_interruptible() over
exec_task(), or similar.
