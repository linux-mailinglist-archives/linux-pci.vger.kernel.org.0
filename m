Return-Path: <linux-pci+bounces-7036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711938BA91F
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C32839CA
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371A5914D;
	Fri,  3 May 2024 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wH8k20xP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E014A084
	for <linux-pci@vger.kernel.org>; Fri,  3 May 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725851; cv=none; b=liuKiUGEHUst7jaBf/x1+quaZPRWd14XjFSHpwj16Vin8/0Vmxs0e+w4NsmBVJ1pAQ1hl+rDFncyxmKwBHd45VPDCzaTE2q61LXbezOcZEobdJVveEMWeJF5Tnfc4PyLDW+EUdZODE6uCpFvP1KYyhv6ETcFbbFOtkNURx2d9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725851; c=relaxed/simple;
	bh=BKji8dql2Q7HB9ydxb8y51caf9/agXzCr0gG3HSWZek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJL9oNsPabVU9cHG6ewWC38OBGip13LaqYLDUAQanLQUyE+HuQTCeGTidNII44Dm+UET1RHwvHvLnvIWySdIR05P3g42Km0joNcJGZINGH6qrmkqAOcABjBg/Ja3iAhTEzIMaW+pIFa5r6hTJdwyjCIsAyPrq2XhLR3OmA2Xchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wH8k20xP; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso4973700276.3
        for <linux-pci@vger.kernel.org>; Fri, 03 May 2024 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725848; x=1715330648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKji8dql2Q7HB9ydxb8y51caf9/agXzCr0gG3HSWZek=;
        b=wH8k20xPMsXvOQCwI8eGiHhjiVmW2UZIu1AxM07J2NodowP28Zp2sjwW/eXbBK0CDx
         Yn/XEtfbliKqyS2iTVLT00NXn5n8UP8ReV1u7udr8a3hyhZnQZjNq3cj4souaR98lTAr
         NjWKDYX7kNso8RsRotwMA7ku7+M7QzCZX2ynHAn5fU5kEIxlyyGzTI7ORuQKsddI6ejG
         NfAVMmlH++6p5BOQ/MYCLE+yxfvFB34Rm7EVSF+LWMSRS0Fk6dj3PngDU93gP5DD2q/w
         Hc13IsJ9HB+8dnJ/zvXQgnVpoTqj5tX6WB07jYMhPGMYMsHj4SNzhVvtUMwM2+uuBSUF
         QSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725848; x=1715330648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKji8dql2Q7HB9ydxb8y51caf9/agXzCr0gG3HSWZek=;
        b=eCIX5pHmarIVXVsrGu2McZo2tla3icPcv2wgfbxHQnyOnqsDI/pbd4jh28NDGu/lLL
         4UBv5Aqw51xAQbQf4utcQhzTa0yKO5xCz3YfclE00D6oAi2dANEk3ElxywXQUk38g13l
         2pUaYloBlC9S2c70SkMY2C1GZmO4H8oyxlMU85gvzLpwEeSzCNvGFEKiYQOljAXvOvvl
         24D5rKbraOIOzmPnuFwljrHQz5mtKkDmPR1CcaqNMfG7fT3tc7vIZVA7EerDk9fOAnA2
         R33IZ425fgtBLCFFHtqcJFFK4l+abmoYTuMFUvvgBk+4P5gQe7su/Va3c9oeskTMoixT
         ma7g==
X-Gm-Message-State: AOJu0YxTFnHVuLVhN01VIrbQhvJZPslHkxZrINHbY5y3CKOqHw7g79IQ
	h5dnjB61RlvRaau6f+cUDo0ngufQojMD6fvhigQWwHxfTLS8TCm3mnCi7XBknK7tTkKBRHyrmgS
	CTpVedfaU7e4uVVLOSkU4q2CfWARhxfZSzEuW3w==
X-Google-Smtp-Source: AGHT+IGWfFGtExQ0NqT26L1KYSVbcOPkIAddlYuzm9qz4w3y6T+dxyxo9KKnqe667MkWqy0SdR4KIs+Wq8t4EpB4aMM=
X-Received: by 2002:a05:6902:2011:b0:dcf:2cfe:c82e with SMTP id
 dh17-20020a056902201100b00dcf2cfec82emr2421680ybb.55.1714725848634; Fri, 03
 May 2024 01:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-8-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240429104633.11060-8-ilpo.jarvinen@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:43:57 +0200
Message-ID: <CACRpkdagd3W1EkJTv70pGBf-=J+yuV+osisR2YjHKuT9Oo5Caw@mail.gmail.com>
Subject: Re: [PATCH 07/10] PCI: Replace PCI_CONF1{,_EXT}_ADDRESS() with the
 new helpers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:47=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:

> Replace the old PCI_CONF1{,_EXT}_ADDRESS() helpers used to calculate
> PCI Configuration Space Type 1 addresses with the new
> pci_conf1{,_ext}_offset() helpers that are more generic and more widely
> available.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

