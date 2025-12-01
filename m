Return-Path: <linux-pci+bounces-42410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C30C992DB
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 22:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA2934E1CCB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749E2868A9;
	Mon,  1 Dec 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EK8M8OF+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22727FD5A;
	Mon,  1 Dec 2025 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764624571; cv=fail; b=f9mMlTThKkbRtNx2nTsq1At19Lxz7bFR/eJfF5hNJ15+2X3YKn/KvQRNfExuIb9CU4Nk3/hSTG/F1vkIGXvXrheuab5zxE4h5dX3AM8t8zAyaO2xVWj4I952cy/WXqJq4mLjh5GZaqv/3FyVfayoAXZZlGFnrF0vr6plwP2qyRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764624571; c=relaxed/simple;
	bh=csrgogbsrGWKZ7GjSv+QWjYK8yZm7NFaEISgZY6890g=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=QZBPIBsr29IpKwTVEdO3gKnqfp+0TcnFv/gWe0VzRopXGfFNSpfKBXUqG1waQDdcYEeNDMyIqO73FpnaerQjlREe5/acykzbDg5kqlnI7k+EMhm5oO6Sn4zP3cwpRT8Xrth3vgePMdbJK/N2LhWrhqEpYwCeFUZu8fd4/z8iTN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EK8M8OF+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764624569; x=1796160569;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=csrgogbsrGWKZ7GjSv+QWjYK8yZm7NFaEISgZY6890g=;
  b=EK8M8OF+uuFMpIPlxHsuyYHzMGm7ti+Z5vEy4Wy16NgRrcGIYTA74R0S
   9GMFc2XN6TxvOL63QDrCFAnfPmISORlh4jDJwhEkRr2YLn298Du19HoiK
   /Q74hVy9XrvpNWYtaCxH5SBVwUZZqW5kgvuHClEti3Dt1tmKK7OmLufkm
   zLjPE+5f1mcAkkcwx0VV7F11vGJZ+kpHZgP/ASLazSuLefhAA4wt+vqsO
   Kwdyp0iAPH3KKBslY3WnEFEwZQSjFrTR6wvsVpbPZkCpGJ03dGrEgZ5Cp
   9OYlnRFGJ9PUVu2IU2cXiLX5aeK7CkTNGw/cAt9ERkOAJUiOXIC+RPNda
   A==;
X-CSE-ConnectionGUID: 5f4HXsjSSbe9WmcYaK66bw==
X-CSE-MsgGUID: 6lnaU2lyQkudDtc57dXReA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="65581642"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="65581642"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:29:28 -0800
X-CSE-ConnectionGUID: Ri5u4psyRu6ZTEhqh1G88Q==
X-CSE-MsgGUID: CoFH0z/qSyGj7w5zN/eGfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="198641683"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:29:28 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 13:29:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 13:29:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 13:29:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNmQrOjo3kiZ1XnTyoGvJyVPmh4zpXZCa5GqLuKb+qjZG827jHzR6HLoflEAO342qbiHOyrpaoqzivYwDYEkrc3fZQkfZJN7s0gQeU8nYvOEpOg/wRSIk0fn4L6A1VMp3FrzDSH6DHVUEWVR0Kgz9XZsbSASSB1cJ4BCRu2mWlLSyCUG7Mc+l/M5SOoevja5Z2Sv7vKSIhQ3hIJz4JEMU3IR1MKoWFHwjPhyazJDVJn0GpzdX4CaI6yzdXACpz0WS2roABW8y5UoblHnfHk1HDe9MQ48ZDC2bqoUB21imG5SrppJeyMz6J1sLXkUaZcK4e/kppEEWISnUn+qYiW4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uJIlI4PfL94itT5vmuuOwtk24QVkrCUUyv5gx9hWRc=;
 b=s6GJk/4Xm9kPuBtVAMgmmxVv0jN79ZvNxaODmzarRZb7TujNn8e0i9zAX4ciONotyaylmQpkAX8lOi/WKdhPz2voEIOWVC0wgZWKhiwxQldioPPNzMD4X6G8/IO5U6DhcyKZOQ0C7q/0xxJ4bT9fCi7OwPWnoO1U4fTjYKv0dWDBAphoVIbSKx7MFKwwigPzssDqzidb7erHe9w02k4dwUebNPdQN+xkpusYyEDrbzPoVrgSw7NUf97TR7hQewyT65rUXqmlmz57Ix6Y+F+RE+1BDxBi7IP1dm7tW8xQTye1Q1LnfcL0mBRKzK0ywJ7ShXChQkkaYWjvPm3crgH6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 21:29:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 21:29:24 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 1 Dec 2025 13:29:22 -0800
To: Dave Hansen <dave.hansen@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<peterz@infradead.org>
CC: <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Balbir Singh <balbirs@nvidia.com>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Andy Lutomirski <luto@kernel.org>, Logan Gunthorpe
	<logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, "Yasunori
 Gotou (Fujitsu)" <y-goto@fujitsu.com>
Message-ID: <692e08b2516d4_261c1100a3@dwillia2-mobl4.notmuch>
In-Reply-To: <2d4fb1ce-176c-404a-852f-987a9481046d@intel.com>
References: <20251108023215.2984031-1-dan.j.williams@intel.com>
 <2d4fb1ce-176c-404a-852f-987a9481046d@intel.com>
Subject: Re: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a91953-b919-466a-39f1-08de3120b309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXBEUnpIbHRQSDNYNDViS0I4aGgzVE0wYklkOEhOOG82Q0VOYTM4L08wVGpD?=
 =?utf-8?B?d3JLeGd2ZmhrOWM0TmxvZUNOMm9NSDk5MzJCZkJMU3VZTXNjNHJEOG9HNXFo?=
 =?utf-8?B?Zk4yRHZ0eXhSR3BSTXFpWDBDem4zSWV3R00xRG45VjQ3RzlreDZueThOVlJI?=
 =?utf-8?B?bFV5dVhlOTgweC9lU0VSWDF4N0F6dlFiZGtuWEpsYS9IeGhMYnROblV4WEZH?=
 =?utf-8?B?WGRwRjhBUGgvT3MvU081K0hsdkRoYUttRnZvZG53NWNjbkxydGo5VWEvbHd6?=
 =?utf-8?B?Wm84bEdObWRQZDhyRjhIZ3VzeGRUZGtrdkZ2cmxnZ0NvdFJnUVBYeENiT3Zr?=
 =?utf-8?B?MkV0QTVuZnVjWFdFeXo1WWNZQVN1VUVOajBNTGFOcnFKenhNSWROemlTSTNR?=
 =?utf-8?B?RUlkMVN0bFJrVWYwSEdpcG1rUml3d0w1ZGltZW1TcEF5azBER1hNaTV4em45?=
 =?utf-8?B?Z3IvTEVqVXR5ejAzcElkdnZ3WGlNRVZWYVRtU2liNVArL2RMY2ZNNGZkeVpj?=
 =?utf-8?B?bzhrYm5wUDdtMkJhMlEzTHNxdExib04vMTAvLzQrTnhTODkySmhyTWpCNmVn?=
 =?utf-8?B?am5xYVUzaURCQUY3SGFmQkUrRDd5cVNCbjg3L3NCTW5HMTVtaXlOWkxLN2NK?=
 =?utf-8?B?OGRUTDRINm4zSTVCVjJ2WSs2WE9obUMyR24yVlhQS09BZ0NpYjAwM0kyYjky?=
 =?utf-8?B?bE1wN05nM1Rtc2JVbHhzaHpyRkdmc013Wnl0WXowMElSbTdEdHpIK3JlN0ho?=
 =?utf-8?B?SndSUUltVEhWU3hTbkpxdStQL2pYbDNtS3dmY25jbTJ4L3c1eUVndGpWNVc4?=
 =?utf-8?B?b1UrWVdkRFA4S0c4bWtSYzRUeW9pRkhPTW5VditJN1ZubmlTOXFMQnl1V3Fk?=
 =?utf-8?B?T1JhUGE0ekhYbjZ5QkViK3BNTTJKeTVhRlNqcmZ0U1R6MzY0ZzlLcGtuNnE3?=
 =?utf-8?B?MUM5elppbEFjY0QzQW9DWFB5dmdSeUpNUmNHb0lmNVJqTjZMTWFCYW9ldlNU?=
 =?utf-8?B?c2FZZ3ZRaW14UHAyT1JEZFQ5ZFNCVXVRNGRYMTBFcGhDUnp4QlFtRTZNNTd3?=
 =?utf-8?B?cENURDhrK0dKVGpHQTdNTVl3anZETXdwaU5KR3lPZXFkZnNwUmxBNnRDS1FL?=
 =?utf-8?B?YkZxSmxCZUl1T1pobGhoY2hzTEVjYWFRbzVQaUZsVFNSSlc0Nm40WGc4VXJy?=
 =?utf-8?B?MnVWclR2L1kvdzRGTER4N2V0aTJtaVhsYWM2MjRZcEhFQmxGaEtTb2FGR0VB?=
 =?utf-8?B?MitPL2R1TStuMkFPMk95MElpQUl2d1pRN2EwTmI0Mnc4MWlFK01aQVRhMnJQ?=
 =?utf-8?B?VHhpSUs5WHh0b3pFQXpsMkY0WElzcEZFREc1dWJwaHY5dmJ4NmRJUWZhdjRq?=
 =?utf-8?B?MUxXMzdoY0paWXlsRVVtb1RDREpnM1NYSHJXd3dXYVoveEovWFhDT3B1d2gr?=
 =?utf-8?B?S0ltalc5WVU3ZmpxK3pHbUNVQ2czM2w1akFzWjlSNHAvS09lM3ZVNmRzSVJo?=
 =?utf-8?B?akNiZE0xK1hVZWlRWHl3RWk2UUh0VlRtZ0pCeWZGb0pCR3hVb0M2WlVRQlhG?=
 =?utf-8?B?QmplajcyNzJYbFBLNFFsaFQ0YlRIZGFiWmV2d2oxQ2ZLUDMxWitkMDdvWTlE?=
 =?utf-8?B?ODNuWnFQbE9IKzNWQktKSTUvd2xGeXJ1Nm91VUU1VXRPdUtMZHYyMU52eGk0?=
 =?utf-8?B?RXpMSXZxMHBxQk41eXFIY0czRDBiczV6ckI0VElmd0FGSXZ3MG5IZitoL1Nx?=
 =?utf-8?B?OWVCTVZiSFlzb3NLUnRnSkwvSjRTY01CNXhmeUM2WDBWcGRkVHgwWXZxL3R2?=
 =?utf-8?B?dmpFNm5mK1I0WW1kWVRGU2JNQWVqcEVMZncwVFYwbGdlaVdtWS92VkpEYXBZ?=
 =?utf-8?B?NitCZlVNa29mdVlGYjlpZHh1VHNma2VKaVZiN2Z6dmxoNElRZTVETE5ZUENq?=
 =?utf-8?B?S0p3aUNDRTJqenRLWTkrMjNLWmloM3BwWWlXSDNXclQzSjFYYkJhNldLYWlV?=
 =?utf-8?B?Tjgyc082MVdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjcxN2JTWEp5N0VzaTlYNVBXNzlheHJjT3B1dFdZRGE2endDVnR5RVM2UzNL?=
 =?utf-8?B?T0psaElvZ01ndnZLTTlNZ2xMUGpUbkRyMVFnSkJ4ajZaZVg0RnJ6SlhuUDhR?=
 =?utf-8?B?eWpLUm80aHhUMzhtQ3VvVVdQZFBvZkFUaCtZK3Uyck1wN3dQcENRamNSbjNw?=
 =?utf-8?B?Nis5OWEwek93eCs4TDZONlJWekM2S0xUem5TWHhUdStvL2JldmRmMVROQ2tW?=
 =?utf-8?B?a3NRczlrRDlhaVNUa0xSUFBaV1NxNFVvVWl5ODk0V205ZDVsMlBMU0lUc2Y3?=
 =?utf-8?B?ZC9CQlBVV2xaVWNmNkdKRXRTa3p1VDc1UzZKQlZHM2VjRERRalNTYmZqT1dP?=
 =?utf-8?B?SXVMa0twcEFlaFF5OU40dGh2S0FsYzJOdWtvUTk5cUxEcVFkWDJqZkswd0RV?=
 =?utf-8?B?djF4bFQzc3hEbGxZc0txZE9JY09DMksxWXZNM3ZMRjd1VXEzWHhMUThvTE5m?=
 =?utf-8?B?REVsaUJOelVSeStFV2gyQ20zQlpvWnBIR05qSjBUekRYc21jUE9WazRmUmZx?=
 =?utf-8?B?TWpTc3FyaUJYTkhtMDdJaWFtMUdwb2FScE9na3E1M0NuUjI1QTh5cjU4N2s1?=
 =?utf-8?B?OUFqMEMxaklSeGh2eitHYjd3eDdCdnIrSnd4RkVnWGN0NmJRNks3YkxXWHhn?=
 =?utf-8?B?L0pBZnBiZFRwME5YWCtlVmpGcVBlck9WTmc1dFFxNDNpMmFhb2dHUHI3cVVB?=
 =?utf-8?B?THljVGZIeVNBRVUrZThHWlVZZFBWNUpZZDY0c0d4RnRhQ1dlKytNU3N0T0tt?=
 =?utf-8?B?VkJBRERaa1dWekZrTHRzZThaN2QzZGVXdk95ekhFOVUzTjVTRGFqbG5Qb3Nl?=
 =?utf-8?B?dWRLaHc5Uk1LK2ZXemhKUytreXA2dmpQSFBuSS82OGJWU2R2UEhrMU90SmlE?=
 =?utf-8?B?Smxlck9oalB2blV3SEZKZ2NoSkJMVVJ3eFZxUU5uRVFOTC9ZNUJXWUdTY2dP?=
 =?utf-8?B?eDBueEt1ekJ3OHJRekNqNFJYMVF0OXZRRUl2Z3FzQm1DK2gyTVM5WDNYSEZq?=
 =?utf-8?B?RXZaZ0g5a3cvc1dCYWVOdzl4clgvaXZodm5LUnhDUC9tKzFFMHkvQnBCRlZD?=
 =?utf-8?B?aDlGMlR1WnRlYjBndG9HaEJOR2NZSkdReU5mUVoyYzJxTGpMd1k3NTZvMXdu?=
 =?utf-8?B?cnMrWjJ0VkJuQVk4eWdGaG53OUdPZlVwSnllcFFRcDFrU2tJdWhDbnhJOGVy?=
 =?utf-8?B?UjVRMjU0NkhwQ3VGUjdydkxSWnlFSEl6N1JaSWRMUHhBbGhqS25iNkkzb2JQ?=
 =?utf-8?B?aE05UmhKVVNwYjQyTFpvT01NTnYveGo5blR6RDNiUHNDRktVT0F4TkpJUVli?=
 =?utf-8?B?ZGoxNEg3VjhHTWpBS0JFSVZOR1BZQkNBMlRZUGlIS2k1ZTJDTGZOalpLM3FC?=
 =?utf-8?B?VFdDVnp5cEpzOU5KMnZBbWkrUHBGNElHWndrUExFbzFKWVdUREYrNVE4MjEx?=
 =?utf-8?B?Q3RySzUwZEVVamw4czl0aWhlejFWa3h0SmV3b3ptd09SNEVZRmFQZmVmZDRn?=
 =?utf-8?B?MHBxU2dKNUNrcXFzL3NVZjl2dlVxZlNFOEs2Zlcyb0NROTh3bFM1NlJVQkYz?=
 =?utf-8?B?eU9sMm5xS2swdDdPbWo4ZlpKdUtyR3RQelREOEp4a0VZYnZubUhFbHI4T3hN?=
 =?utf-8?B?bzhGZDA4NGdWRkl6TmIwNERSdTFURmtNOEZLUDA5MEV5UUVYK1A3clc5QlF6?=
 =?utf-8?B?WDZ6Q2MydzEySU9pK2F2WTMwcDJzN2d3dXc1cDNBRzQwU0ZJZ1pjc25iaW5F?=
 =?utf-8?B?OWI0SFB5bjV6VFpJY0t4Q1ZMR01jcTRwSWcrZmZQS2lxTkZHVHRRM01DdUly?=
 =?utf-8?B?TytFM1pPZ1NINy9mcFhldDJZbVVmbFY3bCtNRnFna0E1RWlndDhpcWUzcjNs?=
 =?utf-8?B?YWE4Z3ZHSGlrQlJtcytFMlBYNDlTNjh5eG93ZXZLYWk1eDdla3E1MzVMMEFw?=
 =?utf-8?B?QS94TlNsTi9tMDkvdjgyVFg4UzJ4R2UvemNKZWw1U2RuOEVqeWN3R2ZpSHM0?=
 =?utf-8?B?amRuWmtzSVJxdjVBOUpMRGlRZHFJTk5rY1phUlhMQWVId3J1ZUVyZHVMNTha?=
 =?utf-8?B?NW5NbkR1VXpyQ3VzREw0WXJCb2RQc3lvZ1dTVjd4Rk1RSE9OMjZhZ2h2V0N6?=
 =?utf-8?B?RGhhZndMclpYdWZFaEpPWGZCR2tzZnpnRlBSYVMzUllPc0QySXpSUkJyYXlU?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a91953-b919-466a-39f1-08de3120b309
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 21:29:24.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JICb5ZQsIs56n0SQ8yjIi2d7atTqDzDYhX0SMoAbyPt4DJFzXuOIlJ47X11XyeIT05KYwEVcJOdwfvzPioWr6HMrodtT7LtGYijQJpkfUAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com

Dave Hansen wrote:
> The subject probably wants to be something along the lines of:
> 
> 	x86/kaslr: Recognize all ZONE_DEVICE users as physaddr consumers

...works for me.

> 
> On 11/7/25 18:32, Dan Williams wrote:
> > Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> > is too narrow. ZONE_DEVICE, in general, lets any physical address be added
> > to the direct-map. I.e. not only ACPI hotplug ranges, CXL Memory Windows,
> > or EFI Specific Purpose Memory, but also any PCI MMIO range for the
> > CONFIG_DEVICE_PRIVATE and CONFIG_PCI_P2PDMA cases.
> 
> This should probably also mention the fact that:
> 
> 	config PCI_P2PDMA
> 		depends on ZONE_DEVICE
> 
> It would also be nice to point out how the "too narrow" check had an
> impact on real ZONE_DEVICE but !PCI_P2PDMA users. This isn't just a
> theoretical problem, right?

Yasunori filled in a detail [1] that I did not have when creating the
patch, specifically that when he enountered the CXL collision with KASLR
he was running on a kernel before commit 7ffb791423c7 ("x86/kaslr:
Reduce KASLR entropy on most x86 systems").

Either way, a pre-7ffb791423c7 kernel and a kernel with
CONFIG_PCI_P2PDMA=n would fail the same way. Yasunori confirmed that
current kernel with CONFIG_PCI_P2PDMA=y, or this patch solved the
problem for him.

See below for a reworked patch with these changes.

[1]: http://lore.kernel.org/OS9PR01MB124215C4182B59D590049B99390CCA@OS9PR01MB12421.jpnprd01.prod.outlook.com
> 
> > A potential path to recover entropy would be to walk ACPI and determine the
> > limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
> > smaller systems that could yield some KASLR address bits. This needs
> > additional investigation to determine if some limited ACPI table scanning
> > can happen this early without an open coded solution like
> > arch/x86/boot/compressed/acpi.c needs to deploy.
> 
> Yeah, a more flexible runtime solution would be highly preferred over
> the existing solution built around config options. But this is really
> orthogonal to the bug fix here.
> 
> With the changelog fixes above:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Oh, and does this need to be cc:stable@?

Yes, especially because it would create a dependency on 7ffb791423c7
also being backported and that would have helped Yasunori avoid this
problem (for CONFIG_PCI_P2PDMA=y builds at least).

-- >8 --
From d2f4b9ac915ce35e2ec842548ae1ccb4f1690b04 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 6 Nov 2025 15:13:50 -0800
Subject: [PATCH v2] x86/kaslr: Recognize all ZONE_DEVICE users as physaddr
 consumers

Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
is too narrow. The effect being mitigated in that commit is caused by
ZONE_DEVICE which PCI_P2PDMA has a dependency. ZONE_DEVICE, in general,
lets any physical address be added to the direct-map. I.e. not only ACPI
hotplug ranges, CXL Memory Windows, or EFI Specific Purpose Memory, but
also any PCI MMIO range for the DEVICE_PRIVATE and PCI_P2PDMA cases. Update
the mitigation, limit KASLR entropy, to apply in all ZONE_DEVICE=y cases.

Distro kernels typically have PCI_P2PDMA=y, so the practical exposure of
this problem is limited to the PCI_P2PDMA=n case.

A potential path to recover entropy would be to walk ACPI and determine the
limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
smaller systems that could yield some KASLR address bits. This needs
additional investigation to determine if some limited ACPI table scanning
can happen this early without an open coded solution like
arch/x86/boot/compressed/acpi.c needs to deploy.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Tested-by: Yasunori Goto <y-goto@fujitsu.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 drivers/pci/Kconfig |  6 ------
 mm/Kconfig          | 12 ++++++++----
 arch/x86/mm/kaslr.c | 10 +++++-----
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index f94f5d384362..47e466946bed 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -207,12 +207,6 @@ config PCI_P2PDMA
 	  P2P DMA transactions must be between devices behind the same root
 	  port.
 
-	  Enabling this option will reduce the entropy of x86 KASLR memory
-	  regions. For example - on a 46 bit system, the entropy goes down
-	  from 16 bits to 15 bits. The actual reduction in entropy depends
-	  on the physical address bits, on processor features, kernel config
-	  (5 level page table) and physical memory present on the system.
-
 	  If unsure, say N.
 
 config PCI_LABEL
diff --git a/mm/Kconfig b/mm/Kconfig
index 0e26f4fc8717..d17ebcc1a029 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1128,10 +1128,14 @@ config ZONE_DEVICE
 	  Device memory hotplug support allows for establishing pmem,
 	  or other device driver discovered memory regions, in the
 	  memmap. This allows pfn_to_page() lookups of otherwise
-	  "device-physical" addresses which is needed for using a DAX
-	  mapping in an O_DIRECT operation, among other things.
-
-	  If FS_DAX is enabled, then say Y.
+	  "device-physical" addresses which is needed for DAX, PCI_P2PDMA, and
+	  DEVICE_PRIVATE features among others.
+
+	  Enabling this option will reduce the entropy of x86 KASLR memory
+	  regions. For example - on a 46 bit system, the entropy goes down
+	  from 16 bits to 15 bits. The actual reduction in entropy depends
+	  on the physical address bits, on processor features, kernel config
+	  (5 level page table) and physical memory present on the system.
 
 #
 # Helpers to mirror range of the CPU page tables of a process into device page
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3c306de52fd4..834641c6049a 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -115,12 +115,12 @@ void __init kernel_randomize_memory(void)
 
 	/*
 	 * Adapt physical memory region size based on available memory,
-	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
-	 * device BAR space assuming the direct map space is large enough
-	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
-	 * to the physical BAR address.
+	 * except when CONFIG_ZONE_DEVICE is enabled. ZONE_DEVICE wants to map
+	 * any physical address into the direct-map. KASLR wants to reliably
+	 * steal some physical address bits. Those design choices are in direct
+	 * conflict.
 	 */
-	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
+	if (!IS_ENABLED(CONFIG_ZONE_DEVICE) && (memory_tb < kaslr_regions[0].size_tb))
 		kaslr_regions[0].size_tb = memory_tb;
 
 	/*
-- 
2.51.1

