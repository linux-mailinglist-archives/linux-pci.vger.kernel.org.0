Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D507A069E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbjINN6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjINN6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 09:58:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28A21BE3;
        Thu, 14 Sep 2023 06:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVFpZQfX6JWRzFT66fVt+7QDu3x5/V9RUqW0tuzDoiVkNSdQx/VSL86gOG1JcSwg/HaiQA8C/Xo/JHWslVRGXP3UA5VoZuqA69RYKNZRQii1BpU63pMdnuB1t9fxseDXNCw2coAgnk2UKwHtd3TPKkWbE/2AGq4Q3Fad/0/4u/ShKyP5O/iW6xnQ/cdF2uV/12t/YbP25z5shbsmtxry+PDN1j2HFBVgdBNQF+0oPJLmexzaJ3yD8/Q45qbDhL5qI13jZks7CN8uSdVrbV1C2qQSggguM5ZGarm2N2ZflFI9kZrkTkfIDmpijcvk+2iFHDLOd4UFdCYElbKXe86Agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N04PaOR6EuWPxjR8d7J9sKuZO7OEbgiko/snri6VNf8=;
 b=BqvxjF8loItpVn1N/IyOrHYtu+kPkPRosh9Neg/uwlTYR0djbUnTt1SXUCAP9F0D54sITBxZGGtxZvfiMcCIQgWxUECUTvt5vpaZtQe1yoMIpSJi9K3SbOg+PtCnEh3c3BbH6cnKzrEXyEGBYygc3eWBcE8TE0+UF+AeFBbRMBlvZafIzy2pJaDEZRvmyS8bfm10LfijUD0GOpmI1UntpAzKXPiYmdxaKVXcYEcTp6WjQKoS8fu8KHra3EXJvmLHlcnQkmsW3+3t6TkVEirf+0/UmSpz/6x5UGslgyzbQ3F0KrsQYEN7VCMMQ/qegswQMpweVJT0J+9+fR/BQyOb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N04PaOR6EuWPxjR8d7J9sKuZO7OEbgiko/snri6VNf8=;
 b=4hc2LatdvliZrDBMSTsDdzuPIv4EKTNHPKp2nqJAPP9qR12eZ0+ix2ze9AZMMlVwXUGM3nkKKnvydPWOWWi6WJd2aXNPHJpOkGoFkBd5qaEKyKHPqIK6rnxqehM3FNCTrsthSsfPJ3ZgketLHgPT2hJ4QetHfHX8mIz+hWjqBMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Thu, 14 Sep
 2023 13:58:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 13:58:01 +0000
Message-ID: <9a936eaa-0e6b-4231-93a4-880a7c00a6a5@amd.com>
Date:   Thu, 14 Sep 2023 08:57:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
References: <20230914123200.GA25154@bhelgaas>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230914123200.GA25154@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0128.namprd07.prod.outlook.com
 (2603:10b6:5:330::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a99147-4358-40d3-025e-08dbb52a9bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ae+M/wgHWJKg+82OhxdrEJXUTYCty2tw6LKQdH6QpbBhRGpr8amYYtCTpq3fCHaRjcPMOpKkR12TWc+6KnrJ+J7YxCImQfkw1IvLc5J1MEz+SzVkewCgp3YE0iL5RQkDGEYGQyk6dHWHfJd0ukKV86Emuraro1G5pJ7YeRRcSDjcGADhtzS6Xdt9Zv1PlVXZY6CoquTNDxxZb5ciwxDStpdzasA9jIj3puu6Rf0Gkr52LKBEXjgUEqEKrN+0FTh0EI6lOKQ15zdYlt86z2Zf88nL9ILl/m5BjO9KTWGE0Iur0mMPYKCIUaJbmxd6g/LaOZ0acoFYWPG6ugzozvZqytpz/NRkNMsHrFG4eZNFwibd9Jzh6oXYzmUoVTjac/IvUnY5sxChlqqycaxR1ZO0EFfXiPFQgx3E4JdSGMNA8YTCNlPS8n7SH1vvBcAZ+NAPWgn5wFTGQNGcf6bnHk2LsVMg+JKDUtWw6y35Fr/ePVV5gIoPTlZw99JduPhOIpm2NngPzEGY994TuQTocNryksMJlf9I9QvIbf4B4boEO+K+iFMK39rA7JIw80AbrO4eZ6hDI+aVZ3xH0LtjRWVQS7+wkON9Nhip0tG5/Or/sQcUOKJh7/4a8NXUOC2Ui+A4hd2gxX7VOhVch6VpKfwjGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(31686004)(66556008)(2906002)(36756003)(7416002)(38100700002)(31696002)(44832011)(5660300002)(86362001)(6512007)(478600001)(4326008)(54906003)(8676002)(41300700001)(8936002)(66476007)(83380400001)(26005)(6506007)(2616005)(6486002)(6916009)(53546011)(316002)(6666004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXVzWm5BOUR3cXpZanlOS2M3SXdiTmZMemdOcE44MGxDeWtGdmk2cXA4SEdh?=
 =?utf-8?B?eDhKSFViSGNWajU4R29QQWdQRUQ4NC9HbWZDNUFkbnZSY3ZVbHpWSzlsaEhm?=
 =?utf-8?B?bEhPN3ZNM0tzUnEyL2N2REZkcVZlZFcyQ2swS3g5ekhwWjg3cHhCTFBKSnUx?=
 =?utf-8?B?Z3Jmbm5ZcjVLVWhONlp5elZ6T3ZkcUJWc0tWK1RweTJhbnFEak9lMGluSTNN?=
 =?utf-8?B?V3RHZTBiZ3JndnVUWHhKQmhPREltZmphOEdreU1tTXBtSHVuUnExQ2JwSitu?=
 =?utf-8?B?dkZrYkx4Rm9CN1M1UCtoTk8xVkcyZkxuckdvSFZzNmxVbEMrRnNzcndodDAr?=
 =?utf-8?B?SVpYb3B1bkwvN015ZTZwR0tkYUhiZXRxNGRRQmZZcnJ2bndQQ2dHcmVjM0xx?=
 =?utf-8?B?QUZhMXNobmZUSUplalpPUzBGMkRBUWVDNWVoZDJYa1YxM3QyRUpPWHdUSGtu?=
 =?utf-8?B?cHNrQmNUWGJyTGpuczdMZU9Zc1l0ajJnU1l5OUhONW5EWnFxSU8zMiszUmJJ?=
 =?utf-8?B?Zzh3RUpZZURKTUNBalFjd1d1R0RwbHlQeFZheUxPcFRmR2FCSDhJRnUzcnpC?=
 =?utf-8?B?aXBqVGtqTmhqZHpuVG9yTG5qOVFGeFlmNG5VMHhEMkRQeVJKVUI5dWNDRWw3?=
 =?utf-8?B?ZzNjQUpxQ25URkM5Mkd1eDZ5OUdSNmFwam5ZK1crekFrTTdvaTZiQU9iOGxl?=
 =?utf-8?B?NHE4NHp4WG0zZUhOajdEbERnckpwakt2NU5RNEcxNzhtWjc4S2Ezc2hqTHg3?=
 =?utf-8?B?bW4xRXNQeDV5Y29peGovakpubi9WWWJDWG9odWRiaGtRSW10RmF0ajliZnJ5?=
 =?utf-8?B?QzdMd2hlRCtDVFY0aFF2NTdla1VzWjMwZFdxQVJPSWtMc2lTTW5FNDVycWtI?=
 =?utf-8?B?UEhaRlpsdDh4ZmZRN2VHMDFaQ3dPOENRRU5IOVlnZ21qeGJ6elpOV1pOc1RW?=
 =?utf-8?B?R2E0OXhZT0hiUUY3WDFXM3Q0ZTErOUVuaDM5SXRQcWVxcWs4OERQbWRuSUda?=
 =?utf-8?B?YkRLVTRMUTMvTkFSeHM5dDJvd1k0d0xhZFl6ZVZsN0FyTGtKLzEyZ2dpa1JW?=
 =?utf-8?B?M2dZcURGbXFYWm9JOUp3QTQzTS93SzlaM25GTkZITVNDZjJFS3hXcUFsb3FC?=
 =?utf-8?B?UzRnSURITEw4TDBrRkJMdkw0QTFIZWdJVncrODVaWitwMWcyVFF6VTFzR3Zs?=
 =?utf-8?B?cWdObnFlU1dIbzczSGd0YnZQWjVFc3RyVjF0U3ZpTDh5YXRleW40RldTOG5O?=
 =?utf-8?B?U2lSZ0dpWDJFMWd2cU1SaXFNT0dFcWFmN3BBV1laemNQZlJQVDZ5cWVmR3hM?=
 =?utf-8?B?QnhITmdJbTBCbHRPVFBMTkVXa0xCeXVEYzkrMFoySkJiMEthTUVSekxkVnM5?=
 =?utf-8?B?RWNOM0gwblFCcWRNUjZVbGJMcDRBTXg2ZEhBTnh3QlB0SVdvSXU0Yzk3MGtC?=
 =?utf-8?B?UkNZaEpEdVRWVHRPUExxVFdDZG1EUnlveitTYm5rS2V5bzk1bjJ1Wmd1SmtT?=
 =?utf-8?B?ZjdLeU5Wd3ZnY2dlOXhVUm16VzZpS1VWNkFnQjJPcmZPYTA4ZEhTTS9IOFZK?=
 =?utf-8?B?SGE5SDQyRE03L1hRa01lN1VyOW5oSkE4T21VSVZGUmpteVM0YVVJRUgyQkEx?=
 =?utf-8?B?Y3Jvc2haVVVhV3RiUWVtZTlCTVpvTFR0SWQyUXBqUnBsWjQ2K3VHVVNnUjRR?=
 =?utf-8?B?TzFVaUFGZHpHbFZDTGRHNmxYbE5uMTB6Vzg3ZDNZd1NuT2VpbEE5YTVIZzNW?=
 =?utf-8?B?VEpTYmFtTi9XTVZCUVJNVzFLa2M0a2Q5akVmVXBPVWE5R2ZlSlVyQ3JSRGNB?=
 =?utf-8?B?TU9Gb2NoQWhXcEFwNTd6bGZRcUtmN2RkU2lSZzFuL1V6cUtKNnhrS1dkVXkz?=
 =?utf-8?B?dmFIZzlqanJWdlR1VVh2YWxkdXdyU0dCNzN4K29YYnQ3cmJtdEQ4WFdnTkNp?=
 =?utf-8?B?bTF1OW1qM0J2UTMzWnRVQmNXN25HQjhqdGdwaUpmSXYvSVRzQWVlTFVGb3RU?=
 =?utf-8?B?VFlLbk5JaW5MMjB1TWFYbjB6V2N5dTFPUEtIcndZYjZJV3EvVnQ4cHFSdHZv?=
 =?utf-8?B?MW1RamlCMTJHV2JUZS96UG0zaVkvQjhjWk1nZFZXTWw3cWgxUytnckt1ek9w?=
 =?utf-8?Q?37xpNmXU9dgkACpCPgl7760sm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a99147-4358-40d3-025e-08dbb52a9bfe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 13:58:01.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zicIeGy0epQS6UaEUcKWHQkMvGdrtQN5WKQEsnN+XdrkGcNarrQ/4ViPJguxYH/CMy9ajuV5yQjpZIO6Tr/AYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/14/2023 07:32, Bjorn Helgaas wrote:
> On Wed, Sep 13, 2023 at 11:59:00PM -0500, Mario Limonciello wrote:
>> On 9/13/2023 16:16, Mario Limonciello wrote:
>>> On 9/13/2023 16:05, Bjorn Helgaas wrote:
>>> [cut]
>>>>>> I expect it to be an ongoing issue.  I also expect unless we use
>>>>>> constraints or convince the firmware team to add a _S0W object with a
>>>>>> value of "0" for the sake of Linux that we will be adding
>>>>>> IDs every year
>>>>>> to wherever this lands as we reproduce it on newer SoCs.
>>>>>
>>>>> So maybe the way to go is to make the AMD PMC driver set a flag for
>>>>> Root Ports on suspend or similar.
>>>>
>>>> I like the quirk approach.  When PMC is involved, the device behavior
>>>> doesn't conform to what it advertised via PME_Support.
>>>>
>>>> The v18 quirk isn't connected to PMC at all, so IIUC it avoids
>>>> D3hot/D3cold unnecessarily when amd/pmc is not loaded.
>>>
>>> Technically someone could; but realistically no one will be using these
>>> machines without amd-pmc.
>>>
>>> The battery life over suspend would be abhorrent.
>>>
>>>> I don't object to avoiding D3hot/D3cold unconditionally.  Presumably
>>>> we *could* save a little power by using them when amd/pci isn't
>>>> loaded, but amd/pci would have to iterate through all PCI devices when
>>>> it loads, save previous state, do the quirk, and then restore the
>>>> previous state on module unload.  And it would have to use notifiers
>>>> or assume no Root Port hotplug.  All sounds kind of complicated.
>>>
>>> Yeah this does sound needlessly complicated.
>>>
>>>> Maybe it would even be enough to just clear dev->pme_support so we
>>>> know wakeups don't work.  It would be a pretty big benefit if we
>>>> didn't have to add another bit and complicate pci_prepare_to_sleep()
>>>> or pci_target_state().
>>>
>>> I don't think clearing PME support entirely is going to help.  The
>>> reason is that pci_target_state() will fall back to PCI_D3hot when
>>> dev->pme_support is fully cleared.
>>>
>>> I think that clearing *just the bits* for D3hot and D3cold in PME
>>> support should work though.  I'll test this.
>>
>> I did confirm this works properly.
>>
>>> Assuming it works how about if we put the quirk to clear the
>>> D3hot/D3cold PME support bit in
>>> drivers/platform/x86/amd/pmc/pmc-quirks.c?
>>>
>>> It's still a quirk file and it makes it very clear that this behavior is
>>> caused by what amd-pmc does.
>>
>> I've got it coded up like this and working, so please let me know if this
>> approach is amenable and I'll drop an updated version.
>>
>> If you would prefer it to be in pci/quirks.c I believe I can do either.
> 
> If the quirk is in a loadable module, as opposed to being built-in,
> does it get applied to the relevant Root Ports when the module is
> loaded?  I didn't look exhaustively, but I don't see a reference to
> pci_fixup_device() in the module load path.
> 
> Bjorn

Right; when done in a module it would be done with code that is part of 
probe.

So it has the implication that it would prevent D3hot/D3cold for this 
root port at runtime as well.

If you think it should be tied to pci_fixup_device() calls then it needs 
to be built-in.
