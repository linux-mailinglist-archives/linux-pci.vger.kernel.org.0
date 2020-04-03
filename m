Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBF19D289
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbgDCIqE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 04:46:04 -0400
Received: from mail-eopbgr1400115.outbound.protection.outlook.com ([40.107.140.115]:63155
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727876AbgDCIqE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 04:46:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr/V3asjqMduLVCyc0ueWORVQwaCVblk+hSp3t9GeNWzqJtqZ32CnO6X4xPCNySKn0tbU4B+JbXS6OIjS/JAFzkk4OHmilQz1uiQSVUI5WpZJ6A+W6hPZ9Q3BULVbzt8x97Z9XO72Qs00vw6H/PvBqsIb22O6KHR1jxtUlu1PJJa2JwPEUDTggf7nApogfIXSVi9eKp7+qqo1sqn3KTTX5frsbuPg8XeoZ444whqXuTdAvn1/zo5mdVHXS3xu7vi90dhmWZWofPv7RsKdLk16K4QU5+Hm2MZRuAXB96AESp3I07pxERrTcvI7H2fjt4qUjAzr0zeL5RBeMEWOb9JhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N42OdNkqK4bOsQO0Ggz3XzzkvnH3BcwgXjGhbVe8U8Q=;
 b=m/rBLjjAD/DCPHX5499n4IEz27115y38krZZXG72MxXuW1z81pjzuV22eagOYt7K4coCJUMX81HpUxBJAy293L3QawIEU5A0OFmYkf9gV4ophIFI1nCXJQS+dqwzltQBLNZ+Adsg+LdWvKt2IUhcr7Kq3ycvM0lrAVaFFSJ2T1V1sg+wWKBPEt+WSKaMww1cn7DGzdzoQtXLKOv0TuMRau8ONelA0MEZvwu4pHTAMU/e8HXuCM7t4ylv3t8o+SHCHhIL5vSp9ohVsvKUWwQxrVvgNH9U4uz9Sj8MnzPhjroSDTafSyctimkWbupoCrbocxlloHnWB8COcdUjCHaXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N42OdNkqK4bOsQO0Ggz3XzzkvnH3BcwgXjGhbVe8U8Q=;
 b=EjFlSsOUZu5KDHqaVXjL6X6w61hp5OkFy9VKZo9YyT8Gk+T5uLWMEwEGMaF7uDBoWh2KAl7oY6L1oqaeyYFgvXJW5MYt8AHFbhbP7wNk3WlHFSMrh3nhllqRGgMYQI1eHekNzkFog6KKPw7a0t7oc6evFxT78yR3T/fP1UmgJ3c=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4958.jpnprd01.prod.outlook.com (20.179.186.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 08:46:01 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 08:46:01 +0000
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
Subject: RE: [PATCH v6 09/11] PCI: Add Renesas R8A774C0 device ID
Thread-Topic: [PATCH v6 09/11] PCI: Add Renesas R8A774C0 device ID
Thread-Index: AQHWCSZ+0p3wXypTI0ic4GUPb70TfahnFeXQ
Date:   Fri, 3 Apr 2020 08:46:01 +0000
Message-ID: <TYAPR01MB454419FA48A7B700E8F627DDD8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1585856319-4380-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11e895f9-8d2d-46d6-7a28-08d7d7ab6fde
x-ms-traffictypediagnostic: TYAPR01MB4958:|TYAPR01MB4958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB4958E85D132633B3DE711618D8C70@TYAPR01MB4958.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(55236004)(110136005)(107886003)(5660300002)(7696005)(2906002)(8676002)(186003)(9686003)(86362001)(71200400001)(81166006)(66476007)(64756008)(76116006)(54906003)(4326008)(66446008)(6506007)(8936002)(55016002)(66556008)(558084003)(81156014)(316002)(66946007)(33656002)(52536014)(7416002)(478600001)(26005)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EkE99+6GdfL5u4/wVTBUXPRhFL0d1uO0V4sEMz+/udklClDTQ/IlfOQAOMNET2C6PHPEcokYHWBolkLXFn4QLoQGInGhdOAyU4iKg34f4II3DnE0LSObkSA74/e+2gpUzKWh6pPYmjYLz6cNIfLd5LHH7LA6AhWvkhDeZAs/Vlqc1DhJyttTQl9BNoPBlOS4GA4eH4t5zXskxI5Hm7zvgQDtHtvVIN9w5PobZiyxM6F4lYzgPl7/Hk7W0+4wirW5eC1gXOu5rKcx8p23ZMYqZZR/R0MZZYeArZrJKwM+Zuo4OD+ub+hYA+y0fgM/HetSEk8t7FFtxfdJMPXOUs/BhzKTajMM7tpHl0ZtBwJP26OCwLFgMV+ZbzH+bdYYopGSCVRH+7qsx2h0EdxGHgyDe0bKwdUxVKN1eYMUIVsq9Yxejd/yGGytLI6UosEjp4srBmVGWt0zigNq09L6C1lf5meirG3zED/wicybUvhZuCvqKkyzlxod75yNOYNyR/e/
x-ms-exchange-antispam-messagedata: DXf7p/NqWiwiVfaimAcx+YFPSSvwBA1f17LNuvVyncuDiKHwU9unDjj3X+55uYcuejYhgwdVhTDCH+Y4HDk+0pZ6IM1qBImCpMhiPjYP9FqsEE1Zz2qbnWTyQin6X7FHbRoGOmS7CvfFzMGuHLYuYQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e895f9-8d2d-46d6-7a28-08d7d7ab6fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 08:46:01.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdvUtspfL0YH382ihlTae2nua9qdkIZJkmxOJM3s6PmyE5I0a/5VXT3xstcek0KoipFTNf0T7JKF/9qRSghBjWibA4YChYDCEPBbxMnU+SCdT9H9ZVLilj3gLwx72j5G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4958
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

> From: Lad Prabhakar, Sent: Friday, April 3, 2020 4:39 AM
>=20
> Add R8A774C0 device ID so that this can be used by
> pci_endpoint_test driver.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

