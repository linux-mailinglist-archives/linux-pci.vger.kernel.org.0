Return-Path: <linux-pci+bounces-6105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB528A077D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 07:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D79C1F22F23
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 05:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9713C67E;
	Thu, 11 Apr 2024 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itQjtcjN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1D13BC0F;
	Thu, 11 Apr 2024 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812404; cv=fail; b=K9YoTpiCJ9WrdJgvjIQIyBtn+hwpnmBChyzwekDht7UbSE+ZEfUNo81mYIszweKz98GH6S7WRt7ZtomIZUXd9yy+qMyemFGVpRaWGbtRiNXhaq4AyfS0evSH/AwJHRV7mrK17NS9nor8zIHC9lVrxviUmwfcB1h98nuxpNVHdPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812404; c=relaxed/simple;
	bh=m/sT2DYO/EBDSCmJcU62SrD4mdhPTeIbSlUPxnDGn40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXXxm4mTpmFKL3xfLOeLcd4S2cKjOJkiaAIE3LCxr5HxVH+vuL5rQqEKosLiE+aHznp/3qep5UjdAjlyq2Ba9Z4k4UystgBpuDH2UYFLJJDQPRJvjmtVfjZsh7B9Q6KPZOA5RFJ3FH9wDW1P6MIWbIbGOrfnqztUuUFBCXOeyZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itQjtcjN; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712812403; x=1744348403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m/sT2DYO/EBDSCmJcU62SrD4mdhPTeIbSlUPxnDGn40=;
  b=itQjtcjNKdBoXu5l3XnyXGY5cGZu+3kMWVN0W7mAhxWtTp4Q3X1Dyx8s
   LvjU8U9Pp/5jmli5hOFBQYy/v74f93rIZ1oHVYVmsEYhv4yiR0rnkcCMN
   QdWZrInejCekvGXXKgQOib3qHLC2fHLFra8nX6sY0keMCDWvvtKBkV7VX
   XJ5qWdznC+X1od8iy9kYx3CgMlqVQT+TTugAQWJyCHBA8+o3/kfXqFaqP
   UhbWzyQkb5SCATzbUpUXOXbcGJ74UXMcwBYDIJa8F+2Dgqd50Q+hFr5Ab
   zaqzTr0vzIZXT97UnMuALm/f+oxlw78j//UNPpTa0Llt8vvkuyOjmtwuh
   Q==;
X-CSE-ConnectionGUID: KE+p3h2hRCqaPbc9n8pdFA==
X-CSE-MsgGUID: wcIMS6ePT4aruQRyHo1wVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8121458"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8121458"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 22:13:22 -0700
X-CSE-ConnectionGUID: X1p+z7XCRoi7pbhoZ7CgNA==
X-CSE-MsgGUID: GeWEl2FrRUOVCxovHrKGhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51982199"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 22:13:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 22:13:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 22:13:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 22:13:20 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 22:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL4htb2JoyUCk/YBLmZIu+LnImUD05RC0RCgPhOCepntEWNsSxSK6mxjaLb8vXopB2Uyv7JyhI3NY/9T5ARhpdGOjvWqc+/yCauA2shKiz5PutjJpo3mJqhS96zpEQ73v75FceEQQaIH2eQ2sW+GuDM17VZmoS5Sh4+oqViMErGo3hjDMhDxPRk9QLmX3V4ENKGWB9v08cc4t29J3XX15KhcuGGhp3f2NPlLkAnYXeU40c7bDg6aj+2LD34ZUcOwns+SJqBLEcwzi5ckoh70uGxTPIreVmKJ4VASF3/q2/hdoSI2ZEi2hGKnqI+NKqoMth7hGGhK8yFyNBRS895Mlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz5VOu+P/PBQIyd6OHaBjbsmU/R/mBhUpDk1mSTZqX0=;
 b=alkIRyzawO4+b6Mb/TcGl/WIy/zqY+j9okvMsWOoy0y7UtuFkGvFDh4WLz1ckN7x/agxnC89YXjrW3KcfHrEH4HRalh+GUdA+vnka0UFmeEJ1Q/1SsoGrlLwXcWfVCRmozd/C+dFBhjRCFQspp1Bhev1tahgXHpRfNhIOWou7DkEl5RYIy9r5woyQ5Labm8lEijOxDxs7grEsTsGyr2bFZ5OtHgaZWf6eGqoEZ71U5GIkXqyV1g+0f7rRhKiUXNHNopVz04SY4miKCHyxvwOWV97C3H5S2I3ndim37PYV79pPCQWb6yveo4jeVHyGQlqrT9V+aqs0WGC2sneOzsR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7789.namprd11.prod.outlook.com (2603:10b6:208:400::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Thu, 11 Apr
 2024 05:13:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 05:13:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Robin Murphy
	<robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: RE: [PATCH v2 5/7] Revert "iommu/vt-d: Enable PCI/IMS"
Thread-Topic: [PATCH v2 5/7] Revert "iommu/vt-d: Enable PCI/IMS"
Thread-Index: AQHai5RYCSVcdBO5c0a51h+2jMjMq7FihrRg
Date: Thu, 11 Apr 2024 05:13:18 +0000
Message-ID: <BN9PR11MB52763A9F7FB464ABBFA39B9E8C052@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240410221307.2162676-1-helgaas@kernel.org>
 <20240410221307.2162676-6-helgaas@kernel.org>
In-Reply-To: <20240410221307.2162676-6-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7789:EE_
x-ms-office365-filtering-correlation-id: 77c870fb-dca3-4519-1e01-08dc59e619c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9AJ8TgPLdGol4/4SJ4BLXO20dCPgv97P2yIES4pJerQJM7UWDX+Rjp7ByN0nrL64DiK9ucjrQdhFS3WBbh01pF2bZv13kWTjn5zkCDeGPI8zq84lH0au6UsvPoiugNdp9AtOgVmUqk9m9tA5PISd9+Kq6cgJXJ1Enn+3dL5dZzShC7QI/YFgJSoeTrNRTxUDkgxf8ACbZ5TWg7BCQrPqUm/klecnFo1VcAuf0Jqe2OXZ5g5BGBh+cUycaaHApNUYpm0SSzktYNGoTBGDqolAF9IhoGajcXnzslIRnGuNFsxS8sCeyGfFXfNWZ9M5QbBsGoCLiHShX95cUIKFiIF50qY2+gVAfz7Ih/vpaoWU/w8VNog4IhMWgrSw7smtl1sVuUXvA+dNbDf7kZqgofcry+9Hy1lxxyJil4jtvyka4oxN2GAgiftWjhoLDrWEkfI7+Bf77aR+uTqBwzOIecsbkfxhfwz4MdO1lCkD2xfg0C2/wMR9r7ilcd/fSC1L8vXqNDM2Bd+DQPba4UuL6Aeoj5EvqRlA/qkxGK9DknyC57ChNBVJRsseJcOmHH5zfoqkRmzWxch0Uc+QFete6nlFLTL5s2FcFzmK6Jo6ixCm4e8VE+aCAHTTal2BdtFJgq06a6VVqd1dVGebSKropNgdGbMI/eDdzecO9qCJXAmCz5fUax7QYGndD3McUY8+V8sRjZAIl0JNZ9cRE1Pmon/BQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nLjjeIBd6enINVlvEJwIhSsxa97FJEtbNDW55FJkL0mGGp9NVfzH73N+c+DG?=
 =?us-ascii?Q?oHpV3d2PliMQc5Mb3KOWgDoT1693DFjncm8UML72P2CH/5p6bFHPkZeD6Gk4?=
 =?us-ascii?Q?2RWsXaXdASidqYGU1RZJWmTxiB0h2bnG9AHKFNquiM8qtSme1DxuPPGaCIkV?=
 =?us-ascii?Q?z6MnqoW3bhR6zmWqrBxqdPfpctEq5cJ8uXunC+bMTjphF4y9sba+CrWFscVY?=
 =?us-ascii?Q?QDd9BV5hrFTrHdU167j1NIkLfQpehuXwNAcRg/9DR7KoYNiMEdEYUpAFe/Dz?=
 =?us-ascii?Q?x1gjbWHH5YoB63iYC/9qJotS/U8ZPVBSFB6PFozovY7jGu/cqPvrx4A/deEG?=
 =?us-ascii?Q?Tz5oNZh9LC8x+/G9V3lIi+SbmnVUbtcQDV/Ao3rl/tKOSq5uAOpzrJeTf8zc?=
 =?us-ascii?Q?+KJ0A0Ilrzmto5t5YqBXYiFpacATMhrK36/8Uv8lTnezRG7gq480UHp4EcQ7?=
 =?us-ascii?Q?8IHcGEc6uUfjO6Xufv3uuVPvlIk1IyZt1tUc/vQ39wwTZFFO7wJlwWQ+cNSE?=
 =?us-ascii?Q?XfeIF6NRGOiz1TiIA9nL0ymJK/4yTKHdiIuMWO21x7yDvLN7m7f+u+I0GW8v?=
 =?us-ascii?Q?IBKSRVmvqUY/9QZcFp7wsU0BzMeJ8VZLrDJVTIDBRkpiwu1FEoYZ0rdK6TqY?=
 =?us-ascii?Q?FKHFDmBAgDvZm9KPnIcSgFfDIO6URPHL9xJEVqT4rBX1STTVZULM5/SXTLgi?=
 =?us-ascii?Q?UQByi4QadLV5KyqiUDW3k5+6q13e1wBpbTOtcY7IRnCWRwlZzxnLpOIdWJPL?=
 =?us-ascii?Q?iBff8ermJ18GwbSsvWR7VL3KznLnAwqlGk6UZ2kulpUt4gQ81kTgMDGca410?=
 =?us-ascii?Q?hd83fpVJPUU0vDkeQvjBBWcL3n15kr/G190PJ8AO/DMeJp3DZ7uQUf9Awk+u?=
 =?us-ascii?Q?YS4u41PQ6EnAPAHPZBjxQYpXKrvX1ZVfHkb5eW0RtfCHEa3MgyXA/4MSemBE?=
 =?us-ascii?Q?uyqHkzytaHlO3R/IfV4NJ5ZbB6NMM3R0+iIjfVKuH04L8r8tjPB1TMAurOqm?=
 =?us-ascii?Q?AzOh6mfnBsJeBJvSJk6S1M6wsn7tRxbSquKHqur3djHssVO7iT75MIt+Osdz?=
 =?us-ascii?Q?bGUnwn7OzYy7wJJi2YdjFxW1qk6yjWStOqPSsxbbBtQhMm8uNNv3OAaDP1Ex?=
 =?us-ascii?Q?2+8Mp8mfxfsMLmce0+0PxN1HCXsCK8czhKTwqIQVHA5MWb8zPq/rYLQi03qb?=
 =?us-ascii?Q?nTpgv80SNUIzLwrMDwn9es7sR99kDw/O8jDCJg6B1y5j2obJfeYLozYClBYI?=
 =?us-ascii?Q?HQ4sJJH9ys3qXda0T4HZyPNl25GQEYHPJQl4CWaHfzEgCKtjcjUUIvD8LCOm?=
 =?us-ascii?Q?nh7bWBWvDCSCf8VGa/3GRlaBvWNGlWmGk82E92QkH+Gix2gdgkE4/pRq+dO6?=
 =?us-ascii?Q?V05AHAwLkR3ZBLmdHH+fjL1XhdHqOdxWjYEKNXGZs72PKli30V+sPC3FLaTi?=
 =?us-ascii?Q?MsVit4Y1oeL4L7bvXw/EmWK8N96tR+V9kewRAZlYVz2Tc8TDegraoKPyiWQ/?=
 =?us-ascii?Q?rZWCimhVVdYLPIv1oJZs3V1YyGJu8cTms+gr1VP4W4DDPcWL313H5JuhfWe9?=
 =?us-ascii?Q?AjRA/kTQaxCmNGZiMPmyM/LWiqvt/Npbo/mAs1GF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c870fb-dca3-4519-1e01-08dc59e619c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 05:13:18.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsMmaNKE3/zikl+EXJg/PyRTvKn0H1CCwkrSsQeslNVt36hkOtu9g9AsEhFeUvngZkPpF7vVUZ+SOTedPlX+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7789
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, April 11, 2024 6:13 AM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> This reverts commit 810531a1af5393f010d6508b1cb48e6650fc5e8f.
>=20
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
>=20
> Remove it for now.  We can add it back when a user comes along.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

