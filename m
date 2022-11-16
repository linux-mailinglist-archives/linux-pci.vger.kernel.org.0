Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9962CC30
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiKPVGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiKPVFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:05:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F836AECF;
        Wed, 16 Nov 2022 13:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668632676; x=1700168676;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c0p78yqrPirmhL0TV+kvZkB6wTJfSEuBRot/uDlj9qQ=;
  b=XXohJUsFOdHqVFEdG4UOnch5Os21iedkIFjR6y1asAqC6eJiWzoXHCOR
   edyh9ymjD50bd3qzOPBxssflAA+qlfraT2eyzfnqiKfOxOzD+phaNOh0s
   i9R/xvBe1h7BzXsFI32b+SGmLjXxYqzkqRpTrGVXQ/34ZPLq3gMGXGTAP
   Qlrd29yuV5oymOAV8PoctwzLaQ7ZbYL19rlOYuMnujlMItAhtrdn3DutY
   tbcgSwV2AUK/+rRHDje9mZ1oY3gcmu8ppzbpPbGksBFNNYUFImAH9jsig
   lmQchwyFfU8z9Blel3fX/AUfe8js2TT+cBR1BN6QR/BsQpC5Og4HZFxEw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310295112"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="310295112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 12:58:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="781918255"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="781918255"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2022 12:58:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 12:58:06 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 12:58:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 12:58:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 12:58:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8fJqMzEhIQxrW3VNIFcMCaTCqZpYMEwSZtMzS0kKUyo/NDEPOzvbg6ShZRisWbjM0j0k9KB0+YsNApGf0ab74b33FF6PEkHTP9hYw12OeCrNF7aLhbMBZGteK09lFVb/M0f+l/ICVknVCfFVWgg6uTThCEhp2MADPE1Mqtbkvs+lpDQvaJqTNDx0UQpOShxpKePtgE7k+Opc+8e0liFewDm2eRmJ++4KRQQgtFwocLyHeoFH66It+flDaY2friwCUcKj7qwTuSMVnFPLsIx01UMRGwao+dO7g3Lno/0q9VBmncZbuowD8NA4GUXtFwENw3GujC7AQwHhxzVPnjg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQgGlHDrGZT9tF4NuE/Q4o8nCbKXLgHRJcSY2172OWo=;
 b=A9OpnkzbmzC7ilxHy6NM3sK10nRHKaZWLA7beTJazDLr6nw9pJDtgPfygubpH0fizdOg15GDBJsY5Hg7W+H0zbdcmVRRf7dgf0/2mr90q5u+wHrTsQleqlNrz7D+BBVVrJ/K8V6lv20KHTB9ci8CwmXW3n8yUfcLYl+cazIRZ1mqCmbese62QHawyu0W2NPgKcfIKi+3LfqDHABN1lBnVEAz2iNMPvuATqWF9VqVmfxLBMOnFrQ+wf7jXilzUVC4zdMGe0NpuHTF1pmExM0DvWlIxXX24yhcctZET13CzXIvOd8ixTgvqLY9Ni/+V47YKJGscuuV2/YYWascBOSKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 20:58:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 20:58:01 +0000
Date:   Wed, 16 Nov 2022 12:57:55 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/doe: Fix work struct declaration
Message-ID: <Y3VO07WbMI5EYAUD@iweiny-mobl>
References: <20221116100939.GA32050@wunner.de>
 <20221116182037.GA1127308@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116182037.GA1127308@bhelgaas>
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 5492c52e-e916-44b3-42d2-08dac8153f27
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xleLoOUdgrVmf4hrJED5Oc1/T+ktyIyRmSFsKTYWTe6NFPOjF20OI3HlYPvBPCe9Kcla/FYWvrLK+fxTWy/jS3UU5LVU/pSIN/3+cqkJfki3sDf9L33296y7iura44mbMn8vTpwMFhMffXGsCxWeFxYmE9nsZm8uLNOxGgeKbeIuCDhlMvk/F8r5POZ+XZLALcRJb+8rri/Ft1FKvIiuxxmbX9qkXmxgIg5eOgyrM+pIux/f6C+JfmlMEDD4/7vRrVKBVeKmi3UsGIDvnThquFt7D5KzX0fLPwUDnNdSZEMfXZ6gqjl1ohXNwm5I0LBMZUNmUGysd99QcLHiMUiBBI9/PfpmezRgCNVFX79GNMiYIvwmI+PbEuWx1oau1CVwHmLnGi15+CfLFdwJIqtLtdyuDvN9xXh+3YcT62OiM/KKfi+hWdcNb+akh2nknTDOJVloD+/xMLtCRaAfmM9FM5cFdLPHUBh7Vqhs22bjiArMKtBCbR2OcEf+dlPPfX+vtfHC2973XUN2aRNY17voDE9xdNPIjXk9Db5CMng+p7J71oGoPWKUz/Erc4QGYI70IEA8tsaI2kQo4n+d6OHCk5n4zJ6NqE2D0OFjt1xEDnABgVZvAjqfRz2jyvUUaaA9wHR/E5c7n8XDTM0VULq0OQiLXfsvHhIoQ6Mh799qlmd+GjO+3ZzkzNQWynoqxCHlohx9IQQnDGl+CZFjWf3qCbgBl2MTn+fpik5T+Cj769oOWOA98d8CDHGQGqV8lAYVmWfAJ5J7OcOdRWmXtIxdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(2906002)(44832011)(41300700001)(4326008)(66476007)(8676002)(66946007)(66556008)(83380400001)(316002)(6916009)(86362001)(478600001)(38100700002)(82960400001)(6506007)(8936002)(6486002)(33716001)(54906003)(5660300002)(6666004)(9686003)(6512007)(966005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?titic7cpHBZx3Flv4K5j0GauLVBrHBEDlbWeJWo7t7GNglXj804ViVcEi6eL?=
 =?us-ascii?Q?c/FtH2QNSyiSV9AwoaSy1wEmwOgZKlqOYN7y2V8qt88oButEKGpVwx0Zes1E?=
 =?us-ascii?Q?KqEEvT0mFuqHVo2Qi00JmGsnX4DKffwG2JXhdTwvtc5PG+Ti1xklx61TmUV7?=
 =?us-ascii?Q?mGlvz07kWyEib8jkWOxiQywcaMhA0+3yFq9Vj6N9sEtSIFqGpKk7e0NHvCOA?=
 =?us-ascii?Q?P5J1n8RcGfvqmXsRVLSYtxpUp1a9GH3SVqcbVJPUT7mvLwoNEl7ZIkXKUipQ?=
 =?us-ascii?Q?JCXbqoCFdZrcwC0xAD2GxkF9+t0PRXmBtyyg7jzrPl0K5RqiVF5ZK3svPEG7?=
 =?us-ascii?Q?tGsYZI/5+ct33Ix8Q/uLlNdHYroL1oXvLhmAYWosyZEkIWpw69ZYfXXBHyGj?=
 =?us-ascii?Q?VsPJgIxbbKxQxSxVLFIv85CO8Dsq2+yekVTU/zxDsUYlWcriwiKZNHy60I9Y?=
 =?us-ascii?Q?d8/KLJfth8NtNHQ9t8Q3ZtT9SNOyVuRIcDnXMa64V/EVWwoXufWwLZ2WJ8Od?=
 =?us-ascii?Q?ioLZlu3KfGb8gZ8LPCg4VC2V4isiMNYHFIP1A6tOBIlagE5ECj/mfXagzvGV?=
 =?us-ascii?Q?CYXDKi+DgEwarUU/0VoDib4eLg/3N3MhsPoJlIWXVkbO4JwMkUvbkRfBw6km?=
 =?us-ascii?Q?dR9eEodsMueYoWBZiZXhnY5vAhAfO8NXEf++CzcNb6HD59PwAIPw/mFbtly/?=
 =?us-ascii?Q?12NWrhDDwCjggJlJvyor5tE8YQ69AMsYZYcLFBbZjMEm+SKADH5RmBjC1JsF?=
 =?us-ascii?Q?/J5OJ1Rjyy72l7EJqVg6Vwc0gcCD3jmdjsbZv5UJ2K4C4sHy6kd96FsGMICh?=
 =?us-ascii?Q?yddjUmokwdFmUHqSTX7Knu4D/mp++rK+p3X7Ucx0z7GYmXrV2oAlB7gwqBuW?=
 =?us-ascii?Q?WH4rDwPcd9O0u5Oo2LUhA41o3onO7sOxA2QVnz2IeOZdb1LgQ+VgIh7xR1Oq?=
 =?us-ascii?Q?dLEtLZVZU0ivktgmhWhKnuN5BW0kfkRnA8h0efTTiilrLZE4z3B75xHKVebJ?=
 =?us-ascii?Q?hCCfLwTJ+Xe5M1dTnNn4L+iYPJzvn7iiCaWf91V4kKhKshLdVjonQCdTWQvz?=
 =?us-ascii?Q?LcoPfzeJK/HDue6M+B+m98rkOBfmwRURCRiOTp8d0N8aLdQx0OS7BQDYGtyk?=
 =?us-ascii?Q?/6WMsZXuHTQOr5O8jGvfp2RNdYTlK0ypupetDaXnrh+2n8f2kEKlQK4XGDww?=
 =?us-ascii?Q?+gScHWmezDZsIT4o311rE+2ICDuwxry8eLzxndzj6dRJGdgJPwo7rLmTbUnr?=
 =?us-ascii?Q?kUswbiPRiG4t+YESQozbM7RoPssJc3In7nVUKUEMkt8tzohpgbEMGRSM+2oI?=
 =?us-ascii?Q?CB0HZeO0HGbCuS7oY7t06Xu3utxBOPPYNX+K8T5d7ZZEPf+h8aySLpHLk7kQ?=
 =?us-ascii?Q?3wqSvBWJGkuzwkk87zgzevEseL/rIlvNO4UnOrDIZUZ4pks86ecGtdN4U1KL?=
 =?us-ascii?Q?syl6magmZ2Gy6YgP392VjYZg6yAHL0wyaWpogtiYLdx1KLkCfVasiP337VCx?=
 =?us-ascii?Q?0RvTBFz9whNRV48++SA98PgQ7zVsC6/QcyfeuAaX9kdDsOWYvXmTiaLVtjVQ?=
 =?us-ascii?Q?ro1b/Gj85++p7gykAUz2CpQMlk2roVDUO2Q12ycHwftknWknQeFj5HD5in1O?=
 =?us-ascii?Q?LwjeVUQJR1Xax97bvi4Cx9IyIZvWHag/fl/QzLZdsB2a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5492c52e-e916-44b3-42d2-08dac8153f27
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 20:58:01.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB2SupnY6WJauUG8bIyh37B5qxwbcOldyWiBYaxY2hIHxR/bAwxqCO/P3zB8VGADD/dxnadRrP2w8uAmARNI4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 12:20:37PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 16, 2022 at 11:09:39AM +0100, Lukas Wunner wrote:
> > On Mon, Nov 14, 2022 at 05:19:43PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The callers of pci_doe_submit_task() allocate the pci_doe_task on the
> > > stack.  This causes the work structure to be allocated on the stack
> > > without pci_doe_submit_task() knowing.  Work item initialization needs
> > > to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
> > > how the work item is allocated.
> > > 
> > > Jonathan suggested creating doe task allocation macros such as
> > > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > > function is not known to the callers and must be initialized correctly.
> > > 
> > > A follow up suggestion was to have an internal 'pci_doe_work' item
> > > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > > could restrict the context where tasks are used.
> > > 
> > > Compromise with an intermediate step to initialize the task struct with
> > > a new call pci_doe_init_task() which must be called prior to submit
> > > task.
> > > 
> > > [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> > > [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> > 
> > We have object_is_on_stack(), included from <linux/sched/task_stack.h>.
> > 
> > So you could just autosense in pci_doe_submit_task() whether
> > pci_doe_task is on the stack and call the appropriate INIT_WORK
> > variant.
> 
> Nifty, I had no idea object_is_on_stack() existed, thank you!

Indeed!  Neither did I!  thanks!

> 
> I wonder if there's an opportunity to use object_is_on_stack()
> somewhere in the INIT_WORK() path to find usage mistakes.

I'm thinking we could make INIT_WORK do the right thing all the time.  Not sure
what the overhead of object_is_on_stack() is.

> 
> Adding it in pci_doe_submit_task() would add some complexity, so I'm
> not sure whether it's worth adding it unless we actually have uses for
> both cases.

I think if we don't do something we have to document that
pci_doe_submit_task() only works with tasks on the stack.

I would rather just make pci_doe_submit_task() correct and not complicate the
callers.  object_is_on_stack() can't be enough overhead to be worried about in
this call path can it?

Actually after writing all that I wonder if we can't push the use of
object_is_on_stack() into the debug code?  Something like below (completely
untested)?  I think this could be pushed even further down but I'd like to get
opinions before attempting a change which will have a wider blast radius.

Ira


diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a0143dd24430..4cc50b554a29 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -199,7 +199,7 @@ struct execute_work {
        struct delayed_work n = __DELAYED_WORK_INITIALIZER(n, f, TIMER_DEFERRABLE)
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
-extern void __init_work(struct work_struct *work, int onstack);
+extern void __init_work(struct work_struct *work);
 extern void destroy_work_on_stack(struct work_struct *work);
 extern void destroy_delayed_work_on_stack(struct delayed_work *work);
 static inline unsigned int work_static(struct work_struct *work)
@@ -207,7 +207,7 @@ static inline unsigned int work_static(struct work_struct *work)
        return *work_data_bits(work) & WORK_STRUCT_STATIC;
 }
 #else
-static inline void __init_work(struct work_struct *work, int onstack) { }
+static inline void __init_work(struct work_struct *work) { }
 static inline void destroy_work_on_stack(struct work_struct *work) { }
 static inline void destroy_delayed_work_on_stack(struct delayed_work *work) { }
 static inline unsigned int work_static(struct work_struct *work) { return 0; }
@@ -221,20 +221,20 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
  * to generate better code.
  */
 #ifdef CONFIG_LOCKDEP
-#define __INIT_WORK(_work, _func, _onstack)                            \
+#define __INIT_WORK(_work, _func)                                      \
        do {                                                            \
                static struct lock_class_key __key;                     \
                                                                        \
-               __init_work((_work), _onstack);                         \
+               __init_work(_work);                                     \
                (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
                lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, &__key, 0); \
                INIT_LIST_HEAD(&(_work)->entry);                        \
                (_work)->func = (_func);                                \
        } while (0)
 #else
-#define __INIT_WORK(_work, _func, _onstack)                            \
+#define __INIT_WORK(_work, _func)                                      \
        do {                                                            \
-               __init_work((_work), _onstack);                         \
+               __init_work(_work);                                     \
                (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
                INIT_LIST_HEAD(&(_work)->entry);                        \
                (_work)->func = (_func);                                \
@@ -242,10 +242,10 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #endif
 
 #define INIT_WORK(_work, _func)                                                \
-       __INIT_WORK((_work), (_func), 0)
+       __INIT_WORK((_work), (_func))
 
 #define INIT_WORK_ONSTACK(_work, _func)                                        \
-       __INIT_WORK((_work), (_func), 1)
+       __INIT_WORK((_work), (_func))
 
 #define __INIT_DELAYED_WORK(_work, _func, _tflags)                     \
        do {                                                            \
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1..7d87300cfbc6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -515,9 +515,9 @@ static inline void debug_work_deactivate(struct work_struct *work)
        debug_object_deactivate(work, &work_debug_descr);
 }
 
-void __init_work(struct work_struct *work, int onstack)
+void __init_work(struct work_struct *work)
 {
-       if (onstack)
+       if (object_is_on_stack(work))
                debug_object_init_on_stack(work, &work_debug_descr);
        else
                debug_object_init(work, &work_debug_descr);
