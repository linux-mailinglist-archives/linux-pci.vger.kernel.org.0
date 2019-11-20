Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7CF10311F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 02:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfKTB1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 20:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfKTB1H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 20:27:07 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C1E22461;
        Wed, 20 Nov 2019 01:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574213225;
        bh=D7abHCeD4TPvV2CC5GlYUE+dpzX7mKsMT4oa0/yvIRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eOnkCcpi3XzYZrccf26EVRVyjaGrzkJM2FuzIDz2a6nLVVzbAKGJvodiPcmIUpL3n
         gvLbf/JklQkvF0ImVVa7jx4efmK2auYAzjeEnnvBU1Q65nizUJ4S0UKbhUJEeKDjdz
         rdCWWF+ApEM0lz17r/TTjMw7fMaTerpB/fD8csH0=
Received: by mail-lf1-f53.google.com with SMTP id d6so18745704lfc.0;
        Tue, 19 Nov 2019 17:27:05 -0800 (PST)
X-Gm-Message-State: APjAAAUKRq3XKE8QT0x5qE0h/21pDFj44fuQ8cctQ3kEraAAenqEU+lf
        Qkkok+3kqgbXLelxZfNoQpnxYjfrZaZRWbKP1bY=
X-Google-Smtp-Source: APXvYqwRCZuOLwwW4yV+7MFk/VIFl8MVP82eHlcf4qaQKdX30EKfsryD1YdVJwUyn/6jRxu7hGaF3j94H2BVMIxjCZE=
X-Received: by 2002:a19:da1a:: with SMTP id r26mr450883lfg.60.1574213223486;
 Tue, 19 Nov 2019 17:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20191119144315.11261-1-krzk@kernel.org> <CAL_Jsq+1hHneSW5DzLNxU00AqQJ49chTyULJ0S3JR-CqfOfTgA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+1hHneSW5DzLNxU00AqQJ49chTyULJ0S3JR-CqfOfTgA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 20 Nov 2019 09:26:51 +0800
X-Gmail-Original-Message-ID: <CAJKOXPep1ftnw0gGEtzmSZaZBaAiyDhCsVygRfNAQ4egiJK1tA@mail.gmail.com>
Message-ID: <CAJKOXPep1ftnw0gGEtzmSZaZBaAiyDhCsVygRfNAQ4egiJK1tA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: Fix path to power-domain.txt bindings
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        etnaviv@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Nov 2019 at 01:02, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 19, 2019 at 8:43 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > With split of power domain controller bindings to power-domain.yaml, the
> > consumer part was renamed to power-domain.txt.  Update the references in
> > other bindings.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: abb4805e343a ("dt-bindings: power: Convert Samsung Exynos Power Domain bindings to json-schema")
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/clock/clk-exynos-audss.txt  | 2 +-
> >  Documentation/devicetree/bindings/clock/exynos5433-clock.txt  | 2 +-
> >  .../devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt  | 2 +-
> >  .../devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 2 +-
> >  .../bindings/clock/renesas,rcar-gen2-cpg-clocks.txt           | 2 +-
> >  .../devicetree/bindings/clock/renesas,rz-cpg-clocks.txt       | 2 +-
> >  .../devicetree/bindings/display/etnaviv/etnaviv-drm.txt       | 2 +-
> >  Documentation/devicetree/bindings/display/msm/dpu.txt         | 2 +-
> >  Documentation/devicetree/bindings/display/msm/mdp5.txt        | 2 +-
> >  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml            | 2 +-
> >  Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt    | 2 +-
> >  .../devicetree/bindings/media/mediatek-jpeg-decoder.txt       | 2 +-
> >  Documentation/devicetree/bindings/media/mediatek-mdp.txt      | 2 +-
> >  Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt  | 2 +-
> >  Documentation/devicetree/bindings/pci/pci-keystone.txt        | 2 +-
> >  Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt | 2 +-
> >  Documentation/devicetree/bindings/power/qcom,rpmpd.txt        | 2 +-
> >  Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt | 2 +-
> >  .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++--
> >  19 files changed, 20 insertions(+), 20 deletions(-)
>
> Please no. Can you just undo the renaming back to power_domain.txt

The renaming was done to make it consistent with yaml and other
bindings but indeed it creates some churn... I'll send rename-undo
then.

Best regards,
Krzysztof
