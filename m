Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB43B0B68
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfILJ3T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 05:29:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45398 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfILJ3T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 05:29:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so23703484qkb.12;
        Thu, 12 Sep 2019 02:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtGU4iMWfZeQ/FsklpEfRM6iPwzDv+XphhtaUmBwgSA=;
        b=conIQTsvjKBscv9fPglL4IoNMHeXhdGelKfEyP7V9Py/OHbTW5L9vi2l0Ni8MrtZUV
         HtrIW3c0wamh53QqfI9RO3brCirVF1CL7PVohPSouQUKqIS60Q5bGPR1iB+4g+qgT+hN
         HsIDARICv8BcBTWQUq4YJ1zXpz0kyHL7OdfsNLHWqIksyMyPmB19PvfO6FZ+2CYEslAW
         XiSsLeJcZlU3Q0PjsPL5a4IWg1UXrWEHVi3tj4q95Ndp+pH6GpHBumlpNNQCH7i0BBYV
         MBCO9pTo4xyckqNBvwmsazMqcJ6CLTphCvwfRzHTJhNbBBnObWsnYvFPiuWB4SPyvlUq
         HC8w==
X-Gm-Message-State: APjAAAXj4nAr6INGJ8T7rhe6Q5nFDSO/1yr9vTLs+exJUy9ekP/qF4uS
        GiRpQglJ3eHUYmu1rhsaejh0YgNDREd9/T9CJAk=
X-Google-Smtp-Source: APXvYqycQWX7fEy2jA5D+LxaO4u4opsppoZ4/cfOD3zMYVxe++YCYyGMd3QpWn3hGnNZZJlZplYFA331lIror8ITmVA=
X-Received: by 2002:a05:620a:145a:: with SMTP id i26mr40226931qkl.352.1568280556796;
 Thu, 12 Sep 2019 02:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Sep 2019 11:29:00 +0200
Message-ID: <CAK8P3a2zGJx7SCA4LUHPGTybN8GU16Ah3H0FbaOEwR3H7uGCnA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Cleanup arm64 driver dependencies
To:     Amit Kucheria <amit.kucheria@linaro.org>
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

On Thu, Sep 12, 2019 at 12:18 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> I was using initcall_debugging on a QCOM platform and ran across a bunch of
> driver initcalls that are enabled even if their SoC support is disabled.
>
> Here are some fixups for a subset of them.

The idea seems reasonable, disabling a platform may just turn off
all the drivers that are not useful elsewhere, but there are mistakes
in a lot of your changes, so I'm certainly not applying these for 5.4.

Generally speaking, the way that works best is

config SUBSYS_DRIVER_FOO
       tristate "SUBSYS support for FOO platform"
       depends on ARCH_FOO || COMPILE_TEST
       depends on SUBSYS
       default "m" if ARCH_FOO

This means it's enabled as a loadable module by default (use
default "y" instead where necessary) as long as the platform
is enabled, but an x86 allmodconfig build also includes it
because of COMPILE_TEST, while any configuration without
ARCH_FOO that is not compile-testing cannot enable it.

       Arnd
