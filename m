Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE12FCF3C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 13:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbhATLVO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 06:21:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:24710 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731020AbhATKFM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 05:05:12 -0500
IronPort-SDR: boxfYtlhInPz685jUte/R6GFzUJjFLjD7X2ToFUVA6whHFEI9FY3+qljfHIJZDInqe91Mzfti/
 MUtX4WoZdWWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="179164688"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="179164688"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 02:04:30 -0800
IronPort-SDR: JHezPY0bu7q+2njJDgwnEAfhkbNzGWELq4XtIKQ03NKgViXOxSHfkVyD5YrF3VWiXZOVe6gzzA
 o5d5r10CTrmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="402689171"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2021 02:04:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 02:04:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 02:04:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Jan 2021 02:04:29 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 02:04:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHt85hEmO4gbN9H8BIr9daQkd5Asp35eRT7Ge2is4BnUdo0dfwSAWHhpw2NZ/5zLyiEJ+Z7kTQE1GW3pQD3qonYi7LXTWU36JAItaSwglagN4DJ830YExGPHB1lBSQqMeilknLjJvRY7XPwuMebdrWEU+9ajGUKhj/YH0p2CYDPnKA02j9XWpI2ZOsRGmuLq+1g/Ziw9OZuxunAjZgEX4nGdeShuQw/aNyitwo89AbkCNZGY9MpbwdUx7olmcRLCR4DcbXgr1q/7xxWjyWuLTcM/rOvVq3uCsx1/D9Un1zKPr7ChsnJ+JNDmoPfv1Y9yqCoMWtqdnreyZep8kQqgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EamwKu1JIt1LjdR/XcJLuTR4pqedQ8vREzBYDaDKwnE=;
 b=XP4EZIxigAWqQukCjM8n5zYw/538HWgr+bbIecNEU15WvN/ztUBIxGDQCARJ1/WRoKdqqPwqDiP+/u8M3axpANMR2qO18tUpOzukFdTCulzsdImlhra4DZ4s+foO8BUFl9YVbCjjJ11yY1CSn/PhrlPvl2YO1li8Q8I0bPd8XhRVDBrVeghUh1dDVgIEwCP0wXYgqRxY1+LKEZnyBGXugPZ1Ixso6/o/c5/ksRe57kDbH6bvDSgiPJSNyBCJB+ElXBK7PL9RrGET3G2auMnsHkB+Ko9lF0FXpwYxy1W4VHjAqSdEJbQ8IgbKAc+3uBiZpaAKlFrIE8qvLqWquntIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EamwKu1JIt1LjdR/XcJLuTR4pqedQ8vREzBYDaDKwnE=;
 b=FRMeC79E6QL3OADGdM8zTSYHes+/8ygglYmZuQFB+kbUiHjbeezNuEez06j1cYyhMyIUmvyrHw61nUXuzbHe03OpgNwHwkRV8WF3ge5JkW9VQyxdS7CB3i0LDYhx62ec2L6r6iFLCRdOGA84qnTJI9Mx9cfj3Pzvy3dIsFQfED4=
Received: from SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27)
 by SN6PR11MB3343.namprd11.prod.outlook.com (2603:10b6:805:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Wed, 20 Jan
 2021 10:04:27 +0000
Received: from SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::910b:5087:a18e:f19]) by SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::910b:5087:a18e:f19%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 10:04:27 +0000
From:   "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
CC:     Jesse Barnes <jsbarnes@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Linux PCI" <linux-pci@vger.kernel.org>,
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
Thread-Index: AQHWstDzxN2Pwg+4lUqs/o8gwa6wpqm5S1QAgABL34CAAUSNAIATRwMAgABjNQCAABWMgIAArfUAgACitgCAAC1YAIAQi95ggABnAACAAmNxkIAA/FuAgADPwoCAAG9wAIAADA0wgEsKCaA=
Date:   Wed, 20 Jan 2021 10:04:26 +0000
Message-ID: <SN6PR11MB34215740DC23DEB73D85B016DFA20@SN6PR11MB3421.namprd11.prod.outlook.com>
References: <160698518967.3553.11319067086667823352@jlahtine-mobl.ger.corp.intel.com>
 <20201203152520.GA1554214@bjorn-Precision-5520>
 <SN6PR11MB34212EA0A59FB5827D3D4C9DDFF20@SN6PR11MB3421.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB34212EA0A59FB5827D3D4C9DDFF20@SN6PR11MB3421.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [103.249.233.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7844453-395e-4bed-eb3f-08d8bd2ac574
x-ms-traffictypediagnostic: SN6PR11MB3343:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB334390B98A7D7A31E130A957DFA20@SN6PR11MB3343.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QPtver1VaJwcovP6sQ6nhHrx0Ql2Yuo0+/bJg/Wqex+8QQ/bfiRAI+UC5VzJJjqX03md5QqiJXNjzRgUwkfHeoSfPzjfCgBM84OWmY/3vqmS7nBsCoVi2jKbTok+TqwFxp+K73FqIRtJVSxM0WY8AGFA9p9B1b6ZcTmhAsJqp9wcCH9jRvIRmEia91cJDI5uYCVO2y7T5w1jAPXixsZiU+vJ9A0/NkmgLOZPnq2hScgbjXx5dISZcR2iHR/rTvNTF5k0e6ZdxGbdoqMQ/T8G/DxZVhDvDheuKr0Ml23LOf/cmmd4ycEkIR4Gtf46rUl20THoB6KbMhtmywIa8G56qLay1XK7o+jlqrnnJPmJUWQiXQfbV560mSOyBAUG+XfI4SZgK4XU7TVzf0QSUBXLyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3421.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(71200400001)(33656002)(55016002)(64756008)(6506007)(76116006)(8936002)(53546011)(7696005)(8676002)(186003)(110136005)(316002)(2906002)(4326008)(5660300002)(7416002)(26005)(52536014)(86362001)(9686003)(54906003)(66946007)(66476007)(66446008)(478600001)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ts9fj1dm+8mhAp7XCditLfPhuD6EPzhVM/LI41hYMRYfV8lNT0ixAsQM1P7g?=
 =?us-ascii?Q?lgkwYa/eROvByj5Gk9XK128iaj21NwwmNJzRCbhOTdU9A79sZpD3xGlTKzEb?=
 =?us-ascii?Q?zy6nHNPLivcDMCxXrVcP7a1uB/uA209cR9PhP17dBYPtiLZ8KkTYWeNoQfjt?=
 =?us-ascii?Q?C0d5MBqew0nkVpPf25C0pZr+iMwlMhQGpeEq6OHSmZtp1UsVuJCxIi/0jPBY?=
 =?us-ascii?Q?TQ0iYD0CSh1VEAl8P7IGkQWBqyOcne2+svMd5OZCfE+nvKWFgAr2bFJMa2j2?=
 =?us-ascii?Q?yY198rRqi87dDYzVyzx7rkPrAMJU/pLHOdPjAFmj5u0mAEcsjQNZRbBi7AFw?=
 =?us-ascii?Q?GxPiBr87I9bUcjHAFIpn+PJBifnp3N7yGQEbNpUAImVJypkvqAdmPUpg2KF4?=
 =?us-ascii?Q?qf+4EAYvOs435xbHU3X5O8yzEK3nBPUKrP8vJFqJs5a2TwWPV8TCYEQ8g0cJ?=
 =?us-ascii?Q?blRjgBzXUDny4YilegdLG8SlJ2K3u55lUVqlHP7BXRxN/qGfi0+iIA4bubIk?=
 =?us-ascii?Q?XbJV8sKV5YhL4DBTOuymri3cIvOHYJwLALaE555QPrsdMmwJeuDejiDYCqkL?=
 =?us-ascii?Q?MY+iL3aazc/kjAe3tEbNtcM0a6dORd/mGulx8wyVQrYmnHj1oh+l7Scum/uB?=
 =?us-ascii?Q?WFUzdgk6HYdy8ZUPLQlEcg3LRqJAFG3joTnIWbhM1JL35GIux0OaZJXgXCyq?=
 =?us-ascii?Q?PQMV/pmFhsh0nOdqMHMrHa3hc33glb8lGjSsykO4Uq/qTTEzCp76K075RYDm?=
 =?us-ascii?Q?LBBJqILZR0Hkb33yr+riv8fiY8iHAT4BFX7byAzTnxmQVyTAU+zNC0X1yKOT?=
 =?us-ascii?Q?xMKOsRzKMKsMwJU1dWkeVuuU5sghvOwRArbYaOvaGhVI3vg5bfwMd1UsYTUD?=
 =?us-ascii?Q?eDS6JY17vs96U/fBETskKhlIDfJ2s629fe/9sqdWBY5SdUPDPEZBw1M33k2g?=
 =?us-ascii?Q?BN8KyZngUq/5S1mYtT47FXLo8W1kqvHXG5ORAC1ruUbGcN6GC+mHeidual8L?=
 =?us-ascii?Q?bvJF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7844453-395e-4bed-eb3f-08d8bd2ac574
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 10:04:27.0456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBfloG72rV6Zw6iMgtgPNu6jR7Asny0VqhdW5q5oEnRFMdnE6Wt8yKlSNdhxYNIBs/vEb0aZMzSzWQBGdVSb79is2kFKhoFhMektesov2bJqOzIW0P/PLtq5hJTFwiouo/tyvRK4aRMlIYJj0ldLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3343
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Have we decided anything on this patch?

Thanks,
Tejas

> -----Original Message-----
> From: Surendrakumar Upadhyay, TejaskumarX
> Sent: 03 December 2020 21:40
> To: Bjorn Helgaas <helgaas@kernel.org>; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>
> Cc: Jesse Barnes <jsbarnes@google.com>; Daniel Vetter <daniel@ffwll.ch>;
> Linux PCI <linux-pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> <hariom.pandey@intel.com>; Jani Nikula <jani.nikula@linux.intel.com>; Viv=
i,
> Rodrigo <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> Subject: RE: [PATCH] x86/gpu: add JSL stolen memory support
>=20
> Okay then I will wait for someone to respond with "Reviewed-by". So this =
can
> be merged.
>=20
> Thanks,
> Tejas
>=20
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 03 December 2020 20:55
> > To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Surendrakumar Upadhyay, TejaskumarX
> > <tejaskumarx.surendrakumar.upadhyay@intel.com>; Jesse Barnes
> > <jsbarnes@google.com>; Daniel Vetter <daniel@ffwll.ch>; Linux PCI
> > <linux- pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> > <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> > Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> > <hariom.pandey@intel.com>; Jani Nikula <jani.nikula@linux.intel.com>;
> > Vivi, Rodrigo <rodrigo.vivi@intel.com>; David Airlie
> > <airlied@linux.ie>
> > Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
> >
> > On Thu, Dec 03, 2020 at 10:46:29AM +0200, Joonas Lahtinen wrote:
> > > Quoting Bjorn Helgaas (2020-12-02 22:22:53)
> > > > On Wed, Dec 02, 2020 at 05:21:58AM +0000, Surendrakumar Upadhyay,
> > TejaskumarX wrote:
> > > > > Yes it fails all the tests which are allocating from this stolen
> > > > > memory bunch. For example IGT tests like "
> > > > > igt@kms_frontbuffer_tracking@-[fbc|fbcpsr].* |
> > > > > igt@kms_fbcon_fbt@fbc.* " are failing as they totally depend to
> > > > > work on stolen memory.
> > >
> > > That's just because we have de-duped the stolen memory detection code=
.
> > > If it's not detected at the early quirks, it's not detected by the
> > > driver at all.
> > >
> > > So if the patch is not merged to early quirks, we'd have to refactor
> > > the code to add alternative detection path to i915. Before that is
> > > done, the failures are expected.
> > >
> > > > I'm sure that means something to graphics developers, but I have
> > > > no idea!  Do you have URLs for the test case source, outputs,
> > > > dmesg log, lspci info, bug reports, etc?
> > >
> > > The thing is, the bug reports for stuff like this would only start
> > > to flow after Jasperlake systems are shipping widely and the less
> > > common OEMs start integrating it to into strangely behaving BIOSes.
> > > Or that is the assumption.
> > >
> > > If it's fine to merge this through i915 for now with an Acked-by,
> > > like the previous patches, that'd be great. We can start a
> > > discussion on if the new platforms are affected anymore. But I'd
> > > rather not drop it before we have that understanding, as the
> > > previous problems have included boot time memory corruption.
> > >
> > > Would that work?
> >
> > Like I said, I'm not objecting if somebody else wants to apply this.
> >
> > I'm just pointing out that there's a little bit of voodoo here because
> > it's not clear what makes a BIOS strangely behaving or what causes
> > boot-time memory corruption, and that means we don't really have any
> > hope of resolving this stream of quirk updates.
> >
> > Bjorn
