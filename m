Return-Path: <linux-pci+bounces-42709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A8CA9CA8
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 02:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA953180739
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 00:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FF3148A6;
	Sat,  6 Dec 2025 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5lL1fZK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170F2163B2;
	Sat,  6 Dec 2025 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764981707; cv=fail; b=JvxwThKvDwU77SfqL77+i+o4Fa5mMvywSpokG+w+KDB57aa4AgpigjdVGcQB7ocF5GZdPXD3N1wWNX29m9L55LiaTvyto5KOvKnPpdrzXEGzbOTj+gMxpBLVv10vwSG9zh8a8/jTkG5q5u6oYNRKWQtlKqJ9xk6wff4Ug9KTsn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764981707; c=relaxed/simple;
	bh=ZgzVJyCAE4kfaC8iFrIxdHoG8YVOwVZffSrRN7TS/4w=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=a3KKsbflG5RNKe1gDkwUUIjnbz7ah8P+mEWIj4/08paUegfRz1eSnmvkGhbVbhCT2uJP35NXXR8GoI9W7eKQbwsgq2NeT1oxuInf7fkoC0MtMpPgUtIwhhFJV1P+v00If+FJyQTpx3Ay4IHjnJYn4kk1xmiiJmHHjxhJxHS8TTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5lL1fZK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764981706; x=1796517706;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ZgzVJyCAE4kfaC8iFrIxdHoG8YVOwVZffSrRN7TS/4w=;
  b=A5lL1fZK/CR9poFsXWg50weNStS+AOq+SIzxij4belJ4maDB3IOJvufA
   TiKmd2MpcmRDlNOzhk5F8DSpRwLr7vDO5u+a7mmowDzKYNZ+P0eN8adcf
   H1LPuYMv3UHhvNZ62MHd+IY8NaRPM0jgCFA8jRq1c5+W8tsgh5Sli5uYr
   iocFdQcIU6rSe+FBMOTW7OUOPJPg/+/8r2M+8M3wu82pR7bjgWimAyFCC
   opjCge6InjcHlZ6lCF3XK5umr7JC+v7h8uwV/YzzXRYlY/Std/h1tBaC8
   d1yrfNbYcyyu+yHbGQqc2Lrrc8dOBoGjDoh4vZFZSwY3hmtp1jslaud/L
   w==;
X-CSE-ConnectionGUID: 1266BC12QTmDpOxVuqAl1w==
X-CSE-MsgGUID: h6xXEphHTqiv8fCsP9TVFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="66980695"
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="66980695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 16:41:45 -0800
X-CSE-ConnectionGUID: OSeRlCamRX+r22u0Of53yA==
X-CSE-MsgGUID: pRT/Ni7VT9m1DPQ4tbnzYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="199865836"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 16:41:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 16:41:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 16:41:44 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 16:41:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwRAE77X93+rbIGyfmRI7CiH2r+Fxq5GEIsimZ1UyGVMZJVeXCuggS243WM3V0kmSUWJf+1z8ZnJLnHPF/OeqUK7Qd+iTNQKXyGfXn58lJzVE8dPffvZrGBPZB6cSV9OIuWzLVFydwlq6qD6IZlwowPm5qnR61zc+Ar+S5uEVEn5NsN52eJ/vqD4E6r3HDPmvkbRMGOPHtWYmzgEVEfXE3dII92DczueMq/P5MR88/lkBRACNljayEbSdAZgrVB/wTatba/HjwiajRQ7GDq56KXUfaQlzbrkNNo5SEnMOaJ6EWhrSe6gffEvud+QHCeTZh/To2bMqFMb9/CydpDFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21MdyCHtWbeK9XfHEkCwFXyBxffzUFsHEQMhFEnt2vU=;
 b=ljuSByQAPgxwBc3co2U+UyCKdM23NGzENd8JRpt2xVX+ONeH/piB3hu4jJ3qnGVY4AgRiDZaEdwStMKaYS4uHh55ehX9+iYFwppdbYYwHv9bkWv8/AfBPFylZTODt/tCwZeUnwkG8u97GRQSjh03pROwPsCwwxBTjxrfPy9xcJrqmvop1uCmY0cOLbvwJ3pHsGcXmmeLF9b2mmCVaSvFhGwg8d48lidSWCM7RsvQ9x6Be4AnpFImQ4ONcdiFiNu1TfIwzaGPzBouYcNxVwJER5xE2k0y+3CJcoVN5JpORY8JZNBLP1E37RteT2L6qttjf1mcQCWpv0QU6dEYY1j4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 00:41:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.011; Sat, 6 Dec 2025
 00:41:42 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Dec 2025 16:41:40 -0800
To: Bjorn Helgaas <helgaas@kernel.org>, Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <69337bc4d1943_1b2e100a9@dwillia2-mobl4.notmuch>
In-Reply-To: <20251206003114.GA3299517@bhelgaas>
References: <20251104001001.3833651-2-terry.bowman@amd.com>
 <20251206003114.GA3299517@bhelgaas>
Subject: Re: [PATCH v13 01/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 025c64e9-856c-42c3-b0fb-08de3460398e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3gyTEE2ZXV0Z0Juc3NMR0Q2OVRUMEo3ZVF3SXRNaGMwQkdXMjgzZTZCRkpG?=
 =?utf-8?B?enpMVERQME00WkZGOGpDME11TVJzZFQzUFhmblFNTWVxQ21pUVBuaDdROU9a?=
 =?utf-8?B?M20xQy9lczZuNWZ3OEprTVFjZ2l4OGxtemdzeW5hU2xwT2dJK2ZDYThlZldI?=
 =?utf-8?B?aXdnMHRIbTRpY3B4dHlkSDJMdExSa3o3SVVMZUJ0ZmxtQUpIR1pIV0dRT1Ux?=
 =?utf-8?B?U3htLy8rdHZzRXVhZHBPWmdMY3FJTmtBaGZRT1pETE1uUVozTmVQYXd3UE9E?=
 =?utf-8?B?MjZVV1FXSDlwWS9wZm1WV0JOeVBKNi9vSTZwalBaUjg0azY1UU9UYU5hU0lB?=
 =?utf-8?B?YTJNY1FaRS9HVkJyRE8zT2llYXpRNTRMMGJZcTZUbTFNVURJL0Rwc00vRHhS?=
 =?utf-8?B?Y0RLWWFLTmMyU2pGZGwxY2hSWXh4OTdXdnEyUndWdXVTMWs4TVUrdDNqMFZ4?=
 =?utf-8?B?aDZQaHhFOGpHbGxsbmxwWHJOUkZ6RmYxdU5lc3hHVVZLK09PV2hjZ3QvZjhI?=
 =?utf-8?B?dEF6YTYyMHoySVNJdkY3NjhTM0hDdHhuVXRPTlpBL1Rma3R4TStmUG92WXZ6?=
 =?utf-8?B?ZWw0YXpLb2VOa0tucFdMM2Q4Skd0WDNSRlQ5bU9jZkxjRVAvZlVPOTU0Unhm?=
 =?utf-8?B?YUlGSmlOYitydkxoTkNtQTRETlpkQU1sYVc4Vk50ZkVXeGxVQmpvdkk4TnFq?=
 =?utf-8?B?WjBTdEFwdXFHYWgrZ1JxMWFkYXQrMm4zLy9yckM0bkkydlIwWDZJZEhyYzhp?=
 =?utf-8?B?NjErV0x5eW4rNUE2UW5FdmhNdHU2M1EyNnVBajdzU0lNd0wvT2pxaUdtZVlI?=
 =?utf-8?B?SkM5cHFCTHZlcmtDS2ZTZjFBTzRvZ1R0ZVZwN0dITjNZb2VZYlE4LzVSeHBV?=
 =?utf-8?B?bXpqa0dxaExqZWxRR0E1RjRqUUg0ZDFyUFMvR1dwM3NqTURGbnZmTEEyRXFs?=
 =?utf-8?B?MEdGS01jNVpnbFB3V010N25va1NyUXVQNlE2SjBrM1ZuM3RPUzFmZ3Zwa0dp?=
 =?utf-8?B?S0JLa0ZQMytWT0hHSFAxVVI1M2dsRWFmTlk0RnFRRktvb1R4WmpFNU1YdUZ6?=
 =?utf-8?B?Y0daR01wR01wbHhuWDFXNGt5ZVppeWhSNTIwbnM4SkZkYU4yY01sbVlPSUk0?=
 =?utf-8?B?enIyK1d2UmppVFRybXZIYnZqZVh6VTE2ajQrdGtjTWJ2NzdDTWQ4ZXNHRTg5?=
 =?utf-8?B?SmlDN2VyVmhhNDN6T3did1lBanJDVjJYZXN4UklOTmpsZlBLZ2JnYzBEZE1Z?=
 =?utf-8?B?L1pnU1lIR0N0Mmt3ZXFlVnFYSkhuRk5ieU5WcXpVMmVzMlpKdFpNaEJEN0xV?=
 =?utf-8?B?b0NJc2VkVWg0TWJBYlpwMUlxZHg4Vms3aDRGK3daYVlGNGJQZ1dFY3l6TWFP?=
 =?utf-8?B?VEhlWFl0ZUZOckRPQURWNUVpMmUwY1NNV1RzckJWa2hSb3p2VE1CNGpHWkxa?=
 =?utf-8?B?MVhET2prb3dCM29vaVB5RmR1STBDYjF3TTByRkZhRDhlclhXcmR0cGt4R0Y0?=
 =?utf-8?B?UlZoNkZIRWVlTm0rMU51bDBpTXgwUlFsaS85UGFQODJTcUpDTERhSnFqWUh1?=
 =?utf-8?B?Ry9FY0NYcExQR0F4dG8wL1MyT0F1SVpKYnllRFVMYmZpS08zOHJ3dyt4SEQ3?=
 =?utf-8?B?ckxYMmNRNFRhaS9wOE96RC9sYUh1em9ONmI0Smt5MjBtOVJiVS91bnU1NHln?=
 =?utf-8?B?VjZtTlVXLzF2SmhXZXZDazRXbi9odDFSd3RZdlk3K1dxSnJTR1ByS1c2UVhj?=
 =?utf-8?B?ZkVEbWFUNE4zU0sydGphZzg4aHFMVzBzdWxLZU9HSWVBY0gySHU5UVRYODNQ?=
 =?utf-8?B?S21TSUZOVVg3eldmdy9HTzNoV1JDYkphK2ltRjJsN1ZlWDFwMVNva1N6QTF0?=
 =?utf-8?B?M2NtUFZ1V0ZZT0oySzVqVmVBWE13eHYySVVCYjdmdHJXV053VnNyK0tiWGVp?=
 =?utf-8?Q?TJJvWrNbSj/HoKMCxIwwx/9UkMMVbCKx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZNOTZMd1F6ZFV5Mjh1YkR5N1RGclAyYS9vWDJiYzRaSitCZnFJdEVTWXFQ?=
 =?utf-8?B?ZUQ2OWJLR0lnekFNUzJMNTZuM1ZXQXZVVjg3TW42OHI4alFBNk9iTEl3YWQw?=
 =?utf-8?B?WENFOG5hU2NlQ1J4Rmx3VThTY1dROTNLMHpGK2N0NnE2Wko3dkFlR0dMYVpR?=
 =?utf-8?B?bG9KSHhsbEpWclhDemNYVVNJaS94WEt3cFdVZFV3cGRsTlFwVHR2TFgxTVVa?=
 =?utf-8?B?VG1WZTgxVVFISlZ3L2pjU0JHUGk2K1VDK2NKcXpPLyszQ3NhNmQ3UWVBbnFM?=
 =?utf-8?B?T0Q4YVZ6Z2hXa0tJc1NrNTIybjNqNjRQbHZXQmgwVy9pN3BrMFNLdFZzRGlK?=
 =?utf-8?B?SUh4cUY5WjVmRjZlS3BMTllwYmlRVFNlVlgyQkx4T3FuTWVmVVUrOURJNFo5?=
 =?utf-8?B?MEtZNTB3WU9lbmpFckZlMG5aWHhiMkpWditTclJXTzE3aFpsalFrM0FzcVV3?=
 =?utf-8?B?czNzR29xTmpJTis1azM0Tm44WThoNE5ibXlJa3NQbUtvVGdQbjZFYW1iWFJm?=
 =?utf-8?B?S2hWZFFUOWVIbEVLQU1HRExpWDRLMFFqZjAyQ01rSkthcUdUOG9NOFVSbnY4?=
 =?utf-8?B?NFYvMGpxaWFIYmxwQ3d4WDJMR2MwNTRRQjZNTW5IYk9hb1Ryc2NlUzRSMzRl?=
 =?utf-8?B?ZmFUWmpwOHFtd2hBbGJjdUlCek9MTUNUQ2srV0Jtc3hKRVZBbXgwZC9iZDFp?=
 =?utf-8?B?N1FwUFNibDVJYUhZNVFBYnV1dDc1WGhMSVhjMW9oRDhtbFBiMkRZaXFZRlZU?=
 =?utf-8?B?K2Y5Zzl6SWNQanlEM0ZjU1c3czloUXJkNkZpVDZoZVFVdVg3eTRtSjlQdnpR?=
 =?utf-8?B?VC84dSsrTkdLQ2RGazN3SDlZSnJiRmU5UEg0UUF4TDZKQ3ZuSHRnZjAwMVNk?=
 =?utf-8?B?Mi9vY3BCNWoyeExpZnM0TTEvLzhPN3pjeXFVVWxaN080NWpuaEIySnhJN0Fn?=
 =?utf-8?B?R0hCYnV2Ti9oQW9xVGhJdm9sejNPK2UvaTVSZ3diRlAwTndOMTM2RXNQS1dn?=
 =?utf-8?B?Rm1HV3pabW9MZ2tJNmY4eEplNUZ4QSt6ajNYU2E4cUdwdXlLRXovOHhSYVdr?=
 =?utf-8?B?WmtHemt5MmFvT1h6Q011YTNqYWd3T0VPbkNjZmtXTlJqV0xhRWoxU0tiK1k2?=
 =?utf-8?B?L0psaDFsVm8wSkFvTTBHeTc5OWFIU2MxN2xkMUJLQ1piNFVESE1yWERvMkZT?=
 =?utf-8?B?WjBkMHlWT1poSnhGemhYTXNOdU5BS0VJUmxxUXhZTDNEemp5OVlCN1I4UXBq?=
 =?utf-8?B?TDBOMTNZalpZemF3dDdiTGpaZXhrMUZBb1V3SDdnTkZSaUNySFNrdGJJZGls?=
 =?utf-8?B?M3Y2VjBNOGhPY1dKTkx4Y3p3Rk9VT1VMczZEQUdsQVN5Nzl3ejl1U3NRV0ho?=
 =?utf-8?B?dHRBVDlSRkJsYVRLMENqL0QxN2RmaEM5SVYzYlpQb2diVnJDTURORWl4TFNt?=
 =?utf-8?B?NGgvcUZLZW94YllKQ1QvSElzekwzWFcyRlN6Vi9VN0QrMkpLeXN3dVpHQ3ZR?=
 =?utf-8?B?OXJCbWRYQnFYSjFycjQwVndqK1Myc3J2K1dmcSs4UzdxWUJCZVVGMW5HeFZS?=
 =?utf-8?B?cnYySXJlUXNUWVNwZnErZUFnTlo5TGxCNTlFMzU1NVdXeGpEQjhGem51cWxh?=
 =?utf-8?B?cnoxSXZaaXlVMXJFRURySlBnNlhyWElYamwvTDlqUHE4Wi8xVXB5M29XeXhL?=
 =?utf-8?B?RjdzZ2dJbzhxcUNmaDZRRjBYVDFpSkU3dGpxd1RGcSs3WlJQTzFBaXphcUpS?=
 =?utf-8?B?MVBzTE90ZzJvN2lrcVRqT3JBYVBYRmxxRGFpWXdGS25Ld1ZSY0J0YXQ3ZGpE?=
 =?utf-8?B?Zlc2NlVCVEZnRSt1Q3l0RndWUjdGSzQ3eWFQVHdiWmtEZzg5ZWFhS2RnU1kz?=
 =?utf-8?B?aHcyMVhuSUd2ZVVtZWtXNnY4cml6bXo1clpiZkp2bzk0UWpBNERxbmhsOE5k?=
 =?utf-8?B?enFJak5PeXNtV2tjWEdLMTZjUDNGemdYbFd4ZFN5emFkYUhZd0tMQ3NtbU1i?=
 =?utf-8?B?MFVCVk9ZaUZXL2hhTlU5dDJOM3phcFNTTWF5aDdJOEZOVmRDRFpuSTdsWXdZ?=
 =?utf-8?B?WUtFM3EwMlJtYTlRN2hVcGVDUjVUVDkyOFVKL005SmtNRU02VU94aVJ5d2cr?=
 =?utf-8?B?WGo3ODBUNTJEVGkxekJWUlBDZGFCbWtjeXZFeDRXWnAwd1lNaGtSTVd2akFo?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 025c64e9-856c-42c3-b0fb-08de3460398e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:41:42.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SoLWbHlMbR6NvFXadW5BSl8DcR/oBV6xJACl7iRnRFOhNk7bzAv8PJLAnvPyRK1kM/rYmX4HHiZOP+SW/rPnFN6DBLhQygKg/HCt5drgI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7563
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Mon, Nov 03, 2025 at 06:09:37PM -0600, Terry Bowman wrote:
> > The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> > accessible to other subsystems. Move these to uapi/linux/pci_regs.h.
> > 
> > Change DVSEC name formatting to follow the existing PCI format in
> > pci_regs.h. The current format uses CXL_DVSEC_XYZ and the CXL defines must
> > be changed to be PCI_DVSEC_CXL_XYZ to match existing pci_regs.h. Leave
> > PCI_DVSEC_CXL_PORT* defines as-is because they are already defined and may
> > be in use by userspace application(s).
> > 
> > Update existing usage to match the name change.
> > 
> > Update the inline documentation to refer to latest CXL spec version.
> 
> > +++ b/drivers/pci/pci.c
> > @@ -5002,7 +5002,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
> >  	if (!dvsec)
> >  		return false;
> >  
> > -	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> > +	rc = pci_read_config_word(dev,
> > +				  dvsec + PCI_DVSEC_CXL_PORT_CTL,
> > +				  &reg);
> 
> Stray change.
> 
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1244,9 +1244,64 @@
> >  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
> >  
> > -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> > -#define PCI_DVSEC_CXL_PORT				3
> > -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> > -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> > +/* Compute Express Link (CXL r3.2, sec 8.1)
> > + *
> > + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> > + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> > + * registers on downstream link-up events.
> > + */
> > +
> > +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
> 
> Looks like a functional duplicate of PCI_DVSEC_HEADER1_LEN().
> 
> Why __GENMASK() instead of GENMASK()?  I don't know the purpose of
> __GENMASK(), but I see other include/uapi/ files using GENMASK().
> Maybe they're wrong?
> 
> Same questions for _BITUL() below.

See this commit:

3c7a8e190bc5 uapi: introduce uapi-friendly macros for GENMASK

GENMASK() for a long time was not available to uapi headers since uapi
headers can only include other include/uapi/ headers, not
include/linux/. That commit made some common kernel bitfield helpers
finally available to the uapi side of the house.

