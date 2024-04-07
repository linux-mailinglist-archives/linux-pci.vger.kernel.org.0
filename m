Return-Path: <linux-pci+bounces-5839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857B89B0CD
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB6D281D4D
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4332E24B2F;
	Sun,  7 Apr 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Dp8OAt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DC2375B;
	Sun,  7 Apr 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493550; cv=none; b=WMehHEjkVPNZafyCd4NO2KGJageqf/5A/qUEG6cnLR28afNdIBrUjunRQcBrCmY8MPyTOWcwt/pFNoeM47/DrRfY3KQQZ7cnzHnYqcMFwHRxz1EEfoWJ8b7Bm7HWMjdtRdJq1QfS4ZRn0CyLGpiz8SQKMTCfqbI566nqTrNSdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493550; c=relaxed/simple;
	bh=70uywmOjnhBrYkTEuZzo/N9wDcHw5Nb706IWaY5ySNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sp5qN9YPUSRPjhbIlOsjY0j/HR8iuGGrXjA0GXxnBIYiH2Lpn6ojMVHFWEc4uYs8CeWgRA3z3OjDVUeZa1q5Fb/rasOm3Hengsa+Mub+heeu934OX2CzUYu9CO9l2/UHt9EmF5ltxQzskokHKbAGku9sJkt/LzjUzRlvs2JuSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Dp8OAt; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a4b35ff84eso2355740eaf.2;
        Sun, 07 Apr 2024 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712493548; x=1713098348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YinWXQnk0eT7Z1wHOzuPSCSYvlwXIPlk1+iKh10Vls=;
        b=H0Dp8OAtGxyv5LEi0Iy7OwtS0lcGf7GwrjaY+NuNteVXcQblS+CdIzOA8g8dPZ++Tr
         Vn8JfHxlBiEiAiXZP28gM8h7E0QyEzdkO6d2MzkrG+OuYHDFYcny+zYJes6275AVXoxk
         lWdrtzcw0xfewnOADRXq3/yuXbH9n0AF4B/KjbENHlmrTYdk2WKqav3+Q/ZMybb3485B
         k7FeFPmQkJsyEyJ+85I9zhpvqX7QUjHQ81z9YU5/OtxTptcQh3NGxqUkPONJ11tp6Hbm
         BepU00IcWMT/MAa22KiaFj/UNFDJImJHx7eYsrPKi5fvos1jnUMlKMW6IwZcArDGmvoD
         aEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712493548; x=1713098348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YinWXQnk0eT7Z1wHOzuPSCSYvlwXIPlk1+iKh10Vls=;
        b=Ebjm0xu2otDYF+RfwlOTFgZp0zrKFnFffncyzCtxK11lr7kB03TzrBKIIKSrobkqJI
         d2SuPYKT9DF3NyoHfH2y0PYO38LzHEB6LEHBJHxsh/sbcUQoGKgbG2WhD7zu92BfvGEV
         6o7fumDQ648O/MpZIe1p3GRjmxvXFCeqgx6/auisKqWIVKr/UNE5YaW01hyVfQFoEDOU
         Usm87KIfkH7w+j6N3mPF+ocolyaagdT5VsiEUhEjwJ22BM2JqVSI3al5aB3mqOsMszfo
         0N8cNbvAHnzj7cs4MfaBaLUWRjBr1P09R7ZTFLuBA35PBPpravZJTb+FAWlAq7uJHSYo
         6tLA==
X-Forwarded-Encrypted: i=1; AJvYcCXRTK/0MUdW0iBCxW5UHAv7KH/OiDOZwj9Dp4PuhSOnw3uX+WYVIktUDezZ50X5hm5flyo6Ddy2NhXxLGzKkkDNsr1z0Srut+daMGpZe0ZsGwKkiUVlLPqwWrVeB7vLwXsCtS3Ma6CZJRUIYcDOt6Xm/dh4KjJ333Xg4qXu8IIsFDMwOMUwX8dWRbuk5efQqkc75nWel89ic0QepVtSgZ+Co9xe70eHACzQsdIKH5KsH4uA5079moLjPSyMmLSCRH63piOUYQ==
X-Gm-Message-State: AOJu0YxomWPlfgNNyXWSnaHqDrXe2WYAVicBugrhnZEIiSneVHqgjeu/
	0A62LbT79fJx6o3N1oGy/DLFKX+nx2DM5M8bTO5GY4I95JRdilIVkk+E1nhG0Eo3q6dd+XwXSdQ
	DXHJfcXtZf1pmu2W1gy1LZ2SJwWg=
X-Google-Smtp-Source: AGHT+IFvZ1UMHhMwBSNso145G9wXeopvnhz67bSYiVC6v0RYNhkx43Ef5CmXFgL9Iup+iSFrwPTE4vACd2zsBUdljvU=
X-Received: by 2002:a05:6870:fb8f:b0:22e:e1e5:b8e with SMTP id
 kv15-20020a056870fb8f00b0022ee1e50b8emr6777731oab.41.1712493547737; Sun, 07
 Apr 2024 05:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org> <20240407102000.37213-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240407102000.37213-3-krzysztof.kozlowski@linaro.org>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Sun, 7 Apr 2024 14:38:57 +0200
Message-ID: <CAMhs-H_gx0LB89QpLf-fJrumONRSnwB5_L7YkkWKC=7130EFLA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: host-bridges: switch from
 deprecated pci-bus.yaml
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
> dtschema package with core schemas deprecated pci-bus.yaml schema in
> favor of pci-host-bridge.yaml.  Update all bindings to use the latter
> one.
>
> The difference between pci-bus.yaml and pci-host-bridge.yaml is only in
> lack of "reg" property defined by the latter, which should not have any
> effect here, because all these bindings define the "reg".
>
> The change is therefore quite trivial, except mediatek,mt7621-pcie.yaml
> binding which have children nodes being also host bridges, apparently.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml         | 4 ++--

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

