Return-Path: <linux-pci+bounces-35993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5372DB547D2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C42BA155A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195AC281376;
	Fri, 12 Sep 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6AFLP2/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282027F00E;
	Fri, 12 Sep 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669658; cv=fail; b=Az5+m68/NYNxs0DT2sQt+Z6SElBBwk2A70oD7C7HYzCigAbfpRMNXAq1m5GUaP+NXRK/ubroIR+WOAKkukQ3s1PXw77IIn08bM/PRk2q5pGtMKAOrmPux1zWU7WCmDq1TAEWHBjYTIsKiyaM1y3Ghofte5/aUiDl5UlgYTLSXSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669658; c=relaxed/simple;
	bh=jtxfddYwv0U1IEn1m4ECC1LQ6y9CF2mas2MXLmGII4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E7nHO62rvsBRnBleCEhn2GXt+U8KNDrGwBOorvODSllrf2fYWMwoarmvLTWKR1xM92emnizxHSst9s3LmRrpTTb00ofKjRa1aRSh8QCbfTvrtz28dQUQ6bhSp3679lTbu02RhsTkJsxibr+ZqWJeahB8JWFIY8TXlxcCNWK7Uzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6AFLP2/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757669657; x=1789205657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jtxfddYwv0U1IEn1m4ECC1LQ6y9CF2mas2MXLmGII4k=;
  b=H6AFLP2/CcmYLvl4Cv5vC1Dw1bXEKS4zC0r5LRu9dh3t0D6b6UwhHQqR
   lySGUxPcCgXPGkSZ4qwuFFyqSgQuhAmDBpZD27UBQYVcAmEyMgGNWQjHH
   Gv/h9a4R9uVFuQ88e1nRP2UpNb2matAh6cQci8jSJ508J9Dd4oaUU6q4X
   qmGZRkceHT8LqpJxuHSV7hgZICrxHVqhA5Y4a/LJcBqkN+WYBbzVEpcDN
   TG0BhZinu/RYPMFr35EB4Zp6eHtqJWZcc62CtxxwD7V8h1sNyAlyVWblx
   a3rLKIuqGFPDW7W1PZJtCjWjtX6FqpCx45EqWQNLpj6jeq3D0/cKHMWaI
   Q==;
X-CSE-ConnectionGUID: W+3Q33hTSNux8piUHqhBSw==
X-CSE-MsgGUID: GtuptAiFRiyfJBxwvVR7vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70266597"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="70266597"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:34:15 -0700
X-CSE-ConnectionGUID: 48kCQrh5Sfan7w+FbposjQ==
X-CSE-MsgGUID: m1mQMB62TUq2e9ZY3iZGmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173834376"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:34:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:34:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 02:34:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmcHu+Ogst0i4h9LHhNI3ek8K/lhzoXssJFBeda5S/qMLzQaT5aehFJ9PdP1zGAGhIoX0GhvmsppG1jp4A/Qm7Ik5rtJkmp+2xkfg9NVyAjtnBpiBqjwtZdA0mNtACqzoiimq4qHLxXzxiNYArA6221to/UR+j8F2KLWe6ZVsHBgIZUkUCEk6wpEQE63Xp1gILHr1veChm8xpI8D1/H1lok3ct2lXFCdSxKKE17kXOPldpNsLOYC4Wak+dmYHwYTHdOBb4t5nm9applc8AlpE3QXkxtAoyjspdr6CrVpxqqDEBDjQU9xByedJFxGK0oKCuhMw6Uant+r2B3mhhlSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtxfddYwv0U1IEn1m4ECC1LQ6y9CF2mas2MXLmGII4k=;
 b=BE9gJk342TLDA5qHf5Mkuzc1drnD7DBY5vT6BwyXrPxLA2PDfItI7Bml3vihNCtyq3ao0aXJ3x6tyqa1Lw9PkLvj/oCCV4ovBZ34O3bt9UQWg1ASgPk7XfkOeMO1lc0cGsyEfIlWUTvRrbmoJC+HkBoeNgWN1amPYvyj849Gyflij23tl9h2c0VHqrncIWFUixi4xSz0WuJcGFy32S4D1XFbB3PfAYswPkernRCobPK4RGmAbLfWR/IhTBOUnBkuWGPHxaL3wNWXn14VyysnO1NWxP5psOa0jDrrd2NWWkdpZL0uIA8EzQ6aaKD5vbdqVctcuCbecU8LpvTCSVkMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 09:34:11 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:34:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "sven@kernel.org" <sven@kernel.org>, "j@jannau.net"
	<j@jannau.net>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"neal@gompa.dev" <neal@gompa.dev>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "krzk@kernel.org" <krzk@kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "tjeznach@rivosinc.com"
	<tjeznach@rivosinc.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "heiko@sntech.de" <heiko@sntech.de>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"zhang.lyra@gmail.com" <zhang.lyra@gmail.com>, "wens@csie.org"
	<wens@csie.org>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"samuel@sholland.org" <samuel@sholland.org>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"cwabbott0@gmail.com" <cwabbott0@gmail.com>, "quic_pbrahma@quicinc.com"
	<quic_pbrahma@quicinc.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Sethi, Vikram" <vsethi@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "etzhao1900@gmail.com"
	<etzhao1900@gmail.com>
Subject: RE: [PATCH v4 2/7] iommu: Lock group->mutex in
 iommu_deferred_attach()
Thread-Topic: [PATCH v4 2/7] iommu: Lock group->mutex in
 iommu_deferred_attach()
Thread-Index: AQHcGs+W9Oo0DISsqkOnH3QouS/gSLSPWuSw
Date: Fri, 12 Sep 2025 09:34:11 +0000
Message-ID: <BL1PR11MB5271F7BD6FF2E99D6C8EC5688C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <9b9199e03c87c3cf8152cf93dc403a95c883811b.1756682135.git.nicolinc@nvidia.com>
In-Reply-To: <9b9199e03c87c3cf8152cf93dc403a95c883811b.1756682135.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CH3PR11MB8518:EE_
x-ms-office365-filtering-correlation-id: 1471f802-cb25-456e-dfec-08ddf1df87ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Zze1exWN2+G8aE7Xk2WBlqj40nNkagWXvwrOIAcjIHxI8six2V36E8FCXIdC?=
 =?us-ascii?Q?+E4YVpJm2amM4QkkG17omypcoHd/fcs5gzjkUXPx6nbdtyOUxwfcsw7FsCbd?=
 =?us-ascii?Q?TMfK6L8qn8CA2Aqw8Nnz+luaUBIRO4lcC0GsXlhzsQF7U5EFm59V/OPfXW1K?=
 =?us-ascii?Q?0jE+GyqLAvZxyow14WYjr+/DyoomXtLya1mGi8t7zj0Z3GJdo3JSDvF145jN?=
 =?us-ascii?Q?+3gZ1CK0FGI3CBYnJlXTULEW4o92Nmb1tJyYZbWRv3eSm0n96Sk0M2W7tJEk?=
 =?us-ascii?Q?dyZ3pct7Hp5R8nui7kTlqIjSWmoLBi4HQ0QM6Sy8fms0v+QwEJt8Y5uWpW1C?=
 =?us-ascii?Q?0chPVmterVREAE1fIq9IaiUUIbc1Q3UaLO3S7mGVFtsaO2TRpd4nzJmfFRGB?=
 =?us-ascii?Q?o+7MFwecuXYLZy2C+H+la7CWHfI269yiDJGG38ff0lIsVUQ2CYR0xVWI3ENz?=
 =?us-ascii?Q?D6UI1ZFTciot7guwVp7pRvhMS9cjncLtBWfRLa/e8A92/AZXAfLIOts0bPw6?=
 =?us-ascii?Q?KVoLsuXoYVHO/dFlRNCICaRDJ5q+ZEkkbC3Nlp54j/c+a1Mltqn18OFEMenf?=
 =?us-ascii?Q?ua3J8A1bAW4ennxcxjUSp4SmEzEU3X5DvFD+Z55q+xSduA/f4Lt6hIgbiAO6?=
 =?us-ascii?Q?J3JduXKP2LgzUxsskRmBFg0friizrbHD0noxzVzPMObtlz2kruXsSORXMVS1?=
 =?us-ascii?Q?uikQRoq36baKRMSHlNSIwi9dCQHrckcUteVJSpSzCsJ8IEyRdDjpK3inhPzh?=
 =?us-ascii?Q?PipjpjH63UcEXgRgkfA9vvUOoFSu+b3UZ7w04ur2ZIsW7oVpUfD4nolVTIJf?=
 =?us-ascii?Q?o+2pijwloza5NqgAA78hLYz8iKtOLz34n9xhQCGw5bjTKkaXXP1N5Su4+GTq?=
 =?us-ascii?Q?M2TbeYEL7BJYtWW3ISCZDhU6Ro+ncEXgNf3bfwp/fSPk9Opr6yt8nHwzmbYa?=
 =?us-ascii?Q?c8gt0ChPrxuIfh9Yal2qWI2hUb1Dr0DrKSsKhoMLe7dFgzJLSOOTOsTefJ5i?=
 =?us-ascii?Q?CoQkUKLkFJ0ZqdWhG7zL7/kpDUvYAPWh9CWsrY0mgpbisehjFqdBn7TWOlyD?=
 =?us-ascii?Q?mWE2nRFRCC/z84iR6iPGWK+NMC3brQA6Yo8F6Q/K+aG8yMKG2MVa2tZsE682?=
 =?us-ascii?Q?ySh6G3G5zDVeyDYCJSjQyi6ZiMAv6w3ZVcA2FwHtB/fdeCkD4FMrtsSowpcP?=
 =?us-ascii?Q?J5WnX1xjaqHD9YSYEImu8BYngfZ1UEa4PlN1HoSJbMyuLBNEYVBQIMvYkuPl?=
 =?us-ascii?Q?BN1/GEsJBaeqMguKs399ZQLSiDtGlgJPEaNScKcW3riPgAbyEqFsgPsSlvbF?=
 =?us-ascii?Q?1ULxkktyrEXnqOPnT168tq8LEFTwK9Hu2GQ+CU2+kuAggDwEQZBRcFVCqPoe?=
 =?us-ascii?Q?+HeCkl4lv/nOEoW9+HM4IGRWPBn+EEj7BUJvfoz6LUcg16EGtoLT4fYjwdwy?=
 =?us-ascii?Q?Z7+UkKaId71shJomxNZY6G8NQbVQ1StpDxSP0tdkP4bdArD5A4BB5Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BqfpXJapmLZmFMMjFNf9LIpE7evtkCtreVxoG4dfxlVj+xy+XMlz4lOyD3Kz?=
 =?us-ascii?Q?7yEtkq9Kai18x2nrVVfYVxYdlP8+eY1a6BNzuMw4ZVoBld2aDkQEBeNPv72L?=
 =?us-ascii?Q?ccjJaz00RyENEOlIYhJrY7J5IgOG8FeTquyN0J57dkw+hI08pA69LHFKXj/a?=
 =?us-ascii?Q?IjH6Mba2BXRypMDrWAld2CYx4zlFAbIwPNi2rj12AAoqPusq116+XpQXZjLC?=
 =?us-ascii?Q?/HcLaqrg76Vjs5W19yyp296WkmRs6mMHwDTNj7bMlbJmLb3nhal51lLaup4j?=
 =?us-ascii?Q?aI2ajGdegCkKCMMFFKA5rSW73xGjsJpKRsMXGP1+iGGtwQeNxMYkxzDo/7f9?=
 =?us-ascii?Q?/hSHeB3zLuA0kHoxs8CnRZeK2toRxYXXKoekJPIUic6GwdQoKNiBE12//cYf?=
 =?us-ascii?Q?lqz4Qg56N3eL5ghmyh8nNfsJcTQFwB3RJ8IiIZwWm4WuOMSgd4x6Y9lKo7m7?=
 =?us-ascii?Q?Nu8EdsI98HCmwuXsKW3W8+B157BdnwvKfECO59YM+ixxFAOkkGwuVE49gp/W?=
 =?us-ascii?Q?72cl1kPr63hbxFQyNkReQrNZPH+XOLriDEx6rHZhwrJGorGABEL2oEojeYwa?=
 =?us-ascii?Q?XIkBrpJ+mE8bFbsNAUFGulwB7iuzgf4IIxw2oK6vbyFSobpuejdZSygW9/Sg?=
 =?us-ascii?Q?rTtIntJQRPm0nyjXK+p3aYTR6G4CB18XSWetXAXljfCL/ZG67Kv4MGAlPjek?=
 =?us-ascii?Q?gvFzIFMDs4N7A9+4WIpJC8zX8SigTuRe0oaOLl6HKSZ4PwiV6EUV5ifadkfC?=
 =?us-ascii?Q?rd9enKrv2qIQLzAJuZWyidfP52NWio/f0x0F9EE/P9wwvkvBFT3lFukwI0m9?=
 =?us-ascii?Q?Dz4r9d37tqc0QWZba3wflbfiRKltuHPhOWn1i5rsn02pWyhqqT3OfbFZdu7h?=
 =?us-ascii?Q?g7rNvXEXhpFjC9i+vDbrv1Lp/iIZ7MDloZ4lTnzwkYOZJ87UkMfiBb+Ak61X?=
 =?us-ascii?Q?Mnitrj829v77e/Hsb2hse+xfOwYgYa4doNYW2LVpqxQjw7dk3000brpDJJXA?=
 =?us-ascii?Q?GIbhGa0jdXF+ZusSvVD6ldiddV/ScjJIp3fZkDL4Nu+ONl+jUiB4o79e+g+K?=
 =?us-ascii?Q?lIXL8zPCZ9gGnVrX6RNvSl/0hieeV2L7J+f/+/i8SU6aC8K2sFPJ4t933APv?=
 =?us-ascii?Q?EMz3oIFwRLc+ycdwTJaxbrVrHF7ZClhnPBXjRYr4/utKV57MIAgE6LoLKcZ4?=
 =?us-ascii?Q?Yk94473SMuLi/IVU1x7HQC5IxMvflWiMAOcNcrUJAVnJExShXnHW5DxKM3Nf?=
 =?us-ascii?Q?zLYOz2p5fdO+XYqbnKt9Cerj0ENu/KMUNumKfkcV5/2BneexRk+P9YYjpFWF?=
 =?us-ascii?Q?Mle6tOKFhcaWS9kNRjzWwZgydDFRXjn6ObqfTSMG5PfdY1vkSPLQKc8ZQ2TC?=
 =?us-ascii?Q?FNba7uhbPqW0ddxn2HqAcr7FR8oUv5BuemEUMUc0G3Y/VJo9c+4aMAdpn3eN?=
 =?us-ascii?Q?CUtM4Hpd0bFb/oHmbFjxI6ZQcC1sn2iBpLoKOfEqEYEasqXvKqrX+Z2LcdUI?=
 =?us-ascii?Q?Z4UQfgftueNkr95B2aJghBu8mnsl7znDxLlOPJA74PfHo0O9qTy4Rc6VhhcS?=
 =?us-ascii?Q?kYeytIIx+lDAEMAhS+3zxYONTr4mFieVnXcUmRWM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1471f802-cb25-456e-dfec-08ddf1df87ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:34:11.6706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONOwadvOguefc/2zPJN2IJ2RnFEciAnFteQBhwdJY5hDpARE0KggIQuya31RIrgmxEOBMlguCvNObjwnIMwxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, September 1, 2025 7:32 AM
>=20
> The iommu_deferred_attach() function invokes __iommu_attach_device()
> while
> not holding the group->mutex, like other __iommu_attach_device() callers.
>=20
> Though there is no pratical bug being triggered so far, it would be bette=
r
> to apply the same locking to this __iommu_attach_device(), since the
> IOMMU
> drivers nowaday are more aware of the group->mutex -- some of them use
> the
> iommu_group_mutex_assert() function that could be potentially in the path
> of an attach_dev callback function invoked by the __iommu_attach_device()=
.
>=20
> The iommu_deferred_attach() will soon need to verify a new flag stored in
> the struct group_device. To iterate the gdev list, the group->mutex shoul=
d
> be held for this matter too.
>=20
> So, grab the mutex to guard __iommu_attach_device() like other callers.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

