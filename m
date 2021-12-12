Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC974717C2
	for <lists+linux-pci@lfdr.de>; Sun, 12 Dec 2021 03:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhLLCOQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 21:14:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:2989 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhLLCOP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Dec 2021 21:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639275255; x=1670811255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9EodgeHwVptYX2sVoovroenfWCGfY+a2iKgrxNP7QqE=;
  b=KXBlz0FaiWe7/YemZ295TvqY3bKLAAx/hr2ASS+zlCZvSHlDecn7cVc9
   ZUwBjnZ9PlvACL8m9lTfRj5iWedVlbwn9OAH1Jl2RN6wKSHFkcxhEAVCU
   JYO+QM3tK/K3TULwrEALPQlrlr1JGR7JUchdh0hlRo/Dcn+86qErtwR/A
   mU6vj4IxePbjdOX8r3RLOpoDtJ8i6Z7BlPnocrGnJENBrnlNX7haMzQh4
   lhATk0ckwvkN413igCKM1gGrFK2JJJ6dEFNfgoHTWBP9w73MERUjt85wO
   Bt8c25978cQY3elIa2jkhrh0th9BBDQJO7kn6h0W1Nl5m2ePxRKLV7UjR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="236096355"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="236096355"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 18:14:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="608277127"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 11 Dec 2021 18:14:14 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 18:14:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 18:14:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 11 Dec 2021 18:14:13 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 11 Dec 2021 18:14:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbTkldGHBPwziFYogLu8VK2gQq3kJ2GtFKuyX3bVbxlRq/iHPUu3YBxeWSGCCSufLeuCW5YevT6uIfRj/K+NHj5/97ybGs7KfmYO86PBhTKNfJ9e//n2bK1dLNC8F26SG0lHuRnpbUGJNGSHSOWFf8l/uXUqNYvUcatYFoTcwRBi+a/K6t++H22nX5TyH/zWTim7nry7SyeTbUp18ixfPW3LMKgQXUgle53Vvn1QTlvN8+4EwxiorBsG6YkfD5MvB4G8R/h6fJgY5GODBsZBdg5RfA/0lfv2a4/yAfuWhzS1BjPLuh2C0AZrOg5S17+ZitXGQkWHMsPkm1eCn19L+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcuayxCT+qnHhWVKtvC89DppbmeNGmZEv1HP2kwepSU=;
 b=axRNQXfdN26Bm3xQ6XNiZz56FSYuN8Z8gDPF1GeCUQ2rAEvMiwUcDM89EChCTIxAuNA7IeZG3Y5y1MaVZTqe+jHpe8w6LpHrRi0Enf5m86WzL7W3YdR5yu8PJp5wKpiC7I1EugdGc4IIA0hhpRFGAvnoXupAGbboy4oktXKBy72Cv1lipfP+KtVJdHwvaw6vjGlNRITBxQwXqDIVEMqCUX/qyC8+wlFhaCRD0i90E+H7uqQRkCMQodjZtGwgVX2s0Zg6aGbQ37wRUVXzEewy/6vtldTjBXa+/Aiu3iBlPxiU3hiGYigaOgpz0O3GZon5RQzJml21hIhSBp4jBlUL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcuayxCT+qnHhWVKtvC89DppbmeNGmZEv1HP2kwepSU=;
 b=OnoJgTbw4s0W6KvtDAO3CC20ilBgxoDKd29lkVMQ+3ZPCgKfoIT1Fy3kpz/Tt2zGEa1WETc9V51516mja4S3kNjqrOnWJhwrhoy4R9wNsffRCl/c9DHf6H4PWpxEl4dxRO6Ep79O7SGDyYfJUErhbCjEXhZAdb07nXqWvPRJ0QQ=
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MN2PR11MB4016.namprd11.prod.outlook.com (2603:10b6:208:155::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Sun, 12 Dec
 2021 02:14:10 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::345d:b67:e8c5:d214]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::345d:b67:e8c5:d214%6]) with mapi id 15.20.4778.017; Sun, 12 Dec 2021
 02:14:10 +0000
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
        "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAE+oAgAAmHACAAFJ4oIAAem8AgAE/1RCAARP4gIAAHS7w
Date:   Sun, 12 Dec 2021 02:14:10 +0000
Message-ID: <BL1PR11MB5271BFC6B2218CF7E9151EE88C739@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
 <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87lf0qvfze.ffs@tglx>
In-Reply-To: <87lf0qvfze.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36ed7bef-3646-4702-9e5b-08d9bd151581
x-ms-traffictypediagnostic: MN2PR11MB4016:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4016EB9CD4A1B131B2C5CB948C739@MN2PR11MB4016.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: suOKQp+Fo7Io8LUCLX+JMNXwaor6fdVS7PnvpfSyk3IQXnF8Wzpqu0r1qSwozECdIW7rh6FlxMYDc82LAkNOt/WWMQxzECYc3gYN6Ss8h5X5rWn78fwsFOISNGsltDC3LlCuROWW72QxgKWqN+9+FIeYPR4yXk3O7/jYLhwU0AIRvgeUzicTTkgai1SzCKIMf5zfu2Vt5x8/qo4PYfldHgAUM3N3XH1ip1XsOJhjPbxRSU1Alphov1cr7FB3JzYjje7G9zmUWoUdC6SXtFqLzy5TiNPsiagpWyzum2fSeYNBpJHEHF9vSVFRn6dhArZsmhyLJQw+dQc+aS5yhlHNT54Ik9d4q7/d2C8seK8P068T06WqdlocN14X4e+A8UxwQXnysGOpvBxxcQvZnzmyPybddelUMXo8IJRMpY9XriDnJZx1Ol+KfparlvicusZcZxkPipfsOTUt7gHNdnHvaaBJ/ZW9Pd4JzGBX5bBAVlm/3yqBVRben7rlyW0OhX/wPy8AveG2jyQdicButc/6DdVJ5+e7pQTFuqDot+pm0wJOgrXaruZR2FL2xEVy0JnqSyiKc4sXi1khp9o/cqmQCzbXb5Te8mbQWJnt6wOSkqfD7A6kHpC1TyRJgcL451kXSltuaXp46WOkqVUi1TNGVPQ6LJi+mO9rQGpgfmg7kv3v2jepSflYMN2xlh4OnjWvLJXYbEoFG1EP+WV93TSlLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8676002)(54906003)(110136005)(9686003)(82960400001)(5660300002)(55016003)(7416002)(4326008)(52536014)(6506007)(316002)(7696005)(66946007)(38070700005)(66476007)(2906002)(122000001)(8936002)(86362001)(26005)(83380400001)(38100700002)(66446008)(71200400001)(186003)(33656002)(66556008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cv23W3v7Eu2Hl87hNWWiml7cNgydQKZoL/iuVXPBI0QowyCV2/e2wyBHL4QJ?=
 =?us-ascii?Q?x+IEcu9fn4vY12Y4+zgokgZN9n42S4uAKhQgsZCWVxydvSyhZwLGdbL3OV8j?=
 =?us-ascii?Q?u7BbFN349eWeO+WifAknxTHr8lK17vlNEEQCinEdy2MG0qf5a0A7jA2+Db4Y?=
 =?us-ascii?Q?Zjp07PZsqoRSo+7zsNwwzajsDdknzs/quMnJp9NyiIrROTjuiDyg9PKCggmF?=
 =?us-ascii?Q?1cm2n+vbo65If6e2VPtWZR7MUay1F79UEZb0hasjeI4FAgs8UKZkl8obZSV9?=
 =?us-ascii?Q?2R0lDqpXKCGqvVQhm+hn3DN72XoV0Fe2fEWgziEczi6Nm7ncujyWA1A/o2az?=
 =?us-ascii?Q?VjEUWwLIxLW0WEFA9EanpZX1f5TT3d+xkNkOJa60JYTb+liRkyhLB40CQmfs?=
 =?us-ascii?Q?1VyvpLHwoMDahKiEII4MSz+7lfM8aLeLK26Xkg1npm1WofKwpG2EicbhkqYp?=
 =?us-ascii?Q?dfb/8hUgLqGZHUr+c25nEFUj86s5ow5e5ywzlCh0dFh8gjoZeCqRik93tDuV?=
 =?us-ascii?Q?nFk5kdmf+A5Tkvkd+lHTLtIsfhrfpBS5T4NdSrhHEDP6cWzHYdQ/6X9KoG+U?=
 =?us-ascii?Q?uRKMAxDnD0EM5PWKudtVYH6H0YRmXXUu/ENiVQmEMVVYXyQH2qpyMJRxrCEr?=
 =?us-ascii?Q?HJo4+/YZd949iD1ipoGH2R5KSpDL41k1ZBxNTio2o/js/dGoAClBLLQDB2NL?=
 =?us-ascii?Q?+r3F4tyP2t57oMQMF/32QQ7bC5+Ik9NRTf+x2zoJ6BuFpo5BL7wfkZMEKi4d?=
 =?us-ascii?Q?VS9e/vcbCG24GMEuV5nJdI+yiJIE9aR2bCetwBBR44sbV/MFn3QulyEimXt2?=
 =?us-ascii?Q?khHTSZgN38dfivYcNYMgqkWuY5kt3QJsmxz+vhz6qLRy+qPvHoupVbX9QWWn?=
 =?us-ascii?Q?1R9J1pXOwKPfpDI0JVV9TaomreVqkLZ5/hJwnT4n6G6FwX9rmsQE+IXWVHZJ?=
 =?us-ascii?Q?swn/EUPIt/GCYH0qKr6m9pBuj77LsFTHox2mwkpxJZMTjrJAbR/aKNYNEYIL?=
 =?us-ascii?Q?C86SEERFU7ls5TAeueeIv8SiTD93MObf3GlWKxa0jxbKTfxapjNNSlfNSXkB?=
 =?us-ascii?Q?3QSAlYrcJjEjKiUuAQDORNSbKte1nOFE2sIrHDii0AFZPiK3XPYErN2a0gJK?=
 =?us-ascii?Q?xsK2vLfqGfJGRdftl4A8vhYgFXjWzYEJ6gpJ0Qtuehi+Vz+OYQZB+KuWEiMJ?=
 =?us-ascii?Q?E13DnQmD5EH7TpXsjC9BnlBBKLBT1c1QFJehWfEybXbKMOyX2u87miEQFiat?=
 =?us-ascii?Q?WDweu9vZNdcyv6g3fxcAmBlIaqOUbEiP1+2i+w/6taKFoa32a+XfSDLHkCPF?=
 =?us-ascii?Q?SGEMIEkHae6XSpjS/RV8C2QZY/QEEpj55iMypqPaswgpOK6KxlGJmbSsN1y4?=
 =?us-ascii?Q?9lodfdtEbSWGBfyOIZMPbwayswRXo7M1BocD7nzk5N9wE9dlfMCJd7XuRB8P?=
 =?us-ascii?Q?JmJPbBmQnaD1Nz7uzPJzif7nVIuy6+OlQ3i6jeB0JOve5pBCDCLOm7yM660k?=
 =?us-ascii?Q?aDjVy0HL0p+19OthRLjzI94PSyaGU8TbPnUXVB1XEGeeeRo3b0uzUMCaddjB?=
 =?us-ascii?Q?UUUSDnxLwVUPmOyL96tZ0+AJNTt05BaiPQ42AIYvLCaWFCjCRPfa3iqFiNHI?=
 =?us-ascii?Q?Lqp2LZN3LlPwYa1f6tMmk4E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ed7bef-3646-4702-9e5b-08d9bd151581
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2021 02:14:10.1166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvZ5GNjNY6Lh7Zu9nQOj7GDimjUi0rQZw/rP6PLzKUJPmQScM/IArpyhAxVxCHxccTwcvtQMnRqqNcPW8rsvHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4016
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Thomas,

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Sunday, December 12, 2021 8:12 AM
>=20
> Kevin,
>=20
> On Sat, Dec 11 2021 at 07:52, Kevin Tian wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> > Then Qemu needs to find out the GSI number for the vIRTE handle.
> >> > Again Qemu doesn't have such information since it doesn't know
> >> > which MSI[-X] entry points to this handle due to no trap.
> >>
> >> No this is already going wrong. qemu *cannot* know the MSI information
> >> because there is no MSI information for IMS.
> >
> > I haven't thought of IMS at this step. The IR approach applies to
> > all types of interrupt storages, thus I'm more interested in how it
> > affect the storages which are already virtualized today (MSI[-X]
> > in my thought practice).
>=20
> They are not any different. As I explained several times now IMS is
> nothing new at all. It existed since the invention of Message Signaled
> interrupts. Why?
>=20
> The principle behind Message Signaled Interrupts is:
>=20
>     Device writes DATA to ADDRESS which raises an interrupt in a CPU
>=20
> Message Signaled Interrupts obviously need some place to store the
> ADDRESS/DATA pair so that the device can use it for raising an
> interrupt, i.e. an
>=20
>    Interrupt Message Store, short IMS.
>=20
> PCI/MSI was the first implementation of this and the storage was defined
> to be at a specified and therefore uniform and device independent place.
>=20
> PCI/MSI-X followed the same approch. While it solved quite some of the
> shortcomings of PCI/MSI it still has a specificed and uniform and device
> independent place to store the message (ADDRESS/DATA pair)
>=20
> Now the PCI wizards figured out that PCI/MSI[-X] is not longer up to the
> task for various reasons and came up with the revolutionary new concept
> of IMS, aka Interrupt Message Store. where the device defines where the
> message is stored.
>=20
> IOW, this is coming back full circle to the original problem of where to
> store the message, i.e. the ADDRESS/DATA pair so that the device can
> raise an interrupt in a CPU, which requires - drum roll - an
>=20
>    Interrupt Message Store, short IMS.
>=20
> So you simply have to look at it from a pure MSI (not PCI/MSI) point
> of view:
>=20
>    MSI at the conceptual level requires storage for the ADDRESS/DATA
>    pair at some place so that the device or the compute unit embedded in
>    the device can write DATA to ADDRESS.
>=20
> That's it. Not more, not less.
>=20
> When you look at it from this perspective, then you'll realize that
>=20
>      PCI/MSI and PCI/MSI-X are just implementations of IMS
>=20
> Not more, not less. The fact that they have very strict rules about the
> storage space and the fact that they are mutually exclusive does not
> change that at all.
>=20
> That's where a lot of the confusion comes from. If you go back to all
> the IDXD/IMS discussions which happened over time then you'll figure out
> that _all_ of us where coming from the same wrong assumption:
>=20
>     IMS is new and it's just another exclusive variant of PCI/MSI and
>     PCi/MSI-X.
>=20
> It took _all_ of us quite some time to realize that we need to look at
> it from the other way around.
>=20
> There was surely some other conceptual confusion vs. subdevices, queues
> and whatever involved which contributed to that. Water under the bridge.
>=20
> Coming back to your initial question:
>=20
> > I haven't thought of IMS at this step. The IR approach applies to
> > all types of interrupt storages, thus I'm more interested in how it
> > affect the storages which are already virtualized today (MSI[-X]
> > in my thought practice).
>=20
> Stop focussing on implementation details. Focus on the general concept
> instead. See above.
>=20

I have no any problem on understanding above relational. This has
been acked multiple times in my previous replies.

I just continue the thought practice along that direction to see what
the host flow will be like (step by step). Looking at the current=20
implementation is just one necessary step in my thought practice to=20
help refine the picture. When I found something which may be=20
worth being aligned then I shared to avoid follow a wrong direction=20
too far.

If both of your think it simply adds noise to this discussion, I can
surely hold back and focus on 'concept' only.

Thanks
Kevin
