Return-Path: <linux-pci+bounces-11157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055FF94573B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 06:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DFFB22247
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 04:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD88420B28;
	Fri,  2 Aug 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UHlCTWgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B0DDA6;
	Fri,  2 Aug 2024 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722574737; cv=fail; b=AopwWOuLi8QCc9EmJRwZ4ooI+ttdLb1zDOo6S5MaojaftX2X1mfB5nFj/ozSrDOfPftK/ZSO5gFZ/9Oh5B3qRVJeR/I6IqE+ywDFd5gb6LY6hiG13ZgYKMGXbZjP/NxXxdYZpVwjhEe++FeBcavxnQfD/81sSgJVDFu6YCzwhZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722574737; c=relaxed/simple;
	bh=dE0hWMrCRqRUgfRCQpQHdeGFe1/cj5qmYBbxNXkts08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MT3p26bF/39rb++5jrB5cH3dwhS2p0h/Nois+lW3I5csyVuC6+dg3cSNxZRX+HJviN+h3VAKWPKwm3AoNfXm4/6mBW6RDkaB/TzOvlIHy2v5y4ftVzReN6XW/WbW90/xwhLwftWjFsS8zfu9NzmtHrm4CeUL/mxnVONwPNby9nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UHlCTWgS; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yT4qdxmLPAz4lnM2zXpSNNZF9MXQbqetKYjXDEpASLXgL8Aw9ec6d/uHMFkHrlFf+K1K66jO82buWNKjiyBwB+rMJEYSKZQOMmXQ78MhtcNYuOOwu8umVM/IyLKwOdcYMMDsQqFqbZr4YT8AU0Bv4A9gT2ouHxieTd1bE5crplIE6+GH0GGOu8oXYUVpk9C1HxaUtU6H/18Uc5zzjh8Tn/Z8ti5YHG4PY8C8MDveOUJTe71Ug3BAssl6ugS9SSNOHvR9mE0Yc3zRjX3Gd1bqSSydKBu+WfBo6dobwVIFMnGk9PjyUxHqBij7dPFMTMGa6VL/006qAcXVt2FD7udmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLPnVVC+OWED6K5bkFTnM+PnNE3ZPWcp2851SVyK4Mw=;
 b=RrSauUp/9U82Yqkrv2cRF+l53/V8V/kgT6TvnZvoLe4dLsAEDLDOmWm4Bacp9xLn7KMVfTQNEhu2WKjYRwsrxbx9cpSXWNTma3OHpVWPmCoHmpKc/o/3JS778Xbn53L0RNIroNaGT4mHu34vYGkX1QCSerVfbjxImnN3+czpCmv9FnFEZxpEK9untgi+5OlmrFy8pYdXixtBSCnXGaPZ3gQ3oGSJhHcgNmOuaxIAIlShaEhouP77scGlcXfSoghuezB3uBBo3Xj9CoJpD6YMT0byOUkb230Pcca/SEL0LtfwKasSuvZVJ4SRuWAqRfzPQSnS4WB7eOlMecoi6wLndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLPnVVC+OWED6K5bkFTnM+PnNE3ZPWcp2851SVyK4Mw=;
 b=UHlCTWgS+EhT6GPUGtyGJBjxfzaNQfindQhVeeMJ0+8A9BytfGMZslLHbFr0wOJS3eRS//K2CDKyIWYZ0LlJmNk9l/CTVwPcrjH3eTJuqNnFN12tYpd5wPFYAg7dxIl1NvH3wPSPMu2WNpZw5TDi0dYg3Bpb088Nde+ByPAiQXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 04:58:51 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 04:58:50 +0000
Message-ID: <2fc282b0-97e4-448c-a77e-0ed63746d0a1@amd.com>
Date: Thu, 1 Aug 2024 23:58:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/10] PCI/TPH: Introduce API to retrieve TPH steering
 tags from ACPI
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com
References: <20240723222229.GA759742@bhelgaas>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <20240723222229.GA759742@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:805:f2::25) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b241db1-aa1f-42ac-78a8-08dcb2afcc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1BnMDZPQXFWZ3hRd3BnWWVuYUVrakdwNTdwY1VrOUlaUWFqOEppdlRqbjEx?=
 =?utf-8?B?aFRoc2o4WTNuZFNlRjBtTWptRkRER1lPNHI3dno2NXpySGhzaWpERWpEbElr?=
 =?utf-8?B?bjRnUHpmTUVQekxJbUZ5L21YZnBXZzVYRFhiWHFZNDNObk4rSkhLSklJalJu?=
 =?utf-8?B?c3Y5ME45UWNqaHVYSnBrNEdwbkpnU1k0eGp6UFhPT2hYaGhGeXFCV0QyVmsz?=
 =?utf-8?B?OFZjcC9VVzRKYTNRMzljMU16Z2hWYXlTT3NWNW1xeXlRR3J5K2JwOHBxdTVJ?=
 =?utf-8?B?WEtGaUg5MjV3T2VEcWZJUC9aK21KN2VOYW9SbUIxRnovVVh6YVFHbnBRZjBo?=
 =?utf-8?B?VE1JT3ZFN0t6bVZONTBlM1UyQThTTHFWYmx2cmJwaU5sQitxRXFUV0dpdU13?=
 =?utf-8?B?UlVOWXh5UGU3a0RiV1BBdUZlczRKWnVnL21oeC9mNlBtNitEc1N5YXcrS2xW?=
 =?utf-8?B?TFA2ak5McnFNSTMvWEFEb3ZPQlZnaGlWWFZwcGcyMTh6eEFLQ1FoK1MzT2s2?=
 =?utf-8?B?dWNGc3hORlF2YXpLazdIMjZLNHV3azVXdFVzditSc0pqb2l0OHFRUVdCWExJ?=
 =?utf-8?B?Q1VPRnFUVUVKdVRIMEJQSldJTTRDU3NJcnJZMkVWeCthbXJTa0oxZGI2R0RV?=
 =?utf-8?B?Q2txcWNmVkVNbUhNZzFWdzQ5bVQ2RktwQnQ0Szk0RWFzMnZTdkJSWXBnSVpx?=
 =?utf-8?B?RXlZc0YvZVBzUThpdW9HQkwwUTRXVmowQmlIYzU4RldhZHJKU3AxZ0luYkQv?=
 =?utf-8?B?aDgzbGhwSlc3YmpXRE5nUXRXd1FLZ2d5ZFpoMTZLMVhQWGxEQTAwWHhSTStl?=
 =?utf-8?B?Q0NFNWliNUJreEtSRElORWxzNkRlTWZQRlRQdkxCdHU4ODJwZHFKc2xTWVEr?=
 =?utf-8?B?T1pEanppekI2WWkvZEo3WE8wRWxvZmIxTFhvM0s2Y2NwWnUyUUNBVjllOUZC?=
 =?utf-8?B?MVZTOU9BVW5Pa2JPRVFZZlJoSFpOVW1RUFRBdkZEeTJCVDBQUmtSdnRnSEls?=
 =?utf-8?B?TkxHQUM2Nk9EWlJ2SWJzcExKRmt6SktxeUFwMDkwcFIvYVRmK1VNb3BSZjFD?=
 =?utf-8?B?Yll3eVFKcTk2SWo2UHc3QU5QUC9PUmEwR1UxT2Vya1lOTW10Uy8zd2c5SEVN?=
 =?utf-8?B?d2pRYWt1VWJOdGM5OWR2RThEQTN1ejBTVDBNNXVuTTlMeGFpMFlwaEY4UVJv?=
 =?utf-8?B?VnN4a3d0ZDQ4M3J5bjFJNWw5QWFyUXVKVWRwRTlTYXQ1bndsME05eVc4VUl5?=
 =?utf-8?B?V0I4NjVYbkdLTUtWblJLcFlBNW9FTlVwTUw5TkJLQWNjZHZOU0FSekpHeThR?=
 =?utf-8?B?UFBKS1RsMVVLNE0venBmbVd5VGdhTmo0dlBQYjRqeXNNcXhpTGNpNklMSDhh?=
 =?utf-8?B?bTNwc1pOSGpnTDQxQ2Faak5odklWR3RwVUs0Zm1OMlgwOFRsRTdiZE1XVFg1?=
 =?utf-8?B?ODNKeGtDTG5OZzNoOWltZnlVb3ZaOVk1ZFB0c2lzU003a0NzRHdvUHp0Rjh5?=
 =?utf-8?B?Yy9qKy85bldwZWUvc0FyNHJkTkF0Mm85Q2lrRkRmaWVoam1nVTl0bjRpVUtn?=
 =?utf-8?B?NVFDN2V1ZDVadEowWDNTNkRYZERvaFZ3Y0gzSG14SWhUMlhlS1l6OS9iamRX?=
 =?utf-8?B?alAvRm84UGx0VkN3WFpjTFBYUllaN2IyZXgyUUF6YnptTVIzdC9DWU1lMWtK?=
 =?utf-8?B?MXhKY1ZIN2lyVC9mZVlpQUZSYXl6clBrMEtqbE9DM25xM3VJVWs3dDB2b2Ry?=
 =?utf-8?B?cGlrcXNIVVRMd3liZU5DeEF0R1FqY2hhRk1GTzJyYm5sOHhIN2ZZUGZaQ1dw?=
 =?utf-8?Q?g/uVaFXYDEoxoKC0Tbcxq3uQpJzS2wb0x6eMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHFVRzZTTzkxUCtOM0J1SnE1WVg0eEI0bVdHRnF3MkpMZ3FkQ09neUx3VHY4?=
 =?utf-8?B?WGZtRm5BWEh1QWJVMTNzWmNaOHRyRGY0Vm9HL2lISXdkOGdwZUJGMmplNTM4?=
 =?utf-8?B?OHpHaENlR2YvL2JTRVRJZVRKN2xqMXRWbkxKVVphMmgzd1BpWkdzbXBKak5o?=
 =?utf-8?B?WXJNQThJTVFmT3Zwbk55alNud2tXYllKbzhpNlI5bk5PS2MrNXh0djhEK0RZ?=
 =?utf-8?B?RzFpOW9ENHJTbXJscUkwSkthMmorL011Z1lOcEFRTVJySU9CV0xIeEphVmtx?=
 =?utf-8?B?a0FDMU1EQ2dFSGR4Nmk1c0tURFZpejB1czFYMTJxR3J6QURTdEVJaXk0Mis1?=
 =?utf-8?B?dEJENnBzU2lQeW0yMHZBMzZBWmdWVUZDZGNJVXVwM1JZTnBKVU0rMVo0Wmhp?=
 =?utf-8?B?NzU3WUdMaXlRQ1IwVDBnbHJ5MC96NWluMlNvd1UwY0xuV2k3OW5GamxhL3Fa?=
 =?utf-8?B?cDRIWEJTZy9LY0pieDdaWDF4Y2FxbkpncXE2R1MwbjdJRGoyZ3krN0xZNjBT?=
 =?utf-8?B?Ny8xbWxSQzBhdFI3VEJOY3AraUh6VHB2Y2kvelYxNkNIT1VGQUNMMFROTTlU?=
 =?utf-8?B?RGcza2gwTDhLUHZOMlJFZDhVTGg3UHAvdGVJZ0cwNDFrQXFxMXlseU5sSXNV?=
 =?utf-8?B?Smtzc2NzYUpyLythRmtSUDYzMU5EMkV1dFlQV1Myb2dsVzZacW92bXE1NmxR?=
 =?utf-8?B?ZDVZNlowRXBWazVJd2VkNzNhbXFmdDVsTlY3dW5paENUNXFtVUdiTXJCTE9v?=
 =?utf-8?B?a2d4N2pQWVN6NTRkMnJ2bld4SzNiWFZWV3lsMW9BNk1pTWZCRUo1SWlVVVhL?=
 =?utf-8?B?RXFRWTBrcjRSdU9oYmxTOTB3eWJOSWpYN1gyQ1ZCSmgxY1N5ai9yUk05NWJa?=
 =?utf-8?B?NUJLTHFYcWttcWZPbkt6TXVOUTVrQ1JFcGczczhrLzJkNmhFa2Q5a0JrbDZr?=
 =?utf-8?B?UkpRMnBvWmZZVUg3SFJjQjVraldnYkswdUwvcC9CTmlyY05QOXk0RzBwNTIw?=
 =?utf-8?B?OHZCS2FqemJKWTliRkVURjZwdjdWcDloV3hWMGJOZm5xeERXNndkVllIUjBx?=
 =?utf-8?B?RkhFazF1Y3pzWnFJMkxBSDBvU3MrNWhDRTFydEhEY215QldNNVlUQWtqV2Qr?=
 =?utf-8?B?dU01U1A4OG40SDVQbTFsYW15MEZJZmxBaXdmaXpXZjhMVzJkc09nOTN2ekc2?=
 =?utf-8?B?bEpUNEI4MUFhbklJY2UzT2dRMCtJS3FDNEVTVER6WWpaT0x6QXhYMkJIYVBh?=
 =?utf-8?B?SVZhVm45MTdhYmZHQjdRUmlEMVF3azdTZTdMZlY2TGR0SVZWQTQyaFgyaFNR?=
 =?utf-8?B?TlBTQkxWdzBYcU9CL2ZINVNCNmt4RG5nSEtLU1JML1JQaDFNZUQya3M3RFRO?=
 =?utf-8?B?MnVyZ1BGQXdnUmJJVGExc2RCUGhRQ0w0UFBqeHhDN2l3enBDaDdhVHRHVCtp?=
 =?utf-8?B?MERKMHBjcmlYVllJaXBWZEtoV3F5V0FhUTZCWXRVS0M3a09CMnU3NWhPR1VB?=
 =?utf-8?B?WCtsUStZMGFqSXpZZDFYWEVqTFhSaXk1VXNwSndYTmVNaE44TE14anU2OWY4?=
 =?utf-8?B?MXVCMFVFdUtheE55bE11R1J0SDdGMGgzQUZwQ29pV3FSelVPY3dNckhZMjV1?=
 =?utf-8?B?cGppODdmdlBsUGJzbXpKYW1QN3NXUFBMbUlueVE2WUd0RlYwZ1NFd0lNdXIz?=
 =?utf-8?B?R3hSY09RQmR3bjJDNTdVQWNxdkNOYXh5dy8rOHp0YWxPdlpWT3oxM1FpYzlW?=
 =?utf-8?B?SUFoMEROeW45RmQ2bmNCOWhPMHF4LzdDZmg4WGhlWkNKRWdick5KcnRSRk1Z?=
 =?utf-8?B?VHVKOSt4MHdJU3lCU0JsZmhKZHhBT3FFNWVFUEM3QjlGT0tldzQwblE4SDh0?=
 =?utf-8?B?RXZqNFlMOVJIZFQydlREaGo3bGcvenM3OVBrZDd4T3BjdGRhdm8wVWhRYmdp?=
 =?utf-8?B?Vnp5NWlGWmNHczI4Q3NuNjZLUGhWbGthYWJFZmZ5ZkZocW5TWWx6SWtpRGt5?=
 =?utf-8?B?YkxGZFpva012YmNubkErWEY0VncwWkh6UGxUVkdxZzVHYkNJcTRkTTNXN291?=
 =?utf-8?B?eFJ3emw4ZXBzRmRualFnUnl2VzlmMm9LeWdUL2RVd1FoMmtHQzJQN1REUW45?=
 =?utf-8?Q?1TC2bkfEfgk2Py674X25Fkzt3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b241db1-aa1f-42ac-78a8-08dcb2afcc96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 04:58:50.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgrcgEh40Jp8o0ny70wgRCWMqOR/hMamLEzZ+px1A0iu38hKl2Ln5ohXRQ0AQgSa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368



On 7/23/24 17:22, Bjorn Helgaas wrote:
>> + * The st_info struct defines the steering tag returned by the firmware _DSM
>> + * method defined in PCI Firmware Spec r3.3, sect 4.6.15 "_DSM to Query Cache
>> + * Locality TPH Features"
> 
> I don't know what I'm missing, but my copy of the r3.3 spec, dated Jan
> 20, 2021, doesn't have sec 4.6.15.

According to https://members.pcisig.com/wg/PCI-SIG/document/15470, the 
revision has "4.6.15. _DSM to Query Cache Locality TPH Features". 
PCI-SIG approved this ECN, but haven't merged it into PCI Firmware 
Specification 3.3 yet.

<snip>

>> +
>> +/**
>> + * pcie_tph_get_st_from_acpi() - Retrieve steering tag for a specific CPU
>> + * using platform ACPI _DSM
> 
> 1) TPH and Steering Tags are not ACPI-specific, even though the only
> current mechanism to learn the tags happens to be an ACPI _DSM, so I
> think we should omit "acpi" from the name drivers use.
> 
> 2) The spec doesn't restrict Steering Tags to be for a CPU; it says
> "processing resource such as a host processor or system cache
> hierarchy ..."  But obviously this interface only comprehends an ACPI
> CPU ID.  Maybe the function name should include "cpu".

How about pcie_tph_get_st_for_cpu() or pcie_tph_retreive_st_for_cpu()?

>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index 854677651d81..b12a592f3d49 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
>> @@ -9,15 +9,27 @@
>>   #ifndef LINUX_PCI_TPH_H
>>   #define LINUX_PCI_TPH_H
>>   
>> +enum tph_mem_type {
>> +	TPH_MEM_TYPE_VM,	/* volatile memory type */
>> +	TPH_MEM_TYPE_PM		/* persistent memory type */
> 
> Where does this come from?  I don't see "vram" or "volatile" used in
> the PCIe spec in this context.  Maybe this is from the PCI Firmware
> spec?
> 

Yes, this is defined in the ECN mentioned above. Do you have concerns 
about defining them here? If we want to remove it, then 
pcie_tph_get_st_from_acpi() function can only support one memory type 
(e.g. vram). Any advice?

>> +static inline int pcie_tph_get_st_from_acpi(struct pci_dev *dev, unsigned int cpu_acpi_uid,
>> +					    enum tph_mem_type tag_type, u8 req_enable,
>> +					    u16 *tag)
>> +{ return false; }
> 
> "false" is not "int".
> 
> Apparently you want to return "success" in this case, when
> CONFIG_PCIE_TPH is not enabled?  I suggested leaving this non-exported
> for now, which would mean removing this altogether.  But if/when we do
> export it, I think maybe it should return error so a caller doesn't
> assume it succeeded, since *tag will be garbage.
> 
> Bjorn

