Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37190102A6E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 18:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfKSRC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 12:02:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfKSRC3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 12:02:29 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522C222384;
        Tue, 19 Nov 2019 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574182943;
        bh=9xlP6l6zc8LrRTuryqi4QOF5/Hg74NZf0SPlZK2mEU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hHdDFqFWJkwOuMKZk0NzaOxgeAE6UqGlvZAVH+WTtjEaZ3CCkLs6cDI5yFhIl9SRE
         54T4E31B4t+satNSKMSJ+416Ec7m0NKdD49RPHEpukOMZs6k0mxIRc9AHYb5zIBbTG
         bNPOVvg5RSncACs08sPyTJmxe1NXOpvf8io01pqY=
Received: by mail-qk1-f179.google.com with SMTP id z16so18462574qkg.7;
        Tue, 19 Nov 2019 09:02:23 -0800 (PST)
X-Gm-Message-State: APjAAAWDgqNzuLMJs8sFoNhCpmKJ/NCyiGWxa3+rUuO7R+v5e5LWatrG
        AnMysVzyQOrrnIp3ZSRcxGlXeEucbJgpgLW1ZA==
X-Google-Smtp-Source: APXvYqxucfdWSXPgW2vd8l9633HeMvIH864eMJ/p+Bk0FhDvh444Pum/yEC+Gs6buUxeu7x2jucgvrCcmOz57phmAkg=
X-Received: by 2002:a05:620a:205d:: with SMTP id d29mr30290391qka.152.1574182942398;
 Tue, 19 Nov 2019 09:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20191119144315.11261-1-krzk@kernel.org>
In-Reply-To: <20191119144315.11261-1-krzk@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Nov 2019 11:02:11 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1hHneSW5DzLNxU00AqQJ49chTyULJ0S3JR-CqfOfTgA@mail.gmail.com>
Message-ID: <CAL_Jsq+1hHneSW5DzLNxU00AqQJ49chTyULJ0S3JR-CqfOfTgA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: Fix path to power-domain.txt bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

On Tue, Nov 19, 2019 at 8:43 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> With split of power domain controller bindings to power-domain.yaml, the
> consumer part was renamed to power-domain.txt.  Update the references in
> other bindings.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: abb4805e343a ("dt-bindings: power: Convert Samsung Exynos Power Domain bindings to json-schema")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/clk-exynos-audss.txt  | 2 +-
>  Documentation/devicetree/bindings/clock/exynos5433-clock.txt  | 2 +-
>  .../devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt  | 2 +-
>  .../devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 2 +-
>  .../bindings/clock/renesas,rcar-gen2-cpg-clocks.txt           | 2 +-
>  .../devicetree/bindings/clock/renesas,rz-cpg-clocks.txt       | 2 +-
>  .../devicetree/bindings/display/etnaviv/etnaviv-drm.txt       | 2 +-
>  Documentation/devicetree/bindings/display/msm/dpu.txt         | 2 +-
>  Documentation/devicetree/bindings/display/msm/mdp5.txt        | 2 +-
>  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml            | 2 +-
>  Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt    | 2 +-
>  .../devicetree/bindings/media/mediatek-jpeg-decoder.txt       | 2 +-
>  Documentation/devicetree/bindings/media/mediatek-mdp.txt      | 2 +-
>  Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt  | 2 +-
>  Documentation/devicetree/bindings/pci/pci-keystone.txt        | 2 +-
>  Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt | 2 +-
>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt        | 2 +-
>  Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt | 2 +-
>  .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++--
>  19 files changed, 20 insertions(+), 20 deletions(-)

Please no. Can you just undo the renaming back to power_domain.txt

Rob
