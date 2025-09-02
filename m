Return-Path: <linux-pci+bounces-35314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B8B3F92E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB03BD456
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141172E36F4;
	Tue,  2 Sep 2025 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WH8TmCPq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B932F742;
	Tue,  2 Sep 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803264; cv=fail; b=ZJA6q8UgB/viiSo8KzJGqG3ubnAjXcXGEqltqHaBHW0yJldqulfsThGatK1ubRYxYsxgvpXk1fv4Kt5PLlWi8XuUuCmOS3kVWy98HeDqCR+fM6UKzIcGuB9wqN5xJwpOh2eMr956jwcPv8fxApYhWZiFGTTSROIEgC/dqdXaznU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803264; c=relaxed/simple;
	bh=tAsC0FdRCETGnEKeD7mZjJ3VMJwRYgN1w9UP6fnk2pQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4SUUNMLAl35lEMG1SQKSm8pcYD+I58m0wJYIWEO5wg8msIzxLsKXnGte8ywiA6jD2uOBk2jC4XsIj4abHR1fyI48SKzBhw1TfMO/rBnK4COeWFfRF/Z/N4oEdQf9ozy/PBHFFv3DIFo3ZNGa41whDDQ9LpNKCxck7iKD42RmiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WH8TmCPq; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756803262; x=1788339262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tAsC0FdRCETGnEKeD7mZjJ3VMJwRYgN1w9UP6fnk2pQ=;
  b=WH8TmCPqP5pouTs9wqt4AKkNEuo8vBGQbYQThQn0zSBj5qGgEj8L0hEV
   BDUus/VSpKHTJyonPFrp8ShEIfoqUZt59w48Elpa96GZvCR5qfZcBStvR
   DPaw1lInaULGfyTglqYtBCm99hBePaeXv/EvbbBPpzkW4rbmBrdAts63Z
   q4uFRPc2YPr+Imj/ks3Azge3xZbI5R4CA/FB0xWXgUhbfAndD8WN9++po
   fcnzVbKIsPxOvkHkiOvkfSt6tpHqwLLitN2Jg3cd6uoOdztQM1ba3V/RT
   n6akMPRVj8FKUOvZ0Qw1ITW/Uw6AAnZehhchVIDLq9YIAzZLTeKSLuXOf
   Q==;
X-CSE-ConnectionGUID: VZwRjftvQ5SoQuBP+vBJoQ==
X-CSE-MsgGUID: NwOpnaS9R1mCNqWNRxn8WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="62887158"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="62887158"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:54:16 -0700
X-CSE-ConnectionGUID: T2hChO/uTc2JGukeu2rE8A==
X-CSE-MsgGUID: 7q/9qV0HRwaUmPQ9mbragA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="208418448"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:54:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:54:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 01:54:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPKMMW8SqAXiHTqfiG/ri8uooGTMvh2Sxv/YfX5KYtHPjt8BoGXot6sHr/VYPjvrO23zm6BIhl683Y+dNHSz6xt5JpVMX9stCTidOEjvMbrSESwXCvNaPOqnSRYv8BD5eQpFE6UT6nPlqiLkxQHSbk8M2yLIjE5lquLb1wIzmCs1QnxiawOake8wOXu4sqkpCmEE89z+MaLHEOoqNF3WrbyID07fXQsJgfq9DY6DCjWkZ6AMtDwkCblhJjwkCNE8Cp1vFfP8vCvZ2yXCHzrcY8O40iNY+4jCDw1CskV4lDZs2X8AUSu+Ons4uQu4G04iL+4Yf97GiBYvJIITg03Byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy7ny+wAnTYrl4KJ+POB7qts7ewOrHo72SRKhxaDm8k=;
 b=P63NcjWmnpH8XGuavAq8MiRO3UcQAzRJLQBeIbB+RWfaoVp+AFz535Dygw7sgRDMY1VFeUeei9zcvQ2tkI92omABFaqnjXm5M3pEtqzWMQysCufmu/j2xgiOyfc08oJX4MLM4T6aS7u1ufW+6HRahSqHazoqKINpVDz8c1InhuOUt65+pX4PpNHqqxSHTrGXT8st4VHxL9zWxV2SA2KsW0eKTb6j+M/xlNQnoT/DUgufN3lqnon5lg5Qg9JRGgOAXjIJmgTgR1UDqmun48rmvk1Cjv2LreaYYAquVog5Ji7nop2wAZkBrv5CPA+GeGjSQgh2DHwwy5aIBHURpEuedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 2 Sep
 2025 08:54:07 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%7]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 08:54:07 +0000
Message-ID: <57da5d38-13d1-4e82-97de-a40e34c27125@intel.com>
Date: Tue, 2 Sep 2025 14:23:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/ACPI: Per root port allow one Aux power
 limit request
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-3-badal.nilawar@intel.com>
 <ec3bd3a0-98d3-3b55-198e-a27a2c1dfe8a@linux.intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <ec3bd3a0-98d3-3b55-198e-a27a2c1dfe8a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::7) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|SN7PR11MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e11500a-a1d1-42d0-e937-08dde9fe469d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUR6bFlRTTh3cFFRN1hXaDVkcndaUWhYOXFXNGdHSEgxYmg5VFdvVjZYdjFF?=
 =?utf-8?B?a1A0TlE0YmVZeXBnOEhxaTJKV2V4ZmV3eFUvQnIzb2hFNS9Wb2NtOERPNTZj?=
 =?utf-8?B?TkdpaVVjcHpDTFE3S05wV2h0amw1T3N6aUl0b2I4ZFk2aHRFWDQyaytyeWFr?=
 =?utf-8?B?SlliOUY3U013T2d0dnpMbW9oL00ydjVNQURkUCtpazZTMFFud1d6VkpSU1VO?=
 =?utf-8?B?a3FNM2xVaU5mTnBsK2JlY2U2VVZhWDVic2NkbDUwM2IzQ1dRVnhvNXJGV082?=
 =?utf-8?B?Z3BnR1FaNWdBYXlJcjRYU1RvNDM1bkhiZHN5eWUwRWcxSWdMSkV3c0lJRHBF?=
 =?utf-8?B?SWlDWHRtZ25xeURFdW5NNGxRLzJBK2d3T0tPN1VuVU1yWnlVeHlpM2EvSXU1?=
 =?utf-8?B?YmszUUZWMXlGR0cwUklLcDFlM1A3S2NxZFRkOUJKdFpibVJoSXR4S1ZFY05K?=
 =?utf-8?B?aFdzaEFKMm9iQkEzOEZDZ2dGMEJBS2tSS2dJY0xyM293Ujg1SE8zM2pEYnU0?=
 =?utf-8?B?SHBnTUJIT2ZmRUp1RUJUYkY4ckxuK3RleU05OE5FTTArOGFqckxySjlOR2hu?=
 =?utf-8?B?dTA4RTNGczdUUHpzSllNa2xzbmNYS1d0QUE1bDhMejd4Q1JNZzZET2NFMXlS?=
 =?utf-8?B?ci9idzNEOGFYYldiL2pTRlltQ1V1WlBvNWpyL09pTXlDdkZpY0M5RkV6NURO?=
 =?utf-8?B?ZVdlN2t0Uzh6ZGp1WnA4QTlLRXkvOERjZVY1ZURCcmFLVEdzWFFTVGd1OWVu?=
 =?utf-8?B?UmcrZzAvTW1UelF1T0Yxb281eHFmVDd1em15K2ZTKzAreE9tTnFkdTRJNFlu?=
 =?utf-8?B?VDRuemlPeGIxNkFMdlU3MW5KRDlFdG9Ca1pHcWxXZ0NtZE5JRVBRTFJ0eGpk?=
 =?utf-8?B?cFVlUC84dThqYVdnSnd0SHh4NGNldzIwWGY5WGFFQ2Rlb0F4bTF2T3AvVUda?=
 =?utf-8?B?eEpTU3B3Y3grZm9tQ29sc1FPVjlacGk0TzFwTkVCc0VYa1RiWVdZamVjbjVv?=
 =?utf-8?B?cjh3a256Ulhia2RhNVJtT3FPRmszK211eUptKzF0RHVqR3IrQ1U0RWE0NnRR?=
 =?utf-8?B?VlhsQzYvQUY0NlM3eWw4Vmo0d1Z2Rkt4RUxHU3piM0Nlc0NsMHB3U3FQbzlz?=
 =?utf-8?B?cTdOT0FDeHB2ZTlCaEt0MGw5NTF6UXJ5NlorSzcwYlVoRWZScjNxenBCRDZH?=
 =?utf-8?B?bUN6WUVxWkNKM2NTTHhvSjgra1B5Tk5kdDdOd0RxQVlTY2IwLzAvTEpEd2RS?=
 =?utf-8?B?Q3QzcHVvU2MwWFpxd3pobGt4M2toYXlXcmkxNUJ4OXpveUtTZElpMG14cHY1?=
 =?utf-8?B?WWNWTFdqUW5mWW1xdnhJdW1PN05iSkNweG8wMjRjRngyNU1yY2ZlWHJrMDZq?=
 =?utf-8?B?TkZPdmczVE8xdFkrK2tyUFVsV2J1L3MwNFo2cHBxNm9QK0FHMmpVV294ZWxE?=
 =?utf-8?B?NENaN29KVHFOYzBxZGpEeGkwSG5wUUtJZnBaakw0cmptcWt1NEJSek9wbjhx?=
 =?utf-8?B?cWZkdTJ5SG5vNG1yNnNxU2oyUStrV20zcmp0ZUlSOVZCN3QrN1EzWFE5Qzh0?=
 =?utf-8?B?OVRBY0NvK3FjaVhOZUN2VnVabjZIWENoS1lxblV6RlF3OHVKQmREOW5xNVVi?=
 =?utf-8?B?bGg4WGthMnZHSzJoMDUzOWZkeEQ0ejhVYXE4RzdJRC9vS1ZYT3M3cDRod1FX?=
 =?utf-8?B?ek8wdVg1OTNQY3hBMGVpdkRqQnJPZEJULzVjVkRON3V5VGl4YjZZdVNJUWhT?=
 =?utf-8?B?NWhDRmxFRVl0dzlSL1pJNGVGREErM0xKcGZpZmR5OEUyeDVPelgxYnA1RXE1?=
 =?utf-8?B?cjYySkdxcXV1bDZhckVXUU5SUHZkbTM0c0RNb2xPRHpzcVRRMWMrdGhGZjRy?=
 =?utf-8?B?QW5lMkRJWmJQL1VCeW5lOFBQWGFKWnVsRTA4VDlDcDlHcTVjdWJmK1VuZE56?=
 =?utf-8?Q?+46DSK3PSp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5jMWVJbWdwY1NBRVkxVmNtSDVNNFVvZG5kdUxIVUdmQ1hQclVOcnhNV2Qv?=
 =?utf-8?B?aUFuSGI1SnZ2ZTc1Mzd2elR1dGlVdC8wRS9kdWVaZUd2OVdnenBJSHloTUhk?=
 =?utf-8?B?Z01Qbk9YekhWc29YU3B0aU9iazVzbE5oaVkvM1orS2JJOU9HRHZ6QkxQdnI4?=
 =?utf-8?B?amE3Y0dESGdEaGtRa0ZVZjFwV0FKcDVaZThmNmgxemFKa1N4ak9Za2RKbjN0?=
 =?utf-8?B?M1BIVXgrWG91eUVzbzZYUDhwbVQ5d3ZaL3JpNENoem1NNy9Xc2NZeGg5Uksz?=
 =?utf-8?B?Y0lwT0lsUFhuQWxjN1o0cTNUcmFFZGFaR3Y0OFhqUFU3RzlnRmFSV3A5aWdU?=
 =?utf-8?B?T09ZZWU1MkNtQlpBVGF2K05UWHRKejMzZVQ3VHYrZVQ1K1I4cU14SmlMMDZU?=
 =?utf-8?B?N25nOXcwQmkxWlJJdE5qNkpPVDVqdndJa2FDc0svckdBTk9FZkZDZHpnZ3Er?=
 =?utf-8?B?QzZha0JXeGpFbnVTY3E4WUZhVkw5aHp6YWt6ZmJPMlFQNU9yVFJMVSs4Q2ZC?=
 =?utf-8?B?aFY5eExGQWJPalhSNGZOL1R3WFJGNGdTZDNRV2Q1dXZkNCtlSEVNamR6d1Z4?=
 =?utf-8?B?ZHhsNEJSdGNIL2V6K0ZhMHBxNmxXZzJubk5ld3drZHRTWUpvcGl5dHJUYlBK?=
 =?utf-8?B?NU9IbUsvZlNvZzJCV0xEUzB3WnhsOVYxZk53YjVobTViR0ZCejV2SXRRVlVP?=
 =?utf-8?B?cU1sVnBvNkxMdFV1eXBGbE1FRzNHOFB2T1dkV0IzMzhmcEk3M3BmMm5pZDZH?=
 =?utf-8?B?cE5CRWRWNG1zYi91YUdzTVpUUEJaZy90SGtaNzVqNXlDYmQ0V2pVN1R3VUJH?=
 =?utf-8?B?TFVIRW5zN0tCVGZBajd1dFBvTzJLOVJMa2tnTlIrVjVzTi9Nb3U4WkpmaXdt?=
 =?utf-8?B?eitWLzRDMHRGeGRMNjRpZWYwRG9kUVUyMDFxemRrZGNMWFUvM1JwZDhHd0x2?=
 =?utf-8?B?c2ZUdFdMTUFLQUJYV2IzWE1NcDVRa0ZmZlpkbURXVWs2QmdpYnNTbmNpaWtV?=
 =?utf-8?B?VlVDcCtzYVg0UU82M3hkRFB1VWRXWGdqbG1jQ1owT2w5UFJEeHdndS9WYUND?=
 =?utf-8?B?aks5TktaQXJGK3BVRHpFSWNoUUl4VFY2TlU0WGhXWTZ5TWpyNmY4M1ZETitU?=
 =?utf-8?B?bzhuMjV5ZzVLY3l2alZGZWdGVFRxTElHZUNsTVZmTUZyOUxBWFpOK3NCR3VP?=
 =?utf-8?B?bE41UUFWUzNKSDFpYnJKVEJ5dlhWOVRzVHE0ZHlSS0FsYmhPVG1qWGt4L0I3?=
 =?utf-8?B?a0VYUjZRZ3k3ejluZmwzMHRvRG02dnc3b2pIaWlBTUwwMU5CY3FjN2NFQjgz?=
 =?utf-8?B?blBvOWtHby9xRVdleENsQVFxT0RQajJIWU5WV0xmRmVEc21XUzd2QjhQcTFp?=
 =?utf-8?B?VWRJOENlazI0cFROOHAwYTA1T1pueS96L1RkelBtWEtIbWRjYkUzYVZucW5H?=
 =?utf-8?B?Rkh6dzNJRTBEV2lINEtRSVBkWW5ZNTNubjNvOTZXdCtuc3ZTT2tFN082ZHVk?=
 =?utf-8?B?RVEvdjA5MHQ2YUxMdDdxcUdIMVJwK1dValM2NVA2TGJud3Q1dzZhaTZxeU1P?=
 =?utf-8?B?Z1ZDcHA1M0d6Rk9KR0tKTVJzbXB1WDkrdnZSQXhRRnh2c2tad3g4bmN1eTBU?=
 =?utf-8?B?OFNnSEtvM0pqWkdKUkpiT3Q3cDkvZzlFMUMrWUd4QU1YekhwcFMyT2V5WWwx?=
 =?utf-8?B?RnFDRFVDWS9qUUNweTZYckVxRjYxRWl4ZTROK2NEU2lnaEI4UUJZTlVXb3NR?=
 =?utf-8?B?S2lFbzh5TzNTcWV1QmZOcGx4Q2NGSHNFcTlVRjJCejdvWDF1eFlrRVhCNFBz?=
 =?utf-8?B?UnhIOGduWkhwRUdCZktlY0hhOU1rOExYOU9pS0duQWlqTWIyNkxiemFxNkpF?=
 =?utf-8?B?RldhWFBtdmc5TzAwdlJOQW85WlIxeUlFNmZDdXB5bFh6L2YxSXhPcjc0NlRS?=
 =?utf-8?B?YUhVTnhGU3h4T0djeVRLbFRPcmxhV3A5T0N2TlBZL2gzdE5oKzkyVjJXNlNr?=
 =?utf-8?B?eWtZcVFUSDNRSDNBNHZqWmozckdZaVVTSUYwaEFjT3JKVFk5THNGSFBwTkh0?=
 =?utf-8?B?cEEzSk1RZUxFN2h1cXZXR2V4WU9kRHNUTlFoYU0xWFF6TDNxODhocWZ1a0Yx?=
 =?utf-8?B?NXp1VDZJd2krK3k3ZkZ3ZUlxQlFwakt0M1VDaGx0T2I4enpVNitVOCswYVdT?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e11500a-a1d1-42d0-e937-08dde9fe469d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:07.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTTzgnX3PWijhAbapDJTL5GpjwRa3sPp7D7ISqAcRZmvujTrH8RMHhbQxlp4pwmNpha1tmJymHWaK4YXDRl3vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
X-OriginatorOrg: intel.com


On 02-07-2025 16:58, Ilpo Järvinen wrote:
> On Thu, 29 May 2025, Badal Nilawar wrote:
>
>> For given root port allow one Aux power limit request.
>>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> ---
>>   drivers/acpi/scan.c     |  1 +
>>   drivers/pci/pci-acpi.c  | 25 ++++++++++++++++++++++++-
>>   include/acpi/acpi_bus.h |  2 ++
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index fb1fe9f3b1a3..9ae7be9db01a 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -745,6 +745,7 @@ int acpi_device_add(struct acpi_device *device)
>>   	INIT_LIST_HEAD(&device->physical_node_list);
>>   	INIT_LIST_HEAD(&device->del_list);
>>   	mutex_init(&device->physical_node_lock);
>> +	mutex_init(&device->power.aux_pwr_lock);
> Hi,
>
> mutex_destroy() also exists but I don't find any added by this patch?
> I think the pre-existing mutex might also have this same problem.

I will add mutex_destroy in acpi_device_release().

Thanks,
Badal

>
>>   
>>   	mutex_lock(&acpi_device_lock);
>>   
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 87f30910a5f1..d33efba4ca94 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1451,6 +1451,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>   	union acpi_object *out_obj;
>>   	acpi_handle handle;
>>   	int result, ret = -EINVAL;
>> +	struct acpi_device *adev;
>>   
>>   	if (!dev || !retry_interval)
>>   		return -EINVAL;
>> @@ -1464,11 +1465,27 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>   		return -ENODEV;
>>   	}
>>   
>> +	adev = ACPI_COMPANION(&dev->dev);
>> +	if (!adev)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&adev->power.aux_pwr_lock);
>> +
>> +	/* Check if aux power already granted */
>> +	if (adev->power.aux_power_limit) {
>> +		pci_info(dev, "D3cold Aux Power request already granted: %u mW\n",
>> +			 adev->power.aux_power_limit);
>> +		mutex_unlock(&adev->power.aux_pwr_lock);
>> +		return -EPERM;
>> +	}
>> +
>>   	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>>   					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>>   					  &in_obj, ACPI_TYPE_INTEGER);
>> -	if (!out_obj)
>> +	if (!out_obj) {
>> +		mutex_unlock(&adev->power.aux_pwr_lock);
>>   		return -EINVAL;
>> +	}
>>   
>>   	result = out_obj->integer.value;
>>   	if (retry_interval)
>> @@ -1478,14 +1495,17 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>   	case 0x0:
>>   		pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>>   			requested_power);
>> +		adev->power.aux_power_limit = 0;
>>   		break;
>>   	case 0x1:
>>   		pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>>   			 requested_power);
>> +		adev->power.aux_power_limit = requested_power;
>>   		ret = 0;
>>   		break;
>>   	case 0x2:
>>   		pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
>> +		adev->power.aux_power_limit = 0;
>>   		ret = -EBUSY;
>>   		break;
>>   	default:
>> @@ -1500,9 +1520,12 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>   			pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
>>   				result);
>>   		}
>> +		adev->power.aux_power_limit = 0;
>>   		break;
>>   	}
>>   
>> +	mutex_unlock(&adev->power.aux_pwr_lock);
>> +
>>   	ACPI_FREE(out_obj);
>>   	return ret;
>>   }
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index aad1a95e6863..c4ce3d84be00 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -294,6 +294,8 @@ struct acpi_device_power {
>>   	struct acpi_device_power_flags flags;
>>   	struct acpi_device_power_state states[ACPI_D_STATE_COUNT];	/* Power states (D0-D3Cold) */
>>   	u8 state_for_enumeration; /* Deepest power state for enumeration */
>> +	u32 aux_power_limit;		/* aux power limit granted by bios */
>> +	struct mutex aux_pwr_lock;	/* prevent concurrent aux power limit requests */
>>   };
>>   
>>   struct acpi_dep_data {
>>

