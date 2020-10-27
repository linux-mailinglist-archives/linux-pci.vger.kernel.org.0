Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A178129AB6B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 13:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750629AbgJ0MEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 08:04:49 -0400
Received: from mail-eopbgr1300118.outbound.protection.outlook.com ([40.107.130.118]:45184
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750627AbgJ0MEs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 08:04:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URbMw4UrROPISB99OPW8lyWj7H9m0yl7joj1DXTe1Tt40K5UfvsbZhGUWROfqieS8Ncu+5odO2DI7acoMRcl7otgFgez7dqBoLfj06HUwVslnftb7LzXmUZ3ar/6w4zSIh4yP1lEbR5Fv5i1PmYj8Oya/WHg4wScjAuXQzcBfuq9WbY7ouDt5YFi/KPhLIRFaQl67Gif3fXiA3vv7ahwimmPsX7Yk57Qg9Rfcycn0Z++Yt6rNhOv4frvVIHInXJAbcW88pxRdsqWgaOxYogTI+69zcc60eS+PzaHxwJzYW0rlkFn9wcCS0Tm7Ein8VJFkY4VaJmA6xvpFmRuohQVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0MZUwFbcMIjBsW/NfzeAnCref3xb0nE+JAhrM1Iy8U=;
 b=XrJFcw1VFBtkkX/ycLiKBehXGs7BvnwGBztyNHg1zwvjNPCv4N3qll3c+3UPodNLYbcdlWsJ/vM/CxLpwW5ot5NIC2v3/+20qla6jbqPTNqBG17YHifNpfHaJmAYjIGJ+qkbY8TVyhe4X5FP1gixq1q6SCN7fsKSgnE/OCsj6D9VScPDZpnKglZ/sEly5XpwzrUJZEuMLvLsR1WE///UZKSlod8y1HTl3AmDNs8TXVz45oKD+oFW7FpqEFIS9DMHmS+NadEBHdEoQikp+4KRRdQlBdLKF2X+oag5Sk5/drbluzWHsTq2WDnH/3c4AQuAgGLk3efd0GZQeG30PtiIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0MZUwFbcMIjBsW/NfzeAnCref3xb0nE+JAhrM1Iy8U=;
 b=XlLNywsFm1xDKyn8P2eyh04JOuRJKBSntK5L+UXzsJAFOfnUhN4aiRsZ5sMl2XkV1UK1lzKCyGki50AGmDEfm4BUOFvjGsF8tKdY9/Mt3gVVRbGwIJaPlKdeSSHyKSepKfXsUlY2egdfeiKMtZUtlciEHwrP2HmKuHwGnmtbySw=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB3689.jpnprd01.prod.outlook.com (2603:1096:404:d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 12:04:44 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 12:04:44 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
Thread-Topic: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
Thread-Index: AQHWo7SHW9P+URzHU0+bBX0ASEFVNKmrattA
Date:   Tue, 27 Oct 2020 12:04:44 +0000
Message-ID: <TY2PR01MB36926F4E927C231E77D050DED8160@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20201016120431.7062-1-marek.vasut@gmail.com>
In-Reply-To: <20201016120431.7062-1-marek.vasut@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b835ea5-d442-4b6b-1f0f-08d87a707e39
x-ms-traffictypediagnostic: TY2PR01MB3689:
x-microsoft-antispam-prvs: <TY2PR01MB3689BF8844C9F11AA9B85083D8160@TY2PR01MB3689.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nlyHG6r1Vo3lFGqvYX9kUWtT235NMQFYcOLQhMgl0136kACLXXK3kZytCKo6V7QE3iTwQF401ugIVydGyyhVLagBif5EFnT+jxZGlIZ9nohE1VwbNAVxiyUJRwxs7HoH2jXHWM5QdwBYlQGWBkwti/INjX4Jrd7cTIYu2ftU7V9DqBE7J2MFILDhcsbrYFMEvhGNM5RcdYDnhrADdfDUkSpH8j40aVxl45lHITKVp6VComHAbqFENYHK17yNUmSxc0lESWy0oo3r7tzjc6QKc1/x02ut5BQowyQVUVkrk4IGianvelaNDX5EZFgcJ/lzhZ1DCW1jOiQ5w04js0G0ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(33656002)(66476007)(8936002)(52536014)(2906002)(55016002)(8676002)(76116006)(9686003)(498600001)(66446008)(66556008)(110136005)(4326008)(55236004)(66946007)(7696005)(54906003)(86362001)(26005)(4744005)(186003)(5660300002)(64756008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fSYkNB8kH9CZ98N/SvXGWK9Qo5KGDRi6t5zDEX+SVFa4YNZqVd+dzqMOY6UGVsl8L6Ri0SKJEZjgofiiEJq2jxsS7GQwFZI1VcefJWB+d8Jg0aIaAQvAPhU/nq5vcf8fEfM9lWFNAmUr4jxKXEBFeFLt+Ee4cD7839RRTymdgwBpXumQUD01d0FYROJL75LqYfEeJFqFnokShtzUA5INqZxXkAddSfx6yxnfd38JeSoG0wzV0uokdHsXVi367UAKhNtNEpu82S3cbVNcomvac+tf+bQ0VLSRB2JWh1fhIrLEUPsxM3+1jcF95NZzT9Wxvbnp1jCVYxBc5Wg6iFnrQEov+omm9Hna3IxkYqurt09TsCj220bAEbTzBRVc4Sb30mkhqkPUjs1QkMahcfYMkCY4uS3LwHHN0NxnOeIVFOQ+vCc6ox+sHxv2dMA87wKRMHkVoIsPDOFTDWW5GUAi2/DX0dj5JXFYooI262Iz9pqpf7KOASctIJPyaHRlA50IIVbn26CvUQA3bvOa+fKtCxIycO/hPVGuJhYajZMZ+b8cBakuz4y7yR6KUun7Xczl9mWOnDzqEUWf/IPrppZHgfTX72TB0hDFJhCGqC0bZ7MHU4vf7OLqod1CMCBjvlnSGMFzAkv7jc2E6tzzBTEwhQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b835ea5-d442-4b6b-1f0f-08d87a707e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 12:04:44.4154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MA5rfTm8Aih1wNE2cPyNWVF7oWuiHMVEoaCEa+jukonJGzlDJgfkHBRvwN4kcfn2OeqpoJxp0dzpztca1MhjWhX0NGH2kPpO3UmHHcyF2yvQQH6oypzFXy6Y9LMduwK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3689
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Marek-san,

> From: marek.vasut@gmail.com, Sent: Friday, October 16, 2020 9:05 PM
>=20
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> This fixes MSI operation on legacy PCI cards, which cannot issue 64bit MS=
Is.
> The R-Car controller only has one MSI trigger address instead of two, one
> for 64bit and one for 32bit MSI, set the address to 32bit PCIe space so t=
hat
> legacy PCI cards can also trigger MSIs.
>=20
> Fixes: 290c1fb35860 ("PCI: rcar: Add MSI support for PCIe")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

And I tested on R-Car H3. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

