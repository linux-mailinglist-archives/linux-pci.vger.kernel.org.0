Return-Path: <linux-pci+bounces-25213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44CA79BCE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 08:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AA51890789
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 06:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116419F42C;
	Thu,  3 Apr 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLOBbtkz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FC19F416;
	Thu,  3 Apr 2025 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743660619; cv=fail; b=L94qtJNtDei76l4exSWFoJwkUSEv6K2HrkWz6HYTfKHNo7dHb1CHWTU6N12zkparF8etvbl/sE2cPCeA60e8c5LbCipMrtgc3w5nSAmzgHR49IFWkwcIEYPWiaMYUdFLdJTw6O7aMflipv0v6fh04CGjjTDLYAy7fqJd3qtoeHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743660619; c=relaxed/simple;
	bh=9uEsbsiABhRfHJhq6yNkPHAKNcI4ZLihuQWp0V0vbX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u8W3FlXlj06vYeBtupRPfz8YgxEz6a/9T8tNfdAtUkp7sK7TwoIDXQwiB/Mihc7GXaAtdT6CH8U5BcJi6GNTBtbqkw62CV585h9vK9/qaIXBKqTciHRKsSILw/6CHpqTkPFOwcmjzMbcFulIDgUHgyoM+RwhaiG8Rq6q5DLrTzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLOBbtkz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743660619; x=1775196619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9uEsbsiABhRfHJhq6yNkPHAKNcI4ZLihuQWp0V0vbX4=;
  b=lLOBbtkzDEJ/43NyzuHvMjripXJBWh5p0CmQs+vm+GaZnzm3qJzTSUB/
   ShwwZJmNwGJQtlfXPWw/ZKLCRz3dKI/TPYosnYECPeQuCEsTcOkaS2QvV
   OZfOTvKycpEzs/+hCHEGNEVRTFvqNI5KvmfGEqLxksdl/DY5K3XX5TRXH
   B3pSxYmST9in7Tc05RkWJJH2VNbyk90Rkd7a/xJ5fC73vXVMNEZAmfn+H
   1N6Yuhr5XitxsvRT95qLDgVmsZdKZ2+7y3iEd63bD29fx3C3hIhM38pR8
   b3r1mD8Y+hfZmZNTNSUkvicoNFE00WeR9bvTvJt+wcyWNUQ47z7S0/tBj
   Q==;
X-CSE-ConnectionGUID: Cd3ks1PhTcCO5jNfsiVmtA==
X-CSE-MsgGUID: KOOH2gEJSn2HPbUpHIIv4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48839378"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="48839378"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 23:10:18 -0700
X-CSE-ConnectionGUID: pMWlmudjSwmlOh0axHLVBA==
X-CSE-MsgGUID: qdDTAd+gQr2NBkQoqtsT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126718353"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 23:10:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 23:10:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 23:10:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 23:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voi///h0NLuFJI6B5fLE/UPAV5hsBQ8uPEOoyOXuwGjh1i84mBFFfwoob76c6yUyTh0ogqZYnSiMbQxSw27eypRAii5ZqJHzioc6LvMCz3Ru50MIvfvUPpYv5Rm08yJwjUGGioFgOlInAJqDeHyQ6AeKv1eRShBdW5udViB6kIQHaanS4zqPHNgQ0O+n9ebEjjR8PIBxTcI4VU55qma47vhiM+bl7gV3zqsxx19poMRra+87KD8OTG0RQ8apHZgsCo9gZ1TT+DsBcchm23a2T5yZ0zoY3Vhurn4ew5byW34LHe6S/YUlsKK2ZxFHXI/nkEEL9XuTEv34cO5CnlLd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9b0cOEV3yISyKHQ9ZVAhA5ezG4VYo3Wt2O7UlI707E=;
 b=kTibZt+FKV1BP1N2iIuy37ugAI866SUg9bJOih0epNOrsIGGoFACAT06qk4BszFLCPL4RUdxXy0MfO+FR2nIH01sI8NQRbq5DnVRclHNXMzvWObUMwqnYLWVXqd5ikS9as5rrSpTHop6866ewOCQ992M25ejPnO+Ekax/5kDjlX0CRuxASoLORyPmxImhM+pMybMgTpsQebCkcx2G4+ZII58cvDv8GtMn9eR3VHe9VTlZGfOIqpoqnVrlxvKJ9iT2H5smkFAsfbr4iJtV14Yprj5LDhQAwq99hbVDMa1XOEU+0jODUFlSGPOWvr33JAt8quiWJSDddn7xo/ZXJc5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by DS7PR11MB7907.namprd11.prod.outlook.com (2603:10b6:8:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 06:09:34 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 06:09:34 +0000
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
Subject: RE: [PATCH 06/12] drm/xe/vrsr: Initialize VRSR feature
Thread-Topic: [PATCH 06/12] drm/xe/vrsr: Initialize VRSR feature
Thread-Index: AQHboxvZbQEXfrJ0SkSeD41Dnzp9mLOPOiCAgAI9JTA=
Date: Thu, 3 Apr 2025 06:09:34 +0000
Message-ID: <CY5PR11MB6211EF836A372FC22C748C8895AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
References: <20250401153225.96379-7-anshuman.gupta@intel.com>
 <20250401195635.GA1679245@bhelgaas>
In-Reply-To: <20250401195635.GA1679245@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6211:EE_|DS7PR11MB7907:EE_
x-ms-office365-filtering-correlation-id: 983e0272-128f-4ff3-aa13-08dd72761b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jY4rcaGgPMj2vQ57hsUaG4KOr0ihDkA+ItkNqVSab2jkvJsdwp2dVpwsVd3U?=
 =?us-ascii?Q?SLhHUyqMjDeJfML59JHyPAS5rAG8lmVPeufwMT5vKPVBxkIq7IS7JoXTJvrO?=
 =?us-ascii?Q?az38IEZMYxLZStjzA+mPsYcErSPWawTTJ0ES+4DjcIhJOMkLqBFmrYRkTIH5?=
 =?us-ascii?Q?LpNbhcS4BWXwidSg7hKtzP40mO6OiBdVkbFPLo2iMr+LtH65zABlS27PO/3T?=
 =?us-ascii?Q?dJgnKvPQXkBnPDgceZaVgLQS81Yd1wiLiFJNGO1FYTrdi/cdzh8M1iJYxcSE?=
 =?us-ascii?Q?nyT4JhrV16sVDhClUnvW3lKJTpTa2/Rmm9Nl2nqQf1sOyH1wRDnepDcc/6Xf?=
 =?us-ascii?Q?gdGpfApeyiVFFp18FiaeGdMRAJxOQsM37X8GdOcCn7gTShdUTFtQeGKqvGqE?=
 =?us-ascii?Q?B/++Z8k+aIT7dDpwEUcRZ5vD2fL31ZiXL+/P0EAHGlE2oYkQ9tRZOLZ7KWiU?=
 =?us-ascii?Q?gecCjax+MsHr5WZgQxNEqYdOycvWbn1PpodyeuPEnlmgxiLS89SncT2ZLjST?=
 =?us-ascii?Q?eho76UuGIgxll9zwZfF8eZSQRy95F6/SXwkFDKDojlzhjJlOpClHcoFSZsDV?=
 =?us-ascii?Q?2+h+XA89ks9vVnzuG4ihmJiukMoaV5kthqlCecAHdvn4SEYyBSAVRnIcaw8A?=
 =?us-ascii?Q?b9ub26JFy54biQeegu2XfqaLB5WbyroglC+YdhP/CWDjmaekKVybHtRhEp+/?=
 =?us-ascii?Q?kO1B/rcyIMcxCi2izZyLXSh/uxVNRlos+EUJds7YP+xvYfLErfQ2mOsVBGtp?=
 =?us-ascii?Q?AlzwM80QilXN0bMshaoZGV6M4rqKV+FuOywsGHvKDnrHRnnk/CwYSwC62GWq?=
 =?us-ascii?Q?V1sd1Uman9sRO0ZU419ZZvTdVNay3cY8p7BKf3KzYshvu+BzG6xXfoNKnA5o?=
 =?us-ascii?Q?gHoTStaFbwnuNc7rvJZeR0m7P0HBsVx+7O3vRInnZmFOHjeyAVEZQNs/jsop?=
 =?us-ascii?Q?caJO2IZkXJ9U11ndAAr+r4GtVfrVl9WeShaoHs7u9U09ypYsixetNcoNsnQi?=
 =?us-ascii?Q?02K1vjSvlwmapGgmyh63TEb0xHGwoQJN+EvjQQaeF9gXfnL2pQNpw+YOUYI4?=
 =?us-ascii?Q?yc4EpHrCHGKVEprXDEuxFRBZsoXPnlyaCbWpVlCbcf5kyF+SZ3mZ2np76Py8?=
 =?us-ascii?Q?/1m+Ye01gcpoXErz5abL0PLz1WzkmPlX/Sdt0KoyLvuiKIvL6lV3DzuxRkKM?=
 =?us-ascii?Q?FW4ec6Rmp1LxcYt743dSUaxrJk0YHgIIE28A4cHZEQUzDpN6c0pRVkUVIeAE?=
 =?us-ascii?Q?Mt0hiU7YGrlh/hO3f0x9B3v5UipQRGf/CVxvnJ7Q8ZKIRoLTz62wq4g4O2eN?=
 =?us-ascii?Q?BzriY1DjtTHKkDvr4oGZYeNFDido2pZXP+Z6I1sG2AaoZCF15ZHfjxX1tqCP?=
 =?us-ascii?Q?gr1BIUHn54nAWIjm9pZyIfuvWOENFio4LcnotRYy9NZGpCkgD/9QrdGEfI+Q?=
 =?us-ascii?Q?cTerMCheGajVogclAGgmDNPvLXR94KS/Hpv8TXZU9htD2hn98ULD6Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9FlL4JmTBiS53fzu+86QKfV/mMJz8ijEY1friYGbeScSWBOed39HGIVTFkbj?=
 =?us-ascii?Q?4n97oM9OdlbJy4hPi9k3idfSn5+Z7jiiyaDs08oX5YtCM53JuhSfsUGYDop+?=
 =?us-ascii?Q?/WcNLW4hMPrYDswnq0ZSCgJF4K4VXt/ukOm0zVCQ9xlDkbRjrtr5geOCrhNd?=
 =?us-ascii?Q?Lq3pIjyw0Kp2D0F/fM/pIjK60QSFU/OXZ/STUUdQ6N52gM8Hq504hZXltOX4?=
 =?us-ascii?Q?yDH7akH26Hvl74fHSIa+j3xLm4wKVBhyixWi0XI5gMfPzAxKmLt9T11b5ys5?=
 =?us-ascii?Q?a7pSCDgTBvr0HXXHQZFBAqv1ybj0Bkj9wIG1jtsDXF0rE4c8sWWRY3ayAHah?=
 =?us-ascii?Q?EYodZ7pNuBayY/1udxQbfDXGzSnby0p3u2BewhohzIUxdTnLg+wHJHAvwaQD?=
 =?us-ascii?Q?8r8k4+/RQwE2XQbBhI75Vqcwp/FZWjnxkLP2kguE9XB2fRCa9szSYKQEEzlY?=
 =?us-ascii?Q?6StR9RqP3xMztxeXjpSQ/wZQEsUzhtfE46CIOB2yQHZoA5kqz/rBEz4EGMVI?=
 =?us-ascii?Q?PDf2th98ylZrrC1KOvyTc5MO3iTMboDza6a5o/y6du1uFS2Zsap0KyOVMRuL?=
 =?us-ascii?Q?UMKy23chsXqeolBG0UGDppWmmEUW+w0r3xfF26i3Yda8EVk25efBWlgq2U/E?=
 =?us-ascii?Q?lz5nggNHtM1ixHSLOOPhYzCnjgShfADKgNVz7B8QzBfDMkYSEqZLHQS++ddp?=
 =?us-ascii?Q?s8GPM0u8/c0hnmWvD4UHOUFmeQ2V5khyrEpBH/J9rcMXccLox6pNF9ICsgMc?=
 =?us-ascii?Q?5spQzG3bZKfq3ubuQ3iOWOuJQQ4AiSjpNegfoee6f/+i/UibQpxWkYRQ1wR1?=
 =?us-ascii?Q?O761BpLlXcrJ2Kv2KO3IOyb/pW8t+jNP7Hs2Z7xmv4ENzuSsDwgch5C/Gclv?=
 =?us-ascii?Q?4BqmVY0agByuXsLb1SLLv52uNeunvRu18nQ8akysFxBthiBNbk8ZW+lvoLGF?=
 =?us-ascii?Q?n3gRAE6GD1rDM9nvLxSMu85UaHz57BjVQD9QpPW6v7ErKofzn08euJV8mSz4?=
 =?us-ascii?Q?LWwku7ObUzf5P7T6OP/1BVhAvdTf9BWotdGWzZz4DJepCjMzotTKNzQgHlDh?=
 =?us-ascii?Q?nOB6suHL6nJN6Cf4vo8WP0bkpidHyvHdh7h+otdwRdEY2c9uj+cu1DdOfh8e?=
 =?us-ascii?Q?ibOlrMtuFG82LeoNb0Q+fvXnGFrxfCS0JHZ5fcMW0YqFy12U392wT21ctZg7?=
 =?us-ascii?Q?/dJPUGAKviQyfrDSYQWhiy8PmcVQw3HajP3aoVkLmUtboVT6aGG8OydVUKe3?=
 =?us-ascii?Q?XWci6pQ0MqQxi9I5O45M2EMEiLzZFU2i/L76Lc5FOU6PVgZEfoS6vinSA9jb?=
 =?us-ascii?Q?euiZOPh7kiQR8sP7aFPEZSeKhcEyb6Jhwa9Mg1KKdAmZG8ATbwpQ3lX3lcNc?=
 =?us-ascii?Q?WnV10pQq+tE9qbwcTB7AdFDxIp3KwjG/TqVfalUmE0qMmYGo8mJIeElJg17j?=
 =?us-ascii?Q?MIUgqlqOof2Kf75+joQQ8xwY30sLdWgoNNITS3HIlA2HoksfnaDoB3FruTa8?=
 =?us-ascii?Q?Y1QL2b+N3Q1MFfrbJlgIzsA8V/fB0qxreikKiBoHM0oGbvFbQocAef8Ox6Cu?=
 =?us-ascii?Q?spRZseMMan3hh38S8htSCQ02xrCCAICz0qEkMzGq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 983e0272-128f-4ff3-aa13-08dd72761b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 06:09:34.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRW7+OA95T91UyQIJJPVKb33LsL85SAAucH0iP5OmayweeWwc+adIW31KX4ok+COzH1gdIJJh4yQshorXegBRngctXsf12pMs2jROwCGRnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7907
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, April 2, 2025 1:27 AM
> To: Gupta, Anshuman <anshuman.gupta@intel.com>
> Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nilaw=
ar,
> Badal <badal.nilawar@intel.com>; Gupta, Varun <varun.gupta@intel.com>;
> ville.syrjala@linux.intel.com; Shankar, Uma <uma.shankar@intel.com>
> Subject: Re: [PATCH 06/12] drm/xe/vrsr: Initialize VRSR feature
>=20
> On Tue, Apr 01, 2025 at 09:02:19PM +0530, Anshuman Gupta wrote:
> > From: Badal Nilawar <badal.nilawar@intel.com>
> >
> > Initialize VRSR feature by requesting Auxilary Power and PERST# asserti=
on
> > delay. Include an API to enable VRSR feature.
>=20
> s/Auxilary/Auxiliary/
>=20
> I would include the name of the API directly.
>=20
> > +#define     PCODE_D3_VRSR_PERST_SHIFT	16
>=20
> PCODE_D3_VRSR_PERST_SHIFT is not used by this series; maybe omit it?
>=20
> > +#define	    POWER_D3_VRSR_PSERST_MASK	REG_GENMASK(31,
> 16)
>=20
> s/PSERST/PERST/ (looks like a typo?)
>=20
> > +static void xe_pm_vrsr_init(struct xe_device *xe)
> > +{
> > +	int ret;
> > +
> > +	/* Check if platform support d3cold vrsr */
>=20
> Nicer to consistently capitalize as "VRSR" in comments, commit
> logs, and messages.
>=20
> Similar with "D3cold" ("D3cold" is used ~100 times in the tree,
> "D3Cold" ~20, mostly in xe).
>=20
> > +	if (!xe->info.has_vrsr)
> > +		return;
> > +
> > +	if (!xe_pm_vrsr_capable(xe))
> > +		return;
> > +
> > +	/*
> > +	 * If the VRSR initialization fails, the device will proceed with the=
 regular
> > +	 * D3 Cold flow
> > +	 */
> > +	ret =3D pci_acpi_aux_power_setup(xe);
> > +	if (ret) {
> > +		drm_info(&xe->drm, "VRSR capable %s\n", "No");
>=20
> Kinda weird to use %s when the text is a known constant.
>=20
> > +		return;
> > +	}
> > +
> > +	xe->d3cold.vrsr_capable =3D true;
> > +	drm_info(&xe->drm, "VRSR capable %s\n", "Yes");
>=20
> Same.
Thanks for review comment, will address these in v2.
Thanks,
Anshuman.
>=20
> > +}

