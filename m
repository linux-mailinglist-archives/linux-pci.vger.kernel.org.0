Return-Path: <linux-pci+bounces-15631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78D99B6797
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33403B248A8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B22139A8;
	Wed, 30 Oct 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GWyyl2Dh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4421314A;
	Wed, 30 Oct 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301356; cv=fail; b=LNCcldaFVMs2GhChm3EL4Yno/nGPbPUFcJ7dpoqPzFJUsRpzsxr1Z01uhQbmzQrcZzS2kgahXsZ0mE2UXTjN+0EmAtvyT0AAGqBlrXBK4L1b8NNQsPLrfAV1f4gppPAqbGaOdHEU8lr9YzOycML3X2FqPnIzH06IvTn6E6G2+rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301356; c=relaxed/simple;
	bh=P+WIbD8zBxhWSUWgt4yFRFebNQnsjRRd+36IeDXVrl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YI6BYIGJJy1KWdLmBNIOdheVcA0MpsoLsrOflP0GjksGiibAgaKaEbb/SmoOJNpUyk9HP46kMgls2ihxAx8SqADJKe3Ak/+OllxTxvmbMjzPt6FJyLeJxflOCNZKMD39JBpoPwaybG5zQBReHGnGJui1YhqApTXsWrySf+zWKJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GWyyl2Dh; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIbbiNxwKUjkbqJOes1LYuxStpb/Shx2Af6jtJu0Yo1zXC/UH0cL5hvou2/ZILRo7yCJ3LJyWPNKl0++UYA0EUh7npLB5iHY1e1XlZ2Ja4nRjFkKrl49ADzG31K9IJJvzspguxj+6q+3VEZsoWPVj5BXmS3y0P1BagnkNMWJ7mu6kZu4SI2Tf5oP2qNqtB6E9+yRSkuXgafCYfPeQ/rkB/ua+LyEYqHtZ7m2o3A8MrKOVWoYXb+fyablUzkhC84NblD8o63DOJ+FilZqDf6bLRnhDqLPRPZmN2cRx4sYSjvKkul0C7nJGeZOG3qNukAHwc8rFC4ENl5qSoOaSB1vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+WIbD8zBxhWSUWgt4yFRFebNQnsjRRd+36IeDXVrl0=;
 b=Z6va6JH0fAB/3JC/HO0HTD/OJ7yoWs1D3DgCNIv7m9CGRsSwrG+HbZrb9yfvVAEVKaLyT6aGa3tP4yxftCfDV9LyXhC3bg682jsVG4LS9BiWfLyYskfH1h3UKBcYoSOnShwdoqDt2GbkMBlaNdBjkHg2gWU0pCHu++YI7RPI+j5mtssI6LjAeWpyAGCPlfehuZs4trIkzpGq6pKBwUZaqfgvoHsHqHBXZVCE74ISfWRC9JKoO7SYB4/t7hHPQCngaprodcMfFmyTkxCmWnXdBE338NMhhOvm4/VsqLAli2t3Q6CcCX/YVC2aoCAD+Ngj/Aea+gafXkFb2n0Vy1Bz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+WIbD8zBxhWSUWgt4yFRFebNQnsjRRd+36IeDXVrl0=;
 b=GWyyl2DhV5AldwOd2HUdOGA+t3WySjspAVn6zm6UIaUvh4MzIhck/o1oZbA7ZqsVOOVHam6/hCAoW0rBrVE29lwV0tlsqcCloHShQrQX6qzQcAwAx8HLOWTpV5AUXws1JY1qcg4fXxOtBt5205gK7eLsGQ1RRlCkOM+rjSJjuYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Wed, 30 Oct
 2024 15:15:51 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 15:15:51 +0000
Message-ID: <c415e871-4c12-4974-a818-97287d3d8188@amd.com>
Date: Wed, 30 Oct 2024 10:15:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] PCI/AER: Introduce 'struct cxl_err_handlers' and
 add to 'struct pci_driver'
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-2-terry.bowman@amd.com>
 <20241030151407.0000227c@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241030151407.0000227c@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:806:23::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3393f1-3e47-459d-2a0f-08dcf8f5bdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2sraGhzbytWQm0xUXMxLzRpYkdKZGtiNTFhMmRkV2Y3Ymk0YVJIM0FMUmVS?=
 =?utf-8?B?cTJPWGdmWFpZQ0RSeGJZWmVzN0F1Smtlbm1BZkxRMDBHRkJITFc4Vi9EbnM0?=
 =?utf-8?B?VHFCSFhSbkppaGpMNzB1YUt0VnZmR2NEOHMxODRUQ3J0VEMwS3Q3VGVFMVFQ?=
 =?utf-8?B?Rk5POGYvTXlYMlpieHU1U3JodzZtUXUvSGRPR0ZYUXFBaHNTWi91dGVEc1RJ?=
 =?utf-8?B?VlBBcXF4Ny9WekVkbHo3dWxXdktjTnAxY2trblJmQmVuWHNYbGhkMExtWkJI?=
 =?utf-8?B?OERmUUtERWE2MTIzb0lnVDJHS0V0dWsxZDNhTjZ4Vm5DT0xXdFlacFRsY1kr?=
 =?utf-8?B?MzBpZkpiZnlGbk81bnlhQXBlMGNpUW9jeDF5aHBSU1ludWVCQzFXTTZQZXVX?=
 =?utf-8?B?a3RoV3NDVTRIcHlSR2ZqenZScEh2RnJLV0hSbWQweW9XcXhHeTZnYkdtZGFQ?=
 =?utf-8?B?WVgxVjdkUm9oSnRqcnlETCtFclNmc1o3b0QxaEgvdC9nL2g0Y1RGM3JHMllH?=
 =?utf-8?B?RFFoMDk2dXcyQXpSUnppcnVlOUNmSWZGVUc0cGx6TzlEOHBYdXhnZkxkTURU?=
 =?utf-8?B?MXR0STJTeUl1V2lDUi80TEYrUmxSL3luV0xoTUttSzhlV1dJT1pQZGpZMGo5?=
 =?utf-8?B?b1J0SWxqWjlpK3daYXV6MzV1RVVLYkVzVEhNdEN5Z0ZQYVRHb2hzT0w3SHgv?=
 =?utf-8?B?L1BxRlZmNkdQL1M0R01qMnl2aXJLNkhpREgxOFZ3NUUxQWxGV05KbUJ1V2lr?=
 =?utf-8?B?YmkzWG1vdzVBOVF5TFphVUtoMkhiTHJFS3Z4WGEwdFV6eEE4ZWJUSDR3SVYw?=
 =?utf-8?B?cm9qNnE2MUNTMG5sZzIwUEEydGVrQnFvbGR5d0tCeE9yeVRlNlpTSmV2K3V3?=
 =?utf-8?B?aFFlRWpiYTl2dVRQZEpLdDdVeE92UHNlcmN6eExwTCtFQUZOU0FQNUwxcXRr?=
 =?utf-8?B?QUhxdGpoZlpTdEU2RDFER1FNZG5qRCtzeFBlVTVSUFRmbC9FUGFIM2cvWERi?=
 =?utf-8?B?b1YxNG5GRVFkSjlCKzl1V1pJdDdlcUVPZDRjN1lROHNMa3JDL1h5VFdaUGx1?=
 =?utf-8?B?SDVWWFZaZlVFL2V1ZjgxMm0wMHVIZEJDSmdWbU91cWQyOEpzZEhrb3AzODRP?=
 =?utf-8?B?TDk1eUhDd0Q2NWNDZHZnUEI2YlNqT1V4QlYrYnRkM3JFSTR1YTgvVnVQcSt5?=
 =?utf-8?B?b3ZYMlk0Q2xHVXYzQWNuc1ByRTVodWpuR2FPd2c2V3p4b1E5M1JjRXFBNDJO?=
 =?utf-8?B?SnhwYytnQW0xdTh1eVdmNXV5c2JSbXI5b0FML2RmMk50MEEwZDVxZ1loNkxZ?=
 =?utf-8?B?cTdIOG1KVXg0TEtGamNwNDlTVDdZV2tCYW9yaTY4RHM1UVl0UE9tWWJUWTFw?=
 =?utf-8?B?VnNJVmIvYXdWMkhuVTduZzEzOStsZnhXYjZnajZxdEdzZGRrd0RKcUF2a1g5?=
 =?utf-8?B?bzM1dW41TzZnMit2NFIrdG1Jc0g0aC9nZzJZbGRTcWlDbnAvdXIrZ2kvQVpR?=
 =?utf-8?B?Mms1b0RkV2V4MVZBUkhmOFRCTDBxcUdhWjJCUVFqSm1xVzgrcmQ2SDdaZWNv?=
 =?utf-8?B?UUtRWXJEamk3NkFaSkhBMmZRWTExN2FMODlOaFRick1uL3lIRWtDNWFzYlVT?=
 =?utf-8?B?NUZnc05xTnEzUlcrWHczblRHVDU3cnRLZ0g2TGVxdjNPNmN6dHR3ZEUvT0tC?=
 =?utf-8?B?azZXL2liV3Q0SnFJUEV5YWFvSy92M0N0WjhVVUZxU3REZDJhQ2c0eW1Da09r?=
 =?utf-8?Q?hOcZOUPhy04cHBkeug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFdXV1JUbXdRWUdoaGRsZ2t3aTF6a1JXTFlJR25aWEdQS1VsQUJlTjcwemVj?=
 =?utf-8?B?VTNCYjVJZGZVeXdFbEpRbndTeHlKSzg2Zk1RMFQvMkVraUNCSlFYMllIMTJE?=
 =?utf-8?B?MVo2VEhscFg3dHJWeGM4MWJDUFM2ait0Nms3MHoza2I0Zjd0YmJIRWhuMHB5?=
 =?utf-8?B?QnB6SHJudklheGtlZkplN2xraGpGU0JpTzN5c24zRzJidm9OSHBvY2ZlWC9J?=
 =?utf-8?B?ak5wdURYNUJSY1ZHVFBZSXpIampUTHVncUNPbkozUmZra3hFWVlSUlU3YlNl?=
 =?utf-8?B?NEcwVGRwWTlPY1RtOTdLRExmVE5ZQ2xGZXpnMzB0azcxM3ZmenlEV0ZsWndM?=
 =?utf-8?B?bzI0M0lUUFJ0cU1rUjhpa1gzV1FMa1dZNGVVZGQxN1huZU1pK081aUIxUlow?=
 =?utf-8?B?T2VnL09pUGdiZFBwZUJHOWFIYldnOFhNbFJKMTJIMnV0c3NGdnRnVjg0dXo4?=
 =?utf-8?B?M3VNaDVuUktyYTVQa0hRazBJY2tuLy9oRHVHVEVqcUg4eThnaExqcDRWN0FT?=
 =?utf-8?B?UFFKVVB1K0VaVEpabWpFd2dCTTRaQzZ1T3oydzFiN0pSL2ZGdWR4ZXIxRXBu?=
 =?utf-8?B?SmFUNHliSUd2WUJST25jRXE4cGxSb2U5bks0Q2ZqVVFsSENIeWZWU3dIblMw?=
 =?utf-8?B?UXgzYWZxKzJsRG1rcUxLWG4wWHBReFBwanNrY1doSHBNZVlpaU9TbjhGMHd4?=
 =?utf-8?B?Y3NVQ2wrRVpRVENJaUdJMU0zTmM1cytNbFNTZUV6c2lwa09QQng5TGh6SVg3?=
 =?utf-8?B?NTNyNzgxOG1kYXN2dGEybjhuYmJaZXVIN3hxNkk4VStVVExaSjlNNS9ud0V2?=
 =?utf-8?B?blpuZ1dIdEZLZTRFYjlqVUxWbXF3S0ViTXcwQlVHWXRaZGtWdUxTbnB5YVdU?=
 =?utf-8?B?Mjh3Qmt4T2MybGEwMGZDL3NKSTFVUFVFSkFiUjFxK3hmUFV5cWxzWm1aMEhC?=
 =?utf-8?B?VkM3ZHVrR1R6eldLZmVOMS92ZkRBRXhCakpORHBOWFo2MU5XcFgzZXVSMjNZ?=
 =?utf-8?B?OEpjSUx3bGFvbVNyS2hOc2sxdWtNTFc0NjJvRGJWTjFwUFZuditWSEM4K1Bz?=
 =?utf-8?B?S0MrUjVzM1RJKzQ2UmNML3Z2RG5wTTZRUDkvVkV6K1Z4dHQyZDJvbjQxVkhJ?=
 =?utf-8?B?YVpPSlpJWGR5QStuMWZ4VEoybkZLcnlDN3Ryck43eHN4SHVzR2xVaWZwMkNU?=
 =?utf-8?B?eDcvcDd6U2Yvd083UEtTRzdHdnFPU3FrUFZEYTFiWGRBbHQrS3Y1bGlUY0g0?=
 =?utf-8?B?NG9aN0Z0ZC9mMlZtbWJlTzVjV1F6NlhrajVRRnlPYU9IUjdzb1B0dnFsS1N1?=
 =?utf-8?B?Q1Rya1hZUTlXaTBXblIvSjNRS2R5Sk01RWJSMVA2RzBzbzVmQm1PNk93QXhu?=
 =?utf-8?B?Q015Nmp5MVFNTGVwemVSZ2E4M0JBRHc2ZmZCSUcrbHZnbmc2OWJaTnIwQWZS?=
 =?utf-8?B?dkNWL1NBRUhuMHIvREQrdVFuejZTTjU2ajArZk96dk1Xb3RXL0RzZTJ4Rzlz?=
 =?utf-8?B?QnR3SlV5ZXVwZi9CaGcreHEvRENmWEx3dEZTL0M1TWMra2hBTENWUUlaNjQv?=
 =?utf-8?B?ay92c2tuOU84cWdRRHQvTzM3Y2cralgxWXgrUW84WmFLM3F1VytjTEg3V2h4?=
 =?utf-8?B?S0FaWHBwQmNZc2Y5WExiMEVOVmFNdDY4YU5mOUtLcS9yN0JMMHUwQ0ZZT0Vx?=
 =?utf-8?B?SUFGNC9yc09NNUd5aEs1TG41aEFqejFXZ0lyMHp5cjF2N2JiTFhTMElxb2lw?=
 =?utf-8?B?VHJVK2I1dk5NWVhERWdlYmExWG02QmlWU1hzOUM3alVQY0pqOXJHMEo0Mm0y?=
 =?utf-8?B?QlRHNEx4Skg5ZVRjQ1AyeXphbkRKanZrRGc3OERFZks5Ky9PRTl2UTZYN3E5?=
 =?utf-8?B?UUx5MU81dm5hV2oydDhidXlVdVBxMDQ2a3l3U0ZkQUlQR2tWRFlWZ2l6MzlE?=
 =?utf-8?B?S2hEZzVEdjJLTTRDYXhoZXRYWlVJRVBlYU1SaFJxSWlteGFuMXh4TzRSeGtO?=
 =?utf-8?B?RHBaWlBCZ2JRblBqK2kxZmZ2eHg2OFYvMzBuYzk0bThrMXlEUmNHYzBKTGs0?=
 =?utf-8?B?RUVGb3IyOWdKVCsrUjNLMnBhbXAxZHN5akt0TXBqTTNvQVAvT25NWkZvU3lo?=
 =?utf-8?Q?jNVE90ltQd8U+HNGsfG7O2tFK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3393f1-3e47-459d-2a0f-08dcf8f5bdd5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:15:51.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wacl3CQiKHnFny3zNmLNli8+KAXOJQVq2ulbiG4Z/C0jsfNoSncynlWVREQFfcAnG4EHpwM5GMQ7lO3dk95/NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538

Hi Jonathan,

Thank you for reviewing.

Regards,
Terry

On 10/30/2024 10:14 AM, Jonathan Cameron wrote:
> On Fri, 25 Oct 2024 16:02:52 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> CXL.io provides PCIe like protocol error implementation, but CXL.io and
>> PCIe have different handling requirements.
>>
>> The PCIe AER service driver may attempt recovering PCIe devices with
>> uncorrectable errors while recovery is not used for CXL.io. Recovery is not
>> used in the CXL.io recovery because of the potential for corruption on
>> what can be system memory.
>>
>> Create pci_driver::cxl_err_handlers similar to pci_driver::error_handler.
>> Create handlers for correctable and uncorrectable CXL.io error
>> handling.
>>
>> The CXL error handlers will be used in future patches adding CXL PCIe
>> port protocol error handling.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


