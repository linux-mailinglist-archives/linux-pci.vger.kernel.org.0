Return-Path: <linux-pci+bounces-6402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AEA8A9473
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 09:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952B91C216D3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 07:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25391757EE;
	Thu, 18 Apr 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D1vpCUSa"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F870CAA
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426689; cv=fail; b=RwcmobrmZQz5v2+PdAlr8ygIIOVJi/XWdTRBWPuPURCainHEmqlweAW9yGYEMp0BDev8RkPXwSH0bGL/8ITENOAplNwGhG+5nepE3Qj42NO9+R1+GrEA9IhyvnU6UHfVAbr2vguEVjhFaR+nYQ2ldRzRLKpz9HjVK42ajnIpI4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426689; c=relaxed/simple;
	bh=r5/YvA4FL+cZTYzREEfn5+8EAnUn9ezsCtSmkL5g6Z0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dog29GMrwNmFLwfT42O0Juw7Sdqejyc6gdHWmQvK2iJGN8/vzbmlPVD7EOrIyBxKr/1mHvI4HqS79pJM2KIAE1Zg5jbZ2VLHIIagoXYv5gZn21pP6ALFDRbd/S0pR0JIk6h56crrV10qX4CUHzzAfdEh8KJ75BrusShA2Qok6iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D1vpCUSa; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEXp/pBR9ZrxPDX9vfqZLiI+h8USGVXhFsKNv/CFbe+B9PK3EKgczohRBBoOkKQDksa15zt++1GJLtRxy4GNOTrsHqrEu/tlhpvk1iPlozUizEgmVfTTrKV3SyWUteWiVFqrMPp0Bq+T0KyKLwmuNTdJR5ztTZiwETvWTDRkXhmlOTKYJysQx9Kol07GYlPjsl6m/L9zFWP25XL2NaE1IhweqrPndNEQ7vOFEBYrpau7fq5JBmmI+BH9owG8IPAenq/6uIUN1XXp2AIiOOQf1vAopXeIreboad7Y0Sne0yR0r9rgllkU+DzC2xAcDdSn0mlnixgh8BRaQYKge0FPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSpDkNflKXiDJqUZcEKX5m3/02xeU5gpwy+6K94a4p0=;
 b=gMC9uFFSRFmSaHQWKtG5IaGEgE99ELaUxR6Hjb1thZDYE9w9Y/jwvouUvQAHqpFE3H/LFPjT//VGLww17TyHW9hPx2oJGF4Z7qDUGCvtwFgKc0FgT7g/Z7KJuDrlrlxgZ40NmWL4HN3mV5FqeeygV9NjEC1EufDpR+fmd4S0SvLjVF3Ss3FX/rX291OnpbR/WMv3ByphzxEsW63cqpzl9sKaEzlQgUdfYhHdrzbn1A6f22Y3XSV+ifh5/ycjjsgL3da3zrvjaCP+vkPOIVOJhPEU86LQWt6WLDy+zfiZFkF7gkBI0LIOzm91Tct4KzEXCnXW2mA+c0vwCxpaSq5liQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSpDkNflKXiDJqUZcEKX5m3/02xeU5gpwy+6K94a4p0=;
 b=D1vpCUSa9pCIPkSoPu2XL4LWI73iQ9PQKvPCet0TTJvkoH92TymVc1lTacf+O1baJAyvB1TyXUTZYctQX3bMLqPFx9i2iFDITpr4k7mE0XtUPNbQoitJqFtZzcvLj36nSFj34u+YHqNleYh6DggXXWpP6s9/vcdOfONrjh/mp/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 07:51:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:51:23 +0000
Message-ID: <d509c9e6-37be-44ab-8f47-6fe55397794e@amd.com>
Date: Thu, 18 Apr 2024 09:51:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: PCIE BAR resizing blocked by another BAR on same device?
To: Bjorn Helgaas <helgaas@kernel.org>, Dag B <dag@bakke.com>
Cc: linux-pci@vger.kernel.org
References: <20240417151313.GA202307@bhelgaas>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240417151313.GA202307@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::6) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc5b631-5b21-46f5-6a79-08dc5f7c575c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JJyXgyGUye1WRuHOk7cm/YYP1oWhV2V9oLr7avwg2c890mi6rxYKyFRfPdmi08xOIgMOjSRkQAxyLy0KZyvQqmIirJz/BJgzDtGUJuUZW/z0dhbVzDnc9NVyjgmOgEISmQn2HlIE4UesHJaSLX1vn73bkC8o9IgrSuDv1yCBScu7OFTlZHI56nFL+3npJmyAiiiak1K+q6y9DxotE+4WZ2FnSnGOXboooiDtAOOe2+1qRE5SMxpsCZy1fGAtz8aRPVfJ1rXgOUB+2e/ifARr667mdtEmcZxGP5L+CXC6TCbmSbMwxSaepXTZZUn4vFHXC8V+fQ93kQAXfFp2+uffnAVBYbftyAP5TKEwVEeBd1ekH9zoG9l9nTmyhpLEVZoVu6bpzP0d8cBBUT4NCE4oaB/fYwOhki4HHJZVycuiD4YdVDmnm9CwL5rvdgkq1m9klUyxqrvYaiBLJV4aOIYAfuF8iwKE/HAG+iPILCfFkDfLUu0rmfzS80KrHWFtLAm2RgbHxkaBiT4V8Ny7ojBXe/D7BM4KLmlBqkX61Htned0WOSblkDFIA18oo7P0SDjHiqapzOjL1xfdivng9sNYoWk8dp1SS5nPz3AkOFgHdC25Ex+XVphvhgsfhzAO3RMsE1HoAMKiaK+wdlCil/rtbudnoMI7aKmIPn7sv1wMxqQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBkd2xYc1hxRHE1YW1RWWpxTHdRUTh4RkFZdVRpdDBYbnpEUDc2S01SSGNm?=
 =?utf-8?B?RjJXS2N3NFAzeWJRWFBkYkxxS1l6U08waXhCcTJFRkFqQUU1STV1SUx3TWtV?=
 =?utf-8?B?WFhZWHFlL1NEZ0NZZEFKS3RZTjVUUit3OUE1VCsrZDdXa3lPNVJLQTFXUnV1?=
 =?utf-8?B?c2N5eWlFd1ZBWnNaVVFhc2tqb205Ni9NQzVFNjRhVWpjUWRDWjZxOExrbUo2?=
 =?utf-8?B?VW1tN2tzOWpyN2E0bjBuLzN1dWs0eTh3WEQ3OCtKWHA2UVhiTU95aG1mREln?=
 =?utf-8?B?c1plbHRqVDFGdU1SQmFkbjdSVVY4UCttRkhsYitjbDBDSzd2OTkxWS9hbGYz?=
 =?utf-8?B?cmlmdWZmZUd3V1kxa0hnMmFTaDVsVEwrTVEvMERTQmZOb0dqNlRvcGl0RnlR?=
 =?utf-8?B?OEtKZXJUU3pQUzNVUGFIeHNvaWFoVjNBMWxFbVp5dHFDRFdjTUZtTXJoUVg4?=
 =?utf-8?B?QmYrL0E4TWtLY2hIbkZsVnduSGNCTnF4aUVrWXBlMjdLWlkyc2t5SmxkZFox?=
 =?utf-8?B?dHJSVlVveEZpejJQR2syWGVsTkl4c28vcHJLaDlrUTF6ZVRTNkx5UHpBcUZZ?=
 =?utf-8?B?NXR0TjhtM1ZWbVUvMk1idzRHMmVvQ0s3dm9HUHBYclA3R3RhUjEyQkxmWnJ5?=
 =?utf-8?B?dUFURVZLUHdHMmJ5RkJpYVlab3lVaTRIeXpoYXU2NEIyaEdZWW40MTh6ZFNz?=
 =?utf-8?B?SHdUZzMvNHFRMDdhYVBGbUNublEyMWNwa3gvTDlxUExtZTVQYThPaHYyY3M0?=
 =?utf-8?B?OERtSlhmL0hkbkRKbE4xUGxXL3FCOEFnWk1WWitQWUZraUdDc1VWNFNSOU5T?=
 =?utf-8?B?aldORWxqZnN5MUdCZU5PZlR3eVp2dnNNZXFGUHM5MjJmbmozd24wcEZkSllk?=
 =?utf-8?B?Nk1NQnJHUy92amZyR05rVXRTSDlKL0tpZnpSdGZOdjZyK0o1dVBKaXhwVlF2?=
 =?utf-8?B?WWpvYUxGUklZUWJhNW4yTnI4b20yNzNUbVpNVStPRlJpYW00VGlPd0VjMUVj?=
 =?utf-8?B?dStTMjNaN2lHb2o5SEdyUU1rRloxWXJQdUk3OVJCWDhUL0JXWU80RjhZV1Nh?=
 =?utf-8?B?Y3NQM1RjeVJBa1V2L1h2eERnSlVGMldVMTBoclBzNSs5YnVYQ3BpOStPWDV6?=
 =?utf-8?B?V1V0WTBJaFBIYWs1SmZIek8wWmRDemoza3JSZUdWcGlXVEFmSGt2TVUxSTZl?=
 =?utf-8?B?c21kRTJrdzFTZlg2U243YktPUEZjYWg0RkZxdWxwVU9qdjJ0MlNOdi9IU0Fs?=
 =?utf-8?B?dm9mSzVleVBPQjlRdHplTll4TnZKZ2ZHSUQyL2ZBNklPcWRqa2ZjY2JSWGdt?=
 =?utf-8?B?ZzcwVU9yUHB0dW9JYytpOENSelplWFhMamx4bzdUaGVHZWdoNlZPTVVHejZ4?=
 =?utf-8?B?MTgxMzV3anAwdVVTbG5LK3NKYkpESzllSUtkMU5KenF5TzNlZnkyYi9EZEMx?=
 =?utf-8?B?azdaSzVScUJ5RnNPY1g4UVZLQWRMdi9zT2FxRktBRmZzSnI4aXJwU0xxVGtW?=
 =?utf-8?B?bnhoTm1DenVTKy9RL0Z0Rm9DOHhzTXlsN1Vab0ZYWHgxYmZxcEJneXJLZFU4?=
 =?utf-8?B?N24xUUFLeW9iQ1pMTkZkT0VEcUxZZm1NN3pGekFRbUJtN0hnM0lUbG9CUnBv?=
 =?utf-8?B?NHBiZG1NbmhsTGhjYTJBZGpSSVFXYVltOXQrQVNQYUJ1Tm16VU5NRWxQSWF1?=
 =?utf-8?B?eUZhRk5nc3RZZ2RucThCUENMQnVDNHBWdGtrZWdnd3c2SExuWTZPWisrRGl4?=
 =?utf-8?B?UmZ2NUZBVWExUFFMUEZUYUV6YWZLT0hoKzNiZVQ3K1ZzeDVWQXBaODdCY1Np?=
 =?utf-8?B?Q2ZyK2JXMWhYS09TYXBWYXYyeU1oSjI1U0ZibXN6QzNYa0Q0ckJaY1A2R0Rz?=
 =?utf-8?B?U0p5TkRyMERTUU80b1dLd3k0eEhOZVIxQzlpQW5RZ2l2QzlnMC96VTR1OHl1?=
 =?utf-8?B?OUtVTVIwelRkZ0RPT1FtcTZVdGlDQTZCSE5GNGZNZThxWXowNE54cVVaMkJT?=
 =?utf-8?B?VkoyNFhMdHhWSmVsbytDYjZId3ZSWHUyZFIvS0NUYlQrcnQ2U3ZwL1pueWsy?=
 =?utf-8?B?ekFmQmhXV1RqcGhua2lOc0tnRjhlWFdibjdmY0lBTUdLVFh6NGlvZ0lwL1ll?=
 =?utf-8?Q?dhlQKTm3BxO7Y6nTxTiBVmvFP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc5b631-5b21-46f5-6a79-08dc5f7c575c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:51:23.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ60b480KRrqj/bDJgF3olXIYWGp5/+1Sj0AWxGnxQUuM2V3h4vrqxB3msM3bMAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451

Hi Dag and Bjorn,

Am 17.04.24 um 17:13 schrieb Bjorn Helgaas:
> [+to Christian, resizable BAR expert]
>
> On Wed, Apr 17, 2024 at 03:16:06PM +0200, Dag B wrote:
>> Hi.
>>
>> In short, I have a GPU for which lspci reveals:
>>
>> Capabilities: [bb0 v1] Physical Resizable BAR
>>
>>          BAR 0: current size: 16MB, supported: 16MB
>>          BAR 1: current size: 128MB, supported: 64MB 128MB 256MB 512MB 1GB
>> 2GB 4GB 8GB 16GB 32GB
>>          BAR 3: current size: 32MB, supported: 32MB
>>
>> In dmesg I see:
>>
>> [    0.517191] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 64bit
>> pref]: assigned
>> [    0.517238] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 64bit
>> pref]: assigned
>> [    0.517261] pci 0000:08:00.0: BAR 0 [mem 0xa4000000-0xa4ffffff]: assigned
>>
>> I take it the location of BAR 3 right after BAR 1 explains why I get:
>>
>> p53 # echo 9 > resource1_resize
>> -bash: echo: write error: No space left on device
>>
>> Shrinking it and increasing it to the orginal size works.
>>
>>
>> Is there anything I can do with current kernel functionality to reserve
>> memory address space for the full-fat BAR 1? Or relocate it?

No, sorry. The BARs have to be released and re-assigned all at the same 
time for this to work correctly.

That's one of the reasons why we choose to do this in the driver during 
the load process instead of the PCI subsystem.

The sysfs functionality is more or less just for testing.

>> If not, is this something which *can* be worked around in the kernel? And if
>> so, does it belong with the PCI subsystem? Or the devicedriver for the
>> device in question?

The device driver is the only place where you know all the hw specific 
things necessary to release a device BAR and eventually move and resize 
upstream bridges.

>>
>> Is there a good ELI13 resource explaining how resizable BAR works in Linux?
>>
>> My current kernel command-line contains: pci=assign-busses,realloc

That's a really really bad idea. The "assign-busses" flag was introduced 
to get 20year old laptops to see their cardbus PCI devices.

On modern systems specifying this flag breaks a lot of ACPI handling 
because we can no longer match ACPI devices to their PCI counterparts 
because all the bus numbers have changed.

While it might get things working temporary if you have to use this 
option then please replace your BIOS. It's not really a doable to use 
this on modern hw.

>> My GPU is attached via TB3 to a system for which resizable BAR is and will
>> remain a foreign concept in the BIOS.

What happens if you hot remove and re-plug the TB3 after the system has 
started?

Regards,
Christian.

>>
>> dmesg excerpt below reflects resizing the BAR to 128MB and then back to
>> 256MB.
>>
>> [ 1730.091789] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 64bit
>> pref]: releasing
>> [ 1730.091875] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 64bit
>> pref]: releasing
>> [ 1730.092072] pcieport 0000:07:01.0: bridge window [mem
>> 0x6000000000-0x6017ffffff 64bit pref]: releasing
>> [ 1730.092151] pcieport 0000:07:01.0: bridge window [mem
>> 0x6000000000-0x6017ffffff 64bit pref]: assigned
>> [ 1730.092223] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 64bit
>> pref]: assigned
>> [ 1730.092335] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 64bit
>> pref]: assigned
>> [ 1730.092444] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
>> [ 1730.092510] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
>> [ 1730.092595] pcieport 0000:06:00.0:   bridge window [mem
>> 0xa4000000-0xafffffff]
>> [ 1730.092680] pcieport 0000:06:00.0:   bridge window [mem
>> 0x6000000000-0x601fffffff 64bit pref]
>> [ 1730.092778] pcieport 0000:07:01.0: PCI bridge to [bus 08]
>> [ 1730.092850] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
>> [ 1730.092933] pcieport 0000:07:01.0:   bridge window [mem
>> 0xa4000000-0xa57fffff]
>> [ 1730.093018] pcieport 0000:07:01.0:   bridge window [mem
>> 0x6000000000-0x6017ffffff 64bit pref]
>> [ 1759.817306] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 64bit
>> pref]: releasing
>> [ 1759.817394] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 64bit
>> pref]: releasing
>> [ 1759.817591] pcieport 0000:07:01.0: bridge window [mem
>> 0x6000000000-0x6017ffffff 64bit pref]: releasing
>> [ 1759.817668] pcieport 0000:07:01.0: bridge window [mem
>> 0x6000000000-0x600bffffff 64bit pref]: assigned
>> [ 1759.817740] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 64bit
>> pref]: assigned
>> [ 1759.817853] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 64bit
>> pref]: assigned
>> [ 1759.817964] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
>> [ 1759.818035] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
>> [ 1759.818120] pcieport 0000:06:00.0:   bridge window [mem
>> 0xa4000000-0xafffffff]
>> [ 1759.818204] pcieport 0000:06:00.0:   bridge window [mem
>> 0x6000000000-0x601fffffff 64bit pref]
>> [ 1759.818303] pcieport 0000:07:01.0: PCI bridge to [bus 08]
>> [ 1759.818374] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
>> [ 1759.818459] pcieport 0000:07:01.0:   bridge window [mem
>> 0xa4000000-0xa57fffff]
>> [ 1759.818544] pcieport 0000:07:01.0:   bridge window [mem
>> 0x6000000000-0x600bffffff 64bit pref]
>> [ 1769.797178] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 64bit
>> pref]: releasing
>> [ 1769.797241] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 64bit
>> pref]: releasing
>> [ 1769.797417] pcieport 0000:07:01.0: bridge window [mem
>> 0x6000000000-0x600bffffff 64bit pref]: releasing
>> [ 1769.797473] pcieport 0000:07:01.0: bridge window [mem size 0x30000000
>> 64bit pref]: can't assign; no space
>> [ 1769.797515] pcieport 0000:07:01.0: bridge window [mem size 0x30000000
>> 64bit pref]: failed to assign
>> [ 1769.797557] pci 0000:08:00.0: BAR 1 [mem size 0x20000000 64bit pref]:
>> can't assign; no space
>> [ 1769.797594] pci 0000:08:00.0: BAR 1 [mem size 0x20000000 64bit pref]:
>> failed to assign
>> [ 1769.797630] pci 0000:08:00.0: BAR 3 [mem size 0x02000000 64bit pref]:
>> can't assign; no space
>> [ 1769.797666] pci 0000:08:00.0: BAR 3 [mem size 0x02000000 64bit pref]:
>> failed to assign
>> [ 1769.797703] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
>> [ 1769.797761] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
>> [ 1769.797829] pcieport 0000:06:00.0:   bridge window [mem
>> 0xa4000000-0xafffffff]
>> [ 1769.797895] pcieport 0000:06:00.0:   bridge window [mem
>> 0x6000000000-0x601fffffff 64bit pref]
>> [ 1769.797972] pcieport 0000:07:01.0: PCI bridge to [bus 08]
>> [ 1769.798027] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
>> [ 1769.798089] pcieport 0000:07:01.0:   bridge window [mem
>> 0xa4000000-0xa57fffff]
>> [ 1769.798155] pcieport 0000:07:01.0:   bridge window [mem
>> 0x6000000000-0x600bffffff 64bit pref]
>> [ 1769.798270] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 64bit
>> pref]: assigned
>> [ 1769.798358] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 64bit
>> pref]: assigned
>> [ 2669.324929] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 64bit
>> pref]: releasing
>> [ 2669.324992] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 64bit
>> pref]: releasing
>> [ 2669.325164] pcieport 0000:07:01.0: bridge window [mem
>> 0x6000000000-0x600bffffff 64bit pref]: releasing
>> [ 2669.325219] pcieport 0000:07:01.0: bridge window [mem size 0x30000000
>> 64bit pref]: can't assign; no space
>> [ 2669.327023] pcieport 0000:07:01.0: bridge window [mem size 0x30000000
>> 64bit pref]: failed to assign
>> [ 2669.328798] pci 0000:08:00.0: BAR 1 [mem size 0x20000000 64bit pref]:
>> can't assign; no space
>> [ 2669.330482] pci 0000:08:00.0: BAR 1 [mem size 0x20000000 64bit pref]:
>> failed to assign
>> [ 2669.331104] pci 0000:08:00.0: BAR 3 [mem size 0x02000000 64bit pref]:
>> can't assign; no space
>> [ 2669.331682] pci 0000:08:00.0: BAR 3 [mem size 0x02000000 64bit pref]:
>> failed to assign
>> [ 2669.332258] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
>> [ 2669.332855] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
>> [ 2669.333444] pcieport 0000:06:00.0:   bridge window [mem
>> 0xa4000000-0xafffffff]
>> [ 2669.334130] pcieport 0000:06:00.0:   bridge window [mem
>> 0x6000000000-0x601fffffff 64bit pref]
>> [ 2669.334821] pcieport 0000:07:01.0: PCI bridge to [bus 08]
>> [ 2669.335460] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
>> [ 2669.336063] pcieport 0000:07:01.0:   bridge window [mem
>> 0xa4000000-0xa57fffff]
>> [ 2669.336657] pcieport 0000:07:01.0:   bridge window [mem
>> 0x6000000000-0x600bffffff 64bit pref]
>> [ 2669.337442] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 64bit
>> pref]: assigned
>> [ 2669.338073] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 64bit
>> pref]: assigned
>> [ 2673.200263] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x6007ffffff 64bit
>> pref]: releasing
>> [ 2673.201935] pci 0000:08:00.0: BAR 3 [mem 0x6008000000-0x6009ffffff 64bit
>> pref]: releasing
>> [ 2673.203801] pcieport 0000:07:01.0: bridge window [mem
>> 0x6000000000-0x600bffffff 64bit pref]: releasing
>> [ 2673.205461] pcieport 0000:07:01.0: bridge window [mem
>> 0x6000000000-0x6017ffffff 64bit pref]: assigned
>> [ 2673.206197] pci 0000:08:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 64bit
>> pref]: assigned
>> [ 2673.206800] pci 0000:08:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 64bit
>> pref]: assigned
>> [ 2673.207534] pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
>> [ 2673.208143] pcieport 0000:06:00.0:   bridge window [io 0x4000-0x6fff]
>> [ 2673.208734] pcieport 0000:06:00.0:   bridge window [mem
>> 0xa4000000-0xafffffff]
>> [ 2673.209323] pcieport 0000:06:00.0:   bridge window [mem
>> 0x6000000000-0x601fffffff 64bit pref]
>> [ 2673.209916] pcieport 0000:07:01.0: PCI bridge to [bus 08]
>> [ 2673.210526] pcieport 0000:07:01.0:   bridge window [io 0x4000-0x4fff]
>> [ 2673.211170] pcieport 0000:07:01.0:   bridge window [mem
>> 0xa4000000-0xa57fffff]
>> [ 2673.211755] pcieport 0000:07:01.0:   bridge window [mem
>> 0x6000000000-0x6017ffffff 64bit pref]
>>
>>
>> Unsure what else from dmesg or kernel config is relevant here. Can post the
>> full 100k here or somewhere else. Or excerpts.
>>
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006f23bfff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000006f23c000-0x000000006f23cfff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x000000006f23d000-0x000000007a792fff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000007a793000-0x000000007fa6cfff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x000000007fa6d000-0x000000007fca9fff] ACPI
>> NVS
>> [    0.000000] BIOS-e820: [mem 0x000000007fcaa000-0x000000007fd0efff] ACPI
>> data
>> [    0.000000] BIOS-e820: [mem 0x000000007fd0f000-0x000000007fd0ffff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000007fd10000-0x0000000087ffffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000088000000-0x00000000887fffff] usable
>> [    0.000000] BIOS-e820: [mem 0x0000000088800000-0x000000008f7fffff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff]
>> reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000106c7fffff] usable
>> [    0.000000] efi: Not removing mem55: MMIO range=[0xfe010000-0xfe010fff]
>> (4KB) from e820 map
>> [    0.000003] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>> [    0.000006] e820: remove [mem 0x000a0000-0x000fffff] usable
>> [    0.503260] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
>> [    0.503262] e820: reserve RAM buffer [mem 0x6f23c000-0x6fffffff]
>> [    0.503263] e820: reserve RAM buffer [mem 0x7a793000-0x7bffffff]
>> [    0.503264] e820: reserve RAM buffer [mem 0x7fd10000-0x7fffffff]
>> [    0.503265] e820: reserve RAM buffer [mem 0x88800000-0x8bffffff]
>> [    0.503266] e820: reserve RAM buffer [mem 0x106c800000-0x106fffffff]
>>
>>
>> [    0.255546] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
>> [    0.445755] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
>> ClockPM Segments MSI HPX-Type3]
>> [    0.447023] acpi PNP0A08:00: _OSC: platform does not support [AER]
>> [    0.449507] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
>> PCIeCapability LTR]
>> [    0.449511] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using
>> BIOS configuration
>>
>> [    0.522380] caller snb_uncore_imc_init_box+0x73/0xd0 mapping multiple
>> BARs
>>
>>
>> Thanks,
>>
>>
>> Dag B
>>


