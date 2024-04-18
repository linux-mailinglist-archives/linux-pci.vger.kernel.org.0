Return-Path: <linux-pci+bounces-6425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110178A99B7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993641F21A25
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0683471B20;
	Thu, 18 Apr 2024 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z3ui94ge"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C082375F
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443073; cv=fail; b=a/BXEZwX/EHtYr4w3380+aaiOiZ0OUUgGe9GoJ9/5n9eLJ3XRNp2xuzBERHEllGA27PsteoRT/Dlr7uWM0qVP6g1qQQbOAvdkZm6jKe8x6ym9k2ZVrn8UJ5ctqtSd99XGNlnGBSSI/ql+jTYxALLJK6kR0kLCQ0uAQ6cSazj6Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443073; c=relaxed/simple;
	bh=fQOBtP4r2sF6ib5XU9+6KNxDs4HjPo/eYysUXKuEVOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IwW5Rn3CTS37dIEcjF7KGJYVOatdBhcjcDifb3n8aX6kNz/th0DH3d6RrDos6yfgj9jr89DT0G9O4pUvwT5HVAf8AnZHEElryjQdQq4yoNJkeUuDpwg44oe82C5EdhcEh1AbwTyvx+Ty/bXysEJyH7xTFo6zk5g5tLLvCOIGfuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z3ui94ge; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCwaHD5VhhtdkQChWNn3D6bxJEtoSMsUt9PpNPzuyqhYfgTZsEmt1+FpZHFJvf1N3/GQulH65m4vyZYjLzKca3H/bXrnIlweMZL6QTSWRov+ijzLucLYS8YhivJD3SVdWWQyRjjOzCc/zJo0TOks0x1TXqCRmxLFR2nWMnM95oj35s5Mt+3NZA/s2TCTDHLuPIXOoMz4n1NlQgVLpcBl3MzaDI1Gf8wakgDzSWMWzA5GopMvrrLStSwxvM68XIjrOv8rcUs252YPnWTrqdQijSBeuBjjYOB51RtKyasW0iqAsRwql4ZRiUWJXcKsSoxsFIjuD5KSuB5aO2/LDoUMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nG3xBdmYt13NRm9o5Km0OBrsSynAirOGRmsvUNWkpU=;
 b=R5FAbSSWrhTQTyPlUTjuYH+h9sNf6JQj3dDrRu68kr1529kvuc+cFlTNxipkpUFT5B9UaBfNFdcgtEQLMREKrXM+e3fgly7rAZYNPZph2e9mswSRNoG2Run8dVZ+vS3sHRNkAcCoQg8G7BKzFitRAlpzlj/R53P/ZvzRxHZiFuf03rkSW4gDOnYZhuTGRjr+R1z2YKbavv7J9nFd3OgXmGpsFn4t9ARRgrixEphR5Tn+oOC9dIjuNIbJcc3DKz6jFSWSJPv1KWqoSlN7Pruw0wasOfaY1KkvXAAYJpfyB/PT0+KNy0IaA5nFFTsA/gcY9bk1ODnbsnwD96lTsDYJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nG3xBdmYt13NRm9o5Km0OBrsSynAirOGRmsvUNWkpU=;
 b=Z3ui94geXmFTFY39oiFB1IJj9almDuS3vzCVS8cIiiF95PAFmX4TJA6BG2IRqexlox/RUq1jR4LMhvCIaP5Zbtc4pqsjbJQ68vc8/H0NBTiAIfk1z7a6mIQJ56vPuwFyfRbsIYO8s5BgBb4FTMHyDhfTAQox60PPs5HkX6388Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 12:24:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 12:24:28 +0000
Message-ID: <fbc9f2c1-2e5a-4611-801e-f055e6042897@amd.com>
Date: Thu, 18 Apr 2024 14:24:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: PCIE BAR resizing blocked by another BAR on same device?
To: Dag B <dag@bakke.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
References: <20240417151313.GA202307@bhelgaas>
 <d509c9e6-37be-44ab-8f47-6fe55397794e@amd.com>
 <fa9245d6-ffb7-4bac-8740-219af7fcd02a@bakke.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <fa9245d6-ffb7-4bac-8740-219af7fcd02a@bakke.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: bed49d72-c45e-43ba-01c1-08dc5fa27e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ywH3SFf2H5hc+7GMv2PO8obbCXSrFV611RN8p21z/mcOY/wvFPvAvT12m1UV0UpHxMxmyxEhIYO/SQ3D7CdtHRrZ5pmVygUABGF+lPExsKpSYdONBSbYi8Nf/mrArTpjSKkYaBELv+a7uYudyN3lCddS8oEmjvCy67dpIdxkSPKvbBFpQbls1WaVoCDnDHb5KFDzmZ2PbHBf6i1vStliH68iUqEdH/pZLwU8QQQ0R7eGy/7lB5lsmtDt+9/xpWiOAJsPLhjsGD3XiUoYiy6o5I+73chluDIEsaoZLylVn56Xbs+3ttMAlDVytq88mcydS7NnX40g++fVC+NzBEGfZobhax6Hj1DQv8UqNy89K/UzN3UE0CCPHMXD4H9geumnHJU3EkEkbHJMJfzQO8XK8SOdsNo8/e9rKgiVLnr8hNtmBeKzqFUuyqlBeh2f7J+hyRT02bD7Q1uoBYqJJmucrWxwqIoovvTl34Bk8xRIXjJhqY6dyQDOZHnHZRzzoRNEX+wepotq7woBB4XSK6FIhJODLvMAEwn3piO0JLG8LhoRXYJpaE15zZcCYHLRqCoxeyCFogH/GrXoA6dLRlcsWk1+HMtva85olHv3R5OIBScSiPcU1iNQA4K2VIyW0DkWJLUfOAgl2p8P/O8WUgYX3wzTrPCGz7Oj5YOLg5iXwZA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVN4VEczN1J3Q1RLbVltTElSdmd6elcrbmMwUEo1TUlJMXFGMWh6YXFQZnVL?=
 =?utf-8?B?TW5GR1FKL2xQcGlLOFFtdXM5TmtlYi9yWjB5Y2dEVS9meXNFREpjcVJGNFBF?=
 =?utf-8?B?aFRkTWxIaDRmcVFSZ09ma0lYdmhqNXRsc1NSQmloQjljMU1nM0Q5a3IyK1Uz?=
 =?utf-8?B?K2pCbDZ6dW0yK3E5Q2dKN2M4UHB0U2xJMnhnMFFPVkUxL1F6S2psQTllL01S?=
 =?utf-8?B?S2M3UDluT2VTbnVobUt1dCtjMnQwb0JmbUtwamdwNXpnUjN6b3NWVjFzQmhO?=
 =?utf-8?B?enR3dzdhZE1ZYmhSVFZDRVAvdWJRUDdHbzNJNHEvL0xxWWgwaU41RHVhTjZl?=
 =?utf-8?B?VjR1Y0tIZy91VkN5YzZ6YURkV1NXMzU5anRWc3hacXVtL3Z2Mmt2MVhhZkNN?=
 =?utf-8?B?am5idzBrRWxPbERDTFZkY2FHaDJIMUx1L2k5WHF0am9xOTQwZnlURnJxN01N?=
 =?utf-8?B?VWxpS040WGtSZG40elByU2tsQ08zUkV6c3JVRWRmVGlYVnJJMVRJNERsSktC?=
 =?utf-8?B?MjhvdklrNlBxMzZsRkE0bUMvQ1R4cTdIMk9EVEJmWmNvU2swcnE0d24vSGdv?=
 =?utf-8?B?ZnBzRTVJR3I2QnZYYUVTSTJVVzlPR2NZVEs2bnlVV0ZWVEFROEhyeU1aTFJS?=
 =?utf-8?B?azl3a3lYaHhrZlJhaHQ4NkU5OUFlZGtDOGd0NUJJeWVTbS9GY0Q0d0RTNlpJ?=
 =?utf-8?B?QXBpQ0RkN3ZmYlh4bzRLdlYyRnZHeTkyRTNJNDhrRHJHMEVWaXZpNnR1Sm9Y?=
 =?utf-8?B?UktwaklEQ0Zib3FnQlBwS0ZPL1p3Qnl6VXoydzNOeHlFWnQ0VFBBekpoSXpI?=
 =?utf-8?B?dlF4YjlNREMzKzVURnoxRU5lMnkzdGtOOEdIdHlaMW9OQUJJTFJUNDFrZkt2?=
 =?utf-8?B?UGxlSDQ0RGQyTU81ci9LUTE2MEkxSG83TTM5dWV2NzMyOVNjcHZ3SG5xQmtX?=
 =?utf-8?B?aUsyaVhjdlVJNjRtY3BPcHIvZDhRandKeFJWUER4TFVtdUo5bmUvR0x4TkVZ?=
 =?utf-8?B?bXF2SXBtSWl1cFZ6SUg2dUJQUFlQcjdJWXVPczYrbUlVbzR0VXVoM3lRTUNK?=
 =?utf-8?B?WjFMWUlZQmVYQ3hNNE0vVXRXVU4vczRwaThXTHZoV1hlVy9ncjBGZzN2NGR0?=
 =?utf-8?B?UjRqSVJlejk3WHk1aUlkL1VtQlg5aVc2Y29PamVZM2QwUjJxdm9sTzVGSTlU?=
 =?utf-8?B?MzMwVDh6ZFQxaWpVMzFQc2xIcitmbXZQbUt6QTljVCtCVms2Ry9FV3g3Umla?=
 =?utf-8?B?WlRtYVcrV1d6SFZWUDVlSTQrZlYydVYwL1lrV1ZkTDBUQTEyelNhcjQwelRk?=
 =?utf-8?B?MDB5Y3ZyNllOeklDczQwQzVDZDVXVWtNdklSZEQyM0RzWGg1b091eS9iV1Zx?=
 =?utf-8?B?S0xZMTIwd0EvVXNqdXY3WFVKVmpBaEdRVXpGdzBqcGVXNHFFempjdHErV3BV?=
 =?utf-8?B?MmxPdGl6MVVURml0aFVwWkpZSis4d3JmU3hZa252YzlrZ3FCd3huTEZmZDQw?=
 =?utf-8?B?bUx3N0FvbEdrSUR6cU1mQ3pMNzYyMnZlUTBEbi9STVZob3ZPQVNJd2dZQVBL?=
 =?utf-8?B?LytYL1FvN3dSQjlrRHRWNmp1eU9ndkZKQTA0NElCOVdRdk9Sc3EySm82N0hr?=
 =?utf-8?B?dTJWUG5tQnhvbDRnaWdIeEI3Mm9jZlFmaGt0WHFEWm9tYU1uaW9xaEhoUlVX?=
 =?utf-8?B?YzZ5YWNxS2FWNmNRaHpQdDczbGRWN3dIZjFMTTlJcURDMFAycW5jNG8yRDkw?=
 =?utf-8?B?Mm1XV093cGkxN0lZSnRKK3Y4cmZVMlJHbUJaZW96cHoxbnZIT0lNbXl5MEhv?=
 =?utf-8?B?Rk5aTHlmSk8xVlZ0OG5NQWFOVDd5RHFIMDVQZDk2aDlkbTN2YmJQZThpWFdO?=
 =?utf-8?B?N0g5bHNqQ041Z29ZNWVGeU43QzN3VnNYbzJSSmJ2K3pXTFpKMS82N3JlaHhH?=
 =?utf-8?B?TDZXYnVzRFhmVFZuMjVvY0ZyZk9Ibk5XeW1MaEtMUm5lanNDZzRJRlJjUTNB?=
 =?utf-8?B?Z2dyMTNadHRJVENIamQ5SHFMdXpqNTkvTjNDS3VpSCtOQ1NJeGhQVGlXYUlk?=
 =?utf-8?B?ZHhoOXJROHgrS0duWGhkdWE4cmhYQ0hGT0lHa1RZbWJJNFB3QmN3Z0hrMWJC?=
 =?utf-8?Q?cDN4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed49d72-c45e-43ba-01c1-08dc5fa27e24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 12:24:28.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: us1dXl3oeNs4+eofY21wHt8Qc9iuC5E3Slt0lDf3mFlSq/dYUZDL6oGCNVcx23Gh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439

Am 18.04.24 um 12:42 schrieb Dag B:
>
> [SNIP]
>>
>>>>
>>>> Is there a good ELI13 resource explaining how resizable BAR works 
>>>> in Linux?
>>>>
>>>> My current kernel command-line contains: pci=assign-busses,realloc
>>
>> That's a really really bad idea. The "assign-busses" flag was 
>> introduced to get 20year old laptops to see their cardbus PCI devices.
>
> I threw a lot of mud at the wall to see what stuck. Removing it now 
> did not make a big difference.
>
> Removing realloc prevents the second TB3 GPU from being initialized, 
> so keeping that for now.

That's really interesting. Why does it fail without that?

It basically means that your BIOS is somehow broken and only the Linux 
PCI subsystem is able to assign resources correctly.

Please provide the output of "sudo lspci -v" and "sudo lspci -tv" as 
file attachment (*not* inline in a mail!).

>>>> My GPU is attached via TB3 to a system for which resizable BAR is 
>>>> and will
>>>> remain a foreign concept in the BIOS.
>>
>> What happens if you hot remove and re-plug the TB3 after the system 
>> has started?
>>
> Much the same as during initial boot. Both good and bad. See below.
>
>
> Do any of the pci=hp* options have any significance/impact on what 
> dmesg says below?

No, the pci=hp* options are a hint for the PCI subsystem how much 
address space to assign to each hot plugged bridge and device from the 
upstream bridge.

But if your BIOS doesn't assign anything to the upstream bridge or your 
don't have a window big enough on the root complex you are pretty much 
busted from the beginning.

And that you get all those "pnp 00:0b: disabling" message also doesn't 
makes the BIOS trustworthy.

>
> Is IO address space moveable?

No, the IO address space is usually only assigned when the device starts 
with VGA emulation. And as long as VGA emulation is active you can't 
move or resize anything.

What drivers usually do is to turn of the VGA emulation (which also 
disables the IO address space) and then resize.

> Relevant kernel config/options impacting this? Is it all in the hands 
> of the device driver?

Well the pci=hp* options are already all you need. But I don't think 
they will help in this case here.

>
> So, so many questions. And barely competent to ask them. Please 
> forgive me.
>
>
> Current kernel command-line snippet: 
> pci=realloc,hpiosize=16K,hpmemsize=64M,pcie_scan_all,hpbussize=0x33
>
>
> I very much appreciate your input. Will try to get the attention of 
> the people responsible for the driver.
>
>
> Thanks,
>
>
> Dag B
>
>
> p53 ~ # dmesg | grep 09:00.0
> [    0.471780] pci 0000:09:00.0: [10de:2204] type 00 class 0x030000 
> PCIe Legacy Endpoint
> [    0.471816] pci 0000:09:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
> [    0.471844] pci 0000:09:00.0: BAR 1 [mem 0x00000000-0x0fffffff 
> 64bit pref]
> [    0.471873] pci 0000:09:00.0: BAR 3 [mem 0x00000000-0x01ffffff 
> 64bit pref]
> [    0.471890] pci 0000:09:00.0: BAR 5 [io  0x0000-0x007f]
> [    0.471907] pci 0000:09:00.0: ROM [mem 0x00000000-0x0007ffff pref]
> [    0.472133] pci 0000:09:00.0: PME# supported from D0 D3hot
> [    0.472382] pci 0000:09:00.0: 8.000 Gb/s available PCIe bandwidth, 
> limited by 2.5 GT/s PCIe x4 link at 0000:05:01.0 (capable of 252.048 
> Gb/s with 16.0 GT/s PCIe x16 link)
> [    0.491866] pci 0000:09:00.0: vgaarb: bridge control possible
> [    0.491866] pci 0000:09:00.0: vgaarb: VGA device added: 
> decodes=io+mem,owns=none,locks=none
> [    0.491866] pnp 00:03: disabling [io  0x002e-0x002f] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:03: disabling [io  0x004e-0x004f] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:03: disabling [io  0x0061] because it overlaps 
> 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:03: disabling [io  0x0063] because it overlaps 
> 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:03: disabling [io  0x0065] because it overlaps 
> 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:03: disabling [io  0x0067] because it overlaps 
> 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:03: disabling [io  0x0070] because it overlaps 
> 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x0010-0x001f] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x0024-0x0025] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x0028-0x0029] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x002c-0x002d] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x0030-0x0031] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x0034-0x0035] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x0038-0x0039] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x003c-0x003d] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x0050-0x0053] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.491866] pnp 00:08: disabling [io  0x0072-0x0077] because it 
> overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
> [    0.493216] pnp 00:0b: disabling [mem 0x00000000-0x0009ffff] 
> because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
> [    0.493220] pnp 00:0b: disabling [mem 0x000c0000-0x000c3fff 
> disabled] because it overlaps 0000:09:00.0 BAR 0 [mem 
> 0x00000000-0x00ffffff]
> [    0.493225] pnp 00:0b: disabling [mem 0x000c8000-0x000cbfff 
> disabled] because it overlaps 0000:09:00.0 BAR 0 [mem 
> 0x00000000-0x00ffffff]
> [    0.493230] pnp 00:0b: disabling [mem 0x000d0000-0x000d3fff 
> disabled] because it overlaps 0000:09:00.0 BAR 0 [mem 
> 0x00000000-0x00ffffff]
> [    0.493234] pnp 00:0b: disabling [mem 0x000d8000-0x000dbfff 
> disabled] because it overlaps 0000:09:00.0 BAR 0 [mem 
> 0x00000000-0x00ffffff]
> [    0.493238] pnp 00:0b: disabling [mem 0x000e0000-0x000e3fff] 
> because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
> [    0.493242] pnp 00:0b: disabling [mem 0x000e8000-0x000ebfff] 
> because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
> [    0.493247] pnp 00:0b: disabling [mem 0x000f0000-0x000fffff] 
> because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
> [    0.493251] pnp 00:0b: disabling [mem 0x00100000-0x8f7fffff] 
> because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
> [    0.493255] pnp 00:0b: disabling [mem 0x00000000-0x0009ffff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493260] pnp 00:0b: disabling [mem 0x000c0000-0x000c3fff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493265] pnp 00:0b: disabling [mem 0x000c8000-0x000cbfff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493270] pnp 00:0b: disabling [mem 0x000d0000-0x000d3fff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493274] pnp 00:0b: disabling [mem 0x000d8000-0x000dbfff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493279] pnp 00:0b: disabling [mem 0x000e0000-0x000e3fff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493283] pnp 00:0b: disabling [mem 0x000e8000-0x000ebfff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493288] pnp 00:0b: disabling [mem 0x000f0000-0x000fffff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493292] pnp 00:0b: disabling [mem 0x00100000-0x8f7fffff 
> disabled] because it overlaps 0000:09:00.0 BAR 1 [mem 
> 0x00000000-0x0fffffff 64bit pref]
> [    0.493297] pnp 00:0b: disabling [mem 0x00000000-0x0009ffff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.493302] pnp 00:0b: disabling [mem 0x000c0000-0x000c3fff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.493306] pnp 00:0b: disabling [mem 0x000c8000-0x000cbfff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.493311] pnp 00:0b: disabling [mem 0x000d0000-0x000d3fff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.493315] pnp 00:0b: disabling [mem 0x000d8000-0x000dbfff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.493320] pnp 00:0b: disabling [mem 0x000e0000-0x000e3fff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.493324] pnp 00:0b: disabling [mem 0x000e8000-0x000ebfff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.493329] pnp 00:0b: disabling [mem 0x000f0000-0x000fffff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.493333] pnp 00:0b: disabling [mem 0x00100000-0x8f7fffff 
> disabled] because it overlaps 0000:09:00.0 BAR 3 [mem 
> 0x00000000-0x01ffffff 64bit pref]
> [    0.503894] pci 0000:09:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
> 64bit pref]: assigned
> [    0.503940] pci 0000:09:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
> 64bit pref]: assigned
> [    0.503963] pci 0000:09:00.0: BAR 0 [mem 0xa4000000-0xa4ffffff]: 
> assigned
> [    0.503972] pci 0000:09:00.0: ROM [mem 0xa5000000-0xa507ffff pref]: 
> assigned
> [    0.503984] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [    0.503987] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [    0.504331] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [    0.504334] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [    0.504704] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [    0.504707] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [    0.505073] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [    0.505076] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [    0.505441] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [    0.505444] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [    0.505810] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [    0.505813] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [    0.507057] pci 0000:09:00.1: D0 power state depends on 0000:09:00.0
> [    0.509437] pci 0000:09:00.0: Adding to iommu group 23
> [    2.833427] nvidia 0000:09:00.0: enabling device (0000 -> 0002)
> [    2.833519] nvidia 0000:09:00.0: vgaarb: VGA decodes changed: 
> olddecodes=io+mem,decodes=none:owns=none
> [    4.954613] [drm] Initialized nvidia-drm 0.0.0 20160202 for 
> 0000:09:00.0 on minor 2
> [  228.414765] NVRM: GPU 0000:09:00.0: GPU has fallen off the bus.
> [  228.445633] pci 0000:09:00.0: Unable to change power state from 
> unknown to D0, device inaccessible
> [  233.991103] pci 0000:09:00.0: [10de:2204] type 00 class 0x030000 
> PCIe Legacy Endpoint
> [  233.993053] pci 0000:09:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
> [  233.994986] pci 0000:09:00.0: BAR 1 [mem 0x00000000-0x0fffffff 
> 64bit pref]
> [  233.996854] pci 0000:09:00.0: BAR 3 [mem 0x00000000-0x01ffffff 
> 64bit pref]
> [  233.998727] pci 0000:09:00.0: BAR 5 [io  0x0000-0x007f]
> [  234.000585] pci 0000:09:00.0: ROM [mem 0x00000000-0x0007ffff pref]
> [  234.002720] pci 0000:09:00.0: PME# supported from D0 D3hot
> [  234.004889] pci 0000:09:00.0: 8.000 Gb/s available PCIe bandwidth, 
> limited by 2.5 GT/s PCIe x4 link at 0000:05:01.0 (capable of 252.048 
> Gb/s with 16.0 GT/s PCIe x16 link)
> [  234.007000] pci 0000:09:00.0: Adding to iommu group 23
> [  234.008925] pci 0000:09:00.0: vgaarb: bridge control possible
> [  234.010828] pci 0000:09:00.0: vgaarb: VGA device added: 
> decodes=io+mem,owns=none,locks=none
> [  234.087850] pci 0000:09:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
> 64bit pref]: assigned
> [  234.089631] pci 0000:09:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
> 64bit pref]: assigned
> [  234.091492] pci 0000:09:00.0: BAR 0 [mem 0xa4000000-0xa4ffffff]: 
> assigned
> [  234.093241] pci 0000:09:00.0: ROM [mem 0xa5000000-0xa507ffff pref]: 
> assigned
> [  234.096831] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [  234.098652] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [  234.155043] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [  234.156615] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [  234.183809] nvidia 0000:09:00.0: enabling device (0000 -> 0002)
> [  234.185579] nvidia 0000:09:00.0: vgaarb: VGA decodes changed: 
> olddecodes=io+mem,decodes=none:owns=none
> [  234.310173] pci 0000:09:00.1: D0 power state depends on 0000:09:00.0
>
>
>
> And doing the same for the 2nd GPU:
>
> p53 ~ # dmesg | grep 2f:00.0
> [    1.215862] pci 0000:2f:00.0: [10de:2204] type 00 class 0x030000 
> PCIe Legacy Endpoint
> [    1.215893] pci 0000:2f:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
> [    1.215918] pci 0000:2f:00.0: BAR 1 [mem 0x00000000-0x0fffffff 
> 64bit pref]
> [    1.215942] pci 0000:2f:00.0: BAR 3 [mem 0x00000000-0x01ffffff 
> 64bit pref]
> [    1.215956] pci 0000:2f:00.0: BAR 5 [io  0x0000-0x007f]
> [    1.215970] pci 0000:2f:00.0: ROM [mem 0x00000000-0x0007ffff pref]
> [    1.216765] pci 0000:2f:00.0: PME# supported from D0 D3hot
> [    1.217000] pci 0000:2f:00.0: 8.000 Gb/s available PCIe bandwidth, 
> limited by 2.5 GT/s PCIe x4 link at 0000:05:04.0 (capable of 252.048 
> Gb/s with 16.0 GT/s PCIe x16 link)
> [    1.217226] pci 0000:2f:00.0: Adding to iommu group 29
> [    1.217237] pci 0000:2f:00.0: vgaarb: bridge control possible
> [    1.217238] pci 0000:2f:00.0: vgaarb: VGA device added: 
> decodes=io+mem,owns=none,locks=none
> [    1.218458] pci 0000:2f:00.0: BAR 1 [mem 0x6020000000-0x602fffffff 
> 64bit pref]: assigned
> [    1.218481] pci 0000:2f:00.0: BAR 3 [mem 0x6030000000-0x6031ffffff 
> 64bit pref]: assigned
> [    1.218501] pci 0000:2f:00.0: BAR 0 [mem 0xb1000000-0xb1ffffff]: 
> assigned
> [    1.218507] pci 0000:2f:00.0: ROM [mem 0xb0800000-0xb087ffff pref]: 
> assigned
> [    1.218514] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [    1.218514] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [    1.218579] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [    1.218580] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [    1.219748] pci 0000:2f:00.1: D0 power state depends on 0000:2f:00.0
> [    2.883186] nvidia 0000:2f:00.0: enabling device (0000 -> 0002)
> [    2.883945] nvidia 0000:2f:00.0: vgaarb: VGA decodes changed: 
> olddecodes=io+mem,decodes=none:owns=none
> [    6.367931] [drm] Initialized nvidia-drm 0.0.0 20160202 for 
> 0000:2f:00.0 on minor 3
> [  485.913085] NVRM: GPU 0000:2f:00.0: GPU has fallen off the bus.
> [  485.913727] NVRM: GPU 0000:2f:00.0: GPU serial number is 
> PKWUQ0B9VFK0SG.
> [  485.938963] pci 0000:2f:00.0: Unable to change power state from 
> unknown to D0, device inaccessible
> [  489.941767] pci 0000:2f:00.0: [10de:2204] type 00 class 0x030000 
> PCIe Legacy Endpoint
> [  489.944551] pci 0000:2f:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
> [  489.947287] pci 0000:2f:00.0: BAR 1 [mem 0x00000000-0x0fffffff 
> 64bit pref]
> [  489.950056] pci 0000:2f:00.0: BAR 3 [mem 0x00000000-0x01ffffff 
> 64bit pref]
> [  489.952835] pci 0000:2f:00.0: BAR 5 [io  0x0000-0x007f]
> [  489.955655] pci 0000:2f:00.0: ROM [mem 0x00000000-0x0007ffff pref]
> [  489.958721] pci 0000:2f:00.0: PME# supported from D0 D3hot
> [  489.961746] pci 0000:2f:00.0: 8.000 Gb/s available PCIe bandwidth, 
> limited by 2.5 GT/s PCIe x4 link at 0000:05:04.0 (capable of 252.048 
> Gb/s with 16.0 GT/s PCIe x16 link)
> [  489.964859] pci 0000:2f:00.0: Adding to iommu group 29
> [  489.967703] pci 0000:2f:00.0: vgaarb: bridge control possible
> [  489.970506] pci 0000:2f:00.0: vgaarb: VGA device added: 
> decodes=io+mem,owns=none,locks=none
> [  490.025678] pci 0000:2f:00.0: BAR 1 [mem 0x6020000000-0x602fffffff 
> 64bit pref]: assigned
> [  490.027887] pci 0000:2f:00.0: BAR 3 [mem 0x6030000000-0x6031ffffff 
> 64bit pref]: assigned
> [  490.029918] pci 0000:2f:00.0: BAR 0 [mem 0xb1000000-0xb1ffffff]: 
> assigned
> [  490.031940] pci 0000:2f:00.0: ROM [mem 0xb0800000-0xb087ffff pref]: 
> assigned
> [  490.036008] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [  490.038096] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [  490.075208] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: can't 
> assign; no space
> [  490.077005] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: failed to 
> assign
> [  490.099288] nvidia 0000:2f:00.0: enabling device (0000 -> 0002)
> [  490.101217] nvidia 0000:2f:00.0: vgaarb: VGA decodes changed: 
> olddecodes=io+mem,decodes=none:owns=none
> [  490.265952] pci 0000:2f:00.1: D0 power state depends on 0000:2f:00.0
>
>
> BAR 5 is missing in the lspci output. Same for both.
>
> lspci specifies 'Physical Resizable'. Is that implied for all BARs?

No, that means only BAR1 is resizeable.

Regards,
Christian.

>
>     Capabilities: [bb0 v1] Physical Resizable BAR
>         BAR 0: current size: 16MB, supported: 16MB
>         BAR 1: current size: 256MB, supported: 64MB 128MB 256MB 512MB 
> 1GB 2GB 4GB 8GB 16GB 32GB
>         BAR 3: current size: 32MB, supported: 32MB
>
>


