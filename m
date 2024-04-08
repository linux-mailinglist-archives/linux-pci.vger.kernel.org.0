Return-Path: <linux-pci+bounces-5859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E328489BA35
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B321C22590
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9792E3F9;
	Mon,  8 Apr 2024 08:27:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC03BBDB;
	Mon,  8 Apr 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564861; cv=none; b=ADbKMm3qJgmSxS+QWmffU5aVDd0rXUslpToVsiqCVYqp9aEJ5/86/QcrXN9D0MjNZUtRmuqBEbHRAM0vJM4IksoYNHCARmuKzILWy/o1hi+R/vk6eFBP9ZXK6LRSCdw0qdaRynOIulbqEaqJK4K3E00eOQk8telcbmJzgpYIVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564861; c=relaxed/simple;
	bh=u9L7qVa0ZjLHzku/GRWHHqefATdqWRrHJlXyyocla8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOoV4iXCFAbJlOwaS2Tjdpg1OjsKRnKmOVzzuVz6AwKUWzYmUJmLoY7QKbiaXfOMLHReLSBpNIlUp88rNpVYDouB39Qm0euw8QR7phXLcM865RMmZqlgG6xAjH7RJb0srkR5UZ4xzzMJRPtHOHtH0tRB2RzTW03MZb5infotxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so3110882a12.1;
        Mon, 08 Apr 2024 01:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564859; x=1713169659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mduMjCqjA7drDw2lEIoqwW5oGXEwTzrsNz9VmuPIKQw=;
        b=G4oD/tN7k00pbY/aLU1vmj7HekENQo8QrzOHUVfqTTkSm+GK5ldTIInhkv7+5Kg/h+
         JFsgxPPQ0JNSwvq8hEaXAMrEWNCJZKeVYbe7g00FUnAQ9ZN4nQt5cIqb2zpVX8ESh3Zx
         7gPvQhS2aE2s+FEVyqfYYUjR4aWSN+r/PTY1fhp+HKQyPlylKXA8k5JmgH8KponFxdjY
         29vg3OptFkNk9g9txkR+1JUNNqvaHHr3GxILXOZgGiBxOdL+lnzlQ0kiCNN1CoAjpm3x
         sNswmTlKPfHTc2fWPDucGdA1sJX3kM69oQrmPrLv9lbE6YttJD/GkY/R4XCO+kkomBpn
         WjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6NJYwtnB03uxgJuzEOS4pgknqwRKaCHlEqsgJTx4qSvIM6e4Yao2e1Y0L3PQ4HWLwfb6opGTQbb1w9wDUoZ/GSZxaC55l9GTd2uNDklgI1qNq7aWR4Z2iwRxHixVq89F77Hl2SXXSxfMxemXyhCCLk4vDhhPIkr7i+jUrqO+0QMUXa/HZI6qZ+jlhL589auBdPJkxZ/RiI5fA200uutolqCK17sh+JLRQL7v0ZBVuDVGEUkbWFDJlyy9JrexBdXrBF/wKdQ==
X-Gm-Message-State: AOJu0YzqrVUtIuNCbvcvGbGcT+qrBrHW/Rx72RJv0nBWREg+d1sTFCWA
	JqQQcjgykj0NILhb2GnbMdofTrSoJdr2Yv3dPKwmyPlEhZyPVht3Di/ZrEpc7es=
X-Google-Smtp-Source: AGHT+IGJ7rgElWb5tKJ3j015626NGsXJVnXE5arFslRsaZzIOOWwKBgE3ge5TOwfbMt/xI4zlwZA+w==
X-Received: by 2002:a17:90b:4b4b:b0:2a2:cd61:c3f5 with SMTP id mi11-20020a17090b4b4b00b002a2cd61c3f5mr6874061pjb.37.1712564858823;
        Mon, 08 Apr 2024 01:27:38 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com. [209.85.210.182])
        by smtp.gmail.com with ESMTPSA id ft4-20020a17090b0f8400b002a54c4dd0f2sm226774pjb.43.2024.04.08.01.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 01:27:38 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecf3943040so2596615b3a.0;
        Mon, 08 Apr 2024 01:27:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+dQMpX+7YAU7PBBS5ccV34mj6qNRn0ffOJOpVXs6NW7aBqj9UYYwmhkEJEUJ7M4vpY0eMoIDMP0/AGpGnrU+rda3VFGUtFU2zeTkNkMUKl6taW42f5aXOEYTZkXrDyk7v1aSgWjGlcJvK0glDBvgWWSky+/pr1IYeSqp97IgNi0rKhs1TBuEPcvgj6hxn8D8GEPNtH6XJlpSU+3OwXCTOl/PvhVl8MYd4DWktiPihO2dXMOrk/CUBGpelyiSP8IAxTKrEgA==
X-Received: by 2002:a25:7406:0:b0:de0:e7f2:a03d with SMTP id
 p6-20020a257406000000b00de0e7f2a03dmr2539436ybc.3.1712564836998; Mon, 08 Apr
 2024 01:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org> <20240407102000.37213-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240407102000.37213-3-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Apr 2024 10:27:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjWLdu9c7=OhFLsY+jSZXspb6jPHxVai2GcbJoS7MDLg@mail.gmail.com>
Message-ID: <CAMuHMdWjWLdu9c7=OhFLsY+jSZXspb6jPHxVai2GcbJoS7MDLg@mail.gmail.com>
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
	Jianjun Wang <jianjun.wang@mediatek.com>, 
	Sergio Paracuellos <sergio.paracuellos@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
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

>  Documentation/devicetree/bindings/pci/rcar-pci-host.yaml      | 2 +-
>  .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml        | 2 +-

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

