Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D4187B1C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 09:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgCQI0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 04:26:07 -0400
Received: from mail-eopbgr1400123.outbound.protection.outlook.com ([40.107.140.123]:26816
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgCQI0H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 04:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKlyewpyvE9GtjntPtFDSAmOg9Dt7R857VqxRBkVf1WHk3pAhDb9M6C0IbYxE3cMJ1VDUvePk09EXAJURBRYNU6KIaowqx5GIWvx4E3y/wwX9OQgisSFAoy8Ryzr8QMA7OWkh8GCF1pI3GTmqaJSpbgBI1OCb+j0WzJL/Eza5TDtn7l/wmITpnSqwAqUaSj8DqMCT6uTG0N9ihg1sceTjefrkEShhnMzflxKcBQatLRBdtIymLKgWLZBMIx//I/sbBZ/+Q1PFfjlZdNnyLIjy3v6byuUs77R8dpljd50YSJk4QG8rlua7DGpazX0QOncyoHTizsDlMWgm9pi6FEuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPmcOlrb+yKUg/weZuB9bCyL075WJYW3h6SzJ8jlSIk=;
 b=WGlJ8ZmwsbLq5axrJwKgbOagtPeVXEDrR76XfvKHT+mXUL5mKnfMAiEdNDuCpMp4vDHXiLxfbKL4w86fCcMX2Z9PXZLQaq8rB3AKVSizwhWWi6yqOZZ4u19V7MXGfWf42eS8G9bY6PyPU19gFVhC7ylzfuiox46CsfoTeNJP48nl8zkzOQbRX1FUQEmHIZJ3B65n6Tfaapr5IV63m/JlBL9sLnvBEm+VkhyGUBQyR+UsLPaalVMzDlsbr33DyKh3mLYtFwV11JjYI04CAGEXq24id9Me2BIGNtXn5OsuL/p6MYktbn+Si40hMdvsxtpftAaIj0DvFP2T/0rKXUmk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPmcOlrb+yKUg/weZuB9bCyL075WJYW3h6SzJ8jlSIk=;
 b=Fs497W/R9O9rc8yQL1NiWI/xDXB1fCqswlATrATmnG+lJlq0Lj9UiFXEYeXblDV6h4c5DF/rotAY6/rOTQVyqeeM7bY5PSyIj0wcUsATtTiwYRjim34LrpT3/zLo6RMDsaAqIq6BJ14GdfBmk6+Lwj85VpAL1fUx18+eJW7ZNfM=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3213.jpnprd01.prod.outlook.com (20.177.104.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Tue, 17 Mar 2020 08:26:03 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 08:26:03 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
CC:     Andrew Murray <andrew.murray@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: RE: [PATCH v5 5/7] dt-bindings: PCI: rcar: Add bindings for R-Car
 PCIe endpoint controller
Thread-Topic: [PATCH v5 5/7] dt-bindings: PCI: rcar: Add bindings for R-Car
 PCIe endpoint controller
Thread-Index: AQHV7k2mHX0IeWzmbUuqL/cidPXc16hMjZhw
Date:   Tue, 17 Mar 2020 08:26:03 +0000
Message-ID: <TYAPR01MB454466B8451E3115D8A7DFB7D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200228154122.14164-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40f9e958-e883-4431-5168-08d7ca4cd4d2
x-ms-traffictypediagnostic: TYAPR01MB3213:|TYAPR01MB3213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3213D0CB519558870D56BF0FD8F60@TYAPR01MB3213.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(33656002)(52536014)(8936002)(55016002)(5660300002)(4326008)(64756008)(9686003)(26005)(186003)(86362001)(2906002)(8676002)(66476007)(76116006)(66946007)(81156014)(66556008)(81166006)(66446008)(478600001)(7416002)(558084003)(6916009)(54906003)(7696005)(71200400001)(6506007)(55236004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3213;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUP2WRCSrmCT6B1OnBLOt5bGDTtxR/U5eJQcpyk8Pbwc1Fn4SEXwO/mXY0itdaDSRG5a+e+rBEp2rza2Auce5Vks63f1rew4j54hRB2PhTUhjPlMNh9btDY6jfWFwWWwjIGo4x9Wg6S7A/FECW2emIETwPqo/R3O7+43IixeHuv6JSj41hdkBz1e83b8sv/fVqtVqOodnHpXaH2DdOl2QziUF7t/PVZaH/dDoXvFTu3FkNFXAiB+i2+XhZS4nVh7yROYMeQ+IBhqxReFPTqqXjwSR2x6kkcxzaJbhA0+PbQQR8LOCHDqn+LuzvjZtXumjG3Qng0s7KtfDVlF5hPcIii4hbizIzw6VknTxdO6cQf7CmEBtR3YJ5UykwSbeL9PtldiBAabUD7RPZGYmmjewUxjuiGITfMOGzhMifgT45Df87HLrcnvy9fkGGpcQcaG
x-ms-exchange-antispam-messagedata: nPz+KD4K74cmcwqaO3a0XU8r0gIQNhMLKks3YAtYZellB3K/NocEQobWkDJrmcN0fAMlGqDfDeWD3q5E19hYP9gmwhLVVT/+qsgfFBoXa3GWDD3Qelygo3oH0NfIEJXbsF+4TH8izMyDVyJ1QPQraA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f9e958-e883-4431-5168-08d7ca4cd4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 08:26:03.0654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEKg5toFkrBKfz+kdF84oWoV3nR1G6DMm4T5UFA66MhY9gKq4bjo6/Gv0D9zoUlNxci9CL0CYvkulni7TSOBvAeWUGQGx6hTQ3RQ0rHzcCnNr1OH1GHsjze3578YHReO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3213
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

Thank you for the patch!

> From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM
>=20
> This patch adds the bindings for the R-Car PCIe endpoint driver.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

