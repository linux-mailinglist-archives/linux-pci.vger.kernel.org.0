Return-Path: <linux-pci+bounces-31065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A09AED6AC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106173A3FFA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3D5226165;
	Mon, 30 Jun 2025 08:06:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022129.outbound.protection.outlook.com [52.101.126.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35444A23;
	Mon, 30 Jun 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270791; cv=fail; b=PeuN6kZRS9sxtyY7ktf06y1vh8KtUGPocjv2WIxX/mo3ctkHU2mEwtQr/VYywsnqWcayrkcTTd/m3I8ZpTu36+UjSLax2HHZ8M+N96onbGvTfv4ySzVCccDtX+FW2qBzObGxgh35mSqPm5K3E1ZdzWZJeg6jwtQyD/2I7t238HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270791; c=relaxed/simple;
	bh=Ze7nu1JQYgSK0pEZ8lmfxcyPdC6l0UDQR1dQzGPsqDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLoryPcWPMHtjhU3f1SyIa+QE5DLRu6O9uc72HO9V0/S2Qfu7AWcu+vHeKDAZuA2dhdWHSKLs8LNG2zRgu26dtdwA6QQsiUXG2UWZ14A504vV6OgFjM9xfTxbzeMqOQ7Egfyleh24QxnWQe71EstVpnHxdw65uEZXDnq/fwG1ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npbGpxj3IRGTG66QfjhKstfPoZEGEdUQ6eTWX5xigMH4IScBLVZXg64TnuYMOikS2/xTBFfLnobWoCQJCcF6Ud6/KVlAbX5pTqest33OeRZl8YfjqPhXwzQyjoQ4uSd0xtPKBEN24YxLIxi+p/u6ygqdkjv5B/avBTzLo+kPAsy8/Mmgeb78L1BdanaWgZ//4AuXpO9lDx+UJJPI5n+2nW9K+Rj39KFCqG/D68329nNLG+OVtWWoPSVYM7LJAxh1Ogygl0QqS+jSKLXbuKOZTKoIvxJzWVnEUOAmTYSW1cm1j4CsiAar3K2JKT5YP3aaQJIFQlBVQVd5EhcufmL8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA6o38TgkHxCG/VpfUA340sf3gJZQ9VC8YT5vfcfENY=;
 b=a1iaAIzmAV0rfSiKHGWGHhozW2+syDoA3ueJ6Er2tkpzS5zvAqgHGsDSadkAW556fErfms7UT+gd3gzbkPZ0zuPGge9fqeBKxP9euKaJS7wKUuoOZZdMipYYCAT9hgCQpA9NvjEIW6d6/PjvlqMb/LJ2TH+c9oX4gAVQbUU+Zgt36MMrYTYYcY6iNrrAzg33vPL5FrkK74o59LfjOscGchpjCfl4TNd447bm6hYFmqxMjILpHDBCrIaGmpoeQu/rFzP6XTL069OyjLHTjWfUuCtrDPPDODHxZfjOac3sg88I8bdN6MkyHL6pQwj4x08RP8MHIsGs/wyf2ks+aNsGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0008.apcprd02.prod.outlook.com (2603:1096:4:1f7::14)
 by KL1PR06MB6651.apcprd06.prod.outlook.com (2603:1096:820:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 08:06:25 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:1f7:cafe::12) by SI1PR02CA0008.outlook.office365.com
 (2603:1096:4:1f7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 08:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 08:06:23 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5686F44C3CA1;
	Mon, 30 Jun 2025 16:06:22 +0800 (CST)
Message-ID: <abfb2578-8d0a-47f4-840f-e1336579f6ae@cixtech.com>
Date: Mon, 30 Jun 2025 16:06:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] MAINTAINERS: add entry for CIX Sky1 PCIe driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-13-hans.zhang@cixtech.com>
 <20250630-delectable-greedy-sambar-5dacd8@krzk-bin>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250630-delectable-greedy-sambar-5dacd8@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|KL1PR06MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcdecf8-2666-408f-5e73-08ddb7ad0117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzVqOVZyYkp6Q2lGZVJwdmZjMFd2bEFybnNzNFlTaTBLWmQrSjdybUJ4ZENT?=
 =?utf-8?B?eE9GejVPZFZZcUV2UGp0UHAyUW5ROFdIdXpNSVBLSld3a3YvQ2luU245WlhC?=
 =?utf-8?B?QmZDOTlidXRPZGxIT1lhaWZreERqMk5sT0NuUTlTWGR0dXhVY0NWRzN6Ylht?=
 =?utf-8?B?VkhQenZaWSs3WUlRaDgvSkxjQnpacmlmdHlTMUtDbGhlQWNVRjB4c21wRmxM?=
 =?utf-8?B?NDhmdzU5a1QrcTBubG11dkFWV3BtVXZTUXgrK1psWE41RDlDanBocEZRN3kw?=
 =?utf-8?B?ZHcySk5DbExoRWVBdUNDcmgyaTk4MkxOUlZnREFtR0ZlNGNhSWEyYXkwMXFq?=
 =?utf-8?B?amZ0ZWpUN0ZPSUNZUlpaMllQMlhWSUVrNmZ0a0t0WU94aTJJbkNyTUJteUJG?=
 =?utf-8?B?a0k3cncyMVRSM2kwSzc2RXYyRGgvOGFEblhUWktscUJEQ3hkRWVha1VYVWx6?=
 =?utf-8?B?dlJlcFAyL0RqMk9iVEJmdStBY3NBZzBtUXpqWmh2UGV1N3JMM01OZG4vQkFI?=
 =?utf-8?B?UkJVaXNYOXhjRUJ3aHhlSnNqQmEwcExwdGI5bXpETjZ3aHgzWXo2OGNwOFZF?=
 =?utf-8?B?Z0dDS2M5bU1FeWdSMzkyN3dNYWNvL3Y2Wm04WHRnaEdHUmx4dHEvbHR1ZVpH?=
 =?utf-8?B?bDlKOTFXblQ3UE1hUzMreUNXbzIzNWdCNllueFRhNlY1YlQrajFqK3dQN3BN?=
 =?utf-8?B?VXV1dE8vaHJNMCtLd3hxT1NNbmJHd25mUVJ6blZBYWhhL0M3eU1WcEljaXVR?=
 =?utf-8?B?MXppZmZOaTFvUG9STUhZK3gzMFRLSEZxZkNMQVBncDV4TkxvYmEyZEpNaUtP?=
 =?utf-8?B?aG1BaXEvSW1ndlJnYVFwMXJnWld2NU56REo5WkttVjRaVnE0SWd4M0RhdXVU?=
 =?utf-8?B?TitWZCthMEphSjlOU0t0V2V3Q3kzL00raitlWEsrOFRkenVlbHFNMFF0SVpr?=
 =?utf-8?B?aDRZK1lXaEptOUZWNVM1NnJFUkhiSDNkSWxEL2hGdWJkVWNBbkI0OE0vQTNO?=
 =?utf-8?B?b3VobmhiQ1dMSEs5dXpOdmt1dnJab3NXajY1UlJOSXBqZUpSeWYrUmhMN3Fn?=
 =?utf-8?B?Q1RGUWRBRFQzUnJUNXVhc0NGZnM2dGJFYVJjeTJjMVRLbEIzdXRWZmNSa3hW?=
 =?utf-8?B?M2prdWNjazhMaE9YS3Y4aUY4aE1zYVZnb0VxZEZPdFczOVJ6N0YyUUNiZStU?=
 =?utf-8?B?SUdJOHREVGdMZzNlTmg0QWZaMlA1U2J0M3A1T3l4S2txWkduZlFVMFc2c010?=
 =?utf-8?B?VTFSeW1VSElIOFZyc0xYZXNaa1pOMzF3NWNTa25oY3pPUlMrVk5jSHdnK1VB?=
 =?utf-8?B?TW1XTXVOR0dXOUlyS25haTF2OHBlM0JhYVRVL3VnMHFsaXFZNWNJbkh3SzF6?=
 =?utf-8?B?YUtSUlZnMko1WStiL0hpaW00RTlwMU9Vai9tRThCeENaL3pqWm8vQjNJaktJ?=
 =?utf-8?B?OEc1MW1KWTQ4Z3h5ZTJPTzZoUzRWakpnR3JJUktxVkdWUWNESkMxYW0yVnkx?=
 =?utf-8?B?NzV3WkNYTGUvUDRJb28rNHFsaWQ0UXlkYUZvZkszNXQzcW80MWdEZVZveWRX?=
 =?utf-8?B?QkJtamh3ejdLL2tKK0F4VGpuMTYveHlXcHBlZTVKa0FEb2JXa3ZDekFoeWNW?=
 =?utf-8?B?UmFWM1FVRWQ2VUVaNlEvRXpoQ2Y0NGRsQ2taWVJOallVazRCQjNRQVhRNWNC?=
 =?utf-8?B?cmtwYi9NWUNBSEdJcXpUNXBiYkZNU3lYL2J6VVAzYWs3WHpjcWZxeG5xZzFQ?=
 =?utf-8?B?NTYxcGN3L0ZkcTdwUTFMaW1vWVdWWXRrcWtlUi9sa0duenZjZ2VVNlQ5c1hx?=
 =?utf-8?B?OUF0Y0tXdnBBMXNTb2VoaDF6ekNqaGNGK29ETjhzNnpPVW90VUdSMkgreFNs?=
 =?utf-8?B?VzA5ZmFZOWlJaXRhb1RTc1RwaG50ekpzczNHdFE5M2dQYmJ3MUxOaVFvb1NB?=
 =?utf-8?B?d09JMGZjR1UxR2NPcWVDQ1pQYlZrczJqM3Q0YVEzemRHMTNBS1VOczN4M1hQ?=
 =?utf-8?B?cHl0TVZoODZQOUtoS3FON090VmdjMEU5d3hMSEloU3FxRGR2YldMZmtkMndX?=
 =?utf-8?Q?BOC/rS?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:06:23.0243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcdecf8-2666-408f-5e73-08ddb7ad0117
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6651



On 2025/6/30 15:29, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Mon, Jun 30, 2025 at 12:15:59PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add myself as maintainer of Sky1 PCIe host driver
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
>> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
> 
> Where? Provide please lore links, since your changelog/cover letter is
> missing them.
> 

Dear Krzysztof,

Thank you very much for your reply.

We reviewed it internally first and then sent it to the PCI mail list. 
Anyway, I will delete the internal review tag next and wait for the 
maintained review tag. I'm very sorry.

Best regards,
Hans

> Best regards,
> Krzysztof
> 

