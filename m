Return-Path: <linux-pci+bounces-37310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF3BAEDE3
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 02:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F57419414EF
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 00:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F094E182B7;
	Wed,  1 Oct 2025 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk6JH+qk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0819597F;
	Wed,  1 Oct 2025 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278255; cv=fail; b=WHxX+cgNZcJ+FpTHu5c4kQKkeTD+zbwLFpIJF9vZumPmk0/lOpv7yvfKmYFwXoNlzLXsc10tZQZ+NcgbvgFx6FU6Z7p9I0SUzVEzqqDgirbkHJ7TBzR+YgWLJNQUrFkYyuNvOFfzPjIYwuNJAi4WqxvgnuHlhK6HSc9npso/ZVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278255; c=relaxed/simple;
	bh=U99gYVVkmYPr9tUkq29zHSjlhw0d75w4W+m3Xatj+J8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=sk3ylh2NLLZ2phgQQadWF0SsuUA5J9M4nnmy7wEPTIg6LNeGNqNDkE4R5G18vwZWDgDFm3sTXEOqkkFz/+iF1qnN/jU9v+rn9ip1cbBNT72Rvi29KkZLpBjRkFOw4r6Tcga1YY93YelhPuw46t68EKbhOIN7X9s0tqtdbhYE5IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk6JH+qk; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759278254; x=1790814254;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=U99gYVVkmYPr9tUkq29zHSjlhw0d75w4W+m3Xatj+J8=;
  b=Fk6JH+qktdWmn8OHY5749pQi9AI5FXYBbpiiLipurnKnaaTuKcN1HazD
   uSRKziqOcqgo1P7PBoq65t9ktaQKeuUnaZoOtrIdIDqRu7r/ywbSSc80l
   YPKJC/1rAt6aHDib45rnjwROF4kEdm2lZ6OqBEYKhhXEo1jmW/Y3p6PtQ
   7sTUWsKgu4tSLArhmgie/b47BfezgcHXFgJoWl/f1Vq7JdXwJo5C/qqug
   49xqDMXzcWrCk/VoYakMysro4+11EcdsQzXQIChwxPs0Br4s2h35Zwvh2
   gTnQ96QPMgPlzuJuZbjMAozX1glk4kTkdbEsDMX0sTshKuXD8hFivGKdN
   Q==;
X-CSE-ConnectionGUID: jCoHtny7TkOJf9WmLIwAvg==
X-CSE-MsgGUID: oHUlNmPzQ86f/HCb9ppx/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79197226"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="79197226"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 17:24:13 -0700
X-CSE-ConnectionGUID: qzqu4bUwROmUv9mFPxuSgw==
X-CSE-MsgGUID: 4NPNVoXGS9OwrUbTuMigaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="182676306"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 17:24:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 17:24:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 17:24:10 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 17:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwgcLTcQgMtlBT3N0WZDO22qnvirKIIReuOKL5dr1cWsIXHGYml4dZ99TT6YtzNbVIRTf43V4u/+9imW6Lnqm94H/NLaehKBTyu/uaDfXu5WLqCTJlSicpgOmqkd7XuAsUwRc/TIFajBxkNq+gEtW1r67HyR03w2q9BZAFiQcwexsBWlnkiprdVV9mmsqMdk1TdJ8ZUsTaSFk+9TlwfQxkohIFs19dYZWI7oXumJG7C0ZYgbRKph11Z+z5iwr5T+oTefBhuJbB26ROD+Z82rBwCNoIWmHjL8GMsX5bmFIm1Ly7GQ8n5dN786UolMGMxgKgWKJvxzAZs+dPJtNR/fXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYaDr4JWbWF3l11drW0X5jD6n60JHwHmAcvFWGd31wU=;
 b=Oh4LLguMLjHPb6EpMTrUXVAReyWmhzk1cT7igH6i+lqIgd3lPIFb1W0QBv2kDPDosSRdBDtY7KC9ZaTO/XoOVbGjTwq3ISfWM4+Pm81mmYiForsj9lhNZDzR/ISYaMCwiWiey1bdcDUlpGQNKC/CIZmehUOsjoeB9gWMt2aNgBpAexsj0pvWDB/bCA6TvFKlfxAFVuu3iidc3U0vIG2bbiWT7g8zGw2Uon9bgaheRsW9BwNtxbByJd/tkHGUsv9p5g50xxzznvesSLN1g+B1NmvS4mz8QnCCmokYp5dnVtle6CJB+P01pSN+Lh2sIAQje02l31Z7H/4iv+LXzy5opg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6102.namprd11.prod.outlook.com (2603:10b6:8:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 00:24:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Wed, 1 Oct 2025
 00:24:08 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 30 Sep 2025 17:24:06 -0700
To: Xu Yilun <yilun.xu@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <yilun.xu@intel.com>, <yilun.xu@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<aneesh.kumar@kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<linux-kernel@vger.kernel.org>
Message-ID: <68dc74a6b7348_1fa210058@dwillia2-mobl4.notmuch>
In-Reply-To: <20250928062756.2188329-2-yilun.xu@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-2-yilun.xu@linux.intel.com>
Subject: Re: [PATCH 1/3] PCI/IDE: Add/export mini helpers for platform TSM
 drivers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9c9d95-353f-4556-131a-08de0080d62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUZKajdoSkVtWlFEUjdvNGFidUEyYU9xY3pVeEpScWlSMGZsYXZ2MHNvem5l?=
 =?utf-8?B?YVJiK0htRzZ6cHFXbFVRN3Q5bVNYMDdCSVJjcDBCK2p1SUNPc2tUcjlsa25W?=
 =?utf-8?B?K0RCZmZ2bEVFbnhOVVVYWmVabFNSNVkrNHpOVUlnL0l1c3lEWmpCaDlsVUd4?=
 =?utf-8?B?SzBPeFlXbm0yT2FPQ25lR1BWRUdVaWhvdzZxWjY2bmdMcTBKci8ydzduYnRR?=
 =?utf-8?B?ZDhMTk5Ydml4OGh1eUkxOHRsejFhQ2VCS1kyZmRJNzF0dVNSaDNxM25WVWxs?=
 =?utf-8?B?MTRqV21LYlVSeEdnZzJtTW8yZXdBZktmUjU5czBBTW9wc3lMSG15bmphTlov?=
 =?utf-8?B?WUdBRmxHRnBxa21DR1hDVnpKMTJXdWNFNDh1aXlJRjVMM0srSkx4bEtWTEVo?=
 =?utf-8?B?RmZSL2dnaHY5RWdwNGpvL3gwTWhtdGRXV1pUQXArWCtkblk3R1ZkdFhwRGJz?=
 =?utf-8?B?c2ZqUHFMVFordGlVbXhVbGVvVXJkS2hPL0FVSUlGR3huV2VEZEkyTUNNdGh6?=
 =?utf-8?B?bWlHd1Y2dVovZ05zOGUyVTV0bThrekhJY3Z5STl3c0JDNXJFbHNiKzRVSURl?=
 =?utf-8?B?S0xHdWV1Um5SN016NlQySGhHeHdZS0NtTEx4by9jYnRvbUwrM1RKaFJEdXVO?=
 =?utf-8?B?YXNGZFFyWlQyRnBsRkFiL2hGM3Y1VktTS0lDWmFFbG51eFozb0x4WHVwNG1S?=
 =?utf-8?B?S2d3ekc5TXBiTGRNV3lTbUxvbDNoRmNVWFE3ZUpKVHBzUnA5ZUhpZVZvYnBj?=
 =?utf-8?B?b2hzNjRYRURuUDZnNklCNmthMDR4S2pURzhOejc4aU01dlFSd1F2NjNSK2xr?=
 =?utf-8?B?bnlqNHJoRjRNWHp1SWZrQk1NOXZEbW9iak1pWnFUcCtNcHp6VDFkbzRFYnJL?=
 =?utf-8?B?Z1FTYUZSVC90aE9kemVmalNRUmdvTTB1VDV2OVZpbjJCOEJQZmd6VzExLzJt?=
 =?utf-8?B?MGx4dXlBc0RkdmdNYThCdVlsS2ZhdXZJWENxdEZTYzlpbzdiNVdQcUhWOVVh?=
 =?utf-8?B?Z1ByZ3VCbFc5dm1WQmNDaWF5SnFVSGVrZDZNdE1ZWDBCTU04dlNRTGxxTVZk?=
 =?utf-8?B?UW93QitvOUFVaFE5NGdXYm1jcUZka2MvaDFyVmpiWkNyRGlZZEZJczYzd2k2?=
 =?utf-8?B?Z0lzSFUvRDNCenZhR2dFemZoWjVvdmdueTVNYlIwWmRYWW9ocmFyK0dLdWpO?=
 =?utf-8?B?TGNKVXk3c1pselp1UkdJLytXb1drQTVTZExoZ25UUHJmclBaWDlWMkRUY0l5?=
 =?utf-8?B?djFsdS9GRXRWbnhKUW5qVm9iSE5DbEFiTFJMakQwSS9DMmN6MWJMa1dCSnkx?=
 =?utf-8?B?OVBiejRzWUhjb2hnZkVEeFlQYUNLRVpTdnBBMlpWbTkrTFIzOTBUTm43dzdM?=
 =?utf-8?B?bDFpclc1dEhxSzE5M2NBOXRZaUdkOTdMbE00YkFyUnVnR2JDKzlIS0cwcjI0?=
 =?utf-8?B?S1VKZUNkL0NRSkZDNlljb2F5dkxCdEdhK3hHSlpEZ0c0QWhGUytmNFRlQmdG?=
 =?utf-8?B?cnJ3UzhHUkxhZ3dkOWhGMG4ydDlZS0tpOUo5U1BzQ3Nvd2hRcTFoZ0lEVUcy?=
 =?utf-8?B?QlBtZFF0N05JVzh3L0VYQ1ExeUlyYloxM05NdkUzOGh0N0d4akxQMXlVdTN2?=
 =?utf-8?B?QWNBbG01eGp0UWRldzdiVkpWRUs5RlVYaWxpZ1BTeCt5UW0xYzFWK0QxYkFK?=
 =?utf-8?B?cFNTbm9RQ25YdG9BOWNIdTRLV0NSaldCOWZOZExTMnYyUnRYWGZjMnhrMUVK?=
 =?utf-8?B?VS95aDAxNlVKekhEZkF5aTBIUVVPRFkydEx2ajNoOGxITXpCSHpHRk5pNmNF?=
 =?utf-8?B?Ylk4aHlua09sUyswSVRaQUk0UUNRWkpyT0ZEMU1DWFhpSTl3cXo0ejNya0lt?=
 =?utf-8?B?M0E0NTN6aGFseHRxdGtjaXo4NnN1MkpRSjl4VDNRQjJ2YmRvOW1EQUJmT3FS?=
 =?utf-8?B?TGRKK25KbXFTWjBFMlY4NWdkd1NnRDUyYUlEdnM3NkVKT0djM01aRjJZKzJ2?=
 =?utf-8?B?a1hCWEpqUlJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5JVDBiaW8yMlY2SnlzK3hINGtiQndDWnhlWG40d09EY0ZyTVBaRTd6VGZY?=
 =?utf-8?B?TW1HVWtXcmd4TzlLcjRYMVROeEdUUVFuM1JKUmM2ZjZtWkZhYWc5N05pVWJS?=
 =?utf-8?B?bmJtcEMrYWttQjEwM3pQSXpOTkZ0dXNlZThkZ1VjNk93WVZLTFBOZjJoQWFD?=
 =?utf-8?B?Z2JrNWpuOUF1djg0emljVDR3RS9ZdzV2eDlqYThhZksvNWpyQjFscUFIaDF3?=
 =?utf-8?B?ZktRajR0eDdNeGpLSUlncjFhc2VkQ2d0ZzdsYzJHeEI5SERVdWdPVmIyRllT?=
 =?utf-8?B?WjVoNUxpKzFUMXhxdDFUOEw1OUNQaGE2RVVSc0JLYXZDa1U1MG83SmJXZkRw?=
 =?utf-8?B?VE1sYzJWWW1oNS9wVzAzeVlZL0l2SXMvcng0eWQ2N2Y4UnB1UCtrOWd4aG9B?=
 =?utf-8?B?NTdlVFBMeXpzMCtSUXQ0TjNxUEhEUnN4SWdVZVp6WXNmR3NSbXdWUDU3NTlx?=
 =?utf-8?B?eW5uU1FoYXErRkV4SDA5bnJzamk4cmo2Q1g2UkJHRE44V1FVd3dwbW5ISHdt?=
 =?utf-8?B?Q2pqOHVheUdmOW5tRXpLTHo3dE1BY2E2VXFNUzRXMnNuSVBMc1BlMEE5N1kx?=
 =?utf-8?B?T1hlY0JzNjhFWnYwc0lhNVB6bkNCS1ZTSjVGRklEeUtvaVVFWXhJSGsrRVZa?=
 =?utf-8?B?KzM5TGdKMG44cjFMMnk3ZWErTFBzWHV5VHE3Y2NFY1ZZeFhNQWkyZjRRNTlV?=
 =?utf-8?B?VkplWW1rVVMvYUJPcDE1U3pzWkRXbWhLWHhJN2VyUmJPYXcyblFHUUFGWUhW?=
 =?utf-8?B?d0VPU3FhM3Z0ekRPb2hYaXdnWWQ3bE5CVEtiN3BMVEpTcUVDb1UySTdhODFp?=
 =?utf-8?B?MUdycHlhTXlYNkdUbVoxYU9hNmVrZVpRQjk4UzRzS3NyVE1WbW1uSG5iYXdF?=
 =?utf-8?B?MitYdzdxcjJHT0xnOWc4TXBTSmJ4QWYwTTY2QUdPclV2NkhETE5Vd0puL0Vj?=
 =?utf-8?B?T2tNenhHSWtlUnpUbXd0eWdHOUVyQm1Ib0hQSjhSd3c5cm0wZmhaL2Z3bllp?=
 =?utf-8?B?ZlJuNmtVQzBMUFloMzFhM1FjUVBlNll1ZFlRYVZlTk1GSG5BNWUrVkJPYzUz?=
 =?utf-8?B?bFp4RmpreWtzeFVETnNSZXUzYUV2Q0Y2bWVtK1o0aTA2blNUZG9UNXRRU1Nz?=
 =?utf-8?B?azlySWFpbVpuMTl1T1dvYnZzZ2pSSWpjcUVOUVZmYkJvUTZHdzJESVRWR2Jy?=
 =?utf-8?B?RHhZZEFiYXF1Q2l1UWl2MVdhOFRzWXI5d1hFc0VrLzdyS2xZQ1d6dEc0bXNq?=
 =?utf-8?B?U0t5a2RISlVEUU9Udjc5emVhQ2l0NGRMOFo5TFgrRjZrSGtyV1FTc2xYRlVv?=
 =?utf-8?B?S1pVOWNTUUtCc0V6YXpqaEVhRElUeEZlVWFsK1dBYk40Y0R2akIrRTMxNkM4?=
 =?utf-8?B?NXR0QlAxRit2Y0hCRjIvNWN3dTl2bHhuTW9EMnVyTitYbmVEajVhVjU5ZlZ2?=
 =?utf-8?B?SUFnZUJzZVA4YmkzM1dyK04zME1lMzZteGF1WUZKNzFHSHNvdnYzVU10UTZv?=
 =?utf-8?B?dkc2TDEyQklKeUo3bXZxbkdja3Z1THI2Y015TXJPM0MrZkNzOFQyMzZzcHd1?=
 =?utf-8?B?QktQUm1RVFZSR3V3UTdqaHl2WSt2UW9HRVFieXAxaVBKc2ZjeG9xZENPc3hu?=
 =?utf-8?B?T1RjdjRaZkpRZEZlUm5KVFV6SkhQRE5nYnBZYkErUjRkVkxxMk9hWTBFeDBs?=
 =?utf-8?B?Yld4NVc4ZUlURnNHMk8vR0VTTXE3TGQ0bnlxZWZaUW9SZVhqZ1Z2SURKcnc0?=
 =?utf-8?B?ZzJDb2lPWnVRdk41Z3o2eUxyU1lTNHVSdThJWXZ1WFpuNWV6WEpocDNlRVZv?=
 =?utf-8?B?Vk1qZFRRN2p4MkFETjRoRzEwcUJ1WXVVcnU3UkZ5YmR0OFFXTytjUjd3d0V5?=
 =?utf-8?B?b0sycTUvUDNSc1NtY0ZuZHhPNG1MQ2FSdzRWa2FGSFBlV0xuSmdua3lQbFg1?=
 =?utf-8?B?bHk2WnBZZWNLa2tJY2hxVXVjOE5DVDE3V1F2TWIzQmdKQlF6UHJScFBRTVlX?=
 =?utf-8?B?TGU3UHJDbjBHdklGZW1qekxZNDBlVXdzK1JuRVRYQVZoVnpiamhkcDVaMG9U?=
 =?utf-8?B?QlRQMHF5YklJTzU4VGVGRkJSOFpXYnJqWFIzeXErYjAvRklOOXRKdU9VWm94?=
 =?utf-8?B?Nk1zNVVhVUd5bzVSL2pSZEt3Q1RnTHNZeVpMaHh2SmdBS014cUY1VTg4TTNm?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9c9d95-353f-4556-131a-08de0080d62d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 00:24:08.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vypmTywfQiNmSlHTk/bWZBNJ/vsfiXHlZbq3xPFyUDm4NdqrMUWFwBi4wv+4Q2A9YeEAzAM+P8dhCEynkyW2054gKw+VIBVctgUsb/Zu22Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6102
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> These mini helpers are mainly for platform TSM drivers to setup root
> port side configuration. Root port side IDE settings may require
> platform specific firmware calls (e.g. TDX Connect [1]) so could not use
> pci_ide_stream_setup(), but may still share these mini helpers cause
> they also refer to definitions in IDE specification.
> 
> [1]: https://lore.kernel.org/linux-coco/20250919142237.418648-28-dan.j.williams@intel.com/
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  include/linux/pci-ide.h | 6 ++++++
>  drivers/pci/ide.c       | 8 +++-----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index a30f9460b04a..5adbd8b81f65 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -6,6 +6,11 @@
>  #ifndef __PCI_IDE_H__
>  #define __PCI_IDE_H__
>  
> +#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> +	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> +	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
> +	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, (domain)))
> +
>  enum pci_ide_partner_select {
>  	PCI_IDE_EP,
>  	PCI_IDE_RP,
> @@ -61,6 +66,7 @@ struct pci_ide {
>  	struct tsm_dev *tsm_dev;
>  };
>  
> +int pci_ide_domain(struct pci_dev *pdev);
>  struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
>  struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
>  void pci_ide_stream_free(struct pci_ide *ide);

So I do not think we need to export these as much as let TSM drivers
reuse more of the common register setup logic.

I will flesh out more of the proposal on the next patch.

