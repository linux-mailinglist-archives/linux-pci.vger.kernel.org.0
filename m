Return-Path: <linux-pci+bounces-600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C536807E2A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 03:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835C71C20C48
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E2E15C6;
	Thu,  7 Dec 2023 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DKDaYxNo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8B9A5;
	Wed,  6 Dec 2023 18:02:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg8Ez4smopU55+f5Ys+TSJl0s5/YoIJjKaKrO8oYWelrkO5hb5MpQ5wjTJlsuWfMgLqVIP0b2RWirGkqJPvVvBlxhhRSJOkKAZVG8W3Cs4hllO7TpiaZLxxSh8IQVe0/YE4LnHshG6QzIeAMk1du0kl3FrB4WVb0TsU695qy5IdNrRcekGwc5ju47Og9hRWvBtHkgDs+IJusGjQIxtLfBrMcZmRBSYZcJCEuqXMAE8+bn+m86j5E15toxdseuGXv4K5OoJLBkgu/PrFvTJo10mUXZ6C1axSjLi8z/N5Kcin+U6Tsy69y72VpSbp8pM993WztdOCIPNXcvP3Jyg7Z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e69UBbw6gJYYm6gZonsI3oyaIgCMo0+6Pi8AabL/qlw=;
 b=JMOpT2G3U5mQXkYYjnBD75GHutAPiwJfBhx7wFOAFK0R8dJbEb8sUgqj0Uoc03JhxYSUDzdviLY3Xc/LwUeKGxyqmfYADJHHsaPvb3Xe2YlIas2fnwB5ntXXLG8VFmq80FA20KSCYryKUi/h7WiycseSnysS2K1M4TaEOYgFZ6MvFu6ilC/8oxBlUPvW34mZzVZXtNARtUdbmBzmdJz3N1cKHCRewoUzpliZ7VfP8eQgEWp6nLYVtIOYYZ4brgrcl5VNRYrdcVgOIXMvqTp9UA7SaSJZpiCpk6nistYwYZ5vO3p4q0zE2bMOE2jBoOrN3pMn5vq6hvhKlVweWJ5uZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e69UBbw6gJYYm6gZonsI3oyaIgCMo0+6Pi8AabL/qlw=;
 b=DKDaYxNoo/IzVy48L9Rerb4B9mTy1xkhOwcQMG6I/lbJlY2iKAGig2e77Nw6LjnAJHz0/PsUvGFZHeFaDDARNP7u8/s16awcnEFNf8bzqFnF+wqfNwBHKwLapPlf+xWln+1Y+8EGtQ2B9+Z38Gp6SVepIT5Q91Ej2xPgWdwrvEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 02:02:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 02:02:36 +0000
Message-ID: <74f6598e-0220-46d3-9f53-ec9cb92e02d3@amd.com>
Date: Wed, 6 Dec 2023 20:02:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: Call PCI ACPI _DSM with consistent revision
 argument
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231206230419.GA733407@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231206230419.GA733407@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc52a75-20cb-4422-a179-08dbf6c8956e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3vyGn8qrK8Hgz1+XSnhE/NIUcxuTsLVFutYUS+Z4aqm+K4ICTWDb8MCmyxPiZLaHt0sIMDurlcjyOk3Wg2WQoiZWZrIuD3iWdgz4EFkubLqJgnXq3wHw/u0nzYHMJQx8R/hCyy8DGlGUN4GkaaYuTy9PPCQGZTzvoWSWLikSWyx10UPizFifNJ9x38YwdQ6XWgdJe5nM8uwBO1JNooURY2F4whzQ52z/OJBld2uwldFjc96k+UhmIIODu5zz9wX/FJ5WLP/roGr0wlJ+jJ6CPyDnvWSEOVrGpLwEhgx8F9ZmB0MhHK4ont8F0lhs1QCn4rNgvqUEmu0t+cgocVnpMvekPPz2Atlhn9tx5GDIY5qZ6SPd2vnRQ9TAHRYgQnWAtw1aiXqrUytkX6OaKnROOI95lzenz97lbe+2LjMa7DEotNOWXlsuNgmqXPOP2Q7havqYBSkjGq6MECdHfFzfksp51qM5nGolaxfXarlvrs4uXeWRqUnTsRf7hOB0uSMC6/m1YYGg87dBr2HqC/cGyspBCCX7A5z272t9qjfFg27Gg2PoYLF9aeABznxBVPHmIJCGLMGKhMIB5KKy26Z2D+hBK7cysHh6cgs5jQg+nIPqcQY8AxxL6nkFZynGYb76acqYPvSUcbqwJ/gH2yceMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(478600001)(966005)(83380400001)(6512007)(53546011)(2616005)(6506007)(26005)(6666004)(8676002)(66476007)(66946007)(54906003)(316002)(66556008)(36756003)(6916009)(86362001)(8936002)(41300700001)(4326008)(44832011)(31696002)(2906002)(5660300002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UExVWjJ4SlRxNDZMNkR6NlEwRjFuK2ExMlExdGJQMGVSVTIreGlwTGREaHRi?=
 =?utf-8?B?RDVwbzhSdGhsTjZGeTc4TzZkempPVnE5VGxaWTIxdHN0NEo2Nkt2clMzeG91?=
 =?utf-8?B?MXdkQTVFZ1ZubmVESDFSQTdiNWRCVVd2c2RJREFWWDFobmFSRTFLbHhqc3dq?=
 =?utf-8?B?UnpQQ1VOK2NLNkRQL3c2Vlk0UU5rM2pQa0tBL0lMb0lOTkFaNWJaQ1p5ekg2?=
 =?utf-8?B?WHAzNC9YN29lNmJRbWYwVU9vTmI4VjZDMGNYeVFBYTVtL3JBak0wa0VhSFp3?=
 =?utf-8?B?RTVCTnRyTFpYcTlDY0s3QlVndGhCcFFrQXV2T29aOUM1dGxmU1NZN0l0Nkwy?=
 =?utf-8?B?NERYVHlmSE1NZjh0UGc3K1J3VUVsK21FZEdFZmtzdUplVmVQY3kxWHdZRzFL?=
 =?utf-8?B?cExqUWM5dkZ5eWd6R0c1U3NITE1uSDVuUGR5YjhWUXlLdGJuWXYzc0JOL21v?=
 =?utf-8?B?Q3FxNjNtYWo2K0VZaktNQmtUODBzOWVVS0NWdDRsSXZkczh0QlVKQTFDRENz?=
 =?utf-8?B?RTNYWHpDaGxsVjlTMVcvc2FnVEU5eS93Y1ByS2lKWWRVMTczcko2ZjlQem5Z?=
 =?utf-8?B?TUFvWkRZUWJCeFdKWVdyajJBYm5WanJUanFjVnRDdWk3Ukl6aTkzdHZmaGNl?=
 =?utf-8?B?ZDhUY1lzNXlGNGtiZWI2YzdsWDFoQyt0ek1yd3NaVnAxSXRycXdIUnBZM3NL?=
 =?utf-8?B?SUQ4TXJnRTRhdnlkclJGeVlRaEwrNTR4eEc1cjBvRVQxTzg4UXRLeHMvYnAr?=
 =?utf-8?B?NkJRazhLbW5KWkdJT3dNMFpLM1hlSDFtRFdzOXUzU3k0ZmVXQ2ZqeXUyMVpu?=
 =?utf-8?B?SVpaNWpKZ0V5ZHAxQmJDanRCbDNRMnZNWlhOMFA1a01DYkozM2NFUXFUWVZs?=
 =?utf-8?B?VFZZUTVHcmNISm1HdFR0TUlaRUQyT1pZUDhFQ1c1Znl5SzFQR045REV6dmh4?=
 =?utf-8?B?Z1NLSm5lUjczeTBsS3BzVGQyUHZnM1FuakFBMWExRGJDWTdFQzV5M0xidGto?=
 =?utf-8?B?U3o3aVQ4bWc4aUhkTlFwbnNhUmxseUpqYXJMOWYzZVlTend5QkVxZFdJbUVS?=
 =?utf-8?B?YjVtTWZFTTVNQlhBMTRCMlprYjZWRUF6Zno3NEgwUldZQkg4dUVSYk5tbk9h?=
 =?utf-8?B?L1JLVmluT1F4cEFLUm56QlVCRnF2MlpOVDh1cEY5OFZoejEzRmhGUVhtY3Rq?=
 =?utf-8?B?QXFQMWVIUnNYalJHcm56MFIwdXU1RWhtT0tVcU5jeVE5LzkxT0dzWjNvZS90?=
 =?utf-8?B?eTBhTzVJclFwc0puMUF5ZTM2TmxqaGVld2ZWTkJYdVZISmxrK0lYMzNCZ1Av?=
 =?utf-8?B?T0pYOG1WU0wxcVhnajIwMVp1NzNnczRyUTkwUjh5L1RJelR6ZFlINTl0UFZW?=
 =?utf-8?B?eXp4dHhLTXFwWDJvZnhYaE5YcXFIV25PUUFlV254QXhjejZGOEw1dXZXQ2Yr?=
 =?utf-8?B?RHdaZklHUFRvMG9EWGlteTRnSnlCdzdGclhGSFI3cUVzaVZ2SFErVVJkUyty?=
 =?utf-8?B?OGRjUk5yVWJNRnlZU0RObVJ1NEJ1TTFPcTFSZllhZ2w5aXlrdDVBMHBYeUhl?=
 =?utf-8?B?QWd1cUdNeVJWdjFOMVpMOVh3elMxdkU5ZFJhSGE0VGNrZEp6L1p6eU53SjAz?=
 =?utf-8?B?SmN5RTJyZXpPUVAyejlsdWRKNmk4aU5LUG1kZXlCZkZaTXhaK0xjTlZqMW5Z?=
 =?utf-8?B?azNTZ2ppZDg2dFlqTDdMQlU5Vy9zS0ZmSDQyaW5oMkZBR2hVT29sSWRYOVFJ?=
 =?utf-8?B?eFJIZFRsdzExYklHY2pKeGNJNEFzbjlvNVhoZFNhalJuSjNzZWJpYUNCVk5j?=
 =?utf-8?B?bWpzTTdJdEVTYWcrNDhlWVlISFQ0YkNpcko4STlLdXdVdlVMeEFESndNbjdD?=
 =?utf-8?B?dnpqcjZ1L2NUTzdBWEpYZWJWOEhmeXdzNnBlUWhud0RxLzRTV0VGQml0dmZs?=
 =?utf-8?B?NlB5b3hmMXArY2dvS2g1NlY4Tnp6d2VNZDBTWkdodTdFTk1yL1paZC9TZ1B4?=
 =?utf-8?B?cGgvK0hsV3hXNWhDdGxKRXNhM3RqTEcxQVh3bjFGVWlhV3VCbmVheGdNbWdO?=
 =?utf-8?B?ZWVkR1FsR2U5ajFZZi9FRXRTelkxOSt0UEpqT2U5eXd5WWFJY2VBV2FhaDZx?=
 =?utf-8?Q?TgQq+ttp3b6cROCtYkz/e+pdO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc52a75-20cb-4422-a179-08dbf6c8956e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 02:02:36.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3J/hyZyzpTuBtgecupsyOSahG/uxWDiWOnJUeVLyF3mkskMoJFGb/s7iQJZFiyzKYE/AU7qCPVSUPzXCRMUIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

On 12/6/2023 17:04, Bjorn Helgaas wrote:
> On Tue, Dec 05, 2023 at 02:12:54PM -0600, Mario Limonciello wrote:
>> On 11/30/2023 16:29, Bjorn Helgaas wrote:
>>> On Fri, Nov 10, 2023 at 12:55:01PM -0600, Mario Limonciello wrote:
>>>> The PCI ACPI _DSM is called across multiple places in the PCI core
>>>> with different arguments for the revision.
>>>>
>>>> The PCI firmware specification specifies that this is an incorrect
>>>> behavior.
>>>> "OSPM must invoke all Functions other than Function 0 with the
>>>>    same Revision ID value"
>>>
>>> This patch passes the same or a larger Revision ID than before, so
>>> everything should work the same because the spec requires backwards
>>> compatibility.  But it's conceivable that it could break on firmware
>>> that does the revision check incorrectly.
>>>
>>> Is this fixing a problem other than the spec compliance issue?
>>
>> It was just a spec compliance issue I noticed when implementing the other
>> two patches.
>>
>>> I agree the PCI FW spec says this.  It was added in r3.3 by the ECN at
>>> https://members.pcisig.com/wg/Firmware/document/previewpdf/13988, but
>>> I don't quite understand that ECN.
>>>
>>> ACPI r6.5, sec 9.1.1, doesn't include the "must invoke all Functions
>>> with same Revision ID" language, and the ASL example there clearly
>>> treats revisions higher than those implemented by firmware as valid,
>>> although new Functions added by those higher revisions are obviously
>>> not supported.
>>>
>>> PCI FW also says OSPM should not use a fixed Revision ID, but should
>>> start with the highest known revision and "successively invoke
>>> Function 0 with decremented values of Revision ID until system
>>> firmware returns a value indicating support for more than Function 0"
>>> (added by the same ECN), and I don't think Linux does this part.
>>>
>>> So I think the fixed "pci_acpi_dsm_rev" value as in your patch works
>>> fine with the ACPI ASL example, but it doesn't track the "successively
>>> decrement" part of PCI FW.  I don't know the reason for that part of
>>> the ECN.
>>
>> Do you think it's better to respin to take this into account and be more
>> stringent or "do nothing"?
> 
> To me, it seems better to do nothing unless a change would solve a
> problem.  I raised it as a question to the PCI Firmware workgroup
> (https://members.pcisig.com/wg/Firmware/mail/thread/32031), but I
> haven't heard anything.
> 
> Regrettably, that link only works for PCI-SIG members; here's the text
> of my question:
> 
>    Sorry to reopen this old topic.  This ECN was approved and appears
>    in r3.3.  We're contemplating Linux changes to conform to it.
> 
>    I think I understand the ACPI requirement for OSPM to invoke _DSM
>    Function 0 to learn whether a Function is supported (because a
>    non-zero Function may have completely arbitrary return values, so
>    invoking that Function has no way to return "this Function Index
>    isn't supported").
> 
>    I don't understand why it's important for OSPM to "invoke all
>    Functions other than Function 0 with the same Revision ID."  That
>    idea doesn't appear in ACPI r6.5, sec 9.1.1 or in the sample ASL
>    there.  Is there a benefit to using the same Revision ID for all
>    Functions?  (Of course OSPM must invoke Function 0 with Revision ID
>    N to learn whether Function X is supported for Revision ID N.)
> 
>    I also don't understand why "OSPM should successively invoke
>    Function 0 with decremented values of Revision ID until system
>    firmware returns a value indicating support for more than Function
>    0."  ACPI r6.5 doesn't suggest that, and the sample ASL returns
>    different bitmasks depending on the Revision ID supplied by OSPM,
>    including a default case that returns a bitmask including all
>    Functions implemented by the firmware if OSPM supplied a higher
>    Revision ID from the future.  What is the benefit of probing with
>    decremented Revision IDs?
> 
>    Is there something PCI-specific here, or should these requirements
>    be in the ACPI spec instead of the PCI Firmware spec?
> 
>>> Unrelated to this patch, I think it's a bug that Linux fails to invoke
>>> Function 0 in a few cases, e.g., DSM_PCI_PRESERVE_BOOT_CONFIG,
>>> DSM_PCI_POWER_ON_RESET_DELAY, and DSM_PCI_DEVICE_READINESS_DURATIONS.
>>>
>>> Per spec, OSPM must invoke Function 0 to learn which other Functions
>>> are supported.  It's not explicitly stated, but I think this is
>>> required because a supported non-zero Function may return "any data
>>> object", so there's no return value that would mean "this Function
>>> Index is not supported."
>>
>> What are your thoughts on the other two patches in the series?
>> Should they wait for a consumer or prepare the API to match the spec.
> 
> I'd prefer to wait until there are users of the new functions.
> There's no real benefit to adding functions that are never called.
> 
> Bjorn

OK thanks - I'll put aside the whole series for now.  The first 
immediate consumers of this would be GPU driver, but it's only needed in 
very specific circumstances that haven't come up yet in practice.

