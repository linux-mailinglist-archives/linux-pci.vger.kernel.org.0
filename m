Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5F93E9B4D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 01:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhHKXoQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 19:44:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:48224 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232803AbhHKXoP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 19:44:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="214975348"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="asc'?scan'208";a="214975348"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 16:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="asc'?scan'208";a="517031148"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2021 16:43:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 11 Aug 2021 16:43:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 11 Aug 2021 16:43:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 11 Aug 2021 16:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdEez2PTNz1VM6kIXXYHHUHOMrm9lFSNCbx9JFsbi/A9fJHtiwakkKZ9GQV8gHzjXDXXF/JDhBvCBM4O6zz1nCLiddRBji3i/3gjIXwEOPG1iQqBbadhde5xvwUh2g2YsJiu8gw/XufkFXxEiTSORnp6q1gi6ykQMi3znh07JHGvgqLjXWNRxbVfmSQbJutFGnyqtCyI1p25pCX6SifM7lSYQumEjecP9yJI/7FZo0T+I8ga9OdSp2F5CnZqS+vTV24zlM5QrKNrUc1uCNQzPkUK5utJhDP44XVZdXdlKSpe3Gb4P5m6BVHQx0FsF/6pSIy7Qp4hrxVdPWZCIv2Lgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWVM9/Nnto0hkqGA0qrjicGDf7Vcr2oBw9BjwROsVQY=;
 b=JugWvBXB+tO6C9doZL69a9urAqqydycva3U0HuQZrdxIgvkBD38QEezXXY/+ZX65KLuiczXhuDzucxmoSZYg7jXEnDJYXe6OJ48M95B2Z7y8NhfYeVLKfEZ1UAbA/8o1t8pacaIDoiK4ZI9nGVCaA+HiXNQz4ReZ9f0PIXtuMTWzSQZCPIgi4tgtiiNxMMP+fm0MW9GV05XcVbvrPdsRqTBxherzjx9HRYRVwLxKE6Hm8f3L8v7PKhVVShRcvTjf+r3kwS6PQFwQuo0f1bOGPFt9Sg6dzeuP+KKKGBVIjX1s9AXAqBCypq5eUAznI+Zbza/lo9g9urlreu7gnvHpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWVM9/Nnto0hkqGA0qrjicGDf7Vcr2oBw9BjwROsVQY=;
 b=g55MFFWGwa6IvzWgItlgnX5HShGOlB9Jfcm7aoq4H3RwGNfqm6cWVKsZIiS/3huy/6EkUJxmDyQNcf/BxPcC4LBmpdylGGWrMxSzuG2bDVmlLlKlhfrG2xUXvVADuek34jZrqUNVGBwl1gwwGORtChPmq59A9cyYV6nQljRwsys=
Received: from BN9PR11MB5484.namprd11.prod.outlook.com (2603:10b6:408:105::16)
 by BN6PR1101MB2274.namprd11.prod.outlook.com (2603:10b6:405:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 23:43:43 +0000
Received: from BN9PR11MB5484.namprd11.prod.outlook.com
 ([fe80::85f6:762f:41ca:ed6a]) by BN9PR11MB5484.namprd11.prod.outlook.com
 ([fe80::85f6:762f:41ca:ed6a%3]) with mapi id 15.20.4415.014; Wed, 11 Aug 2021
 23:43:43 +0000
From:   "Rustad, Mark D" <mark.d.rustad@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/6] PCI/VPD: Remove struct pci_vpd_ops
Thread-Topic: [PATCH 2/6] PCI/VPD: Remove struct pci_vpd_ops
Thread-Index: AQHXjvxk7HyVSy2iwU2Gv1Xy7ApKuatu93YA
Date:   Wed, 11 Aug 2021 23:43:43 +0000
Message-ID: <81BDA19D-B2AC-433A-B16F-4EB88A070B5B@intel.com>
References: <20210811220047.GA2407168@bjorn-Precision-5520>
In-Reply-To: <20210811220047.GA2407168@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6b9433a-43c9-46c2-90e2-08d95d21dab3
x-ms-traffictypediagnostic: BN6PR1101MB2274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2274CC9AB281C09E0D1C2B53BBF89@BN6PR1101MB2274.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qbSvr6NER3WkqQemDcIs+SzzTxcN1ftyocM/OcJVPLdyzB3Hizwv3d7DEGZ8R3jAP1uKxMS3ijPc9dWBbv2NXHkGGuUiReQtirYs4ej8x7/dd0LY9HPaFE8GWzeejaD/xKojW+5PZQf6qXgZzV+ttwpTivgcWh8oiRjcNQM2ElyXtXlHeXJ4hoCMyQBofeuyih47FZLbp6deFFZqb7H2Z+8NO0eGoc4K6cx/r/+Su7ap30apa3GrcEPaCux58DGrn/aKTBc9D45QhirISkuNSTFiR0vIN+c10xYEwHAfZYXBG4r1MtD2y4U0/K4w8Gj0jbFRm2Zh1WdXX9PUkqbLLA2bJ8mbtiybN3JpNUOYJyIBl6q3MWl0psvqoibH1BoDTDJNN0BqhmxZ3kH3+6K+40oIZioNo2gcqaVCJv64TZ1qD3zDyM5VHCBMCJP5oXT/EthhGET/1pmazDBd4Ig/+QUdnVRgWD1iIB9KE7kd6fagOktElYIaC3vZTE4Gx9idUPRVulO3SPpDPqXTXVigo4M4V1U1pANDBaZY7neEHr4vLbSzEdOjGxJdnMZiQwT9ZreOu3jb2WjviHWeBGm3smtjrLLUdkAzJQl4ta+QMDrLGCG2E9WzYRIEcwZ2AFORq8jqzc+qN02P5SMZtt1h89EDQeeCl47YDILxJOmL4q+YxLy1n5ZKDFhiMMXMx9YtgwELQbx/hQZi+nB/9NBWuP6S03ScWYGVbtzGe/48TGJQds/lfa9OvrxSEIrUsd20
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6916009)(186003)(6486002)(66556008)(508600001)(99936003)(66946007)(83380400001)(66616009)(66476007)(86362001)(64756008)(6506007)(4326008)(91956017)(76116006)(316002)(66446008)(4744005)(2906002)(54906003)(2616005)(38070700005)(33656002)(122000001)(38100700002)(8936002)(71200400001)(26005)(8676002)(5660300002)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7tp/cFjgU5v442FxKO2oZYM1MsGFyuHp9ZSJGol0k1wyuM+nTptL1eVeS5IE?=
 =?us-ascii?Q?k/zeg1+CuETPX0UyoK/Ls/SG2jo3ADbhDM2ct0IqXviBOU3dZrHJujNivMFb?=
 =?us-ascii?Q?XrVsiVw6n2qQBSOSiS4B3225nv+krhcCZZs2kg9powSwSeTsr7umhFBLPHDW?=
 =?us-ascii?Q?RSBg6LHTf8aPIno+KURH7t02QPYwC32uQjytp6KTsfvtc5KycvA/3SMWr8DS?=
 =?us-ascii?Q?+lGP1baq3Au5LQT5BsgqplP1VU6/tkDswQTfWoxUw9yNGffnsP2iGD9i1jzy?=
 =?us-ascii?Q?MyXQEly07x3sFW4uPa3iCxAd1EWkjwKc1iMMPAm7qQprYB9pzliHaNYeu30C?=
 =?us-ascii?Q?v1Nxgl4CvXK92tqmcdz1grX2PqrdPmYZRSJ1qkMCbYSQxGgp0+f/MagORb7/?=
 =?us-ascii?Q?UCBQtJLIEhCnITA3A922JjqAYSNG9srfcsU3J74Z//5o0TEqk2HXCDEqkmEy?=
 =?us-ascii?Q?t7AygZDhfg/CQpIy8RqzfinkDqe/tE9N5fXFcUF2dWwDjQem6r3X4WPStCLs?=
 =?us-ascii?Q?B7tuVgkvxbxoEnoeNYnUuRQYzL6w1yNlV3Yg990AUr9I3G7umDESrK3EANpW?=
 =?us-ascii?Q?WbRy6TqVbZ/GV2asa39BdIE0+SzymNdNvqN6gRU29fNk12ovvTrQhu2EGZqg?=
 =?us-ascii?Q?uKQTHpyAIO8d4sbIO5UP4iolcwmF3MPqwGZbvN8Ws1xTtOPIKEPhdrCNmqBp?=
 =?us-ascii?Q?QNZj1OQJbLlfWgT2ru/Kgklnm+Ff6RdqetZSZ6OggNqrcwzGDUBDdgHW7BJU?=
 =?us-ascii?Q?E+l1w67n8hsiMnKy5XeL5+CkR6ChfmgQodURcJUHBip9+OIJacAmfURKeOGS?=
 =?us-ascii?Q?egD6M8i31CkLFvYGDwhtEbdFEGuO2vQhTr+aTCW/MZzo/9EVesz9MsyqZTrx?=
 =?us-ascii?Q?pAAh53lZKFViQJhRwN60gHpUwtUYf7LAAV/OAJrq03LxumEmb4g3Q9pYfY21?=
 =?us-ascii?Q?ZSVlUcONDCD4jW8xVOsvk3fx9PJEijRdE1L/wzf8zt9Kt5m50D+qEJUd4BoE?=
 =?us-ascii?Q?l9BNW3oq011ZK3RaOlAw4Yg0r1dBP5r0ib8kOwWydl4Z/4BMSxLhCy8a/IEw?=
 =?us-ascii?Q?ACoJdYTpXxwWh6cSPsg/wU3cfyvFsDKXFBgJWqlKSjTVZfLeZzV1djNzG0Gp?=
 =?us-ascii?Q?XKbcddCTAghgBdI8W65bRGmE2Se1PJfgB1r+/xKuvTz1vNCbzmAhkjdr3cuW?=
 =?us-ascii?Q?tzhUnQXJuhniSklGtZFxxbFMaCw2sp6Q670nSZBqxwuZLVV+Twpc4c1lBlFN?=
 =?us-ascii?Q?3mQkicrIEnOskyI1Rkr6u0WMD5lT9pXZUt5AOIlQ9iPp/kaShp/oWKGav62R?=
 =?us-ascii?Q?wEzTlqTFOA2NWjgbv8eZVjTf?=
Content-Type: multipart/signed;
        boundary="Apple-Mail=_79FF697A-D482-41C3-89E4-DDF893ADA257";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b9433a-43c9-46c2-90e2-08d95d21dab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 23:43:43.3055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwoSRH/k15vIYruAHFyHosvouKBJFSq2AM1G/y9kOYcaTxGyQPV8O5dlkLaK5h2XTD5dXd8sFI5KGhzabD/JfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2274
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Apple-Mail=_79FF697A-D482-41C3-89E4-DDF893ADA257
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

at 3:00 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> So I wonder if we should just disallow VPD access for these NICs
> except on function 0.  There was a little bit of discussion in that
> direction at [2].

If this is done, you'll have to be sure that any non-0 functions assigned  
to guests (which will appear as function 0 to the guest!) does not appear  
to have VPD and block access to those resources. That seems kind of messy,  
but should work. One hopes that no guest drivers are hard-wired to assume  
VPD presence based on the device type.

--
Mark Rustad (he/him), Ethernet Products Group, Intel Corporation

--Apple-Mail=_79FF697A-D482-41C3-89E4-DDF893ADA257
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAmEUYK4ACgkQPA7/547j
7m6WVRAAuR/rIt6iYiTZcBb9KgT85biyTGWlzO5DQhjtY9lQ5j2/RXBV1gDb3bv3
B2vO46Gi46gpwckwQsJ7HjMzHBlzUBRcnsIchsF/1MvXuW4atoJCReMcs3ujh6S4
4bhcBzC5bexxcB5Bhunc99wUhbR5AyFeOOpRoW01IwtP7ZDBPO8cPkZW2PoQtWX8
4wJaOw8pDHrSv9joEnsG9A0GUI5fNOfYH715zgeYnzLtJmUTGmxu+UjF7yzR/f/E
0cn5Z9uWy0l7XnvQd+LD53j/iqjqtDCeCq+GqzlCifhGu6H7IO+DrjUgj9JvcgL2
AMbiakR79GkfXq/OZU9l/bALOoXbvtcaxRiClQ1jl+3XcSOF1t0CPVRl4E6Ia9+K
g3f8xPpZrt4ofl4FyUZw1eIl/9pb6Txa8d2H9RUlM1xZdoO1MkyJRXF9jibJznYm
0Mj7h5VqMrfl3Hv1sI+WuyvVFDxptKNsiIToHznJD8eEF2Fw6r8aJ89lqcTe4rhI
F4lHgDtMin8DRcWH548kQjntzb7nVng7VHQEO56GEU7LYTEZOSPR/T0N65KwihT+
/PMEynZZuosiuJnBO79+tCJYW8qIXV1722iB0zVdENVu2VQxr5E883XsZT98Jmpg
geDmc4FwRL1UeEAlPDyVY2r+zAklEC1X9sEPnbHeJnupiDi5iQk=
=JWA6
-----END PGP SIGNATURE-----

--Apple-Mail=_79FF697A-D482-41C3-89E4-DDF893ADA257--
