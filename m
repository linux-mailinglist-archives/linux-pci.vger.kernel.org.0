Return-Path: <linux-pci+bounces-43307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C30CCC3C8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 15:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F9AB30341E4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAB6275114;
	Thu, 18 Dec 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOxhV28/"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A926ED59;
	Thu, 18 Dec 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067392; cv=fail; b=k2MtfNif9ot0rvnn3g2qC7KjgGwYhzai2cQNflb/UYq1YiIUauC+U+Q1y2TVWxl7D0m7Ra/ECax2oc9/jKPT5eKd8qSqIin3sUF2j5u5RY3lgofFAdqRXB6kZHEcoFW71eilikdX9Jg4nq+kDZX9I1RXd5ufLDBZU+GI6jtn4Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067392; c=relaxed/simple;
	bh=JdqHqIa80TpIu8gZeOMyRSYOzEruA2O+qtRAQYiscaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q3SHQEq1fWE0RNjhuAidk1MJB+Awka7en1Dx6tTFtP2MOUCaGefRGCl5va8GsCdi/aVee+ek5SnJ16HR8EQwOqBCwEEbnhDXYUyltqhrqRLtBW2+aZZ1om3VrDBBq2zaAHmHL1Ciu2CI+QgF63nw4zus4ZGwJb35TIshlIpyDHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOxhV28/; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVzZqQwMAXl7CggnkCe/8zucpF/M0VzCQozJIpOh4RO8Jtm63RoGQCZ8ALJu0pksK6vyf0Lggm7BZ/Bq9HheMolDAQ2W1eIQYhu4ir8lnk754ozvEgEoWDdeOSKv0EzrdQkIdp4Jp2Cjf1ssF04vGzXesEvMJ/KuZ6nNbcGc96W2ylfy12Q6Et+P4YUyk8jTI9t79VPlkoE6GxdEw2rJXfbZeKg9Jei+DqYNoKfHQHbUvsPJG/afabD5+CdITmYq7ETLBB0GvqOTRytY4oZD2neWt8moWsgtoVzYH/BR2cS6Kt413AOP2+E2fdEuC8Ui9TFxTEPLcfz/OJmQo4siTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zCAMWzOoqlq0pekfmHkVhcIO2MPQ2v4iqAj4G62wsk=;
 b=m1hhizlgOLYjj4OUGFEX0T6AfT38iiWfOpOfnfBPKc97c9u6O4NGpbIkoi+2jJcYOQ8bZ856ESOy2rmo/+G4D6BPxRZ7vOTbT9dgmBpccqxxSJBXuZvmvI5Y/noGehGIRVy4zK0QIVrb1ELNgSagpqRS3cJBv0CEbrbU/1DLXyJy6I4/4Gq5oHaXS6V/uhMEz+h/Gq/tV3Zrjal2vjhFuosgsIsZyxPIEe4Cj3bDT3cVW2WrrO4kvYPAzMTQlypgaskpIY7+Q/hpUkEbTwkkEuZCB9rqMgjhRHk3EsFgaXEmFeJcH0mkfxI604XENs3Qhiw35tIIhmZnSOl3K0v8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zCAMWzOoqlq0pekfmHkVhcIO2MPQ2v4iqAj4G62wsk=;
 b=bOxhV28/iLX3Fa2TFatrbWL3muSKCB8Hyq54cLWMuqin7RkwhT5S24rdyhFglkqbnwq5zAL6sqxgLZvBrXRD5555si/C1SNhyd09XVDoHkZD9mIqD5I5hRTWxVJsU80+EZDPjG0maNinMLjhBzhiw1sVzbWoarULqC/2PdY3iNg3FdK7+msS4i8PHO9/ZRDNsaC9tJ/Uf4Z+2CIu7eqs/pnv2bPn9EaULafFYCvbykWE/bVo6iGwLxankD15SMLZ5DK7TGB4BCd7RDDCJbkjxnzCfilP3HceGI+vL7agUhN0mGedvCjJDU5dR34GVeHPtIVj5LcZi2aQFyunvCWk2w==
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 14:16:26 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::4a) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.5 via Frontend Transport; Thu,
 18 Dec 2025 14:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 14:16:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 06:16:08 -0800
Received: from [10.221.129.160] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 06:16:06 -0800
Message-ID: <918da2d4-dd80-4fd2-8767-679d22b6d929@nvidia.com>
Date: Thu, 18 Dec 2025 15:15:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: Add PCI_BRIDGE_NO_ALIASES quirk for ASPEED
 AST1150
To: Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <iommu@lists.linux.dev>, <jammy_huang@aspeedtech.com>,
	<mochs@nvidia.com>
References: <20251217154529.377586-1-nirmoyd@nvidia.com>
 <20251217154529.377586-2-nirmoyd@nvidia.com>
 <8c9d1129-7943-49f0-aca1-a506dcfa4955@arm.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <8c9d1129-7943-49f0-aca1-a506dcfa4955@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa5ad5d-e015-41e3-f999-08de3e4007bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEtMeXRSeG5nd3lMMXJmMlYrRjZobHFCaDAxbVU3TWV0SHdZQnhJaExUZSt3?=
 =?utf-8?B?QkliWGNNZ3h5enlRZWlOaitOTFZUNXF6dExHdXB5dFFHZUllVTRHUEJsTmR3?=
 =?utf-8?B?dWg4aEFIU2ZlRzFkQ00zdU4rZFdLMTdBeVk1NVQyVUZZOFI1L1lOZWExdDhK?=
 =?utf-8?B?NjM5d1dEUWJXelZMeFRTeEpndzF4QlZneU5tQ0ljMEEvTDlXeGF5dktkTHBo?=
 =?utf-8?B?dVFNbFFXdjlDVGwzQUVnNkNRRjZXSHRUWnp5TG1aNU1KWk1xMnRHWEZhTmpu?=
 =?utf-8?B?QTUrbGVNN1k0TWNmeWppVFRnSGxpV0ViTmVJZ0pENHoxL2pmWHVJcDZRU2xS?=
 =?utf-8?B?OWYxNWtsdjhkR2hkWVJJUmJFM0VoRE5iTFA3cVpIU09rc3J4ejRjdnVPWmRn?=
 =?utf-8?B?OXR6Ym1EcTVGM1pvUXpUMGFWMU8rTHNSb2U4cmJJa3ptQ0xIZ1NMMU9qN014?=
 =?utf-8?B?WEp1dk5lUjZXVlVKSjVSS3FTQlRHRzMzNXMzaFhzN3ExK3NQMlJHaWJTbE9D?=
 =?utf-8?B?ckczS3RjYmpybGZkUVVTVkU1Y0xpMGpiSlpXZy80aVFSeUs3RUNrbUlPS2JD?=
 =?utf-8?B?N0NuM1VrVGRhcGhSQjN1WFF3RURVUEYydXI4OTlqc0M2RXR0OWxQaDhhVFcr?=
 =?utf-8?B?cEl5cmhYMkpjL0QxUDJsMHQ4cVNnWENocVdQdWhXSmFqdTlmeU10ZXdFZlFs?=
 =?utf-8?B?YjRKWXJMMzZCZFNFQmpib3gvM29rRzI3UUkydGYvQndDQUtxY0VsSElNVFdB?=
 =?utf-8?B?RlhTc05Gd0M2aTY4K2JLWUNQbHlVMHFuRnl0a0p6QXhUVFRvbFJxelBWNldF?=
 =?utf-8?B?Y3p1V2JEWSs1b01xemtSTUsvM283ZDlvMFpuUURNUzd6YlJGMWVzRG9GZE5P?=
 =?utf-8?B?Tzd3R2tKTE4rQjU0TXZpYmpaa2FIQTJ0aWFtTGNSNVRZRkp4VU5WdUQ2bWRO?=
 =?utf-8?B?dnBuOXNrZUFIZ2d4ZW0rVGN1Um9xNno2NUE4Rlh3K0Z2UWlubWhBbm5BTFpR?=
 =?utf-8?B?ZG1qaG9YVFpzZ0gvbmRWeCtuUW5KOGNFR3NyVHJUQlc5UVFWSG45K0tiUlhH?=
 =?utf-8?B?V3ZqWlZhY2pqc20rY0FFK3lMQzlTbVFVT2h5Zkl1Z09HdWRoOExKTFRpTUtY?=
 =?utf-8?B?dWhjMlpmenh2YmlpRXhMYUkzOC9uMHdVOWxkWEJqcjQzUmVld2tmYmg1WFFh?=
 =?utf-8?B?K2R3YVZKTzdQMmdacEpWanhRS3R4RjQ0OFI4Z0VuNVdTYUo3NkQwSTNlRkIv?=
 =?utf-8?B?TEJ3ODNjeFVJUjk5UFN5YzlCT0kxbWZ4TlR5TVp2bDFCYXlBN2Z6ZnJEaWdH?=
 =?utf-8?B?YWJUeHZTdjVRMjAzdzlsdm55Vkp6YlZYMkFHODlJaFpFTGZuMDNIK1dFZ084?=
 =?utf-8?B?dmYybTNtakxuK1ZQb2NYQVJaTjFyUTg1c25UV2JzcXMzUkpyT3JFazV0c1Fj?=
 =?utf-8?B?NTRnNXpOWktlaDhlbXpEZ09TbjRmZ2svU2IrdjFNTUQxbmNMY09EVk45MUFt?=
 =?utf-8?B?SkRDdGJxNjRBNVc1WmZOMk44clJKcUFISnQwTzAvL3NpSW9tMWVid0tnK2kw?=
 =?utf-8?B?VjlibEt2KzlPN3FoWnNYeG9pd3ZYYURsREZFbHljS2VtNUcvU0h1VW5weFpR?=
 =?utf-8?B?bDdJY0hqOXpHTmVuWG9nVU9CUUUrOVZVVWJFMVl1NlowQjJxL3E5a1FGcjZj?=
 =?utf-8?B?RlpuZGdUKzFNQjZJWDhnMWE3SzYxSHlHbm5PdzFVbjZyYnNNcjlEV1NXcHdz?=
 =?utf-8?B?SzI2U1ppeFNsb0kxMWMrVUl0RU93QzA4eVBxby8zQUMxMG80WXN0dXNYVWc0?=
 =?utf-8?B?ak5naWVXcWxNTGNJUk03Qlh6RVgwcjlaNGV1ZEM0QVRTS1NidlJOV3F4a1RB?=
 =?utf-8?B?emZZWjZ4V3pnT2hwK2FvaVhqaHJDT1libEt1TDdlR2xPN21FUDQ4VXhtcDJY?=
 =?utf-8?B?SG1tcWdLNGJTelVPUGl1RUt4N1pkVUlULzdqMVJjTjJ4bUxkSHh3K2NybnVk?=
 =?utf-8?B?Ty9YRktJR3BpWDRjc2JmT0JULzVxUzR1MWtNVHAxbFB1V0RsYkx4QnNlQUh6?=
 =?utf-8?B?YzliY1JWQWNHV0VzbnVyeUJrSlNyNEdLMlQvQTlVZnExaGpBamFlUzJwcVRW?=
 =?utf-8?Q?xM8I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 14:16:26.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa5ad5d-e015-41e3-f999-08de3e4007bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532


On 17.12.25 19:07, Robin Murphy wrote:
> On 17/12/2025 3:45 pm, Nirmoy Das wrote:
>> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
>> bridge that causes them to share the same stream ID:
>>
>>    [e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
>>                                      \-02.0  ASPEED USB Controller
>>
>> Both devices get stream ID 0x5e200 due to bridge aliasing, causing the
>> USB controller to be rejected with 'Aliasing StreamID unsupported'.
>>
>> Per ASPEED, the AST1150 doesn't use a real PCI bus and always forwards
>> the original requester ID from downstream devices rather than replacing
>> it with any alias.
>>
>> Add a new PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES flag and apply it to the
>> AST1150.
>
> Looks reasonable to me;
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> (Super-nit: perhaps s/ALIASES/ALIAS/ to neatly mirror 
> PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS, which amusingly it's pretty much the 
> exact opposite of, but I'll leave that to Bjorn's discretion)


Thanks Robin! Happy to resend with s/ALIASES/ALIAS/ if Bjorn prefers.

>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
>> ---
>> v2:
>>    - Use new PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES flag instead of
>>      PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to only skip aliasing at this
>>      bridge, not stop the entire upstream alias walk (Jason Gunthorpe)
>>
>>   drivers/pci/quirks.c | 10 ++++++++++
>>   drivers/pci/search.c |  2 ++
>>   include/linux/pci.h  |  5 +++++
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index b9c252aa6fe0..a37b7305ae5f 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4453,6 +4453,16 @@ 
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
>>                   quirk_bridge_cavm_thrx2_pcie_root);
>>   +/*
>> + * AST1150 doesn't use a real PCI bus and always forwards the 
>> requester ID
>> + * from downstream devices.
>> + */
>> +static void quirk_aspeed_pci_bridge_no_aliases(struct pci_dev *pdev)
>> +{
>> +    pdev->dev_flags |= PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES;
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASPEED, 0x1150, 
>> quirk_aspeed_pci_bridge_no_aliases);
>> +
>>   /*
>>    * Intersil/Techwell TW686[4589]-based video capture cards have an 
>> empty (zero)
>>    * class code.  Fix it.
>> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
>> index 53840634fbfc..2f44444ae22f 100644
>> --- a/drivers/pci/search.c
>> +++ b/drivers/pci/search.c
>> @@ -86,6 +86,8 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>>               case PCI_EXP_TYPE_DOWNSTREAM:
>>                   continue;
>>               case PCI_EXP_TYPE_PCI_BRIDGE:
>> +                if (tmp->dev_flags & 
>> PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES)
>> +                    continue;
>>                   ret = fn(tmp,
>>                        PCI_DEVID(tmp->subordinate->number,
>>                              PCI_DEVFN(0, 0)), data);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index b16127c6a7b4..963da06ef193 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -248,6 +248,11 @@ enum pci_dev_flags {
>>       PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 
>> 12),
>>       /* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX 
>> reads */
>>       PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force 
>> pci_dev_flags_t) (1 << 13),
>> +    /*
>> +     * PCIe to PCI bridge does not create RID aliases because the 
>> bridge is
>> +     * integrated with the downstream devices and doesn't use real PCI.
>> +     */
>> +    PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES = (__force pci_dev_flags_t) 
>> (1 << 14),
>>   };
>>     enum pci_irq_reroute_variant {
>

