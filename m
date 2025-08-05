Return-Path: <linux-pci+bounces-33446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B70B1BB95
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66350188B11F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931C23F295;
	Tue,  5 Aug 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z67ppJQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4E24169A;
	Tue,  5 Aug 2025 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427594; cv=fail; b=jfout1OABiumoMcgNLsmZB9aTXVR4eW+Mqks1DLqkRYwaou5wEz87GSAwscWWJ9JsvYohx1HAwXOmW0pFtUOIMP9BSUATRM+H9MThag5kPPjfhvae0dYLWsoucayYDWPiXfHBASPo1/PqPPyaxiUkJ7ZRm+s2UyM+ENlTTwoUjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427594; c=relaxed/simple;
	bh=9L9Wr0hvTlt6RmpNMZKLzZbq/sXRK5e6cd5mRi7YRGI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=V1qnM5PIA8LpP8gYkJrvtcoEXQ7uAO2L6X4QyAR/kH1WQ4hhdeZtqdEtKjfCBSAmr4zLtrrrbAQ0uOWkyPbNokxpKwWXuRRxOcemJtqo5kJYSAhecnEgTIDOFxRWNiS5/0dPHd7fYdoGH62r2B5aS1ljoDwnXgdZB1C+dLf2XxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z67ppJQk; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754427593; x=1785963593;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9L9Wr0hvTlt6RmpNMZKLzZbq/sXRK5e6cd5mRi7YRGI=;
  b=Z67ppJQkMcGCjNUJE9LzWV57LUMqrJRFPUiS6l9pGSGvL4HYvL/SD2+W
   PnUbHxEI5PmqeUPvnvW/rdRKF+/se8AineKfB3uLvFQ0e7kdEu16mymO2
   s0upvMAF6u8oe/YSL8zgG3W62xCV5VVWD3icdNvfD36LhtoWohRsfgEQQ
   mYG57ZtxN5+mTirczfQLQWDy9kHlwkVs0gO4erWx9hQoQ3s3Svqmm3QxP
   FwtcxF0Uh/5g0klrwybYbOGbOJpw0C0s183qkb6vwFDutqnpgKDgzKaik
   zxcYVras67YHrtdWop10n+2VxC6BiWZUXIl01ggm2NN6vL1+TowyV/OtG
   A==;
X-CSE-ConnectionGUID: CrKFmmNLQ0y5YltOaeNR2g==
X-CSE-MsgGUID: ASGAecknSkyluzrMRhH6tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="74196628"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="74196628"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 13:59:52 -0700
X-CSE-ConnectionGUID: a0Rt8epzSEu2a4ccWIFq4Q==
X-CSE-MsgGUID: kdRNE+NuSJmVITlo7K3OEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169862194"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 13:59:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 13:59:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 13:59:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.52)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 13:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfSA//pAOhsMrjVouCOsTukZJLpz7lZlIVIkmu8PD8HZ3NKxaZXcoLVkdSMDimAo16nmpXlMmLqNq4U755LGq0YUWH0fL5nBAlnuTEYpxOld/TGLzkEWCqnfY/z6GYq/g7AiOvTVpC6WhKlpo1u1USn6hn4flNQlcSy3cuTMuNQ8PUlOniy5S6FJv9gGY1bpKDGPobdSaLZOrWwWxtvEKIPs2Qi5BVEa81RH3vwAFdK8PxDl4vdPhl90FvHi/Okx3LdHxYKuGZ7uiqOiNsKW3MslJgxUDD0PWr3mkE4JCOMld0hH6QwJYJqNLSrs9JXoFqP+DDPM0VeTt5k9a57A9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJwJGhSx8UCSWStTsv0XrxPn5jA3gSCeM18negqwsOs=;
 b=LRoyaFSQpVe8gzd3IQDQI8oIdF6jyAIFf9NB3EPak79SHkz19sc0aGgrermIvtcxxR0j4AbaNXAMSnFMENUQoDOofUAvJTvjioGad+BS9GUAr3cBJWQ1/vDJQ6+JjW1ATWV6n8D8ZnsGgxdDkDrNn2CFAzd5Bj90iPfD1+Hz63hlNucAlQfDLOdBDFrbJQGWc1c0ZUW5fDRIvpUxWmBG+HVFhyK7cFfHdqxN4J2rUagSQWqlNinGWxNbaVaROWnca8mBSA3CQzlhfrzwN8aoFj7FEobYkGOXR+FrNteYOqCG3SVl+EgB9dHj+SneuHpqi79Tf1gQsD3Cwue/XMHm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 20:59:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 20:59:48 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 13:59:43 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Yilun Xu <yilun.xu@intel.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>
Message-ID: <689270bf9aa67_55f09100a0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729130327.00005fc2@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-3-dan.j.williams@intel.com>
 <20250729130327.00005fc2@huawei.com>
Subject: Re: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0021.prod.exchangelabs.com (2603:10b6:208:10c::34)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: fdba0db9-f889-4a03-2699-08ddd46303a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEFMcEpIcGsvb2pKbWdQdlBZdTRWaTZhS0lPUGdKWnV6U1FkUHVicUc0M1Vx?=
 =?utf-8?B?V2JUQmdBYnNXV1dPcXdpOTBHc3M1L285dnpoUmlVNEUwTUh3Q3UvMFl1M3lK?=
 =?utf-8?B?WHNpM2EwWHVQZ1oyajdBeUJrNi9IdWVLZ0NXdmlZTStVMkxTK0pRYjc1bzNw?=
 =?utf-8?B?OG9XOHJzN3Q1NFBFQS81Y1gvbDBDdHN5djcwM3dMSTJQbml4THpUWVlyQmFN?=
 =?utf-8?B?b3lpTnIzT1RRSE1SWkdpeHhQN3cyTytNeTJTNC9sVVNVOTY2R0hMOThYVFRX?=
 =?utf-8?B?dEVPUkUyT2c5Nm02OVRvYVVyNExWSmtLc1E3SncrZnBjV0xScTYxTkpvYUsr?=
 =?utf-8?B?OTFRZHA0Y3g0MEs1eWdIMzhSOExZd0ZZQnd4T0ZTV1cwK2c1Ump6V0Q2NDJD?=
 =?utf-8?B?N3FDYVJFUXlaRzloUHBwRHhlUEphWjZuSWFYeFZHM3B1ekdtbzg0MFJiYWYy?=
 =?utf-8?B?aWl2UVZRMXVSNzJmWG1jOElCWWlyVEcwMS9XMmgwQmRnVG95Q042Tmd4QTM2?=
 =?utf-8?B?ZDFVNm9ZYUh1RVlsZEpYd3QzdG9IS3MzRVBtUWxzelh3d0xRVnhvQWVrTEhj?=
 =?utf-8?B?Ym9kdXpqSGxXcUtUTlBOaUp1Q1hES0d1ZmFQQzJEcGIvR2ZvWjVFTzl5YjN1?=
 =?utf-8?B?aDRscjlYRjJDS2VlR0l2M3VuLzB5VHowSThNVWFNU0cySUVRQlMyS05PRWZ1?=
 =?utf-8?B?bmMzQlJpM0tRbXBBMHJrQzQxZmJjU05Id3pHckprQm9ZZ25GcEprKzhNT1o5?=
 =?utf-8?B?UEMxVnpUUXVtSkNFSTRUYXV0RlRuRHlUZG9nL1ZxUHA1MUdXSHQyS21uUmI2?=
 =?utf-8?B?MGxWK0UycEhkZVRqSlJtRGJ4M3YrV0x3MjM3R1JLb3RxU0wxcm1pWVB6WUxp?=
 =?utf-8?B?YjN6R2VINFU1NEM0RG9wTkJrSjNvVVdQUGJuYUtGaFl4OThQWXlZY0plS0xu?=
 =?utf-8?B?WDBndXc2T3A1VGcvWFFIaEYza2Mxc05uNzV6ek1KdTFMSnFLN2ptOWhGZWpy?=
 =?utf-8?B?a2xZVHdBMGZnOGpEMFdYbWhnZ1I0Sk13WE9kVDBPZkRDeU0rSjJ1dmcwUGIz?=
 =?utf-8?B?S2c0UW5CN1Rad0tERWd6TGtTOG5SMGFTaE0zRE1mZFpBN3phZHdjTk41ZE1p?=
 =?utf-8?B?dmZqeGw2aW5JODd0eFBpdGx2ZVdIMWR0d3VXNWh6WTBFNWpMK2IwSzM4SXpW?=
 =?utf-8?B?ZFNWdEo3NURsa0NpWjR6UEhMc2xYME9kKzB3cE5CUmVNR0dVUFVuWlkzSVQ1?=
 =?utf-8?B?WS9mUGhLNlhoQWcwRW1ORU80Ykl4ZWVKbzI1Q0xEenNJRUVTcXl2MkkwTXpj?=
 =?utf-8?B?bngxbDMwRHZjTHNXNnBmMFUrZnZDOTh0MXhhRTc2TUNtNkxLaXFWUzA2a29l?=
 =?utf-8?B?WDB0eDJ6eDUzaGNwc2ZSd3Vlb1FoY1k3VkxZUmZGM0N2NUs4NVBSWUs3ZE5E?=
 =?utf-8?B?VzdQWVp6YXNZY3NBcnU1eVpGdnB3WmY5ejczQk8zeDJLL1lsa0g3K3lHRzFu?=
 =?utf-8?B?b1cwTFlEVkJnak9IVVh3Zk85K3ZPMyt3OEhOTVJKS1R5RU1kK3V0a296MkZl?=
 =?utf-8?B?SlVZWEhVUGFWdTZOQjFXZjRIYnFoakNDV2V6d1NialI4Y3JTcXltZU9pdFVn?=
 =?utf-8?B?SG1xZzJiUnNhdjY0cnpoTG5wcjRSY1FacUQwZDlDZkRUcjl2aW1GK2pKNk5F?=
 =?utf-8?B?TGhWMW5uaDNsV2ZlZENrN1VXcGN1SGJzcVpJaElGVTBwbVRrM081N3hmbFkw?=
 =?utf-8?B?b2NEZmtsWmRlUG4vVlkzWDFxUFJIb1pZTktzTUo3NDN5RHE1L25Nd2tZaFJy?=
 =?utf-8?B?ZVFPcWJaU2NLcEVjQW9CK2tZVHB6a0pJS0wyeDBBdlFlV2JKQTdKSkorWXhy?=
 =?utf-8?B?RUxTUFpQSlJGWDZuVzNmWmlSbU9pTmQya2R1Qk9LWkw4ZkhyUThpdGl3MERP?=
 =?utf-8?Q?K5lulK/cTDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm1Cczkyd3BNSnBwcFhpamJwSW9teXdEZVl1RTMybm5la0RqRW12K1ppY1NT?=
 =?utf-8?B?Y0JNY0VSMGZiRUxjZHhnQmU3TkcwVnM4cFFFU0VCdjcwTitvWE11bEltdkox?=
 =?utf-8?B?WWJ5MkpyRjU1Z0xKRzFacllUMG5yZG96QzN2VHhhTG1CdWxBSnVWb1dqb1RB?=
 =?utf-8?B?NlVrSWtFSTVuRjI3dEtYOWhIUXMzOHFQU0FaTVNPRFB4QTdGbHpaT2dtekVt?=
 =?utf-8?B?S1JUVFVyaktNU3FPb29CYjM4a3hkS1ZVUVZxcHVmUUVvemY3MXNwaUIxZk5t?=
 =?utf-8?B?SlJwMldMTE5GbDVrdW9lbVlDdjZaS1NWU2pEMnMrSzVscm5JNy9keEROVVRt?=
 =?utf-8?B?VDdNTENqOWcwd1lZODNacUdPVGJTRlNVSk9pVVBuVkxVbWhhY215TFZacFo4?=
 =?utf-8?B?aFowU05NSmNpTGVrYkV6TGtUNWxGbWJmM000YjhoOUpEbVpHbGdWQitoTG5T?=
 =?utf-8?B?cmx2L1pMQ2lJNFlzbVpLWkl6cHRLK0pGckdNTGxVZi9Ndld4cHZaN1V2OTU3?=
 =?utf-8?B?L01rSHErQmdXa05hL1NLNllHMXVzajc4VG8vdEhzeEEvMU1RdDl2aU9rWUF3?=
 =?utf-8?B?WmlaT3pMOGUvbVl6c2tuQ25SK2RIVlhCaTRrUTdIdmdMY0U1ZDhNa0drUVVR?=
 =?utf-8?B?Mm5IazIyVDhNNE1NUDNsWVFpQ2dXZ1QzQmVnMUJiVU1lR2NZSjVGN2p2QXZE?=
 =?utf-8?B?Q24veGlpUktoZWNJcDFLY2ZtR2czV1ZHQnZtTWQ1MjdLbTY1bS9uaW9EbExm?=
 =?utf-8?B?SkZnSWFVbmZrK0xJM2JSWUhyMnhoN0swTkxvc3ErbVdERkxLTVliTGxpcnZS?=
 =?utf-8?B?dmJoVVdxeUxUNWFnaSsyWkxzTkg4LzlTeGxOUmVUU0VTQk1lZUhCcVc2TFRn?=
 =?utf-8?B?ZkJNakw5cUJ5M1c1OFRPcGpabW92Sk55RFV1ZEJXQXgrR3ZFZ0pxbHpPUVZm?=
 =?utf-8?B?bHNUaFMxMTg3QkViTVpIVHg1eGszVHg1V2ZZelJLais1d0pxd1dTSnBDUHF6?=
 =?utf-8?B?NDJNY3Y0ZytaZG53eDR3SWhnSC85NzFrMjlvSjFJVDRCTno2TXpaTm5UdllZ?=
 =?utf-8?B?cUdacEtZR1A3djRZS2pZWERld0xXSklsWUY4bGQydFM1a2R4VEhJSzczV053?=
 =?utf-8?B?RlpiNXRMcEw1SW8xRkM1Q0hzejhmQnlMNU0zdjJYTGVOMVdNNlpBNTlXSGZI?=
 =?utf-8?B?L3h6TitERzlQbmdYVXkrY3lxdGpIeC9WM28zMmRtMVcra1haMWlSWFlJL0dM?=
 =?utf-8?B?UkRwU0tZakkyanRua1JPNEZqbkpMQ252WFZHKy9BRU1UbXdKRW8rdzFhNzM1?=
 =?utf-8?B?QkRIcFZiZXlhWXhpcDVtS2IzdnRDbWphUzVXdm91S1l0cGdpVzVoWktEMVVa?=
 =?utf-8?B?U280U0N1WTA0MkwwZitjamxqa2RNRHd6enJJcmVHV0tXSFJqZ05ranlQN0JT?=
 =?utf-8?B?bTZ1eS9HSko4T3l1cVlPT09lbDQ4T1JQeFVVUDd5RXd3SUlOSi9Ub1ZIRXo1?=
 =?utf-8?B?STh1RmZJT0lydFdNWlZCU1JIK01nOXk0VEdmK3FqcXZ4bEoyS2hDQzlmZ2p0?=
 =?utf-8?B?QWp2b1hiM1UvSTU5QUErVzd6RzVHai9hOGg1RUc0OURUSTd5cENDY0ZWWmh5?=
 =?utf-8?B?MEcwYUVMd2dhMzRXZUdrNmN3MWNoVS8vdjNYN3pnakRhRTZQUXhDVVdmVnVL?=
 =?utf-8?B?eUZ1Y3JSL3d1aWZOZ0o3UUNFTGRScFQxY2UvVHhWOXk3RzNMbk1OZkdRRVU4?=
 =?utf-8?B?MXJ0NzZIcUt4NFFLZ1hhNHhENGtZMnhUbVZEUnorc0diR2svVTIwd0I3VFFw?=
 =?utf-8?B?MWdaenhBbmZXeXNpV0tzWUVWYjBFRjZ4dVA2VThnVThjZmt3WVJLUWJrd0pG?=
 =?utf-8?B?SHc2OUxyZlBtMnVJdlZ2WU55M2hlUzcwbDFCTjZteHljbVQ3cHI1Y240RnlL?=
 =?utf-8?B?anIzSjNsNjVlZlc1OWhsRGFwN09LOVhkYjhUT3pjRzBNWlptem5ZQUoxNlJR?=
 =?utf-8?B?K1k0TExuQzhxZ2JxeFVaNFFCN3l4WHNQRloxTHhLTVE0QmdEMEx1c3hhRlpJ?=
 =?utf-8?B?cVVtbSsyYmYwNi96WEloWmxSUkR3TVhjL0xIV3dLLzZkNk02Q3g0d2cyODNC?=
 =?utf-8?B?cVhobGNrcDhObjBBbExEaE84MTkzTnMzZnpzYUlUM1RTYUZKU0J5QVlRS0Mr?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdba0db9-f889-4a03-2699-08ddd46303a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 20:59:48.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKpC/vLxyaWQ81eqNmyy/Dm7J6i12wU8PSFFbl+wZ+i7nwJMmcpv1RPGv24KHD2qBxgGwZkvf6YDWGuwFI1G0Yv8cIN0nYAsbsbH5JsAJ0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > new file mode 100644
> > index 000000000000..e15937cdb2a4
> > --- /dev/null
> > +++ b/drivers/pci/ide.c
> > @@ -0,0 +1,93 @@
> 
> > +static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
> > +			    u8 nr_ide_mem)
> > +{
> > +	u32 offset;
> > +
> > +	offset = ide_cap + PCI_IDE_LINK_STREAM_0 +
> > +		 nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
> > +
> > +	/*
> > +	 * Assume a constant number of address association resources per
> > +	 * stream index
> > +	 */
> > +	offset += stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
> > +	return offset;
> 
> 	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
> 
> is perhaps a little bit neater?

Sure.

> 
> > +}
> 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index a3a3e942dedf..ab4ebf0f8a46 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > +/* Integrity and Data Encryption Extended Capability */
> > +#define PCI_IDE_CAP			0x4
> 
> Spec uses two digits. Things are a bit inconsistent in this file but
> 0x04 looks like the most common syntax if hex.  Curiously some are
> not in hex.  Anyhow, I'd go with 0x04 etc for all register offsets
> unless Bjorn or someone else shouts otherwise!

While I'm here, might as well.

> > +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> > +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> > +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> > +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> > +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> > +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> > +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> > +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
> > +#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
> > +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> Looking at the rest of this file I think this should be.
> #define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
> #define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> 
> So indent one more space. Example being PCI_LPH_LOC_NONE

ok.

> 
> > +#define  PCI_IDE_CAP_LINK_TC_NUM_MASK	__GENMASK(15, 13) /* Link IDE TCs */
> > +#define  PCI_IDE_CAP_SEL_NUM_MASK	__GENMASK(23, 16)/* Supported Selective IDE Streams */
> 
> Space before comment missing?

Got it.

> 
> > +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> > +#define PCI_IDE_CTL			0x8
> As above 0x08 more consistent with rest of the file.  Same for remaining cases.
> > +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
> > +
> > +#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
> > +#define  PCI_IDE_LINK_BLOCK_SIZE	8
> > +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> > +#define PCI_IDE_LINK_CTL_0		   0x0               /* First Link Control Register Offset in block */
> 
> Event this I think should be 0x01 for consistency

You mean 0x00, right?

> 
> > +#define  PCI_IDE_LINK_CTL_EN		   0x1               /* Link IDE Stream Enable */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2)   /* Tx Aggregation Mode NPR */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4)   /* Tx Aggregation Mode PR */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6)   /* Tx Aggregation Mode CPL */
> > +#define  PCI_IDE_LINK_CTL_PCRC_EN	   0x100	     /* PCRC Enable */
> > +#define  PCI_IDE_LINK_CTL_PART_ENC_MASK	   __GENMASK(13, 10) /* Partial Header Encryption Mode */
> > +#define  PCI_IDE_LINK_CTL_ALG_MASK	   __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> > +#define  PCI_IDE_LINK_CTL_TC_MASK	   __GENMASK(21, 19) /* Traffic Class */
> > +#define  PCI_IDE_LINK_CTL_ID_MASK	   __GENMASK(31, 24) /* Stream ID */
> > +#define PCI_IDE_LINK_STS_0		   0x4               /* First Link Status Register Offset in block */
> > +#define  PCI_IDE_LINK_STS_STATE		   __GENMASK(3, 0)   /* Link IDE Stream State */
> > +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000   /* Received Integrity Check Fail Msg */
> Naming here is drawing on stuff not in the Status register description (in 6.2 anyway which is what I'm
> checking against).  That just calls this Received IDE Fail Message.
> The text else where calls it out 'Upon transition from Secure to Insecure for any reason, other than
> corresponding Link/Selective IDE Stream Enable bit is Cleared, for a given Stream, the Port must transmit an
> IDE Fail Message indicating the Stream ID to the Partner port'
> 
> To me the integrity check naming doesn't really cover that.
> 
> I did some minimal digging. Your text matches 6.0. 

Will update to:

#define  PCI_IDE_LINK_STS_IDE_FAIL         0x80000000        /* IDE fail message received */

...and same for selective.

[ snip the other occurences of 0-padding register offsets ]

