Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACEC670FCD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 02:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjARBRe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 20:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjARBQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 20:16:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8465C366B2;
        Tue, 17 Jan 2023 17:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674004344; x=1705540344;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aNrqEJl/N5v8CBE8eLyLZ3lLg5XDYt96/Phlv8lf4bs=;
  b=i0EaUo68xE/z+nPe5JXNneKYiDNeJjnDXWgvy1s+9mUrJXX5WwyUCNGr
   h9/ZA720nFH31/CniJlhv0FHHuRvISgd25Kfe2KD1CGCrMv3naRb9Oi2Z
   R7R4M3FJj59uKAwOD6B7Pwa4l3CAFxglmpE/SVcsigNicu28PdcsHbaxX
   qAIPD6qhprSwt3/DF7RzTtUG67T4IzmEW87Z9Uz6CaiiiuB6EZnFaetBr
   2npycL5zDpadp/AIx1Qq2FiOmHjYpRK+IesI/v9mosipni6GaIX76bEs1
   +lD8oNob6QYHFKJp07SeC/6rba4eFuSGdLdmqHx95qr0ElMdGxIxh2QPk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="308434351"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="308434351"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 17:12:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="637064020"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="637064020"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2023 17:12:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 17:12:15 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 17:12:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 17:12:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 17:12:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKXzp0tkzlY7YQc4MxZUWK1BG2JJmg02AWWoTx/PFkeV/st27Xt2HQhdd+Yr0vuMMKx3I9GkDlY0kKzkpDEvrUd4jCsRqJC0JPznPv/j4uO/llGFTH9CTl91A+70EjmkdcNSvjAylIn7PbXhyhKANlWhBwrZA1JVsQRcnnt4ChrheIXCxD6uhVA/KhgGfyS9sz89sw7njUVcU+Mcd21aTQYYkp1e7Id0Q++VX1EAn2jyaCPKeVmN/6CaVeNZ4JA05GMzCQh9sMuObL53WLWpmbX8TUG8dev3cU4rq+cUjYJ4kk/G1xKIpF2cBIXqdBUUUNmSjk1WzXWLYqan9vtDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CIjAYOeu58hxJiGK1APrHPlzVH/QP9MmE8bbDZtWnc=;
 b=jcYoNeWBgw3f9KPFZFyY82QzVOhpn8BjJ/tPu1HZ02sX3nlCuRP2qhPkaAvmmju/DENSk0gDwvf/aQl7eWrsNwWKBAlWDIUU/jxfLOxTLMmS/dxTD0ujm5KGdrqEEgSrpyK/KEGGH/s4ULomoUAFbETqKWqkn58zrCjF/ALYhKESQJ/5TJs0k7Fr0Hmgi3W5fi1vdnEQUBePCaMq7t1tqCekqwD2ngyRpNpcPOmRoiaqxy7PKHUTsuRHR3CKjjA+yggENWOjbNdmzIE4AFF97oZwSO1iZ6/1PgtB+bbDHIViK+vvvKWe/v3HU7KUiFdZUlIYzNDrFBIqXo1/HWw6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5165.namprd11.prod.outlook.com (2603:10b6:a03:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 01:12:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 01:12:11 +0000
Date:   Tue, 17 Jan 2023 17:12:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 5/8] cxl/mem: Trace Memory Module Event Record
Message-ID: <63c74767a8612_6f94429426@iweiny-mobl.notmuch>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
 <20221216-cxl-ev-log-v6-5-346583105b30@intel.com>
 <20230113124139.000034c0@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113124139.000034c0@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: a076b76f-a612-465c-66dd-08daf8f10691
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4xXEfIcF9HXrq6/hiZQbxQi45sz93+/KDXISN9UKpqybFrvpR5TYI2MRrz1D+DWurkYdAzlqz1Su4bBFWguzNqTBIfhuiP/nJo5ywTWJmrDyg1J89DBTKgM0Zs6q7IXckTacPWv0xAHooMTqbhGgKcm1Sh1b9WPvSRrQVornjzj20cwa+ggFuvjIsA7ITSi2Zr2JUYm0eDtZiSYQs0ejdN2GNWUeZRJX8qh4rE/PQCpKoGPRz0M3rDAXQPCoUWfVPu0Pr/R/veTnrayKBk0/UQjJfd+l8bLZ5QjGtLWeV/d+6a6nIf/yfE0XSGdK0/5wsxnpKPfMrEvRTcIqtWo5kg+jdcTbwQCvWfc1IYmBljeI0VLdhZjNPcEbPUlVKXFw/hFtY2OvlTKRJzsG6HiLXfxCRP8mq7z8geryMSGBcqTKErLtm2gVQugglT1CB4n14QbTkK22MJkcvzsbJD580qFKYvTIr+gvyJEonTZ8iwq/XvF5UljjQ4KqQTqjok/sbh/tw0dZwcakg2CQHbcQVgXcRnbl6FECVnXmnl4bO4TeIB+/IuOiGLYtXkbiiP4shNBFrFIdu1RSIEg1jD+R2A5Oe1ARKv4ReA+NP6jhe2RAjCFpsHasUCynz8QzrWZe1Bz4RXNaUtcJudib+yHQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(86362001)(66946007)(6512007)(8676002)(186003)(41300700001)(26005)(4326008)(66556008)(9686003)(66476007)(316002)(6506007)(54906003)(478600001)(6666004)(110136005)(44832011)(2906002)(6486002)(38100700002)(82960400001)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yM2gTco4JsofnS90tcz58xJewoN2IW/IR5VIjYKLbVMviud5GftyxB2aBoUn?=
 =?us-ascii?Q?xv+hdXGN/s2xbOuc83pLeIYhCs5zSXnf1UIwSlr6wINXuB5SYXagHJbOEL7I?=
 =?us-ascii?Q?lE+AKq41aeCGsLEC1CbRKxxq4cQUH8U1NP0F0nWUsx6KgbEEr9xuXTOaeWwa?=
 =?us-ascii?Q?wbD1Bg/1C38s3Mx56+X+6XzamNcIqTlDJeQOk/1oBX7Z5SWb3fZIacVbMrdH?=
 =?us-ascii?Q?JdsI5rzNHDfuHWBiIHP8FIxjis3IrdY8DXJMjy4zDZ3WdEIuD8qkS+0UW8mR?=
 =?us-ascii?Q?mmIR+zHrQmWcS++LJ7LlAFtKNAoPAIwXONlqBnUBEIOOOJuNwj4Al8eQx+o0?=
 =?us-ascii?Q?9Zw/qglbm0mju0izGFU2yAe3TDf99H0hHd3UJ58amCw2EyUt4R+T/1W9GUB4?=
 =?us-ascii?Q?uB2yXNvUOWjteX/dP4vCYlnax+WLnjjg18I1qhFC1UD6PbajsQD/xNS6O54M?=
 =?us-ascii?Q?9VWWNeZeDE2ZX9twryGHZgnezH9xMM89Qo8cunV9vtsKok1nmHlhhlN26pPs?=
 =?us-ascii?Q?kYbXqGIOGojA4kfPvIMR8UEYKomkchUakiKEHgndFCBeDVCOrhoZz/XNQ6sy?=
 =?us-ascii?Q?CcL2+CPAMpib0c2rDskXWKMaO0G+LzfpMtiyd6Np0zHS9t5kyryhQsB9eKXj?=
 =?us-ascii?Q?ROmT3osRIbKd8gG4OCypHRmfbDXxooXUDBpQGLMZr5iQlpxC1dSvLKHRQWYw?=
 =?us-ascii?Q?Ye7pdzYo0zznX7UBVuo57SjRg9FDdLQpUrXNVCdNW2OzIcmMQvcR5/7PrH4l?=
 =?us-ascii?Q?OYd9m90QFHdE2ZoSdM4R7MXsCJOQKMECtknN+pHtIOITLzWPi5R4bIFYw6og?=
 =?us-ascii?Q?IOs1zdULjXs29C6RYWVDTJkQytTyntGn2STp3+ZgJ3XSXF1z+0yrkmQllwmc?=
 =?us-ascii?Q?JFWEOq17QQ2UD3CT1Q5bmg0ZtjSpV/Tva0+c5+Y5kcRlsQNYcLzbTrcNjwkv?=
 =?us-ascii?Q?S47YH3IfewP490kL4fMfuRcaSm8Msc1RiKNXb7l4e4cpYihTMsLhgIwG1DzF?=
 =?us-ascii?Q?mVXMNz/Sdr5ugeEDaew0EBizshmOfgRpEROpfpFJIbchHKZ9VZved/x0adxu?=
 =?us-ascii?Q?V+zMx8+RbZ0k3UFO8evF60mnvbicdJMh9t6IlGGFyNePGXZwli/0hFWixzGc?=
 =?us-ascii?Q?tRvcfPTkqM9v4UR3kxqb5aSmHhQSJyO3dML/lKV3Su1Lz05ix8dEMC+o2YG9?=
 =?us-ascii?Q?ybPwYuxyU4mNB6soDuwQD+8mUfz1aJnnKXsdf/v1nHsgfQhVjKTVtNjxEGYa?=
 =?us-ascii?Q?bcyVT6ETztAQqnzf8/pCXV/Z/HhDo70PKMZbzMJKdy/XDPEel9l4VQsCSRHw?=
 =?us-ascii?Q?p6hk4c6WtFB4THhe5k7l71TusdjrWQb5OxAfK0lHf8bFj3l9G1hqiKTtPT7O?=
 =?us-ascii?Q?DLT/PQQVDktt84yrOD314lPXAOR9SMvyjhT5ZvhLybo/dqENtfMTWbkwrNgj?=
 =?us-ascii?Q?S1M5OHEwv+ZB75NgMCTn2/RmuLWJYqIVd2ec84Z2gbhKbEEkQcqbiaXZNYM0?=
 =?us-ascii?Q?yAI02+7nEg1tlH8Pnk2MNS4shqsxnkuaEfnakLrpazSgnJ7LgxDio7xBSyFU?=
 =?us-ascii?Q?MyeMKO0G5dv91dz9KjIk1UB73LZv3AVCjtxs62Ul?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a076b76f-a612-465c-66dd-08daf8f10691
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 01:12:10.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJAaQpgz08tj9b6IvtsOeV3y92X0pRU/Xeo+KBz0rCzZET8c3YvsCHpfWH180h2TLlLysw67ghBXOeEusj7qyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 09 Jan 2023 11:42:24 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> > 
> > Determine if the event read is memory module record and if so trace the
> > record.
> > 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Typo inline.  With that fixed
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index b6321cfb1d9f..ebb4c8ce8587 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -439,6 +439,149 @@ TRACE_EVENT(cxl_dram,
> >  	)
> >  );
> >  
> > +/*
> > + * Memory Module Event Record - MMER
> > + *
> > + * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
> > + */
> > +#define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
> > +#define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
> > +#define CXL_MMER_LIFE_USED_CHANGE		0x02
> > +#define CXL_MMER_TEMP_CHANGE			0x03
> > +#define CXL_MMER_DATA_PATH_ERROR		0x04
> > +#define CXL_MMER_LAS_ERROR			0x05
> 
> CXL_MMER_LSA_ERROR

Done.

Thanks,
Ira
