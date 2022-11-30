Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644D63E00C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiK3SxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 13:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiK3Sw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 13:52:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF221EEC4;
        Wed, 30 Nov 2022 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669834373; x=1701370373;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dfh5xlWUB0VkfmoGDVtFHi9fX0ekBHFas94g03qjfjg=;
  b=LxdEYxPfgyeeG4dg8jnCCNY07yNn8eiSDHq47tzraA+WTof7fvJscOnR
   tCzLhghHwX4eno9KM+ab9IjRz7dtHJ7SXsHv8RcXDGwl122r7aFHq397b
   IY7jfyZ1Tc7cBHqlJ+5hP+Md1UnPbbEJmzfJUlMiGy71zPLXBWOFJ6ESj
   YCo7f1VPjA5rf8hM0KogGIP7RmCEaSPV79FEKGLJdSvXwQaWlRtIu6fZn
   OV7swXXT568kRJFD1eyYjeu0O6Ksdwx8LHtZBhZAFTvRey6PchzlqmUZb
   rUac7FZmKppN4W9hLw6KRC4ZcWnCFYYMvk25otrWHzyUcTDX4pk/WLPK1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313110787"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="313110787"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 10:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="644327610"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="644327610"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2022 10:52:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 10:52:46 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 10:52:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 10:52:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 10:52:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcnvetOyRHEX9siLhDsI91TCDlgBWh4QKD7Sz/319YI3bCxTb/2PoL+wtsXbu6MG1JGynv4j4W7RqbRYFASztavHJ0rsZ0GNdTUn2yHmIY5+Ewb+dO9lEIE8drM4mfKkXFeHfUAzjULXpWkcOOZFBvcJoWGySsP9T12UJO5ZjKRf3o4mdcry4vMhiZpLBKUiCJnB/14yW/vWVZfUYTApme+TvmderMcPjqs7mNd9Huhv8RNp+7iy5KMXxvhjeCW4RizhtLrGVWeTBNuXjcyqzovDjX2eK2RCSGLmlJG7MN6wa9jtipi2VnGeEvCmZUfjrle1Hsn6s7Kvn8cKbhWW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlaHaSWu4/Ti7roJc+vOX7LdRm1PA3nSsls36fJoZGE=;
 b=oTw+QaRAkJeez2tUENI5BJPwszxDu4xj/0bIeNDFs/kUPern/R9m6v17WdUB0k1Ts/8sBEYVgeCxzBg8oej0YDp0nqZp/ZsXRw37ahZumTPPjadGAUubvXwPmuOEuJsI4aqQp/G8sYZdCp/qudOQXUYFSdTYIBrFCTPjm2BUE3Sv7rPqhfd1DzdnWAfyuZGb+ic/TOT1bVa0zODxbRon3OlDHlTXvFRoqWwFQun6cNWAeaJcLzRDcyAGhYCeW12AKCEy6KLSRsLLZRV9GH0LkyeYJvPm7Ww8zFcG8Q0LsemKWfxq+bmRHq7LbagkNyFWHfABKC+v0maJxMvK9MwzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 18:52:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 18:52:42 +0000
Date:   Wed, 30 Nov 2022 10:52:38 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DOE: Silence WARN splat upon task submission
Message-ID: <Y4emdob9uFP354jk@iweiny-desk3>
References: <cover.1669608950.git.lukas@wunner.de>
 <9eb6af0763f1ec05673a7dd6731d9fd646cf1dd4.1669608950.git.lukas@wunner.de>
 <20221130153658.00006674@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221130153658.00006674@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 2645d457-236d-4a9a-95b4-08dad3040f66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0AgUodc5ZMuS8n3o3fBnOlErPRbYftMnCRfyqnKw+isy3AD4YHtF3ohMT3hhBNxG2R3rFCoAeuNev/8FcVMXSZEFygX5DCZG+b08FOW0luakJ68dfXxbHIrBNjyg9ERv43+XAB2VpOJLUNYCqrwuD/zVj4Lv7RoD8c7pfP9LCHFGrfsVK48N5r2iglm2Y3r54kjAArpvGFmZyRBmmZnFz+RxNkW07pZdqT8rjPjuAr13pYXATY3tiMT9mTyK48znoxOdH+AXVj+nIw7pYleIiFAeyAH5c7fOodEuPLNOL27/wG/4ycyN7DsKL3FwWeOD1jG7xKL1ovffzp0QkZIr1v9AQTmaBrZcfC8TiTfBAPulWuq1+OxbMJVxOYPIeD0kHyjQvpqtTHmFLKQLXs9WVej1YddZXRTsoplHFeur97tcwZY7soxfW8T7vAtEOomvgTR6QWBOJ0nn/uD8Hus/4uMIRscHsVHCEsTmdtg/NC6kUG/uKxSbqW5fA1aPF9R+Z1+agbXy9UpiLSn8RvLKq9e9+g+lLzkwfyhursCTi4eTZPBvQ4kHMfRoTGwBEylbBcWbRFrsYU+h9FRex9snvsqkwqTMo7qthgEZwDE9m5x3ezYIKS9AAXXT+QlJRwkfsoNosZVewEjv7vfYGzg4pPVw13G6RyM3+ZVE3OQ1AeBmuv42H20aNdtk5Eb6VSc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(66899015)(6486002)(966005)(82960400001)(9686003)(478600001)(186003)(83380400001)(38100700002)(26005)(6506007)(6512007)(8936002)(44832011)(6666004)(5660300002)(2906002)(316002)(41300700001)(6916009)(66476007)(54906003)(66556008)(8676002)(66946007)(86362001)(33716001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mwULhL47vqj7jEUK8mFilkcH6reKwxbpUJSL5S69gY9YzpiSKs+74Hiu+/b/?=
 =?us-ascii?Q?AuRZ2YRauI4bkLry6i5BgM6RC4IXoDrwc4XGOodLL1Z+Jbj4W9RY1cWlRtgx?=
 =?us-ascii?Q?oY6x0LPPoXa0XVEz9MavdxLCaLkDZYFnalcU9M1bbX41akF3KUvYV5vufvTi?=
 =?us-ascii?Q?W/wKeopEDzbC38nBvr/wbKwneXIi83b14eAIDoMTYfiMOHWudlSioF5ctPbH?=
 =?us-ascii?Q?+z1t28K7K7YXq/zTMoJzMGAzIjWKVjRn+BP6lVEILDDIp9m6JXJli4HEQTPv?=
 =?us-ascii?Q?d50XlNP3kixsV1srmbhwB6maVvgX1t8tSPgDXaU6aJk2JtOY3H8QU6e5a9G0?=
 =?us-ascii?Q?3Aj2P2Smvz5iZcqBEEgcd6hh4GyKvkbpeHG69TZCKxd8Jr6FE946Rm/Vs/Cp?=
 =?us-ascii?Q?WADN9I7w4+tsmmu7uporw2SO0kIxAmLsnaYul9sqD+JncXatSpaI6MXNOZrU?=
 =?us-ascii?Q?yT5PgSWTeBKoB0ycyQCA0x8KGGr46dr4WWTiNcveIJki57HRVgc9aME575uC?=
 =?us-ascii?Q?o9wsYSecIVLEPF0YZDUzuG+1EY6WlIzxllJcD4mQ74Q58DqKqeyOYGtmBRyi?=
 =?us-ascii?Q?jYgafdBJP6+qwirO5hbg/s09QxJYHK7vlzCAkPk2HcFrI7ltoZL4e3oTi3pd?=
 =?us-ascii?Q?1mIEMIVLuZsiIcPj5taj6meCohUVNIczkXL1DeI4A+IOrKu5Rogf3a+jmYLa?=
 =?us-ascii?Q?wudejUAaQUO/j0CdV6EzFtA+DDC1fVv3WgbCIYNAg7/Xb8ZW7ovyepSauajj?=
 =?us-ascii?Q?7tTNu+gRHoUghZVfTWKYuhqC08JoMpGWEgrBcrJ6M7NAVY9bHXWpzxEh6J5n?=
 =?us-ascii?Q?bDxC3XONA/e0rc4uuKe49gsTiMqoi5zJqKsBABnYr3N3Wvw848PN1Lfmt4ai?=
 =?us-ascii?Q?JrDROFMb7ch4iA1LcVBjuGUB02ThCf+SDd7MIcxVC5KSztmodWJ8xVc/CM4E?=
 =?us-ascii?Q?gDlQNTeAHfl3WBdVJM7UUCJSjOerIYFZ3y2lbwFqMT+M0PIqAIImdhids0ih?=
 =?us-ascii?Q?MB/kpxd1h61rwitUpawZUf+McBoQkY5WWKOkp5maZRRpuWCZlBl+ZwTax9Tm?=
 =?us-ascii?Q?5pV4JbngXa1wLVSDurabIYTGm8zGYhKY+ZCNo94Hki8uJndpyMrjcL2UIQGw?=
 =?us-ascii?Q?mGXdGIIU4lgYOA4EXzJC+ITlkXRYkGQy9/NDWM+wt1cVB6NfpFdYlgDsT01X?=
 =?us-ascii?Q?ZWrvBfSm0FgeKjLiicLDQLse9+T9WgfjLN5UVojhqf/SmKH5apqYXfF8CCMP?=
 =?us-ascii?Q?pDF7/Bzqjh52O2LctkHRN2roZnFlsz4r33rNEFgnyV9ZlKLq3MolmdvrGvH9?=
 =?us-ascii?Q?CWB4PyLheUWvvOS0xtTsgX5i1NXhv4YX1TexgjOsrt9eKEaYpCaa7Mt742c5?=
 =?us-ascii?Q?ko5bnXL5EAJnKxRPT1/Ih3oaFjGAXHRQ0lBSOi2CwtxFNJnYUgY74fAPRccN?=
 =?us-ascii?Q?dEZQRWD44loA+D7j9e/MpBl0AnGf1xEaG/Qr9/0SjnYi1GgYyW3QBqvm5o23?=
 =?us-ascii?Q?BBiv+nxmnVCgDDLUiFmYeU4DzuSL07ZPng3Ny01gQqwx5QhSCAkO+v/nIsXY?=
 =?us-ascii?Q?Kx8h75lNDT8p+BbwQ3tbzSyiKYDODzbbUy+RNA5Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2645d457-236d-4a9a-95b4-08dad3040f66
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 18:52:41.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltLW9KNslsHYTSobkxMaJkywtYOJAAKUwCFnqSpFr+IFJdwV9Y2vrCOm3VzG6ywd1zUb7XvoiJ0VENOE75zlgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 30, 2022 at 03:36:58PM +0000, Jonathan Cameron wrote:
> On Mon, 28 Nov 2022 05:25:51 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
> > probing because pci_doe_submit_task() invokes INIT_WORK() instead of
> > INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.
> > 
> > All callers of pci_doe_submit_task() allocate the work_struct on the
> > stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
> > short-term fix.
> > 
> > Stacktrace for posterity:
> > 
> > WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> > CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  pci_doe_submit_task+0x5d/0xd0
> >  pci_doe_discovery+0xb4/0x100
> >  pcim_doe_create_mb+0x219/0x290
> >  cxl_pci_probe+0x192/0x430
> >  local_pci_probe+0x41/0x80
> >  pci_device_probe+0xb3/0x220
> >  really_probe+0xde/0x380
> >  __driver_probe_device+0x78/0x170
> >  driver_probe_device+0x1f/0x90
> >  __driver_attach_async_helper+0x5c/0xe0
> >  async_run_entry_fn+0x30/0x130
> >  process_one_work+0x294/0x5b0
> > 
> > Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> > Link: https://lore.kernel.org/linux-cxl/Y1bOniJliOFszvIK@memverge.com/
> > Reported-by: Gregory Price <gregory.price@memverge.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org # v6.0+
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/pci/doe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 66d9ab288646..52541eac17f1 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -541,7 +541,7 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  		return -EIO;
> >  
> >  	task->doe_mb = doe_mb;
> > -	INIT_WORK(&task->work, doe_statemachine_work);
> > +	INIT_WORK_ONSTACK(&task->work, doe_statemachine_work);
> 
> If we go this way, add a comment to say 'why' it is ONSTACK
> or add to the function description to say it 'must be on stack'.

My apologies, I somehow missed this series with the chaos of my personal life.

I do like this as a backportable fix and I'm not opposed to it.

I think Lukas will need to determine how much he needs the async support.  So
I'm going to back off and let him deal with this.

Ira

> 
> >  	queue_work(doe_mb->work_queue, &task->work);
> >  	return 0;
> >  }
> 
