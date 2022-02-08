Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28F34AD720
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376302AbiBHLbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiBHKau (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 05:30:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460F0C03FEC0;
        Tue,  8 Feb 2022 02:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8TX6bUovBjCYeb/Xjm5RTWRIY6IzGtZfAVQrCS8G6lGTVhaRKwL7BRHU3Bq69rjHQutw5RDIPS1Y5Pkxv3ATY5IG60aIEERWIJstpIDECXwM31y9xxA9BgVeqMTNXTjDaz7QwGNVMnt+tvZgGEVWSikghxSSF9MOeCN0Sn5X65VPcnsQQgHA7/KndY271Nt0H1jF9RBx8WwKP08LHe28W7T40RBaUTb3DtK8g0MW5aTbtnTDrvtNnKxPwi0FsqiEZIYTL04y9bAM3Up/xsGW8rXFS9pR+iBqMGsxSpI42QrC9CEOoVDC1P9HXHtovgjt0vLxKmy2QNBPoDV3Qy3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGOKtAzvndUo9Gp86Q5Hv8bcbSpbGfmQcpUqZWx79R8=;
 b=i57tySB/8xPbOcuHlZTwhF20UMfYvfyoq23SDGyaqfAXg/2jVy+Hn30eCWp38vbRQKYORE6J/jw6FA/HaWdigbUBfPVC9Jk6CJNzEWXLTlOxEtaHJjkFl6weNDoScoPK9vyRqR4Ei2gugtzK/4pKqIkVjFuASHgT1GZGafFlpLMXFD5oUQ1BmmJtA60KmbjZBi6WXMl7spP00X1pQZPIS4LHodN8vcYBOG0Q8lzDqieQu+7jQM2Y0fUZwpIHTiwYoice7I8NzFpZ19efKtIpnMud0T4FU5JSOZYpnQ/hi1Iibfd0Rq85Zi0+MPNkcbLIypM0x+FAJV53n9wVPCHXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGOKtAzvndUo9Gp86Q5Hv8bcbSpbGfmQcpUqZWx79R8=;
 b=n+Ok9x3if1sk8ONYMkNvRPu12pGOtRmkIiujL4a1S2JPwDMTdbVoTlsAG5ewSb1m1iqm+1u6yAeGyu1a0HstyX579FWQTjZpOoi6acodPUYXryLnNVbgzqKnBqscJGEgtsKBbhmS3kvpSz8mgkQ471dX+cRnsNwN89tidRZinoq2HdsagYGZDvs+qLSMh92uuFQNC56sc97o9GMYSjbQ0kuUNx/Q5yg0ZRsC+RdeUmQnVL6AK+lEs1gD9oiR3eg05MpquQ59cwhyt83dgQ3s1ROl8+Fr+MQBvDKiqxWnptDHTduNf+0bXCQsAIn0ynmBT1/Paj/ubwwU31E4LmDzzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 by DM6PR12MB2665.namprd12.prod.outlook.com (2603:10b6:5:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 10:30:47 +0000
Received: from BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::c1b2:224f:101a:a588]) by BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::c1b2:224f:101a:a588%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 10:30:47 +0000
Message-ID: <8f89131c-41a2-02e4-1427-8a5b1704e0ea@nvidia.com>
Date:   Tue, 8 Feb 2022 16:00:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] PCI: Fix the ACPI power state during runtime resume
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220204233219.GA228585@bhelgaas> <2249802.ElGaqSPkdT@kreacher>
From:   Abhishek Sahu <abhsahu@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <2249802.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::10) To BL1PR12MB5304.namprd12.prod.outlook.com
 (2603:10b6:208:314::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cee501c-4b0a-473b-ffd6-08d9eaee11c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2665:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2665C8CC5B8B05260ABE4EF4CC2D9@DM6PR12MB2665.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+Qm4FzkOfHmaH4dcykzAp+0JSHMAmUeWh2PMaiQ5emJubTraOs+UO8/oIPMD3bkDCXXgFNa4ZdiWQwca0iJjT+4Y1z3APFw8mX/7tOuypHuXP7jT9Rs2v6Cns95xpSwNkjdaGCA3ERqFw+hj8cPdJltshF48wFse1x8mPN6Yj7av1mIwTPmEvyzfTKTZONTWduRq9gDI+/bufq+7ofIZKwUSB2qA9GOmWGCkYly2ywnnbfjl4Nw2oQyGhrLsTU3ytyjBBlptQIMdKn4hnj3aps6YM0CnhV6NYqWRHRXs1XFnuh8JnEU0P1gTQhsneFjPeqRqwA3xs5zHX0PXPpldd701RuRAl8btDPWkrtEpcC7cc4wYT1sxAZ9Vxp5U3xT4ICk+XTbeB/+D17kBRzxYbdUGLp5xdxuYAc/XhkLx5gmet5KkkPpgf0Ux4A9VASgEygLpnxjQS/9unS9J/dK6tHu7pOyBDOfO4F2jrVr4k/T1tN+AOc03/fOxdh4U9oS7fNyP9Ac8zWKxWfKcLTZ4zEKLKsWrq1vcxsbpqfRfNmWWSQ9YyUFSb4FCZQl11LTbcNykYUGXcWEV6w1xtXCHr9eVjKeUYAFFbNoOCkE5EetiP9NOqttWha5o/+dBzHEfsEavKkOIoseQSpy1d2XCoPoNGymWueoA1PEouG13xKhBvZVV2OK4Ka3DH6NcKOrAgHmva2nuomf4hAl3lpW3l087BnF+nZ7MlesbgCh5JWv0BK/6oBzCfCO1g198ggI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5304.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(6512007)(2906002)(5660300002)(53546011)(83380400001)(6486002)(26005)(186003)(36756003)(6666004)(31686004)(6506007)(316002)(2616005)(508600001)(31696002)(86362001)(66946007)(54906003)(66556008)(66476007)(110136005)(38100700002)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpORWsxMWlpNTJ0eFhEZVJPZjlTbzJLZlRXQVFkOFlFa0hWQzVLMTkrM1lw?=
 =?utf-8?B?cjJ4K0RhR085YXhUMUVWdXBhRVl0SUh5T3NmY2IvVzIyejJuRmJkUE1ERk5V?=
 =?utf-8?B?REs3TEkyNDU3MDl4anBYUUI3NjdZUWxGSXJPenFKcStBMS8wTmZ0YnQwNWtS?=
 =?utf-8?B?UjFCUWl2bVMveGk1NEpiMHFlb1psQWVtQjZEenFnTlVlQ3lMWlltb21lUGxM?=
 =?utf-8?B?NkFvLzNTTVY4dGE4RHcxTkNhVG9CL0xmczFmM0FYYWMwRmtlMjVtODdjb2xi?=
 =?utf-8?B?RmJFcmliRnV5OXIrenpqakpGVU1uSHdMUlhYdlFIVlROS1hCSnB5MU1ra3pl?=
 =?utf-8?B?TFFiUnB2bjRKK3l4eGRiT2NtQWxaLzlFWmR6VE9BY2I1WG1WZGdsV1JiR2ZF?=
 =?utf-8?B?NmpCdFJQRGcrOUJ3clpnMHE5dnVLWE9sQWJRZUNyWVcyVDVYWFMvUVNqeGlJ?=
 =?utf-8?B?STJsRi95NUgveUcrR1FlY1lWZEtKdXR0SSs5Rk1LenNrUjFQdmNzZE43UGlX?=
 =?utf-8?B?Zk51NSs0TnhzTjhlTWdzWEJFeFBPZ2hOZmh2L2lRQThoM3NqbUdsQUM3OFlK?=
 =?utf-8?B?bWo3MW9ERThsVHEyMEY0N1R0akQxZWNjSWFob3pNdlp0bjI0eGh4cVJXUlov?=
 =?utf-8?B?S0I2WDZXM09IaGNnc1oycFJDaHN6Z0lqcnl4ZHhBTnZUZm96Tk5DaEZzMVcz?=
 =?utf-8?B?emQrQWZSVFpQM0c3bm1ZNVZjTERZMGNxSmxWb3hlUDFOSzFUMGU2Wm90aXdk?=
 =?utf-8?B?dUFyQmpwWHdxdWhJMzM4ZXJ0UkUwaVRoOHo0ZzJvNyt1WlNVaUJNUlRRbWta?=
 =?utf-8?B?Q3JlL1VWekJrZXdMem1qTDVEakpaSFBLd3dwWWZlVXZkdU8rUlhYYnU5K0Zp?=
 =?utf-8?B?WFRrZkd3cWdINTNpZlZVb3hLempPcTcwQTYvbmF0ZmtLYjQ3b3NnZTAvcGJN?=
 =?utf-8?B?eG5kdllKS1E1eXliQm9sQjIzcVpxOVQ5dUgyNml4ck95UmN1S01zQkhHNXVY?=
 =?utf-8?B?c3o2QVN5Z1RCOHd2TXNabUZrZ2xoSnRsT2tiRkwzZmlGYkdBMkVvazB2QUF1?=
 =?utf-8?B?aTRJQm11UDdvQWhlQUVuMWNOeVFFQ251OTh5RnpsV2RwL0gzMmk4ZktaQjJx?=
 =?utf-8?B?cW9TNGNMRFZZd0FmOHcyeTJJdy9NL2ROUHNydWRxd1crYzNNZGJjS2xMYyto?=
 =?utf-8?B?VHhuYnlldFBxUVFxZ3VyL1BEUlM2NFltMmUwRXFoTkwwNW5MY3l5b2Z4Y0ZG?=
 =?utf-8?B?b2VJL0xuZ1k2cEJYb2JmVHBlcG5leklpUkNOMGcxTGhNNWh5N2hlUEZmQjRS?=
 =?utf-8?B?WTlQOFhrdWJ1eFFIM1BXTWJrWWkySEVKMUtFc09oQk1EVXBOTjBzVVVLREVD?=
 =?utf-8?B?MVpDMXlVbmNiMzVxaml4SFJjUVhjSko0U1B2ZjFzQUQyYjNXUHBFUy9Sb0l3?=
 =?utf-8?B?LzF6eXRBdmdDUXdqVjduYXptMUNZaExETjZaQkxjZVZmVFRPZWNoMVkwR3BI?=
 =?utf-8?B?MXBzL1FSbTh2TGMwRzVsaUxQVkc4MmtrdndNcmg5b0JuVkt6a0JoYTF0aDV1?=
 =?utf-8?B?aDRCZFFoc2hBT2FXV1F0RUxUdjNUU0RBRVVSZldUNStUZVczbjNEZVJsYVJ6?=
 =?utf-8?B?VGFIbU11Vjc5ZTJ3QmtYRzczSFZ2THJQSDFtZ2FIeFJ4QzhmUlcrMFdDM1Yx?=
 =?utf-8?B?K1FhS2pJSFhkWm9qU0lyR1F4YVEwU0ptdGpJTnRwYmYwanZCYkdhM0ppd2tj?=
 =?utf-8?B?VFpoSUtuQ2tuRjRnT21MZ1hLNlc1YXhhRlhNRm9HeGJCWHZnN3JINTFZLzlE?=
 =?utf-8?B?NHlJUmtBa3JCTDE2LzZ3dDRFTzl0RkErRXFCdDBRQmZ4RWtZckVtd0ZGY3Ny?=
 =?utf-8?B?alhqRVJkZXJoRitxYzUyYk8zNWR3MTlrbnhNTFhCZ081cVM5NkdaeXlJbis5?=
 =?utf-8?B?RjdXbll4VWtoUmQyelFwSzkwa1ovMzN1UGRXWThmU3FQb2NkbitBSjFFRGFO?=
 =?utf-8?B?b09CdGtYUVFFTFEybXdRdi80UHlOVlFkR0lnMEkrYkdEWDFEWlMwRnEvSm1s?=
 =?utf-8?B?WU5ZQkhsTk1TSWM1UEQ5MmNYb3lPaEZNMVl0dGhDbVFnd2U4ZlA1THNCNzEx?=
 =?utf-8?B?Y2dLNCtiN04rT0tSWkNWMzVtN1pyWTJHYm10bnpVUGs3blZaUllhSGlsb3pB?=
 =?utf-8?Q?+G7w9lfePT9Zd8uh04HGlYs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cee501c-4b0a-473b-ffd6-08d9eaee11c0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 10:30:47.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjlPOvIlBV+m1gQgVSO8i4xpHuByDSztOgmJXRj1I+QPucSjQSoNHn99tVPwqVNxHtqxouy/pzP27VpAF32idg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/8/2022 12:28 AM, Rafael J. Wysocki wrote:
> On Saturday, February 5, 2022 12:32:19 AM CET Bjorn Helgaas wrote:
>> [+cc Rafael, hoping for your review :)
> 
> +Mika
> 
>> Wonder if we should add something like this to MAINTAINERS so you get
>> cc'd on power-related things:
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ea3e6c914384..3d9a211cad5d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15422,6 +15422,7 @@ F:    include/linux/pm.h
>>  F:   include/linux/pm_*
>>  F:   include/linux/powercap.h
>>  F:   kernel/configs/nopm.config
>> +K:   pci_[a-z_]*power[a-z_]*\(
> 
> It seems so, but generally PM patches should be CCed to linux-pm anyway.
> 
>>
>>  DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
>>  M:   Daniel Lezcano <daniel.lezcano@kernel.org>
>> ]
>>
>> On Mon, Jan 24, 2022 at 05:51:07PM +0530, Abhishek Sahu wrote:
>>> Consider the following sequence during PCI device runtime
>>> suspend/resume:
>>>
>>> 1. PCI device goes into runtime suspended state. The PCI state
>>>    will be changed to PCI_D0 and then pci_platform_power_transition()
>>>    will be called which changes the ACPI state to ACPI_STATE_D3_HOT.
> 
> You mean PCI_D3hot I suppose?
>

 Yes. It should be PCI_D3hot here. 

>>> 2. Parent bridge goes into runtime suspended state. If parent
>>>    bridge supports D3cold, then it will change the power state of all its
>>>    children to D3cold state and the power will be removed.
>>>
>>> 3. During wake-up time, the bridge will be runtime resumed first
>>>    and pci_power_up() will be called for the bridge. Now, the power
>>>    supply will be resumed.
>>>
>>> 4. pci_resume_bus() will be called which will internally invoke
>>>    pci_restore_standard_config(). pci_update_current_state()
>>>    will read PCI_PM_CTRL register and the current_state will be
>>>    updated to D0.
>>>
>>> In the above process, at step 4, the ACPI device state will still be
>>> ACPI_STATE_D3_HOT since pci_platform_power_transition() is not being
>>> invoked.
> 
> I'm not quite following.
> 
> I'm assuming that this description applies to the endpoint device that was
> previously put into D3_hot.
> 

 Yes. This is applicable for endpoint devices which was previously put
 into D3hot.

> Since its current state is D3_hot, it is not D0 (in particular) and the
> pci_set_power_state() in pci_restore_standard_config() should put int into
> D0 proper, including the platform firmware part.
> 

 The pci_restore_standard_config() for endpoint devices are being called
 internally during wake-up of upstream bridge. 

 pci_power_up(struct pci_dev *dev)
 {
      ...
      if (dev->runtime_d3cold) {
        /*
         * When powering on a bridge from D3cold, the whole hierarchy
         * may be powered on into D0uninitialized state, resume them to
         * give them a chance to suspend again
         */
        pci_resume_bus(dev->subordinate);
    }
    ...
 }

 For the upstream bridge, the above code will trigger the wake-up of
 endpoint devices and then following code will be executed for the
 endpoint devices:

 pci_update_current_state(struct pci_dev *dev, pci_power_t state)
 {
    if (platform_pci_get_power_state(dev) == PCI_D3cold ||
        !pci_device_is_present(dev)) {
        dev->current_state = PCI_D3cold;
    } else if (dev->pm_cap) {
        u16 pmcsr;

        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
        dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
    } else {
        dev->current_state = state;
    }
 }

 In the above code, the current_state will be set to D0 for the
 endpoint devices since it will go into second block where
 it will read the PM_CTRL register.
 
>>> We need call the pci_platform_power_transition() with state
>>> D0 to change the ACPI state to ACPI_STATE_D0.
>>>
>>> This patch calls pci_power_up() if current power state is D0 inside
>>> pci_restore_standard_config(). This pci_power_up() will change the
>>> ACPI state to ACPI_STATE_D0.
>>>
>>> Following are the steps to confirm:
>>>
>>> Enable the debug prints in acpi_pci_set_power_state()
>>>
>>> 0000:01:00.0 is PCI device and 0000:00:01.0 is parent bridge device
>>>
>>> Before:
>>>
>>> 0000:01:00.0: power state changed by ACPI to D3hot
>>> 0000:00:01.0: power state changed by ACPI to D3cold
>>> 0000:00:01.0: power state changed by ACPI to D0
>>>
>>> After:
>>>
>>> 0000:01:00.0: power state changed by ACPI to D3hot
>>> 0000:00:01.0: power state changed by ACPI to D3cold
>>> 0000:00:01.0: power state changed by ACPI to D0
>>> 0000:01:00.0: power state changed by ACPI to D0
>>>
>>> So with this patch, the PCI device ACPI state is also being
>>> changed to D0.
>>>
>>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
>>> ---
>>>  drivers/pci/pci-driver.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>> index 588588cfda48..64e0cca12f16 100644
>>> --- a/drivers/pci/pci-driver.c
>>> +++ b/drivers/pci/pci-driver.c
>>> @@ -521,14 +521,22 @@ static void pci_device_shutdown(struct device *dev)
>>>   */
>>>  static int pci_restore_standard_config(struct pci_dev *pci_dev)
>>>  {
>>> +   int error = 0;
>>>     pci_update_current_state(pci_dev, PCI_UNKNOWN);
>>>
>>>     if (pci_dev->current_state != PCI_D0) {
>>> -           int error = pci_set_power_state(pci_dev, PCI_D0);
>>> -           if (error)
>>> -                   return error;
>>> +           error = pci_set_power_state(pci_dev, PCI_D0);
>>> +   } else {
>>> +           /*
>>> +            * The platform power state can still be non-D0, so this is
>>> +            * required to change the platform power state to D0.
>>> +            */
> 
> This really isn't expected to happen.
> 
> If the device's power state has been changed to D3hot by ACPI, it is not in D0.
> 
> It looks like the state tracking is not working here.
> 

 The state setting to D0 is happening due to the current logic present in
 pci_update_current_state(). If we can fix the logic in
 pci_update_current_state() to detect this condition and return state D3hot,
 then it should also fix the issue. 

 Thanks,
 Abhishek

>>> +           error = pci_power_up(pci_dev);
>>>     }
>>>
>>> +   if (error)
>>> +           return error;
>>> +
>>>     pci_restore_state(pci_dev);
>>>     pci_pme_restore(pci_dev);
>>>     return 0;
>>
> 
> 
> 
> 

