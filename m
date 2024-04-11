Return-Path: <linux-pci+bounces-6104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E08A077B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 07:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6661728A3DE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 05:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22D13C3CC;
	Thu, 11 Apr 2024 05:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMRWoF8N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93D2AE93;
	Thu, 11 Apr 2024 05:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812381; cv=fail; b=YhOoMKtsEzrAiuA4QZxyz4LscCKGXpYqItYguN9ftF2VhNjJklC+IdY0vZ6+BaHqVXHMwxb5vPvoaxtIJhVaFV9YkHlVv1QyU2xaBbv4kD+wazyy/hIYFct/GnyH/D2X4S6Kokw51IKSCP1GQGbadtPCtD9ZHMTtitAqdcXBAZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812381; c=relaxed/simple;
	bh=csBTrjkl1GScOasZauBTjD47Mubn6zoBGJfpmfaQauI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mlZbvedeIrx5Uv2Sotym0e309F3mlAcLiu2hxd0sIkW6ONpTRsune0/oORuMbXn6G+MnUpTHcC4GRSpRhPaQFV4z1E/fnOSYrKjBfTSen+NyIoV+CFqKQJ6Q28nXxvuT7mN1qhyKvi2agQLVG30k7Qqd7lDdC8p71h69KC9rAtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMRWoF8N; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712812380; x=1744348380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=csBTrjkl1GScOasZauBTjD47Mubn6zoBGJfpmfaQauI=;
  b=nMRWoF8NjKBeTU4so1u7vYlDhST2CMcPbhUjDNeBhS6Ush28i6GJSrM5
   QWxnug4lxbbyE6yd1YP+LmnxqxwoVN3hTA/eqIIhluebEDzZvX1LUQYrg
   C0x+MZQ1O+M4TWFoReO7rKyAxj4OgNShGryrYyJ6LVG6bCS1dyf4bee6c
   wZpLvqhOYcABkTB+3nIbEALbesZbm3mkzgM57fOki5qLEF6ba2sSXw5r+
   kLuwgcJxmdCa870GWjGkXorenoR9Hhmck/O9dWwwAuhNuRIpbS+TqyM4v
   FTW1RsRcVEXH4ZaHbs4LZcQSW7Akvm8Hd30ACuyO8Dk98oS+7jSx7RI7J
   g==;
X-CSE-ConnectionGUID: 4oBnDNwBQ46XA9sgW5ZQfA==
X-CSE-MsgGUID: zhXwOjQmRQqx9HmdoFW5Ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25660093"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25660093"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 22:12:59 -0700
X-CSE-ConnectionGUID: 6/u6mVDVQTGFXIAQPEumpA==
X-CSE-MsgGUID: iwrafImJSySD034/zYiAGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20762847"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 22:12:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 22:12:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 22:12:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 22:12:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 22:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/V9YOICdxnFXjn8s84Xp7u5JgodRxKeohTdE95ETnJVWaiJrzPJBQt/rVSTyoczAc6jAGfM1e7cpzOckxraqb4sXCPmfpQi1nC8r4uU/JuFGwWdkrlPVLw/5S7UYzA56yNvPTCEKKBsLm4AAi4eQvJRGRyzP+hlBFUiPsaTQmRmu4lUdOdbMH63SyjfhQM+9vLhlvi3FG2fq/Y+u5crV+WJDvY64CyMT6utcb6K/s+a1D/Ueib40KfjqXCOV9V8JYUJC2a6I9J4cjqErnDG4k17MYrcmatn3wKLA07c4hGGaJyWmEB3tK30Hr5HPFSHHlU6ibsS4zG3iEYS7KxlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZtQw2zQnQQmrXaLGoF+jgY8OFLxsc5a5a0pKpX9LRg=;
 b=CCjn/cE4WFbsteE14328WAaU/7/iraH9hCTEmLdrk7Fe8k1xftbS8kcQsB20Tgc5Wf3WLa4XIAfs6rD6RiTn574HfJdSqpRrEpRjZX91+rxM88wtl9ZKq9PL6OcgE97UI9Z792sDlS6iHAyz7gYgqYGrOMX+HO5G+f4OaebTvZA1GeaffbhgfNoHQKnhMcdhXW0zW+DIlo336NCt+oUf9k27sfQ9e7YdQTLC3IhiuLTK68G5Cs/v7pz7zLbdJgmg9SeDaF1G+uv0sTyCrH47f0KXNA5yxp7TwQSg1jXDALmexj0xXw64eW135XVg+lFXeEuZOKrCy+R//YY1ZY5WbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7789.namprd11.prod.outlook.com (2603:10b6:208:400::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Thu, 11 Apr
 2024 05:12:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 05:12:50 +0000
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
Subject: RE: [PATCH v2 4/7] Revert "iommu/amd: Enable PCI/IMS"
Thread-Topic: [PATCH v2 4/7] Revert "iommu/amd: Enable PCI/IMS"
Thread-Index: AQHai5RV6GldlKYexEWB+45imhBXHLFihn+g
Date: Thu, 11 Apr 2024 05:12:50 +0000
Message-ID: <BN9PR11MB527626BC2EF78997E19F13358C052@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240410221307.2162676-1-helgaas@kernel.org>
 <20240410221307.2162676-5-helgaas@kernel.org>
In-Reply-To: <20240410221307.2162676-5-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7789:EE_
x-ms-office365-filtering-correlation-id: ac34cb58-3e2a-448b-c6a1-08dc59e608e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Lv5dwMJeyu5tst4e0VH+tItK/+Som7F5Vb35FU8wLxrzbQ2DMup2NQgJSvS1JpVpa7eRuF0sdF3C2wVPf7EHr4KG0lEX4ptzKg+I/5VNFSxuPNCEkjrWAtmzkDAp3rTOMet8uMX04SuuGqYjIi3xeg4r1BTNw21HHWK8DxC4S3e1j3hl3uc/VeYbzYTwmZo9UnHjD9FIqLTWuUS/dqWhUwFl+tpIljEGV6MK50atKSvyYIxP28EIV1pNmuKtbuK6ufBY8CZoRo9JxjgijmDOlHOK9LD6egFRm1YdErAdJGIZYdKe2pj6QWejQW/amxLEDz8pdEps+CvoZaeFaSQDpEWPJ4B/BY4ECOYdMAC5y+tyq5IoBckhyqkYlz6TfoBlO4HgPXaQi8Lj8qKCNGfZigxfvJygxTBINBPgTwr+8CBf99KsLLQLD3cDdF1N+raF7ZK4n8jQirXpJdGGvp5IbASSLYc7mOA+hOjdq5dnuMf8OYwmENPNkWn1TGgnfb99QpFumsZuFN6YaIPYA18GwcPaKTL0p1+hjaC8kj/p7/1tNcBkyCmmN95uJesCWPY+cKk8N8gTi1VbUb9mg5T7X8wgYeT/qgOY7lSAxyenU4Xmx1hmXDAh9ufnZGsJb/Ew/+8VvYhfRM31bjsujX9CnoBnCDIgpxMBxH51jkGUKdHe63MEctsGebCX0pgMjZgKBm+cJ6gUm6bcbkHX4WV1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EnOxmQyk3SaZcSc2gy4Rt0Ew7Glv2dbWg58bOkWeyqzn1fZflL1gWR16tpJp?=
 =?us-ascii?Q?xZx/VmDR+qhDENTfx5w66VgEtjBUz4MyU1A224pudbfXri64guuq8uPImsis?=
 =?us-ascii?Q?2cJZKcOm34QOCQnNDKa135MdsJN2++4x3OnFyazsSCB6YONwiHLeQR1bUU5A?=
 =?us-ascii?Q?1WIp9xFfbzQym3LVO3Te5i/QB9li3Ktok511VoHdsUIM42hNZEIKEnWlaIDR?=
 =?us-ascii?Q?n/C9gL3/auzbqy/xX47H6UJ70+Crg4lpd6Nmjhq86DMaAmySqemUBaxQ2FjX?=
 =?us-ascii?Q?h/O38mhDklcH0wcDeL/BWBOfm9gNA2URVtycHKBYsA3b9mjcMtg0WDM+KQ/k?=
 =?us-ascii?Q?zkcmxuxYBiNjzpBMsoUZR8Cn+Pj/QxZBztTwvnSsJwctAwb/PugJ8zQrBHpZ?=
 =?us-ascii?Q?SZ6Hs25qbRdshrQYvRNh5dIZ4lxyK5TQo1iv7PBGi+Vck0rXF9vYd/Ihw9xl?=
 =?us-ascii?Q?i1MyrFje4oSN7ZfP7NiDlNGHwXIVjlsK7LfSUgToW98N2KgVluRgwNHFnppu?=
 =?us-ascii?Q?H/e94Du0Lu5xHlH3dXCwKmez6r/dxwz7lcfpn06V6lsFjl7MH0i90hQWb5BU?=
 =?us-ascii?Q?/59AVNxOr0It+E2UGmV5VpsUQJKZZImJPeTC1HvSqAOjpPQN7pelqqFkB/HL?=
 =?us-ascii?Q?duhug9EiD70O1G3EfmVsBkiXEVLs8x1hQ/5IHAby6DexGx8DdksceMsw6Qk4?=
 =?us-ascii?Q?bAM5zmeDaBPFQ0uaczWxjHFWZZU4dPshjUVKKBJqxeNxSCVXEdLKMA8R2akK?=
 =?us-ascii?Q?qU8ApfkuXDqFcwYkfY2ETxleZTPmJDnQ4Kz5jBA8ouxPcsZQtbsnamvb7C46?=
 =?us-ascii?Q?osDrqsDKg4EtejW3gBztxb7AZpJBBqy3RlVO6ULhtgZ9A9+wvNhrN8/7YjXP?=
 =?us-ascii?Q?meH/Y3VzucWj1rCBnEsR+r1wMD/S2fcW0yLtn0DE02shwzW+iPSEIRZiKlRC?=
 =?us-ascii?Q?ZeDtwpLfzOd0XENn5iilRXfAry6hnp20Q6tMmFqfkxsuaCVvjUvSYpXl+g2E?=
 =?us-ascii?Q?/O2PYlX6+Lahwig3TpPDseg1SEN1Dt62MVmRAXXatM2aE1SAr9uysDgswYIR?=
 =?us-ascii?Q?vte6VX/SHBBuzQtJYq80P+vAbEnzy7fokyqnFCsEO98vqQyeSv481t1LSa2V?=
 =?us-ascii?Q?Z327h9m683100DnPulrvfWfH3zoJFQycyzvKI5UkUiFzoSFLdf7YiqJwyeGz?=
 =?us-ascii?Q?8Ntee2VjBfog0fRaKfef+NTpVQPRkC+ZBjR7k3ayG51A7dXDTc2cLSwDAbxe?=
 =?us-ascii?Q?hNz3j1lQS5IJBbVbvugCpuZM9abkbYSNTmVCi7hrUBtb3dTe+QYThsrGCcLC?=
 =?us-ascii?Q?CWychlZfTaqnozCpR9Up8ec9nFOM9E9H8IvyCu5SK9ziVPahWpz8EgjkhE59?=
 =?us-ascii?Q?znp3liGHZ7OC4Dr/it/w5X1KipPTBACtJMNn4x2nhHwrtYt5RNbrCHUOmO9A?=
 =?us-ascii?Q?NI8mCHu1dMFLiR3EYxwIpYc7wYRB8p7cpQkZw1hrTeTKkcz/Q+NqbFy7bhuC?=
 =?us-ascii?Q?ymQuXFa0PjCogZpKFhgmep3bzs7fMdfcpmvTOI3tLHG8IxEBCB88HGK70IIg?=
 =?us-ascii?Q?XGpgSQqGrft22xt0RcPUYb/KL6UUKnHKmUrxcBsi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac34cb58-3e2a-448b-c6a1-08dc59e608e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 05:12:50.5679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmOSaI8fPCABkgENZcYuKWT34Yks++FdO6TIsgYlRt1arhs9B4yqrqdd9+xlYnwKvbunSIX2ktjQ8CUwhRuK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7789
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, April 11, 2024 6:13 AM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> This reverts commit fa5745aca1dc819aee6463a2475b5c277f7cf8f6.
>=20
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
>=20
> Remove it for now.  We can add it back when a user comes along.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

