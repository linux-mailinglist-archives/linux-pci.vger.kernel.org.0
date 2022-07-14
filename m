Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2157562F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbiGNUGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 16:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbiGNUGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 16:06:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8BC6C103;
        Thu, 14 Jul 2022 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657829166; x=1689365166;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8MLKQ2fg1IuB/6Dv7RHvGR17yzBewsMxaez9pWCXu54=;
  b=CtWYNwya9f0RJL9P4f0tf2i57ez7WtnXii9SXdSj9D1yhR9F9L9xSaEL
   /BpQmHxwvi2acZKuPuuxo5DwGemDD7OtKuCIMhIhFUF0O6U11UkaKbky1
   +jrQ3pe6rG4Psz5OuDtzgv/97hdqPqk8Pgh+Yv1Us97O1RGOn74eMPPUr
   8QQgcqOES8rugW6eukM634yZRkNMahGiW4faWnLqVVuQ+M+QJMs0x64+K
   RhoZ847UrbiB2r3Dcfg+LA/Kd4UAOyjWAC6/pUS+fEz6P7NP7S6f0X2Lw
   JJlQNvgQCFUTpK4gFGvvzAMKcqylNAeRMttnpS4YTOZeNqKc9ZTZfREae
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371934307"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371934307"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571237323"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 13:06:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:05:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 13:05:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 13:05:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrShRqxhEHbAN7XQgQl1RbFytAQxTvIUPh4WL8vkX/Ym4gvtPcbUc0wf9z8h4ZAHLTpghAZNeSMgDOds1m6CrCpBEo5UiRXPk/cRA6CTPXACDPyQOR+SSTMyD4j5VgpV4kHW46tkOsLb9mcn++00oIJQqlXb9qW75uJ0TDzqif5yn/TmHA7ysrVqWpq8T0fqa0eksW1NkwBWXENx3ptD0DgZ9S1CGhJ4fUNHv3RbYmEFO3cKwMNMbKcMvNpW/UFkp3WGPEQPsWEjJAu/znrcHsC3e6Gp0oH4DsS6o5pb9xpFoq8688HZ7lgRQoRaaLTqlj84SoQmEFLkRKqm/nyDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDGa0epIsKu+uKaOOHIRQLEqOyrUHpfzZ1VFhQbOGdI=;
 b=gT4vcUXVNDOv+YrbIysNU5+j09jR9JrvdunNsc5AWEqONk78DA3HgzZOfpLVK4ijE1dMiHKs49/HETQy76OBZOyvS8IoQosragP/a4Su/Q5hZyPSW1+heevRn1dMxQltU7ApLmfyXvMUJlvKRV/bLhR4YJ0RUIAUTjIdIuoLQ9dnVGtC9RA4VYFEWNBpusyENDU+K7FZivGpXMNHxnUPWC9hBqS8LwxoU+UYG/lK5HDCs7kuF10xRz7XmwTTjlpds66AkjqdVybnFySf7hnrLO7JaB48f2RTIWQqqJ6F+atpDM+zRVgZ6RSsvZdafPzOzaVd9/kzVVBeWxk/OF0YPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB3854.namprd11.prod.outlook.com (2603:10b6:208:f0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.13; Thu, 14 Jul 2022 20:05:54 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 20:05:53 +0000
Date:   Thu, 14 Jul 2022 13:05:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <YtB3GySfcm5CfG01@iweiny-desk3>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-9-ira.weiny@intel.com>
 <62d043d8bd04c_16fb9729422@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62d043d8bd04c_16fb9729422@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e906963e-90f3-43f2-bc1b-08da65d44196
X-MS-TrafficTypeDiagnostic: MN2PR11MB3854:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epA7Vh1mCJ1gZeI+ZPT5COjogM1Lj/BfvHbC9CMKeOF5oTEVoINmbt7FgXMyLuPS+xEUu3bubBhMDf0jcNyXXpfIDPhwhIf1eObsOtW+DGaMwrcz5EmNb3FZa7YjhaB+aexqchS602j3JfV22YyGYrXOLlfE2haPRU1X3DqtsTWmKvqEQi2egHiBLkDoV555mtF10jivQZn4qZyJy9cfCJTGDakixUamselpqo3mAuejUBAN3jtv9rOc0svftOo3Gw6ZvwpvKRGsutt7pVqoJIKEis8vonrf2JwLi8b2jQav0wkyVp5MyygxsydnlRKzaOZkQQhtx8rbPKwmOFHEOhKCjlZrtt1ZzK9Z3PewXuQd19jl10gtkurq3XRoYvpJDHjI7WXQsOuyWT09QGPWJJNtjBYRVFhyBg9vkXwtNgsoQiwfX6PWY5ozdIgmvGTtD6+4PCu2yoI4oROz/ClHg2wKc7fGn8xbI7yAI/CAR0IQhOlCQ8xaWq4Bf+F4YC4qmLHAYZL7gu912yPKTWBa5lGO8+Gh09wsd0MS+p4JbE1FBmg0RUZDtM9uqJWPkaoeLxpbGApBbqhG5q2c1+8DfHaWkwKOZ5lcSeUHIGwoIq+cFz4OuLkSFvzTWFZZgu9NWr5UmY/XBxB4zELIx8FZK/1xzRLfLS1pw0FayMx66yEekCqcAxzBD3rAYn41WYqSNIhwN8vHGi0ww/c5T7MrVGq0Rt81ywTK1Hz3MRzyhYqmEmccZDfACT9o/azq4f2lxTz4mgOd0U/DtCHJcBtPHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(41300700001)(478600001)(6862004)(5660300002)(54906003)(6636002)(44832011)(82960400001)(6486002)(8936002)(4326008)(8676002)(6506007)(6512007)(9686003)(66476007)(66946007)(6666004)(38100700002)(316002)(86362001)(33716001)(186003)(2906002)(83380400001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUgGjLR72g5wgNMdpmy9PbVJNHdWCLNimU9i1ufUzVtwqTY3J4rom+6ss6HJ?=
 =?us-ascii?Q?EoA6jJnLMF1WyRtjfA7pUIJcfrH3zz46SczQIrYQ1Yf/GwtTe7uobKpeJ7sT?=
 =?us-ascii?Q?Hajk6dJvDIFUQBQRGpU8t1YrjdGR68uZbrmhNX4NYGK+AhyPynm9MTFFFGvw?=
 =?us-ascii?Q?St/+4vkUYJTuYjoEogz90p1q1tu1XTDr/QCvLJWWawlv053I+O2e5Jp0AihH?=
 =?us-ascii?Q?1qq2CpXTb1eNA25HjJ8o4Esa0VaEkKpare9700K+d57Qj0DUC+djC81xDO/u?=
 =?us-ascii?Q?fsC8v/B2ib7BpXXQm78eOeKc3NFvaOzNPv9dXnu7J4jtG6zKU6oEZPxv24hE?=
 =?us-ascii?Q?lKkKlAkM/SHI//zRKPI6GCtv+hgwkyy9COQ97fis2MmKyy1HXljSyOjmAKK+?=
 =?us-ascii?Q?I4weTDOFqIO7Xv3BxZAKf+EC3KJul7SfbP7vbwbczOICO816N+niaR5r8P4g?=
 =?us-ascii?Q?MO/i3pvngrTlLJWWUFdO8xEhDM8rXvEhJ5i45m9vX9W2tQprIz4FVyeaXDyN?=
 =?us-ascii?Q?6hPkk8H8dpyn76esv632g6MhokVswUtoFO/jCz8/fo+MDwv4vHNosbAL0saP?=
 =?us-ascii?Q?/VkYQUKpHlUXpOoVbmx/XF9H/De/mi0A/ZhS7JM7vMJCwXwqSstTfFhOV9Ft?=
 =?us-ascii?Q?2QO3D7a1n51OSuhwxkkmOMqP9MJeuUPlo6LHh+eQr6W2vPrGvu/vZi4x0rQy?=
 =?us-ascii?Q?e8rENYt8F461S2zSbSdwUiqXaUJQnYPb4aeIGKL+eJDSwM3fgmDDKQFuUb99?=
 =?us-ascii?Q?MkDgkqSxTt8xPFiE4lxcMskiT57u0smBnKxoX5Cq2sVhE1ses/iurtpEB44b?=
 =?us-ascii?Q?YAOs97gegJ/UbeEkE1WVjghcSq76l46WqChV67RCeXo2UnhU/DOaxJeGZSPn?=
 =?us-ascii?Q?9jYFzO7oh9LxKKcdzrvnUc/LtlV5IUF6JrV6iAILLCCxbk9KPOZO0eY6JCNm?=
 =?us-ascii?Q?HeVgN05PQA5Ya+ybshUYlq+5UmEOk01Tt/pS+vzh/jRJll+mkyxiqujAk6bB?=
 =?us-ascii?Q?dJgbPm9csRoYo9P9B9hrvXhbWCbMK95oiqIfZVHAnkdBLrbHJYsg2ePOCrVF?=
 =?us-ascii?Q?YmOz8yeTOglwVkf4OL5q0WLwON5Z0THGsbKMzZO/xR2y+ne+7Uwq3nxyGETX?=
 =?us-ascii?Q?cm/EZtTJn5qXPe2E/HeFZtpLq8RGE86DBSpg5ri5GeTtAEC/eB1s1P60Y2uk?=
 =?us-ascii?Q?Fz3FKwz19YTj3xOYgmwhKFSOOexWZINdvJBZ7O5vztl8CuZfatsFyt51aXue?=
 =?us-ascii?Q?5wXS/HVJ0VEWjVweUryKVGFb+wiZh9+rlWrwb55/zbLrJFCXu53sw5mIrASG?=
 =?us-ascii?Q?8vCyEmXSF3M1lqGuqYijApuQcfOKMo8csTugJqMEZogEF471A6fcp6ckFWFy?=
 =?us-ascii?Q?qIsb5scKivUnGParGSlRHiSWnRQeIaYAoWZHLn4pC8JHUJKfDy06VrDyJ5Lr?=
 =?us-ascii?Q?oGWcOdy3d0Y+bfJIw8mDvXBZChXLO0OUhGhA0amEX2LQySmoPRwbkEnT4rmi?=
 =?us-ascii?Q?2/ZhuIwqcI96Dz5mTwmoaarDsBXUEdQqt6sOR0CJFcmTLjbXo6+tuim7Fvwu?=
 =?us-ascii?Q?sy6OScOp2AzMi7eDL9nDNMHWxlDTheFbebzrD51TfDy/jBiRYjyLBlrRm9Ej?=
 =?us-ascii?Q?WTUV94fwfcBjys1YeJa6vRfo5nuso+Ybgw+fcT9/lqZw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e906963e-90f3-43f2-bc1b-08da65d44196
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:05:53.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gG0sQe8J9v9Su7ku9/S0Wsx+LV15A4sPn6IqCRsrssV7WY9Vd5d6Tt7ermGFrhE06wI5kTrwKAVv/fPH8QUd1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3854
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 09:27:04AM -0700, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The CDAT read may fail for a number of reasons but mainly it is possible
> > to get different parts of a valid state.  The checksum in the CDAT table
> > protects against this.
> 
> I don't know what "different parts of a valid state" means.

This text is stale but given what I know about how other entities may be
issuing queries without the kernel knowledge I'm not 100% sure that the data
read back will always be valid.

Regardless, this has already caught a bug in QEMU.

So I'm inclined to leave this check in because the checksum is there and should
can be validated if only to detect broken hardware.

I can update the commit message to clarify this.

Ira

>
> The CDAT
> should not be changing as it is being read unless someone is issuing a
> set-partition while the DOE operation is happening. Rather than
> arbitrary retries, block out set-partition while CDAT is being read.
> 
> You can use {set,clear}_exclusive_cxl_commands() to temporarily lock out
> set-partition while the CDAT read is happening.
> 
> ...and since this series is only for enabling 
