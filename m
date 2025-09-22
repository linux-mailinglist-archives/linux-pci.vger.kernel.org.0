Return-Path: <linux-pci+bounces-36656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA6B9077F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6FB18A08FF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D168C261B8A;
	Mon, 22 Sep 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YesvAArr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BF191493
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541674; cv=fail; b=ZyFzSuG1njhvPzkr//d+49zRvivFKSf1niOJnN8aMtTsjJSa/NuuF94n6lZophlrDIJXazvM078BpR/DlICGF61fdaN76vnQ7bNLFEdMc/lHuBHKRTkPLKnHD3997Ngpnj3HhMVSOnyUyoi2R46gRIQuiG67zwapAHNQ+MkRD/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541674; c=relaxed/simple;
	bh=sqOgyJHVcEaCZpQBeslO1dgy/g6fcbfJPTlh0eCiD1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GaKP9oWDBi7/TkKL3C0cqynCG9uFqCaalOMlNviDaUtAPnRwd2/0bUy1SIVrLagz6sg2H2ONc1oVj3fNWGrpm9fm9GGuTKaao3iWFQyLY7Tctc3jZOMaiUgk1lrGlF3qzBiEl+PDc5dg3MqucPRDhfdtWDzpH802LiUu1tTJAq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YesvAArr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758541673; x=1790077673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sqOgyJHVcEaCZpQBeslO1dgy/g6fcbfJPTlh0eCiD1U=;
  b=YesvAArrYv2Abd1pYXiSxhImXcoo7Q/vt3yUIhgp356szweotdYOR++D
   Q60amOFhFqkPQY0xe3zkOCaE617HYE3oLEk+5sEPPEU7OOoRjlnt7LuZm
   jKt0cGsu0AV4fWShQdxvz0WeSWy/d/mObbSqXq+57NWwHkbBcuB7vhKQV
   fp5zJS+BYYQLVicvTo1bokmhKAj9ESK8OSqQ+2BMyNGPqG7F8m0wGJTEM
   aKOLOMmuNBv+tm7JrZluIRLLMznAMAccMB8BbDme6KtnJIxW4IPr6S+N+
   bEbDFXAINPc6bdywVKOo79ElgySds+MQisN7houp68TXlG38CfBWe1W1H
   w==;
X-CSE-ConnectionGUID: cmYNkMirT72ajwGYRGwnjw==
X-CSE-MsgGUID: PFFx15UISQWvhlJLncH4yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60715176"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60715176"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 04:47:49 -0700
X-CSE-ConnectionGUID: CrI/xv2ISGCj/+9HB9u2tw==
X-CSE-MsgGUID: R2hmD2dBRoesD1f0FKSH5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207197293"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 04:47:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 04:47:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 04:47:48 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.53)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 04:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFNAT/NplEEcVLRq7ybp4KGoFbre5Y337TPMEt1FeG++ZFE/zxGttPmZYd06M7rceDP2RLItPZ1F1A0Bik/lm8de+yXudqE80BwWZ5d5GiErz0W9wODj1Nj//67s8fZr5kGcqn3ol4EZyTOAKqBAS6vXJ7RLg9jOw2wFsZ6BquNOfDsrUbP9trYJjTdH8jVDKgbBj0IlzsHQKI+/12qT3YxKR+oPOBNh6X7MkquevHA8lYq77iLKPqa6y95fFiDsdwqfxVJbHqCpRnMMvYMpjiUpDNP+b4VMQ4MvE9Qs/Tw+SLbWSLgyx/94ReC15BR7Gvez9CsHXMrcMIXlvnf+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqOgyJHVcEaCZpQBeslO1dgy/g6fcbfJPTlh0eCiD1U=;
 b=OnKSdLjaS/hRr4uovRqFUy0CZ0WHHoud5hbX6wEvetD2THO/XNervdAprjQ17TTMXewpwzapGA4uOxN8vvNcPYbX0qq6FuQsnwQjL5FwTB50o6QHErnB1TGyi8ZVGX6Xq2Z++vjYz2ZK7XGba8XamcYVshLRH6bLQRHwZjIbiijCPkrc/bSTiXBaKBL/kigVqxkU8JWxNDmHvBpFJbOb+5qS7XLdKUv+DEf2VolOpUgewfcheCFK+Lf+mVAvj0OxqiJ+ZZmuopx9PVhskV+Rd77IpBSspWH+ilc35mVuN59/s8asA8/zQhQNuwFl1w1hrTgQ/CEqwPAFi0SGLDPzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Mon, 22 Sep
 2025 11:47:45 +0000
Received: from BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66]) by BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 11:47:45 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"xin@zytor.com" <xin@zytor.com>
Subject: Re: [RFC PATCH 04/27] x86/virt/tdx: Move tdx_errno.h from KVM to
 public place
Thread-Topic: [RFC PATCH 04/27] x86/virt/tdx: Move tdx_errno.h from KVM to
 public place
Thread-Index: AQHcKXDqgq9PqZ+ITkKmHwkLJ47NQrSfGoQA
Date: Mon, 22 Sep 2025 11:47:45 +0000
Message-ID: <e8632f1ea565d219b67878ba846a880990b8b192.camel@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	 <20250919142237.418648-5-dan.j.williams@intel.com>
In-Reply-To: <20250919142237.418648-5-dan.j.williams@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5525:EE_|DS0PR11MB7334:EE_
x-ms-office365-filtering-correlation-id: ae1aa555-d752-4325-ce60-08ddf9cdd86b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VGV5c3BENVc4c0VYbk5zMC9xcytHNHpuQlQ2VHJNQ1NnanVMQ1dJL0QycytR?=
 =?utf-8?B?UGlEYk4vYTkrZDhON1Fic3Ixbnl3TDVzdnhFcVRUaFRsNGs4c2VQUGRyK3hr?=
 =?utf-8?B?c2F4M2cxRWhoVVhST2phbFArV3daLzlpYVZQUTd4Rm1sQ05QSXJSSmFJK1h3?=
 =?utf-8?B?UWI3b1ZhbVhqajBHOU81Ung4eHpmcTAzNzZyUnJINHB6aWo3QzhwSmpoemR2?=
 =?utf-8?B?cjZJdm4zdW9sZ1JpaEh5clB3VFpRc0wySWVaSUZRS0hxZ29IYVVaWXJZcXo1?=
 =?utf-8?B?TEp5OHBFOVZCNVdMYUgzbFh0UzRTYWpCcURWTTNxOHo0OXkxcXhhRVpoWXZi?=
 =?utf-8?B?WVJQYys2L1BwMzI2bHhvaHlJOXppc2k5U0NqWWJWMytNTnFXWXdKRGM1TnR6?=
 =?utf-8?B?TU0xaEVtbXFzek1hZ1ExcW9SZ3lUVGNRU2NERUF1R2ZJTldQVTNXVWZKTkRT?=
 =?utf-8?B?Y05LVjFORHF3QzBrdHhHSFhMN3BqTWZNdHFHZ0h0Rk9lSE1lODU0OHBJQ0F0?=
 =?utf-8?B?anMyZ1p4OVpsYXdSemN3a2ZwN3E2cUZtNkVuNUZ6VFpJT2pNOGtkTmRkL01R?=
 =?utf-8?B?bHVjK1gzWnZUNzBGa09Ta05TRXF1blZrU3FyeE11cWg4ejBjMnFjTmkrbTZT?=
 =?utf-8?B?K2E0SHJzZEJoNnkvTWllcnlWUG1pNU1BUHgwSzNCZG5SZnJHcUxLWUVqUEUr?=
 =?utf-8?B?RG9XZ2xuTlZiUkhmdGJKK1FxUU42aFp6WEIyMGpEU2lGUzcxb05LQ2lDc0ZY?=
 =?utf-8?B?c2g4T3hja3RLb0paQ3dURkthTGNnZGtXb0ZhZTAyaUpJWHA2UDZ4VStrWjFW?=
 =?utf-8?B?cXVzZnUwbzZyNFYrdnlCaDU0T2RuUTFjTVRSWTB3dU1kNU9hRHFpWGhWR3dY?=
 =?utf-8?B?LzRHRWUvdnhPLyt1bnEyaEZSVjlQM0RCNGE2eDZwRVN3cHZBUmNRL2dIczMx?=
 =?utf-8?B?U0g0SSt2KzBGUTVEdE9Xbkh5L0VYc0VKQjhtTElSNjZvaklPb2t4RGJDNmd6?=
 =?utf-8?B?WTdEYlk2Ym5UeGt3R2RZRlBIOUJoR0k0ZGU1aXBaMG5zMXlGa1lEdW5tQ3BJ?=
 =?utf-8?B?L3hGaUp4WHJ2NWM3UFNNbzM5a2loOElvTko0dFZrYkRYNXZObUd0YmpjdHJy?=
 =?utf-8?B?SnJ5MXp4cUhqejZmRHdpVkZYOGVwQk1Rb3pONVZSeTRicTdzektJRkNNRGZO?=
 =?utf-8?B?THRvbTFXYlY4SjhnakhzVmpuNkc1NnllVmNpSTA4cGpSYjlJbzc5MU9UVUJR?=
 =?utf-8?B?TGh6QUtlOFVxUWQ1MFJubjl1S2treW1SR0VIcUlFODJBalhMbTJ3cmc2MHhN?=
 =?utf-8?B?b3hqTWdBa3lhZ2QrdUtRcXVWc1BTM3pwTUxzaFphOGVQeHRGa0Q2bU1FOWMx?=
 =?utf-8?B?T3k4MlN4Uk9UUTBFaHB2bFVlcEZFK1gzS04yNEtGY3cyRDUzS3V4V1hxZmNk?=
 =?utf-8?B?SnByeVFlUFJXZlE4K21PMk9PK3pMc1d5MEhoYUM5WW1JZ1o5cWFsYWVSM2ZI?=
 =?utf-8?B?cDNFU1pGUEpOVmdreFF5TjJMLytRUElBeDFLOXV6eWdiN0ltdEhyWm9DNk1Z?=
 =?utf-8?B?OHBUTGlERnk5K1dycFNhWjNKTnBHQlhmZ3VyQ3JiRk96N21tdDNrSjV2Mlhm?=
 =?utf-8?B?eW1KVTRuWWJUU0QzdkdidEh2TUdMbVNlYkswUDdYWkg0Y0RxZkIrRVd4V3A4?=
 =?utf-8?B?M2EwSVNXOWt2TFkza3FPajRSSU1HSUpvd2NBdDZJS0loNUlkNEt1LzVaVUlq?=
 =?utf-8?B?UkFxWnhjV1Jad2YwMGdhbHNselpiRUgzSEJvVmxUVWZFU1RNc0NmTU9NSHJs?=
 =?utf-8?B?TGlDOVAwU29zMThpeU9yVjZzZEExMTliNW83dVlQeURwdXlzTVkySGFQTy9P?=
 =?utf-8?B?Y0VlaHViRUluY2N5QVRPcWpqT1pzVzNOQy9vUnNsNTFsWnRJYlZpL3Q2OGdY?=
 =?utf-8?Q?IDANKzmeDNU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5525.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ylh5djJreTljZUxQM2xXWnFwYlJqamRCMGZ6c0JqNm9NVk4yNEZERHBEMXIy?=
 =?utf-8?B?aGxNb3ZQL25taDBHT2FkVXZIMmp1OEFCMGhTcFdCeTA3ek5VSjJhbTI4U0JS?=
 =?utf-8?B?UlptSW5PWndMdXl6T0ptbnlzYmg5YmlEUU1wMGdVSUFVQlBmeEZrY3Nzcll0?=
 =?utf-8?B?TURZcFNzNC9rQVpmQlVRTDRzaW1PZXJDblZseU9PSEhqY05wZ0hWdnFmbTh2?=
 =?utf-8?B?NHNlVUZOZlZjMTFvbStSU29EQUVIOGhHTmZxWGRsN0NIT3J0Rm5pQk5zNDBZ?=
 =?utf-8?B?eEVUck5BRmJaczYreG80YlpoazBwM1RMQ2tpbGp1SjVxTUp2cjk3dzNuVnJD?=
 =?utf-8?B?Sk9ydC9LQjM1RDRrUWtxRTAyWHcrd0FDa1MvN2p5SWFSb2h5ZjVuVTNvWThu?=
 =?utf-8?B?ZkRRWit5TGp6NGc5Sm95cUVHK0NjQ2c2TGhvaVIxWjhQOVIzZ2pZLzVvaWgw?=
 =?utf-8?B?VGJjcjRLMEZxanFGaGVLQlBnMUZJZitjOWM5STcxZllDNDhWek1IM3F5dlFW?=
 =?utf-8?B?Q2hqQkVaclRkUWVjeG92U3ZQQVBuZEtuUU5LYStSek5sbStSMng2OHQxdnZV?=
 =?utf-8?B?Q2xNV3ZZR3E4UGJpREk5RTdyTVBZYUNZSytvVnFnUytjT3hDWVRmZ2txTk5K?=
 =?utf-8?B?cFBsdlBVNEZJS0xOb0p0aG50Ym5Pb2hncDVWR3ZYWEZpUDdsWkFad3dLaURv?=
 =?utf-8?B?d0hGMFVmWjh0bzdPRlBWQVAwOVJsb0lpaVdGaHB6ZC9NVGQ2di96WGYzZGRi?=
 =?utf-8?B?TU1pTTBjT2xHTDBpY1RBMG9BeWtuUDIwTFd3NG9DNDVlNmZIQTlGK2twZFhp?=
 =?utf-8?B?V0s3RmJ2TU04WVFtcjFJWk9kWGlueWJ0UzhBbFcwQVMxU3hTKzIvVEFmRWRr?=
 =?utf-8?B?NXpzdGhNb2hoU21SNTVWMFRMMm5HQjdxRklQYTRpZTBiUFFPWVZPc2EzQlFF?=
 =?utf-8?B?NkZrSGNxMDJJSWk1cXJRZThLdmYrbUhDUGdsQ1RuYUNwWUpxckZFdHdsYlF4?=
 =?utf-8?B?RHJlendYclhTLysydGJqaE9uellKckZvNC80SG5vNkdkaTEyaWlKNUxCMS9E?=
 =?utf-8?B?QmE3dm5sdFRQa3F1b1dnYTZQQzNzemZ0bDU4bkNXczBDNHkzSXk0YU9EdEUx?=
 =?utf-8?B?aGhKblBFUmRxdkVKWk05SjhteWVXV0ZYZXp4TDVNZ2cvbkNsbDNYN1JLUzJP?=
 =?utf-8?B?SWxaRTdhSDg4NCs0V0d4REp2Sm1URnF5RXVmLzdVNDk4d1JEWnJWMHR5VGI5?=
 =?utf-8?B?OStwczRHc2poeE45WEs0Tlh2cGpYUmc0QWM4UnZ4UlFzSVpXT29RT2ZhRVFZ?=
 =?utf-8?B?RVBhTno4N2pFejZwMkEybGI0dmVrTXB3N1RuOG1kSWFYbDBXSTF2MnZ1QVdi?=
 =?utf-8?B?bndXcGRHVkdyVTFscHRJalpkaWhCajIwZzcvQzBMZ283OWZkSHlsK2hzODZk?=
 =?utf-8?B?a0lEUEZVcVBERjdmaGxNZm5BMjhuWjZucXQ4TlFoMnRJOWJIQ2V5Z0U1M2tk?=
 =?utf-8?B?TVFSdnpjdFJnU3hrOEkrbmJCYzdkRm1YWTZKK0MxTzFQYXpBK21FclJ2ekp3?=
 =?utf-8?B?MjFmMWhUZEROUkVIZFg1NEZ5RnpLLzJxS0psNFVXSkphS20rdEt4TkRWT1cz?=
 =?utf-8?B?QzJxbFRCN0w0RDR0Qm5UMGVhUGxLeEJlemtScSs2bHovL1dqQWZBTnZ6N0d3?=
 =?utf-8?B?elJTcERwSWtrbXVicXFGc0NpUjg2cTE0WlNlNjZ3K0V1anc4Q1dQVVBScUh0?=
 =?utf-8?B?OGJmSUtZdHNkTHpzOVJEWFFLU3dwd1N0Z2hReDJHUEJJNTlXK3ZXNG5FSEpX?=
 =?utf-8?B?bnBkRTFGeWpPZU1aeWJITWE2ODBTVFlhcC80UFZzNUllNGtlODhqZk1ZQjgw?=
 =?utf-8?B?RGc5MHNQMzNBdmpjMHNXSkcrcy8yK3BQeHM3TzJYZWRld1VWS2FnZUVQdUdU?=
 =?utf-8?B?bEZia25DVzNNdjRTMWZyWC9oK1YyKyswVjYwc1dxamVqTXpFenlrcXI1dXpx?=
 =?utf-8?B?TUYxWnRXd3doTWFVWXpEZTlhWGlvUmtOc081bzF1UVFCZEJWUlluNUlEY3N2?=
 =?utf-8?B?N0dPbmhTeDBlREV2MWZhYmJSZjNVeC9WRmxDckJTTU9zbi9PbnBrSmgvYmRv?=
 =?utf-8?Q?n9quZZ+6C3u4UkoYohNT4a+di?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3874FEC2B63D5448B326835CE23A31AC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5525.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1aa555-d752-4325-ce60-08ddf9cdd86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 11:47:45.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWemzR2HYcXSuBagmKSLA+83qs6UoIUrGcnQzR+kilV1ok+qdJ0lWQDH2ag/Mji61kFjaUn6i9olOg9O4YSrfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA5LTE5IGF0IDA3OjIyIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEZyb206IFh1IFlpbHVuIDx5aWx1bi54dUBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBNb3ZlIHRo
ZXNlIFREWCBNb2R1bGUgZGVmaW5lZCBlcnJvciBjb2RlIGZyb20gS1ZNIHRvIHB1YmxpYyBwbGFj
ZS4NCj4gDQo+IFNFQU1DQUxMIGhlbHBlcnMgKGRlZmluZWQgaW4gVERYIGNvcmUsIHRkaF8qKCkp
IHJldHVybnMgdGhlc2UgZXJyb3IgY29kZQ0KPiB0byBrZXJuZWwgdXNlcnMuIEl0IGlzIHJlYXNv
bmFibGUgdG8gYWxzbyBwdWJsaWMgdGhlIGRlZmluaXRpb25zIG9mIGVhY2gNCj4gZXJyb3IgY29k
ZS4gVERYIGNvcmUgaXRzZWxmIHdpbGwgdXNlIHRoZXNlIGVycm9yIGNvZGUgd2hlbiBlbmFibGlu
Zw0KPiBvcHRpb25hbCBmZWF0dXJlcyAoZS5nLiBURFggTW9kdWxlIGV4dGVuc2lvbnMpLiBURFgg
Q29ubmVjdCB3aWxsIGFsc28gdXNlDQo+IHRoZW0gaW4gdGR4LWhvc3QgbW9kdWxlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IC0t
LQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmggICAgICAgICAgICAgICAgICAgIHwgMSAr
DQo+ICBhcmNoL3g4Ni97a3ZtL3ZteCA9PiBpbmNsdWRlL2FzbX0vdGR4X2Vycm5vLmggfCA2ICsr
Ky0tLQ0KPiAgYXJjaC94ODYva3ZtL3ZteC90ZHguaCAgICAgICAgICAgICAgICAgICAgICAgIHwg
MSAtDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gIHJlbmFtZSBhcmNoL3g4Ni97a3ZtL3ZteCA9PiBpbmNsdWRlL2FzbX0vdGR4X2Vycm5vLmgg
KDkzJSkNCj4gDQoNCjxhc20vdGR4Lmg+IGhhcyBiZWxvdzoNCg0KLyogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICog
VERYIG1vZHVsZSBTRUFNQ0FMTCBsZWFmIGZ1bmN0aW9uIGVycm9yIGNvZGVzDQogKi8NCiNkZWZp
bmUgVERYX1NVQ0NFU1MgICAgICAgICAgICAgMFVMTCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICANCiNkZWZpbmUgVERYX1JORF9OT19FTlRST1BZICAgICAgMHg4MDAwMDIwMzAwMDAwMDAwVUxM
DQoNClBlcmhhcHMgdGFrZSB0aGlzIGNoYW5jZSB0byBtb3ZlIHRoZXNlIHR3byBpbnRvIDxhc20v
dGR4X2Vycm5vLmg+IHRvbz8NCg0KQnR3LCBSaWNrIGlzIHRyeWluZyB0byBkbyBzaW1pbGFyIHRo
aW5nIGluIGhpcyBkeW5hbWljIFBBTVQgc2VyaWVzOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9rdm0vMjAyNTA5MTgyMzIyMjQuMjIwMjU5Mi0yLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29t
Lw0K

