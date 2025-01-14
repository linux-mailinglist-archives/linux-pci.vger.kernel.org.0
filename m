Return-Path: <linux-pci+bounces-19785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D934A114D7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184833A7813
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24DE228C97;
	Tue, 14 Jan 2025 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBsvP2Ps"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE472288C0;
	Tue, 14 Jan 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895533; cv=fail; b=s4A2v7z6p05co6BQiYb4JeZYDFThUxekbkl9hXbNsJVhtE97pYqI1hjzXnVFtjgk4tHHIFhi+IOE5Wp/9KJW8a2nZ5QZTu80HY6hPZw5iIUcdLgzUm5GkICFRwRbLrFyCu34VOELycsjzsu1HCQ4FEIaAkURYU1FaMVl352Ia0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895533; c=relaxed/simple;
	bh=mi4AJTuP2HDeyXZYuKOyRgoMG3B4TV8RPwNkHXsajh8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GV+f+tk9KZN4FWpPU7jbnVO2aasbz4dX+YZG3JUHtYiM84xyT0LyKysv5yc5EK+631H+vEeKqIZgiS/qoHo5smJVULmoS8bSHosZi4MDS9XGM9gTLTVYPqqSh11a64zcUkZTdJnQqaOxlhmo6hgxBrEztaH290xJLrl/0jGXPKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBsvP2Ps; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736895531; x=1768431531;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=mi4AJTuP2HDeyXZYuKOyRgoMG3B4TV8RPwNkHXsajh8=;
  b=XBsvP2Psc2Zf1HA6APVLodXFZZK9xEZCR3TFbDBoLSdmJQZmB479o2f6
   d6rvkSASJNNsdKObYPJk9kIg6dQ/GeMt92BL+KAGRaHSZoe6u1XJ/0Qo/
   czoxg7yjkhLj8OaVWytVPIhFS/UnGB8JjqHpViWztrth5AFRzO0nQiLh2
   JMOpnwmzn6KdWKwJkEW4mawQzsgh6PV0hUhgBYj32B/04vYg7Xw5gITY0
   iqk2TQezIMrycyBvdD0Uuj/8qSMx0xbGGPVh3CVhvagWfZEZW6Hkpp1t7
   QiRENEzafIphpt80C2DwwWavUUhV+magd0RPIYFGPH0K8SD4aoexkdJk2
   w==;
X-CSE-ConnectionGUID: cSP3sIkoQTaHBS0H/iG3XQ==
X-CSE-MsgGUID: erL73K6HS0qjU+82xk/g5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37370562"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37370562"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 14:58:50 -0800
X-CSE-ConnectionGUID: 3k44nBYvTiqo0bffJcNt6A==
X-CSE-MsgGUID: 6XVrSZhvQv+cnDre3SNgeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109901680"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 14:58:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 14:58:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 14:58:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 14:58:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg4V9n+NnwpJkx4//11b/+bL4stR71f7BdeTvKW4EDWxjpVh1AbMUL532t3cenHcT1hVIlAOSNxbOWZahCjffXCui6t8V9I1SwuL8K0TTmFm20nlOYgBZpATLEF8UPBr1U68g57k96/gIXbB9EMFje+QXvVCqgzsyyNfHEiLwXXlEugqB4KmzPlxXxNlLOvP4mFev95F2w27lzJFWQ4CX4L7/p/SJvJaBJRd5EIY59FIg2dzalh/pZfOmoopOF0dzhterPrsiYp8dM+eW6dATcsNni6QfJV842XV8kI8C8nYmQHLuaH6DHTm4cKNEpMLYKJe3Rf3ds8GSEysz/xX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYTxHRqFuzdrLqtnUG9h7que652xbqDzyRd/W2FmjGw=;
 b=NqcvaF/tHyTTS53cI835oGihJCL+ZUopLcacFwlfWQFKI1MrCApal6r79A9Ow78ersQCMl83cTlWdsyj80pSR4sEEWGtS7SnKXnNNvkpuIJIpvOpyCvkbqo3okwPfb4fLWpNgoijSvx1JJ2G9R7lD3SFFjDN1rEccIEWu/SlFqi4Q6zGpzKRpmnVzIYe25K/2Sr0eNFHddd7nYiSX+rZVziLV+4lYkjjnr56EpJFP/Lu6pfHCkyv56H9l1PLeH0J/+YNZ3hyT8xoX7ooRBpwZ+v5/leC2Zb4cWSMT74uQ7LyERHsRWuKY2WvzR20BqqkosKwro0U8SfjJcMJd7WMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 22:58:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 22:58:33 +0000
Date: Tue, 14 Jan 2025 16:58:28 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 14/16] cxl/pci: Add trace logging for CXL PCIe Port
 RAS errors
Message-ID: <6786ec14738c_186d9b29423@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-15-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-15-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:303:dc::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e58509-691e-49a3-b0b7-08dd34eef883
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oL6Td/yBo5byswiTd448vWs/91Z83Nibz42W0c0NigcXxxSUjYfHJco8Yp8/?=
 =?us-ascii?Q?wlyFKCSdBoITTeW+mXkM3qSWhr4JqE2GtRjcd9wXIHo3DLMCnBufZ92vNOXA?=
 =?us-ascii?Q?Et+39Soji3TJm0fGICWWJeu2+49QKagzVOeslrs40AE7hKPCHrORAg6taLc+?=
 =?us-ascii?Q?hVajzJI6Us+z9UrlnfQJWpvg0Wbk6pdTBrIvIDoSYpgVmIi8tLiuPADWSrVU?=
 =?us-ascii?Q?cO1e3bL0iBf430ok2DaruLzgtTOgF4Qjfndizlg1GR2aO1cdMaYeswFJs715?=
 =?us-ascii?Q?h9ICWm2fWbW3dvvERrTE3kPkYUBvcIrCihf43S+rB2GsZ32IYbPBpasHggpu?=
 =?us-ascii?Q?quoQDxRKpkTTz+2GBHjw4+Td9hgmEQrFtDEY7h99D2hcD9HwYYIrr85y9S2Z?=
 =?us-ascii?Q?g7T6RUSFBgQxcvogFQj443NdKPYPpvJnKClRT5YhFjbQEIAF3ALXjkD0NOj6?=
 =?us-ascii?Q?6yLTCGEtXfx264v4Wbnpfs7dZMk3ZNLG8OS0W2BMwzHvnsLIo2t5W2yxbx2y?=
 =?us-ascii?Q?1CYL40eG6lQ2MICaTkBDXzZl3Ra/OC//CVYCijgEuYGQlV8bCdG4+mHDLbd6?=
 =?us-ascii?Q?OAP+DfaK6MFVZ9gnmKzkGPcWWN8+N5L16xLEMw8E+7IfOVnBUf07elgnuXxz?=
 =?us-ascii?Q?y2G9Qnq/2kQE6SSJXCQYpGrM7ovu4cjzB8jthCRVwQWlqfeDk2cPqr+HbF7W?=
 =?us-ascii?Q?jaeKCkCYlAOyF+Y2y3SI4l3gn9NRyA08tRkC/OPuPQupgI6eTEdDg0ORbTaZ?=
 =?us-ascii?Q?gr5mAXn9fnyWopfswjf2/jzG/N9lD1o7jN83Wbn2pjuY5gz+4KkwsZ8uhM1Z?=
 =?us-ascii?Q?ucHL2VRYs959Ju65VRinobhAV1arm47WDyOD6sgebnL28ltdRP2eMGfUDEmO?=
 =?us-ascii?Q?P4OsQN55wrLnnC02Gl1vPdt4ZgKK9xT3unBTxwZDocrDXDxi9BbTrAUDFPvC?=
 =?us-ascii?Q?FcFuOemznLVHR5pffxgTeoskwAKPcn/fciRtNCQi8D3toGkn3wTUTVH6jcTO?=
 =?us-ascii?Q?Q85K2soe5T36/Y53uAl7ihvfVVfrk+APMfcFL+fJe3ytf5ls7cMildqSXCsZ?=
 =?us-ascii?Q?bbtG50fR2qbEH5D7s24AZ1IgUAP5lqLRIYb8eWugOYZ/cGe+kMzu0DuxNNnS?=
 =?us-ascii?Q?sjMev/9YucrhAY5otZ9cgozcmjrTYnoOulKfUmwrYB7Vj1ZAZqBDfSodQ8gE?=
 =?us-ascii?Q?b13LexMAyjnlILNL/eqOBOnbxnyE6kkMA30NQQM0do28x14A232jsRL8hs6u?=
 =?us-ascii?Q?Q/Xu2K/b9oCXOVQuXsJ0fMtDvwPZ2Jbqvsqxgmftlx7Lucqr1sfNn1ERbptg?=
 =?us-ascii?Q?rK4vC+Q51imElMaXH9OeSLbvZJToCG3U50RqIcTcNT1Gxp93GhVhYNFrSJZ/?=
 =?us-ascii?Q?KPd7QKJvUda1P5jTlCsF/Q8anv0OMW15513UwDxyo1ghNFRrihNuIhXt2cRy?=
 =?us-ascii?Q?n29d3w53wT0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cS4LpYnFXgJTDJRy5s5JKT8YfthU5mpW+oyg7aHxaY1MONEUgPKOLhdar+Ky?=
 =?us-ascii?Q?X5+WG6+enwm8bj2ySo102bep4K58xEBbI3PViT/rMmRRZ66MdanOuS2RoUA3?=
 =?us-ascii?Q?mz1nlLpd+KxiMcuAoVRVh5UirZoUnQuVi2WOhDhuEdsGn3wf5EiGtfoIIRtz?=
 =?us-ascii?Q?h1EFdLzV8PTK4LPUxcEQTx1tmGFdgsQfERs8EC5EQ1xHxBiH+d/QNPRQ4MGJ?=
 =?us-ascii?Q?EBrsgz+GQ0QHXx4FCys0uwVdX6lkY1nTD2lF5pTxineTQLeSimssL27IARma?=
 =?us-ascii?Q?WHd66NFUokEZp29+5qKRFn5kY7AtTWy3GV4YmovOJAEPeYtcwzDktb2R57kO?=
 =?us-ascii?Q?7bUMcWa4F9XZShiGRHjrrqwvG8JnTpMMZHnrg10Bu0pABa95UrOC8be2pwqy?=
 =?us-ascii?Q?xzM2fPdtdg9gywj/k+AJ5GcWABE5q2eAL3FpSv2spLllp0aR0GGtId5feHVB?=
 =?us-ascii?Q?9eGnsZRRA+4gtun8eR5z68OdAGKUWFHu6s+fXuAIm5d+IBVdrSUnVPLpFTub?=
 =?us-ascii?Q?985rMBeWNKsMiCPJIQRpKTffOeHDOkybtLyxUKKTMPJozjFt1KxngwoIINvf?=
 =?us-ascii?Q?vZ64Ar9UCoFkFhZrT1d9IGj1Apnj1UAsJI3R3ZGGfcNoZr+WLYP7dzw6XoAv?=
 =?us-ascii?Q?INmwyma8ClbwhiQWjezX73KQ5MH2aNI/6POPfKir6ViwNOpjrGMKc0XkWXZI?=
 =?us-ascii?Q?jFlw7FCQyngrK4CZanuD0D3OYu5SUc58TOnlPAGl4qal27N58+bWs1HBrfB1?=
 =?us-ascii?Q?mFqGVux+apymEwxx/ndK37StBUtogDvKKIG/O1AHHi2W4QBHNgNOvmvR8v10?=
 =?us-ascii?Q?BJUTR6TyxRW81QVE+efohZGrnVRCMqoC6i9TA0bRyWM8MP6dn/MIu+0Dw5rD?=
 =?us-ascii?Q?37o3A60Dum02V79rMbPeV7IyCHINrInztXduMrNaNr+t+IVyvaKuWxxeEudI?=
 =?us-ascii?Q?kL9mKVIYTkG7Wpq7d+IPihIt/WFAOEdkJGp6YE/7a2WsL8S0yqB9Xg48Mrh9?=
 =?us-ascii?Q?/WJhC3Kwngt0pTYQBb3RXS+AOkJ7lRBFASAiu+WUD5tHPyb3NEV8O404SNid?=
 =?us-ascii?Q?wnre60tNS/2KhLK9wXaiIihYrTSPi5PKamB+Pt5rRLlGH3VUyP7AgsCoobSk?=
 =?us-ascii?Q?0Ez18568YNZr+dIPddOw1l37xohjR0d8A5mnv/lLsi+6pdtVyyKYfWyxrXSs?=
 =?us-ascii?Q?VzDNP9H+1HXGb5mq8t8AEH2CznMfnx7KYW4jXbV/KQXrfc4eGI32IKAC3Frc?=
 =?us-ascii?Q?eyuyPH2mNqwPXWIFmnvslNSFN2y5euHOtxYII0m9EZXVQe1DDTLzzuu1QV7Y?=
 =?us-ascii?Q?qC8318gq3zn/wfUCi+tiHa7JzBS5rCXrixAzlA+JJ8kJtgAFLkKa+F0E1bOB?=
 =?us-ascii?Q?07Z8VC0jKCwmxSSZx88HKSBgcY0XzbLm6qCColWuZh0fgMJ9CrYI6YzFU7EV?=
 =?us-ascii?Q?2P5KXKw9rcw7hSiP7f7lozFFfgHsBjRuJhj1o9YoT2A2y3Sa4u/eOcBSvUjX?=
 =?us-ascii?Q?D3zkZThTXjp6LdkE9NcJ5u5WIENvQgxb8/2b3o/oVap6st4xClbGlyJPnICZ?=
 =?us-ascii?Q?5fAwW+gsMg3q6lkcPdc7E7PE3oeRJhNe+z2ag6Ii?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e58509-691e-49a3-b0b7-08dd34eef883
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:58:33.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AeyzSDYjkWmBSABVEnPK9vutSJ0LMYkyc1KsUq55eHZlWKzxYqtQnlvk2+uDrx0D6y/NeoatPA1ZM/w4jnEaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL drivers use kernel trace functions for logging endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
> the CXL Port Protocol Error handlers to invoke these new trace functions.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

