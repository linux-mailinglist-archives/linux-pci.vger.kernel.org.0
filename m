Return-Path: <linux-pci+bounces-6086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E698A021D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 23:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D75B22968
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194871836EB;
	Wed, 10 Apr 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjGXiIvP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E5181D19;
	Wed, 10 Apr 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784616; cv=fail; b=mZZ6BUvmiD6pJu8zUsHZFq3CO8Tj5Z+fcwIPeLGuR5jj0tS98t2it4htUdhk9mU64WmUeCoGDvbfF70xJCMMhVFrRspbhxdLEc2aQjB/5mUOTzEN/AOaJGnDQik3gdPihjy8Xx7eBAMzoPZA/UCm52wwPepBh0CJcHq+Ze8VJag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784616; c=relaxed/simple;
	bh=EE96jmQR6YAwGT6akNvfBu4875lJW1qLTVUM0QtVtgg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GByzVrw4awQBwo5Zz+lWDmSSCL/Y55hBw3K8b36CwVqZYYVObcKEOYLDxlCqxv4ccnTNBZFouEzVchWlOtM++D+ZY13pgkDxaj0uPT4sbDxilNLcIIWmscq4W2n9gy778E1ijWahnG4eLkvKwNY89Lt2wztwQ183GX0YPlaGWH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjGXiIvP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712784614; x=1744320614;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EE96jmQR6YAwGT6akNvfBu4875lJW1qLTVUM0QtVtgg=;
  b=TjGXiIvPrnNFFsKD3c/o77egOFTDaJu3q8b+TrZEZ5TafGgQnHY40PO3
   Sq+fWp08hzn5OlgkqCy6we4FdC2HCVnVRql1rol8N4Fb7sz8nZW5W30Nk
   MXYSrQ+BLigDYSuWTsWLi5vjUvum5h/uO3KJfOF5BIObTsVbOma5yyDHB
   ry4YRr+U47/m1ZUY3yZrzFPc0OeTtrNcjVSWbs262xc5KUJ1IZgupqqOZ
   rOGAkTu7j8v44REarmao/koCJoHf5YDU+Z/JR/ZgNE8Y9ykRCM8qyrFAb
   /cWeBekeXQ8KR34rKHYFEj53dycqLMfnPfOGs6VesfVMw937WLE4SNTRD
   g==;
X-CSE-ConnectionGUID: Thl0mW0CRqe1mwMqVVoMAg==
X-CSE-MsgGUID: LyT6kjzpTjm+bu/Fc0R2Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30657476"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="30657476"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 14:30:13 -0700
X-CSE-ConnectionGUID: WTKhxh4mSRStYqPddo6ODg==
X-CSE-MsgGUID: xpM3l86WR4iGVY5miHwxdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="58114199"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 14:30:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 14:30:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 14:30:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 14:30:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 14:30:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqcH/Ct4iW371QXXLNrxquSekFlqKR3Nk8yOWsyETjUWnCPSq/wBy+wsMf4Om2MzqVJGFQmNXXmNa6d//U+qZDeXZTStaFKK4D0r8Ep0AU4fCIeqtMqNhozwKQ4AVZhjqqw5Vx669brQuWGWQAS4+OuYz2OZAZUtYb2zY+SQkNDQpTeso1gmtEDWTehIhjK/WP3LpIYm+4UaxgzjdiWTwnDB8C2cTxPoTx7Rky2/of6AJA5l3jd5AFCy2YKW5wRVQ76Rbb2MYmu1dsLIypuhUdNxDGzqzA7/azoCLXhWqkaIVJ0BKpTw7YWpFViawrkmCFN0Ra9AawgLLiNcd3vO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9KWfh+1KSCMfMXVyCB3iKSrFIzEdce6FUxbruJFHEs=;
 b=EoP2DKV+M+XrXDYvn8QFBaXGMfR1B4fJgzKd4lENeBBDmy1UHxw8+xCVGFNHZlbdqxK/kOo9zGUN000wEA/xlZlTicLdIkdVUXvJf5S2JeDxyGqUg0aeDjeF7VoWFGCvYLNyCcQ3xzhqFwG1Q2Os5m7/bZHF3TcAIzISVkG8rEfD76MkYUQahaETUqy8zH965HOHhj2bcYJtbZxKN6McFjsPkfVdfenZ86EQdQv4MYHpPqP1P5iVljKhbfBkjVe/qhCVH5vVwEbPwOVkMXvtw2jgqYap8R4MYEos4+ovmeEIgDkPJr/5gwnZESyQr05ny/m8kXI1Osv6+X0x/f5XhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8400.namprd11.prod.outlook.com (2603:10b6:208:482::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 21:30:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 21:30:10 +0000
Message-ID: <885f0615-81e8-4f1f-9e97-b82f4d9509d3@intel.com>
Date: Wed, 10 Apr 2024 14:30:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <pabeni@redhat.com>, John Fastabend
	<john.fastabend@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel
 Borkmann <daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alexander Duyck
	<alexanderduyck@fb.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <6615adbde1430_249cf52944@willemb.c.googlers.com.notmuch>
 <ZhY_MVfBMMlGAuK5@nanopsycho>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZhY_MVfBMMlGAuK5@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0278.namprd04.prod.outlook.com
 (2603:10b6:303:89::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8400:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piQnrfPDyJwnlXnviq5QRh8sFjsJlbmULYukEM3781yg6vDhd5+r/87UJfjOfEDjR+X7GbJXnZRGTVw26jQ3J/AJBZzEQqQwqNDIpsifyv8zslgI8SLyPlQSlxkubmKYxYYfuhRTL9Nz+nZW1ZSK64bGC6amUyNNz2yJZ7kwTUhrFo3irBBhL5RuwKO79ru5LqCyu+Hr6p28KIb1XHnnw9piA/KAb1s1A1+7djkpYMIARzQrleenoT8O2NUilVUMbp2NODY86G+Z29lXiq2v6yoTHbKCR/+am7zoMitJQiN41yOAtaQQOpSt7Ruzqeo6GbI8Jt6mvdn0j4B/7Q3JA3/9W4p6/e1k5vAYp+7GILTf0fj3m3s0IPSu0IJfB8fRKC3mMnHd2xri7rkY8HmVd58t97mTmt6R+TWKFQY5CfnJCCeu5ov235GGg3hdDPcOm774lhxwfp3LUcRKElKzXZHL0H6Y8k4T8rDOiSZao9iWfG6TLeaerYIyKJJuIEInPbxXRRI8IcCg3vn65G/1Aif9PP8UzQpu8uT0YzXL/pawJ65iFxahjPTbJIZybZPKaucuhdHagZ+FvvceIvaVaPFDwmDXOGhbPJSJYLYlRbKO7Aqo+QHQ4HdgXheMk5znFlXXXLH8UYgUg8dXWuMfi1V0OCcRt8WWYKxTP1cyKXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0E2UjFhUlJscWRQMFNENEhTckhMVi9xd2dGbjJUQUIwMW5nN3RwZWtvZGVU?=
 =?utf-8?B?eHJBYTg2T3NQU1ZrclROQTZVNTNjZFF4UHB2TlNkdW5NOGF3WjNudTh2aUxT?=
 =?utf-8?B?NVMzSlB1NVluM1lmYzJRNTVOOU0rSGM5aFIzZUFqcjZwZ01xOVlvcUJ3Q1lI?=
 =?utf-8?B?NFpIMWVZVjN2b05lKzVoTEJCdVA5UDIwRkVQN3V6dU1IVkZ0UGhYcnNJUExa?=
 =?utf-8?B?dkVJYXRVQUQ5K01rZ3NzZ3BtbUx4V1BqTWNjWXV0UmRaNlpqamZLWjVhT1Jq?=
 =?utf-8?B?VEV0Z1l0bnpoZG5CMm5XVU1JZzQ2T2U3WUxVb24ycnFIY0Z6SmZwVi9Db1JE?=
 =?utf-8?B?cFFCZytvTEVBSHdncXltaGpMNzNHMHhQVWFHSm9ydU81N3VuTjlSWms0Z0Fr?=
 =?utf-8?B?K1NzcEhvQ2RRa0lQZUZNQTlSbjZTd3Z3RUl0MjBZcG9iZTVOSnpEVW12YUJU?=
 =?utf-8?B?N21DVzM0UWpNeXM1Wk1iZnBkTTQvUzFqNWx3TmYrUHFKa3JCVUhLQStZQ1U3?=
 =?utf-8?B?QWVialVzYVJydDNRbHNCVnEzclE4cUJnbnV2T1U3ejAzQTJvaXdjek5DVFdP?=
 =?utf-8?B?ZDBhMUhaLzZkeWs0OVFxS0ZJNWZrQWUvTkpveGoyM051QkliT0dXdVZ4WWpX?=
 =?utf-8?B?b1gvMmlDNzhuNXRmK3JpS3A1WFNFMGxhOWZ5UkRtSCttOVJyNCt6QTh6MG5I?=
 =?utf-8?B?N0dzMU9iYTNJVjI0K1Vwekp1bXhTR28zUW43YWc1RnlIT1haQS9JMTRGTGVZ?=
 =?utf-8?B?UXkwVFRRbWlGalpZQnFjZU5MVmJSRXJvY25jbTlDQmEwVUNCTDZuMkU4aG9m?=
 =?utf-8?B?MTJrbFE4bmdDSXcvYzFHU0hNYVlsc3NEOVdwLzZ6MHpUaklFUGFqa1RxVGY4?=
 =?utf-8?B?SlQrWGlZZ280eUFhMTUxdTR6aEs1VU9Tc3AyQjZrdmJlemlJekNvSmhwZm9U?=
 =?utf-8?B?QWY0eTlCaW1vd2s0TUlONXE5cE1XMEZpZDdQckRLcXh0UG0vbVJyZ3FSS0Rl?=
 =?utf-8?B?MXUxOEkvZGRFdy8zaG5LWmN3bXJmTEhjYVE0M2toMWVTTGhFS1BseUZnNThQ?=
 =?utf-8?B?bUdGZ3AzSnVTbVd4NkhROTFyNURmNHNBN3ZFMCtWM1pQYkRkaHdPOU5CRkh6?=
 =?utf-8?B?OXAyV3o3VHp1bmdlekhkMDljRUt0dDNQUjhsTE1Wd0plUnYxZUVYcEdidXhw?=
 =?utf-8?B?aExES0VTckVoYmowcmtjK08vN1p0WGlJblloNlpuaENOV1hrSW91RmdiajVj?=
 =?utf-8?B?a0I1OU03ZVRydzVUa3V2UFBOYzFNemtPMDZLalZEMmVEeWFjaHYrSGpscUpF?=
 =?utf-8?B?cjJOVVpYNGxBREFRdnpITTlHbGJWRnNyUDV2OElLN00vRVVVczk4cUpERTFM?=
 =?utf-8?B?dXA3Qzl1Q3VDNlJVQXM2ZUVwT3lUWHBhTldZSktWK3ErUW50U0pXb3k4UU9V?=
 =?utf-8?B?S01DcUd0YS82WGlnWEJ0UEJxTWprZWtlWHNNUC9iZ1VXbDJ4K09IQlhYK0xC?=
 =?utf-8?B?dnR4RlZYa25SN051dk1KRWxqeXl0SVkrNXVHbmtlNVZVbUhRa3JVZUxSSlFt?=
 =?utf-8?B?R1JxV054ZDFGUk5mNWFqQklPQTcwTWtZSEdnVmFyRjJ1VHRtQ0tTTnFLZDJO?=
 =?utf-8?B?UnpGN283VnNzNmdTV0xkUjN5VWF6bnlYemVBRU5saUZmeUwwYTNyWHdsTklC?=
 =?utf-8?B?WWpBdDcvSGhGQ2VUalZmQ1hWNXNpbERvRENKYnhYK2hmdGkzU1VCcDd5YnpS?=
 =?utf-8?B?L3l3aG9mcnpqUmpUSU1UVXZHcWRCd2FITHFEQmpqVldGZkFSaUZjSzJhRElm?=
 =?utf-8?B?dmNUTGI2NDhjODhsNWZMcWhmVjA1SnFlQk1TRVYzZVphNkIrUHZIYzFkbk82?=
 =?utf-8?B?dXFJMU9LS0JJc1E3QngvcC9Eb0Q0UnA5YVcySll4NzdQR2pBb2VjeEoyNE42?=
 =?utf-8?B?bjRMcXZZMjZuWGV5aTVkSVhISys2TjdHVFFnZC9WTzJ5VmU0Mm1hdDNPZVh1?=
 =?utf-8?B?WVVRWXFFQ0pqWmduTVpkb0lQU3EraFVXYjQ0S0hHR3JscjFUcUVjLy90WVJ4?=
 =?utf-8?B?ZmJoZFc4R2ppTHhBcitsOHB3SEdFWXNxTEs5eHZENmdwOGhsUS96Q1U1SzhJ?=
 =?utf-8?B?NTJMeGM2VmwwenRtK1BKZUxtTkd3b0hVVWVJenhyOHZzekNlVmJuNmdqVEgv?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adb75ef9-bc3f-4957-39dc-08dc59a5664f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:30:10.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRpg6Xvpxifq+4H349DKz0H2AhbdeV5Bf9wnzGZgkMcWgX6/J6uyzIYCwB2l2Nvq1+FiMmQK8lb4+lDSIFhJn5/EYmft1eQziQAkhEh/0to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8400
X-OriginatorOrg: intel.com



On 4/10/2024 12:26 AM, Jiri Pirko wrote:
> Tue, Apr 09, 2024 at 11:06:05PM CEST, willemdebruijn.kernel@gmail.com wrote:
>> Jakub Kicinski wrote:
>>> On Wed, 03 Apr 2024 13:08:24 -0700 Alexander Duyck wrote:
> 
> [...]
> 
>>
>> 2. whether new device features can be supported without at least
>>   two available devices supporting it.
>>
> 
> [...]
> 
>>
>> 2 is out of scope for this series. But I would always want to hear
>> about potential new features that an organization finds valuable
>> enough to implement. Rather than a blanket rule against them.
> 
> This appears out of the nowhere. In the past, I would say wast majority
> of the features was merged with single device implementation. Often, it
> is the only device out there at a time that supports the feature.
> This limitation would put break for feature additions. I can put a long
> list of features that would not be here ever (like 50% of mlxsw driver).
> 
>>
>>
> 

Jakub already mentioned this being nuanced in a previous part of the
thread. In reality, lots of features do get implemented by only one
driver first.

I think its good practice to ensure multiple vendors/drivers can use
whatever common uAPI or kernel API exists. It can be frustrating when
some new API gets introduced but then can't be used by another device..
In most cases thats on the vendors for being slow to respond or work
with each other when developing the new API.

