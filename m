Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B04464880C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 18:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLIR56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 12:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLIR54 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 12:57:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2488413CED;
        Fri,  9 Dec 2022 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670608674; x=1702144674;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f7PnXX0UJCrtbCJhRxmtDz88RBqYH9ss+W46LTzwefI=;
  b=NqN+5jp5uMBfSc6uOxh6H11BULnMhd5+scsNb+9FucBHyJhrp3r3KgTR
   VQALU5e8Bn6c8ZsIbQiHOHRYXpUP+fdBoxrPrFf53Z/UkIrkGGW7d3ciF
   TLpc503ms3YWIJR8AsHDhnZYsWutUD3EvfAOOhMSVSoor2pzXN3MJTw5w
   QkF2pW5fQ3yVBtqyZDOwFm9tQ1oNsArhOTe2ounE+vv5ExsK9/GmjOYJT
   0/rZ+p7BZLfzJXZ3qfzGgHtnjCzn1Ij/lLZZBA2oSrGh5ReTdzNxUDwc6
   /XWBzc92ShjwpsMqaWZMUgeIeyv3cH6sEcUBPfWvqraNB8EVVHBahdeZ3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="381818670"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="381818670"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 09:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="716092912"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="716092912"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2022 09:56:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 09:56:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 09:56:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 09:56:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjUz0UuwbUzvpIM+w0gxRgtsxKsS9msvLNc+QbqROjdCVB4Xr1D/g8sE1MzGbvXzMlu0cekFWqUFyMfJSGmW9zZvchioyOjOK8PmKscR04vzO0tbZxtxXllETIhD8iPV+7Vrdhs76rDo6P0VydccigrAPp56kxza1/6bVo4F439K7J7L1dbhuna6VBIDz7KJNWmLAagepFtbZzWsOPGxeVkxMfj5q88UQKLVnXazYiyaY4lNz2aEFcYqdGnMgtP89FXa0EMc8/qKu0Wn6TtcxdiGtM22SE3W+xdOfqrz2QmcsDU85WktSzwfBumZXvqo7OEDC7/IJPCvhpjIBjoDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf9khvMB4HA/qlQ/tbYhjtg4suDQcMcnlYZEZbhNKro=;
 b=X8RXy9lsYSqqn0isKEOCw3pol3laWxxJnrx54qDpomYLBojnUeEZsYLmoOvMLfj7O4Mc7kiibBqg8jofbZ0HXD/rSVucoiLBnSRtXe+dtJuewY21HYMUGyeVR3LzydgAL7e0Y0ykWrDiuz529f6qOQqQ6mmzZdeCjuzwoCqysqWDvQRA2PjP3JlPQMfPixdEg/yYgaZIgAWc7gG9hODhnbEdZL9NAkb4AgoyP8KULuha60m+O6MgreKwm8T35e77HDi1Vq9XXVmzVunQlbgjeMahoT3I3pZDh7Vx3XOP/UuUWwae8xgSVH3Y3BZAsgQrt9JSb4br0ZwiWSm26oecAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM8PR11MB5589.namprd11.prod.outlook.com
 (2603:10b6:8:26::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 17:56:52 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 17:56:52 +0000
Date:   Fri, 9 Dec 2022 09:56:49 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V3 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <639376e1452bd_579c12945c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-2-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221208052115.800170-2-ira.weiny@intel.com>
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM8PR11MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3c328b-5b03-438e-e4fc-08dada0ec0a4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLSfZ+YQUK6TXjh4jU5BbWKq3yhkgg8weAcfTKA0FVl+d7loY301tRkdPKJWEtdawR8G2NpZBXdBAa/VGCd1BTN7ysT3TgNT6TlTxh/xRp7yDekMpT8Oo159eZmaB+enkZED5mNCScfCvQG+iFsGNfPlK8Ouoz0aZydjQvSIZdvljsQwBavGMlhGADyqYSHK+zXN+j+gMA4mrUWUSsMkLmzw2ejH/RI7eJctKh9mhfB1E6wvd5/7Hg4bZVU84QOPdkskkp8me2qpxFtHW6Rf0Arh6UOukJstW5ieC9OZ0/cN7V2Oy44gKW7Y0zknBvah3BcSFCE5FfRYztgDdMbJ8/Ktbe4A5YroprQhwztfX5hg6Xr2VVB2cmZRTmsEad6DkftJYYvlkScPAGC4oLZIrsoR29pcsGQT0WLO8FHbL0oxhOHr456+VKpTz6YM7fwXqWvq7S3f0MjeWVHNQSEmxGYmmYXS7qp6NY91iSRPkql5gWFDpTf7fDvT8ZCJYuzuLJKQIfthlVkLDDV4R/NYgr5cG40Ph4YdFNS3RX3ydGrzfj5GRBg81LlJcIzwiyrKvaVv/2iJZhWNCLMhCTWXA0NEagumxink5UFuuFHDbxorxn6IAU98vMsivscDIlH7qY9Pu3Vdp4b4RqH1f+VlGUjHbV96dU/fw1SB6l6SSTtGHGHZN//I15xFA8X3IuGV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(6666004)(6512007)(186003)(83380400001)(5660300002)(26005)(2906002)(30864003)(6506007)(9686003)(8936002)(38100700002)(82960400001)(86362001)(6862004)(6486002)(478600001)(316002)(66946007)(4326008)(6200100001)(66556008)(8676002)(66476007)(54906003)(41300700001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kJa3bl6rAzPLaIxj9SlhHsATNlOiJIakgKkej7jr52mCgoBBbdHroLErQ3L/?=
 =?us-ascii?Q?CkctpNSNst/RLjphw86Th0zEtCmTszi5ZELeHUZQ7RumgktR2z99Yx3S7gLl?=
 =?us-ascii?Q?MvqepDiUuwcjgIZfOfNUD6uho6O4HWEJMlKXXdC2j9NZ5M+g18mCC3dF6fyU?=
 =?us-ascii?Q?G1h0s8lSeT58MxoGSsFAbsiCPU/Z/VyQstp6l8na/PRc5wBcHD9P+vHHfmfS?=
 =?us-ascii?Q?pLyTSWXw4no65evJVomW4klvIlRJhbS8NmngLh/upxcgMQ2JSccadSQmozdt?=
 =?us-ascii?Q?NjwaamGPhBQhQgBFxqLbp2zDYkDJElsZLON0dm47ycrIFdfqQbN029p4jEUO?=
 =?us-ascii?Q?rp+lbF+R0FJ0jr3O4n+kFv2GKNc9KMAEKATV6Wy6wkBP/J8+D3lLNME5eS84?=
 =?us-ascii?Q?L8/Vf7nIpX9yiFAUNhkROgV+bwrLsOq/sBGB0hlbdogJkNQVupyi2k1o1hXw?=
 =?us-ascii?Q?ldeRxufUhtYrBvx85IKOUbywkZ7YdFKp7zs9O829hy9K6waw1wkVrKivEt/5?=
 =?us-ascii?Q?ln8dYNPtUIgWobCkSW5SWS0xphoS1HORgwgaHJsg0TI4Tm5TO4xQeJKTNQPG?=
 =?us-ascii?Q?kRNzbCptMSMc/R9x+Wuf+DhEB5NmrZ5CZnhdm4D6Gt0MIi3DDLn1aoQeCpt+?=
 =?us-ascii?Q?YuG0cqo977paBxEZ3SkFDlhrXs7OupO6R7fIeTVKPxGuyktxg8KMfeQh9aUG?=
 =?us-ascii?Q?t7Xp1SPYjjTjIxiyKEIDDDQRlv8E5TRepbd8jo3D1aOk9cAEUTGa5eV1N5cp?=
 =?us-ascii?Q?TLyPBFvcanbkSClMOnyHohFU/mL6nY+cWOa3tiMps8MZ4ytfb65odVmSgh4I?=
 =?us-ascii?Q?Ud4yfb6k4+Tp0XCm3rsT3cdtemqeobTQzPK+X7I1iE8tLBWM8TrdhBw9+6ba?=
 =?us-ascii?Q?17QQld7n0uq7aHtKy7Q7gcRdEcaeFlrRADTiQS9McIiOAQLHDawJifma/JLf?=
 =?us-ascii?Q?VAxdHABkv8ahF8d+ZHMz0lAK9LFUe0bz95YunIbMeiM7ngqD2Z4dSp6LAtkS?=
 =?us-ascii?Q?+EFDtOdHBNfkvY0scwu4XbExSR+sYwfWI24EDsOnzeSog/yZvl6Bvg0Vh8vn?=
 =?us-ascii?Q?5d3rKelLoWZQM+Fmy+nJuX41V8ndnarzMFRAmdyBlmQeA5ZWF1tRoTEF3a+N?=
 =?us-ascii?Q?/cIGGbP2CCRt8CqkGAITUzlVGqTLlR3piKV3oaNvGV9ORVp9WasMmGzpOtpG?=
 =?us-ascii?Q?fHB1vLipunkyxQBUhtJbzxikfPYf6+LWeDPR2+zbe8h7cK/jkTNG3axnleAz?=
 =?us-ascii?Q?DHmKtmAw3GvYgDeBq6PjJwCjmUcqEMG9rPEfMv1HRqP8paAA+ok/DUhbu8VJ?=
 =?us-ascii?Q?LF1Jz218JK/Y+Cunj1Re3tlW3moiC+lEoE8uFB5kDPRmANBbv5/SM5J91tmo?=
 =?us-ascii?Q?L/yhbk4gcHEjxaC4GFexhl8LUOx5o3Gg7OPSeFRf7nbF+3PGeP3YuWPwWFlT?=
 =?us-ascii?Q?55mWPv4XwCz0ZMtsFl28pjg/lFcjOC7mmOundjYBuzA2OhYIt3mDYVPBbrlm?=
 =?us-ascii?Q?M59pP2y8+2mWL+P/ASsTpnScL4gMbA2R8ncHhJDCq5QEC3Xl7vI6Kut0Gf5P?=
 =?us-ascii?Q?c5gEbM39hyUF3sSVG5qxHugCBeh2HemmJZi3nrZCkK2YwTYtHPWP/JHjkxRL?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3c328b-5b03-438e-e4fc-08dada0ec0a4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 17:56:52.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB00FDVe2AnjE2EQyZMgMZh4Vq8ORGazGwL/Ow9rEAihjX4TFtI3ANa0IgzB/I4Idp/qCWUi46cX5mtw0BPNZMpmeDe3cTQGRFhIlX5jB+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5589
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL devices have multiple event logs which can be queried for CXL event
> records.  Devices are required to support the storage of at least one
> event record in each event log type.
> 
> Devices track event log overflow by incrementing a counter and tracking
> the time of the first and last overflow event seen.
> 
> Software queries events via the Get Event Record mailbox command; CXL
> rev 3.0 section 8.2.9.2.2 and clears events via CXL rev 3.0 section
> 8.2.9.2.3 Clear Event Records mailbox command.
> 
> CXL _OSC Error Reporting Control is used by the OS to determine if
> Firmware has control of various error reporting capabilities including
> the event logs.
> 
> Expose the result of negotiating CXL Error Reporting Control in struct
> pci_host_bridge for consumption by the CXL drivers.  If support is
> controlled by the OS read and clear all event logs on driver load.
> 
> Ensure a clean slate of events by reading and clearing the events on
> driver load.  The operation is performed twice to ensure that any prior
> partial readings are completed and a fresh read from the start is done
> at least one time.  This is done even if rogue reads cause clear errors.
> 
> The status register is not used because a device may continue to trigger
> events and the only requirement is to empty the log at least once.  This
> allows for the required transition from empty to non-empty for interrupt
> generation.  Handling of interrupts is in a follow on patch.
> 
> The device can return up to 1MB worth of event records per query.
> Allocate a shared large buffer to handle the max number of records based
> on the mailbox payload size.
> 
> This patch traces a raw event record and leaves specific event record
> type tracing to subsequent patches.  Macros are created to aid in
> tracing the common CXL Event header fields.
> 
> Each record is cleared explicitly.  A clear all bit is specified but is
> only valid when the log overflows.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V2:
> 	Rebased on 6.3 pending changes
> 	Move cxl_mem_alloc_event_buf() to pci.c
> 	Define and use CXLDEV_EVENT_STATUS_ALL
> 	Fix error flow on clear failure
> 	Remove tags
> 	Jonathan/Dan
> 		Add in OSC Error Reporting Control check
> 	Dan (Jonathan in previous version)
> 		Squash Clear events and the driver load patch into this one.
> 	Dan
> 		Make event device status a separate structure
> 		Move tracing to within cxl core
> 		Reduce clear double loop to a single loop
> 		Pass struct device to trace points
> 		Adjust to new cxl_internal_send_cmd()
> 		Query error logs in order of severity fatal -> Info
> 		Remove uapi defines entirely
> 		pass total via get_pl
> 		fix 'Clearning' spelling
> 		Better clarify event_buf singular allocation
> 		Use decimal for command payload array sizes
> 		Remove trace_*_enabled() optimization
> 		Put GET/CLEAR macros at the end of the user enum to
> 		preserve compatibility
> 		Add Get/Clear Events to kernel exclusive commands
> 		Remove cxl_event_log_type_str() outside of tracing
> 		Add cond_resched() to event log processing
> 	Jonathan
> 		s/event_buf_lock/event_log_lock
> 		Read through all logs two times to ensure partial reads are
> 			covered.
> 		Pass buffer to cxl_mem_free_event_buffer()
> 		kdoc for event buf
> 		Account for cxlds->payload_size limiting the max handles
> 		Don't use min_t as it was used incorrectly
> 
> Changes from V1:
> 	Clear Event Record allows for u8 handles while Get Event Record
> 	allows for u16 records to be returned.  Based on Jonathan's
> 	feedback; allow for all event records to be handled in this
> 	clear.  Which means a double loop with potentially multiple
> 	Clear Event payloads being sent to clear all events sent.
> 
> Changes from RFC:
> 	Jonathan
> 		Clean up init of payload and use return code.
> 		Also report any error to clear the event.
> 		s/v3.0/rev 3.0

This is a lot of text to skip over. The cover letter has the summary of
the changes and a link to v2 and that has the link to v1. Why does each
patch need the full history of changes all over again?

> 
> squash: make event device state a separate structure.
> ---
>  drivers/acpi/pci_root.c  |   3 +
>  drivers/cxl/core/mbox.c  | 138 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/trace.h | 120 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h        |  12 ++++
>  drivers/cxl/cxlmem.h     |  84 ++++++++++++++++++++++++
>  drivers/cxl/pci.c        |  42 ++++++++++++
>  include/linux/pci.h      |   1 +
>  7 files changed, 400 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b3c202d2a433..cee8f56fb63a 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c

I do appreciate that this patch has a full thought about error handling
implementing the full cycle of retrieve and clear, but I think these
drivers/acpi/ changes can stand on their own as a lead-in patch if only
so that Bjorn and Rafael do not need to dig through the CXL details.


> @@ -1047,6 +1047,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
>  		host_bridge->native_dpc = 0;
>  
> +	if (root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL)
> +		host_bridge->native_cxl_error = 1;
> +

Copy the existing style and init the flag to 1 in pci_init_host_bridge()
and clear it in acpi_pci_root_create() upon fail to take control.

>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>  	 * exists and returns 0, we must preserve any PCI resource
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..815da3aac081 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -8,6 +8,7 @@
>  #include <cxl.h>
>  
>  #include "core.h"
> +#include "trace.h"
>  
>  static bool cxl_raw_allow_all;
>  
> @@ -717,6 +718,142 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> +				  enum cxl_event_log_type log,
> +				  struct cxl_get_event_payload *get_pl)
> +{
> +	struct cxl_mbox_clear_event_payload payload = {
> +		.event_log = log,
> +	};
> +	u16 total = le16_to_cpu(get_pl->record_count);
> +	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
> +	size_t pl_size = sizeof(payload);
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u16 cnt;
> +	int rc;
> +	int i;
> +
> +	/* Payload size may limit the max handles */
> +	if (pl_size > cxlds->payload_size) {
> +		max_handles = CXL_CLEAR_EVENT_LIMIT_HANDLES(cxlds->payload_size);
> +		pl_size = cxlds->payload_size;
> +	}
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> +		.payload_in = &payload,
> +		.size_in = pl_size,
> +	};
> +
> +	/*
> +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> +	 * Record can return up to 0xffff records.
> +	 */
> +	i = 0;
> +	for (cnt = 0; cnt < total; cnt++) {
> +		payload.handle[i++] = get_pl->records[cnt].hdr.handle;
> +		dev_dbg(cxlds->dev, "Event log '%d': Clearing %u\n",
> +			log, le16_to_cpu(payload.handle[i]));
> +
> +		if (i == max_handles) {
> +			payload.nr_recs = i;
> +			rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +			if (rc)
> +				return rc;
> +			i = 0;
> +		}
> +	}
> +
> +	/* Clear what is left if any */
> +	if (i) {
> +		payload.nr_recs = i;
> +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +				    enum cxl_event_log_type type)
> +{
> +	struct cxl_get_event_payload *payload;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u8 log_type = type;
> +	u16 nr_rec;
> +
> +	mutex_lock(&cxlds->event.log_lock);
> +	payload = cxlds->event.buf;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> +		.payload_in = &log_type,
> +		.size_in = sizeof(log_type),
> +		.payload_out = payload,
> +		.size_out = cxlds->payload_size,
> +		.min_out = struct_size(payload, records, 0),
> +	};
> +
> +	do {
> +		int rc;
> +
> +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		if (rc) {
> +			dev_err(cxlds->dev, "Event log '%d': Failed to query event records : %d",
> +				type, rc);
> +			goto unlock_buffer;
> +		}
> +
> +		nr_rec = le16_to_cpu(payload->record_count);
> +		if (nr_rec > 0) {

Can save some indentation here and just do:

	if (!nr_rec)
		break;

...and then out-indent this below:

> +			int i;
> +
> +			for (i = 0; i < nr_rec; i++)
> +				trace_cxl_generic_event(cxlds->dev, type,
> +							&payload->records[i]);
> +
> +			rc = cxl_clear_event_record(cxlds, type, payload);
> +			if (rc) {
> +				dev_err(cxlds->dev, "Event log '%d': Failed to clear events : %d",
> +					type, rc);

This and the other dev_err() above should be dev_err_ratelimited() because if
these ever fire they'll probably start firing in bunches.

> +				goto unlock_buffer;

Nit, but how about just "break;" here? No need for a label.

> +			}
> +		}
> +
> +		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> +			trace_cxl_overflow(cxlds->dev, type, payload);

I'm worried about this potentially looping and causing softlockups
without a cond_resched(), but lets wait and see if more complexity is
needed.

> +	} while (nr_rec);
> +
> +unlock_buffer:
> +	mutex_unlock(&cxlds->event.log_lock);
> +}
> +
> +/**
> + * cxl_mem_get_event_records - Get Event Records from the device
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve all event records available on the device, report them as trace
> + * events, and clear them.
> + *
> + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> + * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> + */
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
> +{
> +	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> +
> +	if (status & CXLDEV_EVENT_STATUS_FATAL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> +	if (status & CXLDEV_EVENT_STATUS_FAIL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> +	if (status & CXLDEV_EVENT_STATUS_WARN)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +	if (status & CXLDEV_EVENT_STATUS_INFO)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> @@ -868,6 +1005,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
> +	mutex_init(&cxlds->event.log_lock);
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 20ca2fe2ca8e..24eef6909f13 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -6,7 +6,9 @@
>  #if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _CXL_EVENTS_H
>  
> +#include <asm-generic/unaligned.h>
>  #include <cxl.h>
> +#include <cxlmem.h>
>  #include <linux/tracepoint.h>
>  
>  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
> @@ -103,6 +105,124 @@ TRACE_EVENT(cxl_aer_correctable_error,
>  	)
>  );
>  
> +#include <linux/tracepoint.h>
> +
> +#define cxl_event_log_type_str(type)				\
> +	__print_symbolic(type,					\
> +		{ CXL_EVENT_TYPE_INFO, "Informational" },	\
> +		{ CXL_EVENT_TYPE_WARN, "Warning" },		\
> +		{ CXL_EVENT_TYPE_FAIL, "Failure" },		\
> +		{ CXL_EVENT_TYPE_FATAL, "Fatal" })
> +
> +TRACE_EVENT(cxl_overflow,
> +
> +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> +		 struct cxl_get_event_payload *payload),
> +
> +	TP_ARGS(dev, log, payload),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(int, log)
> +		__field(u64, first_ts)
> +		__field(u64, last_ts)
> +		__field(u16, count)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->log = log;
> +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> +		__entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
> +		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
> +	),
> +
> +	TP_printk("%s: EVENT LOG OVERFLOW log=%s : %u records from %llu to %llu",

The tracepoint is already called "cxl_overflow", seems redundant to also
print "EVENT LOG OVERFLOW".

> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
> +		__entry->count, __entry->first_ts, __entry->last_ts)
> +
> +);
> +
> +/*
> + * Common Event Record Format
> + * CXL 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
> +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
> +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
> +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> +#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
> +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \

Nit, I know this does not matter for parsing since tooling will use the
raw TP_STRUCT__entry fields, but why are these "CAPITAL_UNDERSCORE" and
other symbols are just "Capitalized term"?

> +)
> +
> +/*
> + * Define macros for the common header of each CXL event.
> + *
> + * Tracepoints using these macros must do 3 things:
> + *
> + *	1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
> + *	2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
> + *	   pass the dev, log, and CXL event header
> + *	3) Use CXL_EVT_TP_printk() instead of TP_printk()
> + *
> + * See the generic_event tracepoint as an example.
> + */
> +#define CXL_EVT_TP_entry					\
> +	__string(dev_name, dev_name(dev))			\
> +	__field(int, log)					\
> +	__field_struct(uuid_t, hdr_uuid)			\
> +	__field(u32, hdr_flags)					\
> +	__field(u16, hdr_handle)				\
> +	__field(u16, hdr_related_handle)			\
> +	__field(u64, hdr_timestamp)				\
> +	__field(u8, hdr_length)					\
> +	__field(u8, hdr_maint_op_class)
> +
> +#define CXL_EVT_TP_fast_assign(dev, l, hdr)					\
> +	__assign_str(dev_name, dev_name(dev));					\
> +	__entry->log = (l);							\
> +	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> +	__entry->hdr_length = (hdr).length;					\
> +	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> +	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> +	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> +	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> +	__entry->hdr_maint_op_class = (hdr).maint_op_class
> +
> +#define CXL_EVT_TP_printk(fmt, ...) \
> +	TP_printk("%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "		\
> +		"handle=%x related_handle=%x maint_op_class=%u"			\
> +		" : " fmt,							\
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
> +		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> +		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
> +		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> +		##__VA_ARGS__)
> +
> +TRACE_EVENT(cxl_generic_event,
> +
> +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> +		 struct cxl_event_record_raw *rec),
> +
> +	TP_ARGS(dev, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
> +		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
> +	),
> +
> +	CXL_EVT_TP_printk("%s",
> +		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> +);
> +
>  #endif /* _CXL_EVENTS_H */
>  
>  #define TRACE_INCLUDE_FILE trace
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index aa3af3bb73b2..5974d1082210 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -156,6 +156,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
>  #define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
>  
> +/* CXL 3.0 8.2.8.3.1 Event Status Register */
> +#define CXLDEV_DEV_EVENT_STATUS_OFFSET		0x00
> +#define CXLDEV_EVENT_STATUS_INFO		BIT(0)
> +#define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> +#define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> +#define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +
> +#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
> +				 CXLDEV_EVENT_STATUS_WARN |	\
> +				 CXLDEV_EVENT_STATUS_FAIL |	\
> +				 CXLDEV_EVENT_STATUS_FATAL)
> +
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..dd9aa3dd738e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -4,6 +4,7 @@
>  #define __CXL_MEM_H__
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
> +#include <linux/uuid.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -193,6 +194,17 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> +/**
> + * struct cxl_event_state - Event log driver state
> + *
> + * @event_buf: Buffer to receive event data
> + * @event_log_lock: Serialize event_buf and log use
> + */
> +struct cxl_event_state {
> +	struct cxl_get_event_payload *buf;
> +	struct mutex log_lock;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -266,12 +278,16 @@ struct cxl_dev_state {
>  
>  	struct xarray doe_mbs;
>  
> +	struct cxl_event_state event;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> +	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -347,6 +363,73 @@ struct cxl_mbox_identify {
>  	u8 qos_telemetry_caps;
>  } __packed;
>  
> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +struct cxl_event_record_hdr {
> +	uuid_t id;
> +	u8 length;
> +	u8 flags[3];
> +	__le16 handle;
> +	__le16 related_handle;
> +	__le64 timestamp;
> +	u8 maint_op_class;
> +	u8 reserved[15];
> +} __packed;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {
> +	struct cxl_event_record_hdr hdr;
> +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} __packed;
> +
> +/*
> + * Get Event Records output payload
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS		BIT(1)
> +struct cxl_get_event_payload {
> +	u8 flags;
> +	u8 reserved1;
> +	__le16 overflow_err_count;
> +	__le64 first_overflow_timestamp;
> +	__le64 last_overflow_timestamp;
> +	__le16 record_count;
> +	u8 reserved2[10];
> +	struct cxl_event_record_raw records[];
> +} __packed;
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> + */
> +enum cxl_event_log_type {
> +	CXL_EVENT_TYPE_INFO = 0x00,
> +	CXL_EVENT_TYPE_WARN,
> +	CXL_EVENT_TYPE_FAIL,
> +	CXL_EVENT_TYPE_FATAL,
> +	CXL_EVENT_TYPE_MAX
> +};
> +
> +/*
> + * Clear Event Records input payload
> + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> + */
> +#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
> +struct cxl_mbox_clear_event_payload {
> +	u8 event_log;		/* enum cxl_event_log_type */
> +	u8 clear_flags;
> +	u8 nr_recs;
> +	u8 reserved[3];
> +	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
> +} __packed;
> +#define CXL_CLEAR_EVENT_LIMIT_HANDLES(payload_size)			\
> +	(((payload_size) -						\
> +		(sizeof(struct cxl_mbox_clear_event_payload) -		\
> +		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\
> +		sizeof(__le16))
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> @@ -441,6 +524,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3a66aadb4df0..86c84611a168 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -417,8 +417,44 @@ static void disable_aer(void *pdev)
>  	pci_disable_pcie_error_reporting(pdev);
>  }
>  
> +static void cxl_mem_free_event_buffer(void *buf)
> +{
> +	kvfree(buf);
> +}
> +
> +/*
> + * There is a single buffer for reading event logs from the mailbox.  All logs
> + * share this buffer protected by the cxlds->event_log_lock.
> + */
> +static void cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_get_event_payload *buf;
> +
> +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> +		cxlds->payload_size);
> +
> +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (WARN_ON_ONCE(!buf))

No, why is event init so special that it behaves differently than all
the other init-time allocations this driver does?

> +		return;

return -ENOMEM;

> +
> +	if (WARN_ON_ONCE(devm_add_action_or_reset(cxlds->dev,
> +			 cxl_mem_free_event_buffer, buf)))
> +		return;

ditto.

> +
> +	cxlds->event.buf = buf;
> +}
> +
> +static void cxl_clear_event_logs(struct cxl_dev_state *cxlds)
> +{
> +	/* Force read and clear of all logs */
> +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +	/* Ensure prior partial reads are handled, by starting over again */

What partial reads? cxl_mem_get_event_records() reads every log until
each returns an empty result. Any remaining events after this returns
are events that fired during the retrieval.

So I do not think cxl_clear_event_logs() needs to exist, just call
cxl_mem_get_event_records(CXLDEV_EVENT_STATUS_ALL) once and that's it.


> +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dev_state *cxlds;
> @@ -494,6 +530,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	if (host_bridge->native_cxl_error) {

Probably deserves a small comment about why this flag matters for event
init. Something like: "When BIOS maintains CXL error reporting control,
it will also reap event records. Only one agent can interface with the
event mechanism."

> +		cxl_mem_alloc_event_buf(cxlds);
> +		if (cxlds->event.buf)

No need for this conditional here since this whole block is skipped if
!native_cxl_error and cxl_mem_alloc_event_buf() will fail driver load if
it fails to init.

> +			cxl_clear_event_logs(cxlds);
> +	}
> +
>  	if (cxlds->regs.ras) {
>  		pci_enable_pcie_error_reporting(pdev);
>  		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1f81807492ef..7fe3752a204e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -580,6 +580,7 @@ struct pci_host_bridge {
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> +	unsigned int	native_cxl_error:1;	/* OS CXL Error reporting */

I would group this with the other native_ flags and copy the comment
style "OS may use CXL RAS + Events", or somesuch.
