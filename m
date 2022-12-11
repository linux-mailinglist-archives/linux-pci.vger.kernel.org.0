Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C447764954D
	for <lists+linux-pci@lfdr.de>; Sun, 11 Dec 2022 18:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLKR1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Dec 2022 12:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLKR1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2022 12:27:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C4B7D7;
        Sun, 11 Dec 2022 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670779625; x=1702315625;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y6hrmUAVsqiogZPXG2vfNOGYARSRU5b3UUoVzJtjI/c=;
  b=jlpD3pgIilco1/M+lvIxigN0HAt3zW8XnOQF6u+fH9nvR1YXunVxy5Cl
   eJ28GvJh9x15Ltamz6kqTfPUFK8pZvnMgkCUGtsZWO6ohrJKv52nQQhGB
   asqExDIfnPffS+dYIvGHdp3/eRrSI/HVZflui1+iUf5ZXCjHWGHYvupLE
   XClTHCS6O6NMxGk+6T4DC3Png5bD1C/74tp4c2KrYsdOOKI5+Xm8+uwVg
   tZbquEAUh/lJFT1ur4XclOuAyvC7DpYiugFTHFrqdIIAfZVmZSaoetM0A
   fGTMRcYUQYjNX9p2JA90JNERc+1k9H9q0THQSVRpX+xR2cpQNSpGmsiT7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="382021881"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="382021881"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 09:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="647918126"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="647918126"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2022 09:27:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 09:27:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 09:27:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 11 Dec 2022 09:27:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 11 Dec 2022 09:27:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMF6yWOHx3rUqoziOTxCOhSAbwQeR+na4YlduAH590msOeK2iZWzV0Lh5JQy9Juqu9J6eld2jX4cm3cQiTbb9qVIMbVuLl1uwnFbIl01Z9uw9p8y4VjwZ7f01TJImBO5ogzw7V/aYkINi/i4Fz82XW/fEIJPHvfV+zJHETHOChSRnWefqSSqwkAIFdtDgn4Os0I+j+ctkljhSzjful5/uxM8H5z7klp1+eX+ZTz8dIHR7RAC8eo7y5WIWswttbPNijLidsc1DIGEs6Fgom/egCmftMzSkT/RM+w8zmKpMlMO3sluzAluou7eBUxF3XECZklM9edIWsu1uE6B2pcdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxvEifDbCoZLfrEGG6J4opVWc5yz0hX2GlkY7o2/sDI=;
 b=dWf7x6UgWqvquw8b25gax95qtGpApxh6jyXWn/psOjVlAHPNgsMu1k0T6G0HT1Sjz9LMpso9Ade6PuMOB5vZuiJ+XpcJdPuACf+rW11fZxJTI4RllBcG4L5iqQKgLgVx+WW+ofQ/5+HQNie3NvnHeGvp4Byd8POnA2DJE+bLuADWWBsVR+4Gptv46pJzlq3cpbjqJXtyuD4emQVMsG5nttnyZSwXUtnAX73vMhfYw8nGKX64lGDB5NrdhfkllPkLqic39wri+h7wbqt7e81unoElXvA31sXbD8TuE/sglhMpt76ir7xKoAy8ds/XbI0s+NTlCmLHvnaozePbB2dizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 17:27:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 17:26:59 +0000
Date:   Sun, 11 Dec 2022 09:26:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 6/8] cxl/test: Add generic mock events
Message-ID: <Y5YS3TfboLM5BA3M@iweiny-mobl>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-7-ira.weiny@intel.com>
 <6393bb3dbe9d3_579c1294a0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6393bb3dbe9d3_579c1294a0@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY5PR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:a03:167::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 55501752-1640-428d-2e59-08dadb9ce893
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sxhr8DtrIDvg2HpMB0jldBhyZlHelU4pItbDludHBWCJTtxddWSbyzlwJNTD8ps2i+WHSm1OiYCzEytZaRFpC1Zb5heMRglqI5uOuUy+B+mo59yu9vjJp8xCqcp7sIqwWCO76rH3Be2S/AUfx+/gkFxt54Yo1u65taj7/GOLrSkkBfi0qVAWG+XKLrOVr5+LH8Dzw68X9eTlbXQX/M8n09doBF82JsVRwwd8xamXRSfMUnQEA2TNHtdGCP6d4mF6ERqZQHfMEZ8YuocqrLl2Ti6rWyofpAFLY+r6u+qHy6UL4CoB9Ka2jnM55+20iYN9EqIRFE7ZN1FMkgJIFIryZU7yPyH9XpTwbwYT/5qACsc2ggTfqSoynWOvm0NPupdDdA6S9qzAYslFO4clsUWJXGhetgjjhTmSlpvIv0tK8cqq7Ea8vOrhpRLucKnZUfC974HCK34oYsvGLhC8I92hyNFdUvovfjuuIH/sBbfiK/emGVNL2biHPeTURYoRtUgQfaozQNXUyOAExpXmZsX0qHuzWaclqmYh4J86C/bjy39EBdNy22kHqGgLyCHSJGclNiHSBRZ5xMOMtHV4Bc9m+ZO16cW2QwnWceIzZ09rvoHameQq/XtSWogY8E9IS1balOfJrxtxJ/obQ/Dfnt1S1Px74KAKFo6Wemp3ng/jwiAiRr/T++yQPj6GoSNeY80RlM4w1UaCZO9VMXoD6pHuHZChVSLBdVktVcaHvnt8C3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199015)(478600001)(33716001)(6486002)(9686003)(6512007)(6506007)(26005)(186003)(66476007)(8676002)(44832011)(4326008)(86362001)(2906002)(66946007)(41300700001)(83380400001)(316002)(6636002)(54906003)(5660300002)(6666004)(66556008)(8936002)(30864003)(82960400001)(6862004)(38100700002)(41533002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l59UCYElOithNTC80LGeWePyG3vlYG9ytjvyrlbLlo1kzuhc1745heYvfuBL?=
 =?us-ascii?Q?cWIGSbx+g0EEBrJKCXPGLCbMEruzpHIwRqolGQnKj3YicCb3hfOu1AEHvB/L?=
 =?us-ascii?Q?hRaTj0oUIBJQMgsqQ+nJHgQhYc8rgLRHGt9cjuq3AEwT0BhoB6bFMogeP5rU?=
 =?us-ascii?Q?LJaZIG02ecIEU4xYDMcCRFLKIRhHGkyqHEhCpbWGFd/Ww1FZ6Vp/DpI+LEm2?=
 =?us-ascii?Q?ehm8QymGXxK3SiroWxnA55oklW5CzQ8vkXm5e+JXVUzRiwpfOgigFTlQNJr1?=
 =?us-ascii?Q?XHRqxXdBhNm0OaaeYF8ncQHmBSmdQ+AAc8G5fjCRyh8+yfYIpv7if4zedWvR?=
 =?us-ascii?Q?r6ve0d7L43Xhgd0rB0UABIK+Jpb4al35WTMBuHPtqWHmILmNQ6hid9FVznil?=
 =?us-ascii?Q?v3ZG7iVa1ELXJlj49o6nbFIYL0LWbED54KQ2juwaFedCIS8v2c/rMOjJGiP4?=
 =?us-ascii?Q?j0W/WkjuHTTj2yzFRFBswviIwrF5wtyiLxs4df1h8T9D53LDG9toqlQIVC9M?=
 =?us-ascii?Q?/YorM9qrwzHhQ2iMbMyyVIkiKXP5+TczSbKKKAPKdIPoGjulzo3jn/3ylKX+?=
 =?us-ascii?Q?19PvJA0F14Fg4zd2P/18oXeBSp2vNdDikEKKlGL84lIkyV2pHKWlJ/Ayfv2M?=
 =?us-ascii?Q?MF28uoFMYV0RjLO71tdK1NSFk+xIt2WCNVczdFTB8fqtZCCFR51ifVbEXwNn?=
 =?us-ascii?Q?ypICGJ7Sjisq9+fjJFnAQlW2voTCA9qNgfgAoPXrbmC250s1b4LP7BFCtjEq?=
 =?us-ascii?Q?xICUQ7trqN7jiZ72Z94ndQKBcmETQLYz+2snyh/IryFeRMFlh4Wu5RceaRbc?=
 =?us-ascii?Q?zYzcSh7qrTUknzXNomVEnTKZXrFkuS1LVApqwcAc191Mbqo7g9yzwu7NgEMO?=
 =?us-ascii?Q?6zd4vxY3Kc9tVw3q0nTCNegkobLZKgQWjr2qef62Tp0K3NuSLnx5Lmgp7vX4?=
 =?us-ascii?Q?uCP6pF/o+3SmYQhEcj+8OXUbYg9flXfSI2S/YCxbd9FUDPIydD9la4WeBuR8?=
 =?us-ascii?Q?xtwnSOF6w0CdFsAfsM/h3XNbNMqh1/73kaNRzI1QJA69NiAMnujX99XIBjis?=
 =?us-ascii?Q?Rm5TSx5NJD6fKgOhBeJzQxGp3hCR5IKKnP0nesk+Xki620ogBzeoEeUb7T3B?=
 =?us-ascii?Q?507XdR0I+nNuu9eluQ4gk7z4xR/ZZJfOAx00tb2aaH0+5QYcBiDq6XUwXXKW?=
 =?us-ascii?Q?8oonPGejZ9afVRJCUR5o9GERKOe/70IA9yWa/+M/h9cBwbH0JV/n/QG7pPqn?=
 =?us-ascii?Q?u+YUBa3Dvl8iunPzJh1vWUhqQIMBWS3mkeFX8D+dltkK6nL6SU+mmAeHXPJq?=
 =?us-ascii?Q?+EvLQ/rMYwXLiRAGyEj23Ao3toYWL4XVbDmm00QnXsIrLwTDIaD98630jYy1?=
 =?us-ascii?Q?yO2D6cy/vQUVyHY/HCjslq1cbFDuOr1htVImHIAIxgFaQuSxrb2mapEdJv1S?=
 =?us-ascii?Q?LzlA8IBkxabmzd/wNudzNRjtbQdshXcezyWjoZ1xwnMeVZyRqUqh2yF0f66n?=
 =?us-ascii?Q?m9KEBsX+T86ACEPL7OLbsB/eBN5oxwa2LVQC1G5FS7U5ipmI9mpC6AuPFajA?=
 =?us-ascii?Q?x87UX5PYnzU0lWU0TKcGz6NkLRa7D4DOQBtGEkcv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55501752-1640-428d-2e59-08dadb9ce893
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 17:26:59.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYc6PER5frPzW0w5sKNxWR88IDvF0dzipQSwb3OMuQ1Scq04euyNogyXD1tvbkqbVU0SFecBAFi+Pb4BJq35bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 02:48:29PM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Facilitate testing basic Get/Clear Event functionality by creating
> > multiple logs and generic events with made up UUID's.
> > 
> > Data is completely made up with data patterns which should be easy to
> > spot in trace output.
> > 
> > A single sysfs entry resets the event data and triggers collecting the
> > events for testing.
> > 
> > Test traces are easy to obtain with a small script such as this:
> > 
> > 	#!/bin/bash -x
> > 
> > 	devices=`find /sys/devices/platform -name cxl_mem*`
> > 
> > 	# Turn on tracing
> > 	echo "" > /sys/kernel/tracing/trace
> > 	echo 1 > /sys/kernel/tracing/events/cxl/enable
> > 	echo 1 > /sys/kernel/tracing/tracing_on
> > 
> > 	# Generate fake interrupt
> > 	for device in $devices; do
> > 	        echo 1 > $device/event_trigger
> > 	done
> > 
> > 	# Turn off tracing and report events
> > 	echo 0 > /sys/kernel/tracing/tracing_on
> > 	cat /sys/kernel/tracing/trace
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v2:
> > 	Adjust for tracing being part of cxl core
> > 	Dan/Dave J.
> > 		Adjust to Dave J.s mock data structure
> > 	Dan
> > 		Remove mock specific functionality in main code
> > 
> > Changes from v1:
> > 	Fix up for new structures
> > 	Jonathan
> > 		Update based on specification discussion
> > 
> > Changes from RFC v2:
> > 	Adjust to simulate the event status register
> > 
> > Changes from RFC:
> > 	Separate out the event code
> > 	Adjust for struct changes.
> > 	Clean up devm_cxl_mock_event_logs()
> > 	Clean up naming and comments
> > 	Jonathan
> > 		Remove dynamic allocation of event logs
> > 		Clean up comment
> > 		Remove unneeded xarray
> > 		Ensure event_trigger sysfs is valid prior to the driver
> > 		going active.
> > 	Dan
> > 		Remove the fill/reset event sysfs as these operations
> > 		can be done together
> > ---
> >  tools/testing/cxl/test/Kbuild   |   4 +-
> >  tools/testing/cxl/test/events.c | 195 ++++++++++++++++++++++++++++++++
> >  tools/testing/cxl/test/events.h |  32 ++++++
> >  tools/testing/cxl/test/mem.c    |  33 ++++--
> >  tools/testing/cxl/test/mock.h   |  12 ++
> >  5 files changed, 264 insertions(+), 12 deletions(-)
> >  create mode 100644 tools/testing/cxl/test/events.c
> >  create mode 100644 tools/testing/cxl/test/events.h
> > 
> > diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
> > index 4e59e2c911f6..c48d912e3781 100644
> > --- a/tools/testing/cxl/test/Kbuild
> > +++ b/tools/testing/cxl/test/Kbuild
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -ccflags-y := -I$(srctree)/drivers/cxl/
> > +ccflags-y := -I$(srctree)/drivers/cxl/ -I$(srctree)/drivers/cxl/core
> >  
> >  obj-m += cxl_test.o
> >  obj-m += cxl_mock.o
> > @@ -7,4 +7,4 @@ obj-m += cxl_mock_mem.o
> >  
> >  cxl_test-y := cxl.o
> >  cxl_mock-y := mock.o
> > -cxl_mock_mem-y := mem.o
> > +cxl_mock_mem-y := mem.o events.o
> > diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> > new file mode 100644
> > index 000000000000..1346c38dce1d
> > --- /dev/null
> > +++ b/tools/testing/cxl/test/events.c
> > @@ -0,0 +1,195 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright(c) 2022 Intel Corporation. All rights reserved.
> > +
> > +#include "mock.h"
> > +#include "events.h"
> > +#include "trace.h"
> > +
> > +struct mock_event_log *find_event_log(struct device *dev, int log_type)
> > +{
> > +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> > +
> > +	if (log_type >= CXL_EVENT_TYPE_MAX)
> > +		return NULL;
> > +	return &mdata->mes.mock_logs[log_type];
> > +}
> > +
> > +struct cxl_event_record_raw *get_cur_event(struct mock_event_log *log)
> > +{
> > +	return log->events[log->cur_idx];
> > +}
> > +
> > +void reset_event_log(struct mock_event_log *log)
> > +{
> > +	log->cur_idx = 0;
> > +	log->clear_idx = 0;
> > +}
> > +
> > +/* Handle can never be 0 use 1 based indexing for handle */
> > +u16 get_clear_handle(struct mock_event_log *log)
> > +{
> > +	return log->clear_idx + 1;
> > +}
> > +
> > +/* Handle can never be 0 use 1 based indexing for handle */
> > +__le16 get_cur_event_handle(struct mock_event_log *log)
> > +{
> > +	u16 cur_handle = log->cur_idx + 1;
> > +
> > +	return cpu_to_le16(cur_handle);
> > +}
> > +
> > +static bool log_empty(struct mock_event_log *log)
> > +{
> > +	return log->cur_idx == log->nr_events;
> > +}
> > +
> > +static void event_store_add_event(struct mock_event_store *mes,
> > +				  enum cxl_event_log_type log_type,
> > +				  struct cxl_event_record_raw *event)
> > +{
> > +	struct mock_event_log *log;
> > +
> > +	if (WARN_ON(log_type >= CXL_EVENT_TYPE_MAX))
> > +		return;
> > +
> > +	log = &mes->mock_logs[log_type];
> > +	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
> > +		return;
> > +
> > +	log->events[log->nr_events] = event;
> > +	log->nr_events++;
> > +}
> > +
> > +int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> > +{
> > +	struct cxl_get_event_payload *pl;
> > +	struct mock_event_log *log;
> > +	u8 log_type;
> > +	int i;
> > +
> > +	if (cmd->size_in != sizeof(log_type))
> > +		return -EINVAL;
> > +
> > +	if (cmd->size_out < struct_size(pl, records, CXL_TEST_EVENT_CNT))
> > +		return -EINVAL;
> > +
> > +	log_type = *((u8 *)cmd->payload_in);
> > +	if (log_type >= CXL_EVENT_TYPE_MAX)
> > +		return -EINVAL;
> > +
> > +	memset(cmd->payload_out, 0, cmd->size_out);
> > +
> > +	log = find_event_log(cxlds->dev, log_type);
> > +	if (!log || log_empty(log))
> > +		return 0;
> > +
> > +	pl = cmd->payload_out;
> > +
> > +	for (i = 0; i < CXL_TEST_EVENT_CNT && !log_empty(log); i++) {
> > +		memcpy(&pl->records[i], get_cur_event(log), sizeof(pl->records[i]));
> > +		pl->records[i].hdr.handle = get_cur_event_handle(log);
> > +		log->cur_idx++;
> > +	}
> > +
> > +	pl->record_count = cpu_to_le16(i);
> > +	if (!log_empty(log))
> > +		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mock_get_event);
> 
> I believe I asked this before on the last review. Why is this exported?
> The caller is within the same module.

I don't recall the comment, sorry.  I don't recall why I felt the need to add
the export.  This is now obviously not needed.

> 
> I also notice now that the event support code is even smaller than the
> security code that is already in that file, just go ahead and move this
> infrastructure in there as well. Then this does not need to move the
> cxl_mockmem_data definition around or create other new headers.
> 
> Other than that minor detail the implementation looks good. I appreciate
> the effort to get cxl_test to light up this interface!
> 
> After consolidating in mem.c you can add:

After all the changes the code has shrunk quite a bit.

Moved to mem.c.

> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks!
Ira

> 
> > +
> > +int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> > +{
> > +	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> > +	struct mock_event_log *log;
> > +	u8 log_type = pl->event_log;
> > +	u16 handle;
> > +	int nr;
> > +
> > +	if (log_type >= CXL_EVENT_TYPE_MAX)
> > +		return -EINVAL;
> > +
> > +	log = find_event_log(cxlds->dev, log_type);
> > +	if (!log)
> > +		return 0; /* No mock data in this log */
> > +
> > +	/*
> > +	 * This check is technically not invalid per the specification AFAICS.
> > +	 * (The host could 'guess' handles and clear them in order).
> > +	 * However, this is not good behavior for the host so test it.
> > +	 */
> > +	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
> > +		dev_err(cxlds->dev,
> > +			"Attempting to clear more events than returned!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Check handle order prior to clearing events */
> > +	for (nr = 0, handle = get_clear_handle(log);
> > +	     nr < pl->nr_recs;
> > +	     nr++, handle++) {
> > +		if (handle != le16_to_cpu(pl->handle[nr])) {
> > +			dev_err(cxlds->dev, "Clearing events out of order\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	/* Clear events */
> > +	log->clear_idx += pl->nr_recs;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mock_clear_event);
> > +
> > +void cxl_mock_event_trigger(struct device *dev)
> > +{
> > +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> > +	struct mock_event_store *mes = &mdata->mes;
> > +	int i;
> > +
> > +	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
> > +		struct mock_event_log *log;
> > +
> > +		log = find_event_log(dev, i);
> > +		if (log)
> > +			reset_event_log(log);
> > +	}
> > +
> > +	cxl_mem_get_event_records(mes->cxlds, mes->ev_status);
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_mock_event_trigger);
> > +
> > +struct cxl_event_record_raw maint_needed = {
> > +	.hdr = {
> > +		.id = UUID_INIT(0xBA5EBA11, 0xABCD, 0xEFEB,
> > +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> > +		.length = sizeof(struct cxl_event_record_raw),
> > +		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
> > +		/* .handle = Set dynamically */
> > +		.related_handle = cpu_to_le16(0xa5b6),
> > +	},
> > +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> > +};
> > +
> > +struct cxl_event_record_raw hardware_replace = {
> > +	.hdr = {
> > +		.id = UUID_INIT(0xABCDEFEB, 0xBA11, 0xBA5E,
> > +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> > +		.length = sizeof(struct cxl_event_record_raw),
> > +		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
> > +		/* .handle = Set dynamically */
> > +		.related_handle = cpu_to_le16(0xb6a5),
> > +	},
> > +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> > +};
> > +
> > +void cxl_mock_add_event_logs(struct mock_event_store *mes)
> > +{
> > +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> > +	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
> > +
> > +	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> > +	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_mock_add_event_logs);
> > diff --git a/tools/testing/cxl/test/events.h b/tools/testing/cxl/test/events.h
> > new file mode 100644
> > index 000000000000..626cd79f1871
> > --- /dev/null
> > +++ b/tools/testing/cxl/test/events.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef CXL_TEST_EVENTS_H
> > +#define CXL_TEST_EVENTS_H
> > +
> > +#include <cxlmem.h>
> > +
> > +#define CXL_TEST_EVENT_CNT_MAX 15
> > +
> > +/* Set a number of events to return at a time for simulation.  */
> > +#define CXL_TEST_EVENT_CNT 3
> > +
> > +struct mock_event_log {
> > +	u16 clear_idx;
> > +	u16 cur_idx;
> > +	u16 nr_events;
> > +	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> > +};
> > +
> > +struct mock_event_store {
> > +	struct cxl_dev_state *cxlds;
> > +	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
> > +	u32 ev_status;
> > +};
> > +
> > +int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > +int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > +void cxl_mock_add_event_logs(struct mock_event_store *mes);
> > +void cxl_mock_remove_event_logs(struct device *dev);
> > +void cxl_mock_event_trigger(struct device *dev);
> > +
> > +#endif /* CXL_TEST_EVENTS_H */
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 5e4ecd93f1d2..7674d6305d28 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/bits.h>
> >  #include <cxlmem.h>
> > +#include "mock.h"
> >  
> >  #define LSA_SIZE SZ_128K
> >  #define DEV_SIZE SZ_2G
> > @@ -67,16 +68,6 @@ static struct {
> >  
> >  #define PASS_TRY_LIMIT 3
> >  
> > -struct cxl_mockmem_data {
> > -	void *lsa;
> > -	u32 security_state;
> > -	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
> > -	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
> > -	int user_limit;
> > -	int master_limit;
> > -
> > -};
> > -
> >  static int mock_gsl(struct cxl_mbox_cmd *cmd)
> >  {
> >  	if (cmd->size_out < sizeof(mock_gsl_payload))
> > @@ -582,6 +573,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
> >  	case CXL_MBOX_OP_GET_PARTITION_INFO:
> >  		rc = mock_partition_info(cxlds, cmd);
> >  		break;
> > +	case CXL_MBOX_OP_GET_EVENT_RECORD:
> > +		rc = mock_get_event(cxlds, cmd);
> > +		break;
> > +	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
> > +		rc = mock_clear_event(cxlds, cmd);
> > +		break;
> >  	case CXL_MBOX_OP_SET_LSA:
> >  		rc = mock_set_lsa(cxlds, cmd);
> >  		break;
> > @@ -628,6 +625,15 @@ static bool is_rcd(struct platform_device *pdev)
> >  	return !!id->driver_data;
> >  }
> >  
> > +static ssize_t event_trigger_store(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t count)
> > +{
> > +	cxl_mock_event_trigger(dev);
> > +	return count;
> > +}
> > +static DEVICE_ATTR_WO(event_trigger);
> > +
> >  static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -655,6 +661,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	cxlds->serial = pdev->id;
> >  	cxlds->mbox_send = cxl_mock_mbox_send;
> >  	cxlds->payload_size = SZ_4K;
> > +	cxlds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
> >  	if (is_rcd(pdev)) {
> >  		cxlds->rcd = true;
> >  		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
> > @@ -672,10 +679,15 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		return rc;
> >  
> > +	mdata->mes.cxlds = cxlds;
> > +	cxl_mock_add_event_logs(&mdata->mes);
> > +
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -714,6 +726,7 @@ static DEVICE_ATTR_RW(security_lock);
> >  
> >  static struct attribute *cxl_mock_mem_attrs[] = {
> >  	&dev_attr_security_lock.attr,
> > +	&dev_attr_event_trigger.attr,
> >  	NULL
> >  };
> >  ATTRIBUTE_GROUPS(cxl_mock_mem);
> > diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> > index ef33f159375e..e7827ddedb06 100644
> > --- a/tools/testing/cxl/test/mock.h
> > +++ b/tools/testing/cxl/test/mock.h
> > @@ -3,6 +3,18 @@
> >  #include <linux/list.h>
> >  #include <linux/acpi.h>
> >  #include <cxl.h>
> > +#include "events.h"
> > +
> > +struct cxl_mockmem_data {
> > +	void *lsa;
> > +	u32 security_state;
> > +	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
> > +	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
> > +	int user_limit;
> > +	int master_limit;
> > +	struct mock_event_store mes;
> > +	u8 event_buf[SZ_4K];
> > +};
> 
> Related to the above this does not belong here. test/mock.h is dedicated
> to supporting the symbols that are rerouted between the CXL modules,
> cxl_mock, and cxl_test.
