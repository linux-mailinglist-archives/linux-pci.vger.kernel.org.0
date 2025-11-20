Return-Path: <linux-pci+bounces-41737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFBC7295A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43D4D3482AE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 07:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA9A2BF019;
	Thu, 20 Nov 2025 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrXMQR4N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149372FDC53
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623545; cv=none; b=LgcQ/dcLNk4Eg26gQLp+XQEWs5aBswaB0dtlOQbu5B8aFkIujMZGIT79xEsQ2fAebR6tnwTtLL0u9/IBkzGtZwg2GadsDggUzznOFAfTvBLo/fdn8JreJ1PvesMAU8s1E0EeFrWD2UBH5o8HvIl5tKeDwxWcIbKG2pv4VWRIexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623545; c=relaxed/simple;
	bh=0BBRzQKaztjou1FCEm1RF9AHtnEOkfEB1zV8sHnTWIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4x9PHNPw2qkWx78DED1C9cid9jBhxy7UjhOieOYZ/zW9U9dWFz3LikkNt02SzadjITH6bhgm4HDOAWzcxUf3Kl0LEPmat/Th2mVut8ganmNPEe4L95ZgThvSgm47MKqI6NQYKBrQL+L4nV/JW5DDzV+921h1zmazx2OfnoloCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrXMQR4N; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso711800a12.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 23:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763623541; x=1764228341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oiy3MCCnIY+ubzrtfzu9IxcBIzwVrHngBHadvGb6qFA=;
        b=lrXMQR4NtTqiw/qpi/NXGvr72xvHw2SY9NLMmzj/mrHa2zGI7xZbjybcyIcwzDVZwH
         cDN6NlMnrCjoJDazuRaaRI+ZgiGFsSDcn1NKypDtxjtV27/OefQC17G7ir7TI26IPaJV
         Di3q/GcaEo0pXeZWBeGnsCHdI3LUrXazvp1uLXas5cz8gy9YlVBCceO/d/t198eSuZ8t
         NtUPnbQ/rWn0hulyKyxA2Dec3iKjHZLIllf6JlA7M+EBm1KVT/3BmfQIRYD8/DNXOZGy
         YLkC6JhGbiKCehhwSjuLIwrXgkC8mo57FEX3ixxcmV0Mco6HPa84S1S2NmdyH9Fe39A8
         C6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763623541; x=1764228341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiy3MCCnIY+ubzrtfzu9IxcBIzwVrHngBHadvGb6qFA=;
        b=Da31rRNCRs9yMm0BuLYJFCPkobk6Oq8xlzJV2RwN7h2Y5t5rKiTBek+ApCQDCvlQ83
         /ajRNTB8TDyeiZTylNaKPv/Iy4mmwX3ydK022nV6C9ZqG6y990InJH5rRCMKCwtHWAFL
         a7cYVcDV1mWlilq2nCogKU/0OIpJ4clI/FCckXzVuS/8DfUmzP3FWd8a/1HF4dyqTiIz
         vFm+cT2PwmNxxn5L7VI4Ma1yLiBHgCXTCng0ffdO7duNraE3azR4VLSX7PHd6dkPK4NA
         6B46B1qDwX8wL5nid3ZERz96HIyzYu1DT2dUFfoDYjDGCOKE/LLEV4oWttCKUZpKQIYq
         vZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXvcVdqW7HtZybZsxRcWWsU7d84GfZ3SMP2nitTVJmS95WRLxAwNA/u+eInREfVHe8th1IrGutIBic=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4L1OaEDNedgZ6Q8EPhmmrMbY4YRgPiMXvpB7PHn45N3D7/fE
	NcQNWsOwX2IH+5MNTGGYWhsBUJ+WNW6rcUleqnaQBN9IUGq3/GR9HpbSX8nnjkxS+JC0mOS9rkg
	BqbsuF2hZdhnoG5y+DFiWDiuTomdZbNv6m5idwgpPbg==
X-Gm-Gg: ASbGncta07fyiBjlMqHlM3kyv5fp9a4SpU/JNDOk/oWWUTGm3P0C+sjZ7V6tohia9Mo
	z04RUz74rtl/wHnl6aQR1WtGHBTD7mXEmwOlhYXBaRmgi3zOB6z6xCN9jQS6XABwVJesyrRwif7
	FAuVfzckx1gARMzRVTiJ+6UvY6/5YlmM4nOOlRJhh1XGTPTke6+OFA5YvVcC8q+i57eaoVeQdf5
	AYtAJzghgmUTR+GiLsc/C1UoLuHT+suMzXbasscZrXkw4Q6fezBuKuiyz9lQzJrndxzPG4VsSoz
	/mNqiI1YJGeMu3n0V3zLrzv4
X-Google-Smtp-Source: AGHT+IFAQcf4dBYNDEi3TsDPhv8jstrKlO8aZK1F8IULbrCW1q+UfabVpHtWcfiu1HcoO4gSrjXgCyaW6ykmeZfOoLs=
X-Received: by 2002:a05:6402:278d:b0:641:62bb:9c0 with SMTP id
 4fb4d7f45d1cf-645364652a8mr2343347a12.33.1763623541321; Wed, 19 Nov 2025
 23:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-4-vincent.guittot@linaro.org> <aRymVtJKtcydh3g5@lizhi-Precision-Tower-5810>
In-Reply-To: <aRymVtJKtcydh3g5@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 20 Nov 2025 08:25:30 +0100
X-Gm-Features: AWmQ_bms-sMetVoc9nOrTa8Xt52hfzy9ouUOYIu45ml1BzNFdlb7_KVvCi0dBPc
Message-ID: <CAKfTPtAhQJK1ezv3JF6FBK5ZBBWCWM0ADeg0SG2EG_2JjfzaMA@mail.gmail.com>
Subject: Re: [PATCH 3/4 v5] PCI: s32g: Add initial PCIe support (RC)
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Nov 2025 at 18:01, Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Nov 18, 2025 at 05:02:37PM +0100, Vincent Guittot wrote:
> > Add initial support of the PCIe controller for S32G Soc family. Only
> > host mode is supported.
> >
> > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |  10 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  21 +
> >  drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 391 ++++++++++++++++++
> >  4 files changed, 423 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> >  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 349d4657393c..e276956c3fca 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -256,6 +256,16 @@ config PCIE_TEGRA194_EP
> >         in order to enable device-specific features PCIE_TEGRA194_EP must be
> >         selected. This uses the DesignWare core.
> >
> ...
> > +
> > +static int s32g_pcie_init(struct device *dev, struct s32g_pcie *s32g_pp)
> > +{
> > +     int ret;
> > +
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +
> > +     ret = s32g_init_pcie_phy(s32g_pp);
> > +     if (ret)
> > +             return ret;
>
> Small nit:
>
> return s32g_init_pcie_phy(s32g_pp);

Yes

>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Thanks

> > +
> > +     return 0;
> > +}
> > +
> > +static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
> > +{
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +
> > +     s32g_deinit_pcie_phy(s32g_pp);
> > +}
> > +
> ...
> > +
> > +module_platform_driver(s32g_pcie_driver);
> > +
> > +MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
> > +MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.43.0
> >

