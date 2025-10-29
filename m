Return-Path: <linux-pci+bounces-39736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A6CC1DC7E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D0FC4E29B2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 23:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200221D59C;
	Wed, 29 Oct 2025 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Spb/Uors"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F13191AC
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781653; cv=fail; b=HGRECcdLFZQ7/ReK1DbHsKlN717sG9/23JZtBB9WXUjNn+n6O4fsw9yN5xwOtr6BtVGiFaYe/1fWOVNPPJJKBVSV5Z/JyTwOgp/MLvR0SsRjATK4Ix+5yGvONphRImOvv6aaRbxmtWkd5LA6J/mpv2g1wRHX/Gy85AmzNUw6+kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781653; c=relaxed/simple;
	bh=72x4LyhVwP9oaKDEPMjCpJdR2lGxRKU3AZJv/2YxbJg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=LHyKQMr9iGxir3hWwNrZKqEvVwCL5N2zZ0sub+NbgjP73FGk9t0nbjnqoe/vh/9S8DlFEV0DVXKsQpRIzTjQx2mm7HsmzgyAoJWfN+RE5YNL15mlUv8fo7WCWWVHorXwh5Vl+XGu4a4xdjqKM52+2wkRn8s5AzbWye01WTq5984=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Spb/Uors; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761781652; x=1793317652;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=72x4LyhVwP9oaKDEPMjCpJdR2lGxRKU3AZJv/2YxbJg=;
  b=Spb/Uors1wfyhNKwL9Vc6yyVdxBT9jx8ef2YG/xYk0Z2aKyhFhZH61Kn
   exT20GBsOA4Vh+RZu6d80Pb6nNvAx9jUjVnDzCeEV47okA48PsAeGtHyJ
   B6l0X+uQRHP6T3PAGh+376xqrhRTRWQBx+AtnLsX1g3egAb4oDdSsXGPw
   YNC1f0XIjvJSJ8UR8ABepPs356GVQ6kxxaS6O5ztrIBW0+GpOXBOHcm9J
   S91dsqqOBbQ2B2j5IIwXAVS5Nso3FfZFs7yeFJC4KoLwzJsphkgzKGsf4
   nnR566E+hJ3SptmlmDlhLAlKH2u03LUlQB6bjnUA1BxH53fAQ+UiBpnU9
   Q==;
X-CSE-ConnectionGUID: kkrcyRyfTiyERlOIfmPqMA==
X-CSE-MsgGUID: EwkUjyG8TACog7ETSE0pGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63615623"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63615623"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:47:32 -0700
X-CSE-ConnectionGUID: 9alhlE9wQ0ysm7usUsJZ0Q==
X-CSE-MsgGUID: vhz/ZfdRSOOhMkcTA0pwZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="190122848"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:47:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 16:47:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 16:47:30 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 16:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs/4nvwLEWCZahyAcfUMLt37RLx9b46TDCfbqnyZh3bWvk38GbammY8fqcmVQYUTnn9aTjgRzPSeR6JkRI2p1uFe/oQFiNMTJaR5zPm1YQZrRVDOtuCRnDwG5e/SiFJhRcnnrW440aS4gNiT+/dIB/0kQcvkxgsDH4FFXniuMBglMQ3o/fNaJLHGyN/EfaxjWhtFMryG3kOVDFlze1lrZptyOG0w620lAOM1HdgGlpcttch/VB3q7xQ7w5y1ARwcvkEwUEIIsA7m8hlsmv1z203LOv6gIJn3Y0NnH421TpnJ9m1o1ShgTTipkvaNJAWKelVa0jwgDZjJv3TiXAsR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFjmNHoV+xuYvNP2qGJhKcTueyIjAFZnUtkdcT4kXQY=;
 b=NLPH2DgBExvjwd+wxcnWLCgxKZno+CsxQgAt9Q/pjGfUnW0C/75vtvsMIi6kkMJWXb6pkJSY4f0FPUF3IwZ2TU6qqTdz4hhB2YV4v43MYlRJ8AiZO9z2FtEys7gABANouqvsbK322f4BkRJBQ48E18zSTZsOgv/ykJkBP/3PzumZapo+6kOQnJzwGfY9wO2cMZMZ4hEJgulfevyZ734NjqiDfWQPuqwOh1e+og+2J9C1IxgXF2zeb759GIzzyYBR+2a9BSER2Okrfz0fjrFw1Zo+fEDjbYOqFVooi+a5NQgXMKO9lxCq6DHV3YlKGea7Yif0ES2YK9zIvrs22I7fyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 23:47:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 23:47:25 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 29 Oct 2025 16:47:23 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Message-ID: <6902a78b74cd0_10e9100d4@dwillia2-mobl4.notmuch>
In-Reply-To: <20251029133349.000057cf@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-2-dan.j.williams@intel.com>
 <20251029133349.000057cf@huawei.com>
Subject: Re: [PATCH v7 1/9] coco/tsm: Introduce a core device for TEE Security
 Managers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: fa780141-ef46-495f-9fa5-08de174582d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDh5dkJtQktHNUFERE5mQnVDczF2aTQwSVMrRDlpSmRsclNtMkhKVkNsWWtZ?=
 =?utf-8?B?dWwwaU01L3JuWUdrMVNaK1M4SmdoWC9pbWM4THU0WEs2WlBNYi8wczZJMFo4?=
 =?utf-8?B?OWIxbnpTajY5NTd3eDh6YjR2aE90bnFnQ3FXNVNpOGpTRjJhY0FKTVNzb2pP?=
 =?utf-8?B?cERseFVKNDdCMXJtbWk0NzlRUjcxb3c3a1R0TFRtOTF0b3FJWUJQT01WU1Uw?=
 =?utf-8?B?eElxdW0zMi9Dazc3WjcyVTYxalA2UTZ0NzVtNUJYNmNoOVFXSnIrUnAxOHNN?=
 =?utf-8?B?Sk03UnVnWDJFSkFSbmJRQ3g5bHVTZklDcGU3UUQ5eVZZcWEvWFF5alJlVE5P?=
 =?utf-8?B?ZjI0UndrcDRnOWZjWkpJRUFrU0V5dTNTQWJCejdnalVxTFlPL2Z1VU5XZnJO?=
 =?utf-8?B?TnpUbjZBVXN1TEcwQzA2WDVNclpqMkFZK0NzdUVZV3lvY3BmVUJKOFlPUHgz?=
 =?utf-8?B?d3pTWkxyTGVFakFuZkFQRlN4cVBkTWIzMUJlVE1VaytUY2M0b0lFTWg2enVL?=
 =?utf-8?B?QTdabEFHT29sNVhGOFlxU0Z3QjcwTVB4Tk5XSnlMNkNNb2NlZjE0bHFyWVQy?=
 =?utf-8?B?VkwwaXB2QStLRmVrL1lYSzc4RWViZ0N3dWZBTy9zZno0T1FRaWJtdGtaS1Rj?=
 =?utf-8?B?QXg1NklTc0w1Y0dtYzd3MHMzT3JLK2hTc0NNT1pYbVRyTEFPa2xsa1h2YkNO?=
 =?utf-8?B?YjZ1UGdhVkw5YllDSEFoTDBXTUVIT1cwYVNOaGluZkFqcVArd1pKOVZTUHpI?=
 =?utf-8?B?cmNLb2NRS0FaWGIyMEl5OEpieFNoUXRCbkEzTGd1cmxmYURBY0xPVTZCUUUw?=
 =?utf-8?B?MG5yWTdrYkRrMmRTUkZkMzRKTzA4UnhOUmFuSWNmRzAvMVdzRkpEeW9oVFRO?=
 =?utf-8?B?S3FubUF1THhPdkhVT2pQYVF2QTlwQmZuYmhueXgxYURFYlhwMVF0aks5MHlD?=
 =?utf-8?B?VUN2ejZkQkdMZlFJZXNwMWlOTFBxQnNDWVNBQ2JmY0xHSXpubkFHWTgwZnlk?=
 =?utf-8?B?VUpuQ2JVMlRaYUQvdkR1aDJUbW5HVURNeVhmRlk5YXFhbGVWVTdFakNIN25V?=
 =?utf-8?B?RDFvUzhraDk1aHV6R3N4T2VsOVgwUzc2SllrT0svTHE2b2Q1QVlrMGhxSEtZ?=
 =?utf-8?B?QWR3R2ltTk9VTzQ0YkY4SmgvK2hvNTdZcVdNWHhjRnU1Z2drQUY4UEx4eGFl?=
 =?utf-8?B?cE9iNS9pOWE4ekJyYkUyYWVsbm01MThHaFNXYWF6TnU1ZVFlYnRYUWlaVFpP?=
 =?utf-8?B?cTFIUDFyUkU1cWkyNGN5MVErQXovbVJGL3JMNVhPUmlZd2FhRDJRTkxQN2JI?=
 =?utf-8?B?eUlJc1JXTGRYTi9LV2lveVZpVnBudnRKQTBTWlpTcEVHaVE3Rng2UzZDRG13?=
 =?utf-8?B?S2JVOXI4VG50b2liRWNmWTh4M0l3UWVTZnpaUW9MTnUvS1ZGMzRqR1g4QmtU?=
 =?utf-8?B?VjlCak81YVFyY3lnZGFLY0NoWkdZZHRqY21zd3Q5NWF3ZEtRQVNGUFdmc3JU?=
 =?utf-8?B?Zk1sSXhkRVRSQStFNnMrK0dJTXpidW52bE01Y21nelNNTFVObzZmaG55VE1Z?=
 =?utf-8?B?YkVMRGRIU29MYXlMamg5VU9kMWJ0MjNEL0hZWWFsQU56RENXWi9UR28rT2VZ?=
 =?utf-8?B?L1N0eW1sektkYWZpL3ZXVlpaMTYvSTR2OWV1R1VxVjc5U2R6bHYvbUFRUWhG?=
 =?utf-8?B?SVdEc2h2V0pnT3JaSVRERXlYNEVFY2txajVHYmd1L1RESEM0cnZuSDFBQTcw?=
 =?utf-8?B?elFTUTl6RXduM2w3V0tCbUMraVk3U1BlRHVFNmJ4Mmk3Qks2V0JubkpHMUZB?=
 =?utf-8?B?RTRiSFNrYy9QQ1crL2hoOWU3c1p6cE1QVC9Xa3gyNUFqL0VOZzVscmYvUU90?=
 =?utf-8?B?M3VpQ1NjakZsRDF4YW1ZdGZhZk5ldDMrbWdUZDlGYzloNk1uUHB4emxRNTdQ?=
 =?utf-8?Q?w+OFTfi9tuC0AaQWwyJaue1xSzamW69+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnQzYTRUVlFmS2JTTmtWSjJDNVhvcyswN3RwOVBlcE9mMjVDM0RkRm9IeUl1?=
 =?utf-8?B?VUZ2QVZYSm83ZCtPU1VTNFo3bVVucFJocVBPYTEvNHJqSXY2OUFRR0V3ckZF?=
 =?utf-8?B?U04xMWVoanB1cDhZYndUOVJnTHhrV3RzSjhURjBTeERGQXdnRFVCbnFUamdC?=
 =?utf-8?B?RlRmSTd6YUFHZ3AzMTZvZ21aR1FRNjZCallOS2F6QjhxMTQvWDkxNk9qYjMy?=
 =?utf-8?B?enZxTDdGdldKMDlOWEFxM2NxQnIvbFd3YVVGdTNQNCt6dWFlZmRFUTluNGtw?=
 =?utf-8?B?Nk04RVBrMFQyMXhETitRdVNaWmZDK0dLZUYzWEIra3hkKzBpdm91OFkwODJh?=
 =?utf-8?B?RzdRa1FJaGJiZm5QUUZoY3RBTjZWUHlIU2gxVmFSVVQxU3dUR2gzRVR6UVR5?=
 =?utf-8?B?YkZuKzZFbFMzaE4zUkJMeWR4RHM2TWRjR251cTk4YllyTndmam0raXM3K1cr?=
 =?utf-8?B?VVZ4ekxVYm52b0pYRlFFNVpibDZCTWpLMDFuN29uOWV3dkY2OWt6NS9CZEVE?=
 =?utf-8?B?V0xqR1JZL3lhK0diSTQ0MDZ3cjRPczFEOVIwMjFFb1ZEbWNXZ3p5V29nNDRR?=
 =?utf-8?B?eHJxOVpvalZhZDI1YVNXN1ZjaVdQb0ZLRjF4NjdPQmg4T04wQ3lLSnpIU25U?=
 =?utf-8?B?a1FiRFR0QjlaZkR4cEQ4YmxzWW9WcjE1czgzb3RCMTYxa1N0Zi9nWXBYWTZ2?=
 =?utf-8?B?VHlVOW9oR3hDUDBvY1l1VUdPMTBUL0M5WnpoaWZSWGYrdjUwK2tRWlNNR0ds?=
 =?utf-8?B?V0RMZnRIUDFubkJrUHB3UTdFbWNzUG1wNFJPUzY2UlNwYzdNUGVCcFd2YzhM?=
 =?utf-8?B?Z1Q5R0t5bklQeWovbXpmbTBtZW1vOFJOYUtmUkZKNEhDbm83M3BEb3FVVFQy?=
 =?utf-8?B?RkhGT3NMVUpGS1BHcjlBSDFzRUJTaEtMaFhwTlZJTndBeVBaakh0eGJLeSth?=
 =?utf-8?B?VGg0cW9ieE1RNWtEVmp6Y2xob0lmZFpKU0tacldXallEVWc4NFdESFYybGpk?=
 =?utf-8?B?RlZncHVNSkY2TGF5UFQ5OTY4T1A3Z09EVHBxeHNzVHhPZ0ZsTWxCakx2QlR2?=
 =?utf-8?B?NGloMzR4Z0NiaVdlRGJjdktOa3c0VFZrdDJKYjREem40TTdQL1JESXFlOXVu?=
 =?utf-8?B?akdHd0RERXcxakpkYzZOTnp5NC92eTJiUWpKcDJPRHRwclppQlh2anF1dDU5?=
 =?utf-8?B?ODBFZzNMOHJ1L3NacTlkSXNVTTJtMjhpMzM3NzhXUFBtMkd5SmtlNDZFVGY0?=
 =?utf-8?B?UDBFaG14c2xJdWYrdUZqTk9sdjZRVzdjendURnBUYmVCMnN4RFB1NzZTY2hE?=
 =?utf-8?B?UDkzWHgwMFVjeXR6dndtRnlqbWNVYlBoOWVac20zWHJBZFlPL0pwY0c2a3Nv?=
 =?utf-8?B?QXRIMDB1eGlid1hNaE5HS2gwQ0VHNDhxQmswZmJhRjM5MU5rTEVHNHVicWhE?=
 =?utf-8?B?eGR2WDlweFMzb0UyMzYzY2RPZy9ERXlydEJ4Y0ovTXVSVVdmZjBUQU9IUVI4?=
 =?utf-8?B?c0Q0Rm5kakVZQ1FndlV5UUJHdlVhVmphd0E1WVB5Z0tWQkFkeXhVQ3FiSU9M?=
 =?utf-8?B?OTVQb0hiU25DMEFhL3lTUnpqVW4rY1VkSjhuSTRtVDMraXFLb0JGOTlHYzgr?=
 =?utf-8?B?K1JIOHpjRGVHbVZaY09YT3I2K1B4M1llOEE2bzdEalY2OFJkd01iTld5MTVD?=
 =?utf-8?B?TjZUcFREZXA2dkV0ZDJDbHc3VGRTYTcxbHJ1VlE3VUlsaGFSUU1GZWp5K3hp?=
 =?utf-8?B?ZEhGcnNvWkcwRUtBbGtoODFQbU9qd1VuOHVvcldyaktmU2FJSHplb2VOdHQ1?=
 =?utf-8?B?NHk3VlBMWExURGxGeDNPSW5tR0RmN1g5OHNDRVoxUlFObVdXTGFIY3pZNlZs?=
 =?utf-8?B?TWZnZ1I0OHhtN1docnRkNndVMUhvakVIV1l0UU16YTNKUVVRTGxXNnUrLzg1?=
 =?utf-8?B?UzN5dVdXUXJ1djZtWGZzNkNRNVdrUldkS2tFMVFleGxteFplVm5UcFlmTGIz?=
 =?utf-8?B?UFpkRU5FWUdSZnFrNXJmbjJ0MElqa253d2ZLWFIrY0sxZlllQ1pwbXpqcU1i?=
 =?utf-8?B?RjU2N2VsUm05MndzL3J2aURtbDllWHVrbnh0aFJDZ24zY1Z4MHZwMDV6a1oy?=
 =?utf-8?B?SEE1UEpvcWpZaURzTk1UMzdpcndha0R5T0M3b3V6di9GSlIyZU1zQlNjRjhP?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa780141-ef46-495f-9fa5-08de174582d1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 23:47:25.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2Vu0oq8pepJD8fNwyMZ5MFFiyGPo0lg3BiLWXRSDUZRYeA2HwkyfbvaC01buyoURkRpxxKVOHLH6qghLCQqgjS4WKKbm16+/Fm/YSKOdeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 19:04:10 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > A "TSM" is a platform component that provides an API for securely
> > provisioning resources for a confidential guest (TVM) to consume. The
> > name originates from the PCI specification for platform agent that
> > carries out operations for PCIe TDISP (TEE Device Interface Security
> > Protocol).
> > 
> > Instances of this core device are parented by a device representing the
> > platform security function like CONFIG_CRYPTO_DEV_CCP or
> > CONFIG_INTEL_TDX_HOST.
> > 
> > This device interface is a frontend to the aspects of a TSM and TEE I/O
> > that are cross-architecture common. This includes mechanisms like
> > enumerating available platform TEE I/O capabilities and provisioning
> > connections between the platform TSM and device DSMs (Device Security
> > Manager (TDISP)).
> > 
> > For now this is just the scaffolding for registering a TSM device sysfs
> > interface.
> > 
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Dan,
> 
> My usual problem of having forgotten all the details since I last
> looked applies, so I'll take another look at the lot.
> 
> One trivial comment below.

Too late, you already added a review tag. </joking>

> > diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> > new file mode 100644
> > index 000000000000..a64b776642cf
> > --- /dev/null
> > +++ b/drivers/virt/coco/tsm-core.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> Maybe worth updating as in general this has evolved a bit this year
> I think.

Sure.

> > +
> > +static void put_tsm_dev(struct tsm_dev *tsm_dev)
> > +{
> > +	if (!IS_ERR_OR_NULL(tsm_dev))
> > +		put_device(&tsm_dev->dev);
> > +}
> > +
> > +DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
> > +	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
> 
> I'm entirely on board with the normal argument behind the !IS_ERR_OR_NULL()
> check and the fact it lets the compiler remove an indirect call in some
> cases.  However, here you have the protection here and in put_tsm_dev()
> that is only called via this path.  That seems excessive.

I think if there were open coded callers of put_tsm_dev() I would keep
the excessive form, but since this only for __free() no need for the
explicit helper.

range-diff result:

 1:  c2ad31ce3803 !  1:  448addc31b86 coco/tsm: Introduce a core device for TEE Security Managers
    @@ include/linux/tsm.h: struct tsm_report_ops {
      ## drivers/virt/coco/tsm-core.c (new) ##
     @@
     +// SPDX-License-Identifier: GPL-2.0-only
    -+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
    ++/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
     +
     +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
     +
    @@ drivers/virt/coco/tsm-core.c (new)
     +  return no_free_ptr(tsm_dev);
     +}
     +
    -+static void put_tsm_dev(struct tsm_dev *tsm_dev)
    -+{
    -+  if (!IS_ERR_OR_NULL(tsm_dev))
    -+          put_device(&tsm_dev->dev);
    -+}
    -+
     +DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
    -+      if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
    ++      if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
     +
     +struct tsm_dev *tsm_register(struct device *parent)
     +{

