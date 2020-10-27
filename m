Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8654129AB8E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbgJ0MOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 08:14:36 -0400
Received: from mail-eopbgr1400130.outbound.protection.outlook.com ([40.107.140.130]:6072
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750752AbgJ0MOf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 08:14:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGbfHYutH3uQK6hcM+qdn/rbolOo8lZmTFfTHh9yNVcCWMuUtk/nOKSWmFv0AVAGg58gwUjHQaoL3r2n6a3h5kocH4pRTkVJxYudEm6k6wWy1jaUQyEDpFZGpZrMXHGwTmeAv2YoqqTfvv0UYjlgkOSnmZjn9KGfv2tRGB0zSPfrixtFNUBT6bHQOIY4IMOU+rJ9wC+YwxBT6tCerAew+PKhXaL/q/3GgS9hNBTvrVe4X22KZD5KCAByV46Knb9NBhhlxzpnam5cuop4cQcYl0FxcEq9mQKbdDzajqofB3xCWqKW9sCb8cooDOTewGg+wi9lBcjYRh+Erb3ezwdYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z4+HfJFeGYI3UCmB0paQL1xt5IW3PNwsd+lh75bO4g=;
 b=MSWVK0NjYoAc9B7973UNPuCpd10bfmrqulcfHDupIXCYVFPduOqI111Tdc2y+JzvXYwbq4VCMA/eCILpnY6+/276M+sp7KViTtyzncYeHtNgVSilEnWTQypxIqmAgd/bVox5y7QebIPkW102sQLP4GRKqUFsOWTxQ728AT/cCdbw+droihfm8PVFE1fUwkiqLmL4N9SOG4Ui15FmdHg8SBTyjcuLg0CS0J0LbWnwOP4SasLxnBs/NlG5xmdd6mfjN20G5Vp2hmjmhqnqTB2bl7tASt3aBbfSNR9CMsoR7V7sCHLhp6UEY4NMVYihIbSS912MPa8ufuYOMikJvc0Xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z4+HfJFeGYI3UCmB0paQL1xt5IW3PNwsd+lh75bO4g=;
 b=RXvWt+Cu8s/sye/J7MUk4Hboy0hTAsiOzpS2C2HygoZLMUFcfZHxXa927y1T60zZYIPabiLI/bewHIraqjWwWqvM/lovBgJ995ZKgja2iiYJzySSxDbKIWwoXRVAqZTJClsoNZcVvZ2rkIl0qYHB3aTCieYykkMEuHIghl4Xi0M=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB3214.jpnprd01.prod.outlook.com (2603:1096:404:7f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 12:14:32 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 12:14:32 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: RE: [PATCH] PCI: pcie-rcar-host: Drop unused members from struct
 rcar_pcie_host
Thread-Topic: [PATCH] PCI: pcie-rcar-host: Drop unused members from struct
 rcar_pcie_host
Thread-Index: AQHWqVhmy3i7vhuEiUmg1JNmpIUU46mrYnUw
Date:   Tue, 27 Oct 2020 12:14:32 +0000
Message-ID: <TY2PR01MB3692BBBB69AFC4D782B5D0C3D8160@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20201023162008.967-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201023162008.967-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none;bp.renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef4854b8-0e8c-4b8e-41ea-08d87a71dc99
x-ms-traffictypediagnostic: TYAPR01MB3214:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3214DA152A589F9F2919BD64D8160@TYAPR01MB3214.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gMGhfpNZ4JeegG0wfdYYqIRwPLWqlsjZFkT5E2w6wzPjl0JGanfSx+dFpfSAutqqmqAI89jc5Azfn1iNS9zU+FzBQJm2ogJwHX7+4dhobpiybCvSzbMphGmksak18PDPgVr1bEfYZJ+STAlgDagYIywjW/JMw1z8TUi7y1mM9va+KPJrL0oMF9W2tb1ZcgWNvIvjb5rO1UsYEEjHDsXXKv9CDnKPA04wCWYUzF6mfJGM0F57/HZWRY80OslSU/DfROkx5KgWT8H04kq0Q/U5dgqqcOdUqJ+kOGwtL2SpsfTeWqU3iMN/ZaCMPa1anhPUJAnRTYb5zLgbObY3vS2f7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(2906002)(9686003)(86362001)(64756008)(76116006)(66556008)(66476007)(66946007)(66446008)(5660300002)(4744005)(33656002)(55016002)(7696005)(498600001)(26005)(71200400001)(6506007)(55236004)(8676002)(4326008)(8936002)(186003)(52536014)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kNwe+/CbbG3eE1COZhN41XzXP0BIzRc6sU/B9fAC1/pFqmJccg2e8JU6TjLbbRJZfs1qRVkRRQHvTV/dyEc4W69W9mLwcQUDGKhCsrhMacsNEVS+DkBcSemx5PAyscVli4k1mUbVVRcRMWbIUxDZH7MhDFOF9J3sSXWoGY2MjTsEJaOmG+3cRU2E7hdIs2wwDFY1KbvrsPM184ftp0Io9rZwhRPhcU2vnq04v/PdDdfnu+RFHIZ5JeeAGuBHWw2MzvndtoN0mPeh7noqUEhkeC2plD/TMP5i9S0Xf6W65JTYc67zEKoVjd2j64wwIsp6tHdLKCISHEwOJLmZrNtbVXgvIuK7n97ulVrqU/NMU2aVd57s8hpcHFxCJh7aXpZ8zohN+yH5B/PhS+HnbjQO+9ruGvI5UtPo3u+0jJwTGpoDqfpuVImb0K/I4oLZmEdvf8LbqtL2wILTyZjP5pNvYT8hc1Tc95J2qRxR1BEuOFKt9cFH7qTyeKYGj6wGHWBuqnhJqd/RFm9lVWAqWd0AtWmMlh471nOA3GddX2XwZwygaQW8IpLE4XYzJHfD+wDotxNLTQ0jsf7/Km3YE2EqBLJ2RaHltIDTVYNyJNCJNadKOZRuysQ59SGQXM3bHpsPt4VSbXrmQ7E9ir8NdJKkDw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4854b8-0e8c-4b8e-41ea-08d87a71dc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 12:14:32.3040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WIlJwbiuc9yL1tOGGRr1ADY8IA0j7wSBxJoXfOazmr/PsWPLWx/YaxcfONRhSz3m4LLtypKDo5VPGK1F2RiogQDOjzfKQG0p1LC7fyaUee12ZOLYCRgsJT565Bt6f6v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3214
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lad,

> From: Lad Prabhakar, Sent: Saturday, October 24, 2020 1:20 AM
>=20
> Drop unused members dev and base from struct rcar_pcie_host.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/pci/controller/pcie-rcar-host.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/contro=
ller/pcie-rcar-host.c
> index cdc0963f154e..4d1c4b24e537 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -50,9 +50,7 @@ static inline struct rcar_msi *to_rcar_msi(struct msi_c=
ontroller *chip)
>  /* Structure representing the PCIe interface */
>  struct rcar_pcie_host {
>  	struct rcar_pcie	pcie;
> -	struct device		*dev;
>  	struct phy		*phy;
> -	void __iomem		*base;
>  	struct clk		*bus_clk;
>  	struct			rcar_msi msi;
>  	int			(*phy_init_fn)(struct rcar_pcie_host *host);
> --
> 2.17.1

