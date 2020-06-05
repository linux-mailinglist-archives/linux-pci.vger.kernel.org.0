Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4F1EF51E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFEKNh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgFEKNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2020 06:13:37 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE65C08C5C2
        for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2020 03:13:36 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv17so4369953qvb.13
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2020 03:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kr1JN+TH7Urs24hNJJNmKRJutOEkby8+/R/7dSIUOhw=;
        b=lh0QXYFb7xG25Uk7dHuFKvyGcg5gMlqONXEIaW2e0MxVOjg/8jMAUN+oSWodCl3VN7
         pqV0fs0ur1TtYQARI7xzaQERgGbUP3obbscqqxqDjie2jgsxqoFCLc2MmrEFKI8C0ZLS
         g2Dv4om99HSPjZUZIoC1RDS7WZmIpWWfZfZI7pAB4zmmkdih866YGmuNvVCPVDtK6XmW
         zgIC7UQPpg86NkUu6ihS+tXO/Yjs3eIi6Dba92KM56D8PXNcLcOrs28FFERzMW4q3PRu
         JtnJe1CliTNnXElhLu/Mo8pyDQ0cwxpxbR3DsKQxXepdefyJ+ajccLtLaG4ZNqU+AW3k
         xQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kr1JN+TH7Urs24hNJJNmKRJutOEkby8+/R/7dSIUOhw=;
        b=gKbGKjZuXrWKvaQqAfRKR4wjeOQlWtOjXbBaf5YaCtDu0VEOmEyze3jXo2DW6TmV/P
         BB23PKJA0jg/LXh3W9pMKhSL9SK1TTFJp8vtLv41hZ2zHF/uRjqXG0bEOZa0fqgX+N1D
         jqS4amb5kimY+mMIUF5r838LHNt8vflM8CgkqduVus1J92meB0H4G4syVyb/xYxh0hfT
         ycxONaWSBR8mzKG9yF9bOu/lyr4T5XLK+HV9V47zGa8LuXZF/rWXS/FfHOciggU4kQem
         p67ns7DIDVB1vzgJeH1R010KvcVKlNzf4w4OwMhKZ+EPPmbVWEKZC/bOfyAmOZf0kR5x
         dkLg==
X-Gm-Message-State: AOAM531N6dAZx6SStIy9uJbnZ2ANPPssDt9YFaceRC4/e5ltuAc+0L2b
        DUpGyLN6DC6DZHlhFDgezdPEVm/8nU8Ovlnln1bFwg==
X-Google-Smtp-Source: ABdhPJzm8HG3M6WTMQOrJHazy7H0iVOZBUpaPCcEyaWl+9AsyOE8s4RugnfVJeEtkN9BA4F1BaEeEyRXtGVkr9ePDk0=
X-Received: by 2002:ad4:55b4:: with SMTP id f20mr8785464qvx.148.1591352015116;
 Fri, 05 Jun 2020 03:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpxmJX8U-uNYJPQxmkox=YTSvXVPrWss2y5MS81_bg43Co8Lg@mail.gmail.com>
 <20200604175515.GA1076951@bjorn-Precision-5520> <CAMRc=McWFpFAC3ziWdOEYkc0YwkN-Jqf7vZpxbCBLPoe=oewdg@mail.gmail.com>
 <a12daf08b056431394272f52174aaa71@asmedia.com.tw>
In-Reply-To: <a12daf08b056431394272f52174aaa71@asmedia.com.tw>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 5 Jun 2020 12:13:24 +0200
Message-ID: <CAMpxmJWG62W3my9iaRN=LTFaJtkEXQVX=4ye-PPPwrH5PB2QDA@mail.gmail.com>
Subject: Re: [PATCH] gpio:asm28xx-18xx: new driver
To:     =?UTF-8?B?UmljaGFyZCBIc3Uo6Kix6IKy5b2wKQ==?= 
        <Richard_Hsu@asmedia.com.tw>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Richard Hsu <saraon640529@gmail.com>,
        =?UTF-8?B?WWQgVHNlbmco5pu+6KOV6YGUKQ==?= <Yd_Tseng@asmedia.com.tw>,
        =?UTF-8?B?SmVzc2UxIENoYW5nKOW8teWci+WZqCk=?= 
        <Jesse1_Chang@asmedia.com.tw>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        kbuild test robot <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pt., 5 cze 2020 o 12:02 Richard Hsu(=E8=A8=B1=E8=82=B2=E5=BD=B0) <Richard_H=
su@asmedia.com.tw>
napisa=C5=82(a):
>
> Hi Bjorn Helgass,
>     Thanks for your detailed explanation.

Richard, please format your e-mails correctly for the mailing list. I
already directed you to the documentation on patch submission in the
linux kernel source. Also: don't top-post.

> Hi Bartosz Golaszewski,
>     I am grateful for your suggestion. The driver of bridge is a pci bus =
driver. It isn't written by us and is more complex. I have zero knowledge o=
f
>  the PCI sub-system, and perhaps it(pci bus driver) don't use gpio subsys=
tem with /sys/class/gpio/(sysfs interface) that I need. I just follow the o=
ther driver(gpio-amd8111.c)'s
> framework and maybe it can be used again. Thank you
>

The gpio-amd8111 driver does in fact do what you try to copy here but
it doesn't mean it's correct. It's quite possible that 8 years ago we
didn't know any better and merged it as it is. It doesn't justify
doing the same now with a new driver, especially since Bjorn explained
in detail why it's wrong. Rather, we should try to fix gpio-amd8111
instead.

Bartosz
