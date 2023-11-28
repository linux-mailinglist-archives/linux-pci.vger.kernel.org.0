Return-Path: <linux-pci+bounces-205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B87FB1C2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 07:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7C2281D72
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 06:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9991119B;
	Tue, 28 Nov 2023 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qMWTv2Xr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B8EC4;
	Mon, 27 Nov 2023 22:09:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2Zu7CkUM1bXvNC4dPW4rvug2UsryxYtzisvdmnbHOHYVkaWkg+QVOkdAzBTqGvCxTk0ptestVYl20enoElrBsnphTEdxnEZRcw4MvtcvvmrunSLgpxNPj7dTedqFBbg/vCB1WveL3FH8nr+SwkAhjq0ZiROoMpk7zIhqF9N/7c4qM/vdaQBSuKestN5Dd8kBD5s+yxz3ZS+KvsimtCqjLdgzY/G5pf1J4i/w4oQfl+3Hzl5sZq4SW+IoZDRdYZNR3Nts+XVziOTPZgLsvYDQhpN3KWpfspUb0/B/DAk12CTwqF27CHMnz8AWAL3azyuHFhjGiq+Z3EK3KQCcr6/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGRmdoT49LtqyNbY0dFAPaxIfWmQnMmYouvmQN01/jo=;
 b=jfSDJq8c3bLgginldKas7Acn8dWzYJ1vu6DaBdjXgrf1ghmJtUvrz0k6VFIy1yTAGCE+bRvctiRkI6BtnrTHFGnEZPlW6kEye7n+I83zffBdBBrRiVkzGf+cmGUcvbEZR3aPhGXWqvUWx2SqZjNl6L9J6LoOeme/SnH8z2F1HF+l3U0mX1Zf4ibi6F5quOpylMR2mTC0sgZaTzwQF8A032tlQonoH+zMSFGI6peRQrr1ry63yy/JMIgp2K1lDKFma3NGGY5j/WXyV28oxdDaUVusthePFfhjasE7xMkTBbVphse2lv2k4vt6IxMteAmYhUITLuyY0tK8phhxgNnaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGRmdoT49LtqyNbY0dFAPaxIfWmQnMmYouvmQN01/jo=;
 b=qMWTv2Xrxb+5qI1ZuAhVzhd3rfZSjyC0zBLntVpYgM5yP2A9z8NhoQbEZKEh21BQQVxAAD5OPZ2AFeiUf6D6LqKdcraaB9kUxJxmgXbORLq47CEf5gdTBCIKChTitZyZxSq875KQc13kekuSPL8Wl//Otki5rsPDDk3OTzfKJEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.28; Tue, 28 Nov 2023 06:09:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 06:09:44 +0000
Message-ID: <80dbe1de-c71c-4556-817d-3f06e67f38ba@amd.com>
Date: Tue, 28 Nov 2023 00:09:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Content-Language: en-US
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
 LKML <linux-kernel@vger.kernel.org>, aros@gmx.com, bagasdotme@gmail.com,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
 <20231107121756.GA168964@workstation.local>
 <318cc8da-f8d2-4307-866e-8c302dacf094@amd.com>
 <20231108051638.GA194133@workstation.local>
 <20231128052429.GA25379@workstation.local>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231128052429.GA25379@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:806:d1::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ed50a7-62f9-4057-36b5-08dbefd89d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ddWdPkCN7G+jwNj9NDC0T8PLp0TIjnMi6IpSAwsDnfqDhjkiHPNP1qqGWX6ODEVdotS1NIxyhph4gnc6fFqQZCfTpPgEOQFsfSG0iWq50OwH0+Y+n0fKb4d8YJomN6RlkUfyzGPcPARbDEn9a2LgNgrksdofL1SQqBmA6b2onPrxSbjE7YLdtH4POQlh2nW+sOUdgGLKLvVq4s1Bbqyt/csPdeqDTCMTBdv0IJ8uke+VHtp3Aiu89+wFtku1pYg5iPvRnFXr5smpq/CKSoGO8xUrXEA9Gco7LA8MBHgNRH6qU2ZDG7ToggscCeABHzQVVWhYw2Qk4B3HNu89ZymjyiXsbmEYpusl2tof9ph9fNKkMElrponpWiF5hgn8GoEE/B++ZGVRTb/K2Cn+bMJCyZC5yYNENZINTFFwpDoXG/6z6FeEIFZa1sJx+1xAGcqCuhVblEqSHJjLqn1StxFGgk+xHrHVjvi+0Mjdz83jL9FND6K95FBPrj9OzFliu+iHGjzuzuConGArsGJQpXwByeSLK5sMpQJTmpEAT8duNHInHUrSEhI9JV8GfG7RDviYsoHLDXacYP0pGFITpnRYmQmfqMeYxoUsUYNxG4ZQHuNAc4zmirnu04Q53C6oUKC3qkyTag77pCvumR3zGpksOR6+liEbP8ZM1ANmAa8SE86aR3GurKRXFAepvSio6W/j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6666004)(31696002)(86362001)(31686004)(41300700001)(36756003)(966005)(6486002)(921008)(53546011)(478600001)(6512007)(26005)(2616005)(7416002)(5660300002)(316002)(66946007)(110136005)(66476007)(66556008)(83380400001)(38100700002)(2906002)(7116003)(44832011)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkxaNnJmUHVURUNYb0dWbzUwVGdJVzdJOWZMUmNWSWJIcVNtQjMvV3oyRjZZ?=
 =?utf-8?B?UmtHMmYvUmxQQkVFdWNSNU4yVlVqRDJSbGppTWFiT2hRd2RCSzdGQW10MnV6?=
 =?utf-8?B?bzZLVC9YdFFvQWQya3dnejkzQ0pNdjdRcTlXQ0d2Q1ZvU2hhWHJvbG85SWNX?=
 =?utf-8?B?bzljSjd1Qjh6OW9hN0VYWjgwS3ROSEUwaGtqaTJrcmRLeGswTEw5cGxraElU?=
 =?utf-8?B?WjYrNVhxczZPelZpR1pDRHZyQ1V3aS9WZ1BWRDNQTjlqV0dwZWFpMkIzQ1Z2?=
 =?utf-8?B?ZU1hNStrd2pQTUtYcElYR3RCQ2NKS3Vmb3lEZ2xndjdmOEF3QW9MdWpQMTlB?=
 =?utf-8?B?OGJ3dUpzU1FFRC9mcmNQSEJCZlp6emlWaWlURDhIWXBNT2x4cVVlMkxlYzZz?=
 =?utf-8?B?aFFkSWQ5UVo5VTBKNUpiZFFXM0h4MUlkaUZ5elpTQW8wakJGKys3VWR6aEZB?=
 =?utf-8?B?eFp0TVBDK013QzdXR1NoNWU3dGYyM04rSUpDS0xhRk9zc1lPNXJyamU0ZEc1?=
 =?utf-8?B?M05NaklId2o0eHEzWHg5K0VySXR1cDI0UDdFN2diaEdxeWVWQjNYSHlkZnFW?=
 =?utf-8?B?cVl4bU5PRHowbU9LZWlpaDJ2Vkg5S2UranV4TW9nd0E2UTRiRjhDYk9ybTdS?=
 =?utf-8?B?eUJVcStaUWoxM2RjQjVKVzZFSkp2amU3bFhMZWdJQXYwVzZia1JPdi9vZndQ?=
 =?utf-8?B?S2pFb3pJaVBPb2VuVy9aVEl2Vk1ZejdIRGxseXFDOFBaajFsYU45TFdyQy9B?=
 =?utf-8?B?OUdiVFVQVjQ1clA3ODgzL3Q3ZnpKRTExZUxqTVNrOS9yZlYwbE9mYnVDYm4y?=
 =?utf-8?B?OGRwUUtRTXdoY3gwSjIvVHVMSERpVEJMRVNyRFNsem96bmdBTWFYcnBTUVYy?=
 =?utf-8?B?Q1NlcGlaRUs2WmlwVUhBWlFxRTBYWWplaitOUDZJY05BMHg5dmk3Y21nTVp4?=
 =?utf-8?B?SlViZ1A2Z3o1VXlpSzlqaXZNcWNHQUNrTmt6aE1WR2s5RVJhdlFOc2QwZXgx?=
 =?utf-8?B?UTdCc3ZEb3RsRkJPTnY0RFpBdFdIak84cSs2WmNHSmtTQXJKWmg4L2xzUW1y?=
 =?utf-8?B?a0I0amlwQXNHQmJjdmwxSStySkJlbUtJZ25EUmhncGN3dEVpS0NSOHg2S3BL?=
 =?utf-8?B?aUpmaEtrYUxzUGhLY1oyanNaY3ViUnJKVzBaZlJmRGUyTnFrajRaRHl4V2tE?=
 =?utf-8?B?R2phOUdUWXEzMlZOWmZzSDVQbTRYWkdWc1plalVxbFpuUm9yL2lNNXVMNHBI?=
 =?utf-8?B?eEJPZU9pazJLVzlHaE91UXh1QWttdWhVMVB6RnE4aVRMdDUzQlpoaGU1ZUlo?=
 =?utf-8?B?T2tTazJXUUF3Yy94U2U4VFFnYUkrMGw4WVhTemo1VnNEVE1pcE9MTGJhd1Zz?=
 =?utf-8?B?b1dWNXJ4N0pzaWUvc2Q3bkJIaDY5eDdxemxKRXhDamtLZzBSamI5QldFZ0w1?=
 =?utf-8?B?dEYwa09tSUNiL0hIVU9vVUFjS2w5bXdNQ0hEQXNEOG85dkJHa1JnSTllcldV?=
 =?utf-8?B?WjZBcGNNNU1CYUs2V0dCT0puRU1POERMQS9PZ2tXOHV5Zm9hMHFvZi9BS3VK?=
 =?utf-8?B?bUdDN211eVlXWW53dnM3RWo0bm9wclZKc3gya3oxTGorVGdzcHlCMWxya0sw?=
 =?utf-8?B?b2J6VEE4Rks4STZDaGZ5RkZDWmtXcnpCd0NDeGRxY3RGeUp2ZElWanpuZHkw?=
 =?utf-8?B?NjlEY0IwMkhpcnRkU1JPZHZnaEhVOGN5anF6NzNTQ05mVnE3QTdzbGtBaFRL?=
 =?utf-8?B?a3VXdEVOOGdrWTZhUURKR0dZdjZTY1haQjMvS3N3Zjlhenc4VjZ3MUZzZDRo?=
 =?utf-8?B?V3FZMWtqQWppSHJydjJ5S2E4a0cxdmhDcDVzb2hZeDduYUJHK0l2WjVCS1F4?=
 =?utf-8?B?dHJ6Skx4NE5sazE3NkZZRkVEYlZneWk2OGl3Tk5VVFN0YjQ1U2xhLzBlRVQr?=
 =?utf-8?B?S05laUFkQWFGSHdkSHdvTWQ4dUx3U3lyWGdMSm9lYWVJQXoxYTZXdmVLVURP?=
 =?utf-8?B?dGRMR0N3K2d4TlEyNnpJOURScEJiRFg0dlAxV0xPK1V4eFhESDFSR3l1SWpQ?=
 =?utf-8?B?Q0hjeWkvN0dia0JadCsxYmVNaE4rQ1hickFqWkxaVkFoNzhjZFRuT3hjRy85?=
 =?utf-8?Q?vj6ewhZn3CuCR+2UGQ6+jisk0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ed50a7-62f9-4057-36b5-08dbefd89d81
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 06:09:43.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wR4EIoWlup4TL6+gtGV/WM+b9RRr3S9pU52eXOsRdy1fo9SdPu2CSHiYOYXsKOCbb8EI2jaC2zm56iZbJ0LJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012

+ Boris

Maybe he has some ideas on this issue.

On 11/27/2023 23:24, Takashi Sakamoto wrote:
> Hi Mario
> 
> Following up on our last conversation, I purchase some hardware to
> attempt to retrieve outputs from serial port. Finally, I bought another
> mother board in used market which provides serial port from Super I/O
> chip (ASUS TUF Gaming X570-Plus). However, I have retrieved no helpful
> outputs yet when encountering the system reboot.

Did you up the loglevel to 8 to make sure you'll get all kernel output 
on the serial port, not just errors?

> 
> As you mentioned, I check whether PCIe AER is enabled or not in the
> running kernel (Ubuntu 23.04 linux-image-6.2.0-37-generic). It is
> certainly enabled, however I can see nothing in the output as I noted.
> 
> I experienced extra troubles relevant to AMD Ryzen machine and the issued
> PCIe device:
> 
> * ASRock X570 Phantom Gaming 4 with AMD Ryzen 5 3600X does not detect
>    the card. We can see no corresponding entry in lspci.
> * After associating the card to vfio-pci, lspci command can reboot the
>    system even if firewire-ohci driver is not loaded. I can regenerate it
>    in both Gigabyte AX370-Gaming 5/ASUS TUF Gaming X570-plus with AMD
>    Ryzen 2400G.

Rather than lspci, is it specifically config space access from sysfs? 
Does the output from the serial port change with IOMMU enabled vs disabled?

> 
> I'm plreased to see if you have extra ideas to get helpful output from
> the system. But I guess that I should start finding some workaround to
> avoid the issued access to register instead of investigating the reboot
> mechanism, sigh...
> 
> Anyway, thanks for your help. >

Can you check FCH::PM::S5_RESET_STATUS on next boot after failure has 
occurred?  It is available at MMIO FED80300 or through indirect IO 
access at 0xC0.

If MMIO doesn't work, double check FCH::PM_ISACONTROL bit 1 (described 
on page 296) to confirm if your system enables it.

The meanings of the different bits can be found in a recent PPR:
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/55901_B1_pub_053.zip

Indirect IO is described on PDF page 294.

This will at least give us a hint what's going on in this case.

> 
> Takashi Sakamoto
> 
> On Wed, Nov 08, 2023 at 02:16:44PM +0900, Takashi Sakamoto wrote:
>> Hi Mario,
>>
>> On Tue, Nov 07, 2023 at 03:27:08PM -0600, Mario Limonciello wrote:
>>> +linux-pci / Bjorn
>>> On 11/7/2023 06:17, Takashi Sakamoto wrote:
>>>> Hi Mario,
>>>>
>>>> Thanks for the report.
>>>>
>>>> I apologize for the inconvenience you and your reporter facing, however
>>>> I can not avoid to say that the problem appears to be specific to the AMD
>>>> Ryzen machines.
>>>
>>> Unfortunately I don't have this 1394 hardware myself.  I was just looking at
>>> another completely unrelated issue on Bugzilla and noticed the report come
>>> up in my search and wanted to ensure it's on your radar already as the
>>> author as it's lingered a while.
>>
>> It is your misfortune to face this kind of machine trouble.
>>
>> In the report[1], Matthias Schrumpf and Mark Broadworth noted to use AMD
>> Ryzen 7 5800X on B550/X570 chipsets, and insert VT6307 in their PCIe bus.
>> I guess that the device attends PCI bridge (ASM1083) since VT6307 has PCI
>> interface only.
>>
>> We can see MCE error in another report[2]. Unfortunately, the reporter,
>> Ian Donnelly, have less suspiction about machine architecture, and never
>> provides hardware information. But I believe that it comes from AMD Ryzen
>> machine. I transcribe the error here:
>>
>> ```
>> [    0.860834] mce: [Hardware Error]: Machine check events logged
>> [    0.860834] microcode: CPU20: patch_level=0x0a201025
>> [    0.860835] microcode: CPU21: patch_level=0x0a201025
>> [    0.860836] microcode: CPU23: patch_level=0x0a201025
>> [    0.860836] microcode: CPU22: patch_level=0x0a201025
>> [    0.860837] mce: [Hardware Error]: CPU 17: Machine Check: 0 Bank 0: bc00080001010135
>> [    0.860845] fbcon: Taking over console
>> [    0.860847] mce: [Hardware Error]: TSC 0 ADDR fca000f0 MISC d012000000000000 IPID 1000b000000000
>> [    0.860854] mce: [Hardware Error]: PROCESSOR 2:a20f10 TIME 1696955537 SOCKET 0 APIC b microcode a201025
>> [    0.860860] microcode: CPU0: patch_level=0x0a201025
>> [    0.861676] microcode: Microcode Update Driver: v2.2.
>> ```
>>
>> Additionally, as I note in the PR[3], I observed cache-coherence failure
>> over memory dedicated for DMA transmission. The mapping is created by
>> `dmam_alloc_coherent()` and no need to have extra care such as streaming
>> API. However, the combination of ASM1083 and VT6307 provides me bogus
>> values from the memory in AMD Ryzen machine, and I can see no issue in
>> Intel machines.
>>
>> Essentially, the host system reboots when firewire-ohci module in guest
>> system probes the PCI device for 1394 OHCI hardware provided by PCI
>> pass-though[4].
>>
>>>> I've already received the similar report[1], and have been
>>>> investigating it in the last few weeks, then got the insight. Please take
>>>> a look at my short report about it in PR to Linus for 6.7-rc1:
>>>> https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
>>>>
>>>> I can confirm that I have been abe to reproduce the problem on AMD Ryzen
>>>> machine. However, it's important to note that I have not observed the
>>>> problem on the following systems:
>>>
>>> Any chance you (or anyone with the issue) has a serial output available?
>>> I think it would be really good to look at the circumstances surrounding the
>>> reboot.
>>>
>>>>
>>>> * Intel machine (Sandy Bridge and Skylake generations)
>>>> * AMD machines predating Ryzen (Sempron 145)
>>>> * Machines using different 1394 OHCI hardware from other vendors such as
>>>>     TI
>>>> * VIA VT6307 connected directly to PCI slot (i.e. without the issued
>>>>     PCIe/PCI bridge)
>>>>
>>>> Currently, I have not been able to obtain any useful debug output from
>>>> the Linux system or any hardware error reports when the system reboots.
>>>> It seems that the system reboots spontaneously. My assumption at this
>>>> point is that AMD Ryzen machines detect a specific hardware error
>>>> triggered by Ryzen machine quirk related to the combination of the Asmedia
>>>> ASM1083/1085 and VIA VT6306/6307/6308, leading to power reset.
>>>>
>>>
>>> Recent kernels have enabled PCI AER.  Could that be factoring in perhaps?
>>
>> I ordered equipments for the workflow, and waiting for shipping, since
>> my motherboard has no interface for serial output.
>>
>> (However, I predict that we can no helpful output via the interface.)
>>
>>>> I genuinely appreciate your assistance in debugging this elusive
>>>> hardware issue. If any workaround specific to AMD Ryzen machine quirk is
>>>> required in PCI driver for 1394 OHCI hardware, I'm willing to apply it.
>>>> However, it is preferable to figure out the reboot mechanism at first,
>>>> I think.
>>>
>>> Does the BIOS on these machines enable a watchdog timer?  If so, I'd suggest
>>> disabling that for a starting point.
>>   
>> For consumer use, the machine has no such function, I think. For
>> your information, this is the machine information I used:
>>
>> * Ryzen 5 2400G
>> * Gigabyte Technology Co., Ltd. AX370-Gaming 5/AX370-Gaming 5
>>      * BIOS F51h 02/09/2023
>>
>>> How about if you compile as a module and then modprobe.blacklist the module
>>> on kernel command line and load it later.  Can you trigger the fault/reboot
>>> this way?  If so, it at least rules out some conditions that happen during a
>>> race at boot.
>>
>> Nowadays FireWire software stack is optional in the most of
>> distributions. I can encounter the same issue at deferred probing enough
>> after booting up, even if the load of system is very low.
>>
>>> Looking more closely at the change, I would guess the fault is specifically
>>> in get_cycle_time().  I can see that the VIA devices do set
>>> QUIRK_CYCLE_TIMER which will cause additional reads.
>>
>> I've already tested with the driver compiled without these codes, but the
>> system reboots again.
>>
>>> Another guesses worth looking at is to see if iommu=pt or amd_iommu=off
>>> help.
>>>
>>> If either of those help it could point at being a problem with
>>> get_cycle_time() and IOMMU.  The older systems you mentioned working
>>> probably didn't enable IOMMU by default but most AMD Ryzen systems do.
>>
>> I already suspect platform IOMMU and kernel implementation, however it
>> is helpless to disable AMD SVM and IOMMU in BIOS settings. Of course, it
>> is helpless as well to provide any options to iommu in kernel command line.
>>
>> If I had any opportunity to access to AMD machines for enterprise-grade
>> usage somehow, I would have done it. However, I am a private-time
>> contributor and what I can access to is the ones for consumer use
>> without any hardware support for RAS reporting.
>>
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217993
>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=217994
>> [3] https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
>> [4] https://lore.kernel.org/lkml/20231016155657.GA7904@workstation.local/
>>
>> Thanks
>>
>> Takashi Sakamoto


