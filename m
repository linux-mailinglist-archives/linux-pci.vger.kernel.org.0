Return-Path: <linux-pci+bounces-22394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD10FA451BD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 01:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEFB3A61D4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 00:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233D145B27;
	Wed, 26 Feb 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnKzWKzq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA821494C9
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531040; cv=fail; b=himXB7qhJdLZb5GFRcBi2pFGXbzu4FpTtVyetStKDYW23x+xCXFjHIy63oKpSUis4GgpMJCcj6bcrzXunY8Y3k4tuB/fPTJU/WM8yIdlxV1uYLKT6b8FATyFRtwinbXiVqJ7yZcj5AkO+CDtN7LFN+F/rZppAMkQ6eeza5kK4Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531040; c=relaxed/simple;
	bh=hjTsVg2wL4ir9guKEkZxSq1AP7RYjgtBthvBtGSRJKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lRLCh9FgKaFs0QEtfcRW7Eh3lJsVrU1pXQCpqpEHkEhg8XEAlQwJYifQodwxHzKTQJGVQcBkyY3QlfXvPR3Mi0W8tI0sj/XBtP72ziAj4dU5FSx87XVzmQXJY0HPqteQLZroYcesNFcqqTm1zx9zhVbH+lJDEit5jnLitFiqFag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnKzWKzq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740531039; x=1772067039;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hjTsVg2wL4ir9guKEkZxSq1AP7RYjgtBthvBtGSRJKI=;
  b=lnKzWKzqXfyygShhP8wmrnUvkENCuuws8ryf8Me+rLR93264t4W0dWpq
   U/pzkg5qW8MPdFRoSUBgbbEPetbZCvwwkJOrNSvLM+w5Vi24JX3vQ+Qjq
   l29u+S1bH/IBi8uD78+WOnKwWGCwrauc8tD2BcmAB2l9tX6m0Dy2eJ/oF
   0ehnzXtewi2vlcTx2hA0Qvygquksb4LN5HnohSm7hNfFvmnyZS/LKitWe
   4OKCKwtFFemKye2B6agwSjuRZkgIJPsqEhtDzIu77rlmLQkTNNwpDLnw8
   ZEWE7NZ1Ytoo6+uu4I26XKXZdp0xceNIGU0/DhhLC44XZEIyO5u86nc4Z
   Q==;
X-CSE-ConnectionGUID: P671ccQQRdagBkbMoUX9ew==
X-CSE-MsgGUID: 4/BW3Df4Th20qeJeei9JMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="51575685"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="51575685"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 16:50:39 -0800
X-CSE-ConnectionGUID: Ic98PcqrQzeHh0Sms7GJwA==
X-CSE-MsgGUID: nrM9x2IETX+lQXYkkZ55xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116356143"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 16:50:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 25 Feb 2025 16:50:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 16:50:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 16:50:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHkX7A4lGKr5LRRasd2Y1j6RSQbXzBOjJHb20NXLJ0wAo1XIcE03Uhbx60WJgSJyXzw0hyKi3vKTroHvGoE877TssltEwZg+ajKrktQcsre+52Hs9q6a1mqiy8d8UUBIIxpFxp3lGb1RMT2j3CEtHCpj1dfqL0cFfcATRUrrOlMBIoLN/KYDpmWCVcEbFe041ry/ftGHhS5k4GpR4QKw6vfoMts9P965qOARScSDDqUO1E0W/mZKRdOowi2NwX/Fh/TltKzMbREQF+vtgsepK8OnuJDYuPq5NitAoTsisNYkbWQYfKNaKJmD010nimrnYi3NSTGcwZH2YPvlot/G1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PP+QNnh+L7L3H5KECZYjA4hUPdU127ZD378Wsyozhxc=;
 b=GKc3A5itMkJbPs+L7g3n1iqLEcHQjXsk9yypLQjDofPHB2hwdGqpG+GY72eOhux2LLh2OjN3com16pl7TWZBzLsaWd7Q1GqgHVCrcFznzssmtQru116WgnOnOtYvjve+omEniLJth+nYHdpSL8z48K+9rSk5jgJWZARo9P4y6Of1uwlDS0Ba3VSUCTuEgN7W8jAs5lTzzRxBH4UyIqJO7f2B2cHsVRQrAnaRpKTHK9J9UOENhtjsucIu4dJjPo1pZnbCJUcSwVRudytpld73qNsc6F+CzVuFpD7cMLnjjt/Kt6dCSrqrhIUlCwl9/bT3UXi8ZFQxuyBflR0lpcLO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 00:50:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 00:50:19 +0000
Date: Tue, 25 Feb 2025 16:50:15 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <67be65478bb3e_1a77294e8@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <20250130114554.0000033d@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250130114554.0000033d@huawei.com>
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5d0475-eb5c-4773-0f7e-08dd55ff8aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: EbfSWBBK+VvhpBlVBiPSvB0PtjiOAKdEmjJOoFqRPIbO5+ozp9NtsEeBzSmkC4czn1ICXckuiE8wSjEgRY9ZceDvUtsksPCz+nMdvyEPG4W7xG+U99BDhjLTsi9fpVnC4qRIKhRDCY8Sc8i/98gkHu3l7MGyWIlXMLyJEQSayPz22OVKy17Jp6Sts2/wGaZIf15KGFyT9gBgMkAfSndelgtpPPJBFXCizaM9Dny+zqZv2ex9rY8Jk/Vg31q4NMs09qTOVKBlCH2zTrJv8Do0aUBD3mfA1CXGQIDexjQyzmrU24cSR6fJzfmkz86SHXb2aBMhr/9Ykt/pY4RDcxB37E+4uBcag96dCskE/rQDXbiVQAs/F2wuSeR1+4nJSXHEEwPQeMVfvdzQM7DGIuTwCsD01FQPE2X5RdN/ikVXrKUmU3wqJyHIwrzBrkkc5bpqi+1ar2hkj56SDfxmZQv9T/EcdVoAFREtQRtesX780lW+xcU8B5nbpZwzckTs3ltE+fmpESOopjwklz8X+JvTIm7a8Wn9yxZcRq0ot7EYDbcPjte/4bOTPuOj2Axv/hnewrT0xKpBG1DC2dradcjRlfGgMkKFBx9LPf5epO+mJ7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E40sTK57dilvV4RoYguMwCn+8PdPdRBY6ZonpyUJqIJDx3TKFjSoQ3bqhZec?=
 =?us-ascii?Q?p/sb8xraVLpXhZeMyS9R/Zbxv8gXGN0Ks/dmbiJHAQ+j2BIHXlaq+shnMliT?=
 =?us-ascii?Q?bZody5YS/iZ3C0ckgwpBNnPPqrWvRyjAD66NgtOdMFFTZhuG/Ml6D/137LLF?=
 =?us-ascii?Q?2VnSEgQ9Tf2c2/eCmm9c8+j5njQdkaA+7+wu94RS9wLiMsPy3PHbz7E/vdx7?=
 =?us-ascii?Q?LXUG03s76uM76VWIHCgHUXJqGi3Ylfen/Q1ViJegg1YYRW7zJYATvUqkfM2s?=
 =?us-ascii?Q?2hGUT9AqS8qRrnPYEsTXd/iTp35pe8hpfQq8AC14NsDWRkJi+GIAZL9aLLtu?=
 =?us-ascii?Q?SsaVZafLZs7U5VqI64atbdXkovMvmZPB2kziKKQoIJ1wvWSEcjNeVRSie7ty?=
 =?us-ascii?Q?qthlDNaYN7Yj16yBKarDqX9/yfyeATlVwVM7WAPxL+LgrK3nQIotf70+i0tI?=
 =?us-ascii?Q?QlMpkTiWK46VvBiXiCaAzH8AS2YXcYSYw+cCOxdky3wHVH2Zv4eZo+ijMSq7?=
 =?us-ascii?Q?XW6aXsIxMyttMuhxxDb2FxNlRnH6PpKi5ORnDTt8I9SAqxJNHG4jwjfBgebG?=
 =?us-ascii?Q?x4+k94aPPV4DcM9YQAMvyHRoRl6aa1A4pfEIGWcUCEmgLG/SVDIYUKEhrMH3?=
 =?us-ascii?Q?RTPxun26gtMXWSovLBTv9vzatdEdr6dzM9b1q/97Lz3q4/ewxM+qnuWqewoZ?=
 =?us-ascii?Q?a0QK1LofkWW5Z+SmLV2MhSeNUxJN7qRLKq+Dx/xuPreDgzJB1VG/k96DHN2O?=
 =?us-ascii?Q?M42DvQETzBCXBJDMBGFZuj67lp3E7TizDjWRRVFxcVPZrkoaMmlMFZGAp2yC?=
 =?us-ascii?Q?ycFxyLZqHbGHj+RJzx46cbie0yNPDfb2MiM02v5rRZjj1T9zlJ1GSlW6stum?=
 =?us-ascii?Q?h9+7ZAhS4PrAY1hUB/fpumWlH9CXUsoestFXrQVudY/NbtXON8hfQhro2AMb?=
 =?us-ascii?Q?V7ptGFzPE+ngv/9YkBli2sECeupuxkyMAWT4C5CUVhe0cc2hktdnbQSwBYSz?=
 =?us-ascii?Q?rPoV7rFKwDnmDmzaRolHibHIVOZ75OvC9W8Kx7bMjZPLL2zSaipRh/Q0LP+m?=
 =?us-ascii?Q?lIokXYpO+/L3EZA4WCFQIvCr2IafYGbAzbNJWGD28C/jHcntBnMKKRE6Fate?=
 =?us-ascii?Q?B+DTLdWYHeKNNFONc+dhB8F2M77LGtKLptMgtDTewwM4E7n0dPdvLErW5lIl?=
 =?us-ascii?Q?0PT8sULeAcUoMyU5585JhtIm+XO5sgE2op2Gjfac6XPGAqsbcsqTEJu2PlUW?=
 =?us-ascii?Q?MqhOI8sdNvsRrrvtWLQzYLRe2HqtbYGlZ3TcIcmEtAQ8DdF/x38NVWt8HSsY?=
 =?us-ascii?Q?jGS7KFKGSO1cJa3OZ1UOwikXwukEKBxVD4u40O7nw7qW2OJnSfnWshBZvCIT?=
 =?us-ascii?Q?rOEuLmqgKYAgYFFfoULIM4/g5QJbvn2T72ZLLJ8wvT1ybQpJmUsv8rSo9dKc?=
 =?us-ascii?Q?CVLT+uxwScHbp7lzXRyadfzU5bAvYbVVr01R2iC3UsbjjeL+P/xv3yt/FZir?=
 =?us-ascii?Q?a79Hb3lX0zMTE8Iu5KPa5JE0ycmjMhNxM1xPy3lEcLEbgMVt1NXop/31VSPj?=
 =?us-ascii?Q?CxUvhAdgtsyL7jBG2FF50ANEC5UDC43R0RAp28tTciIhAltLUP12HRagY6M9?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5d0475-eb5c-4773-0f7e-08dd55ff8aac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 00:50:19.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH17EVAlTUZKFu70hRceVK1fVRp6rIz0Nw1xydaDh9xgI95Mi1xB/dpTIr8AnOG9vFobSRfKjC1QCKR6knUKryM4Tn0eckj4byWoIRcbfd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8665
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 05 Dec 2024 14:23:45 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > interface definition builds upon Component Measurement and
> > Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> > adds support for assigning devices (PCI physical or virtual function) to
> > a confidential VM such that the assigned device is enabled to access
> > guest private memory protected by technologies like Intel TDX, AMD
> > SEV-SNP, RISCV COVE, or ARM CCA.
> > 
> > The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> > of an agent that mediates between a "DSM" (Device Security Manager) and
> > system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> > to setup link security and assign devices. A confidential VM uses TSM
> > ABIs to transition an assigned device into the TDISP "RUN" state and
> > validate its configuration. From a Linux perspective the TSM abstracts
> > many of the details of TDISP, IDE, and CMA. Some of those details leak
> > through at times, but for the most part TDISP is an internal
> > implementation detail of the TSM.
> > 
> > CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> > to pci-sysfs. The work in progress CONFIG_PCI_CMA (software
> > kernel-native PCI authentication) that can depend on a local to the PCI
> > core implementation, CONFIG_PCI_TSM needs to be prepared for late
> > loading of the platform TSM driver. 
> 
> I don't follow the previous sentence. Perhaps consider a rewrite?

I will just drop it for now as the entanglements with native PCI CMA are
not relevant in this changelog especially as is not clear which series
will land first.

The rewrite would have been:

--
CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
to pci-sysfs. If native authentication is enabled then the existing
"authenticated" attribute is replaced. The presence of the "tsm/"
directory indicates what device authentication method is in effect.
--

> 
> > Consider that the TSM driver may
> > itself be a PCI driver. Userspace can watch /sys/class/tsm/tsm0/uevent
> > to know when the PCI core has TSM services enabled.
> > 
> > The common verbs that the low-level TSM drivers implement are defined by
> > 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
> > defined for secure session and IDE establishment. The 'probe' and
> > 'remove' operations setup per-device context representing the device's
> > security manager (DSM). Note that there is only one DSM expected per
> > physical PCI function, and that coordinates a variable number of
> > assignable interfaces to CVMs.
> > 
> > The locking allows for multiple devices to be executing commands
> > simultaneously, one outstanding command per-device and an rwsem flushes
> > all in-flight commands when a TSM low-level driver/device is removed.
> > 
> > Thanks to Wu Hao for his work on an early draft of this support.
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few minor things inline.
> 
> Jonathan
[..]
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..04e9257a6e41
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
> > @@ -0,0 +1,293 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * TEE Security Manager for the TEE Device Interface Security Protocol
> > + * (TDISP, PCIe r6.1 sec 11)
> > + *
> > + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> > + */
> > +
> > +#define dev_fmt(fmt) "TSM: " fmt
> > +
> > +#include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/xarray.h>
> > +#include <linux/pci-tsm.h>
> > +#include <linux/bitfield.h>
> 
> Odd header ordering.  Anything consistent is fine by me but
> this just feels random.

Grouped the PCI ones together and X-mas-treed it.

> > +#include "pci.h"
> > +
> > +/*
> > + * Provide a read/write lock against the init / exit of pdev tsm
> > + * capabilities and arrival/departure of a tsm instance
> > + */
> > +static DECLARE_RWSEM(pci_tsm_rwsem);
> > +static const struct pci_tsm_ops *tsm_ops;
> > +
> > +/* supplemental attributes to surface when pci_tsm_attr_group is active */
> > +static const struct attribute_group *pci_tsm_owner_attr_group;
> > +
> > +static int pci_tsm_disconnect(struct pci_dev *pdev)
> > +{
> > +	struct pci_tsm *pci_tsm = pdev->tsm;
> > +
> > +	lockdep_assert_held(&pci_tsm_rwsem)
> > +	if_not_guard(mutex_intr, &pci_tsm->lock)
> 
> Sadly that got dropped.

RIP.

> 
> > +		return -EINTR;
> > +
> > +	if (pci_tsm->state < PCI_TSM_CONNECT)
> > +		return 0;
> > +	if (pci_tsm->state < PCI_TSM_INIT)
> > +		return -ENXIO;
> > +
> > +	tsm_ops->disconnect(pdev);
> > +	pci_tsm->state = PCI_TSM_INIT;
> > +
> > +	return 0;
> > +}
> > +
> 
> > +static struct attribute *pci_tsm_attrs[] = {
> > +	&dev_attr_connect.attr,
> > +	NULL,
> 
> Trivia but no comma given it's a terminator and nothing will
> ever come after it.

Ok.

> 
> 
> > +};
> > +
> > +const struct attribute_group pci_tsm_attr_group = {
> > +	.name = "tsm",
> > +	.attrs = pci_tsm_attrs,
> > +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> > +};
> > +
> > +static ssize_t authenticated_show(struct device *dev,
> > +				  struct device_attribute *attr, char *buf)
> > +{
> > +	/*
> > +	 * When device authentication is TSM owned, 'authenticated' is
> > +	 * identical to the connect state.
> > +	 */
> > +	return connect_show(dev, attr, buf);
> > +}
> > +static DEVICE_ATTR_RO(authenticated);
> > +
> > +static struct attribute *pci_tsm_auth_attrs[] = {
> > +	&dev_attr_authenticated.attr,
> > +	NULL,
> no comma

Ok.

> 
> > +};
> 
> 
> > +void pci_tsm_destroy(struct pci_dev *pdev)
> > +{
> > +	guard(rwsem_write)(&pci_tsm_rwsem);
> > +	__pci_tsm_destroy(pdev);
> > +}
> > +
> > +void pci_tsm_unregister(const struct pci_tsm_ops *ops)
> 
> I'd try to name things so it is clearer when a function
> is about the TSM coming and going vs a particular PCI
> device coming and going after the TSM is loaded.

I will add "core" to the ones that are registering ops from the TSM core
to the PCI core.

> At least that's what I'm assuming is the difference between
> pci_tsm_unregister() tsm going vs
> pci_tsm_destroy() particular PCI device driver being unbound
> (which I don't think gets called, so maybe drop for now?)

pci_destroy_dev() calls it.

