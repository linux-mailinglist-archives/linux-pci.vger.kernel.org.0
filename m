Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8042333C5B4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhCOSc5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 14:32:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:17802 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhCOSck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 14:32:40 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FIWDRs011999;
        Mon, 15 Mar 2021 11:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=4ChAqI6FUCHaLWewUFlrtQVsExPncQX/LVzTd9xfBHA=;
 b=Pfo4neU/bdbKWrfj689tiJqqGMlvbbsqjs5LC1rdAH0S2d9MBZVa1t22ZVDjx9KX9Kpo
 RcSxK79Fm/EBoYIPKkM+G2+a3uHqfmt4YNSeXfdNhPdCHTrmNrRGFejz3Y+1d+V6JIqD
 02wxygGNQvlx/yyD/UV+/7dDkB9/WgeYDEf41WFal/GVhu1YdrtctDnhd85mUaRgg2H1
 vXHgiu+1eLLXHv+3k5SaLnIpTruDMqMje2yiwf6yRLTAxaajMUtF4EOzRTrASpT6T+4s
 JOrajToAE9zZQoIMCWMUyBuHnjXtW9bCclI8uybpS55ebHyUEqiddJ7FU/ghsW8O29kC YQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-002c1b01.pphosted.com with ESMTP id 378vcq4c8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 11:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7/YaJFwrlqC8seceMjhX4e+FFZHrJqe+VATOrYevzY8B//t3AfH3wjvKYCJxUFdvs0wcFCtimUEH6ht1uNmZuMs8SEiucx5SnhCp3fBMMNVS7C6PTTqyEZNr6M8Hy8QbNEKMTnh56a3f3kICuWCvz70mh6BDMd5+J3oIUM57qinqagVe/TjfIjHm7UXHg27IO139flRDPTApmt/2NljRpywGbQ7TP9rhoNJEMC3I1LJvDbjAD2HLp9IGVVgAHeeCacSSUbnrkhICT54aywU4Fie0F2dSabNA+f4gOCojRUX9yVGtbn303lYPZZpG3JuwJehxAV2LmGy27TFxr/Gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ChAqI6FUCHaLWewUFlrtQVsExPncQX/LVzTd9xfBHA=;
 b=AWr4Y1Xs8CPfgXmZWGgjAYcUJJlxENAn42A6xdqJVccebtt0pLuSNYFb4XWdvKGP1RkYu3S1AUl3/QaOq4UJMi890lTPJp/W41eqpmflCW9qXCkcxzInSGtk6CIkkUBXcicFXx5OAAsgI3WKV4k94p3z88AHTGgNxqioiYAdeEV5fzEzhS/cgodS5hUy5zGlhkwNt6W9DKwLIjk+ocBA57QUYbEPoxoj2Ps1idhwQZwxQkRTaFrHXs/C3v0kfR+zCOroh2zivEO6qi3Y8TVKEzXLQYlrOf73NFQdOuPMIYh+Pk6BvPEZapiUWLQmCEWMhEEsThBxjzR5qvlDNpW5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN6PR02MB4111.namprd02.prod.outlook.com (2603:10b6:805:2d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:32:33 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:32:33 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alay Shah <alay.shah@nutanix.com>,
        Suresh Gumpula <suresh.gumpula@nutanix.com>,
        Shyam Rajendran <shyam.rajendran@nutanix.com>,
        Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Thread-Topic: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Thread-Index: AQHXF2ZMYtuGPNuUOUiLwgvTDmOeEqqELEyAgADnPYCAAAKHAIAAC6iAgAAJPgCAAAdkgIAAD7AAgAAiQQA=
Date:   Mon, 15 Mar 2021 18:32:32 +0000
Message-ID: <20210315183226.GA14801@raphael-debian-dev>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
 <20210315135226.avwmnhkfsgof6ihw@pali>
 <20210315083409.08b1359b@x1.home.shazbot.org> <YE94InPHLWmOaH/b@unreal>
 <20210315153341.miip637z35mwv7fv@archlinux>
 <20210315102950.230de1d6@x1.home.shazbot.org>
In-Reply-To: <20210315102950.230de1d6@x1.home.shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [24.165.18.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdf43914-8441-47ba-2c6d-08d8e7e0b2ca
x-ms-traffictypediagnostic: SN6PR02MB4111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB41111FE58066E1F514885291EA6C9@SN6PR02MB4111.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPkylJcNQ5yG/Mi49wYD65ZTJu3QIxRojW/FRY3t+8FSvyyhtm9gizJrBNJ/45jq6/33pt8xbLPNX76BzXMTDCHCLoLiR6tzNksqfhtfoByVsRxugQ2jI9DROYjXMrqu6J9QCGuMG0GvnmKbpSlOkiuNsD0far5zQacWqYCKzEvfYNtkZXtPyP0WLIS//ipnanei47P8g5B19FVekGUs5Q20EJNk7PRszuGjFLiU4AGv6ZKQQCOb2UKWNfb9DyNXrGck1MAXvpEorUAbowvl0jTieF+M9sCEZBczpPEPHyO3aNmMTDDwADJz6OlapgLJAdlB9Zsf/yO6o0xjpLt8tk1HlsTHMdx2mIp2rZ24dP01bulVGJs2xSJ+2gshuyIwwcxctKETMgOoyRdpsLrD1WXdv4i5OleIPihB9IZeoLYsnnX8vP0ihAuKoOtviWALs0RApLiImS9R8L+KpoMaSabV5GGXk4eEreklW4xfBFdkuYdcUFpZBUBvU9CruUtxqEPzlcy6sfP4hxoZcAtpr+UqRRMRbxtjVqecX4VCT/DBsBNsB6o6o67ic/mDcYckDeqMNWT8b5ZAlqwWbmL7M8X9jPItbf2BIUOjaPbz941OE0W+pVn8HqTPSQrGzx0wxxTpVKasLtuqCJpcZuHisw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(346002)(136003)(396003)(376002)(39860400002)(66574015)(83380400001)(86362001)(33656002)(6512007)(6916009)(1076003)(5660300002)(66556008)(316002)(2906002)(64756008)(71200400001)(966005)(478600001)(186003)(6486002)(66476007)(44832011)(66446008)(26005)(107886003)(8936002)(6506007)(66946007)(76116006)(8676002)(9686003)(4326008)(54906003)(33716001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?wrtwpqebhlaWOzqWSetTc5XxiIjyiYipiNFiSWLtxviYMdSLet71iSrQIn?=
 =?iso-8859-1?Q?VqT8UlRzwu9MgIY9pP95uAxKUDSM12Vc3uDE2SVA1rlQJmdlF6dwEUkv+e?=
 =?iso-8859-1?Q?mEpALl7xTyv0Tpswhg2w90/wi7ERZ56FBTJYtJskoXwtFuwJR8hCcJHeq6?=
 =?iso-8859-1?Q?zDNoMG94/8twO5gbb87sdhN/aqvfGrZgK4oV8Er4XN81Lwb+rVu1+Ka2/2?=
 =?iso-8859-1?Q?NF6bGOQUbpxcegUN9u7iw6V2GmmuAsxiVt21hz2H1ueS/51lLMA2m0d4Xg?=
 =?iso-8859-1?Q?GaAR6vhDwl1d8SRacQLgYOoHwPuc8SbUEDODVRzLeV8iJ40fGR0IGP0ROg?=
 =?iso-8859-1?Q?hgRtKKtLjkuswfR6X+uHltZwTQAQOAOV3e7IIX5tnPmNRIgh0IPr7vTkAN?=
 =?iso-8859-1?Q?fztOpOfwdvVs3eWkp7d0W7hg6Bg2nUY64zHlzS57uyOrFiobpRutaeH1yO?=
 =?iso-8859-1?Q?hdDlCf7FVLeKGFrTmNsS9isTa2sxrwz3fYUd6xtElpKfHJZDp5N7UTv9sw?=
 =?iso-8859-1?Q?4BnlzIWL6+jJNOwTkX7R9c1aCECsBnpr2x9Xzh4vVeUJzZXUvi6AhK1LNb?=
 =?iso-8859-1?Q?Mo5w9Kjo4lqbTfs9EYDHTK620bpt1jprGSPD0zOFBEI1QCbJtI7WOupLES?=
 =?iso-8859-1?Q?aBZDM3QJdH1jzXDAxzgtMzMPUrr4N+DI9GTFtnrP0EzErRrJxhjMpaVCYE?=
 =?iso-8859-1?Q?BjbTf+b40ubm5QYlUnHJsKomuR+W6WsiWYvrXTRj+/nQbvLj4RQaRxKM/e?=
 =?iso-8859-1?Q?i1RcpVtyeFdV8Av6qlskklgHmp2rtqNLKUdp4jqj99Oh8yC3rCiFoM9aBt?=
 =?iso-8859-1?Q?C3PcOGEeE6xxAunN656kMOFGreCKke+tfVp/zqdBAWmvC2s/LMWd9ws7Il?=
 =?iso-8859-1?Q?MVv2STAJmTuyPJi7TzsrJ74Y8tuA/DKWhuCPTvVlsy0EspXRqWZQBuBBbT?=
 =?iso-8859-1?Q?y4eXvHfpqMNono8/milXo9oz1ZAR6Vt7o7+MhN22CQGp6xeoWENm1hzmjg?=
 =?iso-8859-1?Q?nFXSwzPp2qlT3INVkzHaAPEB49RThlBcficaKGLgfwHqg6/T0jD75VV1z1?=
 =?iso-8859-1?Q?huFiq08IlnQ3HqUaFfOhy5H2DlTub67LDR5xtwIkD4o7WVXgMiRN0CYhRk?=
 =?iso-8859-1?Q?Mc51osjfzgWKOT0TCV6EWbMyY2uFGDv3PSP5dZPun6YqKmj0+2/5CJyAU8?=
 =?iso-8859-1?Q?uPmob3G4/w//gKADE12oP2R8rlf+jMmHtzsBSUMoWvnj9gQ0UYrH9NrgH0?=
 =?iso-8859-1?Q?GTNCXgMGTJFWitAUZ1iqqDkBZHSUFbi7cw0QqzQvGkms+tQBzG2RK60q6D?=
 =?iso-8859-1?Q?PcqPfWrXysrPjhAJSGtW+0znehS1K5+Kxotf2uIHNgCZJeNRVUAmU5UCnW?=
 =?iso-8859-1?Q?xy44TVGT6M?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2AE6A70E8C58EE4AB152A17B003ABFFB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf43914-8441-47ba-2c6d-08d8e7e0b2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 18:32:32.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7hHqTL8aWASzurxqGe+3t4qcTxdkdHok4IBO9MSavb8KevM6F+825neX1Z/CO6Eo4PTk3E0EtWPqRkeohVZPkW7StsPV46fTo+mFi+5Zhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4111
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_11:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 15, 2021 at 10:29:50AM -0600, Alex Williamson wrote:
> On Mon, 15 Mar 2021 21:03:41 +0530
> Amey Narkhede <ameynarkhede03@gmail.com> wrote:
>=20
> > On 21/03/15 05:07PM, Leon Romanovsky wrote:
> > > On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote: =20
> > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > Pali Roh=E1r <pali@kernel.org> wrote:
> > > > =20
> > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote: =20
> > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > warm reset respectively. =20
> > > > >
> > > > > No. PCI secondary bus reset =3D PCIe Hot Reset. Slot reset is jus=
t another
> > > > > type of reset, which is currently implemented only for PCIe hot p=
lug
> > > > > bridges and for PowerPC PowerNV platform and it just call PCI sec=
ondary
> > > > > bus reset with some other hook. PCIe Warm Reset does not have API=
 in
> > > > > kernel and therefore drivers do not export this type of reset via=
 any
> > > > > kernel function (yet). =20
> > > >
> > > > Warm reset is beyond the scope of this series, but could be impleme=
nted
> > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > defined here.  Note that with this series the resets available thro=
ugh
> > > > pci_reset_function() and the per device reset attribute is sysfs re=
main
> > > > exactly the same as they are currently.  The bus and slot reset
> > > > methods used here are limited to devices where only a single functi=
on is
> > > > affected by the reset, therefore it is not like the patch you propo=
sed
> > > > which performed a reset irrespective of the downstream devices.  Th=
is
> > > > series only enables selection of the existing methods.  Thanks, =20
> > >
> > > Alex,
> > >
> > > I asked the patch author here [1], but didn't get any response, maybe
> > > you can answer me. What is the use case scenario for this functionali=
ty?
> > >
> > > Thanks
> > >
> > > [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal/=20
> > > =20
> > Sorry for not responding immediately. There were some buggy wifi cards
> > which needed FLR explicitly not sure if that behavior is fixed in
> > drivers. Also there is use a case at Nutanix but the engineer who
> > is involved is on PTO that is why I did not respond immediately as
> > I don't know the details yet.
>=20
> And more generally, devices continue to have reset issues and we
> impose a fixed priority in our ordering.  We can and probably should
> continue to quirk devices when we find broken resets so that we have
> the best default behavior, but it's currently not easy for an end user
> to experiment, ie. this reset works, that one doesn't.  We might also
> have platform issues where a given reset works better on a certain
> platform.  Exposing a way to test these things might lead to better
> quirks.  In the case I think Pali was looking for, they wanted a
> mechanism to force a bus reset, if this was in reference to a single
> function device, this could be accomplished by setting a priority for
> that mechanism, which would translate to not only the sysfs reset
> attribute, but also the reset mechanism used by vfio-pci.  Thanks,
>=20
> Alex
>

To confirm from our end - we have seen many such instances where default
reset methods have not worked well on our platform. Debugging these
issues is painful in practice, and this interface would make it far
easier.

Having an interface like this would also help us better communicate the
issues we find with upstream. Allowing others to more easily test our
(or other entities') findings should give better visibility into
which issues apply to the device in general and which are platform
specific. In disambiguating the former from the latter, we should be
able to better quirk devices for everyone, and in the latter cases, this
interface allows for a safer and more elegant solution than any of the
current alternatives.

CC Alay, Suresh, Shyam and Felipe in case they have anything to add.
