Return-Path: <linux-pci+bounces-32475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4BB098F5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 02:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024C61AA4DD8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D802AEEDE;
	Fri, 18 Jul 2025 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlejpSmR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666E2E36EF;
	Fri, 18 Jul 2025 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752798428; cv=fail; b=pOGIrqin+9moTOFaokzLGgz+PQ7u5RAwvd80IuyNNLQ8mbP3pddV849N7Spnh7yMVj5VcO/TNUqjjTQSwdEXl2U2tr5qL/m5r1BtatH+9weR+Ek1dlL9ADRZgikfjIwfIe4UJcps+9ReOFdWOcEcr7Sisq7fiUdKOAfk7qVRxLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752798428; c=relaxed/simple;
	bh=b4gu7ga4PoSBf9sxXcOg2TDNi843Pe31NKkKj2dntGA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=uDd/5MOMrd/TjQS+aQ0eA1//k6q3Q9YFdpkus9KZcT3eZAZ0dnjZxRXendmjo7EPReAFZibUdHyxaIc4bcF2O32GOvx89805timbxxUZWhgGJ8xsjv8VVAnBYtesjc20UX04IC2AZ8tkT9Ts39RA2ZxEQRTtkC9GHonL2ti3PyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlejpSmR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752798428; x=1784334428;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=b4gu7ga4PoSBf9sxXcOg2TDNi843Pe31NKkKj2dntGA=;
  b=FlejpSmR9rF7OMzJdsBt2wqo/nVMYUhFSUa4Ny5xLJEYfKynOhUP7f7s
   FwMLQozD8JgofcCnE/b37L+QrbXp9BjIfyDmXa9YggDaL0Df2jw6CoF++
   1Me4tKE8FVe0ixLT4MlHvilOeFL211MJq0lLNC3LpSuv6QfBUmDHMShwM
   wAMm1vLPNNnxczt79l9e7Yzkr7axR+aviKEGY4uE+B8hqSey84JqZCXas
   ueqIQgOwnJziex/lXc5ut4RZEOX7ukiR8Qh64WgIQNyDiknKl9+CLhSkb
   O6Keo1mV5MBd1A6SdqTuIbvVt/RPW5vmz1if74zdElhNfIIj7GeXpaVg0
   w==;
X-CSE-ConnectionGUID: IJiy2WExRl+QdC2egApdpQ==
X-CSE-MsgGUID: /O6H0pkaSk2F5Th7w2gsbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55244423"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55244423"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:27:07 -0700
X-CSE-ConnectionGUID: PU/w1C1ORTSKJmP4z0PuyQ==
X-CSE-MsgGUID: ALEIG4iSTziqnybRmgVXNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="158279550"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:27:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 17:26:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 17:26:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 17:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg6+Rg20bQIIuso1SLfC2uydoI3bUx25tR8qGLYZRHXyW3cIpv5sUnHdy5u07jNyMT4oNTOUx+x2OpO8MyHTm0aqsWjSEXY/jPXcv7SYXEhcxsnzfWPGmhz1DnnOGdjsTqmdEs5NT+XQfoH8Gdqfn+enPwYuu3YuZPnQrsbAwet5Dpructf8edqYMq4mFGTAhYWZzKW1lqgs0xcwUqNJZSE+IcI4PaOQyeKvS1ackrVhFZkfvKbTyLttBiAxcYmcsxvdpJZFciH6eqtPZ/6/QHG9BFzhEoYMEb4ge8UOHrn9+kVmvmWuwfcReY1rESi8MCDpWbMbzcp+9XW71+nFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyl1/DXyRYGAEWeuqeMREpGtK/tHl1Y0Dg2lbA965oI=;
 b=sdH4LjdLBwOKJtzrWFtio8kPXvgGRk81H/LkiDcOHbZ6vNBpFYJJcBN7vwx22SpdyVBhNjCNGPjkgeqgg8Rwp9GCbluilvCo51XZkO2qwwIXc6ZcVV2UqqSKGfnKlmRsHU6nw7c9x2kPCz9bdJs2t6/L1erhTe83EO+ZQRpD65d1r43JbkCShBq7ACiZSIeS3Hlq/XMjLI8o3qibaO4QFR6KpQPiG+jw9Yqz6H8MKpdfUr3ZkteAkJwTmUsMYVuKCfpSqf2KIZkwKDD872yRCQ3qyTfevJdbqR28rjeaWPCDcZgfi8PKD8PSyj5Dyt8ghFaxzI6+iKTsNT8iBkUwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 18 Jul
 2025 00:26:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 00:26:14 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 17 Jul 2025 17:26:12 -0700
To: Dan Williams <dan.j.williams@intel.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<linux-kernel@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Dexuan Cui
	<decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Nirmal Patel
	<nirmal.patel@linux.intel.com>, Rob Herring <robh@kernel.org>, "Suzuki K
 Poulose" <suzuki.poulose@arm.com>, Wei Liu <wei.liu@kernel.org>,
	<szymon.durawa@linux.intel.com>
Message-ID: <687994a49a17b_14c356100f9@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250716160835.680486-1-dan.j.williams@intel.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] PCI: Unify domain emulation and misc documentation
 update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 476cbe6c-c7b6-4105-10da-08ddc591b488
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzF4ZWIxRkIya2Ric2UxY3VsN1k5aUJTb0VWV29QZjFkN3V1Nll1b09WSmlD?=
 =?utf-8?B?Znc1dXlmclBYK3J1SFZrYTBOZW1ZemY5aWZscU1wOGZPcDRyTWt0STlMV21Q?=
 =?utf-8?B?YXhZVXdjR2RSdXBzVjVaTlJ4QkpSck9JeVNHdzRUVEVuTDFyandWRVptSm1r?=
 =?utf-8?B?MGFhK0dGRC9XK0MyNzFvS1B6S3Y2OUFxYWpaQ2hmZWh0YjFVT1lJc09ZWnNT?=
 =?utf-8?B?bVVGU1ZzeVcvNWgrMWxxRUJjSnRRVE1yZy8zNjZpWnpSemhQazFwNHp3VTdt?=
 =?utf-8?B?VEZyYjRTWmtXVGI3RURScnB5MXVXU2hCL1pmRUV0cW1mbjlwNnVLcDYwR2R1?=
 =?utf-8?B?V0NpWUIxWlNtSnI5cktpUVZuSEhKcS81clpjMlFreDM3VVpjMFFwYUEvSWsw?=
 =?utf-8?B?aVNlNjNqM0hjMnJwV2pYTXVKUkoxbDdFRGxNQTNlSU56M2ZJYkxrUXNPaEhJ?=
 =?utf-8?B?Y2d3TmtqNEFjTU9pMG4rK0tEMVlLdVJxZ21tYWhrTWFiQ2NRQytEdWFrcS8w?=
 =?utf-8?B?MklvM0Jpa1ZyWkR5NWtpZStWMDBDeXgvRHJRNExMeFQwR3JhNi96Skh3bnph?=
 =?utf-8?B?RW1PQms2cjNoekRFUzZhNGU5VXRlWjBBVXpIRHJKbkdCRDRWM2lWb1N3dTk4?=
 =?utf-8?B?K3FmbVRNN25sMFg0OUQxTzZQRnYzcDltaGl3MUk5R0k2ZVhMaVJaV1FnWWxV?=
 =?utf-8?B?eWNPQ3VrK1huU2FTemtpV3pnemlUc2ZLMVBWWHVsbFpLbExZcU41UjJFVzFt?=
 =?utf-8?B?Umx0TGxrUzUvTDVEaFJPZVNpQWtnWElUOXZxSTlVd2NqWmhTNWtKV0EwMFIx?=
 =?utf-8?B?QkVoUW81Y3FsQ2VFVUgrWGxzMnF6L1BDK1JNQ1oxK01uSnNuQ3RBZWEzSklM?=
 =?utf-8?B?RGdQZjZERW1CWG1TWmxSN2MrTDlEQTZxQnNJMFQyZ1ZIMDM5dFBjQnhEdVpP?=
 =?utf-8?B?UU1PZTd6alNXK2tZYlAxcHF6a1FmRXR6cVlsVmU3WXpVTUM1WU9QWVZuTDJH?=
 =?utf-8?B?VUNOZHFxZWxIZEVsamljNlVWZllCanRBQkFYZ1k3UWRnNXlHWUZkNUZhREtL?=
 =?utf-8?B?aWpnZldFME1HSGZBYi94dFFwdWFqWmUzcVkzZXNHU3o0ZlBGbXdrUytDNWZK?=
 =?utf-8?B?NGdJUGhmdjBwNUtHTEVwMXlvczcrYnIrWm5MU0t5RFhCOG1NMDRCYW1ycENH?=
 =?utf-8?B?RUt0U2dJY3poNVpmUTJDM25xNWYzR2RKWlRDTWxBSWJuOFVNL1ZlTWRoL1h4?=
 =?utf-8?B?aFF2NnJlRDl3VlBtbkgra0h0S2VDVW5sa2w1bmtaLzFDSVZlN3Q0OVkwemNt?=
 =?utf-8?B?L05Pcm02RWVxOGwyVHlWM2tYd3N5RjZlSGlQdlBFYXpnOWNBZCt4eFNvY3N3?=
 =?utf-8?B?UVl5MXlIVHRFMVpXbWN3czduK3FiaDFxd1F2S2grMURKOUVWOXBWT2dsbmdL?=
 =?utf-8?B?LzBKY3ZGYzBRamVseER1NWM0bHZWV2hGWFh4NGg3RkRsUm5HSFVhTi9uMkNP?=
 =?utf-8?B?SXpHY0Z6dmVNZzRvUU5GdjJPbUJqNDJ5QmtYYVJzc2JDZ0hib29yL2x4MTN5?=
 =?utf-8?B?NW1mem1vUW16MDdrUHpEWXdkVllLMnhibGhYejdxVWRnRUpldTA2RkYxRldY?=
 =?utf-8?B?WXQzQjNtTVVsQTVKN1hZM2ZFcGRBZGFnNUtyaEczZ2xwYkJ5bE1VMEtWQnRQ?=
 =?utf-8?B?TWZHMERaT0hsdkQ4ajY4ZFdmOEhHMjhOaU8yRXNsanRYZXo0QTJwTDI3SEJz?=
 =?utf-8?B?L0lmMGVkRFdLTTNKZnNKaUhVc2dERE8reHBhM3hWd0piRzlUdUtDN2UyUVBD?=
 =?utf-8?B?S2QxVXlYSDVUN2VZZ1dYVDZ1TmtpRmNMeG5RdGliL3FQUG1BbWduZFA1WFY4?=
 =?utf-8?B?Rmx3MjNjL1UyQ3NEZGh0SklUUklZTUVyM2E1VnVrK2tkeks4WG1XSkMwZFRx?=
 =?utf-8?Q?x4ZbdpM5vV8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzhkYUVPaDNTSk0reDk5OGVxMXZ0dEh1NlYrZlhSRmxSNmw1ZHhlcEdIcDVl?=
 =?utf-8?B?NW5Wc1MxNm1HVkZKVmEyaGZDejJCSjZMVVM4a3hDZ2x5cWZBR1d5QnYzblNY?=
 =?utf-8?B?akxuU3M1RTROKytFMVd4am1wbjNxbTNUMXZlbDJUem4vcW9DZmsza3RBR3U1?=
 =?utf-8?B?bTE2bWlOWXdBR3BCMnpOSUl0UklYaXRnQ2xudElGc0VqQzVld21TdWVFejZB?=
 =?utf-8?B?N05rVVg1TGZoQ1JYNXNsWDFoSEMvem0vUHdPcitNTWxXdlR0WUJwa2FwV2hI?=
 =?utf-8?B?TlhQbFRoOUVuSSs2cVhxY25PWVR4Q3Q2aFdPTnQwcjg0QkV3bU83L01LRkFQ?=
 =?utf-8?B?NXVqUlFZa3d6VlNtM3dpYnFNMjdDcTh3OUVSWlhTZWIyK2F2a3pPVDRyZ2Nw?=
 =?utf-8?B?V2ZRenJvVHkzRHVMV2szdFQrODhSazFqcVhzVll2dmlIM3VaUmlpam95eWtz?=
 =?utf-8?B?WWcvaDNjN0ozSUxCMEptTTkrMmhkYzZxTjZWcUJlVTA1S1oycXdwdmJRbkxQ?=
 =?utf-8?B?L0JiMHJOSzZGZHZHSGlOQU1JbXlOeXN1NmhzVExudnQ4a3hUZG56WXlOUkJz?=
 =?utf-8?B?UmtKdjlqcmpmWENFTVU5bW9jZDdtNFBkYzdlNU45aDhyM1l4K1BscFhTcHZV?=
 =?utf-8?B?aEdPL0dLZHRlc04zRFJ5ZGZEZFRsZ2N1ZzFDcTJYWDVKbGV1TzZyeHIvRjlR?=
 =?utf-8?B?Ri9PT09uL2RmbWtNc1p5SGZXbHNUdFBZc0JZM0YwYm1PMVNMVW4wYTF5N1NU?=
 =?utf-8?B?OXc1M0ZOdDF5U3RPZ0ZuanlPck5IcFBFYjVzY3ZrUGt4TDdJSE9IUzdXV1Mr?=
 =?utf-8?B?ZmZQSnVLdjNBcE04eXBYNE95L2EvQ3poSzlHRmFVZkdwRTJHSzd1b3NjcTQv?=
 =?utf-8?B?VUZIT2haT3Q2MVQvTlY0SDVqUTMvaXdqNkI0dFBidXBWUzB4SmlPTGtOamF1?=
 =?utf-8?B?VWhzQUVMK2s1VU54cVBJaDAvbDdtTkpnRFhxWjN6ZWNZUmJmOFI2bHU3eXAx?=
 =?utf-8?B?SzN5bEhtR29UTGtJUG45MzNMMTVEWDVTdzROeVRSekVQdERmMkxWTGxRcERH?=
 =?utf-8?B?SzdOcWNGcHNCVCs5Ni9WUzYrRHNSbVFDejB4dDRKMXNIRzMvN3o0OE5vNWFL?=
 =?utf-8?B?Vit1Q0hiLzdQT3dUTHkrcTFKN2NVVTlaVmdjTk9RUzJZWVlJTzRmTWM5Vlpa?=
 =?utf-8?B?Mk1aeWI0aFhzcjQ0MDZoSEYxSzZHVGNiSDQ1TnlWd25ia1RKNmwvK0xXNVUx?=
 =?utf-8?B?Mk1NLzc2RXpScjgvaEQ5SjJmNjlnL3FPajZrNi8remFoVzNwOG9RVU1YaEtS?=
 =?utf-8?B?QmJtNkhZWHFPeFNCcWtUN05XWGNDWDBreXlQVnNHU2MzdjVOSlc1bFRUY0M2?=
 =?utf-8?B?ejlTZzN5Q2NmaGhGcUdqSVRIVTZLQng5WmgxRzhwYnhRenQ2VW9FWDBnZ1l4?=
 =?utf-8?B?TmRXQnJVbDV4eWI0eENCbzdqVEJwaG1oOGZzZHZDZ2tkYWp1YkozOTJlVUdj?=
 =?utf-8?B?Y2VleEtNOXczVDVRaUh1b09KQVBYWS8xcnBqRmhDQjg3L0pLaDVFeDR0ODVJ?=
 =?utf-8?B?Y24vQU5HWnVLN2NzaStIS1JwdVlxUERwNUZHTW9LVkRiQThHMlc2Y21NYXRH?=
 =?utf-8?B?MmZhSWU5eXk4VkZ2clNIU2J3ZHZ3TmlVNUdPeVdNUFBuTjFkMkdLbUNLRUxp?=
 =?utf-8?B?OWt5OWQvTEVxcXBaam5FQStFQytmVHA2ZjY5YUowOCtGN2xObWdPclNLN2pU?=
 =?utf-8?B?ZXErSEVRRS9KTHpEMXptSVMvVGN0UFA1a0Y4WFJhNXVhOURFbmF3ekdzQW1S?=
 =?utf-8?B?Z1NXa25FVFBPd0lacExHVWMxV0Z1MTIrdFB3aHoyTUhaREJFL2RkaGtyb3Rm?=
 =?utf-8?B?UU5ycEYzL0p2YU9keUxlZUFHS1EyckZBemlFSzlLTjlwcnp4djMzbWZZc0F4?=
 =?utf-8?B?K3BDRlNlL2ZBRHFRdElNN1lUbzRUSXJWVWFMcC9nNS9HRjVaQTJDU1hjVUsz?=
 =?utf-8?B?YzNGZmNNRTNWM1NVS0NyOWtLOTQrVEtIYmNGd25jUVE2aTllLzRKVDdBL2E4?=
 =?utf-8?B?N29BYnJxQ0JqWUdOVzlqVEdKSkRvYVNhcGJRMUxBVEJkSHhUTUp1N2VPaDA0?=
 =?utf-8?B?bUNrRnYxREdXaEdpd0lkazNBUVJvZjJ5UU4wNDRHMlVmalEyaTdpSk9HbVNa?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 476cbe6c-c7b6-4105-10da-08ddc591b488
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 00:26:14.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICLrUlxWIE1twcIetvNuF7N+LAIk2ABK0S6a3UF13d6MmWla+I43/5Q/iC7obZwbwwCcRaA4di64Bd2ykk5VrRWjvIQ77M23ozx93nyVnM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-OriginatorOrg: intel.com

[ add Syzmon for extra eyes on the VMD change ]

Syzmon see the proposed fixup in the discussion with Michael:

http://lore.kernel.org/687993e03bb4c_14c3561008c@dwillia2-xfh.jf.intel.com.notmuch

Dan Williams wrote:
> Bjorn,
> 
> This is a small collection of miscellaneous updates that originated in
> the PCI/TSM work, but are suitable to go ahead in v6.17. It is a
> documentation update and a new pci_bus_find_emul_domain_nr() helper.
> 
> First, the PCI/TSM work (Trusted Execution Environment Security Manager
> (PCI device assignment for confidential guests)) wants to add some
> additional PCI host bridge sysfs attributes. In preparation for that,
> document what is already there.
> 
> Next, the PCI/TSM effort proposes samples/devsec/ as a reference and
> test implementation of all the TSM infrastructure. It is implemented via
> host bridge emulation and aims to be cross-architecture compatible. It
> stumbled over the current state of PCI domain number emulation being
> arch and driver specific. Remove some of that differentiation and unify
> the existing x86 host bridge emulators (hyper-v and vmd) on a common
> pci_bus_find_emul_domain_nr() helper.
> 
> Dan Williams (3):
>   PCI: Establish document for PCI host bridge sysfs attributes
>   PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms
>   PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
> 
>  .../ABI/testing/sysfs-devices-pci-host-bridge | 19 +++++++
>  MAINTAINERS                                   |  1 +
>  drivers/pci/controller/pci-hyperv.c           | 53 ++-----------------
>  drivers/pci/controller/vmd.c                  | 33 ++++--------
>  drivers/pci/pci.c                             | 43 ++++++++++++++-
>  drivers/pci/probe.c                           |  8 ++-
>  include/linux/pci.h                           |  4 ++
>  7 files changed, 86 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> 
> 
> base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
> -- 
> 2.50.1
> 



