Return-Path: <linux-pci+bounces-29577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3EEAD79D1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C37AFF53
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC729B77A;
	Thu, 12 Jun 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TYSkJDlw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182A198851;
	Thu, 12 Jun 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749753365; cv=fail; b=Ye785oEA1SBEjVhyG+U/RoZggD9ORBN0KE7ZB9vcHvGQhaqb2OpVE2pXw8GWsP6o/Cx1vI7C3Ur8HT0gi2moiFUWtUAbBW420tbD2aYz3LRi++V9unECPXUX+qpi4s1ejP97VuftYy4H9eovwwwkeHmIXiFcQFH1dV4N6WR/zms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749753365; c=relaxed/simple;
	bh=aVHo9Fs9dzyd0Zw6ZwUToHMSjt1UuquNr1iP1Unzy+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MVTMXqMqD3hEiwZgytLkWWLmHDCl4zH85cmzZuWh9Mowz4pLvNv8TFoB49nm/aIwYaoyfzvp8hTF8ipU0YQ5KtpxwxWiI/L1hprgK/8ud3mtGjbvb1P6kiqzfkReSEThHJQyJ36lf2bPeJMlU7x2z6Gt1HvGFqUJAOMTcBgevLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TYSkJDlw; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXsLMjdu3CFNzCFj/YpzjDMrd6N6TJ7Q96e/mTPijiATT5B2Vk/UUqioA1Lqi+kv0HdKuhji63wxKJ0ajavDmYg9SJVPHNBkygwDNJroadJDIqlF60lIpQD0FsQz4wGzasBSk3RkAZUp9xRniepEFuPgwOKctvJGPDvRFECQpvsm+bQOLAAH2Lc0t8UdlUSltiG3CHtc+cgVXAO42yAwCN0d8PWiNjwD+YtaMciWumt5El0O+WvlcAJeWT0ocwpjR0exLBB3cos+EZo/l/VrnStZWmSvYjHk38HKCxkUDUqv6/htNlaSieWG2YzHgx9UnEVfHVVeqrROLmmRmbSanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asdju4MVNRnIitQQDhOY2S6v45XY2YGVkSj0OuRj4nY=;
 b=tqez60mTX44+vZl0adddHsPC1tVAG3oz1OqXNHd249dpu3VXmRnLtwY7EblC+F5nj3TxzoTa+EejD8/JyLdvGJ0Nt05Mxru3pOItCBzEQkwFF6+JlCeIffSvhygOjRnR4gtBkY35nU+NP/aFfY1MOEQRb+N5dtyaclOkaqTzeMAB8JIxSS6FsMFW3J1gX7Vm8ykuSZ+DfxSRvW7UjhOove3KiYtkWZ7TU+DYmXCYbIp+kx+VS82U6HBX0aVp7bSUPIZh9XzDbEijqdtpP2EcQDtd9YRPhRYw/0RMR7ey2IOFeVxE0uKErFXjSdiaqU5bX1El04ymjnLwySurmuuOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asdju4MVNRnIitQQDhOY2S6v45XY2YGVkSj0OuRj4nY=;
 b=TYSkJDlw1ke5LuIx1T+iqqKYZqNbfLT9OEiSJVypEV6Fqq8VHNAy/JcSKJ7KQ2ld5QRTz5LktcAKEbRmyYSOEpnUrxBcEx/4Q9G1AWNKnGP2cmedvpUyvd5OQMVTldba2pIn+rw7KmltLPI6l5R7jv6A3brVdN0CaBQnlkxL5RA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ5PPF6375781D1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::995) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Thu, 12 Jun
 2025 18:35:58 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 18:35:58 +0000
Message-ID: <c4c29333-989b-4fe6-93fa-3f880d3e9b1c@amd.com>
Date: Thu, 12 Jun 2025 13:35:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
 dan.carpenter@linaro.org, Smita.KoralahalliChannabasappa@amd.com,
 kobayashi.da-06@fujitsu.com, rrichter@amd.com, peterz@infradead.org,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <20250612123650.0000321b@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250612123650.0000321b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::9) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2509777b-714d-4220-1208-08dda9dff8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alJDeUJCZ2g0bmw1aVZDQnA2VE9PSXM2dHJLMGtocWt1dVJUZlQ5WGZ5NTBn?=
 =?utf-8?B?NXozb0JrNzl4N29SdXFxQ3I0cDNuUG9vNlV1bTBvUGRwNXpoS1VVenYzbm00?=
 =?utf-8?B?YVRyMzlNSjBHQUpjT3luemEzeERPZ3NXOFFjc3BRVHVYMlR6MzNua2ZLakxW?=
 =?utf-8?B?MDlBUFdvVzFNZWM4ek9ocHRlYzMzbG10eTNGd1ZFU2hkS3lDbjlZdzJyVllJ?=
 =?utf-8?B?TkhYUWxsUnFiaVdGY05WNGc4Y3hLeVIwa2EwVFRwQXBPQ1Q2dlNnczZLVjZM?=
 =?utf-8?B?WXh1L2FNQ045a0U3cGFFbHU0NEdOMklQSGoyRkdoK0VSbUJsNHBUenBxTFZV?=
 =?utf-8?B?K3lZQmduejl4TGlxWXEzbDl1NVlUMUFwU2xIRnRhcE9aZFVYQ1RucUY1bUJ6?=
 =?utf-8?B?dHluSDVIbCsyRngyWlQ5QWtmbTJ6SkNhNks5OFJYeUJPTkU2ZFU2MDNEaXgr?=
 =?utf-8?B?QnZIU0VQLzJWY1cwSEh4TnhYb3R2QlNBSy9ucGFHUVBpVGVZei96c1dkOEtL?=
 =?utf-8?B?K3lBRDBZRE1RVTg0MlJZdVYvL0Rjb0h0Tlo4cFNVSE9JQ3V5OHJWa3BUYm5B?=
 =?utf-8?B?TU5Za0o3ellXbzJYakg3RzZTVS9qZ3ZCZktLQkJZb2E5VEJybVJRUzdvY0hk?=
 =?utf-8?B?ejg0Z2EwM2JhRDA5THlrdERPTVZiZ256Zk5BSTYxZ3VoYWpxTHJ3UlRJd1o5?=
 =?utf-8?B?T1R1YU9GSXBOMXFEMTdqR0ZjQkM5ejhEb0RwR0VVQlljbjBZZlVReTd0UjJE?=
 =?utf-8?B?OVpRalhhZlpJdXJUS2dWQThuVzgrOG5pT1I3S210OVc0N3dGaEk2bEhpbnlR?=
 =?utf-8?B?YlR3akh1dVVTMEZKbFJieVRKeE1GaE54WG1PcnRZU0N3VTRYd1llU05NMmor?=
 =?utf-8?B?QmtjdVV1RmEvQlkrZVR2Ylp3ZVFPR0xONGRJS2VNdlNyakFrL043d3prRVZt?=
 =?utf-8?B?V0l3eVZJdURXemd5K1dzdHZKWGFiS3lVMjNhbktqNXpMTmhoVUcwbkFsUmdZ?=
 =?utf-8?B?MWltYm1lbGp6c09CeFJIVVR3aElZV3JPZUc4U0J2NTV6SUpDUDVwczZ0dy9B?=
 =?utf-8?B?Qm8wVkoyWXhIZHJRUGRZOTl6enFxTUdiTm5aenE0ZnkwSndvMldRNGd2ZENH?=
 =?utf-8?B?UkdjZHhSbzh6eVFaRzdyNEN0UHA4L1hFbk1mdnBSUzNHRFdoTUxteisyeFlU?=
 =?utf-8?B?R1F2TnJZMFMvK2dmbHdBejJqSWM3aCtIektyeUNYT2s3R3BDN1BkYXpzazc2?=
 =?utf-8?B?RFp3VjBPL1U5QnF5ZlRvODhCamcyRFJONVZNZU15NEoxbFpmU21MNW52QS9H?=
 =?utf-8?B?bGt1T2xUa09lZzdYdzM1M0hLNnk1UHFLUVdNSTNIaFowM2c3ZE1NRW8rbGdT?=
 =?utf-8?B?MUkzeWF3dlQzNUI5b1pXVzBwdkZHUTRuOG9xeE5KcFh1S2p3YTZNNmhJWVN1?=
 =?utf-8?B?Q25YZ2svalJvQ2UzSlRCdGh4ckpKZVFSN2E0K3VSakNFQWgyZm55dUNuVVI0?=
 =?utf-8?B?TG84Vk9ROWoyY1A4M056MGwrYWpNNUJjV1lvelFDaGgwcnh4czFoMk1XdVJ5?=
 =?utf-8?B?UENWRUtlOG45eDBmZ1R1NEpTVkNjMUczWFdqaG1JZEhrQTE3Y1Fpa3dNaSty?=
 =?utf-8?B?N09WaWtZejNpTy9mMWd4aXVDRWNHbW9CWjVleklGRUhGeXBiWlNURFlWNEFE?=
 =?utf-8?B?WUx6bEdBaEJtT2JmR2dGZVZLaStSdVJjK3FhVFJYblRLS0NaSFJmazFtUVV4?=
 =?utf-8?B?R1VacytGejY2RmwxTkhXOXJxbW9NR041akU2a1NzSUZQLzdxQkdLaDZCdndw?=
 =?utf-8?B?NE8zSCs2VEp1SERGdTVLaDEvKzRncmpYWnM3K3pVc3dXWS9QdE1SR1JqTDVK?=
 =?utf-8?B?OWNBOXlBQ2NDRHlvOWdpWDZta1JKTjdVZ3ZzNDkyZndLRmZpUFg3VEt1UzRx?=
 =?utf-8?Q?pcC7hsBgoKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WStvWGRwTU5FcHF6eGx1RGp5bC9OQ0N4YW1SeklTYnZqcjlobFZHWUVtZ0Ra?=
 =?utf-8?B?UDBwQjdubkg4V29FUC9LemNhRDZrVlJ0amFmakc5YTEzdDRsQ3Y5UzkzVzVy?=
 =?utf-8?B?RCs0aDYyektaeGhOQzN1cDBHcXpQU09tSVZpTDBFNm5FMEN4MU1yWnF1MFhp?=
 =?utf-8?B?ejN3SGxaaVNSeStzaU5CNHQrQ0lnTmVFT0RMb1R3UGp2amh2UWxLMUpNQnkv?=
 =?utf-8?B?a3JVNGc4dktVcVV3UnVma3dMSWwzWnI5akNNSnFhTE84MnNzYm9HOHFpRWlN?=
 =?utf-8?B?aWFvOTZXdGVmUlo5MmhocDJBRlB3Z012eE5LZFhpMkdiMkdLN3hTbFNPVm5Q?=
 =?utf-8?B?K2NZNDY0WTZRejZveUNQTlRMaUV5VU9VSkRkcVFud2NtVmxpeCszMkwyaGhy?=
 =?utf-8?B?ZnJnRGtnYmxFT25uNk1jaGFhV3h1bTA2R3hYK3hMOUp4a1h6NXJnZmEzZDBJ?=
 =?utf-8?B?NDBqVUZWWVpBQWgzd1FFSzZNTXNNNXg2dzdFL0lUa0dqcDlSYmtUbVdncVdB?=
 =?utf-8?B?T3B2VzlrUERSZTlqemVTNUVRZjgxYXlnMENqa0U2L2YxTUovSFFhTzUzMkEr?=
 =?utf-8?B?RWdmSHJwdlRKdlBBM1d1R2JrOE1kbmhXQmxvTFVXKzgyZG11UTU5bjNCbW14?=
 =?utf-8?B?U3d1cnNvaDdCeUo5c1lQWWYwaWNOc3AxUU4yQ0lNS2hxSFJYcGFqcDNGd2h0?=
 =?utf-8?B?RUgzYktMaTJiMVRVZjg2OEVkYW9hSTA1ei91QjYzdUNWWTFyc0k5Q0RsVHZ2?=
 =?utf-8?B?RDdLbjJuMW1YWlN0YUFsNjlNZ2pJUGlDMmFKWFYrVHRBR0lOdjJOc0xMbFV5?=
 =?utf-8?B?WEhPMXNUb3ZxQm9SMzdJSEVyM214Wm1rdWl6Lzc1VnJ5UmhtL0RXY0dMZUFo?=
 =?utf-8?B?MWE4TVpNK0o3SDNsUFIyL3ZZeUlneHF0TW9QK2EzaUdWalhCRVZsWU5HVTYz?=
 =?utf-8?B?Ymg4LzlDUEJ1YzV4VmZ2V1BXdkxLMGRWZ3hZVFdzUnFMT3N0U0krZ2YycWRx?=
 =?utf-8?B?d1dtMHNvRmFRVXhZWVprYlYrZ2hPUk5zM1l4RVlWcEdTYnVURXBwSTg1TWxs?=
 =?utf-8?B?aXNIdHdjc2Fjd05ocDlHcmNFbVB3M2RicnQ2VmxsVmc3Uzg2cUhKYmt4elp6?=
 =?utf-8?B?bGNOdVdGUk9TWWJiZzRzYmR6ZE9UOXROWkkwTU0ydVZPMllpQ1l4ODFOUnJI?=
 =?utf-8?B?M3creEl4UEJFYmN3eEVlZWRtRHBOQ0l6MXNRVEpZSk9DUi9qRVJTTk80VDZG?=
 =?utf-8?B?ZkhhZ3hpZm9pRFk0dko5eGxqN21jMk9iL3JwZ3hPaDZRZGZCZC9jOHJXekZH?=
 =?utf-8?B?cU9pRmJMbTAvcElTUFlMeTVFNkdCRElwMEsyUWZha0ZEN3lKRXJaTFMyQlVR?=
 =?utf-8?B?OFFmWTJ3NkZHcEVYWDdUMzMrMEE5dGc2VkpaVlNXR3V3RG1pSWh6T3pBNTFY?=
 =?utf-8?B?U25sRWR5ZFJaRm9nSHlHYmV6aURkbGljeStEcHc2djFZWHpFY2ZOZlBOTEkz?=
 =?utf-8?B?UUtsK0c1Q2p4Nkh0RWdvUUFPYkJNUEl6RTVOdDIwVmxyQW9UeitJaEYxbkN4?=
 =?utf-8?B?YWhVNjNvTzlXdHorL3dIVzQyM1pwS0d5MXJYRU1PRlh0OXJuRDZDVTZNaUxK?=
 =?utf-8?B?YlJVWU5KVktuRlVNZVY0Nkg0T0UvZ3FYdlZWL0h6VlVSb1RTTXova2FNWHNQ?=
 =?utf-8?B?VTIxZHBBRkxBcVdVbktSN1ozdHVYRHU5cTBmQkFTRko2Zlo3d3J5RWhnNW8v?=
 =?utf-8?B?b21VMUIwTGdvY1pwRE00emUxMjQ1ZFRObWx1TkRaeC9RajJvN0U3ZUxWbk5Q?=
 =?utf-8?B?Z0gzZmlPRFhkY2VlN1lzYlhveHRKY2p0RVVFTHZ4b0VGK1gyQ2JKVGJNUmpq?=
 =?utf-8?B?QmFNSU1SUkM0RTk4TXFZRjJYYXBVMFRzOGNBZzAxVDNFL24rcE5NSzVxMDQr?=
 =?utf-8?B?dGVhVXJpZUFxUkVxcFZ3dW1GUXhKTXhTbnE0cWtWbS9iZFAzVDhaWXFCYXIw?=
 =?utf-8?B?N1VRSFFNcDAycHk0d1lrN0pQdXlPSXFvdXcyR056eldwN3VTU0VDM01kSnh1?=
 =?utf-8?B?ZUc1UVpyM0RDRU1kUk9DdGE1bUNjeVU5QlU0T3psempwaVRPRVFJWm82YmQ5?=
 =?utf-8?Q?MiBC4Xi9vIdBQKxUWCr3oE8IA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2509777b-714d-4220-1208-08dda9dff8ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 18:35:58.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUWldNE51jJYitlr9ZX7bCQ1FlyonUz4sb367XpQ2/rk0i/KOcLVuVD/1SD7A4thwCWZMS2rbD1BnWUl8/rGkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1



On 6/12/2025 6:36 AM, Jonathan Cameron wrote:
> On Tue, 3 Jun 2025 12:22:27 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER driver is now designed to forward CXL protocol errors to the CXL
>> driver. Update the CXL driver with functionality to dequeue the forwarded
>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>> error handling processing using the work received from the FIFO.
>>
>> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
>> AER service driver. This will begin the CXL protocol error processing
>> with a call to cxl_handle_prot_error().
>>
>> Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
>> previously in the AER driver.
>>
>> Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_prot_error_info'
>> and use in discovering the erring PCI device. Make scope based reference
>> increments/decrements for the discovered PCI device and the associated
>> CXL device.
>>
>> Implement cxl_handle_prot_error() to differentiate between Restricted CXL
>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>> RCH errors will be processed with a call to walk the associated Root
>> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>> so the CXL driver can walk the RCEC's downstream bus, searching for
>> the RCiEP.
>>
>> VH correctable error (CE) processing will call the CXL CE handler. VH
>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>> and pci_clean_device_status() used to clean up AER status after handling.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hopefully I haven't duplicated existing feedback. A few more minor things
> inline.
>
>> +
>> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
> That's an odd function name as the sbdf is buried.
> Unless it's going to get a lot of use, I'd just put the lookup
> inline and not have a 'hard to name' function.  With other suggested
> changes you only need (at where this is currently called)
> 	struct pci_dev *pdev __free(pci_dev_put) =
> 		pci_get_domain_bus_and_slot(err_info->segment, err_info->bus,
> 					    err_info->devfn);
Ok. I'll remove the helper and add inline.
>> +{
>> +	unsigned int devfn = PCI_DEVFN(err_info->device,
>> +				       err_info->function);
> This makes me wonder if you should have just use devfn inside the err_info.
> Is there a good reason to split them up before storing them?
>
> IIRC ARI makes a mess anyway of their meaning when separate.
Agreed. I'll keep devfn together.
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(err_info->segment,
>> +					    err_info->bus,
>> +					    devfn);
>> +	return pdev;
>> +}
>> +
>> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
>> +
>> +	if (!pdev) {
>> +		pr_err("Failed to find the CXL device\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Internal errors of an RCEC indicate an AER error in an
>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>> +	 * device driver.
>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>> +
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		int aer = pdev->aer_cap;
>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +		if (aer)
>> +			pci_clear_and_set_config_dword(pdev,
>> +						       aer + PCI_ERR_COR_STATUS,
>> +						       0, PCI_ERR_COR_INTERNAL);
>> +
>> +		cxl_cor_error_detected(pdev);
>> +
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(pdev);
>> +	}
>> +}
>> +
>>  static void cxl_prot_err_work_fn(struct work_struct *work)
>>  {
>> +	struct cxl_prot_err_work_data wd;
>> +
>> +	while (cxl_prot_err_kfifo_get(&wd)) {
>> +		struct cxl_prot_error_info *err_info = &wd.err_info;
>> +
>> +		cxl_handle_prot_error(err_info);
> I'm not seeing value in the local variable.
> Ignore if this code changes later and that makes more sense!
It can be removed and simplified.

Thanks for reviewing.

-Terry
>> +	}
>>  }
>>  
>>  #else


