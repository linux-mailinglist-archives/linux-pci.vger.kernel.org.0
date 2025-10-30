Return-Path: <linux-pci+bounces-39746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5EEC1E167
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 03:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E45A3BE6BC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB952E8B9C;
	Thu, 30 Oct 2025 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WbNjIK/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045512F851
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789949; cv=fail; b=IR02Yh021tSiL50WQTC12RioWU10+WMl9zTUzL7JQ5uM9ZA7rhcpgO4sFlsrwBT5K8GikvZzSlX9N7VJgLPFG/2qM2PkKhhcQoiBVUy4s60fxSF++gNcYGVUvN1VJITeGL8ulq8TG6tfgvu0FhyMsqeiIOgRHxDFS8TeTRnyZ1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789949; c=relaxed/simple;
	bh=gF/5PSQRTTxowE6Y1xTg8dt0jzhQDWxLsYsJx0Reqps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9Qt/FVQTP2AWm3EE3AW/ej+G0zE54OVxpAP/LtLEIUkwjktE9qxZc/pjWJnK21HWWmo4UM5iXmWMDIR2drxJBPH4uTPyC9SIrH0HS76m42VEXzSsi5DY+dbpxOqxFttwwvBJK6mDlLVpXEKGBUveB+Mnz3OhbQYh4f4My6CpdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WbNjIK/o; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPg+BNqbzkSFfWaODaij5ZQ4YCNYwlB8Igd9M9cArWiI38kzYQOolL57jQMC8aEzYC5ZncDDgqnzPKpQrRbYUrVd7wrrkKb5oGJ4lGbIez0qE8UDclQ/Bev/z0GDAdQSopbmOqk4xZPLjXoIOYTnyxcM8wH2mLYYdKyVfmfYCptTh+fIjiiElYQh+PqiUX3zs35E6G4rqQM1Z0HpfVargYaO/lpvrNU1R06WUB13NGnOARtoa3rK6XukZKFTztARFt42x6TI5wuom98+7iUzw6MwJroKXabcj1jEQZeBSqxTB2lpY6q0flRmkhhKz6FfB3t8qca77WvhpIJI3DqLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxZ2nUwACztJ+mLEeOpyVkufg2rDQvVh9xgiyduMIY4=;
 b=EG0kxslLqlIaWm18Je+gIYPVNNearArjSKv/nhUGbSQ8Omsmn6uOKpyLFXmp4Uh8lurtjhi7PRhC9zaXtV6sEltseP8ok/YO6vExuF0HDmQFQlcJuBIoGZcnsq5pYesl8dZ0lQi1rnKz+AWnHs7cmwDnMf0Ljl6FKjmywyCBCaOWpxYf8Yqfky0+dey9JNiidzaeHZ1OJuEEaqzQTc0mI+V3U6zOgXnnvlXT8NyhwZta6LhIA16YhX6oXfDspxs5bKk8n27QCSiJV2P29X09ovEa8TcZgtwTb6a54tVVSi4s4jrKYi6wJxtBgeBieNjP9xoUtznyoEKslRcHdzD6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxZ2nUwACztJ+mLEeOpyVkufg2rDQvVh9xgiyduMIY4=;
 b=WbNjIK/o78NrlIdi5055XCY2QX7hQrB1MiOQSj7iNWgu97mrC5SGTG5XyKn33uA/7QznyKQy/01s3vYsJ62PX4ClCi4bnBsgz5ALouBAkmYK5BQaa4IzP4RzK7z6EuF9gyRA45/CPk1MeqtVdnFUaaAfX7UO5fGZ2k4XUGFGx4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 02:05:43 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 02:05:43 +0000
Message-ID: <641a605e-75e4-48ae-94a7-3839c5369b07@amd.com>
Date: Thu, 30 Oct 2025 13:05:35 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 9/9] PCI/TSM: Report active IDE streams
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org, bhelgaas@google.com,
 gregkh@linuxfoundation.org, Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-10-dan.j.williams@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20251024020418.1366664-10-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e2160f-c4ed-46a0-8939-08de1758d4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2dDK3NYMTBiUDhicm82TjRMdlBhQk9hMkRFWlJsWmRPQkJIa0NOS293UFc4?=
 =?utf-8?B?ZmdxTnJ0VWpqTGFKbWNQQWZFT1NqeXNRVCtzTDFJb2g5aHRrbUxZanUybHll?=
 =?utf-8?B?Ty9UaDVic0JlVVF2Y2t2NW9nUTVDWHhGem9EMitLRVI3VytmVjh0eWVlQ3Ju?=
 =?utf-8?B?SmRmd2JzMTMxbGdIczJGdklDbC82Vk9CeUttL1dBYTVBVmU5VkNuNkI0N3R6?=
 =?utf-8?B?ckdiWkFEdktOMCtSZ3Mzcm00Ui8vb3hGQkdNSko2aFRoUGVrbUtiZzRoVk9C?=
 =?utf-8?B?UGVpa1NHTE5DK1NRbGRBY296bndyTkJyRloxdndSdUdaN3U4VVZqUEtRbjNW?=
 =?utf-8?B?TkFNV1JHY1Z4SUFCMENQNkFsZmtjaHc1SXVsTkh4b01pMFYrLzRYY2NXbjFP?=
 =?utf-8?B?OGdaVzl0SmJGQWZhaURQVjloa0JYbGQ0dlpFU3N0YXdlaEx1Y0YxbVFmdysr?=
 =?utf-8?B?bnVBNlZFVXVBOUhaRXV4OW4yVGdwQXg3Q29Qd0ZYQ0RHRGxYTVlrOVdDZmMw?=
 =?utf-8?B?M1ZxbVg0V2FwK3JiWVNyTFk0czdQQlFUV3VDaE9LTUV4ZjBYTTdlUEVocC90?=
 =?utf-8?B?Z0J3Smt2QUg0OWJkaU11aTBsMWNPbkRXUmNxUkZyYWlWdUdLNWpkbHRPSnpp?=
 =?utf-8?B?dEhHcjk1Y1kzdUVQUG9DSjNPSWVVbEZhNXhwakh0OTBiamRLejJQSW5TYnVh?=
 =?utf-8?B?UWVZWTVFMkFvSDMzSThJenJBOU9PdDFoUHVZaWdkU3NheUpRWGJKcC9ESnBh?=
 =?utf-8?B?Ykg0bkYwVjdXYVJCdmNlYlF5eGw0ZzBSSVk3QzVoYmNieUdZVTFoZFo5b2kz?=
 =?utf-8?B?UDdlaFhhbVl6aWZEVUQ3UEZQSWtpY3VpaGtYZTZZcExJNzFqSzFjRWhqRjRO?=
 =?utf-8?B?THVWTzBNZ0llQ1VEWmNwY0tPcjQ1ZVdPOSsvQjFhcXBCOUx3UXhlQ3ppN2FR?=
 =?utf-8?B?VWdQcHRERVVaV3RVZkhSdlpONVMyZElpcjNJMzhFRTVwSU1OUEluYWV3Q2Fw?=
 =?utf-8?B?V0JFUm1nTVRnbHJhRXRXb0FmRXJsZGF5a0E0L2NGdnlUUGpZeXM2eGxJdm9K?=
 =?utf-8?B?eUNMZEVpa0FheGpzeEtibkU3d3VNd0I3WWpTaEFTYWlUak9pVVUrWUh6eXg1?=
 =?utf-8?B?cUZXbzlodHJNVU5FaUttc1hTMllycnJYazFpOXNDU2g4Rmt5Yk1GL1NFelcx?=
 =?utf-8?B?UkRDQ1d5SW5Ed2g1NmppcVgyWXVUamJFRnY3VU9XNGFiRmxndTd1cWJaL1lx?=
 =?utf-8?B?bVo0UnkxY1VGbDNPTVN0N3phZldxUEtRYlBNajZaWGJJWktjVTFDLzg5TUxl?=
 =?utf-8?B?S1l4SUsvdnhBbFF5a3ZGUzdVbHlmZnMydzdYTEhjbTZja1Q0c2M5Mld3bEhO?=
 =?utf-8?B?SnhXTWVDRFpJRWxzR0ZMU0U5Y1ZLckFuSUttZXRrWklrdG5JTzl3c1Z1Vy8y?=
 =?utf-8?B?aGlsVnFFWWZxNWJwNG9TZVFGUVJ3a2hMOEJoYzNNQTlOKzE0aVhzR0ZDZSsw?=
 =?utf-8?B?bmRObXpPS2dOUnUxbGxoNHV1RnpZOXpNRVkveEZNYWRnQkhJNHR0R1BnOWNo?=
 =?utf-8?B?TGtMSWVVdG1lcDYrays1OVM4aVd0ZVR3Q1pjUUFRazZ1UEozdGNLNVdPNTI0?=
 =?utf-8?B?bXBWQVlicmc5dXF1TE5URW02MjdjK2EzUlp6VGJocVN5SjdMT1JhdnRpWENT?=
 =?utf-8?B?U09VM20yajRBZGdYcmtUeWtrQ0Ivc0hEbXJhN2pTTHd6eUI4UDBCaU11bzdp?=
 =?utf-8?B?QnBVZDFndmxPMlc3TzVYWmJNTTNHYjlaV0RwQjl1dmhmRTZmWEFkM0d3WGFs?=
 =?utf-8?B?L2dtdUNTWlBNMXh6UDZub1NDWDdJaDR1eC9QZFBFNURQZUpvZDZHM1htaXRt?=
 =?utf-8?B?VWRoMGVtMVNENmdjdHVFZTZITGZyYmVwK2dFSU1hZzU3VFRFREVpZjRuVndO?=
 =?utf-8?Q?a5W8LMpQCk5NOIWVHmSMK/93/DSvDZFx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0lwNjYyS3BTZXRKVGtwMTJNQTJlNFBIVjlaY21GaWZET24xblMrWmxUR3Bn?=
 =?utf-8?B?WFdVbU9mamZKNlVUZ3NlaWN1OThGSTBZVmVTMkVybW9UMnVGak15MzgvaklN?=
 =?utf-8?B?NDFTWFJieDJ4KzlCcDMxOW8yOFo4MUpzOW9nWFNIOGIyd2J1emN5NWw0NG5T?=
 =?utf-8?B?SGIzVkp4QmpocHU1OWMxOGVxQ3ROWFNYeHIvY3ArNEdLYnVLK2NBQnBSc0Fa?=
 =?utf-8?B?UC9WV0U5dGVNOU03eXRxQ3F4bDBGajhXT2lUTS9QYVNTOERvYW01ckpZdi9K?=
 =?utf-8?B?WFpER0JtcVlmL3lPT2FTWjZhVnNZT0NKRG5QRkhWbjVWNVBOTUx3dm56L1Vn?=
 =?utf-8?B?U3FDM1lNMW5hUkpEL3A1MFhIeDg0M2tBOVY4c01NcnNIdVp6b05mbWpLVkZ5?=
 =?utf-8?B?VDFYbG1oY0ZNK0cwMzY5R1BjTFRRZTdNYUxwTE5uL3FHMHF6cVFMaVl6M21u?=
 =?utf-8?B?alZBQzUyOEFEZ1YxZHNPMVlOUkpFU2lLSUt4KzRUTElmMmh3WlBiYjFUSmQ3?=
 =?utf-8?B?UVBIdENsSDNWdkZ4K3MzT3FpMkRWSTJ6QTVRcnVDR2RIL0pTOFFGV1Voa2lj?=
 =?utf-8?B?NXkrcmdxanBQNGtxMEpLSk5nSTJOT2pDVVhrN1FtWU1odThRMFMxUE9FdGdL?=
 =?utf-8?B?OVE3U0Y2eVhDU2pJZEJlOEJwd2V1V0RWMHowc3JFS3pkaUlHTEZLZmZOa0xE?=
 =?utf-8?B?NmZOMWlzU3E3c20waGF5L1d1a2dtak1MYllTYTNMWmVrV2RnYWkrNmFrZW1o?=
 =?utf-8?B?VXkwa0Z5NHJ4VXZTUFl4SzNkWTZ2LzlnVmkwa05OTTMvaEZBS2N3N29hdFdE?=
 =?utf-8?B?NnJ6S0J2azA1bk1xM0lvY3U4U05zUnRXWHlndC9KcVJLa2tLd1QrVTF5aGZY?=
 =?utf-8?B?S3pseGF0dFJQTnNYN20vQy9rMDV1QkxqY0s1NkJURW9yV3lsc0NFRE5FRFEy?=
 =?utf-8?B?QXVTVkxhMUZlKzNKaG9wZ05SZkZOTUg5MGJxOVB4SU9xcndKM0tqMGpNSHlt?=
 =?utf-8?B?R0ZTNVMrc29wVHF5RkRINkl6ZXp0bFJmbU5XSUQ2ZVJZeHo3R0wzRzJZTTV3?=
 =?utf-8?B?SGN5NmpETnh1QW9iSWtXeWliRmVEQVBYUlhzUHVKME9UWXh6SVpRa2tQZlRx?=
 =?utf-8?B?d1V0YXJxVWZwc0k1cEc3RDA2OUJGMStFV2NhcnJsWnduVGxLbWYzU1VmRDJs?=
 =?utf-8?B?V3I1VUhDV2d0T3dvaFJ6NG1tVkFLSEVJcHR5a0pKTTIvSmdFNitmM2RxU0xY?=
 =?utf-8?B?cG9FNG1GUGMwaUYzU1dXRmtNa2NoZ2RWa1ArRXo0R21Ib1ZPNlNya2kxMHJy?=
 =?utf-8?B?YUVPN1RaczM2NndJZVN4Q0NsQ1BETGhPcGRPa2JvcnZrVVdEc0lJY0hnN2dW?=
 =?utf-8?B?T2l6RDd2QTcwOEphRzRwSjNPMTRveXpiV2g2ZjNJcXFiZ0lnMEV5VHlTZVZq?=
 =?utf-8?B?UWdjK3MzT21jU0VKRjdXSlZKMTkzNGtRT0lxY3U3Wk55L1doMFc5UmkvOHdq?=
 =?utf-8?B?VE1PcmdWV055ajFQdkZjYlVLVE5BbmhiTzRTcnVSa1FocldKWGplODdTN3Vi?=
 =?utf-8?B?OHV1SHBvbVNweXp2SWMvTFUrNTNkNk5GeWtPMkxaNGhXUExvZWE1WVF6YWZO?=
 =?utf-8?B?UGZ2WUl0MnNDaWpwT1FINnFFUlpJZmhkL2pHbnBlcTNsN0MzR0VkcW9XNXF2?=
 =?utf-8?B?TnR0Tkk0dDg5VGgvVW9aMm15M2lDUGxBbGdIQ0dTY09hVFBWaVNEdm5DUTN4?=
 =?utf-8?B?Q0hZQ2EvRGcyb3lRUWRxNisvd0dxL1JCOWJHd2I3Y0g4eXl0Y0YxVGM3cEhh?=
 =?utf-8?B?QUxYaDBuYlpXZFA3d0x5dFpGelUxUjZwZEloVDJmSGxLUi9KeWxVRkwvTkdC?=
 =?utf-8?B?dG1RWHpzM1B0QUcvR3AveXk0Y0pGdzlsVkFQQTFhVGVOOG9GNjIycFd3MnFH?=
 =?utf-8?B?ejg0b1c5YjB3aE5ZUzVhWmpnQktJRkcwcmVvaVJvMElGWkV4aFg1bld6R2Yv?=
 =?utf-8?B?Q3Rod1FkTnNBamNBUzZJWXZQVys0VWJjcXY3eHpWUlNkQnpSVUZaa25mdWxi?=
 =?utf-8?B?R1BmQ3p4MGczTTNoRHg4ZFcvUWRGVFl1MWhEazRKMGV5VEJ3b2NRMWhIUk9t?=
 =?utf-8?Q?3L8l0hB+OG9LR8LgoT6aPsHjq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e2160f-c4ed-46a0-8939-08de1758d4ab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 02:05:42.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYUFutC3R4gYcTyTen9UKjDytqRdZG/Kmt5Z93xRQW6zefUi+6DzS59n5LzYRI4VCIk/+w0xJ/YgXW6U64HISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492



On 24/10/25 13:04, Dan Williams wrote:
> Given that the platform TSM owns IDE Stream ID allocation, report the
> active streams via the TSM class device. Establish a symlink from the
> class device to the PCI endpoint device consuming the stream, named by
> the Stream ID.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>



Reviewed-by: Alexey Kardashevskiy <aik@amd.com>


> ---
>   Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++
>   include/linux/pci-ide.h                   |  2 ++
>   include/linux/tsm.h                       |  3 +++
>   drivers/pci/ide.c                         |  4 ++++
>   drivers/virt/coco/tsm-core.c              | 29 +++++++++++++++++++++++
>   5 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> index 2949468deaf7..6fc1a5ac6da1 100644
> --- a/Documentation/ABI/testing/sysfs-class-tsm
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -7,3 +7,13 @@ Description:
>   		signals when the PCI layer is able to support establishment of
>   		link encryption and other device-security features coordinated
>   		through a platform tsm.
> +
> +What:		/sys/class/tsm/tsmN/streamH.R.E
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host bridge has established a secure connection via
> +		the platform TSM, symlink appears. The primary function of this
> +		is have a system global review of TSM resource consumption
> +		across host bridges. The link points to the endpoint PCI device
> +		and matches the same link published by the host bridge. See
> +		Documentation/ABI/testing/sysfs-devices-pci-host-bridge.
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index 85645b0a8620..d0f10f3c89fc 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -50,6 +50,7 @@ struct pci_ide_partner {
>    * @host_bridge_stream: allocated from host bridge @ide_stream_ida pool
>    * @stream_id: unique Stream ID (within Partner Port pairing)
>    * @name: name of the established Selective IDE Stream in sysfs
> + * @tsm_dev: For TSM established IDE, the TSM device context
>    *
>    * Negative @stream_id values indicate "uninitialized" on the
>    * expectation that with TSM established IDE the TSM owns the stream_id
> @@ -61,6 +62,7 @@ struct pci_ide {
>   	u8 host_bridge_stream;
>   	int stream_id;
>   	const char *name;
> +	struct tsm_dev *tsm_dev;
>   };
>   
>   void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr);
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index ee9a54ae3d3c..376139585797 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -120,4 +120,7 @@ int tsm_report_unregister(const struct tsm_report_ops *ops);
>   struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
>   void tsm_unregister(struct tsm_dev *tsm_dev);
>   struct tsm_dev *find_tsm_dev(int id);
> +struct pci_ide;
> +int tsm_ide_stream_register(struct pci_ide *ide);
> +void tsm_ide_stream_unregister(struct pci_ide *ide);
>   #endif /* __TSM_H */
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 44f62da5e191..5659f988e524 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -11,6 +11,7 @@
>   #include <linux/pci_regs.h>
>   #include <linux/slab.h>
>   #include <linux/sysfs.h>
> +#include <linux/tsm.h>
>   
>   #include "pci.h"
>   
> @@ -264,6 +265,9 @@ void pci_ide_stream_release(struct pci_ide *ide)
>   	if (ide->partner[PCI_IDE_EP].enable)
>   		pci_ide_stream_disable(pdev, ide);
>   
> +	if (ide->tsm_dev)
> +		tsm_ide_stream_unregister(ide);
> +
>   	if (ide->partner[PCI_IDE_RP].setup)
>   		pci_ide_stream_teardown(rp, ide);
>   
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 4499803cf20d..c0dae531b64f 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -2,14 +2,17 @@
>   /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>   
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
>   #include <linux/tsm.h>
>   #include <linux/idr.h>
> +#include <linux/pci.h>
>   #include <linux/rwsem.h>
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/cleanup.h>
>   #include <linux/pci-tsm.h>
> +#include <linux/pci-ide.h>
>   
>   static struct class *tsm_class;
>   static DECLARE_RWSEM(tsm_rwsem);
> @@ -106,6 +109,32 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
>   
> +/* must be invoked between tsm_register / tsm_unregister */
> +int tsm_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_tsm *tsm = pdev->tsm;
> +	struct tsm_dev *tsm_dev = tsm->tsm_dev;
> +	int rc;
> +
> +	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj, ide->name);
> +	if (rc)
> +		return rc;
> +
> +	ide->tsm_dev = tsm_dev;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
> +
> +void tsm_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct tsm_dev *tsm_dev = ide->tsm_dev;
> +
> +	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
> +	ide->tsm_dev = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
> +
>   static void tsm_release(struct device *dev)
>   {
>   	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);

-- 
Alexey


