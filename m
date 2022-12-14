Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E468F64C41D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 08:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiLNHBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 02:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiLNHBB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 02:01:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3166C21E26;
        Tue, 13 Dec 2022 23:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671001252; x=1702537252;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sX+SOC4iJbQ2x2rV4KS1Usb08CuxvNQO1i+wsS1C3bk=;
  b=RX9rmyVSGGaFxQJpqYl5uPNuHG7ybyNWOAH3p0mTQC4ouuI56oDOJCCH
   wyKNn/JgN56kVDpnyl9v0nrNsesrdB17Kkx11wWMbOUOCxue90yP4R49M
   SDB+1VZwrRPRo89++hGhiax9Jq3M45h4p7HcKtFmw+Vzb4d0oPN95uygj
   BKTCZSBmyMl/NuBaJZBY6sxOZpvgIXxayfmH0fb50aPQmPqJPARbuAOCP
   3p6dhMyi09H4sy1Yczatj5ozgVhxy6km34r1R9AjyA+zj/TGQGrNGNjut
   /JR96PBf+qSNGQ9CUaVQ9CRAGNQqDmc+SeBRcQdc8rAginypr+hjSqCqs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="345398210"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="345398210"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 23:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="648895605"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="648895605"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2022 23:00:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 23:00:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 23:00:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 23:00:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 23:00:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4W9QnC1SPRHkVCm4jyv+VTtLEoBqjDVBAFVsDbvx0ouP/NYjBxcyEyZXUAsryaqjlaVtkqGB5mE8bUuTr3H/WUVvBaU2j8OpguBgXou7FAoY4idKlhigHWMp8eTI1sLQj+kRn4jRd8qHkvp0LY80lhxRtb0bsWcyO/d8GOjnLJahMiHLx3+G6Uvacji1vayhR1ay+Xycsa0TwjqvwBK6Tbfqjm/0X6WVZp+/Ai7H85sE7CGAcq7IXb7vyKpLX0aUXNQepMY36W+SxMbB0tsbtKNFNySq734SWizCspZ2qGHyIH6D9C8uFkTMRJtDd9VdDG/3uSpVjk+1BPhbmEBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpMHyzK8BTJbAX7ggrIFHK4HTgF9Gc0jRIK/V0aGGPk=;
 b=a4eI0+cqALAxnCXFxjUz9gEieORqCdHvr1IyOwZF2VJRB+TrP8kSR5VAWvnc9077pbcxQeZAbiIWZfHRgk1rfsQyYQ6NOwU40NEApf2frx3Gr/pdYvyZJs2yECQaVmY7M2QaRYoXUFuI606BJc+Ghdo6R3NisARITTmXEkbnAp+tywNtgrfdUjH4RnP4mkDnchNpP7vjz/xUP9Y87tlcc8sfX/mrR4cKzfkIWeByU+e2OVzoTXbYCIv77RuBFX6Ay2p7dbVmDYgvokGrMq4ywVM1KoUT09f98gdXE8h0iSFFjUoE/REAhX3nOUIJXAZR08Bm3kJy84ZpK9LxFySCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 07:00:43 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::7d38:853:2b5c:92ae]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::7d38:853:2b5c:92ae%8]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 07:00:43 +0000
Message-ID: <c5be4dd3-824b-9ad0-29c4-d2f4c9149c34@intel.com>
Date:   Wed, 14 Dec 2022 12:30:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports &
 RCECs
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221210002922.1749403-1-helgaas@kernel.org>
Content-Language: en-US
From:   "Gupta, Anshuman" <anshuman.gupta@intel.com>
In-Reply-To: <20221210002922.1749403-1-helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::32) To CY5PR11MB6211.namprd11.prod.outlook.com
 (2603:10b6:930:25::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6211:EE_|SA2PR11MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a828b1a-0bcb-40f4-22d6-08dadda0ea55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbxEBbBjqYSiksi7j5beVqCQDy4s+OanmnCbVoAw6gBPk7+d/JuCqEJeSHFZypDS4E7vdVJlSihvPwD9TMTQ+RStucMa7HYBLXsEJPi6qqru7EL+ny20MKU6C804znnlj1z1p5dQMtiRWEd6ZCkAZErKr5uUSYh9ORAsJiAV6rZTJ6xdwI0QP9NEvPiwDPlGfxt7GRD7zNC2AoluHu9gs9skcb67w8HceqvLaoFunTMl9B1olaW8gPIAeh1+ZtnAb8E/fM6tQDDfYvC1v/CxDxgK8VpKKoK2fa6wJTq8Eim+LxKCzH5J2Rf8jjsPVVKuHMfM8yFAIspGCYXUn4GSQ11FjkCWAgHkYap0EuKQ61Gknz3JO14H0ULhjPJNJQ/3BqerePlPCqq6y3ezJgqB8bPmwXEGLP+UmxztlmoqqRTiqN1UOLzkQEC1VmqfcF3w+/pZVfuD0XkMCgvxtm3TwRg3YUbwvtwGlb5fbSucV3w2U+PyOSsacjxOu4uoXbOAgAyXfXM/DjxYGlbImp6tqXmtqrRh52wliq0TrGGvyu7fxt80S0YnJ6BOeySl7Mmt3P7QApJPId787GJPSj8yxYd2Ypy8+JmJg98JmTjXPKZSKWPnbRsAnFMnnVQF+T1vOfs4/4zA3ddy+1x0ns4JnadlP2W6Elj0UcWbxfdRXo+q5cFzT8R5MQAJJgOHp9ts5fAsehpFGFx1+eMwOjp9lPE4Nmpu4Y0NnQf5B/RyArfxX84o1/RzvqOWDwZU2noM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(2616005)(36756003)(66476007)(66946007)(2906002)(86362001)(54906003)(83380400001)(31696002)(110136005)(6486002)(55236004)(6506007)(478600001)(53546011)(6666004)(82960400001)(26005)(6512007)(966005)(186003)(5660300002)(38100700002)(4326008)(41300700001)(8676002)(66556008)(316002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZSVkZvTyt2MGlBeStiR1VnKzhjWC9vSnN1QzBUV1RJdjZkR1orZTczY05o?=
 =?utf-8?B?Ujh5dmNkWWFrajNmejVlMzlPbWF6cFlUZmZiUXlkYkJlK1Q1V0E0Vm52K0Rq?=
 =?utf-8?B?M3Qra0lPZ2ZtNStVTFZCTTNSTWhmSTY2NDlmcmdCeitFcWtJWnJXVTBxaVNz?=
 =?utf-8?B?UXpDR0JNNXI2Z1FVWE41TExFK08yUHlVTkE5WS8wRzFoVi9Ubjkyek9JMDZG?=
 =?utf-8?B?UGFKZlNXTzRGZWNCYS9NdHNGby9xYm1qb0FRR3pzc2RhNDROTUh0bXdzTGhH?=
 =?utf-8?B?NzMrd0d4ZW1ka3JuS3VQVWdYbUViMGNLVytXaytmUTlxMGFXMkxZRUJOWTBm?=
 =?utf-8?B?OThRelU1OVNrRE5tdUJ4YmtQQmNmY0RvOHFnZnZkemtEckRzdno1bWloWXF5?=
 =?utf-8?B?ekU4TjM2WERzcVprS3Rudk5RVm5wMjNTbEcxekJ0QzRoMlBueXN3eUVXM0Zm?=
 =?utf-8?B?dlE4UktOVDIxT0tQT0ZreDIxRXpacWJTMlNCZDBhTVB0QXgwbFFSNDRFdE0x?=
 =?utf-8?B?K3g4bG5yaE1PajJnQVRTcWNkcUR6SXNZVlpWblluQ3cyaXpDQ0FNck50YUZi?=
 =?utf-8?B?dmRrWHFRcDZKSi82eG85ZldUMldQYWQ2RlpsWGZ4V1U1K3RwZGJualhEcHlV?=
 =?utf-8?B?SlEyd09LeDVJVFU5QWVVOWpOVFZscDdmZ1ZCbi85eTUrZjlMN2dvWDJvT3ND?=
 =?utf-8?B?aGpydXhnUHB3V2ZUb0N1VXQ3VXNJTDVRR3VqTHlYRXFsQTBWb0J4TUk1TVlX?=
 =?utf-8?B?YVQxVnkyelc0TGtxZFhXQUY5dXZDZllsYWUvR2F3OHhTM3NvTXM4c2E4RUdm?=
 =?utf-8?B?ekZMaWhWRHpGL0xmWWppSHJzZDN6aU1EeE0vVHdvS0d1Uk1uNlpvYkRzMmJx?=
 =?utf-8?B?dHVOVDgzbG9DQzg2bW9UZlEzUVhzRDRVWEpYOWcrMFMxS2paMHRqd2R3NXEz?=
 =?utf-8?B?NkFObmZGZFE4eHk5TDNrRnFCNHpNeWFXTWsxZUx2NEZuZ2RKT0FGc1hmcms5?=
 =?utf-8?B?OVdYa2pYSjVDQ3hwdjVTKzc1amsvNkkzUG5aM1gzY0x0b3REOHZwWEYxMS9H?=
 =?utf-8?B?aTh4aGVybTJaZyt2NWJYYk9oaUdpOTlpMDRWU2dXdGlUMlREUEFHd1NXSzZ2?=
 =?utf-8?B?aDdoV3FYcE1YRkt4TncrT2NMMzF3emlGaDJva1YyTzYyQkg0aVVhOVdMbkhH?=
 =?utf-8?B?YTFjaUVXeFFXMkNOUG9FMDJNWGJ2akh2R0RFajZKSW1PaHA2Tk9HblRaQ1Rt?=
 =?utf-8?B?aGd6WWlyKzh6Q0sreXIyYUJQN01KcE53TWViRTNsNnlPdTFmZDEvem42TzVx?=
 =?utf-8?B?Vm81ZHoybDN3dlErT3AzNlZGRUlmZWYzVlA3Wm0waURhVHlVQnUxNkIzMENt?=
 =?utf-8?B?RlBHUVdhdVZYa3FxMUtNbFJmZXlhQVhsMnQwR0IvM0ZuaGM5dk1MRTJkTjd0?=
 =?utf-8?B?Z0liUVN4RlBSS1dDMGZyOHIvZVQ3MGRCWmJ1ai9SeUU5VlpTckI4WWpHSUdO?=
 =?utf-8?B?cGE2Vk5OKytmUDY0c0RkVWZLa1AyYmY0QmRXZTBjVWhOMkFWZ0xRQ3ZSWDRN?=
 =?utf-8?B?R2xQbFozenhNSEpyY2E5VlV0UXlIb1B2eXIxZGVqOWlSNTRBanlXUXhiRWFx?=
 =?utf-8?B?YU9tNWdGZ0kxWUtPQkdmMVJ1WXQ4WE4zZlQrSGpDN0xwVGF2Q01qcTBWTUtr?=
 =?utf-8?B?OTNCUkJlVjN5OWVsbnpCd0ZOd1J6MzhuLzA4RTVhWG1QUno0QlV3NXloa1hl?=
 =?utf-8?B?LzROSVRLc000WTVEY2QvMktISkNzaVlBNEN6TXcvNWdTaXZrd0ZZQXF4N1lm?=
 =?utf-8?B?SDZFdDV1WEZkSmtyRmgraGU0QWpJMkFCdGRYUlhKdkRDMGJ5T1NONFU3K1pX?=
 =?utf-8?B?anVDQ2F3UEpjcG43YklLVS9EMTRia3pwRll1bGxKL3BXQkQ5Y0hadm42Snhm?=
 =?utf-8?B?M3czendhMnBYajMyb1BmZHh3QXRwVXVWclhldEtXbGdlSnZaNHhURGdVUnZM?=
 =?utf-8?B?aTFLeGJWcExkTmZBODJhTjF2M3pFQUZzZGdtZ1hoZU53ZHVLRU9EaXJnbEtS?=
 =?utf-8?B?c2t4RUk4eVFvWkc1YUhvWW84dWJxN0M3enR2cjRLUTVkSTBkNjYrbzdkaEVW?=
 =?utf-8?B?L1BCYUNPMHlsTlJaeXl4bjlVQUZzTWpCU1Q4dmVmK1hFZXNLekM1TTRCai9x?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a828b1a-0bcb-40f4-22d6-08dadda0ea55
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 07:00:43.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgxezoAG6oxvXV7Vf3KmUhS1EIb9llJbrBeeDbBcENefxZlyzHijy6ufBSv4SdqT4RG4LkKsSXRTQ+jK21dVOD95Qx7lhVW+Y5ZLa69n1GY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/10/2022 5:59 AM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously portdrv allowed the AER service for any device with an AER
> capability (assuming Linux had control of AER) even though the AER service
> driver only attaches to Root Port and RCECs.
> 
> Because get_port_device_capability() included AER for non-RP, non-RCEC
> devices, we tried to initialize the AER IRQ even though these devices
> don't generate AER interrupts.
> 
> Intel DG1 and DG2 discrete graphics cards contain a switch leading to a
> GPU.  The switch supports AER but not MSI, so initializing an AER IRQ
> failed, and portdrv failed to claim the switch port at all.  The GPU itself
> could be suspended, but the switch could not be put in a low-power state
> because it had no driver.
Tested with Intel DG2 Card, virtual switch ports bind with pcieport 
driver and enters to lower power state.
Tested-by: Anshuman Gupta <anshuman.gupta@intel.com>

> 
> Don't allow the AER service on non-Root Port, non-Root Complex Event
> Collector devices.  This means we won't enable Bus Mastering if the device
> doesn't require MSI, the AER service will not appear in sysfs, and the AER
> service driver will not bind to the device.
> 
> Link: https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
> Based-on-patch-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> This is a v3 based on Mika's patch at
> https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
> 
> I wouldn't normally kibbitz like this, but I'm hoping to squeeze this into
> the v6.2 merge window.
> 
> Changes from v2:
> 
>    * Test the device type in get_port_device_capability() instead of
>      pcie_init_service_irqs().  The benefits are to keep the device type
>      checking together (this is similar to the PME test), avoid enabling Bus
>      Mastering unnecessarily, avoid exposing the portdrv AER service in
>      sysfs, and preventing the AER service driver from binding to devices it
>      doesn't need to.
> 
>   drivers/pci/pcie/portdrv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a6c4225505d5..8b16e96ec15c 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>   	}
>   
>   #ifdef CONFIG_PCIEAER
> -	if (dev->aer_cap && pci_aer_available() &&
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> +	    dev->aer_cap && pci_aer_available() &&
>   	    (pcie_ports_native || host->native_aer))
>   		services |= PCIE_PORT_SERVICE_AER;
>   #endif
