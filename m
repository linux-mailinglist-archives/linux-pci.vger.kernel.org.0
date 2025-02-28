Return-Path: <linux-pci+bounces-22609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8663A48E94
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 03:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA7D3B76CA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF3A126C02;
	Fri, 28 Feb 2025 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTEml8XO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96481276D33
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709601; cv=fail; b=PPpq0C+2WeuuU1werNK/YPZFgOsoRuRFRLlzj1Vo8sU7V6+pFF/aJqSfAu7gPuJP0VhjG0HMeZ9QBF9Uqo8fgOSm6DtsigVKGdCfENsQtzM0F1v98fVqF79h6vNffBL7mfqr95qrCM926OfmPazYWBYD6iQ/ynJwHOflFZyYTpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709601; c=relaxed/simple;
	bh=929sPizp6ddrLG375o89yYVsOQfUOoNjDbPYzHvvKys=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dTfYr0+ppxJk0hBbYGVtBx2FpN+Su8xwiEjTkaJOn2Bv/920iUry6a434leOabiGvhh+Mp5yYRTEzgjMnlLu4QigV4WmJDP0wqD7ZY6qw9h/tqIXwzrAh4ytl66nh9kQRPa9jxxjlar+g7Xss+VFap4aJZl7A7PWjxDAujyYPJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTEml8XO; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740709598; x=1772245598;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=929sPizp6ddrLG375o89yYVsOQfUOoNjDbPYzHvvKys=;
  b=OTEml8XOPFr5wgNrzTn3gYX9V4FXZ/oh45/xZYwz+DYJzvUpzh9Cy9Gw
   MtGzhWY2E8ELPuqh4ZqqR/u4u5TKjjV8/57EfC6gwg7d8RazyoQWzLNBA
   N9W51zzKbQT1YczFnaDwJZIqbk9zksaPO1tflH3RZ8k86DLoLU8BYYmLB
   chPbCzFM7u6Rh/zjmQ3ObwKune6PJiGlxaAp+RXhY+75w+cZY5xbOdv0Q
   KVPpaBRlujGdsqTpVcy9Yvp+mlVTF9VPv+SYLCHoK3LCQ2hq3eVvTgNoR
   PMBCeVnKjWEAETa9ui1fJnslqTifHUnCelQ67+Ai5BAnxOBtN5A9svlfh
   w==;
X-CSE-ConnectionGUID: TCi7IXyHTo+An9kry/8jpw==
X-CSE-MsgGUID: wduds6BNQy+/8knpanLcBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41330953"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41330953"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 18:26:38 -0800
X-CSE-ConnectionGUID: 1n/gHrDnR/O3Vuap+qT+DA==
X-CSE-MsgGUID: W2ZQDfhMSxazoHyRG7IGeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154385995"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 18:26:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 18:26:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 18:26:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 18:26:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4nPOupDp9KO3jEo8/yOnMpaSADtyKPIy78wqrtWtfGMN02hIQMlfHydgG3mv/wzALcJnDWkz6hWnj/9rMgx+Vq6q4Qa8vV1DcHK3zvCuNQZipRPCguWNtux72PpcBwc37fasUvbT7kU334R4+YmncP7fKIj3xqFYVnLMu8uqzysP1CibLzkInj/vcCCDasVhiGoKkK3c9EslCq8GF5WnkMUNcao7xP3AcTbA0lke+EysbqEgKcRaY3U3HgSbysBgbBj3HOttuILfAn9XZ4Gt/ABQUjJ9sqH39J6clodEQPik8EU4XcVvvAB1IDis0AHlWg7OQDoYpF5m0b7cQyU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn1lslcsj+2n7SDO+9VoRIw6jN2QpOzhwQh+L/uwWsw=;
 b=e6Ix97o2kf/CaMdXWlLtHP2E+qeTy+Ijbs3WzCPJvINLjQRwyWEhE3kw2KsWkUC3KayC/I8nQccnu5K2z6BsYm+YmkMLhH6LwyqJN7UTmChvyXL3/f07VnUUIN67rJYzC7OqDxf+tJNvhWWS5dG0ioSWbe4QPO7DJFCNHIsOqn7I7iGZ8rCOM2vqK7ouqw1n0UqZUnSdC9lbkFTLevCdlO4EVOdWr1mhEuraHwfnyWQOjOW9TG5aX2/rQL3JY0aqdEM+KgMJdA1L0pXOIe/csAY9U3fRv9vfbYj74N91dbycg4aMCMIH/TyvIOik9CR3D1wwK5hd5G8aeP119sYdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 02:26:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 02:26:29 +0000
Date: Thu, 27 Feb 2025 18:26:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67c11ed38ff8_1a7729458@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
 <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
 <67bd098f4dcd1_1a7729449@dwillia2-xfh.jf.intel.com.notmuch>
 <cf2f615d-2a28-45ec-8bb9-563c2a5bde73@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cf2f615d-2a28-45ec-8bb9-563c2a5bde73@amd.com>
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: d49353c9-fcd0-40ee-7836-08dd579f4ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BXTRrxGwGr8iRsyJvUX3Lqo/yUmu2z/QSexg0SN1y+dTN4JgM3Kk7cB5YKaA?=
 =?us-ascii?Q?vCsRpGPlrc0DH0H1STARbAAQc0AmpDG4V4/KwbAj3GsUmzaBdWjUN+BcK3cX?=
 =?us-ascii?Q?O3whZ6Ss3OAEwvVMHBkasMLsy/PajaSSlytlMtaevpNNvX9KjqHPyd6HJra5?=
 =?us-ascii?Q?YTkp8NCK1aistRGzV6ymQeSwZiPYHKfVakeFf9NNYjJHvuPliMltg50R7/a0?=
 =?us-ascii?Q?0NFwljVbVEF6so6QZfvdeTk2RtGA8s8lAIjYyfb5YrfNE1DR7lRzYXIF/2QW?=
 =?us-ascii?Q?mITNavE2SRp0gOqJeaGxfmcARhKLJ0nVT4T9fyw8M8MNDkY14kApD7jB/j2B?=
 =?us-ascii?Q?O5o1SLlz23+c0p6dqNUScCOfWHAcNOt/oRAB83A4n0TxFw/4DdbBE6Gq0/3D?=
 =?us-ascii?Q?cWlyI07ctN3o6vQqj7yk9W3zzLJcr4PRBVweQJSwn5W59EwgdaWD89qcSymG?=
 =?us-ascii?Q?7TEZTb17ySIoHBaNWz+Rw5a76BHTQX3rkP8CVK13NLVafPf/55/o4cHd6MF7?=
 =?us-ascii?Q?qcVbx7jd3dDPAI8073O43wbYkrEf7L2PFTuwPKn9m+TgWAjThuJRfbEreTA1?=
 =?us-ascii?Q?5+IdewA1BHOJ38h0dv6oEO/BYEZQVnm+hE1ixjrMI3JzguZ6Vz8TAoBu4ApZ?=
 =?us-ascii?Q?0xz9y3uFBmTlpBoesUJVMIbxZ1kKs3pLGhAenm5FNNvJvyjBU/Iyn4LHixsa?=
 =?us-ascii?Q?fmlqakjHtEl1aBmJJICCLDNXHgxBtLeSjed3COONYrsv/F1J0bOBtZQf6h5v?=
 =?us-ascii?Q?1Uz+LiACUnqDe0p6hEYN4mSfR3W0a90/vzH5ZPBO9xJN85obDsSjrw2PW6/t?=
 =?us-ascii?Q?X1B40d570wxTs4m4eSwG/xBl1jYaPFGDiR/2mIs94MPsIVSuATRVJ9xMQdaQ?=
 =?us-ascii?Q?Io4+zk8xejRIkdnBk2zcw6baZWX2/+JXYfuDR9P8T0JhUvcGtXa3Ls4mu/tE?=
 =?us-ascii?Q?anE2UfU4iAD/yscI40jY0/sRo24LUkQ2ntW8/pNisVndWB6T2P3B+jCFUMih?=
 =?us-ascii?Q?XJrFMkPq/WQg4GVZ7WRhSYZReiEMYV+rsBEYG26qlWqP9Fahf5gulCIaU9/X?=
 =?us-ascii?Q?karbLwNqaDz/o3vuwmeaSFWlZ3VGRJ7J1jE2/XfphRbfim49o5Tpk+HDPO5I?=
 =?us-ascii?Q?PZNTOilRz72wGJH2aEF7am9SodxOY2ZHz98vT5B5r1nDA7vhGKHwUbswFg/+?=
 =?us-ascii?Q?pYe4FVnfRUu08njEXkJCDZrbPip6AdKHD3T1lgrq9qGMk0JEULbIseWWKgTn?=
 =?us-ascii?Q?ENslYmCPBHktxybVCTk4Q2ZHguziQYWPTtV+6XILk90lSJ94KBxPNWvK/Cl8?=
 =?us-ascii?Q?vE+cczGVt+TMjxvtTJDsqUVwPfYx7myuxrzkU7eDLZqQhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4LSPSq1sQdQomiovchUxZevZGx9ilFaqKQxb/D5gznjWtxQ+WUv3WVdEFm+?=
 =?us-ascii?Q?M3G4G+Fz6nBvLEX9+nZBKZD/z0k0eo72PgzCcMU1wfychE4jewpkC49AKZf1?=
 =?us-ascii?Q?7lseduOUBZzfWNj69pX2NWan8eKiGTeAIddJaue+WBlL9qc2P7sZFK2QMJof?=
 =?us-ascii?Q?L7viteWt8ylXhPYxGT4NeORBHeSIEyOBCAXH+ricbz9QhrafbY5IgB4KEmLh?=
 =?us-ascii?Q?Bl4gJAHV98QSgnTHUhjd8yiZM9bvps2NiWvagZnwj8cX9QTd9eEkc6WPdb3g?=
 =?us-ascii?Q?VzyhOItClKjL1FpWifIB1IMXNCd60e0SMuVKPY4qNH7ysNW2TcKd0dXeiWff?=
 =?us-ascii?Q?qlGkmEIBdakOjfxs2fzrjvBDoA27QI47femBS23WVmtC4FVeZgpK3D0qmfpN?=
 =?us-ascii?Q?JQuQdOw1QRnn/a8LxqOzqJftJrlgK+n6RE9CiTz0040xNqAY1x00TMH9qX1H?=
 =?us-ascii?Q?6g6Zuiv4SMBrFJeI17KO/W3dZQF9w3L4z+yqBRoEIXOay+INiwvZf1t1/aCi?=
 =?us-ascii?Q?8x+opDlIdsQmeDcqjS7YmLnPjvvQvhKuN9YC51iVf59eOFkqbswSlvmJxyri?=
 =?us-ascii?Q?u72i4bT6Ds2V/YlX/e6/0dbZugR9WRUKVe3GplVW8UhxCtJ/aX+XFYObyoKO?=
 =?us-ascii?Q?vaSMeL9aYnCE+aXWeyOXkUmPmz2HtsIkGeXiX9Cv7f3GpQH+6P1sB5lM6OrS?=
 =?us-ascii?Q?5q7+I2gZAbjtAq9fiM36NM2eFcrHVR3LLOrtukFsbtA7C+rU5hpiA+iJm9+x?=
 =?us-ascii?Q?HRB0kwHGRIOPLNIx5GyGVE8hT4CnFD+u31099ZUMy8goYpqxWHGjLBTspmDE?=
 =?us-ascii?Q?iZEDz8E2od7vrICvfZWd6EUK5LvLopLrdu/X+J4saWQeiGNocZck8zl/Y0Hj?=
 =?us-ascii?Q?kibUF9L22Y3Y5Xh4MXk6T6Zkc+JwUaLlOf3mKvnmzPdiklTXXivKuOaUqIOK?=
 =?us-ascii?Q?ta6tB+sq/H3Wj9Ce2s0WeeOdJob6vxqVvfyolt4AWO3MnhPQb6ZtUnlkTs2w?=
 =?us-ascii?Q?EaLIuc/vTKY0gKmibO5RaCKrTBc0VmVGcZjR8ZzkSM5Xb1mfNxABLRrZvduv?=
 =?us-ascii?Q?OJy3N11hVZQy/ieMQiQg1RHfSQydI6QGCnSHvqNNQ4lGXnaQZ5stX+dxyPpa?=
 =?us-ascii?Q?5ONfARUY9jkUKgYuRGthyR5O9HfQVyb1klrsH/+0dJECf2BTOuEuX2UXYvEs?=
 =?us-ascii?Q?6SbOMEQiP6mzzEaswa6o8byU5CtfNfHtqYEC6R3rLR2j7qVswPbz3PMAEEEV?=
 =?us-ascii?Q?/Ja5/1+q4AtF7Al3gDK1oQYw/YsDNwq/VQ2+Twu5WucPyBrSJrDxYrwj6ZhY?=
 =?us-ascii?Q?YKxEiJEsE873RAAhQl3pgDyNi7Jmd23oiyHU7Sc5htH+NBmdwmFxwwxWcAAS?=
 =?us-ascii?Q?mPRZq9C/JCG0tV4bL0JuWkU7ms8wGV08CwN1HoIkH4hYSOMLbIxGbVVjxd0Q?=
 =?us-ascii?Q?2JTmh9xRriA8L3c69u6WTsJ+Rtf3teZhRAQW+gEEhmzJURyr1Ia+wjJ9JBPk?=
 =?us-ascii?Q?k2x9Y3IdUCe1K28T7ZPL+JtQNU4wvAZuldQKd9EdHz2lD24oLJikOsnM+SQ5?=
 =?us-ascii?Q?jXGQ+PY3nS/h4MWTewpPnpPRHPQ3mLLLx9tXkDjKSZaZQHWulpDreaK+o/SX?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d49353c9-fcd0-40ee-7836-08dd579f4ede
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 02:26:29.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Od1AmUYhVo4gqGke/ofdF4lGP6yYYlqXgD1IPIIOrTlYrLS6iMP7Y6yW0K/HeT2B6g0CyOkc9gaSBTNd5f52cKo85OPa2CXfWSnI4pfkAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> And it just leaves link streams unconfigured. So I have to work around
> >> my device by writing unique numbers to all streams (link + selective)
> >> I am not using. Meh.
> > 
> > This sounds like a device-quirk where it is not waiting for an enable
> > event to associate the key with a given stream index. One could imagine
> > this is either a pervasive problem and TSMs will start considering
> > Stream ID 0 as burned for compatibilitiy reasons. Or, this device is
> > just exhibiting a pre-production quirk that Linux does not need to
> > react, yet.
> 
> The hw people call it "the device needs to have an errata" (for which we 
> will later have a quirk?).

It would be great if by the time this device hit production that problem
could be fixed, but hey, errata happens.

> > Can you say whether this problem is going to escape your test bench into
> > something mainline Linux needs to worry about?
> 
> Likely going to escape, unless the PCIe spec says specifically that this 
> is a bug. Hence 

Linux has a role to play here in influencing what is acceptable in
advance of the specification catching up to provide an implementation
clarification.

> https://github.com/aik/linux/commit/745ee4e151bcc8e3b6db8281af445ab498e87a70

I would not expect the core to have a "Some devices insist on streamid
to be unique even for not enabled streams" path that gets inflicted on
everything unless it is clear that this bug is not not limited to this
one device.

Also, I expect the workaround needs to be re-applied at every Stream
establishment event especially to support TSM implementations that
allocate the Stream ID. I.e. it is presumptuous for the core to assume
that it can pick Stream IDs at pci_ide_init() time.

It would be great if Linux could just say "the maximum number of
potential Stream IDs is 255 (instead of 256). All TSM implementations
must allocate starting at 1". Then this conflict never exists for the
default Stream ID 0 case. That is, if this problem is widespread.

Otherwise, at pci_ide_stream_setup() time I expect that the core would
need to do something gross like check the incoming Stream ID and walk
all idle streams to make sure they are not aliasing that ID.

> >> And then what are we doing to do when we start adding link streams? I
> >> suggest decoupling pci_ide::stream_id from stream_id in sel_ide_offset()
> >> (which is more like selective_stream_index) from the start.
> > 
> > Setting aside that I agree with you that Stream index be separated from
> > from Stream ID, what would motivate Linux to consider setting up Link
> > Stream IDE?
> > 
> > One of the operational criticisms of Link IDE is that it requires adding
> > more points of failure into the TCB where a compromised switch can snoop
> > traffic. It also adds more Keys and their associated maintainenace
> > overhead. So, before we start planning ahead for Link IDE and Selective
> > Stream IDE to co-exist in the implementation, I think we need a clear
> > use case that demonstrates Link IDE is going to graduate from the
> > specification into practical deployments.
> 
> Probably for things like CXL which connect directly to the soc? I do not 
> really know, I only touch link streams because of that only device which 
> is like to see the light of the day though.

CXL TSP is a wholly separate operation model and it expects that CXL
devices, and more specifically CXL memory, are inside the TCB before the
OS boots. So there is no current need for Linux to consider Link IDE for
CXL.

> > We can always cross that sophistication bridge later.
> 
> Today SEV-TIO does not do link streams at all so I am with you :) Thanks,

Sounds good.

