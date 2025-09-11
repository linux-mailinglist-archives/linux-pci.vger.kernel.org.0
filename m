Return-Path: <linux-pci+bounces-35945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD33B53C3C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 21:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85EE3A2BA2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D722DC78C;
	Thu, 11 Sep 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1BVfSpY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6225B30E;
	Thu, 11 Sep 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618708; cv=fail; b=dRacWsc4h0Xx/Y60jB0KMv4zrGC9RGvgQFc00Ufx8yE4a17ipSPxvNYyO0b+pg2t8+8sO3OZw11dBkar60DUjbakEcDzflU7HbQBXdZAmTfe7IkB33P7kDAVk940X7fE3z2RK+okGzM7vAqUbkd4GBDtVavZA1yloy89Qb3dNGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618708; c=relaxed/simple;
	bh=O+u4cLiFpR9r0elFHLGFt2K9PQ+vYIbTZxUUBODKWZ0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=RC8HC+AYLoMbR88UxzkZXwCpTf7BR5JxOfuICKJNKMILBKQQFMSxc9OIcRoY5Ciawj/b78ZAQ0VDnv0Run1hSNOZKTUZlo8Qz00tfxaMOGn3kBJq19uSTkR99VVugiMGI3csBKzCw5etixGzw0A/ttTFYgCfBGlW8CjYZmDhQrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1BVfSpY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757618706; x=1789154706;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=O+u4cLiFpR9r0elFHLGFt2K9PQ+vYIbTZxUUBODKWZ0=;
  b=P1BVfSpYbWG3oPvPsia1zVYfMGhMN0U6bh/6ftEcznNbkF0ySbZ17sul
   dVaX4Q56/7DsUwpgoYL1C0ip7NdUjhkGJ7bJ2a/yd4VmwUBfmjufJscxV
   Ij9KUux0hy1eutbL06bhDtjxz1mKr5vS1mm3FWubsSUzR5POX11zhXQW7
   E7+LZaemTYhOr/zCZgTRlhHtFPzorBXKiVV63Cw5I3mlfX9BX5d52n2JG
   aZKPlCN9dFvTFPJAEosvYAXKaSd4ICcX6p3Lk7ohXDNSRnmH5XLRf5Z+Y
   i6foXoZ6mE0qq1mQFT7frQg/uUorkhS7VX3kz2O6EZqQLwTO+cguPcpwu
   Q==;
X-CSE-ConnectionGUID: JdMP4nyBS9qvCR48/8Pbzw==
X-CSE-MsgGUID: LKzZ70KpS1y0j1kmegh/IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70218375"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="70218375"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:25:05 -0700
X-CSE-ConnectionGUID: S2jL0LA3TUas8NO6LQa+Qw==
X-CSE-MsgGUID: 0kDqTdrgTQ+l2QfxKV1YQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173602010"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:25:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 12:25:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 12:25:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.64)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 12:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJiVgF1VSlx0l4kRfxl4EK+sba97d3eVQYLdjMOos+TUrMCJwx6sSwsv4bCSo07wAbFzW+lx444rFuDxksYQWv7J9OH1Gb7uelEBtDMrIl+lOrm2u7A4mGFpTkc2sm1vkyVqpLPTX7kCu11Kk4/gR/AQZQrrtJZFnP3W4uR/2p7S79c/nLdV3reYQbIgsarKBMlvFptaCculjv9iPrDoZ+G44tRUXczUHno6k2qqZuIpDbNwPn2+7XoE814JLCycqE+Bq/zV7kbGpjdHMynjxhwpd5Jn6FL3tP6mydJ4kM7siemknjSf/yxf0WOPA/hhkc8H74qT58rOhYFxPAMe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5Tzc3itc/Mt2I616izs2d0FGmERkiA4FHg9+LE0M60=;
 b=LS6RkDOgl9kIdOrAo2tqhBD9PvLLCb8t94ov2IXuMzJv6lY0sodk+4uZHhctcLehkrn/Jn2ZuP8XjvohmVh1JRCuqQaLTKbMZSPu2iG5/Li5XWd/t49JABrXS5om1fgil8Vj7/Vo7O+C5aCc2Ojuz/IzNXBn/EzPhYRe0Sy9x99OvnhNlNdEHaIENAnQNMvqbieQgbIdoPe4mrcFMFLWlGZWYaZ5VDVbIGUZZaJwAW9XAvivgdyAjePND2Kvmla0kTBO2kTvSpWHKP2GrAErdywfwni2kHVVG3TxK7z0z9NKvU1bzd61YdZP9ZFjd/T61ucekny6XoUcUDGgyWPaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 19:25:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 19:25:02 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 11 Sep 2025 12:25:01 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Arto Merilainen
	<amerilainen@nvidia.com>, <dan.j.williams@intel.com>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Yilun Xu
	<yilun.xu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Message-ID: <68c3220d47eea_75db100a9@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5a1pod4obp.fsf@kernel.org>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
 <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
 <6896333756c9f_184e1f100ef@dwillia2-xfh.jf.intel.com.notmuch>
 <21903f51-1ed0-41a4-a8c8-cfa78ce6093d@nvidia.com>
 <yq5azfbjq2nf.fsf@kernel.org>
 <yq5a1pod4obp.fsf@kernel.org>
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7286fe-0506-45f9-9f84-08ddf168e7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUdiRkp3VVZMOU9FUTIxRDVvQmhGVHZ4ME9uTnJMd3pwdFhza2g4eUxXbkNw?=
 =?utf-8?B?N21WZ3J0TUJ3NXdERkpNaWwzbTV6cHkzbTNjYW5WMTJqc1RKZlhTMTJTcS8r?=
 =?utf-8?B?WUJFZDFCU3pXRkNQejVEVUprUWNrNWQwdVJVejVReXgrUXcwb2VCUXF2ZTdv?=
 =?utf-8?B?UElpbmh3bU5iSnVDVU1PQ25BbUlHckNBR2VQZ0xScVVRaWRMTDdWL2s3R0tx?=
 =?utf-8?B?YjVqYnlSaGdXL2hXQS9SUUhLdnpQV3I4R3ZoSXdkUGhaeG84NnFnT1FtR3B3?=
 =?utf-8?B?SVFrMlRubDd2bE1RTnFpRjZCN1BFS3hudmZ5MXg2NGs2Qm1QajhjUnJWVXFh?=
 =?utf-8?B?c2JWL2tNL2ZmKzUrUk5oVTYyb0FBVnplSjhaTWZ5eGZQOW5NL3BqcTRtbDJZ?=
 =?utf-8?B?QUs3N1pNSGJzNXMxeVZnc0ZVVEh1ako0cnhKc3VtK1VIWDBMOXlDL0ZhQ1Iz?=
 =?utf-8?B?NkxwRUprRTVuWUpQS1prR2tSeDJoRlJUVnhzQXFMM1V0YStDVnRUQ01PSDFD?=
 =?utf-8?B?NG8ycU5kRXVxZEY0YTNrdEl0VUY1ZUo0U2gyYlNGcjNuSjc1d1dzUUU3cUR1?=
 =?utf-8?B?S1hMMUpObXM4UTExSWRaTVAvZDJ5SWJsV0tWVXhQRWQ4OEV5K1NXdXhLSnpB?=
 =?utf-8?B?WEJwOWIra25xZW5hS1F4MUx3bFpCZk1EWmV2VzlSRitCRU1lNDlFZHBJSWp5?=
 =?utf-8?B?Tm9Oam1rOWljU1BvYVBmbjM3L1UrbGErV0FTbUhQM3JmWDZRVng2Z1h1VTJr?=
 =?utf-8?B?RW1qdkk2TVdsODkvT1RsZlY3eitIOElOZnR5Q092ZDYxUmZIcG1PMzdTdzBV?=
 =?utf-8?B?OEJvdzlqclplR25LdUhTcmwyR0s5RzRFazV1a0h3dVFrMElWeHZEMjZSTVRJ?=
 =?utf-8?B?Qkw5MWtTK0dZNWd3RTl5SnBtSTduM21BNmRJdWRxKzRyMFNIa0lVZzZKQkU5?=
 =?utf-8?B?VXJaRER2V0RiTmFGV0Y0eDhROGlGcjlLemZWMU51VkNNSVY4ZmVnYUkvS3ZE?=
 =?utf-8?B?c21lMW1Ja0Z6dmhPb1NQQndZMno2VVhNVkRyZFE2alJ3ZDYxdml6YWZ1ZC9D?=
 =?utf-8?B?VGcxcUZQL3pQS3NIWS9wV0JaRWl5RzlWcVBnMTVSclYyMlArOXpnVWdtck5M?=
 =?utf-8?B?MGsxNnhhTnZSMXBwQVR4bnZHRjhQc2lVS2FnTStkeVk3bGwyUThkSHBCeGlh?=
 =?utf-8?B?Y1VpWVJTMm5NcGpvZm4xNFk3SjBhWE8wcWdFYXFqblZRNisvME1WSDk2R2xk?=
 =?utf-8?B?U3pRVEZIQ0xXSlBaTVRDZ0pyaVVLVDArRGZSc0tYTkhpOWlPaGNjODdnT2do?=
 =?utf-8?B?R0ZrdFVXa0tjNkVpMWQ1RGJyTUNKVGtxM3JwOXEwWjJDcFE3NmFxTkJRcFpo?=
 =?utf-8?B?TjFWWjRVQU1rTWpMVkxZbktBb1Qyc0FtTFVPbm5Ga2tTTWZkR3Z3NzF2Y0V6?=
 =?utf-8?B?enJkN00zbFJPVEUzbDdDZzhpU2ZNOFBlT2FKU1NLYnBJdWFrV3VaSndPaGIy?=
 =?utf-8?B?YWxHSkYxZG5HMUtHY21FK3NUNklWQmZ3WVM4T0JmNVlvaElvNHBuZVQ1dEZx?=
 =?utf-8?B?S1JUdFRVSFhNeFpSckxpczIzajhlNnJPMEtoaHhhMlVkQ3JsNXlXeUQ4OWdl?=
 =?utf-8?B?UEFLUlVxMTRXMk1ISzZpY0YzeHlaVDlJbCtWVUszbUhTUjRVaVlWMWNBUlRi?=
 =?utf-8?B?NjVNQkZVUmhyZkZXQ2I2a3R0cVNLOTFvUStablhYcUhCUC9qYWJtSCtjNkhw?=
 =?utf-8?B?eExvUmZnemhhN21Ga1k3WHlFSE1NYVg0ZUV1Q2tIempzdGtxditXcEpLam52?=
 =?utf-8?B?YmI3akJmdk9abUFMeE1lbzNEWCtrZnpObW5WK0kyTlhkdW5LcDRMZXViNi9Q?=
 =?utf-8?B?VDA1bzhMYjRlYnNWT0NKeVo4R2xFTWZZMjlUby8yZ0h0V1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjNDQVJiaUkyZ3ZNSHVDNlM4MFRQS1pFV2NzV1pkT0kxbnBQTW1oYzU1Znk5?=
 =?utf-8?B?THFsZlNlTzlDV3pTMEtzNGt1dUxZNDJaRFNrNzNTZHY1cjNZYmg1dkVCR0NY?=
 =?utf-8?B?emY1VHpQdlI1NkwrVmN6OXRGQVVsTXdUT1B3ZWZaMmJkWE1HbFNUZlpIelR6?=
 =?utf-8?B?eWRSZkdLS2VEWm1BcDRZYmxBWlY3cHpwTklmUWhIZlRqMUNvU3Q0VVplaDlK?=
 =?utf-8?B?MFVMSGVGUElCdzlmb1NPNWY1ZjE4V0d1ZUdNNHJQU0IrZHBMUXVMVHR0Z2Mz?=
 =?utf-8?B?MDYxZVJoNktUblhXYzRhUmNNVFBQUTNiQ1hNNHZWcFFMd2xkRG1abjlHNjQ2?=
 =?utf-8?B?SzUrblBCV2dHa1FId05QdzNTYTVuUEpYc1piUFNWQ2NXVVRmaEhadVpUUWtX?=
 =?utf-8?B?czh0c0pDN3ZpOWFBTmJWSUdadTFGYlJLU2F2Q0NHUlNEWithOXhCb0dqbUw3?=
 =?utf-8?B?SU1PWDNTWVdEVG9lcEIxdUVnZWdOUmp3aFJtTm9zQlk4WU9GTXAyZFZVdTh6?=
 =?utf-8?B?dDJkVDJRUk93TkllV2c0cE1tN1dHcTB4Y2lVdHN2aGJ6U0VVbnh0K2FLcVpO?=
 =?utf-8?B?RnZZTUJXT3JjaTVoNXhWQWJyT1F4am5CdVUveGVkNWwvbnNoWDJEVUFYMzVm?=
 =?utf-8?B?LzNFZmNXZnV3eWVNM3RhQTBOT014Z0h1ZnJsOU1DYzZseEl1L09TUGxNZ3Bv?=
 =?utf-8?B?dURaNFBPcXI4VzVsT250OXFrd1poaVdEV3lERmFFMUpCNVN1TmRFQms0QzNO?=
 =?utf-8?B?R2pveTY4VERvd1p3ZzB1Z3BDQUVMWGFNSzMzMEJsNWN2bHJ3d25EY0hZeVFm?=
 =?utf-8?B?b3kyRVhJTDhNMWtPVUNid2o0YWJkQnh4VHJYNndxWlZqK1VUZVZyYXpJQ2JG?=
 =?utf-8?B?QVUvWHhsdXRMMi9RK21SdjMyQ0NibXJzUVBucnEwS2Y5WFNxVVdLTUtCWGlJ?=
 =?utf-8?B?RStZeVVXYUwxNmdUMXEwcFIwT0QvYlloVWVrMWE1WkJ4ZWNtMDJ4R2pnZ3ZM?=
 =?utf-8?B?UWIzTjd5M1hvQ3dlU1NPZW1BMTc5YWszUmJRWFA2Q2Zoc3dIeUpCNUMwWVRQ?=
 =?utf-8?B?d1greGUxa25KSmhDSThCYXpiVTRNR05ERkNCSmNXNHRsaTkyNUpyZnRsL0x3?=
 =?utf-8?B?TUxqTjQ1K2cyeGttUnc4T3dvbUpGOFhUTldqaHYrZzk4Rk9QQm54UjhnMXNT?=
 =?utf-8?B?R0Y5SitqZDhzb0hBcWR4RUFlVW5UYzJMWnJzdndaZklGNjVmNGF1Wnl1MW11?=
 =?utf-8?B?OElhbmRyYWdqYUFBUmVFb3BueFZyMVdHeEFRZzUvc2pRbGRTMkljMGM0K1Vl?=
 =?utf-8?B?Lzl6RFhhUE1UL05XWkhxWnc2alJUWjZaaXdCSE1UcEJGbTU5V2E4YzExMkpQ?=
 =?utf-8?B?K0tkekxvQ3NXUEg2WHFhb2FYdXkwV1J4eCtRaWdMMTNkQlpLQ3pGNTQ1Yzdy?=
 =?utf-8?B?WFZJTFkvYzFqN0JRaGsxOUl0NWNkSEZNMGlsYWZHS1lPVWtpNmlXcldmQzhH?=
 =?utf-8?B?MDZVZ2NTQWNXV3pjUzA2dktCVG03OG9rSmQycHIva3BJS3B5NmdtdmEydlRz?=
 =?utf-8?B?NHA0WjJkOXZPTXVVcXd5OGdlb2IrcEdGVFpYRmRLZTRMK1FHdUx3dWx4aXp1?=
 =?utf-8?B?aEhoamZKNzlLc0xiV0FlZHEvbkVCRFIzaHJUc0hvQmF3eXpKeVoydTBzUkRp?=
 =?utf-8?B?VXpIYWYrV2x4SGYvbzR0U2FyTGxjTmJ1SjBpQVBiRTZjNlA1dGtYay8wWmZo?=
 =?utf-8?B?SVRDTzlqUXAzM3BFMm1zbVYyUjRPUFRneTJLck5TcmtKdVNRVzRXNlhzcTdu?=
 =?utf-8?B?bW4xNXVMa29TWHVqVGZNbXJFRXBicDFKaVA4TnAxY3ZYcWd0NFZCRE9UL09W?=
 =?utf-8?B?VWJEUHFxcGtuS21oM1ZoaFBWd1RZQjNXQUMrNVdrZkdiRExzQ1RIRDUza0dG?=
 =?utf-8?B?bzlQcDdSSC9BZjJ0R3lydXVRMnppTXhtQjJuSkhZUXBsSFRmVWNFYVEzYXFL?=
 =?utf-8?B?VFpWN1R0dGdtdnJBK29YdWxWRFNOTXVXZnV6aHc4L1o4MkttYTBxUmZmUXpF?=
 =?utf-8?B?WjFMNVRyL05CSjlRUGMxRHBQbmVYOUdydWd0bmo2S1Z6SGE2a3FjWWVyWGhj?=
 =?utf-8?B?T2dBaXVrWVNmWXVsYW96d3JSVURsNDAzN2t3UVFYY21jcUtUTkM2WFJGU1da?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7286fe-0506-45f9-9f84-08ddf168e7cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 19:25:02.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoDe5WHSqmwTEkUJ72QSsjyoKMIwnJCDoC8wIMv6IRjjvmEjfBtN+Ssuu3DCaJB8Iv2W5DjYiE/FDhFtvvPq1+1IxN0HBWuPZeOjVzT2kWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
[..]
> >> Aneesh, could you perhaps extend the IDE driver by adding the RP address 
> >> association register programming in the next revision of the DA support 
> >> series?
> >>
> >
> > Sure, I can add that change as part of next update. 
> >
> 
> This is the change I am adding

Just thinking out loud...

I assume we will soon get to the point where at least one of the vendors
is ready to have their implementation pulled into tsm.git.

For truly vendor-specific bits that can be a pull request that I just
blindly pull. For core update proposals like this I expect it would be
best to cherry-pick those into the base at the next staging tree update.
This would be in support of prepping tsm.git (at least the base
infrastructure) for inclusion in linux-next.

As always, open to ideas on how to coordinate this.

In the meantime the tsm.git plan is to continue to rebase the base
infrastrcture branch until the review comments subside and all new
changes can be handled as incremental updates.

>  drivers/pci/ide.c                        | 128 ++++++++++++++++++++++-
>  drivers/virt/coco/arm-cca-host/arm-cca.c |  13 +++
>  include/linux/pci-ide.h                  |   7 ++
>  3 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 3f772979eacb..23d1712ba97a 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -101,7 +101,7 @@ void pci_ide_init(struct pci_dev *pdev)
>  	pdev->ide_cap = ide_cap;
>  	pdev->nr_link_ide = nr_link_ide;
>  	pdev->nr_sel_ide = nr_streams;
> -	pdev->nr_ide_mem = nr_ide_mem;
> +	pdev->nr_ide_mem = min(nr_ide_mem, PCI_IDE_AASOC_REG_MAX);
>  }
>  
>  struct stream_index {
> @@ -213,11 +213,13 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  				.rid_start = pci_dev_id(rp),
>  				.rid_end = pci_dev_id(rp),
>  				.stream_index = no_free_ptr(ep_stream)->stream_index,
> +				.nr_mem = 0,

Designated initializers already zero by default.

>  			},
>  			[PCI_IDE_RP] = {
>  				.rid_start = pci_dev_id(pdev),
>  				.rid_end = rid_end,
>  				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +				.nr_mem = 0,
>  			},
>  		},
>  		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> @@ -228,6 +230,109 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
>  
> +static int add_range_merge_overlap(struct range *range, int az, int nr_range,
> +				   u64 start, u64 end)
> +{
> +	int i;
> +
> +	if (start >= end)
> +		return nr_range;
> +
> +	/* get new start/end: */
> +	for (i = 0; i < nr_range; i++) {
> +
> +		if (!range[i].end)
> +			continue;
> +
> +		/* Try to add to the end */
> +		if (range[i].end + 1 == start) {
> +			range[i].end = end;
> +			return nr_range;
> +		}
> +
> +		/* Try to add to the start */
> +		if (range[i].start == end + 1) {
> +			range[i].start = start;
> +			return nr_range;
> +		}
> +	}
> +
> +	/* Need to add it: */
> +	return add_range(range, az, nr_range, start, end);
> +}
> +
> +int pci_ide_add_address_assoc_block(struct pci_dev *pdev,
> +				    struct pci_ide *ide,
> +				    u64 start, u64 end)

How about:

pci_ide_associate_address()?

...because the result is not always a new block.

> +{
> +	struct pci_ide_partner *partner;
> +
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +
> +		if (pdev != ide->pdev)
> +			return -EINVAL;
> +		partner = &ide->partner[PCI_IDE_RP];
> +		break;
> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (partner->nr_mem >= pdev->nr_ide_mem)
> +		return -ENOMEM;
> +
> +	partner->nr_mem = add_range_merge_overlap(partner->mem,
> +					   PCI_IDE_AASOC_REG_MAX, partner->nr_mem,
> +					   start, end);
> +	return 0;
> +}
> +
> +
> +int pci_ide_merge_address_assoc_block(struct pci_dev *pdev,
> +				      struct pci_ide *ide, u64 start, u64 end)

Is this really "merge", or "expand_to_fit" similar to
insert_resource_expand_to_fit()?

pci_ide_associate_address_force()? ...or am I reading it wrong?

[..]
> diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
> index c9717698af56..28993f9277e4 100644
> --- a/drivers/virt/coco/arm-cca-host/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
> @@ -137,6 +137,7 @@ static int cca_tsm_connect(struct pci_dev *pdev)
>  {
>  	struct pci_dev *rp = pcie_find_root_port(pdev);
>  	struct cca_host_pf0_dsc *dsc_pf0;
> +	struct resource *res;
>  	struct pci_ide *ide;
>  	int rc, stream_id;
>  
> @@ -163,9 +164,21 @@ static int cca_tsm_connect(struct pci_dev *pdev)
>  	if (rc)
>  		goto err_stream;
>  
> +	/*
> +	 * Try to use the available address assoc register blocks.
> +	 * If we fail with ENOMEM, create one block covering the entire
> +	 * address range. (Should work for arm64)
> +	 */
> +	pci_dev_for_each_resource(pdev, res) {
> +		rc = pci_ide_add_address_assoc_block(pdev, ide, res->start, res->end);
> +		if (rc == -ENOMEM)
> +			pci_ide_merge_address_assoc_block(pdev, ide, res->start, res->end);

How does this play with the "shared MSI-X MMIO" problem? Does this also
need to align with interface report expectations?

> +	}
> +
>  	pci_ide_stream_setup(pdev, ide);
>  	pci_ide_stream_setup(rp, ide);
>  
> +
>  	rc = tsm_ide_stream_register(ide);
>  	if (rc)
>  		goto err_tsm;
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index c3838d11af88..3d4f7f462a8d 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -19,6 +19,7 @@ enum pci_ide_partner_select {
>  	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
>  };
>  
> +#define PCI_IDE_AASOC_REG_MAX	6

Where does 6 come from?

---
7.9.26.5.1 Selective IDE Stream Capability Register

The number of Selective IDE Address Association register blocks for a
given IDE Stream is hardware implementation specific, and is permitted
to be any number between 0 and 15.
---

Also, I would put this max in include/uapi/linux/pci_regs.h and match
the local naming.

