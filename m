Return-Path: <linux-pci+bounces-18764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A009F7930
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2CD18982B2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F41CD15;
	Thu, 19 Dec 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CHauhYSZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1029221DAD
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602720; cv=fail; b=ZLL3XNYd8hZkA9zspz2qybDclRkWbSDBLU1ppmJI2ldF4VzS5JUskZ205GVmyNYnESa9KXuIJ4SWcnfPr8va9g9JwRdfl2/XlHwzFPQ4xcjTRuPdOgTGYmrxSdg5axqeoq+4Vr0XN6Q/3RdVNOoTf+3Pi0r3k8oEMELrmtrQUs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602720; c=relaxed/simple;
	bh=vn4ZaMSjcZiVlBCPjis1ROL1hxz2j+77E3AmVBd1QSg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dFCrqlAIKoiP7y/2MjvrcKRSv4+ofEmPnyCJJUv5KLPKVXAvfYBuVskGaU1EajmCoVlzE6T4oBzyRreeexHx1uTeilv31zRostzyVCJyw3wrIb1gjvSS1SwKBJZ1jJ1TJPO8qGt7fI4leq4k0NCBPTyJO+F2DB/Uiv1xIVdK+1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CHauhYSZ; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/XtYC6Aql7YNljPoKOlkY8hRh5yL5JBd2U5O7c6v7CVWarW2r0SZ8nWhGr6FFqeB/QpxTjXwUD/1yr4prBnDCNG5U+illdjrqlIaMM++hlDOxjrIEfAxFKZxkCsm3ooWIuS7iSBNxsE0SDvXys5UfVO87AimPeUbIsuXLdZ+lKVO8OQs038570oDZhfdDXslw8ytwMdr7bKcDU2tcs6IJV4Ly5x0g9SjjmpN8KnWce4zEDu/ZCQAIqFwmCBuLWO/SaIjaI1pc/kYKKGDqxvclIUfRiRu0UnwZtMWaM3b9gflPYp3o6GkbgB/V+5HRsFFXHu0D2r0rHeokOsCNKZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ2cRI9eeenTgmY06D8kf5vi8jPcNUxdBF1a4RdSU7Q=;
 b=HXe4ima9J/iwzYmTnlHdhwUZn6GlmMM9nuV9awh2Ol28JYWOLwdSFRnEsh4hRBoxSpGxxHzeJoVBMeiPvE9O++qgao1/yvCehjxRYnzoXTHrb8as5YDOGDr616Br6y3Z2fiXgNEQ1G7mf5tP24j822BuvqtwHVcDVdNmetgfISHHzKFfk/YEV9pHxsqAknfTMkkBSleAgomUQeBesy9zRlsf+lgZIkv9PCNxadSSBi/hKZ+H3gYmSKGa6yeVTkqKv4qP3e66g63bTnN9YQTEfdYCUptwX21aDGeHx0OufSY5fa+S/gxgi7+38XZcuvguDvzknnT8EF0vHgXMf3O62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ2cRI9eeenTgmY06D8kf5vi8jPcNUxdBF1a4RdSU7Q=;
 b=CHauhYSZzNuw9iqbvoe1dRd6W1SIwdOyWhQBilkssP+HPYN/tkL+Z0aT3cxdH9lI2eOrcQBwLaBgaS9d5jLOlIYqZxx6UndbOEA0p/SfgfOMsvz8G4V4exSHooUC0xNCOyni2z1oI+yjhCdVTsIvyA7XskDpqYI7WILblP5bP5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:05:15 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 10:05:15 +0000
Message-ID: <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
Date: Thu, 19 Dec 2024 21:05:08 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
In-Reply-To: <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P300CA0053.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: c47ad722-f11a-41ba-9016-08dd2014a226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0NSWHNVNkVaYy9kclhaRkE4eFRveDlnbnBWQys1ZGdGVElYRmV1d0lrNWZw?=
 =?utf-8?B?YXJod3JTM0syL041UnprZDZ2UUN0RUloYWhZMy9ncWQ0ZDQ1R2wvSTNOOG5G?=
 =?utf-8?B?MnBCeTBxNm01RThjcTNGc29OaHRwOGlocUF6ZUFwTXpLU2Q2VEluY3BqcFMy?=
 =?utf-8?B?OTUzYS9PcisyUmtzUUM5QkV3UDFVUy9hRFZtTEhYbTJVNlBSVzVTZmNVYmY1?=
 =?utf-8?B?TStBV1dJVFd4cUVyTVpwbDBONXlTV3RFNWU1KzdpVjhXMGhoWmYveDFCcU1B?=
 =?utf-8?B?Vy9tUTBvalhJeDlyNHhGZmZDV0V0ZmFPenRrYzNCaVAwTVBwa0UzKzcxa3R4?=
 =?utf-8?B?VFVxdS9YSERQdTJ4cmp6ZWxhdkdxRlc2aldJUEhBa0FYMElaRVVpUXo4K3pK?=
 =?utf-8?B?K2tGMUcza0d6dWhYcDhaVDV2Nm1uSFRXNkFweWJKVWRQVWp6bm9TMExWaEVl?=
 =?utf-8?B?L2h1b3NZQXhYK3FzMjFuY2d4RVQwd1U3cG1KRGpMRXkybDFiV2g4T1ZGanAz?=
 =?utf-8?B?NURJcTYxMlllRHdOZXdSMG03aUNxZHJBcnNTRTZBZjkxMnVwU2NNTmRBMW5h?=
 =?utf-8?B?endhWHphc1dRQkR5NEp4bkdRREpic1ZJVTY4T1N1MUZOR3dUVVNiYXIyU0Nk?=
 =?utf-8?B?WEIrSTdmbXBsc0tSaWJTNnppZGRRU2JkZG1ZUGUzS243aXJhYnlhUkorV24r?=
 =?utf-8?B?TGdHaHR4ckZXMUdJdkFtVUpxREhyczdWV3lqMndZUm50bVlIbTFqT1RIellp?=
 =?utf-8?B?SC92cGd1Y21pUlJsNTdrUlFZZkxNQUJsWW9aUFdkOGhoMDRWekthVWx6c0Rs?=
 =?utf-8?B?WkJEemlneC92d016TS9PMjIyQ2s4bGV0WW1jeWdlMHpndEk1OURZc1JZeWpt?=
 =?utf-8?B?Z0JsWHUzZnRMWCsremx5TFBGbUxlczZMVU9XY20xNWpMOVlpdS9ScEhDTGw4?=
 =?utf-8?B?bkdkb2FDT3A1Y0RFZE9sSmFiS3BHOTNiMjl1YkRaN0dITVRiWkk5b3lseVRo?=
 =?utf-8?B?aGZMZWJsMW1QY3l3UFZaVnJ4aGJxOUNLWUdmbU00UUgweVFFRE44clEwa0R2?=
 =?utf-8?B?UHRLUTgyWHVrb2NJZWNQQ1Jkd0pOUldrYXBETWlvR0Y1cnhWTGE2RmE4cnhr?=
 =?utf-8?B?bVl0VkZmdWs4TWw4VGxPbytZRG41bXQ2VDRPOU1ZVFJFbHhETDZ6TEI1YTFM?=
 =?utf-8?B?RFowM1dTaDJlTHM3eXRGc1BzNXA0TzZ5TmcrT1IwNlpnOWJHcmM5ZkgzbS9S?=
 =?utf-8?B?Nm9rWVdLb1BNdTVMUStVY1BGWnVOQzZwNmhBNU9IdHJPb2x6aExkRHAzYk1K?=
 =?utf-8?B?aEdQRkQyWXY0ajZ2Mkc0VlVwLy9pSXpwN2QzY09YeGcrOFkrUSsralprUC9D?=
 =?utf-8?B?T0w0V0U1VWlkSzRlQUxYdFBVVjYvTWlwQ21rUFU0S3kvS2diMFZDYWJXUDNY?=
 =?utf-8?B?aGk5TmlUOVpKQlowUTkwZWl6N1R1VllFTE1uRU04bjBjNG1uZVZocWYyZ1dh?=
 =?utf-8?B?bGJIMFIreW5KZXBvUmNtS2swaVdyOVhsSGV6QUdhRXpJaUJXWFJLVm94bFZw?=
 =?utf-8?B?dFpsdFBYazU0Q2UvUVpDbkdBc0d0cEpJSDhLNWt2YUh2VUN0MkVvT3lKVGRw?=
 =?utf-8?B?b2RlRm94cCtmRVNIcS9UNTN6QVRyZVdPSTd5MUV2N1pzdUs4MHMxcncxRjdk?=
 =?utf-8?B?azQ0d0JjbHpGZkRZbzBCT05hYUU3ZEtkSHVXUDdLMmZwZEhCQWM0QnJOcHNO?=
 =?utf-8?B?UmFOQTlmTWVoR1UxdUZEclhkMXduQnJuRWJXTVNESTJOaTRuVWovQ2oxZE1z?=
 =?utf-8?B?UkdsTjF1MVUvWGwxbkszOW5MRjZFTU1OR0RZNE5vcWVsSlZyRkp5OVM4SThu?=
 =?utf-8?Q?RUpKk3mEr6x9b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K051K2NjME5YanM4TVVlclRzK3JkcmEyRFpwT2k4ZHhWd3pYZGFIS1NSNjlX?=
 =?utf-8?B?SXFFbGRsakNVREZJd3NrR3FwdXZlR3Fsa1lCOVZqc1U1Mi9nYVNvQVU3M2xC?=
 =?utf-8?B?MGJlOU5sTDFmNjE4TXFEZVU1Z2k1VFE2c2N0WHJhME9jSDZ3NnB4cU5FYkF3?=
 =?utf-8?B?bTJsMUprWTRtbTM3WStDQUt1YkluUFpFL2RJRWZzWmlRTStwdjJYR2tMbEk2?=
 =?utf-8?B?TUk0a2sxVFZUbk50U20xQVhoMU9MTkJDbDRRVENmUHVqZmdnb01rNjl4bG9H?=
 =?utf-8?B?YXJmVkFacWhqdzltTG9nMTNYNnRaaGJWNG1rYXVNQ1Y5Vnl1VkdDL1BGYk52?=
 =?utf-8?B?SUpaNCs4YkpWOUlWZmQrY3ZZRzZhajVCWnZkVk8xZ2tmWGRrQ3dyMUc4aWxt?=
 =?utf-8?B?TUNlOWZ2YjZPM2pGTEZIZElxbEpReEpmd1NlaSs1L0ZrQ1VTTEhEMWd1ejdx?=
 =?utf-8?B?Z2FReS8wL1BhcWU2N2lqMmRSUjU2UjV5d1pJaFRjekFQc2pIRHgzVGhkRXRl?=
 =?utf-8?B?SHlNTnpCMDhURFdDTHlsU1BkUXozQitydjM0QWZPdVcvTFg3Z2JLU09MaGha?=
 =?utf-8?B?SXF4S0RlTnI4YlRtcVFFTXRUeE1Ba3RzTExLYUpBNzJrUGhwd0IxU1dTUUF6?=
 =?utf-8?B?UE9KK0FqZVZCOXFNVVViK1lnMXBkSGlVTmVBZkpGMVFLOW1JVU5hSzl4OHRu?=
 =?utf-8?B?aktxbWgwc3NkVHBTN2lhMUNKM29oeUplQUZqdFBheC9Sa1FUQ2ZOWDRnVTN2?=
 =?utf-8?B?SUdLdWMzaStHVjQ0Q3hRS3NtUnJzMkcxL212NU9qaEN0Tm5oQklMc1h1Z2FK?=
 =?utf-8?B?Y3pMNlloTHd5enV1WG1DMHhOSXZiU3A0YTRVbTZQZ1JUZ2Y5RzV6Rk9HSEtV?=
 =?utf-8?B?M082ZDh2NjNCNE5ER3RBSGtkUkcyMDBWZU9uc1haR05LdkdoMTB4MzZFMlNM?=
 =?utf-8?B?U1FMcEkwYXZreG83ekdTYk1KMXE5K3NNV1NNMWIwdXZSWkFjM0FjUlNCMzB0?=
 =?utf-8?B?b2RCYlZiMWozS0h4V01RakNlS3EzN0k2RFNISTd2S3dOYXFVYXBraDkvQ0RD?=
 =?utf-8?B?ZWtVVm5DdDdkMWduQWhDMnUzZEEvVkJHOWsyNjdnQUFMbXdkeFh5OFhkUThJ?=
 =?utf-8?B?TE5SaWZlUTFUUGNhbkFwdEh2dWpDQ3JHUng0STA1MlJ1ZjkvUVNlUkNPZFNL?=
 =?utf-8?B?YVJpY1krLzZTQVEwYTlIQThGSkpSdzRTUnIxZW9XamRSd0YyN2x0VkV6cmxi?=
 =?utf-8?B?WWg3M0xxckpZZTBTd0lQNTMvWi9YcWsxSkpqYWVrcGlxOVBESUpyelVHSEs5?=
 =?utf-8?B?L2VVZ3dxQkJJN0pVSmkrZ1NNVms3aW5yODRVQUdEczh6MEFIQWVGRC8rNUxR?=
 =?utf-8?B?cDkvbEZDZmttbXBmM1pjaFdpMmNTYkR3b3dvMnBmaHUxd1ozRnhBV3J6aWhX?=
 =?utf-8?B?Y0Q1MkQyYUdpZWpQYmkyUzBkZWxEQTEwbzFOY0JGTWJqdURRWjNtVzM2T3hw?=
 =?utf-8?B?eGwxdjUrRy9KZzNsQXlFSmMwcGVrRUYxbGJqYlE0N0dBMGVmdXdUVTBTNUh1?=
 =?utf-8?B?ckszYVZhcisxdDVxK2djRU9DWUlXUTJ6YSs0YWhibXNSMGQvVzc2bHQrWFZB?=
 =?utf-8?B?aktUQzdaL2Z0WU9pUHhlT2pVR3RUcm9PL29IcHo5QkMrcEJrNldTdTA0bEx0?=
 =?utf-8?B?M3lTOEhSZTJTL2IvY1Z4UkxCZ0taRXdGWkdROUI3TVlJNTFmS3c0cEludHBu?=
 =?utf-8?B?Vks1aFZqMTFydERGQXVoV0RqV0szR1BDMmxieitYbWZ5YWdrQm8xcDdrdlN4?=
 =?utf-8?B?RWd5OGVqdTZFcWdPM2dibHgxaTdYbEtjcitFTWdKNTF4NnhLMTVoZjZFeGph?=
 =?utf-8?B?YWY3ZHUwKzM3QmtvTTdtdTNaTk1DTXBva3FWMVErcmRudEFkNEFSZWFpaTlE?=
 =?utf-8?B?d3NBUXpEQ3FyWjRxOHZJNXpBM056MzVDb0ZzeEp5Vk1XbHFKTktYRVRLQWk2?=
 =?utf-8?B?SThnc3VCZWN2cFNqLzlGeG5JWTd6MXRDcjJ6aXJieDBOZzgwbWZLczR4OXEx?=
 =?utf-8?B?d09laWp1VWJURExHbmtoRmFUVEExNmdaRTkydnluV3Z6MVR5dzNYK3RBemJi?=
 =?utf-8?Q?cDAWHI99/Y+eL3CeGGE3peXH9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47ad722-f11a-41ba-9016-08dd2014a226
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:05:14.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0t1WBhU4X9RmA0X//EmcjzByjs9BaB6qmyL2i5uqCotfcuJwOVqwqPkbTOPvdPnGZJKXhYk8zWtugnpcuQEYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975



On 19/12/24 18:25, Alexey Kardashevskiy wrote:
> 
> 
> On 6/12/24 09:24, Dan Williams wrote:
>> There are two components to establishing an encrypted link, provisioning
>> the stream in config-space, and programming the keys into the link layer
>> via the IDE_KM (key management) protocol. These helpers enable the
>> former, and are in support of TSM coordinated IDE_KM. When / if native
>> IDE establishment arrives it will share this same config-space
>> provisioning flow, but for now IDE_KM, in any form, is saved for a
>> follow-on change.
>>
>> With the TSM implementations of SEV-TIO and TDX Connect in mind this
>> abstracts small differences in those implementations. For example, TDX
>> Connect handles Root Port registers updates while SEV-TIO expects System
>> Software to update the Root Port registers. This is the rationale for
>> the PCI_IDE_SETUP_ROOT_PORT flag.
>>
>> The other design detail for TSM-coordinated IDE establishment is that
>> the TSM manages allocation of stream-ids, this is why the stream_id is
>> passed in to pci_ide_stream_setup().
>>
>> The flow is:
>>
>> pci_ide_stream_probe()
>>    Gather stream settings (devid and address filters)
>> pci_ide_stream_setup()
>>    Program the stream settings into the endpoint, and optionally Root 
>> Port)
>> pci_ide_enable_stream()
>>    Run the stream after IDE_KM
>>
>> In support of system administrators auditing where platform IDE stream
>> resources are being spent, the allocated stream is reflected as a
>> symlink from the host-bridge to the endpoint.
>>
>> Thanks to Wu Hao for a draft implementation of this infrastructure.
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> Cc: Samuel Ortiz <sameo@rivosinc.com>
>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   .../ABI/testing/sysfs-devices-pci-host-bridge      |   28 +++
>>   drivers/pci/ide.c                                  |  192 
>> ++++++++++++++++++++
>>   drivers/pci/pci.h                                  |    4
>>   drivers/pci/probe.c                                |    1
>>   include/linux/pci-ide.h                            |   33 +++
>>   include/linux/pci.h                                |    4
>>   6 files changed, 262 insertions(+)
>>   create mode 100644 
>> Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>>   create mode 100644 include/linux/pci-ide.h
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge 
>> b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>> new file mode 100644
>> index 000000000000..15dafb46b176
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>> @@ -0,0 +1,28 @@
>> +What:        /sys/devices/pciDDDDD:BB
>> +        /sys/devices/.../pciDDDDD:BB
>> +Date:        December, 2024
>> +Contact:    linux-pci@vger.kernel.org
>> +Description:
>> +        A PCI host bridge device parents a PCI bus device topology. PCI
>> +        controllers may also parent host bridges. The DDDDD:BB format
>> +        convey the PCI domain number and the bus number for root ports
>> +        of the host bridge.
>> +
>> +What:        pciDDDDD:BB/firmware_node
>> +Date:        December, 2024
>> +Contact:    linux-pci@vger.kernel.org
>> +Description:
>> +        (RO) Symlink to the platform firmware device object "companion"
>> +        of the host bridge. For example, an ACPI device with an _HID of
>> +        PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00).
>> +
>> +What:        pciDDDDD:BB/streamN:DDDDD:BB:DD:F
>> +Date:        December, 2024
>> +Contact:    linux-pci@vger.kernel.org
>> +Description:
>> +        (RO) When a host-bridge has established a secure connection,
>> +        typically PCIe IDE, between a host-bridge an endpoint, this
>> +        symlink appears. The primary function is to account how many
>> +        streams can be returned to the available secure streams pool by
>> +        invoking the tsm/disconnect flow. The link points to the
>> +        endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.
>> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
>> index a0c09d9e0b75..c37f35f0d2c0 100644
>> --- a/drivers/pci/ide.c
>> +++ b/drivers/pci/ide.c
>> @@ -5,6 +5,9 @@
>>   #define dev_fmt(fmt) "PCI/IDE: " fmt
>>   #include <linux/pci.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/pci-ide.h>
>> +#include <linux/bitfield.h>
>>   #include "pci.h"
>>   static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
>> @@ -71,3 +74,192 @@ void pci_ide_init(struct pci_dev *pdev)
>>       pdev->sel_ide_cap = sel_ide_cap;
>>       pdev->nr_ide_mem = nr_ide_mem;
>>   }
>> +
>> +void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
>> +{
>> +    hb->ide_stream_res =
>> +        DEFINE_RES_MEM_NAMED(0, 0, "IDE Address Association");
>> +}
>> +
>> +/*
>> + * Retrieve stream association parameters for devid (RID) and resources
>> + * (device address ranges)
>> + */
>> +void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)
>> +{
>> +    int num_vf = pci_num_vf(pdev);
>> +
>> +    *ide = (struct pci_ide) { .stream_id = -1 };
>> +
>> +    if (pdev->fm_enabled)
>> +        ide->domain = pci_domain_nr(pdev->bus);
>> +    ide->devid_start = pci_dev_id(pdev);
>> +
>> +    /* for SR-IOV case, cover all VFs */
>> +    if (num_vf)
>> +        ide->devid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
>> +                       pci_iov_virtfn_devfn(pdev, num_vf));
>> +    else
>> +        ide->devid_end = ide->devid_start;
>> +
>> +    /* TODO: address association probing... */
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_probe);
>> +
>> +static void __pci_ide_stream_teardown(struct pci_dev *pdev, struct 
>> pci_ide *ide)
>> +{
>> +    int pos;
>> +
>> +    pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
>> +                 pdev->nr_ide_mem);
>> +
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
>> +    for (int i = ide->nr_mem - 1; i >= 0; i--) {
>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
>> +    }
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
>> +}
>> +
>> +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct 
>> pci_ide *ide)
>> +{
>> +    int pos;
>> +    u32 val;
>> +
>> +    pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
>> +                 pdev->nr_ide_mem);
>> +
>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
>> +
>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
>> +
>> +    for (int i = 0; i < ide->nr_mem; i++) {
> 
> 
> This needs to test that (pdev->nr_ide_mem >= ide->nr_mem), easy to miss 
> especially when PCI_IDE_SETUP_ROOT_PORT. Thanks,
> 
> 
> 
>> +        val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
>> +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
>> +                 lower_32_bits(ide->mem[i].start) >>
>> +                     PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
>> +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
>> +                 lower_32_bits(ide->mem[i].end) >>
>> +                     PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);
>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
>> +
>> +        val = upper_32_bits(ide->mem[i].end);
>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
>> +
>> +        val = upper_32_bits(ide->mem[i].start);
>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
>> +    }
>> +}
>> +
>> +/*
>> + * Establish IDE stream parameters in @pdev and, optionally, its root 
>> port
>> + */
>> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
>> +             enum pci_ide_flags flags)
>> +{
>> +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>> +    struct pci_dev *rp = pcie_find_root_port(pdev);
>> +    int mem = 0, rc;
>> +
>> +    if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
>> +        pci_err(pdev, "Setup fail: Invalid stream id: %d\n", 
>> ide->stream_id);
>> +        return -ENXIO;
>> +    }
>> +
>> +    if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
>> +        pci_err(pdev, "Setup fail: Busy stream id: %d\n",
>> +            ide->stream_id);
>> +        return -EBUSY;
>> +    }
>> +
>> +    ide->name = kasprintf(GFP_KERNEL, "stream%d:%s", ide->stream_id,
>> +                  dev_name(&pdev->dev));
>> +    if (!ide->name) {
>> +        rc = -ENOMEM;
>> +        goto err_name;
>> +    }
>> +
>> +    rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, ide->name);
>> +    if (rc)
>> +        goto err_link;
>> +
>> +    for (mem = 0; mem < ide->nr_mem; mem++)
>> +        if (!__request_region(&hb->ide_stream_res, ide->mem[mem].start,
>> +                      range_len(&ide->mem[mem]), ide->name,
>> +                      0)) {
>> +            pci_err(pdev,
>> +                "Setup fail: stream%d: address association conflict 
>> [%#llx-%#llx]\n",
>> +                ide->stream_id, ide->mem[mem].start,
>> +                ide->mem[mem].end);
>> +
>> +            rc = -EBUSY;
>> +            goto err;
>> +        }
>> +
>> +    __pci_ide_stream_setup(pdev, ide);
>> +    if (flags & PCI_IDE_SETUP_ROOT_PORT)
>> +        __pci_ide_stream_setup(rp, ide);

Oh, when we do this, the root port gets the same devid_start/end as the 
device which is not correct, what should be there, the rootport bdfn? 
Need to dig that but PCI_IDE_SETUP_ROOT_PORT should detect that it is a 
root port. Thanks,


>> +
>> +    return 0;
>> +err:
>> +    for (; mem >= 0; mem--)
>> +        __release_region(&hb->ide_stream_res, ide->mem[mem].start,
>> +                 range_len(&ide->mem[mem]));
>> +    sysfs_remove_link(&hb->dev.kobj, ide->name);
>> +err_link:
>> +    kfree(ide->name);
>> +err_name:
>> +    clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
>> +    return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
>> +
>> +void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide)
>> +{
>> +    int pos;
>> +    u32 val;
>> +
>> +    pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
>> +                 pdev->nr_ide_mem);
>> +
>> +    val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
>> +          FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1);
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_enable_stream);
>> +
>> +void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide)
>> +{
>> +    int pos;
>> +
>> +    pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
>> +                 pdev->nr_ide_mem);
>> +
>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_disable_stream);
>> +
>> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
>> +                 enum pci_ide_flags flags)
>> +{
>> +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>> +    struct pci_dev *rp = pcie_find_root_port(pdev);
>> +
>> +    __pci_ide_stream_teardown(pdev, ide);
>> +    if (flags & PCI_IDE_SETUP_ROOT_PORT)
>> +        __pci_ide_stream_teardown(rp, ide);
>> +
>> +    for (int i = ide->nr_mem - 1; i >= 0; i--)
>> +        __release_region(&hb->ide_stream_res, ide->mem[i].start,
>> +                 range_len(&ide->mem[i]));
>> +    sysfs_remove_link(&hb->dev.kobj, ide->name);
>> +    kfree(ide->name);
>> +    clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 6565eb72ded2..b267fabfd542 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -465,8 +465,12 @@ static inline void pci_npem_remove(struct pci_dev 
>> *dev) { }
>>   #ifdef CONFIG_PCI_IDE
>>   void pci_ide_init(struct pci_dev *dev);
>> +void pci_init_host_bridge_ide(struct pci_host_bridge *bridge);
>>   #else
>>   static inline void pci_ide_init(struct pci_dev *dev) { }
>> +static inline void pci_init_host_bridge_ide(struct pci_host_bridge 
>> *bridge)
>> +{
>> +}
>>   #endif
>>   #ifdef CONFIG_PCI_TSM
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 6c1fe6354d26..667faa18ced2 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -608,6 +608,7 @@ static void pci_init_host_bridge(struct 
>> pci_host_bridge *bridge)
>>       bridge->native_dpc = 1;
>>       bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
>>       bridge->native_cxl_error = 1;
>> +    pci_init_host_bridge_ide(bridge);
>>       device_initialize(&bridge->dev);
>>   }
>> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
>> new file mode 100644
>> index 000000000000..24e08a413645
>> --- /dev/null
>> +++ b/include/linux/pci-ide.h
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>> +
>> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
>> +
>> +#ifndef __PCI_IDE_H__
>> +#define __PCI_IDE_H__
>> +
>> +#include <linux/range.h>
>> +
>> +struct pci_ide {
>> +    int domain;
>> +    u16 devid_start;
>> +    u16 devid_end;
>> +    int stream_id;
>> +    const char *name;
>> +    int nr_mem;
>> +    struct range mem[16];
>> +};
>> +
>> +void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide);
>> +
>> +enum pci_ide_flags {
>> +    PCI_IDE_SETUP_ROOT_PORT = BIT(0),
>> +};
>> +
>> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
>> +             enum pci_ide_flags flags);
>> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
>> +                 enum pci_ide_flags flags);
>> +void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide);
>> +void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide);
>> +#endif /* __PCI_IDE_H__ */
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 10d035395a43..5d9fc498bc70 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -601,6 +601,10 @@ struct pci_host_bridge {
>>       int        domain_nr;
>>       struct list_head windows;    /* resource_entry */
>>       struct list_head dma_ranges;    /* dma ranges resource list */
>> +#ifdef CONFIG_PCI_IDE            /* track IDE stream id allocation */
>> +    DECLARE_BITMAP(ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
>> +    struct resource ide_stream_res; /* track ide stream address 
>> association */
>> +#endif
>>       u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ 
>> swizzler */
>>       int (*map_irq)(const struct pci_dev *, u8, u8);
>>       void (*release_fn)(struct pci_host_bridge *);
>>
> 

-- 
Alexey


