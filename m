Return-Path: <linux-pci+bounces-34439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEFB2F091
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4FE1B609F1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C7A2E9ED3;
	Thu, 21 Aug 2025 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMZiarTv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19519F135;
	Thu, 21 Aug 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763633; cv=fail; b=M4LmedCG0UQ618G1n6jiROFFw8CsdNJBD1vtrlLlTcAmdjMRrhUVOdDrvHBzc+M9Ot2d8ZripIv0ttmHzIyTpbvh+xNRbZQoyQsH3BcRUV9JUyFaZ1p3yxNxNckBXAi3jUfPQKjie6YbZafUyyDiyAl0dyreMkAPZszYHR2akj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763633; c=relaxed/simple;
	bh=QenybGyXjte4Pytn1sutOZG2IaiCaq4oXeZ9sqON0KA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QWtFos5TBKFyg4V+eZaIYm+GG51mGH8AZeNIXDPcMRtyt4mecJkO/ojmBCz7CnsKe/sSpDeuvm7TUQiGXhtexmaVborSXado0KttuFQkURUAhIC2V+gjH9LR/epf5mKfjBl+cckNqXDApOHfom7yRMDlQxPW/CIZwPLN14m6qug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMZiarTv; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755763632; x=1787299632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QenybGyXjte4Pytn1sutOZG2IaiCaq4oXeZ9sqON0KA=;
  b=eMZiarTvA/79S3/K3YfAcKYIOC6oArAN2kunRQHS0CL1wELoKVndA1Ks
   iLjfihzlEb5IeK8jQ/zGml0LrnGiPEYMvzazA6RzRFLqv10aprkLNhy32
   O09zaSNqqqaIr0/r5F77Q5hT6QDyQ52M4DYB4WismcUQ63Xcw9BIH/nWX
   1ytpbYh1U7OJwdYQlUOW+7nxEmGSRTigvzQLTgOh4ohw5mUJDsq+yD7lY
   +2Lhmxu6B7VNS7OKbPsRHaPgd7AQU/9gssIuMLhsLg16dw745zh4nenRi
   x5YQkEx7nBywYXW/V6kRcjLlxSAfJEqoLPfHYJuEiGVm7QOYVVUq8i+88
   g==;
X-CSE-ConnectionGUID: rh1C4HWyTze4bQmwS/aelw==
X-CSE-MsgGUID: J1q5Mek1TGi612d0TvLHYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80641179"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="80641179"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:07:11 -0700
X-CSE-ConnectionGUID: H1YCUIO3QIGckE7N76rM4A==
X-CSE-MsgGUID: OHazC6h6SAWMN/TsDBnstw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199328729"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:07:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:07:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 01:07:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.87)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qeo1ir9BkJYoK07C7cdYpY5ArRi2nMWffwc9RPsbqldI6jBt2ZRugOv1KuAhDxGBHucXZ07F2gMzVRUvwPXeGK52lzsYIr4KGUkOMeTeaONvcIQ6FRzq8mFzgl0BMhA8rHDOhcD4DMhHwMylviTyfru0O/cOk5T8Tpo3jYFr6mPXMmIr8W/gdyp/XX0sjjJiiiMRROB1VSHoWnI8VDTBPcIda1bsk8Q3GkovtqGllYLok2Boqz80/s9LVRgngvnxU9ZWPm8pyYJvzT4LDtAZi4+fHELrKk97TK+4/fy8dNYqW7dZVYDIkjzf8RZoYrhmvC1V7GyL1zHLqPYbsDzmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCIvWERQYHBo5NgYoRXZX+DytAN8ayLR8gbNZcMsS4Y=;
 b=G4WoyYI7GoOOhrMYbs1XBNhajPK11sH5JAUk1/NGZfUS1KZqSteO61ChPu6nQBVlRE5gp6N64YB3IMp6X6t95agBlwTtmB6GnDNCUm7ksFslRr2GHmMxSRFzxMA2CPLFKhF5hlz4OOomD/pVt2YVt9H/zgEILDSgnLUyXcp+jy3v48eRG2GpsV5Qvn/w9LJTL1q1rScCMxnwoveiLAu5B7v4Jzii46Em48t6fzgTky01BiOqcdg2DKW7OMZu1c11Ws8DCyE2sdUL30n5JmZ/iuxe2EAna1bJgmlEUQoAi9RlF4AUL0piSvPyNi2ZyVo0ACGETShkSPZlA+70Vry8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8232.namprd11.prod.outlook.com (2603:10b6:8:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:07:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 08:07:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
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
Subject: RE: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Topic: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Index: AQHcCxPRj0zb6W5cHUaGmJqSwKG0krRja68AgACnqICACLm4YA==
Date: Thu, 21 Aug 2025 08:07:01 +0000
Message-ID: <BN9PR11MB5276CCC219B8456DAF289AD78C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB52769ACDFED7201CE282FE3C8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aJ+AP18ucw3Jb6QO@Asurada-Nvidia>
In-Reply-To: <aJ+AP18ucw3Jb6QO@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8232:EE_
x-ms-office365-filtering-correlation-id: 8abb978e-8b82-48b1-3911-08dde089b570
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MxDD9+WanT6eYV4up5pyL61nvC3vp1MRe3YMezWRxUo1ijm8LzCJ8p1ZfPr8?=
 =?us-ascii?Q?9it7Zj/3b80/7dn2Jyd0J/2S4HAqMgWnosI3QHstg0UK7a10KllpFnaOApyC?=
 =?us-ascii?Q?vdZDOYrKjMbWOaAw6OTq5f27/Y9vHTG5TO5NlYu5ydRjpySDOGzMy84PWbQ2?=
 =?us-ascii?Q?cyVTwizkarmgZDpPDn7LBb/+2qahlvpcoaaZ1zHWaf6/lg4FEnRDgeO6j+RE?=
 =?us-ascii?Q?14FeccrwcYdXf+72ECdxu5HKC1bo0jIgGYeeWMOK/BgvfSmFakaUebyVGaTx?=
 =?us-ascii?Q?HE/TcQimgE3CJ2p1sT/p4cM7NwlsYV9hd8pAFvpkSUBItdYOxc2LWEeqmQmx?=
 =?us-ascii?Q?Bzf577xBZGrXCZ1KNUy+q/hLrevAb7v5f+VHXmw9XBU6YBs+EBVO2Gtpab5k?=
 =?us-ascii?Q?1QH+yDSFBWecU8COeTLZ6UVWWChnLLSjHeibIstY4FZteAJb0jf9S7K5dQ6Q?=
 =?us-ascii?Q?wLRDM+3DGkVStb03nRaQvxeSKpu8wOIZc3Fk9PealPz0cLLn99YpQIhjEGXQ?=
 =?us-ascii?Q?ZgM3iP7bZ0cHsvQtGBAQTXa3O3YNmF4hAc4ck/LWwV7QxWw6wLMo5g2HkDW+?=
 =?us-ascii?Q?RZEZCzsSwypI74gxteRpAfednZ9eMx/LxmfI9J6+4thbyrYsB+1A/T5OkTd2?=
 =?us-ascii?Q?2shgASmtZp05KPVlj+becqXNeWlQhbH8A2QjSQL5Ih6OtKIzrf11RGmHCy01?=
 =?us-ascii?Q?pO0Re8FysvQdQCUxWQ7IZtIKGAGJQR4Smpxurc/kdvUCcVgNY2++v0uKM2wo?=
 =?us-ascii?Q?px/euXDjioc6DpNnDe8v1h4uz6063ovaJjCzMjDEltkw1txvgbQgJbguK+dQ?=
 =?us-ascii?Q?+A7CqSgnXW5SO6cFgNpzycZBnW94s5ivqkcUvc08jF0uWTk9uGTAO2GZ8STG?=
 =?us-ascii?Q?0QTbQc12EJEM/VK3d4AiWNH040FTxXi6LRv7RwgcQH2N6p5IvW/JVz3sEys4?=
 =?us-ascii?Q?3cdH78V4+/hh1wW4mT9MK9Sq7I4TkNrlvF4e/+zGlKUg5glxwtPDJyC4uoew?=
 =?us-ascii?Q?4cF9YeWGs9rAL4tICSTu0TX6V+BLw9i0rDlyQxQCtmQeT3G2RcZ3UVzlkzsV?=
 =?us-ascii?Q?6EvhcpmzfJkmpS77c+xrOrWPTH08IrhnV5DuzNq4hZ0IJzlCgeg4Zr2PkDvc?=
 =?us-ascii?Q?svDomFUrQl5+C7VeOWSxGNicn0xjrtiolhxr7ELdAV2avloJNgUtzVwqrLnK?=
 =?us-ascii?Q?r/WM8bx1DF1iazRF9AKit3d4dx4o4Sv0ClrDbTbPrhrhA7i8qGXU0VZ+be4f?=
 =?us-ascii?Q?th5f8CdB6CWZ8Ew9HhPilIKHd8fTQNm4ukUY2f9a0yh072Ac/kKEtYsjvTam?=
 =?us-ascii?Q?rB35BlNq49i9cl9sfcU+OIndhp5YWKnOw8xhjxHlArmp+9ORHEZHPyC4DFeq?=
 =?us-ascii?Q?OznAOto3mrNGiFxYhMuCeUgQ1vEX3CkpsT9MVKzziqsLYnpIsvjv/WneF0Yt?=
 =?us-ascii?Q?kAVBtF0RCU9q1Y6PAoS+dBEOuHL6kfqG/GE+q/X8GBDVfmuVP2tpsw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lW68hgbVu/oYy++9D9VZpUtd1SIOZawQDgfVJpaHCN78Jiv2/Ma90WUQe1L0?=
 =?us-ascii?Q?RtDjucm1wuvKYeIzQs5r23AwY9EMZ9FPituWag/Vrea7WM57uYN/LCHNKan1?=
 =?us-ascii?Q?z+svqMmW+i2tNCKtyyEIqahhtc4GApkqXEpTH9S2mB/5kDvVKkuom4L5LTcU?=
 =?us-ascii?Q?bCJqrDfIT3f7sRkpIwkkBh/c1H+5up0jcRIvtfnQ5ezvl3w6i555LCnPEiJj?=
 =?us-ascii?Q?EmpMEtedNio6W6fsfUIRt8bsSZDckOlHepLW8/jx7UPSuvaUGgA8MnDz2ooi?=
 =?us-ascii?Q?dGYqFhkHzlJWzEPJWtfQqVGOebtiUHY363RqGqHDnBpY7xrEQ8/C3grAdu57?=
 =?us-ascii?Q?cMwvqkBDSV6+KoEuMnei9P+T6fNVeNRVUueHXH5saQB7RLbWF9/3dEFme1M6?=
 =?us-ascii?Q?l1N2vjgA34U6dBsrnujNWOBGvV9FIxGFOIC9rZPAlykLrF4fapdlziEW9FR3?=
 =?us-ascii?Q?3YEJr5GjYawI4UW49mfVgsOhi2hQzW7RKTnnsgE+PkOt1ohzv24u/1RRaCaF?=
 =?us-ascii?Q?Ve1ePlTy7/NiVzKKLwPPFQVkzYY2hLPLO52zKHdYWO1v+Zxth/goXwFEkKcH?=
 =?us-ascii?Q?P+NhaS6SWDuFk3y7z7dM8xaeO4k10x9ZV0sMOO+ueWuh5DzsKJnqIfgKEh83?=
 =?us-ascii?Q?/9wyKknJrrvATrShP+cMYwB3klLiorrK5Z92POuDWHzlW2t2oYxCINp9ELG5?=
 =?us-ascii?Q?G9MwgsNDK01PUKeM0DX79AIRq6DOm2PET0QgicsKGY7Iz0WM289RaIll9Ulg?=
 =?us-ascii?Q?tno61kuinzdfi+KLrPZDSw2AHCgrB2jLt0m2x8JbxFo7jx3I6DBvnMwFoS8o?=
 =?us-ascii?Q?2P5iXQ5gUAXi9Bzfh5eY4G7G7uqNGfb7d3nez83/dK1NAHMtrEaVo2tZBfYw?=
 =?us-ascii?Q?+fwAx4XC2E34i0FWp1Ie7B4piXC6DyQhfo9hGWshNjokE1qx7PiwxTk9odLT?=
 =?us-ascii?Q?AwzAzA/kd2xQwegShUk6WtKLuJN1M5l5W3yhvd34Rj1SCpKB7XyQPRxBWwqn?=
 =?us-ascii?Q?owbd+5b3nemwMmQwLV42W7Wzb/Jupni93lkQEGGsyr+eSiPw6D19/CoG9E/s?=
 =?us-ascii?Q?+dY0TRv2gdQWay/f3d5YzHAhnI04vDXShTdjxI0zut0ZeHirY9f9L8dtr+Qf?=
 =?us-ascii?Q?mPBCBcJtvbS6fXb1ENGtf+QEjoqAazKcHZMGE6HAKhlHnkJpMZtmHA1MbwL/?=
 =?us-ascii?Q?t1Vq/chjMhtkZU6jcDUaF9Og4c6BnZQAOz2lG+J9My1CqSEdXmosPrO3HhKa?=
 =?us-ascii?Q?/shxWVHuIWXs/mpHBLGFqiqLiaP8a/g1ehLPGw+tdpj5iabJqnKmWF4aQgf7?=
 =?us-ascii?Q?M6vri+iJJ7QWpzvlKqco2WyJfojE8gzafSA5iHOqIZMYiGZMm+EX5zoxs2nL?=
 =?us-ascii?Q?dZJGKZxRD92C64ivL/cWYzUj1o6UcnTkMGi9xgX+FNDoMdZ9hxFlO2mz+cvP?=
 =?us-ascii?Q?lOzc9WNyfuw//4oxRvUNDRoSsZgJFpR3piLZ5sInhRaxoC5ydLxx9/mrG9y7?=
 =?us-ascii?Q?w715Pt2OeBz6HTKtHrYQ80g5exVP1zEcAamZP2scIi9hKASW6YSLFOabmPAP?=
 =?us-ascii?Q?ze+DIEFEhhgvtiahscRdYuXGwFzaA4EvFVVymxp5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abb978e-8b82-48b1-3911-08dde089b570
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 08:07:01.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9OHLQ/JMbr+Bu1cpyALg37LMdbefF82JJB1MjxPQ5qXCXFsdXW60BtFKs4cEgi8ml/tPKcl6OV3VFYZ0cVMDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8232
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, August 16, 2025 2:45 AM
>=20
> On Fri, Aug 15, 2025 at 08:55:28AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Tuesday, August 12, 2025 6:59 AM
> > > So, iommu_get_domain_for_dev() should check the gdev flag and return
> the
> > > blocked domain if the flag is set. But the caller of this API could h=
old
> > > the group->mutex already or not, making it difficult to add the lock.
> > >
> > > Introduce a new iommu_get_domain_for_dev_locked() helper to be used
> by
> > > those drivers in a context that is already under the protection of th=
e
> > > group->mutex, e.g. those attach_dev callback functions. And roll out =
the
> > > new helper to all the existing IOMMU drivers.
> >
> > iommu_get_domain_for_dev() is also called outside of attach_dev
> > callback functions, e.g. malidp_get_pgsize_bitmap(). and the returned
> > info according to the attached domain might be saved in static
> > structures, e.g.:
> >
> > 	ms->mmu_prefetch_pgsize =3D malidp_get_pgsize_bitmap(mp);
> >
> > would that cause weird issues when blocking domain is returned
> > though one may not expect reset to happen at that point?
>=20
> We aren't changing the iommu_get_domain_for_dev(). So, it should
> be used exclusively for functions that are outside group->mutex,
> like this one, i.e. they should still get the group->domain v.s.
> the blocked domain.
>=20

Usually the difference between func() and func_locked() is only about
whether the caller holds a lock. If they mean to return different
domains, may need better naming (though I don't have a good option
now)...

