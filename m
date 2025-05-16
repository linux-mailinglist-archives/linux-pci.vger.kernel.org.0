Return-Path: <linux-pci+bounces-27820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA063AB9597
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4750B500BBE
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896801F463F;
	Fri, 16 May 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yew8/Xpa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F321C9F1
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374469; cv=fail; b=W+ExJ8lioQ4mhnygTCCjJr01Nk0qpr/4Pc36l36bhGxDVm9PhGvs5eRRvJzyvb35NYsY39TNiNKXqzJcgG3BojsMX29MKlAHUplAhVevXOytuQIJJ22AFua6/jCnYW0RNH8TiK/7GD7pK24rrDMaA3wqfM9fQT1GW6XdoWI94gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374469; c=relaxed/simple;
	bh=JITupa7g4h36jCFDnnmMVSyC3PRVRRugL8w2q/xg9m0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C7c2iR9sRRNdDOjxSAywlTA3JQH+RNyV3NJRwsKc9wJIPSaL+2gyXMHxgqpLnWJ17R7VbK35jFkI9TQM1YIQGEUjHIZotewkku8vDBRdkj0rpRCzBF5/is3DS5gmMZR4IQSFggtuUFSwNU+TczpyBRM4ZkN+Xf2+7AVeb2mWnOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yew8/Xpa; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374466; x=1778910466;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JITupa7g4h36jCFDnnmMVSyC3PRVRRugL8w2q/xg9m0=;
  b=Yew8/XpaQLWNhp6zGRn3khkUFjyTgNbaUAvS5mpepS3DFwutxgKjbmqD
   6kP1tBASHYEwgnHT7TrzkQT1u5oLdsQ8hs1Hr1VON7pZ1FyNK+/mL15Vz
   jQrWoPASeEOqn6kI4Vg6XiS8uMXSIIYE9AEO30JVy7kuS6NoO69kdw4Z6
   Xk8mURA6yxc7kenWD9+BCHVjJ5mUh0Q3Tfyw5fGEGDGmAhtHrQi1Euqtx
   RaO07owWt1gxveIY5GxaXkX4O5JZ7utjAxDt8uYEwV5nrqRBM08DVm4By
   FfWSVkAnBbpaUIKAP+bYV0vkHIAjUppR+1r7mfSzcIKfm0YCQbEqgF9g4
   w==;
X-CSE-ConnectionGUID: Yt4/FVsWQP2VvDcnXv9kog==
X-CSE-MsgGUID: R7C6t254Rce9N1mBNYgNig==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952750"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952750"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:45 -0700
X-CSE-ConnectionGUID: 9xMbnQCBTfGLuzbT1Wgigw==
X-CSE-MsgGUID: J5HCCmYtRZ6UIJ0WURsBdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="169654628"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:47:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:47:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:47:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMMSmMgTYE+yuepY6v8L9KZpY9QtHPLcuTVrBj+K3nf60veuUarrPCpNHEaEU23yLwDC5vc3ddvg38MKa4UQ1E7PWNkwtzmFiWzZBkYnF7MBv0nq+HphsydwsKgpGAvByWL2BOqCZoj5l26O6fSMYt7jbLlCOVFECpHrC2YsZi1ijpIliHQfEeEL2HIbxVyFdBFFsXDvZ2TO+Hruw3BgRZg+aOVkK72v/0RSqIL1xryGrfF97Q2PgYdCtJ7dKOiBlet7uIXCOJF39NJ0vIuXkZ9TMwL4sfJC/V+VA7o9S+6LlmYrbossJalWbtFBZo+UFnmYHz5JIPG7ocLbJl4NiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SdEpd3op+ht435u9eumUKHwznz36JWdbZ4eKC76upE=;
 b=eEGOubIkbLFT/PJwGVJR7hqGwk3d2SI/kEVHoK9HKvRuwulhEZE/LN34YrBrxZ6U05NRBCBVreqCinzdRVLGxfEX8anpR3PcU8xJ5QBzb1oDdpmJuME0mRCIhzqKhowSjXCKnyHsvvS9KHnJbVgC8wZq0J7PEiqr7z7khJufa2b1qYhbbto1uU3xcHNmPo+Sutee+yIt0d6WuCrcuJ3EizE5oWJKNAA4/JBoB0B7ILnboAKcN1K/zCmDbM2oIGv8NFKMWXCC26jBEaoBAUo1uMqceWz45FRKWbwDb33xIEzv+ZI6EYxhUKTYJt2NcJQvslPSR/JblNpb0NOCSud57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:47:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:36 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Dexuan Cui <decui@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
	John Allen <john.allen@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Nirmal Patel
	<nirmal.patel@linux.intel.com>, Rob Herring <robh@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, Wei Liu <wei.liu@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, Yilun Xu
	<yilun.xu@intel.com>
Subject: [PATCH v3 00/13] PCI/TSM: Core infrastructure for PCI device security (TDISP)
Date: Thu, 15 May 2025 22:47:19 -0700
Message-ID: <20250516054732.2055093-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: e8aeb9a4-ff24-4fd4-987b-08dd943d290d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUl5UldScVdOWjRpM0d6YThBWHZWTXRDZVV2a2crUWVqQXNiVERtbENkOWVK?=
 =?utf-8?B?L1V2TVVyR08xVG5IU2ZvUUhGRHdhMjNLQzE5SkFIaDNTVlpHTk5FajBhbWho?=
 =?utf-8?B?L2VvcGwrOHJzdS9wNUN1K0NpMXg5U1c4Q2loUnhoVm5tNHM3eXNVb1B0ZWtI?=
 =?utf-8?B?RGpjd2p6TnNGMGZBQzE2bTlUTXk1Z2IwdVpnZ2tES0tnemhuMkxvWkVXZUl2?=
 =?utf-8?B?dmZVWGRNT2w2U1AwYnFZUjJtaS9SaFB0dTNXaFFsQUlLY0ljQ21jRy80OG14?=
 =?utf-8?B?TzMzZUZDTkY5a2NMU3hEMkgxNHhHMWR1dGgxd2N3S1FyUUh2ZXFTRnNaL1Fu?=
 =?utf-8?B?YUNNTHNlM0I3UXBnRVgxT3lGaFdyUmZBRE1LRU9WdGhWak1tN1NRZjh5Um9q?=
 =?utf-8?B?SldkdVZEQzZUVFNZYjJCRW1tTTYzcFFvcHFrcSt1YXZuSjZpSmJZU2d5dmhF?=
 =?utf-8?B?UnR1d3BHVFlBK3JEVzIyb1pFSGRZTUg3Y2NzZkFWdTQrWTRYTCszaGQ2cC9j?=
 =?utf-8?B?dWJYamxTR1VOYVhrUDhvS1NTVVQrZEI5RVdMMkladlNreVZZTmROOWpOa3o3?=
 =?utf-8?B?bzRQMlFqNytRQzFyVWdMaFRlaUMyQlZpWlVCWHpOQms3NFNyUEQ3ckoxZmJF?=
 =?utf-8?B?emJTMFJpQ1VuYk5kb0xxWDZPREthM0VkT0twellFaVJtOE8wcUJ3SExIajUx?=
 =?utf-8?B?ekhHREpsUDJrM2ZyR25ub3VNWDM1Y0FqT1JKSFNoN0drRUY4MnlPcmRlUU5O?=
 =?utf-8?B?UDQ2b3QxTEZ5NXVZUDZ1eU5ldFVRNUx1eU9rdWFuMjVnbEN5YXNGZFZoVDlq?=
 =?utf-8?B?aXVsSkF5a2VKWE12c0FyZE9Pd0tVZUZOdUsvT3dWVGpncEdKbVZ0dFZLVktv?=
 =?utf-8?B?R2RlRnEvY3Y3TzJFS1h3bmJLcHI2MDMyTHRqZ1FKZlRrYmF5aGNRaEZCcDdk?=
 =?utf-8?B?YTEvbHhSRmlRR1hQb3FsMkNoMkZ4dmZ4eHh5Mllabk11UWNkbWFGUHRwb3Ez?=
 =?utf-8?B?cUVhcTdhejkwNHc1TUFLam82ZDEvZ3ZrQkVmTzJiRE9Xbk42YWt2TXM3STdu?=
 =?utf-8?B?SHA3dEJld1YvZC96YkRaV08yK2N1TW9VQUJNZ2RoZDB4dlZqYUFDNEtlazhJ?=
 =?utf-8?B?bVRxNnl3MTJVM1VPVGFjOGJmWjcxeTcrRCtLc09FWnFGU3U1WVY4K0hLK2tR?=
 =?utf-8?B?d3FQRVFTajdpeWV5VmphOWJGWjNrSTJSZXJ3c0Y5eUl1ZW5qTFZ6cDR0ZXpC?=
 =?utf-8?B?bk4xWTNMcVNQSjVjVU5kZEJqQ3lxR21HUU9EejRXMDdYVkx5MDdjYzhYeWx2?=
 =?utf-8?B?d3VpQk41YW40QjBUWlRMaXpIMVJaTlZkcU0xSTVQZGRZR042azIzdlhIMlpD?=
 =?utf-8?B?MkM1cUZMdk1BRno4R1VFaGl0UTc2Vnp4dWcrZy9hemFYRFhzRmFBb2k0cDNC?=
 =?utf-8?B?b05CQ0JxUmlyc3NNYlVqdlJ3OHlrK015UVNZaTlKVVU2UisvSitENlFmanBZ?=
 =?utf-8?B?cUZJZDFSOVhSV0dZcXEwblBKVDNqakNoWHV0UlI3TnZac0FpZlhpT3BLQWZz?=
 =?utf-8?B?WW5mUndNcmg5V2c4ZmNGUDQxdEdCb09rQVh0dmhnRXZGZ3JSb21XeEU0Y0VN?=
 =?utf-8?B?VFNlL05IODR6Yk1tcXRYNTRaM1JNNFFKUTBndW9WZC9xSHBPbVJIdzYwVy9k?=
 =?utf-8?B?K2YwcC9MWmZQVTExZUlxRmJhekFNbVJoVjBDWDViMGVTSjNSQ1lOdXlzaEJh?=
 =?utf-8?B?bnJoaE5McjB0bkNHNXpQaTRFNlZadWNlczlvVitWRSt4R1dHenRiSTFWay8r?=
 =?utf-8?B?QnRFY0g3U1o2RmtOTWw5ajVMQ3VueHFJWklVbFRNT1ZOTFVRVXRGUkwwSysy?=
 =?utf-8?B?a0tnNjNaTWhWeis4VU1VbmZkMlhqalRIWThrZ1ZpWjdZRnREMWMyNzdnTnc0?=
 =?utf-8?Q?s4MvMiJCSsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9yR0hmYnZHZzdKMHhNZnlkc0NiNXE0Y0VQQzNXcFpCOFlqSHhsZFRENW9U?=
 =?utf-8?B?VEs2UzNVWFA0Wmg0VkZPd0c4TFZkMzlQT3hHWC9CL3NoelhBY3FEaTdYcURq?=
 =?utf-8?B?N3hBaldvVk95WllyQ1p3eXgwMVIyUm4xSWpTTkF0N29PeXJncmVCOXpjeGsv?=
 =?utf-8?B?U05xc1Y1Sm10bUhKS09VTmRxQW5tR21QTXVVSkd3WXRRNU9SNk9mSHFhTlBh?=
 =?utf-8?B?d2xnUStOVEEvR25yNnFOQWErK2lZbXFKQ1NuNzlRY2ZPSFA2MHkreVo1TzB6?=
 =?utf-8?B?UlpqWElUbS85NytFWVg4YTJCRWZuWkxnUWNIcXU5eUwreEMySXpNcE54NWVz?=
 =?utf-8?B?Rjd3UFBjMHZuOVJGUXg0S0hKRmt3TXlsbG1TUlZhdmcrc3ZDT0lOSDJ5N29Y?=
 =?utf-8?B?VWl3ZXpORzFiYTgvTjRlQlQ5cFl1OFpXN1lSV3BDZXVxZGpVK0JqTjNjQ09v?=
 =?utf-8?B?alErT2YyT1I0NktiQ1MyZ2c3bFZEZktXNzA0eFlTbE9XN00vd1BxNVpOakFX?=
 =?utf-8?B?N1NqK2RuQ3Ixb29ocjNydjB2Rm5oOEV2aVVNTTBGWndOQjFTdUdwNnBPNkR0?=
 =?utf-8?B?OHppUmt3ckV3MGVzTm5wTUhNVlBIWUdick53cjJwelpyZ2IrdkRYK0VMUWdh?=
 =?utf-8?B?SmtQYWhkMVVPM2QyMHdTcTRleDU2U1FEU204UW13WmNSaDFFMGNhWE1zbXdB?=
 =?utf-8?B?d0VhL1RLLzZMRWVWOW5ZeHVTT2dqSjlhNXhBVU9YdHZVTUxENUR5ZGszMGg4?=
 =?utf-8?B?QjNuaHpjT3ErcTNVWmNyMW55azZmaWx0NWtGNlhmd3RWeWtGTUs4OTBtSEN1?=
 =?utf-8?B?VEZoY3pha0JCMjlmcjFJQWZmTGgwVlFjU0pBYi9OMkFVWFFwWVZWNU9SNXV2?=
 =?utf-8?B?V09nUEh3bmZzWFRaWU04dTh0WlNKcWxuazgwcnVzQXoxdVdTUU40dmVnK1ZW?=
 =?utf-8?B?STl6aXB2NG5iODBhK0QvNXJtcDlCdStpenA1N3VyQUxyUi9HdUdnY1VDeUI5?=
 =?utf-8?B?YnBVSmVEbGtOMkhQSmZsZ2RqalVDak1lNzBCODZWdmEweFdDZXpBbWRsMEpi?=
 =?utf-8?B?emVJeEEwYzltOHFSYkxETENLRXZlZzJwNlNnQlluNVY1QS9LZGZ3WnA3ekdu?=
 =?utf-8?B?TU5NdlprdkhnVEZXMng3dlZqY1NwdVJjWnN4QW1lLzN6bERhM01IVjZ6OVlE?=
 =?utf-8?B?QUI5Z3RsUTJ5RzE1bkhuNithYnNiNElKSkhHVUU3cnJVV3E5QWpQOXExRW1k?=
 =?utf-8?B?ZVc1aHVJYmxINTRSSTNxRkE0d2k3NmNKck1nb1plR1FDRWMzMFR6b1dwU09J?=
 =?utf-8?B?RkszVTNGeU5EaXNaTGZvbUlsSDVKVkNnU0tIZGs2WlNJekxZU0NTZjJpNVp0?=
 =?utf-8?B?Z3dhbXJvUnZacklGZDdKcWNzdmJiaFJaM3UzazJKNVo0TG9sNG9MKzN0TnRF?=
 =?utf-8?B?dXAzOFc1aWJFOEdZUG9iQnVhd05GVmFYNjVpMi9sNk8wQzFxaUR5RERJYTUx?=
 =?utf-8?B?UmE1TU03SS9Ec2p1SHlDTHpkeUhGU1hKNUNLaklQUkJYOG5SVkJEWThMbVVs?=
 =?utf-8?B?bHdlK2t4eUpURWdxMGpSM2d3a0NweUZlVEt1QkVIOTFXS2ZETHNjY29TN1Zy?=
 =?utf-8?B?N3RCdFVsWE1rRW5SQ1BxOUJxNlMyWk0zSEJXdHRYakxTUjM0V0NNN2tlb2ZZ?=
 =?utf-8?B?N1JtOW9Pb2gvUUkvUkJTMWFxTVFoM0dha3F0KzB4eDVYZTAvSjJPaGh6alRs?=
 =?utf-8?B?QTB3YTVrNTBMTzAzOVBoSVVyYnpCTzc5L3JIeXNDMnRqVWFTR2JXV1ZIYlFS?=
 =?utf-8?B?S2c5QUsxaXF5N0V4L0VIUWtEckJKUyttVXBpaEw5YjdVNUdHUDdWTXpLQ3NQ?=
 =?utf-8?B?ZjkwWTBGRlAwUE0yZkdhd3d2UDI1MnJ0ZjhwRW9wQzViTWVCdFMyakJpNVZQ?=
 =?utf-8?B?RnEvS0k2dXMxZmxTRmEwM1dpSy8xQ2gyajZ3UmwrcXBRa3NTbHBjQ1FqdHZp?=
 =?utf-8?B?RWdGanBtTmhzY3hYK3E0eFZWVFhKUXdNRnVhY2lqaytkMVZKTU9wNExNS2p2?=
 =?utf-8?B?aHphRnFpTU1vNDEwRER0dm1mZzV3aExJaGx3L1IzRWovaCsrdk12LzlSVjFF?=
 =?utf-8?B?S3UxeTJxNWZMN05TTW9Ib29uTUVxYW54U1FBb0FPSDVGd1ZJUDZtb0NHQ0F2?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8aeb9a4-ff24-4fd4-987b-08dd943d290d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:36.1328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYxeRL1M1bMNtxxMU+Hcvfo381sGjc0gOHvHdejl3afzd+HwDtiB2a96VHQbz7KW1oNmtRoG7POnE66zcA9lnePN+czY/NEvX5gKaZhxi3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

Changes since v2 [1]:
- drivers/virt/coco/guest rename merged to tsm.git#next
- Clarify usage and requirements for pci_ide_init_nr_streams() (Dionna)
- Misc fixups (Dionna)
- Fix sel_ide_offset() to incorporate ide_cap (Aneesh, Yilun)
- Allow at least 1 stream when enforcing uniform address association
  register layout (Yilun)
- Fix host-bridge-emulation for PCI_DOMAINS_GENERIC platform (Suzuki)
- Export pci_ide_to_settings() as a helper for TSM drivers (Yilun)
- Set Stream ID early, prior to IDE_KM (Alexey)
- Catch IDE_KM initial setup failures with pci_ide_stream_enable()
  errors (Yilun).
- Fix missing initialization of nr_link_ide (caught by
  samples/devsec/bus test)
- Add some reference documentation to the devsec_tsm_connect() sample
  operation to clarify implementation expectations (Zhi)
- Expand the possible Device Security Managers from only PF0 of a device
  hosting TDIs, to include Upstream Ports with downstream endpoints as
  TDIs
- Add bind, unbind, guest_req, and accept operations (Yilun)

[1]: http://lore.kernel.org/174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com

Launch of tsm.git#staging [2]
-----------------------------
As mentioned on v2, tsm.git#staging is proposed as a neutral location to
collect device-security infrastructure from multiple vendors. I.e.
collect all the vendor trees to resolve conflicts, code or otherwise.
For now it does not contain kvm-coco-queue, but am open to merging that
if needed for some device-security-flows.

Yilun showed a potential flow for the end-to-end API changes here [1],
do review that and point out where it may not work for a different
architecture. A goal of mine is to catch sample/devsec/ up with that
diagram to prove out and unit test the end-to-end mechanism without
needing hardware. It has already found bugs while revising this new set.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging
[3]: http://lore.kernel.org/aCYsNSFQJZzHVOFI@yilunxu-OptiPlex-7050

Original Cover letter:
----------------------

Trusted execution environment (TEE) Device Interface Security Protocol
(TDISP) is a chapter name in the PCI specification. It describes an
alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
software uses to establish trust in a device and assign it to a
confidential virtual machine (CVM). It is protocol for dynamically
extending the trusted computing boundary (TCB) of a CVM with a PCI
device interface that can issue DMA to CVM private memory.

The acronym soup problem is enhanced by every major platform vendor
having distinct TEE Security Manager (TSM) API implementations /
capabilities, and to a lesser extent, every potential endpoint Device
Security Manager (DSM) having its own idiosyncratic behaviors around
TDISP state transitions.

Despite all that opportunity for differentiation, there is a significant
portion of the implementation that is cross-vendor common. However, it
is difficult to develop, debate, test and settle all those pieces absent
a low level TSM driver implementation to pull it all together.

The proposal is incrementally develop the shared infrastructure on top
of a sample TSM driver implementation to enable clean vendor agnostic
discussions about the commons. "samples/devsec/" is meant to be: just
enough emulation to exercise all the core infrastructure, a reference
implementation, and a simple unit test. The sample also enables
coordination with the native PCI device security effort [4].

[4]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de

Dan Williams (11):
  coco/tsm: Introduce a core device for TEE Security Managers
  PCI/IDE: Enumerate Selective Stream IDE capabilities
  PCI/TSM: Authenticate devices via platform TSM
  PCI: Enable host-bridge emulation for PCI_DOMAINS_GENERIC platforms
  PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
  samples/devsec: Introduce a PCI device-security bus + endpoint sample
  PCI: Add PCIe Device 3 Extended Capability enumeration
  PCI/IDE: Add IDE establishment helpers
  PCI/IDE: Report available IDE streams
  PCI/TSM: Report active IDE streams
  samples/devsec: Add sample IDE establishment

Xu Yilun (2):
  PCI/TSM: support TDI related operations for host TSM driver
  PCI/TSM: Add Guest TSM Support

 Documentation/ABI/testing/sysfs-bus-pci       |  45 +
 Documentation/ABI/testing/sysfs-class-tsm     |  20 +
 .../ABI/testing/sysfs-devices-pci-host-bridge |  51 ++
 MAINTAINERS                                   |   7 +-
 drivers/pci/Kconfig                           |  28 +
 drivers/pci/Makefile                          |   2 +
 drivers/pci/controller/pci-hyperv.c           |  53 +-
 drivers/pci/controller/vmd.c                  |  33 +-
 drivers/pci/ide.c                             | 525 ++++++++++++
 drivers/pci/pci-sysfs.c                       |   4 +
 drivers/pci/pci.c                             |  43 +-
 drivers/pci/pci.h                             |  19 +
 drivers/pci/probe.c                           |  34 +-
 drivers/pci/remove.c                          |   3 +
 drivers/pci/tsm.c                             | 782 ++++++++++++++++++
 drivers/virt/coco/Kconfig                     |   2 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/host/Kconfig                |   6 +
 drivers/virt/coco/host/Makefile               |   6 +
 drivers/virt/coco/host/tsm-core.c             | 144 ++++
 include/linux/pci-ide.h                       |  76 ++
 include/linux/pci-tsm.h                       | 211 +++++
 include/linux/pci.h                           |  29 +
 include/linux/tsm.h                           |  11 +
 include/uapi/linux/pci_regs.h                 |  91 +-
 samples/Kconfig                               |  16 +
 samples/Makefile                              |   1 +
 samples/devsec/Makefile                       |  10 +
 samples/devsec/bus.c                          | 711 ++++++++++++++++
 samples/devsec/common.c                       |  26 +
 samples/devsec/devsec.h                       |  40 +
 samples/devsec/tsm.c                          | 218 +++++
 32 files changed, 3170 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 create mode 100644 drivers/pci/ide.c
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/host/Kconfig
 create mode 100644 drivers/virt/coco/host/Makefile
 create mode 100644 drivers/virt/coco/host/tsm-core.c
 create mode 100644 include/linux/pci-ide.h
 create mode 100644 include/linux/pci-tsm.h
 create mode 100644 samples/devsec/Makefile
 create mode 100644 samples/devsec/bus.c
 create mode 100644 samples/devsec/common.c
 create mode 100644 samples/devsec/devsec.h
 create mode 100644 samples/devsec/tsm.c


base-commit: 7515f45c165269b72ee739e6fc26cc2ef928fc1b
-- 
2.49.0


