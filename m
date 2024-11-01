Return-Path: <linux-pci+bounces-15798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A39B9201
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBB9B22453
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB619F409;
	Fri,  1 Nov 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D9xK6Hjb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB419923A;
	Fri,  1 Nov 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467861; cv=fail; b=EMTyo5EXfwA2plW6SU48czrqLYSMH0t1YJWs/vvqCWkA8b7AR+MZWGaM36RkryTQHVnVop+5r7hrx+Y695X9TeNFUY/aSYAqS+cqps4hJ0lyXwUlFxlIdjTi6M2TdAaJ9Oa9RDWuLEOWayxGh2Er+zNtI2RjK3OvRmoBwLyoowc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467861; c=relaxed/simple;
	bh=qpaFNEwam3eC3MdbvBP7ZWkPLvIx+8sj1YY/7ZqhQ4c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cPeZChqz2P0y2XPQgwKtMgJUPgHmLYCesTGe4wBIatW7X3zWQPP3ZJNe5WVsIeeqyrybVg5iXlX/+NCMMsUrbtDhD/DfnETavezvjO7qPIQPm8MiK0xIWemL3dIvLz4YPwQKNrwVgPLmYX9SuQcsQj4GM8EMKry9EiqWci7/xyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D9xK6Hjb; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgicWQAddUOEPUGxs37y11qIFS0QFRh7ZxhOmSA8Lvr2VrvdI6HcnFXlCVjuHdlQkLd/lsWg3Y+B5bA3hl3FfvPm+J0Q9vJxprCTJ43vgNcBEvn0ddikFUcB6VySiUDmD3XiR3pQcA2MQ+JcSo908hpGqlEMCp0QBqHkv4T/ZWq39sXdn6KlPyzpfLa0yqYQ5kanokVzxzUQlRsD5hvanzJXZL8MzV/Pjtk8PoslMxfjlBSfdGB0c5dSXaawFW45B0i1aQ0GuWrvlozubFCV784QB3u09TslmLcYjX1DTBCLbWepaBu9GcPt16crHEhvKH9Gw7lrS0igvWNFJoBS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZV0wVKFbQpJYyc/PvFaT3FNQirnSSstcwDRVyiR/wc=;
 b=ppHDhUfbZlGve4Rcjny0dymh5UMMPPnGGL+U/KpB/Tz1Y02xoUrSJ2cgudcpSteu3clr2g7/wRkQvwhXHOoLxNRlIQ3PC/J23JlskQKIcFKwajpuRjFAu5QWyR0KZSfPp+eNj6dpR0C3EDyWl19uIQ5MERX5GY4xfh+DTV70X8zSyyP3P/PjxYJT8KrMGUB9dk9fFa3wXWTxpeGHd1VPEUrMMrIHrIi8niNX+iqHunXCc6JpiHNGzQwxc2Isc8YwRQ6ukBXMfu2Yoq/oq8pL8nI+w4sImn76YWFcbj85MGOnH9HhvvWoSJTt2VDkJJQzb+NENBRirRLDh2g8pacZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZV0wVKFbQpJYyc/PvFaT3FNQirnSSstcwDRVyiR/wc=;
 b=D9xK6HjbxJF/FDl6jIJbAnvZR7ncqy8tJfYR41qG6GambeqKOOZ6vZQKFYSTcjrXX2knheeWrxcxRCGoVIBRI0mtm2eDz1MWn1qJxD6CElZMHAl8KSN5e3TEUfdVM4ayYqYIFnLeDqfRhjL5qfaYIIXv51QMJ20eM29kO7z4e0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.18; Fri, 1 Nov 2024 13:30:55 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 13:30:55 +0000
Message-ID: <e4767c14-66b0-460c-ab88-ef78be77690b@amd.com>
Date: Fri, 1 Nov 2024 08:30:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe port devices
To: Dave Jiang <dave.jiang@intel.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-7-terry.bowman@amd.com>
 <77b60d4e-2792-4e00-a91c-d2892c091050@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <77b60d4e-2792-4e00-a91c-d2892c091050@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f61ed2-5762-4a0e-17fc-08dcfa7969a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nmlyb3VuWGVjL241eGNxdHd2b2d0SmUxSzlLTWJodmxXZ3l6eXpLUldFdVlI?=
 =?utf-8?B?MXA0SG9nbFFaY3pSb2FJQTBQVzd1WVJCVWhrRFFIQm1EU1dSRDJ2cktjdjZ6?=
 =?utf-8?B?RzlSSXN3UG5kNHlsa1Ntcjl5bW1lVzIyTHlsRmhPRmZBVmNCWkhhR0o4ZXZO?=
 =?utf-8?B?bmZPbFp5Ynh6WVlKYytsdEhyUWdrODlTcWZWWjNWNDltZjJTL1pvOThMblRu?=
 =?utf-8?B?ak50T0l1SndwaUFRc0NOa0dqSTY2WGJITzZQWDZJWGRqRFgyM09oaE9vS3lo?=
 =?utf-8?B?VFpxdDZub1Zxa2Q1TG5sK3MwNW84bzJrZ2VPUVIrcE1jZHRkTENUMzJic2ZI?=
 =?utf-8?B?dTRPb3BGV25hZmh0Um9pWUp4MXNIa1RXbVh2UEVTa0Z2dVl0VWk5ZEFrN04z?=
 =?utf-8?B?VzVpRWE3UnRFelR1K24yQkcvZmNTcCtvOHUrMzRhYTgxWVp4NVM0Y1ZuNmdi?=
 =?utf-8?B?dmpsOXNRV3J3d0JTMGFINDlacjVUcjRpWHh4R0RuR1RIbFJlcFRadlpWa3Fx?=
 =?utf-8?B?RjJBekp0MDVsd2ZmYXRBdExBSTVJOSsveWVZaTNqTmZ3SUJ0bGJzSTlNK2FL?=
 =?utf-8?B?ZnczdFBVT0FDb0hVWEJTc1dzTXpmTHE2RzRzNXZabDVkNEYySEo0ckxkb0Rk?=
 =?utf-8?B?b0dab2VSV2dNc3hlWUFnQnVqem10S1JLTFVpTVRnZStGU3o0bm9YNUsxTU0v?=
 =?utf-8?B?L1N4aG0xdHJlaS91NXFlVGtjbE5zazlqTzVDL2tyZ1dNSUJ3TnViT2U2V1ZD?=
 =?utf-8?B?a3AxNCtaeE4vYlA2V3BubXJwQ1RVcTd1dStYMXBha1JkN2c2V1NPZWlHTUVD?=
 =?utf-8?B?QTJoYjZ0c1hGaXFjRlhhMTViNkJRclVHQ0F4aC9EWTZrMzFTWTBUSnhHQmdY?=
 =?utf-8?B?cmdxMmlweVNWN3oyR1BDaDFZVUw1RjNUdUdwSnlFanAwb3hvb2NMVk9jZUY2?=
 =?utf-8?B?WXM2cElnY29wTjZvazZ4QXQ5dVVUMzRuYm1YNDc4M1BsQ2F4ZUtOL1JFYVp0?=
 =?utf-8?B?cWxHNVpmS1dUM2VBcWxRRU9aRCthaHlDRkJEeGhXRzhJdUErNlZLTUlOc0NY?=
 =?utf-8?B?d2VMcmJ4MjJMcHFEYnVid2pYdHprUkpGRmxPZkltT1BCTEIwV0svanhFRlhY?=
 =?utf-8?B?Zmh3Vnc4d0R2RFl4c3V3WFhicW1JMlA2WUdjaXpTblp3TXh4MTVwMFMyOGdC?=
 =?utf-8?B?TGQvemhoN29YdDlZVTJYMEs0K2hCSENBbk9pWTRGVXdSenMwMnBsZGUwNjhI?=
 =?utf-8?B?ZTFob0ZtT2tYMTdjVncrZEN2NFhuRWx3bC9sZVpFakh4WExLZ3NxNURKSlZK?=
 =?utf-8?B?NncrR1EvZ2JCZzFSbnVyTVpwWVlLN3RKQms1V0pPaCtZeWpZaEtyOWprYlhq?=
 =?utf-8?B?cStqeG81aXJZcGV0SVhyWlFLamZwNUZqVDNjdHJVdEUxbkRWUy9RQXdac3kr?=
 =?utf-8?B?cks2THovZzlYYzhZZjVQNVB0MjdxRllVUTQzbFNFUlBJTWdrK1duZktmSUtK?=
 =?utf-8?B?WjcyelpjVEh0cVNpMU5HK0FNbkpLUXhIc1dyeTNKVnpJeFhKeG9URUtkQkVP?=
 =?utf-8?B?RVJVVmViNWlOR3lwa3J0MkNDTm94dWN3alhHZDZGMGdJYk1hWER6a3F2OXZn?=
 =?utf-8?B?bVRHWGJMUmVIbWxxMmpXU3VFcXRiVVBUOGZOVVNKZVB3blpoak5QZ2J1OFVG?=
 =?utf-8?B?SE0xNlVpTmZNM1ZjTk5iRlA5MjRYL1FHaG9PTFFoaHc3OFRTeURuNmhwR3Er?=
 =?utf-8?B?RFk4ZzVKMk1ET2RHTk5tTWZxbklqUnJXQ05zVUx2UE10aTZwbDNhOHdtWitN?=
 =?utf-8?Q?/QajW9ewYOWfWBWAmWxE+Lxk4pz1Y6iM8y3HQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWEreW5rS3VkNWRGZlFYZEtGQVg2TWoxTjNaT0xyd2VrZmhYSXFSL3NZaXdi?=
 =?utf-8?B?WHJRbGh3aVhyaVN2cU5TWnJQcVl6VTJsb0FOT1JlMkh1Ykw5UGUxek1mUG5k?=
 =?utf-8?B?TEJUV0hqVituQVBpZUhScEc4cHZ4QjZja1ZlWWphdnBPTXhhdk5KYWVad3A4?=
 =?utf-8?B?ZGhOek52Q3VNUWJ1OGlZYXF2dDMxdXhEYy9oejJrVFIyOW13MkNRTjluQlFm?=
 =?utf-8?B?VmoreWZMTE9HekorTklLMU5aNzkzL1BEKyttNzdqZUlxeDEwTEs2Y1B6VUZ6?=
 =?utf-8?B?ZjNtbmFwUmcvdGZaVXVKbnpxSnlSR09kLzFlb1F6YWoxbFYyOHJveUlDYnp5?=
 =?utf-8?B?WVVVZTEvbnJWbU9DODFsbnpMRUFSTlRWU3V6dXVYZnR0dStSS0gyZUlRL2lZ?=
 =?utf-8?B?MFc5YUlkaC9LVDZaOUZFQTh2ZktDQ2ozVDhBZUMrWEZFNFhQaVdUWVQ4OGg2?=
 =?utf-8?B?c01jbXRBd3V6c1cvOWt1Y29KNTh1OVdWQU9UZGdIVGZKS1lya1JkajQ4ZlpL?=
 =?utf-8?B?NFlLeGJ5ZTdwVXhYYmgvZWdZMlFZWW5hQnZ5cEx3T0pKcGFjclJXN2VIUzNC?=
 =?utf-8?B?eUxTU3YyTHN1T2k3SDNYY0w1Rno4QnNtS2NMdDA3aGhVa21XVHA0QStReU1a?=
 =?utf-8?B?T00vbmhCdlJvc1kvTGw1cHNBMUt1MkI0QWc5cm9vYUNSVCtxU3kvWHhscVhS?=
 =?utf-8?B?dnFkQlc2UExTNm9MU3NwOGp2dGhFbTJyWHNXMHB0dGtnMnUzL2R4SzZUKzBs?=
 =?utf-8?B?clR4a3k4NWpaWVlyczZ0bS84YmMvRVJvYWtxbk9pWHdGTk16V0NwRHJEdDJw?=
 =?utf-8?B?MS8vTkdjMEl4LzdTcERhMVlUZjBsbkowREdvRm83b2JPV0lISTQwODByRkRx?=
 =?utf-8?B?c3lPZVFkZVBEWUZoWTIrQUg0OXJtNm1vYkx4c0JOWDh6bmNUVkJkazlSemwr?=
 =?utf-8?B?VHJaakJlRllsc0hOMTE0Y3pIbGU3VDdTdTJNS0ozSXpHd0piakoyQ2ZzcFVI?=
 =?utf-8?B?NEluM21CSW9XUm9Bc0U4bWpEb3FqUkwwQnU3MVZ0Y1l1dENNOHpkenVtNVlH?=
 =?utf-8?B?Qi9lcTk5YnFkZ042M3dienBRWGlJL01yUkVTaTkzWFIzdUpmV3h1SytUVlJv?=
 =?utf-8?B?SEFNTncrRnlkYkhha0pqZkt2WHpmL2Q5SEo5YkU0NjYybDZpY0xxVndqaFFI?=
 =?utf-8?B?WGlDb0MydkxaWW9oZHlVQkZ5Zk1OTnJVNGlOallzdllWTiszZlRBWFRJR1h3?=
 =?utf-8?B?SzVFOWI4RkN3SEg1cVpoK2dTck94aVgvVllPb0NXdU5KNGRvVVZMOXFVVVpT?=
 =?utf-8?B?ZDRIUDNXb2ZwSzVtVEJ0elpISHNoN0Z4VzZ1VkROK2Z2VlkzYkFiRlY3SDlN?=
 =?utf-8?B?d0wwQ0RTSjlGU3VQQWRoVVQ1dTRxN0F0M2Y0UXJGWWs4aDhPM0V5cXZLcDRH?=
 =?utf-8?B?N3Y5YmJiZlJ6c20xUlpCU1MvQzUwTEhpVzhUQWx1RlNHVGlPMzNVL2dNRTNI?=
 =?utf-8?B?LzJUbkVxeHExMm5pTjVvdmJXYTJGRWQ4TDA4MUJpd05TUW01dWxtZDNJcVFX?=
 =?utf-8?B?RDRreGhTRVMxWXJrdDFUNGhpYkNsTm8zMVFUTDVJQnZVYWhHQXNTejNzeU43?=
 =?utf-8?B?L1JDTXpvQUJBT0lncC8yZ1Y2dnlVS0RFdHNscFNSZGh1OXE3SVBtcXdiREdp?=
 =?utf-8?B?cjdFZWRKWnVLVmU3Z0pldE10d05uTkFDeEY4RTlLWkRKcVRlRmJKT3R6UFB4?=
 =?utf-8?B?NGJ5ZUpIdUxQOS9IWTRIY1M4MCtpVDVHVWwxbVdXZDllWXo5YUpxNGZIVjJu?=
 =?utf-8?B?bnY3ejZVNFl4dFZwbEJlemJkSm5EeXVQYzdNN3NnOGduZXdSeGYxZkRqZmRL?=
 =?utf-8?B?T2hwTzBCenlIeVBRemExek1BaFhRd1VTdlpRV1FmeGE2aE1RY3VuWmhZYk1V?=
 =?utf-8?B?YnVWSnhhN2lmbmVnMzAvNmlPRFVGNzJwOVgzMXRmZWZRMHVWMlBKb0FWZXRw?=
 =?utf-8?B?TXdMUzJuRVkzVnRQRUpacmlsTGdYMU56VmdTY1Ixb1N3QkNKVEZ0cko0a09B?=
 =?utf-8?B?czhoNDJjZWNjYlhqT2RRRzBUMWk0Y0plRjlvNTJaQXBxaGhuT2dUVDRXdkF2?=
 =?utf-8?Q?GleoFUNPgs/HqpoBR4/VSxCRb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f61ed2-5762-4a0e-17fc-08dcfa7969a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:30:55.2864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgQ9j8o/XUyNFX3R/MVG2DcICGOiwpBOG6nKWJeMPntGMZ4E6CAGc+863Q+Z2W8c8ZFCqeSwX08Q8hoZHkznzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

Hi Dave,

On 10/31/2024 11:58 AM, Dave Jiang wrote:
>
> On 10/25/24 2:02 PM, Terry Bowman wrote:
>> The AER service driver's aer_get_device_error_info() function doesn't read
>> uncorrectable (UCE) fatal error status from PCIe upstream port devices,
>> including CXL upstream switch ports. As a result, fatal errors are not
>> logged or handled as needed for CXL PCIe upstream switch port devices.
>>
>> Update the aer_get_device_error_info() function to read the UCE fatal
>> status for all CXL PCIe port devices.
>>
>> The fatal error status will be used in future patches implementing
>> CXL PCIe port uncorrectable error handling and logging.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/pci/pcie/aer.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 1d3e5b929661..d772f123c6a2 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1250,6 +1250,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>  		   type == PCI_EXP_TYPE_RC_EC ||
>>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
>> +		   type == PCI_EXP_TYPE_UPSTREAM ||
> At minimal we probably should do something like
> (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)
> instead so we don't regress the original PCI behavior?

Good Idea. I'll change the condition to what you recommend.

Regards,
Terry


