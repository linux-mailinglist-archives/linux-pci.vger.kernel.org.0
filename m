Return-Path: <linux-pci+bounces-44003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3ABCF3981
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAF2F3009D59
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59A33A6EB;
	Mon,  5 Jan 2026 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1JVNGre"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765533A6E6;
	Mon,  5 Jan 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614005; cv=fail; b=Mv5DQRP9mnESmxsmq9d7XbT863KRuaSXTkkYV/0WjakzqVoXwsjuc6CHuejV/KPy4pW9XGhocRL0zy41/6jF6dAUD1IaIT7gdFzDvuT4f0WuIYoHs8NAwDjrbaIIZBqVNvn1nUVt4tlLgb9K3G1o0bGh5bp6XQlPmWqG6GVPRUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614005; c=relaxed/simple;
	bh=wPi7QJVASOVMgzG6cS92A5TMDwpEgtlnBBCS/GuHAYw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F53Ih5IUvnX4LWjcpDVtfacySUZeD6jxmFLy505GwQwnKg9M8AwOPdN5SfaMP3wFt0C8bZfzCyGcv1PhdkvhEU03WASgEtic/axMRpWCWI706bwmLu5Su52prOdjS3pdCIQllxTTXFf4zYIXHRhTpNdujn4wQwQu9Pk/T7xW24Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C1JVNGre; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLBB694VPv5X98qrGz/VwKHQYcW/RlmIynopPTw/xPIS0vnBdBDLKTvvxsnHHOluGZe8siF9WSItfSPSnUPqLppfuvILsxoOlVe8BjyFgAYd/SxA4vljAZY8G3igrYiOCMBHO0MLo1kJAq/ScGBfZgeM7K/Z+TstpR8tMZHJ5C47KHI4W8QvGjJ7ymD48N7UuId2TbIIimV+4+6yadgBWkcIyjQXIhtX8Sm9lkPuYqfLyx4bpecqwRxFAquWylJMihwW6GhBqw87hwP2WSX1RF8a1mmDgyz3Hof9K2TmJ86CTYx+TfhSGVDtdgjkAtyFXFXX8fe8EAHFEVwUAtP3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3m8hS0gfIV4dW8lUGv0yJw84O8GaIOkj79NryMdVxU=;
 b=kSVqOJ8a5/Sw0zmwZNpz/wIOeCVme3DV2t0WyfLnjwuiUMMVF2UhaYz5u4cwZ4urp6f/bbe0dZ/0gjnLIqHdJJPtVMfldFgvc58NVyloi36WCn0Aa9pHIdSGyqtNf4+JwFdb8t9RZj7Mq8oC93EgHxzJU2FB9GatuZ4BFBJsi7cUHQzGtfBsTTZ6b4LdFq15U5lZJAiniTY3nyYgn/j71olEBSMY2y5kwXCv6d49qkNgBNitlvhjMPO0qPeNrz6iB/4TG7JLg0EdNCE3E9t9Jmwx1pJrfafLS2Mjw4jbSzv0VgZxWvnbsrDALwPJpDEqcaht9QFgEuAy3NAl/yipDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3m8hS0gfIV4dW8lUGv0yJw84O8GaIOkj79NryMdVxU=;
 b=C1JVNGrelHUwWm5H/9oNV6O+Yi25tDlaU9rDodrqULLr9tcoe3siI3ySWQ6Rva9TQjzfcnDa1iiR6QicGOzSeovOhENr1ety3iiN+WERgE3AsjBLE7M3SbNURj+hG3JNhOCa3TdZT5lGhx1ogq1OID+a0zZ4y5HOJR/F/wYNC6C81xCR6P9aNvXrz3H7B8EOZf3KZ0qeHdcEiEBjhZOqyLo1eDVRZmZLlpcQhalr89yqE8KMDZyZmyiMdhpAb09fDW4Tunto02/8j9czL/lVghsQpffvHz5PIUiixWpjUZwg+seqjMFzTQuoA/cERdwf8gfQ8L2n2Ng0TFMEH8Ls2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Mon, 5 Jan
 2026 11:53:18 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 11:53:18 +0000
Message-ID: <177ac2ce-8710-41e3-b717-6c56867cb779@nvidia.com>
Date: Mon, 5 Jan 2026 11:53:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: tegra194: allow enabling driver on Tegra234
To: Francesco Lavra <flavra@baylibre.com>,
 Manivannan Sadhasivam <mani@kernel.org>, thierry.reding@gmail.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mayank Rana <mayank.rana@oss.qualcomm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shradha Todi <shradha.t@samsung.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Inochi Amaoto <inochiama@gmail.com>, Vidya Sagar <vidyas@nvidia.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-tegra @ vger . kernel . org" <linux-tegra@vger.kernel.org>
References: <20260102190921.3765226-1-flavra@baylibre.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260102190921.3765226-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 925341ba-5d5e-4aca-fe28-08de4c510489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2F6cXh3QnQrS2VBNXNHVkRMVDB0eEdtV09RRi9qbkkyTUxoR2htQWphZ2x5?=
 =?utf-8?B?cDI2N0xhSGRuSW1HTmdaRXkzOHVENU1YY0ZPdTcwOG1vWE0yL3dTRElVR09o?=
 =?utf-8?B?UE1sYTR3OUZyTGpBZHU1L2RaeFNDbjFMOVF1NUlVb25GbmJXOWo3OHpFVzJP?=
 =?utf-8?B?ZDhTbDg4RThnWVJxbWtYTDE4cklndUpYV1FWT2I2RGFyT0FkaUVQbmJLNzM5?=
 =?utf-8?B?MnRBRmhPTmJVNUNvUGpGQkxCWkFrbHM2ZkVEQXN0Q3I1QWV6N0VOR2hVbkw1?=
 =?utf-8?B?b1pOaW10UTdGVE1NS0lvWWxlRXloTW5vbldwQysveFpiaUEwckphdDc1dXcw?=
 =?utf-8?B?RGlHWklTeVRzQ29RSEEvTHFRN05ZcjdpcnlCYkFYcE8rV3F1Vmd6eUE3QkdJ?=
 =?utf-8?B?OC9KK1hRRC8yKzlvZTlaUVhydk1JaTg2NytsbGV3SmFHZE9kR0lTK05BVGFz?=
 =?utf-8?B?eG9aamRjWGRNK3RqUDVmOFA2SzR4YUVTVXNZN0VTcDByc2svSDhDUnl5Rk5Z?=
 =?utf-8?B?QnROZE1MdWJnYWIyMVZ4aFFYT1d3OUlRTFEza2w1Tk5oejYyWHRuNVBqUis5?=
 =?utf-8?B?QTFvWkpuZTRDQlJscjkrTnJkenY4dW5PeXFraXUvQTFpR1QyNFdTenlORW1E?=
 =?utf-8?B?dEhkY1NFVW4zN3RnS1J5RzJuaFlsRVo2aU14cFBWYXJOYnBmTkQyRHV6VUtv?=
 =?utf-8?B?MGxzOFFEY0szSHlSLytLWnFuSE10NXlTekU3YTNqdU4xMndsWHltQUJsZ1VT?=
 =?utf-8?B?QkNrZ2o0a0ZyeUxIWVU4WXpLaGJtcXQ4Mk90aXVkQVhHdlFoYWJtL1A3N1FR?=
 =?utf-8?B?akhZWU1lcDJIK2FZZEI3R0gzNTlDVVVaWUNaV3A0UUs2MVBZYUZDMGg2dXY1?=
 =?utf-8?B?NzVmTC91VFViZWZMcjlCcHpTNnFPdWtkblk2K3UvY2wvMWgrYjg1azY2citm?=
 =?utf-8?B?dlQydFVvRDRib3NGVmhQWGhubk91ZjZzeTh1dmZhQXBJbi9USkUyOWpQS0VM?=
 =?utf-8?B?N2ZITkx1RzlRWEFQQW1pc3lvSDBmanZqakpSQTJJS1VrY1BDNzlYS1NFOWhG?=
 =?utf-8?B?bVJhUGNNVkxERTNidWxRdGlRcFI0YnVhejNhUlVEakZXTkZBTC9QbzRiano3?=
 =?utf-8?B?bmhtRFREeFlEc1pzZ1hvUFdSWWExeUdNNzBVTk9FNkZzUFg3QXdNUmtmSi9C?=
 =?utf-8?B?bTEvcHdHell2L2hTVXl2STNPK0p2MHRiMzMydVBDTjB4ckYyRERjZUFZNGIv?=
 =?utf-8?B?TU5nWGxUNDBMeTB5b0FjNmcxazE0UGFlcXB5WU1nMWx0SStIZU1CWkc0RFlG?=
 =?utf-8?B?QzRmTkhPZzJkajVwcVZNcDRvWjZFekZiM2MvYlhKbzRuSTRSU05oZ2s1S3hZ?=
 =?utf-8?B?WEhpcUJzMC9LQU1GRGx5QjM0MzNJRm5MV09qYVVaMktvR0RPQ0UxaS9hQjZo?=
 =?utf-8?B?MTFqa0hRcVpYdGsySTdEU2QvNGVxK3FRdDlxcHhUQ0w4MHFTU1EzTEZGSUJw?=
 =?utf-8?B?WFd0OWFiVVBzVFZ4YStCK3U0dDU1TmZaYm5IRmJJYWQvdU1oNjFKdmlheE5Q?=
 =?utf-8?B?bXBlWWxZYTlHYnE5VElFWTdvendLYklYeHVKVFZidkhKM1RjcHNXazA5b2tQ?=
 =?utf-8?B?ZUZyVFhJV0JqR3RUT3JhYVk4eXNGc0FJREc2ZDZMVVRQaXJwZXYyazJYcWZj?=
 =?utf-8?B?LzhURG1ra1V1Q1RDSDdsUHFxdmtwTTRVY1ZVbUJ1T0hqZFhkTHVyUTd5cjlx?=
 =?utf-8?B?VW1LWlQ5QWR4N1BkaFhKT05sWXBReEZrd1FVYWdHK3RWMXVudG1TN2JMeU9D?=
 =?utf-8?B?dW1jYnBEVUxwNmtxNGxkYTIwdjMyNGFkc1NoRUFDTGg5UnVEY0FPcG9nbVZX?=
 =?utf-8?B?T1k2ZkovRjBCQXFZcklGS2ZOcVg5Rm9SdVJnTWNvcmVxdWtkUlJndUowbTh3?=
 =?utf-8?B?WHVKZFpla09kWDVxMVEyU3RJazdDc0ZyT0srS2VoOEZicGx3TGozWmZRVlJL?=
 =?utf-8?B?cFIzZVoySTVaazZTUXJLMlNpOW8xY2tObGVqZGh3Ym1GSWlHVXlxZFdNZFZE?=
 =?utf-8?Q?rFi5HS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkQyMHNtbDVEQWFvamZlQVFCdmhDM0ZoZWNhMG4raVFYNVFBZUVpbTllblYy?=
 =?utf-8?B?YllydEljRDhrcWhtL2xkZUFoUW93MTJQVjZmTVRXVEpNdVByRXhSMkZQaXlO?=
 =?utf-8?B?OWFtcGU0YXNaWUlGaGc1TkswTWhzajVxeXRtdTF0MTBBTWY5UTJvd2QxVDVB?=
 =?utf-8?B?d3VWTDdHQUt5RDRpWU96YVZkbnZSTmxMN1gxbkx4Yi9PWnNxeFdlaXQ3enp0?=
 =?utf-8?B?eWxQUldGbzFFNkVGOEVVVW4wTW8rcnZpMDgveHMrckdWVzRDRjZJcjBEVHN6?=
 =?utf-8?B?Vkt1QkY2UGJsTXkxc1kyMkFJdTNaUHl3cm9aU0Q5V0RCLzVnSVF4aS9TTHp5?=
 =?utf-8?B?M1VEVTVqcEovV3ZCY0F2SGhpZTJ5U2lUb1dLN2xTRW90RU1Pc2k3by9RTnNn?=
 =?utf-8?B?RnZxSEx0RUU2RTMxVzdSMmI3NTF3SHJxS244ZktyamFyQW9oTTYrYkFqdTAr?=
 =?utf-8?B?RnlpTFQ5WWJoYUtjMnhvdDI0eWpwYWthUUQ3MXBqTGF6SzEvV0N3ZjBlTDAy?=
 =?utf-8?B?NkVmb05DVDJKUlU0UnZYV0E3SUtjc2Z1SitodGxZWnJSYjZaMlZrSW1jL1l6?=
 =?utf-8?B?anJoMlMzaHloR21lUVNQMlBFOE9waE9CQmVzdFpGWWxCWXd5OGFvYnJ3Vmcr?=
 =?utf-8?B?N2wrcnRlQ0FLRFFqTzlEdjVYMzNkc2pqMWtMMUsrajAyQnpVK29tNUY0MEN1?=
 =?utf-8?B?RmNISVZGbllNc0tsbGhBajFuTysvUVd2dzNFc3R1dUJKYkdLSTZCTnlNYnV3?=
 =?utf-8?B?NzkzTEhjclB0UVl2ci9lb0FJUEp1R1pwUEI5QjVDOWVHWVNGL3REWWt0a0lj?=
 =?utf-8?B?WDFhZUZDWXNCbnZlRFhLdXNNSzcycmRBanJ2Ukg4RVMwcXQ2VmhtU2ZETVFP?=
 =?utf-8?B?OHJKZjJMdjByZnl6bC9DdXNKZ2VwRmVVejVPN3o4cm5ITjVWTkQ5U20rTHVQ?=
 =?utf-8?B?OFkyRlJHQWpYSjFGaUNIVytoNTRmUWtNelRlc1hZYmNpWit6am8rTDV6R1px?=
 =?utf-8?B?bnY1SDMzMGF3ZTdBeDZtQlAwNzJBbURJVjdVOU5WMUV1WUVEK0lWVWNVNGxK?=
 =?utf-8?B?K1lRd082VmhBNDFDcjJDOGVLOVpwaTdickE5SFBhYk5SOUdIejZ1aDVIdFBO?=
 =?utf-8?B?Ti9xT3ZIN0UySmVjMmhqQU82eE5OVFkvWmE4czVsWkRNT1JkNjVCSlZ4WDNE?=
 =?utf-8?B?b2tGeGhTNWtoWHVOL0trUHArZWcyNGJ6ZDF4NThsTW1CWUZqSFFUS1FkTVRy?=
 =?utf-8?B?YVkrVE9tOVM1N2lzblEwUDJRNE1HUlJyaU5MMTJ1aGJoSTF1Y3BiV0o3VjFK?=
 =?utf-8?B?bHo4QzVJUTZzcmxzV2NrZVZGVGxFTGtsclUyUVk2WkxhWHVNU2xlODRZZEFT?=
 =?utf-8?B?a1kyWEpadlFUMnhIMTAyQlBUSVFBL0VtRXRIb21ob0JHS2o3KzIzUVZJemRY?=
 =?utf-8?B?TnN2UVc2K21jMjVDZlVQYk1VbmxlWFVNMzdYRlNHUFlDVHZHRTBGZ1hJQ285?=
 =?utf-8?B?UmdFT0UzVVZVSWFNNUthZXlGSlZqQnpBT3ZFWm5kc1ZXOGlxV0VUSXZMMmFH?=
 =?utf-8?B?Yjg1cjUzeFFoT3J1MFNJUlA5Q2VFbEk4eHVnWEk3YlR5MlVaZlY4M3RLRWVh?=
 =?utf-8?B?Zk1taGxMdmY5UCtMS1I0YytCRVBIMVNXeWRVRjdCNFg2WmE4WnlPakUycDhu?=
 =?utf-8?B?MU9ubmtndm9JSG80MnFQTFhHbDFaWnlWbllOUDdTNU9IZFRxRCtzdFQ4TnR0?=
 =?utf-8?B?bkxHdnVabFg4MjF4ZmNEWTNLOWRsTmxLek9PRmVaNHhrRnE4RmhmNldMdjhZ?=
 =?utf-8?B?VlJzYW5XazgyUjEzUFQ1VlQrcXZyZmZSMWFwMzkzdkptTUR3dU9za0d4eWhR?=
 =?utf-8?B?YXRIOFY5eCtDSzFzMGROMXRGcFhBeEMxMFV2Y294TmZSTnlkdDlieCtZWXVv?=
 =?utf-8?B?eFVQSlk3eU9KVzFCdnFWUmxoaWRHYWZNbHNTMmJ1U1NBeHN0ZWVBUWI0N3Y2?=
 =?utf-8?B?WEEzbVpiUTJ4OFVGdzAwSmNvWnBWK3VmMEtaYlp5MWR1Y2hySG9paVBteDNP?=
 =?utf-8?B?d2QxVmszUGV5SGRTMnBiWlJtY2pSc2lieHNzN2ZkMTFHeVZ2M2xqK1hxdmtw?=
 =?utf-8?B?WmZMSlhVR3h0ZUJYbXEyM2M5aEYwYUUzRUJmWGhIbWl4L01UWlVkYzllQ2Na?=
 =?utf-8?B?RGN4d3hLZ0xSWmFwQTN5R2pzR0ZXcFA4SW9YVWpiNk1ObjREUFdvTGFZYlZr?=
 =?utf-8?B?WmpuTFZqT1dkWFZLQVNub2FPazBUa3Q1TldPUnN2SUJFR3VDajg5L1BVUzJi?=
 =?utf-8?B?M1FZM2RYcHYyMzVjYk5HLzMwZ3JCSGZ6YnJORFR6eS9xdmE2eHhFWE9WM0pM?=
 =?utf-8?Q?gwyUgLRTQYL/r9T7NeWC0vMMf3vOX0/DCV9LILCtZN+j1?=
X-MS-Exchange-AntiSpam-MessageData-1: /TWpw0Y6GH+Oew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925341ba-5d5e-4aca-fe28-08de4c510489
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 11:53:18.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1PYLO2gROI39iaybAUm4pU2ErqwlsP03ks8EGfPUhuAsxxnl1o0SPLfzIRIsYtqL30ms/UYGafBFoJAn45b4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578


On 02/01/2026 19:09, Francesco Lavra wrote:
> This driver runs (for both host and endpoint operation) also on Tegra234.
> To allow enabling this driver on Tegra234, add a Kconfig dependency on
> ARCH_TEGRA_234_SOC; in addition, amend the Kconfig help text to reflect the
> fact that this driver is no longer exclusive to Tegra194.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
> Changes from v1 [1]:
> - added ARCH_TEGRA_234_SOC instead of replacing ARCH_TEGRA_194_SOC with
>    ARCH_TEGRA (Jon)
> 
> [1] https://lore.kernel.org/linux-pci/20251126102530.4110067-1-flavra@baylibre.com/T/
> 
>   drivers/pci/controller/dwc/Kconfig | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 519b59422b47..cb8a9c049158 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -228,33 +228,33 @@ config PCIE_TEGRA194
>   
>   config PCIE_TEGRA194_HOST
>   	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
>   	depends on PCI_MSI
>   	select PCIE_DW_HOST
>   	select PHY_TEGRA194_P2U
>   	select PCIE_TEGRA194
>   	help
> -	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> -	  work in host mode. There are two instances of PCIe controllers in
> -	  Tegra194. This controller can work either as EP or RC. In order to
> -	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
> -	  in order to enable device-specific features PCIE_TEGRA194_EP must be
> -	  selected. This uses the DesignWare core.
> +	  Enables support for the PCIe controller in the NVIDIA Tegra194 and
> +	  later SoCs to work in host mode. This controller can work either as

Thanks for updating. However, this is really only Tegra194 and Tegra234 
only. Tegra264 is the next device after Tegra234 and it will not use 
this driver. PCIe support for Tegra264 is not upstream yet but hopefully 
will be soon but it does not use this driver.

Thanks
Jon

-- 
nvpublic


