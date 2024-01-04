Return-Path: <linux-pci+bounces-1676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C958243D2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F1A1C21AD0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D715222EE7;
	Thu,  4 Jan 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pc/Es7UN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478722EE1;
	Thu,  4 Jan 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoEOhJ+2UamamLzeEjCy4Pw2UU6Xpn1zkXl9VR2J3Dl+fqD7NaVig464ziuZnXaa9jK845J0RfslT4gaBYGIouB9NF1fSjhMZNX2XP97uSK5uPwUXKDD80n1M1n/lBzEFqOQCT+hj1PLpN0GwBd4m/JcmBvpghElZsor+JYq2v8ac/nnj/bhCDCCHfN9sLp7nJNfhvHZ/88e56Chc7X7JBuGURk+Y0BZuey77ufjTaSgUyTn3PV8biyaTTGGBPEf9ZNOoD2X7DDehiVU4GowsH1kEFFbE8FZUIGln97wVwxInTDZy9Q/z+N210Q56TBhknDjKh2HbbrDdbwqESiANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqmsUO6zS6JDWRIc/HKO9zMAM8cJSGzvqcULPxVoUkY=;
 b=gquWRbPME3zrDN7kAfQDFsoiaCb/l/yfOa5QS3uC2T6Vq8BBVuVQAQW5WJUl8LdA9kUojs9sPTpUqv9876AIW7aot7rWCE0cG0vWyJKLRmADgWXbB196L1Xq57GVkgitGMZuVwZ5f8wwWZwWBCpb7G14oli3/r4HqoC4dsg3p90N7diAszdkT1NROpJdR2d/ZLqQ9D3MXo0KapfhrMj14IaFm1imJupxAUUgeo/tpFfoOBszpGpHzPfsWY6/lDh4JOphabLKFlBLhHBIZrdhkaDczllpUYfRI4PMwxLBdF5TvXFwsrD0zkErT4vy/HsTz3Isoo5GtZoho93XcZfALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqmsUO6zS6JDWRIc/HKO9zMAM8cJSGzvqcULPxVoUkY=;
 b=pc/Es7UNjVouVhIqxTZdOjIvWzboKvOL/yiM3lFtUzibk+2wlCrIyT7XWHnCnXJwNan3oNy5N/YZKuAsY0VbQCq2pkUqPBo29jup3XaJ/hUCk8JC60gDHXpS4j9Ec5TKj0IIlDjzRj90fWCaGX+Pzxp73LpgxbP09EIVuowNUlw8laG8V0mdnBF1xAE2tTLFaM7ANAPMBfeWblIyrhEfR5MZHWg9t51vych7gmYYkP+nNb1b/4q071w+SuSveUF4Hqm/OdohOMQukT6d/+4tVMCoICEAD6nn9ct6nX2AHlLoBSIq+mtd4WEt8EgM2Ml4+BumttxRyMNqWtE24DN/MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 14:31:18 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::fa74:a090:27f6:ce58]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::fa74:a090:27f6:ce58%5]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 14:31:17 +0000
Message-ID: <f7324ca4-2c57-459c-a9e8-aac09ba65e87@nvidia.com>
Date: Thu, 4 Jan 2024 20:01:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, treding@nvidia.com,
 jonathanh@nvidia.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vsethi@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
 <20230730194026.GA19962@wunner.de>
 <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
 <20230731195930.GA13000@wunner.de>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230731195930.GA13000@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::17) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e43998-9758-4982-c54e-08dc0d31cfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dKWV7DwC+E0PqcvdF8Czn2htAa0eFuhfzxgqlRMBFzJJqT2bRaRI22Xfq8O70bkUZpYT5C7LUJNm+IPZNB7QlpmqpTfWmgFWmVqmIe8asc5Vu2+YT26DZG57NK82x/oiOKAp0lFOdYXYdULbYHKhpjd/n4TyVwTEvQpeml4lkG/75fwKd1487hIWEW+gIotiB7WH+mkKO2f/Qf0DBenN5wh4xwE3aodLwnfzC2izRVlmxBox3vOK7HR8li5OU3ubksPnnKEx/d0qcOiaKkaqOMWSJ6CBoawyRjhn9HodXXGy8uDyDp7BbTzVKIcmha9TmdbvVRo59c8q5trZkOK/x6dB3oWhWF2rCGdu2OlV+dtZISmEiXKbxrTTcwJNGWCdhmzVZT4kFwP5gM11F5pGOTL7KvPwIinvlgO+YMWjeP60VpQhuuyBszrzqukRpYnYnQmo4UdX96G6bKYHyEEeh4WkrB8S3gYq3vZ6/fIP36nZ2fo89lM1ByZ79JlO9tPdWgKO2CyZxD9fGsiI9wtjfNS0pXFjpLWXQtMq6hGXu3QnZEHOZDKRA7iUco+9dxxSUeftmfa0Zx20Xmmv84X/pgP69vNRoTip0RwjLiFPaAAILV53ISZz5G6anxpGZyVCH0nEz3PjtW8IrsJw8MCweycL4TBycWc23WzNXWJpTkOr2cBAq7zL4i6NaSYLDDu7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8936002)(8676002)(6486002)(83380400001)(6916009)(66476007)(66556008)(6666004)(41300700001)(2616005)(53546011)(6512007)(6506007)(4326008)(66946007)(31686004)(316002)(26005)(5660300002)(478600001)(38100700002)(2906002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bldEdmlLUTV6aG5NRzZGNE16Q0d0V2RIdWV4ZEMyeE1WOTA4RWZuN3habnJT?=
 =?utf-8?B?SUpxOEhuQllxVEFtY2dEdDIySWp0RTBLRHoxV0FISFovLzYrWXdCNnFUL2Z6?=
 =?utf-8?B?dHdxdU4rVklEUTAyNHhSb0xLbTFBZHNRTG04bi9OR2EwdkRsV2hEN2JkNVZO?=
 =?utf-8?B?M3NCYU4xYnRkTlBzUS95dzJEZ0dHdFVJWEw3Rm5wbW1PR1gzNDd1U3YyVEpX?=
 =?utf-8?B?S0Y0K3J4UHNhVVI5SWJ3UndaS2NGa1FON0dLWW1YOC9Tc3pOMjBSMFZBMmVq?=
 =?utf-8?B?NWs0eG1LaFF6RWt5aW1sYVB2THRheWFoOFk2L2VCU20rcDRQLytYN0lQUW1i?=
 =?utf-8?B?NXRiWExKOGFtQk8xZSs5M0IxMldabE5CVi9qUEhsd1JoazRGWXAxNXErL3VV?=
 =?utf-8?B?aE90VG1WQ1o4YkFJTHZoY29SdG05OWNiUW1rUEVtbDhBL0FMeXZ1RGRtdUda?=
 =?utf-8?B?NGdxdnNlN3VRa2RYaTRIZnFRbS9GaENNUlk4N2VoaVgxaW9BVXZDMytPQnZU?=
 =?utf-8?B?aXlhbDlsdmxpc2duaGdLQWU3K1ppUVQ2Wkl3WWwxeHd2WExpeU4vWmIzWXd1?=
 =?utf-8?B?OTRHZS9wbGNONXk0MTEzZ1JNTS8yZjIxQnZqek5wUkFsbEw2RFFYU0xhYTY2?=
 =?utf-8?B?bExRVENZTTRHV1VFMEYzZ21Ld0dHdFdWRldFa3hQbW01T1g1eXBYRzdzdzZC?=
 =?utf-8?B?WnB5aUxZb2ZGQk85eDhMaWF5SEkwd0dJZ3EyOHpKT2RWMW0rdkM1QUV5N2lt?=
 =?utf-8?B?TTNZVUZoa3JlTm00eTRlSzZUN2Zyd2lGblpLZk1VU0JlS0VFd1hJcGJXLzI2?=
 =?utf-8?B?UUtDUkowWWJ0WnhYdFUxZEptRjcyRmExcUxlYkNaM2ROdWMvaGZzKzFOemhI?=
 =?utf-8?B?eWxkcVJKY201UlJRM3JVNlk1Rm5MUXVqeGVhUExDR25UbnV1U0xKak8xU0Zo?=
 =?utf-8?B?N29YU1BTcTVDWHVTT1lXdlFSK3QzUGFucTFZTEZmTGhSUjc3bVgvVlVUWUpz?=
 =?utf-8?B?TjEyaWZVb1F4NUxkQWFvUUhmTTNMNEREUnJOWW9xMlRGd09aK1VibHo3SUkw?=
 =?utf-8?B?MnU4QlliVmk0VTB5am8zT1ZwcHUwcjdyRVQrMXIzaklxcWlwTDMrbDdzV3Fq?=
 =?utf-8?B?WXAreUpzbkd0b0NBR0RVdUtJc2tYSE82REdWNU0wcENTN1lxcVpPakpDSUcz?=
 =?utf-8?B?TDNzWFBmemdQRXNuTkZaMVBQbm1yanFmOW5kYVk0SVVyVXZJN1JTMHA5YXQ4?=
 =?utf-8?B?bkl0aHNXU08yOFRTMnhJOXNqRTFOQ2JodS9LT1RGTXRQOWQ0U2lIYmY1aWxk?=
 =?utf-8?B?N0dqbmJOMmpBcFk0T0JLaUxITUlTVTFXVC9DaXZsVTJkdVZ0MUE3eHc4WS9Q?=
 =?utf-8?B?R0lUL0luWFUwK0t1bHJUMVlRV3FrVm1qUWoyVUFDQmUwVnBKL05Zc1ZhZXVk?=
 =?utf-8?B?L3E0a0Y4NzVqTUJWTmJZSFRXMk1Ncld0MDRnWmZoVjVhQjkyR2ZrNlJLb3I4?=
 =?utf-8?B?UlFYRUl2RmhmNGRta216MkJZZWNTUXJqYnFrbDZhVEFQQ2JNazZBVllZUEdl?=
 =?utf-8?B?UjZlMjB3R2RISFI5MHRtYU9MZFlqYVlnNWcydVF1THBWYzVxR0VkVmxIZVdN?=
 =?utf-8?B?QjYxNi8rLzhnQy9pb3dDQWhGMkxEM3pZb0drU0d5bngrUmVOR0hCaVQ5d0Q3?=
 =?utf-8?B?WDlyZU9Lbk1wWFBmeGpUc0FiSEN0clFnUFBjUG90T2Zzem5VNVFzcktGWmxU?=
 =?utf-8?B?YTh4ME9neWw2TXlRZVVhRDEwL2RlSXZQZzJ6R0FEVHJmUWdhNHNseDVPZ0pn?=
 =?utf-8?B?dk9uaG1heU1YZzBkY3pVNEN4dWtQaGVzdG1LNzlBa21TTHgrVzF0WDhMbnRP?=
 =?utf-8?B?N3BuZHZHZ1JyUEJXNHBUOHdYVkNiSHJnUE5pNUpPNERKSkRLZlFwV1lOVWtE?=
 =?utf-8?B?YWtJWVp3SDIybUxEUksrd0RtRmlqeGQxblhJbXB3QURaaXZheHhJTUM0WEFu?=
 =?utf-8?B?UFFhdnNvWWtPM2RzRkowRTlIUXBiK2ExVmtTK0RBalQxTGJINW5jZTlDWlB2?=
 =?utf-8?B?SGNyQVFIM2tBN2NuZEk0a2liVkVMd3FKRkJMZzliQVRJem1KQUVOek12T2dh?=
 =?utf-8?Q?4cF60MoN0DqF+A4NZsGQeK9BL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e43998-9758-4982-c54e-08dc0d31cfc6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:31:17.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3SKz0K6TAFsamyto2bHVzza/sHD0z7pgLneMk8qFOUHETptmVg8UIC+QRKcoVXFwXOTn8CzWxlV2x/hKtsSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896



On 8/1/2023 1:29 AM, Lukas Wunner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Jul 31, 2023 at 01:32:27AM +0530, Vidya Sagar wrote:
>> On 7/31/2023 1:10 AM, Lukas Wunner wrote:
>>> On Mon, Jul 31, 2023 at 12:45:19AM +0530, Vidya Sagar wrote:
>>>> PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
>>>> send upstream messages before they have been assigned a bus number and
>>>> such messages have a Requester ID with Bus number set to 00h.
>>>> If the Downstream port has ACS Source Validation enabled, these messages
>>>> will be detected as ACS violation error.
>>>>
>>>> Hence, disable ACS Source Validation in the bridge device during
>>>> hot-remove operation and re-enable it after enumeration of the
>>>> downstream hierarchy but before binding the respective device drivers.
>>>
>>> What are these messages that are sent before assignment of a bus number?
>>
>> One example is the DRS (Device Readiness Status) message.
> 
> Please mention that in the commit message.
> 
> 
>>> What's the user-visible issue that occurs when they're blocked?
>>
>> I'm not sure about the issue one can observe when they are blocked, but, we
>> have seen one issue when they are not blocked. When an endpoint sends a DRS
>> message and an ACS violation is raised for it, the system can trigger DPC
>> (Downstream Port Containment) if it is configured to do so for ACS
>> violations. Once the DPC is released after handling it, system would go for
>> link-up again, which results in root port receiving DRS once again from the
>> endpoint and the cycle continues.
> 
> As an alternative to disabling ACS, have you explored masking ACS
> Violations (PCI_ERR_UNC_ACSV) upon de-enumeration of a device and
> unmasking them after assignment of a bus number?
Hi Lukas,
I explored this option and it seemed to work as expected. But, the issue
is that this works only if the AER registers are owned by the OS. If the
AER registers are owned by the firmware (i.e. Firmware-First approach of
handling the errors), OS is not supposed to access the AER registers and
there is no indication from the OS to the firmware as to when the
enumeration is completed and time is apt to unmask the ACSViolation
errors in the AER's Uncorrectable Error Mask register.
Any thoughts on accommodating the Firmware-First approach also?

> 
> That would alleviate concerns that disabling ACS Source Validation
> weakens security (because it doesn't have to be disabled in the
> first place).
> 
> You'd need to clear the ACS Violation Status bit in the Uncorrectable
> Error Status Register though after assignment of a bus number,
> in addition to unmasking it, because that bit is still set despite
> the error being masked.
> 
> The kernel affords a generous 60 sec timeout for devices to become
> ready (PCIE_RESET_READY_POLL_MS) and is not dependent on DRS messages
> coming through, so blocking them with ACS shouldn't cause issues.
> 
> 
>>> Doesn't disabling Source Validation introduce a security hole because the
>>> device may spoof messages before Source Validation is re-enabled?
>>
>> Agree, but this concern is already/has always been  there during boot
>> scenario where the link-up happens first and the ACS is enabled at a later
>> point and endpoint can spoof messages in between if it wishes so.
> 
> The problem is that devices may be removed only logically (via sysfs
> "power" attribute or Attention Button) and still remain in the system
> physically.  They may spoof messages until they're physically removed
> or the hotplug slot is brought up again.
> 
> 
>>> PCIe r6.1 sec 6.12.1.1 does indeed point out that the downstream device
>>> is *permitted* to send these messages but the Implementation Note
>>> does *not* prescribe that Source Validation shall be disabled to let them
>>> through.  It merely points out that the messages may be filtered if
>>> Source Validation is enabled.
>>
>> Could you please elaborate on the filtering part. Do you expect this to be
>> implemented in the hardware or software?
> 
> By "filtered" I meant that TLPs are blocked by ACS.  Sorry for the
> confusing word choice.
> 
> Thanks,
> 
> Lukas

