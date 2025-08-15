Return-Path: <linux-pci+bounces-34098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F05B27AF6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 10:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D55C5C5FAD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019C246798;
	Fri, 15 Aug 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImXPYrlU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62810E0;
	Fri, 15 Aug 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246551; cv=fail; b=uiVbBwidj+G+nXlYvDDg76jbrCB0dbbBa6XLrUtAqwj4YPQQ8IS41Rni2pw3qNTZAy3bt/ThlX0SNbriaX2rLoFjPjJ5jmqOBXm7kGNUuPd68XlKWJQYJAeX330y8paE0QW5nsBaCasuMuum9Z209h6ocM62Zs1ZJz26uhG/wmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246551; c=relaxed/simple;
	bh=+2ryWvnpPHtaLQi3NvCI+F/O39G+5tNez7owrfTsv78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myOeY0VTJGwhYncwMpZPmYcaTkxQsi3JPFCK585KomvBE3MQ/7RJdbio/CHwldTKQXzwCayoOCybu8CYtBUiDzW0R7MtD44xJj3R/HvBkFLrkW9OTQE/VToSXU8xJqnJg/X9y3H/ijS+qPKf9hEe0fgtEbt8mu1rjuYLHIzQKLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImXPYrlU; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755246550; x=1786782550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+2ryWvnpPHtaLQi3NvCI+F/O39G+5tNez7owrfTsv78=;
  b=ImXPYrlUnRCJRY4NMkPp+erJmHBl/klsdnISH7s/dBy9zEAKOxdFQTkv
   2mffsRMmbHVLfh5EC3DtvkrgrOr4Bko2VewRVgKhQZ1q8QWVmbfzcTzYr
   p4xDjnFAQ5nfDAFj/D3J3n8tvXPJLUDFP8eYZdUCs4zUIa3K5Y8Hm7VRU
   WSZ4MC94ob8sr+eNwT6jMVxnrx+ywumbdhoPmtuN/xWKpYrLAQD8zwTl2
   RBW0f5WacDdhGDfglj4bxbwnIUlXRlxvEUusR02vTtT5rzrUsGFKXTr92
   8U6jd1x99CwVp/NTs8aaFGKJewZ0Sk3c32ZBfLnSGQCW3YBB6SzBuhwYu
   A==;
X-CSE-ConnectionGUID: Y+ZenGesQeWcMVSyHJItJw==
X-CSE-MsgGUID: UfCsj4oJSxOL2htgEhTAfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57720560"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57720560"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:29:09 -0700
X-CSE-ConnectionGUID: ptfm7YqJSomWer9SbOEaig==
X-CSE-MsgGUID: 384GYf+hQwqVGHC7cAirJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="172305887"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:29:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 01:29:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 01:29:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.82)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 01:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP/njBRQhlvEnbRVGOnPT72Wki/NHnq+C/D8ypiG6kAcqi+nJqjT9U/tqp1+uElYCQ4g0BVdE9rbkOuiEKmE0pN8JqrqMsd1e/zQ1sHEM0XBp/fMqxO4MEF5KxewnTAsfytAA0cDbhwFfj+0dax+8D+CoilQ24R5yPfsx4JEDtQTjYuJsF4JHgWOZU0AGMw8BDibp4wJJrg5cqSrxwiTswjNkoJmZFU2f/9K9JLvsqxQdQNdOmiNP/OlqXOGEtp2Ikej8CZfNauwzY3asr5ZFWm+n4VvV16Reo43GaCzznqGj0HA2x4zXiY3JhwLid77J0mZab66RRbxISZiivcj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2ryWvnpPHtaLQi3NvCI+F/O39G+5tNez7owrfTsv78=;
 b=Y+YCavSX/lfVGGFqxrAIe8seG7bI85OY0LA2gUCBz5Q2VToV17gcWUGzuPy5gkT/xXUKskhr0fBFDrB8cUp3hI4S30oSCGSSuDcvSha1uvoihkvdJ4irRIfyq1u5SnS2qLyLGUN/8aMRdZqGDqj2Vn82Od44QNC59DBbvf+JeQWA2kdaK7qoPJ/VeOVE3svO0euy9XAcV0oLUax1yzDoK6jXkKWYHE8/5T7whz45anws4DuSoXlL9A9K2L6HOjPvccGkdAJXHxLInNn3HDz7fFCMefmIzN15/rtaO9C9FlQ7TviGcxb2vLcf4qXcbte2rUp5u3s9Aw4PPPoHaWI33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 08:29:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:29:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "yong.wu@mediatek.com"
	<yong.wu@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
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
Subject: RE: [PATCH v3 2/5] iommu: Pass in gdev to __iommu_device_set_domain
Thread-Topic: [PATCH v3 2/5] iommu: Pass in gdev to __iommu_device_set_domain
Thread-Index: AQHcCxPQvqjgRKFT5U6u66Wlt4r+YrRjZvxg
Date: Fri, 15 Aug 2025 08:29:00 +0000
Message-ID: <BN9PR11MB52764B5E98E099651EE4A7318C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <b07a15780fd5a8c688f1ae6285438a112a9b9478.1754952762.git.nicolinc@nvidia.com>
In-Reply-To: <b07a15780fd5a8c688f1ae6285438a112a9b9478.1754952762.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6246:EE_
x-ms-office365-filtering-correlation-id: b3340bdb-cc19-4fe4-39b1-08dddbd5c94c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JsFPQ3B3GegG17eEJ9kyYi79BhCwHodsgvnnRIDVkaHiT8lkoHTyBrs/7mLS?=
 =?us-ascii?Q?unU5nEENmh8eFHi2tUZEXlOoel4PcRDJH3juaGHwco7CqssqzP8uCuV1VFzu?=
 =?us-ascii?Q?DqeQ2vBH8DHfAXtEkMvSIGkWc5pUU7rxstyEZWEZwUh+YDmDGbteLpjSuAUK?=
 =?us-ascii?Q?OefQcEYZ5TRiE9Nn3EKgtK5A+yhjtw0QQ2Fna89rw2oTuj/WfCClVwTZGU4n?=
 =?us-ascii?Q?nlHxc2Qkl0/eNXJFclfGUNHnljOGthyjuZZ0RtVgxVhLf2y/8XarTYicincm?=
 =?us-ascii?Q?stUj2S4GdqQjjUOS3qgjrV60t2mmMMiNalQuhYQoPavqboiPFyPkUgCBPxJE?=
 =?us-ascii?Q?mOKvBFCC9dcV8TluPz+6WKexkYGDDbSRwN7ZvNwnyHTfCsGI1BgIa+VDhTSz?=
 =?us-ascii?Q?ejsCE8xX3kE1OaZruYk6UpMPwlSIjCyVgzt6cfNpVWR1A8HHrkZvjwFZvTqk?=
 =?us-ascii?Q?pBd95p6rgJE9h6HTm0+0pThwc+r8QPYJtEnrqKwXO1jOUPSvZ8sB7D+sPYMH?=
 =?us-ascii?Q?Ov6ZNBjUY6Apy6+i1IggAoCFHO72YHOF1MtSZ0kW/Nyk2kHTBbMBg8lSnqlp?=
 =?us-ascii?Q?YyEGVyKXF5nSfuKXsBmrK1iAtKNNkCulGnA5hwajL9cMMqNYU2nv/v06bTmk?=
 =?us-ascii?Q?xeLWAb+UAkTRHcwQ5ZmodwTEeoFVSraOPpw4H70etsFXS0g5YzNIBbgs/wGV?=
 =?us-ascii?Q?n1hSs0q93ak4v3e7d2hqoq/RKBl1sBwrw2PK8ttx6olQRtY3eo5Q5d+Lm11E?=
 =?us-ascii?Q?18i1D4K7lbK/+eLDHqJrPZYzlpsHzulYLrUdEnySTzeEh8g+xJb80DhcQpLi?=
 =?us-ascii?Q?W/vlQhdGsuOb7b5KI9SklN2SP0H4UdLxlBJK/KbW6CrDnGWa34fKx6G6aA+L?=
 =?us-ascii?Q?wVRjaINmTYmR+xoqQmmHMm2mONo0NsEUOtpVE3Hyv84+B8S9YN7csPlyt3Bh?=
 =?us-ascii?Q?cnuPvqRAyAvNIVBEsYYpAqPrU65K5yprJPFHR1t6D1x2VmymkKzlHqwsa+qv?=
 =?us-ascii?Q?KQKlY1sxn0c9FIUvphF6bQR0ahAsn3crVCkVL06qpVRupxBDSG4kvb9exagn?=
 =?us-ascii?Q?isZhczjBBd/uMXGCaL/37NvJ+9KGPVyXjzVzm+fajyBUC+YdnbGQUclN6zi0?=
 =?us-ascii?Q?l5AlTPJ+GSIqJrk5mokAMEaYoOBgLeTBMli8CAfK7x5OSAF2IcmaESXyVe9P?=
 =?us-ascii?Q?VzPvqsWnfosyVKWomnxA4RYRuNwmrUzUSxlK6dPiQiBBOhvzWFUiHqXMMDKC?=
 =?us-ascii?Q?JAhczSyDhpN85r3xZFGxQ2KLvFiMlmBwLT6RFrVT65yZHDMcAI/erZNiaWyk?=
 =?us-ascii?Q?h8dnOgc8rRwKxLOtC/dWqMjyWNxQSEih4+sDecfrzKDF4VNCdrsI2w8sWgzk?=
 =?us-ascii?Q?Xg7Qmnwlby+d8TYpxxTzSjeHSD7g2N0gfPsCWM0si5X+eiG0Z7M59EMWyntD?=
 =?us-ascii?Q?C1J2F8ZyM0H0TclM/+FZX9AO9gLzCneEjQFIhr2+VFhcrA19mH8sLA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rb9r3Frd50b0CZfPLlTLiTZMndlCxS7RlAp2sXVzTa8g/dQ8DYWnUnmc2Y4Q?=
 =?us-ascii?Q?Rvf6Oa8e1rrk34cewnKaZ+WxDTS7l9MDzXfPwXRnMxTAfVuSAe5iQ0FkE/ua?=
 =?us-ascii?Q?NPmmpr5BwNM+V3QRgoForvSBxdUVe5XsbSZAaT1TYM1Nr5J+o67Q2QuI/Oig?=
 =?us-ascii?Q?/JggsP9Di8wRcnr/HiSkW62OnqVhC4YVprJYwWHKkDfFiUFXWF0wjkjGmxOa?=
 =?us-ascii?Q?Q9ObHLOBHGT3902Wr1yIQgQPol6fh6xHfSQ6KaK9VVuQ3MAJ2M+jveQMDY1C?=
 =?us-ascii?Q?RZG9fcE6CZEObk7b7R7ytf663z4qvnSGDuwUZlOJ87JKpCz/1d+HWxI5d0PO?=
 =?us-ascii?Q?NtF75lCvneDUhj2oeWXFZR3vgjCQboBec0mZiKZQsae9qVwXcaF6jN2Kp0vF?=
 =?us-ascii?Q?vn/51+eZZZs5ZDGXLKjUxX0qXB4Pp7hyvhiYr/xoUinHLA1CJX/1p3/z8WqT?=
 =?us-ascii?Q?DpVgt44wSkb0Wy46KRsR93wfKzkAXsF0+SZudTxpEsBRtRktA94qsw4cqu/P?=
 =?us-ascii?Q?6t88F9/lDGbo3I3nWN3dRhmPUdh6i4WELfzSTAm7pExSdprVlYXhZ6+yzUXV?=
 =?us-ascii?Q?d/S8IFehM1d+TlkRAAA2RvQdQstPjK6+CLrfKb2Qfuh005Q7q2FSPh8Wto7c?=
 =?us-ascii?Q?UkdzYtkf8BH2VNV4F4qBNfnx9qjDswxgjRkR+T3ECodDAL4Ey4Q9rNhl9GCC?=
 =?us-ascii?Q?Wv2+FvQ900lT+BQke5sAsumFojAC4jqNYnowqwnZua0SuzAkylvrTYI10uFq?=
 =?us-ascii?Q?uHeM5gSkNlzgu8caGjekFXrhYLzUsh7fhrROqJveMsOy2cChp+d66jir4UBt?=
 =?us-ascii?Q?aN40ZS05ozKndqLM9es+5MahxqvdrOBTYjA4h024OJXlbNpZgb8qrcE2mSQO?=
 =?us-ascii?Q?0LcHrK14rq+PRZiQ9IvgLceB199Cjd4GRdI0+IeJ8qLeWCbTJQLZj2QP41k+?=
 =?us-ascii?Q?U/ShAJnwoZ2dZ+TS3lKmR65GiMM+X/7dFwBOcew9EnZkIMitiGkA8NThQkzi?=
 =?us-ascii?Q?kKMRJkjmesVctnOOXpuoW5pbTNozieN6okHn8CcoPtl6X0H5+rYytYFBrHeL?=
 =?us-ascii?Q?VjClBjb4yhrFqPZ/e3Ljli8PVLi9jdSVXas/EWOj1EdgGonRk4kdm1YaSSpP?=
 =?us-ascii?Q?s4UbVssO0HW5k9Mo7T2D3uOoy+0f8Yy1jXRL73tpQ2VCWsmFK1YTVoykaJm5?=
 =?us-ascii?Q?n9XSZ0c2YLczI/UuvZK1aHNszJEApHJ34FEqbYEkyNSJInieGrw5wHGOmGgD?=
 =?us-ascii?Q?D9oktyl20T0af5W5W2v3yRA1+NEJf+BIUoCpEEIQK9GQ3o6V1leIPruaIWKt?=
 =?us-ascii?Q?1XICtMQshEbsJfhMe/KoMn4gtPM/v9z5h/T+Nv0yp6BGY5829HARptXg5Q95?=
 =?us-ascii?Q?okYg01vcuJH2LmncXPUoE0AH+N1VAmMkzydBpNU3geJTOy+GNyVHgK/eND8d?=
 =?us-ascii?Q?DAT69fSIsXFJvsuG4ULfsGlhX0PCKmPq87cuWQeZL2DuSJAha0zXCz0O6ZwS?=
 =?us-ascii?Q?9PoM3OguFzNy9KqFKLV9V3xWNpKsdU5FTFlLPF4JaMbFuNV1hq2RUJcUAiaI?=
 =?us-ascii?Q?TN0B2PIztXxTZrCnSGaHWSINoUdEXUODrEefN7vH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3340bdb-cc19-4fe4-39b1-08dddbd5c94c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 08:29:00.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAmiASOGcFKBshrZheoCrIwG95OT/I/BpS4sEyLKD0rGmaKpaWphHYrDXvjmrdYdaUe8ZAu2Ao2ipEx0HiSzdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, August 12, 2025 6:59 AM
>=20
> The device under the reset will be attached to a blocked domain, while no=
t
> updating the group->domain pointer. So there needs to be a per-device fla=
g
> to indicate the reset state, for other iommu core functions to check so a=
s
> not to shift the attached domain during the reset state.
>=20
> The regular device pointer can't store any private any private iommu flag=
.
> So, the flag has to be in the gdev structure.

duplicated "any private"

>=20
> Pass in the gdev pointer instead to the functions that will check that pe=
r
> device flag.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

