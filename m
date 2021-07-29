Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142DC3DAE03
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhG2VJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 17:09:56 -0400
Received: from mail-bn1nam07on2072.outbound.protection.outlook.com ([40.107.212.72]:34819
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229738AbhG2VJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 17:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGGZMn70CLzBcUK646DE5TYmhbtqh+3+r3cVkUcf1PbK6ESnu0sUUNaG1SaWL7RfLvwQVLNF1iwy40d0rGY4fN6m61H9BIeoqXdlpUCvDfw3PNnX/t4sIMWGRKab3yys1qITDNUaFsPTeKbQ1m/BHexh3/HNw1Uux007zwgGMi4mV0m6pNK/AcYjgA0/FyQkYkaJWRV4qj5+LfItH3kJ8HGozQqrxdOz1gE4cl0YqY+Ic9rCQOSodI7vRMhk21VHRgjOjnGhvgZBrzbuMt9yV+qyoQj5hPjfgdLK/QeG4OCufxHb4GTUrdR3JoZ8saa8SEjdH2VKZznswIGzJZRiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ9m8CT9YDgSs7apmTljDKycDRfxDYoAy+Fmsj4G7Ig=;
 b=QtWDD3KDzEn5DNe1Vol4ZILqdRrvxc5L63vXJ9EvwEhCNI+O7zWoO6H6Wyq572QRgkJdBDgCG7rBf5f9Onho9FgTaK0XkhygBtei9ss4K9m5wRrU+ytC7CRpEpjSDOSmyqwtshiBAblbRekfny4eyKwV+NmXxG+pVvZIaNrTIWngEVHYq+k8nPIIshP6O10XQEauDzw78jkP6LTaDxRFbGHgY6D3Q1zXlXbHQlLqBifFRfF+5wEWbzAfjO/KZAz1UpA7UfhuKo1DrijrfkjPYSEBbSiE1eUK33HQSHuUQoI3HpkTGkGavn+x0oAq+vrOrCzGW8h5Om0MDwa3SrJHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ9m8CT9YDgSs7apmTljDKycDRfxDYoAy+Fmsj4G7Ig=;
 b=ppcIskgfE94wQgBu27BLww83D1ffl0XLxT7h/WrhzjNOGqTnd9XsAHTdV5MeGCRynurvSbaXjzaVJuKV2snqF7OaRuSlNgVQnNhjtEiSt3Dr8Rf6PBfj9aYAEcipqoJYqfjrUu2bpG3TmqH6m5XmU0hSXo4kFzeiNq0Cp8zXlzk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 21:09:51 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 21:09:51 +0000
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Marcin Bachry <hegel666@gmail.com>,
        prike.liang@amd.com, shyam-sundar.s-k@amd.com
References: <20210729210620.GA990816@bjorn-Precision-5520>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <ad2a6e91-47f2-fc1c-13ef-0cf23805bd75@amd.com>
Date:   Thu, 29 Jul 2021 16:09:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210729210620.GA990816@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:806:f3::29) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.180.36] (165.204.77.1) by SN7PR18CA0025.namprd18.prod.outlook.com (2603:10b6:806:f3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 21:09:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f978e4-a603-4fcb-6861-08d952d5348d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB457539C829B9BC7612A1F3ACE2EB9@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojalGiGNuWsHnCTsR+E6Kiwxbf8lV4v58xS4zK3ytpTyFalLL8KEHa4kgdlwxkThmgXVD3d3Oc5igtOWoeF4h19wsP1lCJcNu/zTvbsSwodgoGZLcFjpDGR8sR9BF2RBywzOyhQJk6Cp+zBkeg2ZcsOmVQtkjMXDSMrj3Kq9uo36xlVgId+B0O4aFFBC0fsY4Y9k52SzVmHkVHb7GfMwhsdXr8554e+hID5R/tojm12su3FS7uH84P2JkEYKq74xuItFwQh4tKijpj8kTjurJi9XqZPRAMf9Lp4xcwhxTTEWu5a6qfZEmGKXn7aEI4Wkl3AtsrixM62PpICX05hNzv8fs9NJ02yrNJo2iqM0sRdqKbJXS3KDuqQMzez0nhj3zWve89jmeMaA+QQe73R7s2ZvfqsSw6SPi9ketzcVQwuFIPPcHIUepDfjP4afcYvL6LmQAY5CYU6MbDlLqSMULBGhba5Lw5gvDWOony70JiwkFDapM0mxTmC1DkkqWFI2/w6syDwmv6jM9/SnfM/9GL4c3bXZnK5xfcxmXAP/YA8a3ZTubs4DUThhc+iWbAT46tv5x5w+ouy1JkG6WDzlzjw0LvjsBlGa4+uSOz2WoFnqclOeCPjETB82RBFfmp64il/M+X0fT1jPJOE7Qmhn2Idk/HI5+Uyyc1p0dIbnza+BxKYJnALAdKv++nUCKIDuhSp+aqmJVeu9D8ZTXcDMcr5fApM5G/BLEyLVsa/5HVmr2VF71+OBESM7Awfe/XQwPc6b0HKk+RKNtFqQVgDDsGmQCcMYC4u6zljCB9PIswc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(53546011)(66556008)(5660300002)(66476007)(2616005)(6916009)(186003)(8936002)(66946007)(31686004)(956004)(86362001)(83380400001)(31696002)(38100700002)(36756003)(6486002)(508600001)(8676002)(2906002)(16576012)(54906003)(4326008)(316002)(42413003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9ISkdRSitoUncwME5IZnVaeEdmKzhScmR6Ti9pYlA5Wm5KV0EvN2NvdDBn?=
 =?utf-8?B?V1FiN0xmOXdBclpIVDhOR2tTazVocDBoMTl2d210Vml3b1lVUVRpWUN3Z1lP?=
 =?utf-8?B?dStsajJ2OWc4bkFHQUtaUVRLSzE0b3R0MTVCUHdoNTVGY1JUQmtLYW9JSDN0?=
 =?utf-8?B?Q3hJYUpydjlDc1ZhbERJS29tZkV1bStoeFNESGo5YTRyUHJIZEFEUzRQM3ll?=
 =?utf-8?B?R0RSdHJoTEZXUnJzWlJ2Qzh3ODZ5SWdaQTQxd0lUa3pjM29lWkgvUzNyT3FE?=
 =?utf-8?B?R09LbDZjVHZuRG43V2xCZkd4NHhNREVLUGVIUGNmNkN5ZnFYdjVTSXpyK2VV?=
 =?utf-8?B?WkM1enF0R0pVNDJOaHNFQ0ZTT2xWN1h3cHRIVkZ4cjhKZ3hmdFd1R0RDVGRa?=
 =?utf-8?B?b2J4UUdjTHFqbUF6aUd6V01PWCtrNk9ZWkpQMEM5OWhQUkU5bjBmVEp6OVY0?=
 =?utf-8?B?UStiUTd2bUpsaDJQeXFOdzBLclhsWWF1aXpFSGhqRDhYSy9QU1dQUTl0OSt2?=
 =?utf-8?B?emdDaG9Va1F4VFZQeDhsUGFVS0I5THVVOWx5WHRaSTNlc0lOS0c0WmRzUG5Q?=
 =?utf-8?B?UGJxVzdjeld4MHdzUWhQeHNJbWZ4V2FEQ2lYMC9ueW0rM0t4cnNaTHlseGlB?=
 =?utf-8?B?TDhuT0ZqdXhSOHZsc0tXOVlwNVRyZ2FUT3VyZTJ3ZVdCbndJNHpDTStGcDNC?=
 =?utf-8?B?clRYY2lYQ0xxaDllQ2NEbHNSSDE4azk2WGk1bXI5cy9NUC9iNGFxRFVnaTJw?=
 =?utf-8?B?VndMYWhoODlteDN1RkdkZE43OG1JK1N1d1VueDFhSU4zQ1Mrd1ZTNUoxeFBG?=
 =?utf-8?B?NGw3SkZXMU5TWW5uYk5XN2xaeHltVjE4ZXZvam5hYmNCRzVXL3hTWHlTVmJu?=
 =?utf-8?B?ZXpsZk1rNFpPSmdzdXA0d0pYY0czd1FhVG1TdEdQb004enBrZVVSMHRMdWxh?=
 =?utf-8?B?SEQ5U1VYU3hPaWoyVk5CdEVmOWg4Nk1BU0hiY21OSXpKb3dQbzQ4WVovaEVJ?=
 =?utf-8?B?VHVXMDd5YzhuRUZnMmU1Ym84V1R5TWlKZlN2V0I1N2MrMElHbWdNQ01ybkZW?=
 =?utf-8?B?RWhiM0UvV0FHd1V3Z1B1VlF0OTJ3cEVFazdqSGFSK2hES3pkMnl4aDNHU3RU?=
 =?utf-8?B?VUNIUTJhcDNSTjI3bE96NDVvNk15NngxZjRlM0c5Yjg5U3ZWeUpVMzd2KzB1?=
 =?utf-8?B?end0b0xHMWtuSW8zTVc4QWhITTFPOVhMU3BOMlIxN2FlVWwxbVJBbHpYdE0w?=
 =?utf-8?B?NS8ra0trZFdOM2d5bnB0dW1GekFPRG04WFRYME9Gd1JnbmN4bERhWWNNTUpv?=
 =?utf-8?B?QjhjMmNXeUpjZUFNSWJZYlcxSkdZY2pYNElpVk5oNEdaZVp2emYyK3ZnNllu?=
 =?utf-8?B?cEh3bms5Z0VWTDM3NE1LWmVJQUtBL0E5R0JYRXhlaVRmZDRnc2FnOUhEOWhQ?=
 =?utf-8?B?eUUzdGRZVVN3ZCsrTDRzZTVPOUw4K1dJTDFmeUVrWXRaYXFWWjFBbkN3UnYr?=
 =?utf-8?B?Q0x2ejJlb3l4M3hCeloyVGlHTlptdlNOcHVGYlNZY2E5Z0xUd3BPRDYrdVNs?=
 =?utf-8?B?N2VWYnJwTUxGQTVLVlVPVDdIUG9jOVhUb2RBNXhKSjduUHFVbkdTOHVZOCtG?=
 =?utf-8?B?OTFEbkFZYWR5ZW4xZDIzM29oeVdzQk0xK09CTU9oRE9vTDRCY2pxUmw2NnJh?=
 =?utf-8?B?WFptNUVHQmM4NitaQUZJMnJrUjZkSmltMTVJRXgzekxMRkFBRE93Ry9pTHI2?=
 =?utf-8?Q?l9rTYUzSfBOyQxs8CafNt4++vtW5gc1+jr6KbGf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f978e4-a603-4fcb-6861-08d952d5348d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 21:09:51.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vdmL6ly8Ho+cTAjhWminf5MPZGmqC2ROSG2QYm3/RVMNaN7wOrjmGq+CIug/n7WWZMsN0TlH/3vITwwyYKmbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/29/2021 16:06, Bjorn Helgaas wrote:
> On Thu, Jul 29, 2021 at 03:42:58PM -0500, Limonciello, Mario wrote:
>> On 7/29/2021 15:39, Bjorn Helgaas wrote:
>>> On Wed, Jul 21, 2021 at 10:58:58PM -0400, Alex Deucher wrote:
>>>> From: Marcin Bachry <hegel666@gmail.com>
>>>>
>>>> Renoir needs a similar delay.
>>>>
>>>> [Alex: I talked to the AMD USB hardware team and the
>>>>    AMD windows team and they are not aware of any HW
>>>>    errata or specific issues.  The HW works fine in
>>>>    windows.  I was told windows uses a rather generous
>>>>    default delay of 100ms for PCI state transitions.]
>>>>
>>>> Signed-off-by: Marcin Bachry <hegel666@gmail.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> Added stable tag and applied to pci/pm for v5.15, thanks!
>>
>> Thanks Bjorn!
>>
>> Given how small/harmless this is and 5.14 isn't cut yet, any chance this
>> could still make one of the -rcX rather than wait for 5.14.1 instead?
> 
> Done.

Thanks!

> 
> What's the rest of the story here?  Aare we working around a defect in
> these XHCI controllers?  A defect in Linux?  Obviously nobody wants to
> have to add a quirk for every new Device ID.  It's not like this
> should be hard to figure out for your hardware guys in the lab, and if
> it turns out to be a Linux problem, we should fix it so everybody
> benefits.
> 

Maybe you missed the embedded message from Alex above.  We had a 
discussion with our internal team that works with Windows on this, and 
they told us the default delay is significantly more generous on Windows.

>>>> Cc: mario.limonciello@amd.com
>>>> Cc: prike.liang@amd.com
>>>> Cc: shyam-sundar.s-k@amd.com
>>>> ---
>>>>
>>>> Bjorn,
>>>>
>>>> With the above comment in mind, would you consider this patch
>>>> or would you prefer to increase the default timeout on Linux?
>>>> 100ms seems a bit long and most devices seems to work within
>>>> that limit.  Additionally, this patch doesn't seem to be
>>>> required on all AMD platforms with the affected USB controller,
>>>> so I suspect the current timeout on Linux is probably about
>>>> right.  Increasing it seems to fix some of the marginal cases.
>>>>
>>>> Alex
>>>>
>>>>    drivers/pci/quirks.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 22b2bb1109c9..dea10d62d5b9 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -1899,6 +1899,7 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
>>>>    }
>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
>>>>    #ifdef CONFIG_X86_IO_APIC
>>>>    static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
>>>> -- 
>>>> 2.31.1
>>>>
>>

