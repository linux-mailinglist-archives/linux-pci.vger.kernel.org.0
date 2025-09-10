Return-Path: <linux-pci+bounces-35791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ED9B50CE6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 06:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B51BC2570
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57821277CB1;
	Wed, 10 Sep 2025 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WObQvhYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1725A655
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479577; cv=fail; b=f12vJa2NAj+G9tVkU/teIiKk+HSPeQ/N7yHcV2fuhwFJkveR2jBVAJzrnw0HV77VM757phKmnQdXb0RFEvVEGWIgng59w2YCYGRju7VYJgHWK9+Yf4NklNPyNOEbFL50ijpEjG42fa/Mi5zs8cNco66kAYtl8XLywVGvO26cRcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479577; c=relaxed/simple;
	bh=VujPSKXL6alt5weU/vU8znT1zTAGrD5XYCCHBgrMM6U=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=USExehAkHqbhIufpgmSecNIwENFWySe5GUW+zekPQXGr4/s0NsMVbRHNVuowQ08Q66fMeUod5M7vyDu2ss7dNXRO7xhKYVVbkOW7dFdqbXov8H8RU+/sZEF7aUUsoWBsA+viYj8O2hpNEPmJZLRZQRXXbs9dFhwdGd4zfGp+5B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WObQvhYs; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757479575; x=1789015575;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=VujPSKXL6alt5weU/vU8znT1zTAGrD5XYCCHBgrMM6U=;
  b=WObQvhYstK5aqf0IYRiVg4vODKPTQTIPAbiZN/MLYxHu0izg9eJKL1M7
   gTgyxBipjHf/msHwTf5itIKORbWZl/E0/TAbLbWvE6AIDGeWNxAYdU0Cd
   9v0bpPSwuPxStAh+osX96tLCan+eFpvzsO69L90dmEFxKcLr2WPl9FXuR
   pMyOc9+7g0TGmo4Sw/lavf2v7FIXHiZlgbjZhsPt9JN6pgABFRZ2OF/+9
   IfwWgqCEHml5ru55B3wE9atl1G29DdSxcXDdyEpjcQBz3Z3GC5pUmZCMU
   qm8UB7LlagTOaqKo98qUuwjDtq+/sLfhZCyghAz3CSA1OUOqKfJBoDIDY
   Q==;
X-CSE-ConnectionGUID: gPL1ZkpeRK6VupC4+YZ8Sg==
X-CSE-MsgGUID: 7CDA3TzNQ+e0Wt78Zz39bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="62409822"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="62409822"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 21:46:14 -0700
X-CSE-ConnectionGUID: vATXH0K/TWCOJRHAvlTBMA==
X-CSE-MsgGUID: zJSmSMbiR7qj+4pPYw/HFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="172855912"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 21:46:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 21:46:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 21:46:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.53)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 21:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMKnXc/YZOf8hUOJ0Y5rOZ8CqwI9lUQYF/PcOy9H/lvyhDTXb/Hqp66LCqr26hY8CEZdhOis1aKOf3Y4+ybc9MuONUYCG8JBbzvlc1FuQv6vBAWoVN9Pkwrh7SmNzovLNJIpWEAoCUyFvQGr72UzvW/FO+dctojjJp6egM29zdoVJSWxYmeXyvjqMarpmGEYqVoTEO2O1rSq5v2trvdthTKCz7RMn7ni1j5IGtEzI2WON696zRip/QqNb1/3UfSW+4ieEQ0GIm59XrTdVXAINJ2uduIrW+u83KA/rAVY5BADivETxNHRzBy/MbzgJbKpg4W/R4P9r05yzYK3xtwnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13TRv+dJnJB3CdpEAlRGac3bzJGvzfMHxS/OAlhk5vA=;
 b=SXYOnd+qC9zvnTMaf9tY5vErt/Mpk8htiffjQtcVaEj/VRXyFsksBNBWOR8mpl/BrlUQRSSUx7bRK9mSJroM+8Es6DKUROKdeII/shW+QglPz8alwUc8bkJjNk1z5xpn3j4/JEgbQ39L+9qiMAOJre7BH7zttDomKdmGWY27eEDoADlKqF2Yd2Z9kOjBeaDPgB+CcKB2xNg6dvOdtRu0XdX5j5dpBJoPARQBu15IqNAa9IFLhyuLlTFvT0/MRkr0SfnwDkpnNJzTAVEIf+dyCs97yFexF2dLj2IW+vZA5OSHtCvJvEL6HTtxDlyOpbGdembssx2JAtB3JjW9i6UB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 04:46:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 04:46:10 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 9 Sep 2025 21:46:15 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>
Message-ID: <68c1029741e87_75e310048@dwillia2-mobl4.notmuch>
In-Reply-To: <ccc6dc78-4338-41e6-b8d6-fedbaff4cc8e@amd.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
 <ccc6dc78-4338-41e6-b8d6-fedbaff4cc8e@amd.com>
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3e493a-b44b-483a-f6fe-08ddf024f668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFNGb05BeWtxSzFqQkhOMy9rUDFOa0FMMDdKS0Q5YzhmV2RlbTZqQzJNWmc5?=
 =?utf-8?B?MTJsckJhV29qMjFmRnJkRzYrbmRlQlNHY2lWWlI0SnpNMVZpdUZKZEJpTTYr?=
 =?utf-8?B?Z3hvWVZxV0U0LzA5SFFnTXZIbVBaTkxxSERkSkZxOVFhMUJvMEFyNTBqSUd5?=
 =?utf-8?B?eHE1dWdXcEVMcHZ0bHRhdWJDSVBMUHdNODF6UzdHZGQyc1VLWEIrdVJNQXZv?=
 =?utf-8?B?c2Jla04zRWZMMFlHM1RvL0cramZTSUxoSnMyRFVhMitER2t6di9zRFp0Q2Fq?=
 =?utf-8?B?dVpXenJJd3FnZjJ6NW56cHovS3pOa0ltMVFBLzVULzNEQjVxQit1RzBTOEhB?=
 =?utf-8?B?UzlkeEJZbGpmcE00MDVOUFg0c291S3ZESkcxUnB5QktmYTFoMnRwVHN1aUpr?=
 =?utf-8?B?c0FtUjZUOXhBWmpYZ2d2R1FvWnVtQnY2TEU1ZlVZaUVmMUwwY2RDaUlDQ2Uv?=
 =?utf-8?B?cDl5ZlBiVTh6Vkdpc1lrNTVxL0F2d2czLzhTMzc0eUJSRS9PdU9zeDZVQW1F?=
 =?utf-8?B?dTlLYU90Um1YWFpvbmdxY3pldTh0VStuQVpBb1kzUkZhVlZrcUsyVVZxZmhv?=
 =?utf-8?B?aUMwc2hmaWdNc1FNbnlyVXpwSTVRVWh6TENyb0wrdDMwS0R6ZWFya3B4dVV0?=
 =?utf-8?B?b2Y4MjhPSVVkQnF6d2lXeHdMTjErdXNyL3FyUTV1Um5MS3A5MUE4RG9WOE1h?=
 =?utf-8?B?RGR3YWJsY2lHRFZOS1FpcEtNUE1ROUdHbkZQNzBvRjZlRDd6T3FlL2tHb2Fs?=
 =?utf-8?B?cUhiNDY0S1FNUmhDVzBYeDFFemQ3Y2hyT2IyVFIrMEkwLytYelZOUFNkZnFV?=
 =?utf-8?B?ZnVDVisrMC9QYXQvUnNhYWRqODFFbHMrUUViZHRvcWR2QVNZSSt6Wksvdito?=
 =?utf-8?B?aHZPWkN4V2RUcU5NOTd2K3oyZFVDd3FzbGduTlk0Z3FFRGpMK1I5ZHp0OFpT?=
 =?utf-8?B?eFhOZEFRS3k3bkRqTzRKMXZ3S21uTHhWWk8zcFQvR0tkd3NHS0VVKy9xN1lZ?=
 =?utf-8?B?dTdwRzFJbzgxUGhOOXphc01oSHFVR3ExTWUxMXppOVV3UXo2QkUzREJ1SEJS?=
 =?utf-8?B?MytjKzNET2UrdUFMcnB2aFE4OFZWYzY4a28wTEJsV0xlN1ZxRUJ4SlRSTXl0?=
 =?utf-8?B?a1pUT0VPUXZleEtHb0RSdC9UN2s5SHN2VUcwb25oM3AyQ3A0YnB5a28veG4v?=
 =?utf-8?B?aVgwSlFSZmc0SWlKLzZielhPaDl1dVU2SG9udXV4aVlwWkFXc0s1Rm9CZXht?=
 =?utf-8?B?aEVQSi8wamVBaUxhKzg3TDF1dmpTVGdWMDcyN3k1MWRqNHlYMUhickk5SE9Z?=
 =?utf-8?B?blFQOFIyUUU0NWVXejNYV3dqQkVIS0ZVUHRKZUlPRzRPUWcvRUdka2ZDdkg4?=
 =?utf-8?B?TUZTZ3A2d1E5K2cwVWpuendMd1BXcG0zMmR0RHJDUHEyV2pwZ2RsQXhqbEQw?=
 =?utf-8?B?SEtYWkZoV3FLZXcrQW1kVkZuczUyNmtobEVBekxqUkFINE4vbTJDNHZSTGFn?=
 =?utf-8?B?S0pPNzlqYUlHZ2tQNTBQV0didW9JTHZXOWN4YW5oUHpTUW0zYlpNUU9sc21o?=
 =?utf-8?B?Y2EyT1hVSUluQWRSZ1dvZ1pGWU1KdlRyZzJIVDZra3IvOTVrVURmdWNPM3lq?=
 =?utf-8?B?eWVhcWtOOXNJWjk2VHNHcjRRdjB6R3hBUFU3TEhkdHd2NEZIRmNVSitkc1VC?=
 =?utf-8?B?dXByQnZwaVliRGI0eERuZG4wcmE5cmN1WVUrT3VkMWp1Z3lGam94UnNjYkdS?=
 =?utf-8?B?Qk11MFFHY09YSnNyeERLcDRVUC9RSUNPYysrNkVIN3FhZHQ2QUFweitTaGpP?=
 =?utf-8?B?VHZ3eTRkSWlWWk00ZEp2SnJnTmNLRmF2SGxCS1FBSTUrZXZvbEZjVTBWV0hl?=
 =?utf-8?B?V0p4RGtKS2JESUVJMGdQV2FOcmZMZ0MzRVRzUDc3eW1HZFdEcDhTZEk3cGd6?=
 =?utf-8?Q?57HGB3alr3Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WngzUzlZRUROcjduNHV3ODhMN01CSzJFdmJsL2d0NjRjNGZGREJMVlBmYlF1?=
 =?utf-8?B?bmxoOHdlR2FMRm05QzhpMTUwZm9xUC9tK1d5bDhNNmMrV24xWGVWcmx4aWcv?=
 =?utf-8?B?TksyQVJXd0tKbkV6UklVR3FPaDdNekhIckVvM1N6R3hGQUN5RHRsWTZRdTE2?=
 =?utf-8?B?R3RoOXRpbDFyWVlubkRHL1BSV3hOMkx4Z3BSK3JEQzVWaE9VTG8zZVJuWHBT?=
 =?utf-8?B?U0g2WGZvcHV3Qjhja3JmZ2l4MWxyc0xDMzZRL2dINDJoRGpzeWN0NDFyVWF2?=
 =?utf-8?B?UkZaWS9SUlBmbE1LTWZCT3I3S3lQeHFBT2ZMUkRmd0h5bVlzcFhBVm5ZT2c5?=
 =?utf-8?B?SlRacTlUbi9PZGVZSGloTVlKYmRLMlhWRnB3NDRGa1BtTEwrZm5pZVZhK3g2?=
 =?utf-8?B?VUYvZC8zZ2NMUlkvdlZ6SUdneFUyVlFVY2ZXU2FKNGVCVFUzbkYzbW1RSzZV?=
 =?utf-8?B?QzU2T2JxQVR1QUtxQXY2b0s5QU5GVHg4T04rVVB1Nkl3QW5HZTE2ZHBSTEV2?=
 =?utf-8?B?emd5RmduRUt3SGRPUS9wYjE5QnNkaGVIM1pSYWViZEwyVnJFR3NjNkpmeFpx?=
 =?utf-8?B?QVpDRnVDK1BPQTh5bjZGUVJSeERuYy9vTVVqNUoycStKM0VXcjZiY2h3Tlpp?=
 =?utf-8?B?UTNIRHNJQXRvRTkwN1J2bEsxc3B6cVl5VUFmN1VTaEVRSnpGV1hDR2xOMzVV?=
 =?utf-8?B?TlNYWFo1eG5uQ21tV2RPMVVjbW1DQVBCMHJwckY5T3JZdzRSMDQ0UHpWYU5z?=
 =?utf-8?B?ZDZ5ZVpkODhkRmtKQTVDQ2d0a2J3cVVGQTZoNFY2Tzh1UVFuSHE3dllrMWND?=
 =?utf-8?B?TFBHeTVjQ2dZSWdkcjdIalpzN2pod1Bhd1kwYkhyOUpEbC9zR0dVb2RvcWU1?=
 =?utf-8?B?c044SENBajh3RTFENzdCVndVSzY3alNCTzB3MjVva0l5STZqd3hmY1pUK3ov?=
 =?utf-8?B?YmNsb2d0TThxc1AyVUVvSUVUMG02WEFVYldsOXNrS2hnTHdDTkZSZDhYMUxj?=
 =?utf-8?B?T3ErWUYramJWa2tsZlg3b0dGSCtsSVNhR0pGUWIwam9EQ1M4bExEejlvZmpC?=
 =?utf-8?B?MlNSa2IvSEZvTUtPL3crNVhUTUFNRWJmU2NRZ3pZdkVMN3lSYUdyR1JqSkJ5?=
 =?utf-8?B?cGJ2N3FELzNYZEw1cThSOTZxUmRVaElUcG1ZVHIvR21uRzNEMjJwUGRFY0o2?=
 =?utf-8?B?MjlEYmhqMVZOdTlvL2dTUExtRTNuK01CbVB1bjIvZCtWNFBUdUpTR1NOaUlw?=
 =?utf-8?B?Z0lHUXgvYnlxTmw2Y3VXLy9DVGVyQ0Z4cit2WVZpUGI4dVdjZnJycXBVZGZH?=
 =?utf-8?B?K1NqdTFnWnRvenFaMnpaY0tkaDc1b2dKazJ2MHd2VTZ1bnZEZnMwSkR4MEY0?=
 =?utf-8?B?OEVLQTE3b0J2czZHR2ozcnBCNGR3WXJLMmxwQ0VDdmkwcXp4a0YrejB5L3hw?=
 =?utf-8?B?b0huMU8xMmljaktoYTROV0k1WlJFY0p4OExkc0RKZFhOcUxWOVpKb2NkYTBa?=
 =?utf-8?B?bXNRSzZHOXFQWUpKMndmMmtZN0E5QVpoaWk4cC95Rm9NYktuQUxENTNDVHFX?=
 =?utf-8?B?YmxkVk0veDRWSlhiQmYxam5sMmVoUXF5ZFpiejVLZWpJYmVITWpjMW5FQjlu?=
 =?utf-8?B?L3VIR09ZYmhGQzhOUEc4R2VSRzdkTEJNRUE3cWg5T2FORjhrZ1IrWFRYL2ZE?=
 =?utf-8?B?eXdxcDV4cW1kV2dad3BQMTZxRFdOZ0VKbStESCtkdkRwQWV0Z0xtWUtqQXgr?=
 =?utf-8?B?ejg1Ykw4VFFxeGVNVUREQm1YZ1d6cW9EbXdnY1FJM00waklvcTVPVDViSnVU?=
 =?utf-8?B?bkNqZlVzM05SMGZOaHd3cndWMDg0VWx5dnJRcGVBV2FGL0dGNk91SXFRQmhQ?=
 =?utf-8?B?L1N3SndnWm1ORnBqVnZoRGVJcG40OEFJelNWaDFnRVN3a3dqU2VmOWdXbW1Y?=
 =?utf-8?B?UVkwU2hSd2RiL1U2UzlkQWI4eG1yblZFNDhhREF2eTl6aFpYUTBYNSs1RllC?=
 =?utf-8?B?eVNRUEN1YWJ1eVhuZTJVaVp1V3hOYW5PbzhxdUpZSjRneDlZWmVITm8rV1VZ?=
 =?utf-8?B?MjREM1BIdVZ1cXlGdzE1NVN4SzdWZzRiR290Tkc2RXFYWTEyS29mNGxKMnhN?=
 =?utf-8?B?SmZVVEh1OHRidkQvT2NuZjB1MDRRbWxhWlBpNGVOT1NtWjZuaXhOdGpGREFP?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e493a-b44b-483a-f6fe-08ddf024f668
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 04:46:10.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3o7S3ZGKZDCm1XtvKtqefRKQjkkH+tt9TpxrtoUEC/tXPJgjtsYqjj0BoxaQCxJ7FGUX8Zxw5ifxStPtlpbMQiBMW4untuGfvxtgZzVf7hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 27/8/25 13:52, Dan Williams wrote:
> 
> 
> I suggest changing "pci_tsm_{bind,unbind}()" to
> "pci_tsm_bind/pci_tsm_unbind" or "pci_tsm_bind/_unbind" as otherwise
> cannot grep for pci_tsm_bind in git log.

Easy enough, and will change, but FWIW:

$ git log --grep pci_tsm_bind
commit a8c148ed753d640b5e5f8d1043d9f9d6188436b4 (HEAD -> for-6.18/devsec)
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Mon Aug 18 13:59:26 2025 -0700

    PCI/TSM: Add pci_tsm_{bind,unbind}() methods for instantiating TDIs

...due to pci_tsm_bind() in the changelog.

[..]
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > index 092e81c5208c..302a974f3632 100644
> > --- a/drivers/pci/tsm.c
> > +++ b/drivers/pci/tsm.c
> > @@ -251,6 +251,99 @@ static int remove_fn(struct pci_dev *pdev, void *data)
> >   	return 0;
> >   }
> >   
> > +/*
> > + * Note, this helper only returns an error code and takes an argument for
> > + * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
> > + * always succeeds.
> > + */
> > +static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
> > +{
> > +	struct pci_tdi *tdi;
> > +	struct pci_tsm_pf0 *tsm_pf0;
> > +
> > +	lockdep_assert_held(&pci_tsm_rwsem);
> > +
> > +	if (!pdev->tsm)
> > +		return 0;
> > +
> > +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> 
> What is expected to be passed to __pci_tsm_unbind/pci_tsm_bind as pdev - PF0 or TEE-IO VF? I guess the latter.

Yes, the latter.

> But to_pci_tsm_pf0() casts the pdev's tsm to pci_tsm_pf0 which makes sense for PF0 but not for VFs.

Yes, that it is a bug. Incremental fixup I will push in v6 below.

> What do I miss and how does this work for you? Thanks,

It works if only testing direct-device assignment of PF0.

-- 8< --
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 4688ddbc0b33..59458e894251 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -36,16 +36,16 @@ static inline bool is_dsm(struct pci_dev *pdev)
 }
 
 /* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm_dev == ->pdev (self) */
-static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
+static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
 {
-	struct pci_dev *pdev = pci_tsm->pdev;
+	struct pci_dev *pdev = tsm->dsm_dev;
 
 	if (!is_pci_tsm_pf0(pdev) || !is_dsm(pdev)) {
-		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
+		pci_WARN_ONCE(tsm->pdev, 1, "invalid context object\n");
 		return NULL;
 	}
 
-	return container_of(pci_tsm, struct pci_tsm_pf0, base_tsm);
+	return container_of(tsm, struct pci_tsm_pf0, base_tsm);
 }
 
 static void tsm_remove(struct pci_tsm *tsm)
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 61c947ff8735..d26d6e128d83 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -121,6 +121,9 @@ struct pci_tsm_pf0 {
 /* physical function0 and capable of 'connect' */
 static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 {
+	if (!pdev)
+		return false;
+
 	if (!pci_is_pcie(pdev))
 		return false;
 

