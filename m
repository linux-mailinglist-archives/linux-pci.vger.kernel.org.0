Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2346E675CE5
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjATSmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 13:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATSmC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 13:42:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB822CC25;
        Fri, 20 Jan 2023 10:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674240121; x=1705776121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4eVUvYqdYiqVqeKboGjq9QtZrlqn1wGBXMaUhaiESeM=;
  b=Kd2gGCE5aeyWLZEO7YCYAAM9Uli41pLxh+0hje0q2bq89vxWbivBmFif
   0INquXp6K9qf26C3hG0sMOOv6/EuRebKtKS2i45MwYhxrNdMtWWgjYMX2
   jA6NXXfocZfV4H6hPmTHSZGeEPlfDlsnVovIxdDEubZmCLMV5jAsIG0jE
   aNjj7ywfOb2r4xyr+kM+HPOuFanxUMiN1K+EirORtpjZYvkbLRA+quJTw
   dx6Bvzq/Py+Ba0bGWW8gn3WbdQSkooMvsSFurIr6UQXBAkGOo6oTPLNoc
   fR7IHXSMtBicw7/I93ZJ0rZM5rS8OLcqzttCxxwHeaxX6gH/CqOG6SGDn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="352913243"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="352913243"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 10:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="729204850"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="729204850"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2023 10:42:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 10:42:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 10:42:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 10:42:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 10:42:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFDQ7BIUVtzY4sRa1sUiy0+BqUZX1J2Z8+kGzNiXtKcylkY61lzWNXoJK1p+MNDU9x+rypLXY5iRMOdV3REOvK3Qw8L02U5mcyoFosD8629fyoowQ/v0Md+OE48ymeytBM6VjHb2TX8HdjwjDo/PfKVV3+C4cC0uYjmk/btO4seBBH0bDGDfZliqsQmPss9BfGcor0HJxJ1xxA2BcexmKe89EAHSmjAM1FNgKLGODQ8BGOD1WiOenoRjfp2ETf68Ly3dQ4nzEikpDwjT7UErPoXDIvSec03dNdsw3iTldVxVBsGHzSCxoCxAO96U9bilnVFvbbZBEi/rkyAj6A1n9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL7hhNXOxIFZbNYTC/hSX2Gl5islpS1lKNKiiYwnDIo=;
 b=Z2fbbrhTeSM+3ATVjkOTK3G84PMni3BDrWY1f1LuzUSRtN6YG8raxBoXq/NHJEa6KwWtL/H/gPIfweds0U8ac1UEkKjPP7Rg1g777C3IzDygt5/JSSKR8hvqqN8VwecrAc2TIH54RMwthbGMcYobRqZtW7A0/f0VA/B10o67nwp5OMgzO7GE8EuAZdGlDAFckHoVfNTr7ejuAMJxJOtxCkEg+mC8tJlS/qzaJyoI8XY1Ves8ZuMb/OSkdHpcuhh4tSTRK2XZaT8s/RM6KjQZ610SD0QFP4snSTKUa5SsPWse/VppzTnuq+8tWIHITltZWRG+0SbMT78h0rb356pB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SJ1PR11MB6225.namprd11.prod.outlook.com (2603:10b6:a03:45c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 18:41:58 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%4]) with mapi id 15.20.6002.026; Fri, 20 Jan 2023
 18:41:58 +0000
Message-ID: <7b4293fd-e642-9983-9d88-7a5aadaae97e@intel.com>
Date:   Fri, 20 Jan 2023 19:41:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2] PCI/ASPM: Skip L1SS save/restore if not already
 enabled
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kai.heng.feng@canonical.com>, <enriquezmark36@gmail.com>,
        <tasev.stefanoska@skynet.be>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20230119094913.20536-1-vidyas@nvidia.com>
 <20230120091540.3305-1-vidyas@nvidia.com>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230120091540.3305-1-vidyas@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SJ1PR11MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: cf513581-c253-4187-c4c7-08dafb160287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFl2P1A7Tj/Mwykc9GLkFcc/1yXhK6OWV6smwSK0JDo9Gxcq9FbVf17rfckmw1UBMICgZd96bqSvZrBntvG1iCK49hsK4YPJpMIwzxkIWax4EvJj051V/RVglx8/lHrvj2zElr8R4sOyRFfcdtpdxfoRif7ScvvroYOWScX5XKMcCJdIrZVQ/5bPoIjMIm+PmolEr09bUsKWdYTLK46QqRAS7wZI6VZBHvZYnCu3qzAtMTtjO2EpkjFraeofXOJTWu+uhFEcNZnvFm9mtJvQ6Zc/bI1UFj65VBFVCRRXquekVBuvVrGlLp30bCxHiH5EmBP6uJnLY+TP9V9JNV7VVwGKrMoRzay4p1p2vzAmiWX6npnirW8zIkBrtCSK/ESMdukRBMlPnHQaRPVnwPqMyiozO60P794jWiQy4dizOgC2Q6k4x7Omkn9795OS9HGnPv/29VOIAW4XXOrcLdHoXlKIwQXGaCHd/kjFU/oMpKLbvu1pDmuXwssebq/Cm0urtPZv5Xy9fkdjwcSatp6AoWlf/iHU/4JH38cBa+XIVYbfwTNUWxGNHsIGzNXg6eJZkpKwDRa27i31oC6ctF+N3DSTC5OrKmaig06tDwgfXKGlxg15u4wwxs5ie4vUQrAdLnsks6/HtfyIB8orFOeGhGo9Z8iG+9Yh1zD0dsJ9iG/myC/kYuLdho9nUYaPde9fqoXBRGVc+ol5+uHu12aMm0lcBJp3rp8yM0gOr/XP19+4TNX7Ry76FlrKeUlFR4+9UcjbpXHpUnzQov0JxJk1nZYrpMzyEm1+5bkkBKuqRby4HkejP3vNFuMWCU19HvmP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(5660300002)(8676002)(82960400001)(4326008)(66476007)(66556008)(316002)(53546011)(2616005)(36756003)(6506007)(41300700001)(8936002)(6666004)(38100700002)(86362001)(2906002)(83380400001)(478600001)(31686004)(26005)(6512007)(186003)(6486002)(966005)(7416002)(66946007)(31696002)(32563001)(43740500002)(45980500001)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBDS2FKMVMwVlFadk9tVGtJZXhXMXZXanRaY0tCbnZXUzR6NU9RM3ZOd2NU?=
 =?utf-8?B?Qjc3NTZLZkhReGFjYVhDZytYcUsyVE5xRFdzTkdEdStFRWhUZ0p3M0dwV0VE?=
 =?utf-8?B?QmpsRWN4dERDQXlFS2wrT2o4SE9ER2pXOWxmMHB0Z0MvTm90aWhjdFptU21P?=
 =?utf-8?B?Y0lBT3QxUHpycHR2MG1SWFI5dzJFWlF5Z0dWV0p2L3FDYlAzUlFiNll6ekVX?=
 =?utf-8?B?WnRmQ0hVOEx0SjhpSzRPRUJpb3F1aTdtWmgwd1U4K1lBQS9MVEZGcWR3L1ZT?=
 =?utf-8?B?bUcxVFBkVGFNMU1DQUE2OU1pMmM1OHkwTjZJTXFEc1FpbmpJRXlGYjIrTWdm?=
 =?utf-8?B?YjQ2bnMxMTl0T3RqaEIzcDJ5d2x3aHNpTW93RVFqMXhycnBKT0VwN3NKSXJG?=
 =?utf-8?B?K25INnVCK0swN1g2eCsySE5VenA3QnZsN2tBakFENDFkdnIvdU03Y0gwc3FX?=
 =?utf-8?B?Z29vWnp5Q3JESXRqakQvZ1E1d1NGLzNxamdwUEc4QXYvU1ZodWZlOWFIOU9W?=
 =?utf-8?B?VkFRbGJ1RkwyK2kzTWtPWDRoY0paVW1sMTNWZi9VUHhpQXo2clpQRi9jalJl?=
 =?utf-8?B?UnA5U0VNZUY5Z1l5blp4OW5wQzlRUEdKRVBVVG1CY1M1Sitra3I4MjNCZ2pD?=
 =?utf-8?B?V2hDdjI5NXpLVDZLRE5EY3I4aXhROWdpbVVueTJ5MU9jdUFrOXNmTEZ1eHBs?=
 =?utf-8?B?bit1VXIyWTRENGFSUHMzSmx3TnJPaUY1S25FckJBTys5L3U0eStJdUdpMVgz?=
 =?utf-8?B?WXV2blVyRXNLWXZKdW9UK0lDdmRMcFlGaWFvZUhUaGF0aHZXMTE3RU85OHNr?=
 =?utf-8?B?bmszRjRRdFh2T1NLRFZRUm1Hd0hxczB1MENMRUVYcmFoMTZSRjhqSDVJOEsz?=
 =?utf-8?B?SXBzUVpKTk82ei9wdnBXNnM1eDNhMU8zNVFCdUdjWGN5UnhobHdGYUhseGNj?=
 =?utf-8?B?OTR3enBZbmlENWRwUnY0dU04Mm9hUU8vaUhldTBNelF4Y2xkV3REbW5Da3ZW?=
 =?utf-8?B?Zzl5QW5JcUNReGk4L1ZWTWNnbWhnR0NScXMwQ0pjNGIweEZvZnhVbVlFMjZa?=
 =?utf-8?B?K252Nit4aUlIdWhUeU00WmxXbGY1NHZrZERMT0hIQ2wrN1hOdVk5c09TcU81?=
 =?utf-8?B?RG5rcmxzTTFBSjNsbmpZSFQ3UExOOEhxRnd5Y2ozZnNxZkRWWVRxYU9jSmpz?=
 =?utf-8?B?RkVCREc5Z0dtZjVENDhaK0ZFT1FPUlJZRWt2SDU0eVhyaWhuTWtreVNERTZQ?=
 =?utf-8?B?VTlFbVN2Rmo1Y1ZZZjZZS3l5aW8va0pmdHRPWUsrVjdjTTgrcjdIKzhzVmYz?=
 =?utf-8?B?bVAwMEFlVzR3Ymh0YmRlVHlqcXlxUGx4cXNTakR1NnM2QnV5VTU0dTZRUC8r?=
 =?utf-8?B?Q2J0R0lJcWZmUG14dTZqVDRPSEVSTXZRcktPb2g2RFJoaTlFQ1FHa0RUcHNJ?=
 =?utf-8?B?MXBScjV1WWc1TFlHNmd6TlJMMXFGcnBmZHJpelFLRm5wYVBjdHNuNzRCZldE?=
 =?utf-8?B?L1JhL2p5UytBVU9OaXdIWENuTWJoaGNQTmlQNFRWeXcxZDE4MldUWEtaNjFo?=
 =?utf-8?B?SjhKNkpNK3VwWmVKTDJveTZEQ1QvMVpkdFVjY2p0a3dQMzFlTU1yQmVkREVv?=
 =?utf-8?B?dXc4d29aV3ZXZldjTkh2Tno1eU5mbzl0aWEwdUJvWkh2VXc1RzRscmRwaXFw?=
 =?utf-8?B?N09yVnU5b3JYanZoN0lsRk1Fc1VNZU5pYWhVRlllT25sMHpXTURDZUJwaVQ2?=
 =?utf-8?B?c0UvbjA5QndwcTh1cmJFMDhkU0J5ZFl4Q2lmRlY3MmFUT2NSRFgrT0R1TEk1?=
 =?utf-8?B?UkhBbVo3YllYTjY0dlVnRThCTHlhcXI5RkxmU0l1djNjOFdnVmI0d3YxWVdh?=
 =?utf-8?B?dTJabFpGcHNCNmRISGlzRy9RM1B2d2FqOGk2WDB5QWJ6S0ltZWxZMFZKRk5Y?=
 =?utf-8?B?emxXcWlKd0RZTWdlYXZHSk44SWFSSjFYbGhUTERiNDVZUWdRV3lNTEpSU2x5?=
 =?utf-8?B?NWJ5amZsakxXQ1NsNEllNVlmb1NhV1ZPV05zdGR5RVc4dStrQUJRZm8wZ2tK?=
 =?utf-8?B?Q01SMU1laTRneDlTeUZLVWdUSk1KeFhWUmg3eFo3S01UbzRDR1hJNnRiQytO?=
 =?utf-8?B?K3lFSVdHODRpejB6dlQxcktTeFVvOHNPdjJ5S1JhSnl5ZVZ2ZVkrOVF5N1pl?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf513581-c253-4187-c4c7-08dafb160287
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 18:41:57.9931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p3rdbWSDf6MStHMAAAI1SWVWpYbT8TECHori4KdJTFjCzyrUZ6rhArJGxdPF5UkiUxM+w+ubPf3orhAuGaxjdxeezqyKx7FoVgo6/pbRvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6225
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/20/2023 10:15 AM, Vidya Sagar wrote:
> Skip save and restore of ASPM L1 Sub-States specific registers if they
> are not already enabled in the system. This is to avoid issues observed
> on certain platforms during restoration process, particularly when
> restoring the L1SS registers contents.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216782
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

It would be good if the bug reporters could test this.

When that happens, please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it.

> ---
> v2:
> * Address review comments from Kai-Heng Feng and Rafael
>
>   drivers/pci/pcie/aspm.c | 17 ++++++++++++++++-
>   include/linux/pci.h     |  1 +
>   2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53a1fa306e1e..bd2a922081bd 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -761,11 +761,23 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>   {
>   	struct pci_cap_saved_state *save_state;
>   	u16 l1ss = dev->l1ss;
> -	u32 *cap;
> +	u32 *cap, val;
>   
>   	if (!l1ss)
>   		return;
>   
> +	/*
> +	 * Skip save and restore of L1 Sub-States registers if they are not
> +	 * already enabled in the system
> +	 */
> +	pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, &val);
> +	if (!(val & PCI_L1SS_CTL1_L1SS_MASK)) {
> +		dev->skip_l1ss_restore = true;
> +		return;
> +	}
> +
> +	dev->skip_l1ss_restore = false;
> +
>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>   	if (!save_state)
>   		return;
> @@ -784,6 +796,9 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>   	if (!l1ss)
>   		return;
>   
> +	if (dev->skip_l1ss_restore)
> +		return;
> +
>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>   	if (!save_state)
>   		return;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22319ea71ab0..39534602b55e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -395,6 +395,7 @@ struct pci_dev {
>   	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
>   					   supported from root to here */
>   	u16		l1ss;		/* L1SS Capability pointer */
> +	bool		skip_l1ss_restore;	/* Skip L1SS Save/Restore */
>   #endif
>   	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
>   	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
