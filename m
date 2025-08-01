Return-Path: <linux-pci+bounces-33264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C42FB17B12
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 04:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C9565A2D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 02:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B314A1D;
	Fri,  1 Aug 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AltJDfAk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA55B21A;
	Fri,  1 Aug 2025 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754014049; cv=fail; b=Yk7UQXVMvJtuqu0bczl3NSiZsyPtuF4pswjI4Dxu0K9zE14iElAPfpnel02fvHiZ8wgFjxUPfGi4sPQuCvcCaWrO2Tb2Vxa5JOrmlhWXJLVfqf4pUTmZ7APxtx9bGOZD5SLxAgUrX3rXncMU5C0WHOfu6IQKG/EJ+ve5ahbg1Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754014049; c=relaxed/simple;
	bh=edB9AaH+6aDuyw85+iOMkBVE3eQAisDwT3A1MRYNNm4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=crnvokfhrHESdLJ6p10F9P5oGUJSaCXXbXAPUfCr7bpkbBlShan3+AIy1e2FoaHc2P+x6asrAM52tXpWI4BLjFs/qPqMZsz2I/K9gEZvyDP36wg4/2EI1sPvRDO8nJ7ujjMEbA7YqOnWyYF9XkgidKHvW8LJFlisIaFPv3YXKho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AltJDfAk; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754014047; x=1785550047;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=edB9AaH+6aDuyw85+iOMkBVE3eQAisDwT3A1MRYNNm4=;
  b=AltJDfAk3q9Y6JjPFh7I9F8o0pE1iCR/xyhPy/SCFnIHidj5Xgo3pBbQ
   qRWB0WKhqZeJ6Rx0dZ8j6MO0yOwUdQHtueqdyZd0YGstUojoMbxnVxX1h
   Hr8ymNZaUJrsJiM8FZYxR2WxuqlPvJz+FCYJ7lwH0Bx21vJZ5zeocJeOH
   R96k/VBBX6IqLzjf3hWzboAwZ70BaeCMkyWwJSEYk0kgyrvxYsDHnRzOX
   F6owqZD+Mt9vaSeS8S7qyUmDH9zhvDydjc4FvUd5BNsPA1Sem+mLMskUc
   yHnX1K3plg7xqM1sGT/FF/JyXUJTknSPuCVFwKJDSL0YRjoP47U9OyBUw
   g==;
X-CSE-ConnectionGUID: rXucK5jmRReKi2akH5zJ7w==
X-CSE-MsgGUID: pVLQ6MWTQf2FiTGsC2zgMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="67049870"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="67049870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 19:07:26 -0700
X-CSE-ConnectionGUID: 2rKO7DfyQX2yZMOc0+orPQ==
X-CSE-MsgGUID: yBA62OXATCGTu1WG5aJxsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="200588487"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 19:07:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 19:07:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 19:07:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.75)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 19:07:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SK4wKDZY1XqcWJcHjD4ct6W49k0IF9atJcf/O0fyd8etRXo+XWSbsAccxlIiDZjzAaddxEOt78c0NKGf8GEpqEgKY9oHy+hx+F/BlG2naQEEzKyFw+c/4l3wcv0DQW5k/KWhoAB3p8z5YVi539wBppyPNGwDaRT/R7yfTqINUb4WX7y/ZXrIalxjdAMUCCnM9FuHTgWCGCXIfaxtQ9cYytgAttUY75w6j4j7KRAMTW2XNcdNzkTXm+U03JA+rBUwlILtG1oCu/yEgS7zNnoyax3tPN0qLyUcYff52OcsxTZT3VvO/k0Mg7VHLqaEZ8On8o5o0bZitLKNP11WZy1EXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bwvHTOgLWi6Qzz9j52uwHwNqIerqRHI/jfKG8i4R+I=;
 b=XKKvvOl89xihumteTcx7cx3FL9pQ9OYcO5f7UFmWk9FgxzH/MOBD1lXQw98k6E1IM67y7lxLRpIiC74TYDvu4hKM3Lep5BeyD2REbx0ibKS3nRnaRMXnZow09b1/5jFjGlMd6VGHabExEQbFcBS1vN+ay7MVEh2Jy07RPE6T+SJ6V3ojZSJ1TfPy5HV7ZK3idVjljC9qJJkNOBq143cxK3hqpXPBJUSggNbcjQo2yRR+N7sakBMJnMfcwBxw+C3BlMjUtq26FQDok/no0QgQhXVuX0Wb/8NJ4mWwZsWm/hBPcAxwFdqVAJ4HEPZjMzqUFA75OjIUs6DsIwe8jHNBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5767.namprd11.prod.outlook.com (2603:10b6:510:13a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 02:07:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 02:07:19 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 31 Jul 2025 19:07:17 -0700
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will
 Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, "Aneesh
 Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Message-ID: <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1998e0-9f70-4e25-17e3-08ddd0a0252f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkJIendkMjNtN3pzZjFkZEdnOXhLUkdnTTA3cEthSHJRc1B1N3BSL1J0Vm9t?=
 =?utf-8?B?dXFUQzhFRXAvRWtGcFNQUGlyczNkWDN2MGV0NGdLME1udkZhbUhLclVsRzhj?=
 =?utf-8?B?aHBWaEs2a1Bpbi9JV2JCMFNpeGVZTFZBMHVYOUlTZXRiTzBKbTNWc1FKVTRW?=
 =?utf-8?B?TTBDQ3lBNXJ2L3RZWUJoV2VtM0VIb0FHWE9ZSlkwZWNPR0ZmL2VIcm05dDNT?=
 =?utf-8?B?anIveEdwVUpCVm1FNG1qWEs5TzlsSndqQ3NkMmZ0QjZta3huL2sySkZzb3Nm?=
 =?utf-8?B?Rkl4VUdYTlFabFBvdkxRbVpJZ2YvTnREZHc2NENHTjNETXNCdFlRelR4UHU1?=
 =?utf-8?B?dmdoMXJab2QrTG5QRW81dW5TeWI1NnBHckZSczdZVzBRd1FmNms2WkhjL3RJ?=
 =?utf-8?B?Rzc5cW9pTDFqZkJmVW1kNDFnOGdkZDBraFFsRzN4TCswdkpRYjFtN0JDSXV2?=
 =?utf-8?B?bzFwKzU4b2N4TEtLaXdDbXNWYXVRSUVPdWZyNng4QU0zSkRma3VVaUw0MEZV?=
 =?utf-8?B?YUQ0WUdibStpS1RSSzdZTEN1Mnh3Y0JKZ1JLT2FLcWVYZmJRaU0rTFZ0NVRi?=
 =?utf-8?B?ZFJDOGxadzBQK2xZaURJYjUySDkybFJ5SlhraUtFeXc2SFpOc2NRSUdZVjll?=
 =?utf-8?B?RnlXVEpqbTlwUHcrSE1SVC9uN2xOM1hTdGM0QklMRnpoa2hUTjd5blk4Z3Ja?=
 =?utf-8?B?UlN0eEUwU3MrMzFodzJhNlM3cE42cXA5aG9mNU9VN3dYbVVjY0lqS2NZOVhH?=
 =?utf-8?B?SklNTmxmU2piMWFseklzTjdCRmZTYW9ubU1PSitmKzYvYVVwWTZLNnYvRGFV?=
 =?utf-8?B?SGhsbzlYaHUyaXVwamJiSTV1ZGZ6WStwdHVvZGVUNTRVSDd4UTV1VmZ1TDVJ?=
 =?utf-8?B?OGVkalJQdkdFR053QXhoRWRFV1JsckhlaGFDdC9BTHBUVnpBSmtjVTdHUlls?=
 =?utf-8?B?cVBKWWlUWlY4aDd5Uksvd1VVQVZHbXRpMVVzY1YrNnBIdnJBVmZMa1RlWUpE?=
 =?utf-8?B?Yzh4M2RGUVZ4ZERXNjRieEUzcW80RUxHazUvQlF3TGUvVG4rVVFuYk12RkNJ?=
 =?utf-8?B?bDFtUHFIajc3am1HSDdYd0hFQnVWaXBzbmZiZEd2Ylk0bWNBQU43clNoK0Er?=
 =?utf-8?B?eXNWaG14QnVyMUp5L2lRTThnRkRveEYzQnZ0VXZDWjFENDhmOEw2RVJ2dFNB?=
 =?utf-8?B?eGQ5cWJXTVZrQVAzalQ3Und3M1R3eXBxQVBEL0VSUGRubXhZM3doQk5vNDYy?=
 =?utf-8?B?YUZQUzF0RlVldmtocmpnaXdsNm9zYlE5bUQrcDU0ZnJwR21qeG9zMlhoWEx6?=
 =?utf-8?B?aHg2Y1NwVXA2N0xtelZ1ZXpZaGllRUp5aUp3NWg5Q0txZjRZLzRPWTZlemxF?=
 =?utf-8?B?ejQzNGNuNjNLS2J4Y0lGVEZzSGVjazdFMGQ2Q2VLdGhqN0NibGlIVGN2amV3?=
 =?utf-8?B?YjExR2RaaDlEUHdLUUh1UHhkM1kxRDlJem9rb0NGWXF2ZkZKVkhVdDJyc0pP?=
 =?utf-8?B?d1BDK2kxTmVxa3hjd1BXZ0hlUXFjUEVIRDNqbVVrdzlJSXh6TzBNSzVzdWsv?=
 =?utf-8?B?a2FxSWVLRnFuZktJeU1sTXlpMjh1L0ptNGFZai9tNnhXS2R5M3hXYzBsYjdq?=
 =?utf-8?B?U1ljK1p1bnYrbTYrNUVjaFA2N0s4SENTN1ZwVHMvUjNDUWpDRGJrVU5BTVhK?=
 =?utf-8?B?dVVrWXRhNFRORCtBK1FGVXI2ZWd1NVowZDgrNkUwUTNDc1l0cmdwRi9JaHkz?=
 =?utf-8?B?V0V6WmxLQ1h4d0xhdllMTUV2ZTM1U2FzMm90dTZNUTBHM0o5UXFJU1F0bmRh?=
 =?utf-8?B?R09SYzBPaXFsclhuK1ZJRzJWVHF6ZUpyV1RYQjExQkR4Smg5dGxVTTNHU0xM?=
 =?utf-8?B?SFBUdkN2aDVLWmZaSGFlS2wxdHI1azNiMUFacnhYNkN6TFZGQ3BBeVB4OUg5?=
 =?utf-8?Q?uxo4LY06IYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzBhWExLbGVhV1FrcmxtV21CMGZteE5tU1loUHVNOTMvdGloRndaNUpGVWNG?=
 =?utf-8?B?WVFNT3pPTE1nSHhBNzhzOENpcks2YWlDLzF0WGNsY0luQ05ZVDJVM25iQmEr?=
 =?utf-8?B?YWVoYlh6c1BHMklTK01INUxidGVqTUlMS2IrZzFlTVVqUm5zS0dIaTRGN213?=
 =?utf-8?B?QzcyZzFsK3l3a3R6MGUrcDVtUWZod3piTURHQ2dtOXkrUUxOalc1L05aSTNT?=
 =?utf-8?B?WTVxQitYMjVBVEpkQ2ZZMno2N2FIT2ErNytxUzRBelNJby9SSTYyS2JWRmp2?=
 =?utf-8?B?TlFMb2NlM0ZzMkVDQjB0ditkeENRUlJpTCtHOXRxdTY5d0hxTzRWRC9nK2Va?=
 =?utf-8?B?WHFodUdLQk9wSmtzZHY2U2s3QVJPZGx4djV6NTZtTWN4a3o0M3RaTUcxRFdX?=
 =?utf-8?B?NzU0Y3lMZ3F4a25VVGQ4WUdTbGRtbDBWMlUyYnZ2WGtpZFllcS9TMjFSQ3Rt?=
 =?utf-8?B?aEhONVlCRlU3ZFgzTE1iaDFsNCs1cHl4ZWRUTlhFM3pLaU1wVDlSa3hWRzZL?=
 =?utf-8?B?QWpQRGRvQVJGOFBWQU9icEFhaUpDeW1RRVNibmxxMXMvR0dEakhWZVlYdm1z?=
 =?utf-8?B?MHVUemZicE16eVBXN2hycGRZQ3MzVmxlTXUvd0IyYUpyWnJ4MnpjdGtsU0dv?=
 =?utf-8?B?aVBUWmRsTEpzOGZmS1B5d25VcjJqc251N2MxbUJyR1djZkNxT2hiZkswUEN5?=
 =?utf-8?B?bTBmd2U3aER3ZUdYUldFY2xJLzV6Nit4UWVHbGhtODlxY0phNEJKUnJsVi9y?=
 =?utf-8?B?VFNQOURyeDh1eWY4VW1PQ2I2TVdPSkZ5c2NqSmJ3NVV2QUlUVmMvcnVnS3M2?=
 =?utf-8?B?cTk1WUdSQ0o1dUdnaE8xQUEwZjhoYkp0UlZ5b2xFTlNjZ0F2RnhPdTJPLzBH?=
 =?utf-8?B?ODg1R1RmelVHQ3laNDZjNElPQU5TSzZrU3poVWUwTnRFRW9lMzR1bzVTQjRZ?=
 =?utf-8?B?OG5sUzhlRzQrOEJkYTdNUVhFV3JxZjlYeVR2SGtra29CRjFVYUsyeExSY2ov?=
 =?utf-8?B?QWR0ZlJUQ0ovWFY4dXNEN09HNnJpRVpkbDlDeVlGQklUZ3FPblZRUG1RTUg3?=
 =?utf-8?B?RlBTOTFRVGdrdElGNVBnOWI1TS94MWI2OFNsQkRBSWtuSXVqSmVBWmVsam9H?=
 =?utf-8?B?T2p2cEdOZXZiRjlodmlDZmpZZldmcVRjVytvdC91YUdaL1ZxbEYzeGxGMHJT?=
 =?utf-8?B?T1lzendTQnZ6SmI4WVlVSUtQMVEvN1FJMlBHZFhCdlFFamlYL3hCYkNoeHNX?=
 =?utf-8?B?NmtDZmZRS1Y3aTdmZisrSFJtYzFMWXloYUZFaWw1QldSRVhEdnF2UEZndUNO?=
 =?utf-8?B?L3JUblB2RThZMEhLM21ReERUTTU0cmxyOEVPcGpIUnpBdkp3LzRCM2xKNnZh?=
 =?utf-8?B?YTlBY3FCYTZPdHNTTjZpU2FjNzByQjRuemxRRHFvZ2J0T3crNENxTkYxNUVz?=
 =?utf-8?B?ajZkci90NURGejZkeENmZUQ2aVJ5UXVjMitMOWZoUHJXNXA1RFRBWDZsR3lK?=
 =?utf-8?B?SnJNSVJKamx5T0cyUHpnSHNyclFCWW5nSVZzUkhiZGV1TTZpNWVBTzJzeDBK?=
 =?utf-8?B?NU9KU28zdGVTS2svenpRWWVwTjlkWWRjSVJmNUxCQ3ZFd0FCTTNmMWRJQks0?=
 =?utf-8?B?VDliVTQ0djFnWVNMWXB0L0p5VHEwd0l1dlBVbGNLaXZOYXJ2QVFqZTZyK21P?=
 =?utf-8?B?cVRLOFhHdCsvNmRnTzgxWG1Rc0hYZUE3bkp3MHlMMERUejlkREdNVVJHeG1m?=
 =?utf-8?B?QkR6NXhwRVpTdi9QWVpENlhQSlRKd3NPeUpzRXRYY3BzVW8vQlYrRm4rRFRG?=
 =?utf-8?B?NTloVFlES3VBc1NtVndLNDg0UFRzR0lQU0lSWDFuUTk3c2R3ZUxVUHB4U3ph?=
 =?utf-8?B?VmpiUW5LbktGUytBUWNRbDdERzdhdjl4T1hkN0lVWGozbDVOd0RwTFpIc1FV?=
 =?utf-8?B?bDByaklkOFFsVkxXcWxkR2dPRlRsS09wcXBsaC9PRmFTNDY4MW10WkRQdVd0?=
 =?utf-8?B?dG4vc1JMSEhneWZIdktOa1I4clh6V0l6NnUwWlJUU3Y1YUNGQ2VybFhsTEpI?=
 =?utf-8?B?bHQrT2tqNFBpSmNBckE1L3VGK1hiRXl0czk5N3BmVUQ2L3hPUjFBcTVoTE1K?=
 =?utf-8?B?L0VXVXpyc0VLY1VhTEtDY3VIblA0em1LeGgrcnhSOEdBYUdROVpZaWkwS2dD?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1998e0-9f70-4e25-17e3-08ddd0a0252f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 02:07:19.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQ9WfEtyAijyYXdRV93OhgXYwSMlILOih8wWF9ZqsIV1E0dgyhRrQWyljf6KyqHofzC+QBEpTYOC3csRFy9/mm7/TmA+ruy8dl1hHzWQAWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5767
X-OriginatorOrg: intel.com

Aneesh Kumar K.V (Arm) wrote:
> This patch series implements support for Device Assignment in the ARM CCA
> architecture. The code changes are based on Alp12 specification published=
 here
> [1].
>=20
> The code builds on the TSM framework patches posted at [2]. We add extens=
ion to
> that framework so that TSM is now used in both the host and the guest.
>=20
> A DA workflow can be summarized as below:
>=20
> Host:
> step 1.
> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
> echo ${DEVICE} > /sys/bus/pci/drivers_probe
>=20
> step 2.
> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect

Just for my own understanding... presumably there is no ordering
constraint for ARM CCA between step1 and step2, right? I.e. The connect
state is independent of the bind state.

In the v4 PCI/TSM scheme the connect command is now:

echo $tsm_dev > /sys/bus/pci/devices/$DEVICE/tsm/connect

> Now in the guest we follow the below steps

I assume a signifcant amount of kvmtool magic happens here to get the
TDI into a "bind capable" state, can you share that command?

I had been assuming that everyone was prototyping with QEMU. Not a
problem per se, but the memory management for shared device assignment /
bounce buffering has had a quite of bit of work on the QEMU side, so
just curious about the difference in approach here. Like, does kvmtool
support operating the device in shared mode with bounce buffering and
page conversion (shared <=3D> private) support? In any event, happy to see
mutiple simultaneous consumers of this new kernel infrastructure.

> step 1:
> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>=20
> step 2: Move the device to TDISP LOCK state
> echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/lock

Ok, so my stance has recently picked up some nuance here. As Jason
mentions here:

http://lore.kernel.org/20250410235008.GC63245@ziepe.ca

"However it works, it should be done before the driver is probed and
remain stable for the duration of the driver attachment. From the
iommu side the correct iommu domain, on the correct IOMMU instance to
handle the expected traffic should be setup as the DMA API's iommu
domain."

I agree with that up until the point where the implication is userspace
control of the UNLOCKED->LOCKED transition. That transition requires
enabling bus-mastering (BME), configuring the device into an expected
state, and *then* locking the device. That means userspace is blindly
hoping that the device is in a state where it will remain quiet on the
bus between BME and LOCKED, and that the previous unbind left the device
in a state where it is prepared to be locked again.

The BME concern may be overblown given major PCI drivers blindly set BME
without validating the device is in a quiesced state, but the "device is
prepped for locking" problem seems harder.

2 potential ways to solve this, but open to other ideas:

- Userspace only picks the iommu domain context for the device not the
  lock state. Something like:

  private > /sys/bus/pci/devices/${DEVICE}/tsm/domain

  ...where the default is "shared" and from that point the device can
  not issue DMA until a driver attaches.  Driver controls
  UNLOCKED->LOCKED->RUN.

- Userspace is not involved in this transition and the dma mapping API
  is updated to allow a driver to switch the iommu domain at runtime,
  but only if the device has no outstanding mappings and the transition
  can only happen from ->probe() context. Driver controls joining
  secure-world-DMA and UNLOCKED->LOCKED->RUN.

Clearly the first option is less work in the kernel, but in both options
the driver is in control of when BME is set relative to being ready for
the LOCKED transition.
 =20
> step 3: Moves the device to TDISP RUN state
> echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/accept

This has the same concern from me about userspace being in control of
BME. It feels like a departure from typical expectations.  At least in
the case of a driver setting BME the driver's probe routine is going to
get the device in order shortly and otherwise have error handlers at the
ready to effect any needed recovery.

Userspace just leaves the device enabled indefinitely and hopes.

Now, the nice thing about the scheme as proposed in this set is that
userspace has all the time in the world between "lock" and "accept" to
talk to a verifier.

With the driver in control there would need to be something like a
usermodehelper to notify userspace that the device is in the locked
state and to go ahead and run the attestation while the driver waits*.

* or driver could decide to not wait, especially useful for debug and
  development

> step 4: Load the driver again.
> echo ${DEVICE} > /sys/bus/pci/drivers_probe

TIL drivers_probe

Maybe want to recommend:

echo ${DEVICE} > /sys/bus/pci/drivers/${DRIVER}/bind

...to users just in case there are multiple drivers loaded for the
device for the "shared" vs "private" case?

> I'm currently working against TSM v3, as TSM v4 lacks the necessary
> callbacks=E2=80=94bind, unbind, and guest_req=E2=80=94required for guest =
interactions.

For staging purposes I wanted to put the "connect" flow to bed before
moving on to the guest side.

> The implementation also makes use of RHI interfaces that fall outside the
> current RHI specification [5]. Once the spec is finalized, the code will =
be aligned
> accordingly.
>=20
> For now, I=E2=80=99ve retained validate_mmio and vdev_req exit handling w=
ithin KVM. This
> will transition to a guest_req-based mechanism once the specification is
> updated.
>=20
> At that point, all device assignment (DA)-specific VM exits will exit dir=
ectly
> to the VMM, and will use the guest_req ioctl to handle exit reasons. As p=
art of
> this change, the handlers realm_exit_vdev_req_handler,
> realm_exit_vdev_comm_handler, and realm_exit_dev_mem_map_handler will be
> removed.
>=20
> Full patchset for the kernel and kvmtool can be found at [3] and [4]
>=20
> [1] https://developer.arm.com/-/cdn-downloads/permalink/Architectures/Arm=
v9/DEN0137_1.1-alp12.zip
>=20
> [2] https://lore.kernel.org/all/20250516054732.2055093-1-dan.j.williams@i=
ntel.com
>=20
> [3] https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/tdisp-upstream=
-post-v1
> [4] https://git.gitlab.arm.com/linux-arm/kvmtool-cca.git cca/tdisp-upstre=
am-post-v1
> [5] https://developer.arm.com/documentation/den0148/latest/

Thanks for this and the help reviewing PCI/TSM so far! I want to get
this into tsm.git#staging so we can start to make hard claims ("look at
the shared tree!") of hardware vendor consensus.

