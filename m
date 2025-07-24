Return-Path: <linux-pci+bounces-32900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71171B11268
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 22:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A2F7A8C07
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797823815C;
	Thu, 24 Jul 2025 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeSo4Omm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46051DE4F6;
	Thu, 24 Jul 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389179; cv=fail; b=PEcs8thlj+fm11O990Nc4eoBOVBIafgf0qbTVjtxD9/NE62C3cyHEeduKiM3cO8OfYAvSdLZhMcq3/9r+i13T6rjPn46F1glh0P/pijsTdJpUS8ojwiQ+bv88oufPFzqzCjpUFYP9g9lpfJZLj37pfMYKiWji5+2O7/c9n39Zps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389179; c=relaxed/simple;
	bh=lJy2oTqwQR7lmV3UGYDE4iO0y/hy13JBf8Y5G/Q+uIA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ce/DFTGmhaoMfbyPzSeWJBtG4pi11j6JGSxJFv/NqkXtiJZboueHvr/JN2Yvq2gxIP0We3SFzS68+cCP3vUnQDIXUloQb5/Vk1sWiFWa4GA7aEYQhEyuh1oNwvds5kAjJnHNDi6Iiwy4FFgYFYsF22jFTTvNFiPZ50dUgKhjdPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeSo4Omm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753389178; x=1784925178;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=lJy2oTqwQR7lmV3UGYDE4iO0y/hy13JBf8Y5G/Q+uIA=;
  b=VeSo4OmmXxqrArqXkDW/KTeZhHKC6ePQx8igan/kfarqd7l4O1t67fA3
   w2KQgKLQG98JF/TJWiqmgQuREdsF0+IY9piySip1ykv718t/u9uQxD595
   n/A3HGRq/c4TALCmXEEqNqr7MXnMLkTzDU9BzAvDdcCFe7js4OA9AMeq3
   bs2BgijCPBEYp4dk5BDEeU0DggEXO2X/HppvQ/VXFeQU5t9Rs+WL/wGQ6
   edj2WxZnFRkeOII1tq2mT8UWhHmwU23mqcKtTZPsdqje3XppFOHjmpEz6
   Zh+vBp0LLpojD55XXrXtVHCONPgq4A4xTB4RTJCnnHnLJynyYcywdSIMw
   Q==;
X-CSE-ConnectionGUID: 3RG9vTV5Q3+SdsVn761ApQ==
X-CSE-MsgGUID: y+Qk54HlRCCqoKLHWggYxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55599786"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55599786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 13:32:58 -0700
X-CSE-ConnectionGUID: hchnGzhyQw2pnODdNvMxoA==
X-CSE-MsgGUID: fPuSCwjBRBeoyZEa5EgMsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="191386630"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 13:32:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 13:32:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 13:32:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 24 Jul 2025 13:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jylCmDcT117H5XS+ObLA3PisriOxsCuCIFqFZa4tlfyOU5cmpZpPIwlbKhrBDxWL/pO+zOw4CYvzA8Exl7Lv3pxAq2a3qP4VC1Kb2LlV28kuhpYp5xEOgDlBU8qpVvR+7baGkxSdCS+RdIaHBZnjuK35qcFv+793jYDszweCFZKTkiJbx+6MktJQ71sndk4WhJJIaCmlsuGX0UzhoaZe2zv9UFmgBQEN8f9ObjjTZfklWU+thvXHKd8+8SnGkSvTcJKWopBG3xMIn+liL4jNpIShEewU57qOwFSl5IJ82IBVpYFZpQMbxNgPlgItmoKQGzDIgCyhHOJGatzANUi8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUA+m2fx65Op1nAOV0QOx5qScY2MsUSrtN6g5hMwPoM=;
 b=AAcuIYjE57Ad36gDCRg7LUYS6WJ5I9U1f2DDc2dznKrrUm1zUjvAJwVq/sZf61XsAeO3eGOqZpdwtED5uZKGQSHxADxnYR1Bedzm8EuKs5W2YvK3yHx6JpCaSkH+dwP40Gd+Ut2Qdt5V2To9/shxF3ixZhi3kfqqW2QoznRGGwfmbTckCWcetL9FsmWfTPfsKK5CGC3qUiHpbfmd1GZ6uK9W9uIemQ84waUIuTyUWN+StH4flw9rzbOQoHnwZkGJZ7xji50N9XpkbDOmV3RA0ebjjLMLccMzgm1plbehj63shjesYFP/9AEzDORGLa+UHE/0nBBLeL+bmKNOqr1nBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH3PPF6CF64E2E6.namprd11.prod.outlook.com (2603:10b6:518:1::d2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 20:32:55 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 20:32:54 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 24 Jul 2025 13:32:52 -0700
To: "Bowman, Terry" <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <68829874e03a7_134cc710028@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <066fd1e8-d86c-4016-8fd9-6b94092ea48e@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-5-terry.bowman@amd.com>
 <688177d0553c8_134cc710028@dwillia2-xfh.jf.intel.com.notmuch>
 <066fd1e8-d86c-4016-8fd9-6b94092ea48e@amd.com>
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH3PPF6CF64E2E6:EE_
X-MS-Office365-Filtering-Correlation-Id: 28973f99-8882-4793-62ca-08ddcaf144d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlZjYjd0YUh5V1g0V3RJY0FEd2ZHWXl0MlhETGRucmdwODdTajljVUo5NSto?=
 =?utf-8?B?dW1qOURWVC8zMlJrNFYzTy9iM0pWZk1XN3lkS3FwVmV4Y1crdkRZK21idzh0?=
 =?utf-8?B?alF3RXJvaFp5SU54L2lOWVdOOFo0UVNYcW1GSDAvcnp2MVBOTVErNlR6OUdv?=
 =?utf-8?B?V01Ca2s0WHNGcGZOWkFTT0lFUk90VlBCQWZUQ0tldTJqeFNRczhkcjdqWlhI?=
 =?utf-8?B?cUxkQVM4Zy94OW1hRS9MTVRMY0hjdUkzUldhVjkrYlMrS1JxQ25iZTFVK3VQ?=
 =?utf-8?B?SWpES2Raa2paVVRwcVRjL3hwamRERlAyYnlKakoraDB3OEdVUmZvMFowQ1Ju?=
 =?utf-8?B?K3dydXc5RzhBVitQZFJrM0pya2IxVWtIZXpLNDAxTmM3YmYyamlJbEkreWw0?=
 =?utf-8?B?ZHBNa2lmYkRsWEthRjJOdWV3anBqR3dBZklwZzMyV2xoSml0dWRLa2RYUmtN?=
 =?utf-8?B?VkdHRTFwMCtiQzdVMzJlUkIxbklVSW9ja0tJVm0vSmh1WFRPcmt4Z1pzV0lk?=
 =?utf-8?B?YXdFWHozZ0pmcWZIMERlVmtIOWxsY1orMTJhdktwaU4rME5yb3RrWHVjeXU4?=
 =?utf-8?B?MzB6SHZ1WEd0bUZIQ1psMXoyaDRpU3ZxTEFTTXlkeFRwWFg5ZzFwc2sxdWl0?=
 =?utf-8?B?UDFodEhHOGV3Vm1YSzdUY0pUbGJVZmVNcmp6bXdDeEdERzhhTitYS1FxWnhq?=
 =?utf-8?B?MS93Y1MwWGY3akRvV2pEdEJOSzhXcnoyM2pHQWk3VG9jKzNWV0Z0WWlUa3lV?=
 =?utf-8?B?aHNJYjZBSm5tS3Zsa281bEZFZWhIa1VaM2RoYmZjV2JiemtVQ3kwVVFDaERq?=
 =?utf-8?B?d0Z3b3ljT2ZKS3AvaVdrNTVNSzlpendUcHd4YkpLbGpESlI1U3BDQUZRWTJv?=
 =?utf-8?B?ZkFCanU0anZHOXdFK1lNRDkvSmtIdUZpd3NnZXdPN1JsOGxPc291V3ZHSVRS?=
 =?utf-8?B?ZnZvUmFJUXdQTS9SaDcxWGpZWk52QlVhQnRlcytmSkVwR0laQWtJcUxpS3E1?=
 =?utf-8?B?eEpWL2RZbWl1R09Sdk80VmtjSk9FbkdGV0s1dzg5V01yN3NNclJZY3g3N3lQ?=
 =?utf-8?B?SWcyZTB0RllVMjJVMXVxZUZzM2E2bUkvSWpwM0hWSlVPc1c2YnhscGVKZmpV?=
 =?utf-8?B?dVUvSzRwbXpxNWZnVnVWandqSTNuQVMzcmNpU1dNQXh6aWRkM3E0UDd0ZHhH?=
 =?utf-8?B?eStKZ3h3d2svcEhqVDUzeEJ1WVJ6R1BJdE41Ny9RZXVqR2lJVzE2MEVzSCtQ?=
 =?utf-8?B?N2tOZktRamE2bzlnTnNTc1pqNUVsdTNDSXYxVnZZbmg3S3FrOG0xYnR4NXlC?=
 =?utf-8?B?aFdSOU1CMU8wekJtbW1wRGJ6TGVvQURQMDdibWN4c3Nkc212TjkwQmljWVZs?=
 =?utf-8?B?ZHBqZVh4T3RMR3MxNmZWNS9NdHJ3Rk1HR3JlL0FwOWdDV21Lc0IxVUNtbHRi?=
 =?utf-8?B?QkdvTnd6NUMrZDdBY3p3NDlLTWhMaHlWdVI4ekttNmZCVUFrRHFHVUoxTmpF?=
 =?utf-8?B?emJ2eTlJV2dMcTAwL0R0VDlhNmp2RHh1S29oaFlsU21BaVErQzIxUkQwU2Qy?=
 =?utf-8?B?WTN5NEI1OXdwT0RMS24vNTBxWXVENEllNkpMZnJVVTFBRXpDMCtuWmtMeVp5?=
 =?utf-8?B?V2ZUSVdxeVl4TThBV0JFY1VlSmo1Zk1tTERFeCthQ3ZtRWZQdXRlcVFoWFRl?=
 =?utf-8?B?Q3pMQWZwUkpSQW1nbkV4NStzWnlocTQreHdwS3U2VTY2OHpOQVg1YkFIWnk5?=
 =?utf-8?B?VTBwYmU4R3o1NjFNQnhKa2ZEczgzTTJhWDk1eFdDUGk3NDdCVWRpenZySnE5?=
 =?utf-8?B?U3B4eDhqVTdHOWtXQ1MxTytDdmlwQzVrNkFGaVV4RSt5SzRKSlAxSWp4OFNR?=
 =?utf-8?B?am84ZklseVNVS3ptTDQ0dzJZbXplWXRkMktISjk4NWVqckpaUHdSSk5FdDBJ?=
 =?utf-8?B?a0R0RTVmM0Q3VWFBUHV2eHJEak9ORDR1cXpvc2V5R0JiM0dydzFRSG5CbVpr?=
 =?utf-8?B?dUxDQWZWUW53PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2hiTTFwb1g1RXh1NmJBRlhRczhVcFhHWE5iMk52ekl0TkJCRG11NVhhZG9Y?=
 =?utf-8?B?VmFvUXlVOEJ1SjkvN0xGTFhBZHlLQnZ4akpKbFljNTcxZ0o4Sk44WTBKd0c4?=
 =?utf-8?B?TlJ3TUJ3ZXQwRzNXSlNoODZta2F1NjZsQlhnNXMxY2xIT3lWNlFmRk1ISnpN?=
 =?utf-8?B?Z0VQc0tCL2h4OWd2VzBjMWVrS0x2d3VMcjhPVzJra1FwRXVRU0ZGM0V1TWFt?=
 =?utf-8?B?dG4vbG5jZ25aS0R5aTFUNlIzTFFTRzllckQyMEs1a09qSGhKbTFwVWZlZXFQ?=
 =?utf-8?B?QXVXTWhXaVYrc1hhV2w3NGhzUjd5LzNiSlBTZmlVSzZmY3BoSEY1TkxtSVp4?=
 =?utf-8?B?a1paMDhZT1l0WERveTc2T2ZTcE1zdHVEUkN3QldYMFRlZTBudElwS2ErbG5V?=
 =?utf-8?B?ODRIMlBrSXk2YzFLNUEwNG1Ld3UxREJPYmU3cW94NUN5TUxqNVhLTlZXdjlJ?=
 =?utf-8?B?blMxaGFISFBCN2lMSWVwN2dXZ0F2TEFlc0cxZ2NmSzlaTjNnVUxGNS9GRndw?=
 =?utf-8?B?SUdHanhEbmxuTzZTSjg0aTZCRkRsQ2pyMnB5RFNGSU9uVTNmbEMvY1J4cjRU?=
 =?utf-8?B?bkFpU21OMXcvVnlaeHlWaGJRMVZqaXFQSGlSUXFPZ0I1UUNSVTVveks5MC93?=
 =?utf-8?B?UFU0ZmdKYThEdllUWWc2bmVSZzI1ZlJTR1kwaHJ1am1jK3ZtZmlMNXZuekp1?=
 =?utf-8?B?Z1pxMzlBU2VyZVBJenRPK1puVlFzUTlGOXlhUFNhRjB2MURqaElCQ2ZUR05H?=
 =?utf-8?B?QkpEMS9KeFRBTzF2Z1MyOVRMdDlvelpzYWVJSldmZFJmemdYWWFLZW0yOWpk?=
 =?utf-8?B?SXdYU25UdHM1UUpsQWswK3ROSmFCZFEzbTdOMFE4Qnk1TXdVc3FTTzcrbWZ2?=
 =?utf-8?B?MXhDTWhmR2NrakRmVHBRWVZaRVQwbXdyaFdrTld3N3VoV1A2UW90ZVRyYUxT?=
 =?utf-8?B?VlBOWW5JZFZzSjh2KzZnQi9Fb1JwZ3pacEFVRzNVcHVDWmZITVZiWXpYNjdW?=
 =?utf-8?B?L1lYRzZnNDdXSVJEU3BpeU1LTk54dUY5b1lmcWU4ZUhFVktyRStjU0J3L29H?=
 =?utf-8?B?OWwyNlNQYnI0a3dhRzUrT0tPaFJoVnhIZmxDZjMyTk93NnBXdGc3bUhJdkNL?=
 =?utf-8?B?M0pJVG5lS1M0SjdPQ3hhYXZ3SThXMWpKVGRiY3ljZHNRRGpkWlRwaWRuaE5I?=
 =?utf-8?B?ZThDUXVDOTJoN1hWdzZwQ0dybHFjOFBMb2xDVk1IQ29qZFpQUFN2cVg1Snc0?=
 =?utf-8?B?VngrVzFnYUpvTUxQbFNSNUJEdlVUSlJSQktXWkp4blNncEFCZENFQmtBMU8v?=
 =?utf-8?B?OGhmZXdNd2VCcUNQWmV0K2FySTN2eXRBSmtOejRTaWtHWmczU2s0TlQrWHk3?=
 =?utf-8?B?SzRCLzdwdDVkM1Bic2F6Tm1qMXNSdDV5bWhrRGpLVVBCNC9nZzB0NDdhUEU3?=
 =?utf-8?B?TXRZY2s4Y2RZczdzSE8rQTlBVGFWeU9WNW16SlZoWnpjQlM4YUEzRnByU01m?=
 =?utf-8?B?a0JIM3hCbXExY1F4a0M5OUwvellVWFQzMTZkSytyOHRrMVZnMVYrY0J4M2pU?=
 =?utf-8?B?ejVXMHFsNEJWcWRhNUlZSERmTFpiby9tMjNURmdqd1haaTNhRWplSitqMnVH?=
 =?utf-8?B?THFzWFYzMDZja3ppeHRrQ0NCbTJFQWVsZWFlUTV0SE9kc0RTb21FckZQSDB5?=
 =?utf-8?B?eGZMNnNFeDdwdUxIVW9LTHJ1WDFkYk5ZdXo2eDZ4T1lDbGVOdUxIaE10dmhp?=
 =?utf-8?B?Ym8zTkdrSy8zSWk4K3J6eThuR21WMWgzNUNwaU5raEI0TFJwdkcvVWZaVFB2?=
 =?utf-8?B?dHdnUThlZXVtTzZlQ1hrYTBGMEFETjZpeWpnN1R2WVNUcFlFVEpjaFZQQ0tr?=
 =?utf-8?B?T1F2TU5GdkFLMVhGaUhhRjAyT3lUVEx6cGdYaThNZTdNK0MrdC9JeFN2azQ2?=
 =?utf-8?B?d1BzQzlHSDE4VFQzdlN1alg5enJ5VmIwM2VBbGRNaHpvTlBJaFVxSGwyb0pa?=
 =?utf-8?B?UWV3WHNVRnRKZEhsc29neUhON0NaZVRWcVMwVndpQTY5TlNDc0R2Wk9TS1Ns?=
 =?utf-8?B?WUUrOEFZUVQ1NVFpOEFFSDhtZTFFSDdCalh0UkV5cUV2dkxQVnJOR0ZKbW1S?=
 =?utf-8?B?a1NRMVdDYzcwNWFsbFRRWXR2M0FsaWpOWUwzT3lWd3gzQjRHYlZmbGNleEdG?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28973f99-8882-4793-62ca-08ddcaf144d1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:32:54.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdmSVD7P4W9EMTdqv8dhFY6y6nGj8ILJjHXhDrIjjsrkLrB/OfaYn/E+sanTfGKxOr3pRO6gsbBWdFowDeFQK5p455DXGgT9TwW9gMJBvGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6CF64E2E6
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> On 7/23/2025 7:01 PM, dan.j.williams@intel.com wrote:
> > Terry Bowman wrote:
> >> The CXL AER error handling logic currently resides in the AER driver file,
> >> drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
> >> using #ifdefs.
> >>
> >> Improve the AER driver maintainability by separating the CXL specific logic
> >> from the AER driver's core functionality and removing the #ifdefs.
> >> Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
> >> new file.
> >>
> >> Update the makefile to conditionally compile the CXL file using the
> >> existing CONFIG_PCIEAER_CXL Kconfig.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > [..]
> >> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> >> index e2d71b6fdd84..31b3935bf189 100644
> >> --- a/include/linux/pci_ids.h
> >> +++ b/include/linux/pci_ids.h
> >> @@ -12,6 +12,8 @@
> >>  
> >>  /* Device classes and subclasses */
> >>  
> >> +#define PCI_CLASS_CODE_MASK             0xFFFF00
> > Per other comments do not add this updated in the same patch as the
> > move.
> >
> > When / if you submit it separately it likely also belongs next to
> > PCI_CLASS_REVISION in include/uapi/linux/pci_regs.h defined with
> > __GENMASK(23, 8).
> 
> include/uapi/linux/pci_regs.h appears to use all values without using GENMASK().
> Just adding as a note. I'm making the change.

pci_regs.h is in include/uapi/. Historically that meant that it was
unable to use GENMASK() from include/linux/. That changed "recently"
(compared to the age of pci_regs.h) with commit:

3c7a8e190bc5 uapi: introduce uapi-friendly macros for GENMASK

