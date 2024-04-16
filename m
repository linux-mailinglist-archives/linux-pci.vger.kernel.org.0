Return-Path: <linux-pci+bounces-6335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C28A7706
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 23:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D439328139A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE36EB4E;
	Tue, 16 Apr 2024 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8pTONLL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB31E4BE
	for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2024 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304264; cv=none; b=pJJwR13TYIR6rqeImZ4/YboaqhZx0yhzHfXFDt3qUPdPFgYkc0XxGkR7ujZPztXtq1ndokD0yWodCekSnn6Bd0ve/Dbw9DPjq8fccLcLWIUpXdA4XA86m452Zk9Nkwo3WX4KRdjtMOOuBU8zGSFWYsQct36gEIMODGtJsqRkps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304264; c=relaxed/simple;
	bh=YO5IN0KZGxb6z4yVpPgZdYK16LCj/M+XOfATsFeZlLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8v5kw8llPcLpp2SgjR0wwV2w9CoAtQ4iStm23sMyS+m474oEucgf9c1hplNeylZn5WipXKnVQJuZOUD2XTI58QkI2Z97DHZhdbAe7zF0zd6jN9dUJ4xC/okDE8Au3LBNowR0K948rI1296hSxMOCgAD4PFPfMrfTkgryUMqSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e8pTONLL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61ae6c615aaso19965787b3.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2024 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713304260; x=1713909060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kjacwD0Z0JhzcTISBRsYUI2PwcebrTIi/3ViNZqx+HY=;
        b=e8pTONLLAdpUkLNDhBueJPfuecshcYrK3O6FQLOdHZs8HvubglJ/zabeMEUddbe7oO
         Oo6bOy+GFj3N8+1BuSz7BFwT7nFf/gKi4FjeD+xsRwsrS18Vsv2bUJJNl679hCQmeHxI
         9bGkJXksghK48lfzu7MX/PnZTuvGcYyGtLgcPYb3JFzbTz9yE+GH5qDnutczz7GkhzfA
         YkQzwEP1l/7bgKcbGGEU1e06ttoZcVcbupEnD2ACDoZwY+JK5J0j5mW03b/gA+lDPGy3
         uCAxWThXsuesNk23vv2uFv0hKc5CzX2ohfwRQO0wuMQCxim6g8lDSPGo9pc0HzEYWls9
         StAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713304260; x=1713909060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjacwD0Z0JhzcTISBRsYUI2PwcebrTIi/3ViNZqx+HY=;
        b=nVVQEbk3QJgbLG/gbixSgdFrxIAnkLM68ETeWuyw0tkcNdR9bVV6WyDnA0pxEQZAag
         wJVvJ3ekH0pOSqXFPg/5uBgF9eEPyO8nKs3d/0949vPzcfoe5Wv/lR/9YPaWyM1bNDHo
         sdiEE7FkfqIA37omGyhgkiui5+dlanjdhSEiM9VmLkQGxywKqT4WLsqCOPaWqmmvsoFZ
         u0fWurnYqX1KLeQlX5ZjgrHeQzTlz6Fh1cvEqyWK8JvewRsnsP4BA7rNiI5Dw149VE/A
         xvqsCHcvdYJCEv/hB1nrDYNtYV8kD8yC0O44MRJLUgmJktw2BOO9+ZdAQhnCVfXHp+0Z
         HP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHnuYXU/AjeoZnCFAgRRHDrqzvm0dz0f7om2FXpidaj/jdEGJD/PezuAA2B6UajSDjcwvqpUCmaxpW401RybJj1FUfoHIs55/V
X-Gm-Message-State: AOJu0YymK3uvgSqTnhGOE9y4VdbOF/OlZmYQJ7AtX6fvJeVftov5jB9X
	X1Lzt9q+LUhd+qBnKZcc7siSfQLbU/u4H1ewbpiYEKHHCG40TdDCzwakzZ2xbaUBjFtAYxafh2a
	z9RBnFzxa2+/urUBFyTUpnx0wfYnEKbGoHBK+DA==
X-Google-Smtp-Source: AGHT+IHwf4S0I3CIxt2zebmdygPEKzxzcZAva7zQrKgbnJ+VAk/Eu2tIwupOVk1YuWmguhQVN3+jp9oteWNx3Ywc3xc=
X-Received: by 2002:a81:ac65:0:b0:611:1861:1f0 with SMTP id
 z37-20020a81ac65000000b00611186101f0mr13251817ywj.52.1713304260489; Tue, 16
 Apr 2024 14:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415182052.374494-1-mr.nuke.me@gmail.com> <20240415182052.374494-7-mr.nuke.me@gmail.com>
 <CAA8EJpqY1aDZMaeqBULEOD26UeGYbLd8RsA16jZw7zXJ7_oGPQ@mail.gmail.com>
 <6726fa2b-f5fe-10fb-6aab-f76d61f0b3cd@gmail.com> <4a7b1e1d-ac68-4857-8925-f90c9e123fd1@gmail.com>
In-Reply-To: <4a7b1e1d-ac68-4857-8925-f90c9e123fd1@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 00:50:49 +0300
Message-ID: <CAA8EJppGW=qyk2P6Z_S=dp0njsCjqZaXjw8qU4MY1HOZR-N=4A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
To: "Alex G." <mr.nuke.me@gmail.com>, Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 00:25, Alex G. <mr.nuke.me@gmail.com> wrote:
>
> Hi Dmitry,
>
> On 4/15/24 16:25, mr.nuke.me@gmail.com wrote:
> >
> >
> > On 4/15/24 15:10, Dmitry Baryshkov wrote:
> >> On Mon, 15 Apr 2024 at 21:23, Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >> wrote:
> >>>
> >>> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
> >>> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
> >>> being reused from IPQ8074 and IPQ6018 PHYs.
> >>>
> >>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >>> ---
> >>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
> >>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
> >>>   2 files changed, 149 insertions(+), 1 deletion(-)
> >>>
> >>
> >> [skipped]
> >>
> >>> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem
> >>> *base, u32 offset, u32 val)
> >>>
> >>>   /* list of clocks required by phy */
> >>>   static const char * const qmp_pciephy_clk_l[] = {
> >>> -       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> >>> +       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> >>> "anoc", "snoc"
> >>
> >> Are the NoC clocks really necessary to drive the PHY? I think they are
> >> usually connected to the controllers, not the PHYs.
> >
> > The system will hang if these clocks are not enabled. They are also
> > attached to the PHY in the QCA 5.4 downstream kernel.

Interesting.
I see that Varadarajan is converting these clocks into interconnects.
Maybe it's better to wait for those patches to land and use
interconnects instead. I think it would better suit the
infrastructure.

Varadarajan, could you please comment, are these interconnects
connected to the PHY too or just to the PCIe controller?

> >
> They are named "anoc_lane", and "snoc_lane" in the downstream kernel.
> Would you like me to use these names instead?

I'm fine either way.

> e>>>   };
> >>>
> >>>   /* list of regulators */
> >>> @@ -2499,6 +2593,16 @@ static const struct qmp_pcie_offsets
> >>> qmp_pcie_offsets_v4x1 = {
> >>>          .rx             = 0x0400,
> >>>   };
> >>>
> >>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
> >>> +       .serdes         = 0,
> >>> +       .pcs            = 0x1000,
> >>> +       .pcs_misc       = 0x1400,
> >>> +       .tx             = 0x0200,
> >>> +       .rx             = 0x0400,
> >>> +       .tx2            = 0x0600,
> >>> +       .rx2            = 0x0800,
> >>> +};
> >>> +
> >>>   static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
> >>>          .serdes         = 0,
> >>>          .pcs            = 0x0a00,
> >>> @@ -2728,6 +2832,33 @@ static const struct qmp_phy_cfg
> >>> sm8250_qmp_gen3x1_pciephy_cfg = {
> >>>          .phy_status             = PHYSTATUS,
> >>>   };
> >>>
> >>> +static const struct qmp_phy_cfg ipq9574_pciephy_gen3x2_cfg = {
> >>> +       .lanes                  = 2,
> >>> +
> >>> +       .offsets                = &qmp_pcie_offsets_ipq9574,
> >>> +
> >>> +       .tbls = {
> >>> +               .serdes         = ipq9574_gen3x2_pcie_serdes_tbl,
> >>> +               .serdes_num     =
> >>> ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
> >>> +               .tx             = ipq8074_pcie_gen3_tx_tbl,
> >>> +               .tx_num         = ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
> >>> +               .rx             = ipq6018_pcie_rx_tbl,
> >>> +               .rx_num         = ARRAY_SIZE(ipq6018_pcie_rx_tbl),
> >>> +               .pcs            = ipq6018_pcie_pcs_tbl,
> >>> +               .pcs_num        = ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
> >>> +               .pcs_misc       = ipq9574_gen3x2_pcie_pcs_misc_tbl,
> >>> +               .pcs_misc_num   =
> >>> ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
> >>> +       },
> >>> +       .reset_list             = ipq8074_pciephy_reset_l,
> >>> +       .num_resets             = ARRAY_SIZE(ipq8074_pciephy_reset_l),
> >>> +       .vreg_list              = NULL,
> >>> +       .num_vregs              = 0,
> >>> +       .regs                   = pciephy_v4_regs_layout,
> >>
> >> So, is it v4 or v5?
> >
> > Please give me a day or so to go over my notes and give you a more
> > coherent explanation of why this versioning was chosen. I am only
> > working from the QCA 5.4 downstream sources. I don't have any
> > documentation for the silicon
>
> The downstream QCA kernel uses the same table for ipq6018, ipq8074-gen3,
> and ipq9574. It is named "ipq_pciephy_gen3_regs_layout". Thus, it made
> sense to use the same upstream table for ipq9574, "pciephy_v4_regs_layout".
>
> As far as the register tables go, the pcs/pcs_misc are squashed into the
> same table in the downstream 5.4 kernel. I was able to separate the two
> tables because the pcs_misc registers were defined with an offset of
> 0x400. For example:
>
> /* QMP V2 PHY for PCIE gen3 2 Lane ports - PCS Misc registers */
> #define PCS_PCIE_X2_POWER_STATE_CONFIG2                    0x40c
> #define PCS_PCIE_X2_POWER_STATE_CONFIG4                    0x414
> #define PCS_PCIE_X2_ENDPOINT_REFCLK_DRIVE                  0x420
> #define PCS_PCIE_X2_L1P1_WAKEUP_DLY_TIME_AUXCLK_L          0x444
> #define PCS_PCIE_X2_L1P1_WAKEUP_DLY_TIME_AUXCLK_H          0x448
> #define PCS_PCIE_X2_L1P2_WAKEUP_DLY_TIME_AUXCLK_L          0x44c
> #define PCS_PCIE_X2_L1P2_WAKEUP_DLY_TIME_AUXCLK_H          0x450
> ...
>
> Here, QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2 = 0xc would be correct,
> assuming a pcs_misc offset of 0x400. However, starting with
> ENDPOINT_REFCLK_DRIVE, the register would be
> QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE = 0x1c. Our offsets are off-by 0x4.
>
> The existing V5 offsets, on the other hand, were all correct. For this
> reason, I considered that V5 is the most likely place to add the missing
> PCS misc definitions.

Ok, sounds sane. Please use _v5 for the regs layout.

>
> Is this explanation sufficiently convincing? Where does the v4/v5 scheme
> in upstream kernel originate?

Sometimes it's vendor kernels, sometimes it's a feedback from devs
that have access to actual specs.


--
With best wishes
Dmitry

