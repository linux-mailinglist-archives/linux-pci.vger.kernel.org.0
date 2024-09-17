Return-Path: <linux-pci+bounces-13266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 814A797B16F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EF6B28944
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F61411C8;
	Tue, 17 Sep 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ibsVL0bf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A9182;
	Tue, 17 Sep 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583471; cv=fail; b=LZbklaxTZ4Q656mUi8HwujqczF56f2Hriv6FrVcUmAqkJJho8soiSQRbxS5spCFjvMS8uo9yem84yqxPfgSHYHGSyGymM5xQYACE6DUC/e3SoWvtkgu+Ga3ASD3L8e8HMtA4sH5EkJUbl35G2pCz8IR48oIWoy/wovFu0G1c9To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583471; c=relaxed/simple;
	bh=pPtzpR0/CdyWucCDm2FGP0Qij/qz1QcJwIbw+T11zZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DOhWFGmQtQ9h2VWt5be1qaQvE6W9vB+wokwFMCUm2C1GGwaV1q3ge8FKy8FHTOpIUO21X40OracK0ujDNtGAJmnmMt63tKxw0V/ZUhhcr5n2UBFTzDjEIMwVQQZcWHhxl7pJlNYpWik15brxxTt3dtEKMEMw0//mLwnFOJ6MRyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ibsVL0bf; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsNioOzMQJrvcGgnCEfsh++ZK7LJe98Zb8Uv1lrFc+VVvAfrelmIN1SNrP1y1JGmeSjfX+QqVapo1WI3oAbCZXGf7poIKz/obqt9/p53HnT8L5NfZHB7YZmZ9P1NiYG29ZYEku4ouq1g3C/ot4F+ixNOpFkpClE2ffG9X01Rh+u+iBYZMXQY2gCB8j9WNIGxOJq1zyrEGXboYw9bV4mlnYuhs8dx04phSXfOgevHq1OzDOgjdXapzK8cckDO0rThU+9Z4ixmSXxEsd8yJSVqa6Gxioa+zuay2jNLIo5kY0WhnhcH/E6ld9377edYy0a63skhESo2/YQEOoYLjZvuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWSizLoXEcICRxVLVp0zYofHBIxg38azLUM+O25hDGQ=;
 b=tyXkIAnAtKeXlYBZcKgpQ4GKl528boZluoMeX1EclajD2NM7KIenldRvIo6sW4R76TzTKKGxV9OXudxcbQpfRXaovQcL/ahk+J05+aXjbpQFB3V6U6y8ek0s5G0CmKfrHZsDZ+TNmjs2kTy+gGmU0gIySORczErZBfzpaBUlO6C6dRN7o4Y1xWPtb3ovPV+KF8yxdJfshhy05B8NdlzYSpymrnf9e51hFBQOYRS7bvZb2BpN628ndb5r1QYxE2ehxvUiS/XCMka5qWDKQcOIHj+kue8Ygok+FL0DLs2Uuv/z3I6lnc6eXDL2pX+iY0MA4MDML8TQTsuqvXb2fsDfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWSizLoXEcICRxVLVp0zYofHBIxg38azLUM+O25hDGQ=;
 b=ibsVL0bfy+JiL76ML+/N7QtfipeTNgbP0Vq6nVfSQJ0O+GPBBAjTZuU5oR+J+WYxKGBta/J676UHGewfjZKRwV56AaHbbz4uxUTUEFq6wXC3ferPGIvcpJUroUaNmzcYjO4lYY/loqL88+gjNNfJKEg5BUuXOw5CDQLHKCiKzAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 14:31:05 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 14:31:05 +0000
Message-ID: <6efc219d-29e1-4169-8393-c7e4610347cc@amd.com>
Date: Tue, 17 Sep 2024 09:31:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/5] PCI/TPH: Add Steering Tag support
To: Simon Horman <horms@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-3-wei.huang2@amd.com>
 <20240917073215.GH167971@kernel.org>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240917073215.GH167971@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:130::30) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e14c4ce-9fd8-4a4f-01c7-08dcd7255bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTN2eVF2cW4rYm1ETHYvZ3l5TVF4UTVONXdLWW16RVRUWFNtMGVOeTFHemtl?=
 =?utf-8?B?SzdvWTV1c1Q5QjJBajRINXhseUdZazJaNjByNkkvQnEyRUlnSFF4YXBGZDhL?=
 =?utf-8?B?WStVYlVOS3c4eStsc3pPd2JSTXNKVk93UVBhQjd6RkFxNkpRb2VjZFQ0bHVG?=
 =?utf-8?B?OHBtYzlpd2Z4c1MzRXNzSTBQeXNheFJVc0lOZGRwem1rUEcrd0Z1TXlhd0RS?=
 =?utf-8?B?K2dJNk1VeDBob01EaEVzd0wxUTNQUDBOUzM1ajRFYkdjQU0yb3J1dmhka1Qx?=
 =?utf-8?B?V0c3S01rSDI4S0hGTDBiaGo3cktkaDBvU004OFBIZW5uNGN1VWxRZ0RDbG56?=
 =?utf-8?B?VlZhNC9kR1JYOGpHMm0zNTdCRUp3aG5Rd0lqNXpEZlhtdWNScHZtdFJDbWlT?=
 =?utf-8?B?bXMyckVlYWk5SnkyVGM5d3g0Q2pRYjVvZmhLQmNRK0p3UFppMUFuS2VyQ1BC?=
 =?utf-8?B?d0RuWlhJMThkcEdvRFZocEdsSnRFaVV3YUNGRzBnUkJoNmtsVFJ6d0piOGp0?=
 =?utf-8?B?V1p5OUUzTUdOV0VoOUlTZWRwaXlic29vOUVMSW1qOG1RQlBFT1F3VVBhUGpQ?=
 =?utf-8?B?aUhKdlVJWXR6dExWeHIvbnR4OXZ1My9ZYzJ1b0xvQzhsUU96NXVhM0FSSGlx?=
 =?utf-8?B?SC90dzdsb0d0a21UZ3Yrcm9kM3pDQld1SkkwYmNwZTZja0NUS2hiK0E4QXI1?=
 =?utf-8?B?SDJxRG5wa1RMSEo4aVdmbmg5QzUxSWxPdEJCSTV6VFJGbkh2eElRU1BsdzIr?=
 =?utf-8?B?dmpSWEF0QS9zSjh2THRnbDVEODB4NzJBZWt5cGlVRVM2Mm96QWg2TDJvbllN?=
 =?utf-8?B?Q0svWFZLSVRIT1NicmFBUFlUM0hRVWpOVk9lK0p1MWJ4eFQ5VXVzUDFyRjhG?=
 =?utf-8?B?cG1MRUc5N3N1MnJDZmpadXA0UnRMRGR1Y3FxelNrTTVCYytBTERIdXZzbjNH?=
 =?utf-8?B?Y3VpL3VrMllEc3VqTVFZeTNJaEZzU0I2bnNHMHBMVk5ZMWdUZWs2dWN0M2N6?=
 =?utf-8?B?cXdXQWdnL1lzeXVmdXpmR21tNUlHYmhRU3lRMEdYWEVvemNxdGxqVzB5ckhM?=
 =?utf-8?B?QjhZLzd6TmIyOWZzOG9OR0NVSkE3RVZ0WEx2YjA0L1QraC84aGZ1SmwzcTVr?=
 =?utf-8?B?OU9EbFBUZm9OREk2ano1d2NmNG5hNHU4K1BVZVZzdUJka3lzR0ZCaWVMZmFO?=
 =?utf-8?B?QjRrczhwd0tiMkVqVXpBYzBuRitpY2RtSFpGMVAraG1hOFErMHU2ZjQydndY?=
 =?utf-8?B?MVVFZHVqUEF0cFpVemh6TG1VL2ltbmd4b3BDNXRCVklKWENTSnF1UE1YZWNV?=
 =?utf-8?B?WFk2Umh3U2xrUGs0UjRhZG1nRWdXWnZvQ1lHQmhzayt2S3BzWVpXQksxQlVw?=
 =?utf-8?B?akRJUjR0RjRwRnpCWTRtK3FiL3dZNzZDVlM5eWJZSzRhRjYyTlBrOUF4L2pY?=
 =?utf-8?B?YmFsY2hFbDlQNDA3bFBPTG9DZEtOVHVCaE5nSXNTWm9jLzA0b0lZeEFUdmRB?=
 =?utf-8?B?UWFxQ3ArTzd5aDJpak51RmFoZC85MXFoMHA0aW4vaVdIdGdySXVEbXpqKzJP?=
 =?utf-8?B?Z2k0MmxpNllGeTkzRTdKMHNGRFpyMkNXQ2hwa2RZWDhhRUI1WG43YlB3QVla?=
 =?utf-8?B?WUh1TGFzSEZ6ZXFnKzdTbHJLTWw1Z2VqRUxEYWEvUjVjWGdDbnRZS0orbFd6?=
 =?utf-8?B?TG5rVUh5R0xNV2JIZENHK09zbUdLcDNRSHcxUCsyaXJjTlFtTGRQQkNKSGF6?=
 =?utf-8?B?UERYU1ZRN29WT0xlN0tWeVlIZFlyZzBQaWtwa3ZXRGdIUVAyQnR2TXdnM0l2?=
 =?utf-8?B?OVMvc1o2RnRrSlk2TVMxdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amF6Rkc1K1BmaUVsbE5FNDNhdU9DL2hOS2x6ZXlRWnEyekdJampRRWU2VzRh?=
 =?utf-8?B?bnVhai8vVmJkT0NiSlB6VDZQR0NVQ21Eb3dqV0xtSkpiTlRMSC9CTjdxQVh6?=
 =?utf-8?B?UnNWc1ZLT2VkSTgxcFhvaFkyU2lRc24yb0thVFZTc1J3RDdCblJML2dpODFB?=
 =?utf-8?B?cVl5dkpIdGI5R1hJSHdTOVVDSmFVRTV5YXBhQnEzNzNXbU9xTFNrN1dCWFdt?=
 =?utf-8?B?OWV2Q1REUTY5dHdoL0Y0SnZjNkh5QjdRcWVNQUtxVkQyVkNBdXY0YllYYmFO?=
 =?utf-8?B?akgrTytZaGNzcjQrWlF6Tiszc2RCV1hHcVpTTjFYYVBnWDZqdVFFSTBRS3Vj?=
 =?utf-8?B?MWR5SjFMaU1kRjdlNm95bWFiajJhaVhWODYxRnRJWmo3emw1OEhVa1VxMzc1?=
 =?utf-8?B?d1N5a2IxalRXMDRCbDZjS1ZGekw2c2NGeEdTMnljc1gwOTdrWVgzMndDdG1V?=
 =?utf-8?B?YXRBczRaS3RUMkw0emh2K3VkclR2am81TE53a1diOTRBL2tna1dIQWU3YXFB?=
 =?utf-8?B?NE9TekFLcnpYY2lCS25ybnNNOTFCSjN0MXpnMVpZd3JaM3R3Q3FNek9yaVVs?=
 =?utf-8?B?Ri9mMWNXLzFmMktXSlpEWGNlUmV6L3hvVFBxcDFvMzZiY0RqWWZBRFFwNUlZ?=
 =?utf-8?B?OTNZYTNVZ2RET3Baa1pWRGZUaTFuK3NFV2VDMUgxR3NGUlFkRnNCM3piVjQ4?=
 =?utf-8?B?eXllcW9sVjZNR0xhVW94R3JQWFVEcUVMQjVOOFkxOU9RdHZKZm85MS82NzJW?=
 =?utf-8?B?ODFnWUI5dDBweDkzM3JGOWczRStEV2EvS0cyaWpuNklvY0FKMGhIa01ORHor?=
 =?utf-8?B?QU1zSHdDNTdoOEVrMU5GbjNtSFk1bitCSEJyeXBzZ0NZN3FQWU1sb1FGVlAr?=
 =?utf-8?B?YUxlSjNQZHVwaDkrRWprMUtKb3ZDL0pEaVdkcjdidWJFTS9nbWxHalV5UVFm?=
 =?utf-8?B?djd4KzNXZDJYRFBhZnhRYk1tZFBUcHA1RFBaTzlKQ3VIYUlLbU8rSUhCK1d6?=
 =?utf-8?B?VkNCL1praUNYTURGLytZcmoyYUQxUTFEaVdrVVlwWll2WjVpQlMraEs0d0N3?=
 =?utf-8?B?Tlc5akNsVmpUOW9XZG53OWxhLzB1NVFYWmw2V2JVaHZmNGhCUFdHLzM3VmV6?=
 =?utf-8?B?RmNGbUw3b1NncGFweEhoSHl4bktWa3NzNmlXeGk5RWxSY0JweWVpWm9nTmhO?=
 =?utf-8?B?N0t3K012YXhxRlpBdU1sclZmMHNNKy9ZMnpwZ2lPMXF6RDlNSFU1QURRV09W?=
 =?utf-8?B?K2dKWlFid1o1MCtRck5HOU5ldUxDUWp6SjBJWlR5RmxYWUZlSVNjR1YrL0h2?=
 =?utf-8?B?d2U4djRHb1NONkpSRHNvdEhCQmd0enp2cGs5eWJ0bEFiOUczYTZremI1TlpU?=
 =?utf-8?B?NUt0MVh0UG5KWkJnVUFLL2xVMExHaC9SQ2NxWkp3ZTNlNURWOE9qRzFkZU9q?=
 =?utf-8?B?LzVGaHdjbUdpelJ2ZXpHYWFaWnJSN3N6UUZJQzU2SDArb3NCS0hpa1FXNlpp?=
 =?utf-8?B?VytnenZ3azk5ZkU2b3dTMk9BNUNvcXdlK3MvVE9rclRRVHR3VFp3UVo3dm9x?=
 =?utf-8?B?cEhtQ21Ub082OUE2V3N5a2RCQzFvVytQT2pRTnFCR2p0Tms2ZjFRNDliK2pJ?=
 =?utf-8?B?alZyam1EL1daUVNueThUTFAzNmtsYnNtSFpHc0tEYVdiazkrSDZVRWNEZDJE?=
 =?utf-8?B?SGpCNFpHZmloQy9iOUdtNmptR0h4YklQOG1ORDBsdWU5VWVpSDRHYzNnQjlS?=
 =?utf-8?B?N0d3QVl2T3pGeE13czlYUk1GSGRZbWJsTVYyOUtFUUZobGt3Slc1M1lHZ3dX?=
 =?utf-8?B?aThaNnhOeEloWHBoeGdvQXVKSk9FdjhIZS9iZVJSbU96ZEg1aTMxUzlOUkF4?=
 =?utf-8?B?Rk1tcW5CUnNTM3JQY0paL2RvQjBUbEp5SXNsMUxBZlQ5cUNtcnVsRUpqU0VJ?=
 =?utf-8?B?NWtTVHNCTDQwaDdHRjgzUzhjWi9SN2pkbTEyeHIvYjZjZFhnYktjOUI0eUtz?=
 =?utf-8?B?aERMQmxBTjFXSzNvcitXN2ZrSmhYRjFZZ1lIQlRuMTVZS1cwNFNWenE4bmxP?=
 =?utf-8?B?M0d3ZkN5NzF4V2YyNHVjb3JqdEszbGNqa29vTDhHcHNsSHZZei9PYVNXYTVU?=
 =?utf-8?Q?OcJA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e14c4ce-9fd8-4a4f-01c7-08dcd7255bcf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 14:31:05.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFKG7I4wA05bOI9YwWW3V5q1YNAQiE5O2wKwtQOxhCgLV7AHhPqsPT3x3swa6ir8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250



On 9/17/24 02:32, Simon Horman wrote:
> On Mon, Sep 16, 2024 at 03:51:00PM -0500, Wei Huang wrote:
...
>> +	val = readl(vec_ctrl);
>> +	mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
>> +	val &= ~mask;
>> +	val |= FIELD_PREP(mask, (u32)tag);
> 
> Hi Wei Huang,
> 
> Unfortunately clang-18 (x86_64, allmodconfig, W=1, when applied to net-next)
> complains about this.  I think it is because it expects FIELD_PREP to be
> used with a mask that is a built-in constant.

I thought I fixed it, but apparently not enough for clang-18. I will
address this problem, along with other comments from you and Bjorn (if any).

BTW there is another code in drivers/gpu/drm/ using a similar approach.

> 
> drivers/pci/pcie/tph.c:232:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>   232 |         val |= FIELD_PREP(mask, (u32)tag);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
>   115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
>    72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>    73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
>       |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    74 |                                  _pfx "type of reg too small for mask"); \
>       |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> ././include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
>   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
>   498 |         __compiletime_assert(condition, msg, prefix, suffix)
>       |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
>   490 |                 if (!(condition))                                       \
>       |                       ^~~~~~~~~
> 1 warning generated.
> 
>> +	writel(val, vec_ctrl);
>> +
>> +	/* Read back to flush the update */
>> +	val = readl(vec_ctrl);
>> +
>> +err_out:
>> +	msi_unlock_descs(&pdev->dev);
>> +	return err;
>> +}
> 
> ...

