Return-Path: <linux-pci+bounces-18688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158819F6469
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 12:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE716CD9A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8166819939D;
	Wed, 18 Dec 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A34oUUer"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826317C219;
	Wed, 18 Dec 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520345; cv=fail; b=ElpW21XZjAR+XaPNM2+Z3VZKWGDouf/F5qwC1V2HuSLhzjprZwrNkRpzXE0aSzj7q8vdL56cFkJnCSltBWgcCoHtgCPA1Hg/q/BODBXp2Y/OFauSUIyh0mFkhsbnycSAowIfByydRfDr3bBIiBaupfRdBYQAu0S5IZvpreUYKxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520345; c=relaxed/simple;
	bh=DPOdIoZ7PPix9WpiHU6eBR2ONIKsGN5qKARhBbzlqlM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O6zSMuCCCiVDr4ZzD5xl6uoAuYVClqar4urFH7B1Mx8Y/Lt7Tbc6IydWus0/GD6FPOo6BpQ4ffUh9fV9GWnTk+3wkGYC/BnKUlUOp+On7BKv/VwyTZzKYzYvc9kZgYd4bkNNHNMS2NplvwRZSpZvNDIeu++bIXFnDVKcT/MWY2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A34oUUer; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQW5qazMovNJZPXq2RHqWASF7/GRH0XZTVpIo2IQOhd9xJVjB9uC8ewbI2KjiB6Mvxf4Y5GZVYmw2MMaZ+UQlaQ1DGrcUXyp/NJvaGTh/Iaum5AiQrpMSUGEaJ1RDcCmPRVZwHPL8rhD7h/h/HiccFiGNO9zbcGTFUQSMh9oNw8Wtq7ka4JdtSve5iVNfOa0oRqDXPaTtDgQnEqcY+EqG1jngZQNN73Y7i56OfgdSeyoFAq/ZGKDJP6RVJDSegEqLpi0qNhZdtpXUZXh+m56fVT1W9NJvk+LIZrucYuDUDypF/DCbU8rR5FOrDYZIbbw7hmDtnzeJe9pq57d+INugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2zpEEd4497H8rdqp1CmHcTfFGlz1inQyxr3oGKAVTE=;
 b=b9zyG3ltac7kjEwfZ/I75u/pQH9csOzPEx22AWsn2u96DYa7IRszVvWqtm9xyw/DgTOQVD2Bg37E8mJPURcJV9I2+yRMD0lEv+WE36p9FxkSf7154eJOF2B5S0WMFS3UKlekEZMq5DZrhi4JS2tu3oDYHkSzlhRXGC8y3bqcMJdao2jvccn2l14fRJzEFsyzBgt4OZBNnc+n2rd9rNvN5ht4e69mRvXme0xXx/SfCsfCiXNcyRA1rmRhqKjbt4KtlJEp/tMBR+HKUHIr2KZoPbi497sCyeFUfWt6A6dso89V9LXzuNX/9a5E2limnL7kVkqgWAUjEw0O0cE86wmzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2zpEEd4497H8rdqp1CmHcTfFGlz1inQyxr3oGKAVTE=;
 b=A34oUUeryc+9IVEf1iR1y0hXmmtWTipIA3F/zbo28EC/d536ev+f8TU8KB/0ODf/tsqSPNFKsLd2h2W6rE313GOTKz4/IIMGudshVcv6MuVAzJcGGlqpu4hcuws7DlCRelSatKSNymLsc1YHmQAsBSOfkTrV8UVfmsvFJWlQhSJDqxUqIGlp4uJ38Nh1JRTDbPeEfb+AHcj4cptlpL+fk6/fyl7bl+71KPtnpzZynfTu6bMxMbs9210kPqhL213i3ajxiX+MyGJmUlwfocz8fiQat8bJcjA+SUCQAaEoj26XQ3HZe1U1c5il1R/EH1NjZYJm0l/orWrOjjFEUOPOJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 11:12:20 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 11:12:19 +0000
Message-ID: <99a4ee84-e41d-472d-8935-8f2a2de837ec@nvidia.com>
Date: Wed, 18 Dec 2024 19:12:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Use downstream bridges for distributing resources
To: bhelgaas@google.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carol Soto <csoto@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Chris Chiu <chris.chiu@canonical.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>
References: <20241204022457.51322-1-kaihengf@nvidia.com>
 <20241204054809.GD4955@black.fi.intel.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <20241204054809.GD4955@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8fda44-2151-4d0e-3e3f-08dd1f54d68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjFzMUhLY2hDNlFpN0QxZkVFbmFneGp1dmtzR1VjUzVKY1FDdktZRzdlYTda?=
 =?utf-8?B?bTZlbGVpTDlXZ2hpZEcvWmRXbE5ldXJIRlRWemJHSk91cVJTYVVHV1ZpUHlQ?=
 =?utf-8?B?OXJDMldvVExkMXAyVWxyaHkzWWxkQ3BvSVZCdVkxK2ROOEVWOEdKN2s5TFRJ?=
 =?utf-8?B?K0tCY0pncHpwUEhCZEFkdm1FT1hKZmwyWDVEd0Vvb3l5c1RxSEF5eGpKTlB1?=
 =?utf-8?B?bWJ5di9URFk0aHNjSUR5d2wxL0h5Yk1FR1FPakhYT3FXa09nUlRLOTl3WWEz?=
 =?utf-8?B?UzRxall4TkVoNkxVSVBZY0l6MWR2ZlZ5MTVhWkFYWjMxRm80MkV2Zll4RXpU?=
 =?utf-8?B?MVVpaEhHMlZkZEd4dzF6OTJ3WGNvZ2F4MlVBMTZpRHNmaVhXMEptc3FjVnZu?=
 =?utf-8?B?LzUwYkFhUGtRTWpybzZ1b1cyNjhxMUhxYnI0RmRmbzU4RGR1bk9UZUZPcUI1?=
 =?utf-8?B?R2ZYZ0NMN3JOd1I1MHdodHYySWlVMGZiaVVhWlZwYUZBTXVFZktYeWFoSFlD?=
 =?utf-8?B?N1NIa3hVT3NWbm5NM0FZR3M4V1VFZkNOcHNEM29pdkQ3elBZN0RzWlZyRG9Q?=
 =?utf-8?B?bVpjS3BET3J1dVgycHdiUHIxd1NIenViOEtXbExNY2s0QkkwdGhMM1VleGI3?=
 =?utf-8?B?NExKRk9ZVnhsWUQxZW5hN2owTmh6SHhZR1hRTkloeW5rM3VucmE1S0swUGRJ?=
 =?utf-8?B?a3FxVThDc2VNck91UTJyK04wR3ovS1I0K3dkclFLVXhoUTJTYkx3am45ejEz?=
 =?utf-8?B?WGljSXAvRmIwbWNUb25Uc09VMXdxeUoyVjV6cXArZDRTb21XQkZQa0F1Q1dS?=
 =?utf-8?B?K1ZuSHozVmRpdUpzdjdzTHpXSG9oV1FOOTV6NUg4VnM5cmNIYkVGNGVkeUE2?=
 =?utf-8?B?M1NzMUdkZ2svOG5pTnhjcHkya1ltTndPOUNyUEQrQkFJOUlFTTJrcTMyU2tr?=
 =?utf-8?B?OVdkenc3M2llQytLZFFnNHZiZ2RGSkozSHlBczdkdmgvSTgwT05zUkh2dXJa?=
 =?utf-8?B?Zk5QRFdic3pTckorZWxxbmVQQ1NPVWF2bEo1dFNtYms0UUI0amtTU0ZTOWZj?=
 =?utf-8?B?dE5MVFlHdjVIQWFZWitYVjZnbGJselRYYVhabW5YbVF4ekJzaUNIZnpWMWN5?=
 =?utf-8?B?THp1aGdyazBlSTZYR1lHVGRrNDBpZFQzMzFrcWM2SkFzQnFhYlg1MWNuOTE0?=
 =?utf-8?B?SmxYMUZ1TDErS203eDFqQ2Vpd0x5L2I0a3p3ZFd3RzlUbnFFRHIyNFlGK2pr?=
 =?utf-8?B?MkN4WlQrTDFYaXl4bFFPUnRMRmxubzJSZEtuZ1pVdCt3Q2ltcU9qY1FlQWdH?=
 =?utf-8?B?SXpxZjM5V0dIUE1sYzdua1hTT2taMTR5bUNNM09HNFg5ZUVGRzg0RG5zbE5u?=
 =?utf-8?B?UittYjFNUW5wMitMeE1GZ05GeEgxZzRZY0trM0RDT1p6N09pMlRUSWZXbk5w?=
 =?utf-8?B?cjNTM2Mydi9hZXhKbkZGWGhIYUlTYzRGbVMrbGhTdkw4SnRsYjRPTG1wWnVk?=
 =?utf-8?B?T2wrWHI4dzdOT2FEL1lTT3hrK3c2RnEwaWw3TXhHbFlPZWpYUG85bVhUaFh0?=
 =?utf-8?B?TWRxc2xRUE1OZXpTbUtzV290WnlGVDk4aDdLRHg0aHU2a3NXNnFYVml6RVg2?=
 =?utf-8?B?U0tUajBUVUViR2xkSUtaSmt6bCtJSnJ0cjRacmJzckR0NmVTUGc5dHF0a0Ja?=
 =?utf-8?B?UVhYdUlkc2Q0NFRYOENDRVhuR3JtWGVJTExIcFhZblBsd05PdXJXaHhmZ0dj?=
 =?utf-8?B?OS9zdEtkbmlyTTQraFJ3QXZFekFOcThaanpVV3dGS3QvbEMzb0c2UzdBTjVj?=
 =?utf-8?B?cjVkMjlXTlB0K21XQk1ETHlLQzFTT242a05EZm9tVXQwR08xbmhneitNSmMv?=
 =?utf-8?Q?kBw2s81GCUk0Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a01SMFN2bEN0TklVSm5Qd3JCNW9jb0VGWTZtdzFHUytIR3NpVTJXV3c0b0h1?=
 =?utf-8?B?YWlacVFuQlBiaVpTNVdpeitzWVd1K090MFhpcExkRGVFMUVNOS9xcm1qeUZs?=
 =?utf-8?B?SmsreHlmR3p0LzNFazc3aWZhNXVkUTJlVHhsY2Z6VEV4dkE3UVJyUmJzWk5D?=
 =?utf-8?B?anZsY0s2eGMwa2lKRVowd3JXV1hQQUp3SDQyc09IUzR5MXoydmtLUjJyZU9k?=
 =?utf-8?B?bEN2WHQ5WEZiSzR2Qmt3TTVmNnB2TjBJb3lvbDFpSTNWUXYxUjEwejV5cTlO?=
 =?utf-8?B?b1BiUjNHTHBQQTJJbDQ5bXc2ZmtpcWhKZFFzWmc4VjVpZGZnT1RIVzJVWjdv?=
 =?utf-8?B?N2t3RUR3eFFoWFpXckIyTEFPdVNyV0xCYW1kQU9rZHAreFpPeEVzVlNGbVNW?=
 =?utf-8?B?cnJzNGVuWFRLby8vR3E2SlMvQmIyUzZwS0dNWlVVTEk4aERSdThHMVdlRlZu?=
 =?utf-8?B?MHlsWllyUWlENHFmaHpNL3ByUzFVWCtPWmdkb0luSzlDa0cxeG5tWk9Db0Vq?=
 =?utf-8?B?bGlXa1J6bmU5ckFRTlBEL0dHeGxidVRYTWFhSDZhWXZXeFJ6VktWd1c3R2E1?=
 =?utf-8?B?TENtcVZPb1NDQmpaZnAxSHg3eGNzb1dJVUtvNHpJV2RqOStoc2l5R3RnUkY4?=
 =?utf-8?B?V2p1dlViVnFQMWZHSjhLVlFMNUFVc2lrY0t1NkJTaUxYODFQcitOK2xhS0Yz?=
 =?utf-8?B?RlVrNEZYQlhxWld1cnFpNEZPRm91d2ZtM2dPRCtBZ0phaDhjZFF2STRvUmp5?=
 =?utf-8?B?aHBmUHdmSTZPZ3ozbWlpRE91VGV3YkV0Y0xwT2t5T0NpMzNjR0UwUEphZERl?=
 =?utf-8?B?aHFtbGgzUTBJYUZublduSlRsdWtKQk15QkRmWTl4YUZDSS9FNFBYWW8rMTdU?=
 =?utf-8?B?R3Y5TkVSTmhYcFdvc3VXRGNaMEtIZ0VLTGc1RThOcGw3UEJwVXBSVnpHdmZW?=
 =?utf-8?B?NGpGa3J4YWgvY2VocWdrcitINWJaRHdZVDgvL0VZS2FsMlBsS2czWGRtdU41?=
 =?utf-8?B?cjV1eVlFdWtrUXFjNGFvMTB0UStoUTBUcFEwSmZneksrTXRBZzdHaTlhMGRL?=
 =?utf-8?B?SDhDMFM2NU1pVUdaQ0J3aHpyWS9hZ3JUWGFpOStOQmZyUnExa2RWSWdpaGJT?=
 =?utf-8?B?QktKaU5HUWJxbXdoN1pDQWF2MTJZS3ZlOXdIUWZOSEg0aVd4Z0I1MThub0xS?=
 =?utf-8?B?VGd1VFYvREFQSVFodDRNZGlMaHJ1b3JZb2pEdFowb0diMVFsL0hRbFV5a3Rm?=
 =?utf-8?B?TlUwSm1yWCtpOGJDSmtESlNVRFJiRzVZRjBWdXBsUkk2TzNGUDFENnJwWkRv?=
 =?utf-8?B?cmxGU003aUcxQVZBUnNJY0I4V09HRFQ1dkhEdFpnUUQzQ1hKQlNIUXUxL1M0?=
 =?utf-8?B?U2o0MDZoRDY5WWRmOUZNWk9YUGV2elFPOHFCREIvbnh3RS9KblpvSEQ1cXFX?=
 =?utf-8?B?cENtdnpJMXREb29HMEpxclRNMEpmMnJjaXl2NnNoa2hLQ3ZnMlVEN08yNitV?=
 =?utf-8?B?aXE5cFEyVVBmTlZPVFF0dFFQblVpT2N6ZE5WUHlQZXllbUdZRmUzK1kvazVj?=
 =?utf-8?B?SEYxVUdUdGZWVFFyMWxxSE9TZDE4eDlscU1CSlN5cnlIemhaamZSbXJBT1kx?=
 =?utf-8?B?dFdyNHZidzFsWlBtRG1kUVpVZ1ZVa2owaGFiVFRBV0FmOTlJY2htRWFTNXll?=
 =?utf-8?B?MWhKTE15M1V3NXc1bitrTXlPQmkvQjdKSk9kZnJhZ3NLTzVlWjZhazd1b3Zq?=
 =?utf-8?B?cHZQaWFlT25WckdTSVh1SFIrU0pOajRZWURYV01IVWV0a2NwR2pZdEFUaTNV?=
 =?utf-8?B?NEFla05uT1I5M2pEcU1CRVdxQWd6dWNLZ0NZSXhGVUVuMTI5ek45ZzZrR0Yx?=
 =?utf-8?B?NTlYaEpKb29vNk5GdlJSR2tlck52UXJ4UzA3UjYxeEZlNllVeXVCMC8wN3ZK?=
 =?utf-8?B?OHZDMXpQRjJZZDY3N3ZTQUtpdDB1VnJWMXJLUHZ3VHljcTlJRmQ5bVA1UXNY?=
 =?utf-8?B?OEdhYkdER1dQMlV4MncxTnV5RnpwQ2hZZElSMitLSDFwbE04Y0oraXhreEEw?=
 =?utf-8?B?WUJJQVMvQmVFaGoyUkVYb29YSFBKQUR0V3JJUlRsVzdxOVpOR0p5MHR2b0cr?=
 =?utf-8?Q?uG9zhw5GQU8Cstm4hS3SI+h5Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8fda44-2151-4d0e-3e3f-08dd1f54d68f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 11:12:19.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCkjkFe7Iwdc7ioUIDNHd6n4aYUWwGK1+bSSY6USNs6mhr4Eft+6BT1GDLodkyT9mJuVWmovSNGQPqabVd1jWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

Hi Bjorn,

On 2024/12/4 1:48 PM, Mika Westerberg wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Dec 04, 2024 at 10:24:57AM +0800, Kai-Heng Feng wrote:
>> Commit 7180c1d08639 ("PCI: Distribute available resources for root
>> buses, too") breaks BAR assignment on some devcies:
>> [   10.021193] pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 64bit pref]: assigned
>> [   10.029880] pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 64bit pref]: assigned
>> [   10.038561] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: can't assign; no space
>> [   10.047191] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: failed to assign
>> [   10.055285] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
>> [   10.064180] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
>> [   10.072543] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
>> [   10.081437] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
>>
>> The apertures of domain 0006 before the commit:
>> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>>    6300c0000000-6300c9ffffff : PCI Bus 0006:01
>>      6300c0000000-6300c9ffffff : PCI Bus 0006:02
>>        6300c0000000-6300c8ffffff : PCI Bus 0006:03
>>          6300c0000000-6300c1ffffff : 0006:03:00.0
>>            6300c0000000-6300c1ffffff : mlx5_core
>>          6300c2000000-6300c3ffffff : 0006:03:00.1
>>            6300c2000000-6300c3ffffff : mlx5_core
>>          6300c4000000-6300c47fffff : 0006:03:00.2
>>          6300c4800000-6300c67fffff : 0006:03:00.0
>>          6300c6800000-6300c87fffff : 0006:03:00.1
>>        6300c9000000-6300c9bfffff : PCI Bus 0006:04
>>          6300c9000000-6300c9bfffff : PCI Bus 0006:05
>>            6300c9000000-6300c91fffff : PCI Bus 0006:06
>>            6300c9200000-6300c93fffff : PCI Bus 0006:07
>>            6300c9400000-6300c95fffff : PCI Bus 0006:08
>>            6300c9600000-6300c97fffff : PCI Bus 0006:09
>>
>> After the commit:
>> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>>    6300c0000000-6300c9ffffff : PCI Bus 0006:01
>>      6300c0000000-6300c9ffffff : PCI Bus 0006:02
>>        6300c0000000-6300c43fffff : PCI Bus 0006:03
>>          6300c0000000-6300c1ffffff : 0006:03:00.0
>>            6300c0000000-6300c1ffffff : mlx5_core
>>          6300c2000000-6300c3ffffff : 0006:03:00.1
>>            6300c2000000-6300c3ffffff : mlx5_core
>>        6300c4400000-6300c4dfffff : PCI Bus 0006:04
>>          6300c4400000-6300c4dfffff : PCI Bus 0006:05
>>            6300c4400000-6300c45fffff : PCI Bus 0006:06
>>            6300c4600000-6300c47fffff : PCI Bus 0006:07
>>            6300c4800000-6300c49fffff : PCI Bus 0006:08
>>            6300c4a00000-6300c4bfffff : PCI Bus 0006:09
>>
>> We can see that the window of 0006:03 gets shrunken too much and 0006:04
>> eats away the window for 0006:03:00.2.
>>
>> The offending commit distributes the upstream bridge's resources
>> multiple times to every downstream bridges, hence makes the aperture
>> smaller than desired because calculation of io_per_b, mmio_per_b and
>> mmio_pref_per_b becomes incorrect.
>>
>> Instead, distributing downstream bridges' own resources to resolve the
>> issue.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
>> Cc: Carol Soto <csoto@nvidia.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Chris Chiu <chris.chiu@canonical.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Is it possible to pickup this up in 6.13 window?

Kai-Heng

