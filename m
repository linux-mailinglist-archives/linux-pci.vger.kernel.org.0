Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2745119D29D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgDCIrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 04:47:21 -0400
Received: from mail-eopbgr1400090.outbound.protection.outlook.com ([40.107.140.90]:17952
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727868AbgDCIrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 04:47:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtiOsg1piuYRPBrsW8OhW2xVuVrZWUb8NVq4WjRrpO0rg2aNJnZ3p0UIDhuV4pCWbvJXC03szzDJnCZ0BlTYf6be0+n/UcOqok5wpFp6zJ80/p4nK6pIpA/RI2m2GFmBMCUYy/svAM/p7SfYD20ujHCFs6a9AzGQ2bsCiDgbfN8bCAx36Z+nlLWRt1lDTWfYhAdRx9QHcnD+ObTYuee4QKGOou9Z+NJHGBqmOgeaTci2y75gruFljj17eKFMyZF6auxrz5h+PelB35nudrb0tzYqucWCbFHXfcIr/IovbW8lF23hmDVDKBiMklEGf6FmamG37ewPvV2QBaFXC30Oyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sZRwYyi6CB5KCPTu2VlcIBOdXJhY/X4vDQ3vWKlj/c=;
 b=VdPYSEE/PmrUo2v/QJuCHKNVE54jRthpsq9PXYG9a4DUBWWR0yLXOLCUmqoZQGDlsuAqQPLSooytqvv7c8oFSd6CMJ8anf8/4px4yRvQwmOjkjLLtMGuGpmgeg0ywUHWIO1lZRHF5NSDZgivSLcR8i4okc6c3sDYyzK5QDhC6vHOIQcE2p/CiLVRvRdG+CQdDsCsKPEfhSTNuN9ce3Qs7WlXnsdznA1swx7uwxmoNYyJ1Vtts87rZQwgYY7PqUsYPIgMePNBCRLR7j0R5XjXWIVF1uuqNg69YjQlDke4IkaBpsVecZBV9/U0JkQafHBLoSTki+vo3jdGleMigb4W4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sZRwYyi6CB5KCPTu2VlcIBOdXJhY/X4vDQ3vWKlj/c=;
 b=dXFL7cOHJXZdEhtmxrWvJLkX5k1qPJ12a6AwH+625xOqS8uDJZhinyiTDsAIBmIkPWjxme9XcS/9Zw6Od2dxEXwt3KIVSNOOiCMGMWbI2W+ynEayMNxQDB9POO+1wkLwvqxZLCFDuYK4EJW3kIA9fYaeJkCLxMJyjf8h9vdkcjI=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4958.jpnprd01.prod.outlook.com (20.179.186.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 08:47:17 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 08:47:17 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v6 10/11] misc: pci_endpoint_test: Add Device ID for
 RZ/G2E PCIe controller
Thread-Topic: [PATCH v6 10/11] misc: pci_endpoint_test: Add Device ID for
 RZ/G2E PCIe controller
Thread-Index: AQHWCSaDHFuBR5APEUOnfN9AQ/j4U6hnFldQ
Date:   Fri, 3 Apr 2020 08:47:17 +0000
Message-ID: <TYAPR01MB4544AD255EAE19DAB03D7AF7D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1585856319-4380-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58a30e51-4480-40ed-5e35-08d7d7ab9d42
x-ms-traffictypediagnostic: TYAPR01MB4958:|TYAPR01MB4958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB4958B9373993248AD8744BA1D8C70@TYAPR01MB4958.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(55236004)(110136005)(107886003)(5660300002)(7696005)(2906002)(8676002)(186003)(9686003)(4744005)(86362001)(71200400001)(81166006)(66476007)(64756008)(76116006)(54906003)(4326008)(66446008)(6506007)(8936002)(55016002)(66556008)(81156014)(316002)(66946007)(33656002)(52536014)(7416002)(478600001)(26005)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RO/mK7ATHWy4D9M0zglf124i2risfIH7ssSsYfWLpO3m+5wDyENuz1VDGnOYnKh9IowMAzBdo8Jt90Sntl0l9Z5eC1DlQIUDYjs2V7H+Rxx6qtueF54mljh3Dgrz8ZZzTluzIaeA3DmOJqH0GjuGv8d0vgQQ3SSUcuDv/R7YX0298z042g+yUmjpI6v2r1pNjup69906mDNN2FVeHbt4vdRPEveUJTgyeDsZHiL1n3L44Mhke96d/3IwQW+3dOJwKtCEyb6xtgfHZEa23f5CSvwGwTT+5GHCHj6NB37j34Q4Mv3YTLQEIu4dr/WKAfTI7q+NHY2fgsVYskVFnNPoZh0RXROcVBaSVeOrpFr4jrYkYXezQ5Kyp7UOdtm6qoqkv2VI4NXvXCxHqSobvlrFbJ6QTRzOcXzeuFrmdnegqXckP279G+rEcisO6jMWrZ0J33nOpy42eNMtJgf3c3y/tE5YWZTXztllocRrDQ3BIyZDVbnWir0tv1ynySQaiLrA
x-ms-exchange-antispam-messagedata: gfdpACcKiW+MWfCdfa8uX6AEjd3Udx9aDKtqnkylfO4Sp7KSei8Unyqf06mm0YalO5Wmv5Gr24nuB7Glv1UJpmyQ4Zyt747yy0e9jY/+w5opdWoZXHTA/tYCJjR8W8bxYu9oM1MRTRo3V/IfrFT6RA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a30e51-4480-40ed-5e35-08d7d7ab9d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 08:47:17.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsN+qyC7975f1d+kF/AuKhWLCFzlRndqbHwTLIzfs8awkJabt9U7muewhvhCIPODNWTyya9rxxQ6nkdE8ER5Rbp7UowkuQ+9+3WSM7x+e8Lc0rmhkoP6iKtWWt+3T2Pw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4958
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

> From: Lad Prabhakar, Sent: Friday, April 3, 2020 4:39 AM
>=20
> Add Renesas R8A774C0 in pci_device_id table so that pci-epf-test can be
> used for testing PCIe EP on RZ/G2E.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

