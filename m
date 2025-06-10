Return-Path: <linux-pci+bounces-29269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A635AD2ADD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 02:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E238016D0D5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 00:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC92A1BF;
	Tue, 10 Jun 2025 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="iska8Fr3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DE2111
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749515060; cv=none; b=Hhopt3NQf9x14Bivg2YB96jG3zrzwIVz1DM+xCEARifthUyhzraZ09/s7uhTRdjETGzf5BQkFwKAAnL+4Bgke5FxB6prH97wcpYACX6UZGq/6WnYZUtG78IbI7lTb23VCwRSul7eNCjbMPlEFVmvghYpHJwESjzA+Dy/0IWp/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749515060; c=relaxed/simple;
	bh=7jmPTNP5wXkOM5VKAK8B4cmHLCsgMV0sC67D2Tc8tnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URpqR7g+7xK/90S1iz1X5A1n675W6bg2x4k8+cflGFrbXS4jBZsTYZX3y0eUZH9h3OYzQ3Rj3fEAU0ABksl7MfojMWWgkKkX5TrKiA+ETAmexOpvQz11y8zj72z0+bU10qt1+YsvW6aby/V2wMZWEfIc+mVBZQTTnWAiPLxWb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=iska8Fr3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70f94fe1e40so59376847b3.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 17:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1749515055; x=1750119855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p6WWlOvtLKrokUmhKFbxMIWiiDCNI86TAtn3rEDUQM=;
        b=iska8Fr3I/6mpXtAyNYvHvqOVfOeEz/ht64sFyVYGZMCTyqNSZzq0G3JIPIv3/eyQk
         jL45vVNTskVEsnGp0w/N74wm6hz130KU+6slU2sHAeyySD5JedFd9Nug/KhnSp4FIvGy
         8An92g5wb4msyKTHQ9nmk+Ggh/35w0z+tTYBsUbyE+heZ3H/HT7lOzO2fbHqjUkJ6BSH
         W+fx11MPFR1hX8ycHWlnDgGA6WInOvWArpvhqwrYLrBO6QvAJ4Q0Gm1GwFvfpCAh6Lx3
         T6nqa8MY0qGzuSsHiEl1cJM/vFcnA4Z9/7K4Hwhcd9Mn08HldOrq8SFoYiz6Zgi4X5V8
         TNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749515055; x=1750119855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p6WWlOvtLKrokUmhKFbxMIWiiDCNI86TAtn3rEDUQM=;
        b=dNlZmEyfoXQs8JFaY8y6HQFrHTyOzllDZSNpPIn89K7t1lYsaN02WdjcHRO1MT7khM
         tZDuWzMGcHQDN7rtUcggyUqIXU0mqsYZJ/Kg4kDBqBWYQ5E5eaF5A0ZBAJt7Zp5M3NXy
         JZl09v5ZWpAuZ5955u5N4QAFrTblHPsGKfpvROtv6reZao1sG9BG3r7bRWpATLA1MrQk
         n/9E2+ag4JXLQJ5c+aBhwCrDybIM2mxfNVWR9y45EhJ/bKcljY8dGOgtTSNYIG1FisKL
         Yuxk1gbx2bfReyiF45wMABj/cYs1QAhNI9h6fqwzH2eBLagcO8tdmLyk4x0ekVcnumyB
         XTsw==
X-Forwarded-Encrypted: i=1; AJvYcCUAUmGPhuCASh1tXB3woHDA9rFjmu4HpajsCMepsjKuFRKr0jkzuqa10SqnlXWbdH8X3hTKYsAv6GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Ob39FlSVUnDd57rSW8UK29XZJX++xywfnCWYMRe9AT25nK57
	EeTC3x+nc3ze6tL60CeCsk+afG6+yrk/smzNpMFj2RVeaI76kYpH/u+Rx2+Bc72gPjfvBZGB7cH
	81wMcCDQ+nXxsvQCZMc2kUJk8/WN1QHU1Ts0HjjvZ6Q==
X-Gm-Gg: ASbGnctePbC1+kp5avLp6JTTr8tJKHvijJzCCO141XeNuBEgRRIOikNrLHm7ZMk7h63
	f/Z+0HmX/On3rJ80/q+Tf6uR3h8xYbwbXLIr3RDrbu35hJNtGefTaCwzmG+0CIiBnYYstEguxcn
	CFRGk1AIxYd6Hxfc5aUMunE+B5ug17yaHFXYwa+mQu+UcVo5rFIiACuA==
X-Google-Smtp-Source: AGHT+IEIwckNC6Mk3FUMcw8lzb7oJYprV7CNZkimjX4sCr2WuaRjl9EYST/x4A5RYQYDa8DuCIr4jskjKGm1oKna1b0=
X-Received: by 2002:a05:690c:7204:b0:70e:76eb:8fb0 with SMTP id
 00721157ae682-71133929d3dmr23571387b3.13.1749515055615; Mon, 09 Jun 2025
 17:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20241126075702.4099164-6-hongxing.zhu@nxp.com> <CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZcMHDy+poj9=jSy+w@mail.gmail.com>
 <AS8PR04MB8676C1206066A3215DB5F3B78C6BA@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676C1206066A3215DB5F3B78C6BA@AS8PR04MB8676.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 9 Jun 2025 17:24:04 -0700
X-Gm-Features: AX0GCFvJVHqxJw3QT2Hj1OmwNvuRPr_efH3vouQUS0tjvRGC0_axQFmE3cNvLZA
Message-ID: <CAJ+vNU0rO0tJyon6HGYTZHu5oii5vH-dPpnSH7RQj43+nE1KDQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] PCI: imx6: Deassert apps_reset in imx_pcie_deassert_core_reset()
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 1:03=E2=80=AFAM Hongxing Zhu <hongxing.zhu@nxp.com> =
wrote:
>
> > -----Original Message-----
> > From: Tim Harvey <tharvey@gateworks.com>
> > Sent: 2025=E5=B9=B46=E6=9C=887=E6=97=A5 5:04
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; lpieralisi@kernel.org;
> > kw@linux.com; manivannan.sadhasivam@linaro.org; robh@kernel.org;
> > krzk+dt@kernel.org; conor+dt@kernel.org; shawnguo@kernel.org; Frank Li
> > <frank.li@nxp.com>; s.hauer@pengutronix.de; festevam@gmail.com;
> > imx@lists.linux.dev; kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 05/10] PCI: imx6: Deassert apps_reset in
> > imx_pcie_deassert_core_reset()
> >
> > On Tue, Nov 26, 2024 at 12:03=E2=80=AFAM Richard Zhu <hongxing.zhu@nxp.=
com>
> > wrote:
> > >
> > > Since the apps_reset is asserted in imx_pcie_assert_core_reset(), it
> > > should be deasserted in imx_pcie_deassert_core_reset().
> > >
> > > Fixes: 9b3fe6796d7c ("PCI: imx6: Add code to support i.MX7D")
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 3538440601a7..413db182ce9f 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -776,6 +776,7 @@ static void imx_pcie_assert_core_reset(struct
> > > imx_pcie *imx_pcie)  static int imx_pcie_deassert_core_reset(struct
> > > imx_pcie *imx_pcie)  {
> > >         reset_control_deassert(imx_pcie->pciephy_reset);
> > > +       reset_control_deassert(imx_pcie->apps_reset);
> > >
> > >         if (imx_pcie->drvdata->core_reset)
> > >                 imx_pcie->drvdata->core_reset(imx_pcie, false);
> > > --
> > > 2.37.1
> > >
> > >
> >
> > Hi Richard,
> >
> > I've found that this patch causes a regression on i.MX8MM and i.MX8MP
> > boards with hotplug capable bridges:
> > i.MX8MM+PI7C9X2G404EV (this switch does not support hotplug) - no issue=
s
> > i.MX8MM+PI7C9X2G608GP (hotplug) - fails to reliably enumerate
> > downstream devices about 80% of the time ^^^ when this occurs
> > PCI_PRIMARY_BUS (0x18) for the root complex
> > 0000:00:00.0 reads 0x00000000 instead of 0x00ff0100
> > (PCI_SECONDARY_BUS is 0 instead of 1 and PCI_SUBBORDINATE_BUS is 0
> > instead of 0xff) i.MX8MP+PI7C9X2G608GP (hotplug) - hangs at
> > imx_pcie_ltssm_enable deassert apps_reset
> >
> > In both cases here reverting ef61c7d8d032 ("PCI: imx6: Deassert apps_re=
set
> > in imx_pcie_deassert_core_reset()") resolves this.
> >
> [Richard Zhu] I'm afraid that the ltssm_en bit assert to 1b'1 in
>  imx_pcie_deassert_core_reset() is not correct in your use case.
>

Hi Richard,

Thanks for your quick response. Do you mean not correct for newer IP
core in i.MX8MM/i.MX8MP or in the case of a bridge?

> Actually, the apps_reset isn't a real reset. It's the ltssm_en bit.
> From this perspective view, It's inappropriate to toggle the ltssm_en bit=
 in
>  imx_pcie_assert/deassert_core_reset() functions.
> I consider to move the apps_reset out of _reset_ functions.
> Can you help to test the following changes in you use-case?
>
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -776,7 +776,6 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx=
_pcie, bool assert)
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>         reset_control_assert(imx_pcie->pciephy_reset);
> -       reset_control_assert(imx_pcie->apps_reset);
>
>         if (imx_pcie->drvdata->core_reset)
>                 imx_pcie->drvdata->core_reset(imx_pcie, true);
> @@ -788,7 +787,6 @@ static void imx_pcie_assert_core_reset(struct imx_pci=
e *imx_pcie)
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
>         reset_control_deassert(imx_pcie->pciephy_reset);
> -       reset_control_deassert(imx_pcie->apps_reset);
>
>         if (imx_pcie->drvdata->core_reset)
>                 imx_pcie->drvdata->core_reset(imx_pcie, false);
> @@ -1176,6 +1174,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp=
)
>                 }
>         }
>
> +       /* Make sure that PCIe LTSSM is cleared */
> +       imx_pcie_ltssm_disable(dev);
> +
>         ret =3D imx_pcie_deassert_core_reset(imx_pcie);
>         if (ret < 0) {
>                 dev_err(dev, "pcie deassert core reset failed: %d\n", ret=
);
>

Yes this resolves the regression of failing to reliably enumerate
downstream devices. I think that should be submitted with a fixes tag.

The i.MX8MP+PI7C9X2G608GP switch hanging issue was hardware related...
i was sadly testing on an old board with a defect. I did previously
have a hang issue there discussed previously here [1] but it was
resolved with commit 9c03e30e3ade ("PCI: imx6: Skip link up workaround
for newer platforms").

How much testing is done with i.MX8M{M,P} board with a switch? I feel
like I'm the only one with these SoC's and a switch and I need to get
better at monitoring patches to the IMX6 PCI controller driver and
testing these scenarios.

Best Regards,

Tim
[1] https://www.spinics.net/lists/linux-pci/msg142764.html




> > I notice the sequence of events here is:
> > imx_pcie_assert_core_reset asserts apps_reset (disables LTSSM)
> > imx_pcie_deassert_core_reset deasserts apps_reset (enables LTSSM)
> > imx_pcie_ltssm_enable deasserts apps_reset (enables LTSSM; this is wher=
e it
> > hangs on imx8mp)
> >
> > Is there perhaps some issue with de-asserting this (enabling LTSSM) whe=
n it's
> > already in this state?
> [Richard Zhu]The apps_reset is updated by src driver by regmap_update_bit=
s().
> I can't find the exceptions to update one bit, already has the according =
value.
>
> Best Regards
> Richard Zhu
> >
> > In the case where downstream devices do not enumerate some investigatio=
n
> > points to them not being happy that the link drops so perhaps deasserti=
ng
> > apps_reset when its already asserted drops the link and restarts it?
> >
> > Best Regards,
> >
> > Tim

