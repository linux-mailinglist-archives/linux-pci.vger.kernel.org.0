Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D189E4F6B53
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 22:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiDFUZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 16:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiDFUYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 16:24:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CB334A20A;
        Wed,  6 Apr 2022 11:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGKt0Myh/cYdnGhf+f41PSGHhsSPZQKt+DGUg77rx6fOV2DorFwxV7deHm+CXrvPAfzJe8ivn8+U6hHX88v69bF0+QSS4qwXCdrojYFCbptp8TAJ/JRWFSlYh8BTt59QxEOHGYFigBxhzeCZA8PH8WRDD7DJeLkzgQM/IZyZh0b7R/ddwpyfslT8PqWQq72jPzRlU2S//9WMXpv/YYjvO0GiihHcfWKYy0QIAGPB9qIR3z0dlikcjIS1ZXAKmxPiCf0QQ3WORFposQUjFGbmJHKenU4cWBOQj14siu6mEpsumHfZ590hxb8addO0Wbg127lTW/fXXV+iTTAbLxOprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPZD/3TZYoFUO+G+fja9md+E1X2cE3fSaEjnby7LR4E=;
 b=Eb9Fp+OyPsGFH58FwewVKHCG+l1oSn8hVN2z+k/q0q0MAjSSUZ9dsw3WoQkb5OfyhGCnYZgH7nUOxh9RCr/t9qZoEOmSh5azJXSbNDFUDIasey0V3YU3XDbZUT/ujKnaqmAYqsKa6J6zjO+SyUg48CHfphCCWH3zIhw11TESqFqhBtBqsmSZnKUGNDsu+nOBPNTGbM18Kbm/cS25rRz/kP5GgthaP45/ATIFAgVccVnZF9O3tNnO/ohjs9Reu5pSbaO+cuM/LOXFZJulcrt1ymCBlil8FHEEZb/Nr2L6hOzZhgEnln4WH141gK0IA2WcHYga5d8M3F+WMXzEJhK71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPZD/3TZYoFUO+G+fja9md+E1X2cE3fSaEjnby7LR4E=;
 b=glg5YEg717sN/cg2NmPyauWnavXs3/5Qo4hMWyfmnBhArCUzuysP+a6a+wdOCe9NQny2oclecG5s6lICxyXtyUPwLQHNqiygljlXW0I7IzOsOIppfUgt0pX/g+scwCRIdIAOUmS43bTdLlWk1iCV9gkwncz8SO4ySkheGgFPGUygm6Caz1aLbXYFcTVjc9VVBV5JCHpDFwtcA7oWe7yVODJe7eXQG74hJlHNdUKh+L3LaO9aMxZ7ga0gWLTqZjFPx2Vy9s0KQ4pVYItezpxUs6FGnBs7eGqf087nU7R9v51Qpi4zujlt68GucnH0RGJQyV0o2mRtiP14sGR6h0Tyig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 18:43:30 +0000
Received: from BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::d1ee:362f:4337:d03b]) by BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::d1ee:362f:4337:d03b%7]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 18:43:30 +0000
Message-ID: <e5fd300b-1ec5-934f-cd98-611ce81aa19c@nvidia.com>
Date:   Thu, 7 Apr 2022 00:13:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: Fix the ACPI power state during runtime resume
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220204233219.GA228585@bhelgaas> <2632919.mvXUDI8C0e@kreacher>
 <67fa293b-7957-df11-dd86-7d8d6d9802df@nvidia.com>
 <11967527.O9o76ZdvQC@kreacher>
X-Nvconfidentiality: public
From:   Abhishek Sahu <abhsahu@nvidia.com>
In-Reply-To: <11967527.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::13) To BL1PR12MB5304.namprd12.prod.outlook.com
 (2603:10b6:208:314::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50d1f3c5-9d8e-4f67-caa8-08da17fd5843
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49159C167CF8E24E95555A3FCCE79@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ops1eQxZUb1ZxXWzP7PoRudHGAUYr57BQl42AGfmd9EyWXMTthkCU4XxesWverTThUmBkgnjYuKpJg/Oh1dxlBSXmULOCmv/UcsUDdnRJF1T//Zb9vK8S20U/Zk+gnPUDHkTznpDQMYAhw2fiZ/uAwhQ9imAjb60LXD9UgNdDmcCth6xPuzLcvcWFne89yjnQc7JVKRhGCd8+ECD5hcnTuM9wBHZV4910L9gT3n3hhU3U4Ok2JxC5BFBGIzpnHbgw5bkdASLog20tIObmBXgxBEiJvIm3DQmrEAdGtpNdY8Dr4A44JhhnzXjw0FGO/cCXsvynoxGjitcqDch6UpBM/NgFjIkcHVes+b4q60JqOvbKo0hy6SiNIORqufyn2+g/g0vlJ/0aDceACdqo/Jsds4k9Qp9QI4QyW33a8mRlSAmtUNtbWqR0kRr7yTfwD/V8CdZhACeAwiaH3xGNk492b8m0i9TjSyEK92Itc4DUcpmqS6lJCQvcom/zdntSdP5CSDoLV8RBpLLNkTlCndy/qz9zQtQWZERaq8mtS+V1mhhHEaZ5Mu+M96Dz3KyxuX8KEWfbRTOssCTt+3Xq+TPrbJMvCykKf57qc5ZH9auUD1ENasWc3eDYGLXC7++3kf845kQYv2YG5MeshyRhztCWflbD9zH4PtpU5XZjZ+NjDrwaT2jZ1ax+++LfwVAjSBJBFqssnDym0Kzfg3EnT6rQU8pM54bk3PS/TmjYe30UeDEieZGP/wvkz51l3VmMV0pc5ll5cF/pVqzCdFXXXZjTi7KEr17R5J1MISkxT3+IMBoSYYemHoSzFJaSDTA6CF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5304.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(2616005)(83380400001)(38100700002)(31696002)(86362001)(84970400001)(66476007)(36756003)(6916009)(316002)(2906002)(6486002)(966005)(54906003)(5660300002)(8936002)(30864003)(66946007)(66556008)(4326008)(8676002)(31686004)(6506007)(6512007)(55236004)(53546011)(6666004)(508600001)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXl4NlNHZzJxNjMwZmtVNUNVZHVmaFV0NzBCY2FyTmM0MUVkYmxxVXJYUVEy?=
 =?utf-8?B?bmF0TEFMOFZMQzRLSGt5dFRTRVVaQldwOFNrWWc4eHVIZXhhdmxZZHNjczBr?=
 =?utf-8?B?UWxVRi9KaXo4OXRKSXliV0xIb3ZDdW9oWUF1MldhYnh4a0N0U0hLZ1Y1SHFS?=
 =?utf-8?B?b29ra0xXRzB0L2F6Y2J4dEJRZUhNTFBiUUFSMWpBVkt4aEZpM2xWTHBWYnMv?=
 =?utf-8?B?cVhodSt0cG9oRzAyU0lHdVR6T3BsejdEZnFMZzB5OGZ4NVppRWIyb3pENWFv?=
 =?utf-8?B?ZnVNY2hzZDVoZWtYN2I3SDZ0Zld2eUxlRzJoOEtTYzFxb2tMY0w4WlgzUUNx?=
 =?utf-8?B?Z2g1SmE2MGIyVkp5eVZOWlp6YUNjajBrTndhQkVLWUVwN1NBZGMzbC9mbUtT?=
 =?utf-8?B?M1QzQTlEUjJhQXQwZWpxUEFxbE5zdFNud1Jab0Y1SHRscGZ6eDFYQkFwZHY0?=
 =?utf-8?B?MERzc2VHVGtJNVF2Z3NmMnAzV2dINktFTnFJMVBLQjRySkwvelBPMlRkaUVJ?=
 =?utf-8?B?UWxTRi9LVmd3QU9RNk9VcnJtcHh2TG16NUhSMHVrL2tDbTZ0U1JYUzZHQ2Jv?=
 =?utf-8?B?SXVmdENiTzc4VjdOQS83L1VaeGM1RGM5Wm9KSVlXb3VOaU0yQTZBeURkdFpv?=
 =?utf-8?B?VFdXVWR3alpFenowdS9SczZXbWxjb0xZTlp0Wk5RSHd0cDVOWUV1THhhaEpi?=
 =?utf-8?B?MUVlbDl2TnNDbHE5VHpBNEhCbC9uK2ZXdjMyakNNVVlRczJJVzVJZENyZ1Vs?=
 =?utf-8?B?SUlXdDh4blpHS1ppemRmOXJVYjJUd1lYZWZHcDZKN1pXQ2w5VEF4cHFXc3o4?=
 =?utf-8?B?NEk3UFVQd2k0cm5MR1AycGFhT0dsVUFvblhlWDQyT2IzMFJHSTQ5RE9RME0z?=
 =?utf-8?B?aWRIck9wOFVHaVVXMkNvQzlMMTQ3bVdGT0MyekJNeDZ3NFAwdWtMdUEzZmVx?=
 =?utf-8?B?SC90K3MrZzl6ZE9qV1QwRHFuSTIvSkZTc0ZJVzlLRDN1WU5kTzRYSTNyMTRI?=
 =?utf-8?B?aFluUmxMTnV3Q2xhVFBXb2dQK3RZM2JUUXVEd216d2RFdjdtdEQvRkxkY2tZ?=
 =?utf-8?B?UlFnMnV4VXFuekJCYXVCbVZxVDFNSzl5MTB1dkp3NFdUYy9PTmR2clplaW54?=
 =?utf-8?B?QkRSUkpjQXhMazNlR3l1WElkWHkvMzN3cUpJZ3VaMjlBa3kxRDZJV0svZ0U2?=
 =?utf-8?B?R2NFQXdUU1kxK0piSDVnOGFRdC9pa3h3R216dXdBNEJRd3lzVzBjMVhSL1c5?=
 =?utf-8?B?Q2xuRVNuL0pQcHdRc0loRTRCTGNrSTNMUjNUSmE5d0ZtMk8vWXNmWnJQTGNX?=
 =?utf-8?B?RUhadSs0VXRrVHNhRXdNU2s3S3Zhb1oweFNWd3VrWkJMVncvOVAyOEpIdmZa?=
 =?utf-8?B?VGh2WUQ5akhNL2x2WWRLaU8vMVVnNjNlNDhSM3BvR2wxbzE2NUtVVkkzZlB3?=
 =?utf-8?B?dEw4ZVhEbjNudTZxNTVkekNWLzAwK1RtUnRIeTJXNi85WGt4R1MzRjNMbity?=
 =?utf-8?B?MXVibGJSbFQ2U25vUmhOS3VkM255ZUZwd3JKOUhMVDdMSEt0a1E0aUdpMGRG?=
 =?utf-8?B?b280Q1JxOFlpczFmSnFWMUdMdXMvUExoYmF2NzZwUTUyU0w4Z1o2NFdvS1R4?=
 =?utf-8?B?K2RHU2x3dXJCdXEzZmc4QTV0ZkIrWTdqcU1STmN6QW5hRWNHd3BxNHZuRnBw?=
 =?utf-8?B?WU44cFlZQXJkOHc3VXlwdDhaQ3V6UEVVbktra29XVkVmUzJSeHBacy9LaUpJ?=
 =?utf-8?B?YlBTZGNZUUw4TjQzenZYQlBPd0M4dkhaNVBQVmZXZFREUGk5b3JxTG4xK09u?=
 =?utf-8?B?M21Ja2pURTN3TVpCTWtHR3ZPMmVpMnFJYmoxRVZLRlVCWlZLNXBzejhFWjZQ?=
 =?utf-8?B?aHJld3ZrNEtVTXBBOVZRam1hdWtDb0xBcW42dkkyczlKckFCdzZlVjgyaFdE?=
 =?utf-8?B?UmdlU013UUYwTi9NejBSUHdCMWwzMjFQRWwrNGxVT1pWUzIxaHQwWktOYkRs?=
 =?utf-8?B?anFjL01BY3RobXRma3RtSTdRRm1xcVpTUnFLNXY1VEVyMU1hTDk2eWhNOFRy?=
 =?utf-8?B?ZlpzQnBQK2pQMEtNZmpsVXlFeWlxZWc0U1VwM1BhdTFyRllHd2dqTm1tY2tN?=
 =?utf-8?B?WmVoM2ovMUplcE10OUpjSDB2dHorczV2UkphckJqQWNTbXNNNGJmdWIvbnFV?=
 =?utf-8?B?WitIdTM2bk91VnU1OEpTdE1SYTVXeTVCWHl3akVQaHJQU0xqdnF5eitVN0Vu?=
 =?utf-8?B?NndCa3J4WlU5cUszQVBiejZUUWVhSXR1clRjTHRMS0Y2dGJoWmw5U0d3OVp2?=
 =?utf-8?B?NjRwMUxlRTUxL3B1L25Lc3B5RTRZdkw5YmdRUzR1UjBsYUV1Sk4wdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d1f3c5-9d8e-4f67-caa8-08da17fd5843
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 18:43:30.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hde31ND2EPsdZHhocV5VSuafqfeOdqmaVKSBvWcxQG7mdaeyqT1+bSCNtIO7FklgaAaV3/krnbSCOoXUOUxuyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/6/2022 5:36 PM, Rafael J. Wysocki wrote:
> On Wednesday, April 6, 2022 7:32:45 AM CEST Abhishek Sahu wrote:
>> On 4/5/2022 10:20 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, April 5, 2022 6:36:34 PM CEST Abhishek Sahu wrote:
>>>> On 2/8/2022 4:00 PM, Abhishek Sahu wrote:
>>>>> On 2/8/2022 12:28 AM, Rafael J. Wysocki wrote:
>>>>>> On Saturday, February 5, 2022 12:32:19 AM CET Bjorn Helgaas wrote:
>>>>>>> [+cc Rafael, hoping for your review :)
>>>>>>
>>>>>> +Mika
>>>>>>
>>>>>>> Wonder if we should add something like this to MAINTAINERS so you get
>>>>>>> cc'd on power-related things:
>>>>>>>
>>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>>> index ea3e6c914384..3d9a211cad5d 100644
>>>>>>> --- a/MAINTAINERS
>>>>>>> +++ b/MAINTAINERS
>>>>>>> @@ -15422,6 +15422,7 @@ F:    include/linux/pm.h
>>>>>>>  F:   include/linux/pm_*
>>>>>>>  F:   include/linux/powercap.h
>>>>>>>  F:   kernel/configs/nopm.config
>>>>>>> +K:   pci_[a-z_]*power[a-z_]*\(
>>>>>>
>>>>>> It seems so, but generally PM patches should be CCed to linux-pm anyway.
>>>>>>
>>>>>>>
>>>>>>>  DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
>>>>>>>  M:   Daniel Lezcano <daniel.lezcano@kernel.org>
>>>>>>> ]
>>>>>>>
>>>>>>> On Mon, Jan 24, 2022 at 05:51:07PM +0530, Abhishek Sahu wrote:
>>>>>>>> Consider the following sequence during PCI device runtime
>>>>>>>> suspend/resume:
>>>>>>>>
>>>>>>>> 1. PCI device goes into runtime suspended state. The PCI state
>>>>>>>>    will be changed to PCI_D0 and then pci_platform_power_transition()
>>>>>>>>    will be called which changes the ACPI state to ACPI_STATE_D3_HOT.
>>>>>>
>>>>>> You mean PCI_D3hot I suppose?
>>>>>>
>>>>>
>>>>>  Yes. It should be PCI_D3hot here.
>>>>>
>>>>>>>> 2. Parent bridge goes into runtime suspended state. If parent
>>>>>>>>    bridge supports D3cold, then it will change the power state of all its
>>>>>>>>    children to D3cold state and the power will be removed.
>>>>>>>>
>>>>>>>> 3. During wake-up time, the bridge will be runtime resumed first
>>>>>>>>    and pci_power_up() will be called for the bridge. Now, the power
>>>>>>>>    supply will be resumed.
>>>>>>>>
>>>>>>>> 4. pci_resume_bus() will be called which will internally invoke
>>>>>>>>    pci_restore_standard_config(). pci_update_current_state()
>>>>>>>>    will read PCI_PM_CTRL register and the current_state will be
>>>>>>>>    updated to D0.
>>>>>>>>
>>>>>>>> In the above process, at step 4, the ACPI device state will still be
>>>>>>>> ACPI_STATE_D3_HOT since pci_platform_power_transition() is not being
>>>>>>>> invoked.
>>>>>>
>>>>>> I'm not quite following.
>>>>>>
>>>>>> I'm assuming that this description applies to the endpoint device that was
>>>>>> previously put into D3_hot.
>>>>>>
>>>>>
>>>>>  Yes. This is applicable for endpoint devices which was previously put
>>>>>  into D3hot.
>>>>>
>>>>>> Since its current state is D3_hot, it is not D0 (in particular) and the
>>>>>> pci_set_power_state() in pci_restore_standard_config() should put int into
>>>>>> D0 proper, including the platform firmware part.
>>>>>>
>>>>>
>>>>>  The pci_restore_standard_config() for endpoint devices are being called
>>>>>  internally during wake-up of upstream bridge.
>>>>>
>>>>>  pci_power_up(struct pci_dev *dev)
>>>>>  {
>>>>>       ...
>>>>>       if (dev->runtime_d3cold) {
>>>>>         /*
>>>>>          * When powering on a bridge from D3cold, the whole hierarchy
>>>>>          * may be powered on into D0uninitialized state, resume them to
>>>>>          * give them a chance to suspend again
>>>>>          */
>>>>>         pci_resume_bus(dev->subordinate);
>>>>>     }
>>>>>     ...
>>>>>  }
>>>>>
>>>>>  For the upstream bridge, the above code will trigger the wake-up of
>>>>>  endpoint devices and then following code will be executed for the
>>>>>  endpoint devices:
>>>>>
>>>>>  pci_update_current_state(struct pci_dev *dev, pci_power_t state)
>>>>>  {
>>>>>     if (platform_pci_get_power_state(dev) == PCI_D3cold ||
>>>>>         !pci_device_is_present(dev)) {
>>>>>         dev->current_state = PCI_D3cold;
>>>>>     } else if (dev->pm_cap) {
>>>>>         u16 pmcsr;
>>>>>
>>>>>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>>>         dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
>>>>>     } else {
>>>>>         dev->current_state = state;
>>>>>     }
>>>>>  }
>>>>>
>>>>>  In the above code, the current_state will be set to D0 for the
>>>>>  endpoint devices since it will go into second block where
>>>>>  it will read the PM_CTRL register.
>>>>>
>>>>>>>> We need call the pci_platform_power_transition() with state
>>>>>>>> D0 to change the ACPI state to ACPI_STATE_D0.
>>>>>>>>
>>>>>>>> This patch calls pci_power_up() if current power state is D0 inside
>>>>>>>> pci_restore_standard_config(). This pci_power_up() will change the
>>>>>>>> ACPI state to ACPI_STATE_D0.
>>>>>>>>
>>>>>>>> Following are the steps to confirm:
>>>>>>>>
>>>>>>>> Enable the debug prints in acpi_pci_set_power_state()
>>>>>>>>
>>>>>>>> 0000:01:00.0 is PCI device and 0000:00:01.0 is parent bridge device
>>>>>>>>
>>>>>>>> Before:
>>>>>>>>
>>>>>>>> 0000:01:00.0: power state changed by ACPI to D3hot
>>>>>>>> 0000:00:01.0: power state changed by ACPI to D3cold
>>>>>>>> 0000:00:01.0: power state changed by ACPI to D0
>>>>>>>>
>>>>>>>> After:
>>>>>>>>
>>>>>>>> 0000:01:00.0: power state changed by ACPI to D3hot
>>>>>>>> 0000:00:01.0: power state changed by ACPI to D3cold
>>>>>>>> 0000:00:01.0: power state changed by ACPI to D0
>>>>>>>> 0000:01:00.0: power state changed by ACPI to D0
>>>>>>>>
>>>>>>>> So with this patch, the PCI device ACPI state is also being
>>>>>>>> changed to D0.
>>>>>>>>
>>>>>>>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>>>>>> ---
>>>>>>>>  drivers/pci/pci-driver.c | 14 +++++++++++---
>>>>>>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>>>>>> index 588588cfda48..64e0cca12f16 100644
>>>>>>>> --- a/drivers/pci/pci-driver.c
>>>>>>>> +++ b/drivers/pci/pci-driver.c
>>>>>>>> @@ -521,14 +521,22 @@ static void pci_device_shutdown(struct device *dev)
>>>>>>>>   */
>>>>>>>>  static int pci_restore_standard_config(struct pci_dev *pci_dev)
>>>>>>>>  {
>>>>>>>> +   int error = 0;
>>>>>>>>     pci_update_current_state(pci_dev, PCI_UNKNOWN);
>>>>>>>>
>>>>>>>>     if (pci_dev->current_state != PCI_D0) {
>>>>>>>> -           int error = pci_set_power_state(pci_dev, PCI_D0);
>>>>>>>> -           if (error)
>>>>>>>> -                   return error;
>>>>>>>> +           error = pci_set_power_state(pci_dev, PCI_D0);
>>>>>>>> +   } else {
>>>>>>>> +           /*
>>>>>>>> +            * The platform power state can still be non-D0, so this is
>>>>>>>> +            * required to change the platform power state to D0.
>>>>>>>> +            */
>>>>>>
>>>>>> This really isn't expected to happen.
>>>>>>
>>>>>> If the device's power state has been changed to D3hot by ACPI, it is not in D0.
>>>>>>
>>>>>> It looks like the state tracking is not working here.
>>>>>>
>>>>>
>>>>>  The state setting to D0 is happening due to the current logic present in
>>>>>  pci_update_current_state(). If we can fix the logic in
>>>>>  pci_update_current_state() to detect this condition and return state D3hot,
>>>>>  then it should also fix the issue.
>>>>>
>>>>>  Thanks,
>>>>>  Abhishek
>>>>>
>>>>
>>>>  Hi Rafael/Mika,
>>>>
>>>>  Could you please help regarding the correct way to fix this issue.
>>>>  I can update the patch accordingly.
>>>
>>> I think you can try one of the patches posted recently:
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F3623886.MHq7AAxBmi%40kreacher%2F&amp;data=04%7C01%7Cabhsahu%40nvidia.com%7C87470c4f30f14871bcc708da17c5e913%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637848436478123578%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=USJs87Fmm0Vcjm1YWszZCBTpcNQED3InOuOdGgE3f88%3D&amp;reserved=0
>>>
>>> Thanks!
>>>
>>>
>>>
>>
>>  Thanks Rafael.
>>  I have applied both the changes and still the issue which I mentioned is happening.
>>
>>  Following are the prints:
>>
>>  0000:01:00.0: power state changed by ACPI to D3hot
>>  0000:00:01.0: power state changed by ACPI to D3cold
>>  0000:00:01.0: power state changed by ACPI to D0
>>
>>  So ACPI state change is still not happening for PCI endpoint devices.
>>
>>  Also, the I checked the code and the pci_power_up() will not be called
>>  for endpoint devices. For endpoints, pci_restore_standard_config() will
>>  be called first where the current state will come as D0.
> 
> OK, I see.
> 
> The problem is that if the PCI device goes to D0 because of the bridge power-up,
> it's ACPI companion's power state may not follow, which means that we really
> want to do a full power-up in there.
> 
> Please test the appended patch with the patch from
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F3623886.MHq7AAxBmi%40kreacher%2F&amp;data=04%7C01%7Cabhsahu%40nvidia.com%7C87470c4f30f14871bcc708da17c5e913%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637848436478123578%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=USJs87Fmm0Vcjm1YWszZCBTpcNQED3InOuOdGgE3f88%3D&amp;reserved=0
> 
> still applied.
> 
> ---
>  drivers/pci/pci-driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -1312,7 +1312,7 @@ static int pci_pm_runtime_resume(struct
>          * to a driver because although we left it in D0, it may have gone to
>          * D3cold when the bridge above it runtime suspended.
>          */
> -       pci_restore_standard_config(pci_dev);
> +       pci_pm_default_resume_early(pci_dev);
> 
>         if (!pci_dev->driver)
>                 return 0;
> 

 Thanks Rafael.
 With the above code change, the issue is getting fixed and the
 PCI endpoint power state is also changing to D0.

 0000:01:00.0: power state changed by ACPI to D3hot
 0000:00:01.0: power state changed by ACPI to D3cold
 0000:00:01.0: power state changed by ACPI to D0
 0000:01:00.0: power state changed by ACPI to D0

 Regards,
 Abhishek
