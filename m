Return-Path: <linux-pci+bounces-9198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37A9152A3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 17:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1D31C20FC4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939F1DA21;
	Mon, 24 Jun 2024 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nizmbDv9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88F1DFEF;
	Mon, 24 Jun 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243579; cv=fail; b=O+WghisYSr8G0VXgmKZferqhVrHAndmCl/7b37eNYIOqINzufu3A0yHDcbzgMNS2XtIG84Y9t4MhehWXLTNrO/rfpJ3ynYDw+MLZRbywjSf2d+LdmdhHfYvoPeGvdJ+22HURlA9Sl4u18dzpQ996vTMLv2+LoHtZMunzCvzHrzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243579; c=relaxed/simple;
	bh=d1UQoQJgw7rQHfuIMj5FHFR6F6P/NYr5cInj1390ULU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYckDWSuusbR0g4INGmQZlDsUTrQp+J3yq/0zjq91oNvWj0CITD+i05bmnyi5rxg3JiuOu6wyCQ6d3MgpiiVpXkIIS/c/7uEVp4V7NlNVpf8rFY7GTPMcHEqi9Vs1XcCj0KXciwgsRWY9eweL2FrMCArMXXJwxB4R4kAAZa7oe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nizmbDv9; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719243578; x=1750779578;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d1UQoQJgw7rQHfuIMj5FHFR6F6P/NYr5cInj1390ULU=;
  b=nizmbDv9TfMb3bIOR7UzVK1QTC1YxiNP1UCHNkIl11TCtu0kesZFSQW8
   Vz13m/3B18dPYxOBB+hk2nEuXW1dYU8NyNoOD5+NPZSflrtb0Ri4tvWiY
   U46q6ONadyiib2iTYIDiPVTEl0eX2L323z22Efbb3RvxSzF+t6LSW6XAR
   qGEZ/lIyepYKMAdB9+/Bi+7v9VCRR2RQeIKzHx8ebTBRqJIbdXUWRmDAL
   3z4FcyUCciE0IQh+F1R0yv7qyE5R+hnox+nnUVrTuydJgpQCGNImO/vZS
   XQbilpXOrvNx3S1ySDVMSF9EZ0iXs05ck+kRq44889Jaw0ra4wNxrDJuL
   Q==;
X-CSE-ConnectionGUID: yueXkeEnQpyIJGbCWhFn9g==
X-CSE-MsgGUID: cpfyQ8p3R2a9LtfdXbVKtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16364269"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16364269"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:39:35 -0700
X-CSE-ConnectionGUID: mSVthFj9RDmWY4oLGzwvQA==
X-CSE-MsgGUID: q/TvFGluR1ugn5RIHNEeSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43148098"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 08:39:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 08:39:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 08:39:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 08:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7GmIHAPZXpmQGs3K5/1+v3Vrkf+gORDKJSxS5Yw5FS+vzsEHrpjDhau/90++LgV6/jxAama0Lq4EkxAzGptblPXqgz2vx3zJjYaycCJxMHK3CcOTHgSdd9eHZ0IPHei2Wzrh9Xn6ALph7GL11oJ8zSOYjjct04KVyWZwVNl1Tb4ky8QvQD5MMer7mGwnrntDDo6lhj+XTx7F2Yd7fvydQtfiYLmaYGbb2tIuh9gtB4VORCrNOkmXYufnY9CUCsRdMY1nElp8M4JjDbPSI5Yth1vPq/QllkiuNJsxMTGgM2UPsTrHbNvdbRz7nY3FMsWT0vAVbaqrwPPPtj8z7xMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzUYTpXH7IE7apf5bg5ad2BeVHizgHq1RLZpiVhhh0g=;
 b=Y16NW8jpb7DF4shLJquw1mvsHejEJi2r9rWzEbM1SE39a6oA/lCqBfNTM/K9j5QbWtvKKu2jYCfJUci8dLhClf4GWcjAeLhLHDahielcupZuZhnbESoB89J15nhDfhbqMtHZ4hNWuVqiw5yPf55EA5ppDdskWzrMikr1LnOOYQN7AhCzZc0T/UgQ1fO/Jng9mJaHxfmr/v2+nakoOzyraMAeGPbC3o1ax2L1Rs2bOq3cuXY0gTyQqY0H26WfxSDTlta7LB583Dcf86waBYvopCNISCBnQTmc0jFP973YrNSWNrJsWqjvvMspD38Jy/fBl2Yf2d+QoFMuskEHEJaXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH7PR11MB6425.namprd11.prod.outlook.com (2603:10b6:510:1f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 15:39:32 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:39:31 +0000
Message-ID: <897ead26-be10-4bb3-b085-1b8c97d93964@intel.com>
Date: Mon, 24 Jun 2024 08:39:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: vmd: Drop resetting PCI bus action after scan
 mapped PCI child bus
To: Nirmal Patel <nirmal.patel@linux.intel.com>, Jian-Hong Pan
	<jhp@endlessos.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Francisco Munoz
	<francisco.munoz.ruiz@linux.intel.com>, Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>,
	Jonathan Derrick <jonathan.derrick@linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@endlessos.org>
References: <20240624081108.10143-2-jhp@endlessos.org>
 <20240624082144.10265-2-jhp@endlessos.org>
 <20240624082458.00006da1@linux.intel.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240624082458.00006da1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH7PR11MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f90287-1622-4b53-1052-08dc9463d777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnNQaEQwZDh0ZnhKVUpwU0RpR2hHU0tsakRtTHpSWU1CdVJza1ozUWg5bzdP?=
 =?utf-8?B?bk1TK0NkTUtpSWR0dzhTUUZobVh3dERwVU5JN2Q0VjBPSWVRcDhIbzFKeTd6?=
 =?utf-8?B?clpvdTNhNkozMnlBMVEyMWhmcG9aL1B4NkxERGpvOURFOGlqUndsQ1lyR25K?=
 =?utf-8?B?TmJxQlhFREZJcC9TaWtuMEFFaW1hNVRRMWVqM0R4V0E2MDkvMGM2NVVaVmRH?=
 =?utf-8?B?NWRxZjhRZGdxeUs2bVVESjN2Rng1ZmE1cHpuek8yUkgvMk5yRFlWT1B1ZVRy?=
 =?utf-8?B?SEZiRkp3a0c4a21YQUVYT2lycGQ1b28wSWo1bHJtOHc5UkxGNUlrNFhqYkdj?=
 =?utf-8?B?RzFWY244anQ2S2tYMGZGUHVXcnFaOEpLMklmV01MQ09JdmhqT1o5UktnRENO?=
 =?utf-8?B?VDRSR3FhK1Z1YUI5ekE1OHprbVE3NUVDbUFmOXNybmxVQTNGdTNaZ21ha2Nz?=
 =?utf-8?B?ZG1vY3ptTEY3OHBYcmNZTVNRZ29QSDROK0pqZGtsdkVpRFZneGNwcDFaakI1?=
 =?utf-8?B?N25LL0pXcElTZmt0VllOQVU5cTk2NGk0RGR2ODRYUHNOZ0dnWWROc1RpSFpT?=
 =?utf-8?B?eUlrTnpGeGlGWkNCTWxVOXpnOEtrRUVodnV3YXRKQnRwdk5mNDJtVGdWN0xw?=
 =?utf-8?B?UXBNREtuTXJ4WGd2QWI1dWsyV3NKVndHNlRzbHgyRTR4VkRqMTE1SGd3RjRh?=
 =?utf-8?B?YTFjY0ZFMW9LeE9oTjRpYVV0djdiZGRqb1VZR0FJa1Z6TW9qRVBheEc3K3o3?=
 =?utf-8?B?b3B6aW45L3NzcDVRRWZacFBudHhGa2xLYzNDQjZnOFRPMEpyd0NNWXVRWm1a?=
 =?utf-8?B?RXo2U1h2RGNjQzM5STZxQ3IwdDdQa1Z3TkdhN1pzNkdBN2lzWUJqM2JhUGlS?=
 =?utf-8?B?T3hzWG1vTzNoTTVuQlpLcnMrZGdidmU4Z3FDZUlvOCtSKzlhUTJuWThzZWcr?=
 =?utf-8?B?dDE3MGtkcEVNUnF2YUxwc0VQQkdUNGROc2pSOTdDK2hWTE1tYWl4TTJQaFN2?=
 =?utf-8?B?UkFXczNnNUJCdWE0NkFOcjIvZmFPQUpMbHZ0ek5ud2FtdmZjQmhYbnZmTkdj?=
 =?utf-8?B?RGpCM2RDNDdzY01xTndKYnlBQ2VtbVM4T29sR3NOZWVXOFE3dkNwaVpuT3lF?=
 =?utf-8?B?dHBXTmVDbDJhUDZ3dEdqaWprcGhKeDlUZHZ1Tm1aNEt5dGY3T1hhL1pBa0Ry?=
 =?utf-8?B?dVUySUhQNi9JWE5jZjBka05VZW5MOVNrRU9hTndOYkU0MGFtYkRvYzJpdXNK?=
 =?utf-8?B?UlNId3BFL0pUc2ZTeUZqeGNkSGlIdE8wdUJZT2tmN1RxRElGOGFsMEF6Wkx2?=
 =?utf-8?B?K2gxL2lkRTN0dDh0QStGWGNBOXAxaUNvN1laMWVUZWoxOVhtdGhIR1BVZ1Qw?=
 =?utf-8?B?aHdTTGtrYmxWSHh5eXdCK3htMzlhcWVNNVI0VHFsQ0pPWkZ3eGptMnJyMlFr?=
 =?utf-8?B?bG5LYnRUYTdXdEYxalJJeVlZNGErbXJtKytROFVkTnorYm5jVDNzQjZBdFFV?=
 =?utf-8?B?dmZ0bU9NdzR5M1dKYk5JZEo4QkFncHFaV0JGdGJMS0VzWHI2SUZtUUlBY3B4?=
 =?utf-8?B?NXlwY0hiYkt5cEpwZ1hPUTJ2QS9TM3U4RnJEdytraUxkUFpJN0ZGekd2MVBx?=
 =?utf-8?B?c004YXdGekRZSDFpVHJleFlPaEpBTHFMMHZSZEwzamZQdC9DZzg4WHptZVlj?=
 =?utf-8?Q?EjOfwyw/Nq6Nf38c70PZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHIyWHR2bENxRURoOEp1cVk4d1pWL283bEp0Q245c2lWZVBOaGRuVHZwcnlQ?=
 =?utf-8?B?SHkzM0ZzUytmL0w1TmdTeU0ycU1kUzhZQTZxR2pNQzR0bS9rZWJnMFU2amhP?=
 =?utf-8?B?MHkwQU00R3lDdXRzK0lxRStVbVJaU1ltVDNMWTZrbUJvUmpFQXY5aVB3QkZl?=
 =?utf-8?B?ZFE3dVZsOW1EVTRiM2IxUm5nQUJTMVp5VnNvS2NyWWdHejMwU1Y4cEk1TDVP?=
 =?utf-8?B?TG9SUEI2eVZrLzV2cHkxVWdqV0QrZ3RXL1pTdGs0cEJVWWRIUDZNWStnVkFx?=
 =?utf-8?B?SWhIemJ0RnFXL3JSQjREYThuSGJCbm5KOSs1N2FsR3ZVSHUxWCtYeGM3QTV3?=
 =?utf-8?B?K0tuMTh2ZFczQkRrMU1HLzNPZmZEUDZ2cks5VTA3THRxQzFRVEpjZ0I1VzFF?=
 =?utf-8?B?eC9oQU1nK2h6OW9wUjFvSzNBTGxaMG1PK0Vudkp5RmZIZVVNNS9tVTlPSFdv?=
 =?utf-8?B?amdxdnQyWDgwTVdQOEd3UmpIZHlaUER5b2RHem52TmFma25NTStsemgzSWdl?=
 =?utf-8?B?UVVjYWlhc0xET1BWNElCeURFK21yV1pzYzJNbFpURmROY1pZWWFCbENxcDBv?=
 =?utf-8?B?ZkJVN0FoL3ZKWTNEL1ZnQkpMMzhaL3oxS1FLWDEraW5YODZSM3FQd0tZUllI?=
 =?utf-8?B?S2JmM2xzNWd5NldjK25ENHRlUVZCOVJvaVQxcVVxVzVVc2hCcG1rczBTd1ZK?=
 =?utf-8?B?cVBlWjhaemU1S2ZkVWdqeXU4QjM5TFZQNU1hcXdEV3FJNHdJRzhJVkgxMzV3?=
 =?utf-8?B?R2M1TVplOFUrUHUwYUE5VlBvdWZwOTEwTTU3VlRtRU9XaERrUUt6TTJqZ3Rq?=
 =?utf-8?B?WEQ3Qkc2T1h5NjM5Z2laQkpNVUZ4ZXc5U1B5bWEzU2FaaVRLYXV4ZkZSTlNK?=
 =?utf-8?B?cUJSTExjU3VNRU8zRlpOejNkeEg1OEx4czFoU1dFNVp1Y2trZ2N1ZEtuVnJX?=
 =?utf-8?B?b2pWYWVVeVVjZ3hmSTFBbzhyUHhHZWswMlQva1hGTEkzNUJDekpabFNJU2xK?=
 =?utf-8?B?ZHd6Mzk3Z2VSRDMxRE9abWJCR2JHNTlyczMybHg1V1RvS3pNSEpIYm9aOUd2?=
 =?utf-8?B?dXNJQ3QreEJTTW43R3BmQlhES0x5MFFXYWZUaCtSQjcrdno4MVpOQ0xieHpG?=
 =?utf-8?B?WWNiQTN6cXdpcVpsRjFHUXBBOGh0b1MyVUFTZ3d6WVZLSlI1Z2tJOXppNEs4?=
 =?utf-8?B?N0RwWHlUMUpHYWFhUFdZSlZwRzJBRHZtU1RCQWZCdmVyaW9IajlQQXIreHhF?=
 =?utf-8?B?R1JzajdSa0pEOXh2c1ZCQmRjaXYyTVZGdDB0MEZvS0Q1SHRjWHNOZkJsd0ls?=
 =?utf-8?B?SlR6akFNTTVzb1ZZYWJndDhNT1VxeGQ1RE8yWEtwMC9ZdGkySDBsM3BKNmN4?=
 =?utf-8?B?YkdjbHhMVDdiRUl2MXlIYXptdWVmbFQ2N2Vrd3JpS2RBOFNHWDF3NUlkS01p?=
 =?utf-8?B?NzhwR0J3aE9KYlNSUkZIekMyNE9IVmxPWEpsL1pRVElTbW1SYmRNWkZHMHVQ?=
 =?utf-8?B?NzYwbThTVmYrUTA5bVphRUtkQ2ZybkFBbWY5NjN5cC90elo1S3plRlhVckQy?=
 =?utf-8?B?U1lsMjRIOFZQR3d6YTlMRUs5ZENNRzg5ZjA2cWl1ZmVlRjV5TUxNRXZuUXVY?=
 =?utf-8?B?RGJNbHVTaEsvdG1VN0QvK0Z4ODNnWGZOVVh4VyttQWxMeGZqV01QNi9sV3Q4?=
 =?utf-8?B?NnVLb0hDeG9UaklaZXJuQ3ZSTENoUVlBU1RkbkY0Njdqd1RWa2RUakdKcmZ2?=
 =?utf-8?B?WHpwNDl4UVQ1TWJwUFVuMTIvbkR5WXp0V1R4cFYzT3BicFBrdldxejcvbFVV?=
 =?utf-8?B?T0s1cVI5Y2wrenZBa1hmcXZKclRPNkNlY282ZGRZQ3RtWmpCR3Fna3JCV0Vx?=
 =?utf-8?B?MlJONk5wQTBHbjByY1ZvSGpuSE5FYlhaWWZqTUNYN05kdXdEUmV6VnVvTVh1?=
 =?utf-8?B?SW1xZDQ2Ni9BQTQ3OHA1TlBEbDlkZVMxK1NwOC9NOXg2SDk1Y0c5aDkyMmxh?=
 =?utf-8?B?Z01WOWlOVFd5SnA1NDRkYTcwZjVVNHl1VlBuUG8xQzZ2WHg2blhhODNEWlBu?=
 =?utf-8?B?ejlCaGdHb00vKytmYzlSYjdweGlPNFA3aXQreXpESTJtY3BKVnVpRjMvS2lM?=
 =?utf-8?B?S05YRk9mcTJPYWtrZDJBMmU0cVIxMk5uUFZqRlRUWkNHSHdYWWpZbTBObXBO?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f90287-1622-4b53-1052-08dc9463d777
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:39:31.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8j/Z8LAxTEgppdiLh9xDB57+MFlqxm0CN+bjMdOZIra5qG8G0/bG0dVllh0tZW020gdJ+0vOflnr4QmdSDfRFJw3c++NqkvXYK4/nMZ3m4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6425
X-OriginatorOrg: intel.com

On 6/24/2024 8:24 AM, Nirmal Patel wrote:
> On Mon, 24 Jun 2024 16:21:45 +0800
> Jian-Hong Pan <jhp@endlessos.org> wrote:
> 
>> According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the
>> PCIe Root Port and the child device, they should be programmed with
>> the same LTR1.2_Threshold value. However, they have different values
>> on VMD mapped PCI child bus. For example, Asus B1400CEAE's VMD mapped
>> PCI bridge and NVMe SSD controller have different LTR1.2_Threshold
>> values:
>>
>> 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
>> PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
>>      Capabilities: [200 v1] L1 PM Substates
>>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>> L1_PM_Substates+ PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>>          L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>>          	   T_CommonMode=45us LTR1.2_Threshold=101376ns
>>          L1SubCtl2: T_PwrOn=50us
>>
>> 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
>> SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
>>      Capabilities: [900 v1] L1 PM Substates
>>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>> L1_PM_Substates+ PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>>          L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>>                     T_CommonMode=0us LTR1.2_Threshold=0ns
>>          L1SubCtl2: T_PwrOn=10us
>>
>> After debug in detail, both of the VMD mapped PCI bridge and the NVMe
>> SSD controller have been configured properly with the same
>> LTR1.2_Threshold value. But, become misconfigured after reset the VMD
>> mapped PCI bus which is introduced from commit 0a584655ef89 ("PCI:
>> vmd: Fix secondary bus reset for Intel bridges") and commit
>> 6aab5622296b ("PCI: vmd: Clean up domain before enumeration"). So,
>> drop the resetting PCI bus action after scan VMD mapped PCI child bus.
>>
>> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>> ---
>> v6:
>> - Introduced based on the discussion
>> https://lore.kernel.org/linux-pci/CAPpJ_efYWWxGBopbSQHB=Y2+1RrXFR2XWeqEhGTgdiw3XX0Jmw@mail.gmail.com/
>>
>>   drivers/pci/controller/vmd.c | 20 --------------------
>>   1 file changed, 20 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c
>> b/drivers/pci/controller/vmd.c index 5309afbe31f9..af413cdb4f4e 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -793,7 +793,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
>> unsigned long features) resource_size_t offset[2] = {0};
>>   	resource_size_t membar2_offset = 0x2000;
>>   	struct pci_bus *child;
>> -	struct pci_dev *dev;
>>   	int ret;
>>   
>>   	/*
>> @@ -935,25 +934,6 @@ static int vmd_enable_domain(struct vmd_dev
>> *vmd, unsigned long features) pci_scan_child_bus(vmd->bus);
>>   	vmd_domain_reset(vmd);
>>   
>> -	/* When Intel VMD is enabled, the OS does not discover the
>> Root Ports
>> -	 * owned by Intel VMD within the MMCFG space.
>> pci_reset_bus() applies
>> -	 * a reset to the parent of the PCI device supplied as
>> argument. This
>> -	 * is why we pass a child device, so the reset can be
>> triggered at
>> -	 * the Intel bridge level and propagated to all the children
>> in the
>> -	 * hierarchy.
>> -	 */
>> -	list_for_each_entry(child, &vmd->bus->children, node) {
>> -		if (!list_empty(&child->devices)) {
>> -			dev = list_first_entry(&child->devices,
>> -					       struct pci_dev,
>> bus_list);
>> -			ret = pci_reset_bus(dev);
>> -			if (ret)
>> -				pci_warn(dev, "can't reset device:
>> %d\n", ret); -
>> -			break;
>> -		}
>> -	}
>> -
>>   	pci_assign_unassigned_bus_resources(vmd->bus);
>>   
>>   	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
> 
> Thanks for the patch.
> 
> pci_reset_bus is required to avoid failure in vmd domain creation
> during multiple soft reboots test. So I believe we can't just remove
> it without proper testing. vmd_pm_enable_quirk happens after
> pci_reset_bus, then how is it resetting LTR1.2_Threshold value?
> 
> Thanks
> -nirmal

To follow up on what Nirmal said: why can't you set the threshold value 
in vmd_pm_enable_quirk() since we look at LTR there?

Paul


