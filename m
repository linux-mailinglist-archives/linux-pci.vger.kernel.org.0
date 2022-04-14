Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36815501A8D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbiDNR4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 13:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbiDNRz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 13:55:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BB2EAC90;
        Thu, 14 Apr 2022 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649958814; x=1681494814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LK4JH3As/zR6osqbE8lB+NE7OpDoWitZDGvuM72fZjg=;
  b=SVOoYN5NghsMlohDcdx8sBGitjVFzjejC/2yLY74RhD/uaWiHQue3OJL
   U6r5GGKOBhtZZ2OxtSpWsEsdk29uGCqOlfj0kWEDOrMifhGMLhiULhkAn
   Y48x2CjNi+69GgYCIRGG3XqUOcF2IxFqXmXMXTQ5dAReYdpXiBkdhs/EV
   8ZqFc7CyyTi4KoP2bXnkRg2CIAzFX8PTDn6dltblv0t/Ogft0WBkap01F
   fpu04AOKMEh26aOxa07cBSbdv4sXHn3t1SEdg8JDl+WNJtgaLwL22/Rle
   JM2lZDHlS/WCcyLb/MrWrUvaMJa0qcH9mjeZx4EuEn6kCqZcbBit1o6Gp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262439485"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262439485"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="725461802"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2022 10:53:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 10:53:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 10:53:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 10:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkq3UEk+tmosehYOCaQ6IsWjmL2u2um4lmf3HUUPcVpWC0U1lmuL6PoHBmSoCWfmcyj7JMk0CfCYzQjwQJkE3ElslTzj+jY5/9k37EDjt/F2pgy69Xs0Kenwm/5+XQdav1xXMo9y16bl6783IJpjZYqjCcqavCdXAidUfRjUxi3HFxDmS1QmFonZ0TdlBPxM2xucg9UFtcpid81fyZMEviKn3pwBG2UuHpAn1Sb9DpEd0CnmPC43HLuGzmyr9cZZ7BRsi62G0rmPkbKD+ZLNKGY+ifF/FM8R6X4CFGjwUlFbo936M++2Z4x/o86kPDDLqHsvlxrovwS3Y/F0FWTGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yILzJzPAFkhbgdQ9LQJA2y5+CB9t7gbmIiph+uSX1nI=;
 b=P6K5C+Um1klWFco0yIggSRosbHuRwQmw4kzmtB+vg1MTD7ECvMqe4Ls+zl0B3LCdWPpHbCgSG46OJfBfKRUSlU/8pE2DppAdu04Jq6DIkd9rcxBQ8kE2ySq4GkzAOnljsLcQG17ktlv7ms1jkhorMmZ5kr1oUnrGrlPSofzSSgu8QA/ElXx4/u/02vtdtMOdMMsYuY5ghxVOINRNS5/b/8Xf/h6DEMUP9C8jFZbqJ/IF/085h50vYJbuhPxKNAkfAnA8C6hz3BSvf5S3K58ePi/EXbrG/Dxvn13LFa4xU2l1Bu2I35XZG4b6kI3VyfdmMrRmxW2JtoFu5v0fSVPmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 17:53:31 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 17:53:31 +0000
Message-ID: <cb94e592-0fd8-3274-aeeb-49fbd6f74761@intel.com>
Date:   Thu, 14 Apr 2022 19:53:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Content-Language: en-US
To:     Rajvi Jingar <rajvi.jingar@intel.com>, <bhelgaas@google.com>
CC:     <david.e.box@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220325195053.769373-1-rajvi.jingar@intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220325195053.769373-1-rajvi.jingar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f66f2b2-8bd4-458b-3fad-08da1e3fb020
X-MS-TrafficTypeDiagnostic: BN9PR11MB5244:EE_
X-Microsoft-Antispam-PRVS: <BN9PR11MB524407765D6473BCF7A3A0C5CBEF9@BN9PR11MB5244.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MdPHchzwfrEmHEMwraAxfSeCCvBg/AXctMdq4J+G5LTxD+A1it8occ18KJOuVjc1qPf7orpY32t5jco2fXZrhyV40nDp3b7wNmEF101cF+hcUw7cJ8gAyKkw1zuazJJNf4dxqYiVmBtDXVC1GcqgNizwTn0EG6Vf2PEbBNKHXiHWFqZjcuO/hYeAT3Jw76oc4aperlzIfDp81jpUvZVqdyc1uwguMhCI1qi3Yuw2q2Jn9CAtudmN7Mvu+sgf5lxcT+hsWhCefa4k6mv7uSdlOocUxsaR+r2uLx6OmRnAJ7LaemI5nkdERoBdVVmHg2Ataj9iZSRSXpLiAOhNqhC+cnp1YYbZ0uIdadAA6z9Hi0fPe0xG8WoSljdWfDfS8WAL2LZA+gqETZaEUNLDymaM8idsqK49R70OCLL0jDSVJIilztkLbA4SVzZUO1muaSxYpSIdzj1Q7K40BwK6V7qV8rGufbhmtkAUIQIFA9dBW49nc60+i6CAu5wdoi3WzS15kmjpInFGgr/393Z9/+0i/37S293sQY6IlV6GxiJVBrvOPwIpy0wtY/SuhMJ6c3LKwHm1eQiEEX8HJq54u96RRQXzp032Vwoyf/ERYuao5N6ta+34c2sv9sFbGkLKb5KEBNypQmIjmVzmjgt/q8HKsG1fFJPdHIhB0y2WwXrsB9CoDURBbE6IUUorpmQ4hlJTK1zY+8yUmirnQmrlUaxdXg+/6fdjxYTHiMBdQ5h5EM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(508600001)(36756003)(82960400001)(66476007)(66556008)(66946007)(6666004)(36916002)(8676002)(31696002)(31686004)(4326008)(316002)(8936002)(186003)(2616005)(86362001)(6486002)(6512007)(26005)(6506007)(53546011)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRJbEtXbkZ1emFzTURPNWFxRWxrU2UwR2ljSnFJTmdMV2tqeW5mN3dhSGN2?=
 =?utf-8?B?bWp0NFlsUDhpL3NFOTJpb0NHMTJVMER3eDVodlhDdTNNMDZTbG8rRmpSVHJT?=
 =?utf-8?B?UjdFSW9JQ2x3NDU0Y0daelJQY0p3U3JSd1VPSkdyMVo4dk8vVjh2TTlzZzFH?=
 =?utf-8?B?WXNhNjh5RlVrTWJQVkxPWmY2dElZSVEwTkNnM09OcDFEUjlOdForOTllT0NO?=
 =?utf-8?B?VGVWNGF3V1FyKzZzemtyUjZmT3RUNG81Q25PQ2RsYkxoc25rY1NoZ3pNb2Np?=
 =?utf-8?B?RGlhLzF6UEFWditpbEEvVkRYeDlkWkNXMmdWRzBiakJGZHlJNktZb29EZlpt?=
 =?utf-8?B?dU0zVDkzUmRjc3JXTzBtdnhwb3RtdUpNS3pxNTkrTWhjTHhjdStUcVNOSFFv?=
 =?utf-8?B?bmwrOUpibHJqNXE4amlpM3BtQjU2dVRoWjNOVWFVT3RPTXpZZ3hUR2psbVBy?=
 =?utf-8?B?dHBjWXV3MlJpV0JtK0cxR2t6QWFMdFFzR1RFY1BxUXcrVXZIVGVwMzV6YXdC?=
 =?utf-8?B?SnhiZHRzaDFwK2ZaUUFKenVoSGt0SlNiZk1HdytoZDRCWExUV3ozVE9BQ0FM?=
 =?utf-8?B?c2ZZUjJMdG9zRVdDVitlTzRJZmtkQ0RYYzhSd2toYjV2c2x3RHhKK2RScFBs?=
 =?utf-8?B?OUFQVU8vNTRSZm03cW8wcldkcTdjdEtaZVE2enZkTjg5ZVUrSWthcGorVjNP?=
 =?utf-8?B?M29nZTdMNUJXczJ3VWQvM3p5b1g5elNKd0RCRVZkbUVRc2pvWGdLTmRRVWlG?=
 =?utf-8?B?bElYUE9BSUROZlNyNkdIVVFlMzlLdU01NmRvcUd2UTB2MEJwUkl0RURqTDVi?=
 =?utf-8?B?QlpsK25CTHZSWXcyZWYwaGcyem83Vmk0MVVmVmVXQnQ3YTNBMHhPY0ZIUW9k?=
 =?utf-8?B?bXVGdXBvemFCanhGWjBPZDliSlo5MTJXYWhabFNpQ2ZuQlJzOUdQN25LbXEv?=
 =?utf-8?B?amJ3WjJqa1lrMmYybk9KUTdtcEZ0cTNHNkF0c2h3TE9WNjl0U0MzSndqWDJz?=
 =?utf-8?B?S3R2N2pMeGpBNzlyay93WmVxb0k2aGhjcjcxQzNUb2ZXL0lSemRObVE3c2xk?=
 =?utf-8?B?WlRIR2ptcmNsS00zNU9XQ0ZUb3RmY2J1K1BMc0hUdXFtdkxpNmluTnNVcW04?=
 =?utf-8?B?dmhHQ3NUSVd2czY1a09aSXdFVy9hTU10bWdTOE1MTEFKTHRRclpJNjRUcTB6?=
 =?utf-8?B?aVEvZHNpWk5IdGhQVlh6aTZTektkYStENVVXVVh5anBrT3VyYWIzMzFZNWxV?=
 =?utf-8?B?aC9mYWllbkM3N1N1a0RIdHBkYm5PL0MxU3NFQUt0YndHWTVWSG83WW0rM05N?=
 =?utf-8?B?WEVqcmtKN0oyRVA0RUg3T29lcThKV2FqWEh4VEhrT2RQNERvS0hScGVaQ2hN?=
 =?utf-8?B?bkMzU3ViK3dRWE00L3RtWlp6ZzlzT1VjaTA5aVFpT3hraWJkVE4xSEJzU0pj?=
 =?utf-8?B?MHNiOWVDdm1LbjczTWVReVR2SGcxV20rRkJ1bW5oT2RQSGJEUHhoRVJ1Wkt5?=
 =?utf-8?B?czBpeTNHOVlySkhwdjFKS1paaUs2K1k4UUxhUHdnVjc1ZTVnL0xoSmRKd3hZ?=
 =?utf-8?B?UmRDbGlyREFnUU1VTnpwR3pnSzdpanVVRVkvOTFWZEZDMisxaWNjUDVIMFUr?=
 =?utf-8?B?bitXVTV3TlB3cHR2TEZwMFFCSG5tdXVXWFdjVFBxUkNobkNyOXZVN3lsZUN1?=
 =?utf-8?B?ZmtTbCtjOUVPQ3phRmRUamY2QW8wemVsN0xaT0NlMnp6aUVGc28zZVJsNEh4?=
 =?utf-8?B?UkJKZmUrWTB1NHdieDlBY1VKWndQWXVlWG1sY1huUW9KL1BiUGFJbG90bDRh?=
 =?utf-8?B?UXY5d1huNk16R2RhNE0va0FwbGlDa2FZNWhpSnNZdys4Wkx0YjVNNEYyWlV4?=
 =?utf-8?B?NWJUdmNmdDZ0UzVRRG5VSXpYOVJjSEgzUlp2Rlp2R1diblMyeDZMbDhVR3ZP?=
 =?utf-8?B?WUVXR0VseHNneDM4YXQzcUE3UDlmOHZ6bndmaGNCejQ3TFlZOVhRdFpEK3FK?=
 =?utf-8?B?ZUhrRWg4Mm0vSjVqcG12bllxeThHcjF3ZzNhczAwUHVURm1nNjdVQytPWmsv?=
 =?utf-8?B?WktVZ0FTU1c5bzkxRFJHMjlRN1J1Z1VQQ0lmc0ZVZEp3K3d4NHg3TWhvZERF?=
 =?utf-8?B?Z2tESHZBYXMrMm5ITTJqY21yYW9kTjRZV0RRcmlDeEJ6NERyZUVockF2Rnpm?=
 =?utf-8?B?SlNBaUlIWklsVWw1TlBiRDRUNTNyZEVhejJGbHdidUVMeWpRSXRtcHBmUjB5?=
 =?utf-8?B?c3Byakt3blZOVWdNTGZSY1RHWFJoK3VDOVVhTnNGRml2NVJlZVNJQ3cvYkI5?=
 =?utf-8?B?RUxTM2l6Nzh5LzVyei9jTUU0NjRTU0RZaDlzN1dtMzNEblpHM252S3hBSnVZ?=
 =?utf-8?Q?49dMRKQQXg144060=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f66f2b2-8bd4-458b-3fad-08da1e3fb020
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:53:31.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4AsUctZExLDFvUTwS1FXJrGeROHXbdOskWG11PjwWDsTAJ/lAevmGtLaR4ob+aQOphyW2XjLTlDAhMg5vsUxLCeLPz5edOi+nhkVl1qcSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/25/2022 8:50 PM, Rajvi Jingar wrote:
> The state of the device is saved during pci_pm_suspend_noirq(), if it
> has not already been saved, regardless of the skip_bus_pm flag value. So
> skip_bus_pm check is removed before saving the device state.
>
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>

Sorry for the delay here.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   v1 -> v2: add comments to the changes
>   v2 -> v3: move changelog after "---" marker
>   v3 -> v4: add "---" marker after changelog
> ---
>   drivers/pci/pci-driver.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 4ceeb75fc899..8b55a90126a2 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -845,20 +845,14 @@ static int pci_pm_suspend_noirq(struct device *dev)
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


