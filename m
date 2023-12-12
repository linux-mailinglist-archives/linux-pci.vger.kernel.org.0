Return-Path: <linux-pci+bounces-808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B63280F588
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56778281E84
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D2E5B5D5;
	Tue, 12 Dec 2023 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SH+lJqix"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3849BD
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 10:29:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1gMnUyB1jI6fsi1WelmU072G0ky/nowomi/SbFt17bDpcOLrw4JrmqrwpSe+jHO5eOABNT67fOFyJuvqkf7+LYXbzj7Zt4h2Q5fkmrTE7o27tDezkF0mNisL7IN1Dkyfi2YpBpCheCZvnlKnjqq1IwFg5iZ4L7TcONGARqWIfArDD3e3PEl47BB4V5iuXUXfER10q4reAuO+A0vE9rcw2YIAVO3wKfRUs7SAdcVLixJGq/bdkP7KEvTPtkU5PMX/4HviGk2UVWX0TLVOSo6RiHVC2QNyzohocfYo5Pk4Mdm7W1YuEQHBbC2KbtasEDQdSPIyB1mP9vkrSp5BL3AeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmm8oLrW5M6Sm8RiWum5yGxEVcv+TnzhqBkR+qtWL0w=;
 b=ljXypaM8xaFEH+zsgQ8BIu1xm1xFsYxz1tdZGBoQTyhgtVkfHj6R9KrbPe7n0xyxBeSbjgoOIhxgGOPBtrXAkvTLkebccLnH533wyWoZ9QDtCkiatWqRr0lfftfWJs8jvSDZTrpyAyM1H6KP7rgLC/B3q/lqeq0zI4E2XBtVICvzCfqNWhLD6y8hseOaAUcS5q1d9ln0DCs23aMkSE7KC4kYGTsAqUmtfrNy3UCtJkMD2V3kBt23L4W/z5A7a1gDVOG/Lz3dbNwPiNGt/ysZuHfwZ9MZy45RBlTxSbYurx754ip6vtg7VzzTXjYCjjQsfMm290auPSzHww/9JjGaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmm8oLrW5M6Sm8RiWum5yGxEVcv+TnzhqBkR+qtWL0w=;
 b=SH+lJqixV39l9lnlq2mGj/jpQYMtHyQl2tFB1/JVzdUPWnJPZP3cDKk14j3uqIqQqgub0PV4Vy4hmpNrodeaPlKGNgJnexDXbovGFPZL7CBus9PrzRaBosTYhhHyr/2jOcS6LJ2rgSasc1HNBswvWZkxDA1sdpUqPE7joah5siE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 18:29:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 18:29:20 +0000
Message-ID: <5d880d78-ee3b-4c3d-a0bb-4e278c3d7b29@amd.com>
Date: Tue, 12 Dec 2023 12:29:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: PCI device hot insert is not detected
Content-Language: en-US
To: Ashutosh Sharma <ashutosh.dandora4@gmail.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
 helgaas@kernel.org, dwmw2@infradead.org, yi.l.liu@intel.com,
 majosaheb@gmail.com, cohuck@redhat.com, zhenzhong.duan@gmail.com,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com>
 <20231212105934.GA15015@wunner.de>
 <CADOvte=k6JJbj=CqjLQqYu1Hp+Cu891KNkn-BDkOKPTdfdVQvw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADOvte=k6JJbj=CqjLQqYu1Hp+Cu891KNkn-BDkOKPTdfdVQvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:5:134::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f97614-0218-4a68-13a7-08dbfb4041a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PtRfBVxoNMD1ItN0CKeI4j04LGGycaO5olziH4CbTylyt9/YrETsKuxz7dfwDFIBUVGnXOl01fe80IjyQ2plsMqXroGv8GsZ0IZbNqqMhQT51E+gNLpLvDlsNNm9k1Ou2X8/PkTEksRJiU4L79lTabWD2TC0hAP1uI2W/E561ohjlkmFOVHU9IL0uXaGRv0Pzk/3l8wx+1wPaZCly+1wf2DkSUkV4gWaOqaJJmTxHpWP83nssIVbkHl3vbR93Xz/Z/flVHcCVzo0VZLwK86nOKOGiGWyMCU/gf7pZPbwC31DA3nP+d49X7MFS+koomvoZzfmk2Xqa48xp7EXokdZ8NGiKV2hJuGx8jC7bX8QJdincg5FxNe/ima1q1hhf5OyQ5UhgSznQPliOWkTX5NxtK1cox+5WSPXJC+3U/G8nB6ok9awrrvBrWT0/JlNZ9q8MEKqoudA+mBt5CuF1BFHKa3C4MvScMX9ADj58kcIXAm2UcBxCB/7VQ2e/Y2J3+KjrGCxR7hWbDiX8VwhFXqjOD483LECwaeIZiBrSQwT8vq6Lt3tNelYaZauUNbljoziIxLO9Ig3ts25WydRhHWxnA0PAhawX8jJp9lRpsu5Ioodk+utRGUwCyzknQqVQ7Jm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(41300700001)(2906002)(110136005)(316002)(8676002)(8936002)(5660300002)(7416002)(44832011)(4326008)(53546011)(6512007)(966005)(6486002)(6666004)(6506007)(2616005)(478600001)(54906003)(36756003)(86362001)(31696002)(66946007)(66556008)(66476007)(38100700002)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlVtN3BrNHFLN3kreXFZUTVMQ0c4Y2xUOGtZbjNWWk0wZEVpemxkU1NqMGY0?=
 =?utf-8?B?WWZCbWQ5VGNZaWVFNE8xRHBtYTRmNFdML0F6QVN0a2tITVJQRGJtMjYzc0ZS?=
 =?utf-8?B?eGJ4YnoybUNrNVV1dSthN2xwQmwzWXZOQjVsZHI5N3N0ellOUDBnWmROdjdn?=
 =?utf-8?B?VkpuYS82ZithU3VrZklGREk5ejBSdjA2TzhqTTRBWi9URDZ3UHFnbVdzVnQx?=
 =?utf-8?B?UzBLU05YRXhBcWRJRVE1dHpmSlRqOFZhOEJGYmlmYTU5SGpxd05ZYmxEUlZH?=
 =?utf-8?B?VTUvKzh5MkdkWjUwUC9zd1ZzY1ZxTXFabC9pamVVQkZkcGhaVlRUaWpsdE1m?=
 =?utf-8?B?aExoYXlUVERHZk5xQjB0NkNSR1BNa0EvdDdXSWJRdzh6R291VVBDRDZnaFhE?=
 =?utf-8?B?WU92RDY4a3NFU3M0TE1iVkxJRDNZeHliZmlqY3d0R2dTbTA4dTRKQjFSMm5L?=
 =?utf-8?B?dzdvdnkzMWZ4UnJyeS83WDR1ZklYQnpCeFIyVWlKME9mQU96MzBEbEZJSzl3?=
 =?utf-8?B?czJsUXozRUQzTWkzUWhYU2lCYzhWRGR3Y1R5NDdiaXR5dy9qUEtPSnYyNmty?=
 =?utf-8?B?d1Q4SnBaTEhkWllUYXFSQkJNN0VkMDBtNW8xd2kwc3BVakJ2Y21NamZuVG1W?=
 =?utf-8?B?VXh1dS9BY29NYjBaYlN3ZE1objlzSUphNWJrMnB4eUFBakhZS2hCc0tyV1ZW?=
 =?utf-8?B?WGZ5TEF5cWtydm42Mm5xWjdLb1lSTnd1d01TVWJDT2M4SjBFaEpZeGw5NVRr?=
 =?utf-8?B?OFFIemRHbTc4Smg5UWJvNXp5b3pTazdvRHl3KzZwUWxrK0ZpQTR5bmdQWlBF?=
 =?utf-8?B?K0RGbnVYNjduOEdwbVp3UDgzTjRwUXhnRWNOVUFSNFRGUVQ3MGxiZWxNTmFt?=
 =?utf-8?B?TkszOFUrcXNEZFZzOVBFSGxYNW1LSitDalNrUysxQ2dyanR3V2hQbnhWWmFo?=
 =?utf-8?B?ZlZMZ2JOU01QOFVtTXRaNDcwV0NINE1qNmhqejRPNUhKb0xPRGprb1Yvajd2?=
 =?utf-8?B?VFNOWGVWNXppUGs0YVkrTGpycERObzY1bG1MZGEvVmxPVmJOanpuREJUVUFK?=
 =?utf-8?B?R1JkbHRRMnYzMjcxYXZOZWJXKy94TXY2UzBKRXQ2S2IrSWFUQi9RTXVydE1M?=
 =?utf-8?B?SFN1bkc1RnM4S25ha2pmRDJXcHAvMjIzbjQ2bkV0aFpkeGFyWTZPRDNFdWQr?=
 =?utf-8?B?K3ozRXBYQk15MklwWWdjMmNLczFRY1lpMEptQW9YUC9uUzVmMlZ2S080OTJx?=
 =?utf-8?B?OUdreFZhS0k0aU9NZCtkTU9wUWVpcDdIb2RYMU9tV3A2OVI2RUhhRlRYQmxN?=
 =?utf-8?B?N21mQXBxYXY2OUo1d2pDc3lFdWFFeHh2WWJVa0FFb0JYbkdKVjdiTTd3bEYv?=
 =?utf-8?B?cFJONXBEK05KdXdoQk1XRmhxbjZtREhQSitmdUs5K1gxVGdFTVY0bzUyOUg1?=
 =?utf-8?B?Q3hVbnNjYmdTVldMbkpPWEh4ZGN1R3hjdGxmNTdJdGVnV3Z1ZkpaaXlOaS80?=
 =?utf-8?B?TmxCN3Q5SHdMQ1N3OTc0R2pSZFZ6K1RsMmJUa3R5Y0hTMTJnWXhIbmVoSlhr?=
 =?utf-8?B?NWVMMWZXT0lJay9xQ0wwZngva09SV0JkUklyb29hdkV5bThkT0N3dXNGY3JE?=
 =?utf-8?B?bjV4R2QyNEdmaHpFOVNNdmtWU2VXQ3pvcWUrT25EZTJjZjZiRFZzdzJ6aWlP?=
 =?utf-8?B?TWk2ZnpOSjJKbDIrbjRlK1Bta0tkc2J4Q0VsU3ZrTjlzMG5sVTN1S1FuRzdS?=
 =?utf-8?B?bEd2NkxzUlBXT000bTgxbi94dnVuZXc4Mi9HOUZjeVBkTjFNYW5SZkM2SU12?=
 =?utf-8?B?R3BNZjBXQnlRR01JT25sUXZRR2lBb0hnWkk2SnJPcmkxQVNNL25nZmpqK0h4?=
 =?utf-8?B?QU5wWXdSdjdqclo5QWRZS1pUMjB5T2djVi9PYzBCQVpBQUZid0cveVErME15?=
 =?utf-8?B?bENjemlZS251SFpsOU5QWGU1dzZmWUNlRDJ2bHdld0paNTBPMzJIdVh0aWtL?=
 =?utf-8?B?Y2d1RTJpS05UZ3JDdmR0MTUxaEZINE9BZHR5MW5lSXBDd01INHErK3JNNVRh?=
 =?utf-8?B?d3dsbDI3dEFOWXZVU0dUQnpPa3FXWWhOS2U0SzEyNndVWHpIL2RCWTM3aUVG?=
 =?utf-8?Q?17lt/VV3KhfH6hVs15wdVfL5z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f97614-0218-4a68-13a7-08dbfb4041a6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 18:29:20.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc8rlMBVoTmxekD4omqC2qTvL7EzGFszI3He+FG5d62mzNP18tPHE1GN6auidHV3K2ykbDXDq1dgBpj1kM6REg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434

On 12/12/2023 05:32, Ashutosh Sharma wrote:
>> This doesn't work, try "echo 1 | sudo tee power" instead.
> 
> This was not a permission issue, I already gave it read/write permission.
> 
> admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> -bash: power: Permission denied
> admin@node-4:/sys/bus/pci/slots/14$ sudo chmod 0666 power
> admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> echo: write error: Operation not permitted
> admin@node-4:/sys/bus/pci/slots/14$
> 
>> This is from a "Link up" situation (DLActive+), it would be more
>> interesting to get lspci output of the port in a "No link" situation.
> 
> Unfortunately, I did not collect that output before system reboot.
> 
> On Tue, 12 Dec 2023 at 16:29, Lukas Wunner <lukas@wunner.de> wrote:
>>
>> On Tue, Dec 12, 2023 at 04:04:41PM +0530, Ashutosh Sharma wrote:
>>> Removed one NVMe drive (pci address 0000:83:00.0), it got unbound
>>> successfully from "vfio-pci" driver but saw below error in the syslog.
>>>
>>> can't change power state from D0 to D3hot (config space inaccessible)
>>
>> This is normal, the drive's config space is inaccessible after removal.
>>

Was the removal a "surprise" removal?  Or you mean it was by using 
'remove' sysfs file?

IIRC surprise removal will need platform firmware support to handle it 
properly.

>>
>>> Then after 2:30 min approx, re-inserted the same drive to the same PCI
>>> slot. But the drive was not detected.
>>>
>>> Dec 11 23:54:39 node-4 kernel: [183672.630191] pcieport 0000:80:03.2:
>>> pciehp: Slot(14): Attention button pressed
>>> Dec 11 23:54:39 node-4 kernel: [183672.630195] pcieport 0000:80:03.2:
>>> pciehp: Slot(14) Powering on due to button press
>>> Dec 11 23:54:44 node-4 kernel: [183677.671931] pcieport 0000:80:03.2:
>>> pciehp: Slot(14): Card present
>>> Dec 11 23:54:46 node-4 kernel: [183679.783922] pcieport 0000:80:03.2:
>>> pciehp: Slot(14): No link
>>
>> The link doesn't come up, so the kernel gives up on the slot.
>>
>> I don't know what the reason is, could be a hardware issue or
>> protocol incompatibility.  This doesn't look like a kernel issue.
>>
>>
>>>   |           +-03.0  Advanced Micro Devices, Inc. [AMD]
>>> Starship/Matisse PCIe Dummy Host Bridge
>>>   |           +-03.1-[82]----00.0  Samsung Electronics Co Ltd NVMe SSD
>>> Controller PM9A1/PM9A3/980PRO
>>>   |           +-03.2-[83]--
>>
>> Adding Mario, Smita, Yazen from AMD to cc, maybe they have an idea
>> what the issue is or how to get diagnostics on this Epyc platform.
>>
>> Start of thread:
>> https://lore.kernel.org/linux-pci/CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com/
>>
>>
>>> admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
>>> echo: write error: Operation not permitted
>>
>> This doesn't work, try "echo 1 | sudo tee power" instead.
>>
>>
>>> lspci output of the pci port:
>>> 80:03.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
>>> Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
>> [...]
>>>                  LnkSta: Speed 16GT/s (ok), Width x4 (ok)
>>>                          TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>>
>> This is from a "Link up" situation (DLActive+), it would be more
>> interesting to get lspci output of the port in a "No link" situation.
>>
>> Thanks,
>>
>> Lukas


