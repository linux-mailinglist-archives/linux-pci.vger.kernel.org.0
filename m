Return-Path: <linux-pci+bounces-35998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431ACB54847
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32733B8A14
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5E7285C9E;
	Fri, 12 Sep 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0KyHPnz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE9281358;
	Fri, 12 Sep 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670561; cv=fail; b=VTTrbUGgj2egMg0u/OSoWVN5A+Km0F2SA3UNnepSDH/oTr38wsqgF7wPIlXBdeNG0oXuxVlgAyfm2PWIjzApXbIcM7Vzq0IIfKG5A2yQvO6IL53JDCvuEDpBL5OznZAuY/ONBP4Qwjr02jSgtVPvYnl85l5ee5kuiDnyC41ptcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670561; c=relaxed/simple;
	bh=HH59XwzLugIVfZTSarsP94cLPe35Ip8wQZP+K4wtHlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIjv+Wh3qeZAwuSi5jxb7/sDyq1056KPbaUbsGp4Isq2kdMoR+/4ZJsCVZA683gT2QXTimwbMtmdLAQXhrGBndsitXDgzMvJ3fjRgZvB+ZFmx+Y/uka+QKVOd3ZHjDtac2RJUbD7j4dkhkWNlDz3B3U+BGvsOHdQq9c9gNgryAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0KyHPnz; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757670560; x=1789206560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HH59XwzLugIVfZTSarsP94cLPe35Ip8wQZP+K4wtHlo=;
  b=g0KyHPnzo1HrdLvBzuzABStbg3ZaOsN+K8TNtPkNvenw0omF4LR7A3uY
   NKpHFVFNbM6Z067w9MFQxxxWmrFgdAD9gG/xgJS4iZ2/TYeEGXe2+ixnQ
   ThgJuaIAo4DASoJGfOYj7/bjQs+wLLHCIRS6Dte9hrtO5xUiQbI30KXaW
   8Ay27URJPKzQUtOSAg3VsOESCc54y05g9UI78gEZJfmJVuyI5O/EY1TKK
   GsdGnZr70k+1ePA3dnnDahzXuM1t3IDRMT/NSpnQ3Q62wbThqEso6rzW1
   ym5gOHSNocjcSZEQFiHVQ0qIicj7PSv8m8RmJD7XZ+A6vWmTnq8Cu+dNw
   Q==;
X-CSE-ConnectionGUID: gEBPMVecQT2iPcha4yev0Q==
X-CSE-MsgGUID: HV2ZanI2ROSddN/53yVgsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="63837381"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="63837381"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:49:18 -0700
X-CSE-ConnectionGUID: PA1izaW7Sz2+xoM5EC7IvQ==
X-CSE-MsgGUID: +DUnE2pMQi231Ngtwujq8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="174708484"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:49:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:49:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 02:49:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:49:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLjTJDt1IQbSZU+pz9/dugMiGeRBuvCP2EEbjtnUEuI6DdkEzmHCSrSb9q6lg1CgSoh8yQ70IuHJ5PNJt0zBEENsWqnc++hLVQvkCau4OBoZXkb6c7DRPZ1RfrxjQHht8tA2pWn1NuVfRYXDzjDZAkL11Usla9LKew8h4jDFt3Qi3fuPTuTqC25Upgb/0IwhhUW/QXDbv6XCQhDZnmX4m9StRDgXo3hR8ZKQnU9cEZFUx9Ugf4O46dfwI5clZv6+aG2/TEW/gRNQlW0Mdthd+dtwtT6/SEE0QvbYtwPycdGKHQPcn/+Bl4+dN7Wm4nwUCTAz3CgxwfudqY8iXZ1D7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3LbucmPw5s335YWhG8TSYaXlBUClMiqHk9+bvDVNf8=;
 b=Ct3xOveArlx3NbYTF/WOOk1DGVPzh6UgMFUFWX/Tc79DpZSEe7MdXQcCqyK2ipEfCgRytoZHY/4K5e8cSstlJl73QoOq4X8dG5V5m1N4gUuHafa3kShAOsgesXbTUmiVG1CUyb+F6DVA8MQd+d/09FdhaVGcllpq/tkZoWA/S8pXAm8Ny1wio9bcrWZEj0soijvkhDolblb7KPPwA1eZ8UthL0UkYxnGwj9dc7BMKpiWmSPnZD8vVrTKz2+qBtmr4FsfaOKvouab1fkB6WMDTjvSnCw9K5awRGt/ajcecIOnxsi7nDDf8gkSaeuKV67d6+VY8F46AzVICXFZVYsixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:49:13 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:49:13 +0000
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
Subject: RE: [PATCH v4 6/7] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
Thread-Topic: [PATCH v4 6/7] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
Thread-Index: AQHcGs+kmRd6vX2VUUSIS9z2k1vHZLSPW/CA
Date: Fri, 12 Sep 2025 09:49:13 +0000
Message-ID: <BL1PR11MB5271BE949150D4C2B5EC589A8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <0f6021b500c74db33af8118210dd7a2b2fd31b3c.1756682135.git.nicolinc@nvidia.com>
In-Reply-To: <0f6021b500c74db33af8118210dd7a2b2fd31b3c.1756682135.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SN7PR11MB7420:EE_
x-ms-office365-filtering-correlation-id: 32f8f0bd-455d-4c65-7bf6-08ddf1e1a17b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?E+8XyKohKLugtT08kfmvO+uq2+uEk7DeBFJPEO43Aybt7UfO4tta36u9J3xe?=
 =?us-ascii?Q?fjD/xCWTm8489E++JMicVlxgvL5Q9ZXAXLB6zHhi7bJ1xv2UjWJ1tyOmda3l?=
 =?us-ascii?Q?trt7cJ88r42u5ahGWLPp3OhvqsDCBaqRKF15sO4ZRqhZZFX5iagHY/6qIkS3?=
 =?us-ascii?Q?9nZKIej+FXNmGvZ/+XZYlRsn93rOtd1C757ecoauWCN3LbP5+VPBX2woO5JU?=
 =?us-ascii?Q?xbCJ9QJSCW56dZ/VpIUA1Lc4nC8bEQUNA1VpG7+2qmV6MVXFAf6nLugsFJex?=
 =?us-ascii?Q?7Z978K+ZJwBRV1ojZkXMOK4UeCgjCUTAEklC6WcUlsg9DP6hbc/jguiN/+rM?=
 =?us-ascii?Q?SlAy+QJSmzNI39+VDNVm5uMDMIlVeL2gs2Dvl3Gk7ZjXIMiaR8jDNzmDwLvw?=
 =?us-ascii?Q?r7xv3qgw7BMS3wA4+dSPVIcQgO2nHrZgzkLljevgFwvbDefnt2u9sY0e4oPC?=
 =?us-ascii?Q?umAxNFoXOMSswTC6fWXOpzdnyZuRy6FjDCR2XJLsBE6FExioeATR+zFB+GML?=
 =?us-ascii?Q?yIObzuKY8/prcn1kLnbl5IJEZ+2tYbLH6lY0k+k+w5W/rIbTWiQX/waP1Xhj?=
 =?us-ascii?Q?LhAS/dUbIaoEynw1g86WdWalTa2u6sjrrZVQioO64c3qDGFzDg8t3pGsqZDb?=
 =?us-ascii?Q?uxYQJBvEBUjg5zMIDQrKwlex/sn+DTP/3hJ65JKcj9w3PydKxW251RV0BgD/?=
 =?us-ascii?Q?b9Bkj8RR4MpJAfz00szcoTTarZ5gqR5TGq6NpBw8xCv0I67MdH+1V48LiDVI?=
 =?us-ascii?Q?yigcd+U0ScryOvI5p5WCQi1DIUwvE6bqk9bKaaeikoLuTF6A0kbX0ijQqbNx?=
 =?us-ascii?Q?pIRl4sahQcKjbt9C83YSGngbSmf81QR7re+0a5wFcENvEaBTmQn3VqkFlOb4?=
 =?us-ascii?Q?dtkzzeiGVYU1aib0Qig3LdzR/CvH4/hk5Lw+sqar1TgPHxnri5Dki8sLbvAP?=
 =?us-ascii?Q?IzPi4ncdeRrMlZthsfJnvzcPtiH13XjATGYO48Erz9S3vIF/lSYJWQsqLDWI?=
 =?us-ascii?Q?hS0YzkAS951exYTkq4KRrUCwqbC7O87Rxoax925vV3R/+GQ134QaIwpZSds9?=
 =?us-ascii?Q?0Dx4foGEKBm5Hh7WkaH9BdXyQbcqkJlyOUHprXBucuhlznX8Zp8kd9DuoPZJ?=
 =?us-ascii?Q?mciVj+fe2vSVYU4OuIVklo69Kc7q/6lrSCOe3fAYYfM9xnY+YRpwfu+BA+KK?=
 =?us-ascii?Q?M1UxpPD1B0VdUXmJKQXyhpI2dmbSiv+Udl2oMPGjhZBJ/UPN8D6yulmoYMov?=
 =?us-ascii?Q?LOn11nSv8L0Ub/4O62vClDTrJIQhnLQQI3GZfXa0SP4+8Frozk9CrGDMPSus?=
 =?us-ascii?Q?sXS3vnN3RhdFq+KkxMgiiovbwJW6xGfqUqSb6+K1AXPB9G7UZromOMg6VhmC?=
 =?us-ascii?Q?fSTok7Tk1F5lGYxP/gaON6uQIiaCYfZtvLD6tGgQWX9ZjWvLKMfksTVb9F2j?=
 =?us-ascii?Q?tNqY9ZszOvI2Wcr4aEx1627HBCw8IqyGOfsWxWtZZEK95mvrahWdSA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eHeuMf5NaFH3LfOEi0E9oEW/DuUNhxhZaWHXTj4xSjpUWDJ5FoHZ+2Ghdskz?=
 =?us-ascii?Q?VPXhcvChVhPiCnO7UjacbwIgN8C9jgQ7kXGe3C9wZvH7gs0O2JmjllXML+si?=
 =?us-ascii?Q?vaGQGv6TyDEgFATpM7wht6IX8NCkJ9ju+A+gcveMWXPPMuMPuuC4KPR92/83?=
 =?us-ascii?Q?98ZitHARUwwiuBQpbPR7+mLx1/g8tz2kPHv3+dBfNpc4js209YikVpe7sHan?=
 =?us-ascii?Q?u3v6VdL4Un6/LNZ3UJA6asMAzSa365/X5i5167S9KWaVFQr3ha+iAdJTmCII?=
 =?us-ascii?Q?UjSfwkWT/t5VTHGipj3csNssn+k4hfpYaYjCh4q+sw5PrLq+sNykPB6ptk1c?=
 =?us-ascii?Q?gl+WN+eynA+oi/HoHSQJOF6ulQqQanSduQNk5pYV2qf1IkmnlixWeM85oTAj?=
 =?us-ascii?Q?5jDBz9zBPx/FndtpiLQoyAXJ/u43ZlrQ94gLVT3gYdXDCBiJ5WmRVqIxe91u?=
 =?us-ascii?Q?9W9jR+GtvGrRluSzIBGQpsnSG7QlUH+JKdazTiE/WRSrWHmTzErQqmYDd2D8?=
 =?us-ascii?Q?+tu454sCqHPYNMcDjCAYYeF9cnvjPJk1Fjm1GcOwhV5ZF52cgTkr91lDGRah?=
 =?us-ascii?Q?tQocWoWbpoNdk3sKuHqFhYstGtIQS1jzWcHGN0afYyjNTIr9lKib53fe4YYS?=
 =?us-ascii?Q?Y1pAoZGc0c1XC8pZcU/Ekcjlb4PlxN1a0bJ7qtig2O0bKwwtT9JWbXvVOzqG?=
 =?us-ascii?Q?fPMw/MhKWrznKSfOpMALyXEiLsWauHCc7W5jV6vwLvW3GrBTqleJNJ3Ibd9P?=
 =?us-ascii?Q?zZPgv0EGLIsHZa6sdS821qGcOX76z14qzbn/yLl2Xw3ywcoWrFzAPCiluFOU?=
 =?us-ascii?Q?g+GblwShmPLsamPRL6TwBiT0CDnGZ5y6j2bPNohcZ1ScbqwerUw4A1i54I34?=
 =?us-ascii?Q?dX0xcO5t73O8aqqk4VVQspZMzi8DJhTL4x1mYd6I355lnco2iANQmDFX/6kn?=
 =?us-ascii?Q?KbIgZOL6Kl4Rf6iDbfPXiXd8WGAf9mZ9I7KwNLmMNpSY7E6THrANeCtyum11?=
 =?us-ascii?Q?vSVIPBbsCCTdewdl29Ys5q1nW4BgG6nN/nACjbu/kLnj/nZunt7K4qwEscx5?=
 =?us-ascii?Q?tY2TAOaa6M+mFGI+y7J72s7eGpIENCy9xgFXv8F+tJn6VRxZYbyie2Z8Jp/l?=
 =?us-ascii?Q?tL7r5bhboeV2sPqwsPqKrpe6IDYo7jAP05XK5AG7W/p2tnW9H0tB6da4DHTj?=
 =?us-ascii?Q?8paZ/rCS9AN87cbDUrGV6ldmmRTsY3qaJeer+c/AsAvoXL9fTwafIGkebPzQ?=
 =?us-ascii?Q?pKfEYDBMhVx3UNJ2Lh1lY6B1DECiV1o0A8vFULJLF7pks9muPT2mUL3QdwZB?=
 =?us-ascii?Q?VI0t5fDSvDr5gF6GYyDUucl6w3L/u4/K5eed6pifSvEtAlRKmkIUBVkz4GFv?=
 =?us-ascii?Q?SIQQW1Z356eIk4BcexbPbFeSQkN4cuPCPpeREX7YfBXy1I5szpz7WYBqc6PL?=
 =?us-ascii?Q?jLyjQRFl11rw0rJavrRT+QVBqeK/Q6KebTBA5qmmyXrN3qH+IJQ02oYpfYTW?=
 =?us-ascii?Q?2y+ygYbfnfgiPrTSd/cXa+ixoR/4IR3uxr79r4Bwap7b47kiOPvsOi1/hNs7?=
 =?us-ascii?Q?1DaDgwYkRGj4DSEzYJKzmse0UZ6akw3EYcKodiYZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f8f0bd-455d-4c65-7bf6-08ddf1e1a17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:49:13.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoK6vFC2RGvJGSF7IMaan6JE48+FCcW7iODz/G3gy+8hCjQKyhNky+MKbK6/I2c5sD4Q+je0QZO6lnD6Uq382Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, September 1, 2025 7:32 AM
>=20
> PCIe permits a device to ignore ATS invalidation TLPs, while processing a
> reset. This creates a problem visible to the OS where an ATS invalidation
> command will time out. E.g. an SVA domain will have no coordination with =
a
> reset event and can racily issue ATS invalidations to a resetting device.
>=20
> The OS should do something to mitigate this as we do not want production
> systems to be reporting critical ATS failures, especially in a hypervisor
> environment. Broadly, OS could arrange to ignore the timeouts, block page
> table mutations to prevent invalidations, or disable and block ATS.
>=20
> The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable
> and
> block ATS before initiating a Function Level Reset. It also mentions that
> other reset methods could have the same vulnerability as well.
>=20
> Provide a callback from the PCI subsystem that will enclose the reset and
> have the iommu core temporarily change all the attached domain to
> BLOCKED.
> After attaching a BLOCKED domain, IOMMU hardware would fence any
> incoming
> ATS queries. And IOMMU drivers should also synchronously stop issuing new
> ATS invalidations and wait for all ATS invalidations to complete. This ca=
n
> avoid any ATS invaliation timeouts.
>=20
> However, if there is a domain attachment/replacement happening during an
> ongoing reset, ATS routines may be re-activated between the two function
> calls. So, introduce a new pending_reset flag in group_device, and reject
> any concurrent attach_dev/set_dev_pasid call during a reset for a concern
> of compatibility failure.
>=20
> There are two corner cases that won't work:
> 1. Alias devices that share the same RID
>    Blocking one device also blocks the other alias devices that might not
>    want a reset. Given that it's very rare for an alias device to support
>    ATS, simply skip the blocking routine.

it also applies to the devices in the same iommu group. While one device
is being reset, all other devices in the group cannot change the domain.=20
This needs to be documented in the attach uAPI.

>=20
> 2. SRIOV devices that its PF is resetting while its VF isn't.
>    Both PF and VF should block RID and PASIDs. But, since VF is not aware
>    of the reset, it is difficult to block it and reject concurrent attach
>    calls, because it's not logically reasonable to reject a VF attachment
>    due to a resetting PF unless the VF is resetting too. To address this,
>    we won't be able to reject any concurrent attachment as simple as this
>    patch does; instead we will need two new compatibility testing ops for
>    attach_dev/set_dev_pasid to allowing caching a compatible attach. This
>    itself, however, would be a big series. So, for now, skip the blocking
>    routine for PF devices, and leave a note.
>=20

given it impacts uAPI:

  - now attach/replace can be done anytime
  - with this series attach/replace is rejected when a device is being rese=
t
  - later with compat testing ops attach/replace can be done again at
    any time

we should be cautious here, especially if this series goes into 6.18 (likel=
y
the next LTS version) the interim behavior change may last long. yes
we discussed that no know usage would want to do attach/replace
while a device is being reset, but I wonder whether we should instead=20
wait for a full solution to avoid unnecessary uAPI change back-and-forth...

Thanks
Kevin

