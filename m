Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF162FE2C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiKRTqN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 14:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiKRTqM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 14:46:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7FDEBC;
        Fri, 18 Nov 2022 11:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668800771; x=1700336771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iKUJqYqRB5J6MjBTwYmRdI/WznIHQ+3guFxiZ3fGxhM=;
  b=YnXx5Z1eof/ULOqwmjl+SmOQEWUqmfR8ONyq1FTYSWaNmysi1v5grzJ9
   x1AcOddzAM3YJLBPVMhu73PNMmjOvVjRDokM2FzN4dL4vRsq83xB3CAg3
   n+s2aCszBvDXjUrjOu579UP8a8LBf1v3zx9C+uw+DeDKBOQfHqvtsunKo
   tn29q6PxiZ3k8+qjAQGbx7GFRZrsBsrfgi6QJrSXRe85/wh/a4Ts/dnT8
   euj2cEpPHSxYBt3yulqU6mbCP3nWkFAf5+JLS0qSFx0J/Jh2zRkkFPHAo
   Z9BWZ3mbSvFBAcAzStPFjFY2dVbdzszBbD94CaKV0sG1za++yxp3lakRm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313238596"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="313238596"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:46:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="765272336"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="765272336"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 18 Nov 2022 11:46:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 11:46:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 11:46:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 11:46:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 11:46:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUlHuz0yYcTaNmzQL8l4ijvFKwME9upSJcZ+UEAs+RSqIZ9uKcGGnIVZrx1LykB8yF9nVsc7s0a0Xveq2GKWajCHdIA0+W+aZJ6wkePaqmxKa1de61oI8ZgvL7eL1z1HB4TcQ4XJzB6CVx8Xm+cbxoFfTkcIjz59RUgmWKNMp8K9SjiNLv7vFW2buogproyHp1k8YzUT3FZBquOvISrRjY+aUYVphqFwFVv+h8HgvGilr6vIfHhY3YCHLHRHyQ8oL84gRBIsyiKZyf01gmeySYcl2K4KOceliE+g8ByOLN0iHISlF3a29l59pznYGsJgfjm3A+HQNABfs2212eP/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFVJD/456T6WeIxyLYL7tYX2gImFmyPRKol99/u0kCA=;
 b=KqhDW4pF0pWKJlfdRm40ht6fZu1zquIctDqT/5QNZ5YBCVxg0G6ePx4+vUqhFvM0mXZfN7OvTpHUK5NUfZHX97BWLgRcIVXWEGNWgetHVD6u5LgimfYpwlZNDhxWaFVAsK+rGzdiAz/BEnv9vFW/OmcwbFy1aOoJLZmguBjPklFwo9OTWrmMApk11vS1SM5lYLl9FXKpzlcm0OMWuBQCAFjC309YwZHMbhwuwYeU69K4cWAue7I6CsJuPoYJkHtx6C9w1hQpTtWMS0ZPt80uF8rqvmiXhGXuIRCFEUxHRRsuf5O4DJkKwANjB0KD2hJgsJb6ghxnJ3dRbKcCFp1eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB5016.namprd11.prod.outlook.com
 (2603:10b6:510:32::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 19:46:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 19:46:07 +0000
Date:   Fri, 18 Nov 2022 11:46:02 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        David Laight <David.Laight@aculab.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Message-ID: <6377e0fa50f1d_12cdff29425@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
 <Y3fSRbpjeC1CTPA1@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3fSRbpjeC1CTPA1@iweiny-desk3>
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1a013c-2670-433c-f427-08dac99d8838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDf83qAgOEU+pyvr11AMsawr4qhd7yWyCmtJbBj1fkWvlO91H8QjOYTN27/3OTV1KXqq5wYpyOAz889R6o3G7FMGshQLnjUeSyjUnXpqf/bA76FwOXbiK1MhADd3jBT13EN+gMRGCax1x8H4LWZ5QK1ievW/0QMHpIsVk2N5HFatSNTVNiBZrlew7EyYDuB5IIyn+gVbDJgGWq1/4VeUUSvmdp8jXkubboLb7w4J09is3zFyeCalpxv7VirdKdYX/RhLydbbwwBb7zkp2vTxqdMlU2nTNLnX8d5shX4ZD6doMzv1FbC40Ygnn40R6Yj/aoDlfigmpzkFQkotKB1rFuq8lvS5r1nk1KSGuv7wyAARqKtb4wyp5b2QMxpNzH/m8k0m7wvp9bNeOgxOOyBOpEpLn3S87UFvz4nhi3Ys56+1fMRXMslFXfOzkYuegSPOdEnsORJH/R0i6Pf5r9wHnj1Ji3hwaPm9Jg3CSSKi+dIJxfb+eRykXA7nWv48DP8w1qD/E7rkvwi9HLzSkGQsdOXHjWrSoIrIry/gdLXDNt+qPcnEbIG+NnQ1ILk8qOD7eVdOT9r+Dakn0qw9iepzpPjsoQq488ZueIe3H3zPGJXrm9n/I57dv+GYi0llYzAhilx9ErLWqB7Uy5uE9ihddnS7QtIS4y6m4hwtT15M84U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(38100700002)(82960400001)(26005)(6666004)(2906002)(6512007)(4326008)(110136005)(54906003)(316002)(83380400001)(966005)(6486002)(66946007)(478600001)(66476007)(8676002)(66556008)(8936002)(9686003)(186003)(86362001)(30864003)(41300700001)(6506007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lblEpUaxSlweg2yPlWeqK0eM97tVtXlraNy7uHJZF0KhHUSUeYPD7O1ZAbtV?=
 =?us-ascii?Q?vRh3e4IwfBnFqOIIwfWrt1kAVchch7OjPka4EGNF2tCdoLSBC3k/9w/tKNvZ?=
 =?us-ascii?Q?wptGvq00OCp4qA6XtyXZuIrd/yYkZrEitKD6V2qUs0f+KxUjs9TYrVnaLEZx?=
 =?us-ascii?Q?M7cjYLbyLr6o/F2Nd70l6C+Ng/VZw9Y5QH8NzRpvbvYlpz56R2oObnywElrd?=
 =?us-ascii?Q?SMnkN52ybxESwgV8tL9wUu1gmUc8BeCN9DzWllIZFybLDlE7Sv8vXLGy0Q5O?=
 =?us-ascii?Q?DiVys4cmHTF2xm3lLrvCysx7yOs2Iai1st6eiII3lUeAuI15hzxKszpLGe2C?=
 =?us-ascii?Q?gQ11ernoRLZSIcWU0M7CV7ALwJSPim7ecUCiQ87ROujaVX46nhtt3aXgybeD?=
 =?us-ascii?Q?pOEJwm8cqig92+4B0bFHH1NOsIPox3dubjRqxGpo18A3/C4VjzN0a+njPbwD?=
 =?us-ascii?Q?wVIr4I6dIoA40xzFJNXZpx5XB+hc0PhdvFIKLj1wxTxUcvPhSgsbQ2hJkmFU?=
 =?us-ascii?Q?rImQbK1JBYKFMvtjvEIcY2/n+9LhRI/hj8dVI5jrIpcn0uMRo4UDclwc0XFV?=
 =?us-ascii?Q?n7y/GFeyZacySZ97raahGPRNg55WNPmq+o2UW3ivub6yWaMcdNhIB0jaQQmt?=
 =?us-ascii?Q?MJq39Ap8196xW6aQF/s7IW9T6fu4FVgOcUWd20g0WrlpYhjqgPRaLsB1Lr2D?=
 =?us-ascii?Q?nm432UWcNsiEydlrcpCuo8R8qJdz3uwZ6IQkaTQ2yKuftqknnCV7AZG8pxQL?=
 =?us-ascii?Q?ovGfmeYgQmzCHmAVLRVr6UuuTKIWtaHFDceGP0ZKZuChgwRyRl4Xn5TWB2oX?=
 =?us-ascii?Q?1NI1o6yPJHzBqk6h2+yf4fugb3vXhciTT2CpjQLwXTSI8G4TdAyPMUbOMbdL?=
 =?us-ascii?Q?f3crx1AHqlXHt1mxlMq3AiqkfJ8iT+q5srppBleqvHaCcpssKKSDsrJcImLa?=
 =?us-ascii?Q?nhiqCQb5SV/6ygZM6OLwPY0OR5E68Tzs7nRhgl21XjXYrOah4nsV65pBtZON?=
 =?us-ascii?Q?SULAH+QVHu52svKTnxdJ3rTyXR6PHvVeTMXzJG1N7m0tctKs2toT+KlanZsO?=
 =?us-ascii?Q?UsIcBKUKsD3eLIr+yYEKPBRVZE/CDCqt3rPWDPd9HjHHGECZ7Nm9Ow4AHQzq?=
 =?us-ascii?Q?euzHIcWY3uN7vIyJ6xpNWUyye3jnBcF+9RRNyEBu2zOKR/v6+SPZCtqCGEDd?=
 =?us-ascii?Q?ClvrEeXvUHLAzlTRJ+8pAky8ldzvFIpEu4jUwAcvPlc/0K9KTDsEVVlS/XMv?=
 =?us-ascii?Q?K5Ay14fPklHExZKpv3aHBUzWJwkn3LqoiBn5gh9LUU0H40uU+git5Hd63lkg?=
 =?us-ascii?Q?x8j24b5+eXsoL03/XsqkmB82Onh1LLYtR3ofiiZG0RN9I9YSHCxM1IHEb2J1?=
 =?us-ascii?Q?xMoilSuVPHWDtGCzLAbWw06PJN9m3w4ckMuYbvQoQtPOoxGZ7uo3nmkAuyTg?=
 =?us-ascii?Q?4zJcebIA5WNrHaQuWD9f4H6z39NG3Vm3XedfEYHPiSIL/QWuEuCrl3xL08PE?=
 =?us-ascii?Q?ZzKp5nwsErGbdQD7sPRnEudd68HJJgbpL3Kl6egchZPhFpHXi1JyyrIKrIXQ?=
 =?us-ascii?Q?KkmaHf2Sf6xpDcQDagl0T0VZq0AKrzaUPoG+NBsduc+0fXIqvsPQfOvqiWPu?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1a013c-2670-433c-f427-08dac99d8838
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 19:46:07.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgPQXFuqVNd2Acbwn1vlTKB6dV0SKNgASMlXZaL2OHQwpM2W3pwxpkMSGhUpbUNS00fiS2kvVTYiK+QpPHUl/FqcGyukgVcUDBTeKM1Gqkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
> On Fri, Nov 18, 2022 at 09:20:38AM +0000, David Laight wrote:
> > From: ira.weiny@intel.com
> > > Sent: 18 November 2022 00:05
> > > 
> > > Work item initialization needs to be done with either
> > > INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> > > allocated.
> > > 
> > > The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> > > stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> > > 
> > > Jonathan suggested creating doe task allocation macros such as
> > > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > > function is not known to the callers and must be initialized correctly.
> > > 
> > > A follow up suggestion was to have an internal 'pci_doe_work' item
> > > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > > could restrict the context where tasks are used.
> > > 
> > > Another idea was to have an intermediate step to initialize the task
> > > struct with a new call.[3]  This added a lot of complexity.
> > > 
> > > Lukas pointed out that object_is_on_stack() is available to detect this
> > > automatically.
> > > 
> > > Use object_is_on_stack() to determine the correct init work function to
> > > call.
> > 
> > This is all a bit strange.
> > The 'onstack' flag is needed for the diagnostic check:
> > 	is_on_stack = object_is_on_stack(addr);
> > 	if (is_on_stack == onstack)
> > 		return;
> > 	pr_warn(...);
> > 	WARN_ON(1);
> > 
> 
> :-(
> 
> > So setting the flag to the location of the buffer just subverts the check.
> > It that is sane there ought to be a proper way to do it.
> 
> Ok this brings me back to my previous point and suggested patch.[*]  The
> fundamental bug is that the work item is allocated in different code from
> the code which uses it.  Separating the work item from the task.
> 
> [*] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> 
> Bjorn would this solution be acceptable and just use GFP_KERNEL and mark the
> required context for pci_doe_submit_task()?

It is a waste to have an allocation when one is not needed. The value of
having INIT_WORK_ONSTACK and DECLARE_COMPLETION_ONSTACK is to be clear
at the call site that an async context cares about this stack frame not
going out of scope.

However, coming full circle, we have zero async users today, and having
the completion and work struct in the task are causing a maintenance
burden. So let's just rip it out for now with something like the
following and circle back to add async support later when it becomes
necessary: (only compile tested)


diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0dbbe8d39b07..69873cdcc911 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -488,21 +488,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
 		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
 	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
 
-static void cxl_doe_task_complete(struct pci_doe_task *task)
-{
-	complete(task->private);
-}
-
 struct cdat_doe_task {
 	u32 request_pl;
 	u32 response_pl[32];
-	struct completion c;
 	struct pci_doe_task task;
 };
 
 #define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
 struct cdat_doe_task cdt = {                                  \
-	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
 	.request_pl = req,				      \
 	.task = {                                             \
 		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
@@ -511,8 +504,6 @@ struct cdat_doe_task cdt = {                                  \
 		.request_pl_sz = sizeof(cdt.request_pl),      \
 		.response_pl = cdt.response_pl,               \
 		.response_pl_sz = sizeof(cdt.response_pl),    \
-		.complete = cxl_doe_task_complete,            \
-		.private = &cdt.c,                            \
 	}                                                     \
 }
 
@@ -523,12 +514,12 @@ static int cxl_cdat_get_length(struct device *dev,
 	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
 	int rc;
 
-	rc = pci_doe_submit_task(cdat_doe, &t.task);
+	rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
 	if (rc < 0) {
 		dev_err(dev, "DOE submit failed: %d", rc);
 		return rc;
 	}
-	wait_for_completion(&t.c);
+
 	if (t.task.rv < sizeof(u32))
 		return -EIO;
 
@@ -552,12 +543,11 @@ static int cxl_cdat_read_table(struct device *dev,
 		u32 *entry;
 		int rc;
 
-		rc = pci_doe_submit_task(cdat_doe, &t.task);
+		rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
 		if (rc < 0) {
 			dev_err(dev, "DOE submit failed: %d", rc);
 			return rc;
 		}
-		wait_for_completion(&t.c);
 		/* 1 DW header + 1 DW data min */
 		if (t.task.rv < (2 * sizeof(u32)))
 			return -EIO;
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..115a8ff14afc 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -18,7 +18,6 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
-#include <linux/workqueue.h>
 
 #define PCI_DOE_PROTOCOL_DISCOVERY 0
 
@@ -40,7 +39,6 @@
  * @cap_offset: Capability offset
  * @prots: Array of protocols supported (encoded as long values)
  * @wq: Wait queue for work item
- * @work_queue: Queue of pci_doe_work items
  * @flags: Bit array of PCI_DOE_FLAG_* flags
  */
 struct pci_doe_mb {
@@ -49,7 +47,6 @@ struct pci_doe_mb {
 	struct xarray prots;
 
 	wait_queue_head_t wq;
-	struct workqueue_struct *work_queue;
 	unsigned long flags;
 };
 
@@ -211,7 +208,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 static void signal_task_complete(struct pci_doe_task *task, int rv)
 {
 	task->rv = rv;
-	task->complete(task);
 }
 
 static void signal_task_abort(struct pci_doe_task *task, int rv)
@@ -231,10 +227,9 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
 	signal_task_complete(task, rv);
 }
 
-static void doe_statemachine_work(struct work_struct *work)
+
+static void exec_task(struct pci_doe_task *task)
 {
-	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
-						 work);
 	struct pci_doe_mb *doe_mb = task->doe_mb;
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
@@ -295,18 +290,12 @@ static void doe_statemachine_work(struct work_struct *work)
 	signal_task_complete(task, rc);
 }
 
-static void pci_doe_task_complete(struct pci_doe_task *task)
-{
-	complete(task->private);
-}
-
 static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 			     u8 *protocol)
 {
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
 				    *index);
 	u32 response_pl;
-	DECLARE_COMPLETION_ONSTACK(c);
 	struct pci_doe_task task = {
 		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
 		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
@@ -314,17 +303,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 		.request_pl_sz = sizeof(request_pl),
 		.response_pl = &response_pl,
 		.response_pl_sz = sizeof(response_pl),
-		.complete = pci_doe_task_complete,
-		.private = &c,
 	};
 	int rc;
 
-	rc = pci_doe_submit_task(doe_mb, &task);
+	rc = pci_doe_submit_task_wait(doe_mb, &task);
 	if (rc < 0)
 		return rc;
 
-	wait_for_completion(&c);
-
 	if (task.rv != sizeof(response_pl))
 		return -EIO;
 
@@ -376,13 +361,6 @@ static void pci_doe_xa_destroy(void *mb)
 	xa_destroy(&doe_mb->prots);
 }
 
-static void pci_doe_destroy_workqueue(void *mb)
-{
-	struct pci_doe_mb *doe_mb = mb;
-
-	destroy_workqueue(doe_mb->work_queue);
-}
-
 static void pci_doe_flush_mb(void *mb)
 {
 	struct pci_doe_mb *doe_mb = mb;
@@ -393,9 +371,6 @@ static void pci_doe_flush_mb(void *mb)
 	/* Cancel an in progress work item, if necessary */
 	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
 	wake_up(&doe_mb->wq);
-
-	/* Flush all work items */
-	flush_workqueue(doe_mb->work_queue);
 }
 
 /**
@@ -429,19 +404,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
 	if (rc)
 		return ERR_PTR(rc);
 
-	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
-						dev_driver_string(&pdev->dev),
-						pci_name(pdev),
-						doe_mb->cap_offset);
-	if (!doe_mb->work_queue) {
-		pci_err(pdev, "[%x] failed to allocate work queue\n",
-			doe_mb->cap_offset);
-		return ERR_PTR(-ENOMEM);
-	}
-	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
-
 	/* Reset the mailbox by issuing an abort */
 	rc = pci_doe_abort(doe_mb);
 	if (rc) {
@@ -496,23 +458,20 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
 
 /**
- * pci_doe_submit_task() - Submit a task to be processed by the state machine
+ * pci_doe_submit_task_wait() - Submit and execute a task
  *
  * @doe_mb: DOE mailbox capability to submit to
- * @task: task to be queued
+ * @task: task to be run
  *
- * Submit a DOE task (request/response) to the DOE mailbox to be processed.
- * Returns upon queueing the task object.  If the queue is full this function
- * will sleep until there is room in the queue.
- *
- * task->complete will be called when the state machine is done processing this
- * task.
+ * Submit and run DOE task (request/response) to the DOE mailbox to be
+ * processed.
  *
  * Excess data will be discarded.
  *
- * RETURNS: 0 when task has been successfully queued, -ERRNO on error
+ * RETURNS: 0 when task was executed, the @task->rv holds the status
+ * result of the executed opertion, -ERRNO on failure to submit.
  */
-int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
+int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 {
 	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
 		return -EINVAL;
@@ -529,8 +488,8 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 		return -EIO;
 
 	task->doe_mb = doe_mb;
-	INIT_WORK(&task->work, doe_statemachine_work);
-	queue_work(doe_mb->work_queue, &task->work);
+	exec_task(task);
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_doe_submit_task);
+EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index ed9b4df792b8..c94122a66221 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -30,8 +30,6 @@ struct pci_doe_mb;
  * @response_pl_sz: Size of the response payload (bytes)
  * @rv: Return value.  Length of received response or error (bytes)
  * @complete: Called when task is complete
- * @private: Private data for the consumer
- * @work: Used internally by the mailbox
  * @doe_mb: Used internally by the mailbox
  *
  * The payload sizes and rv are specified in bytes with the following
@@ -50,11 +48,6 @@ struct pci_doe_task {
 	u32 *response_pl;
 	size_t response_pl_sz;
 	int rv;
-	void (*complete)(struct pci_doe_task *task);
-	void *private;
-
-	/* No need for the user to initialize these fields */
-	struct work_struct work;
 	struct pci_doe_mb *doe_mb;
 };
 
@@ -72,6 +65,5 @@ struct pci_doe_task {
 
 struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
 bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
-int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
-
+int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
 #endif


> > OTOH using an on-stack structure for INIT_WORK seems rather strange.
> > Since the kernel thread must sleep waiting for the 'work' to complete
> > why not just perform the required code there.
> 
> It is not strange if some task submitters want to wait while others do not.  It
> was suggested that all submit task operations be async and the callers who
> wanted to be synchronous would wait like this.
> 
> As Dan said there is a difference between submit_bio() and submit_bio_wait().
> 
> We have simply left the wait part up to the users who all wait right now.

Yeah, my bad for jumping ahead to worry about async when it is not yet
needed.
