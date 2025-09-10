Return-Path: <linux-pci+bounces-35828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED91B51D8F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B513517CFE9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C81218AC4;
	Wed, 10 Sep 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WR3NQSHY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A371329F35;
	Wed, 10 Sep 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521468; cv=fail; b=lLSfEV+VTY3kiMc0TXE24lmzdhaFHRMB3xF+Hb9bh4IbpIAuQoKF4KucTBuDo/mwl8pdHQlzoqYCBSyTNCh6SFvIqwK9RIz88ghnuG3tA2N289k+XKJ6gXpeGMPcmfRmiAjosJNcoaJFJUnaaCKnp9SXgfRUDrCxM4sgyvLVNJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521468; c=relaxed/simple;
	bh=KeJx8URFb9XUi/s8lBblvcEyAtVyKJtfOtwXALKg/ac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T8YQlEp1lv9cO1E+xofejM9WzIQtITu6Tsivq+WivaKFxrnx3wd9cyAnQapvUpS8cyxOmU/kuduGfoS8rQ/igeJTLskhP5NlS+s8jVhzZuHl4EJw5Q/0qHIyaQPXJs7stW0+5huK1QHyskFb7MscnIBSuzINDoqeMNzk3ZWhYeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WR3NQSHY; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmGTBQWy1fXO/xw264TP34MrE82MWIJ8AWqWA6oMovTjphJewdrB3ypjX6cqLYOqCtjqnJ4Ybf4EX0JdOEcMYENn/KimaoTigUHrBE1zKfnWnC/gjFS977s3SFqeJFPYruSrCYyL+y8MMox3DuaF4Npj5bZXA01q8ydjZQ8Ee3ACXZ6HC1i+yKHWQ78gP1fj0CObOrSs7M9JcR4mJq9aduRU1daBx4Qb4Un0EziLc7I1E0iVQj7E5pDy0fT6rmiHj/n/BNoA+KyMEmeR6cQQkmHAO7jZONwGpwMGSlo+7ao4mwR5aBywuXbSFvtX28+u72zSta0jrGyrY0USHpu7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkYQY+VgBZ1duCLjiShWedyh/AcYtL9ZiQAY1fqpfzo=;
 b=De5b6axYBjtqBobz4Ouus2cqwB8Mwec/MZh8WHq0EL8t9b0PfY4kIvZeIh7InIbwVQALkaEqfs96iQfxmcQ8+asJZFTXc+rtTmYORijnJ7eK8FMwPbEwK5QcoV+8CkONbydRG0PD2iYQUpwTujHJ6hp8NH5pYdKErN0o2+VYH9ODMcF1JY7dEy+tnNCTACDimHS0X7jVVEc9nQaANIACNu17HXQARHD8PsLTbJrwg3yQ1+z9o8BOeybsLNstdtpJsMjVz57McygFY+vgpYQYWWHsMMOzVv68pGZPgyghOslDnLBlrXZysGnVdZI2hEbm/bgNRuSS3onuICu3vEopKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkYQY+VgBZ1duCLjiShWedyh/AcYtL9ZiQAY1fqpfzo=;
 b=WR3NQSHYk8qlbjSsXN72IMUEMIK9HZnIoGTfBre9aMeIW5hZ15aiNVsjoEJWcddCuFqRHNp74BweT385pFb0Ubk3SUpz+3iiIWTErai9lNBlOdpSl8NnntpjbFpmFw13nn43aIoq0d9imcbPeL4rOg3HRt7j/5M7L0PiTsyQTf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 16:24:24 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:24:23 +0000
Message-ID: <9714dd6a-28c1-4c2a-8558-9f3d7e3f01b0@amd.com>
Date: Wed, 10 Sep 2025 11:24:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/23] PCI/CXL: Introduce pcie_is_cxl()
To: Alejandro Lucero Palau <alucerop@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-9-terry.bowman@amd.com>
 <43c373b4-6ff3-418c-93a0-f679375f117e@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <43c373b4-6ff3-418c-93a0-f679375f117e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0669bd-53db-47ba-4e2f-08ddf08680ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFVrcDVvOXY0aFplMVkyTG52VWhXYXN6Q1FhWk1XODM5UHM3ZWpqQzB4L0dC?=
 =?utf-8?B?cVByMDY5YUpoWWV3aUxiQzZKRUdnR1AwWFpOemJlRnhLUXptRjhVMlFVUzZk?=
 =?utf-8?B?R3F5UXBJcGoyQm1pRjFpa1RsZVVkc1Y3U1EvQmJJMDBKR0RtTnZYdlU5MEV4?=
 =?utf-8?B?OFRldFVta1hqeUFkS3Z3UW1vVU5KNWtzUmVBVmRnRFdYM0dpUVluYW0xdVdR?=
 =?utf-8?B?c09JQ1VkeWtvazNYdk1tcy9BbDZUL1hTOTFmU0M0WWt6aDJaQWgrU1NkWThz?=
 =?utf-8?B?S2FmbmNmMUlrMFhKSlZNUXVtUmZJSEorMUhoZ3dVbXRiaFpoRHdCY3VkV3hj?=
 =?utf-8?B?WlV4amVNTUxudGhyN2FZMm9XbVgrMnB2TGgrMUNvdFVka2o1SjNnUk5PMzIz?=
 =?utf-8?B?b1BYcXR1cHhlQlVPL3FTUm82eU5icUdpZFFZcmsrd2ozOUloWk1zaGJ0K050?=
 =?utf-8?B?TFFWUFI1TVFaYUxkYUEzcktVdnU1TFA3QnBGcHp4SVkwWVRBUE9Mc254VHla?=
 =?utf-8?B?dXVyWGh1NkcwVTlHcEs2Mis4aVJZTUhaNzlDV3NESUdvZ3F3cFFuMmZQS1Ra?=
 =?utf-8?B?cmFqRWoraTlkY3Q0RjlxejNONGFXSXJkUHlJNXJaZnVGOE5WbVB0dFI3Z01z?=
 =?utf-8?B?VkExUklUMGV3amZIZjVjM1RlcXQ5bG5XQWpXbGlra0oyZk1XV0hIdUdYUG16?=
 =?utf-8?B?OG9sS3BVcVFIS1R5andSQm1wa3A2NnBPdWg2TGlqT0k1ckhFVnRBOTZ5TXlY?=
 =?utf-8?B?RFNnVjhjbTh2VkJjYkNodWU1SFg4SVFjYmlkYkZLanhuMUUvNVVORUlJVGlR?=
 =?utf-8?B?WnRBY0dNUkdjZnh5alVRRmJHa01IS1ZUZGV5YzVQREtvOGhvNGR3RkVwV3hp?=
 =?utf-8?B?ajF0M0hWR0dYTGV5ZXlkSVhRb28vZGZZbFZWWUxFUGRSUFMzUHFaSS9oTXdV?=
 =?utf-8?B?NXVHd0tLYkswbzUwMGNBRVN4MUFUZnJ3RitURGUrVDBsbXlWeWRDMEJsb0k1?=
 =?utf-8?B?SEQ0MG9mT3FEby9RUGs4dVM4Y3NWSy9LVTh2ZjVqRGRvWWtpekYzbUVWVGIx?=
 =?utf-8?B?SXkwV0Y5RTNaTEVuYk5VekNGVXdXb2c4SVA5MXhLYnRmdWtHRVJaRkpBektF?=
 =?utf-8?B?WERKWVpFdEg0YXB2MmZuTnVoUlUzdUJJYWFJMTBqK09lSGtrWFpVWk1SSUhK?=
 =?utf-8?B?SlpRUDFrWTFobU1hZmNVN25ub25GYUZZbWEvT1dvWldoeGNKUWt3SEpxS2s2?=
 =?utf-8?B?bUJmUTZtM0U5cHNrVm4rZ3JxMVRlNk5qTExpL2Rkd3lsTGxWRG5OSzNreGtL?=
 =?utf-8?B?VzRTNmZpNXpmdGhuc2JmL0RPRCs1UGpWeWZSbUU2d1JlbmZRZnJlYnp5K2t6?=
 =?utf-8?B?Y2FpRTNqL1hoRmh4RXdXZG92MURibEJ3bmRpb2t0WmE1SUVrbHFjbkh5cjMr?=
 =?utf-8?B?U2pUOUhiU3EzR1M4S0RiVmordTl2a1dFcUJmY1Y3b0tvMnplRG5UZ2x4SDZw?=
 =?utf-8?B?dU10R2d6T21BWENtSTI4eGxEYXpCWWNWTW84b0pPTzZ4UDVlZE5qY0s3V01D?=
 =?utf-8?B?VEVTdVV3c2F6dXh1NzI5VWdJN0paTHVPYmNMOUU5V0RtTjNncTFRUW0rY3FH?=
 =?utf-8?B?RExrcGJEL1huUUlvbStIMXRyZmNsKzFMZmdLellYTVFiWUdoN1BVby9LNVUy?=
 =?utf-8?B?d29makR4c0lmeDRUenhyTldsRG5JRkpJSmZOcGhzY2Q1NkhFTlVEMXA5S1lw?=
 =?utf-8?B?a2x1R2FaYXpVTExVc3ZYTnFoOGw5TGRtOUswWlRzc3FEcUtabzRHNUxxb0Z6?=
 =?utf-8?B?eEZvTzV5TVJGanE2eEVRQWtHWFNOTHl2WXZXdXNFRzV6RXoxUjBzbUtSdzB2?=
 =?utf-8?B?QUFjNmQ3MTdMYmNoaDFzSi9WU0NFWk5GZGFLS0RLU3ZOemNyUW1YQXlpeUJ1?=
 =?utf-8?B?eXgwRU9OMEh2M0ZLYWJ5aTVBdkRja096TWFLMUgvS1hwdDA1alo0ZzFOdWU0?=
 =?utf-8?B?TGt6RHphVSt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGZ5NEgweGZJVENaRklFTWUzZTg4d1BNclpsUndqd3dKOE9rYmlFelpCaU1h?=
 =?utf-8?B?b283eS85UXAxOXkzL0Z2TVBidmxMSVVQMWN3c05ibVZhd3czSG9OKzhxd2I0?=
 =?utf-8?B?QnQ0K2twZWRnZHhvQStDRTFzMVdQUUJaQnZoT2xEV0NVd3NIQVdGMCsrazRo?=
 =?utf-8?B?N0hVUVdya1R0S0xSNkJsN3NaMnB6U3BieFZXZ0k1elk5bVJaeFg3TzVtOGkx?=
 =?utf-8?B?S0dHUVZkY1JMVzduT0ZscnJNRUU3MW9BcXV6OWFQUTYxMHNyVDl1Q2RGTG1n?=
 =?utf-8?B?WEJEZXh6YzBzRk53YnBhaGg4dkxFdzMySXMrL0laODREWGw1T014dUZrQW5S?=
 =?utf-8?B?MWZ6UmZKSmF5aWVBTzI1L29hc0cvWDRDeVlNMzZySGlWd3ZUaHFXWjRVNDEr?=
 =?utf-8?B?RnNCTk9waWdlQWZiMGlrRHpjaFNQNGpNekdCR3FvZFJjcWhRMjhiSVREd3pt?=
 =?utf-8?B?bUhOK29iWTBhNlBOUTIzSU9VbEtjcS9FUU9kS2JGeGRVeW1YVklnQ2pNeVA3?=
 =?utf-8?B?OWY1a05OOG9sdzg4SURCWXAzd1Z0UldtS1pVNFhDZW1CUWZlazgycEg1VDNH?=
 =?utf-8?B?bEs4UzE4NlR4QmViNnA5MFRocjRVcXdzRFJKQ04xdnVxSkdLRmxWVlNFYzNx?=
 =?utf-8?B?TTJIaFhZMGFVMDZuaGg3eEJwVEpFWjliWnhVWXllTms1Rkc3aFU1L0l6ZHdJ?=
 =?utf-8?B?MmF6UnFpVlNkUzJYWnYwTVRIeHJYbkhGZmhPQ3FTNGZwMnowYjlPcnlqNGhB?=
 =?utf-8?B?RWNOWjBPcE9rVVdGaXJHdkhhVFkyQzRKdit6MDN6YTBFd1FjTjNNYks3OGNv?=
 =?utf-8?B?SjVoL29nRVlheUREbHBZdGgwOE0rWlFlQ3dNcXpLMFo0TXZ3d0FKN0xxMVFp?=
 =?utf-8?B?Ujg1WDg0dGNTa0w5UnVaWU1qQUFsY3BwNFlCdXhMeTRrL3pvYU1zTFhqQldi?=
 =?utf-8?B?aThwdU5SdjR5R09SanROYWt1S295MFBVTG1POGFEeHJMN2ZlNFI3MDZ4Z1Zq?=
 =?utf-8?B?eEgzeXkxY2FyQ2NJU0ViV2NjcnZoVjE5c2ttNmRycEhBK1FrSXg0dlIwS25t?=
 =?utf-8?B?Y1lWZUIrOHhCMlpSNDY4MWRsV24wTy9tcHBza25sUW50QTNCUnBKUmc0aWJ3?=
 =?utf-8?B?NmYzT0V4SGx0OVp4WU5IaS9yUFc0ayswR2JOZ2ZxSU0xVkVKbGV4LzZQM2FJ?=
 =?utf-8?B?OWxEV1E2WlZlNEt5NUpjSUJZUmdIdzhNdkw2RWZGTWVJQngrOFdkNGNTVFFV?=
 =?utf-8?B?cFBiSE9naWVpaDhPZzMyNTh5TnZIandGNENwSDcvb0QvN0dtWGVUVnVWL1Zu?=
 =?utf-8?B?dDBFbnJ6emNLRm9wUGw4TEdOb1YzWEQ0SlYzRk85ekcyYTdtNXNXZzBXaUs2?=
 =?utf-8?B?U1ptNlRkWGYzY09ucnVqRGVUUE9WWldoOTAzcEVZUkVNQXI1aXpVdkxDbHlE?=
 =?utf-8?B?T3RvUlRXWWt1czZNWTQ2bzdmL00vNDJSQVBFOWhkWUswblkxZE1GSC9GRTZo?=
 =?utf-8?B?WCt5SW12SU0zdEFJVHRybkZQK2gyak1mSzVIRnJBT2NpMFhPalZjK0VRMkQr?=
 =?utf-8?B?SnJYTlNCVEo3ZDBHenlqTE9iSWovVjZIREhEcnJ6andUTVQwVWt4Q0NaOEQ5?=
 =?utf-8?B?ZFhhSkpDMTJxUmVwbFN4azFQRWhBTGRiQXZpUDV3TmdDblVhMXNZamQ3dita?=
 =?utf-8?B?TTFUd0xNbEZiOWFrRmcrZkZLYURXWHI3MTgyRktDaXpvdC9NUjFtZTJ5VlRZ?=
 =?utf-8?B?bU91VXlCREtRZFRQeDAwRWVBZzlwQnZieUl0aWh6K1U2OUh5T3BtL05jbXYx?=
 =?utf-8?B?RWJaNHFXc0twaVMxczAzbzJzQVNjRjN3TkpqTFlxRVdVZUdyVlE5YmNzSVg5?=
 =?utf-8?B?em5ncmNxaTcwVDhRZEdzN1R5QmFXNFdoRDhFdHhKaHA2T2pBK0M5SS9UNFBv?=
 =?utf-8?B?RjBnTU1IMVNocElIbVhnVWNLMmJhbkR4SlMyb0J1QTYyaXRxN1VJb0lsc3FG?=
 =?utf-8?B?YmEwNlFHMXdLR1p5NEVxMkVRTHV0UmxDTjJOSVhuVHZ6K1BRQXdMVjlpcVNE?=
 =?utf-8?B?a3FydWVSeFEwb0N6Nk9PWGhIZkExVXR3MWxzVWR0cElLU1V4eEdmOHVqYVhH?=
 =?utf-8?Q?J3IeWqcJGUecV+WWJU3ay0bUY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0669bd-53db-47ba-4e2f-08ddf08680ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:24:23.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UEH7vxR0tjI4/fHjPOEhM2Ix1sMdhi2H/JeegbVjZADB5/z9Ra6PiBW2CbPIl3S6ntnyO+tbTchckxfnHfJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136



On 8/28/2025 3:18 AM, Alejandro Lucero Palau wrote:
> Hi Terry,
>
>
> On 8/27/25 02:35, Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices.
>>
>> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
>> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
>> presence is used because it is required for all the CXL PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> CXL.cache and CXl.mem status.
>>
>> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
>> the parent downstream device. This will make certain the correct state
>> is cached.
>>
>> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>      Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> With the changes for checking flexbus state:
>
>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>

Thanks Alejandro.

> Just a minor thing below, something I do not fully understand but I 
> guess it was discussed/explained previously.
>
>
>> ---
>> Changes in v10->v11:
>> - Amended set_pcie_cxl() to check for Upstream Port's and EP's parent
>>    downstream port by calling set_pcie_cxl(). (Dan)
>> - Retitle patch: 'Add' -> 'Introduce'
>> - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
>> ---
>>   drivers/pci/probe.c           | 25 +++++++++++++++++++++++++
>>   include/linux/pci.h           |  6 ++++++
>>   include/uapi/linux/pci_regs.h |  3 +++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4b8693ec9e4c..b08cd0346136 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1691,6 +1691,29 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>>   		dev->is_thunderbolt = 1;
>>   }
>>   
>> +static void set_pcie_cxl(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *parent;
>> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
>> +	if (dvsec) {
>> +		u16 cap;
>> +
>> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
>> +
>> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
>> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
>> +	}
>> +
>> +	if (!pci_is_pcie(dev) ||
>> +	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
>> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
>> +		return;
>> +
>> +	parent = pci_upstream_bridge(dev);
>> +	set_pcie_cxl(parent);
>
> This recursion is confusing to me.
>
> Is it not the parent already having this set from its own pci setup? Or 
> maybe do we expect that to change after a reset and this is a sanity check?
>

Right. The upstream parent bus state is already set but could change after reset.

Terry


