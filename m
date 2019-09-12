Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5909B0BD6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfILJra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 05:47:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41520 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILJra (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 05:47:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id p10so5822689qkg.8
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2019 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njDtF8upkA6+NaauiLZUsAxJubAF9fG83zymry8vAaU=;
        b=hWMSgmlLtCEWRX/MHXkshsdVSzIZAXdwroHnFWd1J+Pi/zDbGAZcyCfZPRTWouMTs3
         HjdnM7SbArudL+LwJw9WXwtNhkxNJ3vPlJTBXwcwK+HnfsDPaTouep35wtRSaBTUpjrI
         9emk8DOaWZePVDjguyhCt/ZL5d6Jbv6RqoCnfcdaExjJj3B1O2Clo5CXX+ScgLcmxCOf
         9/ugnWmvMifS7Z+DvKaoS9sgQ0er8SxLA0lyfPk5VTk9hpa5RR1ZuoDNDMMCWrBadl7y
         3s3xpnuk7FYIRnmUpF5Mf7/DQ3YY1oZ0lqDWccoUZ59bcKSlG6yXZueBxl49+QYWgfcz
         G4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njDtF8upkA6+NaauiLZUsAxJubAF9fG83zymry8vAaU=;
        b=HX/GZbQmP+f/cFVkYYOJPAiMeQU7UcbRhOuwLPpwh5EVx8/9Fk713i2JobWr1w4DJI
         Is793Id+sCbq23jweIVg8zcPgDuEPdWztV/4uP0/hli95R8wr98kp7nYc+7muBnzqIRa
         EdULvYtUwK8t132A8xhCDPirRWAXC2FpRs+2oo3RRnLDPbMJk9Uc3zR0Zy4XVzLBb9aR
         TBv6vk+kKSZMQf29dXsYYXibwZptk9obzRc7l7kKjRfLmP6M8e94rbfvu27HCXpe9RCv
         Ad6PS/E+7Le9HRtcftLLTxvkXUbGh1TMVUNisXNhHuM6qVuK76UZXcRMLNEI1NdymlXK
         Vh1g==
X-Gm-Message-State: APjAAAWJN56XE6WOSUjQ7t4c5waruasy9IIY4iclX58dcQyN+3/mkT36
        GeNHnRA2HzoAXEL5g69Cj6H88pF/nc6TLkCib7uGXg==
X-Google-Smtp-Source: APXvYqz/1oDNL1ZZfCatdlik6ssSKqxLf+19ecAGHXvhEDBbY9mBKtVG6u/Wq02n39I2GGkc6GmOYewOwwhK8D9OZR8=
X-Received: by 2002:a37:6d2:: with SMTP id 201mr39608673qkg.106.1568281649476;
 Thu, 12 Sep 2019 02:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568239378.git.amit.kucheria@linaro.org> <CAK8P3a2zGJx7SCA4LUHPGTybN8GU16Ah3H0FbaOEwR3H7uGCnA@mail.gmail.com>
In-Reply-To: <CAK8P3a2zGJx7SCA4LUHPGTybN8GU16Ah3H0FbaOEwR3H7uGCnA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Sep 2019 15:17:18 +0530
Message-ID: <CAP245DVab2Zw8XPCvCc4kCrq7RCSRh0K8wN=AmLdLMVJQcTmSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Cleanup arm64 driver dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On Thu, Sep 12, 2019 at 2:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 12, 2019 at 12:18 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > I was using initcall_debugging on a QCOM platform and ran across a bunch of
> > driver initcalls that are enabled even if their SoC support is disabled.
> >
> > Here are some fixups for a subset of them.
>
> The idea seems reasonable, disabling a platform may just turn off
> all the drivers that are not useful elsewhere, but there are mistakes
> in a lot of your changes, so I'm certainly not applying these for 5.4.

OK, thanks for confirming that you have no objections to such changes, per-se.

I'll spend some more time ensuring COMPILE_TEST coverage for these
cleanups. I only focused on quickly cleaning up my initcall_debug
output for now.

> Generally speaking, the way that works best is
>
> config SUBSYS_DRIVER_FOO
>        tristate "SUBSYS support for FOO platform"
>        depends on ARCH_FOO || COMPILE_TEST
>        depends on SUBSYS
>        default "m" if ARCH_FOO
>
> This means it's enabled as a loadable module by default (use
> default "y" instead where necessary) as long as the platform
> is enabled, but an x86 allmodconfig build also includes it
> because of COMPILE_TEST, while any configuration without
> ARCH_FOO that is not compile-testing cannot enable it.

How would you like to handle defconfigs which list a driver
explicitly? Should we add ARCH_FOO to those defconfigs or remove
DRIVER_FOO from them?

Regards,
Amit
