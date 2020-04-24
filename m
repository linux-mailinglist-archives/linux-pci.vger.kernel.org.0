Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6091B6DB3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 08:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgDXGA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 02:00:59 -0400
Received: from mail-eopbgr1400092.outbound.protection.outlook.com ([40.107.140.92]:39415
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbgDXGA6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 02:00:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFTKpU1BRWNLVMmmQ9aiCvZmfWDYRMwWkZh98b1luvc6KkGzgz/g/JBRu44dkBhighYs+ZhS7GvsGBUmWY0dsxZBwTtcdV+RUir/RRXSl0+rMFunhJ0s9b2FXWMXAP8WniY5B+LkfOETQR9YlSiddnMc9fgXka85/WG0/2CdDoEnNHF9TaTiX9fVytOjXUzguDizpzLUh7gX/3Pn8RUx8tr2nCbASyK3mxAnSBKXQdxXa/4ZRy/DEqNrY0ktluU9tOxNF4aglvMpbmsKqCrDlo7mxECQm3I6vwgwlBMWA0NOnK3LcvIj4XfcU5OB/ClSbbEQKF49YP5tuWp4msvvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZg39AJatJLwtPxVAUA77MuS1qqgEt2v4MLZVSwWCkE=;
 b=VfNiG4tEVkM3pHGWRrmTaDAL9kg7+U68uZ1xzmWckQC4pS1w0BDBA0T++tiYhZTkfEF9TseS8MNr0hmLjUUqyYBXIYakS3UoLndps+caMHpi9ZB6pDJrj7SalMOBCgzwYAd/riX/RctKmPGd9qTkZZC3zYtj0V3r7rbuZ0x30rKJkvtTwGT4350enS+5eQYPgn32W8I/0M7DJauwydYJ7+6GSqS7+jeEk0HXJPbhKKslxeJ86fG63N3EB6+E3AW52r2NUTvgjfB6KvazmF+rXjID4/287TWcdLz5SPW7spMvxdkTPYEq60/vqNYyy9mEBgFRxWYKVahjrV9bbMeF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZg39AJatJLwtPxVAUA77MuS1qqgEt2v4MLZVSwWCkE=;
 b=ovmSZHXjb+jHPr5oRmw+MF6OBG38Z7b3JBUVy2GaylCO332h5dXDIEi2QS48/QCybRRYIE34F69/7j8yjdEFAbJD7bVzFtZ3EStryUcA5TgDlzfLHgHxmNsfIUfxLY672mmZJEDps3v//5DRnJKLysfvW5rxyHkqmYk7gSI4tWI=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB5340.jpnprd01.prod.outlook.com (20.180.231.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27; Fri, 24 Apr 2020 06:00:55 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 06:00:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v9 5/8] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
Thread-Topic: [PATCH v9 5/8] PCI: endpoint: Add support to handle multiple
 base for mapping outbound memory
Thread-Index: AQHWGZzF+cKabKHIWkeGz+yNhrFZUKiHx8vQ
Date:   Fri, 24 Apr 2020 06:00:54 +0000
Message-ID: <TYAPR01MB4544DCE7E61C83F0D4EC6C3AD8D00@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587666159-6035-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587666159-6035-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 435d2937-ad98-4854-f66f-08d7e814d9fb
x-ms-traffictypediagnostic: TYAPR01MB5340:|TYAPR01MB5340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5340DE138B6B5ACA20E6F2DED8D00@TYAPR01MB5340.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(66446008)(7696005)(7416002)(71200400001)(26005)(316002)(8936002)(4744005)(478600001)(6506007)(52536014)(2906002)(81156014)(186003)(8676002)(55236004)(9686003)(5660300002)(4326008)(55016002)(110136005)(33656002)(54906003)(66946007)(76116006)(66556008)(64756008)(107886003)(86362001)(66476007)(921003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: scKlVwxNmZz8gmL/XNFYG9f+k3/DSvlQuvIM/lLvTnhpiHDWRjm+up3uU9V6uG2jEqwtNBSSe//LLJIHnzab0N0/x0i/qfosTg81GOxXvyaGcDRwu+HeUoy1rlhitPXLprhW2IOqdscr3PZUiO78/yCtPNiKyuThBn+Ryd8O79yFW8GCS2ta8pYzC9ZYovHHsfJ5vyE6EU90bCrg79eTTkglcciiCo5BrFFF2WTUn5y9c3GohOVbenURAUaPgv/wKT/iQiiMPbMmDVh31QH/d7r2sipg2FveWCOBjRED4IoJq1VG/HWmRCcVALAYKZJh1HE0P1w6tLd9HEPzTFtDDTKSQl+TyLP4Y+5pJ+muS88vyukwSv3YeDKIfRYBzjduMS5jwGEO2TiIxxrSJ9HXR90ciHv3O2ENa6aTb1kAl4UyQn4/KSs9mndu0H8kTTv3mPVGSZ47JzvD0qbwFDgV0Qv0MQeMHrDOM8yUsaDKZBw=
x-ms-exchange-antispam-messagedata: KKHXrCBdgsGDevSr/AlEJ8cPmLsR0VZoQud8SZsGbkvL4IWEpwukplUA7LQc8NMsKgXEAVEuuEtiQ11fHOLyMi4cptANaJ5n+A6Cy+lrgeu/+e2ihJY49IfZoSjNdwOk+m74gFDzxJ3CfXOAaOdbag==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435d2937-ad98-4854-f66f-08d7e814d9fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 06:00:54.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzqqeabqdOQ4k++kSWt6Z7f82tDMuExTyc/SHplOzi/YDfT/NAsQvqH2/zsj0CmB2gDSSEqUA79OGNPOSG1jrua2mWdPNqahCdUHpw1LGXV4H7XnSQrrjvAxSDO3Ehvn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5340
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

> From: Lad Prabhakar, Sent: Friday, April 24, 2020 3:23 AM
>=20
> R-Car PCIe controller has support to map multiple memory regions for
> mapping the outbound memory in local system also the controller limits
> single allocation for each region (that is, once a chunk is used from the
> region it cannot be used to allocate a new one). This features inspires t=
o
> add support for handling multiple memory bases in endpoint framework.
>=20
> With this patch pci_epc_mem_init() initializes address space for endpoint
> controller which support single window and pci_epc_multi_mem_init()
> initializes multiple windows supported by endpoint controller.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

