Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F3E865C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 12:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfJ2LMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 07:12:37 -0400
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:32409
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727453AbfJ2LMg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 07:12:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6DOCc4t39ifsNzpwGg0x40cFuxTmx/LDEc3+K8YVeekmFbAW5kQEi7dnf5WvNB1AmONXQVE6mQx9P4D7p10n4VtSTJ7lb76zmLl8HT0juojLP37ogJ8dlNlXxAS/LyPDZB3doXy7/G6RP4Tjdkid/1RS2ONecCxpPtT3bjS8JvlEVlKJ/n+KVnbHk4nc6WwjDwV0qVDL4hq3TqKFlGJEnF7c+JTaP4rLGamaGGjUj4ix0Y5jCXhLyQ7H9eeh0Ykbg3IOc6geICvgvbsuFgDRHxd1UcEFKxm49LLUv0IEanKcf2Y6oQ9Ke0j7uDphqhu2iQQziB46pc9423A1Jye4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk1puDQ4/RIeb+eljSWUNM2oCyk3QVzuvZqhL/1HzA4=;
 b=m19nELDL3bifWTg4+iKvdE4FYmEizj68/lnkRgESF3dtf5mu08L2tcMS8tQV1ziGSGU4YBbS20i4kr8ui29Xl0efUbkdLS/2DakwBvsVRBqBSe6ydv308D2ScW8HOQCtVCouwD/vJoj99cvVRSBS6BWKhuvJGrfmfYUguGdu0VytQu3y13/HOFQN37nbEKxTJE7MNVGozDeLsUAq+ui51+j8ZgHCPu7fFIzhNudVsZJkl18MO1cCMTOwARR3KF8K/0xNbPprPSlx6VuTr+tOUYrkw2AtXsrU2hOzIp2fl1fBpn9Z1MmNNwVMGwcsvGOHPdp2coBP4dxeKfryWjwxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk1puDQ4/RIeb+eljSWUNM2oCyk3QVzuvZqhL/1HzA4=;
 b=rImlMELNgCPzmUBwMPZG7u2y8NDZB9L2GlKM4opIMLZqkS+yWBOT1QTEG/01NtZVpplF+3PH8Em2bsUOr6hj0SL2t0S8Zl02GpYaC6yt5ovGSzvCwXo9TCroLiZ2p6I+e0EOM6PnFzN9Icz1lnaUoYGxePG0IPqcOYB4dB0iI0k=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3597.jpnprd01.prod.outlook.com (20.178.140.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Tue, 29 Oct 2019 11:12:32 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 11:12:32 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH V4 2/2] PCI: rcar: Recalculate inbound range alignment for
 each controller entry
Thread-Topic: [PATCH V4 2/2] PCI: rcar: Recalculate inbound range alignment
 for each controller entry
Thread-Index: AQHVjCsJKpaGn6Kn8EmC1egFxu/pWadvudHAgAAglACAAPhiQIAAneEAgAAImKA=
Date:   Tue, 29 Oct 2019 11:12:32 +0000
Message-ID: <TYAPR01MB45442DBF6F1308E693DC2274D8610@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191026182659.2390-1-marek.vasut@gmail.com>
 <20191026182659.2390-2-marek.vasut@gmail.com>
 <TYAPR01MB45441C49E8E4C33DDBB09071D8660@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20191028102048.GA4414@e121166-lin.cambridge.arm.com>
 <TYAPR01MB4544E78D7F49E2A1F9C53103D8610@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20191029103452.GA27171@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191029103452.GA27171@e121166-lin.cambridge.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6ddb4ef-b10c-40db-adb8-08d75c60e516
x-ms-traffictypediagnostic: TYAPR01MB3597:
x-microsoft-antispam-prvs: <TYAPR01MB3597777DFDA419F752BA9890D8610@TYAPR01MB3597.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(189003)(199004)(3846002)(66556008)(25786009)(8676002)(26005)(7736002)(66066001)(305945005)(4326008)(8936002)(9686003)(74316002)(6506007)(2906002)(6436002)(102836004)(486006)(186003)(6116002)(55016002)(478600001)(229853002)(6246003)(6916009)(14454004)(66476007)(54906003)(33656002)(5660300002)(99286004)(316002)(86362001)(81166006)(256004)(7696005)(76176011)(476003)(446003)(71190400001)(11346002)(71200400001)(64756008)(52536014)(66946007)(66446008)(76116006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3597;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WYdFjUa4hQUg83SsY/y0D77fgK+awzSpfdE76Qelg2bxtyv9TyZrE/fz41x0rDJgtxRUX5OHA5WxBhJ45cXREewKbWOMoAa0wBgjW5nkIfJAXACOPANUVHvk7iMz17LqrcgkymR49mgr0rPImROHm549NdOjdlKinzR8u2HkiFCqpMj95+m2eYB6XXcruKtbjRfZBGOej+dzhDrD2zPekwe9mM5mc72G7JKIy4HyKKA2udmd4bht5w+qeUmpzNRWve5dnYOBvIFVHEwX1XxctWtzH5fBKz6lSdRAjd0EwZAakbHLnpoB/HJ6Ji/4/MvMWH1KnGJxZzjTkuzyLUKHiih8Ne5CSutWfsgfwXlhR7aGs5ihByTFNBdF3iHh4gk+U5j208zyBxfxxn/OnOG6q9NBcXNWZUjvybUk0al4iifZo53aZ8jjUOEzKTmY+Y73
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ddb4ef-b10c-40db-adb8-08d75c60e516
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:12:32.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dd2agaiVYWR5JWNya0uIKi+LaVTklPD/bdEQhnjOoMFWNNy6HK8JE7x0fJ/sOVagy6wrilOqRfgH63BWBmj9tq/tqgjH41EbnUT22gDQ3VOMAEIz3tsuEoH03kLHmL1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3597
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> From: Lorenzo Pieralisi, Sent: Tuesday, October 29, 2019 7:35 PM
>=20
> On Tue, Oct 29, 2019 at 01:18:04AM +0000, Yoshihiro Shimoda wrote:
> > Hi Lorenzo,
> >
> > > From: Lorenzo Pieralisi, Sent: Monday, October 28, 2019 7:21 PM
> > >
> > > On Mon, Oct 28, 2019 at 08:35:32AM +0000, Yoshihiro Shimoda wrote:
> > > > Hi Marek-san.
> > > >
> > > > > From: Marek Vasut, Sent: Sunday, October 27, 2019 3:27 AM
> > > > >
> > > > > Due to hardware constraints, the size of each inbound range entry
> > > > > populated into the controller cannot be larger than the alignment
> > > > > of the entry's start address. Currently, the alignment for each
> > > > > "dma-ranges" inbound range is calculated only once for each range
> > > > > and the increment for programming the controller is also derived
> > > > > from it only once. Thus, a "dma-ranges" entry describing a memory
> > > > > at 0x48000000 and size 0x38000000 would lead to multiple controll=
er
> > > > > entries, each 0x08000000 long.
> > > >
> > > > I added a debug code [1] and I confirmed that each entry is not 0x0=
8000000 long [2].
> > > >
> > > > After fixed the commit log above,
> > >
> > > So what does this mean in practice ? Does it mean that the commit log=
 is
> > > wrong or that the issue is not present as described, in the mainline
> > > code ?
> >
> > I meant the commit log is wrong. In such the case, the multiple control=
ler
> > entries has 3 kind of size like below.
>=20
> OK, that's confusing. The commit log is describing the issue it is
> fixing and you are reporting that's not what happens in practice, so in
> short my question is, is it possible to describe the issue you
> are fixing with an example representative of what's happening and
> explaining why we need to apply this patch please ?

I'm very sorry, I completely misunderstood the original commit description.
I misunderstood "each 0x08000000 log" was a behavior of after we applied
this patch...

So, the description is no problem. In other words, we don't need to fix
any description on this patch.

Best regards,
Yoshihiro Shimoda

