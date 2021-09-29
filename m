Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6B41BEAE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbhI2F04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 01:26:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:54542 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243585AbhI2F0z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 01:26:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224934025"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="224934025"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 22:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="438325690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2021 22:25:14 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 22:25:13 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 22:25:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 22:25:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 22:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrkJE3TEI4oV48W94ecEH84YRYEth6FC33uqD3L5bhS9jgClqsLrIalsX7MeVs1QGWueESXTCxR3Jxkn3Ba1F/2DA5t0cZvtibLnYwkn/bBargMj0leGc4QHuuFi087qf38pfaHkp5l/NTtkLBbrJNJ55s6IgT9RlAyy/0CsUU+GgbV7Xj4IUfI7gQPyG82827pxwfwNsw5nZA+MB1PU3qmkBEdpaitUb4mGu3KiHpCkf0BDNAh74NQXBVDjFfU1R6E89XbTXx3KnV9F7qDvdbNQGrJD5Lj5/aND9BvKOBfMZywE7poKSQgXxaOhDVNpCgDYWSoTGj4OaQ4tBlQBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uy843s4cq3msn3EOpMNlwcDiDWVaiuBHMUOMv9zwEg8=;
 b=Phk/gVuummvXMpYkPQexGC+lbLMf/PetbqnAHq30VJL9UtY3chM7F5iJQigi8y4EL4YCPiF269xyaIebRYYCSjWYOzjmUIggIMhlOw6ZG5zxOjoT9XZspzoqcMhevqPvQ8Gz+D92At/0/qhgxyuOgFpI0beP9KOSzNlJ2qqYp27vgUsvedNAyG5Au7JHQ87p61dklT2oliFzpUTsRGGdc96XUExh1Z5rZfED/tiQI7hTWTEuPPhPwoculvA/skd0MhXa1Q7QgQ/7csjjZlPHktXK1ejJQ1rWIptiMgkT6eE/0dX5K1t8I1NJkZRfZflsiNPxr3+LlnNSSr8lEw3VnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy843s4cq3msn3EOpMNlwcDiDWVaiuBHMUOMv9zwEg8=;
 b=R+iaPNKID8BoCRYFucimWtNOi1QPafxIyH9FlqGSzxTtCdCU9fVx+ByTiPiH+BdMsV0jVCrzPI78iE4/Oh8TBNKnjZEGk721gSzydwV8RRC+wTbrAib4RfPo96kb8j/ZGlDaY3nqaldfR1WUSThoJBeyXbRCtYRAiK6ZiS90P+4=
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 05:25:07 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::44d8:67f3:8883:dec7]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::44d8:67f3:8883:dec7%3]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 05:25:07 +0000
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
CC:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 pci 0/2] Update Mun Yew Tham as Pci Driver maintainer
Thread-Topic: [PATCH V2 pci 0/2] Update Mun Yew Tham as Pci Driver maintainer
Thread-Index: AQHXtPBooCt1dvGSWkWUT/YU8NRqmqu6eoZg
Date:   Wed, 29 Sep 2021 05:25:06 +0000
Message-ID: <CO1PR11MB4820E3A166F8C08A85125458F2A99@CO1PR11MB4820.namprd11.prod.outlook.com>
References: <20210929050955.25758-1-mun.yew.tham@intel.com>
In-Reply-To: <20210929050955.25758-1-mun.yew.tham@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f51eeb8-829e-475d-6059-08d983097fbf
x-ms-traffictypediagnostic: MW3PR11MB4681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4681117D0AC901B86B447C33F2A99@MW3PR11MB4681.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNiI9aYAyEusvOtdgYT3n2u1un6a1BZEAi/Cy0ZywkBcIDf/FAbV0Jx9wngsxRkgR6q/pvXATN+4Z/FO9SuEoSm9uMsjhf7bPoxhP1XLXbM7i4P02cNBLh3S8i3kuzIfe+fkot2zeRzbW1nLHbvEaTsr7wzka0eCq4P6RPg3f1To90sjYQkrIlzU/sX0OwfogA9KPLspKJUfq9DIOUPIrEKPm/RaHiJuiDj8jXXU3QCe7dqL/dbBthOWdRA7EnzrBwSTZPkwqf7dtgzsoLS/9JTCWmXjX5lzAXHPwQPVhHPuvCVjeKjUL21ArRa0T7dp6oIwqi1YRG1uo2hZ+8pwjpPcDQU23b2Y/aAYmmB/aeUktEtwJcpDERWKZV5hMFIRju5RSLOU8k/Z+lgfuQYktoJAkz/EhtLtCNOZ/J6YhPNaRbyoFmXqX51wEsOC4AzL7Hih2M3yz+041RIpNcZ0k4UBHHcnuRUx1dTOiDQ/0xQCo2cO+i8+T4wqcnUghdkIfiEkrsBnozOvz/Bi4pSwOGZK4KfY2XLuh2V53c2Vr753moxxLLZfVF4clVfJ4XldF8ct54NTWnq1rBoBrakbEgi7Zq4rux7YZewMPFDaN5K7uEAbxVO9RmMb0RVHGDYvRfz2Vp46ZQovwymg+3PiY0vclOSdsYiER7Ax4QtJ48iX2QZT6W58soPqzSpODQ0gUNAV1HcH4Jhsnn900X/cDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(52536014)(7696005)(53546011)(71200400001)(54906003)(6506007)(5660300002)(4744005)(186003)(26005)(15650500001)(76116006)(66574015)(508600001)(8936002)(83380400001)(66946007)(8676002)(316002)(66446008)(64756008)(66556008)(4326008)(55016002)(66476007)(9686003)(2906002)(38100700002)(122000001)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?maBv/LPP8fPrEHT08/cTaeimDbzYJE66fUBQD4rg3xkmQbDLGa8cGumpzb?=
 =?iso-8859-2?Q?7rVgx6k76/9M1lE5P+4LuQ/PgglA8fPNZ447yMwBKUSr+O1PMj6kGIUyQx?=
 =?iso-8859-2?Q?5hvvpz2rnDKbGMD/2FJOm1b+CBlcOVFImCzpnHibPM4hs3QnwrenpgAwC/?=
 =?iso-8859-2?Q?/i3QH6ZFDCkq7Za4yTeEoOCaFN70sZtWYQtqE17dBglU4fBi2hCdFsz5Ab?=
 =?iso-8859-2?Q?4+Qlr7X6tAFrvH6af6vWAnbE7kqP1fHOSDUlzUxgklh89eTIaq6xAELDHf?=
 =?iso-8859-2?Q?AmemSbTMCGCojK+MPCNFWfxJyrDEuf4+W7c4YD62+YdoawIQi+W54aHO3Y?=
 =?iso-8859-2?Q?nx1HzK7ubr4zuI+ntDVM5CqO1zCG4UN7NB6/RAGBlPDIzEpAy7EaTWNYev?=
 =?iso-8859-2?Q?R/WuI9MbE9mzf/I00t+9qEP7TXd7ePOys8fFuh9RzkwWYeVeXELZR2xM5I?=
 =?iso-8859-2?Q?COQpH5p9oGWSWFSbbxjSQQbwqMy0nKFsL0t/pSclE3C4JBZk4G+IhTkcYw?=
 =?iso-8859-2?Q?D94ql4E8ccZPFdIW9QWYiUEVkMKBSW8xvNpb55g3ovO3fAlymdaoankTDc?=
 =?iso-8859-2?Q?/amuw7cDUqgTKB/OHVdRmydnLA5uArKdc7LwXowOmVoyT8w9CygCdZpT83?=
 =?iso-8859-2?Q?o5KT+DM32Q1jFQq/SZ1BW1S+rdrR2Hi3UKZd1g4cR84IchlkG1fn4NaUW1?=
 =?iso-8859-2?Q?falGyy2mRWke+yqnax0n0pZ1oGZqvUTpofy/5i6ngESg9UZMKA3aJqPihm?=
 =?iso-8859-2?Q?6+P8wBNBvmnlzBZQ4Wl6WV8EPjS99pMmgL7YQGnyVBEtP1xlK6YEaWUVHf?=
 =?iso-8859-2?Q?axDbxG9x3EzgzcGVAvht+omkYOxxedf+3Y01nuTeLOCIe0Tp7HfGZ/6VnG?=
 =?iso-8859-2?Q?xUxVOSrqOu5crujOetx+KoXds6fwB2UHKfID2OaUFsHNnKK8/IDnDvMFnX?=
 =?iso-8859-2?Q?zd6nv1ENQ0HJSGlLvHen+BJ7WY3xexnCTDmXSrCJa7T8IrTN/Ns8Ws/oNY?=
 =?iso-8859-2?Q?xRkAcgK3aaQvyaqKKBqYLoRIk9gWWrEoFsHd36b+xoQ4rHiiVcGKbsi7ir?=
 =?iso-8859-2?Q?/6UnOtpiJ6RGHDDR42FaXYyEMlixLfg7GpJj2lhiSDeOMDgVgKKRRhNMmn?=
 =?iso-8859-2?Q?iWdAz2OTYeONMcw40Uu8w2G7ZqytDJGV0+OMm2zPG6suNgPZe8XHpr/NH7?=
 =?iso-8859-2?Q?+KzVUDol2dkkEzXpclI/FT03VHptlNBwLFEOgP1Gnt7buKxywtWygf+hYy?=
 =?iso-8859-2?Q?ilIXOujnRjVrQ3Y/wSXV/M2dq8iC3nSr9Yfp0HKdmON7VbOtYAYYo6i4GD?=
 =?iso-8859-2?Q?Rgwj9rXdWk503X/vhw7Z3fz6ATWL5A7XB+9lJShK64k6Jaxg53cKX8m5k8?=
 =?iso-8859-2?Q?9h3hk3T0ki?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f51eeb8-829e-475d-6059-08d983097fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 05:25:07.0131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCly5qI+xtVFoJbVToEZxqL/Y93W89NctJkuETBaflmmoMq2X6vuEJCQmbNStRmBYqVGYbY7ET9MDLlbMU0Ahg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Tham, Mun Yew <mun.yew.tham@intel.com>
> Sent: Wednesday, September 29, 2021 1:10 PM
> To: Ooi, Joyce <joyce.ooi@intel.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>; Rob
> Herring <robh@kernel.org>
> Cc: Krzysztof Wilczy=F1ski <kw@linux.com>; linux-pci@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; Tham, Mun Yew <mun.yew.tham@intel.com>
> Subject: [PATCH V2 pci 0/2] Update Mun Yew Tham as Pci Driver maintainer
>=20
> This is to update both Pci Driver For Altera Pcie Ip and Pci Msi Driver F=
or
> Altera Msi Ip maintainer.
>=20
> Mun Yew Tham (2):
>   Update Mun Yew Tham as Pci Driver For Altera Pcie Ip maintainer
>   Update Mun Yew Tham as Pci Msi Driver For Altera Msi Ip maintainer
>=20
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Joyce Ooi <joyce.ooi@intel.com>
>=20
> --
> 2.26.2

