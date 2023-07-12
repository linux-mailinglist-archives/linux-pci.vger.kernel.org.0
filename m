Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE93750D5F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 18:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGLQDH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjGLQCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 12:02:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84A1999;
        Wed, 12 Jul 2023 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177774; x=1720713774;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xVk4ndNy5jfz4NaHtEA/WxNSVY1z6w7YKUsg2TvMQPA=;
  b=KnycCT8NFXtDH44JIW7suq/YmXyHjG2Pje41Z3MdFaHO6gCzjCGFbgdT
   HiyLxUes5z4ns4kUNk4NP77Ja4Cf8FBWrWroOM+GgZeuPBKyC68CXwB0n
   dAOKo293sA0E5FRc+BRGOSF7blvUd/z5iUWHfEgDUZotfMr+1M+174EMp
   QkUc3x+dAxxiwafNU13Uc/JrHsNUuUe88gPGRRs/T/rcHT8lYOFWebsKq
   sIAnomMBgoNUY/MQW1c9De82hZ/cWVP8YmfMJS7T7mH4149DkSrjGjMS8
   3q2GTo0NiQu0o7Thg+LZz67wIwb6F7C0xkHaK2E1lTqWPl1RU89F0z6qX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="451291550"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="451291550"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="724916254"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="724916254"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 09:02:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 09:02:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 09:02:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 09:02:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR49gJFvcW4uFkbxo12+NHIogDReKqpSG24tb0zdQc1pq1I9DyEtPqZDyoz6Ed1mWtXqNJCFgPbnKfu3oB2UG5AgTZ1rD5BxKjyGln9bL9h/Cg0JOHOcnvE6gxxjFUNQwd2UCnWqKykJUJ3wK5iyxr5A+kwvT4KvHcDu33r6sHF+csZ90BmNYok315MvFGd8tQTN2qijyTwFTCubn+4MsEJQtprLJZYWSqjqq2zQV1IqbXgQ/q+vfZuIGshVzZqlSXsAmBIkK5wI0ZnTZZ23ZX3T9r5F9Fk1pLj6YD78g8003k1yFCnhZsFdQRpYpQRpCd7uMvus/qv1opdaxbcKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JpXmg3tolbzfYayAfjFEeyvFX/NFRRn6ZvgHtokLLo=;
 b=Atr96xOIZ7v68+4ydUobBmABu7kLz1MlvIp6HDBbeJIYd/1l1f3wi7m+1fTye+7EC+CX66Q3ze5ik0Xcqz7Hk6G09pg6xGB5MAhVK7k/tgPQnlpCQZo4NOebKUBehBr77Yy0tuUzhjh8jBszUXz6efHljzyn29g7rzVN7S1fyvOR/GGKB398y5Bb0GBqVnL9QFS0B7NWpAp/suE4cIMvo7bJya+RT/oGxYVO2nFwURpXgXai4L2G01gvxwmcCm5JEg/dyTpiU7XaJeSRjy4i2sbpV6d0uIPRZAcFckprdpTvQtWcyjwxY+TyBue+6YyJ1y904VDj7mHOXQM2vCq0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA0PR11MB7305.namprd11.prod.outlook.com (2603:10b6:208:439::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:02:17 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:02:17 +0000
Message-ID: <99c45b95-5da4-8eaa-05b8-dfc4c1e15154@intel.com>
Date:   Wed, 12 Jul 2023 09:02:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] cxl/pci: Remove unnecessary aer.h include
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20230710231416.232751-1-helgaas@kernel.org>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230710231416.232751-1-helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA0PR11MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: b78935f0-c3c2-428c-ce2d-08db82f15d8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kZCW4l+QPoZgUQ9tmutkAfml2UZb2BIh5yw7fma8xsa3yiLmpFOqwlBeYu+dRYS+Io6sU3r9LyHvSA3W7gZD+IpVDqdLdRcFGSNR9IU4qcxSfdMGY113zfM7yVVAZtm7Yk4ArbLRpEz89kL7wbcePONDOV5Uy7QSLvam0nnNkZDXOg4+DStaqtnVPTWtHEFZCY+WVuljOw0MhTzbgKhasF04fGj4tPV9cJT9uCg0B7HN69/1k+Opzdwrsmx7jiQOrRDPxnY5nKJqE4Ak2Ape8TeOlAHd9RpexWGIbyPWlN4K/5dakxqZQkRC6tVotSv6ySeOp+64EmW1162uI40/6K3Hse7XWSAgcweJ5n0U41UNNTg312z5M740ryQ1mAJaQDdZeO8bHP72MhbacMsjRNN/QncmXE9zkRK6tdcewvczYkPHQ3woxWO3ro1wV8H9zRCFh1J+SECvg77NZGMeUCOlVHAaQ3RzBsKYJNYIoiZclkDl7xAx3FCyOA6IioXBMwT0hajZOIiE4C6dHunmnhm7466uhMKpuOBfa7Oble5WVak/rCHTu81J8NtTZ3VtpCtUaXc3BIzoMIZvuPjW+LSeAtqqhryup4N2n7HmG/iUnsgl3eG9IIft2SVaMX94sG1mpPH3RnOqEJ3hZyXZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(66946007)(66556008)(66476007)(2906002)(316002)(4326008)(83380400001)(6636002)(6512007)(4744005)(41300700001)(5660300002)(36756003)(26005)(38100700002)(6506007)(82960400001)(8936002)(8676002)(31696002)(86362001)(6666004)(478600001)(110136005)(44832011)(53546011)(31686004)(186003)(2616005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHIveXVXUEtuOWo4M3E1cDZCbVo3emFCVzdyUnpueWhCdXRya1UycjQyNFBV?=
 =?utf-8?B?dFVSb1BHOGpGeDBNV1E4V0V5MWFjODhzVHY3KzBqZEdOdWJ1N2hkOE01SEIx?=
 =?utf-8?B?clpuS28yZUJSdldEdTd4M08vV2dzbE5QNlJYOVB4RVpCS2hJVFlPTDN3RWhq?=
 =?utf-8?B?YXoxZ3BKSGovWUhTa3RLV1grQURCRTlUQWJuemVvWS9oYlB1cHFqcDBmV3Nj?=
 =?utf-8?B?Q1ZVb21jOE9vUXhnRXFGOWNUSGJrUm1iSm9ab3dFZ3QxS3VnSmQzR1JKb1JD?=
 =?utf-8?B?NktvakxTdHVVejd0Ry9Sd2VSaG00QUkwckhkVUw5SjQ2b0JreHFPd3MzT3FZ?=
 =?utf-8?B?MTBxeExlaUptRG5pb2FNbkJpQUJGSEkwYVdvU1UrQUp3YVNRZERKMXF3VU1Y?=
 =?utf-8?B?YVZlTGJyVlBmUnpkUm82cjNwNHBTNGc2ZlVxaHY4bFF1ZHhaYVhKQ2N1YUpP?=
 =?utf-8?B?ZEJtbjBvYmdITTY2c2V4R29QNFZPZEtlMTZONmRpVlV1Q1Y5dWw0T1N0czdH?=
 =?utf-8?B?ZlRMQUJzVnhCb0JLaUFpZkxnTmswRDhMaGE4V0dBaGlSQWhUMmwvemE0NWdy?=
 =?utf-8?B?akpOUmtnU3hTelBxeUtRdVJmWnpRYnVtdEFkTDk1REhwbUNpaHhoQjJQSlZh?=
 =?utf-8?B?amhNMHgzZWJhbVVudzBJa3Y3bzVCOUpXOU90WTZYbXI2YzJWTlh0aFdkb2dR?=
 =?utf-8?B?c01VcWpPWTNoV2NCa1dBeHp5UkxpbU9JM2JOcGEyWnZadjUyMkxPaE80OHBm?=
 =?utf-8?B?djduMUtncGxENUhmUnpUNW40TzBwQ2ExNElDSUY0MWRrcFJrdlNhVzJhajZZ?=
 =?utf-8?B?M3pWRkZZeHhEKzNkeldhK3ZFZnM3dU1HZWNtUGl3djRaYk9ZN2U3ZU1TaXdX?=
 =?utf-8?B?U3QrdHFDL3hqYWF4eU5pekdTWEVMMmxXU1hCaXAweTJVTEJNb2VadGo4U0pW?=
 =?utf-8?B?Mi9iQlV1SXlRbHg4NU5NUEZyVTdSK0tJZDN3VkZNR0lHZ0MyUEg5bVF6WjJO?=
 =?utf-8?B?T3ErUjRqWm5jTUtTb2FTT3JydFFqTnJFK21yd20zeXQ2NVJoUk92Y2c4ZE1p?=
 =?utf-8?B?UExCQjFzSTFPN3dZYzdjZ3k0ckNNVHpmaHg4cWErWmMwajFiQ2pWVUtPVG01?=
 =?utf-8?B?aUNIWEMxSnpWa25JRExuZkdheDA0eU90QnJCOC8zdDZ4cWJydEZtNHZaUmRl?=
 =?utf-8?B?bkFMeVBtRFo1cmt2YTJnUHJyZWFoUWJCTUtkUjlVZU5Gc1RtM3YrRmpGRXNW?=
 =?utf-8?B?NWNoTkU2K3lUWEVvZEJHeVNKeWdMd1FLV3FYanJRVFA0SnRnRDBiVk55NlFF?=
 =?utf-8?B?Titna0lTSS9EVkRqUy9ZY25rMi9VZE5lR2dDRjZpMmRubGRvL3I4QlFlTTRZ?=
 =?utf-8?B?M1QzZllaWlZmbHVLL2l0TS85NVRkQmI0VDJYRCtlNC9PcGNoTDN5Y2d4NXhw?=
 =?utf-8?B?a01YL3FMYXlQN3F4V1N4MUNHRDlhb0EybmJZVjQ3dENjOWFoYk5QZTBwL1d3?=
 =?utf-8?B?S2tWdG1lbmNIMFlHY25uNnQveWxkY0VoZDk0Z2kyQ2Vaek83YjRvWmk2SVJi?=
 =?utf-8?B?VWpodTQ4ZFhHak5XZkdIN3o3eUN4WEZ4UGx6aGs3Q0xWVXJaSEZvYUZVY3lL?=
 =?utf-8?B?a2pvQ21DMmJLTDEwTXczMHYrNFllM0d6Q3JMWDR6QVdNS2NVVzNMRW5ob1lw?=
 =?utf-8?B?ME5hOHpFRWg4L254SWEranNZK2dCTVoxTTd0cUZ0MTZxSXBwdnFBSm1VRTlK?=
 =?utf-8?B?WVN4SnZEN1RrRjNrZ0tmRWNsMlF4elIzWW1hbitwSW5lNFU4ZTJwMEg1eWJR?=
 =?utf-8?B?ejdPZmV5MUxwelhSbmNjaTZrY1JkWXp4bTYybGNLVkgrSlJ1SXI5OGVDU2dy?=
 =?utf-8?B?N2htUEF4SHRLRUF3RjJ2TWJDaXBaWE5xT2tVYWhLajExY0hsc2FRZ2lXWXZ4?=
 =?utf-8?B?VnBnWXV6L3g5YXN1SlFBZlI1U090OHlERFBxdEszMWYrYmFYcWVRc3htckU2?=
 =?utf-8?B?aHJGeTRMWE95OUZ2NDRYMzZWQy93eEN0cnZxdzBEWDBFNHlRSXE4Njc0bU51?=
 =?utf-8?B?RjVYTlJWSGE4ZlNLM1dacGh4cWhXVHl3amFSSHEweXdWVkF0TGdncElPRGRj?=
 =?utf-8?Q?iZ5pH0h/aBj2OfUPEFFWYL646?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b78935f0-c3c2-428c-ce2d-08db82f15d8d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:02:17.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4a+EC+6UDXpjPnkSIhK5Sg6MKraCvDU6NFVme2ww4JJUsb0rjT0A8YxKf2aOEBQPtsw4Egzcfz07RMvgmosQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7305
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/10/23 16:14, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> <linux/aer.h> is unused, so remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/pci.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..8314cf2ac16a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -8,7 +8,6 @@
>   #include <linux/mutex.h>
>   #include <linux/list.h>
>   #include <linux/pci.h>
> -#include <linux/aer.h>
>   #include <linux/io.h>
>   #include "cxlmem.h"
>   #include "cxlpci.h"
