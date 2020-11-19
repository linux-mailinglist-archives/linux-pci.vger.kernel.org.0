Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD81A2B91AB
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 12:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKSLqL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 06:46:11 -0500
Received: from mail-eopbgr1400092.outbound.protection.outlook.com ([40.107.140.92]:44966
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbgKSLmf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6oYpmS2E5brYM9manjeHRHBv18pg5Yy1YLRz3+24h9U+z6Z+LiDpVFnDsLXplb5PiHaNPDbY4/49wzuo13ihcu+Ohas3X6LKko4lWLrdO+c2/CT/lagBKIaVTXGx46h1nmlZQhiUNPjY8i30dBx/pB3G/CU8BHNYd+Stq4txYUVbI6CMnXmaaF7YRNr/zdtAZx3pVIBMxyxtexj+wm+uhsQTBo2//j0u9YesKpMo1e2ee03dHbbzSHIXlGouwnpF2zafWnXzUybdJZbz+c3uyhHGUM66dRYZbDFahb8CVrjM38wvycKFwJIpQ9GnAAhmSthRFs/W5aLj2NA6o93/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx+9crcR1hUY90O9OOYReFLhBdSpbsxeiup0jJIBal4=;
 b=YGaJIx94kvnbJFdDTNdwofAiHNbqenW1ITuNVymZFzThsIVlH7sD8GzPpZS18SRWj79UpfgCjiMTBxx/g3NpFj9uQAbxlrMCYAO1MqZqc+jceCERRm90YvAtqMDWHR01uKAjMKAtoJh8fFUsSm0/jy+2kRlViQeJKgkN6IxyD7GLSRumxcU6PDDHXcALgwkxiOHPfHZG//Q/KxknjIGrKO0po8acryNFe9PZaOYjHaPoBesfWcSsnwvhePQlsvHli6dw/hGAia9LOVsMGca8FlqqywQppJbPSAP/gj2pkNEnIGB7eNRmpXVyn2Ps3yjMTECjKCOJ4anY+4BEvUYg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx+9crcR1hUY90O9OOYReFLhBdSpbsxeiup0jJIBal4=;
 b=cvGU+9VasvQuViL4MKohVHfV58XXfqgPU87Bq1n072Y4kT9yZ7th0/gMaQ24kIA6oNqr6aY2KUphLezkMbPEkE0Yp1u4YiRTGIUsy0rRSNnxcAdL9knubg5V/SVBS3zt1DovU3uF0bxmNnuFBxalHZGbqmhj1HtzWBTkZlhhM5w=
Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB2133.jpnprd01.prod.outlook.com (2603:1096:603:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 19 Nov
 2020 11:42:30 +0000
Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3564.028; Thu, 19 Nov 2020
 11:42:29 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: RE: [RESEND PATCH] dt-bindings: pci: rcar-pci: Add device tree
 support for r8a774e1
Thread-Topic: [RESEND PATCH] dt-bindings: pci: rcar-pci: Add device tree
 support for r8a774e1
Thread-Index: AQHWlMvG73dvfwpbB0y9YXB+NCxAsqnPpDwAgAAB7fA=
Date:   Thu, 19 Nov 2020 11:42:28 +0000
Message-ID: <OSBPR01MB5048C92810F7C37C8C29D3ABAAE00@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20200927124257.29612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201119112708.GB19942@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201119112708.GB19942@e121166-lin.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ea7abde-145a-438b-2fc3-08d88c803238
x-ms-traffictypediagnostic: OSBPR01MB2133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2133174A06D89FA228AEE871AAE00@OSBPR01MB2133.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7SHOpUJ4EvflG04r3U5odrMzG3LQuTF47sp3DUua/KqvrlI6kkMTwvJwfjFsjghdmvt/Uwc3S21DSnYtGtaSyeZxxojjYDsgeMP0H9OK148il/kiXG/in+FRh5o4aj3se6OCs2Bluh3xb6BuM5zF6B10VLt7GK1YS9+Dkez2x5Yuqsy+6aJGGEDwNqaSN5L7LrzY2MM40QXxnZHKiidaG4E6XrSH1c1Rg5DtoYqB3EyOhUFvMLPV+kHCocvSan0zKKmlOWwJqmfbheijXldiuIRbDFw+jT/2OiQbCoMZGzn+haZfi4SnpZbruotuL6NFXoxqU87WgRi1xZsP0PzjFLcN/x8gLi6243O5xDl4MhDEm5n3mSjiZ6yFCytq+k1KBZnKfAPWskmGpsxMOw0ozlAjdTOC2hJBcZr2v/ARRmOXbq+1AfipJDJuGgGAl6Lfr0gg4KJKWW1SJtKfG8OhS+Pat1n6QmlmHO1QrTNdKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB5048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(6916009)(64756008)(66476007)(76116006)(45080400002)(478600001)(7696005)(2906002)(26005)(52536014)(5660300002)(66556008)(33656002)(55016002)(9686003)(316002)(71200400001)(4326008)(86362001)(83380400001)(66946007)(8676002)(186003)(966005)(53546011)(6506007)(66446008)(8936002)(54906003)(138113003)(98903001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t30CNkaIju4AMwo0HuxXfLNEXZX9OhyXp5LeVoFrcT5FUsk6GL93BMg3OlXXpHrC7e0g8d8N2pYpeBeGIgBDAMsjO0dmxVSIH5WIO/w9jvXgPycw7huNZu6V8CN8drvnGHK4Z42UEoFbTm757vSzU197GwtnrN+npm6o8AgSjZ7xgSICW+7PXdnti0OZPNUOXiCxxVsFLNaqHF29nrUfijsHHtsr+s8UjdYptglQSnhyy08RXR76oH81BvzZrSZrW1I3RXA6QmKvdcIEXAg8rImrzbNxidAQYPPfiWY7RtXxDMCJS8jS15UI7yNuzo5c6GSZFYmbhpsZiuihiIJYF/UeARGgRf5bB59mYr/2QGmTzyq82OojeeGRIeh0kvggIhK0kDSTXGoscZo+dUox77gHFIpQxdGjAf8hXgE4Cp+1UdakxiXcxsiZHS2tEICsPwWU/UQBwvC6L7iW/e0Yy1nfRTRB9sscRL1KgS7rYyD6VU4UYH+gOkxTsZKqdDIRdEcOvGWgGsaUylnuHMPV6w6aqfh1T3k3OAMRpJqHCewUWZT0ld0NihaplkuwmRO8Jte9cw3Ot1USUeNUlVKDgpwldCDO1P/gVbwZbTUGa/2QPXAnn4lF0lNcfwvK0fK2+bF/xg8QGm0hVszBqEyv4Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea7abde-145a-438b-2fc3-08d88c803238
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 11:42:28.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzUCmi0nP7nA0Qz4eOP5i1GTP5lW5G0ouyjE72cMMdhrluYUJ15mPFnbq0uoO7DdE65KYuDd/JYiZThWiz/7TaFi3jymlsuu3lZKoCqvuasxl8o3f3iR5a0yBiYvxmp2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2133
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: 19 November 2020 11:27
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Marek Vasut <marek.vasut+renesas=
@gmail.com>; Yoshihiro
> Shimoda <yoshihiro.shimoda.uh@renesas.com>; Rob Herring <robh+dt@kernel.o=
rg>; linux-
> pci@vger.kernel.org; linux-renesas-soc@vger.kernel.org; devicetree@vger.k=
ernel.org; linux-
> kernel@vger.kernel.org; Prabhakar <prabhakar.csengg@gmail.com>
> Subject: Re: [RESEND PATCH] dt-bindings: pci: rcar-pci: Add device tree s=
upport for r8a774e1
>=20
> On Sun, Sep 27, 2020 at 01:42:57PM +0100, Lad Prabhakar wrote:
> > Add PCIe support for the RZ/G2H (a.k.a. R8A774E1).
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.ren=
esas.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> > Hi Lorenzo,
> >
> > This patch is part of series [1] and is Acked the DT maintainers,
> > while rest of the patches have been picked up by the respective
> > maintainers, could you please pick this patch.
>=20
> I can, is this still pending (I think so but wanted to check) ?
>=20
Yes this is still pending, but said that Shimoda-san has included this patc=
h as part of yaml conversion changes [1] (patch 3/3 [2]). So this patch can=
 be dropped now.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D3=
76991
[2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/1604455096=
-13923-4-git-send-email-yoshihiro.shimoda.uh@renesas.com/

Cheers,
Prabhakar

> Thanks,
> Lorenzo
>=20
> >
> > [1]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.s=
pinics.net%2Flists%2Fdmaengine%
> 2Fmsg22971.html&amp;data=3D04%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7Cb002fec313bb47d4ee1a08d88c7e1067%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C637413820368345804%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C1000&amp;sdata=3D0Az8f4QOfBLnlogN1p2IMrVi6%2FSE3fbIJmSosv3%2F=
oUU%3D&amp;reserved=3D0
> >
> > Cheers,
> > Prabhakar
> > ---
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > index 14d307deff06..8e495d6811a0 100644
> > --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > @@ -7,6 +7,7 @@ compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
> >  	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
> >  	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
> >  	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
> > +	    "renesas,pcie-r8a774e1" for the R8A774E1 SoC;
> >  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
> >  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> >  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
> > --
> > 2.17.1
> >
