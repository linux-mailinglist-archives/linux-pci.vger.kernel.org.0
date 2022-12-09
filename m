Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C85648AA7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 23:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLIWQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 17:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiLIWP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 17:15:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286606F4A4;
        Fri,  9 Dec 2022 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670624155; x=1702160155;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3PGIeSNgx8KgE6Iv2HBxDvTAI7Cf6fYSiIECm0kVK3M=;
  b=goJpJw/32qq8vRLR6NE6Y48lHlIEJmAy9+3eogngSzQyYcyjFXDwjD+0
   YilSMkKx4ZQEAcV6hZf2CMlGXgXW+bVbTpq6LSyR8vumCp6GHnCZVPcyZ
   u6gvFqfA4rTA/JSpZvOBhtYxUYzRL3EFvs6FvxGcDoVbZ1q53LfYwUess
   lRSCYm4fdniHQpLuD5Lchy1E759PZ48UaT1IkG7Wew9h+8T/Y6CeED6Qb
   TC0N+iqVHlpI4zWTlFLYUVtvdZSGo+H3ErHR3lxc0o0LPhntdKxznCQmi
   I7n1FsxATVW9bvfj72/DHxdF1SV0SwyTYTjBJFByq4EM3DLEmNiDL4YKC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="315195546"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="315195546"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 14:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="711039417"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="711039417"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2022 14:14:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 14:14:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 14:14:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 14:14:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+/BCtghHZ3nL5UWE9HHVPJkFid5dwS1W9CAuPUiBzMm/RY4cMJlb4QJGW/1U5qKHocI43DcLHDwBY/X3ZTzqenDkZUNN723jto9Y1h7xdEMetTWkDWHNiqxxhSBfYvczGDzNC54tCo5AC2JTQ+NBhbstsCDtRJDZwMLrfgWCUlpD1V9wu+6d4RzUpygPmKfjRq5nOJxDyU6t/W+omep8dP+Of5Nw23RNmUGHTmLmGiUY6CJhh3Uw4Ed65SzquCCfru/ueuV+HHbPHL5Z26Ozuh1AJUOP3q3TMmW9jaTtmynwaMl+7E4GwYR7SKCfHtKhYLwBCVeixaUST9pVDEW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGPjLIHkkvONyb8q0zTlj1VucLh3cHgM/yXek53ey1I=;
 b=BAaN+cpLF/86yf5oKGNf8CwirodlD+9ITrwGvmkJKwbBPsi4MMj50O91MYedHOnplV3VoH+nD8DzY2+sY+e2be0+8mi8Att6LrWwaFc4XrlkhFsx+CC+JhB1cLRMf4VFIC/IYgsIJdx2r28qeR8y5693kg0d7ICV6LvRrZUkKM0bDCsOrWVo4+iL6JrWqjYaknW7+c6BAAWmycuMbzcsZj3Edh1tWwexxesZSzDvvTWTfof/WkiFQYTv6m12+NVcy7JmSB9E92euDhqNcrBKYv886PCTn2cO5NRJOKPWxabT5hMPTpCc0Vxa4eEr/U/HmWMPVNjYWnadgJQK/WsP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4551.namprd11.prod.outlook.com
 (2603:10b6:208:269::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 22:14:45 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 22:14:44 +0000
Date:   Fri, 9 Dec 2022 14:14:41 -0800
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
Subject: RE: [PATCH V3 4/8] cxl/mem: Trace DRAM Event Record
Message-ID: <6393b35111f0_579c12947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-5-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221208052115.800170-5-ira.weiny@intel.com>
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN2PR11MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: a911bda3-e5e5-4bb8-6bf2-08dada32c60a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olHheQDY9bcKoh/AcqAqWTVbA/xZzpcyrk21TH3P8vhmWvX0/NHw6I6BpHwZhFuzc33pXoqNm9fFPL1bXmOvM2x7aar0lfmdp77pX/9iqOj18A3Nd8Li3a1kDqdL1McoZ6BnB7Mzn2HiQGYYwOudVnkds4A4QW1V8Tzl+oUw/8W8ShfzOXFE8bs6DV8uP0leEaxEtOGXcbr79KQutOpbPrBwdF6yB1C23H0vfQmAJ+AMNYe+ptODNghrm5nQK3ES+ISgqaIgtR2tPSP8mw4SHIV0pqojuo6H6X1w6KB9TlT/Je2Dso7zePABogAeTo3gNo+nQ/PkMySyA4dPcfYRL+H6DzFo7cFEoNe1yrkYoTe08z+cjQ5iZXK1xlQFan4+2r5Zfxu0iDYldY0dWQKmb95NQ0nybRiuPkcXLEukRCyZltUQrXJRVaDEaSoeSyYYCG3tZsP5X56eFkPNYFRbY4kkW7Lys1joWUqNykSrlfNOvBLsyJXZlmt2nh0T8VCA19HGfl5S2eGDNwQzPmld7yn3v3L67VQPxfmZU3QyAl4ubD9+sHAwA8JfdSZWQUhS18z6UX0S1Q/rIfJ86qAtCAD0+WaqIjB9RoJOJK896SyzGl8Id3Ek9vT/rJiK0TeG1FNemahYOtLTxcrYQZ5R9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(2906002)(6200100001)(6862004)(8936002)(316002)(54906003)(66476007)(8676002)(5660300002)(4326008)(41300700001)(66556008)(66946007)(6512007)(186003)(478600001)(26005)(9686003)(6486002)(86362001)(38100700002)(83380400001)(82960400001)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rlI4kyMlzjhf/D8mGCb2VwC67GDgWzdH8t6PDrH88DVEmm6PMDA3Lajfb6c9?=
 =?us-ascii?Q?0/ukVF2UCzdYO6f64U92DsLnerkoXLqUNKuqCxUZ9re7KflvEoMkb2vSMH2j?=
 =?us-ascii?Q?wJLyw32HUt4ClywSUYKx6Ei4gQNcJaUaEdw+Y0ROgoB/V720gJDL2Q+wCKUw?=
 =?us-ascii?Q?Vrl8NsmoghCc55MhzmoFTp1AIglYrp+Hl3tpmtp74qJPEoJhI+J1jFfqIz18?=
 =?us-ascii?Q?7BmtvpP5Kr3FSDfJg3W7naqnQgR0IyimePDR7erm0FJcDOBEshkeBww0klLK?=
 =?us-ascii?Q?hWlsTr/vhXPI8laKq5AdZdyhjGlaBcFd+u7VGHULt0+7sE2iIP06zhKyBuZK?=
 =?us-ascii?Q?tsUdtHnX7JAQiL1ud1new3SzIpeSbu83DpJgrWhl4E3SqNyu0qQVOU8CQF3I?=
 =?us-ascii?Q?W78z8v3YuQOdaavWK1KE9Sv7bNkUjSkuz50aS6YPt9HFIAA5OFKqewgFxTD3?=
 =?us-ascii?Q?TOhRgI5hnqpMbOch2konrtEkcpF4yte96fDEqq0jBXaJMoV6xV8GhYGFvFB3?=
 =?us-ascii?Q?UooYFuTBuY5Lpm3DwBjVucwtsGlQsZrmnZAGYR904yvRUlYTvo6EjZs9taWE?=
 =?us-ascii?Q?HeHmI3WZQcmpPMD/Nh9H2Hw4esRXkJjRT0A2LrcnsAQvRZtyth2m9WqcSI8t?=
 =?us-ascii?Q?ba79qh6M2TmZuEfCqPHdU2RVkOfdEhIVubWOHX7SX3q7uXgkozZHJKsPAA73?=
 =?us-ascii?Q?1Fh5sGJyDE0eiH3YZcfj725zxVOmB+YRnSCdyn1FLgTQiCrLJp7igFxTIiAR?=
 =?us-ascii?Q?HKZ6cVCqrt2wCXAeiVSHA4YlUZ8BGiz+nSGLX+Vui5FSPzo9FIrS9qKUFcXM?=
 =?us-ascii?Q?03zXqXeBSqELXc9QpShvw3HY7soVs28MPAR52kCx9Zld2Acqs8U75kvHK1Vr?=
 =?us-ascii?Q?eGr3DGs/MJdQakAtjWSJ1MnJa8IYBe+mrWFjkBTZeDI5UXk4ZmjRSfWKOs1k?=
 =?us-ascii?Q?ym1bxJRW3fmRIhLoo9Unc9Xf1S41A90OpSMvNb3Laxr4uiFUEL88d/NwyvT5?=
 =?us-ascii?Q?bUKwEYY8shpUCQRXfNpT1nh1F0o3rcObNirg72AAFDi53F3FRYd3IXIOl4Jw?=
 =?us-ascii?Q?ToKFa1pKCnlyHAqQnpw97uha42sTeVZUYACG5ODfhu3FnjN7hhIKH5tC3KeC?=
 =?us-ascii?Q?vBPbMfiaZPMR7hhK18RzRQA2Axdgzwzc/ointmOhDtOyFuUt/v2V1gAxuG17?=
 =?us-ascii?Q?uVdooBkkzAhaJatsT56u+ulLXcRY2j1keMeSh0QBI0g/9eYHIV+YHijR04f+?=
 =?us-ascii?Q?+M//vT34Foa40Gdabp3KGARtKwVTbBTPMrFr6LxkQarInQeIcZvl7YOocHKD?=
 =?us-ascii?Q?DHPMGBN+Y69WGpmQKGf8sJkwbPp35tgL5p14Zo3EJD7fZC45t+rjVai69tBj?=
 =?us-ascii?Q?u8S9i7pGufhXHo41uSHs8M5n7+wGjr9bbC7AHOa0sarRJWc3QsR0d6/M9Ckg?=
 =?us-ascii?Q?L0C5xqtBXwm1a0E24r45aGtuXvWiEu2xDXWZrGMcf9uqCeRAX4NxOqDwT40V?=
 =?us-ascii?Q?QjXUdZzcokWTbDN7pciNivP1SgKYP+acq1P9JeDOMoEi5mEl6X1uLPUC8YHq?=
 =?us-ascii?Q?Jy6G0Ul4hC03kYN2h1e2Dx7etQLM6YCEg0OqPY7fOTvZpCA1zRxWNzWeNw5L?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a911bda3-e5e5-4bb8-6bf2-08dada32c60a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:14:43.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gHRDHYFZns+ohqB07LPCyU6mkwy1xDU8ZL6jWQGWcBnsAXbbLBNQc1PEF7ObocfYI1wBd8Q3Co08webckK5OWEF4X1jFNE0gL5t5lAF1BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> 
> Determine if the event read is a DRAM event record and if so trace the
> record.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v2:
> 	Dan
> 		Move tracing to cxl core
> 		Remove trace_*_enabled() calls
> 		Pass struct device to trace points
> 
> Changes from RFC v2:
> 	Output DPA flags as a separate field.
> 	Ensure field names match TP_print output
> 	Steven
> 		prefix TRACE_EVENT with 'cxl_'
> 	Jonathan
> 		Formatting fix
> 		Remove reserved field
> 
> Changes from RFC:
> 	Add reserved byte data
> 	Use new CXL header macros
> 	Jonathan
> 		Use get_unaligned_le{24,16}() for unaligned fields
> 		Use 'else if'
> 	Dave Jiang
> 		s/cxl_dram_event/dram
> 		s/cxl_evt_dram_rec/cxl_event_dram
> 	Adjust for new phys addr mask
> ---
>  drivers/cxl/core/mbox.c  | 13 ++++++
>  drivers/cxl/core/trace.h | 92 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h     | 23 ++++++++++
>  3 files changed, 128 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0d8c66f1cdc5..2fa4645f0ed9 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -726,6 +726,14 @@ static const uuid_t gen_media_event_uuid =
>  	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
>  		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
>  
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +static const uuid_t dram_event_uuid =
> +	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
> +
>  static void cxl_trace_event_record(const struct device *dev,
>  				   enum cxl_event_log_type type,
>  				   struct cxl_event_record_raw *record)
> @@ -738,6 +746,11 @@ static void cxl_trace_event_record(const struct device *dev,
>  
>  		trace_cxl_general_media(dev, type, rec);
>  		return;
> +	} else if (uuid_equal(id, &dram_event_uuid)) {
> +		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
> +
> +		trace_cxl_dram(dev, type, rec);
> +		return;

I think I mentioned this before, but rather than a "return" in every
branch just make the 'unknown' case the final else in this if block.

With that feel free to add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
