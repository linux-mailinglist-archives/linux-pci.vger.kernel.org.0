Return-Path: <linux-pci+bounces-19703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E02A0C5E3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587E1169943
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F8B1FA143;
	Mon, 13 Jan 2025 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjXyTmZD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA19160884;
	Mon, 13 Jan 2025 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736812308; cv=fail; b=iF1UMNAj2idxFghnILu9/TRb8pOW/Hlz5C1PhzRsmhAETHP6Q55x405yceS69W0dwNzphREPAwmUSVYkWLNui8z69Ih8AQnwVvUzlT959v5F54Kz4EBLPro8shGNAz3G21HaqjiV+dxJ6Pb41FSVcshpUY5LP+gNetfnBMfazvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736812308; c=relaxed/simple;
	bh=iDkmQ/lClpqSAh1I1ibqsFf/RJd9fkyxZSQotdvu+g8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gyY2hXkxLGkAs+WDL9EKSq9Jh4fFSkCZN+tAQK0zoHgmQF3fEKmH9agX6yrZMS+V183aYzdrWv51JSKwq/Rh6BR8hWOSBJ/4RXOnsQXpBZranxFDoDnKAEq1PiAUW9T6Ex/kMWn0taBIbMN/4mqALGv8wZk5cbSOKSR0+twa3SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjXyTmZD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736812306; x=1768348306;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=iDkmQ/lClpqSAh1I1ibqsFf/RJd9fkyxZSQotdvu+g8=;
  b=ZjXyTmZDMjc71cyjmYCeTD/JmaYsfHip3WBUsJEW3Gv70xB+9m1QXqsX
   dwCd12XiiEwbPTLCGTmY3c2ZcTuehFsFhpE5x6Nu80nAdBJeAX/7ChKHw
   gqiMErK0kueagZHkZqqTkhr0hk1Wul/MiufBXSWf1Jox5W9UImnsxGvfF
   2rK4yr9u5O28ehFzBSxjrEcsilGs7zOPXxVtOOzI010iOjWhocaO5Vo90
   LlWrwlugyX690rXAnt2nKMgzaEwMQXangh6Z7BPCzZ0ePz6/LgJbuK1vC
   EGlSR1d+4UwYVMrDzL9FXB8T0/1mEPEcLRkkfUexUzCyoYn95nAIHa3y7
   Q==;
X-CSE-ConnectionGUID: K9vbIEOcQtys8JVyxRwS3Q==
X-CSE-MsgGUID: 2vQwCTdPRoOTwCp4qvtErg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="62468239"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="62468239"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 15:51:46 -0800
X-CSE-ConnectionGUID: FbSvZVE2R1y9qMCkwQlvfQ==
X-CSE-MsgGUID: j8o0UkUmQTCPI6gfuCieAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="104715890"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 15:51:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 15:51:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 15:51:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 15:51:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBwEBakGFhpDo1RcQqRj6Z9uSWja1/2Scpc2JxJM2LMYgbJ/ktoiAqUFRNmybEcYf59z+MBOfbiDgdHZ+ssia2YynmyCiGYUDVNDw+Gr/uXWPo3LFmWYuZvIEMcFgW/O9BdmKih3taOSmVk7jFdK2Zo2V+zWDaDxL5kjMKCijHG/uhW/5CV9HiP9i7rzacSN0JHvAJlo5E/k72vz5VdxUJG7ASGZ8Y7eZ93TRMrISohPZDm3VbaIaxY1RemMt9cCzGjsUDGT7LX2Czi+J3Eb7z1Xr4SemoB1uZ7ohKuuE5V4U2zxmIKyvAcsvmbaqxdNu8IHqerOguzp7eP/+ra6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhnDErrjjzh6EPRbK9cUYwIZQSbs5dHdmdkgHxHf8Zw=;
 b=v5XNXejcgXX6LYbJ8dDaEuVhvbtUjPi9bzCI29VnOgVWm8zx3bRSSMedAi2aHnvgE6VyhonezGmg0kG7SU4GYntRdEb36qXRurNedn6JKZH+pc0g0i7xD7JQiEnzbwfMpviA/xIzGeniJDKJOlwgHyJID+pRh3aMCizkAB/dbz+N95NT/6AR4YyvkuZSSvR2C5cVkszeXNYQ4WZZY1XEXqZMA+UXP2AE8ynVyOIBBlG9oZ/7dzbOPEyl15yaOTa/nC384Wu2x9d77VS3S7VRmOsZs7gcjmDrliXJMj0FIfF+NwHF6nhexns4/+x3tmHM7ATZEO5kxiSjtxmAehM5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6884.namprd11.prod.outlook.com (2603:10b6:510:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 23:51:43 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Mon, 13 Jan 2025
 23:51:43 +0000
Date: Mon, 13 Jan 2025 17:51:36 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 04/16] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <6785a708e742f_186d9b2942d@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-5-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 996f8885-22e3-450b-fbed-08dd342d3b45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lHodWBCfgGYNSRqfjKBwPCDBZzRWv7c+xojspTFRijW4+4y4xBzN2pNmUz9O?=
 =?us-ascii?Q?rGs9BowOGgOJJ7I6Hh/d4criDURBB8rm1B468UpS0jnioj4cHrQAwbAeaRzN?=
 =?us-ascii?Q?CoZuFyHcYnFAIyeXXd81/k/v5zOhDxiRxNzkqTqlMB2dNMm/ObwftMgb2JqO?=
 =?us-ascii?Q?rnRBF/PGoNdPjAnB8xJcrRysj8MAKES2OZGNCZn+qT8cdQtccrYl7LLHjv08?=
 =?us-ascii?Q?EmOY0U4PpYOJ1Az+ge5uN255IzaZq7aVD9LpIo4e3aeWUoMISQYT6qMUEk6T?=
 =?us-ascii?Q?blAC5Iyovaj+9Vg9gkjOl3EXGoiUMmRXEOgxUpFUwlliCApuvX9RyqPc8q4S?=
 =?us-ascii?Q?zlLxU+5AAdBGcSGy7DSqM3LlRWMPkQtBmGyviRSTbQTeGypFCxGUXTL3Dnoz?=
 =?us-ascii?Q?kKHefgm4/0eVHRr+JucS3s/iKbwXyDreyFL+C6inZNf4Anfb0s739AdoQcXX?=
 =?us-ascii?Q?cZ9v3w018Ji70djVBm0Z1VsuNIc/0GuL+6YP5d42F9nSzxfo2EBaicBp9nEX?=
 =?us-ascii?Q?uHzDLYDvDFQkLuk+P91vz54Tj3XyRqCRO5DrfWiLLkKiWXYpGy5Y85/T2Tj9?=
 =?us-ascii?Q?rEKhceO45hMumx1ZlHJ48aWopBLb5b7ziJBsqRv391+Bj1GClklpSxk+7W/g?=
 =?us-ascii?Q?Dku5P3TuEKc3eOSGXerSxuPKixoiv9g4y07eWGkfPKI4+SfQBJiPE1nlTaaN?=
 =?us-ascii?Q?O7JMhccVjVlilRMJl8WatRhpNlefmMkcLE9iSF9r/voHM0UV8EAWr0wr6YHW?=
 =?us-ascii?Q?XNS17TrpDQe4P2vw+2Cg+SNnN7D/Qk3aXp5lDKShAFA+Q77SeTIbS317gSrd?=
 =?us-ascii?Q?35V0oVcxTt6dqSSm059NCG01pmJBdIqXj0wNF/05jmzeiH0AW55oNHz59i3k?=
 =?us-ascii?Q?HVmW1NyznLOeKYV0Edebz0j2W1Ux5y3xX0pA+R5oZxaUSF/MFCLddk+1tsBV?=
 =?us-ascii?Q?BlyPUUTohuiH1R+yLBO6PQKGgSOixT6aRlPtPIL2lo6VX6prPaZgo5vxPndN?=
 =?us-ascii?Q?FJmzL76GSLmpM8nF9RgUL8VEfpHzCfCNfDF7/5rZRZMvnDSyj8oSUeRclVv1?=
 =?us-ascii?Q?3n7CdG2QzX6Bn8jEwpmwJ7w58m4tPIIpmm5XQ35k/HqIbixL9UJ1iUcsTWEz?=
 =?us-ascii?Q?8NkvbVvM4iM2rF501+otesnT6M6TO7KcM0rfLkMeLQGn+K1kADbmckq3bMoz?=
 =?us-ascii?Q?gBcylWQWLwZn2ZXtM6pQS5cpU1Rn50YSTW4Q9LxJN1ze/iUVoRAqiJU9L2B3?=
 =?us-ascii?Q?N0y9vRS0eWkVK6WMaLqJrkn9VxOux6EQ9CPQrdkMUc9KTxozTS5FrHRllPdY?=
 =?us-ascii?Q?VNaYGTyUkwVXACEo3VnT/7S0UAZ4/w62TSp+T4F4L75JKAeVOtzoUyKOeq3J?=
 =?us-ascii?Q?13jtg0XL51u7NG02JjtcBFoFI0Bpe/jGrHMRbpSHQ4h5j62Ts0nYbxtJAQoJ?=
 =?us-ascii?Q?j/JZzDUpHX4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVO/i7E1mBbqnncjBNgL6I0NFv68iHqKNABEvo6u+XuaDn6Xc+GDBNF8Ek7o?=
 =?us-ascii?Q?haAIl9lQ9VHJZIE7gkqbWf4BdfQXpYI2Visskarzl6eC+8NDtJ4tYTJo1Qjn?=
 =?us-ascii?Q?j0BpusgsinHtEc9Wpa+r7CdMlFXq3dx9IHBpoMjvB06zd0iqo3/k5bq83Kxe?=
 =?us-ascii?Q?cbh6Znr9GEEaM9T438cCmahuxGy/D3bZ/a8RQvWJE22xWiIRg67HTCitnqv7?=
 =?us-ascii?Q?vm3KC+v8M8cuB1GW+IV9TVLKgswpZW8sKxCr73jk4K8vGMR5S3Advt4a4wca?=
 =?us-ascii?Q?NQ/3bk1AP0LgDQzSlTVemBLZRXUrfyqnnpncjuPUCSVPBZvOx5hx4p9k/t27?=
 =?us-ascii?Q?Avt2k5N0Kisl7awFsAbIwuuw+BaF3G1QI+UvtWZCGOZBhnIeTpKWhjesFSGu?=
 =?us-ascii?Q?4Z7WUnazzBDib4PydEANA7cyisArMrQkvZ8Jb6fegUtriCcxPZl1QECLGs0t?=
 =?us-ascii?Q?yz4/Xmd1/sokUuIb+SWnvx7Cm7w3H2DvIf6d7e7HH5o+DJvLxDL2+RXcmgBk?=
 =?us-ascii?Q?L3ChSC97QdbaPLTkYS8yjhDA/OSyiFCrIi7IN5cnPwNgR7xA0GPMo76zbGPX?=
 =?us-ascii?Q?+aJMw+OP44mMilrHnybD27dBEGizP5KNYdhhWws5FNdeNbD5AHu0B/VHI5Tm?=
 =?us-ascii?Q?FleA63XW5Yc+sU3gn2VpT8/vOI+1R3W6ExUC0A/zoxxVKUt9yJ+Zo8jMQq6I?=
 =?us-ascii?Q?tTSOrut/aY+mE2W7y9roAIejhNbT47a3+DtoYu+BSiQoE6nYVM5hHqgkBHOQ?=
 =?us-ascii?Q?exj+sXcMo326onLU/+aAXxjKxBX4ixSuEz1lEs+HIDFbXjlcxDvirZ+qK1z/?=
 =?us-ascii?Q?RTyzkp5FjXj4uKxTW9JEKlzu2w93fx3pCvVctljmDtlmXAoothy4/ik/zuB0?=
 =?us-ascii?Q?I4eFlVmJ/4eLmK/K02HpeX19klc5tD2a0S9zkOrpmTKBM3cB7oDQC922HjDa?=
 =?us-ascii?Q?yna2AcyNZKpDGtORCaCprNjC2A6VRkkAPWSn4TXZ3EZy2HYqHwm6FmviEuAc?=
 =?us-ascii?Q?ZW0Fu13Ac7xGr2D9tZBZ5MFBGJuexSVs0JRuE5XFphyrbDtPjokjgwP7Qott?=
 =?us-ascii?Q?SjsxvzmarRS1vxOqJFBkY+Do5Pohd8jDRTzwxMfCX2JHiDxX59SVnjV6HlYC?=
 =?us-ascii?Q?cBHE23JOgski6YvypLcs6eQFtIiMWVHKhE8TS/WRGwuQx8eXQrpr10Cw2j9I?=
 =?us-ascii?Q?oG9VvtcC49a+ZxHngsq7LuSwRCOoe7xwa9U+pPvzPmMiEnTAZ0dzP0mRfDGg?=
 =?us-ascii?Q?XuGtjhEVaTtpQUTYD2X6O0rBchJ2R2O5fTlRyus4L91mDUljKWutt9bf7wN9?=
 =?us-ascii?Q?HBd/515W3K1dN0zgiiIvW67dPnTA9K3wuFu8lFEj8OGzK6qMCdbCod0A5Q9d?=
 =?us-ascii?Q?/nTe6FkNl5H4sbR67QS4uRkgbEuz74F5PL3xIk9kxASLLHJI1zJ607blwFAJ?=
 =?us-ascii?Q?Gg8cO9418NL6rVuqtkDL1nnfawEiklRaVTygvmHyR8yJl3X4XHUYgDpJR1k/?=
 =?us-ascii?Q?OWMenBg28ibYGm0ZZXJumjI41uC6AZ01+hbyqISH/aZub00mQrgtSSQOhCSE?=
 =?us-ascii?Q?MPxGsYaJFlNcLch5874s0THGkFQeiGDj7E5jJHkn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 996f8885-22e3-450b-fbed-08dd342d3b45
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 23:51:43.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYmnXN87Zq8iKfBAUICqDJySD8tMdE81gCqZEALTXV+tIOcnbP2iLEZBbR/iOWQQ1M+xLMIXQKnbqny14DtZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6884
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors.
> 
> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
> device errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

