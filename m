Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95D754303
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjGNTEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjGNTEr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 15:04:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA035AC;
        Fri, 14 Jul 2023 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689361482; x=1720897482;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qacA9qwUpKvn7LZMtgwL6f2gOhniVmx24US3rVtu6+c=;
  b=dW4WJ7j80y9fh0nt6bUdlQHBNuPFXhNHdhGfzAzQquPjDBi9nMBoyE6V
   dE3AKw62v0nEJykCtMIZ1RUpHj2ZXFcxhLEW8EbkeuGNJmDW61OJgbS4Z
   NCZbHeF8uqryziPubRgc1Zsh0cSlOv19q722IEHAziYRqukcAcMUZ9x/G
   X/wfuBw2797c1DJCkrohUrdkV1zr+n+NDGTHrV3HM7qmLWeZHHkQh5LgC
   objeBhCw42LJ0iZWnxYzasApNnfx02V2QCun1TcoiqGAH3hO0P9qq8tWp
   pORoyid4N3F4HlfVZ91GfadKRfUxn/xVW7SUIiHTp//G8qDke0qbbyMN7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="396366510"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="396366510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 12:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="699791616"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="699791616"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2023 12:04:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 12:04:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 12:04:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 12:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhZHiYK3Gfs/0p67J6wBqEbxk6zpvoc7/yK9bFvem27yftTouwws/aHU3TxtSqXTqWfXEa6LVZbBpQcengbubu2te474JkzI+j7MNuN9gjF1RCwyjJWCBMP4SqPF9NVHGpoBLHBDV/bAh2mkwJOukzUHFSS4g6x94wr0QkLU7Rf0WLgjJ/uZ4hnvQL8aYgVix51y3CZHtmDzGQ9si6sfWcAJ6sCVKTVrX2K4reKYfph4MuSoEJ2GXQAmFL6RoE/TJGnLJyZrgCLys1m+6AnQbogMDkP1o6f+fzntCtAvjdjCr81vXq9ttGYoD7dqisUACZKaZz1RXzkKgVTUafe9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtWziak9pUYSbQL6uM6Pqu0YHSTK3m7EJe7Gyc9BQKk=;
 b=AQvccwKCB+02B75zxHMeGx4//gL8+8B/Dlc0dE06kux7G/3SYKr2Ad/irQI6UaOnceB0BkiHnmV+RX4ZNGSWpRyazSR50abUTaioNh5whnbc2lFue30YcVSBSV6MCR18l0n+MywAk4MmEEZcwL6Lwix2WX35HTXgsVP/DR/F0x1G/5Wd2X91yBl6dEJ63VVBgKliBs1jf2OdE2qz/X2NH5xpxE1bM99ts1wGm/ysFcyhSQPBGkAB9eccoWvrxz5OuyGfRFYw+JgmsmzGgk7QCCCZZdW4F65WJZ1WyYpagKh5NtIiYbncsdyQIkINwZWYOvEHS5WNs3rloVNGsYB0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 PH8PR11MB8038.namprd11.prod.outlook.com (2603:10b6:510:25e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 14 Jul
 2023 19:04:02 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 19:04:02 +0000
Message-ID: <245f0248-b0ea-fae5-ce1b-6d4414277f36@intel.com>
Date:   Fri, 14 Jul 2023 21:03:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/15] PCI: Define Intel PCI IDs and use them in
 drivers
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::17) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|PH8PR11MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bde0426-2eee-4e1f-0346-08db849d1628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Wgh7Tso4oc8kdBooBKw1JL4k79kT8zFBTvgpRCiNctqxVgOIepAvul5oA+fE2F8MmIejzurFPyAGxkO9kJfWyBjRz/9aeb7t/mj7lLdT7bGk+kFxHXxeLfoTjLZCV4276aw+W06k7oceF1SbyP2bZKNwQW5mZjkRIMOGCoOyq/eCAB99FOiaiWJ2UFSCR7wNIEgweZOa1doBC3hig3wguwnerdbw17ys6K+rmscWBtrdQ6YQzBnLlpV//eMs063iw9Gt4XLpaMef8ul4GV9sTPQ9uQ1u52QdJDeIVPQOz03moRTEO6+bNHKkSqfuBwfqN4xJ9VS4WpL5LPuhkiGAwxEEdYStzY4e0rIfnq9s1rHadUm0xLoev4kRExK7NGW9i8lb0inMlKRZzdc8Xpt5WE0Fz2PhqIjfBwLf+y5BiRZCKiv2eectuG+jFWLE+MFqROyDPz52MgaSxdHBb0NCFdUmPxtvC9T2A6zWAGguVUyqvIdJrZZEakmIRJug/ENcmyLoNwJEQnrGxb4xdSNuiRhXrQNSeYOTav81CjjPboMlNc8AK7szVGXQ0CQpY8ywBnKeXqnMmAwa08WBuRPUTRJDgjyFro3rDUel7Co31JcdWRN48L+ou6Gu0b3Qlcnb5G+cHPfX5Jc6meiNgVxHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(31686004)(478600001)(6666004)(110136005)(6486002)(54906003)(36756003)(53546011)(86362001)(2906002)(31696002)(26005)(6506007)(6512007)(2616005)(41300700001)(186003)(38100700002)(44832011)(5660300002)(8676002)(82960400001)(316002)(66476007)(8936002)(4326008)(7416002)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlVqd21mN3V0cnJHcThFZ1RWeVorQ2pUeGRqNHRQK3NrZ082WEM2cjJsSCtE?=
 =?utf-8?B?L3hGcjNiRy9LVVVjdU9OcGk1TFlTdWVEcVZMU0tXaTAvelpNYllJMmRYbW1z?=
 =?utf-8?B?aE1rV0lVcmNBNTNTZlZScWZJaDhJaUloYXA2N3hwUVhTbWowbHpQSy8wUUdx?=
 =?utf-8?B?aVFQN3VEWDU4dC9TTFVHOWRSb2F0cSttMTI5N3o2WWxMVkNpVzc3NE0zc1B0?=
 =?utf-8?B?TEMwbCtFUjhvYlZkOTFQMHV0a2tVRXJ3TTA4T3NGcXc5Q29JWVp1dThQZVJQ?=
 =?utf-8?B?M1VKVDc2NjlwV256UFI1RWhGWk5zWm5sT0F4NDc0WHNINDZXOFplY0NVaVVD?=
 =?utf-8?B?ZTdmK1VxUFZWcEt4aFl0TVRUZnh6WEw0cU5yMWswZHhrQSsxU1d6djcxU0xv?=
 =?utf-8?B?ZWFEazFSeFlKbFl4U0ZxMzlVbXpXNm5MY0hVblFSVXR6Tmd2OG1wMDBPcnZz?=
 =?utf-8?B?MGIrOWUzWlJ2aXl6bk84QjlGV1J6SWtmRW0vRWNTcmZkNkJsbnlITkFEZElE?=
 =?utf-8?B?N3IvZ3RDbW50UzI0bGZCZVFmb3FrSDlPWmtIVlUzWUZxRjhEZlNSN3ZaM1RS?=
 =?utf-8?B?MThKYjRyRXRSMlFLd0lJdXNFYktFZDFHZW5EVm9XbDl4c3E4ME41dVMrQWx0?=
 =?utf-8?B?ZFkxRmtvc2ZsK2xPdG94L0pIaktEZ1I1UUxUWlEwelp2U1NvMzIwMm94aWxU?=
 =?utf-8?B?T3I0OFFoUXNMcHhDdCtZQStUVFIrNitPYndKZFpvM3JzbXU5K04zYmhTWVJx?=
 =?utf-8?B?UjFYdytuUVUycFphR3JJU1piUllYa3gvSklxcUlnb2syN3FRUTRPV3ZLNFZC?=
 =?utf-8?B?clA5VUNFSGY0aTQ2TVlOTm1OYUUyL00zcjhEdGxnUVFXK2VZOUF4d2tzSFJP?=
 =?utf-8?B?QmhlL0pnZk1kbURNUGI2cHBFakZBY3VhZTk1VDFjemtuMUhIWklVc0thZ2t3?=
 =?utf-8?B?Y3hsNVp3VldESWZ1NEVJdDVJQ0pBWlNtOU1YSjFFUFVQZjZyU2xwMFhYV04v?=
 =?utf-8?B?MElpU1lITHhaYmJEMTNiVjZZWnhDN1NiMEpkLzhneTNUeVl1WHBRZ3cxM3Zn?=
 =?utf-8?B?NVdUd3BBdWxOUXhYUGRjeUVLeU1GL3lrU08xTUV1eHpsOHhpTnI4MEdsV0Vp?=
 =?utf-8?B?L1h0MTduUUJtVXdaa25heEh5ZGwvS2NDZVh3ekN2QWRyNW9xYlZTcGJtTmR2?=
 =?utf-8?B?WTA4andSa2cyWkFGUmZWeXduZ0FMajVoWWF5T3htYU9ERUxkVjUySWNrY0kw?=
 =?utf-8?B?SkljWlJ6Z3g0ZC9KY2wwbjVTY1NncUZLaG84ZzVINURsT0FPU0M1QVpPQzg0?=
 =?utf-8?B?NGJLTExBdkp6U2dYU283SzdpL00zcGp1LzZ1cWxnc3FxRFFobHoraHZ4Z25l?=
 =?utf-8?B?WW1vWWsvNUsxbU5ZdjRSYXQzQVI3Qnl1NUlkZDJhNTVvSzlzUUFQWjF6QUt3?=
 =?utf-8?B?TC9uV2ZCc0pySW5MTTVNWmgzMFQrOGNobC82U1lKZXRVeFZsaEJFVlNLaFAv?=
 =?utf-8?B?d29xaG1PNkdMSThJMzZXdEhReStJbWhONkc1UjdRc3dvNVlVR3dYdVE2bkNw?=
 =?utf-8?B?QWhaZGgyTlRSUmtOWUphTG5UdUExOHlIWFB2NUVpL2tYQlVsL1E5MnRFWUw3?=
 =?utf-8?B?QlNFQXJCcU51S1FqRC9iN2plN0gzUnJjVEtuZUVZYS9ZTDkxdjdYV1pScmVR?=
 =?utf-8?B?WW9uMExYNTlEZ2VCbFdvT2s0dTRWMWVXcFZwa1NURmtHZE14cHlWbjB0US9I?=
 =?utf-8?B?d0FTbjZsNkNFaGRscmYvVHkwU2pFV2RCZ2NvQnkxcDFxSzZYdGlNQWFMd09R?=
 =?utf-8?B?KzZnUTlsSDZUN0NuUmlXMlRNN3dxdFhQUDVKaE5hU1VBaExBcndSOVJkdmR1?=
 =?utf-8?B?STlkb2I0cjRROGRqNkl1MzRWcXdTNVN4L2NkNkZiUmtqeVZoYzAxTEVPVGht?=
 =?utf-8?B?R2Q4TFk0dml5R25kVEluTmVrNGxRWlB0c09ZNzNZSnJZOWw4WkdJOFU4Y0xp?=
 =?utf-8?B?d1V6V2E5RnRiNXd4U2c2Mm13WmJhV2RFdmJia2tRcExRYkVBOUZ6TjdSRXVS?=
 =?utf-8?B?MmNQVldXV2dweHdnMWY2anZxaFJBQkxEYWhjS2xaSmJvM2MzQkJ5eW1rMlJC?=
 =?utf-8?B?eWFQSFhYblpRc2VDTmdTcnlCM2ZqK2Y3cXZldHVKQVNNYk9UaFllUG5ZM3dw?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bde0426-2eee-4e1f-0346-08db849d1628
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 19:04:02.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4utCn5CxV80mZ427R2ZCpAzczwOqg1FP9up15cuDOAgpfGZcWFwl/XyJrhNMvrtLjwMqtxMbT94TC6l0qU3AOPL/3q34YIB0oUTpyb3B1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8038
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-07-14 10:24 PM, Amadeusz Sławiński wrote:
> PCI IDs for Intel HDA are duplicated across quite a few drivers, due to
> various configurations and historical reasons. Currently almost all uses
> of HDA PCI IDs have corresponding comment telling which platform it is.
> Additionally there are some inconsistencies between drivers about which
> ID corresponds to which device.
> 
> Simplify things, by adding PCI IDs to global header and make use of them
> in drivers. This allows for removal of comments by having IDs themselves
> being self explanatory. Additionally it allows for removal of existing
> inconsistencies by having one source of truth.

...

> Amadeusz Sławiński (15):
>    PCI: Sort Intel PCI IDs by number
>    PCI: Add Intel Audio DSP devices to pci_ids.h
>    ASoC: SOF: Remove unused Broxton PCI ID
>    ALSA: Remove unused Broxton PCI ID
>    ALSA: hda: Add controller matching macros
>    ALSA: hda: Use global PCI match macro
>    ALSA: hda/i915:  Use global PCI match macro
>    ASoC: Intel: Skylake: Use global PCI match macro
>    ALSA: intel-dsp-config: Convert to PCI device IDs defines
>    ALSA: hda: Convert to PCI device IDs defines
>    ASoC: Intel: avs: Convert to PCI device IDs defines
>    ASoC: Intel: avs: Convert to PCI device IDs defines
>    ASoC: Intel: Skylake: Convert to PCI device IDs defines
>    ASoC: SOF: Intel: Convert to PCI device IDs defines
>    ASoC: Intel: sst: Convert to PCI device IDs defines

Given the amount of talks we have had internally regarding this subject, 
to my best knowledge series looks good:

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Great initiative Amadeo and, good job.
