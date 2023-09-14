Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492BE7A0761
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjINObt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjINObs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 10:31:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258FC1A2;
        Thu, 14 Sep 2023 07:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1eLTFkgYY0ZZ7w6RFzXoCVwPZepltO5RNxUt5caOf0gKuG+sBR5TeVxsEuWbWIaSV2YB4ihN5s5qVmD9CoHkJFB/ASijC+Gj1OHsXr1WjRmfwTaekzvLQTsZ7yaqTJvwOIuV4u2BprJRTetWy76K355aO4Xx4TxiSGtCBmLKDvc93kmzbniYDqgepzoXGClmOShpaFgjsauERvro7F9jKGsWsZY+vYp7dlnp0B0uvoymsenFAbSQi3xZM9uAR3Z9i7rlPOp6+EPiIXUyB825Ep+1i2hOG3cHbwgTxR9XrZyIMYSINaM+CTXhdSy2Il1wahXoWPmndehLge3kT6v5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsRaWFP5t0JcgypsJGiIvyzpuebRQrRNmIXK1THUD/o=;
 b=AprR6xnkcjrZeIFAgaeyKP/9whQ762veYtatPFiLHPFJkqYRlLlFWGh9JY+uFvG7eCk6FdJlaUStcO6i4+4ZBptuLd6q1niYqZ+poeqyJvBPVKsePlESYTrMs2pIgnPq2Rt+NcZ+0OPBYP/ueHQ97L5jZ4FCthx0U27gfebTcAoD4ggs1KHPFuVYoFukayyH2CVO7qJg7489s8dVTJ7jui0ZRs2SXsnvJtB6UL/iJRqPh4NbfiSAMCXfy8jeGQDiFhbiYQ6DJ7sLuuDgtQVWDhE8Q0hU+F6g9LYTjpXbFfN9YW9WXxknAccLU8b6Jjlc03dhyJbaDZDiRRDOl9346g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsRaWFP5t0JcgypsJGiIvyzpuebRQrRNmIXK1THUD/o=;
 b=OFaQqktswiBUXyvFvKtmS4or8Em6mI8PafpgX+WL3aOFapoV1M8EJXObZCiS5jO5KmaSVDQqKIywdkj/2in4+eqHLN2gAt6u5jeT1UX0T0VvfFSSYxV7jpmIJttO2jyqLHPx+UvxKdejTRsx+QPMDyeHwrVdKhpk5MZzVOE871c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 14 Sep
 2023 14:31:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:31:41 +0000
Message-ID: <1db16da9-568d-4492-8b2c-cdabf7a18f3b@amd.com>
Date:   Thu, 14 Sep 2023 09:31:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
References: <20230913040832.114610-1-mario.limonciello@amd.com>
 <20230913040832.114610-3-mario.limonciello@amd.com>
 <20230913042522.GB1359@wunner.de>
 <fd981219-d864-4c46-a348-61f73a9df596@amd.com>
 <20230913143128.GA29059@wunner.de>
 <76dfea89-e386-45e9-851c-8e87f9470c4f@amd.com>
 <20230914141705.GA27051@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230914141705.GA27051@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f72d0c-ea8c-42b0-9509-08dbb52f4ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XCXhyiJhiiZmORbMynDxIeVgROvUdKy8pxA2R7GB+1UD02mI589u6G1fGm2i2wDiTBICJ1nrEVm1z97UiBlZyPp+6nVyXSh7Ak4kw/7Qsq2Nne8mKggkxUIqur9UrjyVILXnoVhpdem5hj/S3+cjpwK68emFGJq87/X2zAyVXlPR67ROKY4JYsZnIQ9jmwQgFyCmgvB4Rx8vNyecVnwJr4MPAXH9dnWGmyZ1KPY8ACggSuupnB6xQA9Yikj2i2QT/rm8jYpDTVJkpOJVKYj9xJO40HA744TyNbbixORQ9cez6rD4LR6mcNhnWGU2U14pE5wgF8/aBUTEL9r6v7gwKSnVZIeNWPjhhwlUj81ja9waiUCy5A04pgkeormUvZCyAIntE7Vk9688fcX23iT4pELdLCeapKdAnTnsqI789ItKzY+IJhZw9TY+fmBKW1EXNpe8gJ74YyXuQXqGvgvC1Qyzlg0zUgiDcQ6NFi4FxuzwRzukzcgCpDmWRn9SGKMhXRtjb+EedfvaVEQFl+uESsDAyORq0mVydZGFPKCqTfAqDvrBIoO5sOidAyj5CKUIsQxNdH2k5TXdRG9TyDEhN0sGUstoKzpP7utWl7Lr8htqfhCbycS5fg8lBPzzIfvIiiqOgZ7Cm0pkIV8QH1k3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(1800799009)(451199024)(186009)(44832011)(8676002)(4326008)(8936002)(6916009)(66476007)(66556008)(66946007)(2616005)(6506007)(6512007)(53546011)(6486002)(41300700001)(6666004)(316002)(26005)(5660300002)(7416002)(54906003)(83380400001)(31686004)(478600001)(2906002)(31696002)(86362001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNmUGJxMml0V2xNT1VZM21qOUFpdTA3eVFyb2FkWFc3TVhaQ214aXQzKzZY?=
 =?utf-8?B?V2pmc1BFcFNJSTlGKzhNSW5qeGJVU0RKTStESUJsM1M5VDF2VjZCazNqVUJZ?=
 =?utf-8?B?T0MrU2tuTlRwQm0yWkdCcVRMR09hN0pZekhUR3dYSmZMY3FZZkNBMnBHblZ6?=
 =?utf-8?B?bW0rYnVmcm9DQm9TcE96WDdiVlhEVitvcjhZZ0NON1FJSFh4RDlwSzV6aUcr?=
 =?utf-8?B?YUFkOXo0SHZtTWNXbGU3OUJIalVVWUV0NUd5OWxOTWtISjRjMTRtZHFsSmNr?=
 =?utf-8?B?NlVWTEFhMUpUYi83a2RHWTVLQjFIL3dlTFYzKzJrVFM5YWc3WEJCU01RYmMr?=
 =?utf-8?B?UUxUaE42aUs4SmVOMVpwa0xMMGJsd0J5Z2ZvNUhrWWRJZ0lTNTAxbmdLVFlQ?=
 =?utf-8?B?dTBrZllWZU9WZG5xY2RiaWNWL0FLQ3lpUXh5QXpkVnFhQXYyQjlRbDFyTThI?=
 =?utf-8?B?NEM2ditJYS85eFpPbzVDMGU4T216NGpVc2owRDRIQXNxdGhjNzRTQjNad1dr?=
 =?utf-8?B?TUhUa1JlMkN4U05rOGpwSUk2aFNER05aREU3M2RNcmUxMlYyWENGV21EQ2FV?=
 =?utf-8?B?Tlg4VFNJVVRMRnY0aFFmMTluNHFiM280N1VkR05ldktJbURUaWs3bGMzSzJn?=
 =?utf-8?B?MWZUNUVZYThCUWUvZk9rYy9hVHl4K3BFb1VSa29zT3pvQ2Exb29rckFNeTRm?=
 =?utf-8?B?bHlzRVYzVkFLQ0xkMmNHNDlYbWpNSWczZkN5NGFIdnFCU3k0allaRkZLSHYx?=
 =?utf-8?B?RWl5SWFpY0Z2RlJYVHdiT3p0dGVNRVkzT3pzTzdsWmJPaFRQNy81ck1tU2V4?=
 =?utf-8?B?WjRJVTRQTVZBcEFobVB3SGYvZnR1S0s5Z3Vtc0ZtZTcvNFZMSDdFRlZwVkMr?=
 =?utf-8?B?a2VOdkRtOTVBSHo5M0pwZE9TenlrOE0wOFFZWjZVYjJ3NTdGSzQ0cGdkcHpE?=
 =?utf-8?B?dmgxY1QxYjNaUFVkcFRmT1Q1czhQQW9KNUlkazVTcUNCVzRUaXhNVUZyOTlm?=
 =?utf-8?B?SFQvM0JPOEpCNkpmREU3OGFFMnpVeldJS2FuMWtZYzNONmVWQ3p5TXpaUnNP?=
 =?utf-8?B?ZEZBTXpoVkJLL0JlU0hlZUllOEpIMzYzVmtTc2tFRGlDVHFWRkxUeS9YZEs4?=
 =?utf-8?B?RG45NEo4VVNBRDdZSXRKNWMycjdrYTN3UHRHVTFGSVU4YmZCVjhWZDRpVE9E?=
 =?utf-8?B?UWtZNHowL0FGTlRLeEhTTjZhVWp6NmxWQzBQaFY0S01kSGFGekNFYzN1VDFp?=
 =?utf-8?B?OVh1NGtPemlkSTEzS2xBd1dtTW5sREVlZXdLRHhXSml1K1hBc0tRcDh4WjNy?=
 =?utf-8?B?OGpqbjRpcW50ZDdDN3dJOGRUSTIyRmNIT2lzbnVBMnJINkpCcEdXd2ZCY1BL?=
 =?utf-8?B?bjA2RTdNQ281TXFTRkpKTHlqZGxQd3k3RG1VUHBDSHJNMVZ0ZzdWR2tIcFU4?=
 =?utf-8?B?eVRCS0VjU0lRU2Vubm1uT3grQ1BvQzd3V2FlRFYwUEI5ZHNzQXlUZFg0dkZT?=
 =?utf-8?B?OCs2ZVZsUVJVTEx2K2F4TFZ3VTM3ZGFyazhMMFVtellpMDd0UDBUam44ak10?=
 =?utf-8?B?TllLcWpVZ2xYbGh3NUMwT0FUaVZJaURiS0owRDNyM2txMnNkOHhIcVJxRzMv?=
 =?utf-8?B?MkdKYnl2a1oxdGUvd0dmMTgvWE1VQ0N6REF2ditvN0RFYmRmcU5IYURTRUhD?=
 =?utf-8?B?S3dOaWZqWS92d2k4RkRWcnNBc0duTTBCTzJBVDZvajJqcSt4bGdndGlkMFEz?=
 =?utf-8?B?TDErdkl2VldORlpjZXcwdGgzTkVxMW01NUZNN0xNdnVhUUhtbDF5MEpKWWsv?=
 =?utf-8?B?UHJoUFhjSVNqTjREaXBWUlBhUGJyUzBVakFmckNGbkVoNzNUNzRQZ3I5d3Q0?=
 =?utf-8?B?TmxnQzlleTZlNEVWQ2lKa0M1M2RlR3F2VHNCRHNhMllzS05ha2xiYUJYbGVZ?=
 =?utf-8?B?VUQwaVFLT0xveTBibmlrSDJhU0paRkVjYzhSL3ZkaDVxV0lVYzhCcWpMODJW?=
 =?utf-8?B?ZTNPcmM4OGpybGF1R2lqbXRZK0t3OFI2ank0cjVBYWxzZnI1c0lyelB3Tm1P?=
 =?utf-8?B?V3prbzk3bTR5NXAvc2lNY3Vod2JWRVFaNXEvSU5qL1dzWWRVN1pBRFgyVnl3?=
 =?utf-8?Q?jmyRLgUdM3KXNFqgya3zIqg2s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f72d0c-ea8c-42b0-9509-08dbb52f4ff6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:31:41.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI81ULfipeZ5Od36XyX0KYtWNs6QuNBXpGTpc0sOhBExcdZU+Nq/qQvmn1vnqjqVhwvsGwRpS8Ct81TkqtDaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/14/2023 09:17, Lukas Wunner wrote:
> On Wed, Sep 13, 2023 at 11:36:49AM -0500, Mario Limonciello wrote:
>> On 9/13/2023 09:31, Lukas Wunner wrote:
>>> If this only affects system sleep, not runtime PM, what you can do is
>>> define a DECLARE_PCI_FIXUP_SUSPEND_LATE() which calls pci_d3cold_disable()
>>> and also define a DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY() which calls
>>> pci_d3cold_enable().
>>>
>>> And I think you can make those calls conditional on pm_suspend_no_platform()
>>> to constrain to s2idle.
>>>
>>> User space should still be able to influence runtime PM via the
>>> d3cold_allowed flag (unless I'm missing something).
>>
>> The part you're missing is that D3hot is affected by this issue too,
>> otherwise it would be a good proposal.
> 
> I recall that in an earlier version of the patch, you solved the issue
> by amending pci_bridge_d3_possible().
> 
> Changing the dev->no_d3cold flag indirectly influences the bridge_d3
> flag (through pci_dev_check_d3cold() and pci_bridge_d3_update()).
> 
> If dev->no_d3cold is set on a device below a port, that port is
> prevented from entring D3hot because it would result in the
> device effectively being in D3cold.
> 
> So you might want to take a closer look at this approach despite
> the flag suggesting that it only influences D3cold.
> 

Ah; I hadn't considered setting it on a device below the port. In this 
particular situation the only devices below the root port are USB 
controllers.

If those devices don't go into D3 the system can't enter hardware sleep.

