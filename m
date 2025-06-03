Return-Path: <linux-pci+bounces-28907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE3DACCD90
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69B33A4725
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD921E3772;
	Tue,  3 Jun 2025 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSaEFrAi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032E4C92
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748978466; cv=fail; b=PeSaDTU2pMMcON/C15yyQgNjCuwjyWBkjM/GV8QpJuR3agcCXVRjG8EfOtfTxI5WVQn87lcuSP34zvwmPWT9c01AX0tVjpm6Vl3Wt4Dn5YseeK9lFt8igVwHEkUyFraxUdylgl9AGHFJPHLpK9bN8BljjSP8droKm6MqMe979bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748978466; c=relaxed/simple;
	bh=uLbuLt+ECNXINrOeTIjpMnIj3pv8GK3z/EjWkMFNbT4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XKbxJzp7DUal6VMyB3lEtDoxxfMLT7YvQGH3iK+cJnwDIHTwvIpPd/flowkgsPWjGzCvHWRaiUY42ZYcFtO+vs4PwP59pVrTZZIP5RyLyUzhOXmIzw2X5Mg7SdOeBxKHS30juB/SfdhNNjj/BSy8I37DL1VNtUEGsbk3AlfUWTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSaEFrAi; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748978465; x=1780514465;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uLbuLt+ECNXINrOeTIjpMnIj3pv8GK3z/EjWkMFNbT4=;
  b=OSaEFrAiPQMqM0COZiUGpy3ZiA0jTQ3lBn+T3trvSNEOHr7wxBDjwcIX
   HllskNS3yi1YFcpwUBcB+fZb3TpSpiBvSgwzxuK31s0y7JPaQKd3WqnkM
   IRlHLmNUOjUgwTTYDheOuXT/VTZIEZJWZO+SkyEeJYQMKEIn9qW3cD5n8
   O1kMcDGznBf4SRlbHFwba1s37KYIo8gCHIzGavEiDuVUNl4O6MrMGuX77
   l0tBIp1WYgzZg/PiJbnRFLAjODPWs4AjEnbLlZ02baveftlIog6L/ZHIL
   2SzKupfw9PaMZjVoSBCeCrmpdqscfxAVqneuLm/C94CwkIPGd5y+xbd5a
   Q==;
X-CSE-ConnectionGUID: a3X5Gcg+RiyOm6ADHoRPjg==
X-CSE-MsgGUID: BZpRbDJXQea43mTp04r5Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50157246"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="50157246"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:21:03 -0700
X-CSE-ConnectionGUID: Er56XSu7SoOBnD6lLGy0bQ==
X-CSE-MsgGUID: ekA0SxDLS3WnFT4VqxH30Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="150249057"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:21:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 12:21:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 12:21:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 12:20:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBzGp883KFeaA+y7ANflJuUoTDKPa808g12wX9QJD3Dhn1PT2fJyWMpn6eudH49oQN3NTZN2YFPyF57+w3c4hi44pTG43UC+nrPITC9I2KYP7wcuFk5ur+Q/qHnkyy6lyT/1JqCMP3RFUGDXKNQSP2r/dme2dtb9k5+5eeXrSwcgAD+nsLGLsngaRTLolVjniipGtbo9I9veYe24bk+EFBrXlVBUqPKqrg3gGSeJg/HQfghPK5AjWNrzeZ/7CP5y+nVOz1+1WZoLgOFkENuVrCmgkrWETeSaJdxPeUjASoAQSw47u1k7EH1Rn+2hbOD50qR42NfywrQw6I77DW9faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4SyeetT08bOGoFa1Bi6m/Ur+3J4jkpWK7/V2oCWOWI=;
 b=PJehSkyQmc6E2bLP9+2osIQCIjHHKuMSMqvl/gJucrI0yeDAQuczkhDoNIYyBIdUwXNDbXustqUUuyay+Opr9TYKYrDZCcvfLC5QvEGUMtGqlNeAEEEszYSj3QBe47c8XmPz/tIQIFOJUVZmTreSByMIg4XalxnRNpLeK+gBSurELrJu7xho9BtJuG5SeSHAN7sBXgU8thLEv+K4igj0vQupGVaw45tqPqnXc2i7GcacJa/okxqpd7/NrFkcigwfWauXJxfKnSqsW0zOoCN65r4ehTBi4ckRtEI5410TjIpyAAAL93UUCVC73/5D8z3Ob3iN4Jjqffp2eFZWCjSMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 3 Jun
 2025 19:20:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 19:20:35 +0000
Date: Tue, 3 Jun 2025 12:20:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Message-ID: <683f4b01a58b6_1626e10085@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <aC3rM1LLmRPAGwFU@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aC3rM1LLmRPAGwFU@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: e168ef3a-7bf5-4bc1-3b52-08dda2d3b768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?53N8SL9G5UQpsoyKVjzUVLcYEYwWLu8gC6IAIzvvcLoPJZOpBHOGmpc1/0tZ?=
 =?us-ascii?Q?PhS0n3p/sKtNmGltrS3rVXyVcsg5jTDEQ27eVl+1au/UCmgxMrAgjtmtZ8be?=
 =?us-ascii?Q?xsFQ/PRX/rykN0G8LKQcntQEI6y3EIuOxU0ggNEBYr3b06gJ6t3natvl/fHJ?=
 =?us-ascii?Q?l2pjZvpcreJ7LHIyC40VoKTaoZ5WDNndwBVaNcAjCfewAeoCa9X7yys3130y?=
 =?us-ascii?Q?XKjU+BvYE8q1Ljj4ecY6KoOGtC+zYwqPnsZo5wX2+eG6AEHcTZKqbVCzg1Ui?=
 =?us-ascii?Q?O/PRD/zsxRUOV9JGOUQIiAR+M8BY9KiOquzjUf6oogMYADPSfpdGgd2J1GMl?=
 =?us-ascii?Q?dshSRASmX6QyeWg13djjDSl3lIVkN5zssle0Mrt9P8XOemdBl6/zv8pR5loR?=
 =?us-ascii?Q?bV9A8dEtEiiEAdf9eYDDC7/OFgjYmMlVg++wN2Se1rNQAe8FORKMlsfCJyEt?=
 =?us-ascii?Q?bMjR7RlTCTmUkxvWRT0whsr690FPrxW4k7/ReX0J2ZnL2V8eMw1ul1FI1oOq?=
 =?us-ascii?Q?RJ2KNr1PV9LHwKtRpKYKCgaxD3K9K77ytJht7H0PA1/P4My53jzdJ/rDmyer?=
 =?us-ascii?Q?daKuKJaqu+UsFKnh7ojc6m2ER4Jq0Lh7+YvynS9B276TVIjMYh713fHdZpZ5?=
 =?us-ascii?Q?m5loMKHXTtR3P0F5DSyg4QahBXtS9LfuntUPyjQjju05MpyxxGFcd/HRI60O?=
 =?us-ascii?Q?gPvtRWVotAmlsfGDUFGoBOXmsFCyRcG8PoGe/QJCsjtSJbtSY6O3NVd2kR5m?=
 =?us-ascii?Q?QWohQ48Kql/FVTkWQkwbDIR+5QTWvNLr5T95bHhRfu2uyYAdNK0L4dvo/p/T?=
 =?us-ascii?Q?5lxmwLts5VV5uRhdmFlEfPsaIcoYhqk007/LN8St05ZpemBbkD/wE12qnE/b?=
 =?us-ascii?Q?cgEUN5BOo54ZWE2jyDsGhPbXMuFOaPcXMzNsS6c463cou7QkFY2jRqZ0QzX4?=
 =?us-ascii?Q?StAxONVz20z1HY31mLq3yviGyrUrsZF8j2jJ7K3ma+daxVc5VDV1/nmjKPM4?=
 =?us-ascii?Q?u+FAO/2WiLo6uX7etrgJArqJAUx5jpCnPZIm7iVTadQETjsWeUGxKFUowk9P?=
 =?us-ascii?Q?ZRhIpmWOBPQH9sJcmn/CYhFL8zSlnUaYuWqDe+ECmaCqLPMLVai/NpNJa4cI?=
 =?us-ascii?Q?xlpbR1qZ9mUnQ+7AJeHvxV+Ef4rxhP/CYtemgsYhlV/xRQUh+U5/a8xsfAvb?=
 =?us-ascii?Q?4wCRuIx62EIEi8v3YowYgVjLLhdcNQ8rVG7NaNGtNCq5DgB56vRLloJ+8qzk?=
 =?us-ascii?Q?47d+HM25Eji4QDACvfLbg1U2YJQHG4q6804cF4gTfhS3KGLJFkCIv4p+511r?=
 =?us-ascii?Q?AOxl5VFlWonF3Y2sLMb5YXH2cAu3doNeh/b5rdK9jPgAt3pVYOpnx6dl8HKZ?=
 =?us-ascii?Q?qYqTgv20aQ/J5yvPj6vb2z+Y1z/Yq84qX+L1UyEoxejXZV7ipMNHClgjqhFf?=
 =?us-ascii?Q?RDLd5y4GJ1M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dfsIUT2dcQotBV1lYAZ+ggAdEmE3/W3wY4wO1jLcK+k6xnGxRUrPYGfBsZQI?=
 =?us-ascii?Q?8iG2WE2UFedHNYCXSuUIHfcqR+myscbK3UkORvoflm0qBV/RMQVSYhEHJq7E?=
 =?us-ascii?Q?ie+c7elm7rjKXSHDpugU4OhphxYzqrZeYOwN0W0DwxkRC0/YK1jG3djC1xxQ?=
 =?us-ascii?Q?C3zQanQnb/GayjuUcqhZp2jjUU5oOecjZVbTlqZK7nEwHCt1xjaMwCNn7xUg?=
 =?us-ascii?Q?8NTc7FYFA8GrmDvLS09AL3tsXQNgPSyGXSz4LVS4Y6Mue324spI4RKiIBJEG?=
 =?us-ascii?Q?wAKE18nIWT1fMvxBRyQymt1+4ydCCQbEszN6NKf6xHTXNApsThabG8nPULw+?=
 =?us-ascii?Q?GOmv/kbSclw79MCwKYKyYEVkYAtYl8qG2QnBAZD3tHylEU3bcXjnLIV6uhVV?=
 =?us-ascii?Q?tUfTTFH4ZVjNhbvtSZ/3rt7CjtT3GtxykiQkmvHxZTRDbqIkqSh42HMPSHsR?=
 =?us-ascii?Q?ox8TmOziPCjeEhX7p06MX0zmBcXa+vq4j/JOMo+88IBwFlNvkePMzzGjPYSm?=
 =?us-ascii?Q?Hw1YuHXywvHkl/gQ1Rycl2bbyHcG2TBlGWSMPoUl8/kM6taSa/kPClayLh7M?=
 =?us-ascii?Q?710EgbYgazOlMB4CTT0wqKDW3NLYkyrelQzNxovZZd4whbRM+wMerUINMqkR?=
 =?us-ascii?Q?sVwSRJAUI0//jKHmGSGB5AyURZB7kDCgIrtBjvEf/oiEmpUMzfclLUz9KfMo?=
 =?us-ascii?Q?z1H/TqKIIDF2l9lbG6QDwnvViYccapOEOjvONsinN9NCPymix2U38F4Iji0W?=
 =?us-ascii?Q?FqgGiuCOxBV9Z/SkLpBKOPZeYBdvuCsRoqDnsKz/FoCAe7+JP2+pL7FClenv?=
 =?us-ascii?Q?zicATj6ogktjfFQ+YDr9GN3speRcHimJbEy0eCxVqNqgv6TroBC8sL2KIwmj?=
 =?us-ascii?Q?XOiKz5Y1kWH5WlMIR2pPXTfOVj+rBZ8HOjDzFQ6XFokmiTAkskAq+5DLG3i3?=
 =?us-ascii?Q?oqPebLwo+2OxKfmAIhWYOHF6QbINuu0zmSJ68G1VhAm4FMx6Q6mMl3ZkvXSY?=
 =?us-ascii?Q?T47e8lKdc07lQmQru/n09Nr30VhSW46PM5AxAST2ydkamObgT6mmbZnRiUdI?=
 =?us-ascii?Q?FqupfIQbJytPSvHGC15t1LGxRog0k3jgpb4fw1uTDqlarse4q14N5pccTd5N?=
 =?us-ascii?Q?kWpjf6KYCIRjI05hoXBLcaIjlMO5cb3Oa3btI1rcq/zp1y1LY/kUMgx6wPfF?=
 =?us-ascii?Q?canBNe/JuoOUZzq8V98zlI0uCkE9W25wVy1c6T1BW3ZlcMR1VEpjKr76dvMv?=
 =?us-ascii?Q?ZhltDGFZszBcSr1VI94UCxzE3GnrjV6zsi9KBQ8Ce0v/GIagdUgS2eAWLjiU?=
 =?us-ascii?Q?35kmWXBBtdgF/4PfwsB0/KSKokc0fgFBnmNtvdArpU0QU/D0cCf7nmVHLdNa?=
 =?us-ascii?Q?XW+68YaftBgy9jWr56fBouxBdYl/QOvIbBTMtHu2nNomSpuDoowQAVKISvhs?=
 =?us-ascii?Q?0mKsyK+CSkBQNq7HMilCrA4IJ1hHaXSKVEimhCcc2VJfAUm0VPq9WGalZrJP?=
 =?us-ascii?Q?q7Gf5KUvvuSuz/rm4EsnQBLE2UlJqoFgy7gTDTLUiBacruYTJ8myeP5v2fB1?=
 =?us-ascii?Q?IDfr33lSNXGt7KKV9UkNlsUs07beh7fllf1Z6GAUu5/oTPi2QTxKieX0QN9S?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e168ef3a-7bf5-4bc1-3b52-08dda2d3b768
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:20:35.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sik5fMHE6DNNTZ8OvnwngpetM/Yz3Bcikqr0W664Aa8/OeBRqfi6Gb6Tflg0e0GCkzVXcrUPg5RFXZlWbfaJSCWp5v2JWrsdzxSdHYy70Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > @@ -573,10 +690,13 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> >  			return -EBUSY;
> >  	}
> >  
> > -	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
> > +	tdi = tsm_ops->bind(pdev, dsm_dev, kvm, tdi_id);
> >  	if (!tdi)
> >  		return -ENXIO;
> >  
> > +	tdi->pdev = pdev;
> > +	tdi->dsm_dev = dsm_dev;
> > +	tdi->kvm = kvm;
> 
> I think it is still better that platform TSM drivers assign these
> fields in ->bind(), just as pci_tsm_ops.probe() do.  It is
> inconveniente that struct pci_tdi is not initialized, then these
> parameters have to be passed again and again between functions.

Ok, I added pci_tdi_initialize() as a helper for low-level TSM driver
implementations of ->bind().

