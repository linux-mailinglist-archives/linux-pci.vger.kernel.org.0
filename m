Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E917C6EEB0D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjDYXmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 19:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbjDYXmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 19:42:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9D13C3B;
        Tue, 25 Apr 2023 16:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcsNboqqdiPN2Fgbgis+KkguJ0aFd2aOVOwruHWP+IY30IUiTlHIYKqoaiE90Q46fI9/eNwyzQSnDeS+MFopKlEWgh7r0End+QKs9g/O906jhSlKbp4IpqCVJyZraii7VVnRJKm377COI46kc/i9Q1kvKX4xM7+1Ih2XX2kcu5u+vfYxEmH/GVqQPUHRRodIH/9W3+73xRej0FuWt49pFLOsoYnRV3CscgoSAdmqBvy6L0upB7wm5epbIr7SOnYNDZKaUx3MknVXv/HyG1ORUm+diVIraZKm7S1GiXRZ3MpRdosFu7QPuMd8GXvPBUGH1asECzyowLgfNfYGvCLNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqDt47JrIM3o68kWxz7lJ+D9stZrvjBUlg0Tad6tbMw=;
 b=hafyznvHYtPI+Rmh4muCHXzTUZNaObXzjYARW6s7fETmibEB1S2s4TFTughNffPq/Ph2MxdVt+e2u4d6sf1n1cjxqFsZCgjtuL9H34WqM1B7qqjYHvapkNPQZr3cNKug9V3xlDHDi4PK2uFxSptAOFyaxzuFK/O+cqkNQmO6J1sxisTwxNa4OgLwuFt8YUSzY0ezSBQbBFMMQPuAyDWQUHSLiBeB/DOKEaF67iTx1vMwH0FXlkDN/3didAGt9MKH/M/0eCcBaQ9fVRI6cdb4yW1T4KIbYwpwpVhMM6r9C/gXLdnKsXpHuYGk14c5rHSs6ZMPJwepwUJv4oCdlloOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqDt47JrIM3o68kWxz7lJ+D9stZrvjBUlg0Tad6tbMw=;
 b=TpPoTFBXdiTq2s3HsFw6LZBlD9K2//2FEoaTuQsx7UAhiclssg+KKEWbHvGMjOS6uAwS+rxrGFNv4kyS+NU6sUm7pz82M6YQtDZa9wEaq7wrUSWQXvH1pgxJZqbXLOEuxedSPj+kgNwSYwYc5rQBvtIevCBRsXViDH2wKLBeQgw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10504.jpnprd01.prod.outlook.com
 (2603:1096:400:2f9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Tue, 25 Apr
 2023 23:42:32 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6340.021; Tue, 25 Apr 2023
 23:42:32 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v12 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Topic: [PATCH v12 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Index: AQHZbpioU+BQJONFN0aPxrMcO53bQ680s8aAgAABQACABz/tsIAAFtGAgAC2DpA=
Date:   Tue, 25 Apr 2023 23:42:32 +0000
Message-ID: <TYBPR01MB53410A9E2025143223EC2A7DD8649@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
 <20230420204129.azbopwklu2yetfrf@mobilestation>
 <20230420204558.4csplhtkz2co4att@mobilestation>
 <TYBPR01MB5341BD8037B4E82C4E5CEBB9D8649@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230425125015.qhhlw5aqnsofq4vb@mobilestation>
In-Reply-To: <20230425125015.qhhlw5aqnsofq4vb@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10504:EE_
x-ms-office365-filtering-correlation-id: b601f2ad-b0f0-4f3c-9978-08db45e6bd54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOpZsygIjywyHBKp3wBhUKQOf3E/P6A7R8cbeG3KHSEiWGW9CBfFviHqKhPn2B+Gq/6BmPb8i6EsYA4f3kA3CJ1eC254LFwrKTl2gdwcqITUYuolvZOVwfY1/56SKlJ1R2VN7uFcy1z56J08/MLHKXlmuYOc0VqGtoEaZu1fewbhczxjXas3Ibm7RYo2jG2QT+guTXAz0yiW+XtXGMGGoRscwgEDF4daCWVM9DYIguJmKIHpmizssR8J+ss+aPvO/5HYGT5eHrWc8OS5Zhq3QRuVYcg/t7w6fPZWiHJqP+m5wBJyqXOvXHENSrGzlMt3A2oZPyu4dw78JOK/+4jSq880LUrB7UOkLWbaogvCtw7v/YIz5oCSekuw3ErwMOByYMgoIWXKiX2zEj89DPsrsnyJI+ThkISKXo9bS2zxwSiosglK7WFWHu9lrwMaobx4EmuuUeblqvfznM3sRBR8P4uijacb4Y4DTF82Dtaej3zjcG98gDw0ckjNkpDkeSGCU8dgQJKVe4rrEtX5HEOo0dM2znD7FgcR7cTl6YZlfEtnGGfpF1wgAUan9Gf5pQMLxu1vi2ge9Q9KomVIJM5hdPv49VBGBKfL97LY2OZIfLOVKeQCDqoPmg/gXBpAtEgw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(55016003)(9686003)(6506007)(6916009)(4326008)(316002)(8676002)(2906002)(7416002)(8936002)(86362001)(33656002)(5660300002)(52536014)(478600001)(54906003)(66446008)(186003)(41300700001)(83380400001)(122000001)(38070700005)(38100700002)(64756008)(66556008)(66476007)(66946007)(76116006)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PUuw0PW9iOlXTijnxElouEOpQ3Y4HYfyaFYpaupcAECPs6dhhDy1z3OIe1s8?=
 =?us-ascii?Q?lOWTPe+SN96d7bclCAgM8SioxqAqj/sX680bNr7EUcR58OuX8z5dFIUFtrbm?=
 =?us-ascii?Q?D0mxp7W43ZZboqOunqzex7ZOnGEG+ijBlmBBHl/oPFW5JLVDrkILIH5mN8pW?=
 =?us-ascii?Q?qmnPNTPLVvEBQuB+szi1yDUmY4XpOdQG3b74cLChdzhWTDpifmfZ2GMqRkTl?=
 =?us-ascii?Q?B0AattI6Q8mRON309HA8YpNuqnnDTWrtCXzjc6CH7uzPoSogEkJdQ37kcg1n?=
 =?us-ascii?Q?ezhBBcqaNrZh0Tu3nNEeMQUuiisdLdQfZKI+pYTBZR1ExnIPTrpjlDwEMd+s?=
 =?us-ascii?Q?+kzHWspmh9OdCHB/B/FqJea/hb941WzMcb8RQhA+IqaAeg3nGuy2Vj+HZ+Ua?=
 =?us-ascii?Q?CkuKr72Wi3eaKJV2Q8N0FBXlNEtNh3H5QuNAKP6ZLDOaomgGJ8V+fTs2Ch8O?=
 =?us-ascii?Q?GUbFehRe/Ng9bzDHQViC9ETRSTPc1licPpngNw3w+yONjWrh4mXfjIBCovSD?=
 =?us-ascii?Q?0xpjldHbTWDDTTjAF0iikHJQ+9yNdzbyZdVDknPZ8oGdbpz8Fock+c0cC+JZ?=
 =?us-ascii?Q?0LWaa5X/DwNvcWhPEkPCq21uwlu6ewUPYpY1qy194qPDr+O9azH9r5IpbOU1?=
 =?us-ascii?Q?gHshMnobZ0cvQwuhEErGTs3xHzMVIxsU48N54rvJ+DJfe2E9lGj3BldmJKUC?=
 =?us-ascii?Q?LS6x59SGB48scq6/vWR6z8IHXN/6LevqoTBuBphwc+5HdQDRQtEz9J4xyZvm?=
 =?us-ascii?Q?B9LJImbDrq7/UtKdAzdoXkZOhgpNpbViwl/8k7ok4ycgC1mqRKvuB3aTyu5f?=
 =?us-ascii?Q?a5KxDWekEHO4hnAHPdocFZryC3fAKM5US2Wk+RiU0l+6eIZjz1rdMLvgJ+dA?=
 =?us-ascii?Q?fYimHRyN1mtpfsBUgAzO6Q9kPBjkt6taPagpl0EK67VAytusrTqgQBFIEo18?=
 =?us-ascii?Q?x1TCbO2r64aiKR4it+0599cf1axXuNJIQOlfQRMiN8QByftX4Tm5XxFexTOy?=
 =?us-ascii?Q?1n9Cb/4HI5WXN1CeEW/cho0czgIcjWQpgf4zgX5wcEsXEseqXpKjvdTC4wbB?=
 =?us-ascii?Q?mhK9FhVbf2MSC6DCx7myqifBaEBdnjxSpV9jz9uMik1mWdh3VdVMkhIdLmKl?=
 =?us-ascii?Q?UHO6YWyLpRnJbVFDVl98m3NjhGLoQBkdUl1obr+xvAeglh2GxEP6GBFKOA6J?=
 =?us-ascii?Q?C8C6F6V5Q4VWdXBa6Lda0fd2SL0YHgs3zrtB9+s30xkVun/qws4x9bWDejBP?=
 =?us-ascii?Q?Qp+04BP6C7aGLJRr3WqYQdvQ91MZoq5gjZ5DznRC+/xK4qoCwdL/Y1HEm5KJ?=
 =?us-ascii?Q?AprZeHrM9oX7SP0vVE5XjyuoSfbGu5hUhQU4oV6Bv9z/EzucQCbuW76Id2Oy?=
 =?us-ascii?Q?G292ZIQ97iIjcYcGuLiG6XP5WNQfStmrD6T/+edTBXbnQD7muwj1QflpdVsL?=
 =?us-ascii?Q?DN+oqHpjFhrzNnSdUNXoDbVfw7QxA+uEePkOFLN39bSMDnjExiufjUC8g1a+?=
 =?us-ascii?Q?euD/LkhTgbCrqK40OstcTHVfmW7XZy88sRJ9hkscu/XHCqwa/BEc80PFkZLJ?=
 =?us-ascii?Q?UbP2CR+RDvPAYmdLZ3JPDvK02U3uf9Xboh7+KG87WQd19/+Iojf7JI3UAdbL?=
 =?us-ascii?Q?jwujarOPxkcCnD+hQ2dmR9iDEzfAmT99DtnAfbJ5Z4LPju5xzzpwUBJPylUb?=
 =?us-ascii?Q?bB5Y8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b601f2ad-b0f0-4f3c-9978-08db45e6bd54
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 23:42:32.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELblEZVN/IAyiPUYF/M+3sycWE0CvGckJBqLs371WMKWW8JI1V1tjyd94LrK+zUuVYxpX1jlamdnZg9CcDBlek/NL5piqDlM39buVMWSdn7jxSVQOeQVj7zxuEyI7x4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, April 25, 2023 9:50 PM
>=20
> On Tue, Apr 25, 2023 at 11:33:58AM +0000, Yoshihiro Shimoda wrote:
> > Hi Serge,
> >
> > > From: Serge Semin, Sent: Friday, April 21, 2023 5:46 AM
> > >
> > > On Thu, Apr 20, 2023 at 11:41:32PM +0300, Serge Semin wrote:
> > > > Hi Yoshihiro
> > > >
> > > > On Fri, Apr 14, 2023 at 03:16:03PM +0900, Yoshihiro Shimoda wrote:
> > > > > Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> > > > > To support them, modify PCIe DesignWare common codes.
> > > >
> > > > Thanks for the updates. I'll have a look at the series on the next
> > > > week.
> > >
> > > Oh, I see there is v13 already submitted. I'll send my comments there
> > > then.
> >
>=20
> > Thank you very much for your support!
> > I got a lot of great feedback from Manivannan, and I modified the patch=
es.
> > But, should I wait for your review on v13? Or, should I submit v14?
>=20
> You may re-submit. I'll send my comments to v14 then.
> * Please make sure my gmail email is in the to/cc list.

Thank you for your reply! I got it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
