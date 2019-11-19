Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37C1028CB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 17:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfKSQA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 11:00:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46179 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKSQA0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2019 11:00:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id n14so19350085oie.13;
        Tue, 19 Nov 2019 08:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOp09REXBJlIhxRQLG3yF3pkOzVMqVXKGYr5zOkYKTU=;
        b=tvirj1n2/8raLM1mnIsqp2gtwTG5uKIyP1xLwQY0vY3qjRyRnMTQn215elCAXasSfy
         WSyp8Uwl85PcYNgWjZwZCCdkqTskSJ7Rg1xm3satC2WKj3DCWtIcVjDP0SHl9JfadCE7
         iQzb2KSMDGkLqXoZ4QACKQLtKY3Q7Mxtk0GCW53GI6ZE3T4ApWiG6V6gSuFNhNyUc/Zb
         0a/IjQe5z6lDgHz8T0LrFt3P57rYJKyytp5fk+au0tF9Mz2CIDBpgZN0BPu/OZv7iZxX
         Rt8K5H761gL0OeumSjzBiNg5XjPK7ROO/j9j68puMeduawUwkVi0Ii3t4994/lK3JRSY
         QfEg==
X-Gm-Message-State: APjAAAU8JKYPSL1ZgPixnZpQwmt6hecZN3aEXOBQkZEKuEurNgWD71f2
        JpBl0Ntpex8oGGzdJhPHeyLiWU3wsUy5mfxGH/g=
X-Google-Smtp-Source: APXvYqyFjVcr3DV/kDkPHFaPjGoNOAPUlx3qgBTMVdhzS/Ov2hib4acxOvn1dSc2R4bN1wN/M0QqvauTflblBxgZCm8=
X-Received: by 2002:aca:fc92:: with SMTP id a140mr4573964oii.153.1574179223502;
 Tue, 19 Nov 2019 08:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20191119144315.11261-1-krzk@kernel.org>
In-Reply-To: <20191119144315.11261-1-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Nov 2019 17:00:05 +0100
Message-ID: <CAMuHMdUnn8uYyQ+D=6rp1+R1sE_W-SS1t+EuNHm=vWaKQ9Z6tQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: Fix path to power-domain.txt bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        etnaviv@lists.freedesktop.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On Tue, Nov 19, 2019 at 3:43 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> With split of power domain controller bindings to power-domain.yaml, the
> consumer part was renamed to power-domain.txt.  Update the references in
> other bindings.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: abb4805e343a ("dt-bindings: power: Convert Samsung Exynos Power Domain bindings to json-schema")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

>  .../bindings/clock/renesas,rcar-gen2-cpg-clocks.txt           | 2 +-

Please note this file is no longer present in next.
But robh/for-next still has it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
