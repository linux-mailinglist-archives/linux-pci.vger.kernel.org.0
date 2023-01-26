Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791E767D849
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 23:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjAZWXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 17:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZWXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 17:23:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99484A23D;
        Thu, 26 Jan 2023 14:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674771798; x=1706307798;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c6rBGuVhUlJiffnZowQGUyJ6ZjGl+H27EvkdzfiukmM=;
  b=g6BcEVHnv4IOKpnI4wWtKt9WomCvck/CV20nib0Cskpqaa9rt1Jat16Q
   80WWjaUpTuf511bapwHcJYlTOJQy7MPhP381cGAsOyoisSA7+CMNuhiSZ
   FCSJFu6zFo7AD1Q7r8NyAP8U5XNQTtmqv5VENMTHb5dMaGFgk85wgKZuh
   6vB0Z+4ZordJA/G8mQmUzgn0impf5oZO2YTX0SZi9ZmMBaJ5xg+/RrpYo
   KDKwa7MYM32UgH1AqJF0MyvW3sue+wnUt0PVklHivq0xFugstldske2HM
   h5i395kFjIoT+ZVlOpdsbDN0UTyadvD2rBYRjmVy5lPjQihCTy4yVr3bH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391509125"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="391509125"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="908405901"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="908405901"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jan 2023 14:00:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 14:00:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 14:00:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 14:00:36 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 14:00:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnOvSiKuYSMzdacELh6zlHr4zO7H0g2JPa+Xmi17GFYgdQOkqFPitLAh+FJmO/ytIUNLYZO6BVG941umCPn2I0DbNUKurwSQ3Ek0ALNJSNszHaoB95BsnM1K2N/JLol0OVVOM+sRoZvmmAEg+PeevoHwhs2vMgvecPEjwy9NAtN41tI7nPPC2YMGztMxI9yr3gdwsGAlqw8/qt4xZHP4DH/THTxQjYpsHFJNnuJJ3LN2k331Jm39drW2+ZYczeKK+YB9JjUZmpMhiaf5xJ3wZZo2YAw3xijOwDTr16Xf9uDjc5FMtSp6E9vApkKiLBxtLKyEOqmDmJk0Wij9BZFSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rprgjAWWXgxPpr7HfGq4WlAtJYqHPDkOzOu1b7sXDwE=;
 b=NEAXxnDu9NXU+XrLes1ud+5WZsnVO+iawIxSICRShlyYY0JqXZbQcR/NJ9X1EcqErHfrXkuga8KnxfmgWTDGCoRNO+PjLrjahw4uVop+N0+ivnGe7fIxgLA+sbff9I/Z7UHh7X0r5y7Jhbq4NIb/Ks7Z0bzUwr4ii8QVcLiaPJNDVwiwJhjnta9FeCgmlkFa8TijTVtJWO7x5N97i9Q/NmxuZjxqYVlYOfM+rPO2ybGiSDU39SRhPRvENl+5UUd57Drkpj/r0jXLC0WpiIaXbFGzUUiWxJ4eao0Xz9r3QRhuBvVgkxmJ3W7wCVI2MrA6iGPAG2MoBlg8gxsphozNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 22:00:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 22:00:33 +0000
Date:   Thu, 26 Jan 2023 14:00:30 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
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
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH v7 2/8] cxl/mem: Wire up event interrupts
Message-ID: <63d2f7fe1cf40_ea222294b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
 <20221216-cxl-ev-log-v7-2-2316a5c8f7d8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216-cxl-ev-log-v7-2-2316a5c8f7d8@intel.com>
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fa4266-678d-4fb2-b811-08daffe8bed7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/2K6dt+2xch82Hns+x/jfMDlM45yNRKmdp10BVlLOIH9848yLXS84vnvPRTB50rCmcmwseKaZ6HZzG8KMGTpblnJaTYLs8efqhGObqXbi9CxKLlacuse9Jh4RA9idonb4WBlGvzEtw6QlMCtEOrsUYn8JK99rkfyt5/PQDu4rD88AcTa2RCR2rT6jPylCuDt5SImK0bODCJ6MAyl2wlIw2fRPEhjKra++PTE1rwthWbSuqV6/ay4j9EEPeFQGZg+pfx1m7ArBJqcHj6z4Eck8R0BlMmz7VONdOxzA5RN0xB3T3i7xmiO9/4WIkULeKH5dDIVf3s6TMFaIBoxEMPvgCjn73+Q1LC8b+go9CIrywLx9kGF5PoPogkoUTSOZhN+0cpg5w1m/zAKW7A/6xI67Q9Am8/6zNxIrHimgGvaqANLl+lduAZmhC4jkdLD5egfzN3bBdPSfLRcISRoeyYQrGhu8+L/UVepLZYLc65ptpZvMq50WlZJvFnq7+s3jdYtLnKELM1UXRwN2SMi8UQc+tCwtY4alOy7mc/h2L15kpCYIDVyMENc8i8Y54Jx9a4UoH9Akxx1QHPAC+0eYq7eXzTPACLSaNHllmPZ+MsXubsXwoHW/KN855hbwg8VW5BmO0yy4JGRaEPJzyUFUi7jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199018)(54906003)(8676002)(316002)(6506007)(6486002)(478600001)(5660300002)(7416002)(2906002)(6200100001)(4326008)(6862004)(66476007)(41300700001)(66556008)(66946007)(8936002)(82960400001)(83380400001)(86362001)(38100700002)(9686003)(186003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8V+6wqAIxwM7FAqrFRCRBQ+/odk7bHWDWFlDjolQE4vITjeoWVSJOZmevXT?=
 =?us-ascii?Q?QEfX+oPyotQ552LNeXjcsxQkoKwPL+3bb1gzKXWt8hIwCy1+XstU8ruD+l3J?=
 =?us-ascii?Q?od57FyLBSKSsfmITmWyejsUZ8Ez8de8TWcu+Gsv9BXILYtHxAcjkxPgUyJNY?=
 =?us-ascii?Q?dB2qtNKRn42RC1Am2xkRH+FRkWd6LYB70UBdUazau4p2LRSXY/PdovsyspRv?=
 =?us-ascii?Q?rtdQH3Vpts7Q64mwu4x2Iqsa5bq/Un8PajiUp9xTDldmeCjJa4yzpan3y/Sn?=
 =?us-ascii?Q?gvaPOPtTkXKwVyul9wvGwR60uoD25qeloJC8sWjb0LlDuHycSde8JEWEisvT?=
 =?us-ascii?Q?gd3M9HPUYtMXJDsc+9bW4hs8L7Czyx4tNvZpLqnkZ5l97dSqsPmdPvgJ5U2h?=
 =?us-ascii?Q?4IxHlxPdvSsfGMBZp+XIczAsEPNMhRzMMHFllmQRhmVEcFJeBURoB156WTVD?=
 =?us-ascii?Q?OUuMHoaCexGEaMDDFe9RABn0qhIwwucf4DAlRAOEZM5Ktip9mrqIkZi4nYWn?=
 =?us-ascii?Q?IZRnLRmyBD9uydqXyyfguGWOMV58eUMfjvHs4dls62N6ps4U75sgezsZrmgo?=
 =?us-ascii?Q?ehARKSSzkah3VmjOqBbYOaSmewQfXQxgMS7SLD+kZnECxU2/r1FwUCHmV25Q?=
 =?us-ascii?Q?EHrONmY9dc3GfnyZb0FpPd5QN/0Aibp7ySve/EKmmIjdXrPqARTfWgKg5txC?=
 =?us-ascii?Q?8HjgBMWlZ9xmTmAdA2MnlvpfXnqETxNp5TP/AYcYC0TZ3vF6i4Nq8uxUK+4t?=
 =?us-ascii?Q?OhEKfuSfa4G1LmaDWp7JyhHQQRAofAYqcOoD7w8zrigaVSPM/h2JXGNQIhbZ?=
 =?us-ascii?Q?SjXkpWFOS8F4jfA0OEbgNH8pahzt/EaMMJOy/5b+UD4vSB3n5BF/jyRrdTho?=
 =?us-ascii?Q?Yn3rkLW8DwbE1xM0HGoRucqmAGzsbqUxi27sGhgnu6pbot++xZflQLevPTDw?=
 =?us-ascii?Q?WnbU6dgTzIxXh4XQTIXJ16iS5FGexpNVIedmymexOz2P+Wgkd5CAPg0f8hXe?=
 =?us-ascii?Q?spOic9mc46SLm+qDKAP9dRxV5G7P4IEZ1zCNuNiydJWNBBr5kNztJAhUNTrr?=
 =?us-ascii?Q?t9lNmi7WGcYaNl47xmMKUGsuDj+ZlE+7ObNe2LLWdJ7jCRdxtrxH6TmKQ70x?=
 =?us-ascii?Q?nREc1LJN5TNF8ySxkP5U9aM6/tTlFT6FEoZnr8Ios7tdn6rXOH/KhSa+uzVH?=
 =?us-ascii?Q?Syo4R1waZbmsHqppjNr6UbAprtdmLNe2J061sx/lLs9FlObvkDRaWRFh36zG?=
 =?us-ascii?Q?EXgnUTzz5VAmgXxMXj6rdj/Y9QnxaSMU3cIkEjueyvCYclCcA80IahqOe/fF?=
 =?us-ascii?Q?HE7R3clDmHbxJuvzKG5kS86pFa2pAyyVRwEaQ1dZ9oYMdzYReGOBBW63YzJZ?=
 =?us-ascii?Q?qweJ+zWy/+GzZ/d3ff7L8iJX9AAHgYRV5ZM5BMWYPdk4iNhz5BR77woN8LpG?=
 =?us-ascii?Q?9ZC49SrYd9E4VNTj3YGi/AXVaiw/apoi5rl4gc9UhdZ1W5dz2pDIIiaGnzro?=
 =?us-ascii?Q?V2CZ6rKGUg0k1IVIGuUiIQHu7QKLcUnNExsFgXTgE5k1iwMl5UL5Vtev0dnm?=
 =?us-ascii?Q?N/r6IwrWQNWN2zyT1ELntElvermSO2Mpwb+DOV2UEm3qyHQwOXsH2zX3f2kx?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fa4266-678d-4fb2-b811-08daffe8bed7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 22:00:32.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMLdTxrIOsT81RQYSODeeytlZbXgzbyWSrh2EZWlNKQbo4DpGp81IqLqN/CHzZL0TbVA0lSx6eUwUeZTD+D+2OtnyRFKzpxCPurlG0HFJzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6734
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
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Currently the only CXL features targeted for irq support require their
> message numbers to be within the first 16 entries.  The device may
> however support less than 16 entries depending on the support it
> provides.
> 
> Attempt to allocate these 16 irq vectors.  If the device supports less
> then the PCI infrastructure will allocate that number.  Upon successful
> allocation, users can plug in their respective isr at any point
> thereafter.
> 
> CXL device events are signaled via interrupts.  Each event log may have
> a different interrupt message number.  These message numbers are
> reported in the Get Event Interrupt Policy mailbox command.
> 
> Add interrupt support for event logs.  Interrupts are allocated as
> shared interrupts.  Therefore, all or some event logs can share the same
> message number.
> 
> In addition all logs are queried on any interrupt in order of the most
> to least severe based on the status register.
> 
> Finally place all event configuration logic into cxl_event_config().
> Previously the logic was a simple 'read all' on start up.  But
> interrupts must be configured prior to any reads to ensure no events are
> missed.  A single event configuration function results in a cleaner over
> all implementation.
> 
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes in v7:
> 	<no change>
> ---
>  drivers/cxl/cxl.h    |   4 +
>  drivers/cxl/cxlmem.h |  19 +++++
>  drivers/cxl/cxlpci.h |   6 ++
>  drivers/cxl/pci.c    | 221 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 240 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5974d1082210..b3964149c77b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -168,6 +168,10 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
>  				 CXLDEV_EVENT_STATUS_FATAL)
>  
> +/* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
> +#define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> +#define CXLDEV_EVENT_INT_MSGNUM_MASK	GENMASK(7, 4)
> +
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0f272206e294..5bef485cd8d9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -194,6 +194,23 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> +/**
> + * Event Interrupt Policy
> + *
> + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> + */
> +enum cxl_event_int_mode {
> +	CXL_INT_NONE		= 0x00,
> +	CXL_INT_MSI_MSIX	= 0x01,
> +	CXL_INT_FW		= 0x02
> +};
> +struct cxl_event_interrupt_policy {
> +	u8 info_settings;
> +	u8 warn_settings;
> +	u8 failure_settings;
> +	u8 fatal_settings;
> +} __packed;
> +
>  /**
>   * struct cxl_event_state - Event log driver state
>   *
> @@ -288,6 +305,8 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 77dbdb980b12..a8ea04f536ab 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -53,6 +53,12 @@
>  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>  
> +/*
> + * NOTE: Currently all the functions which are enabled for CXL require their
> + * vectors to be in the first 16.  Use this as the default max.
> + */
> +#define CXL_PCI_DEFAULT_MAX_VECTORS 16
> +
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_EMPTY = 0,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0fd7742ee70c..a4ee073fd16d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -447,6 +447,209 @@ static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> +{
> +	int nvecs;
> +
> +	/*
> +	 * Per CXL 3.0 3.1.1 CXL.io Endpoint a function on a CXL device must
> +	 * not generate INTx messages if that function participates in
> +	 * CXL.cache or CXL.mem.
> +	 *
> +	 * Additionally pci_alloc_irq_vectors() handles calling
> +	 * pci_free_irq_vectors() automatically despite not being called
> +	 * pcim_*.  See pci_setup_msi_context().
> +	 */
> +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
> +				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (nvecs < 1) {
> +		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> +		return -ENXIO;
> +	}
> +	return 0;
> +}
> +
> +struct cxl_dev_id {
> +	struct cxl_dev_state *cxlds;
> +};
> +
> +static irqreturn_t cxl_event_thread(int irq, void *id)
> +{
> +	struct cxl_dev_id *dev_id = id;
> +	struct cxl_dev_state *cxlds = dev_id->cxlds;
> +	u32 status;
> +
> +	do {
> +		/*
> +		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> +		 * ignore the reserved upper 32 bits
> +		 */
> +		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +		/* Ignore logs unknown to the driver */
> +		status &= CXLDEV_EVENT_STATUS_ALL;
> +		if (!status)
> +			break;
> +		cxl_mem_get_event_records(cxlds, status);
> +		cond_resched();
> +	} while (status);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dev_id *dev_id;
> +	int irq;
> +
> +	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
> +		return -ENXIO;
> +
> +	/* dev_id must be globally unique and must contain the cxlds */
> +	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
> +	if (!dev_id)
> +		return -ENOMEM;
> +	dev_id->cxlds = cxlds;
> +
> +	irq =  pci_irq_vector(pdev,
> +			      FIELD_GET(CXLDEV_EVENT_INT_MSGNUM_MASK, setting));
> +	if (irq < 0)
> +		return irq;
> +
> +	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> +					 IRQF_SHARED, NULL, dev_id);
> +}
> +
> +static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
> +				    struct cxl_event_interrupt_policy *policy)
> +{
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {

At declaration time no need for the cast, I'll zap it on applying.

Rest of this patch looks good me. 
