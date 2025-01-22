Return-Path: <linux-pci+bounces-20219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE3A18B95
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 07:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EA43A574E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 06:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0766D1714C0;
	Wed, 22 Jan 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uES8Zf0Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC172EAE6;
	Wed, 22 Jan 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525793; cv=fail; b=RXFQpWMuZ668fShjbFzIxh9uW6dKSK4jCB6kr4ZIrikd0P4GSfKI/5vPn08X1mxhfbgM/hdxh4wsjNuA5mk4rNAhNZvoFBbBzB2c5Can7jnAo4cwrnvgjHRCJvtWj3UfEfbOzeaXbWC5NcvSbLfHN4k9051BYFQi8I+UHOidklA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525793; c=relaxed/simple;
	bh=4r3VHtDRTkqmELhykrT1t1Fuo1948zGpOJNdQoBdnOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJ72mx5ZMIxD/0tYhXRkAess0OsRonucWxcO7O1uMGPINRuZh+ToEvcp7gJABMHfTX3XYUKOUHnFJd8h5RqqATYE5S7j8AhCSrA1vQbsfN9oqHb+yp1dPjY+geSCTtkc//B/+OPcfk6eyNuPv3piYXWPHDuNIkWRuKN5aO8AKT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uES8Zf0Z; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV0AgC00Feh5h5WS36TwAE2cnM0rmCjDN96eQBeHQUcNMAx0di5pffUFyA2/IDDwkgHd0oL0jyOACy15cheSqUJcuzppNfBhnRCvAskMFz4pgtagtRgMZrWj908XvDH9G8BeXmvWZf+goPGNxNCBKVZLOZK5Hr+B6xcz2wNFd4DyTLNixNEBd7bU7peNBcGBMEk7JkJPUrBBt4GxLIyYSfHdkAPmiztKbZf3qjT3t//JDxttx5GhSAxCh3Eb2/FI20W/+6FVOT8ZAlmNMCD7p4kikrwI/Fi/GykHRoq87nKMtfna1CfU1MEtI0Brgje5s3bUxB9ieCvEB23cpiff/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obzKP+yiXmzemhDeXm2+MRBxOqyvH5Zu9dZMZe+0t90=;
 b=bCwyWa/6ABiQVluZhffbAXtROxB0vKUAl9/EOlbsJgmOsknifoNDBQMg5Sq9BV4s3d+UHmkjggJsYrXETgfIoEClGC+cT47TL1fo3Qr7Bw4zuHCq0LWwdWTcR/wvu6l8JHlLHXzwRHQnh7hGtR1JDdo+Wxg8oT2uEa4feXJTfxn9FK1dsdkp020akAHGFPD14M/PqJhp39GsZ9A3rqDHQr+d2w5ADSG1iwhA1DdjIbK3PZTIiU0atzFhDTT4byhzMBgIlQQEz8U54fjooiJiTS2IiXSc6yUeZBdYxEXzZ60H3SD2x/Iehn4vgtYsn1zPNGp8PFGUW7RZ1h+l8eZHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obzKP+yiXmzemhDeXm2+MRBxOqyvH5Zu9dZMZe+0t90=;
 b=uES8Zf0ZlYF+zdS68ispp17u1SGQSJNWZNz+OPnTUi4VDiY8sVaj1LpbKzBAe7HnSo7QBp2s6TEcaY4p+y4/1SP5d7xNVaSfYOJN1Qx3PbLbdWABXXN3hOnP2WKE2KZjEzrUh0odvGaG3voPBOkWhDl5ECbMyY4lnKmjPO8wuP3AGsIyFtgTV//E0YmSvFZeCM49qvTtXKx8BVXjy5Nlc7JD8dzJxi0N8yzB7Is3x7TDgLFiLJbUhYxwWTTiimffERtDTY+6AGCTOqaEwLX54QbNvCUWW544GtS602S+O9mFRnLgImMXVLuOGuW5SLz5xVvLwXgsxV7/PpGZmu84Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 06:03:09 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 06:03:09 +0000
Message-ID: <11b41380-9ab1-4628-8e1b-2a71a7b92a0c@nvidia.com>
Date: Wed, 22 Jan 2025 06:03:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
To: Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>,
 manivannan.sadhasivam@linaro.org
Cc: kw@linux.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com>
 <87FA054A-053E-4E73-94D7-CB9F4F655053@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <87FA054A-053E-4E73-94D7-CB9F4F655053@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::20) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a914fd0-3b11-44b3-0adc-08dd3aaa7216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aytNS3Z5ZTZtK3JBd3NYeG9IaXlxUE0zbGltNGNrc0MyWEhXdFEvR2V6aWw3?=
 =?utf-8?B?UlhycklrcjRqZ1cxeUt4clB2SXVTUkdLOFV1OEtwUDNrbzRnSUc0N2lPd3Rl?=
 =?utf-8?B?RGpQUS94aUpzeE9FdzY1NzgzVnltSEVKVk0wS2dIQ0pXdytiUG9QU1hPa2hG?=
 =?utf-8?B?TXhER3NOeVVTT1dhc2FtWld4dERKMlZyVTJEelV2OXVJVEJ3b2hkOEFweXY4?=
 =?utf-8?B?RGszYi9rTnY1MTR2emVYSDExUU1tZ3FqWkZ1SUpSb3JoVWJkUytFWWxmZ3Y3?=
 =?utf-8?B?b1grRThodjVwUlF1SXBBTGg2eDhJblFVRjRrOG9pMXVuSVVldTVyZlM4VnlD?=
 =?utf-8?B?SlQrTWc4K1FzWE12dzJRQlJEOSt3NTkyb2RuejhydmhTeHZpaFdYZVRZV2I3?=
 =?utf-8?B?b3FjUEJlNmQzZzFLMEdVaW91K1NOTkhBQ2FJbGVFdUk5L0poTmJXbm45cUE4?=
 =?utf-8?B?aTE0WS9JaVdkSG83MXE2TWhCUnNuQXovOFV0dDlwcmNxbG5pY0ZRNzhVYzlw?=
 =?utf-8?B?M3IzbUJ5bzNJSjFvazIvblpoUWxoUU5oV1ZwZlFaay9GQ0Z0R1k3cVE1eVNv?=
 =?utf-8?B?ZTRkc2VmclhGUEFrZWw4TldyTGs0ME0zd2RtcDV4alU1NW9GVEErdXFJQlZF?=
 =?utf-8?B?bzFWSVROVXRrMGUyTDg5SlBvbmtaQWJiTFkxZnJvR0cwMnJmbkJHT3RpRGdI?=
 =?utf-8?B?bUpCY05kV21FcWh2QWdKUDY4bUZ5bURuVHk5ZDUyNWVBTzJySHAvUE5rTXNL?=
 =?utf-8?B?S2VlNDVxbWVaWCs1MllzdytHc00rbmZoYWFIMDVHcStKNWRVZThDUDJ2ei9G?=
 =?utf-8?B?ZGhNWnpBc09oK3N3K2sybTM0WlE1M3VqVEZsNzdNYjhTREd4WUFrK2RsdFBO?=
 =?utf-8?B?TThXYzlJOUp0b1V4c1A1cHR1cXRjcGd0TWVCWUVlZHQ0aUkwNTdFbm4rVVFz?=
 =?utf-8?B?MUp1T0hpaDE3QXFuY2d1ZTZUU3hJZ09oNGluMExCK2NteFpUbDdqOFNidklr?=
 =?utf-8?B?OFBESmJJdk9Demlva3FvSmRGdko0QlRPbmFkZE11WUVFUEhvcURxTXZ1V2R0?=
 =?utf-8?B?YUwxSm1vdXlmMUdhOEVyTjRjV3FFd0JTcytabGR6dnhSK3dGZ1UyZmhkRjJ5?=
 =?utf-8?B?ZzNaVGk4MFp0UzBOaXFDRXJmRXlNQmMvdWkwN2xqRWkvL3gvRE5pMHZKUXVY?=
 =?utf-8?B?UzVObWFVOEpLNzJneGJvN0orZnNVTkhGb2ZyV0dVOVR2S2V0QVB0VVlNRENE?=
 =?utf-8?B?RlNxWGNjb20rdktUR3lyaWJTeUhLRXNPaTVBRkp3RlY4RTd0cHBvZkhGdnM0?=
 =?utf-8?B?TVlId0FzaW1MRHNPTFVOUExYekZIdDY5bW02NmcwSjFodmdNUHdXSHRLeVIr?=
 =?utf-8?B?Uy8ycS9UOGs1bUdJV1Z6RUVNRnFUVmVZVGNXeFp2aGlzR2w1MTFKNVVIN1BJ?=
 =?utf-8?B?YkcybS82czdRS2ZMZnk4M29xdk1HbGZpNzlNZGlNcW5yYStaWndsT1VLRWda?=
 =?utf-8?B?eVp1RG9FVFpaak0rdVM3Z0lMSUxkSXVMTTZqVGgyc1ZZMk9uTEFmZEFMTHJ4?=
 =?utf-8?B?OVhWSVlnR2YzcG5IUXh2ZTROR3FUelFPMnk0VFZmZmhvVXNUSk9rbjdCa3NO?=
 =?utf-8?B?Yk1kZ2orb0trZXYvQjJhbmt1ODJhOVBnWDZmYkE1T2NKNzUxQ1puYzcyWDla?=
 =?utf-8?B?bEV4SFJRUU9LMVlybFNoYjFib2NPelV2TnRsSkQ0Rll4RDNaT1M0NUlFdGhG?=
 =?utf-8?B?SkpNOENlL2NIeWlyK1QyejF6UTNwR3k2dnRKd2t6c2FIVWdzRjExOGZNRXhs?=
 =?utf-8?B?bTBsM2NnRTViRVprSCs2VG1aL0dkbTJPVEZNbUJmTWIrQzlQY2MzbEdtN3Qw?=
 =?utf-8?Q?jYDH9JvupS7LH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHRBaGFkY3NhUHoyQVRFeXFsYWx1cXRFT2ZMekNiOVpYUi9xVDdCZVVWbGhi?=
 =?utf-8?B?UlBBMmhESysvZGJEOW1aaS9JUGsrdSthakRFNitRWGJJT2QrTjNpV2o2aUU4?=
 =?utf-8?B?RVFTOGVuL0JScnZjYjM1SXc2ZGtPd0U5Q0xKVlZMY0xrcStoTUFoTVd2SzFH?=
 =?utf-8?B?Y3VrMzdyekZkaHI1V3lSR09odzdpc1lURXFYNDFBbGFaa2RtMnlkckRldVhE?=
 =?utf-8?B?S0tpUEg3R1ZibXA4dkJNN1FramY5dGtXTlkxM0R4UEtBL0VtUm55OFdCY2NI?=
 =?utf-8?B?WHBVRHpDSUoweEt4eFBnVzNQNGRrVGNWV0s2dVlpWUYyTmxhRnd3RERGZXMy?=
 =?utf-8?B?dyt5a0JKZTljRlBhYUwvM0tiUFVOOXRLaU1zUkIrWk00Ylh4RmpYR1dVSVcx?=
 =?utf-8?B?R203QTJ4L1BkZEFmd1Y1ZGQzZzdTUWhhcWhUSXhMZjVIakNSSVRsWVJjc0NL?=
 =?utf-8?B?NHBvOU1hQ1YyakFRU3o0c3JuOVU4bTF5ZEMvUGp2N1VUNGFOL2c5azg3SEE1?=
 =?utf-8?B?OGFnNVBCNTJ5bFFTOVlENFlrMFVHaE12dGt4aWZYYW1IaTF1QXMwRGIvajZE?=
 =?utf-8?B?b2t3TURWNGNXR29aZVRuUkIxSm1McVdHQ2loVlhmV2F4UG1KSFhVS09WaENP?=
 =?utf-8?B?ZUhSaFZkRk9nNEw5cEEvV2JoZUd5MlhyaDljTjJzRDJjSk8rU2xOVTFZTHc2?=
 =?utf-8?B?VXVQYUJSSDd2a2cyWldsK0dRblhVT3RuRlZlbG0weVRBQkxXbVhLUHZlVk5Q?=
 =?utf-8?B?cVF5R3pNMWh6a2Nnc2wrRFBlWHlEckk2SjZULy9BL0RSVkNjcnlyY0EwL2lP?=
 =?utf-8?B?QUxJUVI0NFVtZDRvKzI4U3UvamlyYmdVVy91WDRyeUQvUUVvcHRDSWZpaFJv?=
 =?utf-8?B?L3JSTGNXVmlkS3ZHQkNBZ1ZQdHdEVG8wb3VrNDNOa0dCTDQ3TmNJN1hOcEMv?=
 =?utf-8?B?RFlSWmpYckwxcXdTYjhuMTZWcTBEZzAyRjFSbnk4WXFNMmhSeXFIN1BqSTBl?=
 =?utf-8?B?aXJ0ZEE1bU8ydmVuVEl3SGEvUE1ZekFhZzlYd09mYThDQmczRzFpN0RLVDNv?=
 =?utf-8?B?eXg5b1BZa2FTcFRwSnAwQlQvOVQ0bm1hZm5Ibk5NVm5IU3BUU25Id1cyVk1v?=
 =?utf-8?B?N0tGdlpaTjlzNFBuRjJadkhhRzAyUVFEenB3MmVXTWNaQ1ZDM0YxS0FxRHJ5?=
 =?utf-8?B?UlkrU3JyQmZQKzA2VjdvbndYd0VhTGt5Ylk1TUYxQlNRUzhYelJweWlZcHFy?=
 =?utf-8?B?bHpIMWVwV25zb0xWS1QxSXp4WE9YNCtYQUJIZWFKSkJVWDhVaWJHUk1VUnAw?=
 =?utf-8?B?bU5xbWJQV3VLQnVTUkxlY3RzV2J1c3djVHp1bE9HV3RUcDMvTGtkV2kzajdt?=
 =?utf-8?B?WFdyMENtY0s1SXZKQUhQQzR4SXkydjMxVVM5ckhrUE45YVo0Q3NJdXBtU1FJ?=
 =?utf-8?B?ei9ISTYyVlYvRmNRdzRYT0dzOWVEejhrUzFWeEQ2dVJhQ1V3TmxXTjJ6bUNG?=
 =?utf-8?B?NFl2SWNPNC9nOXdtTTFINVZGYjZRSjJ4c05nMDNOTkdxZW1nYUd4M1I2UlNX?=
 =?utf-8?B?RFdBU2dYUW1wMS9TMThKUEVCQVdTVHBoSGZZZmtDS1JFZ25QVTk3OC8zcS9o?=
 =?utf-8?B?cEpUNDFibDNzNnp4R2kxdmw4MFJSWmMySUg3RmRKSXVhdWROM09DTis2RFNN?=
 =?utf-8?B?UnpMaEZTaVAyMGF4b2MxK01vb0IveThibUx4OTNDNWRMR2t3NkYzbng5aVJO?=
 =?utf-8?B?MDh6T3lHWW1LdjhIVjVCNGdFSW5qNlh2amRPWXc2WGxJV0FLcHhyUkRaZ3da?=
 =?utf-8?B?NDVIY2kyYUp4UnpIZEVoY2ZGVGJpSnU5Y002R2RGYndSRmc5OXE0SXNqVXdN?=
 =?utf-8?B?YldpRTJUNEdIMXZWU2l5Q1duTk5uRndRYkljcitOZ3FmUjg2U1U4NGw4UUZr?=
 =?utf-8?B?VWdKWS9JLzlPNGhnR2JMeTNyUjRNbjR1Y2lSaWt2MHZEbTc3MURvVWk0V2VI?=
 =?utf-8?B?UlNjVGM0ZHdXS0ZyajBkTTlxalJ0MTMzTzNCTVNydkJDUnRpNkNqN2JtLzNS?=
 =?utf-8?B?UEd4RnVYSzFZdGVuVjB0Nm50ZHdsbytCQlJUMHFtdlhoemcxWFloR01RaVZ0?=
 =?utf-8?B?aXhGbDFnYm1DMHhLdDhyR1d0b3dFTThzY29lS21sRFBTalVzYi9uc0xTbm4z?=
 =?utf-8?Q?xUKtwbHKxBqTcyQJKToFpXE05ZMSnc2TZ6p/Ye4KDlOL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a914fd0-3b11-44b3-0adc-08dd3aaa7216
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 06:03:09.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RAuSL3yzUFfYBE9wDik7c6f7fB6YKE8pJtmg5BB2BDN3sQpKWmIBYuKFxBAcFM6Ps2ctoxD+FxI+bVu6Q6JLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523


On 21/01/2025 20:31, Niklas Cassel wrote:
> 
> 
> On 21 January 2025 18:46:43 CET, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Hi Hans,
>>
>> On 09/01/2025 09:45, Hans Zhang wrote:
>>> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
>>>
>>> The return value of the `pci_resource_len` interface is not an integer.
>>> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
>>> overflow.
>>>
>>> Change the data type of bar_size from integer to resource_size_t, to fix
>>> the above issue.
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>>> ---
>>> Changes since v10:
>>> https://lore.kernel.org/linux-pci/20250108080951.1700230-3-18255117159@163.com/
>>>
>>> - Replace do_div with the div_u64 API.
>>>
>>> Changes since v8-v9:
>>> https://lore.kernel.org/linux-pci/20250104151652.1652181-1-18255117159@163.com/
>>>
>>> - Split the patch.
>>>
>>> Changes since v4-v7:
>>> https://lore.kernel.org/linux-pci/20250102120222.1403906-1-18255117159@163.com/
>>>
>>> - Fix 32-bit OS warnings and errors.
>>> - Fix undefined reference to `__udivmoddi4`
>>>
>>> Changes since v3:
>>> https://lore.kernel.org/linux-pci/20241221141009.27317-1-18255117159@163.com/
>>>
>>> - The patch subject were modified.
>>>
>>> Changes since v2:
>>> https://lore.kernel.org/linux-pci/20241220075253.16791-1-18255117159@163.com/
>>>
>>> - Fix "changes" part goes below the --- line
>>> - The patch commit message were modified.
>>>
>>> Changes since v1:
>>> https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/
>>>
>>> - The patch subject and commit message were modified.
>>> ---
>>>    drivers/misc/pci_endpoint_test.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>> index f78c7540c52c..0f6291801078 100644
>>> --- a/drivers/misc/pci_endpoint_test.c
>>> +++ b/drivers/misc/pci_endpoint_test.c
>>> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>>>    static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>>    				  enum pci_barno barno)
>>>    {
>>> -	int j, bar_size, buf_size, iters;
>>> +	int j, buf_size, iters;
>>>    	void *write_buf __free(kfree) = NULL;
>>>    	void *read_buf __free(kfree) = NULL;
>>>    	struct pci_dev *pdev = test->pdev;
>>> +	resource_size_t bar_size;
>>>      	if (!test->bar[barno])
>>>    		return false;
>>> @@ -307,7 +308,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>>    	if (!read_buf)
>>>    		return false;
>>>    -	iters = bar_size / buf_size;
>>> +	iters = div_u64(bar_size, buf_size);
>>>    	for (j = 0; j < iters; j++)
>>>    		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
>>>    						 write_buf, read_buf, buf_size))
>>
>>
>> This change breaks building the kernel with GCC v7 and I see ...
>>
>> ERROR: modpost: "__aeabi_uldivmod" [drivers/misc/pci_endpoint_test.ko] undefined!
>> ERROR: modpost: "__aeabi_ldivmod" [drivers/misc/pci_endpoint_test.ko] undefined!
>>
>> I know that this is an old GCC version, but this is a farm builder and the kernel still indicates that GCC v5.1 is still supported [0].
>>
> 
> Hmm.. div_u64() should work on gcc 5.1.
> 
> Out of curiosity, is there any difference if you add:
> 
> #include <linux/math64.h>
> to
> drivers/misc/pci_endpoint_test.c ?


I tried the above, but I am still seeing the same problem. So 
unfortunately, that did not fix it.

Cheers
Jon

-- 
nvpublic


