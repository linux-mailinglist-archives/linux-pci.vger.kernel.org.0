Return-Path: <linux-pci+bounces-5366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E803689107B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 02:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F200B22D80
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 01:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56DE17554;
	Fri, 29 Mar 2024 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeP78YoI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D451755C;
	Fri, 29 Mar 2024 01:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711676501; cv=fail; b=d96skDybwbUNZ0fnjYlHPn2KqEnVpHTPkXXPByEOoPiPbufWy5ZeXflIIK0UqIKXD94WmZcBZSqZzcAUCdsvmSDIB3IPW7ijRlw5spB01Ha7raS1xW5AAPHamCZ/JSYkhHOBulxzx1Z7qoGKv4ti/4SUiyW+r0wER/HprG5HfbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711676501; c=relaxed/simple;
	bh=ytD74C6x8ZlB1Ti5HHKdpJFYXIvo6BNaBHqUtulQUWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVaghpH+lGuVsiyj+HSjURrCbMc0TDFl0R18AsoXdEtRyeyWo52TtHRqpBKyayGHn5bo/Zpp/IMrlpkqHgGI9r/Vn4UduuzFx1WLuqJTF7g0BckVAibX67WVW+hkF7P2DGfmNO0no7X81H1PC0yxwCZYxguElwGNW5fCmQ6uX1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeP78YoI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711676500; x=1743212500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ytD74C6x8ZlB1Ti5HHKdpJFYXIvo6BNaBHqUtulQUWc=;
  b=GeP78YoIiGa9bD7L9UvWwUOOk0mVqF/MRkiG6GlNrQgCi5+KOf/6rPDA
   3fjFLrYXDdNuwhvBQ1Hft2oa0jKpI9N43G/BxBKD+XZ4DQ17Ck+jNBiof
   9oW/MWFfo5sJat9WBywWcxda77kYGNNJzHMkCCIl1APGGRoGi0gwr01fe
   4yp1t1h0JnLM1YFVOVE0d8zrOGOjui9iIyCUq959lWrSoMjMSHYcFQfq0
   +pkQxuROhrARECIwZDv6+SvsMP99ZRqiV+J/0NIpdFcwZWP5ky8Siy+aZ
   TI16ay5t+T+KTv522n5+KJBv/JQgb/yBjjlb/FW2Rxv3dWfHmDi+2y/Yb
   g==;
X-CSE-ConnectionGUID: DYAsitAZSwGNgdyAeJYcSg==
X-CSE-MsgGUID: OcHjs1rSQaO6R99vY1+yMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="9819016"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="9819016"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16713809"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 18:41:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 18:41:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 18:41:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 18:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEvJS0Iem0VsM2EepsJdOGSujep4IOULHMY8sucACl2k5/m1sPOmIxT7VaN6dUCJvii1b4ieErnIEWrK98I4FMteWdQGOAxDTD6eM7gehbS/2pB5kntTXFoewhhxNXyeG6DTzrnFJ5CtbfKG6l9t5kGUiWuSBxd24nyO6aJb9jf45qXtf7whocRTZ6A7JCjtOPTLowBC4O2Y+jfvEehECdEo3KJ6jDLx37hoYR3SfOeYlkbef2oaIuZXNY7wkWKuJDJknCZ5mYRtaKsiIas5JfJRq349P59U6Mtz2FrdaC7ptowUcukn6HaI1FCBlFlD0GAekDEMj11TS16lD3NPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2mPLVKnyX1DDSKnQ7drHMWYVwxNZNvlJi0ALEtX3CY=;
 b=NSSRdocbkka7R16cqA/2BZrMuH0vmUxLIe48PNeSf46iEmwxeEuLWqYV51/sgWfX0qcuH1hZpf1LNJNRXjjvUqC3fNC9cX3NU9tfMzctrUuMk35hUHiO1KEclN5sFwHMHvozRdhdJzU2JYey5cLJ4o6D7v6I30CWXQgdfzO6U08vatYNWt2caDdMROoYICfObdH7d2PVZM1FNqs9zbjcvubYb5ENd+H3sW6NoUyovaTg/z6eXZvdLL3VHZYCx/5V/9n49KycrS6IyUe9yVBvuWBoAFIm/QtET/c2H9NGD63WdfGf7GOyVI1t9YO8S6Y+UQwm+xrBN7EPuMq4JqWOMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:41:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 01:41:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Marc
 Zyngier" <maz@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@mellanox.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe
	<allenbh@gmail.com>
Subject: RE: [patch V3 28/33] PCI/MSI: Provide IMS (Interrupt Message Store)
 support
Thread-Topic: [patch V3 28/33] PCI/MSI: Provide IMS (Interrupt Message Store)
 support
Thread-Index: AQHagGRzDpkHgKkHIE6R1WA5Wbqcr7FN8qHw
Date: Fri, 29 Mar 2024 01:41:27 +0000
Message-ID: <BN9PR11MB5276A75A242ACA5B8ADA55478C3A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221124232326.904316841@linutronix.de>
 <20240327163247.GA1525799@bhelgaas>
In-Reply-To: <20240327163247.GA1525799@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6524:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Wgb5mv6jmAzlkNRZbHEPhnY51uuYI6R/L911tMv+C+d+hyOymXVmEATDVJpWKFNm14KDjqA1L3l2RslH1SF2QaN+aTy9slGWPnGFS4TxmNliK7K61e7LJ0VR8qHFtz+WCSK1wUtZWDQ3qTg9QPt/lR4KBqCvIqW0hrl+hShaJL3IEqPcxzfPXXdyQDyQB/Am2gn8TKDI4TXTFiPZ9yqqzHc7WKBzTqnlBb5dZRY7OsB0TpKpzczFjRo6mqSffoCyUn4moOX86yRog0T1YS4wTWVCF526kbPfZA8kDBj9Cbxtb6dmzkqQW1dzH6z4CPxJd0igC8aZvWoFUF1ygACTzf22yv/ywIRvJZQvW/Okg+pXIxtE1B/I8YUs6l1uOWDrtb5fHGkpX9THs/gcJWiHLcf2/WuB8x0kTi/+sfAMe8J66ecvncqXC5mUj3slKFT3irB4Nybogf12ARBJfXJXvdjKb3FPXWkT612UEEXMxPZKWu2I2ES/YVK9V6goSScbrL6koUqrCxl2Sk7XavaQTvwtoeNmI+3DdhTQ4KyKD+COwu/UJlJRLb24gl2rrek0AJpA78XlMnpRmlWMW+of/ChGFn7s13Lxu9z+ySnkL7xMgEXFYuGuFVTj7fKLbX8JmOTYG7k9mNJzz3eKjBE01lIPkzgleexcPWKP66vWio=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hY4EE8RwsL1FjeB2GKy5RX6QdWNIwM1eqIXV45aGeNnme2qrJUiihAIasQP8?=
 =?us-ascii?Q?Be25rLOIrNptHGM0FnjGP85XuQVMFOPdCjmGgfYFu7jaAqdDGSaIvbhSkXpr?=
 =?us-ascii?Q?nHzSZrZoUB+KiI3/t2Dbs10PjjfATfWAekIlg3S/uQLNUkAH7oJftGz6LOVT?=
 =?us-ascii?Q?xZacQFFbkOi1OrdMwuiC8cr8HGnwD/OlO1XzKQdx3AJwQPgv0qW/aCYnZ6sK?=
 =?us-ascii?Q?qbE6/Oeim3LoNnEQTU9pcPBnGNdeVazx36G8f2EdroNWFkKx7YFrO1BwHCH/?=
 =?us-ascii?Q?mJMxvuPYvAJXojcT4VWj0uZXMxtYEWap3oLRzJHuUEEkdQFSKB/4ENVantKe?=
 =?us-ascii?Q?/Wjw96odkpCpCO5Q3AuVJJAK5MZYQZxqQlxBF7clvysbh7GSDhcE7YRHLef6?=
 =?us-ascii?Q?UM2YzbnwusTWov018KJIpKocCyeuaM7ix3IK7DFGm3YRjWrVm6rjAJqYwD+Y?=
 =?us-ascii?Q?Tsd6U7exAvB2PzGqSCxwO2lp+E4H5Z1/a9QkNVsLlRwn1Lt8yxI7jtgrNuoo?=
 =?us-ascii?Q?tV9HMDaTO63/5dzUUYI0cfe1NWDZa4Voh9DcnzD7KY6s2y21DhRu6tq03CxO?=
 =?us-ascii?Q?eqTSlm3avkY1ZKwplosiqrYfM+cL0DkkDLTLGG4ZztAbI2jEEZlO1hbSMbtJ?=
 =?us-ascii?Q?WcU0RNUlDgjFKEV1hRkWhi5U+288t+Z5kPiH2F80wKBb91N1MbNbWbxrURue?=
 =?us-ascii?Q?Ec1zKAJLCrUKITloptZFBSw1e7gKpRFnLa5/zmMMLgzn7g1XNOyeGRH66tYz?=
 =?us-ascii?Q?IY02uE5PwIVYPbyM9vkuc5oMxDEgzzeMTmrGPRok0Z5z3obeiX3+zB/Ytv0g?=
 =?us-ascii?Q?BNoUxaLubLm5st5J1223Sdc0yf+eqKh0p2g3EFWO1f9w9B8YKvpc6gAKiuNB?=
 =?us-ascii?Q?SDcMNEswWQj/6QpoYqy06cVSy2k1QorPs7S7Kx8IVNVxGSaCjzL61zZN5fcc?=
 =?us-ascii?Q?p7V/bS4LycT7u/ecLQ/MFiNPy3WnEaCnGoLn3PxcS6m+ZYwbuxJUh5qpL4eR?=
 =?us-ascii?Q?zqpdvxRliw57L1v3tLcH45yMSjRGRsoOsLDeBPuPRId+qz1Jxsupw+qHnMNk?=
 =?us-ascii?Q?o7mHPwZyBAesn9ySyUyduGIfAliIQlEe0bsn2uCOcZW4E+NsUbUWxbpIwSa3?=
 =?us-ascii?Q?X/35xvq+7pqWsEARaUyP4NblP95reBQk2spJFUM3PVV/4/KBs5+G/7fEV7uR?=
 =?us-ascii?Q?Dx0lYKR0sGUVdeUL6V3X3cAoOymbag3PZabNlcej6sZ1IEznCwwAPD15ShT4?=
 =?us-ascii?Q?HB4CTTD0H16OiLjHra0mVJOKNPLkirlAgQAqbvmq7cQw2HLds5Hq/F+EQoQE?=
 =?us-ascii?Q?lY7Vrzum2SODAzOi1OAVSNfPgLsjbRG9RrsWLQN/gOglHeNHF/rEnUVnuq/N?=
 =?us-ascii?Q?ojYGIhdZEEusnVkOh7WyR/m1AtH4Ixh75uBIB5f26MEdGS8ZYhOpXNzRL+qh?=
 =?us-ascii?Q?6YYYbbnKBQS1H9499LBA1Y42Skldhpqv3NcKbwUGtX6TvuUt0wikefyk+wGI?=
 =?us-ascii?Q?UrXepsaI7sHkCs1CgI7qvsWVfN74cTI6tTcIzEEjZvTs7QBPqfoEpDBlgaqr?=
 =?us-ascii?Q?nGgTbLlFygiAFeUBIuikQdoMJKjTYRQLRc7RN+nq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6dfddb-663b-42dd-b31a-08dc4f9159db
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 01:41:27.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWL+UkuN0LB6Znfj/c+VZuZlAmL/kVs0ZbV0g5lJ/djZNspap63u2sx1e1jWwqdzjjIESNm9lwDf/plYrlPZ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, March 28, 2024 12:33 AM
>=20
> On Fri, Nov 25, 2022 at 12:26:29AM +0100, Thomas Gleixner wrote:
> > IMS (Interrupt Message Store) is a new specification which allows
> > implementation specific storage of MSI messages contrary to the
> > strict standard specified MSI and MSI-X message stores.
> > ...
>=20
> > + * pci_create_ims_domain - Create a secondary IMS domain for a PCI
> device
>=20
> > + * Return: True on success, false otherwise
>=20
> > +bool pci_create_ims_domain(struct pci_dev *pdev, const struct
> msi_domain_template *template,
> > +			   unsigned int hwsize, void *data)
>=20
> pci_create_ims_domain() is exported for use by modules, but AFAICT,
> there is no in-tree user of this yet.
>=20
> I assume one is coming, but if there isn't one on the near horizon,
> we could/should remove this for now.
>=20

There won't be one in the near term. So I agree it's a good idea to
remove it. Anyway this can be easily added back when the real
user comes.

