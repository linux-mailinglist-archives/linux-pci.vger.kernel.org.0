Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80B46E20E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 06:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhLIFou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 00:44:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:28195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232157AbhLIFou (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 00:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639028477; x=1670564477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v+PP1ZNU8Zy98NMnAYiLpMU2Mcvyja7AivmpWBaYBVw=;
  b=fFf9ml99REvGgjbWkFRTC/iPyraG+KTWE3EM7mrzbke5Yv0VqrtaAavh
   6dRjA+Nr6uqKYX651xEIdXQ/L+O3rdnqL9ZJ31s1joVK2RZGkcVGDCjlm
   D2Qo04hFcyA9O/kBbTEwDZO3X7DIxBE8d0FAje7fOgH3fD0fB/4n1nMYq
   2LT5JdjfCHqcXd46DBaetTZuPAetWQMXl3O8VSd1RdBmpnr7U16TpY9iC
   kC9I3eQeleeS54CNdW3QDM9Nv1yXeZAJt5oc80HcWDX3hKM7Q9nLxq0rm
   7H4OqW/HiAdmZgplNXYPsUykXj1G3Opso+qHYfdc/YN5TyGwvtCsV3TmX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218708612"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="218708612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 21:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="606727926"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2021 21:41:17 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 21:41:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 8 Dec 2021 21:41:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 8 Dec 2021 21:41:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNOzoORFO6N/Tz1u9nPlnKjlfWx6QZdI9IubC6kHIY01Y64d7c4INfvHPoHsiiAbIcB7jkWmj158ibvgrAJfTG0Yys4+7ibh49bpnlyOH3zCoHnasyNoeZiGDZDdRGPJPhTRO3sB5Rpq7O9JWFXdSJW59H99za5RzOYR8zS99HwnW9bWn9Q+du0dLXATrd3qT8wh3J3PXPnJf91yqjwpLUhuC2ZtNFy6AoNTqrK3tNPQcTeN4vBMI6Ide1Vv9Lo3VIRuQFrqAbn3CGX0dAzzMnj8koxor5Jv5XR+5L0XFRLOiRZQBWzQn8CxWArn7ahWCOUS5puveKGsvUDV2MTpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+PP1ZNU8Zy98NMnAYiLpMU2Mcvyja7AivmpWBaYBVw=;
 b=dC2z46+/eCkOljvJCEalaRQKxyksBIUP9FrbYnsAsAPTJSJw+NznNbW1qpn7Nd7yOVzMjVokI88/c0i3q/0yMJxMD8S213KHdK+2mWilgSRY4MIkOv0+gNUbKB8SdejH2gV2kChSipUOqPhsbqweoTb8K1yn42zBsZQn2Qd6HijcP5sfJpVU9E18UAIsTwDPadcvNFtRErd4PXAavB5O6hLdxWflz8d58fSV7oCnot6iUxGrErxXucaGdmALnSCnPbr8Don4kcQTKBozY5MOiRzx4yTLDFKumX1A8kZ8Uy7l/OqHiPUQnfZDWqkUpC/SizDhWvj5vaEG593Rm4J+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+PP1ZNU8Zy98NMnAYiLpMU2Mcvyja7AivmpWBaYBVw=;
 b=uDzm8o/VE9LX59lxTQqEFyo7lQyN3tASJ8GT1sRADY19zOw2eDTIq1cMbMwTNnxmAFGVC1Zp4n8GbckXvpO2lrcPkFGkfNFidldGU7gmwdpVFwyf1N5flZKD0ieXXQ0gjqZaFbTZDs2nJPGuttOIrmPsE5kAcGFYnJ2TplbwXrU=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1315.namprd11.prod.outlook.com (2603:10b6:404:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 05:41:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Thu, 9 Dec 2021
 05:41:14 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Marc Zygnier" <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgAAttoCAAEzjgIAACsMAgAAjl4CAAD2IAIAA6NQAgApo/UA=
Date:   Thu, 9 Dec 2021 05:41:14 +0000
Message-ID: <BN9PR11MB527696C0E8D08680FFFB6BAB8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
In-Reply-To: <20211202135502.GP4670@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 01461389-5de6-4068-f2cd-08d9bad683ad
x-ms-traffictypediagnostic: BN6PR11MB1315:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1315647B552D5FAD0902415E8C709@BN6PR11MB1315.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: avLkqsrKonm7Ggw9tVhhrdFmzJ1IUuXDpvTxR99ye71j3SwB20/Q1osjUcbHo2fV0eAW91TT1cSJbZQn9RFxXIoen5zxTQVQ6y554lK4/iJ5dYXHj6uzzHL7h8oSqy8esQi3Cw2Ex6t1uTU7sUU4erDXxK3C8zhIb5LtixfBZ1xHNz4xVx1l80femxrLml9EgsPAIZfhrYiF+zG+BCXEntUfpF6g++RGV1WDVOhgI4TMLSREvg4D/tpAu/V0VvJDWXPJZ+DUTRsrhLy3OtbcwMoMxjkr6ZCxg0OTWFP5gLAB3Hcnpy47npcQ/BP5NcGYBW4NdwrZbaWC3VhHlPozD3pjV4+rk2ozRDVNJy3N5aEKXT45NkSNFNioUOQaa5KSGj54yPplngO9JXH5SaN1nkhpcYrB/CfVmNd/meNG5b7FASkGJmg2Pu/LqZTu1oJyDrNFhkAxmaXZt7vGm7eChNFnpE4KfAVaYMjRj4PhqHw4zZr1qktN32PyFKn1ZFMjQyXivrWLuPTt2wlqB3DZR03hcPtbQ3k8GGArbpOJxs+vY5u8kvzDGl3ywK8LRRgldWX2LDfcntjSH+hBhRD6uRxG8E3AxjJ9twJi+81nwe8lr8KoQpPgsZQN4LIi1LWA4v/5ayer2UTOQ582mbTIBBd0e1iDyb+h4II3IyxwUBcSP0xzfrjy5pG/zAPXL/Yq/u60qS9w+cX78nI0tJhy0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(9686003)(8936002)(508600001)(7416002)(8676002)(38100700002)(38070700005)(2906002)(122000001)(110136005)(54906003)(76116006)(4326008)(55016003)(26005)(6506007)(7696005)(316002)(83380400001)(5660300002)(86362001)(64756008)(71200400001)(66476007)(33656002)(66446008)(66556008)(4744005)(186003)(52536014)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rUwuOavsESzpU1yGBdqIOajt5sUiZhTWCNYj9OXn2GH8ukgPBL1gVBF4NV3p?=
 =?us-ascii?Q?RbtBQyYNWA7xMEnvX8JhJApm8l70UXyZxOz/Xtlyv+GDxUOKqXWV/wnmFd1C?=
 =?us-ascii?Q?d2WHoRpbHhC/w91cS+NfaH7KWPy89XSNPS2sjpXnmYO53AydafpHEPii/RlO?=
 =?us-ascii?Q?MsDQ6snAAOi230aMGk7hs0M4WQj2NBhAUhzr+Gq06k35KMVu33/B/CXaB4yp?=
 =?us-ascii?Q?/gwZH21bNdA9aqaLVQ7DR5bz43/sbpcKD4fQKTmTYtF2tWbMHgMDMZJXPm0h?=
 =?us-ascii?Q?j0oMGefUp1O/F/UTHzJjIHD1QX4t+EG5fvk6D/Lt09+mAw+gtoPVDwfLP6rN?=
 =?us-ascii?Q?eD4uL/bVssKIfC6pizCE4xNpmvJXaFAnT6D56zm3M0ybl8zyzmekF/W7E+AS?=
 =?us-ascii?Q?nqOcVZEcalureOOpxr+GudGOPGj8NRPlldQ2sd6jw45mJOSraEYAMRQFrDlb?=
 =?us-ascii?Q?KuC8MiqmbtkQVD+SyENeRU6eCHQWMy2HwjPikaSUn4DM43xfwzmM1MMgFvFl?=
 =?us-ascii?Q?HSAhT1D56AgTVbLCDp8D/iaDkzlm0cb9q2T1wyEWEYddXz5odcWpU9Z8NaEG?=
 =?us-ascii?Q?kTHZX2m463dQaNLlCqz45hqv7HpGSzznXvIQxooVTA88esGKX/Vwz60+BFJi?=
 =?us-ascii?Q?udKdSP6GyEwFvNINzlKs1horuWMT6P1qoo+xP02JsR56hpOxhHrfxRRnNfvR?=
 =?us-ascii?Q?tDGu5Rd/2JdK5ELHTE98cNr4DyLstOoppuVnkFJl/jl+UWETWw4PmNw1kalX?=
 =?us-ascii?Q?FeNlD77Mq3+iH0Gq62PlmgK2yCvDBSOpET/TUys7yIEniWxfaUlFWOkqPSP4?=
 =?us-ascii?Q?6zVpcjXusCXuQ7bp6B9ZfJbzL6vo75DZJLWXvG+jfcRTjorhefSIDsCPKEFU?=
 =?us-ascii?Q?BdHt5bvsTX0wnmdzNN8dsIFY2PqBTL06Y97Q//D2DU55lJAYGE6nG4k4tgXy?=
 =?us-ascii?Q?kRgxrnbPbG6huWJXBqY8+uGp3ll8fOZIPauCx3gCGgWOLSBWNFDt1aVa1M8T?=
 =?us-ascii?Q?oZUZ3+juzL+Sp4CQXqx2JH6z5AJpIPeaM3nd1hOtxwITT0lczMdkaeNlMal+?=
 =?us-ascii?Q?BTqa/NmMh6XO72XvemcSm7yAbsKursRU+plLR8iue6iCPK0oGXI/rm72I/0W?=
 =?us-ascii?Q?PMcW9g3o4JkYtFwkb/qWlm/EhBTXehXwrJ7EKfc27UPRKgmcsWdKzS3HDPkL?=
 =?us-ascii?Q?++/UudjXZxkoYBhbixQWQ18gfBpLR0Rd/sdIzDoO4IJCnf6iqLRactOBJruY?=
 =?us-ascii?Q?26KDAXIoGmlVNJjInEQz0bhEBq12kS9jufyqE4+WDotaW1YGmk3LFW5xLrw8?=
 =?us-ascii?Q?mWDu+PajSYiBaCC5XXH6lSD3l6RTON9L1N0hZeBfKbkBKVYnCIgu3xMyeUal?=
 =?us-ascii?Q?3YUt3Za091XqkeAxNL5U32aEs/A0aPIiM5PRjqZyP+HihlkANr1o+pbRizE5?=
 =?us-ascii?Q?dPRIgTN8rW8wM5V8jHbFUdkGZGVJWvFx+LX00dDyHcZ0wvfPC/q+AksyYELr?=
 =?us-ascii?Q?rzftDOPpdkd5ZiqLHVMaxcVx3XrAjNc0LtyOtnVmrfxEIFiSzMiumLsfVzk1?=
 =?us-ascii?Q?AJyjYH13xi2T/BzSJyRnAfqo5bSsZDWLbHSkfozZVUHgWMWQZvFXeJttToWY?=
 =?us-ascii?Q?Orvy2B7xQeQ/HM/8EqZjmUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01461389-5de6-4068-f2cd-08d9bad683ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 05:41:14.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPVsc4lMbajwCQVXJeZYGiCpJQDQjQ5jvUsRc48JpsT/W7C0mbLdn0yy998zYMADYmOHV4uAtQwFIIM9KrV4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1315
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, December 2, 2021 9:55 PM
>=20
> Further, there is no reason why IMS should be reserved exclusively for
> VFIO!=20

This is correct. Just as what you agreed with Thomas, the only difference
between IMS and MSI is on where the messages are stored. Physically=20
it is unreasonable for the HW to check whether an interrupt is used for
a specific software usage (e.g. virtualization) since it doesn't have such
knowledge. At most an entry is associated to PASID, but again the PASID
can be used anywhere.

The wording in current IDXD spec is not clear on this part. We'll talk to=20
the spec owner to have it fixed.

Thanks
Kevin
