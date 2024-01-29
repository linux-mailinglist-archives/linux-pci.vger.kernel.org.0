Return-Path: <linux-pci+bounces-2700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7617F8400BB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB51C233FB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F354BFB;
	Mon, 29 Jan 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFT185nb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F354BF1;
	Mon, 29 Jan 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518712; cv=fail; b=Ws+wgjsU47jXSj35Ga9TtSN9hzcf6J8EC5lKMMpdSWtR5Kno8YXLkQPwj4BwGcaitMc8RuvBcUD4gXgJH+DWbuYL8KzIFj8R97krcMw1+QqaoPChOQtVFKS3jvbwo2mAru7xQJmLACz1wjwmeL4UbDXmOSasjNMXL/mboYvAw0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518712; c=relaxed/simple;
	bh=YQI9P5X1aHkFEtpBl6zTDcofh/kTGlx4ZuXIMpyKwKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ebU3dp9RjXnFkBmC7BwRcl1NogzY1j1xCBAVpPTj86xyKpgeLHnCvnJ5E4Q8/iqSxdXAg93aqs1AgKlmQH9NatVHZbShZla6dFuDwZVPjjy7jetTAc5vEDheNvgAEdR90oqbd4K845ND2t5xlXWNP6CEQctTwX148SD+CdHIZs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFT185nb; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706518710; x=1738054710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YQI9P5X1aHkFEtpBl6zTDcofh/kTGlx4ZuXIMpyKwKY=;
  b=ZFT185nbQz7nLzjIs12+H3s8G6+IFv4up8RVpC+0B6wmsM+3sWMhstxK
   zwPz7P7JASsIDGB1VrTAFi4SzTAmSX4ins3ZDJNiXU8M9FNsUvKtquc6n
   fngzkGxfT9PM49bPA3cV1FKe3J8lar39m2fzl9cAnG6mQybV3AVIGcBpw
   BGk5120wPD3VPQG6pI0kwTO13rRNJcAHgxZC2Hg9AS3555HkhoDf8Cm2l
   1c/PP31IDneC2HPTQZKmMRbYfq40/TQsRc/ZTZEJaIX7wpPkiTqCGmk1L
   q+vgeyj6bLQjXVMsKliLbg+lXos8qp9gP6WasEEcw3ucYB5NmSiiQzB4B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="434058140"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="434058140"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 00:58:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="787770083"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="787770083"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 00:58:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:58:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:58:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 00:58:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 00:58:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im6vrCAqWaIoJhVi9t7nkURCkykL93NoAZabYcdbywR4tCNI1U3pLak4Kl02MKOFP+TZQlmp8dwy33HGd/wDxVkK5MELaYjVKk9pZlflZzMIrY5hGf0yB43DrRwLqkslSoAollJLA00KmYUqj3WtQIzpPnWCzrV4Atp2tm7elJeMfrJHZ5N86scfLS+YMKRL6/7kUWTBimoOYrjJfenDOpiMfdWNJ5/NbZWNtKiWigzqVi7K6aualAzzs9YXrRAZibvr/yMlO66Tr7G97lRYo9rIDPicY5DekcaCcGZijyzAqUn9iJ7QKMD3E5IgVcMPqY19j0rJnAgjDmDZ3kcTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQI9P5X1aHkFEtpBl6zTDcofh/kTGlx4ZuXIMpyKwKY=;
 b=FGD8Ow6qjqYkyz5D98ybpHchcwFXhGGsUaTSy34pOqIAWcuAHzMyirGzf0ZCN2BkOH6lYa7Tkucrdd2ex+B8zoXOQmZYjDPgZjLRqvjl/JYCD+RyLp1A8izbdNlZIb6k0CZ+VKZOpJ6XI3cZYto3pbb6ZtYWBXVTTO7EpCMtpxVF+/B/hTsdIjWtBkIvs7CHG4AHg8ByLWvCe1FlFMHVbWNlS9XK/oz8q1mIwsPMMtpCbV4rbPCUKMR6QYCprZf4yysCZ4qxhyDiYFd0f+p+4K/ySFldAJvyX3K8Ju8rUdyYJYE2dle/rxmyujlov4tkN7eP6eAp4gK/uFtYA1Jh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:58:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:58:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v12 4/5] iommu/vt-d: pass pdev parameter for
 qi_check_fault() and refactor callers
Thread-Topic: [PATCH v12 4/5] iommu/vt-d: pass pdev parameter for
 qi_check_fault() and refactor callers
Thread-Index: AQHaUmY5eqmy9MTTVEOu9HWXN4k20rDwfKCQ
Date: Mon, 29 Jan 2024 08:58:25 +0000
Message-ID: <BN9PR11MB5276BAB9620D3A7B07B24F328C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-5-haifeng.zhao@linux.intel.com>
In-Reply-To: <20240129034924.817005-5-haifeng.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: d94ac0f2-c48c-4284-6c62-08dc20a8740a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kJvBdqFfm/nn7ryGdXIqAgnIsn6nMEDsAHvzHMIgRFjjDpMUHZ8V1MmIVkWR6ejKHGmAigSyJykOB0Wi1Dfo3Mb32Q/BUp8h/lFrMrMtnRQN7YA87XHtmE6WRFRF0GCkKshH/pOvVsecHpyq8Y1hK/d79XO60tMTcV3zfiUnhztGa74ZvvsYI1QXyviphKBylHeqIbgJ2y7bSvWQQBUSlv2bLpMasYyOxwerD/5KjuN3+w6e66WyarRb9PWJwPBaKfCow+zQTSHhBA+keiDsa+SBby9ZsGJouvOd1O+vWWuo47H/29IwBSpnzstzs0YDGTCFASuqP6ww3oZJfNVl3MTgrisc3xO1zNAG8hxdGZTrMeUCfWFh5CiDWa/nAjybkX/YZa0WuIlEvq6WLfngMcheDEqRuUO71tW+qqOuU+s2qoPCTeOupxJBx1xhrMLfa5t39RiIfyFwQcirWUERc3NbWAB0CB9cpkm74v+XJqdcFihDGFPrAk6F9QXofgs7Rvl+UbKSJ2x7hY6CxO0wkQSpSiouTNCvIPKzipfLXInTkWPc4gba8WoDfNaTk/DWsO+a/hf/GxYuVhSmZeFnofm+MR9sa81Zhgu7C8x4iltfBtuYFMS7htIiO5VaYMa7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38070700009)(55016003)(54906003)(7416002)(2906002)(4744005)(6506007)(7696005)(5660300002)(71200400001)(9686003)(76116006)(66946007)(66556008)(316002)(110136005)(4326008)(52536014)(26005)(64756008)(66476007)(66446008)(8676002)(8936002)(122000001)(38100700002)(83380400001)(478600001)(33656002)(86362001)(41300700001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jkWMqW8PVnvtBSmSBaXoCEnxyJaw52WY88jGdV9Fe8dzh7TVFTEoyOcbqL97?=
 =?us-ascii?Q?MWT1nHWaMk2i7IODeb4erB6szl6MfvS3yZIPNm+uyVyRKCPbga9obdfg3Rk7?=
 =?us-ascii?Q?wW32CMsjJsxibbO0gIaJ+7bclWlnVgnmirj2iHT27iGuMQa3uvSJtHEqqKLj?=
 =?us-ascii?Q?6S1KUoxk/TM6hXj78Od19/a/No6KGhRWvu5KnpxTNk7D3iNdcFaSdZ4r5aJo?=
 =?us-ascii?Q?OV9K22rZBjJ0bz3fOJaawuW57wzULf75CArKNb0qy2FskgP97cu6zQg6h6h1?=
 =?us-ascii?Q?Lq7eMRUQw2VbPrYc58N8M4si5vpU7VVFCuSJr95oT8f0EQxpfctRC2V8+XmH?=
 =?us-ascii?Q?Aej9W30+m9X9tRNmT2l3DC8FiZ10GN2etObnvCH/DImsdgxkZOgaQ0yeUHJf?=
 =?us-ascii?Q?/N6exZ3z5ErxWjeuPyB1b7h+hf0/7+BhIuDL/SfcU/L9FbkV+hUGZj1zm7n0?=
 =?us-ascii?Q?Zuqc3RVCuVQ/WhwEWqnP178DMw8DaiHvjOMZLvVxqZIngguVgyyNENrGg6DQ?=
 =?us-ascii?Q?cT9XgqXY6hF8Yr3oxX31d/XrE43yhsiMTtzS6jTZfONScov96vrftoEljRns?=
 =?us-ascii?Q?2DjuYrqokkAVaapF523n0YrBQLG06drbslGtYQXr5Z8CILC3cab2/HtR12+O?=
 =?us-ascii?Q?v5lL+ejZ/CvE2smEDkLCj4LMpP5lK4O+1GeXXkKX7jtFXcg9z8luJPWUC2Wo?=
 =?us-ascii?Q?ewYzfjgBqq79VwuffvcBycE5mWVHJlLxk9DKVtGKjlc87GvD6cOs2AL/+5vd?=
 =?us-ascii?Q?djwavSybW93jRRYeKRNiAfvI/f26En0Z3cW7CE9dFoJIouxUfuIEZolxzX5w?=
 =?us-ascii?Q?gHf1J3pxBXKb9OOMiq5QqdIxHnvARMXSqZeKIl0MsU7idcM1he+8Pd51G1+Q?=
 =?us-ascii?Q?EHaggwHOKz0Nwj8qMV7I6pptO9y7L1HFuve7GbI2YZswKktEs4mIRmp0WdPy?=
 =?us-ascii?Q?7AfU3Gz1OYE47LhPqdHFZxC95FWIh3sCuePQXhyJTowteUgGfp7jhf59+Ld3?=
 =?us-ascii?Q?G7zqW02eNGsJPbPpnZIMOfLhaCTuj5tIDj+B2GTAMSlSz7/QGtYq4fybUKHK?=
 =?us-ascii?Q?gwCGkxOmSGgRFJ0bleJEeRXAHMVh3BsPYz62F+/JMIxUTnuyvXIelzNRyM7C?=
 =?us-ascii?Q?J54FOQTWdJswu/KHn+1OZL5DbSzETUGuYFABkwj9Kz85nltN8s2Z9tkfFk8l?=
 =?us-ascii?Q?3qKaeeaL2nGv+/TToPhDk0ZgE7Wx5i+d2ymWLNl25uMo3rVjlTWCchaAaRi6?=
 =?us-ascii?Q?uYyLGiIiTqux9XgXqKtGAHCzRH21XsDBs9ZRoqrVtOaiALYAwT/HWVKZO+Oj?=
 =?us-ascii?Q?VUZM/hDJY6Tf8V5Xgad2FRKm9DvM0MUz3+sR8hkwUkRMGUO2YhWnqwnfItvB?=
 =?us-ascii?Q?9DQqvqwaCS8yZufznTbt1qxBWs11T5fvuOXVzullzkvlszD++lR4dz4zopog?=
 =?us-ascii?Q?Gk4Lo3AihFb9P+2uqPRaB3tdwqhhzfxnSm76GYKKNOCIcyHdZe1+cTGErLIa?=
 =?us-ascii?Q?Ddoiq16ZNYqhFvjS9l1vX0vvv17WKIT7la0P0a5v4s81Jm3iyXRgZ6D12Abr?=
 =?us-ascii?Q?FOLdj2oNp6OHjr07U1Q9KkqNmKwfU2WKsO5PZ30E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d94ac0f2-c48c-4284-6c62-08dc20a8740a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:58:25.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K1B7euw/y1bUJC27nAJatY6QullrHdBgdHY4re0TkUDH6bTAKjGTDhVSmx7dboqpzrEaombLVB/PdLeObMU5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
X-OriginatorOrg: intel.com

> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Sent: Monday, January 29, 2024 11:49 AM
>=20
> to check state of ATS capable pci device in qi_check_fault() for surprise
> removal case, we need to pass the target pci device of ATS invalidation
> request to qi_check_fault(). if pdev is valid, means current request is f=
or
> ATS invalidation, vice vesa.
>=20
> no function change.

qi_submit_sync() is used for all kinds of iotlb/cache/devtlb invalidations.
it's a bit weird to see a device pointer (even being NULL) in places where
a device doesn't even matter.

having a new qi_submit_sync_devtlb() wrapper sounds cleaner to me,
with an internal __qi_submit_sync() helper to accept a device pointer.

qi_submit_sync() calls __qi_submit_sync() with a null device pointer then
non-devtlb paths are intact.

