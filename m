Return-Path: <linux-pci+bounces-29001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0866ACE4B7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12EE169627
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE701A7262;
	Wed,  4 Jun 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AmWwB0EZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254A1DE4C9;
	Wed,  4 Jun 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749064712; cv=fail; b=h89EnqLbfbh7DF/HFFEz8Mon+Kzm1kOyLSLiJQWfaS2RUONz1Vk19M2N05zNU1mk4IvWvXzYaI6QKbOQU6w2SXoXsN/+WgLqwnklrrlnVxj8qIw7XuCsYZNx3C50qrli3S8aetQISNHSyBgFAF4uFud49CrEayXMxixKIyRuz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749064712; c=relaxed/simple;
	bh=iVlY9K2NrwbLBcBQFks21WXyJQF9XVhAYl9b+RfdOdA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EWtyg9GCAAh1HHveNBszyEshNGXiqCymHi+qAVmSBsld8sjOinQOi2RVg3+WtiZ85hAc8IotJpQCuEojfRRuvCUmbQ/PhS952L3zLzcVZrB1E9wdsRPYZdUI2cgHELdPyhVyqZ0ir6CyDAnAPEvs4hBQ7PDzXKdEESpWjxsJ4Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AmWwB0EZ; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcIMFhiYqCcHj0d3SRXpkqIgxTdlaAttoejiZedqRMUyusyHv6ihx2Vf0JJcP7gU1QS++jtY8zUyzi5ENFhAnH9aa+4s5BiQ3xfCUfBk1UrrArwrqjpMqxs7mGjycZ5fiiHoC4pwAlhyLF89ctSd4gjOZ4UbsvxjGh3R3CE0m+I7o3goQ84Uh9kDtQtlC4LVbz3SWIPqBNnEqP/Yd2/yYE+gt9LBd+7qcXlspwHTdhErv6w7Wkue9Weu5x3ZbfPu2CEJksBGOEqMJgrNrjUMe+x+WPph6IpGnvV5SQCibwWxS5BnxpIX91wbPSISrdPYoVn/n/KcafnKGmEFtUZtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKD7nwjVeS1dL7aXTnx0vdbcxzpkqpremJrN5KqtVTw=;
 b=O3pMTh3NByknzSbKYHoNrVFczxK8VZyFfccShHZC5ltc3+bPCv3P36tgiduJe1fH/f2WaHVfa/aJ+n5DN4nWESVknM8jy8V7DnqylF879vCKMgNK6nIZQjRm9X8eUJS5TJrvl5aR2EpYov+qY1V2hazIDSadYQr3Bfpvc1KqGd6G8Y3gHJtAhAGLWxOPSkRHXYRPr5W8Dm9dJvyBrTJYX94e3s9J3wVS1yIofcSGZC8KOZy3Ye6wIR0kPzlcOQv9X3YwGmN8KcHdYbbDuRix/xK9rAIgThbNa2XzvbwVJJYT86Wlto2VH+8bFuVoLmfcYcXfwVwyY0K8epKfPlnwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKD7nwjVeS1dL7aXTnx0vdbcxzpkqpremJrN5KqtVTw=;
 b=AmWwB0EZyqPK5d7djNofCL6lM659Yt6Tv8KeVvo3/qzh7/ddwU1GH02EjLmf6uT2zWWb96bFsKSNGDjuUAIxwp9rlB1QGFlOas8bDnIYTIIJmY0Iv8KEmVD24TW5pta1q1hUgTdTqdABoKY/M8KoPTgB2vdPW8eq133Q4iQp2Wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 4 Jun
 2025 19:18:28 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 19:18:28 +0000
Message-ID: <ba7c6554-bac1-4c89-96a1-691e2bdffbc6@amd.com>
Date: Wed, 4 Jun 2025 14:18:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/16] PCI/CXL: Add pcie_is_cxl()
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-2-terry.bowman@amd.com>
 <bd3d4af2-aeff-4135-87e9-60b18f290d0e@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <bd3d4af2-aeff-4135-87e9-60b18f290d0e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:5:54::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8a7fe7-e79d-46dd-45aa-08dda39c960c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW1pdnZ0MGo4bE1rZGg5dFFHWEE4RW51Y0poL05zNk1wZk1DOUpHV3FWdXlE?=
 =?utf-8?B?YVVLTDFRbUQxZkF2Ty9BTnp1ay9qUUdoYjBJWGdzakRBWTZ0bHhIMG80Mito?=
 =?utf-8?B?QTFoN3Z6ZGwwTnpHQ2xLaExvNllmZ2NuZXdlUUdJWHpud0lFT1V4SGsyTjhV?=
 =?utf-8?B?K2hOZUV1WTY2U3cyeERCYlIzeUdnRDR2c3EwRWwvalA1OUt6VDlEUEN3TlF3?=
 =?utf-8?B?dTNyMFlnU3dkNTZSVE9HNVF2cWN3eWc5cnRVRXdGZGg1bFpYN1NKUmpja3BF?=
 =?utf-8?B?L2x0VW5oaGwzVzgrUUhWSmt2STNiWm9zaTBPTGRnMkpUeXU3RjFsVHlYaEZr?=
 =?utf-8?B?VDkzYVhPM3NUcjJhd3NkSklvWnA4STlrNzZwLythc2FJODUzOFRQZGJnUkZW?=
 =?utf-8?B?MXNMZXhqRzZrMTEvYzVITU9jcWpQQ3N5RTZFSzBiTmVEUG15dXIvZkRBUFRq?=
 =?utf-8?B?c0NkZE9jbmYrYVB0dC90TFF1UzZVWXd1QkNLbmFEV1F6Qk9jWHMyZjZadk5x?=
 =?utf-8?B?bnFzS1NEVFBCK09sQ1BtM0duZS9jWFpyVk1kR3REd2QzUDBoWTlhUmtNaFlq?=
 =?utf-8?B?YUdoT013OG5kdndYVEt6dXRoa1FXbHB1TlR1NXBVK0JIT2ZlVEM4YmpIdHlU?=
 =?utf-8?B?cmU4MWdQR0NEaENSWHljVm10SVZCRzRlY0ltcmxJMm5JaTFtMXQrZHFHbkdV?=
 =?utf-8?B?ZUMwMVB3Rk5DUG1FN0k1eCs5K05vZTlqUDhyVU9yb1VMMTRCcFNaZnpSbDdp?=
 =?utf-8?B?VTQ3YjNNemczTG1iTEFPMk1DSkNVZXVkM0dYc20wazhwOE9LQjBqOEdjNEpj?=
 =?utf-8?B?am9iSGpSU0cwcEpFR0pkYStPVUJjQXNHWWlkNjg2a3NDN3NVT0RpZ1F5Z1By?=
 =?utf-8?B?dENzbi9UWHQ1elUxMFExbEdqUm05Z1lmTWw4UFgvelZ0WWFDZUJGTmFNNWtU?=
 =?utf-8?B?N3IxbkJSV0VIY1NOb1RsSW02L3VNeVBvWG9tenp3Z0ZaL3ZVSEdZL3Joc0dP?=
 =?utf-8?B?T3NURUZmVVptTmJ1eDZ5YVZHbFNpclhxYkFkaEV2SHR4ZU9aa1dYb1ZQS0Zs?=
 =?utf-8?B?SW53M25iU09yRHM5UWYwclk4YXhFMEg5L2JQSjBmTHRlbWJVREREWmdPWmZa?=
 =?utf-8?B?czJ0R0RlRHdLZFNkMnRHZ0JwKzR2U2FlWFViUnZqQUZ5aWVSNUViSUxhYTQx?=
 =?utf-8?B?TkU1QWFTVi8yME5MRC8xby95TWIxRHNKR1VrME9yT205cXp1VXV4Qk9jWENs?=
 =?utf-8?B?aUxyMmUzRS91aEpFd2hjYldRWlBMSnFNbkJYbWNMNGdCV204dFI0bFdxLzNz?=
 =?utf-8?B?ckFNR1hYdEFGQW9xSEk0b1Fjemx0Umd5UGxLSjFqZFhLY3JBWmZmeXoxcDBP?=
 =?utf-8?B?b3NDcGtMdlU5L3d3TGlYUnA5SlBRQWswejdWMC8rRkhKMTRwZUNYeGdEQVRD?=
 =?utf-8?B?S0JVcmYzOUlaeEoybXhrSlZ2VlM5Z2NQeE94UUR4dzdxR0FMNmNKc1JBT096?=
 =?utf-8?B?ekdVL3J3TWZKUGtKaFlOOStNSkpyaWZpRXpYWjZESVJrTmh0YzMyZnZzSi9Z?=
 =?utf-8?B?Z1ZFUFBub2trVVc0aitwREYzWGFwREMwaEJZYklRTUxvcnZUWWhlUW9YZFpM?=
 =?utf-8?B?KzFTR21nSEhMZXZ3TGtudC9kYjUwdGpXdzdNVHZjVlNWZkE3WHkxSnJRTk5z?=
 =?utf-8?B?c0tNbWc1bWhkWS9Ob0g3ejhxRWhUSzNNbFJJZ1BrczJwS1dHRG90UzF2UWZS?=
 =?utf-8?B?UTBCRDdDbTc5eGVzdDBkSmxWKzlQSDNYemZTbzE1UnowODl4YWJMTVFYcUFR?=
 =?utf-8?B?Zlp2QklXSDFPdWY5NktnVlFiZ0t0MlNOT1QxTy9PdlpxRC9Pc1FiTS9kZXFY?=
 =?utf-8?B?aS9oL0lvSmRYUFFKS3V3RlNURGRQUG01R3J2eGNtSmlDSHdRWXVld1RFWHpS?=
 =?utf-8?B?QnNaUi90a0VXbEdkZDc2UzQ2MTBrN29XdHBnTHRUSCtIYWllN1RhaTg1MkRp?=
 =?utf-8?B?Rk1YSmFXRXN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZExIK0d0NFVZdG1iSEJWNTVnaFpBdG9WWjRGOVFIWVVXMWlxYzAycWNjNGZk?=
 =?utf-8?B?eEJJb0M3RVViaDFYeDJZT2I4TGg2MjJVTDYrdDBBdENlMDF6ZHhWdGpFSWtq?=
 =?utf-8?B?aHU1Q1Noc24xWlNRN0dST21VR2poWTNRSzVaMVZIdXpscDVkQ2JvQ0dxVUY2?=
 =?utf-8?B?YXhiS0drTEVSSWNpb1pFZ0t1MGpoTHJ4bXd4TlJ6bWxZZ1gzYnVPeWhlWmsy?=
 =?utf-8?B?Y1pzTGdBN1BVYm1WSnhtM0NnZUROVVRlU0JtM3Fwbkh4QUpKQlZpb25HZHY4?=
 =?utf-8?B?V1lxV1pKUTBRVFpTSm9rS3JHUDVvdGx5M2RIZUI1ZXhhaDMzNit4TW1RYm52?=
 =?utf-8?B?UzNFQ3hxcjZKbitWZ1I3MzIyNFlQVUFNWWo3Tmg0SHc5UE1oamQzVDIvOFVG?=
 =?utf-8?B?UG0zdGxLYkx5RHZ3YTNZZ0NaNno4L3hleVcxUWVJanBnRHp2aEhCUEd3OFNy?=
 =?utf-8?B?Wm9CRmhvcXgzeEFiZmtyOE0xZmdqOEpCUC9VU3M2ODl5YVZRU2xBN0h3NHFM?=
 =?utf-8?B?aHpnQkROdUJLWWhjclJnMTNJVXdQS29XUllNU2lGaXZBNm51eDVGamNBcXVF?=
 =?utf-8?B?aEpkbHpPTmF5UE5pS3FFTnMzTk42TjhvRUE2eFowekNjcjhmdUdrZUNoM2RG?=
 =?utf-8?B?ZHRwOVdhVmlPbm93M3NXNGJLaTNTZHhONzNTdXhudEZrMmRBYjJvNGsyeTFH?=
 =?utf-8?B?djRvUm1CVzNTcndoSkliZ0RSZWEwcndMOGFzY0Zuc21WdnBhRXVGYWxUa3lK?=
 =?utf-8?B?OC8vMHBWYWY5N2V0WXpjcUxwT2g5Zi9lNEkxODhTZSsyei9na3NQcTVpZDhV?=
 =?utf-8?B?ZXJmMC9wbVlUMW5JQmQ4d0huTXl0U2FKVlVzRTY3YVp6Q0pBajRhejlHZ2E0?=
 =?utf-8?B?NHZVTTZrYUV1SHZoR214REUwVXZnU3FNNGlUekZONWpDWGdldU04LzZ1ZUhP?=
 =?utf-8?B?eTdUYnFOT2plMHRXU20rK3hTWkdhNC9ra1RzT014a1M2cCs1aWN4dGlKR1hO?=
 =?utf-8?B?YVdtT2pDK0JWS3QxVXpEN1NSSFpKcnJ2MTdxTzNicXNRcnJ4YU4ySjZ1eWhK?=
 =?utf-8?B?VzFBZHlwdEVvUHd6RTFLcjUyMEtMRmZRU1V0M3dpS0FkRjRqSVVaZkEzV2ND?=
 =?utf-8?B?MmV3NEVNWEhKL21aV29md0FrbEY3Q3BlckdsQ3kyQ0x4dE05T1FnZ29DVXZB?=
 =?utf-8?B?U3hXUGpiZEpZTHdoems3NzFNM01wdjZSUTkvRG1BVE5sUFRzUlVnMFRqdWNM?=
 =?utf-8?B?QzlLUHlYT3dMZ0hMdEV5UFowSXlGbTFkbURzSDFBWlZnS0E1cU9sVlgzMFg1?=
 =?utf-8?B?NFdvZUtta0RQM1VhQWtqTnM3Nzh0UTk2VlBTRHUrZ1pQcGhDQVdiVmhWNEJS?=
 =?utf-8?B?MlkzUlcwMVF1d3ZCaHhVbFAvWGZNRm01ZUxlejBtRGJFWE9EQmdxWjl5THYv?=
 =?utf-8?B?M0FQc0xKVy85bXJON2o1ODBuOHFhNmdYWkh0RSt6RS9kTTV1Y2wrcVl4VWFY?=
 =?utf-8?B?Ri9TNFIxbGd4V3FacHNzL1psQSttK3lDWVllVExDZlZaWk1wdnpVRHQzcVZ3?=
 =?utf-8?B?N2F4MkhkWnNGN2MwOHNueFNlTzhqV3hhS2VmWkJIc3hOWmo3MG9zZGV5VjZD?=
 =?utf-8?B?UTFJOWNlYkFqWDZLYklZZm01SU8yZkU4UHJaZEc2QUFjYzNpa2FIalo4R2hy?=
 =?utf-8?B?ZVJ4NXZ3cDFyV1kxK2hpd0c2Tm5udFlITUhRZUJGeDlCNzFodnhHVS8yM1ps?=
 =?utf-8?B?SGtDazA0Tm1YRXBrVEkyNXVMaHlyUFI3VmtsdWFlRGV6Tjg4Y1lVY3BXQmhF?=
 =?utf-8?B?bnIyQW5aeGRqMUNzWjB6VUczQXUrQkYyWE5ZZUNMTDNsSk1FZjljR1NMV0V0?=
 =?utf-8?B?NGNuY21PS0VzVVp5NWZZQ3lkN1EvUE1qeUhyV2Y1UWFNL0dXYXVyMS8rOUlh?=
 =?utf-8?B?a1dBZUdwS0xnVjRvQU1Mb0IvdTlITXBid0FwYjNZcWpDZG9TZmFabmlzZHJY?=
 =?utf-8?B?SjkyQVkvdmVRcVIzWWVuWHNweDZVVERFaEUxTVJhQnVMUUVVMm1meDBhMW1i?=
 =?utf-8?B?Nkk5K042TWNtaFd5TVRtUUxxT3YycmlYYzdNeHpqcVMyNWpDTDM0SXpoaEJJ?=
 =?utf-8?Q?Y7EZYjDmYviQXqGp4BFPIiz6d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8a7fe7-e79d-46dd-45aa-08dda39c960c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:18:28.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jIj0bGIUvFJVNq5hoycgAAmglRpnk2Vju2KkSKJawbxSPntfSOv6nPx9MI/Zx1nrGleZDC9CVu0U1bsbCVmfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878



On 6/4/2025 2:06 PM, Sathyanarayanan Kuppuswamy wrote:
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices.
>>
>> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
>> CXL Flexbus DVSEC presence is used because it is required for all the CXL
>> PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> Flexbus presence.
>>
>> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>      Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> ---
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
Thanks for reviewing Kuppuswamy. Terry

