Return-Path: <linux-pci+bounces-6107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035FD8A0781
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 07:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B19C1F22B77
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 05:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93EC13C3CC;
	Thu, 11 Apr 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfXHjNYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38413C677;
	Thu, 11 Apr 2024 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812445; cv=fail; b=Elkdgsa9JACCOwgPk4f6OGinx4YWCXpJqozq/vxFLqNC/AqeR0YvIh1QxmsfwLTLb/cTrImPqF0MXDV5oWvXUFSRKFf9uIc2tcAfJs+8CtgtHQ+Nc0OcLNQXlUiumSXch5Oa8+meRQLea8XSH8n7z8Zetmqx3IyC+ZDs4QJyVLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812445; c=relaxed/simple;
	bh=3ay+0/Tr6gj1emOhdapLuVi3+4EuTTgdS9K4rfbrl28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kExGMfUt1zuMhQqsSuBaw9TPDAslJdV1RniH78P7aa+kwcC1zmQFIo+Wukfzc2WCRuAP5VeOAMsWyL/OoeV34ZqTSwli7URWY3Ap4LapsBgor4aEKL5Ji/CGgs7bHp82mo3t3vWQuqjsGPxvXq4ef3PbDX37JIZkC6rvrnz1mYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfXHjNYD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712812444; x=1744348444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3ay+0/Tr6gj1emOhdapLuVi3+4EuTTgdS9K4rfbrl28=;
  b=YfXHjNYDXTdWJaVH6SmxJYXq+9QKy7R3SzuUsGuiLfqNBxJ1Sgm1YV5k
   8D+asNQva5QFL3mW0uKZB9ROZJmzKy5W7jIbmEL/9sxzit8eRgYKLH9c5
   stE8NVf2kZMuG2+81y5elWDzpm/tleJY18firadWWeFTg/R8Z3h8QQetq
   2YbIK80r4X+qtZBFOJm9d1uYKs07LcIRRqs2PNp/qHomPAeidpCwT2pbQ
   c5D4udjJeUGSKM52ppG4cgCp4Xp5LoiJtv4R/08H0PFPyqbFtpxWlQuM6
   uoctbEqDpWVIKMBttNZzFg1npL6p93p5R38DPn7D0vkm9fPXIMAirzp3G
   w==;
X-CSE-ConnectionGUID: z4WipDyjR6WgITTKnULOVg==
X-CSE-MsgGUID: X0PBqAiIQw2FTt2TEWd0VQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25716709"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25716709"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 22:14:04 -0700
X-CSE-ConnectionGUID: 41oGRrPARbuq7qq3djbESg==
X-CSE-MsgGUID: pfxPeMacSdS8oYN2ZSkZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25270297"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 22:14:03 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 22:14:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 22:14:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 22:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTkdfDUiaI5yut07jyRItR5VIHDDR8gtmli9pVVthiPuZbm9mb+FKQK7CtHUj8G7jys3+HQ48QVhuuK1F2kjTfxipIjr6wacg1B+qOO66uRWejzOrQZt0lnll1SgAqoBFtMAgvGuErcV83GUsaWsR3GM86l5zI+RFPfCTbheZsO1uSFDVicw8cOGGbsC+41v1AH+UZVx7X/GIUl+CWpE+pUdqG1GBlnvJ5Ky7rW+dToPCPxEjhAdCfOUWrkbjgkA6Kr00/dXf4SD54IKCWEB2sHCMmY+CHr5bzjRDmlAD5gfBCGAK0atoxBue1H1M0NxYlKmxuQjtdQIQloLKzhAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmyDI1+vMCyPKcyp9cf41xXKZRtz3w7zNxNLJZRSe7U=;
 b=XIYeWcf8oQsxujvjtoUJj8J8V8UAc0LXft9A3zlynOy8O4oq6ENZarKrwyjgTD22oPFgZAwaoPHzEjcOPTCy8dHazlcKCCFrObYpQTFdcjYRi9dSsw+pOIpQLjkMPfHkFcVkfk0jLaEGZudCjgbzhMKxdtZpnGR/E/WQ0TdJKHpN0lxR1ZTmQAGnV9L/PXdCram/wzyRAlhEitYrEI3PucClBotAbYskrxaVPpwAsRjdBeNPd0YHWQvCvY7VE6Sv3LjEY01e20arN1lIrB6fWVqrUNT/rh4NOy4wRr5PsRKXo++unRtAGDvO8KK7IXD2K7ON35OM2F3Vphl/IWm4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7789.namprd11.prod.outlook.com (2603:10b6:208:400::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Thu, 11 Apr
 2024 05:14:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 05:14:00 +0000
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
Subject: RE: [PATCH v2 7/7] Revert "genirq/msi: Provide constants for PCI/IMS
 support"
Thread-Topic: [PATCH v2 7/7] Revert "genirq/msi: Provide constants for PCI/IMS
 support"
Thread-Index: AQHai5RgXFcPIivdgEmbpV2hdQz5/bFihulQ
Date: Thu, 11 Apr 2024 05:14:00 +0000
Message-ID: <BN9PR11MB52764DE1C15DB3D1CB62C68D8C052@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240410221307.2162676-1-helgaas@kernel.org>
 <20240410221307.2162676-8-helgaas@kernel.org>
In-Reply-To: <20240410221307.2162676-8-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7789:EE_
x-ms-office365-filtering-correlation-id: 7b525cc6-ff8f-44e0-2319-08dc59e632b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYjmhEJWwhfP+ywVG+xW3iUJB4rMYruMz0xS5s19q4I+M/1+4iU3w6cvPOy2b7YEl8V+tqdADAO/futah+N/msVcmqR5c4cqS9hV0nYuKGvgfEkCS+wlsCzJJAkvnnKnZBoPwjunVjnELv3hk3LaRoXKfiTncqBDRmWEw8Gwd+nlUQ40TibW9HwaxhaWxqHMryMAxIHspIRrvXaKgPHaY+f/mVukmqyEd4il3pgA26Cr9LMzClc1Vb+fYbqMFiRseiC+gCPizDFKqDUh4oYatafJmcX3OnQG8KlKVUyVrWFnqOqHMIHLjkfbkJDYwzEpR0/ACxLRZIQJacJxzzZaxcnEK4B7KXs04D91SVmDDUtIeFGQ+srdABk6X07TDfOXGkWSz5znUYkxooPtpIEXCesJ2TX+PhlKo7enlhCCZIZyCSg8EceFHd+t474cbwcCcYObEN96DGABrUIGA7gnHHt18NbJrtsyEckLR4RIsfF5tMKM+CbaI0+vWHGPmfsXFPTWY4gpKjCEsE5jbckHS52x+i82gKWyLaVrT3IfFCocLCwMervr8z1qLrrLhMgITl1dThJaGAn+cx9yys9p2hEouQhRp2tsNYe6GFvhg49aaXAEYunBDof0gpbCR4aZcHr0Wa5QsGi5Uf85VeIL121QKOb+8aR9678dFDIDlhsb7RrvyUAKuMEMLY9xn8Zq/xAkfbdB2yOIMFSUbZFO0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XtcEKRPbIg4NwceWUIPwk5Yz0ErFwYI6wrMewyfYf4aJzV802zfQkMItPfNX?=
 =?us-ascii?Q?xgJ+RP2NTLrQADkbXoXS36EhjlVwXBvm8+i8m0S0fXNE0OdoRmP5/rrXzgOt?=
 =?us-ascii?Q?qT76dQ6l3a+RtXKiw2c11frZgnyvlL5WVL6X95wVftGNm+tcgYgvzp/9Ns7P?=
 =?us-ascii?Q?wZItI4JnPGderfj+yOffKGl0Ndr2AMGMkA42FKa9RbX63SURdQwSJMmyroRM?=
 =?us-ascii?Q?1iZfQi+lPiSvicDkSCt6UzSV09F9acHiX8srd2/jfIMAIVPfDvfIhdnPCyGa?=
 =?us-ascii?Q?AbV4y6tndKrhSNImjfavR1CpjoPdDAEBuxoflSkSEMs7wN7kzsW1z1B0/ZyG?=
 =?us-ascii?Q?wZKQYJ6Ev+2dilOUtiGrbJix/QDn2gfpmmLuW65AoFnwFenv1qMmxDkwjpC/?=
 =?us-ascii?Q?077FNv3pc9lz2XM5A9ZpxGf8XtogmykkRJOlzgsgo4jV0og/JOBMLZwlaJq1?=
 =?us-ascii?Q?YltRy639927i9ZpHRznu+sjeXO1hOCeITTEL51np6HFnZd8+nya9gvRIMZ8G?=
 =?us-ascii?Q?1bQQQJzdPEYjR25z09RznvOlaTq6N+kTdZ55e8KHQJV7/NhpLDTHOfo57M8m?=
 =?us-ascii?Q?xLd8ZeKr4gxpmLI7IRz799gWA8xKbXuX+dIXsBfd9Hwvl595P/fYyy055Uqo?=
 =?us-ascii?Q?jFeSxKVWirwZeo68Bl4Rhh+AqU+B6cGtcsXmBX1LbvxOxfr3PH5DitIHXH0P?=
 =?us-ascii?Q?lyt7icY/heGb4uCQiZXm1BM/F8a84c1cg2JjCQ8XSvAXmVtZK1xB6Jd6fXRu?=
 =?us-ascii?Q?SqT7WqyeICbf0DQVUhKiF8wqe21oH+jpitvKutY/O9u+ComeSVwcoUG9/gtp?=
 =?us-ascii?Q?EHaBN/hNe0ZBageMbcKIOq8teGN0o7meYW7U6n5negFXjOIt1kplh+qEhVod?=
 =?us-ascii?Q?Ma/hXPbOG6Ed5N28LkOSQv3fTygIH5+mQVacJPILCEDI/whlQ3aowKu/z7Cv?=
 =?us-ascii?Q?ICQQ0AoRXYo7UTO2thTMHRnwFajLhFXfKkjN6aywBH3GlYAQ3jUBtZRMquDP?=
 =?us-ascii?Q?k3beFuaj5JPvgRngfdc4vSLpdx7mAnsu6MrKMviQ3iR3aq/+smLa2o0LMtOV?=
 =?us-ascii?Q?UZP4jeutC1gxq1ZmfL+7z+ldpjovFS3h1CU25Q34tlaj36FGuGBTC5Kf1Y+y?=
 =?us-ascii?Q?CsNmkLQ8rt63CdHzW33hgRX5VRDwXydh7gdxFlBnWWCLId8tLfL4MWa3ImMn?=
 =?us-ascii?Q?6iMuZdn2aoPDRuaFzDl2jR22wo2QfqeLvpv9jZhGNT3f/8SWh98aye2lLtst?=
 =?us-ascii?Q?IPSt9beQOB6jxqf0hqM3ANoA42MZ3FRwfr8JikWWusmNPJjV525XIRzfb8+D?=
 =?us-ascii?Q?hfl+ilFu+StrIbj+arS//EEkpe3tHvpWL+PxQUdaraD08dtik5bAWO2IAOuI?=
 =?us-ascii?Q?PxZmqlvl1OCUhc8MtFCxb1LmheEU3LpB/40gWzrhT/5t3TOZ6O+JGJSBNZ9s?=
 =?us-ascii?Q?JYEVFkEe00p6ctap5KS9/BDi2u4VvGLHAsHoF+Vt+x3MirhJrZ3nQZFIlY/1?=
 =?us-ascii?Q?YtvJ+H8D9A+do7h8aZgMuDZNF9MdnhCNh5gaqni9fsg1vXCZKShZ3x2g0NhC?=
 =?us-ascii?Q?AJaAFS7HX43M1u4vYcmeCOKeqvluCLIenL+sYL2e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b525cc6-ff8f-44e0-2319-08dc59e632b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 05:14:00.7836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zp325UIxL2GzE9LU3jwGmBDun4aZNUM6mHB9x84RVOeCF6UHJFz+Wn49NTV/vPgWQXwa1YN/xX3cXmTlB8/i3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7789
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, April 11, 2024 6:13 AM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> This reverts commit e23d4192bf9b612bce5b24f22719fd3cc6edaa69.
>=20
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
>=20
> Remove it for now.  We can add it back when a user comes along.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

