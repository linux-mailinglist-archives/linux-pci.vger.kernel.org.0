Return-Path: <linux-pci+bounces-2450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4858377D3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 00:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CDEB24BE5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED94EB50;
	Mon, 22 Jan 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mFO9OUHV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CB4EB2C;
	Mon, 22 Jan 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967432; cv=fail; b=Sw0BTENaUCrWFoYRO58UATYS0uRDoqxgr6nhoHQ865r2YgqFSOc01+b4hvfdf0H+Wj06+oEvFSyPHc6oxpYjWW85PrxFtF5EINhWMinIf+rl+4r9GdfHmVtZDoYnJjjDYIUqTfNNYhkTQsE96QJErqNcy0ZFCItyAMWX/0I2l1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967432; c=relaxed/simple;
	bh=1CEqx+qjy941rcYpsDEex4ouxM5nRKJJNSigAEx+g5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fim+LPHyka5wl8+rgOnH9vsDLWxGP3NIvlzSCbffE5N003YicU5NaIvgaR+fORuD2953jwamkCSFjsYIN4H4o6OMblNjtwyglHLyFPEuUv7y91jjYBqhRMOMXBukfS/uprSaU2N8A7lTbo4XD55Tu+nQh/2wElZ/GOQ3tQDtTeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mFO9OUHV; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb2faFHKO+9iUaa3oi5QnF0XHXgOV/oTo/yeKYm8OVDV41TwZZcP0s+E7V2MnWcCslGMbhTHGPuMWkkKrgPQ3MhCcCFWcRhMRD5p1D4uKkItdJg7nZbGkhNmlFGkaB7IWOKxPZDbkLaeO4n12vtWGZ5Dvs4+wNnyzO47UZ3evBco8WDT6vLq8uU0LjM9i6I0xKC2MZ2EfqgWQDG6OACCXs7Ot3beV/Yb+p/cHnwQEEbUBaokRrOeT9f35ruYeWz19WLMVKibei9Uj4FW8kgNQPWHm7ghEFDCF33djdVzwzbe40zheY0vNSnTzvg9fs49UyuDUbYhD1HCvY0RtvkkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3//K9RNktRW1Nag+t8g7q3XBjfJR6ZxDpRXrJrzZ6mA=;
 b=Wd5dX7QsQf6prYBrNcsCmWBeWNKDfvSn1+YRuAd4OdDnAF9LDMuIW7dU31vcpixCmiH1My6LcZKnngmn9ueRr88/LVLWBPTH2J/yIeggXTM/hhZPzomJZeOgMDnwqzaSmphT0UYJL2z6yuBwyCb2VjadAmTZzJWvZKTRN2Zup4NZdNTOkRYyx0GbfGYFYYJDLlEwNsWIsl6jM8i2Dj6i/rrtVZ2nyErwSR4gcqpmbpBJ/Qo8OjaIQjn+Z+5qCBJ12nog9FzgOSulAH3aWAUxC2qz5f7OC4lhixOw6Rp4B7rSPFgmkYG/YQmPPCIkBB9aHsrC/7copBoE0/DGuruhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3//K9RNktRW1Nag+t8g7q3XBjfJR6ZxDpRXrJrzZ6mA=;
 b=mFO9OUHVvDjBKsItPuNUn7eGhYvaAgUMT4QN8s4i7zZ7mkjvxgtDysLD/UtRsVXF3GERScgcWb2DVbbW922UWw9uBSa9J703jcikEhKji3SjtLL3+jay8sYhO0D5lieRHr8aTJwfGV86QucasKkfggZ9238CHjUHRNoDshjqFek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 23:50:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 23:50:26 +0000
Message-ID: <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>
Date: Mon, 22 Jan 2024 17:50:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rajat Jain <rajatja@google.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com> <ZalOCPrVA52wyFfv@google.com>
 <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com>
 <20240119102258.GE2543524@black.fi.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240119102258.GE2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: a15fbcff-a0e9-4804-753d-08dc1ba4e827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I6Bza1Yo+u6LVxB3AEQENQewe2USRNl3vemE3IiGkdahalkOLt8lncHYgPZRtZIkQQYCRIQaECRoeVCZt9zT7rQmNFtE9Ay1xbyb4aLa5tc6EKqwWGDQ8N4ERBbM6/EKnXbMr4bv/UXLS1a3H5cWoZt3a45f4g/c8AykWOSmy9ruy2ZPB+SEeJYwhqUbFjbpEOr4S98Os/G8d0LFHcp3st8OAkl65y2qSwUsAHK7P/I5SBo4MuhNPTHsPbhCXheJOhGckZrv0iAMpBGf6dh2gtaFBwJfy4/feXk+guX3zS641kqav/KPgWVrDLX6BUSPKUq03Sm2zsi2i7pr5dn89Huc+OQ8AVO11mUoa4992F1JD4e7WYzyUROdtciXzswylvTKM1Ei1xXhMDYZ+IAcS3lNGO+z4HFt1t3rFfN8ugopoIPr6cyxIw+z6GMF/gbLw6R6ZU0K87K15rhk6FQe3LlVnWCH1Y63XFAg1e/pHbCkiW7j0R9S0SUL2jjbLoNnYI5nrhZnrRYEtHlngoh7+FEzqgDTNZZRna084uareBxF53WLwJsRq3pSqikxQ+QDWTIx7NT3WFkfBNHfniKE2s4fNCmagyFi9NWXpYKwIUEA1+POWtCerezC7w6Tq2hJBghHptX8ICpViifSa9VO8zVxI2UtTKcJjK9JtMwdHJdegy6Wx2k8jaSvOP0EIV0D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(31686004)(41300700001)(6486002)(8936002)(5660300002)(8676002)(2906002)(316002)(54906003)(110136005)(66946007)(66556008)(66476007)(478600001)(66899024)(53546011)(26005)(6506007)(6512007)(2616005)(44832011)(4326008)(86362001)(83380400001)(38100700002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVNQcGtVSXA1ZVhDMUVjMDJHRytHeDkxT25LWTlpREYveFZUTE1WWTJ4eGhP?=
 =?utf-8?B?N1JibVg3UzJZL0R6ZzFwcE1WVVdqMVAxdDVuQnZpTDVGZTRTTnk1ZHU5TXUx?=
 =?utf-8?B?WE1sNjZ3dXFWdlNvbEF5QjlzbGEzOEZ4WG1HU2J5dnIzYnhsa0JwYmZPa1ZI?=
 =?utf-8?B?TDZwZ2FQL2NRN00xWnNwdHNmcTJuMzFsT2FUc3oxKzRlZExZYTJVSit6eTNY?=
 =?utf-8?B?L1pDbTdiaXlBMW9KbmRtY1gxWnRWcU1WSGFsd3d5WkdUZzZBUUFZT1QrcGI3?=
 =?utf-8?B?MDR0TERMb2FORE5NTEZtNy9VR2dSUjZiek9wbmVQTVJ6MjBqaENTemQ3Qk5K?=
 =?utf-8?B?NTZabDdYTE82L1ZNa2pNUkxHdm1CUmhEZFc1RTl4VUt0S0FFdFplb0M1bVhu?=
 =?utf-8?B?S2J6U3FqSERWSTVaYk8wSDJMNk8vU29aeHlHMTZENnZ6d3lyM3R4ajhQZDQ2?=
 =?utf-8?B?WmdqK1lRMU9HcERpdVpwU1FTMktHRUttbjVFRWpVODA1U3NmWDg2RHhmRytN?=
 =?utf-8?B?WHlNMWp4bStZMTZlU0tpQUxRaTRvQzBCQ25wQmVqYzlTZ25UYWo1Z3dpN3FM?=
 =?utf-8?B?OFB2aFVWQnljVEltWEczTCtDNGN5UFlQZUQzbWZGY0V4dFhhNkU1MUtPYzJF?=
 =?utf-8?B?cVE5SGxHbHJIeWN3ZXBaN0w0ZENKRm5OMXBFOVpjYU9NWjZCUHZQNmgrU1pp?=
 =?utf-8?B?eGovbTVqRi9OYTJrd0cxN0p3SlpxOEk5Zyt2YjZWWENWTEJFbWhEZ3dLTFA3?=
 =?utf-8?B?bzNISnFJQTFpcTlHUFl0MkxtVi9HQmRkTTlwZGRqRzVVYnFjN0ZXbER2ZGI5?=
 =?utf-8?B?OXkyLzhTTHk5NCs4MmxqcDhHdlFaRFp6d29tTHBoUXlUTXZGZU9mZlNvWlBB?=
 =?utf-8?B?WDVVSUtRTFl1TStDamRkaFE4cmdZaWlJVGFpNVJHTlh4S0V2YVYrUHkwN1pE?=
 =?utf-8?B?L1hKTTFPQ0xQLzhMYitVOUxxbEJ3bEZVS2hCeWhyRm9XWTRVdC8xUnRoRjc4?=
 =?utf-8?B?VkdlTFlZWjR4aGxhTUFZd3F6cXRGUkhwTndHWURTeG5UMEtSRUJBSXUxTlRZ?=
 =?utf-8?B?U1ZmanNidHNPYTBCNE9mc1VKYTdKei9vcFNrTHpiU2I1UUl2N0d6ZVorSVhE?=
 =?utf-8?B?M2pWSG1VOGtCMkYwSGdjSTBlMDh6N05mdlozOWk0U3BKNmFUeVd2WFNxMXZq?=
 =?utf-8?B?d2czUlFrZSs1WDFLUkl1L1hQTGk2bnZZTDdMcG9QenBXTERodXIxbVpQSEdm?=
 =?utf-8?B?OEtPbFhuK0RrUXF4cUdQVGpiOGIvMld4dXI5ZnJjcVZFSFZCdXIzbVVSRmZr?=
 =?utf-8?B?RHhvMVBqZDdRRis0a1FKdXN6N1JQUGxMZklnOWI0eGxwRVc2Z1hnd0oweDl3?=
 =?utf-8?B?N3FuMU12NVlPV2ZLVmlXUk51alphMW5Rak44RnN3OXBCa1d0WHowV253U1hO?=
 =?utf-8?B?djZNWi9vNWtpY2N3TFZ6Sm0yMXpmUkU2bW05NDBid3Y4RkNpN0hwS0h0alV2?=
 =?utf-8?B?R0NJVFJodEJUVFkrOUsyLzdUWjN0OTA4MjROb0xyaTNJcEdWdk93VE0rNlE4?=
 =?utf-8?B?bkVFY0dlL0hKUUVveW9iem9KTmFlNGVEVmljeDNiMEFSZ3VOV3d4Q0xtSElP?=
 =?utf-8?B?Z3VoNXB1WThrYUFnYi9WbFNESjAzZXVCb0lYcnF5S1RodWhQd1pjOWJNRE51?=
 =?utf-8?B?TmNXdmhBMXdWV2htQlZUOURxaldscUxLNVpVeTBPQTZLb1dEbU13WHBvTHIz?=
 =?utf-8?B?MVVNK2RVMk9BbnExekNNL0FoMXdVZEc1Ykk2UnQ3dWpLR0k4dVc0SEM1NDNN?=
 =?utf-8?B?QTRnTXdRanlYYXE4TG1rdzdJaysyKzVhZUllU2hoNmxGbUNabEd4MXJZb2Vs?=
 =?utf-8?B?V2V6Vi9hd1dSOW9jbDlnZEJ5ZmxwTmhNODJKMWlXaWwvZnBXaldOckVUTC9V?=
 =?utf-8?B?VnA0WXkzeFVseU51U2FBQVBha1NkKzI3UC81ckNDUGJKVFFMOEc0bTE3VzE1?=
 =?utf-8?B?bjR1VjBocXgvejE1RHh3QmtyMEsvSENvcU1yUC9hby9lb2U4Y21sV0FaV3pQ?=
 =?utf-8?B?a0VBR012S1VReVZzdVNld0Y2bXUvekUrT0RxckVtUlJ3Z1RRNTBqS0FweUJw?=
 =?utf-8?Q?IfwcZXV//qnUqu6wI/bnxPqCn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15fbcff-a0e9-4804-753d-08dc1ba4e827
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 23:50:26.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBZcOgdAoe7oZZnXZuRgsGN7VoeGEoevsCSbXuBYaA8J9H8qRZIbQO++z8oR4r0jNafvH8A+RXBmCdPfXXuKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483

On 1/19/2024 04:22, Mika Westerberg wrote:
> On Fri, Jan 19, 2024 at 09:48:29AM +0200, Mika Westerberg wrote:
>> On Fri, Jan 19, 2024 at 07:37:56AM +0200, Mika Westerberg wrote:
>>> On Thu, Jan 18, 2024 at 08:12:56AM -0800, Dmitry Torokhov wrote:
>>>> On Thu, Jan 18, 2024 at 09:47:07AM -0600, Mario Limonciello wrote:
>>>>> On 1/18/2024 00:00, Mika Westerberg wrote:
>>>>>>> Before my patch, you see that the JHL6540 controller is inaccurately
>>>>>>> labeled “removable”:
>>>>>>> $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
>>>>>>> {removable} -e {device} -e {vendor} -e looking
>>>>>>>     looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
>>>>>>>       ATTR{device}=="0x15d3"
>>>>>>>       ATTR{removable}=="removable"
>>>>>>>       ATTR{vendor}=="0x8086"
>>>>>>
>>>>>> This is actually accurate. The Thunderbolt controller is itself
>>>>>> hot-removable and that BTW happens to be hot-removed when fwupd applies
>>>>>> firmware upgrades to the device.
>>>>
>>>> This is quite interesting take. Does fwupd rip the controller out of the
>>>> box to update it? By that account your touchpad is also removable as it
>>>> may stop functioning when its firmware gets updated.
>>>
>>> The Thunderbolt controller is connected to a hotpluggable PCIe root port
>>> so it will be dissappear from the userspace so that "removable" in that
>>> sense is accurate.
>>
>> There are systems as well where the Thunderbolt (and/or xHCI) controller
>> only appears if there is anything plugged to the physical Type-C ports
>> and it gets removed pretty soon after the physical device gets
>> unplugged. These are also the same Alpine Ridge and Titan Ridge
>> controllers that this patch is dealing with.
>>
>> I tried to think about some sort of more generic heuristic how to figure
>> out that the controller is actually inside the physical system but there
>> is a problem that the same controller can appear on the bus as well, eg.
>> you plug in Thunderbolt dock and that one has xHCI controller too. That
>> device should definitely be "removable". With the "software CM" systems
>> we have a couple of additional hints in the ACPI tables that can be used
>> to identify the "tunneled" ports but this does not apply to the older
>> systems I'm afraid.
> 
> The below "might" work:
> 
> 1. A device that is directly behind a PCIe root or downstream port that
>     has ->external_facing == 1.
> 
> 2. It is a PCIe endpoint.
> 
> 3. It is a sibling to or has any of the below PCI IDs (see
>     drivers/thunderbolt/nhi.h for the definitions):
> 
>     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_NHI
>     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_NHI
>     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI
>     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI
>     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI
>     PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI
>     PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI
> 
>     And for all USB4 we can use the PCI class:
> 
>     PCI_CLASS_SERIAL_USB_USB4
> 
> (4. With USB4 systems we could also add the check that the device is not
> below the tunneled PCIe ports but that's kind of redundant).
> 
> I think this covers the existing devices as well as future discrete USB4
> controllers and marks both the NHI and the xHCI as "fixed" which we
> could also use to lift the bounce buffering restriction from them.
> 
> @Mario, did I miss anything?

The bounce buffering restriction is only for unaligned DMA isn't it? 
Does that tend to happen a lot?

But otherwise I think this does a good job.  It will cover external 
enclosure cases too because of having to check it's directly behind a 
root port.

But it should also include comments about why it's not needed on newer 
systems (IE the ACPI hints for someone with no prior knowledge looking 
at this to find).


