Return-Path: <linux-pci+bounces-7361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD0A8C25D5
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D854A1C20A29
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208DA7E583;
	Fri, 10 May 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUz27rFq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174C5339E
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347995; cv=fail; b=lQV4vXMAA1SYU1FP3ss/wMnH4kjw0AyGzW5HznlIHMbObpId0mBqnzTRrDc4lUzXVXxf+zZPEaPhcBW22Im7W3iP6Xv3EGvDp7TmOXUp6TzcbsjrGRKuEWv5dQACD3ECQOVp4CdsNrbUHveaek3jdhYWkbPaU5zJtqoDLS33DSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347995; c=relaxed/simple;
	bh=G1hE2oIG2zw5HJR4oB4fwZay9oRnR/b5RnnyLGLiMrs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=StCpnxMOTk13GY0DlQaN2KCtSmWQxCfk71ckoq2Eu/19IgEb03l+XZxbfVFQigtn/eCyae9oWNyy3TgmGn7PDk+4jQoWSrsmBTXm+yTigQdXY1/3QyIHwm5caXmICi4tGshwRSmQVu3uUaOPDbMrs+yGGQISzfVJj7DozzRXiPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUz27rFq; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347994; x=1746883994;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G1hE2oIG2zw5HJR4oB4fwZay9oRnR/b5RnnyLGLiMrs=;
  b=XUz27rFqQ1jqU4GEjeIBbXWX0IE8o7zXfOSPQMcGkALlSaFRMHcO6HtK
   4MvXRakLon+Ivc+DgdFhTNmooPqP/ZsQXzOjz/QWbseVpcW72oPobZE8R
   1PmSdDqbSLGqpoNt8xbLK+odhRTBRd5eJGD2JPC3fex0YJZPP2QOmEAD3
   wDBaEeRMLhfCGecwYdspPXZSIekGmkrN3qgOfJrh4+4gmgFKv7v1v7LSa
   Eqgh3IcCqghIhnJNagXTBim+uXJ4nN3F5p7cTo0tF/++IA4Dm/cz/hyTN
   r0zHwyDzdh17BoOo4EU5y4IMkZ2XFsiqMzpNamdT0LmlfadxRWoKcB2RC
   g==;
X-CSE-ConnectionGUID: 9dBJ8xRZRfWcLKmwn4g98A==
X-CSE-MsgGUID: f2u4pOoVQIKppRnrC1cA3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22734513"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="22734513"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:33:14 -0700
X-CSE-ConnectionGUID: I2swiGseTNWZXgYR3cZN+g==
X-CSE-MsgGUID: /R2K3S57QL+18wAQ0qNwbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="60785706"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 06:33:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:33:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 06:33:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 06:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgWpcYbMEoifEzDFA6BlxGWfHITvrEfHyvcAiUCAWhBZ8xcEuREceJLWhfCnK1pa7LOhn5aecKDZvaCHv3u9aLB8nPZEootb2xHExo/v0DWzBtaDtBizcayux7SVSYlAthS6vXq6OBwHxMa3b3zJARM3MNHE95nw0Xy6h8J9V6yP0MVLUOdAfpmeB+YOF5WWxkVhd1JbM8AMMT5ozQcZ/xfii0tveyBH0cBi3RTX5XLG7o9pJTU7N8WBH4YNpnqMTTrW4rBGYz5yDY7nGqV/y5gGvHFx4S9Dgs9PA6kUGS1hcYGPB5paMttSq7fk9QrA7/rde4OSgYDSKt/TeMZE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfXW/LgpTWetEHp9hUzmS/QXKwWSihe3NkV10dTDvxw=;
 b=nGeNFjvD7bpjCnkcX+y1dRNri6RNR1+/z3CqMrFOQ5A3ArVXCuWunXrPUbA6dZNQW372rrRqJpFGLT20YCMlA+/BiPmjI/AC4ZXZUxeRiB4XoXrFmDayWhKV66Icql6E/iq3SFVgbc2TejKdwFV7q6qVZr0XxS0+gQJ1L7tXRkeRTliGvIKCspaXJcv3C0ThRxLPGbJNSoq2BE05Vj6lICUVxTYzCSy4Phnq63044mFsMVKFpSQP5qcWRhz2jsGIY2903MgulVYJlP4NoQopbOQQls18UT3eKrCRda0L+pB1q2HwyPRt/yTHT4NX7/SKn87XS8PCqZPkxPQPMOZ8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:33:00 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:33:00 +0000
Date: Fri, 10 May 2024 09:32:56 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 6/8] drm/i915/pciids: remove 11 from INTEL_ICL_IDS()
Message-ID: <Zj4iCCV_yD7qhx5E@intel.com>
References: <cover.1715340032.git.jani.nikula@intel.com>
 <36973674bf333dfdd7cd32ae656754bfa150022b.1715340032.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36973674bf333dfdd7cd32ae656754bfa150022b.1715340032.git.jani.nikula@intel.com>
X-ClientProxiedBy: MW4PR04CA0332.namprd04.prod.outlook.com
 (2603:10b6:303:8a::7) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|BL3PR11MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 61be30f4-147e-403e-6adb-08dc70f5b5fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wTKlQ5xs+FHWkhBKHU0Kp9irj8q4anUFMJohKxMlzZ/GO63YtcbR9gk4a+jg?=
 =?us-ascii?Q?wvmkg/vpTVk77JY9NY0yExYMtMrPSEqg5L1kFA7b06zczLRYeHRNPAbMRyZE?=
 =?us-ascii?Q?yuRiAHfSEI+iSTCk1PrbZn7K2H7dffnVX52Lwz0rW3ueJTznXL53JTw/WSLV?=
 =?us-ascii?Q?irLa56sWVYzhQxP5T4OYlpZM3uO0+M0zjh+or3H8amwKYjb3zQY+Y+oHV7IY?=
 =?us-ascii?Q?HOyXi6wvRuySQnb3lPydwsQjEmZ3+h0IXiV64DfyaJJ/rjRBCBxwiZbVuwi7?=
 =?us-ascii?Q?BzUObIt0yBJvx+dOd5ZFvny/hwNOZ7XWPqll3fPT1D23Hlr3+hdv/lHa53QU?=
 =?us-ascii?Q?1mTkK2gGLRDrKeA1IRhpTXotN9aVAJMgL6YWGVY2L3oHP4JOWRsUcoROryHT?=
 =?us-ascii?Q?Pbm/eszLO67zjSwHPF1gsjrq1kNOvkBZLmOIlcpCRsBs0xlH365bta1spzIc?=
 =?us-ascii?Q?3MGixAvKuYm+sysoOzWWoXroGIxh3is6y6vT+GePzXIw6sl4GGCmkid0Oc9Y?=
 =?us-ascii?Q?IM2YInE2oMKLo9nAmNPHacou8cXrnxG6ZqhzURyE3WvLRWqPZDzEKRVVxJXm?=
 =?us-ascii?Q?WACkaroxxWoqUWHBEGdkV1iM/35FCXE8G4lsPX/HnHNpJrVcywew/msJOsra?=
 =?us-ascii?Q?IfxJ5uWvn26SseBXNaqIc+tyPHj9NbvVM1/Pr5W7ltXWwvBGrZnJzqz++g8B?=
 =?us-ascii?Q?QWStAbEYws+A374Esyou/Np6/ptnIERP2aBvFgQydlGDK+LjgBxBI4BkT0G1?=
 =?us-ascii?Q?aGgE3JN+aGRSDVR9tST+R39M1igYbnxw6VD6aXMBKWfzc1NH2hJFlcnvmP3W?=
 =?us-ascii?Q?3GjBcx6+UEHyg0ZD5KM66pNc8QYe8XW7WpuMWjLujpvSN15gz5si0XRBX9rZ?=
 =?us-ascii?Q?zE2dwMM2huljVpBmzeVxsqfrrzCRHDG69hUocc+pV7V+pdk8NxeKueTOtVas?=
 =?us-ascii?Q?0n9CaC+qei6Ihm7rnm/K5IKUwVvZmzmmbulY6pI2XAdI4d2WicVEkZ/fVxIj?=
 =?us-ascii?Q?j0/wCSO39FWreLmzVAZfuw+RLHwiqmwVbZybJzMnweCMbPTIZDHgvtOAHej9?=
 =?us-ascii?Q?XRpFj5qeztS+FSR85AZZt1FnRoxpZofCaEmkBdqXm66UWyU5GmV04Evkwyee?=
 =?us-ascii?Q?KqyYFvLyQs/7m6R9nBEnlVGytM1hi3ddP5iseXHlFjasg2m9zrwmPkTIEfxz?=
 =?us-ascii?Q?CGa70ARW5itrUvZkgO5ClK/5Qwps43GlbnWVNGQT19RFxMC1hVYlqIUdt1UN?=
 =?us-ascii?Q?mFfS1DRcQ627X3tigzXLumBMuT+Gnr5Nr3if599U8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?miX/yMV+9/jqyztS9Au4nbmjqrfb4tA3W8FGQn8gKuwi6XZ+mtEmBNF74tO+?=
 =?us-ascii?Q?sovE7nDdwf0tnQ90B1xRZLwRVe4DYl19rdU5UUSMxoj7/EoP09zPVAKrHivF?=
 =?us-ascii?Q?tQWvhAAqDqDDEL3DyTkkUTaGXrGJQQzIexBXQb6PzAqyTt5iBaF6TZ/bQRxN?=
 =?us-ascii?Q?QQhFNs7BMkIG4n75CrFq2OKyRq8ZdhKuxSMToPSDzTYLWcNLl/pL5HqTgPyR?=
 =?us-ascii?Q?k28SO1lkOws5SPdQpOyYT50jZD6YoOYDvukiW58QqNvyd8DtqQeUFvE7IdE3?=
 =?us-ascii?Q?9ubhpM0yMu88xHmSDi7oUUOMl7Xm+d6GfyOTD+r0Ak9GSuUEBaRvXOj8KUEP?=
 =?us-ascii?Q?V6KvmkSa7qYAcuF64Xup8Txz/Ckm8cxvskwBmt3eZouirwXUR/F69UOWIxn0?=
 =?us-ascii?Q?XJ9cevqGUFUEx9R2/7MMR14gAGuCPeOkvsbaId2uJs8HJxCPV/levHLyb0o/?=
 =?us-ascii?Q?2J/Ql9/PRhFgNcCNFtfo+AIpoWvvZCxrPvfKSGj9S5TGEC2SPWSUH0h3ArVd?=
 =?us-ascii?Q?quHjCNtYSSqvAE/DGUP+1SGtuNQ9fvjFAPDfuqM2MN6nequSu0rvUCssjxLI?=
 =?us-ascii?Q?iMZpz+y44T4WnjSw7+aa6mPaOxKhh0XFs+C4RFADYZjnz0aFR15I1cO/BLxl?=
 =?us-ascii?Q?1I075EAxwYXVxolfUT/CXIOZ3JDKkN4MXfJmK4pF8m1/e9Uf8oBCoJsbBIml?=
 =?us-ascii?Q?NtommfWzif5//5BzhBSCVYqMITNGH2Jk2c7jNbmnklXmpXmAXdfkBAM7kDCh?=
 =?us-ascii?Q?t5rgZVmZiwcCn+wknNPPUENBZtcWwsQvPoRw66GGNPUHHWWXh6znkMJKPlTY?=
 =?us-ascii?Q?ziA9CnVT0brchH8+FNaya0hgR0fKXwrjr0afNQVtSrHE3rogNeyLs51H1isp?=
 =?us-ascii?Q?/MY6NBHQRP5EeQy7dnJLg8907Wf8BnQZc9Y9Uv8AdUSvtJSNsB2yd1sT6Zln?=
 =?us-ascii?Q?MRzgYYjhi6FEdsWuObyT0mZBSj3t8izFOj4DzWd8g0nBP7C41shWZB9WRVSK?=
 =?us-ascii?Q?zC6r7lPLai0YDpnDdUs5hS/d7sITej14an0yAEfCSQFrzWpvc5if5rcGdkaF?=
 =?us-ascii?Q?ttScz57bPZJVTPhEg5V7sLC2B03ZJXaj2y62NciUdrL3bdaxzLeX52I4p/hN?=
 =?us-ascii?Q?BesncNFkEO9iuGyeWPibJ3onpyIA8B+SBWZk+bhiMM+3F8V4G1IUu1yfgzsI?=
 =?us-ascii?Q?yu4FYDMxMX80GyXHGns2HmUJsWk+fF9fvZHbo4iPv2i8J10RcOm5BqECZJsM?=
 =?us-ascii?Q?tF2naW1/xyNqQboiJrDcaI/A+BvXkvzRQIMKV8w4oDlnkbhiqVciYszoZxtB?=
 =?us-ascii?Q?m8voJvCRhAvg6ndBv6UIex1yMFwEwlf36GalHwsn+B/envdn/MLbR5urfGZN?=
 =?us-ascii?Q?LpJNrCQ0KmHTnqhRUATXgOB+C8DPtYPgPlLv4Pz/8qQ4ZdAgEI7cCjNWrLO7?=
 =?us-ascii?Q?upjPpDeVdTIbhR59mYsxl3iez/AFXEAt7CTYA3Zw6za5rrUpcas+VcSvdqiW?=
 =?us-ascii?Q?lWTzx9xzXN7DvG/3YKaVud5o99N4lsuVb9QuorSqpwhDHPpIdOcYGxoeIqSz?=
 =?us-ascii?Q?q0JJgIJr/qNjb/EMA0TNjjhKC8qVBzWZMYtRLVv+99yNlV46ctE5YX/HCeWw?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61be30f4-147e-403e-6adb-08dc70f5b5fe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:33:00.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0Gn4ayAWQ5VpLxOuVk659AaLKKkdMhtX2jl+P3iVkVo27K/TSnrRLDQ76Mvg8ukxcIchFQEdRVIEOay63yMOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 02:22:19PM +0300, Jani Nikula wrote:
> Most other PCI ID macros do not encode the gen in the name. Follow suit
> for ICL.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/x86/kernel/early-quirks.c                      | 2 +-
>  drivers/gpu/drm/i915/display/intel_display_device.c | 2 +-
>  drivers/gpu/drm/i915/i915_pci.c                     | 2 +-
>  include/drm/i915_pciids.h                           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 2b698a3f56ef..c150bb6f1a39 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -547,7 +547,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_CML_IDS(&gen9_early_ops),
>  	INTEL_GLK_IDS(&gen9_early_ops),
>  	INTEL_CNL_IDS(&gen9_early_ops),
> -	INTEL_ICL_11_IDS(&gen11_early_ops),
> +	INTEL_ICL_IDS(&gen11_early_ops),
>  	INTEL_EHL_IDS(&gen11_early_ops),
>  	INTEL_JSL_IDS(&gen11_early_ops),
>  	INTEL_TGL_12_IDS(&gen11_early_ops),
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index 23909a8e2dc8..e47896002c13 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -831,7 +831,7 @@ static const struct {
>  	INTEL_CFL_IDS(&skl_display),
>  	INTEL_WHL_IDS(&skl_display),
>  	INTEL_CML_IDS(&skl_display),
> -	INTEL_ICL_11_IDS(&icl_display),
> +	INTEL_ICL_IDS(&icl_display),
>  	INTEL_EHL_IDS(&jsl_ehl_display),
>  	INTEL_JSL_IDS(&jsl_ehl_display),
>  	INTEL_TGL_12_IDS(&tgl_display),
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index d85f023afebe..06b1d50ae47c 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -857,7 +857,7 @@ static const struct pci_device_id pciidlist[] = {
>  	INTEL_CML_GT2_IDS(&cml_gt2_info),
>  	INTEL_CML_U_GT1_IDS(&cml_gt1_info),
>  	INTEL_CML_U_GT2_IDS(&cml_gt2_info),
> -	INTEL_ICL_11_IDS(&icl_info),
> +	INTEL_ICL_IDS(&icl_info),
>  	INTEL_EHL_IDS(&ehl_info),
>  	INTEL_JSL_IDS(&jsl_info),
>  	INTEL_TGL_12_IDS(&tgl_info),
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 0c5a20d59801..ecfd7f71e2e7 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -597,7 +597,7 @@
>  	INTEL_VGA_DEVICE(0x8A70, info), \
>  	INTEL_VGA_DEVICE(0x8A71, info)
>  
> -#define INTEL_ICL_11_IDS(info) \
> +#define INTEL_ICL_IDS(info) \
>  	INTEL_ICL_PORT_F_IDS(info), \
>  	INTEL_VGA_DEVICE(0x8A51, info), \
>  	INTEL_VGA_DEVICE(0x8A5D, info)
> -- 
> 2.39.2
> 

