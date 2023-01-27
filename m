Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7967DAEB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 01:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjA0Atk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 19:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjA0Ati (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 19:49:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42593568B8;
        Thu, 26 Jan 2023 16:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674780568; x=1706316568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q6pKt0HJPDiKwxJ+60jGw0rnjGvIPDHStuCmsKYbyWw=;
  b=iqLOeZPRebvTPldNXoVF6+dVfNhjvjoRvaUxoPCxxq8UeYq3j2+S5xhv
   MRor1Jj0T+bZUPQPcZbjYkyQ7J7ABK/PJ6gj+P1nHkxf3h1xCy8phsUjo
   5QkBNhgiVrcmJUbEM6Ggk0gC02ALRL8fADtqvbEZS313ShUNQWX7bTvvS
   0kriYzxzwJsyTh9PQWroKipDJlVU/lkZM471HMhvx7bMW3YWAqftKkE4Y
   LCkXSF/5sn/TagWYHMGtyAjNNpgDrNmrJi1f7Wj2jyHMkSetWn/QySkEz
   9FjlzYF+P0+rm5rQw+Mz3dnUTMiq9H0A02a3rDXYtghlTROlwhHLdVTAM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329124762"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329124762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 16:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="751820794"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="751820794"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2023 16:49:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 16:49:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 16:49:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 16:49:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 16:49:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln+HdPbV2m8b0xlas5g7s3gnHUo4YMXOvExM4YhMy2BKXxuvM8TZKNg7gdCPAChqsCIvwb6bznqyDOr+5LAN+q06Pq9CWXvBnRNMtaybL9jTSf8ymBgO+Q0pglApnQ0JVp5+efwoxADX5okUSlf2fRICerlXP5TjPy58vQfyJX4tl2FugSXoXsfmb84lmd2DKFhMm8paCqG7aI6TwcvAPk5Yj8F4fi0qny3IBaU8wif44PflCWdHnXTNIVPfS3FlrLLtHn1WLA4GnPI4buFtdkH36ze1+GyrFXuunyhAIIrkU+zIMCDwJIh0jhxs642Qf4KDuPLFXVuYj3DPtM20Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf3DlWzXMHZ+IWXIoEbp13tQlCunAtj9hanHL4h6gBU=;
 b=e+jwTNJgWvqrizQdlgS4qTsJBCCVg+KP8I+GT9r4EXEsWmK2/V4kc3uSXEuJD5ZK5Ti/0973NoCpyrVJb+U/bWWeIMOh2bQ6ndUUi932VBgjwEaE8OCTW3ZjMoMkvd8nFz8NopkHhT6/1bkKAypOFoVnpWHIfBJpuNbs3gkcDWP0eCd9ucY5AIzdPgWQJJcFdczgUeSGH3PsnIVQAVK66nViUucAgkhDFMYMSj1ZEudPBGe37+ZI6gMYi9w0umMUSFTqzAsxNiYG7sCutWMIaUL2xX5VxHEU47vGesEHtoJw+CS09ooTUvuCZE1PQXP6OhO2BJtyZuMbM9PimHf2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 00:49:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 00:49:22 +0000
Date:   Thu, 26 Jan 2023 16:49:19 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v7 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <63d31f8fbb678_ea222294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
 <20221216-cxl-ev-log-v7-1-2316a5c8f7d8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216-cxl-ev-log-v7-1-2316a5c8f7d8@intel.com>
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: fc813a4a-4c72-445c-52fd-08db000054ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk+ZCkHdqT5TWdKbFwchP5vyYj1uTBxhIhitLcmrrksmyjQyMDTiNEs3CqnpCaGgfAUcIZ0DwZxuD4UDijeAMTjpT1lhmHyEEn3pGAnJ5qSRC+1YmeXLWWP/lbfuJkTDOGhz6iFick18iwdCt9h6bntbM5po5fYN7ODZBROA1vDz4YN6pkF2dkBN4ATnEnNJtgrotTwykVAjAib+OU7uBPZ5gtzklRru8wGUT/Uu5o90pR62VvUEEazrkijv4v/AHCaJvgnph6JFhWvHZzkqwNRO/1TkWSaSGXGU7Z7671zd7DY0tE58XjLpWw4q3zBgXq1xFEbDhU7XwQ5eID2RtJX1NUaN5q8KlAjzcAMsz5fv/4HiCUoJJummyCr7ak6cSmqS+vaz1oJ0ksRYZI6YbDbtr3gMqZGd3ILsls0L95g6zaxp8sJLv8DHbPjRj+03HAsINIgCLRbfVJELxBj17V88pkvYW4CwBTXenRIG7QsAOPVu2iVufLUJxRRl5QKm8HipayoC8PAz/pd8sPUE1+wkmPObn9QEnb+3i4xWN5O+QhSITqI6iqE+/byCql+ZR/7CtL4KvASq/NSuVQ8SDFV0RZceP/TpkBHjJriAIebdhMS5T+IH+q7ErEbfpWCdiyLUzhILrlUPRY8NmMRVSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(8676002)(54906003)(38100700002)(110136005)(83380400001)(86362001)(26005)(6512007)(9686003)(186003)(5660300002)(66946007)(6666004)(316002)(6506007)(82960400001)(6486002)(478600001)(66476007)(41300700001)(8936002)(66556008)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4DXnQnvWINoNP15tRGJ236oFRJizi/bQtSHyT+NruMjVdM0LGw0uP/4+yQGJ?=
 =?us-ascii?Q?ZQWBf+98MmfI3D4vuQ4cDCmuDCCzsMqmX7YrGaAPPBOwCtiowq4nTZTddeSd?=
 =?us-ascii?Q?piIyRRZ65z0apSA8pxBLVSpcbE1utxKK2bpG1MTP4Qznbyvt/a12xxsZXnFr?=
 =?us-ascii?Q?F+HGS2sLz097juMTCRZvHn6gUHBnBdvVqcbz/JbHlmFo1Hogqn6gPYZiMLvn?=
 =?us-ascii?Q?xNqHsYB2noA+shP/klQEUv/OPmr5/OW2+cecl9QnO1GMjMMyDUDEraST+ZCQ?=
 =?us-ascii?Q?pKMTh0bCLqTWWdnqicpHfCuLFSl5a6crNjLB/xPJgRDgpGOzfwirJG9mobjx?=
 =?us-ascii?Q?QdMs6P/lTmKyVUnFlRebslUV9DfS1Tlgh4ResnNX1KI896MbDT8NXl7M96xu?=
 =?us-ascii?Q?UD+YYgXP2K5VpNpxw0DhSZYWuCUv1L8TKmw2Jr/GuPEMtYzp+NT7SRT90q7E?=
 =?us-ascii?Q?EvPHSOA+lcuq1oChgZt7HGPCJBQdTOvmox+5UXl03pLxsjndnQGZMjhWipCa?=
 =?us-ascii?Q?bT/gBZxBNOxWnufxJR+9rrGrJ8Vehg+mDTFQYnyb4xVqoP2R9HytfTWccIx+?=
 =?us-ascii?Q?ggNiK+W6Bwd1uk4a+Yo3j4llC1vSRh3bCKrw6CF1S/mwKxDToNPAdhjLyXrK?=
 =?us-ascii?Q?JcO5088R9ZCpArRbvLCnHPvQFJ0XKzqK4Tm8+MpQvnPQRsMwyy0pzm7aOdcy?=
 =?us-ascii?Q?afoPbe39B2dCBmLyhmkMqyieZGj+x38kS+TUeErh4v069I5IZAkhfZHKEvdU?=
 =?us-ascii?Q?fLpx8hO6qNgDXmoHocvxgyDl3wvaj4eQ5N3NoRcswbnFFo7DB6uW3yi3OUQF?=
 =?us-ascii?Q?YYVj4LFo0PdOmO6ph/xFM//zZKkMvnXf8SNTqytrrt1WoyQ9RjSpcXR4EYhP?=
 =?us-ascii?Q?I3I3ssss67bWS5hF7uAa9hzW6UGrIR8Gm8+a/mxqE3j1QBzVuUIBwcMqB3nX?=
 =?us-ascii?Q?BL2eKR3XBksRMOoYfyKVSEc+wbNbbGyuHLRjD0arMhYuDVrB7q168dACoYdE?=
 =?us-ascii?Q?Wl86Ogwbf3Eu+PduGlLqbDzt/YMoDhEJS01loqSVftTVycRs7yGuw1IbUMzO?=
 =?us-ascii?Q?nHp+pBGYTES4hgh8QA4I0/4JlSSwCtIw7G9ljaVs72rYZC65E6EuPjRjNNZ5?=
 =?us-ascii?Q?E3u9khLR9C25v+rNYqu2K72bY5DtpsjE5iZHsO7jsUIKttJ8UVv2T9Y/q4bK?=
 =?us-ascii?Q?Q/arWcFMTBWy12p05zKa9fMIy14B38igwDb5PmzqOh3gX8xN0SRxije2MhxY?=
 =?us-ascii?Q?UALg5XeDzgMOlhxewSyD+xsVC8jFVVNph0X00Zb9r6Y5+YK2+KDyg9HL0qT4?=
 =?us-ascii?Q?ZNJSxAVjRetaa08SQl2lZn9S/Ab/e2d2FMyqkcTtX/u5RwFajvEZPp20CDYy?=
 =?us-ascii?Q?wlmRQtm3aNSxvHUEbV02OFQiDok0nQ/cNpOeMgiL5HvfPJOLfeRVoErfviMv?=
 =?us-ascii?Q?R9ppJeC4B/JpCkQ39FySsEHSI9b1jmAETA3/AZH4FILFXSXB/ZCI5zemBkSr?=
 =?us-ascii?Q?GyXVSWtDV67vimJrAW/K0XDz8XTGZev0uPUudzkHdtEv1fxNz+dYn69JnwzQ?=
 =?us-ascii?Q?9SOF+6E0GNiIq4mrFUS2E6dmhunZTkwfIqSm+VOjwPbCjnVxngw6c6OmZL0+?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc813a4a-4c72-445c-52fd-08db000054ad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 00:49:22.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRdTuyWepp4zc4GTQhCNoEIHgURHFMwbhkGZpYynsUywCrKwOz1F+MCsUHW598EZ+lKDtSlICY/MUTDQh47kD9gBrkmkqgKsl6rYmQIxU6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
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
> If the result of negotiating CXL Error Reporting Control is OS control,
> read and clear all event logs on driver load.
> 
> Ensure a clean slate of events by reading and clearing the events on
> driver load.
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
[..]
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 20ca2fe2ca8e..6898212fcb47 100644
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

missed this earlier, no need to include this again. Will drop it in my
local tree.
