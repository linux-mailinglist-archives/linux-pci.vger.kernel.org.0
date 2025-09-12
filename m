Return-Path: <linux-pci+bounces-35996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4053B547FE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80861B22143
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8A284B26;
	Fri, 12 Sep 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMCkCUhW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBA283FF0;
	Fri, 12 Sep 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669784; cv=fail; b=a9f7Myi5cxDJ84T3MxyLHPBjunL6EM9+0ZsRqPNtEcfKN1jMqMVneyPW1S17I0ptUvp56k27EsFeyVi3sZjRD9F1WBL1UhNWpqQ2TctSFrlwz7PnPJU+qR5CMX6RrIAP2fDVrYz9kxywPUmk44kq+Cmb+QpWYUaGEg/zx7fjTq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669784; c=relaxed/simple;
	bh=M4LjDXjZUz7Ex/I9nJlNYa7NZdpSTAtAiC/zxZwHJho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HRqcET0vryFOIEb05HeEWRBt6FJfqHHNvql1G30PRUzPdOsv1Wa9YoGZbMi96caypw4lH3tSxxFxgsbpCS/4eex1pnr2/ecKOFxn1rX5U5tda5ydigOV2GzMYjVAbUkpy+HdOMdDOhLhhalRaGjUid2Jq3Af5DoNLMpgR0OOMUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMCkCUhW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757669783; x=1789205783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M4LjDXjZUz7Ex/I9nJlNYa7NZdpSTAtAiC/zxZwHJho=;
  b=MMCkCUhW/5JV6HeOr1JYKNthrSKeuzhHv3B8HiHllwSuXLgsvqvRQlkP
   yGi+BBjv0OTArZIg0ojVT+cCHuR7I8Fl56IM1xudbz8ArZjFl5Mu3VqLa
   fXkByn6XGvewAPMVqMFDow9wZ9o8qXNzBts66a2lTlvQSXlt3+4SExlLm
   3e3cjj5EcpA7/vy/1d/zwpi+UUs/pQeY/wCoB6NDdn97/K2gYQT+IYjPR
   MxzNq2Om+9lkJ7UoALhjSmj4sUcvw7M6Hlp88dRkYNUC9WWEysf4dJWom
   iS740SISfPPKFUMV2YifOEB1J1B8MazlzlM2lqkTLLwQLYak0paW6fwxi
   Q==;
X-CSE-ConnectionGUID: GR6O0aZ1TA+EuE9aybw7Tg==
X-CSE-MsgGUID: LwJt9Of0RyScvkn9a8UQGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59710132"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59710132"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:36:22 -0700
X-CSE-ConnectionGUID: rvhMGQ0TR4qQHWSKYNwLPA==
X-CSE-MsgGUID: RAIIqEYGTHuyCG3SO0mvtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="197613292"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:35:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:35:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 02:35:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 02:35:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryk3E68FHPzzTPIaUTwaR2vsGmyA01Y1qMwm34UR0PyYKD7IGtdiIufY+xKoQYiLPKaLNb3pxT5BUcLfDZ+5vBOD2TOBjWprZ6rBYgl4kwWiZbc3PcfGgPCK2vLqof0QaJJd3TkPt8R/6N5OZ06S6oCnIOfaCS38ezkBch9+h7vZzJK+8XI70GugZO8Vb0LY4PL8aAxHXVkTaXXxGmZT8i58A7FL7iC6Hz9yYzCpebGeLGPt/DsZI+70Q67j833O3cgiz6+r+TRY1tH213SmfDkkFejACvXaNk5mcc2zRxT0k5ajGvCBWz1qHafBHfsTlqf2aIjAQyoMiTCqh4HR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDEn7q1Fnt42xIvJVMufr0T6YnJdJIT1HQlp8zJrnT8=;
 b=fO7t2Q7SRCg3PuW3WOqJYrJJhb2Cx3jlZWiIBLPQ20ft/6YvdlJlMcRXPTkSOTfFFy6D8RMnZJlEwLosqdZhA/Zc2Hm6qhkstjnRcz/DONgFb4WuS82WNSw4E7pmOPvaIAnSoQZhOZc3ifhQzllKR+ECUR4pU37LijvKz7IMf8PWYf3RS9Lim/smYOQ5AwS/i23Mocp9LMNt46L0ivCkWbwndbE9iWAVojYL8qXW+I3PMZkbC48Iy9qGN0UNN2+edvdQLkkgSZUdlh55vSzT6pv6EDU/IEnT/OGjtD0GbajzPTRuDMqEXuDCHfWfLP9vfBWu/1WcNtIzkQ+yXG0ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SA1PR11MB8860.namprd11.prod.outlook.com (2603:10b6:806:468::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:35:09 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:35:08 +0000
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
Subject: RE: [PATCH v4 4/7] iommu: Pass in old domain to attach_dev callback
 functions
Thread-Topic: [PATCH v4 4/7] iommu: Pass in old domain to attach_dev callback
 functions
Thread-Index: AQHcGs+mElYEwuXgBU2+rJGFw8FtoLSPW1bQ
Date: Fri, 12 Sep 2025 09:35:08 +0000
Message-ID: <BL1PR11MB5271CBE8898677E8BD745D458C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
In-Reply-To: <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SA1PR11MB8860:EE_
x-ms-office365-filtering-correlation-id: 060f916c-2f55-4e89-061f-08ddf1dfa9d1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?2z+3xyZxxznbrMLsSDStfJJCoqS8D/AyFgjVchYVoFbAVHTNnjrShzbhSrCR?=
 =?us-ascii?Q?QDAGot3fU70P/WJux58aVMlZLldBxdRF/yX0X716MFit5YIMtT7Dli4v1Cx9?=
 =?us-ascii?Q?cJRme1jcod4LAIDleIY6vxZvPIh3SxLMEuOrtJPxArOf824/YxOQg0HxcQYc?=
 =?us-ascii?Q?Q0OkT/nSS3knjCIMvU/Wpk61yaGPOOQUFGQirj29HPnm1c+YBqxWbAm2Z7AT?=
 =?us-ascii?Q?LgSN818kB8MUC0HPoaWiKIvfo8CBa3zzAhM7DsezctB56KGYqbAAd2XFbwYt?=
 =?us-ascii?Q?xHwPqJQwXr3IHPKUrhk1/1GESfMMPpj1bhTmQxNAUgC4Wu9hYBLMmeoDKVC7?=
 =?us-ascii?Q?RbO0/fitkCTkHUAI4mcO930MmO/WPGPhtK4ulbS1YFoq/Wawg3HWs0MMrwXc?=
 =?us-ascii?Q?F9jG0A9O+MlGq4IDR/ndVBObXTbvxuce7LP2DIxsapy4dQGX/LdbVWKAYP9L?=
 =?us-ascii?Q?cyX7CI1xWDQRi/kl4n9Du1xGWsKKVWGfBTT0JE7NJyeFRxCGnwPlOqO+LY7X?=
 =?us-ascii?Q?TipgOd1ol+o46yrox9l2jfYE4bdFbvqe2zsHzGgnt8uAyCaTT9ccfmykQDvW?=
 =?us-ascii?Q?RVQFWIW1BOpqkj0Ix9HQtUVYtz8GwG301T6lGkzY7pL6xYJKEKHtDG0k5mxD?=
 =?us-ascii?Q?D3ETQ/yT87p2KEWaFyxg9ND7e2OxCxOAAwikvU5b/a9yjsGx1rJWMNK3CaEn?=
 =?us-ascii?Q?HYoNaAhlJGvgRr0tZZRTYdtDr4ajHyxeDJage+y8rJUWXEH/BMTrDFyMNg6G?=
 =?us-ascii?Q?t2PNM+2ATMr0HyF3mzx7ag+/qExKylEDcvrMbnl725uMTuNYMCGeQpMXvy7I?=
 =?us-ascii?Q?T/7HMwFgEI/zSL1vkUs215FJ+YRt4YUJlKkL7sgtxmDRJk4cOeBBrhmNUvFY?=
 =?us-ascii?Q?HKeJQRt0Mg2C6qurerkfawLuCB5JXfJ0U3ss9vHvjiUfCzyboCIltad0DKX+?=
 =?us-ascii?Q?3Vw216VnW65fmW2yu8qFYtThlrvqrHcCfywBDsTCs3DUZyol3qfd5d4h0Yzg?=
 =?us-ascii?Q?HnNWROvuVNFGvUwvbi9ihSO3HZdHHLdgMBViR/d9d6qmCWJgZVaiJH1wniMR?=
 =?us-ascii?Q?TT7JD27OhH1y2RHTE3FIBdyiDFL6O8syrIS0HqJyVpxjzR0bod4HKNmX4YhD?=
 =?us-ascii?Q?7IBZaswJ6uJa/vFVDx749WJgKuoumMENPOXqKKmH++xyFXZUu9wSYSWqGMeP?=
 =?us-ascii?Q?/WezNx2FnLEfDzc5HciZkg+/JxnfsHJw/W6zJqDZrsnv/lkGiKYgblVEFSty?=
 =?us-ascii?Q?sKU2gVbraXM+2Sa5prZQ2JlkVtL1G1fQ5fz3NFoZqC9Uqbw7AUtUzOXE1tLI?=
 =?us-ascii?Q?mSrz+kpQ7CTQksPMSfujNWna0ILI+2XfbqsgMTc25dFODll759/IVS6A7T13?=
 =?us-ascii?Q?qLpiJ+tjtbtarjAzbivrcXciE5PTCOXMiiohenDKuOJoNdhcuzpakWRxsA1O?=
 =?us-ascii?Q?b9k3+rgav2Ey50FPTOkWBvs8mYkTf4jmHY3uomiONcVdInIsxawRoA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cuwXGuo5zyI+aAH3WS2wZ+nb8Z7zG2iawWVzP3KiRgD0na1TqwDt+adDVse8?=
 =?us-ascii?Q?K7Og/P0skZOf/PFC+eACEt6FLv9Oj7kJF60aoRbW9WuPz16i4OqCZ0ZRpeAX?=
 =?us-ascii?Q?8vaT6faJdwv/c4wTklpVl1Qe6LF1oDfWLEdAs5ux4zrct1DR7i6gG/nkDVI7?=
 =?us-ascii?Q?HE70ExE5FyRU3sH6J6MThchylt+mZetgWhNtZcKVy68AJbroz2yr/E/NQdG0?=
 =?us-ascii?Q?j1jwNtY95jLi37ibNuJjwgHgFtJm84Qk0PyJvu9SLk7MDRpynnvb8rfbvKtt?=
 =?us-ascii?Q?s9bw/m7q8Vuix0AT5Ha3//Au829vWOE63dp4zJ5GRHnhA5geipFiXt2kVm/J?=
 =?us-ascii?Q?ZcUBQdfXeMEB2RtB1yj10lR1MboYU6aF20qk1P/AjmSXM1c27/rqpbCg8Jj8?=
 =?us-ascii?Q?jtci42bSIUbb7z6sSzTjSJ2Pi4DQbl0BQyVE5VDsiOxss2OrnxuuZotwFPpq?=
 =?us-ascii?Q?2VmqSD+4okmg1/1NifbRJesnMDP/8K3w9YJH/K/XvHIqbC3iAp4z9aPcXo4m?=
 =?us-ascii?Q?crlsGPW28YwH5CJn7oNTiEvZXqZQufs08s2rwdF0szAmKHvuT2S6MQwnuNxB?=
 =?us-ascii?Q?QpdODS0wzP0lU3osENuNlzRIiiacTqTDky2tK6oXgACQOgnfbk+qwRvqezi0?=
 =?us-ascii?Q?vbVKqogmBFMNtMMPozjuV6GxtNUxNPp3qupvBidXSNJnaJWvDNqPWbEhZxPz?=
 =?us-ascii?Q?UvbxfYvixY92SsOdkSHHgErxUlllsIeGFK/WG2Wchcx3G8FkMlILd3pnyvWd?=
 =?us-ascii?Q?DsehRe7j3h/72gSSNgjA4e1jkW3JzzEg7R6svAg27RMj8h16bu66dh71ySwf?=
 =?us-ascii?Q?cj7mGqqIgkGt9krJ4WES0p5CjvMaBrBoW67VkWs1aLvfvTu+/TsX23SfKg5R?=
 =?us-ascii?Q?m0GO/mbywe8Z8/Y4An0zMOAYB/om0BagT9JzL9hsKjyAdHTuo1MkkMLkT4eS?=
 =?us-ascii?Q?8qaW6vcfP7E0v062Hy72KlIgy6/U1FWvPfFok12smzmy7Txcl6jSkynjPFtw?=
 =?us-ascii?Q?2iSSU14VWZZDXyZOopgnDgTp+xB8ElsatEdHCXcAb/NZfbMzXvG1rq1if0a6?=
 =?us-ascii?Q?5e/FbbU9+bBFEfc00ijIb2TTqQkyh6lKlAvAlnPS/RapRdw99oE57eD7oNwK?=
 =?us-ascii?Q?f7iHkANmZuKZGfeR7CtEqo/pcJKxGNBjEdXWWlxBFIB2xDmF/ffrWdUjtNtm?=
 =?us-ascii?Q?oA5fpgoXt1zB8hFy/oqkpDiO2HmPzaKM1mtLG14Wkm13fXMyS/0a2t7JjcSc?=
 =?us-ascii?Q?GVboQZtFNQEt+54J+vA6vr0rntaTeR0IAVFD3eSATqzkH1C/Z/rPWlWCEqTL?=
 =?us-ascii?Q?30vvCz+JHIErR7LrheQJupqqU6OzuGUNP66D8/WeVg6zh0LRVau+3wJJBqfo?=
 =?us-ascii?Q?deoemqJ5U5EcaVvMgBncsfSOTxXycFsT7NMilGwwYj7X6O/Bn1ew8B9Rtsc6?=
 =?us-ascii?Q?88jmjeMu4TfEUj+qAWIB/ORVIvuerSJqh+7woaZvMPVXgkyp0TKPZjSyvVJl?=
 =?us-ascii?Q?1T2vkkh0/5YxrMInDJgSHGpGwDG+7CS8B6afOMKeyxB+2FeNBfYSH7HsKeBq?=
 =?us-ascii?Q?yIygBn4Oz/CQGn6vVnJ3eLFSJSqxNeA+wYfII6O+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f916c-2f55-4e89-061f-08ddf1dfa9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:35:08.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aC29wY5Nls/c6bcwxBy5vatBP8iy6gYP7um/yv8haBhqswz4Pf2Rwyd3VZZqBKiL4/8mnjfBCgIXUmkea0VpIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8860
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, September 1, 2025 7:32 AM
>=20
> The IOMMU core attaches each device to a default domain on probe(). Then,
> every new "attach" operation has a fundamental meaning of two-fold:
>  - detach from its currently attached (old) domain
>  - attach to a given new domain
>=20
> Modern IOMMU drivers following this pattern usually want to clean up the
> things related to the old domain, so they call iommu_get_domain_for_dev()
> to fetch the old domain.
>=20
> Pass in the old domain pointer from the core to drivers, aligning with th=
e
> set_dev_pasid op that passes in already.
>=20
> Ensure all low-level attach fcuntions in the core can forward the correct
> old domain pointer. Thus, rework those functions as well.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

