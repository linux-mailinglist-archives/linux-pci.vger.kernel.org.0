Return-Path: <linux-pci+bounces-34547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08755B3145D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 11:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9A01CC2247
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300842F5320;
	Fri, 22 Aug 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ceq+XVXc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381312882CA;
	Fri, 22 Aug 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855939; cv=fail; b=ltl2xp39pAwYvNWH5uSP35J9Ey7pZl+j/OgEi1q/PJ6bAzdHRUK0zAYsxckuTvrHs8eMNBfhB7fDUL0gzCiDzkYsnrwrsd+XUXOZ3J+q3KTaD6ABSZn/7LGjg2vOK+7NCbGvW/4gfvJvQVHhLlj2AiwME0LHZMtQ/h0E9G6Rnq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855939; c=relaxed/simple;
	bh=Mxv+f2AZIagljhUT0zt8U7K6yBDZCw8jx6zi3wX2kbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cxS5YoPstDNKjw9p8z+mOp2sXDlogtzRXDiIVVart2rQOco8UZiNJskl80uJZWWee0ZA6GHCJofrw3mlsjgDF9e5Y2KMOCqLreTDEC/W7ugM6wXGVt3HAILN0C0cd0EgGJtr06gCggatqPb8WtYHyD3WZp6XT+tTkd2o+v+9qdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ceq+XVXc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755855938; x=1787391938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mxv+f2AZIagljhUT0zt8U7K6yBDZCw8jx6zi3wX2kbM=;
  b=Ceq+XVXcH1DN2G6AGNf94CxpAUBzGYyyjn+ZX88DAGE8VpEVCYAAAaGR
   AoM6dXXa88hgvRawU6IRGu2Kz+bUUlv6S3h55ZDGXhZX84idodJQndSum
   ZYFQOgW4UfZmhwvhee7icx/TpOIYsVbG7mO1yd+zitHYSPnOjQHMeXdCd
   ZTNtYjIwKPX+NYbs3Ojo6+1tI/NvzrIWvYoBoak5Yx05w4P/y4zouBk0+
   D4fsHZgnXmmnEPG2mukpLp278xAEncGF+7ZG1TQXdzaZHVQLVb0C6voN6
   bAuZL6T3wPFNu84ZLuva8DKOAkCvRS3n/1LdbWFyOYPVW1SCaw67TsdP5
   Q==;
X-CSE-ConnectionGUID: 3vCP1g3XRB+gKF17Uis5Aw==
X-CSE-MsgGUID: njeuxzGpSYmnW/Eg4W0AdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80760999"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="80760999"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:45:35 -0700
X-CSE-ConnectionGUID: Gmx24MozSTqzEOsRYc3uLg==
X-CSE-MsgGUID: rsp6JAzgSdiwcJV6Tg4iPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169492525"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:45:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 02:45:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 02:45:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 02:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSKw0LWH/dEL4AM3DPIFKkowsRrdMm2QRdBG9Y4y2yjbwJQzObUz4YXdTpNUuT0NF7GsFtdfZDJG4M/JWRnNBBLGUoa35xK+qlwQO3tyF2T2e+zykUyzjyHrIHzi/0uyU0Vdv5+nhOCB8GYSRaL0s5IJjOEJyG3PdwKVhFstUmajVKQVYj0wBGABrN1+5fAv+ehYQ/wEuYqHdn+/FKGVHlnZOCXzmizLj0Xk5RJkPFSpHvFQhv+RR3V/qanF3i6ZPDtg6bGwgOLTJRQZI1+Cv4vPDpxNEnZGZX3+0m2/Rjbdwv/rbYDPWCXDXavrICwonCXjagRssYLf5N2cvQ6ZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPDytkuc2lzn8xRfExCsev7qCehNqrqXNyOfhH/CTVk=;
 b=Q2/mgI28mLSZL7gjFZUPtTlLfpLJDo/shQWfr6TpkE4J5kHAzzWD4tPGUypgC++g998IZXRWGS9nq3Ia5ZADENpoBGlnVIZBVfPnVDJ7oYuikS6szQ6UW5mm/pZkMHpEHRfA+AxnYSUODyQ5mDyva19kPhj6fKVEtCg0zHXDj4TTpw7b5s1SA8g4tzGldbUh0JIdCwJ7JJAv+SBB7t+s0YX9o8gMNpZT07opNRm5RmsFkE3IDMV1Bpotac4pmSMLbLI9GA0IEK+/YpidiQ2oQeGNndNYdE8dzxrcUlQP+vzDg1wiAceI+ZmHdbNymZKKYsFbcnVVfes3gD248F8wkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7280.namprd11.prod.outlook.com (2603:10b6:8:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 09:45:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 09:45:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "will@kernel.org"
	<will@kernel.org>, "robin.clark@oss.qualcomm.com"
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
Subject: RE: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Topic: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Index: AQHcCxPRj0zb6W5cHUaGmJqSwKG0krRohb6AgAAtjgCABBvC0IAAVdMAgAFVcqA=
Date: Fri, 22 Aug 2025 09:45:28 +0000
Message-ID: <BN9PR11MB5276A95E69D761271953E9F38C3DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com> <aKNhIr08fK+xIYcg@Asurada-Nvidia>
 <BN9PR11MB5276262E1925E2CD8AE037EF8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250821131426.GN802098@nvidia.com>
In-Reply-To: <20250821131426.GN802098@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7280:EE_
x-ms-office365-filtering-correlation-id: f440f4da-1274-451a-047a-08dde160a0e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UVTlMcHFNWKNJeavkvedrHGdDCLa7lk0xdz2QDKRmWLYEJVD0o4wD1cQc9ok?=
 =?us-ascii?Q?pStGZCGia6Kqe9V2+sZXGV+8ehILuZr3Us+O8HpGAZVpn4UJSslr7LBbp9ND?=
 =?us-ascii?Q?/54A4DgqNmXuB/2oXnj+xHH0nYXrX9C0t+Z4hwu1UtaTNm31CxiV7AAVTlIP?=
 =?us-ascii?Q?T+RauE56odVDCpx0+g94vbROzftdcNgxHoBHKS7K0a0GKP3j0yjutIxn3qaO?=
 =?us-ascii?Q?3dfb2PigUfJLBPFUlhTIR2M6jYt/C4kCIbbvqVjeehB4v74fbJ4vlRCVdzVQ?=
 =?us-ascii?Q?49ziJkDBET+Tlc0cvRjykmcQJry0V/emd3ojOivJodQ4reVqbWNH2gIxkKu6?=
 =?us-ascii?Q?rIuputsON1oiWic+am69qzmYNpZFcKnTmvdX7bbBooWRZ+ZRVSCthbD200mD?=
 =?us-ascii?Q?umtZcX0ch1NI7M4P8S9SwvioUOkLCkxR1Xri7kEn3lu+XwiltA0tvNBmSAU0?=
 =?us-ascii?Q?2HUYXmbfSud0y2o9daKosDCIlsocxXL4Me5EgOdDGCWn719ihFLn+KUxbZHC?=
 =?us-ascii?Q?bc+zd77HEwclvlD6JWaGB9IUMOQi8+pyNjDhS3IqEmnLokmugnP52lGjr4GO?=
 =?us-ascii?Q?M2x8wEoRQy4kqq2GxlJDPkgxk/S0iH0NysmV0Jpj4o3PpSCJd5+W1CJ0r/9M?=
 =?us-ascii?Q?Yld5XIpS/13gKnWujOLkC6G6SN7ylxxMAR7zr86dSMPbc2nZRhgIcUCyBzRl?=
 =?us-ascii?Q?OdHU8IQQZft+1mxrqCUmbbA+gFGTUF5oO04dQanF9/SZCcwCrSOofebsHgkK?=
 =?us-ascii?Q?tsslu8w/4LCNcwXC5aNhZJGCJ67yUmySoGGVf2UJt9iljPj2VMxnou8YfnpD?=
 =?us-ascii?Q?COBRGbmsANz96r4g4StvXoJBmN+Gze/ENXLzRsb3f8LDPam1NNhsR6AXmpQW?=
 =?us-ascii?Q?14qeUrIhBxVLBD3sNqOYQwLjpWOiP1Tw94zNFLUVzs7iV9y/Z6mwbMEutG5L?=
 =?us-ascii?Q?HEl8St/GBR7wUOodBN/wDUhcqIELteEr656Rpf6zamPX6QPoSbyLOCyXcoP7?=
 =?us-ascii?Q?Jgv91sveFOMiCJgSAUjzcQiShkL+X+CQ+eWDCWZku7gjO7oaRNlAmqXqrurF?=
 =?us-ascii?Q?/1JNZwyMPYc6bUXbVfeZUlUu5w3ZU9yjqMi6FkIv+CRJz1SIvqy/s5UCo62T?=
 =?us-ascii?Q?01Mtj/uQLt5yp6Si2D6ynqqHnCCTa/pXY0hKCQ+oMWpAAMZEy1z0bkNeoxnS?=
 =?us-ascii?Q?1O6y1c+eAx9kiXYHghpZ2RGjII46tjHimJYwRyI/n28h5NLbIAAqwQl46lkC?=
 =?us-ascii?Q?ASqhCk1gYYdnR6MALvm2UkrS9TFcY5vaNVtyYrV/KKXHZiLbs4gc4w+ogJJN?=
 =?us-ascii?Q?SBRc9lM7KGsNnn4tFUxW5KmjmSPjFQyxw+8YYy+zyi42U9zODS9OJUMd+fKK?=
 =?us-ascii?Q?Zo7oP8Bb2A0u6UP7Ss2jLQC6K+Gu8rmrpNZlu8ioJPbAG9tb7zHS1tF+XTmd?=
 =?us-ascii?Q?ovq/JV8wbVzEHebrZp0T4tfWMZzR2eY6ZxacvAcKlaVW5hLDMXNJoQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Hy2VARVM7MChO3ALZ2g+BuXvtfFLBUWEESU4pR+m3+YArsm2R+lWwwj9zLx?=
 =?us-ascii?Q?edRJDJ2mUvWFsNtb7N26ynSqdNKzaiLdiarDlR0TgkjvTewq6Lzmp1j1xXHA?=
 =?us-ascii?Q?CBNVdPVoDxpy1XIsbgGGqwhodVARYNxXuoSpffaHdnYDWAgDPruxAisiU+Kp?=
 =?us-ascii?Q?XoS+rkfsH9rpFQYxkhtX0GkJzLtrntgksFwyYq6Ya0Cgys2Or9P6WuK8aE86?=
 =?us-ascii?Q?yvdfL1Jo9e0S6LKB9VGqpEuZj1xx/vUCj09ZkpeFjdMzeqiqZEoHX/+KRe51?=
 =?us-ascii?Q?jExhEf5pVyeGhfTBY++31btK6CPc1bDpK8QqWPf6RZUr/kaNclrhetS5t82i?=
 =?us-ascii?Q?a59J/V3afFV5T71bvON0UPgfILupbYk13uRE1T2rAdaB/xHCJ21uHDzrCoPa?=
 =?us-ascii?Q?QVhapzRk6h2ErOql1j1716fCGwTjOfl45vNZq2+6fsazP7YfYqkTxH8BRV1D?=
 =?us-ascii?Q?DlZ2NoV7ArIZn4VOGIc2gzcR02zEiIIlXsjMydi5a79hCJJAiL4xDqULqrFD?=
 =?us-ascii?Q?Xc60MPX6LUhfGG306HBZ9Rz5D5ZCicurZZ0JqLZ9YNKoVWKc31608aPkppWL?=
 =?us-ascii?Q?pCaPYAEIJ0MbLQjyWoNZ6fGJWhX3kW9cQfarxFNIxdMYLOEkoVXeGfy6nngz?=
 =?us-ascii?Q?AQnnz6TVSg7GpltyvCAkdxNWeUVB0L7psSylasRdVpWjliM1SvJX62UQYL+B?=
 =?us-ascii?Q?6IkGmPvj1A8nPJlQrZAxrJl82xMZAyK949k2Zv9eE7hLEoD9PwFmqP98fpmE?=
 =?us-ascii?Q?Sk1orU4Ih6Xc+VHUMAdypPPMVD9M5HsbyL2QOOjzAwh0eS/+uhMWvPyeUysO?=
 =?us-ascii?Q?spgPjB87nevMpfOnNcZUf1I7IXNKVJzfac6LLYO6kqJJGcEj9crdDsgF7sS3?=
 =?us-ascii?Q?mAuqq8L2yntFhIgH08pyjQ4v1XBFZKewCjx6Txz1I0RJ32gBZ0rQx49EhyZE?=
 =?us-ascii?Q?e0Y49eUaSbbXskUFB7TXYZPC8yVmmHpaR46cDukZtgbJlJqMwPwWkuM5XGAp?=
 =?us-ascii?Q?osb6w8HabfyVw2klASQlgnHuaqHCbQnhpBCMNURDulqp94Rd9FFBebxtXFEe?=
 =?us-ascii?Q?l4cVKL/yJeBKnzr+HAYh5L9VrBxbrbLkq/CVl5DUD73kyyirENneMyj+AiVk?=
 =?us-ascii?Q?Wcwxcf5E9EzfiAjZ90RrK55DnUK3uwF9di5cTdyf7OH512SEW8Bo2IaB03ip?=
 =?us-ascii?Q?rUsPgY6n9ausHUcGJUEiWo4VCMHrZQC6seRuBXI7Wt80USJIZKQwYJ41soj8?=
 =?us-ascii?Q?Oilb8+6iPo8zU4mFGWNgG5M69d+L6TglaOHzgZWP71UQyIqodJ8dCTfUuJU1?=
 =?us-ascii?Q?BIZONtNwyGGBwlmD8CQbpOHeC5jLJVbGdNeT4TRZPgSUSisfz2JAEWbNmfZW?=
 =?us-ascii?Q?4Sv40FQKXRE+L/jKsALT5XPPbG7RkkeTKV5zJQh6jeuPjXLLtRbxb8uhsRZa?=
 =?us-ascii?Q?fGfwPAry+AgCawiM8MujFis6GW8w8aPBmW3h1CS9hsD7zoHq304oJva9v9dX?=
 =?us-ascii?Q?+SwKCioc70dM3sN5o0n5noORvHVR+ca4/hPAuoVuV88TiDnD8u0R5zb8mGCB?=
 =?us-ascii?Q?QnWDbH080VJAC1AAs9mUIxkGexUNrhtBhKpgeoW/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f440f4da-1274-451a-047a-08dde160a0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:45:28.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cK+R9C6A6EhgMaAHPENsOVWiIdjqxuNtbgp8m4R6RJTyDx6LzK/QcxwUfxsD6UpExTP8/XEI5eiVgpx4e7cn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7280
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, August 21, 2025 9:14 PM
>=20
> On Thu, Aug 21, 2025 at 08:11:05AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Tuesday, August 19, 2025 1:23 AM
> > >
> > > ... I found that in SMMUv3 driver, iommu_get_domain_for_dev() is
> > > used to get the RID domain for an SVA domain:
> > >     arm_smmu_set_pasid()
> > >     arm_smmu_blocking_set_dev_pasid()
> > >
> > > These two are already given an "old" (SVA) domain pointer, FWIW.
> > >
> > > So, we may change to passing in the old domain as you suggested,
> > > yet we still have to fix the iommu_get_domain_for_dev() in order
> > > to reflect the RID domain correctly for the driver that calls it
> > > (or even potentially) in some group->mutex locked context where
> > > the RID domain might not be naturally passed in.
> > >
> >
> > Out of curiosity.
> >
> > arm_smmu_blocking_set_dev_pasid()
> >
> > 	/*
> > 	 * When the last user of the CD table goes away downgrade the STE
> back
> > 	 * to a non-cd_table one.
> > 	 */
> > 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
> > 		struct iommu_domain *sid_domain =3D
> > 			iommu_get_domain_for_dev(master->dev);
> >
> > 		if (sid_domain->type =3D=3D IOMMU_DOMAIN_IDENTITY ||
> > 		   sid_domain->type =3D=3D IOMMU_DOMAIN_BLOCKED)
> > 			sid_domain->ops->attach_dev(sid_domain, dev);
> > 	}
> >
> > why cannot downgrade apply to the case where the RID is attached to
> > a DMA domain?
>=20
> If the RID is a PAGING domain then it must be a S1 paging domain and ther=
e
> is
> no downgrade possible.
>=20
> It is impossible for the RID to be a S2 paging domain while ssids are
> in use.
>=20

Thanks for the background. btw is it technically impossible or just
not worth of the extra software complexity for no value? e.g. if
maintaining two page tables (S1/S2 formats) with exact same mappings,
does SMMU allow smooth transition between two modes w/o breaking
in-fly DMAs? but probably keeping two page tables in-sync in transition
is already a problem w/o proper locking in map/unmap...=20

