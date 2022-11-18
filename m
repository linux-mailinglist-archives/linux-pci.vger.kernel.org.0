Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8567362FCEC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 19:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiKRSnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 13:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbiKRSnd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 13:43:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2BDEA8;
        Fri, 18 Nov 2022 10:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668797011; x=1700333011;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AKH3QW+xdz9pfWuxnq0Yjm49R4r0gxyxPM9hCvHwiQI=;
  b=KPGvJF45vZIBCpr2SOeCVvjEWsljoSRoMQ8ArCwQuKo50Q0ms2nkcPlc
   j4i7U2nF6wSnGPvYujAMamZK/Yh8xUDiyeQR3QRf835rMWME0jBqi5l//
   gqv+9XODZO3gCCXd7R9QyOWYYkvjkrgdSytpWMHrROH63S/NACl1zwRyF
   bPCj7ex36J/G5zRhMer4OrUYcFFiwO5KuMlRMc/eSK6F5DbSddKIqLZ6u
   wyV765IhrVZHPxNkszgT31Khj+2c5knQ7KaOq07ztQaWUVoa10HSNZOEP
   Fzm4+HeKb3p2lpg57mZ1G9sLI4s+ZS0E2j98uvswCI2hOyuyw5IC0IZ08
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313223211"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="313223211"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="709126509"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="709126509"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 18 Nov 2022 10:43:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 10:43:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 10:43:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 10:43:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 10:43:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbbiFj8ApfNzLaSIX0jv78n016XyuwHg51RNEgi0x3x/6WehMyiaf7QJBDESNNaQkdIsxFB+qGWdByyKKI9oeuN+npwcxemHUVV9p8vTJkpXLK/a3biQKGWpz/pu20/UwrMDBnE1YIOYx6RYpwrjTb1gtObctXIlkYIFQCpUrggjLr070mU0gVjiA2MMyvlvwPbELThRl+UlQIsG/s4XoZdauJUegCOgKYcz/7yOQAj3g80uPV+CPr6MBEcHIZgq2djabS6f6XCj6E3actY32vIPGKFVkQ9yJ4Bx5CuOktQUBeCyWcBSvvCRzYYc1ye7fgQwEvGUEVwzwLxSclLueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLWC3tY+A1Wiy9qTo8sfQPK9ce59lt1OWmO0SsIWm6c=;
 b=UFHw3vMI0skrdlU8aVwnIYO+8ruLj0H5ToQ6sJkfXVBuf2zMSvgO74K1TerGJP1675ILOfSH7MeiPTjNrp5v8ClJI/g2zTJ6ThOglb/ULKeARtqh6Cf/tpSOPuryXY/OeuW3cdyluGlhi8tSnFMGUBLG8q1KtCiNmyZuYsufRSbrfeCZTXpzVwvkjsufV6liar4HUo6fFFpSIQtzTom9QV+o0gbAAc/uvbnVSgJK1xSxPLon/qmvzFtcSlIrpJCBba81fLFL7z/QgWOP+2+wMz3yLfWGZl7R8xGYt+1SZ6/mRVhCyVR35tsmFLxfSI3c7HB6lhiRJS4MpYw8FrxtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 18:43:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 18:43:22 +0000
Date:   Fri, 18 Nov 2022 10:43:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     David Laight <David.Laight@aculab.com>
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
Message-ID: <Y3fSRbpjeC1CTPA1@iweiny-desk3>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: d0989892-ecc5-4e85-e115-08dac994c51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNrBIPMgKPSGn3X1cjsM8a8kQRr1eGHQ2kXdwEiRLbX7QA30Tby8m64JE91LZgQVkawESW/dIPEublsHI2MDUSrPqCc2Eqm8AzbYpAaxDQ9Mz8qVJSV9VcCAxrDUoi5DeKj1VNrf5fnDa8XZRL/TkuZ3XRDxKP+LEdaHqpluDT+O/5VnpmXOc3b/f854epsEEEjVJAgfnOLXYYgVV3YvogNRW4u2X8C1nv3IwKD2zUA+u2xtTAIBCxIBGWMe507VASFeyd0Lew7QcoKx3yKKpHsmKbujjlY/k79Rsx4Wpps2ZDeVTF8Z+AIYzz7wIaA+u8ytwpxNqfacCs3lg8xaN2KNZhPI5O+phoIQbOq62KpE8Goify8gMjfxI5Afg2MYnMnRL0AGTQ+PhmYyT2u/ylQ8zRU4+RG0swBMUND1JR+KItaceVUldIGVg8qnmePlaaET1FyLuLHF0/p0ivOHoraER8n1fkXFGQynrQR5Ved4jrcyKiijYlbQKym1fOyhYixWYWImWk1f+qOZJKk2AJli9hLnnVN5eJ2+QoW5hgNlhDN2AI1T+I9sJWWGqY0UPp31jnZyl9VsnY32r/V3HxZxLCHYySi8ImMhZcJR+UjT5Gpt1B9pTJ9gU8zupeP+NJJjRThVIQ9rumBUg404uIQoQIN2zWe8x3BN7mjxN3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(2906002)(86362001)(26005)(6666004)(33716001)(6506007)(9686003)(6512007)(44832011)(66946007)(5660300002)(66476007)(4326008)(8676002)(66556008)(8936002)(41300700001)(316002)(6916009)(82960400001)(38100700002)(478600001)(6486002)(83380400001)(966005)(54906003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5j+Po0k5OF46Dp+UDAlfDSMGNqvb/UZtvDGBRjIYhQC05Rgr+UoiuRnYGoh/?=
 =?us-ascii?Q?l4AQuWpOTfz5HeOka32JJNSyTvA88ZddyU4jEQHvMHCSpgAzTx+0RzLGt3oE?=
 =?us-ascii?Q?sfybnuI7u3j+y8QW7X3c02UNoLG/fPTabIJj51c7zVvM3kguiipdBgp2yyKE?=
 =?us-ascii?Q?aPCtsUwbYMYkJgAJpXpG6vRrfGKxDcRRE6GQFn09iFGgrDm9h3gzCRQ+9XkV?=
 =?us-ascii?Q?d9ySkoq4l9jqqyvbs0cdRWD0oRVcf9spIvceODWip1GBOPoqIPFneO6PyKTn?=
 =?us-ascii?Q?Q/sYiiSIbe1EkOF3EB6eoWX34XjtBYya8z1CJ4/atF3nhkI773CK1hvcMC/T?=
 =?us-ascii?Q?uy2kPbgwxH1VdAbD73BV9zMmqbt15u0LcdgzDyszhZw0UKEngPbPr6WjaQtH?=
 =?us-ascii?Q?5x4V7YGIu2zCh1APR+6a103QUyZ0eGBspV2JyFVzaPQfQnT7J6iKe64bsQTi?=
 =?us-ascii?Q?P96IrQcGwHNrJC7Me+4Wz1C3jpI/fkaRP2Yjiw2HnuXHiBkgODphOz/QTsFG?=
 =?us-ascii?Q?RgHj0prqSi5h6Eds1JeNZq3sbj8FXBy3QmjYF+g8iB9I/5xzElnSMAKuHBvU?=
 =?us-ascii?Q?936xjL4oncqw7OXwom6yqPsAau+CU31qnRi1ObWRXvVkSBTamhSPepMcfJid?=
 =?us-ascii?Q?dwJ5X8UfinlNIV+O+YpiE0j+H147VlYxcyPsj1diJTC4jq9IwtHBznJaUnfv?=
 =?us-ascii?Q?1bQ8r7UyT08FAhI1KaI2rfByQZ1HXsoWTmj9mPxANmKQOq1O5PLFRhx6U3df?=
 =?us-ascii?Q?wQ4iIIPrSJkXpy8+3L2h08czrnUE0IFi8CAiy9/S1NO1mpy82dAhGvng3Ngr?=
 =?us-ascii?Q?w94a43bNWgfHeRMyttzzBtErqfF/+XR+GQLHR46fAqoOPiYgRMIoa307yoK9?=
 =?us-ascii?Q?ATVXF/8U4/kWEQV9Rx55iX8Mg7k8uhgy5Yjw5rqEPholWaSYd3J9+NIlHUNg?=
 =?us-ascii?Q?uitgLDE1CPCEE+9caHFePJuuo91/9FOH4paDnY4teG0uufCagKY+apX+4OFV?=
 =?us-ascii?Q?TUWqG5eRzJ0LtHGCxgZAo18dtR1TWutzAOpyFjIX845ALIbd4zL0QaRdXTKg?=
 =?us-ascii?Q?CUxoaV3ijbSw/BbMfUyZE+pdTERedAI38XfkLOWlqI8MPF3X0CHolVdx+je+?=
 =?us-ascii?Q?I70lIhpIFEoU1g0HZ/40yvIrqGcQG/m0wdYR8n7bCYQypmjj0dRKiGGBotlT?=
 =?us-ascii?Q?nJKMJ6ARA0hDn9ND/sJBsczQIoOGxWxVXkIyUvffdmIDWxAFnN4c+bUAciye?=
 =?us-ascii?Q?vVlQ7LQiFP8GrwPJ63j4AbSkg9MWaI2n00UydC77SAXFn3kvYJdlr/meVKiy?=
 =?us-ascii?Q?Pq+XACtAoKCgAY84BNgoQFzCUFkWlYyiZVXjCkzojzPQXyMaZax93CfSjh6Y?=
 =?us-ascii?Q?39ztGo0suNIQc8qrzZ0sm7H3Mr1DCg+dOjZ2R02zu8vun3PPdg1orZhJfMd3?=
 =?us-ascii?Q?lkHPNGxot4EGqSzzaBamn3qknSIdk64QMN1Hyx2TOGhvZq2cqjrZH7IlY+gZ?=
 =?us-ascii?Q?U0pS8s1m2zgtZYsCEi7DMbTPsDnKOflLvd/Lyv2SC70f7+/pZ+B1ZPY9egX/?=
 =?us-ascii?Q?rlDk5PGTLBeyxDZRZyB5aAvW3pX85r6hrX/TNdV9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0989892-ecc5-4e85-e115-08dac994c51e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 18:43:22.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84qS8s2OCS1s0MdQ7rT7KawXhP1LD3tx7cD8zl+n7g9XTE7MzYgusGPWNyuU4NtAHFG9LIxTKjX6OSPugaWNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 09:20:38AM +0000, David Laight wrote:
> From: ira.weiny@intel.com
> > Sent: 18 November 2022 00:05
> > 
> > Work item initialization needs to be done with either
> > INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> > allocated.
> > 
> > The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> > stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> > 
> > Jonathan suggested creating doe task allocation macros such as
> > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > function is not known to the callers and must be initialized correctly.
> > 
> > A follow up suggestion was to have an internal 'pci_doe_work' item
> > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > could restrict the context where tasks are used.
> > 
> > Another idea was to have an intermediate step to initialize the task
> > struct with a new call.[3]  This added a lot of complexity.
> > 
> > Lukas pointed out that object_is_on_stack() is available to detect this
> > automatically.
> > 
> > Use object_is_on_stack() to determine the correct init work function to
> > call.
> 
> This is all a bit strange.
> The 'onstack' flag is needed for the diagnostic check:
> 	is_on_stack = object_is_on_stack(addr);
> 	if (is_on_stack == onstack)
> 		return;
> 	pr_warn(...);
> 	WARN_ON(1);
> 

:-(

> So setting the flag to the location of the buffer just subverts the check.
> It that is sane there ought to be a proper way to do it.

Ok this brings me back to my previous point and suggested patch.[*]  The
fundamental bug is that the work item is allocated in different code from
the code which uses it.  Separating the work item from the task.

[*] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667

Bjorn would this solution be acceptable and just use GFP_KERNEL and mark the
required context for pci_doe_submit_task()?

> OTOH using an on-stack structure for INIT_WORK seems rather strange.
> Since the kernel thread must sleep waiting for the 'work' to complete
> why not just perform the required code there.

It is not strange if some task submitters want to wait while others do not.  It
was suggested that all submit task operations be async and the callers who
wanted to be synchronous would wait like this.

As Dan said there is a difference between submit_bio() and submit_bio_wait().

We have simply left the wait part up to the users who all wait right now.

> 
> Also you really don't want to OOPS with anything from the stack
> linked into global kernel data structures.

I'm not following what you mean here.  I'm not seeing anything like this in the
current code nor any of the solutions suggested.

Ira

> While wait queues are pretty limited in scope and probably ok,
> this looks like a big accident waiting to happen.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
