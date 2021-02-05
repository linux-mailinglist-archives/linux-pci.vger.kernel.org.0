Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18553113B8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 22:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBEVlm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 16:41:42 -0500
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:60832
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229752AbhBEVlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 16:41:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve68sBPuuplL81OY0cAEfCMAGb8BXXaAwWbwhu+NoLk+JPZc2XTyDpYjb6EdfjancVQ62o/7w0MuatDqb06VDYZIEO8xMTRFnapuedXlnm+wnulpSN93G3GxJhDax5JOLg2jAWk1k5GUgB6FcfAz3XWpSPBJzOdzcZE77QREorx9QXRVd+CsCPWBxDREhp/Hez8w4lCLdA7QAS5S4p7iyTxbir6P8QML9oUmc3Iw37+IiHAdlO+rrcWsjsZ2CLgDiTzN2Ot5FrXPCbe5wi/E22KR27VAQXjOHxMaC/4/JCx1R3wZE7Bl4z961zp4o/IwUGgJBppJFv+Vj/8QyCZHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpkKiXUOVWsRo6H8YwZLgmANhTVb1PU7SX3fD/5Sr64=;
 b=BbuM1e3CAhHz+47H6hyBqhhOPCzDJS8Iso7MRQIygdDnFWtUrKflMQBACjMTsTglnvo6z/q7MnOCmSnjkjQEWOZP2ZZCEInGTh0X0suOVEhAQlf+Zs4iCS3ZYlunB8lHPAVME1uPcYXEIuA1b/oGE2pOxPLE2Q1ORdhhhS93h4r8T4UXzI09oSeaN7EJTqU1Q7KLbISC14UOzTwZxDuivFoLjILANHmDn5mhuWXWRb3FqiDpVzphwVn33r8N4TJPit95MEgnm++s7ksEoOkmh0XJw4B/1HIl7mP0Vp3Sk9a/9kzK0h0STx2hMHcq0AjqGhXK0KJB5ByYg/Iby6IxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpkKiXUOVWsRo6H8YwZLgmANhTVb1PU7SX3fD/5Sr64=;
 b=i/8qnScUQeurHWDpWK4Ji40P0SXJSVHirpTPZ4cKvqEmZxO0MYHWF2cXY/DTHGdZkjExgGS6mSVu1QOySGQFubfoJVINypNincHBytqbzAannpZjnllQtBvqJ0rHQ9e+jnbRLK7GcDeIcns5E8DIL8FNPUz+4oMtZvDu4WPAQkc=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Fri, 5 Feb
 2021 21:40:09 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f%5]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 21:40:09 +0000
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20210205194541.GA191443@bjorn-Precision-5520>
 <c216efcc-6c81-8a7e-a823-1ddb62ebddb7@amd.com>
 <20210205213534.GA2657326@dhcp-10-100-145-180.wdc.com>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <4614701c-562d-cf94-d0eb-8f29a7964107@amd.com>
Date:   Fri, 5 Feb 2021 16:40:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210205213534.GA2657326@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2607:fea8:3edf:49b0:74f0:8064:c429:544e]
X-ClientProxiedBy: YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::24) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:74f0:8064:c429:544e] (2607:fea8:3edf:49b0:74f0:8064:c429:544e) by YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 21:40:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88f9f820-c599-4c62-9d6f-08d8ca1e9c21
X-MS-TrafficTypeDiagnostic: SN6PR12MB2702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27021BC4D904242B2BBB89E7EAB29@SN6PR12MB2702.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tY5JEUadGLnaRpCDvzrs0zPuDN2txmNOHoh53hRwnd0fppxaigddkxOMlwj+95jjYOavJ5cHisfkp3dqPvBY0rCYxtLziUIdx44OguY4cUdlfMoRxSR8CUd6AWrp3b3nRkXZGgxi73O+4222mczgnWuRsF3M5xmmE9H5MKT5nxJo/M5/sxNOwQMz0WrMlEzLQ0ekA1/abaB73eTe7is3bP9UotnlZjdvwhEiQ3ssRU9W5EWA44Dd06w5dd87CKYPI99hTcqDqtBcZthrltomiVaM8aiex+VWh67RjD/8OfeYmafhWf+E3qCGDGxQDoa+/2bs2OnuAicPaDOJ+gqPJVV3E7M+gbKdK6zzdkOgv44nQJvmkpdl4+PKIVG1ybHf5dpXx2oSwzVEOYXVEzExf5dgfiPfSwhWPaYNH5rL5/T6ReSqyMVC2TRY45p/0e+fsOSG0Gz4v6Ls0t37Ez0DccBEgFTt90MTnim0MrkmFyTIddDLfRa/1MxTeoGF1fEBUm/s5QSy78wALds9vdPrhNZYIZgXyzzpVS7o1wL3I+zL4KuLkAnx+vtTozvy6ZxaC07y2UMFtn5I+2goFgCmoFIX+vlbT/vSur5zPyC0IH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(6486002)(83380400001)(5660300002)(8676002)(36756003)(6916009)(52116002)(16526019)(186003)(66476007)(8936002)(31686004)(53546011)(316002)(54906003)(2906002)(478600001)(31696002)(86362001)(66556008)(4326008)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K2FWbGhicWZEc29Zd0pVMnBEUGpDcEd6UDIxaTNDNjBLQUplK3lwQUNNRUtC?=
 =?utf-8?B?UmhGYnZGQXp6RzlJZ2ZHME5XSUo0b3E5SjY3YlVYSW1vT0hCT0poWVo1SUlG?=
 =?utf-8?B?enphbkV0cGZVS3E0REt3TFZFMFNVSUZENnN5T2FXNzduUDl5Z2h0VExqZG1t?=
 =?utf-8?B?Y3pwQVl4Mkl4UEErK0UvOXhkVUhBejFCRWFZUlRnUjBjaWRQMXlKNVNCaDNK?=
 =?utf-8?B?eVhoWktTUkhQYnFMOXp3TGxQMlRoLzJGWjRaK1hXTkUzeUM3N1ljUVdwU1VV?=
 =?utf-8?B?Q1JLbE9aMGNZVThxRzBmWGhZMkJ5RWwraFpTSldFVUZHblY5aXlabHczOWpi?=
 =?utf-8?B?OWNSelNVNTRSWSt2ZHpmYmRmc3FFODNya3hNWFpSY2E2ZUM3a1V3aElmRXlm?=
 =?utf-8?B?NDN3cUFJalBVZTA2REJ2dHJCM010dzRaZ1BSajJuRHdZcUg5U05wRUllN1lN?=
 =?utf-8?B?MVRYMkhSZnBlRHY2YkNEZ1FZcWZFc2xkSE5wa1FacmRodWZKc082eDdxL1lw?=
 =?utf-8?B?eldlY1l5RFR6RHZWd2IwNjlMbnA2aDN2NFU0YzU4UlU1cG9IMXhoWmQ2K3pN?=
 =?utf-8?B?REw1VUZFbjFlZjJVcDJaK1ZGaW1PWUxsaU1LdWdtRjBMNVRweFM4Wi90QzRH?=
 =?utf-8?B?ZncwbnFUaXBnbVlNQSsvRkthUGN1NEF6Y0JFYmR4RWlVdlVGOFNsRm82aTJ3?=
 =?utf-8?B?MWRja281UGtORzNIcGczSVNpMHhSTUFTRjRsd1Y5K1g4RnJ6NWcwMzZBT2Rz?=
 =?utf-8?B?WmlFaXJ2QnQ5WCttVS9zZXM0OTNLRkExRzNlWHUxSW9pOUJHVENUeWlKMk9u?=
 =?utf-8?B?SjV2OWhVMVNSNEV1V3AwU2lYbmVWTlpxLzBGQmVUeENnVzlNMkdweXNYc3Rp?=
 =?utf-8?B?Q3ZaUFArUWVJbFJuWnFOQ1RuNm1ia0U4bWdPZFE0R05KUDRVbWdXbE0vL25Y?=
 =?utf-8?B?Rkg1QzhpQUVCUURwaGgvRWs0L2hXMXRhbHlHeDhCUWJVcEYydkgrNkwvRXRX?=
 =?utf-8?B?M1F2dmhGOHJzNEd0SU5oSWthSlJOemRzSHNhNFFvK04ycGI2TTRBcmdkSEVR?=
 =?utf-8?B?UTA3OXRlZXVuQUNHT21UNS9tY3lXWStBZEY2bEpoSUxTYndJdFQ1TWZPL09t?=
 =?utf-8?B?NHoxQUQvTmkxL1M5TnRQVjMwMFNPSTF0Q0d5M1ZyTmx0bjZaK1k1bEJ1aEhr?=
 =?utf-8?B?KzlrbkcveStJMHQ3azFaSXh5TEJmMy9JOWJ4TWl6Qk43VnBWVGEvMFBlcHFt?=
 =?utf-8?B?UThndzdtaGQ4OVdiaEttaHMydzhHdkVwTERLM0lKM041SWlOSitYQ3BieUxZ?=
 =?utf-8?B?TGltd2FRc1k4MndHcmRENVJxVUVQNXExVktaWVRrUVNJL1J6emNFVmtPY1Vx?=
 =?utf-8?B?UjhpTnBBc2ZUdVA2UW10M2RSTzhqTmd6WmE5ckxWSXcwZUkxeTRNcm0wc0JE?=
 =?utf-8?B?azhwQ3M2SW5BMVNBeGJqMUpOQWtNRlZaU0s2NnQ5Y3JubmJ3bitFNnYwTEpm?=
 =?utf-8?B?bDduTlFxK3B0Nk5SWFlPQzRoK2tVV2JIUVA0VHdvV2t3cVJhVGVSdGpreXQx?=
 =?utf-8?B?Z0ptRjlwb2lnYS9oRktSemxOK1lZVW1tMmxtTHBVb2J4NXMxaUdqU0pFaGdY?=
 =?utf-8?B?RkF5MzlhWVF6MnpkUEF5QWk0VDgwd0VFcnUxWUdlbVNHRnBzYmZhbWVMK1Bu?=
 =?utf-8?B?b0JZQnZmODRjU3hvSHdYa1V2K0lkcTZCZVVVQ0NtcVJFVFIvTjhWWVpsVkZM?=
 =?utf-8?B?eDdCdTNmeTRsL1VmdW9SYURPUWRyV0ZqRHJZTklLVWo3Tmo0NzFkcDN0UnFP?=
 =?utf-8?B?MUwyZ3o2NEVSNjlEejRIcGR5bEljS01RS1RiaXZvaFVHU0NFcDNKdjJLdDlV?=
 =?utf-8?B?TVVUNFhiajdhRVI3SDF1d2hxc05rcXhocGxVNFVwQWxDT1E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f9f820-c599-4c62-9d6f-08d8ca1e9c21
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 21:40:09.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTlrm0rCY6KgyJkYOT3+88wbYq4TA6NNYRrZLzQPt1sOOmHJWpTTNHi4AhjsqU51GK6q8YIfDIMgFb+ZtsO16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2702
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/5/21 4:35 PM, Keith Busch wrote:
> On Fri, Feb 05, 2021 at 03:42:01PM -0500, Andrey Grodzovsky wrote:
>> On 2/5/21 2:45 PM, Bjorn Helgaas wrote:
>>> On Fri, Feb 05, 2021 at 11:08:45AM -0500, Andrey Grodzovsky wrote:
>>>>
>>>> For user mappings, including MMIO mappings, we have a reliable
>>>> approach where we invalidate device address space mappings for all
>>>> user on first sign of device disconnect and then on all subsequent
>>>> page faults from the users accessing those ranges we insert dummy
>>>> zero page into their respective page tables. It's actually the
>>>> kernel driver, where no page faulting can be used such as for user
>>>> space, I have issues on how to protect from keep accessing those
>>>> ranges which already are released by PCI subsystem and hence can be
>>>> allocated to another hot plugging device.
>>>
>>> That doesn't sound reliable to me, but maybe I don't understand what
>>> you mean by the "first sign of device disconnect."
>>
>> See functions drm_dev_enter, drm_dev_exit and drm_dev_unplug in drm_derv.c
>>
>>> At least from a PCI
>>> perspective, the first sign of a surprise hot unplug is likely to be
>>> an MMIO read that returns ~0.
>>
>> We set drm_dev_unplug in amdgpu_pci_remove and base all later checks
>> with drm_dev_enter/drm_dev_exit on this
> 
> It sounds like you are talking about an orderly notified unplug rather
> than a surprise hot unplug. If it's a surprise, the code doesn't get to
> fence off future MMIO access until well after the address range is
> already unreachable.

I am referring to surprise unplug on which we get notification from the PCI
subsystem which ends up calling our pci_driver.remove callback. I understand
there is a window of time within we are not yet notified but all our MMIO 
accesses will already fail because the device is physically gone at that point
already.

Andrey

> 
