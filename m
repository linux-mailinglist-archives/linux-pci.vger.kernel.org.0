Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8922567EF1E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 21:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjA0UEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 15:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjA0UEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 15:04:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E3D7EC5;
        Fri, 27 Jan 2023 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674849763; x=1706385763;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fm8pRYIvHIWX+FnHTutAg6fKek0bu6qCiqhAK/ragl0=;
  b=N/KAPNOO1T68azqK6tQM6cOnGpE+af2FvOV7ooxvhr2pvinKfQfwUbmZ
   wxoL2HcXaZd1vaVWMjMlkziA/PlQYDqCfn4ln98m8I7qsv4LhnbSGl7+n
   6GukNG0ff011rWSXRI3BYDp3cZNeM0eqyMnuoj3a28iuaKiyMgzmvQJWx
   jTikx8vPJaLi7WK9oPIbGzbm6hLjeEc3//vOPvrCL9vtmm1T+rXU4yBT5
   y9R+VicMwwfL3jt61daYsqRjXBAB/6/0hArNeU/hf27Bj/0f+600u3Pxv
   wxtjO8YERQo9w0lILu40sjPutYdP6prmYcuRjTcDHDIAyxXG3myMhTbn7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="306826300"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="306826300"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 11:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695641857"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="695641857"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 11:45:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 11:45:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 11:45:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 11:45:15 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 11:45:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/4TP0QZF2nqvNU3/DO5eBGF5QPZ4cUGAfMNir0d9usw5Ivn8ZSTxl5dF2vYWPcpyjbtuFylWqcP/vg6SLiWezwKgS6zSL3Jsss42M8NHw06nv7yW/LPRsBbGR0sI5O8S5EofxhfgXMz0bFpp6qvjQNqoLCLitcfIukYvT1iJoHlwOkjsMIHptZm/UOcjpMqVk1kATqD0hvoK5Q5QUsMSJhdMNrclPWPVPcALlC5N+iilIjTriyck/jspwcBjcLMw6OU87BzryuKFGkUlsuZmrLnE1tI+2fKZShBiIXFpnIzIygXI8qZBgda1eUdZEQpocsqGD9wKl5EVlqckjc1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu1Gn7UfFwrZ2QkFvnwCvwUhDeCEBlsmxYTxiL1tGRo=;
 b=OshGo3X8MbX1n4ri3b2W8+8yBGeHll9DMjxHojsxA4R2HHjSZQJd6XGfEnll9bQRLP67Ry/7RPja1VLAGVyIMwuMCO8BWXt2gAQfI5FBq0+3TAtyglrPZavWJvtxFder7rbkh7WEKCxJS5YGsfsDpd6bL7QWXEEbqm2Bwp7cj3nE1GtjFZ4nENOc50KKPsMQEtxoCOTAX6lTLRBVBVbJvBVa47DRFhuysZ8jfY8FWNxIFAcOFQQDaUJGhsgvazLwQoofGT9LfOg3XaUhcVIocWSv5A4ZUSeocChAqeONXIzahF4bfZ+n9Gv4BAOSNjMNYSts474IOvo/G4B/uq4Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 19:45:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Fri, 27 Jan 2023
 19:45:11 +0000
Date:   Fri, 27 Jan 2023 11:45:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <63d429c39ecbb_7be472948f@iweiny-mobl.notmuch>
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
 <20221216-cxl-ev-log-v7-1-2316a5c8f7d8@intel.com>
 <63d31f8fbb678_ea222294a3@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d31f8fbb678_ea222294a3@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 885b3cb7-d9f1-4c3b-cc7e-08db009f003d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDYCMsN1jSdZWLbynjyi/5PCP7Bv9zp+c8h7aUz/8A3vRolZyejgSAWrL6N0KjkKYRtBbzkiExqPItsTlBpV4g7BAQ+EJpaR+96OhB6++NGWzHnrhz2M9umn9IwawSLngY+aFXoT4zKxBL+UnDy4iCFWr8MPS7RtmIHILTUmgm9fAHnubmKd3SAz1NEjKGrlaFH3qsZCmh1fpnGpMJ6TNdxJ2rA0eK/A+U0tNzzlma24l0D9r+biCYJm5urBzMd2aK3VOdN8j2ucSseMHHBSNuyy5ql3+cJIXb4Bldg09+DaUq/15SqUhjTqfpC86xNe1EWcUPEQ0u9HfghYWvnRn1+o4L+xCxCfHrG3ilDjS3rpt3M+wY9LdIh+8ruv3wEf2LlGfNAHTomgPYuGlEGUq8JP26ZscGqc9qUEV72W/0NB2gMd5aC+4b65T1ydVmscCW20a4rNCk8LLDtX9xisjKAaOJpKP70JUDoyh8JfEbwo7h/TVwz/HQ76W0jaQvgF3Xlhb27bAvmhhLrX9ERfunyziZvb05nM6VNNgJV8EvDT38aFOrckwixL87glK8Od3OryKqQZNL/Z0BXJ1alZ5L0UImkjEi6YPpviBIeihLwLvVksLQIBupb/FpAoVpRsHEgusEoukZsCyssyjRCkug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(44832011)(2906002)(5660300002)(4744005)(82960400001)(8936002)(38100700002)(41300700001)(6666004)(86362001)(6486002)(478600001)(110136005)(54906003)(316002)(8676002)(66476007)(66946007)(4326008)(66556008)(6506007)(9686003)(186003)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVHbUSf2iD4K5TSA75E2hlKICVpiJBLdYlZqeluWCMtr69t3d5UXiDF1BV/v?=
 =?us-ascii?Q?SwwQ2ImKZMrYBRWQl0Ut7UdocMrIwS5gzfkp0sUR+APvvZVspvmQSyhrjFJu?=
 =?us-ascii?Q?Kp9EUQOBbj8wGG0iWcKFVON5asFrIuJYidOzBrfctrdBCr9PXR/Gmnr+J8hy?=
 =?us-ascii?Q?KkzBiiyxhVORsnVQ6mlvhnYsf6F0llOQESehiV69580XpPi8D+YuKq2sj5QR?=
 =?us-ascii?Q?GVggL2FTEcamGtRF+iaKzKKoAgGCcHq2S3au7eF1oV+932Ri6IZvp4LSsgMm?=
 =?us-ascii?Q?mhLxlBjqVUEnavvfTCcyCRSJDUjrGGM+6Y5FOv/ISi1OZAyEf/E7ukILGnqC?=
 =?us-ascii?Q?ruOukB1vMfyaSKrEZH27bdiRSgaMQhHlRdc55J4tbUxYkFUkreySxR588eRp?=
 =?us-ascii?Q?Opj7udvTI+J+HGoI6odeEECQg1prnTSHIQutpcqMO4ixX8ddEXy8GIJEK504?=
 =?us-ascii?Q?zNMi/ePJlL7gm9N+NdkcljMoK1DFQadmro6MXdu4IbkcCwFO80dYFN/uwNsu?=
 =?us-ascii?Q?ZhH36LlE5ov/gYAv5L8pCAhD4OYjyVGxkqUe0eI82caMOhskDaYiEMpG382z?=
 =?us-ascii?Q?9DJP2D19BsWEcIuyhYOxhhSfzuECUUoPd1PxsI3mSNkCDSSSSQ8JJAQlBcJI?=
 =?us-ascii?Q?CqJpCQCMGV7wDieHlu7C9fvdEj5kOLuJAcNUM5Qp3yvjWeCfRow2tcvNnOge?=
 =?us-ascii?Q?oJ7cy9YP/0GwuonS5wKqVxqMbooAD/+xyQam7snLO5EGmz3AIkpNuHJEqA6J?=
 =?us-ascii?Q?KJEWBFTBF82y+wWAGFscc7vJ9PbeLFGZeBvQpIKnap13em/lpRw1E59LQAf4?=
 =?us-ascii?Q?o/9xQWIpKYdPLDaUEwiHMGJNgN3/PksFLjOMBca+cydOg4Ep334YswiYsqdx?=
 =?us-ascii?Q?nZ4PwosLQqoUMu/5WXx5UKWwO55R5Kk6CPB4+JCkwgYaye42+Rj4+0/CcnvD?=
 =?us-ascii?Q?sqkZq4BSieqMc8AVViBylwzezIRZA7TXOrFkTgCdDHrJCrovS3BamCRigiCz?=
 =?us-ascii?Q?T99R9v3EQehtoFMidgeXrx8ovI//kUnBbhiJwHLissI39GE1W7pOnDf1K5Qu?=
 =?us-ascii?Q?/OBeLPwCnw7FulinaKXYYGwEDEhHDr/1lguTjpJHvXIHBM2k7H1jG6lR/c1f?=
 =?us-ascii?Q?i30SJqkIIJelpWLgs0HpuWDYT63g7yq9eN5jD8subDLqso9A9XRQ9oQucvH8?=
 =?us-ascii?Q?0ZCueYyM0elyMdGQHlGT8FEIh849ZKqSfDfTPc05NEuXjgoRfik6IKsHX2VK?=
 =?us-ascii?Q?3P3L4iydcYGMAZraqAyxX//GqyFHMNUNKgAgFapA9QB7XR3SSMfn2XypW2fO?=
 =?us-ascii?Q?UfFXpBdet+8Ue/ub559bAivv9EIJzTRc9wlwqTziGGA513m6dhTDfoZ37Prz?=
 =?us-ascii?Q?s4icnP6Z1i8JCjqNwdZIUyFWKmRGrAVWJJ+woCJ6s2ftD6n0GEiFMSp2Fztm?=
 =?us-ascii?Q?S+GJkBctn5ou/ogNBuhtJljN/0Mtp9uzSQgZjSXOItc1IGcbF3x4utpO8hZh?=
 =?us-ascii?Q?vC9pADk93efKST4c31sY3QKeVoKjtcG3Qbr+sLExeIMob1uTr6g4rM0YF/94?=
 =?us-ascii?Q?f+MoPwnhlB4xEcdtFX2vLo9/ycur/WMh7jr6J9i5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 885b3cb7-d9f1-4c3b-cc7e-08db009f003d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 19:45:10.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiGXo/KKi3u1lbArkbYjBTMc0H4cTXaMRVJKi2NoYB6LpRxFDjEb9y2hDudDTvpCCzBO/knYok+gu/b/r0rqVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> [..]
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 20ca2fe2ca8e..6898212fcb47 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -6,7 +6,9 @@
> >  #if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
> >  #define _CXL_EVENTS_H
> >  
> > +#include <asm-generic/unaligned.h>
> >  #include <cxl.h>
> > +#include <cxlmem.h>
> >  #include <linux/tracepoint.h>
> >  
> >  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
> > @@ -103,6 +105,124 @@ TRACE_EVENT(cxl_aer_correctable_error,
> >  	)
> >  );
> >  
> > +#include <linux/tracepoint.h>
> 
> missed this earlier, no need to include this again. Will drop it in my
> local tree.

Thanks!
Ira
