Return-Path: <linux-pci+bounces-22451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C27A46B33
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 20:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF1616E8FC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE6723A9AF;
	Wed, 26 Feb 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWPEOZUc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9C23F421
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598591; cv=fail; b=ak9CLTxBsx1tCbjfvMX9cJMMwlZJesTRoNDrFvcZFUnm4KZ24kjCI9ccvPPtje/vrwTxByskxFh4XhWevlvC3Ee7ApNtf62AxOvSJo7NeQec4pb1jVMBb7SstCoAdewh9nfA//jzvCS9rstPxKtP0gqBAs5yA9a96xYA7EwdfDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598591; c=relaxed/simple;
	bh=5E9DO4Zhyy/2VFFTCtJuJYghmIDiL85+croHKVsRIqs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=USmZHxeQs6APhza6/Nvhy2KJntFF5HxK5ooEdv3o7TEgScwNmyvYOUA4Wo9M0i/Q4tnOZ89tB93piV1/04v4PAlJvN8q2Z9dW8NtjqwSrAz8xAT24zhoT9cfF4qo2t2hrMjPxryPZr8YBidu595HlosGF9sGVZwmz+V10dXKMpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWPEOZUc; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740598589; x=1772134589;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5E9DO4Zhyy/2VFFTCtJuJYghmIDiL85+croHKVsRIqs=;
  b=LWPEOZUc5pTenvg9E1BmlAyxfGOu1p5ybUv2DS9WLuLhIRQpXm934R2e
   tldaU1Q7N2ncIa380N/Ucd+itML3JgR0itLLmBm9vDpbYhBfXiENrjzEB
   LvrxT7AsV9gVDT8WCVB5Lof4HLV3dcNiSnrQsVPemOtspM1/N9TWkt5Fj
   F+g/V76vIuX9YAzdBfe7uIpYqAnGZAXRfDJNwMlHdllo8x52rqgEFrb1C
   B0lAqQevev9gKospswpnThUTyA6IYYuA3yj2Q4p+fFTP5Z6qDONKFCsrn
   dzA7TPkeS/kjS9lFPlYQG8gyr7vq7ICHVbIzPYyV1f/ZTIzJCwcQ2wdbH
   g==;
X-CSE-ConnectionGUID: dZbAUeBIQDy7wDVSVTl8bA==
X-CSE-MsgGUID: aKYnIjiDQ+eKaf5RGvNhqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41168683"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41168683"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 11:36:24 -0800
X-CSE-ConnectionGUID: tOav/3nKT/GBRKpe7VoDwQ==
X-CSE-MsgGUID: 1jzHOs1USoS+90fKnH/Gwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="121907169"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 11:36:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 11:36:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 11:36:22 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 11:36:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCDMQlBEyPX9XaSAWDsApISgrTovThRsCSfeG7sBPNHRgJBh0c4UvI/ze0kHObZwjTsAVo0ESK123OlVYjZed6KQg/miePbK/kjerXOmg0ecQneLEdYxqHYk0zQJBa4Jrlb/pQpexI5T/ZecEcuHR4Al6dR59xKokn0OCxolSc9wDr1++1uY8+svHtK+RK0njvHlEKCHEng8NO9hCCeXouZAg1q49jHxSNgXqns6GoPm0oYDZVJ7oHxMh/6YJPYwQyAjKgAKYJztXhEopuTX68SpqDBVJJzoko9iRQ0uB19aA02rAUXcr7vhkFdE0MmXpcRDX4lgdjl1S8rYA+77zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/cIOtsRA1B3FkdmbOyz83Jtd5wfiiGM1+PIdlZlvvo=;
 b=nneeGSbMn3ERce61HjStWQrSGBLahsdnJdiRaBFfdkCCXt0zdE11BlUruwB7PFpBTtTZCWFB07iS205X5GiHY6WxAek4lPBlDki3ebw9ZgM5hJYXbXOT8i3Dhq6/nyvmeKZ7oPGWCLHu7/VGGJ5EtfvpOkj+GkBRFYP1jPbhL68d+XEXrG8ogesYWxLkkar2gnvkbc/aAm6YnGvVqxq/ovgMXOND/2h1oZym84yy7mAzzugN+PAugpMuvz7TrEKU4KMc1T0uscbwIFBAFw2deSkU1nY+crzUsgT9Pc8fkOp1WV5CYr2O4q97S3BRLKnUxfWprjWRwMteSK6YwNbGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SN7PR11MB7067.namprd11.prod.outlook.com (2603:10b6:806:29a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 19:36:19 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:36:19 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Kurmi, Suresh
 Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>
Subject: Regression on linux-next (next-20250221)
Thread-Topic: Regression on linux-next (next-20250221)
Thread-Index: AduIhAZ+norPQ6pIQMCNB7FNA6O0jQ==
Date: Wed, 26 Feb 2025 19:36:19 +0000
Message-ID: <SJ1PR11MB6129B4B298158496F8BD36B0B9C22@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|SN7PR11MB7067:EE_
x-ms-office365-filtering-correlation-id: 777f5844-4f88-4721-2b47-08dd569cd7d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1rW03Cvh8fcu5jZwM3Mb116L64bjoNdgek7saihzgGeq+9N7kNUEhuX1EV?=
 =?iso-8859-1?Q?As+UNCeUeRuZ+4SoA8s1eT+g4Vm41//UzADtyElLwjj5JfkakT4dQ/suIy?=
 =?iso-8859-1?Q?yNKggeVCCV/UFkvFmt7gHbYTVz9a2HQy5okaEtfgM4toJOk7cWNBaCGGmp?=
 =?iso-8859-1?Q?sliOgQyaaLUa+Oa400JhlAGQeScK0ieaxTvCJuZdgE7WC9kximwVhSa6uQ?=
 =?iso-8859-1?Q?3pkxnXjBC348ilzP3IYpj3bFMTjQagGK4pJazQIhAkr9G3SuV7wMk0v/8R?=
 =?iso-8859-1?Q?KZqvjGR3vv9Otf1+jcp/8LRYBmyqxxo1CIYVn1qRBHlze5xZwnth6f5GJ3?=
 =?iso-8859-1?Q?MtEV8Vtx/Ajw+uKIJLjzpr97f8lclq1FvzKM5zhSIJakgR7uDNvf7pjCON?=
 =?iso-8859-1?Q?1z7SKSnQ+XCU+0PQbryTZG4UCpcLYlElYItR6DV/3DMhCu/dyxgNBPVLHI?=
 =?iso-8859-1?Q?PLm29ARqs5/xqrFNCx2ecpS0FufQG4iJ1sbpP6KFpQmJnajqSY0GzKhOwO?=
 =?iso-8859-1?Q?sgd4fC9zDNaZwc9TXS8foK89htdh4HDK7QuE4o5Hv4dqN6GPzIAHHpKEi4?=
 =?iso-8859-1?Q?BekJ19ggEeZtnTHWfiEm7yug932YMmTn+cNY7+eNTqPU+CncY+TbgF5wwg?=
 =?iso-8859-1?Q?G8P9m3jVNktDDlKvyDCsWUf3YJy7fyiE969FZMFWKSVYee/UbaZxkSxexG?=
 =?iso-8859-1?Q?PTOa8XeIUjZuHWlmG2sqixpNo6S+FAgkG2CszXtuP22odJySDwMrxGKNgt?=
 =?iso-8859-1?Q?6sI1DDw6fpmqcRdfYCJZqj6Jh+Dz6m8RjqD+UkKk/g5bLbH9ZVBMy6YEH2?=
 =?iso-8859-1?Q?CVhmHZUUFgTf4hsk/TGjvHbYNgwfzjxtEEIpECr7g2UFxb/4H00mM/QKNX?=
 =?iso-8859-1?Q?jDmIRly5/ewyrVab9jAESGdRGzXaS6XUDFc8xmPAYEmfiUf45mFqwRMtU7?=
 =?iso-8859-1?Q?rtucFotX9mhmAUrftFX6OvgfMB6a8TsL+AQ6iN0kRbvdJlYpEziOD/RGcS?=
 =?iso-8859-1?Q?Vc4f7LkSRRWJUpB7bgQbfYUQyTKgz6jikYms+EO8wyliI11ONxvzWE+cFi?=
 =?iso-8859-1?Q?P1LmOwKYlpe7xPdwMhCvElSwnrBdAhSjHMq9Euy7RoCFAAlZQYK6S74MNW?=
 =?iso-8859-1?Q?f5zS4qY0Q7lx3ZtXfb2y9fCdCAMqoVHKQCIRE9bMJUZUBf6GPDsUbXWTgh?=
 =?iso-8859-1?Q?vsk1sCkJ2r/zBZzd/8hSo4iNKJvoQ4lCPxrxJP0guRQN+snZLLRNPRaVHV?=
 =?iso-8859-1?Q?HySuHc/9uYT8wMXzyXPvGlOiew9KiQP2OKPrvabwwxIvgdBptHf4nZ+VEm?=
 =?iso-8859-1?Q?SBraDCS5Il3yuqj7UCbAHCypfwfXiijBFwOWrPtuZ6Aw0jVLHgVdhzV9Du?=
 =?iso-8859-1?Q?13NHUV8syZLpeKoOxPjOX0Zn9p7vXXYAtI8BrfYRMkAW8UHRznfR2Skx8Z?=
 =?iso-8859-1?Q?8lhirCjXBPPJTGSAczMa9WbBsiVSeSkspsEtYw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FSJu1OWMKNXTTgwjnb/wCpb6SPxIgq90n2VZktFnA6ANW+zTBDnbS8JMS4?=
 =?iso-8859-1?Q?7/bWDntgbwElTXhJTm+FRbIPd5JktniXXUlquB48+gfoSUhsbF5FMAsN78?=
 =?iso-8859-1?Q?wiXT27xe367QqRuZbC23VmFwmt8wX5n69Vbhc7mtXzeGq0zwR2d98LcNTK?=
 =?iso-8859-1?Q?R25nBNGYhKOagLIEAEYxzYDEv6WfNpmIe5TYs73T7qPcgJOZ8RlIhdkMIj?=
 =?iso-8859-1?Q?xaBVDx1BykYmJlbD4OO+0VWIPiA6MTAFZvCwssypblppIwqE6qht+jxokK?=
 =?iso-8859-1?Q?vWpn4tuEZKXKf8bLoZzlQVebjLyocjjLRbjktSNPRqblmW5MLPD8zy/yAt?=
 =?iso-8859-1?Q?SSG19vE0YSVV7w1J47ya/93uWMhkhkgLrysLo9bblisDEqO0b7yR1ioa2A?=
 =?iso-8859-1?Q?p+c8qSXM+wacxMpqWjVt4i/W1CaKXPx4qPoiSnyLinE3g8cMETC/vsHECQ?=
 =?iso-8859-1?Q?2+fh5m3GVDkQxuEHAd/jLNNNGDxb19QGyu3ilxElRbRji/O6McvlKecwcX?=
 =?iso-8859-1?Q?pf2FlJsV2B1KBE9P3rv0Re4iZGKicPNsGPsHCK76qDQhOJqj9rUMoAl7/w?=
 =?iso-8859-1?Q?RvssnZiT6FdhjZUXn3eHNPJoVGtjHCzdLeF6/RTxkwWQz2sroWILzK6KOe?=
 =?iso-8859-1?Q?JJmfs0Z00ztogHMdUy5oAX5NyVB+Z2e6UmHuwDvtYRKFV5OhQceZbf+u2g?=
 =?iso-8859-1?Q?uRpvKv1bwLEIcaSiESGsfheg19GrkY9pRi4fTs/5arwtbd/FIpsOYlpbnc?=
 =?iso-8859-1?Q?Aj/vSj/tCuSHGToqwx+oTXdbExLSaFh3p3JB4v4lWnAixY4m2jagmtDFNh?=
 =?iso-8859-1?Q?lPmrLh2lcAZQK86ORX0h1DjQhc4wqRC6gf/C/WnkD3UlNRDPXLuqTNfug5?=
 =?iso-8859-1?Q?LErBmK7XMtaCQLrVAt3R4M1IcCToO4hBvsxxvfETjP7atm8fJMqcuORjP4?=
 =?iso-8859-1?Q?sR4SC3Kb3y0eaxj9RUPp6V4lCJVd9Lk6rUvulRwLaSwOefzEPJtfcZCap9?=
 =?iso-8859-1?Q?1dLu/ADVg8ylEp8mZ0zxhJcnn5wQzer/MLm6DhSzqtTnejCwMrG/jzdrY+?=
 =?iso-8859-1?Q?3MlCm6YM+ryFI3O9LqkaQpudY50JNYPni1cOmoa8M1an46adNBus/8QpxY?=
 =?iso-8859-1?Q?89Iaii6OP3v6cZ4lCbKcxHweYBy6I7wT68J1eHOjWoLvAlYxnW/oqofycV?=
 =?iso-8859-1?Q?CSggcrfVwq1CjeXUshkJG3Pq1B6MXhFTHruCNsc8uKijhM5aJHAUfGiR5w?=
 =?iso-8859-1?Q?qWf8iZ9EV9RNTMCtc0ezUx9n3at4C4lJ/uGlbzYbVZJD4AbCl5SIjpXQlY?=
 =?iso-8859-1?Q?tvc72xBZ7UROJU6T7kQge9d50pO51wXdtf29RuqtceK8V9a09aZr0IHE0Y?=
 =?iso-8859-1?Q?hmwUlMPBzyNNNqexHw5bGfXZYM5YZC38OeqqnJOdtwLKZgfMNhb6ycxnYx?=
 =?iso-8859-1?Q?OlQsIu9s3T5/O3yKOIVzsdELhGobP762c5/G5cgDFatwYRwEcsKN24sS1a?=
 =?iso-8859-1?Q?33ITcPzJmjFhbPpRe1i6FqpEn7opvX1EjGWKpmu0I0kcqtgYiYbErmImk4?=
 =?iso-8859-1?Q?ujYwfq4uQ5AorSWadVSxrgDsXg/SUIIaZAgX3Vxz4udrAftIJdplJGYrYb?=
 =?iso-8859-1?Q?+9TCjY3XoYgosRcTXilz+/xkFCMIJdenlNRfbk15JwzsruyKhiDgkB3A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777f5844-4f88-4721-2b47-08dd569cd7d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 19:36:19.2397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLz0k8BcffaNUeDtwX3vROK848kmWuEttTzAtKfssbvNdYIocwIa0ZaiQWAyN5Qcy9eLJ1pKak2H9maPfefXh8hgsx6DXiMXcy+wb17+d9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7067
X-OriginatorOrg: intel.com

Hello Bjorn,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.

This mail is regarding a regression we are seeing in our CI runs[1] on linu=
x-next repository.

Since the version next-20250221 [2], we are seeing that some of the machine=
s in our CI are unable to connect through ssh (and therefore unable to part=
icipate).
Looking at the logs we see this.

```````````````````````````````````````````````````````````````````````````=
``````
[    5.838496] e1000e: Intel(R) PRO/1000 Network Driver
[    5.838515] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    5.838737] e1000e 0000:01:00.0: Disabling ASPM  L1
[    5.840055] e1000e 0000:01:00.0: probe with driver e1000e failed with er=
ror -12
```````````````````````````````````````````````````````````````````````````=
``````
After bisecting the tree, the following patch [3] seems to be the first "ba=
d"
commit

```````````````````````````````````````````````````````````````````````````=
``````````````````````````````
commit 7d90d8d2bb1bfff8b33acbb6f815cba6f5250fad
Author: Bjorn Helgaas mailto:bhelgaas@google.com
Date:=A0=A0 Fri Feb 14 18:03:00 2025 -0600

=A0=A0=A0 PCI: Avoid pointless capability searches

=A0=A0=A0 Many of the save/restore functions in the pci_save_state() and
=A0=A0=A0 pci_restore_state() paths depend on both a PCI capability of the =
device and
=A0=A0=A0 a pci_cap_saved_state structure to hold the configuration data, a=
nd they
=A0=A0=A0 skip the operation if either is missing.
```````````````````````````````````````````````````````````````````````````=
``````````````````````````````

We verified that if we revert the patch the issue is not seen.

Could you please check why the patch causes this regression and provide a f=
ix if necessary?

Thank you.

Regards

Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20250221
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20250221&id=3D7d90d8d2bb1bfff8b33acbb6f815cba6f5250fad

