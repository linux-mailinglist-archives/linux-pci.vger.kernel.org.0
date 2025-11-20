Return-Path: <linux-pci+bounces-41833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B617C76600
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 22:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EED982949D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA330DEAD;
	Thu, 20 Nov 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdDNleF0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C520245012;
	Thu, 20 Nov 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674139; cv=fail; b=aN9Cn8z2yyaWH9u1mFUNPbqz12c6oQy5VTeivxC6qBiQNRjWHf3+BJczLPOA3mVKMYQyv/bhyFMWgFVfZBWju4CoaRQE8vGXvsycuXllhMEyzitVjSopwZZ9ppKybuobpaorzUKcOV15yIwqwo3R8LKdYXRWbtoUzoa+z4uKsd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674139; c=relaxed/simple;
	bh=9XTi1YFUCgRfCYkw2G9+6QtXkIUP/+CBWQict3TsYAI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KcxVW8+fSHN3WQHF8VViOa5niUSMQLR1EYmT/BJkmUgy1PIT1he4rH+Tnq2ekYApkgfD9zSdoh6Z3Xuac/J1dsPmgH1WF3iwLn1XxsZKdBCE2PCqMx5Efc+ZBt19OYi+FSqxFQX/5AugxtpPpbml4G01AKsyM7AuUDZwEI1K3oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdDNleF0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763674134; x=1795210134;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9XTi1YFUCgRfCYkw2G9+6QtXkIUP/+CBWQict3TsYAI=;
  b=kdDNleF0SuXKg8EUvSzB/CSlXBEdVQ72H7ttueaq1z6OPwyKRiup0lBw
   51OMdgjHQ69MrgSs2AC83tUscwVytdgX7tXP8SkssLig0edY9MdyOlxdB
   ujs1Svt0aK6NcA/zkQGJJWwpnkbNxOCM1lkiqLT1Nvbm3Qp4tQaQieBRq
   DVHD6pckoU+kLU46YUEqQU7cBAA5IFCB3fuqE1Ug56lV7n1+XA1dg/LHr
   j6JRv7TGPyaEHKYVtTvXhm8S84uEw+WsbZRsoQ/8h5zAg3SiYpiwGWHqp
   ByVtSnLsRYTM5cpc1S6CCDVvEIo+yisidks4T0ZHKrMM5vqAuAtBhaWbH
   w==;
X-CSE-ConnectionGUID: EuPD9xwkTpusyjIbwPeAew==
X-CSE-MsgGUID: vyeoMvXAS3uDTYh5xv0twA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="64951338"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="64951338"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 13:28:49 -0800
X-CSE-ConnectionGUID: oWLAQx48SMW1LwDtumxH8g==
X-CSE-MsgGUID: QYcCrkw6StGbaEuZlTcYYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="190785980"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 13:28:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 13:28:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 13:28:48 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 13:28:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0CHysjVKiVdbGO6pJq899OI7oitmRS2H5r2quFsXQO8ytZ+rUQm+fY23umZ7ZMbmHGuAyvM84NLAD1f5zoLNiPnu0t3uNchpsfvu0lyZGwmkxelkwTK4FhFCrhMywpvQWGB8OpinTT+T7pWKCxC/waddweexkGhuIo/VcezoDw07+PW08sMHBAphOpgadl8Hs5VkfvV7+jT1yr07JOAr33uyafnSx/+Y3L/VRrXf0dXa8rjNRuuhmjLnHT8wSodcl5Uqknd8/mN++A3Z1VHD8OWHSjAzGG1C0eVTfNewnuRwR1BOvNQ+2pZ+327NDWjW6UUx0+u1hm31jJFdwyppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXxbl3qTLg3FxY2O38hQqyp+rM0tq7aWI91d875EkjE=;
 b=ag2dICFsrILmIwh8UbIBpYwFecH/B2npOCVzwLjaCnCCPLwR70NgSkpd0qkriZ2MULtNkwuCz8mJTG+2yRSuykGsRSXJydzKzOS+Ce/pUjFkjwTcH/dDXMinCMlJQTz93YPdXe6Z3aeSMKiH0G45bq/AV9NKNjQsRUjQs8GK8nvEUX6Qgcv4DVUH4wVIFglQh60XSz3P4ISnPNPdg/2wnHm5ljeEwhCG6Cdt8z22XvwCIAppSgZX5+2GrJnoePdnhQEpwybwAqG1DVtUOOP2C9zb2KFdx7ok3qakHm5qsDfAJfYix9MGU5nWsNnGiqL+k982uS0iUsCsK9u3m0F1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.11; Thu, 20 Nov 2025 21:28:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 21:28:46 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 20 Nov 2025 13:28:44 -0800
To: Alexey Kardashevskiy <aik@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "John
 Allen" <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Ashish Kalra <ashish.kalra@amd.com>, "Joerg
 Roedel" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Dan Williams <dan.j.williams@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Eric Biggers <ebiggers@google.com>, "Brijesh
 Singh" <brijesh.singh@amd.com>, Gary R Hook <gary.hook@amd.com>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Kim Phillips <kim.phillips@amd.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Michael Roth
	<michael.roth@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, Gao Shiyuan
	<gaoshiyuan@baidu.com>, Sean Christopherson <seanjc@google.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>
Message-ID: <691f880c7811c_1eb851006e@dwillia2-mobl4.notmuch>
In-Reply-To: <442d4c48-8d6a-4129-b21a-cc2de4f0fcd0@amd.com>
References: <20251111063819.4098701-1-aik@amd.com>
 <20251111063819.4098701-7-aik@amd.com>
 <20251111114742.00007cd8@huawei.com>
 <442d4c48-8d6a-4129-b21a-cc2de4f0fcd0@amd.com>
Subject: Re: [PATCH kernel 6/6] crypto/ccp: Implement SEV-TIO PCIe IDE
 (phase1)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ccb8fa-464d-4da5-4c29-08de287bc9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXZiS1NEcmUxc20xaEQ1UHlidHJKcW1ZQnhjdjNMYklpNTNCVDdQamg0amVk?=
 =?utf-8?B?dW8vbmo0N2RVTjRaUjc3MHN6bGN5d0JvbGRyUWdIZlZlbXV6VFdiRnpHSWxx?=
 =?utf-8?B?UE4yQWwvNVhUYlJlcVFUNjVaT1FNdzMyTEVYb09LL0xXeGFPZ09RWmN0Tndi?=
 =?utf-8?B?SExYSHFIcHc5TkxFTVZMVDgrdk5Ka1VkbXdLaDMvbXlvZ2FlU3hvMTVhVGNU?=
 =?utf-8?B?Qks2UDJLL1NCNzl5VHp1L1FzSEw3Y05zakt5bEZ4SXNubVk1b3pZNjhBWkZh?=
 =?utf-8?B?d1k0V2t0K2tSUk9tditoZUJtWDBSbDVjYmdoZjNYSnlFdU5oVDdwTXFhT2gx?=
 =?utf-8?B?Q3FldEhrSUVVcWtjalJkNjk4RmhhZEVBSWVGaVlYRndnZXFQRUZWYnNDZlN6?=
 =?utf-8?B?NkQyKzBwbGFMRG5OcE9aekxVMmRNeHRpRG5CWmtZUm5yZWNsak1yNUszbHpH?=
 =?utf-8?B?QjlHelVISitVcVJPVldKTkU2MHFGQ3A5M1NVczZ5ajdId0pmVEdKS0FSTXda?=
 =?utf-8?B?QjR5c0FPMFdScjU5dmYwU3JsNkR4VzBhemI4WktuTWgyYklNK2Y1M051MTZ1?=
 =?utf-8?B?clRMMG9uOU9yY3ljS1VlQkZXUzYyZHB3TU50NVlralBqNUh6RlE1Y3hWbGpJ?=
 =?utf-8?B?RE1QMnJFVzVNRm5hZG4vWnZ1OCtta2hsT0FXUmx5b0MzZnhoK25oUDViRVA5?=
 =?utf-8?B?QlpaYWNZOTlkb1J4NVgwN3MvTVVIVEZ1WWNyTDNzWnpvRHE3dGo4d0JvWVV0?=
 =?utf-8?B?bm1KTFYvYkRHNUlqU0ZUdjJFajY5SVNlNWlZL3pDZDViMHRwYjVGV1FLWVA0?=
 =?utf-8?B?NTdYalF5Kzl2YkVoZ1VxUlFNRndlNkhTZWI1Z1pGQ0NDWTcvREYyNzdpalc1?=
 =?utf-8?B?aWxqWExQdWxXSyswTEQySmVTQ25VZUEyVGN4TmFJZjN3bXlsay85U014ZnlD?=
 =?utf-8?B?Tis0UHpxcTdlNWppTFkxdXlxTUVjWjBFSVhlQWtoMEp0SUQzcW1jdDVWS2JU?=
 =?utf-8?B?ZkFoYnh2WHRYbWhjckg3ZFVvOGIzdWtuMG9qNk8xQjQ2ek40aFJtY1dQYXlL?=
 =?utf-8?B?K0FtTUpacG01emRLVzNLZ1JQNnZoTjg1K1N2Vm9vdkgrb3NFdnIxaE9ldFh6?=
 =?utf-8?B?SzZvenN0ZHJpNzV1V2JsNE13QnduMVNWb1ovS2hwVEJoOEwxMFkxczUxNytL?=
 =?utf-8?B?SHA0RENqVGFhWkQ0UnhlaTBDdHNRYW9JZ0k3QzRjVlMwU0hNT2V2T3hoRktJ?=
 =?utf-8?B?RThoTmx6NjA2anBqK3ltRjY4VDhhL0RMS3NicVhVOXNJbGk4aWl1R1pDNVhG?=
 =?utf-8?B?eWlJclYxV2x3RHFaZHpRaDc4RlZqVDBrMFIzT1hwd1pUb1VTM1ZHNW9QTUFv?=
 =?utf-8?B?cEJPNmJQYThKQ05CYnFhdWhIUWJoTFUwUTFtZ3FOU1lHQ3J2ZjhpdjZ4RGdQ?=
 =?utf-8?B?czc1SkI5YTJSMnJxVmloMUUzTncxdUVCek1JZGI1ZW1oRktNdUxjeDBhQStN?=
 =?utf-8?B?dDY2Qmh3LzJ4UXR4RmVEb3dPRURjTUlWME1KaGJyN01mcERFdER1SXhlVTBT?=
 =?utf-8?B?ZHRGN1hLb0d1V2tvMWJwSVh0SDFlZkRkUklEK24zVmdSUiswNFBBVE81VXZU?=
 =?utf-8?B?VkVKUW53QW0yVG5PZ0ZwRWUxRWQzdHVtMHp6T3hlU25jN0JRTERuUTNVN2dB?=
 =?utf-8?B?dzNXUDEyeW95anNTblBzOHdHYnZFNUp0R25kZHArU1NzcVg4MjBjS0FzOGYz?=
 =?utf-8?B?N0UxSWhkbjZ1V0N5aSt0ZjZZWE92V3M4TE9UU2lGWWhyV0JHVDRrY3NmWlZI?=
 =?utf-8?B?SXZnNXlTdkgzN3MzbFdLd045WXdnZURQQ3JBd0VsQzVvZ2lleWlVekZvVUFa?=
 =?utf-8?B?V2h0Y3BKSG9hVEdxaDZpU0sxSzRoQ1IvaS96alZ4dERBRzY4YmtHN21waXB4?=
 =?utf-8?Q?kpJHEU+kQLM+kBILoTTbLEQvx9ix8/Gq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTlsSzZSK2VWYUR2OElwVUs0ZGxieEhpbG9pY3JGaTVpYm5XRXBYYkNZTVNk?=
 =?utf-8?B?ZEVCUW55dTJ1dnREMWF2K2RZa3lPR2NkeS9Rd0pUSVVpUXJDd2FQcHBaUElo?=
 =?utf-8?B?eU1sNVlqVDdJYVEwYzlTcVBiTitLL0ZJR0k0dVZNMklwY3ArNnRNVTZwK0cz?=
 =?utf-8?B?KzJXbWc2UjJBUnFjVU1XMElOZDZOcmhZRWc0L3l3SEl5NHl5aWJ5Q2pMKzBr?=
 =?utf-8?B?ZzZkdFpPQVNZeDNWY0NhTm9Jd0RuRXNHeEZlSTM0MXNDa08xYWRlWk9RM3pm?=
 =?utf-8?B?bElHZTlhM2dCdnFablFMcUhqQ0xiRHdOMHVWaVpmRTkwZFJ4V2FEWXd1WmUy?=
 =?utf-8?B?S3BlZWZHVjZWb25pQlR4TVJKV0NpMTdTNXZIYXZYNXlNbGtCaHNpMnA4SkVz?=
 =?utf-8?B?WnZDMTNlZ1h5RjBmdmxUSmNzUnlsbnFXSStNNllnU3RPQ3FlVlFoLzVVeFFV?=
 =?utf-8?B?WmE5NHhtek9HdloyK0h0WkI2d2M3YnBZTEtQdXNqbnBENWN1cit6d3ZJZXhl?=
 =?utf-8?B?ZHJYRDJiWkYrTUlnaVkxNTh5dUtER2kwYUJJU0svRjJvNFVsOGNOWVdZYWxi?=
 =?utf-8?B?TVBzSTF6V2NUSnBtTUU1WVBRRDN3RFh1b3phU0JQRnFDZjNSWTJLSi9JWmJJ?=
 =?utf-8?B?NkhrRkZaaXFEdjg2SEI3MG9yeHZEcjF0UjYyUEhTNHVjaU1yTkVLYnRGMXc1?=
 =?utf-8?B?alVXL0svczF3WExrc0lTZEthWkdqckJUT1lLdHJYdTNLUXl5Rit0TS9tdkFP?=
 =?utf-8?B?RkxnUVJSWW15T1Azb2k1NllESVFxa2dpSDJBN2h5bFZLbEFpQVVIK2F0TDdW?=
 =?utf-8?B?cDdYai9Jc1BkMlhDaDNFVDRaOWFISGQ4WUVDSnpYS3JIdG96dVExRzV1OXNn?=
 =?utf-8?B?SFNhK0JXN2cxckFQQ25OcTMweU1SWXhLdlY5MXZuZHZOc3FxcGFJcnRkZmVG?=
 =?utf-8?B?VzdnTjE5WU9KZ3ZZcmZDOTRxb3BxQmxxZjgwTGk0a2VsSFVYUXBRWVRRelNh?=
 =?utf-8?B?WjJRRi91cElFd2Y3RGp0dGxxMkFIZGJXWkQ1KzE4Ykl3emlCMmxuUzRPWVdr?=
 =?utf-8?B?blVBbUVwY1FSMS9JR3NsZnZGSVdUdm1hdXRqRml0bVZoNVdkUzR5bnl4OUtk?=
 =?utf-8?B?Tmw3c0V4NnNlSG03L1NVTGJlUFRNRTF5eXJOUVoyZjFmWGZnMUNLSzhRNkFO?=
 =?utf-8?B?b29YclVDWWNxa2NmeWZWcjh2b2NxTmswNUdNSm5aekkzdDZMZ0Z6dnB2UEs2?=
 =?utf-8?B?akFvMjcrcko3LzBVK2dyeU1FNmZhUWgrN3hkL21weEh4K3UzZG1tdzZBK01Y?=
 =?utf-8?B?M2h2YTZzQlU5SVNzWnZ5T3M2NXNEZ29HM3lWdE9CSzBkb2p0cmtuTjhmcjR1?=
 =?utf-8?B?T1pmOHBhems2bmJlZG1aTUF2Z29qTzZYM25xaEJudDl1bWhndmRRRFJJR2Rl?=
 =?utf-8?B?RDZtQXpPbWlJcHhXeHdaNjZTZTBnZ2s5QTQ3a0gvdzZiVnhDSkVrRDNZUEdC?=
 =?utf-8?B?c2xJczhWclRjcnJ3Q0NRYktWU3lRSXl3dG1zS2U4Sm9FVVBqK1A1VXkxbzdV?=
 =?utf-8?B?R2FyV0RaZGpJVC9wRitqWXVpdldKMW5GVVQ5ZDIyZzFJTlU4aWpnQ25uT3ND?=
 =?utf-8?B?cnpKZ1VGT3E4VnpLR2FhYXY4bDA4MEUvTFBZOHBvSlc1WTNoUUJBdlhkZHlB?=
 =?utf-8?B?b3BlMTJCcXN4aGpzV0FyTVRyR1NtenRnYlFnd1R6Y3psZytQN0N5dVorTHVP?=
 =?utf-8?B?dTM2d29BYXRrRUVGMkNlN0pZNlhFZHR6VmFsRzVtbVNhTTRYanlnYU5VU3dz?=
 =?utf-8?B?QzJnZUpON21tamdtck1RcWhLMHEzVHZRRCsxbmJ2MFhIcTlvb1lLZ3VUZDJN?=
 =?utf-8?B?OUFpcGNXQlo1R1l5ZXpWRzN1S011UjNiTXBBQ3JGaWFUYnREcmJLVHNkdVhG?=
 =?utf-8?B?RU11NDRlSzNKSGFOTW9EcUlJTUw0UCs4VkFRbkZFTXdGV0pKbjBzV3d6Y0tm?=
 =?utf-8?B?UGcwQU9ITG1KamNPa1BWcFNDd3QvOWQ4cHA1ZWVTdzU0bmpxNXdTV3Y4WVMv?=
 =?utf-8?B?QThuUExWblQ4djFOVmMwSkpPdWw4MmNKcXZERGpBaG94cy85WmVYMTdyRGIr?=
 =?utf-8?B?RlVDNnhESGh6QXdNSVQ3NERyRVlrVHlpZkIxb29pY083amk3OFB5ZWg2YXBW?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ccb8fa-464d-4da5-4c29-08de287bc9db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:28:46.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPOCNIsVYp/bia82fKI+vfrBpkA3FbO48J757pQ4BAtLwcXtoQpWzWOAr0zMlqTfRRm2/fIX3cGhAI/IGJjdDxwAwB4HBCYJyXLX/0KYTD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> +/*to_pci_tsm_pf0((pdev)->tsm)*/
> > 
> > Left over of something?
> 
> Actually not, to_pci_tsm_pf0() is a static helper in drivers/pci/tsm.c
> and pdev_to_tsm_pf0() (below) is the same thing defined for
> drivers/crypto/ccp/sev-dev-tsm.c and I wonder if to_pci_tsm_pf0() is
> better be exported. pdev_to_tsm_pf0() does not need all the checks as
> if we are that far past the initial setup, we can skip on some checks
> which to_pci_tsm_pf0() performs so I have not exported
> to_pci_tsm_pf0() but left the comment. Thanks,

Why does the low-level TSM driver need to_pci_tsm_pf0() when it
allocated the container for @tsm in the first place?

For example, samples/devsec/ does this:

static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
{
        struct pci_dev *pdev = tsm->pdev;

        dev_dbg(pci_tsm_host(pdev), "%s\n", pci_name(pdev));

        if (is_pci_tsm_pf0(pdev)) {
                struct devsec_tsm_pf0 *devsec_tsm = to_devsec_tsm_pf0(tsm);

                pci_tsm_pf0_destructor(&devsec_tsm->pci);
                kfree(devsec_tsm);
        } else {
                struct devsec_tsm_fn *devsec_tsm = to_devsec_tsm_fn(tsm);

                kfree(devsec_tsm);
        }
}

...where that to_devsec_tsm_pf0() is:

static struct devsec_tsm_pf0 *to_devsec_tsm_pf0(struct pci_tsm *tsm)
{
        return container_of(tsm, struct devsec_tsm_pf0, pci.base_tsm);
}

