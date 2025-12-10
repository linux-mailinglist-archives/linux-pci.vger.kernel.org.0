Return-Path: <linux-pci+bounces-42913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A7CB41C2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 22:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFF93300A8C0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1732471C;
	Wed, 10 Dec 2025 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pYkPkSQQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880D301039;
	Wed, 10 Dec 2025 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403888; cv=fail; b=YI3CYjUbadSnHPbsjb7vltiX6qIjKHmQ/xgPX6IPDA3ZX8plearVrto7V1VAahdT5atohoG0uZQy7DPSimn6M/R0rHlVd+q2Rklw1L9LKC1KNMB4A/o5raekGspYsYgt66mN50eOgAdu+erDECASsuW08FeaCHhCaqlCH7Krzu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403888; c=relaxed/simple;
	bh=6pPKR/rmuPajvba6qUDNQSXL6Vzs9/qAtaiQZtNf+0c=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yfxs7mDdZeULRbpx9IQ3diPzbJlTndCVXchK0jva8vGnAK7o/Ncr1DQlz2ALndC8o2+YUIQJ0aW3Jn2XqhWN6LGuFX/lfK020Y+1Nrn5yjdcNNzpzdhCMtD3kTqV7ep3XmxtQj5ubsY9boShi2HKqzyHOUrD3NmS91byK3nSPrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pYkPkSQQ; arc=fail smtp.client-ip=40.93.195.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvJYcopEB+k+WJdir2fgJwyYAPtxWKoLhzlLTKDz3RntiCyN//PBFTyhzx24oMR5Mg8EV5hS68WVnDtEHd7dsRzM+ZvJXWtYtcXAjGQhHlPgoAOFvl0m3erLNXUG8waYIDaTMh8iU3TyObHcT6tIpH3o78yvdZNOsLzOJvAkOpyqImKY4TT7nts9bDDyKMVl9MNZLG0RF+Hf6l9s9uvXHskMcNJzDw1zaOnNs7Swc2KcaoJtbQRGJjo+bAm5Nhm88kCs7Rz2npnkMtrbnaNQ27pzvcvWtdLiK6nR2SjrSya9yeZ/2sIC0XAMmyMb2PerJ3s449UFiBLR644te/RVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb4ag7TSDw3YAxOQPke3Mkm+uvCPaYUWyO73pCAujMg=;
 b=GhINlvZnJq446GzKYzcZn+BErrPUQqBWcLqJCMq8hWUZyp0+kOHhedPThl9XGH6W2PyQ2k4bxpdRNXwm+5ASAw2m5MIFCO9wKMqYQg6GpgSaq3HfZi6mp66+UcHKCkGvfKaGrFEDoZS5lbANbTFtDCQSBAxDzfj0lxUWf+meUEgpqfQRQEDVjjxWJ3pUb4RZpBwLMHO/SDAyV446BBslTRtb54/Y/b1HU5hz1mIAb1evnrqrocObF2llneylv98p/y8xd6uPsoMaC0rC83xTeUceOJ57Qq7TZp27er4MdR89dMdh8HB/9NkIy7nD35M0rQqm01guGF7QpeJ0jC57mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb4ag7TSDw3YAxOQPke3Mkm+uvCPaYUWyO73pCAujMg=;
 b=pYkPkSQQUIM93FGBP/adN6DSM0If7XtREGHWigmwtpAPyWzNAWx9lDUnfRo1zT8Q6hQeEYQ+9Uq4gbr3bB1n47BSk5js9taIdambiSPW6lRj6XpQ3WLkBYAGHr1MCpBuGhm6ebgPEnIdYqSm8R0cjMpiSK2E7IymZbpsU48YkM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 21:58:02 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 21:58:01 +0000
Message-ID: <212e35e0-3c71-443b-9f4a-8720ef3d0ba0@amd.com>
Date: Wed, 10 Dec 2025 15:57:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/25] CXL/AER: Move AER drivers RCH error handling
 into pcie/aer_cxl_rch.c
From: "Bowman, Terry" <terry.bowman@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251208180624.GA3300935@bhelgaas>
 <ed865f72-8fcc-40ff-afa2-0ed895332126@amd.com>
Content-Language: en-US
In-Reply-To: <ed865f72-8fcc-40ff-afa2-0ed895332126@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::11) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acfe0b7-0ed6-44f8-7880-08de38372fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzBjcVRYajgzQzVGVXR5ZkR6WWhtVnlXNUZoKzlHcElqTXRQZWFCU0JuSVAr?=
 =?utf-8?B?blBTTytGVmVnTlNFZXVCbnRLbnNxVTQxdE4yVTRrN3BuMmpIcUowZWNJRlUz?=
 =?utf-8?B?TFJMTWVsOUE5YTdjMzZyMjNRcStYN0RwSUtmZmQwdHFjZEE4NStqSitJSllm?=
 =?utf-8?B?bmtXaXF6NzVjczJqZ1RDZlZrTG90d0dNOGNIQ0UrNUtYaWR5alEzdjFqYm91?=
 =?utf-8?B?UmF5QWpIQkdRaysxU3c4R3pmbDVaUFJwcWtXQkFEY2dVZTUvcXJ2YjVySngw?=
 =?utf-8?B?QThXRXNPVUxkTDhmSUVKMEpmMk1uSk9Va0xyT3d6aU1IVHNUOWd0NDBaQkhP?=
 =?utf-8?B?ZHRwcnhMSHZmM2Y3ZVRKbm1VcTVLa0hkNnQxai8zdElnWFcrL05HNEVnZkhm?=
 =?utf-8?B?T1BsbkJDNGxVakJHV0tublVzM1dPQitYRkl5djhYcDNmbkdhdXgzb0hJVmFQ?=
 =?utf-8?B?cVA1T3NDdWJ3K0VCdHJDNDNSUjNjMW1yTWRMNmpOZjdUd2cvNzZFdWUreGhw?=
 =?utf-8?B?b21yczRaTXFWdDZnNWhLMTdvQkJxNnFaTGEwRXYzV25QMlRoaW1HeWNVVndQ?=
 =?utf-8?B?T0NnZzVieTJzQitUN0duVWhpNFFKa204WG1KWitaUEJybVJqQVZPbmxUN3ZO?=
 =?utf-8?B?bytXSGoyNUhuRUpucWxaL3JjNzAvcDhrckFYVnM5V0o0elRlVHNTNU1WMXln?=
 =?utf-8?B?djRISEhJamFPNFNTSGxQdER5R1FWOWp1ZnZVMHF2RGJ2eWQ3TDJjSVBRckFt?=
 =?utf-8?B?ZkQwb0NPUEF3bnU2Rm1UL3ZyM1NqSytLWGIwMjE3KzBkMVQ4OGRDNjQzanVE?=
 =?utf-8?B?NmZpZVoySHZVNzMxemw2YkxVcFI0ZXNLV01Ia3hyY3hYWWM1UXcyQzY4YXFZ?=
 =?utf-8?B?ZEg2MTh1SkcyS1M2WEFrQ3NzWEttSGxiYnRoSmIrK29HelJ1d044Q044djJ5?=
 =?utf-8?B?TUhuQVp3elZvbStmSGdmWWI0Vkp0QVUrdGp6RVJzNjZib1lyL3ZBdkxuZCtw?=
 =?utf-8?B?Vzg4WmpQQVkvUkhuSnhSVHhSQmljOGc4Y1Y2YjJlZ0RXajNneFRWRTdJMzFZ?=
 =?utf-8?B?WXc4cm1wRkE2Q09RdWNzOGhaa2dxMzB4TmJVNjNUbzhLTTExYWhiaHhOK1NW?=
 =?utf-8?B?cU5KWlFnT08rOXZiUW5xTDd2SVZ0dUp5b1dDcS9qemhFVXBvWDAvcEVEdkhP?=
 =?utf-8?B?dnNvM2lXY2UyQmV5TTRieXM4dkVzdXNFQzZmS0NnS0FobmV5eW90SERwZk84?=
 =?utf-8?B?UmZFS0FGS2RKQkg0WTgwVmxHRXNmdGxONWVTTG02aXdhMDJpNmFCMjVLU3Fh?=
 =?utf-8?B?aWZ6cjYwRUxaVTFnN1E5M2N5L2ZwcTB3RnhvZGNva1NRajI4WXZ0NmRGZDZW?=
 =?utf-8?B?NnYraWxlb2orWW5NNHJPWW1rRmJHZTdPNHlYWDE3VGZRcGRVWktEQUJ0OEJY?=
 =?utf-8?B?dXQ4cXA3dFNNMjRGTjh5b3RmblkzRFdNMlFqYm9EaE9LdjlKdVpBbVBEWHJN?=
 =?utf-8?B?NFNrZGFjeEZ1NHN3TVpreE13RGR2Q2NyTVdwdmhLVFJ4L1pyTmxFejhFQjdU?=
 =?utf-8?B?ckFNc3d1dy9PaG5EbjE3eXdMUmpBRWdOOUFpNVN4SjZXMS9EbnFHbWdaeUt0?=
 =?utf-8?B?bjNDUHU2cjJMY3Ewb1pPNFZKcXk0dDJWU3A5b0k2ckxtb0ErUVVLU3k4ZGdH?=
 =?utf-8?B?eUhUMXlMZ0FoUkdNSmx1MFZYTUJpOFBwSGRnQXJKRFd3S1dQWW1ESFFBR2lY?=
 =?utf-8?B?cGgvVEpVQzRaREJkdml6TDhSNHFVZUExUS9NNllaTWdUdUtxQnkyMUxMdTA2?=
 =?utf-8?B?RThDK29qcDBBeEY5bnJyQ3NvVllneE9iTE54Z2t6SndrMWpBVFZlV3Y5WHpJ?=
 =?utf-8?B?eUYzQ2hjQldWY0piY2RZNEk3ZXJQa2k5MUx2UUVRUGNCNWl1ck1aa2NSQVBi?=
 =?utf-8?Q?FJf/EkXSIqEy8aLCHdHPn2jmdhkJhFIF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmF2OTNibUd2b0xROCtrNkJEQ3VPa0NvVGwwaFlpR1JSeWdiR0NDVGEzZHF2?=
 =?utf-8?B?VUVvaWsyM1laS2tyYVhKcHNjRjluSmZtNVN0c3k2UUIyWkw0WU5Hc3RTOXNU?=
 =?utf-8?B?cjkrT2tWZThOWWdIT1B2SldFQSt3T09wN3BCY2UvTlBzZFMvdm14NXdkRzJv?=
 =?utf-8?B?b0FlbEFVUHVZN0RNS1A5ME1PZXBuSW9EWXpFK2s0UDBwOGFIbzMwSSt0NG4v?=
 =?utf-8?B?OVFQYzJJcklXY09GRUpsRE02TjV0MXRRckswS0NVZmd6c1plVWNvbkx4cjVL?=
 =?utf-8?B?ZElnS2RFbzNmS2ZoMmlmWEMxVTJKSUdrd2RMaUdOYS9vdS8wVVNmRkZzd25D?=
 =?utf-8?B?bjlYR2tSbFY1K0lTVVJBT0pVMHhodWpQbWs0WmZ4ZUFicWFYeU5BTEdmRmZN?=
 =?utf-8?B?MVl5T1ZuTC9UdmRpVHF6QjQvT2c4OVVFeDF2NkpscTNzVk5LdFJyckNrY1po?=
 =?utf-8?B?RWdhOGpkK3BDd2RTbytNTHNaY3FmdWtFV3JmYThJRWpHalhNbEtWa0dKSENx?=
 =?utf-8?B?QTVWNUs4OEhBd3BSWlRVTXdrblZHUzFXZFpuSkhZWkJRUDBpZ2w1ajNJYlNG?=
 =?utf-8?B?akd1a2hGbGJGaTNDOTB3M0RwTEI1YndkdFk1MmhISFdrT1lqRy9NM3Y0aDFT?=
 =?utf-8?B?NkJvV0U3dUVwcG9yOCtlbW9yQUpvVXdBbkxPL1U3SjY0T01tc1o3dFoyRkhm?=
 =?utf-8?B?V1c2RjZ5RGNsQ1JPV2hQUWZZWTZCZU9zT2dqa0M5RWFoaS9oYVJDT1d3Y0lY?=
 =?utf-8?B?QjJXUVlSZ1B1NHRub3k1eWFTTVhKQ3RsYWord1YvakIxY1ZxSUowSE0wRVpE?=
 =?utf-8?B?OXVKSWY1NDBVQ0QvYlM4cXlzR2hRK09OZ3NnZGR4RGdiRjNJOTM0UzVXMEkx?=
 =?utf-8?B?M0NSaDdWTklRMGxzbUc1UjFiYXQyVG50Y0VVaEg2UGFkTUUxYXNQTnA5MVd3?=
 =?utf-8?B?dm5VaXppN0RWb1ZZb1JjSnNaL24yNll4Wm9TcEdWZEFwdTlUUFhrMnB1WGlO?=
 =?utf-8?B?eERDNnloRXN1c3pObXVhY3UwazJlYXVQS3NpZnNXMUtpa2JUK0F3aDQwRXA3?=
 =?utf-8?B?U0h5U21wc0sweTBNRy92UTFXUk5wWDI2VExwbWFnTkxmeG5WV3ZlMXZNejhF?=
 =?utf-8?B?YVNtZkxpRmplK0wrRmc5L1RwT0d0ZVJndEZIRFUxbFlVNWdVTDBKNVk2Mytq?=
 =?utf-8?B?OTRSVEplN2NhRUZmclN6OTNKbzIvQ0l0TWgycTk2NEE1Y2ZyU2k3aWcvMVhL?=
 =?utf-8?B?TnV3QVo0enBFTVdjVm5VTHIxcnkrQXhkcjE1WTNlVy9nUjAvSmFXR1grRHNz?=
 =?utf-8?B?TDhGY3RKU0ZSN1J1bnNOTWJzZ2JYenlyZzRNZEt0eHFTSzVLTW1XZVV3RlNX?=
 =?utf-8?B?RFZVRTJDZUE2aVE3RjhhUTMySndjd3hQbW53Skd3M1BsTGZ5ZGFUekxORHF6?=
 =?utf-8?B?UWhtOCsrbW5RdUR5STRqUUM2UlM5VDJFZ3kxalBGSWV1ZHA4UkNLMXpyRWtw?=
 =?utf-8?B?N216ekFWZXJkT2JLMXliSVM4R2lFTW9tUzhBdlkxUlVrYy9GMEY2ZSsxTkox?=
 =?utf-8?B?dS9oTlU1a0cvM09YNHVUMTlXWTRHNXc1bWdRTjNETjFocno5eVkyaVV1T1pN?=
 =?utf-8?B?bGczNm5vaG1qazdPUXd5VkZ0d2lyRTFoRmg0OU9SMTJ2U3ZXMDhNQ1JCd3Jv?=
 =?utf-8?B?NWQ2N3JERUFmT2FCV0orNEhqdGROa0JkVC9ybzlCL1VlRW8yUmhmUE9zZHB3?=
 =?utf-8?B?N2dLaDMzMmlWSFA5SXM5cTl4blQ3WnhLcldoWDhlMWxmZTFWYWQyaDFRTW9P?=
 =?utf-8?B?UzI4SGZUMTZYZHJBc2dBbWZ3NmkwQURmUDRJZjlhUVBER3RKMXV6MUdHeUxn?=
 =?utf-8?B?eDgrU0ZCN05aV25TMXI0cWo0NEgyY212TUxJSHlWclVQRmVKRjFDOHF0Ump2?=
 =?utf-8?B?UFBreGczR05mYlMwNXpLZnZDRTdGeFJPZmNjM0huRmlaQlpRWWZZblNSV2VM?=
 =?utf-8?B?aHJPWDlxWkt2MjdrMVJNZkc5RmVSSXRwMkIvR1diaGxsY3pUeUV0YTd3dHJw?=
 =?utf-8?B?UGZSOWdtU0g5TDIvcHdURldZbnJabng1NURJaUFlMmJKaFp6cG9Yb21RcWk4?=
 =?utf-8?Q?/+DL5SGnmfv2x0MZuclXBJGmE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acfe0b7-0ed6-44f8-7880-08de38372fe7
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 21:58:01.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1N3h2RrjCva0A3ArjsbCIExpAKS0jaSjdFgzKg684sULJdCXw+CqI8KOC720DZ/m7v7alRftdU1mTpCe8Hrs/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

On 12/8/2025 3:28 PM, Bowman, Terry wrote:
> On 12/8/2025 12:06 PM, Bjorn Helgaas wrote:
>> I vote for a subject like:
>>
>>   PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
>>
>> I think stuff in drivers/pci should have a PCI/... prefix.  "CXL" is
>> really its own major subsystem, not a feature of PCI.
>>
>> On Mon, Nov 03, 2025 at 06:09:44PM -0600, Terry Bowman wrote:
>>> The restricted CXL Host (RCH) AER error handling logic currently resides
>>> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
>>> conditionally compiled using #ifdefs.
>>
>> s|the AER driver file, drivers/pci/pcie/aer.c|aer.c|
>>
>>> Improve the AER driver maintainability by separating the RCH specific logic
>>> from the AER driver's core functionality and removing the ifdefs. Introduce
>>> drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into.
>>> Conditionally compile the file using the CONFIG_CXL_RCH_RAS Kconfig.
>>>
>>> Move the CXL logic into the new file but leave helper functions in aer.c
>>> for now as they will be moved in future patch for CXL virtual hierarchy
>>> handling. Export the handler functions as needed. Export
>>> pci_aer_unmask_internal_errors() allowing for all subsystems to use.
>>> Avoid multiple declaration moves and export cxl_error_is_native() now to
>>> allow access from cxl_core.
>>>
>>> Inorder to maintain compilation after the move other changes are required.
>>> Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
>>> inorder for accessing from the AER driver in aer.c.
>>
>> s/Inorder to/In order to/  (or just "To maintain ...")
>> /inorder for accessing from the AER driver in/so they can be used by/
>>
>>> Update the new file with the SPDX and 2023 AMD copyright notations because
>>> the RCH bits were initally contributed in 2023 by AMD.
>>
>> Maybe cite the commit that did this so it's easy to check.
>>
> 
> Ok
> 
>>> +++ b/drivers/pci/pci.h
>>
>>> +#ifdef CONFIG_CXL_RAS
>>> +bool is_internal_error(struct aer_err_info *info);
>>> +#else
>>> +static inline bool is_internal_error(struct aer_err_info *info) { return false; }
>>
>> This used to be static and internal.  "is_internal_error()" seems a
>> little too generic now that it's not static; probably should include
>> "aer".  Maybe rename it in a preliminary patch so the move is more of
>> a pure move.
>>
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -1130,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
>>>   * Note: AER must be enabled and supported by the device which must be
>>>   * checked in advance, e.g. with pcie_aer_is_native().
>>>   */
>>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>  {
>>>  	int aer = dev->aer_cap;
>>>  	u32 mask;
>>> @@ -1143,116 +1143,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>  	mask &= ~PCI_ERR_COR_INTERNAL;
>>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>>  }
>>> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>>
>> Not sure why these EXPORTs are needed.  Is there a caller that can be
>> a module?  The callers I see look like they would be builtin.  If you
>> add callers later that need this, the export can be done then.
>>
> 
> pci_aer_unmask_internal_errors() is called by the cxl_core module later in 
> the 2nd to-last patch. I'll move the export change to the later patch. At 
> one point I was trying to avoid changes to same definitions multiple times.
> 
>>> +++ b/include/linux/aer.h
>>> @@ -56,12 +56,20 @@ struct aer_capability_regs {
>>>  #if defined(CONFIG_PCIEAER)
>>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>  int pcie_aer_is_native(struct pci_dev *dev);
>>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>>  #else
>>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>  {
>>>  	return -EINVAL;
>>>  }
>>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_CXL_RAS
>>> +bool cxl_error_is_native(struct pci_dev *dev);
>>> +#else
>>> +static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
>>
>> These include/linux/aer.h changes look like a separate patch.  Moving
>> code from aer.c to aer_cxl_rch.c doesn't add any callers outside
>> drivers/pci, so these shouldn't need to be in include/linux/.
> 
> I'll remove these from here.
> 
> - Terry

Hi Bjorn,

I reviewed this more closely and recalled the reasoning behind the change.
Lukas requested that pci_aer_unmask_internal_errors() be made available
across the entire kernel. I already noted this in the commit message, but
I can also include a link to Lukas’s request. Alternatively, I could split
this into a separate patch with a Recommended-by tag, leave it as is, or
make another adjustment. Additionally, I’ll update cxl_error_is_native()
so it’s only included when necessary.

Terry

