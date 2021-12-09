Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9673E46E83F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 13:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhLIMVO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 07:21:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:20868 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhLIMVN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 07:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639052260; x=1670588260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HsE8SkPo0+HFGrFPaM1g+ERkQ60Tcv2vQwXLaEEqvPY=;
  b=Cwe20bJck7v/VzBJBRSsosktPnetzra31xV+giz11N8VnYVW+nGwOv63
   WYof6bq0KF4wko5KaAOkFvvP45LJaNrNSqqq8ogdrUngTIsu5HGI48Jbt
   DMzC9t/BluiZ4HaudjqTPSO4TedhJyelCDmvIr9dbtlbAKziyhSVNKgTP
   QNVUmKyuql6nHOrFYGP6XS+6zEyyCwwxBnpAKW1pbyxEsv3yGrgxcYNa+
   hoQEIDUS28ghZPqkoX/v8tx4uMpf7NKGSke9GULgwkYliZe3AZdjbzoIh
   H/SRP2jYGXOvMAOwPxPmtHNRLV87xgeiejI37+EEnEQjZwZwwMrmWk9Dy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="298875992"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="298875992"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 04:17:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="750330042"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2021 04:17:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 04:17:38 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 04:17:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 9 Dec 2021 04:17:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 9 Dec 2021 04:17:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUpDf2DWnWK+lQDqpQc6WLdGoXByIXp8LvBjJl/P6Te1C5lf3BTrWmbobO0SvWCruWj0y5E8EbaFUklqLQtTreNStiX1JKQsR3p+la8GuqTNh9re7jAkxve69DTvvrYl7tzzyQlaplz2qQi/w1dY/tJeNdsnXhvVL3M92B9jbFcjmneap4aUHqgredeYX4qSUDwn6DvwCM3aWMrNjuxilRdKHRX2kF0TFZMz0I7BLolYiFADuAFoPCvVLqT5STabifxL940ywvoMwnztU1KG5+Y4+pNAlwC2nBkYgo+ykArJ+or0id9/dQbzGm9Olh8m/TR2SxVyQUP/eaCbyACCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyW8+CHNozl8bUuWKqJN1CoS4SXDfvG8T9l5c2dRIcA=;
 b=Yoht+nFQQ5ACjd3eGOWVzl+BFTxav08oFfr6jVTR+SEYxw97tQWHg8XsxGWTCQ08o1ZwLdUA6EqC3X3jdydJUjPRYaVJ0q7Xzdeg78OsCXgCQ3zaFP79FY2qCqm2N10afUV9NvrvVdqmtOpJ/8QNrZkjbgErK+zmu4WA7Gi9r9VmY43q850dm+tpz+pXzTBxQPJpagHbdnz/MImpEu2Iup0FM+76qj1/n0biYWD2xMBXtJkb6lW8SwBjtW00JMA7NMNdCWvQyf0OOzoNVHktgrVvjcafOavLlJ0P35vWkAngazpAw7oZLxjafgbbI/NEJsJfzP5sn1etn+3VTmAkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyW8+CHNozl8bUuWKqJN1CoS4SXDfvG8T9l5c2dRIcA=;
 b=noJqXXaMyaHsBws6E1PoCogI36Fqf/KNzdA693nkmoH1Vc7HLvS4G8BWqmPzDWjXpyzylXvLsl1C+8g+BiqBRqu36q71n8jA/oRAzRi1mirImGQoDI8i9Wuoley9bf7JQFicmNzeShFUsnkA+W0stexu0qoJLmdchhCMoOe19CQ=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3714.namprd11.prod.outlook.com (2603:10b6:408:90::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 12:17:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Thu, 9 Dec 2021
 12:17:36 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
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
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgAAttoCAAEzjgIAACsMAgAAjl4CAAD2IAIAA6NQAgABcawCAAAmigIAAKimAgAAjYoCAAPMeAIAAGgMAgAis5HCAAEEdAIAANO7A
Date:   Thu, 9 Dec 2021 12:17:36 +0000
Message-ID: <BN9PR11MB5276BDE2AC58ADA7A66CAFBA8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87pmq6ywu3.ffs@tglx>
In-Reply-To: <87pmq6ywu3.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f722c3d-9a20-4273-6a50-08d9bb0de2de
x-ms-traffictypediagnostic: BN8PR11MB3714:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3714318D8D08F4A264F56EBA8C709@BN8PR11MB3714.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQ6LkiGBnQ9KVM86byNWccsHy12nF1ihKuqA2848aS1v8N0xvJmLa6EUstfrVntpPwLoU3wh1s8KKLFMW/QxdPFkoFnszUNx0L5JPeVpJnZkmQs+GSkAYdG4n7T4tt+qhKu58GoZKjNW8HjALwBuNnS5WZ4aP3bZFAWyXBf+/ET0jus80niM0bWSqgYDSG01ghpvuuqWV6WbxcgI/7DhmSukjQu4YEHBQox7VNzEMLpNHn/0jAhdJr1axs39c1l5OjUq0F5+8VpxV5bvdnWDz8LmJ1BKpqeiRw3bVXoUFLqzFb33nQ8GJKCc9xJQ/7UUvB17nfqDlY3LQuYuN7IDpsqViaXyBOGJ9c5Tplh+zpgTUkEpcxPRBa4K04JTpl6+yZSzBbDgwbphx9gzkty3AOAoHKs3DXqKK204aVrxcDqcJ1JXXXffloXn/cSAORdrHXXcPObhRwOyXQQiX+Rfp5dtX/TBvMxYsY4lxOY7G7LIxRddE3LHDoSDl7lGm4H0RXThBu/QM6cfCZV/13wyIjAQoiH6hB8iqe7JA93wml73aMtce7IV2mIjbqJcrFVEp/K5UnvilgRtq84HBeFG1Nfuin9AfSVlgG5PHPn4xlgi4Ki0Pb/0sIOZ9AvtDEbNtLxpInT1IlWY5P5rNEg1BfMq3xY7oHfsrOS0RF8kKT72cVj02Z0hx4EfUIt/Ik6KxHWDvT1LqM2Q3I3bzvh41w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(66556008)(8676002)(6506007)(508600001)(33656002)(66476007)(38070700005)(66946007)(66446008)(9686003)(76116006)(26005)(55016003)(64756008)(110136005)(4326008)(2906002)(186003)(8936002)(82960400001)(86362001)(52536014)(54906003)(71200400001)(38100700002)(5660300002)(7696005)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uLF1CwV6V8M5HScw9bmsKMT1lg1nITA2RB0ia5+ikTAo1etS6FbmWaG5l6k8?=
 =?us-ascii?Q?77OXelpxNVi08nHDCT45RPsCxJ+1uD5fBHWVOWVMVkP1DyU/HwCwtg8V6Txg?=
 =?us-ascii?Q?kAZrcDQajTzOr4frDrk0uhmowFrLPHhSTYgl5Oct4oO3dUO9yn6BRL/OaOJ1?=
 =?us-ascii?Q?VysYLPqqanQyQYJo+05wim+yNqzLw8muq/FXwvS3pQy3POSVODdEWfoUWNtC?=
 =?us-ascii?Q?C685opss8fUzgU7PPHT21H7Qxn/G+1ly1Dy+HxLKR1sg+ZOm01aRcLLa6nMM?=
 =?us-ascii?Q?YYjfTqpzXSgFM2BXw15RbB6Xw3O8Uzu+FC1WTMU0ofbBSLWfBSp1PZgrZoQa?=
 =?us-ascii?Q?fPj2HCtji9/VfA0IucMawpZ9j8rE/pIPf1P9SBJ1lhKNkiJcfXKII3P06c1E?=
 =?us-ascii?Q?p2gF9e19823HvZA2IdqW/3QMj4n/iTs2IWyB3irjvYKxKY6Zk+OZ0Dtbzd8q?=
 =?us-ascii?Q?ZgHH7JVBG4XE1xN7vsD1+uqpt650A5ob/Lb4/aeyLjP+Dxhl4DGuNFoGsueB?=
 =?us-ascii?Q?S76+3hDWu4nQ+yfqB8Midx7yW4zDExK1vFlEOe7XYzyKUJCYB3/eFB9gajWZ?=
 =?us-ascii?Q?9QkeL48UThJPvVUxwdMPh3vYPoOkMqXhRQ8PhgfNkki23FMgo0F5UTinADbq?=
 =?us-ascii?Q?48BlUccA9jr8Hhap+3GAu6/V23YBMwQupKYcHiY8tLOz7np7qMM4Fyzv20lM?=
 =?us-ascii?Q?X4xJJgANBvUFeHlewFH8l0Sa3uc8LqLwt1t4YTty/h4LZWKN4D8Ohn5MI6Ur?=
 =?us-ascii?Q?NjUTdNwmVlwp7W5SdsT3pqGTxQ2+EyTuGxVr1OnL8qSV8pW+t8T4QNHng4Ta?=
 =?us-ascii?Q?bfjmEMaD0RXo4V20j088aQYS+T+yAQol9BeO2rUCMaTq4U45Yrw704B3BWQY?=
 =?us-ascii?Q?Ywc00vVQIT1Qqr2YNWn1QCtjl+Jk6IPEcHpQee4y8/2z2S/nDbGjD2VK/GsV?=
 =?us-ascii?Q?fz5m8NQOvNe6FK5X1PwGo1TIwztIt7ia5ePBJsvE1KFMd6t5WkW208exjR9K?=
 =?us-ascii?Q?Mf1R7fAiBt++9I+LVKLDwuwEFpjB5kyZTYwJ/YNx9kWOnuNofuBIi7tH4aLN?=
 =?us-ascii?Q?SaVVoEiFGE5HkMgtnZ/snIRlEam/yDoVMwfVTkzudCakX5EXzjny2mhwkwvs?=
 =?us-ascii?Q?uFFy8QTMe4dc7qSJOz+kQQeeXHv8qGX6S88SaYqiFq+SOkkkh38plbvkguCX?=
 =?us-ascii?Q?B3IWnlD/UClpyiine/bgL1ljqkxOAIABN9kAxxUu9tmZs9hlZbx4ZYrNtQ/c?=
 =?us-ascii?Q?SQzKzdf3hJgOSKWsf2SiR/rplYodc6qKgOHLMxdNvugxhDNaQDZGn4MX1I28?=
 =?us-ascii?Q?xm6NKGEm7Ny+3qcCQmV7+602UV/Z+3Yg5gD3WODhbMbXbwPHsfLmi3k+WRxd?=
 =?us-ascii?Q?PVBng1wIeRjvdoG2I3vV3FF8bG6Yvh744Y51IL2YoIZCVgoeQlxXByl6r7li?=
 =?us-ascii?Q?g55FccTqIqWBRT6eqTmtXQ2J4A0ptzR1NNKkJPNSafd6fDApUik+ZLL1swy+?=
 =?us-ascii?Q?Tt+1ncuO4JRzj6oJx6MGTnuu4oaUGighax2W71JXkGx3VlYfWz2rUD1EyKMc?=
 =?us-ascii?Q?wuHjLtrYxzM5MhMszUelDaCre+/jRUI+6nfuFs/OlwLDJuZCooz+BPWcv7W5?=
 =?us-ascii?Q?VoPUMB6pE1JvlW2CYVKozbE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f722c3d-9a20-4273-6a50-08d9bb0de2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 12:17:36.3627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Qsrb30MAVYx6VhBpnpcL+psk7W7Qo3E/JCMLq2xouGr+xlSZiwHKz6g6pZ2ftY+6mjsp/jkmPGNY+Y4+FKa4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3714
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, December 9, 2021 5:03 PM
>=20
> Kevin,
>=20
> On Thu, Dec 09 2021 at 06:26, Kevin Tian wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> I don't know of any use case for more than one interrupt on a queue,
> >> and if it did come up I'd probably approach it by making the queue
> >> handle above also specify the 'queue relative HW index'
> >
> > We have such use case with IDXD.
> >
> > Basically the IDXD queue allows software to put an interrupt handle
> > (the index of MSI-X or IMS entry) in the submitted descriptor. Upon
> > completion of the descriptor the hardware finds the specified entry
> > and then generate interrupt to notify software.
> >
> > Conceptually descriptors submitted to a same queue can use different
> > handles, implying one queue can be associated to multiple interrupts.
>=20
> I think you are looking at that from the internal implementation details
> of IDXD. But you can just model it in an IDXD implementation agnostic
> way:
>=20
>      ENQCMD(PASID, IMS-ENTRY,.....)

Not exactly IMS-ENTRY. MSI-ENTRY also works.

>=20
> implies an on demand allocation of a virtual queue, which is deallocated
> when the command completes. The PASID and IMS-ENTRY act as the 'queue'
> identifier.
>=20
> The implementation detail of IDXD that it executes these computations on
> an internal shared workqueue does not change that.
>=20
> Such a workqueue can only execute one enqueued command at a time,
> which
> means that during the execution of a particular command that IDXD
> internal workqueue represents the 'virtual queue' which is identified by
> the unique PASID/IMS-ENTRY pair.
>=20
> No?
>=20

While it's one way of looking at this model do we want to actually
create some objects to represent this 'virtual queue' concept? that
implies each ENQCMD must be moderated to create such short-lifespan
objects and I'm not sure the benefit of doing so.

If not then from driver p.o.v it's still one queue resource and driver=20
needs to manage its association with multiple interrupt entries and=20
PASIDs when it's connected to multiple clients.

Thanks
Kevin
