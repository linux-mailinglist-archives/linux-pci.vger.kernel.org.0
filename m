Return-Path: <linux-pci+bounces-5512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF51489498B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 04:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848B728677C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 02:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C0C1118D;
	Tue,  2 Apr 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6Txxv89"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A514005;
	Tue,  2 Apr 2024 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026098; cv=fail; b=Osvmzms9ddfvKFyrVmQlR5A7KRbjMLhJHWgOSJadRRV+M+jFBGhOQRT9TYZUkCDmduLymWgLI9TFnoTyhsSWc7XRfPL/Uc2aMfGFyIdAFBBRaS7UQGUucg256SlBgNkaIobmqUST8cb+u1TjmAVQ7H3Hd/k2olM2ugCQoyx4MaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026098; c=relaxed/simple;
	bh=rRSLstzXr8TxwFArOY4uYVk5r9C3kwOI+U7I0RuzCUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JOyRrgmTwlZkV0bZrV+Gc1i4gcTuCLsCieuhhn/i0b/w6nyezElAJRHIAoAzbmnNRSXRak0GXHzFFwzQysR29PHlnU9lnR0gcN6+yCRK8Uqzimb/cx0p2mR34whw0zLre8bKDyI8ZLoItEpAl1sS4aUd6425GINjDQh3DzwKgvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6Txxv89; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712026097; x=1743562097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rRSLstzXr8TxwFArOY4uYVk5r9C3kwOI+U7I0RuzCUY=;
  b=N6Txxv89Yn4AN9gNzVyk3dE3mbaTYpPIGO6ZVeQXoU4h/eXYGvsW8Ggz
   EDt2xI2T1VvVEPRpEVUZ+wVrFyFn0SfUob0/NdFz/eWF1NcxxpK0zT2Ge
   9tEvaOpVBPippVPZfN3eXWHTnZcYrTVij8pSvvo+JnIvywjrD+DwZEfxs
   z04RSJ/ozN4mrYAHg+eNa8VvkE8hugidNiezp9y8o8LUNEoypBKKJ1rBG
   zFX8kCqvwZDMq2qZ7zhh+FPaEIpp9kwdmTNIM0IWhlQmFyY/1szqDRsx3
   LoUJxU2JHRFOREN0jJWn+9KxPFpuPy1zC8C2tnYFqX2m4DDp9pPrdXp/y
   Q==;
X-CSE-ConnectionGUID: JhokPuJTTKWe+vxTRqpK0w==
X-CSE-MsgGUID: gr6aR4wVTHSBtCiqeK3FAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7075470"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7075470"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18368692"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 19:48:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 19:48:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 19:48:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 19:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDJIF8B858I4Nt3CW9lRx0H1A6oJTsl1bHSZ2OwRBH4OI9i2sYWhzQMnelYYvG1xM3yIvOnBKjPoOHfkqnf33LjFQZbQVssJKxd4PuTpvgVcdCoP9T4R1jZyH+U0xj2UhnQgt12JNaOXYUmhne6y+oyPEFkU1SqoYEKfOGTjsQS0GtyZNbLIsqdSDQKYaGvF9T17NRUiuNorRx2jckKZP/WG0e1CRZp7A71c/t9VqCtBq4b8weswZcPbVGgRjzsoSdl8PCEyaL5zTZVYvOPY+knLeBz9aoXtyHpGOfOgrRR6Z9OaaV6rKPOfys+NRcsbuEBAKgDfjpSgqQ/uoCujNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+ywXDGlK0z2hCZiB9gcKEvhHcAlDx7Yom7X7ag+dT0=;
 b=CLrFL+TDXDq9ax72eBMObXCBKNCQqBjQ29/EkuYj+c0gNloDmWeEX53fAw71X5JAyihtsaEI28Kz8ndS2wKoCRRQ9gi8LL4XhcAzr1nUH1iprxH3/Ss6sBpmGIUHxpPPfY00msWZKkxlQ0Pj3UG2KjPMnnA7xTcWgQCG4h97E1knuoAZAKvpawdS1e63cx9YkBSzUgU8zYEyyM/004ajWOOdh/bTuS0Z6UHQ1SzJCnCutNX/ScixJcAVKeMB2LceXyvhg5n9+BXEhw6DvXT5+99jfi8OfXgHGT9o6CsXE4eH8MWH3pWZ8RW7UbgzdJfkcxCo0mvFSW5hd5WX0zlfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 2 Apr
 2024 02:48:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 02:48:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: RE: [PATCH 3/3] Revert "PCI/MSI: Provide IMS (Interrupt Message
 Store) support"
Thread-Topic: [PATCH 3/3] Revert "PCI/MSI: Provide IMS (Interrupt Message
 Store) support"
Thread-Index: AQHahIul/8t1qKMgk0CDwvklC6mVYbFURzhA
Date: Tue, 2 Apr 2024 02:48:13 +0000
Message-ID: <BN9PR11MB5276F583D7CE69B65B8DAB3F8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
 <20240401232326.1794707-1-helgaas@kernel.org>
 <20240401232326.1794707-4-helgaas@kernel.org>
In-Reply-To: <20240401232326.1794707-4-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6515:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0UXRr4fpielrYARs2kqP/YBP5zB3bCdjR5AQBCWNBwabVXtrIx/yvvg0YXOBQh6NuRHLmp+zNQ5NvioJhPj2s2YGcdCAEeULkes33U3uLsgXNQdlu2LR4sOKt1DEkOd1r0+38a3VABTpczTzOFphJdfo/SlF5K2bATyu7joCGCjrj0d5Eg2nnKcqZKDJsYNBzXa/wcV+uEY+8OapbAomGd+JbiQPr2kBzIYYOqQtnWQrty3rFDYG57YFepkv5HW8LWUuFR5FIRjjFewyPfcqu1Qj1+FDBZy2zDMCSY7AbWbZc1GIf9f9QDDRmRjH7vNBriNt8Iq6M5skgqDdz0mqfkyb+0S2A4gXF+ZiCohf6IHv8fToTzowwDcocRONZyZA2sHv5rJyQ72rcSQHoE/Tcx5qELU+mgX+lqu5EnP6jqg7w7DXPOdAlZ8jiRzZFRHmkboSf+3mu+IZbd7wmTiYTO6nN5jL8PjiEIO4IvjapIodcHJ3S6daP1rINe8Cc771RaOqO2LFWbZ6e3NZXTZMTOt4xQi+nOUJxy750Z8VijqM8QVtgCuBKQIFLNncxXvQOO+EnH/S/bVCgTLTTKOtGmzdpdtOgNZLzOUo9cBwPc6c+ExCSf/v3lbrauGtOmlxrAvLFpzCHWgM1uj6HX+IyhgCxUpD0eeZUHcqBxGDKOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?99GJC763H1VobSkl/nzDacCBhbUgHz30iFW+mxDZiztRcShJcKm1dGQu8kxa?=
 =?us-ascii?Q?6bCpRQ4ZgPohvwEQQiylalgyvmKoK4UtmlWOiEtXzWP/Os8LHiZrZpHGdFII?=
 =?us-ascii?Q?oyXoZDbLJXuEBxgJ09heLhjUdFq62rt6TlroVq2RSG/fNfrLdwbiHUVu4mGc?=
 =?us-ascii?Q?7AIZ75I+wIWBfyRf/6ngj8r8U9aKp+pmnoM4iGyrBwDmT8t1cuLcQjEHCIBb?=
 =?us-ascii?Q?lY82ecfXJ98Mna9TSapslQY777DSUlzr7pgxFFdxn2Ldj+7HRhJXFZaJlRHz?=
 =?us-ascii?Q?wsKeAjzsdgd9n59bw9FlR6+bpi0i9e8bR6lfKAq7OOHtk3ez/jS+G3D8Lb4t?=
 =?us-ascii?Q?gPXfTn4KQVwRTzH+B1U4aTuPHfrm3oyrbBbnB6+i7osJftoJShX9fNX0PK74?=
 =?us-ascii?Q?k+bzEtCDVgi1CZADop1kC0kyQJvbFuymZnryXBwUFMzOoqdyBkRW7Iso/kU7?=
 =?us-ascii?Q?ZmN7+i4eW5s/C87VzAubp9FGmlmzDgLuFX04D6cwj0TpwsHBnZM1y9otJJl2?=
 =?us-ascii?Q?VPsPR/r18R7LTbvO32Rrn0YMgsOFl/S4LPC5A7Q0w6bFfgi2JrnzNRb5b4ny?=
 =?us-ascii?Q?06XbnCqXhShrBFbwDhbivqDkJKcL01XYsomhe5prUKsQ/TKi407jPqOCrCEc?=
 =?us-ascii?Q?hz3PfkY9HO52wxmiiNBq9rqzvf0oPJutVERHEFhfHt2FSbR4McbZ0/snM+Du?=
 =?us-ascii?Q?As3geBXz0ILQvWn6Up131SpufGWjB8h+PiFdbaOssG5fJR1B6RZmZt/g9m5U?=
 =?us-ascii?Q?J6V4U/30NS17tV7JumxE8apnJbl/S0tneHCtnyMwxvjEQ2d7cbcFs/Vs/fvP?=
 =?us-ascii?Q?zPU06uFEnvhLy9H5XgIROURp3Pm5GW3aukUEcvTvu2AkNt1YJv7x8KcPg9pB?=
 =?us-ascii?Q?GiW54KFjx+UilaJsZLzb1iPrdrOOlBCHjtijBOOlPzC9cDNDgmq71Hh3jLlS?=
 =?us-ascii?Q?Mqjd4A8TZLsvcA24Q1NMvg5E9bvZA3w1k43sBEwCbpWaPcq60XAzTSU3BP71?=
 =?us-ascii?Q?b7cILekWCpbHHSZvb4cAENDAP+d/m4wFh4xVVhgBOAP/BTtFuRl7Z14FZMGD?=
 =?us-ascii?Q?nN0RKehYo/T6aKUfS1qEGBYrR93CsHXWLJi6/Pph16tKGapDQZ8Wr+IyGMzE?=
 =?us-ascii?Q?MIe203d2fQAldt0Jnn4r4o26ytrfFI/OMWLlP4vMSvrr8HErz59d7QekfyWM?=
 =?us-ascii?Q?avXrb4cvWz96ekT8Yfy6B22kWlJMafN5W1D+qYdAKODV3ROb3MIaBBPV0qDX?=
 =?us-ascii?Q?875HE24hDGqo9eXmNy9glS9RIfnJt/GTzBiJEH2EHCRGgNI6XlI8GS7PhoG0?=
 =?us-ascii?Q?trk91C35711PYcGIyOp5Z9XiCZWJIjtEeE2XlI2nvogHu+BAWc6+1TCNpAGk?=
 =?us-ascii?Q?PnIPdOZgyjuit7j7I4qOaRZMDLGjVSHNjXqdbYTNg2gu7rsGRPCv6uLC5THE?=
 =?us-ascii?Q?O9BGUaNCh5NUpsz5mljxRHsE41QBaNNfuW/DnS5GvqP7kHMvTQK+HS/tigqN?=
 =?us-ascii?Q?EwNsNv5sCaiTWqUFY6reRNvLIPRflZL2NClQubjJ6v+LQL59dvjmCXJo2pp8?=
 =?us-ascii?Q?ZhQqXipVmp3E2FjDA4ud1goW0gwRyi0uz7y1N+HR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b911be8a-138d-459d-c98d-08dc52bf56f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 02:48:13.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnjECC0fC4MkbJi5lBakfzzuyhg/U67jyUZU7BWZHl0sQtV0Yux7E9cd6CYK1+ZpmGYyAaRKPRQ787AUWnnn7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, April 2, 2024 7:23 AM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> This reverts commit 0194425af0c87acaad457989a2c6d90dba58e776.
>=20
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
>=20
> Remove it for now.  We can add it back when a user comes along.  If this =
is
> re-added later, the relevant part of 41efa431244f ("PCI/MSI: Provide stub=
s
> for IMS functions") should be squashed into it.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

