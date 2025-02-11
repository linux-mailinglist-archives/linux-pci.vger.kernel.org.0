Return-Path: <linux-pci+bounces-21229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BFDA316D6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A04167C4A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8772638B9;
	Tue, 11 Feb 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMDjiEVD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7141D89E5;
	Tue, 11 Feb 2025 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306694; cv=fail; b=k/WZTWTnqegg7ObeF3FXr1d6XZ9ZxIbQwdXzCBloQioebOeV6qrZtkpZqInX9b6lQCwJRNbqazsQLg1Wh3U+ULhtwSPDCyL8j/siecNoK274kBv6ln6FI1CpraU7WhjAssasrj05I8fbK83oqCBDUan+PYnGTKGzG5cEdg1pl8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306694; c=relaxed/simple;
	bh=zEfj7qW9g2D5PrVc4fw+ft4aWvERMXeV/R8R4mIJxGE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imCGevockAk8/gEje/LW5M2YUo4Ay5SZYszZgDHMaxkG6OFgUCMp74Fjq2torbrbrhCAnDF8IHL13dT9Ad4MU3EmsWFD8HxWXhNWhXmhhKKOfPd3WgTGt5VZHh7g3rP1ZgjImwPjQf9jQ+1wFjb09MUPtUppelBCtGG8GBtc5T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMDjiEVD; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739306692; x=1770842692;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=zEfj7qW9g2D5PrVc4fw+ft4aWvERMXeV/R8R4mIJxGE=;
  b=GMDjiEVDxtGio4h+0ZO7dRuFNKgNrVryE0go68vcBqjpGP1tm1nYr9R1
   LghKh+XwVD4WXQ3PpM9UxdPv6IK6wL5Gtb/liqsAgt2fqfL3jM8RD7oQL
   eGfksZDzdSigH/zO1z43/LLY9uofGj7aKiVlkUBT1jr+6Z4zT6MPNVmuK
   T9/04fj4WgDCvefxRXE1lPUZzgPJ4UhXQWZUCU3zOeozWfk1CRXJIz9P1
   8ONgKEm3JVX9VK4H/kKfjlrdqoERDtnSOa3wxz3buMjMG4GE1WOpnz6bG
   DXp8khHdOWAhZdpS/NoeR4qAW5Xdec4/SvtlW1yEbojVOTgL8cehlZBgx
   A==;
X-CSE-ConnectionGUID: aBzB+I6VTgeqNlg8ExLS6A==
X-CSE-MsgGUID: s6Ek0OR4QmSrDKe1H/Dm0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39965948"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39965948"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 12:44:49 -0800
X-CSE-ConnectionGUID: RbJq446tSMqEYdgLkEHRVg==
X-CSE-MsgGUID: 1S6yZwdMQPe7zKyUD2cCng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="117556228"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 12:44:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 12:44:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 12:44:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 12:44:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5qR4OardnjcEdai00Y7nF4Oo65gsjE9+Qv8umKSERnklU5fNQm1oyGEteM+NIDmv8WhQM2wjeiN7CtubMg7DOrpFljVahKEGhWpWCjcqWOTKjrjUDtzx0keZ/cNAaaXZp95qG+/iSkHhbOI5eO+aezviwK9mGP1v7jbIaJUAxhmPeHWfmhsHVgONh+YkqS5Ex2MTn1L0AGoueDaC+INBj8eQQIRZJ6lNzAj2uyR3L6ztKZzJszY7lGTPPS/jHKeWfZZUDXHp9aAslhbe9aqPzC59spC3r8e/vfLc03D2h7EsIhLrW39UZgq5HNnQShXJzfh9+D6AhEMBfKZ20yJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIBBQ/Nl7O41Ub/SDW1pClUzQjejPwKNzno3mPTpHic=;
 b=dVDVwO3r0NVno8vGNuVGzQyNVqKFP4Y4Bxo+gIg47Ki+LIpiKbJFSWGntISmVgIWXwX2T3/1vHrTQyz/uQB11B2wx1m+FsTKZz7MoC1BImDtBO5uY2bVYXE7OzNgAoZgIDIIRJVKzKk6Gxin4a57MF8GkmJ87nkIzGx0vtVwPGMzPVKLny9Ri7lITZbJVihef0XRtf92tYXKgdrvtvuoTroLqwcm3i9GCK//0cW26Xn2JotRrGNXo99FKzMmeby9uSSl8Mam1SVclMeH3nixorOWpP7kGBJgKdJ9V4uRvR5N1P5VihehYcythiqDplxvJsFHy07FjyYN4lWKRnXz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 20:44:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 20:44:44 +0000
Date: Tue, 11 Feb 2025 12:44:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 02/17] PCI/AER: Rename AER driver's interfaces to also
 indicate CXL PCIe Port support
Message-ID: <67abb6b99f527_2d1e294a5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-3-terry.bowman@amd.com>
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 52630094-7e9f-46cc-7eae-08dd4adceaa5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B+uwauZ9D4h1cEVFu4fNqA6VgMFH/EKpnfG1y3e3H0grzHAAupACU2rQv/OK?=
 =?us-ascii?Q?OEjDsZoI39Lwb/joO/lJEJCa55qA3Nh+wA1IWB/pzc2dex0++uX5eP5NbyDA?=
 =?us-ascii?Q?Hw6bm+9ge7niwr1Cws66Ogr4TQFOyROU3BtO0zvJC6p8fuJ9UUQ0WcA4puCh?=
 =?us-ascii?Q?BiqBy/nI5ehXoy8pazAtqdiSktEYCY0Z53ZwVdltBFW25gwN4vdC5WCh1JIf?=
 =?us-ascii?Q?a8V36iJDpX0EaNLTuOBy5gylaII6bPmGGsmbJK4DbHkX94dNYXBEILJTkTJo?=
 =?us-ascii?Q?M3fTJSlH5JlP73NTCJnSnkUtsgH7TWqMAEfxYucmbyKIyg25MZcWv73B9d9o?=
 =?us-ascii?Q?HehLRRs3KNx3YtWdGi0ILh5wPwRi0YlBmVVuf86XXmzFx7nF0/OWX3vX2IFU?=
 =?us-ascii?Q?mUXI79/o/zKLrcoLD4p+1F16TMKNVeFmqdBqkW1/WR76yGzwaAst45Ide51L?=
 =?us-ascii?Q?YeiwyWze4F4ajEyP7ioIyBPPkqBruDl4Ita2GS8p5kcl7DFoq11y5744t11V?=
 =?us-ascii?Q?RAR1ATqcP+GUXWtnlN0G4kdSw0/JjGMNISwU2lF+3S/Tg+tFsX2N7PAPMTbq?=
 =?us-ascii?Q?j/N91QxjiI1AdddNnAFD+IufYjmqq6W9K9skjl7zGAZlZKmb8QkyCQuS4zj+?=
 =?us-ascii?Q?2xbybChMFv34Q6OA2aY6seylz7SD/mp9NU49QDPTCtSO2jTI9jNomBtOwPuP?=
 =?us-ascii?Q?43tVitZeV9zLUhXkqyytQ5n/DXWw3nv/LFuZUgAdeK1dj+pLE260H4HLBd98?=
 =?us-ascii?Q?5G2PMBE5vRo9NCG+vmFKfWNlOMob0LypXwmEbbOrQBs+3xSyxsdjHHtc2J4r?=
 =?us-ascii?Q?Tr8mqO9b0HfPUvnsGg/c9ahEhwEj+9B1brMY2bY+AKUJBcGfuVXRKO2oT9ag?=
 =?us-ascii?Q?ZaCS4m1q6+SgirYUzCG10ctL4u8XPnOzcETMWDuoKpRceE1J0yLEDRcA6hmh?=
 =?us-ascii?Q?p42wXkYQk9kE5XDsJ5+rTQUnzO4fuQnSKJAi80cgXlQ+iudTLDXFaR+k7nbU?=
 =?us-ascii?Q?7CIJivsRl/rHaFyWiTe5adbvtA5SgbA0fUuSpLZcr6zXDcL8V5muxn0ZiQOU?=
 =?us-ascii?Q?iCX6cDLwuwDR8VkAfEHqY6i9kCJwQOPzOieXDKTt11dn88rLh/L0/RCSh++u?=
 =?us-ascii?Q?fxtwX8B3qejQrPPDFofHPvkCp8qBuLD9Q6BN9YC/ym0EHnyZZRZR4/4pn4fK?=
 =?us-ascii?Q?6IcOiZceBZMXWj246oai4o0txuBMs4tIzmzkd3yUqwDGhRYcxwd+i4lxbtC2?=
 =?us-ascii?Q?UNubp0zF9+4/MTAZPWwhZTdcnAXbT6WbyaZA9FgcP2sUiDjhfcp7ADxYbcHH?=
 =?us-ascii?Q?tWuBwXeSDAD7mnfINmsYjKYe0FbIJn0vtCdw4hdMXdK0QW/qtpOOKp5rPRsD?=
 =?us-ascii?Q?2FCSrh+p7YQStilFjxbM+oL3XqhWWLhOoxZ2Y97XDbFc/t5Z7GrtKyp/1C/F?=
 =?us-ascii?Q?Yzx/2m3TYEI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xUy0HlMXfrs0e/iuIofnUJ1ao2dPzsO7g2+nymPowuJyeoWk4xhVgtRdHj38?=
 =?us-ascii?Q?6brCWO6Jr+/6ddJOB7Qrz7c9ZZXu+n24HJ6DIdwUEi7tRQpsZiQH/0EcnHg2?=
 =?us-ascii?Q?hioBHyAPZyJPGlbgaTwupEcCrS+0BJZJucFyuh9bDUCfT/wfNvkNuc5uH2CW?=
 =?us-ascii?Q?onKMeMtNBfqrF4wRzV20lI9vUMZC6Sn7ehVdq2s46y0l9RRULPPGlhm4xeH2?=
 =?us-ascii?Q?Kcb5qi3xpuItKMr8dDnJmGi2CW619QUzk/OHOs2W+nT+XPkitiRowog3OlYB?=
 =?us-ascii?Q?co4WgtVuGr3gVwPeV2VGLr1cYcTg6XQSYbXDBPBvf17QVi79i3E27uGY3r+A?=
 =?us-ascii?Q?sWj1Ei4b4O9r3nYJ6nHnuQxOjLp7oFar4Hc1R8NzXJ4U4i6qXnwcQ7rX2sy0?=
 =?us-ascii?Q?tdOTNpFaAoIElzIm5tXsTgPDU2+xOsMtfvnRx06i9hrLOhbuZqH3nYg1BBej?=
 =?us-ascii?Q?ob9eZ98m97B6CvqiaXeKlNZDMPfhTUydE6QcdLpo1SCCH62G18XVls0HBC7b?=
 =?us-ascii?Q?uHbD8HFFl2DV2wRCX03UlApcllnufvtFJBB0m99yTeMomOgE6s9w8bH6JHA+?=
 =?us-ascii?Q?fXo+gRgSxb0qA7z7BoRQCk63K99kOnTtVdfRr3YTz0naJF0ZA3Hc+wRxEafs?=
 =?us-ascii?Q?HYgd14PCU08fIb0eLlNFeDgTYnq4H3Ny9uyXes68JiV2pC+6dx+43NnBjaGG?=
 =?us-ascii?Q?Az4AdmqbFNy4NnKwsNIx/5DTyZlOeh/xIYMXFIp0w064X+41+Bx1BCBHNAMR?=
 =?us-ascii?Q?e+6+eh0Pm0ffVv5LkYkseIvIkdO4/brmwpamzgtB4vz4er8Vab/R6WLbaJNO?=
 =?us-ascii?Q?zfgTWJ3Sowg9u9ROSqZ1hXc/py1GFz8vXF6aNRSkR+ytNaNmfAyVP7XwULNB?=
 =?us-ascii?Q?RzKRPqXU5cexChy1lZuamtrWGGzGf4eMQlQLGkXiTBu2JxFKPuh63EPh5AIc?=
 =?us-ascii?Q?mML9vB/6Y4+pjkcdkIHAUK90uco6eJ8GkSagaOuWl9pIcEFimCYFNZChHBu8?=
 =?us-ascii?Q?dZ49XAziW5qZJL2+N7SA8T6vevAMxZyvCXKeaJxYwLYYek2Le0zxkElbjPLR?=
 =?us-ascii?Q?7I7yNWay3VaPiyn+mRWNkSg5SHcjNKmVsCIAWV0axeiwdcQItqGtAmmCmUCk?=
 =?us-ascii?Q?ma0oZkzdaC4hiwP8i/N3tq6YGhz0tQcLnbrWtSZtoYVJoIwDD3NsOjUWhr3g?=
 =?us-ascii?Q?EDsz4OQSz1p4iQY7hmI7BlZJkEPjW2nFuNbgn+Qzc/USmR5Ay7q6dsSHZVs6?=
 =?us-ascii?Q?K9ZjNwUIzRMeRTNt0+sSxcZ6kUrYi5DwZTI7MyoF8qBSZH0u2Tv5jQ+TvAXo?=
 =?us-ascii?Q?zp2V/DKVw8j/7my+vWGrIxgOWoB59Vg9ZGdGPRoT+LGC8GFGHo2DJY7L4bNQ?=
 =?us-ascii?Q?1Kc+Ohv5WCzsOprq2UryeYRQeEaZ9jFULkDCtEAsQof0TCMksRNu1+Dxf7wG?=
 =?us-ascii?Q?ueQKu0YhEDhdYBNUCLHYCgrumtespUT+uwBapKFe+v2vSyr7HD9NR40usH+8?=
 =?us-ascii?Q?57wfMXD+yJRuVUH6O0bbX22d7QzP6iO+7Rhpfh8bYHDOLJ+cdZ2LSu8jxbkt?=
 =?us-ascii?Q?sshk2fzTLr8PiVotwVJl3+Qnx7Hyqx4mbnPrTMCd6WrAwtVbigBEW63UHaMF?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52630094-7e9f-46cc-7eae-08dd4adceaa5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 20:44:44.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B15e2sI+8P2fKfJGftHLbJ0E3HUMUhlvmD2U1Uhw9x/OWesJLCZY0s+1VoIScywWnU9QVL6fW7GQ/O1e2cw2m9Qsem/Jk9UPwkXRkus2ZZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver already includes support for Restricted CXL host
> (RCH) Downstream Port Protocol Error handling. The current implementation
> is based on CXL1.1 using a Root Complex Event Collector.
> 
> Rename function interfaces and parameters where necessary to include
> virtual hierarchy (VH) mode CXL PCIe Port error handling alongside the RCH
> handling.[1] The CXL PCIe Port Protocol Error handling support will be
> added in a future patch.
> 
> Limit changes to renaming variable and function names. No functional
> changes are added.
> 
> [1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Looks good:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

