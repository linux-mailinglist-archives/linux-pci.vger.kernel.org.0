Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017572CDADF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 17:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgLCQKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 11:10:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:38648 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbgLCQKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 11:10:34 -0500
IronPort-SDR: NbIDQHrMeHpwnnbKeXHwG4/gYzQu6pRG4pFL2EwFXBNGLReWmFjjYxqb7FzzDWhqvv7jhyggRe
 LUmsD0g04c3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="173313616"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="173313616"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 08:09:53 -0800
IronPort-SDR: LYM7I8+BojnjDsLO4N0coxQXHm/tmeSw9FJIrCIPDHcRbFJkxjZbCTPy/ZJ2pgQ8LZZV5pTSCo
 QW86oRPRFZww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="365886413"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 03 Dec 2020 08:09:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Dec 2020 08:09:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Dec 2020 08:09:52 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.54) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 3 Dec 2020 08:09:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXJoUgAgt4Zp9og6ScSm5d++kUwvKQbW3zcT1VwN01uRf554TNg2ETbMv2diZ7NMfBvX5gMNjG1ssr4ASZn0jk0YinItXhuUzpM56Oc2P4BDwZJDuunzPdcVVYeI3Z9i9N5Cj3DXJFBx5wPoQQ8Wc1DLgECV/mDIFqdQEU2LWJly0ne+1Oy5JE2++IeJSmQUmJ0Nlo3DMO/rUqOJZQNbTL8Cbb4XoiPzXa8cdxEhZ5TtObyk4CBV6j4toKL3wFXWbaOfk7epyfJbTYWXY4LPJSt+fwvXMuX7TAHLAQwV6W7Jd9ZD/LaT+vyfmHAAGowznNz1flR9x5SKHL0OuI3F3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO2cym3or93g+wAwXrmPOBbcjX01rMWUvIXsKUyq/FI=;
 b=Rnya0D4kqZL9He91bOvO3A4gzjwWG7IIeB+X2U3XSf631E4Meetzfgpn4LUpQmDakWpjvpGzhniYOZiGz1rUXJZp0ZOyiBQ5mtbVe1l1ma2poH5/Wm1adaM+uaEbbYdgOLbpQGnUP7iD/vY+EeWzKE3YsqwX8oih6kCmOVBoTmal+cD6xE+JIu7402kYeM5LmJUKv1H1nVV/VKG/FKoqPhiFAHtDAv38SlZ9IGnRs/sC8ZmOHw0TtJUTzqte8GdAQ/e7p/cRNmp4bw/g/+XedjXyj/bRlfU+0vcT1G5jrfq1LxRLXd/mYLgKCLzPb273S+R6bogAfpHs/Coa2t5t+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO2cym3or93g+wAwXrmPOBbcjX01rMWUvIXsKUyq/FI=;
 b=S+S4a5nF26k7mvSdYIoXpp6ToMV5jYlGE/w6Hy08+VeePv+8L4V2UG3GOasVA5GzImsVgfZWMa1xJkAPFodzh1bNV2hhrWXfrVPnzomIrfzMQMLBPBeJdQrKOF+m6fCCXLpliep+xGxZ6Cml0zCWOiAfSO0o63qfmR05iIHpjVE=
Received: from SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27)
 by SN6PR11MB2573.namprd11.prod.outlook.com (2603:10b6:805:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 16:09:50 +0000
Received: from SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::a975:345b:8dcc:50ff]) by SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::a975:345b:8dcc:50ff%6]) with mapi id 15.20.3611.025; Thu, 3 Dec 2020
 16:09:50 +0000
From:   "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
CC:     Jesse Barnes <jsbarnes@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
Thread-Index: AQHWstDzxN2Pwg+4lUqs/o8gwa6wpqm5S1QAgABL34CAAUSNAIATRwMAgABjNQCAABWMgIAArfUAgACitgCAAC1YAIAQi95ggABnAACAAmNxkIAA/FuAgADPwoCAAG9wAIAADA0w
Date:   Thu, 3 Dec 2020 16:09:50 +0000
Message-ID: <SN6PR11MB34212EA0A59FB5827D3D4C9DDFF20@SN6PR11MB3421.namprd11.prod.outlook.com>
References: <160698518967.3553.11319067086667823352@jlahtine-mobl.ger.corp.intel.com>
 <20201203152520.GA1554214@bjorn-Precision-5520>
In-Reply-To: <20201203152520.GA1554214@bjorn-Precision-5520>
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
x-ms-office365-filtering-correlation-id: e7a6f7be-ec02-4a84-bb1f-08d897a5dd09
x-ms-traffictypediagnostic: SN6PR11MB2573:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2573CC7CFC67888752AAB7A8DFF20@SN6PR11MB2573.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g04avq6lusjlyP0mPQFrM+uOxDIGiijHdLNcoTdBLLLEtDVLimZNGO9P2Gt8tUyEvYYM3Y5+5Xk6RIaFoBI8LRAeJ2c133yM2VpAG1RKuKvbyz+N9JPrONUKe77oh1UAZXIhTbMMZae8xfucvPIE3aTLjNhcyd6HNvbjQB85x6sJNoQFkm+u//w1dRcWWAUSYD4qcCHXw+8L8Ly8/K+ipwAuD/+5chsgD4ANhZWhWOOlohbMHf4UbKUKqgr5RRtvAoaChmDTBAQNQbW1W6ePskkNLhDfmOgDagvy2P1hXCD6m5D4eD+oml8DcoWse7hM80LE7xfdWYC9paeAGAOvPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3421.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(8676002)(66946007)(55016002)(66446008)(498600001)(9686003)(86362001)(186003)(26005)(64756008)(33656002)(76116006)(66556008)(66476007)(7696005)(7416002)(71200400001)(4326008)(8936002)(2906002)(52536014)(6506007)(54906003)(83380400001)(53546011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QX8LDX6hwIuc0XF9eM9zhF13rIyI3Le6zIknniykbNkevXjDlPgVj0wUd843?=
 =?us-ascii?Q?EKoslmDXLqv04Y5ZYC/s3CinHLla1ZpyWBF9+qGFk30xnZBi8tgXjreE4rHy?=
 =?us-ascii?Q?yfl++5MjoVK5n5hAJV7ZJhr2O+750xTi7jPi3YvVX8rqfIBNOzgeCsVM+PbN?=
 =?us-ascii?Q?qNo4WIGxk6VKFObx7HZsu53znIwN4WsNJaB8RnOV0YjfQI3heD0fev6WDVvy?=
 =?us-ascii?Q?T4jb3atOyLSZmUaIxEyvUAII2qx5iAAV44NMJTqcKa1ctZMOP1yVluv+W7qF?=
 =?us-ascii?Q?ZOHD3lWF0RJWuROXT1YmAp/pjea/qLrcv7tlU01XNxEeosfVdsEz982Pf+R1?=
 =?us-ascii?Q?NacSq524EjBw1hTTh/zL6dJJnDPo1bG76BR9w9xDERefKuAW4bC+TLdLkimS?=
 =?us-ascii?Q?ZvJxlm2EbtADwm0+XLEhsVVC3Y7mjxOSzdfxu2IV/ntWfWxjUnDNmxjObJA9?=
 =?us-ascii?Q?sqjPoojj9yIVCZkbPnL9gwLWDoJi8rE0zA5nE7LHRUV6vMFjbYdd9zc4qPTA?=
 =?us-ascii?Q?LYgGMOS5pqmSPbZ/r0k4WlrNv6kZjKmvrMEmQulbkvKe8Y0GLpG1Usqp33Dv?=
 =?us-ascii?Q?cYY1mKaoOXDSb3O6ieDHWm8RhlFNBsRi+5r+ox/ymZIAvYDtehlD28h2IMUL?=
 =?us-ascii?Q?7flmYEmiry/k/al02qj+dE6XPJ31OgRXk/cWQehpJT3DmiLk81orpN6+jsxl?=
 =?us-ascii?Q?ACdSIfLlaVD4krFY1YRo/tqGJkAs1wpP9q/3OA3gfe0oaidsAdEst7vpThnQ?=
 =?us-ascii?Q?kLyeZb+qB6fXs5rPPuhrXNc5t1Dm5FnTJaPD4L2t6bZuWgVnXdu9MRyeoYTt?=
 =?us-ascii?Q?ZYm4xi5Gan6VTvACCLyMsrMFZIMBgKDtsnmWtXS/tL42QToZkuvqM37uqLH0?=
 =?us-ascii?Q?lzBGjLNVR12IB+b3RFl8XtXodbRl5AgAVjefk8/IR6p5633GfAWfrZypSG/y?=
 =?us-ascii?Q?IJswdCAAV9kt1m2NGZaEZmCeZxNjJG2KP05e8LYta6Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a6f7be-ec02-4a84-bb1f-08d897a5dd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 16:09:50.5336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rscKhzyS/ZDaX9ZfzD7oyNjjXQusua5DDJQSkyvSsq+6qMR9fXJvxfGY88rZajFvOhONgks0UHm+1sk2n+TXuE5qAST+9Jx0yeAtjQlXjFToCOSo0kszTCI3pDBI2o4Wq1vvFN4+hcVW0UfPR3W6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2573
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Okay then I will wait for someone to respond with "Reviewed-by". So this ca=
n be merged.

Thanks,
Tejas

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: 03 December 2020 20:55
> To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Surendrakumar Upadhyay, TejaskumarX
> <tejaskumarx.surendrakumar.upadhyay@intel.com>; Jesse Barnes
> <jsbarnes@google.com>; Daniel Vetter <daniel@ffwll.ch>; Linux PCI <linux-
> pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> <hariom.pandey@intel.com>; Jani Nikula <jani.nikula@linux.intel.com>; Viv=
i,
> Rodrigo <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
>=20
> On Thu, Dec 03, 2020 at 10:46:29AM +0200, Joonas Lahtinen wrote:
> > Quoting Bjorn Helgaas (2020-12-02 22:22:53)
> > > On Wed, Dec 02, 2020 at 05:21:58AM +0000, Surendrakumar Upadhyay,
> TejaskumarX wrote:
> > > > Yes it fails all the tests which are allocating from this stolen
> > > > memory bunch. For example IGT tests like "
> > > > igt@kms_frontbuffer_tracking@-[fbc|fbcpsr].* |
> > > > igt@kms_fbcon_fbt@fbc.* " are failing as they totally depend to
> > > > work on stolen memory.
> >
> > That's just because we have de-duped the stolen memory detection code.
> > If it's not detected at the early quirks, it's not detected by the
> > driver at all.
> >
> > So if the patch is not merged to early quirks, we'd have to refactor
> > the code to add alternative detection path to i915. Before that is
> > done, the failures are expected.
> >
> > > I'm sure that means something to graphics developers, but I have no
> > > idea!  Do you have URLs for the test case source, outputs, dmesg
> > > log, lspci info, bug reports, etc?
> >
> > The thing is, the bug reports for stuff like this would only start to
> > flow after Jasperlake systems are shipping widely and the less common
> > OEMs start integrating it to into strangely behaving BIOSes. Or that
> > is the assumption.
> >
> > If it's fine to merge this through i915 for now with an Acked-by, like
> > the previous patches, that'd be great. We can start a discussion on if
> > the new platforms are affected anymore. But I'd rather not drop it
> > before we have that understanding, as the previous problems have
> > included boot time memory corruption.
> >
> > Would that work?
>=20
> Like I said, I'm not objecting if somebody else wants to apply this.
>=20
> I'm just pointing out that there's a little bit of voodoo here because it=
's not
> clear what makes a BIOS strangely behaving or what causes boot-time
> memory corruption, and that means we don't really have any hope of
> resolving this stream of quirk updates.
>=20
> Bjorn
