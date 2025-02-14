Return-Path: <linux-pci+bounces-21518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ED3A36639
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 20:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349A57A2575
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 19:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A6194A44;
	Fri, 14 Feb 2025 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F6oqidox"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3733A8D2;
	Fri, 14 Feb 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561805; cv=fail; b=OkAM7QSsg8wLH3H/SMyk5vavUzY5qmFvEyiZWGi0/ESzNdJNtc+1Jb417P4xkM3h8kVFb4mN9j+Trr5zmwix5keX59ZRqcR1tKTNyv+2SvvwAhK64Dh4x0VzLnTSaiSWshR+vEgnDSmK6ohxXDutDqf8QYQq+RFbwZbFxpYdL64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561805; c=relaxed/simple;
	bh=5z/K8QodkPshvseCS+ieOpsDmeVm/cbgKBIln6/KhAc=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JTgTFHU/KmpXnstC/WOJGXdSX0G29P32f4VPiTkEU/rt6sVRCzRMaMBgKsTsdrRNMToo2ZeXLLBKFy7t82e7/eOPBFEjy91ENmSCR+x1sKtYmhYq7Y4npP1dXmWk2cz2JUMO6zi+KCkvmCFdxO/zMut+GxUuQufHAVC0934k4lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F6oqidox; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsqK/18j/DxfvZIHZViNdWtrtkwgFnCyS+hWzpBaA7H33fqYi8wLGeCNP/N9cHJkrIZWbxu+nKrS3CI4ADx80+U2eVi8XNaFVMqCk6D6cFYjZUzogoNN5rVUHK0ujacF2pcQ24SdLBJul+2xQfDPtbWLvqftT4x/YmCqwOXOyKsI5Eg/UAsS/L4b5niWeepxY1lCjNhkTNQVUUTLBCGwDQFrsNLTMpZIypDt0KQzBM0OLTSyUlGFI1wHSH1Nz4sUbYf71mut1s+aGJPepBs/prq1d6MYKZoau58N5zGOUavozSam00b+tlkXj7SD3giSeXMZM0pFGlPgBkPmwcL/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z/K8QodkPshvseCS+ieOpsDmeVm/cbgKBIln6/KhAc=;
 b=cD048gvLmZhVWjEwzgAdz1bRa9BzkXRD7IPGuRaZplMZ1j8UYpH9b1KwZkKpoHJveYyN29UtDJDe41B2DWnKzCQpBSO8vCx/cSRbKGTmDsvXij9sz4J1AAW03E+GUmCucFTotaZhDSh2Stcg19taB3gpHzAZa+Ay4BDXNW2cA6yHU5/z5DI+5JuZUvb1ed4U9brZkFxjIpdpuWG2DsrvS/h9yGuZLmMZqNpYn+4aCOqkPldecvqAI+XSBVct+t3VzdhvkeZQhDPdzv2G3n0SU7rcNalNwsWrU7Fi8xcrZ9wj9XS1rrRHjLdenY2n2jWEUKBqHLk0t2DfOCAVeLTQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z/K8QodkPshvseCS+ieOpsDmeVm/cbgKBIln6/KhAc=;
 b=F6oqidoxlnda5AFx7QXrZ237OtKnNyShs2dfsg62CGc6GsdLWS1yrvJE2kuU6Gl30JDDyG6TSMWyfBNZd0w6YjBiwiAcsT6UbH7NkNynCQ+4Kgt1nixz7JKEFwtKfqeElo3Xh2gqzrKKWJeFrg1PCssUWSs+RSFOgMsq8yhNTmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 19:36:39 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 14 Feb 2025
 19:36:38 +0000
Message-ID: <ef4e438a-ae10-4757-90ad-642fcb2dc8d6@amd.com>
Date: Fri, 14 Feb 2025 13:36:35 -0600
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-7-terry.bowman@amd.com>
 <67abea44d80f3_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
In-Reply-To: <67abea44d80f3_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0018.prod.exchangelabs.com (2603:10b6:805:b6::31)
 To DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 874563ee-3d48-4a72-467e-08dd4d2ee670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0pZSkVRQ1FDZGZIL20vMkFPSmxjcE1PZUNnenVDdm82NGVoTHhwQTJxTUNL?=
 =?utf-8?B?Znk1QjdJMlZ3OW1IanBwWm1lOTduYmFpZ0VVa2lDK3ZlUVFTSlpsV1IwYmNG?=
 =?utf-8?B?YzBucVo0ZGg3aExPcnZNT1Z3M0xxZ2tkUUhDTzI0Q0s4Vm1oY00wYTJOT0V5?=
 =?utf-8?B?N2dpN3hVSmcxOUtQVHVnaGU2QmhuZlY1L2RiY2oxQk1CU2dSSDBzVmo1cG01?=
 =?utf-8?B?dXcvdWZSWW45ejFYdTlyZzFzc0tCSmlIUmVPR2xVbGxxU05GQ2IzZ0IwTWxy?=
 =?utf-8?B?UVlGWVZ2ZDJVcllBaVc1UENJTERoR1cveVpENUU1YldIOE95ZnlsbW4rLzEx?=
 =?utf-8?B?anZXWVJpNVB3ZnpkM0RQU0tCOWZFZXFrVG1RWmJ4ZWY4UlIxOXpmRXVqSGNO?=
 =?utf-8?B?czZtWG1XZUFWZHMydGI1c3kvbURNT1N5bWVhcUs1cGRscXVQYlVpSzQ2TXZY?=
 =?utf-8?B?M1hmYit5L2E3ZEJqeXYxTWRtTm5sRUg5MjdiRjMyWTk3bkVwcEZnSnRxMmx3?=
 =?utf-8?B?OTNvdm8xeVhQbnhlSmJTOWVuYkpjZU0zbE9PdHhaZ0hRS0VKNkNCNjFPakNF?=
 =?utf-8?B?QmZHWnFsM3ZMQ2ZGckNSOFNMMDRmK0xVS1RCZ0FwNFU1QnBrSDZPRHZTYkxZ?=
 =?utf-8?B?ZHZaZ1AvQzdEeURBcndsNjZUaGFDcy9VL1RWQ1pUanRSQWNBVlJCWmlUSG1T?=
 =?utf-8?B?eS9HcEp1MS90MGZRMVRIWS9OcDRFemJvN2tPNGd6K0xnU2tkc05VTHpYaXdl?=
 =?utf-8?B?SXVabFBvbzQyVC96NWVYWUZOT2duVEt2VEgxL0w1czF2Nk5tRytNVVViUTNF?=
 =?utf-8?B?cDF6TVVldjg4dUZjeXFSd2krOTVlU2lHMGpBMHkzZGZiMFAwNzJrMHQ5L0Vu?=
 =?utf-8?B?RU5qMUgvRUNJUnptSXdjUWcyT1VkMHZtU21UazdVNjBxaFZWelk3cmpHVFJC?=
 =?utf-8?B?VXAyTmlMNlF3Sk9pZWhTb1pZYWhwSldKSlEwVjErbkZISTRqQXk1NHVVTjFt?=
 =?utf-8?B?WG02L09jSUV1eW5vTEtPblZqdlJTWUhneGQwYzVFTzJoTk1hSWo5RGd2eFp5?=
 =?utf-8?B?WUk5ajkwWEk5SjBJOXJ2ZmRiZjF4NWRncktxeGxYTUtFSWhLeCtXR0pGVzBZ?=
 =?utf-8?B?c216SlJ1NnVaTHYzNmJtNElLeHQ5RFN4QkJqOHU2U2JZSytMRE1tSmtuOWtJ?=
 =?utf-8?B?dVhrVCtBNTR0KzdXTkNFLy9sMk1zQ25lMi9MTTFoQzVPWEZoM01JTG1aZmhz?=
 =?utf-8?B?bHh5OG5IZkdKdFBxYXRTdFlaV0xSaDFSNDd3c21EclFDNWErVi90TTFWOHQw?=
 =?utf-8?B?UWZZelJyRGw1dWNWeW5teEJVK24rc20rcjBvWHZKRFMrdUJNYzlWOHkwOEVK?=
 =?utf-8?B?a0xaSXFTUFdRZDdIMXpnMzhXc0NSeGVNWkFZVC9XU0plbXBMWlJ3R1greGNK?=
 =?utf-8?B?aDhHaERoaWlwTm9HNmpDaUhwcGErNS9DMi92RUx4cU1uaFdGQUhkUkVHaWFu?=
 =?utf-8?B?REt1LzBiZFcvTVNJZjBOa2pNSUZjZzhLbkRpRi9mdGdrenU0Zm93L0ExQ1M0?=
 =?utf-8?B?YUhNdnE3Z0FDVW8raXZLNC90TzhkZ3AyeFZWNWdQU2lFbmgzakJLZ0hQMS84?=
 =?utf-8?B?dnkxUUR2alRwYVN3QWxYdnFuSzYwYTg4NUtnQWFqMW4veTNYRytrMW9uTEk2?=
 =?utf-8?B?ZTBWNlVncktPbGRHdGxNVzMyN05nQnp1SzlxQTgxZndtQjQzd3hzNU9VL05n?=
 =?utf-8?B?NlpaMVFPZkh0NGs1RTZUMVhodWc0WGtCb0R5UERmVGZwRnN1dG8yRWZtR2Fr?=
 =?utf-8?B?ZlhOL1BlZEtUenkySDg2dFovV3hneTRXVE0xMTFKV08zNzlHVW14WXVKcUtp?=
 =?utf-8?B?RmRKa29zSkc5T0d1SHVNYVZ3eWhYcVFWTEQxaDREWFp0N2lBZkJwaHJHUHEw?=
 =?utf-8?Q?ELa0BOPPz3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFMTFI3UEZjbDEwUVJUTHRWTm02NWcxT2hYbmE1NUZJZFhncWszd3JweUt6?=
 =?utf-8?B?OHdhV0lvbWN2bkpOcFh1U2JEVkRmMThwVVowM0xIL21MZ0RjaFhwVXhCdUZ5?=
 =?utf-8?B?ZTdiWWQxSk1qZjRuNXZ1S0N4QTNUWkl4S3FkSHcyaXVyK3dwbWRGMWpzcmpp?=
 =?utf-8?B?d2dYS1N0MFRNMzV4SG1VYWFQRDl0b0tYTm02UTFGU3pZSWhYODRaZVBZTE1s?=
 =?utf-8?B?cHoralFNMXQwUlpCNDlyNitPbmV2WkdtVXg2V2tRZndYTlNNeUtzK2RUa2d5?=
 =?utf-8?B?YVlsV0lJdzF4VEdlajJNeFpzSVVIUHBhWVVGNm9vVnFnWjFEdWlaY2VqQzd3?=
 =?utf-8?B?bnhIUEgxaUoxVlowWkloYUhSditib3QrVDlzRCtkYytUaEwxTVJERlFpaWxR?=
 =?utf-8?B?eWhvanZkSTFjNkVOYUpORzFsSWlneCtmb1VyRFdKYTk2YW1TemN4bUJ2K0tz?=
 =?utf-8?B?Um9TOGZTN2hibkZ5ZTEwQTc1S1N6RnhyM28xYUh2dld2L2dBTjd4bjY1elMr?=
 =?utf-8?B?ZExXcFg2SS8yVDhXNTlCZVN2MEhaYklzZFZwZVUveUpFU1pSOWVOTUVCU0hi?=
 =?utf-8?B?bW5oR3BwWVNuSVhiRmpyMXBGcVJGVlJFQW9GWTFBa0JqZ2QvL3l0K0h3VVV4?=
 =?utf-8?B?R201NklYVGkxMnN6Qi8wRjlidXFZQ2VtUE9iZmhmSFRnUE9EWWNnOHJyY3Fv?=
 =?utf-8?B?akdtTnNpZDNCMjRDdUs0bElvYVUvSDFaZnNhbnNmS3M3a3FaRFowREw0dXdx?=
 =?utf-8?B?TURuNzUxcXB4SmxpT0c4SWNJN29PVGl6eEVraVd2SzFURG1kTUJNUk0vQWJZ?=
 =?utf-8?B?S01zckFEYThOclppMTIrbWhvemlVaUU2ak5KZm9mZUgzSVJQeVNtV2RIQWRy?=
 =?utf-8?B?QkM4N1lDV0wwUmw3VFRKTnJRZklFbERZUjZNOTNIckNJU1JTL29uMk8yeTQ1?=
 =?utf-8?B?U3JsR3ppUENvanU2TS93QUNwUEtIZGRueDRqUEE3ekFUNFhIb3ZlaHIwWXl6?=
 =?utf-8?B?S0Q3bHBrWktYMlEyVDZuU2Z2S0p2Q3VMZlRsdkFvS2dGcm41aWdMUno1MXFH?=
 =?utf-8?B?Rmw1NVFxZkJRVHRpTmlmRVNXKzlOOUJNWWczR3RFc241c3VqR0xpYVh2U2Js?=
 =?utf-8?B?empQUmg4VkY5bERJc2xxZHJYY3lJYXgvZm04a21rQy9xd1B3UUh2ZUcxZndk?=
 =?utf-8?B?UU9maFloT1pBMUt6aTRyVGVSTFlPMWdNWEZ0eVNXTEZUVEVpNHZOUzA5VVZo?=
 =?utf-8?B?cFNMRU5FQjA3azN5Vk9vVDVUbHNtcjlVQ3RNZjBndXdTUlVlMUtENkdzeFZv?=
 =?utf-8?B?TFBXTVNUeFZ0cFVFT0VDYkZDVzdRRG1SRDhnaUwvc2N0OWZtbGRlSEg5eDhF?=
 =?utf-8?B?NDFQLzI4bDRCaXRFSnVTWklmbk1JK1N2RWNmd2FXMTRnNmFZOWd2dXdRSUZN?=
 =?utf-8?B?V25QYnZJcmVqMUtxN2h5R0ovOHc2bVN6dlFoZlJ4SkEwTmdtMlRnU0R0amtN?=
 =?utf-8?B?Ung1YWhVNFd4OWF0TElXd0dHYVVpbUN5czNuUXJLVVFOOFhVa21nQmtvWW5Y?=
 =?utf-8?B?akRaeEZRbTRkN09rNmk4cmVOVjNpUUg4dTZpZmlzdUFBemxHNlFiS0tURVFV?=
 =?utf-8?B?d2tsdWl6MlV5T0xMY2pINlhNREh3bkV4bkJRODM5a0lRWVZERWEyV09iSkJ6?=
 =?utf-8?B?OGtOalIrcklFd1Yyd3lBUkMwSGhQR0UrVTduczkyMVBzWllvQVhkaS9wZ254?=
 =?utf-8?B?VGN4blQ1a2pmR2I0a21rV0lSNzdIYXd0ZWVMYWlqR0R2UXpGYmR1bHJUUlc0?=
 =?utf-8?B?M2pBQlZ2RXJOR3hVMFRVeVgvSHVkK1MzVyt5QkQ2L1RJYWtxb3FQbThTbjNG?=
 =?utf-8?B?ZkhDU01Td2hzWW13TVZMOFZQTmtsZ0JtK0U0RGJENG1oVnQwM2pmQTdhUktP?=
 =?utf-8?B?bXN5WnZMOXBCMnpWT2FrZTVZODZPcUd1WVRXTVJiSlVKTnkyOEVVMGxIN3BT?=
 =?utf-8?B?OVNXZ3YxQ3VPY0o3YmNQV1ppcXY2UVl6T0VBdlB3cUhtZjJka01Pa2pBZDRI?=
 =?utf-8?B?b2hqSEV2VmMxdm15Y0VFSHdiOFNrR1RhQ0FoZWJQQ2swdUo0cGl5OEJxcmZU?=
 =?utf-8?Q?r3j507uDP/yq/OQS7I/Mk2w4X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874563ee-3d48-4a72-467e-08dd4d2ee670
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:36:38.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXdNxp8hMvgSw5xJaJwDyW095QzzSUYhL5m64YfI/zo0qU0e4xLJMqAiLkb2/yAbuER3hq24nMlnkhAWjimI8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079



On 2/11/2025 6:24 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
>> apply to CXL devices. Recovery can not be used for CXL devices because of
>> potential corruption on what can be system memory. Also, current PCIe UCE
>> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
>> does not begin at the RP/DSP but begins at the first downstream device.
>> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
>> CXL recovery is needed because of the different handling requirements
>>
>> Add a new function, cxl_do_recovery() using the following.
>>
>> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
>> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
>> will begin iteration at the RP or DSP rather than beginning at the
>> first downstream device.
>>
>> pci_walk_bridge() is candidate to possibly reuse cxl_walk_bridge() but
>> needs further investigation. This will be left for future improvement
>> to make the CXL and PCI handling paths more common.
>>
>> Add cxl_report_error_detected() as an analog to report_error_detected().
>> It will call pci_driver::cxl_err_handlers for each iterated downstream
>> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
>> indicating if there was a UCE error detected during handling.
>>
>> cxl_do_recovery() uses the status from cxl_report_error_detected() to
>> determine how to proceed. Non-fatal CXL UCE errors will be treated as
>> fatal. If a UCE was present during handling then cxl_do_recovery()
>> will kernel panic.
> For what this is:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
> ...and perhaps it addresses my concern on the prior patch that
> ->error_detected() is responsible for the safety of checking that in
> fact a CXL internal error / UCE was detected.
Thanks Dan

