Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5680F4DE1EA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 20:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiCRToQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 15:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiCRToP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 15:44:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B52AE10;
        Fri, 18 Mar 2022 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647632576; x=1679168576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TxCcNRDvm5y3Bjo04hRUE1vAKhG1uxd2YIWnzyV+wJo=;
  b=d79s4+oCUQTU8e94bDev3m/ZZMWLh5a0u4uIGMckoE/Kn759boHHLt3z
   BnAOChZc5eWcxYb471grDoB7Ps+b+DhzNxViPEVHY5jtk6DZmjKlU83iN
   3chyeGd4wNdqJx0J8OpgdA70dFw4dcfIXYUtJ1z2FNPAoEB51ZSvY+6WR
   PcsPvKUpY1BOhngfBRJeFfDdXKEs4oprDF9Yi6fLTQSI69zYOnkIc/wUT
   7d0QAA3FT0VwuDtI5YH9C+GUQ2saH3LE+yrsiSNEXOxx5bFxHkbOspdJx
   Rdh7Yox6Jth3PYsXKHDqZNH4UloGbKJ+ru4eVoxHGJaniWOzQljswzTRR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="244685485"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="244685485"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 12:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715622268"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 12:42:55 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 12:42:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 12:42:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 12:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIYdbd7PE/VRjBzLaWeiG0gK+3SGmvoUVEeBLbQ2kKH4Ebi7gAMNFqqBvpz/ogn411XUPcI8GG+yxk5zfxGhoG6VNvRFJ34L3GQcjD5GbcSH/jHFeRR1C6v/ZUHGqJNDNKh+gRbR3Wsa7BYVPFuSdfRyAswnyQiR3WN7IHB8qDnSnN4AAu84361+GliO5uyOv7DVDo3+76Fw11cVsc0NCUVWhQ4spJ6D49+RRdlN9WB/RlSbxS6hmdY9CdnzrkimBOXAXIrboOhsnh5r5AQPJIzHihpe/v8TDGgn5KHSVbPyQWKHLB/hSojShbQ1K0IWI/KpK5rNOu+7Y5dKB0eUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh2uqEBADpIJmwQ8K16fqwDlTjTZsCgA8Zf/vXlSQys=;
 b=ByP9gdTcBvAWC5nDE9Xwuvhv64kbBdK6QyddJY4QXfsa+JE4i3dIpt6vab6XbvLfTbnlluklbindv++kvDXMzIQSr2DZcEvLcEUSA28xpn4MEJlsKhehjTxszKAZodvLVTcMJPf+QoCga66CRehdscEGYzMfDwgHQAy8B9X9AlOkGLBYytnXNX1fJmCqYMEK5JVVCXbQLXZSjF4vaBbkljg2PGM+HZgf05v+N+T2v7t3xD4pXb+ssRqx4/jpLp2KzAUy8vT9voELt6E/UuOp8FvFk9+B9/3AjYrNNbodYy8uxxc6K4Nx83KjwkiBt2zsDJ2RgSUZK3C44ZdoIclEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MWHPR1101MB2254.namprd11.prod.outlook.com (2603:10b6:301:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 19:42:53 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad%3]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 19:42:53 +0000
Message-ID: <fb1a6cb4-1a75-d28c-09e8-5561a84198fe@intel.com>
Date:   Fri, 18 Mar 2022 20:42:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Content-Language: en-US
To:     Rajvi Jingar <rajvi.jingar@intel.com>, <bhelgaas@google.com>
CC:     <david.e.box@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220317233153.2617938-1-rajvi.jingar@intel.com>
 <20220317233153.2617938-2-rajvi.jingar@intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220317233153.2617938-2-rajvi.jingar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::27) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83e0d58e-3087-4aee-5dbb-08da09177e2b
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2254:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1101MB22543408DF87F1BB415A2256CB139@MWHPR1101MB2254.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPsPByJ7m9XB24G2Ic+HykDNFdWUkT3uK4HNoaZYsnvcsHM6Q123MAOUQTuZAqNZWd8X6JYWU/VAl1apLnndGyoUURtVlSov4otA94TpOZYBNWxelk1mmtkV83Wr0CanH6uPEEE3Uy0NhNvqzVuUbJhoQ4ciKQ9g+xOskNm/mSNl1+zPKNMOqK5CWvDiemByB4fwi40hps4jHkxhn2N46bI2/oKh9CbmI4jkNM119KqQ9x8trnUW0AcAq6f2O7gFlTN/QHMeJroh/lxfmGc/OZpI19l+RDqP2+LHd2uZOu/W3bU0M6zR76DRYv7fYydyllWs/GutPfo2KindWgusp2QiI30a7EthG1I5eAiyq6YMRUqvydphSu2SMcZxyve9vZckkCEihehlf4cNTGlBELGDgF43Rs+qk2MtxM8pVOLqvhSYM6qP5YJnTR5FlZAhcbyv4pg0WilbLl67qWF+04zJgOo/sJh3QVUDd9H9KYsTTiNackyqGxjeN2FkNaBId/q9Oa6SgDvTblYFQEyhFIbnilFl0MYT+IRsRLawg+RU1Ou4Z1k8CCdGUVdVBpY7yYanjNtN2XjUDdajZ2e1hnQyccTXL1XmbBalE0GqhVe9R0uYuToFTWWi2kKzrqB//HAuRGHbU/F6uE3tZkbG2b0vy6gu8tM58ObOShPi7zTIAJUBn92RfWK06KBVWU6tkPewPVeVz3gzuKGMXYSG/nAxsVocg5/0xK9x6rbJS9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(53546011)(36916002)(186003)(8936002)(83380400001)(6506007)(38100700002)(6666004)(6512007)(6486002)(2616005)(36756003)(508600001)(82960400001)(31686004)(8676002)(4326008)(66946007)(316002)(2906002)(66476007)(66556008)(5660300002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2l5V0F5UkdMYzg5eDZvK3RFVnc4UzFRQUxvL29TdEoyQWZ6MlliL2svMSt5?=
 =?utf-8?B?cUNzcFJhbXUvVU9URnRwTTFMeFNOc25sQmY0dW5BV21oQ1Z5N0gyWERtZitj?=
 =?utf-8?B?ZXQybG5ZYWdESXU0cUIzdVg0S2taa2RQeTFVODVDanNPbnRNUzdybnZEKzdz?=
 =?utf-8?B?NHNtbU5Zd0JqL1IwOWVKb2VDWHpNTUZQdUJKb3hPRnIwU1BOSi9tUjY2dFI3?=
 =?utf-8?B?YzBZQXVCM2J0TU1uMk1CazEvN3lOejJ1aFRyQ1E5UnhGbVhBYnlNakRWT0li?=
 =?utf-8?B?b01nRTltTWY1dFB4UHVzK3pUZmM1clgyajNFbmVYQXRyRzRxeE54MXM1ampi?=
 =?utf-8?B?Zm15dmdiNHB4T0NqTDFHNENPUldacmY2VzUvd2N4dkVTQk5TU3o1RVRwT3F4?=
 =?utf-8?B?cEljclo5NnYrdkN5SkR2bkJYaDFDYkVsdUVsNXUvcGpodHl3RS85UnRyR25u?=
 =?utf-8?B?aW1CUUU3NEJDOFlIVmdPdXgxaGY2MFZyMEpuQUs0VktXZWdvQ245ay9ZREZR?=
 =?utf-8?B?dWlINFEwNG9LQnlRYU5MK0FsaFU0UmhyNGthRmdETHZXRTZmc2hPKzVjZkN0?=
 =?utf-8?B?Z1F2dm5tT0ZDVk1VV1owd1daYnJ1WlMyK1IzRmwzQllzaURDQnIxZnRUUDJk?=
 =?utf-8?B?VWdEeno3TnVobm11ZHp1MWN2Zjl1bWNrZ3c2N0Rndi8raTlIVDBLNnovSlpI?=
 =?utf-8?B?dXR4RTA1enEyS2I5KzV5QmN2UHNwNmIvUW9aZCttTUVzdHoyVW5Hakh3M0M2?=
 =?utf-8?B?aTNERUEydlJJYk5vWDhhMkVKaXNyZjZVMjNXT3g0NXkrdUhlc2RZY013RmtK?=
 =?utf-8?B?K1pjR0d0UkNoSGdPVTJ6UUk4bUNuRXZyMXIzd3hrSFdlY21zbXkrSG9oK2RP?=
 =?utf-8?B?bHdST0E2emt5L0RDNnRiZklRWXRNa1JwNTVuWGdXbVdtV1VzU09MRzVtd3Fq?=
 =?utf-8?B?MWl2YTlmeGtManFQS1pOd2hoU1VFalIxSmN3b0JJU2xBNGhMWUlZZExhdStt?=
 =?utf-8?B?aDhxNTloTWZ0SE0yR0pyRDNlN1FTckh1eGFkVDBlUi9qNjZTckdJK0EyWWRE?=
 =?utf-8?B?UGJ6MlNwL1RIbHhQUEp1UnpJZXByNWpkVkxsME95RC9TVllCVmFDMGFSd3V3?=
 =?utf-8?B?NDBkRGJhSG5TbkNVbHUxK2JQaVlCTHpoa2QwRGVkMlIrMnR0bmZuTnkyYnRs?=
 =?utf-8?B?UTU0U2JjQTdVTEVoclVXMjBHYmhiSVYyM09MakpMNVN1dVhCSTFDZDdSQnBh?=
 =?utf-8?B?TFJORXB4SFhsbFptRmR2L25uVG1XaWNEK3NIR0RVV05kdDBwYzAzcVNKRmJJ?=
 =?utf-8?B?UUtCdWdwNHNGNUdLK2dDdm5aVno2d0tpWEdMZURjeGYxTldWUndadjk0blhm?=
 =?utf-8?B?UXJzeHcwTjJ6Y0ZRbnpESkFUU2tXL3R0eHZoWi9VWnNtRFVTbUtWcnZLNlZB?=
 =?utf-8?B?SjloK3MrRGFETWczMk1TUWQxMnRZQm9FMkVhRnpCMEFxSnFxSzNRR2ZZTVps?=
 =?utf-8?B?MkpWdEl5bWlmb3BIeWV2OXg4Um5oZ016OVh4Y2kzaStWRjVHZ3UyY1BQT1ZT?=
 =?utf-8?B?c1k2eTlyVkN4b3FnbUFKdGV4bWpSdGVwZy9JUlBnd0YrdjZpWTl1anZOYjJP?=
 =?utf-8?B?RnRJQXpkaDNCTnFTenN2Z3NCYkZNQlAxKzBGamtBRWIxSVFhcXZIUkhSbzFH?=
 =?utf-8?B?QmZCUmRDYkpjcUtEY2FkU1ZLMDVZOHQzell0cll2K25nNmJFZmhCVXU1SitO?=
 =?utf-8?B?ZEFkeFBYcXluaUtsNEdHUy9oS2pVaGZIc0c1Wk9ucWpncWVmNVRpVmRwTEkw?=
 =?utf-8?B?aGQ1emhyWmRQWHBsZnFPdXJOalRTVnU1d3BNSDY5anVoakh0N3dDYTJNRUll?=
 =?utf-8?B?aWVSZEtmU0p6Sk1vN012Tk9zK1VRT0wrcjJ2ZXRrMENIMHRIU3BxOGZuakpQ?=
 =?utf-8?B?NUZOQXpDKzI3WFJEZ0d6dHJJVWJIaDBRLzlnY05jd0ZXelh2Nm1QZkh1amhX?=
 =?utf-8?B?WU5uMFE4Q2dBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e0d58e-3087-4aee-5dbb-08da09177e2b
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 19:42:53.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGBEjoWx3RO1h917vMbFk9Cu8tq/oWjq8rqy7W+Ckqi46y8KbUmgZ2v5j0uSlhshuyDlc+Y7bZaM/59nijvpx2lpHSHe+DDwtsvzGi02egM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/18/2022 12:31 AM, Rajvi Jingar wrote:
> For the PCIe devices (like nvme) that do not go into D3 state still need to
> disable PTM on PCIe root ports to allow the port to enter a lower-power PM
> state and the SoC to reach a lower-power idle state as a whole. Move the
> pci_disable_ptm() out of pci_prepare_to_sleep() as this code path is not
> followed for devices that do not go into D3. This patch fixes the issue
> seen on Dell XPS 9300 with Ice Lake CPU and Dell Precision 5530 with Coffee
> Lake CPU platforms to get improved residency in low power idle states.
>
> v2: add Fixes tag in commit message

Again, please move the above line after the tags below and add another 
--- marker between it and the tags.


> Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>
> ---
>   drivers/pci/pci-driver.c | 10 ++++++++++
>   drivers/pci/pci.c        | 10 ----------
>   2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index ffe76f238d7e..228d21700825 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -836,6 +836,16 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   
>   	if (!pci_dev->state_saved) {
>   		pci_save_state(pci_dev);
> +		/*
> +		 * There are systems (for example, Intel mobile chips since Coffee
> +		 * Lake) where the power drawn while suspended can be significantly
> +		 * reduced by disabling PTM on PCIe root ports as this allows the
> +		 * port to enter a lower-power PM state and the SoC to reach a
> +		 * lower-power idle state as a whole.
> +		 */
> +		if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> +			pci_disable_ptm(pci_dev);
> +
>   		/*
>   		 * If the device is a bridge with a child in D0 below it, it needs to
>   		 * stay in D0, so check skip_bus_pm to avoid putting it into a
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..f8768672c064 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2660,16 +2660,6 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>   	if (target_state == PCI_POWER_ERROR)
>   		return -EIO;
>   
> -	/*
> -	 * There are systems (for example, Intel mobile chips since Coffee
> -	 * Lake) where the power drawn while suspended can be significantly
> -	 * reduced by disabling PTM on PCIe root ports as this allows the
> -	 * port to enter a lower-power PM state and the SoC to reach a
> -	 * lower-power idle state as a whole.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> -
>   	pci_enable_wake(dev, target_state, wakeup);
>   
>   	error = pci_set_power_state(dev, target_state);


