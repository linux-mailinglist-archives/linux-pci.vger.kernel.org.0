Return-Path: <linux-pci+bounces-20853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DAEA2B814
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 02:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9B57A35F8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF218C011;
	Fri,  7 Feb 2025 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ip2fdJoy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830A1494DD;
	Fri,  7 Feb 2025 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892392; cv=fail; b=cpGAXlKNjWtqY6ElmFYjexziEkXAL+TIC5pstCWn+v0bvdBVO33NNTuX/rFpriAe9S6ayaTwyX3oDyJxjOkb9qJviTfmRWwW0ZgajEBcQNpbkgcbliZssc4UGVWrmCwM1HIkkaZlCS6CUGdxjsnkuGSAjv+EtaOCWx9totlv7nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892392; c=relaxed/simple;
	bh=Smr0dNmLI/dIiy2MQKNgkpmG3nyDokS1juCci335svE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NO2HzQ59rJ7oJ1z8e4sE9CTwNzZV6mVWX4InaQnMmlDhaFOaB88MYc3cBXahi+HBlqBPv8sewpoNCog0NmvGsrBqGi1F27PDn2/PiPvH9JJVxsNuI5iO4LfHoj0GfsVznOjFGtjuseKgRi3Avv0vpnC83cWhbyfAHurKmhf5Knc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ip2fdJoy; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEbqh/zhel5Xm+bBoDoGS2ABS0XxcX/lxIRczX68e6wnDYyiD9TnGWvBEM/tEhp9sZlphuxuif40pbdallrKsqtnVOMeMnPYmvVJVgoqpUrvVbrmKWzHXcLhBQQD625A0ViCezGcQ/dhWaKoZ3RTVre/HXmSYzzZpDqBNTqhWDK5ntng0X5Kzg4rzOoxF2Iv/I2Dzasi6s3R2MKhDa5GknGD9ya67+IKIKfMqfGVZvYb5aW6ndgfLfszsFtLS7WHkxCjU20lVzvCKruxJupKmlBdWmE0bJr+JLcVF75a2Fu5OGMQeOU1QiMXN2IwJMGNBkGBJJqk9MApFFT92YSzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iBOcF6LPKXpB0R5cYBEK1Vr7UatgQremTZqua7GBuI=;
 b=doQR010KS1b8novoNOuRpYoxY0FV41078+EKwZNPTuiGiW/SxfLRxDkriOfbqGL/QDG/3uopWlW7yHUjEJLFuKiNXBE00OYi/UtQTQjdFbbbADgCia8P9IGZLiKZctn8TCGcJI0IquiVdDvk1yVZ++cGa4CvMwgfQiubTuA0fsu3PrFE74b4uw3JiZMnEygUts2srBFKHElVJIN32zkonw72C4dIEOs+07rqkIcvonASzIP0TRnzHERTeLfFfGGWObKwAsQ4Tgw5kn+Z+pAayLY9ZCBKae/xh824vXo1xzSAspis3mMJAvPmOFCbbzoJUoYBUS1OVBZNiE9bYabQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iBOcF6LPKXpB0R5cYBEK1Vr7UatgQremTZqua7GBuI=;
 b=Ip2fdJoyZD/f22ZB8bjY4b8VhilGAM5QSdA/e9iT7BE1Z3guIAqiBEfPtF6avDAQ4PyzwRDqb09xAkvFq8aYq3tsSKZpKATYP8RMNthLWpXFQyUvDqb6DsadVipDrcpDG6/ouM6vm4UByl2kCfviHAnMeGxuTRR4Wbv0wcBE4a7xX/RDt+6nyea9sZgKXW2pL+Cj/KVYzLiOCoAwQdmf3W+uLh4VLue7BoND1wri9Yr8E3Ive4V7wfKc115TjgbpNzTmuxnmFm5H1Oh9rHvAA+o5+e0TBGkA0fdgDmZb0QYRkzcpIKKIGV1sF08axlvJGMbUVjx/sZjHWmKWlkFHiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 01:39:47 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8398.018; Fri, 7 Feb 2025
 01:39:47 +0000
Message-ID: <0b7945c5-d776-4313-a15f-d54cfb27aa32@nvidia.com>
Date: Fri, 7 Feb 2025 12:39:40 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/kaslr: Revisit entropy when CONFIG_PCI_P2PDMA is
 enabled
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 apopple@nvidia.com, jhubbard@nvidia.com, jgg@nvidia.com,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250206234234.1912585-1-balbirs@nvidia.com>
 <76d970d7-e183-4c7b-addd-3b00fa39f9b6@intel.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <76d970d7-e183-4c7b-addd-3b00fa39f9b6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::24) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8bbcb9-86c7-43b4-5c6d-08dd47184dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eENtckxpa3lKaVJObnFKVkROcVVXd0xBRzdZWU5QNmN1U0xLWEtXMUJSV3dG?=
 =?utf-8?B?aTZTZ0NScTB2L0ZkWGRqVkVkUi83b3hraWxDRDJSK1ZVUngxTzRzZVVZd2NF?=
 =?utf-8?B?UzdjWGhtd0JwV2s2TWZnWUUvYkFoVzA3TzhhMmE2UUtXaGQ3NkNKeVVXOWp4?=
 =?utf-8?B?MC9HNTU5UTl3elVSUFNRc09hZmQvdVIyM2RMcmkxcC9La1pDbWtpblpOMkNz?=
 =?utf-8?B?dGVvdHl4ZGwxb1V1NkltSG9JRWlqUFBWQTBDWG9PUDM1M0t0VDk5TXA1VmFF?=
 =?utf-8?B?SmN5alpxM0NUSXJOMnhDTEUxYVUzMDQrSUFwU3FZd0s5OEN0amltU0dQaEVu?=
 =?utf-8?B?V05zYzk5WmtuaXphZVFoaVpSVGJHK3hGcHFtWGI0dGhMbHZEdjMwdkFsMzFl?=
 =?utf-8?B?SnhmVlFCdGNpclpFNDJmREUra0VNcW93SkptVWpXMlhjNFU3TVBhVUlLU0RK?=
 =?utf-8?B?SWZCZDM1L3pVTlJBcHRkNkNJa2dWZ1BHUnBzSyt2VzJmVDdqR0ZjOXc5eFRo?=
 =?utf-8?B?dUtHaVVxcklPM2VGU2hJbXhTbVhBMjZMbmRaVFhmZ0xydmw5a2dMa0s3enNQ?=
 =?utf-8?B?WUtZSlJtamxuR3RLeHFrM2lGZjBCQnFQTGtzVHkzR3liUVk3OUJmdzkvNmdo?=
 =?utf-8?B?TW4vSXN2WHcyUG1ta0dvZW9QTVVaVG0rVkdBYU1sYi9BMTc5NTdQdGplK0No?=
 =?utf-8?B?MUQ3akltbmQ2SnhUd2dOeXR5Y3c5a2ZEODcwazZ2emIyaTVuSDlCbHp0YTRI?=
 =?utf-8?B?UzR3SjJrTnlBbGJrSzJWajlla3dsYTlyN2MwbFVqcldqS3VMRGR2dFBHWUhr?=
 =?utf-8?B?K0pxN1d1NHFpaGFscVpJcXN5ejgvLzNhK3k4YXp0djNYN1RObkR5TCtGQ3Jv?=
 =?utf-8?B?U2hRREg2TWdTQk9VOEpoZUpvTHppU01leVE4aUtNRVk3QXBlRnhpMG5KLzE4?=
 =?utf-8?B?YTdQNUtjOCtkSWRpQWVQT3FtRUtLRUN6Y1l2UWdEZXFXV1ZxQ29XM29RVjBk?=
 =?utf-8?B?OXdPNVkyZFNUOElvc2FlWm1WaE9iVUUvWExib1k0dnBHWTBsVEJodWl1cXpF?=
 =?utf-8?B?aDdTM291bXJzYm41QTdBa2YyQ29EY0VKUkhjN1NTbUx1enNCNm9sT1ZPT2FD?=
 =?utf-8?B?QWRjVGdQdVM5a1I2REMyR1NIeTcwZW5tZ3pGYUtnNWJRdlQyemx5cVB6YVB0?=
 =?utf-8?B?YWJJY3JwU1NrVVZsZG4wSFJPNS9HQ2pEYnhSdkQwWUlsUEJiSDQwNDg5ZUww?=
 =?utf-8?B?VGp4VW1lYlQ4T2lycXdJeExIelV6akFxK3JKNGZkWHNMenVHTFNFQmpBM1cz?=
 =?utf-8?B?UEZhSzRKc2huWnZKMGFRRW85bjE0TnFxZ2dBT0NrYVl6eXZ1aGZXbklxNVVs?=
 =?utf-8?B?dWRoaEltQ3dyZkUvYXRlbWZ6c0V1Zkk1TU4vQTZNdHpaWDVGOGJSVHhKa3F4?=
 =?utf-8?B?VFBhR3VGa3NJZ2ZzUGx4VnVUWGhZQTFNb2tFbW9nQzNjb0Z5YTdBSjkzdnpX?=
 =?utf-8?B?OTVOZVFzdjVRVm5zRFBSbjBuQ1ZuYnFubGErU1oyZHVpWjVXZ21zVmV2N2xV?=
 =?utf-8?B?RHNibjQzNVEySXkvVG9IenM2aDJJcFBNcTlRYmlpWVdSajFkWjMvOWhTRVV4?=
 =?utf-8?B?N0YyUXI1enNwVHNBMk4zWHR6SHlUT0FaM01FNGc3OWx1OGd5LzF5ZTNOS1Jy?=
 =?utf-8?B?UFR2YWdRbkp2SEZ3VFdESVJGOW1CV05QQVZzUmtPWUFjS1NkSjJQb0dMVTYy?=
 =?utf-8?B?Ky9jeXJaOW5heGFYUlpDYXVoZWJONmVudjdob1o1YllxekttTERpNFZFWS9D?=
 =?utf-8?B?NkZKQ0RwSEFvYkM0OXZNZnZGWllXRnVDZWlRQXRFZDdlZmhnc2dFRGk3VTFs?=
 =?utf-8?Q?wEtIz1aZzeTJw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJkeVpnL3hGRHBHSVo4S2EyL09CK2M3Q2djS1hKdjlNVUExT1dEYzJXZG5G?=
 =?utf-8?B?MHNmWlQzRWJiUTNwdllsS2VKWjNGaUtjakxXcWQ0Z1hCY0k5Sk1XdmNGMVVE?=
 =?utf-8?B?cC9EOGxQMFRoUDNVUlJabFcxelZlMnhDaURYaTZvN0NxTU5pWEtQZzhIUitR?=
 =?utf-8?B?c1VTekpOaTJlY1Y0LzZnM1o4WmlHK0E5VkVhNDcxbjIxRVQwZjZKRE43c3pE?=
 =?utf-8?B?a05pR0c2Vk5CdkpUVWtXVUY0eDdselpTcnBlN0d3YzljUmN3QlJwdlZBME9s?=
 =?utf-8?B?NVN5anVlVlE5WXFvRHVyVDR5ZWV5TkRDSFFjMXZJbWxOZWxXd0hjN0NTcWYz?=
 =?utf-8?B?cWZLSmxyanEyOEs0b0pCYld2QmozKzg5bU5JTGJya0dRREJ2Sko0K2NyL0VB?=
 =?utf-8?B?b3NkdGlCWFhXN1RFUTZzTmdIUmhHdUJSbjNGNys4YkFKdktFOFZ3ODkwbVpz?=
 =?utf-8?B?SEdvYmJlbWY1V1Nnc3JrK082ck0rMm5YczVZNjNvZU54MVVtUnZlOEdKK3Er?=
 =?utf-8?B?UHZidGxpUm9NL0h4ZUZqSEVvekdZcTRLOHNnTndXbjNhYlJhcHlXQXhuU2I4?=
 =?utf-8?B?ZkFJREQvU3EwTjE1ZGNxdmRrNkc5M0hGczZ1R1lwbGs3bkk4cUQ4dWZ0ZTND?=
 =?utf-8?B?R0tUQjNsbURNc1hYK25OeDkrQ3BHU3N2TDVadzUwZ3NWWjVueXJ6L2xYV1hw?=
 =?utf-8?B?eitld0pjc1VtODNnVmx0UFBMdm1aWFJaZk9KMnRkZFhxbUZrUXFtMW1BSitD?=
 =?utf-8?B?aGUvMkJrT1lieTBES1k0UXM1VFZMejhTTURSZlpTNERvOXFEdTB4V1FZTzlU?=
 =?utf-8?B?TzNVbTYrdm1pMWlENmJXRXlWY21JL2RHai9DZGw2MG9yNC9wcTYySllDTTJB?=
 =?utf-8?B?c0VTT0V1UGt5SWw5ZGE2SG1BV256a0xXVXEzOGFPWmRmUE1yb3NpQytXTXN2?=
 =?utf-8?B?b3c2UHk5Um1LaWxiYitGV1VrTnc0bXM1UG5wYkxRaC9tTkIveXBvM0d3Z2Jk?=
 =?utf-8?B?eGJyV3BLU29KUGlteUI5Mjk2V1RzV01Zc2Z2NkQvR2VMV0NwckRuVkR0MXhi?=
 =?utf-8?B?Q1BQN0cwbjBXcFlJcnJPdmJCTmM2V2pUUU5pZUsvbVVYdEFsNlc2V3hwa1Vs?=
 =?utf-8?B?OUlaTVliaUpUWEV3OXRsV3ZNRmg1Y2tqT2FkNVY2amNxNDRpNFY3c0d5R1Zq?=
 =?utf-8?B?MWdOdThCSEdQditEcXRQQllwOE5pVVV0V0c1SCt1NGRWUzJOd2Rad3JwQ0Jm?=
 =?utf-8?B?c2Jqd0I5cTRCV3A2eloyYkx0N1NUVVdhUnlzVmlyRnV3bU1uazJZbHNwL1RY?=
 =?utf-8?B?dVVTZzVLL3hyWGRpWkpWVUM1cXZxZHdFTUZ1MmN1TmtVYVZEdmEyL1kvNXFr?=
 =?utf-8?B?WHFnQ2NlWU15cy9hL2VjRFZGbWFHa3pLSUhwOGp4NjQwZkRLSlJLTTNURGJF?=
 =?utf-8?B?bUorNFlaSGtqdEx2dnM0dWdWa0pUd255eDBDb2xjTW9yK2ZMTmVKNnM0b2hH?=
 =?utf-8?B?ZUZybHBRV0NtQ2w2VVBNTWVEbW9CRFRJYkd1ZCtwRmhKOURmWDVnMEhST1ox?=
 =?utf-8?B?aXlsbU5wYmVjN2hZdkUvOThXZEVhNytJZjhyNStFWDBXa2l6TW54emwrWkdM?=
 =?utf-8?B?UDdDTnJjWERxRzZURmZza0FacDJkYjdRby9Qc2dubCtjYmJkNUJWb0hMQkpq?=
 =?utf-8?B?TnIvSGlpamJBMFdUTGZVTkF3Mm9tc3FvZHltRm8yc0dWVEppazEzdWJGVHl0?=
 =?utf-8?B?K2lQdCtIdzhrcm1KODJyODU2R1A0dDBUN3hRem5keXdFZGdGOHVkZmZiM2pI?=
 =?utf-8?B?bEFDVE51WHdqNWp5enM3OHBoSUlGUnJzQWRhdm42UFd1ZUtnWVl3aFZMSWM5?=
 =?utf-8?B?T2IyQmdHb0UxZTRpWkNQZXhJclVpeHpBVm96YkxvbXBiWlBuV3FQRy9BTGtu?=
 =?utf-8?B?Zzg5NkFjcE1ZcTBhdkV1YW9qNjBPZm9ha3NhWEhDSy84bEJtQi9PYURxei9R?=
 =?utf-8?B?TTBkajFGUFQvVkFaZ29uNXZvZHErNGYyaEw0MzNUMUxJb0hYMHJIZ3FMN1Qv?=
 =?utf-8?B?dXVIVjR3dXZjQUlQWW9GQWFDemJpOFRrVThHU1hYWVpqbHNwbnljcE1UL2dW?=
 =?utf-8?Q?RLhI3wjHMUr8I7hGZdWB6IuDd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8bbcb9-86c7-43b4-5c6d-08dd47184dd5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 01:39:46.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQQyTuianlPZzd7pdnwaEAUMMFikqpXKvbozV08mdeg8JoAQLPvqB/7YsX1kq1DZDkkrh+8784fi/StXRHw4bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

On 2/7/25 11:27, Dave Hansen wrote:
> On 2/6/25 15:42, Balbir Singh wrote:
>> Fix this by not shrinking the size of direct map when CONFIG_PCI_P2PDMA
>> is enabled. This reduces the total available entropy, but it's
>> better than the current work around of having to disable KASLR
>> completely.
> 
> Is the size of these P2PDMA mappings known up front? Or do you just need
> them to be as large as possible?

The size is not known upfront, it depends on the system configuration.
Yes, we need them to be as large as possible.

Balbir

