Return-Path: <linux-pci+bounces-34097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13EB27AED
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C405C4A65
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3F0246791;
	Fri, 15 Aug 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vvg6mILF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7B10E0;
	Fri, 15 Aug 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246444; cv=fail; b=rEY4VDvkJUb2Byr/ecrrNmocdtI83qPks7K5PBnzZ9cEPJPHmicrp9xT28DFMXbHC3FspqPHycDSSpWNJRXODQAkwRO4Ygrc7ULb+xkQM4SijcUlvZGkfzMqlvUDPtd29/En7JgleiFQFBIuwEWHIbiuumdYebbvJeXuMRf6zE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246444; c=relaxed/simple;
	bh=Fl5Zim7fGjsuxEenZnn5jVEN/U6zbMh9Nlz+DAfWIbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TVNEgB+PAtga9wLGxXFWI8iqDevAnCKJ/YlPFNbril1aFOzzAJT9Qg3bMRp6lYPcTqW9g0GP7/vKoP7lvMpZqEQF40AK8+MhMB25CFGgEOPXfZ2WHYYEXfn79IOvtJGUzfTe8fmU8roN4BoJzu2wJ/PFElHY2Ha78arElojoWa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vvg6mILF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755246442; x=1786782442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fl5Zim7fGjsuxEenZnn5jVEN/U6zbMh9Nlz+DAfWIbs=;
  b=Vvg6mILF/mOoqJ4YH/wv1pvVPlp4pGMKHkWm8aKesA5tTxhpZnaSqv7H
   aJjnLsqMlqxu3JS27gL+mzTEYC5qRaEg5jBdUe5U0eb/J4ejEbh1W/b+c
   0gu8Pct7W9pAzb2/G12OFByyCy2xWkXXk9RlW1XBszkMsQebgPdE2RwPF
   YVpbvTVmh9Ha+XkRUKRaDT17gNiMPcRfV4fSU5L43DmhOEx4JMompjzUp
   MqIdyKJKa5bJyZeDpT8zG1RirJ1KXY98+fEgL6PzBtqxDSZWQc5K1Szf5
   H6vTZoVTguGuerh4lRKNxwM/k1QZUW4kEqeiBhae88XWnXMQG/1umsIU8
   Q==;
X-CSE-ConnectionGUID: IMi8yylrQw+GeVxtNEy/jw==
X-CSE-MsgGUID: wYXbOx5FSEKdowCej8Gl7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57496044"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57496044"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:27:21 -0700
X-CSE-ConnectionGUID: Jhu2nzWNRiWTGHWpaJqvkQ==
X-CSE-MsgGUID: p04TkMipRYKECOlKJ1pRIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166885118"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:27:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 01:27:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 01:27:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 01:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOrEZKacHvEEoB593QG+YfesllJG0xIJfqRpsywEpQYD177LBljABBHJMp0dLuSiUMJrzsvECYI+5esiBvVJqk6rkPcHXreI66/mGGl6O+Q++wX9G75Ryblqk55a5luc4kI+LCRn62Rrcjjn1hi7esDsWk1Te6/mdk1PoB+GsD2lsmlKRYZLxV9BlGtu6acv9nym2V6D4/mCpiFAz/GJ/z4MznqOhZWXZ6wN0Ewp0A1148b9l3O3htw1G47dlIEHcqQYMiCFFyDVwvRbITX4tAyw5aA6YO1eN/CiHEpJ7us3WZmX9M/OzdT2ksF4uBgwJZeKuW54ostE9zP1tPO45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldzc1cSfmJoX81jhJyH0YZhz8/+hw5ybaeQnv85Yfc0=;
 b=pn7CcGgL/mGkRhMg9dv9wVr4ayuLWLCybZbYVXlhWTAOACnct8e1wuuCwI4LeuSkQQgwZm+lYgXu6hZkHOVmS7UIkw1DibzWyAe+48sUl7r7xahhqqxYeQHBHmvg1aBqHCtgm1/DfNBOcU69rKwE2RnRvEyCOI6MukTDpgcJ2PgIiTn4NU19cTjKF6ytc9ZSYWd1Z0RvQqvNMT8RCffTMGeJ4Ymy9AJyxZyA4vdyyi9M19cekWR/iwbvfm80LnOedTW1UR0utgn7GHQTO7+42w3mYXYYsK2l5+I7w0Hh7FdY/le11ANOh5nXP0KulCOK3vKxTBODSz1Iry39dkPIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 08:27:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:27:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "yong.wu@mediatek.com"
	<yong.wu@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: RE: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Thread-Topic: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Thread-Index: AQHcCxPR9QhO2RgIz0mPcy8d8fJgaLRjL4CAgAA2iNA=
Date: Fri, 15 Aug 2025 08:27:17 +0000
Message-ID: <BN9PR11MB5276092A811C3FA85B1667C88C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
 <eb248b73-7fb6-47cd-9e10-5c54ca2391b2@linux.intel.com>
In-Reply-To: <eb248b73-7fb6-47cd-9e10-5c54ca2391b2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6246:EE_
x-ms-office365-filtering-correlation-id: afaa6e4d-9872-4ef7-ff8d-08dddbd58bf6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/ZPTIdf+BIbRpg5kBZOXSxKheLMd6oMaRa2KrP0XKPSMfFNtUN6Tu8RRzN+9?=
 =?us-ascii?Q?3OgTWF/ZT6VoDJtbMol83Ru+1hwdDzbNa/iL70CfHoYrTTvaPeX4A+m5XS8o?=
 =?us-ascii?Q?cgCu+RKWGH7RJhEGfAU8iQM22JQ45jNsEQA8vgiyBVVr/3VJaD+Ni1DtxCxd?=
 =?us-ascii?Q?E3fkXCm9U//Nh//NtLA2ArLTmz4/es2N6UQ66uXP9IejwPXVm90rG9lyYQGx?=
 =?us-ascii?Q?GE79CucgpIFH4twCH9ljcbEcvGU8U7pyigZbxnB7Kw0GnizklUcLlfKTtmcC?=
 =?us-ascii?Q?zYPZ7wr9xsdM/q1sZDNR7rGEtp7t7wQFFKDgp+COyi8Pxb5MIwLI7sYLn76V?=
 =?us-ascii?Q?9oJrLJWw8ggQe0itcpYrzZmh/ibHj15FAyThAPbQqEzV/dr6W7MxhHnzcLu8?=
 =?us-ascii?Q?fQzoXi57D4AbeuK1shYCb8EE597VX+aRzSjCozJ1oAL1PXPKAmfs70nathCs?=
 =?us-ascii?Q?prsvoPheMVVzDaLFOcaIkGmE+uQptZ+QITft02QiuVNlQ1S2rPqqTSwwB0Yk?=
 =?us-ascii?Q?XKqLKht7+7jr/cDGhv/pVQ9yWPQ/YBQ3XUT8yaYde6albezfRtaIuBEH1UtY?=
 =?us-ascii?Q?Nz33KxA0TqiGpwGDluORQKMtsvLeEQUTGNgyqi8qa9CG7Hxhag25Hi/eoff/?=
 =?us-ascii?Q?/UZP1sFPE6JeSaqM4nZIfATOqOjLarm3wFZKrn5KpKQSbEziDDJhFLJlz15C?=
 =?us-ascii?Q?iMLQjUBr/pisEcAAK15FkgmBQIEa2Jxt9Y+vrIaOTQe5lcEyDaOz6xceE842?=
 =?us-ascii?Q?QYKHZy0rY9ox7wM16RZgAjhWu495/do1Xj+sRv7wPTq0Mde7cxYF1zKPVppB?=
 =?us-ascii?Q?nCCtIp2Wvog7CYlDEgnq97ARmK/Omd2EGkTtxnffuFFSDf2QNaJmWd88yvBi?=
 =?us-ascii?Q?BdI8NiOn7qmNdJmFcFD3GxKPWO2YYcT7zYcadOVkh5K9FxnlmAhZ5m47h3ps?=
 =?us-ascii?Q?SIlgG286tAK0gli0uVN4SDp8pw1FPTx/TiGrM8KOALdDdidKnkTIXQOKnQ0M?=
 =?us-ascii?Q?1o4OETjeHa+bDccbChgB74tVLqSOJLiTOvCUP5VZmJ+JH6CLf0L9Pso/es+A?=
 =?us-ascii?Q?oNpg56EYJn82IkZHHLWTbs+mYBO1aAmmdi+eoJvv6Mjidl/au9ROqNhOsAmT?=
 =?us-ascii?Q?VmAW4slbGWcADipEmiWX+gdc/GxYLS2kjcZOfWlDkTcqI2ZRLsgfU5Swq/2S?=
 =?us-ascii?Q?/5E5hQTmAvYBiWmPhX8TaCtsfqIFPeJunMsa8SEd/fke3LosWvz4QGpe1WwW?=
 =?us-ascii?Q?+jby5J9Ex+GHgRNUhLpWUPI24nE0513H2PmqaXUAQB9F/UHeYD4l4Q+zaJAs?=
 =?us-ascii?Q?xKV2znnuTPs73hZ1Dw0B6CrhTVnU4Fa64LPgPnFBDD50nCTsNW/kLuBkfPWf?=
 =?us-ascii?Q?BEzNQ6WJiyU7f6YlnhHNtI4i1kGAiXX/c9omng6QH4l3e6SyaHgi2JlUqzGR?=
 =?us-ascii?Q?CaeoZbr2Rqar0+8/9LrtSm2tuh+mLv3tsSsRieytkn08f6Cs2KzCPg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7mj5mogDi8fVik+vHQMgmTZv0oGl+5pE+I6+z0s2lY3S7kxZA6SHn4OR1kt3?=
 =?us-ascii?Q?CosQwY6oL5b2jT/wbmb7tz0oD2aE0QUW65OPrhJMrDiJFqSbpH0e9jmXd8PY?=
 =?us-ascii?Q?hYe9kRrTQY0lUw64LnDdtIPSL7qG2OtGOaZZfig+lXz5vRwQ2ab+YBaYct7O?=
 =?us-ascii?Q?4UuF0I32NbELb+uSm7rpJhm43O0NCFBmgQMUxz7YpXso/LeEw9yYYnNZ5ODd?=
 =?us-ascii?Q?fjS+5JoJd7eZSKFoJT7p+Lu8pfHgAAEICKxHqfQWOQ+3xHFJAOn10el/hr8x?=
 =?us-ascii?Q?dPUcALGAkW8NyeK/CJE3HctYKHWu3oaQp+P8sv4Ksx/JUFVQk1Io2YymiNo/?=
 =?us-ascii?Q?cVnAWE4wAuAAQ3CtVR6/g1P9/aBSstK6fyvEtxnC6DT8xE47FoTmYFSdkHna?=
 =?us-ascii?Q?fuqzBaeR3R7fZQP/blRrIzKRkuJcsY3isAieTR6Jj1Xx6WCbfCPrfKhCcb0y?=
 =?us-ascii?Q?hrlrTU6o3h5vOTwq6KvxleFDRsOPdojXKMkSeXGOSNvNBYV59qaagU03DewB?=
 =?us-ascii?Q?fXBELqJJuCKcxe8owfbInRjGm8kvhomwfhYVfsWP7qC/O0Ap4LMhVRCIt9bC?=
 =?us-ascii?Q?qEPcrKqjiV51ng/5h0vSlpev648nmop/RrNWtrbJJkPmy7Kt02dlVmtIGSyx?=
 =?us-ascii?Q?EOkyLNFdBwFx/1bTY7tXB/TeMWyo6mii+2FF33HBECWAn205V0X1Tmnq5mKO?=
 =?us-ascii?Q?UfF4fxFSAG8zed9YicNewPoJBcYuPLjfd7rr+nIIM5pXfSm+lftoW5JQAjn2?=
 =?us-ascii?Q?1SjoU6Ui3HxrrY++gsl0B8ievbER2BhAORaqFpBBQh9nFniA4g4RENEyZSEE?=
 =?us-ascii?Q?KhN8GpIP8aptkx0FKsQBR4b8P6d6whCs4d43gXOQQDVLTHyzO0JiDagGKcq/?=
 =?us-ascii?Q?ylz7CM0xNetGFNSE146zrVuPrlehq2EXtKugAKQ6vd5qE+JwpWHBU88g+/rX?=
 =?us-ascii?Q?kSINTc/PvzeI7Yh5mQT+Og+T6uiOQ6/bLtVlVoAFPY2kCi6dTYvy7rtqWcS0?=
 =?us-ascii?Q?6sSR7FZDEbCh0v0Y8+6UMr2YeGVZvuEHy7D8Kt6rkfKYRv1mFhjmJvxuOX9G?=
 =?us-ascii?Q?KItGnuMp2c1fKnr4W0agG3Brf/M6Cxyl3wJWmBr8h9kZiqFfMzukyuwbvMDC?=
 =?us-ascii?Q?1pxA+dTjVQa8cSL1O91frVzT9db1pJ12w2qtctAoQn1oxj52XDzTquMQjhAQ?=
 =?us-ascii?Q?MVlzmVzFDqXd86FtVmjMOfVPDlQ/zlywOHDhlYp7oZfbcI2MEGze1PsFmA90?=
 =?us-ascii?Q?q9fMsRwXbR1SimqNyUQ/U/hqPYG37OXFNYVsS5cl76uEjhIA9ABnj+hnD4Ol?=
 =?us-ascii?Q?+AeZmm++gj8gYKPlYRoVmIjwdpA1Ck54hfZkAQ2dvbC9J50EfBQ4Iu7KJav+?=
 =?us-ascii?Q?OgM39L009GGRLMPxYe8LUicCxtnl1oPufAhmQ9WHoxSI58CCFEPjsBUsDtYm?=
 =?us-ascii?Q?ULHz0st0VnT/I+Z34pPlCloV1b9ihF9H6BCHrP1nTqJ3N7vjj4eUPAnhodr4?=
 =?us-ascii?Q?din/xW+7kmiSUBR1SLlusxMkAK4qdy5Q9TpkZU/iJNUyyDzZFrzri6wXVGnI?=
 =?us-ascii?Q?NPEYhfA7BxA7y7VWBM174qLX44/vTLqpALYWF4hc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaa6e4d-9872-4ef7-ff8d-08dddbd58bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 08:27:17.8794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCD+lrqBHayNdLz6X4HoZ+x4sKQhwMbFuQWJKevfXFkQ4F2sgtbA/i9NynHFuPEzB2VqEA41q9TGcFrnRO5ZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-OriginatorOrg: intel.com

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Friday, August 15, 2025 1:10 PM
>=20
> On 8/12/25 06:59, Nicolin Chen wrote:
> >
> > +	/*
> > +	 * This is called on the dma mapping fast path so avoid locking. This=
 is
> > +	 * racy, but we have an expectation that the driver will setup its
> DMAs
>=20
> Why not making it like this,
>=20
> int iommu_deferred_attach(struct device *dev, struct iommu_domain
> *domain)
> {
>          /* Caller must be a probed driver on dev */
>          if (!dev->iommu_group)
>                  return 0;
>=20
>          guard(mutex)(&dev->iommu_group->mutex);
>          if (!dev->iommu->attach_deferred)
>                  return 0;
>=20
>          return __iommu_attach_device(domain, dev);
> }
>=20

As the comment said it's the fast path so avoid locking. your way
implies that every map call needs to acquire the group mutex.

