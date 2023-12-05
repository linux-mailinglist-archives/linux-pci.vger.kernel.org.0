Return-Path: <linux-pci+bounces-528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EEC805F08
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC12281F6D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 20:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725D692A1;
	Tue,  5 Dec 2023 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0nnzSHB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D161AA;
	Tue,  5 Dec 2023 12:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9XQ7rXhzdkQtqAgyK+Yu1q9l2vcQG3GvXH+A95mcT0hkn0Y7I32igEce03lVwf1X+OzgfUCU/n6to29w8Wqe0/F9FW5HMmk7HTxVzwOx0pOCptHbvKyKKa/JH4NeAkmak4j45qKtihPvIRlS1qAYV5cSVsHSFW0nEzFvPx1LOwI/Kkifk6A/WcTpg76Vo7CuW6lbvgu9dFzFSd/dSwMmIDoU8iwby+CgCdkcaEjSVRcxRojoHjhJEpYUGJqCZKUZro4QGb0vTlBhSt705QTiEwiFtm5itjxVjyjhrr2B83h6Nf3IowdOo7w0pHMxFgl57IXywCKpl141NNxRcqDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSBroqZ068ss9xs6oXcGFIrf/F2O4WT4a+dd7sax7go=;
 b=g7wWk5jwzHmGGa8F7o8O6dvRfKaQWFFZdS/DL0l9HXelT9Yusj9UjisyrhoE7AejQMW7GyTk3VgywGOBWbZIN7hDPrQOBfvTjoWna3KU/ZQ0CRuCKoqmFv8t1bV7yA5A+34m5ZQXQkjaRX3ZljCThzVWx5gh0BezCbSfrhlgqQzg3CRdXePvb1eA3gAX/NMWiPv3lSJ2Ae3q+xCR0J5s06oMixC2Z++4jGrPePPybXxAi0XGk1R+IteKBFc59bbgNY9vD6lR4DB2ZarjOsux12JEf0Re1fYyZaY8aymw65fsc+6hPYTP2RbmJ0PWkHWBcQ7Wj4zCLz/IT12o3HH10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSBroqZ068ss9xs6oXcGFIrf/F2O4WT4a+dd7sax7go=;
 b=f0nnzSHB+ceLdcRRMEZxhEoJDMLdJyPDYacbfi7N/NRX35ENCaxUtG3IdGEEELC/ajQH2H3c/qmJCkXW+IiLMTL6o53OMv3HeioIIv1UIXYCTHlT0Hfa4N8TOUPU+3k7vtu3ZrWlPhhhYMc1gaps4gJX8+PimWDlZKxBodfQu30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 20:04:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 20:04:21 +0000
Message-ID: <bbf24b56-cc54-4993-b048-eca5b9fd30ca@amd.com>
Date: Tue, 5 Dec 2023 14:04:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Content-Language: en-US
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, a.mark.broadworth@gmail.com,
 matthias.schrumpf@freenet.de, LKML <linux-kernel@vger.kernel.org>,
 aros@gmx.com, bagasdotme@gmail.com,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
 <20231107121756.GA168964@workstation.local>
 <318cc8da-f8d2-4307-866e-8c302dacf094@amd.com>
 <20231108051638.GA194133@workstation.local>
 <20231128052429.GA25379@workstation.local>
 <80dbe1de-c71c-4556-817d-3f06e67f38ba@amd.com>
 <20231203122935.GA5986@workstation.local>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231203122935.GA5986@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:5:337::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: cfffad34-d612-47a5-0625-08dbf5cd5f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HoF/dxcEhXrI3taYROMZvuU74mBUc1H106n8qgFcRc2u72bgeApmVcnn72X4OzOr/fYVnDK1Hp90k9gsIXtzbicnjSX8mfNlK361GPk4Iyg+/RbfifAwRmv/bz0oTG1xnoklhO7OvJPg1tbHG1B/jKmiLdlJJnTnwXJG1iY6/xGc7SnazEGcVEtAvCVmSvRJOxqLWRUmDAbBo3sGNjLQ1cl3shhFtrLasijFItM9j+70ZBvK997Liz1XA4xP2/LKBClcPqVnrSuQ4/+qtlOveIYUMC6O8mmSPegDpjLveHedoOwttUaw1RYUvk2cFWvMZJD9CPNy8Kn1x9/2lWax1p0UPzD6/W0r/0U786pU3OWBLM9mYLGxiB6YzHGsImtwnl8PzNqyT+VKTyVDaE60JEo7IIFr8srzcujdEsHTc4+M3aT3pYovJRRjiK46/7dEDO1Ycvk5FWBj11rsV3eeWcXgyngBB6M4w0cJj+LkoaO3coFJTfJe5vLFIZaKjWpj0lC29bOD3tF+b9tnfRY1++FaDftMulSyDyjvv0BmkgYntUkhXoN5hhGAHqEiZw50wgxqPR+1Bg+z9oh4cPmTmZxddJ8clZ/Vyvz6ix9frAw9WqwIa6sjWYnjjXSlJKBZe3Ep9sMhrww31IhX3nYAKIbEOez55CpPYHFFXL/DbQuo7Xk1UygUY9ViyBQcHJIiaa+/zEInOnTQI92wb5lVdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7116003)(53546011)(2616005)(6512007)(41300700001)(36756003)(86362001)(44832011)(83380400001)(26005)(31696002)(966005)(6486002)(316002)(110136005)(66556008)(66476007)(66946007)(8676002)(8936002)(6506007)(478600001)(38100700002)(31686004)(2906002)(5660300002)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0lsYmpnenViU0s3MkdFcEN3a2t5Q29jcFA5UWJFUnUxNTZHazBLTUp4Umh6?=
 =?utf-8?B?MWVBYmdUZXN0eWYwZnNrQWQ2ejF0bEFPOVRGMm1BdWxDM24vdTJ3SG5aYmE5?=
 =?utf-8?B?bXp5WjhaNlJBL2txeGNDRlNIdHBYODJESGZYWnY4UUNSYmpNN1kweWc1c29q?=
 =?utf-8?B?SFVPa3BDWkd4aXh2Yy9VSVNxWjBldjYwUVhJdVVQU0gwTmxqald6VDc0ZHB3?=
 =?utf-8?B?cW1ZL0Uxc1JKZGlzcllYWFNrZC9KMjc4R1ZkVGVlbWRVc3BDYU5WUFZPK1J2?=
 =?utf-8?B?UndwOGF3aFlHOVoyR2F5Yi9wem9pVUhLc0syanJjTkp1S2J3ekgyY1BNWEwz?=
 =?utf-8?B?bElWK2xxZ2w5b3BMeXE5Vmovcm5HZUJXN0MwdHpFNFZOMzROM2ZQM1RvRGEz?=
 =?utf-8?B?eUdXUlowYWI0K2FCeFgvZi9WbEFoYTYrTG5GMHBtSldvWHdOcHV2SVZQREUy?=
 =?utf-8?B?Sk1WVTc1ZmUzWFM3UXYyRFBVUHF6bVIxOTlJcjM5THVsM2JTNUdjaGVSbW9w?=
 =?utf-8?B?cVlFMTZCU1pWZmZ2OXVpc25SWGQwb3BYb0VmZ051eGU3S1lQYk1za1l3dkVp?=
 =?utf-8?B?a0dHT0l2NGlIaXNybkN2MUJtWkJlTTdzWVBNVyt2YzJsK2FwUTR2ZHA4ejVB?=
 =?utf-8?B?akhHcDJlT013SzBMUEFLM0pWcTRvWldqcDJNZ1FpT1ZGem5VUGRHSGYrekZE?=
 =?utf-8?B?RlUwdloxZ2JuQ1RhYmVrZUJDdkVwTXI4UnZ4U0tmVnNNeGthOUlLYks3OTBv?=
 =?utf-8?B?ci9XemRmK01EMTVRYmpEcEFpWDAxRTFKajM2NzMxL3FGbUMzVW1tUGxzam9U?=
 =?utf-8?B?Vy8zbzM2ekZZd3g0Vk9KbHlHR3JSZzk0Vjh1UHlCS3c1c21xV290MERTQ2xP?=
 =?utf-8?B?ZXAzNVRIL3hJbko3MFBWdDVpbVR3eFZITHlPTUtlazVJMEplOHE0YXd6ck93?=
 =?utf-8?B?dEFsRnFMMDMyMEVnWXViZGExK3IyTVNxWGd0OUF5ZzVxUXZha2xkOW9DRkU0?=
 =?utf-8?B?enQzOWV1QWhpbUFnalZ0NTBHMS9OYkpWcFFmbi81SE5vMjZqcTdteFlkNFVz?=
 =?utf-8?B?bkVWNnpodGZNdjhLNk1KZEJyaXRNS2crZ1dodzg4K3NqMFVidEU4Yy9VOWFR?=
 =?utf-8?B?WlhpQVN1cjZhV0h6U29UdkVGKzR0VTFIcUdJejFLM1pmZEtxVW5RLzBraDdG?=
 =?utf-8?B?ZEIyVmFyN25ySWJuV05GZ3ZjRFZWQjhPaE1raklhbFNHZm9odGIyaFJJRHhQ?=
 =?utf-8?B?N0ZWYnA5cHZjS25IUXJad1kwbXVGc0RBTHgzSHdDWWZTRHFEb3J3SDFIRUJD?=
 =?utf-8?B?b09CWHFNLytHdW9zR0JMeGlEUVF0bklPeUFXbERJZXovTHhuc01VY3pWV3hI?=
 =?utf-8?B?SUlKZ0Q3Y0VhSnJXSmtXa0tJUjl6emFWbzNxWWdyYUlUT1c1MUtmV0xoa1pM?=
 =?utf-8?B?SitWT0JlbE5ONElJd0lPLzlMcVcwMm5vb3ZCaDIwR1pwQ0tBOGZja2NSVHVO?=
 =?utf-8?B?cmNhRU9tRGQ4N3oxb0ltdmxySDFlbEwyd0NJOHh3OVhLTXc4dytLazdDWkJJ?=
 =?utf-8?B?KzU1UUoxdmpNNzJYSGl2bXBkcW5CeTB3WDZDY2x5RzNLZ0VYUVBKeExCTDdt?=
 =?utf-8?B?bVZmWXpack9xMGF4azFReTh3QzFncUNNQmhCMGJWS254Q0wxd0V0OE1wWVBP?=
 =?utf-8?B?VDg5VDFtV2JhSVdaZWZSTXNseERaRzRPU1V4Yy91TXZmbUo0VWptcEZsM0xz?=
 =?utf-8?B?N0tmaFNrVGRUVkNnc2F2SzhXTVlpVWxvWkppZjUybWthaHpFYU1xWTZQZTl4?=
 =?utf-8?B?czNWKzNSM1pTd1dLZ2FLZlhTMjM4TnZnNUdGSThsblZlR1lrRDdPVUJETHRU?=
 =?utf-8?B?am5sbU9iWGY4LzByc0dsTlVwMWI1T2VYeVRTZ3ZEdDFqajVVVDgzQTd6Snp5?=
 =?utf-8?B?K0t2dWhFNFhabEZxZ0VUSzFtS3YrZHdnelZUWmJ6eGVMTzk1L3JjbDlhL1hq?=
 =?utf-8?B?YVhmSnM1WkJCaDRNMU0vWjZidGNHU3JtZDRwclRZRjRVMHNCTTh3ODR4aDd0?=
 =?utf-8?B?TTBsM3RUdEJ2bGVWU2FxajhhL2ZrOVNXUFJHa1B0TzZzazZnNnh0ZFdQNVlD?=
 =?utf-8?Q?k9GyJYw0VXsACAzHJtP21YGKy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfffad34-d612-47a5-0625-08dbf5cd5f23
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 20:04:21.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPQqgp7A6TaKMKWb3VszKWAOP3v5OMqc+s2A7fXrS+VGlVkNhDs1yuEfDGUdAX6bq5dB4lndtoerccWnnI///w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

On 12/3/2023 06:29, Takashi Sakamoto wrote:
> Hi Mario,
> 
> Thanks for the advices.
> 
> I note that In my experiments I use Ubuntu 23.04 amd64 (v6.2 kernel) with
> backported FireWire stack[1]. Except for the stack, the kernel and software
> packages can be retrieved from repositories of Ubuntu project.
> 
> On Tue, Nov 28, 2023 at 12:09:41AM -0600, Mario Limonciello wrote:
>> On 11/27/2023 23:24, Takashi Sakamoto wrote:
>>> Hi Mario
>>>
>>> Following up on our last conversation, I purchase some hardware to
>>> attempt to retrieve outputs from serial port. Finally, I bought another
>>> mother board in used market which provides serial port from Super I/O
>>> chip (ASUS TUF Gaming X570-Plus). However, I have retrieved no helpful
>>> outputs yet when encountering the system reboot.
>>
>> Did you up the loglevel to 8 to make sure you'll get all kernel output on
>> the serial port, not just errors?
> 
> Even if giving either 'debug' cmdline option or incrementing console
> loglevel via syctl, I receive no useful output from console when loading
> the module at or after booting up.
> 
> ```
> $ sysctl kernel.printk
> kernel.printk = 7	7	1	7
> ```
> 
> I tried at several difference cases; enabling/disabling IOMMU,
> enabling/disabling SVM in motherboard level. But nothing effective.
> 
>>> As you mentioned, I check whether PCIe AER is enabled or not in the
>>> running kernel (Ubuntu 23.04 linux-image-6.2.0-37-generic). It is
>>> certainly enabled, however I can see nothing in the output as I noted.
>>>
>>> I experienced extra troubles relevant to AMD Ryzen machine and the issued
>>> PCIe device:
>>>
>>> * ASRock X570 Phantom Gaming 4 with AMD Ryzen 5 3600X does not detect
>>>     the card. We can see no corresponding entry in lspci.
>>> * After associating the card to vfio-pci, lspci command can reboot the
>>>     system even if firewire-ohci driver is not loaded. I can regenerate it
>>>     in both Gigabyte AX370-Gaming 5/ASUS TUF Gaming X570-plus with AMD
>>>     Ryzen 2400G.
>>
>> Rather than lspci, is it specifically config space access from sysfs? Does
>> the output from the serial port change with IOMMU enabled vs disabled?
> 
> In lspci case, I can work with debugger and figure out that 'pread(2)' to
> file descriptor for 'config' node in sysfs causes the unexpected system
> reboot. Additionally I can regenerate it by hexdump(1) to the node:

OK - is this by chance related to access to PCI extended config space 
failing for this device then?  If you read just the first 256 bytes it's 
ok, but beyond that it fails?

If so, can you please try to reproduce using this series from Bjorn applied:
https://lore.kernel.org/r/20231121183643.249006-1-helgaas@kernel.org

And then add this to kernel command line:
efi=debug "dyndbg=file arch/x86/pci/* +p"

Capture the dmesg and share it.

> 
> ```
> $ lspci
> ...
> 04:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI Bridge [1b21:1080] (rev 03)
> 05:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller [1106:3044] (rev 80)
> ...
> $ hexdump -C /sys/bus/pci/devices/0000\:05\:00.0/config
> 00000000  06 11 44 30 80 00 10 02  80 10 00 0c 10 20 00 00  |..D0......... ..|
> 00000010  00 00 90 fc 01 d0 00 00  00 00 00 00 00 00 00 00  |................|
> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 06 11 44 30  |..............D0|
> 00000030  00 00 00 00 50 00 00 00  00 00 00 00 ff 01 00 20  |....P.......... |
> 00000040
> 
> $ lsmod | grep firewire
> (no output)
> 
> $ sudo -i
> # modprobe vfio-pci
> # echo 1106 3044 > /sys/bus/pci/drivers/vfio-pci/new_id
> # exit
> 
> $ hexdump -C /sys/bus/pci/devices/0000\:05\:00.0/config
> (reboot)
> ```

Can you access config space for other PCIe devices successfully on this 
system?
Specifically extended config space?

> 
> I can suppress it when disabling IOMMU in motherboard. In this point, the
> issue of lspci is a bit different from the issue of driver issue.
> 
>>> I'm plreased to see if you have extra ideas to get helpful output from
>>> the system. But I guess that I should start finding some workaround to
>>> avoid the issued access to register instead of investigating the reboot
>>> mechanism, sigh...
>>>
>>> Anyway, thanks for your help. >
>>
>> Can you check FCH::PM::S5_RESET_STATUS on next boot after failure has
>> occurred?  It is available at MMIO FED80300 or through indirect IO access at
>> 0xC0.
>>
>> If MMIO doesn't work, double check FCH::PM_ISACONTROL bit 1 (described on
>> page 296) to confirm if your system enables it.
>>
>> The meanings of the different bits can be found in a recent PPR:
>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/55901_B1_pub_053.zip
>>
>> Indirect IO is described on PDF page 294.
>>
>> This will at least give us a hint what's going on in this case.
> 
> I'll try the above in this week. Thanks.
> 
> 
> [1] https://github.com/takaswie/linux-firewire-dkms/
> 
> Takashi Sakamoto


