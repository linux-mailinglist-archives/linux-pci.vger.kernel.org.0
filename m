Return-Path: <linux-pci+bounces-42661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EA4CA5733
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 22:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E41BA319F94F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D33328256;
	Thu,  4 Dec 2025 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZz/2Hji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA04327C1F;
	Thu,  4 Dec 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882714; cv=fail; b=m70n+DLW2teUDyur+c+cNU50Roxm38g+6wm1YJUFYorKTdZlILmJ5xgpOG1zGtGjpagFJjl5cNNmVYqe36O+ZVN0xdU8PJbNY+A0PVPFwHuRlBl0iklDNUChzORqtC4qrzgQASceQeCZHPCuui2lNjYCvLDNmU5/ra+xsMEl7DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882714; c=relaxed/simple;
	bh=ufZrV4lemZffW2pTTiEUaSNrswEgTARzHZrOL7ZZRgk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Pu6TZGNHBe9WL71uYqpK+OhPalu8sG91D0Gw420+VLVX7Tw2SstaLT4JbLnDQlqvsDHo2DnvGx0wjgzURGUp0W/cHXdSIZWPb2h16gbkfqO0hbIRQMuQ81+tChlufIX44F83p3iY8nBNK8MfW7oL/XqpzoP27e4rWLZiNJt5e+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZz/2Hji; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764882712; x=1796418712;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ufZrV4lemZffW2pTTiEUaSNrswEgTARzHZrOL7ZZRgk=;
  b=FZz/2HjitByjzwMYabYwutTg561J4Vic+o9i2lK3ftulpfQheLmvG/BJ
   EG1+0xAs8jVuNBeawsABiTAfKDj4GkgsBonDCI9pW4UF+LksE6ef4v+6N
   u6tRrVguVzDnbRGiE92pYbW4nGvLMbyAG2zaN7WVBwfRNXpLGR1952as8
   e8kxan4k6hcdugIWIHfpZUCAlRt1Q231DCQKMYrhQiXXUVVMmZ6tsBBkS
   xTJA566Qo5hZtbbs67rMMCzoibWxqX0e1jjKeuxSmb4wHaS3yJYEB1DSF
   dOA8juKy0r6kywEtB47qoSGLKKCQD1gd6ULj6M3GSQ2lNX2hDEhWxe1sU
   Q==;
X-CSE-ConnectionGUID: vihiUKl4ToKCpdASqiIwFw==
X-CSE-MsgGUID: xqGWHP16T3iILG61T8bUKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="67079422"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="67079422"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 13:11:52 -0800
X-CSE-ConnectionGUID: XrtyX1QaSjK4K9UayZZbzA==
X-CSE-MsgGUID: x1DzBSAjTISYSolJJzef0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="199260112"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 13:11:51 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 13:11:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 13:11:51 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 13:11:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWSBwfodwwWCekMrNskCIqL2IT+euPTu0hYTwEcw6TwZuj7K7PqH8cnrm0Yvequrx3+tH5BkLOKiSQxvddAqsRmUUdBTElMJY4p9ynKxHJRmiZuokBW88KFqyDmCG0GrlZdLGzZk0IxX2ii3RdlN3gOoD67giyu5nfQlXfMnZ49mnQL1xgXwHAzLCgAL9BW+/Nh7Glme9ACQq2DFTCOliZxgTvooohr1d5tJE0Z4A7RVKyDY8aC/wjILjXngbYH3bx/mYYrn/qWtGQ0bLi+XpKoiS4yugwkLookGhEojQBxjQuwlvvspbtN5rJ2tJAvjSRPnVS22d5P0PBqJlB6Kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xuL61kiDsAXGzZqkAhk3nsQFd9Yzmb/YuyXhO8bL2s=;
 b=okYWpYT5v7680zl9DrixS0YXx2wp5b7bza1/ekaXDrlA6pIPc+HSqP3+FrEUQ+1s0LEDVK5K5gEf//6zq7N1lSyy4RFk70xCAUKrJDnTwaj+ZZst45QVSgfKcyrJQ72VaQQhqT6/FxUTb7avYowYL7ZCP7qeQ8q6lpBE4NCpRJnvMQUJclM1neV8VBbT8r0JABPfxLNzY21ZsJmxc9Gt8+WD3xDv9Eu2nQEMGI3YWTQcAYieJ3pMtQZUIMXv/3EADD5DcS4lqYDHHwVzQy+cb7xmZKQTdPqzS25fay96APrT9up6AmbktUnd6MVnXuKh2MIhLU/+9xC2E4PUQDVJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 21:11:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 21:11:48 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Dec 2025 13:11:46 -0800
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
Message-ID: <6931f9127f46a_1e02100a0@dwillia2-mobl4.notmuch>
In-Reply-To: <03ec6e1f-bb7d-42e2-a887-70c18dbf4749@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-7-dan.j.williams@intel.com>
 <03ec6e1f-bb7d-42e2-a887-70c18dbf4749@amd.com>
Subject: Re: [PATCH 6/6] cxl/mem: Introduce a memdev creation ->probe()
 operation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 2442211b-adaa-477d-c710-08de3379bc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEJHaUZmSzZLUmxKWTIwTWdKQXlnYkt6MlMycjFoclF0ZkhxQ2JGc0J2QVJS?=
 =?utf-8?B?VnJZWC9hcElKNWNGSSsxYkFpQ2N5MzFrWFpvSTAyNUpQRjBic1JHQm12N3lH?=
 =?utf-8?B?N0htTDhyeXIzV1RBQy8xRCtBTTQ0NUdMaEdwZTFoN1Bwd25HNndaOWloUDdN?=
 =?utf-8?B?VjIrTWNNWXU1ZmpkWldSQXBWQTI5NlhGVi9va2xsTTY5clpMSEpQSm55TjZm?=
 =?utf-8?B?OVEyeXJJUFhpbUlMTUk5NURiTS9FeGgyUktSQ3BBWmoySDRQYTI4Z0ZobTdO?=
 =?utf-8?B?MzErSDRYRTVJZTNSZGZndDZJWm9zNnA2dmNNU1dFRTRSWngwMFN6ZlhWWm5i?=
 =?utf-8?B?dnNiWFFRK1E1bmNuUzMrZWN0YVpoazU1UVFIbEN4UjN3ZnVIVFNhUWhCclQy?=
 =?utf-8?B?RUJYMi9HYlJITkFqYXowWjgvYzMzMDdXOUFzejFtZU1ueis1SzNYSFJkQy9H?=
 =?utf-8?B?Q2lBU1k1R01qaXlkRktxd3lVQ3RJdFpQWERoaVB4QktxUk9aa01PaTBZMGpv?=
 =?utf-8?B?ejNQWWk1OGVyVUZCVFZuUXlNSGRqSWo4MHNVOWxSY2lTKzhDWDRKTVAvdGRU?=
 =?utf-8?B?NmZnWDFGLzN2emY2ckROUU8wVjdDQVBBYkJUUmpockxZeTQyeWhhbGFUYkRh?=
 =?utf-8?B?NW55cEQ4bHlSb1NhQVhNWXFhVVdRZ3RUYkdWV3FCSktnaWhqTzZicUVEcXpz?=
 =?utf-8?B?S09QZnFqWVovdEMyL0VTdVd0emMwVVpVQVdLTm42cU9nekZmVW5TNlAySkpE?=
 =?utf-8?B?OW1VbVhoc2JtZkZyY29naXVESHRtbi8rMWF0c3FPbnVpdGhISHJ6QUpkSUNQ?=
 =?utf-8?B?MlYxY0wvWnMzM2x1WUdGVFlKOVExR08reGRMVWgvbEhCRnJGNk5Pb01VMkNT?=
 =?utf-8?B?MmF6QmVxSDBiQlBUMDIwc2RhYUFwOGtrL2FWYWdqUHR4aE0zM3JYdjZYY082?=
 =?utf-8?B?cjg2R0NUdTFaa1dvNTd5dFZLKzd6aXBvc1BWcHJYcEJ4UE83NlNWVHdpdm9H?=
 =?utf-8?B?NS8zRDEyREZYZFNiVmxVZWdIejhHaENaOU8zeVB1THRzUWQ0enNtT25DdGtZ?=
 =?utf-8?B?bk5JcXdNa0h2NEtjUGZxcE5pS25jQ3kxMnY1cWhJcVZLZW9ZUlVTZG9mK1pW?=
 =?utf-8?B?aFhIUUpTTHVJaDVJMG1vd04rdmRSSktmV1Eray92a3lxWmFwK2lSREFLYVFX?=
 =?utf-8?B?ZS9hQkdkdDYzbFlTWmxGWU5sanRMd1F1UytjSjZIV0szMm1rRDl4UEo1eW5P?=
 =?utf-8?B?bGNOeXVZTEtIZzc1OWhoaEhqVVZSK2dXZXlzYm02Ull6Vmd6eGZTdE9YdVQv?=
 =?utf-8?B?NTZOaDRCc3pteVg0YzFrbDQ0SzdnSGl0THBxV2NKTklDMEJ1VDJSN3RYRUFP?=
 =?utf-8?B?c01JM1ZBT2N1UHdvT0hrZ2ZiUFNlbVpvb2JyTk5keGkvajJ3WGZSTlBqNVp2?=
 =?utf-8?B?MTZLNDNzclBINmhtNzVsZ3Qya0srQ0ZrYU9CSCs2c2YzVkJ6bUxSNm5FQnRk?=
 =?utf-8?B?VGRFYnczQUlTVlB0U1YreCtVeUJlcWJKaTNHOFlaYzNSZjA5NUphWkJ0RWV6?=
 =?utf-8?B?S3dEMlZkZVIxYzdQSVpmNGp5aUJxQkxMUmo0SGlsWnRjLzZ4R3l4NTg1Vndp?=
 =?utf-8?B?VXBvOUxqWjVuaHcxaDRXVXVNK29wRFA5T01kWTRwZTVWbmdEK0pUQS9VOS9l?=
 =?utf-8?B?S3JnTVBMKzhTNHdYZzUveDh2cTY2V0RrUGZXS3BxVFU1MVlEWm96UGwzUnVK?=
 =?utf-8?B?NTZmcVoyZWJrQXI5Q0hwcjRnZ0F2cmRIcC9VbjkxTG1ZVS9wTlFSalFKV25h?=
 =?utf-8?B?RDRNSFFVc3dTUTlkUS9weU5mNUI4MFdTQVI1Rm93R1YzTGhuaTBwYmJWSG1G?=
 =?utf-8?B?dnl0K0FJd2h3K3VRSzJHY09XdXVsTVpDNDA2QnIvTFJhcUlTTnFTTW1pVUR5?=
 =?utf-8?Q?Gngil5BYfU/kbNiLjnxsUeVth3soNJoa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnRYbjRPWWFRaXVud2lkbjF1eFJVeDBrNGUrQ3BsbG9GMFB2OWFwRENjYTlD?=
 =?utf-8?B?OVRCb2J1M21WY05FN0tSMm5aZlpZeU0xZXVPdURzRVp3aDdkRk5MNTVtSk8w?=
 =?utf-8?B?VzFWTUJXdk5GSWYyQldjd3V6d1l0SUZZYzdiSy9BcnI3emdPb2QvcVI5QXpk?=
 =?utf-8?B?dlJmUDFvZXFCTEc1cVhSU2dITzNPZUNnbi9pT1ZFakxCc2kza0kyemQvRXlL?=
 =?utf-8?B?WVU4NURqbS8vdDZ4R0FGWkptSytoZkViZ3NTNDJXZkQ4TlBjNWFJYnhLTGh4?=
 =?utf-8?B?OTE4Y0pKUkF0Sm1mYjIvTjcyTG1BMFFhMG9MNGo4a1hUNDZvekttY1NCQW5Z?=
 =?utf-8?B?ZEhGb0ZxTVZhQVJaWnRpOVNlT1NNNFZBMHp4b0dLc1JrUGF2bngyakRvVUFK?=
 =?utf-8?B?K056cXovdmFlbEtMOG8ycThjTkRHNFZUVXNTZ3ZHbVVxVW9RZDE4Ukd0M0FN?=
 =?utf-8?B?blZGczZ3N2ozTyt2U0pVVGpVTnNMK1NwdlJhQjdFNmRUaXhsaWI1cWZEbkNq?=
 =?utf-8?B?dWxpcXNYWFVYbStpd0xkVC9CMDZRRyt2TFEvYmVud2d5dm1KTllyQlZDOVVV?=
 =?utf-8?B?ZXNkblgwVlZDYVJrU2VHZ1dQNlJod28wYi9tc0FTMmIyWk0xdVNNOHB6RG1w?=
 =?utf-8?B?RVRRWTBoQW9STEVTbnVya1NiQ0NjdnFYQXFqbU5BbEhmdE5CNXdmckl4dllD?=
 =?utf-8?B?Y2VHVS9qQlhOTlg0Y0sycHIzdDJJTVVhWTBNMUFXQ01tTmVKQmEwaCs1UjI0?=
 =?utf-8?B?MkEwUnhrVnFrTGtoeFJoOWlNaC91MU1BN1RqL3R2UENqZk9heTREdldDaHFP?=
 =?utf-8?B?bVFwSXMvTjlZS2sxdkZyMVpJelF3bHBlVFJudThwd0x5cGRkUHgyV0dnaHVP?=
 =?utf-8?B?R2dEVTVYSHdUMWtEZ1N2eEJ2ZFZDNDM1QXFwMmxFWld6RXBRY0hzTlJsTzlS?=
 =?utf-8?B?RmhzUUtiWVhmdzZDSzllWXQ2MzVtQ0N2eS9sNXQrWnpVOWMyNExtL1hhV3Nu?=
 =?utf-8?B?R0ZjVFhLQVhDUE5lNXhidEF4dlI0TFhMOWdxV0NzOFJjY0o2Yk80d2d6ZkNm?=
 =?utf-8?B?TFZ3cm9oQmNSU2pkYkVCd0ZrZnNsdTdvWktjVU56QUwwc3hnbnNjVjNRcFhh?=
 =?utf-8?B?NGxpazdxOUJDSDFhdzB1TmZ2Rmd6RVhvend5TExmdTR4QXIreGVNVzg3aWNY?=
 =?utf-8?B?TFRpU0lHZklXck5GUGE1M1dNUVp1WmR6VktsdU9ZNWJRTlFBY2tEcDE0aVM2?=
 =?utf-8?B?am5KdGdhQXZhQm1Bd2cvMVhSdDIwSWF3SnhNZ1VHeFBhUVkzeDNQMmRLSUJy?=
 =?utf-8?B?QWtGL014L0pEYW9xclB5SEQxNVRSVkhOWWNHdmhYWDhmL244QndkaE9NbXFZ?=
 =?utf-8?B?Z1ZnN3lLbjJEdzVuMEROOXBHOVpFU0F1VlVsRjJ4aVQ1K2lBN3ZFTUpweXFH?=
 =?utf-8?B?SGNPYUg3SUNXZlF0aU9mYlVYUUVlM2tGYm9PcUNKMzRoRkdJNXdhek1vMVNj?=
 =?utf-8?B?WEhWajNBa2wvWGJORi8raCtNQXprbWdSQ204L3V0ZDVEZzRiaWxqNlhFcjJV?=
 =?utf-8?B?UDgxYnN3S2k5MUxwM2RHT2lUaHJWVER4UGZiNmxiVmhCbEo5NkZlVlBmbzdN?=
 =?utf-8?B?cTZKVHJnY0wycXRXMXRsZkdHUXNudksxMWZnaHM2T051QUZsaUswNnlNRm8z?=
 =?utf-8?B?ZWhicUxubUZJUWNFY0hMWk1scmZJZ3lHWWp6REhlM0VNeno5Sm1PZlhtUE80?=
 =?utf-8?B?WnlZQnpzYzhWamQvNXlHbnM4MDl2VUEvdzBlWmZBUUdDa09HU1pCL3NJMFVq?=
 =?utf-8?B?Y3RZQ1huTHZqSzl1ZnUyZmNLeEtvNnc1cnhPNUlodVRDMm5wS043dXNQZG1P?=
 =?utf-8?B?RkNqWEdjaFBFcGVmT0E2YmdBNkVMZXhWbnE2aEwvNmV3ZFFER3J2eFFsTTBu?=
 =?utf-8?B?dFJOYm1aRkdoSmZZQkU2N1JtUXlObUs4OHpncHUzL3kyd0dGWkpHVHZyenVu?=
 =?utf-8?B?TXNuS0pVVUhMSEpBbW9EQWdhb1ZxVmhRTkh3S2taK0YzclhiaWZUTmRPRjlX?=
 =?utf-8?B?aUVXTHJSeGNQcXJjSElpLzd1RTBLVmJhenRPZTFRaWhud1FKSlBDeU1acFMw?=
 =?utf-8?B?YlVMbkk2WEhIaXNkVWEyY01QRG5YQTRQRExWSEpHRTlxM0p3TTV4TjFPK0hT?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2442211b-adaa-477d-c710-08de3379bc84
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 21:11:48.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vu+7IXIxGC3lgxOpKj0pZrFxL7hu/nV8aYod9ivseE1k0L8dA9LQXp0xeNNWM0IIPVUQF19nio/TBeSeKH6WXtzkpAtJRmj+8wDyRLwGEkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com

Cheatham, Benjamin wrote:
> [snip]
> 
> > +static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> > +{
> > +	struct cxl_memdev *ret = cxlmd;
> > +	int rc;
> > +
> > +	/*
> > +	 * If ops is provided fail if the driver is not attached upon
> > +	 * return. The ->endpoint ERR_PTR may have a more precise error
> > +	 * code to convey. Note that failure here could be the result of
> > +	 * a race to teardown the CXL port topology. I.e.
> > +	 * cxl_mem_probe() could have succeeded and then cxl_mem unbound
> > +	 * before the lock is acquired.
> > +	 */
> > +	guard(device)(&cxlmd->dev);
> > +	if (cxlmd->ops && !cxlmd->dev.driver) {
> > +		ret = ERR_PTR(-ENXIO);
> > +		if (IS_ERR(cxlmd->endpoint))
> > +			ret = ERR_CAST(cxlmd->endpoint);
> > +		cxl_memdev_unregister(cxlmd);
> > +		return ret;
> > +	}
> 
> Two minor gripes here:
> 
> 1. The cxlmd->endpoint portion of this is unused. I think the idea is since this is prep work for
> Alejandro's set to just put in here, but I would argue it should be introduced in his set since that's
> where it's actually used.

Fair enough, a follow-on changes can add that back.

> 2. I don't particularly like drivers having to provide a cxlmd->ops to
> automatically unregister the device on cxl_mem probe failure. It's
> probably not likely, but it possible that a driver wouldn't have any
> extra set up to do for CXL.mem but still needs to fallback to PCIe
> mode if it can't be properly set up.
> 
> I don't want to nit-pick without alternatives, so my first thought was
> a flag passed into devm_cxl_add_memdev() (and eventually this
> function) that dictates whether failure to attach to cxl_mem is a
> failure condition. Then that flag replaces the cxlmd->ops check. It
> may not be worth adding that degree of versatility before anyone wants
> it though, so I'm fine with the above approach if you feel it's the
> way to go.

So the problem is that cxl_pci definitely does not care about immediate
cxl_memdev attachment the way that a Type-2 driver probably should. The
way I would handle the case of drivers that only want probe failures and
nothing else is to just provide a common default @ops implementation
that those drivers can use to get that behavior.

That is functionally equivalent to a new devm_cxl_add_memdev() flag, and
is something that can come later when such a driver arrives.

