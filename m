Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08F019D220
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 10:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbgDCI2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 04:28:08 -0400
Received: from mail-eopbgr1410092.outbound.protection.outlook.com ([40.107.141.92]:5216
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389015AbgDCI2H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 04:28:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXBvs5vDsLfYe7Y+vFTcptziEE5YbKLdTU7l3xUEIY5TDkUVgUvkQOFwRRB0wOOo+adnWV5iVKpfleSOpU22RTq6klJqSsMFiaUD+GGWB3p+rlARrWDSm1RSUdRzbbWXo/gXKdQnoa5hjmhBH56yLRePN2m9uV3/Y+p4NJkSJcTa/jQjFiVNpT4To6Jw+PnwTbUm1WeQQBB+3mkA9bN4G5ORMANl0nO3ZUChqG7QZE9/j1Q69AdAicMo0VEk68eY3ZzIeTz9mfzlBZODtjn58hWOrjy4AE3fEtoSkvjFVzLCa2+FCtEgIco5mC+wCOOidNVOhD5JwL9m7QLJ5k557g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+kqWT7sY2OORnmbgt5Cxr5xhozwMaZLXa8dE6EXMtc=;
 b=NrenoDN6/OGKR+Xy/qA1QGLTtNqIqKXVw/EY1TYFLTg6tCzvRJcmvBBlt6uXzCZOp7xZJ2XLEOPMUyY1d8x8LthfP3M0FfpL4/4XWBAxlrHZhCJm8XZwuVEexczffpomgVHxAVdsXaRvq9DwyzVGWcvZo6SpxzaQuf5qOzQ3HxrRghcL4jIC2QGRK4ZLLZGKRNsL12Js8Ik50FeSMRH9BYvMVnaht6CS/zEYdIThbx1aVH0lRiZBV2OhfSzryg9n+FHyHWJ+24oTXvN5vWn2+TkL0rBm14nICsUh0JPj2xEY7PuUgIaVKGXlA3jWDIurj7yKhttCc9Q+xJ1dCh+3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+kqWT7sY2OORnmbgt5Cxr5xhozwMaZLXa8dE6EXMtc=;
 b=pLB+r/kD0vkBKwGZJjaTYSKTVDrV7rv+Al2BOhsgE2Y+o2nvjVkR6nPM04eYECklwMLxrKMbFriNwOlp3WIXJ9BbBkouUt/5m8HENslXlQ6r3hGlRB1DJ6k5aexrzp//CO1Wc/jqfBEG+RddybT8n/5yCDYn4Zji66iep+N7M4A=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2816.jpnprd01.prod.outlook.com (20.177.102.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 08:28:04 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 08:28:04 +0000
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
Subject: RE: [PATCH v6 07/11] dt-bindings: PCI: rcar: Add bindings for R-Car
 PCIe endpoint controller
Thread-Topic: [PATCH v6 07/11] dt-bindings: PCI: rcar: Add bindings for R-Car
 PCIe endpoint controller
Thread-Index: AQHWCSZ3yJsyf9f5C02jBKuKwy/M6ahnD+3A
Date:   Fri, 3 Apr 2020 08:28:04 +0000
Message-ID: <TYAPR01MB4544E4658654491BECD7561AD8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1585856319-4380-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8a580e0-2783-4a0f-e89b-08d7d7a8ee1d
x-ms-traffictypediagnostic: TYAPR01MB2816:|TYAPR01MB2816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2816320A1C33F13A2B36485BD8C70@TYAPR01MB2816.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(54906003)(52536014)(478600001)(107886003)(110136005)(186003)(55016002)(86362001)(26005)(4326008)(316002)(55236004)(6506007)(71200400001)(7696005)(966005)(76116006)(8676002)(9686003)(66476007)(81166006)(33656002)(64756008)(66556008)(81156014)(5660300002)(2906002)(8936002)(7416002)(66946007)(66446008)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Z6QBiZDsHWmDDshjZOuSKXVv7RF4J6oSFOB1gLhajn8N97RQ0oWmwK7xpFQsmm9d4ZVl6loKoHdlSzU2bxdy+WLygne7jyP9FWGyCM0/4VD9SsIflnCvcI1UAYkfZbPmdZRSd/ZArORTl36FmWo/fcJVBFuwBhyLSvJcIcwZ1UadpHXemcMQxUXVtHClRonHGF60HbEt6IEbPdgXqHEz+Qig/cATiS9YWB+WNX0let+AqMLQ/ltNtIZs5sU2IedfJpKCLI/QBaP8ian77Rub+aHrfzuLUJtK+fH6PQtgmTYWr2Cx28Swc7I6veipU8lDQ/dtSTPPo5ZMT345jr+d6HUrYp3uQMdPvqiRTgyJIOVw708cPVcQz/jqmbLGJBiS15UV7ukQHaIGyCVa/nnBg/lYW/eKWWK/FmfC5iioHoSz7ikWbmbyXmukowv7bqkgSWMWKgaXwZ68yaLuhJhBDx6CDO7zbtkBOhXoHMhOdFhGUIRxlGP+G9S7UBDrZKU3cNKX/hguZHFI182GFvBBctLcx02+zgFiLYJXosuLYWMUq/fg4CHejp8rgOJe58DS3Ymeqfy8doWoCVzIBa7VA==
x-ms-exchange-antispam-messagedata: /3BZFq29NVF8wFDQneYsxSdTsMUkO5owxNWWXjsD0PR/bjoFqg60BWton0a1nqVXqsHGPLF59qQaRzhYmkoEIlzojWvrZiE6JTnezg30dAfAoK1awFu2kapuL1MfJcQh6UtQokATL5BR1OsJkzH3PA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a580e0-2783-4a0f-e89b-08d7d7a8ee1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 08:28:04.2581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kqbwr3ti0PXE2ujCGrEVh9SpLDUdlpykgCnFq0R3O0yA0Sx0AaHGmEDwFH0tx1Z+udMZnLKx9v7jZ3nK1n+G02VcGixSF+sb7Z9Olq4lVxmUZMDAK5Hw/hPefNES342j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2816
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

Thank you for your patch!

> From: Lad Prabhakar, Sent: Friday, April 3, 2020 4:39 AM
<snip>
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> new file mode 100644
> index 000000000000..07cd5a7325d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0

I'm sorry I should have mentioned in the previous review.
This is better like the following.

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

https://patchwork.kernel.org/patch/11459267/#23246825

<snip>
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
> +    #include <dt-bindings/power/r8a774c0-sysc.h>
> +
> +     pcie0_ep: pcie-ep@fe000000 {
> +            compatible =3D "renesas,r8a774c0-pcie-ep",
> +                         "renesas,rcar-gen3-pcie-ep";
> +            reg =3D <0 0xfe000000 0 0x80000>,
> +                  <0x0 0xfe100000 0 0x100000>,
> +                  <0x0 0xfe200000 0 0x200000>,
> +                  <0x0 0x30000000 0 0x8000000>,
> +                  <0x0 0x38000000 0 0x8000000>;

Examples are built with #{address,size}-cells =3D <1>, so

            reg =3D <0xfe000000 0x80000>,
                  <0xfe100000 0x100000>,
                  <0xfe200000 0x200000>,
                  <0x30000000 0x8000000>,
                  <0x38000000 0x8000000>;

https://patchwork.kernel.org/patch/11459267/#23246825

Best regards,
Yoshihiro Shimoda

