Return-Path: <linux-pci+bounces-29605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D5AAD7B5E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F031C1893D84
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB512D4B49;
	Thu, 12 Jun 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="L1+a6pB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF920B80E
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757686; cv=none; b=KixMmHUuZqI+Xw+dvdYXrWMJ+kAfXDXtTB2+mZWO4zD5aYQd/6QZWhEdyo+nH+Ztl1IU83oAXpuU9lhNcW7ZBEbUzkyuSf0PBXgv/O/wECthCuzmZ8hpfSweqOmqFXiNnfLUNyzfZfGsMCetvxFajThqGRBVYDbxzosseRa+R54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757686; c=relaxed/simple;
	bh=ioKitG+yRYhRJrtQctH8UeW8KGYpeayaBl4Ml1mBldA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWi5oYZAKI7odkQIOIiqtihitv9zg0gFjc1IvhRqJ2v8ZA2v8PhTOLvjZuU5AzJ/X/WqThRRbcBUQSPNfr9Ou7L5Qbg1WTowf+BDBO0rZm7+IGu4tWOhQBdV7/p/bzaQnbm/F/hdV0fTScgyiSHnktyiRa6FIvCB3Y5/xuOsvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=L1+a6pB5; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-404e580bf09so365930b6e.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1749757683; x=1750362483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8e9esVoe2c1asLojkhwYh+MoQPaPYmSvfLLOY1O43Qk=;
        b=L1+a6pB5HWKsnQSfy/aDfl2Ow2HHCndtYYNnEpXRf1L4YsCgXaabYJB2094YKQLZbA
         0fbNHwMRFSGJgwseBRxrobOyN2oJZ90EjBi//94CRg3YIer7o7fhh8t0zSz6gF42WhH9
         kiXYPy4e+90MsBpEwURC3E/G34tH1yB46UIXAGCHsSDGtssXOCpdpIyfUJZFaSAEIqbS
         umIeeFAzdemJ/fSYoEcZ7hHr3kfLtS3TOdq7JIpz0dcQEG1d1Dq/xMsKrtMefUL0Q66u
         sLsfXqpEaJEMLQW24JoqA5uo1bYB2Nb2HYpUmcIohaI8kdNMsmd0ygv591C+AV6ADOAT
         PcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757683; x=1750362483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8e9esVoe2c1asLojkhwYh+MoQPaPYmSvfLLOY1O43Qk=;
        b=GzArfkgTmG00EULSrQX8gOkOOeAcsKnYGZM0f2HH1H2xJanwmYWWnnRXimHYLPamv4
         WpbGwEELj/3XmtlBBq8OIugFjYVyBVSetDQ2IaGY+KsDaJHAxfh4X9O/LQyexBxjeZxb
         71LZ2UF+7QX4evXsEj13sObvIT9hu8POd7Bf+hSWssqs3r6hKUb+YgA06BHcW+xktBr2
         iAyKc9cM7oOchPSi6+wlytxysmSeFiuiEIn+75ugbc8LSMdfuXwFeHrm9yBjkIB5Vvgq
         jyz7bp+iteOZ3Q7/xQGwNDMzCjiGaQ4LN/ryVOd6Hfi/XkWTNUoAorBZ5ygarv2swyq5
         FHQA==
X-Forwarded-Encrypted: i=1; AJvYcCUPv/mMqPzi98d+lucpo07bYfa9Pijq3n9ZKzmAQzTy6D8PSKVFnM31lKSUwfxAjxnx4wG/Z8vOtU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Dwil8sTNUlwp0evJiTgQBLADP/RTpZjZRL80CkxGGjna+KW3
	H7ZoqEe81NBaH9ZawH7W0bxiVNBp2bsN6hZ2ZrK9CsVrgw3lSeI3hwTqDUhZ/3pw4rFJVrvMh0U
	ZMMWR+OEqs8U/W1i5hpvZ3keKvHP0Fc3Ir4cjVzV3hA==
X-Gm-Gg: ASbGncurNlpWwI+K3CN+c61Fuqou7OR0Jc0YYoxoKv1u5WmHPQDuIOcrUxz0Nm+4cA4
	ctE9+uC9E3QwvMorVLsux6ySESLrvXTHUe/Cu0OSgafOuEexZ11kCD9wGq0WsGQyKJIyGDAhgg+
	OTBqzyvvu3lz6DoQ6nQ68SCWIq84/URWZql9ZNEpCD+zo=
X-Google-Smtp-Source: AGHT+IFcwAXQ3PbWAljxpAOaH7id08n7aXe7ujr3lhVGcrvJaHIYrxkMSHXAY37YjImxRVd5r3NbxP9AAw1idnxghok=
X-Received: by 2002:a05:6808:3c43:b0:401:16e:918e with SMTP id
 5614622812f47-40a71d7641fmr583982b6e.8.1749757683321; Thu, 12 Jun 2025
 12:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612022747.1206053-1-hongxing.zhu@nxp.com>
 <20250612022747.1206053-2-hongxing.zhu@nxp.com> <aEr8PxcHp55Bo5Os@lizhi-Precision-Tower-5810>
In-Reply-To: <aEr8PxcHp55Bo5Os@lizhi-Precision-Tower-5810>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 12 Jun 2025 12:47:52 -0700
X-Gm-Features: AX0GCFtVrSEePbUg8i-7Hr0xxmYOgLkuZdutnpQomlDJR8IFZN655IzCDiGytFM
Message-ID: <CAJ+vNU3vyznybZ_QZBrB+nc1=2+BcC8csOtR5=6-gmgn6sb5tQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: imx6: Remove apps_reset toggle in _core_reset functions
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 9:11=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Jun 12, 2025 at 10:27:46AM +0800, Richard Zhu wrote:
> > apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms=
.
> > Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
> > wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();
> >
> > Remove apps_reset toggle in imx_pcie_assert_core_reset() and
> > imx_pcie_deassert_core_reset() functions. Use imx_pcie_ltssm_enable()
> > and imx_pcie_ltssm_disable() to configure apps_reset directly.
> >
> > Fix fail to enumerate reliably PI7C9X2G608GP (hotplug) at i.MX8MM, whic=
h
> > reported By Tim.
> >
>
> You may rename apps_reset to ltssm_reset to avoid confuse for legancy
> platform later.

Hi Frank and Richard,

I was thinking of making the same suggestion however the apps reset is
in several places:
- imx8m*.dtsi pci node as 'reset-names' and reset index number #define
- imx8m*-reset.h bindings as reset index number/define
- pci-imx.c driver

Granted it is used by imx7d.dtsi, fsl,imx8mq-pcie, fsl,imx8mm-pcie,
fsl,imx8mp-pcie and in every one of those reference manuals it's bit6
of SRC_PCIEPH_RCR named PCIE_CTRL_APPS_EN but described as
'Pcie_ctrl_app_ltssm_enable'. Can you ask your references to get more
definition for this bit? I'm still unclear why 'de-asserting' it twice
was an issue.

Regardless, any cleanup changing the name can be a seperate patch in my opi=
nion.

Best Regards,

Tim


>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
>
> > Reported-by: Tim Harvey <tharvey@gateworks.com>
> > Closes: https://lore.kernel.org/all/CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZ=
cMHDy+poj9=3DjSy+w@mail.gmail.com/
> > Fixes: ef61c7d8d032 ("PCI: imx6: Deassert apps_reset in imx_pcie_deasse=
rt_core_reset()")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contro=
ller/dwc/pci-imx6.c
> > index 5f267dd261b5..f4e0342f4d56 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -776,7 +776,6 @@ static int imx7d_pcie_core_reset(struct imx_pcie *i=
mx_pcie, bool assert)
> >  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
> >  {
> >       reset_control_assert(imx_pcie->pciephy_reset);
> > -     reset_control_assert(imx_pcie->apps_reset);
> >
> >       if (imx_pcie->drvdata->core_reset)
> >               imx_pcie->drvdata->core_reset(imx_pcie, true);
> > @@ -788,7 +787,6 @@ static void imx_pcie_assert_core_reset(struct imx_p=
cie *imx_pcie)
> >  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
> >  {
> >       reset_control_deassert(imx_pcie->pciephy_reset);
> > -     reset_control_deassert(imx_pcie->apps_reset);
> >
> >       if (imx_pcie->drvdata->core_reset)
> >               imx_pcie->drvdata->core_reset(imx_pcie, false);
> > @@ -1176,6 +1174,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *=
pp)
> >               }
> >       }
> >
> > +     /* Make sure that PCIe LTSSM is cleared */
> > +     imx_pcie_ltssm_disable(dev);
> > +
> >       ret =3D imx_pcie_deassert_core_reset(imx_pcie);
> >       if (ret < 0) {
> >               dev_err(dev, "pcie deassert core reset failed: %d\n", ret=
);
> > --
> > 2.37.1
> >

