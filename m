Return-Path: <linux-pci+bounces-44741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4CD1F3A2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A092330C70E9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F98927E04C;
	Wed, 14 Jan 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJhR0jjw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026926ED45;
	Wed, 14 Jan 2026 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398486; cv=fail; b=E182I3PEP3CQAh4JLCAQbsqbfnOXwYenLp0TgGWEqjpc3H2c8wjKvEXzaIYkWaVLhIGf5WE98zb12fmheIaQh1/JR18PyGgcWUNJEaScDn2Mn8LvBoeFTVwk+Ulg8vRKHh5DJWsVZe4cSFuVTHwNoVAHcd6/xS1sDv2K4vhdG54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398486; c=relaxed/simple;
	bh=LrCOhqYutKEfTfBb/nHOgr6A01fzqtVH+wYvANNRxsU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SxaveEFHUlOf92L/SLI7telhGTT/KJXENTlgGzgZgcZdwDOl4U9Cv+O7VXu+tfs9quW9x9m6bHK+8OjnHZb3OrY+ZvESMB335uqRhg6A/xWf3IUTmscewcMK4WXYmrYHDySfF6k36ITrQNao2zxNRDbJk/oqdUPRTJzd39vOkBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJhR0jjw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768398484; x=1799934484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LrCOhqYutKEfTfBb/nHOgr6A01fzqtVH+wYvANNRxsU=;
  b=AJhR0jjwZeiUV1RxiNXVFdzf5CTOuf45cLibeJWnC1Fo8FFihh28fXna
   7tAsAstgfRIGzlJwllyHJOndr1PrHsLzXLTz4kKxfnbGXtV6xJjm8y3DM
   IaW7vtur7MY3dCXGcFJSyPLR+vGpiYDPyGnapaSaomZUT5Pfo5r7ACezu
   VbKRYimKlHu4ng6SEqFqyt56G0vlBUZzDiQE9eRmUWIJ5Mntgy4PJkcgY
   6PuvN2SP4I1lxWuc8g9laaXqTw6RThG3UFtHxxcuB6EICiQH1/WUd7I2/
   JQG9IjzCTQzwtmf/DEkUpm3DQBh8b0Tzuqt/FjHQVHLu2ZYPNByEqt3Z2
   Q==;
X-CSE-ConnectionGUID: 2OV3nZCiThOEmav8MRcKeg==
X-CSE-MsgGUID: ju1Z58rpT4qN7tgvqnk/tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="81058217"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="81058217"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 05:48:03 -0800
X-CSE-ConnectionGUID: 55TF+BOoQMOL1UemVsiHTA==
X-CSE-MsgGUID: W0QuZw9lSqKmBJMqt2ZgrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204734267"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 05:48:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 05:48:02 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 05:48:02 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 05:48:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb+IOcAtQYxDpNpZhxWv9MrrRtXyfgcd8yQE8BOLQqpdOOer7AihhuaZGxerLI/ABpYKbgNMDphzvZ/aCrZ3X2UYtRvTWVtStGBhTVeNk5A9vxvOpjBdKAOhQRupq3iI7UBaWzqBMhbEO2WLapujDpEJF74r35J3SLXrq2uZPcICUPDcLPBpL3TGs0tnKSY7dihEpUWWqYWdYkHszSO1FRq8amCWCSadddNtMtSH+G/HAfSN68xfUQSeXjytjtEITsp8nSoO9BMRs9kGVweemQJllhn4WfzucTBv4C5vGKicu9Mft57Z8SZYin3hZpGHujPeLu3tRoHxqBtwM0uFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdXhwrm8C0coZFNQ3q3k+y5uRk8JiF2sqmFXmD+AWKc=;
 b=Fb6OLBffxaqRJk68DMiXVho/5cw3L0cgm0hhr0kqu9oftAyrlEv4MnnUoC/H0okFAxsnws+vThDRc21bz+5K5S1f9mVuwSdttFIU/EaQKF1NydZqg/F0pwz/nE7P7sox7R6yi/pWXaTwNSAQyT2ypIVyfvVUupEZYQKBtwWr8LnMzQsedH5yzYCZjcSD6ysg6ZjHfc3R8YazLkRUgmFQYJ2AMlIpXD9hylA2zAOVSQlh0ooE3osicPfvuscTTS/iIHoTTRJA2pFtlxAEF1fNIXsLcTXj5tAuJLoKYVvAQWW3s2FgO3l9kGaK9iLg+xNtBcwdAcfsZJ+/uWqSToEBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by MW4PR11MB7080.namprd11.prod.outlook.com (2603:10b6:303:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 13:48:00 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 13:48:00 +0000
Message-ID: <70d581d1-e660-43dd-995e-fe9d48642427@intel.com>
Date: Wed, 14 Jan 2026 19:17:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <varun.gupta@intel.com>,
	<ville.syrjala@linux.intel.com>, <uma.shankar@intel.com>,
	<karthik.poosa@intel.com>, <matthew.auld@intel.com>, <sk.anirban@intel.com>,
	<raag.jadav@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
 <20260113164200.1151788-16-badal.nilawar@intel.com>
 <dn4s77miw7ts7aqqrzltqvlt4qmdb5ego5vkxvxcq7ns42fixh@vubkzxtgverr>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <dn4s77miw7ts7aqqrzltqvlt4qmdb5ego5vkxvxcq7ns42fixh@vubkzxtgverr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::10) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|MW4PR11MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cdaa11-3659-45de-939c-08de537387c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STZ3L0JmeG1FSjFDMDZLeitkRlNJYW1mUzBPL0o0YkxiMy9RM3l3Uk1kQ1dh?=
 =?utf-8?B?Qkt3bForVW14Z01NL1RmVkhZdndIaitmcnpZelE5b3VBT1M2NEpyZTBzVEtM?=
 =?utf-8?B?YTlwMGtUdm5QUklLVlppNU1pYndvaldmTUVzNG9iV1pQK3BxeFUrUjgwY0Qy?=
 =?utf-8?B?VWJRQXd5VWRIb2c0MG1yWXh5OW1wNEE0UW9hNU44RWF4SEk4RktCQ3poazY3?=
 =?utf-8?B?QkFNTXpZWkgrcm1yTWRjb2NEV1hESmRrU3pFMFhnU3NJaUlKdW01VmZmb0oy?=
 =?utf-8?B?cjRWNkxnWkJNb1ZldXptTG9HR1c0bWYveFIxM0ZOS2dvSTIrSW5Yb1VFYjIy?=
 =?utf-8?B?UDlvUDlKMGdPVVlQMTBjM1BUQXdwNTVlbTQ4VWFzcFBFSWxkMlY0YVdBYS84?=
 =?utf-8?B?enJMUElwT2lQcnJ2bXhKQkxEMmFqOFc5b0NYdlpOWjhyVjdwalJsUy81TEdL?=
 =?utf-8?B?MG54SS91VVNsQ0NBY3lwWnh0UkdQY1ZLbGxRa2Q2bFRKVmRJVWlFT2I2bVB4?=
 =?utf-8?B?c1VGZXBTREo0ZG42VFZYSlpLOU9YeXdLNXgxZHFMT0tXK0NNSWZRZU5hN1RG?=
 =?utf-8?B?YzNsejFtUXlhbVhMZGxSbC8yK04rdkJ0MHlmZnA4NEQ0ZVh6Z1JWdGhWc3BQ?=
 =?utf-8?B?amgvV1hEOXkwbmdhOCtPSjJ0cHl4WmtuOExDYTRUcFI2SHZENDdUN3h0Wlln?=
 =?utf-8?B?cGIwbC9qd2U4S01taGs3S0JBU3dJNkxoMHJVdk1CMTA5QkJ4VkNxZDBjMHhO?=
 =?utf-8?B?R1N5dDBlUVBMRjNhWkp5U0p1MGFLSURjOE01MHZFR2l5RWhDNFBDUWhUSXND?=
 =?utf-8?B?Rzl3cjg2cDQ3dWZ1ZE0zbHg4dExDRG5razlPUTY0UGpRdm9WRndIV2E2RWRz?=
 =?utf-8?B?c1JzUkViZ3A1NUxJdHRoMVlIV2pkU1pLR256cEdIVndWUjJyQVdKeXBxK0dY?=
 =?utf-8?B?OHVuMytYZEtTbm1IS3o1MDdGYkYrTFVZVnBWbmlpWUlJZzNKam9sYm1JSVpN?=
 =?utf-8?B?bjRjV0dxQjFoOXFKdjBWYXo5S29rU3poeVFVTXJJNkNWdWNYMzlONGE5S1ZR?=
 =?utf-8?B?M01mOXhraFFObW9Ca3g5aTE0WW1QajFBUG1aMTBZRkJKS2lRZG10ZFlPUU1o?=
 =?utf-8?B?cnlUc2ZIcFd5aEdmczBRMnJaMHk0VUFWdVlQWGlFUDdYeUdkdkl0anB6ZkpF?=
 =?utf-8?B?YTloS3pVQWVHR0VIRWlyc0VZM01RMnROSWl5dGM0K0JQSDh6MEV0ZktUdGlH?=
 =?utf-8?B?WkRmaDNOOVh5MkFBaTMxdXVCblRWQ3FUUFljWUpEUWlhc1hLRUU3RmdXc0dx?=
 =?utf-8?B?emk1bFNpWVZvKzZ0Vkd1N0lVZCs4MlhZTEdla08wNVpOajZ1cEcwejNvblJk?=
 =?utf-8?B?Nk81L2dUdjJZM0gyWDFmOUNmTjFZd3NnU2RsN3I3NnVNYzBlSmU5RlZzNUtr?=
 =?utf-8?B?RGk3b3hpOEtXRjRXQnczU3lrU3I0MGlDOVBHRVkzOGZ6U2JnTlNDWHdnblFh?=
 =?utf-8?B?U3N1cmhqV3dja3FzYnhhejlLUCs1bDlHWVRPSEltZGdGVnBvelRSU0M4MXNC?=
 =?utf-8?B?eTl6T1o3QmFiL2oyeVIwY3NFeXh3TUFjZUxzZ1NKTUU2L3BmWTZWbEViemhx?=
 =?utf-8?B?dmJEVEN1NE53UzMydnZEZGQwSEdMbEN3NXVtZnF4VGNVVGlCWjBnbitzZlpp?=
 =?utf-8?B?enhsNUdxTzhGOGZ6V05nNkJnZHVaQThnTkdVdnpuK0xZTTFyZVdocDhIb2tZ?=
 =?utf-8?B?TzJBU2lzbUxhYTZhQmljd2NYRWwveEVkL1BnTDNXQTh3KzJXa0ZlNGNYejJ4?=
 =?utf-8?B?N0Q1OXFnaG9DRnRPMzA3QnJYSGorT3JxNUxvR3VwaUJZbDhoWFBJdWY3WGQ1?=
 =?utf-8?B?TklEQXdDSTc4a0x3aGlLQndhSjJkeU9JZkx5d2JpZ2tFQlNmYUJEOHFtQXc2?=
 =?utf-8?B?U1kzYTRDVWlJdTMrTTY0aFJhSllUZ2JaYlVxSHVKZGVYLzc3K3JydUM5NUcz?=
 =?utf-8?B?UnFCSlVUdW9FNXNkMldIY2N0bGpjOTFjQjM5Tko3MUdrZW1DaWRsNG5pdU40?=
 =?utf-8?B?bU1vL3ZDcTlOamV2VVpxOUtyREJscE1GUCtoQmlMdFJGR0ZRdm9rTS9zcTNR?=
 =?utf-8?Q?k13o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmYyd1B1TFBMbGpoczQ2STNXakdqZmNYV2ljQ2lpVjR3V1NEaHptRVhhNHVU?=
 =?utf-8?B?Ym15QWNsc2dhR0VNTFliVDljZkdEbStHdHd6SUE4Sm9lN3lOQldrVmh0NVhP?=
 =?utf-8?B?T1lOQ2V0U1JyMGpML3BVZjJlOXZiaUQ3Z2xPamJ5dFZlOHNETm1PRUwxelhh?=
 =?utf-8?B?NFRWSjZuYlhzUURQUktmT3dTODFlb2F0NkM0cG1Nd050R00zUEIyV1c3M01i?=
 =?utf-8?B?V1hjOHdGanl6VnBYcXhLWEo4UEt0THgrYzYyV3F6RHhQcW1XMWV3VDVxTUdD?=
 =?utf-8?B?TzBhaGFwcnh6c1I3UndzQUZBelVHazA4V1RPYUM5NFlwWXQvQTNnQ3NsWC95?=
 =?utf-8?B?SCsrUHM4WHJsQTRQNTFZZjlmd09PS2IrYkdGT1V1NC9QaTgvK2ZycW12Vzdm?=
 =?utf-8?B?cEJIMHdSbzI4NFFWZ2V2a09ZL2NMQktvRlZzYWpvM0h1YjJGT3pNVDFNTjVr?=
 =?utf-8?B?NHdUb1g5NXZERFEwWkJhSS9HQ1ZKbWJ6VDl5c1RGVzRPaCswcTlpaDhST0NL?=
 =?utf-8?B?bU1DKzlhMGR5UmpPWjVGNm9jT2JCKzRCRXNIQlNIT05YV092UGFndWJJaDZ5?=
 =?utf-8?B?ZnZ3TC9TVDZVallqU28renh5YlQwOUJRK1llTUlIcGF5MlVZeWYvSUg3T3ky?=
 =?utf-8?B?TjYvbFAxSlB5K2JSNFNwZmpLbzFOSzF1SHV4NTd0bXIwaEtITjNHcHBFQ1Rv?=
 =?utf-8?B?RnBFOWdNcHE4OFpXZlNiWUtSYk56YWZhOFdtUjQ1RWpTRTByMTVlVHFFTTBJ?=
 =?utf-8?B?R2tIcEpaMkdVVFpnMDltSEwyZnh6K0xsUk9yQjl2dVZDS3NrcTRHNnZOSVR4?=
 =?utf-8?B?b2lkZE81VXFZbFAvZVlrSU9KSGhRdGlHeCs1Z0ltaXYrQXVlR3BJb3p5QjJi?=
 =?utf-8?B?SzJNTjFRakM2K3ZiR0lObnM2K0sxbG1yV293b21MdjVFME1MYjlPc0IyMTFN?=
 =?utf-8?B?eGdMTlN3VW8wUThuVkFEK3NvNDNZWHRFUTNpR3BNdzVnb21mY1F5WFIrMmZo?=
 =?utf-8?B?WmN5WmxEcWkrNmkwY1JEYllVeXZ4aWcyREZHMjRHWDJhOHIzUW5nY1lpSVZN?=
 =?utf-8?B?ZmVpek1rcTRzOTVneE1qZW1IU2w2YUpDV2tsVjhQeTdiZ3owOUFGVkpibUNN?=
 =?utf-8?B?eWN5N1Q3UGc4dHZQelZ3REl1aW5Nam1LaThjY3NDR0VZOUpwT3I5L3YrcUlr?=
 =?utf-8?B?Y2VKb05OYlZaMlRXYW1tK3BMUDd5L2ZNR3F0QTJQb3NJNDJuRnQyTkhxTFA2?=
 =?utf-8?B?ckpvQlFrVGdjV3c2ZWQ1a1ZwS09tUWpCYklDUnk3MEY0ZkVOcXB6UG02aVE4?=
 =?utf-8?B?WWxCYVV4TUxFZUdDSmhUaEpkNkpCNUpmdmhLd29HQzUwYXE5WktWN0pLa2pm?=
 =?utf-8?B?ZGpCdE9NTU9KOG11TGI5dTh0NTNXbzloZUlIbmRTYy9EZWpPdTRXb3JRZjZK?=
 =?utf-8?B?azg0MFFmcTY5V3NpUDhqQzZSVGhkaHlFRmVocFdYSjdDeUNSNGlpWnRLQ0NX?=
 =?utf-8?B?SUlBT2JOZUsxWnRDaHNTWjJ2Wld2ZVJDdEQrVXpRcDZ2RUY0SXZJaHpUb3Jj?=
 =?utf-8?B?ZG14VkgvV1ZsSUo3QktCVngyKzRVOHp5TldZa3ZLSHVRT3NCUXZJZGlyeHho?=
 =?utf-8?B?cllXZklJWHZZeUR1dkVMNGVEaTJXREJMK0dBb2dHZGpGZ2tXQWNYRmdyTmtr?=
 =?utf-8?B?SFRCYWplSnR0czV3VDBUanZSTHl2S3RJbFVVR3JHTWRrcVV5YWZiT2p6b1hp?=
 =?utf-8?B?RGpWOGI4eVdONzV2MnlqaEttNnFiVFdxTC94Q1IvVGtHak1BY250V0puUVZZ?=
 =?utf-8?B?bDVYbndNcXlXa09wZEV0bkEwbWhlOHJyOERzYUtIUk5YLzdLa3ZUV0R4Y1pI?=
 =?utf-8?B?NFJnR09CSGgzNE1DUW1QZFU5LzFKNnlvRDg0SzBBR24vYTU3dkFnMCtnUUFy?=
 =?utf-8?B?WTFXdXh2ZTdCYVN3VzcyWGlwNFR0bnlXSzk2cFBTNkYxNjFiMTlndlk1bVk5?=
 =?utf-8?B?U0lQeHlXTmxoZU1aWEZmOTUyc3ZNM2FhbXA4d3Q4b3JydU8rUnIwZkpEU0JM?=
 =?utf-8?B?UGxtaGt3NnpsWEFhMGlSUGRVNVI3dVp1NmNGdUFTelpPVW5PVDlaRVBVaHRp?=
 =?utf-8?B?alY4b3huS0d5cGtrbHZXeHNrSVFNbGhrbXdIeU0wSVd3U3dPdWV2aDRtWGJD?=
 =?utf-8?B?dEdycXpUY29tZDRuVm9PejA3aTR5VmtHRUs1MFZ3a3dQTjZVTDN0a1JhNjlD?=
 =?utf-8?B?aktCMG5uTk1maktrYzFCVGh3V05hWmJBWEpQSWRwWkNyc0R3Z2U5WkpMeFZ6?=
 =?utf-8?B?ZmNMSVNvSzNmV0NLd1BSSHZIUFBEMTJaREF2bm16YUlKNS92ZWgzZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cdaa11-3659-45de-939c-08de537387c3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 13:48:00.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8jmQbq1nAEucm/QeSFCr7AnsV4viTbucCE49cLXRc8PtWDgAfs6WCUL4YWLeyQSSGd+4pkPPBNHcVzQiQ/hSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com


On 13-01-2026 22:34, Manivannan Sadhasivam wrote:
> On Tue, Jan 13, 2026 at 10:12:03PM +0530, Badal Nilawar wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Implement _DSM Method 0Bh as per PCI Firmware r3.3, sec 4.6.10, to request
> 4.6.11
I will fix this.
>
>> fixed delay in timing between the time the PME_TO_Ack message is received
>> at the PCI Express Downstream Port that originated the PME_Turn_Off
>> message, and the time the platform asserts PERST# to the slot during the
>> corresponding Endpoint’s or PCI Express Upstream Port’s transition to
>> D3cold while the system is in an ACPI operational state.
>> Host platform supporting this feature ensures that device is observing
>> this delay in every applicable D3Cold transition.
>>
>> Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>> For VRSR feature with PERST# Assertion delay device will get enough time
>> to transition to auxiliary power before main power removal.
>> ---
>>   drivers/pci/pci-acpi.c   | 60 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |  9 +++++-
>>   2 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 645d3005ba50..73eaee20a270 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1554,6 +1554,66 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>>   
>> +/**
>> + * pci_acpi_add_perst_assertion_delay - Request PERST# Delay via ACPI DSM
> I'd name the API as "pci_acpi_set_perst_assertion_delay", but the firmware spec
> calls the _DSM as 'Add PERST# Assertion Delay", so I guess it is fine.
>
> But the description should be changed to "Add PERST# assertion delay via ACPI DSM"
Sure.
>
>> + * @dev: PCI device instance
>> + * @delay_us: Requested delay_us
> "Delay to be added"?
Ok.
>
>> + *
>> + * Request PERST# Assertion Delay to platform firmware, via Root Port/
> Here also.
Ok.
>
>> + * Switch Downstream Port ACPI _DSM Function 0Bh, for the specified
>> + * PCI device.
>> + * Evaluate the _DSM and handle the response accordingly.
>> + *
>> + * Return: returns 0 on success and errno on failure.
>> + */
>> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
>> +{
>> +	union acpi_object in_obj = {
>> +		.integer.type = ACPI_TYPE_INTEGER,
>> +		.integer.value = delay_us,
>> +	};
>> +
>> +	union acpi_object *out_obj;
>> +	int result, ret = -EINVAL;
>> +	struct pci_dev *bdev;
>> +	acpi_handle handle;
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	for (bdev = dev; bdev; bdev = pci_upstream_bridge(bdev)) {
>> +		handle = ACPI_HANDLE(&bdev->dev);
>> +		if (handle &&
>> +		    acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4,
>> +				   1 << DSM_PCI_PERST_ASSERTION_DELAY))
>> +			break;
>> +	}
>> +
>> +	if (!bdev)
>> +		return -ENODEV;
>> +
>> +	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
>> +					  &pci_acpi_dsm_guid, 4,
>> +					  DSM_PCI_PERST_ASSERTION_DELAY,
>> +					  &in_obj, ACPI_TYPE_INTEGER);
>> +	if (!out_obj)
>> +		return -EINVAL;
>> +
>> +	result = out_obj->integer.value;
>> +	ACPI_FREE(out_obj);
>> +
>> +	if (result == delay_us) {
>> +		pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
>> +		ret = 0;
>> +	} else {
>> +		pci_info(dev, "PERST# Assertion Delay request failed, using %u microseconds\n",
>> +			 result);
>> +	}
> How about:
>
> 	if (result != delay_us) {
> 		pci_warn(dev, "PERST# Assertion Delay request failed, using %u microseconds\n",
> 			 result);

Kept pci_info as the delay request might not always be honored, and it's 
up to the caller to handle the return appropriately.
For instance, in the case of VRSR, if the delay request fails, VRSR 
won't be enabled.

Thanks,
Badal

> 		return -EINVAL;
> 	}
>
> 	pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
>
> 	return 0;
>
> - Mani
>

