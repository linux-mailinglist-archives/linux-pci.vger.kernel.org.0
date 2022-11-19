Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B62E631065
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 20:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKSTOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 14:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiKSTOX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 14:14:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE2252;
        Sat, 19 Nov 2022 11:14:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA6/LSq7Yh9q7Ox/vz8E2sa7ktXqzYAYocMfWT/DNd1y5raWdRbn0UfB9wlOJsJifY6h124Iwt7W4jkwyAnP9XZnBP1XT5XWDvm+4q4B108KK7onWW3JfOs/vS1QcbNKOlIEXe4cUcd5gycfk3HE+2IK9GDMBJsEi1mlFkA15QhpZY18mLBkuWAL/S5B/pCJm/3QasBxmGgsk+Q3zp8WfSKJSLGgi+08VUfFcxu6tslEo4zT9V5etpm3fHJPsSQJsGK0UjqEnbpxK873K/6qeKoZtkK549h2+5DBA4QhR17FQuxyd+sZ0pLyUqgr8asn/YOhZXiQ28r5ggXM8KxD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN/0lGfoMRyR79JEkj4khXsNvta8d8zYHvFEXAVvEUg=;
 b=k8o9Fy8xnokuCyYLcpx8HY18V9WVWHBTfwRFYPFbun0EITl6k2Y7ApDgAB8E7+eLR2b9WW2ThMNiLDktVuk6c1hvgR8dTeRhqcVz7RP8zUiW4yKMpozB/jfP4AGTfvFFuDc+hqb700sWzxJYQy5tvnfbyr/+KsMabGSKL7nYKLIKutL4a+kyTarf9HRiVbyYd58zWlkAR44d2egZgBAPnO5eJxHuq7klIDB9NPC34joQF/tnunvP89i87AaiduAYiW1JKo+tvCrbd4GM8Lr3Hcs8qDQcwmYRxwxRrPInbe6Oof44PHw6UbUIio4c3cJIFZaiYT0/OQbovK4mXrMOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN/0lGfoMRyR79JEkj4khXsNvta8d8zYHvFEXAVvEUg=;
 b=YQpwDjTyjfnqopJ+VLxA9mtAcWIL5oagiiNzHdhMeq56TZBUW/kV3Ot4cF2irug+JfAhvZuNMTDhxRIYyX8EdI7eOpg+VutE6dYIvvEss1eQw2JSazvt1IHBJydQlv+RCVSGvuUdoM3fLwmE38Af8C0vQm+flO4uP4QzrgcJWFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sat, 19 Nov
 2022 19:14:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 19:14:18 +0000
Message-ID: <e10c6093-6ca5-e669-af0b-bd91514b6371@amd.com>
Date:   Sat, 19 Nov 2022 20:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC] Resizable BARs vs bridges with BARs
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221118160916.7e165306.alex.williamson@redhat.com>
 <fe0e40cb-b982-2aba-b622-8534c174ea39@amd.com>
 <20221119070741.7038464f.alex.williamson@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221119070741.7038464f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b8588b-5f90-4205-a882-08daca6241b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/fNplxawcuBc3z4ES2tyFhEizYCpqTOMLPSHV751OHMDrS2/KeuvqOqtfuuFiR2zPvzVtB79KOONUJcAyUP9oL7XS3OmFL/Rq6+9QkEJ20LPQ4TDK3dexD4Dji4HDFQBq5xYUg6ssB/nh3bE9IB4auJ9fea9vgb21suo98DDu/44zv7th4dFOggtFA8Jyr8Tfg8H4PUmrEVGDdlwcXQg2FTToJMTfcNeopo6R4gFFERoBE0Yjv49xwVvQAQdnsU4Q6gMIk1t+WGYClx28nLrUpFPI3wD3903OdPuhAQ0lT5RvSCUTMpoupidUrd+1Ihsq0g98xCk0141HcNEoheaOxJvseV7Ky0EK2/Dia3L0BGZVD2MB+wuZzDwfByWMv9esN5d7VoXjEcYCRnuLlUP0BJ2C0luyL2CvxPwkrYMJvUJGToIggVjRjms1XAid01bTkQvv/L2uQGiXi6+SVqsHs2TpwHw/Pq1YqfpBl9Nx7MjvZrMAWpiDicok/KgB5VHZngTmyk6RGWPATZU9iDFIT85eqMWLXM9F9RtOa/FMqeMS5EWRGuXg0pUHULuAEIM/yFlozQx9LVAbe80SM3hKb91dFyI9Q/FWHgpwTcjsXcRhmt0AZvLKmvCppSXge67+ni/TxgY6mFds1jlMosc8LdpKkp1TUUyD4fTJaaLqYbHjejofbVKV0gYTqw5fxOlMo68sfOqGYazrq3RXUUiR7hFi35gFUhWnb6Xm7b8rU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(83380400001)(2616005)(66574015)(186003)(8936002)(38100700002)(5660300002)(66556008)(41300700001)(6486002)(8676002)(6666004)(66946007)(4326008)(66476007)(6506007)(6512007)(316002)(478600001)(6916009)(31686004)(36756003)(2906002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmV5d3JCY2lNVUpLSUh6a0pyZXpyU2JWNlJIN2NxcmtCQm9KaHNrZUpucmFv?=
 =?utf-8?B?TTMvNWZ1ZjQ0QVQ2eUlvZVZvRkkvTnpyN2Eya2gyeUZyVXE0alo0clZXNHV2?=
 =?utf-8?B?WXhvTzJNRkZoeldtclVkWTBhY2E2a3JBSnBjQU5xSFJPWFhxbEVGOEV5UnJF?=
 =?utf-8?B?cDVLUnhKcUwrZE1TTitNRUVBTTJYMHFkeHF3ak5RNHhudU0wZ1BOVlJsTWV4?=
 =?utf-8?B?L3Y4bGFudjF3cHpId3d1VmpkcmphdFRXUmIyVUtHVk9FOHR6RFlNUno0Yi9Q?=
 =?utf-8?B?VnJZY3lHVzRlWXNETnRRdlMrazZPUzFsNmszd0VHUlJXbXZZZlBkTWtTVUxt?=
 =?utf-8?B?QlRpbjhMWTlldVQ3WDRHanVDZWFHRlgxL3FSRGpDczFucTBtVk1sUm1rVTBj?=
 =?utf-8?B?ZWFUVllhaXR3b2VXb0RnT3VvTEFnQ000MDhScy9oNmg3RGdVMEplaXJuWjZt?=
 =?utf-8?B?NlFCRUYzSHg1SWVCNXBIY3o1RkJTdy9lMS9GMDNRdEdCU2k3QkJaaFJhL2g0?=
 =?utf-8?B?Snc1RklzWWQ0eXYrYmdXeC94djFMK2IrNTZJSEpuaFJ6bDRKNXNWVHVSaFNi?=
 =?utf-8?B?OVZ3Ris3UHFEa0xNeTB3V09KMGJWTmF0VXR2TGkwQk5BdDhkb2ltYmlZWStr?=
 =?utf-8?B?TGVwelo5M2tKUDFjbExJd0xrajNsN0NqTTZGWFBTT0YzdUNBMFJHL2RIZjc5?=
 =?utf-8?B?NVV1Z3pKdlJaZXlWcmdDTjFOcmJVYUlWRW5tS3BPSERpK2NnLytrSHFwUlpi?=
 =?utf-8?B?MStXcGN1MjJBQXdpaGc5MXBaVHo1S21pMHBxK2xFTWVmZlNoanZQV05hYis5?=
 =?utf-8?B?SHJiMmxkdG1vY0Rsa3J0Yi9sSy9IaTZ3aE04SmRSUXYvcWFEOGlEbGFjalJG?=
 =?utf-8?B?NUM3M2tiTi82Z2lKclZoTDRZdTAzbEJLb01JakJ5amUwbG05eVdOZ1NsaWRK?=
 =?utf-8?B?eGFoTFhqdVB5ekxaKzcyZk9vVGFkeHF6QXk4d210amdzM1FRcEFxdTFDakp6?=
 =?utf-8?B?VlRJM2dUL3hKUWRHYkpDS1AxUkRHaGR6YjVVcW5teFBQRHJjWVdrcGkyVk40?=
 =?utf-8?B?V3I2bHZ4SHBKVzJ1ZGZFZWkrT0x5clVZZzh1OS8xK2V3MDlVRFV0dW1hZVVT?=
 =?utf-8?B?WEh3TkV5MTlvSTkxdXRrcGtqZ1dLUzhBNy8zOTFoaENHZjRrWnQxUDJmVHFX?=
 =?utf-8?B?bXdtQVNPS05RUGFjWVgzTDZzRWRXeTM1NFFCMERtQ245N3dodCtRZzh5R3h4?=
 =?utf-8?B?eHlrK0hLYXZtZGhhTWovRmk3c2MxQmNhR2pEbmQ3MitXS2RMTXduU3FhODh5?=
 =?utf-8?B?SlQxMS96QXZaQlVLTlZHc2FWNEZSRjd1RmszM2NNMFlkck1pYm9YbCtNUlk0?=
 =?utf-8?B?ZEtjNlNXZWxHdWRHZUJLNElSb3BTQzlQQ3pUcW1RN2ZHeElYUFk3SHdJMUZV?=
 =?utf-8?B?WUkzMDc2YmtFcE9TWGZPWklFbkRVR3B4NXNBeVUzYTY4ZEhrQTdhTnFBc1p1?=
 =?utf-8?B?LzMvNE9HZHpvRWNISnpiYkhTR25wT0d5WDB1cTBnWVhmdm13UURRL0tqVUpO?=
 =?utf-8?B?c24vMlM3QUVrWGFBcE44SndtSTRTNEFiMG50VUNUZGsrQUFHS3pERkRFYlRm?=
 =?utf-8?B?aGJjcTg3ZnYxeW1wK2luVm5yTSs3c0dXdlQ1R0x2b3dWQUNwREJEMkNRTXFJ?=
 =?utf-8?B?MzhiTW5EM1dKQTZ6N0lXeEtmblJrUVBIVHJ2cjdtdXhMNU1iTzFBa2h2NUdm?=
 =?utf-8?B?LzdZL0FNb3QrZnEwTXJVaDhwdnVoQkhhM0xLWnZ1dlA2WDVXci9EbkZRZlRI?=
 =?utf-8?B?aW9NVE5wNWhrQUxjTHRIRHVsT3ZpbHdUb1AwN05qRVBTSkF0OG5rRUsvakg4?=
 =?utf-8?B?RUZvRmVIVEpIc3gvclhnNnJKMHE3YjBzTVorV2VCSzFjalNjdmhKeDVselNa?=
 =?utf-8?B?K0wzUmM0OURNWlJOWHk5anE1MUswSjZmN1pnaXRTbXkvUmNoRzFOcmx0VzVD?=
 =?utf-8?B?VnlyS0FiN21ZbmNzaVlJWk9iYmpEZWpvcTdxckRReDg5WGhTYzlSNWtSa0RX?=
 =?utf-8?B?ckRObDBZZjdYYWhBam16OGNhZ3Yza0o3QzNQbkQ1R1dFV3Q3Y2Z6MzVqeExN?=
 =?utf-8?B?bmVTVExQTkVhcnRTdjhwbjZLL0lXSVhFQVlKSTRMYzNuRjlTMFBXbk5rUG84?=
 =?utf-8?Q?oSJcM0TvDYDOTeyRaYWTnjQqIAs1nV7phAnxhTgycubK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b8588b-5f90-4205-a882-08daca6241b4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 19:14:18.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfZqtJcg3F/TP33OsYFRPlYSSAuFtwYpKuf8z3g7GyWSiqN6J/bomaem30In5jgv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

Am 19.11.22 um 15:07 schrieb Alex Williamson:
> Hi Christian,
>
> On Sat, 19 Nov 2022 12:02:55 +0100
> Christian König <christian.koenig@amd.com> wrote:
>
>> Hi Alex,
>>
>> Am 19.11.22 um 00:09 schrieb Alex Williamson:
>>> Hi,
>>>
>>> I'm trying to get resizable BARs working in a configuration where my
>>> root bus resources provide plenty of aperture for the BAR:
>>>
>>> pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
>>> pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
>>> pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff window] <<<
>>> pci_bus 0000:5d: root bus resource [bus 5d-7f]
>>>
>>> But resizing fails with -ENOSPC.  The topology looks like this:
>>>
>>>    +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
>>>                                                \-04.0-[61]----00.0  Intel Corporation Device 4f92
>>>
>>> The BIOS is not fluent in resizable BARs and only programs the root
>>> port with a small aperture:
>>>
>>> 5d:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port A (rev 07) (prog-if 00 [Normal decode])
>>>           Bus: primary=5d, secondary=5e, subordinate=61, sec-latency=0
>>>           I/O behind bridge: 0000f000-00000fff [disabled]
>>>           Memory behind bridge: b9000000-ba0fffff [size=17M]
>>>           Prefetchable memory behind bridge: 000000bfe0000000-000000bff07fffff [size=264M]
>>>           Kernel driver in use: pcieport
>>>
>>> The trouble comes on the upstream PCIe switch port:
>>>
>>> 5e:00.0 PCI bridge: Intel Corporation Device 4fa1 (rev 01) (prog-if 00 [Normal decode])
>>>      >>>  Region 0: Memory at b010000000 (64-bit, prefetchable)
>>>           Bus: primary=5e, secondary=5f, subordinate=61, sec-latency=0
>>>           I/O behind bridge: 0000f000-00000fff [disabled]
>>>           Memory behind bridge: b9000000-ba0fffff [size=17M]
>>>           Prefetchable memory behind bridge: 000000bfe0000000-000000bfefffffff [size=256M]
>>>           Kernel driver in use: pcieport
>>>
>>> Note region 0 of this bridge, which is 64-bit, prefetchable and
>>> therefore conflicts with the same type for the resizable BAR on the GPU:
>>>
>>> 60:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A380] (rev 05) (prog-if 00 [VGA controller])
>>>           Region 0: Memory at b9000000 (64-bit, non-prefetchable) [disabled] [size=16M]
>>>           Region 2: Memory at bfe0000000 (64-bit, prefetchable) [disabled] [size=256M]
>>>           Expansion ROM at <ignored> [disabled]
>>>           Capabilities: [420 v1] Physical Resizable BAR
>>>                   BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB
>>>
>>> It's a shame that the hardware designers didn't mark the upstream port
>>> BAR as non-prefetchable to avoid it living in the same resource
>>> aperture as the resizable BAR on the downstream device.
>> This is expected. Bridges always have a 32bit non prefetchable and a
>> 64bit prefetchable BAR. This is part of the PCI(e) spec.
> To be clear, the issue is a bridge implementing a 64-bit, prefetchable
> BAR at config offset 0x10 & 0x14, not the limit/base registers that
> define the bridge windows for prefetchable and non-prefetchable
> downstream resources.

WHAT? I've never heard of a bridge with this configuration. I don't 
fully remember the spec, but I'm pretty sure that this isn't something 
standard.

Can you give me the output of "sudo lspci -vvvv -s $busID" for this device.

>>> In any case, it's my understanding that our bridge drivers don't generally make use
>>> of bridge BARs.  I think we can test whether a driver has done a
>>> pci_request_region() or equivalent by looking for the IORESOURCE_BUSY
>>> flag, but I also suspect this is potentially racy.
>> That sounds like we have a misunderstanding here how those bridges work.
>> The upstream bridges should include all the resources of the downstream
>> devices/bridges in their BARs.
> Correct, and the issue is that the bridge at 5e:00.0 _consumes_ a
> portion of the window we need to resize at the root port.
>
> Root port:
> Prefetchable memory behind bridge: 000000bfe0000000-000000bff07fffff [size=264M]
>
> Upstream switch port:
> Region 0: Memory at b010000000 (64-bit, prefetchable)
> Prefetchable memory behind bridge: 000000bfe0000000-000000bfefffffff [size=256M]
>
> It's that Region 0 resource that prevents resizing.

Could it be that some of the ACPI tables are broken and because of this 
we add a fixed resource to this device?

Otherwise I have a hard time coming up with a way for a bridge to have a 
BAR in the config space.

>>> The patch below works for me, allowing the new resourceN_resize sysfs
>>> attribute to resize the root port window within the provided bus
>>> window.  Is this the right answer?  How can we make it feel less
>>> sketchy?  Thanks,
>> The correct approach is to remove all the drivers (EFI, vesafb etc...)
>> which are using the PCI(e) devices under the bridge in question. Then
>> release the resources and puzzle everything back together.
>>
>> See amdgpu_device_resize_fb_bar() how to do this correctly.
> Resource resizing in pci-sysfs is largely modeled after the amdgpu
> code, but I don't see any special provisions for handling conflicting
> resources consumed on intermediate devices.  The driver attached to the
> upstream switch port is pcieport and removing it doesn't resolve the
> problem.  The necessary resource on the root port still reports a
> child.
>
> Is amdgppu resizing known to work in cases where the GPU is downstream
> of a PCIe switch that consumes resources of the same type and the root
> port aperture needs to be resized?  I suspect it does not.  Thanks,

Well we have the possibility to add extra space to bridges on the kernel 
command line for this.

This is used for things like hotplug behind bridges with limited address 
space.

Quite a while ago there was also a patch set which dynamically 
binds/unbinds drivers from resources to resize the BARs. But that never 
got far because of locking problems.

Regards,
Christian.

>
> Alex
>

