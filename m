Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9C187E05
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 11:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgCQKSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 06:18:14 -0400
Received: from mail-eopbgr1410134.outbound.protection.outlook.com ([40.107.141.134]:49888
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgCQKSO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 06:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGON62+el/kSiCRvx5caojw7l4aCLJTGGpOCy52PteJbIW1j59lOJOzHjiv2z/2XFkGovh1qWZ0kXLxWhEsVYt34mIwUBikJwMJ2A6fCK3CTFqDZPc9xS9usP6G5u3LC2ic649Msv8LNDJW+GIDHSZ9KwefeOmFwLV9/ssqK3OUi7oK3C+44HrrjqW9LgAId42GBDwxp+EzwTR0tWmZcY0lqhltQD+sDV1EoXU2g1NQGXoXJ2PsZCs+YVa2ZfKgyj7EcbVNSXxKbgZjdB0FgP/M7ZnUWK/Hq3+9vupQ2mW7n8r39PEqntTVGUK9xQwx+hZ7ZFpUVVtDlE0/sMDkvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwUntoL11ukJsITrpHrU6ydIPM8tizbPDa4EU0vKSgE=;
 b=b/rMG2kcwKJJC0HnPq+KX1BtGbP+MqX5AgNhzhRG/jo1wmSK9k8y3nL/l5D/qXtgGunKwSFTqvQ0wiMnhNLIe3AHMXtF7J0/jEppnAjlQT/H0PkWp0IcnuboEWRYaAN9pRlyisHIwRhIgbRxMZq8QB2JYpHasIbbbSjWSIJy8F6jcbO42qpqTwejdw8dEBswPM5n7bTSTT6Rq0A+JWBdngK9+plCfQv1o6+X8z275+DE4ue50RVHBps+xtjKtxMxpsYxjL+D/5JSjOAr/+mPC+B37b9+EEg+i2YALOzAuX43sYktBarstj8oJWTHanQgwWdtP1IIQv7V3220Q+iffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwUntoL11ukJsITrpHrU6ydIPM8tizbPDa4EU0vKSgE=;
 b=iFm4sddOXZawW4q3B9Vc0ojmwp7oKWaKxh54r4ECjy3fTW1JW2uwXwnCcEUzhv+J5Y8YgS9XpwmBfKXdXnfpXXUqA/f5sUvCXw3Vjwj++4els3kUQa33x8IAzaBIfCHwl2ZDx6ky2AK+AQBRyWYMgpE3HOqwQDy0JKIkvs4MrDQ=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB2454.jpnprd01.prod.outlook.com (52.134.253.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 10:18:10 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 10:18:10 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
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
Thread-Index: AQHV7k2mb/v0bc2DvUS+HUsmhvWhMqhMjsmAgAAea9A=
Date:   Tue, 17 Mar 2020 10:18:10 +0000
Message-ID: <OSBPR01MB3590F13134F6E9BD106EC506AAF60@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB454466B8451E3115D8A7DFB7D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB454466B8451E3115D8A7DFB7D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e099edf-b43f-43ee-8065-08d7ca5c7e92
x-ms-traffictypediagnostic: OSBPR01MB2454:|OSBPR01MB2454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2454C261CB16645A0158108EAAF60@OSBPR01MB2454.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(316002)(110136005)(54906003)(2906002)(76116006)(4326008)(5660300002)(52536014)(33656002)(7416002)(66946007)(66476007)(64756008)(66446008)(8676002)(86362001)(7696005)(26005)(66556008)(186003)(71200400001)(8936002)(53546011)(81156014)(6506007)(478600001)(9686003)(81166006)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2454;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QUAO5tMnOTmqzudeSh4ZLSAGLD1cQ3tvJiwtrEQLbijr/MVLPR1/muSO3DzkvzIaNZA/OBpBr5CHp0SYi2+3iyW3WMzhXV5ZRVw/3qEos+gCSc1NyXCFU/EMnURjqVX6oSxOC7HhkHBMUk+eUwaneJbCzvYcG4YJOd4qCPjP91/XXdeu1mxs4obCl2ooG9qc+tGsQb5DHG8ENOnXtEmaM+qOiICzlRlgWKQwSSCgAfK7dlvrFy5HHFr+csILHPdZkrv2nthjqCQO9rvWJ1yLEH67g6RKcm45NTDYTrCV7f7IMvXi580ZZ2Aci32Vxpr9DjXMBA62sbnQof1xkDDguWEwgUhz+g0SS7MOi3kt2lfa6/Tse1Pn2Hasyd7CDvkPv8DTWrdxG6suvLXit1FJ2sc7/dyPNQktnNDUmU4WYLh75bmh7Dw8hPmYK6Pn+qvE
x-ms-exchange-antispam-messagedata: w0zgGx/VgV4KExD9yJ8pV7WikUiHfRwYt9btPpF9nPg0jhmlfU6pgaWuSgcEphmgpCkG0+4Fp6IAmbXjncFg3K6p4/1RfLSIdZOY1E4EWni44SUpq4s/pTIz5Y7PqJjE8yPBpFwbLvHVZL6aeTp77g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e099edf-b43f-43ee-8065-08d7ca5c7e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 10:18:10.3458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbQJmjNJSX6JMv9MLQ20FG9AW2lwXWMHHysf1RCtDtTHekw0/zVDyIuwrY3cNRHHKL86hSqXgcLbiQDQ4iIt3c1vddDL6l7Gl5yzt6HQSAl5yJeUEUo1gvL3kIHOP3Zs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2454
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro-san,

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: 17 March 2020 08:26
> To: Lad Prabhakar <prabhakar.csengg@gmail.com>
> Cc: Andrew Murray <andrew.murray@arm.com>; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-renesas-soc@vger.kernel.org;
> linux-rockchip@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; Rob Herring <robh@kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Catalin Marinas <catalin.marinas@arm.com>; Will
> Deacon <will@kernel.org>; Kishon Vijay Abraham I <kishon@ti.com>;
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> Jingoo Han <jingoohan1@gmail.com>; Gustavo Pimentel
> <gustavo.pimentel@synopsys.com>; Marek Vasut
> <marek.vasut+renesas@gmail.com>; Shawn Lin <shawn.lin@rock-
> chips.com>; Heiko Stuebner <heiko@sntech.de>
> Subject: RE: [PATCH v5 5/7] dt-bindings: PCI: rcar: Add bindings for R-Ca=
r PCIe
> endpoint controller
>
> Hi Prabhakar-san,
>
> Thank you for the patch!
>
> > From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM
> >
> > This patch adds the bindings for the R-Car PCIe endpoint driver.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
Thank you for the review. Shall I add this file under "PCI DRIVER FOR RENES=
AS R-CAR"
In MAINTAINERS file as a separate patch ?

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
