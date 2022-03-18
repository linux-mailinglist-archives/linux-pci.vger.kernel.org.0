Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35E4DE1E7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 20:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiCRTnH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 15:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiCRTnG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 15:43:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D008116283;
        Fri, 18 Mar 2022 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647632507; x=1679168507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/EP6Ub8u8bfGmAw9XaMI1E9cBQohKseqgdGFAIKROeM=;
  b=dGyY/JCsIgXPPlSwm6coGLK9OaaDbcMUHaL4o1jjnIr6uamla8eKGjC+
   9PVNEHJlfJS7ekc6MxzAff+KCm4FiXi/XIiPY5PI8DP1VtfIlasAOVs8U
   agQCoZKqqSrYKfxEOhErzqKoPHtGB+szEiHhYDd74rex+6MHGTkUCfz8/
   cCCbG7OPID1RWvbon554qQCb/j4jcioIe55eGSDfHA3ISnh6QOCD5Ean1
   VtKO8myOfnhH23it0b686JThrZGJeVIuEEgKbNY7hR8EIR3rZWW8r1q2+
   XYfsL7sbHGJ9BkPZZ4l/8azdGHBRU/N8DELx7wmcvrIhqG2BPtubW/R1H
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257160411"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257160411"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 12:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="499362941"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2022 12:41:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 12:41:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 12:41:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 12:41:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 12:41:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bafE6DWVn0P3Tmee2yBhFz0iylzuAR+C3maejPb6QsKiWAeLWmgB/ZyP80Nh4rAXeIN9kpyCZXRXzn9uxe9NS7k7YDWC5soiYxVRw6N2bMLQDPBXW2wh9dSw29TGhnzLYviqBfypIVnxJcfPvd4P9M++CembaFG56ILLwlLNp9TdIyHqVyhLR42mqgykqxifA5iAv+sFBS4P5SLjyAAxbZ2wMHzN5o2j0K1OAupC+uYFb8QgBr5s0TXIxuSXufDMQoFs7y96Ppt7ZjqVYnzJ6rMCMgfhDgCzEI1/FiZyUQdyILc1PkoeNR6k4tdV9cbuzZD/+wZhfADlZUv7IeuccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toy1pun0MCk5kWkKOiWiJUsQji/jGokRh4ph3tnTPtg=;
 b=E/CtY765wfWZuCz6Q30wyTXs/JSKzjtAYtazg2tKa6qH87Lmg5r67bT/u9fF2mS4k6hfSfv4AdH2FxayKTJSDlFZE8hP1DsVQULXABiYdvyrHUnvyYAwDi5VNDo6sfRIpkE0g1GCLHee3wnguuph7+cpkJE46SpnY/OigTXEgPPWpxARGsoqa2Xe/4Z738y+uZt2YHBfQ/zOR5qtG8WoNCInMy1gQS+cpGI5cQp+kIRUT2HFUmBZWNGHsvdnfp/Sgcen48yYzxkqBag72mrvuO7/FBs4g9bk/2hYguIghjXoZbPAicd+nx6BDxnUNYqEQptlFbwSLieLtvVBrVLZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MWHPR1101MB2254.namprd11.prod.outlook.com (2603:10b6:301:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 19:41:44 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad%3]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 19:41:44 +0000
Message-ID: <db78875c-c199-c442-eee7-a2a70ae7606e@intel.com>
Date:   Fri, 18 Mar 2022 20:41:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Content-Language: en-US
To:     Rajvi Jingar <rajvi.jingar@intel.com>, <bhelgaas@google.com>
CC:     <david.e.box@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220317233153.2617938-1-rajvi.jingar@intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220317233153.2617938-1-rajvi.jingar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::17) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cd31ce2-1bd2-4ff0-aa48-08da09175498
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2254:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1101MB22541317F6AB434680102045CB139@MWHPR1101MB2254.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzJBaSSF9x3fn9YGI3BaZXq4hMrukdgdomrINCiQBBWWkdkQ3uQxusBrYS1sSvCpzLKhLvvdXSR0GpIFwAbHCqR+LjVVOqVWCt0TM+HemYXiEeHZR5ecHrD/sNAHD80CXH3P6UdC9g39niGauiXt+QLz7XXaazSKxJTv27RltzysT0WVuRPvveP3WS+bDrr7H9ZhKce0WCrr+kpBUYKNIs4TMiU+JL7c0w05xllzV2s2a69Fa2WIMAsK1waNa8VSgGz02hJ/tO6tD3PRsNyFkF9v5rtEHbLXmaoUQ6j983VfVrOT5ChmhmASvqOpOrhzy0nB02oxsUIv13Apb0AsrNa8QFh+BPJwpbFcioIxUH0YBxsMSrBkjMEQm4rHWn8JVJzI40j7dY5UIHnRwLPvvB0+R2890+CFiwV0jypAr2D/ELWelPqJrcvLPZgJwSIQAbMHOQRSRkdAWs4zYXbPIk1e4otgND0l1YFe74A2Rtfn+Bm5KXQRQ0TxFgkIT+RasuByKtRpU1eRk+dnpsK9lJhYVRQEKGD8yJAuNLCAyO2mxVqCMNlMQ8XHkKV3vi7R5xaS0406i+KDVtD3VNPIydIZvCIjbpS9aRFCwJ5VL1tuaV7WlR/YJBsccoVQbRmHQjBIv9DoP6h7sT4o09N3dDZMLGrGDqrUHkjcQKY9oLcKXIug2FiCSL49Y1y6uu4HK9B1IF5w48y4vBTCLP30P6FueebdEkmaNKVcAdbZnVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(53546011)(36916002)(186003)(8936002)(83380400001)(6506007)(38100700002)(6666004)(6512007)(6486002)(2616005)(36756003)(508600001)(82960400001)(31686004)(8676002)(4326008)(66946007)(316002)(2906002)(66476007)(66556008)(5660300002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEpHMkw0azhlQldnVnpLTUhaVGpEUWxGZzFFT05RYnloNlpNTWlUOGkvcndB?=
 =?utf-8?B?bU9UNEVUZUJHckt4TldYK0ozeGxCclMzR2VYRTZzbWhIQThIV3JkeHhVZGZT?=
 =?utf-8?B?dzBwRTE0Q2c3NnZNZnNJelAwOWZDM2tueXVudWlrVDBhK0diVUZIaXRGSzRm?=
 =?utf-8?B?OUhHeXdONG55SzFoMi91YW0zZmI4QVJQdDZybSt6VVVidU5UNUdocjRuaEFG?=
 =?utf-8?B?VVJ4YjhRTjBpNkpncExwZ05CeGtHV0VhT3BsM2t4dHBBNHNnbGhTWFRIb1Za?=
 =?utf-8?B?M3hxVjJLNWU4N2ZQR2hSYmN5b3RBT3RSQm11NjFNcU5JVlRsc2hMMHlza0lo?=
 =?utf-8?B?bXlpYUFwYjhCakx6VGFJeS9BcjdZU3d5UFRXVWN0QUVkb1VwOTd0aXYrd0po?=
 =?utf-8?B?ZTNkU3h2WWZ3bWNCOXExRTFRYncrZXlqakw1dEVqY1ZYb2Y4ckZqVFlPT0JJ?=
 =?utf-8?B?RHA4SlluaGJYUGs4M2R5VUFDNXhPVUNqMURzbFRiUjRvWGVCSjVCSWNRNEt1?=
 =?utf-8?B?cmM5dWc3NTQ3MkZWUThUWjAzWGlnWVJBQlBMZU5TdU1CS1pVMFc4cUw0bUsr?=
 =?utf-8?B?WkY2ZFdlQTZYdmhSVGlPeE4zT2F2M1crOXU1ZGFyVkpkeVlpZmJrRUV6SElF?=
 =?utf-8?B?SjZYMXZJL1YzcEpBTzJsT3BLbHBHekRCMXZjUDJvS3JpWktsRGZMUEZCd1E2?=
 =?utf-8?B?bW9GUG5NelJqS2JkenA3SVQ0Y05MUnpSL3hYVUh0TllnVFo3UUR2RlVxUS9F?=
 =?utf-8?B?aWZkWFQ5aGl2MzhWUnVHblp0RzF4d0xaMXduaXpCWWpzTHZWTE9nMFFLa3Zp?=
 =?utf-8?B?NFZkRU95OG5Od3dHSlgybmhKNTlHUTJXemYySTNDYi82dHhTbXliMVp1alhO?=
 =?utf-8?B?NkE0dHhCU3E5TkVGazlZN0xvOFdaNmIwSkNwcjRBZWc5QU1YejNzYzZab0Zu?=
 =?utf-8?B?ZTRJbjZQUkZHUFRBRG94emNheFoyak00dkNJTjYvZXd4ZXl5TlhjeE1DQ0NJ?=
 =?utf-8?B?M2dhNi9lSmJoUXlkUGZXRmhpWE1NREU2UUdybTJONW1DNHNONUpwc2ExdTdP?=
 =?utf-8?B?ZTJmWGFEZ2x5c25mV1c0VDhFYUd6UmFldzU2TXpvYTRhMHJYTWF5SEdZY0dh?=
 =?utf-8?B?NlgvNWh4c3BlSU1KZWVERVFSdC93MWw0SDBEQWpUUkUyckdNQXlRcUVzQWhz?=
 =?utf-8?B?TlBwV3AxUUV5QnZIRndSdXgvZE83dlFWcWtqc2w3UDY0UUJvSkppcXF6WHdo?=
 =?utf-8?B?YWlsNWFSK0RGcU9Ha1VVdFRDdWYzaUhxYVVTOFFVNmgwTGdvYVh5UG1UbVBz?=
 =?utf-8?B?K3p4elY3aktpM0hJUDR4V0ZVLzZ4RHlKZFFpNUJGWHZ6NGQ4NkIwTm4wd0NC?=
 =?utf-8?B?anFmYnpWQjhKb2hYOHdBNzRDRllnY0NTR0ExNjU1SkJjTFdwVmI3TlpYOWtT?=
 =?utf-8?B?bW9HTHNIeGVqQlhKNE5TZDJWR2hlM0hBMm91NWdkOEp1cFNCbHhOcTI1Wk9U?=
 =?utf-8?B?b3VQcVNYSDM0bmx4V3l4citQOUxvVlhCNUx5QWx4UVYyNGZDZDluelg5YTVv?=
 =?utf-8?B?NGNBUEhMTlBpOVo0bW5NV2dHdk5xbldYcUlUeGVObHRFQjJDNGgxVDRPTDFZ?=
 =?utf-8?B?THVHY1oxd3luT0RtM0NsbDRpOVU2ekJXc2p2UVdyck0xVkhZb0xZYjh4MGdQ?=
 =?utf-8?B?L2FadnZMVytSRXNFYWRGVGtTZEd4VWswZnNrVmtHNGx5NlZ3YnI0VnRNbjNV?=
 =?utf-8?B?RXgzUko2Zm1OTkFheGgybGtCbFdRdnZaaEpQRzBPd3QxNWRmWnFNaXBNMjJk?=
 =?utf-8?B?RGd2VVp4NG1VeE5qTVBRNlFnNW8zcjRCUGt1b3BxWE1BbVNDc2FheDhOK1pZ?=
 =?utf-8?B?cytPNHk2dVpmb2lQamhteHdrOWl3RzZuSytRWUNVWHVCNkxGQkkxVmVQMjBz?=
 =?utf-8?B?MmoyQjNFeUMvNUVGZ0ZaS2d3a2VFZXMwZUhxMkFWRVRqS1ExNlNLaGhHQ0Jk?=
 =?utf-8?B?bFJFWXFERzF3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd31ce2-1bd2-4ff0-aa48-08da09175498
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 19:41:43.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjchRU4Z6kC75eDODjyIdBpI1vf0cdLbgaV5DYaMYF95QVfOKt2aBSWGAX2C0GN6dCJwi6CgeRuEfT6XMLZ3hvnqlLr3L6eGFv/IxB7fatM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/18/2022 12:31 AM, Rajvi Jingar wrote:
> The state of the device is saved during pci_pm_suspend_noirq(), if it
> has not already been saved, regardless of the skip_bus_pm flag value. So
> skip_bus_pm check is removed before saving the device state.
>
> v2: add comments to the changes

As mentioned by Dave, this shouldn't be here.


> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>
> ---
>   drivers/pci/pci-driver.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 588588cfda48..ffe76f238d7e 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -834,20 +834,14 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   		}
>   	}
>   
> -	if (pci_dev->skip_bus_pm) {
> +	if (!pci_dev->state_saved) {
> +		pci_save_state(pci_dev);
>   		/*
> -		 * Either the device is a bridge with a child in D0 below it, or
> -		 * the function is running for the second time in a row without
> -		 * going through full resume, which is possible only during
> -		 * suspend-to-idle in a spurious wakeup case.  The device should
> -		 * be in D0 at this point, but if it is a bridge, it may be
> -		 * necessary to save its state.
> +		 * If the device is a bridge with a child in D0 below it, it needs to
> +		 * stay in D0, so check skip_bus_pm to avoid putting it into a
> +		 * low-power state in that case.
>   		 */
> -		if (!pci_dev->state_saved)
> -			pci_save_state(pci_dev);
> -	} else if (!pci_dev->state_saved) {
> -		pci_save_state(pci_dev);
> -		if (pci_power_manageable(pci_dev))
> +		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>   			pci_prepare_to_sleep(pci_dev);
>   	}
>   


