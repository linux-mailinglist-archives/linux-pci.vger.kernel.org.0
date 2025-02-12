Return-Path: <linux-pci+bounces-21309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E99A33044
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 20:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F881649E5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 19:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC8200118;
	Wed, 12 Feb 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1RJa8aT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FFB1FF7A9;
	Wed, 12 Feb 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390283; cv=fail; b=m06klv3ogNx9/NoSMlXWZ41ZX6x4tdRBlkdeQwoYe2VHnyM+yvNYsGn9KWZmi3BP9qNtWC42Qh4S+fdk2OFPNS3RBRHbccNWUGMyxZcFi3Bzn5BJUBAFEfq4v4cyfX666R5PhBOEuFh9tCQhue8pneTUQjUSWZrw6RQJWxbiuDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390283; c=relaxed/simple;
	bh=Lnyc+wbLYz/q0w6RTi0PqGggl8UASNCDBqBjATZO4M8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FDf5W6pNwg6t4NpNOG2X8MqTGR9lRkD7CZghi6mCQ6tDlkrwlNsv72OqkLfMrjQTA/k9gL1d39dZwvuNMsAmTJuntQSidxiz1y/rI5RIowJcvZHiWDA49Csu0ybVdWaoA+y7Bgr2Vc6Io09kJ2NCzgvDIx1gvejzyBgJdinMlH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1RJa8aT; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739390281; x=1770926281;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Lnyc+wbLYz/q0w6RTi0PqGggl8UASNCDBqBjATZO4M8=;
  b=d1RJa8aT+ZIdZdFkUrxilVm971F0qIIPC6BtXck/8pcglpGw0/2vA8Jq
   jxQXcpztyLTF+LPiz6xGknd5Q1wrORe0sYw0QpTK0o/BCyS/dQQbSWEHD
   HK1p1k2Ha7AWri9QA/osqfBZ2gW4TgI73X+/pSw33CKeSxZ0EgMFZea4/
   9Y0od9cxYLBF8mHMiIXCYrt521sNwAfOB5AyJrmcyUT2n6cI7Qjamacot
   l/iWRduZZixUq1uezRpcUt1eihaJtDDsM9t7zndHcQy21QNBOUoX/MMPr
   Qm2buwVs6cbuQzuSmnhoj1gdzFSJZvBOAlz5N1zRMzrnqEuvOnB3bpSR6
   Q==;
X-CSE-ConnectionGUID: mYtXbM63TtGll2DI9sYHLg==
X-CSE-MsgGUID: F97Sg5ruTbWwZWp2OOoSng==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62534678"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="62534678"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:58:01 -0800
X-CSE-ConnectionGUID: hBAXW9fPT4yeEtNpFzYQ3Q==
X-CSE-MsgGUID: JoS9btpERbaQ+G7Nb3QYJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="117926143"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 11:58:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 11:57:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 11:57:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 11:57:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXxsP2AJKDorixhK/PEN8kbqjl7Du3qoumODSt+j4vHNba1aL0RA/UTodesnjuHglTyTQ6Ns+WFdCq0SFbw9pDOcgGxWFv6iLwXil+ZnpVM/uGQmJHjTDCjkmG/tRxJMXLUR7rkZQL37Lq0NSd0cO8z1teueAhDAzpm9qgks3p+TQb3icGu5R0SC/B24+QbEnmvWJ+yn759M1brTV6f3sW8Sm6DjxJEoG3AmK2XlVvuOPFg59KywHINmFY9Vub3O7Yq4R0neuUnHool3kHyqfwc13zfZ9fG4Xmhe6egChuZfsC3o11nWXfRwmmrRVFEzm0oLJfuyrjC5s+EGchMGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8uwTmp1U6qNOSyFUCTdm6SFMvny9j7f7jAabJGwY1c=;
 b=bu2Wh2W3AirUtsoGA5L2dwTzzhifbu/dFGRbG7q3XfozV0N+In3IjrqKDNRDNsC0ii+0lPT4eF+qF4HjyAN+z/PfGNtVF6NYbTlmlavrAQQOnIwAkwSbB1C8EsfgWxSTTJEBfOoZ95YrPEArjOaN7s+ZB7+r4A7zmg8vOFKt4e5TKSE911yXYNH7kYn3tK7ZAccy4aOLaknItQKjks0Eq/IEGhImbe3i4RIWz/ON0HNDPNTecbYvvs142GVtK+iDJawtHD5UlqNOy+cSI+UkN9uCePKPqJmS9koBhaFq1tqpLFpw9KQS9/Dhs7e4PCiBQWBa9NgYNAkLQ2C0d13rAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 19:57:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 19:57:27 +0000
Date: Wed, 12 Feb 2025 11:57:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 04/17] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <67acfd24a4245_2d1e29437@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-5-terry.bowman@amd.com>
 <67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch>
 <9035be0b-7102-4abc-a21a-61648211be55@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9035be0b-7102-4abc-a21a-61648211be55@amd.com>
X-ClientProxiedBy: MW4PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:303:84::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: bd31fe6e-8be6-4239-0cd0-08dd4b9f7a1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DAqPVKoz1bfLspUShJvLcioaGOWxTB4kpeHanezUSkvb5CORjtmxuu47NxQN?=
 =?us-ascii?Q?MGUkytPZrPdBb0592Uzpi0Sef1yQb6y8eFdyqmlSsqKGtN41XZ8GfXRNCXJv?=
 =?us-ascii?Q?kTKlJQrP9BDnAN+pEpAjwJVFsrnZYYeyNsFrtg7l+8BNMXuluEGt5mFzf5Q3?=
 =?us-ascii?Q?NM3AInWwbADP0Vkv+4w2hlz5se6l7qu+wDxIgclY64IjrjqS2Nvf6p+2kMgN?=
 =?us-ascii?Q?YnyH/BEkjF5Va0KE3E4NeWaYjzHdpgDIMyQn/+G3FBTKp6SdwhrqdIjSYxX5?=
 =?us-ascii?Q?cdh9/YqoSHd7XkMZon4ruqec+hl7x9oIN9VK7HD3Zy2zA8hH+kewfmyM07DC?=
 =?us-ascii?Q?TJh6Ph1Dx/Jz+BSczcbR0Q5GBd9rbWOurne+EFfnyllLjO71Xekb+QBNns2j?=
 =?us-ascii?Q?Qc7/2BcqP4qfXGCEFGe6MNUMvhDV7nZeMv4IL46Qlk6VPURVXJMwrtI3zGg8?=
 =?us-ascii?Q?Ch0UebfMzhLNMfipK+Fah9vhg7tYthRG6REJd4/THMYd91cr3aqMNGoYvgx4?=
 =?us-ascii?Q?LuoRTGhrxMhY+2ziAeSUagYS0QwNG5Eocavog3/ks1c+12bCu8oq/uD+SRJS?=
 =?us-ascii?Q?DNhffQgCfRpdh6cVx/egFxxTA9X6N0Fa2FCs5iCtGA6TpzPx121P71qzdd7g?=
 =?us-ascii?Q?5tEyIAgAFBiwckYVS/AJwtAxDEHKIHZrhHrbjiHrOolwKWLWYR4hAY/1ZjDE?=
 =?us-ascii?Q?X6Yo+mspwtFaJmHSGIRZAqwhFfZFgNCElqRURKPbNLDT9ZTFxzg0rb2tuaMd?=
 =?us-ascii?Q?JbW1aDPnJkzDahUuOEGlESSD/ezex+u6090koctfd+DMnls+OFvMduktWwPy?=
 =?us-ascii?Q?F5YKHSVPvG55NXbcZi/ApIkjbgVuDMaQ6pQXruurE4HFZkvt/EWdf6oijjCj?=
 =?us-ascii?Q?RQTPQkc538912Nc+BCLRi0DfiScTUtq1KetD4TbuYYCRU+wiw5LoUkp+Ia7j?=
 =?us-ascii?Q?U6Te6FW/wlAAMWAHEMPrt7dCzBwlzZRsgVjiZ0+ushnB2xkXlqnStLXuhaFj?=
 =?us-ascii?Q?Fpnd/u+aEHDHbKDyCAbQpikc5DUFg7g1cLEdqiguA93gwfJYNYaLRIle4IXK?=
 =?us-ascii?Q?fDX2Lr3xYbF9qPxjQhTKZn8iDqyhZALhcAroL/sIYrMGTTAD0KxXFmU9GQGU?=
 =?us-ascii?Q?zLIszHzen/ENNcMofOMfPVBBr1Ua570p0PWX8565bG/2v2E40Rf7plZ7cOn4?=
 =?us-ascii?Q?6pgR9ZGHiXz6xwKrf9rXWgRmeexKF+vDUBLg3k8Ga3H0Qk/9TVgm+z/DQtNJ?=
 =?us-ascii?Q?O+AFLAeW+/CstJYyT81ZsM0ufPT8wHyA6hgGVAVS/0+SkR8IUeECTx0uNJwl?=
 =?us-ascii?Q?eTu980N6mEt3nI1aE2cP9fY9umlBTNIE9ihY+fBXJH1nNxr1Ja5wK3aRgZIg?=
 =?us-ascii?Q?5pvrH0HHbsWgWH9l9FQx3IY4jS4M2lsZtQ7FZ0hvLUHrhN5UfP/JTHKZ6PGI?=
 =?us-ascii?Q?/FLKElqF29c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lnUocReuOctiXrW4p+OsueVRzkaYlx3I77GZ28gDXRtfL8Ng0uwF1s6tdTKQ?=
 =?us-ascii?Q?7YFAJq5D3UuKofN/gj01kTzxNQMrkxCEpoaybiPmWcHlysFlIxFI1jZ0Ktm7?=
 =?us-ascii?Q?SdvY3OU10ZqGuM3jWwfrZkKCuhug3irpFebco92yJr1br2ExyPOvA2xLr+8s?=
 =?us-ascii?Q?XPB6loPVZ5CYDwkGL3VWXEJWHeCFlMVCWgfcZAAbY4QSmCQ1zv/pZhGftpVH?=
 =?us-ascii?Q?bqBQyRnI9wIKT1iURzvVImUStUtrydMHsxpceKB4r1E7lo2LwJQU8NXQEMq/?=
 =?us-ascii?Q?uF7qBWm8RA7dizsLBUiFpzWSrPkLjFaC8YhINAV5UEGHxIMRVEVs7E7iWAXh?=
 =?us-ascii?Q?4HwakNEP3R7Kd1ApAUgrC6JRnWys4iV2kVMv7PhqlK0acRM6mULbEgCzuciD?=
 =?us-ascii?Q?oyAedTMNe+SlvOtacgmChX7yhGEVvxnPS8p8N0jn6p3lGSWWut7AbGPpUKqj?=
 =?us-ascii?Q?n8URyjY6648iHcMcGqOkDozdTu1kfSwZZQ2GhoiqoUs3lMaO5Rag67OT688b?=
 =?us-ascii?Q?Tfwo7zqcgVV1RMumeS5Jfd4oOCYWvqbe7zCZ1GVbHwhfCNhNhV38/wHzMyEk?=
 =?us-ascii?Q?zbaipi6uujm0MtIjRihaqlTywY9iX7/H5yf4RV/t9n5UlRYGZicn13y2pbtm?=
 =?us-ascii?Q?NTaXJVaWN6KMsrFtrg8wcx/TZoUbeiLPCQZuQyTnbVTk0izKS01wqtbcVczV?=
 =?us-ascii?Q?g/kAPa3KqE5FOYhk9d82fkwyR+IJMxlFUpyId5Dm1PMRI8Rlv1Qe0V782EoM?=
 =?us-ascii?Q?lle+PGuiXenky9+J+0bMr9Qz8dHtodZwveQYOxtkZrQ9Z8O4mMkTVE5JWlZB?=
 =?us-ascii?Q?LWjjQd2tvLPTLATkkdH2tjiFagkaUUmjSZZr5bm2e3W6Nq3wL0Dxwv3C/7Gh?=
 =?us-ascii?Q?h8ca4ILcft8DahqOn7xOiW76b8l8R/5JP/kFQgc3WV59bHfmOpCtU2xpw7im?=
 =?us-ascii?Q?y2As9lqcIMF2RgS6d/8NI2Cl+gafc1pHbUnlaN1dqN+h/9VF/0Zp0hyTm2oX?=
 =?us-ascii?Q?sMDamIfRhb39oHRcUoM5V5G3G2URpSQvuduF/VTS3pV9pF/cTsNUdsSHK9sH?=
 =?us-ascii?Q?+AU0sonAcjcLKjsBiZ45sCorw5L593SCVCdHUUt/kgsOgamOe+0JmLT3D/8t?=
 =?us-ascii?Q?/1yCpAyG7NEflEvvLJ3eRIXEdg5fu+w6LbmCGl8DGRx8irH7a/4E3jcqqb8S?=
 =?us-ascii?Q?5bR3T+qAo6dRWG9NwKMY2LoigDtpgo4Eqr7k0Fpqfv1C+Z+Ccjuhl+fXAeun?=
 =?us-ascii?Q?G8P4YdONsU267e8b++NveoJMzJC0HWsus4trf9iA56+ABF3MXtganSIqhtb0?=
 =?us-ascii?Q?8rcnGsApetvzMkjJIDsCvvY9ZDAgvyQMuAqdSmN+cYWEl2y5+Jk5J7yjEY3k?=
 =?us-ascii?Q?MiyDZiZufNVbpLZv2BXxpWxW+ym2igS5rntHmPQWIlIXNCtcmC1TlmM0yI5l?=
 =?us-ascii?Q?w2QJnR0zRONinoTGx4rU3FngKZYUv/ehySVX09Ce0itQVWHxjUJmoWTtGpaY?=
 =?us-ascii?Q?JImKdpvAPDLoFbAMkL1Q0ykviUZVLIzW9q8jN8GEO0M+o2jTO5GtJX5xa/rm?=
 =?us-ascii?Q?fNcjdVHrxIbSOW+HXOKFyeY50I8KjW8UB6eolDbziU5GKeGNeQrnK23lcwpq?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd31fe6e-8be6-4239-0cd0-08dd4b9f7a1d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 19:57:27.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHDJaTfNadJrI7X/h+nKzta9RGqCWdKxP0vnD50uibBY/lkZUUmztq6yYw+/Ljcnr6jN1BboAM/ZtMEEV3Rem/V/LOpkdvF3dHzv8tyLyhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
[..]
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Ok. I can add is_cxl to 'struct aer_err_info'. Shall I set it by reading the
> alternate protocol link state?

I am thinking no because dev->is_cxl at least indicates that a CXL link
was up at some point, and racing CXL link down is not something the
error core can reasonably mitigate.

In the end I think that it should be something like:

   info->is_cxl = dev->is_cxl && is_internal_error()

...on the expectation that a CXL device is unlikely to multiplex
internal errors across CXL protocol error events and device-specific
internal events. Even if a device *did* multiplex those I think it is
reasonable for the kernel to treat a device-specific UCE the same as a
CXL protocol UCE and panic the system.

