Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32305648AE7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 23:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLIWuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 17:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLIWt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 17:49:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F398B855;
        Fri,  9 Dec 2022 14:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670626118; x=1702162118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jCLE6I4e5kmMyJwQsb8Jelq7Qec1Y/xAL9httNKyvog=;
  b=L5afFS4M5+jx3dr/IOeM/LpFdEq1ntbZUkCcdtmQT/j9vLbuB+jY3ntG
   6mAXCw/O9ITCq3XgK3CbGeijj32j9W0LR3r7Pbg1GowIvIO6lElvrqtqc
   ktRQGBCDt1f9ytIZL4XMgfo9MtKzMXXHLLa2k6hzkwZVTmi6NuHQibvAs
   Bsn332YomJmUuSVAvmousaunRcf0vhDSuAU4l4G6CjnxLpc6ACt6eO/Td
   CPkTFOAZpCzTZS4PJXA6UPBw5DiXQr3gyNSuMESrWN887Vav3j8TCz3ri
   9EpDXgcTMDcOtAyXNJddY/aDuxkam4D73dWQ5CAHPIOfkyxMcEv/2JHAS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="316264296"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="316264296"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 14:48:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="976427346"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="976427346"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2022 14:48:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 14:48:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 14:48:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 14:48:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 14:48:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3iSYDyClBGTsXM4O7XeDQarY25YI0JYYG1a966jpuDfu/GvDBxTs33jK11dtnNEzqYWpQPv/dWu0vcSV5CZYDp7eJa3ou9Vv9FsTfVdKky8V8BOfeLSXn/1hNb0DmnoCwRejcbQpqnCTEmuQt56QjUBCE0ihDoIN4khc6IrQ+xyDG9meWspBHE0dgonwu2vDdvJLJ8WcZnB6bfl48uAcWQJQ4OWEB8z3Yt4UlDjXbzrj5OKcP21ByCRgBZCG0S1SLhOCC1BfKyi6RJZVdyjwbtKReesWVHbsfcjIFL/DwbQO5Vcww27VpcFywcbYkougzZ1Lydpr/L6HUVsVgY6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC7AjdF3jU96+Qug6RlOnJhG9oOCaQblX6/S9k4jMgU=;
 b=KEDJKkUcvBnoBzvXxwBRNHzSP70DK3OrZ4KXXaUt2sKyNcbbgbErUxmmuBMzGwfFZ29CcgJFVe6DJ8wMY51lGaBmmBJ6XYTofoX0CfCUMJlS3odb2CHLOn8QJYsdUipSYrT2pZ36ubcln7VgsutzizV2Ig8EjxcRiakH5+QSOs4J1D20cx2ydkLb3UB14hJkKtmVhO68aOMm3Id4Lu9QFD/Yg2fEzQHqiCfaw0ivKshoslHeKHh4qTdxur/4Xs9m/Fl/MisIuLvlMtEqtRNtk8rx8l5Qx1cnPjRNQKsj5wEi95oX/YBVC23SvcppCnhRlXQ/kTTfuh+hjAuDNPpqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL3PR11MB5681.namprd11.prod.outlook.com
 (2603:10b6:208:33c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 22:48:32 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 22:48:32 +0000
Date:   Fri, 9 Dec 2022 14:48:29 -0800
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
Subject: RE: [PATCH V3 6/8] cxl/test: Add generic mock events
Message-ID: <6393bb3dbe9d3_579c1294a0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-7-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221208052115.800170-7-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL3PR11MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 19389989-0314-43f2-8779-08dada377f7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61NfKTPUTSdr72oGI7aJDFahYrtdJKsUSZD4Y57Mwms7W8bKDrtSfxHA9SXbSLnrHtIfEupiBZ3zCXBcDA3EenBPGbbkrX+nLe97Zu+ltyxsvCVc/yre9exxOL26KL6wJLEXpOQyE5ehIClc7M4VMPq2GeuCuWyz9UcHZ4wFHvZtlWTQYD7VV8DPsH2cfRctqbGVWuSwsGYDaH4ea8vRYTHJFNwd53/gmU1pchPCKi59vthrH4n36H51m7vlt39b6pnGkoAUOdVUvZr/eo2vaDHYPRt5+rA/JwFk7ibSXnwjzMV8t6G8N1g8lraa6hQhXlKt8c6wppaAXR/goMNTJq0U9PzSSRuKJkrwqfoEOLAxTUdbhp8qd1dzwzyFKiY0jeNw2o9PdJdtxlWLOe93GchJ4GX/UFOzR+WbKwocQCgYilQjalGzg4nBVyVX5rZ/o6cX+TOzDDtpkW7fI4DueEyd00PD40WaSBsOyJEyO1uWVRrt5JT9B2ay96kyIRm4/0vDfZDxzK8GDtkyDydspl0hTwIbHqLtzH79LTz2okw7hwE8xCeUsb2FLnmRxWsm1YQcW8FYGP100rYP2uq64aqW5u98hpwqB7JcglmaGUpbhCD5QK4zdrDhSfawmVNaXqFKPNbvfXvPhEMslmjpGnZRQaq+LC6H5hcO8qHCYoeEXMmZMilcxKExzf9kLul/6BwodNlSbxKOpTq+WAVkkEJa8MY+n1oa8wxPkqUPnqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(30864003)(5660300002)(2906002)(41300700001)(478600001)(6512007)(186003)(9686003)(26005)(66946007)(83380400001)(66476007)(8936002)(66556008)(6862004)(8676002)(6200100001)(4326008)(316002)(54906003)(82960400001)(6486002)(6666004)(86362001)(38100700002)(6506007)(41533002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Enp/e8kyF195Q4NMLfaYuJu3xKsHBGNXHp6vSD4ycDg1D1y6zPz14H+UiNxA?=
 =?us-ascii?Q?ueU0vu+GNvnftKoXBZtlJ1JkFeh63Z92CCM9dPtz0qez/W/t2kGxAWuDyQ3/?=
 =?us-ascii?Q?wOKidu3JlaxiiUVJqLQl+t59LfHqBlz6x8eMTA0gH4d/1UkUUrbdxvW4v0sR?=
 =?us-ascii?Q?QHdR80PY11NhGD9qJxZdw9fg1NlQC95mfQ+jYfq7yAWWqGVxu6C1PzoJikt/?=
 =?us-ascii?Q?Eus3Ej5gtTTMv9H6BXnmnX7Z9ZTc2voSVsn9f9v60CaHIVdvCd2hIClZ9Zzj?=
 =?us-ascii?Q?m8ja2MUiKWmrCbMG65XaentRiqLPDcmznuRvooV86eVTIpswMmG+2E/gB/kz?=
 =?us-ascii?Q?fkAUJd/aTWxKZtv2IlST/H9CZbAzk6FjbUjk09ZKYF+QkbG5DoCsBWpgJlRG?=
 =?us-ascii?Q?9a54va+zc8JE+YkoGLsXgFIsGEDgopOnDgO9V4JlXmJt1HG2UvuzUGte6L3D?=
 =?us-ascii?Q?1xL9efI9Ob7Wm7feL02iHMNBRSnOBR5Y2xAAGiOj63SNkwjZiL2LtCkIZgtM?=
 =?us-ascii?Q?94iF/9/IfWaCXhuM5NrCghQkHlvFqETTLjDSF3HIF5lgw89T0E1XD91HKEkf?=
 =?us-ascii?Q?9WBgHIFb2J43UtU0kQNu7WGw5jMoym/iFVo6sM4tfgEfR7F7sotPnw2/6rfq?=
 =?us-ascii?Q?AGEL7+9D2FX1263oSV9abvdvrUcsu5MdTkBnFhCGURUJLF2PPnfFK0hTMnh5?=
 =?us-ascii?Q?ScTfvr2p/gqU9T4ZnM+2txF98AiUNWzNkd6Fyudsqx3xTACYIAo/LBNeNd7t?=
 =?us-ascii?Q?oYJoGlMY3dLSI7fMjZP64vrkLiP5cAxmo0mHlre/zHtSy5XLDquZHv846JRi?=
 =?us-ascii?Q?OQj/ZUrnwkviKqdAwjr32HD1hZ8/BtQHUne96bXTRRGH8M0D5RalK34EkMNV?=
 =?us-ascii?Q?Mc4Ph9jGxVA7501kYdILSIF2tu5jnm1uLG9qoROn6Hla1MZN+ks19OZxQxwG?=
 =?us-ascii?Q?Xb16nvvjGJ0d3xb86FrSYsgRUFSzFe0pFPSQLEB2PclMYnb50G5LLrE49mJG?=
 =?us-ascii?Q?46skVnp+IxiVrnQzvYLsm7ZkpApsiQvylA7CPGqQ/QKkG1TBU0uxrTXo/qEu?=
 =?us-ascii?Q?jK3lo3TC9vVOXfz7MPsXR05WPxvVTrV8ZNNo3EJ2/Ztd695qSGxS5qZXQ2jH?=
 =?us-ascii?Q?ESrpPShC8JfCY5z1kMTN1o+g+ywON29jCy5gthBa3m2kj3MjuDV7RS3GpEm5?=
 =?us-ascii?Q?zKBOZbYbMzbMg9UivjJUVNJBbK3ZN5fNfuBd2hfwliWgEerWTkantz38cI6a?=
 =?us-ascii?Q?8WCyzF41ioOPgf0tg+NMOsk4ynM52sim7aNlvGabbrRuYvBECoEuy4OinWIC?=
 =?us-ascii?Q?c5ouIQD4LViyYkyZvCWUa4vWC9XeKCp50BWuoRE5tsQ6aKQ5ZC3D2BzP35MH?=
 =?us-ascii?Q?FbkXZgnWVm4RqSh7mbzMe7VI+oM7fqw08+NWJ9R9uAdJ/7iHl5iyyB67aNCZ?=
 =?us-ascii?Q?ZZNEiUyuis9dOcGhZGBCe/XdTm5Mguv0Yl6iTlP7JEYHsVWUuwc16ZJZzLsa?=
 =?us-ascii?Q?zrIOqHmoqd1iGmzFkJJ323At2EAeefVClwf1lOVkuRTXyAQ2ExTiGqfmmjxT?=
 =?us-ascii?Q?9dzL18XoCb94EjhZHqERKTt+4eOo/ggNOHH5jrRyHT5CMU8Mvx1Ra7NQJyG/?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19389989-0314-43f2-8779-08dada377f7f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:48:32.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEmqiflpiXPJxRHKfMSZ7W/DtbqlILWLrH41lr6H4Pofx4/StQctskJ1gOI9ZZ1patGXA7+OZ8AHx/GyVjj8tEWGBy1ecwL/KDZJF/XZSN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5681
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
> Facilitate testing basic Get/Clear Event functionality by creating
> multiple logs and generic events with made up UUID's.
> 
> Data is completely made up with data patterns which should be easy to
> spot in trace output.
> 
> A single sysfs entry resets the event data and triggers collecting the
> events for testing.
> 
> Test traces are easy to obtain with a small script such as this:
> 
> 	#!/bin/bash -x
> 
> 	devices=`find /sys/devices/platform -name cxl_mem*`
> 
> 	# Turn on tracing
> 	echo "" > /sys/kernel/tracing/trace
> 	echo 1 > /sys/kernel/tracing/events/cxl/enable
> 	echo 1 > /sys/kernel/tracing/tracing_on
> 
> 	# Generate fake interrupt
> 	for device in $devices; do
> 	        echo 1 > $device/event_trigger
> 	done
> 
> 	# Turn off tracing and report events
> 	echo 0 > /sys/kernel/tracing/tracing_on
> 	cat /sys/kernel/tracing/trace
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v2:
> 	Adjust for tracing being part of cxl core
> 	Dan/Dave J.
> 		Adjust to Dave J.s mock data structure
> 	Dan
> 		Remove mock specific functionality in main code
> 
> Changes from v1:
> 	Fix up for new structures
> 	Jonathan
> 		Update based on specification discussion
> 
> Changes from RFC v2:
> 	Adjust to simulate the event status register
> 
> Changes from RFC:
> 	Separate out the event code
> 	Adjust for struct changes.
> 	Clean up devm_cxl_mock_event_logs()
> 	Clean up naming and comments
> 	Jonathan
> 		Remove dynamic allocation of event logs
> 		Clean up comment
> 		Remove unneeded xarray
> 		Ensure event_trigger sysfs is valid prior to the driver
> 		going active.
> 	Dan
> 		Remove the fill/reset event sysfs as these operations
> 		can be done together
> ---
>  tools/testing/cxl/test/Kbuild   |   4 +-
>  tools/testing/cxl/test/events.c | 195 ++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/events.h |  32 ++++++
>  tools/testing/cxl/test/mem.c    |  33 ++++--
>  tools/testing/cxl/test/mock.h   |  12 ++
>  5 files changed, 264 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/cxl/test/events.c
>  create mode 100644 tools/testing/cxl/test/events.h
> 
> diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
> index 4e59e2c911f6..c48d912e3781 100644
> --- a/tools/testing/cxl/test/Kbuild
> +++ b/tools/testing/cxl/test/Kbuild
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ccflags-y := -I$(srctree)/drivers/cxl/
> +ccflags-y := -I$(srctree)/drivers/cxl/ -I$(srctree)/drivers/cxl/core
>  
>  obj-m += cxl_test.o
>  obj-m += cxl_mock.o
> @@ -7,4 +7,4 @@ obj-m += cxl_mock_mem.o
>  
>  cxl_test-y := cxl.o
>  cxl_mock-y := mock.o
> -cxl_mock_mem-y := mem.o
> +cxl_mock_mem-y := mem.o events.o
> diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> new file mode 100644
> index 000000000000..1346c38dce1d
> --- /dev/null
> +++ b/tools/testing/cxl/test/events.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2022 Intel Corporation. All rights reserved.
> +
> +#include "mock.h"
> +#include "events.h"
> +#include "trace.h"
> +
> +struct mock_event_log *find_event_log(struct device *dev, int log_type)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return NULL;
> +	return &mdata->mes.mock_logs[log_type];
> +}
> +
> +struct cxl_event_record_raw *get_cur_event(struct mock_event_log *log)
> +{
> +	return log->events[log->cur_idx];
> +}
> +
> +void reset_event_log(struct mock_event_log *log)
> +{
> +	log->cur_idx = 0;
> +	log->clear_idx = 0;
> +}
> +
> +/* Handle can never be 0 use 1 based indexing for handle */
> +u16 get_clear_handle(struct mock_event_log *log)
> +{
> +	return log->clear_idx + 1;
> +}
> +
> +/* Handle can never be 0 use 1 based indexing for handle */
> +__le16 get_cur_event_handle(struct mock_event_log *log)
> +{
> +	u16 cur_handle = log->cur_idx + 1;
> +
> +	return cpu_to_le16(cur_handle);
> +}
> +
> +static bool log_empty(struct mock_event_log *log)
> +{
> +	return log->cur_idx == log->nr_events;
> +}
> +
> +static void event_store_add_event(struct mock_event_store *mes,
> +				  enum cxl_event_log_type log_type,
> +				  struct cxl_event_record_raw *event)
> +{
> +	struct mock_event_log *log;
> +
> +	if (WARN_ON(log_type >= CXL_EVENT_TYPE_MAX))
> +		return;
> +
> +	log = &mes->mock_logs[log_type];
> +	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
> +		return;
> +
> +	log->events[log->nr_events] = event;
> +	log->nr_events++;
> +}
> +
> +int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_get_event_payload *pl;
> +	struct mock_event_log *log;
> +	u8 log_type;
> +	int i;
> +
> +	if (cmd->size_in != sizeof(log_type))
> +		return -EINVAL;
> +
> +	if (cmd->size_out < struct_size(pl, records, CXL_TEST_EVENT_CNT))
> +		return -EINVAL;
> +
> +	log_type = *((u8 *)cmd->payload_in);
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	memset(cmd->payload_out, 0, cmd->size_out);
> +
> +	log = find_event_log(cxlds->dev, log_type);
> +	if (!log || log_empty(log))
> +		return 0;
> +
> +	pl = cmd->payload_out;
> +
> +	for (i = 0; i < CXL_TEST_EVENT_CNT && !log_empty(log); i++) {
> +		memcpy(&pl->records[i], get_cur_event(log), sizeof(pl->records[i]));
> +		pl->records[i].hdr.handle = get_cur_event_handle(log);
> +		log->cur_idx++;
> +	}
> +
> +	pl->record_count = cpu_to_le16(i);
> +	if (!log_empty(log))
> +		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mock_get_event);

I believe I asked this before on the last review. Why is this exported?
The caller is within the same module.

I also notice now that the event support code is even smaller than the
security code that is already in that file, just go ahead and move this
infrastructure in there as well. Then this does not need to move the
cxl_mockmem_data definition around or create other new headers.

Other than that minor detail the implementation looks good. I appreciate
the effort to get cxl_test to light up this interface!

After consolidating in mem.c you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> +
> +int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> +	struct mock_event_log *log;
> +	u8 log_type = pl->event_log;
> +	u16 handle;
> +	int nr;
> +
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	log = find_event_log(cxlds->dev, log_type);
> +	if (!log)
> +		return 0; /* No mock data in this log */
> +
> +	/*
> +	 * This check is technically not invalid per the specification AFAICS.
> +	 * (The host could 'guess' handles and clear them in order).
> +	 * However, this is not good behavior for the host so test it.
> +	 */
> +	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
> +		dev_err(cxlds->dev,
> +			"Attempting to clear more events than returned!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Check handle order prior to clearing events */
> +	for (nr = 0, handle = get_clear_handle(log);
> +	     nr < pl->nr_recs;
> +	     nr++, handle++) {
> +		if (handle != le16_to_cpu(pl->handle[nr])) {
> +			dev_err(cxlds->dev, "Clearing events out of order\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Clear events */
> +	log->clear_idx += pl->nr_recs;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mock_clear_event);
> +
> +void cxl_mock_event_trigger(struct device *dev)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	struct mock_event_store *mes = &mdata->mes;
> +	int i;
> +
> +	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
> +		struct mock_event_log *log;
> +
> +		log = find_event_log(dev, i);
> +		if (log)
> +			reset_event_log(log);
> +	}
> +
> +	cxl_mem_get_event_records(mes->cxlds, mes->ev_status);
> +}
> +EXPORT_SYMBOL_GPL(cxl_mock_event_trigger);
> +
> +struct cxl_event_record_raw maint_needed = {
> +	.hdr = {
> +		.id = UUID_INIT(0xBA5EBA11, 0xABCD, 0xEFEB,
> +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +		.length = sizeof(struct cxl_event_record_raw),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0xa5b6),
> +	},
> +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +struct cxl_event_record_raw hardware_replace = {
> +	.hdr = {
> +		.id = UUID_INIT(0xABCDEFEB, 0xBA11, 0xBA5E,
> +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +		.length = sizeof(struct cxl_event_record_raw),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0xb6a5),
> +	},
> +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +void cxl_mock_add_event_logs(struct mock_event_store *mes)
> +{
> +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
> +
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
> +}
> +EXPORT_SYMBOL_GPL(cxl_mock_add_event_logs);
> diff --git a/tools/testing/cxl/test/events.h b/tools/testing/cxl/test/events.h
> new file mode 100644
> index 000000000000..626cd79f1871
> --- /dev/null
> +++ b/tools/testing/cxl/test/events.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef CXL_TEST_EVENTS_H
> +#define CXL_TEST_EVENTS_H
> +
> +#include <cxlmem.h>
> +
> +#define CXL_TEST_EVENT_CNT_MAX 15
> +
> +/* Set a number of events to return at a time for simulation.  */
> +#define CXL_TEST_EVENT_CNT 3
> +
> +struct mock_event_log {
> +	u16 clear_idx;
> +	u16 cur_idx;
> +	u16 nr_events;
> +	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> +};
> +
> +struct mock_event_store {
> +	struct cxl_dev_state *cxlds;
> +	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
> +	u32 ev_status;
> +};
> +
> +int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> +int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> +void cxl_mock_add_event_logs(struct mock_event_store *mes);
> +void cxl_mock_remove_event_logs(struct device *dev);
> +void cxl_mock_event_trigger(struct device *dev);
> +
> +#endif /* CXL_TEST_EVENTS_H */
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 5e4ecd93f1d2..7674d6305d28 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -8,6 +8,7 @@
>  #include <linux/sizes.h>
>  #include <linux/bits.h>
>  #include <cxlmem.h>
> +#include "mock.h"
>  
>  #define LSA_SIZE SZ_128K
>  #define DEV_SIZE SZ_2G
> @@ -67,16 +68,6 @@ static struct {
>  
>  #define PASS_TRY_LIMIT 3
>  
> -struct cxl_mockmem_data {
> -	void *lsa;
> -	u32 security_state;
> -	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
> -	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
> -	int user_limit;
> -	int master_limit;
> -
> -};
> -
>  static int mock_gsl(struct cxl_mbox_cmd *cmd)
>  {
>  	if (cmd->size_out < sizeof(mock_gsl_payload))
> @@ -582,6 +573,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_GET_PARTITION_INFO:
>  		rc = mock_partition_info(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_GET_EVENT_RECORD:
> +		rc = mock_get_event(cxlds, cmd);
> +		break;
> +	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
> +		rc = mock_clear_event(cxlds, cmd);
> +		break;
>  	case CXL_MBOX_OP_SET_LSA:
>  		rc = mock_set_lsa(cxlds, cmd);
>  		break;
> @@ -628,6 +625,15 @@ static bool is_rcd(struct platform_device *pdev)
>  	return !!id->driver_data;
>  }
>  
> +static ssize_t event_trigger_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	cxl_mock_event_trigger(dev);
> +	return count;
> +}
> +static DEVICE_ATTR_WO(event_trigger);
> +
>  static int cxl_mock_mem_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -655,6 +661,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	cxlds->serial = pdev->id;
>  	cxlds->mbox_send = cxl_mock_mbox_send;
>  	cxlds->payload_size = SZ_4K;
> +	cxlds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>  	if (is_rcd(pdev)) {
>  		cxlds->rcd = true;
>  		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
> @@ -672,10 +679,15 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	mdata->mes.cxlds = cxlds;
> +	cxl_mock_add_event_logs(&mdata->mes);
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +
>  	return 0;
>  }
>  
> @@ -714,6 +726,7 @@ static DEVICE_ATTR_RW(security_lock);
>  
>  static struct attribute *cxl_mock_mem_attrs[] = {
>  	&dev_attr_security_lock.attr,
> +	&dev_attr_event_trigger.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(cxl_mock_mem);
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index ef33f159375e..e7827ddedb06 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -3,6 +3,18 @@
>  #include <linux/list.h>
>  #include <linux/acpi.h>
>  #include <cxl.h>
> +#include "events.h"
> +
> +struct cxl_mockmem_data {
> +	void *lsa;
> +	u32 security_state;
> +	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
> +	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
> +	int user_limit;
> +	int master_limit;
> +	struct mock_event_store mes;
> +	u8 event_buf[SZ_4K];
> +};

Related to the above this does not belong here. test/mock.h is dedicated
to supporting the symbols that are rerouted between the CXL modules,
cxl_mock, and cxl_test.
