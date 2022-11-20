Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA063148C
	for <lists+linux-pci@lfdr.de>; Sun, 20 Nov 2022 14:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKTN5g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 08:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKTN5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 08:57:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D304C178B4;
        Sun, 20 Nov 2022 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668952652; x=1700488652;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rG8L3Gy6dlYde6aZ1smksl/c8YsjZ659wo8xMGHrrH8=;
  b=dVv7X3fw2Qe/WN92ZIivVvKIp/kGklhp8qApTPIwnilifcJNnFh8cGKn
   aTIOmL78nSGapFS7w3s8/g6YsUGOZMqlT75ECbyERMQ6Q1z3Nfos2Bjk7
   8lRaLodbWE5r0s7sNGnxClscSYju89U1dJTo3lF9SBLJ9FeTeEAcvJqxp
   r4AnIu+/mBaGiXFsVJ6Rfb32Zli8YEZmd4BNwWen3Vt+jNdp5KU0Dp9OS
   6vEwdO4WRmjdL1EzdG1xXMwSyZkItd93SB4o3AtOfXXTdeq+GMn0XYUpz
   4szKGq+ng5OpRq70jrc9qO7ggpSxJNsApfpx7f6iwmYqVFmCr2XEN8CZx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10536"; a="293110555"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="293110555"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 05:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10536"; a="783166303"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="783166303"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 20 Nov 2022 05:57:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 05:57:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 05:57:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 05:57:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 05:57:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5aKRmsltQKKWY71WfDqQI4r3VPD0sLPiiGxUHpYezZO5xsOeVcbapphuSNHSSiTUTmjryrcVfmpC31kQYFLfy7IVsv+PA9uGy4xESHNekFmTOxQ2SaDcDeTZ8+p2QJwzMAdODm0zvY3JP1ZKUIvrvSSZKsoVSK/eSFQsO+dUI7KFnB720yjLwIGhM0X/uHKLoXPV6yHaBigtCeoECVnjSxsxjLZmiFhG3bnZiJTLQb3rF241LR059DbB8SWGaDWUxL+YNWoT+MqheMCTqkvJyMPu5WJ2+6I52A+G+pH/TQrmfX2tqzbdrrg3SjWnavdp32wW0qKTgHqZKLYcOQbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUA6+AYp6/5BVmguxkG7/DxVMyAxJAgdnYCApXuzAVk=;
 b=c3n0MUIb2KMAucK4o42OFiHtorbUWL7XfGV6/q0eevoVRGabgAiH1s1fzA91Y1PQLu46FzWWLB/W6yIMR1QPuT/VDn2iT9dDjf5PCIneEbGalikbcNCsFnQe9nISpGth8YIMLiWLvGWXD1KEDa7Fe20Qij9N0VQjDBJpCFKOqO1gQvzf/rjdO06y68aGprMyMrUd5ILJX5thIyS5N17MqdgcyBr+PlB8HEipgDg8WIaGJ3w0PF2F0HoKkFrpArlaKu+eQe9Nnx6i9bqMtF3eNZcot1ZWtGUTpg4cpt6wzPWpYVn7rkCL1dagwbaQrmm8+wtvS7Q+MpQ3ie5w8m3Sdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Sun, 20 Nov 2022 13:57:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5834.009; Sun, 20 Nov 2022
 13:57:28 +0000
Date:   Sun, 20 Nov 2022 05:57:22 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Li Ming <ming4.li@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <Y3oyQhHUbYZGA80M@iweiny-mobl>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
 <20221120022735.4671-1-hdanton@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221120022735.4671-1-hdanton@sina.com>
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: bb235bc5-a964-4246-bda5-08dacaff2852
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNtCvgD6Sep0Z5AsEbn8jtsqX6quKujSVRLWJEPLJiiS7xYM9uYkdmWX2woRnUmIfUTTvYQ2ZZCTuVAhQkdB8op4HEJdlgDYwrfA+SFriFhuUIy/IYkHyUu2jzycUlSNxT8t7rKZoJNfGYezHQ/uXceGSZ61Fh+fyn//EqBRnZXPtgfBSrGK8gbxw+KfSxNRPl4b4VqnxDDgCzMYWDCMw3RqCSEDSo1fu3Ew2isklDBycM6aDhYVGDZsdinVySS6WDaIUnBjCW4k8Rb9+FacV2JUlpkiEqPpi0CqoKl9r6DNmmrjIS+TPP0em6P80L3cD1+jIVmGdqxxtJ0QcqgjB4Pv6IATQX0tI+dfZR0QYfNz09zFGnu6ajh6EugJCC5krlPDyW7BM9v8Ss6F+6phXKXqjCKl5Oj3rIga2SW27mPqP9AtUooUvddBjBMqXpU3Z1jpUciEQDGFJ374LnOe3MZKSeWS3MBzJi4tFREY8lwSdaXnD2Yd+d878XQ2dEI9L5X2Xlw6oXL6mrzk+keH7pvj+uwcrif9gnb1LyCdjg/nmyWbp1fhJUiqJCjXqHsxk+Dm+5Ftp2DDDR6MRuU3c0uhXCbWjtgKRPoLZbbt91fojqj8RBp8NZRHsz18Ogj1jPzD559YWWX7SbvuNSgo9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(38100700002)(83380400001)(33716001)(478600001)(6486002)(82960400001)(54906003)(6916009)(316002)(9686003)(6512007)(6666004)(4326008)(66946007)(8676002)(66476007)(186003)(66556008)(6506007)(86362001)(41300700001)(26005)(8936002)(5660300002)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y0z90xXHq8iOLu9C2FRhJtIbDD3bnklOMdqEOVgZIngocx7B666m+OXbMD3N?=
 =?us-ascii?Q?TDth6RogWTiPr5xtOc2ePFyGUcT1LcUJbcJEeMgE6EulA4r4++K+XDsDKj4S?=
 =?us-ascii?Q?UMuYVWpmugwL3huOOFh8/2ci+sZeb5xsWDNZDi7Pci41uW3rFxLwIfya6DkN?=
 =?us-ascii?Q?Melx/JSDjXoTFqYj4nko7SLvoJ7BykOgOod+n1rw8n4fk/Jkw0XXUs02UdNh?=
 =?us-ascii?Q?QKe2goxGRi4tHXQRRg3PGjV63peBSMsltYvOy3Pk3ImGWUrl5MOfWeV2RejD?=
 =?us-ascii?Q?T5yGVLGIK6vLmQbOqIhcKqEGqM0Co1faXS6rquHTDl8YbSmse4LPb51AdMDP?=
 =?us-ascii?Q?m8YvPhVMI8MErxSoRGchFY7WdtqmHDOInQDvrSFo2nOGyubRNPZaRw0MDlBl?=
 =?us-ascii?Q?aG1ob6V1/+EAKzQshfqCMxoKuvIfkhS5vmu05puzGQRwk4b9lmWAWq97qBwa?=
 =?us-ascii?Q?ciUIWqqLIJhAOKzgQNjomc6NH3vBozvRmcZOqK2Gsa86CAxIUoAR/LnIo3EL?=
 =?us-ascii?Q?YTNwiGojFx6O61ySYAYe63eqaTRotJrTQhdlmSdC6/Qp6cvmcSHpXrwdfX7j?=
 =?us-ascii?Q?JTroAA+G6ea4txVyiKcnUBVBzOPyBxRTYvBcFBP9akj5rJe+oiB8SNZVxDrv?=
 =?us-ascii?Q?4CaWc6gGVF4qli4O9bMtkn+Xv5Hwogd0ty6yqEMKwat4fhuYNZx8KBOK1Y1F?=
 =?us-ascii?Q?cJaxMcwDH7fohT3gkTl6uxTtg6gi5b8L0Z65UO4bwWLMYbWh0FyDLtaqL0GV?=
 =?us-ascii?Q?jiE7c39TTbdKIZshgAUMZ7z3kqqYfXt4bP/3WvQM+qJnxt9rwNwgbOAvgVXe?=
 =?us-ascii?Q?VxYwJwIpoZGqoev6QwniYSUAhfyaoF8aeyksZEMuMo6WERmOibE5y9WDRx2z?=
 =?us-ascii?Q?4va7G5n15CikQCYUi8s9dXqJJWFjHV5cXnQrUMQe/w57F3NdaB7RdwnRlOWv?=
 =?us-ascii?Q?bdzCepdJ7h0PpEAl+MINXaBbJCPf+m+jTEbt1/Q1PJOpoMV7Nh/j+yvXgAMx?=
 =?us-ascii?Q?hixsKNiS0/HsOyyvkWSYygNP5CPubZbxbKNf7i5V8kfbgwiFwRmfJqCSnor0?=
 =?us-ascii?Q?Lp1wurd5RAeSvuGR9avvG9ZsSKwSUYKr6Ty+rg/pBND6cZ8j8fzeZ/pUD37d?=
 =?us-ascii?Q?dptHX9ZVdrucW+gqdgJ/h3YB6fgmUK/RGt6DxWLCUAa9Jv4ut/hTBxOdTFAS?=
 =?us-ascii?Q?9SYspbq+P/rfKcpFpGHjT6/UCPaIFqRYTGTJqcRgH45dUgj32sjEgwyjpEpD?=
 =?us-ascii?Q?cuO3zXz1p+Ksda7zRIoAZCTOV8j8L81jP9vXx9FjL4bFONjaeF/OQebaeKlz?=
 =?us-ascii?Q?S259+aBFYKxXcX7e/aA6JUqeDlVa8kKefdbESfab1XvidjbjBMXec9L3gvbL?=
 =?us-ascii?Q?k7gzEPM8a2gx9Zcp/aZDIClzOpTU7vfe3Y5bDg5wnOXY6dcVLqDgva0AJG92?=
 =?us-ascii?Q?rvtC2QFbbqogjhwSbh9qJaP70Sbt7EpHBBksNq+6jzxXHUuwNAU50OYeKW5T?=
 =?us-ascii?Q?/9mIGbcllOI1y0rN6FCK09pJWyYADO22OC0ORvIVu+kj55D8O4l4Ms4wNEC/?=
 =?us-ascii?Q?UN5GSKWMQX8CccE3glTLd84MRgmv96Wp/GN1V68p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb235bc5-a964-4246-bda5-08dacaff2852
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 13:57:28.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd05PrsYHhOczadlPoTgZVRDHnUw/gsXGYkQ3nmrK9HKzpXrsxUFO/sMDl7SZ9ALXrrF/LpCn0/2HSC9z1Q5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 20, 2022 at 10:27:35AM +0800, Hillf Danton wrote:
> On Sat, 19 Nov 2022 14:25:27 -0800 Ira Weiny <ira.weiny@intel.com>
> > @@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  		return -EIO;
> >  
> >  	task->doe_mb = doe_mb;
> > -	INIT_WORK(&task->work, doe_statemachine_work);
> > -	queue_work(doe_mb->work_queue, &task->work);
> > +
> > +again:
> > +	if (!mutex_trylock(&doe_mb->exec_lock)) {
> > +		if (wait_event_timeout(task->doe_mb->wq,
> > +				test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> > +				PCI_DOE_POLL_INTERVAL))
> > +			return -EIO;
> 
> Is EIO worth a line of pr_warn()?

Maybe but I'm not sure it is worth it.  This was paralleling the original code
which called pci_doe_flush_mb() to shut down the mailbox.  So this is likely to
never happen.  The callers could print something if needed.

> 
> > +		goto again;
> > +	}
> > +	exec_task(task);
> > +	mutex_unlock(&doe_mb->exec_lock);
> > +
> 
> If it is likely to take two minutes to acquire the exec_lock after
> rounds of trying again, trylock + wait timeout barely make sense given EIO.

I'm not sure where 2 minutes come from?

#define PCI_DOE_TIMEOUT HZ
#define PCI_DOE_POLL_INTERVAL   (PCI_DOE_TIMEOUT / 128)

It is also not anticipated that more than 1 task is being given to the mailbox
but the protection needs to be there because exec_task() will get confused if
more than 1 thread submits at the same time.

All this said I've now convinced myself that there is a race in the use of
PCI_DOE_FLAG_CANCEL even with the existing code.

I believe that if the pci device goes away the doe_mb structure may get free'ed
prior to other threads having a chance to check doe_mb->flags.  Worse yet the
work queue itself (doe_mb->wq) may become invalid...

I don't believe this can currently happen because anyone using the doe_mb
structure has a reference to the pci device.

With this patch I think all the doe_mb->flags and the wait queue can go away.
pci_doe_wait() can be replaced with a simple msleep_interruptible().

Let me work through that a bit.

Ira

> 
> Hillf
> 
> /**
>  * wait_event_timeout - sleep until a condition gets true or a timeout elapses
>  * @wq_head: the waitqueue to wait on
>  * @condition: a C expression for the event to wait for
>  * @timeout: timeout, in jiffies
>  *
>  * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
>  * @condition evaluates to true. The @condition is checked each time
>  * the waitqueue @wq_head is woken up.
>  *
>  * wake_up() has to be called after changing any variable that could
>  * change the result of the wait condition.
>  *
>  * Returns:
>  * 0 if the @condition evaluated to %false after the @timeout elapsed,
>  * 1 if the @condition evaluated to %true after the @timeout elapsed,
>  * or the remaining jiffies (at least 1) if the @condition evaluated
>  * to %true before the @timeout elapsed.
>  */
