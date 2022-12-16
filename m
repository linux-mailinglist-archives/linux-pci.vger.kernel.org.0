Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7E64EFF7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiLPRDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 12:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiLPRD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 12:03:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5080969AB0;
        Fri, 16 Dec 2022 09:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671210207; x=1702746207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CT5P+Nf+diD7fdb+IzRO+BjaujU/S3F5ao+HzO6wslk=;
  b=ibRVrxJe5+RndQrRTMeAEjnX5Va7f22KG45VFE1ol4BBVqVaFkLSf7wk
   n5F9RxN+JMdriJfFv1UpASjT5I26Ss1aNSnu25ShdRkYUPoJr0Ww3OVmn
   +CjBCyIHPysDaU0KV5g85HbM2FKKUv+Jw5mcWUKFaWakZJUhy6zGnjlr8
   28VB7Mj0PROGToBAEciXCuUC8K8GI9ET8z9E1HHT/r+Kvs86odAOjs3F7
   D+Idhqof1qktUdZYWhM4FnzRLKyCmODLHTleUxY7wSnFJ4JPKdJcN1F/T
   VMp8CgkFUrIbagUwdMDLQ70n9JTcrE1jx/5+jAthn9nHjWdhtV1kd4fpA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="319059918"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="319059918"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 09:01:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="895296474"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="895296474"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2022 09:01:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 09:01:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 09:01:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 09:01:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 09:01:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP36IBetTZUnwqDYZfDgg8K13JLIXB3v0svR8WyVcUQvDkLYnuM47kkjT64Qv2gpApcr0j+lkCAk+tk8GbqDIVMIv27Ct2UIBOnoXZG2x7XUtkRc68+0jW9XfTPZ9L97M87Pnp24LqdZubFxkpeNVqDLgDY9P11iDPVgeSNwiELXzgmN5GBFn0Wdc7dgEewT5uMzmMxa8ToZ0Rvlt+KCcEuYKIomlM8/Mw+yLmk5E4BDwp7nSxrBhWU81yPyQd8/cu+RMRKh4CyPJoeHk5BH5TPWxexajOawN4HzEAyyWUgLANp3fdcOb0P7FqFvQB2BK7ZIrABwV9oMdo6pcLnpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtUiBayaMsYauYK+L2umLEcsoup9TbRAfzJrJ943mBw=;
 b=fQMcTMMD3617qqHltO2waJQpC+8R7aAxMzJ5qa9AWvaayFiaQCB3Vs26u+eg7XlMZRozqNQ1ufbzWux6OhT9opO3SrDfX278denASyZMyI+l4gQwYSnV12WLs+KVTSexMpyRVEGEBqwaKQuIcf28NKrVtPkMEA9yfTQ3bvtRNY6ulkgcjMARyEz2NmshbyHXmafLB1WcFzgtYLteNPBC7oIkMu5CuawsOUc5hADJazsNuGkDdhyqT0KEAu1BLrX//XFPuQzMzLbzWj5YsvKNnNgX/LX+uFPP8NYRq87W6hLP0coWKNU65/i92C5m1ZER8DxC0RJjZheKT2uTcZ0w1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6969.namprd11.prod.outlook.com
 (2603:10b6:806:2a9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 17:01:16 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 17:01:16 +0000
Date:   Fri, 16 Dec 2022 09:01:13 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 0/9] CXL: Process event logs
Message-ID: <639ca459102ad_b41e3294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221216122531.00001bef@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216122531.00001bef@huawei.com>
X-ClientProxiedBy: BYAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::40) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1deb150f-4bd8-4537-f0bf-08dadf8724c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1B+CRZSk5bKzxoJjb63UXR7m4Exo/02JfcrCtuiVhj2YRYNX/a47+onHYvF/kgqpYSkffXB7kD3AX9Kxz3Qkp65bLgpVD0J6inxPJNmFlqbrf+yRZEma+6NS7GXX1F/g3ILFCjoCTr/8GwTibk/d2RfdnQoME29K7cBpwZ2GcBSx9oYa05D+GnGKPzkBRKtG8V3fvLRlbabqi+poMvnVukr3KXFYBktt0/4ciEfx6vWgLu79vf9aCj85SBrgvP4LJrba4RSLv4nJ9SkyZkqpt+HO80+T3/J1JsIotq6tA1nQwkshLdqFXzjliRywmP7eVJ0aQ6D55pG+DubDKJdxTGSR0j/Q3WsNm+/96IbuUWTi5NgCi+nHRBq7XG0qlRmhQZQywnOy7BTfajQdmZfRcEPI4AaHXP7QbL8bBtllRCd6O3RBXVhUeohntsowz8nnWQ0JNsgDDztZw1y95rJciMy7afN+xSREsRmN6K8kTBI9jm6o17DNybgjPT4o9ejwh4SnQzvVAMfbJ4uxc0ANkRnoWTE0BSD9j8e0KaySL1gYn1QCFy4Z150U8CCV+x52QWvOxWO85Uzjsl1w7wWxzqA3Y7PT7prMdFu3fl8GHDsj7xNvwgPL0TohIM9WG2Dx2Zf0VepOdR8TAV8tttVoJb6AA4Z1NMVdWieHjuQ9e14ViuTFpANP+1CpaexLvz8HMSiNeawGaVQKwEUgkB4c4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(316002)(2906002)(966005)(6486002)(478600001)(82960400001)(54906003)(41300700001)(6636002)(86362001)(6666004)(38100700002)(66476007)(6506007)(6512007)(5660300002)(26005)(9686003)(66556008)(186003)(8936002)(4326008)(66946007)(8676002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJbpsvmP9kEW+TR3HRUnFVpTl10hUB2lP4Pu8RU+ikKn6rfLCLub1gu8Ae6E?=
 =?us-ascii?Q?7ypi3Q0DEo5PLlC9Az2BWFncw1JDI4zSMQJfL5XBhpYaFl1kPMETc2EwuiAe?=
 =?us-ascii?Q?Q9WHBkC8t6kXHHXNK69aUlCQEx8dy+rf0vJbfZK/bInNSixlMbTWD7fHsuC3?=
 =?us-ascii?Q?I6mDE9SKDXmbdE6ofsFF4VyhzI9IoSVPnP0OfQMGYXy84cFzM6rge5f5hbeX?=
 =?us-ascii?Q?+HV5kdrd3+ydjrzkxrdTBfz3ljZtwRAXzADCVtcoqM5MU6Rk6kZza/DpmLqS?=
 =?us-ascii?Q?ZTXRlP4Y4QB5fHGFPVpOZ2tXk8WCUX/zWUUB6O/gItOe+dk/INeQ258vJBSi?=
 =?us-ascii?Q?P4zm5nH2FkHHd0o8K0CYXRvVGOOjtjr2GI5l2wz/5uiS1ZldTwDupDQo45dO?=
 =?us-ascii?Q?2zAi0laKC1Q4p4niDhxOHGku0aKcdQ2HVULFqc8gEreWJSi+/63rNhestLxP?=
 =?us-ascii?Q?EylEWM3R3WQuqmTUycAUWIo3DDJjQDPRWOS5VqsLeEnHhWFGG3h2dq4SV9ES?=
 =?us-ascii?Q?rxLR8r0spiMv6bN9kj1GCKtPRG1Bu2CNFkx/DzmrvhXf6H6eD4ja6tyFBRMl?=
 =?us-ascii?Q?s1eoHkKTtkxgdu8r5t/FxyFXR/cJBG9RKMIJ54bvF1P0AOJdr6T0jVH017sq?=
 =?us-ascii?Q?or2fyIyHr1849TLQEiYtRnprXe3KkjoKVBKTQ+BbR/Xv0zI/+LFpm9SMrGes?=
 =?us-ascii?Q?CHeHu7vhMh4xWGzIXpEZnoixZJ2UbFIjGaD4G8dTUK+3XADPHdCv5zBdQz4p?=
 =?us-ascii?Q?IXbc3GGuNSCOSoba2l7t7fhDag/IAaS8C1ASnX4nSAm5jhIgOAjGHHM5bi+w?=
 =?us-ascii?Q?YYTCQ5N2tYfwSPVR8g0kvy6EJeEkWfzDDVbdl4PtAiPtgoPnyR89T/HJrtZ5?=
 =?us-ascii?Q?MUICV0Vd1L+tRscv7MYfJSvG0wKxBRNJJk6Vb0dzuzJj0RkMPVKwDd+sBCNQ?=
 =?us-ascii?Q?HOoXPHOe5D4ZpSnY+YEPHvVwkKF33kDeSj5D+m5SVaVWxbgFQQipwwyPZxPZ?=
 =?us-ascii?Q?wnlUro4gOHleMmugHoIp5h1g8GT4r+lwcQjithxL8xHj60S3cMrRfqk6noqy?=
 =?us-ascii?Q?tAjaloBUrcyxrdl8wXAcDhxnoxHgwZyVyGeCcmb+e0Ilri2tZX6mFw55IEDj?=
 =?us-ascii?Q?YNgIynjiEXnzkWQI8SYY5cHdazw5Z7m67r2ZJUdAZ7NJrEbCQ4YaY/oBnKUk?=
 =?us-ascii?Q?WzJOiy96rfhOfw5Sri7cf2GaXcKhQZ5yl2lOCw6YP+7g8t4Jjy2VDfJqNBsc?=
 =?us-ascii?Q?z9U64uswYXojeG76UDHOrJW+Dza1Xba+k1vHgDZVV/zuGZGhFi/NZ7fVYuW+?=
 =?us-ascii?Q?OtWy8wKD+ZAJZ8YJb7v1G3V3bKrDrzkGglEa6vq/AWkJRMhn+Xc0oG5eG3AV?=
 =?us-ascii?Q?JeYo7cLZb5dJqRjpJbjpCz/KzG5C3GBeBEaQDtvNV/wFzYnoXYTUZR+MXmhU?=
 =?us-ascii?Q?V4420Ppj+4+/+uon1nlmbuk5LG94p5vKx+Uq42gRdNjhcAf2A/qJRiypxIQH?=
 =?us-ascii?Q?igt1TZoboGef4LVbQ9WvYKpqF8ip3ry5EUN1EcukT0W8Op3uVlWViE0LyYba?=
 =?us-ascii?Q?GaEn4QpIKNz+Tvl7ZFCIfTmDcMEU/hsdIwBTo+1bMkNRwH6HbwhNqlDj6fKM?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deb150f-4bd8-4537-f0bf-08dadf8724c2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 17:01:15.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEYqdQHh1Q/8EnyTouPtv0Oqm/TC9vFkeBC1i+3b57o4ya/07Ehe4OpAGl73IkX+AmJlsk8G22DOtrRxDYdYPIqHISpV76lRIjrsBRXIcdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 11 Dec 2022 23:06:18 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > This code has been tested with a newer qemu which allows for more events to be
> > returned at a time as well an additional QMP event and interrupt injection.
> > Those patches will follow once they have been cleaned up.
> > 
> > The series is now in 3 parts:
> > 
> > 	1) Base functionality including interrupts
> > 	2) Tracing specific events (Dynamic Capacity Event Record is defered)
> > 	3) cxl-test infrastructure for basic tests
> > 
> > Changes from V3
> > 	Feedback from Dan
> > 	Spit out ACPI changes for Bjorn
> > 
> > - Link to v3: https://lore.kernel.org/all/20221208052115.800170-1-ira.weiny@intel.com/
> 
> Because I'm in a grumpy mood (as my colleagues will attest!)...
> This is dependent on the patch that moves the trace definitions and
> that's not upstream yet except in cxl/preview which is optimistic
> place to use for a base commit.  The id isn't the one below either which
> isn't in either mailine or the current CXL trees.

I do not want to commit to a new baseline until after -rc1, so yes this
is in a messy period.

> Not that I actually checked the cover letter until it failed to apply
> (and hence already knew what was missing) but still, please call out
> dependencies unless they are in the branches Dan has queued up to push.
> 
> I just want to play with Dave's fix for the RAS errors so having to jump
> through these other sets.

Yes, that is annoying, apologies.

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > 
> > Davidlohr Bueso (1):
> >   cxl/mem: Wire up event interrupts
> > 
> > Ira Weiny (8):
> >   PCI/CXL: Export native CXL error reporting control
> >   cxl/mem: Read, trace, and clear events on driver load
> >   cxl/mem: Trace General Media Event Record
> >   cxl/mem: Trace DRAM Event Record
> >   cxl/mem: Trace Memory Module Event Record
> >   cxl/test: Add generic mock events
> >   cxl/test: Add specific events
> >   cxl/test: Simulate event log overflow
> > 
> >  drivers/acpi/pci_root.c       |   3 +
> >  drivers/cxl/core/mbox.c       | 186 +++++++++++++
> >  drivers/cxl/core/trace.h      | 479 ++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h             |  16 ++
> >  drivers/cxl/cxlmem.h          | 171 ++++++++++++
> >  drivers/cxl/cxlpci.h          |   6 +
> >  drivers/cxl/pci.c             | 236 +++++++++++++++++
> >  drivers/pci/probe.c           |   1 +
> >  include/linux/pci.h           |   1 +
> >  tools/testing/cxl/test/Kbuild |   2 +-
> >  tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++
> >  11 files changed, 1452 insertions(+), 1 deletion(-)
> > 
> > 
> > base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e
> 

I think going forward these base-commits need to be something that are
reachable on cxl.git. For now I have pushed out a baseline for both Dave
and Ira's patches to cxl/preview which will rebase after -rc1 comes out.

Just the small matter of needing some acks/reviews on those lead in
patches so I can move them to through cxl/pending to cxl/next:

http://lore.kernel.org/r/167051869176.436579.9728373544811641087.stgit@dwillia2-xfh.jf.intel.com
http://lore.kernel.org/r/20221212070627.1372402-2-ira.weiny@intel.com
