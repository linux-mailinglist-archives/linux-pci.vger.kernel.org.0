Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004C21163F0
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2019 23:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLHWIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Dec 2019 17:08:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43689 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfLHWIJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2019 17:08:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id x14so4635240oic.10;
        Sun, 08 Dec 2019 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LcpecxJCuptWnky/wBInRHW7dBWZyoNDO8ejqGqya4=;
        b=JiUPaF+aLz6TU175q9IIuAWCfbj1Dp34A44ajwK6wWjJuU4qAW6BB4WFznxCnlrz+m
         11aV+yzG5hho4KnFOHqZ4MdNh0vO5men3cU1qp5cZ4yKlf8NYCo/WlL3zH/9Us1l56E2
         zaiUI5IFBXi84lF7T6fkfCSTwUxRB+6DMpcPrFgw+839cVtn7VvEd/tz1YJlMGKUMrFv
         cMVvpXHbsEhI+l1VNNoyP/3w2xVFStHfFJ1IDsQzMBaQj74boPcUBmJpW+MuWdDWAp4S
         z91RVykEF70X975kRocmzBBOXgC3eOuH0yxBwNCsUrxB0bkqd2TIjaIXJztFPi8M4KID
         6zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LcpecxJCuptWnky/wBInRHW7dBWZyoNDO8ejqGqya4=;
        b=RFKfF3+N3VgeXEAJWocg22vGGkANgCW6zk3A93KeUHfbeZ/OFd5ZUbH45i9Q0oNybe
         SM6A9TKT3/heLEn5KVBG6bu74Jw+HHe7KY3TaFP/AQUks97W3EeMWtWSlzLM0A8DI+xF
         GVSxDILmZAciC4J2vkMKcpv/OfEK6XBdlzRozZ0sQ8yOYasnyFq/F215R6cm6z890Lu6
         eG/5Tkj0qKBz5tfZS0vL5jPhaZY2ccA/aHRZVB4J7HkYQZ+8mCDynIU6fxgd8/oLzX+l
         q84o85GFm+R1mxAMiqpjsDkSRLtP5mBw19m4SNYPu4Imxb0m5HKSoA97u6J64CuwbC8y
         OMsA==
X-Gm-Message-State: APjAAAWMJoo2W9LAGWfV6bui17gBqhmP/zf2IKD07K2a0CaQPSOWJJyS
        VcjB+l4bRf+NdU8gUMLIiPRGklF6qLc+zl7mZQQ=
X-Google-Smtp-Source: APXvYqyhNhm0JNicy/loq8RdAT4DHahKdfAG1UNTU2pTEGoRTXZgPhgK9yLqIJ8epqm1nERlorhDJkru2+6iVkzYho0=
X-Received: by 2002:a54:401a:: with SMTP id x26mr21795889oie.15.1575842888488;
 Sun, 08 Dec 2019 14:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20191208210320.15539-1-repk@triplefau.lt> <20191208210320.15539-2-repk@triplefau.lt>
In-Reply-To: <20191208210320.15539-2-repk@triplefau.lt>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 8 Dec 2019 23:07:57 +0100
Message-ID: <CAFBinCA7Tnc2M=4jxYYS_RuoLnGNprUOFDrZG_G6fhQCyb3Cig@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: meson: axg: add pcie pll cml gating
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Remi,

On Sun, Dec 8, 2019 at 9:56 PM Remi Pommarel <repk@triplefau.lt> wrote:
[...]
> +static MESON_GATE(axg_pcie_pll_cml_enable, HHI_MIPI_CNTL0, 26);
we already have CLKID_PCIE_CML_EN0
do you know how this new one is related (in terms of clock hierarchy)
to the existing one?

[...]
> --- a/include/dt-bindings/clock/axg-clkc.h
> +++ b/include/dt-bindings/clock/axg-clkc.h
> @@ -72,5 +72,6 @@
>  #define CLKID_PCIE_CML_EN1                     80
>  #define CLKID_MIPI_ENABLE                      81
>  #define CLKID_GEN_CLK                          84
> +#define CLKID_PCIE_PLL_CML_ENABLE              91
this has to be a separate patch if you want the .dts patch to go into
the same cycle
the .dts change depends on this one. what we typically do is to apply
the dt-bindings patches to a separate clock branch, create an
immutable tag and then Kevin pulls that into his dt64 branch.
the clock controller changes go into a separate patch in the
clk-meson/drivers branch to avoid conflicts with other driver changes


Martin
