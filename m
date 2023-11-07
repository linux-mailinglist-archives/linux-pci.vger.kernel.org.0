Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5A7E4AA2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 22:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjKGV1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 16:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjKGV1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 16:27:16 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80812F;
        Tue,  7 Nov 2023 13:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpPS/+DpXAy/hkCgMAO5ir9DqHsZBzzPLVTy20cquqBgeIF38OcRlkbrYQr1sivJu2ptRyplrgn6VikGI9Q+ljGrbjqzPkEB32palF4H0RzsIRnAeUkK1LPyPQ3eL3VlFFXuMkDzK+DPdEO5pNV/KfVuPTTXQWEk1SNHDGDIA0N5xsJw61m0T5Yx82Q3oGzXSmJf+0+Oeld8bovKVx2qS8HQk8DQFmM93G2Ldwm+kqhqluaVChsgW849YnJ1xc3v9gx4IAGhgWWe5uJlTu11GR3RlkBTudXrtBksQQlWIawEaK48Ip+5GeFZoB/T35jwHtvXT5FYPcIcvWYzZ7js9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2v+2rOgCL816xkJDGmvPhesd35DOfQPQMbe92czL3s=;
 b=QHE3VI87bF2U48615KXwW30n2ibsjZeGSeN02zABD0E3dsFXVBonQXBbxELbcmBtlNnJytM30j5FKzdPA7nu1LRYyGl3XkTMLWqA+t5IYWchj0KqeEp8Ws+M2Hu27WBkaZ9iLcVU9sUTko+JihFqpcUFfWxOCnDTQ2czNmtoPj526KaYp7Y2Pa3sfpRuFgaYDBTTAnjHpi9OG4SfJMssofGH43VXZ235L9s9UzhteNmsXdaK7I1Qwl49wbNZTTToOLge01hHn69UUDH2kuy7Mq77k1bqtr+PLgK08bn21jUyy6y4eYFPrMDrJGbFFjCSgDM7w3cjinu1YWJCZsnsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2v+2rOgCL816xkJDGmvPhesd35DOfQPQMbe92czL3s=;
 b=UejT+dQtatPpvMSvz6Etgbjl4zla5YnfcX/+L9ENP1aRFdHWvn6GI/0x+XsM4HgLELOXN8VTFzVCDPlr4OrINen+OXpQLIXHVeWGg/3A9KLJBFEKGja6eMkoa/pHWnQHvviZbrN5UeBHfXDueIOvDgYwkP4y9v/8wH/Qe+tJenA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:27:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 21:27:11 +0000
Message-ID: <318cc8da-f8d2-4307-866e-8c302dacf094@amd.com>
Date:   Tue, 7 Nov 2023 15:27:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Content-Language: en-US
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
        LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
        bagasdotme@gmail.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
 <20231107121756.GA168964@workstation.local>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231107121756.GA168964@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:802:20::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8a2c1e-5ff0-4c99-729d-08dbdfd84d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXgj2iMXhYb07Fc0VDwSol9XqQSPHyqtz5L2PV57nmJCV3dCVpirqGA1q4W7GMzyrkbjvqe62m993wjQEK8PbQ2bEeqr8lVWyah6KSXyYNBuvfqvoSPooCsdZ7DU1je1QYM19sRDY0H8oSmus4w70GQ4y10fgWyvLBNcC3jKeclV4rAeZbY5Nnqt7nmt1WogT9au1FXHLc/v79iDcpOaStt3FmCc34dj48ew6aSVkZTpdaTT+jfHo0XROU9+tdsESHyTYCVFN5/3azu6p0Eki/mICGFkBa4oxc0Ng/4D9cznTYHxBM6ke7QD+EU6TlwRH5fi20rIEDml53wq3D6TRpxg+A8owyKFu/QzNT0wrRaIqGd0qrLTN8giXFd8n6zTLIn32TAPRIaO9xKSbXeGPaOQBvgR+s7RH/m0bUODDtblPAD2jKwOeEouR1RGw4qlQtu+JqYLKovh2P9MH5WcIzWaBd83e4TdXnZEbozFfthM6DquhVRnU9uY5ul3UnQtn6+8FQFtIBhhDFoKbFqk1RJ0+OC1junaFz/tJN4wpS+6oVSzCSVP4JV/shDo7lKgG27B37jyUf6PBtWlUrae9gxGoxaSk1cqDuhMoM5MBq5zuh1IieyRSD5VIunAmrpx5rWfbr1duR12Kqov1+Hi8x1bRl3B17Bfl7enUoQ7r5QGEg16bwsQ/uvesP98bWHC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(53546011)(41300700001)(26005)(6512007)(2616005)(6666004)(6506007)(38100700002)(8936002)(36756003)(86362001)(31696002)(83380400001)(2906002)(7116003)(966005)(6486002)(5660300002)(44832011)(8676002)(66476007)(66556008)(66946007)(316002)(478600001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3Q1YnV5YzRyV3p3NnNmMVJmTzJmaVVyMjlyWWtPNVpvZ0VYcFdQM0Vnak5N?=
 =?utf-8?B?NjFwdVNGZ2d0YktzendHaVFyT2R3LzhxTU1CL0ZUaVBJaTE1ejhSRzBST1ds?=
 =?utf-8?B?TGtXcFhFSUhPcGVMemFKYTlJYVlXTTI4L2ozYWlzRUNHOFJ5V3hYYjBrR053?=
 =?utf-8?B?TGgyeHNUU1I0WGhuSTlBT1BWQmh2bDgyV0NjMWVjTzhwK2JJRHdGeFlGRUV4?=
 =?utf-8?B?Uy9vMUNtem1id1FNUnpoSDErRTkrL1FQN3NDZll5MzhBZ1ovdXdnL2ZBNXFr?=
 =?utf-8?B?b1k4blc5TkxiSlZvREJmOXBwUFdCcnRJd2JHazdSN3k5OUQrQi83Y2xOSmd1?=
 =?utf-8?B?eXNvekthVFd0NyszNDhPd05Oa3FDUEJ1YzJ4ajV3SWxFdkF1UnM0SzVPNVRT?=
 =?utf-8?B?N2l1anU3S3U5QVRKWEVUamc1VEJJTEU1ME1ZcW9WY0pOanc2dXNwZm9Nck9v?=
 =?utf-8?B?OVhZNW5DU0w3M0VBdFJWQmJTU2djUHk3alBUSnJQa2tRbDErTlArYXdQYXIr?=
 =?utf-8?B?QmVvOUkyZ3ozaUlsSHkwYjJRc1U0TzNoRGFodFUxRy9zMXVxZ3gvdFU0NTNp?=
 =?utf-8?B?eHhVbncxVVpmL3JqVE52cmJ3K3Z4MnR1UU4xR0NmTXMwZDB5R01lM2xGZ0pP?=
 =?utf-8?B?ekRXalFJeFh6eWdLd1NEWHhtS3F4VzltYVNQb1R3bDUwUXN0ZFR2Tmc4WWwv?=
 =?utf-8?B?V2ZyRzFJY01DV2c4Sjh2QkRZeVNVekkwbnJQZ2V6L1hoT1dURDVvdWlhSjNL?=
 =?utf-8?B?VjVReDF5QVVyVDRMM2JSVTEzS2RQWU5lS2NGT2ZKaGNUV1RzZE5yQVpTdXJZ?=
 =?utf-8?B?Z2VNQWw1R1dYRnhPcm1CdlY5Nnc2WHdmYlNJMGxPdDlpSmJRWVBIZEw1Z0lS?=
 =?utf-8?B?Mi80c0huTHhTQmNVVUszcjhESFdxcDlWb2tLQjVIMTJwK1A1QzJ2WE5ObHhX?=
 =?utf-8?B?d1g3UGppSnJTck13dU0waUNPUkVYV29CRVpRdmJrb2wxZFhlR2M0Vnlmdnpm?=
 =?utf-8?B?K2NUNVRJQW5tOHRaaVFaSHIrcEtnaStNK3hQcFZJL0QyRlY5Yk5FT1ZuVmxi?=
 =?utf-8?B?YlNueVNOZTFNL3locFJRd2tBUTdtcjYzZElnNHd2eHpHWUVMQUtXemJNVTRD?=
 =?utf-8?B?dE15TTM0aFpDaEp1bm9oOUlCaDBieURMbEhhTTBWamIxb3JqSGo5NzZnRnpG?=
 =?utf-8?B?Zk0yREhMNTdDYlJDdzlyVE94OXpuMm5hU2ZVeVI4d2N1RVBJMldSZk5STWZ6?=
 =?utf-8?B?ajlIVzFkTnl4QldlMUdrUGFmK083ZnN0N091OGpIOHF1dlVTNVFydEVOZDlk?=
 =?utf-8?B?Vkdnc2RTd0ZrOU1tOGlsdFRLNUlGalFiMXJjd1ptbUlSbWlWTnlNSzNvM1VC?=
 =?utf-8?B?aTJteVp6bmN3aUNMODBMMmJCdHRGOFpLcjBHVERJY3g5R2xSMDVIVnp3elpU?=
 =?utf-8?B?VDlnem1aZml1VVEwSERsSDRjaWxBVlpPZ3RKOUpVRytQTDYxRE43NlZxZkJL?=
 =?utf-8?B?S1RQNERtRkp5RnpVeDJQSW1TZ1oybHV3TDJxcGZreEpySTdKYzZhNmxiUnkr?=
 =?utf-8?B?NkVOblRRR0J4elBxN0hPcnVmVlNvZTNwTkFjbC9sOTFKN2V5akR0QTlGVjNw?=
 =?utf-8?B?UEhKVmJzd0REdEFzVld4TXU3QVR4blorK0x4UUdMR3hhcTV3U2VFa3k3SzRC?=
 =?utf-8?B?MVkwdDNTRFg2NGNWSHBNbFRBbDVoK3lQOHFPTkpBcmVDbVUrN3RUL1hDVFgr?=
 =?utf-8?B?aG82WlRMb0tKK0k1T3BiaGZzMmxLbE9uWnA0Z0FHUEp6ellZRVdWTnh1WXRt?=
 =?utf-8?B?Y0lSai9RQkFFTllobTZla1dFbUVuSnpyWnZKNkQyakdtVWJDcVpnYnNEUStv?=
 =?utf-8?B?aUZmUjV4MloxUFVXbUJMUkFKcU1nNVJCQ2w0R3FXT3lGNnBJQ2kzakNzWlpR?=
 =?utf-8?B?a2lRZ0tmVVAzR0pkOUtqTFMzRUg5L2VzcitPbFZ2V3BZbzVGYW9Jbk53bkRE?=
 =?utf-8?B?cEVYMk9heVRXYW1MVjdzVTNOWDUxRld6djNpSzdoOVpHbUhiMkpvNVc1V096?=
 =?utf-8?B?TUUxZDJYWTRERHllT3p5djZyakR5ZlBENk9BMWV3bzdDOFoxbnJ6UWludlZw?=
 =?utf-8?Q?e4d3qH7zTOSXOuqgZ6AIehU5f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8a2c1e-5ff0-4c99-729d-08dbdfd84d8a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:27:11.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVNqCbs3Ez8z6Q5a6cn5Vj2denfPK3rZuKXr0QCUsnQhnq2z/s3pVSPeqAm7kor7sn7i6ODjWtlHpYJgg36fXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+linux-pci / Bjorn
On 11/7/2023 06:17, Takashi Sakamoto wrote:
> Hi Mario,
> 
> Thanks for the report.
> 
> I apologize for the inconvenience you and your reporter facing, however
> I can not avoid to say that the problem appears to be specific to the AMD
> Ryzen machines.

Unfortunately I don't have this 1394 hardware myself.  I was just 
looking at another completely unrelated issue on Bugzilla and noticed 
the report come up in my search and wanted to ensure it's on your radar 
already as the author as it's lingered a while.

> 
> I've already received the similar report[1], and have been
> investigating it in the last few weeks, then got the insight. Please take
> a look at my short report about it in PR to Linus for 6.7-rc1:
> https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
> 
> I can confirm that I have been abe to reproduce the problem on AMD Ryzen
> machine. However, it's important to note that I have not observed the
> problem on the following systems:

Any chance you (or anyone with the issue) has a serial output available?
I think it would be really good to look at the circumstances surrounding 
the reboot.

> 
> * Intel machine (Sandy Bridge and Skylake generations)
> * AMD machines predating Ryzen (Sempron 145)
> * Machines using different 1394 OHCI hardware from other vendors such as
>    TI
> * VIA VT6307 connected directly to PCI slot (i.e. without the issued
>    PCIe/PCI bridge)
> 
> Currently, I have not been able to obtain any useful debug output from
> the Linux system or any hardware error reports when the system reboots.
> It seems that the system reboots spontaneously. My assumption at this
> point is that AMD Ryzen machines detect a specific hardware error
> triggered by Ryzen machine quirk related to the combination of the Asmedia
> ASM1083/1085 and VIA VT6306/6307/6308, leading to power reset.
> 

Recent kernels have enabled PCI AER.  Could that be factoring in perhaps?

> I genuinely appreciate your assistance in debugging this elusive
> hardware issue. If any workaround specific to AMD Ryzen machine quirk is
> required in PCI driver for 1394 OHCI hardware, I'm willing to apply it.
> However, it is preferable to figure out the reboot mechanism at first,
> I think.

Does the BIOS on these machines enable a watchdog timer?  If so, I'd 
suggest disabling that for a starting point.

How about if you compile as a module and then modprobe.blacklist the 
module on kernel command line and load it later.  Can you trigger the 
fault/reboot this way?  If so, it at least rules out some conditions 
that happen during a race at boot.

Looking more closely at the change, I would guess the fault is 
specifically in get_cycle_time().  I can see that the VIA devices do set
QUIRK_CYCLE_TIMER which will cause additional reads.

Another guesses worth looking at is to see if iommu=pt or amd_iommu=off 
help.

If either of those help it could point at being a problem with 
get_cycle_time() and IOMMU.  The older systems you mentioned working 
probably didn't enable IOMMU by default but most AMD Ryzen systems do.

> 
> On Mon, Nov 06, 2023 at 02:14:39PM -0600, Mario Limonciello wrote:
>> Hi,
>>
>> I recently came across a kernel bugzilla that bisected a boot problem [1]
>> introduced in kernel 6.5 to this change.
>>
>> commit dcadfd7f7c74ef9ee415e072a19bdf6c085159eb (HEAD -> dcadfd7f7c7)
>> Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> Date:   Tue May 30 08:12:40 2023 +0900
>>
>>      firewire: core: use union for callback of transaction completion
>>
>> Removing the firewire card from the system fixes it for both reporters
>> (CC'ed)
>>
>> As the author of this issue can you please take a look at it?
>>
>> Thanks,
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217993
> 
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1215436
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=217994
> 
> Thanks
> 
> Takashi Sakamoto

