Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E42245F47
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHQIUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 04:20:05 -0400
Received: from mail-eopbgr1320120.outbound.protection.outlook.com ([40.107.132.120]:37025
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728070AbgHQIUA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 04:20:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KckMiAoip/bcxOm1+QSevZ6xOxTq2dYuE0XV+4E6CVR3zu2iiMket4LYmz8zGd6YSpvNs0QOMPIuSfN5iXaCoB1LHE7HNhmpOJHMDs8+jszwCIDtr3QBsXrLh8DoK6kKAbPynj7mRDDGqx0EgWnOQJaRVqCbcjhdoORfXxKZxOCB78u4g1C6qnYX16Z8GJJMhJ8HW3YxDlWIn4yavhfrxvAxNrGqKRlIdus6c/NZ3PkPNaR+AVaU02XlNsY/paCiKa+e6M8RXiueQPqolPi0cdLiwjTK2exRPPKWiWynAEJeAj9moXwbBeeOdWBbU2dEF/gdfzwogBe/88bkbpzqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3A0XgXaTt47xmLgoP9TFmSw7SIzmXa4aI5UoH17RO4=;
 b=PQ3ThirWYx7vnt/f9aSFNSeHpwGhszrzJlCXy/g8+laKMW52dTcmICXKsoHfiJXhmggGahF6NV1AJAxxEoGcLBlJZwI9e9n68CU4xw4UL0vqFtOdZNgMTr2hEj+kBE4d9O6avPihf7AQH3CcfI3IBWKFL5tIB2Mh24g/p4KUmI/cWW9YAOg2uTHCFh/y0Gl4k53x+ACllD3jsGodiReJ3PDEGdntNAs2SxFxUp4JwTRwUThEceYuWgsAvWQXSFDi90iwGQIkXgJRpzgi0AlEqXxePlEvsuCX+YdHGjPoyYD3FtM9dtVEhY1V5+YpIt8YQ/UJ/SnpFuhy6zJJh5Cwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3A0XgXaTt47xmLgoP9TFmSw7SIzmXa4aI5UoH17RO4=;
 b=hFTZ/eiTa8FzdMuITOqd87It5ke+3w0dxeFyi7+DMWWeBkIMWVnvFps6l7GMduM2Lz+7j4BIfhkHraRQU+lCkunyJn4kRMV8uwrajKP0AkNxW6HpXpgbIaOMMBNLpg4761O2Fo+j2t9EZfWczZXdcZZqNHLJSmulJSpcRQ88VR8=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4218.jpnprd01.prod.outlook.com (2603:1096:404:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 08:19:55 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 08:19:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: rcar: Add device tree support for
 r8a7742
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: rcar: Add device tree support for
 r8a7742
Thread-Index: AQHWbz2YLmmvYoZWOUiLDevVqH8RSKk7/6GA
Date:   Mon, 17 Aug 2020 08:19:55 +0000
Message-ID: <TY2PR01MB369230866CBF6D701B48AFE1D85F0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20200810174156.30880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200810174156.30880-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200810174156.30880-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none;bp.renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:3806:c8ab:968a:d05d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b01d0f51-e83e-45b8-de94-08d842865308
x-ms-traffictypediagnostic: TY2PR01MB4218:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB421877B1B0B462A8B2AA469CD85F0@TY2PR01MB4218.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0qyHwU7LOMDCS6KrWR5rvJgnom3cSCaUnHc/XF/vnd6CfIvemHKJZ+f8Mraxmhd/qufjfsQYgzNH6Su+LfTF0Seu1KDAOejR8YawWKwrnuIJItYcujS9oOrKCr19RbW/ZVoGKpH77Hga+MhsISced6A7yyhEY/BepJy1YJC1UT31FhPiTLnFCEe2m6Q7jpevLc64yobPcKFVU77B6Tr8srb/paTlY4GsMVf8zXq4Hr1DzQj4aCTDLFGwkeKX/c7xm2yc+RnzylG5ay4/Hb9qq8cV4oEI7nlCEUOiL0RqcS+segMWZHJutYQC4pd05Nd5TUpx+/CHao0ge0yU3/4iBwx/u2dH2Oah46MiLrFxCZlo3iv21a2FGds47X0yuss
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(7696005)(9686003)(2906002)(55016002)(52536014)(66446008)(66946007)(64756008)(66556008)(66476007)(86362001)(110136005)(6506007)(316002)(76116006)(71200400001)(4326008)(7416002)(8936002)(4744005)(5660300002)(478600001)(33656002)(107886003)(8676002)(186003)(54906003)(138113003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: E8H9IfzAcq/MUXqGxxR5fwdq5rsOkQTkyx+o3ebhWo/p0UIGbb3ieChUQYPHLW3jjVndhuRbnLxl6HDkVVfUoJzygPk08sC8LLTr6cC3QRLl3aM/RB0sL+dFtpEWk8mkczoN+4uaIJPszqQGUTBQxBdRxfrGIzSpMGS7daYKMyQ0QwbITUmWOJbSopAPtkdf3WvPQptk0RUrkcQLo5+wZd4ngibuT9KI8P61U/XzR7CuG7Ou/B0eg2nmIdSr4Ceesb7J/QZjuW64oc28vxZt+sI8DSHoYEDJAW5ChF5PMImCpy+uqkAV6+jqnGAu9NqS8qX0x/s3lpv9PYrfwUtALtC7FUeNnqdnxLnLGMuIYQ1rbPKrfAgP3FgZBTdeofO1VxkdkJhXtbEllM3ERlS4oqB3jna57vb/u41PrVFaxAKMnle4esNRRsdbjkpukPflGmd/0J/YikvQrb7iRmQx0Yp/OTgWR+5ZZ+896A/BeALP7+EsH8ln/CVwftVSNcLtN+Rt/FNp2nGrIvouNwABqqAqWgovFdPX4unpo4PUfMRCaCOyREFgBa9LWxDg4TAE/RU2JmU69a2GhCrbOdg8o3s7HvTbEnmOPZUzJpY3lv1duwRdqZxVcTRuGOpOeZ8QVfg/m5nekr/4j59eVfrB0bojELn1xQr7ttponXf78YxlyrLn8kUHq9KiCwQTLxvJdljtCweDGbvNxn6p5LsxvQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01d0f51-e83e-45b8-de94-08d842865308
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 08:19:55.8046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5x6FWC8RF/HO7N1T8whHMe15602epF87KjfvyK20J8tJTULcFA/84D4sw+KtH06wg0RBuZuEkJ31uDTGlQRRC5J4lRN74Se+VUBaARVSsUAs7i9oH6kqbdQ0ruFvchVp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4218
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lad-san,

> From: Lad Prabhakar, Sent: Tuesday, August 11, 2020 2:42 AM
>=20
> Add support for r8a7742. The Renesas RZ/G1H (R8A7742) PCIe controller
> is identical to the R-Car Gen2 family.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Thank you for your patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

