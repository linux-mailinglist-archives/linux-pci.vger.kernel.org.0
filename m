Return-Path: <linux-pci+bounces-33442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63770B1BA0A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 20:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1514418A60CB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319825A2B4;
	Tue,  5 Aug 2025 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+KUhI22"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26594200127;
	Tue,  5 Aug 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418465; cv=fail; b=epMpsQjaD/0IKo9Dt7GiZsVZSXmjEeeW7iUXLyKc3ihuQ8Lx8dL34pBLZjQbuWZu6Xlek3uIsYHRCKf9fVpQqcR2v6KSoOSocoYf/ePJQTzmak+u/KwdDI8F9LkmA11/35wcRKV1ZPR8rDic8fq3NfDO1R/DVtBhidaicrMF+yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418465; c=relaxed/simple;
	bh=Jl0LG2bgaM0BPt99E1u4ozOdwQ3UhnU8sDslkBxW0LM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=oLIK3FUomFL6gZdsuVm2vgURaSR0P5rB3IWLwofddfMbbwRFBKFyGVo5sRdaagpM1MfXeK1zS88bsT9WHfuV9VpnhPjKhwyRpoOk1sF56ZXA/byHsMgwO4bvTrbXJEB/2Hb0bS46HhjTzRUOkhmtmhKR7gyGESdRBs1JjbPE6bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+KUhI22; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754418463; x=1785954463;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Jl0LG2bgaM0BPt99E1u4ozOdwQ3UhnU8sDslkBxW0LM=;
  b=l+KUhI22FNC2iyrBh3Z3J1ijfO1EWpQ+pOh/CiGYxNuBC9nEkraB664b
   s43HG9cWQ2m6kyes5GHzTgb3UWJwauj5xQ3zpvK+SPHqyxlzjMBWHTX0F
   vnFkvKCxEienlHefkyhQqE0hsFyDv4z48+SpUeVvivGT0MGFgk8MdKR5N
   7nWWD8h2I6cIoKAwDz1UTLf+ENnUYZFVXBXOT0ooYJjbboLr10XDxL9X/
   tOZ027iA6E3Kz5lxLPJMFlVLrrCIaZQ392OoLb/6xKOqH2R/cShlzHG3i
   pFNUwpgfX+5MVRiZ/9dMfd+dKqLRHweByiSKB2n2r5wmLKIAR2+CsSfh8
   w==;
X-CSE-ConnectionGUID: lTPkScfAS3CSSPtPc+aNyg==
X-CSE-MsgGUID: 9C1R2dS9Tsei3WYH3oi3Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="66992537"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="66992537"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 11:27:42 -0700
X-CSE-ConnectionGUID: CYOcGQ6oTeWO5CmZmqclxQ==
X-CSE-MsgGUID: NuIoCpL/RnmUtQrG/UNlyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164929236"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 11:27:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 11:27:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 11:27:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.68)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 11:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb1drKQ0Y7V1O6qXz/9e2ipVNTwubupgZiLcP0eA+1TfmHo8y/oZSm6mL2UF0RALvnOEC/i9LIPRsk5KTVjia+wIYM1aWshHj67pzlyV5q+BWDHw2YZvhm4kkXOK9Y1V7LJ1vgY5TeFwwGzPAYcTRlOuRIYHCkno6NtsDXTO3hMLjtsm4IETohdPWvkW5TtyA9gMYcCkoO+UOILHW1bHkkiu9inbyj9iQNCTyvTzByxwm6rTeG0H8x/KpYgeIgXpJNsO3Hsjg6T8DR7a5GoaSxTpjC6VALUA9R/DZwrSdmt0xbr925ze8zLcuvo1bYqd8aze6tXQl4tBaeVwYFXAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntpdwBODA/qBoideMTDWBWDxhGV1wUVQJJrWLeYY9Hw=;
 b=ipr39BeblDa4StiCS2TaxUHdPLFe3dIkoXQ/ohYU1kzgRVEKpYSSOUnOHZXw11whV4lofYVHR0Z1ejFQNTbRwyEysEm/U7ak5eKyHzNQqZlkA5V1mbigFt6QnsQcKmR9q4hewflJgCDSbNnf7SxKONuM+wLgU7i7SsNFf4nIdK511ErHnIvhMep0JJmv1//AJfG3Y9Q/4NRknxBhtNXtgvt0g2cVzmH4ZrfyLv+z124wWjgYurPZOhg4RFl2zvZlwKvVsvzhH4UYKMWfKI2PQhCoymGTwUpDDRQdZIUtI4bF+ZDjkHElATadA81CDN/qD/rkN/hHCm4+vsKQHqIK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPFD56C4208E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::858) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 18:27:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:27:38 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 11:27:36 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aik@amd.com>, <lukas@wunner.de>, "Samuel
 Ortiz" <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Message-ID: <68924d18a68d4_55f091004d@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250805172741.GX26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
 <yq5acy9a8ih6.fsf@kernel.org>
 <20250805172741.GX26511@ziepe.ca>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPFD56C4208E:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd766d0-053e-4b0f-a5c5-08ddd44dc1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0I3MkM2SGQrejNMV2VDdVFaWHFFVHlTY2E0Umc0dDk5allQTTlaTW5DTW5U?=
 =?utf-8?B?aGlWM2dTVmNjNmRJMW5zNkIva3ltLzBUb0VUTTB3OXNtL0lXTm14OVg0L3Nw?=
 =?utf-8?B?b3I4TVRJa2Q5RjMvRHZUMVhqcDk3a1lKMGxUaWFCM2tXNXBxL2ZjQmV4OStI?=
 =?utf-8?B?TlF3YUhBci96Ym92b25OWHV1dUNQNzMvaHF5SktSYmRiSWhza2VlQWl1V1NU?=
 =?utf-8?B?Z2tMWGd0WENPSlRmRmppRysxampyZjV6dFJ5bGxvRkVQaHJSRjJUYjI4MXh2?=
 =?utf-8?B?SUg0RklvOTFadHFJaFIxZ1FOZFVMM2kycnQzbkJvOVBPNXNHZ1VNaGdTTlJO?=
 =?utf-8?B?MmprMk13NGc4M0puZzNEQWdzZ3JhYXhscEMrTDRBKzV5WjM3QUlHc3RqTXA1?=
 =?utf-8?B?VjFNaHY4UFoyVzI1YVFIZHF5UHZvbG13eXc0UEdYQjNPMEZjVXpZakxDQXRJ?=
 =?utf-8?B?Yll2Z2ZhMVg0aWVTcXJidnlDTk5sbmFSVG9BL0NlTWdjQ1Izd0RDcnpyYlVa?=
 =?utf-8?B?YWtpRDV4RUpHWDBxUy9wajhTVkJEQnBENnNoR1g3c21NOVdpVHJzS2tSTUdj?=
 =?utf-8?B?VWpVSUU3NktVbU9DcFgxeWF4TWtWTktvVzQ5bGJxZ21DSVFpdUlCdVMyeVR1?=
 =?utf-8?B?ZDY0Sks2UXJKOUJFSk1Vangvd3BXTng5L29zWmVvVkdEeVUxajlTTkJVNXd2?=
 =?utf-8?B?T1VCZGI0Vm8zVXE5QjFrN1AxdmxlK2pIcWpnYWdpNTFHelo1TEN5Y21waU5o?=
 =?utf-8?B?RThaaCs1c0FGMkV3WHErQnJIakVJS1oxd2g5Z1VuYXF4R0t5WWo5SFl4b1Yr?=
 =?utf-8?B?T3o0T0d0eU9NeDhHR0ZybmVsSGU4Y1dOQzVvVlFiU21PdTg3dDE3T0M3N1ky?=
 =?utf-8?B?VHV2RWpKOHBtY0FUZ2RNR1hoMURYc25aMjB0NFVwMTBSMFJJZ3dPbFlmK3o4?=
 =?utf-8?B?ZlkwT3kzMHpJTFQvZUN3Kyt1bGMrbVZjbjA1TVRmYnRnelBYTkZidk93c1JP?=
 =?utf-8?B?cFV0ZDRPYkdzQ205bnZGZE41alJROVZZRE4wdDRDUjVtaWUzeGV3RjJrQzV0?=
 =?utf-8?B?TW5vQ01ocFpBekxsRFpXeWN3UFc2VmFkc2g5enE4Q1JsUzNzYm5FVFhFVWxB?=
 =?utf-8?B?M0FpY1IzUGtrS1grbmVnVGUxeEtKR1g2VUllelFKL1o2N3Y3Wjd4RkRJNEJU?=
 =?utf-8?B?eGtpLzBRZUpuRHFTeTE5QlBHK0lmTGM2T2JPR0NKZlJ4TTM2VUdlY1pCZ05r?=
 =?utf-8?B?WTNkZTBaU2F4dzh2aEZ6U2RpSGo1OWQ3RlpwUXhsT1JqYzFkcmZXRnNndmpv?=
 =?utf-8?B?dGNSckg4NUFrQlkzc2taN0dZRzFlYkpQMEdkUUtKdTVsUVNna1FzV3dzZm96?=
 =?utf-8?B?U0lVcmgrbGZXdk5XY3pNNDd6citxTWZ4M0dZZHloUTc4VjR6ektGZzNxVkFR?=
 =?utf-8?B?Zyt6R2V1K1JMNXN2cStkWjhZZDBWN0FCeXU1RFZYRk40RUsrV3dPUVV5YlY0?=
 =?utf-8?B?YWJ0aVhScU1YeWUvYVVKSUtsOFRsdDVWbGNwWklYUU51QnFxYmRDWEU0UU9i?=
 =?utf-8?B?UlUrQTJpcGxreDA4TXJBOU1leVpwSlFMVkNhYWVaWllQckdRaklLcGVkSk5Y?=
 =?utf-8?B?ZEtwK21tQnhmL1Q4RUVuSDQwTnlTNkhjMWlNcHUzd3B1SGZpSHRQQ2pTWXFi?=
 =?utf-8?B?R2ZNT2FHSVZFbzFDUFcwZmNqS0Y2VDA5Ty9NQVYzaDcySE93aWREV2o5VUNk?=
 =?utf-8?B?QjZlZzRtRlFiQWFtUUp4cWZkenhPdDdCMFBCaDlrQ3RkeElwVklycDBmTE0y?=
 =?utf-8?B?cDN1RzBHRXp1akpoUnMxY2NFelJsdnA0eGk4T0JDSXRiSVNrWlJTemYya3pI?=
 =?utf-8?B?RTFZQS9tcFhVV2ZHU1Z3clNoUzlsR2FmNnUvN3hrdHMzMzVQR3dGZHM3eXpI?=
 =?utf-8?Q?C+Qby00ecxY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzN0Sk5nK3dyTHJxRVpWd3ZqRytxMmE1Rm10eGpHT21rZjZOU011WVk4YnN5?=
 =?utf-8?B?d1Q4MzduM0lobXN1bUZIUVpQRVp5aHdwRElLUVViQzMrSkRlMTBQT2ZzUGMy?=
 =?utf-8?B?UHV6NHpYcTB2L0Q4T1Vxd2ozYVB4R2NVSHdQbDJGbk5YR0hCK1VCbXdqV1Fk?=
 =?utf-8?B?ckxXRG1uN203OGpVY01FVkZGeGE3NEJkVm5ZalRsSmFkSzB5WXY3VHJqdmEz?=
 =?utf-8?B?QzkwUFBud2hENHAwZWI5U0duUUNra2JNLy9raTk3TkRPOC9uUE1sb0pPc0ti?=
 =?utf-8?B?bmtOZVh2aTRjSE5vMUZuZTVxVWVPbkFYclNjdEVhR2N3cCs5YWhDVE5IYkdO?=
 =?utf-8?B?NlpzYjdjQkFySEZORVMvek15UG1scTBXT3loTWl0WVp2Y2MxWmhjd1duSEhO?=
 =?utf-8?B?SkFiNFliSHhpZU9ERm4wNGJLbjlxcW94SVdHa1RqN0JISDlqNWRNMUlSSXc1?=
 =?utf-8?B?VmdKOUlDdG5FYmZKN1R6ditSRjUyQ0lzdmU3eklVTlREeU05Qzl3aFV5ZER4?=
 =?utf-8?B?SFdMaGk1RElXNGoreVlsNE5ML2Q4VzdPUlJjWGEyb0RXeUE1SEEyTm00U1Q0?=
 =?utf-8?B?amRZM09aUDNzRHNmRFNNVWFXRDBYMnVSMno5U3g3enc1V0p6RitSaG16WERJ?=
 =?utf-8?B?ZGwzRm5tK1NESVhidmRmMzYyTGhwcHdxc010ZXZ3bXJZUXZkcHU2cjZNZzNB?=
 =?utf-8?B?WU9lMjBwVno4Qk1RU1ZoUFR1b2tpK3VXODZwcFZqclpzK1ZrVUlOaDh3VHFr?=
 =?utf-8?B?clVRRTRDeDBPWFBvR3RGSWVpVkMyUHE3aHFjRGdGRTN4VU1ucWkvQVBaTVJt?=
 =?utf-8?B?YnVPSFd6RGVicWs1VGdOZ0VQa3N6RUxlWHRCU2t3VmJOcnJXcDBSZzhjS1R0?=
 =?utf-8?B?RGduOFF6TkQ0YkFpUEJnQTAwZnFYdlMwUGJLTHBQS1BFd0d5Q3J6WHJGc3Ja?=
 =?utf-8?B?NDc0YkF4c3ZGWDU3N1ZvQWhTWVV0Rm9xbzhTU2IxVVNoVytnVmdVZkJEMVll?=
 =?utf-8?B?TXN1L0ZqNTRRbGtxR3NIaWdFNTU4eUFzaE1ZOTVkeFhuVHJWRVJTQkszYzZO?=
 =?utf-8?B?TFpLUi9EY1JuemI1a3ZQYjNKK2FxVE9lbVpTVWdHcmptQ2d0dE4zL2V4MHR0?=
 =?utf-8?B?NzJYK1cvVDA2U3FBT2d3Q3B5Z2VubmE3RmlyTXFxOEJVcnBzcFBDUStNQStR?=
 =?utf-8?B?djNHRWFZSnI0eTNrbTBLVC9zTlNsUU5ZWmZYTVVYUmVjcWpkZFMxSGV6V0da?=
 =?utf-8?B?NUQzOTRaTHlSZGNQUlZwZ2U2MlNQUVlNTXpxMzhKM09aSlppeWlTd2NwZlRT?=
 =?utf-8?B?QXk2TXZRbzBQN2FTWkJOUHNGWTRrMy9lRksvS2NyblZSdU5xRjRKQTV0MGNn?=
 =?utf-8?B?MDhkVXljcUk2YnBXd0JKVmdQUWdwa1dtZkg2NmJaZHhnNmdsQ3RZOFV3M0Rw?=
 =?utf-8?B?dFg3SXozU21ydkVHQjBkc0tMQlJ3UktTRFRNVktJSU5obVhsaXBXcjBxYWhG?=
 =?utf-8?B?UWRPZEJDUTZzVnNGbEJFb1kvSTd3eUl6dThNUWNIVkhxaTkyYzNvSW9mcjZy?=
 =?utf-8?B?LzU2OVZ3cUdpSFRWNTJkUy95VmhIRGtTd095eUxVYVpWWnl6NGpBd3lxVWtj?=
 =?utf-8?B?VThOeFI0MVZlUlJHZVl5c2lJQVJkN2Y0dnplMHZkMnpPMGFEa09YUmZxQWFX?=
 =?utf-8?B?OEN2bWhkYkd1ZGNweS9DT1NPQlV6em1ZOEM0Q1ltbytTU2NlQmtmSm5abDhR?=
 =?utf-8?B?MFhlMitWMWo4bndHUlhBU2RYbkhXMlZHRWZ4M3VoVGxRc2tJK2lmbkUvNCtt?=
 =?utf-8?B?OW1sYWN5SFN1cXVNWDVxRDVFQ0l6YWlzZXNYeFgyb2E3Vm1LY0dTUXBJSm1n?=
 =?utf-8?B?NTVKM2JQK2lWajdmMW1zcytScjROTnJHT0RXS29MSzZCMGgzbG8xNWpVa1Fm?=
 =?utf-8?B?VnQzNEVNOEpvc29abHZreVcrd0ZNMVFXZGw2VWtEczkycjRERjNRTEFER0dB?=
 =?utf-8?B?TklCdE16SnlyVEhKYTBCWXE5ZDIzbHNESzVkT2tzM0dFQWFPMEltaWludnNh?=
 =?utf-8?B?S3laQ25DS2pkUDNQcC96N0lJZVpVdmlKRzFVcWg2MHFqSmtXalV6YmdUeTJv?=
 =?utf-8?B?cGs5THhhVVoyd2RIL2dORGhkVUdDNVpxNTI5OUFlUjU3WFFJSlRnUi9Wd0JE?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd766d0-053e-4b0f-a5c5-08ddd44dc1c4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:27:38.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLYqWwx6Zj9HYmmpfL3nHkYHfX2gSiYeuHY44oC6is4nVEzn3mi4PpRYNjyRz6sTiZ0q+IjKzVNr88Oxn9XhOp95YuiNlAGxfYG126DRDxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD56C4208E
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Tue, Aug 05, 2025 at 10:37:01AM +0530, Aneesh Kumar K.V wrote:
> > > To me it is an unfortunate PCI specification wrinkle that writing to =
the
> > > command register drops the device from RUN to ERROR. So you can LOCK
> > > without setting BME, but then no DMA.
> >=20
> > This is only w.r.t clearing BME isn't ?
> >
> > According to section 11.2.6 DSM Tracking and Handling of Locked TDI Con=
figurations
> >=20
> > Clearing any of the following bits causes the TDI hosted
> > by the Function to transition to ERROR:
> >=20
> > =E2=80=A2 Memory Space Enable
> > =E2=80=A2 Bus Master Enable
>=20
> Oh that's nice, yeah!

That is useful, but an unmodified PCI driver is going to make separate
calls to pci_set_master() and pci_enable_device() so it should still be
the case that those need to be trapped out of the concern that
writing back zero for a read-modify-write also trips the error state on
some device that fails the Robustness Principle.

I guess we could wait to solve that problem until the encountering the
first device that trips ERROR when writing zero to an already zeroed
bit.

> > Which implies the flow described in the cover-letter where driver enabl=
e the BME works?
> > However clearing BME may be problematic? I did have a FIXME!!/comment i=
n [1]
> >=20
> > vfio_pci_core_close_device():
> >=20
> > #if 0
> > 	/*
> > 	 * destroy vdevice which involves tsm unbind before we disable pci dis=
able
> > 	 * A MSE/BME clear will transition the device to error state.
> > 	 */
> > 	if (core_vdev->iommufd_device)
> > 		iommufd_device_tombstone_vdevice(core_vdev->iommufd_device);
> > #endif
> >=20
> > 	vfio_pci_core_disable(vdev);
>=20
> Here is where I feel the VMM should be trapping this and NOPing it, or
> failing that the guest PCI Core should NOP it.

At this point (vfio shutdown path) the VMM is committed stopping guest
operations with the device. So ok not to not NOP in this specific path,
right?

> With the ideal version being the TSM and VMM would be able to block
> the iommu as a functional stand in for BME.

The TSM block for BME is the LOCKED or ERROR state. That would be in
conflict with the proposal that the device stays in the RUN state on
guest driver unbind.

I feel like either the device stays in RUN state and BME leaks, or the
device is returned to LOCKED on driver unbind. Otherwise a functional
stand-in for BME that also keeps the device in RUN state feels like a
TSM feature request for a "RUN but BLOCKED" state.=

