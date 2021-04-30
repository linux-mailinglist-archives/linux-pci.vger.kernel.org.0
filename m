Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527C837011E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 21:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhD3TYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 15:24:20 -0400
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:12768
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229990AbhD3TYR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 15:24:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU5TCn17Wxy1LIrAwzWymqjPrN4F3Tlcc/2XqR40hzn/RSMIlxl6gmR9DCX0XG1Te7ZwM6iW0XMZmj8NBlD9IpOuDS4DLE3Jyd7YvZMnGXkAj2onpFRetJHdSQOSE3/o1u9+79LaN1jo0ostZY8TpWInOlvNaZMxVeIE+Lqquy1dIkwXfCvVfBMUlJh2SU9lS+cjrFhOb3d0HQnBeaUtOaKo5CkdxLrB4QE9MCvi58j2mSIVsO/pdj5jZ3Q/pRLyQGWKxU5ONj5PSc5miSyB9IpZa4yx9W3L0oTvoNdKwsZ4Mm/4JRgOGkwPU5c7gt8NLHGoaHu+kGyaFB9FOJVMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKpVihbmKiBEZfDKnNpi6LEccFOQA/37xbZQSnS3Su8=;
 b=YlaRVsmqryNwy1+670tt7UlsOEyFAubMUIGCDIG+6IEEGcPEkrs/VLjRyNtPs7gqWxVPDnmQwnWzXZroDHT4PuGncSZjJmcbjDIOg0bYPqIL2cg5gSp90w73hial2ykUzcAL+CJ5T4pKLfA+mZKb4bKoCsB9H6Fmw+PKz3WGghgqCFJztq+voYnUkn6KRj0em9isaYD2pgggWYHrUpU5ReiqUptFWF/w+cOp8Ywcy0XAaj/n92+moJGWnGV85C6PqkRzsZF9yOqT8w1/sqG+z1K5u2XE1GQTbHsJhleILNb5y7dULBQRKAqIX9IUX2Qe0vzSqLhwYyBsfcklKwkg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKpVihbmKiBEZfDKnNpi6LEccFOQA/37xbZQSnS3Su8=;
 b=WWmZtjKRXs8GGRRTq71dIs14Dw4W9+X5Kz9F6Eg63Ekgz9WW1819aNplChK4DZTWMDIYfNVte3++ObHLlONIOcpxYJRKovutmR25P37yO714udfgjSW6AkekZuM4oRssKi75E+WjX12M7XMNa8CQLHNLcbHoTufL2PtzJrECeOA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 19:23:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.026; Fri, 30 Apr 2021
 19:23:24 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: fix unused variable warning
Thread-Topic: [PATCH] nvme: fix unused variable warning
Thread-Index: AQHXNrdLp6h8G1JZ5Equar3750o+u6rNZxyAgAAKfYCAAAdGgIAABdtA
Date:   Fri, 30 Apr 2021 19:23:24 +0000
Message-ID: <MN2PR12MB448848FEBDCB3A5669A55FB6F75E9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <CAHp75Vchfem1OmR=2Mawiebw-zisU57BEcF64PUKcOODeiLS-g@mail.gmail.com>
 <20210430190057.GA671619@bjorn-Precision-5520>
In-Reply-To: <20210430190057.GA671619@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-30T19:23:21Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c606c9a9-5c1d-4511-baaa-1bbca67f73bd;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eda82c2f-1e50-45ea-be5b-08d90c0d6c99
x-ms-traffictypediagnostic: BL0PR12MB4866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4866916BC7F89E6EC25CBDE3F75E9@BL0PR12MB4866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/DDeDJzaI0W8QWhmfI8osTujK2VXV+qvZpgMjutPYZJHbGPpXCWO2FSkyanwZnXCZ7ywLTvNT2lFJ3nwgUNQcsjHah2Y/zgOA/EZNf8ZVJB5LviQ+ND9I0xw2i/YLo3O39vsrZ376GiUgfsrByMKPEBEiNpSNuRewx0XAzOPBO7YKJ3JvU6U+g3GirLe0BeyXElmP8NXQh4YDDRGORgEsKPxI86CDq3mEQ6/zTvP4w0L6FhlbtWF6KqP7hU2daWaqpyHB6BedOmaZ0kp4uSZ9Kr+Q3mMe3Y6czEnbJh1YUfYO9ZoaHxDbuBUIlo567UNAkjjNQW/WzwkTvkrsJXtfWP8SHsOXHuT7Dk/HQ7iJi7+68NkF03bFanrxvmp/wwara1yJTuVYSlXwL9wsnS66LHMQU2m062HedECcYwQ5IzIJFS9qQHvARbOP4sGdaKzzj65cR2F5McbTWgMeik/EkjQAdumvsfqWT6ynNO4r+ogyx/86HJoiL0oZdxPbuyMMU32DZFkYVziPjR8pnTO06dgpIvlyusMMOzlSMIu7n8M8CFcSH5ZeDmEc9QYkkyFwxOU9Pb3Hvo83VTYGWhk08rnykB/zcDr40YnvFDD9RVPoF8gHjO5449IrsSfVpyd6L7/CKobwLqg+MQr0VdeI9QVcw6VgrYiYJMv5znEqYHRKy4pAHuY2oPKjlpTH3F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(122000001)(83380400001)(33656002)(7416002)(71200400001)(86362001)(9686003)(45080400002)(76116006)(966005)(66574015)(26005)(4326008)(52536014)(186003)(6506007)(478600001)(66476007)(55016002)(38100700002)(2906002)(5660300002)(53546011)(66946007)(8676002)(7696005)(54906003)(8936002)(66446008)(64756008)(66556008)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?4UJsF6sz/BBFRT32M5ISTduZJdqJbmhVjM0JsLNpg295ybiuKiV3ZLgqAN?=
 =?iso-8859-2?Q?KTciw1Ypip0DIVylfYzpybjl7namS9J8wcub5LgyL76Z3AvNUFNmaPhTAV?=
 =?iso-8859-2?Q?moNfdw14CiHbHl4MLfXVtvD0tG9Bu/uW0Pgyv/gEjss8NHYurQ9k/CGhpW?=
 =?iso-8859-2?Q?CpjYrGZSpZ2Z6FG428uwWbIw4Iyh4mJKvfYAc3IrgkVCMdrK1FjjkKJuzw?=
 =?iso-8859-2?Q?ypZwc5+otsKiA4ZKrtu/y99begaGc4fwOyGbxd2ltaLK+9JykMp+LSNsaC?=
 =?iso-8859-2?Q?bwPpT9d5DeSdbdWPZk/cJ0g7uhfAD2HID62cdSxT2gRlvHySECDhgQej5B?=
 =?iso-8859-2?Q?vN3F6P9zld12RiwU7haSCcB9OBESpI3I23BrTK6lWLm2XHrThHLXiakpOv?=
 =?iso-8859-2?Q?zY2Xr8Mzwib2xRyrjq+DvR3719+YJUMNMr7GV5iIqtIZqwii8Zaarjox5n?=
 =?iso-8859-2?Q?DBTJ3v7cV7G9dws0n85Y8d63pC3V5oVXdGabGAlpJT3h79VWE21okiigM5?=
 =?iso-8859-2?Q?8bvtvpi3ajMcqlRDZCda16mVFxQoW+ETCCgobZTL+QDy1TumA3u7YuhvaX?=
 =?iso-8859-2?Q?Cf+6K4NeO0N/rUPNoxHdlyl/cMrE2iiIm1rhbPhCyW0jNiPu6DDg+i/aDl?=
 =?iso-8859-2?Q?sUSmoVusbnb0P0VRj99W5Xs60Es+ZRbybR3p/s2JETqyxqKzDCV8vSDD5U?=
 =?iso-8859-2?Q?5kYrtxDSEcvv2EIeu2459SW+TIAizw/5Sd1LNC10hl0xxyyZmkLREni0xE?=
 =?iso-8859-2?Q?q8QaPLS/qGVKO8rzqGGFpqGR0mXP6TKNwlqdj/Iyr5HScPGYh5DhGwr323?=
 =?iso-8859-2?Q?i6VWdmMyLIC/HmKIcWG+vONPpLhfjwwevvenqZl069VszOUb+H4X5h8BYB?=
 =?iso-8859-2?Q?QqJPonY7otsElQ3VgZXSbwWuAGSTqelXteRCfODP/mMbCW+/Oe4kvb+OLu?=
 =?iso-8859-2?Q?xR20ShrOO1C/ALo5Ue2rU9fOzD+k9/tDFgng4YE+OzTj7tnrrqcBgP0GL/?=
 =?iso-8859-2?Q?8MGvlk/dXKdEP9XCdf79nQGIb2S/KS6kFJTCv8MOvIKmWaxHQNkr/mO9QI?=
 =?iso-8859-2?Q?XbQ+beffzKH9N4JLIj+3yWLvok6I3zwyJ5FO4Ghf5VxwdGHWe/kd1aYVr5?=
 =?iso-8859-2?Q?tulxjRIqVh1KRelbE+n7//4YUEvjvoR8vGPOBHkq4/S+KIZI4e/9UyLkpk?=
 =?iso-8859-2?Q?KX5yXJZJoSEaKEyUgs+poMkd+iw79ttYhTqXG93+pzcWBf29RTm6I131/T?=
 =?iso-8859-2?Q?h8P5euDGQrOtpD1sCdlzXaXcdR5ZAu20dEqQLiA5MiPYcSXPZmZNZjiOpE?=
 =?iso-8859-2?Q?mDzJUHWxvyUJ0sWQptLg7xvWT/A9OjO4IE7FMAgL039vvVwz/X99LOvP66?=
 =?iso-8859-2?Q?ADToiaaqc9?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda82c2f-1e50-45ea-be5b-08d90c0d6c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 19:23:24.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tL46+Be5663sXeU/HCm9izmGD005jVeJ5b6wtMl7gRM0QkLyZA0JJiMqwCmMmAV3yL5QC2BMwM3D0ppte/FvyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, April 30, 2021 3:01 PM
> To: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Arnd Bergmann <arnd@kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; Liang, Prike <Prike.Liang@amd.com>; S-k, Shyam-
> sundar <Shyam-sundar.S-k@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Chaitanya Kulkarni
> <chaitanya.kulkarni@wdc.com>; Arnd Bergmann <arnd@arndb.de>; Lorenzo
> Pieralisi <lorenzo.pieralisi@arm.com>; Kai-Heng Feng
> <kai.heng.feng@canonical.com>; Krzysztof Wilczy=F1ski <kw@linux.com>;
> Rajat Jain <rajatja@google.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; linux-pci <linux-
> pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH] nvme: fix unused variable warning
>=20
> On Fri, Apr 30, 2021 at 09:34:55PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 30, 2021 at 8:57 PM Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > > On Wed, Apr 21, 2021 at 04:04:20PM +0200, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > The function was introduced with a variable that is never reference=
d:
> > > >
> > > > drivers/pci/quirks.c: In function 'quirk_amd_nvme_fixup':
> > > > drivers/pci/quirks.c:312:25: warning: unused variable 'rdev'
> > > > [-Wunused-variable]
> > > >
> > > > Fixes: 9597624ef606 ("nvme: put some AMD PCIE downstream NVME
> > > > device to simple suspend/resume path")
> > >
> > > I guess this refers to
> > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo
> > > re.kernel.org%2Flinux-nvme%2F1618458725-17164-1-git-send-email-
> Prike
> > >
> .Liang%40amd.com%2F&amp;data=3D04%7C01%7Calexander.deucher%40amd.
> com%7
> > >
> C23a1908e8a394d957ce908d90c0a4b06%7C3dd8961fe4884e608e11a82d994e1
> 83d
> > >
> %7C0%7C0%7C637554060633362710%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLj
> > >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdat
> > >
> a=3DZtcffnpa8rchwe%2Fb6HuHeRASSlNI7uMwAKZuoH5k6CY%3D&amp;reserv
> ed=3D0
> > >
> > > But I don't know what the SHA1 means; I can't find it in linux-next
> > > or my tree.
> >
> > $ git tag --contains 9597624ef606
> > next-20210416
> > next-20210419
> > next-20210420
> >
> > Something is wrong with your tree.
>=20
> I think what's wrong is that it doesn't appear in the *current* linux-nex=
t
> (next-20210430) and I don't have all the old linux-next objects.
>=20
> It was in next-20210420, but seems to have been dropped since then:

It was in my tree briefly to facilitate testing, but I since dropped it.

Alex

>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k
> ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> next.git%2Fcommit%2Finclude%2Flinux%2Fpci.h%3Fh%3Dnext-
> 20210420%26id%3D9597624ef6067bab1500d0273a43d4f90e62e929&amp;data
> =3D04%7C01%7Calexander.deucher%40amd.com%7C23a1908e8a394d957ce908
> d90c0a4b06%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375540
> 60633362710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D0Rb%2
> F9p8VhmiPu4QP3mEJTUCPe4NNcroFHDhyiYb8h40%3D&amp;reserved=3D0
