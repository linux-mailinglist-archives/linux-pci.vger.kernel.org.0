Return-Path: <linux-pci+bounces-34866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF454B37933
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 06:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58887365175
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 04:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A02D0C7B;
	Wed, 27 Aug 2025 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xW2Dkme0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635F2C0F9C
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269911; cv=fail; b=Kbitqp3CXrYvLBxwCLiWxIyeMFyl45osj5cckPbRUALtWAOa/ueV/3CVz8NYKScEc81UKh7isni1d22fjb/DPjr6EQJX3jgeSdadBhyCYKSVSkdg0A4LCjo9z1TuP54u//ixysS9/pWcGSTiavUTvpzLP4YTmf+o3XXurxnKK9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269911; c=relaxed/simple;
	bh=gd9pvKuHojJgkK3Kav/5ah+taDLhiniGvp3/355ltWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XQSCrvvgi9QpTDokQz9Yj5d4yvWwBpBqli39ih4MPJ8PBBnLmEEmDAe+Z/OMCgTYNEU2915h4CjZviPop3icc7bbTPhuWXDS0K0oGJQkFFAdAUJTLDDc0N9Ch7iHlymQH0OLQuVWRkx7vywaW0yccsjA7AesEfH8JEUneFTipT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xW2Dkme0; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyF4W+zYj2Fv1RbAjngigAapgSBND9WSEioJuSlNC0d8+kMqyms1SulWqCTFNccdQiGMfUiCu4vMJbjRVe1zMaWNPNDaG179fKSHKIGodASp+sVHq2TWGblIbWBiC08jfEJR/XmZZlMQLY8efPUf4JHKNjP6+DEczGt/9la8uQeUA47K2SOyWgFItV3NpCPlnnYduB99ePwTirHZASl6+DQEGpxqrwJYXlA1u17traeryPCAEgzcUd46wqxIv092Hwov837KV/CA8V6UK+V5ooInoT0otbvVEzpZ5MKmBJ9BJNtnAhbLW5JLpxxII7ZTDJDUb/OcaZz04SHqdIuYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtWG/sBMLpEoC4uhSTgEjscQzh4J2MD5fHd47DzfJpQ=;
 b=QJEWBP9s/n+YdL60OSgKmm8Hfz/PoZyMbIho9qzChQDI9BYk1CSOvp1BNm5iPB31qys0j94ceDXt7p+m4YQ7P3wnhSmG29VPcexnkl6qKyN5/LkI2sftOLLiU2AFDedR5WiZiquJnbTCV1syxByf+7PVQRntZHi0iX/55OdeiQzS82HrneME0FO31dtqUJrD0mgQtN2/kosY1hYS9JydDGvd0tbHAfmZnOw46mfHzV0NF8hQt/aD6IsGIy1Qbuw89F71yF0h5boudk2o1FtgKopXUIJKN7KMM1XyTSfqMJU0U3QRreOPzHg6wrE8+uMQtPpVno7qM25wtssKGyEUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtWG/sBMLpEoC4uhSTgEjscQzh4J2MD5fHd47DzfJpQ=;
 b=xW2Dkme0zzmoHq5pNoRKix8yiJDKWtJvfrmDBgHgTSb2yZH/8oKT/yUywArYibh3oZfWQ9Q1ovF5Fgg9FSDt/PzbzfaxP1Rn27uMulrLy0vf0VFBdAJVmhaMV5uBBwedQUHQuS+cvHz7LpV1kbjiVO5iSYl/fiomSVNgYcvxWOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 04:45:06 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Wed, 27 Aug 2025
 04:45:05 +0000
Message-ID: <e35667f8-f1bf-4cd4-bb2c-b854c8f59d0e@amd.com>
Date: Wed, 27 Aug 2025 14:44:59 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <849c12a9-f801-46f8-8fff-09fbc259843e@amd.com>
 <68ae491e1348a_75db10072@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68ae491e1348a_75db10072@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0102.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f592f03-ea8a-42c5-ebd8-08dde5247e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFNTdmplNDV2Z0xWVTZMMjE1Q0E4eCsrdFFROVBKSko0OGVxT2NjTnlDTGxL?=
 =?utf-8?B?WUdwb25rb2xiT2RsRjBNWUtQTi9vVUVEd01XSVZrNGlvcEdYYWh3UG5HQXQ0?=
 =?utf-8?B?bU1VRm1CbkZwQm5qZHlhS1lPNHp5S1BJSDQrTGhaT1RTUTRLSzY1VVU4bjVL?=
 =?utf-8?B?UnBmREtOVHFNR1JicTFGbEpSQm5UZ3NoS2tBdUlxbmtOQTdjSGRBSnlEcUJx?=
 =?utf-8?B?TDd1QmZwVWZpbGxMRFZTTzJZcmdBQUh1YzlLdUhuWjJVOFFsWXlaeFRUSGlQ?=
 =?utf-8?B?TWZRbTA4T0JpRU9Wd1hBVk1sNFhpZlNGQTVFTWludDR1bFFoSGRPc2FLN3FI?=
 =?utf-8?B?aTczRGZLQUkxeHVHeTRpVUJVcEVvYlAxb1k5cldSdGxPTktnREMzd1drZjRl?=
 =?utf-8?B?RGRINXlvMFIyY0NDRjRzTzdhREtkcG40VzBsT0Ivb1V0Ty84blIxL2tNV1ZJ?=
 =?utf-8?B?NXlSQzhxYjVtM0x1dzJpM3h6V2p3WkpxMFFvVHd0OXNZMDFLaUV5UFIrVmsr?=
 =?utf-8?B?QXJ2MW8yZC93VjF0RDFJUUg2cEFac1FBNlJNZTBMRHFlczNhNE5LYXZXcnpV?=
 =?utf-8?B?MTc2Qjd5cnBsZk5wcWZISDRqRk8zN24xMHpZNlBLWkR4NEF0QlZJSXRuRFZq?=
 =?utf-8?B?Y3c2eG42Q1A5eTdIeGx3K1dZRVhuejhxQk5PL3VIbTk0SDUrUXNqQ0VITFVR?=
 =?utf-8?B?RkRaakIzeFptRlFQYlFkSi92dFZMclNhRGY1ME44RGk4d1ByTFJYcndTN0Nq?=
 =?utf-8?B?bUVnb1BtSm9rUCs3WFo3ZlY1d0lUc2Y5WDhHQkVOaC9VaklSeW4wUVhQUExy?=
 =?utf-8?B?bGk2U2MvOWZGbmRjZEMxTmlQTjZnNkxQS0xyQjk2eTJLd2drb3VlWE91cjhL?=
 =?utf-8?B?VEZEMzg1Q09hckVyUnJIZWxwZEhmZFhYVlpVRnhRY3JBRmJ0c3BPWkg5cnFH?=
 =?utf-8?B?Tnl5bXVpeUVrbnB4YXVCUEN1ZnpLNE82MVhUVFZ3SDBTN2gydTRGSzh5NDNH?=
 =?utf-8?B?clRhd2x4TU8rWlpROUhoQnExQlZRVmNsQ3RiZjhBN3BaUnk1YzZWVVlTcTJC?=
 =?utf-8?B?ZFFvZ0lrVTllc1ZCdDcvWWp5ZXMrQ1lkdEVRcXptZEM4RzFFZEs2aU9uUXdm?=
 =?utf-8?B?UC82RGFFdUFwclMyV3RvbHZqMXFPVS9MUkMzZHFZL2w1cEJXcUI0QWpKb0Y3?=
 =?utf-8?B?KzZUWGcxS0p4WXJRUGlHNGZ5azFUWHMxVHlZbGh0bDFpdmg4bXlaRVkwRUFz?=
 =?utf-8?B?R3pheG1XNlJzbmhFOE5XT3JKdzNkbWhKaU9kQUN1SWhsS1g3NTFBNE5xTGU3?=
 =?utf-8?B?SmV6STlXWmYydEN0MnJxd3pCSW5JNEVyMGI3MUpMdlkrVE5ON1hPbTBoVS9O?=
 =?utf-8?B?a3RnckNMMnljWlpyNjh2cThXaWNCRjRuODNaZ201TzBOT0VsS0JQN3Y2RnEy?=
 =?utf-8?B?RmllYjNkREIyUlVIUGM3RkhremlPN0hBbExZc2gweUxpUmc5RE5hckgvbktr?=
 =?utf-8?B?M1VjenpkREdnMVZwSklKbW9YVkxtTzRyaTNZSlkyN2JrVzJIZ0QrRTdINlE0?=
 =?utf-8?B?V2Qrb09tQm5oWnpleDBQUkZjUCsxZFBpZ01weC94TWlXSlNxbGZmdC8wTXQv?=
 =?utf-8?B?N3RaeGZWSlhwVHZpaElxRmZSd3pFU2VEUzZDSWNld3B0K1A0ajFsL2QvRTFR?=
 =?utf-8?B?RCtNNFNYV1duN2xvRHZlK1RRcWpVRkx6M3RIVUFvd0hSVGtvTDNYb3hrc1ZR?=
 =?utf-8?B?eEdmUFRBb0NwOUpuQUlOakZyUkVEdDBOTGgrSXdLOTRIMnB4cjNHaC8rSkRS?=
 =?utf-8?B?U3MxL0hXVWZzVDNoZXM0Y2dZTDlianZrWkw3NktpbjlObTAyZGwzRHJlN2pm?=
 =?utf-8?B?UUVIYlNMTUJjUkR3L0hoWlBYNFhRYmxXdnRUbE9FRGo1amdKcVZMbUVleWNk?=
 =?utf-8?Q?OF0dk00/oeo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akVVcEtlRjRUYUhZMXRITC9VMWFjRlBKTVlyN2Qrb2R2MW83Y3UzNzl5WFN6?=
 =?utf-8?B?U29iQ3N4SzgwbGlKcm5EMHd6Q3Rzc0N3NWhyWlFDM0JWMjI2UWhuaExhSFRO?=
 =?utf-8?B?R2hBZXY1ZlI3WFVqWURyTDI5MDJsWWxTQVlvVk1hNGRJd1ZXZzl4Y0F4dEVy?=
 =?utf-8?B?SllwdkVRMzkwanZjZzNqYjI3eVJRbk1uMENUUjhBRnkvSUJFNHczWGNSYmJ5?=
 =?utf-8?B?aEE0ZUI4bTErTFBxRHpyTDZVajNNNUd4TEVqRmZ5bFVzSTJpSmFhakJNb1Br?=
 =?utf-8?B?QVBUR0VGVDJYKzFHMHJJKzNRMlZsV1FrNnk5cDdkM29vNjl3UEFrMWk0cDJh?=
 =?utf-8?B?Tm1wWmFERWs3YzIvVjFua0dqUE4xL1NkSm9XTUtXVFg0eXBBcm50YVBQZG9C?=
 =?utf-8?B?WVZvMytvcFMyLzdMTkpxc1FnM0l4eGFBMmNteStxcHhSdlVpeURCc1NhNHFx?=
 =?utf-8?B?ZFJIS2FrcXJyTFkrSVFXdW9mRXRPY2s2bCt1ZTA2OE9YRWxVTmNvdjRRdW1D?=
 =?utf-8?B?RXhjRjErRUVsYjZMVnpQaFlFUTlwREp4ZFJtRXhZa2grNjNPMjUrSzFzN2Zq?=
 =?utf-8?B?NGhzS0l1cTBxU1RQc1NOclNmbHljRHJ2SmRaTTdYclQ3a1VaakQzeHN4Yk1S?=
 =?utf-8?B?dTlsd2g1THpTaklQb0QxZVFOQzhoS1RMeDV0V3JMM3RndWIyTjZWaHZEWVNI?=
 =?utf-8?B?VUxYeVllM3VqakFrOWl4MW9oWWUvRjRNa292bEdMTWRBZnVPOHVBYmw3ellk?=
 =?utf-8?B?dE1rSWpuR21lck5kYWs0Z0wzZDZmZjlnaGNLbGEwOGcxUk5vTjdkREJjWkVB?=
 =?utf-8?B?amMwc1ByTDRMaW4wbVRKZWh6ZXdxL0pRUGpSZjRvQ3o3MC91dmdVTFNrOUhm?=
 =?utf-8?B?RDhnRzlCb0hyVUlTbE0venM2cHFFbFFLSW0wQ0lLcjVhc2M5WmFCdTRXcWpI?=
 =?utf-8?B?LzdqV3JnQkExTUVqbHpJaGtHSXF1SWlUM1hQUVBXeHRMNzJ2L2FkQ1I1cDdn?=
 =?utf-8?B?VTQ2THgrbXVRN00rZTBwUnB6RWtxZEZHSGNsMGNJN0FRWE83eEV1bWRqVndU?=
 =?utf-8?B?aysyUjc5azFTWjN0bkZ5ZUE2V0pCTFBsQlI3aHR3OFBpdVdnSVZLdThqbHI3?=
 =?utf-8?B?UUtZTnRFMUJ1OXRYa29yUmV3eitGQVU3SWZMSktaTTJ2ZWptT0xmVEp2MUMz?=
 =?utf-8?B?bE5YZmtGYmgrcmFNYTVhdDNjWmZpaEpBdWNwTkwrN2ZobzZTdUVtQVc2NXV4?=
 =?utf-8?B?MjJLZjlVUVJKUkhiME9OZVpTeFpWZllYVmFVSTV5amdCS1FkUDFsTEJjUVpi?=
 =?utf-8?B?VmNmMmVvVm1sYU82Z0VQWlJZSXpJM1ozZ2ZlaFllaXNCcmJ5OGlaQ010R3E2?=
 =?utf-8?B?UUxiN3RvQnNoT043VWl4TzgySWR0SVh3cGk3N1BKM2Q1WEViOExtVlJiWVZy?=
 =?utf-8?B?RVdlU2x5cDFBWHM3MU5EMVJuZU5rK0Z0NzNWc1BCM2RTWjUvRVVsSE9lai9M?=
 =?utf-8?B?VlNCVC9WU0p1dFlLcmxoTVBsbUtpS0ZVZDJTUVZ6ek4xTnVNZ3J0aUdxTGpr?=
 =?utf-8?B?bC9kNE5wWTJCQ2pBYkloY1poVjdEUzFVZEw5cGplL3o4OVFsblQ5eUZWV1pC?=
 =?utf-8?B?NGNNdktRMHpxalFDZkpER0l0OC9SdHUvN285L2JpcVQ3bDZUdlY2S0VRQUgr?=
 =?utf-8?B?ZjVFNG1Fb3FSejFSVm9sSXFKMVdxUU4vUU5FSjdOMi9CMHg4SEFyZDMrM2xI?=
 =?utf-8?B?Nmh2d0ZGa2ZpYXU1cHBXVkMwSS9FdXV6Nm1YY3NrNnM0NGlIMzZJQW5KMGdu?=
 =?utf-8?B?Vm9XVXlNSk5oLzlEaTBZWjh2b0FMbzZYUEE0dlVhRlRWeGcxc1Q3djVFTXIw?=
 =?utf-8?B?ZXpnMEpQZUlMcEhsMW9Xb3NJaVhxeSt6VzQ3QjFZbnU0NlJlcWFrR25SeGpW?=
 =?utf-8?B?NUp4TzhaRkVia0d6UExnczJRdHRQVzRoMldFTzJQNFV1b3N4eGdRbWZaWTVC?=
 =?utf-8?B?dmRWZHdoNFlVRVpmMGREMUVlQWZjYlZ1SFNJUFo5QzFGZ1l1VHZpdElIVW85?=
 =?utf-8?B?eW8xeHNqQnRjOHF3RjREcThCc256SGRzVlpBUmw1cW9FU0h3WktvcEVLcTl4?=
 =?utf-8?Q?wHSq8ILqPJJEGZs9R+fqFHJeK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f592f03-ea8a-42c5-ebd8-08dde5247e35
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:45:05.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpSA4VbhtsEirrun1+BeMT8DLuZozdxcX+sk4nOZKXGprI6Ig5+sJo3qPE55z22qFU8qbdrp1aiNo+l5mDNrnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723



On 27/8/25 09:54, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
> [trim multiple pages of uncommented context, please trim your replies]
> 
>>> +/**
>>> + * pci_tsm_pf0_initialize() - common 'struct pci_tsm_pf0' initialization
>>> + * @pdev: Physical Function 0 PCI device
>>> + * @tsm: context to initialize
>>> + */
>>> +int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
>>
>> Here it is: struct pci_tsm_pf0 *tsm  (it is really a "dsm")
> 
> All of the context returned by the TSM driver is a "tsm" context, the
> only time use "dsm" is in referring to the actual pci_dev that runs the
> SPDM session.

ah ok. Just seems a bit counterintuitive to use a short "tsm" acronym for something else than the actual TSM as defined in the PCI spec and in this case - it is the opposite to the spec's "TSM" - it is a DSM, the other end of trust chain. And if I wanted to reference the actual TSM in the same function - that would be "tsm_dev".⁠⁠⁠⁠⁠ And the actual DSM pci_dev is barely used, it is mostly "struct pci_tsm_pf0".


>> In pci_tsm: struct pci_dev *dsm (alright)
>>
>> May be we need some distinction between PF0's pci_dev and pci_tsm_pf0 but still these are DSMs.
>>
>> In pci_tsm_pf0 it is: struct pci_tsm tsm, imho "base" is less confusing (I keep catching myself thinking it is a pointer to tsm_dev).
> 
> Ok, I can change it to base.
> 
>> "tsm" would be what you call "tsm_dev" which is ok but seeing short "tsm" used as "dsm" or "TSM data for this pci_dev" is confusing.
>>
>> s/pci_tsm/pci_tsm_ctx/ and s/tsm/tsm_ctx/ ? Thanks,
> 
> What is a tsm_ctx? The s/pci_tsm/pci_tsm_ctx/ rename is not adding more
> clarity for me.

TSM-related attributes of a PCI device. Not the best name, true.

> If Aneesh or Yilun also find that rename clarifying I
> will switch. For v5 I will stick with 'struct pci_tsm' as the PCI object
> that wraps TSM driver produced objects.
yeah, if it is just me, then never mind, I'll get used to it.

> The reason I do not think of "pci_tsm" as a "tsm_dev" is because PCI is
> always a consumer of an outside of PCI TSM service provided, PCI does
> not have a TSM concept internal to it.
"struct pci_dev" describes a PCI device, "struct pci_ide" - a PCI IDE stream but "struct pci_tsm" does not describe PCI TSM... Hm. Thanks,



-- 
Alexey


