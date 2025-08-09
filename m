Return-Path: <linux-pci+bounces-33664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB83B1F445
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 12:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D0B18C5A9B
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6A25A651;
	Sat,  9 Aug 2025 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3kSipXd6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690025A32E;
	Sat,  9 Aug 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754737025; cv=fail; b=NciCCtHgGTlg3DbK8SC8GnhaHQYvymteTqlgVbG4nGbijZ1fK3YxNk81Ndt0xFH+oDzUmXe/kIrwmJGD7Tkmisxi9f/o4PpSj1UJCXFIvPmS5/OwJRepSwGxt31606f142fUyvGmFEnNSEq+AQUsoWrU5wmmkv+tb4bZR8ceR8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754737025; c=relaxed/simple;
	bh=ih/K8GfnE+6YpaORjI0W15qoqgA5/GKdIvmHL/Th+VI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lChWsbAP4Ts9aRO4qyChnv01tXUlXPFcNFqZvEO/E0Uu82qlVMe/h1QQNBdNTH/cvnssAATL71W16mPoWQIYpb/NmH3aoFz2eAiYDaH+7sJOGw53FHg70nqtgJw9Z7ILnwX0uHOhngDN7a6vg1GQjZaTslFemAQBoREzeSZUdZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3kSipXd6; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHh3lRKRqQnwyW3Ol5NTOSQ0078akRQGBChi8Qe7tXau9gfxbZ7s6ArdlMUbaQKwh7DnPwtIl6haEp4HNgtsr3fumu5Y2MgYxox3Se0kX1LsFZHAeZQQv/zU6gB02bIndBE5gGS2zhQVKAx6eALnxfeKGGfZtgAK3dv2VzX00MujRmCPd712waUAhGbEsiDUUj+y5IB6jxkY9RAkkuKN5FkOdvnTu8NTEnjwCel8ASrkD8oS/GKHMFGEBdnby/tle78nVv0W6HcSwGofkJxPxHxCHb5oj9GWlQtMAaI2U3weFJoPu7fyqJCHZueTE6NgWVuGU+QpnNiUFFYPrik/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrsdzPj3Gyxy0D0LbVJLUR3NpxmdKtT9oMwBCELrVns=;
 b=bTHFSDMx8DXfKUFQSWPvwT+tXV/ChfBJUxs/WNvcUj2RTSAJ88Hv5qP27G/vV3yN5kiyzufk5Quc0PfFftmJYxlCwWeLIuvWRCr5tvS2dfomWcWy6XUyD7AEP9pu4LWnTcx4TM6Jys8M9kscVxjOsmrnT15srKl8jekeUzpiHtcNdxDem9MiTC8VNWh6RAxA7mCz6cl2tUzFRW4sTKGXD1kyVFuWZWiIWijU/503MpxOIaUxNEWHXtNKXpgXMbWjyL9MIkcOTt/qRsyWGhxwk49JoG2sq+UIdNHJ1A6imoAu/Of4CAJxwMi24gnV1VdxkYqryoxxkStwEE6Dlzew5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrsdzPj3Gyxy0D0LbVJLUR3NpxmdKtT9oMwBCELrVns=;
 b=3kSipXd6JQWGV0k7RyIVaetR7DJanESjUe84I0YPjHY/ojpeoNC0Rd5XYWRN7f4R/jhzd3ttYqMMhOovjT2YsXrXlNLkggEj070jSysNwY/l8R+XmyGtWIJBZ6/sSOzPBGzR/yIi9Nr9pOeC0DNQSZWsxIAbaU62x/s9kZ7aQic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Sat, 9 Aug
 2025 10:57:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 10:56:59 +0000
Message-ID: <d8aee8c3-55cf-4aec-afc1-21773759d193@amd.com>
Date: Sat, 9 Aug 2025 11:56:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/17] PCI/CXL: Add pcie_is_cxl()
Content-Language: en-US
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-3-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250626224252.1415009-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c1dd18-8210-4681-f833-08ddd73376b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHhCbGFoUU5hU1A4UzJ5Q0txTGtRT1pIMGZSOUhTSmFuYzQ4My9uVGZmSlFz?=
 =?utf-8?B?N2lwdmEyWGp2aGpJQlVrM0UvenRld05wMzNWbjJmajFDeWpyRDNWeEhtQnhs?=
 =?utf-8?B?My9scmdFQTV6RUlzVG5Pa3NQWVhYWHBnV3BEYjZjZUtLSUk5c1JaQ0xsWElW?=
 =?utf-8?B?MWRDdEduM3ZzZ0xVVFBtTFg0NFdYZzNhTCtNVnpOSTZvSTFqS01SMzllUlFI?=
 =?utf-8?B?WXVtOGRrMHRXUkx2dVdha280RnVUTmxJcUx6WDlBcXAwVHduKzJFZER2WFQr?=
 =?utf-8?B?STBORE1CWWxNOUxXTkZmV2VmeTdTQnhRVng0cytzTzFFQ2Jhc1V1V2U1R2pk?=
 =?utf-8?B?SFQ5ajQxNVdaQmhycXdyZWtKaTR4aHN5VkNTdVhyVTl1TTlmUVA1djByV2Iw?=
 =?utf-8?B?eC9KL0w3TVRGWjArYmxMb3NGdCtyTXpJaWd0dUpJV1ByRkxPTStiWms2SXlz?=
 =?utf-8?B?TEt6M3ZXVGpubVZOTDBtYzZXMXRhaytPYjg2WEI3Y0ZNaGhQd1orYU1iTWxX?=
 =?utf-8?B?S1VSQWxhWGx2Y0k0cGNWTUVSQmIyN3ZveDg1VExoOGsvaXc5ZTVzNmdIalZ6?=
 =?utf-8?B?YXVodjBmU0J1OGdMZ2duM3FjSCs3VGkrUXlLT25iYWt3ZHY2ak5zK1gvdWx1?=
 =?utf-8?B?d1VlSXBIdGZYQnQrL2YydTZUbi9EbWc3cDJjcjFtcDF1cEpKKzBsUnNiUFQ3?=
 =?utf-8?B?OHZNNXdJYlFZaEFzTEJZVzVLaHFRR09WckluRndPTnpobnY1aXloRFpKam5C?=
 =?utf-8?B?czV0SUxJYmk0T1hGMzNqaTNDMGdRRVJob0JNTlQwZzQwYjBEaXkvekN2d05R?=
 =?utf-8?B?NjlSNjU2N0g5Z21vTk5CeHcrUWEzTEVlS1c4UGYrTTZkTGtqdzVlOVVoTXpG?=
 =?utf-8?B?M2tMbXM0R3QvT2l6WE9FVUVnNlBONUtrK25CdjM3UkhENWFmQUE1eTI5V290?=
 =?utf-8?B?cGYvSHp5amJvU1BNMnhtR2VpZHlVRVNKeXFWODVZNnp0cUJoRVBzQmhGb29u?=
 =?utf-8?B?TW5yZ2paNTVYcFVWVTd4ZkJVOXpreFErZjc2eXhseEVWRXMxallYblprcGQy?=
 =?utf-8?B?R1QyS3VNRnJnQVhqbnBlM2RhQ2Y5SmNuU3I0bEVGNnMvLzB5S0l6a1M1YTht?=
 =?utf-8?B?bWNOM0tyNlBiRmtZdHpUL0U1alFla0o3K3k2Q1FZakJmWDgvSWJ4eGlGMmxD?=
 =?utf-8?B?Yks3dEozaEFjeXpRU0pvLzZpbHlLM3VGZnZVOEM4cWYvRW1ESTFaNFdHbWdP?=
 =?utf-8?B?dFdRTEZSaEtjbkdscm5sZ3dSb1pUeFh5THdlRHdJWTU3ZnE3K254VW5scFVC?=
 =?utf-8?B?VG9LZjRCZmRlNUZNdGUxcjZ3eUNqZHlwc2dXeVV6aEJXNEg5SHpJM3BwRXRT?=
 =?utf-8?B?MEF5UkNkS0FrTUFOcEIvYVhQcHV1MFJZVEhDRjJSODZzeHNzZjJpZms0bURB?=
 =?utf-8?B?dnpvNWVvZ2R0eCs2MHJWVk1EVVlldjFSNm96QUQzVHlCc3E2THVCTnF0YnAr?=
 =?utf-8?B?RWpVTmNuZjRlelQ3bG1HbzFiMTFQMmR3eXFFclYrRFo5N2JoalZuelBoeDA5?=
 =?utf-8?B?a3BOU1EvVytQc3NjbHI0cjdtTk9uZzU4WWdxTnRXZVdoMDhHQzFTWlZIajRK?=
 =?utf-8?B?RnFBZWVTRlFCdlVGVEo4a2pmeitPUGZkdkJDYm1wbHA4UGMvWXoreFNlMFE0?=
 =?utf-8?B?ZGtzUERVQTBBZzhPcWVqRkhxSzhhQWpZVnpMdURyckxDVGZxaEZpOGVjMG03?=
 =?utf-8?B?L0xWc3ZVc1FiT0NFeXAwa0pDbjBpaERMWUxXSkpsVEFrMDdjTE90NlZpbW1W?=
 =?utf-8?B?VnB3dnlRQ1ZxY3Q2RHlmdDYzTWw2d2ZzdWZRUmNtL254R1k1WkpSWlVxR2Ey?=
 =?utf-8?B?KzhsVHlOdTZnTUdyZXY2cXIza0pibXRKSTd6SlpRZHdYY0pBREZJNk90aVdh?=
 =?utf-8?B?UUNla1gwODB3dG1ZOHJsY3BuMFdmZ2x5Z2hMaHhHK1NSZlVWSU52NUVzd0NP?=
 =?utf-8?B?SUR4R05uMkVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUp6WjJBWldFRGZJcnRLUWo3SEMxa05PZE1aT0NmNkJ5QmsyYmlXVjl4MGNn?=
 =?utf-8?B?QzFFbytmdWpJdUtwMEdLSFJORFE5WTRodWJiVkZUWEVLeEFDcUFVRHdITWFN?=
 =?utf-8?B?UkM2d3dXc3NRREI0SkJxMlNGUDZlTktzMnpNYUhDUmxYNTljbHg0NFAvend6?=
 =?utf-8?B?RHdPL3laNmhFYjIvRFQreTlIQTJ5MW1WWnpMUzk1anpqQnFhYWpCYTRpQzMy?=
 =?utf-8?B?SU0wWGtscGxOUlduQng4YVZ6blByMkxjYjRnTXV1UXgwYk5JdzdHVEFpV0dT?=
 =?utf-8?B?Q2piOEk2MS9Tdk4xL2x1OVJXdnkyWTZORjFXNEhCRFJ4Q25aOHZHV0tLNVdH?=
 =?utf-8?B?TmVrcWNBbkQ2U2VkVHNrbUlVd3g3TUJBSzB4alJ0ekZPaXdYenVPYWU1NW15?=
 =?utf-8?B?UVpxK0dZcXBHc21tdmF0djR6NUlLb1JoQUdYVTk0WWs5bytUVUxvckVrdjhB?=
 =?utf-8?B?TWtLbG8xQ0pLSjljZ2FZd2cvWkt0Z09BMDcxZC9IK0JOUHBLcXdGdklWUGJp?=
 =?utf-8?B?MlRiakNITzg3dTZuaDVab3FxRHJ2WEh6ZTdVbndyTnh5OUkzS2pCUDE1UEtK?=
 =?utf-8?B?cmtySG96eHpYMUxCNGFwY3lUQ1B6TXh5RVRMT3AzRCtnQzZnMGhUL3E3cktx?=
 =?utf-8?B?d3lzUDVaYmVNRjlkdGQrWDJsdzYrTFNSWG5WbEloNm5vay9iN2prbkd1WkM2?=
 =?utf-8?B?cjBmV3FsV1JmYkFNZUd5RVFabTNUdGlxMkF0OGQwMjNuYlZ5U2drR1RxOWRx?=
 =?utf-8?B?WjBTMkxOSHVkQ0ZUVWZRWlI5U3pzMkZvTmdySjhlbVNPNmtVWHlLQUlqc0FJ?=
 =?utf-8?B?WER6bnYxKy9DQ3Y2WXhYRWpRYzB5eTNqN3IxWGUvOTJFOVVWTU4wdUlJdkRW?=
 =?utf-8?B?Ym5qb1o4dWM2SUxSeHl6K2JlcjZCUi9Fc3RabUsvUndtOUpxL1pWcVArY3V3?=
 =?utf-8?B?MlBqaGprOHc2cVV6a2hlRnlURk1tOXZPakNURkFIdlM3T0xWMk9JRmdvbzky?=
 =?utf-8?B?cC8xSFl4NHE1bnp2YVNwMUtEVW9mRUJKQk9td0wvd05JYlFKUjRYcFVSbXlM?=
 =?utf-8?B?NE1pdVNLWnhMRVNDbmpDYTNZS1A5eENhaGtheUZaMlF4b1E1dVFMb21VaFpj?=
 =?utf-8?B?Q3Bkc1dUTjhPNitlbWN5TjQ3cStzbWpoYkhoSEdxTklLRXBqandjM05BZ2Vq?=
 =?utf-8?B?NXNocWZMVHJvTUpnRlZMZDFvWW83MWEwd0VJMU1EbUliRWp1VjZvMWlVc2w3?=
 =?utf-8?B?SWJiTkVwTmVGRGVPZlBVdXgvczRRUExTd25zVE1SMkVNZkNCK3B3eGthd0dq?=
 =?utf-8?B?Y1JWdTBIRlJ3bWtReUxwZ0djN0lKbmhCVlhBT0NsSFZPSmN3UFU0T2w2THpB?=
 =?utf-8?B?UHhpVlFRQ24vd1B6bVJ0Z3ZMQ0NBbGVNL3FGUlRwazgwRmpWamVVc1kwKzND?=
 =?utf-8?B?ZkZGdy9LMVpLcmd2cEVlV0hiVnNtOGFHQjUzc0pqZjl1MDhnanRyZ29YZXVR?=
 =?utf-8?B?bk1TTFNzRGcvMmNuY29ZanY4VHJBS0lMenJ3UGo2dlkrZnNCTVNMNjhFMHVy?=
 =?utf-8?B?azBUa0l2aDlWWHhpNEtJb0taT2xveWRWM3ROT2JGa2lTUUhPR25NRloyanVM?=
 =?utf-8?B?Vm9SbmtTYVh1RDZPTjJzdnZOZURiVElCMGJDbWJ3QzJFVThNME5MSVdnbThs?=
 =?utf-8?B?TXQyTkV0OVl2RkJuOC9UM0Yrd3NoRUVMaEVYSUNid0tSUnNBN0dTOWhvdjVG?=
 =?utf-8?B?N1JWeitOMlZuWUxseDlZaU4xcFZOOVFpa2JaZVZVTkt6WWpORHhLWU80QkFU?=
 =?utf-8?B?WUQzK2tyK1JtZnJZbjVhODdXUTV3T2dwOVNHbkpabVpJVm40Q3hjL2FHNnFj?=
 =?utf-8?B?NTBuZWw1cXNlb3kwWTdWdTlPdnMyTUtrWXF2a3Fhd0RYMEZNam5UcXZZVTV1?=
 =?utf-8?B?UFhlWFRlUWo4dENmcFAxTUFsbnQ0Tm56OFJSMTBDd3lGM0NjT1NrNlE0YllP?=
 =?utf-8?B?MEhzZHRvV1N0RE1BQXlibXlyUDdtQXpjdFpDYnI4Z1VRVmlQSWNqc1RwclVj?=
 =?utf-8?B?UkpobjlXcThxSVIrUi9jNzRxQWJYcFdaWm40U0pyMS9aL3VYODdGSGpDTWdY?=
 =?utf-8?Q?AaAgMvyNER0VVejUmFUgCrynK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c1dd18-8210-4681-f833-08ddd73376b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 10:56:59.3508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCDSB0OWPYy+Y0zAUdZpQmxivUUrBpEY0OE6htHd+aRvXTJYiE0nxLEafbodz3AvjVb9H+2RLruPlBBihieSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326


On 6/26/25 23:42, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
>
> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
> CXL Flexbus DVSEC presence is used because it is required for all the CXL
> PCIe devices.[1]
>
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
>
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
>
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>      Capability (DVSEC) ID Assignment, Table 8-2
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/pci/probe.c           | 10 ++++++++++
>   include/linux/pci.h           |  6 ++++++
>   include/uapi/linux/pci_regs.h |  8 +++++++-
>   3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..5d3548648d5c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1691,6 +1691,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>   		dev->is_thunderbolt = 1;
>   }
>   
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS);
> +	if (dvsec)
> +		dev->is_cxl = 1;


Hi Terry,


Should not this check for the bits about port status like IO_Enabled?


Maybe I'm confused with the goal, but we can know a device is a cxl one 
without specifically looking at the FLEXBUS capability presence or not. 
What this capability can tell, and what I think it is more interesting, 
is if the link was successfully trained as CXL.io. From problems we have 
had while testing our type2 device, if the training for CXL.io fails, 
the device will use pcie and this bit will be 0, same if the device can 
be configured for using pcie only.


If this is what we really need to know, changing is_cxl to 
is_cxl_enabled could be clearer.


I come here after Dan suggesting to use this functionality for ensuring 
the CXL device functionality is on, and it would require to inspect the 
status instead of just the capability being present. Maybe I'm confused 
because I remember some patches from Robert Richter dealing with 
checking link up for enabling downstream ports, but I think the goal 
here is different.


> +}
> +
>   static void set_pcie_untrusted(struct pci_dev *dev)
>   {
>   	struct pci_dev *parent = pci_upstream_bridge(dev);
> @@ -2021,6 +2029,8 @@ int pci_setup_device(struct pci_dev *dev)
>   	/* Need to have dev->cfg_size ready */
>   	set_pcie_thunderbolt(dev);
>   
> +	set_pcie_cxl(dev);
> +
>   	set_pcie_untrusted(dev);
>   
>   	if (pci_is_pcie(dev))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..79878243b681 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -453,6 +453,7 @@ struct pci_dev {
>   	unsigned int	is_hotplug_bridge:1;
>   	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>   	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>   	/*
>   	 * Devices marked being untrusted are the ones that can potentially
>   	 * execute DMA attacks and similar. They are typically connected
> @@ -744,6 +745,11 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>   	return false;
>   }
>   
> +static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +
>   #define for_each_pci_bridge(dev, bus)				\
>   	list_for_each_entry(dev, &bus->devices, bus_list)	\
>   		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a3a3e942dedf..fb9d77c69d5f 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1225,9 +1225,15 @@
>   /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>   
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +/* Compute Express Link (CXL r3.2, sec 8.1)
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
>   #define PCI_DVSEC_CXL_PORT				3
>   #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>   #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +#define PCI_DVSEC_CXL_FLEXBUS				7
>   
>   #endif /* LINUX_PCI_REGS_H */

