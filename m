Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C9E6975BF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 06:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBOFSI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 00:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjBOFSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 00:18:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DA832524;
        Tue, 14 Feb 2023 21:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676438286; x=1707974286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yJTviSiu4S2vk4eSJXUA/jy0Y22yB4HO8qUbinjqRmo=;
  b=KES/YKbCrVhH7/nmNKu1w52OlnevnXmJE3dU3FMYHsUKZmU4JV5F1zl5
   bESUMjOjUAG5mbjCL7vguLbWuZ0RuntD7c9kQuAX8KR7+KxgQHoSQDgRy
   3aRsiauAUUtg7v8+nJhXRnH58hMWxgW+BxPv67LAMmS+W4t9xW4zLqTZL
   bqLHa5X9WFSCx5LU4ZAj0tooHA/wHPywhIE3oev8v6pcgmKLF1AgQpoNz
   xciUnp1qTZ2wy4Q1nu4fdQxYvRy1C55y8XZU/YnPnB0Kp22SP/pVWYVKn
   d2kJjQiGEIZTsX6FXoHirTMRMdNp5TjIRnNzVDryFVs5C9pgkoPfR9Yp1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329973838"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="329973838"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 21:18:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="619298819"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="619298819"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2023 21:18:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 21:18:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 21:18:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 21:18:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmpg4xOg5DWZreQPf323DmCRmIrECyvPcSB3NcZtXaDODCPAv/pSH+7LY5T0GoM9la1YEjQDu7B2gvtXW/uvFaaZm0FQakf2vhAO6rUjgHReFajFsyi3J5IkOQYU30NBd2XORV5x/QYWUGJeQ6wAoz7DPWYbvgq2LZ3vFRWtcDimH2We8oqAJ31xRQIHx4/XaxPiFkJTjDxPyv6nq96oqnEPaSxqUqHUAMJImZG2IbgKj4kIDXEpdWkwWRpGa0JOq1d30tTmq236T/byhaQJdt+Zm0TI6y2vyXTGuF0f8HtXF/CPWd3tx5fNrh+g5EEiBHTOGbnPbV2i0Tk1gnr7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEgPHZ0wVAiisaE/KPKLiyykJPGIa+KqvU5S46o2QG4=;
 b=jmBfL6IPj0L6tbzuoE3JxopK1078GN1kKkNsK5Fz4XUiX/q9kok+3jTSGyraRzAsRkeTWt4MRlumec/dFs1VjDc6E/oqVcGHTuV3EEtQLJAR2zhUKzHgwShtPnLahizz0yQG84n6ek84dh/s/H8EqyVK68jy4mo8A6GnOC7zN3duDwloPzgplYSUSWKWr92uOua89DbsmNGoIkxuTDAlLSRgmYtAIVReqsLhN5G3qUYolnLXjOw6aVQTCFjFn2WSpAV3aumglWwGERfeAvtcvYOVSdBfwBLlDdeIAOEigJKByjPgg4h2rHhrbDBGElT4ctfqgstULZpt1D0a1ksrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3957.namprd11.prod.outlook.com (2603:10b6:a03:183::21)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 05:18:01 +0000
Received: from BY5PR11MB3957.namprd11.prod.outlook.com
 ([fe80::a328:556d:855e:3f4b]) by BY5PR11MB3957.namprd11.prod.outlook.com
 ([fe80::a328:556d:855e:3f4b%2]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 05:18:01 +0000
Message-ID: <a9f88073-c52d-8755-4a0a-f9723bfacb02@intel.com>
Date:   Wed, 15 Feb 2023 13:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 11/16] PCI/DOE: Allow mailbox creation without devres
 management
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <cover.1676043318.git.lukas@wunner.de>
 <ad46bbc593d4b7f1c9c5cbafbb51d89533edd4a7.1676043318.git.lukas@wunner.de>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <ad46bbc593d4b7f1c9c5cbafbb51d89533edd4a7.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0023.apcprd04.prod.outlook.com
 (2603:1096:820:e::10) To BY5PR11MB3957.namprd11.prod.outlook.com
 (2603:10b6:a03:183::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3957:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: ac767bbf-ad96-443a-f3a3-08db0f1401d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcMkyPFqCoQcCA3pgjGua54kmX5cuClgoHA1mL1PoE+72qinFEwnSeQ3VRTRhht6O704CvFkWNuscIq58dYmDWS3MRlVOnpz7itmSyDmGvsctIpoRuk4pXLr0bYMEXxVnMQBVOCGa5PIY1rTd1hiWaItPvS0JMqTXb9proWcTagJVfCSWMO0maR5Sh8bhcafEyr2TXXlhnApta/lp8Zacm8GRjvdsX+v1XQ0uC7IuhFYcxOL1dMP73rpFmS0hnMwOJVDOudebE6trJUvOMSg3sJnhgy+IgGW7p2d4g6E/MPnI178emxnQEiTo4cSkYC79CZfMguYTnZwSXZtwYagXlW/39P70IgXdQImOf3zUcm1MQvZGM+jto/21thl96kRuogDeya8fBJ+1q64ekK4gH+WOIaO4qOKbdyFss1/N5ynGue6morJOSTyRYwlm2BBaMo+26cFlP33YlYkuInkZP0IK2SlXe6Swa2ZMXIjBYkzu+FaZyZwIC2IPeOf4cTd2T7pHois9l2I+QUznTQC1NB/qTpD/RPbgBWCIE3FRNiELGsmpxMHkN3nEF9t2ISwT/Os4gWhrkbW9VJxVQoTHVc3AMr2bynjycrfRUX5Xwgj8YjS4itKe8KoKJkOOBPaCZq5fCCL3HFBBwOXUHt1TgcRUWxVGlSufLDfi4pP2riMME/rv+Z1W/MMu+xn2Qo5uJBKDr8wqE18H5275CHZg7Pu8IuJNqt0nuzRRtH0RYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3957.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199018)(66556008)(66946007)(66476007)(6916009)(38100700002)(41300700001)(8676002)(4326008)(82960400001)(54906003)(36916002)(316002)(186003)(26005)(31696002)(2616005)(6512007)(36756003)(6506007)(53546011)(31686004)(2906002)(86362001)(478600001)(15650500001)(83380400001)(6486002)(5660300002)(6666004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VHdU1GTnowdjFRVElWSS9JWDE2UTlWaUJJT2s3QkZkc0EvN1RzTXkzWk9t?=
 =?utf-8?B?aVBHL3lnT2E2cWdGa2V3dC9JTmw3ZjlPaC9YbHcxTjQ2NjJ4QWhGa1VQOVVs?=
 =?utf-8?B?Q2JHQkE3Wm1mdUVYcll6SzI3bUpSUGJBNzZtRmtBR0QwQlBmaWwyVytlZXFa?=
 =?utf-8?B?YzJDdmFVaHFxLzZyZGV1TW9QRFdzcVhRV0dFYXdPQncwUS9lSU1SRDNPYlJW?=
 =?utf-8?B?VzlUS0duay9mcnVJN1pueko1VFIvQ0RyQmx6WDZkb2szZ01UQVFxUWxVQkVB?=
 =?utf-8?B?Sk5KTmxkUU84dEJJTnVTMkJvVkhxZ2FCZy9wd3RlOXZoR3J6NUJsUnFWSGZJ?=
 =?utf-8?B?ME9nYmx0RXRSdmMwTUNCRy9JVG9sR1ZoOWFtK29QKzdLcHVUcmdVZ0hmWG55?=
 =?utf-8?B?UXIxdDdQZWl1SkRNb3N3ZTFPTUFGTVdZYlpxc1l1QjI3REFwdytGTmUxSGhO?=
 =?utf-8?B?NXlib3J0T1hrK1NQbEhjMkhER2lKWCtSM0hmeGpycVNEeXBqTkZLL3pqVGtl?=
 =?utf-8?B?cVlSZ3VJa1BaZStqYnErSk11OEFEMjlFZG9SWCtxcnBkSUJpMnpmbGFpY1Vq?=
 =?utf-8?B?bFFRTzVQcnVXenByZjJ6SWN3UlhQZXBsamNpU283d1hHSXpJZWc1ZWtEWDAx?=
 =?utf-8?B?RnEwTFg1a0ZPUVl5NGRackVHZGNLQWdsQUp1VGs0Y2hKOEFZUnd5dWZnWkhN?=
 =?utf-8?B?MWROUFd1b3MwMms0UVJuRjd1RWFncE02YlZTWnY3SVdoY25od0RDS0xUMmp3?=
 =?utf-8?B?L2ZLY1gwU0ZNeGNqOWZEbElNU2RyLzluaEFMOHQrSzZCVWE1TzZzZno5ZUVq?=
 =?utf-8?B?VVZBMXk3MCt6dmQvSzRFQmdlQU1kaUJOSnkwak1NeGtTTUhiREJ4ZUM5TDJB?=
 =?utf-8?B?S2JBbW9DK05VUDNvZTRzYjcvR0dvZE5vZ0JWZ1VpOW9NS0NOQ2ZuSmlQRmpE?=
 =?utf-8?B?MlVNSEpJVzQ0ZFZrSjJCVk9jTW1iSS9qZThzOUZqREZEUmVmcnJaS3kvSzVl?=
 =?utf-8?B?MXdmZjdoU0tQTU5pSDJLR0N0WTlvcWZzOCtaNkdpR0pxL2pyN1M2UDdxbEpm?=
 =?utf-8?B?Smp1NW9GUEVaUCtQN2djUXdJQk56VG1TWmxrVVdSOEZyeGE0cHR5OGhVNnps?=
 =?utf-8?B?Zm82ZkozYmtyOGdaaFhnc203a1o0NTZHdE5pcUt5MnJYcUdiTGxacjRZa0lL?=
 =?utf-8?B?aVByRFlyNW5NbjB1ODNEYlBDRzd2RER6eWNPUTZpNkRZSTMxSmMxWHdnSmMz?=
 =?utf-8?B?ZmhhQjBvVGl6dDBLa1B2UFhZcnl6dzY3SEJBWGhRZGJiWlQ4KytSNWlxcHdz?=
 =?utf-8?B?aGw3dUV2aXdlOEN0QTEvZk92dUFVT3FVVHR1ZDNhZ05GbVZtNUJLdGdkQlRv?=
 =?utf-8?B?d2d3WG5aQ3VTVmJaRGp3RW1XMTNiY2huN0k4U2pja2h4dDg0cHRmQm9BaXVE?=
 =?utf-8?B?bUlpTm1aekxxUG94Q2tqejJKdVlwS2l5UUVmVGZtV2tCOWlibWYrREJadExl?=
 =?utf-8?B?TWNZMnlRck1yeUF5WnVpaDcyRlR2TW53Q3dxOWd4aU94amM5d1Y2aEs0ajV1?=
 =?utf-8?B?bVYxTnFZNlhta3d4aXVEN0c1c3l5Ry8xVnc0a1VZV01NTTBjY3lrbUIzR0ND?=
 =?utf-8?B?dlRwdEVGNWNHWldWeGRNc0U0MnNQbFpFeTNBdHIwdXFuZ1ZOaGZSdk9sekJM?=
 =?utf-8?B?TXNRQ0xIUWVDOEFlcityUXZHMjVwVnBvSXExS0Q4QjdpMmIxdmgrUWFaVFc2?=
 =?utf-8?B?ZTByc29IeU4zNFZmYVJ6a2l6VmsvQUxmS3RmSHE1dkpRbTdXa2ZTL1RZUmhr?=
 =?utf-8?B?QVI4VUtSV2ZBNTdMaFBqRWd5TU85TWNvSDBidXdlNVU1aTBJOXJYTW85OUE2?=
 =?utf-8?B?cjFJT2lMd0lqRTdNRFN2V3dMWCtUYU1ZNE9hYUxJeDhaMUR3ZllUQkh6cS9j?=
 =?utf-8?B?ZHRpWkxEZ2EwMFNyWSs1RDBrR1ROcktNYkhoWGo4d0ppOEptYkkwb1RJZGRG?=
 =?utf-8?B?MTRLS0RvNzVTSzFEM2NnRmxhZzlXMm5kYzdFWTNJUnZkZHB2NzRmYU9WZDdo?=
 =?utf-8?B?bVh5eTJWR3MxejY3Mjl3eXlsVHpJVGQrNFFkU0g0Zmc1RDU2U0tTMG1iMlVL?=
 =?utf-8?Q?q0OrNWja4+EWdAnMqAsNK7o5e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac767bbf-ad96-443a-f3a3-08db0f1401d8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3957.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:18:01.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edDRm95Knh/GnThLHrD8hMmdCf34i/G56HLCRUc1J84wXzuIj+FWFeBo0MVYAOZSsxMDzRuRJ1YynVjTwi0YOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/11/2023 4:25 AM, Lukas Wunner wrote:
> DOE mailbox creation is currently only possible through a devres-managed
> API.  The lifetime of mailboxes thus ends with driver unbinding.
> 
> An upcoming commit will create DOE mailboxes upon device enumeration by
> the PCI core.  Their lifetime shall not be limited by a driver.
> 
> Therefore rework pcim_doe_create_mb() into the non-devres-managed
> pci_doe_create_mb().  Add pci_doe_destroy_mb() for mailbox destruction
> on device removal.
> 
> Provide a devres-managed wrapper under the existing pcim_doe_create_mb()
> name.
> 
> The error path of pcim_doe_create_mb() previously called xa_destroy() if
> alloc_ordered_workqueue() failed.  That's unnecessary because the xarray
> is still empty at that point.  It doesn't need to be destroyed until
> it's been populated by pci_doe_cache_protocols().  Arrange the error
> path of the new pci_doe_create_mb() accordingly.
> 
> pci_doe_cancel_tasks() is no longer used as callback for
> devm_add_action(), so refactor it to accept a struct pci_doe_mb pointer
> instead of a generic void pointer.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Ming Li <ming4.li@intel.com>
