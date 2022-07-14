Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA95575605
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 21:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiGNTzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiGNTzP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 15:55:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93879599D9;
        Thu, 14 Jul 2022 12:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657828514; x=1689364514;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iGRlzyZA3o1uqOwhiiluYWgU3+ATCYeecoqiLYyNmzo=;
  b=gn9o43gInE+KTENkws12/UGt/ezQF9avhvUJc7an/JfS+ksiBLap0733
   g94w1ZCVYBqlRxAwmu7lb4r1ztVhhPhFu+E1PcOqUoUAoIp4YwMAb+pSh
   28O8zlOXxQ/3gDnTZACwN6QgU0xWwGOwurKiHY/0YbxApenOioUY6sbai
   Zv6eS0mOD1iKDh3FlxBFVlLMrZVNwxcwF2gOuaiLGf6FPKwoXA46G9rOw
   iYJysWUn60kjaYoiRyQvdzVd6k5vNsNQfZ+I1GJUiD6Kc/jU9u19mqrmq
   xmXJ170LdvnFBmkJMsgU5Ahm9zmuHv+mXZO5UPs9MaelVaVZJPR13nm3b
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="311274517"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="311274517"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 12:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628834605"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2022 12:55:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 12:55:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 12:55:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 12:55:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 12:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE+OJiNhxr5kvzvcPsIoEZvyBQdf2QhuLNBuRxAth1qot4d5vMrPMbAIkvcZz5T17C01TEj7xNf6VK3rH9lze3hc8BM4DUyyhcGrek8lzIKfrQjVrGXanmME4bKaHu01wEo2VzNUnAGm1QvdrjCpbdNRZCFNzB96cso+E25SAkfPIBOESj+iahDEG2hNq+xK5YlR7xHiTffOJku72OQsJwlZ4tncFXJkJ+Had4bs1BEdm80gkGHbR7MoibnbZ7zTRY4d+V3RayAvCZeCm+PE0t2A0kVnxc2Ke7vfiiKsnZ18hE851AGt22iptCECwyzmAFoB4el08lWuMWY7WmmR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+bwmOIj6D+Ii+doy51oREOicXf/4Kcnxf105ivVJFU=;
 b=J8kwmLrRGsNyrGtpKsoUo7X0p1PsEIv0km1M0uqTgeWYa7a/8mZddRnrOn0TcRm3YncTi5RN8j9x9YypiGaVs2lwICYBMR9TK0bSx4c33YGrYQ7qyVmMl7dJlzCet8sFXOMPK1rLNbNE9uw/W58KAstt9vUoG8kA4ddMH0/UBNoHd7e3B21bvrKOhaMkWP1YOC74vdayLt+cpuM3U6R5DX06EeRaUKPF6LVZ36iT5RyVC+1OUcK6eKrmOL36ZsloCdAIWLaJuI+hVB63fBQZ55K/+hNNbppIxizza59eCAUVVyGrcgEbXadD2ibAPRB1Fl6d3NnIJsj4IkqDDFINTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN6PR1101MB2145.namprd11.prod.outlook.com (2603:10b6:405:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 19:55:10 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 19:55:10 +0000
Date:   Thu, 14 Jul 2022 12:55:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 6/9] cxl/port: Read CDAT table
Message-ID: <YtB0loLvlKbgcA43@iweiny-desk3>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-7-ira.weiny@intel.com>
 <62d0387522e5b_16fb9729432@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62d0387522e5b_16fb9729432@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695cb428-ba55-4d48-6086-08da65d2c22c
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2145:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+HfaS4neHJhUjrKoXPOheYNbW5m789CHYUqaazf1CV5wEZggoRBE/2VRPBMwAuZ3b6mlt59Ez9SGOzf3+T3bHXWdXfG6XtY9CUjZtz7a0r8xJ9/dGBt0LDYc8aIkrqbEPHxBngYHmd5ppvee9wHbhnqjAOC3cqJKS+Sx0lmqLFJjf++JQ9gRRveso611zQR3FHEHf6obYhah5bNT1AbLDBNk/6C9VXEGL9MSssICr76KrnLeupnPdtSagUV78Q/JYmkLHkIgO1rtZd4PnXBtG8TcUWpG437IlIavR4+aRYw/frhZKHNeC1wc5YQQD8RPrrg2SjC1v1IWE1ct//ETyz+2SU6hxhqMEahT8rRmKMHy59muoEE3XIh7oiohrrt8p0U9cO6Iy5dYuc/yi767VW1sHxZneEWE605YupUTgy1ybUr2yJUg7tyytQZDU3VhF0MNRZAxqafgOUFMzTnJgg3EHeff7W4bQTSEbUUr0tVZMTM3gZW4n/tKWjBSgvN51ATcqSMUIb5lVkLjN8SbOzUtxFX23G/QZcWazql4yCH9CZQXQvaV6mjL8NV5/WYnagfTaA61BOjCqo7m4u1PdiS9eEIURvPGeKvBf85Wp9FHdgzeHUUa0GBMDkS8yFVWdB6z0Ebtj9POD39Bl7PC/dXfNWcnowWlmNc07BznVwcaF5EpEy+2N6JQi5wilCnfA8Gbb/E7pGjh7cwg0j4d4wv9QYvwpscn/JeuNvOtukpXZFoMVxXsjssal0f3h8wX8WPvHRb8J9v6xfSPc+OvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(83380400001)(316002)(82960400001)(8936002)(86362001)(33716001)(6486002)(5660300002)(44832011)(41300700001)(6636002)(2906002)(6862004)(66556008)(9686003)(54906003)(6666004)(30864003)(66946007)(6512007)(4326008)(38100700002)(66476007)(478600001)(8676002)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYzVCu8eTeBmiITM5/P8NBbYKwofFK7t7cBHeUEE7B8zF2wmdsqjmSg/Oppu?=
 =?us-ascii?Q?wQ8IG0CeMgo02iqYdBxGi6HWQ5GaAkr9xshAwTWssyxDRsxuRp5ETtjnwjFO?=
 =?us-ascii?Q?0lI6gMQsFVlFLoL5z4ucIBgyArtKDrf/yhm3bIu9L8rF9CR0jXpyZ5BFfpwp?=
 =?us-ascii?Q?jca2ILjruUYRVDXxQZJDjAVVnn6OpxhgzrrRcPm0hrQs09t5dMkdrU9FHHnw?=
 =?us-ascii?Q?iBL3MFZdk9RO4arDCWpl17fTQjhlNNN02xPPFNe8QETTaPCEsky6grL3zAK+?=
 =?us-ascii?Q?eMRrynOHmj5uYx1itREkkxEbp3qWw9BVicJ01HEgjSWEcu2ITPvx9wPLAe0V?=
 =?us-ascii?Q?upU8AgZbzbBeV2APVXv/yOhsRTf0sL5rotB+OCJliJn7ockTc61QoTOfFXdx?=
 =?us-ascii?Q?381U4Ec97xgtaLqgG/6eLiayc/EejGA4AqtiVoWYHugcHwipwkjuRt4fU5Mf?=
 =?us-ascii?Q?mTDQW/iP1inWhUJ3OwH+vTCc1kKSxrN8tjqPrwBXdw3FK7+X+eTVt9wTGKjG?=
 =?us-ascii?Q?q6M0iBtIismybBLmQ6+SjP3vN0uM3vk90VmrF/5puG6O4LXOGIwSduMeabTU?=
 =?us-ascii?Q?am7v3YEaO/ARNEItmTDyj3Oiwi6K74uWcpBUQ00by8H4GznGfXJgP4AlHvJF?=
 =?us-ascii?Q?TurUqJy2urdGyLUI0jMAB4xNseG3cRVJ0470bGmUXaxVOY5pSyTO7plwozoZ?=
 =?us-ascii?Q?ybatQYm9yVNYJGkKXhIfZcEUG6kn7NDKTpbyHNgVQQwo+wshi9BaeZ2QT9VK?=
 =?us-ascii?Q?Ipd7z+2d9eHdAYje13XM0IJ7KpAho4bS7xPBR+tzP9T7+yVfPeV1ZixSvknh?=
 =?us-ascii?Q?4EstoKlsisEKlyOCWg+6BJWIgYAh44IEPnSklMCO+G2AgzM+vGrMTk71p1kn?=
 =?us-ascii?Q?wqcvMpoITgUATWpMebMpXNrT+zFbav7mCKNhClWZUO41lfIlPkYSVN9jfaFm?=
 =?us-ascii?Q?s8FJ9P/l3nn4hqz2EdDTmSZ1ELbRVUGpRJzkcZvge5ACoBVyvJqRTt57NnfP?=
 =?us-ascii?Q?tOaJ8AsOqDNC4foB+yl4L2pdk5Jxx+sWDSE3eTBYuDOa8nLlGNlGmDJkpTNu?=
 =?us-ascii?Q?GEvPpK2EqTv6AzaqhpJpYnPccEgDgkIt7y+OPcd6mpcMuXkTEClCxBq5qIfh?=
 =?us-ascii?Q?pVYKHwFpAZnDZyWwcu0lz51gaLzp0pAWFQfL4U87eqfhOMk9W5t5ZgVmfUK+?=
 =?us-ascii?Q?uz6ZQQ/LGbNLLgrgU6oUNsl/vz6tmW8xusuGlZuQv672LlnN6E+ww6IunJeW?=
 =?us-ascii?Q?qXvWjHZN30WmH7RzOMVItWwDjGMIKa4vcYIy1DJmm8M1XleSsSjpAfIs86qJ?=
 =?us-ascii?Q?N6wy7CT//6VQYu1j385C1XfLr02zwklqTFN4jE8k9qwbd8WDughhRNLhmwmT?=
 =?us-ascii?Q?rvJRqCTdb+woTbVjsfO5p6gzl2uyNX41JgBz9/k2lpRdxNkYJW2zVzGZPStu?=
 =?us-ascii?Q?A90OmjZ9/yWJAcZSYztSVqKXGYeg5PYAYJq82Ep3QJgfpUCmBITMU5YAglvH?=
 =?us-ascii?Q?TeBxS4S2pYwKweMlTdrruigm/FvDVRNFguIhibqWNGmpuR9MvLdEsqSETjlR?=
 =?us-ascii?Q?hE3BjNPuqdbuMTVUixbfL5U+1tS0HSuT2U9rsxvv4im8Wewu9oJP0RNwrY+K?=
 =?us-ascii?Q?TvXEizDlUpBNztSP/ZbQmx8phiYy8uokPqI4S4TkjdFo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 695cb428-ba55-4d48-6086-08da65d2c22c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 19:55:10.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dY9d0nE6kjMFEgNZNqat7Z20RnwNeRjxzGUq+BM3oBFNxmaB4YCUl0Hs5PPLR2V4d0KL1TecBdOT3H8zEVCT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2145
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 08:38:29AM -0700, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>

[snip]

> > ---
> >  drivers/cxl/cdat.h     | 100 ++++++++++++++++++++++++
> >  drivers/cxl/core/pci.c | 170 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h      |   5 ++
> >  drivers/cxl/cxlpci.h   |   1 +
> >  drivers/cxl/port.c     |  51 +++++++++++++
> >  5 files changed, 327 insertions(+)
> >  create mode 100644 drivers/cxl/cdat.h
> 
> The bin_attr additions to CXL sysfs need to be added to
> Documentation/ABI/testing/sysfs-bus-cxl.

Done.  But with a very simple text:

What:           /sys/bus/cxl/devices/endpointX/CDAT/cdat
Date:           July, 2022
KernelVersion:  v5.19
Contact:        linux-cxl@vger.kernel.org
Description:
                (RO) Raw binary CDAT data.

Is this enough?

[snip]

> > +
> > +/* Device Scoped Memory Side Cache Information Structure */
> > +#define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
> > +#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
> > +	((u64)((entry)[3]) << 32 | (entry)[2])
> 
> This looks sketchy for 2 reasons, there is no type safety on @entry, so
> it could be anything, and it is referenced twice which is a bug waiting
> to happen if this or any of the other macros that copy this pattern pass
> a statement argument with side-effects like:
> CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry++).
> 
> > +#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
> > +
> > +/* Device Scoped Initiator Structure */
> > +#define CDAT_DSIS_DW1_FLAGS		0x000000ff
> > +#define CDAT_DSIS_DW1_HANDLE		0x0000ff00
> > +
> > +/* Device Scoped EFI Memory Type Structure */
> > +#define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
> > +#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
> > +#define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> > +#define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])
> 
> More sketchy double array derefernces against an unspecified type. No
> need to invent a new way to parse ACPI-like table data. CDAT parsing
> should end up looking a lot like: drivers/acpi/numa/hmat.c. I.e. I would
> expect the helpers in drivers/acpi/tables.c are repurposed to parse a
> passed in CDAT data buffer rather than using acpi_get_table()
> internally.
> 
> Lets drop patch 9 for now and all of these definitions. Leave all the
> parsing to userspace via the bin_attr. Then we can circle back and build
> up the CDAT parsing code when its ready to consume the data for QTG
> assignment, and reuse the ACPI parsing code.
> 
> > +
> > +/* Switch Scoped Latency and Bandwidth Information Structure */
> > +#define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
> > +#define CDAT_SSLBIS_BASE_UNIT(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> > +#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
> > +#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
> > +#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
> 
> Yeah, all of these unused CDAT defintions can be deleted from this
> patch.
> 

Done and patch 9 dropped.

> > +
> > +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> > +
> > +/**
> > + * struct cxl_cdat - CXL CDAT data
> > + *
> > + * @table: cache of CDAT table
> > + * @length: length of cached CDAT table
> > + */
> > +struct cxl_cdat {
> > +	void *table;
> > +	size_t length;
> > +};
> > +
> > +#endif /* !__CXL_CDAT_H__ */
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c4c99ff7b55e..9232b806d051 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -4,10 +4,12 @@
> >  #include <linux/device.h>
> >  #include <linux/delay.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <cxlpci.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  #include "core.h"
> > +#include "cdat.h"
> >  
> >  /**
> >   * DOC: cxl core pci
> > @@ -458,3 +460,171 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> > +
> > +static struct pci_doe_mb *find_cdat_mb(struct device *uport)
> 
> small naming nit, probably more places than this, but
> s/find_cdat_mb/find_cdat_doe/ to make it clearly distinct from the
> drivers/cxl/core/mbox.c infrastructure. I.e. I think "mailbox" is
> implied by "doe".

Good idea, mailbox (and mb) is overloaded.

> 
> > +{
> > +	struct cxl_memdev *cxlmd;
> > +	struct cxl_dev_state *cxlds;
> > +	unsigned long index;
> > +	void *entry;
> > +
> > +	if (!is_cxl_memdev(uport))
> > +		return NULL;
> 
> If this only supports endpoints just call this from the part of
> cxl_port_probe() that does:
> 
>   	if (is_cxl_endpoint(port)) {
>   		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> 		...
> 
> ...and let the person who adds CDAT support for switches refactor it
> later. I.e. find_cdat_doe() can just take a @cxlmd arg directly.
>

I was trying to make this generic for all ports originally.  But in the end we
punted and said end points only since we don't have the plumbing for PCI port
driver yet.  Won't I have to move this back when that comes online?

>
> It's
> enough that this patch located the cdat cached buffer on 'struct
> cxl_port' and the 'CDAT' sysfs attribute under
> /sys/bus/cxl/device/cxl_portX.

I'm not parsing this sentence?

.../cxl_portX/...

does not exist?

root fedora /sys/bus/cxl/drivers
12:46:39 > ll
total 0
drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_mem
drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_nvdimm
drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_nvdimm_bridge
drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_port

endpointX points back to the same place as /sys/bus/cxl/devices/endpointX

root fedora /sys/bus/cxl/drivers/cxl_port
12:47:03 > ll
total 0
...
lrwxrwxrwx 1 root root    0 Jul 14 12:44 endpoint3 -> ../../../../devices/platform/ACPI0017:00/root0/port1/endpoint3
...

root fedora /sys/bus/cxl/devices
12:47:59 > ll
total 0
...
lrwxrwxrwx 1 root root 0 Jul 14 12:44 endpoint3 -> ../../../devices/platform/ACPI0017:00/root0/port1/endpoint3

So what is different from what I'm doing?

> 
> > +
> > +	cxlmd = to_cxl_memdev(uport);
> > +	cxlds = cxlmd->cxlds;
> > +
> > +	xa_for_each(&cxlds->doe_mbs, index, entry) {
> > +		struct pci_doe_mb *cur = entry;
> > +
> > +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> > +					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> > +			return cur;
> 
> This has me thinking the doe_mbs xarray is overkill if all the other
> DOEs are just enumerated and then ignored. When / if more DOEs need to
> be handled then we can think about instantiating all of them and keeping
> them aruond.  Otherwise, just do this pci_doe_supports_prot() check in
> cxl_pci and throw away the rest. Then cxlds would just carry a single
> @cdat_doe attribute for this first use of DOE capabilities in the
> kernel.

I was hoping that code could be lifted to the PCI side later.  For now CXL
could handle all DOE's.

At this point CXL devices are the only one using DOE in the kernel.  I know
there are other PCI uses coming but for any 1 device only one mailbox object
should be created or we are going to have the kernel drivers conflicting with
each other.

So I'd rather leave this series with CXL controlling the DOE mailboxes.  I
think later we will need to lift the mailbox objects to PCI and CXL drivers
will need to query into that side as needed.  There was a version like this
before (Probably Jonathan's) and I think the aux bus moved it all over here.
<sigh>  Sorry getting pretty confused myself at this point.

The code change you suggest is easy to do but I think it would be better to
land this and then lift all of the mailboxes to PCI in a follow on series.

> 
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +#define CDAT_DOE_REQ(entry_handle)					\
> > +	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
> > +		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> > +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> > +		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> > +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> > +
> > +static void cxl_doe_task_complete(struct pci_doe_task *task)
> > +{
> > +	complete(task->private);
> > +}
> > +
> > +static int cxl_cdat_get_length(struct device *dev,
> > +			       struct pci_doe_mb *cdat_mb,
> > +			       size_t *length)
> > +{
> > +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> > +	u32 cdat_response_pl[32];
> > +	DECLARE_COMPLETION_ONSTACK(c);
> > +	struct pci_doe_task task = {
> > +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> > +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > +		.request_pl = &cdat_request_pl,
> > +		.request_pl_sz = sizeof(cdat_request_pl),
> > +		.response_pl = cdat_response_pl,
> > +		.response_pl_sz = sizeof(cdat_response_pl),
> > +		.complete = cxl_doe_task_complete,
> > +		.private = &c,
> > +	};
> 
> I think this wants to be macro'ized to something like:
> 
> #define DECLARE_PCI_DOE_TASK(vid, type, req, rsp, priv)

I was thinking the same thing after you wanted the task init here too.

Can I follow on with that work?  I think the following members need to be
wrapped and hidden from the caller API.

struct pci_doe_task {
...
        /* No need for the user to initialize these fields */
        struct work_struct work;
	struct pci_doe_mb *doe_mb;
};

Reworking that structure goes hand in hand with said macro.

[snip]

> >  
> >  /**
> >   * DOC: cxl objects
> > @@ -267,6 +268,8 @@ struct cxl_nvdimm {
> >   * @component_reg_phys: component register capability base address (optional)
> >   * @dead: last ep has been removed, force port re-creation
> >   * @depth: How deep this port is relative to the root. depth 0 is the root.
> > + * @cdat: Cached CDAT data
> > + * @cdat_sup: Is CDAT supported
> 
> That does not provide more information than the member name, how about?
> 
> "should a CDAT attribute be published in sysfs"

Sounds good.

But re-reading this 'cdat_available' seems like a better name all around.

> 
> >   */
> >  struct cxl_port {
> >  	struct device dev;
> > @@ -278,6 +281,8 @@ struct cxl_port {
> >  	resource_size_t component_reg_phys;
> >  	bool dead;
> >  	unsigned int depth;
> > +	struct cxl_cdat cdat;
> > +	bool cdat_sup;
> 
> Just spell out "supported", no need to save characters on this used once
> attribute.

ok.

cdat_available?

> 
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index fce1c11729c2..eec597dbe763 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
> >  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >  struct cxl_dev_state;
> >  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> > +void read_cdat_data(struct cxl_port *port);
> >  #endif /* __CXL_PCI_H__ */
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 3cf308f114c4..1ec34a159657 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -49,6 +49,9 @@ static int cxl_port_probe(struct device *dev)
> >  	if (IS_ERR(cxlhdm))
> >  		return PTR_ERR(cxlhdm);
> >  
> > +	/* Cache the data early to ensure is_visible() works */
> > +	read_cdat_data(port);
> > +
> >  	if (is_cxl_endpoint(port)) {
> >  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> >  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > @@ -78,10 +81,58 @@ static int cxl_port_probe(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
> > +			 struct bin_attribute *bin_attr, char *buf,
> > +			 loff_t offset, size_t count)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct cxl_port *port = to_cxl_port(dev);
> 
> Just for completeness you can have an:
> 
>     if (!port->cdat_supported)
> 	return -ENXIO;
> 
> ...to document expectations / backstop the is_bin_visible().

Sure.

Ira
