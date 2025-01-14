Return-Path: <linux-pci+bounces-19749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22980A10DBA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280C518849ED
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E714A609;
	Tue, 14 Jan 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOZFl2KN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F41D5CD1;
	Tue, 14 Jan 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875670; cv=fail; b=TBUOJFyXcZdOJitqUS7Cc01BjVNb4yzsBVZDsW1MfVhEdFxaJCyw48zhl5xepZW51l2XMB2T5LKW7AEmhSqCtLPZlDx5VFl/R2SZNvXCsDhSNlfuHF0rur+l6ZlRLw7uU1ZQq1kTOKTwOfH1Q6K66x2zL2OnjYxd4D5TbiltN+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875670; c=relaxed/simple;
	bh=Ctz11DzOACatzwsG23/S1a38h24w2TOWNkIJ+M90WH8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HwrnJZVAfXJVfy7Jiv9qNgp3VY3AcRElO9TCd6wYf2/cwhZYAVTjf2JYbf4cWP3GGt0c7uBI0zvmdk+oIXQZGSkMlbYcpB+DRnc/N8HLxKwwOp0CNq5DDHEJK20w5zjebjP0hZbYrQPB7VEhg4XFg8s9BwsDTanf6jZHSr2QtWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOZFl2KN; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736875668; x=1768411668;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Ctz11DzOACatzwsG23/S1a38h24w2TOWNkIJ+M90WH8=;
  b=WOZFl2KN8G+4LJWcFEG/XwAv8LG5mWX37jefJT01volSZghOtuMNih/u
   BVOv74S1x+HB7d8Gs7KGpJ3COCLTNUUTbNZ59GbXZq+tnAL1SKj4gPjBS
   QNOPjKoN2cMvL2MsTeFFstm/EFAeY22QFx4gyE3i8wexmXhvvJD2LBdZB
   jk1mjRWek0bG5qytS+UWsOWpeNpaazmKF9iR8S0rSeLoS3jxj3misur76
   hwn+7cTIVirjESiD1ILoY4nVqQodQGuR8bYjxtOnND2N8j+Y/4isB6DpP
   v64mAEaezaIUyYQI63tfezh9nK5THXkoUWJ6YfT/cKGjIUM/etdSRwIz5
   g==;
X-CSE-ConnectionGUID: z3l0XfT5Q6WOQiqN3CA8xA==
X-CSE-MsgGUID: GbfcQqhYQ5W52dmvitS4Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40946253"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="40946253"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:27:48 -0800
X-CSE-ConnectionGUID: 4e/Ho18gSDSPrLHCYR6jbA==
X-CSE-MsgGUID: PzdqkPZsQLuURtQaQs33NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105040748"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 09:27:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 09:27:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 09:27:46 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 09:27:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRaX291LbuZx8nhz17nNH2SYQ1mHQEttvrtGigP+qg9WvjusfPwaU/tyr2QFR423HtXyWD9U8UIQc4oYBvF91lNV+7CQB6/mKn6nSo5MFeosZmxyETlo4Yq3pWjoOadmvegUQCxbFiWaMCklc7lD5496BK1etWWeitDwI96O6RtbBlGVFgT3pgXlWI/RX+W4pgKPdwPgHWG9wtNQoelPxj5fB6xSOtKMJ1vaj0qal9jUSvfvM0iNhWnXy5iWnV+y5wlJz0t6SePQ1o9hFyQ/u2m9IGW+HlNFwCYgZuwlcz6FXf5KPlZWcdSMh4zcrewyisGlPdLs6eziMj1QiJblwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM3rrOZFT1yiBwCE1qVAUsPOlHXqzwqI3qK/FGDQe8I=;
 b=iKigQA0FuiUhEbW6804fcQOZDX/vpUWoIcWx52laYogKEcm5blZH/KqQmDMRwo1Dcl9vS8Dn3eo++XmWGj4fnoqV0HGRo7Nd8TBNRGuPPDY1+bKzanNTt4ay6fxD8hIOlg+UQw9y9EWWmWxbaW2si+6KHemzOy7Q/HJ/XTHq0g6Pqmrgax7lrlDz0/pIaJNs+v8URO+Eta/kHtmwfmbbT9B4/YgDwbN/YyRKHGl3xpYNRUdRbGQVS5BwalhREEHgAfn0Qj62coNC4aesmw9Wgc/VIQ5wxrBsWKtPO7mVwxPgsHTL+1mdmocWdmjuXOpv3DPfz6i+ASwHvGwEjnc62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 17:27:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 17:27:38 +0000
Date: Tue, 14 Jan 2025 11:27:32 -0600
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
Subject: Re: [PATCH v5 07/16] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <67869e8427ff9_186d9b29437@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-8-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-8-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: c0aa1898-36bd-47af-e1d6-08dd34c0bdfe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fUMFE0ILCWGssWJ1E00PlXOJurltsfi5JYbM4mFeZjUZdEYdq1QK5HQ5/GNv?=
 =?us-ascii?Q?I9eIRTIzo86midSZ+K6D73D+Gh9vcwt2WuGRX3IctqGGqObOcavHMsZMVOPk?=
 =?us-ascii?Q?v/Y1Rmj51Yugcy59O9V9QLhUdAJM5E2eN/EmKXJAQvfJ92PWoZLy6YgD0Zjj?=
 =?us-ascii?Q?w9dislnBndaTCjRPTyVBYja1UNXzdm8rThT+fj4AjHNlMnz3lRuG7oU7W2sL?=
 =?us-ascii?Q?eQSdA4uQhEO6+AUYrB05h5xKCkOVOXO3SMdBE6GIVHdA2CGn4PrA7kHR9WJI?=
 =?us-ascii?Q?CoHIGu2kax6KKdE50RV1ntWW4/+K+z3GkGWovE0/4WUmkSVLUr+aX6jvXIpO?=
 =?us-ascii?Q?iTXV/FhMnWp76kQbcTbfwsAu/lI80fJuaaYeNiO+zEQFyB5fCpUe0K4GOY+V?=
 =?us-ascii?Q?+lB88y0BFtUQ8ABtzpwy6uhathHDaEfZUDZBYjp6ZfPbziQRqKObN+VyiN8t?=
 =?us-ascii?Q?nUV0EN8uIgq8tJXNU8CuVG5ojWAmE5/qTATtRRZliik6wsHqe6ecBKIuWOnp?=
 =?us-ascii?Q?zQSBgr182COEvJBjwjB5dku2z7rl+MYVBgJk4tMlaTiE1ZbriWT7A9BJNM6o?=
 =?us-ascii?Q?XzZXTmynfVu1RR4O3tmipekKKNh0FGYcgzIzTYo7vLmJ9FtR8X1R2fpsaWv2?=
 =?us-ascii?Q?ZCP3O2Q5dmwFT8ZyE3pNCASo2Tiu17piND6hILd0NrCo27mz1JU8lBU8VZLb?=
 =?us-ascii?Q?xZQrddsSmfDrdAYXDHU2PwsRLScHZdSIcfTwPS9K3dbg+pC0jhYCwrG5kNww?=
 =?us-ascii?Q?iHK4T/2shIXkyFKpSkfLru6MlHqsBM9R1Lhf53KzdF32nru3U1wo/QuLhtmc?=
 =?us-ascii?Q?AHypDXAHybSCy28w5w41bfQxIpDL0wFpZRt1qFrwxLbaqj4ItoK5AGCh8I7h?=
 =?us-ascii?Q?9iv8Z8iRKepfTrfYaXwDu88qP6jrYdyQBhCeRKNffwQEugXoPHQW9DLJxR9r?=
 =?us-ascii?Q?Snw469+6Z3eAo1/5FS4wfgtKW6hd856ALyiiObVSQ90Wo9MTEOB7MSLRRH0/?=
 =?us-ascii?Q?dIdVNvZD+r4A2RkgF98jyzMwTYLIiLm+yV7hpp4oLp7gPFy6WDcjFmRbAxxc?=
 =?us-ascii?Q?x+n4L93C6yyWSA9VE/O/ft6rB487fQa5whZMAObRLq0hd8ub+s2gHJ5YUVzd?=
 =?us-ascii?Q?qfxHEl3YRaMNt7tSOU+/Kl5tjmaBtzyeWNWpYbKztL6TckBet06X0/SrSOV0?=
 =?us-ascii?Q?qZSJQ1YgzDfO9nOQDC7Y+NDZsHGP4SbagU1iUywFz+8YDwtEf8gCLvzgtH2f?=
 =?us-ascii?Q?f6tf9OktTc6qWFfGkp5gw1+ToaYll0ip1y9h/arqmw4xqDTYK/SqIS6c/Fsr?=
 =?us-ascii?Q?cl9VRr0w/vg70c6996A+XJNuxFZ93RZaJfVdXODKQYA6iJsqVjxv35ZCM0Xt?=
 =?us-ascii?Q?m8yAerxaaX2Z7xpBuVrjInIeX9lxTnDwZXoHKV8sxf94EZj9cYIpREHTx6Gl?=
 =?us-ascii?Q?V6krGieTHIw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGp4uNtVWb/F7vHNZYwgZai047GoJKSZXKrvzqwl+wLvIO6EwxI0pB1nDrmp?=
 =?us-ascii?Q?CEngmXodTvoyhdWcwlbicc0f5pRXPeqnhcYfD8hH8Cthb2Uyv7YqcAQZus+8?=
 =?us-ascii?Q?kwoU5sjh/T7QQUETRs73nF46+upCzFXiH464kYvksiqlfKbsfd65gJdEMp5f?=
 =?us-ascii?Q?aFaAJNVVXS8NHT3UIt3BvmSlYm5xGuVicdDa9aDTRhHgJ7RPLMyw4j6ZGTQr?=
 =?us-ascii?Q?XC8s4A11C23Km9CC4895zHtKVTqj11TrnuHCtZaDVJdC9yZ0K7IwQm+/EOKG?=
 =?us-ascii?Q?RSyfXI5drB/mWinxpRcNAhFM8qzMXXoHBvHF0XcAYNFLZhYOc6zs4K2Y9F2j?=
 =?us-ascii?Q?Mmng5UlbS3Q3RXSk8uVm2FE8yHQmqRsYMHig/eJBGE04Y+20MA6IXO3WEB8n?=
 =?us-ascii?Q?taoFBvGuJNO4yTH+VXU7nE4ZJZY4bhddXxVxDryvAcZMhLrrbRoHXLWtOklI?=
 =?us-ascii?Q?qzflUkVMwjVyhwywruXvi5KfMsLpfIAzgDCH0mQK4nY7KAgbH4s/VghcJbkU?=
 =?us-ascii?Q?gVDEk0g1Qt4CKCo2Z6sgSgsiC7M+Jnwhbg++onCBSuybtTbeQHggIuUFSV/d?=
 =?us-ascii?Q?o1yI9NbDkiFEZKDuugVBsNmmBmU4wXmDep9WYKBhybTBvJNg8c6bAacbYdRQ?=
 =?us-ascii?Q?w72McRdG0T8GiRiaA5oBmayrUbXLRscQ1lrcEDXhw5RVv9r3EEPWs1CFdKE2?=
 =?us-ascii?Q?AKgkRJbCg9KF5cp/XpEfQS0AqxP8+VAho5MiYG1GqsLhjyGbl2SphZsjGOMp?=
 =?us-ascii?Q?U0el96Wa2WRS1u3KQaOWjN3cTQsELNuKikDB9Aqb8BSEkrXHdJgtDjkrr2F2?=
 =?us-ascii?Q?m8JjAqxCqHzK4z897nNWGXUFqjAOjOXn5ZvKJiIl2t1KVPwRxO8/G1bYY3pI?=
 =?us-ascii?Q?m1lu8buIm37SME+FHq/n2ikTMuBjSlA9VJGv3YlxTaIBBdKRVEU5V/BMxata?=
 =?us-ascii?Q?BvZ0mNlHp8TfPxEprdVbha5PpQQTgy8oZAPUlPFm0+T0SX9DSIQEUcJE3uU5?=
 =?us-ascii?Q?9fKX77Pqf1S4DYIbwyZbUC0kLYqBNIXDB6K+BBNl15aD09YeKgmSgtvCSsZa?=
 =?us-ascii?Q?cUvxCFmZyQszReKV2hYrm+FqtGVtKK+GYt/o+vqq09h/jKW0X2nEep3W1n2F?=
 =?us-ascii?Q?r2vhL2zHj7ZuNdQ8od/0KKVi8RQJdiPXA3QS46rck3Jvb4sSlE28HIr4yi69?=
 =?us-ascii?Q?lBNIWZ2ZFYINV6hWDCGhUtzgf6ZbDO2Ioq/XRcdVUCj2yz1Ef2xAKfxxyjQX?=
 =?us-ascii?Q?FKIKybhKxJpFB+cBgZFIV01ql8NHJSnpXMUiB+Zc+Ptrc2AmkmU1VvttEBEK?=
 =?us-ascii?Q?x59gPGL9UIdX9AeQVh5xNrE7e/cvvUScjYzTAlM9Yy7udGyngCczJo1d79Rf?=
 =?us-ascii?Q?AyE/j+tTFQ08uIji637Bht7NEH0i3RqSkiowCoRDDDIwHNGWjvpEmKM59Mtt?=
 =?us-ascii?Q?pbEGMZUGlPNt5ApY0/uQsMu9XGU6qyg+YqOFHSmklfILaJ8I7ZMqSWh6H+xM?=
 =?us-ascii?Q?x2GUoqWfL7nbnu/wTW0h+GI4pxsgzWABSqSSP3cw/ho2xyyfOE09BWjY1lqE?=
 =?us-ascii?Q?uOQRarBcBedxSuoHrDUZdYRtxgrT1mOGLHwuQvVd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0aa1898-36bd-47af-e1d6-08dd34c0bdfe
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 17:27:38.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFeV8wYJcerSEuVcEnCVIO35ncGBiYo6WbAq96SRcohQ9NXB8T1MBW/NqWADHczZ7CjmreDtFewcUfvrNM75Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
> apply to CXL devices. Recovery can not be used for CXL devices because of
> potential corruption on what can be system memory. Also, current PCIe UCE
> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
> does not begin at the RP/DSP but begins at the first downstream device.
> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
> CXL recovery is needed because of the different handling requirements
> 
> Add a new function, cxl_do_recovery() using the following.
> 
> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
> will begin iteration at the RP or DSP rather than beginning at the
> first downstream device.
> 
> Add cxl_report_error_detected() as an analog to report_error_detected().
> It will call pci_driver::cxl_err_handlers for each iterated downstream
> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
> indicating if there was a UCE error detected during handling.
> 
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

[snip]

> +
> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
> +{
> +	const struct cxl_error_handlers *cxl_err_handler;
> +	struct pci_driver *pdrv = dev->driver;
> +	bool *status = data;
> +
> +	device_lock(&dev->dev);
> +	if (pdrv && pdrv->cxl_err_handler &&
> +	    pdrv->cxl_err_handler->error_detected) {
> +		cxl_err_handler = pdrv->cxl_err_handler;
> +		*status = cxl_err_handler->error_detected(dev);
> +	}
> +	device_unlock(&dev->dev);
> +	return *status;

This is probably just another nit on my part but returning bool here for
int may cause issues down the road.

Looking at this I wonder if it would be better to add *_PANIC to
pci_ers_result_t and return that similar to report_error_detected()?

> +}
> +
> +void cxl_do_recovery(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	int type = pci_pcie_type(dev);
> +	struct pci_dev *bridge;
> +	int status;
> +
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    type == PCI_EXP_TYPE_UPSTREAM ||
> +	    type == PCI_EXP_TYPE_ENDPOINT)
> +		bridge = dev;
> +	else
> +		bridge = pci_upstream_bridge(dev);
> +
> +	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
> +	if (status)
> +		panic("CXL cachemem error.");
> +
> +	if (host->native_aer || pcie_ports_native) {
> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +	}

There is a nice informative comment in pcie_do_recovery() about this
block.  I think we should combine this and that block into a new function
which preserves that for both paths.

Ira

> +
> +	pci_info(bridge, "CXL uncorrectable error.\n");
> +}
> -- 
> 2.34.1
> 



