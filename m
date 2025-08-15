Return-Path: <linux-pci+bounces-34096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF2CB27AE0
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 10:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E171E1C20E26
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982124166E;
	Fri, 15 Aug 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arzQzhDC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5FDF71;
	Fri, 15 Aug 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246306; cv=fail; b=pEhOX83n/nT+DOCSWeKaUkNlatfOaQ4VgBxl5moiwAIokz+UU9q0ce7RipPfS52iu3lH+54OJdgwMnWc02lEROkvQep7xKttClMhD4ql6fCXEWs9nd2e4zOcgfAClHJ1yhZLZ2/Wp7CuTDtOVEE1hLTJMqoCoPmzRgwdFu040tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246306; c=relaxed/simple;
	bh=NRDdqxN659/vwsysgRGFLfJcB/1nuf8UrhwSWL19wTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBQ6Eu9PoyP+iRuPDe4Jk7gEbRn9dvmdbS/tNnn/D64kx9oGGU5p26nWRk1NZ4tEvt5V4OlSzrUnXMCJOLklStu4kKbjVDoeyt6SmAcvRVwCnIroyzLT4HSjXdCNTJYpSEYIGbzdHoG2M09p+SzqXsC1/9ffeXwIa65OHClquqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arzQzhDC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755246304; x=1786782304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NRDdqxN659/vwsysgRGFLfJcB/1nuf8UrhwSWL19wTs=;
  b=arzQzhDCoOhqzg0VgPSqQ1pMXmrU5mkbK0AFe2G9MgZVzVDWmLD2vvxu
   uH0KsvMPwuVFt44ngMkheqUNfR3s4jJqc+K00JdyvZN22bJqaCS+wN0CH
   CHJzZTdKxnU/74FuH20IUGzrI6Ad84AdgaNjMQ/ERwvnUZav61w9x6I3z
   1ywAU3W7eifSV5VMp90h5Gr4jdcVvEnijEJyisjVrcHecpTZLd1SC2hit
   bAVs5gRQ5QB2zlwuY2HYuAge93ycyCuqjIZI1KLON7tsHLqu0Ehl2s26k
   TBhPU/tFj/5YaZEVErP7lx15UrfWxOZk4OSH5WIS4dvCqmPQ5VU0uQapP
   Q==;
X-CSE-ConnectionGUID: kKhhj7VkSMqMbyiXdK0bEA==
X-CSE-MsgGUID: g+2rPs2lSsippOvNKI/BGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56778093"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56778093"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:25:02 -0700
X-CSE-ConnectionGUID: FWI9iLsDSQWzrtrqpU69eg==
X-CSE-MsgGUID: jYarVl0jRFmcq45b9GXLkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197965392"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:25:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 01:25:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 01:25:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.41)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 01:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPigQ84/z0XLlqDORMF6gNGlAfHBzYB7Q7pHtwc3BsgyKVh7q2fC5KybvJO0XmiZ5i7sPQagn793M6k/G6K4WnNA4Ea+4jkEuyKbSHJmMgtc9Y06R3WfZIFx+q+50guMuM7hE3pOrDX93Tox07dHIeoQzOSDoGSr1FOIPOIa6fLIrgjwTDDGnBayg4vLvpViFGpbHWK+UH44KooNG/2S2pHm9wcC8cCtxZh5mJAYVxrWy8L8Sx8Uxc0poZxCBUF8Vz5YhCsAYuF/ETj8+z5hBP8P7lY4QsnowUNCqQysMj8wQyCsZWUBrPimrNUkDK9psRyOHK4LQ5vq1Cl7hwhJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxmnhJHbeHxs70TSr7TH/Z3cto3qeE1yz67+SPh2EC0=;
 b=yzzlWHpABImspIzApZEbgPogbY6y767dTuGYJVBn4vhKRvekGPuH3tU+zb0iiIURTLrm12NYJsKIHcpZhaF15WZ9BEK9DuMMnstDcOdXYIi2ghobkqiCC7LcTzlsmPcmy8cJ+Ff/2Xn7b/W4P/yd+vfWoNfOpsLIN2stduDbrhGkuMN1PAhw3LU9T1mWsUYEIDy2W6VDVfgHTmUmu5KaBq+/kgQLSIdjC7lYjgOy4ed3WWMhe3XUiTVs9mJq5aQoUPKWTMClA2Af0Z9piBq8qIidxKjYzq6xBbvpBW1AZzeoQskLXxPWdYzDAcUaunONMN3+ggW7Yw5CIj3BYror4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 08:24:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:24:57 +0000
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
Subject: RE: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Thread-Topic: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Thread-Index: AQHcCxPR9QhO2RgIz0mPcy8d8fJgaLRjZRxg
Date: Fri, 15 Aug 2025 08:24:57 +0000
Message-ID: <BN9PR11MB5276F543286807E05FB465F58C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
In-Reply-To: <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6246:EE_
x-ms-office365-filtering-correlation-id: 579f6c62-80ea-42f3-78d5-08dddbd53883
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?d9wjLJwApFbIGCZrT2O584xZGxRBGVYlXnRFSE4r1H1Y7SVyNB6aKG+H/YzT?=
 =?us-ascii?Q?OhKCb/DBNuCdqjcp7tVgN6JjAuFGHFLhOmgw+HILhJKpO04DHd9niSWV4PJx?=
 =?us-ascii?Q?/gjuuaL3VDZeEzyyM2f8vw0sd9/uaiFClJ9nno+Ci8e+3KurkM3KPKzXdTwM?=
 =?us-ascii?Q?L4xX/ZNIsHjY3KdRYFQM5kcPwUs8VLkeHqNI/xc5sBrFJozCYnTUIcAHDc3/?=
 =?us-ascii?Q?nrDpAG2dc1B4pBFOUVPudHCBtdcczdDTG3kMEBzQeMKWwXh+LmpPcaSUqfRG?=
 =?us-ascii?Q?/qa1pXITL1rtiPolBrDs18ny6Zgotb2hqWFTEPkSibLY+23iKNjF6O7/cCjw?=
 =?us-ascii?Q?DsrjYTOjjxQe+NfkpGKB04w+67Lprpy1MKGpiY0Po2h8oFRwrP7I9n5hW+Pt?=
 =?us-ascii?Q?14Pik/qLBJX8sJcpgTrV9ddLIDeRWI11bjZ24fYbdhdJoqrhhMwlBvnrGhT2?=
 =?us-ascii?Q?vNtMeB9xDrCCrVwFki7gNAU1w3lMljyRhsdQkmyMAd5emp8kqhxENbaVspG5?=
 =?us-ascii?Q?HSYbBjWr/RZPUd6HgxA8LgVnbiM1cMwkG0IJW61BBgvAeSqlI1Q5TDW4RDWL?=
 =?us-ascii?Q?vNLDYCCMKvinua0Iz5/DfLFbOl2fTTtfySZTcDJIrrbQKGPZyFa+PZUqYhwL?=
 =?us-ascii?Q?egRsuqXdu+q+N2OWfWQDUYQ0z5C1MiOWgqZp0nRkog2rYolG0q91teHhnH/g?=
 =?us-ascii?Q?lQFiCOPQh4BZh9hHCMAqBv8SbyNaS8Q/njgMtpCDzLdBy0LvJrLj/KbdWTl2?=
 =?us-ascii?Q?NJTVr2TfO0GbvIurGKZC5ef2eulHwc5tDvqGfKeyiNmZN4fY8eFTEIwmL3aQ?=
 =?us-ascii?Q?2DOx+ONV9OANIxAax1I8jCZGss8jB4OCBJqE2mzZyDHqf9KOryyoiOZedPfJ?=
 =?us-ascii?Q?t/VrSrwltVYorYiBZH+sSsIjwBKwL7n0uCL8+Tq2xCjmEjecS0mtzqxlf135?=
 =?us-ascii?Q?n+isdEBiLTQ+XWfKMeOAhKaU2Su8LjIhbX92OQsY8iTgche7UGm0ii17gP6F?=
 =?us-ascii?Q?rsPvnmN1pxbWjIcEMH2R3ZCpl7XAAJpr3rD0ZyZgSF/qJ8Hq3RDj3VNwphvi?=
 =?us-ascii?Q?3zIFTE9u6cJ1/ibJvoHOMQJGVXrq+wQbaXO4kxQatFb64cNCy8CZHoxVUDlN?=
 =?us-ascii?Q?9Tm8TVBXLPIGUSeCHB87/xFKtwsutbSIzustq3cAOR/t9NA2yLamG3F/s7ax?=
 =?us-ascii?Q?knr1T2i6PW4kpA+XiBDHnhxJu5JPhYsPNLz7zAJ7yT8ZgtQrc2zlw8kGm3pd?=
 =?us-ascii?Q?edcwgOTmDlI0lG7qQJykKxKIz3iRlO5oHAbaCrm8D3FpJXLhZnXyxTKe7st3?=
 =?us-ascii?Q?Y20Ti6vCsPUEyUQtPkYfPqk4vKoj20SGcqGW//gImbvBcE8Qozv97DHzHS8o?=
 =?us-ascii?Q?uC+5XcsxlqU6zt3OcmLj2aq8RlSiO45DQBNsiJL5vEe5l9FqNU6G8yRNunC8?=
 =?us-ascii?Q?b3wh5iNaKZDTQ+fsIUHxDoMAr9vyCYXIErs2Dblwxl0rXYxJHF9LxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hqNj9XEvL5li55LjpJxRVTNSNHOHmYgdscGuSuNTcMs1bfmMXySVsY6NdRbM?=
 =?us-ascii?Q?IVtkGA5pIB7ogaicDcnPbGF5JlEt6gjQ3nx0X9SGHaf1ryHw5Fz+iucaVgJR?=
 =?us-ascii?Q?2tGrIUahaz/mnexOtQwlXVmzMA9uh3B0aTTc9bp9kO43N2aGH1xhBA/B7WRk?=
 =?us-ascii?Q?atOyiSQ/WsSalPrL8yDiAQwLDAqpHg3zzsdwJc6wdyUOKQnNbXBSDom1RSUX?=
 =?us-ascii?Q?l3iPZpZluFWjqmOhdjzcde0UijUQMq+S2+VfG4lqf9NlTB7zrDT5VjMuFpDD?=
 =?us-ascii?Q?TSYifnRryBS3jrL6vJtbuP7iOAyM6W9Hhao0qxPnzgzaAcVSexK1/qJUp0sW?=
 =?us-ascii?Q?2eP0WwZzKk2BCxEh8ThiREXz7j3hGPcv1MhXc43ol50ts3CNPbmi147z8K2Y?=
 =?us-ascii?Q?V+Z4CG1fJFS7bGEOM4wwI3aJJskQ6S1DS40clKNJVZolC7s/2HnW9TuZLCDp?=
 =?us-ascii?Q?YeGF2Tp2h0NEI7Stz9rgDs3M/Z6umZx0u+7LjVaeCUi6bFDkNM9R5+rxb0tI?=
 =?us-ascii?Q?ko32l8EySNeVvvz+DGCno4G96wC1xTlqqUdMODhVftrekRK+Yz+W5JhgHY+y?=
 =?us-ascii?Q?1NI+lMkQ1wxpLErtJlWtTDDpiA6f4UB8RggrhNbal8fpIXTLYDpxM3BdMTI/?=
 =?us-ascii?Q?so5xbJRYx3uSDBCzPG71QO1qpNeDjkGnpm10FAoiIZelrBj+9kr7SYLY6eS/?=
 =?us-ascii?Q?MsVlSQ5sb5/Npl3F1cBKE5EmrcaLMFzyJqBXAu1of+LGRRDwZmtFqB2hCQe6?=
 =?us-ascii?Q?9tYr/61toUudogh/TerRF0XSTiQALlzJOz0pRl8MNo4KhBpkcrlOPpJ1CzT9?=
 =?us-ascii?Q?OZv2gIKetdQfgx63C91kl6XKkPkkfME96KVbz5HAF5GxDWkh7z1Z0kK3HmIn?=
 =?us-ascii?Q?tKDJULauKn4lwIHNO85nRn66it8DYb90Hy3Q/m3or6US2fr9bKbpQfUZcU/r?=
 =?us-ascii?Q?2Iy2TKo1ctoWYI4TAuDvsH5knwBfQryEh7nybCp/HiVsPVD66Im9LsxZIaka?=
 =?us-ascii?Q?q7Nb0G+jEOIbzFCOg0dHTUjVwGZHzTeB2jvu2ZdMzk1lhHst6LKKxuK2dPrM?=
 =?us-ascii?Q?rKSHVoIVNQ+PGMZqtUubRaOMjoJPzbKsd+6dUCMKBfv1YXqcl94VvRnTipzD?=
 =?us-ascii?Q?59HuWwHLoG3wH8uSrjAc66sQw1VL6LbIFfn/iYjna8jwJLhbqCPQkXk36ySu?=
 =?us-ascii?Q?8zuFP8QxwFmH/EabxyZcYA2mRsSzmfyNtRE5JrzdyE7F9I05EZFrfm9Je7xx?=
 =?us-ascii?Q?CNE+/LvRgIr/EHvPCDLubcsH2cNamACx6cD9vF9SyyDVugY5nQD+75ZUCakC?=
 =?us-ascii?Q?7dSOiy2HkdgSBahjgLptBfjVi5/yaGMQYGCyP1HGf7GG0JAzSPrJClLI9xvU?=
 =?us-ascii?Q?V/dunUxe75AIzay/xQu9UJz1mSK9Ke7p2qkoxSk7UPmmnwcWScB7oLbfCyYM?=
 =?us-ascii?Q?cGFl/uJ8Ei5WevfjUTaCfLrHnYbxv5UudzwkzY6KMtQeBldx3vctg3Zhb7A0?=
 =?us-ascii?Q?ZNkheiiDqamAb5rJrYpvcIb6aWLUevVGpLzF7AWAA+XeB61oG1jcBwRfmNgk?=
 =?us-ascii?Q?Ay255+fcQMiM5Yt6Cnemt1qY6TDV/dkF6KlxhuPt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 579f6c62-80ea-42f3-78d5-08dddbd53883
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 08:24:57.8796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5+NGTSUzfufc3mHoQ2yhQZXVa/qiSMfZ6P+ttkcPPSK4Y6pfvTNlBvhm5/DeYdW8Sh358/CbZ5/A3jaoqRQZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, August 12, 2025 6:59 AM
>=20
> The iommu_deferred_attach() is a runtime asynchronous function called by
> iommu-dma function, which could race against other attach functions if it
> accesses something in the dev->iommu_group.

Is there a real racing scenario being observed or more theoretical?

If the former may need a Fix tag.=20

>=20
> So, grab the mutex to guard __iommu_attach_device() like other callers.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 060ebe330ee16..1e0116bce0762 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2144,10 +2144,17 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>=20
>  int iommu_deferred_attach(struct device *dev, struct iommu_domain
> *domain)
>  {
> -	if (dev->iommu && dev->iommu->attach_deferred)
> -		return __iommu_attach_device(domain, dev);
> +	/*
> +	 * This is called on the dma mapping fast path so avoid locking. This i=
s
> +	 * racy, but we have an expectation that the driver will setup its
> DMAs
> +	 * inside probe while being single threaded to avoid racing.
> +	 */
> +	if (!dev->iommu || !dev->iommu->attach_deferred)
> +		return 0;

Is there any way to detect a driver breaking the expectation?

>=20
> -	return 0;
> +	guard(mutex)(&dev->iommu_group->mutex);
> +
> +	return __iommu_attach_device(domain, dev);
>  }
>=20
>  void iommu_detach_device(struct iommu_domain *domain, struct device
> *dev)
> --
> 2.43.0


