Return-Path: <linux-pci+bounces-15471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558AE9B3844
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B611F2304C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B6A1DEFE7;
	Mon, 28 Oct 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6J0G8Sj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448521106;
	Mon, 28 Oct 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137965; cv=fail; b=WxYRsJ6dx0sB6KEKcAtLJZvwuBnTGZ0P77X0+tbzfFFiYCYpM9eao7ltsJ/picmFJ/uomcZQm7HGiX6+i3IQEpGBQmfXOV6S8LkEmFyRnxNu4Yg/dwHfM2g1UNVqwaD5QsnmY/ETksoSnOVSadE8NUyyPjrBYR8r5p7mwPm23p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137965; c=relaxed/simple;
	bh=cqIRUhGERLdbM/CG5Og+jihFb/f/FimrWs8O+IaaOVk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kYWdsjZ/ZAzoCh3LkUt+P6CRXUPGqb350YkA/k8gozqAvIEckAH7amyxrHjdmwvFs2JXCrXiKX4lAVNl+oafMbkFbL/5ipFelGn2pAWbY94ud21lo/+HprdW21+LpGJrAcWL0bDLj932fsuHYAOOlEFhGGK0/Q9Tj4BuAeSVCNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6J0G8Sj; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730137964; x=1761673964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cqIRUhGERLdbM/CG5Og+jihFb/f/FimrWs8O+IaaOVk=;
  b=m6J0G8SjwuuMkttoO1jXd7Ho+15z84Tam58vB2OJf5jrMo9cZssu41fG
   TSjR9y0sNzlOCTpsgFC6FA6t/L4eIfCqwK9yVHoCsjHBMN2VGbwCqsNH5
   M60ijYDIl+1K4k9IEH8DfXugfCXM3P3oQiq0RkN/oWWYQWBP2nB0xsL31
   z2GCN0UivLHupzZj5trCD9x2oMp4gazLra3TrBDPof5yGIBI8kCQjxfHF
   FG3JCJvy27Qdg+U868KINMzqMv/pkLklpvw3AH9zWO7/AH/YySgPHlZJF
   p6k22Xubf2iydAXjYDtuZZUwLc32oa4JQ0QmyO/d2LZ6eKEmDXPZDYMnx
   w==;
X-CSE-ConnectionGUID: 2kaVfthWTruQTihOGgGavg==
X-CSE-MsgGUID: RdwThYEhRfaeeimAdHNwYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29856128"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29856128"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:52:43 -0700
X-CSE-ConnectionGUID: 4mP5BMwZREqOxKyKNCQPww==
X-CSE-MsgGUID: NtzCEbPxQJGNy4UespiFdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="82018535"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 10:52:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 10:52:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 10:52:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 10:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbXW9SzjPgTVlqKtF05o90xqHpn+G0oDkuM2hOK5QuhuqqkJqas307sqDr7yDH51sXxgXIAOuTvXq16qJ+WTA8Ihy6GglmFC2GPiw2068rBWTgrCCECK08W8DVbUGX+mMg5W7vRi1TaJhjXUn0LCFhXlF2xk+kyuV+m6Gv5NakaJ0KhLIQaqGHWjEvSm6LiX8AeL9I++rSA1qjYDvA5hkVUM394IPyUAZpeX7iTS02GecG6eCX4VkchtIv8So+/glZdQq9KFH1zAnNnpXUjTI/uqNTbTbB9DKT6Xou47J3CpyP0rgFGvJT4yOJus2WbhT2JDqet15BuGX+znRzsyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBN0iaFXO5B72S5WfNGRaWwKJnzBXIjhOdQHzMXMh7Y=;
 b=nFd4dbu/5lMXdcGEH9geGsd6mc8yoOlkds7M6LwRblXGdok5Oz1vFRAzoQ2a3E73vnXJ5Qjrf2b6rA/tjEHBoJhLq7VzkJ+dC8fvMviRQZ3y3LMKHNDKtCAVzc9fq0c6WXI3m0/h2aN6bTYj6Xn/wjWd612OH1dvigEoGPMlses+UgDiNDX51gL0vE6QhEDlQGlTqRqeVQ/gW+J0LM1lJ421W97aM5KKphyUYLcb363ZteUCjM1oGJsAFg3OY2nueatAeohEY0vAUSfgLQKc3Z2VJNSb4bM8omKh/03w/5bXtjrEgC1PdUqnzhBYxrcSLhJXUN9GDHh9gYLZesDZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CH3PR11MB8466.namprd11.prod.outlook.com (2603:10b6:610:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Mon, 28 Oct
 2024 17:52:38 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 17:52:38 +0000
Message-ID: <7ad59d82-8122-438e-9682-791816ab0366@intel.com>
Date: Mon, 28 Oct 2024 18:52:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] PCI/PM: Do not RPM suspend devices without drivers
To: Marek Vasut <marex@denx.de>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>
References: <20241012004857.218874-1-marex@denx.de>
 <ZwupHAAwTo5mDyyA@wunner.de> <52b90ab1-2759-45e9-ae86-3d3073a0add0@denx.de>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <52b90ab1-2759-45e9-ae86-3d3073a0add0@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|CH3PR11MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: a49d76e8-325c-4606-a718-08dcf7794fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWZDYXVId2g3cEwzQ3RNajFmSHpkZ1huUUNGSDFWanB2TWlXTm5IaURMcXhG?=
 =?utf-8?B?UmJMQmYzYXVZSEs4RmVQSVhlVjFpaFRDdTEzNE93VkZWRFlENGk5bXN1UUtP?=
 =?utf-8?B?NGRtRWlqVk00TjR6bFljMkhKZi9aRmc4WTlqOERwR3hhYlNZaVVQM212b3pu?=
 =?utf-8?B?U3prRGxGM3N3OFpsUFk5RjhSU2IwYW1RMTdsTTBONzc2UkhUWWhJNnhJMDVO?=
 =?utf-8?B?OTZnckdBQU8vQU1wREp0dlV6Z3hVYU1FTzNxbjU4OG84eEd6bnl4TGptWDVQ?=
 =?utf-8?B?Zk9zNTRnRVJuL1g3OVNPcEtVQ25pNUtORnprQmFqem1HYzZHY242SW1OQWto?=
 =?utf-8?B?YTZkUm5MWkNIdlhwWWk2Y3BaWmpxYlhOMmZSRzFHeDVUWDJERlVhUUVsYVlG?=
 =?utf-8?B?UlRiM0hpUENoUGRIUGIzZlFDTHNJWVFQTVRISTZwM2J4RGZQS1h1WEdNZWxv?=
 =?utf-8?B?TkJNYmpjd1pHWW1kRTBjeDlBTjZCUCtzMUJVRm5wcEZ0Vm1OeXhnTjdSL2VD?=
 =?utf-8?B?ZXZsMDkwUDY4T0t6QkhCdHJ6RnU4ajZoQkJ2TVh3T2Fub21kWVY1dXIzZE5r?=
 =?utf-8?B?cTA3OGZucVVhVVFOSmt6ejlPQXcwb3hHbHVUMHl4YlB4ZEpwaVJreXl2dUFI?=
 =?utf-8?B?Sk1XOTZKMEpkTUFUdkloVVpWeVNLcnJyODNva1VTVDRYTy9QTURXSGt6WXNz?=
 =?utf-8?B?OFpOSFlhcmhtWVNzTG5pRW40ZUg1QVZkV1V4RGF5K1FlRWE3bDNBYy94elJE?=
 =?utf-8?B?UW50UEk0cDdhbHBxVFFMMFhCRmczZVZnT3RaYTc5QzBSdm12WDNicTdteFlP?=
 =?utf-8?B?SzlIZ3F1dXk3RUtXMVJiT0JualJ1OVFqRUYyZkNnOUdVeWc5amdtNGJObngz?=
 =?utf-8?B?azkxc0dpYlFsRzhqQUM0ZEZqTDFCeitpanFiejNhTzF2V2ppMDVTQjlNRXdT?=
 =?utf-8?B?dGttTUtqSkJmTUkxRUNraVpuMTFaVHBBYVdnSXpZVHYyTmIxQlJrNTI5Um5K?=
 =?utf-8?B?QmhZZVdtUXh3OFlOYmpCTnJtSklKLzYzNFJwbkVmV1V3cHBwTGtvZ1hjejRx?=
 =?utf-8?B?RzZPc0Y1UGk5aDNOV3dZRVF2NjIvT1BUUkZnNHlTK3BMWXRnSVRvN3E1TTZP?=
 =?utf-8?B?S2dDaVFNWmNjeVdpVWZvYTAxZVppeW5INkhyQ0xnYkN6T1h2WDlzQXdQOHUw?=
 =?utf-8?B?MFo1ZzRlYS8xK2oyb21OQW5DL01LUmVhdE5EOFdZZm1vbWo1MnBYcVZOT3py?=
 =?utf-8?B?Tkg2bWdsVjVLVm5QUm9RU2hJaVBNODdscm9kQjcvTmtxbENJbmVneDhGODdo?=
 =?utf-8?B?NXRBVDR4WGU5bCt5ellRYkhpVUY5OEhDVkx5QUFTeHhWeTBTNzI2Y0FYbnlS?=
 =?utf-8?B?cWtKVzJPaUxQWUxTTHFScy9jTk14VSt0b3poc3A3S0ZJWmNNbXdidVhOU1Nu?=
 =?utf-8?B?L1p5djZ4U1daUjh3TjA4NWNwVHR6NWJ0aHl5UlNsWEFUYUpYbFE5Q3dhZFdY?=
 =?utf-8?B?TzAvOGR2eTFUSVhpSG9TNmRucWxzK0FCczRXMGM4eWZwOWJQamx3YmIrdHNk?=
 =?utf-8?B?MnRFWCtIMXJQcnRFcWxJYVhBbzFNY3RkRXRDVnBoTCt4YmlGNWV4eFA3Mmds?=
 =?utf-8?B?YUpIb0c1OFpPdDV5SUtzUjRJVDdyd3NHODNreFlDREQ5SjI5Uy9ZTy9Mc0Rn?=
 =?utf-8?B?WStjUTJ0RGp1REpHdS9jMy95U1kwZzB3NFlGWWhXeGlOQnhvcVJkMUllMDVp?=
 =?utf-8?Q?0EBNsA+INEbi+cddItqtN/9LG+Fqrexi4jNOywa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVsYmVyUkkrdWxiRk5RMUpxNmpNTDhvR1pGYmdKRjRkUktBUnZmUStHK2Zw?=
 =?utf-8?B?aE1QT1p6VkZwa0t1YlN0VkR2cmlBUXM2UWtobHFYWitPQjF0L0xCODJVbjRK?=
 =?utf-8?B?d0NGdS9MWE04RUtjd0M3YW12eVc4a0tPRFNMaTNBUVcvWnp0Q3RrdHg4Y0Vs?=
 =?utf-8?B?ZUZPN2xDMElzNEhob2xLazIwQVpDOHhOZHg0NWhWOVVIVUJDUUhmYTFES3Yw?=
 =?utf-8?B?YXpuVnFvMU1rRVJDQUlFbk9jcDdUVllXcnhJZyt5Q2gwdzdwQTk2OHRZSFNK?=
 =?utf-8?B?T05xSGloN3h3NnhFM2YxWTNiczZ4b0FlRTZEN1Btbi9ueTNEOGpVamxqNGNs?=
 =?utf-8?B?MEczdjZ4N20rTVcvOGZBUWtGL2lvcmRFRUowc0FLUWZuSzhSUEVZTXB0bEww?=
 =?utf-8?B?dWN0clhWOExKMFYwSVFMN3BiV0NuMDRLMEtab0tzK29yeXgra2ljaVFzYUJV?=
 =?utf-8?B?WXVBYXR4UGZxVC9qZng3dnVqN1NXamZtY01SdGFLdlhZelpPUHREc3dlalZp?=
 =?utf-8?B?OFI1MFJLOHdjMU5HRzErRnA4SnZFcGFVWlZoeXQyOTlvSFVRdTlKTHlBLzN2?=
 =?utf-8?B?bzVnUDN5UnpXN3o3RmUrdGRQWVJJOHE2Mk5UNXlsL0xucVR0S1oxdnllU2l5?=
 =?utf-8?B?dHpzYktYS2Iyb3UzTlY2N2FJbmlBUG1QQkVRN0VQanpRYldjbG1YdlI5b1hZ?=
 =?utf-8?B?aGp3alduVjNzK0JJNXdsWjNzTFBOcVlaS2ZNb0R3UUNuTzBkNWE1eURvM2hZ?=
 =?utf-8?B?bW9oZ3NNdW9xWmNNZXBNdWJSZGREdWlJNHlRM3VjUmVzc1Btci9OanFKc3hh?=
 =?utf-8?B?ZUxySWlxbWRySzVzd0RZTjhyc215dEpaWG1KaE42VmxpTkQ3cVVCQkIwNHdY?=
 =?utf-8?B?aEFtUjJJS05tWVBNWlVsRlNsczNDdFUzRFRwMmY3c1hIWmtDNTZvTyt5Mm1a?=
 =?utf-8?B?cVUzdDV4blp5OFUvSWZEV3RyMWx0TU94ckpxc1dkc1VJdnRHOHJRb0J4QTRJ?=
 =?utf-8?B?T1d2bWNsSGxkR1BFTkpFbkpMbDB6NUxDeXFtWWNnbXU5ZkJkaFAzMEZSTGUw?=
 =?utf-8?B?emVNV3YrejBZYUxvK0grL1BkODY2c2xoZDhVUHN1NE1aVlNMYjE0UVR0eUJ1?=
 =?utf-8?B?MGx6enRmMWl6MURQMnJ4K29FYVp6VnlScnFvaUoxdmxoSGV4ZnNDejRKdkpo?=
 =?utf-8?B?a2NMc0lPcUE2UWw4OFVwakNKR1ViSGVhbE1UU0Rad3VuSzhscGJ0Tkx5REky?=
 =?utf-8?B?NEhXZUFwcGdYQ0ozMngwZUR1YXZIT1lNOG1oVmpMUVkwZ1A4R096V25aSkND?=
 =?utf-8?B?N2RxRVYzSlhjdEs3b3N5Rml2VWcyRkVOYnA2OTl1c1UzNklZeFNSWXJERjcz?=
 =?utf-8?B?RGhYTzdlMGZpeFFyTTZrRnVmRVJadDdBMVZBUVd6VFlmSDdXNC9XV1JqVWFM?=
 =?utf-8?B?UUpIamV1bElzZ29vaDhFSUNxdzZOUFVDSlBQMEEySG1QS1VCNU9DV0lJZHZK?=
 =?utf-8?B?YjZsSVFTR0M5MTFvVmR6endIcWZnWDkyK2lnKzg2WjE1VURia0lFZE1FUllS?=
 =?utf-8?B?Tm5WT0xMY29DWnlxS3EwTWFuandpRzB2alV5ajlUUHorUkJEOFhLL21Zb3BX?=
 =?utf-8?B?L0VhL0EzNVAvVTJLKzBNQnhGcG02UlZmRU9DR3dUZ2RjbHJ6SENDRVdhOVlv?=
 =?utf-8?B?c2dLZFl4OHV2ZGd0MWZuMjdlWEI4eWdiS0JIQm5ETHV2MCtKUHd4ajR5UldP?=
 =?utf-8?B?eW93T0dWUk82bElDODVqVlBBNkR4UkJWbityZDVsSGtUU05ReTh2aUtaazVR?=
 =?utf-8?B?MG5rU24vQXNZekpYUzQvQXRycEQ0WkpCRU5IRU9zMVFOSXlrcjc0eU55V09p?=
 =?utf-8?B?ZmhCMkdKRmFaWFZYamhmbVp1ckVYUnBnek85MXg1R1YyUTVKdmFTTlRCdFpV?=
 =?utf-8?B?Y1U2RmtYSW5XcVBDUXZTc2lCSy9hakgrVWJsWjFESXZxak5jdXFWR1U5ZXhw?=
 =?utf-8?B?c0ttQkxERmFQd3JJSGY4WFNzR3VLMkFNait5eXFJRGRIN1lwMUJ1UmFCVVR5?=
 =?utf-8?B?TGcvN3pCRnUraUh2alFCckFyVnBranFVc2xyZ0tmQnFrbHpxSVVwczd3aUdo?=
 =?utf-8?B?NVh6am5sZ01iWnkxTnVYNEtCdUh5R3pmRDREZWlNeDc2ZEFsOTRvRkNZRnQ2?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a49d76e8-325c-4606-a718-08dcf7794fd6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 17:52:38.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0PQGY7wX/vEWuHf492BfYMrNblJT4Q+cDFwCl1KVHOww8Vccy+eO+yrFx6hHzCeI5Ftg+uOQVITp+1n2ryS9vPetJnSjXyXEqszcFuIz8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8466
X-OriginatorOrg: intel.com

On 10/26/2024 2:19 AM, Marek Vasut wrote:
> On 10/13/24 1:03 PM, Lukas Wunner wrote:
>> On Sat, Oct 12, 2024 at 02:48:48AM +0200, Marek Vasut wrote:
>>> The pci_host_probe() does reallocate BARs for devices which start up 
>>> with
>>> uninitialized BAR addresses set to 0 by calling 
>>> pci_bus_assign_resources(),
>>> which updates the device config space content.
>>>
>>> At the same time, pci_pm_runtime_suspend() triggers pci_save_state() 
>>> for
>>> all devices which do not have drivers assigned to them to store current
>>> content of their config space registers.

What exactly do you mean by "at the same time"?


>> [...]
>>> Work around the issue by not suspending pci_bus_type devices which do
>>> not have driver assigned to them, keep those devices active to prevent
>>> pci_save_state() from being called. Once a proper driver takes over, it
>>> can RPM manage the device correctly.
>>
>> It sounds like you may want to acquire a runtime PM reference
>> or disable runtime PM for the duration of the bus scan (or at
>> least device scan) rather than the proposed workaround.
> I was hoping to get at least an confirmation that this issue really 
> exists and that I'm not chasing some nonsense. Thoughts ?

