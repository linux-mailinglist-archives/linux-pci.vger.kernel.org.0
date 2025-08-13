Return-Path: <linux-pci+bounces-33953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F91B24EA2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 18:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D3D560726
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E045226B96A;
	Wed, 13 Aug 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="boWUgRgM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26C279DC5;
	Wed, 13 Aug 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100472; cv=fail; b=E7wIsByJ8hedzAL2HcB5fnvF8b2t42RGM8LSV1hy/B8Tu0tKj76qtIf0SppdN125dsN3J4ekn7pkpa/FXwmUt5DhccXD0gOjar1AUECmfmURtg2Ca05rZ24HLTm4BIc1jpDysnCUqKMBWnFxR03MzuzLG6eKgsCZ8WLF/5A6MgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100472; c=relaxed/simple;
	bh=/3II6w6CuIIrMVT37ZaV2yAr3k5QGZLOpKMpEVCmAjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tDsy9P1O8YqI7aQCgSfjEl5TC5Lo+UvMsJ/lSn32lOPzEo3UKZKM1cAePwOJppirO3RO63zWOd3ZpSVJUugf+/bsRv9pDNrN5fD4SZCnet2wZ7Xc3rkW4mV1rpbr61IlJdt/cK4Y3zl3Srrp3nSCkU4dxAoBAXi43m418qah/pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=boWUgRgM; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra6cV+ZY4Q2jHjs9qMkkX0A1NxdnrRyan8gUSt7rtC3EcnEyizew6iFUdWTBIP6M5E/xJa9WLuWl8Ws8ivp844tQK3hdTT5NO5zdjL4UqODK0rOcd4GJCGXGET1iPoJQR7V3Zokp1h9j5fN5XmgFz9cxPOrY9XJsKfLFQdztMSYhOUHLsWOZi2yWimvovz9APexzwAHeOsxBXLTCrIgGtGMqLhCJLEttDcn6rv+eNUvEohwL2ET18SH58+e+FyWC5zAbGs7tnwM70DLG51a3Xj0930BKGtr7icqPL6zCCqbj3B5FV+8qsPEdL5GFq7l4RzQjEXbNQc6NYasGEndfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVg1NKja/MBEi5lkTJmFZzE7VLqqokVDyt4OX4TEc5A=;
 b=rPOAabQA6pZb+yn5Ii5HotqFQNfLzLuRZew9CKan0Fr5xt5RT0UsLwka+tygZ0lTlqt9QpmWEFmlkS0CYMD/Md1S5K6bcjb6GlTAWIc+X/wb+xfTbQbvf3JcpXDo0/Z31hUa5Dx4PVKCyPHkTpQMorBDtOEywCCGqdJawJwGzI/tq67IIGR0WCj2hEbsq+pB3P/hAE5CV2z6zhIRc7uDMWRRA7aOwmceXLBLL1tPpFiQInwBHRweRNxCQjISWBg8J6v3jgENkGqvN2fubJbjzfvd9SozHCoEAXt/Fi52ZIW+kClAf2yTRH2USP9AaWSuhkA/TV538Pdk/vBAsyaiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVg1NKja/MBEi5lkTJmFZzE7VLqqokVDyt4OX4TEc5A=;
 b=boWUgRgMQFWqk3xsRIBhn8d3qbRHmahjyssGneDVZaTQK8JE2MWcizyR3rwSF2CSq0d13cPNOmgripo46r8NVExLV44zuAGr6TXA8KR/joIALOsN9LFnuDcvu3mK6zralt3fuvFBHDGqxxSFC1nARBKqwFEGjlZ3ykutmtrXhjs=
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 15:54:28 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::a5) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 15:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 15:54:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 10:54:27 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Aug 2025 10:54:26 -0500
Message-ID: <95370ca7-6dd7-cc2a-ac36-570d49451df3@amd.com>
Date: Wed, 13 Aug 2025 08:54:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Issues with OF_DYNAMIC PCI bridge node generation
 (kmemleak/interrupt-map IC reg property)
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
CC: <maz@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aJms+YT8TnpzpCY8@lpieralisi>
 <c627564a-ccc3-9404-ba87-078fb8d10fea@amd.com> <aJrwgKUNh68Dx1Fo@lpieralisi>
 <e15ebb26-15ac-ef7a-c91b-28112f44db55@amd.com>
 <CAL_JsqJF6s8GsGe1w6KEkeECab956YiBSFbdbHOiiCv2+v3MAA@mail.gmail.com>
 <aJxPDH6Sx0Ur01ER@lpieralisi>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <aJxPDH6Sx0Ur01ER@lpieralisi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b773a0-6124-4ba5-b039-08ddda81af13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2VienZVTjJnY0xaUW1LS0tXQzNicGxmSkJaN24rQnpEVkpTTE84cXI1SGg1?=
 =?utf-8?B?NGhlaksyTlBaTzQ2WnRYc2tMNytBb21pMXZWUlBOTzJHL294dk9IOUpjeHdy?=
 =?utf-8?B?SU1zc0RNNVhxcFN6OGpucW9yeGF0ZjN2YW9SOHhoZUhLemMzcktsbk82TlF2?=
 =?utf-8?B?V2UxcWFaYjFWRGx5OWhPQW5EYVJ5MkpaclVWMS9lblZjaUJEeHNFbzNuOGYz?=
 =?utf-8?B?QkVKZmNuR1BFdXpkMC9hUlIycU9YSVh6MHhtMG94OWNEU0h4b2x4VVVuVnVT?=
 =?utf-8?B?ZDd5TUEyWGhLZUdMOGFNUFphOTZvN2lJcWdQS2xLZnVxcmJLWDlNeDI1RnBw?=
 =?utf-8?B?UzQvaGxCcTFJZSs5Vnp0aytWZVJva2UyaWQ5Yzh4NEZ1aCtURU1Ib2psNVFZ?=
 =?utf-8?B?ZEdoZUIvRlZvWXlWNnlYRzl6QW5nMm1vNkVnak5HOW5qOFk1Q2pPZ3RoaWY5?=
 =?utf-8?B?cisrSDZWZFBKNnJmUjRKQ1V0ZTBjNmtFWUFmS1pJejZpVlhmU2JlRWpGS2Z4?=
 =?utf-8?B?ZjNtRDlQemVWU2NqQzdoK01IWjZXR1pTbHJsV0JJdTFjTjFpUTdQcHBLd1VP?=
 =?utf-8?B?WkdQNkE1eGZ3OGgvQ0VaVmFsRkFpa1dRKzFYanlHT2t2dE4wQ1d6L1J3Nzhj?=
 =?utf-8?B?K3lhT1BmNE5JcVFzM1NScXExV1lqZURreSt0bHpIU3lMcUord3JPMjg5NW5w?=
 =?utf-8?B?RTFMUFhWL2ppSUs0M1l3azQ3U0JGZHYrZWcrUmkvN2R5eWFHMUh1MEh0dGNj?=
 =?utf-8?B?U3R1M2JiY1BSMjdlYVdsd1BZeTRKa1VFZ2NyMXd4di8yK3IxMDB1Nndudnhj?=
 =?utf-8?B?UjN2R2NwT0tiYW9Hdjg2R1FGSXI0czhCbkYwNk1GZEhhUW1vcEJmTDl4d1pD?=
 =?utf-8?B?Rk9RSE9VMXNpZXlTcWRhb3hCZnRXWjdBdVc3VHJ1KzBsaDd0cTFoQm9wRmZw?=
 =?utf-8?B?bjFBeXRDUkpxYkNzeWkrU3BtUm5zQ3BwaHZqUFB6ZjRxc0lOWlNQanFMQ2hp?=
 =?utf-8?B?Ukx3N0taRUhVVE8wckZsZTZnTldJSXE3UWxQZWIwMmliMlF4QWRBVlc1VHov?=
 =?utf-8?B?K3VRRnhUcXJsUzZheU5SdTEwWm1pdlI0UDJDVHhhUWNkY3czbmwrZ2pocVRL?=
 =?utf-8?B?cmZRYWJuZlJnK29iczNpNU5JM0I4NERDcXYyOWVJYnQ0NkFxdDhwNlZJR25H?=
 =?utf-8?B?ZW13elpOVU9PZS90T2FoUjRVU0x0S1cydml0RE9yLzJXcExDc3BNV3FYbGQv?=
 =?utf-8?B?a1Jjbjlaa0dsbnFEZ0VaMThDU21uQXlWdFFxT21wa1M2N0d2cXhudTVVZE04?=
 =?utf-8?B?WTFudHN6Z3ZXcHlNT1pFOGtVSUVRZzllSUVDU0xIKzFJdjNjUWlyQmZlcXJ3?=
 =?utf-8?B?QlViRTJsWjlycEltMnpLTVNVVllPdEpkaWUxK0Fidks2dUthZWRQTkVDdlhi?=
 =?utf-8?B?VzBTYWxGUXg2TEVyRnBSSTZpR3dsc2NEMXR5K0NGb3FpalB4cXRoRVpuZEZa?=
 =?utf-8?B?ZmlxeUwvSk5JTlkyOUdGdlNNUHFiZjZXbUN2SGlqWWZVa3Y3bWJ6d0c4cEpx?=
 =?utf-8?B?RkthOFVUT3lXMk16d2psbDB3aDdiT2JydnRHWVhlbUV6dVg2clN2WlZoblU0?=
 =?utf-8?B?WTh5a2h6Y1VJaGlaanFQVGhsN250K3Exci9DTzRnWmJXZWNNVWRieHpaMlFC?=
 =?utf-8?B?ekdwTjN1VHc3YWVaQ2Z3M05uUG5PdEVSRGE1aDJlb0thSVIrNjdSOE5vbllk?=
 =?utf-8?B?L0c3d1FOR3BxTjFEVmRLbGZnL0ZjbjZISThxTHhiTWdWRFlpMmxhTkhFbTNC?=
 =?utf-8?B?eUdUZ01HOUZNbDFOZy80T05jKzRuaGEvZ1ZBaWNtcmlBRmV4STNETTBTRkJE?=
 =?utf-8?B?M2hkelpzRzcwSHJabmNvTkFjTEV6NHIrNDUvSXV5VG5TTGpoQlgvbDZtYXZK?=
 =?utf-8?B?a3BweTYrS1VZSDBQUHNhZTRqUjZPcHFqck9yckxkZkorWVpIVkZwUGdoQXFY?=
 =?utf-8?B?ZkVBa1VaSXp1QXQ3QmVQWXdCR09LYUxzMHhqQ0FMMzM2QnFQbkc2eWd5SWdG?=
 =?utf-8?Q?8AroTl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:54:27.8993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b773a0-6124-4ba5-b039-08ddda81af13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763


On 8/13/25 01:38, Lorenzo Pieralisi wrote:
> On Tue, Aug 12, 2025 at 11:59:06AM -0500, Rob Herring wrote:
>> On Tue, Aug 12, 2025 at 10:53 AM Lizhi Hou <lizhi.hou@amd.com> wrote:
>>>
>>> On 8/12/25 00:42, Lorenzo Pieralisi wrote:
>>>> On Mon, Aug 11, 2025 at 08:26:11PM -0700, Lizhi Hou wrote:
>>>>> On 8/11/25 01:42, Lorenzo Pieralisi wrote:
>>>>>
>>>>>> Hi Lizhi, Rob,
>>>>>>
>>>>>> while debugging something unrelated I noticed two issues
>>>>>> (related) caused by the automatic generation of device nodes
>>>>>> for PCI bridges.
>>>>>>
>>>>>> GICv5 interrupt controller DT top level node [1] does not have a "reg"
>>>>>> property, because it represents the top level node, children (IRSes and ITSs)
>>>>>> are nested.
>>>>>>
>>>>>> It does provide #address-cells since it has child nodes, so it has to
>>>>>> have a "ranges" property as well.
>>>>>>
>>>>>> You have added code to automatically generate properties for PCI bridges
>>>>>> and in particular this code [2] creates an interrupt-map property for
>>>>>> the PCI bridges (other than the host bridge if it has got an OF node
>>>>>> already).
>>>>>>
>>>>>> That code fails on GICv5, because the interrupt controller node does not
>>>>>> have a "reg" property (and AFAIU it does not have to - as a matter of
>>>>>> fact, INTx mapping works on GICv5 with the interrupt-map in the
>>>>>> host bridge node containing zeros in the parent unit interrupt
>>>>>> specifier #address-cells).
>>>>> Does GICv5 have 'interrupt-controller' but not 'interrupt-map'? I think
>>>>> of_irq_parse_raw will not check its parent in this case.
>>>> But that's not the problem. GICv5 does not have an interrupt-map,
>>>> the issue here is that GICv5 _is_ the parent and does not have
>>>> a "reg" property. Why does the code in [2] check the reg property
>>>> for the parent node while building the interrupt-map property for
>>>> the PCI bridge ?
>>> Based on the document, if #address-cells is not zero, it needs to get
>>> parent unit address. Maybe there is way to get the parent unit address
>>> other than read 'reg'?  Or maybe zero should be used as parent unit
>>> address if 'reg' does not exist?
>>>
>>> Rob, Could you give us some advise on this?
>> If there's no 'reg', then 'ranges' parent address can be used. If
>> 'ranges' is boolean (i.e. 1:1), then shrug. Just use 0. Probably, 0
>> should just always be used because I don't think it ever matters.
>>
>>  From my read of the kernel's interrupt parsing code, only the original
>> device's node (i.e. the one with 'interrupts') address is ever used in
>> the parsing and matching. So the values in the parent's address cells
>> don't matter. If a subsequent 'interrupt-map' is the parent, then the
>> code would compare the original address with the parent's
>> interrupt-map entries (if not masked). That kind of seems wrong to me,
>> but also unlikely to ever occur if it hasn't already. And that code is
>> something I don't want to touch because we tend to break platforms
>> when we do. The addresses are intertwined with the interrupt
>> translating because interrupts used to be part of the buses (e.g ISA).
>> That hasn't been the case for any h/w in the last 20 years.
> If the parent address values don't matter I think we can just leave
> them as zeroes and be done with it (explaining why obviously).
>
> Something like this (with a big fat comment added summarizing this
> thread):
>
> Lizhi are you able to test it please at least to check it does not break
> anything before I make it a patch for the MLs ?

I tested it and did not see any issue on my side.


Thanks,

Lizhi

>
> Any concerns ?
>
> -- >8 --
> diff --git i/drivers/pci/of_property.c w/drivers/pci/of_property.c
> index 506fcd507113..dd12691fe43c 100644
> --- i/drivers/pci/of_property.c
> +++ w/drivers/pci/of_property.c
> @@ -279,13 +279,6 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>   			mapp++;
>   			*mapp = out_irq[i].np->phandle;
>   			mapp++;
> -			if (addr_sz[i]) {
> -				ret = of_property_read_u32_array(out_irq[i].np,
> -								 "reg", mapp,
> -								 addr_sz[i]);
> -				if (ret)
> -					goto failed;
> -			}
>   			mapp += addr_sz[i];
>   			memcpy(mapp, out_irq[i].args,
>   			       out_irq[i].args_count * sizeof(u32));

