Return-Path: <linux-pci+bounces-43326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2ACCD704
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E1A301B4BD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B382221FBA;
	Thu, 18 Dec 2025 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcCqEob8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079A21E32D3;
	Thu, 18 Dec 2025 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087421; cv=fail; b=TMd8VnCpZxJT5sCdPO7okZmUHzZjGoIdUll+OvIXZHqOis0C5fTkHWvqaLvf+C1dKvh8jg/zOASoaTZqMkO8hrUdF4y06ES5kREFdqXMQM1+EP0WjSUeyasjou/nnWtl8/OBHV60VgK73tvAes3Z+kw0T4uj0lu8I+E/G9HgsZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087421; c=relaxed/simple;
	bh=4Pxsiyc0mCM758NFmhsCvlxD55vFYnztbHTBzOEHZ8A=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YqLzG3IMdtBPShi1lrrr4qshaou3+dFhAhVctKUk8IYMExTE7ES7KePX7vcczKxCB4xmHT/2CuLSEMu2ta/BLMY5j82LM7cBJhKEptfgg3NRaVcxRFyoE+aeVkhOQ2RapIFRj2kk55Ttz/c9dqKZH/4tYmgDhqUYqsslYLCcQLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcCqEob8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766087419; x=1797623419;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=4Pxsiyc0mCM758NFmhsCvlxD55vFYnztbHTBzOEHZ8A=;
  b=jcCqEob88poMaOkGNeUry5Tn2DKjlc8insJf74OtJBvcImlqh9j9zl29
   BQUhSKpvnJKOG4wGNkRnaJT1QCQSy401pmbksCBqgdkJCWM1X1OFXA+8i
   syUE12VcGxW1kY86LLWZWTlbmjO0H0wuhthjDYwuvatxSyMTaAG2HBJUa
   LqCKtzZWqwxAfDQt9w6YMVu4kfSYoMKM7nWYiJeIM2IjHj+6ldh5hbZqO
   1/3GJ9Hhvoamqf0w4fNnAbrJWFJZX5rNey7H5Qja3m6+Q7wQPc11wIxCt
   bvV2O3Vr1qWiCgbF+1D9q3QC1djpsoQ9BmHsrd2wT9TP7/MI5Y+bOLPvh
   w==;
X-CSE-ConnectionGUID: z2vMUqyoSQK4zqNL4FzLAQ==
X-CSE-MsgGUID: vy/mf6ZyRGCS67ZR5qMrog==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="67943059"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="67943059"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 11:50:19 -0800
X-CSE-ConnectionGUID: 0JzdbRMtTQGI/5WlHMyOrw==
X-CSE-MsgGUID: 8Rw4NoklSGOobOVF/Py5Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="198579230"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 11:50:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 11:50:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 11:50:16 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 11:50:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg3vdfWntTn3bYkcfpmK9Rnwze3JZ61EFZNhmEjoMZQ+o5V05qbPf1DAexPKK3i22AEyqmsuEuKejN/Nsq0YG2Y8xGHbrIlyjVVW9gtEMZ15iwxEfDy5Up8FFwOXQx4jzhozUWw9u+Dc03qIlqAuZwHvYXoyN4pONEe8HwRjX0gIYzp9tXPTt1DhrhjWtfrMYIp6L4IztajMr547UEEOKgHNJcixBoU22A7gfqzbGJLU9xM941xy5QKh11duOOuXesaTSXSRZkXIWUDUEcBxV3hMkRnb6vAcLtECz5puVsHi6FJsoybqWrinoNGvKDSm0Z/LmR32XrO9EtXlGpVy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N84PjVV1VmyE+tmhZKRl0MaaSWkd6tHJhsAAdzKwf4k=;
 b=gImDgT2mKT/wYGypImv+GvhWjBHrV96nUeqyCgIGMYXmpME1cgqyXNDWnI2nBy6knChFAKxneH3jBq9YSBaVmGk7pDTcupW5lAEYJPNjmO46HneCEkuCCLbf6O6as+PDtiDzu7d1vIFzbT/kM7FvB+eMt3M71EHL0ZJ9gZ4/Dkm6cczz92LMc2Uy5eJHZw43jN9DsXU6854K+SSzcxQsY2ouVdJLI4MfyU3SZrJHBm5Eu6Lxa7gEkG/idSunU0meklUvwcdXXtErM7ZQ14KUkW2TF98qfEVIJelQGsChg6b383PaugjjADLCy/mfxJV+kx/4MCawRG38HbyLOlINsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7714.namprd11.prod.outlook.com (2603:10b6:a03:4fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 19:50:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:50:11 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 18 Dec 2025 11:50:10 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alejandro Lucero <alucerop@amd.com>
Message-ID: <69445af227f36_1cee1009e@dwillia2-mobl4.notmuch>
In-Reply-To: <20251218144608.0000238c@huawei.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
 <20251216005616.3090129-7-dan.j.williams@intel.com>
 <20251217155712.000012da@huawei.com>
 <6942d9d46e09e_1cee10089@dwillia2-mobl4.notmuch>
 <20251218144608.0000238c@huawei.com>
Subject: Re: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for
 CXL-dependent operation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d224a66-84ce-4c40-82ff-08de3e6ea7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUNlenRTbTdUKzNYbFA3U1hBMjRydGl4Z0IyTFB5VlgvRDFGazQxaEZIcGkw?=
 =?utf-8?B?YStmMzVDVzFCZzljdnAxc1lBV0t4b0hFMmhCcm40RGt2S1VKTDR5a01jRXlo?=
 =?utf-8?B?djRqclZZNWF3TW9tMk9TN2MyOTBhU0pXc0JqY1EvNk95eDlkbW9vZTN4SVdD?=
 =?utf-8?B?b0ljVnJoV0tuUkU2WHc0RzZhaXdJcUhFK3IvSlhyWmpTQUNyVUhvcmZUYzBC?=
 =?utf-8?B?aGRYQmNqQXZiZ2p2Mkw3UUo4ald5S3E5akN6OTBpSUozeis5YW00c0dXQWtR?=
 =?utf-8?B?VDAvK3pCd3JiTS95aFZiNTM1MS9LZ1hvTExyVXR1ejE3Nmp4dHQ3b2dlU1k2?=
 =?utf-8?B?U2dXc0ZOTm9WU3E4aUNsdHkyQkhBQWVka2RwdmhxdEE0c2QybC8yMFF4SmQ1?=
 =?utf-8?B?RWhKSGtueWo1bXRNbzh2c0xHOGN1RENQZnZpeXlqNDFNN3NRbjF2MFdQc05m?=
 =?utf-8?B?Vkw4TS91MWNEcGdVTGxKWTVRL3VDcVJGWS9sOE9Pa0QveXo3cjV0MDdiQlZH?=
 =?utf-8?B?K1A2SnhDOVVKeWVLbUlGS0o5R292QS93bDZNNDFGeDNPTW9wNWF5YjEzYmIy?=
 =?utf-8?B?TTM5eWsrZ1BrSmxGUGJObVhQY0ovMVVyVW1xay9UR0ZIelpEZllDc2l2bjhZ?=
 =?utf-8?B?bmdXazE4Vm10YS9Wc0Q5OWVNS3RQamhNamRESWRZWjRORTJPRnE1Yi91N0c2?=
 =?utf-8?B?a3IvaTF2LzM5N0xTMlY1SmZnUEsydVhIcFZkMEpsa002VWRxY0lwSFgvUm8z?=
 =?utf-8?B?SmlEVkEzT29wQ1cwVnUxQ2QxMFpFdlJIOUUrWG1LUWsrVndVdFhSSGp6dkRw?=
 =?utf-8?B?R2F2QndldmpTSFVZVnBzV1QzcDEyc1RpQkR6NkphRXd1NTRhODZseUgwa2hI?=
 =?utf-8?B?MzZwL2JDejJ6SVJzNmxEMFhVL1A1NlQ5YndNWVdkMXVuWWpmMkpzMHRVdFRq?=
 =?utf-8?B?REc0UzltUEpqdFowdG9iNEtDczgyWHczWDUrOHNPREowb1hEdTI1MDl2TTlZ?=
 =?utf-8?B?SjViaDN3L3BoV3VrUE5KWnhiSkw5ckJ0ZmpNRkRpODRYWHlaUTVmRnNCaXFW?=
 =?utf-8?B?cW9TV1UvVkFOZTV6ZCswMkxJeW1iSklHckpnQ3grM3M4MWt1SUxrZmtsSXB3?=
 =?utf-8?B?dTBjN2daZEt6NXVtTkFGVlhHQllmZ1JlcE5qTTlpRC9YRHBHazNvUkEyb21j?=
 =?utf-8?B?QWEzdUt1b25LVkNRanhRYlhVaXFmb3hIMDkzdTNkRDBTNTFBUlRRalEzaTN6?=
 =?utf-8?B?VzdwbG9Ma0lMdjh4bTRRNDREMHNCS3pvclZVdkw2dHJpUlVoV1JvN3JvNDd1?=
 =?utf-8?B?am5FOHV1eTd0T1B3dFQ3amZ0YWlFdk1pUGw2cXArbzhtOGljNmZlSnV4V3Y0?=
 =?utf-8?B?UXkzNFo1VFNHckJZUGZocXdhUlI5TzEwa04rU0tBVjZOaHZpdlEvNDAzY1ht?=
 =?utf-8?B?UktyczhzY08yR2R6eU0wMW1zbHZkZFliZTBKMUNXaHNYZ1pBbEsxcjlUakdp?=
 =?utf-8?B?eDc4QkJnVzIyd2VybldGOFB3KzhFQTFObWtnVDRXWDg2Z1JSc3ZucWNSNFBC?=
 =?utf-8?B?aHVvbmlNN2M3ai9RTHluRGNkUWIwbEx6THJWOTliQUNzK2g2L3pmalhXTVBX?=
 =?utf-8?B?Z2Z0Z21GaHVNQ2xBb2hKRnpuWnFZY1o4bDQ2ckNoUXlqU1V1VldjbjV3RDUy?=
 =?utf-8?B?QUFlN2t0LzdjZ01BT3lqUTljRnU4OWNzdW9zdXZJNU5OZmlQWlpCTGtwM0FX?=
 =?utf-8?B?WUl6WGg4VzlZM2tFMzByVVF2b2pkb0cvMVVXcnZrbEdMVU4wa3k3cFVqa0RY?=
 =?utf-8?B?MDc1eVIzSnRadm1ZampkdVlBbGZSMFRJTklrd2V3RWllZVhjRzdpbW5wTEc4?=
 =?utf-8?B?SENaSmRDQnZocjBtWUhWNUlXSGcvTmNpRnEvMFVSV2VCV2VVTHFBZ1pUSkVB?=
 =?utf-8?Q?nDLYQHfTRYR5eEiuF7LZ/502bR2pNSHP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJEUHJDNVZTRTBzbTN0ZDUvb0IxZUJyMkhwdGxRbm5BNDVkZnNlTUJidEw1?=
 =?utf-8?B?TUdxKzlkUGdMTGE3Z211T0llU2I0VkZqNnR0TGJKWjM5akV0aHhRcDU5bXYx?=
 =?utf-8?B?dTl1b1JVUFgwQm1uYTQzOU9CN1puTUV6cEhrV2VlSDQyQlpic2RIcUpHOHBG?=
 =?utf-8?B?ZUJXWWtkSkYyQXFOYnBwMXRZZTVqSGdTMnpCV2NndkY1UUM2R2duVU5yZlVx?=
 =?utf-8?B?NHp1YS9IZ1U2WjRjMUlrclhBcnNuRTV1ZDExY1NyZFZvUC9KVG5vZUFvcStj?=
 =?utf-8?B?eVYyR1ZKaFZUdmxmZkdvbEpmMVNSbkMrbmRpL0lrVEg0VUowKzlnYnlmMlgx?=
 =?utf-8?B?KzVLK29mMHlaZnpsMDZyVHFCT3d0MmhLRE1CWUVxNmZ3a0Fya1k3Z2poVHcx?=
 =?utf-8?B?QTNvQzlLcUhBcU4xdWd1YmpqSGt0STZmVWdDcVRKdGNaUmZnY2kwb2Y3bTB3?=
 =?utf-8?B?cHpXTDBJVHM0TXJCWWZkRlNSZi9XUDM0dTduTzNDVHZaazhYY2s2dWlabWRQ?=
 =?utf-8?B?Wldkc3daM1Q3QnRRdjlCUE1qU01iZm95dkh6cXVrME1oQVg0eFNNNkdsNmI1?=
 =?utf-8?B?bVg0SU02RWdlV1B4RGc2MGl5QVJVVmxGSUpIVE1PSkppY3NPZkNZTUJxR3ZW?=
 =?utf-8?B?UzFkbEc3TlNmcTBuRkxSWFQvNzVDUXVWblJRMGhPVVplRmFCMHgxSW5OOUJM?=
 =?utf-8?B?V1dHQzBZQmROT3lTTjNHcnFxMHB1Zk5QM2ZUVVBVZXZNbHRDMXhWbVdNZkJh?=
 =?utf-8?B?MUtmSEc2am5nOHVBckhWaFRob2kxZUd1ZlpoWEs4ZTZBRitPQTdkWFJUb0tw?=
 =?utf-8?B?TFNlK09aR28zcGIxM1JsdlpkdzNGcDY3dWdhT3ZlNVNMWFU1VFkxMU5LdmlM?=
 =?utf-8?B?MmVqOFJDczA5Tjd4Y2NjM0Znek8wY1FWMWlHNlBlc3Y2M1lNZ3k4b1JabCto?=
 =?utf-8?B?alZYWWM3YzRJWjc4ZlZyQ0ZDaWJYdGFRczhZVXZNS0FkR3dZV0lXOEFjeitF?=
 =?utf-8?B?QkZKSzV0ZkppNHRZaW0rSGpDMlhpeEdMV3hqN0NYS2RZekV0cnd3a3FUVXJG?=
 =?utf-8?B?ajJrZmF1NGhZemdVMmQvdVBoNWgrZDlsU2Vqa2pjeEljVVFVRmUxejQranZK?=
 =?utf-8?B?aUN1UEo0ZE92UGRPU05Fc042Sng5eHVOcWpaRVErQlh0WGFQVTVpOXlLUmtj?=
 =?utf-8?B?ekpJU2VsU2d6cE5DeUpGVHp4aUhRbElJM0VoQm1KRTZnQi9wZDZPOTV2OEk4?=
 =?utf-8?B?cnBiNFk2ZTNWeFVsUGE1THR6L3FpTENPQkpPSG5sdGlER3o1ZlVDNEZ3b0ZH?=
 =?utf-8?B?WFBkZWxXNnR2NE1DalZTNkFnTHRFbFJ0MllnckpKU0FkcUJkMy9ZNnFCK0lT?=
 =?utf-8?B?NEFYNlQvSGJVOTZ3bTdyTWRxQ3RwYUNPZkdqaWdDSXNycWw4TWFaaU5Oa2g2?=
 =?utf-8?B?MFVldVBlVmttMSt0M1I5YzRZSDR2Q2xXVHVYYjNXN20rU0JGK2pIcGZRQXpP?=
 =?utf-8?B?RVludlY1VEV3ODk0KzdETWIyQ3dPQWtaUDlHZkExeEhGVE9wOElQSU41M05w?=
 =?utf-8?B?SWlSQTRQN0xPNVAxQlVZSHhWcmk4bGJJRW42MXRUNGJVY05qR0wxVDY4cUth?=
 =?utf-8?B?cDlTWU03QUdjYjRuUGRiRWpRbjJaZGNSalR2dmpmMjZyQnRiNE03K3k2RDJE?=
 =?utf-8?B?UURhb3hTWFFKRDU3aUkreVFPYnIyK0dXK0FLYlN5U2M1VldlcTFCRzNGdGVk?=
 =?utf-8?B?ZXg3dGRuSGY5ZmtiN2VRV1kzWFk2WlUwd3F4MDU4emRad2F5SFV4cDZJdUVw?=
 =?utf-8?B?Z2xpekpLNC9tN2ttVDQ4MUErTmVoM3A5Q1BTRnVRTmw5TzdJMjliWXpLdGpH?=
 =?utf-8?B?NG80N1E3amtuT242RE5OMGtBL2ZyOG0wbVdxajdoNUpzUFJYQ0VFMEhBUjlL?=
 =?utf-8?B?dlhUUU5BMi8rS3k2Qy9DSzMwc0s1KzdJN1llaCtpRGk2RU5qN0VUa0IvbWJa?=
 =?utf-8?B?RmlGSVRta0d5bmp5V1FWeUZKcjA1SmNZb25FMDFHcEhFRlAwejRKYndZeEdv?=
 =?utf-8?B?SDNKVDNKSlJCK3hBUU5aL05zU0RUN29JZkxqcSsvWFpRZXZUOVpyMm5UWUJD?=
 =?utf-8?B?dFYyLzh1dFN6RFAyeVdMMXhZQXN2a3BVdmdwSjNxZHZlODhJR0lURlIvOXB0?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d224a66-84ce-4c40-82ff-08de3e6ea7e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 19:50:11.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D42TBiFgRyeDUd8V6a8VWcUOAxr57tA3RQn2trX0SqRYoi2aZyXw27ctOf9PAUOCCQ23eJUmTqdUR1g3TGez/JROWg2hj8fhHaZ6rOS2mbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7714
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 17 Dec 2025 08:27:00 -0800
> dan.j.williams@intel.com wrote:
> 
> > Jonathan Cameron wrote:
> > > On Mon, 15 Dec 2025 16:56:16 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > Unlike the cxl_pci class driver that opportunistically enables memory
> > > > expansion with no other dependent functionality, CXL accelerator drivers
> > > > have distinct PCIe-only and CXL-enhanced operation states. If CXL is
> > > > available some additional coherent memory/cache operations can be enabled,
> > > > otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.
> > > > 
> > > > Allow for a driver to pass a routine to be called in cxl_mem_probe()
> > > > context. This ability is inspired by and mirrors the semantics of
> > > > faux_device_create(). It allows for the caller to run CXL-topology
> > > > attach-dependent logic on behalf of the caller.  
> > > 
> > > This seems confusing.   
> > 
> > Is faux_device_create() confusing?
> 
> Just to be clear this question is all about the word 'caller' being repeated
> in that sentence. Not about the code itself or anything else in the explanation
> or flow. 

Oh, sorry, I took it as the design was confusing.

> This comment that reads very oddly to me and I think means something very
> different from what is going on here.
> 
> > 
> > > The caller is running logic for the caller?  It can do that whenever
> > > it likes!  One of those is presumably callee  
> > 
> > No, it cannot execute CXL topology attach dependendent functionality in
> > the device's initial probe context synchronous with the device-attach
> > event "whenever it likes".
> 
> I'm still lost. Why 'caller to run' ... 'on behalf of the caller.'  In this case
> caller is in both cases the function calling cxl_memdev_alloc()?
> 
> Maybe something like
> 
> "This arranges for CXL-topology attach-dependent logic to be run later, on behalf of
> the caller."
> 
> Though that kind of repeats what follows, so maybe just drop the sentence.

How about this reworked changelog?

---

Unlike the cxl_pci class driver that opportunistically enables memory
expansion with no other dependent functionality, CXL accelerator drivers
have distinct PCIe-only and CXL-enhanced operation states. If CXL is
available some additional coherent memory/cache operations can be enabled,
otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.

This constitutes a new mode of operation where the caller of
devm_cxl_add_memdev() wants to make a "go/no-go" decision about running
in CXL accelerated mode or falling back to PCIe-only operation. Part of
that decision making process likely also includes additional
CXL-acceleration-specific resource setup. Encapsulate both of those
requirements into 'struct cxl_memdev_attach' that provides a ->probe()
callback. The probe callback runs in cxl_mem_probe() context, after the
port topology is successfully attached for the given memdev. It supports
a contract where, upon successful return from devm_cxl_add_memdev(),
everything needed for CXL accelerated operation has been enabled.

Additionally the presence of @cxlmd->attach indicates that the accelerator
driver be detached when CXL operation ends. This conceptually makes a CXL
link loss event mirror a PCIe link loss event which results in triggering
the ->remove() callback of affected devices+drivers. A driver can re-attach
to recover back to PCIe-only operation. Live recovery, i.e. without a
->remove()/->probe() cycle, is left as a future consideration.

---

> > > > @@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> > > >  {
> > > >  	int rc;
> > > >  
> > > > +	/*  
> > > 
> > > The general approach is fine but is the function name appropriate for this
> > > new stuff?  Naturally I'm not suggesting the bikeshed should be any particular
> > > alternative color just maybe not the current blue.  
> > 
> > The _autoremove() verb appears multiple times in the subsystem, not sure
> > why it is raising bikeshed concerns now. Please send a new proposal if
> > "autoremove" is not jibing.
> 
> It felt like a stretch given the additional code that is not about registering
> autoremove for later, but doing it now under some circumstances.  Ah well I don't
> care that much what it's called.

It is the same semantic as devm_add_action_or_reset() in that if the
"add_action" fails then the "reset" is triggered.

Yes, there is additional code that validates that the device to be
registered for removal is attached to its driver. That organization
supports having a single handoff from scoped-based cleanup to devm based
cleanup.

If you can think of a better organization and name I am open to hearing
options, but nothing better is immediately jumping out at me.

