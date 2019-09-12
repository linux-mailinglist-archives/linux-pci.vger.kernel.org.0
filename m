Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50326B0C31
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfILKDd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 06:03:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46558 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbfILKDd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 06:03:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id v11so28794033qto.13
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2019 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOWYB3DMPBdvSwiXyF/GUh8D7R8BU3JTpRh9eNB50ww=;
        b=iOQJK+F3Xh4PPUjpY0GaAGDZ7VttfqtZpUaqyZLYJsstBuH+U//r/47PYtwiMrUymC
         +RIu5KaGmOqoA1BXAMhf03gyhA8+cL0qYtzn5aJ0figtQFVRk8HuwsLfFLYYUh0eQ6UL
         1fbrbbltTdIxNoBM8syoEnHSUsXhYUYVwThNaIBMPtAVL3kWU8BCWOtARgjIygZZb6zp
         KINRjXD8yOkUAViAV3oWKxOc0i1Z25Ae+P0kSIFMVVi72gTD//ZHE7mKIdgs9G1Kuawi
         Ms+M9iHQC3FAnmSmbJUkBRkOFS6S3xbVTYvi5SAIOE8i3NUeQ/Be0soUMZ3ZzjaQVbSi
         E9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOWYB3DMPBdvSwiXyF/GUh8D7R8BU3JTpRh9eNB50ww=;
        b=eQ4NAR00s5GfUt/dadU7//w1RKAv0pYgFv7zcSAAWx1rfXqZZWA3VbHyp/mG+Of+Lc
         glkJrAaIdNjWvDWZp06fCAnCYGw9yXok5Iw454VnBZeIrSbLjqT6eszOZgGXxZFCEjYQ
         XaCAYu7/5WGmU6hxdQKDl+jz3oyjnWLs8Hf7OB41QcONP54141G7BtXWW09fhRCWb+Za
         BSsAwuOI6DPhyB/5f/2Ce4mWQgL7IwwgIIMNhg74MfGNF4A6X4q6S2SSiplAXEeuUC45
         vG5P5kG2imYzdxYKUkijT+38sCP/JgrRdYbYC4/gMgjuyA5EyORF1ZTajQz+9COEiZC2
         6YIQ==
X-Gm-Message-State: APjAAAVRnxoY/kO7Kx6EbJ0dSy9wqVddjxZNBxBLqXZYBSZnDi/2tRgI
        hS9T4BsUIX+5ceEZtHDjDftLIykdMHOdtWl0fCFDCg==
X-Google-Smtp-Source: APXvYqyYqFVBKfUcLfS+7Te1gAsm+iJfnRQxxrlLXOVJMqmgd4LMC/pVx2XfUktZHZPdRIqzoioVTHAClDoQFNDQUkA=
X-Received: by 2002:aed:2a3b:: with SMTP id c56mr41859375qtd.343.1568282611921;
 Thu, 12 Sep 2019 03:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568239378.git.amit.kucheria@linaro.org> <20190912094651.GH2036@sirena.org.uk>
In-Reply-To: <20190912094651.GH2036@sirena.org.uk>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Sep 2019 15:33:20 +0530
Message-ID: <CAP245DXBwwtcbjRQV_bCdYK5SZH9C9oxZJ2rFraJpbd5L0sHvw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Cleanup arm64 driver dependencies
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lists LAKML <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

On Thu, Sep 12, 2019 at 3:17 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 12, 2019 at 03:48:44AM +0530, Amit Kucheria wrote:
>
> > I was using initcall_debugging on a QCOM platform and ran across a bunch of
> > driver initcalls that are enabled even if their SoC support is disabled.
>
> What exactly is the problem you're trying to fix here?  For the
> drivers I looked at these were bog standard register the driver
> with the subsystem type initcalls on optional drivers so not
> doing anything particularly disruptive or anything like that.

I was trying to prune the defconfig only to drivers that make sense on
the SoC. e.g. Why should I see a brcmstb_soc_device_early_init() call
on a QCOM system when I've disabled ARCH_BRCMSTB?

I came across this while trying to figure out how to make thermal and
cpufreq frameworks initialise as early as possible.

> For any given system that's going to be an issue for the
> overwhelming majority of drivers on the tree, including those
> that aren't associated with any particular architecture.

Indeed. From a quick check, MFD and GPIO has a bunch of 'generic'
drivers that aren't SoC-specific. I'm sure there are several such
drivers in regulator framework too. They don't need to be 'fixed'.

I was just trying to ring-fence obvious SoC-specific drivers behind a
ARCH_FOO dependency since they seemed like low-hanging fruit. Let me
know if it isn't a good use of everyone's time.

Regards,
Amit
