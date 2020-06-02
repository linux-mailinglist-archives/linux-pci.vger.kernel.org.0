Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806FE1EB89D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFBJe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBJe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 05:34:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6BC061A0E;
        Tue,  2 Jun 2020 02:34:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so2677291wrv.4;
        Tue, 02 Jun 2020 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=B55oe33tQCkzxWimg+ZfOhRx1c98hkXT02+HAEUdowc=;
        b=oF3yVN69hVB7BGPvNvSU7+yVWpzxpaa4CaieNUPq1YmlNxu/3+AimQrMmbU1QsYyWE
         W0PBN/N/QaZHwq1DKx11WvNRKAYv7e9u34Vq01U0Ev4q1Oxo3CLNu4PfsPwMFgljCIFA
         6UHw1SLSbKQQQVI9pbtk7KSoUAXsCu5nRUeZQ037iLOGP0pmU6BROVCEteRi5avoAdIx
         Q16WSo2ptgsglK+WJ3u7rognfMvOM1kUQf47G/vTgTBpL2XYC9YguRiw0q+5x4l/yTzQ
         SKWpanjBR/xh6XZQEHplxVkoCSQk1Bp82K8StTeVhL5qG+7ZCdIPyxdnwI19N4NuDl27
         syQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=B55oe33tQCkzxWimg+ZfOhRx1c98hkXT02+HAEUdowc=;
        b=mLdVBPSVT2botBmQWgxNNx1dmHp8lJYgXMb6eiqBmZJ+Mf4Fx3GaLmMa6KxJYiYYPF
         hMAvGOButmsJyaJ4iteD2+o3m6PL5S9BXYsyQqAKNT/J6B728/VQpkSCcMgwk4dwXxLW
         DM/bN8qEP+TfTsJp9mGs7j3jTK0ybVlqpHRuGHQ7s9BMGosSJ1Sylz0QHWqQtDbhjlFE
         Inu3LphL4bdrBZ8nQacM5U57pP7r7MBZvMLUOpCk4/oO7QBaBXSs7QtmwvA59V+6QugB
         SpCKDe1IlIJM6kpBGQg2iNSYKrbZXOlzFycXIJ9EOLQ4at+5xExiFqyODqi5LmKnlINn
         oYiw==
X-Gm-Message-State: AOAM532WKjdbH7hHsq/KcHWEcg3ERMa4OPa0e5G7O7B/hRlIuxCo0etF
        sKWnzObGZ1BPRtvMZLGn5Xg=
X-Google-Smtp-Source: ABdhPJx+uDpxkJIQlhn1mTzdEM7d7VbDdagj0oOZlAXJItkakG8tdrIUEM/f8IUaNZuQLAiehyi8/A==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr24371728wrs.234.1591090463651;
        Tue, 02 Jun 2020 02:34:23 -0700 (PDT)
Received: from AnsuelXPS (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.gmail.com with ESMTPSA id h15sm2708805wrt.73.2020.06.02.02.34.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 02:34:21 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200514200712.12232-1-ansuelsmth@gmail.com> <20200514200712.12232-9-ansuelsmth@gmail.com> <20200601210844.GA1494556@bogus>
In-Reply-To: <20200601210844.GA1494556@bogus>
Subject: R: [PATCH v4 08/10] PCI: qcom: Add ipq8064 rev2 variant and set tx term offset
Date:   Tue, 2 Jun 2020 11:34:17 +0200
Message-ID: <090401d638c0$fdab0c10$f9012430$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQH3v0d+k9NO1qBgLdGiwEtxppfOxAJRdC88AVZe6H+oZMSG4A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Messaggio originale-----
> Da: Rob Herring <robh@kernel.org>
> Inviato: luned=EC 1 giugno 2020 23:09
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>; Sham Muthayyan
> <smuthayy@codeaurora.org>; Andy Gross <agross@kernel.org>; Bjorn
> Helgaas <bhelgaas@google.com>; Mark Rutland
> <mark.rutland@arm.com>; Stanimir Varbanov <svarbanov@mm-sol.com>;
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Andrew Murray
> <amurray@thegoodpenguin.co.uk>; Philipp Zabel
> <p.zabel@pengutronix.de>; linux-arm-msm@vger.kernel.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: [PATCH v4 08/10] PCI: qcom: Add ipq8064 rev2 variant and
> set tx term offset
>=20
> On Thu, May 14, 2020 at 10:07:09PM +0200, Ansuel Smith wrote:
> > Add tx term offset support to pcie qcom driver need in some revision =
of
> > the ipq806x SoC. Ipq8064 have tx term offset set to 7. Ipq8064-v2
> revision
> > and ipq8065 have the tx term offset set to 0.
>=20
> Seems like this should be 2 patches or why isn't 'Ipq8064 have tx term
> offset set to 7' done in the prior patch? One tweak is needed for
> stable, but this isn't?
>=20

Ok i will split this in 2 patch and set for stable the tx term patch.

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
> > --
> > 2.25.1
> >

