Return-Path: <linux-pci+bounces-35056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B41B3AB4A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 22:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3095C201204
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746F9278E7E;
	Thu, 28 Aug 2025 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNZr38tG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28026B96A
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411683; cv=fail; b=nl3bcSlJgj+7Okgw+oG/9LYNqBm303TwnjVHi0lHfVbwKjCyneea5xrC1m/jn+7olsYNU0pzyZG4B3XzYL8XhG1cm2WyXWbMfWbJsdfijWe3aZokMGHRPGGMlvQ3szUshMxCZvo+98juGuwa4Z0g5cTzo/eutzUNCDJHC6Lszm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411683; c=relaxed/simple;
	bh=j/j+TASvvFn+ihezwOQVOhnzXnniLQwxqRsY2bStXck=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GHw7goGM7qBe+cjcnnf/Fh/Y22TqT+MEUKl34VQeeFOfeCNCOtJtbbgkCAvLumpdxftD8smu0Ay5jK3eTzMAs05ZwoLd1jRmE83FsbVT9omhY+VnQhoENyG49gyRT8/mEZsVl7P3y0Qu/8c89/DuB/uHhBTUzyPgRb+Apdcg9eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNZr38tG; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756411682; x=1787947682;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=j/j+TASvvFn+ihezwOQVOhnzXnniLQwxqRsY2bStXck=;
  b=ZNZr38tGcIHGW3CGRMOlKUqsZAgTn5Vz3OvtzUoBsIiDXZKk9L6NfQIS
   5852h6onW+WQWsPSUZm3RcEc7bK6mtWcfXn3gC+j/6jS9nb1ppjWWjU6r
   FBR4Q32yCEjeL0RWbpASmLScduBtW2gVlGGA87vy1QEmKviiQ2LWtkE+1
   jgYp9M8PTu5+3saMBpuD1Gr2LUiAFtZBxN33HyLz5vbEPDfk5ZK6K1QzA
   ervTAaCwM4eKvWK/rryK1WSlvuAIXOtYuM/Z0oWFMPDfRFn/TWQfSerMv
   x3IitoplcJ6w0IsIT9m8VJy8T6/CZZjdEY6PxeStMyfZYFEmJDfLqZW1w
   g==;
X-CSE-ConnectionGUID: SgcAq1PNQdqxh57hIVG95g==
X-CSE-MsgGUID: LIfzDeTGTvyLxCeGuCsmHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58402048"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58402048"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 13:07:59 -0700
X-CSE-ConnectionGUID: xVbf9vnMSVCCsOCueDvUZA==
X-CSE-MsgGUID: WBMV+agnR6yI/uB1sa45AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170107184"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 13:07:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 13:07:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 13:07:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 13:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIBAvk61QTiAt+GrBHPo/yAG/0R5KxDsd2zVPjN8s4b/OVzXd4we1TFxiyiPpR/U3//e94U+x4eyCofpPsEl5xZTYRM9RB1FI8imCFtpIUr7TEFU7GX0mnv4FY9hBX9R4LF3FxlySSY7jkTWJIRngufh5GSL0pmpDFHkE6C6rpc6bF/eHnbgumiF9DiIaDUgMysVgDfW0UesbPOC/5OJ7hVRxQqKH4xfGMUxcrJKZp8wQXDLb2+Ua+KUbtkciN4DfOK3NVN07wXaIU4dJtA6LsMuVLaU49pFunMk/lbQ5NSFTJCbSSixvE8RAaFMv3i/0NZTG/VCfNBgKB92937HVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTo6/cA5XWeRB/dDUcjMF6INwD0Tci7p6L7bX6HK720=;
 b=pwXbMMSi3QPbO53atilNYmL4W8PyOCpfLwRgZylbOof6ViWIV/wUa3xl5phfGLl7NPIk75KYHm+AERUXzG6R1FacB8O7Tx6US1ZOUPSliTveBcrbqSAvpDDXDWDWip6lQOYs449oco3Poy7GC7VjZZRq1O0FNwTECap+feKrig2OHM7tqGmx3+FGjIS+ogdSxZhLlDC8jyJZ8WyNtv+2vzQT+pzrcpefDf3GdOTohcWkBckUD4e5fDuKP7/vcYMIJwk4DZOgrBSOe3M+39b1AoBajXRxvwKU0rkxEhRbKSJeV8cocgOm2ZQ5Qz1AsxIfaQH6PQQiqJDu5ORIMELgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPFA92F35354.namprd11.prod.outlook.com (2603:10b6:f:fc02::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Thu, 28 Aug
 2025 20:07:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 20:07:52 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 13:07:50 -0700
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<bhelgaas@google.com>, <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<aik@amd.com>, Christoph Hellwig <hch@lst.de>, Jason Gunthorpe
	<jgg@ziepe.ca>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Roman Kisel <romank@linux.microsoft.com>, "Samuel
 Ortiz" <sameo@rivosinc.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>
Message-ID: <68b0b7169cb1b_75db1001b@dwillia2-mobl4.notmuch>
In-Reply-To: <2025082717-fresh-catty-3394@gregkh>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-4-dan.j.williams@intel.com>
 <2025082717-fresh-catty-3394@gregkh>
Subject: Re: [PATCH 3/7] device core: Introduce confidential device acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPFA92F35354:EE_
X-MS-Office365-Filtering-Correlation-Id: c9929c55-4399-469e-f854-08dde66e9197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWFoUkczVjlzeUJVNWowMGc2aSswdlF6bDByR3hyR0daOWszWmNDeVZXN21W?=
 =?utf-8?B?SjJDTE9JVXQ1cXBwbFRFcVhPUGp1WGxLa0JYVFpnYjhxdGREZWJTaVdxbnh6?=
 =?utf-8?B?dVdXNUJvS21Dc29WZ1dJcmJaQ1NLRnVYMTBHUU9PYzBrRVA0aUdNYUNCM3lW?=
 =?utf-8?B?RXYwN2toVll0NzRFVDd5L09kaGE5MS9wUk5mOGdweTNHUUhSNFRCMlBtWjJj?=
 =?utf-8?B?ZHExY1loaDMwWWlWWExYb2g4eVRYb0RKeFZ4TFFhYjRZMGJQeTl5ZGlVd245?=
 =?utf-8?B?NkJxVGE3OFU2cFdzVG5JdTBYOFViKzJKNUk5ZnVFZlNjK0xRaG5ma0JFS0lw?=
 =?utf-8?B?dGkwT3RBcW5pamtOelpsZ0piOUczQ0tmQzUreUJiVXpXME9xNXpjL1N4VXdi?=
 =?utf-8?B?M044cUllSDY1aXRWZmJ3dVU0VzF6dWxxRHZFdCt0dUpKbjFkWnl3WkowQkg5?=
 =?utf-8?B?U1NOMThvQ3VaSHZTUXRpUm1tOFN1cThqVy94RFhEVDJnK09MVEVkbHU2bWNx?=
 =?utf-8?B?bWZsSkNVS1VqaWpBZ3VIeWlHUTNMMXAzVDJLVFZRTmxGdWExVEd3Qkh6ZFBr?=
 =?utf-8?B?MGl6U2RJUmY4NDB2Z0dHb0kxbFlXM25xVkovQ1lsT3pNWE1McGVRVHcvR3hO?=
 =?utf-8?B?b1hNczVlWGxkNGROSC8vbzNKdHJ1M2Q4NkhhZW12d3BuQjM0Mko2QzFaYnd1?=
 =?utf-8?B?YnkrNXZLRWd0OTdOMStYV2U4M3I3V0h6Z09RY2tyK2xGTWJ3alZWbVFIRmJr?=
 =?utf-8?B?amdqenNEV01iTkRXUGRTS0ZDQ3lUNzBTbld4R2s0ZFYrZzJrblFDODBrUlAv?=
 =?utf-8?B?dmNhVTQ2YzRJN21qV2k2Z09sVUs5RDRuTUJzNUlsWVNFY3FObjdMdDE2anh5?=
 =?utf-8?B?ZHhyTDNvbDFBMmpHNEpqak9WUWtaanYya1JQWTFGbjZFK3VNR1R0eGxOcjNE?=
 =?utf-8?B?MXFwMVpNby9jdTdmN1JwRTdRZ0tUVWFqdWdXVTJPY1hXcjIyc3pwQlArcDRq?=
 =?utf-8?B?TzUzN3VmSk1JR213LzVqdlVpWnh6cHF0K3Y4NGNqRHB4M0xWUjk4MWpibjM0?=
 =?utf-8?B?ZnhoblFUZVByelR3T0pRMWNPeWVKeE5VaUV3N2h3QnU5NlVSOFlBZzQwZUpV?=
 =?utf-8?B?TDgwSjBDanNGNEkySTRFbThuRWdONkd3cHBLbEQ0MmIxbFNOTEZIb09HcVFF?=
 =?utf-8?B?ODl1aFVVSk5NZXRlOUI3dWY2Z2t0ZmsxL3lzbFRDYm5NU2xveUpIUGZENU5p?=
 =?utf-8?B?QmlUcUE1RUhwM1JPd2VWSEdjdlRadmtPSm94cmVVN0pFQ2svN0VqbDhXdHdD?=
 =?utf-8?B?b1QxSW1kZ3pzeTcreWNmd0hxbmlMZ0JRWVB6LzIvSlRwc3ErVVlLWUs2d1Mx?=
 =?utf-8?B?NkVzTjlSTDY1bTh4U1REZVQxWkFacVZCNnZueVMzbTZmMUxNMk1oWGhPcTNP?=
 =?utf-8?B?V2JJV0ZBNzU3VzdKS2xHT0hRZ29PRlpoYUFmVUFBK2owQzd3dXR1RitmYnhr?=
 =?utf-8?B?S1NUanFhVG5lVzFYK2FIeXBzTU5mT3VNNHNoQk1nL0RlQm00T2FFdWFHeDQz?=
 =?utf-8?B?NUlGTkdXdGFUanlCNEFJLy9YbmNqOTR1T1pla0ZMZmZ3bFhmS2hHMzkvUk5Q?=
 =?utf-8?B?TFIyYUNQd3VpR0VSNXFCcFVPeTQyTDB4N0RvdkpoWVFBVXR5SlFJTE5Bb0xj?=
 =?utf-8?B?d3k2S09qeDhyRTFrd0dUTUJieE1iV2FGWE5YS3VYcjZWc2ZyS2ZqeitIOVlI?=
 =?utf-8?B?dFJuZ3d2Znd3OTFBSk1ITVNLbGs0QXB5VXdBS2VhWTdKNEh1M3QyMGNjSy84?=
 =?utf-8?B?SUZzL1dNUndzYk1OVEZUaURRTVdCdytiK3paS0ZrSEVveHB6eTJDVTUxbmFK?=
 =?utf-8?B?b1B1eWM1b1pqYmxONWc3Wk85NDJrWUQxTFlnTzhuMXZ2d1JxQm1NeVJRdkdX?=
 =?utf-8?Q?zUx4e7C3lQU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHlPRlV3SWhXZzJPOFhBZm5pVUNtSFVPNGxVRkY3RVk3UGY2cDNRM0dXYWlI?=
 =?utf-8?B?TlpPYlo5eExFeU5TcDVTdGF6Z2h3cHpZVzgwcTJuMHNtcXNFcjRWd0hpdTN0?=
 =?utf-8?B?UW1nRUJjME5pWm5XY2pUYjRBNWNNUjlOZHFQWUFiWTJacDRDdHp4Um5PbnpC?=
 =?utf-8?B?ZTNhcmVJUEdtbU0ybzJab0ZPMHlTNFRMOXNYYytlTjQzcDRVVU9DOTVSQVNK?=
 =?utf-8?B?ZkFHV0lsV1pIYkJxdTMvUGZYNTRWK1hTbFgrVTlmTlk5MnpkV01CT016Q3Vt?=
 =?utf-8?B?UTVDcG85WG45M3B4MnZLQ2tsV2tDbGtQVERPUHJUUW53YkdKeFlmdEhFOHlu?=
 =?utf-8?B?aDc4M3NsTUQ0L1M2eXlwQ2N6UWNGc3JBRy9BSFY4RE16ZWpGUlFzZkN1R213?=
 =?utf-8?B?bWhhK0V2U003ZXU4STdyWGs0UUs4d0VJUE4xWHlNdnRyYkRTeDRjZ1BvTWkz?=
 =?utf-8?B?a29mVWhzaTl6NUN1bWRtYS9kNUx4RXIrOExBNlk2S2FBSU85czYrMGthMEZ0?=
 =?utf-8?B?eTJzSm5EOWJYODR4SXR2VHNLb2o2cU9TQXJKRXhleUhCaWJIL1AzRzBNLzFG?=
 =?utf-8?B?VERDblpaT29TQUJGa3B2UUkzM0ZEelVIbWlPTDdoWVBwNFBXUzJ1QlpNb09D?=
 =?utf-8?B?Q01ERVNLRVNKRVdmbVIvZlRuVFgxbnRzYjVwTEN0VVlKRFJSdGh2OVdMSjJX?=
 =?utf-8?B?RG9vM2ZlbEFCd0ZQeERUcHV2N0dBUCt0M2dGQ3ZHMHBIWDdlS1NnOXdzSlJP?=
 =?utf-8?B?U2tCdk5HTnZtV00vVDc2eG93cSs5U3VJa1d1RVlLRVVwSjh0blIveWhnVy9q?=
 =?utf-8?B?SVRDbFY0NDVvajV0aFRwSlVGcExYZ3N5bVE3eUJFSlNtK2VQaTg5M0luM0Rm?=
 =?utf-8?B?QzUyUEpjT1gwMnd6NEhsSG53bzJDRmtYdFcyNEhPV3ozWC9XSGxELzlSeTJK?=
 =?utf-8?B?RUZKYXZXZWNYVDcremdtakk3UVV6K1VsQjc4eENuTVJ0L1lkdkdSZXlKT3Vi?=
 =?utf-8?B?WE5rY0FVZnEwa3ZFMzBmZjB0RnI5MHRZUkVaRU9tVTJhTC82SFVQNk0rVHFu?=
 =?utf-8?B?ZDJ6VXpYWG44NHd0MmZ6M0l0RXFtSkxacGpuSHJXM2NkanA3ZU95UHJTR21Y?=
 =?utf-8?B?ZVBpRnhyYkxLbWZ2QnpDY2RObGYyUStiU1JQUE50TzdpK3UxZTJrQVlxcDQr?=
 =?utf-8?B?Y1JrMWR6L3hHeFVYL0NXTmlDR0k0QkRiSW9SaXlnZjgzRGxoUHQrQ2ZvYlR6?=
 =?utf-8?B?VGlqRnFmeHFiWkQ3VkxwZldHOFpWTVNKVkExUEtTNnJJZUhabFVGRy8zNzE4?=
 =?utf-8?B?ZzdyR0Fma0VGUnJFT21oWW0ybmpwY0ZTY1hEQnl2L241QmVoU3ZQUlpVZXcz?=
 =?utf-8?B?bXFDOFZqTEU1OHlvVFlIVHlBdXRVOGdmamlqeTQrZTc4a1NScjhkYmZ4Sk92?=
 =?utf-8?B?bHpaYnNYSnhjV3lLTkZ6dVdYTGdndDdTL2NkckxMNGtpSXo0Y3FoWE8xKzRV?=
 =?utf-8?B?anB6bFNUNE1tUHlnNWxVNytzRWJ4K0YraGxraVlDdE5idUdpNjFQR3l4RDA1?=
 =?utf-8?B?Q0UzZmF1UmR3WUQzMFBkN1BLUkhoQWlsTXBoSm1XbHpuZ1JGSC9hU044N2pE?=
 =?utf-8?B?em84OUpmcHFpTlJvd1hYWklIWDk4RUNiZGkzUzdhOWttWUt1aUlTSFY1YTdt?=
 =?utf-8?B?dGZQYmhhdUpEb05ieDlxY0pNRW02bWlvMnptWlpVd3czRS9sTDBLeU9RWm1X?=
 =?utf-8?B?M3llaHNJQnZkMjlUOEtEUkt5czlkeWFJQUNwcFFLdEp2QmtSb3hwcS9ZOEIr?=
 =?utf-8?B?WElGTnhuTW5BbGJNT3JFNTRqcjNJWk9hWFkydytSdllJMk1oUDVSOVA0Z2Uz?=
 =?utf-8?B?UVB5cjJBODlPZ2JuZUQ1b2NLc2k4Zitab2kydTBuMFJUQ0RrZldzSWE5TDNO?=
 =?utf-8?B?N1JOVFVONjJQL3V3a2VmMHJsbnhLOWFRNnV6bUhaUEZXMmtobWQ4dWRLSzQ2?=
 =?utf-8?B?WHVkS2VaNUZDdS9iSktFU1ZheFkrSCtHSWJWVStnSzZxeFdzMG92c2d0VG1u?=
 =?utf-8?B?TVkzSG81SGJQdVlNU2pSWDVWdUN3U1liditmMkNYdmxweWs4VmRRV3R4TFhD?=
 =?utf-8?B?OUl1czBUaytGMDZ5TzJXaWtyTnFVYVk2ZkdhenhyZ04zNUhFWDhzVHgwSmlN?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9929c55-4399-469e-f854-08dde66e9197
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 20:07:52.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDtnSlkj6lKUWcC25h7nAPDDiIcKPKHDykmotTBftanvhLZ8SYSHijRJlGuJCANzqO8tBdulV4c0YBPMkNcYP4KMTpsndGe59BTrzKKOzaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA92F35354
X-OriginatorOrg: intel.com

Greg KH wrote:
> On Tue, Aug 26, 2025 at 08:52:55PM -0700, Dan Williams wrote:
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -98,6 +98,8 @@ struct driver_private {
> >   *	the device; typically because it depends on another driver getting
> >   *	probed first.
> >   * @async_driver - pointer to device driver awaiting probe via async_probe
> > + * @cc_accepted - track the TEE acceptance state of the device for deferred
> > + *	probing, MMIO mapping type, and SWIOTLB bypass for private memory DMA.
> >   * @device - pointer back to the struct device that this structure is
> >   * associated with.
> >   * @dead - This device is currently either in the process of or has been
> > @@ -115,6 +117,9 @@ struct device_private {
> >  	struct list_head deferred_probe;
> >  	const struct device_driver *async_driver;
> >  	char *deferred_probe_reason;
> > +#ifdef CONFIG_CONFIDENTIAL_DEVICES
> > +	bool cc_accepted;
> > +#endif
> >  	struct device *device;
> >  	u8 dead:1;
> 
> Why did you not just use another u8:1 at the end?  You kind of added a
> big hole in the structure that is created for every device :(

It was the concern for colliding bitfield updates. I will go audit if
all ->dead and ->cc_accepted updates can be guaranteed to be ordered by
the device_lock(), or otherwise put this bool in a better place in the
struct to not cause a hole.

> >  };
> > diff --git a/drivers/base/coco.c b/drivers/base/coco.c
> > new file mode 100644
> > index 000000000000..97c22d0e9247
> > --- /dev/null
> > +++ b/drivers/base/coco.c
> > @@ -0,0 +1,96 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> No copyright at the top?  Bold :)

Will fix.

Hanlon's razor v2, "never attribute to boldness..."

> > +#include <linux/device.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/lockdep.h>
> > +#include "base.h"
> > +
> > +/*
> > + * Confidential devices implement encrypted + integrity protected MMIO and have
> > + * the ability to issue DMA to encrypted + integrity protected System RAM. The
> > + * device_cc_*() helpers aid buses in setting the acceptance state, drivers in
> > + * preparing and probing the acceptance state, and other kernel subsystem in
> > + * augmenting behavior in the presence of accepted devices (e.g.
> > + * ioremap_encrypted()).
> > + */
> > +
> > +/**
> > + * device_cc_accept(): Mark a device as accepted for TEE operation
> 
> What does TEE mean here?  I feel you mix "confidential" and TEE a bunch.

The distinction in my mind of merely Confidential and TEE acceptance, is
that a Trusted Execution Environment implies a larger attestation
infrastructure beyond just "are the bits on the wire protected by AES
XTS". A TEE has a launch state attestation for the TVM a vTPM or other
Runtime Measurement Scheme to have a relying party validate that changes
to the TVM do not violate expectations of the TEE, and in this case
"PCIe Device Acceptance" is one more event for the TEE to validate with
a relying party. The confidential device mechanism is just a property
that allows the TEE to maintain its confidentiality and data integrity
assumptions.

I will include a form of that commentary in v2 because it is an
important distinction.

[..]
> > +/**
> > + * device_cc_probe(): Coordinate dynamic acceptance with a device driver
> > + * @dev: device to defer probing while acceptance pending
> > + *
> > + * Dynamically accepted devices may need a driver to perform initial
> > + * configuration to get the device into a state where it can be accepted. Use
> > + * this helper to exit driver probe at that partial device-init point and log
> > + * this TEE acceptance specific deferral reason.
> > + *
> > + * This is an exported helper for device drivers that need to coordinate device
> > + * configuration state and acceptance.
> > + */
> > +int device_cc_probe(struct device *dev)
> > +{
> > +	/*
> > +	 * See work_on_cpu() in local_pci_probe() for one reason why
> > +	 * lockdep_assert_held() can not be used here.
> > +	 */
> > +	WARN_ON_ONCE(!mutex_is_locked(&dev->mutex));
> 
> If not locked you just keep going?  Why not return an error?

It is ok to keep going because this is a warning that should only fire
on a kernel developer workstation when they have somehow messed up a
bus's probe implementation. It is more for documentation purposes like
lockdep_assert_held(). Maybe a lockdep_assert_remote_held() for this
work_on_cpu() case where the thread holding the lock is also in charge
of flushing work_on_cpu()?

Either way, this race fails safely. If the driver proceeds with falsely
believing the device is accepted the hardware will throw errors on MMIO
cycles, and fail to issue DMA. Failure in the other direction just means
the driver fall into deferred probing unnecessarily.

