Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915F719D1C6
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 10:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390461AbgDCIGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 04:06:31 -0400
Received: from mail-eopbgr1400092.outbound.protection.outlook.com ([40.107.140.92]:55228
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387849AbgDCIGa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 04:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTsM5q1dAGVMEJWEA7sgATm6UqWkfzsBNXPhIToTHQdmt4EnZQ/krifkS8RHOapvn156dDcoPnkKRvUTfGxe6TTKhE97nVkmknyGTvPGRA51TZ0MUFCUmCkfIH31OaNV+0vCOHTzqEMecdHr6EX9xa6IakL3VkPUUmiRMYPqwzBv7cdMhA1A2lRAp9loIBYfsq7DV0mmL6UZTdOeA3GbZwulM9lSZ7LHfSXDT3WMGyXdJCc93+GZcJEKh/cpZsSoASf6l4LlN4JsnNO65lxWEITIAA1UprMUq50dUEiwVfxeHXH+taqqKh/EEnuBQhObw5/fbEAVA7KJMKQlbVYWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iHNw+p9CFliqPw4gSClcSVJhGgbxb3uy6TZhYpqEbU=;
 b=ZMobhzB/rkPNNC9D0HmkGN3tTxMVXN2eRT3t04uDoak6tJtrFSu16SjLzB6U2puFXY+a3PaotyD2nt/UqGPiYw/vWXNwJB820z8fcY+qPauHWZ8gzk2emhoqCsXEFm519UhKGHvT9KGuE1wAUxxCox4WIja+5oFJ3LLrYkfptp/ZY4PpWD3cjOT4QSmzdo5iG8/DB+IjQxRKzrb0i1wWZ4FLYcmvrzTNMzzPJu+P8QYPTDABmew9ahPSCLm447Yc1ubhHOu4uifsVYtGQjY6ETVnanFCLswJ9vWx/nzXF5CrZM0MhfP9LGorZFjlNsq8WGXbiyvNgOalCjwz2YdFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iHNw+p9CFliqPw4gSClcSVJhGgbxb3uy6TZhYpqEbU=;
 b=m2NuhdsQC3+MuoyT0l58zu2+3vIb4gCgkbt2n2xZHvJoLi4WiR96CHZfp4w1tTPr8Z79iJmBlaa1WSwaLRPz/ixvSzOdskvM8/o7ZYeg0Ys9nBDTRwj+zCnlELCQG8DReTl97l+XZII022vmFRqhOjdvbbiuycrYWGcCeDVywvo=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4287.jpnprd01.prod.outlook.com (20.179.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 08:06:26 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 08:06:26 +0000
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
Subject: RE: [PATCH v6 04/11] PCI: rcar: Move shareable code to a common file
Thread-Topic: [PATCH v6 04/11] PCI: rcar: Move shareable code to a common file
Thread-Index: AQHWCSZoqgaKoB6XHkeyCAu/SQjsSKhnCvuQ
Date:   Fri, 3 Apr 2020 08:06:26 +0000
Message-ID: <TYAPR01MB45447612B5784FDF633FA327D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1585856319-4380-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50a35fff-a627-479d-1358-08d7d7a5e88f
x-ms-traffictypediagnostic: TYAPR01MB4287:|TYAPR01MB4287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB428700CC1832571D33516B41D8C70@TYAPR01MB4287.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4744005)(478600001)(4326008)(55016002)(7696005)(54906003)(316002)(186003)(71200400001)(5660300002)(110136005)(8676002)(86362001)(8936002)(64756008)(66446008)(66556008)(107886003)(81156014)(66476007)(2906002)(55236004)(26005)(9686003)(76116006)(52536014)(33656002)(66946007)(81166006)(6506007)(7416002)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PAWEiNWemXu5o4DcAwYDqdAQqTlxIrddMZlkXRZoM5nwRX04QP8zoTuOTdgyMwkDT9XFrekKm9+jnWuVqtdApKtGJMZCJcm8Yyy3DurKcEdQZNBJ/LsKk2qNIcMGJsmOZvt6XftJkdDvoGyF+ctsDS0tIfc29f5rpDLohXTH/NlckFL76aEQFPSemA1111WeVfuetIEVoSazuvPHU9SErFopbM+aiYokuYMZOyDUUXWiOghJfjQVkE6GwCsHrMgO1qYGtQR7vCyca28uoU/FfT2E0hMjeFnmdPfTwaaPucqX0bRA8IJxOiNKj6FC3B4OtlMcKct0CZlJ5jGj+eycfBF8beJ0gca8AZ47trjJoVq7IFn5n/lkFgr4UShzVPFP/nONsKd8zlzDS+9/WY0609K9s4AVRTUa5kUV9UjYQkCtv4j3ZKzKqQOQHWLkNQVj1OaVpfOOLJK4wyN45dOXW2wwdq2pylaWPeP5WNc24yJwD6N3FPELAeJWcR3f+yd
x-ms-exchange-antispam-messagedata: jZUkQhXqDwwtIDzgUNtGMFuPUKGqhfTlWgG4kgwsV0afxkzi5FRbOZqlAiCIo6+FhPqd+5Y9ZlvvklSVrur2cZJQvDCIPUtdu9Ti9tNV6b6UA0Z2dp+9yphCMejfT5uRkW+hGClMsgqVYf6zGZrnQw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a35fff-a627-479d-1358-08d7d7a5e88f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 08:06:26.5641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GP3nrgo0y6VMAVLZVlQ4glJBeEyjiGwA2uJvTJgVxTucqbUTKJB6V1VVFRZbG9RCom2zlMUH+Wm6pnpxnVJDtqBbfqsbzasbX20RRVAifYhBsQQF18BTKZCLRP/ES9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4287
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

> From: Lad Prabhakar, Sent: Friday, April 3, 2020 4:39 AM
>=20
> This patch moves sharable code to common file pcie-rcar.c and the #define=
s
> to pcie-rcar.h so that the common code can be reused with endpoint driver=
.
> There are no functional changes with this patch for the host controller
> driver.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

