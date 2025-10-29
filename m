Return-Path: <linux-pci+bounces-39671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25B7C1C174
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536F56E7237
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6B3358C8;
	Wed, 29 Oct 2025 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tab9Ajkb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85533F37D
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753956; cv=fail; b=iJ1DIjNST8COPU622jpk/SCGpmZTLiE8qy8a9AjoAaIALSm8IHIQCZPTJGuSRYDHSspCR0odLmGChZFXarh38iujspArJS9GK9EUuf6G1ilbfO1oouPW2LYYu9+S/Nq+pQ/fI1jXNqdJ0KDzXLlee9LhoYMO1lQLzpTDbfDO+4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753956; c=relaxed/simple;
	bh=2Vk8laQGEuPYvjq2PdOlXSBA/3rV8/h7PSkw3v6IuOY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=XU32TBojwv4mlHhHue9BdhHkzzRe8i2brVPwpvb26/ygI68Tidqp2EwWy747DIW88Iv7b4Ybgx+Kbi1vHZqknczugqHk2khFznpyOhdWofXqfGDlsRLpAoftNPeJ5ygKx1x7Xr75RVVMudxKOV4IaAnM/86PZfuIwI/VguExY2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tab9Ajkb; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761753954; x=1793289954;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2Vk8laQGEuPYvjq2PdOlXSBA/3rV8/h7PSkw3v6IuOY=;
  b=Tab9Ajkbmwq0xLBZt9vKeT701hvPRaOXlJMr+gdBhfEnjVj7y6S86oeB
   nEU8pN/dZXmcdHRLGJbxWF0O1bPxYH7IJj5P/gpD3Yn+zUocTtu6s1e8j
   0Vvw9qNrwkTdotYVupF2LE8GRA/RWBJX+jAC1vTXRSaDYiwaCpUvlwXmP
   j5kl/m47jubLXEov9hNXzm6K9wutDutjlkrz4+vneGgSOuwOQUdM2bo4a
   B98II0Uao/SRgckAGbcLaSRmijFD3WcWaEwZeGwZ4GoupljT8hIjBxZ6R
   47AZtWE32nQaDWJDicUFzc05qwpsd+YuuA5/a6eTyx1kYStl8nOeljrDs
   A==;
X-CSE-ConnectionGUID: 4O//6KcwQWWR19j9CM4X9A==
X-CSE-MsgGUID: xTCpGbGiS8mQqJE+7QmbaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="51454555"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="51454555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:05:53 -0700
X-CSE-ConnectionGUID: Ra4G2enVTSCp6ESSQZPlug==
X-CSE-MsgGUID: He2Q5vbTSRq6jz6tJuovVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="186453220"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:05:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 09:05:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 09:05:52 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 09:05:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKSKVYW77V65ys1SyHqTixOhP3hcEvYBYIZWojH4q/JQxg5Au1zWtXCG83YOn7HLaYcjrngCC9x/QGRnZB7QAIKMFtCzdzFOpMc5MRpPhL5UaommUzlDs21b5lubjbEys8GOJmhC7QlDr3CJK0I2qpcivaXjaFcjObqIn3XZnuB185vOQqrZybRSoK91PeuzzCW9rZlkpWqk4t9tDvInX8nOwG1Xq8UW11mRTWBPtFhdN6gwnvpHAumcwTxw8qawmcfDXdzbvzETdDTJkd1PCRvXgYfyUNurAaaI9FJAeW1ZFLke6Ot1b7qSIxn5ZnMKjOF/TMacFMBTjcP8lny9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBJYn1B/BREAStaWcxW+s1u+BwHoiuj4E2zFnBSmlVI=;
 b=OfaGg/yhfMes4/7SlWA/J8+Jw0eVytM53Ake4mMWbPNB4+YLEZil0mLxlvVpZsBfz9l48IvAhcgItKFzJTz+kngcmEQ86bbFO5Ki6B3BeqVVvcqOFnRnShV4qbpl9kLX548TcGsI5GVgRjVuVywKFAHWvWPOaYknnr8VfUmXHteeWt4JhEu6lQyBKpsYPuTIWGu4esrFIMamJVfGBMuN5fILpl11WBsB1/JihNIA3iDf/wvBpuWQfiV88cQKkGGWt1pfH2lcHuHg0otw4qaH5dD+wj46vVKTabFrWt4YWF/e04mQcq/QXFQYIjuZFuMZh2pTnve/Aa0+ySeBpLW5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 29 Oct
 2025 16:05:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 16:05:50 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 29 Oct 2025 09:05:48 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Message-ID: <69023b5cbc9aa_10e9100a5@dwillia2-mobl4.notmuch>
In-Reply-To: <20251029140002.0000596f@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-4-dan.j.williams@intel.com>
 <20251029140002.0000596f@huawei.com>
Subject: Re: [PATCH v7 3/9] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 0882ac4b-c88b-4173-28d5-08de17050795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2dTbVBZOVkzS3hOWTRLWGhKT1ozUm1wdzVSZWY4cnhrblhBeHdjMlFzWVBh?=
 =?utf-8?B?MENhU2sxYXp1Ujk1ZlVVV2VYdGpmRmJYckxlVmZKY3ZZWEJRRDczRWFDL0xa?=
 =?utf-8?B?cnFFc1V5d1kwWGh6LzJNZzYrNllPVGowMytqN1VNbmwrV0MrR0dzM0cxRWJT?=
 =?utf-8?B?U0JRQWd3YzZFNXZvdW5YbWZ2eTNGTXBvaHU4WGtHUHYrU3BmY1B5T29hR0NO?=
 =?utf-8?B?K0RjVE01NnhkMjN3WW5aNjV1Y1pWSnJwZ0FBdFVBUTZ2dm5kME1DQjJFYWRu?=
 =?utf-8?B?UjVwbFhLSHUyOVFLak5pbFlLcDJKMThianJ6Q2JTbFpCNHdPc043MmNqK3Bx?=
 =?utf-8?B?TURmK29VZjIzU05OV0krMVE2Rk01RFZPdnZQMFhOdnBnaXRKVXQxV0dMTHBq?=
 =?utf-8?B?TU5oLzd2WnUwNUl3TVA1cXlzV0YwM1VRVFd5UDdsSVFTSG03eStUOThGcWJG?=
 =?utf-8?B?S041WlNFamFpdzFhOFJoK1ltdGtJM04vaG5pWW14M3pSb1ovcGgxYmtyaVVW?=
 =?utf-8?B?VEY0VzFnVDlJbVowaFgxZTgwVDkvczlES05GdzFPU2p4QWhucFFVS01kbkFK?=
 =?utf-8?B?K1gyc0Nra1lVK2p5RllRYytrTDVRNWFpMmp0cDVLZ3NrK283eVVoVDEySTJp?=
 =?utf-8?B?YUxvY2c4bTQycC9iRTc2SnZ0SjlEeFR0TEFocDF1TDQxd1hJU2x3THRxaTd6?=
 =?utf-8?B?dWUxdVlUaUpHNVVJNDFpODRicUFMajdsSW5BL0U5T3dOQU50aHZ2RUVJb1o2?=
 =?utf-8?B?aXVZQ09MbGxBR0lSWkxmTVdWVEFoWnhVM3ByMDZUU0s1VWhLNjcxTDZiQStN?=
 =?utf-8?B?OERVa2wrRGxJV0ZnVWEwK2RIdGJJUU1oWTNqbmxVZUh0M09zaUJvRzZCczVD?=
 =?utf-8?B?bHJHY2NKVThtMTRKdFh3Y2FaSXdpdC80bWtJOXQwdTN3cCtjaEh1TmtmVmVI?=
 =?utf-8?B?RVA5ZmgyRnc5bWJZbEpGVGlKRkxJMHJUMzgrN3hPUjd2TU9acm53WmE4WkF2?=
 =?utf-8?B?eFozSFJlK2J0VGx2U0RFRXprMDNtOGcrdndUM2VxWnFiSXJxNHhzejNhYlha?=
 =?utf-8?B?N0MrUVpGT1F0ZXhDdnRndlRIdzZuTW8zUXV2WTVXVThYR0dFeU1USDRmeUhJ?=
 =?utf-8?B?RjIyNUQvQUo3SWxDUjZSNm5WdDJEZVhYZ1hRZmQzOXRLWVllMnBRRFR5cXRI?=
 =?utf-8?B?K0JJMEtzNVUxNmNmRzIrNmNTZmM0NlArME9VVjByN1FQUGdWcDlKdTZVRXdU?=
 =?utf-8?B?S1R4cnFwK201ZTZ0dE56VkdicHpWamJkMFFDMkpWVnA0UDljLytYYmRFSXZj?=
 =?utf-8?B?ZjFURlJnL2I2NjE4NmZNTC9zWGNpajU0L3dwOWpMK3B2aW8vMGZsY3JxQ0tG?=
 =?utf-8?B?dzZPYVNaMzU3VThMY1UyT2g1MmNRcVZBUnMyNTZsN0RQKzVrWi9Jd0E4cTFX?=
 =?utf-8?B?bjBEUDgwTXJMQlNQV29nVUt3UkduMHhUYTFhY05ZR2tpTnVreGYzOHp5cTJV?=
 =?utf-8?B?czR2Z1FyaVY2ak5OSDRWbjZmN0dVeUV6S0ovL3QwNXppRnJ0WTdIazNDRlBu?=
 =?utf-8?B?ODY0cC96ejVZSUxEdjFQVk1rQXd2YXQzVW1qSWxtWTlOMlZFVDk0M2g0THZl?=
 =?utf-8?B?eWQ5aTUyMkFwQWF2NmJFaHVyMlNnWDV3L2tGRXhNVVB6a0VvYk0vRXdTNnFn?=
 =?utf-8?B?bXp4UVJ4U3JObVh1OUFhUEgwcDJLZVcvWTl2ZFNrcmZKdEc5NWpveUdBd21H?=
 =?utf-8?B?YmNoSGM4VnpTSjc4dHpKemtpVVZ1TGlZVWY2SjRrbG0wQm9qU3cvYlg1dTg1?=
 =?utf-8?B?Vm9uMkNIYVNDektnVXVud0k0T2hNeG5tRVdMbHk1Q0F5U1ZqWEhsa2VhSmZU?=
 =?utf-8?B?ek9HZS9PN2diUDlyNk92ZENUL3JSQmNLZjgvOG9kd1FTRGVla3Z2NDlrclZ6?=
 =?utf-8?Q?gZSza2M5sKuOJOBQUH6iRAuNySU3encw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clY0emlZL0s3NTcyeUlZTy9BM3BETHJ4Vmw2SHJKVVF4RHArWjdidHlGb2RF?=
 =?utf-8?B?ek1NQjJwZW5wQ05yZlFBOFBUNjdPdE9JdFVIdHJTVXNQZ0Voc0pDeDN6V3cr?=
 =?utf-8?B?RHpjM2VtWityZmtLMU1la2R6N0tFZitHRGlvS1lydU5PVUpyMHhBL3VBbFJ5?=
 =?utf-8?B?K2lTUFdTcEk2UFczSVVGSEJUU1NHQ0dYQmU3RlJ5OVVneDd5dDl1UHNvNTdF?=
 =?utf-8?B?TVRGRlhTOFU5d0lTRmxRd0pwQXJWTk1ZazM1ZmRLVENRRGl2bUFDY3hhY1Ni?=
 =?utf-8?B?VDR2eXdkUHIyNGEvVUtYUFFSRk4ydVpialNHVXcxcWxWTnF6VC9XWmN5ZXg2?=
 =?utf-8?B?eFJ0WTRiOTZDTFZPVjFENFlLWlpua2ZSczNoZUNPeTNVS0o1THhzbmkrdXZM?=
 =?utf-8?B?TjZZSno2YnhpMENlajlzd0pZRGtMV2JtRVpMcnNKZUQvTE1UZFlmdDF4eXgw?=
 =?utf-8?B?RU1JQUlhK3JsYnlNNko4WnFMQ0JDK1BJL1JsS05LbWJQQzFFOTJjcFlVVXRk?=
 =?utf-8?B?cHo4Z3VCZVBpM1E0aHp3RzlaSTV5SzF6Z1hWcmluUTh5RyttMzJ6ZHBTbk5x?=
 =?utf-8?B?SUZvQ1Era1FYVCtRcVNHdkVtZWRSYUFJRER0SjBqdklZUWltR0xKTVRqdlB2?=
 =?utf-8?B?cDNXOVcvTjVxTWJ3bmg1SUN0UGdseWlMQ21aZUZCRUVvenc2MlRSdE5NRE43?=
 =?utf-8?B?NTdvUCtmNHpuWXNxcVJZdEV2MGpmTGdxdkg0bmwyc1lwQUc4bVJLOXBtQ2JG?=
 =?utf-8?B?L2EvYW4xSWNnbmRqNGw1amVPQ1M2QW8vRzFaYzlrdWNsTWlFZmVoSytoN3hi?=
 =?utf-8?B?ckFEVk52Tmc1T1pvWi9HVXBnL0RFZDRBbkRFWDNNRHRKKzQzZWlxNU9aenRi?=
 =?utf-8?B?QmNQNFg3L3dxN3g1MFlpb3dEcUwwR2lFbE9VdytEMzlwY2Q4aFpXN3dnTVNi?=
 =?utf-8?B?dkVZOTdkYXprNW1tL2czOUNIbTlUWWVESG9LSmJ4aXFaa1VQbFErWG95b3VE?=
 =?utf-8?B?TEtZREdsOG4vNzhSWHlSbEthZGxrSTY0SHNtaEFKRmdHNjA0OEdkNitlTytw?=
 =?utf-8?B?OEdWTkEzQjFKNlFXMGNNTUR3V2ZzN1lsUm9ScTBING42Wk9Yd3lrUGNtT1pB?=
 =?utf-8?B?WXFmaWxHblVQSHA4NDR0T0JKSWZDTHEwUjd5Q1hyUjA0ZDRVSmYrYk1qaXNU?=
 =?utf-8?B?MjlaaDJweWZaYk5ObUtSRWpHWGlsWmpBYlBRSHF4cUJLRXh1aXJvZkVyaVF6?=
 =?utf-8?B?MzdxOXkwekh0aUhWczdXcEplbXBCRk1DclNRMDdEYU1pb2pJMkhoSGtRSFFy?=
 =?utf-8?B?cWtpKzIvS3A2cngvTzRXZmtndGVIR25aT3N3U1Jhby9MNStobEZ4MUV0V0NW?=
 =?utf-8?B?cFlEcTVVR016RDV0TnlLb2pYaEtsd01aVGlyZFZWK1BEaFdFVFF1c3Fva0dC?=
 =?utf-8?B?aTFJN1M2RmJzZnpvcDZTVzNtODhMR1Fqd1NRUG16Q0FNRmNEZHFQdU0xcDR4?=
 =?utf-8?B?elphcTZxbEFKUXRCQWFLTlcvdFhjMWNjdDlqY09tcy9iTTBqRnN1aEh4N1Y4?=
 =?utf-8?B?Tm13eTdKSklrV0xoR0FYOTgxenBjbWNia1lneXVpNi9OekRQV1FhbEN6bk1J?=
 =?utf-8?B?aDhFTjVqd1ZLdTdYT3BhSVNTcUY2R2VlZ1FRdjl1NmpMTlJ1TnAxcEVaWUVr?=
 =?utf-8?B?RkhSalFxWlBlbDJpcElmU0lIaDlxR3Bta2tabHU1ZmVGSFBCY2FyaC9UaUxJ?=
 =?utf-8?B?RE1wR3Q3TXJIUVY5NEVJZlk0QUwwL2RKUFFLaVFaQllvbTM0dnF6UUIrTDRa?=
 =?utf-8?B?cUs0UDlORVJtY2ZWNGxtR1VnNGVhODd6OFppVUpLRHRSUXVOTmdmNnBBVXM0?=
 =?utf-8?B?U1FFMU4xMWFqUXBmUEQ4dk0rVUovNDBKNm01bWx4L0Rlb0VBT3hHTm9BUytm?=
 =?utf-8?B?N0VKWlVsZFg4WnBnZGxFNzNQZnJVd0hON1Q0L3JkSlYzQjN2SFRoK05QRWFX?=
 =?utf-8?B?RHczV0JYSkNCS1FQVFAxY3ppVTV0VTczMDB5cTZ5czRQNXZjT0xmY0N3cGZ3?=
 =?utf-8?B?UVlrYlV0cWpuSk92bVY2VEZ0bkJFWkxXT2dGc0l1c2lZNmZ6N1NucHpTdkdV?=
 =?utf-8?B?UTM0TzFlbXpTNjFxOFgxNGF3TzM5ZjBkY3k4TWNKdjhEMUpGUFdFcElxdEpX?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0882ac4b-c88b-4173-28d5-08de17050795
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:05:50.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Mn4UELTZZ3I5BVNurErPbONl0UVZYZfwB65ZcQlTBuTQMbhkR6PZM5ConC/bNwM/Mqr+2756Lh/JihkpsWS9bieExROSrmlfFnJ2q4r1Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 19:04:12 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
> > Security Protocol (TDISP), has a need to walk all subordinate functions of
> > a Device Security Manager (DSM) to setup a device security context. A DSM
> > is physical function 0 of multi-function or SR-IOV device endpoint, or it
> > is an upstream switch port.
> > 
> > In error scenarios or when a TEE Security Manager (TSM) device is removed
> > it needs to unwind all established DSM contexts.
> > 
> > Introduce reverse versions of PCI device iteration helpers to mirror the
> > setup path and ensure that dependent children are handled before parents.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Bit of archaeology was needed as there are some existing oddities in the
> functions this is based on.
> 
> My suggestions for this are don't use guard() and drop the void * cast that
> we should cleanup in the existing code.
> 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index f26aec6ff588..1c981ca72b03 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -8,6 +8,7 @@
> >   */
> >  #include <linux/module.h>
> >  #include <linux/kernel.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/pci.h>
> >  #include <linux/errno.h>
> >  #include <linux/ioport.h>
> > @@ -432,6 +433,27 @@ static int __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void
> >  	return ret;
> >  }
> >  
> > +static int __pci_walk_bus_reverse(struct pci_bus *top,
> > +				  int (*cb)(struct pci_dev *, void *),
> > +				  void *userdata)
> > +{
> > +	struct pci_dev *dev;
> > +	int ret = 0;
> > +
> > +	list_for_each_entry_reverse(dev, &top->devices, bus_list) {
> > +		if (dev->subordinate) {
> > +			ret = __pci_walk_bus_reverse(dev->subordinate, cb,
> > +						     userdata);
> > +			if (ret)
> > +				break;
> > +		}
> > +		ret = cb(dev, userdata);
> > +		if (ret)
> > +			break;
> > +	}
> > +	return ret;
> 
> I see this is local style so fair enough, but I'd have gone with early
> returns as it's a simple case of return ret if it is ever set.
> 
> > +}
> 
> > +/**
> > + * pci_walk_bus_reverse - walk devices on/under bus, calling callback.
> > + * @top: bus whose devices should be walked
> > + * @cb: callback to be called for each device found
> > + * @userdata: arbitrary pointer to be passed to callback
> > + *
> > + * Same semantics as pci_walk_bus(), but walks the bus in reverse order.
> > + */
> > +void pci_walk_bus_reverse(struct pci_bus *top,
> > +			  int (*cb)(struct pci_dev *, void *), void *userdata)
> > +{
> > +	guard(rwsem_read)(&pci_bus_sem);
> 
> So this ends up different to pci_walk_bus.  I'd be tempted to just
> not bother bringing a single guard() usage here. Gain is trivial and
> mixing and matching style in a file isn't particularly nice.
> 
> I'd not mind changing pci_walk_bus() as well but that would need
> to be a trivial precursor patch I think.
> 
> > +	__pci_walk_bus_reverse(top, cb, userdata);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_walk_bus_reverse);
> > +
> 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index 53840634fbfc..e6e84dc62e82 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -282,6 +282,45 @@ static struct pci_dev *pci_get_dev_by_id(const struct pci_device_id *id,
> >  	return pdev;
> >  }
> >  
> > +static struct pci_dev *pci_get_dev_by_id_reverse(const struct pci_device_id *id,
> > +						 struct pci_dev *from)
> > +{
> > +	struct device *dev;
> > +	struct device *dev_start = NULL;
> > +	struct pci_dev *pdev = NULL;
> > +
> > +	if (from)
> > +		dev_start = &from->dev;
> > +	dev = bus_find_device_reverse(&pci_bus_type, dev_start, (void *)id,
> 
> That (void *) is casting away a const but bus_find_device_reverse takes
> a const void *.
> I think you are fine just relying on implicit cast for that parameter.
> 
> Not that important and pci_get_device_by_id() does have same odd casting.
> Looks like way back bus_find_device() didn't take a const pointer 
> 
> Seems to be true in 3.19 (random choice jumping back through time on elixir)
> but not sure when it changed.
> 
> Anyhow, would be nice to clean that up in existing code if anyone is bored
> enough.

Right, happy to go cleanup old code if there is appetite for it, but I
am not sure it was worth destroying the blame history for that. In the
meantime, keep the new helpers "style-bug" compatible.

