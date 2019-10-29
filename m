Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D20E7DD4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 02:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfJ2BSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 21:18:11 -0400
Received: from mail-eopbgr1410133.outbound.protection.outlook.com ([40.107.141.133]:13696
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbfJ2BSL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 21:18:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8/HRZSuuL+L0BjcPuHx7D8KVYoLUtmJdLuXJexp518ige1pGsGixiE/2XQ4PMxooOqvH00Jx0m1jb3FdafUUf37ljLsHgeWdjt4hhnhYTLrHR4gsRw38mE8Jm1F1gz+G9/GqjPyBoKLR6mT9HdOaxHYS+JaQ8bi4m10RhMLeEh3lP9e9zA4x2O27yWduOhLy1mHz4nsI8d3yUDMP8s6BEaGFSiqImN2DbSwgo2FLDooIx6kl1x8jEOt3wSu4JjHE/gJ94Kq9NERDp8ycHCWI/VxDNMLhzrIn9Aa/sG/yvlKc7aWsNQ2V1oPM8JVnSXnvCF7UoSRS9iu0B2MYSrM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+VEgBQw27OueejMZPHxu4plaks/o8xMSia3WfEG6xo=;
 b=aO8eKrQFcSyaQH1+ESutRnBaR+1785zxBvEAPtKa9ehT+8i5M7ieFE4tofM5lplcubBVQ185Hu9SQr7tjvjYiRm7ldLU6aTAbFJP8xLxYQ9Qy+l9F5t+e2lsH2GIe/Liq6nsNgzePh95LHte5tG57uPLyQaop7IAQksZZ8ChHg9AfhDkaqXzvdTMJ4ak+5BwS3yPYFS5ei3oxWLh1JJtJpAsireW9CRb5Y+bx382aLeAgTEPgJ5/F3XxjyJh0MIQ2gAYCTwf6n+OeJyYTxIUklIQCxakBtVfwCqdiAdWH1qBjbxHvtXYcL6HMM3y1zNRumwMPMjW7pvlN3OW+fRvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+VEgBQw27OueejMZPHxu4plaks/o8xMSia3WfEG6xo=;
 b=EojwjouzSLvgsz6d7gqRiU2Z1D0lypSe0CTkD0aLZ0b4zdrFslmybUGBSuTS0raF1UQtXmV0kc7VyGOTF8OEVB+sUjfEpBjWjJ2X4i5TknCTpdkd70P5vXMXxc6qV2Fb5yELxJR432/v9Qxwwly6RjrugcfkiKgsGVQ9pj4T1Aw=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3295.jpnprd01.prod.outlook.com (20.177.102.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 01:18:04 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 01:18:04 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
Thread-Index: AQHVjCsJKpaGn6Kn8EmC1egFxu/pWadvudHAgAAglACAAPhiQA==
Date:   Tue, 29 Oct 2019 01:18:04 +0000
Message-ID: <TYAPR01MB4544E78D7F49E2A1F9C53103D8610@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191026182659.2390-1-marek.vasut@gmail.com>
 <20191026182659.2390-2-marek.vasut@gmail.com>
 <TYAPR01MB45441C49E8E4C33DDBB09071D8660@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20191028102048.GA4414@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191028102048.GA4414@e121166-lin.cambridge.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d99d94c6-4597-42fc-43df-08d75c0dd945
x-ms-traffictypediagnostic: TYAPR01MB3295:
x-microsoft-antispam-prvs: <TYAPR01MB32958793ED6C900DC8657F22D8610@TYAPR01MB3295.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(446003)(6436002)(6116002)(3846002)(25786009)(86362001)(9686003)(229853002)(55016002)(7696005)(52536014)(4326008)(71200400001)(478600001)(5660300002)(71190400001)(2501003)(8936002)(33656002)(6246003)(54906003)(81156014)(81166006)(76176011)(6506007)(14454004)(186003)(26005)(8676002)(110136005)(74316002)(7736002)(2906002)(66066001)(316002)(76116006)(66946007)(305945005)(66446008)(64756008)(66556008)(66476007)(102836004)(256004)(486006)(476003)(99286004)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3295;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 43nnvlFlwBd3YHN1ykBJ2d2R5JrmSihAr+sIAPSXeo6jMwEQe4ht/woJkGjCGlSwitgI52AuJog154GD5nA3LTi6AhbdnBBNJ65FYj6c09rNBKcbQ/Pm7rSXpVvFuACbKmRjbGdPQueGV7lBZGFcnXBBRY+YoqYJxj2aUVvLtUDZhwUQXsU7dxJZ18VdKw7WGBIhPeu1268eLWE8e2+JyVCTZA6O4F9PEvKPCZKvWsPtrVOeHrxXjonvex1uqyFYjuEI8v488IeLsJwtDttnG/3wkm4dfbQqUL2WOPGWRWLnMwnUAUItNeGmdmJWGZwgGbgBTWlK5zAUnyhD6wrcAI7oW1BWdf3ErHNjKixNLGDhfaVXKa/Rnn96VCD17ea1NbwhGj5Ak+UQSGoX9CItpQPcrDQZxWCVTpo3DKBM+erMB3yiSt9y3mP7L+kn4qTe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99d94c6-4597-42fc-43df-08d75c0dd945
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 01:18:04.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEQ1Bhdpwp5SVMCT7UHvipr/cHPFabTqG6zgukiFd8iKvcwTGXTjAdBELZf4S1xrmeRPnJzoLncZOQzDmj0U662W98MQgJnIkse8YlTNWl9NfUpTO2JvNoi7vMV1Q4V9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3295
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> From: Lorenzo Pieralisi, Sent: Monday, October 28, 2019 7:21 PM
>=20
> On Mon, Oct 28, 2019 at 08:35:32AM +0000, Yoshihiro Shimoda wrote:
> > Hi Marek-san.
> >
> > > From: Marek Vasut, Sent: Sunday, October 27, 2019 3:27 AM
> > >
> > > Due to hardware constraints, the size of each inbound range entry
> > > populated into the controller cannot be larger than the alignment
> > > of the entry's start address. Currently, the alignment for each
> > > "dma-ranges" inbound range is calculated only once for each range
> > > and the increment for programming the controller is also derived
> > > from it only once. Thus, a "dma-ranges" entry describing a memory
> > > at 0x48000000 and size 0x38000000 would lead to multiple controller
> > > entries, each 0x08000000 long.
> >
> > I added a debug code [1] and I confirmed that each entry is not 0x08000=
000 long [2].
> >
> > After fixed the commit log above,
>=20
> So what does this mean in practice ? Does it mean that the commit log is
> wrong or that the issue is not present as described, in the mainline
> code ?

I meant the commit log is wrong. In such the case, the multiple controller
entries has 3 kind of size like below.

> > +		dev_dbg(pcie->dev, "idx%d: 0x%016llx..0x%016llx -> 0x%016llx\n",
> > +			idx, cpu_addr, size, pci_addr);
<snip>
> > [    0.374771] rcar-pcie fe000000.pcie: idx0: 0x0000000048000000..0x000=
0000008000000 -> 0x0000000048000000

The first entry's size is 0x08000000.

> > [    0.374777] rcar-pcie fe000000.pcie: idx2: 0x0000000050000000..0x000=
0000010000000 -> 0x0000000050000000

The second one's size is 0x10000000.

> > [    0.374782] rcar-pcie fe000000.pcie: idx4: 0x0000000060000000..0x000=
0000020000000 -> 0x0000000060000000

The third one's size is 0x20000000.

> Please clarify and send a v5 accordingly.

Marek-san, would you send a v5 patch series?

Best regards,
Yoshihiro Shimoda

> Thanks,
> Lorenzo
>=20
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > And I tested on r8a7795-salvator-xs with my debug code. So,
> >
> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > ---
> > [1] Based on next-20191025 with this patch series:
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot=
/dts/renesas/r8a7795.dtsi
> > index fde6ec1..9bdd39e 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -2684,7 +2684,7 @@
> >  				0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> >  				0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> >  			/* Map all possible DDR as inbound ranges */
> > -			dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> > +			dma-ranges =3D <0x42000000 0 0x48000000 0 0x48000000 0 0x38000000>;
> >  			interrupts =3D <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> >  				<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> >  				<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> > diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controlle=
r/pcie-rcar.c
> > index 0dadccb..54ad977 100644
> > --- a/drivers/pci/controller/pcie-rcar.c
> > +++ b/drivers/pci/controller/pcie-rcar.c
> > @@ -11,6 +11,8 @@
> >   * Author: Phil Edworthy <phil.edworthy@renesas.com>
> >   */
> >
> > +#define DEBUG
> > +
> >  #include <linux/bitops.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > @@ -1054,6 +1056,8 @@ static int rcar_pcie_inbound_ranges(struct rcar_p=
cie *pcie,
> >  		mask =3D roundup_pow_of_two(size) - 1;
> >  		mask &=3D ~0xf;
> >
> > +		dev_dbg(pcie->dev, "idx%d: 0x%016llx..0x%016llx -> 0x%016llx\n",
> > +			idx, cpu_addr, size, pci_addr);
> >  		/*
> >  		 * Set up 64-bit inbound regions as the range parser doesn't
> >  		 * distinguish between 32 and 64-bit types.
> > ---
> > [2]
> > [    0.374771] rcar-pcie fe000000.pcie: idx0: 0x0000000048000000..0x000=
0000008000000 -> 0x0000000048000000
> > [    0.374777] rcar-pcie fe000000.pcie: idx2: 0x0000000050000000..0x000=
0000010000000 -> 0x0000000050000000
> > [    0.374782] rcar-pcie fe000000.pcie: idx4: 0x0000000060000000..0x000=
0000020000000 -> 0x0000000060000000
> > ---
> >
