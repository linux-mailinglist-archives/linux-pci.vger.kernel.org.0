Return-Path: <linux-pci+bounces-40786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE3C497F7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894F33AF753
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D42D949F;
	Mon, 10 Nov 2025 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWXrlj/B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165C23E34C
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813183; cv=fail; b=GBQK8VAmkG+0Ptvq8/d2A6sblkH37EyH96TIIp8zUaQYcTztLabv1lmhVYL5PLuWoqvEakaJyri4V9ufX8+XvPpaen152yU2y/5oGNiLo5oJ/imFEMovKhdD0O0edo+GK6PIW3OoY+sGjXRDpsCD5D+VQLbYjEWhyO8JECUJI4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813183; c=relaxed/simple;
	bh=THg3Oaka9Rpw6qGYDA+RYL2n7q8T3y9ZNQVvGJ9SNko=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fLislgZoxn1c//jvkD7A7pTu3EZw5s6bhmULnqufGH5ZBRGMBDeMslnvAsK0SEgCCroMovYsQw/8hj5IK8W7Q5+/7WoGF4JqSOfGB5If7p43J8ndPrlBEiscPJ12tzmjqcG3/pE/Bqm+VZWBxJ5b4vseBxoYjazm2n/jmFU1KJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWXrlj/B; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762813181; x=1794349181;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=THg3Oaka9Rpw6qGYDA+RYL2n7q8T3y9ZNQVvGJ9SNko=;
  b=FWXrlj/BoXsLEdScXjFmbDlFPGuAkOifDmRn8OSORp7eQ0hewCHJPdVF
   T0HZHSEus73k7wMde5Uokv4aFALLXQ+q/quIdUMh+7f51qVJ6aMHQG+KV
   C8m0WRV5ZSGwTLCR28xykN2dD8+tatEDmN98ghbeAD8h1mdZwd1vpehSN
   GG5VO6PdSMu7f+XXXegjjxcp++JYiDXkzyFutegGJkh8iMKxHfnEQ3X8n
   BqwQWpDO/bepHgivUXX0uCxFBvoD6NGQInObzBEeUFCKcpJEp8UyRul1q
   NnAtQLu8MeQsm6OV/xfI0noUpdQEFILC6Ss2ueTLiwCM24pZ77GIxv3jO
   Q==;
X-CSE-ConnectionGUID: XhzRfbz1SpCj2Wvr53Q0EA==
X-CSE-MsgGUID: uiOVYNu+T2mYNyGsMIAhRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68728397"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="68728397"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:19:41 -0800
X-CSE-ConnectionGUID: Pccc4+bGQSuC3hM1yDcR9w==
X-CSE-MsgGUID: mnT53z0pRS2ReeR/xAs9Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="189029695"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:19:41 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:19:40 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 14:19:40 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:19:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9T8VQCb4/7tqjKGx3OeMLJxRgcbQfBil6T2o337flIzOgcB40ytadvosiCkrb5R/U55MFELqn4HUXFBy6sf7zebrYwl5Z4GNwNPOw96Azx7J5DcUdfsm/QCvPvgYCfppGid+UUUOixjj2SKdqKvrU5dt5BE7wKykUy5HrGmk+Qgc61Oa5NXba7bEfOrYkGnm9emr+45Ov2BXybNsQkWJOkB9qwLmOLAOUbtnjpBM+8G3A9kqctidvt72HhJ7gRl4xaLx7gaGj2m7rohyI8VcSsRc5Ad70N8a0rWAEIjTrV35f4fMj6isvNeP/3LYidJJbV8P1za6h4fPJHW00i9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDBmQw8YjmNKbT2c8+7cDSV71fQXKzgPoXeO8JVZ4DM=;
 b=J/DjrLdKjTFJbeFfmXmlMggQ2GRe6ESHInydxyAk9Ww1a9Q4hi4Jew6NZ0Yw8Cn+5qVMosTEmCbBMjaxsUABwznK7prayyib1YqorYzgliirwWNagZBbLhf7/5nfB4VZfK6DDSa1qLet8CcI0mPmarbfpA1MypK0kAFSaAICZ2ZhUBgjq1Lp75ZWO0OHi5D/5KaCRWlvPwRv2iilaaSmdmM03zU4yPpMH1YCm2usuGqdXiaMNBTjPxFXge+o4oAxbP2wqIDQ9f82sWsmG1TxyakVpVe4hxboTd8W4wko8OHuqhywZia9o5umHvf63tr1+SHFbAFFWmBiVhZG/aB4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:19:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 22:19:38 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 10 Nov 2025 15:19:36 -0800
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	"Lukas Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>
Message-ID: <691273081685_1d9110038@dwillia2-mobl4.notmuch>
In-Reply-To: <aRFfk14DJWEVhC/R@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-5-dan.j.williams@intel.com>
 <aRFfk14DJWEVhC/R@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v8 4/9] PCI/TSM: Establish Secure Sessions and Link
 Encryption
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 762d3acd-6ab3-4446-e5a2-08de20a73ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVgvVEZLeFBEVks4V01wbGltTGF6YkNFQnJWbzlqcHJFZ0RUbFNFZkdVYmlY?=
 =?utf-8?B?T21udFNUSHMvaFlyaWI5ME1YWHcyUmRVVjBqMXpFTFlMNFErKzBYd1VkZG1L?=
 =?utf-8?B?a29pYzRGV3gxZTdIVGN3L0NycHZqZFlPanVSeHFRRGowR1pyaDBobHJMd0p6?=
 =?utf-8?B?eXRSUE1mTmFEVk9iVkFWdkZHOXliUUNsZmd6cHdtL1pQMml0aG52cDRjMEJM?=
 =?utf-8?B?WEJwYWVVTFJ6VW85bGFqWDRtM21LSjJmRGc5Uk1teTV6aDBKOElpY0RBUUY1?=
 =?utf-8?B?UVpYeFNpUC9CLzhYSHkwL0Y4c20rYnArOVYzdm80SFRNZmxaNXNEN05hN3JI?=
 =?utf-8?B?LzBWbWh1OG04VVJOVmlpVnFSUm9BUmhpcjZsY1NPQkZseGxDSjlCQzJMZE9K?=
 =?utf-8?B?WmRnWVc4ckxxUFVKR2lnLzVDT3dDTkRpSUtYeUd6dGRabmhzMitxaDNiS0cy?=
 =?utf-8?B?NEpZVmdWajJDTks1aHFzN1lTcm9HVy90czdtSUNvcW16ZDBtbStRTEhFNFNU?=
 =?utf-8?B?dzk3UkljeXY5ZnpOdTAwbUZjLzY5My8ralhyUWYxNWxVMWtOR0pLQU1ENVZh?=
 =?utf-8?B?K0lTQVRhQ010amd0VjROZ2dqUTRqYzZFUWlIYlVxM05paDdma2ZoQkoxb1dG?=
 =?utf-8?B?RUNRZ1hnbUtJcXluSERrTE1YWWNjTStLUkNLL3l1cTN6cnNKcnUzWEZienNS?=
 =?utf-8?B?Z3VjQVJhWnpUNTNoK3Z2TWE3a2RRS2JqZlRIeFFlZXVud2Zsc1grUm9QSmRz?=
 =?utf-8?B?OXdjWlJJRmF4OEpTNXpBU1dScDU2bUV6NHJucXRDcjVJZUpTNUFUc0F1TFdS?=
 =?utf-8?B?S1NXMS9wcng4ZzM5MnhjY2V1TTFQK21hZ2I0STFEQVk3RzlRa1JVdWpKM1dI?=
 =?utf-8?B?RmF5czNSTjF0ckZ1TlU0MEM5emVlN3MyNzlKNitDeE1XdmlnRVNtRGFUa3Bh?=
 =?utf-8?B?L3JocU9rbVlaQmM3aXowaHZZUHRldjBHSUc4SndQWXNlUkxmUlozaXV4RDM1?=
 =?utf-8?B?U0k3dHdYSmtRZ0Zhd0N4RHFBd2NneVZ5VW1zMVpkb01PUjhXVWw3OW5OQnBH?=
 =?utf-8?B?MlllQWhHc0dCNkY3QnJYRm81emlWbXZ5MzNHVUpWdncxS1IwQVJjWEQ1ZS8r?=
 =?utf-8?B?WjVwb3FsMXR4RGU4MEZCSzI1dm56WHR1Rk9teUx3aUNXOFBjaDZEM2VvTU05?=
 =?utf-8?B?MkhVNjFoeDRZRFRCWlEyM1BTU3JseEtYUzBqSXBxT25hc1htYThnYmJRaXg1?=
 =?utf-8?B?WEJkU3dLb1NKTUpqT0JKbmdraUFGOU84aGczZUFLRlgzTXM2RTVxUzE3emxE?=
 =?utf-8?B?U1Jmajk2b2pSQVErK1pGTXNvNHJxRWtCVHk0ZVkxMDdtQjZucnMrYTY5YVNN?=
 =?utf-8?B?RmovNzRKejZOcm9DeUdtb0Z4MlFSM3lBVEVEb1N0VUQvdXNZd1kzc2VtZ3lr?=
 =?utf-8?B?Y1c3RGt2VnowR2svM0pYc3h5bTZPdkxsUHZNdDIwQ1lPTzhPN3VCOUplaXc0?=
 =?utf-8?B?cDM1WllYTlNlM29rRkZxdGhSUHYzbWpkNWtxZUNzYUN0eW5nTGF4QVNkS2xS?=
 =?utf-8?B?MU9ianFNVjlsN2h4dGVtK3VSUk01UGNpQ1hNQzAxRkVhUG53TnpFTnRuTHVq?=
 =?utf-8?B?dGY4dnFyRCtmbVZBcHdVTXNLek8zNzBBOVZldWtCcHllL2lPaUZvZDIzYTFC?=
 =?utf-8?B?QzVUTlY0UTlJWkFlTUJNbkRMaktuV2g2K2ZURkxLbW5jVUN5NWxtMHNxc2Q2?=
 =?utf-8?B?R0JVeHpxa2l1UFhpTnBPNFhyVXJvSjBPOHZERnpOdW5Ua0UxWHFYc1YwNlhP?=
 =?utf-8?B?ZzZsN1VFemNKcWh6K1dkcHVlQ1NpdVpLb0ppaklXUU80NXVWSVNTUVNWY2Fz?=
 =?utf-8?B?K2FLRXlPRmhSQ1l6enp3NXRIcXV3SUdtWEE0YmdDL25EVTZ2T1JpYStNWTNL?=
 =?utf-8?Q?fu+sfhvbQ+p9zdXV5SuSRmm2+OjBPrj8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qml1L2E2Q2ZnY0lUWWhqb1gvR25iVzFaMVd6cU0yZzgxRWtIdDdzMzVqWWRv?=
 =?utf-8?B?K0M2cCtPaC9RL2pFSjJ6VzFVSlRIK201K3JwN1pOYkVUWFBjWjcxem8yWjJZ?=
 =?utf-8?B?SlVlQ2p0WGFlQ0tPWjJVVWR3ZUNGaTFDNHVoeVE5My9aRW5SQkNFWlJNdzhO?=
 =?utf-8?B?Nk0wTE8rcXRWNkVhMWVPOHRtNDl4WHhDSWxZV2RQTUIxQTB5NjVPczBmN3JS?=
 =?utf-8?B?dkJ0RmRva2V5VUN5MkVNRVUrUzl3UC9McHdEZWE3WHN2R0lNdFdJUE1TMHU1?=
 =?utf-8?B?L0VMbDdNSDZzdUQwdlN2dTc1TVNHSUlzWitaeVVzWStFc3JFSlZaSVJqd3dh?=
 =?utf-8?B?NllqbXhDMXJGNDdTUXIzU3UyRjNZUWUzc0xRVTFPRkdRbXRBcFd1TmJyMVY3?=
 =?utf-8?B?bzhYdmQyQ2NLOWZxN1B1bmRPVk5HNnB5akJjaTRZMjdhcEkzR2d0ZEVTTENJ?=
 =?utf-8?B?T0xFQjJxNkxFd3R2OEVnT29DT1RqZmFuQ0wrUE84Y29UeVp4amlGMFJWUmdH?=
 =?utf-8?B?WWxCR3czQ1NWSUtSaDBqNCtXT2pBU2NhK1FlVmtTSERFVEJWWnFEQy85VXc5?=
 =?utf-8?B?TFNIcGo1KzIwQjJveUY5TC9Sc01VcjM2Z1VweUxDWWRGSWdVTzRJMDl4K0RU?=
 =?utf-8?B?ZmVsYWtnYVpGSDhOWTMxY0V5Z1dOTlVkUnFXcTJYaTMxWkhxOGd6Y3A2Z3ZT?=
 =?utf-8?B?MU1IM2R0UlRwVG5Hd3dHdzF3a3M4bDQ4cnVWVXpLZkNGTDFtNlhJWUhJUzUz?=
 =?utf-8?B?aWgvV3FCWW9nd25tUHlBYm9qWksvNVdaRFM5dFlGWkRobWJwTWlkc3NiNE1N?=
 =?utf-8?B?eGZHTkhaOFVtbC9ORHlTSE04a2VkQnVzTnFXUjVYTnFST3R2SUFYamN4NHYz?=
 =?utf-8?B?cFNmL3dxcVBKZFl6YVhhZXZqZTB3RWVzRHhuS1cxOUdwbDBoejBVcDd0cERW?=
 =?utf-8?B?TnJXQitOZWJXMUNETE1VZnMvVjFTRU5SYTJuY2RDNUlYLzFGYkRLM2R6ZlJr?=
 =?utf-8?B?cnNKVkhhSWlBOXBNQndVd2pFdk9TMXJGY0phV0VWM2ROSENkUGMwKzhzOWNl?=
 =?utf-8?B?c2xvRG96RkVFSGpjaGtSVGlib2ZyWVFlMm9oR3MyMEhscG9tVWsvMmVEVi9R?=
 =?utf-8?B?SUlmNHROTUJ3bzJRcEs2ZzFTcXFCL2dZZy9VdXZlVm9IMnhhellFVUMrdWZo?=
 =?utf-8?B?R0ZaVVM2WXc4UDVMNnVjR1JTTXRCYkUvLzRnQkhld1BRSU1ndmZGQlBUNEZt?=
 =?utf-8?B?bzY1V25EMDJQQ3pobTYyZFJFUWd3K3kvQVFNWEpCWDBnQXhuNDZ3YnZCV2lw?=
 =?utf-8?B?Tk52NDdhbCtscm9IeDlKMHFvdUphMW1jQ3lmVnRseTA4YWxJNGREdUVsY2Fm?=
 =?utf-8?B?Sk1ub1hJNkJKeXlBODRnWUpkRzVaS25mTmVWblgyNVdlWnhTOWE3OFg4VEhu?=
 =?utf-8?B?QU1JbTBSTXVsTjVtclpjcUJsUFM5MlpGOVhmY0VnN1dIVHVrQ3FxTE1ybGtB?=
 =?utf-8?B?OXFsUHM0bnpXc0tOUnNZTEdmUkpOQStxZ0NHaUhUd3NZZXp6dS81Y2JNTC9s?=
 =?utf-8?B?UTgvSGlJZGFvVzBzL0FndUFIbURjdlJKdEkvbnA3NUhydlBrT0VBS29TL1Z2?=
 =?utf-8?B?SWJ5MlFCTy9Fa1JvNHpTTTNlNFJtcitaY0tDVEFSWUFpUFBmZks3cHBhWlpr?=
 =?utf-8?B?SmNENUtQODIwZlBYZGQyaTdsYldWRzdCYVdSMmsxUHhHK3pPbmRTZ1lJNUxk?=
 =?utf-8?B?cWIrMUJGK3RhbzF6TWY2Z2dGamNBNGVacC9RWCt3SXZXMXM5TzJFYVVFSEpy?=
 =?utf-8?B?U3NWU3FBMnJsWWdtcFROWVRlT3pLRXNNSUtnK1pINHU5Y3RIdmo5SFpVcFFz?=
 =?utf-8?B?YjNIdTdKQ3VxSTl3dFJKWW9ZQ3EwZ3ZIQnRadTNOL2FSL3p4cFJQR3JkTEZh?=
 =?utf-8?B?MHlkRXYyTzRkUVBsMFB4MjY2NnlpSVFMMUwxNkYrRzdpQW9mVklRdGJUaEhm?=
 =?utf-8?B?aDFaanpKNGVhU2F1dms4NUp2YllzZENKMEJNdXhDUmx3QlBHTHZvQXBwYldp?=
 =?utf-8?B?RlR3UXBMYjRWWEFqWUY5QjVhMmh6eVJMNlcxZ05QdnVpRm5qYkEvWDFrK0l6?=
 =?utf-8?B?aVZyTENBTkdkNCtuUk05bENYcERjVGtqSHNVOEVVQzUxc3NmSzRCd2NYSHdq?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 762d3acd-6ab3-4446-e5a2-08de20a73ca6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:19:38.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jilnRkwIPuv4Mwu8dVn+sl1lMaWf8s7DgsXZtB9rBUMCCFnctHE4lzmHTjmTqLQpiZcaZ8H+y99ui4EHjieW0zmsrG6r9xskbxD1O76nnx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > +#ifdef CONFIG_PCI_TSM
> > +int pci_tsm_register(struct tsm_dev *tsm_dev);
> > +void pci_tsm_unregister(struct tsm_dev *tsm_dev);
> > +int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> > +			     struct tsm_dev *tsm_dev);
> > +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> > +			    struct tsm_dev *tsm_dev);
> > +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
> > +int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
> > +			 size_t req_sz, void *resp, size_t resp_sz);
> > +#else
> > +static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
> > +{
> > +	return 0;
> > +}
> > +static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> > +{
> > +}
> > +static inline int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type,
> > +				       const void *req, size_t req_sz,
> > +				       void *resp, size_t resp_sz)
> 
> Any concern to keep the stub without PCI_TSM?
> pci_tsm_pf0_constructor/destructor() don't do this.

True. There should be no callers of this when CONFIG_PCI_TSM=n. Will
append a cleanup for this.

> 
> > +{
> > +	return -ENXIO;
> > +}
> > +#endif
> 
> [...]
> 
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..6a2849f77adc
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
> > @@ -0,0 +1,643 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Interface with platform TEE Security Manager (TSM) objects as defined by
> > + * PCIe r7.0 section 11 TEE Device Interface Security Protocol (TDISP)
> > + *
> > + * Copyright(c) 2024-2025 Intel Corporation. All rights reserved.
> > + */
> > +
> > +#define dev_fmt(fmt) "PCI/TSM: " fmt
> > +
> > +#include <linux/bitfield.h>
> 
> No need the bitfield.h
> 
> > +#include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> > +#include <linux/pci-tsm.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/tsm.h>
> > +#include <linux/xarray.h>
> 
> No need the xarray.h
> 
> Anyway, they are all minor and cause no impact, I don't expect a new
> version.

Ah yes, holdovers from early versions, will append your reviewed-by in
the pull request.

> 
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> 



