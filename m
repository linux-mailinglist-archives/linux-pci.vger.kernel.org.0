Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B413454E03B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiFPLv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 07:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFPLv6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 07:51:58 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6577D54BEC;
        Thu, 16 Jun 2022 04:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5vzSLeHJyLf1ebbiQu6SRfEQ8A9FTSknECqGN8+9HBQMishp18bz5y3H8mNQc2sLRFRBgWVFepn7ESof0k2TWNAysi6z+LWqnaUXbXkh1KMt1aVPektBnCBST7jvuOTaObK20kccyTKixL23OHMwvaon7sbJY69NYjAIneLBtt02TuGVciH7yxITdTHjd+2IKvwQ+6YL0EoO2ev+sUb1l5lJSHhqmWGBdQdR5O6DaGe6pC80btX4V/SQ5ieOi4kXS6ggWuk7SO5TB2eEOSUCeTCKSbuLPPxHyCYkM8PsA5uKo2aNTI+H/22pSb1HIjfehPFrKN8JDhQ3HxClprDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJiFRWAPhelTRNjbQ55s9+KEXU3YHo7z5fnGMIf4VPI=;
 b=Y9XnOyP0bcWV/7QnkfijVo5tK1RITUVacIAsfxUUYAybxJU31W/tYEULRfLmOLBv2y39oJ/w8w00uD+PshMcX43G9beWmZQ+VTUy2nG+rMl9GJ5p3vFMAlqZl2kiD1ntamsSlYost70IzjpGeB7xhHRplVPY5x+3cbN0/L40Jk3FZleCONSLhK4mVzUEekdpIxVj3ienK6djMkHonKuU8GaXAA3gPT+BoBV32teMXh3BlD+9GREgB5GUwKHh6zXuynAxQsbdsv0JCHhEmxyEzNkSN3fSFomCxMbwfcUHas5NsBeOortFGKPpqpnLBsRePHgd3gOpKXBvjjcrgLTAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJiFRWAPhelTRNjbQ55s9+KEXU3YHo7z5fnGMIf4VPI=;
 b=E41PwaWHe0bKHPAlrbb72BWFL+q5mc0VhcgGtwrzEYniW8oojxyaZocQMYqrsWmuPbh9ZYvS/UKS8Q/nHWrfZLibT8df9mnNKWK5FCrs44gfAeyOh9h86YMt5DrO49SMVrCfJjiMxIm7Fg5ujYrSzJz9TuFKmBlKfbdkcMFUabU=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB9311.jpnprd01.prod.outlook.com
 (2603:1096:400:1a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 11:51:53 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 11:51:53 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
Thread-Topic: [PATCH 1/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
Thread-Index: AQHYfxzFdwwgJS7KZEGDDrndJUkmHq1QKz0AgAHEWyA=
Date:   Thu, 16 Jun 2022 11:51:53 +0000
Message-ID: <TYBPR01MB534130FE351F8FD201888EB1D8AC9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
 <20220613115712.2831386-2-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVTq4P33P3MOim1USzQ7MFn_bGAkzf13CHN=VyMPsn3pA@mail.gmail.com>
In-Reply-To: <CAMuHMdVTq4P33P3MOim1USzQ7MFn_bGAkzf13CHN=VyMPsn3pA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f19ebc6-74f9-4849-73da-08da4f8e9b1e
x-ms-traffictypediagnostic: TYWPR01MB9311:EE_
x-microsoft-antispam-prvs: <TYWPR01MB931134DA788BFB71829ABDD9D8AC9@TYWPR01MB9311.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C1edIeY3Te6Un49gVEIkrsL4UMn5ZwbjX5Kc8zcNFTtyNWIQkQky3AqaBJiBi2PRS9qs5f6chk8/9nsPHCciQwWUj5H1avzJazi4hDbtGaqjAeN0uVdMR0uHvbSOhIMCkNrPoYm5+qpEcUzCK79hh1moFZUWOd5VkgOfwLsYaU/yUiiSdna7KnvKXjE+pcZHYCrHvshDvaKpwgbvoS7iLMJTBywuq40QONsxHx1fdALNTbOvZwi+dC692D4atPh8VExvO4tkQ/pLPWBrPfgchH5QNx2asUtUEe8YDFlaGLwppv4fOQhOHn+FwMLgvwFK43m13aaZs4PBL93eWgFxnMWwIq+WoHm7VJdtMH24n5ywTGOkvEhi43Gx9HIOKIZi4CNOl59d9p5PtADiac31vaP0UDXODq3xJ05aJ0RRUMKLmXNa/qeXGXwhf7mWIyZMRO0ihy6Ed1Nz7TjVlQ7NBXVspWs4Oxg8m5Eycrt7EX24F2alV9XVJYxORdNi78CvED1XlHLXzPN2AxlYe5p9/oUUSSjz32WAQV9AMUo922y0SaGkVY4zXcIqbVYycITVikB1UVQtxuCc6bENqJsH5558rgES2MTkrhDZl0ApHS40FjcEZRi0I7vCsctI91TYJpi/zBNn6t22yIxqF7TbQnor2c3NCZhPPP6C2P7V+to8lNofX9Mi3Q4JPZMFTTP4n7JazRHZzOpYEyx1lToK0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(76116006)(7696005)(2906002)(6506007)(64756008)(8676002)(66946007)(66556008)(4326008)(9686003)(71200400001)(66476007)(53546011)(33656002)(55016003)(6916009)(66446008)(508600001)(54906003)(7416002)(5660300002)(186003)(316002)(86362001)(38070700005)(8936002)(52536014)(83380400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?GnQTy1BgFByOIJ26dURG6PHU35dk30PL7v39fpt1zYG+X5b4gmtmt6Jr2T?=
 =?iso-8859-2?Q?9nUM5S1DHjLPMbiWO0r7yl9g160SGHs30gdHjowNIg3aLKCTIheYYaxlfA?=
 =?iso-8859-2?Q?6KZXJKywWkIqLR0drVCu4aeO+AHxb87qCM9vgWgI8SAeJhKLiAEdXd5T/N?=
 =?iso-8859-2?Q?5OmSDXIZuZVVCOS2PoPma24BnBP9nRHMZKPonQKAHq1KlS/DW8fQ+Weq++?=
 =?iso-8859-2?Q?0BWt7M/VYaqPoTyFTMmb0A+jCPP9p4KEwjihDeqwz2hnaC1drKVDM5SBbM?=
 =?iso-8859-2?Q?pODgWDxVS+QJnRJSaUgqSxr1jf0YUZxU/CXUW4RiSJo/FHVIDuX5x7/nIW?=
 =?iso-8859-2?Q?xMUl02KhyWDcGEJPB5o894D4O3Zid5zYpv2ajobVRSU8xOvCHjktE2+Fxn?=
 =?iso-8859-2?Q?JhbhD72vKVSZvNcNJLoFNdPPF8g5A/bQia8yNUc311GC1LcIbAwZC5Q/xG?=
 =?iso-8859-2?Q?w1Mmg7tVwVtwalWJK0KoNt8OS0o0/m7TRiUjtRj+rCmBMiZoscTua0/Z+i?=
 =?iso-8859-2?Q?Fs7K5JE8tqzqoGchdSVo9H6BYIR5tTPkrVCg3YROXynHQlSmAruE0GEcqC?=
 =?iso-8859-2?Q?WCc4kxNTeBoZhLMGNV/TAnfcfO/Nla3CMeMmSGaUGeuYz2yFBi7axT/oLb?=
 =?iso-8859-2?Q?RF3YeI8Fq5Yv+h/kIRY7nFh2C1Va/A+qRunQHGYHmQ/5FIKrNYdDbPFPfi?=
 =?iso-8859-2?Q?RbN9ynrZTKhPMUa+r11VrOyUc35QJ6zjsjLLipnRqYr0cIZDyELLdybIag?=
 =?iso-8859-2?Q?b1nguliEU6VjyfWUlJYq+xS7RWdnlz1Var2RXGNjZYeu2I73bw/B0vPbVK?=
 =?iso-8859-2?Q?6T44LgpLH/bPzz7b3e041dQq4h1Z2L46f83zYfZ1oLJat+mUg4UjI/mVCX?=
 =?iso-8859-2?Q?fKXRVwvj+WmbfO5lqRaq5LHNRLg3DAJit0yfJAD05jQzvvqJG8bJVSBcii?=
 =?iso-8859-2?Q?fPx9KUwTi0AdSWf9x+NoUK6PSUooPl/iT5NCPxu0ndvtnxLoxkfFXT/Jvy?=
 =?iso-8859-2?Q?Hpn6nUTPWwoIZcDFvdEJDRJK2yxsY0OhF+FOygJo4rJWZ00bGGFGeWIU6O?=
 =?iso-8859-2?Q?JI0709YGNRON8F608xCVr9LGExOCejBJxvS8PXXNJZu5NhXVYM1FvjX7O8?=
 =?iso-8859-2?Q?qF6l0Jlqv/w8V2MEM2h3ih3OUjdhKaFs23JxY2s8q+hsplvhZn+k8qVHuK?=
 =?iso-8859-2?Q?GqK2ePgLQM2+CVn//KoY/IlHYsabCzim5D52UnW9msT539guG34ikqPwH3?=
 =?iso-8859-2?Q?E+gwnLteR8UyNLW2UFjSUjjvSadZvM24NZjVZj24D+S5H/Ewqjh3vr/T/P?=
 =?iso-8859-2?Q?P92j4/VNTUWhM7VWT+UCquctkyB3JiiWHCtC6sXU4jRx8SZz9Ru+Uey8tu?=
 =?iso-8859-2?Q?xlViLBm8CHdaVO3qFsd26HDc+lCKhzIikBTsCPejc7+2mYFBpfVmNlMaHh?=
 =?iso-8859-2?Q?MCtLtIV1EmVY+CCslWUr/EWA9C+ztNYjoVISimqpwEsNDNYf864+ztaVMQ?=
 =?iso-8859-2?Q?epsof3/Y63VvkR/6UT5NkdOjLECmUuq4PPLuFCys08rVEi7DezJiecXKfy?=
 =?iso-8859-2?Q?dNYuNm1IgM78CkIQmG5NHAOqgiZBW/83XetuEhXvZ7/POLPqS3jtIfhE1+?=
 =?iso-8859-2?Q?c+2OMha8OItwprZ7qzGgR66UpbYd4GihwW/sOBwE1crVCawPWKztjNF0Cw?=
 =?iso-8859-2?Q?F7Qc+1Z0pqXxJNoH9uUCbjr9QIej1wdhnDEX0Xc+TOmiabPkR05FDPkPNB?=
 =?iso-8859-2?Q?Is20d7y1g7rYjPB7lJEDpUBKhG7kWy5snuz33NdGY8uREGHzfkK4cRs5KL?=
 =?iso-8859-2?Q?hITWh+t6ieyTERnIiYhZ4sdJ0eBBJnKuq579mjT3E+u4S+iVGI5cPIRCIO?=
 =?iso-8859-2?Q?IO?=
x-ms-exchange-antispam-messagedata-1: +CYWo0oAJmAszoHvfZdvfb/YKV8JlNuQcaY=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f19ebc6-74f9-4849-73da-08da4f8e9b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 11:51:53.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wz8rMZyl/p13iit40ws82Kdb47msz1bh54Ibu4aR22UjElhenn8mVyriTYMIHdJ/F+JbU8X6qBG7TlaUk+4S21BkkPdoQjzPmrvLNOVvC0UN3kpCQtIZg6cl7nvk3erp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9311
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert-san,

Thank you for your review!

> From: Geert Uytterhoeven, Sent: Wednesday, June 15, 2022 5:49 PM
>=20
> Hi Shimoda-san,
>=20
> On Mon, Jun 13, 2022 at 1:57 PM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > PCIe host module.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> Thanks for your patch!
>=20
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
<snip>
> > +title: Renesas R-Car Gen4 PCIe Host
> > +
> > +maintainers:
> > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > +
> > +allOf:
> > +  - $ref: snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: renesas,r8a779f0-pcie   # R-Car S4-8
> > +      - const: renesas,rcar-gen4-pcie  # R-Car Gen4
> > +      - const: snps,dw-pcie
> > +
> > +  interrupts:
> > +    maxItems: 6
>=20
> The R-Car S4 INTC Interrupt Mapping spreadsheet says there are 7.
>=20
>     items:
>       - description: Other Errors
>       - description: DMA Event
>       - description: Correctable Error
>       - description: Fatal Error
>       - description: Non-Fatal Error
>       - description: Reception of a ERR message from link partner
>       - description: Reception of Vendor
>=20
> > +  interrupt-names:
> > +    items:
> > +      - const: msi

I think this should be "other" instead of msi.

> Missing:
>=20
>       - const: dma

You're correct. I'll fix it.

> > +      - const: err
>=20
> correctable?

I think so. I'll fix it.

Best regards,
Yoshihiro Shimoda

> > +      - const: fatal
> > +      - const: nonfatal
> > +      - const: lp
> > +      - const: vndmsg
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
