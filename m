Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46F526987E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgINWCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 18:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINWCN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 18:02:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD2C06174A;
        Mon, 14 Sep 2020 15:02:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o8so2092881ejb.10;
        Mon, 14 Sep 2020 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=xGKDB+SeTNUH9+ntXv69tsjlv921V8lJoDxF7UQdwLc=;
        b=RjH3QJHfbcwVDlI94UAt3J12rjSoccHaoscLj3GjVsl1MDXF756cAuvpcKg0BCldxp
         up/1FFcsCFip2nZBRCu+A1UmCAXgrIFSX6uTLinhwL1QOf/qtIEV8N1I0Oxsu6w1uKz1
         Slu3Cgzxofa4175a+I+uLr9MwdD7hb7IqZejwy75LkcBW2br32aZNhXRXPELUziiFk59
         v7oTmwIWYedKeSRjpmi5uwEZoEgBQwDeIuETJszqsmLh+psch5HWUHuc6XcbXyAsg/3l
         EL5NSYOtoAtEIVMjdim4qV16snbHmu8TIUiYgLtWUc9gZ1aAkSCnfuxsKQkqBEkRTMg9
         GoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=xGKDB+SeTNUH9+ntXv69tsjlv921V8lJoDxF7UQdwLc=;
        b=CEsuyuOzDSebDRWKkZDg707r0UgABCNvJ6AXLJbDITWl5unp29hR/gQGfkl7qTwDUq
         hLrJ0FMppzQNJosHNWH5ZHfcqOy4NH+6TDDRmjGUojWpPIdaDPBojBOzHHuqO3NNWfYI
         gcIjS6/1yXnLhnPVW7xAlHHmJlVImdlWU2KEOV+BRvKoX8Xln0baKwqPIPdLjkCJvCAg
         Fz4TeM22hY7bd3IQSqNwgKDSgiEkfqRnZPzqptLpXAABkkLZBOpRQlM9S8Dckl+D9SwG
         VdmFeY4/Fc1KNmvJp93AzeQObljPV9EVSRFYn0ru6xhiBG589CHRjXTSAGPLd+KSnh7w
         yTyg==
X-Gm-Message-State: AOAM530TKqgwetsqqcHP54pz/P0uF63Zcolm6FIGRHEn/LH/HL1dxv9o
        4bA9GJnV8XWvXGXX+wwIHmo=
X-Google-Smtp-Source: ABdhPJyzrcmyUdk3mhdVJ7z7u1v/jNoFrq6sINS7cTp5D6Flsu5JPb60nhPMfbjtFXkv7cAGEbb8+A==
X-Received: by 2002:a17:906:cf9d:: with SMTP id um29mr16627895ejb.74.1600120930154;
        Mon, 14 Sep 2020 15:02:10 -0700 (PDT)
Received: from AnsuelXPS (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.gmail.com with ESMTPSA id k6sm8640821ejr.104.2020.09.14.15.02.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 15:02:09 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Ilia Mirkin'" <imirkin@alum.mit.edu>
Cc:     <linux-arm-msm@vger.kernel.org>,
        "'Linux PCI'" <linux-pci@vger.kernel.org>
References: <20200907011238.3401-1-imirkin@alum.mit.edu> <018401d684b4$d31162c0$79342840$@gmail.com> <CAKb7UvgQcSsm=5wqs3jUNYYxuv1w_DPYpV1trSfz+OkbfK6TCg@mail.gmail.com>
In-Reply-To: <CAKb7UvgQcSsm=5wqs3jUNYYxuv1w_DPYpV1trSfz+OkbfK6TCg@mail.gmail.com>
Subject: R: [PATCH] PCI: qcom: don't clear out PHY_REFCLK_USE_PAD
Date:   Tue, 15 Sep 2020 00:02:00 +0200
Message-ID: <000001d68ae2$b0ad55c0$12080140$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHY0SUK+QbXAY/uJVDw58GDK9a3NgHRG3jUAX2gsWypPhCRQA==
Content-Language: it
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Messaggio originale-----
> Da: Ilia Mirkin <imirkin@alum.mit.edu>
> Inviato: luned=C3=AC 7 settembre 2020 05:29
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: linux-arm-msm@vger.kernel.org; Linux PCI =
<linux-pci@vger.kernel.org>
> Oggetto: Re: [PATCH] PCI: qcom: don't clear out PHY_REFCLK_USE_PAD
>=20
> On Sun, Sep 6, 2020 at 9:18 PM <ansuelsmth@gmail.com> wrote:
> >
> >
> >
> > > -----Messaggio originale-----
> > > Da: Ilia Mirkin <ibmirkin@gmail.com> Per conto di Ilia Mirkin
> > > Inviato: luned=C3=AC 7 settembre 2020 03:13
> > > A: ansuelsmth@gmail.com
> > > Cc: linux-arm-msm@vger.kernel.org; linux-pci@vger.kernel.org; Ilia
> Mirkin
> > > <imirkin@alum.mit.edu>
> > > Oggetto: [PATCH] PCI: qcom: don't clear out PHY_REFCLK_USE_PAD
> > >
> > > This makes PCIe links come up again on ifc6410 (apq8064).
> > >
> > > Fixes: de3c4bf6489 ("PCI: qcom: Add support for tx term offset for =
rev
> > > 2.1.0")
> > > Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > > b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 3aac77a295ba..985b11cf6481 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -387,7 +387,6 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie
> > > *pcie)
> > >
> > >       /* enable external reference clock */
> > >       val =3D readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> > > -     val &=3D ~PHY_REFCLK_USE_PAD;
> >
> > To make sure this doesn't brake ipq806x, why not limit the &=3D to =
the
> ipq806x
> > compatible like we do up in the code? (or use the use_pad only if
> apq8064
> > compatible is not detected, to address ipq8064-v2 added later?)
>=20
> Do you mean something like
>=20
> if (!of_device_is_compatible(node, "qcom,pcie-apq8064"))
> val &=3D ~PHY_REFCLK_USE_PAD;
>=20
> I'm not sure what's considered acceptable in these cases. It does seem
> odd that this bit should not be cleared on apq8064 but should be on
> ipq8064 -- perhaps there's more going on there? Unfortunately I
> haven't the faintest clue as to what it is...
>=20
>   -ilia

Ok i did some test... Can confirm that the condition is needed.
ipq806x needs the USE_PAD or the kernel just hangs.=20
When the pci interface is init the regs are 1019... For ipq806x this =
need to
change to 10019 (external ref clk enabled and something else disabled =
that
we don't know without documentation)
So to sum up... without the condition this patch would cause a =
regression for
ipq8064/5.

