Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CED24FCD2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 13:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHXLgr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 07:36:47 -0400
Received: from mail-eopbgr1400130.outbound.protection.outlook.com ([40.107.140.130]:13696
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbgHXLgA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 07:36:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ9KwdboSR3AmnNWXttHOo4DAm20Ab8jZu3uWeDev+D4/UNJV07yLYaDuS9Qts9uiGv8iEa37VCn9kwVmUyRRqhLx2SuvHJdySwT7gmQqMUkpcBUM+zFi0k2CAaMVfMenUZkjtAndUeOMeo+uqRsGto6rUzcT1GRr01p1e3V9QSOgwNX/2pvx6z/ZydfoL0MqJZiDGT/i3qLAYyTntl0+3UaSXhWlB4c9mGAKNdVgdK+FrtUHpvtSXYCy06TIRhs2DWcVrkk1st9dJQx0BjM7Q/n/9jTLodJxFVLCHmlQXuky+sAw4BMRh00VKmwJ0fBP37eLIqnJiqy4EAEAGU8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTNKgN/48GvUqERfgyYHUU094eeLnn8elfIgl0FJpJo=;
 b=AAZ4KYd6jmwOVQcfN367MqE8q0baPkl6RcLhNJx+I3Z9A5vwUALRJhwYEqCusYggQGVJTdJUmv3HX/jW4tmm2dFZfA9gn4ZZeE9uZv31rdD2Vb+LE3KRF6CAeBv6COPu71RkpbOlVmIzjxsF4VLub0+z8VLk7ZM1/vsEjt7OP67E3AYkEztVf2XaBQJjI/EsFSM5yh+RIMrpB9XiP61E1oJLSdFU0lwCJV0EmmNb+BIuOqnc5YhghuwKoNygI1AmRHsw2+pRyprIYuNbJ3BPLl4SyUHL+thgxOC0Rk+wc/GyhADeq6U3pgdTege62mzc4s/bjmfHQum+seCOxU+BWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTNKgN/48GvUqERfgyYHUU094eeLnn8elfIgl0FJpJo=;
 b=MHSTdM0xEofn6a208scJXqpjwQHH0EKbuC32DUsh8NV4cdFRw/JCM1L9rBN8spNs8ezUmSRrDMix0jzK9M7mUmZl5/MdVNFs2LioDqS2Ofoq9zs5IrId3QbV4/dLOgMIJj1pjDXJFnh6x0SRVKDSktW3bDUZdbvhIv0xt2RP1k0=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYXPR01MB1550.jpnprd01.prod.outlook.com (2603:1096:403:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 11:35:56 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 11:35:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 1/5] dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and
 r8a774b1
Thread-Topic: [PATCH 1/5] dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and
 r8a774b1
Thread-Index: AQHWcmDcJvg+g1OZekuouK9eHA4EtKlHMBgA
Date:   Mon, 24 Aug 2020 11:35:56 +0000
Message-ID: <TY2PR01MB36924E483AD458BB5DA2F0A1D8560@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200814173037.17822-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200814173037.17822-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none;bp.renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c6e3267-89d9-40a5-d6bc-08d84821ddef
x-ms-traffictypediagnostic: TYXPR01MB1550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYXPR01MB15501C0AA121F21C393F2FE4D8560@TYXPR01MB1550.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o151cMKDY3E1XvdL9/Dk1+k/p9zoE6fx6fLQRhfwtufnqK4eQ7YF6SLQXA6Lrpmn+7e0B6Yr7b7V2sWht3FIUnoOAIuhnffZxkVcRy52el6cC7APhfUShoHPRgD2ufJwShvtuuZ/Qwcb8QaMGyQTjafMXvGTI5RRCAP+DLUwa1v6Seg97uMIoeDAlIvYPvVdPqbC7M45o1zkjWNM0daI6//y7fnrMF2AsTkK4R7oQP0jBXeyGIHaVOExWZ8DVVkq6isucWmK+kN+8T63of9Cpc0sdvYl0hgYmJClSAAiXW57850HHNFd29gpfpPDIdCz0Nw858Wv4rJ+v8U/eVro9UpGT87dOq523m3ygnGdGwbmm+lEj5sYCbpJhhZVqOCf31I8SI1VTUyZwZyhTLcaN8HztUBBI6t3Fme8KfsL1Rw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(7416002)(86362001)(186003)(4744005)(478600001)(26005)(71200400001)(107886003)(5660300002)(52536014)(55236004)(316002)(33656002)(6506007)(4326008)(9686003)(7696005)(66446008)(64756008)(66476007)(76116006)(66946007)(2906002)(110136005)(66556008)(54906003)(55016002)(8936002)(8676002)(138113003)(98903001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vZd2xeIi/qAGLhK3E9ZTft2UOWIT5NdzC9VadLP0dGsVTtVVRB1XstHhIE/MuidWqZBSlgv/7WNVJTnXRcY1o01SolFrjp+qT4C+OVl4JtFYCqTtBMy0UqWWmTNxX2wDac7UwBL0bwDsSTE/NgPNI9zm+AnV4Zh5uF8W5IxX5Av/T7ZV0NUEwkdSygLIlDnFrofl37ocpqV4Zz7YZfCLr6jocS0ui4OelNnDnXE0evj2G7Ox2DEbG+g02Zymcp6xKfdPdYY8M/wm/g28zdYmvHYcwLZSAbVBmljntKgQV4nMuBjjc2MV6qgNQ1Lu4RDqUk8ZG9sejLq+/6pYPmsen5APpbXtmsuuoYOCXFoYw8PZmqyFqcORUmsztHa9dVyK7WW5bH+5NOudTC9fKINgicRxy/lL2MlnIDstbi4t45N308z+Pi9BltbMWLigmSPAV1s+5ivP5jqySCaEbzTbVdu6JUTmpEEQFM0z9HbnW6FRwzouBSM5Y/afHde2zy3hxX3rqeCKJ9TkouehlxgyuE2A+YDuQ0pmJDmBnZBWkkwtgFS0D3q7uPKsBvklW0KKfVE/qkplHR5Yg+hxb+68JdSxpx+9lc1SDnXyGCH04OXYV48/5xlkgyxQxqr+KQ7qurb7rcTT37NOXXWoeVpVVw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6e3267-89d9-40a5-d6bc-08d84821ddef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 11:35:56.6039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRdjyQKRxjpda8srvb7qEJrwFiKrZ0Gb00KADLnpPUNXQjAbJ7nrZrhQg9WVfaINOrpqtfVc5kCIwFOdTBu1dCBl3hnCXOPH/i/O4LU/ypRNVtzr3QWMo4RfVgTSl8ur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1550
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lad-san,

> From: Lad Prabhakar, Sent: Saturday, August 15, 2020 2:31 AM
>=20
> Document the support for R-Car PCIe EP on R8A774A1 and R8A774B1 SoC
> devices.
>=20
> Also constify "renesas,rcar-gen3-pcie-ep" so that it can be used as
> fallback compatible string for R-Car Gen3 and RZ/G2 devices as the
> PCIe module is identical.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

