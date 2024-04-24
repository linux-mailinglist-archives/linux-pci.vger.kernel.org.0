Return-Path: <linux-pci+bounces-6654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550058B1531
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3466EB21C05
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074D156C41;
	Wed, 24 Apr 2024 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S32zdKB/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F413C9DE
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994162; cv=fail; b=Jal0ZJLNtDQ9YujYThoMq6qqTt0sxjcJ5zZYT/Zb3pA+L9cL5bOlLzwxkWK/ZeAcskZ8wUkQAyZ6BuRmgwbG24hIBbsvHdV5C7jNrTGzyozBhApoaPjHOnNHWp6ZxvhHggOgJJijV1Jb0nx9YFwqp7BHAcM2TH6nnbwrzLmwFjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994162; c=relaxed/simple;
	bh=81GgC00TVk2/XX/1ShuDxOfMN2aJWQxFQpWrTn+mei4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nV9dSUVa53qnIQXMNSFemaJm3M1OOT3QQ41b7gUPoCPTNLIX6gaaHEk0hZ0RH0++5ES5xBIMkwPHmHPG1lrtxxCvAxtrmiZcKdQ16P2QfizrUOULjj+PCRilQGNDTLAIPLF2ZOqWyi5eFasnF3iA/t11wr1ApSWWlKSQyV+aWo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S32zdKB/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713994161; x=1745530161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=81GgC00TVk2/XX/1ShuDxOfMN2aJWQxFQpWrTn+mei4=;
  b=S32zdKB/mMhfODkjtea7XK+secournh37s7avVnTqyBniSjlSsEdSllJ
   5BZ8I/e+OgXJtbHaeIkf4oAzRKjCA8SCJozAuYtSmLlF4+huLoyBcjnAA
   nXSb+FkUwnyntfEMioQM7HDZGXZ16T96EN2FHPRlNsKR0Imqpp7+gCLus
   JIpBA31T05eBdPk3GdJEe5xnwMxcFj+ngMuFe0nP7zpWnbfdNgEkoT+OQ
   UjAgmY8LPuI06je6VEMw6z55DMOWavJNV9xM9pmAy1b7yoQBAoDWA0L6m
   PRBEbDraE/E2k0x0ocPUoTshHJwSmhbh0Nx19ihxZfQiDeNpHgPu2u8om
   A==;
X-CSE-ConnectionGUID: VvCKG1oLTBOrvJp6pvswDw==
X-CSE-MsgGUID: LozZY3uNT2mecmCXNVYKNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9775336"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9775336"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 14:29:21 -0700
X-CSE-ConnectionGUID: E3MS6RbOR9iJfi3i1q17OQ==
X-CSE-MsgGUID: ZhP8A8jyQ6WURDAZch6MwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="25352161"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 14:29:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 14:29:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 14:29:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 14:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1UFaMWEjKXu6lIAxb9/65JIyB6xjdkoQ2rcZMgE3vCNVIyzwFyiDtmtrsQutqnIAWUZDCjzM9ij/S4zkjUS1Totf54QUuMALurCixXeim45iuN4ao4buKd+aUkjChJcFgJvMQLUknCgYIxO+E+sI065ccp3dnXd+eZjmzqs4d7w4cJhKamD01A4iplldfSeUB9okOREadJxj+/Pl1G+eIEixS1kzczKMgE/SVf6yIDZmLLs6U6pQRkzHIuaXxw0U0gq1xcEq1hiIMmsNyR8V3YTLEiMCVp5f1ZMEoan8HMnq3+MwZ6ThUdvgP4CaiIVPycqRaSjjAV/tpF2ofFp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwnJSxncrQCoHJweB8Eh5rmR1WglbkAwCwyVbihKCac=;
 b=Pa2dy50f4iJY0XRJpFP+mpQTLfIzS38+eE1RM3OKWq5CschHOzFgY4I7tAV6njRwttIMGVgOww8ZqctQDKShza3XA8PL2SBCo/7ghES5QIoL9MV4ekE/7lB6glVfAalvC7j2nR/1eXkKkv2p11QywRtEJg1BrMhobDgUWjZ7fU/sROSY++AcpMakJb7SLf6lhkGGXEeqMs3BRn+8YSOMokpW9YzEG4sFz9IY7bwsmNEnyQzYzR7XVcF6oVEZlAqo5CZZhHRHeuUcX2RQR3ByYsadYazYdgItI7nSi26nuhC2TyKqyJjsL0CP0oom5cHYzU2AplZ77vvrWWbr/7qoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Wed, 24 Apr 2024 21:29:17 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 21:29:17 +0000
Message-ID: <56d5ca30-de62-4f7e-a43e-2affd2d1059a@intel.com>
Date: Wed, 24 Apr 2024 14:29:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240424004733.GA476130@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240424004733.GA476130@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a97c18-8195-410e-c8de-08dc64a598bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkFyajhWS3UrQmxaekFkK0R6K0tPTUZLT3BrS29ka25EWGY0b2tWZC9KaWxl?=
 =?utf-8?B?M3p6SUdEOUhjNlVBZkpjTytnbnVyM25wdnJPQlJkSjhpdUdkeENoSnpFT2lM?=
 =?utf-8?B?OStjeWc1VlJrOEtCelYxS0VhQVFmR21raFQ2WUh2djJJOTZWa2pHa0xOL3h4?=
 =?utf-8?B?T053UTd6NEZLbnJBbHZ3aG1Ra01DZVJySFJJWGk1YjJhdmZKd2RmenJQcUxv?=
 =?utf-8?B?SkpWK2tqNmVuWUpvR1JkSGEraGlsbVVsOVVIVzV0ZUFydWU1MytUMUxhemhO?=
 =?utf-8?B?SHBaVW5ObTg4b0FIVlU0czZrTEZkTHlEcU4zcU5QVEovaVhwK2lCa2NpRHZN?=
 =?utf-8?B?aE9sdzYwVzYrUVlwSFZmdlFRN3pMNlBFemcrZXhMaHE5d0JWcTFMQVRwTEEr?=
 =?utf-8?B?d1ovSGxFVHR4Smt4RW9nQzlCMDBZZmtkUEh3OWsvYVdnd2Q3V0F0NVlsdmhF?=
 =?utf-8?B?S2hoN1JnQi9ybVM1VFVaVGhoaE1YY2g2Qi9Wa0ljUDh3R0FtS0pURS94Qndi?=
 =?utf-8?B?N2p3MjZmVFhUZXdoQ3RkUEM4ZEVySkxMQlBnamRIZStpTjJmR05ycmIxMmVT?=
 =?utf-8?B?aWg0eENpZ1o1RGtxcUloeVJiYVB4aWlXeWlHRDZPTm5MYXFIeUtLNEhDZVNv?=
 =?utf-8?B?ZFU2eHhXYkFIN21FSDBaY3B2dFZuOSsvQVpSZW5tOXZGdWduSE1CRkQ0TzNR?=
 =?utf-8?B?MHVXUWo1T2I4Z1MwWWEyM3Zia1E3RzFDbDN5QzlhVXhFdmZWRDNDQkVVSXdN?=
 =?utf-8?B?UnV5K0QyQmdNNmdlN01ORkhtV0lCNkViSmpqb3MvcTd4RjViaXM4bm1qRXFp?=
 =?utf-8?B?ekRVbGwxTUsxemZ2V2ErdDk5dkExK09wMVl3KzFmSmRRenU0aEZnNkxIYWUx?=
 =?utf-8?B?Wk5XTnFzNy9Qa2VzcnAzRWVmWklNNDEwOHZXS1N4K0RTZUs2SDN3VHBadmdt?=
 =?utf-8?B?WW94QTdXbzVvWnhEOVZiZlRBK3Nzd0JGR2pVd014NHc1ZmM1c3p1THNYMXJV?=
 =?utf-8?B?d0dmZlJtVFFsQXBWek1hQjArSm1UNTVSQ2x3V21nSWt4M0dJSWg5UlN5SlVZ?=
 =?utf-8?B?amZCNWFxUHhYTkpLQ2plLzZBOEM1WWdTMWwweW1iNC9hT0FGUHhmNmZnb2xs?=
 =?utf-8?B?MTh4a2tEWVk4UDc2ZytRR2hZcW9xcWlxRDMwMmxxVjV3a2M1RzE4Q2lvR2c1?=
 =?utf-8?B?amc2bUIxeHBveHcxNEd3Rlc0SFRFUTg1QXhFRUZCaWx1WGZwMmRyWnZqaVQz?=
 =?utf-8?B?aDk4aVRmRTduUFVIaXRWWXlKNnhTNEtxeVpoRXFmOTkwWDZEVTZHcVE3aEhC?=
 =?utf-8?B?REE4NUJ2OFhXT0w1dUpXMXYyUmlPYlNHU0p6NWtsd3VneGVZeGJZSjlZTzY3?=
 =?utf-8?B?TXhwUEV6RWtLTGpsNHJ6R0ZIWC9sS2VRS1lMMFRXQU50NkpqTFdCMzl3RDc5?=
 =?utf-8?B?aXJoZEtDRFRKTis3RUZjVkJ0Mi8vYU4vbk5YRjE5UHc4Y3lxVENFK0pJOERp?=
 =?utf-8?B?THU1MFZSZkpycDg0RU8ydHdOMnZTR3RsbDA3bCtoeVIzTEhOQzRUUFVrR3NC?=
 =?utf-8?B?bFcrRzBoYnU0eHhwUVhQVmM3S3lmb0RFWW4wTG96Z011cVFWTEhoc0xPVDMz?=
 =?utf-8?B?MXZ6b0QvUTV4d01TNHZibWQwRUlFU21yUUROS2xaMjdyMTRWUElnTkcyRmR2?=
 =?utf-8?B?N3AzeGc4MDlVYytLSHN1c3VraGVkSVM4RnpJUHQ1VG9RMmlIdVQwRUN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXVBL1c5eUxTeHlLa29JaDZwWjQ3TVgzbkh2WDhVSEtmaHowZjlhMEJwYkQy?=
 =?utf-8?B?TG4zRU96M0NjczJ2cU84SVBxUXhJNmJnc2ZkUkJobFVUUEU2ZXFIVjVKMWpK?=
 =?utf-8?B?eWNMVzZxOS9KNWtlNHBTUUtJdFU4R2xoQVMwQkFVTUk3YktRSmdxZVFKWEhs?=
 =?utf-8?B?RlB4eWFTNTRCTWE4SE5ka1JhN3d6Y0pGQTBlbGRtbEZ6SmdVNUxYaFlpM1lK?=
 =?utf-8?B?eUpEZ1JGdUtBcEttR282SmUwQnRDU01RcGtOS1NNeWdQaWdvZ1psVFlPaDVG?=
 =?utf-8?B?a1QyTVlTdEY3TkZmZElXUWhoR2ljeFlGMi9FVVVjMmc0ZWRreUlmMFlMc3I1?=
 =?utf-8?B?T3dtMitYUmNpQUYvRTdsM20zZ2tEOUV6ZU9pUXhSNkZjTU9NVEtmWVB4Vklv?=
 =?utf-8?B?SjIzU2pOMGZXZGFGbXF1b0V3bXlPb083ZlcweEF4MXg2ZnN1RllCWjJrZyt0?=
 =?utf-8?B?aXBOcHZnV29uNGdwSnIxNTdtckE5R1JZWlJaMkNhMFhsOHYrR1lrb2tMSXJB?=
 =?utf-8?B?YVRqNzlIQVlDOEtWRkYvQWgvZTI5WVg2NmZrNGVKZUFnVjdncXZKdHZ2K1dy?=
 =?utf-8?B?cHdXVWhlZWczL05NaTNRK2tqUlZXZlNGaTIwaDRTV0NMK0haaHR4THRlbTRv?=
 =?utf-8?B?SDVBNFRMU1NnNlNLR1lCSTFkaDdMSkhaVHA5UnkzUXBUcHRPTE9hLzJ3TFp5?=
 =?utf-8?B?ZkRBelptMnoreHk1bzFRemUzMW9GRDNoR21RQncvU3ZmNU05UGRMay96cEpv?=
 =?utf-8?B?QUpLT2t6M3ZEbHNzNW5FY1IzSFpYbllEN1hCam0wUGN6SEVvcmZiTE5RTDRP?=
 =?utf-8?B?NlRzbmcyZnp6WG5WNTN1dlJsM09mbXd0cnp5TWkyTVBlRHBNWXB3YWhTUXRs?=
 =?utf-8?B?QzFFbVRmUkRWRDcweGl2YzRIV3FJcE9sSkRBVU9NS044QnZybTA2RVNFdlgz?=
 =?utf-8?B?Wk1MejdWVmEydmxYd3J1a1B4ajNYS3hycU1oRnBuNEZ4K0VVSEh0L2ZyRG1h?=
 =?utf-8?B?RC8xMUZhUHpESFhLN3pGaEh2dXd6a01mRU5SSDJJNEw3akpuQ0FYcGtmc2JJ?=
 =?utf-8?B?WnYwaDEzYmNKVzdaYlZNTjdrTjVmTDFkc29FRGFuTDlXQTRuMUhvV2NrZXhW?=
 =?utf-8?B?bG9HRjk2RTNTWTkrcDRZd0hXY0VqU1Q5eVE3N0dXYzJqbndpbjIwR2R6eFh1?=
 =?utf-8?B?UERHQktJQUpsaW9JaDVyMWp6YUF2aEZHMlZ4RzhuZUhYd1B1ZjJZL0xTd0RQ?=
 =?utf-8?B?bnh4MVBDOHpCTHVreFc4TG94eTMyK1VDb1EvTFJPYjliT3JPWXErdk9JYVZO?=
 =?utf-8?B?dE16cFVXS0lNNDQyZ2VhaTdnRTBMNzNkUVNEMXBpZ3YyRzNpbzBtd1pPZElL?=
 =?utf-8?B?L1RVcVIybFdjK2dpU2tmRkRZZExJdjh4UkxwWUhSRjMxVk1vVGVTSlF3dDR3?=
 =?utf-8?B?RTFtYlNGdXJhVUQwYzN5TlpTc013a21yYk5QL09hNnJBejNDTnZDMDFWbmo5?=
 =?utf-8?B?ZlRiM3pXenVGaXR6djNtV0NWRlp4bjBoSXJLdUtoMDlNdFJkYUcveVpnakJ2?=
 =?utf-8?B?Y09YUDduWThvRE9PdTRGOGpCU09JQmx3Rm5ObXU4S2VvdFlYTDV0N05zZk9Y?=
 =?utf-8?B?R2FDTnA1OXNsY1RTSVZhcFMybnV5Y2tnamdESFdiKzNvc20wa3pFdUdTWm1u?=
 =?utf-8?B?YVkzOTJuSHdkdnkwUUFCb0gwYU9TZjE3KzZMbHVGaG11cFhsZDNjRVdtamVl?=
 =?utf-8?B?bU5YTUI4MHpaTU9Dc2F2MnZ2am9ReDA2Uko1VVpCTWNjei90cGZIRXZ2SHFy?=
 =?utf-8?B?QWF4MkIxajBUdUgzOW93aFNYdjVJUEYwSU9zUEx2cW5YRzB6MjVWcnZSalVZ?=
 =?utf-8?B?eVFOVGE4anczWGxwalQ2RHUyME90TlRCdHBTcXdreHNVaGxPZFVteGRvMEdP?=
 =?utf-8?B?TUpZWmZaNFpBc2xPZFBBQzVsUURQdHNwSFZzUk01NXdkMlBBdVBwTDNqYWx2?=
 =?utf-8?B?VE1kY0IyT0RWdnNXZ0lLcmgwa3JmU2dxejRRVmNON3RMNDJVOVgyK1hUajRy?=
 =?utf-8?B?NzFZKzNqMk5qaDZ1dWw2L0ZQcHR3YXB3T21BckFYU3hUa2ZlMEJab0QrSzB2?=
 =?utf-8?B?ZXEveW5yazdKMnVhTVJDRngzckVDYThvcUM2UDZLbnIyd01OWnhla0dkZWdL?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a97c18-8195-410e-c8de-08dc64a598bf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 21:29:17.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrz+jRDD5CERT2fgRFMrlvitw5KuRQozGmPUx30w4iY+Gqh8k3IWxxt+H/1sjdOrHevH+Leuo2a2n/yyhfXukzYbjPmufqR/dR9dcRQXERo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com

On 4/23/2024 5:47 PM, Bjorn Helgaas wrote:
> On Tue, Apr 23, 2024 at 04:10:37PM -0700, Paul M Stillwell Jr wrote:
>> On 4/23/2024 2:26 PM, Bjorn Helgaas wrote:
>>> On Mon, Apr 22, 2024 at 04:39:19PM -0700, Paul M Stillwell Jr wrote:
>>>> On 4/22/2024 3:52 PM, Bjorn Helgaas wrote:
>>>>> On Mon, Apr 22, 2024 at 02:39:16PM -0700, Paul M Stillwell Jr wrote:
>>>>>> On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
>>>> ...
>>>
>>>>>>> _OSC negotiates ownership of features between platform firmware and
>>>>>>> OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
>>>>>>> device advertises the feature, the OS can use it."  We clear those
>>>>>>> native_* bits if the platform retains ownership via _OSC.
>>>>>>>
>>>>>>> If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
>>>>>>> the domain below it, why would we assume that BIOS retains ownership
>>>>>>> of the features negotiated by _OSC?  I think we have to assume the OS
>>>>>>> owns them, which is what happened before 04b12ef163d1.
>>>>>>
>>>>>> Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is disabled)
>>>>>> then all the root ports and devices underneath VMD are visible to the BIOS
>>>>>> and OS so ACPI would run on all of them and the _OSC bits should be set
>>>>>> correctly.
>>>>>
>>>>> Sorry, that was confusing.  I think there are two pieces to enabling
>>>>> VMD:
>>>>>
>>>>>      1) There's the BIOS "VMD enable" switch.  If set, the VMD device
>>>>>      appears as an RCiEP and the devices behind it are invisible to the
>>>>>      BIOS.  If cleared, VMD doesn't exist; the VMD RCiEP is hidden and
>>>>>      the devices behind it appear as normal Root Ports with devices below
>>>>>      them.
>>>>>
>>>>>      2) When the BIOS "VMD enable" is set, the OS vmd driver configures
>>>>>      the VMD RCiEP and enumerates things below the VMD host bridge.
>>>>>
>>>>>      In this case, BIOS enables the VMD RCiEP, but it doesn't have a
>>>>>      driver for it and it doesn't know how to enumerate the VMD Root
>>>>>      Ports, so I don't think it makes sense for BIOS to own features for
>>>>>      devices it doesn't know about.
>>>>
>>>> That makes sense to me. It sounds like VMD should own all the features, I
>>>> just don't know how the vmd driver would set the bits other than hotplug
>>>> correctly... We know leaving them on is problematic, but I'm not sure what
>>>> method to use to decide which of the other bits should be set or not.
>>>
>>> My starting assumption would be that we'd handle the VMD domain the
>>> same as other PCI domains: if a device advertises a feature, the
>>> kernel includes support for it, and the kernel owns it, we enable it.
>>
>> I've been poking around and it seems like some things (I was looking for
>> AER) are global to the platform. In my investigation (which is a small
>> sample size of machines) it looks like there is a single entry in the BIOS
>> to enable/disable AER so whatever is in one domain should be the same in all
>> the domains. I couldn't find settings for LTR or the other bits, but I'm not
>> sure what to look for in the BIOS for those.
>>
>> So it seems that there are 2 categories: platform global and device
>> specific. AER and probably some of the others are global and can be copied
>> from one domain to another, but things like hotplug are device specific and
>> should be handled that way.
> 
> _OSC is the only mechanism for negotiating ownership of these
> features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that _OSC
> only applies to the hierarchy originated by the PNP0A03/PNP0A08 host
> bridge that contains the _OSC method.  AFAICT, there's no
> global/device-specific thing here.
> 
> The BIOS may have a single user-visible setting, and it may apply that
> setting to all host bridge _OSC methods, but that's just part of the
> BIOS UI, not part of the firmware/OS interface.
> 

Fair, but we are still left with the question of how to set the _OSC 
bits for the VMD bridge. This would normally happen using ACPI AFAICT 
and we don't have that for the devices behind VMD.

>>> If a device advertises a feature but there's a hardware problem with
>>> it, the usual approach is to add a quirk to work around the problem.
>>> The Correctable Error issue addressed by 04b12ef163d1 ("PCI: vmd:
>>> Honor ACPI _OSC on PCIe features"), looks like it might be in this
>>> category.
>>
>> I don't think we had a hardware problem with these Samsung (IIRC) devices;
>> the issue was that the vmd driver were incorrectly enabling AER because
>> those native_* bits get set automatically.
> 
> Where do all the Correctable Errors come from?  IMO they're either
> caused by some hardware issue or by a software error in programming
> AER.  It's possible we forget to clear the errors and we just see the
> same error reported over and over.  But I don't think the answer is
> to copy the AER ownership from a different domain.
> 

I looked back at the original bugzilla and I feel like the AER errors 
are a red herring. AER was *supposed* to be disabled, but was 
incorrectly enabled by VMD so we are seeing errors. Yes, they may be 
real errors, but my point is that the user had disabled AER so they 
didn't care if there were errors or not (i.e. if AER had been correctly 
disabled by VMD then the user would not have AER errors in the dmesg 
output).

Kai-Heng even says this in one of his responses here 
https://lore.kernel.org/linux-pci/CAAd53p6hATV8TOcJ9Qi2rMwVi=y_9+tQu6KhDkAm6Y8=cQ_xoA@mail.gmail.com/. 
A quote from his reply "To be more precise, AER is disabled by the 
platform vendor in BIOS to paper over the issue."

Paul

