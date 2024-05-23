Return-Path: <linux-pci+bounces-7801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA3A8CDBD0
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 23:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42BEB224A6
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67723127E1F;
	Thu, 23 May 2024 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ez2Filtw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539262628D;
	Thu, 23 May 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499101; cv=fail; b=t90QcNi1rih12/HoBo4gbrEEsv+i4MHOb9OnxJpPV8wrgIynpItCycmWEMIXGh9HYZozjRzCpNhbCklbN7pPhJWiyJ5Yq6ynImVSoSdq+72+OTUhHZAkagf8i0qn6zcgYx/Aoaur3bHpeETo8es1mKrMlkafBpuCtI+kaPgUhT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499101; c=relaxed/simple;
	bh=qsdLNhefnyy5v0NX6VCyaMdB3xC3uscEOZTefp/v5as=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gRHofzKRMqz8IlaJztoTdqmcow4MNG9UIwLfma4P57h3LV7kGFScqpppe3ylX/kLalFzacRdVd1eIDc56PN3FrkEvmb1UipthHbABHjeFu4q2cCtvK+4Zz/fB3sCddfRI/0s+8oOefpLcbcVCiosF751pmHresp71Bwjm7gupYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ez2Filtw; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716499099; x=1748035099;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qsdLNhefnyy5v0NX6VCyaMdB3xC3uscEOZTefp/v5as=;
  b=ez2Filtwzg1khP5x9o6j8XJkHrwsSKeh2/SNQQWHz8dBPjVSi/YDhb09
   ixf9mzovxY7bVvP1PaNLKqvZlFXvxHCFzG222YTuOwFfcLdZtfIFAJaUi
   dPsbPeyU+InLZPbmlHPE5EKTTIOoKRXy6P/axTH04rY7Mf/Sb1RZrl6SK
   pwxT2ppyNu+sb0IqaTYxe2MHJLe+kTeKlbsHrPzTxEVj2j8AQTPwOl621
   IK4ZFP5b80Dg5oWEjGY+Ad4lm3NKKAxWxdoKHalPOQdq969XZ/XkYNY7K
   ADO6jF41xYBynyYEEQySrIXM8rMNBxEWYg7JK0c7gjwUfoe8o405+mBWv
   g==;
X-CSE-ConnectionGUID: 5YjGJClNSki4Y0UttqtyZw==
X-CSE-MsgGUID: +npQUWYxRG6DbAkaUJDmGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13082061"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="13082061"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 14:18:18 -0700
X-CSE-ConnectionGUID: H8DQ31kMQGeurHlH0VK8yA==
X-CSE-MsgGUID: vOcjMkedQYSyf7ip/FnoNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38369251"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 14:18:11 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 14:18:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 14:18:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 14:18:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJ+pKAXJIbCzUeT0eHi2k76j3M5t3wNQnHj/gU+ZYjo2EquROJ59+H9VD0cxkVTB9/e94T/lEDYN3NAeyRgdp4fNeazFlRa7tTZUg3rGrOYMPWvgE3NpZyZw35tnu4ruPr5peTt87qri82PWOzLUwg/uxgDpe1GBuIMrtG/NhQWL1VrMjm4Wafzqn/K7Q/AkD7gX03yPg26X2r6dNYyYyLd/uLUbY/wqScnkn9K+orq18ohOzjda0a+NdF8jLaFoQNgt2cUvJNaMhKvcUFCwR5MQXNgbcONyrRQ45/dBezYlzeZaVKE35uSSoaZkyPnXA1/Gu+OPlck3jjLuSKHFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSw+xl7oxdnWJzyrhiv83qYiTgHJpPxc/O9VxpVM31Y=;
 b=MyKGRvos7LE1/EZfwtZ3dUwvsxG4v/4OL+VlK+vjIilyRiXmTPXlHNAyZgXCDD2xsIh0TEopDBsRjxs6rsQp82x9D8Ws9BWYGn/6i2H729+HZghXj1w3p5hG9bcbf8h6odNwOo4Jyuk90F8c6G/SzGo/JWfGj62dn7loeh3sMikCfrw1qBkGMSGcB9B9pFrHDQ3jDlKixFeZyqpPHBr+xIfHFNTJvq1YwTYyZl47mncoLxzCcZo9DahWMeSqeFsYybWhWMYL1+roLrrmNgXtOsYaheKM9EJZN8jTolt5h30ysnMIKFTVCp9+bzJ5vcjm30IdYbnY/ujHg91D9Rq0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7087.namprd11.prod.outlook.com (2603:10b6:806:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 21:18:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 21:18:03 +0000
Date: Thu, 23 May 2024 14:17:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v6 2/5] PCI: Add locking of upstream bridge for
 pci_reset_function()
Message-ID: <664fb286639ed_195e29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240502165851.1948523-1-dave.jiang@intel.com>
 <20240502165851.1948523-3-dave.jiang@intel.com>
 <20240523131005.5578e3de.alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523131005.5578e3de.alex.williamson@redhat.com>
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f234e6-3ec7-4450-ac02-08dc7b6dd4d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uG90MEqZfV01A5Qs5iPp0/qLcN6zgHFzHQ52qw8LioSXFFMUtFsy5Yn0Fdqo?=
 =?us-ascii?Q?eQ9h9FVsBe/w/eIuv+ISkPA43+Fm9UOZko071OATA60AIysgIbFbNhc4ypaw?=
 =?us-ascii?Q?+knXYB90y8oygHkm2j0LxJIs50L6xHmskWwfyJkUb+H2gGuKwq8okGWS6t4U?=
 =?us-ascii?Q?KR5b/fK1fMQbqLiBjDAd6pPjlW0isi/1nZ6xLh2ZnjJlwxc2Qc5s4/K4BmCh?=
 =?us-ascii?Q?qVnl63F8DO7GCusQH7HeEYElI1bLilyZrlCKQ1TlTMEx6mnM8T/QTwiRt2zM?=
 =?us-ascii?Q?BCXOqi7onq4Mh61nmxalJ7iIGDcpj4pAhxPESBimmqBUTGG6w7cBzpAB0FDn?=
 =?us-ascii?Q?sAtzwFkG80OQCstn92vDBeJm11oogBU6O66xCxiqvaznJa8F0C8AvAKIst+l?=
 =?us-ascii?Q?7TADSYHHqzX96s2HTNg1RHxP3byonaGhwZAqrJG/aWCUdeELjX4tDVteut4h?=
 =?us-ascii?Q?AjefV51uamri4kkNZO7VzCLSof9JsE5nDhqbT5/O7LHIgQuNyaGLs1WOsvqk?=
 =?us-ascii?Q?tIxqU14j4FBknZPSu0vcwDxPK0CH+I5cVGpXi+BGWoaF/GC142BCrlJ4fBxw?=
 =?us-ascii?Q?2wVRcK6pRH4b5FWpAk6QTuBs6MrzLft5k3IpfO/Izzpr7U/r8xG23YIJTyxj?=
 =?us-ascii?Q?2liJkkMksHb0aL4Uu4I7Gc2Lx4Qee8Lzbi2TZgIpnkRWq05TYQEqfyWKSEjL?=
 =?us-ascii?Q?V/8d6w1OprQQyK5nc4u8fsPtYJANjDpBsJg7dPl9TQrP5elqaR8Aaa9xUpSP?=
 =?us-ascii?Q?qwxKOS3JgKSNi0rgl46b3YWBzv4prnA2FEWqmTfYMUhty8Ihf18A3n3xmoHH?=
 =?us-ascii?Q?EsSw9mZc6dFsoJtgBD49PtlORnVHfxoes6dLnluaPfhJWOqXqL4BJijOYx/T?=
 =?us-ascii?Q?CUnWhqUVwl6Ijv3Rjx0HzDiZuE9iZ45weMYnkIAqG+8jgq1JYbVpfKVuFYC/?=
 =?us-ascii?Q?WTWfJXQFdKRuP6xgrRd2E3yeLmrGP2RdvFMx0mP0wXmVuPlBFi+hrRsRVlCN?=
 =?us-ascii?Q?OlcnS9IJXz8+YRmmWrNnWtVMpjBqfEQF3M/AyBcwtE+ZoQR29TGgio/0pNny?=
 =?us-ascii?Q?GDa2B1jsw9qD7g8yC/iXuL0gdKnsJLYazkFfdfM1azE5SCuAAXE3UUXPzTtI?=
 =?us-ascii?Q?ZLOEIfPbSWXa6K6cfArBKRTiF8USvGC+cjkbOie5P7zFlJe1feCiZR00NAlz?=
 =?us-ascii?Q?JhwhXES/fHEJNLcMb15MwUXWMcRaQBdpnMbFcHfNfI5geRrMdONkpaC23dtT?=
 =?us-ascii?Q?mBoNTi1XGDVo7O/CZse7AkBs4nhRVuX7MLlmTOdw0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I/GKw0S5Bbh0lIfW8brx48yCYWsKsvp2TagRwbGUlWKp408bCC6V/aalekG9?=
 =?us-ascii?Q?dAbW6BY+QJbXeEL0w3ysaMBc519xDx+bNGJm0qrtT9OA8H9A0M9WAitf6i9i?=
 =?us-ascii?Q?8qd64O0gIW3lPPsNbLzXmXX53HdoqlxG2AWZJJc1Eo+6i0wtkQFCWM2rMfJ0?=
 =?us-ascii?Q?IzoT0oHCAjZWzqmyRKBlxmCPWWPEzA7PdaE8RWCaMZcN6UKBJNMKs091kGbX?=
 =?us-ascii?Q?ZyhZtVhQ5XVINLMHeSpx9tRtlhFJulFO+c+q9J27NQWTxw1dmCEjgme5TD9I?=
 =?us-ascii?Q?su4t1gQWjIshLwhv/jQ4ipiYGcdlESsOTeM+r+AB2q2kAcaFHBF8MEcrbWeI?=
 =?us-ascii?Q?zslFwhlz8SsB768A1UygmOG0Gn/W2UGmz14N9B21SE3nHiAu6d2t04llgTMA?=
 =?us-ascii?Q?s+hPqQI0E1dfrpPh6vgVlSdMgQSAzvOeNQ1oY4nWfrzv9moCv5AAoClYB7cy?=
 =?us-ascii?Q?LCAvlAhBxRhYZtncEPBxpeXtxrOZ0flEOAWu7iHjzz5F3iDdH/ICRA3CfrDA?=
 =?us-ascii?Q?v4hRlakzoYjQ0LNYlZuDc/chBz8su/c3AyHAUdUcsioaLlRzW4vvgyTEdZAR?=
 =?us-ascii?Q?NJomIdPWEaiu+67E3rLDhuOwwNHUqFUq45RArWo5MlOIjnvlziQSZ5PtxJCf?=
 =?us-ascii?Q?tDtHR2iBDZ0tQ7q1ntNA5KAyrZU+0NEEB9N1plNovboG8xVo6EC4yQbcqMZk?=
 =?us-ascii?Q?5EUQmPnAJvOeAsxQSX8VeqIR9YkzEU2X9eK1iwuSTTt64PXWmSZc/5Yv5Oan?=
 =?us-ascii?Q?olOWrMZCb3ssA5Wa2abkheaLRTkiD5Kz4u3qqCwXsolrJTL8Mwe6GPOsrMRK?=
 =?us-ascii?Q?wthPzkjWsRPgE9kcB3npJ13aUZ35OZxGTI0PB4SCwXA2uFLxCm4RFqADCJZP?=
 =?us-ascii?Q?iVaxrCi3aaEOcptZM1nXNGK761DiKbpT7xmiZWngpA+YyIBzYZo8Tjm3ulFV?=
 =?us-ascii?Q?Ceyn4CQw2rCV7w+3/Sf8En6SS+xHebZm/fIOvbMKpfpm4bLEIIVOyAeEPAGQ?=
 =?us-ascii?Q?c0jjKC2c9LwoFNA1jqdQ3z3VCiO0CTTrgTfRWsqGCExYQ62STfk4homgCuV6?=
 =?us-ascii?Q?FSzlZb3jhP9Amnk0GTXtrUYw27kk59rCiJ3NI2yaNsZam282Ga1KqQQYK9Qf?=
 =?us-ascii?Q?z9lBLQOsCJWcW3Sy8eyEIZ0LejttG+N8VimfWQyyAK3Gc3EuBcMT2UaPS3KV?=
 =?us-ascii?Q?N5LKDzNShL29n3N0iQ5nYFsSNcKsrgQgVJVmYrqw1/TO6tGE5lLUAny6vSIs?=
 =?us-ascii?Q?9xEvJ5dmASglgIOQIUQjhdjnfhCcyj/kUZwIp2Ee49/0NMdl6Hqn9PERgLsi?=
 =?us-ascii?Q?11p4dMaxnoEEsWGxG5MFbj1C/XDlFs/Es3T8hImgoO1kxg3NnXzYhRpUCqBY?=
 =?us-ascii?Q?G2/iwMNrYAjM56shiiTwNyBnMu+aZtlrmX9EmiDVOO7FGWp7Uct9VoW1NLuw?=
 =?us-ascii?Q?UvoJ3QBfZrOK8jiF0OZErlQ7hxr5YL71ofyMsZ5lWucfcQli4aRSbYCXsPEj?=
 =?us-ascii?Q?/t8dIm3mO+b9Ye1UE1iWTMNZ0YCTDFkovNRmUZ7oIjNZUu5jbFG3ptc8pz+e?=
 =?us-ascii?Q?PcmWiyAHcJJlCKc/AB3M84XDc8vySm9/njFN0UMNzlHmdx9MEV5pcejkI6NH?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f234e6-3ec7-4450-ac02-08dc7b6dd4d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 21:18:03.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smxpxbqHB4dZ7k6du8WB33om34M1g8hjP6G7nxcVUnYnXUmdKKqzBb9pfguVUcNPTYZ7maplRm7u+wcVeWcHs7rfxPwjXfKz6JWyWvFJS94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7087
X-OriginatorOrg: intel.com

Alex Williamson wrote:
> On Thu,  2 May 2024 09:57:31 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > Fix a long standing locking gap for missing pci_cfg_access_lock() while
> > manipulating bridge reset registers and configuration during
> > pci_reset_bus_function(). Add calling of pci_dev_lock() against the
> > bridge device before locking the device. The locking is conditional
> > depending on whether the trigger device has an upstream bridge. If
> > the device is a root port then there would be no upstream bridge and
> > thus the locking of the bridge is unnecessary. As part of calling
> > pci_dev_lock(), pci_cfg_access_lock() happens and blocks the writing
> > of PCI config space by user space.
> > 
> > Add lockdep assertion via pci_dev->cfg_access_lock in order to verify
> > pci_dev->block_cfg_access is set.
> > 
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
[..]
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 6449056b57dd..36f10c7f9ef5 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -275,6 +275,8 @@ void pci_cfg_access_lock(struct pci_dev *dev)
> >  {
> >  	might_sleep();
> >  
> > +	lock_map_acquire(&dev->cfg_access_lock);
> > +
> >  	raw_spin_lock_irq(&pci_lock);
> >  	if (dev->block_cfg_access)
> >  		pci_wait_cfg(dev);
> > @@ -329,6 +331,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
> >  	raw_spin_unlock_irqrestore(&pci_lock, flags);
> >  
> >  	wake_up_all(&pci_cfg_wait);
> > +
> > +	lock_map_release(&dev->cfg_access_lock);
> 
> 
> This doesn't account for config access locks acquired via
> pci_cfg_access_trylock(), such as the pci_dev_trylock() through
> pci_try_reset_function() resulting in a new lockdep warning for
> vfio-pci when we try to release a lock that was never acquired.
> Thanks,

Hey Alex, sorry about that, does this fix it up for you? Note I move the
lock_map_acquire() relative to the global pci_lock just for symmetry
purposes.

-- >8 --
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 30f031de9cfe..3595130ff719 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -289,11 +289,10 @@ void pci_cfg_access_lock(struct pci_dev *dev)
 {
 	might_sleep();
 
-	lock_map_acquire(&dev->cfg_access_lock);
-
 	raw_spin_lock_irq(&pci_lock);
 	if (dev->block_cfg_access)
 		pci_wait_cfg(dev);
+	lock_map_acquire(&dev->cfg_access_lock);
 	dev->block_cfg_access = 1;
 	raw_spin_unlock_irq(&pci_lock);
 }
@@ -315,8 +314,10 @@ bool pci_cfg_access_trylock(struct pci_dev *dev)
 	raw_spin_lock_irqsave(&pci_lock, flags);
 	if (dev->block_cfg_access)
 		locked = false;
-	else
+	else {
+		lock_map_acquire(&dev->cfg_access_lock);
 		dev->block_cfg_access = 1;
+	}
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 
 	return locked;
@@ -342,11 +343,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
 	WARN_ON(!dev->block_cfg_access);
 
 	dev->block_cfg_access = 0;
+	lock_map_release(&dev->cfg_access_lock);
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 
 	wake_up_all(&pci_cfg_wait);
-
-	lock_map_release(&dev->cfg_access_lock);
 }
 EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
 

