Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207D0E6E03
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 09:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbfJ1IYK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 04:24:10 -0400
Received: from mail-eopbgr1400115.outbound.protection.outlook.com ([40.107.140.115]:18944
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733275AbfJ1IYK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 04:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbfYAf802skOdAQqCv3Z7klnaumbQhsWDJAvt69X41ltXWAdfcx8XKlQrtiV4LHyHWiS704zaAUDVDIJP8OFzSTgyu3i5+sNC401XG54pPqrCjilDxCPY+hcQH3S6Jv0M+VHNojemfMEdkdv/RI91hM6EuP8SRvk/+EzaRNAeoknhgBC89eZ2vuXNaF/4yOtqH+IRm/gTnRndGtxI5SSLaA25YDmnYyMQLjf5Q+owTX3Kox/rQuk7kTRXP1a6ulj3V5Yh68CwZNoub3Ik8Nu0AiEGrcMPNE2Yq2mlEfUUkGLeoITiEFQnPjTvhRIlyreU/h0ae+VG6CG9xU7+Qhrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeBLqJYgLGMMke0o5u4rLlJgOsmVPicvDsCPvTpyKCc=;
 b=Idkszs7/SmvEChDM3ycb67bY29n5LNBhgLp9TcX/6ulBZPh4I35FGlUgngL6VxOCYM3o7XjLUnhp8aTZVaf6jKrtWqEMjtPwsOjdoCP+iG3zgz6urieS65IxyEjG+D5JJA6YR5mKihpRqXvJR5fzZe4wlCrKGFYB5H42vShlPBRhrJBxsAR/2gWCqKJpGBtLisZjE9LIiB5lPECVsvTcIXiS0jo/L7sfkJKUFHMYvBC6Qi/cnga/Jx55TgDavZMBIcJsClgB1Dky2HqSs05euVDB+LUCHGGNGdV3SbMn9n0miqx6WiKGxLCIMnpdsNjNBAlAripZNMLIb6Ap94f9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeBLqJYgLGMMke0o5u4rLlJgOsmVPicvDsCPvTpyKCc=;
 b=nv6neeHpbpzFuZfUZigpqQZczr+0bhdKVX6/vmWmSOhpamfoOYTpPUdYZnmq4bCmIrC6r+4+zM0cgntfTR6eMTxSoDhdSXz8XEuB0QHGMB2giU4OnKxpLPiinnm4KzoPIXJ/rMjtp4YB2P6kieIDpkH2H68SM8vJj7gqeBZh/RU=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4813.jpnprd01.prod.outlook.com (20.179.186.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Mon, 28 Oct 2019 08:24:08 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 08:24:07 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH V4 1/2] PCI: rcar: Move the inbound index check
Thread-Topic: [PATCH V4 1/2] PCI: rcar: Move the inbound index check
Thread-Index: AQHVjCsHboG+CR4iYESonm2wlk//8KdvuWJw
Date:   Mon, 28 Oct 2019 08:24:07 +0000
Message-ID: <TYAPR01MB4544C7DA109A5F449D1377B9D8660@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191026182659.2390-1-marek.vasut@gmail.com>
In-Reply-To: <20191026182659.2390-1-marek.vasut@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a6d21c3-dcee-4929-633a-08d75b8033cc
x-ms-traffictypediagnostic: TYAPR01MB4813:
x-microsoft-antispam-prvs: <TYAPR01MB48136334F9A2190244D8E793D8660@TYAPR01MB4813.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(478600001)(71200400001)(71190400001)(74316002)(4326008)(4744005)(7696005)(76116006)(66476007)(66946007)(66556008)(64756008)(66446008)(86362001)(6436002)(6246003)(33656002)(5660300002)(81166006)(81156014)(6506007)(102836004)(229853002)(8936002)(8676002)(186003)(2501003)(26005)(76176011)(52536014)(11346002)(2906002)(6116002)(446003)(54906003)(110136005)(25786009)(3846002)(316002)(14454004)(256004)(66066001)(55016002)(99286004)(9686003)(305945005)(486006)(476003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4813;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwZFMvkCnSoWTxHc6nn9hR6C+BSc0CsjLRfGaLUTF+iyRCWFhnur74WklF4xN26t/rKtzUffCetnF7Zs6zsB06oyrWSGoKRFCqB1RO7hiepMTAKH4HuzCD+LnRSAqycmFnY5uR7+VtdRCmJ36mkuwOflC4z70wL0lIi1CD+Y04ZBPJVkHQ0apx7y5a6zvLMJ70eGF9uESIX2yAh4V/4qs7E4khQipAAwn/kIvV75YZz1M2SYJDb9rEaTVi03icww+eulMhnJleT+JFw6rJZjGxonL+TK83s7lUkX0EsGjAz+myVAaP8Yv7L7SLIZVf1W7hLpYpjZWHClwJsd3rnSqJHHYY8Kpg5k/pyb3Y+/jraoN+yHNOr5v+sPuH+a03cIto2kRT4+Jt5TGDCoOMQEtYXvsJT10o0dAR4G3ECu4NhtfcMmCStkocgCSUlOL85Q
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6d21c3-dcee-4929-633a-08d75b8033cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 08:24:07.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0rt8Kka2+BdA59S9sqNPLT4ldxOfxCW6kcCUoDRwuONqmb9H+lF5ZrCqDkFd/VdfwckhvGJIP16AsExMnvIiqA5MjU++96k52l7DRJZZn+XrttXv/AVs2VpdjS+rmnj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4813
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek-san,

> From: Marek Vasut, Sent: Sunday, October 27, 2019 3:27 AM
>=20
> Since the $idx variable value is stored across multiple calls to
> rcar_pcie_inbound_ranges() function, and the $idx value is used to
> index registers which are written, subsequent calls might cause
> the $idx value to be high enough to trigger writes into nonexistent
> registers.
>=20
> Fix this by moving the $idx value check to the beginning of the loop.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

