Return-Path: <linux-pci+bounces-22273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E145EA4318E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 01:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6C81898B91
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 00:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0736D;
	Tue, 25 Feb 2025 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKZc/JxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251F366
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442011; cv=fail; b=YcOBaKcEp/eGtXtK9AewGFa8es3bevvpN0Wh31hCFQFKeAQBQvYD/9Kp0vdPWMGpTa8F+ekGCjxsM7ETqdjiFOi3PZBmOFaPuyLuc4cI4XE2zuwwib7BHjXp+ajLVkVC1WInnzAsfEbe/PWC+uhkkXhG0ukopv0PgWjkKfuGMuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442011; c=relaxed/simple;
	bh=Alp7Mne3ZZBgZRBEBL7FEjhJZpyw1CagMr7+cmpg/VQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVOriLqDDArKmTlfwuQ8mvFVUK9uwG2i/TVcVYmGv6T6Uu5QsmwSpsZpiRnljzybOpMtO6IQ3w8fyE7LhdwB1b4s2kikoh4QlyHso4mY4tFnRWQR7ZXc2J5KbxZB8ID/Q4btm4DHJn5l1nEV1iEWQe0UIMrQdyzwalQ67aokGIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKZc/JxH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740442010; x=1771978010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Alp7Mne3ZZBgZRBEBL7FEjhJZpyw1CagMr7+cmpg/VQ=;
  b=JKZc/JxHK4nBL5OQV75XJMhGqhSPDu9VXiRnNmlZ1S1dIRACwq+Ey+4w
   RR6Vz3XNK/W8DLFVLRlRa9ZIEuDnvQ4FGDYrAYc32gwUwtmQFiS02s4OG
   HvGuMvvAjQHlgAqSgNOM4gh2tCOQvTuq8MNzY78a9x11/lL6tTLlBMz4M
   YRv13sF9gpm1k21b5HhgrXL6LkEB+eN6Fk4pgxxQKy2IsbtW3O5shZ4nP
   s+AJzbZoe4n1HpZEv5GDG6JIUW00+DTq8V8R86n3OS25pFoQ0K+z4RUCv
   kITJGNfwv+e9sAOrIh6GwYx9bI9r1DQWfwqWqjbRnJHRvQswUgodOhWFm
   A==;
X-CSE-ConnectionGUID: /QNKPvZySOugFVEuQeiYKg==
X-CSE-MsgGUID: oBf5DewyQICa7AFB52doiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45004302"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="45004302"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 16:06:49 -0800
X-CSE-ConnectionGUID: Hqi/uKGiSKuvB9Ay0Xsd4g==
X-CSE-MsgGUID: Ah58BznRRry9SSkuOD5FJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121465534"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 16:06:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 16:06:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 16:06:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 16:06:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F35RahDzWBi2SQFwndeHI9FjHFyKzWrd/j3fXPYhQh7WKQoKDZcODwW6+0XJXHxyEuNOE0p65qYXjXV+KM9/KB11aWgPoPgRwJUF9RDQIKJ7tLvkVPaRWyU0K7Use08zL5ov000hyWfHRnatxN/JsA4KL0u3tApBnkUmy4LWU0QQDnWhdb8NCUDS7taMwpjIrtLW2HM2Ot38OiReKj0colEfUh34zQh68y7rxP1SFgQDB5sOP2WA6QlhST8azCG/TyC27VUOzuydR5hhDiMcu7JYWM7Yo/3n9wdUuLMQYBYu5Tzw4x7jxDPuy0LIpC912a5KWZUt7T4Q0lJZssQMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFIx+T78yVSlCdOegnB10qsLaymmSMG6nBlWNRwLdqI=;
 b=MwUsFcvE84kgOhN3hNW7ysiJq/hVYSSrS/xYv/TMEyN1gTpaMTNSz2Qbl0UyCCwnu4JthAg6O2rEiIN3Hg4/Tw5bFvKvfyqQJTn6W3ByuKzNU/YUp+F3nYrN5gUZOXPQHnOVC6KmUBOO55oV3J5zOzeeelpoa57Wku56ije402Okoa2DejN8hAEM1JiWt+do69lVCS3JA2D978mjBdqGGTiwELUsqss0ahUmmdGm6KCYnmt0+Phe6wKm3TDIwGaUY4DUNZKJjyrsZkp4khmyX3q9b4MhR8VK/hOEs8w+A43c1/wmNVxrq6TAFLsEysOZOc2TrlhZss37sePc+4wVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 25 Feb
 2025 00:06:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:06:42 +0000
Date: Mon, 24 Feb 2025 16:06:39 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, "Samuel
 Ortiz" <sameo@rivosinc.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67bd098f4dcd1_1a7729449@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
 <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed3d0d3-3338-499b-bee8-08dd55304866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cYbZnzVYTsGqDFoHosaUpK1b/ESkUFlqCSLHYM+229VRRLI0lFzv4gpWEzCb?=
 =?us-ascii?Q?tFrMZTl/N5wzcIVeMJWLf86w9zMLamaKBg9/yUKTkSnykvf4IgcEKyM+t1mR?=
 =?us-ascii?Q?/XOx4Uhl0VHyWypXrsU2ORmQqZH+dY0xzBoBlIJ7L7HO/klg+lXdYV7rQv3Q?=
 =?us-ascii?Q?QHJ6CRK2OcOeXir9TT2z6Gw+l90tiMO05OkllKMrdi3yuDpLA4VISyAa7Q3W?=
 =?us-ascii?Q?pQavquJkjTO4F6WZ5VsNnnz/nxE0Ne7RzlQFWBjKwpEmDStqmR8n61JduwY8?=
 =?us-ascii?Q?QRwZaMzAK75G1BzQ06YqFsV5W8U70w+WydYKw5zoaAzqp6ndRQ5JBFQGPMGJ?=
 =?us-ascii?Q?zrg+hugd9tSgSv4Th7s5r6gcSp6h0k2cSzIyqCW5H5K4+MRPS/T6zsF2qQG6?=
 =?us-ascii?Q?a1uRmeawkME14V/XC8wOC/FPfXD5X2qjFljVJER0ttlOQ799aDO1DQiDxHwW?=
 =?us-ascii?Q?LFsJYusnZRfFLmBZvA6xSvvmQp+BlTlhhuaaUnsSdU/+jiuZie/uQ66nERMG?=
 =?us-ascii?Q?GK9AZKuhxmXHWWdJMC80UInFPtkPYo/vRJdZEmZfGE0fGhzCf3WXt0HaRmT1?=
 =?us-ascii?Q?Xv//tncgeaTtbXbbv07Q8MELn66wofkEBMvMgIGKdlf5qaeiI81lDMHVveIj?=
 =?us-ascii?Q?uzYUX+3wLqH1jMM1MKI4Z2Bs2e2p0S+QWiG4galGMBRETk2C1DD36UBlLvhr?=
 =?us-ascii?Q?81n1iM+c4mh6cIZAkB5wTVzkJtAYTsvF+E2gzZsfRVUJwmiEC9sDIG8AgJYt?=
 =?us-ascii?Q?fZWPdy47vO1fWOw2rQLPz8FzbefGvCuzSexOBwfZ6u5dm10WYMZW6xU4Pw/l?=
 =?us-ascii?Q?G/Y+vZlLOek/RH2kreHPay30oKR9GWZat376sAe/ghPRGHtgXK51JgL4702a?=
 =?us-ascii?Q?vyxDmBhFMtDs70PX5TAfFjvomQdQh2EN5AlTKu6FSw9FsPWrT0Dfs+iBblWZ?=
 =?us-ascii?Q?rtYVzRQOP/VOCnc7kIW+i/XFL889fpmbOlHyTc7Y3H6E1EfjxIc9QggAJxB9?=
 =?us-ascii?Q?Dkgnim6j8vZjG60LjremUzpPsnoWY/MklN6vXoQWCqW5w5POhQbphQ4LzaL9?=
 =?us-ascii?Q?ZbPhI46v3X6G4VN5wJGh4mu2d+MvNTQ1KqImtGUiAdxSuL7+LmsqOUcl/8WE?=
 =?us-ascii?Q?qDZeCohJYxA0BuGnH/OIdzwUWg97ldWWNWzBZ8TmLiCdBkrC+RlzNuk836TQ?=
 =?us-ascii?Q?7MVR/5FVFZUCZK4Q2BohKRlSyr9bUul975AKG4QLDf0NxnsbV8O/4MQalqGy?=
 =?us-ascii?Q?YbyA7DvWldseiuHbFrSNhFYg3u6YXeeR8qvwJ0WoPCJ4se7NOR3Qsq4JDN4c?=
 =?us-ascii?Q?vgl0VUDLGctgQaTWu5W3OMvAqgOjJk7dFayh7At7kgmSQxiiHCOZ9hwqp4eG?=
 =?us-ascii?Q?rtMRAk0t0bFyy+r2k5P19Xzjwmqs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G3BYqmuZITi1wuVDQ3kMw8mLADSOpK+BnxTLmtiZaNwJNj/H7BPWyHqP7ul4?=
 =?us-ascii?Q?1Ao9rBMjI6pCrY7umUR+pIT7nDICh9GhrKxctykysgZHt1jrNVdrOxfXvwjM?=
 =?us-ascii?Q?uxnb4yoPEXgwn8vYeeO9/c5Zyu7Gz1RdXrOQwg9rkbfS1MYKTzpvsYimH4Hw?=
 =?us-ascii?Q?Rcp7Ea3M4H6RINDIZkQnPksAiJ5Vq1VsBL/vT5ZYY4wHSFTwq/YzQRs1uwJv?=
 =?us-ascii?Q?L9zBLacOs55d3VgdJSbf83cGFB4bUsKHBnbqRp0NLuMl0iLnHQdDd/gRnzEw?=
 =?us-ascii?Q?/FR2WLmcXWFXHqVhi/p49zH5hZ/9FFZBBwyN7FI87i1N0/BrcEgl3r1asTQg?=
 =?us-ascii?Q?LBpih0z8CRdQKSKTZdpgwFNgLR67soWAmSVh4gXxazj7iRAVGR9sGHpPYF/X?=
 =?us-ascii?Q?Lp4vmckJkW4iUdbXZARZSFirRYElQBQ/5pddLf+HnXPBLONSDdJf0CBBJ7RE?=
 =?us-ascii?Q?F68MXqn8p7FMgG2M5kecNNc7NMdaZKPitnp4giGP4+87bqp0p8sTQ5EvMHqp?=
 =?us-ascii?Q?/QeqdH/FWZauMgGPVFqeboo1nu+PG9ITgV+dwvuiy+5+oSDdbEmo0g2MzT6p?=
 =?us-ascii?Q?H/q+aqgmAJGN0BHrGRbzP4HCERdcUSDlUAJmsa4ivroVMHghr8fPgto0WQFP?=
 =?us-ascii?Q?LsL9GB62YMBQo7kCtrHrxwxT/y5/a6zXTQ2mzLym5O9hf6FbtQx9B8TUhaWL?=
 =?us-ascii?Q?ZebksYJCvdShW5veCuqCntflr7cHnrLJAq6CqApahlWZXJ+ofMwCkVu/LOmV?=
 =?us-ascii?Q?LZnmuuJDfgVMJOfXw0ZSEK2uR9ezsWrmX+xN4nVW2SnieYfZ12TwStNjX2b5?=
 =?us-ascii?Q?CCRarWvE88cLHU4qDQtd8xsVgAq7b7+xMl0H3zk3gAiVkosuyZh+zCtdnY2L?=
 =?us-ascii?Q?Nd4QdpLAlm9MQO81kIv4UWCdLF9G5zWLP7VP1JskRzbXrJBLZUSeaUMA98VA?=
 =?us-ascii?Q?NXVzfMyyKn7wVo/kJ0xvAeeQrlBUsS0bRJh7LZz415JQ3LSPZEvGSXS2Svz9?=
 =?us-ascii?Q?WR5f7QwP37XjaeiLyaK+q/12HkNQrwO9BXCtskPnZmcuvOVGOZjeS3ox6sy3?=
 =?us-ascii?Q?cPMQZaAHiWqnXLWn1cAN9orUBFLY4hd1jvULN91EJ7GIN085YCCi8GD7LFHK?=
 =?us-ascii?Q?+MIYgs6pQSIAw6i1qxMpYFWQUa3qQJEmlE8X9LADdjqUOz1OVBn4tJxC3uPy?=
 =?us-ascii?Q?jgul1AwHu2X7YvzFusL5cYXW7ndGF0CAjXMGRVrXLlA+Us0s2kpQnuymOlJk?=
 =?us-ascii?Q?BDRx+MQlOFx1J8YskbvO+8gqTCCr9QVsNmH6Y0VR0tzqz6K9/5k+DicvXkPm?=
 =?us-ascii?Q?E6gsbqmoVAvDMveA0/LHaWK1VhdeC+9rz9nq8rJPF+fHm7Rh1vgaj5Z2TJPY?=
 =?us-ascii?Q?dxA2mNQLlk7JsPFhabfT35sAURKdxn8G1w6YrZI1Edx1E6ZyNuQNpAiwqeqm?=
 =?us-ascii?Q?6HFMLOg7p1xDCu84TZ+aDhkEAb8lBkzSLBKm9FfbVdeRht8ViOhvXech5oT+?=
 =?us-ascii?Q?e0xLT4M1Ec+pINSd/rW0KMTjiu5AdSzhl6ZLbwO0t+KKDqRTLKF3/YRaPJ7M?=
 =?us-ascii?Q?QD3sFqt1TLejCkaOzfnt2skDzVsPdvLI++P5kROqHSCWAUI+DBG11nP6FNOt?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed3d0d3-3338-499b-bee8-08dd55304866
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:06:41.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1TI+5RV2X4hTb4UjZ486FfDO+pRXDWol0laHbspW0GORJMiAFvb5yr3izuyOb4LEqP8L09ERVYyauzpyyCURiEoEgU6n9978nAV3I+P820=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> access to set T-bit). The device got just one (which is no use here as I
> >> understand).
> > 
> > I also have no idea from SPEC how to use the IDE register blocks on EP,
> > except stream ENABLE bit.
> 
> Well, there is another problem.
> 
> My other test device has 1 link stream and 1 selective stream, both have 
> streamid=0 and enable=0 after reset. I only configure 1 selective stream 
> (write streamid + enable) and do not touch the link stream.
> 
> But the device assumes 2 streams have the same streamid=0 and when it 
> receives KEY_PROG, it semi-randomly assigns the key to the link stream 
> in my case so things do not work. The argument for it is: every stream 
> needs to have an unique id, regardless its enabled state as "enable" can 
> come before or after key programming (and I wonder if somebody else 
> interprets it the same way).
> 
> This patch assumes that the selective streamid is the same as its index 
> in the IDE cap's list of selective streams.

Oh, true that should be separated, and perhaps that is the concern that
Aneesh has been raising as well?
 
> And it just leaves link streams unconfigured. So I have to work around
> my device by writing unique numbers to all streams (link + selective)
> I am not using. Meh.

This sounds like a device-quirk where it is not waiting for an enable
event to associate the key with a given stream index. One could imagine
this is either a pervasive problem and TSMs will start considering
Stream ID 0 as burned for compatibilitiy reasons. Or, this device is
just exhibiting a pre-production quirk that Linux does not need to
react, yet.

Can you say whether this problem is going to escape your test bench into
something mainline Linux needs to worry about?

> And then what are we doing to do when we start adding link streams? I 
> suggest decoupling pci_ide::stream_id from stream_id in sel_ide_offset() 
> (which is more like selective_stream_index) from the start.

Setting aside that I agree with you that Stream index be separated from
from Stream ID, what would motivate Linux to consider setting up Link
Stream IDE?

One of the operational criticisms of Link IDE is that it requires adding
more points of failure into the TCB where a compromised switch can snoop
traffic. It also adds more Keys and their associated maintainenace
overhead. So, before we start planning ahead for Link IDE and Selective
Stream IDE to co-exist in the implementation, I think we need a clear
use case that demonstrates Link IDE is going to graduate from the
specification into practical deployments.

We can always cross that sophistication bridge later.

