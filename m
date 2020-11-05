Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E482A848B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 18:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgKERO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 12:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKERO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 12:14:56 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E9C0613CF;
        Thu,  5 Nov 2020 09:14:56 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so1098275plo.0;
        Thu, 05 Nov 2020 09:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=XwV+aW6cGJGYI4Hbmxr8mO8vep5QW19zw8MT/QMQ6J4=;
        b=DG1/lsxD23Zu+0xI8p/fT1yZLzBJNXRnYUDHkUck+eLYeRFbk4eXtEmsz7xBKo2Ubn
         Hu6yCzfK8qI6JviVQz93AubOVaYEPuH1fZ6sPAyc/ZkquR6ezD1qFjK4krRwCLW0A8af
         lg+SP8gLg0Sz/WO8279RyUkHSPBmmK/pofiry13zeLJfedyE2BN66A91HScPYRfLXZaQ
         kHMSztIL7quITa0DoQJMbipKMz/bySBpD48UDr042jBR7ByVY0/1mZTTMChSWxWY3UAE
         99QZ++p4KP3eJkOw4Rgde0tAk0NP7OeMBH4S6ejdFDE58pUkHBtnX8d+g/g0mzoPLgw7
         VJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=XwV+aW6cGJGYI4Hbmxr8mO8vep5QW19zw8MT/QMQ6J4=;
        b=NHlEVamGaB3Hep5J5u+8zwjanu64T+++iHMjub3h+XLQjIsp2shxWfqqzcxVA23SGV
         bISldDNMZvaurACD7XlxipmUijAYii3su+J6TM2/8rHJroEXFPuwUymr9tpALtL4Vfu1
         nknkT++SIaA20HTQ4/UU+hIxF/hUzkfQJZvYo0BtyDbg3XdQ1H2afnQVXKu9MQXoM0YC
         UwIAzHbwKx0qYCZaH9V7h+5RTfmjrUYJ805IA3Hg/pLPikjnSvshjWFcF+OvI8ShXY6+
         /JaKkOl88h9QPZDbbvxpGzzmsv/XrRky0emaUlPweKiNW2BLZOGKviabPGy/2aD4VRN0
         bMzA==
X-Gm-Message-State: AOAM5313PI7z1NDvy5EznGUbvch3/oXmVOgVXXFZQ4DY1qi1aeJ/ePxw
        JRKAlul3RxrNa2vaS2khffs=
X-Google-Smtp-Source: ABdhPJxizlMCIeICyyJrLiuwB6GA88j9xik3qp0bMTx1JoaNIFQ0rtun87LTzJD3xGIYvUKTpGB7EQ==
X-Received: by 2002:a17:902:c383:b029:d6:991c:671b with SMTP id g3-20020a170902c383b02900d6991c671bmr3058728plg.51.1604596495770;
        Thu, 05 Nov 2020 09:14:55 -0800 (PST)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id w131sm3236826pfd.14.2020.11.05.09.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 09:14:54 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: pci: add the samsung,exynos-pcie
 binding
Thread-Topic: [PATCH v3 2/6] dt-bindings: pci: add the samsung,exynos-pcie
 binding
Thread-Index: AQHWrfkxmqu5u2BfXUOgfEcMUhWpwKm4iO6AgAC3vwCAAHO+AIAAHfWn
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 5 Nov 2020 17:14:49 +0000
Message-ID: <SLXP216MB0477D362203645C619958647AAEE0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
 <CGME20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47@eucas1p2.samsung.com>
 <20201029134017.27400-3-m.szyprowski@samsung.com>
 <20201104213539.GA4144654@bogus>
 <d89f5f0a-c45e-0bda-4db7-7b0cf9cd49fe@samsung.com>
 <CAL_JsqKQstKa7_0pjcODyyLCwMiGF9zB4_+x=GhcSUOyvuLRmw@mail.gmail.com>
In-Reply-To: <CAL_JsqKQstKa7_0pjcODyyLCwMiGF9zB4_+x=GhcSUOyvuLRmw@mail.gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/5/20, 10:27 AM, Rob Herring wrote:
>=20
> On Thu, Nov 5, 2020 at 2:33 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Hi Rob,
> >
> > On 04.11.2020 22:35, Rob Herring wrote:
> > > On Thu, Oct 29, 2020 at 02:40:13PM +0100, Marek Szyprowski wrote:
> > >> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
> > >> variant). Based on the text dt-binding posted by Jaehoon Chung.
> > >>
> > >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > >> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >> ---
> > >>   .../bindings/pci/samsung,exynos-pcie.yaml     | 119 ++++++++++++++=
++++
> > >>   1 file changed, 119 insertions(+)
> > >>   create mode 100644 Documentation/devicetree/bindings/pci/samsung,e=
xynos-pcie.yaml
> >
> > >> ...
> >
> > >> +  num-viewport:
> > >> +    const: 3
> > > I'm confused why you need this. This is only used with the iATU excep=
t
> > > for keystone. Platforms like Exynos with their own child bus config
> > > space accessors don't have an iATU.
> >
> > Frankly I have no idea, I don't know much about the PCI internals.
>
> Sorry, I was confused. It's fine.

I was confused, too. But, as far as I remember, I also think that viewpoint=
-related
setting was necessary for Exynos PCIe.
Thank you.

Best regards,
Jingoo Han

>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Rob
