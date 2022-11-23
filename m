Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE863676F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 18:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiKWRk2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 12:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbiKWRjy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 12:39:54 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89627C5B63;
        Wed, 23 Nov 2022 09:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669225188; x=1700761188;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RyhBmCRf/uRh8JEWFek45gxJw9QftQakxfDXFgF4V3E=;
  b=WkPuOGEtAEQjFm82ZiGIUASTunYFldgCrAGgqdxgT3EW8g109JAmwPmn
   M/AJrO+yYEkv/kYxAkhaIG+KGURpQRxplBKrW3HDnRj5S2tEjFLiqXf/r
   ic7qKjYigy43fSmJYmBwvy9xaWMooKfTC4nSkAQmPjK0I+kCOAf/vi2AU
   y+9zqa8cqkLs/lBCrQQoQmqFdgwacFE4N+uGOMahw24l74kdQgKh6gpWF
   k31hIe3q44bBYb1p1otOjftFSoC822NqM6gPppCqT7qsl33KGehDfhDCZ
   pbYsqNA/ML2LHJZpHpkXXr3tr3wTNh3LSl4vucqxVrWDp/2PdGk1AUCh1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="341009219"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="341009219"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="644193797"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="644193797"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2022 09:39:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 09:39:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 09:39:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 09:39:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwdQWBdCCNBPHA8HVrY9fEhTwmdzxpq8MukNuouuWhczK0dnsP5XTxYcMvwXYBiSVMvUSbj8HOwEZyx3E8txKBslibgjIoymqZ5HTeX7MN9RZRO3c8wTIYBlTlnrnPc8gPXtZ+03CYS3yV8HqFXhjClFx7ukjCY1+EguKAGqmLqZG4kJe0qcVsQ7TVvqmun/9solQ6+TgWkHh8S+yy8tYkekJdS+CeQP17rciOaOjSFTaUZ79SqgzCPqwIa4CPa8MpIeyA4nl1ABAVjW49aKh4vXvlNm1lB0zWM7obELIm9uvgZOVUIKl3Yr5XeiibwnRc37DoMvL2RzE6F1aXiU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMNT/CEwwxxBr9iAZOL/xYjA03Y7jfgKS9WfKh8ZQWo=;
 b=DXCbM+qIQGgqCQcBRgLODx4wwHOgIexX/UEpvULWnBRj37Mg589bIK1lwL/bFFvfH84nYWFUjVavVlsSSEOAe6zcgpXNG6JlHKiIq9WO+dzzaqrVZO1pVGDoeTRVPeSeiQX8xbzvkyogZo29401752F2THHUi9Q5PZmiuP/mSQv2/R4mM1J4dKTA4kCkZiWehg4Kqtu77i1kMfQ2wIaaQhytebpl4t1ObLXdk6tUSK9sWwIFq+oj/g/UK5OWbhQcXJGkgaG87qfRzWDdOH+cBjSecFBUBpzdH+FLH7FXF199RDY8T3tQi/xzGf3+ZyYbncCF8OPLuvMNX5rP2LGf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 17:39:43 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 17:39:43 +0000
Date:   Wed, 23 Nov 2022 09:39:38 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Message-ID: <Y35a2nhgOUPhhLeS@iweiny-desk3>
References: <20221122155324.1878416-1-ira.weiny@intel.com>
 <20221122155324.1878416-2-ira.weiny@intel.com>
 <20221122195316.GC20515@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221122195316.GC20515@wunner.de>
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM8PR11MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c74209f-deac-4042-e4c0-08dacd79b475
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4450Hz1R/xKcwBizZuJvnE+0LWXlsy29GFjwrYnL6I5ZmzMvoyrBKoveTqzvkxrrl9OrhWAlXjVwI9vGYTwG18Bw/s/9rOPAjRULIyCxQlBRpTMptue925SkmFcbfkN6OY/l+x4nOLKpRdqFUb1U1pn32ziXkw1qAfBgvFIs/1imsNoTvA9pp10P6cFdY8h3qqqkza6B0Jm2hyWouGQSsyBwtGXi8QVDT8MBFR+6FsiXr2w+/bF067jyQLw/+ZChCta7Z0mFdGFJmjxZ95inI6X/sQCk4IGPYpmyhXVgQ+xSW0Z4em68JEUg0cCO5uk/vYf/roVB5dvmnXqC4Gl7+03xcYcO2gilhpwmN4lLPcPKw59CWLjhJgSsSQAtMOxT+00eRllREsN4M5cIoUFUOsgwnSLjcC7igMj20W94ltraItDsK4bAAITUC7OCcVnn24puRTC3v8aTHBZoSmwF6H+b9CXrcrJHrmuA6UoTr3ILjcrwpdRf1AGQieRtsHN1ORMLuggRT6rrv8CbiC6yTULcUYogogaBv0JEnqVABnR1PSK/cox1G90Jk/i9Zd5SWebKklKAGUkfXHJx/dTeRjxC5N0pq9KSIgqnQXdvMRW9iqX4MJLrnTAvKYieJNsGbYRKO0tcNw6Dqc/zVQ7wtfGhdbOZF92RJO65U2YBoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(5660300002)(8936002)(4326008)(66476007)(66946007)(44832011)(66556008)(86362001)(41300700001)(8676002)(54906003)(6916009)(82960400001)(26005)(83380400001)(966005)(2906002)(6486002)(186003)(38100700002)(33716001)(6666004)(478600001)(6512007)(9686003)(6506007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPRSX1D1yOen+0vAfgDsTm2yasZZQiHZpmBnGpJFt0OPbqKsoOm5ie19hsbp?=
 =?us-ascii?Q?C5TeJxGHfSPuOOu47HxFKoGT9wKm8Y/uVZd6AabpyO9AerpifEtLl1wOuUXm?=
 =?us-ascii?Q?xYPyEsAkcv1qWyea94J5lCoQ9SOsADXle9HvkBtQ8LEzlL10YbW7vvHM3rKO?=
 =?us-ascii?Q?z6vtIEQ/uTP+ifZvgdCJtLQkBXaYli8a9d78cDfSckto412W1+SETnOgBDY+?=
 =?us-ascii?Q?wFWzR40T7BJU0m7b42x+sDlk9ji6MLdjv7pYHye/aAvKlsWGCBaDkRVjhgOJ?=
 =?us-ascii?Q?Weft83lQiSB6VS01AA+JMnMpmVkWmW4v1GmCNHZi4hofwzqeLkqvRSt3uoK5?=
 =?us-ascii?Q?MRfOqc7RUmza2RDTf6Gaj5BCNpLEmBBhiogI8Stxynz/FO5RZTqYYwGaE6e5?=
 =?us-ascii?Q?kDOZexYkI85eZ6W1ow6r8kMrVa8ZaxqhYtHFn3AscGJCVtvGaK8HQgHIsG4t?=
 =?us-ascii?Q?ukJzMEy3pD8NJ1vpHVLc4GEfFk8/4nnJBcNRi5X49QXCxR5chz5+5TBrZaiP?=
 =?us-ascii?Q?PYWA0Vcb+fPCNQKvOzvtNmnLjW7L7RR5SDHtIFqmQR70+8mHQpW3IW6JDMk3?=
 =?us-ascii?Q?Zf+dfJxX3PtxqGFerRIZvkZ+AAK4lsN51sE0O0a+CGy15nVy46Eyz2x2bWGh?=
 =?us-ascii?Q?5i7QEZu1MEQ0FB0tmJWzT7bNAfTmeI0j312KaCMAqoE3gKWQguroVt9MD/fi?=
 =?us-ascii?Q?9gtUCYkmAbNNkxZ9o9YUnDy9yQhYNn8fIObFoOVD/75PlFsHR3HNGUVPBLWz?=
 =?us-ascii?Q?UXvI6mUK+zH0LpXxbNJWoOxiq3w3RSjCDCQyCtRKHMSMX+HQ7UwbKeSaB15g?=
 =?us-ascii?Q?Rr8aksPDQAR4CNKYOITT/MvPPyNyR276ZHRL4Ic7994Wldr3D4iExzN0PdDI?=
 =?us-ascii?Q?F9WbHkOrzbKNnN1u/iyNTRJD1XBeWf3qku3a/ScX5CN5oSAjgVx+qOMyidyq?=
 =?us-ascii?Q?mewmL+Yq7D9mUUgith2tTjKlyzvzRt7p0Rk92jRIWfTHj3ZlWvHPk3HXtjF9?=
 =?us-ascii?Q?aorBQWrjgKrX2QGWPaJXC9kaPGRF4cH+mawCcLHP7p1rvzsVZaJltaPggj9y?=
 =?us-ascii?Q?Vk7PLWnxB4yurtgGVPgqUlO9c/C/BwzrVhs5B8yL1XcgG4jZbXf0vsHxj3Te?=
 =?us-ascii?Q?S69/BMEDP+GQ3eZftKNShwjoyZUvn8YSdnTdqcZkpx5cYFCPxnRLCPFlf/ea?=
 =?us-ascii?Q?6SuhW1ii6oK3DvA3tDnDyDuk38P1mSFoX3Gbk3rtxDFNlqYvgzgN3jJwb3pI?=
 =?us-ascii?Q?P2d5ak3yw+qSXRHjubtEKTeJrGTDccr4k96oVuVIW0YyiEFe8aNS0hZ7YRWt?=
 =?us-ascii?Q?dRAl3TqH7+JV6tVbmR+9QA6GXmo97pOgwe/C/rpDVzDuEki7BCAZFkSAQAow?=
 =?us-ascii?Q?JB/lhYAvmoD/f+3CZ/mLBATAGOIaOp1gG465PBer7j0cG1QySYvOoe55fN+C?=
 =?us-ascii?Q?Ls9xwum7ry677Si1KsetzMMS7M5Fjvznh/rAv1Hns9XosO21Fj4FlhnAKb/W?=
 =?us-ascii?Q?ALLdQDWNpwLhyIGSuCoINv0n5h7krYjZq/u0xUSjCV5Z5fCAg9ysPKzjmJSd?=
 =?us-ascii?Q?ZdSTQpg6avch0Gco4JrkMXOlP75WbNAR6MqJHyR+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c74209f-deac-4042-e4c0-08dacd79b475
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 17:39:43.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: japuLfvNhCreLq5V8FXQ0xY9u97oeuOgZtMuBo93A34GcXLXDw2TKOo/V3BLorxT1RFI4tNRV9HqJKcQ2OqSBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5591
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 08:53:16PM +0100, Lukas Wunner wrote:
> On Tue, Nov 22, 2022 at 07:53:23AM -0800, ira.weiny@intel.com wrote:
> > Each struct doe_mb is managed as part of the PCI device.  They can't go
> > away as long as the PCI device exists.  pci_doe_flush_mb() was set up to
> > flush the workqueue and prevent any further submissions to the mailboxes
> > when the PCI device goes away.  Unfortunately, this was fundamentally
> > flawed.  There was no guarantee that a struct doe_mb remained after
> > pci_doe_flush_mb() returned.  Therefore, the doe_mb state could be
> > invalid when those threads waiting on the workqueue were flushed.
> > 
> > Fortunately the current code is safe because all callers make a
> > synchronous call to pci_doe_submit_task() and maintain a reference on the
> > PCI device.
> > 
> > For these reasons, pci_doe_flush_mb() will never be called while tasks
> > are being processed and there is no use for it.
> 
> Going forward my plan is to allocate all existing DOE mailboxes
> of a device upon enumeration.  That will allow concurrent use
> of a mailbox by multiple drivers.
> 
> When a pci_dev goes away, say, because it's been hot-removed,
> we need a way to abort all ongoing DOE exchanges.
> 
> pci_doe_flush_mb() seems to do just that so I'm not sure why
> it's being removed?

I guess I was not explicit enough in the commit message.  1) it is not used
today.  More importantly 2) it does not work.

Because we are not using it currently I thought it best to remove it rather
than try and fix it.  Once we have a use then we can figure out how to make
sure the doe_mb[*] is valid until all tasks are flushed.

Ira

[*] Probably with a reference on the struct as was discussed before.

	-- https://lore.kernel.org/all/20221122094627.00003f2c@Huawei.com/

> 
> Thanks,
> 
> Lukas
