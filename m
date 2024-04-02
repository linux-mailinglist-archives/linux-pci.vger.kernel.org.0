Return-Path: <linux-pci+bounces-5510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645F894985
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 04:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10D4B214F4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40C12E63;
	Tue,  2 Apr 2024 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1bAo9oi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB7111A3;
	Tue,  2 Apr 2024 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025979; cv=fail; b=WB4+Xg9SItdaGI4Xh8oygp93AJYybApB9J/bRniX/MyxZ461jpVPxXpogPpUtMoNIliCnRxtiVOHxUWCLdLcecJTQbIVu/jAy35rOeYoLZp5y03AAIYhsmRzjWBk1g7L09KJT+OCUUcUJwBsc+a3yUP5jG3J8/39QK0DS7k5eUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025979; c=relaxed/simple;
	bh=ZYNcWGJy0VOFzFUCWgXNkBcYGDeLvMtztT/hK3D4uz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LJyf2Ayt0aWZbYgBLPMKlC3ebn33x3Y/aAHg0s4m+r/buOXMbEaIDrHFJv5FlSwXYvq2eFSCKNjqsQAa/c+AsJ6MVbNCqouIhrvpx5dZYg9oy0XlfSFVezKC1QXMor5RJdEBGXundEPVnOXwsk8IPiqNby4Yqg5imHpmka58Ab8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1bAo9oi; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712025977; x=1743561977;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZYNcWGJy0VOFzFUCWgXNkBcYGDeLvMtztT/hK3D4uz8=;
  b=i1bAo9oihP+/VEIKoc62dL45wwJPyNwtVWWjsBskp+6h/8aZZ5zRRFbR
   eh4eeJNvhMTIltKepS4MQEsc2aF3cQQD45CG4A6WHvH4m3J1h6b3CePkh
   wWZDSEFA1gjq8RgtHkzZOgEchBOY5G7OKx1DW46D4Fc2I8BNvVJarn5yQ
   bDgLc2G8QLQfXVP5oUSbkpJio725JapgFOs6Me68UXcsnZk/vHi5Kalho
   fayLWP7a74k9/YoLhE5d/wI/eRKVM6UvatJkXSDmU+I3DjKntHGggQKkt
   q2pZ07W6QmALXPoWPuzikMj4ksZ8VkvlwHQEUl77A9ma83TkJTKhMG1wb
   A==;
X-CSE-ConnectionGUID: XRihovFWREOj3YYxyxBTqg==
X-CSE-MsgGUID: oeSjWlfBQdaw8jez7hSpww==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7075046"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7075046"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18368013"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 19:46:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 19:46:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 19:46:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 19:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWAjOkw+2+v1Fg3Gw2sNDSGzSBpkysjZ6gYIX6+To9vJmmLgc/ScnYpOHDxQNhvDTAKahKEa+I/Lco+oxaJA448kC+hpJmmbVwccn6VrDD+OC++M64Y23BqFkUN+D3A/Ns8XOeXTfClbGaiYDLzf8y7QttThzEu2cesDpVSid25d2JLkwwjpAwRiy7dYn/5T9m0ypeZe5o1BIbHZpsWjhd12C1tKUoxpFBUGnZKj04pvKi//+aQfl9cYRKewG+8M7ai7mAkHu9OWPqGES7r4c1oTfmzhhEU0yFAfarpsIFE/lf8JXeRL+K+7YrjR39yBJIDs73b/0uVsekeDq9g/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbqmBZWd/kYImXnQipJTH+yuDdkROFrNrg50mPD+hs4=;
 b=mtghyP1WqmAUCMs5FkP1GsfY7O/sddE6gYnl5u6KPstX+n96qquQznbOegfWJlX+sLsl18HeCy1ZLfqzL+ZV39Mi6ObRHDZsizUZXaQAv0xIWfBpAoVjn8whrdGrONNzm7J/QSRQvMoQIa2pCQq7gZgH4dGjfh9O/CDSQ6KXiVz0SwkN0EdTAjZ79O+FZuGWEeZeWEJ2b/jKpVCcFoeut4VGpbLqjMOYg8iE2z70ySaH/G2P3T0K9Q2SNrGbO5RPzUmQaO1f7E7zu1wh1/UOiYnXcdbAuVePLCBubjsJ5ioHkFHXTrR6j2RIJu7wmIyj2sYELq0pGiZZODQUEKnubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 2 Apr
 2024 02:46:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 02:46:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: RE: [PATCH 1/3] Revert "PCI/MSI: Provide stubs for IMS functions"
Thread-Topic: [PATCH 1/3] Revert "PCI/MSI: Provide stubs for IMS functions"
Thread-Index: AQHahIumU75Xk3lI3UO+3HEtV+zkUrFURq1g
Date: Tue, 2 Apr 2024 02:46:13 +0000
Message-ID: <BN9PR11MB5276EF9072D52400B11482B78C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
 <20240401232326.1794707-1-helgaas@kernel.org>
 <20240401232326.1794707-2-helgaas@kernel.org>
In-Reply-To: <20240401232326.1794707-2-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6515:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znezW9uC8TGB5SRy8ua8Gqwf4Vtktm9tUhyMj/xnNQocyw/xWUXifOM9stlWkCj0d0hNeRJ7uh9koeS1cD8cST6WmNbh2U7vjRjuYvVnmdiCt0ZTycLtTyOx2dhVgVNLkujBPADFh5+ri3pUXYNibfLRiedC/iRruhONB3CFKD9xymHPtTKj9dmzINz4cw7ACcBslqn0ZytPrWuDLClmE1A/J59vRq9fhHomFphjn9gwsFv6q9c6zYtNZvQ8oMsvDxOM118uHTm7aGXoPq/NT+y09D6O8ZnpW2L5nBPcOb1xFH/r1RTvH2VRyDvKZkpO2OllaO2nQBcKDmoRnDJfth4OSmEg7izKl3DO6J2dwcLf7PGaMff4Ap/lvCcCZG+qw9L2Aqc0uwThMHHuk4vhi3XiP3GPIBI8cJtzd/7xj4O/pQeq9oSXDgJveB52L5DVLqyl+vccQgGPr22tdiLUMivULkvATbHWWPplTaoSLa6Wzb2j9POpD2vWh7j0MwEGQX0x9anNAFi9BxHvXwiIjMSYD6c00R2DdO27oH0m2xWfZunl0Dqt/iR0vkJfF8iQRbHLnxswmrMpaXCAmUaBNXAs50EyFThfGLYM0vqa0LUhSQsPPrgfKLEWb7o9iGsgAxkgGmRIPoFB0Il6bmCX0UarzYfREYxxpz+OyG4S53U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4W+pTKJD8zt68UVP4QYdcNZA/CCtbyyusH7sTmz+ZtrqYuI7BTnNR93Jy0BG?=
 =?us-ascii?Q?nNGqFB1CjbAZrZlbFc7z8GQsPjmGEFx82KuUAP1KIVyLH/KcckJ/VpVsNw+Q?=
 =?us-ascii?Q?FIOtm6PPl8/mtFXru7CIIMCaJQ5CgyuD9UOmA1LBZp6c2YzpC4ul8WaThY9r?=
 =?us-ascii?Q?+18V3nsxJx3vvSIiW1rubv5YcGmyuGgpYfQWMzfdF+6atPRjjISt+3r2D7az?=
 =?us-ascii?Q?jPsdyeO3ChOdy8Sh5zj7sJEfsibSBuRdnGdMxuMz1VDXu4qNUK8DCpU7hQlR?=
 =?us-ascii?Q?YtotVdTkP/Tb8ssGgQUg/PxGtOoP2YcgaEUrMPsVzVoSFUnY6NyvZBZmA/H/?=
 =?us-ascii?Q?/fV9zFnD1XkI3vgtT+6LhUC9HBy/+3g1sBRauYp651qnGQBgc0lmFhkXcL1c?=
 =?us-ascii?Q?bzV5ntg5jVxEaaEY0aKorzo3wqX7qZEjVnrlSCoSSwSIeUJ26ZGF3mIRMMh4?=
 =?us-ascii?Q?r6fiACCLQJcyGj4+wL9/0cUu/Um59C8S39O3l+Hx+2mCXQWHDVw73k4xEO75?=
 =?us-ascii?Q?JW7RxtAbRf9/7OX8LCYATQ6yOe+cUrc7vw8xb0NKGii0u/arkiBXhKe2CtB6?=
 =?us-ascii?Q?e3UtQ5tCegdzvsHGjEuLn8tO99sRKwUyw8gC14SmAP254B1+YoGfuGxu/0hk?=
 =?us-ascii?Q?Y3FxnM0+hyOZWjnV3DNcvdowIuWSMdXQH3Ir1TPPb9a0df6GmzJKeU90eNAO?=
 =?us-ascii?Q?1Gcef35jBnvpI/3JiBGFfnZhzJHXr47f8w0eTe8WkqOc4PqEOnXXbqC3RB6b?=
 =?us-ascii?Q?22BxYpf9AsnrzTOGQD3acT41l/GOxzwv5GDrBEaTi4jz0s/Ak4C2fht/4l80?=
 =?us-ascii?Q?hzLvC7giZqqLOG8NAxRScyNT6p3gV1E4f/52OxBjO2ey4XzIUQNEbJ4mJ9gK?=
 =?us-ascii?Q?bkiFt9Wyc+30LdEeWgfuvKQd59JYNB5d5r7P/F0YWzpcBvUksuKd/KOWvkBk?=
 =?us-ascii?Q?xKqkUrUDViieMQwkCW4Cspwn99dKAssIzXR36Xn38jp4Q2jbJmUZQoHrCLhk?=
 =?us-ascii?Q?GeVmCI8X89immzR42PKOQ8yi/uBF1pPg00PPKjtXrJe30CKcrJ4GFVbu+Cz5?=
 =?us-ascii?Q?z5Bgc4syKl66AzhSjXKCoM17PVIDYHvQle0EcsgJ2NcCkaaC9oA5UjGY10aC?=
 =?us-ascii?Q?lJO/DXqxMASe17POAQlSkB5X9O79Vv4gPmlj+KtId4FfrVrp7SJjJnRXkdcC?=
 =?us-ascii?Q?IHDs0TN6MIU/4CcittYbnjd+b1ErvwS2E4HimmaXI/2I1b2aJR3saVRV5Ng3?=
 =?us-ascii?Q?qyU45tLv+4QnaX8GcP4cgIVMXqJgP1Mx09L9eefOpUPJPSY3vHu817urPBor?=
 =?us-ascii?Q?xhqTQQ/8IXNZWZYqNCiP00kHzw4ljRSDOaR1xoe5HdxVst12ICqo2cbRwPWq?=
 =?us-ascii?Q?ocSFWU+ELj9xmr0s9eCCeUjxO/mJkocI7PRu8cVHB0ztrEE79qC1UeFwvVpl?=
 =?us-ascii?Q?rxG2gNeXTVUF6btRzm1Uy7j+IBYriN0WoyTLDnRAY/1zIzSRrddNYgflOHYi?=
 =?us-ascii?Q?acxJUlGE0SKhPenvkTGRhZhP2EPprhtJMyBFkDiV2g7vVFSyqy2Ei2NGyl7u?=
 =?us-ascii?Q?u+eZohcDlQJ9/ygOo5E26EiII9Zc+o+NW7WsOx2O?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c56b7c6e-98e2-4a16-c1c4-08dc52bf0fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 02:46:13.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7V6m0xTcWM3Yd3NUxUdaS3bbeq2qS2b0cbPiFyFNVfI5t4U1Bw8kyd6IN3S986hv8d+7CnU+TfNedPbJPcXyzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, April 2, 2024 7:23 AM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> This reverts commit 41efa431244f6498833ff8ee8dde28c4924c5479.
>=20
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
>=20
> Remove it for now.  We can add it back when a user comes along.  If this =
is
> re-added later, this could be squashed with these commits:
>=20
>   0194425af0c8 ("PCI/MSI: Provide IMS (Interrupt Message Store) support")
>   c9e5bea27383 ("PCI/MSI: Provide pci_ims_alloc/free_irq()")
>=20
> which added the non-stub implementations.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

