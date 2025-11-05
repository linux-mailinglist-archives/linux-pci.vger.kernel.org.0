Return-Path: <linux-pci+bounces-40432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8CC38193
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BD818C7243
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7929992A;
	Wed,  5 Nov 2025 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYGrZGjp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C35296BB3
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379405; cv=fail; b=ilVbfU02bIBBohTjKkZ13pzWM1mLdDIiD6courTQNZTdr7WDzL6waPIP0VNGdHdsdBjA9OY90gtTAqzO0QqgeDsqi1dbGFNwsOzDeknh916FaZQH71VxwSwP91vwnhoiXu1YfBY5jI2XVp3Ox99+wcNN0lb/otEdG3scGBK/ZaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379405; c=relaxed/simple;
	bh=NRmoU0IUv3kfieoYpNCG61sn3xgwyLnAF6kxiNExVNs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Julkm4/UvUA9d3jvsDoyrBTRH5xw7fdfIgySqd8kz2zRSvvSYI53GtQPkRFsP5rnVLD9ggPLsQb8lLbOUFZ76gj+4audc5eS30e1YaZaNEfUlghvZfKiUhcGp6+WajTDTfXsn5d5EEkHJmRHS8flTI3/lwIh0Bz1tvUUb1svH0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYGrZGjp; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762379403; x=1793915403;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NRmoU0IUv3kfieoYpNCG61sn3xgwyLnAF6kxiNExVNs=;
  b=YYGrZGjp/JqyUkC/WcqUfqMxgQZludz8jVO6Bwr2s8Y3CY6HONBNC4QT
   L8Orta6qcYyuckbDciixGc2D3EcvpOkkIloNzJahJOjh8g4DDzb/E6PPJ
   yrlvScC6sl/1upMWVhaGz23iLG75qLKzhMAT5qTDfdKvdtUrYlGc+m0lM
   7YmxtlT9DlB1WVlmxh7xzf35l8+BjUsaFXwM0a2ZhrhHCv9mTuwjTsJqL
   I276MUfOCyyV3xMUnJVOhW07SDnKnK/x84fOIkWqEjmS6ES2T+NKe/os4
   +Sd+VEiDQ/0aHYLsaAruSU4UZc7x3XtEoEnpS4HC/MbZWyMS53IeicVAY
   Q==;
X-CSE-ConnectionGUID: qXDOrVAfRTS9Cbev+dg+HQ==
X-CSE-MsgGUID: QXTcq058Qx2oJQyZGOpFmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64433280"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64433280"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:50:02 -0800
X-CSE-ConnectionGUID: hvfR4G+vR0qsaqoh2FHy6A==
X-CSE-MsgGUID: G3mQy+T4RSyyJ9Rx1yAvhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="218227432"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:50:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 13:50:01 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 13:50:01 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 13:50:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz0WKYpK354+O81ACFNOHwGfP6UyVi82hhhIPEWH3zTGu/w3Z29smknnmRllORWsHAYjur4qP4eqrQhS6/pLjXKFnJ1vgXu+/FoiyfyNnlfHm28CADzrvMJrgnACj6NFqODWjh94B9xLH2sVZ3rrwGRBh8uTc8VVEDzIhvWfLu31glIw87dOiD3cNVYr76kyAHd+iHVrISUQhDz2ndpf+awUIBgjrYAXct7kMs1HkFBZe1dovqOqDQMqJ/Yw/88pPtUhBMGjLgd/c7/07CQ0IFJ+fqTtcuYf66Mbw+kQy6MH1UXyBzmS6C/XcoEUDyIJ8PwrTrlXLK+9Zh+qF33/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYJy01mtq3Rhj8awZVI+8QztjgqfjeWji5pfxe+zGD0=;
 b=pTk9hPAFw2bBE6+lGCWeitrw4xdKYnPGbTlqQrnK+JIUQIuh1pXjKk982FIOdcIGmUoWomB9XhE09jtWWGiy+hkTzkc8AzcBpMfoNxoB3/rjIoKuSWjFdZJ2WtSozonT/IDEPx6coN4K6JB+OCmdGstoKXpvAqtgXMjkEzKmJKV+iQ1Qo1EuVyvxNSk0nkF+7oNXyjlyipIbEFAfGQxfZel0rqDFvOWarNeR3jbi/9P8mYYe25krTMqus4bJKVR0CHWtqBa088NK3lg6dqYmu+9QECmpRq21Ia9d7uTUA5R9oXMe9jZUdFuqynj8+KhCvK9i5Ep1khaacxFsk2nkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 21:49:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 21:49:53 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 5 Nov 2025 13:49:52 -0800
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-pci@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <690bc68082c76_74f7610077@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5aecqdcbwa.fsf@kernel.org>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
 <20251105040055.2832866-5-dan.j.williams@intel.com>
 <yq5aecqdcbwa.fsf@kernel.org>
Subject: Re: [PATCH 4/6] PCI/TSM: Add pci_tsm_bind() helper for instantiating
 TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: c62fa458-fc31-4aa5-0806-08de1cb540c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHVsUEJzZUFBOVhaaGh5SHBEN2RxazRRYmRQRTFWcFNRUHpNRkpjZkhxcG53?=
 =?utf-8?B?UWlzU1NubXRPOUhnMVFRdTJPQys0QWZkZXNmVVl0eWhYL3Ntd09NU2djUHpw?=
 =?utf-8?B?RGFUR1ZkTUtQWkVhQUNEaE9BVjFLUTROMmtiSFdQRGVqNzBjUTVaR1NMVzI2?=
 =?utf-8?B?VGdNWE1KWEN2ZGlJT1Z0Q3VKRlQ2cHVTbUZqU3BQRloyL1Z6ekptZFRrTTNo?=
 =?utf-8?B?VFh1TXlqeHRYWk1SZmhnWnFkL3hTNFlIczUxV2JZNVlCZlUvV2p2SHQ5ZnBO?=
 =?utf-8?B?QUZKcWU5REtrbUllNWxaL3pQVVRDcUNWZzVXbzRPMzkyQVZNNDhpNEc5NHRB?=
 =?utf-8?B?dkVGZkRmVDVrc3FadGpRN2lOanJHS2NkcTNMMWtvUHdvOHFBMFU3amhpZ2lF?=
 =?utf-8?B?ZWg1ZUVoMjdtU1NBOWc1SkJhUlpGUEFUS2hoZDJ0dzJBU2hZcHYrV1ZpOE45?=
 =?utf-8?B?eVIrdEl1dWxxZCtxVEN6ZE5FZGRzUDJmbjRPbmJpNERRdVNEN2JMV0pIcVcy?=
 =?utf-8?B?OWFyWFM1OWtDTUpJQkZ0TE1Hc1FjQlQzWlhKL3pUeHFMSitocFUzeHRvMW0x?=
 =?utf-8?B?TWtTU1JaVXREdmU4QVZJOGNBREhzVEpId3pBZGxIUFcvQnJTS29ZVmF1M0VD?=
 =?utf-8?B?MU5kNXlRR1ozSkx0djl2UWNpTVlKWFZjSVh4U3FIZUtUeFVnTWw4cWUwd0RE?=
 =?utf-8?B?VHNrdkE3M09JWjdLWGN0b0s1dk9qa0JOb24wdHNuS2tOVXFSMzFmTFQ1M2Yx?=
 =?utf-8?B?ck9RZXRkM29obVZySm4zM0daWjlOZmY1cDlwZzVZNlo5aDM3eFhKREFKcE9N?=
 =?utf-8?B?NXpqamxPb0RNVWplYW42cmVZejBjRkZjMDhhQ2w4a2ZBVkRuaGxaaVYrNFhO?=
 =?utf-8?B?eUVLRDFBL2Z0c0pGT29XdkpKTmc1Sk5HVW9hK1BKTVZTM29GbW9uaUVoQXVZ?=
 =?utf-8?B?dVh3RXMySFNMRlFKcWRMVldYOENzTUFLTi8zcmxlaDNHRFRBWHRFTDlSRTRB?=
 =?utf-8?B?c3RoUnkyWWYzZ1Q5bzc4VU5OMXF6M0NGS21nVlJGOU9wSmpWM1h0a1dVeTFq?=
 =?utf-8?B?c3loUDIzSDlhUmV6SkUvNVZHUE00d1h3SHQvTHMwQVNIbXk1WVdyNnFnb3hH?=
 =?utf-8?B?dkxCcjhwUGwxT1lPVDJZUWlkMjJNRHVia0VLMk9aLzV5dFp3aWR4QzZIVWd4?=
 =?utf-8?B?a25FV0tzOWZkZnpYTXNuV3VtRHBsQ0FGNStNYVJCNmR2allTdVh3cE5pT0tl?=
 =?utf-8?B?ZFBhVllRenBFOWh5S1VCL0xiN1luWnE3QnZrSXhiRUVldWwwSWxmSnljc3dB?=
 =?utf-8?B?a2JtTW5USHA1ckRDb3pUMjFFQmxvSXZUSmJ2ZzkzaUxkM01yL0p1bW9UMFlj?=
 =?utf-8?B?MU56b3ltV3E3eXliVjRQWm9JL3NsbDN5aCtlb2I4S3RMd0ZPVkZHMkFOczM2?=
 =?utf-8?B?WUpwM0k5YnBZYVk0ZDFnOTF2SHhaWUxXWlM1bEdXTmZMVG9QNVRIMWgrVjgr?=
 =?utf-8?B?VnFFQ0lmSkVtNWd2MGNiZUFJcFM0bW43eGFGRnJaVTY3QTNJeWhrbmtkbjhW?=
 =?utf-8?B?aWI4Z1ZMeTlqcXBxYVFaWkt0TzRsSnZmbkZBYlVvWG05WTdhRTNUZ0NwVytV?=
 =?utf-8?B?Z0d2ZDBqNGRsWGxaWkJlYnBZYXV6dm1zR0FUeWtxakYzRVpHTmpGZVY3NDdm?=
 =?utf-8?B?aDRmS3Q2OGxLZVo2RThTRWU2cnBaMVlxNkJqR3hpRytodkZxQStDYXdpZDk2?=
 =?utf-8?B?ajRyM2M3Um82U3Z6TnVrcjdXa052NzFoZXpJajkvSkVoM1IxV1ZMcGpsZWgw?=
 =?utf-8?B?cjFUWWpFTG9WYnQzR21JZk5WTm9pSWFTeWl6MENBdlR0QXlhN1FyYXZ0QUVl?=
 =?utf-8?B?ZzZBUUFzUTk1ZlY5V1QzalRoelFhMHJ3M0JRSzFPbVZqS25HWWExOVhyZWF5?=
 =?utf-8?Q?B9iMc2BvZHpy+JHQ8JDsqe6qQt4qaywt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y290aTdMK3J2ZUtVU2c5bHVldjVwcndkMlpKUm9SMXVmNXp2Wk9WREIyUDJv?=
 =?utf-8?B?WHRMMnkycWlGNVR5UVNGbW50THpPNmhLZThrc3JFZVR2VEFuSCtXMnFYc0tG?=
 =?utf-8?B?OFB6OExGR3RHNDBQZGowUGJMeTF2SlRKUFpCMWdaRnFxMUJvTlJ3QzErbE1q?=
 =?utf-8?B?ZE9zYkk2clZDT01WMUh5VVpMSU5tcVgvMEF2eSs2MDViczN4V1Y4RFI0L0Ew?=
 =?utf-8?B?TkFCL3UwOWREVThnd3hVWFloK1VRSi9SeSttL2ZKRHBsNHBtdlFDcGVwNzQ5?=
 =?utf-8?B?bkMyOXFnOG9aWktNdTJ0Q1ZCNTJTb2dwdzJkZlNNYXg5UUhZMWxqZ29Fdmls?=
 =?utf-8?B?QlBJcFptQi8yZXcra2puUThUd0MzVW5qOE14V0M0eGd1eUpCZ216YmNWbGtO?=
 =?utf-8?B?SndWalBseEk0NW4zL3JoRnBxbGV5RWpnM2FBckIxdit0Q21HQnViNmx2dmhE?=
 =?utf-8?B?WW05WDA5cVVRMVN1OENvdEMySFNBdHNiakdycXVwTDArWVRNS1RobGJ6WlFM?=
 =?utf-8?B?b2l3Q3QrdlJMdGVCdEJ3UTNUaEhBNllsaUlTZzgxa1VQNFZoOXhQbU1DZlVX?=
 =?utf-8?B?TEV3OVhmOTdjM3ZFV3VwdzJjTGxTQkQvekhEdDVPR3JRbXpnTmZZSFhHWlpt?=
 =?utf-8?B?TFYzTENTR3A0RTBNNG5GYTAxaDQvTWczWnNtV2FENXppdjdFbDJLbVNjYTFm?=
 =?utf-8?B?V2FpNzBiNUE2ZkZUZU84ZGNQU3d5M1N4VkRadFZIWE5SMTEwVjJxa1AwT2JC?=
 =?utf-8?B?b0x5eE1Zb2l4TzdQZWpubWkrbXE0aFkyTThDdlB5ZmxLMzVvaGFFTzYwRCsz?=
 =?utf-8?B?SytIb0N5VytDWTNhem1udlJMdDNMZ1JkZGZTMWlMeXI0U3h6d2VaZHRGTWtM?=
 =?utf-8?B?NmxWQjNUZC8vRVkvNlE1ekUzc0FvK1FDcTlWeXFwUktFRnVUbTVMYWViUEMv?=
 =?utf-8?B?bFdialZhSW9ibE1lbUVKeWg1ME1iU2dEQzRMQnlOL0d3aEZOY2NZWUZpdHl5?=
 =?utf-8?B?cytHeStoYjJIdGYyNHk3ZUNtbFY2RWQ4L09hZ1R1ZXlwSHdtdVNNRzYxSHNV?=
 =?utf-8?B?RDRKK01GSDByY0pBSjF1M3hzU015UXBOUVkzUXBoTi9Jbm9PajdsajY0dEta?=
 =?utf-8?B?QWpPbFgwRjJ1WVhYSEpuNTU5VXhCdjlHTy9FQW1sTUtNQzAyUlVRakdGeW9R?=
 =?utf-8?B?d1JRNy9iaTV2Q0xJWWNTVk0vWC9MWnRxMlAyWWpDS0ZDNDB4b3NzQ1V0MTh2?=
 =?utf-8?B?OG9xU0xaTXNiczU3cVJ6cGVDWUh2OTBuck42ZWl3SjE1M3c4OG5veFdzWS9S?=
 =?utf-8?B?b1prK2NQZ1lsWnRXejREeFk4LzhNWHViL3BoNmk3MEQ4Nnd6a2xqck8vZzNj?=
 =?utf-8?B?bjU4MUR0aXBvMUpKVWtaYjBZVjdBaHVEZ05oMXo2aEtTSW5uaU5RU0JhTjh4?=
 =?utf-8?B?bWp3LzE1N3g3NzhKTmpRSnA5c0t2OTI0TGF2UmE0cndxemE3SXRQSXR4by8w?=
 =?utf-8?B?Yk9IdjFXM1ZCVWl6YjJodkdYV2lWNWZRdmxtYUYzN3RXYkk3NGxmMk92aElq?=
 =?utf-8?B?eTlkWEVhNVhkcklkcGd4Q201a3ZaSkZ1TW9nVHhvV0FlK0R4Sk5FQlhnd0Qv?=
 =?utf-8?B?d0JobjFPTStZSFd3aFNocUF3OUxmNnQ0NHZMci9iV0lUVk02OGtuTVBLNmlm?=
 =?utf-8?B?a09GRVp2eStLSzhMRWs3T01PWFFncTlRU0NvSDFURHlSYmFtNTdqL1VhQ3F5?=
 =?utf-8?B?bmIvMTdGWDNGMDZwYVpwQk9ERXdRYUQvd1RmTjFuQ2ZwVXQvUDN5cURSTWVv?=
 =?utf-8?B?aFJFaUFob29EN2tDK2hhZnFzc0QwcXV1b2JadkdXSGZHTlpUOWFoWkljcFg3?=
 =?utf-8?B?WmVVZHpjRlBvWVJsSnkrZGNCait2cHdDbFRlVGtMQzVsY2JzRkk5YlBQbXlo?=
 =?utf-8?B?Ti95Wi9xOU1vSVJGVWRKdWwwRldldmh5VGVNei9TUVIzeVBZY0pFN2kyNnVT?=
 =?utf-8?B?Qm9OdzN3dUVnSyszNTZ5RTFScFNJeHVjKzdXVVZvaGFlK3QrYUtYanlPdld1?=
 =?utf-8?B?dElHa3BNQlJ3NHUveHJmN3NqcS9BbEQraDNEcDRSQ3NJSnF1bXArbE51ekF4?=
 =?utf-8?B?STlYYWR4RnZjYVhsQUg1d1UzdzZrR2hidE5vM1RtTDh4TjZoMHJKTGtFbmxE?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c62fa458-fc31-4aa5-0806-08de1cb540c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:49:53.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOs1/IN7xvv98cwKo9D+uLKKfkJ6dwf7+KklFVBsX7O5OFgWSZKQot3TWS6j4FTuG+5AZPoKc/2VOjCFauRgqCobvX133WZGiQ8nL2CeSJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
[..]
> Can we set tdi in the constructor? I use it later as part of a bind()
> callback. I=E2=80=99d prefer not to pass tdi as an argument to those func=
tions,
> since functions like do_dev_communicate() are reused in other contexts
> where tdi isn't needed.

I think if you need this it would be ok to set tsm->tdi in your driver.
It is not the greatest fit for pci_tsm_tdi_constructor() because that
function really does not know if the tdi is fully formed and ready to
publish via tsm->tdi. It only knows that the common fields have been
initialized. See below...

[..]
> modified   drivers/pci/tsm.c
> @@ -391,8 +391,6 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kv=
m, u32 tdi_id)
>  	if (IS_ERR(tdi))
>  		return PTR_ERR(tdi);
> =20
> -	pdev->tsm->tdi =3D tdi;
> -

I think it is ok to keep this even if the TSM driver already did it.

>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_tsm_bind);
> @@ -998,6 +996,7 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *p=
dev)
>  void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
>  			     struct kvm *kvm, u32 tdi_id)
>  {
> +	pdev->tsm->tdi =3D tdi;
>  	tdi->pdev =3D pdev;
>  	tdi->kvm =3D kvm;
>  	tdi->tdi_id =3D tdi_id;

This ordering potentially causes something that walks tdi->pdev to fail,
and who knows if the TSM driver calls pci_tsm_tdi_constructor() before
or after TSM driver specific init. It all around feels like the TSM
driver is responsible for making the "early publish" decision, not this
constructor.=

