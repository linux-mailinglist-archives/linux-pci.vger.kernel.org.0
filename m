Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332E02CCD45
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 04:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgLCDXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 22:23:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:39830 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgLCDXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 22:23:48 -0500
IronPort-SDR: tzbSKmaj5ArnX6RYR/Yq4ybnA0NeL4DvAoLNerjT1UgIMI1Owuvw3r3Lyji55MgmLcdORc+8yD
 ECzSPGTaL5JA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152953845"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="152953845"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 19:23:07 -0800
IronPort-SDR: TkIkscBmeKXhP2ARQbP9YS1YmCUQMFfUAMMWje7w2+4z2/prozAygaIf3m1H2rEY9kk1lf/2sl
 ROzA9CWlsA2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="330689441"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2020 19:23:07 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 19:23:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 19:23:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 19:23:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDB/qn/6Z+zYPopTs1LoHjBgWfcum5QeT5vYEsN08dQnfqy4LK77iCSyUIjfyimnQqfagZRtTU9oUMfQTHDyyKGh0369Qx9xQQSl/6off+PirF64h/yZBHLZI8oEhTuvDe8o2ykj2fgSAP3QlX3mQTWsp69319c8ICuzX5qKtq+fWWIjPBtz8Myrm6CiL6bMlfhER1kvJDY5MstkrZAnomcIcTX1fdFb42vlcOl75lEjDfDvoLZ1I/ES7nyKQlxnde4FFTOscQwIUxdcKTfrEtrd45F4nfxNbMjIYaWq858L4KawucPspzIEbeMq7/6uFFwkQdIB3qYXE0nPvcvVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xY1kIx5pUUe1MEp+gYhiifqmSM/QU17vhGLZd8op7Y=;
 b=ayIbhiVDM8AqJQ+XZXqVALhLLv+3P/sxLm0NzR7vLKfZy1B0Dq9VQ8yJHqQPBvohGxYLCDbfOS+PKlfCb38IpANN/n+QhB09S/TSxhaC21NnfLncuJX419vYnv6OjMhwLhl+rm/IFg2J7bwWvFRRqxMMcn84gcDHy3JwdaLPArKIPYL9NUVGZTjPwHONqaGen92YqonKsitLC/G1cXsGIQcGLvN2fOJxYu7gcxoKIoQP2gX/SjmL0IZ7LflIF1/9dzTqG29Gr0P6L8KEvKVk/JFQshKdm4Fetna+nEtXrwvmTq46HfRX47c45uXCrhDnCQBfbtszAvvmDtinJJUreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xY1kIx5pUUe1MEp+gYhiifqmSM/QU17vhGLZd8op7Y=;
 b=Ixuxb5JUB+RQlLUxoc0s81VrPjA0XA/YwpjEGILw0tVvhX89l2XkMjWvN7FqvZEqvE0Hv+fVaH5o199pVpJMRzcHzsnGi9RKzd6eR2bftypPNSO2subuHxfyDVnssUQVTinaotcoBuxlMeoa5ra3NLB4oAhJ2BiR2gB0t8B1iS0=
Received: from SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 3 Dec
 2020 03:23:05 +0000
Received: from SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::a975:345b:8dcc:50ff]) by SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::a975:345b:8dcc:50ff%6]) with mapi id 15.20.3611.025; Thu, 3 Dec 2020
 03:23:05 +0000
From:   "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Jesse Barnes <jsbarnes@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Pandey, Hariom" <hariom.pandey@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Subject: RE: [PATCH] x86/gpu: add JSL stolen memory support
Thread-Topic: [PATCH] x86/gpu: add JSL stolen memory support
Thread-Index: AQHWstDzxN2Pwg+4lUqs/o8gwa6wpqm5S1QAgABL34CAAUSNAIATRwMAgABjNQCAABWMgIAArfUAgACitgCAAC1YAIAQi95ggABnAACAAmNxkIAA/FuAgAB1KgA=
Date:   Thu, 3 Dec 2020 03:23:05 +0000
Message-ID: <SN6PR11MB34216FDFC6BA39C71B444707DFF20@SN6PR11MB3421.namprd11.prod.outlook.com>
References: <SN6PR11MB3421F97AA179145AA86369B6DFF30@SN6PR11MB3421.namprd11.prod.outlook.com>
 <20201202202253.GA1467966@bjorn-Precision-5520>
In-Reply-To: <20201202202253.GA1467966@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [43.250.165.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f7d15b-305e-4c55-7ba1-08d8973abfc6
x-ms-traffictypediagnostic: SA2PR11MB5097:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB50975E44922527744E1F1F5FDFF20@SA2PR11MB5097.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w3Ff3D9bsTJxM0h/w0G0kBmzxLxUn8dKagWx52CX6zUuxEKbXgAzgqiigdCUCdppOPnb1C5vmheIompB1T5kKXGnToRWq9GFyhFWSQ/TYHSODIpGqCNGPWoFtTJwhydbgV7Kil1rZZ/Fs7mk8TWR7eS/wtgxY4zacvIxYVac66EPJkBH/JkbjKFxs3Fsa2GuxWj+K/CeYPOXs7neMY51+QrpFR/3DFPmV+on5N422tFmlo3MGwA3G09eDaP6+7kIfApxwBdQ6yNT2BwrBKfrrwuXGEAOMtmE6t+3B4lEHfk3RsJJPGv029I8A5GMcbw8b2RD56fHYR+CW1B++bfDyNx1GEZk9D1i183z6OwOPpu+1Ky6Yz7h0+6y+yY9TnqRyZ8o7vQIFMy+POLGJtSPcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3421.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(7696005)(4326008)(7416002)(6506007)(33656002)(83380400001)(6916009)(2906002)(54906003)(478600001)(71200400001)(9686003)(966005)(66556008)(316002)(86362001)(64756008)(8936002)(8676002)(5660300002)(76116006)(52536014)(66446008)(66946007)(186003)(55016002)(26005)(66476007)(30864003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8dKV8nVz1PLGrEgcQLce8AO0xQKM5HLMuH98vYFDf8/Wjhp9zt2FaGkRV/p+?=
 =?us-ascii?Q?1lUvKGzueZnyWygOAxMu+FDlQN52e2m4aYJfd2UC7xhTqURvgPbYiMcfBd7W?=
 =?us-ascii?Q?B/SuKtQepdpOeJK90BA9MAq5gtlapKEAMRSOxMz0yk1LsBTMTLaxIKPa1Alm?=
 =?us-ascii?Q?BnNKfHmdFRAqS4GzSsFAIhM8469NIjP87GmuC6PPoovFgvN3MRqBUufriD8c?=
 =?us-ascii?Q?2e2rko/XECA82vgSjcGr4d9hJtnQHY/GKE9ycCMB0Y9gFB7/2IkGYnAzy3I3?=
 =?us-ascii?Q?0UlDm42h6Fc40r2aWun1fdcRuHGXxnO1FN51qZ7uEgxvDRD3UgtpRfJFMzcr?=
 =?us-ascii?Q?9+hPa30wkBDVKQME1ukgJ3D2cPrCK30wJ/uAW0DVI2gGFRhv4O43DscvXx2b?=
 =?us-ascii?Q?8tPQzyTxYrae5bmm0zz9AzNjPUZkjFD3juxzJjqoISxezUidQwSxVmtJrt7a?=
 =?us-ascii?Q?jvCVLIJ5XfiYTPf1VkDVeLYQ8pz1ieCF4DQlhDPl9ej+WaTYBdV4QV/cpOcb?=
 =?us-ascii?Q?4HA6WnFJmjvnTflBVBmcqiMF73ROv8v9Ohr8z8rxTX+kVAJA5nlpTfYXOcSg?=
 =?us-ascii?Q?dZOtPCWUwmwKa/mTo0Q1KRHZZSeEqWRMzo887TivGNizSMFDUkCl3EJEOKg2?=
 =?us-ascii?Q?PNv5bGYNVzJL37YaEaZbsJDOL+aTwKJUm82EC3+f9qjIh075JwXvgE1NEGdi?=
 =?us-ascii?Q?dlYaic7E/Zjcb+7MnlMZzLTSYMoqj25fsR8ADMJ4wLCzmBmG80aQxlR1CkRR?=
 =?us-ascii?Q?uhnh4XV9Szkb5Vl6d3chbenl8TRo31YtNfqRVcBI2arG1CnvJvfrgZ2YQNkJ?=
 =?us-ascii?Q?wKwPzuB7He43FuiPBdBiUnqcfaqFNfKaPUb81buAaLW9zdmziOCTx7Hx6hBt?=
 =?us-ascii?Q?N6gK2b4Rzqyk7SkZ0XFPomYqWzhVNt8E4Jkmfb2C2AMWk9xLB4FlpV48lJmK?=
 =?us-ascii?Q?pqax8k4mlJ0Dos210d8pTeaTcwIp0HJQjyzVIkiKYqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f7d15b-305e-4c55-7ba1-08d8973abfc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 03:23:05.2219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WN6ojnZG0Hr4ktNdLczyqRdgccU1zsbBZWyE1V46Pq20MH1Sn1p0SL6PSPHvJjcQpA7hwyPXMa/NIdPLM51FpfdntHjat+b39283dETxat9WOnmKVoUbjvU04RqM8Utpvc+DzHovDvPyEXjHkrzuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I sent patch to fix https://gitlab.freedesktop.org/drm/intel/-/issues/2610 =
issue.

Thanks,
Tejas

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: 03 December 2020 01:53
> To: Surendrakumar Upadhyay, TejaskumarX
> <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Cc: Jesse Barnes <jsbarnes@google.com>; Daniel Vetter <daniel@ffwll.ch>;
> Joonas Lahtinen <joonas.lahtinen@linux.intel.com>; Linux PCI <linux-
> pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> <hariom.pandey@intel.com>; Jani Nikula <jani.nikula@linux.intel.com>; Viv=
i,
> Rodrigo <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
>=20
> On Wed, Dec 02, 2020 at 05:21:58AM +0000, Surendrakumar Upadhyay,
> TejaskumarX wrote:
> > Yes it fails all the tests which are allocating from this stolen
> > memory bunch. For example IGT tests like "
> > igt@kms_frontbuffer_tracking@-[fbc|fbcpsr].* |
> > igt@kms_fbcon_fbt@fbc.* " are failing as they totally depend to work
> > on stolen memory.
>=20
> I'm sure that means something to graphics developers, but I have no idea!
> Do you have URLs for the test case source, outputs, dmesg log, lspci info=
, bug
> reports, etc?
>=20
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: 30 November 2020 22:21
> > > To: Surendrakumar Upadhyay, TejaskumarX
> > > <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > > Cc: Jesse Barnes <jsbarnes@google.com>; Daniel Vetter
> > > <daniel@ffwll.ch>; Joonas Lahtinen
> > > <joonas.lahtinen@linux.intel.com>; Linux PCI <linux-
> > > pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> > > <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> > > Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> > > <hariom.pandey@intel.com>; Jani Nikula
> > > <jani.nikula@linux.intel.com>; Vivi, Rodrigo
> > > <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> > > Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
> > >
> > > On Mon, Nov 30, 2020 at 10:44:14AM +0000, Surendrakumar Upadhyay,
> > > TejaskumarX wrote:
> > > > Hi All,
> > > >
> > > > Are we merging this patch in?
> > >
> > > Does it fix something?  If something is broken without this patch,
> > > can we collect information about exactly what is broken and how it fa=
ils?
> > >
> > > But I don't object if somebody else wants to apply this.
> > >
> > > > > -----Original Message-----
> > > > > From: Jesse Barnes <jsbarnes@google.com>
> > > > > Sent: 20 November 2020 03:32
> > > > > To: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>; Joonas Lahtinen
> > > > > <joonas.lahtinen@linux.intel.com>; Surendrakumar Upadhyay,
> > > > > TejaskumarX <tejaskumarx.surendrakumar.upadhyay@intel.com>;
> > > > > Linux PCI <linux- pci@vger.kernel.org>; Linux Kernel Mailing
> > > > > List <linux- kernel@vger.kernel.org>; X86 ML <x86@kernel.org>;
> > > > > Borislav Petkov <bp@alien8.de>; De Marchi, Lucas
> > > > > <lucas.demarchi@intel.com>; Roper, Matthew D
> > > > > <matthew.d.roper@intel.com>; Pandey, Hariom
> > > > > <hariom.pandey@intel.com>; Jani Nikula
> > > > > <jani.nikula@linux.intel.com>; Vivi, Rodrigo
> > > > > <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> > > > > Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
> > > > >
> > > > > On Thu, Nov 19, 2020 at 11:19 AM Bjorn Helgaas
> > > > > <helgaas@kernel.org>
> > > > > wrote:
> > > > > >
> > > > > > [+cc Jesse]
> > > > > >
> > > > > > On Thu, Nov 19, 2020 at 10:37:10AM +0100, Daniel Vetter wrote:
> > > > > > > On Thu, Nov 19, 2020 at 12:14 AM Bjorn Helgaas
> > > > > > > <helgaas@kernel.org>
> > > > > wrote:
> > > > > > > > On Wed, Nov 18, 2020 at 10:57:26PM +0100, Daniel Vetter
> wrote:
> > > > > > > > > On Wed, Nov 18, 2020 at 5:02 PM Bjorn Helgaas
> > > > > <helgaas@kernel.org> wrote:
> > > > > > > > > > On Fri, Nov 06, 2020 at 10:39:16AM +0100, Daniel Vetter
> wrote:
> > > > > > > > > > > On Thu, Nov 5, 2020 at 3:17 PM Bjorn Helgaas
> > > > > <helgaas@kernel.org> wrote:
> > > > > > > > > > > > On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas
> > > > > > > > > > > > Lahtinen
> > > > > wrote:
> > > > > > > > > > > > > Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> > > > > > > > > > > > > > [+cc Jani, Joonas, Rodrigo, David, Daniel]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Nov 04, 2020 at 05:35:06PM +0530,
> > > > > > > > > > > > > > Tejas Upadhyay
> > > > > wrote:
> > > > > > > > > > > > > > > JSL re-uses the same stolen memory as ICL and=
 EHL.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Cc: Lucas De Marchi
> > > > > > > > > > > > > > > <lucas.demarchi@intel.com>
> > > > > > > > > > > > > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > > > > > > > > > > > > > Signed-off-by: Tejas Upadhyay
> > > > > > > > > > > > > > > <tejaskumarx.surendrakumar.upadhyay@intel.co
> > > > > > > > > > > > > > > m>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't plan to do anything with this since
> > > > > > > > > > > > > > previous similar patches have gone through
> > > > > > > > > > > > > > some other tree, so this is
> > > > > just kibitzing.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But the fact that we have this long list of
> > > > > > > > > > > > > > Intel devices [1] that constantly needs
> > > > > > > > > > > > > > updates [2] is a hint that
> > > > > something is wrong.
> > > > > > > > > > > > >
> > > > > > > > > > > > > We add an entry for every new integrated
> > > > > > > > > > > > > graphics platform. Once the platform is added,
> > > > > > > > > > > > > there have not been
> > > > > changes lately.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > IIUC the general idea is that we need to
> > > > > > > > > > > > > > discover Intel gfx memory by looking at
> > > > > > > > > > > > > > device-dependent config
> > > > > space and add it to the E820 map.
> > > > > > > > > > > > > > Apparently the quirks discover this via PCI
> > > > > > > > > > > > > > config registers like I830_ESMRAMC,
> > > > > > > > > > > > > > I845_ESMRAMC, etc, and tell the driver about
> > > > > > > > > > > > > > it via the global
> > > > > "intel_graphics_stolen_res"?
> > > > > > > > > > > > >
> > > > > > > > > > > > > We discover what is called the graphics data
> > > > > > > > > > > > > stolen memory. It is regular system memory range
> > > > > > > > > > > > > that is not CPU accessible. It is accessible by
> > > > > > > > > > > > > the integrated
> > > graphics only.
> > > > > > > > > > > > >
> > > > > > > > > > > > > See:
> > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/
> > > > > > > > > > > > > torv
> > > > > > > > > > > > > alds
> > > > > > > > > > > > > /linux.git/commit/arch/x86/kernel/early-quirks.c
> > > > > > > > > > > > > ?h=3Dv
> > > > > > > > > > > > > 5.10
> > > > > > > > > > > > > -rc2&id=3D814c5f1f52a4beb3710317022acd6ad34fc0b6b=
9
> > > > > > > > > > > > >
> > > > > > > > > > > > > > That's not the way this should work.  There
> > > > > > > > > > > > > > should some generic, non device-dependent PCI
> > > > > > > > > > > > > > or ACPI method to discover the memory used, or
> > > > > > > > > > > > > > at least some way to do it in
> > > > > the driver instead of early arch code.
> > > > > > > > > > > > >
> > > > > > > > > > > > > It's used by the early BIOS/UEFI code to set up
> > > > > > > > > > > > > initial
> > > > > framebuffer.
> > > > > > > > > > > > > Even if i915 driver is never loaded, the memory
> > > > > > > > > > > > > ranges still need to be fixed. They source of
> > > > > > > > > > > > > the problem is that the OEM BIOS which are not
> > > > > > > > > > > > > under our control get the
> > > > > programming wrong.
> > > > > > > > > > > > >
> > > > > > > > > > > > > We used to detect the memory region size again
> > > > > > > > > > > > > at
> > > > > > > > > > > > > i915 initialization but wanted to eliminate the
> > > > > > > > > > > > > code duplication and resulting subtle bugs that c=
aused.
> > > > > > > > > > > > > Conclusion back then was that storing the struct
> > > > > > > > > > > > > resource in
> > > > > memory is the best trade-off.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > How is this *supposed* to work?  Is there
> > > > > > > > > > > > > > something we can do in E820 or other resource
> > > > > > > > > > > > > > management that would
> > > > > make this easier?
> > > > > > > > > > > > >
> > > > > > > > > > > > > The code was added around Haswell (HSW) device
> > > > > > > > > > > > > generation to mitigate bugs in BIOS. It is
> > > > > > > > > > > > > traditionally hard to get all OEMs to fix their
> > > > > > > > > > > > > BIOS when things work for Windows. It's only
> > > > > > > > > > > > > later years when some laptop models
> > > > > are intended to be sold with Linux.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The alternative would be to get all the OEM to
> > > > > > > > > > > > > fix their BIOS for Linux, but that is not very
> > > > > > > > > > > > > realistic given past experiences. So it seems a
> > > > > > > > > > > > > better choice to to add new line per platform
> > > > > > > > > > > > > generation to make sure the users can
> > > > > boot to Linux.
> > > > > > > > > > > >
> > > > > > > > > > > > How does Windows do this?  Do they have to add
> > > > > > > > > > > > similar code for each new platform?
> > > > > > > > > > >
> > > > > > > > > > > Windows is chicken and doesn't move any mmio bar
> > > > > > > > > > > around on its
> > > > > own.
> > > > > > > > > > > Except if the bios explicitly told it somehow (e.g.
> > > > > > > > > > > for the 64bit bar stuff amd recently announced for
> > > > > > > > > > > windows, that linux supports since years by moving
> > > > > > > > > > > the bar). So except if you want to preemptively
> > > > > > > > > > > disable the pci code that does this anytime there's
> > > > > > > > > > > an intel gpu, this is what we
> > > have to do.
> > > > > > > > > >
> > > > > > > > > > I think Windows *does* move BARs (they use the more
> > > > > > > > > > generic terminology of "rebalancing PNP resources") in
> > > > > > > > > > some cases [3,4].  Of course, I'm pretty sure Windows
> > > > > > > > > > will only assign PCI resources inside the windows
> > > > > > > > > > advertised in the host bridge
> > > > > _CRS.
> > > > > > > > > >
> > > > > > > > > > Linux *used* to ignore that host bridge _CRS and could
> > > > > > > > > > set BARs to addresses that appeared available but were
> > > > > > > > > > in fact used by the platform somehow.  But Linux has
> > > > > > > > > > been paying attention to host bridge _CRS for a long
> > > > > > > > > > time now, so it should also only assign resources insid=
e those
> windows.
> > > > > > > > >
> > > > > > > > > If this behaviour is newer than the addition of these
> > > > > > > > > quirks then yeah they're probably not needed anymore,
> > > > > > > > > and we can move all this back into the driver. Do you
> > > > > > > > > have the commit when pci core started observing _CRS on t=
he
> host bridge?
> > > > > > > >
> > > > > > > > I think the most relevant commit is this:
> > > > > > > >
> > > > > > > >   2010-02-23 7bc5e3f2be32 ("x86/PCI: use host bridge _CRS
> > > > > > > > info by default on 2008 and newer machines")
> > > > > > > >
> > > > > > > > but the earliest quirk I found is over three years later:
> > > > > > > >
> > > > > > > >   2013-07-26 814c5f1f52a4 ("x86: add early quirk for
> > > > > > > > reserving Intel graphics stolen memory v5")
> > > > > > > >
> > > > > > > > So there must be something else going on.  814c5f1f52a4
> > > > > > > > mentions a couple bug reports.  The dmesg from 66726 [5]
> > > > > > > > shows that we *are* observing the host bridge _CRS, but
> > > > > > > > Linux just used the BIOS configuration without changing
> anything:
> > > > > > > >
> > > > > > > >   BIOS-e820: [mem 0x000000007f49_f000-0x000000007f5f_ffff]
> > > usable
> > > > > > > >   BIOS-e820: [mem 0x00000000fec0_0000-0x00000000fec0_0fff]
> > > > > reserved
> > > > > > > >   PCI: Using host bridge windows from ACPI; if necessary,
> > > > > > > > use
> > > > > "pci=3Dnocrs" and report a bug
> > > > > > > >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > > > > > > >   pci_bus 0000:00: root bus resource [mem 0x7f70_0000-
> 0xffff_ffff]
> > > > > > > >   pci 0000:00:1c.0: PCI bridge to [bus 01]
> > > > > > > >   pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> > > > > > > >   pci 0000:00:1c.0:   bridge window [mem 0xfe90_0000-
> 0xfe9f_ffff]
> > > > > > > >   pci 0000:00:1c.0:   bridge window [mem 0x7f70_0000-
> 0x7f8f_ffff
> > > 64bit
> > > > > pref]
> > > > > > > >   pci 0000:01:00.0: [1814:3090] type 00 class 0x028000
> > > > > > > >   pci 0000:01:00.0: reg 10: [mem 0xfe90_0000-0xfe90_ffff]
> > > > > > > >   [drm:i915_stolen_to_physical] *ERROR* conflict detected
> > > > > > > > with stolen region: [0x7f80_0000 - 0x8000_0000]
> > > > > > > >
> > > > > > > > So the BIOS programmed the 00:1c.0 bridge prefetchable
> > > > > > > > window to [mem 0x7f70_0000-0x7f8f_ffff], and i915 thinks th=
at's
> a conflict.
> > > > > > > >
> > > > > > > > On this system, there are no PCI BARs in that range.
> > > > > > > > 01:00.0 looks like a Ralink RT3090 Wireless 802.11n device
> > > > > > > > that only has a non-prefetchable BAR at [mem 0xfe90_0000-
> 0xfe90_ffff].
> > > > > > > >
> > > > > > > > I don't know the details of the conflict.  IIUC, Joonas
> > > > > > > > said the stolen memory is accessible only by the
> > > > > > > > integrated graphics, not by the CPU.  The bridge window is
> > > > > > > > CPU accessible, of course, and the [mem
> > > > > > > > 0x7f70_0000-0x7f8f_ffff] range contains the addresses the
> > > > > > > > CPU uses for programmed I/O to
> > > BARs below the bridge.
> > > > > > > >
> > > > > > > > The graphics accesses sound like they would be DMA in the
> > > > > > > > *bus* address space, which is frequently, but not always,
> > > > > > > > identical to the CPU address space.
> > > > > > >
> > > > > > > So apparently on some platforms the conflict is harmless
> > > > > > > because the BIOS puts BARs and stuff over it from boot-up, an=
d
> things work:
> > > > > > > 0b6d24c01932 ("drm/i915: Don't complain about stolen
> > > > > > > conflicts on
> > > > > > > gen3") But we also had conflict reports on other machines.
> > > > > >
> > > > > > The bug reports mentioned in 814c5f1f52a4 ("x86: add early
> > > > > > quirk for reserving Intel graphics stolen memory v5") and
> > > > > > 0b6d24c01932
> > > > > > ("drm/i915: Don't complain about stolen conflicts on gen3")
> > > > > > seem to be basically complaints about the *message*, not
> > > > > > anything that's actually broken.
> > > > > >
> > > > > > Jesse's comment [6]:
> > > > > >
> > > > > >   Given the decode priority on our GMCHs, it's fine if the regi=
ons
> > > > > >   overlap.  However it doesn't look like there's a nice way to =
detect
> > > > > >   it.  In this case, part of the range occupied by the stolen s=
pace is
> > > > > >   simply "reserved" per the E820, but the rest of it is under t=
he bus
> > > > > >   0 range (which kind of makes sense too).
> > > > > >
> > > > > > sounds relevant but I don't know enough to interpret it.  I
> > > > > > added Jesse in case he wants to comment.
> > > > > >
> > > > > > > GPU does all its access with CPU address space (after the
> > > > > > > iommu, which is entirely integrated). So I'm not sure
> > > > > > > whether we've seen something go boom or whether reserving
> > > > > > > that resource was just precaution in
> > > > > > > eaba1b8f3379 ("drm/i915: Verify that our stolen memory
> > > > > > > doesn't conflict"), it's all a bit way back in history.
> > > > > > >
> > > > > > > So really not sure what to do here or what the risks are.
> > > > > >
> > > > > > I'm not either.  Seems like we're not really converging on
> > > > > > anything useful we can do at this point.  The only thing I can
> > > > > > think of would be to collect data about actual failures (not
> > > > > > just warning
> > > messages).
> > > > > > That might lead to something we could improve in the future.
> > > > >
> > > > > I don't have any brilliant ideas here unfortunately.  Maybe it's
> > > > > worth talking to some of the Windows folks internally to see how
> > > > > these ranges are handled these days and matching it?
> > > > > Historically this has been an area fraught with danger because
> > > > > getting things wrong can lead to corruption of various kinds or b=
oot
> hangs.
> > > > >
> > > > > Jesse
