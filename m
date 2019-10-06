Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F64CD2FF
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2019 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfJFPrm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Oct 2019 11:47:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55716 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFPrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Oct 2019 11:47:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id a6so10044625wma.5;
        Sun, 06 Oct 2019 08:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SBpRb6qd+48zQK5uPLn0YvEluIoUY9o3FhFhGA6TXtY=;
        b=Z37+ICp7Y2QDT49t+AdNnVTJVt76pPZFd6B69eHRoUoNZlsdtFkBCYnSdEyhWhNbuK
         XyETKrUDNSnLU0N40QS4exLwpNzCn3/7e6RprNKgM+Qgr2l5BRucGBLAeRfUBtKOQMJ/
         5E9krxQL8OOHlalnke9FA7tibZzAe6GFB/E4Tjd1T8SsglrBwPlPGPzr8Yl+7Mdbg35j
         IFXYmMzgkgcDjGXuUelcoGSjezWAQjoj/QavICNDeyyyRPhrYYOc89Nr353qflFxSsn4
         1BvgZwAEXST7N03PUH5ali/fZNJcdatPFLpTHv6qfPMQra3BvYtNieDoXbXlpO+z1NTI
         sjXw==
X-Gm-Message-State: APjAAAUxUmMz14TPUm0Zi7j50psy10b7VPGg5JHEvkXkDaeqENUPDqXP
        tPZ/Wxzu3jmyhFXsDcYOxAA=
X-Google-Smtp-Source: APXvYqwiD5w33vuIYv9624AWG0k3vsCYtE8uO59mkpTJi1G/TZQDv7OS1UJvxH3zuwZ0w6XxIwuUIQ==
X-Received: by 2002:a1c:9988:: with SMTP id b130mr18139392wme.164.1570376858781;
        Sun, 06 Oct 2019 08:47:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id o22sm31539882wra.96.2019.10.06.08.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 08:47:38 -0700 (PDT)
Date:   Sun, 6 Oct 2019 17:47:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: dts: exynos: Rename power domain nodes to
 "power-domain" in Exynos4
Message-ID: <20191006154734.GA29365@kozik-lap>
References: <20191002160632.11140-1-krzk@kernel.org>
 <20191002160632.11140-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002160632.11140-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 02, 2019 at 06:06:32PM +0200, Krzysztof Kozlowski wrote:
> The device node name should reflect generic class of a device so rename
> power domain nodes to "power-domain".  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4.dtsi    | 14 +++++++-------
>  arch/arm/boot/dts/exynos4210.dtsi |  2 +-
>  arch/arm/boot/dts/exynos4412.dtsi |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)

Applied.

Best regards,
Krzysztof
