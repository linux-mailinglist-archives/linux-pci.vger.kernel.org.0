Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2944C721B8E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 03:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjFEBiH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 21:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFEBiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 21:38:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AF8BC;
        Sun,  4 Jun 2023 18:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN9g78LbBfeZMoOAxC8V2v6ZYyYJBkrtuGN2E0tVnuKxD68UN6dGq0RWXehzF2Q/yRQOr4gZ1tRb6QyUdR+4GCsXpdc4p8xTAQ5H5sqjzVUaMm/46LVoe4+RejG3mttBec/sX3aLVyfSB3kFqXG2GSHA69vk9lJ0P4dhi06d5XAVH5bYUefDpJmhamqhbmScgMTVQXA+Cqg+ejeJAohD/SbgfmDWGOaKdFi7NICNjz3s6Tyu6A9rvVS0yYyaUpBcu9KLkqi0maYDb9pJ8yfQypIdRLWlEKlLm7wrXy+Pvqi/ilSJQyuFEzY2lTG7FtNO/BjhdgsrmbX0AbsnR5FySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxUGjWhOaMKwLJF04KCjV1+L9Y8NMzaJGt+YBNlVNVU=;
 b=Yo727Cb5x6riHlwoL4Pr2jKorgzlbNGSsbHxT4wq/nz4ld2sN4Ol9t2TlKOx/qFJw05p7sIy6V5tA3TXpWq/VDIvLXYoTmm+QmGMtcZZKl8Jitdg0LQV/qopcmNnv9UjKa6yygI1krd27DG0GGWhh0gA18j1xCXmwopTm/HLX+cEeOWM1QdlflrS1HNQxRf5HBkzfW6AiRGqBUtMSAT9m2KOj4Uoa/K76w78h3IBr+J/iCYQZaLYzi/pOgZ+lXuHaVnibfhYq1afSMrbD1Ox2lmwj+gd2SBdVtQrOIFDt+KiD2/zzdbBNcfLsO+68JCEWTeMDU7lQswSnxuGYap7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxUGjWhOaMKwLJF04KCjV1+L9Y8NMzaJGt+YBNlVNVU=;
 b=BuUN5vRfeW+IQV+3BEOzLfas6wiLfkuqO1G82XFvEJaB2FHl/83Ho1Gth+Pi3TDL3AUL5lgkkidLQQebSgqA+x8c+ZaXD2RbwkWkjfSB4qAEi8Ape3UB1H77vlNnczSEGt01ELGHEjnJ63Zn4Sy1tSYn1k9eZa8s92ct8PrZgm4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY1PR01MB10675.jpnprd01.prod.outlook.com
 (2603:1096:400:31d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 01:38:00 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 01:38:00 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 01/22] PCI: Add PCI_EXP_LNKCAP_MLW macros
Thread-Topic: [PATCH v16 01/22] PCI: Add PCI_EXP_LNKCAP_MLW macros
Thread-Index: AQHZgwfRNypZz/ijvkOLsJCqGkmnGa97Z+QAgAAVubCAAATQgIAAEgUQ
Date:   Mon, 5 Jun 2023 01:38:00 +0000
Message-ID: <TYBPR01MB5341340A0E03E6551B26A53AD84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-2-yoshihiro.shimoda.uh@renesas.com>
 <20230604225036.earzdx5dvzc3imoz@mobilestation>
 <TYBPR01MB534183482CD31D122C4735C0D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230605002535.f75gn32artzoyiat@mobilestation>
In-Reply-To: <20230605002535.f75gn32artzoyiat@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY1PR01MB10675:EE_
x-ms-office365-filtering-correlation-id: 3a07c690-d7e9-4359-9f65-08db65657f79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uKY5OWAL9slfDXnUaMTYSw9/CPke/DlAmqeHSVt2Txq2elc/WR3WCWctiHUsw3lHbeYE5jhpGacjQAuIkUnlf3EOCYdTQFg2gDx7yNxKS3x9bwyYPbRZCSM56SJMm7m1Ax4j2djw+SDXeEf228GRHbv/SSCIf1mWP9E4soETVKboqjwjZGvDX9r8VW8ivfzbQURDebiiCIgKVNjRExaD8rSoK6Gadx2RHrsKyphv1GX7hK48871Lt8Hl5l4o8V2KUKSKS8E2WME+FeUdfc/T20qGu4iuwJdUiGCVH00puJQEqD6f8kMyo1oXiwuT9SAhez38WgWQ7VKXj49UxX8vb4/zswnlj1tLTw0CtvtXXrUwEf40M1Na716CU0dgdX8ulK4L08z00Cf5P1LEdsKhNfD32BPeljiZDSDRaQEBacs+kjbeHwrE0IMVXnXiyal5IvGUSW6UgTynOqrxgIkc5JWkrFJaJUb+iMG83A4oVX9B0o68gxmkM0LjiEXAxsUIW2Isngxu6Q5OsGkFEa/fhFci3PSFBLIxawaxEz9UOf3S6uCokUspJxHUN8Fkr5mjt1jnJsylj0VB2s4YnMXE0UcTcA4+UXQiYL+pWCMA7ZjX29roo/8LpUhjC/Im1dVI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(9686003)(186003)(6506007)(7696005)(71200400001)(122000001)(66946007)(76116006)(38100700002)(6916009)(4326008)(478600001)(66556008)(83380400001)(38070700005)(8936002)(8676002)(55016003)(86362001)(5660300002)(52536014)(33656002)(66476007)(66446008)(64756008)(54906003)(316002)(7416002)(2906002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fV+9DC4TVguaauY1XkI+Ray26NV8Ua6TBwNZOVMfq8pal8kdgK4DnINTBRMX?=
 =?us-ascii?Q?WvImvwQF4NSxeygIdjSefRQRrK1dOSqtmYZ04STS+BtpEJCQ9yWE6ixs/63v?=
 =?us-ascii?Q?LcyQZFWkUJwsq4nBIb0PocPxJXna6/inqE0/V4EyS56gbKQcumd0OZrEQya3?=
 =?us-ascii?Q?WMnEPYR1oVyvvIVGvmRf3NpTcmi7H4BTqrXCshkJQyQIcMDFUqvVw7elC5TH?=
 =?us-ascii?Q?ZwVs6i2u3dvU2742SuTVTIy9HYxKtDdTrGTK6hPLpDYqSeNX/xil/4K+1jkp?=
 =?us-ascii?Q?w3QI+4WbLKkrdgGCp7DEcAIKqdCLoyeq68OA323HLXkGMPAqQoK3imtKGE4I?=
 =?us-ascii?Q?4xDhHcuck529XabniPwEzJY5nswiNPRikfTbS5bg7tINqddUH/PbwwsWjMXr?=
 =?us-ascii?Q?zZodG7v1c4qPcuGB8KKdHuIRvR2ZRoJ+aeZa6xppRLJr2K7tWzsKofNWts9m?=
 =?us-ascii?Q?tsF3Q6lpvHEFef83CFfsePBV413SzoNSWtYCLgqG+u0AXQsIBlc+oCLRSwZP?=
 =?us-ascii?Q?ZRGDmjcdpQOrsF5sHN/bLrU5VEh8C8NR5l2Ot5oT/1TtW/fnOvJuPsXlVZ2y?=
 =?us-ascii?Q?V5sTi/uNnMybq8b4cgFneEsbiuiRNZhBFmhMr406SUcm7kG8+WBLtYEpQFuQ?=
 =?us-ascii?Q?Gv4GcG+uJKRCKpW0RQkfhyFa+BpVOKcxYuqxRADqnGxKf8Vix81qtn0Kgl5C?=
 =?us-ascii?Q?wCSaBiOAuCz4zttJJhAxkoQLxUXknQ1She275I2r8JaMP1c9R9xaPnMWqbj0?=
 =?us-ascii?Q?WZhNRIT4fxH0rOroCBlD2E/40ZyebzbGJZoAG2UtvA6ZsV7Sj91N627IRdeo?=
 =?us-ascii?Q?iqDbNL0VeAiSwOGV9sEM2M7lo45qgHH8B/h3/aI6/uyQ9jx+piXJLdmGz5Nv?=
 =?us-ascii?Q?BqQPUplWKw7VC0OnIGhxwfsdMkalGIFoX19GUVEzEXSKrqhnzg8qKjC9CoX2?=
 =?us-ascii?Q?g7K2L3N23f98z51TvSHd64OebfOv0aSPmqT71wpkIW0nDQDfSh5ArMoCQ0rR?=
 =?us-ascii?Q?AD49cSVMSY7gMv7rSJP/Z+JppIIvM2O8tB3IwFNoA2Oa6tgaZ+q4I60EiO2S?=
 =?us-ascii?Q?dL9uclCqZBXMN83+jYYKCmz0aIzJY2WaZNXz8haHkFfuB6FQ/q0PyzxvLR5b?=
 =?us-ascii?Q?lIXRdn/BO/QbYsclP/PjVtHsTOGeVxkGmnLQFAs92NahUbRNCRC97Wq4K/KS?=
 =?us-ascii?Q?P4VGlopgqDZY8GAtmboLJ1dcfn09Xxel9kAjrW3+dJ0o7IpDKeO1AlVG/pSd?=
 =?us-ascii?Q?NLqZf84onfiw9cn2RoWYuULZVBvqdDFH/2oGbWgoAiuMIZV3ay/lrygYO9R9?=
 =?us-ascii?Q?2G4k+Nbf7hyhvPEvo1DP9F3bmfUG43PGL0qbWaBb+Rzf/IZLgB3/R9J/1di1?=
 =?us-ascii?Q?x3mx7Q9HrbsfN8gjC5xUqgHghb02qtgDvTxEvaOZSEs2DbVBMnLr1jUWXCBy?=
 =?us-ascii?Q?IVIXiwIXrFGjF2+xF1dXY+AlSS26C0lEE9ZHjeHV0ixMTl0cTt0FqoOu/v5T?=
 =?us-ascii?Q?qrylDJ/7SihlddS8AsjO2uuqdYkk1M0M3iB/HaOhJcFFleESVXSCj5ww+Aob?=
 =?us-ascii?Q?uNIlpi3OL2UMliQXYyffz/+A42XP4YjAlZT8S3B/EjmeTu+bM3SJO0aL7SK9?=
 =?us-ascii?Q?LWnxqe8EW53BMAyAWswGY6SOn4Xr5ngB18m42p6JgrlnJ577WF2/TnTdWcVu?=
 =?us-ascii?Q?Xrmiiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a07c690-d7e9-4359-9f65-08db65657f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 01:38:00.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgVP5ya0soIBvS69ZRFZB/puoe06yczqODxoQdnKwXf57o4Fm3rb93sg9OcKMPPtc+PSGYqAnOaB2YHy5b/pckNAlBJfKIN4A/RecdCGcqkUrH01ph49NNHtUZAcJKQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, June 5, 2023 9:26 AM
>=20
> On Mon, Jun 05, 2023 at 12:14:26AM +0000, Yoshihiro Shimoda wrote:
> > Hello Serge,
> >
> > > From: Serge Semin, Sent: Monday, June 5, 2023 7:51 AM
> > >
> > > On Wed, May 10, 2023 at 03:22:13PM +0900, Yoshihiro Shimoda wrote:
> > > > Add macros defining Maximum Link Width bits in Link Capabilities
> > > > Register.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > You haven't been using these macros in the following up patches since
> > > v9. Why do you keep submitting this change then? I would suggest to
> > > drop the patch especially seeing the PCI_EXP_LNKCAP_MLW field directl=
y
> > > encodes the link width thus these macros unlikely will be of much use=
.
> >
> > Thank you for your review! You're correct. I didn't realized that
> > the macros were not used on the patch series..
> >
> > However, I also realized that the patch 11/22 used the PCI_EXP_LNKSTA_N=
LW_SHIFT
> > macro for the PCI_EXP_LNKCAP register. So, I'm thinking that I should m=
odify
> > this patch as adding PCI_EXP_LNKCAP_MLW_SHIFT instead. But, what do you=
 think?
> >
> > --- on the patch 11/22 ---
> > > +	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > +	val =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> > > +	val &=3D ~PCI_EXP_LNKCAP_MLW;
> > > +	val |=3D num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;
> >
> > Perhaps, this should be PCI_EXP_LNKCAP_MLW_SHIFT instead.
>=20
> I'll get to that patch tomorrow, but in any case there is no need in
> defining an additional macro here. There is a handy helper FIELD_PREP()
> for that: FIELD_PREP(PCI_EXP_LNKSTA_MLW, num_lanes).

Thank you for the reply. TBH, I didn't know the helper FIELD_PREP(),
but now I understood it. Since the pci_regs.h has already had
the PCI_EXP_LNKCAP_MLW macro, we don't need to add any macro here.

> IMO for the same reason the PCI_EXP_LNKSTA_NLW_* macros are
> unnecessary and can be easily either dropped or replaced by the
> FIELD_{PREP,GET} macros usage.

I got it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > ---
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > -Serge(y)
> > >
> > > > ---
> > > >  include/uapi/linux/pci_regs.h | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci=
_regs.h
> > > > index dc2000e0fe3a..5d48413ac28f 100644
> > > > --- a/include/uapi/linux/pci_regs.h
> > > > +++ b/include/uapi/linux/pci_regs.h
> > > > @@ -538,6 +538,12 @@
> > > >  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vecto=
r bit 3 */
> > > >  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vecto=
r bit 4 */
> > > >  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vecto=
r bit 5 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1=
 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2=
 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4=
 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8=
 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x=
12 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x=
16 */
> > > >  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
> > > >  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
> > > >  #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
> > > > --
> > > > 2.25.1
> > > >
