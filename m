Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41D646FB46
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 08:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhLJHck (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 02:32:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:56377 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232117AbhLJHck (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Dec 2021 02:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639121345; x=1670657345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0g4UFSZu+F1AdGcSGLaDjoe631tmNrx+bVeI5RrOqw4=;
  b=ms5oSoMZx5p6uLc/1B3BI79yvcxS5+DnYdGOMvUkd+EeXlGJIvvagIHI
   moC9xjen9SWELOGEbsWe4q1/GFD01vg5rEwuAB6Njx5X7bPlhaIeGDY+a
   lt6zzWNDVYrm6lD5qw9qApEuPYyDTrrAJiHPcy8a1wPrf4/KleotR8mcg
   wK7xWA9cRW6vHZg10P/6420cDoy6VcN2dZtjL+Lc0YZPRO1x+MuSW7vzJ
   W/6krCD68ApcrvbxZDOAdw47gIy5b1vDldFKILPjsgMlkUEObfu1dyozF
   8wR41dVCX6VKadeaSGNXv/DWMjWvYUkBh+6GkDagg7zSP5gPGhj3TvIZa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238097350"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="238097350"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 23:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="503828825"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2021 23:29:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 23:29:04 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 23:29:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 9 Dec 2021 23:29:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 9 Dec 2021 23:29:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gckaPVBlv45Kh9SEYN2anHfV2kGmWySa58dT5BSdmPjThsnZv/xJJZnmaUhZ2uzrPAAsw5dMjaRxpX3tcRFZoyQhfnbIMb8ZMpKiZW2gC0j9O5JdTLkVhKgbAIqmxqeDDIT5thiiuLYVNOBha9+ueEqjsz34f2+XBFbffSh/dFN2O+2ptz0pN7LcGMOT8M8NJuz3BqZYToXF6N37q1O3pwOzJTclcn0UMehKxxb4RMyf1Z8szOWlNO65Szf98DoXJjIpEw3To81NE5GV26d0h1fwNsMYEA2cFaGOtn6ypULsQLEvS21/WfXPgNtiqW9hLKBrO3NztrJnL4imWNT1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZz6ReOUMIdtowR5X+JPAtVTUL4ZDJIxHx7N6iOt7zI=;
 b=Gwwx/p4Q3WZVCrmDMCPfXqmPEbPETuwRsWaIeWWaS9E2ZzbMJCw8U/FP66uV/eWWs4mU6DMxUsO2fXXJOSPwzHjcuiEeWs7R4gRhbwvgwUc3/uSq8okVowqfE/9rKIYM2RP1slSVIBtzaAA0+fMC7djcvl2KpTW6E4qmX/EojVzS0LpJc7OyJ10FeMF5D8QXRE88AR9C2m6FGjapw+PUhQrMSWbsSfzGGUyQyW4g9BLV9eKKSo9bmecRFrOXMM7UR5S3Wwli5mTPmqAeIgEDFsBBW2beotdlU2n8dGanI39fR2VFTyExKAnUMuL9OwYBUoZNWSDe4DAX3bUX5Fo81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZz6ReOUMIdtowR5X+JPAtVTUL4ZDJIxHx7N6iOt7zI=;
 b=DBiQGY8NfSkxwc0ngwzb82z9uone+GsJh1xaTOAkZaD/cQOxtcrU5+pvB874CHp1Xu8KyeczfHE7dxTKSYj8QAUcuQJcQwEr37jAPUnCUopqjdxXyQgFejmElcoe8I4MemIKdbumcReKRTQBs87HauZNGpUUnNeiAPdKDCc35n0=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3713.namprd11.prod.outlook.com (2603:10b6:408:8e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 07:29:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Fri, 10 Dec 2021
 07:29:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
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
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAE+oAgAAmHACAAFJ4oA==
Date:   Fri, 10 Dec 2021 07:29:01 +0000
Message-ID: <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
In-Reply-To: <87sfv1xq3b.ffs@tglx>
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
x-ms-office365-filtering-correlation-id: 06de6b41-6cd5-4ebc-66f4-08d9bbaebd10
x-ms-traffictypediagnostic: BN8PR11MB3713:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3713E5F51F5AD3469C56A3A28C719@BN8PR11MB3713.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CaY8cfLO2Cg2Eo/IqNXqq6Xb3uNK1u4Xh7fMKyOZ6GzdhUa4r6/aLEm9Ts6LQoVegopTx4MFTGpsXzdisBn70AX1Bbyofz9giMLbZ8UgcPEMtWOvUoAJ7olFFoSYSFpWQeBpLPCSi6O8cVvOAHsBoZe1icqLwDq7f9e52YhNMj5TfdU3Vlzi8BBe7Ge2hAJQjyoQ3Pa5jfy3nEeNoIJoKZPUympqgjLVD3vD/C8/Nwjhz+cOtEUEFoO2K3K7RkaFWXu47vf1nUglg6gZDpJ5+QPFpLvbVY1Lo77M3sj/tnjxCbv4J+u5p95S9+PMQ8B8MAMA6Bs/tC4IFfR/Fh10ckspCnzw4m3YdGX1a22QyA38gNBgcXV/gytF566DvMydMXDRSeg1KEcGl1rrAjBpOivxOcMFvhUWxX0lUtajh+koHVZIqaG4TY4k/jnPB/WcmrGXnoUDF6szVJ4rWcEeoJQhKpwXvONfCFu2sgSbvecySv6QfR6C/1g5Oqn4zpxbh3NyHaY2SlX2sMM+qkl0tYGOse8UGjMaFhbqxzomjbiGuxMBDSBanUDw5zkvNcNRmparZymZeOWkEw6yAMl/+ZObTPFi4MRouaqOMq6egijIMeCLaRkUhGarNryXAJZPMsPxGm0Dc7dOqJjkmxKRvaBPMIMovPtlhdq7mhKWzPr6YvqTEnrG0t9AynFSjPtm6qk6NUojwwEeXSeKUqp5Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(64756008)(508600001)(38100700002)(55016003)(7416002)(86362001)(38070700005)(6506007)(54906003)(82960400001)(66556008)(316002)(9686003)(4326008)(8676002)(8936002)(5660300002)(2906002)(52536014)(26005)(76116006)(122000001)(33656002)(7696005)(186003)(66476007)(110136005)(66946007)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8oELUMSs+btzOK39w91n49HbC7r7n59aYVdZIa+zI1ucIB8tTIoHg/PgyVOK?=
 =?us-ascii?Q?juBiw1az5VMZSbTaaKRJ3RNntcrb4aAgLE4WbgRknNJEqTHIiYm8rDapH+N5?=
 =?us-ascii?Q?ogHQFg74V+Q30I0r4LfoMxm2dOiolgd9h40axuotMpww1qQUTv89adeRBqBr?=
 =?us-ascii?Q?FDJBbCmoXzlf5Xy0N6OleKat0Z0rgpbO27hCRftB2YE6g85sk5ouhR9K32fV?=
 =?us-ascii?Q?qivAeDWOBGl8bW1dRtK695csIJLbThS4z+zsJ7s+DPFqr2Mr9kFqlZ+YBwqN?=
 =?us-ascii?Q?Tq1atqAs+OTmCBalbBHmn48Xrk6f3SAo7PMPPXVWOoCMcakiDJOx2bHHEPRS?=
 =?us-ascii?Q?bzmIMQbKewqvprFcNjetFchIiNOlgGZNRiFuQncKLr1+QSJ0q/k1hqoqNxjT?=
 =?us-ascii?Q?ysi41t92cK0esUXR8m+9cIwbaqFXB3RgOFxL5jaY1fSp8a4jNenbq7pkShGR?=
 =?us-ascii?Q?ElZdq+uBjsFoBG7xND7E2grtT5YrsKx32F0uNglo17lHYjFWzK/d4oRE+uQy?=
 =?us-ascii?Q?Fa/li43nnTs2iwstqfOWo0yG4Q6gKL/Xqzsn6TT27FKUMgSrJ1wkDLOFJFXo?=
 =?us-ascii?Q?ANI1sESnW8rje5S/zQgrNpPBsP0As81JcMexUy0TZWEyP86rYobWw/ZPtn7S?=
 =?us-ascii?Q?Vz95X5S/K/6fbLY/V/kuFWjZO9sjCOruDn7NEDfO25WXQXagkTQyI1KuShpv?=
 =?us-ascii?Q?npmiw4b4omgC8cdP4WLC9McOJTSHGvO0zcmcDeICdR9LHilqSyFjBUB3dlU/?=
 =?us-ascii?Q?6iVLp1G7P+I1xX/EIgOATsCq6xo1OqJwlYL42S8T4zOhfID8NiWIxCD58wE+?=
 =?us-ascii?Q?KSq31GVyhaH6i7ZdZQhpfhOnOcu+mPe6/k6Z0n7D8TrG4hEIoEYT9KgODDOS?=
 =?us-ascii?Q?xwxc0h9L2mXlHpsl8PIPhO6TQNCPWRcbxzyTt4VgmNv97iWuL7ePfPPfQ3A8?=
 =?us-ascii?Q?KHhx1HyJI/q98SfCNRWq/B8EZmUq9QNPbQicm0Mha+i7wHElVHy61J9pTRdU?=
 =?us-ascii?Q?4nXB4Hptv1T7MVXRW+e0IBa9xAqbR7cInZ7MnP/nYjWFm9HhnBHkop4AUy1P?=
 =?us-ascii?Q?1kV+pPqSjqzq1WAZdrLJa/uwl0erzI4CsH/JEp+iO9L7IOUidS/fulqvRi0k?=
 =?us-ascii?Q?GBd0diQVE4HwgBgxIFCRo51ayRVCGpAMakzSdiFTcT0GU2BXeR4gIBTrUjJ3?=
 =?us-ascii?Q?K+C02zlcz+ewaOoZeT4Ukmd5zIUxv3KzN0cVmOfdUst5TgoDUcEVaiDbpHK9?=
 =?us-ascii?Q?bexmseazEahHhFbvIoB/qGnvEM9PEh8g15g0NTBpoR2FwDmt+WpKXtjK4Cd9?=
 =?us-ascii?Q?2rYmGxxiLppfIGBQ3LJnNXr1VDTOlXvu56p1JBOodbc4OxvHHvoPjq0+q5tf?=
 =?us-ascii?Q?qP0qJgbycmv1NJsli0C/8S9ueNE7cS2IQI9mFBjzlwyySsiEoQYLXhh53sLd?=
 =?us-ascii?Q?mxIdxMKG6GPRq39/7w30CkwSVXh2TyxcfPWlFnkBqvh5I716QNuWlfMgoWwl?=
 =?us-ascii?Q?SKFf7oOETi+GPhlz0265M/H0xaZFQalG2nZ+3hsB19Xa/HBME5c6l7AYV7um?=
 =?us-ascii?Q?tft0Xmwh3lu1kghYWJ9fF8HsrOH1l7GWlFhoZr+bombknYwAzSl3MVMJSmIB?=
 =?us-ascii?Q?vTwmdpC7b+BUQjGKVV0T8hM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06de6b41-6cd5-4ebc-66f4-08d9bbaebd10
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 07:29:01.8117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGIEnQr7Gl2niEsXbvaFzRJwVraWfZSf8B/dTG0sAbyy3ddtvQQZrb4sW0gXsm9E1BYgXBg/20cOtaNePwuiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3713
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, December 10, 2021 8:26 AM
>=20
> On Thu, Dec 09 2021 at 23:09, Thomas Gleixner wrote:
> > On Thu, Dec 09 2021 at 16:58, Jason Gunthorpe wrote:
> >> Okay, I think I get it. Would be nice to have someone from intel
> >> familiar with the vIOMMU protocols and qemu code remark what the
> >> hypervisor side can look like.
> >>
> >> There is a bit more work here, we'd have to change VFIO to somehow
> >> entirely disconnect the kernel IRQ logic from the MSI table and
> >> directly pass control of it to the guest after the hypervisor IOMMU IR
> >> secures it. ie directly mmap the msi-x table into the guest
> >
> > That makes everything consistent and a clear cut on all levels, right?
>=20
> Let me give a bit more rationale here, why I think this is the right
> thing to do. There are several problems with IMS both on the host and on
> the guest side:
>=20
>   1) Contrary to MSI/MSI-X the address/data pair is not completely
>      managed by the core. It's handed off to driver writers in the
>      hope they get it right.
>=20
>   2) Without interrupt remapping there is a fundamental issue on x86
>      for the affinity setting case, as there is no guarantee that
>      the magic protocol which we came up with (see msi_set_affinity()
>      in the x86 code) is correctly implemented at the driver level or
>      that the update is truly atomic so that the problem does not
>      arise. My interrest in chasing these things is exactly zero.
>=20
>      With interrupt remapping the affinity change happens at the IRTE
>      level and not at the device level. It's a one time setup for the
>      device.

This is a good rationale for making IMS depend on IR on native.

>=20
>      Just for the record:
>=20
>      The ATH11 thing does not have that problem by pure luck because
>      multi-vector MSI is not supported on X86 unless interrupt
>      remapping is enabled.
>=20
>      The switchtec NTB thing will fall apart w/o remapping AFAICT.
>=20
>   3) With remapping the message for the device is constructed at
>      allocation time. It does not change after that because the affinity
>      change happens at the remapping level, which eliminates #2 above.
>=20
>      That has another advantage for IMS because it does not require any
>      synchronization with the queue or whatever is involved. The next
>      interrupt after the change at the remapping level ends up on the
>      new target.

Yes

>=20
>   4) For the guest side we agreed that we need an hypercall because the
>      host can't trap the write to the MSI[-X] entry anymore.

To be accurate I'd like to not call it "can't trap". The host still traps t=
he=20
MSI/MSI-X entry if the hypercall is not used. This is for current guest=20
OS which doesn't have this hypercall mechanism. For future new guest
OS which will support this machinery then a handshake process from
such guest will disable the trap for MSI-X and map it for direct guest
access in the fly.

MSI has to be always trapped although the guest has acquired the right=20
data/addr pair via the hypercall, since it's a PCI config capability.

>=20
>      Aside of the fact that this creates a special case for IMS which is
>      undesirable in my opinion, it's not really obvious where the
>      hypercall should be placed to work for all scenarios so that it can
>      also solve the existing issue of silent failures.
>=20
>   5) It's not possible for the kernel to reliably detect whether it is
>      running on bare metal or not. Yes we talked about heuristics, but
>      that's something I really want to avoid.

How would the hypercall mechanism avoid such heuristics?

>=20
> When looking at the above I came to the conclusion that the consistent
> way is to make IMS depend on IR both on the host and the guest as this
> solves all of the above in one go.
>=20
> How would that work? With IR the irqdomain hierarchy looks like this:
>=20
>                    |--IO/APIC
>                    |--MSI
>     vector -- IR --|--MIX-X
>                    |--IMS
>=20
> There are several context where this matters:
>=20
>   1) Allocation of an interrupt, e.g. pci_alloc_irq_vectors().
>=20
>   2) Activation of an interrupt which happens during allocation and/or
>      at request_irq() time
>=20
>   3) Interrupt affinity setting
>=20
> #1 Allocation
>=20
>    That allocates an IRTE, which can fail
>=20
> #2 Activation
>=20
>    That's the step where actually a CPU vector is allocated, where the
>    IRTE is updated and where the device message is composed to target
>    the IRTE.
>=20
>    On X86 activation is happening twice:
>=20
>    1) During allocation it allocates a special CPU vector which is
>       handed out to all allocated interrupts. That's called reservation
>       mode. This was introduced to prevent vector exhaustion for two
>       cases:
>=20
>        - Devices allocating tons of MSI-X vectors without using
>          them. That obviously needs to be fixed at the device driver
>          level, but due to the fact that post probe() allocation is not
>          supported, that's not always possible
>=20
>        - CPU hotunplug
>=20
>          All vectors targeting the outgoing CPU need to be migrated to a
>          new target CPU, which can result in exhaustion of the vector
>          space.
>=20
>          Reservation mode avoids that because it just uses a unique
>          vector for all interrupts which are allocated but not
>          requested.
>=20
>     2) On request_irq()
>=20
>        As the vector assigned during allocation is just a place holder
>        to make the MSI hardware happy it needs to be replaced by a
>        real vector.
>=20
>    Both can fail and the error is propagated through the call chain
>=20
> #3 Changing the interrupt affinity
>=20
>    This obviously needs to allocate a new target CPU vector and update
>    the IRTE.
>=20
>    Allocating a new target CPU vector can fail.
>=20
> When looking at it from the host side, then the host needs to do the
> same things:
>=20
>   1) Allocate an IRTE for #1
>=20
>   2) Update the IRTE for #2 and #3
>=20
> But that does not necessarily mean that we need two hypercalls. We can
> get away with one in the code which updates the IRTE and that would be
> the point where the host side has to allocate the backing host
> interrupt, which would replace that allocate on unmask mechanism which
> is used today.
>=20
> It might look awkward on first sight that an IRTE update can fail, but
> it's not that awkward when put into context:
>=20
>   The first update happens during activation and activation can fail for
>   various reasons.
>=20
> The charm is that his works for everything from INTx to IMS because all
> of them go through the same procedure, except that INTx (IO/APIC) does
> not support the reservation mode dance.
>=20
> Thoughts?
>=20

Above sounds the right direction to me. and here is more thought=20
down the road.

First let's look at how the interrupt is delivered to the guest today.

With IR the physical interrupt is first delivered to the host, then=20
converted into a virtual interrupt and finally injected to the guest.
Let's put posted interrupt aside since it's an optional platform capability=
.

    HW interrupt
        vfio_msihandler(): ->irqfd
            kvm_arch_set_irq_inatomic()
                kvm_set_msi_irq()
                kvm_irq_delivery_to_apic_fast()

Virtual interrupt injection is based on the virtual routing information=20
registered by Qemu, via KVM_SET_GSI_ROUTING(gsi, routing_info).=20

GSI is later associated to irqfd via KVM_IRQFD(irqfd, gsi).=20

Qemu composes the virtual routing information based on trapping
of various interrupt storages (INTx, MSI, MSI-X, etc.). When IR is=20
enabled in the vIOMMU, the routing info is composed by combining
the storage entry and vIRTE entry.

Now adding the new hypercall machinery to above flow, obviously
we also want the hypercall to carry the virtual routing information=20
(vIRTE) to the host beside acquiring data/addr pair from the host.=20
Without trap this information is now hidden from Qemu.

Then Qemu needs to find out the GSI number for the vIRTE handle.=20
Again Qemu doesn't have such information since it doesn't know=20
which MSI[-X] entry points to this handle due to no trap.

This implies that we may also need carry device ID, #msi entry, etc.=20
in the hypercall, so Qemu can associate the virtual routing info
to the right [irqfd, gsi].

In your model the hypercall is raised by IR domain. Do you see
any problem of finding those information within IR domain?

Thanks
Kevin
