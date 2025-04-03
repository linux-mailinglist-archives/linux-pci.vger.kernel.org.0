Return-Path: <linux-pci+bounces-25212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9526A79BA2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29FE1706C9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F3B19ABDE;
	Thu,  3 Apr 2025 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOx3ou2w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267A33993;
	Thu,  3 Apr 2025 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659995; cv=fail; b=pGBarjTQXG9UaWDtm4LBG1ribtS2fdTAcMw4mHXGEFm7bxkeyxkqcE6Aewi5JFgmfhsVhDnVF5LU86RqZnXI3i1YLEANpr2zJbJ5ySK88E4qsfSzsPLwlTDuvGzntk7MqOfsy10FruUbbB1z9S4qxUnAQN74Av0Tm/zqDoe28lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659995; c=relaxed/simple;
	bh=aXpcZ+e+fAUiJufuNBs1U4UpMJjmvll8US/1PoLh5lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RSfCWxMU0ggH4ozy6nIVlIi5m97ExJkoSAIQIVVRebLvVNutymh6YLK/TBsz8TjxVL2HftgwDrLpKDBa9bATNan44ayJsRufTiYBds1pQV5ke39A/PN7FdoIbncWSEcIjFwhka1RnrpkX8fgKPVQS7erp804pJ7gIT0yQMiB9Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOx3ou2w; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743659993; x=1775195993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aXpcZ+e+fAUiJufuNBs1U4UpMJjmvll8US/1PoLh5lM=;
  b=dOx3ou2w9PE+KrqsymNlykRIeK5GBTD26UoWp/5jrOJwzYyW/5s4fV0f
   Zoi4G2xl+h9yr1f4yuOvBAS8oCm0fF/HBTO/EevKVbbhnHsDFe57R+wMX
   XRWdeB9byzTM9BYdkaZPij1OiB8r4cYaJZjvNZ2x6xqVgvLjiF7n4y45P
   nCL7/DGYZcdZMam7ahJhdk1ZrkJwIluxsyaMaKJ9trIuUW7GY0Q4qlOom
   JR9w0HPUm/mrA7PZ/zxyLvqwoBMFf/q9K59sy/x060OsAt7Iva6jgD/rT
   YiUcXXBDC0JIMBb6w1C5vYiqx0rRrf8BpBUOQHQEhLvNsOevcxduTGGnk
   A==;
X-CSE-ConnectionGUID: phoYoAj7TF+0oI0vmPWM4w==
X-CSE-MsgGUID: v61jBzxZTX6bBJqi8YmtEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="56415125"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="56415125"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 22:59:52 -0700
X-CSE-ConnectionGUID: vReob5XARn66cC29VmoD6A==
X-CSE-MsgGUID: R0I6z2m0QDWSxUOnNlUgCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131034296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 22:59:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 22:59:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 22:59:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 22:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDpZCupp9rZkgpv1QocAxWZK0Oc5O0Wk4NwDL+lu15aQLlzVFqyHJwpeclQWCJ+Cd5mYIG4xCnhyKn+d2lQLhmsejbo07Z3qg4xwihh9FGZuV8EepCgMnbQSxr/4wJRcLW7UwKGWue6pQwy6xufEXbwcCK92qmVMUv9pOV/TJ2CFlOcsp1rXucpobWVSkEkp96Pb+MSYSHzOwIy+xxOFJq11bQNsD3xViZMqdclkXFvXBre35DiQjclG+OHZ/+pL1/aenet7+kcnErkCCV+XGD+yR9oXuJyIzvjsWGwyhJU+g+add5qce/FZ/XfvPU/B5O8PP8CEvABs9q62PxbCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmQUe8PwxBoV4d1S/wIvbXjl4WBflbb7GsPvw6Sa97A=;
 b=zLLlPgaXUAGkJSdXMV759AJvnd7xJi8t6wKZd8mAGs6peVAzCQm51EXRhae1DxsDN1NKz172XjxCAtrrnviWrTt10tB+RTeWrWfI1oeIk76xERsMUXu+RZ9UAsxQQJUn1T3macbtoYELMvyzOZPqi0Qe1OXaOSkMs/1pdDzOQEwB6poVexfbrH2grj8awvGYB72XXVzBhZgnALFG88+yAJh1egshQknAYIJqsCyunx1lvzEE6YI0nvTOJ94PrN5QVM59Ennmkykr36KwTYcvg18CxWi0Og7/htn7lPmA4XH/G7HADUS1p29cQ9UecHhNXL0Gy7MeFDctN0rYS1q3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by DS7PR11MB7907.namprd11.prod.outlook.com (2603:10b6:8:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 05:59:35 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 05:59:35 +0000
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
	<ville.syrjala@linux.intel.com>, "Shankar, Uma" <uma.shankar@intel.com>
Subject: RE: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Thread-Topic: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Thread-Index: AQHboxvS9+UDiaobzUKCMXM+EIsD97OPIhMAgAJP7iA=
Date: Thu, 3 Apr 2025 05:59:35 +0000
Message-ID: <CY5PR11MB6211B618338BECAF408917F795AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
References: <20250401153225.96379-3-anshuman.gupta@intel.com>
 <20250401183030.GA1676293@bhelgaas>
In-Reply-To: <20250401183030.GA1676293@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6211:EE_|DS7PR11MB7907:EE_
x-ms-office365-filtering-correlation-id: 3c724e82-e445-496c-0465-08dd7274b608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lC/CLZYlSPrAtr+rQIgkCy4xvQ536HXxom5Lbr4QVsRorm+8DxLGOU9P8Ovp?=
 =?us-ascii?Q?F0Mn+clvSsxqYqf1QRmND2jGzu+oaS91M8o9uRJM8n+ViTk+YfmILIyzZpSf?=
 =?us-ascii?Q?2PgG1Qf44tkqK3RKm2QQMAQ/rUOptuR9eXhNYg8j+4QEuowNs55skhWkPO6R?=
 =?us-ascii?Q?WY5iJpyxkunNI9JsKqX5YZRffwyGecKvXeOqSmeLTwXnX3B1HlxX2iqv0DYi?=
 =?us-ascii?Q?Ioln/7tFMv1q4HzbOe/B/Ft6qioaGxchtMVBhV2MqOkqZ+IPeZb/qfieVkrq?=
 =?us-ascii?Q?tQydkECcXpxDZPyYRuewg+FR1KEAwLaBZ28jHqJHWSyzypqLv8pHkWBXdexh?=
 =?us-ascii?Q?mNDNJoS+hg83xukuDcDz3gCz6MsbvUvEzMoxVBJcFG/hEvpzdXymOVC19dTn?=
 =?us-ascii?Q?iBSeRkXndthjedr6p8SqegC5yoL5zvXYhaIjBtw6NixHJH/KcbWuTl/a5xyr?=
 =?us-ascii?Q?wVa80VSUT1R/3LJ3460tjoJbPPiHyNHZHrmLYIYN3lhudh0AdxGHDK9yoTWZ?=
 =?us-ascii?Q?pcP8fGm4CFZcrFepPi5IvFlCGKHmUwfngq0FqK4iE0LsIdg//DUjZsbWjgre?=
 =?us-ascii?Q?N7DrRjjNu016uN66h/WjMTbRHhlxwJw7talpyzm2LRdJyn2v22nW2x0169x3?=
 =?us-ascii?Q?BXuCPT0kDeawm8KQfbdIw5OC2CBB5r3pUPTsKnRrZZ5iKtIjXr0Y8fGpl1Fz?=
 =?us-ascii?Q?fK6G+GdAfGGc/QV1uWFXuS5BhTpQuLTW0u80pffvsuZC0z80RY3ZcciKfpCg?=
 =?us-ascii?Q?6h2p6d1EMt8U0qJotdxOnBY8Y6d8q6ylzUNySi5TZXQG6lrfRAMzVYPGPoli?=
 =?us-ascii?Q?mTj+ctWCJ/py4wLTW0MfX6TnzfP4j3uOc1EVk2oxb7UQgTV/cL6aRr7VtFkc?=
 =?us-ascii?Q?WgpSRnQTpBEZ9OUdDa/vowIaoNgmMd4rzts932iR7HHfgWAJDy9/E7EN3JBe?=
 =?us-ascii?Q?vKtFLYZTaN5+Hls5p8Rd2GoZ6Xhc8RHPdl4e1aKPQJccsP4CBiGCSCbBZ1op?=
 =?us-ascii?Q?Uy5skHL1mz0doiqZFciISy7BLiLK3xE9lH5lX5rMXn8YaaCEvTEsYUYz2V3P?=
 =?us-ascii?Q?7H0kYpmNuLdoBh6AGBCC8KedCnrKFhX+h3hrvla0vy0oWww719hkdiHE6oMS?=
 =?us-ascii?Q?xmg56I6ySmwEuJ5THL5phHez861WoUzMMVCJA3fOhJh3Z/WFnPzdv+GS1Huy?=
 =?us-ascii?Q?aaB67td5LhW2qaI9zPMV8mR7Nk179+lzmvuczNhyay6+xxxS8+rMu/GSNRol?=
 =?us-ascii?Q?FkIe5UvOsyJhRWZGjUMZuUGV9WSoPstAqDi0r0yi5GfQvnsItdlh3Ue1A3Xm?=
 =?us-ascii?Q?P06Rs6EcErySOBMswi5a1ZTjoO4b4oP1p2H1ansdF/+uphVeX5MunmCIQ16x?=
 =?us-ascii?Q?Rt6zWMNVs0KAzLDJgJetHmlH7dsF6FNpP+k9+r4dd7uyEgpCjNq0+RKXDZKI?=
 =?us-ascii?Q?VofJbf0xuZBBMIpOW+idzD7QFmaXJY59WZYGkyjrNbaSnBvEZzZvkQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o15FN/nMidIgObMg7iAh7uCANBkOGtsz7+GdeCZGUZhUrb0zFG1ieFVMh2xP?=
 =?us-ascii?Q?HiMlfZilmzlHeLdHqnsn+abEmjItA5eCKAWtHmsm1C9d+vCUTUXXyviWhiSG?=
 =?us-ascii?Q?7I+qAKI53VzxNmOtO1qwoO8GlUpzfp/iKjGicJAXS1Z07o42S8yphLyLcWgt?=
 =?us-ascii?Q?ifCKMKu+Dr0y1E1k2KK/M16DQ2/xOyc2ltClw3FQREjT11u6c1mCHbVD83zN?=
 =?us-ascii?Q?+Zf0qPpWYPMRvkg95Ow8mWWanansUJuRyKUbpEUmYB6UIqqAfboSV9IzEFOQ?=
 =?us-ascii?Q?G/yXPAwDlstz+uNqfWHyrBRFf81lOfZa/NgAbHI6hgBTPm38TgCoVma4fMQW?=
 =?us-ascii?Q?meBMO9W6qffuQklYnmRP5feENpesy9UZar701S0SiP2MVBF+mqoFE6L7VpLF?=
 =?us-ascii?Q?1jIFPhJdG8xYkNFDs6S4djfx8+J5/dKpb4awx5e0N22zrc84yw0minSPpseu?=
 =?us-ascii?Q?0CBDFalDf2TS6eaYeC+JK3Ztdnz4irhd6TB4CwORuwb/DSpJTtaYxDT3jAbJ?=
 =?us-ascii?Q?/cIgfM6saBFnRo9DC3VoGaDIajflFCEn2RvsuvRcpiisXHYVlfIHQ1AUj4MY?=
 =?us-ascii?Q?uWXq4sAXcvRhWvl88HSIAdG09l66L6Fks7KBol/E6pognAYONGocv70Y+MIe?=
 =?us-ascii?Q?54aql89niZdp8OnmfHTiEJWkLnmo8kChR1ctXtwlYweGG9UB7pgW6ihROSP1?=
 =?us-ascii?Q?LhbetPmVDElvZOJRgY5jM1nrevwRA7MH4275u71BLCf8Xry7KQznBxuFCe74?=
 =?us-ascii?Q?yqeoFh+BDHZcYD1+5zArBG/Hkep6USiU2T8g4lR1kUjOjxKXHmbhWWnFwreV?=
 =?us-ascii?Q?IJhoKG74VjtqQIMAOBrTuDiUjs6NTjTuV1bBQfxi2elAYWHOb8Gb7dQfzCUZ?=
 =?us-ascii?Q?SpbAndCbPCX+nAi8NfVCoFxv1YJXTRlFdfwa4F7Gzxj4+BT+fzxrEM3EklLF?=
 =?us-ascii?Q?q2LkpYsT64zjgJJ8FD1CMVEji3caVierCVDktsenQJYzTAlIPRe4l0rBvwwY?=
 =?us-ascii?Q?YupGBg7/PTZlxLlCLPJB/dEBsMfR60J22bnPwi8f89TZ0AZChkeTSQN4Usqc?=
 =?us-ascii?Q?kJxs8oy+Sj12pWUVlJLq05k5h7fX6VmXIs2wgotcsFaRJoeZX1V4Mq1eWxOW?=
 =?us-ascii?Q?M7Zbyou+d7//Ee/1lolTKS4ZIT3qbSpSVvqW6PFsUaRciSQ2stzBaP6TeoZW?=
 =?us-ascii?Q?m2gyMI18xOnjt/hQmCvF39O1IwkcOd56xXb8tsJS94B/YzUfyNvSTuq/DGlL?=
 =?us-ascii?Q?X2gm2x5omGB2NObvLSd6bAqJxF3eh/fdEvs8OPclYoxwSRt+uCtpkoyx1PaL?=
 =?us-ascii?Q?6AJB9SExofhx0hYmjotjcXvi0VO4Kzt3xKWhYStwL0Afvs3gsIithwvGdhvT?=
 =?us-ascii?Q?ylL+BttcC1mwrZUHWUzGmEH8BxdTaFwUKYEQR97E/REBhRcefS/KgYo8KIK2?=
 =?us-ascii?Q?oWFdLsxVbUr7wS4A0DEoTNr4j5DaEW6CviQmEEnnEr6c98SFJglGMCwsFeS/?=
 =?us-ascii?Q?s5qhzHTfDWYfap37TFrxbaFv4V+W+2dDgDlid/Kc5DXWTPswBl7UJhaqHh3q?=
 =?us-ascii?Q?jnrEA5CbMntOqBYA48w6PFPIChGOlGXaIoyke/rR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c724e82-e445-496c-0465-08dd7274b608
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 05:59:35.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goycKIekBAVkG0HJKkl+wshYrZXpks6cdlfKAnhecel0+QhZALInRAzmCO85AmvPj6mqBlCZSEmPq8aLVi/A/7greFYVR+FC/6jLHza3yok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7907
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, April 2, 2025 12:01 AM
> To: Gupta, Anshuman <anshuman.gupta@intel.com>
> Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nilaw=
ar,
> Badal <badal.nilawar@intel.com>; Gupta, Varun <varun.gupta@intel.com>;
> ville.syrjala@linux.intel.com; Shankar, Uma <uma.shankar@intel.com>
> Subject: Re: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM
> method
>=20
> On Tue, Apr 01, 2025 at 09:02:15PM +0530, Anshuman Gupta wrote:
> > Implement _DSM Method 11 as per PCI firmware specs section 4.6.11 Rev
> > 3.3.
>=20
> "PCI Firmware r3.3, sec 4.6.11" so the citation is major to minor.
>=20
> "0xb" or "0Bh" to match spec usage.
Thanks for review,
will fix it.
>=20
> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > ---
> >  drivers/pci/pci-acpi.c   | 53
> ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-acpi.h |  7 ++++++
> >  2 files changed, 60 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> > ebd49e43457e..04149f037664 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1499,6 +1499,59 @@ int pci_acpi_request_d3cold_aux_power(struct
> > pci_dev *dev, u32 requested_power)  }
> > EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);
> >
> > +/**
> > + * pci_acpi_add_perst_assertion_delay - Request PERST# delay via ACPI
> > +DSM
> > + * @dev: PCI device instance
> > + * @delay_us: Requested delay_us
> > + *
> > + * This function sends a request to the host BIOS via ACPI _DSM to
> > +grant the
> > + * required PERST# delay for the specified PCI device. It evaluates
> > +the _DSM
> > + * to request the PERST# delay and handles the response accordingly.
> > + *
> > + * Return: returns 0 on success and errno on failure.
> > + */
> > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32
> > +delay_us) {
> > +	union acpi_object in_obj =3D {
> > +		.integer.type =3D ACPI_TYPE_INTEGER,
> > +		.integer.value =3D delay_us,
> > +	};
> > +
> > +	union acpi_object *out_obj;
> > +	acpi_handle handle;
> > +	int result, ret =3D -EINVAL;
> > +
> > +	if (!dev || !ACPI_HANDLE(&dev->dev))
> > +		return -EINVAL;
> > +
> > +	handle =3D ACPI_HANDLE(&dev->dev);
>=20
> acpi_check_dsm().
Will fix it same as patch1
>=20
> > +	out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> > +					  DSM_PCI_PERST_ASSERTION_DELAY,
> > +					  &in_obj, ACPI_TYPE_INTEGER);
> > +	if (!out_obj)
> > +		return -EINVAL;
> > +
> > +	result =3D out_obj->integer.value;
> > +
> > +	if (result =3D=3D delay_us) {
> > +		dev_info(&dev->dev, "PERST# Assertion Delay set to"
> > +			 "%u microseconds\n", delay_us);
>=20
> pci_info().
>=20
> Join these into a single string, even though they won't fit in a line wit=
hout
> wrapping.  This is to make them easier to grep for when a user reports se=
eing
> the message.  (Do this on the previous patch too, where I forgot to menti=
on
> it.)
there was comment in RFC to warp the line with in 80.
Will join the string.
Thanks,
Anshuman
>=20
> > +		ret =3D 0;
> > +	} else if (result =3D=3D 0) {
> > +		dev_warn(&dev->dev, "PERST# Assertion Delay request
> failed,"
> > +			 "no previous valid request\n");
> > +	} else {
> > +		dev_warn(&dev->dev,
> > +			 "PERST# Assertion Delay request failed"
> > +			 "Previous valid delay: %u microseconds\n", result);
> > +	}
> > +
> > +	ACPI_FREE(out_obj);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(pci_acpi_add_perst_assertion_delay);

