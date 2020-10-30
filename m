Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7A29FCCC
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 05:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgJ3EqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 00:46:17 -0400
Received: from mail-eopbgr1400121.outbound.protection.outlook.com ([40.107.140.121]:38448
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbgJ3EqR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 00:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MisLRynt8WSCFfXulEqDKQZilwQkzmn/KE+SRsfN/tL5o8XhXM3byuTQusBZh6d2CQvOfyHczS4F0C/L2E1vaHooRFzVng9IHgZ7wjVk/7B62GzbO49jNay0zKsFvbazHttar4XLyUpztKGL1jlOMT7QsUPaRRSGBV/vw9hGYxxAidUP96a6HzseC08Rc/XHbLuS06kBrMe/noGy/kXS1QGP92CHec1+F9+GJzefW0z/9jm5kWUnl3o1QTDamE45yEnrRaUj89vVK5Yu+c3fKitimOhCF4ySd2FtK4fEb7xR/6l0HV6XplQKbLZmM79lfvfhDHuK7nCl7kSqwzlOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDoBiVs0eWrlkJVRk5gg+Dc8D7jnQp6dpQzIJj4XSJ0=;
 b=OI+BFD7R/+FHEa3ncRrDju8SbXW0ASd02IInAMtCTdfY7vRkEpb5YGFc/0l+9JxJySXHOdtlErNrow0GpZ1zddpJBCCHT2eGBumdaD+CC7B/W9MwBORWC7+xmInKrz+MR6Rq9J6LjtvOufxhV9g8PVdqFsLV6ns0JbWC0oENFHwHGDkvVKg1BtU6RkTyoalbt2gbesKycYxZ3r0fM+le8AE37WwOV3oqercPQ3qrXQN95fjHNXVedNXYN4zMVrLAm9l4q2bnfh6n3Z8wTgZY2RfrHe0sg6brfziqxZ0wTMU6NRmOKTvkGuNOr4Ug66SXyrO5ZchsFOLDOuF2UU6/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDoBiVs0eWrlkJVRk5gg+Dc8D7jnQp6dpQzIJj4XSJ0=;
 b=T4Ace2xNvQsyPqEQBSDrP4srg+cBKcJ5qG8l0HpnTjAlhYqgG4vOL7NNYaYTlMmf7zO/ti4xbNlT/yUfpeLDzc/4PAYsQarVdyttZF8u/dnth6ppucHYa7ih1AWigzEnJjp4N1T2vJPfHbS9O4VdkDlimVSCCbAblt2l0YsBwa8=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB2223.jpnprd01.prod.outlook.com (2603:1096:404:6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Fri, 30 Oct
 2020 04:46:12 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883%4]) with mapi id 15.20.3477.028; Fri, 30 Oct 2020
 04:46:12 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: pci: rcar-pci-host: convert bindings to
 json-schema
Thread-Topic: [PATCH 1/3] dt-bindings: pci: rcar-pci-host: convert bindings to
 json-schema
Thread-Index: AQHWrM7jGTlGJy1Xq0qXxgEFYj7a+6mtGCWAgAJ57QA=
Date:   Fri, 30 Oct 2020 04:46:12 +0000
Message-ID: <TY2PR01MB3692F8530E52FA9332166D11D8150@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1603850751-32762-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20201028144447.GA3994930@bogus>
In-Reply-To: <20201028144447.GA3994930@bogus>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:1d1:f583:fc3b:d64f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53557737-8619-4dcc-7f97-08d87c8eba5b
x-ms-traffictypediagnostic: TYAPR01MB2223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2223BD635E46C6B9401B975FD8150@TYAPR01MB2223.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kAd+dljgQvJDsbi82smG7ZE52RDj0g3dP6vI/I01jLMOC1lQ/cH6gRCHPfRcwc8A2oDv+ozIrJKEkkaL4I/TZ3bL5uuKct5/G/E3D8tPsDYExY9Li1xZZS231f2BBE6sNEXiT5syoP9WACzMWS9DnqWUdDhPznEKBIM+IG/yRPC/Pnw+eG5rQ/x5voVcEtDQnLpMLOZmuhnnam/6y3DakJQ8y3QLDhwa5y95+CzZGiNItQgu/Bp3olxff+z797hm8LCORCwKqj2G5W/7ozlwjwChE+jAAhtI+xLb0EfmxF58Xfvv6XhjgrWv9bmQ+j6pXxsVF4PgnN73YftkTkp21yr270HNAxd96zEMN3o9ThOweCm9KaMXPjLomO7EKnHsNapa6Evk79CG4BuyJgWsyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(66446008)(71200400001)(5660300002)(76116006)(4326008)(2906002)(66476007)(64756008)(66556008)(66946007)(86362001)(316002)(54906003)(52536014)(83380400001)(6506007)(8676002)(7696005)(8936002)(9686003)(186003)(966005)(33656002)(478600001)(6916009)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YVGgZg2CSx1MmN+Y+nq97BJl0D+HiKIsUTuBSvA+cSoYYmQaBNPNslOT+PPtVqETA5DdQtDGgSnQtcIGGmHCWGl+iBdZUUP56Xk8fZli3bbyTXTSWW289Jg3bY6TDp31v7vkcu1c2gHDmH9cRn9XzDiAap56znJl17RCPGHcmrU8hOrsAAqWGa3Qgfe8OCSDuJZGa9nKdSYQR0TcTljeJDZb1O+7QIlYba01wtYu9SO+iaZAH6hEPnUBJO/ARuBR4lFzHSC3QEDZgbyiVO+M/FdynxZIxn/+Gb/fTWg6OFZzXIEBvuZpCp6lcWqRXCh8IAl9h/JUVxA1hf1rDl5GCm022uQkeWuSUSrbhNP3243r2uUJHjVqPiJ4X2vuFBOXOrg/zlqf5qPvfBlD4J6IsQ1GwFhnmfgh5NMA04lI7nPK/xSVBJodFC61l8SDOASjQFwXgcGidmvpzyO/EFbmGZ1cHm8UmRzYZlMuQo5YK6OlS2q+phnwItZhuVJMsNXFvdVD2MFQTieLlTWF9fGeFmAuw6EvinRIWOjMo+20pafjPQhOhALmwG/WSr3qRFp6eiSChMQwPkkbbDH32Z8ieYnWDnhJNqwG9yxthOHYaGu4cCEts9VGrQ2zjRTV4E85mhEy7mjXWLPbUYd9fbY9nyES1MkKFS5a6+04vlY9YLUG+s0msArgdZCbwGxrPGpEoA8iYAxWwu4SYsmISKRlVg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53557737-8619-4dcc-7f97-08d87c8eba5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 04:46:12.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKr/LdsRK4FfNmQhTJFnOGBrMgXlbMY/+8mFeQvm9ppbru1Jmc89u5dJqjKSghy6PU2qweNCetrz/O8jKp1zo9Vf3E9/MmlflmQ5G2A5wfcvte1kwaOUUxstZFW2ShCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2223
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

> From: Rob Herring, Sent: Wednesday, October 28, 2020 11:45 PM
>=20
> On Wed, 28 Oct 2020 11:05:49 +0900, Yoshihiro Shimoda wrote:
> > Convert Renesas PCIe Host controller bindings documentation to
> > json-schema. Note that some compatible doesn't contain on
> > the original documantation so that incremental patches are required
> > for it.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../devicetree/bindings/pci/rcar-pci-host.yaml     | 146 +++++++++++++=
++++++++
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 ----------
> >  2 files changed, 146 insertions(+), 72 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host=
.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> >
>=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/rcar-pci-host.yaml:18:9: [warning=
] wrong indentation: expected 10 but found 8
> (indentation)
> ./Documentation/devicetree/bindings/pci/rcar-pci-host.yaml:27:9: [warning=
] wrong indentation: expected 10 but found 8
> (indentation)
>=20
> dtschema/dtc warnings/errors:
>=20
>=20
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1603850751=
-32762-2-git-send-email-yoshihiro.shimoda.uh@renesas.com/
>=20
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

Thank you for the information. I already ran 'make dt_binding_check',
but didn't install yamllint so I didn't see the errors.
I'll fix it.

Best regards,
Yoshihiro Shimoda

