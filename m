Return-Path: <linux-pci+bounces-28923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B34AACCFF2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 00:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF523A2D43
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C7922331C;
	Tue,  3 Jun 2025 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFAVZrLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140244B5AE
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990443; cv=fail; b=LaLg9WInq5DdFEyOHXPQOCF4L+UbOHDky3hUJ47VNORjoUmWDlMIerh5u/xAabdz0SKfAW/OXL8qnV1YDlBNyUf58jZdaWhLiN8Q5t2j4n0mr9TxniIQYSJDDqi9Q21kwDP2/8h8MH/dDpkTUiw5BIVhCRqSdxhTa0orsBTnRPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990443; c=relaxed/simple;
	bh=ha7CDA3cUhn/9XR7Jjmjaj8+hRlhzbMUwgKiCXBLZ/c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TqEZ1rI5mk+pYA4xU+4hqT7QRD0bpoCrW23scTq/ddsYEkZFvHOJCn9+pu6K+y1TG0aXlGRPNDaem5VM5+dC68mZASBSOIsQPJhvcxM5wn0cLasARL+tC2ri3eMlZ7rr/ZYpu/akHObhk18G6c8Lf6RYA069FtqXMlugO7Xi6tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFAVZrLE; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748990442; x=1780526442;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ha7CDA3cUhn/9XR7Jjmjaj8+hRlhzbMUwgKiCXBLZ/c=;
  b=aFAVZrLEofU/xGZ4Ne0Ddrq122wgg27XTGKyhwOYN+h3pBlUhazx3L6g
   jDcmnAtXBWML6DaMea9ciQRFG/CLi6s73jr6eN5XykihHIAtlNixYNL8q
   Wh4crM59dJMVVMKIogeLHaYtT1bXPqAw8Z1zMlAV8H5pXHE9bdMihxA4s
   wCuwHDNHIYFVohSEyj8osOeyHj80KX+7SCwa92gnMmGL2769OyixQ+yk2
   6V7WjvEuu4qiqorKDG6c2+3c8TLYiKbq5msIUVbHCtmzn2RHyfrGv+D3m
   XGAdOcU1rzyMMzexg+0w9XdwxT6Kf+S/+xdYx3hHrvgMA/KoG2sJSmIZn
   w==;
X-CSE-ConnectionGUID: gp4CB1YSSue+JiW1kBIhzQ==
X-CSE-MsgGUID: xiDHPo1hTS66XfqP+Zj2Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="53679489"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="53679489"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:40:41 -0700
X-CSE-ConnectionGUID: svJ8MFvOQ1Si2Jen1BKojQ==
X-CSE-MsgGUID: u17Oj0wfR0mfvDFH8hk5+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="175933884"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:40:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 15:40:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 15:40:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.54)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 15:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHFg2mgftoKfHrBh7l8pe4w6vjJdPQmGd8aSGjnLtu785VsTJLizct9hcRZW/cRxKOM7jP7Mvm/6PVfLJYdMdrHGIkqQOGXeFfz2AfPp+M7GCRMw+7kDoVHBMOet53Y7goXQqNLbM3vm8KT/QwBbhnLwxM6wNgGeTqZ4PI3/02w4xbeQpwBMz767qo3CnrgqFotlFfh3w/R2Txc6vyFc9m5NmLqLVN32Py4+6OPXBgmoG3d78aW0dMtszgFnF9P1TNoNwr5ZdvprDsWwsrFRCItY+MY2ifW9UzgrhHdBgTiROzEaOu8nbrsZ4KJ8z3gjWAB5EVKgJUz8WDE3wM6mlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2INm/aGcSE0kms5miYsedg4S3dZTrTHwx2sZi0qC+LQ=;
 b=cers9YXl8RZT/V0UOKFHwV6XfQe2gGlJfPiGDAKs0XmVFuhDBbKqnnw+NXecpsw7RhSKcjiCNcOMNSLfUhuTEPcwYYikGK9XDTlBxHZCMACDgjHV8I6qjLck3JL+C0OtdnBvy7wsB49QqTl/91r4F14zAGEjPJzxY9iq7NlznH0QxoJfGkwsia2PwTI/WZwzscPO2c+N+0PzJn8Wk6lbnCrnvekSLSSrwG7kc5JseGAGhEdwkeTnP7dybyEhLF1o7nGCytRIfTSmqqa7Vze0hmsBBRqBw8mychZY/oXrJK8HMroK5CRs8iu9Pt7qDp32XdzfZT3VsH42ODFxIbmwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 22:40:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 22:40:38 +0000
Date: Tue, 3 Jun 2025 15:40:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <jgg@nvidia.com>,
	<zhiw@nvidia.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <683f79e3efe9c_1626e10040@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: baaf55c5-a766-4367-cd7d-08dda2efa98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?exjiBjauiz6sjwI8ZGy1netWMuvkwxESlJF0YHwIRzfYeJE7Koz2ZpHjkVIm?=
 =?us-ascii?Q?pYxUCuWGsvZPfFmZxDwFS+pg0q1D+tg9KfbYp8qegk2B/MLpkbuP2O0aVRUb?=
 =?us-ascii?Q?4nkIbBpGwIJOwxLrf/2rsboCU73kGFUTOg5U5lquSrfyTErVnjphKn/GyJ/u?=
 =?us-ascii?Q?bcjFUFhDr3DxM8fVXdiXPAJjnHMUQaQWKbcUX8COlRXF7CR5FXRJJ9wg0FXK?=
 =?us-ascii?Q?WXe14CGuDAcCs00hHwB4ix7KrU/WRNlCpyS/YAPwfBlLRn5e5NxVIsdF47bD?=
 =?us-ascii?Q?4tfrZZNN5taXozGB2eruowYLFBrWETL+y/NxBFm3vFNKZiNsOamcxfPmOC4X?=
 =?us-ascii?Q?yJ1mrDfTvbix49HGHWPjmbZa1ijElLpkbHrCR96s1SzlKkvC2hrHFiL9DYN0?=
 =?us-ascii?Q?lquSbvW9qU1+43VgxDbGCaxUw8bJsN4zlACtI07/VJiC1roHQhHfTufQWVXD?=
 =?us-ascii?Q?Bu/kQiHb76zqNGut8I/PH3Ou8FoRGroTM+d37s8WXWGVy3vyX4HAyUT4KdFY?=
 =?us-ascii?Q?XhT7xqkT0+nmeUpLk+SzwMeLu6Fa2be01qjU/WMmVh0cA8ELdL+Gm314orQN?=
 =?us-ascii?Q?NbgAyyIORytzcmIxFyz3/iQ82oXF18f++a7NJSCHD6/HEr/jcX5hPG9dkc52?=
 =?us-ascii?Q?yub2JIXtc16I+FfnaRlSsKNpbdr3SnToDDLMxeY7bl94OYyQpXVbJHVDH6dv?=
 =?us-ascii?Q?fU+A9eU2pfEnhg8BO7zDFsr16m0GoIxO0trdCEmqXYGg8qrBJ/kOzyTSycGN?=
 =?us-ascii?Q?34IZx5XRJTbxxLouYkfvNtYxkzLK9q3MikoDYRqNYvE8IQA240GCyjL/IXpi?=
 =?us-ascii?Q?DHsWeyTZzyVMWJJiQGrFUHBhZQ99di/WkEhtC792OvxJSLZGFnej7ME6nPay?=
 =?us-ascii?Q?FBunSfNP5VzPTGaIRDVy48dK4RHRBL/68YXaQpqtli3P60rXFT5KTRVutr8F?=
 =?us-ascii?Q?vYYmzaJLjGZisGJRl42z880y8iA6Tgy71M5WzQyzu59Gyf2Y08K/nTK5X2fW?=
 =?us-ascii?Q?BELKigGvXbJZyJKOpcxXeTnIREEt/3tcZxFHBc58F6aNMNJuVipXmzNZ2DYV?=
 =?us-ascii?Q?HptwL35cu8jVSRPJ8cguaxy+XVo16P6QwmDNBPjlZ0B7FjuL6jT6yY4MuLlz?=
 =?us-ascii?Q?UeWkj+aeksmQbHHkRU1CtNdrR4BxNrS31h+ZTg3q2nimWnwSRFH6bzg8sMgX?=
 =?us-ascii?Q?aAd1KH/EkaLwNKpPXGy6F1bDMAUgNc2mYGrAp523yW9duOsiI6xZXCLcxbZM?=
 =?us-ascii?Q?tWPxAAfbLPPmw9f/oNsToz/F/9a7/ecoYv1LfCRpZVfBEO86ueUGSAE2NcGj?=
 =?us-ascii?Q?o0l/oR42Ymi2bbqD7QhcK+1Xpei8k9WeUdS87YLv62On5bsEfxKXEKTGCX4y?=
 =?us-ascii?Q?0H+2OOItRY7MngSu0yCkkCAQzXS+9plbC8O7YSoWwweLAxdgveLHXvUkONV2?=
 =?us-ascii?Q?rrkCE2/XoZE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDygfIQsOd8tpL4SFjr8D5QcqVThOxEPFkRpVstVtwd0Qh3xPAtEMpefu5PQ?=
 =?us-ascii?Q?0RubvNAgSBAZpwKuj5778yvOfWiiJHNfbRrQGZCMObYzsYfrph3T2eqz0Yq4?=
 =?us-ascii?Q?3LUZN/WSK21rYaxP2OsCKIXnFazBnmjLUo+poMHzm06fnkBZdYGlP6z9bqNV?=
 =?us-ascii?Q?aCv14rX+oKZRSIzn3FhD+Ex3xgZIMu97krLMT6s/38nywtMxrKiq7Pu/P0yJ?=
 =?us-ascii?Q?C/vDWy3upz/+CIOzCjklLkCFoTEE7OBHm6kUDSxbkL1nn1Ia+FS8GAh0dmjF?=
 =?us-ascii?Q?MKzP4NhDpmHFYtG0EtWKTbf7Vk6IIX+AoBTufRNUOYkUKe74wmFSsjoXBssb?=
 =?us-ascii?Q?88onNSF+jJfJW1aeDHONGLwuFgyNXLQGo0KyO1XTQ0TbtEj79X77BPfRezep?=
 =?us-ascii?Q?04rUJwLAHDdWY0nkkRI7Qz2gguX8CH/HqITwd2SGIaR7+XPVPTdEbQH6/HVt?=
 =?us-ascii?Q?NuZnZV/oyEfxs0RD9wKc8SUEhUtgZdCLh/CBTJtTwcZXfI5g7n9L3LNNtmdV?=
 =?us-ascii?Q?r6eet5TUClDcaY/B0hdhIh79niPiDbAxIs4ZfufCDU0Z/Gy5e3JMnEj47JRI?=
 =?us-ascii?Q?Z3BYtuprBkL+8811toRz8a2ah5ZNp+cb3TT+iGQc65BkYiCIDDRN1nk4Ewlt?=
 =?us-ascii?Q?juYIJym4vzJ4G5Km6lYV1zUVx0qvt+kcuHybhG1FKYlEc7Mofkc09bZF+KTS?=
 =?us-ascii?Q?MTYYXgdNtdYN6aRjMUGjP6OXsPENVMKUeWXyqpOxWicBQCxpzbdI4Fvdcn0r?=
 =?us-ascii?Q?x3iu9o1vRzy0tfS7PgvYZyvybe63kFgxa+wvxthqZ/HngcZLXQAbYBcx5hKP?=
 =?us-ascii?Q?x994ZMKU6pfdpHHCBda/qoKN8r27vO1fHaSIc/v1SxiojnMiCzLYKV//c9wO?=
 =?us-ascii?Q?aKdZvEpXTXTN9akdjKCN7nv53Uj1lR50QD+dr/5JRU0cROqWE6s4VX22sV8d?=
 =?us-ascii?Q?JffHUS8S87DzSFUOdF6feWMOPq98W/GJPZFF4WLlDywJLLBJD9gBJHtd1Ods?=
 =?us-ascii?Q?7j33bB+6LCyQs7oXUx9TB6J6yygAtgS4mdqyb7FoR5SPEm2+zgHuEX3kMGCK?=
 =?us-ascii?Q?RC+DxbttuWAaiwagIH/58YL6ySzKJBPYbeRrnO5iXuUPWA4IUOBN1nd3LKLP?=
 =?us-ascii?Q?KDnaZKyLcYXWIB90SREcUpZFyW3OK3E848X5Ldl1K14KO7nNEJOcAIPpAGBF?=
 =?us-ascii?Q?jN/Wun7psPlifL/4JlGRP3SCdLkZqcjOkyf+CpwMlf1SrW9xd928U6N6lRb0?=
 =?us-ascii?Q?3E4+GylAQZIHYvwpGgv8zLnSyDxvPPMtJ8woor6BUKreZFCiV/Gd5cTst0gf?=
 =?us-ascii?Q?TnpXvghtmhTgW0TXyKlfPIhw8zkI9QMZswwzMUbXMJ1puYHgMuHdFCCAvMRB?=
 =?us-ascii?Q?GaHNTvpI54AhPexb6wH5RdxeYIuGHzoHEYz34ABxmINDkL27YOsJqPoxy5sV?=
 =?us-ascii?Q?j6mSxmQlriDGyXfd/mRFIk3t9HpieB1+kXKNKYnZYONZ9mPZPT97j+aMu7l0?=
 =?us-ascii?Q?F9q1YB9WMK9XwGr1ZYJWDSjqpFqKwy5QZlGI0PpSakuwvcNF1O4wjJQI6COx?=
 =?us-ascii?Q?Zbbr3mmIm4ZQ+tPVXaZXMF4FoH89NpXCzZMoupw6wsolfzWVmiYU0sl4Els1?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baaf55c5-a766-4367-cd7d-08dda2efa98f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:40:38.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQhe8b6aesmPyB2EisGIR0xETcuNRof3YOmZjBlOcosQpnjE8CIC59xZegix0WvcgZ40s1C6u895hfudXh82oG/xA9A5RBKMSWA8g9BPVTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
> >> Stage 2 patchset. I need to rebase this series, adopt suggestions from
> >> Jason, and make TDX Connect work to verify, so need more time...
> >>
> > 
> > Since the bind/unbind operations are PCI-specific callbacks, and iommufd
> 
> Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,

Certainly the iommufd call signature will be in terms of iommufd_device,
but that call ultimately needs to be bus aware, because "Device
Security" is a bus specific protocol.

