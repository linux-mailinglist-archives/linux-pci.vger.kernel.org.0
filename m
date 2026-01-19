Return-Path: <linux-pci+bounces-45225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE052D3BB2F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 00:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68BCB300AACE
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 23:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7627A461;
	Mon, 19 Jan 2026 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFJKJoeu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D271B142D;
	Mon, 19 Jan 2026 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863736; cv=fail; b=rFW+T0T6vwUNDYk3+8QM4AIuHBS8lpNmlxe/M9c0JPrEIpCB5XlN9X+7T1DTZwspFTS3ifHVuvoZAJ8UPgvWMBDlIWAwA6j0f/HrUxPFGVSoGdNtxeLtdnKFen7bXWerht8pHcOW3tUE2EaqV/jjKu06aHGwBXuz2xn8RNPr8Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863736; c=relaxed/simple;
	bh=XEttxJz771LcYuRHx9UsSn3493dmc+wOMEXRchcQyGo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=OKBBS6b1mXr4/nG3KVxckWVkgVPMo+kbGThSpVg1RMuyaRgMSctbTiT3+50j+hP9feh+Z491i5WnWmWHagLqnq2id0edwSuj87U1UFlEA6gDZ6B1ssIeMEK3yfafJ0vQGAqL5mMSx/9Pr7pOxp68KniIw/ULXOanJNLOdOcVXvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFJKJoeu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768863735; x=1800399735;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=XEttxJz771LcYuRHx9UsSn3493dmc+wOMEXRchcQyGo=;
  b=JFJKJoeuS/+l8l+/ZMhmyaoZ0xDlT96zdhDGHK/BpKh7f+Tlkf07Yjv3
   IvnZPHOZFW9/4v6fgQ65MNA9ch0s5u+CCfs0LoFc7F+BVg0sc1GFypXKg
   uG/w4QKUjxOyAKDQvoZQXen/2T6MCaGbVECbxtcHk7BsicfYH5BZwbJGL
   WHpdBd/zfko7RBE9VJfdIU0AF0Y7htH3yaQ0/pcY2KXNJa1TMUXOaXEcH
   XqMbO2uJjicMgkHX19QEBoBFG98spzeP1Jv6vAUR08OAXRMXqM1YItEE0
   kGHQUi9xxtmmUjIJxICYzxddfXJTkEkui0SK8OYNjcaYINz7UdAQL7rrE
   A==;
X-CSE-ConnectionGUID: CdoQY9qJRw6BZI2NOa29Mg==
X-CSE-MsgGUID: nYnGT6bDSxaDyqXcEDu0QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69083343"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="69083343"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 15:02:14 -0800
X-CSE-ConnectionGUID: EnTeu69ZRWe6NuaR+k3h7w==
X-CSE-MsgGUID: PqZMKocnT1eCYH24sBangw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="206314915"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 15:02:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 15:02:13 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 15:02:13 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 15:02:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZWRszycxhPFMAli6l31QFmM9UF3V7TERkw4KC3CS3QZvfBHm/ymb3gXjqOQlvqKHjqe75HTWJggbcjox9NITsqkWWPdygvmBpcCK9qMYTfEeTEN4HGBQjBMthQF2AYCCYfUOXQTCh4uGD6yJ0K/NYeneM4QMAV2HLvv9BSWmadJvJSCS6DFs1HhGW3/VMMTgVrrDvhaa/M9LwFLTLbdp7mGb+3CYSJ3lx4IQWtjTbhh0bKHDruxOq9WYkLnZVIJWESzvvnEWd4DSHWeXA6HdL48kcylq66YRx+FJzG3ztE/YmG4WXOk0n3cwMrVmHc6xjtzjBohcspmEvdBeJaF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uzCIFNIUvIteHXv4eW+UZuoafPqdH+GaoAvSFkI2ZE=;
 b=C5O3TDAwqrmAOAH0AF6IaHuSvtPiZbg0037kF0aTujvuzWO76u4PyGR838xmQQuuFcUiTHlp6Edw0nOeGM2cHILgtnCbC6dNd/TWrCCyNlDZGDFMmwngDhsc2Y7/yPkc8DhOKCBnr/sZtxBvNnpp7EFKTpujjLX7cDs5BEiJuBYaZUtZmFNp3gDO1KLuBP6zUvLt2UPGezKtpBTLcBlB7j1tz/LYGeMMLEHpfiHPajMAYxRZTGIcDDFVBPpnF44C2WqTTdIGJEgRZbfW7XeFk0xxXC+ULNbxSmGYJecDR6R4fH8/RQvkuvMOi8Gt9xJCDbLQZyInMVoQk8CaAH4qvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH2PR11MB8865.namprd11.prod.outlook.com (2603:10b6:610:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 23:02:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 23:02:11 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 19 Jan 2026 15:02:09 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <696eb7f160bbb_875d10053@dwillia2-mobl4.notmuch>
In-Reply-To: <20260116161607.00005588@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-20-terry.bowman@amd.com>
 <20260115144605.00000666@huawei.com>
 <6969c260b7998_34d2a100f6@dwillia2-mobl4.notmuch>
 <20260116150119.00003bbd@huawei.com>
 <20260116161607.00005588@huawei.com>
Subject: Re: [PATCH v14 19/34] cxl/port: Fix devm resource leaks around with
 dport management
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH2PR11MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: b22727b6-19b4-405c-807e-08de57aec70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzZ0MmJmSDRmcURQTHVRM2F2cURVT1lJWERLa1QvUHlJRXEwTjlDQ0FuV200?=
 =?utf-8?B?eVVmb3A2cC9aM2NyTHJmdnB4bUFzWHo3QlpiV2lFbmJOdm5ybmIxRW4xemp1?=
 =?utf-8?B?RlpGaDZCLzVnK0s4R1RydjZjdTlTeGtDM0puc245a3pOTUpiN3FWVHVFUFgx?=
 =?utf-8?B?WE5ZOEV4YUFGUGo0R3NmbU0zL1VhUmpyNjFFZ29PU3p2RDBtdGdrVktoVzlW?=
 =?utf-8?B?VXo3bHFHa3Y0VmdYaEdETUw2dHhNMkxURGRKczVmQ2I0QzRGTVBBNnVlSnBB?=
 =?utf-8?B?ZWpSMEduazJ5WGhwRzI5c29SQTVYWHl0V3IxTkNEZXl1NWNZU3VZNXZNOGlh?=
 =?utf-8?B?WUlocW10NHNYcWpVeHc0Z1hPaFppVXRWbFZIODZPL0hxeU5hMmtuS2JGay9o?=
 =?utf-8?B?aWIxMnRMRzRkNGpmOGJrSlR3SFkyRGJ1WXZSWjhGRUlnYUxobG10NnRVUG5G?=
 =?utf-8?B?VmU3Q2cyU2IydTB5WlQ4ZDlsbHh5MHQrRGhxdzV6YkFUVnl6czVIYUZHQmd2?=
 =?utf-8?B?djZSQU9QVmgwei9PSHI3TnBzdUJDeDFMZ3czOHNUUEtKSlZ1NDdQMldCVnRQ?=
 =?utf-8?B?bWxyV3QyRVhJa1pybEJiMFpicjY0STZoUVNrYmZNVnRwUk14U3VLeTJ6Uzhl?=
 =?utf-8?B?bWZ1TmFZZmU2bFBVZk1Ydlp6WlJVY2p3U2IxUDhjZzJlTE1zV0xTUmgxUFVE?=
 =?utf-8?B?Slp1Zm9wL0NhZnkvSUxiMXVsT1RPd200SWo2cEhENUlzYjRYNElUeENoVWFY?=
 =?utf-8?B?RmhyUjgycjB6Rk0zOXpOVUF6THpybFpNOW9QL21pNDhsR2YyZ25LNFB0ZFpp?=
 =?utf-8?B?RHJpUlgrYTIxUkd0QnFsT3NzNnZRbWNiZTl3aXA5eE9BUDZGZ3BiQ2hoTCt4?=
 =?utf-8?B?clFZT3ZsQnF1WURPZ1JaV3BzQkpLY0hkdW5yTFM0RG9lQm1YVzRycm45REdG?=
 =?utf-8?B?THJIOFdoQkMzRzZsQnBhVkwzK3I4M1FkQkVhTzA0UkMxNmQ3N203TmhiSmxY?=
 =?utf-8?B?cWh5QTZGQ1IrZlVDY3RmNWdzTmdlYXAvaGZwV0RkWStLZmxVYmd1WmZXZmdF?=
 =?utf-8?B?TElaa2grcTdOVEkzMldiRXF5SXd0VXVML3BmN0V3UlRRSFp6aHVhTXFzbDhM?=
 =?utf-8?B?R2cxNUpKTTJ5aDhOMmRYMWR4T2FLQ1RNN2FINWYxSG9nTVNsZkZiUU8zWE04?=
 =?utf-8?B?emhpR1lRMnRxMjV6SG9YL1JOT0hidmZRTDllYlNHcndidVp5d2pJYThob3Zy?=
 =?utf-8?B?ZW41REl5N3J3QXUzOThHckdNSENUQzVFc0hhVUlMQVpUa3E4bFhrSDJpQXBm?=
 =?utf-8?B?dGJNL2NTcENsb3NHWWVZSzlOWElNSmxWQTlIUG1VVkJnS0FUNFNJNlQ4MWdY?=
 =?utf-8?B?RHBRYnhyTEtvWWlBd0NuTjFHeW1MVmZ3WWpWZXhvYUphbWMzQmZGdm9FSlg1?=
 =?utf-8?B?R3RCRGpFRUltdndVbWhRNFEzM0s1NTQwS2NNUDMvTmtDU0t3RXl2d1hncVF5?=
 =?utf-8?B?dWFDU2R4RFhLM1BUSnlqS0xMYThxRklrdzVZS0NVYzc5UXlILzBDWGlsZ2x6?=
 =?utf-8?B?d0JNeXFjYXF5U2lZdThoR2tZSEUzM01HWHIwL3dGNkNwNERXYnpWemlKN0Va?=
 =?utf-8?B?SHFNaWQ1cFd0VHRGS3BqMTZ6Ny9uaGRaeUx3NXRrNU83cEs0ZTBJV3c1NENl?=
 =?utf-8?B?SEMxeGYvaG5rZjNSeS81NS9ZNVFKSWZnb1JubGRaWm1yT2FDVTBYanpGMkVP?=
 =?utf-8?B?TGhxM2t4Q0d0Vi8yajgvamowTlpkQTZTdWtpZ3d0UnB4NXVacUNTdHFPaVNE?=
 =?utf-8?B?TXVrdXh4Q1BQbEFkSzRSY2FKQTZ2RGZPK0d1UlUrWUZuei82WWEva0RFazRQ?=
 =?utf-8?B?NUg5c1kvT1BEN0tnT3phQW5FYnhjL2lRc0tNNjFmUHpHZ3Nkb0gvaTlsMGEz?=
 =?utf-8?B?L1RRNVZsVnNZaXMwSjFmRGJUdHZvQkVhUU5QV2VDbXJaUVJiVkdEOTV1dnBo?=
 =?utf-8?B?Y2lOQWY0R2cvNm9KUzNDczl6cUc4QXh3YmFhUDFqVW9zZGloV095cE1IRzY0?=
 =?utf-8?B?Q3dzRzd1RmZDT1VuaXZYdDZldEFPYk53U3pvTURoUXVFRTcySER4OWMxNFdE?=
 =?utf-8?Q?YYpQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZLd2YyQnpDUkJNamEvUHRLMlhPYlR5NFRoY0JmUmxZNHpoanUvZjgzczh3?=
 =?utf-8?B?WWI2MklHM3BKSDRCNytFTWtGb2xPTDM5c3ZIaVVEL3M1SlRaelBYYXRCblM0?=
 =?utf-8?B?citMUjExQkhmU1FIOC9YbVFyNGVqSnpXYXdrai9aemtrMFVMUVNXM1gyeXpr?=
 =?utf-8?B?S1NDakhlaGNJRm9sRkpuUkZFVFVUT092Tm5TOXNBbXVHTDl0VVlQcTExSHd6?=
 =?utf-8?B?Y1N4NW94elVTTnJBUFNPSmQ3VzloejFUdEtockcra2c4bVllNExEY003UE1G?=
 =?utf-8?B?b29ManpoUnBzWjBsQWRsV3JDSThLWW5ZUCtxWVhuWFFac0ZFL3ZkaElOUHhU?=
 =?utf-8?B?ZWhEVUQ4bEVZbWRSSUxTS1V0SHVDbDFtdkxnSFlhREFlaVFWcXpOQmF3YkNZ?=
 =?utf-8?B?RitCL0huZ2x6OEJpSHpNNzdBcXJlZi91bit0dktpdlc1NzlVMTdiTXhETzEx?=
 =?utf-8?B?MTF4WlFBVFhCRGtWQmhQTWE4dHpSZzNabnhLai9DZHBwY3gwZ1UreGRaeXVE?=
 =?utf-8?B?VEZpTlZnM3UwQzhkNWxSYmdEczB3N1dHWTVkN1pnSXBUVnRTbFVaQXZJMkkx?=
 =?utf-8?B?d2hwb2U5V2xIKysrRWM4Uk1KN0lwQ0w4TkRkaGttQ0t4ODU5UXh4WW9tNUJM?=
 =?utf-8?B?UGM4Z3hhYnZ1WHVxbGpaSUxlRkZXWEdXSVZzRG4zdnp0TGJNaGNGU2hrYVF4?=
 =?utf-8?B?WmxLeklmYlRodlJnanlZazdXR2RiNTBRZmJ1T2dMZ0dOSlpucDB2cjN6bkQ1?=
 =?utf-8?B?WmpjQVlGVnEzZno2eHJQRkpLVmdJekRhZGJFS2lqMU5rN0UzV2t5eEp6VHRv?=
 =?utf-8?B?c3o3OW8yMGxoL1pkUjJacEtrM21hVzZpZDlWZXlLYXd6TmQxSG5CVXBRT0dI?=
 =?utf-8?B?VjFmMVJKeURzR0pXNU91YUVvT3RPQkI1N1UvckJvN0FHSVBldStBcDM1ODJu?=
 =?utf-8?B?bzljRjlQN0pmbHRVVHIyZkZVUXJkM1F5TG9GcXQ1eGppRTVhZG5LVVRPWmFH?=
 =?utf-8?B?MnBHcUNrMHVRQ09hcXNCS1dkNmsyZ1JjNWF0dTh0eFRGNHlJTVFFdG1vQ1Fu?=
 =?utf-8?B?TVNYSUdsUCt3bjRPdTVpeXVCVjlSdTh2dmhJaW1Od1hlUXM4MHdGc25JS3Yw?=
 =?utf-8?B?K0tySUxSM0lUUmdRcytnYm9SdU1jTUdvaUZGWTQyWHRtSy9jSU1Xc3hvZEh0?=
 =?utf-8?B?ZllGTHpyNlhKbzM3RHRXaVR5RGg0ZkgwekdBVjdaNVRDd2dKRS81N01OMHdJ?=
 =?utf-8?B?VTlpT1RmejBXUDkwMEkvbzFNSGdlczVZTlY5bVVuL25sZk9leXdhL3dDTy9a?=
 =?utf-8?B?T3VNTTNLdFFmUmdpV0htd1ZnZGJielR6WGF2a0xoeDdRVk9ia0VKeHRybzFm?=
 =?utf-8?B?S1haalZRbXhJL3BQVnlMb2U3dHo0YTVuODRZMVBVUTQvMGNMdFpZYVlTYVhO?=
 =?utf-8?B?eEV2RkU0TE9lMm9ZS3lFT0lhNkw5dDNXSmJ4eUdhd0VXdnlIZnpoOXczbkRK?=
 =?utf-8?B?czlTay9GSlZBaGduYXFPcUJVL05mK1J0MXFCQ1ZpQ1lhNFJhY3pQUEcrNFBi?=
 =?utf-8?B?bzIzV1Z2ZzVjMnJndkJiL3BWenFJdWFkZE5iT1czTmp4Rm56Q3J2NnZyREE5?=
 =?utf-8?B?ZHQ5TmE5cTdKeG15Mmdib1JRZ1BFR1VxbFhabTRSUUdIOG5xOXA3end0WTlh?=
 =?utf-8?B?K1FFOGlMTU93aHlEZDlZMjdmc1V5SXdqdlJJMG5pN0Z1c0JEblpxLzJQcVJr?=
 =?utf-8?B?TTVyWGphbFBPaWcrNWxObnBOT2h6TU1VYVV0akJMMXJrK00rNEplaXZIR0p4?=
 =?utf-8?B?dCs2ZnRmVHlmTDVEOEowcHhBSStyN01GemtMeG5Ja28vRXZnWUlPVUc2NGN3?=
 =?utf-8?B?UHB0T3BOWGNFTkdTSXppRVozeDRsQk1FeUVnbHhWTS9PVDd5SEdoTVYyTTR3?=
 =?utf-8?B?L0xFd1ZOWUJvUXZ0YXFzTlYyeUZkcUIxWldSYVZKR1B0cXdxVmk2eUFHemRl?=
 =?utf-8?B?bDJydlBjQmxuMUpxckpiWG8zd3l2bUtRV0RiOGw3ZWg5SnRQZ1VhVVdFclRN?=
 =?utf-8?B?ZldCT1VhOElodWVTaFNzVWlETEVIVEczK3UxSDQ3Q2YxQ3pESy81bnFOcEJr?=
 =?utf-8?B?ZldyYkovbG9yUHFaaTY1R1hRNSsyZlZHdTV4dUFvcmZHWGl6cWNGYllvR2R4?=
 =?utf-8?B?ekt1RkJiWGxRcDBrV3FGZHQvM1psUTZlQWZFU3R4ckUzdmsvak1vK2thT2x3?=
 =?utf-8?B?NVNxRENSNnd1UGIzWUh0YTZpRzkwSHNXcndKYXFTd0RqRjNEYS8vd0NnVFBs?=
 =?utf-8?B?VmZuSlUwWUx6SjJBNS9KdFNQUWYrc3NlczJ4VjFicEdNOEVJWlV4VndUeWQx?=
 =?utf-8?Q?FDJkDX2NnI0rcHuo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b22727b6-19b4-405c-807e-08de57aec70d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:02:11.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZK2xc3bWuEvg32rDKYVCGxQC6KNXq9FRjKNXTYSwiwY4y/4GAIexX5ftgMy8nR22VlOHw2z4Ighq6a1b5ZYzIXj5VyPDExOhplbm0AsVmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8865
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> Any thoughts on what I'm missing?

Probably:

   cxl/port: Map Port component registers before switchport init

...which really should not be a distinct patch from the one that changes
the ordering. I will send out a more patient series to settle this so
Terry does not need to keep carrying it.

