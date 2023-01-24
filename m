Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2A678CE7
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 01:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjAXAds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 19:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAXAdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 19:33:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE56E3A1;
        Mon, 23 Jan 2023 16:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674520426; x=1706056426;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iDw2XrZNhpiRMu3U2eiaihFCZ4cL1WRDtE28mkC0hKE=;
  b=GoTwIOzAgFQOL3qw4zD2VI8jhpb0CxQ/JQu8YqxsGBBfibCWiBNPKS2W
   qcfoXQwF1Z9UjTwZQ/GujtRzrdRpyHTS37gm8s6kmmvS2etgVTMUuu+jZ
   FfGSyDP5N1HzgWj0ZBdkjtyS8B7Tlg67A/G1oPAgG3ox56su6srCPSA1I
   u6iBWlZouEiEs0DTiYQSSXaqXGT9DhaFjKhLRCFNhtdfEHVuzZVOviix4
   sAuIPy3hv3viEOYT8FTVsyDb2AK3Y9tv7bojkSoZ3wZuqHD9sLf8lZzCI
   WrP7O7KYQGSwS/RYBKNHQkVw3WOZ/+vpetJH01rbqw3z8L9vn0a5lr7oW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="305862031"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="305862031"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:33:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="785880385"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="785880385"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2023 16:33:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:33:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 16:33:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 16:33:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRkwxFM3x4WR/oNGvH+kvGeq++iXwkn8UFxzLY1FkwbRHpZEcDQa+l06cvptFYOJsvtSxh4l8mEYO/p5EjKa6XQSDqHJjP0mqF4VZTrJ304Uic9R+mAL1EhoufuNwo77JCsd65T6Xg1aFS+i24Q0lGkCTu8hC3Q8xw3e3A3B1e3FjS7wjjVQm4G+zdF8ckyotY7iToHrGFsztU0OUjVt4/x0WPOgSGmSthMR1qAGjPc6RvtHE1DJ+SYQ8ondVBWR6vpZvbXmXONKNdufKVJLlo2731TSEi3ZrR1Rr0VWe7EbPeJ6GQIyHlmZXmb0kzIOcE+6HDgJqXwPgl+bpLIdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bikTyV9XwvX/ETZ9FzCPEvucesdk5yFPtuvo7A0tWs=;
 b=oMDPbrsLI8K3+/955+nmW+aqfZEIGYMtblk5nPIvO4bDFFb1jzvwEH5ch0wbXaUeWS3GCBxJQEc3pivrfu2g9uSzmZgEHQFFxUvmPCmwlTG8J1tRp4BpdZyOzhOxwNmnk+ZfHEO4rigiDlczrJzRQdNs7o6wRW8OCRg/TSEU+ZXrogZtP35/jFcDhvBh0DXXAHNZsOfSyFB3Suj9fixc9+gTQAlLkj9iDNp7nlzG1taOBzKC67Pr+worrxWwvGp6gJDG5Bl/IhXBViprgnh5xELxLr9pQB+nG7E3vAsulD6PpZWnCNjIpmXvXFH24AdjN8LeyxvWIegGqQmZeMFLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4977.namprd11.prod.outlook.com (2603:10b6:303:6d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 00:33:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 00:33:40 +0000
Date:   Mon, 23 Jan 2023 16:33:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] PCI/DOE: Silence WARN splat with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <63cf276083fe1_4a9a29468@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <cc4b61809e2520d835cf3d4f62e7d5ed00a9d031.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc4b61809e2520d835cf3d4f62e7d5ed00a9d031.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4977:EE_
X-MS-Office365-Filtering-Correlation-Id: 9881b917-5317-4533-4c2b-08dafda2a3b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6z62QJYNIexhCkyxoOEnk3epXIxSGSaPu14rzQfPGzAVSPMlw/oZ0qnNzemORisx9p7e0oLE/z2U8FJAts9QZEgQLVrNZBGmkrNeXjDg5Anzx0bujX2Eit7hxRx00MgAgG45WcX9Ev338xLl3gm2i+zeqQXRUsTqfFQ3isvO6e5Qo6ofGiRDGJCg1EYp0S+6WqgLlvKRrxb7sgelySVLUKLLz2nw5cuS9YrBX8vZFf5ZA2fPohJKNanOxAyGN8mIM8FzR5eibCe0yr9e91SBtytPf80DfoQFCQjHe9Z+u+zbWCJ7scQOrcZFVkP2W/86ISCsbNsbCmZlmflMYA+oSqkWVizmLt0/DGURNuYLBEl+YjXZJ+s+meZvo/+49cPTWGjbpEAi8aYa11wGUT85YHdknETfuC5pISuhoePqd19N4LTkGcho0e9CkUsl39XUpUN28tvviZfYnWIpDRwMoNgB0F/MW6doZA9HcwgvhzBxTLIKRh6itP6w6y6NUFnA5QxePhm2MUjBQV5ejs2/ac/WJRT6knLhky8W7TkS3THmRPMeW4mXIIAbtGVxQH5eQGzzmamN/n6L6jXJ68kufWCJWJQMHPzXouvKsDkRIsyLivB3UhIswZqtr+fjswt2SXqITPPCBTObcNUyGqtnoe7QSKhbv5ERHkLqt0g9z18=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(83380400001)(38100700002)(82960400001)(86362001)(2906002)(44832011)(5660300002)(41300700001)(8936002)(4326008)(186003)(8676002)(9686003)(6512007)(26005)(6506007)(316002)(6666004)(66946007)(66556008)(54906003)(66476007)(110136005)(478600001)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzT6+2jwdwSEG9R+zvSlMcidwX2wH7W4Z+kyvMzAE+5R88ffOvjSk34hQVvt?=
 =?us-ascii?Q?5kpEoqBgaWNjw3ZwzvjoSDZqncaRJDYooqRUbxpTdaZuk/NggZR5KJvPgnnW?=
 =?us-ascii?Q?FCtIfSEkq1+R7bdd1rCCYkpbjMn+N8oPiQ2+7s/d3RsPkkvJnBAWZPGy4igh?=
 =?us-ascii?Q?rmU1pcsOjQHFhzG4G5v3r9bfXNFeuuMpd6WCdrkfLZb/3hpTBPezPQFwM8IK?=
 =?us-ascii?Q?z8qq3mGazezEjOM/LDSIDbD0wQ9Wo5IEGebrc22i8PPjM4ynsLl+UypAmLyw?=
 =?us-ascii?Q?tJsDAXnVKhkrB5DWcujuK7BVii/34TFwaxh+/e1ONT8Qj0oiTGb412NSO3E/?=
 =?us-ascii?Q?0ASg17u7O+HHYQa7YHVHxynknW4Z5qSZTQsU0Cqsi/SlWpYKZcV/N7/DFKtD?=
 =?us-ascii?Q?7G/ypndP++eVaL2L8uR1eEpCURu3LWydEyBiofsjbRFcZcUGroc3tVAIfA5a?=
 =?us-ascii?Q?ZLVEKDJnepiZDN9q8z8bxQUm2WG2F3AK1T9k70xzBoM1Bilgv/8mjkd+ufAu?=
 =?us-ascii?Q?VtQolJqat0a5EPpBr8HXarvi6y5SLOnRk+ABzOcalmiIKtcYtMwPfKVjirWV?=
 =?us-ascii?Q?kHexZ6JJw1/vvVAv2qsJD9swNXLcBY7mjjuWhDvwdtlKPmK1K6HA2IdJx/Ou?=
 =?us-ascii?Q?8zCVlRaRmHu7U4wDTOUiIBOHeLHalXemYg+oHzey3bFYfUd6u/LJU+QNdIP4?=
 =?us-ascii?Q?ngzUU44EasC/oF/1VCicvqcCvXBVr5VlcXKn7FLnGINxl+UDmKOGr9ZXu+Hx?=
 =?us-ascii?Q?L/xnJnIJ674oSFxMkO2kv5LcWgSwTwtFLg7O0h/x/o/MsEteLlADeWP0ig2M?=
 =?us-ascii?Q?LrpFbXkUQ2fInYLI5C1ZRRDbb5LhLaq9Mb0KTtbb3uGFjbzHzl5B514DQIIB?=
 =?us-ascii?Q?rPOWPKYDQ039rOUHCex0YQK2hvJ9PojT1z9ZmxWFFhVxi5HkVI6vKMBhJjBz?=
 =?us-ascii?Q?4MQxbH0nRZiUYS22UDGwT4If49RotPUyx5PqQoe/iEbgSngClsAc1xR6j448?=
 =?us-ascii?Q?RxUx43+zUExkrmEP1NYRVKjI2cTyvErswOsDWl49aoatOhn/uiL6UGGitfE2?=
 =?us-ascii?Q?bPrIBuIpQQi5NviyNns6fYxAnGKL/pt9uTMQEKpyjMym+sxve3coudu04Ypj?=
 =?us-ascii?Q?Te9/OIEMyOPnYcoKG6FXNoywaGN1D1nN/ox94IylPF7HDginoEPIBZqvwbD+?=
 =?us-ascii?Q?ba8niwR+WyZpg1shiSl6GKMRBC9pTiLVyWwusg4jYHBkf1EZJqSGmUhK+wde?=
 =?us-ascii?Q?ymJqPUB51QlUtHCLuLf2rropkzHFr+JgvNRSCaNJEPIblJhAEpsNoxy2HiB4?=
 =?us-ascii?Q?MQ/DdyEfyIhZJ8L0/1jV5vfE3i7IAvxuB3kZMb9oS0OmtWhujFe4f8Ryl43R?=
 =?us-ascii?Q?yPfmSk9B/9L2IETRJmsZMjPH//zopfD98vWUjLzG6DN91ds3RcSKfJ9Xk0Cu?=
 =?us-ascii?Q?XBNin6beBgY3FR+0W2LUss+QMDJcIJSvw4RpxhYnG1NfX4wXqECkRErkZoIV?=
 =?us-ascii?Q?gsL7dyub9kE3EK/4pD6zsZege3KsT9UgJqRbRZTj+vPwdDK+v2hcl6II/nNK?=
 =?us-ascii?Q?F0Vfdjf3dJJ4fqAinyATl7mJWu47BZMTr3yNyWJD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9881b917-5317-4533-4c2b-08dafda2a3b2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:33:40.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9WjhDGW9XpiNLLTRr21CIvIuxeLVGVyM7390vCfyQU2r84zixnOx9SH0A6CsOWAdWIrIUcyFUXIPYV3nCzcyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4977
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
> probing because pci_doe_submit_task() invokes INIT_WORK() instead of
> INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.
> 
> All callers of pci_doe_submit_task() allocate the work_struct on the
> stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
> short-term fix.
> 
> Stacktrace for posterity:
> 
> WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  pci_doe_submit_task+0x5d/0xd0
>  pci_doe_discovery+0xb4/0x100
>  pcim_doe_create_mb+0x219/0x290
>  cxl_pci_probe+0x192/0x430
>  local_pci_probe+0x41/0x80
>  pci_device_probe+0xb3/0x220
>  really_probe+0xde/0x380
>  __driver_probe_device+0x78/0x170
>  driver_probe_device+0x1f/0x90
>  __driver_attach_async_helper+0x5c/0xe0
>  async_run_entry_fn+0x30/0x130
>  process_one_work+0x294/0x5b0
> 
> Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> Link: https://lore.kernel.org/linux-cxl/Y1bOniJliOFszvIK@memverge.com/
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Changes v1 -> v2:
>   * Add note in kernel-doc of pci_doe_submit_task() that pci_doe_task must
>     be allocated on the stack (Jonathan)
> 
>  drivers/pci/doe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 66d9ab288646..12a6752351bf 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -520,6 +520,8 @@ EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
>   * task->complete will be called when the state machine is done processing this
>   * task.
>   *
> + * @task must be allocated on the stack.
> + *
>   * Excess data will be discarded.
>   *
>   * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> @@ -541,7 +543,7 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  		return -EIO;
>  
>  	task->doe_mb = doe_mb;
> -	INIT_WORK(&task->work, doe_statemachine_work);
> +	INIT_WORK_ONSTACK(&task->work, doe_statemachine_work);
>  	queue_work(doe_mb->work_queue, &task->work);
>  	return 0;
>  }
> -- 
> 2.39.1
> 


