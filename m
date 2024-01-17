Return-Path: <linux-pci+bounces-2295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2873830C47
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D691F26201
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3123741;
	Wed, 17 Jan 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UwURO/UG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2C22EE8;
	Wed, 17 Jan 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514041; cv=fail; b=BhijKTlTLrpTDWo96b+Ki8XGqvqkAgPhq+XTHvV7TdSXaPZDa7hxF1YYWcmzlIefuBfjX5l0/dVhQsO/HHKLdT2yu39Z2qhxo0mSr9TBPz8IloxTMwazD6sz9LMK7DZQoivjUrEeva08X5K2eoKIjjbAVtGnDXBhYuidCjJYnNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514041; c=relaxed/simple;
	bh=c8vPMePyS8jlOkSRbtZ6IyAMorjmcyORssVc3KgUhno=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=hzCmM9epYvN/J9d++m915g36LNKfguLR2dmPfd8HteQk4SsL68LSx+ZbcKLMlfAPjQJ1fXZ8XwHs1MCZB/ObWPaCl9/wixS7P+9VVXSyxAf1lPNsUy7FXZTt1O1ltO3Kc3vqTcG1Dn/S03ivxF2CcVCoRxPY9inIH4pMmIukkFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UwURO/UG; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXbaqSo7IbSL7MGtGhGmmJh1R9XDo4mhqKqZOaumPARxlIoesxMqq0lHPmdcGrsMW2f6LkhQzmUK1FcZz+yGoUap8Rk9imeo9xqTWfT9oCiFL5hAFwQXl5nOkQyPtdJ7JndrwgqjH36oVD+k1Udf5JcVSfVkPiH0zfn2YIWxX/UxKDbPpWirpZg6pBOP96cJ47oPzktYFzljAlKIdFvWrklp9PLJ10Vs/6QAA9TyVdCKiyqZuW8nMchxQ6Dy1tzgWiwATcgHmYHXT46C+7wVBEYafJvl/rHYqsQTrFUvSShyXtYh9k3nAZS2lQ6Ddol0WYlLJjSQnd5E6WwDhPzgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4Nc2aHqcrIwd2wXR/3ybz1D24xjczyibQ9AD2sG1qg=;
 b=C7nBmwi1MOIVEryI0Q90SLYGVGF3L5H23uF34Xpl6zT09npLb/vhagN3xdnfP8Lfz+snzIj00cQM/Qyp3ZAthKST3UTrvqgFOdyqCH60RQzef9z8YH9XYgGZyBty7rGJhnnOWAQYdPT9Xlev6cuNlAEwyQKRgWkrNPC4YRiTi5VU4mbYyeTbMUNWg8SBUSHtuRmmTxRiU2+ytri/cQs/KgExuFv3jsIBMjYmCLuXS4+iB/kYa0XhTI5+39/EzCkXwYiuKQ8qBdyFeHpMK85OwlCPHe+yVP37H6EVGuywKKjRwd0LLyJqm3nw5diNMF9Rssia2tuIwwF2lPW76m9Dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Nc2aHqcrIwd2wXR/3ybz1D24xjczyibQ9AD2sG1qg=;
 b=UwURO/UGt33WvL3DpNLXv2Vkfy6bl06N5p4+PlOGXpgJAtJ4BgR4oplsJVkJ31AlnZ9bSgFOQxGv4dwjkEA4CuRTVAhe2ViwLnQs/zTPW4T+AzOgjuBqkWRzXyPk3XCjnmFJPxmWx2KXHShuhPdJ7flbhzMBSc23yGHx/w6gOxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Wed, 17 Jan 2024 17:53:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 17:53:52 +0000
Message-ID: <7caefe4b-bf05-49a3-bfb8-75e7fd73343b@amd.com>
Date: Wed, 17 Jan 2024 11:53:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/pci: Stop requiring ECAM to be declared in E820,
 ACPI or EFI
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231215220343.22523-1-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231215220343.22523-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:5:120::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcc1b15-7d49-4716-53c9-08dc17854481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eSFkYCWvGIobu59ITdAfuhE9b+0hEcT5ur23OBnnBuX2PjUQyi8BdICtRDXlYVMZ471ytRwTZrL7zw4097J+951h6rxC/wCLa8BehtftoByGPWWgbSFHwCLq+4mlC3r/40dnu9W5i6i0s5dYP7lVKyLTXs0mPdk5qk24et/3IVc3S+5wBn6+eOAd+8F2VctRJyLfHLQu6ZCWviYyE8AZylG51DGwXpe/p7lRMKIzCo6P7Z6rMDDrr1UyVKrPhzJ+6aL3lX6N/ZnueWFUDHJpUjSpdMgZle3jYElN5QiT9t+Yx760L7iZLNUjhTZzwELvWeLN8n41cLLy+nIoiN8C2JA/ZoEsJyC7II7JuVW6TbN+FZYh0n4vREblCQaayPBbz1qsnM+5XbcJN7z+aQm/kRV29FAlGp+ZAyv/Ngu/jhpr8E70sd19p+tlRu5ryMtSu3w+ZV9WUugol5w+dGbLrP71WzdqYFht+WX7djcCdN0l9g+YSl2Z2ib58UELNTMw0ItFIyqvBfvKDxAsPRCsuxCeJOTSslB8O+RhRE4d55/5r/ya+CoybgwUVA7vgdRUaqtWA9Icqdxc3kBp6q4GhEMosfnNG2JJ9vPpPBH+IYd8IlG1X5QZEJtcMiYihOGPUqWbmRHSv5lf/5CDjYhEWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(53546011)(6512007)(6506007)(26005)(2616005)(38100700002)(36756003)(86362001)(31696002)(8936002)(2906002)(41300700001)(44832011)(8676002)(4326008)(966005)(6486002)(83380400001)(5660300002)(316002)(478600001)(66556008)(110136005)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldSaERRT2Y3c29ESXhrNkprT2s0VmNPNFJyd2NLTVJTWnNMYUhrNnJwWHor?=
 =?utf-8?B?cURHZDZ5K0M5U2tNN09qK1pjcHBoczRyR1pXYTF6ZndjMVBjU2g5ZXFENmFl?=
 =?utf-8?B?N0tiWTc1UkVPZHdkWVlBUC9JYUErYkU1RWFjOUdVRmV4cTNJTWtRK2piakRT?=
 =?utf-8?B?ZmVNaTcxNlAva2w4dHVZc3NtVS9lVmJQK01iYklXN24wSzhZZWVHQ01oQmdl?=
 =?utf-8?B?Mk84WnZvS3BaeDdDTkpSUmRkWWNYWEs0L29jeC91RTZVWllhaVkzTkdTbFg4?=
 =?utf-8?B?V0R0ME1xQkF0SFc2elJzcTAzdnZWUVgxV2ZiWGtiZlV5MUc3ck1KbVZQTGU0?=
 =?utf-8?B?Z0g1ZzFMYVZySTcyMlRYYmdqVzA2OFo5VzF0V1FQVWJNcmdDRXFOamdjWmI5?=
 =?utf-8?B?K3BJRnp3TGdyWXpLYk1DSEk3L24vVmU4RVhIZzhrMnoxRVN2cVRaamo0N0pL?=
 =?utf-8?B?SEtXRXlGYU03VWUvb1JjU2NkbVpSVmhiODI3Zi8rejBnaHV5RnBCamRHOEFV?=
 =?utf-8?B?M3Vldi9xejRZc2tONlRUTUVwRDFDcStlSjNnS1BBWU15V0FGa3ZBNUhVWHNv?=
 =?utf-8?B?QVAvdTVjY1lXdk05aFhyM0wxdWJQYkdJWFRUb2EvV1AvdWlKZ2c1M0VGVjV6?=
 =?utf-8?B?c2pIajhvNXFKY0REbXpsbXVxR3dPanBVcFFKd0xJT0I3MjFGbGRNUk1zUTYr?=
 =?utf-8?B?V0x1K2ZaUGRwQml0N2FSZTJJSmZIMDRuV0NuVi8xeWNOMlBvdGFiakFqWmlo?=
 =?utf-8?B?dzRteXJqdlZTbE1WQ3BlSFMza2ZTc2FKQ1BrcGZoRkdJbVVybUM3VWFZejJt?=
 =?utf-8?B?NGNIazVrUGVzTjAvNUN5eTZ6b0hzRHluSm5GTUw5TDNDNnJMODhJZzgvOG1P?=
 =?utf-8?B?dUpCbzRna1R2RnNhL0hTZG9xNEN2c2tnQWtNcmZPUGg2aDgzeW1EK2hla0FL?=
 =?utf-8?B?YnpaSVo1WjFGa3FsVithV1R2ZE5hR0JqU2d6OUtKRVdtd1Rva0pnT0s1UUZU?=
 =?utf-8?B?OTJyUmRiMmUvTTBpenY1R3c1elBMNW1OaWlrTEx0Y01IQVRhT29qMUc3WmVn?=
 =?utf-8?B?ZEl2dzIvSEJzVDNISHVYMk44WEpqdHViZXE5SFo4T1VZSkpQbjdNYTNPSklW?=
 =?utf-8?B?UC9xcVVOZHdLZmlOYmJ1dS96ZkNJN29kU2s0S29zYW1TZWxVSGhsM3F0Q3Nj?=
 =?utf-8?B?aENrMUZ0c3RxTVQ1d3NBYSs5c1ZPRWIxcXhDS1BWb21HdElaWTBObGUwYXBk?=
 =?utf-8?B?bmdCY3hSSTNmTTBkZHMyU1FmK0ZiZkdlZ0RmWFlPVnBBSUgrdkVvdnJ6L09P?=
 =?utf-8?B?aEhtMzdEbE1YS2tZNTVRaDJCMk1LbWJhZDFFYUZRaUR1Mi9WQnNseXo2L1Q2?=
 =?utf-8?B?ZW04YlN2cWFHWndYNVFDUG5qWUZwOXJFM3p5ZnVMVWhtbXJFamNVc1NsbFVv?=
 =?utf-8?B?TXpiOEhJTERMZ1Zrb3diWkRqQm1HbkJPSEhtSW1CWTA4V3hxVk1kMmJmZEpj?=
 =?utf-8?B?Z25oVnRtVEdjUVJBM3pGenFhY1lNbVBCdWF0VkhQNk1wNitzTjZ3RDZyL01R?=
 =?utf-8?B?RHdJSUgrL2UrZnZSbXg1QlFrTWhNWklNcFhlajF4bDdvcFpleExqbWVJeGdM?=
 =?utf-8?B?TTF5STN1U2h3QWYyYmpEYWN6WHVNU2NkWDlPZTZzSzEramJyWG1yQWZzR090?=
 =?utf-8?B?T0xjcXdOb2hJa2VXTEppSDVmN0ZwMUFZQWkweEQ4eW1VS2wxVzU2NWcrVnY2?=
 =?utf-8?B?Zk9ZTDBIQmV3bzNOaHNxdlBuQ1JicGc4Q252VytDUkpNUytLU0EyMEVXOFNQ?=
 =?utf-8?B?akNKVUpLQkRXR1prb2QyOXk4UmNYTi9BVW5mQ0hIT1V0MXRDODhRL1hJbFMz?=
 =?utf-8?B?bVhjVFFJeGhkbHRCTVJMbkM3Y1BXV0FaMFpuOWFHZHBycVNGWmtKLzZTRkZk?=
 =?utf-8?B?NllwZ0poUmM4NVFqcWFqSWk5Zkg2emhXTXJ4WGFSSkZobUJPSXNCNk1CMlNy?=
 =?utf-8?B?UythdGdJY0JvRzVlSGFvUEJvRWlxZE5aMlc3TFh0eDJ2YjlwdGtlY2U3T2th?=
 =?utf-8?B?S1BHMGI4dWoyRHNiRHltcVhmLzBWV1AzdGxGUVdsUkFNZjA4ekF4Zm9xZmg2?=
 =?utf-8?Q?OBVcNV7IiFUNQJsTk8fynpkef?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcc1b15-7d49-4716-53c9-08dc17854481
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 17:53:52.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXKIz2NFu+lL8VqYuZ1Mpe3qEmfcGuTqlm+/HPvvrw7403ChRAvo0Q6SKAWoINLc4ihBQJaw7ZzM0Iich+QgRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118

On 12/15/2023 16:03, Mario Limonciello wrote:
> commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
> introduced checks for ensuring that MCFG table also has memory region
> reservations to ensure no conflicts were introduced from a buggy BIOS.
> 
> This has proceeded over time to add other types of reservation checks
> for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
> does say that these checks are only required when the operating system
> doesn't comprehend the firmware region:
> 
> ```
> If the operating system does not natively comprehend reserving the MMCFG
> region, the MMCFG region must be reserved by firmware. The address range
> reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
> reserved by declaring a motherboard resource. For most systems, the
> motherboard resource would appear at the root of the ACPI namespace
> (under \_SB) in a node with a _HID of EISAID (PNP0C02), and the resources
> in this case should not be claimed in the root PCI bus’s _CRS. The
> resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
> as reserved memory but must always be reported through ACPI as a
> motherboard resource.
> ```
> 
> Running this check causes problems with accessing extended PCI
> configuration space on OEM laptops that don't specify the region in PNP
> resources or in the EFI memory map. That later manifests as problems with
> dGPU and accessing resizable BAR. Similar problems don't exist in Windows
> 11 with exact same laptop/firmware stack.
> 
> Due to the stability of the Windows ecosystem that x86 machines participate
> it is unlikely that using the region specified in the MCFG table as
> a reservation will cause a problem. The possible worst circumstance could
> be that a buggy BIOS causes a larger hole in the memory map that is
> unusable for devices than intended.
> 
> Change the default behavior to keep the region specified in MCFG even if
> it's not specified in another source. This is expected to improve
> machines that otherwise couldn't access PCI extended configuration space.
> 
> In case this change causes problems, add a kernel command line parameter
> that can restore the previous behavior.
> 
> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
>        PCI Firmware Specification 3.3
>        Section 4.1.2 MCFG Table Description Note 2
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Bjorn,

Any thoughts on this version since our last conversation on V1?

Thanks,

> v1->v2:
>   * Rebase on pci/next
>   * Add an escape hatch
>   * Reword commit message
> ---
>   .../admin-guide/kernel-parameters.txt         |  6 ++++++
>   arch/x86/pci/mmconfig-shared.c                | 19 +++++++++++++++----
>   2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..eacd0c0521c2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1473,6 +1473,12 @@
>   			(in particular on some ATI chipsets).
>   			The kernel tries to set a reasonable default.
>   
> +	enforce_ecam_resv [X86]
> +			Enforce requiring an ECAM reservation specified in
> +			BIOS for PCI devices.
> +			This parameter is only valid if CONFIG_PCI_MMCONFIG
> +			is enabled.
> +
>   	enforcing=	[SELINUX] Set initial enforcing status.
>   			Format: {"0" | "1"}
>   			See security/selinux/Kconfig help text.
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 0cc9520666ef..aee117c6bbf9 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -34,6 +34,15 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
>   
>   LIST_HEAD(pci_mmcfg_list);
>   
> +static bool enforce_ecam_resv __read_mostly;
> +static int __init parse_ecam_options(char *str)
> +{
> +	enforce_ecam_resv = true;
> +
> +	return 1;
> +}
> +__setup("enforce_ecam_resv", parse_ecam_options);
> +
>   static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
>   {
>   	if (cfg->res.parent)
> @@ -569,10 +578,12 @@ static void __init pci_mmcfg_reject_broken(int early)
>   
>   	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>   		if (!pci_mmcfg_reserved(NULL, cfg, early)) {
> -			pr_info("not using ECAM (%pR not reserved)\n",
> -				&cfg->res);
> -			free_all_mmcfg();
> -			return;
> +			pr_info("ECAM %pR not reserved, %s\n", &cfg->res,
> +				enforce_ecam_resv ? "ignoring" : "using anyway");
> +			if (enforce_ecam_resv) {
> +				free_all_mmcfg();
> +				return;
> +			}
>   		}
>   	}
>   }
> 
> base-commit: 67e04d921cb6902e8c2abdbf748279d43f25213e


