Return-Path: <linux-pci+bounces-25222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F28A79D85
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF7818977D8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A121A23B9;
	Thu,  3 Apr 2025 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOenXsp6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C11494C2;
	Thu,  3 Apr 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743667056; cv=fail; b=lvWLOLvrvx+6zkxJ4XdwBBKY49dT5IfVHcLM1hDG6a7pRRwaulFlkwGJdJDWGUnB1kjWIneIw1sTrRIxvRXGcJRx/J9/j+4uaGP75LrpH0IhKip6+gIpaXRl4AKVHbbA1i05jvK+1utnQVsJ5ygMc+NzZR4A6VXdge/cjFqigWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743667056; c=relaxed/simple;
	bh=08XTUZ+y4BovC1cAlXvW6bxqkOd7DtayMIBaBxyuTi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FlG47AsHxiPrSpVENfwsJ2SoNBUljWdUHKl3Ej5BWntTTs2OsnEM0PG+VavuYSC5Kb9OD1nU02cXVdzdfS5Fpath46t/JlHzcPR3Mpe3LCb1sVQJ2NeaiO4K00NeWjT6rUbGjAYon5vvhlDc2PDYf+rJdcsb08IhL+6qbyp0Lfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOenXsp6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743667054; x=1775203054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=08XTUZ+y4BovC1cAlXvW6bxqkOd7DtayMIBaBxyuTi4=;
  b=IOenXsp6ROvaMT4xldsT89ZS6AXtc70jwvD8IhUI1lWAdN9MiHtHDPmq
   GD4R3IhBTjvd73lS674bc3F7qNy4i8KDJiWc1Jc5ee8XmEVmDewm30AdX
   36AvVNs8RvuGqRenWS6X6oEqvb/4uoD5q9gbaTyQoGO+rc7WM+Jb/ghjN
   v+gs8V2kLrv2ITLDOikU1VW8RfrrmfLfNjwzOtJKrAMMm8vh7FRR1OFWO
   mn/6s9z6XFqhH9n275JUJ1kGoORNr2ANDSeQSpLwqY4Rva/RaKXCMYRtw
   BfHzpz3yY5P1wwZdsX3sKx+LUoatKxBFbOmWbSqLrVNTuKDU3m8vT3us0
   A==;
X-CSE-ConnectionGUID: 0dRpCBuORzCznsLrifaPlA==
X-CSE-MsgGUID: HUw3H+sRQSyp1zDc/m/Xrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44209923"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44209923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 00:57:23 -0700
X-CSE-ConnectionGUID: PQr3LGo3Qou7S2L7n6JGCg==
X-CSE-MsgGUID: pkgd0hFKTgS7RoUySL8U0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="157889188"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2025 00:57:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 3 Apr 2025 00:56:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 3 Apr 2025 00:56:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 3 Apr 2025 00:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2vBpDoZExUM0sl6qf60BPzdNlXwUmk8lK7hMMfB67cE6fzp2gECeqp4LO1bXxaTFGkDk5wQj9bOP0goF3aeZqluOZ+IjX6CiRyCWSjFAusvw7i4I4CDfoiETi6Ydy0SoEXKBC5GSS22HIAwj8KTYuGMfzeBsL5ZiM1T3dWV8iBNwPvHvla/HflKp3OXPxifbjcgK6PBZ+6CItP3eyTcVGaaIztwnfqhLH0+YPBSXX8hH7QVSaHeYLxPI8i0wG+umU1/seYH99VlGNLAiD4psiufraqm0UZLnxqQZYu5shDXRC9mdMWDmhExV7icje9oApEXlnmM2Ubpr2cykEIUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNA/5xoZj56TPp0W3/guWceQF0WyeukfwwjLTt0ZDIw=;
 b=x3XD/UIrzTTG6Yg+X8q2d/aG3DoMTagOYMx5CkPbOtlcuODQpEmikH4d2Mo5CMIpCNU59L+BuMrVBYoBW1zrRsWWO8dihtBQsXBLxHXuUVKwr/g+o2XAWfejwIWl/r92Uwm3fbC5eopgE9dvVZvNEZbXPdhD+BbgqbpzjKwW38MO6ubTIwuYgWSrNd7xvP7jMlVsqm7lt/fpJL52qDbzaUcpwN+rz8agmYjjzZpZRCmQARTRAp0EdnaO5cAbgSRd0QgpUmTkUXROdrlWKgDKmlfkPnw9l+tcMmboJ/TxwOu+MfTox1H+BDoNmneGwSOMMyJM+cF15/gPe1T8ZJZnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by DS0PR11MB6519.namprd11.prod.outlook.com (2603:10b6:8:d1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 3 Apr 2025 07:56:57 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 07:56:56 +0000
From: "Gupta, Anshuman" <anshuman.gupta@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>, "Gupta, Varun"
	<varun.gupta@intel.com>, "ville.syrjala@linux.intel.com"
	<ville.syrjala@linux.intel.com>, "Shankar, Uma" <uma.shankar@intel.com>,
	"Nasim, Kam" <kam.nasim@intel.com>
Subject: RE: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
Thread-Topic: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
Thread-Index: AQHboxvW09BLofS39EOnp6kodPmC7rOPPvGAgAI7gcA=
Date: Thu, 3 Apr 2025 07:56:56 +0000
Message-ID: <CY5PR11MB6211BE6482B046D8946E1DA995AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
References: <20250401153225.96379-4-anshuman.gupta@intel.com>
 <20250401201349.GA1676401@bhelgaas>
In-Reply-To: <20250401201349.GA1676401@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6211:EE_|DS0PR11MB6519:EE_
x-ms-office365-filtering-correlation-id: c1e8fcfa-d68b-492c-ae94-08dd72851b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?V/4Hvt917jZdQsn1D8iFsSCUiVj8qTVdvIdBAx+IgPPpLSs9UZcS50m1SiXS?=
 =?us-ascii?Q?tcn32RRJwKp3Ggm67f03rNEjPVDe+/b+hTeOetiS420yIVciI+A84LzXIqPL?=
 =?us-ascii?Q?NtpJmBAUCC7nGEZ2frUCdvLJHVpbtw5mu9glGhfFsIf0GdVFBMG2oRebaRJQ?=
 =?us-ascii?Q?ikNtg4hzZuu3ezYugP4YQScif6bF/nAovtocKU9M4AC6ytVfgUa8Kqbge9ba?=
 =?us-ascii?Q?BNeYzDvGzOYI+hy+v6pZoBP135njUNqA1sNKTVE5A8hcTnspOOs/JjATNRzK?=
 =?us-ascii?Q?E8US7x84Sn1oBO+kS0MfvF0nELjbIyz/mGuhddY25x+u94USmivXWemHAq2b?=
 =?us-ascii?Q?92/DIKFdZWWBTlH6Jmn1gTtfYbXjae4G6az6x4ku+gBK9U8vUkM+E9vq9puX?=
 =?us-ascii?Q?jq2IiHcoIvn501dqzMCAv50FB1Fqsee5zNhAsYYIV8WybQh1rsjSdNZxlcZM?=
 =?us-ascii?Q?97cuaySBcmRf95x+UCmrBiMzDbTWb9gxx/H9n1NNsti1GI1Yj2c1Brk2CANe?=
 =?us-ascii?Q?+ooRGvuzTMgVGR8GUMfnsGkTknn5oFZZVL9pHTCw/nNASVaAgq0sFtTESpqs?=
 =?us-ascii?Q?c1e8ioTql3jymJp58PuzdpxSPcJ0eYa4ieqL8PtgupV7r8PVICZozWNBHBbX?=
 =?us-ascii?Q?lqDssqBieedp3bSYzN3IkvoCqaqIzwFhFij6jN0hN9H4X4wjVkMlSzaz5XhY?=
 =?us-ascii?Q?gpXWHRA1U8qeVRQv//vzQuGKN7cqldJmY79Q0dugfU6qEcsE89CVvSzWVGLf?=
 =?us-ascii?Q?NUzkh/uJvnHTxAdt4Nt9Ryowo3//M/uu2xKLINrNxtn6dEnrFWfD90X/Lmg1?=
 =?us-ascii?Q?K6QJ4RH1/FDnse+c0fJQjKVyuapCwe0BGkZlLYYexqz/LwPrI4mRmQCue7tb?=
 =?us-ascii?Q?JEnBSCdqT6wXk81uYBo0pYtcL/iKGQpF056zVbpepVA48O+BRTqBKVe131af?=
 =?us-ascii?Q?hK93fTJSXEk0l2fcd+3frR9sNnekKuVEp5keot83wkY6k4yhKfdXhpRd2rR4?=
 =?us-ascii?Q?VM1dII0RWmZWS3GvpwPcvWwedbsjpXJhyB3peFqBdF6PWzXlNGyxGZWD1qro?=
 =?us-ascii?Q?0faoD+YtYvAS+b2GMVwKQfGHrA5ZLcHlulrOiTiM/1MpLUhexCtp0E1xKEHB?=
 =?us-ascii?Q?P87AgXltRJIQ0olUAiNDeAo0AohPLhpd9hhmrf84NNoCeqWLY0+gSSWtY1kW?=
 =?us-ascii?Q?gwytSfXB006BDhlSDQHqIQH+LLCDAs20NrTh0KbF+rzWGN27PQnzGwZo2WsK?=
 =?us-ascii?Q?R7syqYid5pb27hCJbLBEZhow79OgXQZJmD2m3NWQnNxGiafD/6qiHOT9awJI?=
 =?us-ascii?Q?3KlHlRLJNJKrH8U/OuHbQdjwjPAkalJVJNqD8AkEKE6iOtJ2h4iJck+EMcQ5?=
 =?us-ascii?Q?tIkB32pREdOVfb5vqrvqciEcHz0D3WA7Gnc/mtSFxvzHhVsrDGEiJcGwCI2C?=
 =?us-ascii?Q?s0r/aP+3H3Usc8HfBG2A2CPe389OOypf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AW0Ml2FNub+myJ7BemobiCVw5UOJ6fFQs6S78whrGG1LFarnWdTVy3hSc38M?=
 =?us-ascii?Q?BJEk0U4cwjDFpeIIUfK+k1vy2ZxUD4sVQGBomAyi9aIY9oGt9NjP5fud3nGR?=
 =?us-ascii?Q?6IWeRHOHUy3eudlWEsw5zX4qgwDvpBpuHtV4G1ZaIb24RZkkMSMWHag5zMSL?=
 =?us-ascii?Q?Vd1U69s5U/HQD4UsSotB2TmJ/lkaogJp9xkamv/aFwnMHFPoJ6kJz9e20zLX?=
 =?us-ascii?Q?LbFfKRMPdG7bwXIybFOgb/0nttPf5V/kM/ANBWNCsYaOiCH7f2f8ZYfrPJsL?=
 =?us-ascii?Q?/WEM7E+PGqZUresseITXO4zjzQc4H6akhZ1a7MDvRL8vF2Cyc0HChig+sTjx?=
 =?us-ascii?Q?olv0RbTBEJpVASyedJU8K/ZqZU7Wkhutj9hZcZn6mcYCVjU0wlu9J+vCUv9d?=
 =?us-ascii?Q?qz68T+kDCk0ZfKnG0sHOolQufUDSTZ9Cmt+QaNzeAj8oLCiOpubYB8+NFTvc?=
 =?us-ascii?Q?dXtPVZV6la0Z5osbnHHhIBmzT+LPPx5ISzWOLaTzAme1US5P1cKTSvXNk4K6?=
 =?us-ascii?Q?9ewz47PzuNppCL+bEYMrNutfr7aqzK6rzDmpOsAXGRJZ0Noi5eeIiHT1Psdt?=
 =?us-ascii?Q?o6/AquaQZ/LmqvJSpc/7FstXh/pRejA+b4IMLLX9r5uFS/CKqVnKxR1OSDr6?=
 =?us-ascii?Q?4OQZZV0i2EnvA75GSB6d02DKPPkk0bC2ju7a3NusjmyCV1ut+GFGDOqNEN8/?=
 =?us-ascii?Q?U7RKcu+hLrh1/fU/F8zhNZxKPAV4lEnwss/9FUN562q7JyPdzFXDbfDaN+i3?=
 =?us-ascii?Q?VbqZS2pjey4puamfQJiCLs0CnF4Jzp5A1rN4oxe1fnkPX9aMpFtx18Ue9cRN?=
 =?us-ascii?Q?0HivDtwv9fhzxR/daJacZib+/0gmp+n957NVBumIbK7mrn4iFOWH3jRI8NU4?=
 =?us-ascii?Q?ec3bxZ6d/UZMIAE1eRiKwawrqfIdNgyT/VGIiGUffd8Z75hWQJQ4U1UiOrVf?=
 =?us-ascii?Q?LMdDAbBExBRpxNrhkGPiqKploGLfxchh06++Zjo31LxLBGE5JzqyMmnMDf0A?=
 =?us-ascii?Q?IYFxPQ2Udns3mbkw5qGz8N8C5y/zBa2rCozewFMoAWKRuMwCyzNN+70bBeGK?=
 =?us-ascii?Q?3yy/xajGLas4tscbZhMGhPgd3VwYlAHu5u5t4E2I2IcVLr/gKGC50H0cV7Ql?=
 =?us-ascii?Q?hdq48ztuSuiHa3b4/crZQe+30g8he1UDphqesnPIk3nGCSgGPq8nHXc4Stfr?=
 =?us-ascii?Q?eRmzXQutptn4JGY9SdRS5DRJWKrFbCbOZbJYfh3AY47jp6XyCy+KaTdOYrDE?=
 =?us-ascii?Q?lq6xJJVTlXw5E7b6HYWEJpFe8g1wNVvjsdKnQcLp9vUyBONr8kg+tcr2mx/S?=
 =?us-ascii?Q?nJ5dof0785jhWFATJhAHXfgKoQ/XPK7E2gDfT7VU+/U8sA/TSavFxtdirf1h?=
 =?us-ascii?Q?osr27+fbhnN/x1eFiVrXDRCOWnsDke67Gh/Lcz7W/tkjjESxdfvIWZxy2CUg?=
 =?us-ascii?Q?nu0UoZ1juY8GaU3py7KjrDpMulRnmedHJGENWb98U4qW2XIxNPqshhK+xw/p?=
 =?us-ascii?Q?Kos06bnpK10PY7H5+IF/OVDE3SrxN52qSk9VFE+tpOrABF7IoGsK/DuqJqGU?=
 =?us-ascii?Q?YXmS6MK43V/WBcoqBF+upFMqp0aJaKaUo0ARZBRE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e8fcfa-d68b-492c-ae94-08dd72851b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 07:56:56.6142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49AW9kRG/qpPRImnVtgYR78mnisNuDjbNE3lVVMoCMSYssVlYSZAl3hGBqVFvRvpzER44ZwTb/ZqdIZdj+Yfb0jA8ZMt801KObEtAK+RZ3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6519
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, April 2, 2025 1:44 AM
> To: Gupta, Anshuman <anshuman.gupta@intel.com>
> Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nilaw=
ar,
> Badal <badal.nilawar@intel.com>; Gupta, Varun <varun.gupta@intel.com>;
> ville.syrjala@linux.intel.com; Shankar, Uma <uma.shankar@intel.com>
> Subject: Re: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
>=20
> On Tue, Apr 01, 2025 at 09:02:16PM +0530, Anshuman Gupta wrote:
> > Adding a notifier to notify all PCIe child devices about the block
> > main power removal. It is needed because theoretically multiple PCIe
> > Endpoint devices on same Root Port can request for AUX power and _DSM
> > method can return with 80000000h signifies that the hierarchy
> > connected via the slot cannot support main power removal when in
> > D3Cold.
>=20
> I wish the spec used different language here.  "D3cold" *means* "main pow=
er
> is removed" (PCIe r6.0, sec 5.3.1.4.2), so it doesn't make sense to say t=
hat
> "the slot cannot support main power removal when in D3cold".  If a device=
 is
> in D3cold, its main power has been removed by definition.
>=20
> I suppose the spec is trying to say if the driver has called this _DSM wi=
th
> 80000000h, it means the platform must not remove main power from the
> device while the system is in S0?  Is that what you think it means?
Thanks for review.
what I understand here, S0 term essentially means here PCIe Runtime PM or s=
2idle=20
(both refers system is S0 state). AFAIU during both Runtime PM and s2ilde p=
ath=20
Root Port can transition  to D3Cold if it support _PR3.=20
I observed Root Port either have D0 or D3Cold state.
/sys/bus/pci0/devices/$root_port_bdf/firmware_node/real_power_state

Driver can disable the D3cold by pci_d3cold_disable(), so I wonder there is=
 no use
case driver calling _DSM 0xa with 80000000h. =20
PCIe specs shall be simplified by removal of value 80000000h from _DSM 0xa =
Arg.
>=20
> The 2h return value description says it "indicates that the platform will=
 not
> remove main power from the slot while the system is in S0,"
> so I guess that must be it.
>=20
> In this series, pci_acpi_aux_power_setup() only supplies a 16-bit
> aux_pwr_limit value, so the driver cannot *request* that the platform not
> remove main power.
Yeah but that value Xe driver received from GPU firmware.
>=20
> So I guess the only scenario where the _DSM returns 80000000h is when the
> platform itself or other devices prevent the removal of main power.  And =
the
> point of the notifier is to tell devices that their main power will never=
 be
> removed while the system is in S0.  Is that right?
Yes the notifier will safeguard against the use case if some other PCIe dev=
ice
calls _DSM 0xa with Arg3 Value of 80000000h or its request return with 0x2h=
.
>=20
> > This may disrupt functionality of other child device.
>=20
> What sort of disruption could happen?  I would think that if the _DSM ret=
urns
> 80000000h, it just means the device will not have main power removed, so =
it
> won't see that power state transition.  The only "disruption" would be th=
at
> we're using more power.
Let's say during Xe Driver initialization BIOS firmware grants the Xe drive=
r=20
Aux power request successfully.
Xe driver will prepare to transition D3Cold state with VRAM Self Refresh.
VRAM Self Refresh relies on vram shall derive power from Aux power.
But later at any point if some other PCIe device under same root port=20
Calls _DSM either with 080000000h or _DSM returns with 02h, will
Block the main power removal. But Xe driver is unaware of it can still
program the VRAM Self Refresh and that make VRAM to derive power=20
from Aux and that will disrupt the GPU VRAM as there is no switch to Aux
Power.
Thanks,
Anshuman
>=20
> > Let's notify all PCIe devices requested Aux power resource and Let
> > PCIe End Point driver handle it in its callback.
>=20
> Wrap to fill 75 columns.
>=20
> s/Adding/Add/
> s/Let's notify/Notify/
> s/and Let/and let/
> s/End Point/Endpoint/ (several places here and below)
>=20
> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > ---
> >  drivers/pci/pci-acpi.c   | 34 +++++++++++++++++++++++++++++++---
> >  include/linux/pci-acpi.h | 13 +++++++++++++
> >  2 files changed, 44 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> > 04149f037664..d1ca1649e6e8 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1421,6 +1421,32 @@ static void pci_acpi_optimize_delay(struct
> pci_dev *pdev,
> >  	ACPI_FREE(obj);
> >  }
> >
> > +static BLOCKING_NOTIFIER_HEAD(pci_acpi_aux_power_notify_list);
> > +
> > +/**
> > + * pci_acpi_register_aux_power_notifier - Register driver notifier
> > + * @nb: notifier block
> > + *
> > + * This function shall be called by PCIe End Point device requested
> > +the Aux
> > + * power resource in order to handle the any scenario gracefully when
> > +other
> > + * child PCIe devices Aux power request returns with No main power
> removal.
> > + * PCIe devices which register this notifier shall handle No main
> > +power
> > + * removal scenario accordingly.
>=20
> This would actually be called by the *driver* (not by the device).
>=20
> Reword in imperative mood if possible.
>=20
> > + *
> > + * Return: Returns 0 on success and errno on failure.
> > + */
> > +int pci_acpi_register_aux_power_notifier(struct notifier_block *nb) {
> > +	return
> > +blocking_notifier_chain_register(&pci_acpi_aux_power_notify_list,
> > +nb); } EXPORT_SYMBOL_GPL(pci_acpi_register_aux_power_notifier);
> > +
> > +void pci_acpi_unregister_aux_power_notifier(struct notifier_block
> > +*nb) {
> > +	blocking_notifier_chain_unregister(&pci_acpi_aux_power_notify_list,
> > +nb); } EXPORT_SYMBOL_GPL(pci_acpi_unregister_aux_power_notifier);
> > +
> >  /**
> >   * pci_acpi_request_d3cold_aux_power - Request D3cold aux power via
> ACPI DSM
> >   * @dev: PCI device instance
> > @@ -1466,17 +1492,19 @@ int
> pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32
> requested_power)
> >  	result =3D out_obj->integer.value;
> >
> >  	switch (result) {
> > -	case 0x0:
> > +	case ACPI_AUX_PW_DENIED:
>=20
> Add these constants in the patch that adds the _DSM.  Then this patch wil=
l be
> just notifier-related code.
>=20
> >  		dev_dbg(&dev->dev, "D3cold Aux Power %umW request
> denied\n",
> >  			requested_power);
> >  		break;
> > -	case 0x1:
> > +	case ACPI_AUX_PW_GRANTED:
> >  		dev_info(&dev->dev, "D3cold Aux Power request granted:
> %umW\n",
> >  			 requested_power);
> >  		ret =3D 0;
> >  		break;
> > -	case 0x2:
> > +	case ACPI_NO_MAIN_PW_REMOVAL:
> >  		dev_info(&dev->dev, "D3cold Aux Power: Main power won't
> be
> > removed\n");
> > +		blocking_notifier_call_chain(&pci_acpi_aux_power_notify_list,
> > +					     ACPI_NO_MAIN_PW_REMOVAL,
> dev);
> >  		ret =3D -EBUSY;
> >  		break;
> >  	default:
> > diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h index
> > 4b7373f91a9a..793b979af98b 100644
> > --- a/include/linux/pci-acpi.h
> > +++ b/include/linux/pci-acpi.h
> > @@ -124,6 +124,10 @@ extern const guid_t pci_acpi_dsm_guid;
> >  #define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
> >  #define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
> >
> > +#define ACPI_AUX_PW_DENIED			0x0
> > +#define ACPI_AUX_PW_GRANTED			0x1
> > +#define ACPI_NO_MAIN_PW_REMOVAL			0x2
> > +
> >  #ifdef CONFIG_PCIE_EDR
> >  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);  void
> > pci_acpi_remove_edr_notifier(struct pci_dev *pdev); @@ -134,12 +138,21
> > @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev
> > *pdev) { }
> >
> >  int pci_acpi_set_companion_lookup_hook(struct acpi_device
> > *(*func)(struct pci_dev *));  void
> > pci_acpi_clear_companion_lookup_hook(void);
> > +int pci_acpi_register_aux_power_notifier(struct notifier_block *nb);
> > +void pci_acpi_unregister_aux_power_notifier(struct notifier_block
> > +*nb);
> >  int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32
> > requested_power);  int pci_acpi_add_perst_assertion_delay(struct
> > pci_dev *dev, u32 delay_us);
> >
> >  #else	/* CONFIG_ACPI */
> >  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }  static
> > inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> > +int pci_acpi_register_aux_power_notifier(struct notifier_block *nb) {
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +void pci_acpi_unregister_aux_power_notifier(struct notifier_block
> > +*nb) { }
> > +
> >  int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32
> > requested_power)  {
> >  	return -EOPNOTSUPP;
> > --
> > 2.43.0
> >

