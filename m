Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B036E3EC3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 07:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDQFF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 01:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDQFF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 01:05:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E04E3595;
        Sun, 16 Apr 2023 22:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI1xxIVW+GI3gmYWe0uxDpQLMrKPDL4DmBliPGKdmLiheVQUatRy+dvttPFe+ABFJCPynHJk8L7waWu2OgdzCtO+vX5u8BoV/UGLmjePIhewCdrY95l9yQahF+t4KTQegcpIFwoPFXzvLyIQXJG+urRV4BOzVXg7iZp4X8WHGNia1PDciz8USon+w5YxgfWkmoPYG1xBzt/KuxEGqosJQHMUC61N+Xas8KY5L5U/m0UTsroGdvk0XpyjDJFx0ZlDt7p+jEt+O/kuCCGZBr204Aeu68x9GQyJ3CCEJc/Us+5RMpHM93sAuhTvV7P58GQlnqmMWylWBmHAm6o5oDBe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNTRHy+h/0DBQ+7TZ17miFe0RxNO7M7u0cFmOXGLNv4=;
 b=mPTLAEXwvlWh99vTIw8Zlmc6p77sA8rQb8asQObmm6uSB1jV/cLENhRN+nL8reXIaF6PyUiOorGwKzbPjK7DTrY4KTDjdc+UdFGQL21RtIM4k/Fy1c5z6B3WNyHUQifGMg4gDo4ELvCL8GDrf/dX6kI6TfiIsn3XmpLwh2qhRtOO0ZMzETbiiDpW8DondWNIR+hcUEKcFiHI/Wt03ZQEZGCFJ3jE+jDlcAmQwtpCSadXlud1xQnDDp1xXCfcZ/U4GDlArsZYG25HZlBB2Wvauc6w0ShpU0ztynVFKszt55qimN/olWMsPMIj3OdmLKU8yYRO4RhCI4z9xClEFw6nPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNTRHy+h/0DBQ+7TZ17miFe0RxNO7M7u0cFmOXGLNv4=;
 b=a/fiO8r6qUNNjWEt2SQgxumT7maJMJ6QQMThOR7plVg2T/XwV9x+o+eaNTDT/ptu9Ivj816GOeb7qLSyVSo1dF3ywJwuv5mUyUeXovZE3rA8/QVe9feGupBgFYN+g22etqvjht2cF7qAGZ0vLS5eMCx1Ey3ihxVJwMh/JbEmRCw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11161.jpnprd01.prod.outlook.com
 (2603:1096:400:3d5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 05:05:19 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 05:05:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
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
Subject: RE: [PATCH v12 02/19] PCI: Add INtx Mechanism Messages macros
Thread-Topic: [PATCH v12 02/19] PCI: Add INtx Mechanism Messages macros
Thread-Index: AQHZbpio0JNG2maAWEOtiSp2Bn7znK8rKV6AgAPNiCA=
Date:   Mon, 17 Apr 2023 05:05:19 +0000
Message-ID: <TYBPR01MB53413B963258BAD0EF34D726D89C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230414061622.2930995-3-yoshihiro.shimoda.uh@renesas.com>
 <20230414185947.GA212493@bhelgaas>
In-Reply-To: <20230414185947.GA212493@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11161:EE_
x-ms-office365-filtering-correlation-id: 4f070c9e-7849-45f4-bfdc-08db3f015759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ttf9phgCztDohJxw2SyuzDDAj8eWGoCNWH+QNIAVIrLrks474MAkLecKNfYp/Xccpv5nG/Y5F3lM5u8cMoYJbm7GsbHkwJB2QukWAcviegTI8Zx++mnc27WqrLRqn3G5//bjFZAVRJqawBMe6K9f/WSyEJ4f+iQSo8PHNyP+8KyU886AjTFEDQ2c43axyEnjBsg3N57B2Q6RYDmj/B7wcDsiet1NOcpEIfUtm5O2POVJ12OtAm+X++q6lUPPv9i4McflzKZ57PYmz/YZWJgw8UPLs/fhhVEz59BSwQzR1C+Oqh655VNCw3BPHxO5lqNJSDjM0hbPe5Ivqgy+8pkZ6y2DHldcsy3hHybTsDuo42mOmdajzi2IHPlZeAWoZcYhl/5S0InB245dJN1llRlROZwb+FqP4auAPLnTTD/RG+jlM4Akbl8eSpblpHGUxru518r85e3GKxQ8yiA4+qOYFGZHFORMRgFGFwdRlWYf1cNIAtCV+3/bb7+1ahPf7Ln3v2fcz2Znmu4i719ELvJ5aZZDFFf1mIchIdtILylXGz7RI8DlGIdjE7V6zVSwup/cgyGvbmgeU2pky7z0Ts9L2hlOhqHia2eXPgPYJn6KPZG/qmEQRVt52yfSxk7UdBKS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(54906003)(55016003)(7696005)(71200400001)(478600001)(41300700001)(316002)(83380400001)(6916009)(4326008)(64756008)(66556008)(186003)(66446008)(53546011)(6506007)(9686003)(76116006)(66946007)(66476007)(52536014)(5660300002)(15650500001)(7416002)(2906002)(8936002)(8676002)(38100700002)(38070700005)(122000001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CnrWVD2DAX/6pbeKVwXGotey9DQlwkKKZkIr2ah4ea59R8/PSy1smnzFCdF7?=
 =?us-ascii?Q?bLOxLS4iPiSfS9P73/+rO5mJw0rROy1jTg8LwI8CQEENfmJeNTIhaB7JrZjc?=
 =?us-ascii?Q?Bc6klRud5uoMeErA8Q6sjWp4tJMSFWVu5Gix8bC/fpRNe1uJqLi/QBBbrOh+?=
 =?us-ascii?Q?lZEqpmLXdAhtfn8fY136CPZokFzvorAzJjUmxCkv7CkHpgeSlJnprjxM06ah?=
 =?us-ascii?Q?4Ehfs/Rk229al5cceVLeGaUHiUiTkspjkn1wMtbqy3S75B8j+7p34Zf9rADG?=
 =?us-ascii?Q?Xtx1eJrQLjeWaZcUN3nhYGvWWtQJECEGZhhcxNo0YTOrKkgZ5f7Dqk9Fpbiu?=
 =?us-ascii?Q?bG/PhTDf+zNUG59Cayy3rGQ/azIQ9vDKUttJo9KW8kuAYRPMzX0dbYdadzGB?=
 =?us-ascii?Q?VjaSGNCWrLgp3ogYiGp8GCl5cQObyUlSdMLxUbTRddoiabNf3NoLs+XWH4TH?=
 =?us-ascii?Q?70A2Q8DGVqDDQpe1vJU9Qt69wiNItGTw2CSPtDpkped+4xWruXxro2t03a+6?=
 =?us-ascii?Q?Afkgyo0uwwE3hYPLhipY+8msPE4eqSob8PSTdz4WH/GCSe/OFwH7iwuHQy+H?=
 =?us-ascii?Q?q6M7wUbY4OdpcQ5lIelTprM7Hzoxb/eovVAuyybpRqWS3X5TF7P9AuanYyn2?=
 =?us-ascii?Q?3yT0Ulps3cWRmMt90Y/pI1m6n1phlPxUaV5lkm0YdDh9SopP/ce+hJ64AUgN?=
 =?us-ascii?Q?n4LmgDa+i+fMEKcV99tj5dsAm/SuhMcT2RDeO8L8VU1Ym+4ELCnbweOajw0m?=
 =?us-ascii?Q?hJQlEBp6gvjcMqpDV5s7mnru28gQMPE3TJV61JLKLj4JF9TF1GuKcxPJmWGS?=
 =?us-ascii?Q?vFvBK8zG+oOGsCRINgCSfug/4ybnDvqzLlDMi1l0QzmSc/pJUfoiYJQBQ+MQ?=
 =?us-ascii?Q?LNJ50ivtuiclstgkSzm0gX8D9vSt1HdUfXcOIoVDEQXP96VRnyXHcqAFU1Dg?=
 =?us-ascii?Q?lEe2YfLBQQtQSB9yC2YswuG3l65ap/VGAkKSCLF3pgC9xojTINgFmU3xJ19Y?=
 =?us-ascii?Q?Ze/lLPcHEI4s20C0L4IJe4h9ku1VaYALvGF+ItyEIygc6zn0Jl6TPbx/CCyg?=
 =?us-ascii?Q?yygq6CNqj+8f7wogwdlIXVHu7Y8Wzvl0PQcCepZI/O9yDop88BISXyPWGdvm?=
 =?us-ascii?Q?YdmSCHK5QrwP2kIFJsiGdxZ+2NsoKA1R+Z5UAIyt4GWy++VM8JeNLHw9IFWm?=
 =?us-ascii?Q?OptWGQmJoWERhJ74g5V+voGB+66YlGmkh+nLRZr2tLFS+SChPwUl0TSlINdK?=
 =?us-ascii?Q?IuFcgzKOntyjr/bd+oLZwYeO+BtjhhG1Uj0xjWzzUDMtH0KcD5v6uDOuERNc?=
 =?us-ascii?Q?ABH8BQSnqmxiE2tpb5B5KUgh/vhGm4qFoZzd7A0NZTFsWc/mJ4npsMMdGlrR?=
 =?us-ascii?Q?bp4Oh9OjkLTEx2Esm6eG5G35OILKWCwhPWm7JOKPHGBKOwuALNxRDVzaBf3J?=
 =?us-ascii?Q?FXuFi0saVqE7PSV0bzx038J63KZwZWBi6n54yBXgSe/I/v8nKoUDUtoNqI8w?=
 =?us-ascii?Q?3jieiljcsnaQpg+kZQ/tfJiO6w70OD9/P9TkTE0jDXNiYtzUlRc5TmE1XB9C?=
 =?us-ascii?Q?7WDp5JC2Uku+InyCUbxfo5nAVHQl8R36JZsGytV8swgXokuz3sGjamQry89b?=
 =?us-ascii?Q?eRsjgtjZRxhs5+cFflxIb6Shf8YyRqhzTZlXZnyJ+1GgjURcVsGXOa3zvUEb?=
 =?us-ascii?Q?mr1vQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f070c9e-7849-45f4-bfdc-08db3f015759
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 05:05:19.5753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XmMOYJpGXtydhLjwQTP5bIRDi44wXFoWLvwNZ8O87ubxAWZs6Red41VeoENy7YgKp0HPRpPt7s+K1krlV8JR7MEKS2eCroroPf+DoMZwHNVt7owCPLQrXQop80wPltb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Saturday, April 15, 2023 4:00 AM
> Subject: Re: [PATCH v12 02/19] PCI: Add INtx Mechanism Messages macros
>=20
> s/INtx/INTx/ in subject

Oops. I'll fix it on v13.

> On Fri, Apr 14, 2023 at 03:16:05PM +0900, Yoshihiro Shimoda wrote:
> > Add "Message Routing" and "INTx Mechanism Messages" macros to send
> > a message by a PCIe driver.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  include/linux/pci.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 0b57e37d8e77..ada1047035a8 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1050,6 +1050,24 @@ enum {
> >  #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
> >  #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
> >
> > +/* Message Routing */
> > +#define PCI_MSG_ROUTING_RC	0
> > +#define PCI_MSG_ROUTING_ADDR	1
> > +#define PCI_MSG_ROUTING_ID	2
> > +#define PCI_MSG_ROUTING_BC	3
> > +#define PCI_MSG_ROUTING_LOCAL	4
> > +#define PCI_MSG_ROUTING_GATHER	5
> > +
> > +/* INTx Mechanism Messages */
> > +#define PCI_CODE_ASSERT_INTA	0x20
> > +#define PCI_CODE_ASSERT_INTB	0x21
> > +#define PCI_CODE_ASSERT_INTC	0x22
> > +#define PCI_CODE_ASSERT_INTD	0x23
> > +#define PCI_CODE_DEASSERT_INTA	0x24
> > +#define PCI_CODE_DEASSERT_INTB	0x25
> > +#define PCI_CODE_DEASSERT_INTC	0x26
> > +#define PCI_CODE_DEASSERT_INTD	0x27
>=20
> These look like things that should not be needed outside drivers/pci.
> If that's the case, they should go in drivers/pci/pci.h, not
> include/linux/pci.h.

I got it. I'll modify it on v13.

Best regards,
Yoshihiro Shimoda

> >  /* These external functions are only available when PCI support is ena=
bled */
> >  #ifdef CONFIG_PCI
> >
> > --
> > 2.25.1
> >
