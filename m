Return-Path: <linux-pci+bounces-21302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DCEA32F65
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 20:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28D53A790D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB526157E;
	Wed, 12 Feb 2025 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q7Nd62hO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A0261595;
	Wed, 12 Feb 2025 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387710; cv=fail; b=qDRyCqK3w4NESww6T4OZmpdyGmNW7TDPbeXelXUZqY7ONPSHCioKtDhmD64Qx9qpEqbL5s6wbgiJuso7zSdnicRovH2FU7oT4wpLwhGangLrjBVCqSdOJmtrL4BnEWgxMetM9k5vVAjLlpmuzgAOT9zcg7vnjVvBa50zA02bqbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387710; c=relaxed/simple;
	bh=BavyEDVu30o5W9bslYeKG+aqPQWZ34FKZ2b4H9v9qaw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BG7TjNVDPAG/moNUOczMYZB0c1gt0U5EjBom4Zfy00n/BpIF8dYBRARGLB8nOd63cEAiXAwJWR+3GVO6EHN8hgg/kkwxQkb7CAmKObmMwMAzVZRGsZXw82GZqdBH05z3nfv7APbtrkDuQLD3b8hkvtkhJHiCHoWUGbkKp+CWOuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q7Nd62hO; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSPg198QCBA7gJbsfJwIsA77s1zp7dNvFBzdxB5OWo4KWL68kbqFpZ9PSWblu1JwWO6qCe38lrUYlhuvE4+vSBB1k+0m113s81D2FYRRSn4elJ7+8SVdT/3RThUeHZC05SwSJlrfZxb25ZdQEf45Wq2mTJS5o2wwDXL57yT7uzgSTzLm/1pkrYdq44w7MIBiVub3L+gRdtARxdGoLlL4yShsg0AyEHiXa6gT2knT/Ep9KNLpfNs9lxn++lJxTyR+BAOFFUKJAzj/H2Iy5z+NK8wB/HviBirN7nmn2ORqB5F4KEk3i2N+Xkyzb9TlcmZeN3S7dAKMkzWnKctaoDPBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsW5EmhkDMZWwIwQLmvMP10org5uuEUc0tstILbnPh0=;
 b=zEeJy8yhXtETgrHt1r/OSJZwvSQpZ+EScC4BDGAy4A3igPHVo+MmWaoynZ3f00zxUen601vfAgHnQY41Wyhfq1e40ENce0q1oL8qAcS6vbOYzz9elkeVJJA05uh2CkSC7067qK4OcevCvVXmQ2rJRK1qiZpc3MUZbszvLQxaHC0ZKChx+162HP2oSX491XzztTQW2iUM0AU5ZBLhxX+f5h9K5Cbfek8Bxtm9kKynieDTNQnOaqLJKPLWEUDfphwYG7MCkJ3mmdSBX9hTVyAlHIkuTRqcNfA9lUbkZv2g5uyeg85n1ZPYxyGVDrXn9k/zIo0YFR+TuauJWpoS0wEDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsW5EmhkDMZWwIwQLmvMP10org5uuEUc0tstILbnPh0=;
 b=q7Nd62hOWl49UPX0O0Qp2fIUEkWm6M32CzDnbPKAL+aXrunx3fV/W2dYVfmCKYhGUMQiCUd5ImH1HPBDVF3QGRhlpqo0GfRcMcic9X9b5aBZyzhSJbncw05oTekP2/VQxikFgD2oXwWp7Nh/uBxvr2hq0FYk+Gp0fLoozVJVfhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 19:15:05 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 19:15:05 +0000
Message-ID: <9035be0b-7102-4abc-a21a-61648211be55@amd.com>
Date: Wed, 12 Feb 2025 13:15:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/17] PCI/AER: Modify AER driver logging to report CXL
 or PCIe bus error type
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-5-terry.bowman@amd.com>
 <67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:802:21::42) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 7baaa7f0-624c-49fe-a054-08dd4b998e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1FFYkEvR1pCQzhmazB5cUwzUkk3M042RXQwZytNNHlTWFU4TjdqaXhpVzI5?=
 =?utf-8?B?THlOZUpEL0hlWUJoUFFZbzlHZThQZXpJTmhZTExIbXk1ZUFxdnVpNSsyYll2?=
 =?utf-8?B?MkpJVDlaM1ZDUFA0dWhIc0ltMmxCdlhHU1NzcXgyTzJVRXI1eGQ0YUd1Zi9h?=
 =?utf-8?B?aEVxdHlaRUR2YUx5YVREeFY3N29EVmtvUDcvNlNLanRTcGRrUmp0SCs1aVVQ?=
 =?utf-8?B?S0tUenlqeTBiS2RodFMrT0dSQUhjTWRvbUJ2UVk4dXBNTVArdjBOckljalln?=
 =?utf-8?B?dkRNRTBDaWlNOGJRZ3RHY2xyYTdrMXpNRWhKb3NjSmJDN2NQQVNpVXdHR3Vw?=
 =?utf-8?B?RWNRSmx4N1RxY1Y2RjIvNUpLS1VWRGFEWnBQM0RwWVNBZmt1VUNtOWV4cXFF?=
 =?utf-8?B?ZG1FMkJtMjZXTzZrbzl3RlVxdzVVQUtkZVNXa25wdTNaYzJ1cjZPUEhacmdq?=
 =?utf-8?B?VkRPLzh5bnNnY25Uck5tTGljSlo1RmwxZ1ljWEVqcXZTTUJkK0hWdnBXMEpa?=
 =?utf-8?B?dmxvMzNMdjQ2cVRZYVpoQXduY2xJVHBkTlZXMFUxS2VCTkJqQmhyeGlqeURZ?=
 =?utf-8?B?U1l1aXM0cmFzMXJ1cXNHVjBES0F3K1U2VUJDUjBsK2xkTWZaL3VaSWtySCtR?=
 =?utf-8?B?NVZOTnI2Zmlnak8yM1FVQkh4L1BRU2orTnRleklwbG9tTmw1ZlpqQ0xYeFdt?=
 =?utf-8?B?ZGYwdHhVYVhORkZQa1pKM2M5VW5ZaUlveUU0dkNYZ2RKOEgxM0dvYkNHMXho?=
 =?utf-8?B?emlhUmxlYXlKdkFvWENueVlLdVk4aDZYcEUzZUZnUW1PemNQYVZmU3M2eHJn?=
 =?utf-8?B?alUyOUd2eTlNVkpoVjNqNHMrb2NQeWJSVlVFOFRWL1BXSUlPck5GYU11S1J3?=
 =?utf-8?B?NlhZVk0rS0FMWjh1YXk4MjRtYTVQNmpNMHZFRStsNmFYZlZaVldDYWZBblRs?=
 =?utf-8?B?NnE3ZXNBQVpkSUdhb1RzM05NbUpkZWo5a0EzZ2ZuQklLQktjZ3BGbWFObkVD?=
 =?utf-8?B?N2JSNy9VU2VVQlEwUGhRdGxBbndQb2liZVFiQlZPTlgxczYvUHJoZXg5TGY5?=
 =?utf-8?B?NTVvSkxYRDdPcWJhZGJxWDRUd21waUlranBEL0ZsU29YN0RlNVEybmFGRHhE?=
 =?utf-8?B?UU1NeVo0ZjRrRGh4UkV3K1NQL1A4T2N4R3o0bzBiUkY5dStXb2xjUFdXODV4?=
 =?utf-8?B?SEJCUVVaRjNHWmVuUWdGVkdNdzlxNk5RVjdxdmFibE5OQkc5T1I4aFRNS0Q0?=
 =?utf-8?B?OXdTYWJyanRyWlhmUGZ4WmdLUC9UbWJreVJaUmYweWNQdEdVZVNFZ2wzanp6?=
 =?utf-8?B?OVViZ1QvRDYrTmNmMGJTdUJycDBYYjJ1M1AyV2kxTW5uUkhjK0lxUXBlM1Zq?=
 =?utf-8?B?SUR5eE4xYllRdE42MmF1WjNxRTVTRzZoaUpTSmYvcWJTZnMyblNmTktwRzRj?=
 =?utf-8?B?WWJiUFp6aVVweHZRYktFaWdhUXJRb0xQSCs2MkNvYVJIaGZCeFFYQWZiYVZk?=
 =?utf-8?B?NXoybFQ1VjkwRzhUWGcxM2k2NlhWeXhSNmIzVkV5aExWY0xiYnZGYjcxNHpM?=
 =?utf-8?B?bXRNcStXMmFkWW92Q0VOK21PMWEwZmEzZ0VubTNLTU11U1hhZ0FtRW5sZnpX?=
 =?utf-8?B?TExkRjZPMEMra2l1ZHVlVWJ2bVlBSTc1L2E0eEJmVFY3QTB4TFB5d25tTUVH?=
 =?utf-8?B?bmZmTk5iZW5INFZTVTF1b1BEYTFmcEtRVmlmL0xnVHVOZWpwOGRNb2o1bWNx?=
 =?utf-8?B?WWMvN3VVc2xtZ09XdjRJcURXWEIySmpIbEVtTFhCUXk3dzAzWU1IVDVkZitn?=
 =?utf-8?B?ZjQ1YmtQU2ZyVmpGYW1RZk5iclZZR0FJWWNMSTJhc1ZBb0kwcThra2ZuSEdQ?=
 =?utf-8?B?eEpjNEpzVE03Tk5wQ2xuM3FZMEhrM1p3MFhJZGs0ajhBa3ZwVFc5WEsyd3po?=
 =?utf-8?Q?oBFDkZlnzUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0RyUWlUUVhMeGpRK2F4dDJYejMzVVVwdmJnc2VKSS8zRlVPVGtRZmdYaW1H?=
 =?utf-8?B?N3lnOTd6V2dDY3VHamU2alRncTRmSyt4TjR1YXdkaG9teGc2SVlZZjM4Qmh4?=
 =?utf-8?B?cTUybk04N21xOGRrNXZhM2M3U1JRbEVjdDBzTXhBamV2ZXRQaEZYVDFDZHpH?=
 =?utf-8?B?Z3NKRXB3dm1YZlpsSXNxaC9pOVJZS2RNY0VYVUVlS2V3Wk1IRUtzNTZiZVJH?=
 =?utf-8?B?cWpudHlMejJNTGhUNXZxS0RKZEl3SDRWbVRSRDRDbi9yTGtlM1RmTzJXTjFE?=
 =?utf-8?B?WUJuQlZoVTZLc3BJdVVocWVka0VnRmRMdkszOGRHdDF1QXhnUVhPN05JT1cx?=
 =?utf-8?B?bHBJZ1BIclVWRHFkL2dIQkdNOCsyM0dWNlhGWi81OWZBREg5MXBGMUZaWDV2?=
 =?utf-8?B?YlBTRGJwU05NRUtQVFN6azYwU1JoRlBqZXVSTGNlWFRpUW82NHhPVWN2cGZm?=
 =?utf-8?B?ekd2dFpnL3ZWOXNOWWIxY1dXRmhBTzB6UWNpUVFkVWMrOURUbHk1YlllaGN5?=
 =?utf-8?B?Nlh2c21tS1NjZjQ4a3pXRnUzbTFCRHFOYXBPWWNTT2dhY3RuZUo3RnVnMG9l?=
 =?utf-8?B?S3JocmRReHpPR3RRM0RPcEFyOUhZcjZ4UE4rckpFcW5XdFM5Wi9oekRIYmRN?=
 =?utf-8?B?ZTZwSjNkNDJ6VVg0d1diRVRRTWo0MmVSYjN5M2wraGFzMU5Ua3dGanI2LzN2?=
 =?utf-8?B?OStpdGRaMDcvaDd5Q0RxUk12Y0syTEtmclNlS3VHc0ZHSlBBMERBTTBVaDFv?=
 =?utf-8?B?M1c2NXZBemt6SEppdmQ4YlBQYXRUVUNqY3FJbFFjZzFkVG9BOWlWTG1lSVhF?=
 =?utf-8?B?YUJqelZsajMvaUMvTGo5SHZrRzVoeURka202N2dLamovd2dCU3hPMHZ3d1di?=
 =?utf-8?B?Q053enJrZ0dKMzNNUmRnN3J1Z3c2RDhPb3RZRnBiQU5MaTVsMEI1b2VRb3hB?=
 =?utf-8?B?eFpLRU9TY0dCM2JvbjNFKzBJWnFvRWlvZVRaZnlRdjcwV3B2QldEN3Y0cncr?=
 =?utf-8?B?RExLRjJYbFhYRXZyeW5JUTZOTkd4Vm9lK2ptVnp6Q2p5dnZRVnRKUDNaU3l4?=
 =?utf-8?B?SGFDajRRNDJuN0FML2hCZ2p0V29OcE9weXhEeFk0cUZlOHBnVytEdGFHY3lT?=
 =?utf-8?B?dW1HMHJ4TXpzdUNzVEJkTzB4T1k2Ykh1aGFpaFM4R1lsUkp1NVNtd25qQkxK?=
 =?utf-8?B?bGI5ZzBjUXdiVm9RaTBiRkYyUUoxNysxVlBzWjliZkxkWEQxZVRoeVdjUU9j?=
 =?utf-8?B?dWxpNUNsSVRxQTVBeng1bGtFU2g2M0tJTzg4UnJPRUFQN1dPS2VxcE5uNE9M?=
 =?utf-8?B?QmlSUE9wMjhTMjU3RkM0MEowRFNIVllLbXcwbEhzdi9nZUVKK0wzSEFJRWln?=
 =?utf-8?B?OUJIZ0VjWHM4N29nN05YRDUwOWIwazVyTytVR2g4b3FKL25SQ0RYaWx6MXNq?=
 =?utf-8?B?aHFEMm9vbUFKRU1teG4yR1d2dldmSzVXUWNrVS9iTVlQWHlvYjRYT3dQRnNB?=
 =?utf-8?B?RTdpZVZxcVFMcEc2QWNETXE0MnNMTmFGS0VxTkx5UksvNThlKzNacjZYUDdV?=
 =?utf-8?B?WGdTV2RZVktkLzJPcWs1eU1Wa1diQmp2NnVld3BTc3pGbENzL0dpV3ptY1F6?=
 =?utf-8?B?bVBKaXpGRVprK2g1OCtFbys2R2JFSjNueGdEV2taMENsWUh1d2RHOU9keGVB?=
 =?utf-8?B?ZzlSY1pLcjQ0bStuaHVQb0o0WnFFeFdqaVg0eklRaWlZcUNrSHVLUjBXZlVE?=
 =?utf-8?B?SVVsTmNWMmFpeWYzYnhwWWUxWDh5UUovdkdmcyt4N2dzL0FMSXZqa2hFQ3l2?=
 =?utf-8?B?U2YwV1paSHBUY3JKUmpOV0hRcEQwMllYZ3hpYXE5cXJvVlczWHVGUW9yemNn?=
 =?utf-8?B?VC93Z3MyWkNlc1U0R3IweCtpemthbWFOUlppNGRPeCtmYWxteGVBK2JzYk9r?=
 =?utf-8?B?aHg1WmxQb2dqZHVsa2NOSU5HbVNwM0lJK3QwS3RHRzU3YjFoTXdQamZ0SWpR?=
 =?utf-8?B?UHE1VGUzaUVLbmd4eUZkY3pVa1FhbWNiQ2oyRzg5MHQwZmNBRTFzczRoeEFl?=
 =?utf-8?B?RzdqL3MzRHdpZEh6cWN6dHJnZkRXZllSRjFkYUFjN2UvTnJBcTV6OFB3L3FM?=
 =?utf-8?Q?mbde04Qtb1JmTecKvl6nP0JSZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baaa7f0-624c-49fe-a054-08dd4b998e86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 19:15:05.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItqaGRa1EMamaCNk1aoE3smQpBTST6vITEyk4HUjb1qH4aVvG9yqcWf3ZOGVAczWWN2jnQOvZclmnm2IlRD4oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054



On 2/11/2025 5:47 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors.
>>
>> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
>> device errors.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> ---
>>  drivers/pci/pcie/aer.c  | 14 ++++++++------
>>  include/ras/ras_event.h |  9 ++++++---
>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 6e8de77d0fc4..f99a1c6fb274 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -694,13 +694,14 @@ static void __aer_print_error(struct pci_dev *dev,
>>  
>>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
> I was expecting that this would be more than just a CXL link check
> because CXL AER events are only a subset of the events that can trigger
> an AER interrupt on a CXL device.
>
> Also, with CXL protocol errors the TLP log is sourced from CXL RAS
> registers and is distinct from the PCIe ->tlp in 'struct aer_err_info'.
>
> All that to say that I think this patch probably wants to decorate the
> bus type in 'struct aer_err_info' and then use that rather than just the ->is_cxl
> flag of the device.
>
> In the interest of moving the patch set along perhaps just do something
> like this for now and circle back to make it more sophisticated later:
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..eed098c134a6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>  struct aer_err_info {
>         struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>         int error_dev_num;
> +       bool is_cxl;
>  
>         unsigned int id:16;
>  
> @@ -549,6 +550,11 @@ struct aer_err_info {
>         struct pcie_tlp_log tlp;        /* TLP Header */
>  };
>  
> +static inline const char *aer_err_bus(struct aer_err_info *info)
> +{
> +       return info->is_cxl ? "CXL" : "PCIe";
> +}
> +
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..405f15c878ff 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1211,6 +1211,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>         /* Must reset in this function */
>         info->status = 0;
>         info->tlp_header_valid = 0;
> +       info->is_cxl = dev->is_cxl;
>  
>         /* The device might not support AER */
>         if (!aer)
>
> Other than that, this patch looks good to me:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Ok. I can add is_cxl to 'struct aer_err_info'. Shall I set it by reading the
alternate protocol link state?

Terry



