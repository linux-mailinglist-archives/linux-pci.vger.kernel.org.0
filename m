Return-Path: <linux-pci+bounces-35569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF3BB4634E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 21:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AE77BC924
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EBB26F28F;
	Fri,  5 Sep 2025 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsQNSAwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710222836C
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099644; cv=fail; b=nbN8CpBTK+dXLZ01SaDgBpsiNiF5DcebHicckZKJtx2MR8hUECM/JA/cC4nA5rok1/hxTrWXjmTgcgBajkEtbDxIirY4jqzbddUQhOl49uvevDKl+crYqBtWVgxz+H1BxA4tf4WcgiEU/yLns5l1ZCWgaibF9lFeG2qjLI2xNNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099644; c=relaxed/simple;
	bh=96ckUKq6lhDxcTSi1AUp4kc16dlpxwWJ0zGEP6Pr3ls=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=FRruumzsmG2nz/TGYM19NXglGvsq4iGpajhN0uGdoz1Bjm9Ve5vNoaPHiIHZft0R9JijdGXK7OGyEMSJTFrF31U2sVI9ub/NKSUrreTpJ3reZ2mbSygjRCWfDxsCwCLjaqh5DWC+PEMypSikxNOcidIxw4Swt57Ns/uhT9s8Fzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsQNSAwR; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757099644; x=1788635644;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=96ckUKq6lhDxcTSi1AUp4kc16dlpxwWJ0zGEP6Pr3ls=;
  b=VsQNSAwReVSin3Q7B+mVKKflTBu+sQPOFu+tA9gW4oLNHOKKORAf5Hcb
   4mUKNbxjFivsHJK8ZzsBuwX2NeRg/04qWyWa/4he6ZtH91fE3YJ2pqwnH
   OQhzfQDzfYmA5fNfkRAxepNp6R+EzI71+R5v+X93cG0bTGgiO4CuLJB3d
   ntGdtbGxFp6cKIbrBgKMNdJHyzweFghZSdXvLJcbUCtBFE+yAqHjLgk7U
   MSo0ExFBiIOZrsn0PIM+4OBh/r8lBLUHND7UvR48zx0b91AvJauYRwq/s
   fAUayU5fM3t9w4jkfPj6n/DuMAZZFrqrDfGwvWwLWy9ip1xxs3LY+MXNx
   Q==;
X-CSE-ConnectionGUID: ouRn6yWuQs2f5ImbdWxbvg==
X-CSE-MsgGUID: eBiJJqX+RQWSiMqkJKvTqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70885644"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="70885644"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 12:14:03 -0700
X-CSE-ConnectionGUID: 12kGefTFRtGIRq9D8sOyNA==
X-CSE-MsgGUID: Vt7HuWMJRgO9T0mposOGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="195897024"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 12:14:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 12:14:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 12:14:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.74)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 12:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsBtgqttuVKXDzstG1CxzLh6IL58EBGFWhIEtOfymebWYdDEQuMR2txcXcRj13DMjoYZYvFhqOFcxF2BKS8w2Oi0eqkfhgOUvkkxt06evcP5Yx9sX76iM/cAeAldmMwiQJhCaP4yRgDBAR25E4i/XQfznZ5Stb45wW55yjwRE6Sa59+YYiCL5bP6gKZb/6Zo1khcyVYLV21VX4gkBdLmjv/ifRP8BbywK6taNcFeetOMpydR6CNF6Eo4dkGnDNlP69Dzve2nYF1O9kjPtyA3VQYOXEzm1IhLL4U+imZHz0CpFCUV0rjL90Me/KNpCRZKs+V4jxFaRloWRFLcIUYn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96ckUKq6lhDxcTSi1AUp4kc16dlpxwWJ0zGEP6Pr3ls=;
 b=PcZorAuogkMxTg5djB4mo1n2G5R5ZeI9oSJuWZ08PZqey93CUq3YUEL95pMgtGZphT6w5yp0WgQRvrYq/ta0hdYKwTaPVqqsD2ov3FxTy7oJlZPC2Zn71uZ9mxrecroa0GH/Zv3bBpVaZmnre5m8MytlLqyUNgVJu0Zg43wS0El1LGN3VmrnJMBMcz+cDF6tCjscdV+/GGLsKVtm4alZHVMzQmZilzdy8qCIEEL7CXBF8+AcHPv4ae4cgJStTps6im0E5jTYIGyroYy4zLHBZI9gGOeXNOI4F9Q8b9X7Ph5gXILQD7uKpKTeMjXRucK/i+E+OK7ovSGcKsxO4LpI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Fri, 5 Sep 2025 19:13:52 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 19:13:52 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Sep 2025 12:13:49 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aik@amd.com>, <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>
Message-ID: <68bb366d8f298_75db10096@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5a4itk3n9f.fsf@kernel.org>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <yq5a4itk3n9f.fsf@kernel.org>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DM4PR11MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b9f0a8-fdd5-40f2-5cba-08ddecb059b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0wvd0xTWWcxUU80cmMrOVJ1QVQ2bzRaNC9WZFQ4cml1ZDNoZExQb1Jjemts?=
 =?utf-8?B?RlJlUTdZYmNudnMwTzZIMXpxMVVtaW5CbjZ6L0o0YWZGSXozQmUya1V0ajMz?=
 =?utf-8?B?ZkxBQ2oyVnJZQVc3Yk1zTytpMEpvTHpmMDcxZlRaUjZSdy9pZkdoVHdjWFov?=
 =?utf-8?B?QlRDZUlqZ2U1bi9BeVNoMTlBOEgwYlQwSDRYTzFtRDF4ZGV1SHNOMlFMMWtI?=
 =?utf-8?B?TjJGbVVLR0UxdGNhVDJYUEJZZWJRL0Y0WEdxSi9yYzMzb3Y0cC92RDhtWkZF?=
 =?utf-8?B?YjR2VlZXSjZpVWthVWFwL1gybkFUTEQ2ai9NWmp4UkFpeVlZblVJekNaTGsx?=
 =?utf-8?B?Z2ZXemc5SzdqcWp2Q1Zub0F6VExHbkxwbTdycks0Y1B6bmp4NmhVcEovUjdR?=
 =?utf-8?B?U2pGclpielI4bTFtODVObk1tUnhhNDQ2cC9oa1l0ZkVRS0RFU3Q4cjVEVmhm?=
 =?utf-8?B?RmVaWGpMT2xYbTNmWXZWNlhRWkNkS0p0NTFrWnIra0VIM0lnWk1JNTJ6cElH?=
 =?utf-8?B?NExhdWNHeHZLa2xmNXhtY1JxRlkwdFJtdStqOWU2aXNuU3hmMVVhQk5KMjVz?=
 =?utf-8?B?NnRJS1hvWkgxekVoQ1dSQUVQVW80cEEwRk9Bd1o5UHBnTzZ1eCtGMDZNNnFP?=
 =?utf-8?B?SG5ISENIc3NoNENnNTlMb3RMTmtKdkJ2dE5YMUtoOFRsWFR2SWRaeGZad3Yx?=
 =?utf-8?B?SmJVVTVaQVBYbFdFcFg4eUdidHMwOUI0a2l5MlVURlFPRWF3WjJOUWl4ZjNi?=
 =?utf-8?B?K09oMXJxYzd5SUZIcnllcEZMZUZTUzZXakhrWnlHVmF3dXlsOHB1bXp6bmU5?=
 =?utf-8?B?eGdoZm8wNXg5Q05EZjhnMXdEMkNpYlpsUXhvOFZGdkNMRmJiWmt3QVBrRGg3?=
 =?utf-8?B?UU54bW14M1BuQkdpSVIwYTQzYlRmSTd6eW1FMEpYWmdVMGlTeFBaNVZtZ0VB?=
 =?utf-8?B?Y0paSnhiTlZhMk9VVWdTQ2hsSGxxS2svZy9nS1BsdzY5VlFPbDk3K1NsTFdr?=
 =?utf-8?B?SXpFcFhjS3pRQUZGTE5CeHYyV2s3QlZQZWdxU0ZBUnlSVG9adm9pZGY0a0pn?=
 =?utf-8?B?UWZpVzZ5Y0pwd3lUb2hNcTBUZnM4eXBnVENMWi9PdmZYR2pHRDF2UkNYWHFW?=
 =?utf-8?B?Z0poM0RRUzBhRUZqWUVFYnpkcTUxcHJnWUp5dVMzcVQ5aVlXMHk5eTh3TGls?=
 =?utf-8?B?a05FekRORjFkQVZOUXRBeXVIQnlKQWZ3ZU40cEswK0VFZWNiekhyNmNGMVFS?=
 =?utf-8?B?clcxS0hYWm1pVlJmRlRJc0RyODV0TmlUVUhvSTVVUThjNWtNeU5ydVJNRkVn?=
 =?utf-8?B?cGxQVmxHME83RHdHcTdjc3pheTUreURaWkU4VHBTNG1rVDZESzl5NUx4ZlI3?=
 =?utf-8?B?VjBNSjRHNU44U0tjd3ZCWjVneHlWUCt5UzMvekJKSU01L1QzblZhR3Rqa0Rr?=
 =?utf-8?B?Ui9CQkRhd0NkTW5Kb2RjNllTbklRRGczTW9Kb3gzRWgzbzJlZUNIUWV5OEh5?=
 =?utf-8?B?MGJlZ2hOTnpLeWFDVVVjQmRrM3hMT1dmTDlMOElqSFhGWEw1ZElROGZUMTJ6?=
 =?utf-8?B?dUorV2tkd2lET090aHhtWnFLdExEa2ZhaHdDbm83WU5MbkdOK0ZqcmdlNE1n?=
 =?utf-8?B?cWxwaVJ4T2hDZG5iaG5ZaytybUhIMzloUUZ0VUxBaGtGUWQ1UjZVY2ZHWi9Z?=
 =?utf-8?B?WWd3NWtwbHdsMWZlOTdoMHYxVFNGMVhTcUpRTU92WFp5ajZLK1ZBQUpsaEU5?=
 =?utf-8?B?SlZseGJNNlJPOWlWcFdTMkg2SkdwRHZHMmZLS0ZhTHU4djFDVGQ3UVRDZldI?=
 =?utf-8?B?cHdCbEt2UjBobit0UEU0NWREWXNlRW04UFpiNGJ3SXhNZjVRTm5MNUNsQjhw?=
 =?utf-8?B?ZlozRUlmNEdyV3dMVEUvczRZb3k1WXVYUXV4V3p1akNrYkpjZUh3RG5CUUc4?=
 =?utf-8?Q?P9mdQyZS6As=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDR6ZllJN0ZxMTlaUDliczV0Y0Q4QnJuT1VLeG0vcXF1UTZTMitoeUZybTlH?=
 =?utf-8?B?Z2lsYXcrWHZMK3lrazZnT2VQeVlyMUYvMEhFdS9jUlFOUUJaZzlIaWE1YXV0?=
 =?utf-8?B?aUxyc0VlVFZ2SWJxMk1KVnhLSGZQZkFLZW9rdFJIalJhdmltaWhvTkpBRHov?=
 =?utf-8?B?bXA0VGUxclFHSm1TT0F1NU5SOEZob0hFLzA5SnB2dllWMWNKSjhFcWU3Q2N6?=
 =?utf-8?B?VTdXYVpKcWpDaTNzRmxYd0ZXRkdIMXRreXlPdTlpZUZYUU5ScElXM2c0MFY1?=
 =?utf-8?B?MmdjUjRrOUs4SUtVbm9keFhwKzN0a3BwbE5WTnFGdDhoWWo4dkhZUDg2c2RV?=
 =?utf-8?B?bUJBTExuT2NUZ0g4NGp0MTNLZjNBYzZXaS9FYnIvRE10YjczQTYrZDJDQnNJ?=
 =?utf-8?B?YVlyUnBMNGZjU2tFRVQ5bEI1NXRHa1FOdUYvNkxyaDFrTGczS29TMDdBSkxl?=
 =?utf-8?B?VnR6Ty9Hem9Bekl5S0VaTit2aktxVGhIakpmdHBrRU1xZ3gxVVp0ZjdZQjR4?=
 =?utf-8?B?V3hNWTdleG9uOVMrMVRPMnhRYWNaUzFKa2NXQ0RtVFIwbHFGRmpla1NpRmNT?=
 =?utf-8?B?QVA0bzJ2aGJmZkd5L3hGRFk5RStacVlTRmlhRnQyM0EzNmx6dUFLRGV4RkxM?=
 =?utf-8?B?eDZXdExOWVVwTnViK3JGS0JWOHplSkNaTTRDQnZTUHRuSXpMUWdEYkgwMTFl?=
 =?utf-8?B?dUgvbHpjRWVMTWtlSHNLai92NVN3OGVOMFZsU21PdGlXRDdQZkdUcU9OZHlK?=
 =?utf-8?B?VEJ0UzRqUWVPUEJUdWR6M2JrZWMzayt6OE82N2k0MHNrTkZmK1ZMNFc1Rmc5?=
 =?utf-8?B?SFBidjdDbkNWZWdlUlpaNWoyS2Q0Wlo5QVdtTWxyNDJ0TmdscXhtSzhLRzQ2?=
 =?utf-8?B?QjdHdHZ5a2pFRm9IcXU0U3M1MU9rN3U2bzNocGdqalFDb3ZRby82TUN5QXFO?=
 =?utf-8?B?TGRGRGdzS0tLeXNUd3pVYUY4WHBoSnVtQ1JnSXZFV3N0ci9qVlRJUytOcUN3?=
 =?utf-8?B?R25kOVFKTWdWRkp1aEJIcy91SUVtcVFMaTFYZEU4THJzejAza2dEUlp1TENM?=
 =?utf-8?B?RFI4c3dVekFZYm5mUlEyOC80NFNSU1IvQVUvcWR2U2tBaG9pSEVmV3NucmVq?=
 =?utf-8?B?UXJIbUEwcXJHdFpXcjBCNyttdnpKS3NpZHFJZU9xYlRqNUxwY01sekJ0Ymtq?=
 =?utf-8?B?WEx5cjJQVURPN3RLVmZNM2dqWEhQRnFRTExNWWVoZGpycHhRVGxxR2ZPTnI4?=
 =?utf-8?B?aFN0WVp0eGlUdzR2NTlMemxIU3FtZ2NBZzM4YlFpQ0h0OUNOTFRkL2IzWm15?=
 =?utf-8?B?SW96Y2diZ1k4NzB0SU5BVE1NV1kzdVBDem8yUDF6VkVVVEJrVGZPbktXSGdP?=
 =?utf-8?B?ek55QWhiSnpmUC9MOSt2b1A2R1pZUStPbHozcUNwcU1oczVIN0Zyeno2dGN2?=
 =?utf-8?B?YS9EMUFFdHRsZERLRnBwK0ZORG1PNzZtaEZNQWNhZnBpeGZQL2xMQXF4VXVx?=
 =?utf-8?B?NVBraGNWcWJsZnRsblNBRnZrdzdhVnFkZW5YOGZnd25kQmpLRFF4eUEyZkRm?=
 =?utf-8?B?UWFxNDE3MHB0YXFUZVJXT2I2S3ZNaXRvRHBjV3h5LzAxZmNlcXJETno0UUsv?=
 =?utf-8?B?Q1djSjZqbGdieTRGRmpGL3ZXTVVzbS9nT09rSlNwaWpBZlpCNWl2dlJ0VlVL?=
 =?utf-8?B?T1hsYTVUWlc3TkkxRGdZdnFQYm92MzQzRUd3UURHMlZ4RkpiZ2JBYlU3bmVD?=
 =?utf-8?B?a2ZteWhIOVMzRzVldkkvV2ovcXY5bWJUM0gyUlFOaVBqNTdtc2ROZmdHZVQ3?=
 =?utf-8?B?UklhYXFRS0F0QS9TV2g4V2JRT0hUZDd5N0RkeXNqbUxvMklJODZSdkxhWm5L?=
 =?utf-8?B?alR5SU9UMTJnenZiZkRBOVlUY2ZZOXN6c2pVNHZMQm1pNTZXOUhQQzlmMlVB?=
 =?utf-8?B?VGZ2cVRBWWgzbGNaMG9aekxIUUhSSURFRHdNVFFINzhJK25FRWMweEdkMlVN?=
 =?utf-8?B?WGVPUEZva3dpZG4xeGhZaFg2Zk01TlY2ZTd6Slg3WER3K1hBOWs3OXE5aUhB?=
 =?utf-8?B?U3dkYXZUcTgzYStWdG53eTVoVE9CeUU1c3ZPZlNPVkhjd21mQzBmeHR1Q2cz?=
 =?utf-8?B?QjN5ckl2b0c0aWFIUXpXVzYvRGRzR1NxY2o3a0FIczBOcXBneWRaVnVyczdR?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b9f0a8-fdd5-40f2-5cba-08ddecb059b7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 19:13:52.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiF1hMQdKbDXxQZrXQ5rG6KLxXd+LKsIC9x56GAQtlaAxUY6XGxLXioNRcWNTh+RJTpgDyk8wz/eUi3caXon9JOTGBRVksC3valrUkV3wwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
[..]
> you dropped pci_tsm_doe_transfer from an earlier version of this patch
> in this series. Any reason for that?

Alexey pointed out that it had no users, but on second look the
to_pci_tsm_pf0() helper is not exported and it did offer some
type-safety. I will add it back for v6.

Going forward I will be less quick to make regressive changes especially
with evidence like this that users are in-flight.

