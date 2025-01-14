Return-Path: <linux-pci+bounces-19787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C13A11516
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A849918895AE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F5E213245;
	Tue, 14 Jan 2025 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QbWT4jzK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6DB20F09D;
	Tue, 14 Jan 2025 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896251; cv=fail; b=BS56SPa7xeqRiTRcADddFWzbuIv7BCFMPpTEQPAhf5o4mO+NzIbnHlih0joUHjo9v4BFdTcxoc/zBNoOYA2Nla7E14EeIf0oo2/dPOHMhVjiZg/pwSCQRn4K4kihFNqXcfhX/F5ShFZdTSwmlTS6LIdBAtQ7mE+ms5hU/j4+Vgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896251; c=relaxed/simple;
	bh=1/OiJ/XMj84B/pa0+9GOATDlKgZZAZwfICGBDT9xhmM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2oNVYT5WVMEwquyzVVlccOFvon1WHSFqQWSy9gzShBKPHzfssFvuOyo8TVFE8mrM7NKc+fO9Dl1fin3k1HyhLkqgfrIGJCoD8ELOqech/DTt1OyA6mL7BwI0WLh60r4Y10wJyoUD9M4fK5GZtssJbhUC8/EHNH8Ty12mYhNqso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QbWT4jzK; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8DywL1VHidIbl2EOL8gsPlUY4SwYT1BW8KHHULIMa5H33/75XYy2H8WZGLqQqydW55IIaccFK0NIHCT8LsbNlWODvzZBccsFJ2q0wjV8k01JIYxsmf01x1zV4USkU+12ONOjFsbKSx84Q/tR0VGYEUMvF2SfCcv5XGbMSE0kFNLdLEhVsIBTGDXjVMEJmc9P5arKmX9tPKtYIrlcD1LBy5Dq73XBzUQpMqRvSm8e/n8a9FjPUU/+cjaSt0NI+ywcfOJ7kOUe8B8rVsqzazINx5OmX2rYDLkPEA6YjtxpXnLg1439ya1uVB49lPzOJFhVi9KTzPMPfryiGMPTqR8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up4NdUthawA63Hm9cGD7xZ0Ey1fo+0Os51Iqiluuqw4=;
 b=vb+LXQEjvz1x9oiQ4V+WzwrrvQBcBRdkUqKVbKX8JH8vsZRi4cN5Uzs1NLrEUligBSR/ZTa3ZJADQv6Cd3cGmKQeqvyKZTiuT962cSOoI76ghxx0aVHFNnyLgGf98Ebd4MOF8FALhGXJhZ9YkvYnuD1PGiPW1cvw4jWySa8fdJkkZF4VA2GFZ5SLYgu0gYRo7mVoZpoK2oITX5BLzhyhp6GGVGkLVRcVdyLk5pSFVYHi5vSKyeSDPaiZdSpgRKslQqeBy4q6d4/RWb4aYinNr1QQxn+wnQYJDLvj47ZrhJhKqPPfhYoCKUq9dADYWRnC+ggkVyrCrpEX69ljJTfXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up4NdUthawA63Hm9cGD7xZ0Ey1fo+0Os51Iqiluuqw4=;
 b=QbWT4jzK3MB3FlKXbDroiwrwk2MpesvS0bLBLrMUvwP7E8b6TI40kmEEQ0EMwNSZb1h5xmHpoicMOJhfui6s36JE3E5lKsj6PA49HaJcwmmaNODBZGAZMOUmsJOI4M/e3HuSnSTZsb0glnBCzpVoByyOa0+TdYQZiglNZRME5Bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.19; Tue, 14 Jan 2025 23:10:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 23:10:46 +0000
Message-ID: <b8080387-dae3-46dc-ba5e-bc33c81201c1@amd.com>
Date: Tue, 14 Jan 2025 17:10:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
 <6786ea6964f3c_186d9b29424@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6786ea6964f3c_186d9b29424@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0166.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::21) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca7d262-f75e-4121-4dcf-08dd34f0ad77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUY5SUVRcU40SUhRUk9pNlJJZ2grOXhzZjBnVXBRK2ZGY3pUVXArZEdMaDlu?=
 =?utf-8?B?b2FqRVV3MytaQU4zYm90UktjNjlKNit5cWp1UW1URzlGZ1RjMHBpWVorQ0Nt?=
 =?utf-8?B?UzdVWmZlekh0NlkvSTh2eWdVWXdZS1hNSk5pdVZseGRCN2pnMU5NL2VuZ1VJ?=
 =?utf-8?B?UGF2VHJXUDQ5Z24rRkFOQ243bXJkV3dyQzFjYjgwWWV0VGlWaVJHOStSRU5y?=
 =?utf-8?B?V3NvMy9IUVl5WCtQalgxSlozczFvay9QY05rTkxJUlRnVXZaL1RUOC92UUZp?=
 =?utf-8?B?bzJWdy91eFI4djFadWJkQVkrKzJLODZZOUpmSm1FaktkaWl4NW5UZWo2eUt0?=
 =?utf-8?B?TXNyWFRjVUhMTnBnaGtidjdCYkxKbjk2bnQ3eks2cjAzaHBSR05DbmgrZlJ3?=
 =?utf-8?B?Z2RHOE43RTlta3RoL0pOZzh4Y0pPRm5qdmdUZUR0SnZWTVVRTk5xKzZQYzA2?=
 =?utf-8?B?Wm5QYVFNR2Z2alNnR3p1WEdkUUd0MG1DZTJNdE1EeCtHUWJPWkdEbzNpMzUz?=
 =?utf-8?B?emM2RFVFQXZBOUtqbmZPN0dVSk15WnUrTjRKWFkxN2RFMDVrbTZESnlsY2Rv?=
 =?utf-8?B?N3JvZzlkVFpxc1dESEpJN0F6YzA2YlV5U3RZZmp6Rm5aTnk4c0hRblVLbHM2?=
 =?utf-8?B?eE8rK3hCVENJeVNwZzVUTEpDeXJKZ3JFRHBxL1pSY21GUmE1bkpOU3FTQ2xG?=
 =?utf-8?B?QVdqN0FoYmZDK0lOcU1xTVU5c1lxeFZHN0RLYmlISndwN1BIOHdzTk43a3Bu?=
 =?utf-8?B?ci9MNVVrM01OS2lzdXVEdjRBWnArTFVNQzBka3FnUWMxZXpuSWZyU0dKMStC?=
 =?utf-8?B?UjV5U0tOOFFGM2YwbTBLV25WekthK2FWY3NBWDErYkJxUmp3RU45RHk0V1Zn?=
 =?utf-8?B?TFBDaWtmTWM2ZG5zS0RWYkwwZXZvbTJUajRXekVwZksyYUFVb25JSHhybUFW?=
 =?utf-8?B?WkxEd3hPczl3ZDV2cWlJc0JRY1o1NDlWTFZCdGtvR2w3QjVQeWZUWmhhMG53?=
 =?utf-8?B?TS9tMkxCYU5VOW4zM1lWc1FtSDNJekhDQk9reGdxbTVpUHI5dElaNUV3Q09D?=
 =?utf-8?B?SUxIeUVJYnM2ZnhHVzJ0bnI0QXZlZGtmUk1kcEpBcmRUdEovTnU2QklNWWRp?=
 =?utf-8?B?RDNpQmF3RnRrekNGVHFLU052TXowOU51VHNvbXhyMlgyak0rNDZqaFpRcjl2?=
 =?utf-8?B?WnEyM1U0MVBVZXVtUnBnQkpmVy82dXEyL1lOakkxZHdWcUhkZGJ1QWZNZmZ5?=
 =?utf-8?B?dUUzeFlMeGNQSjZoN3dVeTYwTFdhN2pRYy8zLzFSdlpFSlIzZlZSaU51NjF2?=
 =?utf-8?B?b3NNNW91NWp0ZXFJejBzTjRRa3d1RG9wcTZtd0pUWFQ2aEI1bXdBODNkZlFD?=
 =?utf-8?B?aXI4QkRJRmprTGQvMXFYTHRqRlpFdlJTdUxReGpSYS9ZN2dZODI1QWpyYyti?=
 =?utf-8?B?UStqYUxBQTRUY3lSNXpKVXZ5eU9nV3FVWVMrNkoxcnVjdjBVb3pobFZNUEUr?=
 =?utf-8?B?UTRNc21RUnZ0SExQbGpQeXNVTHBSU0xZeS9tZWtXWDk1U0c5Y2VwZlVWQnUr?=
 =?utf-8?B?a0RoZnp3eWYzU21IVEhKRHNmSkZFdjN3d01HZ3hURXlVWVNTYitGc1gvdUdW?=
 =?utf-8?B?TUYyV2p4bkJLNnhvOUtvd0J1Zm5ycmVab3RjNGlKaWxEZ3NsOFhtQzFLSnVT?=
 =?utf-8?B?MkVaS3kwUHlveGtFbkdFdXo5dEhYWmJjRU10V3I4RHYwaGZrN0RxbXJ1MWhK?=
 =?utf-8?B?MmtjK3ZZSDBka0FRUkR0L3dZSklRU0lFTmlabC9GWGp3K1drZnVqd3NabUhz?=
 =?utf-8?B?a1VUcUUxenNtZGErTFV1OFBzYUU3endtNGZ6U08vT2h4dXFzakNtaVFodTJx?=
 =?utf-8?B?Y3hjL1NxclBLVS9XT3Z3aWFibTdWWVpVc3NkbTU5MDhnNm80Y01BMmJaT1Nt?=
 =?utf-8?Q?m1VEoNe0QTc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjFjTnhxV21UUkZhWFhndXo0USs3RU5Selh0Ylh6SHd4aWRlZVNsZTlVNmk2?=
 =?utf-8?B?OXdRVkk5bHh0MXRpZW5BamoxQWtlTGMxOUQwVHBuQkl5L0dPZy9tUDVHWWtm?=
 =?utf-8?B?RUtva0pjNTlqTGprUHRXUUxSWUkrbVpFd3duVVFSZHNmSXlSNWd3SGhGUFU1?=
 =?utf-8?B?cWNsTmtqckNJOHJ2QmdLWmo4aDFjWjhkY3ZIYk8wbnVtd08zcS9OU2E3UzZJ?=
 =?utf-8?B?clhxZmNLWk9kaXFKU1YyY3J3NjNkaWNBU1pDU1l4ei93NzVsT0RFSnJFS1pp?=
 =?utf-8?B?Z2syODRhVGpPb3lCY3Z6blpEYW5JWHRmWktBdUFXeVVDblNUQ3BwMk91MHVp?=
 =?utf-8?B?bTMzNnlBb2Z4eW9Rc0xBMXNlTXNmTThFb2hHTS9yMWVrQU9PRDNsNTJaTUdN?=
 =?utf-8?B?bXpSQmowQmdPYm1yOFNKQXFRcHZIaEFFd1Zac1BJNzF3ZDRFRnF4YWFIM0sv?=
 =?utf-8?B?T2NzZUlFem9kWTVkVzJueWc2clVzaTdwMm1BSG1rZEJtbDZPdGpqS3JPZFlQ?=
 =?utf-8?B?dlAyWDNrSFVkR1Bzclc0VXQreWhFZkRUWCttZkxGcTlOVTlNVitLNWxoWTJY?=
 =?utf-8?B?U1VYQ1NMUUVWclBEY1F4RUN6K2xXelFEb0NoS2dPTzJVdldLQXlXNFlmem5q?=
 =?utf-8?B?Q2dneTZvRnczTGtCc2o5UEQzUFZ6Rk1MV0VqTmlmUTRHemxxcHpKeHNuaDJ6?=
 =?utf-8?B?ajRLWFF4SERvbDQyeHR3Y3RHMGUwa3RIK3k5ejJxNXE0czhDWjFZRDFQWkxS?=
 =?utf-8?B?ZC9lWkNtcXNROCt2UitTVG1zOHlYZ1ErRG9ScUpuOVdyRmF3YUsxV21UeTFs?=
 =?utf-8?B?NGI1NDN3TlhWY3RKSk16UUMzRTVUbWRidll2VitERjJ2aDA3UERpdC94QTJh?=
 =?utf-8?B?WU05Z3JYbVExYWFXeHJpYTRVRFg3Y1lhWUhldU5mcEwxZi9ZZ2VHdldCMGFG?=
 =?utf-8?B?dU9kM0R1SHJmR3FaMTVnb3liT1FyZGNPNVdmZTVUWXh2c0ZRQzJsbnJJS0xs?=
 =?utf-8?B?T1dXL0pOVjZKOGVqZjVNNWZPekhOT0twbWhubkpkVUl2YksxRFlEYktWTEMx?=
 =?utf-8?B?ZWF4SlVWVFBldHd3Z2lwMVlLVDZzelI4YkRWOWFSemxnMWtwaHFRcGxNZFpT?=
 =?utf-8?B?SUs5UzJXK1hjY3BFUlFqMkJwaDh0NGp4ZCtJVjNSdGdianBJOVhJT0lLejhS?=
 =?utf-8?B?eVcwZU9ZclBMVnhtQXFxamt3SkI3d214RFowWm1nc09EQjdpNUZIS01tTm4y?=
 =?utf-8?B?cDk3R0IzT1hkQzRlZXdYclQ0dmNMTDlPandsUWRSMk1hVjdlZ244RWV3a2hq?=
 =?utf-8?B?WVpKeVdkQmFwSmRvM01lNk9zbU5NeXh2ZHVQTDR1R2VSYTA4cjFBbXgyMUFv?=
 =?utf-8?B?K2xieUN0aXFnK1hQcC9tRytLTWN1eVRITG5LanVtUmdNcjVSS0xBVWZWUGlX?=
 =?utf-8?B?SFdBYXEvSEx6TmdFb1FqcGZsYVdmQnRRaGxxMW81UTJpSFp0WUl3elJIN2JI?=
 =?utf-8?B?aUswNFNjUHBlYmtranlIT1l1RCtLQzNmeXlhL0tBdmpjaElGRWNFUkVCVjhp?=
 =?utf-8?B?YXA0eVRVa3l0enM5VGFxdEk1a2x5M041ZktVNTJoV0c4aVI4d0lsVFBUVXI4?=
 =?utf-8?B?YnlwVnR1NVlpbm5iWFd0bVcwRnVvYllIY3hLZ0F3OEhhQTQvVXBZSFQ2UkFu?=
 =?utf-8?B?ZlpHalVlTDFNOEhTMjBLRTRVWFF2L1JGYXd6UjFJRFBpSXQ0KzVMSjJnRXFu?=
 =?utf-8?B?ZlU1Y1k1MWFUWmtxN2I4QnV6b3UrekVXZEJHajJkY0kwRVNLNGRacWRBTE41?=
 =?utf-8?B?Qkc0bmsyMk9ROGhNV1hBakRrRGRVSisyZ2FwS01aTE9yRS8zRDl5cVdmcWd0?=
 =?utf-8?B?aXlrZWFhMjlhQitPS09CMEFxOXl2Q1hIZ2pJcUpjcDJxNmljTUNKVmJsQWpZ?=
 =?utf-8?B?Smt3S1REWUhYNmhzdlJGb2Q1eXFFY2hCODNnN3Q4S3pORjFWQUVzWVo5RzVC?=
 =?utf-8?B?L2RueTZtNFc4RjZFYllMdWl4aHhIL3JxMUNCcWtFQ28vQVRUL09OemVyMzNO?=
 =?utf-8?B?NngxMWJucWQremZjSkpQSmN4Y0tra2wvL2ZtTW9aUGRyYXdLT0F5V0xZTUxU?=
 =?utf-8?Q?J02BzkHtPyH+FyvFr5O622dO9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca7d262-f75e-4121-4dcf-08dd34f0ad77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:10:46.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDc7QpnmV0GcQzsNxnvUGVWGFynTGfo1A5Ne6DIUIrrC9g2bd5vrpze/g8rV1hlTdQoizVxYMu6ZsBJbJHp3SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194




On 1/14/2025 4:51 PM, Ira Weiny wrote:
> Terry Bowman wrote:
>> Introduce correctable and uncorrectable CXL PCIe Port Protocol Error
>> handlers.
>>
>> The handlers will be called with a 'struct pci_dev' parameter
>> indicating the CXL Port device requiring handling. The CXL PCIe Port
>> device's underlying 'struct device' will match the port device in the
>> CXL topology.
>>
>> Use the PCIe Port's device object to find the matching CXL Upstream Switch
>> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
>> matching CXL Port device should contain a cached reference to the RAS
>> register block. The cached RAS block will be used handling the error.
>>
>> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
>> a reference to the RAS registers as a parameter. These functions will use
>> the RAS register reference to indicate an error and clear the device's RAS
>> status.
>>
>> Future patches will assign the error handlers and add trace logging.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 8275b3dc3589..411834f7efe0 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -776,6 +776,69 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>> +static int match_uport(struct device *dev, const void *data)
>> +{
>> +	struct device *uport_dev = (struct device *)data;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return port->uport_dev == uport_dev;
>> +}
>> +
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
>> +{
>> +	struct cxl_port *port;
>> +
>> +	if (!pdev)
>> +		return NULL;
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_dport *dport;
>> +		void __iomem *ras_base;
>> +
>> +		port = find_cxl_port(&pdev->dev, &dport);
>> +		ras_base = dport ? dport->regs.ras : NULL;
>> +		if (port)
>> +			put_device(&port->dev);
>> +		return ras_base;
>> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>> +		struct device *port_dev;
>> +
>> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
>> +					   match_uport);
>> +		if (!port_dev)
>> +			return NULL;
>> +
>> +		port = to_cxl_port(port_dev);
>> +		if (!port)
>> +			return NULL;
>> +
>> +		put_device(port_dev);
> Is there any chance the cxl_port (and subsequently the mapping of the ras
> registers) could go away between here and their use in
> __cxl_handle_*_ras()?
>
> Ira

Yes. I believe that is possible.

Regards,
Terry

>> +		return port->uport_regs.ras;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)
>> +{
>> +	void __iomem *ras_base = cxl_pci_port_ras(pdev);
>> +
>> +	__cxl_handle_cor_ras(&pdev->dev, ras_base);
>> +}
>> +
>> +static bool cxl_port_error_detected(struct pci_dev *pdev)
>> +{
>> +	void __iomem *ras_base = cxl_pci_port_ras(pdev);
>> +
>> +	return __cxl_handle_ras(&pdev->dev, ras_base);
>> +}
>> +
>>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  {
>>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>> -- 
>> 2.34.1
>>
>


