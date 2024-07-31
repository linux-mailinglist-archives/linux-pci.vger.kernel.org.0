Return-Path: <linux-pci+bounces-11052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4236D942F96
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6BB228BC
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F01AD410;
	Wed, 31 Jul 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJcgqOwK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107F19408C;
	Wed, 31 Jul 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430802; cv=fail; b=KEZKy2cKv6D5JdNtiOH8ohAfXhc6xoAgDvfONTsNUQkgVwhVkATH/ZkXXQ7j60W48933Es0V/6OmOyOcpQMZzNiSUeh/JvkvqtGgpbQej0uhWIHsy68cBzPQDzyCEoj7UvdlgSJdek2kmM5Crx1Scnl1Xyl03TA6jKeW0wLEiLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430802; c=relaxed/simple;
	bh=jj2TbI6V9j9WFvvTkkdt4Gbc8JoSZgvLARdZ6bwO3Y8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqgdXSwv2mIuCn59tzJR7f+D07uKC8PLkx3EmyKIhC46Rc5gtaCTQDFWvngP2qNo3BeE3JQgJe53Sa9zowmzSXUVhb5Bl2ElZRtAXMDVlZk+10vZfDuXh811AdyQk5Vi+kiLxfwRDEW0O2DHd4kGHACOf4tQuf6xZXE11Qn5GEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJcgqOwK; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722430802; x=1753966802;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jj2TbI6V9j9WFvvTkkdt4Gbc8JoSZgvLARdZ6bwO3Y8=;
  b=RJcgqOwK3rYdgvN8FedoAYZmc/Y44IgytelGXA/05KuxJm4YuxV2atQb
   jt2kqEAqrtFPLu2Y7DSzUMEVCpxAnaqKGN2qf7ijn/Nna7/civaKSj++i
   gou3QCJVibM2U6S9Nf+eiL+E9fQ3a4tAmIHsuaK2f1ceWVOm3KplhFb07
   yfGMaq/7d0yu+uX94qzTQKPUEyKYIqhaYLhOeyN4lz0+TMuEddab+uNjY
   VU6RsIZHLeF+XGxo+sgondOtdb2neej7fbEg/u89x5qj7HFs3IG71vwDZ
   cwRVwXbulXfAWVcZ3P/Uok3t753PRoB75txUj9MixCkNh5iwmeIYORrL0
   A==;
X-CSE-ConnectionGUID: 8hkvh/N9TySwkErLnabeyQ==
X-CSE-MsgGUID: wJD1s8rPSZOFMAN3A5D6Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="24068821"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="24068821"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 06:00:01 -0700
X-CSE-ConnectionGUID: 2Qum0YqNTuKN6T+bjn3IUQ==
X-CSE-MsgGUID: RBRo5WurSYaO7MY8CLQriA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59737725"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 06:00:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 05:59:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 05:59:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 05:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pucL/GywRYc9S88WH2HylKd657rRNZfCIZDYSd/LBSjUoUvgmyK8O4XRBgLruLeNvSHRtstnLZlY4RELi1BderKcM5XkMgScesxSaWlq7y1hoi7tTQI5rR6+G5YsgQHMezkUd+AhBTGJv10DNeprlaQ9GjJo2IwKlLFdP7h06lhkeubyDnK8HDk6U9j71vp1TFckaV7AOgmuHn78H23KdtVMXL6YIwxpMemmMcJxxnx0x2X9mHKUSsirnN2klt0PDnpIdDF93VHoJlQzPp11tYTjHAHk85unQU8RyJqLFTAkfrRdpETYj22g2jNudsuhXUtwEGK8ui0+RECSlwaCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVRNwiIvINgZzuFIi+4uXeeiqAaJJFJSdfEdGx06SpU=;
 b=ug3OKW3QWMckVysHHjvgOevFd4FfqAmP6uHkLQT0Ek6InrAvlCr+4vzNZU0IGl/Ndov+TZOGfVjf0tnrDGqPcZJZio2Oz65Zy4FjmCaEthk8lYw200SEFSNPjzgQnyRWA2TeAw37qdFSLpxqLJ1DaKjUX11/IUYra09Yzr6X2Xo5gCFPYfdi/ekancKeY1B4eewXvSV14HU1ZxnL47VQfOvBW/ILC8q9QAY8/VSc2Ie1AdTgPHzdTcoLvN/2JpUVCDonoT0VmeI0DLrFz4ue99sNSfimJNeCNSph/AtyYueobWpiCBxZJxDfUhCR4BxaSGYaie2ovD972abfOIT6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Wed, 31 Jul
 2024 12:59:55 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 12:59:55 +0000
Message-ID: <79151d6b-1f42-4140-847a-5247c86eddcc@intel.com>
Date: Wed, 31 Jul 2024 14:59:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 3/3] net/mlx5: Implement PTM cross
 timestamping support
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, John Stultz
	<jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
References: <20240730134055.1835261-1-tariqt@nvidia.com>
 <20240730134055.1835261-4-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730134055.1835261-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::16) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: cb11514c-2aff-4e02-41cf-08dcb160acdd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1A2OW1EU1ZaNGROeVhKVjQ4MDVrU3pHS01BL09HT2J5U1BqbUdRQ0pHenhi?=
 =?utf-8?B?YlBFUWxXNUljTWZWWmdBck5xbExQNUV0MHhPem9xVU13TjBLcXpEeEE5ZHdz?=
 =?utf-8?B?WFJlU09zZTJtbGxJbWJOOXoyTVlEQWdqMjh1VzJxRnlkQ1NDcmRBYXFveVFj?=
 =?utf-8?B?Sm03dmhMMzVMV0tucDhVVDdsQlZBQzVTdDZkNHQvWjBUVEh5K1BiTmIwR2la?=
 =?utf-8?B?Tzd4a0hGS0swZ1YwUmh0Ukk0MzE1R0dCUkhReTJjcytxU29qell2eWZISXhv?=
 =?utf-8?B?MDVsL1FDMDd6TGxZNWI0QUpzbGtTelRKZnJUWDJQZUZWeElISTJJWXUrelht?=
 =?utf-8?B?Z3pZMkd1NGNGVGZDcDlpYXEzMWQ3SjBTSC9DcDdlUEt4OVY1RlFmZ1R6WFJ6?=
 =?utf-8?B?YkRuVTN4Tk1PaE5ZejdlOUY5cEVBUnNNSWxsNGxZdE1nbStVTHkva0t4WDla?=
 =?utf-8?B?ZDVucXBaT3NNWTF0azA0dk1FZEtQMFUydFdOVzVPbGNjNG1nZ0JjcnRwYWIx?=
 =?utf-8?B?TU1oZ2ZDcW51Qk1VTjQ3UW5UNXRlUjVZS2c4Q3RiOC80OVo2cDJCMk5pc0Ri?=
 =?utf-8?B?eVMxd3Q0ZkpNaUZQS1lKZ3VWK0FrNzhTUWdWdUpsZDYrTldvWjl4Mmp2amZ1?=
 =?utf-8?B?NmxCcTFDeWpCaUxOVGRxdXk2N29ZNi8vVHZSTTBxQnFsMVIzWUZEM2VkOXRo?=
 =?utf-8?B?Nm1JRTRpQW00dm1ibDVRdEZrcjNydnl5ZUYxOFJ3RFF2VVRzU2ZieEFFdzYv?=
 =?utf-8?B?R2o0T0VWSm56NFVHazRKUjNKbmVlNHBSZEdCMFgzaXoxNlltc3d2bHZOZmxW?=
 =?utf-8?B?UmlDWjNidjdKSlh1dGg5UnJsb3cyelBUeXNkNVJDVkt4Q08zbXVFaHVSaDFZ?=
 =?utf-8?B?TWpJSzkydE5VR0N4bGt6R1RVZFBEODMzSXkxWWFvSW5QTUUwUDgwQzhYbmlM?=
 =?utf-8?B?YVRVTGQyOTh2cmxpY3oyWGJRNTR0L3ZEYWI4dzI1elZKYmRXLzFYZTFHSW50?=
 =?utf-8?B?bWNkUTQ2eXVzbXpGYnY3VnIyeHZrQUV3QUtyc09KVmxDSTJMRXNXVGltaUR0?=
 =?utf-8?B?UTViMkxpY0Y5THNRYnJwMElyaHN2a1AxYzF2MkJuRXRHLzI5M3NwYzFxRENm?=
 =?utf-8?B?enpmZU4xN0ZPcUVzNzhiTGV6Nkw4Y0tmWUN1QWkrMDlPa1pwSzQrSjhOb0M2?=
 =?utf-8?B?M1FaWkNmOTBaUlJ6SUdNUHFkMUlVT05oRm0yTUc2QjdhNXVzeWl5ZGkvQ0l2?=
 =?utf-8?B?cVQ3VWczYmlGTmRCU0FFTnZ0S1V0UjNyTTMya29oWUlSTzlCbUY1OWV3Vk1Z?=
 =?utf-8?B?cEk3Z1pvSmd5RWk1eUxGNDE0ZThRd0NHWFozL2JsQUpBSVJ5Mmh3SWRqSUF1?=
 =?utf-8?B?anlZWC83YmxKS1FablpKMmFpNmhFSCtEaENlUjlEcDY1UTVEd0hkRVE0d2FM?=
 =?utf-8?B?ZHZtZXZxZVhmaTlCejdpcmJMY0VNZm9kcVprTFI3eWFibWNkb0s1NzVqTm13?=
 =?utf-8?B?YmFqb3N2Nk9aWmlWNEhsTFRKemJsOHhmMWsySDljS2F5THhaUjUvOXlnWFRU?=
 =?utf-8?B?NFJ0VlpZcUkrZXcrMW9Id0FQY2RaMEdVOE1Dd3ZQaUxUUXBJVURiS1hBbnJE?=
 =?utf-8?B?VFlDT1VkM3ptbHBoazdDZ2ZrRGZSaUp0MmJvY0xKM1lnVitnRVRIOEVQeDRl?=
 =?utf-8?B?SFpxVjlYOFlWZFhGWEZaRUxRZTVmWHRhc0x5SlJ1RzhtNDZqYWFvc2FIa2hN?=
 =?utf-8?B?MUZQb0pYUTZWMDVobjl6QXdjSDc4ajdBcnJ1UjJiaGRsRkpWT2hFMHcvcDBO?=
 =?utf-8?B?TWNqVzRjZU1nZGhCVFdTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0YrdlhtK2ZMaVUyVk9DQkhTbTB1U1E5NFFJbVpyM1c1OUVWN2E0V3I3Rzh6?=
 =?utf-8?B?MzlNK1hyZVo1OVphcDZXOUlTRll2QWxkTks1TnNCRjgzdmxLSG9YN2xyS0g1?=
 =?utf-8?B?cnpIOE5PT3VCMllyc3ZWNWJOenJESlQxUS9FRjI3SUV6L09kWElWOGVSTWlv?=
 =?utf-8?B?MXdISjZ5WGdrN3dPMVhaSGx2Q3o5V0JxNmdabjhZbkxMTUpXN3o5WWZHOExs?=
 =?utf-8?B?bjY0QXhLZElxejV5cGU2amtxanlCL1hOdUJLRHhrTWsrRWo1QW1SM3pWaGc4?=
 =?utf-8?B?aHd6RXliUXpYakxvS0dBOVhoQnpaMGpvb20wWVdhUGRkZTNnR0YyNm5hQ2xx?=
 =?utf-8?B?aGM5dk04QklwR2psaDkxTFhCYU92c1pzdlVKczZRS0didVJDaElVeWhadC9Y?=
 =?utf-8?B?dmdIa2c4Q3JHMVR1MEY1VnlmQS83Q3NtUkhreTNJQmt5YjNBMUVLT2JaTkEw?=
 =?utf-8?B?RGRzaEpPSVM3RytPZmZGMTg5cmpXRkVJeVJjWHpBWFRxRTVtTm5WYWliYlNm?=
 =?utf-8?B?QTA1Rm11WFViWkVoei92elh3eUFvdTVmaGlPWk1kQTI1U3YvbVBwQWtIYVNM?=
 =?utf-8?B?dHFGNHpycDQ3dndHME4wWFR3b21vNmRnV1dVV1Bhd2ZXNGlPR0RaWnI0UFlh?=
 =?utf-8?B?WnRxT3ZBQk5BMURoNWFDdThWbFY2cERiZllPcGU3MkZIR2FXdFNzaWVqUFU0?=
 =?utf-8?B?REtjT1VMbTlqYWdVRW03WERxaG1FZVVZYjVOeVBnaFRZbGltZUtuN0ZQaUIr?=
 =?utf-8?B?UGFvemgxWThURWVBODY4N0djNGVFZC9OemxXSDB3a294L0syVVlha0xYSElB?=
 =?utf-8?B?UVFCVjJVTWtPR3RZdGRvWi9leFdTSnNHUkl5NDVQRkV3VmZNOVBzWXVNOUdW?=
 =?utf-8?B?TkFqdVR4TXV2RFllZXhHemNtcTVUR2h4eGhlRmZrMHBwVEZub1NUYnM5NnRl?=
 =?utf-8?B?Y3M2UnYxakFEb2FjUFpWcFFkUjJzbkU1RWJRU2V2OVF3b01pYTk5clRSU1dx?=
 =?utf-8?B?d0RyNjNwZ0tKTHdwS3FBNFVyb1JKYTdXZS9xYmJMSSt4WlpzTy9KR1p5U1VU?=
 =?utf-8?B?RjVkK0ZPNlRGakUzejZGck85Y3ZpWTIrb3VoRG9jMmdpSkNJc3cyVTFwa1BG?=
 =?utf-8?B?RUR5SWdpTXZsaVFEZlMzQzdFWnM2N1FWY2ZOM3NXYkNQbW1Vdlg0Y256amhQ?=
 =?utf-8?B?SVczWjB1OHRHemRpajZVWHFKWE5VUk1IU1FmMEZiYlFqZ09DeHpPaEtMNnlW?=
 =?utf-8?B?WWMyMlVLVVlHaUg3RE16ZEsvMzlxQ0hQTTZMZVdQMUx1SkdLaFl3ZmdyOTM4?=
 =?utf-8?B?UENKdEFpSmFONGpnSXlrVXlwb3lyZjZaNjRTWUV3RFJVMmc2VnpFVDZ4VGIy?=
 =?utf-8?B?VFlkb3pONjdBVW5QSDdLdTZzWURWZlNSa1E5Mk9HaHl3cVo3L0xRRXpqc1Bw?=
 =?utf-8?B?cFNKbTFJUHV2S1JzVFMrcFZtVmNDSzBSV0tKeW0xZE8zVDFlMUxSRnhsRnNu?=
 =?utf-8?B?dTBoWStXM1RJaGdrb1lTZE1PQU04ektnd0hWSEpBby85dU9GRjdDemtWZDFn?=
 =?utf-8?B?UkY1NGs0MEFYc2pOMk5CMDR2SVR0N0xnV29tczZ0RmE1dW1yOTNoeXQxSkF2?=
 =?utf-8?B?LzZuZ2toaHAxTTBmeW9pQis0QjJkT2FNS3Jsa1E0dy94Vkx3RTVGNVloQjAx?=
 =?utf-8?B?S2Y3SGF6MWNiQURzNWhJSHFUVjdIYnd6UXJPMms5dEwwRTVOVUU0TTNYdUVX?=
 =?utf-8?B?K2h5anlSblVaczl2d0VyUW1nczdjaU5Zc2xuZVUrMEY3a0kwd2lEbDRXZm9Q?=
 =?utf-8?B?U24rNHpXRTRhdjh2NE1WeUttb0s1RzNLUmszZWJKdWJJdGE4ME8zelFMVHFm?=
 =?utf-8?B?MzA3RHpHSm43cWFhZWUxSG1XT3prQlZRTzVuRWl2VkZVNDRTUC9UQlRQYjVO?=
 =?utf-8?B?ek9POFFhdnRGcnY1emxGV3NTczhEcFdiVVEyUkxncFF3UW1tdG5MYkRYTnBa?=
 =?utf-8?B?Y1Rja2RRdzYxV3dMTTdzeHFDMFVoL3V5TlFyS1pOSThva25ZL0F6WW1OQnlm?=
 =?utf-8?B?ZnlBbm5CSklvZ3d4cklsTFhEb294QURhTFdqMm9abFB3Q3dTT1ZZUW0zWklq?=
 =?utf-8?B?WEVURFExVDArcXlaRWhCRVlPMDFlZ0V5YXY1QW5heUEvVXpPU0REZEMvNG9K?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb11514c-2aff-4e02-41cf-08dcb160acdd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:59:55.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thyBW4Lc/WKydiJO2EleIk+KdjHaFTrdFVJuoDEZSI+hjU3phvZuXVPTBKqPWKyGBcqh5jYPsO9tjIJtUS4+UQ9bxZXZqBQX2DipLlDD9nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com



On 30.07.2024 15:40, Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Expose Precision Time Measurement support through related PTP ioctl.
> 
> The performance of PTM on ConnectX-7 was evaluated using both real-time
> (RTC) and free-running (FRC) clocks under traffic and no traffic
> conditions. Tests with phc2sys measured the maximum offset values at a 50Hz
> rate, with and without PTM. 
> 
> Results:
> 
> 1. No traffic
> +-----+--------+--------+
> |     | No-PTM | PTM    |
> +-----+--------+--------+
> | FRC | 125 ns | <29 ns |
> +-----+--------+--------+
> | RTC | 248 ns | <34 ns |
> +-----+--------+--------+
> 
> 2. With traffic
> +-----+--------+--------+
> |     | No-PTM | PTM    |
> +-----+--------+--------+
> | FRC | 254 ns | <40 ns |
> +-----+--------+--------+
> | RTC | 255 ns | <45 ns |
> +-----+--------+--------+
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Co-developed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

<...>

