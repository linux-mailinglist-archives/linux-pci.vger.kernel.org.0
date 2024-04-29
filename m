Return-Path: <linux-pci+bounces-6778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302278B55E4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1F61F22E50
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40C43A8FF;
	Mon, 29 Apr 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqN72Smo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24020383BA
	for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388147; cv=none; b=MYdpkvRoWJzHHPDsy1SOAm25xHD8Pc5lizW673EZkxsqVWFDoYcNGkOlLg5tka4Nv8vI5D5baRNwPz5L/Bpw7NLXMrtdW7bzijdxcBZiIj7aCQihfjSj8mjfbME1rm01eC9fH5bCOjlOmUpAlBc8KHMrOzKlxhwLQfyQkcZLpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388147; c=relaxed/simple;
	bh=Xpupn6nv6f2q38+tmYSrohtAxHhfoWPOabgy2X+P2HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eegfEIWqYmO+J3qEHZGlUaltpYl7HJHElfEwaDLosYaQ5zqgMvdlw0c1uHS+eM2x6kPbXsB+VlE38x8JA4O1rwZbP25jplzR7pal5fLb5sAL8bfq7X6pw68PzUpsH9SVj5NzDALWBhf7nczKY9tMkdNkNFP0GflwXvZpydvT6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqN72Smo; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de46da8ced2so4927779276.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714388144; x=1714992944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HK9OBY6JCsI5PbvjejB+IUXQa8uw72iX0OVXzGaQJV4=;
        b=RqN72Smo87boybYk0biU491UJ2hX+RJHRb0epw9NuEPoXPbZy+O/dcrX2UQzwz8zfn
         22unEBQRlyVVqSgIQ/HEephQ9WNkxmNkLm8v2VzY5JUlHFujea//EyDoUTY6m0hgFpJD
         vSixFTitHZPDDzbd/I3UGA4l0UoHZjBbeZbI0FbsSwFOjZJImU4hDUfDlniXwaeSsrJ1
         NdQQjLtv7e/TT8Norxfk8IVQsMmxpYgXr6BpoPtQQ1Iqb2cQXmjWc98pYN0UPW96r8G6
         8dKBcsZvFHCValowyiSrTJAnLiJnSU138DJr9MctjH2udQl5ua90RDaXiVV6R7kX0Xaw
         IZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714388144; x=1714992944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HK9OBY6JCsI5PbvjejB+IUXQa8uw72iX0OVXzGaQJV4=;
        b=BPZpadq8K8cg4oc6ldWuw+RRNY7ekdXT6rD9AVuPaGAOPeh7Ew+vRoBWakFh+GMLv2
         9F+TtKqrlZ6QSq3kV/lbkFM+/i5j0VseBa18O7Iy6rFbBbpqgWHPmkqC6c9GbTwUTutZ
         m0XV5s67WTbsBCJlUlXC6dWFnwKyNZvm9ipp//FHd+RtFpiQmNxdunXayXNbsO4Gp1ia
         9+R9os66aDLKxsemeOXk0yl1VZCuqxd+1grGGQd53fWZ6xshB30ELiU2bpMXhJOlL9lm
         u7YMs2uBOcc3YprrPDhcEVF7FK5bs+6/CqpcwszlALwa0dvYe42zLUuSDAPJPQQ4/DX5
         lhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6gfIs/8nNZHgaxaritERd3h5waxoLrWIU5Rz3auPwzkX4TFsQXSO13QAu3eweKXcoiwmBS8GEti+Go/vi3nTELx5TLggpUetR
X-Gm-Message-State: AOJu0Yy/jZ4F0EZ5AM8d9+ZdpQ/9frtKbfUxyKXtukTqfPcF8ULPN8M+
	Ous+g2k4o8iYRDxljxauCSu4T9ve2byITx7M4oj+S8wohQcC3Bl5rpBJ1RIVrvpZgvE1B7YiP9y
	5Hf4B886pALJ+oM8kMXbP0jgp4tpFG7/aybr/iA==
X-Google-Smtp-Source: AGHT+IGnLAI/1mmfL0Yrtu3STdW3JZRgrtSe9fLYX4PwRR3wSZS0mEZbbEeASJOYhpilXlNLDeYA2jBBTzekDMQ4uOM=
X-Received: by 2002:a25:ae18:0:b0:de5:5d4b:1632 with SMTP id
 a24-20020a25ae18000000b00de55d4b1632mr9731287ybj.60.1714388144152; Mon, 29
 Apr 2024 03:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415182052.374494-1-mr.nuke.me@gmail.com> <20240415182052.374494-7-mr.nuke.me@gmail.com>
 <CAA8EJpqY1aDZMaeqBULEOD26UeGYbLd8RsA16jZw7zXJ7_oGPQ@mail.gmail.com>
 <6726fa2b-f5fe-10fb-6aab-f76d61f0b3cd@gmail.com> <4a7b1e1d-ac68-4857-8925-f90c9e123fd1@gmail.com>
 <CAA8EJppGW=qyk2P6Z_S=dp0njsCjqZaXjw8qU4MY1HOZR-N=4A@mail.gmail.com> <Zi88Hdx6UgBo/gti@hu-varada-blr.qualcomm.com>
In-Reply-To: <Zi88Hdx6UgBo/gti@hu-varada-blr.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Apr 2024 13:55:32 +0300
Message-ID: <CAA8EJpq+Bbws8yH5Xq7rHyA+-=DaCcfEcgUa5RUt2+LWQW0kKg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: "Alex G." <mr.nuke.me@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 09:20, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Wed, Apr 17, 2024 at 12:50:49AM +0300, Dmitry Baryshkov wrote:
> > On Wed, 17 Apr 2024 at 00:25, Alex G. <mr.nuke.me@gmail.com> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On 4/15/24 16:25, mr.nuke.me@gmail.com wrote:
> > > >
> > > >
> > > > On 4/15/24 15:10, Dmitry Baryshkov wrote:
> > > >> On Mon, 15 Apr 2024 at 21:23, Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > > >> wrote:
> > > >>>
> > > >>> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
> > > >>> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
> > > >>> being reused from IPQ8074 and IPQ6018 PHYs.
> > > >>>
> > > >>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > > >>> ---
> > > >>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
> > > >>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
> > > >>>   2 files changed, 149 insertions(+), 1 deletion(-)
> > > >>>
> > > >>
> > > >> [skipped]
> > > >>
> > > >>> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem
> > > >>> *base, u32 offset, u32 val)
> > > >>>
> > > >>>   /* list of clocks required by phy */
> > > >>>   static const char * const qmp_pciephy_clk_l[] = {
> > > >>> -       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> > > >>> +       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> > > >>> "anoc", "snoc"
> > > >>
> > > >> Are the NoC clocks really necessary to drive the PHY? I think they are
> > > >> usually connected to the controllers, not the PHYs.
> > > >
> > > > The system will hang if these clocks are not enabled. They are also
> > > > attached to the PHY in the QCA 5.4 downstream kernel.
> >
> > Interesting.
> > I see that Varadarajan is converting these clocks into interconnects.
> > Maybe it's better to wait for those patches to land and use
> > interconnects instead. I think it would better suit the
> > infrastructure.
> >
> > Varadarajan, could you please comment, are these interconnects
> > connected to the PHY too or just to the PCIe controller?
>
> Sorry for the late response. Missed this e-mail.
>
> These 2 clks are related to AXI port clk on Aggnoc/SNOC, not
> directly connected to PCIE wrapper, but it should be enabled to
> generate pcie traffic.

So, are they required for the PHY or are they required for the PCIe
controller only?

>
> Thanks
> Varada
>
> > > They are named "anoc_lane", and "snoc_lane" in the downstream kernel.
> > > Would you like me to use these names instead?
> >
> > I'm fine either way.
> >



-- 
With best wishes
Dmitry

