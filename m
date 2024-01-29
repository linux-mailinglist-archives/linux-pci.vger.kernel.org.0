Return-Path: <linux-pci+bounces-2703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024178401B6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C42C1F2115E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915F54FB0;
	Mon, 29 Jan 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrwvLByh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D773360B9D;
	Mon, 29 Jan 2024 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520585; cv=fail; b=afVtdK8uMiQZShtpsGsqJsB30T5eWlCWhqitHt2ZL5yMKNSmFwvrfUGS8KuT0L0HGHEx1Yl3Cj4pmjlBLnefUaxDmFK5RSQEr4Q0VU58Cwm3TU6mLT1XCNQAftKqGsoDQZ6HjvzuaFsyj7sv76Yl44lwC2Pdax/B5aCeJd8JWXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520585; c=relaxed/simple;
	bh=6oO9CnSScF1lTeGakSebP/OrRqWcZo4YyQ/pud/nYG4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gh00LixLtUKS5n/6qWlVppVGCtW9972MHY6vhfHG6YmFrz4WkCaUDk0SF8VuOlR4AeONQifcsq2/pRowrqBq9M75H5gQwl5C8thOjmQtlLiSgg+OOQ6w8yHLWlFyEJTI6AiQ0EW/YNx0u5jicxDos+4qmys5HDA/QkkJeDdBHqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrwvLByh; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706520583; x=1738056583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6oO9CnSScF1lTeGakSebP/OrRqWcZo4YyQ/pud/nYG4=;
  b=HrwvLByh/AfKEiaoe5H2CeDEkO8WSN3CaXKVn+9ndZH6VBRg1XcPFsTB
   byeFegia4HvPPNbMHC0xpYmw/jbKSahe8oKpS4qrRdhf0HvhXz3J6YWTs
   giGQ09vat1cjJT+C1sPjWPH696QAEry5eR264d2CJKYR7X72hNCvV2NWv
   dftu2L4L4hxS6+zGNGjU9LHJfXTu4oMb91Mg56Q3rb9wXpsHxAU277zwD
   hs28usZcQtg2i/DC45bFFSxxP4Vig9tmPd5rFyjKfP9mPd/2wzbCFvYR5
   cIuv/YbFj/2r3AEntafCEoYmulEvtwHlhA162TcTSb88JqyShDJNHuywy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2765156"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2765156"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:29:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="911009562"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="911009562"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 01:29:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:29:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:29:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 01:29:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 01:29:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/NXq2V3euXwrecRsHPyl1tyVCAUHoHylYf+z+IYRa57lDLaz+yFj+NEkq/cnxPTSMvJEcoMlSPacAaPRJUQFI4V1rbzkKHKxIrtYnmBUz+UuTBE/19xYOhgKD1C1LKl6j93K1zR2ucJrz3KWTY8cuI02T9QcRRc2OoW2ylcih9knJPOZPaVf8h/A5iiZqx/VO6nI5uqffGib87l9SzrQlpCtgOjAQCxlNThndnG2RUAksQ/8JozaM+CpGMnfxPXqX1u1m4ufl70Dsf7teZNjspek/S2cdmGqX9h8eN6mqHqT1zQXMh/oBdlKPDt+yv91OdLtkwVwv9dKYVbSd2Peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POsgSOT5JRfZV05d8XjRQOoExXRBx76fAPMHTUC5sQM=;
 b=HDNrBbK3wmXMZCqpKAuKecTBOcBG1ZhhgQXrnwR4I9mflqV0FEyQekE1nbs6chXCVONAzkOS8atp1q93h87PhZO/ik7oDlhmUE/dG4UVtGKvFvS20VBQIJR2mXah3wcgDVzaIUL47vNrSmWbETB/Whu02PBvycvoRkWja5bSgBTPkGzugaLbnWZKxBKbZKrvqoADA/wKhyqmbC7tZiN2uW/cL8cXYlyKsEgE3k13tztghUV5Pmx8iQmhKCjOSQskcf3/G0exxGb4VQlvv2LaC10PcLV3bXVVq+WNsOj/nNeWoJ85ffXJ1GNmuO+A0reyc0YzZv6WDBB+9FwmClvAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Mon, 29 Jan 2024 09:29:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:29:37 +0000
Message-ID: <62f9ad7b-eaad-4a73-856a-78b30817b0d5@intel.com>
Date: Mon, 29 Jan 2024 17:32:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/5] iommu/vt-d: don't issue ATS Invalidation request
 when device is disconnected
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, <baolu.lu@linux.intel.com>,
	<bhelgaas@google.com>, <robin.murphy@arm.com>, <jgg@ziepe.ca>
CC: <kevin.tian@intel.com>, <dwmw2@infradead.org>, <will@kernel.org>,
	<lukas@wunner.de>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Haorong Ye <yehaorong@bytedance.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-3-haifeng.zhao@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240129034924.817005-3-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 05de36ca-6139-4d58-2717-08dc20accff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SA05WESVXEukORMaj3qAiPbO1AbNEpaG3MOre1GKGDHJdML0vqLJYpT2jd2mB6Ir864PB4qPKcXP9P1EtIksqWYfxS+sIkzLIYM9Fw+OaP9OL5ZSpIOLJYVhQugEWuSesHls4mtY7E03ffRw3yFxQ17nlNUuPebYrCdKWptaluqhEj5m6kxTYOyMalAgRPWjjN2gV6ZSbWoz58pXv4Ypa663gdEBewoKPnjHg3aj0rThy4N3DY1uODjx9VAnxupR74gAs/aQWU3bvGzPu4+clu5064kG41SFsAK9iBjaZu/JnJQfTcnTNfVlLQ3cMiLnYXYAHi4l8gYcmjIhe4wbJlruyPWg20rKC5E9zXcfrw6d4GngriyPCENl/cN1xt0W674TkAuGAucllsP7yyrQxH5w2eYeYnNrAICN9MROzp2CTuGes2RGhZmGKSAl+olyH5S0/ZQmDxgLC6uCqjymc1viWpX0vuuopM16+XbMuuneOUk63r/F009HBXxS8t1FrCNAoqy57abXzEnJ7T+AcxWg+iNZDzv5YEToQYf0/nQPHPmCzix59v0VhEtUqWJwcB/JJ6b1lQUUS8FqZOH6XDNOOUrrAQfeL4CaAOs7VtjjaiEWeUa7INuXo+ONiSkoU5GfbNnmpC0mjFpqXlLyiVOKpdakZ8iI7+M8H0s1FbxK++kdwhGwljlJeMaespXF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(86362001)(82960400001)(38100700002)(83380400001)(26005)(2616005)(6512007)(478600001)(6506007)(53546011)(6666004)(6486002)(316002)(31696002)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(7416002)(2906002)(5660300002)(36756003)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCt3ckdrclc3M1k4Q2VDYmREdHd3T09qNkR4ckgxRGNzdFhNd0s3SE1DUnNo?=
 =?utf-8?B?Wm1JQi8yQjVkdXJmTTUvZDRqZlZDckhETzVVdGpPKy9PSzVzblBvV0F6RGEw?=
 =?utf-8?B?N1gzOFU4WDBjSUp0Umh4dmh3Zm0yajNlT3N3ZXF2RmxIWGhIZ3BqYnhZK05u?=
 =?utf-8?B?ZDg1VWlCcjcrODhPMitHbExwbVlUZTNjVy9LQTVmOWROZEFycFVYZGZibTYv?=
 =?utf-8?B?UWJEZXZJd2ZiYkdxbEZKK2RuZnRkWHBOSEdCQkhwQkxZbFBSSUlFSkptMGxO?=
 =?utf-8?B?Vm96NE1oYUFaUjJScTh1c1hjMHphcGVVTlNwWXAvazBaM2QzbnpqbE1TS2ha?=
 =?utf-8?B?cGk4R1MxTHZwdjg3K2FBVGxZdkRjVmt3ayswQVlKRFRUUFhLVEZtVEFGZkNU?=
 =?utf-8?B?OVB0TVhWRDk1czRCM0puV2M5V2J2S2tJN2lMWUFJNytCUGRVUmRIM3ViUHFZ?=
 =?utf-8?B?Nk1oZFIwT1VDb1Z5Uzdib2Z3amIxU3ltM1NCS2E1T3ZiZElYQ0NlUUp1MUJF?=
 =?utf-8?B?K1VMTWk0dml3VUhkZ3JRWVR3Q3FKK1Fjd2tmcCtQNTJjeDJ1aWlyaWFiR0dN?=
 =?utf-8?B?c2g4YXVwWFk1d2FBWGhUR0IrMTIyYmxRRUpLZllSNTRueEJaM012dDEwMzNF?=
 =?utf-8?B?S1gwWlo2UUlLdE9lWDBJNjdjZUFJa0VnWjNaVm9oR04rbkRxejd0Zmx4eldP?=
 =?utf-8?B?d1JwWTBHeUZBZ0FkZ3VQL0pBR0cyL3BhN1VLOW9mb1F3dXRJbkJYREpwSHhq?=
 =?utf-8?B?cTJudDZZbGNoMlhnSDI4QWYxTURXZWxIbzVQNmRBQ0RhaFNiazczRVR5SnhR?=
 =?utf-8?B?WERvZFJMb3ZqcHNScmk2cHJ4ZElDdUhLN081VVM5U3JOaE90eHNSRytjeWI4?=
 =?utf-8?B?WnZneWxuejhFRkFIY21lUTJuN3hBVkVyNWxnTWJOWVFJQ0o5anpYUHpQZjlj?=
 =?utf-8?B?dk9nbEFpTkZ6NnNpVWRiczNwd3RmaEw5YXRJbHNEYkxqMFFUcWxLdkFtemV1?=
 =?utf-8?B?aXpEQ0dKZmVxcDRrYTlSRDByQnpmaFJ4a2tqSHhkL2pCdGQxdmllMlBRUVZY?=
 =?utf-8?B?bzgzV3NuRFFCSk52T2FmcGt0MGxWVXZMUzBDTUlDZnFsamxxS3R6aG5wckVy?=
 =?utf-8?B?WTNWZjlRQXFlVy9JZnpoYkRkeW9rWWhvNU5EdlZTU3B4bXVQeHpsQ3dWckpF?=
 =?utf-8?B?Y0ZETEZMVHUzemVHbWF0eXB0TWZkeXIwaUJiUzFxUGtTamdkY1JzeWJCVnFZ?=
 =?utf-8?B?S3pLbzBmdldQV0lKekNSdGh1bG1JWVh5UkVGdnR1V3JkZE5Td1FodHJZdXpz?=
 =?utf-8?B?ZnQ1RDBtNzF2T2dyeE9YYmZBMVErZGFrQVg1ckw3VU1rYlRVUkpNd1FVUDNk?=
 =?utf-8?B?ZDBMQXNXOXp1QnRDMWt4aXNjSTNtaDFVR1h1U1EydlNsRUxKd2xHVUU3b2lh?=
 =?utf-8?B?akZ4bnBjS051NW4rNDZiUGZtQ3FKakFUZldyTHRmNVdRRzNxOUxmRFpjWVFS?=
 =?utf-8?B?ZGpZOS85QUlPZ1p6Zk9zL2pnWVBBc2ZtTkdLYlpLOFNVQVpXajA2bTJSMXBy?=
 =?utf-8?B?ZGZDaE9TWkJTcG1pcTI5a2NaOVk2RjN5L1RzR1ZnVTFnZEFzV05xYUZNeGdB?=
 =?utf-8?B?ZERHSW9jRUw1dENBVG05NTQ1akNJNDRtelFkMi9zZllwbkpUcGV0alhwcTFO?=
 =?utf-8?B?dXZENXdPeFMwc1d5K2xGdDdnTllZZUY1OUZjRG5kODVYVi9IbHRxR2F0R2I1?=
 =?utf-8?B?dmtyUXpOREFsOUN6SHlLRktQZDAvTWZuSXdtVXM4QlpRejhIcVVWTHEzeHcr?=
 =?utf-8?B?MzBTSm1pV3h6cmpTakU2QU8wdDE5UTYxTTRVL1lCM0JTSmZSYkgwVlU4aHZv?=
 =?utf-8?B?RTJ2VzhzZ09yMnJBTm1mUmJXZEtTQWs5aWlrbjBvSFNScHZZYXNFR3JTbTZM?=
 =?utf-8?B?dCsvM1Z0UmtrL2J6dUpPdkFieEF4WFJOY09WWG5WR2toL25ubWhWeXE3R2FS?=
 =?utf-8?B?TGxuN1lLOXk3clZNb3B6eE9NSXA5Z0g5OTJJLzJsUy8veTJMOXQ2U0RXT3dw?=
 =?utf-8?B?aURrYTFENlpSUGs4ZlljRitIT1ArQkptR1ZLcU5jdjRJZmpnc1BVa3BzMFMy?=
 =?utf-8?Q?SGdXXYLanSWxhwkuCF+uw/16a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05de36ca-6139-4d58-2717-08dc20accff7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:29:37.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YS6iQjH1pig+cpTKkBK6K8XM7/YYhRjXlO7YHu3gCqL3PnGMYyyXKPY6ypYjz4WfyXLrv66+R9I66jB62O/dPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com

On 2024/1/29 11:49, Ethan Zhao wrote:
> For those endpoint devices connect to system via hotplug capable ports,
> users could request a hot reset to the device by flapping device's link
> through setting the slot's link control register, as pciehp_ist() DLLSC
> interrupt sequence response, pciehp will unload the device driver and
> then power it off. thus cause an IOMMU device-TLB invalidation (Intel
> VT-d spec, or ATS Invalidation in PCIe spec r6.1) request for non-existence
> target device to be sent and deadly loop to retry that request after ITE
> fault triggered in interrupt context.
> 
> That would cause following continuous hard lockup warning and system hang
> 
> [ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
> [ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not present
> [ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
> [ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
>           OE    kernel version xxxx
> [ 4223.822623] Hardware name: vendorname xxxx 666-106,
> BIOS 01.01.02.03.01 05/15/2023
> [ 4223.822623] RIP: 0010:qi_submit_sync+0x2c0/0x490
> [ 4223.822624] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c1 48 8b
>   57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f6 c6 1
> 0 74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
> [ 4223.822624] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
> [ 4223.822625] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 0000000000000005
> [ 4223.822625] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: ffff9f38401a8340
> [ 4223.822625] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 0000000000000000
> [ 4223.822626] R10: 0000000000000010 R11: 0000000000000018 R12: ffff9f384005e200
> [ 4223.822626] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000000004
> [ 4223.822626] FS:  0000000000000000(0000) GS:ffffa237ae400000(0000)
> knlGS:0000000000000000
> [ 4223.822627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4223.822627] CR2: 00007ffe86515d80 CR3: 000002fd3000a001 CR4: 0000000000770ee0
> [ 4223.822627] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4223.822628] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 4223.822628] PKRU: 55555554
> [ 4223.822628] Call Trace:
> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
> [ 4223.822629]  intel_iommu_release_device+0x1f/0x30
> [ 4223.822629]  iommu_release_device+0x33/0x60
> [ 4223.822629]  iommu_bus_notifier+0x7f/0x90
> [ 4223.822630]  blocking_notifier_call_chain+0x60/0x90
> [ 4223.822630]  device_del+0x2e5/0x420
> [ 4223.822630]  pci_remove_bus_device+0x70/0x110
> [ 4223.822630]  pciehp_unconfigure_device+0x7c/0x130
> [ 4223.822631]  pciehp_disable_slot+0x6b/0x100
> [ 4223.822631]  pciehp_handle_presence_or_link_change+0xd8/0x320
> [ 4223.822631]  pciehp_ist+0x176/0x180
> [ 4223.822631]  ? irq_finalize_oneshot.part.50+0x110/0x110
> [ 4223.822632]  irq_thread_fn+0x19/0x50
> [ 4223.822632]  irq_thread+0x104/0x190
> [ 4223.822632]  ? irq_forced_thread_fn+0x90/0x90
> [ 4223.822632]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 4223.822633]  kthread+0x114/0x130
> [ 4223.822633]  ? __kthread_cancel_work+0x40/0x40
> [ 4223.822633]  ret_from_fork+0x1f/0x30
> [ 4223.822633] Kernel panic - not syncing: Hard LOCKUP
> [ 4223.822634] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
>           OE     kernel version xxxx
> [ 4223.822634] Hardware name: vendorname xxxx 666-106,
> BIOS 01.01.02.03.01 05/15/2023
> [ 4223.822634] Call Trace:
> [ 4223.822634]  <NMI>
> [ 4223.822635]  dump_stack+0x6d/0x88
> [ 4223.822635]  panic+0x101/0x2d0
> [ 4223.822635]  ? ret_from_fork+0x11/0x30
> [ 4223.822635]  nmi_panic.cold.14+0xc/0xc
> [ 4223.822636]  watchdog_overflow_callback.cold.8+0x6d/0x81
> [ 4223.822636]  __perf_event_overflow+0x4f/0xf0
> [ 4223.822636]  handle_pmi_common+0x1ef/0x290
> [ 4223.822636]  ? __set_pte_vaddr+0x28/0x40
> [ 4223.822637]  ? flush_tlb_one_kernel+0xa/0x20
> [ 4223.822637]  ? __native_set_fixmap+0x24/0x30
> [ 4223.822637]  ? ghes_copy_tofrom_phys+0x70/0x100
> [ 4223.822637]  ? __ghes_peek_estatus.isra.16+0x49/0xa0
> [ 4223.822637]  intel_pmu_handle_irq+0xba/0x2b0
> [ 4223.822638]  perf_event_nmi_handler+0x24/0x40
> [ 4223.822638]  nmi_handle+0x4d/0xf0
> [ 4223.822638]  default_do_nmi+0x49/0x100
> [ 4223.822638]  exc_nmi+0x134/0x180
> [ 4223.822639]  end_repeat_nmi+0x16/0x67
> [ 4223.822639] RIP: 0010:qi_submit_sync+0x2c0/0x490
> [ 4223.822639] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c1 48 8b
>   57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f6 c6 10
>   74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
> [ 4223.822640] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
> [ 4223.822640] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 0000000000000005
> [ 4223.822640] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: ffff9f38401a8340
> [ 4223.822641] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 0000000000000000
> [ 4223.822641] R10: 0000000000000010 R11: 0000000000000018 R12: ffff9f384005e200
> [ 4223.822641] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000000004
> [ 4223.822641]  ? qi_submit_sync+0x2c0/0x490
> [ 4223.822642]  ? qi_submit_sync+0x2c0/0x490
> [ 4223.822642]  </NMI>
> [ 4223.822642]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822642]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822643]  dmar_remove_one_dev_info+0x3e/0x50
> [ 4223.822643]  intel_iommu_release_device+0x1f/0x30
> [ 4223.822643]  iommu_release_device+0x33/0x60
> [ 4223.822643]  iommu_bus_notifier+0x7f/0x90
> [ 4223.822644]  blocking_notifier_call_chain+0x60/0x90
> [ 4223.822644]  device_del+0x2e5/0x420
> [ 4223.822644]  pci_remove_bus_device+0x70/0x110
> [ 4223.822644]  pciehp_unconfigure_device+0x7c/0x130
> [ 4223.822644]  pciehp_disable_slot+0x6b/0x100
> [ 4223.822645]  pciehp_handle_presence_or_link_change+0xd8/0x320
> [ 4223.822645]  pciehp_ist+0x176/0x180
> [ 4223.822645]  ? irq_finalize_oneshot.part.50+0x110/0x110
> [ 4223.822645]  irq_thread_fn+0x19/0x50
> [ 4223.822646]  irq_thread+0x104/0x190
> [ 4223.822646]  ? irq_forced_thread_fn+0x90/0x90
> [ 4223.822646]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 4223.822646]  kthread+0x114/0x130
> [ 4223.822647]  ? __kthread_cancel_work+0x40/0x40
> [ 4223.822647]  ret_from_fork+0x1f/0x30
> [ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 (relocation
> range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Such issue could be triggered by all kinds of regular surprise removal
> hotplug operation. like:
> 
> 1. pull EP(endpoint device) out directly.
> 2. turn off EP's power.
> 3. bring the link down.
> etc.
> 
> this patch aims to work for regular safe removal and surprise removal
> unplug. these hot unplug handling process could be optimized for fix the
> ATS Invalidation hang issue by calling pci_dev_is_disconnected() in
> function devtlb_invalidation_with_pasid() to check target device state to
> avoid sending meaningless ATS Invalidation request to iommu when device is
> gone. (see IMPLEMENTATION NOTE in PCIe spec r6.1 section 10.3.1)
> 
> For safe removal, device wouldn't be removed until the whole software
> handling process is done, it wouldn't trigger the hard lock up issue
> caused by too long ATS Invalidation timeout wait. In safe removal path,
> device state isn't set to pci_channel_io_perm_failure in
> pciehp_unconfigure_device() by checking 'presence' parameter, calling
> pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will return
> false there, wouldn't break the function.
> 
> For surprise removal, device state is set to pci_channel_io_perm_failure in
> pciehp_unconfigure_device(), means device is already gone (disconnected)
> call pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will
> return true to break the function not to send ATS Invalidation request to
> the disconnected device blindly, thus avoid to trigger further ITE fault,
> and ITE fault will block all invalidation request to be handled.
> furthermore retry the timeout request could trigger hard lockup.
> 
> safe removal (present) & surprise removal (not present)
> 
> pciehp_ist()
>     pciehp_handle_presence_or_link_change()
>       pciehp_disable_slot()
>         remove_board()
>           pciehp_unconfigure_device(presence) {
>             if (!presence)
>                  pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
>             }
> 
> this patch works for regular safe removal and surprise removal of ATS
> capable endpoint on PCIe switch downstream ports.

this is not the real fix. So this series may focus on the real fix (avoid
dead loop in intel iommu driver when ITE happens), and in the end add this
patch as an optimization.

> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
> Tested-by: Haorong Ye <yehaorong@bytedance.com>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3239cefa4c33..953592125e4a 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -214,6 +214,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   	if (!info || !info->ats_enabled)
>   		return;
>   
> +	if (pci_dev_is_disconnected(to_pci_dev(dev)))
> +		return;
> +
>   	sid = info->bus << 8 | info->devfn;
>   	qdep = info->ats_qdep;
>   	pfsid = info->pfsid;

-- 
Regards,
Yi Liu

