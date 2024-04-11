Return-Path: <linux-pci+bounces-6101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66D98A04D3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 02:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1C81F24AB9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437F23BF;
	Thu, 11 Apr 2024 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MO1kGFb5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05140A48;
	Thu, 11 Apr 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712795517; cv=fail; b=DLIMCf3+Zdggfh6OqopVZAgmTdMiV3wZyt6mhsvbbwPrY1ixBjc0jnuXxi3/PfZHOMG16w4PS+5Iu1A4EjQvsIHiXd09on0EhkJHnSX6S1t7M3jPfRppZo+7I9LMY9wuzqX10oD91YtdUmuWISV3r5bo0M1w/y52+VjYUggJ+AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712795517; c=relaxed/simple;
	bh=x5wuhtquJcxCkMdGlYscdxhOFW1RG4pRtxvRVVTfCoo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UL+BNwzTX9EGnJndAMOx959DgnRiAuUR9itDlc7c+bGjbsdKowXHkjairy5zAHaJtlzNkT7g8JoAvFOUukFwiqd/dhSHORGrTuCE77PGJdvDL6uYOr0UuWMFnfpXP3vjxsUk5t/hnsklPiy65VxfG3HRGi1t6pbsHQpWTR3b1AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MO1kGFb5; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712795516; x=1744331516;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x5wuhtquJcxCkMdGlYscdxhOFW1RG4pRtxvRVVTfCoo=;
  b=MO1kGFb5qMem+g8M6tBA0zS8n2/zTI8x5582nccY5LmVyhDiuIEhMlKK
   s4h2tquKH2cXNDu/eLj26tWN8GyAaiPNynSup4tyGBRbHfrHGwNdqloKm
   LrwqDYjT8367ZAQGEw+5/m9jDKDrD4T4/DLEpnxphJQVmiPx16Fm150aC
   UqS9Y7UsKHlbd2fwoCsP9PUsRuI1mf44AbzsslAL4KyFKBYOXEO6YuEOh
   KVpSI0uJlxeNZN638IR0l09JIlfSTwgp7qLKNi+MP5zV5/ATxNU3QNVEs
   87FnRnWKGAVmGvGiXkOTBp1gxMaMAx5e16RuYdwH4qmZyMuzjDnpgMi2g
   w==;
X-CSE-ConnectionGUID: BQ1DyhZAQEy79u1FbCv5yw==
X-CSE-MsgGUID: XfQ9xf3/RdaoKg5oLO5GTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8043675"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8043675"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 17:31:55 -0700
X-CSE-ConnectionGUID: zm5e09awSluMpV+ZOKvadA==
X-CSE-MsgGUID: 4ndKYWu7QcOcHVL2fDZnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20734063"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 17:31:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 17:31:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 17:31:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 17:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMoLXGh5mNNcNM3wEapbE7SGRg+Ma6X9wf7EACG/cnBSNwVfum1EEd1HETPcT/lGxsHDEyZJnDYmg9QzscTBBri1WiECrwwjIk6FCghvwNGAcwWOh9ZLAaKWLQO9GwqsvLanByei+GBEZ65Ta3EDsjOyt4Gaqf55KUKe7IQSFxw4puz6Gy7DpcBEgfP0X31w9y+ByMiQKrhGqhh0wUW4oBAC3ULbW7ugtmAB8hKWCOUJS6E7/Frirxan7d5XQNHFWCix35Yl0PageTkpKYemXZJt6nIS65BIUfjZzAN0enC72mGoZcaFD6BusdmQAp0Z6KZ+PWbwzO2U4D6Hxuc0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGM3WIFPYEKJrKI+00eblX7QlamtfnJ72iCxQEGgd0s=;
 b=Ijf4QYf6GLBHzdByVsswg6QulCmWuXBIQB6PpIybUcfuvD3aXl84hNZrlI3yFNwVqfjGNK+4KGB5SF47ypSKXWcfhzNOGTtx2FIvz1MWMQhJEjdc+QsYbn+Y2Gfu8OCGpX/sa7NSBDLiTqUNSyB53zvyrik0Q2MHBn8SppmnG/GcafRHjaDwqFYUwVr1m14AAdnRLjLtf5rW14xxZ1oXzJG9+AWib5drmnpgXWJKzNxIRFRLyhxXFlbm/bm42r0X8rJsMTSSwWbLw8o2bEPxkDDEtazXKY95ja1SXHnN6r14EY0h+zc6YnCoXptW1O+rjfLyn3ijVuX2cIzjG66mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 00:31:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 00:31:52 +0000
Message-ID: <06e02e6e-71a1-4966-8fd2-0151e358e465@intel.com>
Date: Wed, 10 Apr 2024 17:31:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Andrew Lunn <andrew@lunn.ch>
CC: Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	<pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Edward Cree
	<ecree.xilinx@gmail.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	<netdev@vger.kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <6615adbde1430_249cf52944@willemb.c.googlers.com.notmuch>
 <ZhY_MVfBMMlGAuK5@nanopsycho>
 <885f0615-81e8-4f1f-9e97-b82f4d9509d3@intel.com>
 <6a775533-bd50-4f57-85f7-125c107bd77a@lunn.ch>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <6a775533-bd50-4f57-85f7-125c107bd77a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIoWE8MaHZvM53gBnHFZJ/8Sgx3mmrJGSA7kcJf4T6MW/tCmRQLU4aCItJ6JNk6QBdJS5wdzseZ6hezGASJ2J3rO5s33sdXEMrl1+yckYXygH0eLIz+PsdntPhLTqLZ7g4ZupXB+M8HQdxp+Si2FyIueJAHfU6dxeEqbKqR42OHcVTCHVeM1OBLKal+2MM443b+bHp+p/Z68YiCZZbGqcdLstaxPTB0lj5TrGyND0szaVT1gbosox3EjaXAiIskVCovEp+ngi3aKPhAf2Zg75MBgnbbUWxxi6xQFCsl2U7pSV1ZzKoblQeZ1xZYxaDVC5WS0jZjoI/GHi2lwV/PuPn0kavMVo05fG/+FWt2U5Bqr4qCrK/9G6qkjQtJp8C/IgVEuQ59d0Jbjrxat1ASVMsB/xb3tZ/iXTRfl4mzLiyegwujz7f7brOJ0v1x0b7/bEpbBA0I518oJ9sOZtzFe39Gj/N+GN0iX/ciGdXLm3bqV85OdMeKCmxh+x4cF5e5yGlgkZUw7mqgslMnVO4HlUi2hWk3H0voIJ/GA26cSnkOwoUtEZrfdqgLLvZOqzgrsMjmbt5pCZ4zWeADFSiAjyscYdtbadLanBjAN7k1WqLTIFQnxr588f1m2TK3mhTiPewH6M3UMmAZlwBKTntAQR1PljfPp9RuafMG+OYTgVX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NrbVZucVZFVmI5a2dTL2NZQ2xERnJzQ3BQOTJJVkxzTVljYndEMDJCRnpZ?=
 =?utf-8?B?VUwzcHZZR255WnIydzFQc0M3a3NQenZGL3lNeHBvb0VDWDMrZWtrSGVReUtY?=
 =?utf-8?B?Vnd0SVJqNml2SXpuOEZHZVZVWkY3YmZjSjVOWk1pN2lURW9uVEZIRzdrUUJF?=
 =?utf-8?B?Y3Ztc094ZmhSVkVDRURuMythQ0xCSE9KcTJqdkZrUGU5dXYrdXZzSWNMdXhF?=
 =?utf-8?B?UnpXTVRLODFJMVpvSWRidStEVFJ0aU0yZzVIS0p5MGJ4czhyYk1odlVXWDRR?=
 =?utf-8?B?bzhraW5tN0d6R2xmcklxMzgweXhWK1F4R2kxZGR4eUw2OFk3UFV6ZTIvVFhP?=
 =?utf-8?B?NWRISUVHZlQ2ak9lbkU5ZHlaSjJyVzhJQWtvU2N0TVgrWjdJaGZrTElSMUZ5?=
 =?utf-8?B?TXBCanprMWtTckpqM0Q5YlA1dTdFaS9sRXMwTEpIaXVldG4xa2gvREJKK21a?=
 =?utf-8?B?cWZSMkxvaVFEeW0wdDAza21mUHVUeVVaQVd2VkNIakVNQkswa3MvT3A4Yjk1?=
 =?utf-8?B?QlpPMlN4VHhibmthdmt3QldSU29iamZjUzVWTXV2bWJCRlFvNWxEVnh5YzV6?=
 =?utf-8?B?SG1pdHVQWU5TcjUvR2lHS3NNUVViSjRzalZXMjlPNWlCNGw1anU0WVhRRzhH?=
 =?utf-8?B?dEZWemdpSSt4YXpWRFBzZlVibkdQS3ltS0YrVnduam1INitlQmdWQlFXQVBI?=
 =?utf-8?B?anZBN0ZOVGZscFF5bjh4cUUyeGFYcGp3ZDBhRks1Q0tKS09Gb1h3c0xLcXY2?=
 =?utf-8?B?a0tKT3pRbUtoQVlVNythZ0ZBUUlKMEoyUWVvZ3NkbkVhd0xsTnRzQlJYcnBC?=
 =?utf-8?B?TitjVUM2dkk3czJ3emhTdEwzZmo5amVhejlQNGJlL0tvZTBjVC9lSU5qdW1T?=
 =?utf-8?B?Q1hKZHFZbWJBRlRVdHVsaEdTLzREZHlxdTRvME1SMFppeEtJTzVMY3lSN3hi?=
 =?utf-8?B?elpYMzdLa25yTjdjRnVvaHZZQUwvU1JqYTZLdFpsZ1k3NVJwVGVUOGlHMkdo?=
 =?utf-8?B?YVgzRXdMenJFTDhucW5GOGtLZU9mQWRDTGYvL2NnVWRGRit5RllsbHl0SEg1?=
 =?utf-8?B?UjFXSDRIMVBOYkF5Rm1VWktHOGt2dFg5bHZpdnhwNk9pa0VpQnFSNFFtUnFX?=
 =?utf-8?B?dTU0aTNXdTdpZzZ2cHBVZmRNdkdRZnU1QUNhNXNsQ0hId3Z4ZEdsMVF1TytN?=
 =?utf-8?B?dGVwSXVrMzRtM3pOdkVSTzRLY0dIbENjY1B1Y0I5czk0c2JmaFVxMVlyWWs2?=
 =?utf-8?B?STFsaTVMQWZpYWw0bWFyV2gxMUhsN1pUaExod2NOanNvVExqdUJ4VWJ5S1Mw?=
 =?utf-8?B?Z2EzOWQ0UWtibmZhZjhKNnJHZnVsdlBpQlpsQlNILzRETUNMNzBYOXNHUlY3?=
 =?utf-8?B?RUhmbEExcU9ucWpiUmczVmNHVERFNkxFRENBVHlzWVRhWDhSSVJuZjR2ZnFi?=
 =?utf-8?B?VU1QYlU0LzZ3YThxdXVLUHpwaWZTQXlIQ2M3OG5WTGtCZlpVcGMzTW1WR0lW?=
 =?utf-8?B?Z3hmNUZTWnpSaHZZdmlJS2hFMjRzMjJwc3h4UFpUY0tjZlltS21McVRXSXBK?=
 =?utf-8?B?UlBYZzQ4Mkc2Z1Z3NzJVYTQ5WSthV05aeWVyZlUxWlBxcU1pUVF5YXdRejF3?=
 =?utf-8?B?d3J0UlhjYjBHQ01VRGU0bDhFeVpZL0QwaUgrMk53UEtYRDBzRktHWHZ6NXhE?=
 =?utf-8?B?VENGNkZITUJZMFo2cXpRTmRQeEU4UkE0dlZTOWFBU1dTUzI0Q2JURkwyU3Yy?=
 =?utf-8?B?R1dxWEg0NVlzcGdjaitDTFlQNGdLWFQ1Q1JTdm1GSGJEa2JUSE1zc1RqYW9G?=
 =?utf-8?B?SnB1SVZPcXBIbGVFVjlyY0pRd1RPMTZ2aEEvNkozc01ub1ExVm9JYWRrTDlv?=
 =?utf-8?B?WGRGLzcycE5USW9wa0tIbnF3dHpxM2YwY2ttMFBkbytralgzc3A2OHI1Zk45?=
 =?utf-8?B?R1FOcnQ3OThIZXYxVm14U1dwZytvRHh6c2pxZDM5SGV0QldRMHhXOXdYUGEz?=
 =?utf-8?B?RzVOSFFGOHVuS0ZSWGhLRDZoczdqMFMzTUZBeWRDdFppT0ZCTFR4QWNONHdk?=
 =?utf-8?B?WlI0M1RrVHRydmhscVNMOG80Z1VqbHVtbHFSMlFNOFdMMHA3dk9ZNngvRTkr?=
 =?utf-8?B?V1FsaWVIRUZwaW5JS3JCdWEyajdZQzMwMytrcG5uYWx6UnJGeHF5c3c3ZlJk?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13871f7a-d6d8-41ed-18f1-08dc59bec86e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:31:52.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HthbnrQn7ffqPn9XLlarNIuDOkncBHYA3B2eKDMKAaUIEru9XgrYUKbpO8XQ9R9kS+IU4Q5EsXCRLzxrO9mz3DJBbV+xUsUN8cyCy9ywP5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com



On 4/10/2024 3:19 PM, Andrew Lunn wrote:
>> I think its good practice to ensure multiple vendors/drivers can use
>> whatever common uAPI or kernel API exists. It can be frustrating when
>> some new API gets introduced but then can't be used by another device..
>> In most cases thats on the vendors for being slow to respond or work
>> with each other when developing the new API.
> 
> I tend to agree with the last part. Vendors tend not to reviewer other
> vendors patches, and so often don't notice a new API being added which
> they could use, if it was a little bit more generic. Also vendors
> often seem to focus on their devices/firmware requirements, not an
> abstract device, and so end up with something not generic.
> 
> As a reviewer, i try to take more notice of new APIs than most other
> things, and ideally it is something we should all do.
> 
> 	 Andrew
> 
> 
> 

Agreed. It can be challenging when you're in the vendor space though, as
you get handed priorities.

