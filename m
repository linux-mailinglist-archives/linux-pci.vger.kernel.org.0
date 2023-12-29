Return-Path: <linux-pci+bounces-1540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7348381FE19
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 09:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03BC2861B0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4565463D2;
	Fri, 29 Dec 2023 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuSfTRLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42A6FC4;
	Fri, 29 Dec 2023 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703837936; x=1735373936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B8QFzn7bEpKIKjVsQH0qT+KW+5bPVzPWZl0oM5aQioA=;
  b=DuSfTRLVnhXAPjI2uOSDlfArSVkuPOy9zbPbGHcq7nGeebTwjoTLMFwu
   0lsxJUshXgnKp+Qv4gTpuMANPHuaBCB2n7/laRwx6Q8eOj8y8wddrkXN3
   5xuHZUuebIXHsRWNCI4UiApVyTFbPQjtqn1KylozSmWajvQelbG4MTKMk
   U51bWgAkNX5VlUSgBLM9tfcOU1RtIeq3LjYk6ensjLX+/1wE3KQ242dU3
   7NJekCdapZCMVqsjm2o2fMiZ+QC/7EkxOlKdqEgtls6RDCgVbit8aOfaT
   rvY7u+G8meFApDB6jN04DEjH4CqCrJaJxPYk3JgR7jRKyIFwxM5KCNmTq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="15276797"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="15276797"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 00:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="849163458"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="849163458"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 00:18:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 00:18:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 00:18:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 00:18:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 00:18:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldgt551Fcx0sF2dTghWVnwUVbbzqj9SmWbE9i4jOzZLIfNhAQWiMjM6LfT3jR70apeFdy9wRnn/MPcZdJDCVQroJ1WYSQvUM3r/Ew/yKfZ0X+MXFApVzXfpemRJP9/hMB1afeutGMUVrviaX1LOgcgu33BEYC738KmN6Bfl2+kXElXkpDFcixw9WPCkoWGIaWRo7+muiJFKmnZp9w1PFj58Vv/OhSRyLZ8GvBPU8izqxV9szHGkjugQmOPGFzCPLdY+8HDFr5OL+j4GuRomVcCMs6WKhnApf3+VUdnUWRnANE4k0kfZHMzbzCVixhgreAcztHSkuQ+nykyA1FLVwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0qKyD6NiyqdF4+ukd5kPa9TpxAuInm8rtlbshSNKHI=;
 b=ZqXFaTgHaJyHQ12A7L7RvRKeEzuS5ChjepL7Tho+flc0uznkJDC9SZBlM4eAfvoGTG5JqiiRhh1shr5C/H0V1nEpwWKUxoPx68aAB1fj/hb0obca63JnzeAejsyL0Cc5brtJe2+wHw7GE+ZvZU0gIBq6s5NDNogCJ2qxp7YXIPklgPQPqF21Itz/P+GEnuUJUj/r8ee9amXBCmpbD+hoFuQGq5wevnioGg25gsuScyJ+SUAwI03RnNUOqmvOHyrFi6m1ZCBfBTN23A5lON6Bp83KhzuDoP2U7i/KrHBtsfwXeBotrG7xk3uTWAYISW7ujYXTzB7eEa7yfEdpjvmE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Fri, 29 Dec
 2023 08:18:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 08:18:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
Thread-Topic: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS
 capable device
Thread-Index: AQHaOa+ijMZc2uZ2TE6tTm1L7128uLC/65bQ
Date: Fri, 29 Dec 2023 08:18:50 +0000
Message-ID: <BN9PR11MB527685C387DDD5FA4B189B3C8C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8319:EE_
x-ms-office365-filtering-correlation-id: 62572adf-ce0b-4e20-1509-08dc0846c9df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cq/Us8qkWhRgiujY5xobbkEvvyu62X4tKvpemvn3JOiGnXFVPzVWHSUyew37t7QHYA1e1qwcmhydo9zASJ1YuuR0nNfCF7MzV7ROeZsPEhbd8BkTuaJXm9+VdnpQCt7FhrD390nnG7/W7BMmfzsLi60OAJD9uQDLIbxETJqX6SCmJTFc8CP7BKKB0vm2bo5BFjBaSetopQov5Bob3PmYCPI8qgbRBtiIqrW6vJd5VFjnvGVcbvVVD8MzUq6dRGNxl2YLMhdt9s1M9DzCH4nsWx2F7WrojxIwMoPlTWw9vdezJkFPKgjrV0f1mA/L/5hmcDSku8cB1U96WkIspWpGzm1+ru/nTRRlc9S7iBfnO7UAlml/8fKTQsQ/38Yk/AvMf9Li4NFH18sc27+jjy2jxkEjYQwvQ8rAVuJ+ptGC3XOHNYO9s595AlnBTPdjGQgbTm/5zLh5v9pxX5tegwJCG7RPlGuBfsVot2qJn5fM3wALxAOLDBw1ngUjA7b1sX5KkKhoDQEfnMWlPHEMvOVFj6pJefie+MUCBMq4RphbHw3o3o+G285fs/AZQmt7cXNevFd85lcH5VWqZrSWa8xGRWpB1rX234e98z0/7u5Bl5+YbekMI4AN7twfWO0+If5G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(33656002)(64756008)(66476007)(71200400001)(6506007)(9686003)(76116006)(66556008)(66946007)(66446008)(7696005)(38070700009)(86362001)(26005)(38100700002)(122000001)(82960400001)(83380400001)(54906003)(2906002)(8676002)(5660300002)(4744005)(478600001)(8936002)(316002)(4326008)(7416002)(52536014)(110136005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1zXX1qN6GCNxWq67YCtLCFBEDWa+V1TuuUeDoiaT0YJAwpzTUuEhZ1rIxfJ/?=
 =?us-ascii?Q?GpQfRnGoperJiSqg3LYyx6d2hhcAM5RoMdW5UpQxpK4sWHD6hUcCZXHfk87T?=
 =?us-ascii?Q?xSwm6mPnM63fBrnpAkq/HHcpTBpJUqHako1gSZEcjq8aGuORie8GECSXp927?=
 =?us-ascii?Q?qZAunRzNBkIi8ZHFsvwXvnndGir7dSJoZVjPUxt9bOELlZSbZoObed7nCgni?=
 =?us-ascii?Q?eErPvZcnZU7SNZ6tEBdnrlBkurf+PUz5x3GOV9dCswDWbRWvGv3sz5t4v8Dw?=
 =?us-ascii?Q?OWk1Sy8LmoUlH617PJHHP731rGAOT9kWG7XmnGeHBQPRR+XPF4xi4EBQq1NF?=
 =?us-ascii?Q?Snveknm2TazNOPBlbFrjs0txTa74SkuDBznTllySVPi3DVlgCYLHTAKnnU41?=
 =?us-ascii?Q?bnc5x28EqfgoN8WdK2VfHTXuosPaX35Ku4wqQVtsQGunpQLp3zRwMy2qqK2Z?=
 =?us-ascii?Q?TwgvodmlwOGaY5lsfjkVVyvnMWMWoCwxuj7hDAN6gU35ldnlX1eGi88NgOCX?=
 =?us-ascii?Q?FRT/KncgALRgsEaJTRGfWoeaOXaHCLM5Ih5dLhh96vJ0IjASmBXmzBZtwuF1?=
 =?us-ascii?Q?YHoVlIE3JNWFWrtgkQ6A2dAZ+E9S7oOgNjaUH5ExZdVsKqxn03wVhjXeZ9dM?=
 =?us-ascii?Q?PFLffl5cynPCDsQLkHBmU/UXmmASt2SM7g+WmcnmGwTTViFh8H+6SLKro32z?=
 =?us-ascii?Q?/5tKE4dzYXXnT9pF4udq7fv3jp+0iYQ0wBlFA86h73CCcZKdzheza8NDXds/?=
 =?us-ascii?Q?HyV68T3lt+5OYr2bW2lYDxvBZzN+7lP5SqXgMues6KEKIRe7gAamzBxLa06S?=
 =?us-ascii?Q?A7CGazujy7vQIeSToCxoUs2JYSfJKLcmArh9CTfsdvHBvwfjnfpYE6/hqOyD?=
 =?us-ascii?Q?/RLaU8frjiIf+igacrgHq3dPrDWMCu9qqyQf/pG4nKPewHnSzSOOAOBIUL7K?=
 =?us-ascii?Q?nLGOFDKzakaYtE2A7tNf+8ssQvf4B+1jO14VT4WUXxk8Pn2Ojnr41oooKzdO?=
 =?us-ascii?Q?uo8PLlR3ja0E2VVH08jOUAZ3LO6sAcaa3Ed1Gqs/py17ksJM5qaGKtWExdaP?=
 =?us-ascii?Q?cpsTKGHNBFL75ZK35iIlNcbIDC+Vrmf0AGXlqvU4xYlFgk1VF69I3x5Plluj?=
 =?us-ascii?Q?qzoMvToInICeIsIkGmTwbLA9KqALKfxEecotQGU6aYpsUhyI9zT+Ezv9HAG+?=
 =?us-ascii?Q?mcCQ4qrz2e8UUGF/ZgnFQ2tQBW9TY0c/ow/rSf7Z46TCaBM7cM4aZJARUU5d?=
 =?us-ascii?Q?3Cwwz89x1Hf7RGZ7aUvLV3jbcOYWV27JG/MTLqGl7qxOz3QX9x0DdcwlDi7S?=
 =?us-ascii?Q?YPDQzF/KAzl17qVEAm0Z2Os5gsq4+8nNIqYikz0EXQBN3G1ZCFpChhzAxjRR?=
 =?us-ascii?Q?++gv9I8vzXSTQD79AUmF83WeyHWY9/0KrQNMCOJ250XC2ekmJSmk+1VsBzl7?=
 =?us-ascii?Q?LsyVd8U/wnamh0Xvy7NbeXvdp7xQe22KFID7I3ibCXvHLXj2P7e6R24OoiIk?=
 =?us-ascii?Q?m4kw7bZ8Fagx5rWxB4VlOtvAn+8uPGEOruJl/Cm1TvcU+xqLaKjxaZ+Up/1S?=
 =?us-ascii?Q?Rt4p52jmTPEK6Bnw1ryt0dTE4LHN6z/H9KGIKT+c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62572adf-ce0b-4e20-1509-08dc0846c9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 08:18:50.7033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9aL8o/GKj6/goiZz/r0mJ7D7u+kzHTtbJQ6GmtVyPup9cD6jaDSzvA4UF/Of+/R7nDtl2l7LrFwQ1JPobGFqYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Sent: Friday, December 29, 2023 1:02 AM
>
> change log:
> v10:
> - refactor qi_submit_sync() and its callers to get pci_dev instance, as
>   Kevin pointed out add target_flush_dev to iommu is not right.

let's not rush for new versions when there are still opens unclosed in
previous one (and considering most related folks are in vacation).

