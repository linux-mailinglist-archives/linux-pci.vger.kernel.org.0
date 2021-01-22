Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE540300D6F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 21:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbhAVULy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 15:11:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:56020 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbhAVUJq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 15:09:46 -0500
IronPort-SDR: VKZMcN9OG7svXAC9OrmzR2yIlgqNsGfj126Bf2LrkX3Hlj3I6nU04tfiNfteDz3g4vhjsH4kRp
 xdXU6zuPxzBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="166600809"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="166600809"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 12:08:55 -0800
IronPort-SDR: WpdbPtEcOckpDq5P8Bb/GnL/s+gMOJSY3YQKAKW0PJVvnpRI4WpTFiWE0ZrgBk3H4mRqfkD4Pu
 2TDMTTGyTCxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="357152222"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jan 2021 12:08:54 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 12:08:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Jan 2021 12:08:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Jan 2021 12:08:53 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 22 Jan 2021 12:08:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6bkpl1TxtfVML8fdiVVdDC/6/7+d6ffOXz4fr6XpyxG95/9/6xkU8QoBvQmOmtA6pSgiv1A9frobLzBUkfTR66W68tZ5mp8UXc5QAYHgdkfjJ3GitZTveHrcfLQbd+DuutALT0aK7ekjxbAjLiEPzWJx9cBe1UlIInaMmLsY/HFteEdyKBmMEcwBq4D9wuJBqRBMLcX8HC70KUMOhPLb6XjZQ1xPGoMICNknKbCmkwKNJHRsy3JUEUVrzi3xB84zMhr3HPzD5xXPuAUjQOQ3JiUYU7P+OTgBtYTKmEr13PYPa6R0dYv1DryYdZELhk42R+UOvJECOKnej2sRPpKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK7elhIbo3/6WSB/1IEytWz+5SriR1ompn/htUZCqSY=;
 b=JoSh89lPQY6vR/LIOjM/x8pUUbexuoNiYE21KCjKofVKKhNlEHxlr4nD0fh4HGqmHF5z7+cgMozGWlD4AE3wrsgt14DMBfqas0vaJ6PpVDp+OMf4wfCy8tYAIKBGTopsXM++Ts6uA9AQ7D2OaLi0r5JHqQsnMztlglb18JMR470umTPFfG0jmYdm9ye76mR/8J3n+bp2wANpS7UepuAsiwrcW4FjebbqfKyEIzB9Z2qllhoY44085MOlCTpOUGwTMqK/TcRb3jrAVYWaxJGvAaslXNYD6vNT0/sUeIbhApswr1AiPC47ArZ1oNGjMo9KL3yp136zC5tE5BErDbdWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK7elhIbo3/6WSB/1IEytWz+5SriR1ompn/htUZCqSY=;
 b=YqB879iK/M08w1ZK+mkWcDMUqN/+M7/SJrBBoM/WU21ym4YWkwXr7SNuoIRezYwzC7OD3CCQBAyV4qnIZZQ3ogAe/f9GsNiBgfrJVlNPrMp8f0B+NApqnupskUy4bchmCs+lpLfyC/1XdyVdXqOXd/wnS/1QrMh7zQaQla5Kh7Y=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by MW3PR11MB4700.namprd11.prod.outlook.com (2603:10b6:303:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 20:08:50 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::2835:4cc2:edf6:3c0d]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::2835:4cc2:edf6:3c0d%9]) with mapi id 15.20.3763.017; Fri, 22 Jan 2021
 20:08:50 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHW8CxEYqglrlTf6UWr0PjVJmm9saoyfXIAgAAN1ACAAXwv8A==
Date:   Fri, 22 Jan 2021 20:08:50 +0000
Message-ID: <MWHPR11MB1406A5779B2B45036ECB01C485A00@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210122032610.4958-3-srikanth.thokala@intel.com>
 <20210121195206.GA2678455@bjorn-Precision-5520>
 <YAnnALx/ZHJ+Euhq@smile.fi.intel.com>
In-Reply-To: <YAnnALx/ZHJ+Euhq@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.167.96.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7e16c59-3f8a-4780-80fe-08d8bf1188fc
x-ms-traffictypediagnostic: MW3PR11MB4700:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB47001FA41043683C8550A61E85A09@MW3PR11MB4700.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 49ark8L0atS0kSsbT6GQZeLscY2c1KszgXvQtQDLChKJNIPcFUiL1WRFxxAQpFhjDwg+O+B5U5gR1hympkEiqUSfdZHWe+mTUfnf+4f9ww7TZqvqqqjaStuC/uMSyZ2IhpU2Sua8GE8vae6A07k0WWkMlDAO93JwboPSUe9xCgq8Oy3jtaXS/poHvVBO3SHah8pxx8ehGn36XLDBczumZOXefCaOllNO5Ct7e2X0GMlHTwMVmFgcz3G2PcFpHi62I/nQzVAdpwUHgza7yNNZkQtlyuNaiwtGfixvFULBjLFaluVwKneLL8hUDwTnNpJdkfjDvZSHqQbg8esTSoNs1s1ZwrTmEnrj06+LBhyl/gieIfHLB0gTRV2UpRgYhN8s4qjB+qHPV3ExcxGaCqqxSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(55016002)(86362001)(83380400001)(8936002)(478600001)(9686003)(33656002)(54906003)(316002)(8676002)(7696005)(110136005)(66946007)(2906002)(66476007)(4326008)(52536014)(5660300002)(66556008)(64756008)(66446008)(6506007)(76116006)(53546011)(26005)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e1QUyEvfez8tJwzTyYzYcRvDExW4sNJHMGM1lZalf1PJygLqMpbFy8SGv6D3?=
 =?us-ascii?Q?cXULKWJeCFZZfHBR7fxxddoUHSMWxmPPQgSeQtTVXbaz/J/5XXzFtLwTPz9l?=
 =?us-ascii?Q?HD0czYxgOqlp29hCmORMKFZURnzv2Wa9aSTM5IQ6N6oKCu9vLbHSLTWg1QxM?=
 =?us-ascii?Q?NPCLd9c+7jtHcH0sPi3sBUlr2+aULZ099so8CWCTuie/Yy7vqZ7vmZy6Qukz?=
 =?us-ascii?Q?wMcUdrFl9QGUXouryriwgtFdq2tf8aQbuy+i9B6GqJvvF2J0WKiyQqW1LnFa?=
 =?us-ascii?Q?q1hkFLdsQeD9GePFDRgPu87GNji1KiAGoq2Rf8lcGXjV0cootFDqxqxIHmz1?=
 =?us-ascii?Q?jcncp/XXCwL608f4KtYzQp9rPVYbedOHuWtLnPigqe3k6tcMA9QlfK2tneNj?=
 =?us-ascii?Q?Urf1V26wWPiktOiEQDsxTG7SomNMSZB31OmID5umyD0oxl/9ACiHNYUMRZxX?=
 =?us-ascii?Q?SMpBMKL182OhQIR67s0ULOjYU5IbV8O2hT3rKX4RryaaClvreuGI843gYhjo?=
 =?us-ascii?Q?97GkgDbNVBSKt4AsR7zZfY4LzCZMGFgSVSTbCngHfu/NKUKrQ5hYkVaBcCze?=
 =?us-ascii?Q?22QBKPMbN6iRa/Jk40fwwbYz74U9B6XkVj9MmSfVVB9AL+WxgalkfMoQh12a?=
 =?us-ascii?Q?eHUHIa6Fld/vULXZjGEOD+PRnKE8y19asLHC+5D5HuRneO/Dj6HWCDqpNl9m?=
 =?us-ascii?Q?KlejQadMRz5zHtTl9M6rr3A+6emv4NAhU8ufoR2pP1SfLJSatwhcZtEKGhfb?=
 =?us-ascii?Q?nu/oX0yz58XwCSc6KrlZDVszDmTfxO+J4hMXm+X+0LUc+SYVLykYk+DLA0+3?=
 =?us-ascii?Q?UhfAMNHWBEhrmSCgvU5ZAtHlG+CXVGuKAgUGHs3HXJ9gA9QbV8FGfsG6/6A8?=
 =?us-ascii?Q?p2xENjVmeuCd0Ot/rE503W+1HxvLncybyIDQHxNboiOTNVMVz+hYvhvmB8FL?=
 =?us-ascii?Q?YSOfvp6Kumu+HOPrDaOamEbOh0jKTTflFuYiuo3Odxc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e16c59-3f8a-4780-80fe-08d8bf1188fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 20:08:50.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSeS9zhxQyrQTFVuCKzQAeVKwM4fDbthhSmvsyFn6cdwfYn4cGTPY8J8Ni79OlG4jgGkb7pSHnP3u+wJ08VRKlLNodPRgEdY7iBF3g/31fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4700
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

Thanks for the review.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, January 22, 2021 2:12 AM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Thokala, Srikanth <srikanth.thokala@intel.com>; bhelgaas@google.com;
> robh+dt@kernel.org; lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; mgross@linux.intel.com; Raja Subramanian,
> Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
> Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
>=20
> On Thu, Jan 21, 2021 at 01:52:06PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 22, 2021 at 08:56:10AM +0530, srikanth.thokala@intel.com
> wrote:
>=20
> > > Signed-off-by: Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> > > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
>=20
> This list seems strange. Shouldn't be your SoB last?

Sure, I will fix it.

>=20
> ...
>=20
> > <checks MAINTAINERS> ... yep, all previous entries are in alphabetical
> > order.  This new one just got dropped at the end.
> >
> > I feel like a broken record, but please, please, take a look at the
> > surrounding code/text/whatever, and MAKE YOUR NEW STUFF MATCH THE
> > EXISTING STYLE.  We want the whole thing to be reasonably consistent
> > so readers can make sense of it without being confused by the
> > idiosyncrasies of every contributor.
>=20
> I guess even checkpatch.pl should complain about this these days.

Sorry I missed, but there are not any checkpatch warnings.  I will fix it
in my next version of the patch.

Thanks!
Srikanth

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

