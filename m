Return-Path: <linux-pci+bounces-15235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E509AF248
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 21:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BD51F2119B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 19:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7A217313;
	Thu, 24 Oct 2024 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fziQSfCw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1702170D4;
	Thu, 24 Oct 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797062; cv=fail; b=FhOxb/qzsA7BKTM7xF2kqatzwdfvNh77gj5DMod9fFJu7aLG62s3hYvmcRwxLJ5ObPjS8h7QeXqDmbNHK26oqmOLFH7Di/IL3wWXT1F3wtpVMjDQRaOMioE/I64vzi6YU0MM50Bpm9TzIIz6lHcJQ05SHgurOx1wFe8DqgTPTo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797062; c=relaxed/simple;
	bh=iM4IVF5Tma5CiiQS+QdL/BTEf8ZF0uCLBmLaYTksGz4=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZE7OiJuAfElQ5G6DGMU1s6IAVwHMXzWiSa0fm8877ZJZe5Dn/UuVtrC+uUuiSXVuYkL/AYNI7McRVuSsTgpCjwlPobHb3XPqoYpNS2dhDH9uKFli7del6k6kdm5WWvZ8e/UbUEIYk67FpPY5N7yDYahqBm5RWen7ZGEHonlrpjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fziQSfCw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797060; x=1761333060;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iM4IVF5Tma5CiiQS+QdL/BTEf8ZF0uCLBmLaYTksGz4=;
  b=fziQSfCwhk9MBhwZySVnm3/qiavqqQB0l6lOQwJHu+k96CGGns9qaOoL
   5QL10927plITCe2nB7D8zgw4aIMtHsZ97lstChqT0UUJV0oK73ClSIj3O
   GXbbv+etOTGuo+EA/1GrZJPE8RdExPpe8adXw+5iql5JyeuTzuZHu/OVI
   0jP1XC/Rm1rRhXWDwq8L/754ldEJtl6F8RPrNkP6X17rxKBO02UEu2wEI
   /WrJhKXX+3HOvSvnOcdpWA/xc1cTP74DSt7lcq5mW7Un1GILQC8CEBLgT
   O/KSpMmKbOicYOyPC4uw6vtVJzmo4xvo/vgmhUEQ+gSG+vMw/TF5/CnHK
   g==;
X-CSE-ConnectionGUID: 5SYS6Sp5RnaiVl7GScwm0Q==
X-CSE-MsgGUID: njoKliW5SVqCOx/j40ZGpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40068881"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="40068881"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:10:58 -0700
X-CSE-ConnectionGUID: gv0d7iArSRuIIjazhU1c3g==
X-CSE-MsgGUID: /gufXM+kQBGPjdlYBEwh7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80991206"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 12:10:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 12:10:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 12:10:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 12:10:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zpt1gBCGefzpk/kbB4hDY5QGKVaeP+p47ewGbDouvdD/8lUEBo2JwmOnHUlwSNmF4WpHyszUpa9f4IHUJ8mgCdn1Jl1hYdph5tQ+9I25Ax0ZNzNQ6n6IaAFfbj13q+CcwVvTGNSc3ExZ1UPdp+Wq0b6Vp0tHtnOs4Hao6IxTpZV/c0v7OUQKynzyyPbh/I/QnuASB29eWltApP297SNMwL6RcplGh9wX/XK83gk0qfVRI/cjzuskGHOhbkKzdNQdrkMbP7JgOO2zyc633YkadToA0JKpHcdH0SMn4dxiWFqSw/s8NtnaTd3zzzNPfiorFOSgn5G1JMAwF8bwhXBmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFrvTVxXwsNPWyskehxLIAni10rLtS/Dbg9qz/xe3eo=;
 b=sNYez3lzZCrjIRuyEwOqVkSpKs0JhlOMjg0u8AHqPZIc5fjN7LU7KlRJnD6yLJwJqGgKnskWt2Yh8IDNTG1TkQd09jQJkNHlGfYVuNqoDGVq9cJOI4s6xBRHmLIwMULp7rzX9hbw81QzhtYgTzDzmbQfDsoQ/77rARDXBh9URRyyy1RhTqqC/skSp+1ry6gTbLCrYzKrxFuRXQYnBPY7Ihx3RPqjMzJpexmR25YBym12F7CCmmvWltE6E5O3gqldboDrcYDmMRLs4LFzKebn85XnIbgs0Ka/2zBfb3Nqe6k3bmZVSDBeOr/FQlnVqDY5/G6uKk9JqubkDywhauPvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6265.namprd11.prod.outlook.com (2603:10b6:208:3e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 19:10:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 19:10:52 +0000
Date: Thu, 24 Oct 2024 12:10:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 01/15] cxl/aer/pci: Add CXL PCIe port error handler
 callbacks in AER service driver
Message-ID: <671a9bb93ecce_10e5929419@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-2-terry.bowman@amd.com>
 <671705b5bb95b_231229468@dwillia2-xfh.jf.intel.com.notmuch>
 <0cceca3d-f69e-4277-bc9f-2556fd212ebb@amd.com>
 <6717dc2ec6c90_231229487@dwillia2-xfh.jf.intel.com.notmuch>
 <b3fea77e-1103-40ab-b7f2-adc545273be6@amd.com>
 <671838bc84b33_4bcb294fa@dwillia2-xfh.jf.intel.com.notmuch>
 <6af9d0a2-97fe-4296-9ceb-bf9e7fc91d5a@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6af9d0a2-97fe-4296-9ceb-bf9e7fc91d5a@amd.com>
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b6fe84-0800-4b61-f424-08dcf45f9425
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?0AX/zyULxQh3pxchmZenagm/tVWdDevFwkWcq8DOv4YoG98AthptscmohX?=
 =?iso-8859-1?Q?4tCyp98BgDDC5gvxi4UshBXnpX/quyc+vTFgxobBbzxzpq29Z5rvrwhUrD?=
 =?iso-8859-1?Q?ZrtYgEkfBG/QEetezeErtqO1OzRsf06ipRr4BiKztYA719Au+pUGHTXjL2?=
 =?iso-8859-1?Q?87ImHMWTsmpNohSEXqrPuWZxddxs1s3KqM6bgwLf+poMkop2zkS48XEhEZ?=
 =?iso-8859-1?Q?lNYn7NxfyikvBCgEDAGdGufG4OAcYYz4e041rHq1SPWkQA3WQ70zp5e2OM?=
 =?iso-8859-1?Q?0EzKfIIYivSsEoq/QdGxhBguyJFufcRLXO+yAJYrBabI0MoyJ0NEZonKx8?=
 =?iso-8859-1?Q?ZBQkatLUBjD0ayq7DMGC8N7z2ZN8CuK4CuvWMbS6ut+BhJ9sjx0r/8qFml?=
 =?iso-8859-1?Q?vSNY87fGAu9SW7B2EAxSz06DRcYxtlxO3nR4VpODWxm/cb/F9Yxk03D7EV?=
 =?iso-8859-1?Q?mFaxtytI2+lsIiOo4Kf+L1HkGP6XpFyP1XwobRYdHfokEXNwFJ+96MSsId?=
 =?iso-8859-1?Q?S3T61SUeUCqDtsJgX7urNzLYNYWdUsutbJlZ+TmrZB7Au+PDFqv/eaB3e0?=
 =?iso-8859-1?Q?4EHd4pZNyx1RSa6peZ0b0YldFMw2apGouTU8XiqC0jOyL+gRTUMQXauOgc?=
 =?iso-8859-1?Q?u3WkwW93Aco5eDeNbEhYd6nV7sMZz3FXPEAuEFYYdtNT83uld4CkFGpa/A?=
 =?iso-8859-1?Q?Abw1yq4atiuARH3R14Ir1W1ljv8sl7/WHEjyutiZudBAHArm2KpJ+b+JVx?=
 =?iso-8859-1?Q?cWJGrtKkTSDM6PABSC71jx/ez0UuUjZp4PMSES09Cg1n1AOde/47xHlQHW?=
 =?iso-8859-1?Q?e8GsN8/1+xK+i6+SrqHYUzQIIaRI4/7xa/bPaoXvOwk+6zpswY3AYVFGeh?=
 =?iso-8859-1?Q?yuuUNb+nlTpPYGceT/0lYi6bFATt4aNBoonT8unKDXItvkOtrkDcSlEiuy?=
 =?iso-8859-1?Q?sylkVEMkPjRyimmAraQ7s7JIpvw/4DSJGPHQ+mPHC9Mhpl3Rk3Dusw8ZPm?=
 =?iso-8859-1?Q?qQ6LOrUYn68eSwQ36Mtt66o9Ip1j/yDbUNWKtkjnsIRPdUe/WZ0dmHD+Uj?=
 =?iso-8859-1?Q?PrkJCTkcc08Da2xGVn0nLJE4Gx5xVIqgs/KxjRHxEt4IoV0AqJ2w1ULXf8?=
 =?iso-8859-1?Q?4j30UydDLPydGAUYX/cGxuOqb8XgB5XXEvUuX7K9AV4SCk39kO4Bs/0iXW?=
 =?iso-8859-1?Q?nnwzz5j+PVAiLztdBsRywUlmMd6KlfzZRVjQ2kxjcXW7lDN00fK/1SOpB8?=
 =?iso-8859-1?Q?DEMSRDv8MyX7zP0EuMjDqud4hyYS4V1ZUwJDB5Ct9NdxaTzNOWuSfDCy/Q?=
 =?iso-8859-1?Q?pyGNJuMD8lC8Jvw3NpT+pQ2tv8gjoBnkdISrNyl7oXDp7D0B8/1gW3iJ4C?=
 =?iso-8859-1?Q?g1h7uC1gYJI0uNxwbw1ZRs4T3e8WVtpgzmyJps4BrdtbO9aOlAx04=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tAVH/yKEmIHNPwFGyhaPzfZtyCbYYWs/XmE4fPPm9JXNJana2KFWFNvtiP?=
 =?iso-8859-1?Q?tmdusirVLR2rXfAO6dOWAyt17zcsBSRFfhhqrKeNZQZYG72yyTNZXu1Vrq?=
 =?iso-8859-1?Q?qDCCpsOec+Q23L2JH9oM+QS147c9aj0vtPeW4BWszVg/GpMJOjxACsfaPP?=
 =?iso-8859-1?Q?/LRHov7YilcvJx4pEHPMlYynO84ETiFxbdLNvQZoQy+wic3gj+RfmdkARi?=
 =?iso-8859-1?Q?Id9IWW/4QwM+ME+3rkp0D8qQOWZFSAq8C5HymbIU3MM1lNlODt7GEh4AuG?=
 =?iso-8859-1?Q?Bo5pA/hyAbdDNoY7vqCVl3ySQRZc3jgQpGiZvYfFQVx+8SQ+y4R/PhmRFs?=
 =?iso-8859-1?Q?7f9q7sRIwOUz2T0q8CjSnn1uliPQJFuT59PFdy4hacrY9oiGJTF9LzWVaG?=
 =?iso-8859-1?Q?p4d01aLHGBm++jRucJTVMgkabhCiRX4RH7+l/rsB6/XhEyLqUg6DcX273G?=
 =?iso-8859-1?Q?DTRpwWiYr0Fxv+luW4cpbbUoVkNW8AO+THmjasQGAFfPR+HAQck3NQBTye?=
 =?iso-8859-1?Q?1CBTmDZWFyiPeTLS5oOLWyr1Pxz7F7bgyiKyuwbE9yu10bD0Apn67AYUee?=
 =?iso-8859-1?Q?T8MFN9gABmTXufXKgIIohy7GeFa0MJ490/wgRWsiQV95iVZ+g03u7+vVwV?=
 =?iso-8859-1?Q?iOp+SEMdMBoxFhmG42btRJIz/jLs7DNT+muoJsGX/PouRiYrBJ/Dj0j/wZ?=
 =?iso-8859-1?Q?uxbCVabtFhvX0nSoCzxTCQBuv07JQe4pZVIaM4AyCYST0y5qp7R/rkOh2K?=
 =?iso-8859-1?Q?oCQ7LTIrO3ZXRNH2VbuLWv7zydDb9h3We+6R/ZhNOqXFyRyqYlpWFoRBk7?=
 =?iso-8859-1?Q?nMO8BGk9+qzXWy4iz1ga/wwVbNIeOvDWrkCFaEZV8tWzoaB9okOylj1zkB?=
 =?iso-8859-1?Q?t6Sj0bAXkhg0JC5WC07PRVLAjCv3SagMxFcEGgi8xpoEVtakI97kVoO9P2?=
 =?iso-8859-1?Q?yB4OvrvVUAgz9mDFtBaaV3DaMgjZr/gKzNKH37/W6Vi8n6CajS/c49E6GT?=
 =?iso-8859-1?Q?TgvK7UD6i8YXwXJrwFO3Pu0CvEP9ccPUxnnYhZ+KuWMGMNWfen7cc6rhF6?=
 =?iso-8859-1?Q?M6nr0aSLDlYWEsn0pdYL767IH1EjLfdFAXzoAymXhwon15UZQcbzibgYT5?=
 =?iso-8859-1?Q?NSPVIbSUPH9WAQ+Y/9eLRWvXMkJ0AObqBLmC7Uftke8nssTwf2HQ7mdkoq?=
 =?iso-8859-1?Q?bEoOjmzZfhN2Rt4apVuD2aClnAt6Gq3YNPkfWWTNAsD7+Z9PXq0Bb18eSC?=
 =?iso-8859-1?Q?CEeiMlAsdDhXFDbuKrytFqJ5V5kK8WOo9SLU3aIAGUk3FriaSBDtv38HBt?=
 =?iso-8859-1?Q?kT98UiwmFclk0Rwhe8p9CrboeS6dQl9MZnmGnD7eMDp16/EtwlIR14aJIh?=
 =?iso-8859-1?Q?0+IR2AeF6KyNYx9KqHM73WkTWV0EJjCGZn+5PFfYdu2vTJbVXwR6+JDbEn?=
 =?iso-8859-1?Q?uM/vMRKTnQ8IXsuCOyYaylBOex+NTCQKvRzAnxcURM7lQapW+3YRUaKZVh?=
 =?iso-8859-1?Q?ISNt0aCQROIeoJsOUV2bkFEIrNa4NSZqmjwrDR56OQjt70s4lCeRwDTWh/?=
 =?iso-8859-1?Q?LHBAA4rn+Z+Ju0J/Q2nrQj6U3QYofpj7tLjD4yg8eGWvwP821V3l4jdLib?=
 =?iso-8859-1?Q?SU4fE6ufWudWS2WC6MlhPBAoOFiaBH87DEfMaJDBwWJtVazI1ukfsETQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b6fe84-0800-4b61-f424-08dcf45f9425
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 19:10:52.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eDf0blM8nP959FVYU0VdckUEgK1cp4iiQwP6RImbaoSINUqlI7/Ei8DDD3Lf2PEkQq7DjYin8AeOmANN5Qsy7ZV3H6TM83eKFYinp26ohU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6265
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
[..]
> > So, in general new operational models == new data structures and types.
> 
> Would you like to continue to use the pci_error_handlers for the CXL PCIe 
> endpoint device driver? Or do we change the CXL PCIe endpoint driver to 
> use the cxl_error_handlers ?

I would expect to extend with new 'cxl_error_handlers' support. 'Extend'
not 'replace' because a CXL endpoint could in fact be operating in pure
PCIe mode.

Otherwise, it is currently ambiguous what an error handler invocation is
signaling. In the new scheme fatal CXL errors are panics, while fatal
PCIe errors remain device resets.

So the question is how to distinguish those events without separate
entry points. Either the error (bus) type needs to be added as a
parameter to the callbacks or the error type is implied by the 'error
handlers' type. I would rather not go disturb the PCIe error handler
world by making them deal with an error type passed to existing
callbacks, so a new invocation regime seems appropriate.

I am open to other thoughts, but this seems the most maintainable way to
handle these parallel universes that both happen to fork from an AER
error source.

