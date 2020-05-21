Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196F41DD9A9
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 23:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEUVsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgEUVs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 17:48:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75483C061A0E
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 14:48:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so8111510wrx.10
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1FrDzsjYEcXgrfssVNqqByxFp+Ac+Iq6mZixETRuPi4=;
        b=WmNJz59ItRug2cC5INbpwDKpcDmMtgi6jVU9u719g067ES93QLe8eqTMGzSES6EhYV
         mdMc2M6PGzOF/Q5wqmdP/+0piv/rNvkgZr7PxPh5g3wVI+f0b7hBEdreqS8AJ+DrIblE
         ofDD7ndpAcgLcQ/PBOeUaeUwNJgP5BaLTIZNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1FrDzsjYEcXgrfssVNqqByxFp+Ac+Iq6mZixETRuPi4=;
        b=QDHt0Mjy4pVeecibpoxur0gdJ1Ya1EHjJscyYZPe4MeoQWyzYM5T7KsK1Rlq5PqlX0
         S7NHF/ENx+YJh6UJvcUkyGw6+GF77hLF133UbeF3pajXEM7+O40IQ4LmCAXlf1AFuLEq
         OXnp//6M7ixqdDzUmJbmmOm/stJN3WrNrOVk34lbYm75Ywrr0trz1t21iUVzsXc7iUz9
         tpEJxiMcBXSmjaZPOIo7JmW2jcmsU7zQkCt3Kb74mCKoaCyjHKQo01uBrfJUCzhuD1cp
         d4MMv2tGz1TxuwuZUm69cnzkDdLVeFSXZaSiUcJ1bdGz1AoSjETUVPeNAUt3g+LFEUNU
         pvOg==
X-Gm-Message-State: AOAM533+NUSlLdnWmlnX2OHpZA5xfciO6vOJxRBs6r7uKacM+6a7e/Ae
        dntSWpDf1H4wB/6bx9i4J1LvIi/l/c/f+28Zd1yG3g==
X-Google-Smtp-Source: ABdhPJzO8QjCrwiMc96gkFPxC2xNsu+AaIKQ54rCen8kgp3Tra5gNG8QuZwpex0i5HD/wL/RicupKUhSYd6aPhEXMJ8=
X-Received: by 2002:adf:e688:: with SMTP id r8mr509896wrm.274.1590097708107;
 Thu, 21 May 2020 14:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-8-james.quinlan@broadcom.com> <20200520072747.GB5213@pengutronix.de>
In-Reply-To: <20200520072747.GB5213@pengutronix.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 21 May 2020 17:48:15 -0400
Message-ID: <CA+-6iNxtW66QLrb5BaOOCPJwG-1fShdfZqiLSkKfi6Y669dn5w@mail.gmail.com>
Subject: Re: [PATCH 07/15] PCI: brcmstb: Add control of rescal reset
To:     Philipp Zabel <pza@pengutronix.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 3:27 AM Philipp Zabel <pza@pengutronix.de> wrote:
>
> Hi Jim,
>
> On Tue, May 19, 2020 at 04:34:05PM -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Some STB chips have a special purpose reset controller named
> > RESCAL (reset calibration).  This commit adds the control
> > of RESCAL as well as the ability to start and stop its
> > operation for PCIe HW.
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 81 ++++++++++++++++++++++++++-
> >  1 file changed, 80 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 2c470104ba38..0787e8f6f7e5 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> [...]
> > @@ -1100,6 +1164,21 @@ static int brcm_pcie_probe(struct platform_devic=
e *pdev)
> >               dev_err(&pdev->dev, "could not enable clock\n");
> >               return ret;
> >       }
> > +     pcie->rescal =3D devm_reset_control_get_shared(&pdev->dev, "resca=
l");
> > +     if (IS_ERR(pcie->rescal)) {
> > +             if (PTR_ERR(pcie->rescal) =3D=3D -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +             pcie->rescal =3D NULL;
>
> This is effectively an optional reset control, so it is better to use:
> =E2=86=B5
>         pcie->rescal =3D devm_reset_control_get_optional_shared(&pdev->de=
v,
>                                                               "rescal");=
=E2=86=B5
>         if (IS_ERR(pcie->rescal))
>                 return PTR_ERR(pcie->rescal);
>
> > +     } else {
> > +             ret =3D reset_control_deassert(pcie->rescal);
> > +             if (ret)
> > +                     dev_err(&pdev->dev, "failed to deassert 'rescal'\=
n");
> > +     }
>
> reset_control_* can handle rstc =3D=3D NULL parameters for optional reset
> controls, so this can be done unconditionally:
>
>         ret =3D reset_control_deassert(pcie->rescal);=E2=86=B5
>         if (ret)=E2=86=B5
>                 dev_err(&pdev->dev, "failed to deassert 'rescal'\n");=E2=
=86=B5
>
> Is rescal handled by the reset-brcmstb-rescal driver? Since that only
> implements the .reset op, I would expect reset_control_reset() here.
Where exactly?  "reset.h" says that "Calling reset_control_rese()t is
not allowed on a shared reset control." so I'm not sure why  you would
want me to invoke it.
> Otherwise this looks like it'd be missing a reset_control_assert in
> remove.
I can add this.
Thanks,
Jim
>
> regards
> Philipp
