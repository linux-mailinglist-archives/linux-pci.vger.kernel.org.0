Return-Path: <linux-pci+bounces-36410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C55B83EC4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 11:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DF134E1B9C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223982C026D;
	Thu, 18 Sep 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSIodTy7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D70274B37
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189282; cv=none; b=rMa2nNKscKaVhZ4IQgqeypU9+m9Ss14JcYB4c54U9wWqgAge3+hWMTwNh2rToH4F5RhybSldFt3rO7CWVvwJu13VouyP6h2LMnUljEq0d0guI9zxJPVwc7oA75isK1Uh+5q5Bq0JUvW3spFlID8aS3NwCpnml/P4MoOfNdB33po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189282; c=relaxed/simple;
	bh=HvpH/we1i8j6YDiaciJy38Drhc0hF4JJPv6YA9NqLZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enGmXhjInbry05gTSTwU8eNt+Vz2IHMfoO/PegYdTcHJIMrPlNaA6ts0/1jyLbLPvFdFZcrXcPufQPzCjP19sgmQzpdz40DId4Oa9dgSmZEip43vxMs4GhPkgIsf8bBkqW8SbMwnKva5h3QOQn0wbOJsPnjWyzVC4t5J+bC5S+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSIodTy7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fa99bcfcdso664892a12.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758189279; x=1758794079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3uhf87DrC/GqYd1AzAwWRkEB5wkIeXkNvqHSQcwwy4Q=;
        b=WSIodTy7iljYjesgsd6VPAkcROQzsgZ21/VGGHsoiRHyTWb5zCr1Iyfj+hfhTF8jZU
         8YIyVi8SXNvVO9xjIzBkfaOCiOAe600uuckRekGwOAiOtM/RqjWimK5929zZmDek7lfc
         iRn3vg5RsqZj3XPT2D9oQ8oZ0saHPhxL+LKdJ1EmdDOvRztrynueKcLBkec/9kAUVflY
         5Ns1DtCvxmK2PiVD/7oyDuo3gd+4bmJqQCcnouqYoekAvQ6/1nWJAXSru6KXgrLbLIEC
         FrFu9FyHwpqGrM2XEOvfNCTEQqLL6TOd6aep1pKJVOw1L0UG2UyRjg2I8ZP4MI0fjQWT
         ly6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189279; x=1758794079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uhf87DrC/GqYd1AzAwWRkEB5wkIeXkNvqHSQcwwy4Q=;
        b=mq8fYfgz2e1HA6yBKtp2jhNNelD21kQ1xG08XyWP/MIs936xbjKqx2JZuN3Xa/L2b2
         pNH6RypuZ3T2XYIZwfrHpJ38KFg56T/a/V0D8HJYQajvP1fWRZJVySy3+hH8mM+PizmA
         bNTidAr2FU04N7GuXaoZPdDwTpikLkVPJWEmGYzwKGvqXjJMF/z7OOAC7LhH0YuRAdjr
         V3nQhxllndQnNnpOf03DgQV1qLoHI/AICV14D+SQwK8yr2x72WlLw39rC5uwE3X53jF8
         q/ljchXpqiySv7EeUjBI6Q3WSW3o5TA46QpN/QgVs6wsVEE47I/XnSfCL3SH117522zy
         WpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5gRtdLNDscBUA3WqgWwHJFUhXtU9Qiq2rUd8F5E8C8jCBiDp8xVLEnEnAzT0oPkzMbH+r1rBK2PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zRfgU/vKtM+dpav1HgKKRbu7HN8vPVobNEizwb8ZYyYvJAV5
	TmWWEWqC67+XvSvejdvSYBd8F5IugmTknpJOMEbg4PpXKdqsgJBRnywxTW+d/6S+tW1l7qwIs1q
	nwA/EsjSmEqbxDUOaV5CgULRsLDkyhHb/oNsriNSgPA==
X-Gm-Gg: ASbGncsK147P0qtLkPdt1aaF0CuFZ+09oCN+qS36xs05PnBlVWjmsSfF8gQaAtaROqL
	wN5dxCvHpBmaSmUNYpj4nR1BdVwiB1Z6yP10LEjt8ja1BdHNACqFptDsl+/cmFY6uBrs9EcoU+h
	Fgfd/6yG5G95ttDgXftZzKZ+VprhFniFBbtpQfBa4lPlAIKZwzZjhHWI6/0LjmMDLDph764o12Q
	1GE1CMNjtE2fs/PN7SDqyvB4XsFw6YmWaxcvouGAQHjP4CuqEC0
X-Google-Smtp-Source: AGHT+IE1zmv9oHlYf6BUBNOW+SUyz6ajjYN0b3+2pAlc66/NC3KjbbHlv5KbLza2QpbO9MoNOwx3daqo5CZgA0JV3IY=
X-Received: by 2002:a05:6402:2115:b0:62f:7968:e1ca with SMTP id
 4fb4d7f45d1cf-62f84798527mr4551388a12.38.1758189278612; Thu, 18 Sep 2025
 02:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e236uncj7qradf34elkmd2c4wjogc6pfkobuu7muyoyb2hrrai@tta36jq5fzsr> <20250917212833.GA1873293@bhelgaas>
In-Reply-To: <20250917212833.GA1873293@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 18 Sep 2025 11:54:26 +0200
X-Gm-Features: AS18NWDHkrQ8kASDtWOuxujVdqn0GrRUTOJ77F2So0WyDmX2EIKvc-v29xTUv-g
Message-ID: <CAKfTPtCizQ7nk3P4Dzi6uFewH5GcAnMakMt5=bK-Ykayp3t7XQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, chester62515@gmail.com, 
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com, 
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 23:28, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 17, 2025 at 10:41:08PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Sep 16, 2025 at 09:23:13AM GMT, Bjorn Helgaas wrote:
> > > On Tue, Sep 16, 2025 at 10:10:31AM +0200, Vincent Guittot wrote:
> > > > On Sun, 14 Sept 2025 at 14:35, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > > On Sat, 13 Sept 2025 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > > > > > > Describe the PCIe controller available on the S32G platforms.
> > >
> > > > > > > +                  num-lanes = <2>;
> > > > > > > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > > > > >
> > > > > > num-lanes and phys are properties of a Root Port, not the host bridge.
> > > > > > Please put them in a separate stanza.  See this for details and
> > > > > > examples:
> > > > > >
> > > > > >   https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
> > > > >
> > > > > Ok, I'm going to have a look
> > > >
> > > > This driver relies on dw_pcie_host_init() to get common resources like
> > > > num-lane which doesn't look at childs to get num-lane.
> > > >
> > > > I have to keep num-lane in the pcie node. Having this in mind should I
> > > > keep phys as well as they are both linked ?
>
> > > Huh, that sounds like an issue in the DWC core.  Jingoo, Mani?
> > >
> > > dw_pcie_host_init() includes several things that assume a single Root
> > > Port: num_lanes, of_pci_get_equalization_presets(),
> > > dw_pcie_start_link() are all per-Root Port things.
> >
> > Yeah, it is a gap right now. We only recently started moving the DWC
> > platforms to per Root Port binding (like Qcom).
>
> Do you need num-lanes in the devicetree?
> dw_pcie_link_get_max_link_width() will read it from PCI_EXP_LNKCAP, so
> if that works maybe you can omit it from the binding?

num-lane is not mandatory but we can have 1 or 2 lanes so should be
able to restrict to only 1 lane for some platform
the "num-lanes = <2>;" in the example is wrong as we don't need it in
case of 2 lanes but only if we want to restrict to 1 lane

>
> If you do need num-lanes in the binding, maybe you could make a Root
> Port parser similar to mvebu_pcie_parse_port() or
> qcom_pcie_parse_port() that would get num-lanes, the PHY, and
> nxp,phy-mode from a Root Port node?
>
> Then all this would be in one place, and if you set ->num_lanes there
> it looks like the DWC core wouldn't do anything with it.

