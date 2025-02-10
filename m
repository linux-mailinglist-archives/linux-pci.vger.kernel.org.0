Return-Path: <linux-pci+bounces-21120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD0A2FAC9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECFF16564F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633502505DB;
	Mon, 10 Feb 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v0Ljxo0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C82505D6;
	Mon, 10 Feb 2025 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219805; cv=fail; b=uRU6l51KLVjx/ih06pXcsvTNzvB0CtDfxFAtWVwNlkhNfvFjysddy2zRFV0rlPp6KsAs8qdsYXj5JcSoLRwoid9T2njokcfafeZSrYWOzeI7sHZ3Tbv4vAdcz0sM91ybq2HqTGPYXX/3tEzaF6LK6OLLxZqwAXNkZGzz/IAKQlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219805; c=relaxed/simple;
	bh=cyniIwNJpR2xHGUplVSdB6601wriWGhT1EnlXYKKYpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L0tIdzjbsbIKAn4yDuvVxZ3NubbUtxloFj+yw7wcXBvcdZv/lCmJjNqBpee3vanZ3JCVRoFc2aEGEAFvnq9IWu0zgKoXfJLDMT8ZoLKGednM/NC7s9qyaMtLEcStyTzx6C6jjWUPudmqOkv5irJJD5LrgiVFn5bB9yjk1V6jXMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v0Ljxo0V; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnTo1pJACDnyJEKkzTIf4szNgEt2wmBJUX7DRvpoksQnM+XSMDRrE4QFHHoPIuSkVS9kuT7lVbjpi32jpg20nqtWIic3LEcEghO/5BlrLQM8GXLeW2jEzT0wFLnheNAaAmcd04Hdutbk3ObT5qLcD9t9xlq7ZQZeDB2GRjlQ5iq57VC4OrA1EkPpo+epLSyfGOyjWWP4H2Bq3xlQJ52qer1QitoX/gQhn7x4FJX8stXzGTG+UDWUyqEOyzwh4ymEBJnxExy751iO/5B06+hdOQwtZRFtHpR2BXJw6mBOH2O3c2vwqCvSNKsZBASKclkewOtJQSeDepWE6gVAA9D8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFIqnLwjymIzl/YJb3u9GpPYbRITWkQFbrYydrcjuKw=;
 b=ocSkxRnEILhDvzRsi6L48ArSJEJnKDmyunwtEM/sBqEXSEmzPlDhdBX1WCQrqt7YWYokX28BROv9ObKbn0SdJsjxrOYhGlyurgLk9KeoLz6rQDH6LKlK3Mk7avXrdojfVs9JCSjXrNMhdV1dCvM16fiaZ/cDGN+cLCiz/FLnD7MDz/0uGsWkFFpFGvBYpIVfnLhv6iOzo6i/rKquDN7pwoC5t1NrRgKAEQXHPJX3Orjsie8BfYsNG7eQ294SEdPvFfGsql4SzvOM1nvSxbNuxs4CUQebC2Ljm5Vu7F4M5+CzLADHONE9rkbfdrbmBJxuXp0FHVqmAB7Sc1AB8si6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFIqnLwjymIzl/YJb3u9GpPYbRITWkQFbrYydrcjuKw=;
 b=v0Ljxo0Vf+WSPQM0W/Oybefob6aAQrynKl71ecCUonfu7qvFvxRhLQPm34eRfG9e716P1oudT1VmcpL7DTIB30b49o//9kSzQFbgZxE9DWO3WN0qd4Bd9DeyJ1PGzCCLLD7XPLTEM2JeGRf46Q1RbNrYu49/otAozsOYG/Aje5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Mon, 10 Feb 2025 20:36:40 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 20:36:40 +0000
Message-ID: <773606cc-e412-49fa-99b2-ef00baa384f9@amd.com>
Date: Mon, 10 Feb 2025 14:36:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/17] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250208002941.4135321-1-terry.bowman@amd.com>
 <20250208002941.4135321-10-terry.bowman@amd.com>
 <Z6pem7NaFiBdcCxy@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z6pem7NaFiBdcCxy@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:806:a7::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd4c8c0-4e19-42f4-9595-08dd4a129f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzJpNzF5L1EyemFNcXduS3M1cVhXeFBvdmE3bzI2VTl5dmxMWk81bEJONnUr?=
 =?utf-8?B?WkROYWFqL2NaVUhRUEMweXM4UmVaV2tGeU5CUlBGc3pvRmN1bWNNbjNScldK?=
 =?utf-8?B?S0JhYUJES1JaWGF5Q1kwVEFmWDZzQkJ2aXhGMSs2RzlrazhLVXIwNDdnbVha?=
 =?utf-8?B?Z0JmZDVrSFJmZkZ6d2ZLelIxZU4rYWZ0Qk5LQXA4cSs0eXRlUk55cHhtM1A1?=
 =?utf-8?B?UlpHa0RrUE9Pd2daQ1NDUmpJdUdqQkJHdjJJWTlEdnluakQ1Qm42dDN1Tmxl?=
 =?utf-8?B?NEdnMUFzOEJVcHB2TlRwK0xpTXh0ZlV0ZE9oNDg5TVVYemZwZ0s4b1Qya3I1?=
 =?utf-8?B?M0Zuc21DNWREWlZ4UGpRNXJjcGxWWm45ZS9wL0Q2cU1yaERJME54T3F6dGZK?=
 =?utf-8?B?UkNydTlpS3daaExubGFwTXZJRjlXT0oxYTJYNzV6c2VuZ3JEWUtDOW5Cc2JG?=
 =?utf-8?B?RkRENGQ3NWdjV1lTTFJWVWxZZ3ZOZ25EYURYU3RXTG02UGhod2ExOHEyU0hv?=
 =?utf-8?B?QWNLVUVqbjdBYXkxb1BMNFZ5akZQSlJpUjdrdWhydWFNcllhZ3dITHMvR0Zz?=
 =?utf-8?B?NWowd1hVck02ZU96eWdxRGh1M3QrVmZtSUFwVVVRK3NZaTVCRTYyS25kaWpP?=
 =?utf-8?B?L0xray9GT2ttUFVOU3UwckdZM3htYm54K3o1bXoxcW5vRjFVcjBCdTA3OEFw?=
 =?utf-8?B?WXc0Tm1KSEZhUWZheHd1aFpldXZvelNRYm95WTFicVVicFF2dEQ3T1h0ZGJi?=
 =?utf-8?B?eWdJUXl2RG9NcjYzTEhNd3RZd3FFSjNoKytvWDNDMDdWcFRBZ1RENVVBQVdq?=
 =?utf-8?B?c2M0a3FyNW90a2NRQWRrN0Zha2Z1bWNlSTM4RmZWOVh6VVM4Q2p4VXlHOVFk?=
 =?utf-8?B?OW5YRjdvQXBuMUM1cTNxL2I5ZE1NVHpMcWxoNVR6ZXNoQkpTTWhmRC9BU3BG?=
 =?utf-8?B?MFdRYmpMUWVucXJLbk1ZVDQvVVJWVGlBVk9jM2NvMFFGR0Z5T1h2ZTFHVUpo?=
 =?utf-8?B?a01hNUo2TlZVMHZnNkN2ZldaOFpFYVpXVktlcVRvMDlOMGt5cXdad2V2TEM0?=
 =?utf-8?B?OUZwTFdidzIvYUtLWEdrVnZ3YStZQkN3OFJYNWwrVC9xaEZjRmdkRGw0TGN2?=
 =?utf-8?B?a25PcnZNd1RZS09ma2RMVW9ObHJQOEZjQnd0ZXJlb1VNVE9rNVRERGUwMUdP?=
 =?utf-8?B?c0JudlVOemtiNmo3cktqSTN3UUszQXNuOW1vbmQ2YWx5Vk5KOGtqaVdMWlFR?=
 =?utf-8?B?SlhCYW1OdnY5QXc1SSs3ZFRQdStjMVl2ZlJ3YW9RODRRcmx4UGdnM1k2dlVa?=
 =?utf-8?B?QlVFZVVjbWl4NkdZNTNOZ3QwZWtHbU1TREJXRTNtQUpKVXJEN0xrUDBNQ3VM?=
 =?utf-8?B?TGx5UFJyZm9YU3ViTXJzTGE0ODM5Z3I4TUZoTEVkK1ZJRVpjbE1zSUd6UkFt?=
 =?utf-8?B?cUkrYWNqN2NDODUyenJUYkRnZ3pzQUtuSHczNmlwS1NTZk9jMVh1d2RDM0pH?=
 =?utf-8?B?SmNzYS91NkxYYk1oMWk3Slc4blVzaENGb3RIZ3VuZXhEbXhxMnh4MlI5aC9U?=
 =?utf-8?B?L0llY0g0QURWTXZQR1dxdlU2bHBHT2RmaGxaVHRGQVlmR1BVWWU5anBKU1hp?=
 =?utf-8?B?dWVVOXNHU3U4NW1rWXdqbDBUR0JYTjVZcGxHYkhYdFdEYjMzMDRzRHBHSWtW?=
 =?utf-8?B?S09mc1JiZGI4eTRtS2JHMC9EZ24wT0lPRHBBVzdpYUNOOFdlelZHdkdDVDBJ?=
 =?utf-8?B?UUdJeXkxc0NwQVV4L0xyODZPMWVFUEZ4dlhwaGdwTWExR0FUMmtHeXBkZEFK?=
 =?utf-8?B?bktWeGtLOWxQb1RTNWV5TUhlaFRaZW1GbVRnbkpEdnA2dlc2VVoyaTQ1TTRk?=
 =?utf-8?Q?O2ZD90duT3Cvz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2NvVENCQWNOMlRPZGtkY1dPUGJDUDBWV210R2dqRFc0cFZkeEZkWmVjZXZq?=
 =?utf-8?B?ZHpKcGp4UWkrZ0YzVjlaV0IzNmxrdXZBNnlZa1NKZGh0MWlmWk02Sjh6Qmo2?=
 =?utf-8?B?TXdKOE5JRUtsY3JMd0xYSTVpTFhscXRKSUJKZ3IxS1M0eit6b3VOTGpOUGlT?=
 =?utf-8?B?b28xUGp4T0lIOVNoRis5aGQ3bGs3elBEcHRkeWdieFRvUUpqd1AvQTBKSUVJ?=
 =?utf-8?B?S0F2a3pFSkRwYjV4VGFxMFV1RFB4RzVYWTdsOFdia3g5SXd1UzZJaTU1Y3B6?=
 =?utf-8?B?WUZFOXFvdC9LYlB1b2NEcktFZEN5MzZzKzBzSGI0aFliODYwTmViZXVySGs5?=
 =?utf-8?B?Q1BJeEw2aEZZWitROGU5YU0xb2ZkMjU4Nnhsd0djQ21qNW1mNVo2ZURndEFT?=
 =?utf-8?B?bW9ENjN0cXQ1NVY4TC9WbFNyam9WSkdmMGdOV2NIdVhvRlRQd2w5NEkwZlh5?=
 =?utf-8?B?Wi8yZTU3ZFFPdVJ4eUdzWlN4R3NKN1hHRUUwWCtIeko4aGQ2QnZPMDFCM0lt?=
 =?utf-8?B?Ym9NNWhZTG1vVUlwVjF2UU1LSFE4Wk1YUmpBM1ZobCt2WUZPM3d0b0JpQytZ?=
 =?utf-8?B?MEg2NjA4YnlNcStTNE5POEdkUmwvblhCVTBjcDlYakU1dGFBRWhXcUQ2Qlhr?=
 =?utf-8?B?OC9NM1d6VWdXL2RBWXdTLy9GdzJNWGlTV2ZMbnNlcDQ3TjFtWlQxTStoMW1H?=
 =?utf-8?B?U3lNN3hlbnZHaDljKzczTmRTMy8wa2p4dytNVjlpSTdWRkFzQ1o1RUxYSlNw?=
 =?utf-8?B?aHBTeEVMcjNWRTVDUDhOeVdyZ1NyV3J5RC9TY3hzTENkRFVIbkF0S3hnVXRt?=
 =?utf-8?B?UFBkYTVkeGZqUS9pUVlEMFcvTlpjZVBzU3cxRFJ0aDJBaHcwcXlINW9jazZK?=
 =?utf-8?B?RnZEK3RicG1WZFRCNTZEaVd2enRzQkVXRWJDYjduV0dHQUdZbHFGRThVUWZa?=
 =?utf-8?B?UEcrUDVjcCtFaUxRMzdkbzJvSzhEOHlBaCtJRHFDY3lQaDc3b1BiQTZ6aVNa?=
 =?utf-8?B?WGU3WXpUNW9KeVJOY1Yva2VKT2RSWW9ZL1RNNFlXSVB5elVJbkhldG9YaUpx?=
 =?utf-8?B?ejdkU2d1WXlYVTdlNnZqVzdadW56SVdvTXZCbDExTHhISzM0K21sbStqK2F3?=
 =?utf-8?B?UldTNUkvd3VDT1VJNnh5bWFEek9kUmJPRGNrRklDN3RPcEl0TXRlOGIrTjc1?=
 =?utf-8?B?MFZqVmpNWnNhK3hLcmVFR2ZIL2ErbzQyZG5OR0dWQW1lM1NsUFBDcHlxcEhB?=
 =?utf-8?B?ZDZaR0czcDRaTjZDaStlSWsxZG5mMWFyZGtiVFlEOFcrV3NLVi9IUTJuMGU3?=
 =?utf-8?B?NUxwd2dVNklVaEU1V2xXM0EzamVETndKcCtUN0xlYTZkWWZjUkJwS2M3QnlP?=
 =?utf-8?B?RXVFSlN1VXY2SUpKOUtIMHNYTkRseUhNcHR2NXBLQ0pUUDZSZVI3V0dFVGw0?=
 =?utf-8?B?S1gzWjhwZ3N6ejhoQitjOTlCNTZZdWtPM3B1S0U0c3BTRGdQa0NFVnladVQ1?=
 =?utf-8?B?UE5UR0dlS1BaSmc3UGhHdk5VcWFQSWxXZ2xOeC94UWJDVzZDaTBsTFNzMWhB?=
 =?utf-8?B?UzZRaTBNTHNZaEM1cTBMY05yUjYrZVNxdEVpQ0pjaGhIKzZLR1FWMm1rekpu?=
 =?utf-8?B?U0xXYnRWZ1VieEdrc2hqd2ZoYVZsRWtLNjlURmJsa3VXUUVraHZPSEhFYU53?=
 =?utf-8?B?VGNNS0FQY3VMNEE4dnk5TVl3ZXBkc3VkajBMcnQ0eVBtMlkvYUQ5UmxSRjVL?=
 =?utf-8?B?Zzc3eHlIS1VsWW9ua0FwLzNHOFlnaUd1TUQ3ZGNEL25jeTBUZU9IcGg2V3VE?=
 =?utf-8?B?REJmUWVRLzhvb2U1WG0rcStqaHlIRnFuN3ZTa0tHaUt2QzZCT2pYNzFyWDc5?=
 =?utf-8?B?ZUN3T3lQUnorTnRtQ1RWMVJkYlRGaTE4VktmYlFUS0V1ZzhSZjV6VWx4RXcr?=
 =?utf-8?B?anpzMDVmK2VWSEZwek1PeitGRzhrZGZlbDNLN2ZsV3haSFRRQTVuc3U2T3ly?=
 =?utf-8?B?bXBGUGQwR3FNM2M2ckZhWEVINXdHYTUySHBnRlRpN2ViclJwK2NXdDBCM2Q3?=
 =?utf-8?B?NTRZK1FkRTZ4RWhoUktGRVR1OHY0U3NQaTFMbHhQVnVPYU9VOWU1cVVUN1dF?=
 =?utf-8?Q?r3rSYAbHOEVwK6i3srmCq+OGS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd4c8c0-4e19-42f4-9595-08dd4a129f4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 20:36:40.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3unGLVMWEiQkw4nrCXU0e+clQXgQcrx6XPBa9HuAbYFHL1HTmU7Q2vBvw6gAvU9X954JyyOnFUzdO4XLER4jlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126



On 2/10/2025 2:16 PM, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 06:29:33PM -0600, Terry Bowman wrote:
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 4af39abbfab3..0adebf261fe7 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -652,7 +652,7 @@ void read_cdat_data(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>>  
>> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>> +static void __cxl_handle_cor_ras(struct device *dev,
>>  				 void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>> @@ -663,10 +663,8 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK)) {
>> -		dev_err(cxl_dev, "%s():%d: CE Status is empty\n", __func__, __LINE__);
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>>  		return;
>> -	}
>>  	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>>  
>>  	if (is_cxl_memdev(cxl_dev))
>
> This seems like where you actually wanted this original change:

You're right. Somehow I moved a chunk into the wrong patch. I might need to respin this.

Terry
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index aa855c2068e0..a0c78655a8af 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -714,7 +714,7 @@ void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_port_prot_err, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +static void __cxl_handle_cor_ras(struct device *dev,
>                                  void __iomem *ras_base)
>  {
>         void __iomem *addr;
> @@ -725,15 +725,19 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  
>         addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>         status = readl(addr);
> -       if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -               writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -               trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> -       }
> +       if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +               return;
> +       writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +       if (is_cxl_memdev(dev))
> +               trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +       else if (is_cxl_port(dev))
> +               trace_cxl_port_aer_correctable_error(dev, status);
>  }


