Return-Path: <linux-pci+bounces-26661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F57A9A26E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 08:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D864217A32E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1B1DD9AB;
	Thu, 24 Apr 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MfKywKDD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D471B4F1F;
	Thu, 24 Apr 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476750; cv=fail; b=lOOJz9SAFZ83VHXZkonTYuMOn/qRMNRC9EErD8oyYVj53Pf7o+TW0+X4KO5KFUEOjA8k4PjNfwtd1KesUW7EjKpdqiAE3ioGVG2DOI01hJNFXTkWbb2Wp6KGJcF5ST+Jpl+BTDF+ZOOMk5qqu6Egs6S+SsZbZlZSRD50OKll0g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476750; c=relaxed/simple;
	bh=YQaZBg/njmOlfnRoRgtPvYtCmDRlTniqf0H10FAurcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A8+xkUtQ0M2Kj2S5Wu99XIn7tmo9qmTpVxfA/qJarf/E/OGpARZkU5hWt/eU6w1Kdbv628tcnjPtdAVxW/CIjMVWy0aE4wpNqIj5DNG14n2z6mb/P2Ri/1zA8wvstfRQNtrksY8181chzpQAanPOqNUkNALbFtnvlG1oyaisyLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MfKywKDD; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlZlWNtaoCDZFGamBX2zYpUGrmrU5nDjhpDn1y9cAkmrLP7LfBnB0h9PwN3+m4ofyhXJVOfBSuC5nz/133Hw0pKLkUDF3OAexGCxO/2zBXWBaieKRXdBkiarq3muP/LaKx0nBhUKPbisqEG5XFUQJro3kSNO2FIbvK39dJW1O93auu3w5tTq7BEeFxbBubhYmkm5kHDapeHC+DM4Pp60X0wUHjJukI3yc6zJ2Gzyx7eeMjSgTddrJwmQbYo3urqJKPrJdXotqEundrfWn2MNXG2omH8DM6wTrX5qSoTIR7b0c8TPKTNBNtYOgJGr4l6FjjN3ObNg1trMS55vTqPhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP9Jg4hOm4Mv4dbLJunui5022D+xDqbUwdlYwjd8848=;
 b=UioNGwO1OnxIt/RfYk2FUaCot7JcKEUMX2ZXXckIJGVqxAphuGZQ9qpKa9OjgFKe+mlLnjBZoAxuvcyAcDa6h5/ljEf5v98KauxaCN/429xuXh29rsxswtZawIhAeS2PzG1xZ45QwgEXha4nChP/gfci3wSGK+GNvUNNwUwrHuzJU1pU/zPxvaPzsY5Q5OVyCvR20f7QEZpohDRjXww2NU5FXk1BH9fu0eYBjVJIzO4Xk6CW+LllSCB8sNzJdr5xc0isIM8TwZ1QUgpcwkzMZWXKF29XE0tgd+m73K8mfGmuGIhN8Cj6IVxU5yfwN4I8hwBc6uf6nP5wPfoPxLsmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP9Jg4hOm4Mv4dbLJunui5022D+xDqbUwdlYwjd8848=;
 b=MfKywKDDCCDu+zjmTHVRCG8LbGeXkT9Kv3Gb9NWryXjrWh+G1uFT8LZWWNC3xrtgNnOvUaGSRowVCU41nfL19AFmgZUCDa+TPHvGIEVuzdkd+Zm/Nlmx1SaUFy053iB8B35EP+dGYXf67pxoS/AxLohbuPpjbvW4VyMGPfK9hoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.22; Thu, 24 Apr 2025 06:39:06 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:39:06 +0000
Message-ID: <8ef5da0e-f857-43a0-8cdf-b69f52b4b93a@amd.com>
Date: Thu, 24 Apr 2025 12:08:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu: Skip PASID validation for devices without PASID
 capability
To: Baolu Lu <baolu.lu@linux.intel.com>, Tushar Dave <tdave@nvidia.com>,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 kevin.tian@intel.com, jgg@nvidia.com, yi.l.liu@intel.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250424020626.945829-1-tdave@nvidia.com>
 <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: f858c8af-9669-4d3b-79fe-08dd82fab5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlZsRW05Q3ZNdml1U1RWbmhEK3FWVFQvN0x6VVJERGxZVkpFL2VkZjcxOXBK?=
 =?utf-8?B?UDNTK1FuSDdoVC9yZ1p3YjBLd1BmMnVkODBVa3hyR05jN1NoWFB6MTF6Nm1P?=
 =?utf-8?B?QTZnMWhwN1Yya0JuSk5hOEJPaW5EKzhaSk9WZ1hoaGhzTTN6TDYzVzV2Q0tV?=
 =?utf-8?B?MU9ONnVRbm5QZ05HWHJpcEVob1pwdWV4TWtZUVpsVE55c0toT3gwN3VTMjBD?=
 =?utf-8?B?aXlFc1ZqRXBuWjEzMVZYeTlSdmpVUFQxWWNVQ2dXV2ZXckxrcGsvY3FIdmZQ?=
 =?utf-8?B?NU1VUStDVktpUEhRaHlMUlFHZ0gvVXlSL29LbUNmdURmT1pRYlBvRWsvU242?=
 =?utf-8?B?S2tpUFJ5RlhEVmhIUU5majZCRE1DbWh3WEcyNS9WeTNTT0JoSEZQSEt1dnAw?=
 =?utf-8?B?Njk2ZWNQSXNWd0NCM0VwRXJQNmpNY3RaWWV1czBJaWVDNXVaVno2aWxXYVhz?=
 =?utf-8?B?dmYySWZ5MkkrSlkzODZOc1JnT1pza25hUURZd0JTd0d2Zm5jVGtlSFF4RXpu?=
 =?utf-8?B?K2hjQkZEaGVPNXJ3d2dtRGZSTHd5MElaUHVZR2JRRC9rVW45NjR0djZ0R3Fa?=
 =?utf-8?B?b3hibGRjbEZoZFZXK2YycURXZnF1TG5aU2JiMFpSZHdxYnpZVEdUTHRray9k?=
 =?utf-8?B?cHd6ZmlxczVEcEhDU2d6cTVFbENGSE1BQm84TmxuemRHWE9OS1dhYnE2Tmlh?=
 =?utf-8?B?V25aWkpTTFp6R1lSUnNld3JvOWtBQkRiYmRIMTZMRmZ1Q1BlSi9COVZWL1Zv?=
 =?utf-8?B?SUpxd3VGVXhydllROFRmaHJZUy9oWElzL09yU0psNS9vVEtMOXpTTVJVSFVQ?=
 =?utf-8?B?d1ZSN3ZKWk1QMUNhc05NSDB0bk5ZR1JOTDRCdHNhMHM4T0Fxa0dGYmxIOVBs?=
 =?utf-8?B?M3RRcWRGRlUwaklIUU1NV1VYT3ZaMSt6Vi90YzZqTEpHM0k0V01tVDVpZXMx?=
 =?utf-8?B?b0x1V00rdGVERHZ2enBtNUVhR0psNnByR0MxKytOQjJqRW1HV1B2b3FvS29y?=
 =?utf-8?B?RWpQUkQ4Mmd0VjYyRm95b2RzZDAwOVg3N2FvZTJkUC8wWm05NktrcG5CM3p3?=
 =?utf-8?B?NXhkZFU4bFVoNGhMSDZpWEJTUWRXWjErR0tMK0FHUzcrY1d5TFpqdGs0U3RR?=
 =?utf-8?B?bUVodExjb0llb0IrNWhNdE11cS95VnpHRGRJTFIrNTBUOEZtOXh2WE1EVUVm?=
 =?utf-8?B?clRLOFNLNGdDcCszVWR0NE9WTXNPRnYyUXhDM2xXTmN3OW1MRUpMdncrZitH?=
 =?utf-8?B?M1p2cFNEeVhmeE00UllrQ2tDV0tvNldKMFk4QUNYK3EwOFdRTXlJUGFoYUc4?=
 =?utf-8?B?WUJzcVhjYjhEQjBBV0JXV3FnZzBnZTF1N2ZiV2ZlMklycWFDKzBsR1dYT1Jr?=
 =?utf-8?B?T0NkSk5FeUx6eldjQUlUcVlNdUlEamVGWkM3eGdVQ3c0U0ROZEIzRUl1Zzlo?=
 =?utf-8?B?WDhHNWVJbC90d1hYd1hTdXlrRXpySWY3akd5dEd0eG9OclNXaDgvTU44NzQr?=
 =?utf-8?B?Rnk0MHVhRHJ2YmU2V3dHdWxLbFBMU0NLdW5CZk9ZM20rYXg5YlNVbFBZVHVP?=
 =?utf-8?B?V3lqd3dCNjlpeksxK295RW83elVEaFkwUG0yT1pIV290RnNuK2RSTjVBM3Ur?=
 =?utf-8?B?UHdmd0d0dHVwb3dweG80ekdFYzBSaHdBamlDdXJjR1hxVFZxRkxEZVRnUWky?=
 =?utf-8?B?OERHVTlZZEF2T24wQisvcGxwWXF0M293MWpOSVdCa2RtYzAyRGd6R1MvNEJ4?=
 =?utf-8?B?UnJtTjlvbEhHbGhrNVZVZVVUbE95NFlhbDFGKzNWM1VqbFZnTmd3eXhQa1NW?=
 =?utf-8?B?RjRoUFRJNkpNSEpBSkljRytGU2EvUjNGM3A1SzRCNC9IRVE5VDdvZURLWHA5?=
 =?utf-8?B?S0hqdkZ6YjdWcXpzU2hXa1pZNHRPNXI0eW54enVKWVNyVjIvWXVHbDI0Uk9I?=
 =?utf-8?B?OFlJMTRuUjNhb3RpQmNPVm9RTUNsZjBva2hmSDNzcXNmVy8vWCtwdkxpWW1q?=
 =?utf-8?B?RzV5Q1hNNGFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K010TXdxcGpENUp6YkdGK1kvcWlaM3dkdFcyUGxYVnB6TTMxR0ZOUURDRFVZ?=
 =?utf-8?B?aTB3QUV6RVBubjNNOU1FeEE1QTN1UHhMcEdTRE9jNkxoVUNsUGYvNUkyc1BQ?=
 =?utf-8?B?YkpVK3ZuWDlWTDFPclNRays3Qi8yNlBLdmNreCtmaDVGZkZyZUlmY3RuT2hI?=
 =?utf-8?B?VlREQTd3VHQzZGphbFVrTktzTFlIZjdyZjNDdG4rM01ndElqUjNaL1dxd2xh?=
 =?utf-8?B?ZU1WWjcwRjBBMWc4Uk1QaTR0eGVsNkNlUTVqSnMvdittRnpEUnJrZlpwVzgr?=
 =?utf-8?B?cFBrT3BmODRKOE92d0RXWHh3R0J3clBiL0RwUFpTSnduakgwYmNBK1hpU0xl?=
 =?utf-8?B?R3dlc1A4aDY5MkFHZGJaWVVxRS9uSmNGdmpxeDNzYjFYZmphRjN3eEFYZERp?=
 =?utf-8?B?dUJYQjRpKzBQV3FPNkx5eW5GZExwejRPMnlCc2hia3RXRzdtUWFVTXdDVDVs?=
 =?utf-8?B?dngzR3FRYlhzeW5MeHI2Tk5YdmlleFByVlFPWWRPbXpHd1l5MVhJdGY1QndO?=
 =?utf-8?B?Ni94SGI0ZUw4WUNTRlRRbG1UbmFWSDJENy9ueXFjSklycjlsY1JHeW9paXFB?=
 =?utf-8?B?dHJvOHROdUorTjI5QTM5SU5LbGJzQksvQUhSRzdkZS8zQ1JHWW8yUlZtbGNR?=
 =?utf-8?B?a2tqZ21WQU1sY0Q4T2NCM3lqVndoL0RQUmlmQ1BudEo1enN0bDJnSHhPL3Jy?=
 =?utf-8?B?VWNqR2tnbzJ4anFwR1hseGdXS3BmalFIenpJSjFQVDFPRGNoYUsyd0lnaHRZ?=
 =?utf-8?B?SWNlMUtuMnQxOFpDQUNRaTBLWm9pU3RkV09CTXF5TTV1dkZCSDdYQ2RramZ6?=
 =?utf-8?B?UjI3Z1ZRT2tKNWhVLzFRVTUzaXprUEhrQStrWU9iR2xkK0dZTStQYjVKYWxJ?=
 =?utf-8?B?aHdZS0xLSGFqcTZkcXVxUExsb1M5ZlJTYkx4cTlWUTkvcHVJQnBuWGFzeE9W?=
 =?utf-8?B?M2NvSStyWUJLY2o5RVFaV3BTcGdERDdXdUpkRG5qVENpbHo4bVVRRHl2UmlH?=
 =?utf-8?B?a1dhc2hsUnJWZEwzV0s1Vy95WUp2N2ZWNFN3eURmL1RBVDV4TFdPOFdIZzR6?=
 =?utf-8?B?L1FoRVVqOXZzUmlzNEtkTTVSNHRpS3Bxb0ZQNjNxRnMyclRVaVRRQ1NWekox?=
 =?utf-8?B?cnJHakI3MkZCUlE0dVJ6bUZVeDhNSlVlTldoWEtnWlc3azI0UWM4Zm9EdDFw?=
 =?utf-8?B?cldrRmd1cDhNcDd4M0tVVC9SNElFNUVYZFFYMjFQam1Dd3lqcU9YeC9iVmts?=
 =?utf-8?B?SU5hb2RNelJ3aWpZaUFQdjhNcDU5NG9wbWFBSDNwZ1dnbnI4ZU1MQnM0UlNu?=
 =?utf-8?B?SkQ1MjNvYXRaVm41K252Vnk2SFJBVnQrYzhrcTNtSEJWejc5THlFT2ZNOFdr?=
 =?utf-8?B?dnQzTjk1T1p3M3NHVmN1Y1c0TXRpYks5aUZkVU82Mi9nMHhza01CZDlmLzY4?=
 =?utf-8?B?WjljNzl2WHJrakx4SG5nUkhWK1BYbjhnVC9ZRFpTTFFURU9vQXE5Q3pLcGhs?=
 =?utf-8?B?Mit4TGxHMWQ2Nm8weGxieHJlTWdmblRDeWs3SUlGcHAvbWdtSUhFZkxXdlhs?=
 =?utf-8?B?MTBsdHlnVndLVUpqSDhSTExOekZxSE1yUlFvVDZ2emxsaUF5MlNwQTQ4cUNT?=
 =?utf-8?B?QlFmeEo3RVhFOVJCUExKak1zQ242SHRVTHFEMzJLK3lJRjdLdlNJcXFzUXRU?=
 =?utf-8?B?SkxGMlNNNm4wcVBMRjdUblo3ZHh2b0RRbjlQbTB4RmppQTQzRnowYk0vVUxm?=
 =?utf-8?B?dDhHQ2p4NmkxN0FzTUhQSnBJMWtEdHRLWWU0L21ScnhtMkU4elNLbXFzalVB?=
 =?utf-8?B?MEkwdnpUc1VvdUhqbXV3dXVtUkRvbkI0YlR6SDNXeG5UZGF4L05aMkRvVzJK?=
 =?utf-8?B?QTFzT0FVOE1tYVFqMWhleVMvNy81Z2lyWmlTWnA2S3JJbXRiMFRJWEc2UzNr?=
 =?utf-8?B?aFFiY21HSGE0LzVIZ3ozS3FiYU5rSHRSWVBEUG9YcjRRdTRTTDlLYjBQQS9F?=
 =?utf-8?B?RG91ZUhmQklsd0YyQjVCWUxaZnkyRkFYbTJ0em03ck0zWk1RQURicmI5dzFm?=
 =?utf-8?B?UUMvMFFxWmRpT0UxY0Rzc2hpWG5LMnk3NjlNU3hqTnVWSkZaSjhFOURCZkJ6?=
 =?utf-8?Q?4PMJUSMBUhWC1zcm6Qiw+uyVS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f858c8af-9669-4d3b-79fe-08dd82fab5e6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:39:06.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TynGhLXeb1V0y0fDnKyZVBKX4xD8PZi3bKjpGaY/mcjfdvooeAvFO6dK4HLrliZizfCMUuVsnfOvFu81GFbQeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

On 4/24/2025 8:57 AM, Baolu Lu wrote:
> On 4/24/25 10:06, Tushar Dave wrote:
>> Generally PASID support requires ACS settings that usually create
>> single device groups, but there are some niche cases where we can get
>> multi-device groups and still have working PASID support. The primary
>> issue is that PCI switches are not required to treat PASID tagged TLPs
>> specially so appropriate ACS settings are required to route all TLPs to
>> the host bridge if PASID is going to work properly.
>>
>> pci_enable_pasid() does check that each device that will use PASID has
>> the proper ACS settings to achieve this routing.
>>
>> However, no-PASID devices can be combined with PASID capable devices
>> within the same topology using non-uniform ACS settings. In this case
>> the no-PASID devices may not have strict route to host ACS flags and
>> end up being grouped with the PASID devices.
>>
>> This configuration fails to allow use of the PASID within the iommu
>> core code which wrongly checks if the no-PASID device supports PASID.
>>
>> Fix this by ignoring no-PASID devices during the PASID validation. They
>> will never issue a PASID TLP anyhow so they can be ignored.
>>
>> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Tushar Dave<tdave@nvidia.com>
>> ---
>>   drivers/iommu/iommu.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 4f91a740c15f..e01df4c3e709 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3440,7 +3440,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>         mutex_lock(&group->mutex);
>>       for_each_group_device(group, device) {
>> -        if (pasid >= device->dev->iommu->max_pasids) {
>> +        /*
>> +         * Skip PASID validation for devices without PASID support
>> +         * (max_pasids = 0). These devices cannot issue transactions
>> +         * with PASID, so they don't affect group's PASID usage.
>> +         */
>> +        if ((device->dev->iommu->max_pasids > 0) &&
>> +            (pasid >= device->dev->iommu->max_pasids)) {
> 
> What the iommu driver should do when set_dev_pasid is called for a non-
> PASID device?

Per device max_pasids check should cover that right?

FYI. One example of such device is some of the AMD GPUs which has both VGA and
audio in same group. while VGA supports PASID, audio is not. This used to work
fine when we had AMD IOMMU PASID specific driver. GPUs stopped using PASIDs in
upstream kernel. So I didn't look into this part in details.

-Vasant


