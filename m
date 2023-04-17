Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0B6E3EA4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 06:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDQEwE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 00:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQEwD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 00:52:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2097.outbound.protection.outlook.com [40.107.113.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0E30CF;
        Sun, 16 Apr 2023 21:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzlOKKQkl36x6MUkpUFknHozaoiSLxVYLgCuY6rSbWZ7qW/F8eUF8eRJsjUFRb177rVlWcXwI4Q9L4yZe1o6pRvkLwejOrq6jVaSRusp2bbRjk5mY2Otig1T6dd0MJFQQeIVk4hWoZlgUSkJj8c2D0Fg1V2o9MInnA279Vj90GqzoTWJThBgkCU7ZFMpK0M0I5Kj8sJelwdsq3U88lPmsiKHM8Tjj1s8SVO2A/Od9lY76aC6oAxfO5Q103e6AOCyQa+BS5LtkeqHNMNmkJwxpYmCwC/sfzkXoK24ifiLOBBRRAonMTGpxavzl3XhR4iNez934SrjWYDvLde5dBm5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp0GO8nmUrK2L8oClsYamF4pL8Rld42Wrnoh8Iut6so=;
 b=fpgqPKQMdvYinCkdos9Fcigc8HRqw57C4GcD+kuZxu5T2yVThPfAp7rHj4G0xJ0cjNnZLR/LXRLetM8sFIpLSSX2D/PbWhIsAzTXaMUfHx2rg74SjaOgR1SdlWTsnI8bQnPDOW+iwyz2VPrJN+fYYmNEGez9iTakqg8lkl0Qmj8TIm4tjsqy8RFAC+DpC03NeTr9P6YVdCrV2C0CXe0vgqHHD0SZCUtNgieMVGs4xRo/kUxeZ8VeGsoUEqmYy4oSXQ6pr2coUe+3+V6EQQnjoBeLCrPuZBkwvfsh79OIBixFmbzSKyDsM8wXKVmlQ0+z4/j0P4KJZpwDNuNhFCEQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp0GO8nmUrK2L8oClsYamF4pL8Rld42Wrnoh8Iut6so=;
 b=KQcN4Ay6AVY1AopNbfoP49N/IXTKpBk932vosTSIVmD4gghqjyLoaBif0aUlQ5HhaLy99MZBMLpJYWUaEGByF/++KVnL+hfc+60PkFxEPkbi6vk+pYDrV1Z4cdngJzrxKaIHW63eVgHMV6OiH66unxnBBkQtQ52QffIHWDjdIpU=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS0PR01MB5346.jpnprd01.prod.outlook.com
 (2603:1096:604:a3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 04:51:58 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 04:51:58 +0000
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
Subject: RE: [PATCH v12 03/19] PCI: Add PCI_HEADER_TYPE_MULTI_FUNC
Thread-Topic: [PATCH v12 03/19] PCI: Add PCI_HEADER_TYPE_MULTI_FUNC
Thread-Index: AQHZbpipXq+UNUurd0mXqLmdBe8ObK8rKO0AgAPIv5A=
Date:   Mon, 17 Apr 2023 04:51:58 +0000
Message-ID: <TYBPR01MB53418E476ED24B2BA922B7B2D89C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230414061622.2930995-4-yoshihiro.shimoda.uh@renesas.com>
 <20230414185812.GA212427@bhelgaas>
In-Reply-To: <20230414185812.GA212427@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS0PR01MB5346:EE_
x-ms-office365-filtering-correlation-id: a44bea63-67da-45c9-e78c-08db3eff79d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cgnsEaF7KsVbY0DWO0NSlzqUM4DodAuCBVm2LwMaluBkep0XrPclJ2AukuXUbtp91u4I6JGJunWOs4YCAM9iizQtUlFuF8CHttcwSWi65BS0utvmQAF9iAqQsjNnaS7UM7FB4c/3+7F2fGQyxXfSijzTSsBdJx4QuT8yiWQPCUjxS1pxwUW1bLn4InNLq/gvcXVIUFLpOWiIIHo1KMGShOifqH8TdNy4fxuRl7LZUSmXT2MhFEtzFeJWUOzTmabQeRifQthtISu9qMr6TTPZ5awOjPhfUnRG+tQQ8oPa3+X+auyCzziZfWbB2yqjQXuCsmW/nNEy5ykRm/W1AyEkS50RDX2srfzltUD+fIJ4a98pXugGpLaja4AE/eGYkkar6LCYo8xou9v2/SHu2Uj+xTBcs8z7qsu3VWC/qvpa49wXffKhWXCsWXOwurDuLy1hQDnjk1HClYbvscKwVBQCB3osB6fVfnjevSGb0Fnt3N2Clh2PrOGA9WC7tYsBgJdeT5p6pqflRDsdcWsoL2lm4s7E1+4n/1+djwDSm9S5MWMmiGpZ5HXAoPqhHZMVnWVB/TEgNE4+G+x2+mh62vY9WBQRnsBvCT3aM5BJYaBMOIUPTmpzS9utQ0YxsiJsxEW6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(7416002)(5660300002)(52536014)(8676002)(8936002)(316002)(55016003)(41300700001)(76116006)(478600001)(33656002)(54906003)(7696005)(71200400001)(186003)(122000001)(6506007)(86362001)(9686003)(83380400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oppnSQEKbvqcFvZOE6WD01eDozeqL4Ed37b3r7tJvGGlQnU1BHiBwQoxz1nv?=
 =?us-ascii?Q?1tgeUcbPguetnJPsEuIxa1htaKUb8tWhcj0BCZ1injnWFn9WPjnigPNgyijz?=
 =?us-ascii?Q?Mc/s0WSfl68+nUx7bycQtEMTLeOfTYeKpCK3oyKGvrZQWYdhNg6+xpKI4aFy?=
 =?us-ascii?Q?thTdUiKalIftPfWUV1TcosaKqR8o+UaHClEhuDZ7Rj+dAVOwqjUyRitbMs2h?=
 =?us-ascii?Q?sgm3W1MIegMSpCzXx4aaLBFwNI5cwKJnN7AsnbklO9YyCc4c34kKhysq79sb?=
 =?us-ascii?Q?/3xiFe4nR8U5EVIBFJjyFXwa0fSwJ0yUxye12XJ0fAAFYO4mKrF4awQb3+l5?=
 =?us-ascii?Q?MeVgm4/+HUTVEDs1BKM9lhVR/RSoupcYnTqw74434fNlURvgzCPeUZMLgbpa?=
 =?us-ascii?Q?PVsXMa44Y+nfbaPLpz+9nLKiVPPsHQi9pJ/Vq5ZalOoR2JRAPTHlcS8AvS3p?=
 =?us-ascii?Q?rcBrBpXYt5Wo1mBkHmUeUgARx0jAYyuFJ16Oii9nOv8sjsoF9yKdl+6SmmDV?=
 =?us-ascii?Q?rJWnBnOZ4khcdixFM37QWl0FLlLUuaX1Rd5IhGSVhGuRKbDzuhidSR5AuOoK?=
 =?us-ascii?Q?0lSS3VjCXWzVWvCxLqELMMo2sdGWWLEC///sE9IPjJUax5z514ww2owhC0OS?=
 =?us-ascii?Q?0PbplHWlAhyZ+2sgz/Pmc5LMsh2O/sXQqT3OaUYOoX0pDON4tiw9GJzbj1U6?=
 =?us-ascii?Q?JJ+Z17QiEZK/izjmWXX9q0wNQNmuAsYK4KikmalRAaGgVKSOc0X4VuSTWFB/?=
 =?us-ascii?Q?YyKUsJ7clDqsvmnarhBiGfkiGYVj9GnTfHKdvB1ZQwS189Hjkp0saeX4gGS5?=
 =?us-ascii?Q?HTvfOrcRpVego0iqEizudScK0vYA/vpqnVHVK8xEA2spH2JopNQFVKDLGjo7?=
 =?us-ascii?Q?wKUhUcg755d7iPsRgpGVVN1gdHYz3GfAdNBzpSs+88noj1LIMQWiAyJv7UeT?=
 =?us-ascii?Q?XEGuoDyEUwy1teVwxIM+P1QP7Ti/vIdZ084BWOnIJbVKsfJzZ+d+30/IbPer?=
 =?us-ascii?Q?60vKlGhtcnDa33+VcgsmCYRWRuSwjshLqK3BgvWHORlcjcNJfRb8IN/oFYVL?=
 =?us-ascii?Q?Fy+MYgM583YdhPA0/9AHZcSjDO4GFrYTYWh37YAM3FARy2tF/buld4/bvYR6?=
 =?us-ascii?Q?pf4PF/VA85iozy+H6Nvzx+L9aFj04iSsNu2+Epj3DQI/KmbSIIP0N0t7vdni?=
 =?us-ascii?Q?r32Xo6jPtL38PxKD0r7tHPkjoZb8xxx60ZvvyanSyzOw9rqujvNg1SXm5kji?=
 =?us-ascii?Q?FhViQvcz+YCRCp1SH8qWaff3xkSMHcKS8oW1WUgGo0cDD5YJY7vGDFLXYgf4?=
 =?us-ascii?Q?5LXNMAasNSxtW2qPjL/ZkZhwphJIUACae6dJLDi/JL36QiL91qOMxQPIQXPC?=
 =?us-ascii?Q?w0Xtl9nVuKUKlCHUerJG6xHpzfs7pj5UksX6ijaUwUenpw514SV7vEHzxsjF?=
 =?us-ascii?Q?c9u4c/q1ivZyc16OrzAQW6bUEgJyPeQE0ZEqcMd09RhOaL42ePaIN5iL2R6o?=
 =?us-ascii?Q?Fhn7VeHataD3l18hR/iB42a2nNVAzSXebbzWCE7coMd+BTR/oE9t/zT0PVAc?=
 =?us-ascii?Q?aiuVRcWSCh1lhXEqHVdvcQwbxHEWaegkrsMz4AxR0Iga2d7DrQS3frYlZrU/?=
 =?us-ascii?Q?UrYvBE9ctIvEtqY7diKnw9V4/LtiyW1pg4akNBNL+KdsnjTt/qCcjT64j97r?=
 =?us-ascii?Q?02w9zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44bea63-67da-45c9-e78c-08db3eff79d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 04:51:58.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGQ2NzYWRQQZ5FxbSsyapBp9vqCkwtP48P35m28qB7jQl+dpDZKU4oyc7LbUC50d7uTxTbCi017TJhhNE6+1/svq4zYYPUkNaG4GGuMfxL5LLCJQqmFXKu9Wq782uNHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5346
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

> From: Bjorn Helgaas, Sent: Saturday, April 15, 2023 3:58 AM
>=20
> On Fri, Apr 14, 2023 at 03:16:06PM +0900, Yoshihiro Shimoda wrote:
> > Add PCI_HEADER_TYPE_MULTI_FUNC macro which is "Multi-Function Device"
> > of Header Type Register.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  include/uapi/linux/pci_regs.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index 5d48413ac28f..a302b67d2834 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -80,6 +80,7 @@
> >  #define  PCI_HEADER_TYPE_NORMAL		0
> >  #define  PCI_HEADER_TYPE_BRIDGE		1
> >  #define  PCI_HEADER_TYPE_CARDBUS	2
> > +#define  PCI_HEADER_TYPE_MULTI_FUNC	0x80
>=20
> We test this a few places already; if we add this new macro, shouldn't
> we update those places to use it?

Thank you for your comment! We should updated drivers/pci/{probe,quirks}.c
like the following code for example:

	dev->multifunction =3D !!(hdr_type & 0x80);

I'll update them on v13.

Best regards,
Yoshihiro Shimoda

> >  #define PCI_BIST		0x0f	/* 8 bits */
> >  #define  PCI_BIST_CODE_MASK	0x0f	/* Return result */
> > --
> > 2.25.1
> >
