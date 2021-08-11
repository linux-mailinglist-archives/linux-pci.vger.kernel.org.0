Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C63E93DE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhHKOo7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 10:44:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:64384 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232725AbhHKOo6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 10:44:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="212025356"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="212025356"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:44:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="439733409"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2021 07:44:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 11 Aug 2021 07:44:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 11 Aug 2021 07:44:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 11 Aug 2021 07:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYF3pAUMLgYDM/8hREu2omG01DwJQMkMxAiu7tPekwIv8iZegjs94dyrxHWbeHUdRMP1NmYBCUOKldSCSDC3XVweUyXhEpgVON+zTfbOAOKOaZTOf04Imwb8mvrHqFAdPm+6LTyljBe/mNsFOYn9NGNi7xDf83+HVRs/WnTNL+hGAY4bQKmCyXQ0nUZc2TuAIsUX3SmJ7v0YVHQGmrkUmE+Toft6PUpcE0kW4Jm9zberVTqY366m/JYhx5IZIWS/KLIcpfymHytOdiSCeJFvH9W7zoNurAS/f2MGBBG8GmVuIPkBBqjaLad3wvoYVqdt8BaAhq4vU0a3EG28A3Ur7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60WTLF8RLrlb7qSoisJ/nwWtW8lWjAp6ZjjHAApTu7I=;
 b=TP7TUGkVgjML1GYX0egrPQ2hKnd6ChzOvHbAUmvJCfsHwKG+z8Ks5/md36brMDxIxIQmfLrKcTwHHlixlZRvK4NsuWBeCCljto2tpC1msd/vMyU40UiqJ4fNvJ9VtVN4PGDXXHokQ5amoAx+W5EWtV0uGETxMi6dK9WFb3YjGiZmTQxjd2vGS2ihJmX+h+aavFF/Jwr+80qRrb+lmPvtAzBohOGLvBk4lc/50x7d0IKtsOYmnkHKKiIE3VwDV+qaapTMQvzeHnrmiuLzQgJTRBA7CJz72k3MMCEv62hl8vc6Cldrx/ypdfZXMBcMi+g3LCMb/kxGUjowX9hrd5ll2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60WTLF8RLrlb7qSoisJ/nwWtW8lWjAp6ZjjHAApTu7I=;
 b=ksjYSufVAAGpLPefoih3fO77cDtNDk/xwS+PKFAMmMjzaG19DgySuLg3NFjzesnfAmtWEKwVPvdDNEzLJ+kYPJaLbZdvurMWI7cKZ7XgoiDUHwrqOAcV5onlhlOVgQYrOlQ9LuyAeVNMhrwSET3SacP3hXysPPXSJ1Jvt7G88lM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2746.namprd11.prod.outlook.com (2603:10b6:5:c9::10) by
 DM5PR11MB1356.namprd11.prod.outlook.com (2603:10b6:3:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Wed, 11 Aug 2021 14:43:47 +0000
Received: from DM6PR11MB2746.namprd11.prod.outlook.com
 ([fe80::95c6:8d41:62e6:24c7]) by DM6PR11MB2746.namprd11.prod.outlook.com
 ([fe80::95c6:8d41:62e6:24c7%7]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 14:43:47 +0000
Subject: Re: [PATCH] PCI: vmd: depend on !UML
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Berg, Johannes" <johannes.berg@intel.com>
References: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
Message-ID: <a8905276-7b46-cc50-740f-b9d86ec54717@intel.com>
Date:   Wed, 11 Aug 2021 08:43:45 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::46) To DM6PR11MB2746.namprd11.prod.outlook.com
 (2603:10b6:5:c9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.123.78] (192.55.52.194) by BYAPR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:c0::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.6 via Frontend Transport; Wed, 11 Aug 2021 14:43:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5d69017-86f2-41aa-da45-08d95cd66d3c
X-MS-TrafficTypeDiagnostic: DM5PR11MB1356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB135621399F9FB4983FA12D6D98F89@DM5PR11MB1356.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dp1BARTxRuYyrN+4b6gpLAn9P8iy2zSf6CRfIvAkzhMHYsBDvB73qTgh/sNnLdpIT++lWKUcaBT4RLbp0+FEnXehASDQFOiTYRofP50DAU8aWxROZ9AS4caJnldYRlJ6YEHvfnT6nh3nDA4VthpSPfG+fFn9cgeNbGnDIPYHcjUvcctwTJXpoVSaTyObNKo4DVElvbki+XI4JI3gR4YHrp7Ep8adAry3za2Dh4JtuUCqJa8w6s6gQlNKCwVWwZVUKFtLI0+16izP7KP99jHiLuKxQnjA5f7gbMsoTBdvID+BBA947l95QqhRC5YDVFM9l6zf9t4m+TS8hvC/Tn2x0nVxPdVmEKSq7cJpmBOChwA0Gw/VR34YQzhxe8yPvuF3fXBjwv9ehoP8Gu27mTgGk+AXD2u7N22CUAd5yBeldnWW5KDfuiaLrwi82nh/V6u/Ap4tC6PETRU6Ydp//RI0J7NBZ1i1s0pOPAc6JyLjyk36rrm/wwBzY5nYp/zoynDVRvXnvXVOMk+IkkeGOFOoDfmK115kFCZKEvcFRPgbqKvHNjWT0wPneSvoC2CtPnoidJ2nYqDk44yDYJQ0LYa9MffwoiMvqExECUtEunQ1OFcpaAdP+9steGFW7T0xpEfWezUfeAx8v2GLylfSX0Cj3+19MxqH6qdgFKyNO134PGDv7E8INtBYy8JRF8MsAMQjDpZwW/NUbTYh6GeFcR2gdGHjlsi2ZRKGC7kXO84AbjjluYoiqz5FogCXG9fZ1IEd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2746.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(36756003)(316002)(86362001)(16576012)(2616005)(5660300002)(53546011)(8676002)(110136005)(26005)(31686004)(83380400001)(4326008)(956004)(54906003)(66946007)(38100700002)(186003)(8936002)(66556008)(31696002)(6486002)(478600001)(66476007)(107886003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJ5T0JhY1AzUGZLN1BHT2tUa014WjdISXAwVFVyc2NhMTNtN0Z1Uk5SM3cz?=
 =?utf-8?B?NWV6NUlYKzhHRFJMdHdBNktXOUlzTmpGd0ZTc1oxRm5tTDdGczRpcUY3THJt?=
 =?utf-8?B?bks3Wi9wM2puRHErV1puNm9sVFo5V2J2cUtYd3dJNDJtVGo0cFhXUXAwSWRF?=
 =?utf-8?B?dkZkc3o0UFpNYnFRVHBVL0NaN0Yxb1ZOakNHQkxnSURiNlRBcXlIUUp2UmQ5?=
 =?utf-8?B?R3ptV0lNQUV6TnhnczYxRUlxQU5LWGpsb3dxeHM2TDFSUjQxbzdKQThFT28w?=
 =?utf-8?B?VjJtVis0YytHdnh1NkluUTl6akdWYzFtOTBRTmxwTHFTeUFVYnFpU3kyNGlm?=
 =?utf-8?B?MnM5UVhjMGllMldoY2xuWjludUZOUEtVZjJSbGVUdFU4L0VDcDAwZ1J5QkFz?=
 =?utf-8?B?OVQvWE1IdkgrL2xaZXl2VkV6azZhdWFiU2cvQ0J3NFR0S0Z3VU9FMXVNSHVD?=
 =?utf-8?B?bWZ6TnVTbjF3WUtMR3JndThXdUJadHpjVUo4T2FGdk5RUmlDcmR3YnJCSGRj?=
 =?utf-8?B?blhaRERLVmhXY0VqK1RjQlg1djVvUzdkMmJpMWxQNXgwZzFVS2UwNkxIWmVo?=
 =?utf-8?B?cm9qdXRuYjRXcFB3KzduR1pmaENMTnpOa3lxQTg3MUFTcnZhNEJzdjVxZmU2?=
 =?utf-8?B?WnY4emlPTlArVDFnWjFJbWQvL29JaVNYWnBRMWRMRGo4dmxUbzJ2M2crS1pw?=
 =?utf-8?B?YVVJRmcySU9qUzVFRnZsMGJwMWVwZUlKYzg0cG0rS05ucThxRnBhQ3d1dEpR?=
 =?utf-8?B?RHltczF1N2owTXJZRHVqbWd2NEVUOFFxZ1BjeU1RdWVTM0RSbHo0NXloQnNr?=
 =?utf-8?B?OEdqRGE0U2VoZjhKaGFtZ2F6MnV4TzdQaUswVk0ycGd6Vmo3b1AzZk40TWJK?=
 =?utf-8?B?TlJWU3hBMVVSZmZ3NTNqbnRmMGt1bWxSVk95VjdqWDBGOC9hRGR1MFZGb3RE?=
 =?utf-8?B?OWJPaDVVdWV5Yk1XT1l5Y1Z5MlQ3VDQ1TEcyK0ZvNUgrcFJhMkxNVGh0OSsv?=
 =?utf-8?B?ZzN0MC9aTC9QOXAraFVyT0NBMzd5ZkZWd1dtUndWbWdiZk9QM0RxZ0Q5em9T?=
 =?utf-8?B?dnNSUnU3eXUwUU5YODVLSTNOdzE2b1NIQWFPbjY0alNHSmw3azM2SHhJMEN0?=
 =?utf-8?B?UjBIMUlGOGxhZjlYZ09QZ0NCTVJzaG5JaGEvcjMrZUk4d2FBR0N1dGd3U21U?=
 =?utf-8?B?UUs4dlVqcHFzRWNGUGtNenc5UElKMnZ5S2swQ1NOeVhCRVk1V1ZwK3Q4Qm1l?=
 =?utf-8?B?OWJqZ3g4UWViRURMY0E1aG5qOFNHZlpOTUd0Y3VyLzQzVVNNVEdET25rRUhC?=
 =?utf-8?B?TStGOEVRVXovVHcySStrbWdxVVJWMkYrMmthdFA0WEhvMGY5YS92d0Eva3lG?=
 =?utf-8?B?Vm5nSTRiY0g1cUhSemtJY0RJUzlTUk92Z0R5dkU1MkpSNFZJRmpsQ2JMYm5K?=
 =?utf-8?B?Ry9lZW9BWFNJNnVoWnQ5aWJXU0pnWHJqUTMwRzFKUjM1c0dyakRKL1l1WnJN?=
 =?utf-8?B?QmFjZ2t2OWR3WmxMeW9qcVQ2aHVJTDJVQ0ErMjBrSm1OS3NXWUVxb3N0OHlX?=
 =?utf-8?B?T2QrSkRmZWNCUG9YSjIwcDRVRW1BM0VBRXp4alRpN2RjSjQ1R3R2bWkrK1NJ?=
 =?utf-8?B?dlVpUGFZOWF5aGprQ2pDSEFxM2ZuT1BKUzFTMCtXV2JsU01aR0ovVUc2elRZ?=
 =?utf-8?B?ejNGd2x2Nm13dVY5RGUrd2hNbjNqaUdISm1CTG01US9yQ0R4dFNIeG43ZVN1?=
 =?utf-8?Q?n83g6E/Xsg6+I1A/Pusn4RhVzqDI+IK0F+334hG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d69017-86f2-41aa-da45-08d95cd66d3c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2746.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 14:43:47.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miOemOsEhu5LSCbThdbdmqrPAGJaNvG8yod3MttE8ARmMgLJ73z8PQgafXsoXeyZdKwmZGaY9XD5p13CVSqCfePSiDMqPO4tXTYkD0+hwk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1356
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On 8/11/2021 8:25 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> With UML having enabled (simulated) PCI on UML, VMD breaks
> allyesconfig/allmodconfig compilation because it assumes
> it's running on X86_64 bare metal, and has hardcoded API
> use of ARCH=x86. Make it depend on !UML to fix this.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 64e2f5e379aa..297bbd86806a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -257,7 +257,7 @@ config PCIE_TANGO_SMP8759
>  	  config and MMIO accesses.
>  
>  config VMD
> -	depends on PCI_MSI && X86_64 && SRCU
> +	depends on PCI_MSI && X86_64 && SRCU && !UML
>  	tristate "Intel Volume Management Device Driver"
>  	help
>  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> 
