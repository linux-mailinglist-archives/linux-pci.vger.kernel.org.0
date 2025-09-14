Return-Path: <linux-pci+bounces-36099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47D3B568AE
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834C716278E
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C39238C0D;
	Sun, 14 Sep 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2tfi+L4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B181DDC08
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853386; cv=none; b=FkUAM0CMWLPbQ8FEfmeG2dltDxG9Wazq1k3pEZ2v2m7jwSK8Xr5BRxwy2rCIt7GNnnc7qPVWcZIKANXTrN+n/ch8sgCdXvCLGiwqtFxe9QIIMPkUqbCGlCF4SV91b3VmvvNQt/8k3h7mzL/rubkSzyNk3cXAhJ5smmupsvNT73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853386; c=relaxed/simple;
	bh=z5cXpDMyuJ+Ht6r3/PhJmTnt5q2Pgn8JuraH6UOXQks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3K4LlH6vaBxusdqICXdXCcaEmX+78nAGm8wDprbgsrFkvmdlikReKXiZFF4a9jplzjdopP9e/zPcsLE03t7C1snzg/OdbOTHAIBGOUCYMCvs16cU+OB6I0ao0Bc9KyZC6KuBqCkjVTYvm0F2CHgq8jWemM2NADUmzSFk49h9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2tfi+L4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-627b85e4c0fso5309361a12.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757853382; x=1758458182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XzitEMhuyn3awzPo2ebuyIpUU8Id0dDSX6YSKZOv+ZU=;
        b=L2tfi+L45Q4ArYvTDKAG+/aw3/V0DGGZGDakemCBzIEGGszvfinIsdNBdgvWL6/+1k
         zuUSAJvZbtaGLUUdaU4+7+3s+rTkI4om4L9rCfLhD+SWOXXfuMKX7/bL2NfBUSlS+8+6
         +peN1CDmRYP/GTSU5xFR0zoirEt2REFSAQQJ9zqst3zkDtAr4HCRAeRnCBrbk9oOa+nU
         DSzWMTNCL32L5lEXNovAmWe4QO6zuUMobNly6VHRRmhb3+AE+RR9+W8bjc/VqbtasyxV
         qX/J+0ygNf3v9Kx0jk4HfjtHqxk4A2F3/W+0CwX/u5wllyMVTcqhLnZZa7vaxr1oKRMf
         5AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853382; x=1758458182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzitEMhuyn3awzPo2ebuyIpUU8Id0dDSX6YSKZOv+ZU=;
        b=PIR3Hj5K1iidL/VQcoSEsGSmT3dLPLIDhqlha28exKeaDbvSfDv0YDTRP5sKnQ1IT1
         3AMw4UJp7tXJHVSTGnR+FU+p0BCndQsfHGnVMdekQg8ELA6czgg0I4soHxjqLTfUJKlY
         pHhYcSK5XzSF4wZHKtlR2khnMMSGpsr4XpBS0YkGEJ0xAZWkJG36t1G/FJk8FWY4613M
         luZOgIdYmt/6meVAqYeQDxF9CB5N1ldaozDBfGvXcoZGCVl0Lteyfo7Ywzh2abCnBXQl
         NHWSKOVMU7fiE1uVqSxdiM3BAcPKA8SPPGacNFtyXdDBAhLz8gfRL6GOVSJ3pqF2UkMb
         sY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVX/eH/gCKAjxYACMjfrrdeo3Cg1LSGEAebaKqU9h5ZDa5VcrGY7V8VWU86a0wwG70am5wOpVWlOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAAJbRD4KvCf1NmwO+naukamaUPGKWjwfpKQisdpbTAyxk9q4F
	IRpL4y3syYQMupm4BX71RfDB5HyqtMd16bHBjl4qSfhSUoOD/JJ+N6Aq//OeOiENxBZQBqdxvZk
	r4wGxDDBKsuBSmitsW7J5FnXB+kEKdKvB+wzwiTT36w==
X-Gm-Gg: ASbGncvU76OyACaHjJotCAVEdWoC2FZPDrxzQrzqOZkXi04VVdLPAtmiJtuo9ROv9qy
	L2MloxU1AzRbRLAMi9IgpRU5yJ1du+kzh4Rpf7RfnOxNL7dxCEKoZ4jHOD2vnWYKZaUMpLuN29f
	ev3nsIlsIdxftybCSXVnnj6rxKYhk/7OTQ9skpjKcpEg3B1Foh8kkQvFCXq8DLYv3ufZM0r526A
	pf1w9Y8iRfP04a9nJERcSCD94EPl5VCciBKKopXwnO0Qwm3aYuX0d/eUQ==
X-Google-Smtp-Source: AGHT+IGLgebxMOwJM71zc3D3ToXnk7YnVzCirJGRT8ZrnA27mi4s1untjNEF1bLojbZ0S1PNlaf1GTIT/qLxGso+faQ=
X-Received: by 2002:a05:6402:84c:b0:625:ec92:9cb9 with SMTP id
 4fb4d7f45d1cf-62ed97f056amr9211931a12.6.1757853382608; Sun, 14 Sep 2025
 05:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-3-vincent.guittot@linaro.org> <20250912221817.GA1650405@bhelgaas>
In-Reply-To: <20250912221817.GA1650405@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Sep 2025 14:36:11 +0200
X-Gm-Features: Ac12FXyJQFQuZhjlTZQnQvt2nz8ZamVHOj5HVBPrh9aJUXB8J86pKRnbeO0Lw-0
Message-ID: <CAKfTPtCm8QLrMv6CF9KWRf__39bRnx7VOA=rf6M5zJmHL-ekgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] pcie: s32g: Add Phy clock definition
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Sept 2025 at 00:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Sep 12, 2025 at 04:14:34PM +0200, Vincent Guittot wrote:
> > From: Ciprian Costea <ciprianmarian.costea@nxp.com>
> >
> > Define the list of Clock mode supported by PCIe
> >
> > Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  include/linux/pcie/nxp-s32g-pcie-phy-submode.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> >
> > diff --git a/include/linux/pcie/nxp-s32g-pcie-phy-submode.h b/include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> > new file mode 100644
> > index 000000000000..2b96b5fd68c0
> > --- /dev/null
> > +++ b/include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/**
> > + * Copyright 2021, 2025 NXP
> > + */
> > +#ifndef NXP_S32G_PCIE_PHY_SUBMODE_H
> > +#define NXP_S32G_PCIE_PHY_SUBMODE_H
> > +
> > +enum pcie_phy_mode {
> > +     CRNS = 0, /* Common Reference Clock, No Spread Spectrum */
> > +     CRSS = 1, /* Common Reference Clock, Spread Spectrum */
> > +     SRNS = 2, /* Separate Reference Clock, No Spread Spectrum */
> > +     SRIS = 3  /* Separate Reference Clock, Independent Spread Spectrum */
> > +};
> > +
> > +#endif
>
> I doubt this belongs in include/linux/.  It looks like it should be in
> pci-s32g.c since that's the only use.

The header will be used by other driver so I didn't want to manage the
transition and a patchset which would includes drivers from different
areas

