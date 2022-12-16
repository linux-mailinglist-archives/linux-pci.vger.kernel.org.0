Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB71464F0C9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 19:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiLPSP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 13:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPSPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 13:15:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C0201B0;
        Fri, 16 Dec 2022 10:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671214524; x=1702750524;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=31qrinnmibLOCpUXa/HlLvj7g6+QzG+LsavymXza0fM=;
  b=FteGBy79SOmJtr8YzUOnVFtc3MddoUc25JpPkwTw7VsL3GHfGlH67Xcz
   1wo0DshW6g+1AFdTxKhskEB+Sbm982tujwZLrXIun8dBijhczq2oH+6cS
   54qjnKxAyHtjpsIvOoSZ0WSnkjLCAlcUx/DjuLofIHOZtIGoXYfqLGK+D
   90SYvptsdmdI63hCZxp4drF5N8SXZzj8W3Dyiu2wVJONDJIAc7wm6IYkV
   UyCQ1QvkEOfi/z9lUEKlIxHm8saCTGjDpBQaDrjiprBg/CLDvOIfzcRU6
   +nYBFD0LlXzXmCgVtOX2pVeTg1domsT7Ny3EnDA0duvuGsAhRI5ENjcwd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="381245512"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="381245512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 10:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="792169016"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="792169016"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2022 10:15:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 10:15:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 10:15:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 10:15:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8Fe1MPFTwIt2MS0m07Tn4CWAmjcDZk2g3A5sDFBiLurW201EDd6rQVGQNueudRp4XNjKVxgquJTkfbF7Bo6WRky3sarujD7nSL43YPb+eNxHpXpi1WRv1/Kv5RNg54g3o4Rg+1ndAFN8gSTlh/25ZkYCPcEnwGQEPCxQjwPQE1ZsR2f6RI9HM7r47QPgAcURqNAHnWlsfg1K+fkyxSL3U5DAJGj60t6rNfNZlm3CSbk/AS2gj2BkiJYSvYY/isV3Okglm3nUoOaOjAdojZyvdHS3UxdAgFIQWOBCQdPT2moETcN3WumwIWV5WYDjcSqBtA48RVXiXk9UCsTc2gotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVvh+SIkADg23/ct3Z6KGPNh+m+oxlF4LsEqx4GXBYY=;
 b=MxtgSO/eBy3d+qtHjqqhGS08fRd3SA22PoA8OGjGW4abCC+QHAvw/bukcFn7ZGnGVSgFaT5OkPhkbVjD2M1i+wewBqVojYbJzI2ysgjLZPdnRaizRw40Ob5aFXEosgF+XarJzgEdhdj2nzwZcDMEf7GvFp7eFMPLUyF+lDnmzW+tmHaSika/jHrFXxThtRACnXxAn9PSK+BJQMivGHxVk9fPQHXfxa5f5rz70QJgRWwdR60H/fGRck6iJFMRAfQgOS2hKnBiKRLyC8FiR7dv5FByIPUeDnyUJAQ7gYuwBj8+doaykGD4BzilZqOeFwFKQ+fDUwTWzYL7y3j81rVXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 18:15:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 18:15:18 +0000
Date:   Fri, 16 Dec 2022 10:15:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 0/9] CXL: Process event logs
Message-ID: <Y5y1spikvIrH4qsg@iweiny-desk3>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221216122531.00001bef@huawei.com>
 <639ca459102ad_b41e3294c7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <639ca459102ad_b41e3294c7@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:332::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: c1885260-464a-4ce1-3c49-08dadf917ccf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ljf1QuL1zc2XbOb2Bib95MEolEtYQBDft8XU1nnADkUlkr08COEbHiXTAq0jTgEV0h12n6PLb6EOFG5EbKdgFKlsjhf5mShIumkpCPbnUKFxMxB2iOh5KlLHI9bnm5VUno3nUvd2HAPfRUm96vRempJsKH9zAyAJrYEHqlxm9ovosZJAaNI20Es4fZqbLLWDUkOBTW+QRJxKObXBuoMdgUPs3fxzMpKmP5ZPxnsiUWV3pUK4ISU7wMDeL7jRqoWSgOMdqgouYvqab0nGk103KNZ2BTp+K4eAPxdWXe6ZFDhc/jdsi+CU/we0D1MInOe3B/iLvFvePn4lJINjS4FSAChlFEsdB1pNBJ/kH9CuNRjNhpjQAyFnPYBPuhIYITp2Xl9+fosCJ4exFgB0v1BMDVQ/RODwklgq8n+7jCKHYwZauNSBZ5/fj93Yt+QageoihjEB3PRte6LXXpcT0GQXi8mpEnEJ3Ogk/5y4eFCQuzTrGhhLKxCh6FIFQCz/MJdd82x+djfDKjBM9tRgIMZECDIj6cTP1KqfnlTRU1Ad+3s7xfGrn+xj3B2VMxomLZGzatCnPFwoUM+qASiwLzMbwL0FiixrW5KGNIk5cYMNNZU+/OkGuFeeTfYe8ydcj74QukLVui6QZyBQLEjKEo+WdtnLi9ZJ5XsSztRSaCIgRIN+1WpXLB1Jv+Bvqlq9nlq9KpcK1WD+hEtusnfALF0KlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199015)(83380400001)(86362001)(38100700002)(2906002)(5660300002)(6862004)(41300700001)(8936002)(33716001)(4326008)(6666004)(26005)(8676002)(186003)(9686003)(6512007)(66556008)(316002)(66476007)(6506007)(66946007)(6486002)(966005)(478600001)(54906003)(44832011)(6636002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Exfxlfs5OwvU0i6P0vITMbESEkgZgUvSvgwf6vFPECB6WEIET7QpJZQVcrI?=
 =?us-ascii?Q?QCo0cavG/ZL8s2wVG+fZe3O10T54XCb0E3Ky9Njfqjl5/9qeCG94Og3gwOoV?=
 =?us-ascii?Q?XwhFzYenlkNExCrVzT1EGhT+9ZtdfRZdIp56Lv/FI3ONEIYTYDi1pEcacE96?=
 =?us-ascii?Q?cJ8fpV/MhuVouCo4ozmCis4U4EREtm4dyqs/EvM6gWBZ2RwL3dX8g1CqJUam?=
 =?us-ascii?Q?hXeyVgXFbsVLgTRSBSGYhb+p1GiQIILjrWTieyJPha6h0uQaan5AZWannRH0?=
 =?us-ascii?Q?wdeg1LiF0wohtkEiEyZAnuiziWW4FR/71T28W66zO4bSAyozHE+HnwDa8sEM?=
 =?us-ascii?Q?tdakDQMv9f9ZcQZl9v7gP5aGNgA4j8EUm+A4hnVuHbB1GgKzRYgaIJpRmHfu?=
 =?us-ascii?Q?X3BGDMgwBFUl+ex9WsNcY6O2ZIVKeYTdrJxT4BYwcUhfrCiilOu0ccpMa8hr?=
 =?us-ascii?Q?pSjWgM+DPiISb5rLuBcU0QbCXTx9ASD+w+pCWiYEuo4+Qk+UlbOXM5M2iORz?=
 =?us-ascii?Q?VxH/vTX98wI1VZjFEFNpDqJerIXUTPFbmKdet6s9Y77nmmDoXSGLZ5aoaAtR?=
 =?us-ascii?Q?g5zoqjJqSCChvCRiwgnnb36tGoRIpuxST8d5OdAib+rlk5xl2MnsGUU7KaXY?=
 =?us-ascii?Q?eT1J6Q23se4yeyZUlQ81STb5DxbDHnA1yq4OFWURNAwqrqctUlChVwwonsYS?=
 =?us-ascii?Q?Mj2OFb+brleEu3B0Kr6CUmSYGQno7gH0vgUAVFVuqRCQJXIA8sVtPqrsMeBT?=
 =?us-ascii?Q?p0J87/uCvvopq/rnqBV9JzGn3diqjQUDmKOQBnYtxvq8xvNXoRZSuwH38mgh?=
 =?us-ascii?Q?MpNNI+QpUR2he58kVwcgUgpwoL3GJbPtonY8LG3E1NOkyQ/oLxfbxJilrIDi?=
 =?us-ascii?Q?ek+NpoRy31cMui4Z+/OcioJxXZWj5WnA6IcCXAHspBhxGIbb0lkEw4wylNle?=
 =?us-ascii?Q?f3bZD2FGCbnLkV0GrgqI8tmdJJCSz4OAy0fjIGn8/aQeCi2AiOzYKPY3kPAe?=
 =?us-ascii?Q?X41NYmmrnqxX9Ean9DNIAcGSN6BOa5xxDHjlka/R2rwrsOJryE4ZL2c+xq3c?=
 =?us-ascii?Q?ARWFFSw85E6Ykyu5hT8UFaI3qQIIT+vZRQBl25KGLJPJlvyApW2KH3C8GIcb?=
 =?us-ascii?Q?rRLA8QLPIsJxhFPr+xlLBrOFCphC7LCMNxIx+Lg4rUqTJ02Jh0wgLEjpwvlv?=
 =?us-ascii?Q?OPb9JqbAnRomn9Kp3MwtiwGVqlnJBpM+/UvI5EDUZvE/xB6+dgc1oI1aq7IJ?=
 =?us-ascii?Q?lWHep0sktdRI0U3GDyqCOtfsF2epgBg3jraRkLl/o1dWU9xtL+XCsWlbTtDb?=
 =?us-ascii?Q?WbWbCc16vYO9r8G63bQFdSkI2CI1QKKu9rI5UbBuQFisnKlwpCRILDlP4i/R?=
 =?us-ascii?Q?rjRaAFTI5WJkoR1EduPtFFn9sHLA/LNgRdycINikzaJrE7Ea2e6LIJwctYr8?=
 =?us-ascii?Q?K9fHA0NvuI5Def81MrEto0k+XbfAnh2zDBU7WajOvM/C2TMCS3QsPhRM4EvR?=
 =?us-ascii?Q?VXz2cuTVBB3a+G8hm/2IlDSfSNmUvtg8UKEinYP9g1pF6j5AA6KhBFkaN3CW?=
 =?us-ascii?Q?nMMMlWO99TIL7wJJBUJ7Ofz0sfTlusIj7o2ZsDdT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1885260-464a-4ce1-3c49-08dadf917ccf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 18:15:18.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Br9ExwCEQznlhZnkB6JR5netEqzp0YNZN8EXP5kZNzDBUyNXajRU/cbngPuYwomyZPL1z+VGDgheWE18RdirCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 16, 2022 at 09:01:13AM -0800, Dan Williams wrote:
> Jonathan Cameron wrote:
> > On Sun, 11 Dec 2022 23:06:18 -0800
> > ira.weiny@intel.com wrote:
> > 
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > This code has been tested with a newer qemu which allows for more events to be
> > > returned at a time as well an additional QMP event and interrupt injection.
> > > Those patches will follow once they have been cleaned up.
> > > 
> > > The series is now in 3 parts:
> > > 
> > > 	1) Base functionality including interrupts
> > > 	2) Tracing specific events (Dynamic Capacity Event Record is defered)
> > > 	3) cxl-test infrastructure for basic tests
> > > 
> > > Changes from V3
> > > 	Feedback from Dan
> > > 	Spit out ACPI changes for Bjorn
> > > 
> > > - Link to v3: https://lore.kernel.org/all/20221208052115.800170-1-ira.weiny@intel.com/
> > 
> > Because I'm in a grumpy mood (as my colleagues will attest!)...
> > This is dependent on the patch that moves the trace definitions and
> > that's not upstream yet except in cxl/preview which is optimistic
> > place to use for a base commit.  The id isn't the one below either which
> > isn't in either mailine or the current CXL trees.
> 
> I do not want to commit to a new baseline until after -rc1, so yes this
> is in a messy period.
> 
> > Not that I actually checked the cover letter until it failed to apply
> > (and hence already knew what was missing) but still, please call out
> > dependencies unless they are in the branches Dan has queued up to push.
> > 
> > I just want to play with Dave's fix for the RAS errors so having to jump
> > through these other sets.
> 
> Yes, that is annoying, apologies.
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > > 
> > > 
> > > Davidlohr Bueso (1):
> > >   cxl/mem: Wire up event interrupts
> > > 
> > > Ira Weiny (8):
> > >   PCI/CXL: Export native CXL error reporting control
> > >   cxl/mem: Read, trace, and clear events on driver load
> > >   cxl/mem: Trace General Media Event Record
> > >   cxl/mem: Trace DRAM Event Record
> > >   cxl/mem: Trace Memory Module Event Record
> > >   cxl/test: Add generic mock events
> > >   cxl/test: Add specific events
> > >   cxl/test: Simulate event log overflow
> > > 
> > >  drivers/acpi/pci_root.c       |   3 +
> > >  drivers/cxl/core/mbox.c       | 186 +++++++++++++
> > >  drivers/cxl/core/trace.h      | 479 ++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/cxl.h             |  16 ++
> > >  drivers/cxl/cxlmem.h          | 171 ++++++++++++
> > >  drivers/cxl/cxlpci.h          |   6 +
> > >  drivers/cxl/pci.c             | 236 +++++++++++++++++
> > >  drivers/pci/probe.c           |   1 +
> > >  include/linux/pci.h           |   1 +
> > >  tools/testing/cxl/test/Kbuild |   2 +-
> > >  tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++
> > >  11 files changed, 1452 insertions(+), 1 deletion(-)
> > > 
> > > 
> > > base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e
> > 
> 
> I think going forward these base-commits need to be something that are
> reachable on cxl.git.

Agreed.  I thought this was in preview.  But even preview is not stable and I
should have waited and asked to see this land in next first.

Ira

> For now I have pushed out a baseline for both Dave
> and Ira's patches to cxl/preview which will rebase after -rc1 comes out.
> 
> Just the small matter of needing some acks/reviews on those lead in
> patches so I can move them to through cxl/pending to cxl/next:
> 
> http://lore.kernel.org/r/167051869176.436579.9728373544811641087.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/20221212070627.1372402-2-ira.weiny@intel.com
