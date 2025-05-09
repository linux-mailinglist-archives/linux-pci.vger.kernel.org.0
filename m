Return-Path: <linux-pci+bounces-27509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84590AB1950
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 17:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA033B4339
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48C232369;
	Fri,  9 May 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfTKwX2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3722D9EF;
	Fri,  9 May 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805953; cv=fail; b=dbRjF/kZpwoj8c6C4bg7WYs+O/4Uhi6FuVOzXW04gm9eV0Zc3RtQsEuE8oni56xzVCQYwId3fDz/nuzJD3qMt8co94YOdRXYBZPPO/SBUujNRS/FL9LZYhH2+t7gSsXI7dMQTzVDA6tzzluGLk756I93hYg9AuVhqZofvSeda2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805953; c=relaxed/simple;
	bh=JGwzP+y+o2dAwU8ct5Bse4myh7Kfqj0+mlbK0zGrZ1w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hHGPDtSJfQdF39FtPCHSjtYk9KLHglv0iNPmdUB3M85fXSgvsNPHWVuwHhVsHQ5J8iNmh+0cR2YTUDQ+odAOvP2J8tmx9vNjbGv4FgZtzHtEK1w4+B+tLGi2AvYt1Y2gbcYcnisZrjbXQ8GHQUgAnK029ODeW5O9kWjYKnP6NlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfTKwX2K; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746805952; x=1778341952;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JGwzP+y+o2dAwU8ct5Bse4myh7Kfqj0+mlbK0zGrZ1w=;
  b=DfTKwX2K9xF0VFRvly2Xzgd/snOR1B7iCbqr/oS/Ig0uLOoRZLE5+twE
   Nt4yhSACwQmeY0zNsd9uBT+K+Ha3R5GfCmbRBMVX2YTjBcUNMNir3cGMr
   3MbALl6GfITpfDabCNgyfEz1G6usxikkCTlhp0mZNs5upigconztkrLN8
   WhxFjqo/ll4XRvNDt7HN+Ai5/dy4fY5BGYUR0LRBm1DDocnn/kKB8nghC
   zMkbtsbDDFgPgNUQDHoJ3sqRRG4y8sgH50o2OxzJ1i4M1+uHRl9w9qIqa
   0KuJ3sMyDU5vMofY6kOYn9yBy9ALnR4zM0YmDo8JvvquPNc97ykNoPv7P
   g==;
X-CSE-ConnectionGUID: BuACdp1sS1qCHAceRGvM3w==
X-CSE-MsgGUID: a+Pv2b0YRhqjp2UNdKuQZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="51297787"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="51297787"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 08:52:31 -0700
X-CSE-ConnectionGUID: gbFhKvNtQ/uBNJUBOatxTA==
X-CSE-MsgGUID: WIbgz7E9T6qMJ48kUZzc6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141430149"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 08:52:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 08:52:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 08:52:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 08:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMYPyvvPKhUj1o8Gny5li6i2MfsjnrHtbUhZBxlW5KJTGNUe/1EqX4llkGP02TEs+CVksSYHq0ZwOzj0e8XYqu/0pG4EormlXotH04tL0Y/EOXDEP8ZpNcNj8QfTMV3G7bzJxG62b9gTXPItW+NH0EUcgeV8gn5pBI2dx/eDbFi1V05U9dbnVaN2ZtGcsbWSBiqeMAJo6cy3KeMzOZAcAW7Ox3QXhbLZE7aNhAbNFJjYrk8pJ/AiDEHdYAACSXJu0R4o9GWx+KIFYHKGHDITMtZYXhVOf+8GDqZq35BTvi3x9kMQb7NwW+V7OuosBzXbqTVBErdnHNFmKrWcYFy//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCIzU0gL82Jy9jzSTrqcs9m1GJ9Tq9sT+sraBzM5qNA=;
 b=WzMHg3Zh/2fd/FZQDG3ogA/IBPKhOxNgEtFvv7ll3VuN8YJYt2Q2aJzCgYrVZHY3gFgrT2IWFTpRmqp/UmCCTxIMHQl0l4jIhZ8TI5iBOHGWrmqycaDgUsxc5vKCJ8Uq7PaJNIbOZTb+ptVMhVRyi8GA9B7iYJsXlWcz0CcL7bduYyK3rSlUk+Lc40ctjY0/pCBWUkZz5mINOvupjZAXRjCuEO7Rb2GvTx4dU5sd1g8pSxTIBA8ZK/XPc/jU5RGIRNfkQn29A+3hVL3qAlSuwB4kmssa0jwuyD/1kdbFyI7UV7djEqmVoHJksbJp9SOoMhpUjoC/8ihWPvZGZtW9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 15:52:25 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 15:52:25 +0000
Date: Fri, 9 May 2025 11:52:19 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, x86 Maintainers
	<x86@kernel.org>, <intel-xe@lists.freedesktop.org>, Lucas De Marchi
	<lucas.demarchi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v1 2/3] PM: sleep: Introduce pm_suspend_in_progress()
Message-ID: <aB4ks2JgJeO6DD5s@intel.com>
References: <5903743.DvuYhMxLoT@rjwysocki.net>
 <2020901.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2020901.PYKUYFuaPT@rjwysocki.net>
X-ClientProxiedBy: MW3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:303:2b::15) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cc1f8a-73be-4fe7-e2c5-08dd8f117e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7G0StqpZKZUcAPmGOEXQ81Z4rt30+xDk68o+9E5qEjmfGo9otHhadVbLX083?=
 =?us-ascii?Q?pVCeMMVPgKqBlLR8qw3GZKQyLukC4TGokohoJeDhGqlRPmWL44P09uOpbpj5?=
 =?us-ascii?Q?BqJCeMCI5pjpIW5Pi0RxEkq+peki6C9ox3GJRAr/kXAtNYkPX1qGYhcnxQV0?=
 =?us-ascii?Q?TPQrWnnP0pt6Z55hCAOShbbbaD3kT4lqv9ln9BUVFbSyko/IemF/xQ8phI/h?=
 =?us-ascii?Q?X3z55cdE/bFB+P96JrSvCSQXhdta6R20U0meHQ7gM8AVFodkLDgWR358Ut/V?=
 =?us-ascii?Q?5bFZf7wHlyqaqgoIYI//XR9gkhMCCjFHZwAHanCQi44DYtC9hdduDu1t+Jjc?=
 =?us-ascii?Q?lqQV4Np69oKI7nOH/A/SwprkeGgfdr0PTqBc5KFETvJmT1IWVps9k8ugb0jT?=
 =?us-ascii?Q?xATG1sCmyqhPrQf2nK8/+JhWd09PUcWsER2B8Fv2ownVdrU7wFerZrs9MTD/?=
 =?us-ascii?Q?uXrZNRdD6jmtvZnfsleswdptmTSBPFOKT8XDN3TdXrlR4i9wknO6Be1B4DAQ?=
 =?us-ascii?Q?+Bogl64+ChDy7eMcAxDBqaWijMKFz/n8zulGU0/gyUy0Wd0XVU5PDDgKOEn9?=
 =?us-ascii?Q?wueWoTChdXlEbuWzVDX2OLYJNV4MpKuRwicu35z75nEooi79Rk8PQtHeED5g?=
 =?us-ascii?Q?hf8pFaBNnf6v4lIHT4TboyWA8NZD9ZswVxENRbb20RiF4hc29CDx7jezYgy/?=
 =?us-ascii?Q?MJwGibkYZB9a15wNs6b5+a+OoVLavCQbseeD54Tvgk62L/QkOiWd7unOV+jB?=
 =?us-ascii?Q?HJsjAJjgEKmCQvvfm+ZBjZHONMDdr177jgGXIQn9CKro0GyK7BcaXGcnFC6y?=
 =?us-ascii?Q?RtCTq6LQtuPMgZGb4KOqnRFLAPzqwfxnFMx+lx3VVO29+ebzrfj31sMxoRxZ?=
 =?us-ascii?Q?vByY08hoYTJ7hq3j/L+af8mUAdhLqm1D15Ri38Um14KB/VMCctJyynV5cqGl?=
 =?us-ascii?Q?oX+ufldfvOSDZm+9BZC1EQTju16Y3kSAr/FuM4eSPJRemF8nS+BmRGAvs0Gv?=
 =?us-ascii?Q?mysoYydLwiDGjLHY7tbKjQRjnMBgh1dhoAcoZahzBeK3ed/CoMwO420ktQwa?=
 =?us-ascii?Q?Otou8sesP0pDtVEbOFy+p0ld9mQFzaWPAoyrETeORLe7TFzRayMJL/sLlIrw?=
 =?us-ascii?Q?wr7Kk5X8rFntK8ePF/O/fHVp8VwT4LVGdqfXqr8ANBAkerLV606LgddsA06t?=
 =?us-ascii?Q?cQp+sRrn0CHVpT12zT8W5t4Lz9fjR3pRipH/sopBfK7ZdMvr5Lf5fj6mdOTG?=
 =?us-ascii?Q?61uFKorUg7acJkXa7+Qmw6E7EAEydM2k0R2STBA0jTMD9Pg/UWLzzTtGFZAI?=
 =?us-ascii?Q?uReTiduAO7qD7JRSCbhMW5IX4X6NpH/eQuc8l9yb6SRCwMnYYGlHxyY2p4R8?=
 =?us-ascii?Q?zFfJvTyGdWAPJsCphoNK1UpweSApPG4V3KiJhGr3iS3dZkz/M8BCU68XgbCd?=
 =?us-ascii?Q?KY408ycErTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mwPJXvCteSKiyc/5Es4qilWs7EbgaoauhaxK2pCRUF2OFxdnQWHZe7K8pbAa?=
 =?us-ascii?Q?1SUA8+fU8C2ypyq/tBSU26hrKMKLTNS1YpEOTqDKywE9UZpDLV9+7rJ+chkw?=
 =?us-ascii?Q?sg9DihdCSIE1JBOvsJIkgRTi1X6iBaP+4CcqIO0ztmki3koqSS6Hnk0mAQ6x?=
 =?us-ascii?Q?I83m8en2+Jc8WvgcDnlVDCG3mBO16edWF9UQ7to/jsWOwrsk9+24/SSFXVpJ?=
 =?us-ascii?Q?5j2iYq0Jtqvc0Fhlkx31LTGq2PjhdRANcBb/L49M3FMC1Ojtt+oubKpc0Ey3?=
 =?us-ascii?Q?9kiMlR/0oXA3e7QkdnIpNzKKoOQA3luGQJjzjXZYPCKbzYXBknU5qi/MjYVA?=
 =?us-ascii?Q?H/H/cos4LV75yBLizVam3x+LqdQCzAblXvVjZ1kNGGh+0o5Aw5KjmaRTyZ4x?=
 =?us-ascii?Q?llWN1LlYwsZgNF/8m9OYBoNbghRmKu1I5ohNR8UJyO0yGlTXCmtz8W9auVlN?=
 =?us-ascii?Q?5cA35SnxwSifKLLGAivx2Tq4drn153y8mfBkIWEn3/itPXXAWjPAlhANoObb?=
 =?us-ascii?Q?2VS1Er3PVcAGYkAku332pmRiPa805/gKq0E0uAOwG1b3l+5apDpdFCskYC5X?=
 =?us-ascii?Q?+1gPtP71Nw699hR82L1vOsNcYbMFjjF7SMCca/km6fU3dCajQNbTmEbCDWHu?=
 =?us-ascii?Q?NoCll2hccXwvZ+ve3LAU7B4WortvXQm8mpahZdN6QWrgIK2v7IlJYpMRW/Sm?=
 =?us-ascii?Q?36r7GIRBBeRmaBiwvTL0mHNRIhIOlbd4AoNs9tmJMRmUn49YD3gMv/RxGH4L?=
 =?us-ascii?Q?CR+5HLyb1SmzpRj8AEHP8m3uO87jWqcxIJ1EbXvgo3G8Ab3aE8d7TjjYxTy1?=
 =?us-ascii?Q?eZb16E3FMbBF3i+ZsrXDK9KHYgik0s9srwECKKyvm4vy4v1Gn55DMKrGHEl5?=
 =?us-ascii?Q?zCRp96/6EJTTVkct1WWdqCX0/w5jKqdS80VpEleMVR4P+tVt/dK6HQd+P2aV?=
 =?us-ascii?Q?NSKLrfLoRPLh8ewJJcImeJNb0SFn7mg+yzasjDc8+OE/p5HAg7rnJ+TbdeEY?=
 =?us-ascii?Q?kU+BzVROlRInR7SBz5JT2Zz/jF4fXdY9gkZca2wWQE8PHxdrq+rWehUaJPw3?=
 =?us-ascii?Q?CyjedFCw2TO7cKW1VQGgkaw4fLGzHJykhJLLUF8o0jkANIts0dsM20tXY8Ot?=
 =?us-ascii?Q?IeCbycMexsP1QGEdiB4DRW2njKL43YpvAcc2y88j8gFKd/ePLHmzBYM0kzo9?=
 =?us-ascii?Q?Sw9NAqM0rObXPfLai8RV1owDsRXmvoGJcZ8dBwWRARbEQdI0/w1AUhNzDCub?=
 =?us-ascii?Q?6BDjAnrKPvJxjcgyz466qsYYEfo1saCl8NmgdkazDPETlJwnxX3HXAHehUix?=
 =?us-ascii?Q?Ou1y/eGCDpvpKSMyiW0F/U86mbjK5qmwKmO3ceg/0fydmzj+GQuwxo+IqCv3?=
 =?us-ascii?Q?CHksrdGroAqxCdCTp2Art099B+G8wdsHo2fNKYRNlJkg0oRZAm7GmBoaNtXU?=
 =?us-ascii?Q?3V4RPLXaXvW8RxxyDHwZcAgoS5Nc3i3ppibdOtoIhfJ+nby7c34anLFioEMP?=
 =?us-ascii?Q?KhVSx+GOcRyGCOy1OHQn+wELHkRyGQdPUCje9pLoHEcdhxFQwoPMjfvv5X7C?=
 =?us-ascii?Q?vnZYklLg+/L20X/dcgfO4uDNtEGvyxHYpcLBfm0rUf+ASQW5SQXBEWyAaeY5?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cc1f8a-73be-4fe7-e2c5-08dd8f117e64
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:52:25.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbtxTq8zPII8xBsOZV57AwfnKPaLRNf8H7WSTDNQbndT+YEYRURKq7C3JTmXfrEtXgXb8Qb2J/N3T3mekmOsEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com

On Fri, May 09, 2025 at 03:02:27PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce pm_suspend_in_progress() to be used for checking if a system-
> wide suspend or resume transition is in progress, instead of comparing
> pm_suspend_target_state directly to PM_SUSPEND_ON, and use it where
> applicable.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
> 
> The only change in this patch that depends in the [1/3] is in
> kernel/power/main.c and it is not relevant for PCI/x86 and xe.
> 
> ---
>  arch/x86/pci/fixup.c        |    4 ++--
>  drivers/base/power/wakeup.c |    2 +-
>  drivers/gpu/drm/xe/xe_pm.c  |    2 +-

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
to merge this through your trees


>  include/linux/suspend.h     |    5 +++++
>  kernel/power/main.c         |    4 ++--
>  5 files changed, 11 insertions(+), 6 deletions(-)
> 
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -970,13 +970,13 @@
>  	struct pci_dev *rp;
>  
>  	/*
> -	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
> +	 * If system suspend is not in progress, we're doing runtime suspend, so
>  	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
>  	 *
>  	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
>  	 * sleep state, but we assume amd-pmc is always present.
>  	 */
> -	if (pm_suspend_target_state == PM_SUSPEND_ON)
> +	if (!pm_suspend_in_progress())
>  		return;
>  
>  	rp = pcie_find_root_port(dev);
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -337,7 +337,7 @@
>  	if (!dev || !dev->power.can_wakeup)
>  		return -EINVAL;
>  
> -	if (pm_suspend_target_state != PM_SUSPEND_ON)
> +	if (pm_suspend_in_progress())
>  		dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
>  
>  	ws = wakeup_source_register(dev, dev_name(dev));
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -641,7 +641,7 @@
>  
>  	return dev->power.runtime_status == RPM_SUSPENDING ||
>  		dev->power.runtime_status == RPM_RESUMING ||
> -		pm_suspend_target_state != PM_SUSPEND_ON;
> +		pm_suspend_in_progress();
>  #else
>  	return false;
>  #endif
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -298,6 +298,11 @@
>  static inline void s2idle_wake(void) {}
>  #endif /* !CONFIG_SUSPEND */
>  
> +static inline bool pm_suspend_in_progress(void)
> +{
> +	return pm_suspend_target_state != PM_SUSPEND_ON;
> +}
> +
>  /* struct pbe is used for creating lists of pages that should be restored
>   * atomically during the resume from disk, because the page frames they have
>   * occupied before the suspend are in use.
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -613,8 +613,8 @@
>  
>  bool pm_debug_messages_should_print(void)
>  {
> -	return pm_debug_messages_on && (hibernation_in_progress() ||
> -		pm_suspend_target_state != PM_SUSPEND_ON);
> +	return pm_debug_messages_on && (pm_suspend_in_progress() ||
> +		hibernation_in_progress());
>  }
>  EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>  
> 
> 
> 

