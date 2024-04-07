Return-Path: <linux-pci+bounces-5838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D660889B0C6
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582F91F2172B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F3823772;
	Sun,  7 Apr 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAW8MwwQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55717999;
	Sun,  7 Apr 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493382; cv=none; b=AcIc31k1ZXpIOK3n+Nw5dTF5+rdz4lvKF3s4m2EF8wC7Zd6m9UVqKVxoDG7DzjXX2Gy1//kn+yOFtMM05CSp5XD73OTHoLSkjRlsFsSkz1RcYGUat9PhOefvZ1OnJ+ABN9MZTfMLHhok3wFVlLo7vFdrGUFIUFwHSUXbIlCh6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493382; c=relaxed/simple;
	bh=VhtheWqyCFUO49/ez9JKbY6OihTjwk/bQeNzjLVwE5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKWwcSFCyVMdAloaO8bXBlFv6XKi2OEaE7PFmYiP3gUOgZGDKkYjaAa4jbsFlhcrJhrqsRuK92e3OeWIwcP7vhDTc5b47rI2tYnJXZphI8QhSqkn9X5goNoIMQWsmZaJfnaB6JCl31BhFyj3x7qqVvvgoBtw7gYeIwFKHPBGNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAW8MwwQ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22963f0e12cso1965141fac.1;
        Sun, 07 Apr 2024 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712493380; x=1713098180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTpah3z9nxK4+QUIUhM/zsRbPjioxiMre0R2YErPMBI=;
        b=mAW8MwwQF4Cppw7sPkIDH2UWhumaRBaYtRAKrnKQkgIhNjYITfNEgvALQCJh9uKtzf
         E/gOAMTi5d10RPy6LMT0GayeIbSqDle0fOiPVO+3zuPv9mXqlm+nRO9R1MXZuMbspCCZ
         oQbvOLo/GDWOb4PZ+QgNFLkAfkreEcSHbanyN+IEBcwhdtsxgYg9hug9N3D8i2X83RMl
         rtASvYLRORe2Gw6tz65zNPkRJkwDQMmG+0hkfuw7QlLxGhJLOgzAY4q1hDJc4uBYRHdD
         g5uufeYavrLOF1rBush3a0xE078loalDyPZ15s1Huip0kSlI0PcbTAC4JnRyi93KXFYU
         Nw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712493380; x=1713098180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTpah3z9nxK4+QUIUhM/zsRbPjioxiMre0R2YErPMBI=;
        b=fQrQ43p+68VcOxQiwv4BCfTqcY4vBNGh2K5xMv32JayWV4XlcVO7F5P85wpa2xedYa
         Nh/pnJIRLhaevNE9PTCPBwT1Z0XGD+VC5W/xIPh7hio14KuDpJMEnG/hFBo5j2B1nbI2
         3biHoOoFvR3RPQahbgOxjij8bwmgTJrDCADI/i3ouoAvrsmKuJvcxncp0S4QiENZP8Og
         JK385pLSjq6ggS3VO+u1B2pF5tOn6pDljQQWnpkHPrIuM58VXZngJcf46RTY8iYm4FeF
         xNiJehduwxwEa1Gi2tgRyTRcqf+sWwl0jzTh9KO7DJUCVysb/x5zbq5EA2+VZgGqBA7Z
         13gw==
X-Forwarded-Encrypted: i=1; AJvYcCVATKiOVDej0tNk7VWyEk6fYH2iPbHHG9jngl/vOqJWuh/FZCtpP3mqfKwoWIodEpk35BTIoCGs92Qkn8c1eIw19Ux3BbetN8pCG37x5KF5InG+dPQv3PU+geSBiVxBEX6IvjRIveFeZsy4f/K/JJX6tnWTIny7vjAor3AsB/sklbn1buMID+xtn0dXNxfVcnDrdunEy2CfJz4vUoFrzxfzFdX1fCI9ln+HEIjn23NQ4OoeEocRVUOwh+0F8Zqm8GKvU48zSg==
X-Gm-Message-State: AOJu0YxQ31x8+7bSQdLP1c0g7tJ2aqEOCkffA16a5hJqFgktuX7sUeJy
	zYpFoGt8wxx06SeycGM8ynpD+u5EkpZWOfjdV3P7PrkAO5rHQn314LvOJUBHvxOZoTEg+rbFVwR
	I46mUevIHk1rrEWI4DQXQA1vcQ0w=
X-Google-Smtp-Source: AGHT+IHCRJwJiztaVGgYDsbvhsWKurdYA7ka/A/XrCbAAgdQQF3HjScy5xiyJE6CEank6R3QWX9EeoxlvmFNctyZZ+w=
X-Received: by 2002:a05:6870:d622:b0:229:f9fa:df52 with SMTP id
 a34-20020a056870d62200b00229f9fadf52mr7031792oaq.12.1712493380515; Sun, 07
 Apr 2024 05:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org> <20240407102000.37213-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240407102000.37213-2-krzysztof.kozlowski@linaro.org>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Sun, 7 Apr 2024 14:36:10 +0200
Message-ID: <CAMhs-H8jjPpoFfUngpCckAq+hix65VN4rNWMJb=Rrtkzq6nEKA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: PCI: mediatek,mt7621: add missing child
 node reg
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Will Deacon <will@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Srikanth Thokala <srikanth.thokala@intel.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Tom Joseph <tjoseph@cadence.com>, Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 12:20=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> MT7621 PCI host bridge has children which apparently are also PCI host
> bridges, at least that's what the binding suggest.  The children have
> "reg" property, but do not explicitly define it.  Instead they rely on
> pci-bus.yaml schema, but that one has "reg" without any constraints.
>
> Define the "reg" for the children, so the binding will be more specific
> and later will allow dropping reference to deprecated pci-bus.yaml
> schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml          | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

