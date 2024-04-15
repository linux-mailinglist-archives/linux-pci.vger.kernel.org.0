Return-Path: <linux-pci+bounces-6232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB99A8A4911
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F870B227D2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BCD2374E;
	Mon, 15 Apr 2024 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSS59ZAS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC52D058;
	Mon, 15 Apr 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166318; cv=none; b=tWAVd7H/obtFNmK69vxyTOr6iWYBkqlYW5XcA20/QvpjxkUfQ25FT4SEIky+V399xLnKbMrsn6XQhNk8Q7uKh/IUdBJfvNVy2Ho1iEce2FDRILTFZomWb9R5N8NLKQnMYdhiAWmEXBzwxPqktsihWUcpYffTAhQfQ60OhG3P02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166318; c=relaxed/simple;
	bh=RiMMGXA23rt3N/5UddmduV4dDe775hQfb8LLkY3/0Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMeLb1lDL3vrfVx6RR98MJyqfhUyhr6HuJqbIm6BeiTxg7JodQ2b2G0Dmbdy6fSy6HGR2kC8nCaePEHRWCP49e3NHBA2N8OiqIs0QCitjc4LRceJClY/qlOFuQ8RUcF/3LW9iVNCT+9F8qmqDNdtuZcrwg+i80qSb8W00/5fp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSS59ZAS; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c709e5e4f9so1023751b6e.3;
        Mon, 15 Apr 2024 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713166316; x=1713771116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyAUoqBvIOKTY3LdJCpcnCDojqj4JBfKWFR06e36DaU=;
        b=RSS59ZASpatW3v7wMh06zmn8h4gzBMsbwcm5b33oqlx49NNgMRAeiKGFyNzJ1EEVdC
         TsPGMJ5qn/khdN+YtV7wgsuh3IfbSFeTm7IhOjJeMo7xb67mcUL0oOYZdElnCxbbZSKn
         cQUigmI/MUhqW8BkdQaBvovPKTZGfTI0q0ppiJElAlMoGgjCAO2GKl83uGmY/TBspAqO
         V7GSzKZW6B0453CEgBq6SX0GapaNrA8EoFswrqUAgFBiIXnbRxvP8Z3aaceGpF8RDQvS
         iZtstwj+lrg1w+qylCwZFnRpnBZdpIDadigxYnXJ1wYe4QTIQvf9LcNPX7eroZ5/C1h2
         A2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713166316; x=1713771116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyAUoqBvIOKTY3LdJCpcnCDojqj4JBfKWFR06e36DaU=;
        b=C8iibwI2GDAf3dwCe4styRCJ7+T7YU132Vfxud9JPqIoLt39OdvFEFYAlyRRZhF9MX
         69PUvy97oYVMz/vk1LRymsZ9diUmuCN1OH+GKFEMksW321HONMo6ma/tlvC2/1UcLZpH
         jFGSTlULr8wwyNjeTQI2Vf8djmRKNzzsgLGrqIRz9GYFquhPLeozZol2kY9Zy1/7/vHA
         eAyN6mt0UVglC7iEJOOfNa6Jz4NOuk4I9mhPKHqC1MNHY1VTmQtAbi0FFjSm1RxgV/me
         kmXNb6549wqEv29evJ5sZqlIPHDUqkY7IK2FJZ2ecLCiOzFAkzB+RCHL9KhOQ8hTCSkS
         5wLw==
X-Forwarded-Encrypted: i=1; AJvYcCWY8DXVAr/fchcRvV94G4Rx4uHZGU4tz6LNKCl0487rGxRYHqfp985wSn+jlxuEzMt4pxx06h+STB88UojUe3MUXZt329DDLyf+nyp/NjbXFzXtG1IB55ZuDDeAKwXkdprQ0SEbsnL+8FQi1tWyL7vA8ZXjUqKtnWhp7J1iY7cP8FGYrOzY5b2kMqe76Wq0b2k/OA054IiE/lmDUnLEKrrw7/pdGEGZwNhMrHhvQ8TKp0e4jpnFMqfV+ULbyxNAbBc9gGRNzw==
X-Gm-Message-State: AOJu0YzR5o/NBHxudyw4YGwh10QvTQel2OSzcsAKRzOay/UDoMVyjG+l
	jogPvC6RceRrvF7CauLR/CKBwy4c2WKrFiMlZLTg+KuBjquQmxDaf3L8MxAA0Gx/HM5Ck4Giyxq
	DT8ohRxSZCxbTI/hZghGxlS3rfB0=
X-Google-Smtp-Source: AGHT+IG+mHEf+9pMHePulndcOmqJAFoy+0e8uxd+TwOgPTDj/IhKU2JtlX/85TmoPDDzrhRzFX9Fs3nWYPxdgLlCL2I=
X-Received: by 2002:a05:6870:ac26:b0:233:b575:4b4a with SMTP id
 kw38-20020a056870ac2600b00233b5754b4amr10413015oab.36.1713166316068; Mon, 15
 Apr 2024 00:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413151617.35630-1-krzysztof.kozlowski@linaro.org> <20240413151617.35630-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240413151617.35630-4-krzysztof.kozlowski@linaro.org>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Mon, 15 Apr 2024 09:31:47 +0200
Message-ID: <CAMhs-H9ADfuDkFcD==7x+VaN2q92JV1gxuyrWvfNYK1psEnrQA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: PCI: mediatek,mt7621-pcie: switch
 from deprecated pci-bus.yaml
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Will Deacon <will@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
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

Hi Krzysztof,

On Sat, Apr 13, 2024 at 5:16=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> dtschema package with core schemas deprecated pci-bus.yaml schema in
> favor of individual schemas per host, device and pci-pci.
>
> Switch Mediatek MT7621 PCIe host bridge binding to this new schema.
>
> This requires dtschema package newer than v2024.02 to work fully.
> v2024.02 will partially work: with a warning.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Important: This depends on change recently merged to dtschema, however
> no release was yet made with mentioned change.
> Therefore this patch probably should wait a bit. Previous patches do not
> depend anyhow on future release, so they can be taken as is.

Does this mean that we should set DT_SCHEMA_MIN_VERSION to 2024.02 in
Documentation/devicetree/bindings/Makefile then before merging this
patch?

>
> Changes in v3:
> 1. None
>
> Changes in v2:
> 1. New patch
> 2. Split mediatek,mt7621-pcie to separate patch as it uses
>    pci-pci-bridge schema.
> ---
>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

