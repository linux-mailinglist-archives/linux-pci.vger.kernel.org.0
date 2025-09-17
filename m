Return-Path: <linux-pci+bounces-36369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A67B812A4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3845546492F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612D2FC871;
	Wed, 17 Sep 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tc/rD0Z2"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858D1EBFE0;
	Wed, 17 Sep 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130018; cv=fail; b=RXbaZs5FC6Rnge4aIYudT6UHIWUZu4MOyBND7pPWjZ6HiWeP6Xb6wkAWdbHsKipJW3KCSsEyKL6fmzxOa2grxq5pebWuZ3+3VuVZ5I8CKTvZvmgd+bo/9QzADRprUGURmEQdRtJDBrOMjuKuVlQhpJ//lF4puNsVxPvG9WQt3dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130018; c=relaxed/simple;
	bh=RuQNiQCTrw3SAZgVkdqnWcY9KDv2JefHtavG2aMxalo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CX0tcTWqrvj41yc2PZpp/rOfPx9F+ShqNfqQs1HaBgvdjIAAX5T77ElE1StbHtv4y9sVlBpCMhlJD2nkrxTECMRkktvj14uGniUAFY28ZLfeEREd3PfGPI+RV0AiJ30tfU4XKgjbuD0qnNgZ1c8nljuISj6DQlfP60I5oiMimCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tc/rD0Z2; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOiqmG+GXJISdSDNPV/eDOC0Lqxp1dY3fCeEzK7JpV08V6vidyr7D49aFhip/1O4ItIlVSlbdyRu51VFc8IWK3JfO+teRuJN/GAPFqwftoPZq4BkCjzQHjOWo3CXDdF33vTrkE8BwvpnkotVWLi/15bf1KCybD6l2+fA3blnPwbOzau6ah4bWC30rkLCgU7DnTklaVfEjF/CFTStjoKLKNuZxC7L/1Hy5IyQKx7LMbOHZZLL9ikEyMsPS0vkX9BcHU6cVtDbBa8rs0uP+Rf7x+E2fWlpGsOylmSjGJ6Y4asX2fpvxLAJ4l87Ip/ZtUYq7dvg65wShoHoovvf8DyyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyVwfayfzLtH67vkrXLBRudt/gZCqTG51K78Dk8TSu4=;
 b=JDKO0OzaxtBMfypBuGdh+C6sb2nqHx+zWtZy6hbEm6pijKRdABFW2r7E3H1sykbijEYuE2A50V5RxrA8Bp7CY2ntangfYryXl8qPW/wiGvbCo1Gx9OM0/hE0IJtXFWZrnd3yLPNAanQLwr2o8m3EWcW/13HYWA5DpLOCrc5Ov22e16aR6D67VzlKKgee5S+2vOwai8crcD/l1x4NXtV3JZAjQTYzcwdK1w5kI7IO59m7aHbwJn+AVZX99u7r/tUNcYxfljdiSnOufepmwpR13aDjLq4L2K8bQ0+FBn3aAnKhJEeq8+O1s+UN8C4kdNqfzP8IkqCOeL9LIX2vIWfEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyVwfayfzLtH67vkrXLBRudt/gZCqTG51K78Dk8TSu4=;
 b=tc/rD0Z2pFJpFDmMYkHnjji+iCPjpHhbOWGioXzdTDRhTF/kN0NbLYzRsxjaj98x9TCUqp4IjIf2cticwPtoykI6sOSkI84oUdSbIMQ8TeFd8MwCOgHnJIb9G6Fj17Qdpje7IcDYlsYURp/i1BucHOa20t6kkaAT5MvZs00kcJ4=
Received: from DM6PR14CA0039.namprd14.prod.outlook.com (2603:10b6:5:18f::16)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 17:26:51 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::c1) by DM6PR14CA0039.outlook.office365.com
 (2603:10b6:5:18f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 17:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 17:26:48 +0000
Received: from [10.236.181.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 10:26:47 -0700
Message-ID: <4f7d8553-b162-46d5-b45c-239899010f19@amd.com>
Date: Wed, 17 Sep 2025 12:26:47 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] cxl/regs: Add cxl_unmap_component_regs()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
 <20250730214718.10679-2-Benjamin.Cheatham@amd.com>
 <20250912154629.00007db4@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250912154629.00007db4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e39a648-5766-499f-1792-08ddf60f61ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFdpNk9lZXk5ZWo5WmNsYmFTaE5qU1JIS3hCaGluaGpWays2T3Ewa01nQ1p1?=
 =?utf-8?B?aHFsdUtIbHZ4MUh2S3BnZFQ4N3lJcEI3d0pyN0VxMjl5a0w2RURnM2Foc0d3?=
 =?utf-8?B?YTlFS3FvWEp0d3FPY0RnY3huZ3JGRHQ4U1dxM2RuSVpwckcrc2FUamJFakRv?=
 =?utf-8?B?ZVNBSTBHa2syNlFhYUM4N1ZmQlhVMEx6MmpBaFFnaTVEZndVamhyZW5haHRK?=
 =?utf-8?B?UkZLYTcxbGRDV2JpSmhJMFFOSFhveXdySDljclZLbEF6RmJ5SktTaFZXRTFF?=
 =?utf-8?B?c2VPbGs3QWt0MFNPbW1VRXVUdlRhK2c5c0NNVGdNM0hUTllYL3NEU1Z4QjZw?=
 =?utf-8?B?SU9OTGlJNllWQVlOR3BSNk0wOS9lNUpmRldibnZCdG5CbWZKdXNLTWFTcnNH?=
 =?utf-8?B?Y1AvRW81Z1ZoQ0p2dXM1NmtXWnY5ZXZYNGd3cjA0Q016UmNwckZ0TWlNNUFr?=
 =?utf-8?B?bDZjSCtvd05kWmZGaFdWYVZqQkppYkk0L0x4SnhhZTRvMHdyTGp3dFBIRlpa?=
 =?utf-8?B?RzEvNHV6UjBTNkMzVTJIOUZ5R3dKOExZSWNFTm94VExxWFNraXVnbVBYSFJk?=
 =?utf-8?B?WC93MmxlQlBjUlJFelZXU1l1RmZ3aGZEODhWMDN3LzQ3M1pvK0U3c2x1cS83?=
 =?utf-8?B?NDVDTUhaVGFScHRyVE9lemxYS09TS0d5SjVkc3hVanJjU1dLdFRLazJXN0NZ?=
 =?utf-8?B?SkVBa2Nicy9aQ1hjMU01WnRsUkx1QUJoNnVVSGJxeHZiNjcwYzBuSmFDL2Zq?=
 =?utf-8?B?UU0xTVQzakxSTjBHZnVqSDVWMHN0WFJ2N2tkRHo5TDdsSFdlN013b2sxeUU1?=
 =?utf-8?B?YUtyNzNQWnlKODd0MDRrRExHZFFCMDhpYjBuWUdRdjgwdVQ5aFNUVGsybnUv?=
 =?utf-8?B?UVIvV3o5cGRWQzluWGpzZ0pnWDhGcEZKQlJqcDBoS2lLcjgwcEJXRnArUXlV?=
 =?utf-8?B?U1I2ZlFQZXVBUk5xZ3k2cXhJak56UVprOXEwWHl0a0pWRjdLaTBqR1dOMXQz?=
 =?utf-8?B?VXJTY2prT095QVZPRjJ6RXEwNENkQzhDa3JFcWwyazgwVVA4OUtZME10Q3Jn?=
 =?utf-8?B?SGtheG5vMUg1Unh2TUdRZm9GWVdmWGdGanRNY01yYjV4Q3NYeUpUV0lIV2F6?=
 =?utf-8?B?MzFLSXF4VE8zcWtxdElrMXptMmVqbTZMUXhTMlhOcFo1YnpOVUhLdWhtTzQz?=
 =?utf-8?B?bE80OWNDVDN0Z3V0WFJMTDB6OEk0UVlSRStwVWs4emExK2pWUW9wbnQrWllh?=
 =?utf-8?B?RG9VSnQvOUNvTWdHR1k3RjhZUnlIVGxhUmZEQ1phU0x0bjEzbkpONHpyUktP?=
 =?utf-8?B?alBSZytldGIySy8ra2dBVEthbklIamNkd2lsOWh2dmtROVNQVFhhcDIwK0ha?=
 =?utf-8?B?U3pGcHpqVWNjT0ZlQkZITWtCeDJTMkJBY0NrN2NPaFZFckxpc1g2OWd2MUpV?=
 =?utf-8?B?N1F2eXZUV2hxb2xjcWpnS2Z2U0d1eTgrQWpMVzJBUlhKMVNKZ0VRQ0lHNUNh?=
 =?utf-8?B?bnhxLzQ1MmZjUWx0Wmg5Um9aVjVJMWpra2ZsN0lWMnczWWM4RFV3NjhsT0Rv?=
 =?utf-8?B?OHNjdjBST2tBT3A4S1BNdnZwbjVZSVRhcUE3VzdoQk5oSm5TazVRVDIrM0tK?=
 =?utf-8?B?ZWcxTTgrc0l1SWNMTjV4elJ5cXZJVEV2a3BBemU4b1RyTEtsUHZmN0laOVcx?=
 =?utf-8?B?RlgzcjJnL0xELzl4aVQzR3BCUFRhVVRSd3Mzb2NhYzNGNCtEUU1FSzdNNUx4?=
 =?utf-8?B?Umt2TUIzR1o1U256M2ZWYmpVWVgrUnA3ODhiaDdQcHV5MHRzMm1KdmlQM2xZ?=
 =?utf-8?B?WGVzenNwUEtTOU9QWlZZRDBraGh6dURCVzMrTzRkTCs1ZHI2SmJINExpZ1gx?=
 =?utf-8?B?cldkQmpheFRBaDhtY01SVXNYUEZrSzAzUkY0UFpqVi93aXl3SEUvS0tXcVY1?=
 =?utf-8?B?eGhkdWxEMktPSVREVDBqOGdvUHdvMmJYK0dGaVpyMERDR01qNll1N29aSU9N?=
 =?utf-8?B?amJnejhjNU9SMUtMNVcxRnloaStOczJ5UEMrazBVSkN0RUM0U0lTZ2NHNXI5?=
 =?utf-8?Q?1gccrO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 17:26:48.3542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e39a648-5766-499f-1792-08ddf60f61ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9

On 9/12/2025 9:46 AM, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 16:47:03 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
> Hi Ben,
> 
> Whilst I know there has been some discussion of whether it is appropriate
> to enable this functionality without a full use case and definite confirmation
> someone is going to use it, I'm loath to leave completely unread code
> on list.  (you talk about this in the cover letter).

Thanks for taking the time to review! I wasn't able to go to the community meeting this month,
but I did hear that this was brought up. My plan is to wait on a v2 until I get a customer (if
I do at all).

> 
>> In order to allocate the MSI/-X interrupt for CXL error isolation the
>> PCIe portdrv driver needs to map the MMIO-space isolation capability
>> register that contains the interrupt vector. The CXL core already
>> provides a function to map registers in this space:
>> cxl_map_component_regs(). The mappings given this function are managed
> 
> given to, or returned by?
> 

Probably meant "given by". I'll change it to "returned by" though since I like the
specificity.

>> by devres. If the isolation registers are left mapped by the PCIe
>> portdrv driver, the CXL driver will run into a devres conflict when it
>> goes to map the same registers during probe.
>>
>> Add cxl_unmap_component_regs() to be called from the PCIe portdrv
>> driver. This function will unwind the devres allocations done by
>> cxl_map_component_regs(), which will allow the PCIe portdrv driver to
>> map the isolation capability register without conflicts.
>>
>> Factor out the register mapping retrieval code in
>> cxl_map_component_regs() to be reused by cxl_map/unmap_component_regs().
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/core/regs.c | 77 +++++++++++++++++++++++++++++++----------
>>  drivers/cxl/cxl.h       |  3 ++
>>  2 files changed, 62 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index b8e767a9571c..da8e668a3b70 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -201,40 +201,81 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>>  
>> -int cxl_map_component_regs(const struct cxl_register_map *map,
>> +struct mapinfo {
>> +	const struct cxl_reg_map *rmap;
>> +	void __iomem **addr;
>> +};
>> +
>> +static int cxl_get_mapinfo(const struct cxl_register_map *map,
>>  			   struct cxl_component_regs *regs,
>> -			   unsigned long map_mask)
>> +			   unsigned long map_mask, struct mapinfo *info)
>>  {
>> -	struct device *host = map->host;
>> -	struct mapinfo {
>> -		const struct cxl_reg_map *rmap;
>> -		void __iomem **addr;
>> -	} mapinfo[] = {
>> +	struct mapinfo mapinfo[] = {
>>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>>  		{ &map->component_map.ras, &regs->ras },
>>  	};
>>  	int i;
>>  
>>  	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
>> -		struct mapinfo *mi = &mapinfo[i];
> 
> Whilst the usefulness of this local variable is reduced I think
> it is still justified and keeping it will reduce the churn
> here somewhat.
> 

Ok, I'll keep it in.

>> -		resource_size_t addr;
>> -		resource_size_t length;
>> -
>> -		if (!mi->rmap->valid)
>> +		if (!mapinfo[i].rmap->valid)
>>  			continue;
>> -		if (!test_bit(mi->rmap->id, &map_mask))
>> +		if (!test_bit(mapinfo[i].rmap->id, &map_mask))
>>  			continue;
>> -		addr = map->resource + mi->rmap->offset;
>> -		length = mi->rmap->size;
>> -		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
>> -		if (!*(mi->addr))
>> -			return -ENOMEM;
>> +
>> +		*info = mapinfo[i];
>> +		return 0;
> 
> I'm struggling to see how this logic works.  We now only find the first
> entry in mapinfo that is valid? The new cxl_map_component_regs()
> doesn't seem to include a loop either so it's not that we enter here
> multiple times.
> 
> 
> I think this only works if only one bit is set in map_mask?
> It is always called like that, but the function doesn't check it and
> if we are going to always call it with BIT(X) then pass X in instead
> that making it inherently only deal with a one hot bitmap.
> 

Yeah it looks like this was an oversight on my part and I didn't catch it
during testing due to how it's called. I don't have a strong opinion either way,
but I would prefer to keep the original behavior since it's more versatile.
So, I'll change this function accordingly and keep cxl_map/unmap_component_regs()
as-is.

> 
>>  	}
>>  
>> +	return -ENXIO;
>> +}
>> +
>> +int cxl_map_component_regs(const struct cxl_register_map *map,
>> +			   struct cxl_component_regs *regs,
>> +			   unsigned long map_mask)
> 
> Similarly I'd make this the bit position not the bitmap with
> 1 bit set.
> 
>> +{
>> +	struct device *host = map->host;
>> +	resource_size_t addr, length;
>> +	struct mapinfo mi;
>> +	int rc;
>> +
>> +	rc = cxl_get_mapinfo(map, regs, map_mask, &mi);
>> +	if (rc)
>> +		return rc;
>> +
>> +	addr = map->resource + mi.rmap->offset;
>> +	length = mi.rmap->size;
>> +	*mi.addr = devm_cxl_iomap_block(host, addr, length);
>> +	if (!(*mi.addr))
>> +		return -ENOMEM;
>> +
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, "CXL");
>>  
>> +int cxl_unmap_component_regs(const struct cxl_register_map *map,
>> +			     struct cxl_component_regs *regs,
>> +			     unsigned long map_mask)
> And this one.
> 
>> +{
>> +	struct device *host = map->host;
>> +	resource_size_t addr, length;
>> +	struct mapinfo mi;
>> +	int rc;
>> +
>> +	rc = cxl_get_mapinfo(map, regs, map_mask, &mi);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!(*mi.addr))
>> +		return 0;
>> +
>> +	addr = map->resource + mi.rmap->offset;
>> +	length = mi.rmap->size;
>> +
>> +	devm_iounmap(host, *mi.addr);
>> +	devm_release_mem_region(host, addr, length);
> 
> Add a little helper for devm_cxl_iounmap_block()
> So that it clearly pairs with what happens in devm_cxl_iomap_block()
> 

Sure.

> 
>> +	return 0;
>> +}
> 


