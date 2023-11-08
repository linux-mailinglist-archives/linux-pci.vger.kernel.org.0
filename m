Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5587E50D9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 08:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjKHHRZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 02:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjKHHRY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 02:17:24 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D3D1BE;
        Tue,  7 Nov 2023 23:17:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI4o80uyfB8kabUiOTE913eDj7hP1UvFOA1z9jgyPtYpQ4LXBmy293i4R7cTqyhBbNVUrH6ew+WLP7ube/ZSXCVcN+2hldyObIiCzPdYko9Y92yk1xyDUekYPlgP4cC6Yes1FsBTnDWYFmtXEm2eUNSOUAvnszIOvAqT9WD+mpeVbLhlNUez+Xys3xJ4RuFVOmlo0a10vd7rR8gOq4N8w9dkVbPMU5ka+SRQHJpoPAGkyxZYEihht9Um2QPtX0czg2vYZUD+FHE9cgCCFh++Glg0VrPXMEKdXwV2q8uMYXLvYM8jl1EaeOgn62vmMurdU6yPjoSudPkKZk2CAXfg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkBusBQ9rzgSYlAXDVDxwIyffYik2yyIYM39L7pP4pY=;
 b=QgVn9BqrbpoeOLzVHg/Sj4CjaRbEM7weKCh37+dSd72PpsmT0uiuDFEL4sc1wlmahkdXP6ubsIuhpLR09BnAKyDLJJFE9vPcx2oX5rzubefPu702faWmF3r2VYAvkB0UmfUZLjzMoJucMEhvGUDpZWmRa0C0acR4jecf6wW8+G2rBIjlq/RtVqaBG9W/v3AIp59TTODB60ASaS/CEIqeQzTw3g8lYM1SHqRVU1Tb1OYrQ94lCEMfks/k5N6g+stvLnS6rCEWEInFPNyNqfH5Ffi2420OsOkr2TyZVek6vAk2DuP7+zqIJdoqTIsV4zul2nj5fQ8EssqQo4PhsLTsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkBusBQ9rzgSYlAXDVDxwIyffYik2yyIYM39L7pP4pY=;
 b=Q5PVYLXm2IHpmEgFv9J2drZt8JDBOxsid4yRG1bN8Y44aeWgoJJK4xHeFaAN3jSzuk87hHP8DrnEVHI8GdFitRFJNnh+eh9gMmrnX6050AEbw3fI+DpB6pK4cEzFNs0Nq8SnzJ72DoHY3Whl7vShfqsmDSP4+cgaonk5b39XiFnbRrx71XUEzjZx12LKIjt3DxLXKoikqtYpS8Qf/lcOxHdgOLG654iwURU5oj0j3UoKAsOAmxpAc0CYTSCbDH5i/Lonh6kHsy2wobvTwEjy+Vaf/n/4hNWZ4hKW5PWGbMmdy91bqi/j8G2sLGXdNUG26QAGQyEvPQX/0ZOFU5dgaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 07:17:17 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13%5]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 07:17:16 +0000
Message-ID: <1fb9d746-0695-4d19-af98-f442f31cd464@nvidia.com>
Date:   Wed, 8 Nov 2023 12:47:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Question: Clearing error bits in the root port post enumeration
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231107152929.GA289532@bhelgaas>
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20231107152929.GA289532@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::32) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b571eb7-c545-47c6-f3fd-08dbe02abcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RiTqBlc61dC/hjyzHjgAcxpMCdE4qgJmOUlXMhz/FbfA3tuKJTS5o/5bhK48m85wTVwK2hjGj1zZmev5oCMran2i+p2IxCe2QXvyJAfvw/HGS9vAiPMMt2JrriEl99vNmyHEUqpMF3L8HBH2ROr6uryFl6yCHzVqC2HDvQjIH2eJydlfX3NP7mm4ZYQPqkQEpoy3ByTVpleepda2psfJcXQ0HKRlzyzZDk5a+ZaV+L9v7oq3Igb1uth/0fbSvbz2m15r5LABcWQ38jig4f00RF7+gVgu92vdA7UKszumCOftGtK9FhgakwBSa+bUMvcQq4pfmHJExMcEifrtyduDQSvysSutiKQrb3jUGihcy3pbyUhNCMjnNB9cjRM1Pgd0C9kWa7sucAo2dSgntZmSpxkVI7UerZU/LXi7K/5fSiRujGLR0kE/HJMkISulOXLmjEFzjBYAezgoMzuE740LJo8UGyIZGBmxpLONKIfIEmAPaNEwP30cwcAg3edFo2E/BNsRU6/bj2eQjUCTMOmPeN16BodYIHwMJDooKdurr5xKPMn2hUtrOzOyFNuFVEHzzmAOsoxtW+3pWRjCyKtQz6dWJJoQpHKwtMPuK7iMd4xF7uc0YgDtur7wzy85sp0tCP1RWlrdozF+rAUti/xEg82MyXAXMAX2H/Z2Jq4Tibc6Lf278N5nUJQH8Ign/+2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799009)(64100799003)(451199024)(186009)(31686004)(6666004)(6512007)(6506007)(6486002)(53546011)(31696002)(86362001)(36756003)(38100700002)(5660300002)(316002)(4326008)(2906002)(478600001)(26005)(2616005)(83380400001)(66476007)(54906003)(8936002)(8676002)(66556008)(41300700001)(6916009)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9uenprVStsQUZHQVJ1SGlucTVRTnMyNWxsMmc3bStPbXRGVGkyaW1qNWxL?=
 =?utf-8?B?NUgzcjNEMkxJcURYMUowbEhXd2J3aDRiMStrNmxuRlQrWTZKU21YRWVGZSs0?=
 =?utf-8?B?QnNMZnJoS0x0dkZLSHgvT1N5eXZzSXNHYXU1N2kxV2Z5TzBkQlp5eVZxWnVO?=
 =?utf-8?B?QVFUYytkY0FOdGwyVFpXZWFoREJvY2pFQmJXQ3VLcmxqKzYzemt3bE1aTEZy?=
 =?utf-8?B?TXpGcnBYR0pUeWJyMVpZNjVleDFwMHZQdENsOTdWa29TS1BBVFJHWTFHWWVx?=
 =?utf-8?B?amZ6RzRySHNkaHJ4eXovd3hZTm9yN0QrZGI2K2RPR05MbnVqMjhKQ2RjMk1Q?=
 =?utf-8?B?cGhmQUl2YXU1UVh5RHpVNy96aTltM09PSXlrMWRMU1MxRzQvZzNYRk1nU1hB?=
 =?utf-8?B?RXJEMmphaTZTclZNSnlCQU1pcGJGVHNTeFBQN0l0MW5ja0QwVDFUQXBNT095?=
 =?utf-8?B?SU5MRGJrVU0zNkd1MDBrRkZHNE80Uk90YXVUajlnVWw2RUZGdEFMT1BKL2dh?=
 =?utf-8?B?ZCtqb3RUYW9RUzMxK25NM0JkSXVpcFBYSEY5SUhrMkRzb29Rb0NaOERNTFBE?=
 =?utf-8?B?aTh3OU9CbnM3cUNZViszYkdHNWxEcjJ0NGZ5NDBJdGxySDFlSEplNjFxNHhj?=
 =?utf-8?B?SStvSStTUGNaMGg3MlBTYjVOY0c1MG1nYzE3L3oyaU8yWlhMWWhQNEJaRjhh?=
 =?utf-8?B?ZWhQZ1NJc0ZHOHRhMjFTNzF6VHRWVkdueVFVc1FQczBKOGl0bjBrOW5jRGxs?=
 =?utf-8?B?Ui8wRGZhNksvdWpxa3ZxYWt4VUhnSHd3RFU3N3VKMTd5YWJxdCtKSUFMeWZS?=
 =?utf-8?B?dUl0ZHFYMllCbmRQT2VRNXl4dEhodEZaUWVFeFBOZ21NakovV1NkMno4R0dk?=
 =?utf-8?B?bGl4bWZqckRTNDdleW1laW9Ba2VFcjdDOTJWQXlTbGN5VlI1dXNSMzk1eTd6?=
 =?utf-8?B?bDNhbVFWNnVrQ0MrZFh4Wmp4ZzI5QWdRaWNiNi9kdkhYMm0rNExQZGJrenUy?=
 =?utf-8?B?aVczbDA2Z01KSTB2bmErRFpOTU1IVExQb1RXSC81QXBsdmRvT3NSdDlYeGE5?=
 =?utf-8?B?WWdDV3hiYWt5UjBrQTdUTHpEK3pzZ2trc2l6OUhVTW41RzFUdm54Z3BQbWY5?=
 =?utf-8?B?VkpjcVlwQTB6dGZQNW9TT1kwVm5mUll3VWkvNG1taDZBS1dzbmdQK1NQNlBy?=
 =?utf-8?B?K3l0UGRWWGc3QllMRlBiSG5JN3BIVWhvdWZJaTcwTDRJOW14UzRCbG1LdTB5?=
 =?utf-8?B?cWhMb25BNDZoTEJtUE80K21rVnoxcVZjWGt4cyt5RUh4UDZyTURPNVlreEd2?=
 =?utf-8?B?SGY1OGY4dTZDRFN3OG5MTGpoZGRpcTBXa1NxUXMrS2FJMS8wMVVvMk4yb1NB?=
 =?utf-8?B?UGovcHFPN0RRY2dkUUJvZ0FkYXRIa241K0F6b1UvcjBrRlFseEd2QkJRaVpL?=
 =?utf-8?B?WGpBWXh1Z1JDTWVnTUVZNmRZTWZpc3JUeTNyYURBYkFReGRSN2lNdThoWlBD?=
 =?utf-8?B?MnowYjRxRC9oVEdSNCtjdm9NbTBOS2VUUHNueE14bFAxMUxuN1lsRUxzY1lh?=
 =?utf-8?B?RVZiOVNZcGcvWDk4aUJtU2ovMWVrc3FoZ2wvYWszMlozVTNxbEltZktQTkJM?=
 =?utf-8?B?YzNWUEJUVHBkaGVRTDFodHh0UGxueENvT05zeVlteTZNdndiQWo2Z25NbEZa?=
 =?utf-8?B?L2J5RzVkK3AwMGlJNlVJNTM1dzVwMjdnUkgzUU8wanVCTERWemxGdnEzdlIy?=
 =?utf-8?B?bXdaUnNWc3AzYkhiTlYwN2xQa1Y4V1dCcyt2Y3FkZzYrMnBsYUQ4bmltSWIr?=
 =?utf-8?B?dGhaRXpuRnJKbWlYUWt2VTlOMEpEUkJXYjVhQ2hDZFpDM1lnQ3ExR1RGRjM2?=
 =?utf-8?B?b2c4bXczVnkrekhrZXBLTTBibitQVzcwYUN5YndXVTJ2eTRpL3lqZGI4ck94?=
 =?utf-8?B?MjgreHhYa2l5ZWtaSndHMHBtbFBFUmFYSC82V2Rvb2o2TlB3SkppZDZzT0F0?=
 =?utf-8?B?S2hady83SHMycmFueDJZc1JyU3JRcThZR3JpcVc2K0p4Z29ZeWd5dEJOaG14?=
 =?utf-8?B?UFl1NERsS2VYMmo2bjFNM3phTVlxSVZ0Y0NZb3N4QU9Ub0FxNnVaUVJtZnB6?=
 =?utf-8?Q?gsRYQuYuwJGbWz3ZnWtU7PApq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b571eb7-c545-47c6-f3fd-08dbe02abcaf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:17:16.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQBpRw8TZ23TwfjV/Fz4P8pwAGOHVJeGFbdqoLUTLLHCkonK5ccrXvmWKf5RQlOI3hvHa+DNPbBW8z/Ae89NwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/7/2023 8:59 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Nov 07, 2023 at 08:44:53AM +0530, Vidya Sagar wrote:
>> On 11/3/2023 11:50 PM, Bjorn Helgaas wrote:
>>> On Tue, Oct 31, 2023 at 12:26:31PM +0000, Vidya Sagar wrote:
>>>> Hi folks,
>>>>
>>>> I would like to know your comments on the following scenario where
>>>> we are observing the root port logging errors because of the
>>>> enumeration flow being followed.
>>>>
>>>> DUT information:
>>>> - Has a root port and an endpoint connected to it
>>>> - Uses ECAM mechanism to access the configuration space
>>>> - Booted through ACPI flow
>>>> - Has a Firmware-First approach for handling the errors
>>>> - System is configured to treat Unsupported Requests as
>>>>     AdvisoryNon-Fatal errors
>>>>
>>>> As we all know, when a configuration read request comes in for a
>>>> device number that is not implemented, a UR would be returned as per
>>>> the PCIe spec.
>>>>
>>>> As part of the enumeration flow on DUT, when the kernel reads offset
>>>> 0x0 of B:D:F=0:0:0, the root port responds with its valid Vendor-ID
>>>> and Device-ID values.  But, when B:D:F=0:1:0 is probed, since there
>>>> is no device present there, the root port responds with an
>>>> Unsupported Request and simultaneously logs the same in the Device
>>>> Status register (i.e. bit-3).  Because of it, there is a UR logged
>>>> in the Device Status register of the RP by the time enumeration is
>>>> complete.
>>>>
>>>> In the case of AER capability natively owned by the kernel, the AER
>>>> driver's init call would clear all such pending bits.
>>>>
>>>> Since we are going with the Firmware-First approach, and the system
>>>> is configured to treat Unsupported Requests as AdvisoryNon-Fatal
>>>> errors, only a correctable error interrupt can be raised to the
>>>> Firmware which takes care of clearing the corresponding status
>>>> registers.  The firmware can't know about the UnsupReq bit being set
>>>> as the interrupt it received is for a correctable error hence it
>>>> clears only bits related to correctable error.
>>>>
>>>> All these events leave a freshly booted system with the following
>>>> bits set.
>>>>
>>>> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-          (MAbort)
>>>> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-                                                              (UnsupReq)
>>>> UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-   (UnsupReq)
>>>>
>>>> Since the reason for UR is well understood at this point, I would
>>>> like to weigh in on the idea of clearing the aforementioned bits in
>>>> the root port once the enumeration is done particularly to cater to
>>>> the configurations where Firmware-First approach is in place.
>>>> Please let me know your comments on this approach.
>>>
>>> I think Secondary status (PCI_SEC_STATUS) is always owned by the OS
>>> and is not affected by _OSC negotiation, right?  Linux does basically
>>> nothing with that today, but I think it *could* clear the "Received
>>> Master Abort" bit.
>>
>> Yes. PCI_SEC_STATUS is always owned by the OS and _OSC negotiation doesn't
>> really affect that.
>>
>>> I'm not very familiar with Advisory Non-Fatal errors.  I'm curious
>>> about the UESta situation: why can't firmware know about UnsupReq
>>> being set?  I assume PCI_ERR_COR_ADV_NFAT is the Correctable Error
>>> Status bit the firmware *does* see and clear.
>>
>> Yes, PCI_ERR_COR_ADV_NFAT is indeed cleared by the firmware.
>>>
>>> But isn't the whole point of Advisory Non-Fatal errors that an error
>>> that is logged as an Uncorrectable Error and that normally would be
>>> signaled with ERR_NONFATAL is signaled with ERR_COR instead?  So
>>> doesn't PCI_ERR_COR_ADV_NFAT being set imply that some
>>> PCI_ERR_UNCOR_STATUS must be set as well?  If so, I would think
>>> firmware *could* figure that out and clear the PCI_ERR_UNCOR_STATUS
>>> bit.
>>
>> So, are you suggesting that let the firmware only clear the
>> PCI_ERR_UNCOR_STATUS also?
> 
> In this firmware-first scenario, I'm assuming the platform retained
> ownership of the AER capability, so I would think firmware certainly
> should be allowed to clear PCI_ERR_UNCOR_STATUS.
> 
>> if so, then, I can even make the firmware clear the PCI_SEC_STATUS
>> also thereby leaving the firmware responsible for clearing all the
>> error bits. Does that sound ok?
> 
> It doesn't sound quite right to me for firmware to clear
> PCI_SEC_STATUS because it doesn't own that register.  I suspect we
> would probably see the "Received Master Abort" bit set after
> enumeration even on Conventional PCI systems, so I doubt this is
> anything specific to PCIe or AER, and maybe Linux should clear it
> after enumerating devices below the bridge.
Agree.
I'll push a patch to clear PCI_SEC_STATUS bit.

Thanks for your inputs Bjorn.

> 
> Bjorn
