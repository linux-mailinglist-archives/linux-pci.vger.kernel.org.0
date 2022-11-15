Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D618662A37E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 21:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiKOUyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 15:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiKOUyv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 15:54:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C753B4;
        Tue, 15 Nov 2022 12:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668545690; x=1700081690;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K0ZDEg2yWT0CtsPQQ9ODXbntvWCu3WwldSsSq3R1iyE=;
  b=CqsP+vbmB+oijoNBo++xGnd76y0QVfPTk5c5zNMdZbRbAhf1LR+p5h4v
   MDzc8VCVqwgPAgdVk6cN3kL0IJUpyXp7/y3AwO/BrYQHRckZC7JCRDJaF
   0fcNF0gFwmhAEw4Mi/4Cr4qH02htz2Q35+V0M5lNXfw3UGTfHk/VwxCBV
   X4sI1aJ1C+WaIBxKsKm6adaujMlW+l6lGTucegpGx88IaITF1DY4ni7Ng
   nygbYF/9MQ5lJsczdGR72hKBwNlcSh2Gxo/R14xOnVXT1i4XjINz7Tlrj
   XMe8ZzlPyn1wDC+qZLbcTZKMr2gIXx64Jt+fQT/PmcPyxyJvMEyEaK+Ad
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="376636764"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="376636764"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744748178"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="744748178"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 12:54:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:54:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:54:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:54:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:54:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFpSW4eEkTKecyfLpREYT3QKvvFXEuXEhkpDY9qDJ8Ft6f8x6hC9ryk343UyWS21qvz8CscU1kbED4GIiOIUtN7S4wTw7MybEzuviyf9nEP6fVF0hX7e+YuYJOzhRfFFERShVOhz1hZ/yTJ7vV63sn9BSFozTNMV0oimfnUA70gtJe2V6Mh/9+jDzEGzkhcC3oy/yLWi8UHFp9rcm/oPO0vHSNPzfqDWwebkeT3GdhC11HAnjGB97ImSTX0sQkkP+Muzn9ZsQ2ddlX5y+YoP4DtGkTMO8fkZh12K7cab2YYVIEKIhLOQ7IlxncUapmlTgQJ0bIM6rrSr8+Yi70ZCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSRpE62GDvBn2tTZXPLGxtQR03WAQ9XjDAzh1Z4PShQ=;
 b=ML3LdWBhfweUZ38pNhHjuLn/Jjgc1Fjdf4V5+GIe9fI485wm+0+1uF7Gzt2OvYI/a64td6mWzJ5CjlkrW0L7swuJn1ABaXJebbXws8s4Jpwia+f8CCS0HZE1Tut9ht2jacMcjsGYrjpzR9PJsisRXON438APQ+dBdPKnxQbeqCYOJzRIuBHuoGGqcbQuXZWf2CMYlZajHNwkIJgzUUwB8mQNE2b5j9xd7afUVENJfBmmWmOWX75A98qnarXYL136j8mpWN42trLx6PEbOV++19gNYet3iJGheVPwiSawesNljcOIvR5z011rWszGYZ7WxWfsgdAh6qDyf5QxRoFDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5547.namprd11.prod.outlook.com (2603:10b6:408:104::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 20:54:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 20:54:44 +0000
Date:   Tue, 15 Nov 2022 12:54:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/doe: Fix work struct declaration
Message-ID: <Y3P8jyhGDIjSAoTT@iweiny-mobl>
References: <Y3P0Hp7eK3V7xRLN@iweiny-mobl>
 <20221115204135.GA1037921@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221115204135.GA1037921@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d60e87d-e6dd-478a-9c90-08dac74b9fb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SRHlJDipi76wZlIhbm8MfZNbTPHoa6k2CXhU8EILmzr2LX8Rl7O98j3BWewA9Z7n8lg5BIO0kTJ4RK1nIT5RyT7j4onU0v93kdC9bZHbqbd0stZ/90h+k6jvtmTvJBBTPbWFhM9L2yUizi74mYyoNRY+pTiVBCOR1m8553I7hkmXg6/Qs03Jk3qGc7t/oJXhNTOrx5EhJBk077moq+zmgJ/kybY65Af1QHGr7GW3SRcRvgl8w4zPOfdjxTIn22RtcEd3yR7IgIe/ZfLjDxmEG9WJjaH5doRabzvBcm8kNZ1xC2n0jTCFn8zK9mClg6FyJLCtswtUwi4bHbzBySjv1Z5RdQp139OFirvJgOkQkd+f4JPoeJQZJ1nL1bflFbfOdm9V0SqCRacBC5ZI34vwzIYFimcZ7lYWzxl3iDDML05fb87eu+lNpTgkhsTuhtLADWLy5jKHNCkEeQNuWfwl3iTCuW6SGiKbbdqD/7vt5AaFqoIs5B3r0sinTIQDZf0snmwegLs8kodZ5Yg7cTK9JPNfDAX1IMSQ1BYREko4zziQFvBEgu+CEVtGcnqyCZptrB6nGnpcoDJkabb7TFicXrZEbej5uMDk04Wx+9z1E8Jk0JX5Q/g5CWSnJ/Yfcr/ZUU/REVzDBoiLk0ZIJWy+8+GDdObNw88lJJYst/jqFHNM8/DsQIgWUSlOD0uXP2+L4QFXA0N/lZL6etzDnxIP852nZ7aAEwfn4VP9FmmdZu70EfEAq7z4RcRBBkfkzQyG0Y9JR5phZ/VBqrYe7pfqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(6512007)(9686003)(86362001)(38100700002)(66556008)(66946007)(66476007)(8676002)(4326008)(316002)(478600001)(5660300002)(33716001)(186003)(44832011)(2906002)(41300700001)(82960400001)(6486002)(8936002)(966005)(83380400001)(6666004)(6506007)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AjHNJGmyEk8Evl+1XR1MUWauC5DI+KD1zOz+3FDlZYctQwFQDkACFbLM3EJz?=
 =?us-ascii?Q?3V3NF+FlCXiOIq8WuRRMa/OkcVL9h8JKrRdhQ9mxbCOUOF3xqURYdbrOVv47?=
 =?us-ascii?Q?sJ4uBGFBQfuuUzP49csTigchuji1Mff8MluDlyQJQGZ90dCKFtKMvGEv5W/P?=
 =?us-ascii?Q?j2YYkuVVwq0nhsg+ovJQ6g69JcX1UC+jmZWuctdSYDiHdjiiT4RC5k1KrMWH?=
 =?us-ascii?Q?8ChWAFLv7RHZ3zW0m8lD27VgBKsu9+oi8uvnKShdE++j5Ccl7mfBIE6ZKkZ3?=
 =?us-ascii?Q?ZnaNHu2i6T8pCE8DeEu0eA0OHFob66fIXEOyJK/7ex0VK+bsaObEqYD1u3KH?=
 =?us-ascii?Q?ptqboDmaesm1K/mE4toesj6VF/ykIpyjZ0s8jHgjYquR+kLRtftAJSRNTLGK?=
 =?us-ascii?Q?SxGR+LNJdo+PV76Dn/ilDRQKSSlLMoPKWRG34pkhTuZKRXLVKuSEXAdrpu/V?=
 =?us-ascii?Q?3bLRxKzLnHD5hvCWtsph9eLpmzjiq0ULfGKyR5lh0wHSerGVmnvcZEimIcdf?=
 =?us-ascii?Q?J8ovb1NcY/xUFAPcZktPM7LpW+WI+rMfuBI2bfb4mckekmHKMrsa2+Q3zNKm?=
 =?us-ascii?Q?5eo4hDCjFf2uT6wHVNCzgOBL+I8yrfDwvtXYjlBVgie7pFl4enEL17xaUfdz?=
 =?us-ascii?Q?O5Z0EnWSLWgU+mkAZR59EXr7W2BtKtzjWjeOQyQSDv1ID6k7F6AcXW9llDzf?=
 =?us-ascii?Q?a5afXzmCPRpKHedXrA3abwkAJqFnGAZRCW2ug6Dbr/HFi87iE1sFB5kgAABA?=
 =?us-ascii?Q?FoE9vVaPRXe7Gi6YVbloIbPjFlPC6Z/LMAdZcTsmSjN1xpPY9u48O9PrxhJY?=
 =?us-ascii?Q?wUwaS5SytBc2DK7S2FkasycluuvsX2TBMsJNS0mXCsNW356gsR1C+tWh/ppi?=
 =?us-ascii?Q?jwFStOeZbCfwR3zeoN+V4wruLfTtJmuQuVev9G74WhlhC5CeCfErwBPm8RVV?=
 =?us-ascii?Q?7eJUfzV6mA3FhiUEiwlwTpthokPjiHckgzBVCSonce6/7KbTWSqO9dOMHqD7?=
 =?us-ascii?Q?jtRCGtdh4uhBvDgEI5R5zwALhX47rQJWiQDMNCz2775NQ0t+UgtLFHqsynA3?=
 =?us-ascii?Q?Z5aUuMMH43Hjm3V2ra/qH/cf0ccBcWmi7X9ENYKZ6GrZq500w7tsP6r3tV7V?=
 =?us-ascii?Q?LWBC8+m/DlvEHTRDiR0Q/u5xLQuQi0KaYBcmZBAo4ob4vcVaDdRsKQybqI/X?=
 =?us-ascii?Q?GnCbQo2JB+kvAPk1oL92McASX9oTO6Ne01VI80slpKlUwgAdAq3eSp9Dw0RR?=
 =?us-ascii?Q?OelKuFKd+xqDJh4+PNVv1l6O5k/Sapp047NtUR9Rks7fApM6wzPdGhixuGU7?=
 =?us-ascii?Q?zBRxg3uzEqhqoREw1Phdp+sGCcRvO6vskbuwx0pjo4OOiwljo73SO1jvKcWI?=
 =?us-ascii?Q?9m/TPeFicuuAYvVkZEJgUsrBEeammk5WGhpUlo/eDa5fjaJODacjodmlkJC8?=
 =?us-ascii?Q?W6qK3+IjM6bZfqLj9j3tHYhGH9DGTeA/ahBg4RHRoFr4s6kMEsiEyEkuRAiU?=
 =?us-ascii?Q?tmePo4kWn3Pwfy+FWHY83q++gPJw3xuwYGLaxaEPR3HSkg054eBCvOLexCp1?=
 =?us-ascii?Q?Qme/tlfvXjTDG9ljLOl/ubCZHT0ZultqCytLo344tIN/kTiEK6AhFSRJ1Aj5?=
 =?us-ascii?Q?tTvmbRKSKSWFxbjr1m0ofOsKgFx0abQA2j720ltwsgof?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d60e87d-e6dd-478a-9c90-08dac74b9fb7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:54:44.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTWG3EO1ABF0vU3HmlKhA/rwa0EROUsn1BJ0p82IM0PQwUyA/2nM7aCciLG2Os8t0WmZO4Um5cFXg5YrQc89ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5547
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 02:41:35PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 15, 2022 at 12:18:38PM -0800, Ira Weiny wrote:
> > On Tue, Nov 15, 2022 at 01:44:24PM -0600, Bjorn Helgaas wrote:
> > > and say something more specific than "fix struct"?
> > 
> > How about?
> > 
> > PCI/DOE: Fix initialization of work struct in pci_doe_task
> 
> The importance of this has to do with whether something is on the
> stack, so I think something about that would be useful.
> 
> I'm afraid this subject line bike-shedding has made you overlook my
> other questions below ...

Oh...  I see now.

> 
> > > On Mon, Nov 14, 2022 at 05:19:43PM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > The callers of pci_doe_submit_task() allocate the pci_doe_task on the
> > > > stack.  This causes the work structure to be allocated on the stack
> > > > without pci_doe_submit_task() knowing.  Work item initialization needs
> > > > to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
> > > > how the work item is allocated.
> > > > 
> > > > Jonathan suggested creating doe task allocation macros such as
> > > > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > > > function is not known to the callers and must be initialized correctly.
> > > > 
> > > > A follow up suggestion was to have an internal 'pci_doe_work' item
> > > > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > > > could restrict the context where tasks are used.
> > > > 
> > > > Compromise with an intermediate step to initialize the task struct with
> > > > a new call pci_doe_init_task() which must be called prior to submit
> > > > task.
> > > 
> > > I'm not really a fan of passing a parameter to say "this struct is on
> > > the stack" because that seems kind of error-prone and I don't know
> > > what the consequence of getting it wrong would be.  Sounds like it
> > > *could* be some memory corruption or reading garbage data that would
> > > be hard to debug.
> > > 
> > > Do we have cases today where pci_doe_submit_task() can't do the
> > > kzalloc() as in your patch at [3]?

No.

> > > If the current use cases allow a
> > > kzalloc(), why not do that now and defer this until it becomes an
> > > issue?

I do like pci_doe_submit_task() handling this as an internal detail.  I'm happy
with that if you are.

I was just concerned about the restriction of context.  Dan suggested this
instead of passing a gfp parameter.

If you are happy with my original patch I will submit it instead.  (With a
better one liner.)

Thanks again for the review,
Ira

> > > 
> > > Bjorn
> > > 
> > > > [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> > > > [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> > > 
> > > [3] https://lore.kernel.org/linux-cxl/Y2AnKB88ALYm9c5L@iweiny-desk3/
> > > 
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > > Reported-by: Gregory Price <gregory.price@memverge.com>
> > > > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > ---
> > > >  drivers/cxl/core/pci.c  |  2 ++
> > > >  drivers/pci/doe.c       | 14 ++++++++++++--
> > > >  include/linux/pci-doe.h |  8 +++++---
> > > >  3 files changed, 19 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > > index 9240df53ed87..a19c1fa0e2f4 100644
> > > > --- a/drivers/cxl/core/pci.c
> > > > +++ b/drivers/cxl/core/pci.c
> > > > @@ -525,6 +525,7 @@ static int cxl_cdat_get_length(struct device *dev,
> > > >  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> > > >  	int rc;
> > > >  
> > > > +	pci_doe_init_task(cdat_doe, &t.task, true);
> > > >  	rc = pci_doe_submit_task(cdat_doe, &t.task);
> > > >  	if (rc < 0) {
> > > >  		dev_err(dev, "DOE submit failed: %d", rc);
> > > > @@ -554,6 +555,7 @@ static int cxl_cdat_read_table(struct device *dev,
> > > >  		u32 *entry;
> > > >  		int rc;
> > > >  
> > > > +		pci_doe_init_task(cdat_doe, &t.task, true);
> > > >  		rc = pci_doe_submit_task(cdat_doe, &t.task);
> > > >  		if (rc < 0) {
> > > >  			dev_err(dev, "DOE submit failed: %d", rc);
> > > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > > index e402f05068a5..cabeae4ae955 100644
> > > > --- a/drivers/pci/doe.c
> > > > +++ b/drivers/pci/doe.c
> > > > @@ -319,6 +319,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > > >  	};
> > > >  	int rc;
> > > >  
> > > > +	pci_doe_init_task(doe_mb, &task, true);
> > > >  	rc = pci_doe_submit_task(doe_mb, &task);
> > > >  	if (rc < 0)
> > > >  		return rc;
> > > > @@ -495,6 +496,14 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> > > >  
> > > > +void pci_doe_init_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
> > > > +		       bool onstack)
> > > > +{
> > > > +	task->doe_mb = doe_mb;
> > > > +	__INIT_WORK(&task->work, doe_statemachine_work, onstack);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_doe_init_task);
> > > > +
> > > >  /**
> > > >   * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > > >   *
> > > > @@ -517,6 +526,9 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > > >  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> > > >  		return -EINVAL;
> > > >  
> > > > +	if (WARN_ON_ONCE(task->work.func != doe_statemachine_work))
> > > > +		return -EINVAL;
> > > > +
> > > >  	/*
> > > >  	 * DOE requests must be a whole number of DW and the response needs to
> > > >  	 * be big enough for at least 1 DW
> > > > @@ -528,8 +540,6 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > > >  	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > > >  		return -EIO;
> > > >  
> > > > -	task->doe_mb = doe_mb;
> > > > -	INIT_WORK(&task->work, doe_statemachine_work);
> > > >  	queue_work(doe_mb->work_queue, &task->work);
> > > >  	return 0;
> > > >  }
> > > > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > > > index ed9b4df792b8..457fc0e53d64 100644
> > > > --- a/include/linux/pci-doe.h
> > > > +++ b/include/linux/pci-doe.h
> > > > @@ -31,8 +31,8 @@ struct pci_doe_mb;
> > > >   * @rv: Return value.  Length of received response or error (bytes)
> > > >   * @complete: Called when task is complete
> > > >   * @private: Private data for the consumer
> > > > - * @work: Used internally by the mailbox
> > > > - * @doe_mb: Used internally by the mailbox
> > > > + * @work: Used internally by the mailbox [see pci_doe_init_task()]
> > > > + * @doe_mb: Used internally by the mailbox [see pci_doe_init_task()]
> > > >   *
> > > >   * The payload sizes and rv are specified in bytes with the following
> > > >   * restrictions concerning the protocol.
> > > > @@ -53,7 +53,7 @@ struct pci_doe_task {
> > > >  	void (*complete)(struct pci_doe_task *task);
> > > >  	void *private;
> > > >  
> > > > -	/* No need for the user to initialize these fields */
> > > > +	/* Call pci_doe_init_task() for these */
> > > >  	struct work_struct work;
> > > >  	struct pci_doe_mb *doe_mb;
> > > >  };
> > > > @@ -72,6 +72,8 @@ struct pci_doe_task {
> > > >  
> > > >  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> > > >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > > > +void pci_doe_init_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
> > > > +		       bool onstack);
> > > >  int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > > >  
> > > >  #endif
> > > > 
> > > > base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
> > > > -- 
> > > > 2.37.2
> > > > 
