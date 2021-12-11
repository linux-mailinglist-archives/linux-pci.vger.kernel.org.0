Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CEC471299
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 08:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhLKHxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 02:53:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:62648 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhLKHxD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Dec 2021 02:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639209183; x=1670745183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zcOUEDtikxKATapfuQyPykxdlw2CP9C0eeguOeaOVmI=;
  b=XdFP9Z0QGiFMUwE4feY6JRIctEVA+NW0bn1sbE75FAwupOxymTkqoYcf
   Eqnfgh6Ms3JUQFnrCTKc7ohbX3v65bvjlN1z6EkeZxKzlm5D7xMJmwpNX
   vSZqiVpKlJQ8ySInTV/zT4arxR7XX/Dxn/kR9t2RlKvdM9bD11IU3Hm/5
   AsocrIv08PamoclRXPniWFAbH8BWLDZzYP9lXbbVZjQs18GYBcpViyaed
   6WdKP1D2SdGXUtwd92Si5rQjNodLjRFH9Klln9FonhBpNy2i165qLboxh
   KIEfaqvqqCWSjJ9T+R/Z/HXsDdtDTkaag6tfkSS7lAumK+r3/C3G2Bk+v
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="299302236"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="299302236"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 23:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="681020011"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2021 23:53:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 23:53:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 10 Dec 2021 23:53:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 10 Dec 2021 23:53:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWks90c0U0z9os1rsrNyLuhbgMdtapQoloDIBQT9ukg97v5QYPrdgImg09LZY7I9PwbPd3AljoJENPcCjH2UI3cYCOAlPDY+e6UwM3wos64CnneptnUsQuxqgElqFgovXUTJOfaCs3mSz7gXGgfWqf1rl9aXQZtZWeLSdKq1M4IAZ72h4ddmHQfSnjlpmIhvZwYmrauUFy6ss3D8wqb1DksasLCkVugwHG7EGKLg+zZ0GDmm+5N95GWzwSCY0N+R8B9/UL7eKJbaB+J1EnPZ2vQ6mlsToHjYKAML/3JgZ5eD1EwdzsYRi1h38u0xrU62JjasDUxwJcvKRdep71TyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcOUEDtikxKATapfuQyPykxdlw2CP9C0eeguOeaOVmI=;
 b=TSPSG0k3TutSN100o3RPvvKGvCdSISglq2FPRm/WEj8WWEsnWm1G2em5dy48SOJKImEMtaUkLIMpryc3rnIwHL9m6k9tmWkQpkw3nVQOYoUEfNLfaWdnfXJYZQf9uNOpTquIHHnM3X7Hm0fOqWr/9jIm9DKeRx5qBA1RbC8ebHLeruOukEuMY3dJfHCsXvqBX2csutK0HxU0QvaS+xTOuf70H0ujG+nvhfdWh/w+aXRkiD0nG50gTuhtwA7HSb0Vq+GfuP4n2GoDuea47SLzNcYqRiDH3E1IKMttlrdGkx4s80hd9TFljHzhcHGcVjXGx54g6VX2y1ZI+Cu0aXaykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcOUEDtikxKATapfuQyPykxdlw2CP9C0eeguOeaOVmI=;
 b=YX9sFO1+/TmWCcc7uIlRgpC/WUxR9Yf4qllSx8J8b1fAijQGV26RfZMRLufDWICxdguA4lG31mZlUNjZprR00feRyyLkDYE1rBlXFb0BHJ3mCtBKn5MMgj/CtQ9KXW5lfBzKtUXbZ6wZS+vgcHONgt+PPfBD31o0wy3on9wDnQY=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB3860.namprd11.prod.outlook.com (2603:10b6:405:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Sat, 11 Dec
 2021 07:52:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Sat, 11 Dec 2021
 07:52:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Marc Zygnier" <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAE+oAgAAmHACAAFJ4oIAAem8AgAE/1RA=
Date:   Sat, 11 Dec 2021 07:52:59 +0000
Message-ID: <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
In-Reply-To: <20211210123938.GF6385@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f28959de-a94f-486d-b0b5-08d9bc7b4073
x-ms-traffictypediagnostic: BN6PR11MB3860:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB3860E84DD738E410C46707F28C729@BN6PR11MB3860.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prIbr7vcPYzlPoeu+80Qw/FpM4qCUIIljh05j3L75rtThQkCwux2Fbrlsl7F+hBfUxhSlc0U70M1exW67BQiCg4fFAhHBw/auvImgZvNrYQ7ndXemBEqAPiyOwN8UoEWYmRAHfqc19kAEuIfKrdUoXe4sN108czQhSt0XvHvmL+uVQuSLtOJ8gg9hvPRSMFXYFkI8QtmH5qlVaiN9lczhHa46luDyq6Z1zH8COagQgtez69zKV/CK87ogEGT3bW4pByoBsDFVOsr5G8oDBss3KXj44h8q5rowL7oFTYfRFXwbUQOdDXBeB+4bYV6HO1nCYqI/gK4YE1k01nvMmSZ9DcZFskBm4JRwAegZwwaKKp5xYu2BfazCeQWFkia6n4V45BsLLiddtSdTQuVlnJsyq1aSOP/duZWHedU9PGoGNDAQZyVTQ9BGDdqTaUNm2tXjEUYWbFD5wmeL5trF1TEp72GoCGmccU1/OEwlhtTQcw+izIJ0AAGBtdW6bBwRC4/SgN/8HI0ljlsRXpEMYF/MHM5Fy1G/cIsZaz3rh1b2oXgPurkDDxJwuz6AeLExpyQuHNiQS2lava+MS0WgFgImgKSYs3aDAcifVTriNMcp8yfLD1vatHHuuD4+AbTvT/7GE43+e4zCZf5h7n/+a7Q+pHNOCaXL8SkWtehi+5FDQDR43cydUtvGLRBflTJFEbuV8mKzFKPXEfuIrCh1ULV4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(54906003)(33656002)(86362001)(64756008)(66446008)(55016003)(7416002)(66556008)(38100700002)(52536014)(76116006)(66946007)(186003)(122000001)(508600001)(71200400001)(4326008)(9686003)(8676002)(26005)(6506007)(316002)(82960400001)(38070700005)(2906002)(6916009)(5660300002)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f1eOO76T/evD/DN8ZkMUIqzFFqfVGVq9ths4MAAPgcXAddMcXCDHrovKfTJr?=
 =?us-ascii?Q?/rVJdoFV8Q+miurzd5hbhl4yFmRQSmFZbN6nG4qTQC9T+kfLuStEOgSHbuh5?=
 =?us-ascii?Q?oeG5IN38lizm4jcj/bnF41cYVNo3rf8iMJUorFydQttz9lMEOkqLJkyfUxFG?=
 =?us-ascii?Q?6hvQnudptOB+i2L/UulauClMxVndmdlksX1oQtlSurmD4MXLr1KIOUJsvSIm?=
 =?us-ascii?Q?OnQLYHxxebL5OQCAEZSvJXFwCBI5XYApn0OE3U9K51InAAD6T13aSg4N6z7D?=
 =?us-ascii?Q?0KohewMNN3Xk5K2cdMVHR84ZRr4ZgTuKuV+r2/pe4/+NUV2oINoTr1nO3Fy5?=
 =?us-ascii?Q?SniAWDxLVEtcWKjzell14UPRwECVRRlAa+uvmGFH1HgDS5TUQ9ZktDfmj2Dw?=
 =?us-ascii?Q?jtDlHizjdi1wMQ4mZlS8SNbdsT0lhz4uhnUnNAtxXXEoDQutQAjrKo5lhYwp?=
 =?us-ascii?Q?JMH2JAllVYSBZJFjGmnRQ3jMS06l+DHc18YyJ+TD1kzR4+mK5qckBL5FXKQ6?=
 =?us-ascii?Q?feDWkvdX+ztjcoYY8KKcEZDJq9/QLgfTeauBpq7i3U9b5pR4DY/Jl/ejsXkB?=
 =?us-ascii?Q?ihBKZSKr2AyfydkXz190EwRPFh/CXzNF1hUasaviv+ZQGupQ1Q+F5mWdBnIL?=
 =?us-ascii?Q?GLmrsQadA/Dm/eWFUFF0z83PJuk1ZsV6wOWdKrDQTz2VeovkGW9Iujvv61/U?=
 =?us-ascii?Q?W0Y4NZIZbfJ/7r+zSVDtCm4xEYLChFC2cHCKhhItSJDvKGTkyFYTwRFbQuzi?=
 =?us-ascii?Q?7SgMC5/blGWkISEGg4BAxZwMs2vUM2Dbr7F7xbEd+XDl814TEcK20XosIV6c?=
 =?us-ascii?Q?EPbsSGX4KgBJeY+4gohhJ5RUDCJN/Tyvap0/DbxiFaj0fbLpgLnQOhjxeXvE?=
 =?us-ascii?Q?JfSt0XLjLF8dRf5iOSsLpDD9P4k2y7II3OKUvmChUPUm/2/RimoCwHAgaGOG?=
 =?us-ascii?Q?L7XMGq0OiOPSdOW//E3/ro35MpMiPEEsfI7fi1n9lfQCtrvKkftBvVcLVRqN?=
 =?us-ascii?Q?HPpetiODQXEuQonqOkikyKpOnHerVM+qQ/A/zlSFZ7bQ8SKUNn0X+/f5kG/w?=
 =?us-ascii?Q?zTfsp2K34oPEjTIab5OSZQ28ytkBRxLdpt8HjITswot5ZSlN7nBx6NLN+Q1g?=
 =?us-ascii?Q?aW5Jb1chvJgZFikbEAH5S4edGzU3x0sCBoHYkjEN7W6IZQs8uvQyvGDjah/7?=
 =?us-ascii?Q?Ca69aZRSjLjkOHNqq8JKX5AiyUVjw44J0aEnxeMe+SllDN/RNKi8LnG+MTbH?=
 =?us-ascii?Q?VzYln/7bDb7heuCvZqeQqVSPnt7UKqwZRMuVORuuZxeBd/xiS5d7SVoVkxtT?=
 =?us-ascii?Q?zaIHCjmTZ4jkbeqVgUCMruMVl8b6/KZkK4m+Vdua9KbeurhuVEp7RAy45ZnH?=
 =?us-ascii?Q?YUr8W+/tYVXFc9V8ImSCVsVRgT+2OMsXj1EDmttbPMf+gcCnUOg8SxxsPMep?=
 =?us-ascii?Q?K0rLTss5gOyVLq/4yvpTFhD6B6XLr4JgpjkK4UDxTctYQUDRYayAallS4FvD?=
 =?us-ascii?Q?NmRSQlPfq7KYRZvUFJp9kH8vKt+8rwFBdWfdoWKxrquhcyrtUM/SH5jfWTDg?=
 =?us-ascii?Q?vjUw+POu7a+azAbigv06g4GgSZdVDwTlUD7vnQlTaRiiBIxHuC1VVyrtoBZq?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28959de-a94f-486d-b0b5-08d9bc7b4073
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 07:52:59.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfkaBKHcM9RCCkfJf+mjfXy3FiKFR9h0uYeU8+xHigwv/zCMi38XXQmGvHGX4Aq0yjOmv7PSymYmwrprE/mJFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3860
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, December 10, 2021 8:40 PM
>=20
>=20
> > Then Qemu needs to find out the GSI number for the vIRTE handle.
> > Again Qemu doesn't have such information since it doesn't know
> > which MSI[-X] entry points to this handle due to no trap.
>=20
> No this is already going wrong. qemu *cannot* know the MSI information
> because there is no MSI information for IMS.

I haven't thought of IMS at this step. The IR approach applies to
all types of interrupt storages, thus I'm more interested in how it
affect the storages which are already virtualized today (MSI[-X]=20
in my thought practice).

>=20
> All qemu should get is the origin device information and data about
> how the guest wants the interrupt setup.

yes, this is what I concluded in previous mail. The hypercall should
provide those information to the host and then get addr/data pair
back from the host.

>=20
> Forget about guests and all of this complexity, design how to make
> VFIO work with IMS in pure userspace like DPDK.
>=20
> We must have a VFIO ioctl to acquire a addr/data pair and link it to
> an event fd.

No question on it. Still need more thought down this road.

Thanks
Kevin
