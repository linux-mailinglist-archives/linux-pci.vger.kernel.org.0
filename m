Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4504946FBA0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 08:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhLJHjw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 02:39:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:37275 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235161AbhLJHjv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Dec 2021 02:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639121776; x=1670657776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7rVFFBCwMZFFsmKWB83JZ9GzWl8G/vODzompyfs8e9Q=;
  b=GwO9LrL89glnvVqjOoRLJT87fNaCkrBZArjzj9vfv1dcZw2lJJtm+/Kd
   yNSuZ9UYiSwybCLWX5uaNiT3z82ht6xNbxxZVx6OIx/WsEaXYX5N9SM5h
   SRdu753z2mkedE6/RWrAhnVWTgwkJP6DdeFgltMu3uAYB/SQbTSRIQEET
   leke1FVZWSN2MtwSzeGUtjDSBTjER5OhhLDyibfSx6mg2xBl5iqNRyxUt
   2kDw5i4oXYlzYCxm+GuLFMQowwSEgUx8gGQID+Q0tXUp7eqaPymbm3b+H
   Jfk24n2GUdVfhcSOsan15yjURY7WYRILBVLRSlSWcjsQ57Jvvei/fBMGm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225164249"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="225164249"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 23:36:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="543886766"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2021 23:36:15 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 23:36:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 9 Dec 2021 23:36:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 9 Dec 2021 23:36:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh2NKy6oncZMM8z8yq3zkWAB8TGLzR7OfTY3dsUOWuZ0oeALpGAfJLo9IwU6W0+0Ckbl89D0GEatPmZaayB5EVPfIZPyy4ce+Hli09paQVk2dzMFBdGDOvX/cS7P/G5vcpBcqWf1zSWD2OzRxVglxKwMgtMByXhVZNdX+LnzKNqE7Jqer9G5prjgb2TMRdHkFY9vjQLpUX4VB52nDga5chiTCyM5pVn2UjbRgBOVBq4FZsKdLkaZDtVrPBp0yUzDnHaA1b8GwXNW5GVajhQt9YyGMx0f47yOKurXD+jeS3aYn6NGwyD6Hkp/ETQxbTQdvERetLOqbnjzXeY+dxLBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAFDR2oUkRqk0K0jPTjKI9YMKrAhpfgZddRAhc6PCUs=;
 b=fG3GxcvvE4XadV9UqRsBVcXuD6tooyErKNjrsAs3MGWgrHzP8Wlsyg6rpY6vmxelpyVc0QGZQpRf51xpDf9xFAP+tNF+YMLyQbPcSTZ8qbXK610cbf1D83xwm7D+ZqPTmxNGlhl06rLAzti24C/6RVJNlAOaV5e1DUaKefNtfZdRfCYxQxOHTf3uTNJmiEYqwVDWOMawasH+oqcdqsOAAV7eI1mFxxWLtfxAQGgZP1cSnRTJBYIM4VlwGnDCyFMdQYdP64joR9i/xW/WZdoOA7Om/1kdLsFA13YsWfJa+yWqXv7cGuJvNVyrKfy/LufXxT9ckwlYcHB5EhadE6NsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAFDR2oUkRqk0K0jPTjKI9YMKrAhpfgZddRAhc6PCUs=;
 b=PsuUHXhVas2MlrH3X20/oKlScorqU/UGMzCF7s6fDRvMrS1mKTCGeuhOThOE7XrKtwfBYxhx5r4QtraAAR8AXq3IAhD3gGc5boPyu38olMUJp5Eh5l1VzOaEjzQgXVsCbQ1x7Ltqq0fjxTs/Qtw4bl7S3aJOaLCfOk+WgiOVX5A=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3652.namprd11.prod.outlook.com (2603:10b6:408:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 07:36:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Fri, 10 Dec 2021
 07:36:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAsDnw
Date:   Fri, 10 Dec 2021 07:36:12 +0000
Message-ID: <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
In-Reply-To: <20211209205835.GZ6385@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96020c36-a142-44b3-4b85-08d9bbafbdce
x-ms-traffictypediagnostic: BN8PR11MB3652:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB365253666649205AB0AF6F118C719@BN8PR11MB3652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /657dP0mh/2iBUf9wDEJBTfKaYW6Jrc8vJXsgFsk0tckl+lxJHufoq0eVKxGUhQUEaY+K2OqUuyKL34a2o14Xrm9fAp0ko6GaMOlhNsGuQJzSmsJV//KeZBAuDdJbgrLwloNEUtVs/rM+8pH89kjwItnNh5x7pl/iBZqxF0TE2s3ft+lRwgmQxsCOmULUSAg2w1ogtjNYChVxgRN7k9MfP8vtI8MgWseCYTsODnnj5gM/t2JLbqOoUJ+akLz4uSHajLhJhTps/A0KOy22cLeWtvod8WGCeJJ33GRVzkqObIb+yV/pDpMiuKhkkinGcQPbxRBm/u84/w4I246izJz2+t3I7Uxh0HnBwsZZud7sgdI47sr5XG/K3vmfu+7usYdsY/pUVqDh/1vjIPdLLsGt+Kd+0LNZonpl7OEiyl2zTP94Vc8Gy2ot8dj1/n39MEIDJjsucUk/2NtyQgpPOpZuz+i2x57ceHNF39PgXNkZ0K4+l/Tt1eK7e7ODqMjLLXjhED03n5br23EsAtT/tulzBF2i/1B4P+8zShXUZ9724KYisVqbP3K4OzR5DeSxHX7GaAZFGeZQYWvWwqziXUlK8t+97yXgBXoufhiv/B5vGPWcWBq2EoGat8+6YEwpb9QiZ1F4XKb2eNNRZQf0u0jdUp3qXUAkehpQjqLFCy/ca/lQCYiiGBgEDzgR4UuRUcnYeO8o0mYa9vOFiF5CbKDhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2906002)(55016003)(38070700005)(7696005)(7416002)(5660300002)(508600001)(6506007)(86362001)(71200400001)(122000001)(26005)(83380400001)(9686003)(76116006)(82960400001)(4326008)(66946007)(66556008)(66446008)(38100700002)(64756008)(110136005)(52536014)(33656002)(316002)(66476007)(8936002)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wmb2C6oQBnZDq0fxSZ84ZZn/PRr1Vx17p/I32hO0lFF1oFigSADhb4HpaBdb?=
 =?us-ascii?Q?sWOhwEiyaICpgl+ujhIIwmKe6Jk+HAV9EsEIIJBMb63EW5vVh0Ffc2/l6YDp?=
 =?us-ascii?Q?8Nj19/bLckVyKkIpr0etXlMi9Jemh36CPGz7NWWtUHP65hDJxgNadkpuLsU9?=
 =?us-ascii?Q?eLOODCEvrBIfuzr4uN8Yz8+p97w5bf9ROV9+rYuz6U1guIi4irawGlQzwE4M?=
 =?us-ascii?Q?k+cWsWf/Eoi6sQ5X4v6O9JSLUj8+3PX5xUdcpbDHPhZy9dvLfNeyO1rEv6fb?=
 =?us-ascii?Q?9/zMrXESKg+Dpz7L5RFKuR7sTQDpaGgIkfZJ6w2/a//OEKtHaHxdHXDUci5B?=
 =?us-ascii?Q?PvdY358maYWlbfp4EkB2NDB5yB7kyxA1+Xi2uogNmXbp/KgxlPDnIPAlwHYn?=
 =?us-ascii?Q?ysLdNvIqpPri06rPfz+OV3HeSv0+RPjtUb+s4UkRhooAT2l70w5hZIW9Ayl8?=
 =?us-ascii?Q?GhfF4kJ7EyMJn6hX6e/6WdHV4V7y7/U1IF8TvSoxtnO+QU+KU8e5efeyhk2R?=
 =?us-ascii?Q?dV2gLO/odK8gU2a/XTTD7lzANKzogy74QfuRgoCT2dSoCUzgp11yBzDqV26B?=
 =?us-ascii?Q?rUsodh/I+TsxtCEKFlPLjeNm6ocWUQ4ZQ6s8LYF79u249hxOEIkUiqmE7eKZ?=
 =?us-ascii?Q?1fWg7kC37jyv5KnAjtx5mV/jDXOMc5zF5mDGvIqS9zpL1vC/NPeL+pn11LFv?=
 =?us-ascii?Q?C+hAGgxRWqmWClO9eB5d3B2ZB+0mk2wru1AJLKlXIDd3S574zrDrhiV724vq?=
 =?us-ascii?Q?BKDJ5IMvojGw2290eWKjn2ma3rOnFX5kTiAGHAzT3qlK874jHlVvGm2/d6ze?=
 =?us-ascii?Q?Kk3PffRVrAHkOe6PiqXw5jeqRhU25lJyl/Nn+Z0rTDeL7dPYDKxEPCxWYBcq?=
 =?us-ascii?Q?a4XJeVgT8YQqQ7SfKXbCm6SRT6RPXVWDDMQd+vHFlAzWUvV+iH4h8Afz0ZZo?=
 =?us-ascii?Q?aA3vD5IspE54bxrCvwAhGecUXIv0pHeEipGrZiwl6YewYuS8CQNdBa+da/Ro?=
 =?us-ascii?Q?JS7KQwL9FEXJreBhutES7keSFFjuZkDLcJ8/aTn3s6vVgloKXO4AbY7dHSvo?=
 =?us-ascii?Q?nKIQEAXnFhGHdc4lVVqM6X6gJHq+gqWaqxEfKaPasOQiFYBhHTJeVl97Cihq?=
 =?us-ascii?Q?YrKAeiBSsFe4nvk1/D5JVsL4Z2cHFapMdYWh0aSXUE+dLAB8E7Ws1IGps4+O?=
 =?us-ascii?Q?PVQlncAZwMcLwW9fjAlHQH8EFfajzFsFCL4u1AcddYUzjTACNtpE3tEAqSHo?=
 =?us-ascii?Q?qOJD3vfH7lS1zCNmJpeKGV4tjyP/SSwMoDa9J63j69siYkDLZppktYL0aWxv?=
 =?us-ascii?Q?sam6Yc4JzTr02o9LmCGVCxi2/ygdZGQXAnSIeX6fmIMO26/AIpBdHL/3ksMG?=
 =?us-ascii?Q?+qHCF29Weh4qmphKdov7dB3fgBzhnmjqrLcLU6hGYwTzE7xvg1MbOcf1eHhE?=
 =?us-ascii?Q?ek2SAO0arTppU5VI+p5KuDw5zIK73IUkrJWujJuzKmIqCvt9jphamaaGFaIX?=
 =?us-ascii?Q?VFj83GiWgrU/CD0V4EoHkdq0vuPwDs+lTEunIGZ5EG725/ZnArWYxSV5guCK?=
 =?us-ascii?Q?aEfETK8ZGpkftPNlxIDq7/4G7WDGSyBCgoFTLQ5ToBHbYPYBG7Nrp2MFBwVl?=
 =?us-ascii?Q?ugLNzeSyq5fNq3prMCFbmA4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96020c36-a142-44b3-4b85-08d9bbafbdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 07:36:12.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5XyiUZhVgoGIPDkzzxU1E3ZeqQdwLaczRXq1rj6UoyRfucFHCTHVxw6BZRLXXNt04o4Bz4zswtD317I+psKSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3652
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, December 10, 2021 4:59 AM
>=20
> On Thu, Dec 09, 2021 at 09:32:42PM +0100, Thomas Gleixner wrote:
> > On Thu, Dec 09 2021 at 12:21, Jason Gunthorpe wrote:
> > > On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
> > > If we keep the MSI emulation in the hypervisor then MSI !=3D IMS.  Th=
e
> > > MSI code needs to write a addr/data pair compatible with the emulatio=
n
> > > and the IMS code needs to write an addr/data pair from the
> > > hypercall. Seems like this scenario is best avoided!
> > >
> > > From this perspective I haven't connected how virtual interrupt
> > > remapping helps in the guest? Is this a way to provide the hypercall
> > > I'm imagining above?
> >
> > That was my thought to avoid having different mechanisms.
> >
> > The address/data pair is computed in two places:
> >
> >   1) Activation of an interrupt
> >   2) Affinity setting on an interrupt
> >
> > Both configure the IRTE when interrupt remapping is in place.
> >
> > In both cases a vector is allocated in the vector domain and based on
> > the resulting target APIC / vector number pair the IRTE is
> > (re)configured.
> >
> > So putting the hypercall into the vIRTE update is the obvious
> > place. Both activation and affinity setting can fail and propagate an
> > error code down to the originating caller.
> >
> > Hmm?
>=20
> Okay, I think I get it. Would be nice to have someone from intel
> familiar with the vIOMMU protocols and qemu code remark what the
> hypervisor side can look like.
>=20
> There is a bit more work here, we'd have to change VFIO to somehow
> entirely disconnect the kernel IRQ logic from the MSI table and
> directly pass control of it to the guest after the hypervisor IOMMU IR
> secures it. ie directly mmap the msi-x table into the guest
>=20

It's supported already:

/*
 * The MSIX mappable capability informs that MSIX data of a BAR can be mmap=
ped
 * which allows direct access to non-MSIX registers which happened to be wi=
thin
 * the same system page.
 *
 * Even though the userspace gets direct access to the MSIX data, the exist=
ing
 * VFIO_DEVICE_SET_IRQS interface must still be used for MSIX configuration=
.
 */
#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE      3

IIRC this was introduced for PPC when a device has MSI-X in the same BAR as
other MMIO registers. Trapping MSI-X leads to performance downgrade on
accesses to adjacent registers. MSI-X can be mapped by userspace because
PPC already uses a hypercall mechanism for interrupt. Though unclear about
the detail it sounds a similar usage as proposed here.

Thanks
Kevin
