Return-Path: <linux-pci+bounces-15685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD59B760F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 09:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2A1C244F8
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88114F123;
	Thu, 31 Oct 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4nJbnIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFD14B976;
	Thu, 31 Oct 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362161; cv=fail; b=kb/zlVanPDXOH+ChWAAxzWTg0zWJ9r6ogR/olB6IncXXdWI43yf2lnY2Ad1jdXML++iqy4QEE6kCS2AMUSFq/sCLepifx7eDqyzhxM1lFtWRFx3kkjtBZMEKVuRZMCQ2N3R1hELfgFHrebUfaeBgzaUTagxNM73/NnvKK2FexUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362161; c=relaxed/simple;
	bh=tJituLtI3qY+lu+9+3/XVF95TJD/ChM0+7d186fIOag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6Nkpd705VZuhPLNbodqs6z9s7KY9Xg/gSJnND9qgWHBd3wKI+BqAMyelkdO6PSrh62qyJDIBXVO/7HwNzUU6cNiX84BKoXQCFLRwr58WK9pTozEfZkVtWjPianA12H/k7JPZpZ+eL/BZN3J6UFi1TXi653+0HXvNDNSAN44szs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4nJbnIo; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730362159; x=1761898159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tJituLtI3qY+lu+9+3/XVF95TJD/ChM0+7d186fIOag=;
  b=G4nJbnIottxi9p7z/f7UiVJRN5yHUNhDiOv9TJfDzwePhtDbVCt7sJpX
   IZtzJDtaPUkQ5Zw+jf5WA0n5rwo3PIyspVXD9SNePAOrOhIkrgk2D79Qk
   azFPb4OSoaYXoHAwR/IFGdlaMCHOKON1Fcp1TDFVBDUOi0VhhFz4tSB72
   mDm5tV/aMUHXu8RZDGyLOidoxHdlkHdfYfNRxxT/FPhBRk/TcPBNCwAz+
   pi7r3O0fNAfLWvrqKHeV7OzjJG45IhCU075ND1Vd5qlh84hRLYKAjVz3c
   DlOJIcGS5pETSnEUerrbSJcZKKqepd1jHFYQzPZZd8X+jX/l+PaJzJh6d
   w==;
X-CSE-ConnectionGUID: lyk6FwJmTfWeX+l8Eml0uw==
X-CSE-MsgGUID: kgTg1D7pTZa/ld4t4HdBiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40632388"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40632388"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:09:18 -0700
X-CSE-ConnectionGUID: sYQHRlAaQgev1fAunf9z5Q==
X-CSE-MsgGUID: 6clZma2FTym8Z7kDVkA0gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87699852"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 01:09:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 01:09:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 01:09:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 01:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBxeaqUinxapMkDi9hfXTQ0nqglVezwn1oGW7CFFOoAnu48v9VRQgEFT37N2P1ZP8zIYWyoR9qJ/seyEmysassqNeDFzg2KY2DjzuQB0zQj+So6pz3FngXEmY8ZWKkzV6v1sT6WGg7d+StsZiOEcrsJVyjwRDG4tFI+YPKqYILJ7eFsRw0OGdjeXZ+MdvU4SGyYdofv84oYeOnuDGK/n5U6jIOoHTjSxuPpXbBbSJXIvauQK9eR1RtoXQaUP+14KBMlW3It/gQ9GUucOjL6fKcqeVU9+PNbG4XKtcaT3QACiI1B+LCyJcUCgPZcK58Y5uFfK1FXfADCmlx1LIG8cpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dr7bonNI7YRDvLzcsmxCnvuBMbPGATyBtEzm9zL/3Y=;
 b=xL2PZIo+/u/oSqmEwx8w2FVjDX+lxTq9J0j64hufrpVNtb5yiqss55Vu2fwjyNMe6NFYYc5NwWVekwQ/NIpZDK5/oKabwUgGNSURj/y9OXIm6XZjJBgN3Jwfv0pKW5tlPos+D467HWBAMg0DX8dMYXgMKY0q8sTY0fPvxIXO1odewgvDRXE/lQSUH+85dgDRnHHWmOcFDDwPPRtjsAwV/C6Yvias+D2cLdJ7fxjDd3GDKhd3kn1oe99oqYvgDptg2cNX1wwzRaPISPH+vUne31qhlYN4DJzYHicfoqgxSIoTwCu50DRswmWpmd0FtZdEfrnUHJGpZfNq6W9ExC88bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB6954.namprd11.prod.outlook.com (2603:10b6:510:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 08:09:15 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 08:09:15 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck,
 Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"avadhut.naik@amd.com" <avadhut.naik@amd.com>, "john.allen@amd.com"
	<john.allen@amd.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>, "richard.gong@amd.com"
	<richard.gong@amd.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "clemens@ladisch.de"
	<clemens@ladisch.de>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
	"carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: RE: [PATCH 02/16] x86/amd_nb: Restrict init function to AMD-based
 systems
Thread-Topic: [PATCH 02/16] x86/amd_nb: Restrict init function to AMD-based
 systems
Thread-Index: AQHbJXAimaYZSg6TnU2Ki9kvG1u6UbKgiiyQ
Date: Thu, 31 Oct 2024 08:09:14 +0000
Message-ID: <CY8PR11MB71340D079448528FD548F73289552@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-3-yazen.ghannam@amd.com>
In-Reply-To: <20241023172150.659002-3-yazen.ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB6954:EE_
x-ms-office365-filtering-correlation-id: 19acaaf1-cb20-455e-ab45-08dcf9834f8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?z+GzR8rkgboGOtF2tMQqBRsRpC09Bk+13bDrho+kQN2Y9Ob9WRHO73EQGbEe?=
 =?us-ascii?Q?e7EVm/TU1Blw/uXl5bAbDQDx4KwMM4kS+//3wOnmJsHc9A/pNdxUd6LS0NZa?=
 =?us-ascii?Q?Iw8CNjEW01q/oyG59QmK8b4SMeoXtAA/Gdh6fX620E0cF2gsYYVDxk16FIoM?=
 =?us-ascii?Q?4ByeBKqGfvZcxdQ2Q6ahYW1qwcITuQyhLXfz4RwdX5wFtXbHXZe29H9aYAnZ?=
 =?us-ascii?Q?+ThTWdd5nWMJVjbnlkVRUcGLVHZ8/OfJXgZkqJAJBS81JlhYr7z/fVH6SqbZ?=
 =?us-ascii?Q?6klF/moY+tGgMnhpNdkqGVw+5HWi+cmfRRuiE9aNw4fQONO7HqngMEfVKzNN?=
 =?us-ascii?Q?R0pZ9GcSj7NqfJqyYTjujivmOUfliFYmCVOlG+oECHcIYJwTenDZzyRU+psV?=
 =?us-ascii?Q?7tN/i+HSaWwGsaLK/Ase4Rkz3An2nXHEAab5/GI6ZG2Xv+Gef/Dih90cL7da?=
 =?us-ascii?Q?J4OOYGTgLdWxySTT45hmAYEiAdpu0+cC1H/fLIeQ+EHKhjzyDrHP0c+BsrUY?=
 =?us-ascii?Q?+Da1efVFaIoJjf74rVowXnXgOu+eT4HiMRpjplw6c3DXob/O0wgmPVzxaENN?=
 =?us-ascii?Q?96XAJlbP9cBYIUAw3FXfPNWhzF+We/93IN6l62INjpIff/H/yasH7ZfeFJMU?=
 =?us-ascii?Q?Tvh1/95hn+d0OjXrz9LqDsLFOZ9OCyqLIwZFX3LeGwOr7bpOdjsID2tPbuDR?=
 =?us-ascii?Q?J31B/JZAAd1vnJoq+mhPG5xEoj9M0IF2qqKY7fiKaFz+/75+uMcqcMpvXUSI?=
 =?us-ascii?Q?unn951DGIbb8GI/w8b+H2abudnuEE2Sy0H4ErkcZkapMxxhSqouOvEL+/yhC?=
 =?us-ascii?Q?P5/0MCc8JWE36m9Kw3QdWdDI72cE7jkzhnTkp1HBHmnDwydBaPti2a5lq1uV?=
 =?us-ascii?Q?Yc5XkNFMZcZgE9PEpZyQ227GuOCkK421Uhy6eoc6dDO1mcvhvUnvxfsAnyHy?=
 =?us-ascii?Q?GbDLmPtEuvqo2jbRJmJETO428jOqqn9k/np0pJ3XlYWnFf0Rp6F0pU4Zx/qg?=
 =?us-ascii?Q?c+ip4B9kuJVcjLzrcDXBQfYFyeeHexAPV24YZ3nMcElceHr2szW0Lb2CD+sP?=
 =?us-ascii?Q?/eSBvUO9mD0VbqFXecP9KZh7Ejh5ipqIqr995Rf0ar2/rOPcsFgennF8xiaF?=
 =?us-ascii?Q?LpCKaqym+2iV60KXBIoykS4lGWErZBarZznAqrVR1lIdK6jJnStOKMmZoG5h?=
 =?us-ascii?Q?9hU7SqvUKhBfyYzCa++fZj43BcE+d+PLcgR13SfcbkQaoYuP/h0OtepmfwAa?=
 =?us-ascii?Q?EIIHlKLlt3sLUFm3whLOoR1DPoHRAsvDvVfd4272br0aVq7fo22dRfyMXgUe?=
 =?us-ascii?Q?YAW6ny8oppnkSPvBvJ/UY0F4ubLWmR/Z+YcUgp0gh3p2hM2r9b22du5jjOTX?=
 =?us-ascii?Q?SPv2INQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lS6gTDWfT/cyhPakgrqLfX5ILVXd+v1BVs77l3Q1hrfFacLpyZi6Kz1I5Aqh?=
 =?us-ascii?Q?M3MchJFNL2sJGp4DdC5bBuxs+zNuzrjq5K10EmDTp7IQaOAUZI7FckzI40Ms?=
 =?us-ascii?Q?5Qb5ibpxXyJmC8FRCl4SQPnyhmwDo07O+INlK48bFlZkkyACR0/ZuhWoU06M?=
 =?us-ascii?Q?ovZnjK/7faq516nPoHkjvxnU5ozIynKAuqQ5/XptoWXuyaBm8XEI1bkx1eod?=
 =?us-ascii?Q?8+B6PyM2C0AW6XvIsU+/wu5AhXtidsOLYy0j+YstwsS5meltxbAD5707TV8d?=
 =?us-ascii?Q?RrH5tmnTvM6PktiEmLyz1CSVq8ds7qMdo373NeyIcJlgUoMuYQiJpYRQrOAm?=
 =?us-ascii?Q?WKW0/gxOv3/p/heTmMSk10s0CbGaprRfyp0gK+XEPL751xw2X4X7cu+dpS5j?=
 =?us-ascii?Q?kE/5ufhUp96JmNZOjFfksftl7F47DkSrdCz0kXjDsxvG+7lZaeF+1AJYzNWR?=
 =?us-ascii?Q?AGGvCQ5IIa5pK8sMfBUmlyHEyKrGmWUiVnH6oQSoj6Crusre1Y9d02pj8NL9?=
 =?us-ascii?Q?XkL54vh2vjns6pEvup4GaYFn+REdQ8MpT0Q50ZuhhwjSd8sTUJcJARojX5Gm?=
 =?us-ascii?Q?ezb2bQVeJtQOwnr31WLz9dBu+2n9FMd0XSoRtTPvsMtZh2tIX4NTTE4+CzC0?=
 =?us-ascii?Q?fVu27TmIQGLgOnIyzzaKVkybi4YuBYOiCxWf8C2yT4THKpCt2lS4y6kmpUel?=
 =?us-ascii?Q?q502LM1+tEdyxtvyza/ucvKRwK43LEkErfFgFbK0X3EsiQ6EoLDja9DogfFs?=
 =?us-ascii?Q?4+DBsiC2Cxx7juAZ2xNyoZJcWq3w+nziccKPv6mbNxsqbX/vYMeIOe1joj3x?=
 =?us-ascii?Q?Q227jPDi3K6FB4zoGmdkTY180AL6vjnUXSahJcT4Ze85/E2IZ6JdunShIotr?=
 =?us-ascii?Q?COasVjEMChpw0Tfl/LXPrJQzA6JUroQhX7Kb4MG6ksvTPZE/DuhxjdjET0q/?=
 =?us-ascii?Q?QLW7fr8ZKo0J7gQyG7a3lAm2ZdqQ94aevOHyRM1JCbs4+3keraLpbKbjCCxQ?=
 =?us-ascii?Q?HnN68uaOqS1uVHtcAltoh8pPqKFjTf3PC1iyo5LOql4TpOUs9+DqxPRNGMkm?=
 =?us-ascii?Q?h4OTgHqaICkKe3Nn55+ol0vMaZ+LDbrMn2HfKMixGEYUjR/SJFHyEZ5Wnvb7?=
 =?us-ascii?Q?jaFuvdsIqbkqLqlW46g8LHvI0vhezQ4miuwrrWV08Anb5+5bnwLOArJSGhYq?=
 =?us-ascii?Q?cMQOq37uWvMtoUrAfpMDfY0h2HSGsCscxTj2RaMzrMlCUobZMSL6heaA3b0B?=
 =?us-ascii?Q?bAOpdaE9Ny5kj0pErEf1Li+809IG7V5DdXlfCwMUg4hFxUXmAsNSxALM1tTm?=
 =?us-ascii?Q?+vfw2Y9NlH+4p8L0dAbHTP/uHpvmhrk2cMjSB4Q9M9/5O4u0yVC6aVR4P8q4?=
 =?us-ascii?Q?S8ZuihNyeDFtZTzAOFAdTOnk18fQk52ehhDp3aO1T75wvXSWc5y1KqQMV6Os?=
 =?us-ascii?Q?A7WzX6B5PiBHrVgn2fHXdWxlOVKYqivw9Z93hOEUFhvkDZmYisIzpIXF4M2k?=
 =?us-ascii?Q?D3BguPuQjEiphMRJWbsSMiOU+euCy2JaeffzEra3vu4DyqJIE5J5mvHCH6ww?=
 =?us-ascii?Q?EUVYhrotUYiiP4LRArUHOqmgHMjngxBBe0Hp/pLs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19acaaf1-cb20-455e-ab45-08dcf9834f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 08:09:14.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnbM5DERUnAQRtSAn6d64UJBcS201c12cqGqkMO4L+YD9buQVuYW6tDlxXQSQyFWUZI3Fh1TSVQrKV+HguC27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6954
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [..]
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -582,6 +582,10 @@ static __init void fix_erratum_688(void)
>=20
>  static __init int init_amd_nbs(void)
>  {
> +	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD &&
> +	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_HYGON)
> +		return 0;
> +
>  	amd_cache_northbridges();

This function could fail and return an error.
Is an early return with an error code needed if this function fails?

[ I know this is out of this patch scope. ]

>  	amd_cache_gart();

-Qiuxu

