Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9361EB898
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFBJbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBJbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 05:31:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A9C061A0E;
        Tue,  2 Jun 2020 02:31:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j10so2634374wrw.8;
        Tue, 02 Jun 2020 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=Vc1kb2bA4hjesNSKldjcTzB184QagN+MorD8GwBPl5o=;
        b=DXp8SF9V/Mm2dJI/gQqZTW7uJytvoTFvssMpDpFNpT/Lz90uWN0EKWUQ33sMm8I5qu
         oQlVwYeeuajtBNhHC4DuV0X8ydcWwVo9yJ+gS5LEN4qb3Qbn6LG74My9+fJw44rL+m6l
         vG9ZgazapVC9QkK9krkpkSEE1ZbppMHSrnuluyLCvgCfZYxG1OFa4m9aBGWSLBww/AiE
         Z3/vFppMcsVGD6T/BUIuT6ewkfFhSTaL784QDt8BE9F7UY9Vt3WBUIvwlLNwD/N8ieYi
         ghi0/BvZTBp/3fSOM47mcY43TmK9pCeSsoHTuxqezcaYjVT9gHwVcPoSBQL9FH6fv4To
         Vd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=Vc1kb2bA4hjesNSKldjcTzB184QagN+MorD8GwBPl5o=;
        b=nfVD6ItF1c6hQUKlEgHZB05nvNXjp8tJxmXLhklA1gYmMUFtLwvy4B5uutLM4vVaxW
         wcB0qsLU2EpHvAsVEYFEnpKDeoNItEyHWd08RfNkkRCuYslx2h/G1NVjg4l81/Jq9wbL
         q8A3u3dLtSSEZpHhP3ceQcyXyJ8OJWu+UqbbW9EP7dzxzeuqWVBuNIbqmKWI5/vxgt8p
         4Y6RDbKfOkDd05Ij0AYpv8RvIC6q2YxgtI7XhAtt1hCQDYOg8qPW22JWjyj+pR+ZwVJ/
         8+z1MCvU076Y/Z6nVmLgIkY+MurHcNCBMPV7jO6voMorMtCwwFkdGlsypMnD8dxOGf2a
         hUrg==
X-Gm-Message-State: AOAM530A0Cjfo07ydDQVqS/LRjRMtsAeBRNAvdS2mu5OqcfuC4wi1TlJ
        v17eRsD9ciVGecTTFABeEqE=
X-Google-Smtp-Source: ABdhPJwcEfIzn8sBz4FtMqROG1S5X/bgC39xs3ex3TX5CF1MMCPowLZyy9MKUDBTNc16Cb1v7DqJEA==
X-Received: by 2002:a5d:5006:: with SMTP id e6mr27281079wrt.170.1591090293140;
        Tue, 02 Jun 2020 02:31:33 -0700 (PDT)
Received: from AnsuelXPS (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.gmail.com with ESMTPSA id b136sm3384830wme.1.2020.06.02.02.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 02:31:32 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>
Cc:     "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200514200712.12232-1-ansuelsmth@gmail.com> <20200514200712.12232-9-ansuelsmth@gmail.com> <e672c516-29a4-e7d2-ee8b-3bce73bdf4e2@mm-sol.com>
In-Reply-To: <e672c516-29a4-e7d2-ee8b-3bce73bdf4e2@mm-sol.com>
Subject: R: [PATCH v4 08/10] PCI: qcom: Add ipq8064 rev2 variant and set tx term offset
Date:   Tue, 2 Jun 2020 11:31:27 +0200
Message-ID: <090301d638c0$989b9e20$c9d2da60$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQH3v0d+k9NO1qBgLdGiwEtxppfOxAJRdC88ANwDc5WoaJZTcA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Messaggio originale-----
> Da: Stanimir Varbanov <svarbanov@mm-sol.com>
> Inviato: marted=C3=AC 2 giugno 2020 09:54
> A: Ansuel Smith <ansuelsmth@gmail.com>; Bjorn Andersson
> <bjorn.andersson@linaro.org>
> Cc: Sham Muthayyan <smuthayy@codeaurora.org>; Andy Gross
> <agross@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Lorenzo
> Pieralisi <lorenzo.pieralisi@arm.com>; Andrew Murray
> <amurray@thegoodpenguin.co.uk>; Philipp Zabel
> <p.zabel@pengutronix.de>; linux-arm-msm@vger.kernel.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: [PATCH v4 08/10] PCI: qcom: Add ipq8064 rev2 variant and
> set tx term offset
>=20
> Hi,
>=20
> On 5/14/20 11:07 PM, Ansuel Smith wrote:
> > Add tx term offset support to pcie qcom driver need in some revision =
of
> > the ipq806x SoC. Ipq8064 have tx term offset set to 7. Ipq8064-v2
> revision
> > and ipq8065 have the tx term offset set to 0.
> >
> > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> > index f5398b0d270c..ab6f1bdd24c3 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -45,6 +45,9 @@
> >  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
> >
> >  #define PCIE20_PARF_PHY_CTRL			0x40
> > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20,
> 16)
>=20
> I see you changed the mask, did you found the issue in previous v3 =
mask
> and shift?
>=20

I checked the original code and the old GENMASK declaration was wrong as =
you
suggested.

> > +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> > +
> >  #define PCIE20_PARF_PHY_REFCLK			0x4C
> >  #define PHY_REFCLK_SSP_EN			BIT(16)
> >  #define PHY_REFCLK_USE_PAD			BIT(12)
> > @@ -363,7 +366,8 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  	val &=3D ~BIT(0);
> >  	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> >
> > -	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
> > +	if (of_device_is_compatible(node, "qcom,pcie-ipq8064") |
>=20
> this should be logical OR
>=20

Will change in v5 since I will have to split this

> > +	    of_device_is_compatible(node, "qcom,pcie-ipq8064-v2")) {
> >  		writel(PCS_DEEMPH_TX_DEEMPH_GEN1(24) |
> >  			       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(24) |
> >  			       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(34),
> > @@ -374,9 +378,18 @@ static int qcom_pcie_init_2_1_0(struct
> qcom_pcie *pcie)
> >  		writel(PHY_RX0_EQ(4), pcie->parf +
> PCIE20_PARF_CONFIG_BITS);
> >  	}
> >
> > +	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
> > +		/* set TX termination offset */
> > +		val =3D readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +		val &=3D ~PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK;
> > +		val |=3D PHY_CTRL_PHY_TX0_TERM_OFFSET(7);
> > +		writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +	}
> > +
> >  	/* enable external reference clock */
> >  	val =3D readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> > -	val |=3D BIT(16);
> > +	val &=3D ~PHY_REFCLK_USE_PAD;
> > +	val |=3D PHY_REFCLK_SSP_EN;
> >  	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
> >
> >  	/* wait for clock acquisition */
> > @@ -1452,6 +1465,7 @@ static int qcom_pcie_probe(struct
> platform_device *pdev)
> >  static const struct of_device_id qcom_pcie_match[] =3D {
> >  	{ .compatible =3D "qcom,pcie-apq8084", .data =3D &ops_1_0_0 },
> >  	{ .compatible =3D "qcom,pcie-ipq8064", .data =3D &ops_2_1_0 },
> > +	{ .compatible =3D "qcom,pcie-ipq8064-v2", .data =3D &ops_2_1_0 },
> >  	{ .compatible =3D "qcom,pcie-apq8064", .data =3D &ops_2_1_0 },
> >  	{ .compatible =3D "qcom,pcie-msm8996", .data =3D &ops_2_3_2 },
> >  	{ .compatible =3D "qcom,pcie-ipq8074", .data =3D &ops_2_3_3 },
> >
>=20
> --
> regards,
> Stan

