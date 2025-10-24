Return-Path: <linux-pci+bounces-39259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4E0C05904
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E534335B7DD
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211B30F94C;
	Fri, 24 Oct 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w9Ejsfpz"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB530FF26;
	Fri, 24 Oct 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301529; cv=fail; b=iG2UZA6Kd9OZ+C4rVNMW6OF6S1RyiqxXTlbAPjN3bXdJSX/oxe2oiuyB3Qo4gXHO2aG1CGFZco55SdaW1ZK2cUeHj4eG1yj2H0pYh3QbAIj4sVqUDYeQHI5IJZUCXnWuef007LEV9kcJfPLWnDaURz1E8tP1HuiCIY3/n1zgh8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301529; c=relaxed/simple;
	bh=RrcU5xJFzK/pO7ceHgGmVCyE9+0Kla0lBaOEsjzDVS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GOCiOvvkHw51DwyHuRyQ2t1X3dI33lk1F8SBsHqIXOILuFBS0FTFLS0TvCgLMJBbV7hRgQ1hwzuq+vrC5lUEGTvzn3hU1DtMKz9ILOgag4U+XGNT3z/DXIGjz07joWOX9gIFwWUqRk/IfoPqTAdXQOVgI5e7PlYoluZxr68defI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w9Ejsfpz; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JL/quE7GYYq7soy54RlboDxoNKW1x/J8F2zh3mFwVE1/UXQDObubN1wrbuPxPDi32OI1NCpGrdIYoW9W1zoHyg4YphL55cFbdQCon00YhERxtL/4ROdDcdQWpp0aLI4OtPDmmpxbq/eqxU3gk1RSYWYsMlpxXJ+gb91h3PZzo9ypq5M+g6pzC8+rUIlbFWSfaA6jJ+1wUO4czwiqCHOVvcwyj98sDyZAal79nkE/Wzpz54SiuM3P3zTFNfMwTm4TRrAUQ41f4XPSanaiy9z9VBASsTrWp/QJKqHrjyHyyxDFBKarf3u1JJu8AH8/2gJbMVRmtlyZg+X4ULobgOD19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mggU92FxsHRNyVuVvqE/IdDZz31314hn1M5DIZRBOGQ=;
 b=hq9OWRjsLurU5T4xR9qnMz/Twj+5YoISQ6LT2Rle4kESaqLRbGO/XRKmzh5yJUihlxc01Gmckyljb0gACPm8n/1AgCoTTmOoTb6s20KeYXxvHiJQAts7NZrRy8Mc0A6BZ1ts7jlLBas9n5E4SHmZUVFEyYkOumg05rz49sUBsTmolMt+quSt5k3qRfBd++9D7Ravpblskad0kkUUxEGI4zpgCgw1dNkjYcL5Rn7vLpn2EoDPygPbxmOF4FSFvJHDi1QkJYPi9kqI4S6jKDZ8MY7z/O/YpOHwJftqY71a55iQrmUOGgrnIUMTPPBrQeTnQHAPkllu8kYOKeBcNnRQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mggU92FxsHRNyVuVvqE/IdDZz31314hn1M5DIZRBOGQ=;
 b=w9Ejsfpz37TKxQZ6ea8nbt0AgLyFcAscyANW15Rc1zWmH0vvntcNVZj9f2Mo/R9bAG0cRN1C3qMHEsMU6GdLc3yBBWCjAN+GbRFpPeziXF62rgaOR7zeWNLYOROIMwEut6FA1Zky8qJfPK3msfnc9TDMMEuG0ySmzoAcNelGLhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Fri, 24 Oct 2025 10:25:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:25:22 +0000
Message-ID: <2f5d7017-d49c-4358-b12c-0cd00b229f2c@amd.com>
Date: Fri, 24 Oct 2025 11:25:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/25] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Terry Bowman <terry.bowman@amd.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-16-terry.bowman@amd.com>
 <883ee74a-0f11-414e-be62-1d5bdbfb1edd@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <883ee74a-0f11-414e-be62-1d5bdbfb1edd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0258.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 91da26af-4b7f-49bb-3d64-08de12e7a386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFVkQmNRd3Eyb1Zybm50K2FOWk1QREN1TE9zMmsyQ2VEVEliMUZqSkFibXdo?=
 =?utf-8?B?ZzQrc1pISFNJc1g3RUc4TjdPWGZQeGQyVDdkc2xSODJkbkhtSE45T2p5UkxV?=
 =?utf-8?B?UEsxR25lTzdzellQbkhBNCs5Mytqb1NIWGIxTlBjMC93YTgvcVJWMzg5VE0v?=
 =?utf-8?B?V29aY3k3TzdlckFUbGswOHJGTHI2WGlkQ2FOdkxmKzNrU2t6UXJ1NzJFbFlG?=
 =?utf-8?B?VjlSRmV3dEt2cjhUSndXZHFXZkZrWitoSUdESXFBd3psZXdneWRQaExKY2VU?=
 =?utf-8?B?TjBZdXZaQmxkRWhoa2NlRmc1M3BGZldoazB3dyt1dHF6MmN5Vy8xK3ZvVWZJ?=
 =?utf-8?B?NlNRRkhiOWlRQTRhVElpRkpNaGFuZ0gybThLNXNyTllrdmNaZzVVTVcySFBP?=
 =?utf-8?B?ellENDVWQTVSWWZZWVNQZ3Awd2hYVkc2ckpIWnh0bXJYT0R0VWRzU3JNN0I2?=
 =?utf-8?B?cklSMElOWXV2bndqTFAzOUxrcUhzQ293UUFFN1NMb01wSHkyZ2VYRHNvSVlD?=
 =?utf-8?B?R21NWHhNUTVmZEVJTGZ2akdnVkVhTVlxYnVqdjhSWVMzL1ZMakFsQVBmZmtB?=
 =?utf-8?B?VjJ0VEhZbnBENVVZYUVjc3BSRm4wS3NyRklKOS85dkhmejFmeDFHT2ttM0hV?=
 =?utf-8?B?TTQ2eFhhYVJGcG1aL3V0MkswWEc1R3V5NXM3bldrMjNmZndiTFB5YjhXRHRr?=
 =?utf-8?B?SDNnN1lkREV1dFJTdVg4YUJtMGxCNGFTaFFMTzBTMlRDbDVlUlpoYWhycUdY?=
 =?utf-8?B?amFRVEFIYlc4Q25Oekh6S1VPMmlxZnhIREZscTQ0ZTgxZjliOFhPU0llTE4w?=
 =?utf-8?B?QU5RV2p0bG90cEFldGRmcTdqWCtXQTNBOHpBZi9rRHVGVDVmRWpnUEtOZ3Bk?=
 =?utf-8?B?SlNIYUZBeFd6L0MwUFF2c1phVEttZC82N1BWUFB2MS9sb0hNTGVnQlJKMFFY?=
 =?utf-8?B?WEpLbTJVczNoWjhuQk1TSDdhdDBBcEk1VDNJbE9NcnpoNlIzMTJmbHBtZVVO?=
 =?utf-8?B?bzZFaWhvdDA4b2Q2aE5oL2I1TXVlYjNqTTNZTDhKUFR1Ym1jRVVqaVMzL0t4?=
 =?utf-8?B?aUNDSkh2MlBreGRXeGwxNzRrK2txb1JrNWt6VXFsUXhHaVNDalVJbVpzdE1H?=
 =?utf-8?B?a25pVi9qbUhuTWRPREVUNm1MenRFcXgra1ZnOGxyUGkvM3VBNzZrYkNRbFpT?=
 =?utf-8?B?N3hsQUtMN2E3b1FYNUtxdWhLakwxeVlsUXUydjlDbGJuUU9leEwvOC8wZ0NO?=
 =?utf-8?B?b1lFWUdGVTM4dXpRaTVoT2RucVkrQkF1TTVLWEtleHFuRDlQVmpMbE9wb0FN?=
 =?utf-8?B?eG5Rc054N1FTMG5hLzQwV256YzgvZVJEdFRYZFJaUEFMalVORzUvR05YU1U2?=
 =?utf-8?B?SkhVQ0g0c0gxNkdNT1F6Q0c0L0VmT2RUWGFyajlkL1h3UkZQWFg5eDlqRVla?=
 =?utf-8?B?alBPR1ZVY2RYRVVKRnZEcnF2UEtVcnpUZmVtS3ZtQkc1RmtnY3VnMXJoMlVQ?=
 =?utf-8?B?L2lFeFZOQ3J3aG1ndmRUU0tVekozMlp0a2pTQU9EV0M5MG5Ob1dtYktlaWZa?=
 =?utf-8?B?Rm0wNmpldUR5Y1c3OWI5QU82V0FsK2xtTHY5MVVYbjUvMGN3VWt4TkQyT3JN?=
 =?utf-8?B?K1V0b2pDd2FXN2xIakl5NVNWQ2o2SUZHWVZQZE9rZzRvbTlxb2l4K0hEcjVo?=
 =?utf-8?B?bEdQRkUvMnFlVkNHMUFFQkIvTnRRcjVGR1REdFBvelk5b0J1clV0a3VTeFAx?=
 =?utf-8?B?QlVpQkdJQXNIMS9HUE5FeWZlRkszOFRPM2w3aDhlbE9VNk1HYzFmOGRuSGRi?=
 =?utf-8?B?RVFaZnBaaktTTXhQUGJybHhjK2pUMlFVZFg2RDVBOUtwOEhORkdkSU8vcFQ0?=
 =?utf-8?B?VjFxN0RtT0Jmc0UzRnJETDg3TVk5dkFldGgzaDBsVEtHTUNMb0NmRjArWG5p?=
 =?utf-8?B?NHFoMCtldzN4VUpwYnZZM0VHMzdOZFF6dDlpRmQwYjQ2L3pTUVM2MFY0eGZR?=
 =?utf-8?Q?ehpXuXQmQLa/mhl2Gx2n6j3EkaYSWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHpSSkVxdHhPdjJKS2w0R293Y05kczBkbitTU1BHUUQxejBtek5LWkFlQm5W?=
 =?utf-8?B?cmhKRkZtQVFhdlVSY20wTzBiak1SNFZwQmFoNGQ0OXRtaU5rL3RNR084elc5?=
 =?utf-8?B?RFJiK1pNQnUxWXdUYkNVai80Tnp4RnZPZEEvNi9jSnd5cEJmUHhucmhmRGNY?=
 =?utf-8?B?VEo4VWpidHNhVTN4Y3FIZ3VQK3ZoWXVoSWtBd0tab2l4TlNKaXQzWTNPM0ZH?=
 =?utf-8?B?ZkZQUFJ0NUVadG1QN1IwZ2E3ck44QWE5RTBNZXhaWGlWakhObE52SXZjRkV2?=
 =?utf-8?B?dFRwdXVxck5ZbitnODc3aFc3T0VqWWtLblk1RzVLZTQzdW9DRVFZS1ROMWZL?=
 =?utf-8?B?L0N6ZkVUMXlJUno5aUQ0NDE1UHNQNFNJSFhXU05nZjNnRDVVZk5GaEFLdVBi?=
 =?utf-8?B?YWxDNy9OVmpVMU9zTXF3Vzl2S2VCYkU2dVhJaE9lTUxmeVhBVW5zZXBFRldq?=
 =?utf-8?B?dWZiR1lCMGNrQmVJbjJqWjJIQzdGaVU3L3ZDM2V4aWk4RXdOY3c1WVBzbzMw?=
 =?utf-8?B?QnpkTlp6UzNHQTRLTUZRcU4vRDROODNBL1dKMDYvR1NXcUM3cFN6ZzFRYXlE?=
 =?utf-8?B?cjN0Q25vUTBvYVdSSFVRVlFpYXpGTWpDcm1xRklmTmNucHYwdEwzTnlFRElq?=
 =?utf-8?B?MVJtWWtqODZhdzJGaUZqQWxMbXJQR05RL1pJb0ZjZi9COGVyRk9zdS9GRDY5?=
 =?utf-8?B?dmFyTDgraXJ5VCtTellWYzdsN3JPeUZiUGdXQVZ2THI0Y2dwZVpYSEZHZzl5?=
 =?utf-8?B?a3c5MG1ENEJzRXpyRnZVbVRGN2kzNTNYTzZIM2pJUkxyd0dNZnA1SzU0Nnpp?=
 =?utf-8?B?dWpSWHdRNTFIejhlcnJGZE4zd0lrSDBFQXdPMnRyZG5YTXZFN01oYWt4Yml4?=
 =?utf-8?B?SitiM1V6bUpJcFBNQ2dTTkVKVzh0RmtIOWo5RGhBaURDMW9JNzd2aURaUlhJ?=
 =?utf-8?B?Z29aYUdyc0JtVjFKZFRZaGEzNGlnaDJnZVFWY1lGSW13SnMrR2NLcTRtdjZq?=
 =?utf-8?B?SUtGYVBXeER0MzROb1VMcmNPVFhiaU94bHJKZmJOQTRibHlIUEVXaU5vMG1k?=
 =?utf-8?B?VnMyVGl0YjNVV3Fobk02WStsYXYyVTJ6YzRINEZmejVGUjN4VTRRa3pEZUQy?=
 =?utf-8?B?cFhaalpHaktFYmhBcWl6cE1ZdHA4cW1zZHJrZjkwMmQzRTFuT01HTVRmSWFD?=
 =?utf-8?B?czZjZVV5Uk1NM29lVTJKS3ROUkNNN0YrMG43emNoWTZsdUhBUjJvYWQ4N1Ft?=
 =?utf-8?B?blVsNi84c3cvQ1R1ME1JcEUyZGoxMmh4VUhYeW1jRCs4K1ExV1NDampib2Zl?=
 =?utf-8?B?YUU5OXd3dG84SjJZZ2VXK2V0cEZkR2VqU2cvS3gzZVJHMGJGTGs2anJPcGZ4?=
 =?utf-8?B?N2xqZ0NEdXNoeVNKZTZZcS84a0tMbkRXaDNIOXBDWDNtaEpBZ3QwWkRpbklO?=
 =?utf-8?B?N3JzMjFPMjd3TGJUMEF4eXZWZTFueXBuMEw3N2FYQmpROWJXRG9rTlVDQytF?=
 =?utf-8?B?YXh6RXl4emJ2L3RhSmFKVzMyQ0JGZTNRZ3FkL3FDWG1FYkhOVU1BVFJBaUtL?=
 =?utf-8?B?SGlWbmNDRlpvcmJUMCtGYXN5ZS83bUJLUWlZTW1TUVpVQ3RRNFV4QWdEYTBn?=
 =?utf-8?B?K2VHY3RIMC9hMnl4dm5CS2lmK0xRV0xmZ1pkbG11UXBUWXVMTU5nVnFtb21P?=
 =?utf-8?B?RGQ1SUlrVCtRcEJNSE9wQ05KV1p4MTdsRnFPUVhuNDFXazFjaGxqT3pFTThp?=
 =?utf-8?B?R2VIQlFiU3l3OFRmUHJTNC80Sk05NHFLRTJySjZNUWltc0pjZnhHTW5CQWti?=
 =?utf-8?B?Y1VBNzRNbVVjdTlEaDhCb1d0N0NqV1IzT3ZBNDhybnc1Y2FqOG1nMWdxL2Zx?=
 =?utf-8?B?eUxGbDhiald5blNRMXZtcEI3L0VsQWhjK0Y5MDkwWDBBYlZ6cWxpSDc5SmpT?=
 =?utf-8?B?NUdMZVY2RkZZak80TC9jQlA1WC8rdGgwVzE1TGg5N2tNVVZpbzdtS2trdGJ2?=
 =?utf-8?B?TFZmNWVYZW1tZm83RnBoa0tmZlNPdEJOUWszVURhOGptcURKWGh3WjZHSW94?=
 =?utf-8?B?Ty85cE00UWFRZUNLMWpmSENCcHF1ajFoZHhlZk5aUDNFUTJ5L1ovV3NFait0?=
 =?utf-8?Q?2/0dKlE0vdIEyQK1tYfSLVZeh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91da26af-4b7f-49bb-3d64-08de12e7a386
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:25:22.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL9NIIbPu5UIn8C/4JjgDmsQrxlv0mfxecMpQIl68ThxtPgWTgWwYeMYMAs/YocYyT1g9DtLZAz7oGIqv234iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349


On 9/26/25 22:10, Dave Jiang wrote:
>
> On 9/25/25 3:34 PM, Terry Bowman wrote:
>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>> mapping to enable RAS logging. This initialization is currently missing and
>> must be added for CXL RPs and DSPs.
>>
>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>
>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>> created and added to the EP port.
>>
>> Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
>> Upstream Port's CXL capabilities' physical location to be used in mapping
>> the RAS registers.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
>> Changes in v11->v12:
>> - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
>> RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
>>
>> Changes in v10->v11:
>> - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
>> - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
>> - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>>    and cxl_switch_port_init_ras() (Dave Jiang)
>> - Port helper changes were in cxl/port.c, now in core/ras.c (Dave
>> Jiang)
>> ---
>>   drivers/cxl/core/core.h |  7 ++++++
>>   drivers/cxl/core/port.c |  1 +
>>   drivers/cxl/core/ras.c  | 48 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h       |  2 ++
>>   drivers/cxl/cxlpci.h    |  4 ----
>>   drivers/cxl/mem.c       |  4 +++-
>>   drivers/cxl/port.c      |  5 +++++
>>   7 files changed, 66 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 9f4eb7e2feba..8c51a2631716 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -147,6 +147,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>>   #ifdef CONFIG_CXL_RAS
>>   int cxl_ras_init(void);
>>   void cxl_ras_exit(void);
>> +void cxl_switch_port_init_ras(struct cxl_port *port);
>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>   #else
>>   static inline int cxl_ras_init(void)
>>   {
>> @@ -156,6 +159,10 @@ static inline int cxl_ras_init(void)
>>   static inline void cxl_ras_exit(void)
>>   {
>>   }
>> +static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>> +static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>> +						struct device *host) { }
>>   #endif // CONFIG_CXL_RAS
>>   
>>   int cxl_gpf_port_setup(struct cxl_dport *dport);
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index d5f71eb1ade8..bd4be046888a 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -870,6 +870,7 @@ static int cxl_port_add(struct cxl_port *port,
>>   			return rc;
>>   
>>   		port->component_reg_phys = component_reg_phys;
>> +		cxl_port_setup_regs(port, port->component_reg_phys);
> This was actually moved previously to delay the port register probe. It now happens when the first dport is discovered. See the end of __devm_cxl_add_dport().


FWIW (other people not going through my discovery path :-) ) Dave is 
pointing out to his patchset for delaying port probing and now applied 
to next.


Terry, any estimation of when your next version will be sent to the 
list? My Type2 patchset is dependent on yours, so I'll be reviewing it 
as soon as you do it.


Thank you


>>   	} else {
>>   		rc = dev_set_name(dev, "root%d", port->id);
>>   		if (rc)
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 97a5a5c3910f..14a434bd68f0 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -283,6 +283,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>   
>> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>> +					 struct device *host)
>> +{
>> +	struct cxl_register_map *map = &port->reg_map;
>> +
>> +	map->host = host;
>> +	if (cxl_map_component_regs(map, &port->uport_regs,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>> +}
>> +
>> +void cxl_switch_port_init_ras(struct cxl_port *port)
>> +{
>> +	struct cxl_dport *parent_dport = port->parent_dport;
>> +
>> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
>> +		return;
>> +
>> +	/* May have parent DSP or RP */
>> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev) &&
>> +	    !parent_dport->rch) {
>> +		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
>> +
>> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>> +			cxl_dport_init_ras_reporting(parent_dport, &port->dev);
>> +	}
>> +
>> +	cxl_uport_init_ras_reporting(port, &port->dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_switch_port_init_ras, "CXL");
>> +
>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>> +{
>> +	struct cxl_dport *parent_dport;
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(ep->uport_dev);
>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>> +		cxl_mem_find_port(cxlmd, &parent_dport);
>> +
>> +	if (!parent_dport || !dev_is_pci(parent_dport->dport_dev) || parent_dport->rch) {
>> +		dev_err(&ep->dev, "CXL port topology not found\n");
>> +		return;
>> +	}
>> +
>> +	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>> +
>>   static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>   {
>>   	void __iomem *addr;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 259ed4b676e1..b7654d40dc9e 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -599,6 +599,7 @@ struct cxl_dax_region {
>>    * @parent_dport: dport that points to this port in the parent
>>    * @decoder_ida: allocator for decoder ids
>>    * @reg_map: component and ras register mapping parameters
>> + * @uport_regs: mapped component registers
>>    * @nr_dports: number of entries in @dports
>>    * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>    * @commit_end: cursor to track highest committed decoder for commit ordering
>> @@ -620,6 +621,7 @@ struct cxl_port {
>>   	struct cxl_dport *parent_dport;
>>   	struct ida decoder_ida;
>>   	struct cxl_register_map reg_map;
>> +	struct cxl_component_regs uport_regs;
>>   	int nr_dports;
>>   	int hdm_end;
>>   	int commit_end;
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 0c8b6ee7b6de..3882a089ae77 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -82,7 +82,6 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>   #else
>>   static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>>   
>> @@ -91,9 +90,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   {
>>   	return PCI_ERS_RESULT_NONE;
>>   }
>> -
>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>> -						struct device *host) { }
>>   #endif
>>   
>>   #endif /* __CXL_PCI_H__ */
> I think this change broke cxl_test:
>
>    CC [M]  test/mem.o
> test/mock.c: In function ‘__wrap_cxl_dport_init_ras_reporting’:
> test/mock.c:266:17: error: implicit declaration of function ‘cxl_dport_init_ras_reporting’ [-Wimplicit-function-declaration]
>    266 |                 cxl_dport_init_ras_reporting(dport, host);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 6e6777b7bafb..f7dc0ba8905d 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -7,6 +7,7 @@
>>   
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>> +#include "core/core.h"
>>   
>>   /**
>>    * DOC: cxl mem
>> @@ -166,7 +167,8 @@ static int cxl_mem_probe(struct device *dev)
>>   	else
>>   		endpoint_parent = &parent_port->dev;
>>   
>> -	cxl_dport_init_ras_reporting(dport, dev);
>> +	if (dport->rch)
>> +		cxl_dport_init_ras_reporting(dport, dev);
>>   
>>   	scoped_guard(device, endpoint_parent) {
>>   		if (!endpoint_parent->driver) {
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 51c8f2f84717..2d12890b66fe 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -6,6 +6,7 @@
>>   
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>> +#include "core/core.h"
>>   
>>   /**
>>    * DOC: cxl port
>> @@ -65,6 +66,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>   	/* Cache the data early to ensure is_visible() works */
>>   	read_cdat_data(port);
>>   
>> +	cxl_switch_port_init_ras(port);
> This is probably not the right place to do it because you have no dports yet with the new delayed dport setup. I would init the uport when the register gets probed in __devm_cxl_add_dport(), and init the dport on per dport basis as they are discovered. So maybe in cxl_port_add_dport(). This is where the old dport stuff in the switch probe got moved to.
>
>> +
>>   	return 0;
>>   }
>>   
>> @@ -86,6 +89,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>   	if (rc)
>>   		return rc;
>>   
>> +	cxl_endpoint_port_init_ras(port);
>> +
>>   	/*
>>   	 * Now that all endpoint decoders are successfully enumerated, try to
>>   	 * assemble regions from committed decoders

