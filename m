Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C938D4F1
	for <lists+linux-pci@lfdr.de>; Sat, 22 May 2021 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEVJxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 May 2021 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEVJxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 May 2021 05:53:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C6C061574
        for <linux-pci@vger.kernel.org>; Sat, 22 May 2021 02:51:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so31963853lfr.6
        for <linux-pci@vger.kernel.org>; Sat, 22 May 2021 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Om/I1sVk1q3S0lDclruJw2xquLaj7Ph8H8jWODqmq90=;
        b=NihEhfB1HbjdxrO7OBIkOQPFNcPS15ycgWEHqw6mwpfg5lBUSutPmjk4iNYvU7hO56
         7PQ2Ig2c00z9gWxW5AcLBEGYrgRUklqtsdzFTgDsEqYyCqEOxeuxWnov5uLj6A/6ogK1
         xw3n7J4kd/QLLNV952Jw3rVDI4CL3AU/7zb1pHubNnLp4XYHXyedM/3NzUWb2+hGg4Yv
         nNC24XFFKflKotg/lc+90wU+exGnUf5MWKZZyy+0JDcvKCD9WaA06lD7lMCv6xUp7R2V
         tUADgu9tAuTtIHi/VC+bJDvcPE2GOHKWGTaVfZM+JLYVhM+3MynB4kktNUpUk11ltOGM
         lubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Om/I1sVk1q3S0lDclruJw2xquLaj7Ph8H8jWODqmq90=;
        b=fI3bJgzltNUiOtugXDhR6tIEvXlnwQeqYRl3TrPeJ1nQYNbVVB1UdXtGljEuDvdzv8
         GB0WYVctEwSSi+/tlB5hjO7H7a3N+959Im45/bNL4z6Rfb/0CpBes023XLxVyKxixTLP
         cO9HLMw6oP3WyDv+D6mmN1tpxFWb7lrAamyF6nZzcPk6ygC9P8hkjkfCW3g5gpv8hLK3
         F67eCL8zHgxuHVHJos8eeDlp1vNdXiMuEif6dfh90ilM57UMW/ue1Upv7Ohbtv/9JtRQ
         bJjLewF+030ikbPUaUqQI9oCKgYVKCrrOHUJyrXfS1xnGbtiLLJBW1Kg9vL/EGnsJ5z2
         mHjA==
X-Gm-Message-State: AOAM5309ARjbBYxoOprNbOTnEyxr6BrQsRnWJld3N28iFqfJdG2hvorf
        dNH0454aew2yTFffpFeVhemKI0KZzwkrx/gpXO1xPw==
X-Google-Smtp-Source: ABdhPJzrHIPNsKG/fgPwvoFPQL4Sz/uqW13yfiIBe261bdsfM6/6hS7dOECg18YTgCUDnKPHCxyIRJRmtNCwoJdIkpM=
X-Received: by 2002:ac2:5145:: with SMTP id q5mr5070586lfd.529.1621677113471;
 Sat, 22 May 2021 02:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210509222055.341945-1-linus.walleij@linaro.org> <20210509222055.341945-5-linus.walleij@linaro.org>
In-Reply-To: <20210509222055.341945-5-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 11:51:42 +0200
Message-ID: <CACRpkdaC1XG1sFQK8L2DrHA2KD-BDZihWJfz+GpgH2H8_-FJoA@mail.gmail.com>
Subject: Re: [PATCH 4/4 v3] PCI: ixp4xx: Add a new driver for IXP4xx
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 12:21 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds a new PCI controller driver for the Intel IXP4xx
> (IX425, IXP435 etc), based on the XScale microarchitecture.

Bjorn, how do you feel about this driver? I want to get it into
ARM SoC along with the other refactorings soon, so if it needs
rewrites it'd be great to know. (Or to get an ACK.)

I changed one thing since v3:

> +#ifdef __ARMEB__
> +       val |= (IXP4XX_PCI_CSR_PDS | IXP4XX_PCI_CSR_ADS);
> +#endif

This now looks like this:

+       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+               val |= (IXP4XX_PCI_CSR_PDS | IXP4XX_PCI_CSR_ADS);

Yours,
Linus Walleij
