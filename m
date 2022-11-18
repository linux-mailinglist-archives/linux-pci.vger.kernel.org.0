Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F862EA12
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 01:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiKRAIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 19:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRAI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 19:08:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186CC62;
        Thu, 17 Nov 2022 16:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668730105; x=1700266105;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hzA4bDBtTrYA8NOBoqCfnyRdbaNYPd68tCavkcBHOQM=;
  b=QdeG1nw+qP69wSJgiWBNiFUr08uSYxgXrcGE3qNSNZA0gzO3mIyIhTEK
   kTfSdIgIXzbxGjx71rNTRXWgwTbpjceFyxNLeJOvnF/9XB7TsaWgUQt4b
   tVW2GVNUAr5qeO4wZyVHk9V1fHujXRUblLOGnVKr8jBJu3lEaZUqvGzGS
   fiT1DhKzeUvt1b9/Sg4qtSc21u4/CNkiVsQYxgBpGcMxtFG6LWRbl2OAc
   Qec4PEYyE/Xa+DpPl5LTpHztoEbseNPk6GF0RRdOkaj9hQ+O+dKqDt/Y0
   e20rGOH76jpi/tyLpYLO5L7MZh/Bauq/dfw/Sz3dR1yk9ZYBo21TDI84w
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313022321"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="313022321"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:08:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="764962527"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="764962527"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2022 16:08:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:08:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:08:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 16:08:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 16:08:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIoGoaNdeQ8pV24PJxcNXoDMNVYhj+LnETLj9kUxZ6gg8fYILQE7TzX6VHkA2Kh70SsBXvyNp5pIDGAWvhJPmT5jieh7qfH4z+0Jep/L37VxIueKeZvj7tcNDjnsj20QJI4Pwk4cAeNG44svaG1OyaZ7YvNqkpaS2llbNXisCEg/oGKMfH0H5xSaqVyjnFa5YZ8sYCMrYnXw4PATFVAA7u7ryiuSJtHWktFdyxOyILBglXKrRfgkV0SA+uBQKWcH2naz8dDyjN4v0Wew36XcZ1ycZSrzNVWpmYb0ZuoyUnjW3eZ9qzpsRXc8qYicyT+f6tECtKb8sLpEtI9GAR6HVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwkZum5NvWs6af4B6i6mYsdhAAeGYkTs2J2BIAThoI0=;
 b=JtwidOCoaMLaUr0U5H79KmzBum79JABzffU3PdPBeshIXgAcM4q2b/8G7LK26t/mCNbg8EF0VDxe0geNTPqUdoFyOTaWAb96gcJ+EXYbjRqDjlo9KEKM+qEl9whMzgwOAYAzDJ6KeKUgSvruWuT6R5st75HFji57TN3mIfv5P/QsKwZDWUd4irC9KHrmVS3pzLwjVOqFFJMr7G4qXLLyaz+8jCOVpjz76DZcyh2Ol5aFMrpSCfqFYYEIV0R5BAEkf9RybHGa9bgF2yrD7jZVAuTmTNE0PtFv4G+bdz1HWmBdVs54b3YnlcihALi/8pb/WcFygVLGuyzQfYfGbKjFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 00:08:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 00:08:22 +0000
Date:   Thu, 17 Nov 2022 16:07:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Message-ID: <Y3bM1NkVUhCe6/Vo@iweiny-mobl>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221118000524.1477383-1-ira.weiny@intel.com>
X-ClientProxiedBy: MW4PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:303:b9::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: ea91f8d9-df3e-4605-40a4-08dac8f900b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEsVEOrBZx1+C8UFEtKP41Lxi723Ayhgvcc3+Kag3qI40UoWsyXq+zN+p7MB8R14qUKqd6rcl13lxiCfUUIHl5/hP0ZyJyeyhc5RGRKxDsYuWg9pCBQXj8YbjnsCeB5w6E3TqxdIlMyL+djnmPcl7pdyKc4A3b97NzTaLZWQF/U5yLaI3PZtqrBJW/yEAXKGOeQE+ZIUlACz9NP+OHx/M+YtbbduC/M+MFAe2bOxfy3XVzu78jgn7NRbCNZZvlzcN6meg0bWu1XsmOwwnYKD7+l2eAweqagyxEtvsMylWNrTdrglRm8r7dAlcgChuxHN2BwxJFH037uaZexy+tFd3G1QzBze00VRODLGE876TSzR1Q7tEJtWTE8mzx35PKpymkZf4c02fjg6FnRMHeaSPiXTa1WvAuQDIz5cY1LfvPtIQEzouedhFhOQtYXG62VV5STz3N2KggkOiYsj6hQxGHE0XZcrqB418G8VE53F29cvdHTbilzHs8si+H757B/FuUT1nRaI3hUYubbVC4sIsh/hDfyeYjduNqBtY6UQ6nxFEMJPxoS0Fdvu/qkxQ5brs5wJyFNPs2y9Tc0kY4uedM5HO7ShyXNKgM7X5YALR3wZILhGJlwPjQJdCR0X+Kcq+QKll5faPm65JttqAz3sjmtEncoqhvsS/6Trl/Jp6635Qbb06V47vY8/n/jKBO22PmQb9ENKTJSmvAvSO+9SqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(44832011)(2906002)(66476007)(66946007)(5660300002)(66556008)(8936002)(4326008)(8676002)(41300700001)(6486002)(83380400001)(33716001)(82960400001)(110136005)(186003)(6512007)(9686003)(6666004)(966005)(6636002)(54906003)(316002)(478600001)(86362001)(6506007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?heCuvfqxFYklpcfWFbIDLzNQsl1SjJBPCYg+YvD1SsESGd1LodWqtPzkTNKn?=
 =?us-ascii?Q?E3bnBNf9+2zRtFDc+sJ/+yACmx5U/a6WWFq5d/32RlPu9AjibhU37+2PJXor?=
 =?us-ascii?Q?PzQFwFTi+hHWHqy8p1i1m6UiSphtd2FDUXzyxT+UUqk4Q0u+dwW29RgHiVrL?=
 =?us-ascii?Q?QoewNXxZBSqlvUez4KvTjAnfogpw8OjVgcu1lcR0BCuQ4KnQFKrxYy/NGul7?=
 =?us-ascii?Q?1YJzpXStJf80yi7yW60l3mxMVUOZKBaKq8Y5DbLK/U3DdX4/ORAA3Pllfs9d?=
 =?us-ascii?Q?A1S8BWvzd3dQvXkVMISP0Ee298r3eQ+ixCTQQ1J4vvNwB9ZZDeL9p72hXj1Z?=
 =?us-ascii?Q?pmaGXodZjI2vIhwfz0cLnENuyjtlJsvzz2oH0setYleg4MNdT3tkfaCsrXV8?=
 =?us-ascii?Q?ouLNeilyWL6EUXzoD5QvTXQUAZ0ZZF6pdWrTRKAbTASf0XjAGQ3F0jhNmhZp?=
 =?us-ascii?Q?Q+t3D2sKsUcRHmJoiy3MGjrepYk44tKrYqeHlOKRzhSVizJA+wQUPt/ohyV6?=
 =?us-ascii?Q?jlz6d9/Z+htZHGYjHgXvWgEHKF3D7wLAeoyLJ61KZZFZHER4BNIOhuzZoRds?=
 =?us-ascii?Q?Id7UhYXsBi9HxYmn1dbrVLDDMxFY8vVP4IIwW2iIwszwl+U0rZlYMs7VkmvY?=
 =?us-ascii?Q?bd4gjtBd7435IdIkxhvwEvSfkL3+UdeutFfdwaiaMtpWMCKvHS4GaFbWf/Dt?=
 =?us-ascii?Q?a0YhoauEGaFtwgqs8cSmfcmyWtJMvYtwlo7nW8Wd+rr87u/F9AtpcyMv1jw7?=
 =?us-ascii?Q?YRv+6RKC0nAlzFmjOQl2UJn1B3jh2re7mvcPuosGmqM0anCr7DWtc5gH1aKq?=
 =?us-ascii?Q?s71ktsqwx74gWchKCCV2EvyiS8ZFljxAfFu9hACeHszI/jiV/koEOxH0TAIu?=
 =?us-ascii?Q?68zlIJ0FBLgllRP3ReyjReSmxmtX+gn7c10EsWrXNk6caf4frbFv83HITett?=
 =?us-ascii?Q?05sdAuuMuG6loWsmI4lN8jaCOuCQFAkacjFaO/D7IUgr2tDV/FYgE+LH/Ygy?=
 =?us-ascii?Q?tUUWzgD9RolIvJL609zbRBmhHiGyCqh2Z9GvyZEcuR3AuAFl5vbuv5b8h64L?=
 =?us-ascii?Q?HJZY08vzG28Tpqv/hM5Nl+qGZBzIF/urnu7oomJLMVxTKE/fD9AelJwj/7u1?=
 =?us-ascii?Q?dy+tKqI2CIP865ff73y54vTD4FLuQpXhpUWIsQKlL7pfWANCDoY81FZ9zoBo?=
 =?us-ascii?Q?auyoTF0Tl5JMGWIR1DJDovyk1KyBfqH4XZUm+P1g9C0LRRQ1mVYJ+hPVoNux?=
 =?us-ascii?Q?FGvdqjuGYpYrDte+w2eqZE+DCgC1G+m0de7t8WMCI0zDVxco4YOOjG6evE7D?=
 =?us-ascii?Q?g0opUspwSb5XYpuk0iFJrHnnJFQZku+XM163x7eNylamuDpfwsYk1Xvw1PWr?=
 =?us-ascii?Q?1yEbpmtZfQOmUXSGFeTy5udWytre4bbMET5VZaXWIpLaI5p077Bt/KeDuVC2?=
 =?us-ascii?Q?0DHydd+04TS+bvwtlj9g5uBXOyqNnv8EE38sYfaiGC7yedv6l5RLO/Ea3+OT?=
 =?us-ascii?Q?I7CcyiaOc+xPa8vRRoeTwW+bvQawHB1Wz8nHjBZKKKRB6aABP+rhC5PHp3mL?=
 =?us-ascii?Q?4AWSP5NHRgc/V+/5hY8I6IWSCjMyHS8Zc7mEXRvwmpoEZAZ3uJWsBbhisShp?=
 =?us-ascii?Q?Rnt5o++c1g/Lbmh8KblIFodZxjbYMeg5E1xOD2ya9xUh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea91f8d9-df3e-4605-40a4-08dac8f900b9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 00:08:22.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZr+/WC+0VSCsixEDJG7VrwB+YvxwVCGNuC1Qbu6I1q0aXVN5h6eu+5R0pTzhsFH9GE/6JkqGn3NmCKW246IsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 04:05:24PM -0800, Ira wrote:
> From: Ira Weiny <ira.weiny@intel.com>

Sorry about the extra pre-patches listed below.  They are not needed.

> 
> Work item initialization needs to be done with either
> INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> allocated.
> 
> The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> 
> Jonathan suggested creating doe task allocation macros such as
> DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> function is not known to the callers and must be initialized correctly.
> 
> A follow up suggestion was to have an internal 'pci_doe_work' item
> allocated by pci_doe_submit_task().[2]  This requires an allocation which
> could restrict the context where tasks are used.
> 
> Another idea was to have an intermediate step to initialize the task
> struct with a new call.[3]  This added a lot of complexity.
> 
> Lukas pointed out that object_is_on_stack() is available to detect this
> automatically.
> 
> Use object_is_on_stack() to determine the correct init work function to
> call.
> 
> [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> [3] https://lore.kernel.org/all/20221115011943.1051039-1-ira.weiny@intel.com/
> 
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V1
> 	Update oneliner
> 	Use object_is_on_stack() to make this a simple fix
> ---
>  drivers/pci/doe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index e402f05068a5..42de517022d9 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -19,6 +19,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/workqueue.h>
> +#include <linux/sched/task_stack.h>
>  
>  #define PCI_DOE_PROTOCOL_DISCOVERY 0
>  
> @@ -529,7 +530,10 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  		return -EIO;
>  
>  	task->doe_mb = doe_mb;
> -	INIT_WORK(&task->work, doe_statemachine_work);
> +	if (object_is_on_stack(&task->work))
> +		INIT_WORK_ONSTACK(&task->work, doe_statemachine_work);
> +	else
> +		INIT_WORK(&task->work, doe_statemachine_work);
>  	queue_work(doe_mb->work_queue, &task->work);
>  	return 0;
>  }
> 
> base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763

This is correct.

> prerequisite-patch-id: dfea657e07f37aa9d7c3d477d68b07f64fe78721
> prerequisite-patch-id: e27264e76e637214ee50cdab0e5854b223d44b4e

These are not needed...

Sorry, should I resend?

Ira

> -- 
> 2.37.2
> 
