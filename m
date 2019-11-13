Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21D4FA033
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 02:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKMBez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 20:34:55 -0500
Received: from mail-eopbgr1410128.outbound.protection.outlook.com ([40.107.141.128]:20835
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbfKMBez (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 20:34:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at8JnQ4+Ehbg2EdMffXZqbt9Vvu4EMg69mE+XAG1kTyaepR0yOm4gnX7OZoy0mh5U+uEqErknwSfUWV//jmbRrusNsiTlWWBq4309MUGPKOM5uOVvC7HAnyrc6NA32LC8Cm8cVFkjyYWL+n4JAV9o5uPOltcqn6d/TN0iwB4ywh5YZDU6vlFGCyYPx6LOpxmAQZlShUsLsG36yKqmMVXrebMLalSus/6glmh0636mnoKrBRhhVzf1N6s1jBNlAwAr4u9U/XrbTjbkCfInCxxj8Mcp5q+YDtzSKTNUM4m0GNOIjz/cG4LGVfHKD8vdiQXiHn+02rItfpg6Wd+vc012Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2Ij4zsYm1Ubn+CbvJmXpu36XEuWtJn15q/VIvM5O3E=;
 b=JkGS1nNTlAI9yPEzDHH/njodMQyEkpOTHAhtr6l1Kl++7HApRGo9Al5WZR92lrMjiz9w+d2cUqYt6qaV3M7U3mXuRyiyGjJ/M8zn2Lx4j1pKN4YvmIFUBSeljRQHshPDaVxQdbkg9Qx0UqLRT0ci783pzJ4vph/loRXr969Dg5oJ2ANW2CA1Cv17eGSf3L6Mj0Bz0shp6FSh4Ypgg4UqF9BfvhYFQ0RYrTRy9uVrSpaOEXH8DuntxeSwVZPhawXWzrQR72wPWVPIz9gf/uyRCGgDtEcO+7qMCqjm9ELec06D+3RFDiUr6MJKI3KRBAnKR0kxcCNwngRX1Z0AaStj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2Ij4zsYm1Ubn+CbvJmXpu36XEuWtJn15q/VIvM5O3E=;
 b=KKFhdocJL5HpsI+wz4sZR42277ZLqL3dzFRShaH3CW7GwUIGJlomSfCOaLoagiYieNotNgHX4cVtfyYZ7SEvuhk8dyoMaN34uFwVZbLvUZ5L1RXtXK9LL3rAqv2RnPmFg/RgVaIedp9mjWfzk7tTl8BAdvfE1I/wdo+KwvhOxT4=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3597.jpnprd01.prod.outlook.com (20.178.140.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 01:34:52 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6998:f6cf:8cf1:2528]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6998:f6cf:8cf1:2528%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 01:34:51 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH v4 2/2] PCI: rcar: Fix missing MACCTLR register setting in
 initialize sequence
Thread-Topic: [PATCH v4 2/2] PCI: rcar: Fix missing MACCTLR register setting
 in initialize sequence
Thread-Index: AQHVk8b75iTnpBH/kkeyIqRIXE+o+qeGFPYAgACz2rCAAJcYAIAABXoAgAAKvwCAAOy04A==
Date:   Wed, 13 Nov 2019 01:34:51 +0000
Message-ID: <TYAPR01MB454416AA6EAFDA8BF5024330D8760@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1572951089-19956-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1572951089-19956-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20191111144236.GB9653@e121166-lin.cambridge.arm.com>
 <TYAPR01MB4544F0F0BCAC5116731D15A9D8770@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20191112102706.GA12685@e121166-lin.cambridge.arm.com>
 <CAMuHMdXBJaL=c+9_kb70jHMqzvfxxYezLEX-Evh-FRyY-FYPyQ@mail.gmail.com>
 <20191112112510.GA15159@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191112112510.GA15159@e121166-lin.cambridge.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b43d180-b022-4fdd-ace3-08d767d9ade9
x-ms-traffictypediagnostic: TYAPR01MB3597:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TYAPR01MB3597AEEE8D13E85DEDC73F92D8760@TYAPR01MB3597.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(229853002)(52536014)(8936002)(476003)(11346002)(3846002)(99286004)(6116002)(6306002)(86362001)(446003)(66066001)(9686003)(486006)(71190400001)(256004)(186003)(71200400001)(6916009)(33656002)(8676002)(55016002)(6506007)(53546011)(5660300002)(25786009)(26005)(4326008)(102836004)(478600001)(7736002)(6436002)(54906003)(966005)(14454004)(7696005)(76176011)(81166006)(66476007)(81156014)(6246003)(66946007)(66446008)(76116006)(64756008)(66556008)(2906002)(316002)(74316002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3597;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5u+qhbdkKZitnMnjKk9lCj3HLo456SehcYRggEyP1kJEfHlpkonAWeZ8ORD9iyLBVmELf2BIyyV7CKW/ujFAqsMHPG6i+jfpmySEUZWyEebWCAw/NSfKfi3haQZtLjqywP56J46TXvAWxjTJnh6zggwQnOyfN+ucMo1GlpBrkjBUTGD+knvXdyqNAJpczdzK6YFNc8U/L+YMmH3Omb0PO1uE8kzrp/hmkdUBNJoQgLYXOdYnut2HPBFHV54eFw5mZfI07ne80pThmKGFjghCWVYLBHsv3ymUhakz4KTwS8lHN2kF9RAnwOiwdd+6mrQ/D7AovNLjBCxqHKYxQfVnEPtqydi7uq32dduvCO4Z5gGAgf1syS/o5Z2ZuAECszm5rfkFraQOtMmW82u+j03H9hd8D1I6o0zD9ZtJVtM84vPI0r8FuFpSMTi2d5j2YtvJ5djPDJvRpj5IuUr+qV+b4xlDIEzmbyWdZV/9J82YW9I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b43d180-b022-4fdd-ace3-08d767d9ade9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 01:34:51.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuHRchefntJnLSTFIkDSEDejdtzn43GIf6+UPqg49OCJ2i8/fCSuGDi5WmhntL/PS1CxFmssqezWAdsHi5DsuzaU3xB1Aitx6hAxEIU6UB+RHoxyZzgd6gFjVtApLiok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3597
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> From: Lorenzo Pieralisi, Sent: Tuesday, November 12, 2019 8:25 PM
>=20
> On Tue, Nov 12, 2019 at 11:46:42AM +0100, Geert Uytterhoeven wrote:
> > Hi Lorenzo,
> >
> > On Tue, Nov 12, 2019 at 11:27 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Tue, Nov 12, 2019 at 01:48:03AM +0000, Yoshihiro Shimoda wrote:
> > > > I'm sorry. I think I should not drop a sentence "because the bit 0 =
is
> > > > set to 1 on reset" which has the reverted patch from this version. =
Also,
> > > > the note seems to be difficult to understand. So, I'll rewrite this=
 log
> > > > like below. Is it acceptable?
> > > >
> > > > ---
> > > > According to the R-Car Gen2/3 manual,
> > >
> > > Is this a publicly available manual ? If yes we provide a link, if
> > > not I will reword the sentence below.
> >
> > The same hardware block is present in the RZ/G series, and documented
> > in RZ/G Series User's Manual: Hardware
> > https://www.renesas.com/eu/en/products/microcontrollers-microprocessors=
/rz/rzg/rzg1m.html#documents
> > Chapter 39 ("PCIEC").
> > Section 39.28.98 ("MAC Control Register (MACCTLR)")
> > Section 39.3.1 ("Initialization"), Paragraph 3 ("Initial Setting of
> > PCI Express").
> >
> > Thanks, and happy digesting ;-)
>=20
> Thank you, updated commit log and pushed out, pci/rcar branch.

Thank you very much for updating the commit log. It's very clear than mine =
:)

Best regards,
Yoshihiro Shimoda

> Thanks,
> Lorenzo
