Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C940B6F2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhINS3q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 14:29:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:30587 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhINS3p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 14:29:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="202269636"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="202269636"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 11:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="481956626"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2021 11:28:26 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 14 Sep 2021 11:28:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 14 Sep 2021 11:28:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 14 Sep 2021 11:28:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORy4mcBls3G/O1ylp/wCh9mtub3GT0YLsRFH1MN27RdtvV2e43Vw8nTeFsV0UrI9rMR5UdvLVAEmROx3Oo2uPwhZMDxF5pu2zZyExuJJT5YM9uLpljTg8ZdHqMV6i0vHRqJY1Oqw3qIxYgzJiC2gJxk3oNiRop7mIz3R7QZQYeT0KBumWn1xA1cmxEVyml1uaEg3tBm8GCq9KqE/hoDBThCp2GiNElYzdNsNklOlN5kTDdUrg63wXrM9CIgo4eXyODCwcQVK5GMG0aQlq8nqsiVDIH5IGt013hZzSBxt+aMvF2QtSDmHMHk9iY9kCIn+eks01ERIO7Q+ECkd6eT3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QWNfU0RahtXtHJcxeTgIHMDOt1YaxCj41TGENYbdsz4=;
 b=bTGq+D1yn1vnUEhXQpzsXHmzzYuE0CIjGHtaYoIPkNw/JLR1eeQYrWrSXEQ4OC21ZUKw3IFrqFjp88KIrU3VG0hAdDSjXFHU8bwh6RET5WoB/nEpf+JfmKbq/LySH7EGwhnxuTQBtdBbK9lpyzTOivRWEWWPU+bF0dpyGyZDS7lnDyD9pM3TbEFHRE2oLL5Z3NgWlb8cGbZZE1gqfV2PYdI4hgBxM9g1GpkX+55Cc18Q/A42M6tpabsJoWOBZv6wirZpWpDBWCQnklo8WPaOXaVBrQ5MrqmKcPoJfgSQF0S3JfgWyCXpmujBzid0S3CEHTdfKCJ+b+LuyA417cCA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWNfU0RahtXtHJcxeTgIHMDOt1YaxCj41TGENYbdsz4=;
 b=PD5GMdK02b5dae9LTW84WkpUjO29Ec13oF49FZsZE3LM0mQMOADH4nR18ejmOocTZrT18HG6AKsdCL6apoDWqgAlogZubfkol0Kbjv2TksQxmV/eBWSysa2Cfs3LucwFFFiOpjQKkWTh5NeSKK6hAFgWqx4+zwIIaoTf2axEXzw=
Received: from CO6PR11MB5652.namprd11.prod.outlook.com (2603:10b6:5:35e::14)
 by CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 18:28:24 +0000
Received: from CO6PR11MB5652.namprd11.prod.outlook.com
 ([fe80::9ccf:22f3:ebe0:fd25]) by CO6PR11MB5652.namprd11.prod.outlook.com
 ([fe80::9ccf:22f3:ebe0:fd25%9]) with mapi id 15.20.4523.014; Tue, 14 Sep 2021
 18:28:24 +0000
From:   "Fujinaka, Todd" <todd.fujinaka@intel.com>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC:     "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hisashi T Fujinaka <htodd@twofifty.com>
Subject: RE: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
Thread-Topic: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
Thread-Index: AQHXqOBdDrYuIoY4WU2s2AfwBgv2xauinYaAgABp0ACAAI9RgIAAQ0aw
Date:   Tue, 14 Sep 2021 18:28:24 +0000
Message-ID: <CO6PR11MB5652A825C25D4675649BA43FEFDA9@CO6PR11MB5652.namprd11.prod.outlook.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
 <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
 <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com>
 <367cc748-d411-8cf8-ff95-07715c55e899@gmail.com>
 <20210914142419.GA32324@codemonkey.org.uk>
In-Reply-To: <20210914142419.GA32324@codemonkey.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: codemonkey.org.uk; dkim=none (message not signed)
 header.d=none;codemonkey.org.uk; dmarc=none action=none
 header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 597d7c1f-e052-406d-3943-08d977ad700e
x-ms-traffictypediagnostic: CO6PR11MB5635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR11MB56354D5EB606CE0B3A2D777CEFDA9@CO6PR11MB5635.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Q/2Jn/MKMhr08IXaNKmjM8F/Du3wSRkL9k5gg4WM/GElmQd2x8sA+Fd+RO/nBMlZm96yKOa1TTnU/EAccnl+dbx1G+WfHOVToaIqXQflzS5AlGIsMj5mXO3SMcrxaEMWDo6O796+m7sd4SsL5VsI/YO2fd5m224F+43RyV47kBj06PygwfF62MJHnU0ACTvN5e7oWJYeQe1J2x4ziROkbmaS1507NO1bfxwdFUcphJpMTjh5+fax/bm9oZuX1QXLdp95VySm9G6Dx31/A06p7UzgjXyHCAenB1IG86oBPr+NQrjaWHfKIfIrz4VZS39+9ZOukSQ+w54/uWAaKVpf8keyKZG8SNLmVKS6Ggza1Spah0y/9fDg3rRQs7Mcz3wU0Lz/h4uG1pZ4klYpKfrcGpVkuY/IYcPDq/gYCXimnTcKHW/4k5SdwKbOV4675HOjCKligTca0D2HrWTL87kTggQfCMPKKbRcxyJmT5p3kMJhYnsOsHX6QFaAU8WXvmKFSxPjUYo7D/oeLn6RPeNroHXL6TKOir8snTpIXmQtHTJ9fcV/vIZkQmflC1xEeM0t5b7LEyIpUa2qj6DdibSFJiRGxJppSVFVEw4LfDvkd/DacQ1ep4rX5BWhTjV9mmOArQqcUO57twMU4t1lhv/F+k+EWHEraehu5/p1vRSb/yX/VH8dxdBCTJhUWp29gBE3TVOcyXPajccEBDyHNE93g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5652.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(52536014)(86362001)(38100700002)(83380400001)(26005)(9686003)(55016002)(122000001)(478600001)(45080400002)(110136005)(5660300002)(316002)(7696005)(76116006)(186003)(6506007)(66476007)(8676002)(38070700005)(54906003)(53546011)(33656002)(66446008)(4326008)(66556008)(64756008)(8936002)(71200400001)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bi/mi5ZRuPO58EzTnMEeJq2vgoC2RM+SslYPhL9Z26kapphv0OXm2KQSfueY?=
 =?us-ascii?Q?B4gYzgOm9db2YIVYM+oD4THjboOO9Px8ekKJDwBQVetAo7bbyAurU8/7y2PT?=
 =?us-ascii?Q?p2wqZMZuxy3sKBsafPO8SYwpybQyQ8abMc7yXghkkaycA7b0alvTA9S6LK0P?=
 =?us-ascii?Q?o3nxdx+qEbxCPlLiHIy9iuINBKZ0sgnKIU8sk7xO05SBq5p9mAClndwrxQ4O?=
 =?us-ascii?Q?tsk2SPdVMwfwJvX9wTGCVTjGQS1wO3vnRjpINMlTMPF6GPpFEKwbRK3/w5aK?=
 =?us-ascii?Q?7zerP9od+1up2uHUziq2dOqd6Z9X2RUxMOHYsk99wPcXQUrv/gLxcjqFXImd?=
 =?us-ascii?Q?4ni2BNBGS92A1fKdpNsV+Dj7OUhdchMtRM2kB6xKlcI07WjoYYMpRBO/KxOW?=
 =?us-ascii?Q?Ne5TAyQ2S2Tk3wTg1gspA3mL9K0aHH4HlfSaWaT53mn+vxwHB9kAv7tXGehp?=
 =?us-ascii?Q?aUAulxe+v+WZALv35K2jMoQMzv+Q393+WKps+mg31etQL6ux5G7AixJfQkf2?=
 =?us-ascii?Q?+8bFZeg7F93TgFWFdRfDxhL82VM1DJ7OTViB3ZnTpe8kRRShxbuaa+7LW43g?=
 =?us-ascii?Q?puZVWtbyzYodPgJBPI5Li2GdiCBy9COONCcGzkWJ4EQPgZQmbkQKolCDkGh4?=
 =?us-ascii?Q?S3G7LUpu2OCHoWt0bNmc1RXIhwo64wOYbBl7E7p070ncDzvXBv7LHvt3fmAL?=
 =?us-ascii?Q?Mu6Rf4v1BhEAD1cqmy1711Aqk22O5qX52gkaqOujpmhv/Zb43ZxOjQmZ/nXZ?=
 =?us-ascii?Q?mQSYx+1LcSIk0mCj1F4K+KNKSFuFOQQrhK4QDDdw8mQ1LYR2T4ekfnQVcJmI?=
 =?us-ascii?Q?H4F3IM64SvJstrKz//wLJPgeW+QSw/i53iCv1I6LMu+vfF/8OWxWMxrebAtH?=
 =?us-ascii?Q?okD2CECHuWqtkXqtle8oxQAHcut4G+YzDKNtQknrm8Vs1DGEj3FKaeDp+/rK?=
 =?us-ascii?Q?HCC40KVGLWV0nzwqcGNLE+PRcSYgR1XBiJcUwhFoj7sdO8epWopHrzFwFlh1?=
 =?us-ascii?Q?68gDKUV9mJkgYlhuEjgNRfug55w0ZyRpkjaGPpaSkO8UJHXLgl77rNXz4Nyd?=
 =?us-ascii?Q?52ggmTDrv8sthhNKEcTdQoNGiqntaOVB9U6xJeRDY5M8A2MU0Y0441AIcdRD?=
 =?us-ascii?Q?bbXhyD72pMy4NQdpbaau0AQVesFHo/+l6C+/W8r6zcMK0ARuNrgMHd0EoI0B?=
 =?us-ascii?Q?RVv1LtsKuN7JJxvkNZJTGD2Ozh8pIBX/1nRQA3Z5PaPZny1Td/YBCtKzAmvD?=
 =?us-ascii?Q?/agjLFy5YLS83WWmigvN6TRbIhY0O5vvIJLX+k+U6PIyFjhnU4YHatg2nuar?=
 =?us-ascii?Q?l3nHJbZAseEpil9mJsw18PVo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5652.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597d7c1f-e052-406d-3943-08d977ad700e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 18:28:24.2116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cL5Btl394olnQFT3EijnAwiBT9DKuG3ZBjwn2fkO8ats/aSb8iFwca56qXotL1m0kxr8G4ch6qyxoRV87hLv3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5635
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Wow, I'm waiting for the hardware guy to look at this but this is an off-br=
and 10Gtek NIC from Amazon that just has nonsense data in the VPD as far as=
 I can tell (3's).

I'll let you know if I find out that the critical settings are bad, but I w=
ould just ignore any VPD errors.

Todd Fujinaka
Software Application Engineer
Ethernet Products Group
Intel Corporation
todd.fujinaka@intel.com

-----Original Message-----
From: Dave Jones <davej@codemonkey.org.uk>=20
Sent: Tuesday, September 14, 2021 7:24 AM
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <anth=
ony.l.nguyen@intel.com>; linux-pci@vger.kernel.org; Linux Kernel Mailing Li=
st <linux-kernel@vger.kernel.org>; intel-wired-lan <intel-wired-lan@lists.o=
suosl.org>; Bjorn Helgaas <bhelgaas@google.com>; Fujinaka, Todd <todd.fujin=
aka@intel.com>; Hisashi T Fujinaka <htodd@twofifty.com>
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue

On Tue, Sep 14, 2021 at 07:51:22AM +0200, Heiner Kallweit wrote:
=20
 > > Sorry to reply from my personal account. If I did it from my work  > >=
 account I'd be top-posting because of Outlook and that goes over like a  >=
 > lead balloon.
 > >
 > > Anyway, can you send us a dump of your eeprom using ethtool -e? You ca=
n  > > either send it via a bug on e1000.sourceforge.net or try sending it =
to  > > todd.fujinaka@intel.com  > >  > > The other thing is I'm wondering =
is what the subvendor device ID you  > > have is referring to because it's =
not in the pci database. Some ODMs  > > like getting creative with what the=
y put in the NVM.
 > >
 > > Todd Fujinaka (todd.fujinaka@intel.com)  >  > Thanks for the prompt re=
ply. Dave, could you please provide the requested  > information?

sent off-list.

	Dave
