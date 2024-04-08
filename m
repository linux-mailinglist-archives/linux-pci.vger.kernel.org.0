Return-Path: <linux-pci+bounces-5890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66889CA1C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D21284CEF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71A6142E64;
	Mon,  8 Apr 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqr8lFGR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B31422BC;
	Mon,  8 Apr 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595295; cv=fail; b=PXrXaCwuRcL4zXWDWoKSUKN39mlxOPKYIn1Fv+RQ/jbxXWSNUxEirWWaE1goiYysImGaAq6bYw4n6srLNnCEUDevRvdPNvGn0v13kjjEDhlcqyLhASV5HPQA/3D8E/O9GXJfiiWfUH3lXZ7oZsGRHX+mf7BbyBAtw7AdCPEc6Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595295; c=relaxed/simple;
	bh=GLGm4CturOjS2M22Mlvv7afTDB2VxW12ZN2F3zVNwJg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DiroFytefaXCZao9yZCHP3Ey5afs+3takRZHMx+s7GDSn1dhzSiLJp9PJM8rsUl642O/WW3RotMLtp5OXvaWCxn9vlgBTTMDbs9CSqVq2QCrrJ/Js9ulBgLgNP+6d1NY4OYRfDw2bmUpMhIPdsJKRMyPxv875ES6ZlfDwcFYVmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqr8lFGR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712595294; x=1744131294;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GLGm4CturOjS2M22Mlvv7afTDB2VxW12ZN2F3zVNwJg=;
  b=eqr8lFGRW9Yj0w1u5L8xLHTXNykCbzd0LP23gZ8sPDk6Ty7bwRXVTy1l
   YcvsNZbGsLUV1WTVutaG7y6yYhZWsENs4Xtv0OOrrdeE/pnnDs8xDSzoj
   ZZGjp3N+nX59O858kFuQP/pBl2b6SultIzndoMAofru7OakU6wr936aSK
   l88tG/6jj5yjw7ooot1/qxsDCgKQXLe3msdjaIuzkoFvYDG1wKvlokVwY
   Jpz+EG/DgA8QBkinYjLBM0YsHs4bLj6yMA/cL4LE8yG4q/wAVW9xToOQI
   5ApVfHpkVz96xuQZw63DplBsSbR1LegHCvvrfOqKAXUOqePfevpd6KSNI
   w==;
X-CSE-ConnectionGUID: GAnwZj+wSCux3Naw5WEHhw==
X-CSE-MsgGUID: zBjSDVbBRhSzY/dHuKwXug==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18494714"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18494714"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:54:53 -0700
X-CSE-ConnectionGUID: jK2kV5fxQ+ag8puPjtaaPg==
X-CSE-MsgGUID: oL8F1GJkRzeWBv4992XJiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20387398"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 09:54:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 09:54:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 09:54:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 09:54:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 09:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hyk2C/ZmbHNkvNgWPLpjGwpzgnduuqZqKgQ4Opi8hCsBi0VWuxXIM/Ch1cmwdRDkMGBY5qshGix5B7USdhAtcmw2srETLdxExQbHlCndgBZUNaXr1IxNN0LZT+LTJeyWH3TWZzqdG6/0Lsn031vvJA+pyuvIyf7Ftp5RM0Y1fKBPMjlRmoZQpxbXtIB+ZKlGSr9IpGUWTNqByE4tOzObW6DK2IjWdS1v3ShkF8Z1es2tf+8kQDE97ihPx8mYbeSQd/QNm7v6uXwlu8JMTA6+5pNGtm7QaJmtlMkXYClzPFea+LeFXtfZua88P/wDr2DzIOWjwpdDhURzmmgduOvTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl89HAxr5yUSR+JVUQZ5s4nr2eoWg5o+FJxmgErWZs4=;
 b=GpHlwmRZ8p8S7MaIDcTyQjGQyF5cSew2ukn/KSOIL9yPUf+FNOh9Oib/ejl9ZrUgLs7SnzBX1spH7KFxHftWnQJP/5VdNqNYVY0MNHGB7PovNX5TR9ciP0SgOHyRnT8moqLRl51zTnoWdyHcqPGcyT53zF/S6Rac5kbdmmE8ZEhGlvjnYjPOU5/ibmj+BIOekRqq4lTVOTEX5pL12GR76EvB2xTrVRpqWAbp1uOWMCe4EtD541EWwAVQbozv42SKPqsg3L0vh7r4Rp2R7ssttmkx+1WGex6BPSd3dSsIrF2nLjRyeQ2W2pMqcoV34s2tfGNHypNaplf5xeh0/8XVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8156.namprd11.prod.outlook.com (2603:10b6:610:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Mon, 8 Apr
 2024 16:54:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 16:54:49 +0000
Date: Mon, 8 Apr 2024 09:54:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <ppwaskie@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, PJ Waskiewicz <ppwaskie@kernel.org>
Subject: RE: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <661421574048c_2583ad294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240407210526.8500-1-ppwaskie@kernel.org>
X-ClientProxiedBy: MW4PR04CA0248.namprd04.prod.outlook.com
 (2603:10b6:303:88::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1SmzHMB7daULw3ZilA7S9nbMgs3QffFOGolZwsvFJITNfM+759rCdHFE4xow6Ly5f8HqdeE4eOnt0RRWJ7s/Ytp4reQgspo1M4RvMSPRB/7gwSL7sUk9Ofu0cT9dCCJn9pQbpuCfRDlaMKMOpXSpQYobMpsIxiKvtB7NgEUJvpwp7a2z1CZJ8/oMTa3eR7C4P7gxtf+Yf1VUGil+Vog+pdtSL3AgYAm3rEcEsbeVn8KL+m90EHvgBX5HDPWwiRvQYov5MTyPUtVc/9QjYqhqqtquJUwwhk/pp96gVB4E7Ij+qxgyGkmQYLkfl1PvFcAc+QbhYy23qb4cyULuNxAI7oY2ArMNCor7ixJa4ebCLNQ5kJRM9V4PdXIRu0X2UW/lcOLX2lPz8UlILAy74idi4k9tcdac6wyrp7KjeEtgUInMQD3wAoTkYFpjUBTicBNmfc00gMmXI8s2CoyCnD7hkQ2fNkonVLAQhLVIuIY+NzXE808KrP058yUAvUxoB4OhNP1ypdmpweZfWEjHvhBxM6ksibsJcKAsGWvv2jyUi4hApP9Byo4wKDjaWB3Ch1HhO6F1sBrXF4aAr5ZeaqR2c1PNnh2757FDJhotlHlz1XWabdpSyegRDjv7QrpQsZQC5pgNthUe/HD2+Y2+6UMBa2Z49DH5EfzDgCJx9KuzdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DkR3hscpPUwUtOH9sXqiCgE2cH9CA5E6QcxmG+0gFBRAHffRvb7/7o3uLEJi?=
 =?us-ascii?Q?0z1jlhKa8cCzvDxHmdcL6D76KyE0V9WbUw+s7UsS2yRqwi7NZ5wxwRoBM9j/?=
 =?us-ascii?Q?sHPd3I6MySuPzWFfjfh1X4DBmkAX9YsFtiI83Ox8lixg4d3SOCIzVdyd2mNt?=
 =?us-ascii?Q?qmbJMXSq4LMewzXp3gc+IdNN1pZqVqgDXl+zjys+2D9Uy3RUX1AqzaHYk+T3?=
 =?us-ascii?Q?vqDHWTm4FYNMJhI5j1vVwryI+pWL+bGs1sfRhj3VFgjbmDPhyqO+LAE+UwVf?=
 =?us-ascii?Q?7Ht9Ha/I3zWhQyUconwkh0zg36Q9/5TLHdIcXzL+j+FpHZR6swgOLSfwEWQE?=
 =?us-ascii?Q?LIyMTYdprYssrKFz+pz5ufQe4LN2TRTv4Bh+cXAQoxSEdEIdrMrPW1a0LCoE?=
 =?us-ascii?Q?kM7qD4mCCwAl8jTa7lUay6SdncDENnMz2eLsE2X/G6s6O5yjBAl7pOmcS/Zr?=
 =?us-ascii?Q?XTqC7myzdsnoW77Bbm0+eSu57c5U0/hVa375dfc4TA7Hvf/dyXA6XXivgP5v?=
 =?us-ascii?Q?qoWttiwlBLaIBDB/p8KLDa9jio+789EUOCsgTLrLVPylyE1sIz8b15jFuQjS?=
 =?us-ascii?Q?VCoqD1WHIX+4TwU1iNN3ri3/+qYlaG2urScQSWmxjE4lU+We3h37CMixTi1f?=
 =?us-ascii?Q?HaUHEwrWC1mHwys4G57r0TVzixI4Z16RVXYbauP/1PF73mHcAbgUHKsGK09I?=
 =?us-ascii?Q?Xc69uc4kR9phufPGRBV95X/av4ESwriQXtDqVl35ALgOHntcQLKo/wOkDv6y?=
 =?us-ascii?Q?WUHMYz+O5wRkbGkJGG+xaNMfdHi+ODYb0AGgM4ibSOTmi4Quth0svzDjFHF8?=
 =?us-ascii?Q?g9lFzmSqAXe5rTRphvVWiaTKMM82kGRDkRhXuIMhckLe921czWmuOrJS1KSq?=
 =?us-ascii?Q?xyXkComKbTaxqnrIA1ejlSBcFnDK9IrECruQvjuQpOsFi7L7MPyj1adfu9C+?=
 =?us-ascii?Q?4OMaNnPGKoLOYTgrr6Jgc2PqqtsPP4f5qIt76SvqOUMrAkqbWc+HvICJsf/V?=
 =?us-ascii?Q?5BOnB5X+bxeLmfUeDKVjeo+csYNNAcpRpv0FpT7QyP23nL+eeSEVdEeXl0gU?=
 =?us-ascii?Q?7+TukJBvMUdS7Q8Asb6MgSYlG6E7l1m3iCvz31ut2FIINcv8tEe2InEI2plZ?=
 =?us-ascii?Q?4o6GfJ/shkhLV8dhlQCKvgRz59Hgsoi7UEmWfOPppTx1P0c0hnmJFqEnENYG?=
 =?us-ascii?Q?LMQHVS4iNvnmPRz6II2W3HwYwDMIeCTQ0yM4zxLIw3XJNgivCKJAzoBp7bQo?=
 =?us-ascii?Q?Xh2fCRBwsUeYk5EMOx7haaQEKgvjFO2qaXBaCEZWO0zKIXYaH7z/A/VrWWyT?=
 =?us-ascii?Q?YlWXaFjx1fMyjCPId8OHWHhEBzJY9NxThgGduSD1MOn96ore22fwoPd9FWuu?=
 =?us-ascii?Q?UaibUYkGyBKjo9r3QF8Tfi64PJ/82ezoJ3un+Qx8OymVicR0HIAeKX1vMeRP?=
 =?us-ascii?Q?Bf1SENGVsDavXm7lgWH/pl3pMmhdJfasUd0ICXgNk/1WoCUaB7nt0242T8nV?=
 =?us-ascii?Q?Gc925iyZrCFZYpLZn9NX8gj2aVYhDBxh+1xPwZRiyKX8IhWqF61tHR7z9bmx?=
 =?us-ascii?Q?xxSwrzqKpnae1BwPQWWstpWqXAS5HT+UcRbwc5//Z397hH/OlH/q/6MvCkOU?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd16d068-babb-49fe-4aff-08dc57ec9a47
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 16:54:49.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaYSvhPV6tOumBAjG8/eI6qKDSiAK8dPBV0R/bjEoImVu5GcZtJWbAU3QvM5fmMzYLYNOLo4OWWIBkhLeqqfgwy+olDtMsJB496BNosLxck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8156
X-OriginatorOrg: intel.com

ppwaskie@ wrote:
> From: PJ Waskiewicz <ppwaskie@kernel.org>
> 
> Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
> drivers on Emerald Rapids systems.  However, on some production
> systems from some vendors, a buggy BIOS exists that improperly
> populates the ACPI => PCI mappings.  This leads to the cxl_acpi
> driver to fail probe when it cannot find the root port's _UID, in
> order to look up the device's CXL attributes in the CEDT.
> 
> Add a bit more of a descriptive message that the lookup failure
> could be a bad BIOS, rather than just "failed."

Makes sense, but is the goal here to name and shame the BIOS, or find a
potential quirk workaround? Presumably we could fall back to parsing
_UID instead of a string and then get some guidance from said BIOS about
how to lookup the corresponding ACPI0016 device from that identifier.

In other words, I see this patch as a warning shot of, "hey,
$platform_vendor if you
don't want folks to RMA these platforms please tell us how to do the
association Linux expects per the spec". Otherwise, this can escalate to
a loud WARN_TAINT(TAINT_FIRMWARE_WORKAROUND...), but I first want more
details from this platform like an acpidump and the exact error code
acpi_evaluate_integer() is returning.

